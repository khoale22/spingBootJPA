/*
 * $Id: UserInfoMapper.java,v 1.22 2015/03/13 08:02:05 vn55228 Exp $
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

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ldap.core.DirContextAdapter;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.ldap.userdetails.UserDetailsContextMapper;

import com.heb.jaf.util.Constants;
import com.heb.jaf.util.Helper;
import com.heb.jaf.vo.Resource;
import com.heb.jaf.vo.VendorOrg;
import com.heb.operations.cps.util.CPSHelper;

/**
 * The Class UserInfoMapper.
 *
 * @author ha.than
 */
public class UserInfoMapper implements UserDetailsContextMapper {

    /** The log. */
    Logger LOG = Logger.getLogger(UserInfoMapper.class);
    
    /** The heb ldap user search. */
    @Autowired
    private HebLdapUserSearch hebLdapUserSearch;

    /** The Constant MAIL. */
    public static final String MAIL = "mail";
    
    /** The Constant DEPARTMENT_NUMBER. */
    public static final String DEPARTMENT_NUMBER = "departmentNumber";
    
    /** The Constant HEB_JOB_DESC. */
    public static final String HEB_JOB_DESC = "hebJobDesc";
    
    /** The Constant HEB_JOB_CODE. */
    public static final String HEB_JOB_CODE = "hebJobCode";
    
    /** The Constant DISPLAY_NAME. */
    public static final String DISPLAY_NAME = "displayName";
    
    /** The Constant MOBILE. */
    // private static final String HEB_KEY = "!@#$%^";
    public static final String MOBILE = "mobile";
    
    /** The Constant CN. */
    public static final String CN = "cn";
    
    /** The Constant SN. */
    public static final String SN = "sn";
    
    /** The Constant SINQUO. */
    public static final String SINQUO = "'";
    
    /** The Constant COMMA. */
    public static final String COMMA = ",";
    
    /** The Constant GIVENNAME. */
    public static final String GIVENNAME = "givenName";
    
    /** The Constant HEBGLLOCATION. */
    public static final String HEBGLLOCATION = "hebGLlocation";
    
    /** The Constant TELEPHONENUMBER. */
    public static final String TELEPHONENUMBER = "telephoneNumber";
    
    /** The Constant BUSINESSCATEGORY. */
    public static final String BUSINESSCATEGORY = "businessCategory";
    
    /** The broker role. */
    private static String BROKER_ROLE = "broker";

    /** The heb authorities populator. */
    @Autowired
    private HebAuthoritiesPopulator hebAuthoritiesPopulator;

    /* (non-Javadoc)
     * @see org.springframework.security.ldap.userdetails.UserDetailsContextMapper#mapUserFromContext(org.springframework.ldap.core.DirContextOperations, java.lang.String, java.util.Collection)
     */
    @Override
    public UserDetails mapUserFromContext(DirContextOperations ctxLdap, String username, Collection<? extends GrantedAuthority> authorities) {
	// DirContextOperations ctxLdap =
	// hebLdapUserSearch.searchForUser(username);
	UserInfo retObj = new UserInfo(username, "cps12345", true, true, true, true, authorities);
	retObj.setDisplayName(ctxLdap.getStringAttribute(UserInfoMapper.DISPLAY_NAME));
	retObj.setHebJobCode(ctxLdap.getStringAttribute(UserInfoMapper.HEB_JOB_CODE));
	retObj.setHebJobDesc(ctxLdap.getStringAttribute(UserInfoMapper.HEB_JOB_DESC));
	retObj.setDepartmentNumber(ctxLdap.getStringAttribute(UserInfoMapper.DEPARTMENT_NUMBER));
	retObj.setMail(ctxLdap.getStringAttribute(UserInfoMapper.MAIL));
	retObj.setMobile(ctxLdap.getStringAttribute(UserInfoMapper.MOBILE));
	retObj.setHebGLlocation(ctxLdap.getStringAttribute(UserInfoMapper.HEBGLLOCATION));
	retObj.setCn(ctxLdap.getStringAttribute(UserInfoMapper.CN));
	retObj.setSn(ctxLdap.getStringAttribute(UserInfoMapper.SN));
	retObj.setGivenName(ctxLdap.getStringAttribute(UserInfoMapper.GIVENNAME));
	retObj.setUserName(username);
	retObj.setUid(username);
	// Set role in user role
	String ldapRole = ctxLdap.getStringAttribute(BUSINESSCATEGORY);
	if (ldapRole != null) {
	    retObj.setRole(Helper.getRole(ldapRole));
	} else {
	    retObj.setRole("N/A");
	}
	setMapStringAttribute(retObj, ctxLdap);
	if (Helper.isVendoPrefix(username)) {
	    setDefaultVendorOrgId(retObj);
	    this.setVendorOrgRole(retObj, ctxLdap);
//	    Set role UVEND or RVEND for vendor/Broker 
	    retObj.setUserRoles(CPSRolesBuilder.buildRoles(retObj));
	}else {
	    Map<String, Role> roleMapHeb = new HashMap<String, Role>();
	    if (!authorities.isEmpty()) {
		    for (GrantedAuthority grantedAuthority : authorities) {
			Role role = (Role) grantedAuthority;
			roleMapHeb.put(role.getRoleName(), role);
		    }
	    }
	    retObj.setUserRoles(roleMapHeb);
	}
	StringBuilder roleArr = new StringBuilder();
	Map<Integer, String> resourceMap = new HashMap<Integer, String>();
	if (!retObj.getUserRoles().isEmpty()) {
	    for (Map.Entry<String, Role> roleUser : retObj.getUserRoles().entrySet()) {
		Role role = (Role) roleUser.getValue();
		roleArr = roleArr.append(SINQUO).append(role.getRoleName()).append(SINQUO).append(COMMA);
	    }
	    if (roleArr.length() > 0) {
		Map<String, Resource> mapResource = this.hebAuthoritiesPopulator.getAllResourceByRoles(roleArr.substring(0, roleArr.length() - 1), username, retObj.getHebJobCode());
		retObj.setUserResources(mapResource);
		for (Map.Entry<String, Resource> resMap : mapResource.entrySet()) {
		    resourceMap.put(Integer.parseInt(resMap.getKey()), resMap.getValue().getAccessType().getAccessTypeCd());
		}
	    }
	}
	retObj.setResourceMap(resourceMap);
	return retObj;
    }

