package com.heb.operations.cps.excelExport;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.Logger;

/**
 * @author UST Global
 * 
 *         Helper class for the Excel export functionality.
 */
public class CPSExportHelper {

	/** The Constant LOG. */
	private static final Logger LOG = Logger.getLogger(CPSExportHelper.class);

	private static int MAX_ROWS = 65000; // 65536;

	/**
	 * Gets the XML format of the list
	 * 
	 * @param columnHeaders
	 * @param rowValues
	 * @param reportName
	 * @param title
	 * @param out
	 * @return XML format
	 */
	public String getXMLFormat(List columnHeaders, List rowValues, String reportName, String title, OutputStream out) {

		List excelContents = rowValues;
		int headerSize = columnHeaders.size();
		int rowSize = excelContents.size();

		StringBuffer results = new StringBuffer();
		results.append(getWorkbookOpenHeader());

		int numberOfSheets;
		if ((rowSize % 65000) == 0) {
			numberOfSheets = rowSize / 65000;
		} else {
			numberOfSheets = (rowSize / 65000) + 1;
		}
		int startRowIndex = 0;
		int endRowIndex = 0;
		if (rowSize > 65000) {
			endRowIndex = 65000;
		} else {
			endRowIndex = rowSize;
		}

		results.append(getHeaderStyle());

		for (int i = 0; i < numberOfSheets; i++) {

			// Create worksheets
			results.append("<Worksheet ss:Name=\"SearchResults");
			results.append(i);
			results.append("\">");
			// Set the row count / column count value
			results.append("<Table ss:ExpandedColumnCount=\"").append(headerSize).append("\" ss:ExpandedRowCount=\"").append(((endRowIndex - startRowIndex) + 1))
					.append("\" x:FullColumns=\"1\" x:FullRows=\"1\"><Column ss:Width=\"73.5\" ss:Span=\"2\"/>");

			/* To set column headings */
			results.append(getSheetHeader(columnHeaders));

			try {
				out.write(results.toString().getBytes());
				results.setLength(0);
			} catch (IOException e) {
				LOG.error(e.getMessage(), e);
			}

			results.append(getSheetBody(excelContents, columnHeaders, startRowIndex, endRowIndex, out));

			results.append("</Table>");
			results.append("</Worksheet>");

			startRowIndex = endRowIndex;
			if ((startRowIndex + 65000) >= rowSize) {
				endRowIndex = rowSize;
			} else {
				endRowIndex = startRowIndex + 65000;
			}

		}

		results.append("</Workbook>");

		try {
			out.write(results.toString().getBytes());
			results.setLength(0);
		} catch (IOException exception) {
			LOG.error(exception.getMessage(), exception);
		}
		return ""; // results.toString();

	}

	public String getXMLFormat(List columnHeaders, List rowValues, String reportName, String title, FileOutputStream out) {

		List excelContents = rowValues;
		int headerSize = columnHeaders.size();
		int rowSize = excelContents.size();

		StringBuffer results = new StringBuffer();
		results.append(getWorkbookOpenHeader());

		int numberOfSheets;
		if ((rowSize % 65000) == 0) {
			numberOfSheets = rowSize / 65000;
		} else {
			numberOfSheets = (rowSize / 65000) + 1;
		}
		int startRowIndex = 0;
		int endRowIndex = 0;
		if (rowSize > 65000) {
			endRowIndex = 65000;
		} else {
			endRowIndex = rowSize;
		}

		results.append(getHeaderStyle());

		for (int i = 0; i < numberOfSheets; i++) {

			// Create worksheets
			results.append("<Worksheet ss:Name=\"SearchResults");
			results.append(i);
			results.append("\">");
			// Set the row count / column count value
			results.append("<Table ss:ExpandedColumnCount=\"").append(headerSize).append("\" ss:ExpandedRowCount=\"").append(((endRowIndex - startRowIndex) + 1))
					.append("\" x:FullColumns=\"1\" x:FullRows=\"1\"><Column ss:Width=\"73.5\" ss:Span=\"2\"/>");

			/* To set column headings */
			results.append(getSheetHeader(columnHeaders));

			try {
				out.write(results.toString().getBytes());
				results.setLength(0);
			} catch (IOException e) {
				LOG.error(e.getMessage(), e);
			}

			results.append(getSheetBody(excelContents, columnHeaders, startRowIndex, endRowIndex, out));

			results.append("</Table>");
			results.append("</Worksheet>");

			startRowIndex = endRowIndex;
			if ((startRowIndex + 65000) >= rowSize) {
				endRowIndex = rowSize;
			} else {
				endRowIndex = startRowIndex + 65000;
			}

		}

		results.append("</Workbook>");

		try {
			out.write(results.toString().getBytes());
			results.setLength(0);
		} catch (IOException exception) {
			LOG.error(exception.getMessage(), exception);
		}
		return ""; 

	}

