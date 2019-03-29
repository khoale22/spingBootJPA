/*
 * $Id: HebLdapUserSearch.java,v 1.21 2015/03/12 11:15:10 vn44178 Exp $
 *
 * Copyright (c) 2010 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.jaf.security;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.ldap.CommunicationException;
import org.springframework.ldap.core.AttributesMapper;
import org.springframework.ldap.core.ContextSource;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.ldap.core.NameAwareAttribute;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.ldap.SpringSecurityLdapTemplate;
import org.springframework.security.ldap.search.LdapUserSearch;

import com.heb.jaf.util.Constants;
import com.heb.jaf.util.Helper;
import com.heb.jaf.vo.VendorOrg;

/**
 * The Class HebLdapUserSearch.
 *
 * @author ha.than
 */
public class HebLdapUserSearch implements LdapUserSearch {

    /** The log. */
    Logger LOG = Logger.getLogger(HebLdapUserSearch.class);

    /** The ctx. */
    private ContextSource ctx;

    /** The ctx vendor. */
    private ContextSource ctxVendor;
    /** The search base pattern. */
    private String searchBasePattern;

    /** The search filter. */
    private String searchFilter;

    /** The search base pattern vendor. */
    @Value("${security.ldap.heb.vendor.searchbase}")
    private String searchBasePatternVendor = "";

    /**
     * HebLdapUserSearch.
     */
    public HebLdapUserSearch() {
    }

    /**
     * Instantiates a new heb ldap user search.
     *
     * @param ctxi
     *            ContextSource
     */
    public HebLdapUserSearch(ContextSource ctxi) {
	this.ctx = ctxi;
    }

    /**
     * Instantiates a new heb ldap user search.
     *
     * @param ctxi
     *            the ctxi
     * @param ctxi2
     *            the ctxi2
     */
    public HebLdapUserSearch(ContextSource ctxi, ContextSource ctxi2) {
	this.ctx = ctxi;
	this.ctxVendor = ctxi2;
    }

    /*
     * (non-Javadoc)
     * @see
     * org.springframework.security.ldap.search.LdapUserSearch#searchForUser(
     * java.lang.String)
     * @author ha.than
     */
    @Override
    public DirContextOperations searchForUser(String username) throws UsernameNotFoundException {
	SpringSecurityLdapTemplate ldap = null;
	ContextSource ctxTemp = null;
	String searchBasePatternTemp = "";
	if (Helper.isVendoPrefix(username)) {
	    ctxTemp = this.getCtxVendor();
	    searchBasePatternTemp = searchBasePatternVendor;
	} else {
	    ctxTemp = this.getCtx();
	    searchBasePatternTemp = this.searchBasePattern;
	}
	DirContextOperations retObj = null;
	try {
	    ldap = new SpringSecurityLdapTemplate(ctxTemp);
	    retObj = ldap.searchForSingleEntry(searchBasePatternTemp, this.searchFilter, new Object[] { username });
	} catch (IncorrectResultSizeDataAccessException e) {
	    LOG.error("Username not found------------");
	    throw new UsernameNotFoundException("Username not found");
	} catch (CommunicationException e){
	    LOG.error("Failed connect to LDAP------------"+e.getMessage());
	    throw new UsernameNotFoundException("Failed connect to LDAP:"+ e.getMessage());
	} catch (Exception e) {
	    LOG.error("Error Ocur in searchForUser ------------" + e);
	    throw new UsernameNotFoundException("Failed connect to LDAP:"+ e.getMessage());
	}
	return retObj;
    }

    /**
     * Gets the vendor organization names.
     * @author ha.than
     * @param ctxo
     *            the ctxo
     * @return the vendor organization names
     */
    public List<VendorOrg> getVendorOrganizationNames(DirContextOperations ctxo) {
	List<VendorOrg> lstVendor = null;
	Enumeration vendorList = null;
	if (null != ctxo && null != ctxo.getAttributes() && ctxo.getAttributes().size() > 0) {
	    NamingEnumeration<Attribute> arrAttribute = (NamingEnumeration<Attribute>) ctxo.getAttributes().getAll();
	    if (arrAttribute != null) {
		for (Enumeration enumAttrs = arrAttribute; enumAttrs.hasMoreElements();) {
		    NameAwareAttribute nameAwareAttribute = (NameAwareAttribute) enumAttrs.nextElement();
		    if (Constants.MEMBER_OF_ATTR_NAME.equals(nameAwareAttribute.getID()) && nameAwareAttribute.getAll() != null) {
			vendorList = nameAwareAttribute.getAll();
			break;
		    }
		}
	    }
	    if (null != vendorList) {
		lstVendor = getVendorOrgNames(vendorList);
	    }
	}
	return lstVendor;
    }

