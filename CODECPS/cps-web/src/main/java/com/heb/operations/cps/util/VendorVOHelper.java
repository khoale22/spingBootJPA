package com.heb.operations.cps.util;

import com.heb.operations.cps.vo.VendorVO;

public class VendorVOHelper {

	public static VendorVO copyVendorVOtoVendorVO(VendorVO vendorVO) {
		VendorVO newVendorVO = new VendorVO();

		newVendorVO.setVendorLocation(CPSHelper.getTrimmedValue(vendorVO
				.getVendorLocation()));
		newVendorVO.setVendorLocationTypeCode(CPSHelper
				.getTrimmedValue(vendorVO.getVendorLocationTypeCode()));
		newVendorVO.setOriginalLocationTypeCode(CPSHelper
				.getTrimmedValue(vendorVO.getOriginalLocationTypeCode()));
		newVendorVO.setVpc(CPSHelper.getTrimmedValue(vendorVO.getVpc()));
		newVendorVO.setListCost(CPSHelper.getTrimmedValue(vendorVO
				.getListCost()));
		newVendorVO.setListCostVendor(vendorVO.getListCost());
		newVendorVO.setUnitCost(CPSHelper.getTrimmedValue(vendorVO
				.getUnitCost()));
		newVendorVO
				.setImportd(CPSHelper.getTrimmedValue(vendorVO.getImportd()));
		newVendorVO.setCostOwner(CPSHelper.getTrimmedValue(vendorVO
				.getCostOwner()));
		newVendorVO.setCostLink(CPSHelper.getTrimmedValue(vendorVO
				.getCostLink()));
		newVendorVO.setCostLinkRadio(vendorVO.isCostLinkRadio());
		newVendorVO.setItemCodeRadio(vendorVO.isItemCodeRadio());				
		newVendorVO
				.setTop2Top(CPSHelper.getTrimmedValue(vendorVO.getTop2Top()));
		newVendorVO.setCountryOfOrigin(CPSHelper.getTrimmedValue(vendorVO
				.getCountryOfOrigin()));
		newVendorVO.setSeasonality(CPSHelper.getTrimmedValue(vendorVO
				.getSeasonality()));
		newVendorVO.setTop2TopVal(CPSHelper.getTrimmedValue(vendorVO
				.getTop2TopVal()));
		newVendorVO.setCountryOfOriginVal(CPSHelper.getTrimmedValue(vendorVO
				.getCountryOfOriginVal()));
		newVendorVO.setVendorLocationVal(CPSHelper.getTrimmedValue(vendorVO
				.getVendorLocationVal()));
		newVendorVO.setSeasonalityVal(CPSHelper.getTrimmedValue(vendorVO
				.getSeasonalityVal()));
		newVendorVO.setSeasonalityYr(CPSHelper.getTrimmedValue(vendorVO
				.getSeasonalityYr()));
		newVendorVO.setUniqueId(CPSHelper.getTrimmedValue(vendorVO
				.getUniqueId()));
		newVendorVO.setVendorTie(CPSHelper.getTrimmedValue(vendorVO
				.getVendorTie()));
		newVendorVO.setVendorTier(CPSHelper.getTrimmedValue(vendorVO
				.getVendorTier()));

		newVendorVO
				.setChannel(CPSHelper.getTrimmedValue(vendorVO.getChannel()));
		newVendorVO.setChannelVal(CPSHelper.getTrimmedValue(vendorVO
				.getChannelVal()));

		newVendorVO.setVendorLocTypeCode(CPSHelper.getTrimmedValue(vendorVO
				.getVendorLocTypeCode()));

		newVendorVO.setWorkRequest(vendorVO.getWorkRequest());
		
		return newVendorVO;
	}

