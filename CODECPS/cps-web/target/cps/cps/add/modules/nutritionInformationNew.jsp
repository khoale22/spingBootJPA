<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<style>
/* .yui-skin-sam .yui-dt td.align-center { */
/* 	text-align: center; */
/* } */

/* .yui-skin-sam .yui-dt th { */
/* 	text-align: center; */
/* 	font-weight: bold; */
/* 	color: #00000; */
/* 	font-family: Arial, Helvetica, sans-serif; */
/* 	font-size: 12px; */
/* } */
.yui-skin-sam TR.yui-dt-selected TD{
	color: black;
}
/* .yui-skin-sam .yui-dt TD { */
/* 	text-align: justify; */
/* } */
#nutritionPage .yui-dt-message {
	display: none;
}
.hideClaims {
	display: none;
}
.yui-skin-sam .yui-dt td.align-right { 
	    text-align:right;
}
.yui-skin-sam .yui-dt td.align-left { 
	    text-align:left;
}
.yui-dt-col-nutrient {
	text-align: right;
}
.yui-dt-col-nutriQuantity{
	text-align: left;
}  
.yui-dt-col-dailyValuePac {
	text-align: left;
}
.yui-dt-col-nutriQuantityPre {
	text-align: left;
}
.yui-dt-col-dailyValuePre {
	text-align: left;
}
.yui-skin-sam .myAutoComplete .myAutoCompleteQuantityUom .myAutocompleteMeasurementPrecision .yui-ac-content {	
	overflow: auto;
	overflow-x: hidden;
	_height: 14em;
	z-index: 15000;
	left: 0px;
	text-align: left;
	color: #000;
}

.yui-skin-sam .yui-ac-content {
	max-height: 13em;
	overflow: auto;
	overflow-x: hidden;	
}
#popupNutriInfo .yui-dt-loading {
	display: none;
}
#popupNutriDatadrid .yui-dt-empty {
	display: none;
}
.hide {
 display:none; 
 visibility:hidden;
}
.yui-dt-scrollable .yui-dt-bd {
	overflow: auto;	
}
#errorMsg {
	color: red;
}

/* #popupNutriDatadrid td.yui-dt-col-nutritionId input{ */
/* 	width:201px; */
/* } */


/* #popupNutriDatadrid td.yui-dt-col-nutriQuantity input{ */
/* 	width:105px; */
/* } */

/* #popupNutriDatadrid td.yui-dt-col-servingSizeUOMCD input{ */
/* 	width:120px; */
/* } */
/* #popupNutriDatadrid td.yui-dt-col-nutritionMeasr input{ */
/* 	width:120px; */
/* } */
/* #popupNutriDatadrid td.yui-dt-col-dailyValue input{ */
/* 	width:180px; */
/* } */
.nutritionPopupContent {
	height:408px;
	overflow: scroll;
}
/*  .nutritionPopupContent .tblNutrition { */
/*  	width: 97%; */
/*  } */
/* #popupNutriDatadrid { */
/* 	width:100% */
/* } */
/* #popupNutriDatadrid table { */
/* 	width: 97% */
/* } */
</style>
<c:set var="showOrHide" value="inline"></c:set>
<c:url value="${request.getContextPath()}/hebAssets/images/dropdown.bmp" var="image"></c:url>
<c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.srcSysId eq '7'}">
	<c:set var="showOrHide" value="none"></c:set>
</c:if>
<script type="text/javascript">
	//Adding trim function to String object
	if(typeof String.prototype.trim !== 'function') {
	  String.prototype.trim = function() {
	    return this.replace(/^\s+|\s+$/g, '');
	  }
	}
	function getTrimmedValue(str) {
		return str==null?"":str;
	}
	var isOrContainer = "";
	var arrNutriVOs = new Array();
	var arrNutriVOsPopup = new Array();
	var arrIsOrContainer = new Array();
	var maxNutrient;
	var isPopupShowed = false;
	var isPreShowed = false;
	var isUomShowed = false;
	var prodValDes = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.prodValDes}"/>';
	var chBoxAsPre = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.chBoxAsPre}"/>';
	var sizeOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSize}"/>';
	var sizeUomOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSizeUOMDesc}"/>';
	var houseHoldOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.houseHoldSize}"/>';
	var preStateOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.preState}"/>';
	var dailyValueOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.dailyIntakeRef}"/>';
	var fatMilkOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.fatMilkContent}"/>';
	
	var srcSysIdOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.srcSysId}"/>';
	var srcSysID = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.srcSysId}"/>';
	var sizeUOMCD = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSizeUOMCD}"/>';
	var sizeUOMFilter = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSizeUOMCD}"/>';
	
	var newArrInfoTmp = new Array();
	var isEditing = false;
	var newArrISorCont = new Array();
	
	var tableNutrt,
	myPaneltableNutrt, tableNutrtPop;
	var widthTable = (screen.width - 250)+"px";
	var widthTableColumn = (screen.width - 355)*0.2;
	var widthTableColPop = 770*0.2;
	
	var isMandatory = ${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw};
	var lstQuantityUOM = convertListToArrayUOM();
	var lstNutriType = convertListToArrayNutriType();
	
	var dailyValueFormatter = function(elLiner, oRecord, oColumn, oData) {
        if(oData < 0) {
            elLiner.innerHTML = '';
        }else {
        	if(oRecord.getData("nutritionId") == 1){
        		elLiner.innerHTML = '';
        	}else {
        		elLiner.innerHTML = '<div style="width: 100px;float:left;text-align:right;">' +oData + '</div>' + '<div style="text-align:left;float:left;margin-left:10px"> % </div>';        		
        	}
        }         
    };
    var amountPerSrvPacFormatter = function(elLiner, oRecord, oColumn, oData) {
		if(oData < 0) {
            elLiner.innerHTML = '';
        }else {
        	if(oRecord.getData("nutritionId") == 1){
        		elLiner.innerHTML = '<div style="width: 100px;float:left;text-align:right;">' +oData + '</div>' + '<div style="text-align:left;float:left;margin-left:10px">'+' &#8594; '+oRecord.getData("dailyValuePac")+'</div>';
        	}else {
        		elLiner.innerHTML = '<div style="width: 100px;float:left;text-align:right;">' +oData + '</div>' + '<div style="text-align:left;float:left;margin-left:10px">'+oRecord.getData("sizeUomTxt")+'</div>';
        	}
        }      
    };
    var amountPerSrvPreFormatter = function(elLiner, oRecord, oColumn, oData) {
		if(oData < 0) {
            elLiner.innerHTML = '';
        }else {
        	elLiner.innerHTML = '<div style="width: 100px;float:left;text-align:right;">' +oData + '</div>' + '<div style="text-align:left;float:left;margin-left:10px">'+oRecord.getData("sizeUomTxtPre")+'</div>';
        }      
    };
	var columnDefsTemp = [ 
	            {key:"nutrient", label : "Nutrient <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>",className: 'align-right',width:widthTableColumn}, 
	            {label : "As Packaged",className: 'align-center',
	            	children:[
	                      {key:"nutriQuantity", label : "Amount per serving <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>",formatter:amountPerSrvPacFormatter,width:widthTableColumn}, 
	                      {key:"dailyValuePac", label : "% Daily value",formatter:dailyValueFormatter,width:widthTableColumn}
	            ]},
                {label : "As Prepared",className: 'align-center',
	            	children:[
            	      	{label:'<input type="text" disabled="disabled" name="prodValDes" id="prodValDes" value="'+prodValDes+'" style="width: 300px;">',
			            	children:[
			                      {key:"nutriQuantityPre", label : "Amount per serving <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>",formatter:amountPerSrvPreFormatter,width:widthTableColumn}, 
			                      {key:"dailyValuePre", label : "% Daily value",formatter:dailyValueFormatter,width:widthTableColumn}
			            	]}
            	      	]
	            }
	     ]; 
	var amountPerSrvPacPopFormatter = function(elLiner, oRecord, oColumn, oData) {
    	if(oRecord.getData("custom") == true){
    		var quantityUomName = oRecord.getData("sizeUomTxt");
    		elLiner.innerHTML = '<div style="float:left"> <input style="width: 70px" maxlength="10" onkeypress="return validNumPress(event)" onblur="roundValue(this,4);changeValueDatatable(this);return true;" id="nutriQuantity_'+oRecord.getData("rowUni")+'" type="text" value="'+oRecord.getData("nutriQuantity")+'"> </div>' +
    		"<div class='myAutoCompleteQuantityUom' style='width:110px;float:left;padding-left:5px' id='myAutoCompleteQuantityUom"+oRecord.getData("keyNutrition")+"'><input type='text' id='myInputQuantityUom"+oRecord.getData("keyNutrition")+"' value='"+convertHtml(quantityUomName)+"' maxlength='50'  onKeyPress='return disableEnterKey(event)' style='position: relative; width:110px;'/><img src='${image}'  width='21' id='imageQuantityUom"+oRecord.getData("keyNutrition")+"' height='21' hspace='5' style='position:absolute;top: 2px;right:-12px;'/><div id='myContainerQuantityUom"+oRecord.getData("keyNutrition")+"'></div></div>";
    	}else {
    		if(oData < 0) {
                elLiner.innerHTML = '';
            }else {
            	if(oRecord.getData("nutritionId") == 1){
            		elLiner.innerHTML = '<input style="width: 70px" maxlength="10" onkeypress="return validNumPress(event)" onblur="roundValue(this,4);changeValueDatatable(this);return true;" id="nutriQuantity_'+oRecord.getData("rowUni")+'" type="text" value="'+oRecord.getData("nutriQuantity")+'">' +' &#8594; '+oRecord.getData("dailyValuePac");
            	}else {
            		elLiner.innerHTML = '<input style="width: 70px" maxlength="10" onkeypress="return validNumPress(event)" onblur="roundValue(this,4);changeValueDatatable(this);return true;" id="nutriQuantity_'+oRecord.getData("rowUni")+'" type="text" value="'+oRecord.getData("nutriQuantity")+'">' +' '+oRecord.getData("sizeUomTxt");
            	}
            }      
    	}
    };
    var amountPerSrvPrePopFormatter = function(elLiner, oRecord, oColumn, oData) {
    	if(oRecord.getData("custom") == true){
    		elLiner.innerHTML = '<input style="width: 70px" maxlength="10" onkeypress="return validNumPress(event)" onblur="roundValue(this,4);changeValueDatatable(this);return true;" id="nutriQuantityPre_'+oRecord.getData("rowUni")+'" type="text" value="'+oRecord.getData("nutriQuantityPre")+'">'+' '+oRecord.getData("sizeUomTxtPre");
    	}else {
    		if(oData < 0) {
                elLiner.innerHTML = '';
            }else {
           	 	elLiner.innerHTML = '<input style="width: 70px" maxlength="10" onkeypress="return validNumPress(event)" onblur="roundValue(this,4);changeValueDatatable(this);return true;" id="nutriQuantityPre_'+oRecord.getData("rowUni")+'" type="text" value="'+oRecord.getData("nutriQuantityPre")+'">' +' '+oRecord.getData("sizeUomTxtPre");
            }      
    	}
    };
    var dailyValuePacPopFormatter = function(elLiner, oRecord, oColumn, oData) {
        if(oRecord.getData("dailyValuePac") < 0) {
            elLiner.innerHTML = '';
        }else {
        	if(oRecord.getData("nutritionId") == 1){
        		 elLiner.innerHTML = '';
        	}else {
        		elLiner.innerHTML = '<input style="width: 70px" maxlength="10" onkeypress="return validNumPress(event)" onblur="roundValue(this,4);changeValueDatatable(this);return true;" id="dailyValuePac_'+oRecord.getData("rowUni")+'" type="text" value="'+oRecord.getData("dailyValuePac")+'">' +' %';        		
        	}
        }         
    };
    var dailyValuePrePopFormatter = function(elLiner, oRecord, oColumn, oData) {
        if(oRecord.getData("dailyValuePre") < 0) {
            elLiner.innerHTML = '';
        }else {
        	elLiner.innerHTML = '<input style="width: 70px" maxlength="10" onkeypress="return validNumPress(event)" onblur="roundValue(this,4);changeValueDatatable(this);return true;" id="dailyValuePre_'+oRecord.getData("rowUni")+'" type="text"  value="'+oRecord.getData("dailyValuePre")+'">' +' %';
        }         
    };
    var nutrientPopFormatter = function(elLiner, oRecord, oColumn, oData) {
    	if(oRecord.getData("custom") == true){
    		var nutritionName = oRecord.getData("nutrientTypeTxt");
            elLiner.innerHTML = "<div style='float:left'> <img id='"+oRecord.getData("rowUni")+"' width = '80px' height='23px' src='${request.getContextPath()}/cps/hebAssets/images/buttons/removeButton.png' onclick='deleteRow(this)'></image> </div>" +
            "<div class='myAutoComplete' style='float:left;width:115px;' id='myAutoComplete"+oRecord.getData("keyNutrition")+"'><input type='text' id='myInput"+oRecord.getData("keyNutrition")+"' value='"+convertHtml(nutritionName)+"' maxlength='50' onKeyPress='return disableEnterKey(event)' style='position: relative;width:115px;'><img src='${image}'  width='21' id='image"+oRecord.getData("keyNutrition")+"' height='21' hspace='5' style='position:absolute;top: 2px;right:-12px;'/><div id='myContainer"+oRecord.getData("keyNutrition")+"'></div></div>";
        }else {
        	 elLiner.innerHTML = "<div style='text-align:right;'>"+oRecord.getData("nutrient")+"</div>";
        }         
    };
