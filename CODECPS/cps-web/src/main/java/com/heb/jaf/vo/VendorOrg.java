/**
 * 
 */
package com.heb.jaf.vo;
import java.io.Serializable;

/**
 * The Class VendorOrg.
 * @author ha.than
 */
public class VendorOrg implements Serializable {
    
    /** The Constant serialVersionUID. */
    private static final long serialVersionUID = 1L;
    
    /** The vendor org id. */
    private String vendorOrgId;
    
    /** The vendor org name. */
    private String vendorOrgName;
    
    /**
     * Instantiates a new vendor org.
     */
    public VendorOrg() {
    }
    
    /**
     * Gets the vendor org id.
     *
     * @return the vendor org id
     */
    public String getVendorOrgId() {
	return this.vendorOrgId;
    }

    /**
     * Gets the vendor org name.
     *
     * @return the vendor org name
     */
    public String getVendorOrgName() {
	return this.vendorOrgName;
    }

    /**
     * Sets the vendor org id.
     *
     * @param vendorOrgId the new vendor org id
     */
    public void setVendorOrgId(String vendorOrgId) {
	this.vendorOrgId = vendorOrgId;
    }

    /**
     * Sets the vendor org name.
     *
     * @param vendorOrgName the new vendor org name
     */
    public void setVendorOrgName(String vendorOrgName) {
	this.vendorOrgName = vendorOrgName;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#toString()
     */
    public String toString() {
	return this.vendorOrgId + "#" + this.vendorOrgName;
    }
}
