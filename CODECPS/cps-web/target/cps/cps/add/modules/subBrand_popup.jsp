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
<title>Add a New Sub Brand</title>
	<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />

<jsp:include page="/common_head.jsp" />
<c:url value="/dwr/interface/AddCandidateTemp.js" var="myJs" />
<script type="text/javascript" src="${myJs}"></script>
</head>
<body style="visibility: visible;">
<!-- END HEADER INCLUDE -->
<!-- End of Header -->
<div id="container" style="background-color: #D6DCE2;"><form:form
	action="/protected/cps/add" id="subBrandPop" modelAttribute="addNewCandidate">
	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<table align="center" border="0" width="100%" bordercolor="cyan">
		<tr>
			<td width="2%"></td>
			<td width="96%" align="center">
			<table border="0" width="100%" align="center" bordercolor="red">
				<tr height="50%"><td></td></tr>
				<tr>
					<td align="center">Add new sub brand <b>"${CPSForm.newSubBrand}"?</b></td>
				</tr>
				<tr height="30%"><td></td></tr>
				<tr>
					<td width="10%" align="center">
						<button type="button" id="saveSubBrand" name="save" value="save">Save</button>
						&nbsp;&nbsp;			
						<button type="button" id="cancelSubBrand" name="cancel" value="cancel">Cancel</button>       
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
</form:form></div>


<script type="text/javascript">
		//new YAHOO.widget.Button("saveSubBrand");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveSubBrand"), "click", saveSubBrand);
		//new YAHOO.widget.Button("cancelSubBrand");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("cancelSubBrand"), "click", cancelSubBrand);

		function saveSubBrand(evt){	
			 //showProgress();
			 AddCandidateTemp.addSubBrand('${CPSForm.newSubBrand}',getDWRCallbackMethod(addSubBrandMsg));
		}

		function cancelSubBrand(evt){	
			window.parent.execScript("clearSubBrand();");
			closePopUp();
		}
		
		function closePopUp(evt){	
			window.parent.execScript("f2();");
		}
		
		function addSubBrandMsg(data) {
			//hideProgress();
		    var myArray = new Array();				
			myArray = data.split(';');
	      	data1=myArray[0];
	      	data2=myArray[1];
			window.parent.execScript("setSubBrand('"+data2+"');");
		    var scriptString = "dispSubBrandMsg('"+data1+"');";
		    window.parent.execScript(scriptString);
		    closePopUp();
		}
</script>
</body>
</html>
