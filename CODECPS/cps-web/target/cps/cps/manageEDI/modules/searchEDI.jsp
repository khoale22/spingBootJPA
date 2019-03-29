<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.List"%>
<%@ page import="com.heb.operations.cps.model.ManageEDICandidate" %>
<base ref="site" />
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

<%--<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/hebAssets/calendar/calendar_blue.css'></html:rewrite>" title="calBlue"/>--%>
<link rel="stylesheet"  type="text/css" media="all" href="<spring:url value='/hebAssets/calendar/calendar_blue.css'></spring:url>" type="text/css" title="calBlue"/>

<div id="formCont1" style="position: relative;min-width: 0;">
<%
	/*
	 This form will be submitted to the 'prodInfo' method of the class:
	 */
%> 
<script type="text/Javascript">

checkFinalInputDisable();

var visi = "v";
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
	document.getElementById(id).className = classname;
}
var tempHtml;

<c:url var="colspd" value="${request.getContextPath()}/hebAssets/images/collapsed.gif"></c:url>
<c:url var="expnd" value="${request.getContextPath()}/hebAssets/images/expanded.gif"></c:url>
function hideTable(){
if(visi == "v"){
	document.getElementById('caseDiv').style.display = 'none';
	document.getElementById('caseImg').src = "${colspd}";
	visi = "h";
}
}
function showTable(){
if(visi == "h"){
	
	document.getElementById('caseDiv').style.display = 'block';
	document.getElementById('caseImg').src = "${expnd}";
	visi = "v";
}
}
</script>
	<%
		ManageEDICandidate manageEDICandidate = (ManageEDICandidate) request.getAttribute("manageEDICandidate");
		request.setAttribute("bdms",manageEDICandidate.getBdms());
		request.setAttribute("commodities",manageEDICandidate.getCommodities());
		request.setAttribute("subCommodities",manageEDICandidate.getSubCommodities());
		request.setAttribute("classes",manageEDICandidate.getClasses());
	%>
<fieldset id="f1" style="margin-left: 6px; background-color: #FFFFFF; margin-right: 6px; padding-bottom: 3px;
		padding-top: 2px; width: 98%; color: #000000;position: relative;z-index: 9000;">
		<legend onclick="toggle('f1');" style="cursor: pointer; color: #666666">

	<img src="${expnd}" id="caseImg"/> <b>Search Criteria</b> </legend>

