
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
<title>Title</title>

	<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />

<jsp:include page="/common_head.jsp" />
<c:url value="/dwr/interface/AddCandidateTemp.js" var="myJs"/>
<script type="text/javascript" src="${myJs}"></script>

</head>
<body style="visibility: visible;">
<!-- END HEADER INCLUDE -->
<!-- End of Header -->
<div id="container" style="background-color: #D6DCE2;"><form:form
	action="/protected/cps/add" id="matrixMargin" modelAttribute="addNewCandidate">
	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<table align="center" border="0" width="100%" bordercolor="cyan">
		<tr>
			<td width="2%"></td>
			<td width="96%" align="center">
			<fieldset style="width: 98%; height: 215px;background-color: #FFFFFF"><br />
			<table border="0" width="100%" align="center" bordercolor="red">
				<tr>
					<td  align="right" width="50%">&nbsp;<label
						for="selectedChannel" class="labelFont"><b>Vendor Unit Cost: </b></label></td>
					<td align="left" width="50%"><form:input
						cssClass="textFieldNormal" path="vendorListCost" maxlength="6" size="6" tabindex="520" style="dataType : float;"
						 id="vendorListCost" 
						></form:input></td>
				</tr>
				<tr>
				<td width="50%" align="center" colspan="2">    
				 <button type="button" id="toSave" name="toSave" value="toSave">Save</button>
	             
					</td>
				</tr>
			</table>
			
			</fieldset>
			</td>
		</tr>
	</table>
	
	<script type="text/javascript">
	function matrixMarginFocus(){
	<c:if test="${CPSForm.matrixMarginClose}">
	 	 var ex = "fromMatrixMargin();";
	     window.parent.execScript(ex);
	   	 window.parent.execScript("f2();");
	</c:if>
	document.getElementById('vendorListCost').focus();
	YAHOO.util.Dom.get("vendorListCost").value = '';
	}
	matrixMarginFocus();
    
	
	
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("toSave"), "click", fetchValue);
	
	function fetchValue(evt){
	
	vendorList = document.getElementById("vendorListCost").value;
	
	AddCandidateTemp.getCalRetail(vendorList,getDWRCallbackMethod(updateMatrix));
	
	
	} 	
	
	  function updateMatrix (data1){ 
     	var ex = "updateRetail("+data1+");";
     	window.parent.execScript(ex);
     	window.parent.execScript("f2();");
      }
	
	
	
	</script>
</form:form></div>


</body>
</html>
