<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<c:url var="upArrow" value="${request.getContextPath()}/hebAssets/images/up_arrow.gif"></c:url>
<c:url var="downArrow" value="${request.getContextPath()}/hebAssets/images/down_arrow.gif"></c:url>
<style>
	#clearFilter-button {
		width:73px;
	}
</style>
<fieldset id="f1" style="margin-left: 6px; background-color:#F5EFEA;
									margin-right: 6px; 
									padding-bottom: 5px; 
									padding-top: 5px; 
									width: 98%; position: relative;
									color: #000000;height: 260px;overflow-x: auto;overflow-y:auto;z-index: -1000;">
	<div id="allHeader" style="position: relative;overflow-y:auto; width:99.6%;height: 255px;min-width: 0;z-index: -1000;">
	<div id="tabHeader" style="position: relative;top: -1px;height: 70px;width: 99.6%;min-width: 0;z-index: -1000;">
	<table id="searchResults" width="100%" border="0" bordercolor="red" cellspacing="0" cellpadding="0" class="dataGrid" style="position: relative;">
		<tr>
			<td class="dataGridHead" align="left" width="3%"><span style="margin-left:3px"> All</span> <br> <input type="checkbox" id="checkAll" 
			onclick='selectCheckboxes();'> </td>	
			<td class="dataGridHead"  align="left" width="15%" id="v1">
				<table border="0" ><tr>
					<td><div id="d1" style="position: relative;"></div></td>
					<td class="#searchResults"><a href="javascript:return false;" onclick="sortColumn(1);return false;">Vendor</a></td>
					<td>    <input type="button" onclick="showCompleter(1);" value="..."/></td>
					</tr></table>
			</td>
			<td class="dataGridHead"  align="left" width="9%" id="v2">
				<table border="0"><tr>
					<td><div id="d2" style="position: relative;"></div></td>
					<td><a href="javascript:return false;" onclick="sortColumn(2);return false;">Unit UPC</a></td>
					<td>    <input type="button" onclick="showCompleter(2);" value="..."/></td>
					</tr></table>
			</td>
			<td class="dataGridHead"  align="left" width="22%" id="v3">
				<table border="0"><tr>
					<td><div id="d3" style="position: relative;"></div></td> 
					<td>
						<a href="javascript:return false;" onclick="sortColumn(3);return false;">
						<c:choose>
							<c:when test="${manageProduct.prodcriteria.mrtSwitchCheck}">
								Item Description	
							</c:when>
							<c:otherwise>
								Product Description	
							</c:otherwise>
						</c:choose>	
						</a>
					</td>
					<td><input type="button" onclick="showCompleter(3);" value="..."/></td>
					</tr></table>
			</td>
			
			<!-- <td class="dataGridHead"  align="center" width="13%" id="v5">
				<table border="0"><tr>
					<td><div id="d5" style="position: relative;"></div></td>
					<td><a href="javascript:return false;"	onclick="sortColumn(5);return false;">Presentation Date</a></td>
					<td>    <input type="button" onclick="showCompleter(5);" value="..."/></td>
					</tr></table>
			</td>
			-->
			<td class="dataGridHead"  align="center" width="15%" id="v6">
			
				<table border="0"><tr>
					<td><div id="d6" style="position: relative;"></div></td> 
					<td ><a href="javascript:return false;" onclick="sortColumn(6);return false;">Activation Date</a></td>
					<td>    <input type="button" onclick="showCompleter(6);" value="..."/></td>
				</tr></table>
			</td>
			<td class="dataGridHead"  align="left" width="13%" id="v7">
			
			    <table border="0"><tr>
					<td><div id="d7" style="position: relative;"></div></td>
					<td ><a href="javascript:return false;" onclick="sortColumn(7);return false;">Item Code</a></td>
					<td>    <input type="button" onclick="showCompleter(7);" value="..."/></td>
					</tr> </table>
			</td>
			<td class="dataGridHead"  align="left" width="16%" id="v8">
				<table border="0">
				<tr>
					<td><div id="d8" style="position: relative;"></div></td>
					<td ><a href="javascript:return false;" onclick="sortColumn(8);return false;">MRT Switch</a></td>
					<td> 
						<cps:renderByResourceAccess resourceId="226">
							<jsp:attribute name="EDIT">
								<input type="button" onclick="showMrtSwitch();" value="..."/>
							</jsp:attribute>		
							<jsp:attribute name="VIEW"> 
								<input type="button" onclick="showMrtSwitch();" value="..."/>
							</jsp:attribute>								
						</cps:renderByResourceAccess> 
					</td>
				</tr> 
				</table>
			</td>
			<td class="dataGridHead"  align="left" width="5%" id="v10">
				<button type="button" id="clearFilter" name="clearFilter" value="clearfilter">Clear Filter</button>
			
		</td>
		</tr>   

		<tr>
		<td class="dataGridHead" align="center" width="3%"></td>
			
			<td class="dataGridHead"  width="20%">		
			<c:if test="${noData eq 'true'}">
				<input type="hidden" id="noData">
			</c:if>					
			<div id="autoComplete1" style="display: none;"><cps:autoComplete sourceList="vendorDescs" compName="vendorDescUniq" containerId="vendorDescContainer"
						textid="vendorDescText" selectedProperty="vndrDesc" 
						clearMethod="vndrDescClear"
						containerVar="YAHOO.HEB.manageMain.vendorDescData"
						resetJSMethodName="YAHOO.HEB.manageMain.vendorDescReset"
						selectedValueId="vendorDescSelectedId"
						selectedValueName="vendorDescSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.vendorDescReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete></div></td>
			<td class="dataGridHead"  width="11%" >
			<div id="autoComplete2" style="display: none;"> <cps:autoComplete sourceList="unitUPCs" compName="unitUPCUniq" containerId="unitUPCContainer"
						textid="unitUPCText" selectedProperty="vndrUnitUpc" 
						clearMethod="vndrUnitUpcClear"
						containerVar="YAHOO.HEB.manageMain.unitUPCData"
						resetJSMethodName="YAHOO.HEB.manageMain.unitUPCReset"
						selectedValueId="unitUPCSelectedId"
						selectedValueName="unitUPCSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.unitUPCReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete> </div></td>
			<td class="dataGridHead"  width="22%">
			<div id="autoComplete3" style="display: none;"><cps:autoComplete sourceList="prodDescriptions" compName="prodDescUniq" containerId="prodDescContainer"
						textid="prodDescText" selectedProperty="prdDesc"
						clearMethod="prdDescClear"
						containerVar="YAHOO.HEB.manageMain.prodDescData"
						resetJSMethodName="YAHOO.HEB.manageMain.prodDescReset"
						selectedValueId="prodDescSelectedId"
						selectedValueName="prodDescSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.prodDescReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete></div></td>
		
			<!--<td class="dataGridHead"  width="13%">
			<div id="autoComplete5" style="display: none;"><cps:autoComplete sourceList="prodPresDates" compName="prodPresDateUniq" containerId="prodPresDateContainer"
						textid="prodPresDateText" selectedProperty="prodPresDate"
						clearMethod="prodPresDateClear"
						containerVar="YAHOO.HEB.manageMain.prodPresDateData"
						resetJSMethodName="YAHOO.HEB.manageMain.prodPresDateReset"
						selectedValueId="prodPresDateSelectedId"
						selectedValueName="prodPresDateSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.prodPresDateReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete></div></td>
			-->
			<td class="dataGridHead"  width="10%">
		
			 <div id="autoComplete6" style="display: none;"><cps:autoComplete sourceList="activationDate" compName="activationDateUniq" containerId="activationDateContainer"
						textid="activationDateText" selectedProperty="activateDate"
						clearMethod="activationDateClear"
						containerVar="YAHOO.HEB.manageMain.activationDateData"
						resetJSMethodName="YAHOO.HEB.manageMain.activationDateReset"
						selectedValueId="activationDateSelectedId"
						selectedValueName="activationDateSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.activationDateReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete></div>
					</td>
			<td class="dataGridHead"  width="8%">
			
			<div id="autoComplete7" style="display: none;"><cps:autoComplete sourceList="productItemCode" compName="productItemCodeUniq" containerId="productItemCodeContainer"
						textid="productItemCodeText" selectedProperty="prodItemCode"
						clearMethod="productItemCodeClear"
						containerVar="YAHOO.HEB.manageMain.productItemCodeData"
						resetJSMethodName="YAHOO.HEB.manageMain.productItemCodeReset"
						selectedValueId="productItemCodeSelectedId"
						selectedValueName="productItemCodeSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.productItemCodeReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete></div>
					</td>
					<!--add new MRT Switch header
					    @author khoapkl
					 -->
					<td class="dataGridHead"  width="8%">
						<div id="mrtSwitchFilter" style="display: none;margin-left:15px">
							<cps:renderByResourceAccess resourceId="226">
								<jsp:attribute name="EDIT">
									<form:checkbox path="prodcriteria.mrtSwitchCheck" tabindex="6" id="mrtSwitch" onclick="filterChange(null)"></form:checkbox>
								</jsp:attribute>	
								<jsp:attribute name="VIEW">
									<form:checkbox path="prodcriteria.mrtSwitchCheck" tabindex="6" id="mrtSwitch" onclick="filterChange(null)"></form:checkbox>
								</jsp:attribute>	
							</cps:renderByResourceAccess>
						</div>
					</td>		
					<td class="dataGridHead"  align="left" width="5%" id="v10">			
			</td> 
		</tr> 
	</table>
	</div>
		<input type="hidden" id="allIds" value="-" name="hiddenTxt"/>
		<form:hidden path="selectedProductId" id="selectedProductId"/>
		<form:hidden path="selectedProductIdItmTypCd" id="selectedProductIdItmTypCd"/>
		<!--add new selectedMrtLabel textbox
		 @author khoapkl
		 -->
		<form:hidden path="selectedMrtLabel" id="selectedMrtLabel"/>
		<form:hidden path="candidateTypeList" id="candidateTypeList"/>
	<div id="results" style="position: relative;width: 99.6%;top: 10px;z-index: -2000">
			<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="dataGrid">
				<c:forEach items="${manageProduct.productsTemp}" var="product" varStatus="loop">
				<c:url value="/protected/cps/add/pow?${_csrf.parameterName}=${_csrf.token}" var="pow"></c:url>
					<tr id="row${product.productId}" ondblclick="modifyDblClick('${product.productId}','${product.mrtLabel}');">
						<td class="row${loop.index%2}"  align="left" width="3%">
							<input type="hidden" id="hiddProdId${loop.index}" value="${product.productId}"/>
							<input type="hidden" id="hiddProdIdItmTypCd${loop.index}" value="${product.itemTypCd}"/>
							<input type="hidden" id="hiddActiveProductKit${loop.index}" value="${product.activeProductKit}"/>
							<input type="hidden" id="hiddUnitUpc${loop.index}" value="${product.unitUPC}"/>
							<!--add new hiddMrtLabel textbox
							 *@author khoapkl
		                     -->
							<input type="hidden" id="hiddMrtLabel${loop.index}" value="${product.mrtLabel}"/>
							<input type="checkbox" id="check" name="candSelectCheck" onclick="selectSingleProduct();"></td>
						<td   class="row${loop.index%2}" align="left" width="18%"><c:out value="${product.vendorDesc}"/></td>
						<td  class="row${loop.index%2}" align="left" width="9%"><c:out value="${product.unitUPC}"/></td>
						<td   class="row${loop.index%2}" width="21%"><c:out value="${product.productDesc}"/></td>
						<!--<td  class="row${loop.index%2}"  align="left" width="13%"><bean:write name="product" property="pressDate"/></td>
						--><td   class="row${loop.index%2}" width="12%">
						<span  style="margin-left:6px">
						<c:out value="${product.activationDate}" /></span>
						</td>
						<td   class="row${loop.index%2}" width="13%">
						<c:out value="${product.itemCode}" /></td>
						<!-- add new MRT label
						 *@author khoapkl
						 -->
						<td   class="row${loop.index%2}" align="left" width="11%">
						<c:out value="${product.mrtLabel}" /></td>
						<td   class="row${loop.index%2}" align="left" width="10%"></td></tr>
						<input type="hidden" id="upcDSV" value="${product.unitUPC}"/>
				</c:forEach>
			</table>
	</div>
	</div>
