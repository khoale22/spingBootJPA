package com.heb.operations.ui.framework.servlet;

public class Environment {
	
	private static String env;
	private static final String DEV = "DEV";
	private static final String PROD = "PROD";
	private static final String LOCAL = "LOCAL";
	
	static{
		env = System.getProperty("cps.environment");
		if(env == null || "".equals(env.trim())){
			env = PROD;
		}
	}
	
	public static boolean isDevelopmentEnv(){
		return DEV.equals(env);
	}
	public static boolean isProductionEnv(){
		return PROD.equals(env);
	}
	public static boolean isLocalEnv(){
		return 	LOCAL.equals(env);
	}
}
