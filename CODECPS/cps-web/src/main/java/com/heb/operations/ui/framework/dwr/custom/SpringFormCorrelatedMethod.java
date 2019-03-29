package com.heb.operations.ui.framework.dwr.custom;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;


/**
 * An annotation to indicate that the return value of this method should be applied to a 
 * particular property of the Classes associated Struts Action Form
 * @author robhardt
 *
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface SpringFormCorrelatedMethod {
	String correlatedStrutsFormProperty();
}