</fieldset>
	<div id="resultsButtons" style="margin-left: 6px;
									margin-right: 6px; position: relative;
									padding-bottom: 5px; 
									padding-top: 5px; 
									width: 99%;
									color: #000000;">
	<table align="right" width="50%" id="tabResults" border="0" bordercolor="red" cellspacing="0" cellpadding="0" >
			<tr>
				 <TD width="50%"></TD>
				  <TD align="center" width="20%">
				     <cps:renderByResourceAccess resourceId="205">
					<jsp:attribute name="EXEC"> 
				     <button type="button" id="printSummaryBut" name="printSummaryBut" value="printSummary" style="width: 6em;">Print Summary</button> 
				     </jsp:attribute></cps:renderByResourceAccess>
			    </TD>
     <TD align="center" width="10%">
     <cps:renderByResourceAccess resourceId="227">
	<jsp:attribute name="EXEC"> 
     <button type="button" id="viewBut" name="viewBut" value="view" style="width: 6em;">View</button> 
     </jsp:attribute></cps:renderByResourceAccess>
    </TD>
     <TD align="center" width="10%">
     <cps:renderByResourceAccess resourceId="229">
	<jsp:attribute name="EXEC">
     <button type="button" id="modifyBut" name="modifyBut" value="modify" style="width: 6em;">Modify</button>
     </jsp:attribute></cps:renderByResourceAccess> 
    </TD>
    <TD align="center" width="10%">
     <cps:renderByResourceAccess resourceId="228">
				<jsp:attribute name="EXEC">
     <button type="button" id="copyBut" name="copyBut" value="copy" style="width: 5em;">Copy </button>
     </jsp:attribute></cps:renderByResourceAccess> 
    </TD>
    
     	 </tr>
	</table>
	</div>

