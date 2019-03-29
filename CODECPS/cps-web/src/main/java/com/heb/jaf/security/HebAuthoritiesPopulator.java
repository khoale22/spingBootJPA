/*
 * $Id: HebAuthoritiesPopulator.java,v 1.21 2015/03/12 11:15:10 vn44178 Exp $
 *
 * Copyright (c) 2010 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.jaf.security;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.ldap.userdetails.LdapAuthoritiesPopulator;

import com.heb.jaf.util.Constants;
import com.heb.jaf.util.Helper;
import com.heb.jaf.vo.Resource;
import com.heb.jaf.vo.Resource.AccessType;
import com.heb.jaf.vo.RoleVO;

/**
 * The Class HebAuthoritiesPopulator.
 *
 * @author ha.than
 */
public class HebAuthoritiesPopulator implements LdapAuthoritiesPopulator {

	/** The Constant LOG. */
	private static final Logger LOG = Logger
			.getLogger(HebAuthoritiesPopulator.class);

	/** The Constant HEB_JOB_CODE. */
	private static final String HEB_JOB_CODE = "hebJobCode";

	/** The schema. */
	@Value("${app.database.db2t.schema}")
	private String SCHEMA = "";

	/** The Constant ARBAF_CONNECT_ERROR. */
	private static final String ARBAF_CONNECT_ERROR = "Application has not been configured to use the"
			+ " targeted ARBAF environment";

	/** The Constant USRROLEDES. */
	private static final String USRROLEDES = "usr_role_des";

	/** The Constant USRROLECD. */
	private static final String USRROLECD = "usr_role_cd";

	/** The Constant USRROLEABB. */
	private static final String USRROLEABB = "usr_role_abb";

	/** The Constant GUEST. */
	// private static final String ADMIN = "ADMIN";
	private static final String GUEST = "GUEST";

	/** The application id. */
	private Integer applicationId = 1; // Set default for CPS application id.

	/** The arbaf dao. */
	private JdbcTemplate arbafDao;

	/** The appl abb. */
	private String applAbb = "JAF";

	/** The find application query. */
	private String findApplicationQuery = "select appl_id from appl_nm where appl_nm=?";

	/** The find roles by onepass and job cd cps. */
	private String findRolesByOnepassAndJobCdCps = "SELECT DISTINCT ur.USR_ROLE_ABB, ur.USR_ROLE_DES "
			+ "FROM SCHEMA.usr_sec_grp usg, SCHEMA.usr_role ur "
			+ "WHERE ur.USR_ROLE_cd = usg.USR_ROLE_CD AND UPPER(USR_ID) IN(?) "
			+ "UNION  "
			+ "select DISTINCT ur.USR_ROLE_abb,ur.USR_ROLE_des "
			+ "from SCHEMA.usr_role ur, SCHEMA.usr_role_job_cd urjc  "
			+ "where  ur.usr_role_cd = urjc.usr_role_cd and urjc.JOB_CD_XREF=?";

	/** The find roles by onepass cps. */
	private String findRolesByOnepassCps = "SELECT DISTINCT ur.USR_ROLE_ABB, ur.USR_ROLE_DES "
			+ "FROM SCHEMA.usr_sec_grp usg, SCHEMA.usr_role ur "
			+ "WHERE ur.USR_ROLE_cd = usg.USR_ROLE_CD AND UPPER(USR_ID) IN(?)";

