<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
 <c:url value="${request.getContextPath()}/yui/autocomplete/autocomplete-min.js" var="styleURL"/>
 <script type="text/javascript" src="${styleURL}"></script>
<style type="text/css">
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

#popupNutriDatadrid td.yui-dt-col-nutritionId input{
	width:201px;
}


#popupNutriDatadrid td.yui-dt-col-nutriQuantity input{
	width:105px;
}

#popupNutriDatadrid td.yui-dt-col-servingSizeUOMCD input{
	width:120px;
}
#popupNutriDatadrid td.yui-dt-col-nutritionMeasr input{
	width:120px;
}
#popupNutriDatadrid td.yui-dt-col-dailyValue input{
	width:180px;
}
.nutritionPopupContent {
	height:408px;
	overflow: scroll;
}
 .nutritionPopupContent .tblNutrition {
 	width: 97%;
 }
#popupNutriDatadrid {
	width:100%
}
#popupNutriDatadrid table {
	width: 97%
}
</style>

<c:set var="showOrHide" value="inline"></c:set>
<c:url value="${request.getContextPath()}/hebAssets/images/dropdown.bmp" var="image"></c:url>
<c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.srcSysId eq '7'}">
	<c:set var="showOrHide" value="none"></c:set>
</c:if>
<c:url value="${request.getContextPath()}/hebAssets/images/icons/iconPopup.png" var="iconPopup"/>
<div id="nutritionPopupWrapper">
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
		
		<table class="tblNutrition">
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
				<td>House Holding Serving Size </td>
				<td><input type="text" maxlength="70" name="txtHouseSize" id="txtHouseSize"/></td>
				<td>Preparation State </td>
				<td>
					<input type="text" name="txtPreState" id="txtPreState" onchange="queryPreStateByTxt(this)"/>
					<img class="imageStandard" id="imgEditNutriPreState" align="middle" alt="" src="${iconPopup}"/>
				</td>
			</tr>
			<tr>
				<td>
				<div class="isHiddenPopup">	
				Daily Value Intake Reference
				</div>
				</td>
				<td>
				<div class="isHiddenPopup">
				<input type="text" name="txtDailyRef" id="txtDailyRef" maxlength="10" onkeypress="return validNumPress(event)" onblur="roundValue(this,4);return true;"/>
				</div>
				</td>
				<td>
				<div class="isHiddenPopup">
				Fat in Milk Content
				</div>
				</td>
				<td>
				<div class="isHiddenPopup">
				<input type="text" name="txtFatContent" id="txtFatContent" maxlength="10" onkeypress="return validNumPress(event)" onblur="roundValue(this,4);return true;"/>
				</div>
				</td>
			</tr>
		</table>
		<div id='errorMsg' ></div>
		<center><div id='prodValDesPopup' style="display: none;"></div></center>
		<br/>
		<div id="popupNutriDatadrid" >			
		</div>
<!-- 		<div id="popupNutriDatadridTag" > -->
<%-- 			<c:forEach var="item" begin="0" end="6" varStatus="count"> --%>
<%-- 				<cps:dataTableNutrientPop compId="777777${item}" --%>
<%-- 					viewMode="false" --%>
<%-- 					resourceId="271"> 									 --%>
<%-- 				</cps:dataTableNutrientPop> --%>
<%-- 			</c:forEach> --%>
<!-- 		</div> -->
	<div id="isContainsPopupWrapper" style="display: none; margin: 3px 0px">
	IS or Contains : <span id='isContainsPopup'></span>
	</div>
		</div>
	<div class="buttonBar" align="right">
		<input type="button" id="addNewNutriRow" name="Add" value="Add">
		<input type="button" id="deleteNutriRow" name="Delete" value="Delete"> 
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

<div id="prepareStatePopupWrapper">
	<jsp:include page="/cps/add/modules/prepareStatePopup.jsp"></jsp:include>
</div>

<div id="sizeUOMPopupWrapper">
	<jsp:include page="/cps/add/modules/sizeUOMPopup.jsp"></jsp:include>
</div>
<script type="text/javascript">