<script type="text/javascript">
<cps:renderByResourceAccess resourceId="227">
	<jsp:attribute name="EXEC">  
	new YAHOO.widget.Button("printSummaryBut"); 
</jsp:attribute>
</cps:renderByResourceAccess>
<cps:renderByResourceAccess resourceId="227">
	<jsp:attribute name="EXEC">  
		new YAHOO.widget.Button("viewBut"); 
	</jsp:attribute>
</cps:renderByResourceAccess>   
<cps:renderByResourceAccess resourceId="228">
	<jsp:attribute name="EXEC">                                     
		new YAHOO.widget.Button("copyBut");  
	</jsp:attribute>
</cps:renderByResourceAccess>
<cps:renderByResourceAccess resourceId="229">
	<jsp:attribute name="EXEC">
		new YAHOO.widget.Button("modifyBut");  
	</jsp:attribute>
</cps:renderByResourceAccess>

new YAHOO.widget.Button("clearFilter");

YAHOO.util.Event.addListener(YAHOO.util.Dom.get("clearFilter"), "click", clearFilt);

<c:if test="${manageProduct.validForResults}">
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("printSummaryBut"), "click", printSummary); 
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("viewBut"), "click", view); 
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifyBut"), "click", modify); 
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("copyBut"), "click", copy); 
</c:if>





