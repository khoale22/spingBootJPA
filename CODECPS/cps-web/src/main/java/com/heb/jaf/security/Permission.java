/*
 * $Id: Permission.java,v 1.21 2015/03/12 11:15:10 vn44178 Exp $
 *
 * Copyright (c) 2010 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.jaf.security;

import java.util.Date;

import org.springframework.security.core.GrantedAuthority;

/**
 * The Class Permission.
 *
 * @author ha.than
 */
public class Permission implements GrantedAuthority {
    /**
     * RESC_PREFIX.
     */
    public static final String RESC_PREFIX = "RESC_";
    /**
     * ACTION_PREFIX.
     */
    public static final String ACTION_PREFIX = "_ACTION_";
    /**
     * serialVersionUID.
     */
    private static final long serialVersionUID = 1L;
    
    /** The resc name. */
    private String rescName;
    
    /** The resc def. */
    private String rescDef;
    
    /** The resc scrn nm. */
    private String rescScrnNm;
    
    /** The resc type abb. */
    private String rescTypeAbb;
    
    /** The resc type desc. */
    private String rescTypeDesc;
    
    /** The access type abb. */
    private String accessTypeAbb;
    
    /** The access type desc. */
    private String accessTypeDesc;
    
    /** The dt eff. */
    private Date dtEff;
    
    /** The dt exp. */
    private Date dtExp;

    /* (non-Javadoc)
     * @see org.springframework.security.core.GrantedAuthority#getAuthority()
     */
    @Override
    public String getAuthority() {
	return Permission.RESC_PREFIX + this.rescName + Permission.ACTION_PREFIX + this.accessTypeAbb;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result + ((this.accessTypeAbb == null) ? 0 : this.accessTypeAbb.hashCode());
	return result;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object obj) {
	if (obj instanceof GrantedAuthority) {
	    return ((GrantedAuthority) obj).getAuthority().equals(this.getAuthority());
	}
	return false;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
	return "Permission: " + this.accessTypeDesc + " " + this.rescDef;
    }

    /**
     * Sets the resc name.
     *
     * @param rescName            the rescName to set
     */
    public void setRescName(String rescName) {
	this.rescName = rescName;
    }

    /**
     * Gets the resc name.
     *
     * @return the rescName
     */
    public String getRescName() {
	return this.rescName;
    }

    /**
     * Sets the resc def.
     *
     * @param rescDef            the rescDef to set
     */
    public void setRescDef(String rescDef) {
	this.rescDef = rescDef;
    }

    /**
     * Gets the resc def.
     *
     * @return the rescDef
     */
    public String getRescDef() {
	return this.rescDef;
    }

    /**
     * Sets the resc scrn nm.
     *
     * @param rescScrnNm            the rescScrnNm to set
     */
    public void setRescScrnNm(String rescScrnNm) {
	this.rescScrnNm = rescScrnNm;
    }

    /**
     * Gets the resc scrn nm.
     *
     * @return the rescScrnNm
     */
    public String getRescScrnNm() {
	return this.rescScrnNm;
    }

    /**
     * Sets the resc type abb.
     *
     * @param rescTypeAbb            the rescTypeAbb to set
     */
    public void setRescTypeAbb(String rescTypeAbb) {
	this.rescTypeAbb = rescTypeAbb;
    }

    /**
     * Gets the resc type abb.
     *
     * @return the rescTypeAbb
     */
    public String getRescTypeAbb() {
	return this.rescTypeAbb;
    }

    /**
     * Sets the resc type desc.
     *
     * @param rescTypeDesc            the rescTypeDesc to set
     */
    public void setRescTypeDesc(String rescTypeDesc) {
	this.rescTypeDesc = rescTypeDesc;
    }

    /**
     * Gets the resc type desc.
     *
     * @return the rescTypeDesc
     */
    public String getRescTypeDesc() {
	return this.rescTypeDesc;
    }

    /**
     * Sets the access type abb.
     *
     * @param accessTypeAbb            the accessTypeAbb to set
     */
    public void setAccessTypeAbb(String accessTypeAbb) {
	this.accessTypeAbb = accessTypeAbb;
    }

    /**
     * Gets the access type abb.
     *
     * @return the accessTypeAbb
     */
    public String getAccessTypeAbb() {
	return this.accessTypeAbb;
    }

    /**
     * Sets the access type desc.
     *
     * @param accessTypeDesc            the accessTypeDesc to set
     */
    public void setAccessTypeDesc(String accessTypeDesc) {
	this.accessTypeDesc = accessTypeDesc;
    }

    /**
     * Gets the access type desc.
     *
     * @return the accessTypeDesc
     */
    public String getAccessTypeDesc() {
	return this.accessTypeDesc;
    }

    /**
     * Sets the dt eff.
     *
     * @param dtEff            the dtEff to set
     */
    public void setDtEff(Date dtEff) {
	this.dtEff = dtEff;
    }

    /**
     * Gets the dt eff.
     *
     * @return the dtEff
     */
    public Date getDtEff() {
	return this.dtEff;
    }

    /**
     * Sets the dt exp.
     *
     * @param dtExp            the dtExp to set
     */
    public void setDtExp(Date dtExp) {
	this.dtExp = dtExp;
    }

    /**
     * Gets the dt exp.
     *
     * @return the dtExp
     */
    public Date getDtExp() {
	return this.dtExp;
    }

}
