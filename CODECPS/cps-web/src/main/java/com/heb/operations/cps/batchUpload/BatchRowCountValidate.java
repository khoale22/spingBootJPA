package com.heb.operations.cps.batchUpload;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.vo.BatchVO;

public class BatchRowCountValidate {
	private static final Logger LOG = Logger.getLogger(BatchRowCountValidate.class);

	private int sheetNumber;
	private int processRow;
	private int numberOfRows = 0;
	public static final String FAILURE = "LessRowCount";
	public static final String SUCCESS = "Success";

	public String batchRowCount(byte[] fileData) throws Exception {
		String returnStatus = SUCCESS;
		POIFSFileSystem fileSystem = null;
		HSSFWorkbook workBook = null;
		HSSFSheet sheet = null;
		HSSFRow row = null;
		HSSFFont font = null;
		int counter;
		boolean readStatus = false;
		InputStream inputStream = null;
		try {
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
				if (rows.hasNext()) {
					while (rows.hasNext()) {
						row = (HSSFRow) rows.next();
						rowNumber++;
						processRow = row.getRowNum();
						if (processRow == rowNumber) {
							Iterator cells = row.cellIterator();
							BatchVO batchVO = new BatchVO();
							while (cells.hasNext()) {
								HSSFCellString cellString = new HSSFCellString();
								HSSFCellNumeric cellNumeric = new HSSFCellNumeric();
								HSSFCellBlank cellBlank = new HSSFCellBlank();
								HSSFCellStyle cellStyle = workBook
										.createCellStyle();
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
							}
							if (0 == processRow) {
								numberOfRows++;
							} else {
								BatchProductValidator batchProductValidator = new BatchProductValidator();
								// check whether all columns are empty in the
								// excel
								if (batchProductValidator.validateRow(batchVO)) {
									readStatus = true;
									break;
								} else {
									numberOfRows++;
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

			LOG.error(CPSConstants.ERROR_READ_EXCEL + exception.getMessage() , exception);
			returnStatus = CPSConstants.WRONG_XL_FORMAT;
		} catch (Exception exception) {

			LOG.error(CPSConstants.ERROR_READ_EXCEL + exception.getMessage(), exception);
			returnStatus =  CPSConstants.WRONG_XL_FORMAT;
		} finally {
			row = null;
			sheet = null;
			workBook = null;
			fileSystem = null;
			if (returnStatus.equalsIgnoreCase(SUCCESS)) {
				if (numberOfRows < 75) {
					returnStatus = FAILURE;
				}
			}
		}
		return returnStatus;
	}
}