<c:url value="/protected/cps/add/copyProduct?${_csrf.parameterName}=${_csrf.token}" var="copyProd"></c:url>
function copy(evt){	
    if(checkSelection2(evt)){  
	  //Sprint - 23
        if(allActiveProductKitSelected!=null && allActiveProductKitSelected.length>0) {
            var upc = ""
            for(var i =0;i<allActiveProductKitSelected.length;i++){
		    	var arr = allActiveProductKitSelected[i].split("_");
				if(arr[0]=='true') {
					alert('A kit cannot be copied.');
					return false;
				}
	    	}
        }
        if(YAHOO.util.Dom.get('candidateTypeList').value){
            if(YAHOO.util.Dom.get('candidateTypeList').value =='MRT'){
            	alert('MRT cannot be copied.');
            } else {
    	var formObject = YAHOO.util.Dom.get('searchForm'); 
    	formObject.action = '${copyProd}';
    	formObject.submit();
    }
}
    }
}

<c:url value="/protected/cps/add/viewProduct?${_csrf.parameterName}=${_csrf.token}" var="viewProd"></c:url>
function view(evt){	
	var viewRequestArray = new Array();
	var checks = document.getElementsByName('candSelectCheck');
	var cnt = 0;
	var productTypeArray = new Array();
	for(var i =0;i<checks.length;i++){
		if(checks[i].checked) {
			viewRequestArray[cnt]= YAHOO.util.Dom.get("hiddProdId"+i).value;
			cnt++;
		}
	}	
    if(cnt < 1){
    	alert('Please select a Product');
    	return false;
    }else{
    	var formObject = YAHOO.util.Dom.get('searchForm'); 
    	formObject.action = '${viewProd}'+'&SelectedViewArray='+viewRequestArray;
    	formObject.submit();
    }
}
<c:url value="/protected/cps/manage/printProductSummary" var="printProductSummary"></c:url>
function printSummary(evt){	
	var viewRequestArray = new Array();
	var checks = document.getElementsByName('candSelectCheck');
	var cnt = 0;
	var productTypeArray = new Array();
	for(var i =0;i<checks.length;i++){
		if(checks[i].checked) {
			viewRequestArray[cnt]= YAHOO.util.Dom.get("hiddProdId"+i).value;
			cnt++;
		}
	}	
    if(cnt < 1){
    	alert('Please select a Product');
    	return false;
    }else{
    	var formObject = YAHOO.util.Dom.get('searchForm'); 
    	formObject.action = '${printProductSummary}';
    	formObject.submit();
    }
}

