package com.heb.operations.cps.dwr.service.spring;

import com.heb.jaf.security.UserInfo;
import com.heb.operations.business.framework.exeption.CPSBusinessException;
import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.exeption.CPSMessage;
import com.heb.operations.business.framework.vo.CommoditySubCommVO;
import com.heb.operations.cps.model.ManageEDICandidate;
import com.heb.operations.cps.util.BusinessConstants;
import com.heb.operations.cps.util.CPSConstant;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.util.CommonBridge;
import com.heb.operations.cps.vo.*;
import com.heb.operations.ui.framework.dwr.custom.SpringFormCorrelatedService;
import org.apache.log4j.Logger;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@SpringFormCorrelatedService(formName = ManageEDICandidate.FORM_NAME)
public class ManageCandidateEDIDWR extends ProductClassificationDWR {
	private static final Logger LOG = Logger.getLogger(ManageCandidateEDIDWR.class);

	@Override
	protected ManageEDICandidate getForm() {
		return (ManageEDICandidate) getForm(ManageEDICandidate.FORM_NAME);
	}

	public boolean clearSearchResults() {
		if (!CPSHelper.isEmpty(getForm().getEdiSearchResultVOLst())) {
			getForm().getEdiSearchResultVOLst().clear();
			getForm().setHaveResults(false);
		}
		if (!CPSHelper.isEmpty(getForm().getEdiSearchResultVOLstTemp())) {
			getForm().getEdiSearchResultVOLstTemp().clear();
		}
		return true;
	}

	public boolean modifySearch() {
		if (!CPSHelper.isEmpty(getForm().getEdiSearchResultVOLst())) {
			getForm().getEdiSearchResultVOLst().clear();
			getForm().setHaveResults(false);
		}
		if (!CPSHelper.isEmpty(getForm().getEdiSearchResultVOLstTemp())) {
			getForm().getEdiSearchResultVOLstTemp().clear();
		}
		return true;
	}

