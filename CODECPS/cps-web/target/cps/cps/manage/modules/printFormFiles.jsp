<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<title>Print Candidate</title>
</head>
<body onload="checkForm()" style="background-color:white;">
<form:form
	id="batchUploadForm"
	action="/protected/cps/add/AddNewCandidate" method="POST"
	modelAttribute="manageCandidate"
	enctype="multipart/form-data">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<script type="text/javascript">
	<c:url value="/protected/PrintFormViewerServlet" var="printFormView" />
	<c:url value="/protected/cps/manage/printMRT?${_csrf.parameterName}=${_csrf.token}" var="printFormMRTView" />
	function checkForm(){
	 <c:if test="${manageCandidate.rejectClose}">
	 var ex = "updateMessage();";
	     window.parent.updateMessage();
	   	 window.parent.f2();
	 </c:if>
	}
	
</script>
The following forms are generated for the product  ${manageCandidate.productDescription}

<br>
<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="dataGrid" >
		<%--<logic:iterate id="files" property="printFormVOList" name="CPSForm" indexId="count">--%>
			<c:forEach items="${manageCandidate.printFormVOList}" var="files">
				<tr>
					<td width="100%" align="left">
						<a target=new
							href="${printFormView}?errorMessage=${files.fileName}">
						<font class="labelFont">"${files.displayToUser}"</font> </a>
				</td>
				</tr>
			</c:forEach>
		<%--</logic:iterate>--%>
</table></form:form>
<br/>
The following MRT forms are generated.

<br/>
<form:form
	id="batchUploadForm"
	action="/protected/cps/add/AddNewCandidate" method="POST"
	modelAttribute="manageCandidate"
	enctype="multipart/form-data">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="dataGrid" >
		<%--<logic:iterate id="mrtVO" property="MRTList" name="CPSForm" indexId="mrtCount">--%>
			<c:forEach items="${manageCandidate.MRTList}" var="mrtVO">
				<tr>
					<td width="100%" colspan="3" align="left">
						<font class="labelFont">"${mrtVO.caseVO.caseDescription}"</font>
					</td>
				</tr>
				<%--<logic:iterate id="mrtVendor" property="caseVO.vendorVOs" name="mrtVO" indexId="mrtVendorCount">--%>
				<c:forEach items="${mrtVO.caseVO.vendorVOs}" var="mrtVendor">
						<c:if test="${mrtVendor.newDataSw eq 'Y'.charAt(0)}">
							<tr>
								<td width="10%" align="left"></td>
								<td width="90%" colspan="2" align="left">
										<a target="new" href="${printFormMRTView}&mrtId=${mrtVO.workRequest.workIdentifier}&mrtVenId=${mrtVendor.vendorLocNumber}">
										<font class="labelFont">"${mrtVendor.vendorLocation}"</font> </a>
								</td>
							</tr>
						</c:if>
				</c:forEach>
				<%--</logic:iterate>--%>

				<%--<logic:iterate id="mrtKid" property="mrtVOs" name="mrtVO" indexId="count">--%>
				<c:forEach items="${mrtVO.mrtVOs}" var="mrtKid">
					<tr>
						<td width="10%" align="left"></td>
						<td width="90%" colspan="2" align="left">
							<font class="labelFont">"${mrtKid.productVO.classificationVO.prodDescritpion}"</font>
						</td>
					</tr>

						<%--<logic:iterate id="mrtKidCase" property="productVO.caseVOs" name="mrtKid" indexId="kidCaseCount">	--%>
					<c:forEach items="${mrtKid.productVO.caseVOs}" var="mrtKidCase">
							<%--<logic:iterate id="mrtKidVendor" property="vendorVOListPrints" name="mrtKidCase" indexId="kidVendorCount">--%>
						<c:forEach items="${mrtKidCase.vendorVOListPrints}" var="mrtKidVendor">
		<%-- 						<c:if test="${mrtKidVendor.newDataSw == 'Y'}"> --%>
									<tr>
										<td width="10%" align="left"></td>
										<td width="10%" align="left"></td>
										<td width="80%" align="left">
											<a target="new" href="${printFormMRTView}&mrtId=${mrtVO.workRequest.workIdentifier}&prodID=${mrtKid.productVO.psProdId}&prodVenId=${mrtKidVendor.vendorLocNumber}">
											<font class="labelFont">"${mrtKidVendor.vendorLocation}"</font> </a>
										</td>
									</tr>
		<%-- 						</c:if> --%>
							<%--</logic:iterate>--%>
						</c:forEach>
					</c:forEach>
						<%--</logic:iterate>--%>
					<%--</logic:iterate>--%>
				</c:forEach>
			</c:forEach>
		<%--</logic:iterate>--%>
</table></form:form>

</body>
</html>