var isMandatory = ${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw};
var lstQuantityUOM = convertListToArrayUOM();
var lstNutriType = convertListToArrayNutriType();
function convertListToArrayNutriType() {
	var arr = new Array();
	<c:forEach var="item" items="${CPSForm.productVO.imageAttVO.lstNutriType}">
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
/* if(${!CPSForm.viewModeImageAttr}){
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("imgEditNutrition"), "click", showNutritionPopup);
} */
YAHOO.util.Event.addListener(YAHOO.util.Dom.get("imgEditNutriPreState"), "click", showpreStatePopup);
YAHOO.util.Event.addListener(YAHOO.util.Dom.get("imgEditNutriSizeUOM"), "click", showNutriUOMPopup);
YAHOO.util.Event.addListener(YAHOO.util.Dom.get("cancelNutriPopup"), "click", cancelNutriPopup);
YAHOO.util.Event.addListener(YAHOO.util.Dom.get("fillValueForNutriInfo"), "click", doFillValueForNutriInfo);

var srcSysIdOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.srcSysId}"/>';
var srcSysID = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.srcSysId}"/>';
var sizeUOMCD = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSizeUOMCD}"/>';
var sizeUOMFilter = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSizeUOMCD}"/>';
var newArrInfoTmp = new Array();
var isEditing = false;
var newArrISorCont = new Array();
YAHOO.namespace('heb.imageAttribute.nutritionPopup');
function showNutritionPopup(){
	if (!isPopupShowed) {
		isPopupShowed = true;
		document.getElementById("nutritionPopupWrapper").style.display="inline";
		YAHOO.heb.imageAttribute.nutritionPopup = new YAHOO.widget.Panel("nutritionPopupWrapper",
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
		
	YAHOO.heb.imageAttribute.nutritionPopup.render(document.body);
	document.getElementById('errorMsg').innerText = '';
		showDataForFirstTime(false);
		if(srcSysID != '4'){
			getDataBySourceId(srcSysID);
		}
	}
}
function onBeforeShowEvent(){
}
function cancelNutriPopup() {
	isPopupShowed = false;
	YAHOO.heb.imageAttribute.nutritionPopup.hide();
	srcSysID = srcSysIdOrigin;
	if (isEditing) {
		srcSysID='4';
	}
	AddCandidateTemp.revertToNutriInforOrigin();
}
function showDataForFirstTime(isEditBtnClicked) {
	document.getElementById("prodValDesPopup").style.display = "none";
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
		if (srcSysIdOrigin=='7') {
			document.getElementById("prodValDesPopup").style.display = "inline";
			document.getElementById("prodValDesPopup").innerText = prodValDes;
		} else {
		}
		if (srcSysID==srcSysIdOrigin) {
			if (isOrContainer.length>1) {
				document.getElementById("isContainsPopupWrapper").style.display = "inline";
				document.getElementById("isContainsPopup").innerHTML = isOrContainer.slice(0, isOrContainer.length -2);
			}
		}
	}
	fillDataForPopupInput(isEditBtnClicked);
	fillDataForDatagridPopup(isEditBtnClicked);
	setViewAndEditable();
	hideProgress();
	YAHOO.heb.imageAttribute.nutritionPopup.show();
	// remove horizontal bar of datagrid
// 	var grid = document.getElementById('popupNutriDatadrid');
// 	if (document.getElementById('popupNutriDatadrid').childNodes[2]!=null) {
// 		document.getElementById('popupNutriDatadrid').childNodes[2].style.overflowX = 'hidden';
// 		document.getElementById('popupNutriDatadrid').childNodes[2].style.overflowY = 'hidden';
// 	}
}
function fillDataForPopupInput(isFirst) {
	var size = "";
	var uom = "";
	var hold = "";
	var pre = "";
	var daily = "";
	var fat = "";
	if (isFirst) {
		if (isEditing) {
			size = document.getElementById('spanSize').innerText;
			uom = document.getElementById('spanSizeUOM').innerText;
			hold = document.getElementById('spanHouseHold').innerText;
			pre = document.getElementById('spanPreState').innerText;
			daily = document.getElementById('spanDailyValue').innerText;
			fat = document.getElementById('spanFatMilk').innerText;
		} else {
			size = sizeOrigin;
			uom = decodeHtml(sizeUomOrigin);
			hold = decodeHtml(houseHoldOrigin);
			pre = preStateOrigin;
			daily = dailyValueOrigin;
			fat = fatMilkOrigin;
		}
	} else {
		if (srcSysID==srcSysIdOrigin) {
			size = sizeOrigin;
			uom = decodeHtml(sizeUomOrigin);
			hold = decodeHtml(houseHoldOrigin);
			pre = preStateOrigin;
			daily = dailyValueOrigin;
			fat = fatMilkOrigin;
		} else {
			size = document.getElementById('spanSize').innerText;
			uom = document.getElementById('spanSizeUOM').innerText;
			hold = document.getElementById('spanHouseHold').innerText;
			pre = document.getElementById('spanPreState').innerText;
			daily = document.getElementById('spanDailyValue').innerText;
			fat = document.getElementById('spanFatMilk').innerText;
		}
	}
	document.getElementById('txtServingSize').value = size;
	document.getElementById('txtSizeUOM').value = uom;
	document.getElementById('txtHouseSize').value = hold;
	document.getElementById('txtPreState').value = pre;
	document.getElementById('txtDailyRef').value = daily;
	document.getElementById('txtFatContent').value = fat;
	newArrISorCont = arrIsOrContainer;
}

