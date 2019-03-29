/*
 * $Id: CustomAuthenticationEntryPoint.java, 5:38:05 PM$
 *
 * Copyright (c) 2014 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.jaf.util;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.heb.operations.cps.servlet.CPSWebFilter;
import org.apache.log4j.Logger;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.stereotype.Component;

/**
 * CustomAuthenticationEntryPoint.
 * @author ha.than
 */
@Component(value = "customAuthenticationEntryPoint")
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {
    private static Logger LOG = Logger.getLogger(CustomAuthenticationEntryPoint.class);
    /** The login page url. */
    private String loginPageUrl;
    
    /** The return parameter enabled. */
    private boolean returnParameterEnabled;
    
    /** The return parameter name. */
    private String returnParameterName;

    /**
     * getLoginPageUrl.
     * @return String
     */
    public String getLoginPageUrl() {
	return this.loginPageUrl;
    }

    /**
     * Sets the login page url.
     *
     * @param loginPageUrl the new login page url
     */
    public void setLoginPageUrl(String loginPageUrl) {
	this.loginPageUrl = loginPageUrl;
    }

    /**
     * isReturnParameterEnabled.
     * @return boolean
     */
    public boolean isReturnParameterEnabled() {
	return this.returnParameterEnabled;
    }

    /**
     * Sets the return parameter enabled.
     *
     * @param returnParameterEnabled the new return parameter enabled
     */
    public void setReturnParameterEnabled(boolean returnParameterEnabled) {
	this.returnParameterEnabled = returnParameterEnabled;
    }

    /**
     * Gets the return parameter name.
     * @return the return parameter name
     */
    public String getReturnParameterName() {
	return this.returnParameterName;
    }

    /**
     * Sets the return parameter name.
     *
     * @param returnParameterName the new return parameter name
     */
    public void setReturnParameterName(String returnParameterName) {
	this.returnParameterName = returnParameterName;
    }

    /**
     * commence.
     *
     * @author ha.than
     * @param request            :HttpServletRequest
     * @param response            :HttpServletResponse
     * @param reason            :AuthenticationException
     * @throws IOException             :IOException
     * @throws ServletException             :ServletException
     */
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException reason) throws IOException, ServletException {

        String ajaxHeader = ((HttpServletRequest) request).getHeader("X-Requested-With");
	if ("XMLHttpRequest".equals(ajaxHeader)) {
	    response.sendError(901, "Ajax Request Denied (Session Expired)");
	    // response.setStatus(AntiMagicNumber.NINE_HUNDRED_AND_ONE);
	} else {
	    if (this.loginPageUrl == null || Constants.EMPTY_STRING.equals(this.loginPageUrl)) {
		throw new RuntimeException("loginPageUrl has not been defined");
	    }
	    String redirectUrl = this.loginPageUrl;
	    if (this.isReturnParameterEnabled()) {
		String redirectUrlReturnParameterName = this.getReturnParameterName();
		if (redirectUrlReturnParameterName == null || Constants.EMPTY_STRING.equals(redirectUrlReturnParameterName)) {
		    throw new RuntimeException("redirectUrlReturnParameterName has not been defined");
		}
		redirectUrl += "?" + redirectUrlReturnParameterName + "=" + request.getServletPath();
	    }
	    RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	    redirectStrategy.sendRedirect(request, response, redirectUrl);
	}
    }
}