<div id="caseDiv" style="position: relative;min-width: 0;">
	<table width="100%" border="0">
		<tr>
			<td align="right" width="13%"><label for="selectedChannel" class="labelFont helpable" id="BDMLabel">BDM</label></td>
			<td align="left" width="20%">			<table width="100%" border="0">
				<tr>
					<td width="100%" align="left">
					<cps:renderByResourceAccess resourceId="139">
						<jsp:attribute name="EDIT">
							<cps:autoComplete sourceList="bdms" compName="bdmUniq" containerId="bdmContainer" textid="bdmText"
							selectedProperty="candidateEDISearchCriteria.bdm" containerVar="YAHOO.HEB.manageMain.bdmData"
							resetJSMethodName="YAHOO.HEB.manageMain.bdmReset" selectedValueId="bdmSelectedId" clearMethod="bdmClear"
							selectedValueName="bdmSelectedName" width="95%" onchangeMethod="bdmChange" index="9000" reloadMethod="YAHOO.HEB.manageMain.a2"
							emptyList="emptyBdm" valueDisplay="false" tabIndex="1">
							</cps:autoComplete>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
					</tr>
			</table>
			</td>
			<td align="right" width="13%"><label for="selectedChannel" class="labelFont helpable" id="CommodityLabel">Commodity</label>
			</td>
			<td align="left" width="20%"><table width="100%">
				<tr>
					<td width="100%" align="left">
					<cps:renderByResourceAccess resourceId="232">
						<jsp:attribute name="EDIT">
							<cps:autoComplete sourceList="commodities" compName="comodityUniq" containerId="commodityContainer"
								textid="commodityText" selectedProperty="candidateEDISearchCriteria.commodity"
								containerVar="YAHOO.HEB.manageMain.commodityData"
								resetJSMethodName="YAHOO.HEB.manageMain.commodityReset"
								selectedValueId="commoditySelectedId" clearMethod="commodityClear"
								selectedValueName="commoditySelectedName" width="95%" onchangeMethod="commodityChange" index="9000"
								 reloadMethod="YAHOO.HEB.manageMain.a3" valueDisplay="false" tabIndex="2" emptyList="emptyCommodity">
							</cps:autoComplete>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					</td></tr>
			</table></td>
			<td align="right" width="13%"><label for="selectedChannel" class="labelFont helpable" id="SubComLabel">Sub Commodity</label></td>
			<td align="left" width="20%"><table width="100%">
				<tr>
					<td width="100%" align="left">
					<cps:renderByResourceAccess resourceId="141">
						<jsp:attribute name="EDIT">
							<cps:autoComplete sourceList="subCommodities" compName="subComodityUniq" containerId="subCommodityContainer"
								textid="subCommodityText" selectedProperty="candidateEDISearchCriteria.subCommodity"
								containerVar="YAHOO.HEB.manageMain.subCommodityData"
								resetJSMethodName="YAHOO.HEB.manageMain.subCommodityReset"
								selectedValueId="subCommoditySelectedId" clearMethod="subCommodityClear"
								selectedValueName="subCommoditySelectedName" width="95%" onchangeMethod="subCommChange" index="1000"
								 reloadMethod="YAHOO.HEB.manageMain.a4" valueDisplay="false" tabIndex="3" emptyList="emptySubcommodity">
							</cps:autoComplete>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					</td></tr>
			</table></td>
		</tr>
		<tr>
			<td align="right" width="13%"><label for="selectedChannel" class="labelFont helpable" id="ClassLabel">Class</label>
			</td>
			<td align="left" width="20%"><table width="100%">
				<tr>
					<td width="80%" align="left">
					<cps:renderByResourceAccess resourceId="142">
					<jsp:attribute name="EDIT">
					<cps:autoComplete sourceList="classes" compName="classUniq" containerId="classContainer"
						textid="classDisplay" selectedProperty="candidateEDISearchCriteria.classField"
						containerVar="YAHOO.HEB.manageMain.classData"
						resetJSMethodName="YAHOO.HEB.manageMain.classReset"
						selectedValueId="classField" clearMethod="classClear"
						selectedValueName="classSelectedName" width="95%" onchangeMethod="classChange" index="1000"
						 reloadMethod="YAHOO.HEB.manageMain.a10" valueDisplay="false" tabIndex="4" emptyList="emptyclass">
						</cps:autoComplete>
					</jsp:attribute>
					</cps:renderByResourceAccess>
					</td>
					</tr>
			</table></td>
			<td align="right" width="13%"  class="labelFont"><label for="selectedChannel" class="labelFont helpable" id="VendorLabel">Vendor Name/Number</label></td>
			<td align="left" width="20%">
				<cps:renderByResourceAccess resourceId="225">
				<jsp:attribute name="EDIT">
				<form:input path="candidateEDISearchCriteria.vendorDescription" cssClass="textFieldMedium" id="vendorField" maxlength="30" size="" tabindex="5" cssStyle="width:90%;margin-left:3px"/>
				</jsp:attribute>
				</cps:renderByResourceAccess>


			</td>

			<td align="right" width="13%" class="labelFont">
			<label for="selectedChannel" class="labelFont helpable" id="dataSourceLabel">
			Data Source</label></td>

			<td align="left" width="20%">
				<form:select path="candidateEDISearchCriteria.dataSourse" id="dataSourseSelect" cssClass="selectBoxStyle2" tabindex="12" cssStyle="margin-left:3px">
					<form:options items="${manageEDICandidate.allDataSource}" itemLabel="name" itemValue="id" />
				</form:select>
			</td>
		</tr>
			</table>

		<div id="searchAttr" style="display: none;position: relative;min-width: 0;">
		<table width="100%" border="0" bordercolor="cyan">
		<tr>
			<td align="right" width="13%"  class="labelFont"><label for="actionLabel" class="labelFont helpable" id="actionLabel">Action</label></td>
			<td align="left" width="20%">
				<form:select path="candidateEDISearchCriteria.actionId" id="actionSelect" cssClass="selectBoxStyle2" tabindex="12" cssStyle="margin-left:3px">
					<form:options items="${manageEDICandidate.allAction}" itemLabel="name" itemValue="id" />
				</form:select>
			</td>
			<td align="right" width="13%"  class="labelFont"><label for="selectedChannel" class="labelFont helpable" id="UPCLabel">UPC </label></td>
			<td align="left" width="20%">
			<cps:renderByResourceAccess resourceId="145">
			<jsp:attribute name="EDIT">
				<form:input path="candidateEDISearchCriteria.upc" cssClass="textFieldMedium" maxlength="13" size=""
					tabindex="8" id="upc" cssStyle="dataType : numeric;margin-left:3px;"/>
			</jsp:attribute>
			</cps:renderByResourceAccess> </td>
			<td align="right" width="13%"  class="labelFont"><label for="selectedChannel" class="labelFont helpable" id="ProductDescriptionLabel">Product Description</label></td>
			<td align="left" width="20%">
			<cps:renderByResourceAccess resourceId="146">
			<jsp:attribute name="EDIT"><form:input path="candidateEDISearchCriteria.prodDescription" id="prodDescriptionField" cssClass="textFieldNormal" maxlength="30" size="30"
				tabindex="9" onkeypress="sub();" cssStyle="margin-left:3px"/>
			</jsp:attribute>
			</cps:renderByResourceAccess></td>
		</tr>
		<tr>
			<td align="right" width="13%" class="labelFont"><label for="selectedChannel" class="labelFont helpable" id="ProductLabel">Product Type</label></td>
			<td align="left" width="20%">
			<cps:renderByResourceAccess resourceId="144">
			<jsp:attribute name="EDIT"><form:select
			path="candidateEDISearchCriteria.productType" tabindex="7" id="productType"
			cssClass="selectBoxStyle2" cssStyle="margin-left:3px">
				<form:options items="${manageEDICandidate.productTypes}" itemLabel="name"
					itemValue="id" />
			</form:select>
			</jsp:attribute>
			</cps:renderByResourceAccess>
			</td>
			<td align="right" width="13%"  class="labelFont">
			<cps:renderByResourceAccess resourceId="209">
				<jsp:attribute name="EDIT">
				<label for="selectedChannel" class="labelFont helpable" id="RetailLinkLabel">Retail Link</label>
				</jsp:attribute>
			</cps:renderByResourceAccess>
			</td>
			<td align="left" width="20%">
			<cps:renderByResourceAccess resourceId="209">
				<jsp:attribute name="EDIT">
			<form:input path="candidateEDISearchCriteria.retailLink" id="retailField" cssClass="textFieldMedium" maxlength="10" size=""
				tabindex="11" cssStyle="dataType : numeric;margin-left:3px"/>
				</jsp:attribute>
			</cps:renderByResourceAccess>
				</td>
			<td align="right" width="13%"  class="labelFont"><label for="selectedChannel" class="labelFont helpable" id="StatusLabel">Status</label></td>
			<td align="left" width="20%">
			<cps:renderByResourceAccess resourceId="149">
			<jsp:attribute name="EDIT">
			<form:select path="candidateEDISearchCriteria.status" id="StatusSelect" cssClass="selectBoxStyle2" tabindex="12" cssStyle="margin-left:3px">
				<form:option value="">--Select--</form:option>
				<form:options items="${manageEDICandidate.allStatus}" itemLabel="name" itemValue="id" />
			</form:select>
			</jsp:attribute>
			</cps:renderByResourceAccess></td>
		</tr>
		<tr>
			<td align="right" width="13%"  class="labelFont"><label for="selectedChannel" class="labelFont helpable" id="CostLinkLabel">Cost Link</label></td>
			<td align="left" width="20%">
			<cps:renderByResourceAccess resourceId="147">
			<jsp:attribute name="EDIT">
			<form:input path="candidateEDISearchCriteria.costLink" id="costField" cssClass="textFieldMedium" maxlength="10" size=""
				tabindex="10" cssStyle="dataType : numeric;margin-left:3px;width:59%"/>
			</jsp:attribute>
			</cps:renderByResourceAccess></td>
			<td align="right" width="13%"  class="labelFont"><label for="selectedChannel" class="labelFont helpable" id="FromDateLabel">From Date</label>
			</td>
			<td align="left" width="20%">
			<cps:renderByResourceAccess resourceId="151">
			<jsp:attribute name="EDIT">
			<form:input path="candidateEDISearchCriteria.fromDate" cssClass="textFieldMedium" maxlength="10" size=""
				tabindex="14" id="fromDate" onblur="validateDate(this);" cssStyle="margin-left:3px" />
				<%--<html:img src="${cal}"  styleId="calimg1"/>--%>
				<img src="${cal}"  id="calimg1"/>
			</jsp:attribute>
			</cps:renderByResourceAccess>
			</td>
			<cps:renderByResourceAccess resourceId="151">
			<jsp:attribute name="EDIT">
			<script type="text/javascript">
			    Calendar.setup({
			        inputField     :    "fromDate",     // id of the input field
			        ifFormat       :    "%m/%d/%Y",      // format of the input field
			        button         :    "calimg1",  // trigger for the calendar (button ID)
			        align          :    "T1",           // alignment (defaults to "Bl")
			        singleClick    :    true
			    });
			</script>
			</jsp:attribute>
			</cps:renderByResourceAccess>
			<td align="right" width="13%"  class="labelFont"><label for="selectedChannel" class="labelFont helpable" id="ToDateLabel">To Date</label>
			</td>
			<td align="left" width="20%" colspan="2">
			<cps:renderByResourceAccess resourceId="152">
			<jsp:attribute name="EDIT"><form:input path="candidateEDISearchCriteria.toDate" cssClass="textFieldMedium" maxlength="10" size=""
				tabindex="15" id="toDate" onblur="validateDate(this);" cssStyle="margin-left:3px"/>
			<%--<html:img src="${cal}"  styleId="calimg2"/>	--%>
				<img src="${cal}"  id="calimg2"/>
			</jsp:attribute>
			</cps:renderByResourceAccess>
			</td>
			<cps:renderByResourceAccess resourceId="152">
			<jsp:attribute name="EDIT">
			<script type="text/javascript">
			    Calendar.setup({
			        inputField     :    "toDate",     // id of the input field
			        ifFormat       :    "%m/%d/%Y",      // format of the input field
			        button         :    "calimg2",  // trigger for the calendar (button ID)
			        align          :    "T1",           // alignment (defaults to "Bl")
			        singleClick    :    true
			    });
			</script>
			</jsp:attribute>
			</cps:renderByResourceAccess>
		</tr>
		<tr>
			<td align="right" width="13%"  class="labelFont"><label for="selectedChannel" class="labelFont helpable" id="TestScanLabel">Test Scan Status</label></td>
			<td align="left" width="20%">
			<cps:renderByResourceAccess resourceId="155">
			<jsp:attribute name="EDIT"><form:select path="candidateEDISearchCriteria.testScanStatus" id="sourceSelect" cssClass="selectBoxStyle3" tabindex="13" cssStyle="margin-left:3px;width:62%">
				<form:option value="">--Select--</form:option>
				<form:options items="${manageEDICandidate.testScans}" itemLabel="name" itemValue="id" />
			</form:select>
			</jsp:attribute>
			</cps:renderByResourceAccess></td>
			<td align="right" width="13%" class="labelFont">Tracking Number</td>
			<td align="left" width="20%">&nbsp;<form:input path="candidateEDISearchCriteria.batchId" cssClass="textFieldMedium" maxlength="13" size=""
						tabindex="18" id="batchId" cssStyle="dataType : numeric;width:59%"/>
			</td>
		</tr>
		</table>
		</div>
	<table width="100%" border="0" bordercolor="orange">
		<tr>
			<td align="right" width="13%"  class="labelFont"><label for="defaultActionLabel" class="labelFont helpable" id="defaultActionLabel">Action</label></td>
			<td align="left" width="20%">
				<div id="actionSelectDefault">
					<%--<form:select path="candidateEDISearchCriteria.actionId" id="defaultActionSelect" cssClass="selectBoxStyle2" tabindex="12" cssStyle="margin-left:3px">--%>
						<%--<form:options items="${manageEDICandidate.allAction}" itemLabel="name" itemValue="id" />--%>
					<%--</form:select>--%>
					<select id="defaultActionSelect" cssClass="selectBoxStyle2" tabindex="12" cssStyle="margin-left:3px">
						<c:forEach items="${manageEDICandidate.allAction}" var="action">
							<option value="${action.id}" ${action.id == manageEDICandidate.candidateEDISearchCriteria.actionId ? 'selected' : ''}>
									${action.name}
							</option>
						</c:forEach>
					</select>
				</div>
			</td>
			<td align="right" width="13%"  class="labelFont"><label for="selectedChannel" class="labelFont helpable" id="defaultUPCLabel">UPC </label></td>
			<td align="left" width="20%">
				<div id="upcDefault">
					<cps:renderByResourceAccess resourceId="145">
					<jsp:attribute name="EDIT"><input class="textFieldMedium" maxlength="13" size="" value="${manageEDICandidate.candidateEDISearchCriteria.upc}"
														  tabindex="8" id="defaultUpcValue" style="margin-left:3px"/>
					</jsp:attribute>
					</cps:renderByResourceAccess>
				</div>
			</td>
			<td align="left" width="13%">
				<div style="position:relative;" id="link1">
					<a href="javascript:return false;" onclick="showAttributes();return false;" id="hlink1" tabindex="16">Show Advanced Search</a></div>
				<div style="display: none;position: relative;" id="link2">
					<a href="javascript:return false;" onclick="showAttributes();return false;" id="hlink2" tabindex="17">Hide Advanced Search</a></div>
			</td>
			<td width="20%">
				<div id="searchButtonDiv">
				<span>
				<cps:renderByResourceAccess
						resourceId="238">
					<jsp:attribute name="EXEC">
		     		<button type="button" id="searchCand" name="searchCand"
							value="Add" tabindex="18">Search</button>
		     	</jsp:attribute>
				</cps:renderByResourceAccess>
				<cps:renderByResourceAccess	resourceId="239">
					<jsp:attribute name="EXEC">
		     		<button type="button" id="clearSearch" name="clearSearch" value="Add"
							tabindex="19">Clear</button>
		     	</jsp:attribute>
				</cps:renderByResourceAccess>
				</span>
				</div>
				<div id="modifyButtonDiv" style="visibility: hidden; position: absolute;">
					<cps:renderByResourceAccess
							resourceId="238">
			<jsp:attribute name="EXEC">
     		<button type="button" id="modifySearch" name="modifySearch"
					value="Modify" tabindex="18">Modify</button>
     		</jsp:attribute>
					</cps:renderByResourceAccess>
				</div>
			</td>
		</tr>
	</table>
