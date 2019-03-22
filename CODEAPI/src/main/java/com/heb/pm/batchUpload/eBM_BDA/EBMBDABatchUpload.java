/*
 * EBMBDABatchUpload
 *
 *  Copyright (c) 2019 HEB
 *  All rights reserved.
 *
 *  This software is the confidential and proprietary information
 *  of HEB.
 */
package com.heb.pm.batchUpload.eBM_BDA;

import com.heb.pm.batchUpload.BatchUpload;

import java.util.HashMap;
import java.util.Map;

public class EBMBDABatchUpload extends BatchUpload {

    /*
     * serialVersionUID.
     */
    private static final long serialVersionUID = 1L;

    public static final int COL_POS_CLASS_CODE=0;
    public static final String COL_NM_CLASS_CODE = "Class";
    public static final int COL_POS_COMMODITY_CODE=1;
    public static final String COL_NM_COMMODITY_CODE = "OMI Commodity ID";
    public static final int COL_POS_EBM_CODE =2;
    public static final String COL_NM_EBM_CODE = "eBM OnePass ID";
    public static final int COL_POS_BDA_CODE =3;
    public static final String COL_NM_BDA_CODE = "BDA OnePass ID";

    private String classCode;
    private String commodityCode;
    private String eBMid;
    private String bDAid;

    public static final Map<Integer,String> uploadFileHeader;
    static {
        uploadFileHeader = new HashMap<>();
        uploadFileHeader.put(COL_POS_CLASS_CODE, COL_NM_CLASS_CODE);
        uploadFileHeader.put(COL_POS_COMMODITY_CODE, COL_NM_COMMODITY_CODE);
        uploadFileHeader.put(COL_POS_EBM_CODE, COL_NM_EBM_CODE);
        uploadFileHeader.put(COL_POS_BDA_CODE, COL_NM_BDA_CODE);
    }

    /**
     * Returns the class code.
     *
     * @return The class code.
     */
    public String getClassCode() {
        return classCode;
    }

    /**
     * Sets the class code.
     *
     * @param classCode The class code.
     **/
    public void setClassCode(String classCode) {
        this.classCode = classCode;
    }

    /**
     * Returns the commodity code.
     *
     * @return The commodity code.
     */
    public String getCommodityCode() {
        return commodityCode;
    }

    /**
     * Sets the commodity code.
     *
     * @param commodityCode The commodity code.
     **/
    public void setCommodityCode(String commodityCode) {
        this.commodityCode = commodityCode;
    }

    /**
     * Returns the eBM id.
     *
     * @return The eBM id.
     **/
    public String geteBMid() {
        return eBMid;
    }

    /**
     * Sets the eBM id.
     *
     * @param eBMid The eBM id.
     **/
    public void seteBMid(String eBMid) {
        this.eBMid = eBMid;
    }

    /**
     * Returns the BDA id.
     *
     * @return The BDA id.
     **/
    public String getbDAid() {
        return bDAid;
    }

    /**
     * Sets the BDA id.
     *
     * @param bDAid The BDA id.
     **/
    public void setbDAid(String bDAid) {
        this.bDAid = bDAid;
    }
}