    /**
     * Sets the vendor org role.
     * @author ha.than
     * @param retObj the ret obj
     * @param ctxLdap the ctx ldap
     */
    public void setVendorOrgRole(UserInfo retObj,DirContextOperations ctxLdap) {
	List<VendorOrg> vendors = hebLdapUserSearch.getVendorOrganizationNames(ctxLdap);
	String role = null;
	if (CPSHelper.isNotEmpty(vendors) && (vendors.size() == 1)) {
	    VendorOrg vendor = vendors.get(0);
	    String vendorName = vendor.getVendorOrgName();
	    retObj.setVendorOrgName(vendorName);
	    retObj.setVendorOrgId(vendor.getVendorOrgId());
	    role = Constants.VENDOR_ROLE_KEY;
	} else if (CPSHelper.isNotEmpty(vendors) && (vendors.size() > 1)) {
	    retObj.setVendorOrgs(vendors);
	    role = Constants.BROKER_ROLE_KEY;
	} else {
	    retObj.setVendorOrgName("No Vendor");
	    retObj.setVendorOrgId("XXXXX");
	    role = Constants.VENDOR_ROLE_KEY;
	}
	if ("N/A".equalsIgnoreCase(retObj.getRole())) {
	    retObj.setRole(role);
	} else {
	    if (BROKER_ROLE.equalsIgnoreCase(retObj.getRole())) {
		retObj.setRole(Constants.BROKER_ROLE_KEY);
	    } else {
		retObj.setRole(Constants.VENDOR_ROLE_KEY);
	    }
	}
    }

    /**
     * Sets the map string attribute.
     * @author ha.than
     * @param arg0 the arg0
     * @param ctxLdap the ctx ldap
     */
    public static void setMapStringAttribute(UserInfo arg0, DirContextOperations ctxLdap) {
	Map<String, String> retObj = new HashMap<String, String>();
	retObj.put(UserInfoMapper.DISPLAY_NAME, ctxLdap.getStringAttribute(UserInfoMapper.DISPLAY_NAME));
	retObj.put(UserInfoMapper.HEB_JOB_CODE, ctxLdap.getStringAttribute(UserInfoMapper.HEB_JOB_CODE));
	retObj.put(UserInfoMapper.HEB_JOB_DESC, ctxLdap.getStringAttribute(UserInfoMapper.HEB_JOB_DESC));
	retObj.put(UserInfoMapper.DEPARTMENT_NUMBER, ctxLdap.getStringAttribute(UserInfoMapper.DEPARTMENT_NUMBER));
	retObj.put(UserInfoMapper.MAIL, ctxLdap.getStringAttribute(UserInfoMapper.MAIL));
	retObj.put(UserInfoMapper.MOBILE, ctxLdap.getStringAttribute(UserInfoMapper.MOBILE));
	retObj.put(UserInfoMapper.HEBGLLOCATION, ctxLdap.getStringAttribute(UserInfoMapper.HEBGLLOCATION));
	retObj.put(UserInfoMapper.CN, ctxLdap.getStringAttribute(UserInfoMapper.CN));
	retObj.put(UserInfoMapper.SN, ctxLdap.getStringAttribute(UserInfoMapper.SN));
	retObj.put(UserInfoMapper.GIVENNAME, ctxLdap.getStringAttribute(UserInfoMapper.GIVENNAME));
	retObj.put(UserInfoMapper.DISPLAY_NAME, ctxLdap.getStringAttribute(UserInfoMapper.DISPLAY_NAME));
	retObj.put(UserInfoMapper.TELEPHONENUMBER, ctxLdap.getStringAttribute(UserInfoMapper.TELEPHONENUMBER));
	arg0.setAttributeValueMap(retObj);
    }
    
    /**
     * Sets the default vendor org id.
     * @author ha.than
     * @param arg0 the new default vendor org id
     */
    public static void setDefaultVendorOrgId(UserInfo arg0) {
	arg0.setVendorOrgId("000XXXXX");
    }
    
    /* (non-Javadoc)
     * @see org.springframework.security.ldap.userdetails.UserDetailsContextMapper#mapUserToContext(org.springframework.security.core.userdetails.UserDetails, org.springframework.ldap.core.DirContextAdapter)
     */
    @Override
    public void mapUserToContext(UserDetails arg0, DirContextAdapter arg1) {
    }

}
