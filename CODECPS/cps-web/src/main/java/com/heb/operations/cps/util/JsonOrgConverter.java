package com.heb.operations.cps.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.cps.vo.AgeAndTimeRestricVO;
import com.heb.operations.cps.vo.PointOfSaleVO;
import com.heb.operations.cps.vo.RatingVO;

public class JsonOrgConverter {
	
	private static final Logger LOG = Logger.getLogger(JsonOrgConverter.class);

	@SuppressWarnings("unchecked")
	public static JSONObject initJsonForDT(List<BaseJSFVO> lstRateType,
			List<BaseJSFVO> lstRating, String rateTypeSelected) {

		JSONArray jsonArrRateType = new JSONArray();
		for (int i = 0; i < lstRateType.size(); i++) {
			JSONObject jsonRateType = new JSONObject();
			jsonRateType.put("rateTypeId", lstRateType.get(i).getId());
			jsonRateType.put("rateTypeName", lstRateType.get(i).getName());
			jsonArrRateType.add(jsonRateType);
		}

		JSONArray jsonArrRating = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		if (CPSHelper.isNotEmpty(lstRating)) {
			for (int i = 0; i < lstRating.size(); i++) {
				JSONObject jsonRating = new JSONObject();
				jsonRating.put("ratingId", lstRating.get(i).getId());
				jsonRating.put("ratingName", lstRating.get(i).getName());
				jsonArrRating.add(jsonRating);
			}
			jsonObject.put("rating", jsonArrRating);
		} else {
			jsonObject.put("rating", "");
		}
		jsonObject.put("rateType", jsonArrRateType);
		jsonObject.put("age", "");
		jsonObject.put("salesTime", "");
		jsonObject.put("rateTypeSelected", rateTypeSelected);
		if ("-1".equals(rateTypeSelected)) {
			jsonObject.put("isMapping", "false");
		} else {
			jsonObject.put("isMapping", "true");
		}
		jsonObject.put("ratingSelected", "-1");
		return jsonObject;
	}

	public static JSONObject getJsonRating(List<BaseJSFVO> lstRating) {
		return updateJsonRating(lstRating);
	}

	public static JSONObject getJsonRatingVo(List<RatingVO> lstRating) {
		JSONArray jsonArrRating = new JSONArray();
		for (int i = 0; i < lstRating.size(); i++) {
			JSONObject jsonRating = new JSONObject();
			jsonRating.put("ratingId", lstRating.get(i).getSalsRstrCd().trim());
			if(CPSHelper.getTrimmedValue(lstRating
					.get(i).getSalsRstrGrpCd()).equalsIgnoreCase("3") || CPSHelper.getTrimmedValue(lstRating
					.get(i).getSalsRstrGrpCd()).equalsIgnoreCase("4") ) {
				jsonRating.put("ratingName", lstRating.get(i).getSalsRstrAbb() + " ("+lstRating.get(i).getSalsRstrDes().trim()+")"
						);
			} else {
				jsonRating.put("ratingName", lstRating.get(i).getSalsRstrDes().trim());
			}
			if (null != lstRating.get(i).getRstredQty()) {
				jsonRating.put("ratingRstredQty", lstRating.get(i)
						.getRstredQty().intValue());
			}
			if (lstRating.get(i).getMinRstrAgeNbr() != null) {
				jsonRating.put("minRstrAgeNbr", lstRating.get(i)
						.getMinRstrAgeNbr());
			}
			jsonRating.put("salsRstrGrpCd", CPSHelper.getTrimmedValue(lstRating
					.get(i).getSalsRstrGrpCd()));
			jsonArrRating.add(jsonRating);
		}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("rating", jsonArrRating);
		return jsonObj;
	}

	@SuppressWarnings("unchecked")
	private static JSONObject updateJsonRating(List<BaseJSFVO> lstRating) {
		JSONArray jsonArrRating = new JSONArray();
		for (int i = 0; i < lstRating.size(); i++) {
			JSONObject jsonRating = new JSONObject();
			jsonRating.put("ratingId", lstRating.get(i).getId());
			jsonRating.put("ratingName", lstRating.get(i).getName());
			jsonArrRating.add(jsonRating);
		}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("rating", jsonArrRating);
		return jsonObj;
	}

	public static JSONObject getJSONAgeAndSalesTime(AgeAndTimeRestricVO vo,
			String rating) {
		return updateJSONAgeAndSalesTime(vo, rating);
	}

	@SuppressWarnings("unchecked")
	private static JSONObject updateJSONAgeAndSalesTime(AgeAndTimeRestricVO vo,
			String rating) {
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("age", vo.getRestrictedLimitName());
		jsonObj.put("salesTime", vo.getPurchaseTime());
		jsonObj.put("ratingSelected", rating);
		return jsonObj;
	}

	// parse json to list object
	public static PointOfSaleVO convertJsonToVO(String json) {
		PointOfSaleVO posv = new PointOfSaleVO();
		JSONArray jsonArrayUpdate = null;
		JSONObject jsonInsertRating = new JSONObject();
		List<String> temp1 = new ArrayList<String>();
		List<String> temp2 = new ArrayList<String>();
		try {
			String dbSelling = StringEscapeUtils.unescapeHtml(json);
			jsonArrayUpdate = (JSONArray) new JSONParser().parse(dbSelling);
			for (int i = 0; i < jsonArrayUpdate.size(); i++) {
				jsonInsertRating = (JSONObject) jsonArrayUpdate.get(i);
				if (null != jsonInsertRating.get("sellingTypeId")
						&& jsonInsertRating.get("sellingTypeId") != "-1") {
					temp1.add(jsonInsertRating.get("sellingTypeId").toString());
					if (jsonInsertRating.get("sellingTypeId").equals("1")) { // alcohol
						if (null != jsonInsertRating.get("ofPreConsumptId")) {
							posv.setOffPermise(jsonInsertRating.get(
									"ofPreConsumptId").toString());
						} else {
							posv.setOffPermise(CPSConstant.STRING_EMPTY);
						}
					}
				}
				if (null != jsonInsertRating.get("sellingResId")
						&& jsonInsertRating.get("sellingResId") != "-1") {
					temp2.add(jsonInsertRating.get("sellingResId").toString());
				}
			}
			posv.setLstRating(temp1);
			posv.setLstSellingRestrictions(temp2);
		} catch (ParseException e) {
			LOG.error(e.getMessage(), e);
		}
		return posv;
	}