<c:url value="/protected/cps/add/modifyProduct?${_csrf.parameterName}=${_csrf.token}" var="modifyProd"></c:url>
function executeModify(){
	var formObject = YAHOO.util.Dom.get('searchForm'); 
    if(checkSelection2(null)){  
    	var candType=YAHOO.util.Dom.get('candidateTypeList').value;
        if(candType.indexOf('MRT')==0) {
        	alert('MRT product cannot be modified.');
            return false;
        }
        //Sprint - 23
        if(allActiveProductKitSelected!=null && allActiveProductKitSelected.length>0) {
            var upc = ""
            for(var i =0;i<allActiveProductKitSelected.length;i++){
		    	var arr = allActiveProductKitSelected[i].split("_");
				if(arr[0]=='true') {
					alert('A kit product may not be modified.');
					//. Please de-select the kit product(s) ('+arr[1]+') before modifying.');
					return false;
				}
	    	}
        }
    	formObject.action = '${modifyProd}';
    	/*Hide MRT case tab when modify a product
    	 *@author khoapkl
    	 */
    	//YAHOO.util.Dom.get('selectedMrtLabel').value='';
    	formObject.submit();
    }
}

function myTrim(x) {
	return x.replace(/^\s+|\s+$/gm,'');
}

<c:url var="addNewCandidateUrl" value="${request.getContextPath()}/protected/cps/add/"></c:url>
function modify(evt){
	if(checkSelection2(evt) == false){ 
		return;
	}
	var paramProdId = document.getElementById("allIds").value;	// get the selected prod id
	var trimProdId = paramProdId.slice(0, -1);	// trim the last "-" character
	if(!paramProdId || !trimProdId){
		return;
	}
	showProgress();	
	var callbacks = {
			success : function(o) {
				try {
					hideProgress();
					if (o != null && myTrim(o.responseText) != "") {
						alert(o.responseText);
					}else{
// 						showProgress();	
						executeModify(evt);
					}
				} catch (e) {
					hideProgress();
					return;
				}
			},
			failure : function() {
				hideProgress();
			},
			timeout : 5000
		};
		YAHOO.util.Connect.asyncRequest('GET',"${addNewCandidateUrl}checkDSVItem?prodid="+trimProdId+"&${_csrf.parameterName}=${_csrf.token}",callbacks);
}

function modifyCallBack(data){	
	try {
		hideProgress();
		if (data != null && myTrim(data) != "") {
			alert(data);
		}else{
			executeModify();
		}
	} catch (e) {
		hideProgress();
		return;
	}
}

var allActiveProductKitSelected = new Array();

function selectSingleProduct(){
    var allProdIdsSelected = '';
    var allProdIdsItmTypCdSelected = '';
    var checks = document.getElementsByName('candSelectCheck');
	var productTypeArray = new Array();
	var headerCheckBox = document.getElementById('checkAll');
	var varCheckAll = false;
	allActiveProductKitSelected = new Array();
    for(var i =0;i<checks.length;i++){
        if(checks[i].checked){                        
           allProdIdsSelected += YAHOO.util.Dom.get('hiddProdId'+i).value + '-';
           allProdIdsItmTypCdSelected += YAHOO.util.Dom.get('hiddProdId'+i).value + '-' + YAHOO.util.Dom.get('hiddProdIdItmTypCd'+i).value + ',';
           allActiveProductKitSelected.push(YAHOO.util.Dom.get('hiddActiveProductKit'+i).value+"_"+YAHOO.util.Dom.get('hiddUnitUpc'+i).value);
		   //khoapkl
			if(document.getElementById("hiddMrtLabel"+i).value=='') {
				productTypeArray.push('None-MRT');
			} else {
				productTypeArray.push(document.getElementById("hiddMrtLabel"+i).value);
			}
        }else{
        	varCheckAll = true;
        }
    }
    headerCheckBox.checked = !varCheckAll;
	//khoapkl
	if(productTypeArray[0]=='None-MRT') {
		document.getElementById("selectedMrtLabel").value='None-MRT';
	} else {
		document.getElementById("selectedMrtLabel").value='MRT';
	}
	YAHOO.util.Dom.get('candidateTypeList').value=productTypeArray;
    YAHOO.util.Dom.get('selectedProductId').value = allProdIdsSelected;
    YAHOO.util.Dom.get('selectedProductIdItmTypCd').value = allProdIdsItmTypCdSelected;
    YAHOO.util.Dom.get('allIds').value = allProdIdsSelected;
}	

