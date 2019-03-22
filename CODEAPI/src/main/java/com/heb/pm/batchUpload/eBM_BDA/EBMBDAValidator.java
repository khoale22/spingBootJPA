/*
 * EBMBDAValidator
 *
 *  Copyright (c) 2019 HEB
 *  All rights reserved.
 *
 *  This software is the confidential and proprietary information
 *  of HEB.
 */
package com.heb.pm.batchUpload.eBM_BDA;

import com.heb.pm.batchUpload.AbstractBatchUploadValidator;
import com.heb.pm.batchUpload.BatchUpload;
import com.heb.pm.batchUpload.UnexpectedInputException;
import com.heb.pm.entity.ClassCommodity;
import com.heb.pm.repository.ClassCommodityRepository;
import com.heb.pm.user.UserService;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

/**
 * Holds all validate of eBM_BDA Batch Upload.
 *
 * @author VN70529
 * @since 2.33.0
 */
@Component
public class EBMBDAValidator extends AbstractBatchUploadValidator {
    private static final Logger LOGGER = LoggerFactory.getLogger(EBMBDAValidator.class);

    private static final Character CLASS_COMMODITY_ACTIVE_CODE = 'A';
    private static final String ERROR_COMMODITY_NOT_ACTIVE = "Commodity is not active.";
    private static final String ERROR_CLASS_COMMODITY_NOT_MATCH_HIERARCHY = "Commodity/Class is not under the same hierarchy.";
    private static final String ERROR_COMMODITY_MANDATORY_FIELD = "OMI Commodity ID field is mandatory.";
    private static final String ERROR_COMMODITY_TYPE_NUMBER = "OMI Commodity ID must be integer number.";
    private static final String ERROR_COMMODITY_VALUE = "OMI Commodity ID must be greater than 0 and less than 10000.";
    private static final String ERROR_CLASS_MANDATORY_FIELD = "Class field is mandatory.";
    private static final String ERROR_CLASS_TYPE_NUMBER = "Class must be integer number.";
    private static final String ERROR_CLASS_VALUE = "Class ID must be greater than 1 and less than 99.";
    private static final String ERROR_ONE_PASS_ID_NOT_VALID = "OnePass ID is not valid.";
    private static final String STRING_EMPTY = "EMPTY";
    private static final int DEFAULT_SHEET = 0;
    private static final int DEFAULT_ROW_BEGIN_READ_DATA = 0;

    private EBMBDABatchUpload eBMBDABatchUpload;
    private ClassCommodity classCommodity;

    @Autowired
    private ClassCommodityRepository classCommodityRepository;
    @Autowired
    private UserService userService;

    public void validateRow(BatchUpload batchUpload) {
        this.eBMBDABatchUpload = (EBMBDABatchUpload) batchUpload;
        this.validateClassCode();
        if (!this.eBMBDABatchUpload.hasErrors()) this.validateCommodityCode();
        if (!this.eBMBDABatchUpload.hasErrors()) this.validateClassCommodityCode();
        if (!this.eBMBDABatchUpload.hasErrors()) this.validateEBM();
        if (!this.eBMBDABatchUpload.hasErrors()) this.validateBDA();
    }

    /**
     * Validate class code.
     */
    private void validateClassCode() {
        if (!StringUtils.trimToEmpty(this.eBMBDABatchUpload.getClassCode()).equals(StringUtils.EMPTY)) {
            try {
                int classCode = Integer.parseInt(this.eBMBDABatchUpload.getClassCode());
                if (classCode <= 1 || classCode >= 99) {
                    this.eBMBDABatchUpload.getErrors().add(ERROR_CLASS_VALUE);
                }
            } catch (NumberFormatException ex) {
                this.eBMBDABatchUpload.getErrors().add(ERROR_CLASS_TYPE_NUMBER);
            }
        } else {
            this.eBMBDABatchUpload.getErrors().add(ERROR_CLASS_MANDATORY_FIELD);
        }
    }

