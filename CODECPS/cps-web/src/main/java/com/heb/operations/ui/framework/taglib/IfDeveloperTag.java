package com.heb.operations.ui.framework.taglib;

import java.io.IOException;

import javax.servlet.jsp.JspException;

public class IfDeveloperTag extends AbstractIfInRoleTag {

	public IfDeveloperTag() throws JspException, IOException{
		super("Developer");
	}
	
}
