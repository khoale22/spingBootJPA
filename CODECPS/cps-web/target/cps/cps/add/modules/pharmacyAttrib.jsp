<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<fieldset style="width: 95%;">
	<legend class="legendFont">Pharmacy Attributes</legend>
<c:choose>
	<c:when test="${addNewCandidate.productVO.classificationVO.productType eq 'SPLY'}">
		<c:set value="display: none;position: absolute;" var="styleVar"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="display: block;position: absolute;" var="styleVar"></c:set>
	</c:otherwise>
</c:choose>	
	<table border="0" width="100%">
		<tr>
			<td align="right" width="10%"><label class="labelFont helpable" id="NDCLabel">NDC </label></td>
			<cps:renderByResourceAccess	resourceId="72"  honorViewMode="${addNewCandidate.retailViewOverRide}">
				<jsp:attribute name="EDIT">
					<td align="left" width="10%">&nbsp;&nbsp;
						<form:input	path="productVO.pharmacyVO.ndc" maxlength="11" size="11" tabindex="580"
									   style="dataType : numeric;" styleId="ndc" id="ndc"/>
					</td>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<td align="left" width="10%">&nbsp;&nbsp;
						<form:input path="productVO.pharmacyVO.ndc" maxlength="11" size="11" tabindex="580"
									style="dataType : numeric;" styleId="ndc" id="ndc" disabled="true" />
					</td>
				</jsp:attribute>
			</cps:renderByResourceAccess>
			<td align="right" width="10%">
				<cps:renderByResourceAccess	resourceId="73"  honorViewMode="${addNewCandidate.retailViewOverRide}">
					<jsp:attribute name="EDIT">
						<label class="labelFont helpable" id="DrugAbbLabel">Drug Abbreviation </label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label class="labelFont helpable" id="DrugAbbLabel">Drug Abbreviation </label>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left" width="10%">&nbsp;&nbsp;
				<cps:renderByResourceAccess	resourceId="73"  honorViewMode="${addNewCandidate.retailViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:select path="productVO.pharmacyVO.drugNmCd"  tabindex="590" style="dataType : alpha;"
									 styleId="drugAbb" id="drugAbb">
							<form:option value="">--select--</form:option>
						</form:select>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:select path="productVO.pharmacyVO.drugNmCd"  tabindex="590" style="dataType : alpha;"
									 styleId="drugAbb" id="drugAbb" disabled="true">
							<form:option value="">--select--</form:option>
						</form:select>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="10%">
				<label class="labelFont helpable" id="DrugScheduleLabel">Drug Schedule </label>
			</td>
			<cps:renderByResourceAccess	resourceId="74"  honorViewMode="${addNewCandidate.retailViewOverRide}">
				<jsp:attribute name="EDIT">
					<td align="left" width="10%">&nbsp;&nbsp;
						<form:select path="productVO.pharmacyVO.drugSchedule" tabindex="600" style="dataType : alpha"
									 styleId="drugSchedule" id="drugSchedule">
							<form:option value="">--select--</form:option>
						</form:select>
					</td>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<td align="left" width="10%">&nbsp;&nbsp;
						<form:select path="productVO.pharmacyVO.drugSchedule" tabindex="600" id="drugSchedule"
									 style="dataType : alphanumeric" styleId="drugSchedule" disabled="true">
							<form:option value="">--select--</form:option>
						</form:select>
					</td>
				</jsp:attribute>
			</cps:renderByResourceAccess>
			<td align="right" width="10%">
				<label class="labelFont helpable" id="AvgWholeCostLabel">Average Wholesale Cost </label>
			</td>
			<cps:renderByResourceAccess	resourceId="75"  honorViewMode="${addNewCandidate.retailViewOverRide}">
				<jsp:attribute name="EDIT">
					<td align="left" width="10%">&nbsp;&nbsp;
						<form:input path="productVO.pharmacyVO.avgCost" size="15" tabindex="610" id="avgCost"
									style="dataType : float;" maxlength="12" onblur="validateAvgCost();" styleId="avgCost"/>
					</td>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<td align="left" width="10%">&nbsp;&nbsp;
						<form:input path="productVO.pharmacyVO.avgCost" maxlength="12" size="15" tabindex="610"
									style="dataType : float;" styleId="avgCost" disabled="true" id="avgCost"/>
					</td>
				</jsp:attribute>
			</cps:renderByResourceAccess>
		</tr>
		<tr>
			<td align="right" width="10%">
				<label class="labelFont helpable" id="DirectCostLabel">Direct Cost </label>
			</td>
			<cps:renderByResourceAccess	resourceId="76"  honorViewMode="${addNewCandidate.retailViewOverRide}">
				<jsp:attribute name="EDIT">
					<td align="left" width="10%">&nbsp;&nbsp;
						<form:input path="productVO.pharmacyVO.directCost" maxlength="6" size="5" tabindex="620"
									style="dataType : float;" onblur="validateDirectCost();" styleId="directCost" id="directCost"/>
					</td>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<td align="left" width="10%">&nbsp;&nbsp;
						<form:input path="productVO.pharmacyVO.directCost" maxlength="6" size="5" tabindex="620"
									style="dataType : float;" styleId="directCost" disabled="true" id="directCost"/>
					</td>
				</jsp:attribute>
			</cps:renderByResourceAccess>
		</tr>
	</table>
