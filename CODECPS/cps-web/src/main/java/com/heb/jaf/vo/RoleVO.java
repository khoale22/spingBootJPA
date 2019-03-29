/*
 * $Id: RoleVO.java,v 1.21 2015/03/12 11:15:08 vn44178 Exp $
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
 * The Class RoleVO.
 *
 * @author ha.than
 */
public class RoleVO implements Serializable {

    /**
     * serialVersionUID.
     */
    private static final long serialVersionUID = 1L;
    
    /** The usr id. */
    private String usrId;
    
    /** The usr nm. */
    private String usrNm;
    
    /** The usr role cd. */
    private String usrRoleCd;
    
    /** The usr role abb. */
    private String usrRoleAbb;
    
    /** The usr role des. */
    private String usrRoleDes;

    /**
     * getUsrRoleCd.
     * @return String
     */
    public String getUsrRoleCd() {
	return this.usrRoleCd;
    }

    /**
     * setUsrRoleCd.
     *
     * @param usrRoleCd the new usr role cd
     */
    public void setUsrRoleCd(String usrRoleCd) {
	this.usrRoleCd = usrRoleCd;
    }

    /**
     * getUsrRoleAbb.
     * @return String
     */
    public String getUsrRoleAbb() {
	return this.usrRoleAbb;
    }

    /**
     * setUsrRoleAbb.
     *
     * @param usrRoleAbb the new usr role abb
     */
    public void setUsrRoleAbb(String usrRoleAbb) {
	this.usrRoleAbb = usrRoleAbb;
    }

    /**
     * getUsrRoleDes.
     * @return String
     */
    public String getUsrRoleDes() {
	return this.usrRoleDes;
    }

    /**
     * setUsrRoleDes.
     *
     * @param usrRoleDes the new usr role des
     */
    public void setUsrRoleDes(String usrRoleDes) {
	this.usrRoleDes = usrRoleDes;
    }

    /**
     * Gets the usr id.
     *
     * @return the usrId
     */
    public String getUsrId() {
	return this.usrId;
    }

    /**
     * Sets the usr id.
     *
     * @param usrId            the usrId to set
     */
    public void setUsrId(String usrId) {
	this.usrId = usrId;
    }

    /**
     * Gets the usr nm.
     *
     * @return the usrNm
     */
    public String getUsrNm() {
	return usrNm;
    }

    /**
     * Sets the usr nm.
     *
     * @param usrNm            the usrNm to set
     */
    public void setUsrNm(String usrNm) {
	this.usrNm = usrNm;
    }

}
