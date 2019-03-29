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
	<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />
<c:url value="/dwr/engine.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="${request.getContextPath()}/hebAssets/common.js" var="styleURL"/>
<script src="${styleURL}" type="text/javascript"></script>

<c:url value="/dwr/util.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>

<c:url value="/dwr/interface/AddCandidateTemp.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<title>PSE PopUp</title>
<%
	String pseType="";
	if(request.getAttribute("pseType")!=null)
	{
		pseType = (String)request.getAttribute("pseType");
	}
%>
	
</head>
<body style="visibility: visible;" onload="onBodyLoad();" style="background-color: #FFFFFF;">

<form:form action="/protected/cps/add" id="psePop" modelAttribute="addNewCandidate">
<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<table align="center">
		<tr>
			<td  class="labelFont" align="center">			
				<label class="labelFont"> PSE</label>
			</td>
			<td  class="labelFont" align="center">
				<input type="text" id="pseType" value="<%=pseType%>" disabled="disabled"/>
			</td>
		</tr>
	</table>
	<br>
	<br>
	<fieldset style="vertical-align: top; width: 98%; height: 225px; overflow: auto; background-color: #FFFFFF">
	<table width="100%" border="0" background="" id="cntTable" cellpadding="2" class="dataGrid">
		<tr>
			<td width="30%" class="dataGridHead" class="labelFont" align="center">
				UPC
			</td>
			<td width="30%" class="dataGridHead" class="labelFont" align="center">
				Size
			</td>
			<td width="30%" class="dataGridHead" class="labelFont" align="center">
				PSE Grams
			</td>
		</tr>
		<c:forEach items="${addNewCandidate.productVO.upcVO}" var="upc" varStatus="loop" >
			<tr class="labelFont">
				<td align="left" width="20%" class="row${loop.index%2}" class="labelFont">
					<c:out value="${upc.unitUpc}"></c:out>
				</td>
				<td class="row${loop.index%2}" class="labelFont">
					<c:out value="${upc.size}"></c:out>
				</td>
				<td class="row${loop.index%2}">
				<%
					if(pseType.equals("NO PSE"))
					{
				%>					
					<input type="text" id="grams__${loop.index}" value="${upc.pseGram}" style="dataType: numeric;" maxlength="10" onblur="roundValueForPse(this,4);return true;" disabled="disabled"/>
					<% 
					}
					else
					{
					%>
					<c:if test="${upc.editable eq false}">	
						<input type="text" id="grams__${loop.index}" value="${upc.pseGram}" style="dataType: numeric;" maxlength="10" onblur="roundValueForPse(this,4);return true;" disabled="disabled"/>
					</c:if>
					<c:if test="${upc.editable eq true}">
					<input type="text" id="grams__${loop.index}" value="${upc.pseGram}" style="dataType: numeric;" maxlength="10" onblur="roundValueForPse(this,4);return true;" />
					</c:if>
					<%
					}
					%>				
				</td>
			</tr>
		</c:forEach>
		
	</table>
	</fieldset>		
	<table align="right">
		<tr align="right">
			<td align="right">
				<button id="savePse" onclick="pseSave();">Save</button>
				<input type="reset" id="rset" value="Reset"/> 								             		
			</td>			
		</tr>
	</table>
</form:form>
<script type="text/javascript">
	function pseSave()
	{
		var tble = document.getElementById("cntTable");
		var strKey = new Array();
		var strValue =new Array();
		if(tble.rows.length > 1)
		{
			var vl = document.getElementById("pseType").value;
			for(var i=1;i<tble.rows.length;i++){
				var tableRow = tble.rows[i];
				var upc = tableRow.cells[0].innerHTML;
				var gramVl = document.getElementById("grams__"+(i-1)).value;
				if(isNaN(gramVl) || gramVl.length ==0)
				{
					if(!document.getElementById("grams__"+(i-1)).disabled)
					{
					alert(" All PSE Grams must be a number value, and not empty.");
					return;
				}	
				}	
				else
				{
					if(!isNaN(gramVl))
					{
						if(vl!="NO PSE")
						{
							if(gramVl > 99999.9999 || gramVl <= 0)
							{
								if(!document.getElementById("grams__"+(i-1)).disabled)
								{
								alert('PSE Grams value must be greater than 0 and less than or equal to 99999.9999');
								return;
							}
						}	
					}	
				}
				}
				strKey.push(upc);
				strValue.push(gramVl);
					
			}
			//window.parent.execScript('showProgress();', "JavaScript");			
			AddCandidateTemp.addPseValueForUpc(strKey,strValue,getDWRCallbackMethod(displayAfterSave));
						
		}			
		else
		{
			document.getElementById("psePop").style.display="none";		
			window.parent.execScript("closePsePopup();");	
		}			
	}
	function displayAfterSave(data)
	{				
		
		document.getElementById("psePop").style.display="none";		
		window.parent.execScript("closePsePopup();");		
	}

	function roundValueForPse(text,precision){
        var number = text.value;
        if(isNaN(number))
        {
            return;
        }
		    if(number == "0"){
	           	text.value = '0.00';
				return; 
		   }
        var numberValue = parseFloat(number);
        var maxLength = text.getAttribute("maxlength");
        var decimal = precision;
        var decimalValue = (decimal+1);
        var intiger = (maxLength-decimalValue);
        var Chars = ".";
        var np = "";
          var dp = "";
         for(var j = 0; j < intiger; j++){
               np=np+"9";
         } 
         for(var k = 0; k < decimal; k++){
               dp=dp+"9";
         }
        var maxLimit =(np+"."+dp);
        var maxLimitValue = parseFloat(maxLimit);
        for (var i = 0; i< number.length;i++){
        if(numberValue <= maxLimitValue){
		   if(precision == 4){
        calculatePrice3(text);
		   }else if(precision == 3)
		   {
        calculatePrice2(text);
		   }else {
		   calculatePrice1(text);
		   }
        }else {
        alert('The entered value is above the maximum limit ['+maxLimitValue+']. Please re-enter');
       	// text.select();
        //text.focus();
        break;
        }
        }
   }
	function onBodyLoad(){
		window.parent.execScript("hideTheProgress();");
	}	
		
</script>
</body>
</html>