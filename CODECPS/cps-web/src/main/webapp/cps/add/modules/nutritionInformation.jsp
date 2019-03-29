<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>

<style type="text/css">
#nutritionPage .yui-dt-message {
	display: none;
}
.hideClaims {
	display: none;
}
</style>

<script type="text/javascript">

//Adding trim function to String object
if(typeof String.prototype.trim !== 'function') {
  String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g, '');
  }
}

YAHOO.namespace('YAHOO.nutri.datagrid');
var nutriInfoTable = null;
var isOrContainer = "";
var arrNutriVOs = new Array();
var arrNutriVOsPopup = new Array();
var arrIsOrContainer = new Array();
var maxNutrient;
var isPopupShowed = false;
var isPreShowed = false;
var isUomShowed = false;
var prodValDes = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.prodValDes}"/>';

var sizeOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSize}"/>';
var sizeUomOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.servingSizeUOMDesc}"/>';
var houseHoldOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.houseHoldSize}"/>';
var preStateOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.preState}"/>';
var dailyValueOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.dailyIntakeRef}"/>';
var fatMilkOrigin = '<c:out value="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.fatMilkContent}"/>';

<c:forEach var="item" items="${CPSForm.productVO.imageAttVO.nutriInfoVO.lstNutriDatagrid}" varStatus="count">
	
	<c:if test="${item.isOrContainer eq 0}">
		arrNutriVOs.push({
			nutritionName:'${item.nutritionName}', 
			nutriQuantity:'${item.nutriQuantity}', 
			servingSizeUOMCD:'${item.servingSizeUOMDesc}', 
			nutritionMeasr:'${item.nutritionMeasr}', 
			dailyValue:'${item.dailyValue}'});
		arrNutriVOsPopup.push({
			nutritionId:'${item.nutritionId}', 
			nutriQuantity:'${item.nutriQuantity}', 
			servingSizeUOMCD:'${item.servingSizeUOMCD}', 
			nutritionMeasr:'${item.nutritionMeasr}', 
			dailyValue:'${item.dailyValue}',
			nutrientTypeTxt: '${item.nutritionName}',
			sizeUomTxt: '${item.servingSizeUOMDesc}',
			changed: true,
			isOrContainer: '${item.isOrContainer}',
			keyNutrition: '${item.keyNutrition}'});
	</c:if>
	<c:if test="${item.isOrContainer ne 0}">
		isOrContainer += '${item.nutritionName}' + ", ";
		arrIsOrContainer.push({
			nutritionId:'${item.nutritionId}', 
			nutriQuantity:'${item.nutriQuantity}', 
			servingSizeUOMCD:'${item.servingSizeUOMCD}', 
			nutritionMeasr:'${item.nutritionMeasr}', 
			dailyValue:'${item.dailyValue}',
			nutrientTypeTxt: '${item.nutritionName}',
			sizeUomTxt: '${item.servingSizeUOMDesc}',
			changed: true,
			isOrContainer: '${item.isOrContainer}',
			keyNutrition: '${item.keyNutrition}'});
	</c:if>
</c:forEach>

YAHOO.nutri.datagrid.Data = {
	    dataProvider: arrNutriVOs
	}
YAHOO.util.Event.addListener(window, "load", function() {
	maxNutrient = "${CPSForm.productVO.imageAttVO.nutriInfoVO.maxNutrientDetails}";	
	if(typeof maxNutrient == 'undefined' || maxNutrient == null || maxNutrient==''){
		maxNutrient = 1;
	}
	YAHOO.nutri.datagrid.Basic = function() {
        var myColumnDefs = [
            {key:"nutritionName", label : "Nutrient Type<c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>"},
            {key:"nutriQuantity", label : "Quantity Contained <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>"},
            {key:"servingSizeUOMCD", label : "Quantity Contained UOM <c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>"},
            {key:"nutritionMeasr", label : "Measurement Precision"},
            {key:"dailyValue", label : "Percentage of Daily Value Intake"},
            {key:"changed", label : "", width:0,hidden :true}
        ];

        var myDataSource = new YAHOO.util.DataSource(YAHOO.nutri.datagrid.Data.dataProvider);
        myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
        myDataSource.responseSchema = {
            fields: ["nutritionName","nutriQuantity","servingSizeUOMCD","nutritionMeasr","dailyValue","changed"]
        };

        nutriInfoTable = new YAHOO.widget.DataTable("nutrientDatagrid", myColumnDefs, myDataSource);
        nutriInfoTable.showTableMessage("");
        return {
            oDS: myDataSource,
            oDT: nutriInfoTable
        };
    }();
});

</script>
<c:url value="${request.getContextPath()}/hebAssets/images/icons/iconPopup.png" var="iconPopup"/>
<div id="nutritionPage">
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
	<table class="tblNutrition">
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
			<td class='alignRight'>House Holding Serving Size 
			</td>
			<td><span id='spanHouseHold'>${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.houseHoldSize}</span></td>
			<td class='alignRight'>Preparation State</td>
			<td width="5px"></td>
			<td><span id='spanPreState'>${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.preState}</span></td>
		</tr>
		<tr>
			<td class='alignRight'>
			<div class="isHidden">
			Daily Value Intake Reference
			</div>
			</td>
			<td>
			<div class="isHidden">
			<span id='spanDailyValue'>${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.dailyIntakeRef}</span>
			</div>
			</td>
			<td class='alignRight'>
			<div class="isHidden">Fat in Milk Content</div>
			</td>
			<td width="5px"></td>
			<td>
			<div class="isHidden">
			<span id='spanFatMilk'>${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.fatMilkContent}</span>
			</div>
			</td>
		</tr>
	</table>
	</div>
	<center><div id='prodValDes' style="display: none;"></div></center>
	<br/>
	<div id="nutrientDatagrid"></div>
	<br/>
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
</div>
<div id="nutritionPopupPage">
	<jsp:include page="/cps/add/modules/nutritionPopup.jsp"></jsp:include>
</div>
<script type="text/javascript">
if (isOrContainer.length>1) {
	document.getElementById("isOrcontainerWrapper").style.display = "inline";
	document.getElementById("isOrcontainer").innerHTML = isOrContainer.slice(0, isOrContainer.length -2);
}
<c:if test="${CPSForm.productVO.imageAttVO.nutriInfoVO.nutriBasicInfoVO.srcSysId eq '7'}">
document.getElementById("prodValDes").innerText = prodValDes;
document.getElementById("prodValDes").style.display = 'inline';
YAHOO.util.Dom.setStyle(YAHOO.util.Dom.getElementsByClassName('isHidden', 'div'), 'display', 'none');
</c:if>
</script>