// 	var formatAutocompleteQuantityUom = function(elCell, oRecord, oColumn, sData) {				 			
// 		var quantityUomName = oRecord.getData("sizeUomTxt");
// 		elCell.innerHTML = "<div class='myAutoCompleteQuantityUom' id='myAutoCompleteQuantityUom"+oRecord.getData("keyNutrition")+"'><input type='text' id='myInputQuantityUom"+oRecord.getData("keyNutrition")+"' value='"+convertHtml(quantityUomName)+"' size='20' maxlength='50' onKeyPress='return disableEnterKey(event)' style='position: relative;'/><img src='${image}'  width='20' id='imageQuantityUom"+oRecord.getData("keyNutrition")+"' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerQuantityUom"+oRecord.getData("keyNutrition")+"'></div></div>";	
// 	};
	var columnDefsPop = [ 
	      	            {key:"nutrient", label : "Nutrient <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>",formatter:nutrientPopFormatter,width:widthTableColPop+45}, 
	      	            {label : "As Packaged",
	      	            	children:[
	      	                      {key:"nutriQuantity", className: 'align-left', label : "Amount per serving <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>",width:widthTableColPop+40,formatter:amountPerSrvPacPopFormatter}, 
	      	                      {key:"dailyValuePac", label : "% Daily value",className: 'align-left',formatter:dailyValuePacPopFormatter,width:widthTableColPop-50}
	      	            ]},
	                    {label : "As Prepared",
	      	            	children:[
	                  	      	{label:'<input type="text" name="prodValDesPopup" id="prodValDesPopup" maxlength ="50"  style="width: '+widthTableColPop*2+'px;">',
	      			            	children:[
	      			                      {key:"nutriQuantityPre",className: 'align-left', label : "Amount per serving <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>",width:widthTableColPop+40,formatter:amountPerSrvPrePopFormatter}, 
	      			                      {key:"dailyValuePre", label : "% Daily value",className: 'align-left',formatter:dailyValuePrePopFormatter,width:widthTableColPop-50}
	      			            	]}
	                  	      	]
	      	            }
	      	     ]; 
	function changeValueDatatable(element) {
		var key = element.id.split('_')[0];
		var id = element.id.split('_')[1];
    	for (var i= 0; i< tableNutrtPop.getRecordSet().getLength();i++){
    		var oRec = tableNutrtPop.getRecordSet().getRecord(i);
			if(id == oRec.getData("rowUni")){
				oRec.setData(key,element.value);
				if(key =="nutriQuantityPre") {
					if(element.value == ""){
						oRec.setData("sizeUomTxtPre","");
						oRec.setData('servingSizeUOMCDPre',"");
					}else {
						oRec.setData("sizeUomTxtPre",oRec.getData("sizeUomTxt"));
						oRec.setData('servingSizeUOMCDPre',oRec.getData("servingSizeUOMCD"));
					}
					tableNutrtPop.refreshView();
					if(document.getElementById('chBoxAsPrePop').checked){
						setEditableForTextInput('yui-dt-col-nutriQuantityPre', false);
						setEditableForTextInput('yui-dt-col-dailyValuePre', false);
					}else {
						setEditableForTextInput('yui-dt-col-nutriQuantityPre', true);
						setEditableForTextInput('yui-dt-col-dailyValuePre', true);
							
					}
				}
				break;
			}
    	}
	}
	function deleteRow(element) {
		var value = element.id;
		if(tableNutrtPop.getRecordSet().getLength() > 28){
			for (var i= 0; i< tableNutrtPop.getRecordSet().getLength();i++){
				var oRec = tableNutrtPop.getRecordSet().getRecord(i);
				if(value == oRec.getData("rowUni")){
					var answer = confirm ("Are you sure you want to delete Nutrient "+oRec.getData("nutrient")+" ?");
					if (answer) {
						tableNutrtPop.deleteRow(i); 
					}
					break;
				}
		 	}
		}
	}
	<c:forEach var="item" items="${CPSForm.productVO.imageAttVO.nutriInfoVO.lstNutriDatagrid}" varStatus="count">
	var dailyValuePac  = '${item.dailyValue}';
	var dailyValuePre  = '${item.dailyValueAsPre}';
	var nutriQuantityPac = '${item.nutriQuantity}';
	var nutriQuantityPre = '${item.nutriQuantityPre}';
		<c:if test="${item.isOrContainer ne 1}">
			var custom = false;
			if(${count.count} == 1 || ${count.count} == 2 || ${count.count} == 5 || ${count.count} == 6 || ${count.count} == 7
					|| ${count.count} == 13 || ${count.count} == 14){
				if(!(${item.nutritionId} == 1)){
					dailyValuePac = -1;
				}
				dailyValuePre = -1;
			}
			if(${count.count} > 14 && ${count.count} < 29){
				nutriQuantityPac = -1;
				nutriQuantityPre = -1;
			}
			if(${count.count} > 28){
				custom = true;
			}
