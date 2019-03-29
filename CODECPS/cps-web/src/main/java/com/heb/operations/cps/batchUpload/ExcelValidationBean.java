package com.heb.operations.cps.batchUpload;

import java.io.Serializable;

public class ExcelValidationBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 39851998525265835L;

	private String expectedHeader = "";

	private String foundHeader = "";

	private String excelStatus = "";

	public String getExpectedHeader() {
		return expectedHeader;
	}

	public void setExpectedHeader(String expectedHeader) {
		this.expectedHeader = expectedHeader;
	}

	public String getFoundHeader() {
		return foundHeader;
	}

	public void setFoundHeader(String foundHeader) {
		this.foundHeader = foundHeader;
	}

	public String getExcelStatus() {
		return excelStatus;
	}

	public void setExcelStatus(String excelStatus) {
		this.excelStatus = excelStatus;
	}

}
