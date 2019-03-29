/**
 * 
 */
package com.heb.jaf.security;

import java.util.HashMap;
import java.util.Map;

import com.heb.jaf.util.Constants;

/**
 * The Class CPSRolesBuilder.
 *
 * @author ha.than
 */
public class CPSRolesBuilder {
    
    /** The Constant RVEND. */
    public static final String RVEND = "RVEND";
    
    /** The Constant UVEND. */
    public static final String UVEND = "UVEND";

    /**
     * Builds the roles.
     *
     * @param userInfo the user info
     * @return the map
     */
    public static Map<String, Role> buildRoles(UserInfo userInfo) {
	Map<String, Role> ret = userInfo.getUserRoles();
	if (userInfo.getVendorOrgId() != null) {
	    if (ret == null) {
		ret = new HashMap();
	    }
	    if (Constants.GUEST.equals(userInfo.getVendorOrgId())) {
		Role ur = new Role(UVEND, "Unregistered Vendor");
		ur.setProgrammaticallyAssigned(true);
		ret.put(UVEND, ur);
	    } else if (userInfo.getVendorOrgId().trim().length() != 0) {
		Role ur = new Role(RVEND, "Registered Vendor");
		ur.setProgrammaticallyAssigned(true);
		ret.put(RVEND, ur);
	    }
	}
	return ret;
    }
}