	/** The find resources by rolecds cps. */
	private String findResourcesByRolecdsCps = "SELECT DISTINCT ur.usr_role_abb, at.ACS_cd, r.RESRC_ID,r.SCREEN_NM, rt.RESRC_TYP_ABB,r.resrc_nm,r.tool_tip_sw "
			+ "FROM SCHEMA.usr_sec_grp usg,SCHEMA.usr_role ur,SCHEMA.sec_grp_resrc sgr,SCHEMA.resrc r,SCHEMA.resrc_typ rt,SCHEMA.access_type at "
			+ "WHERE     usg.USR_ROLE_CD = ur.USR_ROLE_CD   AND sgr.USR_ROLE_CD = ur.USR_ROLE_CD AND r.RESRC_ID = sgr.RESRC_ID "
			+ "AND rt.RESRC_TYP_id = r.RESRC_TYP_ID AND sgr.ACS_CD = at.ACS_CD AND r.APPL_ID=? AND UPPER(usg.USR_ID) IN (?) "
			+ "Union  SELECT DISTINCT ur.usr_role_abb,   at.ACS_cd,     r.RESRC_ID, r.SCREEN_NM,  rt.RESRC_TYP_ABB,   r.resrc_nm,  r.tool_tip_sw "
			+ "FROM SCHEMA.usr_role ur, SCHEMA.usr_role_job_cd urjc,SCHEMA.sec_grp_resrc sgr, SCHEMA.resrc r, SCHEMA.resrc_typ rt, SCHEMA.access_type at  "
			+ "WHERE   sgr.USR_ROLE_CD = ur.USR_ROLE_CD   AND r.RESRC_ID = sgr.RESRC_ID  AND rt.RESRC_TYP_id = r.RESRC_TYP_ID  AND sgr.ACS_CD = at.ACS_CD "
			+ "AND r.APPL_ID = ?  AND ur.usr_role_cd = urjc.usr_role_cd     AND urjc.job_cd_xref=? "
			+ "union SELECT DISTINCT ur.usr_role_abb, at.ACS_cd, r.RESRC_ID, r.SCREEN_NM, rt.RESRC_TYP_ABB, r.resrc_nm, r.tool_tip_sw "
			+ "from SCHEMA.usr_role ur, SCHEMA.sec_grp_resrc sgr, SCHEMA.resrc r, SCHEMA.resrc_typ rt, SCHEMA.access_type at "
			+ "where ur.USR_ROLE_ABB in (ROLEARRLOG) and ur.usr_role_cd = sgr.usr_role_cd AND r.RESRC_ID = sgr.RESRC_ID "
			+ "AND rt.RESRC_TYP_id = r.RESRC_TYP_ID AND sgr.ACS_CD = at.ACS_CD AND r.APPL_ID=? ";
	/** The get multiple roles. */
	@Value("select idm.usr_id,usr_role.usr_role_cd, usr_role_abb, usr_role_des from idm, usr_role, usr_sec_grp where idm.usr_id=usr_sec_grp.usr_id and usr_sec_grp.usr_role_cd=usr_role.usr_role_cd and appl_id=(:applId) and upper(idm.usr_id) IN (:usrIds)")
	private String getMultipleRoles;

	/** The map row resource. */
	private RowMapper<Resource> mapRowResource = new RowMapper<Resource>() {
		@Override
		public Resource mapRow(ResultSet rs, int rowNum) throws SQLException {
			String resourceNm = rs.getString("RESRC_NM");
			if (null != resourceNm) {
				resourceNm = resourceNm.trim();
			}
			String resourceId = rs.getString("RESRC_ID");
			if (null != resourceId) {
				resourceId = resourceId.trim();
			}
			String scr = rs.getString("SCREEN_NM");
			if (null != scr) {
				scr = scr.trim();
			}
			String tooSw = rs.getString("TOOL_TIP_SW");
			if (null != tooSw) {
				tooSw = tooSw.trim();
			}
			String acsCd = rs.getString("ACS_CD");
			if (null != acsCd) {
				acsCd = acsCd.trim();
			}
			String resrcTyp = rs.getString("RESRC_TYP_ABB");
			if (null != resrcTyp) {
				resrcTyp = resrcTyp.trim();
			}

			Resource retObj = new Resource(resourceNm, resourceId, scr, tooSw,
					acsCd, resrcTyp);
			return retObj;
		}
	};

	/**
	 * Sets the appl abb.
	 *
	 * @param applAbb
	 *            the applAbb to set
	 */
	public void setApplAbb(String applAbb) {
		this.applAbb = applAbb;
	}