function reloadDataAfterSave() {
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
// 			setSelectedOption();
			fillDataForBasicInfo(data);
			fillDataForDataGrid(data);
			setViewAndEditable();
		}else{
			alert(data.appData.message);
		}
	}else{
		alert(msgData.exception);
	}
	YAHOO.heb.imageAttribute.nutritionPopup.show();
	hideProgress();
}
function fillDataForBasicInfo(data) {
	if (data.appData.nutriBasicInfoVO!=null) {
		document.getElementById('txtPreState').value = getTrimmedValue(data.appData.nutriBasicInfoVO.preState);
		document.getElementById('txtServingSize').value = getTrimmedValue(data.appData.nutriBasicInfoVO.servingSize);
		sizeUOMCD = getTrimmedValue(data.appData.nutriBasicInfoVO.servingSizeUOMCD);
		document.getElementById('txtSizeUOM').value = decodeHtml(getTrimmedValue(data.appData.nutriBasicInfoVO.servingSizeUOMDesc));
		document.getElementById('txtHouseSize').value = decodeHtml(getTrimmedValue(data.appData.nutriBasicInfoVO.houseHoldSize));
		document.getElementById('txtFatContent').value = getTrimmedValue(data.appData.nutriBasicInfoVO.fatMilkContent);
		document.getElementById('txtDailyRef').value = getTrimmedValue(data.appData.nutriBasicInfoVO.dailyIntakeRef);
		if (srcSysID=='7') {
			document.getElementById("prodValDesPopup").innerText = getTrimmedValue(data.appData.nutriBasicInfoVO.prodValDes);
			document.getElementById("prodValDesPopup").style.display = "inline";
		} else {
			document.getElementById("prodValDesPopup").style.display = "none";
		}
	}
}
function setViewAndEditable() {
	var radioObj = document.getElementsByName("radioSrcOpt");
	var radioVal = getCheckedRadioVal(radioObj);
	doSetViewAndEditable(radioVal);
}
function doSetViewAndEditable(source) {
	if (source=='4') {
		var elements = YAHOO.util.Dom.getElementsByClassName('isHiddenPopup');
		for (key in elements) {
			YAHOO.util.Dom.removeClass(elements[key],"hide");
		}
		document.getElementById('txtPreState').disabled = false;
		document.getElementById('txtServingSize').disabled = false;
		document.getElementById('txtSizeUOM').disabled = false;
		document.getElementById('txtHouseSize').disabled = false;
		document.getElementById('txtFatContent').disabled = false;
		document.getElementById('txtDailyRef').disabled = false;
		document.getElementById('addNewNutriRow').disabled = false;
		document.getElementById('deleteNutriRow').disabled = false;
		document.getElementById('fillValueForNutriInfo').disabled = false;
		YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('imgEditNutriPreState'), 'display', 'inline');
		YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('imgEditNutriSizeUOM'), 'display', 'inline');
		setEditableForDatagrid(source);
	} else {
		if (source=='7') {
			var elements = YAHOO.util.Dom.getElementsByClassName('isHiddenPopup');
			for (key in elements) {
				YAHOO.util.Dom.addClass(elements[key],"hide");
			}
		} else if (source=='9' || source=='17') {
			var elements = YAHOO.util.Dom.getElementsByClassName('isHiddenPopup');
			for (key in elements) {
				YAHOO.util.Dom.removeClass(elements[key],"hide");
			}
		} 
		document.getElementById('txtPreState').disabled = true;
		document.getElementById('txtServingSize').disabled = true;
		document.getElementById('txtSizeUOM').disabled = true;
		document.getElementById('txtHouseSize').disabled = true;
		document.getElementById('txtFatContent').disabled = true;
		document.getElementById('txtDailyRef').disabled = true;
		document.getElementById('addNewNutriRow').disabled = true;
		document.getElementById('deleteNutriRow').disabled = true;
		document.getElementById('fillValueForNutriInfo').disabled = false;
		document.getElementById('txtPreState').style.border = "1px solid #dedede";
		document.getElementById('txtServingSize').style.border = "1px solid #dedede";
		document.getElementById('txtSizeUOM').style.border = "1px solid #dedede";
		document.getElementById('txtHouseSize').style.border = "1px solid #dedede";
		document.getElementById('txtFatContent').style.border = "1px solid #dedede";
		document.getElementById('txtDailyRef').style.border = "1px solid #dedede";
		YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('imgEditNutriPreState'), 'display', 'none');
		YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('imgEditNutriSizeUOM'), 'display', 'none');		
		setEditableForDatagrid(source);	
	}
}
function setEditableForDatagrid(source) {
	var isEnabled = true;
	if (source==4) {
		isEnabled = false;
	}
	var selects = YAHOO.util.Dom.getElementsByClassName('yui-dt-dropdown');
	for (key in selects) {
		selects[key].disabled = isEnabled;
	}
	var checkBoxes = YAHOO.util.Dom.getElementsByClassName('yui-dt-checkbox');
	for (key in checkBoxes) {
		checkBoxes[key].disabled = isEnabled;
	}
	this.setEditableForTextInput('yui-dt-col-nutriQuantity', isEnabled);
	this.setEditableForTextInput('yui-dt-col-dailyValue', isEnabled);
	this.setEditableForAutoComplete('myAutoComplete', isEnabled);
	this.setEditableForAutoComplete('myAutoCompleteQuantityUom', isEnabled);
	this.setEditableForAutoComplete('myAutocompleteMeasurementPrecision', isEnabled);
}
function setEditableForTextInput(className, isEnabled) {
	var inputs = YAHOO.util.Dom.getElementsByClassName(className);
	for (key in inputs) {
		if (inputs[key].childNodes[0].childNodes[0]!=null) {
			if (inputs[key].childNodes[0].childNodes[0].nodeName=='INPUT' && inputs[key].childNodes[0].childNodes[0].disabled!=null) {
			inputs[key].childNodes[0].childNodes[0].disabled = isEnabled;
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
function getTrimmedValue(str) {
	return str==null?"":str;
}
/* nutrition pop up data grid*/
YAHOO.namespace('YAHOO.nutri.popup.datagrid');
var arrNutriVOPopup = new Array();
var myDataTable = null;
YAHOO.nutri.popup.datagrid.Data = {
	    dataProvider: arrNutriVOsPopup
	}
YAHOO.nutri.popup.datagrid.Basic = function() {	
	var formatAutocomplete = function(elCell, oRecord, oColumn, sData) {
	var nutritionName = oRecord.getData("nutrientTypeTxt");
	elCell.innerHTML = "<div class='myAutoComplete' id='myAutoComplete"+oRecord.getData("keyNutrition")+"'><input type='text' id='myInput"+oRecord.getData("keyNutrition")+"' value='"+convertHtml(nutritionName)+"' size='20' maxlength='50' onKeyPress='return disableEnterKey(event)' style='position: relative;'><img src='${image}'  width='20' id='image"+oRecord.getData("keyNutrition")+"' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainer"+oRecord.getData("keyNutrition")+"'></div></div>";	
   };	
   	var formatAutocompleteQuantityUom = function(elCell, oRecord, oColumn, sData) {				 			
	var quantityUomName = oRecord.getData("sizeUomTxt");
	elCell.innerHTML = "<div class='myAutoCompleteQuantityUom' id='myAutoCompleteQuantityUom"+oRecord.getData("keyNutrition")+"'><input type='text' id='myInputQuantityUom"+oRecord.getData("keyNutrition")+"' value='"+convertHtml(quantityUomName)+"' size='20' maxlength='50' onKeyPress='return disableEnterKey(event)' style='position: relative;'/><img src='${image}'  width='20' id='imageQuantityUom"+oRecord.getData("keyNutrition")+"' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerQuantityUom"+oRecord.getData("keyNutrition")+"'></div></div>";	
 };
 var formatAutocompleteMeasurementPrecision = function(elCell, oRecord, oColumn, sData) {				 			
		var nutritionMeasrName = oRecord.getData("nutritionMeasr");
		elCell.innerHTML = "<div class='myAutocompleteMeasurementPrecision' id='myAutocompleteMeasurementPrecision"+oRecord.getData("keyNutrition")+"'><input type='text' id='myInputMeasurementPrecision"+oRecord.getData("keyNutrition")+"' value='"+convertHtml(nutritionMeasrName)+"' size='20' maxlength='50' onKeyPress='return disableEnterKey(event)' style='position: relative;'/><img src='${image}'  width='20' id='imageMeasurementPrecision"+oRecord.getData("keyNutrition")+"' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerMeasurementPrecision"+oRecord.getData("keyNutrition")+"'></div></div>";	
	 };
    var myColumnDefs = [
  		{key:"checkBox", label: "Select", formatter : "checkbox"},                      
        {key:"nutritionId", label : "Nutrient Type <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>", formatter:formatAutocomplete },
        {key:"nutriQuantity", width:110, dataType: "DEC", label : "Quantity Contained <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>", formatter : "textbox"},
        {key:"servingSizeUOMCD", width:140, label : "Quantity Contained UOM <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>", formatter:formatAutocompleteQuantityUom },
        {key:"nutritionMeasr", label : "Measurement Precision", formatter:formatAutocompleteMeasurementPrecision },
        {key:"dailyValue", width:190, dataType: "DEC", label : "Percentage of Daily Value Intake ", formatter : "textbox"},
        {key:"nutrientTypeTxt", label : "Nutri Type Text", hidden: true, width:0},
        {key:"sizeUomTxt", label : "Size UOM Text", hidden: true, width:0},
        {key:"changed", label : "", width:0,hidden :true},
        {key:"isOrContainer", label : "", width:0,hidden :true},
        {key:"keyNutrition", label : "", width:0,hidden :true},
        {key:"preTypeCd", label : "", width:0,hidden :true}
        
    ];

    var myDataSource = new YAHOO.util.DataSource(YAHOO.nutri.popup.datagrid.Data.dataProvider);
    
    myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
    myDataSource.responseSchema = {
        fields: ["checkBox","nutritionId","nutriQuantity","servingSizeUOMCD","nutritionMeasr","dailyValue","nutrientTypeTxt","sizeUomTxt","changed","isOrContainer","keyNutrition", "preTypeCd"]
    };
    myDataTable = new YAHOO.widget.DataTable("popupNutriDatadrid",
            myColumnDefs, myDataSource, {height:"15em"});
    
    myDataTable.showTableMessage("");
    return {
        oDS: myDataSource,
        oDT: myDataTable
    };
}(); 

myDataTable.subscribe("dropdownChangeEvent", function (oArgs) {
    var elCheckbox = oArgs.target;
    var oRecord = this.getRecord(elCheckbox);
    var column = this.getColumn(elCheckbox);
	oRecord.setData(column.key, elCheckbox.value);
	oRecord.setData("changed", true);
});

myDataTable.subscribe("postRenderEvent", function(){			
	for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){		
		var oRec = myDataTable.getRecord(i);   			
		setZindex(oRec.getData('keyNutrition'),i%myDataTable.getRecordSet().getLength(),myDataTable.getRecordSet().getLength());      	
	    //document.getElementById("myAutoComplete"+oRec.getData("keyNutrition")).parentNode.parentNode.parentNode.style.overflow = 'visible';
		setAutoComplete(oRec.getData('keyNutrition'));
		setZindexQuantityUom(oRec.getData('keyNutrition'),i%myDataTable.getRecordSet().getLength(),myDataTable.getRecordSet().getLength());      	
	    document.getElementById("myAutoCompleteQuantityUom"+oRec.getData("keyNutrition")).parentNode.parentNode.parentNode.style.overflow = 'visible';
	    setAutoCompleteQuantityUom(oRec.getData('keyNutrition'));
	    //myAutocompleteMeasurementPrecision
	    setZindexMeasurementPrecision(oRec.getData('keyNutrition'),i%myDataTable.getRecordSet().getLength(),myDataTable.getRecordSet().getLength());      	
	    document.getElementById("myAutocompleteMeasurementPrecision"+oRec.getData("keyNutrition")).parentNode.parentNode.parentNode.style.overflow = 'visible';
	    setAutoCompleteMeasurementPrecision(oRec.getData('keyNutrition'));
	}			 			
});
myDataTable.subscribe("checkboxClickEvent", function (oArgs) {
    var elCheckbox = oArgs.target;
    var oRecord = this.getRecord(elCheckbox);
    var column = this.getColumn(elCheckbox);
	oRecord.setData(column.key, elCheckbox.checked);
});

myDataTable.subscribe("renderEvent", function () {
	addEventListenerForInputDatagrid();
});

YAHOO.util.Event.on(myDataTable.getTbodyEl(),'keyup',function (ev) {
	var elInput = YAHOO.util.Event.getTarget(ev);
	if (elInput.tagName.toUpperCase() == 'INPUT') {
		var oRecord = myDataTable.getRecord(elInput);
		var column = myDataTable.getColumn(elInput);
		oRecord.setData(column.key,elInput.value);
		oRecord.setData("changed", true);
	}
});
YAHOO.util.Event.on(myDataTable.getTbodyEl(),'keypress',function (ev) {
	var elInput = YAHOO.util.Event.getTarget(ev);
	if (elInput.tagName.toUpperCase() == 'INPUT') {
		var oRecord = myDataTable.getRecord(elInput);
		var column = myDataTable.getColumn(elInput);
		if(column["dataType"] == "I" || column["dataType"] == "DEC" ) {
			return validNumPress(ev);
		}
	}
});

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
	myDataTable.getRecordSet().reset();
	myDataTable.getRecordSet().setRecords(arr);
	myDataTable.refreshView();
	//addEventListenerForInputDatagrid();
}

function addEventListenerForInputDatagrid() {
	var inputs = YAHOO.util.Dom.getElementsByClassName('yui-dt-col-nutriQuantity');
	var element;
	if (typeof inputs != 'undefined' && inputs){
		for (key in inputs) {
			element = inputs[key].childNodes[0].childNodes[0];
			if (element && element.nodeName=='INPUT') {
				element.setAttribute("maxLength",10);
				if(!YAHOO.util.Event.getListeners(element, "blur")){
					YAHOO.util.Event.addListener(element, "blur", validNumBlur );
				}
				calculatePrice3(element);
			}
		}
	}
	inputs = YAHOO.util.Dom.getElementsByClassName('yui-dt-col-dailyValue');
	if (typeof inputs != 'undefined' && inputs){
		for (key in inputs) {
			element = inputs[key].childNodes[0].childNodes[0];
			if (element && element.nodeName=='INPUT') {
				element.setAttribute("maxLength",10);
				if(!YAHOO.util.Event.getListeners(element, "blur")){
					YAHOO.util.Event.addListener(element, "blur", validNumBlur );
				}
				calculatePrice3(element);
			}
		}
	}
}

function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode;
    return !(charCode > 31 && (charCode < 48 || charCode > 57));
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
			nutriTypeCDTxt = data.appData.lstNutriDatagrid[i].nutritionName;
			sizeUomTxt = data.appData.lstNutriDatagrid[i].servingSizeUOMDesc;
			if (data.appData.lstNutriDatagrid[i].isOrContainer!=0) {
				isContainsPopup += data.appData.lstNutriDatagrid[i].nutritionName + ", ";
				newArrISorCont.push({
					checkBox: false,
					nutritionId: data.appData.lstNutriDatagrid[i].nutritionId, 
					nutriQuantity: data.appData.lstNutriDatagrid[i].nutriQuantity, 
					servingSizeUOMCD: data.appData.lstNutriDatagrid[i].servingSizeUOMCD, 
					nutritionMeasr: data.appData.lstNutriDatagrid[i].nutritionMeasr, 
					dailyValue: data.appData.lstNutriDatagrid[i].dailyValue,
					nutrientTypeTxt: data.appData.lstNutriDatagrid[i].nutritionName,
					sizeUomTxt: data.appData.lstNutriDatagrid[i].servingSizeUOMDesc,
					changed: true,
					isOrContainer: data.appData.lstNutriDatagrid[i].isOrContainer,
					keyNutrition: data.appData.lstNutriDatagrid[i].keyNutrition});
			} else {
				arrNutriVOPopup
					.push({
						checkBox: false,
						nutritionId: data.appData.lstNutriDatagrid[i].nutritionId,
						nutriQuantity:data.appData.lstNutriDatagrid[i].nutriQuantity,
						servingSizeUOMCD:data.appData.lstNutriDatagrid[i].servingSizeUOMCD,
						nutritionMeasr:data.appData.lstNutriDatagrid[i].nutritionMeasr,
						dailyValue:data.appData.lstNutriDatagrid[i].dailyValue,
						nutrientTypeTxt: nutriTypeCDTxt,
						sizeUomTxt: sizeUomTxt,
						changed: data.appData.lstNutriDatagrid[i].changed,
						isOrContainer: data.appData.lstNutriDatagrid[i].isOrContainer,
						keyNutrition: data.appData.lstNutriDatagrid[i].keyNutrition});			
			}
		}
		if (isContainsPopup.length>1) {
			document.getElementById("isContainsPopupWrapper").style.display = "inline";
			document.getElementById("isContainsPopup").innerHTML = isContainsPopup.slice(0, isContainsPopup.length -2);
		}
	}
	myDataTable.getRecordSet().reset();
	myDataTable.getRecordSet().setRecords(arrNutriVOPopup);
	myDataTable.refreshView();
}


