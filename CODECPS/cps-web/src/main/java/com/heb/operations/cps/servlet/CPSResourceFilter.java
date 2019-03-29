package com.heb.operations.cps.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.TimeZone;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.heb.operations.ui.framework.servlet.Environment;

/**
 * The expires filter adds the expires HTTP header based on the deployment policy.
 * Many sites have a fixed deployment schedule where deployments take place 
 * based on timed regular intervals. This filter adds the expires header of the
 * next possible deployment time, to support browser caching. 
 * @author Chris Webster
 */
public class CPSResourceFilter implements Filter {
	
    	private static Logger LOG = Logger.getLogger(CPSResourceFilter.class);

	private FilterConfig filterConfig;

	public CPSResourceFilter() {
		super();
	}

	private String formatCalendar(Calendar c) {		
	    	String pattern = "EEE, dd MMM yyyy HH:mm:ss z";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
		return sdf.format(c.getTime());
	}
	
	private void addCacheHeaders(ServletRequest request, final ServletResponse response)
		throws IOException, ServletException {
		
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, 1);
		
		long tomorrowMs = c.getTimeInMillis();
		String tomorrowStr = formatCalendar(c);
		
		HttpServletResponse sr = (HttpServletResponse) response;
		sr.setHeader("Expires", tomorrowStr);

		long now = Calendar.getInstance().getTimeInMillis();
		
		long expireTime = tomorrowMs - now;		
		final double d = (double)expireTime / 1000;
		expireTime = (long)d;
		sr.setHeader("Cache-Control", "max-age="+
			Long.toString(expireTime)+";public;must-revalidate;");
	}

	/**
	 *
	 * @param request The servlet request we are processing
	 * @param response The servlet response we are creating
	 * @param chain The filter chain we are processing
	 *
	 * @exception IOException if an input/output error occurs
	 * @exception ServletException if a servlet error occurs
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
						  FilterChain chain)
		throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest)request;
		final String s = req.getRequestURI();
		
//		if(s.contains(".css.jsp")){
//			LOG.info("button");
//		}
		//needs to cache only if it is not DEV environment
		if(!Environment.isDevelopmentEnv()){
			addCacheHeaders(request, response);
		}
		chain.doFilter(request, response);
	}

	/**
	 * Return the filter configuration object for this filter.
	 */
	private FilterConfig getFilterConfig() {
		return filterConfig;
	}

	/**
	 * Set the filter configuration object for this filter.
	 *
	 * @param filterConfig The filter configuration object
	 */
	private void setFilterConfig(FilterConfig filterConfig) {
		this.filterConfig = filterConfig;
	}

	/**
	 * Destroy method for this filter 
	 *
	 */
	public void destroy(){}

	/**
	 * Init method for this filter 
	 *
	 */
	public void init(FilterConfig filterConfig) {
		setFilterConfig(filterConfig);
	}

	/**
	 * Return a String representation of this object.
	 */
	@Override
	public String toString() {
		if (getFilterConfig() == null) {
			return "ExpiresFilter()";
		}
		StringBuffer sb = new StringBuffer("ExpiresFilter(");
		sb.append(getFilterConfig());
		sb.append(")");
		return sb.toString();

	}
}