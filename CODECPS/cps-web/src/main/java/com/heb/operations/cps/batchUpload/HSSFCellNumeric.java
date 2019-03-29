package com.heb.operations.cps.batchUpload;

import org.apache.poi.hssf.usermodel.HSSFCell;

import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.vo.BatchVO;


public class HSSFCellNumeric {
    /**
     * To insert the Excel numeric value longo VO
     * @param cell
     * @param batchVO
     */
	public void cellHSSFNumeric(HSSFCell cell, BatchVO batchVO) {
		long cellNumber = cell.getCellNum();
		if (0 == cellNumber) {
			long upcWithCheckDigit = (long) cell.getNumericCellValue();
			batchVO.setUnitUPCCheckDigit(CPSHelper.getTrimmedValue(String.valueOf(upcWithCheckDigit)));
		}
		if (1 == cellNumber) {
			long itemDescription = (long) cell.getNumericCellValue();
			batchVO.setItemDescription(CPSHelper.getTrimmedValue(String.valueOf(itemDescription)));
		}
		if (2 == cellNumber) {
			long itemSizeQuantity = (long) cell.getNumericCellValue();
			batchVO.setItemSizeQty(CPSHelper.getTrimmedValue(String.valueOf(itemSizeQuantity)));
		}
		if (3 == cellNumber) {
			long receiptSw =(long) cell.getNumericCellValue();
			batchVO.setReceipSW(CPSHelper.getTrimmedValue(String.valueOf(receiptSw)));
		}
		if (4 == cellNumber) {
			long upcTypeCD = (long) cell.getNumericCellValue();
			batchVO.setUpcTypeCD(CPSHelper.getTrimmedValue(String.valueOf(upcTypeCD)));
		}
		if (5 == cellNumber) {
			long whareHouseDSDCD = (long) cell.getNumericCellValue();
			batchVO.setWhareHouseDSDCD(CPSHelper.getTrimmedValue(String.valueOf(whareHouseDSDCD)));
		}
		if (6 == cellNumber) {
			long sellUnitQty = (long) cell.getNumericCellValue();
			batchVO.setSellUnitQty(CPSHelper.getTrimmedValue(String.valueOf(sellUnitQty)));
		}
		if (7 == cellNumber) {
			long unitUOMText = (long) cell.getNumericCellValue();
			batchVO.setUnitUOMText(CPSHelper.getTrimmedValue(String.valueOf(unitUOMText)));
		}
		if (8 == cellNumber) {
			long prodDesTag1Eng = (long) cell.getNumericCellValue();
			batchVO.setProdDesTag1Eng(CPSHelper.getTrimmedValue(String.valueOf(prodDesTag1Eng)));
		}
		if (9 == cellNumber) {
			long prodDesTag2Eng = (long) cell.getNumericCellValue();
			batchVO.setProdDesTag2Eng(CPSHelper.getTrimmedValue(String.valueOf(prodDesTag2Eng)));
		}
		if (10 == cellNumber) {
			long fcDpDeptNo = (long) cell.getNumericCellValue();
			batchVO.setFcDpDeptNo(CPSHelper.getTrimmedValue(String.valueOf(fcDpDeptNo)));
		}
		if (11 == cellNumber) {
			long fcDpSubDeptCD = (long) cell.getNumericCellValue();
			batchVO.setFcDpSubDeptCD(CPSHelper.getTrimmedValue(String.valueOf(fcDpSubDeptCD)));
		}
		if (12 == cellNumber) {
			long prodOmiComCD = (long) cell.getNumericCellValue();
			batchVO.setProdOmiComCD(CPSHelper.getTrimmedValue(String.valueOf(prodOmiComCD)));
		}
		if (13 == cellNumber) {
			long prodOmiSubComCD = (long) cell.getNumericCellValue();
			batchVO.setProdOmiSubComCD(CPSHelper.getTrimmedValue(String.valueOf(prodOmiSubComCD)));
		}
		if (14 == cellNumber) {
			long buyerCd = (long) cell.getNumericCellValue();
			batchVO.setBuyerCd(CPSHelper.getTrimmedValue(String.valueOf(buyerCd)));
		}
		if (15 == cellNumber) {
			long prodDeptNo = (long) cell.getNumericCellValue();

			batchVO.setProdDeptNo(CPSHelper.getTrimmedValue(String.valueOf(prodDeptNo)));
		}
		if (16 == cellNumber) {
			long prodItemCatCD = (long) cell.getNumericCellValue();

			batchVO.setProdItemCatCD(CPSHelper.getTrimmedValue(String.valueOf(prodItemCatCD)));
		}
		if (17 == cellNumber) {
			long vdStrPrcGrpCD = (long) cell.getNumericCellValue();

			batchVO.setVdStrPrcGrpCD(CPSHelper.getTrimmedValue(String.valueOf(vdStrPrcGrpCD)));
		}
		if (18 == cellNumber) {
			long storeNo = (long) cell.getNumericCellValue();

			batchVO.setStoreNo(CPSHelper.getTrimmedValue(String.valueOf(storeNo)));
		}
		if (19 == cellNumber) {
			float prodRetailHT = (float) cell.getNumericCellValue();

			batchVO.setProdRetailHT(CPSHelper.getTrimmedValue(String.valueOf(prodRetailHT)));
		}
		if (20 == cellNumber) {
			float prodRetailLN = (float) cell.getNumericCellValue();

			batchVO.setProdRetailLN(CPSHelper.getTrimmedValue(String.valueOf(prodRetailLN)));
		}
		if (21 == cellNumber) {
			float prodRetailWD = (float) cell.getNumericCellValue();

			batchVO.setProdRetailWD(CPSHelper.getTrimmedValue(String.valueOf(prodRetailWD)));
		}
		if (22 == cellNumber) {
			long vendorNo = (long) cell.getNumericCellValue();

			batchVO.setVendorNo(CPSHelper.getTrimmedValue(String.valueOf(vendorNo)));
		}
		if (23 == cellNumber) {
			long prodVendorCodeNo = (long) cell.getNumericCellValue();

			batchVO.setProdVendorCodeNo(CPSHelper.getTrimmedValue(String.valueOf(prodVendorCodeNo)));
		}
		if (24 == cellNumber) {
			long prodMastPKQty = (long) cell.getNumericCellValue();

			batchVO.setProdMastPKQty(CPSHelper.getTrimmedValue(String.valueOf(prodMastPKQty)));
		}
		if (25 == cellNumber) {
			float prodListCST = (float) cell.getNumericCellValue();

			batchVO.setProdListCST(CPSHelper.getTrimmedValue(String.valueOf(prodListCST)));
		}
		if (26 == cellNumber) {
			long prodCoreUX4Qty = (long) cell.getNumericCellValue();

			batchVO.setProdCoreUX4Qty(CPSHelper.getTrimmedValue(String.valueOf(prodCoreUX4Qty)));
		}
		if (27 == cellNumber) {
			float prodCoreUnitCST = (float) cell.getNumericCellValue();

			batchVO.setProdCoreUnitCST(CPSHelper.getTrimmedValue(String.valueOf(prodCoreUnitCST)));
		}
		if (28 == cellNumber) {
			long prodCoreChangeCD = (long) cell.getNumericCellValue();

			batchVO.setProdCoreChangeCD(CPSHelper.getTrimmedValue(String.valueOf(prodCoreChangeCD)));
		}
		if (29 == cellNumber) {
			long prodCoreLinkCD = (long) cell.getNumericCellValue();

			batchVO.setProdCoreLinkCD(CPSHelper.getTrimmedValue(String.valueOf(prodCoreLinkCD)));
		}
		if (30 == cellNumber) {
			long prodCoreMatrixSW = (long) cell.getNumericCellValue();

			batchVO.setProdCoreMatrixSW(CPSHelper.getTrimmedValue(String.valueOf(prodCoreMatrixSW)));
		}
		if (31 == cellNumber) {
			long prodCritItemCD = (long) cell.getNumericCellValue();

			batchVO.setProdCritItemCD(CPSHelper.getTrimmedValue(String.valueOf(prodCritItemCD)));
		}
		if (32 == cellNumber) {
			float prodCorePrepdPCT = (float) cell.getNumericCellValue();

			batchVO.setProdCorePrepdPCT(CPSHelper.getTrimmedValue(String.valueOf(prodCorePrepdPCT)));
		}
		if (33 == cellNumber) {
			long prodPrfxForQty = (long) cell.getNumericCellValue();

			batchVO.setProdPrfxForQty(CPSHelper.getTrimmedValue(String.valueOf(prodPrfxForQty)));
		}
		if (34 == cellNumber) {
			float prodPrfxPriceCST = (float) cell.getNumericCellValue();

			batchVO.setProdPrfxPriceCST(CPSHelper.getTrimmedValue(String.valueOf(prodPrfxPriceCST)));
		}
		if (35 == cellNumber) {
			long prodCoreTagCD = (long) cell.getNumericCellValue();

			batchVO.setProdCoreTagCD(CPSHelper.getTrimmedValue(String.valueOf(prodCoreTagCD)));
		}
		if (36 == cellNumber) {
			long prodTagSZCD = (long) cell.getNumericCellValue();

			batchVO.setProdTagSZCD(CPSHelper.getTrimmedValue(String.valueOf(prodTagSZCD)));
		}
		if (37 == cellNumber) {
			long prodNoTagQty = (long) cell.getNumericCellValue();

			batchVO.setProdNoTagQty(CPSHelper.getTrimmedValue(String.valueOf(prodNoTagQty)));
		}
		if (38 == cellNumber) {
			long prodCrgTaxQty = (long) cell.getNumericCellValue();

			batchVO.setProdCrgTaxQty(CPSHelper.getTrimmedValue(String.valueOf(prodCrgTaxQty)));
		}
		if (39 == cellNumber) {
			long prodFdStampCD = (long) cell.getNumericCellValue();

			batchVO.setProdFdStampCD(CPSHelper.getTrimmedValue(String.valueOf(prodFdStampCD)));
		}
		if (40 == cellNumber) {
			long prodFamOneCD = (long) cell.getNumericCellValue();

			batchVO.setProdFamOneCD(CPSHelper.getTrimmedValue(String.valueOf(prodFamOneCD)));
		}
		if (41 == cellNumber) {
			long prodFamTwoCD = (long) cell.getNumericCellValue();

			batchVO.setProdFamTwoCD(CPSHelper.getTrimmedValue(String.valueOf(prodFamTwoCD)));
		}
		if (42 == cellNumber) {
			long cstOwnID = (long) cell.getNumericCellValue();

			batchVO.setCstOwnID(CPSHelper.getTrimmedValue(String.valueOf(cstOwnID)));
		}
		if (43 == cellNumber) {
			long prodBrandID = (long) cell.getNumericCellValue();

			batchVO.setProdBrandID(CPSHelper.getTrimmedValue(String.valueOf(prodBrandID)));
		}
		if (44 == cellNumber) {
			long t2tID = (long) cell.getNumericCellValue();

			batchVO.setT2tID(CPSHelper.getTrimmedValue(String.valueOf(t2tID)));
		}
		if (45 == cellNumber) {
			long prodSubBrandID = (long) cell.getNumericCellValue();

			batchVO.setProdSubBrandID(CPSHelper.getTrimmedValue(String.valueOf(prodSubBrandID)));
		}
		if (46 == cellNumber) {
			long cntryOfOrginID = (long) cell.getNumericCellValue();

			batchVO.setCntryOfOrginID(CPSHelper.getTrimmedValue(String.valueOf(cntryOfOrginID)));
		}
		if (47 == cellNumber) {
			long comments = (long) cell.getNumericCellValue();

			batchVO.setComments(CPSHelper.getTrimmedValue(String.valueOf(comments)));
		}
		if (48 == cellNumber) {
			long packaging = (long) cell.getNumericCellValue();
			batchVO.setPackaging(CPSHelper.getTrimmedValue(String.valueOf(packaging)));
		}
	}
}
