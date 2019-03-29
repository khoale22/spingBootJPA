package com.heb.operations.cps.model;

public class AjaxSearchVO extends HebBaseInfo {

	private static final long serialVersionUID = 1L;

	public static final String FORM_NAME = "AjaxSearchVO";

	private boolean showId;
	private boolean highlightMatch;
	private String codeTableName;
	private String query;
	private int maxResults;
	private boolean searchOnId;
	private String uniqueId;
	private String action;

	@Override
	public String getStrutsFormName() {

		return FORM_NAME;
	}


	/**
	 * @return the showId
	 */
	public boolean isShowId() {
		return showId;
	}

	/**
	 * @param showId
	 *            the showId to set
	 */
	public void setShowId(boolean showId) {
		this.showId = showId;
	}

	/**
	 * @return the highlightMatch
	 */
	public boolean isHighlightMatch() {
		return highlightMatch;
	}

	/**
	 * @param highlightMatch
	 *            the highlightMatch to set
	 */
	public void setHighlightMatch(boolean highlightMatch) {
		this.highlightMatch = highlightMatch;
	}

	/**
	 * @return the codeTableName
	 */
	public String getCodeTableName() {
		return codeTableName;
	}

	/**
	 * @param codeTableName
	 *            the codeTableName to set
	 */
	public void setCodeTableName(String codeTableName) {
		this.codeTableName = codeTableName;
	}

	/**
	 * @return the query
	 */
	public String getQuery() {
		return query;
	}

	/**
	 * @param query
	 *            the query to set
	 */
	public void setQuery(String query) {
		this.query = query;
	}

	/**
	 * @return the maxResults
	 */
	public int getMaxResults() {
		return maxResults;
	}

	/**
	 * @param maxResults
	 *            the maxResults to set
	 */
	public void setMaxResults(int maxResults) {
		this.maxResults = maxResults;
	}

	/**
	 * @return the searchOnId
	 */
	public boolean isSearchOnId() {
		return searchOnId;
	}

	/**
	 * @param searchOnId
	 *            the searchOnId to set
	 */
	public void setSearchOnId(boolean searchOnId) {
		this.searchOnId = searchOnId;
	}

	/**
	 * @return the uniqueId
	 */
	public String getUniqueId() {
		return uniqueId;
	}

	/**
	 * @param uniqueId
	 *            the uniqueId to set
	 */
	public void setUniqueId(String uniqueId) {
		this.uniqueId = uniqueId;
	}

	/**
	 * @return the action
	 */
	public String getAction() {
		return action;
	}

	/**
	 * @param action
	 *            the action to set
	 */
	public void setAction(String action) {
		this.action = action;
	}

}
