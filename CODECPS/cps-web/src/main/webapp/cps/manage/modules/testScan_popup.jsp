<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>Available UPCs</title>

<c:url value="${request.getContextPath()}/hebAssets/common.css.jsp" var="styleJspURL"/>
<link rel="stylesheet"	href="${styleJspURL}"	type="text/css" />
<c:url value="/dwr/engine.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>
<%--Utils for DWR--%>
<c:url value="/dwr/util.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>
<%--CPS Util for DWR--%>
<c:url value="/dwr/interface/FieldHelp.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/AddCandidateTemp.js" var="myJs" />
<script type="text/javascript" src="${myJs}"></script>
<c:url value="${request.getContextPath()}/hebAssets/common.js" var="styleURL"/>
<script src="${styleURL}" type="text/javascript"></script>

<%--js for the panel-menus--%>
<c:url value="${request.getContextPath()}/yui/yahoo/yahoo-debug.js" var="styleURL"/>
<script type="text/javascript" src="${styleURL}" ></script>

<c:url value="${request.getContextPath()}/yui/dom/dom-debug.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>

<c:url value="${request.getContextPath()}/yui/event/event-debug.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>

<c:url value="${request.getContextPath()}/yui/container/container-min.js" var="styleURL"/>
<script type="text/javascript" src="${styleURL}"></script>
</head>
<body style="visibility: visible;" onload="onBodyLoad();">
<div id="container" style="vertical-align: top; overflow: auto; background-color: #D6DCE2;">
<form:form action="/protected/cps/add/AddNewCandidate" id="addItemForm" commandName="manageCandidate">
<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<table width="100%">
		<tr>
			<td width="96%" align="center"> 
			<jsp:include page="/cpsErrors.jsp" />
			</td>
		</tr>	
		<tr>
			<td width="96%" align="center"> 
			<fieldset style="vertical-align: top; overflow: auto; background-color: #FFFFFF">
				<legend	class="legendFont">Available UPC's</legend>
				<div style="overflow: auto; height: 280px; vertical-align: top;">	
				<table border="0" width="100%" align="center">
					<tr>
						<td class="dataGridHead" class="labelFont" align="center"
							width="30%">Available UPC</td>
						<td class="dataGridHead" align="center" class="labelFont"
							width="30%">Scan Status</td>
						<c:if test="${manageCandidate.testScanUserSwitch}">
							<td class="dataGridHead" align="center" class="labelFont"
								width="30%">Override Test scan <input type="checkbox" id="overrideAll" onclick="selectAll();"/></td>
						</c:if>
					</tr>
					<tbody id="values">
						<%--<logic:iterate id="product" property="upcVOs" indexId="count" name="CPSForm">--%>
						<c:forEach items="${manageCandidate.upcVOs}" var="product" varStatus="loop" >
							<tr class="labelFont">
								<c:url var="img"
									value="${request.getContextPath()}/hebAssets/images/newButtons/validated.PNG" />
								<td align="center" width="30%" id="upcRow${loop.index}"
									class="labelFont">
									<font class="labelFont">
										<c:out value="${product.unitUpc}"></c:out>
								</font>
									<input type="hidden"
									id="prodId${loop.index}" value="${product.psProdId}" /> <input
									type="hidden" id="sequanceId${loop.index}" value="${product.seqNo}" />
								<input type="hidden" id="upcTyp${loop.index}"
									value="${product.upcType}" /></td>


								<td align="center" width="30%" class="labelFont">
								 <c:choose>
									<c:when
										test="${product.testScanOverridenStatus eq 'N'.charAt(0) && product.testScanUPC ne ''}">
										<c:set value="visibility: visible;position: static;"
											var="styleStr" />										
									</c:when>
									<c:otherwise>
										<c:set value="visibility: hidden;position: static;"
											var="styleStr" />	
									</c:otherwise>
								</c:choose>
								<div id="validateDiv${loop.index}" style="${styleStr}"><img
									src='${img}' alt="Validated" style="position: static;" /></div>
								</td>
								<c:if test="${manageCandidate.testScanUserSwitch}">
									<td align="center" width="30%" class="labelFont">
									<c:if
										test="${product.testScanOverridenStatus eq 'Y'.charAt(0)}">
										<input type="checkbox" id="checkDiv${loop.index}"
											checked="checked" onclick="clearScan();">
									</c:if> 
									<c:if test="${product.testScanOverridenStatus eq 'N'.charAt(0)}">
										<input type="checkbox" id="checkDiv${loop.index}" onclick="clearScan();">
										
									</c:if></td>
								</c:if>
							</tr>
							</c:forEach>
					<%--	</logic:iterate>--%>
					</tbody>
				</table>
				</div>
			</fieldset>
			</td>
		</tr>	
		<tr>	
			<td width="96%" align="center"> 
			<div style="background-color: #D6DCE2;">
			<table width="100%">
				<tr>
					<td align="right" width="25%"><label class="labelFont">Scan
					Gun Input</label></td>
					<td align="left" width="25%">
						<div id="holder" style="dataType: numeric; position:absolute; z-index:99; background-color:transparent">
							<form:input	cssClass="textFieldNormal" path="scanGun" tabindex="73"	maxlength="15" id="scanGun" size="15"
							onkeydown="checkForValue();"  readonly="true" ></form:input>
						</div>
						<div id="reader" align="left"  style="width:10px">
							<textarea onkeypress="onKeyPressEvent(event);" 
							rows="1" cols="1" style="dataType: numeric; text-decoration:none; text-align:right;  border: 0px solid #000000; width=1px; cursor:none;"  name="scanGunReader" id="scanGunReader"></textarea>
						</div>
						
					
					</td>
					<td align="left" width="25%" class="dataGridHead"
						background="#FFFFFF">
				        <button type="button" id="validate" name="validate"
								value="Add">ValidateUPC</button>
				       
					    <button type="button" id="saveTestScan" name="save" value="Save">Save</button>
					 </td>
					<td align="left" width="25%"></td> 
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td align="center" width="96%">
				<label class="labelFont" id="msg"></label>
			</td>
		</tr>
	</table>
	<script type="text/javascript">
