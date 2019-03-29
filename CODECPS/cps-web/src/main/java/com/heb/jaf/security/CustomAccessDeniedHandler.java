/**
 * 
 */
package com.heb.jaf.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.csrf.InvalidCsrfTokenException;
import org.springframework.security.web.csrf.MissingCsrfTokenException;

/**
 * @author khoapkl
 *
 */
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
    /* ... */
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException exception)
            throws IOException, ServletException {
    	if (exception instanceof MissingCsrfTokenException || exception instanceof InvalidCsrfTokenException) {
    		response.sendRedirect(request.getContextPath()+"/login.do?mode=error");
        } else {
            /* Redirect to a error page, send HTTP 403, etc. */
        	response.sendRedirect(request.getContextPath()+"/login.do?mode=accessDenied");
        }
    }

}
