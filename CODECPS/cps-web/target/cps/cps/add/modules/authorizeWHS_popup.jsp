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
<!-- 		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
			<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />
		<jsp:include page="/common_head.jsp" />
		
		<c:url value="${request.getContextPath()}/dwr/engine.js" var="styleURL" />
		<script type='text/javascript' src="${styleURL}"> </script>
		
		<c:url value="${request.getContextPath()}/dwr/util.js" var="styleURL" />
		<script type='text/javascript' src="${styleURL}"> </script>
		
		<c:url value="${request.getContextPath()}/dwr/interface/AddCandidateTemp.js" var="styleURL" />
		<script type='text/javascript' src="${styleURL}"> </script>
		<title>Authorize WHS</title>
		</head>

<body style="visibility: visible;">
<div id="container" style="background-color: #D6DCE2; height: 200px;"><form:form
	action="/protected/cps/add" id="addItemForm" modelAttribute="addNewCandidate">
	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<jsp:include page="/cpsErrors.jsp" />
	<table width="100%">
		<tr>
			<td width="2%"></td>
			<td width="96%" align="center">
				<fieldset style="width: 96%; height: 250px; vertical-align:top;">
								<legend	class="legendFont">Authorize WHS</legend> <br />
				<div id="data" 
					style="height: 190px; overflow-y: auto; overflow-x: auto; vertical-align:top;">
					<table width="100%" border="0" cellspacing="0" bordercolor="red" style="vertical-align:top;">
							<tr>
									<td width="10%" align="center" class="dataGridHead"></td>
									<td width="20%" align="center" class="dataGridHead">WareHouse ID</td>
									<td width="50%" align="center" class="dataGridHead">WareHouse Name</td>
									<td width="20%" align="center" class="dataGridHead">Facility Number</td>
							</tr>
							<tbody id="warehouseTable">
							<c:forEach items="${addNewCandidate.wareHouseList}" var="auth" varStatus="loop" >
									<tr id="caseRow${loop.index}">
										<td width="10%" align="center" class="row0">
										   <c:if test="${auth.check eq true}">
											<input type="checkbox" id="check${loop.index}" checked="checked"/>
											</c:if>
											<c:if test="${auth.check  eq false}">
											<input type="checkbox" id="check${loop.index}" />
											</c:if>
										</td>
										<td width="20%" align="center" class="row0" align="center"><input
											type="hidden" id="whsNumVal${loop.index}"
											value="${auth.whareHouseid}" /> ${auth.whareHouseid}</td>
										<td width="50%" align="center" class="row0" align="center">
												${auth.whareHouseName}</td>
										<td width="20%" align="center" class="row0" align="center"> ${auth.facilityNumber}</td>
									</tr>
							</c:forEach>
							</tbody>
					</table>
				</div>
				<table width="100%" border="0" cellspacing="0" >
						<tr align="left">
							<td width="50%" align="right" colspan=2><button id="authWHSSave">Save</button></td>
							<td width="50%" align="left" colspan=2><button id="assortCancel">Cancel</button></td>
						</tr>
				</table>
				</fieldset>
			</td>
			<td width="2%"></td>
		</tr>
	</table>
	<br />
	<input type="hidden" value='${CPSForm.vendorVO.psItemId }' id="psItemId"/>
</form:form></div>
</body>
<script type="text/javascript">
    
YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authWHSSave"), "click", saveWHSDetails);

YAHOO.util.Event.addListener(YAHOO.util.Dom.get("assortCancel"), "click", toClose);

function saveWHSDetails(evt){
	 var listSize = ${CPSForm.wareHouseListSize};
	 var k=0;
	 var arr = new Array();
	 for(var i=0;i<listSize;i++){
	    if(document.getElementById("check"+i).checked) {
	       arr[k]=document.getElementById("whsNumVal"+i).value;
	       k++;
	      }
	   }
		if(k>0) {
			var psItemId = document.getElementById("psItemId").value;
		
			AddCandidateTemp.isWHSeDC(psItemId,getDWRCallbackMethod(function(data){
				if(data){
							
					var whsTbl = document.getElementById("warehouseTable");
					for(var i = 0; i < whsTbl.rows.length; i ++){
						var records = whsTbl.rows[i].cells[0];
						var isChecked = whsTbl.rows[i].cells[0].innerHTML.toUpperCase().indexOf('CHECKED');
						var is101 = whsTbl.rows[i].cells[3].innerHTML;
						if("101" == is101 && isChecked == -1){
							alert("WHS 101 cannot be removed for WHS(DSDeDC) item.");
							window.parent.f2();
							return;
						}
					}
					document.getElementById('authWHSSave').disabled=true;
				    document.getElementById('assortCancel').disabled=true;
					AddCandidateTemp.saveWhareHouseDetails(arr,getDWRCallbackMethod(checkValue));
				}else{					
					document.getElementById('authWHSSave').disabled=true;
				    document.getElementById('assortCancel').disabled=true;
					AddCandidateTemp.saveWhareHouseDetails(arr,getDWRCallbackMethod(checkValue));
				}
			}));
		}
		else {
		  alert('Please select a warehouse value');
		}
		
		return;
}

function checkValue(evt){	
	toClose();
}
function toClose(evt){	
	window.parent.f2();
}
function check(){
	    <c:if test="${CPSForm.rejectClose}">
	      var ex = "fromExecute();";
	     window.parent.fromExecute();
	   	 window.parent.f2();
	    </c:if>
    }
    check();
</script>


</html>