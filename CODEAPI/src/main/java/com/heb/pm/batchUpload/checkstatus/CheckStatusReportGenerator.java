/*
 *  CheckStatusReportGenerator
 *  Copyright (c) 2017 HEB
 *  All rights reserved.
 *
 *  This software is the confidential and proprietary information of HEB.
 */
package com.heb.pm.batchUpload.checkstatus;

import com.heb.pm.batchUpload.util.BatchUploadStatusDetail;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * generate to csv on check status page
 *
 * @author vn87351
 * @since 2.12.0
 */
public class CheckStatusReportGenerator {
	private static final String TEXT_EXPORT_FORMAT = "\"%s\",";
	private static final String NEWLINE_TEXT_EXPORT_FORMAT = "\n";

	private static final String DOUBLE_QUOTES_FORMAT = "\"";
	private static final String ESCAPED_DOUBLE_QUOTES_FORMAT = "\"\"";

	public static final String CSV_HEADING = "Product ID, Product Description, Size,Primary UPC,Result,Error Message";
	/**
	 * Creates a CSV string from a list of object detail tracking.
	 *
	 * @param lst a list of tracking detail.
	 * @return a CSV string with tracking detail information.
	 */
	public static String createCsv(List<BatchUploadStatusDetail> lst){
		StringBuilder csv = new StringBuilder();
		for(BatchUploadStatusDetail batchUploadStatusDetail : lst){
			csv.append(String.format(TEXT_EXPORT_FORMAT, batchUploadStatusDetail.getProductId()));
			csv.append(String.format(TEXT_EXPORT_FORMAT, formatCsvData(batchUploadStatusDetail.getProductDescription())));
			csv.append(String.format(TEXT_EXPORT_FORMAT, formatCsvData(batchUploadStatusDetail.getSize())));
			csv.append(String.format(TEXT_EXPORT_FORMAT, batchUploadStatusDetail.getPrimaryUpc()));
			csv.append(String.format(TEXT_EXPORT_FORMAT, formatCsvData(batchUploadStatusDetail.getUpdateResult())));
			csv.append(String.format(TEXT_EXPORT_FORMAT, formatCsvData(batchUploadStatusDetail.getErrorMessage())));
			csv.append(NEWLINE_TEXT_EXPORT_FORMAT);
		}
		return csv.toString();
	}

	/**
	 * Escaped the double-quotes with another double quote (RFC4180).
	 * @param value The string will be formatted.
	 * @return a formatted string.
	 */
	private static String formatCsvData(String value) {
		String result = value;
		if (result != null && result.contains(DOUBLE_QUOTES_FORMAT)) {
			result = result.replace(DOUBLE_QUOTES_FORMAT, ESCAPED_DOUBLE_QUOTES_FORMAT);
		}
		return result;
	}
}