function setSelectedSourceOption(radioObj) {
	for(var i = 0; i < radioObj.length; i++){
	    if(radioObj[i].value == srcSysID){
	    	radioObj[i].checked = true;
	    	break;
	    }
	}
}
/* NUTRITION ACTION */
YAHOO.util.Event.addListener("addNewNutriRow", "click", addNewNutriRow);
YAHOO.util.Event.addListener("deleteNutriRow", "click", deleteNutriRow);
function addNewNutriRow() {
	if(!validateDataGrid()) {
		return false;
	}
	document.getElementById('errorMsg').innerText = '';
	var dataSource = myDataTable.getDataSource();
	myDataTable.addRow(buildRowData(), 0);
	//addEventListenerForInputDatagrid()
}
var buildRowData = function () {
	var rowDatas = new Object();
	var dataSource = myDataTable.getDataSource();
	if(dataSource != null && dataSource.liveData != null && dataSource.liveData.length > 0) {
		var rowDataSource = dataSource.liveData[0];
		var rowData = rowDataSource.constructor();
		for(var key in rowDataSource){
			if(key == "checkBox") {
				rowData[key] = false;
			}else {
				rowData[key] = "";
			}
			if(key == "changed") {
				rowData[key] = true;
			}
			if(key == "keyNutrition") {
				rowData[key] = maxNutrient;
			}
			if(key == "isOrContainer") {
				rowData[key] = rowDataSource[key];
			}
		}
		maxNutrient++;
		rowDatas = rowData;
	} else {
		rowDatas =  {
			checkBox: false,
			nutritionId: '',
			nutriQuantity:'',
			servingSizeUOMCD:'',
			nutritionMeasr:'',
			dailyValue:'',
			nutrientTypeTxt: '',
			sizeUomTxt: '',
			changed: true,
			isOrContainer: '0',
			keyNutrition: maxNutrient};
		maxNutrient++;
	}
	return rowDatas;
};

