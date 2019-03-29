<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="/WEB-INF/functions.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<base ref="site" />

<a id="sec3tion"></a>
<c:url var="iconQuestion" value="${request.getContextPath()}/hebAssets/images/buttons/iconQuestion.png"/>

<fieldset style="width: 95%;">
	<legend class="legendFont">Shelf Edge </legend>
	<table width="100%" border="0" cellspacing="3" bordercolor="red">
		<tr>		
			<td align="right" width="19%"><label for="selectedChannel" class="labelFont helpable" id="PackagingLabel">
				Packaging  <em><font color="red"><b>*</b></font></em></label>
			</td>
			<td align="left" width="5%">&nbsp;&nbsp;
				<cps:renderByResourceAccess resourceId="42" honorViewMode="${addNewCandidate.packagingViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:input path="productVO.shelfEdgeVO.packaging" maxlength="30" size="" tabindex="40"
									cssClass="textFieldNormal" id="Packaging"
									style="TEXT-TRANSFORM : uppercase; dataType: alphanumericSpecial;"
									onkeyup="switchToUpperCase(this); return true;"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.shelfEdgeVO.packaging" disabled="true" id="Packaging"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>		
			<td align="right" width="29%">
				<label for="selectedChannel" class="labelFont helpable" id="CustDesc1Label">
					Customer Friendly Description 1
					<c:choose>
						<c:when test="${addNewCandidate.scaleProduct eq false}">
							<c:set var="cfdStyle" value="display:block;"></c:set>
						</c:when>
						<c:otherwise>
							<c:set var="cfdStyle" value="display:none;"></c:set>
						</c:otherwise>
					</c:choose>
					<span class="mtGroup mtGroup1 mtGroup4 mtGroup5" id="cfdix" style="${cfdStyle}">
						<em id="cfdStar" style="color:red"><b>*</b></em>
					</span>
				</label>
			</td>
			<td align="left" width="5%">&nbsp;&nbsp;
				<cps:renderByResourceAccess resourceId="43" honorViewMode="${addNewCandidate.packagingViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:input path="productVO.shelfEdgeVO.custFrndlyDescription1"
									cssClass="textFieldNormal mtGroup mtGroup1 mtGroup4" maxlength="30" size=""
									tabindex="41" id="custFrndlyDescription1" style="dataType: alphanumericCustomer;"
									onblur="camelCase1()"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.shelfEdgeVO.custFrndlyDescription1" disabled="true"
									id="custFrndlyDescription1" cssClass="mtGroup mtGroup1 mtGroup4"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>			
			<td align="left" width="2%">
				<img src="${iconQuestion}" title="Need a word in all CAPS? Call ext. 88185." width="20"
					 onmouseover="this.style.cursor='pointer'"/>
			</td>	
			<td align="right" width="28%">
				<label for="selectedChannel" class="labelFont helpable" id="CustDesc2Label">
					Customer Friendly Description 2
				</label>
			</td>
			<td align="left" width="5%">
				<cps:renderByResourceAccess resourceId="44">
					<jsp:attribute name="EDIT">
						<form:input path="productVO.shelfEdgeVO.custFrndlyDescription2"
									cssClass="textFieldNormal mtGroup mtGroup1 mtGroup4" maxlength="30" size=""
									tabindex="42" id="custFrndlyDescription2" style="dataType: alphanumericCustomer;"
									onblur="camelCase2()" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.shelfEdgeVO.custFrndlyDescription2" disabled="true"
									id="custFrndlyDescription2" cssClass="mtGroup mtGroup1 mtGroup4" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>			
			<td align="left" width="2%">
				<img src="${iconQuestion}" title="Need a word in all CAPS? Call ext. 88185." width="20"
					 onmouseover="this.style.cursor='pointer'"/>
			</td>			
		</tr>
	</table>
</fieldset>

<script type="text/javascript">
function camelCase(evt){
	var cfd1 = YAHOO.util.Dom.get("custFrndlyDescription1").value; 
	var cfd2 = YAHOO.util.Dom.get("custFrndlyDescription2").value;
	YAHOO.util.Dom.get("custFrndlyDescription1").value = getCamelCase(cfd1);
	YAHOO.util.Dom.get("custFrndlyDescription2").value = getCamelCase(cfd2);

  }
function isValid(str){
	return !/[~`!^=\[\]\';,{}\":<>]/g.test(str);
}
function spaceTrim(x) {
	return x.replace(/^\s+|\s+$/gm,'');
}
var originalCfd1 = "";
var originalCfd2 = "";
function camelCase1(evt){
	var cfd1 = YAHOO.util.Dom.get("custFrndlyDescription1").value;
	if(null != cfd1 && spaceTrim(cfd1) !=""){
		if(isValid(cfd1)){
			if(cfd1 != originalCfd1){
				showProgress();
				AddCandidateTemp.getSpellCheckDes(cfd1,getDWRCallbackMethod(camelCaseCallback1));
			}
		}else {
			alert("Customer Friendly Description 1 is not allow special characters");
			YAHOO.util.Dom.get("custFrndlyDescription1").value = "";
		}
		
	}
}
function camelCaseCallback1(data){
	originalCfd1 = data;
	YAHOO.util.Dom.get("custFrndlyDescription1").value = data;
	hideTheProgress();
	YAHOO.util.Dom.get("custFrndlyDescription2").focus();
}
function camelCaseCallback2(data){
	originalCfd2 = data;
	YAHOO.util.Dom.get("custFrndlyDescription2").value = data;
	hideTheProgress();
	YAHOO.util.Dom.get("style").focus();
}
function camelCase2(evt){
	var cfd2 = YAHOO.util.Dom.get("custFrndlyDescription2").value; 
	if(null != cfd2 && spaceTrim(cfd2) !=""){
		if(isValid(cfd2)){
			if(cfd2 != originalCfd2){
				showProgress();
				AddCandidateTemp.getSpellCheckDes(cfd2,getDWRCallbackMethod(camelCaseCallback2));
			}
		}else {
			alert("Customer Friendly Description 2 is not allow special characters");
			YAHOO.util.Dom.get("custFrndlyDescription2").value = "";
		}
	}
}

function getCamelCase(text){
	text = text.replace(/^\s+|\s+$/g,'').replace(/\s+/g,' ').toLowerCase();
	var words = text.split(' ');
	var returnVal = '';
	var flag = false;
	for(i = 0; i < words.length; i++){
		var word = words[i];
		if(flag){
			returnVal = returnVal + ' ';
		}
		if(word == 'to' || word == 'from'
		|| word == 'a' || word == 'the' || word == 'of'
		|| word == 'by' || word == 'or' || word == 'and'){
			returnVal = returnVal + word;
		} else if (word == 'hcf' || word == 'heb' || word == 'h-e-b' || word == 'h-c-f'){
			returnVal = returnVal + word.toUpperCase();			
		} else if(word == 'h-e-buddy'){
			returnVal = returnVal + 'H-E-Buddy';
		} else if(word == 'hcf-hill'){
			returnVal = returnVal + 'HCF-Hill';
		} else if(word == 'hce'){
			returnVal = returnVal + 'HCE';
		}else{
			returnVal = returnVal + word.titleCase();			
		}
		flag = true;
	}
	return returnVal;
}
</script>