	public static PointOfSaleVO convertSellingResJsonToVO(String json) {
		PointOfSaleVO posv = new PointOfSaleVO();
		JSONArray jsonArrayUpdate = null;
		JSONObject jsonInsertRating = new JSONObject();
		List<String> temp1 = new ArrayList<String>();
		List<String> temp2 = new ArrayList<String>();
		try {
			String dbSelling = StringEscapeUtils.unescapeHtml(json);
			jsonArrayUpdate = (JSONArray) new JSONParser().parse(dbSelling);
			for (int i = 0; i < jsonArrayUpdate.size(); i++) {
				jsonInsertRating = (JSONObject) jsonArrayUpdate.get(i);
				if (jsonInsertRating.get("sellingTypeId") != "-1") {
					temp1.add(jsonInsertRating.get("sellingTypeId").toString());
				}
				if (jsonInsertRating.get("sellingResId") != "-1") {
					temp2.add(jsonInsertRating.get("sellingResId").toString());
				}
			}
			posv.setLstRating(temp1);
			posv.setLstSellingRestrictions(temp2);
		} catch (ParseException e) {
			LOG.error(e.getMessage(), e);
		}
		return posv;
	}

	public static JSONObject jsonSellResNotMapping(List<BaseJSFVO> lstRateType,
			List<BaseJSFVO> lstRating, String trim, String trim2,
			AgeAndTimeRestricVO vo, String disable) {
		return null;
	}

	public static JSONArray buildJsonTbleSellRes(List<RatingVO> savedRatings,
			List<String> lstSellingFromWS, Map<String, BaseJSFVO> mapRateType,
			boolean isProduct, String offPre, List<String> sellingResWs) {
		JSONArray jsonData = new JSONArray();
		JSONObject jsonOb = null;
		for (int i = 0; i < savedRatings.size(); i++) {
			jsonOb = new JSONObject();
			jsonOb.put("sellingResDisable", false);
			for (int j = 0; j < sellingResWs.size(); j++) {
				if (savedRatings.get(i).getSalsRstrGrpCd().trim()
						.equals(sellingResWs.get(j).trim())) {
					jsonOb.put("sellingResDisable", true);
					break;
				}
			}
			jsonOb.put("rowId", i);
			jsonOb.put("checkBox", false);
			jsonOb.put("sellingResId", CPSHelper.getTrimmedValue(savedRatings
					.get(i).getSalsRstrGrpCd()));
			if (mapRateType.containsKey(CPSHelper.getTrimmedValue(savedRatings
					.get(i).getSalsRstrGrpCd()))) {
				jsonOb.put(
						"sellingResName",
						mapRateType.get(
								CPSHelper.getTrimmedValue(savedRatings.get(i)
										.getSalsRstrGrpCd())).getName());
			}
			jsonOb.put("sellingTypeId", CPSHelper.getTrimmedValue(savedRatings
					.get(i).getSalsRstrCd()));
			jsonOb.put("sellingTypeName", CPSHelper
					.getTrimmedValue(savedRatings.get(i).getSalsRstrDes()));
			jsonOb.put("quantityRes", savedRatings.get(i).getRstredQty()
					.intValue());
			if (savedRatings.get(i).getSalsRstrGrpCd().trim().equals("1")) { // alcohol
				if (savedRatings.get(i).getSalsRstrCd().trim().equals("3")) { // NONE
					jsonOb.put("containAlcoholId", "N");
					jsonOb.put("containAlcoholName", "NO");
				} else {
					jsonOb.put("containAlcoholId", "Y");
					jsonOb.put("containAlcoholName", "YES");
				}
			} else {
				jsonOb.put("containAlcoholId", "-1");
			}
			if (null != offPre && offPre.equals("Y")) {
				jsonOb.put("ofPreConsumptName", "YES");
				jsonOb.put("ofPreConsumptId", "Y");
			} else if (null != offPre && offPre.equals("N")) {
				jsonOb.put("ofPreConsumptId", "N");
				jsonOb.put("ofPreConsumptName", "NO");
			} else {
				jsonOb.put("ofPreConsumptId", CPSConstant.STRING_EMPTY);
				jsonOb.put("ofPreConsumptName", "NO");
			}
			jsonOb.put("isProduct", isProduct);
			jsonData.add(jsonOb);
		}
		return jsonData;
	}

	public static JSONArray convertSellingResJsonToVO(List<BaseJSFVO> json) {
		JSONArray jsonArrayUpdate = new JSONArray();
		JSONObject jSonObj = null;
		if (CPSHelper.isNotEmpty(json)) {
			for (BaseJSFVO object : json) {
				jSonObj = new JSONObject();
				jSonObj.put("rateTypeId", object.getId().trim());
				jSonObj.put("rateTypeName", object.getName().trim());
				jsonArrayUpdate.add(jSonObj);
			}
		}
		return jsonArrayUpdate;
	}
}
