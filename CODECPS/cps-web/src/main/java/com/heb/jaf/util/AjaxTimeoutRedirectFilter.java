/*
 * $Id: AjaxTimeoutRedirectFilter.java,v 1.16 2013/10/29 13:58:02 vn44178 Exp $
 *
 * Copyright (c) 2012 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.jaf.util;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.authentication.AuthenticationTrustResolverImpl;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.security.web.util.ThrowableAnalyzer;
import org.springframework.security.web.util.ThrowableCauseExtractor;
import org.springframework.web.filter.GenericFilterBean;

import com.heb.operations.cps.util.CPSHelper;


/**
 * The Class AjaxTimeoutRedirectFilter.
 *
 * @author hathan
 */
public class AjaxTimeoutRedirectFilter extends GenericFilterBean {

	/** The Constant LOG. */
	private static final Logger LOG = Logger
			.getLogger(AjaxTimeoutRedirectFilter.class);

	/** The throwable analyzer. */
	private ThrowableAnalyzer throwableAnalyzer = new DefaultThrowableAnalyzer();

	/** The authentication trust resolver. */
	private AuthenticationTrustResolver authenticationTrustResolver = new AuthenticationTrustResolverImpl();

	/** The custom session expired error code. */
	private int customSessionExpiredErrorCode = 901;

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest,
	 * javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 */
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		try {
			CsrfToken token = (CsrfToken) request.getAttribute("_csrf");
			
			HttpServletResponse httpServletResponse = (HttpServletResponse) response;

			if (token != null) {
				// Spring Security will allow the Token to be included in this
				// header name
				httpServletResponse.setHeader("X-CSRF-HEADER",
						token.getHeaderName());

				// Spring Security will allow the token to be included in this
				// parameter name
				httpServletResponse.setHeader("X-CSRF-PARAM",
						token.getParameterName());

				// this is the value of the token to be included as either a
				// header or an HTTP parameter
				httpServletResponse.setHeader("X-CSRF-TOKEN", token.getToken());
				HttpServletRequest req = (HttpServletRequest)request;
				if(CPSHelper.isNotEmpty(req.getCookies())) {
					Cookie cookie[] = req.getCookies();
					for (Cookie cookie2 : cookie) {
						if(cookie2.getName().equalsIgnoreCase("DWRSESSIONID")) {
							cookie2.setSecure(true);
							cookie2.setHttpOnly(true);
							httpServletResponse.addCookie(cookie2);
							break;
						}
					}
				}
				
			//	httpServletResponse.addCookie(cookie);
			}
			chain.doFilter(request, response);
		}  catch (Exception ex) {
			LOG.error("AjaxTimeoutRedirectFilter "+ex.getMessage(), ex);
			Throwable[] causeChain = this.throwableAnalyzer
					.determineCauseChain(ex);
			RuntimeException ase = (AuthenticationException) this.throwableAnalyzer
					.getFirstThrowableOfType(AuthenticationException.class,
							causeChain);
			if (ase == null) {
				ase = (AccessDeniedException) this.throwableAnalyzer
						.getFirstThrowableOfType(AccessDeniedException.class,
								causeChain);
			}

			if (ase != null) {
				if (ase instanceof AuthenticationException) {
					throw ase;
				} else if (ase instanceof AccessDeniedException) {

					if (this.authenticationTrustResolver
							.isAnonymous(SecurityContextHolder.getContext()
									.getAuthentication())) {
						String ajaxHeader = ((HttpServletRequest) request)
								.getHeader("X-Requested-With");
						if ("XMLHttpRequest".equals(ajaxHeader)) {
							HttpServletResponse resp = (HttpServletResponse) response;
							resp.sendError(this.customSessionExpiredErrorCode);
						} else {
							throw ase;
						}
					} else {
						throw ase;
					}
				}
			}
		} 
	}

	/**
	 * The Class DefaultThrowableAnalyzer.
	 *
	 * @author hainn
	 */
	private static final class DefaultThrowableAnalyzer extends
			ThrowableAnalyzer {

		/**
		 * Inits the extractor map.
		 *
		 * @author hainn
		 */
		protected void initExtractorMap() {
			super.initExtractorMap();

			registerExtractor(ServletException.class,
					new ThrowableCauseExtractor() {

						/**
						 * @param throwable
						 *            Throwable
						 * @return Throwable
						 */
						public Throwable extractCause(Throwable throwable) {
							ThrowableAnalyzer.verifyThrowableHierarchy(
									throwable, ServletException.class);
							Throwable throwableReturn = ((ServletException) throwable)
									.getRootCause();
							return throwableReturn;
						}
					});
		}
	}

	/**
	 * Sets the custom session expired error code.
	 *
	 * @param customSessionExpiredErrorCode
	 *            the new custom session expired error code
	 */
	public void setCustomSessionExpiredErrorCode(
			int customSessionExpiredErrorCode) {
		this.customSessionExpiredErrorCode = customSessionExpiredErrorCode;
	}
}
