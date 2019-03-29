package com.heb.operations.cps.util;

import com.heb.operations.cps.vo.CaseVO;
import com.heb.operations.cps.vo.UPCVO;

public class CaseVOHelper {

	public static CaseVO copyCaseVOtoCaseVO(CaseVO caseVO) {
		CaseVO newCaseVO = new CaseVO();
		newCaseVO.setCaseDescription(CPSHelper.getTrimmedValue(caseVO
				.getCaseDescription()));
		newCaseVO.setChannel(CPSHelper.getTrimmedValue(caseVO.getChannel()));
		newCaseVO.setChannelVal(CPSHelper.getTrimmedValue(caseVO
				.getChannelVal()));
		newCaseVO.setUnitFactor(CPSHelper.getTrimmedValue(caseVO
				.getUnitFactor()));
		newCaseVO.setCaseUPC(CPSHelper.getTrimmedValue(caseVO.getCaseUPC()));
		newCaseVO.setMaxShelfLifeDays(CPSHelper.getTrimmedValue(caseVO
				.getMaxShelfLifeDays()));
		newCaseVO.setInboundSpecificationDays(CPSHelper.getTrimmedValue(caseVO
				.getInboundSpecificationDays()));
		newCaseVO.setReactionDays(CPSHelper.getTrimmedValue(caseVO
				.getReactionDays()));
		newCaseVO.setGuaranteetoStoreDays(CPSHelper.getTrimmedValue(caseVO
				.getGuaranteetoStoreDays()));
		newCaseVO.setOneTouch(CPSHelper.getTrimmedValue(caseVO.getOneTouch()));
		newCaseVO.setMasterPack(CPSHelper.getTrimmedValue(caseVO
				.getMasterPack()));
		newCaseVO.setMasterLength(CPSHelper.getTrimmedValue(caseVO
				.getMasterLength()));
		newCaseVO.setMasterWidth(CPSHelper.getTrimmedValue(caseVO
				.getMasterWidth()));
		newCaseVO.setMasterHeight(CPSHelper.getTrimmedValue(caseVO
				.getMasterHeight()));
		newCaseVO.setMasterWeight(CPSHelper.getTrimmedValue(caseVO
				.getMasterWeight()));
		newCaseVO.setMasterCube(CPSHelper.getTrimmedValue(caseVO
				.getMasterCube()));
		newCaseVO.setShipPack(CPSHelper.getTrimmedValue(caseVO.getShipPack()));
		newCaseVO.setShipLength(CPSHelper.getTrimmedValue(caseVO
				.getShipLength()));
		newCaseVO
				.setShipWidth(CPSHelper.getTrimmedValue(caseVO.getShipWidth()));
		newCaseVO.setShipHeight(CPSHelper.getTrimmedValue(caseVO
				.getShipHeight()));
		newCaseVO.setShipWeight(CPSHelper.getTrimmedValue(caseVO
				.getShipWeight()));
		newCaseVO.setShipCube(CPSHelper.getTrimmedValue(caseVO.getShipCube()));
		newCaseVO.setCodeDate(caseVO.isCodeDate());
		newCaseVO.setCatchWeight(caseVO.isCatchWeight());
		newCaseVO.setVariableWeight(caseVO.isVariableWeight());
		
		newCaseVO.setMerchandizeType(CPSHelper.getTrimmedValue(caseVO
				.getMerchandizeType()));
		newCaseVO.setCommodityCode(CPSHelper.getTrimmedValue(caseVO
				.getCommodityCode()));
		newCaseVO.setSubCommodityCode(CPSHelper.getTrimmedValue(caseVO
				.getSubCommodityCode()));
		newCaseVO.setPssDept(CPSHelper.getTrimmedValue(caseVO.getPssDept()));
		newCaseVO
				.setClassCode(CPSHelper.getTrimmedValue(caseVO.getClassCode()));
		newCaseVO.setDeptId(CPSHelper.getTrimmedValue(caseVO.getDeptId()));
		newCaseVO
				.setSubDeptId(CPSHelper.getTrimmedValue(caseVO.getSubDeptId()));
		newCaseVO.setItemId(caseVO.getItemId());
		newCaseVO.setItemSizeTxt(CPSHelper.getTrimmedValue(caseVO.getItemSizeTxt()));
		newCaseVO.setItemSizeQty(CPSHelper.getTrimmedValue(caseVO.getItemSizeQty()));
		newCaseVO.setItemsSizeText(CPSHelper.getTrimmedValue(caseVO.getItemsSizeText()));
		newCaseVO.setItemCategory(CPSHelper.getTrimmedValue(caseVO.getItemCategory()));
		newCaseVO.setPurchaseStatus(CPSHelper.getTrimmedValue(caseVO.getPurchaseStatus()));
		newCaseVO.setMrt(CPSHelper.getTrimmedValue(caseVO.getMrt()));
		//DRU
		newCaseVO.setDsplyDryPalSw(caseVO.isDsplyDryPalSw());
		newCaseVO.setStdSubstLogicSw(caseVO.getStdSubstLogicSw());
		newCaseVO.setSrsAffTypCd(caseVO.getSrsAffTypCd());
		newCaseVO.setProdFcngNbr(caseVO.getProdFcngNbr());
		newCaseVO.setProdRowDeepNbr(caseVO.getProdRowDeepNbr());
		newCaseVO.setProdRowHiNbr(caseVO.getProdRowHiNbr());		
		// Fix DepositSw
		newCaseVO.setDepositSw(caseVO.getDepositSw());
		if(caseVO.isDsplyDryPalSw() && CPSHelper.isNotEmpty(caseVO.getSrsAffTypCd())){
			newCaseVO.setNbrOfOrintNbr(caseVO.getNbrOfOrintNbr());
		} else {
			newCaseVO.setNbrOfOrintNbr(null);
		}
		newCaseVO.setOrientations(caseVO.getOrientations());
		newCaseVO.setReadyUnits(caseVO.getReadyUnits());
		newCaseVO.setPsItemId(caseVO.getPsItemId());
		return newCaseVO;
	}

