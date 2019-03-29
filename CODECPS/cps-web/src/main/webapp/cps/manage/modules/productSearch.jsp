<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.List"%>
<%@ page import="com.heb.operations.cps.model.ManageProduct" %>
<base ref="site" />
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8"/>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> -->
<link rel="stylesheet"
	href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>"
	type="text/css" ></link>
<link rel="stylesheet" 
		type="text/css" media="all" 
		href="<spring:url value='/hebAssets/calendar/calendar_blue.css'></spring:url>" title="calBlue"></link>	
</head>
<body >

<!-- Calendar Speccific Declarations  -->
<c:url value="${request.getContextPath()}/hebAssets/common.js" var="common"/>
<script type="text/javascript" src="${common}"></script>

<c:url value="${request.getContextPath()}/hebAssets/calendar/calendar.js" var="cal"/>
<script type="text/javascript" src="${cal}"></script>

<c:url value="${request.getContextPath()}/hebAssets/calendar/calendar-en.js" var="calen"/>
<script type="text/javascript" src="${calen}"></script>

<c:url value="${request.getContextPath()}/hebAssets/calendar/calendar-setup.js" var="calsetup"/>
<script type="text/javascript" src="${calsetup}"></script>

<c:url var="cal" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>



<div id="formCont1" style="position: relative;min-width: 0;">
<script type="text/Javascript">
var visi = "v";
checkFinalInputDisable();
function toggle(id){
	if(visi == "v"){
		hideTable();
		hideBorder(id,'hide');
	}else{
		showTable();
		hideBorder(id,'noHide');
	}
}
function hideBorder(id,classname){
	YAHOO.util.Dom.get(id).className = classname;
}
var tempHtml;

<c:url var="colspd" value="${request.getContextPath()}/hebAssets/images/collapsed.gif"></c:url>
<c:url var="expnd" value="${request.getContextPath()}/hebAssets/images/expanded.gif"></c:url>
function hideTable(){
if(visi == "v"){
	YAHOO.util.Dom.get('caseDiv').style.display = 'none';
	YAHOO.util.Dom.get('caseImg').src = "${colspd}";
	visi = "h";
}
}
function showTable(){
if(visi == "h"){
	
	YAHOO.util.Dom.get('caseDiv').style.display = 'block';
	YAHOO.util.Dom.get('caseImg').src = "${expnd}";
	visi = "v";
}
}
</script>

<c:choose>
	<c:when test="${manageProduct.prodcriteria.mrtSwitchCheck}">
		<c:set value="true"  var="mrtSwitchVar"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="false" var="mrtSwitchVar"></c:set>
	</c:otherwise>
</c:choose>

<fieldset id="f1" style="margin-left: 6px; background-color: #FFFFFF; margin-right: 6px; padding-bottom: 5px; 
		padding-top: 5px; width: 98%; color: #000000;position: relative;z-index: 9000;">
		<legend onclick="toggle('f1');" style="cursor: pointer; color: #666666">
		
	<img src="${expnd}" id="caseImg"/> Search Criteria </legend>