function modifyDblClick(evt,evt1){
	var mrtSwitchCheck='no';
	<c:if test="${manageProduct.prodcriteria.mrtSwitchCheck}">
		mrtSwitchCheck='yes';
	//return false;
	</c:if>
	//if(evt1=='MRT') return false;
	var formObject = YAHOO.util.Dom.get('searchForm'); 
	YAHOO.util.Dom.get('selectedProductId').value = evt;
	document.getElementById("selectedMrtLabel").value = evt1;
	var viewRequestArray = new Array();
	/* set evt1 in selectedMrtLabel
	 *@author khoapkl
	 */
	//YAHOO.util.Dom.get('selectedMrtLabel').value=evt1;
	viewRequestArray[0] = YAHOO.util.Dom.get('selectedProductId').value;
	//formObject.act
	ion = '${viewProd}'+'&SelectedViewArray='+YAHOO.util.Dom.get('selectedProductId').value;
	formObject.action = '${viewProd}'+'&SelectedViewArray='+viewRequestArray;
	formObject.submit();
}

function showCompleter(iddd){
	if(YAHOO.util.Dom.get('autoComplete'+iddd).style.display == 'none'){
		YAHOO.util.Dom.get('autoComplete'+iddd).style.display = 'block';
	}else if(YAHOO.util.Dom.get('autoComplete'+iddd).style.display == 'block'){
		YAHOO.util.Dom.get('autoComplete'+iddd).style.display = 'none';
	}
}
	
function clearFlt(){
	if(YAHOO.util.Dom.get('vndrDesc')) {
		YAHOO.util.Dom.get('vndrDesc').value = '';
	}
	if(YAHOO.util.Dom.get('vndrUnitUpc')) {
		YAHOO.util.Dom.get('vndrUnitUpc').value = '';
	}
	if(YAHOO.util.Dom.get('prdDesc')) {
		YAHOO.util.Dom.get('prdDesc').value = '';
	}
	if(YAHOO.util.Dom.get('activateDate')) {
		YAHOO.util.Dom.get('activateDate').value = '';
	}
	if(YAHOO.util.Dom.get('prodItemCode')) {
		YAHOO.util.Dom.get('prodItemCode').value = '';
	}
	if(document.getElementById('mrtSwitch')) {
		document.getElementById('mrtSwitch').checked = false;		
	} 
}

clearFlt();

function hide(elem){
	var data = document.getElementById(elem);
	if (data){
		data.style.display = 'none';
	}
}

function clearFilt(){
	var isChanged='false';
    vndrDescClear();
    hide('autoComplete1');
    vndrUnitUpcClear();
    hide('autoComplete2');
    prdDescClear();
    hide('autoComplete3');
    activationDateClear();
    hide('autoComplete6');
    productItemCodeClear();
    hide('autoComplete7');
	/* begin
	 *@author khoapkl
	 */
    if(document.getElementById('mrtSwitch').checked==true) {
		document.getElementById('mrtSwitch').checked=false;
	} 
	document.getElementById('mrtSwitchFilter').style.display='none';
	filterChange(null);	
}

var panels = new Array();
var i=0;
for(i=0;i<11;i++){
	panels[i] = new YAHOO.widget.Panel("filterPanel"+i, { xy:[250,250], width: "350px", visible: false } );
	panels[i].render();
}

function filterChangeOnthis(val, stylId){
	clearFlt();
	YAHOO.util.Dom.get(stylId).value = val;
	panels[shownPanelIndex].hide();
	filterChange(null);
}

