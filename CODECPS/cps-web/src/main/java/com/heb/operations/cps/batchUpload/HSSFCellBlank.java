package com.heb.operations.cps.batchUpload;

import org.apache.poi.hssf.usermodel.HSSFCell;

import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.vo.BatchVO;

public class HSSFCellBlank {
	/**
	 * To insert the Excel String value into VO
	 * @param cell
	 * @param batchVO
	 */
	public void cellHSSFBlank(HSSFCell cell, BatchVO batchVO) {
		int cellNumber = cell.getCellNum();
		if (0 == cellNumber) {
			batchVO.setUnitUPCCheckDigit(CPSConstants.EMPTY_STRING);
		}
		if (1 == cellNumber) {

			batchVO.setItemDescription(CPSConstants.EMPTY_STRING);
		}
		if (2 == cellNumber) {

			batchVO.setItemSizeQty(CPSConstants.EMPTY_STRING);
		}
		if (3 == cellNumber) {

			batchVO.setReceipSW(CPSConstants.EMPTY_STRING);
		}
		if (4 == cellNumber) {

			batchVO.setUpcTypeCD(CPSConstants.EMPTY_STRING);
		}
		if (5 == cellNumber) {

			batchVO.setWhareHouseDSDCD(CPSConstants.EMPTY_STRING);
		}
		if (6 == cellNumber) {

			batchVO.setSellUnitQty(CPSConstants.EMPTY_STRING);
		}
		if (7 == cellNumber) {

			batchVO.setUnitUOMText(CPSConstants.EMPTY_STRING);
		}
		if (8 == cellNumber) {

			batchVO.setProdDesTag1Eng(CPSConstants.EMPTY_STRING);
		}
		if (9 == cellNumber) {

			batchVO.setProdDesTag2Eng(CPSConstants.EMPTY_STRING);
		}
		if (10 == cellNumber) {

			batchVO.setFcDpDeptNo(CPSConstants.EMPTY_STRING);
		}
		if (11 == cellNumber) {

			batchVO.setFcDpSubDeptCD(CPSConstants.EMPTY_STRING);
		}
		if (12 == cellNumber) {

			batchVO.setProdOmiComCD(CPSConstants.EMPTY_STRING);
		}
		if (13 == cellNumber) {

			batchVO.setProdOmiSubComCD(CPSConstants.EMPTY_STRING);
		}
		if (14 == cellNumber) {

			batchVO.setBuyerCd(CPSConstants.EMPTY_STRING);
		}
		if (15 == cellNumber) {

			batchVO.setProdDeptNo(CPSConstants.EMPTY_STRING);
		}
		if (16 == cellNumber) {

			batchVO.setProdItemCatCD(CPSConstants.EMPTY_STRING);
		}
		if (17 == cellNumber) {

			batchVO.setVdStrPrcGrpCD(CPSConstants.EMPTY_STRING);
		}
		if (18 == cellNumber) {

			batchVO.setStoreNo(CPSConstants.EMPTY_STRING);
		}
		if (19 == cellNumber) {

			batchVO.setProdRetailHT(CPSConstants.EMPTY_STRING);
		}
		if (20 == cellNumber) {

			batchVO.setProdRetailLN(CPSConstants.EMPTY_STRING);
		}
		if (21 == cellNumber) {

			batchVO.setProdRetailWD(CPSConstants.EMPTY_STRING);
		}
		if (22 == cellNumber) {

			batchVO.setVendorNo(CPSConstants.EMPTY_STRING);
		}
		if (23 == cellNumber) {

			batchVO.setProdVendorCodeNo(CPSConstants.EMPTY_STRING);
		}
		if (24 == cellNumber) {

			batchVO.setProdMastPKQty(CPSConstants.EMPTY_STRING);
		}
		if (25 == cellNumber) {

			batchVO.setProdListCST(CPSConstants.EMPTY_STRING);
		}
		if (26 == cellNumber) {

			batchVO.setProdCoreUX4Qty(CPSConstants.EMPTY_STRING);
		}
		if (27 == cellNumber) {

			batchVO.setProdCoreUnitCST(CPSConstants.EMPTY_STRING);
		}
		if (28 == cellNumber) {

			batchVO.setProdCoreChangeCD(CPSConstants.EMPTY_STRING);
		}
		if (29 == cellNumber) {

			batchVO.setProdCoreLinkCD(CPSConstants.EMPTY_STRING);
		}
		if (30 == cellNumber) {

			batchVO.setProdCoreMatrixSW(CPSConstants.EMPTY_STRING);
		}
		if (31 == cellNumber) {

			batchVO.setProdCritItemCD(CPSConstants.EMPTY_STRING);
		}
		if (32 == cellNumber) {

			batchVO.setProdCorePrepdPCT(CPSConstants.EMPTY_STRING);
		}
		if (33 == cellNumber) {

			batchVO.setProdPrfxForQty(CPSConstants.EMPTY_STRING);
		}
		if (34 == cellNumber) {

			batchVO.setProdPrfxPriceCST(CPSConstants.EMPTY_STRING);
		}
		if (35 == cellNumber) {

			batchVO.setProdCoreTagCD(CPSConstants.EMPTY_STRING);
		}
		if (36 == cellNumber) {

			batchVO.setProdTagSZCD(CPSConstants.EMPTY_STRING);
		}
		if (37 == cellNumber) {

			batchVO.setProdNoTagQty(CPSConstants.EMPTY_STRING);
		}
		if (38 == cellNumber) {

			batchVO.setProdCrgTaxQty(CPSConstants.EMPTY_STRING);
		}
		if (39 == cellNumber) {

			batchVO.setProdFdStampCD(CPSConstants.EMPTY_STRING);
		}
		if (40 == cellNumber) {

			batchVO.setProdFamOneCD(CPSConstants.EMPTY_STRING);
		}
		if (41 == cellNumber) {

			batchVO.setProdFamTwoCD(CPSConstants.EMPTY_STRING);
		}
		if (42 == cellNumber) {

			batchVO.setCstOwnID(CPSConstants.EMPTY_STRING);
		}
		if (43 == cellNumber) {

			batchVO.setProdBrandID(CPSConstants.EMPTY_STRING);
		}
		if (44 == cellNumber) {

			batchVO.setT2tID(CPSConstants.EMPTY_STRING);
		}
		if (45 == cellNumber) {
			batchVO.setProdSubBrandID(CPSConstants.EMPTY_STRING);
		}
		if (46 == cellNumber) {
			batchVO.setCntryOfOrginID(CPSConstants.EMPTY_STRING);
		}
		if (47 == cellNumber) {
			batchVO.setComments(CPSConstants.EMPTY_STRING);
		}
		if (48 == cellNumber) {
			batchVO.setPackaging(CPSConstants.EMPTY_STRING);
		}
	}
}
