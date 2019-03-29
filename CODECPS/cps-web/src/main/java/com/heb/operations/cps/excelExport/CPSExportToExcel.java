package com.heb.operations.cps.excelExport;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.PrintSetup;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.Region;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.heb.jaf.security.HebLdapUserService;
import com.heb.jaf.security.UserInfo;
import com.heb.operations.cps.util.BusinessConstants;
import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.vo.CandidateEDISearchCriteria;
import com.heb.operations.cps.vo.CandidateSearchCriteria;
import com.heb.operations.cps.vo.PrintSumaryProductVO;
import com.heb.operations.cps.vo.PrintVO;
import com.heb.operations.cps.vo.ProductSearchCriteria;

public class CPSExportToExcel {

	private static final Log LOG = LogFactory.getLog(CPSExportToExcel.class);

	public void exportToExcel(List columnHeadings, List rowValues, String reportName, String title, HttpServletResponse resp, HttpServletRequest request) throws ServletException, IOException {
		exportToExcelSupport(columnHeadings, rowValues, reportName, title, request);
		this.showExcelFile(reportName, resp, request);
		this.deleteExcelFile(reportName, resp, request);
	}

	private void exportToExcelSupport(List columnHeadings, List rowValues, String reportName, String title, HttpServletRequest request) {
		String sessionId = request.getSession().getId();

		CPSExportPathBuilder exportPathBuilder = new CPSExportPathBuilder();
		String path = exportPathBuilder.excelPath(request);
		String excelReportHeaderString = reportName + sessionId + ".xls";
		FileOutputStream fileOut = null;

		boolean xmlMode = false;
		int size = rowValues.size();
		if (size > 35000) {
			xmlMode = true;
		}
		HSSFWorkbook wb = null;
		try {
			if (!xmlMode) {
				wb = getDataGridValuesInXLFormat(columnHeadings, rowValues, reportName, title);
			}
			if (xmlMode) {
				CPSExportHelper helper = new CPSExportHelper();
				String contents = helper.getXMLFormat(columnHeadings, rowValues, reportName, title, fileOut);
			} else {
				fileOut = new FileOutputStream(path + excelReportHeaderString);
				wb.write(fileOut);
			}
			if (fileOut != null) {
				fileOut.flush();
				fileOut.close();
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally {
			wb = null;
		}
	}

	public HSSFWorkbook getDataGridValuesInXLFormat(List columnHeadings, List rowValues, String reportName, String title) {
		HSSFWorkbook workbook = new HSSFWorkbook();
		List excelContents = rowValues;
		int numberOfSheets;

		int rowSize = excelContents.size();

		if (rowSize % 65000 == 0) {
			numberOfSheets = rowSize / 65000;
		} else {
			numberOfSheets = rowSize / 65000 + 1;
		}

		int startRowIndex = 0;
		int endRowIndex = 0;
		if (rowSize > 65000) {
			endRowIndex = 65000;
		} else {
			endRowIndex = rowSize;
		}
		for (int i = 0; i < numberOfSheets; i++) {

			HSSFSheet sheet = workbook.createSheet(reportName + i + 1);

			/* Creating the First Row with column headings */
			HSSFRow row = sheet.createRow((int) 0);

			// Create a new font and alter it//.
			HSSFFont headingFont = workbook.createFont();
			headingFont.setFontHeightInPoints((short) 10);
			headingFont.setFontName("Arial");
			headingFont.setBoldweight((short) 600);

			/* Style the Column Headers */
			HSSFCellStyle headingStyle = workbook.createCellStyle();
			headingStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			headingStyle.setBottomBorderColor(HSSFColor.BLACK.index);
			headingStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			headingStyle.setLeftBorderColor(HSSFColor.BLACK.index);
			headingStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
			headingStyle.setRightBorderColor(HSSFColor.BLACK.index);
			headingStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
			headingStyle.setTopBorderColor(HSSFColor.BLACK.index);
			headingStyle.setFillForegroundColor(HSSFColor.GREY_50_PERCENT.index);
			headingStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			headingStyle.setFont(headingFont);
			headingStyle.setAlignment((short) 2);
			// headingStyle.setWrapText(true);

			/* Style the Column Data */
			HSSFCellStyle bodyStyle = workbook.createCellStyle();
			HSSFFont bodyFont = workbook.createFont();
			bodyFont.setFontName("Verdana");
			bodyStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			bodyStyle.setBottomBorderColor(HSSFColor.BLACK.index);
			bodyStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			bodyStyle.setLeftBorderColor(HSSFColor.BLACK.index);
			bodyStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
			bodyStyle.setRightBorderColor(HSSFColor.BLACK.index);
			bodyStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
			bodyStyle.setTopBorderColor(HSSFColor.BLACK.index);
			bodyStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
			bodyStyle.setFillPattern(HSSFCellStyle.NO_FILL);
			bodyStyle.setAlignment((short) 1);

			HSSFCellStyle bodyParentStyle = workbook.createCellStyle();
			HSSFFont bodyParentFont = workbook.createFont();
			bodyParentFont.setFontName("Verdana");
			bodyParentStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			bodyParentStyle.setBottomBorderColor(HSSFColor.BLACK.index);
			bodyParentStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			bodyParentStyle.setLeftBorderColor(HSSFColor.BLACK.index);
			bodyParentStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
			bodyParentStyle.setRightBorderColor(HSSFColor.BLACK.index);
			bodyParentStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
			bodyParentStyle.setTopBorderColor(HSSFColor.BLACK.index);
			bodyParentStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
			bodyParentStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			// bodyParentStyle.setFillBackgroundColor(HSSFColor.AQUA.index);
			// bodyParentStyle.setFillPattern(HSSFCellStyle.BIG_SPOTS);
			// bodyParentStyle.setFillForegroundColor(HSSFColor.ORANGE.index);
			// bodyParentStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			bodyParentStyle.setAlignment((short) 1);

			HSSFCell cell = null;
			// New
			HSSFFont infoFont = workbook.createFont();
			infoFont.setFontName("Arial");
			infoFont.setColor(HSSFColor.BLUE.index);
			infoFont.setItalic(true);
			infoFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			HSSFCellStyle infoStyle = workbook.createCellStyle();
			infoStyle.setFont(infoFont);
			cell = row.createCell((int) (0));
			cell.setCellStyle(infoStyle);
			// New
			// row = sheet.createRow((short) 2); newly removed to the heading in
			// the first row
			int rowCount;
			if (null == title) {
				rowCount = 1;
			} else {
				HSSFFont titleFont = workbook.createFont();
				titleFont.setFontHeightInPoints((short) 15);
				titleFont.setFontName("Verdana");

				HSSFCellStyle titleStyle = workbook.createCellStyle();
				titleStyle.setFont(titleFont);
				sheet.addMergedRegion(new Region(2, (short) 0, 3, (short) 9));
				cell = row.createCell((int) 0);
				cell.setCellStyle(titleStyle);
				cell.setCellValue(new HSSFRichTextString(title));
				row = sheet.createRow((int) 4);
				rowCount = 5;
			}

			/* To set column headings */
			final int headerSize = columnHeadings.size();

			for (int columnIndex = 0; columnIndex < headerSize; columnIndex++) {
				ColumnHeader columnHeader = (ColumnHeader) columnHeadings.get(columnIndex);
				cell = row.createCell((int) (columnIndex));
				cell.setCellStyle(headingStyle);
				cell.setCellValue(new HSSFRichTextString(columnHeader.getDisplayName()));

				sheet.setColumnWidth((int) (columnIndex), (int) ((60 * 3) / ((double) 1 / 20)));
			}

			/* Populating the row values into the XL */
			int rowIndex;

			// changes - UNIQUE ROWS
			StringBuffer rowValue = new StringBuffer();
			// Set set = new HashSet();
			for (rowIndex = startRowIndex; rowIndex < endRowIndex; rowIndex++) {
				row = sheet.createRow((int) (rowCount++));

				for (int columnIndex = 0; columnIndex < headerSize; columnIndex++) {
					final ColumnHeader columnHeader = (ColumnHeader) columnHeadings.get(columnIndex);

					cell = row.createCell((int) (columnIndex));

					// Change -- start
					// PrintVO printVO =(PrintVO)excelContents.get(rowIndex);
					Object object = excelContents.get(rowIndex);
					if (object instanceof PrintVO) {
						PrintVO printVO = (PrintVO) object;
						if (printVO.isParentProductFlag()) {
							cell.setCellStyle(bodyStyle);
						} else {
							cell.setCellStyle(bodyParentStyle);
						}
					} else {
						cell.setCellStyle(bodyStyle);
					}
					HSSFRichTextString cellValue = new HSSFRichTextString(getCellValue(excelContents.get(rowIndex), columnHeader));
					cell.setCellValue(cellValue);

					rowValue.append(cellValue);
					/*
					 * if (columnIndex == headerSize - 1) { if
					 * (!set.add(rowValue.toString())) { rowCount--;
					 * sheet.removeRow(row); } rowValue.setLength(0); }
					 */
					// Change -- end

				}

			}
			startRowIndex = endRowIndex;
			if ((startRowIndex + 65000) >= rowSize) {
				endRowIndex = rowSize;
			} else {
				endRowIndex = startRowIndex + 65000;
			}

		}
		return workbook;
	}

	public String getCellValue(final Object row, ColumnHeader columnHeader) {
		String propertyName = columnHeader.getProperty();
		Object value = getValueOf(row, propertyName);
		return "".equals(value) ? "" : value.toString();
	}

	private Object getValueOf(final Object obj, final String propertyName) {
		final Object value = invoke(obj, getGetterMethod(propertyName));
		return (value == null ? "" : value);
	}

	private static String getGetterMethod(String propName) {
		if (propName == null) {
			return null;
		}
		return propName.trim();
	}

	private Object invoke(Object obj, String methodName) {

		Object object = null;
		try {
			object = PropertyUtils.getNestedProperty(obj, methodName);
		} catch (IllegalAccessException e) {
			LOG.error(e.getMessage(), e);
		} catch (InvocationTargetException e) {
			LOG.error(e.getMessage(), e);
		} catch (NoSuchMethodException e) {
			LOG.error(e.getMessage(), e);
		}
		return object;

	}

	/**
	 * Gets the column headings
	 * 
	 * @param headerAttributes
	 * @param actionEvent
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getColumnHeadings(LinkedHashMap headerAttributes) {

		List columnHeadings = new ArrayList();
		String columnName = "";
		ArrayList headers = new ArrayList();
		List attributes = new ArrayList();
		if (headerAttributes != null && !headerAttributes.isEmpty()) {
			Iterator headerIterator = headerAttributes.keySet().iterator();

			while (headerIterator.hasNext()) {
				headers.add(headerIterator.next());
			}

			Iterator attributeIterator = headerAttributes.values().iterator();

			while (attributeIterator.hasNext()) {
				attributes.add(attributeIterator.next());
			}
			List selectedList = headers;

			// setting the selected headers and its corresponding attribute

			for (int index1 = 0; index1 < selectedList.size(); index1++) {

				columnName = selectedList.get(index1).toString();
				int totalColumn = headers.size();
				for (int index2 = 0; index2 < totalColumn; index2++) {

					if (columnName.equals(headers.get(index2))) {
						columnHeadings.add(new ColumnHeader(headers.get(index2).toString(), attributes.get(index2).toString()));
					}
				}
			}
		}

		return columnHeadings;
	}

	private void showExcelFile(String reportName, HttpServletResponse response, HttpServletRequest request) throws ServletException, IOException {
		String sessionId = request.getSession().getId();
		CPSExportPathBuilder exportPathBuilder = new CPSExportPathBuilder();
		String path = exportPathBuilder.excelPath(request);
		String excelReportHeaderString = reportName + sessionId + ".xls";
		ServletOutputStream stream = null;
		BufferedInputStream buf = null;
		try {
			stream = response.getOutputStream();
			File doc = new File(path + excelReportHeaderString);
			response.setContentType("application/excel");
			response.addHeader("Content-Disposition", "attachment; filename=" + reportName + ".xls");
			response.setHeader("Cache-Control", "");
			response.setHeader("Pragma", "");
			response.setContentLength((int) doc.length());
			FileInputStream input = new FileInputStream(doc);
			buf = new BufferedInputStream(input);
			int readBytes = 0;
			while ((readBytes = buf.read()) != -1) {
				stream.write(readBytes);
			}
		} catch (IOException ioe) {
			LOG.error(ioe.getMessage(), ioe);
			throw new ServletException(ioe.getMessage(), ioe);
		} finally {
			if (stream != null) {
				stream.close();
			}
			if (buf != null) {
				buf.close();
			}
		}
	}

	private void deleteExcelFile(String reportName, HttpServletResponse resp, HttpServletRequest request) {
		final String sessionId = request.getSession().getId();
		CPSExportPathBuilder exportPathBuilder = new CPSExportPathBuilder();
		final String path = exportPathBuilder.excelPath(request);
		final String excelReportHeaderString = reportName + sessionId + ".xls";
		File folder = new File(path);
		File[] listOfFiles = folder.listFiles();
		for (int i = 0; i < listOfFiles.length; i++) {
			if (listOfFiles[i].isFile()) {
				if (listOfFiles[i].getName().equalsIgnoreCase(excelReportHeaderString)) {
					listOfFiles[i].delete();
				}
			}
		}

	}

	// print Summary Candidate
	public void exportToExcelCandidate(List<String> columnHeadings, List<PrintSumaryProductVO> rowValues, String reportName, final String title, CandidateSearchCriteria candidateSearchCriteria,
			HttpServletResponse resp, HttpServletRequest request, HebLdapUserService hebLdap) throws ServletException, IOException {
		exportToExcelSupportCandidate(columnHeadings, rowValues, reportName, title, candidateSearchCriteria, request, hebLdap);
		this.showExcelFile(reportName, resp, request);
		this.deleteExcelFile(reportName, resp, request);
	}

	// Print EDI
	public void exportToExcelCandidateEDI(List<String> columnHeadings, List<PrintSumaryProductVO> rowValues, String reportName, String title, CandidateEDISearchCriteria candidateEDISearchCriteria,
			HttpServletResponse resp, HttpServletRequest request, HebLdapUserService hebLdap) throws ServletException, IOException {
		exportToExcelSupportCandidateEDI(columnHeadings, rowValues, reportName, title, candidateEDISearchCriteria, request, hebLdap);
		this.showExcelFile(reportName, resp, request);
		this.deleteExcelFile(reportName, resp, request);
	}

	private void exportToExcelSupportCandidate(List<String> columnHeadings, List<PrintSumaryProductVO> rowValues, String reportName, String title, CandidateSearchCriteria candidateSearchCriteria,
			HttpServletRequest request, HebLdapUserService hebLdap) {
		final String sessionId = request.getSession().getId();
		CPSExportPathBuilder exportPathBuilder = new CPSExportPathBuilder();
		String path = exportPathBuilder.excelPath(request);
		final String excelReportHeader = reportName + sessionId + ".xls";
		FileOutputStream fileOut = null;
		Workbook wb = null;
		try {
			wb = getDataGridValuesInXLFormatCandidate(columnHeadings, rowValues, reportName, title, candidateSearchCriteria, hebLdap);

			fileOut = new FileOutputStream(path + excelReportHeader);
			wb.write(fileOut);
			fileOut.flush();
			fileOut.close();
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally {
			wb = null;
		}
	}

	private void exportToExcelSupportCandidateEDI(List<String> columnHeadings, List<PrintSumaryProductVO> rowValues, String reportName, String title,
			CandidateEDISearchCriteria candidateEDISearchCriteria, HttpServletRequest request, HebLdapUserService hebLdap) {
		final String sessionId = request.getSession().getId();
		CPSExportPathBuilder exportPathBuilder = new CPSExportPathBuilder();
		final String path = exportPathBuilder.excelPath(request);
		final String excelReportHeader = reportName + sessionId + ".xls";
		FileOutputStream fileOut = null;
		Workbook wb = null;
		try {
			wb = getDataGridValuesInXLFormatCandidateEDI(columnHeadings, rowValues, reportName, title, candidateEDISearchCriteria, hebLdap);

			fileOut = new FileOutputStream(path + excelReportHeader);
			wb.write(fileOut);
			fileOut.flush();
			fileOut.close();
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally {
			wb = null;
		}
	}

	public Workbook getDataGridValuesInXLFormatCandidate(List<String> columnHeadings, List<PrintSumaryProductVO> rowValues, String reportName, String title,
			CandidateSearchCriteria candidateSearchCriteria, HebLdapUserService hebLdap) {
		HSSFWorkbook wb = new HSSFWorkbook();
		Map<String, CellStyle> styles = createStylesPrinSummaryProduct(wb);
		int indexRow = 0;
		Sheet sheet = wb.createSheet(reportName);
		sheet.setFitToPage(true);
		sheet.setHorizontallyCenter(true);
		PrintSetup printSetup = sheet.getPrintSetup();
		printSetup.setLandscape(true);

		// the following three statements are required only for HSSF
		sheet.setAutobreaks(true);
		printSetup.setFitHeight((short) 1);
		printSetup.setFitWidth((short) 1);
		Row row = sheet.createRow(indexRow);
		row.setHeightInPoints(30);
		Cell titleCell = row.createCell(0);
		titleCell.setCellValue(CPSConstants.PRINSUMARY_PRODUCT_SET_UP_STATUS_SUMMARY);
		titleCell.setCellStyle(styles.get(CPSConstants.TITLE_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$J$1"));
		indexRow++;
		row = sheet.createRow(indexRow);
		Cell userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_VENDOR_SIGNATURE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$2:$N$2"));
		indexRow++;
		row = sheet.createRow(indexRow);
		userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_DATE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$3:$N$3"));
		indexRow++;
		row = sheet.createRow(indexRow);
		userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_BDM_SIGNATURE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$4:$N$4"));
		indexRow++;
		row = sheet.createRow(indexRow);
		userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_DATE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$5:$N$5"));
		indexRow++;
		row = sheet.createRow(indexRow);
		Cell filtersCell = row.createCell(0);
		filtersCell.setCellValue(CPSConstants.PRINSUMARY_FITLER);
		filtersCell.setCellStyle(styles.get(CPSConstants.FILTER_PRINSUMARY));
		List<ProductSearchCriteria> searchCriteriaList = searchCriteriaQueryList(candidateSearchCriteria);
		if (searchCriteriaList != null && !searchCriteriaList.isEmpty()) {
			for (ProductSearchCriteria productSearchCriteria : searchCriteriaList) {
				indexRow++;
				row = sheet.createRow(indexRow);
				filtersCell = row.createCell(0);
				filtersCell.setCellValue(productSearchCriteria.getCriteriaName() + " : " + String.valueOf(productSearchCriteria.getCriteriaValue()));
				filtersCell.setCellStyle(styles.get(CPSConstants.FILTER_PRINSUMARY));
			}
		}
		indexRow++;
		int indexRowMerge;
		row = sheet.createRow(indexRow);
		row.setHeightInPoints(30);
		userCell = row.createCell(0);
		userCell.setCellValue(CPSConstants.PRINSUMARY_VENDOR_FIELDS);
		userCell.setCellStyle(styles.get(CPSConstants.HEADER_VENDOR_PRINSUMARY));
		indexRowMerge = indexRow + 1;
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$" + indexRowMerge + ":$V$" + indexRowMerge));
		userCell = row.createCell(22);
		userCell.setCellValue(CPSConstants.PRINSUMARY_HEB_FIELDS);
		userCell.setCellStyle(styles.get(CPSConstants.HEADER_HEB_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$W$" + indexRowMerge + ":$AH$" + indexRowMerge));
		userCell = row.createCell(34);
		userCell.setCellValue(CPSConstants.PRINSUMARY_PRODUCT_AUDIT_DETAILS_FIELDS);
		userCell.setCellStyle(styles.get(CPSConstants.HEADER_PRODUCT_AUDIT_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$AI$" + indexRowMerge + ":$AN$" + indexRowMerge));
		indexRow++;
		row = sheet.createRow(indexRow);
		filtersCell = row.createCell(0);
		filtersCell.setCellValue("Selling UPC");
		indexRowMerge = indexRow + 1;
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$" + indexRowMerge + ":$L$" + indexRowMerge));
		filtersCell = row.createCell(12);
		filtersCell.setCellValue("Case Pack");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$M$" + indexRowMerge + ":$R$" + indexRowMerge));
		filtersCell = row.createCell(18);
		filtersCell.setCellValue("Vendor's Cost and Suggested Retail Pricing");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$S$" + indexRowMerge + ":$V$" + indexRowMerge));
		filtersCell = row.createCell(22);
		filtersCell.setCellValue("H-E-B's Approved Selling Price and Profitability");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$W$" + indexRowMerge + ":$AC$" + indexRowMerge));
		filtersCell = row.createCell(29);
		// filtersCell.setCellValue("HEB's Approved Selling Price and Profitability");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$AD$" + indexRowMerge + ":$AI$" + indexRowMerge));

		// sheet.addMergedRegion(new CellRangeAddress(10, 10, 0, 40));
		indexRow++;
		row = sheet.createRow(indexRow);
		indexRow++;
		Row empty = sheet.createRow(indexRow);
		row.setHeightInPoints(30);
		empty.setHeightInPoints(30);
		Cell vendorCell;
		int columnVendorIndex = 0;
		boolean setCodedate = false;
		for (String columnVendor : columnHeadings) {
			sheet.setColumnWidth(columnVendorIndex, 4000);
			if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_INBOUND_SPECIFICATION_DAYS) || (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_REACTION_DAYS))
					|| columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_GUARANTEE_TO_STORE_DAYS)) {
				vendorCell = empty.createCell(columnVendorIndex);
				vendorCell.setCellValue(columnVendor);
				vendorCell.setCellStyle(styles.get(CPSConstants.HEADER_GRID_PRINSUMARY));
				if (!setCodedate) {
					vendorCell = row.createCell(columnVendorIndex);
					vendorCell.setCellValue(CPSConstants.PRINSUMARY_COLUMN_CODE_DATE);
					vendorCell.setCellStyle(styles.get(CPSConstants.HEADER_GRID_PRINSUMARY));
					sheet.addMergedRegion(new CellRangeAddress(indexRow - 1, indexRow - 1, columnVendorIndex, columnVendorIndex + 2));
					setCodedate = true;
				}
			} else {
				vendorCell = row.createCell(columnVendorIndex);
				vendorCell.setCellValue(columnVendor);
				vendorCell.setCellStyle(styles.get(CPSConstants.HEADER_GRID_PRINSUMARY));
				sheet.addMergedRegion(new CellRangeAddress(indexRow - 1, indexRow, columnVendorIndex, columnVendorIndex));
			}
			if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RARING_TYPE_RATING)) {
				sheet.setColumnWidth(columnVendorIndex, 15000);
			}
			columnVendorIndex++;
		}
		if (rowValues != null && !rowValues.isEmpty()) {
			Row value;
			int indexValue = 0;
			int indexRowData = 0;
			String cellFormula = "";
			UserInfo userInfo = null;
			String userFullName = "";
			for (PrintSumaryProductVO printSumaryProductVO : rowValues) {
				indexValue++;
				columnVendorIndex = 0;
				indexRowData = indexRow + indexValue;
				value = sheet.createRow(indexRowData);
				indexRowData = indexRowData + 1;
				for (String columnVendor : columnHeadings) {
					vendorCell = value.createCell(columnVendorIndex);
					if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_VENDOR_NAME)) {
						vendorCell.setCellValue(printSumaryProductVO.getVendorName());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getSellingUnitUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_DESCRIPTION)) {
						vendorCell.setCellValue(printSumaryProductVO.getDescription());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_SIZE)) {
						vendorCell.setCellValue(printSumaryProductVO.getSellingUnitSize());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_UOM)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						vendorCell.setCellValue(printSumaryProductVO.getUom());
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						vendorCell.setCellValue(printSumaryProductVO.getSubCommodity());
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_STYLE)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						vendorCell.setCellValue(printSumaryProductVO.getStyle());
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_MODEL)) {
						vendorCell.setCellValue(printSumaryProductVO.getModel());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_COLOR)) {
						vendorCell.setCellValue(printSumaryProductVO.getColor());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_BRAND)) {
						vendorCell.setCellValue(printSumaryProductVO.getBrand());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PACKING)) {
						vendorCell.setCellValue(printSumaryProductVO.getPackaging());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RARING_TYPE_RATING)) {
						vendorCell.setCellValue(printSumaryProductVO.getRating());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_CASE_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getCaseUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_MASTER_PACK)) {
						if (CPSHelper.isNumeric(printSumaryProductVO.getMasterPack())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getMasterPack()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SHIP_PACK)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
						if (CPSHelper.isNumeric(printSumaryProductVO.getShipPack())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getShipPack()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_MAX_SHELF_LIFE_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getMaxShelfLifeDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_COST_LINK_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getCostLinkUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_COUNTRY_OF_ORIGIN)) {
						vendorCell.setCellValue(printSumaryProductVO.getCountryOfOrigin());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_LIST_COST)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getListCost()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_UNIT_COST)) {
						// if
						// (CPSHelper.isNotEmpty(printSumaryProductVO.getChannel())
						// &&
						// printSumaryProductVO.getChannel().equals(BusinessConstants.CHANEL_WHS))
						// {
						// if
						// (CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())
						// &&
						// CPSHelper.isNumeric(printSumaryProductVO.getShipPack())
						// &&
						// Double.parseDouble(printSumaryProductVO.getShipPack().trim())
						// != 0) {
						// //cellFormula = "S" + indexRowData + "/O" +
						// indexRowData;
						// vendorCell.setCellFormula(printSumaryProductVO.getUnitCost());
						// }
						// } else {
						// if
						// (CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())
						// &&
						// CPSHelper.isNumeric(printSumaryProductVO.getMasterPack())
						// &&
						// Double.parseDouble(printSumaryProductVO.getMasterPack().trim())
						// != 0) {
						// //cellFormula = "S" + indexRowData + "/N" +
						// indexRowData;
						// vendorCell.setCellFormula(printSumaryProductVO.getUnitCost());
						// }
						// }
						vendorCell.setCellValue(printSumaryProductVO.getUnitCost());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUGGESTED_UNIT_RETAIL)) {
						if (CPSHelper.isNumeric(printSumaryProductVO.getSuggestedUnitRetail())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getSuggestedUnitRetail()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PREPRICE_UNIT_RETAIL)) {
						if (CPSHelper.isNumeric(printSumaryProductVO.getPrepriceUnitRetail())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getPrepriceUnitRetail()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RETAIL)) {
						if (CPSHelper.isNumeric(printSumaryProductVO.getRetail())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getRetail()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PENNY_PROFIT)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getRetail()) && CPSHelper.getBigdecimalValue(printSumaryProductVO.getRetail()) != null
								&& printSumaryProductVO.getRetailFor() != null && CPSHelper.getBigdecimalValue(printSumaryProductVO.getRetail()).compareTo(BigDecimal.ONE) == -1
								&& printSumaryProductVO.getRetailFor().compareTo(BigDecimal.ZERO) == 0) {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						} else {
							if (CPSHelper.isNotEmpty(printSumaryProductVO.getUnitCost()) && CPSHelper.isNotEmpty(printSumaryProductVO.getRetail())
									&& CPSHelper.isNotEmpty(printSumaryProductVO.getPennyprofit())) {
								// cellFormula = "ROUNDDOWN(W" + indexRowData +
								// " - T" + indexRowData+",2)";
								vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getPennyprofit()));
								// vendorCell.setCellFormula(cellFormula);
							} else {
								vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
							}
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PERCENT_MARGIN)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getUnitCost()) && CPSHelper.isNumeric(printSumaryProductVO.getRetail())
								&& Double.parseDouble(printSumaryProductVO.getRetail()) != 0 && CPSHelper.isNotEmpty(printSumaryProductVO.getMarginPercent())) {
							// cellFormula = "ROUNDDOWN(W" + indexRowData +
							// " - T" + indexRowData + ")/W" +
							// indexRowData+",2)";
							// LOG.info("% Margin:"+printSumaryProductVO.getMarginPercent());
							// vendorCell.setCellFormula(cellFormula);
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getMarginPercent()) / 100);
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_PECENTAGE_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RETAIL_LINK_UPC_CANDIDATE)) {
						vendorCell.setCellValue(printSumaryProductVO.getRetailLinkUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY)) {
						vendorCell.setCellValue(printSumaryProductVO.getSeasonality());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY_YEAR)) {
						vendorCell.setCellValue(printSumaryProductVO.getSeasonalityYear());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_INBOUND_SPECIFICATION_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getInboundSpecificationDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_REACTION_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getReactionDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_GUARANTEE_TO_STORE_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getGuaranteeToStoreDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY)) {
						vendorCell.setCellValue(printSumaryProductVO.getSubCommodity());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_BDM)) {
						vendorCell.setCellValue(printSumaryProductVO.getBdm());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUB_DEPT_NAME)) {
						vendorCell.setCellValue(printSumaryProductVO.getDeptName());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PSS_DEPT)) {
						vendorCell.setCellValue(printSumaryProductVO.getPssDept());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SOURCE_METHOD)) {
						vendorCell.setCellValue(printSumaryProductVO.getResource());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_STATUS)) {
						vendorCell.setCellValue(printSumaryProductVO.getStatus());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_TESTSCAN)) {
						vendorCell.setCellValue(printSumaryProductVO.getTestScan());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_ID_OF_USER)) {
						// ----------comment code error when change security
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getUserId())) {
							try {
								userInfo = (UserInfo) hebLdap.getUserInfo(CPSHelper.getTrimmedValue(printSumaryProductVO.getUserId()));
							} catch (UsernameNotFoundException e) {
								LOG.error(e.getMessage(), e);
							} catch (DataAccessException e) {
								LOG.error(e.getMessage(), e);
							}
							if (userInfo == null) {
								vendorCell.setCellValue(printSumaryProductVO.getUserId());
							} else {
								userFullName = userInfo.getAttributeValue("givenName") + " " + userInfo.getAttributeValue("sn") + " [" + userInfo.getUid() + "]";
								vendorCell.setCellValue(userFullName);
							}
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					}
					columnVendorIndex++;
				}

			}
			sheet.autoSizeColumn(0);
			sheet.autoSizeColumn(1);
			sheet.autoSizeColumn(2);
			sheet.autoSizeColumn(5);
			// sheet.autoSizeColumn(6);
			// sheet.autoSizeColumn(7);
			// sheet.autoSizeColumn(8);
			sheet.autoSizeColumn(9);
			sheet.autoSizeColumn(10);
			// sheet.autoSizeColumn(11);
			sheet.autoSizeColumn(12);
			sheet.autoSizeColumn(13);
			sheet.autoSizeColumn(18);
			sheet.autoSizeColumn(28);
			sheet.autoSizeColumn(33);
			sheet.autoSizeColumn(34);
			sheet.autoSizeColumn(35);
			sheet.autoSizeColumn(38);
			sheet.autoSizeColumn(39);
			sheet.autoSizeColumn(40);
		}

		return wb;
	}

	public Workbook getDataGridValuesInXLFormatCandidateEDI(List<String> columnHeadings, List<PrintSumaryProductVO> rowValues, String reportName, String title,
			CandidateEDISearchCriteria candidateSearchCriteria, HebLdapUserService hebLdap) {
		HSSFWorkbook wb = new HSSFWorkbook();
		Map<String, CellStyle> styles = createStylesPrinSummaryProduct(wb);
		int indexRow = 0;
		Sheet sheet = wb.createSheet(reportName);
		sheet.setFitToPage(true);
		sheet.setHorizontallyCenter(true);
		PrintSetup printSetup = sheet.getPrintSetup();
		printSetup.setLandscape(true);

		// the following three statements are required only for HSSF
		sheet.setAutobreaks(true);
		printSetup.setFitHeight((short) 1);
		printSetup.setFitWidth((short) 1);
		Row row = sheet.createRow(indexRow);
		row.setHeightInPoints(30);
		Cell titleCell = row.createCell(0);
		titleCell.setCellValue(CPSConstants.PRINSUMARY_PRODUCT_SET_UP_STATUS_SUMMARY);
		titleCell.setCellStyle(styles.get(CPSConstants.TITLE_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$J$1"));
		indexRow++;
		row = sheet.createRow(indexRow);
		Cell userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_VENDOR_SIGNATURE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$2:$N$2"));
		indexRow++;
		row = sheet.createRow(indexRow);
		userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_DATE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$3:$N$3"));
		indexRow++;
		row = sheet.createRow(indexRow);
		userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_BDM_SIGNATURE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$4:$N$4"));
		indexRow++;
		row = sheet.createRow(indexRow);
		userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_DATE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$5:$N$5"));
		indexRow++;
		row = sheet.createRow(indexRow);
		Cell filtersCell = row.createCell(0);
		filtersCell.setCellValue(CPSConstants.PRINSUMARY_FITLER);
		filtersCell.setCellStyle(styles.get(CPSConstants.FILTER_PRINSUMARY));
		final List<ProductSearchCriteria> searchCriteriaList = searchCriteriaQueryListEDI(candidateSearchCriteria);
		if (searchCriteriaList != null && !searchCriteriaList.isEmpty()) {
			for (final ProductSearchCriteria productSearchCriteria : searchCriteriaList) {
				indexRow++;
				row = sheet.createRow(indexRow);
				filtersCell = row.createCell(0);
				filtersCell.setCellValue(productSearchCriteria.getCriteriaName() + " : " + String.valueOf(productSearchCriteria.getCriteriaValue()));
				filtersCell.setCellStyle(styles.get(CPSConstants.FILTER_PRINSUMARY));
			}
		}
		indexRow++;
		int indexRowMerge;
		row = sheet.createRow(indexRow);
		row.setHeightInPoints(30);
		userCell = row.createCell(0);
		userCell.setCellValue(CPSConstants.PRINSUMARY_VENDOR_FIELDS);
		userCell.setCellStyle(styles.get(CPSConstants.HEADER_VENDOR_PRINSUMARY));
		indexRowMerge = indexRow + 1;
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$" + indexRowMerge + ":$V$" + indexRowMerge));
		userCell = row.createCell(22);
		userCell.setCellValue(CPSConstants.PRINSUMARY_HEB_FIELDS);
		userCell.setCellStyle(styles.get(CPSConstants.HEADER_HEB_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$W$" + indexRowMerge + ":$AH$" + indexRowMerge));
		userCell = row.createCell(34);
		userCell.setCellValue(CPSConstants.PRINSUMARY_PRODUCT_AUDIT_DETAILS_FIELDS);
		userCell.setCellStyle(styles.get(CPSConstants.HEADER_PRODUCT_AUDIT_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$AI$" + indexRowMerge + ":$AN$" + indexRowMerge));
		indexRow++;
		row = sheet.createRow(indexRow);
		filtersCell = row.createCell(0);
		filtersCell.setCellValue("Selling UPC");
		indexRowMerge = indexRow + 1;
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$" + indexRowMerge + ":$L$" + indexRowMerge));
		filtersCell = row.createCell(12);
		filtersCell.setCellValue("Case Pack");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$M$" + indexRowMerge + ":$R$" + indexRowMerge));
		filtersCell = row.createCell(18);
		filtersCell.setCellValue("Vendor's Cost and Suggested Retail Pricing");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$S$" + indexRowMerge + ":$V$" + indexRowMerge));
		filtersCell = row.createCell(22);
		filtersCell.setCellValue("H-E-B's Approved Selling Price and Profitability");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$W$" + indexRowMerge + ":$AC$" + indexRowMerge));
		filtersCell = row.createCell(29);
		// filtersCell.setCellValue("HEB's Approved Selling Price and Profitability");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$AD$" + indexRowMerge + ":$AH$" + indexRowMerge));

		// sheet.addMergedRegion(new CellRangeAddress(10, 10, 0, 40));
		indexRow++;
		row = sheet.createRow(indexRow);
		indexRow++;
		Row empty = sheet.createRow(indexRow);
		row.setHeightInPoints(30);
		empty.setHeightInPoints(30);
		Cell vendorCell;
		int columnVendorIndex = 0;
		boolean setCodedate = false;
		for (String columnVendor : columnHeadings) {

			sheet.setColumnWidth(columnVendorIndex, 4000);
			if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_INBOUND_SPECIFICATION_DAYS) || (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_REACTION_DAYS))
					|| columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_GUARANTEE_TO_STORE_DAYS)) {
				vendorCell = empty.createCell(columnVendorIndex);
				vendorCell.setCellValue(columnVendor);
				vendorCell.setCellStyle(styles.get(CPSConstants.HEADER_GRID_PRINSUMARY));
				if (!setCodedate) {
					vendorCell = row.createCell(columnVendorIndex);
					vendorCell.setCellValue(CPSConstants.PRINSUMARY_COLUMN_CODE_DATE);
					vendorCell.setCellStyle(styles.get(CPSConstants.HEADER_GRID_PRINSUMARY));
					sheet.addMergedRegion(new CellRangeAddress(indexRow - 1, indexRow - 1, columnVendorIndex, columnVendorIndex + 2));
					setCodedate = true;
				}
			} else {
				vendorCell = row.createCell(columnVendorIndex);
				vendorCell.setCellValue(columnVendor);
				vendorCell.setCellStyle(styles.get(CPSConstants.HEADER_GRID_PRINSUMARY));
				sheet.addMergedRegion(new CellRangeAddress(indexRow - 1, indexRow, columnVendorIndex, columnVendorIndex));
			}
			if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RARING_TYPE_RATING)) {
				sheet.setColumnWidth(columnVendorIndex, 15000);
			}
			columnVendorIndex++;
		}
		if (rowValues != null && !rowValues.isEmpty()) {
			Row value;
			int indexValue = 0;
			String cellFormula = "";
			int indexRowData = 0;
			UserInfo userInfo = null;
			String userFullName = "";
			for (final PrintSumaryProductVO printSumaryProductVO : rowValues) {
				indexValue++;
				columnVendorIndex = 0;
				indexRowData = indexRow + indexValue;
				value = sheet.createRow(indexRowData);
				indexRowData++;
				for (String columnVendor : columnHeadings) {
					vendorCell = value.createCell(columnVendorIndex);
					if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_VENDOR_NAME)) {
						vendorCell.setCellValue(printSumaryProductVO.getVendorName());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getSellingUnitUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_DESCRIPTION)) {
						vendorCell.setCellValue(printSumaryProductVO.getDescription());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_SIZE)) {
						vendorCell.setCellValue(printSumaryProductVO.getSellingUnitSize());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_UOM)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						vendorCell.setCellValue(printSumaryProductVO.getUom());
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						vendorCell.setCellValue(printSumaryProductVO.getSubCommodity());
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_STYLE)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						vendorCell.setCellValue(printSumaryProductVO.getStyle());
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_MODEL)) {
						vendorCell.setCellValue(printSumaryProductVO.getModel());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_COLOR)) {
						vendorCell.setCellValue(printSumaryProductVO.getColor());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_BRAND)) {
						vendorCell.setCellValue(printSumaryProductVO.getBrand());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PACKING)) {
						vendorCell.setCellValue(printSumaryProductVO.getPackaging());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RARING_TYPE_RATING)) {
						vendorCell.setCellValue(printSumaryProductVO.getRating());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_CASE_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getCaseUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_MASTER_PACK)) {
						if (CPSHelper.isNumeric(printSumaryProductVO.getMasterPack())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getMasterPack()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SHIP_PACK)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
						if (CPSHelper.isNumeric(printSumaryProductVO.getShipPack())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getShipPack()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_MAX_SHELF_LIFE_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getMaxShelfLifeDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_COST_LINK_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getCostLinkUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_COUNTRY_OF_ORIGIN)) {
						vendorCell.setCellValue(printSumaryProductVO.getCountryOfOrigin());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_LIST_COST)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getListCost()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_UNIT_COST)) {
						// if
						// (CPSHelper.isNotEmpty(printSumaryProductVO.getChannel())
						// &&
						// printSumaryProductVO.getChannel().equals(BusinessConstants.CHANEL_WHS))
						// {
						// if
						// (CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())
						// &&
						// CPSHelper.isNumeric(printSumaryProductVO.getShipPack())
						// &&
						// Double.parseDouble(printSumaryProductVO.getShipPack())
						// != 0) {
						// //cellFormula = "S" + indexRowData + "/O" +
						// indexRowData;
						// vendorCell.setCellFormula(printSumaryProductVO.getUnitCost());
						// }
						// } else {
						// if
						// (CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())
						// &&
						// CPSHelper.isNumeric(printSumaryProductVO.getMasterPack())
						// &&
						// Double.parseDouble(printSumaryProductVO.getMasterPack())
						// != 0) {
						// //cellFormula = "S" + indexRowData + "/N" +
						// indexRowData;
						// vendorCell.setCellFormula(printSumaryProductVO.getUnitCost());
						// }
						// }
						vendorCell.setCellValue(printSumaryProductVO.getUnitCost());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUGGESTED_UNIT_RETAIL)) {
						if (CPSHelper.isNumeric(printSumaryProductVO.getSuggestedUnitRetail())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getSuggestedUnitRetail()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PREPRICE_UNIT_RETAIL)) {
						if (CPSHelper.isNumeric(printSumaryProductVO.getPrepriceUnitRetail())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getPrepriceUnitRetail()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RETAIL)) {
						if (CPSHelper.isNumeric(printSumaryProductVO.getRetail())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getRetail()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PENNY_PROFIT)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getRetail()) && CPSHelper.getBigdecimalValue(printSumaryProductVO.getRetail()) != null
								&& printSumaryProductVO.getRetailFor() != null && CPSHelper.getBigdecimalValue(printSumaryProductVO.getRetail()).compareTo(BigDecimal.ONE) == -1
								&& printSumaryProductVO.getRetailFor().compareTo(BigDecimal.ZERO) == 0) {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						} else {
							if (CPSHelper.isNotEmpty(printSumaryProductVO.getUnitCost()) && CPSHelper.isNotEmpty(printSumaryProductVO.getRetail())
									&& CPSHelper.isNotEmpty(printSumaryProductVO.getPennyprofit())) {
								// cellFormula = "ROUNDDOWN(W" + indexRowData +
								// " - T" + indexRowData+",2)";
								vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getPennyprofit()));
								// vendorCell.setCellFormula(cellFormula);
							} else {
								vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
							}
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PERCENT_MARGIN)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getUnitCost()) && CPSHelper.isNumeric(printSumaryProductVO.getRetail())
								&& Double.parseDouble(printSumaryProductVO.getRetail()) != 0 && CPSHelper.isNotEmpty(printSumaryProductVO.getMarginPercent())) {
							// cellFormula = "ROUNDDOWN(W" + indexRowData +
							// " - T" + indexRowData + ")/W" +
							// indexRowData+",2)";
							// LOG.info("% Margin:"+printSumaryProductVO.getMarginPercent());
							// vendorCell.setCellFormula(cellFormula);
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getMarginPercent()) / 100);
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_PECENTAGE_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY)) {
						vendorCell.setCellValue(printSumaryProductVO.getSeasonality());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY_YEAR)) {
						vendorCell.setCellValue(printSumaryProductVO.getSeasonalityYear());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_INBOUND_SPECIFICATION_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getInboundSpecificationDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_REACTION_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getReactionDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_GUARANTEE_TO_STORE_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getGuaranteeToStoreDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY)) {
						vendorCell.setCellValue(printSumaryProductVO.getSubCommodity());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_BDM)) {
						vendorCell.setCellValue(printSumaryProductVO.getBdm());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUB_DEPT_NAME)) {
						vendorCell.setCellValue(printSumaryProductVO.getDeptName());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PSS_DEPT)) {
						vendorCell.setCellValue(printSumaryProductVO.getPssDept());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SOURCE_METHOD)) {
						vendorCell.setCellValue(printSumaryProductVO.getResource());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_STATUS)) {
						vendorCell.setCellValue(printSumaryProductVO.getStatus());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_TESTSCAN)) {
						vendorCell.setCellValue(printSumaryProductVO.getTestScan());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_ID_OF_USER)) {
						// ----------comment code error when change security
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getUserId())) {
							try {
								userInfo = (UserInfo) hebLdap.getUserInfo(CPSHelper.getTrimmedValue(printSumaryProductVO.getUserId()));
							} catch (UsernameNotFoundException e) {
								LOG.error(e.getMessage(), e);
							} catch (DataAccessException e) {
								LOG.error(e.getMessage(), e);
							}
							if (userInfo == null) {
								vendorCell.setCellValue(printSumaryProductVO.getUserId());
							} else {
								userFullName = userInfo.getAttributeValue("givenName") + " " + userInfo.getAttributeValue("sn") + " [" + userInfo.getUid() + "]";
								vendorCell.setCellValue(userFullName);
							}
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_BDM)) {
						vendorCell.setCellValue(printSumaryProductVO.getBdm());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					}
					columnVendorIndex++;
				}
			}
			sheet.autoSizeColumn(0);
			sheet.autoSizeColumn(1);
			sheet.autoSizeColumn(2);
			sheet.autoSizeColumn(5);
			// sheet.autoSizeColumn(6);
			// sheet.autoSizeColumn(7);
			// sheet.autoSizeColumn(8);
			sheet.autoSizeColumn(9);
			sheet.autoSizeColumn(10);
			// sheet.autoSizeColumn(11);
			sheet.autoSizeColumn(12);
			sheet.autoSizeColumn(13);
			sheet.autoSizeColumn(18);
			sheet.autoSizeColumn(28);
			sheet.autoSizeColumn(33);
			sheet.autoSizeColumn(34);
			sheet.autoSizeColumn(35);
			sheet.autoSizeColumn(38);
			sheet.autoSizeColumn(39);
			sheet.autoSizeColumn(40);
		}

		return wb;
	}

	// print Summary Product
	public void exportToExcelProduct(List<String> columnHeadings, List<PrintSumaryProductVO> rowValues, String reportName, String title, CandidateSearchCriteria candidateSearchCriteria,
			HttpServletResponse resp, HttpServletRequest request, HebLdapUserService hebLdap) throws ServletException, IOException {
		exportToExcelSupportProduct(columnHeadings, rowValues, reportName, title, candidateSearchCriteria, request, hebLdap);
		this.showExcelFile(reportName, resp, request);
		this.deleteExcelFile(reportName, resp, request);
	}

	// print Summary Product
	public void exportToExcelProductEDI(List<String> columnHeadings, List<PrintSumaryProductVO> rowValues, String reportName, final String title,
			CandidateEDISearchCriteria candidateEDISearchCriteria, HttpServletResponse resp, HttpServletRequest request, HebLdapUserService hebLdap) throws ServletException, IOException {
		exportToExcelSupportProductEDI(columnHeadings, rowValues, reportName, title, candidateEDISearchCriteria, request, hebLdap);
		this.showExcelFile(reportName, resp, request);
		this.deleteExcelFile(reportName, resp, request);
	}

	private void exportToExcelSupportProduct(List<String> columnHeadings, List<PrintSumaryProductVO> rowValues, String reportName, String title, CandidateSearchCriteria candidateSearchCriteria,
			HttpServletRequest request, HebLdapUserService hebLdap) {
		String sessionId = request.getSession().getId();
		CPSExportPathBuilder exportPathBuilder = new CPSExportPathBuilder();
		String path = exportPathBuilder.excelPath(request);
		String excelReportHeaderString = reportName + sessionId + ".xls";
		FileOutputStream fileOut = null;
		// boolean xmlMode = false;
		// int size = rowValues.size();
		// if (size > 35000) {
		// xmlMode = true;
		// }
		Workbook wb = null;
		try {
			// if (!xmlMode) {
			wb = getDataGridValuesInXLFormatProduct(columnHeadings, rowValues, reportName, title, candidateSearchCriteria, hebLdap);
			// }
			// if (xmlMode) {
			// CPSExportHelper helper = new CPSExportHelper();
			// String contents = helper.getXMLFormat(columnHeadings,
			// rowValues, reportName, title, fileOut);
			// } else {
			fileOut = new FileOutputStream(path + excelReportHeaderString);
			wb.write(fileOut);
			// }
			fileOut.flush();
			fileOut.close();
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally {
			wb = null;
		}
	}

	private void exportToExcelSupportProductEDI(List<String> columnHeadings, List<PrintSumaryProductVO> rowValues, String reportName, String title,
			CandidateEDISearchCriteria candidateEDISearchCriteria, HttpServletRequest request, HebLdapUserService hebLdap) {
		String sessionId = request.getSession().getId();
		CPSExportPathBuilder exportPathBuilder = new CPSExportPathBuilder();
		String path = exportPathBuilder.excelPath(request);
		String excelReportHeaderString = reportName + sessionId + ".xls";
		FileOutputStream fileOut = null;
		Workbook wb = null;
		try {
			wb = getDataGridValuesInXLFormatProductEDI(columnHeadings, rowValues, reportName, title, candidateEDISearchCriteria, hebLdap);
			fileOut = new FileOutputStream(path + excelReportHeaderString);
			wb.write(fileOut);
			fileOut.flush();
			fileOut.close();
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		} finally {
			wb = null;
		}
	}

	public Workbook getDataGridValuesInXLFormatProduct(List<String> columnHeadings, List<PrintSumaryProductVO> rowValues, String reportName, String title,
			CandidateSearchCriteria candidateSearchCriteria, HebLdapUserService hebLdap) {
		HSSFWorkbook wb = new HSSFWorkbook();
		Map<String, CellStyle> styles = createStylesPrinSummaryProduct(wb);
		int indexRow = 0;
		Sheet sheet = wb.createSheet(reportName);
		sheet.setFitToPage(true);
		sheet.setHorizontallyCenter(true);
		PrintSetup printSetup = sheet.getPrintSetup();
		printSetup.setLandscape(true);

		// the following three statements are required only for HSSF
		sheet.setAutobreaks(true);
		printSetup.setFitHeight((short) 1);
		printSetup.setFitWidth((short) 1);
		Row row = sheet.createRow(indexRow);
		row.setHeightInPoints(30);
		Cell titleCell = row.createCell(0);
		titleCell.setCellValue(CPSConstants.PRINSUMARY_PRODUCT_SET_UP_STATUS_SUMMARY);
		titleCell.setCellStyle(styles.get(CPSConstants.TITLE_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$J$1"));
		indexRow++;
		row = sheet.createRow(indexRow);
		Cell userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_VENDOR_SIGNATURE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$2:$N$2"));
		indexRow++;
		row = sheet.createRow(indexRow);
		userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_DATE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$3:$N$3"));
		indexRow++;
		row = sheet.createRow(indexRow);
		userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_BDM_SIGNATURE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$4:$N$4"));
		indexRow++;
		row = sheet.createRow(indexRow);
		userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_DATE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$5:$N$5"));
		indexRow++;
		row = sheet.createRow(indexRow);
		Cell filtersCell = row.createCell(0);
		filtersCell.setCellValue(CPSConstants.PRINSUMARY_FITLER);
		filtersCell.setCellStyle(styles.get(CPSConstants.FILTER_PRINSUMARY));
		List<ProductSearchCriteria> searchCriteriaList = searchCriteriaQueryList(candidateSearchCriteria);
		if (searchCriteriaList != null && !searchCriteriaList.isEmpty()) {
			for (ProductSearchCriteria productSearchCriteria : searchCriteriaList) {
				indexRow++;
				row = sheet.createRow(indexRow);
				filtersCell = row.createCell(0);
				filtersCell.setCellValue(productSearchCriteria.getCriteriaName() + " : " + productSearchCriteria.getCriteriaValue());
				filtersCell.setCellStyle(styles.get(CPSConstants.FILTER_PRINSUMARY));
			}
		}
		indexRow++;
		int indexRowMerge;
		row = sheet.createRow(indexRow);
		row.setHeightInPoints(30);
		userCell = row.createCell(0);
		userCell.setCellValue(CPSConstants.PRINSUMARY_VENDOR_FIELDS);
		userCell.setCellStyle(styles.get(CPSConstants.HEADER_VENDOR_PRINSUMARY));
		indexRowMerge = indexRow + 1;
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$" + indexRowMerge + ":$V$" + indexRowMerge));
		userCell = row.createCell(22);
		userCell.setCellValue(CPSConstants.PRINSUMARY_HEB_FIELDS);
		userCell.setCellStyle(styles.get(CPSConstants.HEADER_HEB_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$W$" + indexRowMerge + ":$AH$" + indexRowMerge));
		userCell = row.createCell(34);
		userCell.setCellValue(CPSConstants.PRINSUMARY_PRODUCT_AUDIT_DETAILS_FIELDS);
		userCell.setCellStyle(styles.get(CPSConstants.HEADER_PRODUCT_AUDIT_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$AI$" + indexRowMerge + ":$AN$" + indexRowMerge));
		indexRow++;
		row = sheet.createRow(indexRow);
		filtersCell = row.createCell(0);
		filtersCell.setCellValue("Selling UPC");
		indexRowMerge = indexRow + 1;
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$" + indexRowMerge + ":$L$" + indexRowMerge));
		filtersCell = row.createCell(12);
		filtersCell.setCellValue("Case Pack");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$M$" + indexRowMerge + ":$R$" + indexRowMerge));
		filtersCell = row.createCell(18);
		filtersCell.setCellValue("Vendor's Cost and Suggested Retail Pricing");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$S$" + indexRowMerge + ":$V$" + indexRowMerge));
		filtersCell = row.createCell(22);
		filtersCell.setCellValue("H-E-B's Approved Selling Price and Profitability");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$W$" + indexRowMerge + ":$AC$" + indexRowMerge));
		filtersCell = row.createCell(29);
		// filtersCell.setCellValue("HEB's Approved Selling Price and Profitability");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$AD$" + indexRowMerge + ":$AH$" + indexRowMerge));

		// sheet.addMergedRegion(new CellRangeAddress(10, 10, 0, 40));
		indexRow++;
		row = sheet.createRow(indexRow);
		indexRow++;
		Row empty = sheet.createRow(indexRow);
		row.setHeightInPoints(30);
		empty.setHeightInPoints(30);
		Cell vendorCell;
		int columnVendorIndex = 0;
		boolean setCodedate = false;
		for (String columnVendor : columnHeadings) {

			sheet.setColumnWidth(columnVendorIndex, 4000);
			if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_INBOUND_SPECIFICATION_DAYS) || (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_REACTION_DAYS))
					|| columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_GUARANTEE_TO_STORE_DAYS)) {
				vendorCell = empty.createCell(columnVendorIndex);
				vendorCell.setCellValue(columnVendor);
				vendorCell.setCellStyle(styles.get(CPSConstants.HEADER_GRID_PRINSUMARY));
				if (!setCodedate) {
					vendorCell = row.createCell(columnVendorIndex);
					vendorCell.setCellValue(CPSConstants.PRINSUMARY_COLUMN_CODE_DATE);
					vendorCell.setCellStyle(styles.get(CPSConstants.HEADER_GRID_PRINSUMARY));
					sheet.addMergedRegion(new CellRangeAddress(indexRow - 1, indexRow - 1, columnVendorIndex, columnVendorIndex + 2));
					setCodedate = true;
				}
			} else {
				vendorCell = row.createCell(columnVendorIndex);
				vendorCell.setCellValue(columnVendor);
				vendorCell.setCellStyle(styles.get(CPSConstants.HEADER_GRID_PRINSUMARY));
				sheet.addMergedRegion(new CellRangeAddress(indexRow - 1, indexRow, columnVendorIndex, columnVendorIndex));
			}
			if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RARING_TYPE_RATING)) {
				sheet.setColumnWidth(columnVendorIndex, 15000);
			}
			columnVendorIndex++;
		}
		if (rowValues != null && !rowValues.isEmpty()) {
			Row value;
			int indexValue = 0;
			String cellFormula = "";
			int indexRowData = 0;
			for (PrintSumaryProductVO printSumaryProductVO : rowValues) {
				indexValue++;
				columnVendorIndex = 0;
				indexRowData = indexRow + indexValue;
				value = sheet.createRow(indexRowData);
				indexRowData++;
				UserInfo userInfo = null;
				String userFullName = "";
				for (String columnVendor : columnHeadings) {
					vendorCell = value.createCell(columnVendorIndex);
					if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_VENDOR_NAME)) {
						vendorCell.setCellValue(printSumaryProductVO.getVendorName());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getSellingUnitUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_DESCRIPTION)) {
						vendorCell.setCellValue(printSumaryProductVO.getDescription());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_SIZE)) {
						vendorCell.setCellValue(printSumaryProductVO.getSellingUnitSize());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_UOM)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						vendorCell.setCellValue(printSumaryProductVO.getUom());
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						vendorCell.setCellValue(printSumaryProductVO.getSubCommodity());
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_STYLE)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						vendorCell.setCellValue(printSumaryProductVO.getStyle());
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_MODEL)) {
						vendorCell.setCellValue(printSumaryProductVO.getModel());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_COLOR)) {
						vendorCell.setCellValue(printSumaryProductVO.getColor());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_BRAND)) {
						vendorCell.setCellValue(printSumaryProductVO.getBrand());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PACKING)) {
						vendorCell.setCellValue(printSumaryProductVO.getPackaging());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RARING_TYPE_RATING)) {
						vendorCell.setCellValue(printSumaryProductVO.getRating());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_CASE_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getCaseUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_MASTER_PACK)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getMasterPack())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getMasterPack().trim()));
						} else {
							vendorCell.setCellValue(printSumaryProductVO.getMasterPack());
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SHIP_PACK)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getShipPack())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getShipPack().trim()));
						} else {
							vendorCell.setCellValue(printSumaryProductVO.getShipPack());
						}
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_MAX_SHELF_LIFE_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getMaxShelfLifeDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_COST_LINK_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getCostLinkUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_COUNTRY_OF_ORIGIN)) {
						vendorCell.setCellValue(printSumaryProductVO.getCountryOfOrigin());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_LIST_COST)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getListCost().trim()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_UNIT_COST)) {
						// if
						// (CPSHelper.isNotEmpty(printSumaryProductVO.getChannel())
						// &&
						// printSumaryProductVO.getChannel().equals(BusinessConstants.CHANEL_WHS))
						// {
						// if
						// (CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())
						// &&
						// CPSHelper.isNotEmpty(printSumaryProductVO.getShipPack())
						// &&
						// Double.parseDouble(printSumaryProductVO.getShipPack())
						// != 0) {
						// cellFormula = "S" + indexRowData + "/O" +
						// indexRowData;
						// vendorCell.setCellFormula(cellFormula);
						// }
						// } else {
						// if
						// (CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())
						// &&
						// CPSHelper.isNotEmpty(printSumaryProductVO.getMasterPack())
						// &&
						// Double.parseDouble(printSumaryProductVO.getMasterPack())
						// != 0) {
						// cellFormula = "S" + indexRowData + "/N" +
						// indexRowData;
						// vendorCell.setCellFormula(cellFormula);
						// }
						// }
						vendorCell.setCellValue(printSumaryProductVO.getUnitCost());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUGGESTED_UNIT_RETAIL)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getSuggestedUnitRetail())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getSuggestedUnitRetail().trim()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PREPRICE_UNIT_RETAIL)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getPrepriceUnitRetail())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getPrepriceUnitRetail().trim()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RETAIL)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getRetail())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getRetail().trim()));
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PENNY_PROFIT)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getRetail()) && CPSHelper.getBigdecimalValue(printSumaryProductVO.getRetail()) != null
								&& printSumaryProductVO.getRetailFor() != null && CPSHelper.getBigdecimalValue(printSumaryProductVO.getRetail()).compareTo(BigDecimal.ONE) == -1
								&& printSumaryProductVO.getRetailFor().compareTo(BigDecimal.ZERO) == 0) {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						} else {
							if (CPSHelper.isNotEmpty(printSumaryProductVO.getUnitCost()) && CPSHelper.isNotEmpty(printSumaryProductVO.getRetail())
									&& CPSHelper.isNotEmpty(printSumaryProductVO.getPennyprofit())) {
								// cellFormula = "ROUNDDOWN(W" + indexRowData +
								// " - T" + indexRowData+",2)";
								vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getPennyprofit()));
								// vendorCell.setCellFormula(cellFormula);
							} else {
								vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
							}
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PERCENT_MARGIN)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getUnitCost()) && CPSHelper.isNumeric(printSumaryProductVO.getRetail())
								&& Double.parseDouble(printSumaryProductVO.getRetail()) != 0 && CPSHelper.isNotEmpty(printSumaryProductVO.getMarginPercent())) {
							// cellFormula = "ROUNDDOWN(W" + indexRowData +
							// " - T" + indexRowData + ")/W" +
							// indexRowData+",2)";
							// LOG.info("% Margin:"+printSumaryProductVO.getMarginPercent());
							// vendorCell.setCellFormula(cellFormula);
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getMarginPercent()) / 100);
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_PECENTAGE_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RETAIL_LINK_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getRetailLinkUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_ITEM_CODE)) {
						vendorCell.setCellValue(printSumaryProductVO.getHebItemCode());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY)) {
						vendorCell.setCellValue(printSumaryProductVO.getSeasonality());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY_YEAR)) {
						vendorCell.setCellValue(printSumaryProductVO.getSeasonalityYear());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_INBOUND_SPECIFICATION_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getInboundSpecificationDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_REACTION_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getReactionDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_GUARANTEE_TO_STORE_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getGuaranteeToStoreDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
						// }else
						// if(columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SHIP_CANCEL_DATE)){
						// vendorCell.setCellValue(printSumaryProductVO.getShipCancelDate());
						// vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						// }else
						// if(columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PO_DATE)){
						// vendorCell.setCellValue(printSumaryProductVO.getpODateHEBDC());
						// vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						// }else
						// if(columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_ORD_QTY)){
						// vendorCell.setCellValue(printSumaryProductVO.getQty());
						// vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
						// }else
						// if(columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SHIP_CANCEL_DATE)){
						// vendorCell.setCellValue(printSumaryProductVO.getShipCancelDate());
						// vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY)) {
						vendorCell.setCellValue(printSumaryProductVO.getSubCommodity());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_BDM)) {
						vendorCell.setCellValue(printSumaryProductVO.getBdm());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUB_DEPT_NAME)) {
						vendorCell.setCellValue(printSumaryProductVO.getDeptName());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PSS_DEPT)) {
						vendorCell.setCellValue(printSumaryProductVO.getPssDept());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SOURCE_METHOD)) {
						vendorCell.setCellValue(printSumaryProductVO.getResource());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_STATUS)) {
						vendorCell.setCellValue(printSumaryProductVO.getStatus());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_TESTSCAN)) {
						vendorCell.setCellValue(printSumaryProductVO.getTestScan());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_ID_OF_USER)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getUserId())) {
							try {
								userInfo = (UserInfo) hebLdap.getUserInfo(CPSHelper.getTrimmedValue(printSumaryProductVO.getUserId()));
							} catch (UsernameNotFoundException e) {
								LOG.error(e.getMessage(), e);
							} catch (DataAccessException e) {
								LOG.error(e.getMessage(), e);
							}
							if (userInfo == null) {
								vendorCell.setCellValue(printSumaryProductVO.getUserId());
							} else {
								userFullName = userInfo.getAttributeValue("givenName") + " " + userInfo.getAttributeValue("sn") + " [" + userInfo.getUid() + "]";
								vendorCell.setCellValue(userFullName);
							}
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_BDM)) {
						vendorCell.setCellValue(printSumaryProductVO.getBdm());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					}

					columnVendorIndex++;
				}

			}
			sheet.autoSizeColumn(0);
			sheet.autoSizeColumn(1);
			sheet.autoSizeColumn(2);
			sheet.autoSizeColumn(5);
			// sheet.autoSizeColumn(6);
			// sheet.autoSizeColumn(7);
			// sheet.autoSizeColumn(8);
			sheet.autoSizeColumn(9);
			sheet.autoSizeColumn(10);
			// sheet.autoSizeColumn(11);
			sheet.autoSizeColumn(12);
			sheet.autoSizeColumn(13);
			sheet.autoSizeColumn(18);
			sheet.autoSizeColumn(27);
			sheet.autoSizeColumn(32);
			sheet.autoSizeColumn(33);
			sheet.autoSizeColumn(34);
			sheet.autoSizeColumn(37);
			sheet.autoSizeColumn(38);
			sheet.autoSizeColumn(39);
		}

		// startRowIndex = endRowIndex;
		// if ((startRowIndex + 65000) >= rowSize) {
		// endRowIndex = rowSize;
		// } else {
		// endRowIndex = startRowIndex + 65000;
		// }
		// }
		return wb;
	}

	public Workbook getDataGridValuesInXLFormatProductEDI(List<String> columnHeadings, List<PrintSumaryProductVO> rowValues, String reportName, String title,
			CandidateEDISearchCriteria candidateSearchCriteria, HebLdapUserService hebLdap) {
		HSSFWorkbook wb = new HSSFWorkbook();
		Map<String, CellStyle> styles = createStylesPrinSummaryProduct(wb);
		int indexRow = 0;
		Sheet sheet = wb.createSheet(reportName);
		sheet.setFitToPage(true);
		sheet.setHorizontallyCenter(true);
		PrintSetup printSetup = sheet.getPrintSetup();
		printSetup.setLandscape(true);

		// the following three statements are required only for HSSF
		sheet.setAutobreaks(true);
		printSetup.setFitHeight((short) 1);
		printSetup.setFitWidth((short) 1);
		Row row = sheet.createRow(indexRow);
		row.setHeightInPoints(30);
		Cell titleCell = row.createCell(0);
		titleCell.setCellValue(CPSConstants.PRINSUMARY_PRODUCT_SET_UP_STATUS_SUMMARY);
		titleCell.setCellStyle(styles.get(CPSConstants.TITLE_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$J$1"));
		indexRow++;
		row = sheet.createRow(indexRow);
		Cell userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_VENDOR_SIGNATURE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$2:$N$2"));
		indexRow++;
		row = sheet.createRow(indexRow);
		userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_DATE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$3:$N$3"));
		indexRow++;
		row = sheet.createRow(indexRow);
		userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_BDM_SIGNATURE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$4:$N$4"));
		indexRow++;
		row = sheet.createRow(indexRow);
		userCell = row.createCell(10);
		userCell.setCellValue(CPSConstants.PRINSUMARY_DATE + CPSConstants.PRINSUMARY_UNDERLINE);
		userCell.setCellStyle(styles.get(CPSConstants.USER_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$K$5:$N$5"));
		indexRow++;
		row = sheet.createRow(indexRow);
		Cell filtersCell = row.createCell(0);
		filtersCell.setCellValue(CPSConstants.PRINSUMARY_FITLER);
		filtersCell.setCellStyle(styles.get(CPSConstants.FILTER_PRINSUMARY));
		List<ProductSearchCriteria> searchCriteriaList = searchCriteriaQueryListEDI(candidateSearchCriteria);
		if (searchCriteriaList != null && !searchCriteriaList.isEmpty()) {
			for (ProductSearchCriteria productSearchCriteria : searchCriteriaList) {
				indexRow++;
				row = sheet.createRow(indexRow);
				filtersCell = row.createCell(0);
				filtersCell.setCellValue(productSearchCriteria.getCriteriaName() + " : " + String.valueOf(productSearchCriteria.getCriteriaValue()));
				filtersCell.setCellStyle(styles.get(CPSConstants.FILTER_PRINSUMARY));
			}
		}
		indexRow++;
		int indexRowMerge;
		row = sheet.createRow(indexRow);
		row.setHeightInPoints(30);
		userCell = row.createCell(0);
		userCell.setCellValue(CPSConstants.PRINSUMARY_VENDOR_FIELDS);
		userCell.setCellStyle(styles.get(CPSConstants.HEADER_VENDOR_PRINSUMARY));
		indexRowMerge = indexRow + 1;
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$" + indexRowMerge + ":$V$" + indexRowMerge));
		userCell = row.createCell(22);
		userCell.setCellValue(CPSConstants.PRINSUMARY_HEB_FIELDS);
		userCell.setCellStyle(styles.get(CPSConstants.HEADER_HEB_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$W$" + indexRowMerge + ":$AH$" + indexRowMerge));
		userCell = row.createCell(34);
		userCell.setCellValue(CPSConstants.PRINSUMARY_PRODUCT_AUDIT_DETAILS_FIELDS);
		userCell.setCellStyle(styles.get(CPSConstants.HEADER_PRODUCT_AUDIT_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$AI$" + indexRowMerge + ":$AN$" + indexRowMerge));
		indexRow++;
		row = sheet.createRow(indexRow);
		filtersCell = row.createCell(0);
		filtersCell.setCellValue("Selling UPC");
		indexRowMerge = indexRow + 1;
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$A$" + indexRowMerge + ":$L$" + indexRowMerge));
		filtersCell = row.createCell(12);
		filtersCell.setCellValue("Case Pack");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$M$" + indexRowMerge + ":$T$" + indexRowMerge));
		filtersCell = row.createCell(18);
		filtersCell.setCellValue("Vendor's Cost and Suggested Retail Pricing");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$S$" + indexRowMerge + ":$V$" + indexRowMerge));
		filtersCell = row.createCell(22);
		filtersCell.setCellValue("H-E-B's Approved Selling Price and Profitability");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$W$" + indexRowMerge + ":$AC$" + indexRowMerge));
		filtersCell = row.createCell(29);
		// filtersCell.setCellValue("HEB's Approved Selling Price and Profitability");
		filtersCell.setCellStyle(styles.get(CPSConstants.HEADER_SMALL_PRINSUMARY));
		sheet.addMergedRegion(CellRangeAddress.valueOf("$AD$" + indexRowMerge + ":$AH$" + indexRowMerge));

		// sheet.addMergedRegion(new CellRangeAddress(10, 10, 0, 40));
		indexRow++;
		row = sheet.createRow(indexRow);
		indexRow++;
		Row empty = sheet.createRow(indexRow);
		row.setHeightInPoints(30);
		empty.setHeightInPoints(30);
		Cell vendorCell;
		int columnVendorIndex = 0;
		boolean setCodedate = false;
		for (final String columnVendor : columnHeadings) {
			sheet.setColumnWidth(columnVendorIndex, 4000);
			if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_INBOUND_SPECIFICATION_DAYS) || (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_REACTION_DAYS))
					|| columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_GUARANTEE_TO_STORE_DAYS)) {
				vendorCell = empty.createCell(columnVendorIndex);
				vendorCell.setCellValue(columnVendor);
				vendorCell.setCellStyle(styles.get(CPSConstants.HEADER_GRID_PRINSUMARY));
				if (!setCodedate) {
					vendorCell = row.createCell(columnVendorIndex);
					vendorCell.setCellValue(CPSConstants.PRINSUMARY_COLUMN_CODE_DATE);
					vendorCell.setCellStyle(styles.get(CPSConstants.HEADER_GRID_PRINSUMARY));
					sheet.addMergedRegion(new CellRangeAddress(indexRow - 1, indexRow - 1, columnVendorIndex, columnVendorIndex + 2));
					setCodedate = true;
				}
			} else {
				vendorCell = row.createCell(columnVendorIndex);
				vendorCell.setCellValue(columnVendor);
				vendorCell.setCellStyle(styles.get(CPSConstants.HEADER_GRID_PRINSUMARY));
				sheet.addMergedRegion(new CellRangeAddress(indexRow - 1, indexRow, columnVendorIndex, columnVendorIndex));
			}
			columnVendorIndex++;
		}
		if (rowValues != null && !rowValues.isEmpty()) {
			Row value;
			int indexValue = 0;
			String cellFormula = "";
			int indexRowData = 0;
			for (final PrintSumaryProductVO printSumaryProductVO : rowValues) {
				indexValue++;
				columnVendorIndex = 0;
				UserInfo userInfo = null;
				String userFullName = "";
				indexRowData = indexRow + indexValue;
				value = sheet.createRow(indexRowData);
				indexRowData++;
				for (final String columnVendor : columnHeadings) {
					vendorCell = value.createCell(columnVendorIndex);
					if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_VENDOR_NAME)) {
						vendorCell.setCellValue(printSumaryProductVO.getVendorName());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getSellingUnitUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_DESCRIPTION)) {
						vendorCell.setCellValue(printSumaryProductVO.getDescription());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_SIZE)) {
						vendorCell.setCellValue(printSumaryProductVO.getSellingUnitSize());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_UOM)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						vendorCell.setCellValue(printSumaryProductVO.getUom());
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						vendorCell.setCellValue(printSumaryProductVO.getSubCommodity());
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_STYLE)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
						vendorCell.setCellValue(printSumaryProductVO.getStyle());
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_MODEL)) {
						vendorCell.setCellValue(printSumaryProductVO.getModel());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_COLOR)) {
						vendorCell.setCellValue(printSumaryProductVO.getColor());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_BRAND)) {
						vendorCell.setCellValue(printSumaryProductVO.getBrand());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PACKING)) {
						vendorCell.setCellValue(printSumaryProductVO.getPackaging());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RARING_TYPE_RATING)) {
						vendorCell.setCellValue(printSumaryProductVO.getRating());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_CASE_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getCaseUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_MASTER_PACK)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getMasterPack())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getMasterPack()));
						} else {
							vendorCell.setCellValue(printSumaryProductVO.getMasterPack());
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SHIP_PACK)) {
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getShipPack())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getShipPack()));
						} else {
							vendorCell.setCellValue(printSumaryProductVO.getShipPack());
						}
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_MAX_SHELF_LIFE_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getMaxShelfLifeDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_COST_LINK_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getCostLinkUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_COUNTRY_OF_ORIGIN)) {
						vendorCell.setCellValue(printSumaryProductVO.getCountryOfOrigin());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_LIST_COST)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getListCost()));
						} else {
							vendorCell.setCellValue(printSumaryProductVO.getListCost());
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_UNIT_COST)) {
						// if
						// (CPSHelper.isNotEmpty(printSumaryProductVO.getChannel())
						// &&
						// printSumaryProductVO.getChannel().equals(BusinessConstants.CHANEL_WHS))
						// {
						// if
						// (CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())
						// &&
						// CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())
						// &&
						// CPSHelper.isNotEmpty(printSumaryProductVO.getShipPack())
						// &&
						// Double.parseDouble(printSumaryProductVO.getShipPack())
						// != 0) {
						// cellFormula = "S" + indexRowData + "/O" +
						// indexRowData;
						// vendorCell.setCellFormula(cellFormula);
						// }
						// } else {
						// if
						// (CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())
						// &&
						// CPSHelper.isNotEmpty(printSumaryProductVO.getListCost())
						// &&
						// CPSHelper.isNotEmpty(printSumaryProductVO.getMasterPack())
						// &&
						// Double.parseDouble(printSumaryProductVO.getMasterPack())
						// != 0) {
						// cellFormula = "S" + indexRowData + "/N" +
						// indexRowData;
						// vendorCell.setCellFormula(cellFormula);
						// }
						// }
						vendorCell.setCellValue(printSumaryProductVO.getUnitCost());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUGGESTED_UNIT_RETAIL)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getSuggestedUnitRetail())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getSuggestedUnitRetail()));
						} else {
							vendorCell.setCellValue(printSumaryProductVO.getSuggestedUnitRetail());
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PREPRICE_UNIT_RETAIL)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getPrepriceUnitRetail())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getPrepriceUnitRetail()));
						} else {
							vendorCell.setCellValue(printSumaryProductVO.getPrepriceUnitRetail());
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RETAIL)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getRetail())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getRetail()));
						} else {
							vendorCell.setCellValue(printSumaryProductVO.getRetail());
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PENNY_PROFIT)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getRetail()) && CPSHelper.getBigdecimalValue(printSumaryProductVO.getRetail()) != null
								&& printSumaryProductVO.getRetailFor() != null && CPSHelper.getBigdecimalValue(printSumaryProductVO.getRetail()).compareTo(BigDecimal.ONE) == -1
								&& printSumaryProductVO.getRetailFor().compareTo(BigDecimal.ZERO) == 0) {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						} else {
							if (CPSHelper.isNotEmpty(printSumaryProductVO.getUnitCost()) && CPSHelper.isNotEmpty(printSumaryProductVO.getRetail())
									&& CPSHelper.isNotEmpty(printSumaryProductVO.getPennyprofit())) {
								vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getPennyprofit()));
							} else {
								vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
							}
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PERCENT_MARGIN)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getUnitCost()) && CPSHelper.isNumeric(printSumaryProductVO.getRetail())
								&& Double.parseDouble(printSumaryProductVO.getRetail()) != 0 && CPSHelper.isNotEmpty(printSumaryProductVO.getMarginPercent())) {
							vendorCell.setCellValue(Double.parseDouble(printSumaryProductVO.getMarginPercent()) / 100);
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_PECENTAGE_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_RETAIL_LINK_UPC)) {
						vendorCell.setCellValue(printSumaryProductVO.getRetailLinkUPC());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_ITEM_CODE)) {
						vendorCell.setCellValue(printSumaryProductVO.getHebItemCode());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY)) {
						vendorCell.setCellValue(printSumaryProductVO.getSeasonality());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY_YEAR)) {
						vendorCell.setCellValue(printSumaryProductVO.getSeasonalityYear());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_INBOUND_SPECIFICATION_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getInboundSpecificationDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_REACTION_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getReactionDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_GUARANTEE_TO_STORE_DAYS)) {
						vendorCell.setCellValue(printSumaryProductVO.getGuaranteeToStoreDays());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY)) {
						vendorCell.setCellValue(printSumaryProductVO.getSubCommodity());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_BDM)) {
						vendorCell.setCellValue(printSumaryProductVO.getBdm());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SUB_DEPT_NAME)) {
						vendorCell.setCellValue(printSumaryProductVO.getDeptName());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_PSS_DEPT)) {
						vendorCell.setCellValue(printSumaryProductVO.getPssDept());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_SOURCE_METHOD)) {
						vendorCell.setCellValue(printSumaryProductVO.getResource());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_STATUS)) {
						vendorCell.setCellValue(printSumaryProductVO.getStatus());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_TESTSCAN)) {
						vendorCell.setCellValue(printSumaryProductVO.getTestScan());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_ID_OF_USER)) {
						if (CPSHelper.isNotEmpty(printSumaryProductVO.getUserId())) {
							try {
								userInfo = (UserInfo) hebLdap.getUserInfo(CPSHelper.getTrimmedValue(printSumaryProductVO.getUserId()));
							} catch (UsernameNotFoundException e) {
								LOG.error(e.getMessage(), e);
							} catch (DataAccessException e) {
								LOG.error(e.getMessage(), e);
							}
							if (userInfo == null) {
								vendorCell.setCellValue(printSumaryProductVO.getUserId());
							} else {
								userFullName = userInfo.getAttributeValue("givenName") + " " + userInfo.getAttributeValue("sn") + " [" + userInfo.getUid() + "]";
								vendorCell.setCellValue(userFullName);
							}
						} else {
							vendorCell.setCellValue(CPSConstants.EMPTY_STRING);
						}
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					} else if (columnVendor.equals(CPSConstants.PRINSUMARY_COLUMN_BDM)) {
						vendorCell.setCellValue(printSumaryProductVO.getBdm());
						vendorCell.setCellStyle(styles.get(CPSConstants.PRINSUMARY_HEB_DATA));
					}
					columnVendorIndex++;
				}
			}
			sheet.autoSizeColumn(0);
			sheet.autoSizeColumn(1);
			sheet.autoSizeColumn(2);
			sheet.autoSizeColumn(5);
			// sheet.autoSizeColumn(6);
			// sheet.autoSizeColumn(7);
			// sheet.autoSizeColumn(8);
			sheet.autoSizeColumn(9);
			sheet.autoSizeColumn(10);
			// sheet.autoSizeColumn(11);
			sheet.autoSizeColumn(12);
			sheet.autoSizeColumn(13);
			sheet.autoSizeColumn(18);
			sheet.autoSizeColumn(28);
			sheet.autoSizeColumn(33);
			sheet.autoSizeColumn(34);
			sheet.autoSizeColumn(35);
			sheet.autoSizeColumn(38);
			sheet.autoSizeColumn(39);
			sheet.autoSizeColumn(40);
		}
		return wb;
	}

	private static Map<String, CellStyle> createStylesPrinSummaryProduct(HSSFWorkbook wb) {
		Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
		// short borderColor = IndexedColors.BLACK.getIndex();
		CellStyle style;
		// style title
		Font titleFont = wb.createFont();
		titleFont.setFontHeightInPoints(CPSConstants.TITLE_PRINSUMARY_FONT_HEIGHT);
		titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
		titleFont.setColor(IndexedColors.BLACK.getIndex());
		titleFont.setFontName("Arial");
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFont(titleFont);
		styles.put(CPSConstants.TITLE_PRINSUMARY, style);
		// end style title

		// style user
		Font userFont = wb.createFont();
		userFont.setFontHeightInPoints(CPSConstants.USER_PRINSUMARY_PRINSUMARY_FONT_HEIGHT);
		userFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
		userFont.setColor(IndexedColors.BLACK.getIndex());
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFont(userFont);
		styles.put(CPSConstants.USER_PRINSUMARY, style);
		// end style user

		// style filter
		Font filterApplied = wb.createFont();
		filterApplied.setFontHeightInPoints(CPSConstants.FILTER_PRINSUMARY_FONT_HEIGHT);
		filterApplied.setFontName("Calibri");
		filterApplied.setColor(IndexedColors.BLACK.getIndex());
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFont(filterApplied);
		styles.put(CPSConstants.FILTER_PRINSUMARY, style);

		// end filter

		// style header Vendor
		Font headerVendor = wb.createFont();
		headerVendor.setFontHeightInPoints(CPSConstants.HEADER_PRINSUMARY_FONT_HEIGHT);
		headerVendor.setColor(IndexedColors.WHITE.getIndex());
		headerVendor.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.GREEN.index);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		style.setFont(headerVendor);
		styles.put(CPSConstants.HEADER_VENDOR_PRINSUMARY, style);

		// end header Vendor

		// style header HEB
		Font headerHeb = wb.createFont();
		headerHeb.setFontHeightInPoints(CPSConstants.HEADER_PRINSUMARY_FONT_HEIGHT);
		headerHeb.setColor(IndexedColors.BLACK.getIndex());
		headerHeb.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.LIGHT_ORANGE.index);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		style.setFont(headerHeb);
		styles.put(CPSConstants.HEADER_HEB_PRINSUMARY, style);
		// end header HEB

		// style Product Audit
		Font headerProductAudit = wb.createFont();
		headerProductAudit.setFontHeightInPoints(CPSConstants.HEADER_PRINSUMARY_FONT_HEIGHT);
		headerProductAudit.setColor(IndexedColors.BLACK.getIndex());
		headerProductAudit.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.YELLOW.index);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		style.setFont(headerProductAudit);
		styles.put(CPSConstants.HEADER_PRODUCT_AUDIT_PRINSUMARY, style);
		// end Product Audit

		// style header HEB
		Font headerSmall = wb.createFont();
		headerSmall.setFontHeightInPoints(CPSConstants.HEADER_SAMLL_PRINSUMARY_PRINSUMARY_FONT_HEIGHT);
		headerSmall.setColor(IndexedColors.BLACK.getIndex());
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFont(headerSmall);
		styles.put(CPSConstants.HEADER_SMALL_PRINSUMARY, style);
		// end header HEB

		// style header grid
		Font headerGrid = wb.createFont();
		headerGrid.setFontHeightInPoints(CPSConstants.HEADER_GRID_PRINSUMARY_PRINSUMARY_FONT_HEIGHT);
		headerGrid.setBoldweight(Font.BOLDWEIGHT_BOLD);
		headerGrid.setColor(IndexedColors.BLACK.getIndex());
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		style.setFont(headerGrid);
		styles.put(CPSConstants.HEADER_GRID_PRINSUMARY, style);
		// end header HEB

		// style grid data
		Font gridData = wb.createFont();
		gridData.setFontHeightInPoints(CPSConstants.GRID_DATA_PRINSUMARY_PRINSUMARY_FONT_HEIGHT);
		gridData.setColor(IndexedColors.BLACK.getIndex());
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setLocked(false);
		style.setWrapText(true);
		style.setFont(gridData);
		styles.put(CPSConstants.GRID_DATA_PRINSUMARY, style);
		// end header HEB
		// style data
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_LEFT);
		// style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		// style.setFont(gridData);
		styles.put(CPSConstants.PRINSUMARY_HEB_DATA, style);
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_RIGHT);
		// style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setLocked(false);
		style.setWrapText(true);
		// style.setWrapText(true);
		// style.setFont(gridData);
		styles.put(CPSConstants.PRINSUMARY_HEB_DATA_ALIGN_RIGHT, style);

		// PRINSUMARY_HEB_DATA_CURRENCY_RIGHT
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_RIGHT);
		HSSFDataFormat df = wb.createDataFormat();
		style.setDataFormat(df.getFormat("$#,##0.0000"));
		style.setLocked(false);
		style.setWrapText(true);
		styles.put(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_RIGHT, style);
		// PRINSUMARY_HEB_DATA_CURRENCY_RIGHT
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_RIGHT);
		df = wb.createDataFormat();
		style.setDataFormat(df.getFormat("$#,##0.00"));
		style.setLocked(false);
		style.setWrapText(true);
		styles.put(CPSConstants.PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT, style);
		// PRINSUMARY_HEB_DATA_PECENTAGE_RIGHT
		style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_RIGHT);
		df = wb.createDataFormat();
		style.setDataFormat(df.getFormat("0.00%"));
		style.setLocked(false);
		style.setWrapText(true);
		styles.put(CPSConstants.PRINSUMARY_HEB_DATA_PECENTAGE_RIGHT, style);
		return styles;
	}

	private List<ProductSearchCriteria> searchCriteriaQueryList(CandidateSearchCriteria searchCriteria) {
		// SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		List<ProductSearchCriteria> searchCriteriaList = new ArrayList<ProductSearchCriteria>();
		final String prodDescription = CPSHelper.getTrimmedValue(searchCriteria.getProdDescription());
		final String vendorDescription = CPSHelper.getTrimmedValue(searchCriteria.getVendorDescription());
		List<Integer> vendorIDList = searchCriteria.getVendorIDList();
		final String unitUPC = CPSHelper.getTrimmedValue(searchCriteria.getUpc());
		final String caseUPC = CPSHelper.getTrimmedValue(searchCriteria.getCaseUpc());
		final String retailLink = CPSHelper.getTrimmedValue(searchCriteria.getRetailLink());
		final String costLink = CPSHelper.getTrimmedValue(searchCriteria.getCostLink());
		// Product Description
		if (CPSHelper.isNotEmpty(prodDescription)) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Product Description", prodDescription.trim().toUpperCase());
			searchCriteriaList.add(searchCriteria1);
		}
		// Vendor description
		if (CPSHelper.isNotEmpty(vendorDescription) && CPSHelper.isEmpty(vendorIDList)) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Vendor Name/Number", vendorDescription.toUpperCase());
			searchCriteriaList.add(searchCriteria1);
		}

		// Vendor ID
		if (CPSHelper.isNotEmpty(vendorIDList)) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Vendor Name/Number", vendorIDList);
			searchCriteriaList.add(searchCriteria1);
		}

		// Unit UPC
		if (CPSHelper.isNotEmpty(unitUPC)) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria(BusinessConstants.UPC_CRITERIA_NAME, unitUPC);
			searchCriteriaList.add(searchCriteria1);
		}
		// Case UPC
		if (CPSHelper.isNotEmpty(caseUPC)) {
			// Fixed for search CASE-UPC in
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Case UPC", caseUPC);
			searchCriteriaList.add(searchCriteria1);

		}

		// Item Code
		if (CPSHelper.isNotEmpty(searchCriteria.getItemCode())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Item Code", searchCriteria.getItemCode().trim());
			searchCriteriaList.add(searchCriteria1);
		}
		// BDM
		if (CPSHelper.isNotEmpty(searchCriteria.getBdm())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria(BusinessConstants.BDM_CRITERIA_NAME, searchCriteria.getBdm());
			searchCriteriaList.add(searchCriteria1);
		}
		// Sub Commodity
		if (CPSHelper.isNotEmpty(searchCriteria.getSubCommodity())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Sub Commodity", searchCriteria.getSubCommodity());
			searchCriteriaList.add(searchCriteria1);

		}
		// Commodity
		if (CPSHelper.isNotEmpty(searchCriteria.getCommodity())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Commodity", searchCriteria.getCommodity());
			searchCriteriaList.add(searchCriteria1);

		}
		// class
		if (CPSHelper.isNotEmpty(searchCriteria.getClassField())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Class", searchCriteria.getClassField());
			searchCriteriaList.add(searchCriteria1);
		}
		// product type - equal search for drop down
		if (CPSHelper.isNotEmpty(searchCriteria.getProductTypeName())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Product Type", searchCriteria.getProductTypeName().toUpperCase());
			searchCriteriaList.add(searchCriteria1);
		}
		// from date
		if (CPSHelper.isNotEmpty(searchCriteria.getFromDate())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("From Date", searchCriteria.getFromDate());
			searchCriteriaList.add(searchCriteria1);
		}
		// to date
		if (CPSHelper.isNotEmpty(searchCriteria.getToDate())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("To Date", searchCriteria.getToDate());
			searchCriteriaList.add(searchCriteria1);
		}
		// Retail Link
		if (CPSHelper.isNotEmpty(retailLink)) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Retail Link", retailLink);
			searchCriteriaList.add(searchCriteria1);
		}
		// Cost Link
		if (CPSHelper.isNotEmpty(costLink)) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Cost Link", costLink);
			searchCriteriaList.add(searchCriteria1);
		}
		// Status
		if (CPSHelper.isNotEmpty(searchCriteria.getStatusName())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Status", searchCriteria.getStatusName());
			searchCriteriaList.add(searchCriteria1);
		}
		// Test Scan Status
		if (CPSHelper.isNotEmpty(searchCriteria.getTestScanStatusName())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Test Scan Status", searchCriteria.getTestScanStatusName());
			searchCriteriaList.add(searchCriteria1);
		}
		return searchCriteriaList;
	}

	private List<ProductSearchCriteria> searchCriteriaQueryListEDI(CandidateEDISearchCriteria searchCriteria) {
		// SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		final List<ProductSearchCriteria> searchCriteriaList = new ArrayList<ProductSearchCriteria>();
		final String prodDescription = CPSHelper.getTrimmedValue(searchCriteria.getProdDescription());
		final String vendorDescription = CPSHelper.getTrimmedValue(searchCriteria.getVendorDescription());
		final List<Integer> vendorIDList = searchCriteria.getVendorIDList();
		final String unitUPC = CPSHelper.getTrimmedValue(searchCriteria.getUpc());
		final String retailLink = CPSHelper.getTrimmedValue(searchCriteria.getRetailLink());
		final String costLink = CPSHelper.getTrimmedValue(searchCriteria.getCostLink());
		// Product Description
		if (CPSHelper.isNotEmpty(prodDescription)) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Product Description", prodDescription.trim().toUpperCase());
			searchCriteriaList.add(searchCriteria1);
		}
		// Vendor description
		if (CPSHelper.isNotEmpty(vendorDescription) && CPSHelper.isEmpty(vendorIDList)) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Vendor Name/Number", vendorDescription.toUpperCase());
			searchCriteriaList.add(searchCriteria1);
		}

		// Vendor ID
		if (CPSHelper.isNotEmpty(vendorIDList)) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Vendor Name/Number", vendorIDList);
			searchCriteriaList.add(searchCriteria1);
		}

		// Unit UPC
		if (CPSHelper.isNotEmpty(unitUPC)) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria(BusinessConstants.UPC_CRITERIA_NAME, unitUPC);
			searchCriteriaList.add(searchCriteria1);
		}

		// Item Code
		if (CPSHelper.isNotEmpty(searchCriteria.getItemCode())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Item Code", searchCriteria.getItemCode().trim());
			searchCriteriaList.add(searchCriteria1);
		}
		// BDM
		if (CPSHelper.isNotEmpty(searchCriteria.getBdm())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria(BusinessConstants.BDM_CRITERIA_NAME, searchCriteria.getBdm());
			searchCriteriaList.add(searchCriteria1);
		}
		// Sub Commodity
		if (CPSHelper.isNotEmpty(searchCriteria.getSubCommodity())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Sub Commodity", searchCriteria.getSubCommodity());
			searchCriteriaList.add(searchCriteria1);

		}
		// Commodity
		if (CPSHelper.isNotEmpty(searchCriteria.getCommodity())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Commodity", searchCriteria.getCommodity());
			searchCriteriaList.add(searchCriteria1);

		}
		// class
		if (CPSHelper.isNotEmpty(searchCriteria.getClassField())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Class", searchCriteria.getClassField());
			searchCriteriaList.add(searchCriteria1);
		}
		// product type - equal search for drop down
		if (CPSHelper.isNotEmpty(searchCriteria.getProductTypeName())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Product Type", searchCriteria.getProductTypeName().toUpperCase());
			searchCriteriaList.add(searchCriteria1);
		}
		// from date
		if (CPSHelper.isNotEmpty(searchCriteria.getFromDate())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("From Date", searchCriteria.getFromDate());
			searchCriteriaList.add(searchCriteria1);
		}
		// to date
		if (CPSHelper.isNotEmpty(searchCriteria.getToDate())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("To Date", searchCriteria.getToDate());
			searchCriteriaList.add(searchCriteria1);
		}
		// Retail Link
		if (CPSHelper.isNotEmpty(retailLink)) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Retail Link", retailLink);
			searchCriteriaList.add(searchCriteria1);
		}
		// Cost Link
		if (CPSHelper.isNotEmpty(costLink)) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Cost Link", costLink);
			searchCriteriaList.add(searchCriteria1);
		}
		// Status
		if (CPSHelper.isNotEmpty(searchCriteria.getStatusName())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Status", searchCriteria.getStatusName());
			searchCriteriaList.add(searchCriteria1);
		}
		// DataSourse
		if (CPSHelper.isNotEmpty(searchCriteria.getDataSourseName())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Data Source", searchCriteria.getDataSourseName());
			searchCriteriaList.add(searchCriteria1);
		}
		// Action
		if (CPSHelper.isNotEmpty(searchCriteria.getActionName())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Action", searchCriteria.getActionName());
			searchCriteriaList.add(searchCriteria1);
		}
		// Test Scan Status
		if (CPSHelper.isNotEmpty(searchCriteria.getTestScanStatusName())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Test Scan Status", searchCriteria.getTestScanStatusName());
			searchCriteriaList.add(searchCriteria1);
		}
		// Tracking Number
		if (CPSHelper.isNotEmpty(searchCriteria.getBatchId())) {
			final ProductSearchCriteria searchCriteria1 = new ProductSearchCriteria("Tracking Number", searchCriteria.getBatchId());
			searchCriteriaList.add(searchCriteria1);
		}
		return searchCriteriaList;
	}
}