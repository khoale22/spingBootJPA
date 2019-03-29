package com.heb.operations.cps.batchUpload;

import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.vo.BatchVO;

public class BatchHeaderValidation {
	private ExcelValidationBean excelValidationBean;
	/**
	 * To validate the Field heading is in correct format
	 * @param batchVO
	 * @return
	 */
	 public  ExcelValidationBean validateBatchHeader(BatchVO batchVO) {
		  ExcelValidationBean excelValidationBean = new ExcelValidationBean();
		  excelValidationBean .setExcelStatus(CPSConstants.VALID_HEADER);
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_UPC_NO.equalsIgnoreCase(batchVO.getUnitUPCCheckDigit().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_UPC_NO);
			  excelValidationBean.setFoundHeader(batchVO.getUnitUPCCheckDigit().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_ITEM_DES.equalsIgnoreCase(batchVO.getItemDescription().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_ITEM_DES);
			  excelValidationBean.setFoundHeader(batchVO.getItemDescription().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_ITM_SZ_QTY.equalsIgnoreCase(batchVO.getItemSizeQty().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_ITM_SZ_QTY);
			  excelValidationBean.setFoundHeader(batchVO.getItemSizeQty().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_RECIP_SW.equalsIgnoreCase(batchVO.getReceipSW().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_RECIP_SW);
			  excelValidationBean.setFoundHeader(batchVO.getReceipSW().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_UPC_TYP_CD.equalsIgnoreCase(batchVO.getUpcTypeCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_UPC_TYP_CD);
			  excelValidationBean.setFoundHeader(batchVO.getUpcTypeCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_WHSE_DSD_CD.equalsIgnoreCase(batchVO.getWhareHouseDSDCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_WHSE_DSD_CD);
			  excelValidationBean.setFoundHeader(batchVO.getWhareHouseDSDCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_SELL_UNIT_QTY.equalsIgnoreCase(batchVO.getSellUnitQty().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_SELL_UNIT_QTY);
			  excelValidationBean.setFoundHeader(batchVO.getSellUnitQty().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_UNIT_UOM_TXT.equalsIgnoreCase(batchVO.getUnitUOMText().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_UNIT_UOM_TXT);
			  excelValidationBean.setFoundHeader(batchVO.getUnitUOMText().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PROD_DES_TAG1_ENG.equalsIgnoreCase(batchVO.getProdDesTag1Eng().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PROD_DES_TAG1_ENG);
			  excelValidationBean.setFoundHeader(batchVO.getProdDesTag1Eng().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PROD_DES_TAG2_ENG.equalsIgnoreCase(batchVO.getProdDesTag2Eng().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PROD_DES_TAG2_ENG);
			  excelValidationBean.setFoundHeader(batchVO.getProdDesTag2Eng().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.FC_DP_DEPT_NO.equalsIgnoreCase(batchVO.getFcDpDeptNo().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.FC_DP_DEPT_NO);
			  excelValidationBean.setFoundHeader(batchVO.getFcDpDeptNo().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.FC_DP_SUB_DEPT_CD.equalsIgnoreCase(batchVO.getFcDpSubDeptCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.FC_DP_SUB_DEPT_CD);
			  excelValidationBean.setFoundHeader(batchVO.getFcDpSubDeptCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_OMI_COM_CD.equalsIgnoreCase(batchVO.getProdOmiComCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_OMI_COM_CD);
			  excelValidationBean.setFoundHeader(batchVO.getProdOmiComCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_OMI_SUB_COM_CD.equalsIgnoreCase(batchVO.getProdOmiSubComCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_OMI_SUB_COM_CD);
			  excelValidationBean.setFoundHeader(batchVO.getProdOmiSubComCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PC_OMI_BUYER_CD.equalsIgnoreCase(batchVO.getBuyerCd().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PC_OMI_BUYER_CD);
			  excelValidationBean.setFoundHeader(batchVO.getBuyerCd().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_PSS_DEPT_NO.equalsIgnoreCase(batchVO.getProdDeptNo().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_PSS_DEPT_NO);
			  excelValidationBean.setFoundHeader(batchVO.getProdDeptNo().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_ITM_CAT_CD.equalsIgnoreCase(batchVO.getProdItemCatCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_ITM_CAT_CD);
			  excelValidationBean.setFoundHeader(batchVO.getProdItemCatCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.VD_STR_PRC_GRP_CD.equalsIgnoreCase(batchVO.getVdStrPrcGrpCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.VD_STR_PRC_GRP_CD);
			  excelValidationBean.setFoundHeader(batchVO.getVdStrPrcGrpCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.FC_STORE_NO.equalsIgnoreCase(batchVO.getStoreNo().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.FC_STORE_NO);
			  excelValidationBean.setFoundHeader(batchVO.getStoreNo().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_RETL_HT.equalsIgnoreCase(batchVO.getProdRetailHT().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_RETL_HT);
			  excelValidationBean.setFoundHeader(batchVO.getProdRetailHT().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_RETL_LN.equalsIgnoreCase(batchVO.getProdRetailLN().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_RETL_LN);
			  excelValidationBean.setFoundHeader(batchVO.getProdRetailLN().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_RETL_WD.equalsIgnoreCase(batchVO.getProdRetailWD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_RETL_WD);
			  excelValidationBean.setFoundHeader(batchVO.getProdRetailWD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.VD_VEND_NO.equalsIgnoreCase(batchVO.getVendorNo().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.VD_VEND_NO);
			  excelValidationBean.setFoundHeader(batchVO.getVendorNo().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_VEND_PROD_CD_NO.equalsIgnoreCase(batchVO.getProdVendorCodeNo().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_VEND_PROD_CD_NO);
			  excelValidationBean.setFoundHeader(batchVO.getProdVendorCodeNo().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_MAST_PK_QTY.equalsIgnoreCase(batchVO.getProdMastPKQty().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_MAST_PK_QTY);
			  excelValidationBean.setFoundHeader(batchVO.getProdMastPKQty().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_LIST_CST.equalsIgnoreCase(batchVO.getProdListCST().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_LIST_CST);
			  excelValidationBean.setFoundHeader(batchVO.getProdListCST().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_CORE_UX4_QTY.equalsIgnoreCase(batchVO.getProdCoreUX4Qty().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_CORE_UX4_QTY);
			  excelValidationBean.setFoundHeader(batchVO.getProdCoreUX4Qty().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_CORE_UNIT_CST.equalsIgnoreCase(batchVO.getProdCoreUnitCST().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_CORE_UNIT_CST);
			  excelValidationBean.setFoundHeader(batchVO.getProdCoreUnitCST().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_CORE_CHG_CD.equalsIgnoreCase(batchVO.getProdCoreChangeCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_CORE_CHG_CD);
			  excelValidationBean.setFoundHeader(batchVO.getProdCoreChangeCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_CORE_LINK_CD.equalsIgnoreCase(batchVO.getProdCoreLinkCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_CORE_LINK_CD);
			  excelValidationBean.setFoundHeader(batchVO.getProdCoreLinkCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_CORE_MATRX_SW.equalsIgnoreCase(batchVO.getProdCoreMatrixSW().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_CORE_MATRX_SW);
			  excelValidationBean.setFoundHeader(batchVO.getProdCoreMatrixSW().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_CRIT_ITEM_CD.equalsIgnoreCase(batchVO.getProdCritItemCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_CRIT_ITEM_CD);
			  excelValidationBean.setFoundHeader(batchVO.getProdCritItemCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_CORE_PREPD_PCT.equalsIgnoreCase(batchVO.getProdCorePrepdPCT().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_CORE_PREPD_PCT);
			  excelValidationBean.setFoundHeader(batchVO.getProdCorePrepdPCT().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_PRFX_XFOR_QTY.equalsIgnoreCase(batchVO.getProdPrfxForQty().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_PRFX_XFOR_QTY);
			  excelValidationBean.setFoundHeader(batchVO.getProdPrfxForQty().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_PRFX_PRICE_CST.equalsIgnoreCase(batchVO.getProdPrfxPriceCST().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_PRFX_PRICE_CST);
			  excelValidationBean.setFoundHeader(batchVO.getProdPrfxPriceCST().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_CORE_TAG_CD.equalsIgnoreCase(batchVO.getProdCoreTagCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_CORE_TAG_CD);
			  excelValidationBean.setFoundHeader(batchVO.getProdCoreTagCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_TAG_SZ_CD.equalsIgnoreCase(batchVO.getProdTagSZCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_TAG_SZ_CD);
			  excelValidationBean.setFoundHeader(batchVO.getProdTagSZCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_NO_TAG_QTY.equalsIgnoreCase(batchVO.getProdNoTagQty().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_NO_TAG_QTY);
			  excelValidationBean.setFoundHeader(batchVO.getProdNoTagQty().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_CRG_TAX_CD.equalsIgnoreCase(batchVO.getProdCrgTaxQty().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_CRG_TAX_CD);
			  excelValidationBean.setFoundHeader(batchVO.getProdCrgTaxQty().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_FD_STAMP_CD.equalsIgnoreCase(batchVO.getProdFdStampCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_FD_STAMP_CD);
			  excelValidationBean.setFoundHeader(batchVO.getProdFdStampCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_FAM_ONE_CD.equalsIgnoreCase(batchVO.getProdFamOneCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_FAM_ONE_CD);
			  excelValidationBean.setFoundHeader(batchVO.getProdFamOneCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PD_FAM_TWO_CD.equalsIgnoreCase(batchVO.getProdFamTwoCD().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PD_FAM_TWO_CD);
			  excelValidationBean.setFoundHeader(batchVO.getProdFamTwoCD().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.CST_OWN_ID.equalsIgnoreCase(batchVO.getCstOwnID().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.CST_OWN_ID);
			  excelValidationBean.setFoundHeader(batchVO.getCstOwnID().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PROD_BRND_ID.equalsIgnoreCase(batchVO.getProdBrandID().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PROD_BRND_ID);
			  excelValidationBean.setFoundHeader(batchVO.getProdBrandID().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.T2T_ID.equalsIgnoreCase(batchVO.getT2tID().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.T2T_ID);
			  excelValidationBean.setFoundHeader(batchVO.getT2tID().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PROD_SUB_BRND_ID.equalsIgnoreCase(batchVO.getProdSubBrandID().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PROD_SUB_BRND_ID);
			  excelValidationBean.setFoundHeader(batchVO.getProdSubBrandID().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.CNTRY_OF_ORIG_ID.equalsIgnoreCase(batchVO.getCntryOfOrginID().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.CNTRY_OF_ORIG_ID);
			  excelValidationBean.setFoundHeader(batchVO.getCntryOfOrginID().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.COMMENTS.equalsIgnoreCase(batchVO.getComments().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.COMMENTS);
			  excelValidationBean.setFoundHeader(batchVO.getComments().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  if ((CPSConstants.VALID_HEADER
					.equalsIgnoreCase(excelValidationBean.getExcelStatus()))
					&& !(CPSConstants.PACKAGING.equalsIgnoreCase(batchVO.getPackaging().trim()))){
			  excelValidationBean.setExpectedHeader(CPSConstants.PACKAGING);
			  excelValidationBean.setFoundHeader(batchVO.getPackaging().trim());
			  excelValidationBean.setExcelStatus(CPSConstants.INVALID_HEADER);
			  
		  }
		  return excelValidationBean;
		}

	public ExcelValidationBean getExcelValidationBean() {
		return excelValidationBean;
	}

	public void setExcelValidationBean(ExcelValidationBean excelValidationBean) {
		this.excelValidationBean = excelValidationBean;
	}

}