YAHOO.util.Event.addListener(YAHOO.util.Dom.get("validate"), "click", validateCheck);
YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveTestScan"), "click", saveScannedUpc); 

function toClose(evt){
	//window.parent.execScript('f2();');
	window.parent.closePopup();
}


function validateCheck(evt){
	validateScanGunValue();
	//validateWithoutCheckDigit();
	validateWithCheckDigit();
}



	function validateWithCheckDigit(evt){
	var scanGunVal = YAHOO.util.Dom.get("scanGun").value+"";
	var finalScanGunVal = scanGunVal.substring(2,(scanGunVal.length));
	var tbody = document.getElementById('values');
	var bln=false;
	for(var i=0;i<tbody.rows.length;i++){
			var upc = document.getElementById('upcRow'+i).innerText+"";
			/*to trim the value from the list*/
			var upcTrimmed = upc.replace(/^\s+|\s+$/g, '') ;
			var finalUPC = upcTrimmed.substring(2,(upcTrimmed.length));
			var validate = YAHOO.util.Dom.get("validateDiv"+i);
			<c:if test="${manageCandidate.testScanUserSwitch}">
			var overRiddenCheckBox = YAHOO.util.Dom.get("checkDiv"+i);
				if(finalUPC==finalScanGunVal){
					bln=true;
					if(overRiddenCheckBox.checked) {
				        alert('OverRidden UPC');
				        setfocus();
				    }else{
						validate.style.visibility = 'visible';
						validate.style.position = 'static';
						YAHOO.util.Dom.get("scanGunReader").value = "";
						YAHOO.util.Dom.get("scanGun").value = "";
						overRiddenCheckBox.disabled="true";
						setfocus();
					}
				}
				</c:if>
			<c:if test="${!manageCandidate.testScanUserSwitch}">
			if(finalUPC==finalScanGunVal){
				bln=true;
				validate.style.visibility = 'visible';
				validate.style.position = 'static';
				YAHOO.util.Dom.get("scanGunReader").value = "";
				YAHOO.util.Dom.get("scanGun").value = "";
				setfocus();
				}
			</c:if>
	}
	YAHOO.util.Dom.get("msg").innerHTML = "";
	if(!bln){
		YAHOO.util.Dom.get("msg").innerHTML = '<font color="#FF0000" size="2px;">No matching UPC Found. Please scan again.</font>';
		YAHOO.util.Dom.get("scanGunReader").value = "";		
		YAHOO.util.Dom.get("scanGun").value = "";
		setfocus();
	}
}