	public static boolean entitySaved(CaseVO newCaseVO, CaseVO savedCaseVO) {

		// Properties of saved Case
		String savedCaseDescription = CPSHelper.getTrimmedValue(savedCaseVO.getCaseDescription());
		String savedChannel = CPSHelper.getTrimmedValue(savedCaseVO.getChannel());
		String savedChannelVal = CPSHelper.getTrimmedValue(savedCaseVO.getChannelVal());
		String savedUnitFactor = CPSHelper.getTrimmedValue(savedCaseVO.getUnitFactor());
		String savedCaseUPC = CPSHelper.getTrimmedValue(savedCaseVO.getCaseUPC());
		String savedMaxShelfLifeDays = CPSHelper.getTrimmedValue(savedCaseVO.getMaxShelfLifeDays());
		String savedInboundSpecificationDays = CPSHelper.getTrimmedValue(savedCaseVO
				.getInboundSpecificationDays());
		String savedReactionDays = CPSHelper.getTrimmedValue(savedCaseVO.getReactionDays());
		String savedGuaranteetoStoreDays = CPSHelper.getTrimmedValue(savedCaseVO
				.getGuaranteetoStoreDays());
		String savedOneTouch = CPSHelper.getTrimmedValue(savedCaseVO.getOneTouch());
		String savedMasterPack = CPSHelper.getTrimmedValue(savedCaseVO.getMasterPack());
		String savedMasterLength = CPSHelper.getTrimmedValue(savedCaseVO.getMasterLength());
		String savedMasterWidth = CPSHelper.getTrimmedValue(savedCaseVO.getMasterWidth());
		String savedMasterHeight = CPSHelper.getTrimmedValue(savedCaseVO.getMasterHeight());
		String savedMasterWeight = CPSHelper.getTrimmedValue(savedCaseVO.getMasterWeight());
		String savedMasterCube = CPSHelper.getTrimmedValue(savedCaseVO.getMasterCube());
		String savedShipPack = CPSHelper.getTrimmedValue(savedCaseVO.getShipPack());
		String savedShipLength = CPSHelper.getTrimmedValue(savedCaseVO.getShipLength());
		String savedShipWidth = CPSHelper.getTrimmedValue(savedCaseVO.getShipWidth());
		String savedShipHeight = CPSHelper.getTrimmedValue(savedCaseVO.getShipHeight());
		String savedShipWeight = CPSHelper.getTrimmedValue(savedCaseVO.getShipWeight());
		String savedShipCube = CPSHelper.getTrimmedValue(savedCaseVO.getShipCube());
		boolean savedCodeDate = savedCaseVO.isCodeDate();
		boolean savedCatchWeight = savedCaseVO.isCatchWeight();
		boolean savedVariableWeight = savedCaseVO.isVariableWeight();
		String savedMerchandizeType = CPSHelper.getTrimmedValue(savedCaseVO.getMerchandizeType());
		String savedCommodityCode= CPSHelper.getTrimmedValue(savedCaseVO.getCommodityCode());
		String savedSubCommodityCode= CPSHelper.getTrimmedValue(savedCaseVO.getSubCommodityCode());
		String savedPssDept= CPSHelper.getTrimmedValue(savedCaseVO.getPssDept());
		String savedClassCode= CPSHelper.getTrimmedValue(savedCaseVO.getClassCode());
		String savedDeptId= CPSHelper.getTrimmedValue(savedCaseVO.getDeptId());
		String savedSubDeptId= CPSHelper.getTrimmedValue(savedCaseVO.getSubDeptId());
		String savedItemCategory= CPSHelper.getTrimmedValue(savedCaseVO.getItemCategory());
		// Fix DepositSw
		char savedDepositSw = savedCaseVO.getDepositSw();
		//DRU
		boolean  savedIsDsplyDryPalSw = savedCaseVO.isDsplyDryPalSw();
		String   savedSrsAffTypCd = savedCaseVO.getSrsAffTypCd();
		String  savedProdFcngNbr = savedCaseVO.getProdFcngNbr();
		String  savedProdRowDeepNbr = savedCaseVO.getProdRowDeepNbr();
		String  savedProdRowHiNbr = savedCaseVO.getProdRowHiNbr();
		String   savedNbrOfOrintNbr = savedCaseVO.getNbrOfOrintNbr();

		// Properties of new Case
		String newCaseDescription = CPSHelper.getTrimmedValue(newCaseVO.getCaseDescription());
		String newChannel = CPSHelper.getTrimmedValue(newCaseVO.getChannel());
		String newChannelVal = CPSHelper.getTrimmedValue(newCaseVO.getChannelVal());
		String newUnitFactor = CPSHelper.getTrimmedValue(newCaseVO.getUnitFactor());
		String newCaseUPC = CPSHelper.getTrimmedValue(newCaseVO.getCaseUPC());
		String newMaxShelfLifeDays = CPSHelper.getTrimmedValue(newCaseVO.getMaxShelfLifeDays());
		String newInboundSpecificationDays = CPSHelper.getTrimmedValue(newCaseVO
				.getInboundSpecificationDays());
		String newReactionDays = CPSHelper.getTrimmedValue(newCaseVO.getReactionDays());
		String newGuaranteetoStoreDays = CPSHelper.getTrimmedValue(newCaseVO.getGuaranteetoStoreDays());
		String newOneTouch = CPSHelper.getTrimmedValue(newCaseVO.getOneTouch());
		String newMasterPack = CPSHelper.getTrimmedValue(newCaseVO.getMasterPack());
		String newMasterLength = CPSHelper.getTrimmedValue(newCaseVO.getMasterLength());
		String newMasterWidth = CPSHelper.getTrimmedValue(newCaseVO.getMasterWidth());
		String newMasterHeight = CPSHelper.getTrimmedValue(newCaseVO.getMasterHeight());
		String newMasterWeight = CPSHelper.getTrimmedValue(newCaseVO.getMasterWeight());
		String newMasterCube = CPSHelper.getTrimmedValue(newCaseVO.getMasterCube());
		String newShipPack = CPSHelper.getTrimmedValue(newCaseVO.getShipPack());
		String newShipLength = CPSHelper.getTrimmedValue(newCaseVO.getShipLength());
		String newShipWidth = CPSHelper.getTrimmedValue(newCaseVO.getShipWidth());
		String newShipHeight = CPSHelper.getTrimmedValue(newCaseVO.getShipHeight());
		String newShipWeight = CPSHelper.getTrimmedValue(newCaseVO.getShipWeight());
		String newShipCube = CPSHelper.getTrimmedValue(newCaseVO.getShipCube());
		boolean newCodeDate = newCaseVO.isCodeDate();
		boolean newCatchWeight = newCaseVO.isCatchWeight();
		boolean newVariableWeight = newCaseVO.isVariableWeight();
		String newMerchandizeType = CPSHelper.getTrimmedValue(newCaseVO.getMerchandizeType());
		String newCommodityCode= CPSHelper.getTrimmedValue(newCaseVO.getCommodityCode());
		String newSubCommodityCode= CPSHelper.getTrimmedValue(newCaseVO.getSubCommodityCode());
		String newPssDept= CPSHelper.getTrimmedValue(newCaseVO.getPssDept());
		String newClassCode= CPSHelper.getTrimmedValue(newCaseVO.getClassCode());
		String newDeptId= CPSHelper.getTrimmedValue(newCaseVO.getDeptId());
		String newSubDeptId= CPSHelper.getTrimmedValue(newCaseVO.getSubDeptId());
		String newItemCategory= CPSHelper.getTrimmedValue(newCaseVO.getItemCategory());
		//DRU
		boolean  newIsDsplyDryPalSw = newCaseVO.isDsplyDryPalSw();
		String   newSrsAffTypCd = newCaseVO.getSrsAffTypCd();
		String  newProdFcngNbr = newCaseVO.getProdFcngNbr();
		String  newProdRowDeepNbr = newCaseVO.getProdRowDeepNbr();
		String  newProdRowHiNbr = newCaseVO.getProdRowHiNbr();
		String   newNbrOfOrintNbr = newCaseVO.getNbrOfOrintNbr();
		// Fix DepositSw
		char newDepositSw = newCaseVO.getDepositSw(); 
		if (CPSHelper.checkEqualValue(savedCaseDescription, newCaseDescription)
				&& CPSHelper.checkEqualValue(savedChannel, newChannel)
				&& CPSHelper.checkEqualValue(savedChannelVal, newChannelVal)
				&& CPSHelper.checkEqualValue(savedUnitFactor, newUnitFactor)
				&& CPSHelper.checkEqualValue(savedCaseUPC, newCaseUPC)
				&& CPSHelper.checkEqualValue(savedMaxShelfLifeDays,
						newMaxShelfLifeDays)
				&& CPSHelper.checkEqualValue(savedInboundSpecificationDays,
						newInboundSpecificationDays)
				&& CPSHelper
						.checkEqualValue(savedReactionDays, newReactionDays)
				&& CPSHelper.checkEqualValue(savedGuaranteetoStoreDays,
						newGuaranteetoStoreDays)
				&& CPSHelper.checkEqualValue(savedOneTouch, newOneTouch)
				&& CPSHelper.checkEqualValue(savedMasterPack, newMasterPack)
				&& CPSHelper
						.checkEqualValue(savedMasterLength, newMasterLength)
				&& CPSHelper.checkEqualValue(savedMasterWidth, newMasterWidth)
				&& CPSHelper
						.checkEqualValue(savedMasterHeight, newMasterHeight)
				&& CPSHelper
						.checkEqualValue(savedMasterWeight, newMasterWeight)
				&& CPSHelper.checkEqualValue(savedMasterCube, newMasterCube)
				&& CPSHelper.checkEqualValue(savedShipPack, newShipPack)
				&& CPSHelper.checkEqualValue(savedShipLength, newShipLength)
				&& CPSHelper.checkEqualValue(savedShipWidth, newShipWidth)
				&& CPSHelper.checkEqualValue(savedShipHeight, newShipHeight)
				&& CPSHelper.checkEqualValue(savedShipWeight, newShipWeight)
				&& CPSHelper.checkEqualValue(savedShipCube, newShipCube)
				&& CPSHelper.checkEqualValue(savedCodeDate, newCodeDate)
				&& CPSHelper.checkEqualValue(savedCatchWeight, newCatchWeight)
				&& CPSHelper.checkEqualValue(savedVariableWeight,
						newVariableWeight)
				&& CPSHelper.checkEqualValue(savedMerchandizeType, newMerchandizeType)
				&& CPSHelper.checkEqualValue(savedCommodityCode, newCommodityCode)
				&& CPSHelper.checkEqualValue(savedSubCommodityCode, newSubCommodityCode)
				&& CPSHelper.checkEqualValue(savedPssDept, newPssDept)
				&& CPSHelper.checkEqualValue(savedClassCode, newClassCode)
				&& CPSHelper.checkEqualValue(savedDeptId, newDeptId)
				&& CPSHelper.checkEqualValue(savedSubDeptId, newSubDeptId)
				&& CPSHelper.checkEqualValue(savedItemCategory, newItemCategory)
				&& CPSHelper.checkEqualValue(savedIsDsplyDryPalSw, newIsDsplyDryPalSw)
				&& CPSHelper.checkEqualValue(savedSrsAffTypCd, newSrsAffTypCd)
				&& CPSHelper.checkEqualValue(savedProdFcngNbr, newProdFcngNbr)
				&& CPSHelper.checkEqualValue(savedProdRowDeepNbr, newProdRowDeepNbr)
				&& CPSHelper.checkEqualValue(savedProdRowHiNbr, newProdRowHiNbr)
				&& CPSHelper.checkEqualValue(savedNbrOfOrintNbr, newNbrOfOrintNbr)
				// Fix DepositSw
				&& savedDepositSw == newDepositSw) {
			return false;
		} else {
			return true;
		}
	}
	public static boolean entityMRTCaseSaved(CaseVO newCaseVO, CaseVO savedCaseVO) {

		// Properties of new Case
		String newCaseDescription = CPSHelper.getTrimmedValue(newCaseVO.getCaseDescription());
		String newChannel = CPSHelper.getTrimmedValue(newCaseVO.getChannel());
		String newChannelVal = CPSHelper.getTrimmedValue(newCaseVO.getChannelVal());
		String newUnitFactor = CPSHelper.getTrimmedValue(newCaseVO.getUnitFactor());
		String newCaseUPC = CPSHelper.getTrimmedValue(newCaseVO.getCaseUPC());
		String newMaxShelfLifeDays = CPSHelper.getTrimmedValue(newCaseVO.getMaxShelfLifeDays());
		String newInboundSpecificationDays = CPSHelper.getTrimmedValue(newCaseVO
				.getInboundSpecificationDays());
		String newReactionDays = CPSHelper.getTrimmedValue(newCaseVO.getReactionDays());
		String newGuaranteetoStoreDays = CPSHelper.getTrimmedValue(newCaseVO.getGuaranteetoStoreDays());
		String newOneTouch = CPSHelper.getTrimmedValue(newCaseVO.getOneTouch());
		String newMasterPack = CPSHelper.getTrimmedValue(newCaseVO.getMasterPack());
		String newMasterLength = CPSHelper.getTrimmedValue(newCaseVO.getMasterLength());
		String newMasterWidth = CPSHelper.getTrimmedValue(newCaseVO.getMasterWidth());
		String newMasterHeight = CPSHelper.getTrimmedValue(newCaseVO.getMasterHeight());
		String newMasterWeight = CPSHelper.getTrimmedValue(newCaseVO.getMasterWeight());
		String newMasterCube = CPSHelper.getTrimmedValue(newCaseVO.getMasterCube());
		String newShipPack = CPSHelper.getTrimmedValue(newCaseVO.getShipPack());
		String newShipLength = CPSHelper.getTrimmedValue(newCaseVO.getShipLength());
		String newShipWidth = CPSHelper.getTrimmedValue(newCaseVO.getShipWidth());
		String newShipHeight = CPSHelper.getTrimmedValue(newCaseVO.getShipHeight());
		String newShipWeight = CPSHelper.getTrimmedValue(newCaseVO.getShipWeight());
		String newShipCube = CPSHelper.getTrimmedValue(newCaseVO.getShipCube());
		boolean newCodeDate = newCaseVO.isCodeDate();
		boolean newCatchWeight = newCaseVO.isCatchWeight();
		boolean newVariableWeight = newCaseVO.isVariableWeight();
		String newMerchandizeType = CPSHelper.getTrimmedValue(newCaseVO.getMerchandizeType());
		String newCommodityCode= CPSHelper.getTrimmedValue(newCaseVO.getCommodityCode());
		String newSubCommodityCode= CPSHelper.getTrimmedValue(newCaseVO.getSubCommodityCode());
		String newPssDept= CPSHelper.getTrimmedValue(newCaseVO.getPssDept());
		String newClassCode= CPSHelper.getTrimmedValue(newCaseVO.getClassCode());
		String newDeptId= CPSHelper.getTrimmedValue(newCaseVO.getDeptId());
		String newSubDeptId= CPSHelper.getTrimmedValue(newCaseVO.getSubDeptId());
		String newItemCategory= CPSHelper.getTrimmedValue(newCaseVO.getItemCategory());
		if (CPSHelper.isEmpty(newCaseDescription)
				&& CPSHelper.isEmpty(newChannel)
				&& CPSHelper.isEmpty(newChannelVal)
				&& CPSHelper.isEmpty(newUnitFactor)
				&& CPSHelper.isEmpty(newCaseUPC)
				&& CPSHelper.isEmpty(
						newMaxShelfLifeDays)
				&& CPSHelper.isEmpty(
						newInboundSpecificationDays)
				&& CPSHelper.isEmpty(newReactionDays)
				&& CPSHelper.isEmpty(
						newGuaranteetoStoreDays)
				&& CPSHelper.isEmpty(newOneTouch)
				&& CPSHelper.isEmpty(newMasterPack)
				&& CPSHelper.isEmpty(newMasterLength)
				&& CPSHelper.isEmpty(newMasterWidth)
				&& CPSHelper.isEmpty(newMasterHeight)
				&& CPSHelper.isEmpty(newMasterWeight)
				&& CPSHelper.isEmpty(newMasterCube)
				&& CPSHelper.isEmpty(newShipPack)
				&& CPSHelper.isEmpty(newShipLength)
				&& CPSHelper.isEmpty(newShipWidth)
				&& CPSHelper.isEmpty(newShipHeight)
				&& CPSHelper.isEmpty(newShipWeight)
				&& CPSHelper.isEmpty(newShipCube)
				&& CPSHelper.isEmpty(newCodeDate)
				&& CPSHelper.isEmpty(newCatchWeight)
				&& CPSHelper.isEmpty(
						newVariableWeight)
				&& CPSHelper.isEmpty(newMerchandizeType)
				&& CPSHelper.isEmpty(newCommodityCode)
				&& CPSHelper.isEmpty(newSubCommodityCode)
				&& CPSHelper.isEmpty(newPssDept)
				&& CPSHelper.isEmpty(newClassCode)
				&& CPSHelper.isEmpty(newDeptId)
				&& CPSHelper.isEmpty(newSubDeptId)
				&& CPSHelper.isEmpty(newItemCategory)) {
			return false;
		} else {
			return true;
		}
	}
	public static UPCVO copyUPCVOtoUPCVO(UPCVO upcVO){
		UPCVO newUpcVO = new UPCVO();		
		newUpcVO.setSampleProvdSw(upcVO.getSampleProvdSw());
		newUpcVO.setWorkRequest(upcVO.getWorkRequest());
		newUpcVO.setTestScanOverridenStatus(upcVO.getTestScanOverridenStatus());
		newUpcVO.setUniqueId(upcVO.getUniqueId());
		newUpcVO.setLength(upcVO.getLength());
		newUpcVO.setWidth(upcVO.getWidth());
		newUpcVO.setHeight(upcVO.getHeight());
		newUpcVO.setUpcType(upcVO.getUpcType());
		newUpcVO.setSelectedUpcType(upcVO.getSelectedUpcType());
		newUpcVO.setPsProdId(upcVO.getPsProdId());
		newUpcVO.setSelectedUnitUPC(upcVO.getSelectedUnitUPC());
		newUpcVO.setSelectedUnitSize(upcVO.getSelectedUnitSize());
		newUpcVO.setSelectedUnitOfMeasure(upcVO.getSelectedUnitOfMeasure());
		newUpcVO.setSelectedUPCLength(upcVO.getSelectedUPCLength());
		newUpcVO.setSelectedUPCWidth(upcVO.getSelectedUPCWidth());
		newUpcVO.setSelectedUPCHeight(upcVO.getSelectedUPCHeight());
		newUpcVO.setSelectedUPCSize(upcVO.getSelectedUPCSize());
		newUpcVO.setSelectedPluType(upcVO.getSelectedPluType());
		newUpcVO.setSelectedRange(upcVO.getSelectedRange());
		newUpcVO.setGeneratedPLU(upcVO.getGeneratedPLU());
		newUpcVO.setUnitUpc(upcVO.getUnitUpc());
		newUpcVO.setSize(upcVO.getSize());
		newUpcVO.setUnitSize(upcVO.getUnitSize());
		newUpcVO.setUnitMeasureDesc(upcVO.getUnitMeasureDesc());
		newUpcVO.setUnitMeasureCode(upcVO.getUnitMeasureCode());
		newUpcVO.setPluTypeList(upcVO.getPluTypeList());
		newUpcVO.setRangeList(upcVO.getRangeList());
		newUpcVO.setSelectedBonus(upcVO.isSelectedBonus());
		newUpcVO.setBonus(upcVO.isBonus());
		newUpcVO.setSelectedUnitOfMeasureDesc(upcVO.getSelectedUnitOfMeasureDesc());	
		newUpcVO.setSelectedUnitUPC1(upcVO.getSelectedUnitUPC1());
		newUpcVO.setUnitUpc10(upcVO.getUnitUpc10());
		newUpcVO.setMessage(upcVO.getMessage());
		newUpcVO.setSelectedUnitUPCNew(upcVO.getSelectedUnitUPCNew());
		newUpcVO.setSelectedBonusNew(upcVO.getSelectedBonusNew());
		newUpcVO.setSelectedUnitSizeNew(upcVO.getSelectedUnitSizeNew());
		newUpcVO.setSelectedUnitOfMeasureNew(upcVO.getSelectedUnitOfMeasureNew());
		newUpcVO.setSelectedUPCLengthNew(upcVO.getSelectedUPCLengthNew());
		newUpcVO.setSelectedUPCWidthNew(upcVO.getSelectedUPCWidthNew());
		newUpcVO.setSelectedUPCHeightNew(upcVO.getSelectedUPCHeightNew());
		newUpcVO.setSelectedUPCSizeNew(upcVO.getSelectedUPCSizeNew());
		newUpcVO.setUpcvoSaved(upcVO.isUpcvoSaved());
		newUpcVO.setPsScanCodeId(upcVO.getPsScanCodeId());		
		newUpcVO.setSeqNo(upcVO.getSeqNo());
		newUpcVO.setSelectedSubBrand(upcVO.getSelectedSubBrand());
		newUpcVO.setSelectedSubBrandNew(upcVO.getSelectedSubBrandNew());
		newUpcVO.setCheckDigit(upcVO.getCheckDigit());
		newUpcVO.setSubBrand(upcVO.getSubBrand());
		newUpcVO.setTestScanUPC(upcVO.getTestScanUPC());
		newUpcVO.setSubBrandDesc(upcVO.getSubBrandDesc());
		newUpcVO.setMaxAttributes(upcVO.getMaxAttributes());
		newUpcVO.setAssgndAttributes(upcVO.getAssgndAttributes());
		newUpcVO.setFieldName(upcVO.getFieldName());
		newUpcVO.setNewDataSw(upcVO.getNewDataSw());
		newUpcVO.setPreDigit(upcVO.getPreDigit());
		newUpcVO.setSelectedWic(upcVO.getSelectedWic());
		newUpcVO.setWic(upcVO.getWic());
		newUpcVO.setSelectedWicNew(upcVO.getSelectedWicNew());
		newUpcVO.setWicUPC(upcVO.isWicUPC());
		newUpcVO.setContainsScaleUPC(upcVO.getContainsScaleUPC());
		newUpcVO.setUomBeforeChange(upcVO.getUomBeforeChange());
		newUpcVO.setRowId(upcVO.getRowId());
		newUpcVO.setEditFlag(upcVO.isEditFlag());
		newUpcVO.setSelectedSubBrandName(upcVO.getSelectedSubBrandName());
		newUpcVO.setSelectedSubBrandNewName(upcVO.getSelectedSubBrandNewName());		
		return newUpcVO;
		
	}
}