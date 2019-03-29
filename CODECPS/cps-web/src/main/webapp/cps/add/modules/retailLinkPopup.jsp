
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
<title>Retail Link Information</title>

	<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />

<jsp:include page="/common_head.jsp" />

<c:url value="/dwr/interface/AddCandidateTemp.js" var="myJs"/>
<script type="text/javascript" src="${myJs}"></script>

</head>
<body style="visibility: visible;">
<!-- END HEADER INCLUDE -->
<!-- End of Header -->
<div id="container" style="background-color: #D6DCE2;"><form:form
	action="/protected/cps/add" id="retailLink" modelAttribute="addNewCandidate">
	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<jsp:include page="/cpsErrors.jsp" />
	<table align="center" border="0" width="100%" bordercolor="cyan">
		<tr>
			<td width="2%"></td>
			<td width="96%" align="center">
			<fieldset style="width: 98%; height: 215px;background-color: #FFFFFF"><br />
			<table border="0" width="100%" align="center" bordercolor="red">
				<tr>
					<td colspan="2" align="right" width="45%">&nbsp;<label
						for="selectedChannel" class="labelFont"><b>Retail Link Number: </b></label></td>
					<td align="left" colspan="2" width="45%">
						<form:input path="productVO.retailLinkVO.retailLinkNum" id="retailLinkNum" maxlength="15"
									size="15" tabindex="1"/>
					</td>
				</tr>
				<tr>
					<td align="right" width="20%">&nbsp;<label class="labelFont">UPC Type: </label></td>
					<td align="left" width="25%">
						<form:input path="productVO.retailLinkVO.upcType" tabindex="1" id="upcType" maxlength="15"
									size="15"/>
					</td>
					<td align="right" width="20%"><label class="labelFont">Unit UPC: </label></td>
					<td align="left" width="25%">&nbsp;
						<form:input path="productVO.retailLinkVO.unitUpc" tabindex="1" id="unitUpc" maxlength="15"
									size="15"/>
					</td>
				</tr>
				<tr>
					<td align="right" width="20%">&nbsp;<label class="labelFont">Commodity: </label></td>
					<td align="left" width="25%">
						<form:input path="productVO.retailLinkVO.commodity" tabindex="1" id="commodity"
									maxlength="15" size="15"/>
					</td>
					<td align="right" width="20%"><label class="labelFont">Sub Commodity: </label></td>
					<td align="left" width="25%">&nbsp;
						<form:input path="productVO.retailLinkVO.subCommodity" tabindex="1" id="subCommodity"
									maxlength="15" size="15"/>
					</td>
				</tr>
				<tr>
					<td align="right" width="20%">&nbsp;<label class="labelFont">Product Description: </label></td>
					<td align="left" width="25%">
						<form:input path="productVO.retailLinkVO.prodDesc" tabindex="1" id="prodDesc" maxlength="15"
									size="15"/>
					</td>
					<td align="right" width="20%"><label class="labelFont">Unit Retail: </label></td>
					<td align="left" width="25%">&nbsp;
						<form:input path="productVO.retailLinkVO.unitRetail" maxlength="3" size="3" tabindex="43" id="unitRetail" readonly="true"/>
						<label for="selectedChannel" class="labelFont">For</label> <label id="label2">$</label>
						<form:input path="productVO.retailLinkVO.unitRetailFor" maxlength="4" size="4" tabindex="44" id="unitRetailFor" readonly="true"/>
					</td>
				</tr>
				<tr>
					<td align="right" width="20%">&nbsp;<label class="labelFont">Size: </label></td>
					<td align="left" width="25%">
						<form:input path="productVO.retailLinkVO.size" tabindex="1" id="size" maxlength="15" size="15"/>
					</td>
					<td align="right" width="45%" colspan="2"></td>
				</tr>
			</table>
			<table border="0" width="100%" align="center" bordercolor="red">
				<tr>
					<td width="90%" align="center" colspan="4">
						<button type="button" id="toClose" name="toClose" value="toClose">Close</button>
					</td>
				</tr>
			</table>
			</fieldset>
			</td>
		</tr>
	</table>
</form:form></div>

<script type="text/javascript">
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("toClose"), "click", toClose);
	
	function toClose(){
		var retailField = YAHOO.util.Dom.get("unitRetail").value;
		var retailFor = YAHOO.util.Dom.get("unitRetailFor").value;
		var retailTo = YAHOO.util.Dom.get("unitUpc").value;
		
		 var scriptString = "updateRetailForRetailLink('"+retailField+"','"+retailFor+"','"+retailTo+"');";
		 //var scriptString = "updateRetailForRetailLink('"+retailField+"','"+retailFor+"');";
		 
		 window.parent.execScript(scriptString);
		 
		window.parent.execScript('f2();', "JavaScript");
	}

</script>
</body>
</html>
