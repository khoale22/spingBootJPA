<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- STARTING upc.jsp MODULE -->
<script type="text/javascript">
		YAHOO.namespace('HEB.otherInfo.productAndUPC.upc');
</script>

<c:url
	value="${request.getContextPath()}/hebAssets/moduleIncludes/authAndDist.js"
	var="authAndDist" />
<script type="text/javascript" src="${authAndDist}"></script>

<script type="text/javascript"
		src="<spring:url value='/hebAssets/moduleIncludes/auth.js.jsp'></spring:url>"></script>
<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />

<fieldset style="width: 95%; z-index: 8000;">
	<legend class="legendFont">Build Kit Components</legend>
	<table width="100%" border="0" id="addUPCKitTable">
		<tr>
			<td>
				<table width="100%" cellspacing="0"  border="0">
					<tr height="25px">
						<td width="13%" align="center" class="dataGridHead">Unit UPC<em><font color="red"><b>*</b></font></em></td>
						<!--<td class="dataGridHead" width="2%" class="labelFont"></td>-->
						<td width="13%" align="center" class="dataGridHead">Quantity<em><font color="red"><b>*</b></font></em></td>
						<td width="13%" align="center" class="dataGridHead">Description</td>
						<td width="13%" align="center" class="dataGridHead">Avg Cost</td>
						<td width="13%" align="center" class="dataGridHead">Retail</td>
						<td width="13%" align="center" class="dataGridHead">Extended Avg Cost</td>
						<td width="13%" align="center" class="dataGridHead">Extended Retail</td>
						<td width="5%" align="center" class="dataGridHead"></td>
						<td width="5%" align="center" class="dataGridHead"></td>
					</tr>
					<tbody id="upcKitTable" align="center">
						<c:forEach items="${addNewCandidate.productVO.upcKitVOs}" var="upc" varStatus="loop" >
							<tr id="caseRow${loop.index}" class="labelFont">
								<td width="13%" align="center" nowrap="nowrap" class="labelFont" align="center">
									<c:out value="${upc.unitUPC}"></c:out>
								</td>
								<td width="13%" align="center" nowrap="nowrap" class="labelFont" align="center">
									<c:out value="${upc.quantity}"></c:out>
								</td>
								<td width="13%" align="center" nowrap="nowrap" class="labelFont" >
									<c:out value="${upc.description}"></c:out>
									<input type="hidden" id="hiddenNormal${loop.index}" value="${upc.uniqueId}" />
									<input type="hidden" id="hiddenNormalQuantity${loop.index}" value="${upc.quantity}" />
									<input type="hidden" id="hiddenNormalIsTaxable${loop.index}" value="${upc.taxable}" />
								</td>
								<td width="13%" align="center" nowrap="nowrap" class="labelFont" align="center">
									<div style="float:right;padding-right:60px;margin:0px" id="avgCostWrap">
										<c:out value="${upc.avgCostLabel}"></c:out>
									</div>
								</td>
								<td width="13%" align="center" nowrap="nowrap" class="labelFont" align="center">
									<c:out value="${upc.retailLabel}"></c:out>
								</td>
								<td width="13%" align="center" nowrap="nowrap" class="labelFont" align="center">
									<div style="float:right;padding-right:60px;margin:0px" id="extendedCostWrap">
										<c:set var="extCost" value="${not empty upc.avgCostLabel ? (upc.avgCostLabel * upc.quantity) : ''}" />
										<fmt:formatNumber minFractionDigits="4" maxFractionDigits="4" groupingUsed="false" value="${not empty extCost ? extCost : ''}"/>
									</div>
								</td>
								<td width="13%" align="center" nowrap="nowrap" class="labelFont" align="center">
									<c:set var="extRetail" value="${not empty upc.retailLabel ? (upc.retailLabel * upc.quantity) : ''}" />
									<fmt:formatNumber minFractionDigits="2" maxFractionDigits="2" groupingUsed="false" value="${not empty extRetail ? extRetail : ''}"/>
								</td>
								<td  align="left"  width="5%">
									<cps:renderByResourceAccess resourceId="276">
										<jsp:attribute name="EDIT">
											<c:url var="img" value="${request.getContextPath()}/hebAssets/images/trash.png"/>
											<a href='#' target='_parent' id='deleteUPCKIT${loop.index}'
											   onclick='javascript:return false;' title='Delete this Kit component'>
												<img src='${img}' alt='' name='deleteUPCKIT${loop.index}' border='0' id='deleteUPCKIT${loop.index}' />
											</a>
											<c:url var="imgSave" value="${request.getContextPath()}/hebAssets/images/saveIcon.jpg" />
											<a href="#" target="_parent" id="saveUPCKIT${loop.index}"
											   onclick='javascript:return false;' style="display: none;" title='Update this Kit component'>
												<img alt="" src="${imgSave}" name="saveUPCKIT${loop.index}" border="0" id="saveUPCKIT${loop.index}" />
											</a>
										</jsp:attribute>
									</cps:renderByResourceAccess>
								</td>
								<td align="left" width="5%">
									<cps:renderByResourceAccess resourceId="276">
										<jsp:attribute name="EDIT">
											<c:url var="imgEdit" value="${request.getContextPath()}/hebAssets/images/modify.png" />
											<a href="#" target="_parent" id="editUPCKIT${loop.index}"
											   onclick='javascript:return false;' title='Edit quantity of this Kit component'>
												<img alt="" src="${imgEdit}" name="editUPCKIT${loop.index}" border="0" id="editUPCKIT${loop.index}" />
											</a>
											<c:url var="imgRevert" value="${request.getContextPath()}/hebAssets/images/revertIcon.jpg" />
											<a href="#" target="_parent" id="revertUPCKIT${loop.index}"
											   onclick='javascript:return false;' style="display: none;" title='Revert quantity of this Kit component'>
												<img alt="" src="${imgRevert}" name="revertUPCKIT${loop.index}" border="0" id="revertUPCKIT${loop.index}" />
											</a>
										</jsp:attribute>
									</cps:renderByResourceAccess>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</td>
		</tr>
	</table>
	<br />
	<table width="100%" border="0">
		<tr>
			<td>
				<table id="upcKitInputTable" width="100%" cellspacing="0">
					<tbody align="center">
						<tr class="labelFont" align="center">
							<td width="13%" align="center">
								<cps:renderByResourceAccess resourceId="276">
									<jsp:attribute name="EDIT">
										<input value="${addNewCandidate.dummyProperty}" size="20" maxlength="13" tabindex="610"
												   id="unitUPCKit" style="dataType : numeric;"
												   onkeyup="autotabUPC(this);return true;" />
										<input type="hidden" id="upcDigit" style="dataType: numeric; width: 10px;"
													 value="${addNewCandidate.dummyProperty}" onblur="verifyCheckUPCKitDigit();" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input value="${addNewCandidate.dummyProperty}" size="20" tabindex="611" id="unitUPC" style="dataType : numeric;" disabled="true" />
										<input type="hidden" id="upcDigit" style="dataType: numeric; width: 10px;"
													 value="${addNewCandidate.dummyProperty}" onblur="verifyCheckUPCKitDigit();"
													 disabled="disabled" />
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</td>
							<td width="13%" align="center">
								<cps:renderByResourceAccess resourceId="276">
									<jsp:attribute name="EDIT">
										<input value="${addNewCandidate.dummyProperty}" size="20" maxlength="5" tabindex="613"
													id="quantity" onblur="IsNumeric(this);"
													style="dataType : numeric;" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input value="${addNewCandidate.dummyProperty}" size="20" maxlength="5" tabindex="613" id="quantity" onblur="IsNumeric(this);"
													style="dataType : numeric; text-align: center;" disabled="disabled" />
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</td>
							<td width="13%" align="center">
								<cps:renderByResourceAccess resourceId="276">
									<jsp:attribute name="EDIT">
										<input value="${addNewCandidate.dummyProperty}" size="30" maxlength="5" id="description" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input value="${addNewCandidate.dummyProperty}" size="30" maxlength="5" id="description" disabled="disabled" />
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</td>
							<td width="13%" align="center">
								<cps:renderByResourceAccess	resourceId="276">
									<jsp:attribute name="EDIT">
										<input value="${addNewCandidate.dummyProperty}" size="15" maxlength="5" id="avgCost" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input value="${addNewCandidate.dummyProperty}" size="15" maxlength="5" id="avgCost" disabled="disabled" />
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</td>
							<td width="13%" align="center">
								<cps:renderByResourceAccess	resourceId="276">
									<jsp:attribute name="EDIT">
										<input value="${addNewCandidate.dummyProperty}" size="15" maxlength="5" id="retailKit" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input value="${addNewCandidate.dummyProperty}" size="15" maxlength="5" id="retailKit" disabled="disabled" />
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</td>
							<td width="13%" align="center">
								<cps:renderByResourceAccess	resourceId="276">
									<jsp:attribute name="EDIT">
										<input value="${addNewCandidate.dummyProperty}" size="15" maxlength="5" id="extendedCost" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input value="${addNewCandidate.dummyProperty}" size="15" maxlength="5" id="extendedCost" disabled="disabled" />
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</td>
							<td width="13%" align="center">
								<cps:renderByResourceAccess	resourceId="276">
									<jsp:attribute name="EDIT">
										<input value="${addNewCandidate.dummyProperty}" size="15" maxlength="5" id="extendedRetail" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input value="${addNewCandidate.dummyProperty}" size="15" maxlength="5" id="extendedRetail" disabled="disabled"/>
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</td>
							<td width="10%" align="left" colspan="2">
								<cps:renderByResourceAccess resourceId="276">
									<jsp:attribute name="EDIT">
										<button type="button" id="kitAddButton" name="kitAddButton" value="Add"
												tabindex="614" style="width: 10em;">
											Add
										</button>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<button type="button" id="kitAddButton" name="kitAddButton" value="Add"
												tabindex="614" style="width: 10em;" disabled>
											Add
										</button>
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</table>
	<table width="100%" border="0">
		<tr>
			<td colspan="3"  width="66%">
			</td>
			<td align="left"  colspan="2" width="13%">
				<span style="font-weight:bold;padding-left: 20px;">Kit Cost</span>&nbsp;&nbsp;&nbsp;<span id="kitCost" ></span>
				<form:hidden styleId="hiddenKitCost" id="hiddenKitCost" path="hiddenKitCost"/>
			</td>
			<td align="left" colspan="2">
				<span style="font-weight:bold;">Kit Retail</span>&nbsp;&nbsp;&nbsp;<span id="kitRetail" ></span>
			</td>
		</tr>
	</table>