	public String getActualAndMultipleRetail(String retailLink) {
		String result = CPSConstant.STRING_EMPTY;
		String retailLinkInput = retailLink;
		StringBuffer checkMessage = new StringBuffer();
		checkMessage.append(EMPTY_STRING);
		try {
			String retailLinkUPC = null;
			int itemId = 0;
			if (retailLink.length() == 13) {
				retailLinkUPC = retailLinkInput;
			} else if (retailLinkInput.length() == 7) {
				itemId = Integer.parseInt(retailLinkInput);
			}
			RetailLinkVO retailLinkVO = CommonBridge.getAddNewCandidateServiceInstance().getRetailLinkVO(retailLinkUPC, itemId);

			if (CPSHelper.isNotEmpty(retailLinkVO)) {
				result = retailLinkVO.getUnitRetail();
				result = result + "_" + retailLinkVO.getUnitRetailFor();
				result = result + "_" + retailLinkVO.getUnitUpc();
			} else {
				result = CPSConstant.STRING_EMPTY;
			}
		} catch (CPSBusinessException ex) {
			LOG.error(ex.getMessage(), ex);
			List<CPSMessage> list = ex.getMessages();
			for (CPSMessage message : list) {
				checkMessage.append(message.getMessage());
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return result;

	}

	public String getAuthorizationFromVendorSelected(String idResult) {
		StringBuffer strData = new StringBuffer();
		strData.append("[");

		if (idResult != null) {
			String[] arrResult = idResult.trim().split("-");
			if (arrResult.length > 0) {
				VendorVO vendorVO = new VendorVO();
				vendorVO.setVendorLocNumber(Integer.parseInt(arrResult[1]));
				vendorVO.setChannel(arrResult[2]);
				// if channel is Both
				if (vendorVO.getChannel().isEmpty() || ("null").equals(vendorVO.getChannel())) {
					if (arrResult[1].trim().length() >= 6)
						vendorVO.setChannel("V");
					else
						vendorVO.setChannel("D");
				}

				AuthorizationAndDistributionDetailVO authorAndDistriDetailVO;

				ManageEDICandidate fmEDI = getForm();
				// if search with action is active product
				if (fmEDI.getCandidateEDISearchCriteria().getActionId().equals(BusinessConstants.SEARCH_ACTION_ACTIVEPRODUCTS_ID)) {
					vendorVO.setItemId(new BigDecimal(arrResult[0]));
					authorAndDistriDetailVO = CommonBridge.getCommonServiceInstance().getWarehouseStoreFromVendorWithActiveProduct(vendorVO);
				} else {
					vendorVO.setPsItemId(Integer.parseInt(arrResult[0]));
					authorAndDistriDetailVO = CommonBridge.getCommonServiceInstance().getWarehouseStoreFromVendor(vendorVO);
				}

				if (!authorAndDistriDetailVO.getDsdLst().isEmpty()) {
					for (int i = 0; i < authorAndDistriDetailVO.getDsdLst().size(); i++) {
						DSDDetailVO dsdDetailVO = authorAndDistriDetailVO.getDsdLst().get(i);

						if (i == 0)
							strData.append("{costGroup:\"" + dsdDetailVO.getCostGroup());
						else
							strData.append("\n,{costGroup:\"" + dsdDetailVO.getCostGroup());

						strData.append("\",store:\"" + dsdDetailVO.getStore());
						strData.append("\",storeName:\"" + CPSHelper.convertCharToHTMLForJSON(dsdDetailVO.getStoreName()));
						strData.append("\",authorized:\"" + dsdDetailVO.getAuthorized() + "\"}");
					}
				} else if (!authorAndDistriDetailVO.getWhsLst().isEmpty()) {
					for (int i = 0; i < authorAndDistriDetailVO.getWhsLst().size(); i++) {
						WHSDetailVO whsDetailVO = authorAndDistriDetailVO.getWhsLst().get(i);

						if (i == 0)
							strData.append("{bicep:\"" + whsDetailVO.getBicep());
						else
							strData.append("\n,{bicep:\"" + whsDetailVO.getBicep());

						strData.append("\",warehouse:\"" + whsDetailVO.getWareHouse());
						strData.append("\",warehouseName:\"" + CPSHelper.convertCharToHTMLForJSON(whsDetailVO.getWareHouseName()));
						strData.append("\",authorized:\"" + whsDetailVO.getAuthorized() + "\"}");
					}
				}

			}
		}
		strData.append("]");
		return strData.toString();
	}

	public String updateDataForOtherAttributeTab(String[] arrId, String[] arrInboundSpecDays, String[] arrReactionDays, String[] arrGuaranteeToStoreDays, String[] arrSeasonalityYear,
			String[] arrSeasonality, String currentPage) {

		int result = -1;

		try {
			ManageEDICandidate fmEDI = getForm();
			List<EDISearchResultVO> listEDISearchResultVO = new ArrayList<EDISearchResultVO>();
			for (int i = 0; i < arrId.length; i++) {
				String[] arrValues = arrId[i].split("-");

				EDISearchResultVO ediSearchResultVO = new EDISearchResultVO();
				ediSearchResultVO.setPsWorkId(Integer.parseInt(arrValues[0].trim()));
				ediSearchResultVO.setPsItemId(arrValues[1]);
				ediSearchResultVO.setPsVendno(arrValues[2]);
				ediSearchResultVO.setChannel(arrValues[3]);

				// if channel is Both
				if (ediSearchResultVO.getChannel().isEmpty() || ("null").equals(ediSearchResultVO.getChannel())) {
					if (ediSearchResultVO.getPsVendno().trim().length() >= 6)
						ediSearchResultVO.setChannel("V");
					else
						ediSearchResultVO.setChannel("D");
				}

				OtherAttributeDetailVO otherAttributeDetailVO = new OtherAttributeDetailVO();

				boolean isVendor = fmEDI.getIsVendor();

				if (!(CPSConstant.STRING_EMPTY).equals(arrInboundSpecDays[i].trim()))
					otherAttributeDetailVO.setInboundSpecDays(arrInboundSpecDays[i]);
				if (!(CPSConstant.STRING_EMPTY).equals(arrReactionDays[i].trim()) && !isVendor)
					otherAttributeDetailVO.setReactionDays(arrReactionDays[i]);
				if (!(CPSConstant.STRING_EMPTY).equals(arrGuaranteeToStoreDays[i].trim()) && !isVendor)
					otherAttributeDetailVO.setGuaranteeToStoreDays(arrGuaranteeToStoreDays[i]);
				if (!(CPSConstant.STRING_EMPTY).equals(arrSeasonalityYear[i].trim()))
					otherAttributeDetailVO.setSeasonalityYear(arrSeasonalityYear[i]);
				if (!(CPSConstant.STRING_EMPTY).equals(arrSeasonality[i].trim()))
					otherAttributeDetailVO.setSeasonality(arrSeasonality[i]);

				ediSearchResultVO.setOtherAttributeDetailVO(otherAttributeDetailVO);

				listEDISearchResultVO.add(ediSearchResultVO);
			}

			if (!listEDISearchResultVO.isEmpty()) {
				fmEDI.setListItemToUpdate(listEDISearchResultVO);
				result = 1;
			}

			// set current page is selected on grid
			fmEDI.setCurrentPage(Integer.parseInt(currentPage));
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}

		return String.valueOf(result);
	}

	public boolean updateFormForSave(SaveEDISellingObj saveEDISellingObj, String currentPage) {
		boolean isHaveChange = false;
		try {
			List<SellingUPCSaveVO> sellingUPCSaveVOLst = saveEDISellingObj.convertToSellingUPCSaveVO();
			ManageEDICandidate fmEDI = getForm();
			List<EDISearchResultVO> ediSearchResultVOLst = fmEDI.getEdiSearchResultVOLst();
			for (SellingUPCSaveVO sellingUPCSaveVO : sellingUPCSaveVOLst) {
				String psWkId = sellingUPCSaveVO.getPsWorkId();
				String psProId = sellingUPCSaveVO.getPsProdId();
				String subComCode = sellingUPCSaveVO.getSubComCode();
				String psTaxWkId = sellingUPCSaveVO.getPsTaxWorkId();
				String psTaxProId = sellingUPCSaveVO.getPsTaxProdId();
				String taxCatCode = sellingUPCSaveVO.getTaxCatCode();
				for (EDISearchResultVO searchResultVO : ediSearchResultVOLst) {
					if (psWkId != null && searchResultVO.getPsWorkId().toString().trim().equals(psWkId) && searchResultVO.getPsProdId().toString().trim().equals(psProId) && !("0").equals(subComCode)) {
						searchResultVO.getSellingUPCDetailVO().setSubComCode(sellingUPCSaveVO.getSubComCode());
						searchResultVO.getSellingUPCDetailVO().setTobeSave(true);
						isHaveChange = true;
					}
					// BINHHT-add
					if (psTaxWkId != null && searchResultVO.getPsWorkId().toString().trim().equals(psTaxWkId) && searchResultVO.getPsProdId().toString().trim().equals(psTaxProId)
							&& !("0").equals(taxCatCode)) {
						searchResultVO.getSellingUPCDetailVO().setTaxCategoryCode(sellingUPCSaveVO.getTaxCatCode());
						searchResultVO.getSellingUPCDetailVO().setTobeSave(true);
						isHaveChange = true;
					}
				}
			}
			fmEDI.setEdiSearchResultVOLst(ediSearchResultVOLst);
			// set current page is selected on grid
			fmEDI.setCurrentPage(Integer.parseInt(currentPage));
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}

		return isHaveChange;
	}

	public String updateDataForCostAndRetailTab(String[] arrIdResult, String[] arrActualRetail, String[] arrActualMultipleRetail, String[] arrRetailLink, String[] arrPennyProfit, String[] arrMargin,
			String[] arrListCost, String[] arrUnitCost, String currentPage) {
		List<EDISearchResultVO> listEDISearchResultVO = new ArrayList<EDISearchResultVO>();
		int result = -1;
		try {
			for (int i = 0; i < arrIdResult.length; i++) {

				if (arrIdResult[i] != null) {
					String idResult = arrIdResult[i].split("-")[0];
					String workID = arrIdResult[i].split("-")[4];
					EDISearchResultVO ediSearchResultVO = new EDISearchResultVO();
					ediSearchResultVO.setPsProdId(Integer.parseInt(idResult));
					ediSearchResultVO.setPsWorkId(Integer.valueOf(workID));
					CostAndRetailDetailVO costAndRetailVO = new CostAndRetailDetailVO();
					if (CPSHelper.isNotEmpty(arrActualRetail[i]) && !(CPSConstant.STRING_EMPTY).equals(arrActualRetail[i])) {
						costAndRetailVO.setActualRetail(arrActualRetail[i]);
					} else {
						costAndRetailVO.setActualRetail(CPSConstant.STRING_EMPTY);
						costAndRetailVO.setPennyProfit(CPSConstant.STRING_EMPTY);
						costAndRetailVO.setPercentageMargin(CPSConstant.STRING_EMPTY);
					}
					if (CPSHelper.isNotEmpty(arrActualMultipleRetail[i]) && !(CPSConstant.STRING_EMPTY).equals(arrActualMultipleRetail[i])) {
						costAndRetailVO.setActualMultipleRetail(arrActualMultipleRetail[i]);
					} else {
						costAndRetailVO.setActualMultipleRetail(CPSConstant.STRING_EMPTY);
						costAndRetailVO.setPennyProfit(CPSConstant.STRING_EMPTY);
						costAndRetailVO.setPercentageMargin(CPSConstant.STRING_EMPTY);
					}
					if (CPSHelper.isNotEmpty(arrRetailLink[i]) && !(CPSConstant.STRING_EMPTY).equals(arrRetailLink[i])) {
						costAndRetailVO.setRetailLink(arrRetailLink[i]);
					} else {
						costAndRetailVO.setRetailLink(CPSConstant.STRING_EMPTY);
						if ((CPSConstant.STRING_EMPTY).equals(arrRetailLink[i])
								&& ((CPSConstant.STRING_EMPTY).equals(arrActualMultipleRetail[i]) || (CPSConstant.STRING_EMPTY).equals(arrActualRetail[i]))) {
							costAndRetailVO.setPennyProfit(CPSConstant.STRING_EMPTY);
							costAndRetailVO.setPercentageMargin(CPSConstant.STRING_EMPTY);
						}
					}
					if (CPSHelper.isNotEmpty(arrPennyProfit[i]) && !(CPSConstant.STRING_EMPTY).equals(arrPennyProfit[i])) {
						costAndRetailVO.setPennyProfit(arrPennyProfit[i]);
					} else {
						costAndRetailVO.setPennyProfit(CPSConstant.STRING_EMPTY);
					}
					if (CPSHelper.isNotEmpty(arrMargin[i]) && !(CPSConstant.STRING_EMPTY).equals(arrMargin[i])) {
						costAndRetailVO.setPercentageMargin(arrMargin[i]);
					} else {
						costAndRetailVO.setPennyProfit(CPSConstant.STRING_EMPTY);
					}
					if (CPSHelper.isNotEmpty(arrListCost[i]) && !(CPSConstant.STRING_EMPTY).equals(arrListCost[i])) {
						costAndRetailVO.setListCost(arrListCost[i]);
					} else {
						costAndRetailVO.setListCost(CPSConstant.STRING_EMPTY);
					}
					if (CPSHelper.isNotEmpty(arrUnitCost[i]) && !(CPSConstant.STRING_EMPTY).equals(arrUnitCost[i])) {
						costAndRetailVO.setUnitCost(arrUnitCost[i]);
					} else {
						costAndRetailVO.setUnitCost(CPSConstant.STRING_EMPTY);
					}

					ediSearchResultVO.setCostAndRetailDetailVO(costAndRetailVO);
					listEDISearchResultVO.add(ediSearchResultVO);
				}

			}

			ManageEDICandidate fmEDI = getForm();
			if (!listEDISearchResultVO.isEmpty()) {
				fmEDI.setListItemToUpdate(listEDISearchResultVO);
				result = 1;
			}

			// set current page is selected on grid
			fmEDI.setCurrentPage(Integer.parseInt(currentPage));

		} catch (Exception ex) {
			LOG.error("ERROR Run DWR for updateDataForCostAndRetailTab: " + ex.getMessage(), ex);
		}

		return String.valueOf(result);
	}

	public String approveDSDDiscontinue(String[] arrPsWorkId, String[] arrId, String[] arrDiscontinueDate, String currentPage) {
		List<EDISearchResultVO> listEDISearchResultVO = new ArrayList<EDISearchResultVO>();
		int result = -1;
		Map<String, String> allStatus = null;
		try {
			allStatus = CommonBridge.getCommonServiceInstance().getCandidateStatus();

			for (int i = 0; i < arrPsWorkId.length; i++) {
				if (arrPsWorkId[i] != null) {
					EDISearchResultVO ediSearchResultVO = new EDISearchResultVO();
					ediSearchResultVO.setPsWorkId(Integer.parseInt(arrPsWorkId[i]));
					ediSearchResultVO.setStatus("111");
					if (allStatus != null && !allStatus.isEmpty()) {
						ediSearchResultVO.setStatusValue(allStatus.get(ediSearchResultVO.getStatus()));
					}
					ediSearchResultVO.setPsItemId(arrId[i]);
					ediSearchResultVO.setDiscontinueDate(arrDiscontinueDate[i]);
					listEDISearchResultVO.add(ediSearchResultVO);
				}
			}
			String userRole = getUserRole();
			ManageEDICandidate fmEDI = getForm();
			if (!listEDISearchResultVO.isEmpty()) {
				fmEDI.setListItemToUpdate(listEDISearchResultVO);
				fmEDI.setUserRole(userRole);
				result = 1;
			}

			fmEDI.setCurrentPage(Integer.parseInt(currentPage));
		} catch (Exception ex) {
			LOG.error(ex.getMessage(), ex);
		}
		return String.valueOf(result);
	}

	/*
	 * @author tuanle
	 * 
	 * @Description updateDataForDescriptionAndSizeTab
	 * 
	 * @Param
	 * 
	 * @return String StringBuffer strData
	 */

	public String updateDataForDescriptionAndSizeTab(String[] arrIdResult, String[] arrDescription, String[] arrCfd1, String[] arrCfd2, String[] arrSizeText, String currentPage) {
		int result = -1;

		try {
			List<EDISearchResultVO> listEDISearchResultVO = new ArrayList<EDISearchResultVO>();
			for (int i = 0; i < arrIdResult.length; i++) {
				String[] arrValues = arrIdResult[i].split("-");

				EDISearchResultVO ediSearchResultVO = new EDISearchResultVO();
				ediSearchResultVO.setPsWorkId(Integer.parseInt(arrValues[0]));
				ediSearchResultVO.setPsItemId(arrValues[1]);
				ediSearchResultVO.setPsVendno(arrValues[2]);
				ediSearchResultVO.setChannel(arrValues[3]);
				ediSearchResultVO.setPsProdId(Integer.parseInt(arrValues[4]));
				ediSearchResultVO.setScnCdSeqNbr(Integer.parseInt(arrValues[5]));
				DescriptionAndSizeDetailVO descriptionAndSizeDetailVO = new DescriptionAndSizeDetailVO();

				if (!(CPSConstant.STRING_EMPTY).equals(arrDescription[i].trim()))
					descriptionAndSizeDetailVO.setDescription(CPSHelper.convertHTMLToChars(arrDescription[i]));
				if (!(CPSConstant.STRING_EMPTY).equals(arrCfd1[i].trim()))
					descriptionAndSizeDetailVO.setCfd1(CPSHelper.convertHTMLToChars(arrCfd1[i]));
				if (!(CPSConstant.STRING_EMPTY).equals(arrCfd2[i].trim()))
					descriptionAndSizeDetailVO.setCfd2(CPSHelper.convertHTMLToChars(arrCfd2[i]));
				if (!(CPSConstant.STRING_EMPTY).equals(arrSizeText[i].trim()))
					descriptionAndSizeDetailVO.setSizeText(arrSizeText[i]);

				ediSearchResultVO.setDescriptionAndSizeDetailVO(descriptionAndSizeDetailVO);

				listEDISearchResultVO.add(ediSearchResultVO);
			}

			ManageEDICandidate fmEDI = getForm();
			if (!listEDISearchResultVO.isEmpty()) {
				fmEDI.setListItemToUpdate(listEDISearchResultVO);
				result = 1;
			}

			// set current page is selected on grid
			fmEDI.setCurrentPage(Integer.parseInt(currentPage));
		} catch (Exception e) {
			LOG.error("ERROR Run DWR for UPDATAE DescriptionAndSizeTab: " + e.getMessage(), e);
		}
		return String.valueOf(result);

	}

	/*
	 * @author tuanle
	 * 
	 * @Description update data for Test Scan
	 * 
	 * @Param
	 * 
	 * @return resultUpdate
	 */
	public String updateDataForTestScan(String[] arrIdResult, String[] arrUnitUPC, String[] arrSeqNo) {
		List<UPCVO> listUPCVO = new ArrayList<UPCVO>();
		int resultUpdate = -1;
		try {
			for (int i = 0; i < arrIdResult.length; i++) {
				String[] arrValues = arrIdResult[i].split("-");
				UPCVO upcVO = new UPCVO();
				upcVO.setPsProdId(Integer.parseInt(arrValues[0]));
				upcVO.setTestScanOverridenStatus('Y');
				upcVO.setTestScanUPC(arrUnitUPC[i]);
				upcVO.setSeqNo(Integer.parseInt(arrSeqNo[i]));
				listUPCVO.add(upcVO);

			}

			resultUpdate = CommonBridge.getCommonServiceInstance().updateTestScan(listUPCVO);

		} catch (Exception e) {
			LOG.error("ERROR Run DWR for updateDataForTestScan: " + e.getMessage(), e);
		}
		return String.valueOf(resultUpdate);

	}

	public String updateDataForDsdDiscontinue(String[] arrId, String[] arrDiscontinueDate, String currentPage) {
		int result = -1;
		try {
			List<EDISearchResultVO> listEDISearchResultVO = new ArrayList<EDISearchResultVO>();
			for (int i = 0; i < arrId.length; i++) {
				EDISearchResultVO ediSearchResultVO = new EDISearchResultVO();
				ediSearchResultVO.setPsItemId(arrId[i]);
				ediSearchResultVO.setDiscontinueDate(arrDiscontinueDate[i]);
				listEDISearchResultVO.add(ediSearchResultVO);
			}

			ManageEDICandidate fmEDI = getForm();
			if (!listEDISearchResultVO.isEmpty()) {
				fmEDI.setListItemToUpdate(listEDISearchResultVO);
				result = 1;
			}

			// set current page is selected on grid
			fmEDI.setCurrentPage(Integer.parseInt(currentPage));
		} catch (Exception e) {
			LOG.error("ERROR Run DWR for updateDataForDsdDiscontinue: " + e.getMessage(), e);
		}

		return String.valueOf(result);

	}

	/*
	 * @author tuanle
	 * 
	 * @Description update data save for Reject
	 * 
	 * @return resultUpdate
	 */
	public String saveReject(String[] arrIdResult, String[] arrRejectReasonsSelected, String[] arrSuggestedActionsSelected, String[] arrStatus, String[] arrChangeStatus) throws CPSBusinessException {
		int resultUpdate = -1;
		List<EDISearchResultVO> listEdiSearchResultVOs = null;// new
																// ArrayList<EDISearchResultVO>();
		Map<String, String> allStatus = null;
		String userRole = getUserRole();
		UserInfo userInfo = getUserInfo();
		try {
			List<CommentUPCVO> listCommentUPCVOs = new ArrayList<CommentUPCVO>();
			List<CommentUPCVO> listCommentUPCVOsCommt = new ArrayList<CommentUPCVO>();
			for (int i = 0; i < arrIdResult.length; i++) {
				if (("1").equals(arrChangeStatus[i].trim()) || ("3").equals(arrChangeStatus[i].trim())) {
					String[] arrValues = arrIdResult[i].split("-");

					CommentUPCVO commentUPCVO = new CommentUPCVO();
					commentUPCVO.setPsWorkId(Integer.parseInt(arrValues[0]));
					commentUPCVO.setPsProdId(Integer.parseInt(arrValues[1]));
					commentUPCVO.setSeqNo(Integer.parseInt(arrValues[2]));

					commentUPCVO.setStatus(String.valueOf(arrStatus[i]));

					if (!(CPSConstant.STRING_EMPTY).equals(arrRejectReasonsSelected[i].trim()))
						commentUPCVO.setRejectReason(CPSHelper.convertHTMLToChars(arrRejectReasonsSelected[i]));
					if (!(CPSConstant.STRING_EMPTY).equals(arrSuggestedActionsSelected[i].trim()))
						commentUPCVO.setSuggestedAction(CPSHelper.convertHTMLToChars(arrSuggestedActionsSelected[i]));
					listCommentUPCVOs.add(commentUPCVO);
				}
				if (("2").equals(arrChangeStatus[i].trim())) {
					String[] arrValues = arrIdResult[i].split("-");

					CommentUPCVO commentUPCVO = new CommentUPCVO();
					commentUPCVO.setPsWorkId(Integer.parseInt(arrValues[0]));
					commentUPCVO.setPsProdId(Integer.parseInt(arrValues[1]));
					commentUPCVO.setSeqNo(Integer.parseInt(arrValues[2]));

					commentUPCVO.setStatus(String.valueOf(arrStatus[i]));

					if (!(CPSConstant.STRING_EMPTY).equals(arrRejectReasonsSelected[i].trim()))
						commentUPCVO.setRejectReason(CPSHelper.convertHTMLToChars(arrRejectReasonsSelected[i]));
					if (!(CPSConstant.STRING_EMPTY).equals(arrSuggestedActionsSelected[i].trim()))
						commentUPCVO.setSuggestedAction(CPSHelper.convertHTMLToChars(arrSuggestedActionsSelected[i]));
					listCommentUPCVOsCommt.add(commentUPCVO);
				}
			}
			if (!listCommentUPCVOsCommt.isEmpty()) {
				CommonBridge.getCommonServiceInstance().updateRejectComment(listCommentUPCVOsCommt);
				resultUpdate = 1;
			}
			if (!listCommentUPCVOs.isEmpty()) {
				String uID = userInfo.getUid();
				String firstName = userInfo.getAttributeValue("givenName");
				String lastName = userInfo.getAttributeValue("sn");
				listEdiSearchResultVOs = CommonBridge.getCommonServiceInstance().updateReject(listCommentUPCVOs, userRole, uID, firstName, lastName);
				ManageEDICandidate fmEDI = getForm();
				// Edit CPSEDIManageForm to remove rejected candidate
				List<EDISearchResultVO> searchResultVOLstTemp = fmEDI.getEdiSearchResultVOLst();
				List<EDISearchResultVO> listItemUpdate = new ArrayList<EDISearchResultVO>();
				allStatus = CommonBridge.getCommonServiceInstance().getCandidateStatus();
				for (int i = 0; i < searchResultVOLstTemp.size(); i++) {
					EDISearchResultVO searchResultVO = searchResultVOLstTemp.get(i);
					if (!listEdiSearchResultVOs.isEmpty()) {
						for (EDISearchResultVO ediSearchResultVO : listEdiSearchResultVOs) {
							if (ediSearchResultVO.getStatus().equals(BusinessConstants.DELETE_CODE)) {
								if (searchResultVO.getPsWorkId().equals(ediSearchResultVO.getPsWorkId())) {
									searchResultVOLstTemp.remove(i);
									i -= 1;
									break;
								}
							}
							if (ediSearchResultVO.getStatus().equals(BusinessConstants.REJECT_CODE)) {
								if (searchResultVO.getPsWorkId().equals(ediSearchResultVO.getPsWorkId())) {
									EDISearchResultVO edResultVO = new EDISearchResultVO();
									edResultVO.setPsWorkId(searchResultVO.getPsWorkId());
									edResultVO.setStatus(BusinessConstants.REJECT_CODE);
									if (allStatus != null && !allStatus.isEmpty()) {
										edResultVO.setStatusValue(allStatus.get(edResultVO.getStatus()));
									}
									listItemUpdate.add(edResultVO);
								}
							}
						}
					}
				}
				fmEDI.setEdiSearchResultVOLst(searchResultVOLstTemp);
				fmEDI.setListItemToUpdate(listItemUpdate);
				resultUpdate = 1;
			}
		} catch (Exception e) {
			LOG.error("ERROR Run DWR for saveReject: " + e.getMessage(), e);
		}

		return String.valueOf(resultUpdate);
	}

	/*
	 * @author tuanle
	 * 
	 * @Description update data save for RejectComment
	 * 
	 * @return resultUpdate
	 */
	public String saveRejectComment(String[] arrIdResult, String[] arrRejectReasonsSelected, String[] arrSuggestedActionsSelected) {
		StringBuffer strData = new StringBuffer();
		strData.append("[");

		try {
			List<CommentUPCVO> listCommentUPCVOs = new ArrayList<CommentUPCVO>();
			for (int i = 0; i < arrIdResult.length; i++) {
				String[] arrValues = arrIdResult[i].split("-");

				CommentUPCVO commentUPCVO = new CommentUPCVO();
				commentUPCVO.setPsWorkId(Integer.parseInt(arrValues[0]));
				commentUPCVO.setPsProdId(Integer.parseInt(arrValues[1]));
				commentUPCVO.setSeqNo(Integer.parseInt(arrValues[2]));

				if (!(CPSConstant.STRING_EMPTY).equals(arrRejectReasonsSelected[i].trim()))
					commentUPCVO.setRejectReason(CPSHelper.convertHTMLToChars(arrRejectReasonsSelected[i]));
				if (!(CPSConstant.STRING_EMPTY).equals(arrSuggestedActionsSelected[i].trim()))
					commentUPCVO.setSuggestedAction(CPSHelper.convertHTMLToChars(arrSuggestedActionsSelected[i]));
				listCommentUPCVOs.add(commentUPCVO);
			}

			if (!listCommentUPCVOs.isEmpty()) {
				CommonBridge.getCommonServiceInstance().updateRejectComment(listCommentUPCVOs);
				for (CommentUPCVO commentUPCVO : listCommentUPCVOs) {
					if (commentUPCVO.getPsProdId() != null && CPSHelper.isNotEmpty(commentUPCVO.getPsProdId())) {
						if (("[").equals(strData.toString()))
							strData.append("{idResult:\"" + commentUPCVO.getPsWorkId() + "-" + commentUPCVO.getPsProdId() + "-" + commentUPCVO.getSeqNo());
						else
							strData.append("\n,{idResult:\"" + commentUPCVO.getPsWorkId() + "-" + commentUPCVO.getPsProdId() + "-" + commentUPCVO.getSeqNo());

						strData.append("\",rejectReason:\"" + (commentUPCVO.getRejectReason() != null ? CPSHelper.convertCharToHTMLForJSON(commentUPCVO.getRejectReason()) : CPSConstant.STRING_EMPTY));
						strData.append("\",suggestedAction:\""
								+ (commentUPCVO.getSuggestedAction() != null ? CPSHelper.convertCharToHTMLForJSON(commentUPCVO.getSuggestedAction()) : CPSConstant.STRING_EMPTY) + "\"}");
					}
				}
			}
		} catch (Exception e) {
			LOG.error("ERROR Run DWR for saveRejectComment: " + e.getMessage(), e);
		}
		strData.append("]");
		return strData.toString();
	}

	public String getAuthorizedStore(String curItemSelected) {
		StringBuffer strData = new StringBuffer();

		try {
			ManageEDICandidate fmEDI = getForm();
			UpcStoreAuthorizationVO upcStoreAuthorizationVO;

			String itemId = curItemSelected.split("-")[0];
			String vendorNo = curItemSelected.split("-")[1];
			String upcNo = curItemSelected.split("-")[2];

			upcStoreAuthorizationVO = fmEDI.getUpcStoreAuthorization();
			if (upcStoreAuthorizationVO != null && upcStoreAuthorizationVO.getPsItemId().equals(itemId) && upcStoreAuthorizationVO.getPsVendno().equals(vendorNo)) {
				upcStoreAuthorizationVO.setUpcNo(upcNo);
			} else {
				VendorVO vendorVO = new VendorVO();
				vendorVO.setPsItemId(Integer.parseInt(itemId));
				vendorVO.setVendorLocNumber(Integer.parseInt(vendorNo));
				vendorVO.setChannel("D"); // only DSD

				upcStoreAuthorizationVO = CommonBridge.getCommonServiceInstance().getUpcStoreAuthorization(vendorVO);

				for (EDISearchResultVO ediSearchResultVO : fmEDI.getEdiSearchResultVOLst()) {
					if (ediSearchResultVO.getPsItemId().equals(String.valueOf(vendorVO.getPsItemId())) && ediSearchResultVO.getPsVendno().equals(String.valueOf(vendorVO.getVendorLocNumber()))
							&& ediSearchResultVO.getUpcNo().equals(upcNo)) {
						upcStoreAuthorizationVO.setUpcNo(ediSearchResultVO.getUpcNo());
						upcStoreAuthorizationVO.setDescription(ediSearchResultVO.getUpcDescription() != null ? ediSearchResultVO.getUpcDescription() : CPSConstant.STRING_EMPTY);
						upcStoreAuthorizationVO.setPsVendno(ediSearchResultVO.getPsVendno());
						upcStoreAuthorizationVO.setPsVendName(ediSearchResultVO.getPsVendName());
						break;
					}
				}

				fmEDI.setUpcStoreAuthorization(upcStoreAuthorizationVO);
			}

			strData.append("{sellingUpc:\"" + CPSHelper.displaySellingUPC(upcStoreAuthorizationVO.getUpcNo()));
			strData.append("\",item:\"" + upcStoreAuthorizationVO.getPsItemId());
			strData.append("\",description:\"" + CPSHelper.convertCharToHTMLForJSON(upcStoreAuthorizationVO.getDescription()));
			strData.append("\",vendorNo:\"" + upcStoreAuthorizationVO.getPsVendno());
			strData.append("\",vendorName:\"" + CPSHelper.convertCharToHTMLForJSON(upcStoreAuthorizationVO.getPsVendName()));
			strData.append("\",size:\"" + upcStoreAuthorizationVO.getSize());
			strData.append("\",dept:\"" + upcStoreAuthorizationVO.getDept());
			strData.append("\",pack:\"" + upcStoreAuthorizationVO.getPack());
			strData.append("\",vpc:\"" + upcStoreAuthorizationVO.getVpc());
			strData.append("\",\nresults: [");

			List<DSDDetailVO> listDSDDetailVO = upcStoreAuthorizationVO.getListDSDDetailVO();
			for (int i = 0; i < listDSDDetailVO.size(); i++) {
				DSDDetailVO dsdResult = listDSDDetailVO.get(i);

				if (i == 0)
					strData.append("\n{store:\"" + dsdResult.getStore());
				else
					strData.append("\n,{store:\"" + dsdResult.getStore());
				strData.append("\",storeName:\"" + CPSHelper.convertCharToHTMLForJSON(dsdResult.getStoreName()));
				strData.append("\",costGroup:\"" + dsdResult.getCostGroup());
				strData.append("\",authorized:\"" + dsdResult.getAuthorized());
				strData.append("\",authorizedDate:\"" + dsdResult.getAuthorizedDate());
				strData.append("\",deAuthorizedDate:\"" + dsdResult.getDeAuthorizedDate());
				strData.append("\",sbt:\"" + dsdResult.getSbt() + "\"}");

			}

			strData.append("]}");

		} catch (Exception e) {
			LOG.error("ERROR Run DWR for getAuthorizedStore: " + e.getMessage(), e);
		}

		return strData.toString();
	}

	/*
	 * @author nghianguyen
	 * 
	 * @Description update data save for RejectComment
	 * 
	 * @return resultUpdate
	 */
	public String rejectDSD(String[] arrIdResult, String[] arrRejectReasonsSelected, String[] arrSuggestedActionsSelected, String[] arrStatus, String[] arrChangeStatus) {
		String resultUpdate = "-1";
		StringBuffer strData = new StringBuffer();
		strData.append("[");
		List<EDISearchResultVO> listEdiSearchResultVOs = new ArrayList<EDISearchResultVO>();
		String userRole = getUserRole();
		UserInfo userInfo = getUserInfo();
		Map<String, String> allStatus = null;
		try {
			List<CommentUPCVO> listCommentUPCVOs = new ArrayList<CommentUPCVO>();
			List<CommentUPCVO> listCommentUPCVOs1 = new ArrayList<CommentUPCVO>();
			for (int i = 0; i < arrIdResult.length; i++) {
				String[] arrValues = arrIdResult[i].split("-");
				CommentUPCVO commentUPCVO = new CommentUPCVO();
				if (("1").equals(arrChangeStatus[i]) || ("3").equals(arrChangeStatus[i])) {
					commentUPCVO.setPsWorkId(Integer.parseInt(arrValues[0]));

					commentUPCVO.setPsProdId(Integer.parseInt(arrValues[1]));
					commentUPCVO.setSeqNo(Integer.parseInt(arrValues[2]));

					commentUPCVO.setStatus(String.valueOf(arrStatus[i]));
					if (!(CPSConstant.STRING_EMPTY).equals(arrRejectReasonsSelected[i].trim()))
						commentUPCVO.setRejectReason(CPSHelper.convertHTMLToChars(arrRejectReasonsSelected[i]));

					if (!(CPSConstant.STRING_EMPTY).equals(arrSuggestedActionsSelected[i].trim()))
						commentUPCVO.setSuggestedAction(CPSHelper.convertHTMLToChars(arrSuggestedActionsSelected[i]));

					listCommentUPCVOs.add(commentUPCVO);
				}
				if (("2").equals(arrChangeStatus[i])) {
					commentUPCVO.setPsWorkId(Integer.parseInt(arrValues[0]));

					commentUPCVO.setPsProdId(Integer.parseInt(arrValues[1]));
					commentUPCVO.setSeqNo(Integer.parseInt(arrValues[2]));

					commentUPCVO.setStatus(String.valueOf(arrStatus[i]));
					if (!(CPSConstant.STRING_EMPTY).equals(arrRejectReasonsSelected[i].trim()))
						commentUPCVO.setRejectReason(CPSHelper.convertHTMLToChars(arrRejectReasonsSelected[i]));

					if (!(CPSConstant.STRING_EMPTY).equals(arrSuggestedActionsSelected[i].trim()))
						commentUPCVO.setSuggestedAction(CPSHelper.convertHTMLToChars(arrSuggestedActionsSelected[i]));

					listCommentUPCVOs1.add(commentUPCVO);
				}
			}
			if (!listCommentUPCVOs1.isEmpty()) {

				CommonBridge.getCommonServiceInstance().updateRejectComment(listCommentUPCVOs1);
				for (CommentUPCVO commentUPCVO : listCommentUPCVOs1) {
					if (commentUPCVO.getPsProdId() != null && CPSHelper.isNotEmpty(commentUPCVO.getPsProdId())) {
						if (("[").equals(strData.toString()))
							strData.append("{idResult:\"" + commentUPCVO.getPsWorkId() + "-" + commentUPCVO.getPsProdId() + "-" + commentUPCVO.getSeqNo());
						else
							strData.append("\n,{idResult:\"" + commentUPCVO.getPsWorkId() + "-" + commentUPCVO.getPsProdId() + "-" + commentUPCVO.getSeqNo());

						strData.append("\",rejectReason:\"" + (commentUPCVO.getRejectReason() != null ? CPSHelper.convertCharToHTMLForJSON(commentUPCVO.getRejectReason()) : CPSConstant.STRING_EMPTY));
						strData.append("\",suggestedAction:\""
								+ (commentUPCVO.getSuggestedAction() != null ? CPSHelper.convertCharToHTMLForJSON(commentUPCVO.getSuggestedAction()) : CPSConstant.STRING_EMPTY) + "\"}");
					}
				}
			}
			strData.append("]");
			if (!listCommentUPCVOs.isEmpty()) {
				String uID = userInfo.getUid();
				String firstName = userInfo.getAttributeValue("givenName");
				String lastName = userInfo.getAttributeValue("sn");
				listEdiSearchResultVOs = CommonBridge.getCommonServiceInstance().updateReject(listCommentUPCVOs, userRole, uID, firstName, lastName);
				ManageEDICandidate fmEDI = getForm();
				// Edit CPSEDIManageForm to remove rejected candidate
				List<EDISearchResultVO> searchResultVOLstTemp = fmEDI.getEdiSearchResultVOLst();
				List<EDISearchResultVO> listItemUpdate = new ArrayList<EDISearchResultVO>();
				allStatus = CommonBridge.getCommonServiceInstance().getCandidateStatus();
				for (int i = 0; i < searchResultVOLstTemp.size(); i++) {
					EDISearchResultVO searchResultVO = searchResultVOLstTemp.get(i);
					if (!listEdiSearchResultVOs.isEmpty()) {
						for (EDISearchResultVO ediSearchResultVO : listEdiSearchResultVOs) {
							if (ediSearchResultVO.getStatus().equals(BusinessConstants.DELETE_CODE)) {
								if (searchResultVO.getPsWorkId().equals(ediSearchResultVO.getPsWorkId())) {
									searchResultVOLstTemp.remove(i);
									i -= 1;
									break;
								}
							}
							if (ediSearchResultVO.getStatus().equals(BusinessConstants.REJECT_CODE)) {
								if (searchResultVO.getPsWorkId().equals(ediSearchResultVO.getPsWorkId())) {
									EDISearchResultVO edResultVO = new EDISearchResultVO();
									edResultVO.setPsWorkId(searchResultVO.getPsWorkId());
									edResultVO.setStatus(BusinessConstants.REJECT_CODE);
									if (allStatus != null && !allStatus.isEmpty()) {
										edResultVO.setStatusValue(allStatus.get(edResultVO.getStatus()));
									}
									listItemUpdate.add(edResultVO);
								}
							}
						}
					}
				}
				fmEDI.setEdiSearchResultVOLst(searchResultVOLstTemp);
				fmEDI.setListItemToUpdate(listItemUpdate);
			}
			resultUpdate = "1";
		} catch (Exception e) {
			LOG.error("ERROR Run DWR for rejectDSD: " + e.getMessage(), e);
		}
		if (!("[]").equals(strData.toString()))
			return String.valueOf(strData.toString());
		else
			return resultUpdate;
	}

	public String warningTaxFoodStamp(String productIds) {
		String warningData = CPSConstant.STRING_EMPTY;
		String taxFllagWarning = CPSConstant.STRING_EMPTY;
		String foodStampWarning = CPSConstant.STRING_EMPTY;
		try {
			Map<Integer, ProductClassificationVO> lstProductClassificationVOs = CommonBridge.getAddNewCandidateServiceInstance().getInforProductClassification(productIds);
			ProductClassificationVO productClassificationVO = null;
			Map<String, CommoditySubCommVO> subComm = null;
			CommoditySubCommVO codes = null;
			List<Integer> lstProductIds = new ArrayList<Integer>();
			CommoditySubCommVO codeOnlys = null;
			if (lstProductClassificationVOs != null && !lstProductClassificationVOs.isEmpty()) {
				for (Map.Entry<Integer, ProductClassificationVO> entry : lstProductClassificationVOs.entrySet()) {
					Integer productId = entry.getKey();
					productClassificationVO = entry.getValue();

					subComm = CommonBridge.getCommonServiceInstance().getSubCommoditiesForClassCommodity(productClassificationVO.getClassField(), productClassificationVO.getCommodity());
					codes = subComm.get(productClassificationVO.getSubCommodity());
					if (codes != null) {
						if (!codes.getFdStampCd().equals(productClassificationVO.getFoodStamp())) {
							foodStampWarning += productClassificationVO.getUpcs() + " " + productClassificationVO.getProdDescritpion();
							foodStampWarning += " - ";
							foodStampWarning += "Food Stamp flag = " + productClassificationVO.getFoodStamp();
							foodStampWarning += "\n";
							codeOnlys = codes;
							if (!lstProductIds.contains(productId)) {
								lstProductIds.add(productId);
							}
						}
						if (!codes.getCrgTaxCd().equals(productClassificationVO.getTaxable())) {
							taxFllagWarning = taxFllagWarning + productClassificationVO.getUpcs() + " " + productClassificationVO.getProdDescritpion();
							taxFllagWarning += " - ";
							taxFllagWarning += "Tax flag = " + productClassificationVO.getTaxable();
							taxFllagWarning += "\n";
							codeOnlys = codes;
							if (!lstProductIds.contains(productId)) {
								lstProductIds.add(productId);
							}
						}
					}
				}
				if (CPSHelper.isNotEmpty(foodStampWarning) || CPSHelper.isNotEmpty(taxFllagWarning)) {
					if (lstProductIds != null && lstProductIds.size() == 1) {
						if (!codeOnlys.getFdStampCd().equals(lstProductClassificationVOs.get(lstProductIds.get(0)).getFoodStamp())) {
							String foodStampValue = "N=No";
							String foodStampDefault = "N=No";
							if (("Y").equals(lstProductClassificationVOs.get(lstProductIds.get(0)).getFoodStamp()))
								foodStampValue = "Y=Yes";
							if (("Y").equals(codeOnlys.getFdStampCd()))
								foodStampDefault = "Y=Yes";
							warningData += "Food Stamp Flag (selected as " + foodStampValue + ") is different than the default for the sub-commodity (set at " + foodStampDefault + ").";
						}
						if (!codeOnlys.getCrgTaxCd().equals(lstProductClassificationVOs.get(lstProductIds.get(0)).getTaxable())) {
							warningData = warningData + "\n\n";
							String taxFlagValue = "N=No";
							String taxFlagValueDefault = "N=No";
							if (("Y").equals(lstProductClassificationVOs.get(lstProductIds.get(0)).getTaxable()))
								taxFlagValue = "Y=Yes";
							if (("Y").equals(codeOnlys.getCrgTaxCd()))
								taxFlagValueDefault = "Y=Yes";
							warningData += " Tax Flag (selected as " + taxFlagValue + ") is different than the default for the sub-commodity (set at " + taxFlagValueDefault + ").";
						}
						warningData = warningData + "\n";

					} else {
						warningData = "Following UPCs have Food stamp that is different than the default for the sub-commodity:\n" + foodStampWarning;
						warningData = warningData + "\nFollowing UPCs have Tax Flag that is different than the default for the sub-commodity:\n" + taxFllagWarning;
					}
					warningData += "\n For assistance with the rules, please contact Procurement Support's Product Team at ext. 87800, Option #1.";
					warningData += "\n\nDo you want to proceed with activation?";
				}
			}
		} catch (CPSGeneralException e) {
			LOG.error(e.getMessage(), e);
		}
		return warningData;
	}

	public String updateDataMassUPloadProfilied(String[] allVendorSelected, String[] allFunctionSelected, String[] allAutoApproveSelected, String[] allStatus, String[] alltypeCdSelected,
			String[] allDSDSelected, String[] allWHSSelected, String[] allBothSelected, int page, int rowPerPage, String filterValues) {
		ManageEDICandidate fmEDI = getForm();
		List<MassUploadVO> lstMassUPloadUpdates = new ArrayList<MassUploadVO>();
		String vendorId;
		MassUploadVO massUploadVO;
		for (int i = 0; i < allVendorSelected.length; i++) {
			if (allVendorSelected[i] != null) {
				massUploadVO = new MassUploadVO();
				// massUploadVO.set
				try {
					if (CPSHelper.isNotEmpty(allVendorSelected[i])) {
						vendorId = allVendorSelected[i].substring(0, allVendorSelected[i].lastIndexOf('-'));
						massUploadVO.setVendorId(Integer.valueOf(vendorId));
						if (CPSHelper.isNotEmpty(allFunctionSelected[i])) {
							massUploadVO.setFunctionId(Integer.valueOf(allFunctionSelected[i]));
						}
						if (CPSHelper.isNotEmpty(allAutoApproveSelected[i]) && !("none").equals(allAutoApproveSelected[i])) {
							if (("Y").equals(allAutoApproveSelected[i])) {
								massUploadVO.setAutoApprove(BusinessConstants.AUTO);
							} else {
								massUploadVO.setAutoApprove(BusinessConstants.MANU);
							}
						} else {
							massUploadVO.setAutoApprove(CPSConstant.STRING_EMPTY);
						}
						if (CPSHelper.isNotEmpty(allStatus[i]) && ("1").equals(allStatus[i])) {
							massUploadVO.setAddFlag(true);
						} else {
							massUploadVO.setAddFlag(false);
						}
						if (CPSHelper.isNotEmpty(allBothSelected[i]) && ("true").equals(allBothSelected[i])) {
							massUploadVO.setBoth(true);
							if (CPSHelper.isNotEmpty(allDSDSelected[i]) && ("true").equals(allDSDSelected[i])) {
								massUploadVO.setDSD(true);
							} else {
								massUploadVO.setDSD(false);
							}
							if (CPSHelper.isNotEmpty(allWHSSelected[i]) && ("true").equals(allWHSSelected[i])) {
								massUploadVO.setWHS(true);
							} else {
								massUploadVO.setWHS(false);
							}
						} else {
							if (CPSHelper.isNotEmpty(allStatus[i]) && ("1").equals(allStatus[i])) {
								if (CPSHelper.isNotEmpty(alltypeCdSelected[i]))
									massUploadVO.setTypeCd(alltypeCdSelected[i]);
								if (CPSHelper.isNotEmpty(allDSDSelected[i]) && ("true").equals(allDSDSelected[i])) {
									massUploadVO.setDSD(true);
								} else {
									massUploadVO.setDSD(false);
								}
								if (CPSHelper.isNotEmpty(allWHSSelected[i]) && ("true").equals(allWHSSelected[i])) {
									massUploadVO.setWHS(true);
								} else {
									massUploadVO.setWHS(false);
								}

							}
							massUploadVO.setBoth(false);
						}
						lstMassUPloadUpdates.add(massUploadVO);
					}
				} catch (NumberFormatException e) {
					LOG.error(e.getMessage(), e);
				}
			}
		}
		fmEDI.setLstMassUPloadUpdates(lstMassUPloadUpdates);
		fmEDI.setCurrentPage(page);
		fmEDI.setCurrentRecord(rowPerPage);
		fmEDI.setFilterValues(filterValues);

		return "1";
	}

	public String deleteMassUploadProfilies(String[] allVendorSelected) {
		ManageEDICandidate fmEDI = getForm();
		List<MassUploadVO> lstMassUPloadUpdates = new ArrayList<MassUploadVO>();
		MassUploadVO massUploadVO;
		String vendorId;
		String functionId;
		for (int i = 0; i < allVendorSelected.length; i++) {
			if (allVendorSelected[i] != null) {
				try {
					massUploadVO = new MassUploadVO();
					vendorId = allVendorSelected[i].substring(0, allVendorSelected[i].lastIndexOf('-'));
					functionId = allVendorSelected[i].substring(allVendorSelected[i].lastIndexOf('-') + 1);
					massUploadVO.setVendorId(Integer.valueOf(vendorId));
					massUploadVO.setFunctionId(Integer.valueOf(functionId));
					lstMassUPloadUpdates.add(massUploadVO);
				} catch (NumberFormatException e) {
					LOG.error(e.getMessage(), e);
				}
			}
		}
		fmEDI.setLstMassUPloadUpdates(lstMassUPloadUpdates);
		return "1";
	}

	public boolean checkMultilPluReuse(String prodIs) throws Exception {
		boolean flag = false;
		Map<String, String> lstUPCs = CommonBridge.getAddNewCandidateServiceInstance().getMultilePluUpcs(prodIs);
		if (lstUPCs != null && !lstUPCs.isEmpty()) {
			String[] upcProdArray;
			for (String upcProd : lstUPCs.values()) {
				upcProdArray = upcProd.split("-");
				flag = CommonBridge.getAddNewCandidateServiceInstance().checkPluReuse(upcProdArray[1], Integer.valueOf(upcProdArray[0]));
				if (flag)
					break;
			}
		}
		return flag;
	}

	public boolean checkMultilPluReuseEDI(String prodIs) throws Exception {
		boolean flag = false;
		Map<String, String> lstUPCs = CommonBridge.getAddNewCandidateServiceInstance().getMultilePluUpcs(prodIs);
		if (lstUPCs != null && !lstUPCs.isEmpty()) {
			String[] upcProdArray;
			for (String upcProd : lstUPCs.values()) {
				upcProdArray = upcProd.split("-");
				flag = CommonBridge.getAddNewCandidateServiceInstance().checkPluReuseEDI(upcProdArray[1], Integer.valueOf(upcProdArray[0]), lstUPCs.values());
				if (flag)
					break;
			}
		}
		return flag;
	}
}
