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
<title>PLU Generation</title>

<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />

<jsp:include page="/common_head.jsp" />

<c:url value="/dwr/interface/AddCandidateTemp.js" var="myJs"/>
<script type="text/javascript" src="${myJs}"></script>
</head>
<body style="visibility: visible;">
<!-- END HEADER INCLUDE -->
<!-- End of Header -->
<div id="container" style="background-color: #D6DCE2;">
	<form:form action="/protected/cps/add" id="pluGenPop" modelAttribute="addNewCandidate">
	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<table align="center" border="0" width="100%" bordercolor="cyan">
		<tr>
			<td width="2%"></td>
			<td width="96%" align="center">
			<fieldset style="width: 98%; height: 140px;background-color: #FFFFFF"><legend
				class="legendFont">PLU</legend> <br />
				
				<table border="0" width="100%" align="center" bordercolor="red">
				<tr>
					<td align="LEFT" width="50%" colspan="3"><label id="errorMessage" style="color: red;" dir="ltr"></label></td>
					<td align="left" width="50%">&nbsp;</td>
				</tr>
			</table>
				
								
				
			<table border="0" width="100%" align="center" bordercolor="red">
				<tr>
					<td align="right" width="15%">&nbsp;<label
						for="selectedChannel" class="labelFont">PLU Type </label></td>
					<td align="left" width="20%">
						<form:select path="upcvo.selectedPluType" tabindex="1" id="plutype" cssClass="selectBoxStyle2">
							<form:option value="">--Select--</form:option>
							<form:options items="${addNewCandidate.upcvo.pluTypeList}" itemLabel="name" itemValue="id" />
						</form:select>
					</td>

					<td align="right" width="13%"><label class="labelFont">Range
					</label></td>
					<td align="left" width="52%">&nbsp;
						<form:select path="upcvo.selectedRange" tabindex="2" id="plurange"
									 cssClass="selectBoxStyleBig">
							<form:option value="">--Select--</form:option>
							<form:options items="${addNewCandidate.upcvo.rangeList}" itemLabel="name"
										  itemValue="id" />
						</form:select>
					</td>
				</tr>
			</table>
			<table border="0" width="100%" align="center" bordercolor="red">

				<tr>
					<td width="20%"></td>
					<td width="50%"></td>
					<td width="5%"></td>
				<td width="10%" align="left">
				<button type="button" id="genPLU" name="genPLU" value="generate">Generate PLU</button>			
	             
					</td>
				</tr>
				<tr>
					<td align="right">The New PLU is:</td>
					<td colspan="3" align="left"> <a href="#" id="pluId"
						onclick="pluScaleLink();return false;"></a> 
					<label id="msg"></label></td>
				</tr>
			</table>
			</fieldset>
			</td>
		</tr>
	</table>
</form:form></div>


<script type="text/javascript">
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("genPLU"), "click", generatePLU);
		var pluScale;
		var pluChecker;
		var checkDigit;
		var checkDigit1;
		var pluTypeChanged='';
						
		function generatePLU(evt){
			var pluType = YAHOO.util.Dom.get("plutype").value;
			var pluRange = YAHOO.util.Dom.get("plurange").value;
			pluTypeChanged=pluType;
			document.getElementById("genPLU").disabled = true;
			AddCandidateTemp.generatePLU(pluType,pluRange,getDWRCallbackMethod(displayPLU));
		}
		
		function displayPLU(data){ 	
		var num1;	
		document.getElementById("genPLU").disabled = false;
			if(data == "Please select both PLU Type & Range"){
				document.getElementById("pluId").innerText="";
				document.getElementById("msg").innerText="";
				document.getElementById("errorMessage").innerText=data;
			}else{
			    var myArray = new Array();
				myArray = data.split(',');
	      		num1=myArray[0];
	      		checkDigit=myArray[1];
	      		checkDigit1=myArray[2];				
				if(num1.length<28){
					document.getElementById("pluId").innerText=num1;
					document.getElementById("msg").innerText="";
					document.getElementById("errorMessage").innerText="";
				}else{
					document.getElementById("pluId").innerText="";
					document.getElementById("errorMessage").innerText="";
					document.getElementById("msg").innerText=data;
				}
			}
		
			
			pluScale = ""+num1;
		}
			
		
		function pluScaleLink(){
			var pluType = YAHOO.util.Dom.get("plutype").value;
		 	var scriptString = "updateUPCTextBox('"+pluTypeChanged+"', '"+pluScale+"','','','"+checkDigit+"','');";
			var pluLength = "";
			if(pluTypeChanged == 'B') {
				var num1;
				var num2;
			
				var myArray = new Array();				
				myArray = pluScale.split('-');
	        	num1=myArray[0];
	        	num2=myArray[1];
	        	var scriptString = "updateUPCTextBox('"+pluTypeChanged+"','"+pluScale+"','"+num1+"','"+num2+"','"+checkDigit+"','"+checkDigit1+"');";
			
			}
			window.parent.execScript(scriptString);

			window.parent.execScript("f2();");
		}
</script>
</body>
</html>
