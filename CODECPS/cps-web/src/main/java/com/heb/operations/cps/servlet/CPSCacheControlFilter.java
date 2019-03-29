package com.heb.operations.cps.servlet;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CPSCacheControlFilter implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpServletResponse response = (HttpServletResponse) arg1;
		chain.doFilter(request, response);
		// response.setHeader("Pragma","no-cache");
		// response.setHeader("Cache-Control","no-cache"); Defect#800
		response.setDateHeader("Expires", 0);
	}

	public void init(FilterConfig arg0) throws ServletException {

	}

}