function validateWithoutCheckDigit(evt){
	
	var finalScanGunVal = YAHOO.util.Dom.get("scanGun").value+"";
	var tbody = document.getElementById('values');
	var bln=false; 
	for(var i=0;i<tbody.rows.length;i++){
			var upc = document.getElementById('upcRow'+i).innerText+"";
			/*to trim the value from the list*/
			
			var finalUPC = upc.replace(/^\s+|\s+$/g, '') ;
			var validate = YAHOO.util.Dom.get("validateDiv"+i);
			<c:if test="${manageCandidate.testScanUserSwitch}">
			var overRiddenCheckBox = YAHOO.util.Dom.get("checkDiv"+i);
				if(finalUPC==finalScanGunVal){
					bln=true;
					if(overRiddenCheckBox.checked) {
				        alert('OverRidden UPC');
				        setfocus();
				    }else{
						validate.style.visibility = 'visible';
						validate.style.position = 'static';
						YAHOO.util.Dom.get("scanGunReader").value = "";
						YAHOO.util.Dom.get("scanGun").value = "";
						overRiddenCheckBox.disabled="true";
						setfocus();
					}
					
				}
				</c:if>
			<c:if test="${!manageCandidate.testScanUserSwitch}">
			if(finalUPC==finalScanGunVal){
				bln=true;
				validate.style.visibility = 'visible';
				validate.style.position = 'static';
				YAHOO.util.Dom.get("scanGunReader").value = "";
				YAHOO.util.Dom.get("scanGun").value = "";
				setfocus();
				}
			</c:if>
	}
	YAHOO.util.Dom.get("msg").innerHTML = "";
	if(!bln){
		YAHOO.util.Dom.get("msg").innerHTML = '<font color="#FF0000" size="2px;">No matching UPC Found. Please scan again.</font>';
		YAHOO.util.Dom.get("scanGunReader").value = "";		
		YAHOO.util.Dom.get("scanGun").value = "";
		setfocus();
	}
}


document.body.scroll = 'no';

function onBodyLoad(evt){
	window.parent.hideTheProgress();
	setfocus(evt);	
}

function setfocus(evt){
	//YAHOO.util.Dom.get("scanGun").focus();
	setfocusIn();
}
function testSacnOnLoad(){
 <c:if test="${manageCandidate.rejectClose}">
	    //  var ex = "fromTestScan();";
	     //window.parent.execScript(ex);
	   	 //window.parent.execScript("f2();");
	   		window.parent.closePopup();
	    </c:if>
}
testSacnOnLoad();
 function saveScannedUpc(evt){
  var tbody = document.getElementById('values');
  var dataString = new Array();
  var k = 0;
   for(var i=0;i<tbody.rows.length;i++) {
   <c:if test="${manageCandidate.testScanUserSwitch}">
  	var overRiddenCheckBox = YAHOO.util.Dom.get("checkDiv"+i);
  	</c:if>
  	        var finalUPC = "";
  	 		var upc = document.getElementById('upcRow'+i).innerText+"";
	        var upcTrimmed = upc.replace(/^\s+|\s+$/g, '') ;
	        if(upcTrimmed.length <=14){
	        finalUPC = upcTrimmed;
	        }else {
			finalUPC = upcTrimmed.substring(0,(upcTrimmed.length-1));
			}
	        var prodid =  document.getElementById('prodId'+i).value;
	        var scanCodeId =  document.getElementById('sequanceId'+i).value;
	    	var upcType1 = document.getElementById('upcTyp'+i).value;
	<c:if test="${manageCandidate.testScanUserSwitch}">
  	 if(overRiddenCheckBox.checked) { 
	         var o = new Object();
	         o.unitUPC = finalUPC;
	         o.prodId = prodid;
	         o.scanCodeId =scanCodeId;
	         o.upcType = upcType1;
	         o.overRiddenFlag = "true";
	         dataString[k] = finalUPC+":"+prodid+":"+scanCodeId+":"+upcType1+"|";
	         dataString[k] = o;
	         k++;
      }
     else if(overRiddenCheckBox.disabled) {
            var o = new Object();
	         o.unitUPC = finalUPC;
	         o.prodId = prodid;
	         o.scanCodeId =scanCodeId;
	         o.upcType = upcType1;
	         o.overRiddenFlag = "false";
	         dataString[k] = finalUPC+":"+prodid+":"+scanCodeId+":"+upcType1+"|";
	         dataString[k] = o;
	         k++;
     }
    </c:if>
    <c:if test="${!manageCandidate.testScanUserSwitch}">
           	 var validateCheck = YAHOO.util.Dom.get("validateDiv"+i).style.visibility;
           	 if('visible'==validateCheck){
	           	 var o = new Object();
		         o.unitUPC = finalUPC;
		         o.prodId = prodid;
		         o.scanCodeId =scanCodeId;
		         o.upcType = upcType1;
		         o.overRiddenFlag = "false";
		         dataString[k] = finalUPC+":"+prodid+":"+scanCodeId+":"+upcType1+"|";
		         dataString[k] = o;
		         k++;
           	 }
    </c:if>
  }
  if(k>0) {
    // showProgress();
    document.getElementById("saveTestScan").disabled=true;
     AddCandidateTemp.saveTestScan(dataString,getDWRCallbackMethod(callBack));
  
  }

}
function callBack(data) {
    var scriptString = "testScanMess('"+data+"');";
    window.parent.testScanMess(data);
    //window.parent.execScript("f2();");
    window.parent.closePopup();
	window.parent.nonSellableHide();
}