var shownPanelIndex;

function showPanel(index){
	panels[index].show();	
	panels[index].moveTo(250,250);
	shownPanelIndex = index;
}



var sortedCol = null;
var dir = "down";

function sortColumn(col){
	if(col == sortedCol){
		if(dir == "down"){
			dir = "up";
		}else{
			dir = "down";
		}
	}else{
		dir = "up";
	}
	d = dir;
	var sr = null;
	if(dir == 'up'){
		sr = '${upArrow}';
	}else{
		sr = '${downArrow}';
	}
	if(null != sortedCol){
		YAHOO.util.Dom.get('d'+sortedCol).innerHTML = '';
	}
	YAHOO.util.Dom.get('d'+col).innerHTML = '<img src="'+sr+'" />';
	sortedCol = col;
	var caseVl = col + 1;
	sort(dir, caseVl);
}

function sort(dirct,caseValue){
	d1 = dirct;
	caseVal = caseValue;
	filter(null);
}
function selectCheckboxes() {
   /*check object is not null
	*@author khoapkl
	*/
	var allProdIdsSelected = '';
	var allProdIdsItmTypCdSelected = '';
	var productTypeArray = new Array();
	allActiveProductKitSelected = new Array();
	if(YAHOO.util.Dom.get('check')!=null) {
		if(YAHOO.util.Dom.get('checkAll').checked){
			YAHOO.util.Dom.get('check').checked=true;
		}
		else {
			YAHOO.util.Dom.get('check').checked=false;
		}
		var checkedValue = YAHOO.util.Dom.get('checkAll').checked;
		var checks = document.getElementsByName('candSelectCheck');
		for(var i =0;i<checks.length;i++){
			checks[i].checked = checkedValue;
			if(checkedValue) {
				allProdIdsSelected += YAHOO.util.Dom.get('hiddProdId'+i).value + '-';
				allProdIdsItmTypCdSelected += YAHOO.util.Dom.get('hiddProdId'+i).value + '-' + YAHOO.util.Dom.get('hiddProdIdItmTypCd'+i).value + ',';
				if(document.getElementById("hiddMrtLabel"+i).value=='') {
					productTypeArray.push('None-MRT');
				} else {
					productTypeArray.push(document.getElementById("hiddMrtLabel"+i).value);
				}
				 allActiveProductKitSelected.push(YAHOO.util.Dom.get('hiddActiveProductKit'+i).value+"_"+YAHOO.util.Dom.get('hiddUnitUpc'+i).value);
			}
		}
		//khoapkl
		if(productTypeArray[0]=='None-MRT') {
			document.getElementById("selectedMrtLabel").value='None-MRT';
		} else {
			document.getElementById("selectedMrtLabel").value='MRT';
		}
		YAHOO.util.Dom.get('candidateTypeList').value=productTypeArray;
		YAHOO.util.Dom.get('selectedProductId').value = allProdIdsSelected;
		YAHOO.util.Dom.get('selectedProductIdItmTypCd').value = allProdIdsItmTypCdSelected;
		YAHOO.util.Dom.get('allIds').value = allProdIdsSelected;
	}
}
	
function selectSingle(){
	var cnt =0;
	var HeaderCheckBox = YAHOO.util.Dom.get('checkAll');
	var checks = document.getElementsByName('candSelectCheck');
	for(var i =0;i<checks.length;i++){
		if(checks[i].checked){
	    	cnt++;
		}
	}	
	if(cnt<checks.length){
		HeaderCheckBox.checked = false;
	}else if(cnt == checks.length){
     	HeaderCheckBox.checked = true;
	}
}
		
	
<c:url value="/protected/cps/add/classification?${_csrf.parameterName}=${_csrf.token}" var="actn"></c:url>
		
function checkSelection(evt) {
	   var checks = document.getElementsByName('candSelectCheck');
		var cnt = 0;
		for(var i =0;i<checks.length;i++){
		if(checks[i].checked){
			cnt++;
		}
	}	
    if(cnt < 1){
    	alert('Please select a Product');
    	return false;
    }else{
    	return true;
    }
}
function checkSelection2(evt) {
	var checks = document.getElementsByName('candSelectCheck');
	var cnt = 0;
	for(var i =0;i<checks.length;i++){
		if(checks[i].checked){
			cnt++;
		}
	}	
    if(cnt > 1){
    	alert('Please select one Product');
    	return false;
    }else if(cnt < 1){
    	alert('Please select a Product');
    	return false;
    }else{
    	return true;
    }
}

