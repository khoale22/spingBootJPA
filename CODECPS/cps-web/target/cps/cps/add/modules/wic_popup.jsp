<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>WIC</title>
	<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />

<jsp:include page="/common_head.jsp" />
<c:url value="/dwr/interface/AddCandidateTemp.js" var="myJs" />
<script type="text/javascript" src="${myJs}"></script>
</head>
<body style="overflow: auto; visibility: visible;">
<!-- END HEADER INCLUDE -->
<!-- End of Header -->
<div id="container" style="background-color: #D6DCE2;"><form:form
	action="/protected/cps/add" id="wicPop" modelAttribute="addNewCandidate">
	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<table align="center" border="0" width="100%" bordercolor="cyan">
		<tr>
			<td width="2%"></td>
			<td width="96%" align="center">
			<table border="0" width="100%" align="center" bordercolor="red">
				<tr height="50%"><td></td></tr>
				<tr>
					<td align="center">		
					<label class="labelFont" id="WicLabel"><B> WIC APL ID : </B></label>
					<c:if test="${CPSForm.disableWic}">
						<form:input id="wic1"
						path="wic" size="14" maxlength="14" disabled="true"></form:input>
					</c:if>
					<c:if test="${!CPSForm.disableWic}">		
						<form:input id="wic" path="wic" size="14" maxlength="14"  style="dataType:numeric;"></form:input>
					</c:if>
					</td>
				</tr>
				<tr height="30%"><td></td></tr>
				<c:if test="${!CPSForm.disableWic}">
				<tr>
					<td width="10%" align="center">
						<button type="button" id="saveWic" name="save" value="save">Save</button>
						&nbsp;&nbsp;			
						<button type="button" id="cancelWic" name="cancel" value="cancel">Cancel</button>       
					</td>
				</tr>
				</c:if>
			</table>
			</td>
		</tr>
	</table>
</form:form></div>


<script type="text/javascript">
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveWic"), "click", saveWic);
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("cancelWic"), "click", cancelWic);

		function saveWic(evt){	
			 var value = document.getElementById("wic").value;
			 window.parent.execScript("setWic('"+value+"');");
			 closePopUp();
		}

		function cancelWic(evt){	
			document.getElementById("wic").value = "";
			closePopUp();
		}
		
		function closePopUp(evt){	
			window.parent.execScript("f2();");
		}
</script>
</body>
</html>