<div id="caseDiv" style="position: relative;min-width: 0;">
	<table width="100%" border="0">
		<tr>
			<td align="right" width="13%"><label for="selectedChannel" class="labelFont">BDM </label></td>
			<td align="left" width="20%">			<table width="100%" border="0">
				<tr>
					<td width="100%" align="left">
					<cps:autoComplete sourceList="bdms" compName="bdmUniq" containerId="bdmContainer" textid="bdmText" selectedProperty="prodcriteria.bdm" containerVar="YAHOO.HEB.manageMain.bdmData"
					resetJSMethodName="YAHOO.HEB.manageMain.bdmReset" selectedValueId="bdmSelectedId" clearMethod="bdmClear" 
					selectedValueName="bdmSelectedName" width="95%" onchangeMethod="bdmChange" index="9000" reloadMethod="YAHOO.HEB.manageMain.a2" valueDisplay="false" tabIndex="1"></cps:autoComplete>					
					
				</td>
					</tr>
			</table>
			</td>
			<td align="right" width="13%"><label for="selectedChannel" class="labelFont">Commodity </label>
			</td>
			<td align="left" width="20%"><table width="100%">
				<tr>
					<td width="100%" align="left">
				 	<cps:autoComplete sourceList="commodities" compName="comodityUniq" containerId="commodityContainer"
						textid="commodityText" selectedProperty="prodcriteria.commodity"
						containerVar="YAHOO.HEB.manageMain.commodityData"
						resetJSMethodName="YAHOO.HEB.manageMain.commodityReset"
						selectedValueId="commoditySelectedId" clearMethod="commodityClear"
						selectedValueName="commoditySelectedName" width="95%" onchangeMethod="commodityChange" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.a3" valueDisplay="false" tabIndex="2" emptyList="emptyCommodity">
					</cps:autoComplete> </td></tr>
			</table></td>
			<td align="right" width="13%"><label for="selectedChannel" class="labelFont">Sub Commodity </label></td>
			<td align="left" width="20%"><table width="100%">
				<tr>
					<td width="100%" align="left">
					<cps:autoComplete sourceList="subCommodities" compName="subComodityUniq" containerId="subCommodityContainer"
						textid="subCommodityText" selectedProperty="prodcriteria.subCommodity"
						containerVar="YAHOO.HEB.manageMain.subCommodityData"
						resetJSMethodName="YAHOO.HEB.manageMain.subCommodityReset"
						selectedValueId="subCommoditySelectedId" clearMethod="subCommodityClear"
						selectedValueName="subCommoditySelectedName" width="95%" onchangeMethod="subCommChange" index="1000"
						 reloadMethod="YAHOO.HEB.manageMain.a4" valueDisplay="false" tabIndex="3" emptyList="emptySubcommodity">
						</cps:autoComplete> 
					</td></tr>
			</table></td>	
		</tr>
		<tr>		
			<td align="right" width="13%"><label for="selectedChannel" class="labelFont">Class</label>
			</td>
			<td align="left" width="20%"><table width="100%">
				<tr>
					<td width="80%" align="left">
					<cps:autoComplete sourceList="classes" compName="classUniq" containerId="classContainer"
						textid="classDisplay" selectedProperty="prodcriteria.classField"
						containerVar="YAHOO.HEB.manageMain.classData"
						resetJSMethodName="YAHOO.HEB.manageMain.classReset"
						selectedValueId="classField" clearMethod="classClear"
						selectedValueName="classSelectedName" width="95%" onchangeMethod="classChange" index="1000"
						 reloadMethod="YAHOO.HEB.manageMain.a10" valueDisplay="false" tabIndex="4" emptyList="emptyclass">
						</cps:autoComplete> 
					<%-- 
					<html:text property="prodcriteria.classLabel" styleId="classDisplay" 
					style="width: 94%" styleClass="textFieldNormal" tabindex="4" onfocus="initValue();" onblur="copyValue();"></html:text>
					<html:hidden property="prodcriteria.classField" styleId="classField"/> --%>
					</td>
					</tr>
			</table></td>
			<td align="right" width="13%"  class="labelFont">Vendor Name/Number</td>
			<td align="left" width="20%">
				<form:input path="prodcriteria.vendorDescription" class="textFieldNormal" id="vendorField" maxlength="30" size="" tabindex="5" style="width:92%;margin-left:3px" onkeypress="sub();"/>			
			</td>
			<td align="right" width="13%" class="labelFont">
			</td>
			<td align="left" width="20%">
			</td>
		</tr>
			</table>

		<div id="searchAttr" style="display: none;position: relative;min-width: 0;">		
		<table width="100%" border="0">
		<tr>
			<td align="right" width="13%" class="labelFont">Product Type</td>
			<td align="left" width="20%">&nbsp;<form:select
			path="prodcriteria.productType" tabindex="7" id="productType" disabled="${mrtSwitchVar}"
			class="selectBoxStyle2">
				<form:options items="${manageProduct.productTypes}" itemLabel="name" itemValue="id" />
			</form:select>	</td>	
			<td align="right" width="12%"  class="labelFont"><label for="selectedChannel" class="labelFont helpable" id="defaultUPCLabelTop">UPC </label></td>
			<td align="left" width="11%">
				<div id="upcDefaultTop">
					<cps:renderByResourceAccess resourceId="145">
					<jsp:attribute name="EDIT">					
						<form:input path="prodcriteria.upc" class="textFieldMedium" maxlength="13" size=""
				tabindex="8" id="upc" onkeypress="sub();" style="margin-left:3px;" /> 
					</jsp:attribute>					
					</cps:renderByResourceAccess>
				</div>
			</td>
				<td align="right" width="13%"  class="labelFont">Cost Link</td>
			<td align="left" width="20%">&nbsp;<form:input path="prodcriteria.costLink" id="costField" class="textFieldMedium" maxlength="10" size="" 
				disabled="${mrtSwitchVar}" style="dataType : numeric;"
				tabindex="10" onkeypress="sub();"/></td>
		</tr>
		<tr>			
			<td align="right" width="13%"  class="labelFont">Retail Link
			</td>
			<td align="left" width="20%">&nbsp;<form:input path="prodcriteria.retailLink" id="retailField" style="width:59%;dataType : numeric" class="textFieldMedium" maxlength="7" size="" disabled="${mrtSwitchVar}"
				tabindex="11" onkeypress="sub();"/></td>
			<td align="right" width="13%"  class="labelFont">From Date
			</td>
			<td align="left" width="20%">&nbsp;<form:input path="prodcriteria.fromDate" class="textFieldMedium" maxlength="10" size=""
				tabindex="14" id="fromDate" onblur="validateDate(this);"/>
				<img src="${cal}"  id="calimg1"/>
			</td>
			<script type="text/javascript">
			    Calendar.setup({
			        inputField     :    "fromDate",     // id of the input field
			        ifFormat       :    "%m/%d/%Y",      // format of the input field
			        button         :    "calimg1",  // trigger for the calendar (button ID)
			        align          :    "T1",           // alignment (defaults to "Bl")
			        singleClick    :    true
			    });
			</script>
			<td align="right" width="13%"  class="labelFont">To Date
			</td>
			<td align="left" width="20%" colspan="2">&nbsp;<form:input path="prodcriteria.toDate" class="textFieldMedium" maxlength="10" size=""
				tabindex="15" id="toDate" onblur="validateDate(this);"/>
			<img src="${cal}"  id="calimg2"/>	
			</td>
			<script type="text/javascript">
			    Calendar.setup({
			        inputField     :    "toDate",     // id of the input field
			        ifFormat       :    "%m/%d/%Y",      // format of the input field
			        button         :    "calimg2",  // trigger for the calendar (button ID)
			        align          :    "T1",           // alignment (defaults to "Bl")
			        singleClick    :    true
			    });
			</script>		
		</tr>	
		</table></div>
	<table width="100%" border="0">
		<tr>
			<td width="13%" align="right" class="labelFont">
				<span id="caseUpcLbl" style="display:none">Case UPC</span>
			</td>
			<td width="20%" align="left">
				<div id="caseUpcTxt" style="display:none">&nbsp;				
						<form:input path="prodcriteria.caseUpc" class="textFieldMedium" maxlength="17" size=""
						tabindex="18" id="caseUpcField" onkeypress="sub();" style="dataType : numeric;width:59%;" /> 

				</div>
			</td>			
			<td align="right" width="13%"  class="labelFont">
				<label for="selectedChannel" class="labelFont helpable" id="defaultUPCLabel">UPC </label>
				<span id="productDesLabel"  style="display:none">
				<c:choose>
					<c:when test="${manageProduct.prodcriteria.mrtSwitchCheck}">
						<span id="ProdItemDescFldNm">Item Description</span>	
					</c:when>
					<c:otherwise>
						<span id="ProdItemDescFldNm">Product Description</span>	
					</c:otherwise>
				</c:choose>	
				</span>
			</td>
			<td align="left" width="13%">
				<div id="upcDefault">
					<cps:renderByResourceAccess resourceId="145">
					<jsp:attribute name="EDIT">					
						<input type="text" class="textFieldMedium" maxlength="13" size=""
				tabindex="8" id="defaultUpcValue" onkeypress="sub();" style="margin-left:3px" value="${manageProduct.prodcriteria.upc}" /> 
					</jsp:attribute>					
					</cps:renderByResourceAccess>
				</div>
				<span id="productDesTxt" style="display:none">
				<form:input path="prodcriteria.prodDescription" id="prodDescriptionField" class="textFieldNormal" maxlength="30" size="30"
				tabindex="9" onkeypress="sub();" style="margin-left:3px;" />
				</span>
			</td>	
			<td align="right" width="13%" class="labelFont"><span id="itemCodeLbl" style="display:none">&nbsp;&nbsp;Item Code</span></td>
			<td align="left" width="19%">
				<span id="itemCodeTxt" style="display:none"><form:input path="prodcriteria.itemCode" id="itemCodeField" class="textFieldMedium" maxlength="17" size="" 
					style="dataType : numeric;margin-left:3px;"
					tabindex="12" onkeypress="sub();"/></span>
			</td>		
		</tr> 
		<tr>
			<td colspan="4"></td>
			<td align="right" width="20%">
				<div style="position:relative;" id="link1">
				<a href="javascript:return false;" onclick="showAttributes(); return false;" id="hlink1" tabindex="16">Show Advanced Search</a></div>
				<div style="display: none;position: relative;" id="link2">
				<a href="javascript:return false;" onclick="showAttributes(); return false;" id="hlink2" tabindex="17">Hide Advanced Search</a></div>
			</td>				
			<td align="left" width="20%">
				<span style="margin-left:1px">
					<cps:renderByResourceAccess resourceId="238">
						<jsp:attribute name="EXEC">  
							<button type="button" id="searchProd" name="searchProd" value="Add" tabindex="18">Search</button>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<cps:renderByResourceAccess resourceId="239">
						<jsp:attribute name="EXEC">		
							<button type="button" id="clearSearch" name="clearSearch" value="Add" tabindex="19">Clear</button>		
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</span>
			</td>
		</tr>
	</table>
