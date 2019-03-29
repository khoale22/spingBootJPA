/*
 * $Id: PMJAFException.java,v 1.22 2015/03/17 08:27:18 vn55228 Exp $
 *
 * Copyright (c) 2014 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.jaf.exeption;

/**
 * PMJAFException class.
 * @author ha.than
 */
public class CPSJAFException extends Exception {

    // ======================
    public static final int ERR_COMMON = 9999;
    public static final int ERR_DB = 9998;
    public static final int errWS = 9999;

    /**
     * serialVersionUID.
     */
    private static final long serialVersionUID = 1L;

    private int errCode = 9999;

    public int getErrCode() {
	return errCode;
    }

    public void setErrCode(int errCode) {
	this.errCode = errCode;
    }

    /**
     * DSVException constructor method.
     * @param e
     *            Exception
     * @author Hai.Ngo
     */
    public CPSJAFException(Exception e) {
	super(e);
    }

    /**
     * DSVException constructor method.
     * @param errorMsg
     *            errorMsg
     * @author quangmai
     */
    public CPSJAFException(String errorMsg) {
	this(new Exception(errorMsg));
    }

    /**
     * Instantiates a new DSV exception.
     * @param errCode
     *            the err code
     * @param e
     *            the e
     */
    public CPSJAFException(int errCode, Exception e) {
	super(e);
	this.errCode = errCode;
    }

    /**
     * Instantiates a new DSV exception.
     * @param msg
     *            the msg
     * @param e
     *            the e
     */
    public CPSJAFException(String msg, Exception e) {
	super(msg, e);
    }

}
