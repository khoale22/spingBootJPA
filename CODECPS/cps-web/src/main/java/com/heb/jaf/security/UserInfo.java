/*
 * $Id: UserInfo.java,v 1.22 2016/01/12 11:15:10 vn70529 Exp $
 *
 * Copyright (c) 2010 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.jaf.security;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.heb.jaf.util.Constants;
import com.heb.jaf.vo.Resource;
import com.heb.jaf.vo.RoleVO;

/**
 * The Class UserInfo.
 *
 * @author ha.than
 */
public class UserInfo extends User {

    /**
     * serialVersionUID.
     */
    private static final long serialVersionUID = 1L;
    
    /** The display name. */
    private String displayName;
    
    /** The heb job code. */
    private String hebJobCode;
    
    /** The heb job desc. */
    private String hebJobDesc;
    
    /** The department number. */
    private String departmentNumber;
    
    /** The mail. */
    private String mail;
    
    /** The role. */
    private String role;
    
    /** The mobile. */
    private String mobile;
    
    /** The vendor org id. */
    // Valid only for vendors
    private String vendorOrgId;
    
    /** The vendor org name. */
    private String vendorOrgName;
    
    /** The heb g llocation. */
    private String hebGLlocation;
    
    /** The test. */
    private String test;
    
    /** The sn. */
    private String sn;
    
    /** The cn. */
    private String cn;
    
    /** The role v os. */
    private List<RoleVO> roleVOs;

    /** The user roles. */
    // user from jaf jar
    private Map<String, Role> userRoles;
    
    /** The user resources. */
    private Map<String, Resource> userResources;
    
    /** The Resource map. */
    private Map<Integer, String> ResourceMap;
    
    /** The vendor orgs. */
    private List vendorOrgs;
    
    /** The user name. */
    private String userName;
    
    /** The uid. */
    private String uid;
    
    /** The given name. */
    private String givenName;
    
    /** The attribute value map. */
    Map<String, String> attributeValueMap = new HashMap<String, String>();
    
    /**
     * Gets the attribute value map.
     *
     * @return the getAttributeValueMap
     */
    public Map<String, String> GetAttributeValueMap() {
        return attributeValueMap;
    }

    /**
     * Sets the attribute value map.
     *
     * @param attributeValueMap the attribute value map
     */
    public void setAttributeValueMap(Map<String, String> attributeValueMap) {
        this.attributeValueMap = attributeValueMap;
    }

    /**
     * UserInfo.
     * @param username
     *            String
     * @param password
     *            String
     * @param enabled
     *            boolean
     * @param accountNonExpired
     *            boolean
     * @param credentialsNonExpired
     *            boolean
     * @param accountNonLocked
     *            boolean
     * @param authorities
     *            Collection<? extends GrantedAuthority>
     */
    public UserInfo(String username, String password, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked,
	    Collection<? extends GrantedAuthority> authorities) {
	super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
    }

    /**
     * Gets the test.
     *
     * @return the test
     */
    public String getTest() {
	return this.test;
    }

    /**
     * Sets the test.
     *
     * @param test the new test
     */
    public void setTest(String test) {
	this.test = test;
    }

    /**
     * Sets the display name.
     *
     * @param displayName            the displayName to set
     */
    public void setDisplayName(String displayName) {
	this.displayName = displayName;
    }

    /**
     * Gets the display name.
     *
     * @return the displayName
     */
    public String getDisplayName() {
	return this.displayName;
    }

    /**
     * Sets the heb job code.
     *
     * @param hebJobCode            the hebJobCode to set
     */
    public void setHebJobCode(String hebJobCode) {
	this.hebJobCode = hebJobCode;
    }

    /**
     * Gets the heb job code.
     *
     * @return the hebJobCode
     */
    public String getHebJobCode() {
	return this.hebJobCode;
    }

    /**
     * Sets the heb job desc.
     *
     * @param hebJobDesc            the hebJobDesc to set
     */
    public void setHebJobDesc(String hebJobDesc) {
	this.hebJobDesc = hebJobDesc;
    }

    /**
     * Gets the heb job desc.
     *
     * @return the hebJobDesc
     */
    public String getHebJobDesc() {
	return this.hebJobDesc;
    }

    /**
     * Sets the mail.
     *
     * @param mail            the mail to set
     */
    public void setMail(String mail) {
	this.mail = mail;
    }

    /**
     * Gets the mail.
     *
     * @return the mail
     */
    public String getMail() {
	return this.mail;
    }

    /**
     * Sets the role.
     *
     * @param role            the role to set
     */
    public void setRole(String role) {
	this.role = role;
    }

    /**
     * Gets the role.
     *
     * @return the role
     */
    public String getRole() {
	return this.role;
    }

    /**
     * Sets the vendor org id.
     *
     * @param vendorOrgId            the vendorOrgId to set
     */
    public void setVendorOrgId(String vendorOrgId) {
	this.vendorOrgId = vendorOrgId;
    }

    /**
     * Gets the vendor org id.
     *
     * @return the vendorOrgId
     */
    public String getVendorOrgId() {
	return this.vendorOrgId;
    }

    /**
     * Sets the vendor org name.
     *
     * @param vendorOrgName            the vendorOrgName to set
     */
    public void setVendorOrgName(String vendorOrgName) {
	this.vendorOrgName = vendorOrgName;
    }

    /**
     * Gets the vendor org name.
     *
     * @return the vendorOrgName
     */
    public String getVendorOrgName() {
	return this.vendorOrgName;
    }