</div>
</fieldset>
<form:hidden path="prodcriteria.advancedSearch" id="isAdvanced"/>
<form:hidden path="prodcriteria.classLabel" id="classLabel"/>
</div>
<script type="text/javascript">

	

<cps:renderByResourceAccess resourceId="239">
<jsp:attribute name="EXEC">
    var clearButton = new YAHOO.widget.Button("clearSearch");
    </jsp:attribute>
    </cps:renderByResourceAccess>
    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("clearSearch"), "click", clearCandidate);

	<c:if test="${! manageProduct.validForResults}">
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("searchGo"), "click", search);
	</c:if>
	<cps:renderByResourceAccess resourceId="238">
	<jsp:attribute name="EXEC">
	var searchButton = new YAHOO.widget.Button("searchProd");
	 </jsp:attribute>
	    </cps:renderByResourceAccess>
	
	
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("searchProd"), "click", searchProduct);


	<cps:renderByResourceAccess resourceId="226">
	<jsp:attribute name="EDIT">
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("mrtSwitch"), "click", disableFields);
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	
	
<c:url value="/protected/cps/manage/searchProduct?${_csrf.parameterName}=${_csrf.token}" var="link1"></c:url>

function initAdvancedSearch(){
	if(YAHOO.util.Dom.get('isAdvanced').value == 'true'){
		showProductAttributes();		
	}
}

