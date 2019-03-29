/*
 * $Id: HebLdapUserService.java,v 1.21 2015/03/12 11:15:10 vn44178 Exp $
 *
 * Copyright (c) 2010 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.jaf.security;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;
import javax.naming.directory.Attributes;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.ldap.core.AttributesMapper;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.ldap.query.LdapQuery;
import org.springframework.ldap.query.LdapQueryBuilder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.ldap.search.LdapUserSearch;
import org.springframework.security.ldap.userdetails.LdapAuthoritiesPopulator;
import org.springframework.security.ldap.userdetails.UserDetailsContextMapper;

import com.heb.jaf.util.Constants;
import com.heb.jaf.util.Helper;
import com.heb.jaf.vo.RoleVO;
import com.heb.jaf.vo.UserVO;
import com.heb.operations.cps.util.CPSHelper;

/**
 * The Class HebLdapUserService.
 *
 * @author ha.than
 */
public class HebLdapUserService implements UserDetailsService {

     /** The Constant LOG. */
     private static final Logger LOG = Logger.getLogger(HebLdapUserService.class);

    /** The user finders. */
    private List<LdapUserSearch> userFinders;
    
    /** The user mapper. */
    private UserDetailsContextMapper userMapper;
    
    /** The auth populator. */
    private LdapAuthoritiesPopulator authPopulator;

    /** The ldap template. */
    @Autowired
    private LdapTemplate ldapTemplate;

    /** The heb authorities populator. */
    @Autowired
    private HebAuthoritiesPopulator hebAuthoritiesPopulator;

    /** The base. */
    @Value("${security.ldap.heb.base}")
    private String base;

    /** The filter format. */
    @Value("(|(uid={0}*)(displayName=*{1}*)(cn=*{2}*))")
    private String filterFormat;
    Map<String,UserDetails> mapCacheUser = new HashMap<String, UserDetails>();
    /**
     * Gets the user info.
     *
     * @author ha.than
     * @param username the username
     * @return the user info
     * @throws UsernameNotFoundException the username not found exception
     * @throws DataAccessException the data access exception
     */
    public UserDetails getUserInfo(String username) throws UsernameNotFoundException, DataAccessException {
	if(mapCacheUser.containsKey(username)){
	    return mapCacheUser.get(username);
	}
	DirContextOperations ldapUser = null;
	// Try to search each ldap server for the user
	for (LdapUserSearch finder : this.getUserFinders()) {
	    try {
		ldapUser = finder.searchForUser(username);
		if (ldapUser != null) {
		    break;
		}
	    } catch (UsernameNotFoundException e) {
		LOG.error("User not found on any of the specified ldap contexts");
	    }
	}

	if (ldapUser == null) {
	    throw new UsernameNotFoundException("User not found on any of the specified ldap contexts");
	}
	// Populate with permissions
	Collection<? extends GrantedAuthority> authorities = this.getAuthPopulator().getGrantedAuthorities(ldapUser, username);
	// Set the fields from ldap
	UserInfo retObj = new UserInfo(username, "cps12345", true, true, true, true, authorities);
	retObj.setDisplayName(ldapUser.getStringAttribute(UserInfoMapper.DISPLAY_NAME));
	retObj.setHebJobCode(ldapUser.getStringAttribute(UserInfoMapper.HEB_JOB_CODE));
	retObj.setHebJobDesc(ldapUser.getStringAttribute(UserInfoMapper.HEB_JOB_DESC));
	retObj.setDepartmentNumber(ldapUser.getStringAttribute(UserInfoMapper.DEPARTMENT_NUMBER));
	retObj.setMail(ldapUser.getStringAttribute(UserInfoMapper.MAIL));
	retObj.setMobile(ldapUser.getStringAttribute(UserInfoMapper.MOBILE));
	retObj.setHebGLlocation(ldapUser.getStringAttribute(UserInfoMapper.HEBGLLOCATION));
	retObj.setCn(ldapUser.getStringAttribute(UserInfoMapper.CN));
	retObj.setSn(ldapUser.getStringAttribute(UserInfoMapper.SN));
	retObj.setUserName(username);
	retObj.setUid(username);
	retObj.setGivenName(CPSHelper.getTrimmedValue(ldapUser.getStringAttribute(UserInfoMapper.GIVENNAME)));
	UserInfoMapper.setMapStringAttribute(retObj, ldapUser);
	mapCacheUser.put(username, retObj);
	return retObj;
    }
    