	/**
	 * Gets the header portion in XML format
	 * 
	 * @return
	 */
	public String getWorkbookOpenHeader() {
		StringBuffer results = new StringBuffer();
		results.append("<?xml version=\"1.0\"?>").append("<?mso-application progid=\"Excel.Sheet\"?>");
		results.append("<Workbook xmlns=\"urn:schemas-microsoft-com:office:spreadsheet\"").append(" xmlns:o=\"urn:schemas-microsoft-com:office:office\"")
				.append(" xmlns:x=\"urn:schemas-microsoft-com:office:excel\"").append(" xmlns:ss=\"urn:schemas-microsoft-com:office:spreadsheet\"")
				.append(" xmlns:html=\"http://www.w3.org/TR/REC-html40\">");
		return results.toString();
	}

	/**
	 * Gets the header style in XML format
	 * 
	 * @return header style
	 */
	public String getHeaderStyle() {
		StringBuffer results = new StringBuffer();
		results.append("<Styles><Style ss:ID=\"s21\">");
		results.append("<Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Bottom\"/>");
		results.append("<Borders><Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" ss:Color=\"#000000\"/>");
		results.append("<Border ss:Position=\"Left\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" ss:Color=\"#000000\"/>");
		results.append("<Border ss:Position=\"Right\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"");
		results.append(" ss:Color=\"#000000\"/><Border ss:Position=\"Top\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" ss:Color=\"#000000\"/>");
		results.append("</Borders><Font/></Style></Styles>");
		return results.toString();
	}

	/**
	 * Gets the sheet header portion in XML format
	 * 
	 * @param columnHeaders
	 * @return
	 */
	private String getSheetHeader(List columnHeaders) {

		int headerSize = columnHeaders.size();
		StringBuffer results = new StringBuffer();
		results.append("<Row>");

		for (int column = 0; column < headerSize; column++) {
			ColumnHeader columnHeader = (ColumnHeader) columnHeaders.get(column);
			results.append("<Cell ss:StyleID=\"s21\"><Data ss:Type=\"String\">");
			results.append(columnHeader.getDisplayName());
			results.append("</Data></Cell>");
		}

		results.append("</Row>");
		return results.toString();

	}

	/**
	 * Gets the sheet body portion in XML format
	 * 
	 * @param data
	 * @param columnHeaders
	 * @param startRowIndex
	 * @param endRowIndex
	 * @param out
	 * @return
	 */
	public String getSheetBody(List data, List columnHeaders, int startRowIndex, int endRowIndex, OutputStream out) {

		StringBuffer results = new StringBuffer();
		int headerSize = columnHeaders.size();
		Object row = null;
		ColumnHeader columnHeader = null;

		for (int i = startRowIndex; i < endRowIndex; i++) {
			results.append("<Row>");
			row = data.get(i);
			for (int columnIndex = 0; columnIndex < headerSize; columnIndex++) {
				columnHeader = (ColumnHeader) columnHeaders.get(columnIndex);
				results.append("<Cell><Data ss:Type=\"String\">");
				results.append(getCellValue(row, columnHeader));
				results.append("</Data></Cell>");
			}
			results.append("</Row>");

			if ((i % 20) == 0) {
				try {
					out.write(results.toString().getBytes());
					out.flush();
					results.setLength(0);
				} catch (IOException e) {
					LOG.error(e.getMessage(), e);
				}
			}

		}

		try {
			if (results.length() > 0) {
				out.write(results.toString().getBytes());
				results.setLength(0);
			}
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}

		return ""; // results.toString();
	}

	/**
	 * Gets the cell value
	 * 
	 * @param row
	 * @param columnHeader
	 * @return
	 */
	public String getCellValue(Object row, ColumnHeader columnHeader) {
		String propertyName = columnHeader.getProperty();
		Object value = getValueOf(row, propertyName);
		return "".equals(value) ? "" : value.toString();
	}

	/**
	 * Gets the value of the bean
	 * 
	 * @param obj
	 * @param propertyName
	 * @return
	 */
	private Object getValueOf(Object obj, String propertyName) {
		Object value = invoke(obj, getGetterMethod(propertyName));
		return ((value != null) ? (value) : (""));
	}

	/**
	 * Gets the getter method name
	 * 
	 * @param propName
	 * @return
	 */
	private static String getGetterMethod(String propName) {
		if (propName == null) {
			return null;
		}
		return propName = propName.trim();
	}

	/**
	 * Invokes the method dynamically
	 * 
	 * @param obj
	 * @param methodName
	 * @return
	 */
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
}