function deleteNutriRow() {
	if (myDataTable.getRecordSet().getLength()==0) {
		alert('Please select at least one record to delete!');
	} else {
		var isChecked = false;
		for (var i= myDataTable.getRecordSet().getLength() -1 ; i >=0 ;i--){
			var oRec = myDataTable.getRecordSet().getRecord(i);
	        var dataCheckBox = oRec.getData("checkBox");
	        if (dataCheckBox) {
	        	isChecked = true;
	        	break;
	        }
	 	}
		if (isChecked) {
			var r = confirm("Are you sure you want to delete the selected record(s)?");
			if (r == true) {
				for (var i= myDataTable.getRecordSet().getLength() -1 ; i >=0 ;i--){
					var oRec = myDataTable.getRecordSet().getRecord(i);
			        var dataCheckBox = oRec.getData("checkBox");
			        if (dataCheckBox) {
			        	myDataTable.deleteRows(i);
			        }
			 	}
			}
		} else {
			alert('Please select at least one record to delete!');
		}
	}
}
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
		document.getElementById("prodValDes").style.display = "none";
		// hide IS or Container
		/* if (radioVal!=srcSysIdOrigin) {
			document.getElementById("isOrcontainerWrapper").style.display = "none";
			YAHOO.util.Dom.setStyle(YAHOO.util.Dom.getElementsByClassName('isHidden', 'div'), 'display', 'inline');
		} */
	} 
	
	
		document.getElementById('errorMsg').innerText = '';
		document.getElementById("spanPreState").innerText= document.getElementById('txtPreState').value;
		document.getElementById("spanSize").innerText= document.getElementById('txtServingSize').value;
		document.getElementById("spanSizeUOM").innerText= document.getElementById('txtSizeUOM').value;
		document.getElementById("spanHouseHold").innerText= document.getElementById('txtHouseSize').value;
		if (document.getElementById("spanFatMilk")!=null) {
			if (document.getElementById('txtFatContent')!=null) {
				document.getElementById("spanFatMilk").innerText= document.getElementById('txtFatContent').value;
			}
		}
		if (document.getElementById("spanDailyValue")!=null) {
			if (document.getElementById('txtDailyRef')!=null) {
				document.getElementById("spanDailyValue").innerText= document.getElementById('txtDailyRef').value;
			}
		}
		var iSCont='';
		iSCont = document.getElementById("isContainsPopup").innerHTML;
		if(iSCont != null && iSCont.length > 0){
			document.getElementById("isOrcontainerWrapper").style.display = "inline";
			document.getElementById("isOrcontainer").innerHTML = iSCont;
		} else {
			document.getElementById("isOrcontainerWrapper").style.display = "none";
			document.getElementById("isOrcontainer").innerHTML ="";
		}
		
		var newArrInfo = new Array();
		newArrInfoTmp = new Array();
		var rowDatas = []; 
		for (var i= 0; i < myDataTable.getRecordSet().getLength(); i++){
			var oRec = myDataTable.getRecordSet().getRecord(i);
			var name = oRec.getData("nutritionId");
			var quantity = oRec.getData("nutriQuantity");
			var uom = oRec.getData("servingSizeUOMCD");
			var measure = oRec.getData("nutritionMeasr");
			var daily = oRec.getData("dailyValue");
			var typeCdTxt = oRec.getData("nutrientTypeTxt");
			var uomTxt = oRec.getData("sizeUomTxt");
			var changed = oRec.getData("changed");
			//var changed = true;
			var isOrContainer = oRec.getData("isOrContainer");
			var keyNutrition = oRec.getData("keyNutrition");			
			rowDatas.push(oRec.getData());
			newArrInfo.push({nutritionName: typeCdTxt, nutriQuantity: quantity, servingSizeUOMCD: uomTxt, nutritionMeasr: measure, dailyValue: daily, nutrientTypeTxt: typeCdTxt, sizeUomTxt: uomTxt, changed: changed, isOrContainer: isOrContainer,keyNutrition:keyNutrition});
	 		newArrInfoTmp.push({
				nutritionId:name, 
				nutriQuantity:quantity, 
				servingSizeUOMCD:uom, 
				nutritionMeasr:measure, 
				dailyValue:daily,
				nutrientTypeTxt: typeCdTxt,
				sizeUomTxt: uomTxt,
				changed: true,
				isOrContainer: isOrContainer,
				keyNutrition:keyNutrition});
	 	}
		nutriInfoTable.getRecordSet().reset();
		nutriInfoTable.getRecordSet().setRecords(newArrInfo);
		nutriInfoTable.refreshView();
		document.getElementById("hiddenPreState").value=document.getElementById('txtPreState').value;
		document.getElementById("hiddenServingSize").value=document.getElementById('txtServingSize').value;
		document.getElementById("hiddenUOM").value=sizeUOMCD;
		document.getElementById("hiddenUOMDesc").value= document.getElementById('txtSizeUOM').value;	
		document.getElementById("hiddenHoldHouse").value=document.getElementById('txtHouseSize').value;
		if (document.getElementById("spanFatMilk")!=null) {
			if (document.getElementById('txtFatContent')!=null) {
				document.getElementById("hiddenFatMilk").value=document.getElementById('txtFatContent').value;
			}
		}
		if (document.getElementById("spanDailyValue")!=null) {
			if (document.getElementById('txtDailyRef')!=null) {
				document.getElementById("hiddenDaily").value=document.getElementById('txtDailyRef').value;
			}
		}
		/* if (arrIsOrContainer.length>0){
			for (var i=0;i<arrIsOrContainer.length;i++) {
				rowDatas.push(arrIsOrContainer[i]);
			}
		} */
		
		if (newArrISorCont.length>0){
			for (var i=0;i<newArrISorCont.length;i++) {
				rowDatas.push(newArrISorCont[i]);
			}
		}
		document.getElementById("hiddenJSONNutriDataGrid").value = YAHOO.lang.JSON.stringify(rowDatas);  
		var sourceRadio = document.getElementsByName('radioSrcOpt');
		for(var i = 0; i < radioObj.length; i++){
		    if(radioObj[i].checked){
		    	document.getElementById("hiddenSrcSystem").value = radioObj[i].value;
		    	break;
		    }
		}
		YAHOO.heb.imageAttribute.nutritionPopup.hide();
		if(radioVal=='7'){
			YAHOO.util.Dom.setStyle(YAHOO.util.Dom.getElementsByClassName('isHidden', 'div'), 'display', 'none');
	}
}

