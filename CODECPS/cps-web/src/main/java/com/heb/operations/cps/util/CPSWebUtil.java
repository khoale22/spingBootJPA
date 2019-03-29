package com.heb.operations.cps.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.heb.operations.cps.model.AddCandidate;
import org.apache.log4j.Logger;

import com.heb.operations.business.framework.exeption.CPSMessage;
import com.heb.operations.cps.vo.CaseUPCVO;
import com.heb.operations.cps.vo.CaseVO;
import com.heb.operations.cps.vo.IngdVO;
import com.heb.operations.cps.vo.MRTUPCVO;
import com.heb.operations.cps.vo.ProductVO;
import com.heb.operations.cps.vo.UPCKitVO;
import com.heb.operations.cps.vo.UPCVO;
import com.heb.operations.cps.vo.VendorVO;

public class CPSWebUtil extends BusinessUtil implements CPSConstants {
	private static Logger LOG = Logger.getLogger(CPSWebUtil.class);

	public static List<String> getToBeClearedFormList(HttpServletRequest request) {
		try {
			List<String> list = (List<String>) request.getSession()
					.getAttribute(LIST_OF_FORMS_TO_BE_CLEARED);
			if (null == list) {
				list = new ArrayList<String>();
				request.getSession().setAttribute(LIST_OF_FORMS_TO_BE_CLEARED,
						list);
			}
			return list;
		} catch (Exception e) {
			LOG.error(
					"in web Util - getToBeClearedFormList--> " + e.getMessage(),
					e);
			LOG.error(((HttpServletRequest) request).getRequestURI());
		}
		return new ArrayList<String>();
	}

	public static String replaceHTMLSpecialChars(String in) {
		String in1 = CPSHelper.getTrimmedValue(in);
		if (CPSHelper.isNotEmpty(in)) {
			in1 = in1.replaceAll("&lt;", "<").replaceAll("&gt;", ">");
			in1 = in1.replaceAll("&#39;", "'").replaceAll("&#37;", "%");
			in1 = in1.replaceAll("&#59;", ";").replaceAll("&#43;", "+");
			in1 = in1.replaceAll("&#40;", "(").replaceAll("&#41;", ")");
			in1 = in1.replaceAll("&quot;", "\"").replaceAll("&amp;", "&");
		}
		return in1;
	}

	public static boolean isExistingUpc(List<MRTUPCVO> mrtList, String unitUpc) {
		boolean success = true;
		if (!mrtList.isEmpty()) {
			for (MRTUPCVO mrtVOTemp : mrtList) {
				if (mrtVOTemp.getUnitUPC().equalsIgnoreCase(unitUpc)) {
					success = false;
				}
			}
		}
		return success;
	}

	public static boolean isExistUpc(List<UPCVO> upcList, String unitUpc1) {
		boolean success = false;
		if (upcList.size() > 0) {
			for (UPCVO upcVOTemp : upcList) {
				if (upcVOTemp.getUnitUpc().equalsIgnoreCase(unitUpc1)) {
					success = true;
				}
			}
		}
		return success;
	}

	public static boolean isExistIngredient(List<IngdVO> ingdList,
			String ingdCode) {
		boolean success = false;
		if (ingdList.size() > 0) {
			for (IngdVO ingdVOTemp : ingdList) {
				if ((CPSHelper.getTrimmedValue(ingdVOTemp.getIngdCode()))
						.equalsIgnoreCase(CPSHelper.getTrimmedValue(ingdCode))) {
					success = true;
				}
			}
		}
		return success;
	}

	public static final String getChannelValForService(String channelVal) {
		if (null == channelVal || "".equals(channelVal.trim())) {
			return null;
		} else if ("DSD".equals(channelVal)) {
			return "D";
		} else if ("WHS".equals(channelVal)) {
			return "V";
		} else if ("BOTH".equals(channelVal)) {
			return null;
		}
		return "";
	}

	public static final boolean yearValidation(Date checkDate) {
		boolean returnFlag = false;
		Date futureDate = futureDate();
		Date currentDate = currentDate();
		if (checkDate.after(currentDate) && checkDate.before(futureDate)) {
			returnFlag = true;
		} else if (checkDate.equals(currentDate)
				|| checkDate.equals(futureDate)) {
			returnFlag = true;
		}
		return returnFlag;
	}

	private static Date futureDate() {
		Calendar calender = Calendar.getInstance();
		calender.add(Calendar.YEAR, 10);
		Date futureDate = calender.getTime();
		return futureDate;
	}

	private static Date currentDate() {
		Calendar calender = Calendar.getInstance();
		Date currentDate = calender.getTime();
		return currentDate;
	}