	/**
	 * Gets the appl abb.
	 *
	 * @return the applAbb
	 */
	public String getApplAbb() {
		return this.applAbb;
	}

	/**
	 * Gets the arbaf dao.
	 *
	 * @return the arbaf dao
	 */
	public JdbcTemplate getArbafDao() {
		return this.arbafDao;
	}

	/**
	 * Sets the arbaf dao.
	 *
	 * @param arbafDao
	 *            the new arbaf dao
	 */
	public void setArbafDao(JdbcTemplate arbafDao) {
		this.arbafDao = arbafDao;
	}

	/**
	 * Gets the granted authorities.
	 *
	 * @author ha.than
	 * @param ldapCtx
	 *            the ldap ctx
	 * @param username
	 *            the username
	 * @return the granted authorities
	 */
	@Override
	public Collection<GrantedAuthority> getGrantedAuthorities(
			DirContextOperations ldapCtx, String username) {
		// Grab the user so that we can see his roles.
		if (username == null) {
			throw new IllegalArgumentException(
					"A username is required to get GrantedAuthorities");
		}
		Set<GrantedAuthority> roles = new HashSet<GrantedAuthority>();
		roles.add(new Role(GUEST, GUEST));
		if (Helper.isVendoPrefix(username)) {
			if (Constants.BROKER_ROLE_KEY.equals(ldapCtx
					.getStringAttribute(UserInfoMapper.BUSINESSCATEGORY))
					|| Constants.VENDOR_ROLE_KEY
							.equals(ldapCtx
									.getStringAttribute(UserInfoMapper.BUSINESSCATEGORY))) {
				roles.add(new Role(CPSRolesBuilder.RVEND, CPSRolesBuilder.RVEND));
			} else {
				roles.add(new Role(CPSRolesBuilder.UVEND, CPSRolesBuilder.UVEND));
			}
			// roles.add(new
			// Role(ldapCtx.getStringAttribute(UserInfoMapper.BUSINESSCATEGORY),
			// ldapCtx.getStringAttribute(UserInfoMapper.BUSINESSCATEGORY)));
		} else {
			String jobCode = ldapCtx.getStringAttribute(HEB_JOB_CODE);
			List<Map<String, Object>> results = null;
			try {
				if (jobCode != null) {
					results = this.arbafDao.queryForList(
							this.findRolesByOnepassAndJobCdCps.replaceAll(
									"SCHEMA", SCHEMA), StringUtils.upperCase(username), jobCode);
				} else {
					results = this.arbafDao.queryForList(
							this.findRolesByOnepassCps.replaceAll("SCHEMA",
									SCHEMA), StringUtils.upperCase(username));
				}
				for (Map<String, Object> role : results) {
					roles.add(new Role(role.get(USRROLEABB).toString().trim()
							.toUpperCase(), role.get(USRROLEDES).toString()
							.trim()));
				}
			} catch (DataAccessException e) {
				LOG.error(e.getMessage(), e);
			}
		}
		return roles;
	}

	/**
	 * getMultipleRoles.
	 *
	 * @author ha.than
	 * @param usrIds
	 *            List<String>
	 * @return Map<String, List<RoleVO>>
	 */
	public Map<String, List<RoleVO>> getMultipleRoles(List<String> usrIds) {
		List<RoleVO> lstRoleVO = null;
		Map<String, Object> map = new HashMap<String, Object>();
		NamedParameterJdbcTemplate jdbcTemplate = new NamedParameterJdbcTemplate(
				this.arbafDao);
		try {
			List<Integer> appl = this.arbafDao.queryForList(
					this.findApplicationQuery, Integer.class, this.applAbb);
			if (appl == null || appl.size() != 1) {
				throw new IllegalArgumentException(ARBAF_CONNECT_ERROR);
			}
			int applId = appl.get(0);
			map.put("applId", applId);
			map.put("usrIds", usrIds);
			lstRoleVO = jdbcTemplate.query(this.getMultipleRoles, map,
					this.getMultipleRolesRowMapper());
		} catch (DataAccessException e) {
			LOG.error(e.getMessage(), e);
		}
		return this.convertLstRoleVOToMap(usrIds, lstRoleVO);
	}

