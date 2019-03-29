/**
 * 
 */
package com.heb.jaf.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.csrf.CsrfToken;

import com.heb.operations.cps.util.CPSHelper;

/**
 * CustomAuthenticationSuccessHandler delete cookies after login successfully.
 */
public class CustomAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
	/* ... */
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
    	CsrfToken csrf = (CsrfToken) request.getAttribute(CsrfToken.class.getName());
    	if (CPSHelper.isNotEmpty(csrf)) {
    		Cookie[] cookies = request.getCookies();
        	// delete cookies when login
        	for (Cookie cookie : cookies) {
        		if(cookie.getName().equalsIgnoreCase("DWRSESSIONID")) {
	        		cookie.setMaxAge(0);
	        		response.addCookie(cookie);
	        		break;
        		}
        	}
    	}
    	
    	handle(request, response, authentication);
        clearAuthenticationAttributes(request);
    }

}
