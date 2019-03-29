<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>Print Candidate</title>
</head>
<body onload="checkForm()">
<form:form
	styleId="batchUploadForm"
	action="/protected/cps/add/AddNewCandidate" method="POST"
	enctype="multipart/form-data">
	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
<script type="text/javascript">
	<c:url value="/protected/cps/manage/printMRT?${_csrf.parameterName}=${_csrf.token}" var="printFormView" />
	function checkForm(){
	 <c:if test="${CPSForm.rejectClose}">
	 var ex = "updateMessage();";
	     window.parent.updateMessage();
	   	 window.parent.f2();
	 </c:if>
	 window.parent.hideProgress();
	}
	
</script>

The following forms are generated.

<br>
<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="dataGrid" >
		<c:forEach items="${CPSForm.MRTList}" var="mrtVO">
			<tr>
				<td width="100%" colspan="3" align="left">
					<font class="labelFont">"${mrtVO.caseVO.caseDescription}"</font>
				</td>
			</tr>
			<c:forEach items="${mrtVO.caseVO.vendorVOs}" var="mrtVendor">
				<c:if test="${mrtVendor.newDataSw eq 'Y'.charAt(0)}">
					<tr>
						<td width="10%" align="left"></td>
						<td width="90%" colspan="2" align="left">
							<a target="new" href="${printFormView}&mrtId=${mrtVO.workRequest.workIdentifier}&mrtVenId=${mrtVendor.vendorLocNumber}">
							<font class="labelFont">"${mrtVendor.vendorLocation}"</font> </a>
						</td>
					</tr>
				</c:if>
			</c:forEach>
			
			<c:forEach items="${mrtVO.mrtVOPrints}" var="mrtKid">
				<tr>
					<td width="10%" align="left"></td>
					<td width="90%" colspan="2" align="left">
						<font class="labelFont">"${mrtKid.productVO.classificationVO.prodDescritpion}"</font>
					</td>
				</tr>
				<c:forEach items="${mrtKid.productVO.caseVOs}" var="mrtKidCase">
<%-- 					<logic:iterate id="mrtKidVendor" property="vendorVOs" name="mrtKidCase" indexId="kidVendorCount"> fix pim 933--%>
					<c:forEach items="${mrtKidCase.vendorVOListPrints}" var="mrtKidVendor">
<%-- 						<c:if test="${mrtKidVendor.newDataSw eq 'Y'.charAt(0)}"> --%>
							<tr>
								<td width="10%" align="left"></td>
								<td width="10%" align="left"></td>							
								<td width="80%" align="left">
									<a target="new" href="${printFormView}&mrtId=${mrtVO.workRequest.workIdentifier}&prodID=${mrtKid.productVO.psProdId}&prodVenId=${mrtKidVendor.vendorLocNumber}">
									<font class="labelFont">"${mrtKidVendor.vendorLocation}" </font> </a>
								</td>							
							</tr>
<%-- 						</c:if> --%>
					</c:forEach>
				</c:forEach>
			</c:forEach>
		</c:forEach>
</table></form:form>

</body>
</html>