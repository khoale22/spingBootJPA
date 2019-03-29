package com.heb.operations.ui.framework.taglib;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public abstract class AbstractIfInRoleTag extends TagSupport {

	private List<String> desiredRoleNames;
	
	public AbstractIfInRoleTag(String desiredRoleName) throws JspException, IOException{
		
		Properties p = new Properties();
		InputStream is = this.getClass().getClassLoader().getResourceAsStream("/com/heb/operations/ui/framework/taglib/RoleCorrelations.properties");
		try{
			p.load(is);
		}
		catch(Exception ex){
			throw new JspException("Couldn't load RoleCorrelations.properties", ex);
		} finally{
			is.close();
		}
		
		
		desiredRoleNames = new ArrayList<String>();
		desiredRoleNames.add(desiredRoleName);
		
		String otherRoles = p.getProperty(desiredRoleName);
		if(otherRoles != null){
			StringTokenizer st = new StringTokenizer(otherRoles, ",");
			while(st.hasMoreTokens()){
				desiredRoleNames.add(st.nextToken().trim());
			}
		}
		
		
	}
	
	
	
	public int doStartTag() throws JspException {
		
		boolean inRole = false;
		
		for (String name : desiredRoleNames) {
			if(((HttpServletRequest)pageContext.getRequest()).isUserInRole(name)){
				inRole = true;
				break;
			}
		}
		
		//boolean inRole = ((HttpServletRequest)pageContext.getRequest()).isUserInRole(desiredRoleName);
		
		return inRole ? EVAL_BODY_INCLUDE : SKIP_BODY;
		
	}
	
}