</fieldset>

<script type="text/javascript">
	//drugSchedule
	function getPharmLists(){
		AddCandidateTemp.getPharmacyAttribLists(getDWRCallbackMethod(populatePharmLists));
	}
	
	function populatePharmLists(data){
		var ds = data.DRUG_SCHEDULES;
		var abb = data.DRUG_ABBR;


		dwr.util.removeAllOptions("drugSchedule");
		dwr.util.addOptions("drugSchedule", ds, "id", "name");

		<cps:currentComponentValueSubTag strutsHiddenElmProperty="productVO.pharmacyVO.drugSchedule" uniqueId="ignore" />
		<c:if test="${currentComponentId != null}">
			dwr.util.setValue("drugSchedule", "${currentComponentId}");
		</c:if>

		dwr.util.removeAllOptions("drugAbb");
		dwr.util.addOptions("drugAbb", abb, "id", "name");
		<cps:currentComponentValueSubTag strutsHiddenElmProperty="productVO.pharmacyVO.drugNmCd" uniqueId="ignore" />
		<c:if test="${currentComponentId != null}">
			dwr.util.setValue("drugAbb", "${currentComponentId}");
		</c:if>
		<c:if test="${addNewCandidate.productVO.modifyFlag==true}">
			if(document.getElementById('activateButton')!=null)
				document.getElementById('activateButton').disabled = true;
		</c:if>
	}

	YAHOO.util.Event.onDOMReady(getPharmLists);

	function showAsterisk(){
		var pseType = dwr.util.getValue("PSE");
		if(pseType =="Y"){
		document.getElementById("gramLabelDiv").style.display = "block";
		}else{
		document.getElementById("gramLabelDiv").style.display = "none";
		}
	}

	function validateAvgCost(){
		var avgCost = document.getElementById("avgCost").value;
		if(null != avgCost && "" != avgCost){
			var pos = avgCost.indexOf(".");
			var realPart = "";
			var decimal = "";
			if(pos != -1){
				realPart= avgCost.substring(0, pos);
				if(pos+1 < avgCost.length){
					decimal= avgCost.substring(pos+1, avgCost.length);
				}
			}else{
				if(avgCost.length > 11){
					document.getElementById("avgCost").value = avgCost.substring(0, 11);
				}
				realPart= document.getElementById("avgCost").value;
			}
			if(null != realPart && "" != realPart){
				if(realPart.length >8 ){
					alert("Average Wholesale Cost should contain only 8 real digits");
					document.getElementById("avgCost").value = "";
					return;
				}
			}
			if(null != decimal && "" != decimal){
				if(decimal.length >3 ){
					document.getElementById("avgCost").value = realPart+"."+decimal.substring(0,3);
				}
			}
		}
	}

	function validateDirectCost(){
		var directCost = document.getElementById("directCost").value;
		if(null != directCost && "" != directCost){
			var pos = directCost.indexOf(".");
			var realPart = "";
			var decimal = "";
			if(pos != -1){
				realPart= directCost.substring(0, pos);
				if(pos+1 < directCost.length){
					decimal= directCost.substring(pos+1, directCost.length);
				}
			}else{
				realPart= directCost;
			}

			if(null != realPart && "" != realPart){
				if(realPart.length > 1){
					alert("Direct Cost should contain only 1 real digit");
					document.getElementById("directCost").value = "";
					return;
				}
			}
			if(null != decimal && "" != decimal){
				if(decimal.length >4 ){
					document.getElementById("directCost").value = realPart+"."+decimal.substring(0,4);
				}
			}
		}
	}
</script>