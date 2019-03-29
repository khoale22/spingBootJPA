package com.heb.operations.ui.framework.taglib;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class IfInRoleTag extends TagSupport {

	private String role;
	
	
	@Override
	public int doStartTag() throws JspException {
		
		if(role == null){
			throw new JspException("role attribute is required");
		}
		
		boolean inRole = ((HttpServletRequest)pageContext.getRequest()).isUserInRole(role);
		
		return inRole ? EVAL_BODY_INCLUDE : SKIP_BODY;
		
	}


	public String getRole() {
		return role;
	}


	public void setRole(String role) {
		this.role = role;
	}

	
	
}
