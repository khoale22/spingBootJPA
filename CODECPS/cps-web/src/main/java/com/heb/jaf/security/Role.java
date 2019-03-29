/*
 * $Id: Role.java,v 1.21 2015/03/12 11:15:10 vn44178 Exp $
 *
 * Copyright (c) 2010 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.jaf.security;

import org.springframework.security.core.GrantedAuthority;

/**
 * The Class Role.
 *
 * @author ha.than
 */
public class Role implements GrantedAuthority {
    /**
     * ROLE_PREFIX.
     */
    public static final String ROLE_PREFIX = "ROLE_";
    /**
     * serialVersionUID.
     */
    private static final long serialVersionUID = 1L;
    
    /** The role name. */
    private String roleName;
    
    /** The role desc. */
    private String roleDesc;
    
    /** The programmatically assigned. */
    private boolean programmaticallyAssigned = false;
    /**
     * Role.
     */
    public Role() {
    }

    /**
     * Role.
     * @param roleNamep
     *            String
     * @param roleDescp
     *            String
     */
    public Role(String roleNamep, String roleDescp) {
	this.roleName = roleNamep;
	this.roleDesc = roleDescp;
    }

    /* (non-Javadoc)
     * @see org.springframework.security.core.GrantedAuthority#getAuthority()
     */
    @Override
    public String getAuthority() {
	return ROLE_PREFIX + this.roleName;
    }

    /**
     * Sets the role name.
     *
     * @param roleName            the roleName to set
     */
    public void setRoleName(String roleName) {
	this.roleName = roleName;
    }

    /**
     * Gets the role name.
     *
     * @return the roleName
     */
    public String getRoleName() {
	return this.roleName;
    }

    /**
     * Sets the role desc.
     *
     * @param roleDesc            the roleDesc to set
     */
    public void setRoleDesc(String roleDesc) {
	this.roleDesc = roleDesc;
    }

    /**
     * Gets the role desc.
     *
     * @return the roleDesc
     */
    public String getRoleDesc() {
	return this.roleDesc;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result + ((this.roleDesc == null) ? 0 : this.roleDesc.hashCode());
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
	return "Role " + this.roleName + ": " + this.roleDesc;
    }

    /**
     * Checks if is programmatically assigned.
     *
     * @return the programmaticallyAssigned
     */
    public boolean isProgrammaticallyAssigned() {
	return programmaticallyAssigned;
    }

    /**
     * Sets the programmatically assigned.
     *
     * @param programmaticallyAssigned the programmaticallyAssigned to set
     */
    public void setProgrammaticallyAssigned(boolean programmaticallyAssigned) {
	this.programmaticallyAssigned = programmaticallyAssigned;
    }

}
