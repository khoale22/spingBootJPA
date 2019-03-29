<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8"/>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>CPS Help</title>

<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />

<jsp:include page="/common_head.jsp" />

</head>
<body style="overflow: auto; visibility: visible;">
<div id="container" style="background-color: #D6DCE2;">
<form:form action="/protected/cps/add/AddNewCandidate" id="addItemForm">
<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<table width="99%">
		<tr>
			<td width="100%" align="center">			
			<fieldset style="overflow: auto; width: 98%; height: 90%; background-color: #FFFFFF">
				<legend class="legendFont">CPS Help</legend>
				<table border="0" width="100%" align="center">
					<tr>
						<td class="dataGridHead" class="labelFont" align="center" width="20%">Attribute</td>
						<td class="dataGridHead" align="center" class="labelFont">Definition</td>
					</tr>
					
						<c:forEach items="${applicationScope.helpTexts}" var="item">
							<tr class="labelFont">
								<td align="left" class="labelFont" width="20%">
									
										<font color="black" style="font-weight: bold; text-decoration: underline" >${item.id} :</font>
									
								</td>
								<td align="left" class="labelFont">
									
										${item.name}
									
								</td>
							</tr>
						</c:forEach>
				
			</table>
			
			</fieldset>

			</td>
		</tr>
	</table>
</form:form></div>
</body>
</html>