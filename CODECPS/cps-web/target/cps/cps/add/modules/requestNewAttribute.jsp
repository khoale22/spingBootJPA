<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="/WEB-INF/functions.tld"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />
<%--The HEB-specific css classes--%>
<c:url value="${request.getContextPath()}/hebAssets/common.css.jsp" var="styleURL"/>
<link href="${styleURL}" rel="stylesheet" type="text/css" />

<%--css for the main menu bar (SpryMenu)--%>
<c:url value="${request.getContextPath()}/hebAssets/SpryAssets/SpryMenuBarHorizontal.css" var="styleURL"/>
<link href="${styleURL}" rel="stylesheet" type="text/css" />

<%--Common js--%>
<c:url value="${request.getContextPath()}/hebAssets/common.js" var="styleURL"/>
<script src="${styleURL}" type="text/javascript"></script>
<%--js for the main menu bar (SpryMenu)--%>
<c:url value="${request.getContextPath()}/hebAssets/SpryAssets/SpryMenuBar.js" var="styleURL"/>
<script src="${styleURL}" type="text/javascript"></script>

<%--css for the YUI button component--%>
<c:url value="${request.getContextPath()}/yui/button/assets/skins/sam/button.css" var="styleURL"/>
<link href="${styleURL}" type="text/css" rel="stylesheet" />

<%--core js for the DWR Ajax functionality--%>
<c:url value="/dwr/engine.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>
<%--Utils for DWR--%>
<c:url value="/dwr/util.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>
<%--CPS Util for DWR--%>
<c:url value="/dwr/interface/FieldHelp.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>

<%--Core yahoo js, supporting namespaces, dom, events--%>
<c:url value="${request.getContextPath()}/yui/yahoo/yahoo-min.js" var="styleURL"/>
<script type="text/javascript" src="${styleURL}" ></script>

<c:url value="${request.getContextPath()}/yui/dom/dom-min.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>

<c:url value="${request.getContextPath()}/yui/event/event-min.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>

<%--more YUI js--%>
<c:url value="${request.getContextPath()}/yui/element/element-beta-min.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>

<%--js for the YUI button component--%>
<c:url value="${request.getContextPath()}/yui/button/button-min.js" var="styleURL"/>
<script type="text/javascript" src="${styleURL}"></script>

<%--most excellent YUI css that gives us reasonably uniform font rendering across browsers and OSes--%>
<c:url value="${request.getContextPath()}/yui/fonts/fonts-min.css" var="styleURL"/>
<link href="${styleURL}" type="text/css" rel="stylesheet" />

<%--css for our many YUI panel-menu thingies--%>
<c:url value="${request.getContextPath()}/yui/container/assets/container-core.css" var="styleURL"/>
<link href="${styleURL}" type="text/css" rel="stylesheet" />

<%--more css for the YUI panel-menus--%>
<c:url value="${request.getContextPath()}/yui/container/assets/skins/sam/container-skin.css" var="styleURL"/>
<link href="${styleURL}" type="text/css" rel="stylesheet" />

<%--js to allow us to drag the YUI panel-menus around--%>
<c:url value="${request.getContextPath()}/yui/dragdrop/dragdrop-min.js" var="styleURL"/>
<script type="text/javascript" src="${styleURL}"></script>

<%--js for the panel-menus--%>
<c:url value="${request.getContextPath()}/yui/container/container-min.js" var="styleURL"/>
<script type="text/javascript" src="${styleURL}"></script>

<%--css for logger--%>
<c:url value="${request.getContextPath()}/yui/logger/assets/logger.css" var="styleURL"/>
<link href="${styleURL}" type="text/css" rel="stylesheet" />

<%--js for YUI logging--%>
<c:url value="${request.getContextPath()}/yui/logger/logger-min.js" var="styleURL"/>
<script type="text/javascript" src="${styleURL}"></script>

<script type="text/javascript">
// these 3 are from the HEB standard page templates.

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function changeImage(obj, image){
	obj.src = image;
}

//from YUI, lets us call an init function when the page's DOM tree is fully in place
YAHOO.util.Event.onDOMReady(hebInit);

var myLogReader;
var myLogReaderIsHidden = true;

//various page init things
function hebInit(){
	//MM_preloadImages('hebAssets/images/F_save_over.gif','hebAssets/images/F_discard_over.gif');
	//instantiate and render the main menu bar
	<c:url value="${request.getContextPath()}/hebAssets/images/menuarrow.gif" var="arrow1"/>
	<c:url value="${request.getContextPath()}/hebAssets/images/menuarrowSub_2.gif" var="arrow2"/>
	var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"${arrow1}", imgRight:"${arrow2}"});
} 
</script>