</div>
</fieldset>
<form:hidden path="candidateEDISearchCriteria.bdmValue" id="bdmValue"/>
<form:hidden path="candidateEDISearchCriteria.advancedSearch" id="isAdvanced"/>
</div>
<script type="text/javascript">

	
<cps:renderByResourceAccess resourceId="239">
<jsp:attribute name="EXEC">
    var clearButton = new YAHOO.widget.Button("clearSearch");   
    </jsp:attribute>
    </cps:renderByResourceAccess>
    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("clearSearch"), "click", clearCandidate);    

	<cps:renderByResourceAccess resourceId="238">
	<jsp:attribute name="EXEC">
	var searchButton = new YAHOO.widget.Button("searchCand");
	 </jsp:attribute>
	    </cps:renderByResourceAccess>
	var modifybutton = new YAHOO.widget.Button("modifySearch");
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifySearch"), "click", modifySearchResult);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("searchCand"), "click", searchCandidate);
	
<c:url value="/protected/cps/manageEDI/searchEDICandidate?${_csrf.parameterName}=${_csrf.token}" var="link"></c:url>

function initAdvancedSearch(){
	if(document.getElementById('isAdvanced').value == 'true'){
		showAttributes();		
	}
}


var classVal = null;
/*
function copyValue(){
	var afterVal = document.getElementById('classDisplay').value;
	if(afterVal != classVal){
		document.getElementById('classField').value = afterVal;
	}
}

function initValue(){
	classVal = document.getElementById('classDisplay').value;
}
*/