// checkSelection function for approve,reject and delete candidate
function checkSelection3(evt) {
	var checks = document.getElementsByName('candSelectCheck');
	var cnt = 0;
	for(var i =0;i<checks.length;i++){
		if(checks[i].checked){
			cnt++;
		}
	}	
    if(cnt < 1){
    	alert('Please select a candidate');
    	return false;
    }else{
    	return true;
    }
}

function submitPage(evt){ 
	if(checkSelection2(evt)){  
		var formObject = YAHOO.util.Dom.get('searchForm'); 
		formObject.action = '${prod}';
		formObject.submit();
	}
}
	

	
<c:url value="/protected/cps/manage/productFilterChange?${_csrf.parameterName}=${_csrf.token}" var="link"></c:url>
function filterChange(evt){
	var formObject = YAHOO.util.Dom.get('searchForm');
	formObject.action = "${link}";
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
	
<c:if test="${manageProduct.validForResults}">
	<c:url value="/protected/cps/manage/sortFilter?${_csrf.parameterName}=${_csrf.token}" var="filterLink"></c:url>
	<c:url value="${request.getContextPath()}/hebAssets/images/loading.gif" var="loading" />
	var loadingUrl = '${loading}';
	var tempHtml1 = "<br><br><br><table width='100%'><tr><td align='center'><img src='"+loadingUrl+"'  align='middle'/></td></tr></table><br><br><br>"

	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("filterGo"), "click", filter);

	var d1 = 'no';
	var caseVal = '';


	function filter(evt){
		var formObject = YAHOO.util.Dom.get('searchForm');
		formObject.action = "${filterLink}"+'&direction='+d1+'&sortCaseValue='+caseVal;
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
		YAHOO.util.Dom.get('results').innerHTML = tempHtml1;
		showProgress();
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
		
		//to clear selected checkboxes on filter
		YAHOO.util.Dom.get('checkAll').checked = false; 
	}
</c:if>

<c:if test="${manageProduct.prodcriteria.mrtSwitchCheck}">
	var copyBut1 	= YAHOO.util.Dom.get("copyBut");
	var modifyBut1 	= YAHOO.util.Dom.get("modifyBut");
	var viewBut1	= YAHOO.util.Dom.get("viewBut");
	copyBut1.disabled	= true;
	modifyBut1.disabled	= true;
	viewBut1.disabled	= true;
</c:if>
<c:url value="/protected/cps/manage/searchProductByMrt?${_csrf.parameterName}=${_csrf.token}" var="mrtSearch"></c:url>
/*@author khoapkl*/
function filterByMrtSwitch(evt){
	if(document.getElementById('noData')!=null){
		var formObject = document.getElementById('searchForm');
		formObject.action = "${mrtSearch}";
		YAHOO.util.Connect.setForm(formObject); 
		
		var callback = {
			success:function(o){
				hideProgress();
				document.getElementById('results').innerHTML = o.responseText;
				document.getElementById('errors').innerHTML='<ul>'+handleMessageFilter(document.getElementById('msgError').value,document.getElementById('msgIndex').value)+'</ul>';
			}
		};
		showProgress();
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
		
		//to clear selected checkboxes on filter
		document.getElementById('checkAll').checked = false; 
	}
}
/*@author khoapkl*/
function handleMessageFilter(msgError,msgIndex) {
	var msg='';
	if(msgIndex=='1') {
		msg+='<LI><font color="\Blue\" size="\1px\">'+msgError+'</li>';
	} else if(msgIndex=='2') {
		msg+='<LI><font color="\#980000\" size="\1px\">'+msgError+'</li>';
	} else if(msgIndex=='3') {
		msg+='<LI><font color="\#C80000\" size="\1px\">'+msgError+'</li>';
	} else {
		msg+='<LI><font color="\#FF0000\" size="\1px\">'+msgError+'</li>';
	}
	return msg;
}		
/*@author khoapkl*/
function showMrtSwitch() {
	if(document.getElementById('mrtSwitchFilter').style.display=='none') {
		document.getElementById('mrtSwitchFilter').style.display='';
	} else if (document.getElementById('mrtSwitchFilter').style.display=='') {
		document.getElementById('mrtSwitchFilter').style.display='none';
	}
}
</script>