package com.heb.operations.cps.batchUpload;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import com.heb.jaf.security.UserInfo;
import com.heb.operations.cps.services.AddNewCandidateService;
import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.vo.BatchVO;
import com.heb.operations.cps.vo.ProductVO;

public class BatchExcelReader {
	private static final Logger LOG = Logger.getLogger(BatchExcelReader.class);

	private int sheetNumber;
	private int processRow;
	private int numberOfInvalidRows = 0;
	private int numberOfValidRows = 0;
	public static final String FAILURE = "fails";
	private List upcList = new ArrayList();
	public static final String CUSTOMER_ERROR = "Customer Friendly Description is mandatory if Product Type is 'Sellable'.";
	private AddNewCandidateService addNewCandidateService;

	public AddNewCandidateService getAddNewCandidateService() {
		return addNewCandidateService;
	}

	public void setAddNewCandidateService(AddNewCandidateService addNewCandidateService) {
		this.addNewCandidateService = addNewCandidateService;
	}

	/**
	 * To read the excel file data/validation/inserting the data into the
	 * database
	 * 
	 * @param fileData
	 */
	@SuppressWarnings("unchecked")
	public String excelReader(byte[] fileData, boolean insertFlag, String batchFileName, String userRole, UserInfo userInfo) {

		// declarations
		upcList = new ArrayList();
		StringBuffer returnStatus = new StringBuffer();
		StringBuffer batchMessage = new StringBuffer();
		returnStatus.append(CPSConstants.EMPTY_STRING);
		InputStream inputStream = null;
		String excelStatus = CPSConstants.EMPTY_STRING;
		POIFSFileSystem fileSystem = null;
		HSSFWorkbook workBook = null;
		HSSFSheet sheet = null;
		HSSFRow row = null;
		HSSFFont font = null;
		int counter;
		boolean readStatus = false;
		List<Integer> workID = new ArrayList<Integer>();

		try {
			// read in the file
			inputStream = new ByteArrayInputStream(fileData);
			fileSystem = new POIFSFileSystem(inputStream);
			workBook = new HSSFWorkbook(fileSystem);
			font = workBook.createFont();
			font.setFontName("Arial");
			sheetNumber = workBook.getNumberOfSheets();
			int cellNumber = 0;
			sheet = null;
			for (counter = 0; counter < sheetNumber; counter++) {
				sheet = workBook.getSheetAt(counter);
				Iterator rows = sheet.rowIterator();
				int rowNumber = -1;

				// for each row, read through the cells and put them into a vo
				if (rows.hasNext()) {
					while (rows.hasNext()) {
						row = (HSSFRow) rows.next();
						rowNumber++;
						// not really sure what's going on here.
						processRow = row.getRowNum();
						if (processRow == rowNumber) {
							Iterator cells = row.cellIterator();
							BatchVO batchVO = new BatchVO();
							while (cells.hasNext()) {
								HSSFCellString cellString = new HSSFCellString();
								HSSFCellNumeric cellNumeric = new HSSFCellNumeric();
								HSSFCellBlank cellBlank = new HSSFCellBlank();
								HSSFCellStyle cellStyle = workBook.createCellStyle();
								HSSFCell cell = (HSSFCell) cells.next();
								cellStyle.setFont(font);
								cell.setCellStyle(cellStyle);
								cellNumber = cell.getCellNum();
								switch (cell.getCellType()) {
								case HSSFCell.CELL_TYPE_NUMERIC: {
									cellNumeric.cellHSSFNumeric(cell, batchVO);
									break;
								}
								case HSSFCell.CELL_TYPE_STRING: {
									cellString.cellHSSFString(cell, batchVO);
									break;
								}
								default: {
									cellBlank.cellHSSFBlank(cell, batchVO);
									break;
								}
								}
								batchVO.setUserRole(userRole);
							}
							if (0 == processRow) {
								BatchHeaderValidation batchHeaderValidation = new BatchHeaderValidation();
								ExcelValidationBean excelValidationBean = batchHeaderValidation.validateBatchHeader(batchVO);
								excelStatus = excelValidationBean.getExcelStatus();
							} else {
								// validate the vo.
								BatchProductValidator batchProductValidator = new BatchProductValidator();
								if (batchProductValidator.validateRow(batchVO)) {
									if ((processRow + 1) < 2) {
										returnStatus.append("Row number: " + (processRow + 1) + " [Sheet " + (counter + 1) + "]  No Value for Saving.");
									}
									readStatus = true;
									break;
								} else {
									if (CPSConstants.VALID_HEADER.equalsIgnoreCase(excelStatus)) {
										if (!upcList.contains(batchVO.getUnitUPCCheckDigit())) {
											upcList.add(batchVO.getUnitUPCCheckDigit());

											// Mandatory Value Checking
											String validateString = batchProductValidator.mandatoryFieldCheck(batchVO);
											if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(validateString)) {
												numberOfInvalidRows++;
												returnStatus.append("Row number: " + (processRow + 1) + " [Sheet " + (counter + 1) + "]  Following Mandatory Fields value missing." + validateString);
											} else {
												// main function
												String validateRowFields = batchProductValidator.rowFieldValidator(batchVO);
												if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(validateRowFields)) {
													numberOfInvalidRows++;
													returnStatus.append("Row number: " + (processRow + 1) + " [Sheet " + (counter + 1) + "]  Error in the following fields." + validateRowFields);
													returnStatus.append("\n");
												} else {
													// mainfunction
													if (insertFlag) {

														// 1197 Fix
														batchVO.setVendorEmail(userInfo.getMail());
														String phone = userInfo.getAttributeValue("telephoneNumber");
														if (phone != null) {
															phone = CPSHelper.cleanPhoneNumber(phone);
															if (phone.length() >= 10) {
																batchVO.setVendorPhoneAreaCd(phone.substring(0, 3));
																batchVO.setVendorPhoneNumber(phone.substring(3, 10));
															} else {
																batchVO.setVendorPhoneAreaCd(phone.substring(0, 3));
																batchVO.setVendorPhoneNumber(phone.substring(3, phone.length()));
															}
														}
														batchVO.setCandUpdtUID(userInfo.getUid());
														/*
														 * String name=
														 * userInfo.
														 * getDisplayName();
														 * if(name != null){
														 * String[] names =
														 * name.split(",");
														 * if(names.length > 1)
														 * { batchVO.
														 * setCandUpdtFirstName(
														 * names[1]); batchVO.
														 * setCandUpdtLastName(
														 * names[0]); }else{
														 * batchVO.
														 * setCandUpdtLastName(
														 * name); } }
														 */
														batchVO.setCandUpdtFirstName(userInfo.getAttributeValue("givenName"));
														batchVO.setCandUpdtLastName(userInfo.getAttributeValue("sn"));

														ProductVO productVO = getAddNewCandidateService().insertBatchUpload(batchVO);
														String returnValue = productVO.getBatchErrorMessage();
														if (!returnValue.equalsIgnoreCase(CPSConstants.EMPTY_STRING)) {
															returnStatus.append("Problem in saving : Row number: " + (processRow + 1) + " [Sheet " + (counter + 1) + "]");
															if (!returnValue.equalsIgnoreCase(FAILURE)) {
																returnStatus.append("---").append(returnValue);
															}
															numberOfInvalidRows++;
															// break;
															returnStatus.append("\n");
														} else {
															numberOfValidRows++;
														}
														// Storing the work id
														// into List for
														// rollback
														if (!returnValue.equalsIgnoreCase(CUSTOMER_ERROR)) {
															/*
															 * if(CPSConstants.
															 * EMPTY_STRING
															 * .equalsIgnoreCase
															 * (returnValue.
															 * replace(
															 * CPSConstants.
															 * NEXT_LINE,
															 * CPSConstants.
															 * EMPTY_STRING).
															 * trim())){
															 */
															if (null != productVO.getWorkRequest()) {
																if (0 < productVO.getWorkRequest().getWorkIdentifier()) {
																	workID.add(productVO.getWorkRequest().getWorkIdentifier());
																}
															}
														}
													}
												}
											}
										} else {
											returnStatus.append("Row number: " + (processRow + 1) + " [Sheet " + (counter + 1) + "] Duplicate PD_UPC_NO ");
											numberOfInvalidRows++;
											returnStatus.append("\n");
										}
									} else {
										returnStatus.append("Header validation Fails");
										readStatus = true;
										break;
									}
								}
							}
						} else {
							readStatus = true;
							break;
						}
					}
				}
				if (readStatus) {
					break;
				}
			}
		} catch (IOException exception) {
			if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(returnStatus.toString())) {
				returnStatus.append("Error while reading excel:");
			}
			LOG.error(CPSConstants.ERROR_READ_EXCEL + exception.getMessage(), exception);
		} catch (Exception exception) {
			if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(returnStatus.toString())) {
				returnStatus.append("Error while reading excel:");
			} else {
				returnStatus.append("Error while reading excel:");
			}
			LOG.error(CPSConstants.ERROR_READ_EXCEL + exception.getMessage(), exception);
		} finally {
			row = null;
			sheet = null;
			workBook = null;
			fileSystem = null;
			batchMessage.append(CPSConstants.EMPTY_STRING);
			batchMessage.append("No of In-Valid Rows : ").append(String.valueOf(numberOfInvalidRows)).append("|");
			batchMessage.append("No of Valid Rows : ").append(String.valueOf(numberOfValidRows)).append("|");
			batchMessage.append(returnStatus.toString());
			// To roll back the data's
			if (insertFlag) {
				rollBackBatchFile(returnStatus.toString(), workID);
			}
			// Roll back Ends
		}
		return batchMessage.toString();
	}

	private void rollBackBatchFile(String returnStatus, List<Integer> workID) {
		if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(returnStatus.replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING).trim())) {
			try {
				getAddNewCandidateService().rollBackBatchFile(workID);
			} catch (Exception e) {
				LOG.error("Exception", e);
			}
		}

	}

	public int getSheetNumber() {
		return sheetNumber;
	}

	public void setSheetNumber(int sheetNumber) {
		this.sheetNumber = sheetNumber;
	}

	public int getProcessRow() {
		return processRow;
	}

	public void setProcessRow(int processRow) {
		this.processRow = processRow;
	}

	public int getNumberOfInvalidRows() {
		return numberOfInvalidRows;
	}

	public void setNumberOfInvalidRows(int numberOfInvalidRows) {
		this.numberOfInvalidRows = numberOfInvalidRows;
	}

	public int getNumberOfValidRows() {
		return numberOfValidRows;
	}

	public void setNumberOfValidRows(int numberOfValidRows) {
		this.numberOfValidRows = numberOfValidRows;
	}

	public List getUpcList() {
		return upcList;
	}

	public void setUpcList(List upcList) {
		this.upcList = upcList;
	}

}