// 			if(nutriQuantityPre != -1 && nutriQuantityPre != '' && dailyValuePre != -1 && dailyValuePre !=''){
// 				checkAsPreValue = true
// 			}
			arrNutriVOsPopup.push({
				nutrient:'${item.nutritionName}', 
				nutritionId:'${item.nutritionId}', 
				nutriQuantity:nutriQuantityPac, 
				nutriQuantityPre:nutriQuantityPre,
				servingSizeUOMCD:'${item.servingSizeUOMCD}', 
				sizeUomTxt: '${item.servingSizeUOMDesc}',
				servingSizeUOMCDPre:'${item.servingSizeUOMCDAsPre}', 
				sizeUomTxtPre: '${item.servingSizeUOMDescAsPre}',
				rowUni:${count.count},
				custom:custom,
				nutrientTypeTxt: '${item.nutritionName}',
				changed: true,
				isOrContainer: '${item.isOrContainer}',
				keyNutrition: ${count.count},
				dailyValuePac:dailyValuePac,
				dailyValuePre:dailyValuePre});
		</c:if>
		<c:if test="${item.isOrContainer eq 1}">
			isOrContainer += '${item.nutritionName}' + ", ";
			arrIsOrContainer.push({
				nutritionId:'${item.nutritionId}', 
				nutriQuantity:nutriQuantityPac, 
				nutriQuantityPre:nutriQuantityPre,
				servingSizeUOMCD:'${item.servingSizeUOMCD}', 
				sizeUomTxt: '${item.servingSizeUOMDesc}',
				servingSizeUOMCDPre:'${item.servingSizeUOMCDAsPre}', 
				sizeUomTxtPre: '${item.servingSizeUOMDescAsPre}',
				nutrientTypeTxt: '${item.nutritionName}',
				changed: true,
				isOrContainer: '${item.isOrContainer}',
				keyNutrition: ${count.count},
				dailyValuePac:dailyValuePac,
				dailyValuePre:dailyValuePre});
		</c:if>
	</c:forEach>
	YAHOO.util.Event.onDOMReady(function(){
		document.getElementById("nutritionPopupWrapper").style.display="none";
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("imgEditNutrition"), "click", calShowNutritionPopup);
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addNewNutriRow"), "click", addNutrienPop);
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("fillValueForNutriInfo"), "click", doFillValueForNutriInfo);
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("cancelNutriPopup"), "click", cancelNutriPopup);
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("imgEditNutriSizeUOM"), "click", showNutriUOMPopup);
		buildTableNutrient();
		if(${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.chBoxAsPre}) {
			document.getElementById('chBoxNotAsPre').checked = true;
		}else {
			document.getElementById('chBoxNotAsPre').checked = false;
		}
	});
	function addNutrienPop() {
		if(!validateDataGrid()) {
			return false;
		}
		document.getElementById('errorMsg').innerText = '';
		var dataSource = tableNutrtPop.getRecordSet();
		tableNutrtPop.addRow(buildDataNewRow(), dataSource.getLength());
		tableNutrtPop.refreshView();
		if(document.getElementById('chBoxAsPrePop').checked){
			setEditableForTextInput('yui-dt-col-nutriQuantityPre', false);
			setEditableForTextInput('yui-dt-col-dailyValuePre', false);
		}else {
			setEditableForTextInput('yui-dt-col-nutriQuantityPre', true);
			setEditableForTextInput('yui-dt-col-dailyValuePre', true);
				
		}
	}
	var buildDataNewRow = function () {
		var rowUni = 0;
		if(tableNutrtPop.getRecordSet().getLength() > 0){
			var oRec = tableNutrtPop.getRecordSet().getRecord(tableNutrtPop.getRecordSet().getLength()-1).getData();
			if(oRec != null && oRec["rowUni"] != null){
				rowUni = parseInt(oRec["rowUni"]);
			}
		}
		var rowDatas = new Object();
		rowDatas["nutritionId"] = "";
		rowDatas["nutrient"] = "";
		rowDatas["nutriQuantity"] = "";
		rowDatas["servingSizeUOMCD"] = "";
		rowDatas["sizeUomTxt"] = "";
		rowDatas["dailyValuePac"] = "";
		rowDatas["nutriQuantityPre"] = "";
		rowDatas["servingSizeUOMCDPre"] = "";
		rowDatas["sizeUomTxtPre"] = "";
		rowDatas["dailyValuePre"] = "";
		rowDatas["nutrientTypeTxt"] = "";
		rowDatas["isOrContainer"] = "0";
		rowDatas["rowUni"] = rowUni+1;
		rowDatas["keyNutrition"] = rowUni+1;
		rowDatas["custom"] = true;
		return rowDatas;
	};
	function validateDataGrid() {
		if (tableNutrtPop.getRecordSet().getLength()==0){
			return true;
		}
		var isOK = true;

		for (var i= 0; i< tableNutrtPop.getRecordSet().getLength();i++){
			var oReci = tableNutrtPop.getRecordSet().getRecord(i).getData();
			for (var j= i+1; j< tableNutrtPop.getRecordSet().getLength();j++){
				var oRecj = tableNutrtPop.getRecordSet().getRecord(j).getData();
				for(var keyRec in oReci) {
					if (keyRec=='nutritionId') {
						if (oReci[keyRec]== oRecj[keyRec]) {
							isOK = false;
							document.getElementById('errorMsg').innerText = 'Remove duplicate data.';
							break;
						}
					}
				}
			}
		}
		if (!isOK) return false;
		for (var i= 28; i< tableNutrtPop.getRecordSet().getLength();i++){
			var oRec = tableNutrtPop.getRecordSet().getRecord(i);
			for(var keyRec in oRec) {
				if(oRec.getData('nutritionId')!=''){
					if (arrIsOrContainer.length>0){
						for (var j=0;j<arrIsOrContainer.length;j++) {
							if (oRec.getData('nutritionId')==arrIsOrContainer[j].nutritionId) {
								isOK = false;
								document.getElementById('errorMsg').innerText = 'Remove duplicate data.';
								break;
							}
						}
					}
				}
			}
		}
		if (!isOK) return false;
		for (var i= 0; i< tableNutrtPop.getRecordSet().getLength();i++){
			var oRec = tableNutrtPop.getRecordSet().getRecord(i);
				if (isMandatory) {
					if(oRec.getData('custom')) {
						if(oRec.getData('nutritionId')==''){
							document.getElementById('errorMsg').innerText = 'Please enter mandatory data before adding next row.';
							return false;
						}
						if(oRec.getData('nutriQuantity')==''){
							document.getElementById('errorMsg').innerText = 'Please enter mandatory data before adding next row.';
							return false;
						}
						if(oRec.getData('nutriQuantityPre')==''){
							document.getElementById('errorMsg').innerText = 'Please enter mandatory data before adding next row.';
							return false;
						}					
						if(oRec.getData('custom') == true && oRec.getData('servingSizeUOMCD')==''){
							document.getElementById('errorMsg').innerText = 'Please enter mandatory data before adding next row.';
							return false;
						}
						if(oRec.getData('custom') == true && oRec.getData('servingSizeUOMCDPre')==''){
							document.getElementById('errorMsg').innerText = 'Please enter mandatory data before adding next row.';
							return false;
						}
					}else {
						if(oRec.getData('nutriQuantity')!='' || oRec.getData('nutriQuantityPre')!='' 
								|| (oRec.getData('dailyValuePac')!='' && (oRec.getData('dailyValuePac')!=-1 || oRec.getData('dailyValuePac')!="-1")) 
								|| (oRec.getData('dailyValuePre')!='' && (oRec.getData('dailyValuePre')!=-1 || oRec.getData('dailyValuePre')!="-1"))){
							if(oRec.getData('nutriQuantity') !=-1 && oRec.getData('nutriQuantity') ==''){
								document.getElementById('errorMsg').innerText = 'Please enter mandatory data before adding next row.';
								return false;
							}
							if(document.getElementById('chBoxAsPrePop').checked && oRec.getData('nutriQuantityPre') !=-1 && oRec.getData('nutriQuantityPre') ==''){
								document.getElementById('errorMsg').innerText = 'Please enter mandatory data before adding next row.';
								return false;
							}
						}
					}
				} else {
					if(oRec.getData('custom')){
						if(oRec.getData('nutritionId')=='' 
							&& oRec.getData('nutriQuantity')==''
							&& oRec.getData('servingSizeUOMCD')==''
							&& oRec.getData('nutriQuantityPre')==''
							&& oRec.getData('servingSizeUOMCDPre')==''
							&& oRec.getData('dailyValuePre')==''
							&& oRec.getData('dailyValuePac')=='') {
							document.getElementById('errorMsg').innerText = 'Please enter one field at least for existing row.';
							return false;
						}
					}					
				}
		}
		return isOK;
	}
	function validateDuplicateRecord() {
		var check = false;
		if(tableNutrtPop.getRecordSet().getLength() > 28){//28 is number of static attribute
			for (var i = 28; i< tableNutrtPop.getRecordSet().getLength();i++){
				var oReci = tableNutrtPop.getRecordSet().getRecord(i).getData();
				for (var j= i+1; j< tableNutrtPop.getRecordSet().getLength();j++){
					var oRecj = tableNutrtPop.getRecordSet().getRecord(j).getData();
					var checkRecord = true;
					for(var keyRec in oReci) {
						if(keyRec == "nutritionId" && keyRec == "nutriQuantity" && keyRec == "servingSizeUOMCD" && keyRec == "dailyValuePac" && 
								keyRec == "nutriQuantityPre" && keyRec == "servingSizeUOMCDPre" && keyRec == "dailyValuePre") {
							if(oReci[keyRec] != oRecj[keyRec]){
								checkRecord = false;
								break;
							}
						}
					}
					if(checkRecord){
						check = true
						break;
					}
				}
				if(check){
					break;
				}
			}
		}
		return check;
	}
