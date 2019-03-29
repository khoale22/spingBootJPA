package com.heb.operations.ui.framework.taglib;

import java.io.IOException;

import javax.servlet.jsp.JspException;

public class IfAdminTag extends AbstractIfInRoleTag {

	public IfAdminTag() throws JspException, IOException{
		super("Admin");
	}
	
}