    /**
     * Sets the department number.
     *
     * @param departmentNumber            the departmentNumber to set
     */
    public void setDepartmentNumber(String departmentNumber) {
	this.departmentNumber = departmentNumber;
    }

    /**
     * Gets the department number.
     *
     * @return the departmentNumber
     */
    public String getDepartmentNumber() {
	return this.departmentNumber;
    }

    /**
     * Sets the mobile.
     *
     * @param mobile            the mobile to set
     */
    public void setMobile(String mobile) {
	this.mobile = mobile;
    }

    /**
     * Gets the mobile.
     *
     * @return the mobile
     */
    public String getMobile() {
	return this.mobile;
    }

    /**
     * Sets the heb g llocation.
     *
     * @param hebGLlocation            the hebGLlocation to set
     */
    public void setHebGLlocation(String hebGLlocation) {
	this.hebGLlocation = hebGLlocation;
    }

    /**
     * Gets the heb g llocation.
     *
     * @return the hebGLlocation
     */
    public String getHebGLlocation() {
	return this.hebGLlocation;
    }

    /**
     * Gets the sn.
     *
     * @return the sn
     */
    public String getSn() {
	return sn;
    }

    /**
     * Sets the sn.
     *
     * @param sn the new sn
     */
    public void setSn(String sn) {
	this.sn = sn;
    }

    /**
     * Gets the cn.
     *
     * @return the cn
     */
    public String getCn() {
	return cn;
    }

    /**
     * Sets the cn.
     *
     * @param cn the new cn
     */
    public void setCn(String cn) {
	this.cn = cn;
    }

    /**
     * Gets the role v os.
     *
     * @return the role v os
     */
    public List<RoleVO> getRoleVOs() {
	return roleVOs;
    }

    /**
     * Sets the role v os.
     *
     * @param roleVOs the new role v os
     */
    public void setRoleVOs(List<RoleVO> roleVOs) {
	this.roleVOs = roleVOs;
    }

    /**
     * check if can edit invoice match.
     *
     * @author ha.than
     * @return true, if successful
     */
    public boolean canEditInvoiceMatch() {
	Collection<GrantedAuthority> authorities = this.getAuthorities();
	boolean isEditable = false;
	// authorities always not null.
	for (GrantedAuthority ga : authorities) {
	    if (ga.getAuthority().equals(Constants.HEB_ACCOUNTING_ROLE) || ga.getAuthority().equals(Constants.HEB_ADMINISTRATOR_ROLE) || ga.getAuthority().equals(Constants.HEB_ADMIN_ROLE)) {
		isEditable = true;
		break;
	    }
	}
	return isEditable;
    }

    /**
     * check if can edit user access page.
     *
     * @author ha.than
     * @return true, if successful
     */
    public boolean canEditUserAcccess() {
	Collection<GrantedAuthority> authorities = this.getAuthorities();
	boolean isEditable = false;
	// authorities always not null.
	for (GrantedAuthority ga : authorities) {
	    if (ga.getAuthority().equals(Constants.HEB_ADMINISTRATOR_ROLE) || ga.getAuthority().equals(Constants.HEB_ADMIN_ROLE)) {
		isEditable = true;
		break;
	    }
	}
	return isEditable;
    }

    /**
     * Gets the user roles.
     *
     * @return the userRoles
     */
    public Map<String, Role> getUserRoles() {
	return userRoles;
    }

    /**
     * Sets the user roles.
     *
     * @param userRoles            the userRoles to set
     */
    public void setUserRoles(Map<String, Role> userRoles) {
	this.userRoles = userRoles;
    }

    /**
     * Gets the user resources.
     *
     * @return the userResources
     */
    public Map<String, Resource> getUserResources() {
	return userResources;
    }

    /**
     * Sets the user resources.
     *
     * @param userResources            the userResources to set
     */
    public void setUserResources(Map<String, Resource> userResources) {
	this.userResources = userResources;
    }

    /**
     * Gets the vendor orgs.
     *
     * @return the vendorOrgs
     */
    public List getVendorOrgs() {
	return vendorOrgs;
    }

    /**
     * Sets the vendor orgs.
     *
     * @param vendorOrgs            the vendorOrgs to set
     */
    public void setVendorOrgs(List vendorOrgs) {
	this.vendorOrgs = vendorOrgs;
    }

    /**
     * Gets the user name.
     *
     * @return the userName
     */
    public String getUserName() {
	return userName;
    }

    /**
     * Sets the user name.
     *
     * @param userName            the userName to set
     */
    public void setUserName(String userName) {
	this.userName = userName;
    }

    /**
     * Gets the resource map.
     *
     * @return the resourceMap
     */
    public Map<Integer, String> getResourceMap() {
	return ResourceMap;
    }

    /**
     * Sets the resource map.
     *
     * @param resourceMap            the resourceMap to set
     */
    public void setResourceMap(Map<Integer, String> resourceMap) {
	ResourceMap = resourceMap;
    }

    /**
     * Gets the uid.
     *
     * @return the uid
     */
    public String getUid() {
	return uid;
    }

    /**
     * Sets the uid.
     *
     * @param uid            the uid to set
     */
    public void setUid(String uid) {
	this.uid = uid;
    }

    /**
     * Gets the attribute value.
     *
     * @param attribute the attribute
     * @return the attribute value
     */
    public String getAttributeValue(String attribute) {
	return GetAttributeValueMap().get(attribute);
    }

    /**
     * Gets the given name.
     *
     * @return the givenName
     */
    public String getGivenName() {
	return givenName;
    }

    /**
     * Sets the given name.
     *
     * @param givenName the givenName to set
     */
    public void setGivenName(String givenName) {
	this.givenName = givenName;
    }

}
