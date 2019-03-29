package com.heb.operations.cps.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.exeption.CPSMessage;
import com.heb.operations.business.framework.exeption.CPSMessage.ErrorSeverity;
import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.cps.database.entities.UsrRole;
import com.heb.operations.cps.model.Roles;
import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.vo.RolesPrivilgesVO;

/**
 * The controller of tab Roles and Privileges.
 * 
 * @author vn00602
 * @since 2017/11/22
 */
@Controller
@SessionAttributes(RolesController.ROLES_MODEL_ATTRIBUTE)
@RequestMapping(value = RolesController.RELATIVE_PATH_ROLES_BASE)
public class RolesController extends HEBBaseService {

	protected static final String RELATIVE_PATH_ROLES_BASE = "/protected/cps/security";
	private static final String RELATIVE_PATH_ROLES_WRAPPER = "/roles";
	private static final String RELATIVE_PATH_SAVE_ROLES = "/save";
	private static final String RELATIVE_PATH_ROOT_PAGE = "/cps/roles/";
	private static final String RELATIVE_PATH_ROLES_PAGE = "rolesPrivileges1";
	protected static final String ROLES_MODEL_ATTRIBUTE = "roles";

	@RequestMapping(method = RequestMethod.POST, value = RolesController.RELATIVE_PATH_ROLES_WRAPPER)
	public ModelAndView roles(Roles roles, HttpServletRequest request, HttpServletResponse response)
			throws CPSGeneralException {
		this.setForm(request, roles);
		ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_ROLES_PAGE);

		String roleAbbreciation = roles.getRoleSelected();
		if (CPSHelper.isEmpty(roleAbbreciation)) {
			roleAbbreciation = CPSConstants.DEFAULT_ROLE_ABBREVIATION;
			roles.setRoleSelected(roleAbbreciation);
		}
		if (CPSHelper.isEmpty(roles.getReturnedRoles())) {
			List<UsrRole> userRoles = getRolesService().getUserRoles();
			roles.setReturnedRoles(userRoles);
		}

		UsrRole role = roles.getReturnedRole(roleAbbreciation);
		roles.setRoleNameSelected(role.getUsrRoleDes());

		if (CPSHelper.isEmpty(roles.getFunctions())) {
			List<BaseJSFVO> accessTypes = getRolesService().getAllAccessTypes();
			roles.setFunctions(this.getAttrAccessList(accessTypes));
		}

		// List resourceList = getRolesService().getResources();
		this.getAttributesforSection(roles, roleAbbreciation);
		if (CPSConstants.REGISTERED_VENDOR_ROLE.equals(roles.getUserRole())
				|| CPSConstants.UNREGISTERED_VENDOR_ROLE.equals(roles.getUserRole())) {
			request.getSession().removeAttribute(CPSConstants.VENDOR_LOGIN_COFIRM);
			request.getSession().setAttribute(CPSConstants.VENDOR_LOGIN_COFIRM, "true");
		}
		Object currentMode = request.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		if (currentMode != null)
			request.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		request.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);

		roles.setCPSRolesMode();
		saveMessage(roles, new CPSMessage());
		model.addObject(ROLES_MODEL_ATTRIBUTE, roles);
		return model;
	}

	@RequestMapping(method = RequestMethod.GET, value = RolesController.RELATIVE_PATH_ROLES_WRAPPER)
	public ModelAndView rolesWrapper(HttpServletRequest request, HttpServletResponse response)
			throws CPSGeneralException {
		Roles roles = new Roles();
		roles.setSession(request.getSession());
		roles.clearQuestionaireVO();
		return roles(roles, request, response);
	}

	@RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RolesController.RELATIVE_PATH_SAVE_ROLES)
	public ModelAndView save(@Valid @ModelAttribute(ROLES_MODEL_ATTRIBUTE) Roles roles,
			HttpServletRequest request, HttpServletResponse response) throws CPSGeneralException {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_ROLES_PAGE);

		String selectedRole = roles.getRoleSelected();
		RolesPrivilgesVO privilgesVO = roles.getRolesPrivilgesVO();
		this.getRolesService().saveResourcePrivilegesForRole(selectedRole, privilgesVO);
		saveMessage(roles, new CPSMessage(CPSConstants.SAVED_SUCCESSFULLY, ErrorSeverity.INFO));

		roles.setCPSRolesMode();
		model.addObject(ROLES_MODEL_ATTRIBUTE, roles);
		return model;
	}

	private List<BaseJSFVO> getAttrAccessList(List<BaseJSFVO> in) {
		assert null != in : "getAttrAccessList in RolesController, in null";
		List<BaseJSFVO> out = new ArrayList<BaseJSFVO>();
		for (BaseJSFVO baseJSFVO : in) {
			if (!CPSConstants.EXEC_ACCESS_CODE.equals(baseJSFVO.getId())) {
				out.add(baseJSFVO);
			}
		}
		return out;
	}

	private void getAttributesforSection(Roles roles, String roleAbbreviation) throws CPSGeneralException {

		RolesPrivilgesVO rolesPrivilgesVO = this.getRolesService().getResourcePrivilegesForRole(roleAbbreviation);
		roles.setRolesPrivilgesVO(rolesPrivilgesVO);
	}
}
