<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>View Stores</title>
<c:url value="${request.getContextPath()}/dwr/engine.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="${request.getContextPath()}/dwr/util.js" var="styleURL" />
<c:url value="${request.getContextPath()}/dwr/interface/AddCandidateTemp.js" var="myJs" />
<script type="text/javascript" src="${myJs}"></script>
<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />

<jsp:include page="/common_head.jsp" />
<c:url value="${request.getContextPath()}/hebAssets/tablesorter.js"
	var="sorter" />
<script type="text/javascript" src="${sorter}"></script>
</head>
<body style="visibility: visible; background-color: #FFFFFF;">
	<%
	  String caseUniquId = request.getParameter("selectedItemId");
	  String firstUniqueIdVendor = request.getParameter("firstUniqueIdVendor");
	  String selectedVendorUniq = request.getParameter("selectedVendorUniq");
	  String selectedVendorId = request.getParameter("selectedVendorId");
	  
	%>
	<!-- END HEADER INCLUDE -->
	<!-- End of Header -->
	<div id="container" style="height: 170px;">
		<form:form action="/protected/cps/add"
			id="viewStoresForm" modelAttribute="addNewCandidate">
			<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<jsp:include page="/cpsErrors.jsp" />
			<form:hidden path="productVO.classificationVO.productType"
				id="productType" />
			<c:set var="updateStore" value="" />
			<c:if test="${CPSForm.preventUpdateStore eq true}">
				<c:set var="updateStore" value="disabled='disabled'" />
			</c:if>
			<c:set var="listCostOri" value="${CPSForm.listCost}" />
			<c:set var="vendorDCM" value="${CPSForm.preventUpdateStore}" />
			<table width="100%">
				<tr>
					<td width="100%" align="center">
						<fieldset
							style="width: 97%; height: 95%; background-color: #FFFFFF;">
							<legend class="legendFont">Store Authorization</legend>
							<br />
							<table border="0" width="100%" align="center">
								<tr align="left">
									<td align="right" width="10%"><label class="labelFont">Cost
											Group </label></td>
									<td align="left" width="15%">&nbsp;&nbsp; <c:choose>
											<c:when test="${CPSForm.costGroupContainsOne}">
												<form:select path="costGroup" tabindex="2"
													id="costGp" value="1" cssClass="selectBoxStyle2"
													onchange="onCostGroupChange();">
													<form:options items="${AddNewCandidate.costGroups}" itemLabel="name"
														itemValue="id" />
												</form:select>
											</c:when>
											<c:otherwise>
												<form:select path="costGroup" tabindex="2"
													id="costGp" cssClass="selectBoxStyle2"
													onchange="onCostGroupChange();">
													<form:options items="${AddNewCandidate.costGroups}" itemLabel="name"
														itemValue="id" />
												</form:select>
											</c:otherwise>
										</c:choose> &nbsp;&nbsp;&nbsp;&nbsp;
									</td>
									<td colspan="5">&nbsp;</td>

								</tr>
								<tr align="left">
									<td align="right" width="10%"><label class="labelFont">List
											Cost</label></td>
									<td align="left" width="15%">
										<!--<form:input path="listCost"
						id="listCostFld" cssClass="textFieldNormal" maxlength="7"
						size="" tabindex="14" style="dataType: float;"
						onkeydown="return onKeyDownListCost(event, this);"
							onblur="validateListCost(this);" />--> <input type="text"
										value="${CPSForm.listCost}" id="listCostFld" maxlength="10"
										class="textFieldNormal" style="dataType: float;" size="8"
										onkeydown="return onKeyDownListCost(event, this);"
										onblur="validateListCost(this);" tabindex="14" />
									</td>
									<td align="left" width="12%">
										<button type="button" id="storeUpdate" name="storeUpdate"
											value="update">Update</button>
									</td>
									<td align="left" width="27%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
									<td align="right" width="12%"></td>
									<td align="right" width="12%"></td>
								</tr>
								<tr>
									<td colspan="6" valign="top">
										<div id="data"
											style="height: 270px; overflow-y: auto; overflow-x: hidden; border: 1px solid black; vertical-align: top"></div>
									</td>
								</tr>
								<tr>
									<td colspan="6">
										<div style="width: 94%;">
											<table width="96%" border="0" cellspacing="0" cellpadding="2"
												class="dataGrid">
												<tr align="right">
													<td align="right" width="88%">
														<button type="button" id="storeSave1" name="storeSave1"
															value="save">Save</button>
													</td>
													<td align="right" width="8%">
														<button type="button" id="storeCancel1"
															name="storeCancel1" value="cancel">Cancel</button>
													</td>
												</tr>
											</table>
										</div>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</table>

			<input type="hidden" id="listCostHiddenValue" value="listCost" />
			<div style="display: none;">
				<c:set var="count" value="-1"></c:set>
				<c:forEach items="${addNewCandidate.costGroups}" var="costGroupVO" varStatus="loop" >
					<c:choose>
						<c:when test="${loop.index == 0}">
							<c:set var="showIt" value="display: none;"></c:set>
						</c:when>
						<c:otherwise>
							<c:set var="showIt" value="display: none;"></c:set>
						</c:otherwise>
					</c:choose>
					<input type="hidden" id="listCost${costGroupVO.id}" value="" />

					<div id="costGroupTableDiv${costGroupVO.id}" style="${showIt}">
						<table align="center" width="100%" border="0" cellspacing="0"
							cellpadding="2" class="dataGrid">
							<thead>
								<tr>
									<th class="sorttable_nosort dataGridHead" align="center"
										class="labelFont" width="16%">Action</th>
									<th class="dataGridHead" class="labelFont" align="center"
										width="12%" style="cursor: hand;">Vendor Number</th>
									<th class="dataGridHead" class="labelFont" align="center"
										width="10%" style="cursor: hand;">Cost Group</th>
									<th class="dataGridHead" class="labelFont" align="center"
										width="10%" style="cursor: hand;">Store</th>
									<th class="sorttable_alpha dataGridHead" class="dataGridHead"
										class="labelFont" align="center" width="20%"
										style="cursor: hand;">Store Abbreviation</th>
									<th class="sorttable_nosort dataGridHead" class="labelFont"
										align="center" width="18%">List Cost</th>
									<th class="dataGridHead" class="labelFont" align="center"
										width="14%" style="cursor: hand;"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="upc"
									items='${addNewCandidate.costGrpStoreMap[costGroupVO.id]}'>
									<c:set var="count" value="${count+1}"></c:set>
									<tr class="labelFont">
										<td align="center" class="labelFont"><c:if
												test="${upc.storeRemoved eq false}">
												<div id="removeStoreDiv${count}" style="display: block;">
													<input type="Button" value="Remove Store"
														id="removeStore${count}" />
												</div>
												<div id="addStoreDiv${count}" style="display: none;">
													<input type="Button" value="Add Store"
														id="addStore${count}" />
												</div>
											</c:if> <c:if test="${upc.storeRemoved eq true}">
												<div id="removeStoreDiv${count}" style="display: none;">
													<input type="Button" value="Remove Store"
														id="removeStore${count}" />
												</div>
												<div id="addStoreDiv${count}" style="display: block;">
													<input type="Button" value="Add Store"
														id="addStore${count}" />
												</div>
											</c:if></td>
										<td align="center" class="labelFont"><font
											class="labelFont">
											<c:out value="${upc.vendorNumber}"></c:out>
										</font></td>
										<td align="center" class="labelFont"><font
											class="labelFont"> <c:out value="${upc.costGroup}"></c:out>
										</font></td>
										<c:set var="color" value="" />
										<c:if test="${upc.conflictStore eq true}">
											<c:set var="color" value="color='red'" />
										</c:if>
										<td align="center" class="labelFont"><font
											class="labelFont" ${color}> <c:out value="${upc.storeId}"></c:out>
										</font></td>
										<td align="center" class="labelFont"><font
											class="labelFont"> <c:out value="${upc.storeAbbreviation}"></c:out>
										</font></td>
										<td align="center" class="labelFont"><input type="hidden"
											id="store${count}"
											value="<c:out value="${upc.uniqueId}"></c:out>" /> <input
											type="text" id="list${count}" value="${upc.listCost}"
											maxlength="10" size="8" cssClass="textFieldNormal"
											style="dataType: float;"
											onkeydown="return onKeyDownListCost(event, this);"
											onblur="validateListCost(this);" ${updateStore} /></td>
										<td align="center" class="labelFont"><c:if
												test="${upc.storeRemoved eq false}">
												<div id="updateStoreDiv${count}" style="display: block;">
													<input type="Button" value="Update"
														id="updateStore${count}" ${updateStore} />
												</div>
											</c:if> <c:if test="${upc.storeRemoved eq true}">
												<div id="updateStoreDiv${count}" style="display: none;">
													<input type="Button" value="Update"
														id="updateStore${count}" ${updateStore} />
												</div>
											</c:if></td>
									</tr>
									<c:set var="cnt" value="${count}"></c:set>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:forEach>
			</div>


			<script type="text/javascript">
	//var caseUniquId = '${request.getParameter("selectedItemId")}';
	
	document.body.scroll = 'no';
	
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("storeUpdate"), "click", updateStore);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("storeSave1"), "click", saveViewStore);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("storeCancel1"), "click", toclose);

	<c:url value="/protected/cps/add/updateViewStores?${_csrf.parameterName}=${_csrf.token}" var="pageSrc" />
		var transaction = false;
		var textValue;
		var cnt = ${cnt} + 1;
	
		
	function updateStoreValue(evt){
		var costGp = document.getElementById('costGp').value;
		var listCostFld = document.getElementById('listCostFld').value;
		var clBack = function(data){listChangeCallback(data, listCostFld);};
		AddCandidateTemp.changeListCostByCostGp(costGp,listCostFld,getDWRCallbackMethod(clBack));
	}
	var arrUniqueId;	
	var arrStore;
	function updateStore(evt){
	    var listCostValue = document.getElementById('listCostFld').value;
		listCostValue = parseFloat(listCostValue);	
		if(isNaN(listCostValue)) {
			alert('The entered value is not a number, Please re-enter');
			YAHOO.util.Dom.get("listCostFld").focus(); 
			YAHOO.util.Dom.get("listCostFld").select(); 
		}else {
			if(listCostValue == 0){
			 	removeAllStore(evt, arrUniqueId, arrStore);
			} else {
			  if(listCostValue > 0){
	            var pre = listCostValue;
	            var listCostOriTemp = "${listCostOri}";
	            var listCostOri = "${listCostOri}";
	            var vendorDCM = "${vendorDCM}";
	            if(listCostOriTemp !=null && listCostOriTemp!=""){
	            	listCostOriTemp = parseFloat(listCostOriTemp);	
	            } else {
	            	listCostOriTemp = 0; 
	            }
				var minus = '';
				if(pre < 0) { minus = '';}
				pre = Math.abs(pre);
				pre = parseInt((pre + .00005) * 10000);
				pre = pre / 10000;
				s = new String(pre);
				/*if(s.indexOf('.') < 0) { s += '.0000'; }
				if(s.indexOf('.') == (s.length - 2)) { s += '0'; }*/
				s = formatValue(s);
				s = minus + s;
				document.getElementById('listCostFld').value = s;
				if(s > 99999.9999){
					alert('List cost value should not exceed $99999.9999');
			        YAHOO.util.Dom.get("listCostFld").focus(); 
			        YAHOO.util.Dom.get("listCostFld").select(); 
			        return;
				} else if(vendorDCM == 'true' && listCostOriTemp!= listCostValue){
					listCostOri = parseFloat(listCostOri);	
	             	                var pre = listCostOri;	          
		                         var minus = '';
					if(pre < 0) { minus = '';}
					pre = Math.abs(pre);
					pre = parseInt((pre + .00005) * 10000);
					pre = pre / 10000;
					s = new String(pre);
					/*if(s.indexOf('.') < 0) { s += '.0000'; }
					if(s.indexOf('.') == (s.length - 2)) { s += '0'; }*/
					s = formatValue(s);
					s = minus + s;
	            	alert('List cost should be either 0.0000 or '+s);			
			               YAHOO.util.Dom.get("listCostFld").focus(); 
			               YAHOO.util.Dom.get("listCostFld").select(); 
			               return;
				}else{
					updateStoreValue();
				}
			 }else {
				alert('Please enter a value');
	       		 YAHOO.util.Dom.get("listCostFld").focus(); 
	      			  YAHOO.util.Dom.get("listCostFld").select(); 
	       		 return;
			}
		   }
		}
}
	
	function updateStoreData(evt, arr){
		var count = arr[0];
		var uniqId = arr[1];
		var listCostValue = YAHOO.util.Dom.get("list"+count).value;
		listCostValue = parseFloat(listCostValue);	
		if(isNaN(listCostValue)){
				alert('The entered value is not a number, Please re-enter');
				YAHOO.util.Dom.get("list"+count).focus(); 
			    YAHOO.util.Dom.get("list"+count).select(); 
		}else if (listCostValue > 99999.9999){
			alert('List cost value should not exceed $99999.9999');
			YAHOO.util.Dom.get("list"+count).focus(); 
		    YAHOO.util.Dom.get("list"+count).select(); 
		}
		else {
			 if(listCostValue == 0){	
			 	removeStore(evt, arr);
			 }else {
				 if(listCostValue > 0){
			            var listCostOriTemp = "${listCostOri}";
			            var listCostOri = "${listCostOri}";
			            var vendorDCM = "${vendorDCM}";
			            if(listCostOriTemp !=null && listCostOriTemp!=""){
			            	listCostOriTemp = parseFloat(listCostOriTemp);	
			            } else {
			            	listCostOriTemp = 0; 
			            }
			            if(vendorDCM == 'true' && listCostOriTemp!= listCostValue){
			            	    listCostOri = parseFloat(listCostOri);	
			             	    var pre = listCostOri;	          
				            var minus = '';
					    if(pre < 0) { minus = '';}
					    pre = Math.abs(pre);
					    pre = parseInt((pre + .00005) * 10000);
					    pre = pre / 10000;
					    s = new String(pre);
					/*if(s.indexOf('.') < 0) { s += '.0000'; }
					    if(s.indexOf('.') == (s.length - 2)) { s += '0'; }*/
					    s = formatValue(s);
					    s = minus + s;
			            	    alert('List cost should be either 0.0000 or '+s);
			            	YAHOO.util.Dom.get("list"+count).focus(); 
			    		    YAHOO.util.Dom.get("list"+count).select(); 
			            } else {
					 var pre = listCostValue;
						var minus = '';
						if(pre < 0) { minus = '';}
						pre = Math.abs(pre);
						pre = parseInt((pre + .00005) * 10000);
						pre = pre / 10000;
						s = new String(pre);
						/*if(s.indexOf('.') < 0) { s += '.0000'; }
						if(s.indexOf('.') == (s.length - 2)) { s += '0'; }*/
						s = formatValue(s);
						s = minus + s;
						document.getElementById("list"+count).value = s;
						var costGp = document.getElementById('costGp').value;
						var listCostFld = YAHOO.util.Dom.get("list"+count).value
						var clBack = function(data){listChangeCallback(data, listCostFld);};
						AddCandidateTemp.updateListCostByCost(uniqId,listCostFld,getDWRCallbackMethod(clBack));
				}
				}
				else {
					alert('Please enter a value');
				YAHOO.util.Dom.get("listCostFld").focus(); 
				YAHOO.util.Dom.get("listCostFld").select(); 
				return;
				}
			}
		}
	}
	
	var firstUniqueIdVendor ='<%=firstUniqueIdVendor%>';
	var caseUniquId ='<%=caseUniquId%>';
	var selectedVendorUniq ='<%=selectedVendorUniq%>';
	var selectedVendorId ='<%=selectedVendorId%>';
	var addingStore706=false;
    function saveViewStore(evt){
		window.parent.showProgress();
	    document.getElementById('storeSave1').disabled=true;
	    document.getElementById('storeCancel1').disabled=true;
	    document.getElementById('storeUpdate').disabled=true;
//	 	HB-S21
		AddCandidateTemp.setStoreDetails(caseUniquId.toString(),addingStore706,getDWRCallbackMethod(callBackDetails));
	}
   
    function callBackDetails(data) {
   		document.getElementById('storeSave1').disabled=false;
   		document.getElementById('storeCancel1').disabled=false;
   		document.getElementById('storeUpdate').disabled=false;
		if(data != ""){	
			if(data =="fails"){
	        	alert(data);
	        	toclose();
	        }else if(data == "conflict") {			
	        	conflictChecking(true);			
				//window.parent.execScript('hideProgress();', "JavaScript");
			}else{
	        	if(data.indexOf("conflict") != -1){
					var psitemid = data.substring(8);
	        		window.parent.deleteCaseItemeDCFromTbl1(psitemid);
					
	        		conflictChecking(true);
					//QC-30
					if(firstUniqueIdVendor=="") {
						window.parent.hideProgress();
					}    		        			
				}else{
					window.parent.deleteCaseItemeDCFromTbl1(data);
					window.parent.showProgress();
					window.parent.beforeMorph(selectedVendorUniq.toString(),caseUniquId.toString(),selectedVendorId.toString());  
		        	toclose();
	        	}
	        }
	    } else {	
			toclose();
			if(selectedVendorUniq!="") {
				window.parent.showProgress();
				window.parent.beforeMorph(selectedVendorUniq.toString(),caseUniquId.toString(),selectedVendorId.toString());  
			}
	    }
    }
    <c:url value="/protected/cps/add/conflictStore?${_csrf.parameterName}=${_csrf.token}" var="storeConflict"></c:url>
	function conflictChecking(flag){
		 if(flag==true) { 
			window.parent.beginMorph = true;
		 }
		 document.forms[0].action = '${storeConflict}'+'&startingMorph='+flag+'&firstUniqueIdVendor='+firstUniqueIdVendor.toString()+'&caseUniquId='+caseUniquId.toString()+'&selectedVendorId='+selectedVendorId.toString();
		 document.forms[0].submit();
	}
	function resetValues(evt){
	document.getElementById('costGp').value = '1';
	document.getElementById('listCostFld').value = '';
	}	
		
	function toclose(evt){
	//window.parent.execScript('f2();');
	window.parent.hideProgress();
	window.parent.closeAuthorizeStroe();
	}
	
	function addStore(evt, arr){
		var count = arr[0];  
		var uniqId = arr[1]; 
		var storeId=arr[2];
		var clback = function(data){ addStoreCallBack(data, count) };
		AddCandidateTemp.addStore(uniqId,getDWRCallbackMethod(clback));
		if(storeId==706) {
			addingStore706 = true;
			window.parent.unAuthorizedStore706=true;
		}
	}
	function addStoreCallBack(data,count){
		YAHOO.util.Dom.get("list"+count).value= data;
		document.getElementById("addStoreDiv"+count).style.display = "none";
		document.getElementById("removeStoreDiv"+count).style.display = "block";
		document.getElementById("updateStoreDiv"+count).style.display = "block";
	}
	/*
	 * Remove all srores when user enter list cost is zero 
	 * @author khoapkl
	 */
	function removeAllStore(evt, arr,arrStore){
		var count = arr.length;
		var clback = function(data){ removeAllStoreCallBack(data, count); };
		for(i=0;i<arrStore.length;i++) {
			if(arrStore[i]!=null && arrStore[i]!="") {
				var stores = arrStore[i].toString().split(",");
				if(stores!=null && stores[1]==706) {
					addingStore706 = true;
					window.parent.unAuthorizedStore706=false;
					break;
				}
			}
		}
		AddCandidateTemp.removeAllStore(String(arr),getDWRCallbackMethod(clback));
	}
	

	function removeAllStoreCallBack(data,count){
		var temp = data;
		if(temp){
			var beginItem=0;
			if((lastItem-(count-1))>0) {
				beginItem=lastItem-count+1;
			} 
			for(i=beginItem;i<lastItem+1;i++) {
				YAHOO.util.Dom.get("list"+i).value="0.0000";
				document.getElementById("removeStoreDiv"+i).style.display = "none";
				document.getElementById("addStoreDiv"+i).style.display = "block";
				document.getElementById("updateStoreDiv"+i).style.display = "none";
			}
		}
	}
	function removeStore(evt, arr){
		var count = arr[0];
		var uniqId = arr[1];
		var clback = function(data){ removeStoreCallBack(data, count); };
		var storeId=arr[2];
		if(storeId==706) {
			addingStore706 = true;
			window.parent.unAuthorizedStore706=false;
		}
		AddCandidateTemp.removeStore(uniqId,getDWRCallbackMethod(clback));
	}
	
	function removeStoreCallBack(data,count){
		var temp = data;
		if(temp){
			YAHOO.util.Dom.get("list"+count).value="0.000";
			document.getElementById("removeStoreDiv"+count).style.display = "none";
		    document.getElementById("addStoreDiv"+count).style.display = "block";
		    document.getElementById("updateStoreDiv"+count).style.display = "none";
		}
	}
	
	function textFocus(evt,arr){
		var count = arr[0];
		var uniqId = arr[1];
		textValue = YAHOO.util.Dom.get("list"+count);
	}
	
	
	function textdown(evt,arr){
		if(window.event.keyCode == 13){
			textUnFocus(evt,arr);
		}	
	}
	
	function textUnFocus(evt,arr){
		var count = arr[0];
		var uniqId = arr[1];
		var value = YAHOO.util.Dom.get("list"+count).value;
		if(! value.match(textValue)){
			var clBack = function(data){ listChangeCallback(data, value);};
			AddCandidateTemp.changeListCost(uniqId,value,getDWRCallbackMethod(clBack));
		}
	}
	
	function listChangeCallback(data, value){
		for(var i=0;i<cnt;i++){
			var uniqId = YAHOO.util.Dom.get("store"+i).value;
			for(var y=0;y<data.length;y++){
				if(data[y].match(uniqId)){
				    	YAHOO.util.Dom.get("list"+i).value = value;
				    	document.getElementById("removeStoreDiv"+i).style.display = "block";
						document.getElementById("addStoreDiv"+i).style.display = "none";
						document.getElementById("updateStoreDiv"+i).style.display = "block";
					break;
				}
			}
		}
		if(0==value){
			for(var i=0;i<cnt;i++){
				var uniqId = YAHOO.util.Dom.get("store"+i).value;
				for(var y=0;y<data.length;y++){
					if(data[y].match(uniqId)){
						document.getElementById("removeStoreDiv"+i).style.display = "none";
						document.getElementById("addStoreDiv"+i).style.display = "block";
						document.getElementById("updateStoreDiv"+i).style.display = "none";
						break;
					}
				}
			}
		}	
	}

	function check() {
	    <c:if test="${CPSForm.rejectClose}">
	      var ex = "fromExecute();";
	     window.parent.fromExecute();
	   	 //window.parent.execScript("f2();");
		 window.parent.hideProgress();
		 window.parent.closeAuthorizeStroe();

	    </c:if>
    }
	var lastItem=0;
	function refreshButtonListeners(selCostGrp) {
		addingStore706 = false;
		<c:set var="count" value="-1"></c:set>
		var arrUpc = [];
		var arrStores = [];
		arrStore = new Array();
		arrUniqueId=new Array();
        <c:forEach items="${AddNewCandidate.costGroups}" var="costGroupVO" varStatus="loop" >
		if(selCostGrp == '<c:out value="${costGroupVO.id}"></c:out>'  )	{
			<c:forEach var="upc" items='${AddNewCandidate.costGrpStoreMap[costGroupVO.id]}'>
				<c:set var="count" value="${count+1}"></c:set>
		var arr = [];
		arr = [${count}, '${upc.uniqueId}','${upc.storeId}'];
		arrUpc = ['${upc.uniqueId}'];
		arrStores = ['${upc.storeId}'];
		arrStore.push(arrStores);
		arrUniqueId.push(arrUpc);
		YAHOO.util.Event.removeListener(YAHOO.util.Dom.get("removeStore${count}"), "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("removeStore${count}"), "click", removeStore,arr);
		YAHOO.util.Event.removeListener(YAHOO.util.Dom.get("addStore${count}"), "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addStore${count}"), "click", addStore,arr);
		YAHOO.util.Event.removeListener(YAHOO.util.Dom.get("updateStore${count}"), "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("updateStore${count}"), "click", updateStoreData,arr);
		lastItem=${count};
			</c:forEach>
		}
        </c:forEach>
		check(); 
	}

	function makeTableSortable(){
		var tables = document.getElementById("data").getElementsByTagName("table");
		if(tables && tables.length > 0){
			sorttable.makeSortable(tables[0]);
		}
	}


	function onCostGroupChange(){
		var costGrp = YAHOO.util.Dom.get("costGp");	
		if(costGrp.options.length > 0){
			var selCostGrp = costGrp.options[costGrp.selectedIndex].value; 	
			if(previousCostGrp != -1){		
				document.getElementById("listCost"+previousCostGrp).value = document.getElementById("listCostFld").value;
				document.getElementById("listCostFld").value = document.getElementById("listCost"+selCostGrp).value;
				document.getElementById("costGroupTableDiv" + previousCostGrp).innerHTML = document.getElementById("data").innerHTML;
				document.getElementById("data").innerHTML = document.getElementById("costGroupTableDiv"+selCostGrp).innerHTML;
				document.getElementById("costGroupTableDiv"+selCostGrp).innerHTML = "";	
				previousCostGrp = selCostGrp;
				refreshButtonListeners(selCostGrp);
				makeTableSortable();
			}
		}
	}
var previousCostGrp = -1;
if(YAHOO.util.Dom.get("costGp").options.length > 0){
	document.getElementById("data").innerHTML = document.getElementById("costGroupTableDiv"+YAHOO.util.Dom.get("costGp").options[YAHOO.util.Dom.get("costGp").selectedIndex].value).innerHTML;
	document.getElementById("costGroupTableDiv"+YAHOO.util.Dom.get("costGp").options[YAHOO.util.Dom.get("costGp").selectedIndex].value).innerHTML = "";	
	previousCostGrp = YAHOO.util.Dom.get("costGp").options[YAHOO.util.Dom.get("costGp").selectedIndex].value;
	for(var i = 0; i < YAHOO.util.Dom.get("costGp").options.length; i++){
		document.getElementById("listCost"+YAHOO.util.Dom.get("costGp").options[i].value).value = document.getElementById("listCostFld").value;	
	}	
	refreshButtonListeners(YAHOO.util.Dom.get("costGp").options[YAHOO.util.Dom.get("costGp").selectedIndex].value);
	makeTableSortable();
}


function formatValue(t){
	if(t.indexOf('.') < 0){ 
		t += '.0000'; 
	}
	if(t.indexOf('.') == (t.length - 2)){ 
	    t += '000'; 
	}
	if(t.indexOf('.') == (t.length - 3)){ 
	    t += '00'; 
	}
	if(t.indexOf('.') == (t.length - 4)){ 
	    t += '0'; 
	}
	return t;
}
function validateListCost(data){
   	var producSellable = true;
   	if(document.getElementById('productType')){
   		if(document.getElementById('productType').value == 'SPLY'){
   			producSellable = false;
   		}
   	}
   	if(null != data && "" != data){
   		var listCost = data.value;
   		var listCostOriTemp = "${listCostOri}";
   		var listCostOri = "${listCostOri}";
     	        var vendorDCM = "${vendorDCM}";
   		if(null != listCost && "" != listCost){
         	if(null != listCostOriTemp && "" != listCostOriTemp){
         		listCostOriTemp = parseFloat(listCostOriTemp);	
            } else {
            	listCostOriTemp = 0; 
            }     		   		
   			if(listCost > 99999.9999){
   				alert("List Cost should not exceed $99999.9999");
   				data.value = "";
   				return;
   			}
   			//HoangVT - [Change Request - A&D tab - QC:1398] Vendor should be able to enter list cost 2 cent at least
   			//[Defect 1467] for non-sellable product: list cost cannot be < 0.01
   			if(producSellable == false && (listCost < 0.01 && listCost >0)){
   				alert("List Cost should be greater than or equal to 0.01");
   				data.value = "";
   				return;
   			}
   			if(producSellable == true && (listCost < 0.02 && listCost >0)){
   				alert("List Cost should be greater than or equal to 0.02");
   				data.value = "";
   				return;
   			}
   			if(vendorDCM == 'true' && listCost>0 && listCostOriTemp != listCost){  	
   				listCostOri = parseFloat(listCostOri);	 	
   			  	var pre = listCostOri;	          
	            var minus = '';
				if(pre < 0) { minus = '';}
				pre = Math.abs(pre);
				pre = parseInt((pre + .00005) * 10000);
				pre = pre / 10000;
				s = new String(pre);
				/*if(s.indexOf('.') < 0) { s += '.0000'; }
				if(s.indexOf('.') == (s.length - 2)) { s += '0'; }*/
				s = formatValue(s);
				s = minus + s;
   				alert('List cost should be either 0.0000 or '+s);   				
   				data.value = s;
   				return;
   			}         
   			var index = listCost.indexOf('.');
   			if(index > 0){
   				var dec=listCost.substring(index,listCost.length);
   				if(dec.length > 5){
   					alert("Allow to enter maximum 4 decimal digits in List Cost");
   					data.value = "";
   					return;
   				}
   			}
   			data.value = formatValue(data.value);		
   		}
   	}
   }
window.parent.hideProgress();
</script>
		</form:form>
	</div>

</body>

</html>