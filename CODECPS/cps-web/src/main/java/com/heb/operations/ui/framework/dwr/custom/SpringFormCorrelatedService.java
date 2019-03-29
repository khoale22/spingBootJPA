package com.heb.operations.ui.framework.dwr.custom;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;


/**
 * @author robhardt
 *	Used to denote DWR services that can bind the results of DWR method calls to a Struts Form
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface SpringFormCorrelatedService {
	String	formName();
	String	formScope()	default "session";
}