initAdvancedSearch();

function clearCandidate(evt){	
	ManageEDIDWR.clearSearchResults(getDWRCallbackMethod(clearCallBack));
}
function classChange(evt){
}

function clearCallBack(callBackData){		
	var defaultUpcValue = YAHOO.util.Dom.get("defaultUpcValue");
	if(defaultUpcValue!=null) {
		defaultUpcValue.value='';
	}	
	if(document.getElementById('contentAfterSearchDiv')){
		document.getElementById('contentAfterSearchDiv').innerHTML = "";	
	}
	clearErrors();
	showProgress();
	subCommodityChanged=false;	
	<cps:renderByResourceAccess resourceId="139">
	<jsp:attribute name="EDIT">
	//@author khoapkl
	ManageEDIDWR.getAllBDMs(getDWRCallbackMethod(updateBdm));
	bdmClear();	
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	//@author khoapkl
	ManageEDIDWR.getAllCommodities(getDWRCallbackMethod(updateComms));
    commodityClear();
	<cps:renderByResourceAccess resourceId="142">
	<jsp:attribute name="EDIT">
    //document.getElementById('classDisplay').value = '';
    //document.getElementById('classField').value = '';
    ManageEDIDWR.getAllClasses(getDWRCallbackMethod(updateClasses));
    classClear();
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	<cps:renderByResourceAccess resourceId="141">
	<jsp:attribute name="EDIT">
	//@author khoapkl
	ManageEDIDWR.getAllSubCommodities(getDWRCallbackMethod(updateSubComm));
    subCommodityClear();
	</jsp:attribute>					
	</cps:renderByResourceAccess>
   //emptyCommodity();
	<cps:renderByResourceAccess resourceId="141">
	<jsp:attribute name="EDIT">
   //emptySubcommodity();
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	<cps:renderByResourceAccess resourceId="225">
	<jsp:attribute name="EDIT">
    document.getElementById('vendorField').value = '';
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	<cps:renderByResourceAccess resourceId="144">
	<jsp:attribute name="EDIT">
    document.getElementById('productType').value = '';
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	<cps:renderByResourceAccess resourceId="145">
	<jsp:attribute name="EDIT">
    document.getElementById('upc').value = '';
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	<cps:renderByResourceAccess resourceId="146">
	<jsp:attribute name="EDIT">
    document.getElementById('prodDescriptionField').value = '';
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	<cps:renderByResourceAccess resourceId="147">
	<jsp:attribute name="EDIT">
    document.getElementById('costField').value = '';
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	<cps:renderByResourceAccess resourceId="149">
	<jsp:attribute name="EDIT">
    document.getElementById('StatusSelect').value = '';
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	<cps:renderByResourceAccess resourceId="155">
	<jsp:attribute name="EDIT">
    document.getElementById('sourceSelect').value = '';
    document.getElementById('sourceSelect').disabled=false;
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	<cps:renderByResourceAccess resourceId="151">
	<jsp:attribute name="EDIT">
    document.getElementById('fromDate').value = '';
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	<cps:renderByResourceAccess resourceId="152">
	<jsp:attribute name="EDIT">
    document.getElementById('toDate').value = '';
	</jsp:attribute>					
	</cps:renderByResourceAccess>
	<cps:renderByResourceAccess resourceId="226">						
	</cps:renderByResourceAccess>
    
	<cps:renderByResourceAccess resourceId="209">
	<jsp:attribute name="EDIT">
    if(document.getElementById('retailField')){
    	document.getElementById('retailField').value = '';
    }
	</jsp:attribute>					
	</cps:renderByResourceAccess>	
	document.getElementById('batchId').value='';
	var actionSelect = document.getElementById("actionSelect");
	var defaultActionSelect = document.getElementById("defaultActionSelect");
	if(actionSelect!=null) {
		actionSelect.value='1';
	}	
	if(defaultActionSelect!=null) {
		defaultActionSelect.value='1';
	}	
	var dataSourseSelect = document.getElementById("dataSourseSelect");
	if(dataSourseSelect!=null) {
		dataSourseSelect.value='0';
	}	
}