</fieldset>

<script type="text/javascript">
	var oPushButton2 = new YAHOO.widget.Button("kitAddButton");
	var unitUPCTxt = YAHOO.util.Dom.get("unitUPCKit");
	var quantityTxt = YAHOO.util.Dom.get("quantity");
	//var upcDigitTxt = YAHOO.util.Dom.get("upcDigit");
	var upcKitTableBody = document.getElementById("upcKitTable");
	var addCount = 0;
	var mrtSize = ${AddNewCandidate.productVO.upcKitVOSize};
	var hiddenButtonName = null;
	var hiddenButtonCount;
	var selectedUPCRow = "";
	var selectedChildNodes = "";
	var hiddenQuantity = "";
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("kitAddButton"), "click", addUPCKit); 
	function addEvents(){
		var uniqId;
		var cnt;
		var butn;
		var arr;
		<c:forEach items="${addNewCandidate.productVO.upcKitVOs}" var="upc" varStatus="loop" >
			uniqId = '<c:out value="${upc.uniqueId}"></c:out>';
			cnt = ${loop.index};
			arr = [cnt,"hiddenNormal"];
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteUPCKIT${count}"), "click",deleteUPCKIT,arr);
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("editUPCKIT${count}"), "click",editUPCKIT,arr);
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveUPCKIT${count}"), "click",saveUPCKIT,arr);
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("revertUPCKIT${count}"), "click",revertUPCKIT,arr);
		</c:forEach>
	}
	initData();
	
	function addUPCKit(){
		var unitUPCValue = trim(unitUPCTxt.value);
		var quantity = quantityTxt.value;
		//var upcDigit = upcDigitTxt.value;
		if(unitUPCValue=="") {
			 alert('Please enter the Unit UPC');
			 return true;
		}
		var messageCheck = validateQuantity(quantity);
		if(messageCheck == 'true') {  //null != quantity && "" != quantity && 0 != Number(quantity)){
			if(quantity.indexOf('0')==0){
				quantity = Number(quantity);
				quantity.value = quantity;
			}
			/*if(upcDigit!="" && null != upcDigit) {
				showProgress();
				AddCandidateTemp.addUPCKit(unitUPCValue,quantity,upcDigit,getDWRCallbackMethod(addRowToUpcKitTable));
			} else {
			   alert('Please enter the Check Digit');
			   return true;
			}*/
			showProgress();
			AddCandidateTemp.addUPCKit(unitUPCValue,quantity,'',getDWRCallbackMethod(addRowToUpcKitTable));
		} else {
			alert(messageCheck);
			quantityTxt.focus();
			/*if(trim(quantity)=='') {
				alert('Please enter a quantity for Kit component UPC(s)');
			} else if(0 == Number(quantity)){
				alert('Quantity should be greater than 0');
			} else if(quantity.indexOf('0')==0){
				alert('Quantity should be a number');
			} */
		}
	}
	
	function addRowToUpcKitTable(data){
		hideProgress();
	    if(data.message !="" && data.message !=null) {
	       	alert(data.message);
			unitUPCTxt.value='';
			quantityTxt.value='';
			//upcDigitTxt.value='';
			unitUPCTxt.focus();
	    } else {
	       document.getElementById("unitUPCKit").value =data.unitUPC;
	       addCount++;	
			var rowLength = upcKitTableBody.rows.length; 
			var newRow = upcKitTableBody.insertRow(-1);
			newRow.id = "caseAjax"+addCount;
			newRow.style.fontFamily = 'Verdana, Arial, Helvetica, sans-serif';
			newRow.style.fontSize = '12px';		
			var classAppend = rowLength % 2;
			if(classAppend == 0){
			var col;
				col = "#F7F7F7";
			}else{
				col = "#FFFFFF";
			}
			rowLength--;
			<c:url var="img" value="${request.getContextPath()}/hebAssets/images/trash.png"/>
			<c:url var="imgEdit" value="${request.getContextPath()}/hebAssets/images/modify.png"/>
			<c:url var="imgSave" value="${request.getContextPath()}/hebAssets/images/saveIcon.jpg"/>
		    <c:url var="imgRevert" value="${request.getContextPath()}/hebAssets/images/revertIcon.jpg"/>
			var butId = "checkAjax"+addCount;
			var btnEditId = "editAjax" + addCount;
			var btnSaveId = "saveAjax" + addCount;
			var btnRevertId = "revertAjax" + addCount;
			var delAndSave = "<div style='width: 5%; float: left'><a href='#' target='_parent' id ='"+butId +"'onclick='javascript:return false;' title='Delete this Kit component'><img src='${img}' alt='' name='"+butId+"'  border='0' id='"+butId+"'/></a>" +
			                "<a href='#' target='_parent' id ='"+btnSaveId +"'onclick='javascript:return false;' style='display: none;' title='Update this Kit component'><img src='${imgSave}' alt='' name='"+btnSaveId+"'  border='0' id='"+btnSaveId+"'/></a></div>";
			var editAndRevert = "<div style='width: 5%; float: left'><a href='#' target='_parent' id ='"+btnEditId +"'onclick='javascript:return false;' title='Edit quantity of this Kit component'><img src='${imgEdit}' alt='' name='"+btnEditId+"'  border='0' id='"+btnEditId+"'/></a>" +
				            "<a href='#' target='_parent' id ='"+btnRevertId +"'onclick='javascript:return false;' style='display: none;' title='Revert quantity of this Kit component'><img src='${imgRevert}' alt='' name='"+btnRevertId+"'  border='0' id='"+btnRevertId+"'/></a></div>";
            var description = data.description;
			var avgCostId = "avgCost";
			var rowData = [ 
			data.unitUPC,
			//data.upcDigit,
			data.quantity, 
			description+'<input type="hidden" id="hiddenAjax'+addCount+'" value="'+data.uniqueId+'"/>'+
			            '<input type="hidden" id="hiddenAjaxQuantity' + addCount + '" value="' + data.quantity + '"/>' +
			            '<input type="hidden" id="hiddenAjaxIsTaxable' + addCount + '" value="' + data.taxable + '"/>',
			"<div style='float:right;padding-right:60px;margin:0px' id='avgCostWrap'>"+parseFloat(data.avgCostLabel).toFixed(4)+"</div>",
			parseFloat(data.retail).toFixed(2),
			"<div style='float:right;padding-right:60px;margin:0px' id='extendedCostWrap'>" + parseFloat(data.avgCostLabel * data.quantity).toFixed(4) + "</div>",
			parseFloat(data.retail * data.quantity).toFixed(2),
			delAndSave,
			editAndRevert
			];
		
			for (var i = 0; i < rowData.length; i++) {
		        newCell = newRow.insertCell(i);
		        newCell.style.backgroundColor = col;
		        /* //position of Edit Icon
				if(i > 5) {
					newCell.style.textAlign ='left';
				} */
		        newCell.innerHTML = (null != rowData[i] || '' != rowData[i]) ? rowData[i] : '';
		  	}
	  		var tmpTmp = "caseAjax"+addCount;
	  		var idI = data.uniqueId;
	  		var tempCount = addCount;
	  		var arrr = [ tempCount, "hiddenAjax" ];
	  		//var delBut = new YAHOO.widget.Button(butId);
	  		YAHOO.util.Event.addListener(YAHOO.util.Dom.get(butId), "click", deleteUPCKIT,arrr);
	  		YAHOO.util.Event.addListener(YAHOO.util.Dom.get(btnEditId), "click", editUPCKIT,arrr);
            YAHOO.util.Event.addListener(YAHOO.util.Dom.get(btnSaveId), "click", saveUPCKIT,arrr);
            YAHOO.util.Event.addListener(YAHOO.util.Dom.get(btnRevertId), "click", revertUPCKIT,arrr);
	  		
			document.getElementById("unitUPCKit").value="";
			document.getElementById("quantity").value="";
			//document.getElementById("upcDigit").value="";
	  		resetRemovedButtonsUPCKIT();
	  		hideDeleteButtonUPCKIT();
			calculateKitCost();
	  	}
	}
	
	function resetRemovedButtonsUPCKIT(){
		var tempName = null;
		if(null!=hiddenButtonName){
	        var arrr = [ hiddenButtonCount, hiddenButtonName];
	        if(hiddenButtonName == "hiddenAjax") {
	        	tempName = "checkAjax";
	        }
	        else {
	        	tempName = "deleteUPCKIT";
	        }
	       new YAHOO.widget.Button(tempName+hiddenButtonCount);
	   	   YAHOO.util.Event.addListener(YAHOO.util.Dom.get(tempName+hiddenButtonCount), "click", deleteUPCKIT,arrr);
	   	   YAHOO.util.Dom.get(tempName+hiddenButtonCount).disabled = false;
	   	   hiddenButtonName = null;
		 }
	}
	
	function hideDeleteButtonUPCKIT(){
		var totalCount=0;
		var singleButtonType;
		var singleButtonCount;
		var uniqueIdType;
		for (var i = 0; i <= addCount; i++) {
		 if( document.getElementById("checkAjax"+i+"")){
		      singleButtonType = "checkAjax";
		      uniqueIdType ="hiddenAjax";
		      singleButtonCount = i;
		      totalCount++;
		  }
		}
		if(mrtSize>0) {
			for (var i = 0; i < mrtSize; i++) {
			  if( document.getElementById("deleteUPCKIT"+i+"")){
			   singleButtonType = "deleteUPCKIT";
			   uniqueIdType ="hiddenNormal";
			   singleButtonCount = i;
			   totalCount++;
			  }
			}
		}
	}
	
	function deleteUPCKIT(evt,arr){
		var tempName="";
		 var c = arr[1];
	    if(c == "hiddenAjax") {
	       tempName = "caseAjax";
	    } else {
	       tempName = "caseRow";
	    }
		
		selectedUPCRow = tempName+arr[0];
		var d= arr[1]+arr[0];
		var k= document.getElementById(d).value;
		var message = confirm('Are you sure you want to remove this row?');
    	if(message){
    		showProgress();
    		AddCandidateTemp.deleteUPCKit(k,getDWRCallbackMethod(callBackValueUPCKIT));
    	}
	}
	
	function callBackValueUPCKIT(data){
		deleteRowWithButtonUPCKIT(selectedUPCRow);
		hideDeleteButtonUPCKIT();
		calculateKitCost();
	}
	
	function deleteRowWithButtonUPCKIT(rowId){
	 	hideProgress();
		for(var i=0;i < upcKitTableBody.rows.length;i++){
			if( upcKitTableBody.rows[i].id == rowId){
				upcKitTableBody.deleteRow(i);
				colorTableRows('upcKitTable');
				break;
			}
		}
	}
	
	function verifyCheckUPCKitDigit(){
		var unitUPCValue = unitUPCTxt.value;
	    var unitUPCCheckDigitValue = upcDigitTxt.value;
	    if(unitUPCCheckDigitValue!="" && null != unitUPCCheckDigitValue) {
		     AddCandidateTemp.verifyCheckDigit(trim(unitUPCValue),unitUPCCheckDigitValue,getDWRCallbackMethod(returnDataUPCKIT));
	    }
	}

	function returnDataUPCKIT(data) {
		if('firstTimeError' == data.message || 'secondTimeError' == data.message){
			 unitUPCTxt.focus();
			 unitUPCTxt.select();
		  	alert('InValid Check Digit. Please Re-enter the UPC/Checkdigit Value');
		 }else if('numberFormatError' == data.message){
			 unitUPCTxt.focus();
			 unitUPCTxt.select();
		 	 alert('Unit UPC/check digit should be in number format');
		 }
	}
	
	function autotabUPC(original){
		if(original.value.length == original.getAttribute("maxlength")){
			//upcDigitTxt.focus();
		}
	}

	function initData() {
		var totalKitCost = 0;
		var uniqId;
		var cnt;
		var arr;
		var count=0;
		var totalKitRetail=0;
		var sumTaxable = 0;
		var sumNonTaxable = 0;
		<c:forEach items="${addNewCandidate.productVO.upcKitVOs}" var="upc" varStatus="loop" >
			avgCostVal = '<c:out value="${upc.avgCost}"></c:out>';
			quantity = '<c:out value="${upc.quantity}"></c:out>';
			uniqId = '<c:out value="${upc.uniqueId}"></c:out>';
			retail = '<c:out value="${upc.retail}"></c:out>';
			cnt = ${loop.index};
			arr = [cnt,"hiddenNormal"];
			totalKitCost +=avgCostVal*quantity;
			totalKitRetail +=retail*quantity;
			count++;
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteUPCKIT${loop.index}"), "click",deleteUPCKIT,arr);
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("editUPCKIT${loop.index}"), "click",editUPCKIT,arr);
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveUPCKIT${loop.index}"), "click",saveUPCKIT,arr);
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("revertUPCKIT${loop.index}"), "click",revertUPCKIT,arr);
		</c:forEach>
		document.getElementById("kitCost").innerHTML = (count>0 ? "$"+parseFloat(totalKitCost).toFixed(4):"");
		document.getElementById("kitRetail").innerHTML = (count>0 ? "$"+parseFloat(totalKitRetail).toFixed(2):"");
		document.getElementById("hiddenKitCost").value = (count>0 ? "" + parseFloat(totalKitCost).toFixed(4) : "");
    }
	
	function editUPCKIT(evt, arr) {
		var btn = "btnEditToggle";
		toggleButtonsDESR(arr, btn);
		
		executeButtonsESR(arr, btn);
	}
	
	function saveUPCKIT(evt, arr) {
		var btn = "btnSaveToggle";
        toggleButtonsDESR(arr, btn);
        
        executeButtonsESR(arr, btn);
    }
	
	function revertUPCKIT(evt, arr) {
		var btn = "btnRevertToggle";
        toggleButtonsDESR(arr, btn);
        
        executeButtonsESR(arr, btn);
    }
	
	function toggleButtonsDESR(arr, btn) {
		var tempDel = "";
		var tempName = "";
        var typeId = arr[1];
        if (typeId == "hiddenAjax") {
        	tempDel = "checkAjax";
            tempName = "Ajax";
        } else {
        	tempDel = "deleteUPCKIT";
            tempName = "UPCKIT";
        }
        
        var dispBtnDE = "";
        var dispBtnSR = "";
        if (btn == "btnEditToggle") {
        	dispBtnDE = 'none';
        	dispBtnSR = 'block';
        } else {
        	dispBtnDE = 'block';
            dispBtnSR = 'none';
        }

        var btnDeleteSelected = tempDel + arr[0];
        var btnEditSelected = "edit" + tempName + arr[0];
        var btnSaveSelected = "save" + tempName + arr[0];
        var btnRevertSelected = "revert" + tempName + arr[0];
        document.getElementById(btnDeleteSelected).style.display=dispBtnDE;
        document.getElementById(btnEditSelected).style.display=dispBtnDE;
        document.getElementById(btnSaveSelected).style.display=dispBtnSR;
        document.getElementById(btnRevertSelected).style.display=dispBtnSR;
	}
	
	function executeButtonsESR(arr, btn) {
		var tempName="";
        var typeId = arr[1];
        if(typeId == "hiddenAjax") {
            tempName = "caseAjax";
        } else {
            tempName = "caseRow";
        }
        var selectedRow = tempName + arr[0];
        selectedChildNodes = document.getElementById(selectedRow).getElementsByTagName("td");
        hiddenQuantity = arr[1] + "Quantity" + arr[0];
        var valueRevert = document.getElementById(hiddenQuantity).value;
        
        if (btn == "btnEditToggle") {
        	var inputQuantity = '<input type="number" maxlength="5" size="20" value="'+valueRevert+'" onblur="IsNumeric(this);" id="newQuantity'+arr[0]+'" style="dataType : numeric;">';
        	selectedChildNodes[1].innerHTML = inputQuantity;
        	document.getElementById("newQuantity" + arr[0]).focus();
        } else if (btn == "btnRevertToggle") {
            selectedChildNodes[1].innerHTML = valueRevert;
        } else if (btn == "btnSaveToggle") {
        	var newValueQuantity = document.getElementById("newQuantity" + arr[0]).value;
        	var messageCheck = validateQuantity(newValueQuantity);
        	if (newValueQuantity == valueRevert) {
        		selectedChildNodes[1].innerHTML = valueRevert;
        	} else if (messageCheck == "true") {
        		if (newValueQuantity.indexOf('0') == 0){
                    newValueQuantity = Number(newValueQuantity);
                    newValueQuantity.value = newValueQuantity;
                }
                var hiddenUniqueId = arr[1] + arr[0];
                var strUniqueId = document.getElementById(hiddenUniqueId).value;
                showProgress();
                AddCandidateTemp.updateUPCKit(strUniqueId,newValueQuantity,getDWRCallbackMethod(returnUpdatedUPCKit));
        	} else {
        		//selectedChildNodes[1].innerHTML = valueRevert;
        		alert(messageCheck);
        		document.getElementById("newQuantity" + arr[0]).focus();
        		toggleButtonsDESR(arr, "btnEditToggle");
        	}
        }
	}
	
	function returnUpdatedUPCKit(data) {
		selectedChildNodes[1].innerHTML = data.quantity;
        document.getElementById(hiddenQuantity).value = data.quantity;
		// calculate extended cost and extended retail
		selectedChildNodes[5].innerHTML = "<div style='float:right;padding-right:60px;margin:0px' id='extendedCostWrap'>" + parseFloat(data.avgCostLabel * data.quantity).toFixed(4) + "</div>";
		selectedChildNodes[6].innerHTML = parseFloat(data.retail * data.quantity).toFixed(2);
        hideProgress();
        calculateKitCost();
	}
	
	// method to check quantity of Kit Components and return message
	function validateQuantity(quantity) {
		var check = "";
		if (isNumericPositive(quantity)){
            check = "true";
        } else {
            if (trim(quantity) == '') {
                check = 'Please enter a quantity for Kit component UPC(s)';
            } else if (Number(quantity) <= 0){
                check = 'Quantity should be greater than 0';
            } else if (quantity.indexOf('0') == 0 || isNaN(quantity)){
                check = 'Quantity should be a number';
            }
        }
		return check;
	}

	// method to check a number is a positive integer or not.
	function isNumericPositive(n) {
		  return !isNaN(parseFloat(n)) && isFinite(n) && parseInt(n) > 0;
	}
	
	function calculateKitCost() {
		var totalKitCost=0;
		var totalKitRetail=0;
		var sumTaxable = 0;
		var sumNonTaxable = 0;
		
		for(var i=0;i < upcKitTableBody.rows.length;i++){
			var avgCostInner = upcKitTableBody.rows[i].cells[3].getElementsByTagName("div")[0].innerHTML;
			var retailInner = upcKitTableBody.rows[i].cells[4].innerHTML;
			// hidden quantity is in the second hidden input, but the third if editing quantity input
			var indexQuantity = upcKitTableBody.rows[i].getElementsByTagName("input").length == 3 ? 1 : 2;
			var indexTaxable = upcKitTableBody.rows[i].getElementsByTagName("input").length == 3 ? 2 : 3;
			var quantityVal = upcKitTableBody.rows[i].getElementsByTagName("input")[indexQuantity].value;
			var taxable = upcKitTableBody.rows[i].getElementsByTagName("input")[indexTaxable].value;
			totalKitCost += quantityVal * avgCostInner;
			totalKitRetail += quantityVal * retailInner;
			// calculate sum of retail of all the taxable items and the non-taxable items
			if (taxable == 'true') {
				sumTaxable += quantityVal * retailInner;
			} else {
				sumNonTaxable += quantityVal * retailInner;
			}
		}
		document.getElementById("kitCost").innerHTML = upcKitTableBody.rows.length>0 ? "$"+parseFloat(totalKitCost).toFixed(4) : "";
		document.getElementById("kitRetail").innerHTML = upcKitTableBody.rows.length>0 ? "$"+parseFloat(totalKitRetail).toFixed(2) : "";
        document.getElementById("suggRetail").innerText = (upcKitTableBody.rows.length>0 ? "1" : "");
        document.getElementById("suggforPrice").innerText = (upcKitTableBody.rows.length>0 ? ""+parseFloat(totalKitRetail).toFixed(2) : "");
        document.getElementById("hiddenKitCost").value = (upcKitTableBody.rows.length>0 ? "" + parseFloat(totalKitCost).toFixed(4) : "");

		if (sumTaxable > sumNonTaxable || (upcKitTableBody.rows.length > 0 && sumTaxable == sumNonTaxable) && Number(sumTaxable) > 0) {
			// if sum of retail of all the taxable items greater than or equal to sum of retail of all the non-taxable items
			// then Kit is taxable
			document.getElementById("taxabilityFlag").checked = true;
		} else {
			// if sum of retail of all the non-taxable items greater than sum of retail of all the taxable items
			// then Kit is non-taxable
			document.getElementById("taxabilityFlag").checked = false;
		}
	}
</script>
