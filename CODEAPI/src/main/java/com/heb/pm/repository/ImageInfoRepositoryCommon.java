/*
 *  ImageInfoRepositoryCommon
 *
 *  Copyright (c) 2018 HEB
 *  All rights reserved.
 *
 *  This software is the confidential and proprietary information
 *  of HEB.
 */
package com.heb.pm.repository;

/**
 * Repository constants for queries to retrieve image information.
 *
 * @author vn70529
 * @since 2.27.0
 */
public interface ImageInfoRepositoryCommon {

    /**
     * The query for fetching the submitted image with not rejected image
     * by the list of upcs and active switch equals true and active online equals false and imageFormat is not equals 'TGA'
     * and isShowRejected.
     */
    String QUERY_FIND_SUBMITTED_IMAGE_NOT_REJECTED_BY_UPCS = "FROM ProductScanImageURI i WHERE" +
            " i.key.id in (:upcs) AND i.activeSwitch = 'Y'" +
            " AND TRIM(i.imageStatusCode) != 'R' AND" +
            " i.activeOnline = 'N' AND i.imageType.imageFormat != 'TGA'";

    /**
     * The query for fetching the submitted image with not rejected image or rejected images of 3 months from today's date
     * by the list of upcs and active switch equals true and active online equals false and imageFormat is not equals 'TGA'
     * and isShowRejected.
     */
    String QUERY_FIND_SUBMITTED_IMAGE_BY_UPCS = "FROM ProductScanImageURI i WHERE" +
            " i.key.id in (:upcs) AND i.activeSwitch = 'Y'" +
            " AND (TRIM(i.imageStatusCode) != 'R' OR (TRIM(i.imageStatusCode) = 'R' AND i.lastModifiedOn >= ADD_MONTHS(trunc(CURRENT_DATE),-3))) AND" +
            " i.activeOnline = 'N' AND i.imageType.imageFormat != 'TGA'";

    /**
     * The query find all active online image
     * by the list of upcs and active switch equals true and active online equals true
     * and imageFormat is not equals 'TGA'.
     */
    String QUERY_FIND_ACTIVE_ONLINE_IMAGE_BY_UPCS = "FROM ProductScanImageURI i WHERE" +
            " i.key.id in (:upcs) AND i.activeSwitch = 'Y'" +
            " AND i.activeOnline = 'Y' AND i.imageType.imageFormat != 'TGA'";

    /**
     * The query find all priamry image
     * by the list of upcs and active switch equals true and image priority code equals 'P'
     * and imageFormat is not equals 'TGA'.
     */
    String QUERY_FIND_PRIMARY_IMAGE_BY_UPCS = "FROM ProductScanImageURI i WHERE" +
            " i.key.id in (:upcs) AND i.activeSwitch = 'Y'" +
            " AND TRIM(i.imagePriorityCode) = 'P' AND i.imageType.imageFormat != 'TGA'";
}