onload();

function onload(){
	/*
	 *after search, system will keep value of bdm
	 *@author khoapkl
	 */
	 if(document.getElementById("bdmText") && document.getElementById("bdmValue")){
		YAHOO.util.Dom.get("bdmText").value=YAHOO.util.Dom.get("bdmValue").value;
	 }
	if(YAHOO.util.Dom.get("screenLabel")!=null) {
		document.getElementById("screenLabel").className='screenName-Search';
	}
	disableSearchAtr();	
	
	
}
function searchCandidate(evt){	
	/*
	 *set value of bdm combo-box into attribute of CandidateSearchcandidateEDISearchCriteria
	 *@author khoapkl
	 */
	var defaultUpcValue = YAHOO.util.Dom.get("defaultUpcValue");
	var defaultActionSelect = YAHOO.util.Dom.get("defaultActionSelect");
	var actionSelect = YAHOO.util.Dom.get("actionSelect");	
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
	if(defaultActionSelect!=null) {
		if(actionSelect!=null) {			
			//update value in upc of advanced search when user typed value in Upc of Basic Search
			if(link1Attr) {
				if(link1Attr.style.display=='block' || link1Attr.style.display=='') {
					actionSelect.value=defaultActionSelect.value;
				} 
			}
		}
	}
	YAHOO.util.Dom.get("bdmValue").value=YAHOO.util.Dom.get("bdmText").value;
	document.forms[0].action = '${link}';
	document.forms[0].submit();
}
<c:url value="/protected/cps/manageEDI/modifySeach?${_csrf.parameterName}=${_csrf.token}" var="modifySearch"></c:url>
function modifySearchResult(evt){		

	var isEmptyFlag="${empty ManageEDICandidate.ediSearchResultVOLst}";

	isEmptyFlag+="";
	if(isEmptyFlag == "false"){
		if(checkDataChangeForAllTab().length > 0)
		{

			var message = confirm('Do you want to save the changes?');
			var modify=false;
			if(message){
				<c:if test="${ManageEDICandidate.candidateEDISearchCriteria.actionId != '4'}">
						doLoadTabData(7);
				</c:if>
				<c:if test="${ManageEDICandidate.candidateEDISearchCriteria.actionId == '4'}">
						modifySearchForDsdDiscontinue();
				</c:if>
			}
			else
			{
				document.forms["searchForm"].action = "${modifySearch}";
				document.forms["searchForm"].submit();
			}
		}
		else
		{
			document.forms["searchForm"].action = "${modifySearch}";
			document.forms["searchForm"].submit();
		}
	}
	else
	{
		document.forms["searchForm"].action = "${modifySearch}";
			document.forms["searchForm"].submit();
	}
}

	
	function bdmChange(evt){		
		var bdm = YAHOO.util.Dom.get("bdmSelectedId");
		var bdmVal = bdm.value;
		//YAHOO.util.Dom.get("commodityText").value = "";
		<cps:renderByResourceAccess resourceId="141">
		<jsp:attribute name="EDIT">
		//YAHOO.util.Dom.get("subCommodityText").value = "";
		</jsp:attribute>					
		</cps:renderByResourceAccess>
		<cps:renderByResourceAccess resourceId="142">
		<jsp:attribute name="EDIT">
		//YAHOO.util.Dom.get("classField").value = "";
		//YAHOO.util.Dom.get("classDisplay").value = "";
		//classClear();
		</jsp:attribute>					
		</cps:renderByResourceAccess>
		showProgress();
		ManageEDIDWR.getCommoditiesFromBDM(bdmVal, getDWRCallbackMethod(updateCommodity));
	}
	var subCommodityChanged=false;
	var subCommodityId='';
	var commodityId='';
	var classId='';
	function subCommChange(evt){
		var subCommodity = YAHOO.util.Dom.get("subCommoditySelectedId");	
		if(YAHOO.util.Dom.get("commodityText").value=='' && YAHOO.util.Dom.get("bdmText").value=='' &&
		   YAHOO.util.Dom.get("classDisplay").value=='') {
			showProgress();
			subCommodityChanged=true;
			subCommodityId=subCommodity.value;
			ManageEDIDWR.getCommodityForSubCommodity(subCommodity.value, getDWRCallbackMethod(updateCommForSub));
		}
	}
	
	function commodityChange(evt){
		subCommodityChanged=false;
		showProgress();
		<cps:renderByResourceAccess resourceId="139">
			<jsp:attribute name="EDIT">
			var bdm = YAHOO.util.Dom.get("bdmSelectedId");
			var comm = YAHOO.util.Dom.get("commoditySelectedId");
			<cps:renderByResourceAccess resourceId="141">
				<jsp:attribute name="EDIT">
				//YAHOO.util.Dom.get("subCommodityText").value = "";
				</jsp:attribute>					
			</cps:renderByResourceAccess>
			<cps:renderByResourceAccess resourceId="142">
				<jsp:attribute name="EDIT">
				//YAHOO.util.Dom.get("classField").value = "";
				//classClear();
				</jsp:attribute>					
			</cps:renderByResourceAccess>
			/*
			 *Update bdm list when commodity changed more than one time
			 *@author khoapkl
			 */
			commodityId=comm.value;
			ManageEDIDWR.getBDMForCommodity(comm.value, getDWRCallbackMethod(updateBdm));		
			ManageEDIDWR.getClassFromCommNoReturn(comm.value, getDWRCallbackMethod(updateClass));		
			</jsp:attribute>					
		</cps:renderByResourceAccess>
	}

	function updateClass(data){
		var comm = YAHOO.util.Dom.get("commoditySelectedId");
		<cps:renderByResourceAccess resourceId="142">
			<jsp:attribute name="EDIT">
				if(data.id!='') {
					YAHOO.util.Dom.get("classDisplay").value = ''+data.name+' ['+data.id+']';
					YAHOO.util.Dom.get("classField").value = data.id;
				}
			</jsp:attribute>					
		</cps:renderByResourceAccess>
		if(data.id=='') {
			classClear();
		} else {
			YAHOO.HEB.manageMain.classReset(data);
		}
		/*
		 *update sub-commodity when user changing commodity. 
		 *This case happened when sub-commodity hasn't changed for the first time.
		 *@author khoapkl
		 */
		if(!subCommodityChanged) {
			commodityId=comm.value;
			classId=data.id;
			if(classId!='') {
				ManageEDIDWR.getSubCommodityForClassCommodity(data.id,comm.value,getDWRCallbackMethod(updateSubCommForComm));
			} else {
				hideProgress();
			}
		} else {
			hideProgress();
		}
	}
	function updateBdm(data) {
		if(data.length==0) {
			bdmClear();	
		} else if(data.length==1){
			//Display a bdm if list of bdm has one item			
			ManageEDIDWR.getSingleBDMForCommodity(commodityId,getDWRCallbackMethod(updateSingleBdm));	
		} else {
			var bdmCurrent=YAHOO.util.Dom.get("bdmSelectedId").value;
			var count=0;
			for(i=0;i<data.length;i++){
				//keep current bdm if it belongs to commodity
				if(data[i].id==bdmCurrent) {
					YAHOO.util.Dom.get("bdmText").value=''+data[i].name;
				} else {
					count++;					
				}
			}
			//remove bdm if don't have any current bdm belongs to commodity
			if(count==data.length) YAHOO.util.Dom.get("bdmText").value='';
			YAHOO.HEB.manageMain.bdmReset(data);
		}
	}
	function updateSingleBdm(data) {
		YAHOO.util.Dom.get("bdmText").value=''+data.name+' ['+data.id+']';
		//keep value after searching
		YAHOO.util.Dom.get("bdmSelectedId").value = data.id;
		YAHOO.HEB.manageMain.bdmReset(data);
	}
	
	function updateComms(data){ 
		if(data.length==0){
			alert("No Commodities Found");		
		} 
		YAHOO.HEB.manageMain.commodityReset(data);
	}
	function updateCommodity(data){ 
		if(data.length==0){
			alert("No Commodities Found");		
			hideProgress();				
		} else if(data.length==1) {
			//Display a commodity if list of commodity has one item			
			ManageEDIDWR.getSingleCommodityForBDM(YAHOO.util.Dom.get("bdmSelectedId").value,getDWRCallbackMethod(updateSingleCommodity));
		} else {
			var commodityCurrent = YAHOO.util.Dom.get("commoditySelectedId").value;
			var count=0;
			for(i=0;i<data.length;i++){
				//keep current bdm if it belongs to commodity
				if(data[i].id==commodityCurrent) {
					YAHOO.util.Dom.get("commodityText").value=''+data[i].name;
				} else {
					count++;					
				}
			}
			//remove bdm if don't have any current bdm belongs to commodity
			if(count==data.length) YAHOO.util.Dom.get("commodityText").value='';
			if(YAHOO.util.Dom.get("classDisplay").value!='') YAHOO.util.Dom.get("classDisplay").value='';
			if(YAHOO.util.Dom.get("subCommodityText").value!='') {
				YAHOO.util.Dom.get("subCommodityText").value='';
				ManageEDIDWR.getAllSubCommodities(getDWRCallbackMethod(updateSubComm));
			}
			hideProgress();
		}
		YAHOO.HEB.manageMain.commodityReset(data);
	}
	function updateCommForSub(data){ 
		if(data.length==0){
			alert("No Commodities Found");	
			hideProgress();			
		} else if(data.length==1) {
			//Display a commodity if list of commodity has one item
			ManageEDIDWR.getSingleCommodityForSubCommodity(subCommodityId,getDWRCallbackMethod(updateSingleCommodity));
		} else {
			commodityClear();
			YAHOO.HEB.manageMain.commodityReset(data);
			hideProgress();
		}
	}
	function updateSingleCommodity(data) {
		commodityId=data.id;
		YAHOO.util.Dom.get("commodityText").value=''+data.name+' ['+data.id+']';
		//keep value after searching
		YAHOO.util.Dom.get("commoditySelectedId").value=data.id;
		YAHOO.HEB.manageMain.commodityReset(data);
		/*
		 * update class if sub-commodity changed
		 * This case happen when sub-commmodity changed first
		 */
		if(subCommodityChanged) {
			ManageEDIDWR.getBDMForCommodity(data.id, getDWRCallbackMethod(updateBdm));	
		}
		ManageEDIDWR.getClassFromCommNoReturn(data.id, getDWRCallbackMethod(updateClass));
		/*
		 * update bdm if sub-commodity changed
		 * This case happen when sub-commmodity changed first
		 */
		hideProgress();
	}
	/*This method called when user clicking on Clear button*/
	function updateSubComm(data){
		subCommodityClear();
		hideProgress();
		<cps:renderByResourceAccess resourceId="141">
		<jsp:attribute name="EDIT">
		YAHOO.HEB.manageMain.subCommodityReset(data);
		</jsp:attribute>					
		</cps:renderByResourceAccess>
	}

	/*This method called when user clicking on Clear button*/
	function updateClasses(data){
		<cps:renderByResourceAccess resourceId="142">
			<jsp:attribute name="EDIT">
				YAHOO.HEB.manageMain.classReset(data);
			</jsp:attribute>					
		</cps:renderByResourceAccess>
	}
	function updateSubCommForComm(data){
		subCommodityClear();
		//Display a sub-commodity when commodity changed and list of sub-commodity has one item.
		if(data.length==1) {
			ManageEDIDWR.getSingSubCommodityForClassCommodity(classId,commodityId,getDWRCallbackMethod(updateSingleSubCom));
		} else {
			<cps:renderByResourceAccess resourceId="141">
				<jsp:attribute name="EDIT">
					YAHOO.HEB.manageMain.subCommodityReset(data);
				</jsp:attribute>					
			</cps:renderByResourceAccess>
			hideProgress();
		}	
	}
	function updateSingleSubCom(data) {	
		YAHOO.util.Dom.get("subCommodityText").value=''+data.name+' ['+data.id+']';
		//keep value after searching
		YAHOO.util.Dom.get("subCommoditySelectedId").value=data.id;
		YAHOO.HEB.manageMain.subCommodityReset(data);
		setTimeout(function() {hideProgress();}, 2000);	
	}
	function sub(){		
		var key = window.event.keyCode;
		if(key == 13){
		searchCandidate();
		}
	}

	function disableFields(evt){
		<cps:renderByResourceAccess resourceId="226">
		<jsp:attribute name="EDIT">
		<cps:renderByResourceAccess resourceId="155">
		<jsp:attribute name="EDIT">		
		var tstScan = YAHOO.util.Dom.get("sourceSelect");
		
		if(mrtSwtch.checked==true){
			tstScan.disabled=true;
		}else if(mrtSwtch.checked==false){
			tstScan.disabled=false;
		}
		</jsp:attribute>					
		</cps:renderByResourceAccess>
		</jsp:attribute>					
		</cps:renderByResourceAccess>
	}
	//EDI
	function disableSearchAtr(){		
		if(${ManageEDICandidate.haveResults}){
			document.getElementById("searchButtonDiv").style.visibility = 'hidden';
			document.getElementById("searchButtonDiv").style.position = 'absolute';
			document.getElementById("modifyButtonDiv").style.visibility = 'visible';
			document.getElementById("modifyButtonDiv").style.position = 'static';
			if(document.getElementById('bdmText')){
				document.getElementById('bdmText').disabled=true;
			}
			if(document.getElementById('commodityText')){
				document.getElementById('commodityText').disabled=true;
			}
			if(document.getElementById('subCommodityText')){
				document.getElementById('subCommodityText').disabled=true;
			}
			if(document.getElementById('classDisplay')){
				document.getElementById('classDisplay').disabled=true;
			}
			if(document.getElementById('vendorField')){
				document.getElementById('vendorField').disabled=true;
			}
			if(document.getElementById('dataSourseSelect')){
				document.getElementById('dataSourseSelect').disabled=true;
			}
			if(document.getElementById('productType')){
				document.getElementById('productType').disabled=true;
			}
			if(document.getElementById('upc')){
				document.getElementById('upc').disabled=true;
			}
			if(document.getElementById('prodDescriptionField')){
				document.getElementById('prodDescriptionField').disabled=true;
			}
			if(document.getElementById('costField')){
				document.getElementById('costField').disabled=true;
			}
			if(document.getElementById('retailField')){
				document.getElementById('retailField').disabled=true;
			}
			if(document.getElementById('StatusSelect')){
				document.getElementById('StatusSelect').disabled=true;
			}
			if(document.getElementById('sourceSelect')){
				document.getElementById('sourceSelect').disabled=true;
			}
			if(document.getElementById('fromDate')){
				document.getElementById('fromDate').disabled=true;
			}
			if(document.getElementById('toDate')){
				document.getElementById('toDate').disabled=true;
			}
			if(document.getElementById('batchId')){
				document.getElementById('batchId').disabled=true;
			}
			if(document.getElementById('defaultUpcValue')){
				document.getElementById('defaultUpcValue').disabled=true;
			}
			if(document.getElementById('actionSelect')){
				document.getElementById('actionSelect').disabled=true;
			}
			if(document.getElementById('defaultActionSelect')){
				document.getElementById('defaultActionSelect').disabled=true;
			}
			document.images['bdmUniqImage'].style.visibility = 'hidden';
			//document.images['bdmUniqImage'].style.position = 'static';
			document.images['comodityUniqImage'].style.visibility = 'hidden';
			//document.images['comodityUniqImage'].style.position = 'static';
			document.images['subComodityUniqImage'].style.visibility = 'hidden';
			//document.images['subComodityUniqImage'].style.position = 'static';
			document.images['classUniqImage'].style.visibility = 'hidden';
			document.images['calimg1'].style.visibility = 'hidden';
			document.images['calimg2'].style.visibility = 'hidden';
			//document.images['classUniqImage'].style.position = 'static';
		} else {
			document.getElementById("modifyButtonDiv").style.visibility = 'hidden';
			document.getElementById("modifyButtonDiv").style.position = 'absolute';
			document.getElementById("searchButtonDiv").style.visibility = 'visible';
			document.getElementById("searchButtonDiv").style.position = 'static';
			if(document.getElementById('bdmText')){
				document.getElementById('bdmText').disabled=false;
			}
			if(document.getElementById('commodityText')){
				document.getElementById('commodityText').disabled=false;
			}
			if(document.getElementById('subCommodityText')){
				document.getElementById('subCommodityText').disabled=false;
			}
			if(document.getElementById('classDisplay')){
				document.getElementById('classDisplay').disabled=false;
			}
			if(document.getElementById('vendorField')){
				document.getElementById('vendorField').disabled=false;
			}
			if(document.getElementById('dataSourseSelect')){
				document.getElementById('dataSourseSelect').disabled=false;
			}
			if(document.getElementById('productType')){
				document.getElementById('productType').disabled=false;
			}
			if(document.getElementById('upc')){
				document.getElementById('upc').disabled=false;
			}
			if(document.getElementById('prodDescriptionField')){
				document.getElementById('prodDescriptionField').disabled=false;
			}
			if(document.getElementById('costField')){
				document.getElementById('costField').disabled=false;
			}
			if(document.getElementById('retailField')){
				document.getElementById('retailField').disabled=false;
			}
			if(document.getElementById('StatusSelect')){
				document.getElementById('StatusSelect').disabled=false;
			}
			if(document.getElementById('sourceSelect')){
				document.getElementById('sourceSelect').disabled=false;
			}
			if(document.getElementById('fromDate')){
				document.getElementById('fromDate').disabled=false;
			}
			if(document.getElementById('toDate')){
				document.getElementById('toDate').disabled=false;
			}
			if(document.getElementById('batchId')){
				document.getElementById('batchId').disabled=false;
			}
			if(document.getElementById('defaultUpcValue')){
				document.getElementById('defaultUpcValue').disabled=false;
			}
			if(document.getElementById('actionSelect')){
				document.getElementById('actionSelect').disabled=false;
			}
			if(document.getElementById('defaultActionSelect')){
				document.getElementById('defaultActionSelect').disabled=false;
			}
			document.images['bdmUniqImage'].style.visibility = 'visible';
			//document.images['bdmUniqImage'].style.position = 'absolute';
			document.images['comodityUniqImage'].style.visibility = 'visible';
			//document.images['comodityUniqImage'].style.position = 'absolute';
			document.images['subComodityUniqImage'].style.visibility = 'visible';
			//document.images['subComodityUniqImage'].style.position = 'absolute';
			document.images['classUniqImage'].style.visibility = 'visible';
			document.images['calimg1'].style.visibility = 'visible';
			document.images['calimg2'].style.visibility = 'visible';
			//document.images['classUniqImage'].style.position = 'absolute';
		}
	}
	
	
</script>