    /**
     * Load user by username.
     *
     * @author ha.than
     * @param username the username
     * @return the user details
     * @throws UsernameNotFoundException the username not found exception
     * @throws DataAccessException the data access exception
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {
	DirContextOperations ldapUser = null;
	// Try to search each ldap server for the user
	for (LdapUserSearch finder : this.getUserFinders()) {
	    try {
		ldapUser = finder.searchForUser(username);
		if (ldapUser != null) {
		    break;
		}
	    } catch (UsernameNotFoundException e) {
		e.printStackTrace();
	    }
	}

	if (ldapUser == null) {
	    throw new UsernameNotFoundException("User not found on any of the specified ldap contexts");
	}
	// Populate with permissions
	Collection<? extends GrantedAuthority> authorities = this.getAuthPopulator().getGrantedAuthorities(ldapUser, username);
	// Set the fields from ldap
	UserDetails retObj = this.getUserMapper().mapUserFromContext(ldapUser, username, authorities);
	return retObj;
    }
    
    /**
     * searchUsers.
     *
     * @author ha.than
     * @param searchContent            :String
     * @return List<UserDetails>
     */
    public List<UserVO> searchForUsers(String searchContent) {
	MessageFormat messageFormat = new MessageFormat(this.filterFormat);
	LdapQuery query = LdapQueryBuilder.query().base(this.base).filter(messageFormat.format(new Object[] { searchContent, searchContent, searchContent }));
	List<UserVO> userVOs = this.ldapTemplate.search(query, new UserDetailAttributesMapper());
	List<String> lstStr = new ArrayList<String>();
	for (UserVO userVO : userVOs) {
	    lstStr.add(StringUtils.upperCase(userVO.getUserId()));
	}
	Map<String, List<RoleVO>> roleVOMap = this.hebAuthoritiesPopulator.getMultipleRoles(lstStr);
	if (!roleVOMap.isEmpty()) {
	    for (UserVO userVO : userVOs) {
	    	userVO.setLstRoleVO(roleVOMap.get(StringUtils.upperCase(userVO.getUserId())));
	    }
	}

	return userVOs;
    }
    /**
     * UserDetailAttributesMapper.
     * @author ha.than
     */
    private class UserDetailAttributesMapper implements AttributesMapper<UserVO> {
	
	/**
	 * mapFromAttributes.
	 *
	 * @author ha.than
	 * @param attrs            Attributes
	 * @return UserVO
	 * @throws NamingException             NamingException
	 * @throws NamingException             NamingException
	 */
	public UserVO mapFromAttributes(Attributes attrs) throws NamingException, javax.naming.NamingException {
	    UserVO userVO = new UserVO();
	    userVO.setUserId((String) attrs.get(Constants.LDAP_ATTRIBUTE_UID).get());
	    userVO.setUserName(Helper.isEmpty(attrs.get(Constants.LDAP_ATTRIBUTE_DISPLAYNAME)) ? (String) attrs.get(Constants.LDAP_ATTRIBUTE_CN).get()
		    : (String) attrs.get(Constants.LDAP_ATTRIBUTE_DISPLAYNAME).get());
	    return userVO;
	}
    }

    /**
     * Sets the user finders.
     *
     * @param userFinders            the userFinders to set
     */
    public void setUserFinders(List<LdapUserSearch> userFinders) {
	this.userFinders = userFinders;
    }

    /**
     * Gets the user finders.
     *
     * @return the userFinders
     */
    public List<LdapUserSearch> getUserFinders() {
	return this.userFinders;
    }

    /**
     * Sets the user mapper.
     *
     * @param userMapper            the userMapper to set
     */
    public void setUserMapper(UserDetailsContextMapper userMapper) {
	this.userMapper = userMapper;
    }

    /**
     * Gets the user mapper.
     *
     * @return the userMapper
     */
    public UserDetailsContextMapper getUserMapper() {
	return this.userMapper;
    }

    /**
     * Sets the auth populator.
     *
     * @param authPopulator            the authPopulator to set
     */
    public void setAuthPopulator(LdapAuthoritiesPopulator authPopulator) {
	this.authPopulator = authPopulator;
    }

    /**
     * Gets the auth populator.
     *
     * @return the authPopulator
     */
    public LdapAuthoritiesPopulator getAuthPopulator() {
	return this.authPopulator;
    }
}
