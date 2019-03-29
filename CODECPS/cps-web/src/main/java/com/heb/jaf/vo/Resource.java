package com.heb.jaf.vo;

import java.io.Serializable;

/**
 * The Class Resource.
 *
 * @author ha.than
 */
public class Resource implements Serializable {
    
    /** The resrc defntn. */
    private String resrcDefntn;
    
    /** The screen name. */
    private String screenName;
    
    /** The tool tip. */
    private String toolTip;
    
    /** The resrc name. */
    private String resrcName;
    
    /** The access type. */
    private AccessType accessType;
    
    /** The resource type. */
    private ResourceType resourceType;

    /**
     * Instantiates a new resource.
     */
    public Resource() {
    }

    /**
     * Sets the resource type.
     *
     * @param resrcType the new resource type
     */
    protected void setResourceType(ResourceType resrcType) {
	this.resourceType = resrcType;
    }

    /**
     * Gets the resource type.
     *
     * @return the resource type
     */
    public ResourceType getResourceType() {
	return this.resourceType;
    }

    /**
     * Sets the resource name.
     *
     * @param resrcName the new resource name
     */
    protected void setResourceName(String resrcName) {
	this.resrcName = resrcName;
    }

    /**
     * Gets the resource name.
     *
     * @return the resource name
     */
    public String getResourceName() {
	return this.resrcName;
    }

    /**
     * Sets the access type.
     *
     * @param accessType the new access type
     */
    protected void setAccessType(AccessType accessType) {
	this.accessType = accessType;
    }

    /**
     * Gets the access type.
     *
     * @return the access type
     */
    public AccessType getAccessType() {
	return this.accessType;
    }

    /**
     * Sets the resrc defntn.
     *
     * @param resrcDefntn the new resrc defntn
     */
    protected void setResrcDefntn(String resrcDefntn) {
	this.resrcDefntn = resrcDefntn;
    }

    /**
     * Gets the resrc defntn.
     *
     * @return the resrc defntn
     */
    public String getResrcDefntn() {
	return this.resrcDefntn;
    }

    /**
     * Sets the screen name.
     *
     * @param screenName the new screen name
     */
    protected void setScreenName(String screenName) {
	this.screenName = screenName;
    }

    /**
     * Gets the screen name.
     *
     * @return the screen name
     */
    public String getScreenName() {
	return this.screenName;
    }

    /**
     * Sets the tool tip.
     *
     * @param toolTip the new tool tip
     */
    protected void setToolTip(String toolTip) {
	this.toolTip = toolTip;
    }

    /**
     * Gets the tool tip.
     *
     * @return the tool tip
     */
    public String getToolTip() {
	return this.toolTip;
    }

    /**
     * Instantiates a new resource.
     *
     * @param resrcName the resrc name
     * @param resrcDefntn the resrc defntn
     * @param screenName the screen name
     * @param toolTip the tool tip
     * @param accessType the access type
     * @param resrcType the resrc type
     */
    public Resource(String resrcName, String resrcDefntn, String screenName, String toolTip, String accessType, String resrcType) {
	this.resrcDefntn = resrcDefntn;
	this.screenName = screenName;
	this.toolTip = toolTip;
	this.resrcName = resrcName;
	if (AccessType.EDIT.getAccessTypeCd().equals(accessType)) {
	    this.accessType = AccessType.EDIT;
	} else if (AccessType.EXEC.getAccessTypeCd().equals(accessType)) {
	    this.accessType = AccessType.EXEC;
	} else if (AccessType.VIEW.getAccessTypeCd().equals(accessType)) {
	    this.accessType = AccessType.VIEW;
	} else if (AccessType.UPDATE.getAccessTypeCd().equals(accessType)) {
	    this.accessType = AccessType.UPDATE;
	} else {
	    this.accessType = AccessType.NONE;
	}
	if (ResourceType.SCREEN.getResourceTypeCd().equals(accessType)) {
	    this.resourceType = ResourceType.SCREEN;
	} else if (ResourceType.ATTRIBUTE.getResourceTypeCd().equals(accessType)) {
	    this.resourceType = ResourceType.ATTRIBUTE;
	} else if (ResourceType.SECTION.getResourceTypeCd().equals(accessType)) {
	    this.resourceType = ResourceType.SECTION;
	} else if (ResourceType.FUNCTION.getResourceTypeCd().equals(accessType)) {
	    this.resourceType = ResourceType.FUNCTION;
	}
    }

    /* (non-Javadoc)
     * @see java.lang.Object#toString()
     */
    public String toString() {
	return this.resrcName + "," + this.resrcDefntn + "," + this.screenName + "," + this.toolTip + "," + this.accessType + "," + this.resourceType;
    }

    /**
     * The Enum ResourceType.
     */
    public static enum ResourceType {
	
	/** The screen. */
	SCREEN("SCRN"), 
 /** The attribute. */
 ATTRIBUTE("ATTR"), 
 /** The section. */
 SECTION("SCTN"), 
 /** The function. */
 FUNCTION("FUNC");

	/** The rt code. */
	private String rtCode;

	/**
	 * Instantiates a new resource type.
	 *
	 * @param rtCode the rt code
	 */
	private ResourceType(String rtCode) {
	    this.rtCode = rtCode;
	}

	/**
	 * Gets the resource type cd.
	 *
	 * @return the resource type cd
	 */
	public String getResourceTypeCd() {
	    return this.rtCode;
	}
    }

    /**
     * The Enum AccessType.
     */
    public static enum AccessType {
	
	/** The edit. */
	EDIT("ED"), 
 /** The exec. */
 EXEC("EX"), 
 /** The none. */
 NONE("N"), 
 /** The view. */
 VIEW("V"), 
 /** The update. */
 UPDATE("UPD");

	/** The rt code. */
	private String rtCode;

	/**
	 * Instantiates a new access type.
	 *
	 * @param rtCode the rt code
	 */
	private AccessType(String rtCode) {
	    this.rtCode = rtCode;
	}

	/**
	 * Gets the access type cd.
	 *
	 * @return the access type cd
	 */
	public String getAccessTypeCd() {
	    return this.rtCode;
	}
    }
}