<c:url value="/dwr/engine.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/util.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/AddCandidateTemp.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<title>Request New Attribute</title>
</head>

<body style="visibility: visible;">
<script type="text/javascript">
function isEmpty() {
	if(trim(document.getElementById('c').value) == "" || trim(document.getElementById('b').value) == "" ||
	   trim(document.getElementById('t').value) == "") {
	   return true;
	}
	return false;
}

function isManadatory() {
	if(trim(document.getElementById('s').value) == "" && 
	   trim(document.getElementById('o').value) == "") {
		return true;
	}
	return false;
}
function request(evt)
{	
	if(trim(document.getElementById('c').value) == "" || trim(document.getElementById('b').value) == "" || trim(document.getElementById('t').value) == "") {
		alert('Cost Owner, Brand, Top 2 Top are required fields');
		return;
	} 	
	var emailLists = document.getElementById('ccMailList').value;
	if(null != emailLists && trim(emailLists) != ""){
		if(!validateMultipleEmailsCommaSeparated(emailLists)){
			alert('Please enter valid email ID(s) separated by semi colons ( ; )');
			return;
		}
	}
	if(trim(document.getElementById('hebVendor').value) != ""){		
		if (validateHebVendorCommaSeparated(document.getElementById('hebVendor').value)) 
		  {
		    alert("H-E-B Vendor # should contain only numbers separated by comma ( , )");
		    return;
		  }
	}
	var b1 = " ";
	if(trim(document.getElementById('c').value) != ""){
	 b1 = trim(document.getElementById('c').value);
	 }
	var b2 = " ";
	if(trim(document.getElementById('b').value) != ""){
	 b2 = trim(document.getElementById('b').value);
	 }
	var b3 = " ";
	if(trim(document.getElementById('t').value) != ""){
	 b3 = trim(document.getElementById('t').value);
	 }
	var b4 = " ";
	if(trim(document.getElementById('hebVendor').value) != ""){
	 b4 = trim(document.getElementById('hebVendor').value);
	}
	var b5 = " ";
	if(trim(document.getElementById('note').value) != ""){
	 b5 = trim(document.getElementById('note').value);
	 }
	document.getElementById("reqeustNewAttr").disabled = true;
	//var emailTest = document.getElementById('emailTest').value;
	//AddCandidateTemp.mail(c1,c2,c3,c4,c5,b1,b2,b3,b4,b5,emailLists,emailTest,getDWRCallbackMethod(checkMailStatus));	
	AddCandidateTemp.mail(b1,b2,b3,b4,b5,emailLists,getDWRCallbackMethod(checkMailStatus));	
}
function checkMailStatus(data){
	document.getElementById("reqeustNewAttr").disabled = false;
	alert(data);
	toClose();
}

function checkCountryValue(){
	var country = YAHOO.util.Dom.get("o").value;
	if(country != null && country != ""){
		var length = country.length;
		country = country.toUpperCase();
		  for(var i=0;i<length;i++){
			    var t = country.charCodeAt(i);	
			    var result = handleAlpha(t);
			    if(result == false){
				    alert("Country of Origin should contain only alphabets");
				    YAHOO.util.Dom.get("o").value = '';
				    return false;
			    }    
		  }	    	
	}	
	return true;
}

function handleAlpha(keyCde){
	 if(keyCde >= 65 && keyCde <= 90){
	  	return true;
	 }else if(keyCde == 32){//Special characters
	  	return true;
	 }else{
	  	return false;
	 }
	}
function validateMultipleEmailsCommaSeparated(value) {
	    var result = value.split(";"); 	
	    var lengthResult = result.length;
	    for(var i = 0;i < lengthResult;i++){  
			if(null != result[i] && trim(result[i]) != "" ){			
				if(!validateEmail(trim(result[i]))) 
					return false;         
			} else if(i != lengthResult-1){			
				return false;     
			}
	    }  
	 //}    
	 return true;
}
function validateEmail(field) {    
   // var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$/;
   // var emailPattern = regex=/\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/i;
    var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
    if (field.search(emailRegEx) == -1) {
         //alert("Please enter a valid email address.");
         return false;
    }
   // return emailPattern.test(field); 
    return true; 
}
function limitText(limitField,limitNum) {
	if (limitField.value.length > limitNum) {
		limitField.value = limitField.value.substring(0, limitNum);
	} 
}
function handleNumber(evt) {
	  var theEvent = evt || window.event;
	  var key = theEvent.keyCode || theEvent.which;
	  key = String.fromCharCode( key );
	  var regex = /[0-9]|\.|,/;
	  if( !regex.test(key) ) {
	    theEvent.returnValue = false;
	    if(theEvent.preventDefault) theEvent.preventDefault();
	  }
	}