	public static boolean dateValidation(int year) {
		boolean returnFlag = false;
		Calendar calender = Calendar.getInstance();
		int currentYear = calender.get(Calendar.YEAR);
		int futureYear = currentYear + 10;
		if (year >= currentYear && year <= futureYear) {
			returnFlag = true;
		}
		return returnFlag;
	}

	public static List<CPSMessage> getDWRMessagesInSession(HttpSession session) {
		if (null != session) {
			List<CPSMessage> list = (List<CPSMessage>) session
					.getAttribute(DWR_MESSAGE_SESSION_KEY);
			if (null == list) {
				list = new ArrayList<CPSMessage>();
				session.setAttribute(DWR_MESSAGE_SESSION_KEY, list);
			}
			return list;
		}
		return null;
	}

	public static String mandatoryFieldCheck(AddCandidate candidateForm) {
		StringBuffer returnBuffer = new StringBuffer();
		returnBuffer.append(CPSConstants.EMPTY_STRING);
		if (CPSHelper.isEmpty(candidateForm.getProductVO()
				.getClassificationVO().getProdDescritpion())) {
			returnBuffer.append("Product Description,");
		}
		if (CPSHelper.isEmpty(candidateForm.getProductVO()
				.getClassificationVO().getAlternateBdm())) {
			returnBuffer.append("BDM,");
		}
		if (CPSHelper.isEmpty(candidateForm.getProductVO()
				.getClassificationVO().getCommodity())) {
			returnBuffer.append("Commodity,");
		}
		if (CPSHelper.isEmpty(candidateForm.getProductVO()
				.getClassificationVO().getSubCommodity())) {
			returnBuffer.append("Sub Commodity,");
		}
		if (CPSHelper.isEmpty(candidateForm.getProductVO()
				.getClassificationVO().getProductType())) {
			returnBuffer.append("Product Type,");
		}
		if (CPSHelper.isEmpty(candidateForm.getProductVO()
				.getClassificationVO().getClassField())) {
			returnBuffer.append("Class,");
		}
		if (CPSHelper.isEmpty(candidateForm.getProductVO()
				.getClassificationVO().getBrand())) {
			returnBuffer.append("Brand,");
		}
		if (CPSHelper
				.isEmpty(candidateForm.getProductVO().getUpcVO().isEmpty())) {
			returnBuffer.append("UPC Type,");
		}

		// if(CPSHelper.isEmpty(candidateForm.getProductVO().getPointOfSaleVO().isAbusiveVolatileChemical())){
		// returnBuffer.append("Abusive and Volatile Chemical");
		// }
		returnBuffer.append("<BR>");

		if (CPSHelper.isEmpty(candidateForm.getCaseVO().getMasterPack())) {
			returnBuffer.append("Master Pack,");
		}
		if (("WHS".equals(candidateForm.getCaseVO().getChannel()))
				|| ("BOTH".equals(candidateForm.getCaseVO().getChannel()))) {
			if (CPSHelper.isEmpty(candidateForm.getCaseVO().getMasterLength())) {
				returnBuffer.append("Master Pack Length,");
			}
			if (CPSHelper.isEmpty(candidateForm.getCaseVO().getMasterWidth())) {
				returnBuffer.append("Master Pack Width,");
			}
			if (CPSHelper.isEmpty(candidateForm.getCaseVO().getMasterHeight())) {
				returnBuffer.append("Master Pack Hight,");
			}
			if (CPSHelper.isEmpty(candidateForm.getCaseVO().getMasterWeight())) {
				returnBuffer.append("Master Pack Weight,");
			}
			if (CPSHelper.isEmpty(candidateForm.getCaseVO().getOneTouch())) {
				returnBuffer.append("1-Touch,");
			}
		}

		if (CPSHelper.isEmpty(candidateForm.getCaseVO().isCodeDate())) {
			returnBuffer.append("Code Date,");
		}
		if (CPSHelper.isEmpty(candidateForm.getCaseVO().getMaxShelfLifeDays())) {
			returnBuffer.append("Max Shelf Life Days,");
		}
		if (CPSHelper.isEmpty(candidateForm.getVendorVO().getVendorTie())) {
			returnBuffer.append("Vendor Tie,");
		}
		if (CPSHelper.isEmpty(candidateForm.getVendorVO().getVendorTier())) {
			returnBuffer.append("Vendor Tier,");
		}
		if (CPSHelper.isEmpty(candidateForm.getVendorVO().getCostOwner())) {
			returnBuffer.append("Cost Owner,");
		}
		if (CPSHelper.isEmpty(candidateForm.getVendorVO().getTop2Top())) {
			returnBuffer.append("Top 2 Top,");
		}
		if (CPSHelper.isEmpty(candidateForm.getVendorVO().getCountryOfOrigin())) {
			returnBuffer.append("Country Of Origin,");
		}
		returnBuffer.append("<BR>");

		return returnBuffer.toString();
	}