function validateNutriForm() {
	var isOK = false;
	var isPreOK = validateByFieldId("txtPreState");
	var isSizeOK = validateByFieldId("txtServingSize");
	var isUomOK = validateByFieldId("txtSizeUOM");
	var isHouseOK = validateByFieldId("txtHouseSize");
	var isDailyOK = validateByFieldId("txtDailyRef");
	if (isPreOK && isSizeOK && isUomOK && isHouseOK && isDailyOK) {
		isOK = true;
	}
	return isOK;
}

function validateByFieldId(fieldId) {
	var isValid = false;
	var claims = document.getElementById(fieldId);
	if (claims.value.toString().trim()=="") {
		claims.style.border = "1px solid red";
		isValid = false;
	} else {
		claims.style.border = "1px solid #dedede";
		isValid = true;
	}
	return isValid;
}

function setBorderForInput(fieldId, color) {
	var object = document.getElementById(fieldId);
	object.style.border = "1px solid " + color;
}

function validateDataGrid() {
	if (myDataTable.getRecordSet().getLength()==0){
		return true;
	}
	var isOK = true;

	for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){
		var oReci = myDataTable.getRecordSet().getRecord(i).getData();
		for (var j= i+1; j< myDataTable.getRecordSet().getLength();j++){
			var oRecj = myDataTable.getRecordSet().getRecord(j).getData();
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
	for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){
		var oRec = myDataTable.getRecordSet().getRecord(i);
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
	for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){
		var oRec = myDataTable.getRecordSet().getRecord(i);
		for(var keyRec in oRec) {
			if (isMandatory) {
				if(oRec.getData('nutritionId')==''){
					document.getElementById('errorMsg').innerText = 'Please enter mandatory data before adding next row.';
					return false;
				}
				if(oRec.getData('nutriQuantity')==''){
					document.getElementById('errorMsg').innerText = 'Please enter mandatory data before adding next row.';
					return false;
				}
				if(oRec.getData('servingSizeUOMCD')==''){
					document.getElementById('errorMsg').innerText = 'Please enter mandatory data before adding next row.';
					return false;
				}
			} else {
				if(oRec.getData('nutritionId')=='' 
						&& oRec.getData('nutriQuantity')==''
						&& oRec.getData('servingSizeUOMCD')==''
						&& oRec.getData('nutritionMeasr')==''
						&& oRec.getData('dailyValue')=='') {
					document.getElementById('errorMsg').innerText = 'Please enter one field at least for existing row.';
					return false;
				}
			}
		}
	}
	
	
// 	var selects = YAHOO.util.Dom.getElementsByClassName('yui-ac-input');
// 	for (key in selects) {
// 		if (selects[key].value.trim()=="") {
// 			isOK = false;
// 			document.getElementById('errorMsg').innerText = 'Please enter fully data for one row.';
// 			break;
// 		} else {
// 		}
// 	}
// 	if (!isOK) return false; 
// 	selects = YAHOO.util.Dom.getElementsByClassName('yui-dt-dropdown');
// 	for (key in selects) {
// 		if (selects[key].value.trim()=="") {
// 			isOK = false;
// 			document.getElementById('errorMsg').innerText = 'Please enter fully data for one row.';
// 			break;
// 		} else {
// 		}
// 	}
// 	if (!isOK) return false;
// 	inputs = YAHOO.util.Dom.getElementsByClassName('yui-dt-col-dailyValue');
// 	for (key in inputs) {
// 		if (inputs[key].childNodes[0].childNodes[0]!=null) {
// 			if (inputs[key].childNodes[0].childNodes[0].nodeName=='INPUT' && inputs[key].childNodes[0].childNodes[0].disabled!=null) {
// 				if (inputs[key].childNodes[0].childNodes[0].value.trim()=='') {
// 					isOK = false;
// 					document.getElementById('errorMsg').innerText = 'Please enter fully data for one row.';
// 					break;
// 				} else {
// 				}
// 			}
// 		}
// 	}
	return isOK;
}