var classVal = null;
/*
function copyValue(){
	var afterVal = YAHOO.util.Dom.get('classDisplay').value;
	if(afterVal != classVal){
		YAHOO.util.Dom.get('classField').value = afterVal;
	}
}

function initValue(){
	classVal = YAHOO.util.Dom.get('classDisplay').value;
}
*/
initAdvancedSearch();

function classChange(evt){}

<c:url value="/protected/cps/manage/productFilterChangeClear?${_csrf.parameterName}=${_csrf.token}" var="linkClear"></c:url>
function filterChangeClear(){
	var formObject = YAHOO.util.Dom.get('searchForm');
	formObject.action = "${linkClear}";
	//hideTable();
	//hideBorder('f1','hide');
	YAHOO.util.Connect.setForm(formObject); 
	
	var callback = {
		success:function(o){
			hideProgress();
			try{
				YAHOO.util.Dom.get('results').innerHTML = o.responseText;
				document.getElementById('errors').innerHTML='<ul>'+handleMessageFilter(document.getElementById('msgError').value,document.getElementById('msgIndex').value)+'</ul>';
			}catch(err){}
		}
	};
	YAHOO.util.Dom.get('results').innerHTML = tempHtml1;
	showProgress();
	var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
	
	//to clear selected checkboxes on filter
	YAHOO.util.Dom.get('checkAll').checked = false;
}