    /**
     * Validate commodity code.
     */
    private void validateCommodityCode() {
        if (!StringUtils.trimToEmpty(this.eBMBDABatchUpload.getCommodityCode()).equals(StringUtils.EMPTY)) {
            try {
                int commodityCode = Integer.parseInt(this.eBMBDABatchUpload.getCommodityCode());
                if (commodityCode <= 0 || commodityCode > 9999) {
                    this.eBMBDABatchUpload.getErrors().add(ERROR_COMMODITY_VALUE);
                }
            } catch (NumberFormatException ex) {
                this.eBMBDABatchUpload.getErrors().add(ERROR_COMMODITY_TYPE_NUMBER);
            }
        } else {
            this.eBMBDABatchUpload.getErrors().add(ERROR_COMMODITY_MANDATORY_FIELD);
        }
    }

    /**
     * Validate class commodity has active.
     */
    private void validateClassCommodityCode() {
        int classCode = Integer.parseInt(this.eBMBDABatchUpload.getClassCode());
        int commodityCode = Integer.parseInt(this.eBMBDABatchUpload.getCommodityCode());
        this.classCommodity = this.classCommodityRepository.findFirstByKeyClassCodeAndKeyCommodityCode(classCode, commodityCode);
        if (this.classCommodity == null) {
            this.eBMBDABatchUpload.getErrors().add(ERROR_CLASS_COMMODITY_NOT_MATCH_HIERARCHY);
        } else {
            if (!this.classCommodity.getClassCommodityActive().equals(CLASS_COMMODITY_ACTIVE_CODE)) {
                this.eBMBDABatchUpload.getErrors().add(ERROR_COMMODITY_NOT_ACTIVE);
            }
        }
    }

    /**
     * Validate for ebm id.
     */
    private void validateEBM() {
        if (!StringUtils.trimToEmpty(this.eBMBDABatchUpload.geteBMid()).equals(StringUtils.EMPTY) && !this.eBMBDABatchUpload.geteBMid().trim().toUpperCase().equals(STRING_EMPTY)
                && this.userService.getUserById(StringUtils.trim(this.eBMBDABatchUpload.geteBMid())) == null) {
            this.eBMBDABatchUpload.getErrors().add(ERROR_ONE_PASS_ID_NOT_VALID);
        }
    }

    /**
     * Validate for bda id.
     */
    private void validateBDA() {
        if (!StringUtils.trimToEmpty(this.eBMBDABatchUpload.getbDAid()).equals(StringUtils.EMPTY) && !this.eBMBDABatchUpload.getbDAid().trim().toUpperCase().equals(STRING_EMPTY)
                && this.userService.getUserById(StringUtils.trim(this.eBMBDABatchUpload.getbDAid())) == null) {
            this.eBMBDABatchUpload.getErrors().add(ERROR_ONE_PASS_ID_NOT_VALID);
        }
    }

    /**
     * Validate File Upload.
     *
     * @param data the byte[]
     * @throws UnexpectedInputException The UnexpectedInputException
     */
    public void validateTemplate(byte[] data) throws UnexpectedInputException {
        try {
            InputStream inputStream = new ByteArrayInputStream(data);
            Workbook workBook = new XSSFWorkbook(inputStream);
            int numberOfSheets = workBook.getNumberOfSheets();
            if (numberOfSheets > 0) {
                Row row = workBook.getSheetAt(DEFAULT_SHEET).getRow(DEFAULT_ROW_BEGIN_READ_DATA);
                String header;
                for (int columnCounter = 0; columnCounter < row.getLastCellNum(); columnCounter++) {
                    header = getValueOfCell(row.getCell(columnCounter));
                    header = header != null ? header.trim() : StringUtils.EMPTY;
                    if (eBMBDABatchUpload.uploadFileHeader.containsKey(columnCounter) && !eBMBDABatchUpload.uploadFileHeader.get(columnCounter).equalsIgnoreCase(header)) {
                        throw new UnexpectedInputException(AbstractBatchUploadValidator.ERROR_FILE_WRONG_FORMAT);
                    }
                }
            }
        } catch (Exception e) {
            throw new UnexpectedInputException(AbstractBatchUploadValidator.ERROR_FILE_WRONG_FORMAT);
        }
    }
}
