/*
 *  BatchUploadDataMap
 *  Copyright (c) 2017 HEB
 *  All rights reserved.
 *
 *  This software is the confidential and proprietary information of HEB.
 */
package com.heb.pm.batchUpload;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * This is BatchUploadDataMap class.
 *
 * @author vn55306
 * @since 2.8.0
 */
@Service
public class BatchUploadDataMap {
    private Map<Long, BatchUploadType> parametersMap;

    /**
     * Constructs a new BatuploadParameterMap.
     */
    public BatchUploadDataMap() {
        this.parametersMap = new HashMap<>();
    }

    /**
     * Adds a new set of parameters to the map
     *
     * @param transactionId The transaction id for the parameters. This will be used as the key.
     * @param parameters The parameters to add.
     */
    public void add(Long transactionId, BatchUploadType parameters) {
        this.parametersMap.put(transactionId, parameters);
    }

    /**
     * Returns the parameters for a given ID. This is a destructive read and they will no longer be available after
     * being read.
     *
     * @param transactionId The ID of the parameters to look for.
     * @return The parameters tied to transactionId. If none are found, it returns null.
     */
    public BatchUploadType get(Long transactionId) {
        return this.parametersMap.remove(transactionId);
    }
}