function clearCandidate(evt){
	YAHOO.util.Dom.get('results').innerHTML = "";
			clearErrors();
			bdmClear();
            commodityClear();
            subCommodityClear();
            emptyCommodity();
            emptySubcommodity();
			var defaultUpcValue = YAHOO.util.Dom.get("defaultUpcValue");
			if(defaultUpcValue) {
				defaultUpcValue.value='';
			}
			var upc = YAHOO.util.Dom.get("upc");
			if(upc) {
				upc.value='';
			}
            YAHOO.util.Dom.get('classDisplay').value = '';
            YAHOO.util.Dom.get('classField').value = '';
            YAHOO.util.Dom.get('vendorField').value = '';
            YAHOO.util.Dom.get('productType').value = '';
            YAHOO.util.Dom.get('prodDescriptionField').value = '';
            YAHOO.util.Dom.get('costField').value = '';
            YAHOO.util.Dom.get('retailField').value = '';
            YAHOO.util.Dom.get('fromDate').value = '';
            YAHOO.util.Dom.get('toDate').value = '';
			YAHOO.util.Dom.get('itemCodeField').value='';		
			YAHOO.util.Dom.get('caseUpcField').value='';
        	<cps:renderByResourceAccess resourceId="226">
        	<jsp:attribute name="EDIT">
            document.getElementById('mrtSwitch').checked = false;
        	</jsp:attribute>					
        	</cps:renderByResourceAccess>
        	filterChangeClear();
          }
var link1Clicked = false;
function searchProduct(evt){
	if (!validateMRTSearch()) {
		return false;
	}
	/*
	 *set value of bdm combo-box into attribute of CandidateSearchCriteria
	 *@author khoapkl
	 */
	var defaultUpcValue = YAHOO.util.Dom.get("defaultUpcValue");
	var upc=YAHOO.util.Dom.get("upc");
	var link1Attr = YAHOO.util.Dom.get("link1");
	if(defaultUpcValue!=null) {
		if(upc!=null) {
			//update value in upc of advanced search when user typed value in Upc of Basic Search
			if(link1Attr) {
				if(link1Attr.style.display=='block' || link1Attr.style.display=='') {
					upc.value=defaultUpcValue.value;
				} 
			}
		}
	}
	var formObject = YAHOO.util.Dom.get('searchForm');
	YAHOO.util.Dom.get("classLabel").value = YAHOO.util.Dom.get("classDisplay").value;
	formObject.action = '${link1}';
	formObject.submit();

}
onload()
function onload(){
	var link1Attr = YAHOO.util.Dom.get("link1");
	var defaultUPCLabel = YAHOO.util.Dom.get("defaultUPCLabel");	
	var defaultUPCLabelTop = YAHOO.util.Dom.get("defaultUPCLabelTop");
	var upcDefault = YAHOO.util.Dom.get("upcDefault");
	var productDesLabel= YAHOO.util.Dom.get("productDesLabel");
	var productDesTxt= YAHOO.util.Dom.get("productDesTxt");
	var itemCodeLbl = YAHOO.util.Dom.get("itemCodeLbl");
	var itemCodeTxt = YAHOO.util.Dom.get("itemCodeTxt");
	var caseUpcLbl = YAHOO.util.Dom.get("caseUpcLbl");
	var caseUpcTxt = YAHOO.util.Dom.get("caseUpcTxt");
	//keep Product Description when user show all attributes and then clicking on Search button
	if(link1Attr) {
		if(link1Attr.style.display=='none') {
			if(productDesLabel) {
				productDesLabel.style.display='';
			}
			if(productDesTxt) {
				productDesTxt.style.display='';
			}
			//hide upc label & textbox
			if(defaultUPCLabel) {
				defaultUPCLabel.style.display='none';
			}
			if(upcDefault) {
				upcDefault.style.display='none';
			}
			//keep item code,caseUPC after search
			itemCodeLbl.style.display = '';
			itemCodeTxt.style.display = '';
			caseUpcLbl.style.display = '';
			caseUpcTxt.style.display = '';	
		} 
	}
	if(YAHOO.util.Dom.get("screenLabel")!=null) {
		document.getElementById("screenLabel").className='screenName-Search';
	}
	if (YAHOO.util.Dom.get("classDisplay") && YAHOO.util.Dom.get("classLabel")) {
		YAHOO.util.Dom.get("classDisplay").value = YAHOO.util.Dom.get("classLabel").value;
	}
}
function toBeUsedLater(evt){
		<c:url value="${request.getContextPath()}/hebAssets/images/loading.gif" var="loading" />
		var loadingUrl = '${loading}';
		var tmpHtml = "<br><br><br><table width='100%'><tr><td align='center'><img src='"+loadingUrl+"'  align='middle'/></td></tr></table><br><br><br>"
		var formObject = YAHOO.util.Dom.get('searchForm');
		formObject.action = "${link}";
		hideTable();
		hideBorder('f1','hide');
		YAHOO.util.Connect.setForm(formObject); 
		
		var callback = {
			success:function(o){
				hideProgress();
				YAHOO.util.Dom.get('results').innerHTML = o.responseText;
				d1 = 'no';
			}
		};
		showProgress();
		YAHOO.util.Dom.get('results').innerHTML = tmpHtml;
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
		
}

