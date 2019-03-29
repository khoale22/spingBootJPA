/*
 * $Id: BaseVO.java,v 1.21 2015/03/12 11:15:08 vn44178 Exp $
 *
 * Copyright (c) 2014 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.jaf.vo;

import java.io.Serializable;

/**
 * The Class BaseVO.
 *
 * @author ha.than
 */
public class BaseVO implements Serializable {

	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 7679295204128632853L;
	
	/** The action cd. */
	private String actionCd;
	
	/** The id. */
	private String id;
	
	/** The desc. */
	private String desc;
	
	/** The is selected. */
	private boolean isSelected;
	
	/** The ps work id. */
	private int psWorkId;

	/**
	 * Gets the id.
	 *
	 * @return the id
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * Sets the id.
	 *
	 * @param baseid            the id to set
	 */
	public void setId(String baseid) {
		this.id = baseid;
	}

	/**
	 * Gets the desc.
	 *
	 * @return the desc
	 */
	public String getDesc() {
		return this.desc;
	}

	/**
	 * Sets the desc.
	 *
	 * @param descrpt            the desc to set
	 */
	public void setDesc(String descrpt) {
		this.desc = descrpt;
	}

	/**
	 * Checks if is selected.
	 *
	 * @return isSelected
	 */
	public boolean isSelected() {
		return this.isSelected;
	}

	/**
	 * setSelected field.
	 * 
	 * @param isSelectedVal
	 *            isSelected
	 */
	public void setSelected(boolean isSelectedVal) {
		this.isSelected = isSelectedVal;
	}

	/**
	 * Gets the ps work id.
	 *
	 * @return the psWorkId
	 */
	public int getPsWorkId() {
		return this.psWorkId;
	}

	/**
	 * Sets the ps work id.
	 *
	 * @param psWorkId            the psWorkId to set
	 */
	public void setPsWorkId(int psWorkId) {
		this.psWorkId = psWorkId;
	}

	/**
	 * Gets the action cd.
	 *
	 * @return the actionCd
	 */
	public String getActionCd() {
		return this.actionCd;
	}

	/**
	 * Sets the action cd.
	 *
	 * @param actionCd            the actionCd to set
	 */
	public void setActionCd(String actionCd) {
		this.actionCd = actionCd;
	}
}