// 	function okNutrientPop() {
// 		var rowDatas = []; 
// 		for (var i= 0; i< tableNutrtPop.getRecordSet().getLength();i++){
// 			var oRec = tableNutrtPop.getRecordSet().getRecord(i);
// 			var oRecDta =  oRec.getData();
// 			rowDatas.push(oRec.getData());
// 		}
// 		tableNutrt.getDataSource().liveData = rowDatas;			
// 		tableNutrt.getDataSource().sendRequest(null, {success: tableNutrt.onDataReturnInitializeTable},tableNutrt);
// 		myPaneltableNutrt.hide();
// 	}
	function doFillValueForNutriInfo() {
		isPopupShowed = false;
		var radioObj = document.getElementsByName("radioSrcOpt");
		var radioVal = getCheckedRadioVal(radioObj);
		if (radioVal=='4') {
			isEditing = true;
			if(!validateDataGrid()) {
				return false;
			}
			// hide prod val des
// 			document.getElementById("prodValDes").style.display = "none";
		} 
		document.getElementById('errorMsg').innerText = '';
// 		document.getElementById("spanPreState").innerText= document.getElementById('txtPreState').value;
		document.getElementById("spanSize").innerText= document.getElementById('txtServingSize').value;
		document.getElementById("spanSizeUOM").innerText= document.getElementById('txtSizeUOM').value;
		document.getElementById("spanHouseHold").innerText= document.getElementById('txtHouseSize').value;
		var iSCont='';
		iSCont = document.getElementById("isContainsPopup").innerHTML;
		if(iSCont != null && iSCont.length > 0){
			document.getElementById("isOrcontainerWrapper").style.display = "inline";
			document.getElementById("isOrcontainer").innerHTML = iSCont;
		} else {
			document.getElementById("isOrcontainerWrapper").style.display = "none";
			document.getElementById("isOrcontainer").innerHTML ="";
		}
// 		set data for val Des
		document.getElementById("prodValDes").value = document.getElementById("prodValDesPopup").value;
		document.getElementById('chBoxNotAsPre').checked = document.getElementById('chBoxAsPrePop').checked;
		var newArrInfo = new Array();
		newArrInfoTmp = new Array();
		var rowDatas = []; 
		for (var i= 0; i < tableNutrtPop.getRecordSet().getLength(); i++){
			var oRec = tableNutrtPop.getRecordSet().getRecord(i);
			newArrInfo.push(oRec);
			rowDatas.push(oRec.getData());
			newArrInfoTmp.push(oRec.getData());
	 	}
		tableNutrt.getDataSource().liveData = rowDatas;			
		tableNutrt.refreshView();
		tableNutrt.getDataSource().sendRequest(null, {success: tableNutrt.onDataReturnInitializeTable},tableNutrt);
		document.getElementById("hiddenServingSize").value=document.getElementById('txtServingSize').value;
		document.getElementById("hiddenUOM").value=sizeUOMCD;
		document.getElementById("hiddenUOMDesc").value= document.getElementById('txtSizeUOM').value;	
		document.getElementById("hiddenHoldHouse").value=document.getElementById('txtHouseSize').value;
		document.getElementById("hiddenProdValDes").value= document.getElementById('prodValDes').value;
		if (newArrISorCont.length>0){
			for (var i=0;i<newArrISorCont.length;i++) {
				rowDatas.push(newArrISorCont[i]);
			}
		}
		document.getElementById("hiddenJSONNutriDataGrid").value = YAHOO.lang.JSON.stringify(rowDatas);  
// 		var sourceRadio = document.getElementsByName('radioSrcOpt');
		for(var i = 0; i < radioObj.length; i++){
		    if(radioObj[i].checked){
		    	document.getElementById("hiddenSrcSystem").value = radioObj[i].value;
		    	break;
		    }
		}
		myPaneltableNutrt.hide();
		if(radioVal=='7'){
			YAHOO.util.Dom.setStyle(YAHOO.util.Dom.getElementsByClassName('isHidden', 'div'), 'display', 'none');
		}
	}

	function buildTableNutrient() {
		var dsLocalJSON = new YAHOO.util.LocalDataSource(arrNutriVOsPopup);
		tableNutrt = new  YAHOO.widget.ScrollingDataTable("tableNutrientView", columnDefsTemp, dsLocalJSON,{width:widthTable});
// 		tableNutrt.showTableMessage("");
		tableNutrt.subscribe("rowMouseoverEvent", tableNutrt.onEventHighlightRow);
		tableNutrt.subscribe("rowMouseoutEvent", tableNutrt.onEventUnhighlightRow);
		tableNutrt.subscribe("rowClickEvent", tableNutrt.onEventSelectRow);
//         table${compId}.render();
	}
	function showNutritionPopup(){
		document.getElementById("nutritionPopupWrapper").style.display="inline";
		myPaneltableNutrt = new YAHOO.widget.Panel("nutritionPopupWrapper",
		{ 	width:"950px",
			height:"550px",
			underlay:"shadow",
			visible:false,
			constraintoviewport:true,
			draggable:false,
			zIndex : 15000,
			modal:true,
			close:true,
			fixedCenter : true
		} );
		myPaneltableNutrt.render(document.body);
		document.getElementById('errorMsg').innerText = '';
		myPaneltableNutrt.show();
		document.getElementById('chBoxAsPrePop').checked = document.getElementById('chBoxNotAsPre').checked;
		showDataForFirstTime(false);
		if(srcSysID != '4'){
			getDataBySourceId(srcSysID);
		}else {
			if(document.getElementById('chBoxAsPrePop').checked == false){
				setEditableForTextInput('yui-dt-col-nutriQuantityPre', true);
				setEditableForTextInput('yui-dt-col-dailyValuePre', true);
				document.getElementById("prodValDesPopup").disabled = true; 
			}
			document.getElementById('txtServingSize').value = document.getElementById("spanSize").innerText;
			document.getElementById('txtSizeUOM').value =  document.getElementById("spanSizeUOM").innerText
			document.getElementById('txtHouseSize').value = document.getElementById("spanHouseHold").innerText
		}
	}
	function getDataBySourceId(source) {
		document.getElementById('errorMsg').innerText = '';
		document.getElementById("isContainsPopupWrapper").style.display = "none";
// 		document.getElementById("prodValDesPopup").style.display = "none";
		srcSysID = source;
		if (source=='4' && (source==srcSysIdOrigin || isEditing)) {
// 			fnInitialPopUp(columnDefsPop);
// 			fillDataForDatagridPopup(false);
			tableNutrtPop.getRecordSet().reset();
			tableNutrtPop.getRecordSet().setRecords(arrNutriVOsPopup);
			tableNutrtPop.refreshView();
			if(${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.chBoxAsPre}) {
				document.getElementById('chBoxAsPrePop').checked = true;
			}else {
				document.getElementById('chBoxAsPrePop').checked = false;
			}
			showDataForFirstTime(false);
		} else {
			showProgress();
			AddCandidateTemp.getNutritionInfoBySrcSysId(source, "${CPSForm.productVO.upcImageAndAttr}", showNutritionInfo);
		}		
	}
	function fnInitialPopUp(dataListAttr) {
		// Create the DataTable.
		tableNutrtPop = new  YAHOO.widget.ScrollingDataTable("popupNutriDatadrid", columnDefsPop,
				tableNutrt.getDataSource(),{width:"900px"});
        tableNutrtPop.subscribe("rowMouseoverEvent", tableNutrtPop.onEventHighlightRow);
        tableNutrtPop.subscribe("rowMouseoutEvent", tableNutrtPop.onEventUnhighlightRow);
        tableNutrtPop.subscribe("rowClickEvent", tableNutrtPop.onEventSelectRow);
        tableNutrtPop.subscribe("postRenderEvent", function(){
    		for (var i= 28; i< tableNutrtPop.getRecordSet().getLength();i++){
    			var oRec = tableNutrtPop.getRecord(i);   			
    			setZindex(oRec.getData('keyNutrition'),i%tableNutrtPop.getRecordSet().getLength(),tableNutrtPop.getRecordSet().getLength());      	
    		    //document.getElementById("myAutoComplete"+oRec.getData("keyNutrition")).parentNode.parentNode.parentNode.style.overflow = 'visible';
    		    setAutoComplete(oRec.getData('keyNutrition'));
    		    setZindexQuantityUom(oRec.getData('keyNutrition'),i%tableNutrtPop.getRecordSet().getLength(),tableNutrtPop.getRecordSet().getLength());      	
    		    document.getElementById("myAutoCompleteQuantityUom"+oRec.getData("keyNutrition")).parentNode.parentNode.parentNode.style.overflow = 'visible';
    		    setAutoCompleteQuantityUom(oRec.getData('keyNutrition'));
    		    //myAutocompleteMeasurementPrecision
//     		    setZindexMeasurementPrecision(oRec.getData('keyNutrition'),i%tableNutrtPop.getRecordSet().getLength(),tableNutrtPop.getRecordSet().getLength());      	
//     		    document.getElementById("myAutocompleteMeasurementPrecision"+oRec.getData("keyNutrition")).parentNode.parentNode.parentNode.style.overflow = 'visible';
//     		    setAutoCompleteMeasurementPrecision(oRec.getData('keyNutrition'));
    		}			 			
    	});
        document.getElementById("prodValDesPopup").value = document.getElementById("prodValDes").value;
	}
	function calShowNutritionPopup(){
		<c:if test="${CPSForm.viewModeImageAttr == false}">
			fnInitialPopUp(columnDefsPop);
			showNutritionPopup();
			myPaneltableNutrt.show();
		</c:if>
	}
	function cancelNutriPopup() {
		isPopupShowed = false;
		myPaneltableNutrt.hide();
		srcSysID = srcSysIdOrigin;
		if (isEditing) {
			srcSysID='4';
		}
		AddCandidateTemp.revertToNutriInforOrigin();
	}
	function setZindex(id,position,totalInPage)
	{		
		if(document.getElementById("myAutoComplete"+id)!=null)
		{		
			if(document.getElementById("myAutoComplete"+id).parentNode!=null)
			{
				document.getElementById("myAutoComplete"+id).parentNode.style.zIndex=15000+(totalInPage-position)*100;
				document.getElementById("myAutoComplete"+id).parentNode.style.overflow = 'visible';
			}	
			document.getElementById("myAutoComplete"+id).style.zIndex=10000+(totalInPage-position)*100;						
			if(document.getElementById("myContainer"+id))
			{							
				document.getElementById('popupNutriDatadrid').style.zIndex=2;
				document.getElementById("myContainer"+id).style.zIndex=1;	
			}
								
		}
	};
	function setZindexQuantityUom(id,position,totalInPage)
	{		
		if(document.getElementById("myAutoCompleteQuantityUom"+id)!=null)
		{		
			if(document.getElementById("myAutoCompleteQuantityUom"+id).parentNode!=null)
			{
				document.getElementById("myAutoCompleteQuantityUom"+id).parentNode.style.zIndex=15000+(totalInPage-position)*100;
				document.getElementById("myAutoCompleteQuantityUom"+id).parentNode.style.overflow = 'visible';
			}	
			document.getElementById("myAutoCompleteQuantityUom"+id).style.zIndex=10000+(totalInPage-position)*100;						
			if(document.getElementById("myContainerQuantityUom"+id))
			{							
				document.getElementById('popupNutriDatadrid').style.zIndex=2;
				document.getElementById("myContainerQuantityUom"+id).style.zIndex=1;	
			}
								
		}
	};
	function setZindexMeasurementPrecision(id,position,totalInPage)
	{		
		if(document.getElementById("myAutocompleteMeasurementPrecision"+id)!=null)
		{		
			if(document.getElementById("myAutocompleteMeasurementPrecision"+id).parentNode!=null)
			{
				document.getElementById("myAutocompleteMeasurementPrecision"+id).parentNode.style.zIndex=15000+(totalInPage-position)*100;
				document.getElementById("myAutocompleteMeasurementPrecision"+id).parentNode.style.overflow = 'visible';
			}	
			document.getElementById("myAutocompleteMeasurementPrecision"+id).style.zIndex=10000+(totalInPage-position)*100;						
			if(document.getElementById("myContainerMeasurementPrecision"+id))
			{							
				document.getElementById('popupNutriDatadrid').style.zIndex=2;
				document.getElementById("myContainerMeasurementPrecision"+id).style.zIndex=1;	
			}
								
		}
	};
	getNutriTypeList = function(query)
	{	
		var reslts = [];	
		if(query == 'xxxxx'){
			reslts = lstNutriType.slice(0, 999); 
		}else {
// 			if(query!=''){
				query = query.ReplaceAll('%20',' ');
				query = query.ReplaceAll('%25','%');
// 			}	
			for (var i = 0; i < lstNutriType.length; i++) {    	
			    var t1 = lstNutriType[i].value;
			    var t2 = query;
			    var t1Up = decodeHTMLEntity(t1.toUpperCase());
			    var t2Up = t2.toUpperCase();	   
			    //var v1 = lstNutriType[i].id;
			   // var v1Up = v1.toUpperCase();	    
		    	if (t1Up.indexOf(t2Up)>=0) {
		    		reslts.push(lstNutriType[i]);
		    	}    	
		    }
// 		    if(query != ''){
				reslts.sort(function(a, b){
					 var t2Up = query.toUpperCase();
					 var nameA = a.value.toUpperCase(), nameB=b.value.toUpperCase();
					 if (nameA.indexOf(t2Up) < nameB.indexOf(t2Up)) //sort string ascending
					  	return -1;
					 if (nameA.indexOf(t2Up) > nameB.indexOf(t2Up))
					  	return 1;
					 return 0 ;//default return value (no sorting)
					});
// 			}
		}
	    return reslts;
	};
	getUomList = function(query)
	{	
		reslts = [];
		if(query!=''){
			query = query.trim();
			query = query.ReplaceAll('%20',' ');
			query = query.ReplaceAll('%25','%');
		}
		for (var i = 0; i < lstQuantityUOM.length; i++) {    	
		    var t1 = lstQuantityUOM[i].value;
		    var t2 = query;
		    var t1Up = decodeHTMLEntity(t1.toUpperCase());
		    var t2Up = t2.toUpperCase();
		   // var v1 = lstQuantityUOM[i].id;
		   // var v1Up = v1.toUpperCase();	    
	    	if (t1Up.indexOf(t2Up)>=0) {
	    		reslts.push(lstQuantityUOM[i]);
	    	}    	
	    }
	    if(query != ''){
			reslts.sort(function(a, b){
				 var t2Up = query.toUpperCase();
				 var nameA = a.value.toUpperCase(), nameB=b.value.toUpperCase();
				 if (nameA.indexOf(t2Up) < nameB.indexOf(t2Up)) //sort string ascending
				  	return -1;
				 if (nameA.indexOf(t2Up) > nameB.indexOf(t2Up))
				  	return 1;
				 return 0; //default return value (no sorting)
				});
		}
	    return reslts;
	};
	function setAutoComplete(id) { 	
			var oACDS = new YAHOO.widget.DS_JSFunction(getNutriTypeList);
		    // Instantiate first AutoComplete
		    var oAutoComp = new YAHOO.widget.AutoComplete("myInput"+id, "myContainer"+id, oACDS);
		    oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
		   // this.oAutoComp.typeAhead = true;
			oAutoComp.queryQuestionMark = false;
			oAutoComp.forceSelection = false;
			oAutoComp.autoHighlight = true;
			oAutoComp.maxResultsDisplayed = 50;
			oAutoComp.resultTypeList = false;
			oAutoComp.useIFrame = true;
			oAutoComp.minQueryLength=3;	
			oAutoComp.queryDelay = 0.7;
			oAutoComp.formatResult = function(oResultItem, sQuery) {
		        var sMarkup = oResultItem.value;
		        return (sMarkup);
		    };
			oAutoComp.doBeforeExpandContainer = function() {
				var Dom = YAHOO.util.Dom;
				Dom.setXY("myContainer"+id, [Dom.getX("myInput"+id), Dom.getY("myInput"+id) + Dom.get("myInput"+id).offsetHeight] );
				return true;
			}	
			var itemSelectHandler = function(sType, aArgs) {
				var aData = aArgs[2]; //array of the data for the item as returned by the DataSource	
				for (var i= 28; i< tableNutrtPop.getRecordSet().getLength();i++){		
					var oRec = tableNutrtPop.getRecord(i);  		
					if(oRec.getData('keyNutrition')==id){							
						oRec.setData('nutritionId',aData.id);
						oRec.setData('nutrientTypeTxt',aData.value);		
						oRec.setData('nutrient',aData.value);
					}
				}			
				tableNutrtPop.refreshView();
				if(document.getElementById('chBoxAsPrePop').checked){
					setEditableForTextInput('yui-dt-col-nutriQuantityPre', false);
					setEditableForTextInput('yui-dt-col-dailyValuePre', false);
				}else {
					setEditableForTextInput('yui-dt-col-nutriQuantityPre', true);
					setEditableForTextInput('yui-dt-col-dailyValuePre', true);
						
				}
			}
			oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
			oAutoComp.textboxKeyEvent.subscribe(
				function(nKeycode){
		        	var oSelf = this;
					oSelf.forceSelection = false;
				});
			oAutoComp.textboxChangeEvent.subscribe(
					function(){
						var oSelf = this;
						var data = oSelf.getSubsetMatches(oSelf.getInputEl().value);
						if(!data){
							oSelf.getInputEl().value = "";
							for (var i= 28; i< tableNutrtPop.getRecordSet().getLength();i++){		
								var oRec = tableNutrtPop.getRecord(i);
								if(oRec.getData('keyNutrition')==id){							
									oRec.setData('nutritionId',"");
									oRec.setData('nutrientTypeTxt',"");
									oRec.setData('nutrient',"");
									break;
								}
							}
						}
					});
			oAutoComp.textboxFocusEvent.subscribe(
					function(){
						var oSelf = this;
						oSelf.forceSelection = false;
		 	});		
		 	var temp = oAutoComp;
			var sendEmptyQuery = function(t1, t2) {	
				document.getElementById("myContainer"+id).style.display = '';		
		        setTimeout(function() {t2.sendQuery("xxxxx");}, 0);
		        document.getElementById("myInput"+id).focus();
			};
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("image"+id), "click", sendEmptyQuery,temp); 
	};
	function setAutoCompleteQuantityUom(id) { 	
		var oACDS = new YAHOO.widget.DS_JSFunction(getUomList);
	    // Instantiate first AutoComplete
	    var oAutoComp = new YAHOO.widget.AutoComplete("myInputQuantityUom"+id, "myContainerQuantityUom"+id, oACDS);
	    oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
	   // this.oAutoComp.typeAhead = true;
		oAutoComp.queryQuestionMark = false;
		oAutoComp.forceSelection = false;
		oAutoComp.autoHighlight = true;
		oAutoComp.maxResultsDisplayed = 50;
		oAutoComp.resultTypeList = false;
		oAutoComp.useIFrame = true;
		oAutoComp.minQueryLength=0;	
		oAutoComp.formatResult = function(oResultItem, sQuery) {
	        var sMarkup = oResultItem.value;
	        return (sMarkup);
	    };
		oAutoComp.doBeforeExpandContainer = function() {
			var Dom = YAHOO.util.Dom;
			Dom.setXY("myContainerQuantityUom"+id, [Dom.getX("myInputQuantityUom"+id), Dom.getY("myInputQuantityUom"+id) + Dom.get("myInputQuantityUom"+id).offsetHeight] );
			return true;
		}
		var itemSelectHandler = function(sType, aArgs) {
			var aData = aArgs[2]; //array of the data for the item as returned by the DataSource	
			for (var i= 0; i< tableNutrtPop.getRecordSet().getLength();i++){		
				var oRec = tableNutrtPop.getRecord(i);  		
				if(oRec.getData('keyNutrition')==id){					
					oRec.setData('servingSizeUOMCD',aData.id);
					oRec.setData('sizeUomTxt',aData.value);
					if(oRec.getData('nutriQuantityPre')!=''){
						oRec.setData('servingSizeUOMCDPre',aData.id);
						oRec.setData('sizeUomTxtPre',aData.value);		
					}
				}
			}			
			tableNutrtPop.refreshView();
			if(document.getElementById('chBoxAsPrePop').checked){
				setEditableForTextInput('yui-dt-col-nutriQuantityPre', false);
				setEditableForTextInput('yui-dt-col-dailyValuePre', false);
			}else {
				setEditableForTextInput('yui-dt-col-nutriQuantityPre', true);
				setEditableForTextInput('yui-dt-col-dailyValuePre', true);
					
			}
		}
		
		oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
		
		oAutoComp.textboxChangeEvent.subscribe(
				function(){
					var oSelf = this;
					var data = oSelf.getSubsetMatches(oSelf.getInputEl().value);
					if(!data){
						oSelf.getInputEl().value = "";
						for (var i= 0; i< tableNutrtPop.getRecordSet().getLength();i++){		
							var oRec = tableNutrtPop.getRecord(i);
							if(oRec.getData('keyNutrition')==id){							
								oRec.setData('servingSizeUOMCD',"");
								oRec.setData('sizeUomTxt',"");
								break;
							}
						}
					}
				});
		
		oAutoComp.textboxKeyEvent.subscribe(
			function(nKeycode){
	        	var oSelf = this;
				//oSelf.forceSelection = false;
			});

		oAutoComp.textboxFocusEvent.subscribe(
				function(){
					var oSelf = this;
					//oSelf.forceSelection = false;
	 });
		var temp = oAutoComp;
		var sendEmptyQuery = function(t1, t2) {		
	        setTimeout(function() {t2.sendQuery("");}, 0);
	        document.getElementById('myInputQuantityUom'+id).focus();
		};		
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get('imageQuantityUom'+id), "click", sendEmptyQuery,temp); 	
	};
	function setAutoCompleteMeasurementPrecision(id) { 	
		//var oACDS = new YAHOO.widget.DS_JSFunction(getUomList);
		var oACDS = new YAHOO.util.LocalDataSource(["","APPROXIMATELY","EXACT","LESS_THAN"]);
	    // Instantiate first AutoComplete
	    var oAutoComp = new YAHOO.widget.AutoComplete("myInputMeasurementPrecision"+id, "myContainerMeasurementPrecision"+id, oACDS);
	    oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
	   // this.oAutoComp.typeAhead = true;
		oAutoComp.queryQuestionMark = false;
		oAutoComp.forceSelection = false;
		oAutoComp.autoHighlight = true;
		oAutoComp.maxResultsDisplayed = 50;
		oAutoComp.resultTypeList = false;
		oAutoComp.useIFrame = true;
		oAutoComp.minQueryLength=0;	
		/* oAutoComp.formatResult = function(oResultItem, sQuery) {
	        var sMarkup = oResultItem.value;
	        return (sMarkup);
	    }; */
		oAutoComp.doBeforeExpandContainer = function() {
			var Dom = YAHOO.util.Dom;
			Dom.setXY("myContainerMeasurementPrecision"+id, [Dom.getX("myInputMeasurementPrecision"+id), Dom.getY("myInputMeasurementPrecision"+id) + Dom.get("myInputMeasurementPrecision"+id).offsetHeight] );
			return true;
		}
		var itemSelectHandler = function(sType, aArgs) {
			var aData = aArgs[2]; //array of the data for the item as returned by the DataSource	
			for (var i= 0; i< tableNutrtPop.getRecordSet().getLength();i++){		
				var oRec = tableNutrtPop.getRecord(i);  		
				if(oRec.getData('keyNutrition')==id){
					oRec.setData('nutritionMeasr',aData);			
				}
			}			
			tableNutrtPop.refreshView();
			if(document.getElementById('chBoxAsPrePop').checked){
				setEditableForTextInput('yui-dt-col-nutriQuantityPre', false);
				setEditableForTextInput('yui-dt-col-dailyValuePre', false);
			}else {
				setEditableForTextInput('yui-dt-col-nutriQuantityPre', true);
				setEditableForTextInput('yui-dt-col-dailyValuePre', true);
					
			}
		}
		
		oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
		
		oAutoComp.textboxChangeEvent.subscribe(
				function(){
					var oSelf = this;
					var data = oSelf.getSubsetMatches(oSelf.getInputEl().value);
					if(!data){
						oSelf.getInputEl().value = "";
						for (var i= 0; i< tableNutrtPop.getRecordSet().getLength();i++){		
							var oRec = tableNutrtPop.getRecord(i);
							if(oRec.getData('keyNutrition')==id){							
								oRec.setData('nutritionMeasr',"");
								break;
							}
						}
					}
				});
		
		oAutoComp.textboxKeyEvent.subscribe(
			function(nKeycode){
	        	var oSelf = this;
				//oSelf.forceSelection = false;
			});

		oAutoComp.textboxFocusEvent.subscribe(
				function(){
					var oSelf = this;
					//oSelf.forceSelection = false;
	 });
		var temp = oAutoComp;
		var sendEmptyQuery = function(t1, t2) {		
	        setTimeout(function() {t2.sendQuery("");}, 0);
	        document.getElementById('myInputMeasurementPrecision'+id).focus();
		};	 	
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get('imageMeasurementPrecision'+id), "click", sendEmptyQuery,temp); 	
	};
	function decodeHTMLEntity(str) {
		return str.replace(/&#(\d+);/g, function(match, dec) {
			return String.fromCharCode(dec);
		});
	}
	String.prototype.ReplaceAll = function(stringToFind,stringToReplace){
	    var temp = this;
	    var index = temp.indexOf(stringToFind);
	        while(index != -1){
	            temp = temp.replace(stringToFind,stringToReplace);
	            index = temp.indexOf(stringToFind);
	        }
	     return temp;
	    }
	    
	function decodeHtml(s) {
		var str, temp= document.createElement('p');
	    temp.innerHTML= s;
	    str= temp.textContent || temp.innerText;
	    temp=null;
	    return str;

	}
	/* Get nutrition info by source system id*/
	function getNutritionInfoBySrcSysId(srcSysId, upc) {
		AddCandidateTemp.getNutritionInfoBySrcSysId(srcSysId, upc, showNutritionInfo);
	} 
	/* show nutrition information */
	function showNutritionInfo(data) {
		var msgData = data.messages;
		if(!msgData.exception){
			if(data.appData!=null && !data.appData.message){
//	 			setSelectedOption();
				fillDataForBasicInfo(data);
				fillDataForDataGrid(data);
				setViewAndEditable();
			}else{
// 				alert(data.appData.message);
				alert("Connection is down");
			}
		}else{
// 			alert(msgData.exception);
			alert("Connection is down");
		}
// 		YAHOO.heb.imageAttribute.nutritionPopup.show();
		hideProgress();
	}
	function fillDataForDataGrid(data) {
		arrNutriVOPopup = new Array();
		newArrISorCont = new Array();
		document.getElementById("isContainsPopup").innerHTML = "";
		document.getElementById("isContainsPopupWrapper").style.display = "none";
		if (data.appData.lstNutriDatagrid!=null && data.appData.lstNutriDatagrid.length>0) {
			var nutriTypeCDTxt = "";
			var sizeUomTxt= "";
			var isContainsPopup = "";
			for (var i=0; i < data.appData.lstNutriDatagrid.length; i++) {
				var dailyValuePac  = getTrimmedValue(data.appData.lstNutriDatagrid[i].dailyValue);
				var dailyValuePre  = getTrimmedValue(data.appData.lstNutriDatagrid[i].dailyValueAsPre);
				var nutriQuantityPac = getTrimmedValue(data.appData.lstNutriDatagrid[i].nutriQuantity);
				var nutriQuantityPre = getTrimmedValue(data.appData.lstNutriDatagrid[i].nutriQuantityPre);
				if (data.appData.lstNutriDatagrid[i].isOrContainer == 1) {
					isContainsPopup += data.appData.lstNutriDatagrid[i].nutritionName + ", ";
					newArrISorCont.push({
						nutritionId:data.appData.lstNutriDatagrid[i].nutritionId, 
						nutriQuantity:nutriQuantityPac, 
						nutriQuantityPre:nutriQuantityPre,
						servingSizeUOMCD:getTrimmedValue(data.appData.lstNutriDatagrid[i].servingSizeUOMCD), 
						sizeUomTxt: getTrimmedValue(data.appData.lstNutriDatagrid[i].servingSizeUOMDesc),
						servingSizeUOMCDPre:getTrimmedValue(data.appData.lstNutriDatagrid[i].servingSizeUOMCDAsPre), 
						sizeUomTxtPre: getTrimmedValue(data.appData.lstNutriDatagrid[i].servingSizeUOMDescAsPre),
						nutrientTypeTxt: getTrimmedValue(data.appData.lstNutriDatagrid[i].nutritionName),
						changed: true,
						isOrContainer: data.appData.lstNutriDatagrid[i].isOrContainer,
						dailyValuePac:dailyValuePac,
						dailyValuePre:dailyValuePre});
				} else {
					var count = i+1;
					var custom = false;
					if(count == 1 || count == 2 || count == 5 || count == 6 || count == 7
							|| count == 13 || count == 14){
						if(!(data.appData.lstNutriDatagrid[i].nutritionId == 1)){
							dailyValuePac = -1;
						}
// 						dailyValuePac = -1;
						dailyValuePre = -1;
					}
					if(count > 14 && count < 29){
						nutriQuantityPac = -1;
						nutriQuantityPre = -1;
					}
					if(count > 28){
						custom = true;
					}
					arrNutriVOPopup.push({
						nutrient:getTrimmedValue(data.appData.lstNutriDatagrid[i].nutritionName), 
						nutritionId:data.appData.lstNutriDatagrid[i].nutritionId, 
						nutriQuantity:nutriQuantityPac, 
						nutriQuantityPre:nutriQuantityPre,
						servingSizeUOMCD:getTrimmedValue(data.appData.lstNutriDatagrid[i].servingSizeUOMCD), 
						sizeUomTxt: getTrimmedValue(data.appData.lstNutriDatagrid[i].servingSizeUOMDesc),
						servingSizeUOMCDPre:getTrimmedValue(data.appData.lstNutriDatagrid[i].servingSizeUOMCDAsPre), 
						sizeUomTxtPre: getTrimmedValue(data.appData.lstNutriDatagrid[i].servingSizeUOMDescAsPre),
						rowUni:count,
						custom:custom,
						nutrientTypeTxt: getTrimmedValue(data.appData.lstNutriDatagrid[i].nutritionName),
						changed: true,
						isOrContainer: data.appData.lstNutriDatagrid[i].isOrContainer,
						keyNutrition: count,
						dailyValuePac:dailyValuePac,
						dailyValuePre:dailyValuePre});
				}
				
			}
			if (isContainsPopup.length>1) {
				document.getElementById("isContainsPopupWrapper").style.display = "inline";
				document.getElementById("isContainsPopup").innerHTML = isContainsPopup.slice(0, isContainsPopup.length -2);
			}
		}
		tableNutrtPop.getRecordSet().reset();
		tableNutrtPop.getRecordSet().setRecords(arrNutriVOPopup);
		tableNutrtPop.refreshView();
	}
	function fillDataForBasicInfo(data) {
		if (data.appData.nutriBasicInfoVO!=null) {
// 			document.getElementById('txtPreState').value = getTrimmedValue(data.appData.nutriBasicInfoVO.preState);
			document.getElementById('txtServingSize').value = getTrimmedValue(data.appData.nutriBasicInfoVO.servingSize);
			sizeUOMCD = getTrimmedValue(data.appData.nutriBasicInfoVO.servingSizeUOMCD);
			document.getElementById('txtSizeUOM').value = decodeHtml(getTrimmedValue(data.appData.nutriBasicInfoVO.servingSizeUOMDesc));
			document.getElementById('txtHouseSize').value = decodeHtml(getTrimmedValue(data.appData.nutriBasicInfoVO.houseHoldSize));
// 			document.getElementById('txtFatContent').value = getTrimmedValue(data.appData.nutriBasicInfoVO.fatMilkContent);
// 			document.getElementById('txtDailyRef').value = getTrimmedValue(data.appData.nutriBasicInfoVO.dailyIntakeRef);
// 			if (srcSysID=='7') {
				document.getElementById("prodValDesPopup").value = getTrimmedValue(data.appData.nutriBasicInfoVO.prodValDes);
// 				document.getElementById("prodValDesPopup").style.display = "inline";
// 			} else {
// 				document.getElementById("prodValDesPopup").style.display = "none";
// 			}
			if(data.appData.nutriBasicInfoVO.chBoxAsPre){
				document.getElementById('chBoxAsPrePop').checked = true;
			}else {
				document.getElementById('chBoxAsPrePop').checked = false;
			}
		}
	}
	function setSelectedOption() {
		var sourceRadio = document.getElementsByName('radioSrcOpt');
		setSelectedSourceOption(sourceRadio);
	}
	function setSelectedSourceOption(radioObj) {
		for(var i = 0; i < radioObj.length; i++){
		    if(radioObj[i].value == srcSysID){
		    	radioObj[i].checked = true;
		    	break;
		    }
		}
	}
	function showDataForFirstTime(isEditBtnClicked) {
// 		document.getElementById("prodValDesPopup").style.display = "none";
		document.getElementById("isContainsPopupWrapper").style.display = "none";
		if (isEditBtnClicked) {
			document.getElementById("radioSrc4").checked= true;
		} else {
			setSelectedOption();
		}
		if (isEditing) {
			if (isOrContainer.length>1 && (document.getElementById("radioSrc4").value==srcSysIdOrigin || srcSysID==srcSysIdOrigin)) {
				document.getElementById("isContainsPopupWrapper").style.display = "inline";
				document.getElementById("isContainsPopup").innerHTML = isOrContainer.slice(0, isOrContainer.length -2);
			}
		} else {
			setSelectedOption();
// 			if (srcSysIdOrigin=='7') {
// 				document.getElementById("prodValDesPopup").style.display = "inline";
				document.getElementById("prodValDesPopup").value = document.getElementById("prodValDes").value;
// 			} else {
// 			}
			if (srcSysID==srcSysIdOrigin) {
				if (isOrContainer.length>1) {
					document.getElementById("isContainsPopupWrapper").style.display = "inline";
					document.getElementById("isContainsPopup").innerHTML = isOrContainer.slice(0, isOrContainer.length -2);
				}
			}
		}
		fillDataForPopupInput(isEditBtnClicked);
// 		fillDataForDatagridPopup(isEditBtnClicked);
		setViewAndEditable();
		hideProgress();
// 		YAHOO.heb.imageAttribute.nutritionPopup.show();
	}