<c:url value="/protected/cps/manage/performSearch?${_csrf.parameterName}=${_csrf.token}" var="link"></c:url>

function search(evt){
	document.searchForm.action = "${link}";
	document.searchForm.submit();
}

	
	function bdmChange(evt){
		var bdm = YAHOO.util.Dom.get("bdmSelectedId");
		var bdmVal = bdm.value;
		YAHOO.util.Dom.get("commodityText").value = "";
		YAHOO.util.Dom.get("subCommodityText").value = "";
		YAHOO.util.Dom.get("classField").value = "";
		YAHOO.util.Dom.get("classDisplay").value = "";
		showProgress();
		ProductDWR.getCommoditiesFromBDM(bdmVal, getDWRCallbackMethod(updateComms));
	}
	function commodityChange(evt){
		var bdm = YAHOO.util.Dom.get("bdmSelectedId");
		var comm = YAHOO.util.Dom.get("commoditySelectedId");
		YAHOO.util.Dom.get("subCommodityText").value = "";
		YAHOO.util.Dom.get("classField").value = "";
		showProgress();
		ProductDWR.getClassForCommodity(comm.value, getDWRCallbackMethod(updateClass));
	}
	function subCommChange(){
		//do nothing
	}
	function updateClass(data){
		YAHOO.log("UPDATE CLASS");
		var comm = YAHOO.util.Dom.get("commoditySelectedId");
		YAHOO.util.Dom.get("classDisplay").value = ''+data.name+' ['+data.id+']';
		YAHOO.util.Dom.get("classField").value = data.id;
		ProductDWR.getSubCommodityForClassCommodity(data.id,comm.value,getDWRCallbackMethod(updateSubComm));
	}
	function updateComms(data){ 
		YAHOO.log("UPDATE COMMS");
		hideProgress();
		if(data.length==0){
			alert("No Commodities Found");			
		}
		YAHOO.HEB.manageMain.commodityReset(data);
	}
	function updateSubComm(data){
		YAHOO.log("UPDATE SUB COMM");
		hideProgress();
		YAHOO.HEB.manageMain.subCommodityReset(data);		
	}

function sub(){
	var key = window.event.keyCode;
	if(key == 13){
	searchProduct();
	}
}

function disableFields(evt) {
	var mrtSwtch 			= YAHOO.util.Dom.get("mrtSwitch");
	var retailFld 			= YAHOO.util.Dom.get("retailField");
	var costFld 			= YAHOO.util.Dom.get("costField");
	var productTypeFld 		= YAHOO.util.Dom.get("productType");
	var prodItemDescFld 	= YAHOO.util.Dom.get("ProdItemDescFldNm");

	if(mrtSwtch.checked == true){
		retailFld.value				= "";
		retailFld.disabled			= true;
		costFld.value				= "";
		costFld.disabled			= true;
		productTypeFld.value 		= "";
		productTypeFld.disabled 	= true;
		prodItemDescFld.innerHTML	= 'Item Description';
	}else if(mrtSwtch.checked == false){
		retailFld.disabled			= false;
		costFld.disabled			= false;
		productTypeFld.disabled 	= false;
		prodItemDescFld.innerHTML	= 'Product Description';
	}
}

function validateMRTSearch() {
	var mrtSwtch	= YAHOO.util.Dom.get("mrtSwitch");
	if (!mrtSwtch.checked) {
		return true;
	}
	var bdm = YAHOO.util.Dom.get("bdmSelectedId");
	var bdmVal = bdm.value;
	return true;
}
</script>
</body>