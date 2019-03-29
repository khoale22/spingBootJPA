/*
 * $Id: Helper.java,v 1.56 2015/08/10 10:00:26 vn55228 Exp $
 *
 * Copyright (c) 2014 HEB
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HEB.
 */
package com.heb.jaf.util;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

/**
 * The Class Helper.
 *
 * @author ha.than
 */
public final class Helper {

    /**
     * Constructor method.
     */
    private Helper() {
    }

    /**
     * <b>Method check a string is empty.</b>
     *
     * @author ha.than
     * @param obj            - An Input String.
     * @return Return true if object is empty or null and otherwise false.
     */
    public static boolean isEmpty(final String obj) {
	return obj == null || Constants.EMPTY_STRING.equals(obj.trim());
    }

    /**
     * <b>Method check string is empty.</b>
     *
     * @author duyen.le
     * @param obj            - An Input Object.
     * @return Returns true if Object is null, otherwise false.
     */
    public static boolean isEmpty(final Object obj) {
	return obj == null;
    }

    /**
     * <b>Method check string is empty.</b>
     *
     * @author ha.than
     * @param map            - An Input Object.
     * @return Returns true if Object is null, otherwise false.
     */
    public static boolean isEmpty(final Map map) {
	return map == null || map.isEmpty();
    }

    /**
     * Checks if is empty.
     *
     * @author ha.than
     * @param set            the set
     * @return true, if is empty
     */
    public static boolean isEmpty(final Set set) {
	return set == null || set.isEmpty();
    }

    /**
     * Check is empty BigDecimal.
     * @param value
     *            BigDecimal value
     * @return boolean value
     */
    public static boolean isEmpty(final BigDecimal value) {
	return value == null || new BigDecimal(00).equals(value);
    }

    /**
     * Check is empty Collection<?>.
     * @param obj
     *            Collection value
     * @return boolean value
     */
    public static boolean isEmpty(final Collection<Object> obj) {
	return obj == null || obj.isEmpty();
    }

    /**
     * Check is empty List<?>.
     * @param obj
     *            Collection value
     * @return boolean value
     */
    public static boolean isEmpty(final List<?> obj) {
	return obj == null || obj.isEmpty();
    }

    /**
     * Check is empty Object[].
     * @param arr
     *            Object array
     * @return true or false
     */
    public static boolean isEmpty(final Object[] arr) {
	return arr == null || arr.length == 0;
    }

    /**
     * <p>
     * Test valid number.
     * </p>
     *
     * @author ha.than
     * @param value            - Input String.
     * @return Return true if the Input String is parsed to Integer type
     *         successful, otherwise false.
     */
    public static boolean isInteger(final String value) {
	boolean reValue = false;
	try {
	    Integer.parseInt(value);
	    reValue = true;
	} catch (NumberFormatException e) {
	    reValue = false;
	}
	return reValue;
    }

    /**
     * Test valid number.
     *
     * @author ha.than
     * @param value            - Input String.
     * @return Return true if the Input String is parsed to Long type
     *         successful, otherwise false.
     */
    public static boolean isLong(final String value) {
	boolean reValue = false;
	try {
	    Long.parseLong(value);
	    reValue = true;
	} catch (NumberFormatException e) {
	    reValue = false;
	}
	return reValue;
    }

    /**
     * Test valid number.
     *
     * @author ha.than
     * @param value            - Input String.
     * @return boolean.
     */
    public static boolean isDouble(String value) {
	boolean reValue = false;
	try {
	    Double.parseDouble(value);
	    reValue = true;
	} catch (NumberFormatException e) {
	    reValue = false;
	}
	return reValue;
    }

    /**
     * Check a valid List of Objects.
     *
     * @author ha.than
     * @param inVal            A list of random Object need to be checked.
     * @return Return TRUE if this list is not null and It contains elements,
     *         otherwise false.
     */
    public static boolean isNormalList(List<? extends Object> inVal) {
	return inVal != null && !inVal.isEmpty();
    }

    /**
     * Check the Input String is valid Date.
     *
     * @author ha.than
     * @param inDate            - The Input String
     * @return boolean result.
     */
    public static boolean isValidDate(String inDate) {
	SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy", Locale.US);
	dateFormat.setLenient(false);
	try {
	    dateFormat.parse(inDate.trim());
	} catch (ParseException pe) {
	    return false;
	}
	return true;
    }

    /**
     * Just workaround checkstyle warning (Boolean expression complexity).
     *
     * @author ha.than
     * @param bs            List of boolean values.
     * @return Return True if all values are true.
     */
    public static boolean testMultiBoolean(boolean... bs) {
	boolean retVal = true;
	for (boolean item : bs) {
	    if (!item) {
		retVal = false;
		break;
	    }
	}
	return retVal;
    }

    /**
     * Checks if is vendo prefix.
     *
     * @param user the user
     * @return true, if is vendo prefix
     */
    public static boolean isVendoPrefix(String user) {
	return (user.toUpperCase().startsWith(Constants.VENDOR_PREFIX_V90) || user.toUpperCase().startsWith(Constants.VENDOR_PREFIX_VB)) ? true : false;
    }

    /**
     * Gets the vendor org id.
     *
     * @param aVendorOrgId the a vendor org id
     * @return the vendor org id
     */
    public static final String getVendorOrgId(String aVendorOrgId) {
	String vendorOrgId = null;
	if (!isEmpty(aVendorOrgId)) {
	    StringTokenizer tokens = new StringTokenizer(aVendorOrgId, ",");
	    vendorOrgId = tokens.nextToken();
	    vendorOrgId = vendorOrgId.substring(3, vendorOrgId.length());
	}
	return vendorOrgId;
    }

    /**
     * Gets the role.
     *
     * @param aRole the a role
     * @return the role
     */
    public static final String getRole(String aRole) {
	String role = "Vendor";
	if (!isEmpty(role)) {
	    if (!"USER".equals(aRole)) {
		role = aRole;
	    }
	    role = role.trim();
	}
	if (role.equals("BROKER")) {
	    role = "Broker";
	}
	return role;
    }
}