	/**
	 * getMultipleRoles.
	 *
	 * @author ha.than
	 * @param roles
	 *            the roles
	 * @param userId
	 *            the user id
	 * @param jobCode
	 *            the job code
	 * @return Map<String, List<RoleVO>>
	 */
	public Map<String, Resource> getAllResourceByRoles(String roles,
			String userId, String jobCode) {
		Map<String, Resource> mapReSource = new HashMap<String, Resource>();
		try {
			List<Resource> lstResource = this.arbafDao.query(this
					.convertSqlGetRole(roles).replaceAll("SCHEMA", SCHEMA),
					new Object[] { applicationId, StringUtils.upperCase(userId), applicationId,
							(jobCode == null) ? "-1" : jobCode.trim(),
							applicationId }, this.mapRowResource);
			for (Resource resource : lstResource) {
				String oldAccessType = resource.getResrcDefntn() + "_"
						+ resource.getAccessType().getAccessTypeCd();
				if (mapReSource.get(resource.getResrcDefntn()) == null) {
					mapReSource.put(resource.getResrcDefntn(), resource);
				} else {
					Resource temp = mapReSource.get(resource.getResrcDefntn());
					if (temp.getAccessType()
							.getAccessTypeCd()
							.equalsIgnoreCase(AccessType.EDIT.getAccessTypeCd())
							&& resource
									.getAccessType()
									.getAccessTypeCd()
									.equalsIgnoreCase(
											AccessType.VIEW.getAccessTypeCd())) {
						continue;
					} else {
						mapReSource.put(resource.getResrcDefntn(), resource);
					}
				}
			}
		} catch (DataAccessException e) {
			LOG.error(e.getMessage(), e);
		}
		return mapReSource;
	}

	/**
	 * Convert sql get role.
	 *
	 * @param roles
	 *            the roles
	 * @return the string
	 */
	private String convertSqlGetRole(String roles) {
		return this.findResourcesByRolecdsCps.replace("ROLEARRLOG", roles);
	}

	/**
	 * convertLstRoleVOToMap.
	 *
	 * @author anhtran.
	 * @param usrIds
	 *            :List<String>
	 * @param lstRoleVO
	 *            :List<UserVO>
	 * @return Map<String, List<RoleVO>>
	 */
	private Map<String, List<RoleVO>> convertLstRoleVOToMap(
			List<String> usrIds, List<RoleVO> lstRoleVO) {
		Map<String, List<RoleVO>> roleVOMap = new HashMap<String, List<RoleVO>>();
		for (String usrId : usrIds) {
			List<RoleVO> roleVOs = new ArrayList<RoleVO>();
			for (RoleVO roleVO : lstRoleVO) {
				if (usrId.equalsIgnoreCase(roleVO.getUsrId())) {
					roleVOs.add(roleVO);
				}
			}
			roleVOMap.put(usrId, roleVOs);
		}
		return roleVOMap;
	}

	/**
	 * Get list order detail from Database.
	 *
	 * @author anhtran
	 * @return List<OrderDetailVO>
	 */
	private RowMapper<RoleVO> getMultipleRolesRowMapper() {
		RowMapper<RoleVO> orderMapper = new RowMapper<RoleVO>() {
			@Override
			public RoleVO mapRow(ResultSet rs, int arg1) throws SQLException {
				RoleVO roleVO = new RoleVO();
				roleVO.setUsrId(rs.getString("usr_id"));
				roleVO.setUsrRoleCd(rs.getString(USRROLECD));
				roleVO.setUsrRoleAbb(rs.getString(USRROLEABB));
				roleVO.setUsrRoleDes(rs.getString(USRROLEDES));
				return roleVO;
			}
		};
		return orderMapper;
	}
}
