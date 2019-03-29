/*
 * $Id: PMException.java,v 1.5.2.13 2013/12/02 02:48:39 vn55228 Exp $. Copyright
 * (c) 2012 HEB All rights reserved. This software is the confidential and
 * proprietary information of HEB.
 */
package com.heb.jaf.exeption;

/**
 * @author ha.than
 */
public class JAFException extends Exception {

    private static final long serialVersionUID = 1867066590373253305L;

    /**
     * Construction.
     */
    public JAFException() {
	super();
    }

    /**
     * Construction.
     * @param throwable
     *            Throwable
     */
    public JAFException(Throwable throwable) {
	super(throwable);
    }

    /**
     * PMException.
     * @param message
     *            String
     * @param cause
     *            Throwable
     */
    public JAFException(String message, Throwable cause) {
	super(message, cause);
    }

    /**
     * PMException.
     * @param message
     *            String
     */
    public JAFException(String message) {
	super(message);
    }
}