function validateHebVendorCommaSeparated(value) {
    var result = value.split(","); 	
    var lengthResult = result.length;
    for(var i = 0;i < lengthResult;i++){  
		if(null != result[i] && trim(result[i]) != "" ){			
			if(isNaN(trim(result[i]))){ 
				return true;         
			}
		} 
    }    
 return false;
}
</script>

<div id="container" style="background-color: #D6DCE2; height: 170px;">
<table width="100%" border="0" cellspacing="0" id="requestNewAttribute"	bordercolor="red">
  
	<tr>
		<td align="left" width="40%"><b>Attributes</b></td>
		<td align="left" width="60%"><b>Value</b></td>
	</tr>
	<tr>
		<td align="left" width="40%">Cost Owner:</td>
		<td align="left" width="60%"><input type="text"	name="costowner" id="c" tabindex="2" style="z-index: 6000;" maxlength="30"></td>
	</tr>
	<tr>
		<td align="left" width="40%">Brand:</td>
		<td align="left" width="60%"><input type="text" name="brand" id="b" tabindex="3" maxlength="30" onkeypress="gotToTop();"></td>
	</tr>
	<tr>
		<td align="left" width="50%">Top 2 Top:</td>
		<td align="left" width="40%"><input type="text" name="top2top" id="t" tabindex="4" maxlength="30" onkeypress="goToSub();"></td>
	</tr>
	<tr>		
		<td align="left" width="40%">H-E-B Vendor #:</td>
		<td align="left" width="60%"><input type="text" name="hebVendor" id="hebVendor" tabindex="5" maxlength="30" onkeypress='handleNumber(event)'/></td>
	</tr>
	<tr>		
		<td align="left" width="40%">Note:</td>
		<td align="left" width="60%"><textarea name="note" id="note" rows="3" cols="55" tabindex="6" name="note" 
		onKeyDown="limitText(this,500);" onKeyUp="limitText(this,500);"></textarea> </td>
	</tr>
	<tr>
		<td width="40%" align="left">Confirmation CC (Carbon Copy) to:(optional)</td>
		<td align="right" width="60%"><input type="text" id="ccMailList" tabindex="7" size="54" style="margin-right:7px"></td>
	</tr>
</table>

<table border="0" width="100%">
 <tr>
	<td width="50%" align="right">
	<button type="button" id="reqeustNewAttr" name="reqeustNewAttr" value="request">Request</button>
	</td>
	<td width="50%" align="left">
	<button type="button" id="assortCancel" name="assortCancel" value="cancel" onblur="setTheFocus();">Cancel</button>
	</td>
</tr> 	
</table>

<a id="link" href="" style="display: none"></a>
</div>
</body>

<script type="text/javascript">
YAHOO.util.Event.addListener(YAHOO.util.Dom.get("assortCancel"), "click", toClose);
YAHOO.util.Event.addListener(YAHOO.util.Dom.get("reqeustNewAttr"), "click", request);

var cancelled = false;
function toClose(evt){	
	cancelled = true;
	window.parent.execScript('closeRNAPanel();', "JavaScript");
}

document.body.scroll = 'no';

function gotToReq(evt){
	//if(evt.keyCode == 13){
	//	document.getElementById("reqeustNewAttr").focus();
	//}
}

function gotToCOO(evt){
	//if(evt.keyCode == 13){
	//	document.getElementById("o").focus();
	//}
}
function goToSub(evt){
	//if(evt.keyCode == 13){
	//	document.getElementById("subbrand").focus();
	//}
}
function gotToTop(evt){
	//if(evt.keyCode == 13){
	//	document.getElementById("t").focus();
	//}
}
function goToBrand(evt){
	//if(evt.keyCode == 13){
	//	document.getElementById("b").focus();
	//}
}
function setTheFocus(){	
	if(cancelled == false){
		document.getElementById("c").focus();
	}	
}

function onLoadPopup(){		
	document.getElementById("c").focus();
}

YAHOO.util.Event.onDOMReady(onLoadPopup); 
</script>
</html>