    /**
     * Gets the vendor org names.
     * @author ha.than
     * @param aVendorOrgIds
     *            the a vendor org ids
     * @return the vendor org names
     */
    public List<VendorOrg> getVendorOrgNames(Enumeration aVendorOrgIds) {
	SpringSecurityLdapTemplate ldap = null;
	int counter;
	StringBuilder filter = new StringBuilder();
	List<VendorOrg> listVendorOrgs = new ArrayList<VendorOrg>();
	boolean bFirst = true;
	for (counter = 0; aVendorOrgIds.hasMoreElements(); counter++) {
	    String vendorApNumber = (String) aVendorOrgIds.nextElement();
	    if (vendorApNumber != null && vendorApNumber.length() != 8)
		vendorApNumber = Helper.getVendorOrgId(vendorApNumber);
	    if (bFirst) {
		filter.append("(|(ou=").append(vendorApNumber).append(")");
		bFirst = false;
	    } else {
		filter.append("(ou=").append(vendorApNumber).append(")");
	    }
	}
	filter.append(")");
	String filterStr = filter.toString();
	if (counter == 1 && filterStr.length() > 1)
	    filterStr = filterStr.substring(2, filterStr.length() - 1);
	ldap = new SpringSecurityLdapTemplate(this.getCtxVendor());
//	we will find out resolution with base name
	List<VendorOrg> listEnum = ldap.search("", filterStr, 2, new AttributesMapperVendor());
	Map<String, String> currentVendors = new HashMap<String, String>();
	if (null != listEnum) {
	    for (VendorOrg vendorOrg : listEnum) {
		if (!currentVendors.containsKey(vendorOrg.getVendorOrgId())) {
		    currentVendors.put(vendorOrg.getVendorOrgId(), vendorOrg.getVendorOrgId());
		    listVendorOrgs.add(vendorOrg);
		}
	    }
	}
	return listEnum;
    }

    /**
     * The Class AttributesMapperVendor.
     * @author ha.than
     */
    private class AttributesMapperVendor implements AttributesMapper<VendorOrg> {

	/*
	 * (non-Javadoc)
	 * @see
	 * org.springframework.ldap.core.AttributesMapper#mapFromAttributes(
	 * javax.naming.directory.Attributes)
	 */
	public VendorOrg mapFromAttributes(Attributes attrs) throws NamingException, javax.naming.NamingException {
	    VendorOrg vendor = new VendorOrg();
	    Attribute ldapUid = attrs.get("ou");
	    Attribute ldapAttribute = attrs.get(Constants.VENDOR_ORGANIZATION_NAME_FIELD);
	    String uid = null;
	    String vendorOrgName = null;
	    if (ldapUid != null) {
		Enumeration values = ldapUid.getAll();
		if (values != null)
		    while (values.hasMoreElements())
			uid = (String) values.nextElement();
	    }
	    if (ldapAttribute != null) {
		Enumeration values = ldapAttribute.getAll();
		if (values != null && values.hasMoreElements())
		    vendorOrgName = (String) values.nextElement();
	    }
	    vendor.setVendorOrgId(uid);
	    if (vendorOrgName == null) {
		vendor.setVendorOrgName("Unknown Vendor Name");
	    } else {
		vendor.setVendorOrgName(vendorOrgName);
	    }
	    return vendor;
	}
    }

    /**
     * Sets the ctx.
     *
     * @param ctx
     *            the ctx to set
     */
    public void setCtx(ContextSource ctx) {
	this.ctx = ctx;
    }

    /**
     * Gets the ctx.
     *
     * @return the ctx
     */
    public ContextSource getCtx() {
	return this.ctx;
    }

    /**
     * Sets the search base pattern.
     *
     * @param searchDnPattern
     *            the searchDnPattern to set
     */
    public void setSearchBasePattern(String searchDnPattern) {
	this.searchBasePattern = searchDnPattern;
    }

    /**
     * Gets the search base pattern.
     *
     * @return the searchDnPattern
     */
    public String getSearchBasePattern() {
	return this.searchBasePattern;
    }

    /**
     * Sets the search filter.
     *
     * @param searchFilter
     *            the searchFilter to set
     */
    public void setSearchFilter(String searchFilter) {
	this.searchFilter = searchFilter;
    }

    /**
     * Gets the search filter.
     *
     * @return the searchFilter
     */
    public String getSearchFilter() {
	return this.searchFilter;
    }

    /**
     * Gets the ctx vendor.
     *
     * @return the ctx2
     */
    public ContextSource getCtxVendor() {
	return ctxVendor;
    }

    /**
     * Sets the ctx2.
     *
     * @param ctxVendor
     *            the new ctx2
     */
    public void setCtx2(ContextSource ctxVendor) {
	this.ctxVendor = ctxVendor;
    }

}
