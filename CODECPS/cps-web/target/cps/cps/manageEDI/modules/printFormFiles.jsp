<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>Print Candidate</title>
</head>
<body onload="checkForm()">
<form:form
	id="batchUploadForm" name="batchUploadForm"
	action="/protected/cps/add" method="POST"
	commandName="manageEDICandidate"
	enctype="multipart/form-data">
	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
<script type="text/javascript">
	<c:url value="/protected/PrintFormViewerServlet" var="printFormView" />
	<c:url value="/protected/cps/manage/printMRT?${_csrf.parameterName}=${_csrf.token}" var="printFormMRTView" />
	function checkForm(){
	 <c:if test="${ManageEDICandidate.rejectClose}">
	 var ex = "updateMessage();";
	     window.parent.updateMessage();
	   	 window.parent.f2();
	 </c:if>
	}
	window.parent.hideProgress();
</script>
The following forms are generated for the product  ${ManageEDICandidate.productDescription}

<br>
<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="dataGrid" >
	<c:forEach var="files" items="${ManageEDICandidate.printFormVOList}" varStatus="count" >
		<%--<logic:iterate id="files" property="printFormVOList" name="CPSEDIMain" indexId="count">--%>
		<tr>
			<td width="100%" align="left">
				<a target=new
					href="${printFormView}?errorMessage=${files.fileName}">
				<font class="labelFont">"${files.displayToUser}"</font> </a>
		</td>
		</tr>
	</c:forEach>
</table></form:form>


</body>
</html>