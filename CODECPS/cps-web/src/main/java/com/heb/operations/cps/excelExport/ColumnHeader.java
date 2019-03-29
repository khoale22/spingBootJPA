package com.heb.operations.cps.excelExport;

public class ColumnHeader {

	private String property;
	private String displayName;

	/**
	 * @param property
	 * @param displayName
	 */
	public ColumnHeader(String displayName, String property) {
		super();
		this.property = property;
		this.displayName = displayName;
	}

	/**
	 * @return Returns the displayName.
	 */
	public String getDisplayName() {
		return displayName;
	}

	/**
	 * @param displayName
	 *            The displayName to set.
	 */
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	/**
	 * @return Returns the property.
	 */
	public String getProperty() {
		return property;
	}

	/**
	 * @param property
	 *            The property to set.
	 */
	public void setProperty(String property) {
		this.property = property;
	}
}