// 	tableNutrtPop.subscribe("renderEvent", function () {
// 		addEventListenerForInputDatagrid();
// 	});
	function setViewAndEditable() {
		var radioObj = document.getElementsByName("radioSrcOpt");
		var radioVal = getCheckedRadioVal(radioObj);
		doSetViewAndEditable(radioVal);
	}
	function validNumPress(evt){
		var charCode = (evt.which) ? evt.which : event.keyCode;
		var target = evt.target || evt.srcElement; 
		if(charCode == 8) return true;
		if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
	    	return false;
		var indexOfDot = target.value.indexOf('.');
		var check = indexOfDot != -1;
	 	if(check && charCode == 46){
	 		return false;
	 	}
	 	return true;
	}
	function doSetViewAndEditable(source) {
		if (source=='4') {
// 			var elements = YAHOO.util.Dom.getElementsByClassName('isHiddenPopup');
// 			for (key in elements) {
// 				YAHOO.util.Dom.removeClass(elements[key],"hide");
// 			}
// 			document.getElementById('txtPreState').disabled = false;
			document.getElementById('txtServingSize').disabled = false;
			document.getElementById('txtSizeUOM').disabled = false;
			document.getElementById('txtHouseSize').disabled = false;
			document.getElementById('addNewNutriRow').disabled = false;
			document.getElementById('chBoxAsPrePop').disabled = false;
// 			document.getElementById('deleteNutriRow').disabled = false;
			document.getElementById('fillValueForNutriInfo').disabled = false;
			YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('imgEditNutriSizeUOM'), 'display', 'inline');
			setEditableForDatagrid(source);
		} else {
// 			if (source=='7') {
// 				var elements = YAHOO.util.Dom.getElementsByClassName('isHiddenPopup');
// 				for (key in elements) {
// 					YAHOO.util.Dom.addClass(elements[key],"hide");
// 				}
// 			} else if (source=='9' || source=='17') {
// 				var elements = YAHOO.util.Dom.getElementsByClassName('isHiddenPopup');
// 				for (key in elements) {
// 					YAHOO.util.Dom.removeClass(elements[key],"hide");
// 				}
// 			} 
// 			document.getElementById('txtPreState').disabled = true;
			document.getElementById('txtServingSize').disabled = true;
			document.getElementById('txtSizeUOM').disabled = true;
			document.getElementById('txtHouseSize').disabled = true;
// 			document.getElementById('txtFatContent').disabled = true;
// 			document.getElementById('txtDailyRef').disabled = true;
			document.getElementById('chBoxAsPrePop').disabled = true;
			document.getElementById('addNewNutriRow').disabled = true;
// 			document.getElementById('deleteNutriRow').disabled = true;
			document.getElementById('fillValueForNutriInfo').disabled = false;
// 			document.getElementById('txtPreState').style.border = "1px solid #dedede";
			document.getElementById('txtServingSize').style.border = "1px solid #dedede";
			document.getElementById('txtSizeUOM').style.border = "1px solid #dedede";
			document.getElementById('txtHouseSize').style.border = "1px solid #dedede";
// 			document.getElementById('txtFatContent').style.border = "1px solid #dedede";
// 			document.getElementById('txtDailyRef').style.border = "1px solid #dedede";
// 			YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('imgEditNutriPreState'), 'display', 'none');
			YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('imgEditNutriSizeUOM'), 'display', 'none');		
			setEditableForDatagrid(source);	
		}
	}
	function setEditableForDatagrid(source) {
		var isEnabled = true;
		if (source==4) {
			isEnabled = false;
		}
		if(!isEnabled){
			if(document.getElementById('chBoxAsPrePop').checked){
				setEditableForTextInput('yui-dt-col-nutriQuantityPre', false);
				setEditableForTextInput('yui-dt-col-dailyValuePre', false);
				document.getElementById('prodValDesPopup').disabled = false;
			}else {
				setEditableForTextInput('yui-dt-col-nutriQuantityPre', true);
				setEditableForTextInput('yui-dt-col-dailyValuePre', true);
				document.getElementById('prodValDesPopup').disabled = true;
					
			}
		}else {
			setEditableForTextInput('yui-dt-col-nutriQuantityPre', true);
			setEditableForTextInput('yui-dt-col-dailyValuePre', true);
			document.getElementById('prodValDesPopup').disabled = true;
		}
		setEditableForTextInput('yui-dt-col-nutriQuantity', isEnabled);
		setEditableForTextInput('yui-dt-col-dailyValuePac', isEnabled);
		setEditableForAutoComplete('myAutoComplete', isEnabled);
		setEditableForAutoComplete('myAutoCompleteQuantityUom', isEnabled);
// 		this.setEditableForAutoComplete('myAutocompleteMeasurementPrecision', isEnabled);
	}
	function setEditableForTextInput(className, isEnabled) {
		var inputs = YAHOO.util.Dom.getElementsByClassName(className);
		if(null != inputs){
			for (key in inputs) {
				if (inputs[key] != null && inputs[key].childNodes[0] != null && inputs[key].childNodes[0].childNodes[0]!=null) {
					if (inputs[key].childNodes[0].childNodes[0].nodeName=='INPUT' && inputs[key].childNodes[0].childNodes[0].disabled!=null) {
						inputs[key].childNodes[0].childNodes[0].disabled = isEnabled;
					}
				}
			}
		}
	}
	function setEditableForAutoComplete(className, isEnabled) {
		var inputs = YAHOO.util.Dom.getElementsByClassName(className);
		for (key in inputs) {
			if (inputs[key].childNodes[0]!=null && inputs[key].childNodes[0].nodeName=='INPUT' && inputs[key].childNodes[0].disabled!=null) {
				inputs[key].childNodes[0].disabled = isEnabled;
			}
			if (inputs[key].childNodes[1]!=null) {
				if (isEnabled) {
					inputs[key].childNodes[1].style.display = 'none';
				} else {
					inputs[key].childNodes[1].style.display = 'inline';
				}
			}
		}
	}
	function fillDataForPopupInput(isFirst) {
		var size = "";
		var uom = "";
		var hold = "";
		if (isFirst) {
			if (isEditing) {
				size = document.getElementById('spanSize').innerText;
				uom = document.getElementById('spanSizeUOM').innerText;
				hold = document.getElementById('spanHouseHold').innerText;
			} else {
				size = sizeOrigin;
				uom = decodeHtml(sizeUomOrigin);
				hold = decodeHtml(houseHoldOrigin);
			}
		} else {
			if (srcSysID==srcSysIdOrigin) {
				size = sizeOrigin;
				uom = decodeHtml(sizeUomOrigin);
				hold = decodeHtml(houseHoldOrigin);
			} else {
				size = document.getElementById('spanSize').innerText;
				uom = document.getElementById('spanSizeUOM').innerText;
				hold = document.getElementById('spanHouseHold').innerText;
			}
		}
		document.getElementById('txtServingSize').value = size;
		document.getElementById('txtSizeUOM').value = uom;
		document.getElementById('txtHouseSize').value = hold;
// 		document.getElementById('txtServingSize').value = document.getElementById('spanSize').innerText;
// 		document.getElementById('txtSizeUOM').value = document.getElementById('spanSizeUOM').innerText;
// 		document.getElementById('txtHouseSize').value = document.getElementById('spanHouseHold').innerText;
		newArrISorCont = arrIsOrContainer;
	}
	function convertHtml(str)
	{
		if (typeof str != 'undefined' && str){
		  str = str.replace(/&/g, "&amp;");
		  str = str.replace(/>/g, "&gt;");
		  str = str.replace(/</g, "&lt;");
		  str = str.replace(/"/g, "&quot;");
		  str = str.replace(/'/g, "&#039;");
	  		return str;
		}
		return "";
	}
	function disableEnterKey(e)
	{
	     var key;		
	     if(window.event)
	          key = window.event.keyCode;     //IE
	     else
	          key = e.which;     //firefox		
	     if(key == 13)
	          return false;
	     else
	          return true;
	}
	function convertListToArrayNutriType() {
		var arr = new Array();
		<c:forEach var="item" items="${CPSForm.productVO.imageAttVO.lstNutriTypeNotStaAtt}">
			arr.push({
				value: '${item.desc}',
				id : "${item.id}"
			});
		</c:forEach>
		return arr;
	}
	function convertListToArrayUOM() {
		var arr = new Array();
		<c:forEach var="item" items="${CPSForm.productVO.imageAttVO.lstQuantityUOM}">
			arr.push({
				value: '${item.desc}',
				id : "${item.id}"
			});
		</c:forEach>
		return arr;
	} 
	function fillDataForDatagridPopup(isFirst) {
		var arr = new Array();
		if (isFirst) {
			if (isEditing) {
				arr = newArrInfoTmp;
			} else {
				arr = arrNutriVOsPopup;
			}
		} else {
			if (srcSysID==srcSysIdOrigin) {
				if (srcSysIdOrigin=='4' && isEditing) {
					arr = newArrInfoTmp;
				} else {
					arr = arrNutriVOsPopup;
				}
			} else {
				arr = newArrInfoTmp;
			}
		}
		tableNutrtPop.getRecordSet().reset();
		tableNutrtPop.getRecordSet().setRecords(arr);
		tableNutrtPop.refreshView();
		//addEventListenerForInputDatagrid();
	}
	function changeChBoxAsPrePop(element) {
		if(element != null){
// 			disable column of as prepared
			if(element.checked){
				setEditableForTextInput('yui-dt-col-nutriQuantityPre', false);
				setEditableForTextInput('yui-dt-col-dailyValuePre', false);
				document.getElementById("prodValDesPopup").disabled = false; 
			}else {
				setEditableForTextInput('yui-dt-col-nutriQuantityPre', true);
				setEditableForTextInput('yui-dt-col-dailyValuePre', true);
				document.getElementById("prodValDesPopup").disabled = true; 
					
			}
// 			tableNutrtPop.refreshView();
		}
	}
	function isDecimalKeyPress(evt){
	    var charCode = (evt.which) ? evt.which : event.keyCode;
	    return !(charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57));
	}
</script>

<c:url value="${request.getContextPath()}/hebAssets/images/icons/iconPopup.png" var="iconPopup"/>
<!-- <div style="width: 100%"> -->
	<div class="nutrientInfo">
		<h3>Nutrition Information</h3>&nbsp;&nbsp;&nbsp;
				<cps:renderByResourceAccess resourceId="271">
					<jsp:attribute name="EDIT">
						<img class="imageStandard" id="imgEditNutrition" align="middle" alt="" src="${iconPopup}"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<cps:renderByResourceAccess resourceId="271">
					<jsp:attribute name="VIEW">
						<img class="imageStandard" id="imgEditNutrition" align="middle" alt="" src="${iconPopup}"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>			
		<table class="tblNutrition" style="width: ${widthTable}px">
			<tr>
				<td width="30%" class='alignRight'>Serving Size 
				<c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class="redAsterisk">*</strong></c:if>
				<span class="hideClaims" id='spanNutriClaims'>${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.nutriClaimsTxt}</span>
				</td>
				<td width="20%"><span id='spanSize'>${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSize}</span></td>
				<td width="15%" class='alignRight'>Serving Size UOM</td>
				<td width="5px"><c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class="redAsterisk">*</strong></c:if></td>
				<td width="50%"><span id='spanSizeUOM'>${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSizeUOMDesc}</span></td>
			</tr>
			<tr>
				<td class='alignRight'>House Hold Serving Size 
				</td>
				<td><span id='spanHouseHold'>${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.houseHoldSize}</span></td>
				<td class='alignRight'></td>
				<td width="5px"></td>
				<td></td>
			</tr>
		</table>
	</div>
	<div style="margin-left: 0px;padding-left: 0px; padding-top: 5px;padding-bottom: 5px;"> 
		<input type="checkbox" id="chBoxNotAsPre" disabled="disabled"/> Show "As Prepared" Columns
	</div>
<%-- 	<center><div id='prodValDes' style="display: none;"></div></center> --%>
	<div id="tableNutrientView"></div>
	<div id="isOrcontainerWrapper" style="display: none;">
	IS or Contains : <span id='isOrcontainer'></span>
	</div>
	<form:hidden id="hiddenNutriClaims" path="productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.nutriClaims"/>
	<form:hidden id="hiddenNutriClaimsTxts" path="productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.nutriClaimsTxt"/>
	<form:hidden id="hiddenPreState" path="productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.preState"/>
	<form:hidden id="hiddenServingSize" path="productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSize"/>
	<form:hidden id="hiddenUOM" path="productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSizeUOMCD"/>
	<form:hidden id="hiddenUOMDesc" path="productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSizeUOMDesc"/>
	<form:hidden id="hiddenHoldHouse" path="productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.houseHoldSize"/>
	<form:hidden id="hiddenFatMilk" path="productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.fatMilkContent"/>
	<form:hidden id="hiddenDaily" path="productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.dailyIntakeRef"/>
	<form:hidden id="hiddenJSONNutriDataGrid" path="productVO.imageAttVO.nutriInfoVO.jsonNutriDataGrid"/>
	<form:hidden id="hiddenSrcSystem" path="productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.srcSysId"/>
	<form:hidden id="hiddenProdValDes" path="productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.prodValDes"/>
	<div id="nutritionPopupWrapper" style="display: none;">
		<div id="popupNutriInfo">
			<div class="hd">	
				<div class="tl"></div>
				<span>
					<font size="2" color="white">&nbsp;&nbsp;&nbsp;
						Nutrient Information
					</font>
				</span>
				<div class="closeMe" onclick="cancelNutriPopup();"></div>
				<div class="tr"></div>
			</div>
		    <div class="bd">
				<div class="nutritionPopupContent" width="100%">
					<div class="sourceOption">
					<c:forEach var="item" items="${CPSForm.productVO.imageAttVO.lstSrcPriority}" varStatus="count">
						<c:if test="${item ne 4}">
							<input type="radio" name="radioSrcOpt" onclick="getDataBySourceId(this.value)" value='${item}' /> Option ${count.count - 1}
						</c:if>
					</c:forEach>
						<input type="radio" id='radioSrc4' name="radioSrcOpt" onclick="getDataBySourceId(this.value)" value="4"/> User Input
					</div>
					<table class="tblNutrition" style="width: 900px">
						<tr>
							<td>Serving Size <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class="redAsterisk">*</strong></c:if></td>
							<td>
								<input type="text" name="txtServingSize" id="txtServingSize" maxlength="10" onkeypress="return validNumPress(event)" onblur="roundValue(this,4);return true;"/>
								<div class="hideClaims">	
								<input type="text" name="txtNuClaims" id="txtNuClaims" readonly="readonly"/>
								<img class="imageStandard" id="imgEditNutriClaims" align="middle" alt="" src="${iconPopup}"/>
							</div>
							</td>
							<td>Serving Size UOM <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class="redAsterisk">*</strong></c:if></td>
							<td>
								<input type="text" name="txtSizeUOM" id="txtSizeUOM" onchange="queryItemByTxt(this)"/>
								<img class="imageStandard" id="imgEditNutriSizeUOM" align="middle" alt="" src="${iconPopup}"/>
							</td>				
						</tr>
						<tr>
							<td>House Hold Serving Size </td>
							<td><input type="text" maxlength="70" name="txtHouseSize" id="txtHouseSize"/></td>
							<td></td>
							<td>
							</td>
						</tr>
					</table>
					<div style="margin-left: 0px;padding-left: 0px;padding-top: 5px;padding-bottom: 5px;"> 
						<input type="checkbox" id="chBoxAsPrePop" onclick="changeChBoxAsPrePop(this)" /> Show "As Prepared" Columns
					</div>
					<div  style="padding-top: 5px;" id='errorMsg' ></div>
<%-- 					<center><div id='prodValDesPopup' style="display: none;"></div></center> --%>
					<br/>
					<div id="popupNutriDatadrid" ></div>
					<div id="isContainsPopupWrapper" style="display: none; margin: 3px 0px">
					IS or Contains : <span id='isContainsPopup'></span>
					</div>
				</div>
				<div class="buttonBar" align="right">
					<input type="button" id="addNewNutriRow" name="Add" value="Add">
					<input type="button" id="fillValueForNutriInfo" name="Ok" value="OK"> 
					<input type="button" id="cancelNutriPopup" name="Cancel" value="Cancel">
				</div>
			</div>
		    <div class="ft">
					<div class="bl"></div>
					<div class="br"></div>
			</div>
		</div>
	</div>
<!-- </div> -->
<div id="sizeUOMPopupWrapper">
	<jsp:include page="/cps/add/modules/sizeUOMPopup.jsp"></jsp:include>
</div>
<script type="text/javascript">
if (isOrContainer.length>1) {
	document.getElementById("isOrcontainerWrapper").style.display = "inline";
	document.getElementById("isOrcontainer").innerHTML = isOrContainer.slice(0, isOrContainer.length -2);
}
// <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.srcSysId eq '7'}">
// document.getElementById("prodValDes").style.display = 'inline';
// YAHOO.util.Dom.setStyle(YAHOO.util.Dom.getElementsByClassName('isHidden', 'div'), 'display', 'none');
// </c:if>
</script>