function getTextById(listObj, key) {
	var txt = "";
	for (var i=0; i < listObj.length; i++) {
		if (listObj[i].value==key) {
			txt= listObj[i].text;
			break;
		}
	}	
	return txt;
}

function getDataBySourceId(source) {
	document.getElementById('errorMsg').innerText = '';
	document.getElementById("isContainsPopupWrapper").style.display = "none";
	document.getElementById("prodValDesPopup").style.display = "none";
	srcSysID = source;
	if (source=='4' && (source==srcSysIdOrigin || isEditing)) {
		showDataForFirstTime(false);
	} else {
		showProgress();
		AddCandidateTemp.getNutritionInfoBySrcSysId(source, "${CPSForm.productVO.upcImageAndAttr}", showNutritionInfo);
	}		
}
function returnFalse(){
	return false;
}
function setSelectedOption() {
	var sourceRadio = document.getElementsByName('radioSrcOpt');
	setSelectedSourceOption(sourceRadio);
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

function validNumBlur(evt){
	var target = evt.target || evt.srcElement;
	roundValue(target, 4);
 	return true;
}


function html_entity_decode(str) {
	var ta = document.createElement("textarea");
	ta.innerHTML = str.replace(/</g,"&lt;").replace(/>/g,"&gt;");
	return ta.value;
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
	if(query!=''){
		query = query.ReplaceAll('%20',' ');
		query = query.ReplaceAll('%25','%');
	}	
	reslts = [];	
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
    if(query != ''){
		reslts.sort(function(a, b){
			 var t2Up = query.toUpperCase();
			 var nameA = a.value.toUpperCase(), nameB=b.value.toUpperCase();
			 if (nameA.indexOf(t2Up) < nameB.indexOf(t2Up)) //sort string ascending
			  	return -1;
			 if (nameA.indexOf(t2Up) > nameB.indexOf(t2Up))
			  	return 1;
			 return 0 ;//default return value (no sorting)
			});
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
		oAutoComp.minQueryLength=0;	
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
			for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){		
				var oRec = myDataTable.getRecord(i);  		
				if(oRec.getData('keyNutrition')==id){							
					oRec.setData('nutritionId',aData.id);
					oRec.setData('nutrientTypeTxt',aData.value);			
				}
			}			
			myDataTable.refreshView();
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
						for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){		
							var oRec = myDataTable.getRecord(i);
							if(oRec.getData('keyNutrition')==id){							
								oRec.setData('nutritionId',"");
								oRec.setData('nutrientTypeTxt',"");
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
	        setTimeout(function() {t2.sendQuery("");}, 0);
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
		for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){		
			var oRec = myDataTable.getRecord(i);  		
			if(oRec.getData('keyNutrition')==id){					
				oRec.setData('servingSizeUOMCD',aData.id);
				oRec.setData('sizeUomTxt',aData.value);			
			}
		}			
		myDataTable.refreshView();
	}
	
	oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
	
	oAutoComp.textboxChangeEvent.subscribe(
			function(){
				var oSelf = this;
				var data = oSelf.getSubsetMatches(oSelf.getInputEl().value);
				if(!data){
					oSelf.getInputEl().value = "";
					for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){		
						var oRec = myDataTable.getRecord(i);
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
		for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){		
			var oRec = myDataTable.getRecord(i);  		
			if(oRec.getData('keyNutrition')==id){
				oRec.setData('nutritionMeasr',aData);			
			}
		}			
		myDataTable.refreshView();
	}
	
	oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
	
	oAutoComp.textboxChangeEvent.subscribe(
			function(){
				var oSelf = this;
				var data = oSelf.getSubsetMatches(oSelf.getInputEl().value);
				if(!data){
					oSelf.getInputEl().value = "";
					for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){		
						var oRec = myDataTable.getRecord(i);
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
</script>