package com.heb.operations.cps.batchUpload;

import org.apache.poi.hssf.usermodel.HSSFCell;

import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.vo.BatchVO;


public class HSSFCellString {
	/**
     * To insert the Excel String value into VO
     * @param cell
     * @param batchVO
     */
	public void cellHSSFString(HSSFCell cell, BatchVO batchVO) {
		int cellNumber = cell.getCellNum();
		if (0 == cellNumber) {
			String upcWithCheckDigit = cell.getRichStringCellValue()
					.getString().trim();
			batchVO.setUnitUPCCheckDigit(CPSHelper.getTrimmedValue(upcWithCheckDigit));
		}
		if (1 == cellNumber) {
			String itemDescription = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setItemDescription(CPSHelper.getTrimmedValue(itemDescription));
		}
		if (2 == cellNumber) {
			String itemSizeQuantity = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setItemSizeQty(CPSHelper.getTrimmedValue(itemSizeQuantity));
		}
		if (3 == cellNumber) {
			String receiptSw = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setReceipSW(CPSHelper.getTrimmedValue(receiptSw));
		}
		if (4 == cellNumber) {
			String upcTypeCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setUpcTypeCD(CPSHelper.getTrimmedValue(upcTypeCD));
		}
		if (5 == cellNumber) {
			String whareHouseDSDCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setWhareHouseDSDCD(CPSHelper.getTrimmedValue(whareHouseDSDCD));
		}
		if (6 == cellNumber) {
			String sellUnitQty = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setSellUnitQty(CPSHelper.getTrimmedValue(sellUnitQty));
		}
		if (7 == cellNumber) {
			String unitUOMText = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setUnitUOMText(CPSHelper.getTrimmedValue(unitUOMText));
		}
		if (8 == cellNumber) {
			String prodDesTag1Eng = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdDesTag1Eng(CPSHelper.getTrimmedValue(prodDesTag1Eng));
		}
		if (9 == cellNumber) {
			String prodDesTag2Eng = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdDesTag2Eng(CPSHelper.getTrimmedValue(prodDesTag2Eng));
		}
		if (10 == cellNumber) {
			String fcDpDeptNo = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setFcDpDeptNo(CPSHelper.getTrimmedValue(fcDpDeptNo));
		}
		if (11 == cellNumber) {
			String fcDpSubDeptCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setFcDpSubDeptCD(CPSHelper.getTrimmedValue(fcDpSubDeptCD));
		}
		if (12 == cellNumber) {
			String prodOmiComCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdOmiComCD(CPSHelper.getTrimmedValue(prodOmiComCD));
		}
		if (13 == cellNumber) {
			String prodOmiSubComCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdOmiSubComCD(CPSHelper.getTrimmedValue(prodOmiSubComCD));
		}
		if (14 == cellNumber) {
			String buyerCd = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setBuyerCd(CPSHelper.getTrimmedValue(buyerCd));
		}
		if (15 == cellNumber) {
			String prodDeptNo = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdDeptNo(CPSHelper.getTrimmedValue(prodDeptNo));
		}
		if (16 == cellNumber) {
			String prodItemCatCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdItemCatCD(CPSHelper.getTrimmedValue(prodItemCatCD));
		}
		if (17 == cellNumber) {
			String vdStrPrcGrpCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setVdStrPrcGrpCD(CPSHelper.getTrimmedValue(vdStrPrcGrpCD));
		}
		if (18 == cellNumber) {
			String storeNo = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setStoreNo(CPSHelper.getTrimmedValue(storeNo));
		}
		if (19 == cellNumber) {
			String prodRetailHT = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdRetailHT(CPSHelper.getTrimmedValue(prodRetailHT));
		}
		if (20 == cellNumber) {
			String prodRetailLN = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdRetailLN(CPSHelper.getTrimmedValue(prodRetailLN));
		}
		if (21 == cellNumber) {
			String prodRetailWD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdRetailWD(CPSHelper.getTrimmedValue(prodRetailWD));
		}
		if (22 == cellNumber) {
			String vendorNo = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setVendorNo(CPSHelper.getTrimmedValue(vendorNo));
		}
		if (23 == cellNumber) {
			String prodVendorCodeNo = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdVendorCodeNo(CPSHelper.getTrimmedValue(prodVendorCodeNo));
		}
		if (24 == cellNumber) {
			String prodMastPKQty = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdMastPKQty(CPSHelper.getTrimmedValue(prodMastPKQty));
		}
		if (25 == cellNumber) {
			String prodListCST = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdListCST(CPSHelper.getTrimmedValue(prodListCST));
		}
		if (26 == cellNumber) {
			String prodCoreUX4Qty = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdCoreUX4Qty(CPSHelper.getTrimmedValue(prodCoreUX4Qty));
		}
		if (27 == cellNumber) {
			String prodCoreUnitCST = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdCoreUnitCST(CPSHelper.getTrimmedValue(prodCoreUnitCST));
		}
		if (28 == cellNumber) {
			String prodCoreChangeCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdCoreChangeCD(CPSHelper.getTrimmedValue(prodCoreChangeCD));
		}
		if (29 == cellNumber) {
			String prodCoreLinkCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdCoreLinkCD(CPSHelper.getTrimmedValue(prodCoreLinkCD));
		}
		if (30 == cellNumber) {
			String prodCoreMatrixSW = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdCoreMatrixSW(CPSHelper.getTrimmedValue(prodCoreMatrixSW));
		}
		if (31 == cellNumber) {
			String prodCritItemCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdCritItemCD(CPSHelper.getTrimmedValue(prodCritItemCD));
		}
		if (32 == cellNumber) {
			String prodCorePrepdPCT = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdCorePrepdPCT(CPSHelper.getTrimmedValue(prodCorePrepdPCT));
		}
		if (33 == cellNumber) {
			String prodPrfxForQty = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdPrfxForQty(CPSHelper.getTrimmedValue(prodPrfxForQty));
		}
		if (34 == cellNumber) {
			String prodPrfxPriceCST = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdPrfxPriceCST(CPSHelper.getTrimmedValue(prodPrfxPriceCST));
		}
		if (35 == cellNumber) {
			String prodCoreTagCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdCoreTagCD(CPSHelper.getTrimmedValue(prodCoreTagCD));
		}
		if (36 == cellNumber) {
			String prodTagSZCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdTagSZCD(CPSHelper.getTrimmedValue(prodTagSZCD));
		}
		if (37 == cellNumber) {
			String prodNoTagQty = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdNoTagQty(CPSHelper.getTrimmedValue(prodNoTagQty));
		}
		if (38 == cellNumber) {
			String prodCrgTaxQty = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdCrgTaxQty(CPSHelper.getTrimmedValue(prodCrgTaxQty));
		}
		if (39 == cellNumber) {
			String prodFdStampCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdFdStampCD(CPSHelper.getTrimmedValue(prodFdStampCD));
		}
		if (40 == cellNumber) {
			String prodFamOneCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdFamOneCD(CPSHelper.getTrimmedValue(prodFamOneCD));
		}
		if (41 == cellNumber) {
			String prodFamTwoCD = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdFamTwoCD(CPSHelper.getTrimmedValue(prodFamTwoCD));
		}
		if (42 == cellNumber) {
			String cstOwnID = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setCstOwnID(CPSHelper.getTrimmedValue(cstOwnID));
		}
		if (43 == cellNumber) {
			String prodBrandID = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdBrandID(CPSHelper.getTrimmedValue(prodBrandID));
		}
		if (44 == cellNumber) {
			String t2tID = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setT2tID(CPSHelper.getTrimmedValue(t2tID));
		}
		if (45 == cellNumber) {
			String prodSubBrandID = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setProdSubBrandID(CPSHelper.getTrimmedValue(prodSubBrandID));
		}
		if (46 == cellNumber) {
			String cntryOfOrginID = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setCntryOfOrginID(CPSHelper.getTrimmedValue(cntryOfOrginID));
		}
		if (47 == cellNumber) {
			String comments = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setComments(CPSHelper.getTrimmedValue(comments));
		}
		if (48 == cellNumber) {
			String packaging = cell.getRichStringCellValue().getString()
					.trim();
			batchVO.setPackaging(CPSHelper.getTrimmedValue(packaging));
		}
	}
}
