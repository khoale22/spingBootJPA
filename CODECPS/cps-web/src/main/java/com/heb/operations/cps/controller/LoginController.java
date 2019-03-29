/*
 * $Id: LoginController.java,v 1.14.2.4 2015/10/30 09:58:50 vn55228 Exp $
 *
 * Copyright (c) 2013 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.operations.cps.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.StandardEnvironment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


/**
 * Controller for the Login screen.
 * @author duyen.le
 */
@Controller
// @RequestMapping("/login")
public class LoginController {
	/**
	 * The Constant LOG.
	 */
	private static final Logger LOG = Logger.getLogger(LoginController.class);
	private static final String LOGIN_TILE = "login.tile";

	private static final String ACCESS_DENIED = "403.tile";

	private static final String SESSION = "session";

//	@Value("${app.rerun.url}")
//	private String rerunRuleUrl;

	/**
	 * Handles any login case.
	 * @param logout
	 *            boolean whether the user has just logged out
	 * @param fail
	 *            boolean whether the user has failed a login attempt
	 * @param model
	 *            ModelMap Spring's model to which to add the logout and failure flags
	 * @return the tile for the login page
	 */
	@RequestMapping(value = { "/","/login" }, method = RequestMethod.GET)
	public ModelAndView showLogin(ModelMap model) {
//		String[] profs = this.environment.getActiveProfiles();
//		if (profs.length > 0)
//			model.addAttribute("env", profs[0]);
//		model.addAttribute("showLogout", logout);
//		model.addAttribute("showFailure", fail);
//		model.put("rerunUrl", this.rerunRuleUrl);
		return new ModelAndView("/Main1", model);
	}

	/**
	 * showAccessDeniedScreen.
	 * @return the tile for the access denied page
	 */
	@RequestMapping(value = { "/403" }, method = RequestMethod.GET)
	public String showAccessDeniedScreen() {
		return ACCESS_DENIED;
	}

	/**
	 * checkSessionTimeOut.
	 * @param request
	 *            :HttpServletRequest
	 * @return String
	 * @author anhtran.
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = { "/checkSessionTimeOut" }, method = RequestMethod.GET)
	public String checkSessionTimeOut(HttpServletRequest request) {
		HttpSession session = request.getSession();
		JSONObject jsonResult = new JSONObject();
		if (session == null) {
			jsonResult.put(SESSION, false);
		} else {
			jsonResult.put(SESSION, true);
		}
		return jsonResult.toString();
	}

}
