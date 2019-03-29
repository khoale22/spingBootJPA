package com.heb.operations.cps.util;

import java.util.Collection;

import javax.servlet.http.HttpServletRequest;

public class FunctionUtil {

	public static boolean isUserInRole(HttpServletRequest req, String role){
		return req.isUserInRole(role);
	}
	
	public static boolean isVendor(HttpServletRequest req){
		return (
				(isUserInRole(req, "RVEND"))
					||
				(isUserInRole(req, "UVEND"))
		);
	}
	
	public static int length(Collection collection){
		if(null != collection){
			return collection.size();
		}else{
			return 0;
		}
	}
	
}
