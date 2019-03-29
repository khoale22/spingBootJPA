package com.heb.operations.cps.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.cps.database.entities.UsrRole;
import com.heb.operations.cps.vo.RolesPrivilgesVO;

public class Roles extends HebBaseInfo {

	private static final String FORM_NAME = "Roles";

	private String role = null;

	private RolesPrivilgesVO rolesPrivilgesVO;

	private List<BaseJSFVO> functions = new ArrayList<BaseJSFVO>();

	private List<BaseJSFVO> attrFunctions = new ArrayList<BaseJSFVO>();

	private Map<String, UsrRole> returnedRoles = new HashMap<String, UsrRole>();

	private String productType = "";

	private String roleSelected = "";

	private String roleNameSelected = "";

	// @Override
	// public void reset(ActionMapping mapping, HttpServletRequest req) {
	// super.reset(mapping, req);
	// if (null != rolesPrivilgesVO) {
	// rolesPrivilgesVO.clearFunctionAccess();
	// rolesPrivilgesVO.clearMenuAccess();
	// rolesPrivilgesVO.clearAttributeAccess();
	// }
	// }

	public Roles() {
		this.setCurrentAppName("Roles and Privileges");
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public List<BaseJSFVO> getFunctions() {
		return functions;
	}

	public void setFunctions(List<BaseJSFVO> functions) {
		this.functions = functions;
	}

	public List<UsrRole> getReturnedRoles() {
		List<UsrRole> list = new ArrayList<UsrRole>();
		list.addAll(this.returnedRoles.values());
		return list;
	}

	public UsrRole getReturnedRole(String roleAbbreviation) {
		return this.returnedRoles.get(roleAbbreviation);
	}

	public void setReturnedRoles(List<UsrRole> returnedRoles) {
		if (null != returnedRoles) {
			this.returnedRoles.clear();
			for (UsrRole role : returnedRoles) {
				this.returnedRoles.put(role.getUsrRoleAbb(), role);
			}
		}
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public RolesPrivilgesVO getRolesPrivilgesVO() {
		return rolesPrivilgesVO;
	}

	public void setRolesPrivilgesVO(RolesPrivilgesVO rolesPrivilgesVO) {
		this.rolesPrivilgesVO = rolesPrivilgesVO;
	}

	@Override
	public String getStrutsFormName() {
		return FORM_NAME;
	}

	public List<BaseJSFVO> getAttrFunctions() {
		return attrFunctions;
	}

	public void setAttrFunctions(List<BaseJSFVO> attrFunctions) {
		this.attrFunctions = attrFunctions;
	}

	public String getRoleSelected() {
		return roleSelected;
	}

	public void setRoleSelected(String roleSelected) {
		this.roleSelected = roleSelected;
	}

	public String getRoleNameSelected() {
		return roleNameSelected;
	}

	public void setRoleNameSelected(String roleNameSelected) {
		this.roleNameSelected = roleNameSelected;
	}
}