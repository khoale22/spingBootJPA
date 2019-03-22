/*
 * EBMBDACandidateWorkRequestCreator
 *
 *  Copyright (c) 2019 HEB
 *  All rights reserved.
 *
 *  This software is the confidential and proprietary information
 *  of HEB.
 */
package com.heb.pm.batchUpload.eBM_BDA;

import com.heb.pm.batchUpload.parser.CandidateWorkRequestCreator;
import com.heb.pm.batchUpload.parser.ProductAttribute;
import com.heb.pm.batchUpload.parser.WorkRequestCreatorUtils;
import com.heb.pm.entity.*;
import com.heb.pm.repository.ClassCommodityRepository;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class EBMBDACandidateWorkRequestCreator extends CandidateWorkRequestCreator {

    private static final String SINGLE_SPACE = " ";
    private static final String STRING_EMPTY = "EMPTY";

    @Autowired
    private EBMBDAValidator eBMBDAValidator;

    @Override
    public CandidateWorkRequest createRequest(List<String> cellValues, List<ProductAttribute> productAttributes, long transactionId, String userId) {
        EBMBDABatchUpload ebmbdaBatchUpload = this.createEBMBDABatchUpload(cellValues);
        this.eBMBDAValidator.validateRow(ebmbdaBatchUpload);
        CandidateWorkRequest candidateWorkRequest =
                WorkRequestCreatorUtils.getEmptyWorkRequest(null, null, userId, transactionId,
                        CandidateWorkRequest.SRC_SYSTEM_ID_DEFAULT, getBatchStatus(ebmbdaBatchUpload).getName());
        if (!ebmbdaBatchUpload.hasErrors()) {
            setDataToCandidateClassCommodity(candidateWorkRequest, ebmbdaBatchUpload);
            setDataToCandidateStatus(candidateWorkRequest, ebmbdaBatchUpload);
        } else {
            setDataToCandidateStatus(candidateWorkRequest, ebmbdaBatchUpload);
        }
        return candidateWorkRequest;
    }

    /**
     * set data to CandidateClassCommodity
     *
     * @param candidateWorkRequest the CandidateWorkRequest
     * @param eBMBDABatchUpload    the EBMBDABatchUpload
     */
    public void setDataToCandidateClassCommodity(CandidateWorkRequest candidateWorkRequest, EBMBDABatchUpload eBMBDABatchUpload) {

        CandidateClassCommodity candidateClassCommodity = new CandidateClassCommodity();
        CandidateClassCommodityKey candidateClassCommodityKey = new CandidateClassCommodityKey();
        candidateClassCommodityKey.setClassCode(Integer.valueOf(eBMBDABatchUpload.getClassCode()));
        candidateClassCommodityKey.setCommodityCode(Integer.valueOf(eBMBDABatchUpload.getCommodityCode()));
        candidateClassCommodity.setKey(candidateClassCommodityKey);
        candidateClassCommodity.seteBMid(this.getEBMBDAId(eBMBDABatchUpload.geteBMid()));
        candidateClassCommodity.setbDAid(this.getEBMBDAId(eBMBDABatchUpload.getbDAid()));
        candidateClassCommodity.setCreateDate(LocalDateTime.now());
        candidateClassCommodity.setCreateUserId(candidateWorkRequest.getUserId());
        candidateClassCommodity.setLastUpdateDate(LocalDateTime.now());
        candidateClassCommodity.setLastUpdateUserId(candidateWorkRequest.getUserId());
        candidateClassCommodity.setCandidateWorkRequest(candidateWorkRequest);

        candidateWorkRequest.setCandidateClassCommodities(new ArrayList<CandidateClassCommodity>());
        candidateWorkRequest.getCandidateClassCommodities().add(candidateClassCommodity);
    }

    /**
     * get value for edm, bda.
     *
     * @param value the value of ebm, bda.
     * @return the id of ebm, bda
     */
    public String getEBMBDAId(String value) {
        //If value is null or empty then return null.
        if (StringUtils.trimToEmpty(value).equals(StringUtils.EMPTY)) return null;
        //If value is 'empty' or 'EMPTY' then return blank.
        if (StringUtils.trimToEmpty(value).toUpperCase().equals(STRING_EMPTY)) return SINGLE_SPACE;
        // If value is not null, not empty and not 'empty' then return value.
        return value.trim();
    }

    /**
     * set Data To CandidateStatus.
     *
     * @param candidateWorkRequest the CandidateWorkRequest
     * @param eBMBDABatchUpload    the EBMBDABatchUpload
     */
    public void setDataToCandidateStatus(CandidateWorkRequest candidateWorkRequest, EBMBDABatchUpload eBMBDABatchUpload) {
        String errorMessage = eBMBDABatchUpload.hasErrors() ? eBMBDABatchUpload.getErrors().get(0) : StringUtils.EMPTY;
        candidateWorkRequest.setCandidateStatuses(new ArrayList<CandidateStatus>());
        CandidateStatusKey key = new CandidateStatusKey();
        key.setStatus(this.getBatchStatus(eBMBDABatchUpload).getName());
        key.setLastUpdateDate(LocalDateTime.now());
        CandidateStatus candidateStatus = new CandidateStatus();
        candidateStatus.setKey(key);
        candidateStatus.setUpdateUserId(candidateWorkRequest.getUserId());
        candidateStatus.setStatusChangeReason(CandidateStatus.STAT_CHG_RSN_ID_WRKG);
        candidateStatus.setCommentText(errorMessage);
        candidateStatus.setCandidateWorkRequest(candidateWorkRequest);
        candidateWorkRequest.getCandidateStatuses().add(candidateStatus);
    }

    /**
     * Create data for EBMBDABatchUpload.
     *
     * @param cellValues the cell value.
     * @return the EBMBDABatchUpload
     */
    private EBMBDABatchUpload createEBMBDABatchUpload(List<String> cellValues) {
        EBMBDABatchUpload eBMBDABatchUpload = new EBMBDABatchUpload();
        String value;
        for (int j = 0; j < cellValues.size(); j++) {
            value = cellValues.get(j);
            switch (j) {
                case EBMBDABatchUpload.COL_POS_CLASS_CODE:
                    eBMBDABatchUpload.setClassCode(value);
                    break;
                case EBMBDABatchUpload.COL_POS_COMMODITY_CODE:
                    eBMBDABatchUpload.setCommodityCode(value);
                    break;
                case EBMBDABatchUpload.COL_POS_EBM_CODE:
                    eBMBDABatchUpload.seteBMid(value);
                    break;
                case EBMBDABatchUpload.COL_POS_BDA_CODE:
                    eBMBDABatchUpload.setbDAid(value);
                    break;
            }
        }
        return eBMBDABatchUpload;
    }
}
