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

<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />

<jsp:include page="/common_head.jsp" />
<c:url
	value="${request.getContextPath()}/dwr/interface/AddCandidateTemp.js"
	var="myJs" />
<script type="text/javascript" src="${myJs}"></script>
</head>
<body style="visibility: visible; background-color: #FFFFFF;">
	<!-- END HEADER INCLUDE -->
	<!-- End of Header -->
	<div id="container" style="background-color: #FFFFFF; height: 170px;">
	<%
	  String caseUniquId = request.getParameter("caseUniquId");
	  String firstUniqueIdVendor = request.getParameter("firstUniqueIdVendor");
	  String startingMorph = request.getParameter("startingMorph");
	  String selectedVendorId = request.getParameter("selectedVendorId");
	%>
		<form:form action="/protected/cps/add"
			id="conflictStoresForm" modelAttribute="addNewCandidate">
			
			<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<jsp:include page="/cpsErrors.jsp" />
			<form:hidden path="productVO.classificationVO.productType"
				id="productType" />
			<table width="100%">
				<tr>
					<td width="2%"></td>
					<td width="96%" align="center">
						<fieldset
							style="width: 98%; height: 95%; background-color: #FFFFFF;">
							<legend class="legendFont">Store Conflicts</legend>
							<br />

							<div
								style="width: 94%; height: 270px; overflow-y: auto; overflow-x: auto; border: 1px solid black;">

								<table id="upcTble" align="center" width="96%" border="0"
									cellspacing="0" cellpadding="2" class="dataGrid">
									<tr>
										<td class="dataGridHead" align="center" class="labelFont"
											width="15%">Store Number</td>
										<td class="dataGridHead" class="labelFont" align="center"
											width="12%">Vendor Number 1</td>
										<td class="dataGridHead" class="labelFont" align="center"
											width="12%">List Cost</td>
										<td class="dataGridHead" class="labelFont" align="center"
											width="12%">Vendor Number 2</td>
										<td class="dataGridHead" class="labelFont" align="center"
											width="12%">List Cost</td>
									</tr>
									<tbody id="upcTable">
											<c:forEach items="${addNewCandidate.conflictStoreVOs}" var="upc" varStatus="loop" >
											<tr class="labelFont">
											<td align="center" width="15%" class="labelFont">
												<font class="labelFont"> <c:out value="${upc.conflictStoreId}"></c:out></font>
											</td>
											<td align="center" width="12%" class="labelFont">
												<font class="labelFont"> <c:out value="${upc.conflictVNumber1}"></c:out></font>
											</td>
											<td align="center" width="12%" class="labelFont">
												<font class="labelFont">
													<c:if test="${upc.new1 == 'Y'  || upc.new1 == null}">
													<input value="${upc.conflictListCost1}" name="conflictListCost1" id="conflictListCost1"
																onkeydown="onKeyDownListCost(event, this);"
																onblur="validateListCost(this);"/>
													</c:if>
													<c:if test="${upc.new1 == 'N'}">
														<input value="${upc.conflictListCost1}" disabled="disabled" readonly="readonly" name="conflictListCost1" id="conflictListCost1">
													</c:if>
													<input type="hidden" name="new1" value="${upc.new1}"/>
												</font></td>
												<td align="center" width="12%" class="labelFont">
													<font class="labelFont"><c:out value="${upc.conflictVNumber2}"></c:out></font>
												</td>
												<td align="center" width="12%" class="labelFont">
													<font class="labelFont">
													<c:if test="${upc.new2 == 'Y'  || upc.new2 == null}">
													<input value="${upc.conflictListCost2}" name="conflictListCost2" id="conflictListCost2"
																onkeydown="onKeyDownListCost(event, this);"
																onblur="validateListCost(this);"/>
													</c:if>
													<c:if test="${upc.new2 == 'N'}">
														<input value="${upc.conflictListCost2}" disabled="disabled" readonly="readonly" name="conflictListCost2" id="conflictListCost2">
													</c:if>
														<input type="hidden" name="new2" value="${upc.new2}"/>
												</font></td>
											</tr>
											<c:set var="cnt" value="${loop.index}"></c:set>
											</c:forEach>
									</tbody>
								</table>
							</div>
							<div style="width: 94%;">
								<table width="96%" border="0" cellspacing="0" cellpadding="2"
									class="dataGrid">
									<tr align="right">
										<td align="right" width="80%"></td>
										<td align="right" width="10%">
											<button type="button" id="conflictStoreCancel1"
												name="conflictStoreCancel1" value="cancel"
												onclick="conflictClose()">Ok</button>
										</td>
										<td align="right" width="10%">
											<button type="button" id="print" name="print"
												onclick="printConflict()">Print</button>
										</td>
									</tr>

								</table>
							</div>
						</fieldset>
					</td>
					<td width="2%"></td>
				</tr>
			</table>
			<script type="text/javascript">
	<c:url value="/protected/cps/add/conflictStoreUpdate?${_csrf.parameterName}=${_csrf.token}" var="storeConflictUpdate"></c:url>
	<c:url value="/protected/cps/add/printConflictStore?${_csrf.parameterName}=${_csrf.token}" var="printConflictStore"></c:url>
	function conflictSaveConflict(){
	    //document.getElementById('conflictStoreSave1').disabled=true;
	    document.getElementById('conflictStoreCancel1').disabled=true;
	  	document.forms[0].action = '${storeConflictUpdate}';
	 	document.forms[0].submit();
    }
     
	var firstUniqueIdVendor ='<%=firstUniqueIdVendor%>';
	var caseUniquId ='<%=caseUniquId%>';
	var startingMorph ='<%=startingMorph%>';
	var selectedVendorId ='<%=selectedVendorId%>';
	function onLoad(){
		//document.getElementById('conflictStoreSave1').disabled=false;
		 document.getElementById('conflictStoreCancel1').disabled=false;
 		 <c:if test="${CPSForm.rejectClose}">
  				//window.parent.execScript("f2();");
				window.parent.execScript('hideProgress();', "JavaScript");
				window.parent.execScript('closeAuthorizeStroe();', "JavaScript");
  		</c:if>
		<c:if test="${CPSForm.rejectComments == 'C'}"> 
				alert("Conflict Still exists. Please remove stores");
			</c:if>
		//QC-30
		if(firstUniqueIdVendor!="" && startingMorph=='true') {
			window.parent.execScript('showProgress();', "JavaScript");
			window.parent.beforeMorph(firstUniqueIdVendor.toString(),caseUniquId.toString(),selectedVendorId.toString());  
		}  else {
			window.parent.execScript('hideProgress();', "JavaScript");
		}
	}

	function conflictClose(){
		if (!validateConflictStores()) {
			return false;
		} else {
		//window.parent.execScript("f2();");	
		 document.getElementById('conflictStoreCancel1').disabled=true;			 
		 window.parent.execScript('showProgress();', "JavaScript");
		 var e1= document.getElementsByName('conflictListCost1');
		 //var e1Value = e1[0].value;
		 var e2= document.getElementsByName('conflictListCost2');
		// var e2Value = e2[0].value;	
		var e1Value = new Array();	 
		var e2Value = new Array();	
		 for (i=0 ; i<e1.length ; i++) {
			 e1Value[i] = e1[i].value;
			 e2Value[i] = e2[i].value;
			 
		}
		 AddCandidateTemp.conflictStoreUpdate(e1Value,e2Value,getDWRCallbackMethod(callBackDetails));		
	 }
	}
	function callBackDetails(data) {   		
	    if(data != ""){
	        if(data =="fails"){
	        	alert(data);
	        	toclose();
	        }else {	        	
	        	toclose();	    		
	        }
	    }else{
	    toclose();
	    }
    }
	function toclose(evt){
		//window.parent.execScript('f2();');
		window.parent.execScript('hideProgress();', "JavaScript");
		window.parent.execScript('closeAuthorizeStroe();', "JavaScript");
		}
	
	function validateConflictStores() {
		var e1= document.getElementsByName('conflictListCost1');
		var e2= document.getElementsByName('conflictListCost2');
		var new1= document.getElementsByName('new1');
		var new2= document.getElementsByName('new2');
		var flg = false;
		for (i=0 ; i<e1.length ; i++) {
			if (e1[i].value != 0 && e2[i].value != 0 ) {
				flg = true;
				break;
			}
			if(new1[i].value=='N' && (new2[i].value=='Y' || new2[i].value=='')) {
				if(e2[i].value>0){
					flg = true;
					break;
				}
			} else if(new1[i].value=='Y' && (new2[i].value=='N' || new2[i].value=='')) {
				if(e1[i].value>0){
					flg = true;
					break;
				}
			}
		}
	
		if (flg) {
			alert('Conflict Still exists. Please remove stores');
			return false;
		} 
		return true;
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
	   		if(null != listCost && "" != listCost){
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
	   			var index = listCost.indexOf('.');
	   			if(index > 0){
	   				var dec=listCost.substring(index,listCost.length);
	   				if(dec.length > 4){
	   					alert("Allow to enter maximum 3 decimal digits in List Cost");
	   					data.value = "";
	   				}
	   			}
	   		}
	   	}
	   }
	   function printConflict(){
			document.forms[0].action = '${printConflictStore}';
		 	document.forms[0].submit();
		 	return false;
	   }
onLoad();
</script>
		</form:form>
	</div>

</body>

</html>