	public static boolean entitySaved(VendorVO newVendorVO,
			VendorVO savedVendorVO) {

		// Properties of saved Vendor
		String savedVendorLocation = savedVendorVO.getVendorLocation();
		String savedVendorLocationTypeCode = savedVendorVO
				.getVendorLocationTypeCode();
		String savedOriginalLocationTypeCode = savedVendorVO
				.getOriginalLocationTypeCode();
		String savedVpc = savedVendorVO.getVpc();
		String savedListCost = savedVendorVO.getListCost();
		String savedUnitCost = savedVendorVO.getUnitCost();
		String savedImportd = savedVendorVO.getImportd();
		String savedCostOwner = savedVendorVO.getCostOwner();
		String savedCostlink = savedVendorVO.getCostLink();
		String savedTop2Top = savedVendorVO.getTop2Top();
		String savedCountryOfOrigin = savedVendorVO.getCountryOfOrigin();
		String savedSeasonality = savedVendorVO.getSeasonality();
		String savedTop2TopVal = savedVendorVO.getTop2TopVal();
		String savedCountryOfOriginVal = savedVendorVO.getCountryOfOriginVal();
		String savedVendorLocationVal = savedVendorVO.getVendorLocationVal();
		String savedSeasonalityVal = savedVendorVO.getSeasonalityVal();
		String savedSeasonalityYr = savedVendorVO.getSeasonalityYr();
		String savedUniqueId = savedVendorVO.getUniqueId();
		String savedVendorTie = savedVendorVO.getVendorTie();
		String savedVendorTier = savedVendorVO.getVendorTier();
		String savedChannel = savedVendorVO.getChannel();
		String savedChannelVal = savedVendorVO.getChannelVal();
		String savedVendorLocTypeCode = savedVendorVO.getVendorLocTypeCode();

		// Properties of new Vendor
		String newVendorLocation = newVendorVO.getVendorLocation();
		String newVendorLocationTypeCode = newVendorVO
				.getVendorLocationTypeCode();
		String newOriginalLocationTypeCode = newVendorVO
				.getOriginalLocationTypeCode();
		String newVpc = newVendorVO.getVpc();
		String newListCost = newVendorVO.getListCost();
		String newUnitCost = newVendorVO.getUnitCost();
		String newImportd = newVendorVO.getImportd();
		String newCostOwner = newVendorVO.getCostOwner();
		String newCostlink = newVendorVO.getCostLink();
		String newTop2Top = newVendorVO.getTop2Top();
		String newCountryOfOrigin = newVendorVO.getCountryOfOrigin();
		String newSeasonality = newVendorVO.getSeasonality();
		String newTop2TopVal = newVendorVO.getTop2TopVal();
		String newCountryOfOriginVal = newVendorVO.getCountryOfOriginVal();
		String newVendorLocationVal = newVendorVO.getVendorLocationVal();
		String newSeasonalityVal = newVendorVO.getSeasonalityVal();
		String newSeasonalityYr = newVendorVO.getSeasonalityYr();
		String newUniqueId = newVendorVO.getUniqueId();
		String newVendorTie = newVendorVO.getVendorTie();
		String newVendorTier = newVendorVO.getVendorTier();
		String newChannel = newVendorVO.getChannel();
		String newChannelVal = newVendorVO.getChannelVal();
		String newVendorLocTypeCode = newVendorVO.getVendorLocTypeCode();

		if (CPSHelper.checkEqualValue(savedVendorLocation, newVendorLocation)
				&& CPSHelper.checkEqualValue(savedVendorLocationTypeCode,
						newVendorLocationTypeCode)
				&& CPSHelper.checkEqualValue(savedOriginalLocationTypeCode,
						newOriginalLocationTypeCode)
				&& CPSHelper.checkEqualValue(savedVpc, newVpc)
				&& CPSHelper.checkEqualValue(savedListCost, newListCost)
				&& CPSHelper.checkEqualValue(savedUnitCost, newUnitCost)
				&& CPSHelper.checkEqualValue(savedImportd, newImportd)
				&& CPSHelper.checkEqualValue(savedCostOwner, newCostOwner)
				&& CPSHelper.checkEqualValue(savedCostlink, newCostlink)
				&& CPSHelper.checkEqualValue(savedTop2Top, newTop2Top)
				&& CPSHelper.checkEqualValue(savedCountryOfOrigin,
						newCountryOfOrigin)
				&& CPSHelper.checkEqualValue(savedSeasonality, newSeasonality)
				&& CPSHelper.checkEqualValue(savedTop2TopVal, newTop2TopVal)
				&& CPSHelper.checkEqualValue(savedCountryOfOriginVal,
						newCountryOfOriginVal)
				&& CPSHelper.checkEqualValue(savedVendorLocationVal,
						newVendorLocationVal)
				&& CPSHelper.checkEqualValue(savedSeasonalityVal,
						newSeasonalityVal)
				&& CPSHelper.checkEqualValue(savedSeasonalityYr,
						newSeasonalityYr)
				&& CPSHelper.checkEqualValue(savedUniqueId, newUniqueId)
				&& CPSHelper.checkEqualValue(savedVendorTie, newVendorTie)
				&& CPSHelper.checkEqualValue(savedVendorTier, newVendorTier)
				&& CPSHelper.checkEqualValue(savedChannel, newChannel)
				&& CPSHelper.checkEqualValue(savedChannelVal, newChannelVal)
				&& CPSHelper.checkEqualValue(savedVendorLocTypeCode,
						newVendorLocTypeCode)) {
			return false;
		} else {
			return true;
		}

	}
}
