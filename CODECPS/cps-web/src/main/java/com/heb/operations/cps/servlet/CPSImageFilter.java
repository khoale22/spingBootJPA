package com.heb.operations.cps.servlet;

import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class CPSImageFilter implements Filter {

	public void destroy() {
		// TODO Auto-generated method stub

	}
	private static final String PATH_LIST = "PATH_LIST";
	private static final String COOKIE_NAME = "CPSCookie";
	private static final Long ONE_DAY = new Long(24*60*60*1000);

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)arg0;
		HttpServletResponse response = (HttpServletResponse)arg1;
		chain.doFilter(request, response);
//		HttpSession session = request.getSession();
//		List<String> list = (List<String>)session.getAttribute(PATH_LIST);
//		if(list == null){
//			list = new ArrayList<String>();
//			session.setAttribute(PATH_LIST, list);
//		}
//		//printHeaders(request);
//		try{
//			if(isToBeRefreshed(request.getRequestURI(),list)){
//				chain.doFilter(request, response);
//				list.add(request.getRequestURI());
//				response.setIntHeader("Expires", 24 * 60 * 60 * 1);
//				response.setHeader("Cache-Control", "public");
//			}else{
//				response.sendError(304);
//			}
//		}catch (Exception e) {
//		}
	}
	
	private boolean isToBeRefreshed(String uri, List<String> list) {
		if(list.contains(uri)){
			return false;
		}
		return true;
	}

	private boolean isToBeRefreshed(HttpServletRequest request){
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies){
			if(COOKIE_NAME.equals(cookie.getName())){
				String time = cookie.getValue();
				Long lTime;
				try{
					lTime = Long.parseLong(time);
				}catch (NumberFormatException e) {
					return true;
				}
				Long cuurntTime = System.currentTimeMillis();
				Long timeDiff = cuurntTime - lTime;
				if(timeDiff < ONE_DAY){
					return false;
				}
			}
		}
		return true;
	}
	
	private void printHeaders(HttpServletRequest request){
		Enumeration enumeration = request.getHeaderNames();
		while (enumeration.hasMoreElements()) {
			String name = (String) enumeration.nextElement();
		}
	}
	
	

	public void init(FilterConfig arg0) throws ServletException {}

}