function checkForValue(){
	if(document.getElementById('scanGun').value==''){
		document.getElementById("validate").disabled=true;
	}else{
		document.getElementById("validate").disabled=false;
	}
}


if (document.all || document.getElementById){
	setInterval("checkForValue()",100);
	setInterval("setfocusIn()",100);
}

function validateScanGunValue(){
    var scanGunValue = document.getElementById('scanGun').value;
	var length = scanGunValue.length;
	if(length < 14){
		var	numberofZero = 14-length;
		for(var j = 0; j < numberofZero; j++){
		scanGunValue = "0" + scanGunValue;
		}
		YAHOO.util.Dom.get("scanGun").value = scanGunValue;
	}else { 
		YAHOO.util.Dom.get("scanGun").value = scanGunValue;
	}
}

	function callBackCheckDigit(data) {
		YAHOO.util.Dom.get("scanGun").value = data;

	}

function trim(sString){
	while (sString.substring(0,1) == ' ')
	{
		sString = sString.substring(1, sString.length);
	}
	while (sString.substring(sString.length-1, sString.length) == ' ')
	{
		sString = sString.substring(0,sString.length-1);
	}
	return sString; 
}

	
function setfocusIn(){
	setCaretToEnd(document.getElementById("scanGunReader"));
}

function prependZeros(inpt){
	var dificit = 14 - inpt.length;
	for(var i = 0;  i < dificit; i++){
		inpt = "0" + inpt;
	}	
	return inpt;
}


function isNumeric(scanVal){
	var re14digit=/^\d{14}$/
	if (scanVal.search(re14digit)==-1)
	{
		return false;
	}
	return true;
}

function onKeyPressEvent(event){
	if((event.keyCode >= 48 && event.keyCode <= 57) || event.keyCode == 13){
		if(event.keyCode == 13){
			document.getElementById('scanGunReader').value = document.getElementById('scanGunReader').value.replace(/^\s+|\s+$/g, '');
			
			if(document.getElementById('scanGunReader').value != ""){
				var theUPC = prependZeros(document.getElementById('scanGunReader').value);
				if(isNumeric(theUPC) == true){
					document.getElementById('scanGun').value = theUPC;	
					//validateCheck();
				}else{
					document.getElementById('scanGun').value = "";		
					document.getElementById('scanGunReader').value = "";	
				}
			}
		}
	}else{		
		document.getElementById('scanGun').value = "";		
		document.getElementById('scanGunReader').value = "";			
	}
} 
	
function setSelectionRange(input, selectionStart, selectionEnd) {
  if (input.setSelectionRange) {
    input.focus();
    input.setSelectionRange(selectionStart, selectionEnd);
  }
  else if (input.createTextRange) {
    var range = input.createTextRange();
    range.collapse(true);
    range.moveEnd('character', selectionEnd);
    range.moveStart('character', selectionStart);
    range.select();
  }
}
function setCaretToEnd (input) {
	input.focus();	
	window.parent.onShowEvent();
  	//setSelectionRange(input, input.value.length, input.value.length);
}	
function clearScan(){
	document.getElementById('scanGun').value = "";		
	document.getElementById('scanGunReader').value = "";	
	var overrideChecked = document.getElementById('overrideAll');
	if(overrideCheckAll())
		overrideChecked.checked = true;
	else overrideChecked.checked = false;
}	

//Select All Override Test Scan
function selectAll(){
	var tbody = document.getElementById('values');
	var overrideChecked = document.getElementById('overrideAll').checked;
	for(var i=0;i<tbody.rows.length;i++) {
		var overRiddenCheckBox = document.getElementById("checkDiv"+i);
		if(!overRiddenCheckBox.disabled) {
			overRiddenCheckBox.checked = overrideChecked;
		}
	}
}

function overrideCheckAll()
{
	var tbody = document.getElementById('values');
	for(var i=0;i<tbody.rows.length;i++) {
		var overRiddenCheckBox = document.getElementById("checkDiv"+i);
		var checked = overRiddenCheckBox.checked;
		if(!checked) return false;
	}
	return true;
}
</script>
</form:form></div>
</body>
</html>