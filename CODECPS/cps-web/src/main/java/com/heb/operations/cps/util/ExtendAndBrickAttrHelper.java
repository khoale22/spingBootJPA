/**
 * 
 */
package com.heb.operations.cps.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.heb.operations.cps.vo.BaseVO;
import com.heb.operations.cps.vo.ProductMiniTaxCateVO;
import com.heb.operations.cps.vo.TaxCategoryVO;
import com.heb.operations.cps.vo.ImageAttribute.AttrDataVO;
import com.heb.operations.cps.vo.ImageAttribute.AttrVO;
import com.heb.operations.cps.vo.ImageAttribute.AttributeCodeVO;
import com.heb.operations.cps.vo.ImageAttribute.DynamicExtentionAttributeVO;
import com.heb.operations.cps.vo.ImageAttribute.GroupAttrVO;
import com.heb.operations.cps.vo.ImageAttribute.ImageAttributeVO;
import com.heb.operations.cps.vo.ImageAttribute.NutritionDetailVO;

/**
 * @author ha.than
 * 
 */
public class ExtendAndBrickAttrHelper {
    public static JSONObject buildDtaGrpToJson(ImageAttributeVO imageAttributeVO) {
	JSONObject jsonObject = null;
	JSONObject jsonObjectGrp = null;
	JSONArray listArrGrp = null;
	JSONArray listArrAllGrp = null;
	JSONObject jsonObjAttr2 = null;
	JSONArray jsonAttDta = null;
	JSONObject jsonObjectEnty = new JSONObject();
	Map<Integer, Integer> mapAttTable = null;
	String valueTxt;
	Integer attrCd;
	if (imageAttributeVO.getExtendAttrWrapper() != null && CPSHelper.isNotEmpty(imageAttributeVO.getExtendAttrWrapper().getLstDynamicExtention())) {
	    for (DynamicExtentionAttributeVO dynExAtt : imageAttributeVO.getExtendAttrWrapper().getLstDynamicExtention()) {
		listArrAllGrp = new JSONArray();
		mapAttTable = new HashMap<Integer, Integer>();
		for (GroupAttrVO grpAttVO : dynExAtt.getExtendAttrVO().getLstGrp()) {
		    if (grpAttVO.getComponentType() != null && grpAttVO.getComponentType().equals(CPSConstant.MULTI_ENTY_VALUE)) {
			int keyFirst = grpAttVO.getLstAttr().get(0).getAttrId();
			if (dynExAtt.getExtendAttrValueVO().getMapData().containsKey(keyFirst)) {
			    jsonObjectGrp = new JSONObject();
			    listArrGrp = new JSONArray();
			    attrCd = 0;
			    for (int i = 0; i < dynExAtt.getExtendAttrValueVO().getMapData().get(keyFirst).size(); i++) {
				jsonObject = new JSONObject();
				jsonObject.put("select", true);
				int seqNbr = 0;
				for (AttrVO attVO2 : grpAttVO.getLstAttr()) {
				    if (dynExAtt.getExtendAttrValueVO().getMapData().containsKey(attVO2.getAttrId())) {
					mapAttTable.put(attVO2.getAttrId(), attVO2.getAttrId());
					if (i < dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).size()) {
					    String value = dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).get(i).getAttrValTxt();
					    int codeId = 0;
					    String codeCd = "";
					    
					    if (dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).get(i).getAttributeCodeVO() != null) {
						if (dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).get(i).getAttributeCodeVO().getAttrCodeId() != null) {
						    codeId = dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).get(i).getAttributeCodeVO().getAttrCodeId();
						}
						codeCd = dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).get(i).getAttributeCodeVO().getAttrValCode();
					    }
					    seqNbr = dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).get(i).getSeqNbr();
					    jsonObject.put(attVO2.getAttrId(), value);
					    jsonObject.put(attVO2.getAttrId() +"codeTxt", value);
					    jsonObject.put(attVO2.getAttrId() + "codeId", codeId);
					    jsonObject.put(attVO2.getAttrId()+ "codeCd", codeCd);
					    attrCd = codeId;

					} else {
					    jsonObject.put(attVO2.getAttrId(), "");
					}
				    } else {
					jsonObject.put(attVO2.getAttrId(), "");
				    }
				    attVO2.setAttrCd(String.valueOf(attrCd));
				}
				jsonObject.put("seqNbr", seqNbr);
				listArrGrp.add(jsonObject);
			    }
			    grpAttVO.setJsonDataUpdate(listArrGrp.toJSONString());
			    grpAttVO.setJsonDataOri(listArrGrp.toJSONString());
			    jsonObjectGrp.put(grpAttVO.getGroupId(), listArrGrp);
			    listArrAllGrp.add(jsonObjectGrp);
			}
		    } else {
			if (!dynExAtt.getExtendAttrValueVO().getMapData().isEmpty()) {
			    jsonObjAttr2 = new JSONObject();
			    valueTxt = "";
			    attrCd = 0;
			    for (AttrVO attVO2 : grpAttVO.getLstAttr()) {
				if (dynExAtt.getExtendAttrValueVO().getMapData().containsKey(attVO2.getAttrId())) {
				    mapAttTable.put(attVO2.getAttrId(), attVO2.getAttrId());
				    jsonAttDta = new JSONArray();
				    for (AttrDataVO attDataVO : dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId())) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put(attDataVO.getSeqNbr(), attDataVO.getAttrValTxt());
					if (attDataVO.getAttributeCodeVO() != null && attDataVO.getAttributeCodeVO().getAttrCodeId() != null) {
					    jsonObj.put("codeId", attDataVO.getAttributeCodeVO().getAttrCodeId());
					} else {
					    jsonObj.put("codeId", 0);
					}
					valueTxt = attDataVO.getAttrValTxt();
					attrCd = attDataVO.getAttributeCodeVO().getAttrCodeId();
					jsonAttDta.add(jsonObj);
				    }
				    attVO2.setAttrValTxt(valueTxt);
				    attVO2.setAttrCd(String.valueOf(attrCd));
				    jsonObjAttr2.put(attVO2.getAttrId(), jsonAttDta);
				}
			    }
			    jsonObjectGrp = new JSONObject();
			    jsonObjectGrp.put(grpAttVO.getGroupId(), jsonObjAttr2);
			    listArrAllGrp.add(jsonObjectGrp);
			}
		    }
		}
		if (!dynExAtt.getExtendAttrValueVO().getMapData().isEmpty()) {
		    jsonObjAttr2 = new JSONObject();
		    for (Integer key : dynExAtt.getExtendAttrValueVO().getMapData().keySet()) {
			if (!mapAttTable.containsKey(key)) {
			    jsonAttDta = new JSONArray();
			    valueTxt = "";
			    attrCd = 0;
			    for (AttrDataVO attDataVO : dynExAtt.getExtendAttrValueVO().getMapData().get(key)) {
				JSONObject jsonObjAttDta2 = new JSONObject();
				if(CPSConstant.STRING_Y.equals(attDataVO.getAttrValListSw().trim())){
				    if(attDataVO.getAttributeCodeVO() != null){
					 jsonObjAttDta2.put(attDataVO.getSeqNbr(), attDataVO.getAttributeCodeVO().getAttrValCode());
				    }else {
					jsonObjAttDta2.put(attDataVO.getSeqNbr(),"");
				    }
				}else {
				    jsonObjAttDta2.put(attDataVO.getSeqNbr(), attDataVO.getAttrValTxt());
				   
				}
//				jsonObjAttDta2.put(attDataVO.getSeqNbr(), attDataVO.getAttrValTxt());
				if (attDataVO.getAttributeCodeVO() != null && attDataVO.getAttributeCodeVO().getAttrCodeId() != null) {
				    jsonObjAttDta2.put("codeId", attDataVO.getAttributeCodeVO().getAttrCodeId());
				} else {
				    jsonObjAttDta2.put("codeId", 0);
				}
				jsonAttDta.add(jsonObjAttDta2);
				valueTxt = valueTxt.concat(attDataVO.getAttrValTxt()).concat(";");
				attrCd = attDataVO.getAttributeCodeVO().getAttrCodeId();
			    }
			    if (CPSHelper.isNotEmpty(valueTxt)) {
				valueTxt = valueTxt.substring(0, valueTxt.length() - 1);
			    }
			    for (AttrVO attrVO : dynExAtt.getExtendAttrVO().getLstSingle()) {
				if (attrVO.getAttrId().equals(key)) {
				    attrVO.setAttrValTxt(valueTxt);
				    attrVO.setAttrCd(String.valueOf(attrCd));
				    break;
				}
			    }
			    jsonObjAttr2.put(key, jsonAttDta);
			}
		    }
		    jsonObjectGrp = new JSONObject();
		    jsonObjectGrp.put("0", jsonObjAttr2);
		    listArrAllGrp.add(jsonObjectGrp);
		}
		jsonObjectEnty.put(dynExAtt.getExtEntyId().toString(), listArrAllGrp);
	    }
	}
	return jsonObjectEnty;
    }

    public static JSONObject buildDtaOfAttrToJsonForBrick(ImageAttributeVO imageAttributeVO) {
	JSONObject jsonObject = null;
	JSONObject jsonObjectGrp = null;
	JSONArray listArrGrp = null;
	JSONArray listArrAllGrp = null;
	JSONObject jsonObjAttr2 = null;
	JSONArray jsonAttDta = null;
	JSONObject jsonObjectEnty = new JSONObject();
	Map<Integer, Integer> mapAttTable = null;
	listArrAllGrp = new JSONArray();
	mapAttTable = new HashMap<Integer, Integer>();
	DynamicExtentionAttributeVO dynExAtt = imageAttributeVO.getBrick();
	String valueTxt;
	Integer attrCd;
	for (GroupAttrVO grpAttVO : dynExAtt.getExtendAttrVO().getLstGrp()) {
	    if (grpAttVO.getComponentType() != null && grpAttVO.getComponentType().equals(CPSConstant.MULTI_ENTY_VALUE)) {
		int keyFirst = grpAttVO.getLstAttr().get(0).getAttrId();
		if (dynExAtt.getExtendAttrValueVO().getMapData().containsKey(keyFirst)) {
		    jsonObjectGrp = new JSONObject();
		    listArrGrp = new JSONArray();
		    attrCd = 0;
		    for (int i = 0; i < dynExAtt.getExtendAttrValueVO().getMapData().get(keyFirst).size(); i++) {
			int seqNbr = 0;
			jsonObject = new JSONObject();
			jsonObject.put("select", true);
			for (AttrVO attVO2 : grpAttVO.getLstAttr()) {
			    if (dynExAtt.getExtendAttrValueVO().getMapData().containsKey(attVO2.getAttrId())) {
				mapAttTable.put(attVO2.getAttrId(), attVO2.getAttrId());
				if (i < dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).size()) {
				    String value = dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).get(i).getAttrValTxt();
				    int codeId = 0;
				    String codeCd = "";
				    jsonObject.put(attVO2.getAttrId(), value);
				    if (dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).get(i).getAttributeCodeVO() != null
					    && dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).get(i).getAttributeCodeVO().getAttrCodeId() != null) {
					codeId = dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).get(i).getAttributeCodeVO().getAttrCodeId();
					codeCd = dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).get(i).getAttributeCodeVO().getAttrValCode();
				    }
				    jsonObject.put(attVO2.getAttrId() +"codeTxt", value);
				    jsonObject.put(attVO2.getAttrId() + "codeId", codeId);
				    jsonObject.put(attVO2.getAttrId()+ "codeCd", codeCd);
				    attrCd = codeId;
				    seqNbr = dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId()).get(i).getSeqNbr();
				} else {
				    jsonObject.put(attVO2.getAttrId(), "");
				}
			    } else {
				jsonObject.put(attVO2.getAttrId(), "");
			    }
			    attVO2.setAttrCd(String.valueOf(attrCd));
			}
			jsonObject.put("seqNbr", seqNbr);
			listArrGrp.add(jsonObject);
		    }
		    
		    grpAttVO.setJsonDataUpdate(listArrGrp.toJSONString());
		    grpAttVO.setJsonDataOri(listArrGrp.toJSONString());
		    jsonObjectGrp.put(grpAttVO.getGroupId(), listArrGrp);
		    listArrAllGrp.add(jsonObjectGrp);
		}
	    } else {
		if (!dynExAtt.getExtendAttrValueVO().getMapData().isEmpty()) {
		    valueTxt = "";
		    attrCd = 0;
		    jsonObjAttr2 = new JSONObject();
		    for (AttrVO attVO2 : grpAttVO.getLstAttr()) {
			if (dynExAtt.getExtendAttrValueVO().getMapData().containsKey(attVO2.getAttrId())) {
			    mapAttTable.put(attVO2.getAttrId(), attVO2.getAttrId());
			    jsonAttDta = new JSONArray();
			    for (AttrDataVO attDataVO : dynExAtt.getExtendAttrValueVO().getMapData().get(attVO2.getAttrId())) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put(attDataVO.getSeqNbr(), attDataVO.getAttrValTxt());
				if (attDataVO.getAttributeCodeVO() != null && attDataVO.getAttributeCodeVO().getAttrCodeId() != null) {
				    jsonObj.put("codeId", attDataVO.getAttributeCodeVO().getAttrCodeId());
				} else {
				    jsonObj.put("codeId", 0);
				}
				valueTxt = attDataVO.getAttrValTxt();
				attrCd = attDataVO.getAttributeCodeVO().getAttrCodeId();
				jsonAttDta.add(jsonObj);
			    }
			    attVO2.setAttrValTxt(valueTxt);
			    attVO2.setAttrCd(String.valueOf(attrCd));

			    jsonObjAttr2.put(attVO2.getAttrId(), jsonAttDta);
			}
		    }
		    jsonObjectGrp = new JSONObject();
		    jsonObjectGrp.put(grpAttVO.getGroupId(), jsonObjAttr2);
		    listArrAllGrp.add(jsonObjectGrp);
		}
	    }
	}
	if (!dynExAtt.getExtendAttrValueVO().getMapData().isEmpty()) {
	    jsonObjAttr2 = new JSONObject();
	    for (Integer key : dynExAtt.getExtendAttrValueVO().getMapData().keySet()) {
		if (!mapAttTable.containsKey(key)) {
		    jsonAttDta = new JSONArray();
		    valueTxt = "";
		    attrCd = 0;
		    for (AttrDataVO attDataVO : dynExAtt.getExtendAttrValueVO().getMapData().get(key)) {
			JSONObject jsonObjAttDta2 = new JSONObject();
			if(CPSConstant.STRING_Y.equals(attDataVO.getAttrValListSw().trim())){
			    if(attDataVO.getAttributeCodeVO() != null){
				 jsonObjAttDta2.put(attDataVO.getSeqNbr(), attDataVO.getAttributeCodeVO().getAttrValCode());
			    }else {
				jsonObjAttDta2.put(attDataVO.getSeqNbr(),"");
			    }
			}else {
			    jsonObjAttDta2.put(attDataVO.getSeqNbr(), attDataVO.getAttrValTxt());
			   
			}
//			jsonObjAttDta2.put(attDataVO.getSeqNbr(), attDataVO.getAttrValTxt());
			if (attDataVO.getAttributeCodeVO() != null && attDataVO.getAttributeCodeVO().getAttrCodeId() != null) {
			    jsonObjAttDta2.put("codeId", attDataVO.getAttributeCodeVO().getAttrCodeId());
			} else {
			    jsonObjAttDta2.put("codeId", 0);
			}
			jsonAttDta.add(jsonObjAttDta2);
			valueTxt = valueTxt.concat(attDataVO.getAttrValTxt()).concat(";");
			attrCd = attDataVO.getAttributeCodeVO().getAttrCodeId();
		    }
		    if (CPSHelper.isNotEmpty(valueTxt)) {
			valueTxt = valueTxt.substring(0, valueTxt.length() - 1);
		    }
		    for (AttrVO attrVO : dynExAtt.getExtendAttrVO().getLstSingle()) {
			if (attrVO.getAttrId().equals(key)) {
			    attrVO.setAttrValTxt(valueTxt);
			    attrVO.setAttrCd(String.valueOf(attrCd));
			    break;
			}
		    }
		    jsonObjAttr2.put(key, jsonAttDta);
		}
	    }
	    jsonObjectGrp = new JSONObject();
	    jsonObjectGrp.put("0", jsonObjAttr2);
	    listArrAllGrp.add(jsonObjectGrp);
	}
	jsonObjectEnty.put(dynExAtt.getExtEntyId().toString(), listArrAllGrp);
	
	
	return jsonObjectEnty;
    }

    public static void parseGrpToJson(ImageAttributeVO imageAttributeVO) {
	JSONObject jsonObject = null;
	JSONArray listArr = null;
	if (CPSHelper.isNotEmpty(imageAttributeVO.getExtendAttrWrapper()) && CPSHelper.isNotEmpty(imageAttributeVO.getExtendAttrWrapper().getLstDynamicExtention())) {
	    for (DynamicExtentionAttributeVO dynExAtt : imageAttributeVO.getExtendAttrWrapper().getLstDynamicExtention()) {
		for (GroupAttrVO grpAttVO : dynExAtt.getExtendAttrVO().getLstGrp()) {
		    if (grpAttVO.getComponentType() != null && ("MULTI_ENTY_VALUE").equals(grpAttVO.getComponentType())) {
			listArr = new JSONArray();
			for (AttrVO attVO : grpAttVO.getLstAttr()) {
			    jsonObject = new JSONObject();
			    jsonObject.put("key", attVO.getAttrId().toString());
			    if (attVO.isRequired()) {
				jsonObject.put("label", attVO.getLabel() + " <strong class=\'redAsterisk\'>*</strong>");
			    } else {
				jsonObject.put("label", attVO.getLabel());
			    }
			    jsonObject.put("attrRequire", attVO.isRequired());
			    jsonObject.put("attrValListSw", attVO.getAttrValListSw());
			    jsonObject.put("dataType", attVO.getDataType());
			    jsonObject.put("prcsnNbr", attVO.getPrcsnNbr());
			    jsonObject.put("maxLnNbr", attVO.getMaxLnNbr());
			    listArr.add(jsonObject);
			}
			if (!listArr.isEmpty()) {
			    grpAttVO.setjSonHeaderGroup(listArr.toJSONString());
			   
			}
		    }
		}
	    }
	}
    }

    public static JSONObject buildMapGrpToJson(Map<Integer, List<AttributeCodeVO>> mapAtt) {
	JSONObject jsonObjCdWrap = new JSONObject();
	JSONObject jsonObjCd = null;
	JSONArray listArrCd = null;
//	JSONObject jsonObjectEnty = new JSONObject();
	if (mapAtt != null && !mapAtt.isEmpty()) {
	    /*for (Integer key : mapAtt.keySet()) {
		listArrCd = new JSONArray();
		jsonObjCd = new JSONObject();
		jsonObjCd.put("value", "");
		jsonObjCd.put("attrCdId", "");
		jsonObjCd.put("text", "-Select-");
		listArrCd.add(jsonObjCd);
		for (AttributeCodeVO attCd : mapAtt.get(key)) {
		    jsonObjCd = new JSONObject();
		    jsonObjCd.put("attrCdId", attCd.getAttrCodeId());
		    jsonObjCd.put("value", attCd.getAttrValCode());
		    jsonObjCd.put("text", attCd.getAttrValText());
		    listArrCd.add(jsonObjCd);
		}
		jsonObjCdWrap.put(key, listArrCd);
	    }*/
	    // Doan code tren duoc viet lai ben duoi
	    for(Map.Entry<Integer, List<AttributeCodeVO>> entry : mapAtt.entrySet()){
		listArrCd = new JSONArray();
		jsonObjCd = new JSONObject();
		
		jsonObjCd.put("value", "");
		jsonObjCd.put("attrCdId", "");
		jsonObjCd.put("text", "-Select-");
		listArrCd.add(jsonObjCd);
		for (AttributeCodeVO attCd : entry.getValue()) {
		    jsonObjCd = new JSONObject();
		    jsonObjCd.put("attrCdId", attCd.getAttrCodeId());
		    jsonObjCd.put("value", attCd.getAttrValCode());
		    jsonObjCd.put("text", attCd.getAttrValText());
		    listArrCd.add(jsonObjCd);
		}
		jsonObjCdWrap.put(entry.getKey(), listArrCd);
	    }
	}
	return jsonObjCdWrap;
    }
    public static JSONArray buildProdListToJson(List<ProductMiniTaxCateVO> prods) {
	JSONArray listArrCd = new JSONArray();
   	JSONObject jsonObjCd = null;
   	JSONObject jsonObjCds = new JSONObject();
   	if (prods != null && !prods.isEmpty()) {
   	    for(ProductMiniTaxCateVO entry : prods){
   		jsonObjCd = new JSONObject();
   		jsonObjCd.put("productId", entry.getProductId());
   		jsonObjCd.put("productDes", entry.getProductDes());
   		jsonObjCd.put("size", entry.getSize());
   		listArrCd.add(jsonObjCd);
   	    }
   	}
   	return listArrCd;
    }
    public static JSONObject buildValueTotalToJson(int prods) {
   	JSONObject jsonObjCd  = new JSONObject();
   	jsonObjCd.put("total", prods);
   	return jsonObjCd;
    }
    public static JSONObject buildTaxCategoryToJson(TaxCategoryVO taxCategoryVO) {
   	JSONObject jsonObjCd = new JSONObject();
   	jsonObjCd.put("txBltyDvrCode", taxCategoryVO.getTxBltyDvrCode());
   	jsonObjCd.put("txBltyDvrName", taxCategoryVO.getTxBltyDvrName());
   	jsonObjCd.put("txBltyCatDesc", taxCategoryVO.getTxBltyCatDesc());
   	return jsonObjCd;
    }
    public static JSONArray buildListDataDistinctToJson(List<TaxCategoryVO> prods) {
   	JSONArray listArrCd = new JSONArray();
      	JSONObject jsonObjCd = null;
      	if (prods != null && !prods.isEmpty()) {
      	    for(TaxCategoryVO entry : prods){
      		jsonObjCd = new JSONObject();
      		jsonObjCd.put("txBltyDvrCode", entry.getTxBltyDvrCode());
      		jsonObjCd.put("txBltyDvrName", entry.getTxBltyDvrName());
      		jsonObjCd.put("txBltyCatDesc", entry.getTxBltyCatDesc());
      		listArrCd.add(jsonObjCd);
      	    }
      	}
      	return listArrCd;
       }
    public static JSONObject buildMapDataPopupToJson(Map<Integer, List<AttributeCodeVO>> mapAtt) {
	JSONObject jsonObjCdWrap = new JSONObject();
	JSONObject jsonObjCd = null;
	JSONArray listArrCd = null;
	if (mapAtt != null && !mapAtt.isEmpty()) {
	    for(Map.Entry<Integer, List<AttributeCodeVO>> entry : mapAtt.entrySet()){
		listArrCd = new JSONArray();
			
		for (AttributeCodeVO attCd : entry.getValue()) {
		    jsonObjCd = new JSONObject();
		    jsonObjCd.put("checkBox", false);
		    jsonObjCd.put("attrCdId", attCd.getAttrCodeId());
		    jsonObjCd.put("attrName", attCd.getAttrValCode());
		    jsonObjCd.put("attrDesc", attCd.getAttrValText());
		    jsonObjCd.put("attrCode", attCd.getAttrCodeId());
		    listArrCd.add(jsonObjCd);
			}
		jsonObjCdWrap.put(entry.getKey(), listArrCd); 
	    }
	}
	return jsonObjCdWrap;
    }

    public static void parseBrickGrpToJson(DynamicExtentionAttributeVO deAttrVO) {
	JSONObject jsonObject = null;
	JSONArray listArr = null;
	for (GroupAttrVO grpAttVO : deAttrVO.getExtendAttrVO().getLstGrp()) {

	    if (grpAttVO.getComponentType() != null && ("MULTI_ENTY_VALUE").equals(grpAttVO.getComponentType())) {

		listArr = new JSONArray();
		for (AttrVO attVO : grpAttVO.getLstAttr()) {
		    jsonObject = new JSONObject();
		    jsonObject.put("key", attVO.getAttrId().toString());
		    if (attVO.isRequired()) {
			jsonObject.put("label", attVO.getLabel() + " <strong class=\'redAsterisk\'>*</strong>");
		    } else {
			jsonObject.put("label", attVO.getLabel());
		    }
		    jsonObject.put("attrRequire", attVO.isRequired());
		    jsonObject.put("attrValListSw", attVO.getAttrValListSw());
		    jsonObject.put("dataType", attVO.getDataType());
		    jsonObject.put("prcsnNbr", attVO.getPrcsnNbr());
		    jsonObject.put("maxLnNbr", attVO.getMaxLnNbr());
		    listArr.add(jsonObject);
		    // attCellVO.setFormatter();
		    // attCellVO.setDropdownOptions();
		}
		if (!listArr.isEmpty()) {
		    grpAttVO.setjSonHeaderGroup(listArr.toJSONString());
		}
	    }
	}
    }

    public static String buildDataNutritionDetaiToJson(List<NutritionDetailVO> lstNutritionDetailVOs) {
	String str = null;
	JSONObject jsonObject = null;
	JSONArray listArr = new JSONArray();
	if (CPSHelper.isNotEmpty(lstNutritionDetailVOs)) {
	    for (NutritionDetailVO nutritionDetailVO : lstNutritionDetailVOs) {
		jsonObject = new JSONObject();
		jsonObject.put("checkBox", false);
		if (CPSHelper.isNotEmpty(nutritionDetailVO.getNutritionId())) {
		    jsonObject.put("nutritionId", nutritionDetailVO.getNutritionId());
		} else {
		    jsonObject.put("nutritionId", "");
		}
		jsonObject.put("nutriQuantity", nutritionDetailVO.getNutriQuantity());
		jsonObject.put("nutriQuantityPre", nutritionDetailVO.getNutriQuantityPre());
		jsonObject.put("servingSizeUOMCD", nutritionDetailVO.getServingSizeUOMCD());
		jsonObject.put("servingSizeUOMCDPre", nutritionDetailVO.getServingSizeUOMCDAsPre());
		jsonObject.put("nutritionMeasr", nutritionDetailVO.getNutritionMeasr());
		jsonObject.put("dailyValuePac", nutritionDetailVO.getDailyValue());
		jsonObject.put("dailyValuePre", nutritionDetailVO.getDailyValueAsPre());
		jsonObject.put("nutrientTypeTxt", nutritionDetailVO.getNutritionName());
		jsonObject.put("sizeUomTxt", nutritionDetailVO.getServingSizeUOMDesc());
		jsonObject.put("sizeUomTxtPre", nutritionDetailVO.getServingSizeUOMDescAsPre());
		jsonObject.put("changed", false);
		jsonObject.put("isOrContainer", nutritionDetailVO.getIsOrContainer());
		jsonObject.put("keyNutrition", nutritionDetailVO.getKeyNutrition());
		jsonObject.put("rowUni", nutritionDetailVO.getRowUni());
		jsonObject.put("preTypeCd", nutritionDetailVO.getPreTypeCd());
		listArr.add(jsonObject);
	    }
	    str = listArr.toJSONString();
	}
	return str;
    }

    public static JSONObject buildDtaOfAttrToJsonForSzUOMs(List<BaseVO> lstSzUOMs) {
	JSONObject jsonObjCdWrap = new JSONObject();
	JSONObject jsonObjCd = null;
	JSONArray listArrCd = null;
	if (CPSHelper.isNotEmpty(lstSzUOMs)) {
	    listArrCd = new JSONArray();
	    for (BaseVO bVO : lstSzUOMs) {
		jsonObjCd = new JSONObject();
		jsonObjCd.put("radio", false);
		jsonObjCd.put("cd", bVO.getCd());
		jsonObjCd.put("desc", bVO.getDesc());
		jsonObjCd.put("id", bVO.getId());
		listArrCd.add(jsonObjCd);

	    }
	    jsonObjCdWrap.put("items", listArrCd);
	}
	return jsonObjCdWrap;
    }
}
