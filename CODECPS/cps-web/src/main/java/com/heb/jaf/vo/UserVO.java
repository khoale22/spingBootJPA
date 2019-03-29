/*
 * $Id: UserVO.java,v 1.21 2015/03/12 11:15:09 vn44178 Exp $
 *
 * Copyright (c) 2014 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.jaf.vo;

import java.io.Serializable;
import java.util.List;

/**
 * The Class UserVO.
 *
 * @author ha.than
 */
public class UserVO implements Serializable {
    /**
     * serialVersionUID.
     */
    private static final long serialVersionUID = 1L;
    
    /** The user id. */
    private String userId;
    
    /** The user name. */
    private String userName;
    
    /** The lst vendor assigns. */
    private List<BaseVO> lstVendorAssigns;
    
    /** The access type. */
    private String accessType;
    
    /** The lst role vo. */
    private List<RoleVO> lstRoleVO;

    /**
     * UserVO.
     */
    public UserVO() {
    }

    /**
     * Gets the user id.
     *
     * @return the userId
     */
    public final String getUserId() {
	return this.userId;
    }

    /**
     * Sets the user id.
     *
     * @param userId            the userId to set
     */
    public final void setUserId(String userId) {
	this.userId = userId;
    }

    /**
     * Gets the user name.
     *
     * @return the userName
     */
    public final String getUserName() {
	return this.userName;
    }

    /**
     * Sets the user name.
     *
     * @param userName            the userName to set
     */
    public final void setUserName(String userName) {
	this.userName = userName;
    }

    /**
     * Gets the lst vendor assigns.
     *
     * @return the lstVendorAssigns
     */
    public final List<BaseVO> getLstVendorAssigns() {
	return this.lstVendorAssigns;
    }

    /**
     * Sets the lst vendor assigns.
     *
     * @param lstVendorAssigns            the lstVendorAssigns to set
     */
    public final void setLstVendorAssigns(List<BaseVO> lstVendorAssigns) {
	this.lstVendorAssigns = lstVendorAssigns;
    }

    /**
     * Gets the access type.
     *
     * @return the accessType
     */
    public final String getAccessType() {
	return this.accessType;
    }

    /**
     * Sets the access type.
     *
     * @param accessType            the accessType to set
     */
    public final void setAccessType(String accessType) {
	this.accessType = accessType;
    }

    /**
     * getLstRoleVO.
     * @return List<RoleVO>
     */
    public List<RoleVO> getLstRoleVO() {
	return this.lstRoleVO;
    }

    /**
     * setLstRoleVO.
     * @param lstRoleVO
     *            List<RoleVO>
     */
    public void setLstRoleVO(List<RoleVO> lstRoleVO) {
	this.lstRoleVO = lstRoleVO;
    }

}