	public static String sanitize(String input) {

		if (input == null) {
			return null;
		}

		StringBuffer result = new StringBuffer(input.length());
		for (int i = 0; i < input.length(); ++i) {
			switch (input.charAt(i)) {
			case '<':
				result.append("&lt;");
				break;
			case '>':
				result.append("&gt;");
				break;
			case '"':
				result.append("&quot;");
				break;
			case '\'':
				result.append("&#39;");
				break;
			case '%':
				result.append("&#37;");
				break;
			case ';':
				result.append("&#59;");
				break;
			case '(':
				result.append("&#40;");
				break;
			case ')':
				result.append("&#41;");
				break;
			case '+':
				result.append("&#43;");
				break;
			default:
				result.append(input.charAt(i));
				break;
			}
		}
		return result.toString();
	}

	// Fix 511
	public static boolean isExistCaseUpc(List<MRTUPCVO> upcList, String unitUpc) {
		boolean success = false;
		if (upcList.size() > 0) {
			long currentUPC = CPSHelper.getLongValue(unitUpc);
			for (MRTUPCVO upcVOTemp : upcList) {
				if (currentUPC == CPSHelper
						.getLongValue(upcVOTemp.getUnitUPC())) {
					success = true;
					break;
				}
			}
		}
		return success;
	}

	public static void setVendorVoListPrintsToCase(ProductVO productVO) {
		Map<Integer, VendorVO> mapVendor = null;
		if (productVO != null && productVO.getCaseVOs() != null
				&& !productVO.getCaseVOs().isEmpty()) {
			for (CaseVO caseVO : productVO.getCaseVOs()) {
				//Filter out EDC-Whs
				if(!caseVO.getChannel().equalsIgnoreCase(CPSConstant.CHANNEL_WHSDSD)) {
					mapVendor = new HashMap<Integer, VendorVO>();
					if (caseVO.getNewDataSw() == 'Y') {
						if (null != caseVO.getCaseUPCVOs()
								&& !caseVO.getCaseUPCVOs().isEmpty()) {
							for (CaseUPCVO caseUpcVO : caseVO.getCaseUPCVOs()) {
								if (caseUpcVO.isLinked()) {
									for (VendorVO vendorVO : caseVO.getVendorVOs()) {
										mapVendor.put(
												vendorVO.getVendorLocNumber(),
												vendorVO);
									}
									break;
								}
							}
						}
					} else {
						if (null != caseVO.getVendorVOs()
								&& !caseVO.getVendorVOs().isEmpty()) {
							for (VendorVO vendorVO : caseVO.getVendorVOs()) {
								if (vendorVO.getNewDataSw() == 'Y') {
									mapVendor.put(vendorVO.getVendorLocNumber(),
											vendorVO);
								}
							}
						}
					}
					if (productVO.getUpcVO() != null
							&& !productVO.getUpcVO().isEmpty()) {
						for (UPCVO upcvo : productVO.getUpcVO()) {
							if (upcvo.getNewDataSw() == 'Y') {
								if (null != caseVO.getCaseUPCVOs()
										&& !caseVO.getCaseUPCVOs().isEmpty()) {
									for (CaseUPCVO caseUpcVO : caseVO
											.getCaseUPCVOs()) {
										if (caseUpcVO.getUnitUpc().trim()
												.equals(upcvo.getUnitUpc().trim())
												&& caseUpcVO.isLinked()) {
											if (null != caseVO.getVendorVOs()
													&& !caseVO.getVendorVOs()
															.isEmpty()) {
												for (VendorVO vendorVO : caseVO
														.getVendorVOs()) {
													mapVendor.put(vendorVO
															.getVendorLocNumber(),
															vendorVO);
												}
											}
											break;
										}
									}
								}
							}
						}
					}
					if (!mapVendor.isEmpty()) {
						List<VendorVO> lstVendorVO = new ArrayList<VendorVO>();
						for (Map.Entry<Integer, VendorVO> elementVendor : mapVendor
								.entrySet()) {
							lstVendorVO.add(elementVendor.getValue());
						}
						caseVO.setVendorVOListPrints(lstVendorVO);
					} else {
						caseVO.setVendorVOListPrints(new ArrayList<VendorVO>());
					}
				}
			}
		}
	}

	public static boolean isExistingUpcKit(List<UPCKitVO> upcKits, String unitUpc, int prodId) {
		boolean success = true;
		if (CPSHelper.isNotEmpty(upcKits)) {
			for (UPCKitVO upcKitTemp : upcKits) {
				if (upcKitTemp.getUnitUPC().equalsIgnoreCase(unitUpc) || (prodId>0 && prodId==upcKitTemp.getRelatedProdId())) {
					success = false;
					break;
				}
			}
		}
		return success;
	}

}
