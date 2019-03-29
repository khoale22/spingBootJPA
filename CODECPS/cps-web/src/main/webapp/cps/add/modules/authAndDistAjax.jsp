<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.heb.operations.cps.vo.*" %>
<c:url var="colspd" value="${request.getContextPath()}/hebAssets/images/collapsed.gif"></c:url>
<c:url var="expnd" value="${request.getContextPath()}/hebAssets/images/expanded.gif"></c:url>
<c:url var="calend" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>	
<c:url var="calend1" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
<c:url var="cal" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
<c:url var="calen" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
<fieldset style="width: 96%; margin-left: 10px; border-collapse: collapse;" id="f2">
<c:choose>
<c:when test="${showNoData eq 'true'}">
	<legend id="caseDetailsLegend">Add New Case Details</legend> <input type="hidden" id="selectedCaseUniqueId" value="${selectedCaseVO.uniqueId}">
</c:when>
<c:otherwise>
	<legend id="caseDetailsLegend">Edit Case Details</legend> <input type="hidden" id="selectedCaseUniqueId" value="${selectedCaseVO.uniqueId}">
</c:otherwise>
</c:choose>

<c:choose>
<c:when test="${showNoData eq 'true'}">

	<table width="100%" border="0">
		<tr>
		<td align="right" width="19%"><label class="labelFont helpable" id="CaseDescriptionLabel">Case	Description  <em><font color="red"><b>*</b></font></em></label></td>
		<td align="left" width="18%">
			<cps:renderByResourceAccess	resourceId="81" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<input type="text" value=""	id="caseDescriptionText" maxlength="30" class="textFieldNormal"	tabindex="10" onblur="valdKeyPressSymbSpec(this);switchToUpperCase(this);return true;" style="TEXT-TRANSFORM: uppercase; dataType: alphanumeric;"/>
					</jsp:attribute>
				<jsp:attribute name="VIEW">
					<input type="text" value=""	id="caseDescriptionText" maxlength="30" class="textFieldNormal"	tabindex="10" disabled="disabled" />
				</jsp:attribute>
			</cps:renderByResourceAccess>
		</td>
		<td width="11%" align="right"><label class="labelFont helpable" id="ChannelLabel">Channel <em><font color="red"><b>*</b></font></em></label></td>
		<td width="11%" align="left">&nbsp; <cps:renderByResourceAccess	resourceId="83">
			<jsp:attribute name="EDIT">
				<select id="actions3" tabindex="15"	onchange="selectChannelAjax();displayImportDivAjax();">
					<c:forEach items="${CPSForm.channels}" var="channel">
						<option value="${channel.id}" <c:if test="${selectedCaseVO.channelVal == -1}">selected</c:if>>${channel.name}</option>
					</c:forEach>
				</select>					
			</jsp:attribute>
			<jsp:attribute name="VIEW">
						<select id="actions3" tabindex="15" disabled="disabled">
							<c:forEach items="${CPSForm.channels}" var="channel">
								<option value="${channel.id}"
							<c:if test="${selectedCaseVO.channelVal eq channel.id}">selected</c:if>>${channel.name}</option>
							</c:forEach>
						</select>										
					</jsp:attribute>
		</cps:renderByResourceAccess></td>
		<td align="right" width="19%"><div id="CatchWtSwLabelDiv" style="display: none; "><label class="labelFont helpable" id="CatchWtSwLabel">Catch Weight Sw</label></div></td>
		<td align="left" width="22%"><div id="catchRadioDiv" style="display: none; ">&nbsp;&nbsp; 
			<c:set var="catchChk" value=""></c:set>
			<c:if test="${selectedCaseVO.catchWeight eq true}">
				<c:set var="catchChk" value="checked='checked'"></c:set>
			</c:if>
			<cps:renderByResourceAccess resourceId="88" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<input type="radio" name="upcradio" ${catchChk} id="catchRadio" maxlength="1" tabindex="20" />
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<input type="radio" name="upcradio" ${catchChk} id="catchRadio" maxlength="1" tabindex="20" disabled="disabled" />
				</jsp:attribute>
			</cps:renderByResourceAccess></div>
		</td>
        </tr>
	</table>
		<c:choose>
			<c:when	test='${selectedCaseVO.channelVal eq "DSD"}'>
				<c:set	value="visibility: hidden; position: absolute;"	var="styleStr12" />
			</c:when>
			<c:otherwise>
				<c:set value="visibility: visible; position: static;" var="styleStr12" />
			</c:otherwise>
		</c:choose>
		<table width="100%" border="0" bordercolor="blue">
		<tr>
			<td width="37%">
				<div id="caseUpcDiv" style="${styleStr12}">
					<table width="100%" border="0" bordercolor="blue">
					<tr>
					<td align="right" width="57%">
						<label class="labelFont helpable" id="CaseUPCLabel">Case UPC
							<em><font color="red"><b>*</b></font></em>
						</label>
					</td>
					<td align="left" width="49%">
						<cps:renderByResourceAccess	resourceId="79" honorViewMode="${selectedCaseVO.caseViewOverride}">
							<jsp:attribute name="EDIT">
								<input type="text" value="" style="dataType: numeric;" id="caseUpcText" maxlength="13" onkeyup="autotab(this,'caseCheckDigit');return true;" class="textFieldMedium" tabindex="23" />
								<label for="selectedChannel" class="labelFont">-</label> 
								<input type="text" tabindex="24" class="textFieldMedium" id="caseCheckDigit" maxlength="1" style="dataType: numeric; width: 10px;" size="1" onblur="verifyCheckDigit();" value=""/>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<input type="text" value=""	style="dataType: numeric;" id="caseUpcText" maxlength="13" onkeyup="autotab(this,'caseCheckDigit');return true;" class="textFieldMedium" tabindex="23" disabled="disabled" />
								<label for="selectedChannel" class="labelFont">-</label> 
								<input type="text" class="textFieldMedium" id="caseCheckDigit" maxlength="1" style="dataType: numeric; width: 10px;" size="1" value="" disabled="disabled"/>
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</td>
					</tr>
					</table>
				</div>
			</td>
	
		<td width="22%"></td>
			<td width="19%" align="right"><div id="VariableWtSwLabelDiv" style="display: none; "><label class="labelFont helpable" id="VariableWtSwLabel">Variable	Weight Sw</label></div></td>
		<td width="22%" align="left"><div id="variableRadioDiv" style="display: none; ">&nbsp;&nbsp; 
			<c:set var="variableChk" value=""></c:set>
			<c:if test="${selectedCaseVO.variableWeight eq true}">
				<c:set var="variableChk" value="checked='checked'"></c:set>
			</c:if> 
			<cps:renderByResourceAccess resourceId="89" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<input type="radio" name="upcradio" id="variableRadio" ${variableChk} maxlength="1" tabindex="21"  class="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"/>					
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<input type="radio" name="upcradio" id="variableRadio" ${variableChk} maxlength="1" tabindex="21"  disabled="disabled" style="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" />					
				</jsp:attribute>
			</cps:renderByResourceAccess></div>
		</td>
		</tr>
		<tr>
		<td colspan="2"></td>
		<td align="right" width="19%"><div id="NoneLabelDiv" style="display: none; "><label class="labelFont helpable" id="NoneLabel">None</label></div></td>
		<td align="left" width="22%"><div id="noneRadioDiv" style="display: none; ">&nbsp;&nbsp;
			<c:set var="noneChk" value=""></c:set>
			<c:if test="${selectedCaseVO.none eq true}">
				<c:set var="noneChk" value="checked='checked'"></c:set>
			</c:if> 
			<cps:renderByResourceAccess	resourceId="90" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<input type="radio" name="upcradio" ${noneChk} id="noneRadio" maxlength="1" tabindex="22" />
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<input type="radio" name="upcradio" ${noneChk} id="noneRadio" maxlength="1" tabindex="22" disabled="disabled" />
				</jsp:attribute>
			</cps:renderByResourceAccess></div>
		</td>
		</tr>
	</table>
	<br />


	<table width="100%">
	<tr>
		<td width="17%">
			<c:choose>
				<c:when	test='${selectedCaseVO.channelVal eq "DSD" or selectedCaseVO.channelVal eq "BOTH" or selectedCaseVO.channelVal eq "WHS" or selectedCaseVO.channelVal eq "0"}'>
					<c:set	value="visibility: hidden;"	var="styleStr" />
				</c:when>
				<c:otherwise>
					<c:set	value="visibility: hidden;"	var="styleStr" />
				</c:otherwise>
			</c:choose>

	<div id="masterPackDiv" style="${styleStr}">

	<table width="100%" border="0">
		<tr align="left">
			<td align="right" width="10%"><label class="labelFont helpable" id="MasterPackLabel">Master	pack<em><font color="red"><b>*</b></font></em></label></td>
			<td align="left" width="7%">&nbsp;
				<cps:renderByResourceAccess	resourceId="84" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<input type="text" value=""	id="masterPackText" maxlength="3" class="textFieldSmall" tabindex="35" style="dataType: numeric;"  onblur="calculateUnitCost();"/>					
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input type="text" value=""	id="masterPackText" maxlength="3" class="textFieldSmall" tabindex="35"	style="dataType: numeric;" disabled="disabled" />					
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
		</tr>
	</table>
	</div>
	</td>
	<td width="83%">
		<c:choose>
			<c:when	test='${selectedCaseVO.channelVal eq "DSD"}'>
				<c:set value="visibility: hidden; position: absolute;" var="styleStr2" />
			</c:when>
			<c:otherwise>
				<c:set value="visibility: hidden; position: absolute;" var="styleStr2" />
				
			</c:otherwise>
		</c:choose>


	<div id="whs_details" style="${styleStr2}">


	<table width="100%" border="0">
		<tr>
			<td align="right" width="7%"><label class="labelFont helpable" id="MasterLengthLabel">Length<em><font color="red"><b>*</b></font></em></label></td>
			<td align="left" width="10%">
				<cps:renderByResourceAccess	resourceId="91" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<input type="text" value="" id="masterLength" maxlength="8" class="textFieldSmall" 
						onkeydown="return onKeyDownRestrictDecimal(event, this, 'length');"
						onblur="checkLength('master');calculateMasterCube(); check();return true;" 
						tabindex="40"	style="dataType: float;" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input type="text" value="" id="masterLength" maxlength="8" class="textFieldSmall" tabindex="40" style="dataType: float;" disabled="disabled" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<label for="selectedChannel" class="labelFont">in</label>
			</td>
			<td align="right" width="7%"><label class="labelFont helpable" id="MasterWidthLabel">Width<em><font color="red"><b>*</b></font></em></label></td>
			<td align="left" width="10%">
				<cps:renderByResourceAccess	resourceId="92" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<input type="text" value=""	id="masterWidth" maxlength="8" class="textFieldSmall" 
						onkeydown="return onKeyDownRestrictDecimal(event, this, 'width');"
						onblur="checkWidth('master');calculateMasterCube(); check();return true;" 
						tabindex="45"	style="dataType: float;" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input type="text" value=""	id="masterWidth" maxlength="8" class="textFieldSmall" tabindex="45"	style="dataType: float;" disabled="disabled" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<label for="selectedChannel" class="labelFont">in</label>
			</td>
			<td align="right" width="7%"><label class="labelFont helpable" id="MasterHeightLabel">Height<em><font color="red"><b>*</b></font></em></label></td>
			<td align="left" width="10%">
				<cps:renderByResourceAccess	resourceId="93" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<input type="text" value="" id="masterHeight" maxlength="8" class="textFieldSmall" 
						tabindex="50" style="dataType: float;" 
						onkeydown="return onKeyDownRestrictDecimal(event, this, 'height');"
						onblur="checkHeight('master');calculateMasterCube(); check();return true;" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input type="text" value="" id="masterHeight" maxlength="8" class="textFieldSmall" tabindex="50" style="dataType: float;" disabled="disabled" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<label for="selectedChannel" class="labelFont">in</label>
			</td>
			<td align="right" width="5%"><label class="labelFont helpable" id="MasterLabel">Cube</label></td>
			<td align="left" width="10%">&nbsp;&nbsp; 
				<cps:renderByResourceAccess	resourceId="94" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<label id="masterCubeLabel" class="labelFont">${selectedCaseVO.masterCubeFormatted}</label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label id="masterCubeLabel" class="labelFont">${selectedCaseVO.masterCubeFormatted}</label>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<label	for="selectedChannel" class="labelFont"> cu.ft</label>
			</td>
			<td align="right" width="7%"><label class="labelFont helpable" id="MasterWeightLabel">Weight<em><font color="red"><b>*</b></font></em></label></td>
			<td align="left" width="10%">
				<cps:renderByResourceAccess	resourceId="95" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<input type="text" value=""	id="masterWeight" maxlength="8" class="textFieldSmall"	
						tabindex="55" style="dataType: float;" 
						onkeydown="return onKeyDownRestrictDecimal(event, this, 'weight');"
						onblur="chekDecimalValue(this, 2); check();return true;"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input type="text" value=""	id="masterWeight" maxlength="8" class="textFieldSmall"	tabindex="55" style="dataType: float;" disabled="disabled" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
		</tr>
	</table>
	</div>
	</td>
	</tr>
	<tr>
	<td width="100%" colspan="2">
		<c:choose>
			<c:when	test='${selectedCaseVO.channelVal eq "DSD"}'>
				<c:set value="visibility: hidden; position: absolute;"	var="styleStr3" />
			</c:when>
			<c:otherwise>
				<c:set value="visibility: hidden; position: absolute;" var="styleStr3" />
			</c:otherwise>
		</c:choose>
	<div id="shipPackDiv" style="${styleStr3}">
		
	<table width="100%" border="0">
	<tr align="left">
		<td align="right" width="10%"><label class="labelFont helpable" id="ShipPackLabel">Ship	Pack<em><font color="red"><b>*</b></font></em></label></td>
		<td align="left" width="7%">
			<cps:renderByResourceAccess	resourceId="85" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<input type="text" value="" id="shipPackText" maxlength="3" class="textFieldSmall"	tabindex="60" style="dataType: numeric; " onblur="check(); calculateUnitCost();" />
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<input type="text" value="" id="shipPackText" maxlength="3" class="textFieldNormal"	tabindex="60" style="dataType: numeric;" disabled="disabled" />
				</jsp:attribute>
			</cps:renderByResourceAccess>
		</td>
		<td align="right" width="7%"><label class="labelFont helpable" id="ShipPackLengthLabel">Length<em><font color="red"><b>*</b></font></em></label></td>
		<td align="left" width="10%">
			<cps:renderByResourceAccess	resourceId="96" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<input type="text" value=""	id="shipLength" maxlength="8" class="textFieldSmall" tabindex="75"	
					onkeydown="return onKeyDownRestrictDecimal(event, this, 'length');"
					onblur="checkLength('ship');calculateShipCube();validateShip('Length');return true;" 
					style="dataType: float;" />
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<input type="text" value=""	id="shipLength" maxlength="8" class="textFieldSmall" tabindex="75"	style="dataType: float;" disabled="disabled" />
				</jsp:attribute>
			</cps:renderByResourceAccess>
			<label for="selectedChannel" class="labelFont">in</label>
		</td>
		<td align="right" width="7%"><label class="labelFont helpable" id="ShipPackWidthLabel">Width<em><font color="red"><b>*</b></font></em></label></td>
		<td align="left" width="10%">
			<cps:renderByResourceAccess resourceId="97" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<input type="text" id="shipWidth" value="" maxlength="8" class="textFieldSmall" tabindex="80" 
					onkeydown="return onKeyDownRestrictDecimal(event, this, 'width');"
					onblur="checkWidth('ship');calculateShipCube();validateShip('Width');return true;" 
					style="dataType: float;" />
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<input type="text" id="shipWidth" value="" maxlength="8" class="textFieldSmall" tabindex="80" style="dataType: float;" disabled="disabled" />
				</jsp:attribute>
			</cps:renderByResourceAccess>
			<label for="selectedChannel" class="labelFont">in</label>
		</td>
		<td align="right" width="7%"><label class="labelFont helpable" id="ShipPackHeightLabel">Height<em><font color="red"><b>*</b></font></em></label></td>
		<td align="left" width="10%">
			<cps:renderByResourceAccess	resourceId="98" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<input type="text" value="" id="shipHeight" maxlength="8" class="textFieldSmall" tabindex="85"	
					onkeydown="return onKeyDownRestrictDecimal(event, this, 'height');"
					onblur="checkHeight('ship');calculateShipCube();validateShip('Height');return true;" 
					style="dataType: float;" />
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<input type="text" value=""	id="shipHeight" maxlength="8" class="textFieldSmall" tabindex="85"	style="dataType: float;" disabled="disabled" />
				</jsp:attribute>
			</cps:renderByResourceAccess>
			<label for="selectedChannel" class="labelFont">in</label>
		</td>
		<td align="right" width="5%"><label class="labelFont helpable" id="ShipLabel">Cube</label></td>
		<td align="left" width="10%">&nbsp;&nbsp; 
			<cps:renderByResourceAccess	resourceId="99" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<label class="labelFont" id="shipCubeLabel">${selectedCaseVO.shipCubeFormatted}</label>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<label class="labelFont" id="shipCubeLabel">${selectedCaseVO.shipCubeFormatted}</label>
				</jsp:attribute>
			</cps:renderByResourceAccess>
			<label	for="selectedChannel" class="labelFont"> cu.ft</label>
		</td>
		<td align="right" width="7%"><label class="labelFont helpable" id="ShipWeightLabel">Weight<em><font color="red"><b>*</b></font></em></label></td>
		<td align="left" width="10%">
			<cps:renderByResourceAccess	resourceId="100" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<input type="text" value=""	id="shipWeight" maxlength="10" class="textFieldSmall" tabindex="90"	style="dataType: float;" 
					onkeydown="return onKeyDownRestrictDecimal(event, this, 'weight');"
					onblur="chekDecimalValue(this, 2);return true;"/>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<input type="text" value=""	id="shipWeight" maxlength="10" class="textFieldSmall" tabindex="90"	style="dataType: float;" disabled="disabled"/>
				</jsp:attribute>
			</cps:renderByResourceAccess>
		</td>
	</tr>
	<tr>
		<td align="right" width="10%"><label class="labelFont helpable" id="UnitFactorLabel">Unit Factor</label></td>
		<td align="left" width="7%">
			<cps:renderByResourceAccess	resourceId="101" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<input type="text" value=""	id="unitFactor" maxlength="7" class="textFieldSmall" tabindex="95"	style="dataType: float;" onblur="roundValue(this,3);return true;"/>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<input type="text" value=""	id="unitFactor" maxlength="7" class="textFieldSmall" tabindex="95"	style="dataType: float;" disabled="disabled" />
				</jsp:attribute>
			</cps:renderByResourceAccess>
		</td>
		<!-- Max Ship attribute added -->
		<td align="right" width="10%">
			<cps:renderByResourceAccess	resourceId="243" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<label class="labelFont helpable" id="MaxShipLabel">Max Ship</label>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<label class="labelFont helpable" id="MaxShipLabel">Max Ship</label>
				</jsp:attribute>
				<jsp:attribute name="NONE">
				</jsp:attribute>
			</cps:renderByResourceAccess>
		</td>
		<td width="15%" align="left" colspan="2">&nbsp;&nbsp;
			<cps:renderByResourceAccess	resourceId="243" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<input type="text" value=""	id="maxShipText" maxlength="5" class="textFieldSmall" tabindex="100"	style="dataType: numeric;" />
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<input type="text" value=""	id="maxShipText" maxlength="3" class="textFieldSmall" tabindex="100"	style="dataType: numeric;" disabled="disabled"/>	
				</jsp:attribute>
				<jsp:attribute name="NONE">
					<input type="text" value=""	id="maxShipText" maxlength="3" class="textFieldSmall" tabindex="100"	style="dataType: numeric;display:none;" />
				</jsp:attribute>
			</cps:renderByResourceAccess>
		</td>
		
		<td align="right" width="15%">
			<cps:renderByResourceAccess resourceId="245" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<label class="labelFont helpable" id="PurchaseStatusLabel">Purchase Status</label>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<label class="labelFont helpable" id="PurchaseStatusLabel">Purchase Status</label>
				</jsp:attribute>
			</cps:renderByResourceAccess>
		</td>
		<td align="left" width="15%">&nbsp;&nbsp;
			<cps:renderByResourceAccess resourceId="245" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<select
					id="purchaseStatus" tabindex="101" class="selectBoxStyle"
					style="dataType: alpha;">
					<c:forEach var="opt"
						items="${selectedCaseVO.purchaseStatusList}">
						<c:if test="${opt.id eq selectedCaseVO.purchaseStatus}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedCaseVO.purchaseStatus}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
					</select>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<select
					id="purchaseStatus" tabindex="101" class="selectBoxStyle"
					style="dataType: alpha;" disabled="disabled">
					<c:forEach var="opt"
						items="${selectedCaseVO.purchaseStatusList}">
						<c:if test="${opt.id eq selectedCaseVO.purchaseStatus}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedCaseVO.purchaseStatus}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
					</select>
				</jsp:attribute>
				<jsp:attribute name="NONE">
					<select
					id="purchaseStatus" tabindex="101" class="selectBoxStyle"
					style="dataType: alpha; visibility: hidden;" disabled="disabled">
					<c:forEach var="opt"
						items="${selectedCaseVO.purchaseStatusList}">
						<c:if test="${opt.id eq selectedCaseVO.purchaseStatus}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedCaseVO.purchaseStatus}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
					</select>
				</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			
			
			
	</tr>
	<tr>
		<cps:renderByResourceAccess resourceId="105" honorViewMode="${selectedCaseVO.caseViewOverride}">
			<jsp:attribute name="EDIT">
			<td width="10%" align="right"><label class="labelFont helpable" id="CodeDateLabel">Code Date</label></td>
			<td width="7%" align="left">&nbsp;
				<input type="checkbox" value="" id="codeDate"	tabindex="105" />
			</td>
			</jsp:attribute>
			<jsp:attribute name="VIEW">
				<td width="10%" align="right"><label class="labelFont helpable" id="CodeDateLabel">Code Date</label></td>
				<td width="7%" align="left">&nbsp;
					<input type="checkbox" value=""  id="codeDate"	tabindex="105" disabled="disabled" />
				</td>
			</jsp:attribute>
			<jsp:attribute name="NONE">
				<td width="10%" align="right"></td>
				<td width="7%" align="left">&nbsp;
				<input type="checkbox" value="" id="codeDate"	tabindex="105" disabled="disabled" style="display:none;"/>					
				</td>
			</jsp:attribute>
		</cps:renderByResourceAccess>
		<td colspan="6"></td>
	</tr>
	</table>
	</div>
		<c:choose>
			<c:when test="${selectedCaseVO.codeDate eq true}">
				<c:set	value="visibility: hidden; position: absolute;" var="styleStr4" />
			</c:when>
			<c:otherwise>
				<c:set value="visibility: hidden; position: absolute;"	var="styleStr4" />
			</c:otherwise>
		</c:choose>

	<div id="codeDateDiv" style="${styleStr4}">

	<table width="100%">
		<tr align="left">
			<td align="right" width="10%">
				<cps:renderByResourceAccess	resourceId="107" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<label class="labelFont helpable" id="MaxShelfLabel">Max Shelf Life Days<em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label class="labelFont helpable" id="MaxShelfLabel">Max Shelf Life Days<em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left" width="15%">&nbsp;&nbsp; 
				<cps:renderByResourceAccess	resourceId="107" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<input type="text"	value="" id="shelfDays"	maxlength="4" class="textFieldSmall mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="110"	style="dataType: numeric;" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input type="text"	value="" id="shelfDays"	maxlength="4" class="textFieldSmall mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="110"	style="dataType: numeric;" disabled="disabled"/>				
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="10%">
				<cps:renderByResourceAccess	resourceId="107" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<label class="labelFont helpable" id="InboundLabel">Inbound Specification Days<em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label class="labelFont helpable" id="InboundLabel">Inbound Specification Days<em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left" width="15%">&nbsp;&nbsp;
				<cps:renderByResourceAccess	resourceId="107" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<input type="text"	value="" id="inboundDays" maxlength="4" class="textFieldSmall" tabindex="115" style="dataType: numeric;" />			
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input type="text"	value="" id="inboundDays" maxlength="4" class="textFieldSmall" tabindex="115" style="dataType: numeric;" disabled="disabled"/>				
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="10%">
				<cps:renderByResourceAccess	resourceId="108" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<label class="labelFont helpable" id="ReactionLabel">Reaction	Days <em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label class="labelFont helpable" id="ReactionLabel">Reaction	Days <em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left" width="15%">&nbsp;&nbsp; 
				<cps:renderByResourceAccess	resourceId="108" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<input type="text"	value="" id="reactionDays" maxlength="4" class="textFieldSmall" tabindex="120" style="dataType: numeric;" />							
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input type="text" value="" id="reactionDays" maxlength="4" class="textFieldSmall" tabindex="120" style="dataType: numeric;" disabled="disabled"/>								
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="10%">
				<cps:renderByResourceAccess	resourceId="109" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<label class="labelFont helpable" id="GuranteeLabel">Guarantee to Store Days<em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label class="labelFont helpable" id="GuranteeLabel">Guarantee to Store Days<em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left" width="15%">&nbsp;&nbsp;
				<cps:renderByResourceAccess	resourceId="109" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						 <input type="text" value="" id="guaranteestoreDays" maxlength="4" class="textFieldSmall" tabindex="125" style="dataType: numeric;" />				
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						 <input type="text"	value="" id="guaranteestoreDays" maxlength="4" class="textFieldSmall" tabindex="125" style="dataType: numeric;" disabled="disabled"/>						
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
		</tr>
	</table>
	</div>
	<c:choose>
		<c:when	test='${selectedCaseVO.channelVal eq "DSD"}'>
			<c:set value="visibility: hidden; position: absolute;"	var="styleStr5" />
		</c:when>
		<c:otherwise>
			<c:set value="visibility: hidden; position: absolute;"	var="styleStr5" />
		</c:otherwise>
	</c:choose>
	

	<div id="oneTuchTypeDiv" style="${styleStr5}">
	<table width="100%" style="margin-left: -12px;">
		<tr>
			<cps:renderByResourceAccess	resourceId="110" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<td align="right" width="10%"><label class="labelFont helpable" id="OneTouchLabel">1-Touch</label></td>
					<td width="30%" align="left" colspan="2">&nbsp;&nbsp;
						<select id="oneTouchType" tabindex="130" class="selectBoxStyle">
			        		<c:forEach var="opt" items="${selectedCaseVO.touchTypeList}">
				    			<c:if test="${opt.id eq selectedCaseVO.oneTouch}">
									<option value="${opt.id}" selected="selected">${opt.name}</option>
				    			</c:if>
				    			<c:if test="${opt.id ne selectedCaseVO.oneTouch}">
									<option value="${opt.id}">${opt.name}</option>
				    			</c:if>
				    		</c:forEach>
		            	</select>
					</td>				
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<td align="right" width="10%"><label class="labelFont helpable" id="OneTouchLabel">1-Touch</label></td>
					<td width="30%" align="left" colspan="2">&nbsp;&nbsp; 
						<select id="oneTouchType" tabindex="130" class="selectBoxStyle" disabled="disabled">
			        		<c:forEach var="opt" items="${selectedCaseVO.touchTypeList}">
				    			<c:if test="${opt.id eq selectedCaseVO.oneTouch}">
									<option value="${opt.id}" selected="selected" >${opt.name}</option>
				    			</c:if>
				    			<c:if test="${opt.id ne selectedCaseVO.oneTouch}">
									<option value="${opt.id}">${opt.name}</option>
				    			</c:if>
				    		</c:forEach>
		            	</select>
					</td>
				</jsp:attribute>
				<jsp:attribute name="NONE">
					<td width="30%" align="left" colspan="2" style="visibility: hidden;">&nbsp;&nbsp; 
						<select id="oneTouchType" tabindex="130" class="selectBoxStyle" disabled="disabled">
			        		<c:forEach var="opt" items="${selectedCaseVO.touchTypeList}">
				    			<c:if test="${opt.id eq selectedCaseVO.oneTouch}">
									<option value="${opt.id}" selected="selected">${opt.name}</option>
				    			</c:if>
					    		<c:if test="${opt.id ne selectedCaseVO.oneTouch}">
									<option value="${opt.id}">${opt.name}</option>
					    		</c:if>
				    		</c:forEach>
		            	</select>
					</td>
				</jsp:attribute>
			</cps:renderByResourceAccess>
			<cps:renderByResourceAccess	resourceId="242" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<td align="right" width="10%"><label class="labelFont helpable" id="ItemCategoryLabel">Item Category<em><font color="red"><b>*</b></font></em></label></td>
					<td width="30%" align="left" colspan="2">&nbsp;&nbsp;
						<select id="itmCategory" tabindex="130" class="selectBoxStyle">
			        		<c:forEach var="opt" items="${selectedCaseVO.itemCategoryList}">
				    			<c:if test="${opt.id eq selectedCaseVO.itemCategory}">
									<option value="${opt.id}" selected="selected">${opt.name}</option>
				    			</c:if>
				    			<c:if test="${opt.id ne selectedCaseVO.itemCategory}">
									<option value="${opt.id}">${opt.name}</option>
				    			</c:if>
				    		</c:forEach>
		            	</select>	
					</td>			
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<td align="right" width="10%"><label class="labelFont helpable" id="ItemCategoryLabel">Item Category<em><font color="red"><b>*</b></font></em></label></td>
					<td width="30%" align="left" colspan="2">&nbsp;&nbsp;
						<select id="itmCategory" tabindex="130" class="selectBoxStyle" disabled="disabled">
			        		<c:forEach var="opt" items="${selectedCaseVO.itemCategoryList}">
				    			<c:if test="${opt.id eq selectedCaseVO.itemCategory}">
									<option value="${opt.id}" selected="selected">${opt.name}</option>
				    			</c:if>
				    			<c:if test="${opt.id ne selectedCaseVO.itemCategory}">
									<option value="${opt.id}">${opt.name}</option>
				    			</c:if>
				    		</c:forEach>
		            	</select>
					</td>
				</jsp:attribute>
				<jsp:attribute name="NONE">
					<td width="30%" align="left" colspan="2" style="visibility: hidden;">&nbsp;&nbsp;
						<select id="itmCategory" tabindex="130" class="selectBoxStyle" disabled="disabled">
			        		<c:forEach var="opt" items="${selectedCaseVO.itemCategoryList}">
				    			<c:if test="${opt.id eq selectedCaseVO.itemCategory}">
									<option value="${opt.id}" selected="selected">${opt.name}</option>
				    			</c:if>
				    			<c:if test="${opt.id ne selectedCaseVO.itemCategory}">
									<option value="${opt.id}">${opt.name}</option>
				    			</c:if>
				    		</c:forEach>
		            	</select>
					</td>
				</jsp:attribute>
			</cps:renderByResourceAccess>
			<td align="right"></td>
		</tr>
	</table>
	</div>
	&nbsp;&nbsp;
	&nbsp;&nbsp;
	</td>
	</tr>
	<!-- Display Ready Unit  -->	
	<c:choose>
		<c:when test="${selectedCaseVO.dsplyDryPalSw eq true}">
			<c:set	value="visibility: visible; position: relative;"	var="styleStr6" />
		</c:when>
		<c:otherwise>
			<c:set	value="visibility: hidden; position: absolute;"	var="styleStr6" />
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${selectedCaseVO.dsplyDryPalSw eq true}">
			<c:set	value="visibility: visible; position: relative;"	var="styleStr6" />
		</c:when>
		<c:otherwise>
			<c:set	value="visibility: hidden; position: absolute;"	var="styleStr6" />
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${selectedCaseVO.dsplyDryPalSw eq true}">
			<c:set	value="visibility: visible; position: relative;"	var="styleStr7" />
		</c:when>
		<c:otherwise>
			<c:set	value="visibility: hidden; position: absolute;"	var="styleStr7" />
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${selectedCaseVO.dsplyDryPalSw eq true && (selectedCaseVO.srsAffTypCd eq 7 || selectedCaseVO.srsAffTypCd eq 9)}">
			<c:set	value="visibility: visible; position: relative;"	var="styleStr8" />
		</c:when>
		<c:otherwise>
			<c:set	value="visibility: hidden; position: absolute;"	var="styleStr8" />
		</c:otherwise>
	</c:choose>
	<tr>
	<td width="100%" colspan="2" align="left">	
	<div id="displayReadyUnitDiv">
		<table width="100%" align="left">
			<tr>
				<td width="15%" valign="top" align="right">  <label class="labelFont helpable" id="displayReadyUnitlabel">Display Ready Unit</label>
				<cps:renderByResourceAccess resourceId="81" honorViewMode="${selectedCaseVO.caseViewOverride}">	
					<jsp:attribute name="EDIT">
						<c:choose>
							<c:when  test="${selectedCaseVO.dsplyDryPalSw eq true}">
								<input type="checkbox" value="" checked='checked' id="dsplyDryPalSwId"	tabindex="105" onclick="displayReadyUnitClick();"/>
							</c:when>
							<c:otherwise>
								<input type="checkbox" value="" id="dsplyDryPalSwId" tabindex="105" disabled="disabled" onclick="displayReadyUnitClick();"/>
							</c:otherwise>
						</c:choose>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<c:choose>
							<c:when  test="${selectedCaseVO.dsplyDryPalSw eq true}">
								<input type="checkbox" value="" checked='checked' id="dsplyDryPalSwId"	tabindex="105" disabled="disabled" />
							</c:when>
							<c:otherwise>
								<input type="checkbox" value="" id="dsplyDryPalSwId"	tabindex="105" disabled="disabled" />
							</c:otherwise>
						</c:choose>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<c:choose>
							<c:when  test="${selectedCaseVO.dsplyDryPalSw eq true}">
								<input type="checkbox" value="" checked='checked' id="dsplyDryPalSwId"	tabindex="105" disabled="disabled" style="display:none;"/>
							</c:when>
							<c:otherwise>
								<input type="checkbox" value="" id="dsplyDryPalSwId" tabindex="105" disabled="disabled" style="display:none;"/>
							</c:otherwise>
						</c:choose>
					</jsp:attribute>
				</cps:renderByResourceAccess>				
				</td>	
				<td width="85%">
					<div id="displayReadyfieldset" style="${styleStr7}">
					<fieldset style="width: 90%">	
					<table width="100%">
						<tr>
							<td width="55%" valign="top"> 	
								<div id="typeDisplayReadyUnitId" style="${styleStr7}">	
									<table width="100%">
										<tr>
											<td width="50%" align="right"> <label class="labelFont helpable" id="typeDisplayReadyUnitlabel">Type Of Display Ready Unit ?<em><font color="red"><b>*</b></font></em></label> </td>
											<td width="50%" align="left"> 
												<select id="srsAffTypCdId" class="selectBoxStyle" onchange="onReadyUnitChange(this);">
									        		<c:forEach var="opt" items="${selectedCaseVO.readyUnits}">
										    			<c:if test="${opt.id eq selectedCaseVO.srsAffTypCd}">
															<option value="${opt.id}" selected="selected">${opt.name}</option>
										    			</c:if>
										    			<c:if test="${opt.id ne selectedCaseVO.srsAffTypCd}">
															<option value="${opt.id}">${opt.name}</option>
										    			</c:if>
										    		</c:forEach>
										    	</select>
											</td>							
										</tr>	
									</table>
								</div>		
								</td>
								<td width="45%" valign="top">	
									<div id="typeDisplayReadyUnitValue" style="${styleStr8}">
									<table width="100%">
										<tr>							
											<td width="50%" align="left"><label class="labelFont helpable" id="rowFactRetailsUnitId">Rows Facing in Retail Units <em><font color="red"><b>*</b></font></em></label></td>
											<td width="50%">							
											<cps:renderByResourceAccess	resourceId="81" honorViewMode="${selectedCaseVO.caseViewOverride}">
												<jsp:attribute name="EDIT">
													<input type="text" value="${selectedCaseVO.prodFcngNbr}" maxlength="4" id="prodFcngNbrId" style="dataType: numeric;"  class="textFieldSmall"/>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<input type="text" value="${selectedCaseVO.prodFcngNbr}" maxlength="4" id="prodFcngNbrId" style="dataType: numeric;" disabled="disabled"  class="textFieldSmall"/>							
												</jsp:attribute>
											</cps:renderByResourceAccess>
											</td>
										</tr>			
										<tr>							
											<td width="50%" align="left"><label class="labelFont helpable" id="rowDeepRetailsUnitId">Rows Deep in Retail Units <em><font color="red"><b>*</b></font></em></label></td>
											<td width="50%">							
											<cps:renderByResourceAccess	resourceId="81" honorViewMode="${selectedCaseVO.caseViewOverride}">
												<jsp:attribute name="EDIT">
													<input type="text" value="${selectedCaseVO.prodRowDeepNbr}" maxlength="4" id="prodRowDeepNbrId" style="dataType: numeric;"  class="textFieldSmall"/>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<input type="text" value="${selectedCaseVO.prodRowDeepNbr}" maxlength="4" id="prodRowDeepNbrId" style="dataType: numeric;" disabled="disabled"  class="textFieldSmall"/>							
												</jsp:attribute>
											</cps:renderByResourceAccess>
											</td>
										</tr>
										<tr>							
											<td width="50%" align="left"><label class="labelFont helpable" id="rowHigtRetailsUnitId">Rows High in Retail Units <em><font color="red"><b>*</b></font></em></label></td>
											<td width="50%">
											<cps:renderByResourceAccess	resourceId="81" honorViewMode="${selectedCaseVO.caseViewOverride}">
												<jsp:attribute name="EDIT">
													<input type="text" value="${selectedCaseVO.prodRowHiNbr}" maxlength="4" id="prodRowHiNbrId" style="dataType: numeric;"  class="textFieldSmall"/>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<input type="text" value="${selectedCaseVO.prodRowHiNbr}" maxlength="4" id="prodRowHiNbrId" style="dataType: numeric;" disabled="disabled"  class="textFieldSmall"/>							
												</jsp:attribute>
											</cps:renderByResourceAccess>	
											</td>
										</tr>
										<tr>							
											<td width="50%" align="left"><label class="labelFont helpable" id="orientationOfDrp">Orientation Of DRP <em><font color="red"><b>*</b></font></em></label></td>
											<td width="50%">
												<select id="nbrOfOrintNbrId" class="selectBoxStyleOrientationDRU">
										        		<c:forEach var="opt" items="${selectedCaseVO.orientations}">
											    			<c:if test="${opt.id eq selectedCaseVO.nbrOfOrintNbr}">
																<option value="${opt.id}" selected="selected">${opt.name}</option>
											    			</c:if>
											    			<c:if test="${opt.id ne selectedCaseVO.nbrOfOrintNbr}">
																<option value="${opt.id}">${opt.name}</option>
											    			</c:if>
											    		</c:forEach>
											    </select>														
	</td>
	</tr>
	</table>
									</div>				
								</td>
							</tr>
						</table>	
					</fieldset>
					</div>
				</td>			
			</tr>
		</table>
	</div>
	</td>
	</tr>
	<!-- END Display Ready Unit  -->
</table>
</c:when>
<c:otherwise>
<!-- SHOWING THE DATA. -->

	<table width="100%" border="0">
		<tr>
		<td align="right" width="19%"><label class="labelFont helpable" id="CaseDescriptionLabel">Case	Description  <em><font color="red"><b>*</b></font></em></label></td>
		<td align="left" width="18%"><cps:renderByResourceAccess
			resourceId="81" honorViewMode="${selectedCaseVO.caseViewOverride}">
			<jsp:attribute name="EDIT">
				<input type="text" name="caseDescription" id="caseDescriptionText" value="${selectedCaseVO.caseDescription}"  maxlength="30" size="35" class="textFieldNormal"
					   indexed="10" onblur="valdKeyPressSymbSpec(this);switchToUpperCase(this);return true;" style="TEXT-TRANSFORM: uppercase; dataType: alphanumeric;" disabled="true" />
			</jsp:attribute>
			<jsp:attribute name="VIEW">
			<input type="text" name="caseDescription" id="caseDescriptionText" value="${selectedCaseVO.caseDescription}"  maxlength="30" size="35" class="textFieldNormal"
				   indexed="10" disabled="true"/>
				</jsp:attribute>
			</cps:renderByResourceAccess>
		</td>
		<td width="11%" align="right"><label class="labelFont helpable" id="ChannelLabel">Channel <em><font color="red"><b>*</b></font></em></label></td>
		<td width="11%" align="left">&nbsp; <cps:renderByResourceAccess	resourceId="83">
			<jsp:attribute name="EDIT">
						<select id="actions3" tabindex="15"
					onchange="removeVendorMatchChannel();selectChannelAjax();displayImportDivAjax();" disabled="disabled">
							<c:forEach items="${CPSForm.channels}" var="channel">
								<option value="${channel.id}"
							<c:if test="${selectedCaseVO.channelVal eq channel.id}">selected</c:if>>${channel.name}</option>
							</c:forEach>
						</select>					
					</jsp:attribute>
			<jsp:attribute name="VIEW">
						<select id="actions3" tabindex="15" disabled="disabled">
							<c:forEach items="${CPSForm.channels}" var="channel">
								<option value="${channel.id}"
							<c:if test="${selectedCaseVO.channelVal eq channel.id}">selected</c:if>>${channel.name}</option>
							</c:forEach>
						</select>										
					</jsp:attribute>
		</cps:renderByResourceAccess></td>

		<c:choose>
		<c:when test='${selectedCaseVO.channelVal eq "DSD"}'>
		<c:set value="display: none;" var="styleStrCatchWt"></c:set>
		</c:when>
		<c:otherwise>
		<c:set value="display: block;" var="styleStrCatchWt"></c:set>
		</c:otherwise>
		</c:choose>
		
		<td align="right" width="19%"><div id="CatchWtSwLabelDiv" style="${styleStrCatchWt}"><label class="labelFont helpable" id="CatchWtSwLabel">Catch Weight Sw </label></div></td>
		<td align="left" width="22%"><div id="catchRadioDiv" style="${styleStrCatchWt}">&nbsp;&nbsp; 
			<c:set var="catchChk" value=""></c:set>
			<cps:renderByResourceAccess resourceId="88" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<c:choose>
						<c:when test="${selectedCaseVO.catchWeight eq true}">
							<input type="radio" name="upcradio" checked='checked' id="catchRadio" maxlength="1" tabindex="20" disabled="disabled" />
						</c:when>
						<c:otherwise>
							<input type="radio" name="upcradio" id="catchRadio" maxlength="1" tabindex="20" disabled="disabled" />
						</c:otherwise>
					</c:choose>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<c:choose>
						<c:when test="${selectedCaseVO.catchWeight eq true}">
							<input type="radio" name="upcradio" checked='checked' id="catchRadio" maxlength="1" tabindex="20" disabled="disabled"/>
						</c:when>
						<c:otherwise>
							<input type="radio" name="upcradio" id="catchRadio" maxlength="1" tabindex="20" disabled="disabled"/>
						</c:otherwise>
					</c:choose>
				</jsp:attribute>
			</cps:renderByResourceAccess></div>
		</td>
        </tr>
	</table>
	<c:choose>
		<c:when	test='${selectedCaseVO.channelVal eq "DSD"}'>
			<c:set	value="visibility: hidden; position: absolute;" 	var="styleStr1" />
		</c:when>
		<c:otherwise>
			<c:set value="visibility: visible; position: static;" var="styleStr1" />
		</c:otherwise>
	</c:choose>
		<table width="100%" border="0">
		<tr>
		<td width="37%">
		<div id="caseUpcDiv" style="${styleStr1}">
		<table width="100%" border="0">
		<tr>
			<td align="right" width="57%">
				<label class="labelFont helpable" id="CaseUPCLabel">Case UPC
				<em><font color="red"><b>*</b></font></em>
				</label>
			</td>
			<td align="left" width="49%">
				<cps:renderByResourceAccess resourceId="79" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<input type="text" value="${selectedCaseVO.caseUPC}" style="dataType: numeric;" id="caseUpcText" maxlength="13" onkeyup="autotab(this,'caseCheckDigit');return true;" class="textFieldMedium" tabindex="23" disabled="disabled"/>
						<label for="selectedChannel" class="labelFont">-</label> 
						<input type="text" class="textFieldMedium" tabindex="24" id="caseCheckDigit" maxlength="1" style="dataType: numeric; width: 10px;" size="1" onblur="verifyCheckDigit();" value="${selectedCaseVO.caseChkDigit}" disabled="disabled"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input type="text" value="${selectedCaseVO.caseUPC}" style="dataType: numeric;" id="caseUpcText" maxlength="13" onkeyup="autotab(this,'caseCheckDigit');return true;" class="textFieldMedium" tabindex="23" disabled="disabled" />
						<label for="selectedChannel" class="labelFont">-</label> 
						<input type="text" class="textFieldMedium" id="caseCheckDigit" maxlength="1" style="dataType: numeric; width: 10px;" size="1" value="${selectedCaseVO.caseChkDigit}" disabled="disabled"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			</tr>
		</table>
		</div>
		</td>
	
		<td width="22%"></td>

		<c:choose>
		<c:when test='${selectedCaseVO.channelVal eq "DSD"}'>
		<c:set value="display: none;" var="styleStrVariableWt"></c:set>
		</c:when>
		<c:otherwise>
		<c:set value="display: block;" var="styleStrVariableWt"></c:set>
		</c:otherwise>
		</c:choose>
		
		<td width="19%" align="right"><div id="VariableWtSwLabelDiv" style="${styleStrVariableWt}"><label class="labelFont helpable" id="VariableWtSwLabel">Variable	Weight Sw</label></div></td>
		<td width="22%" align="left"><div id="variableRadioDiv" style="${styleStrVariableWt}">&nbsp;&nbsp; 
			<cps:renderByResourceAccess resourceId="89" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<c:choose>
						<c:when test="${selectedCaseVO.variableWeight eq true}">
							<input type="radio" name="upcradio" checked='checked' id="variableRadio" maxlength="1" tabindex="21" class="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" disabled="disabled"/>
						</c:when>
						<c:otherwise>
							<input type="radio" name="upcradio" id="variableRadio" maxlength="1" tabindex="21" class="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" disabled="disabled"/>
						</c:otherwise>
					</c:choose>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<c:choose>
						<c:when test="${selectedCaseVO.variableWeight eq true}">
							<input type="radio" name="upcradio" checked='checked' id="variableRadio" maxlength="1" tabindex="21" disabled="disabled" class="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"/>
						</c:when>
						<c:otherwise>
							<input type="radio" name="upcradio" id="variableRadio" maxlength="1" tabindex="21" disabled="disabled" class="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"/>
						</c:otherwise>
					</c:choose>
				</jsp:attribute>
			</cps:renderByResourceAccess></div>
		</td>
	</tr>
	
	<tr>
			<td colspan="2"></td>

		<c:choose>
		<c:when test='${selectedCaseVO.channelVal eq "DSD"}'>
		<c:set value="display: none;" var="styleStrNone"></c:set>
		</c:when>
		<c:otherwise>
		<c:set value="display: block;" var="styleStrNone"></c:set>
		</c:otherwise>
		</c:choose>
			
		<td align="right" width="19%"><div id="NoneLabelDiv" style="${styleStrNone}"><label class="labelFont helpable" id="NoneLabel">None
		</label></div></td>
		<td align="left" width="22%"><div id="noneRadioDiv" style="${styleStrNone}">&nbsp;&nbsp; 
			<cps:renderByResourceAccess	resourceId="90" honorViewMode="${selectedCaseVO.caseViewOverride}">	
				<jsp:attribute name="EDIT">
					<c:choose>
						<c:when test="${selectedCaseVO.none eq true}">
							<input type="radio" name="upcradio" checked='checked' id="noneRadio" maxlength="1" tabindex="22" disabled="disabled"/>
						</c:when>
						<c:otherwise>
							<input type="radio" name="upcradio" id="noneRadio" maxlength="1" tabindex="22" disabled="disabled" />
						</c:otherwise>
					</c:choose>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<c:choose>
						<c:when test="${selectedCaseVO.none eq true}">
							<input type="radio" name="upcradio" checked='checked' id="noneRadio" maxlength="1" tabindex="22" disabled="disabled" />
						</c:when>
						<c:otherwise>
							<input type="radio" name="upcradio" id="noneRadio" maxlength="1" tabindex="22" disabled="disabled" />
						</c:otherwise>
					</c:choose>
				</jsp:attribute>
			</cps:renderByResourceAccess></div>
	</td>
	</tr>
</table>
<br />

<!-- MASTER PACK & SHIP PACK TABLE -->
<table width="100%">
	<tr>
	<td width="17%">
		<c:choose>
			<c:when	test='${selectedCaseVO.channelVal eq "DSD" or selectedCaseVO.channelVal eq "BOTH" or selectedCaseVO.channelVal eq "WHS"}'>
				<c:set 	value="display: inline;"	var="styleStr" />
			</c:when>
			<c:otherwise>
				<c:set	value="display:none;" var="styleStr" />
			</c:otherwise>
		</c:choose>
		<div id="masterPackDiv" style="${styleStr}">
		
		
		<table width="100%" border="0">
			<tr align="left">
				<td align="right" width="10%"><label class="labelFont helpable" id="MasterPackLabel">Master	pack <em><font color="red"><b>*</b></font></em></label></td>
				<td align="left" width="7%">
					<cps:renderByResourceAccess	resourceId="84" honorViewMode="${selectedCaseVO.caseViewOverride}">
						<jsp:attribute name="EDIT">
							<input type="text" value="${selectedCaseVO.masterPack}"
								id="masterPackText" maxlength="3" class="textFieldSmall" tabindex="35"
								style="dataType: numeric;"  onblur="calculateUnitCost();" disabled="disabled"/>					
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<input type="text" value="${selectedCaseVO.masterPack}"
								id="masterPackText" maxlength="3" class="textFieldSmall" tabindex="35"
								style="dataType: numeric;" disabled="disabled" />					
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
			</tr>
		</table>
		</div>
	</td>
	<td width="83%">
		<c:choose>
			<c:when	test='${selectedCaseVO.channelVal eq "DSD"}'>
				<c:set	value="visibility: hidden; position: absolute;"	var="styleStr2" />
			</c:when>
			<c:otherwise>
				<c:set	value="visibility: visible; position: static;"	var="styleStr2" />
			</c:otherwise>
		</c:choose>
		
		<div id="whs_details" style="${styleStr2}">
		<table width="100%" border="0" >
			<tr>
				<td align="right" width="7%"><label class="labelFont helpable" id="MasterLengthLabel">Length<em><font color="red"><b>*</b></font></em></label></td>
				<td align="left" width="10%"><cps:renderByResourceAccess
					resourceId="91" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
								<input type="text" value="${selectedCaseVO.masterLengthFormatted}"
							id="masterLength" maxlength="8" class="textFieldSmall"
							onkeydown="return onKeyDownRestrictDecimal(event, this, 'length');"
							onblur="checkLength('master');calculateMasterCube();check();return true;" tabindex="40"
							style="dataType: float;" disabled="disabled" />
							</jsp:attribute>
					<jsp:attribute name="VIEW">
								<input type="text" value="${selectedCaseVO.masterLengthFormatted}"
							id="masterLength" maxlength="8" class="textFieldSmall"
							tabindex="40" style="dataType: float;" disabled="disabled" />
							</jsp:attribute>
				</cps:renderByResourceAccess><label for="selectedChannel" class="labelFont">in</label></td>
				<td align="right" width="7%"><label class="labelFont helpable" id="MasterWidthLabel">Width<em><font color="red"><b>*</b></font></em></label></td>
				<td align="left" width="10%">
					<cps:renderByResourceAccess resourceId="92" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
								<input type="text" value="${selectedCaseVO.masterWidthFormatted}"
							id="masterWidth" maxlength="8" class="textFieldSmall"
							onkeydown="return onKeyDownRestrictDecimal(event, this, 'width');"
							onblur="checkWidth('master');calculateMasterCube();check();return true;" tabindex="45"
							style="dataType: float;" disabled="disabled" />
							</jsp:attribute>
					<jsp:attribute name="VIEW">
								<input type="text" value="${selectedCaseVO.masterWidthFormatted}"
							id="masterWidth" maxlength="8" class="textFieldSmall" tabindex="45"
							style="dataType: float;" disabled="disabled" />
							</jsp:attribute>
				</cps:renderByResourceAccess><label for="selectedChannel" class="labelFont">in</label></td>
				<td align="right" width="7%"><label class="labelFont helpable" id="MasterHeightLabel">Height<em><font color="red"><b>*</b></font></em>
				</label></td>
				<td align="left" width="10%"><cps:renderByResourceAccess
					resourceId="93" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
								<input type="text" value="${selectedCaseVO.masterHeightFormatted}"
							id="masterHeight" maxlength="8" class="textFieldSmall"
							tabindex="50" style="dataType: float;"
							onkeydown="return onKeyDownRestrictDecimal(event, this, 'height');"
							onblur="checkHeight('master');calculateMasterCube();check();return true;" disabled="disabled"/>
							</jsp:attribute>
					<jsp:attribute name="VIEW">
								<input type="text" value="${selectedCaseVO.masterHeightFormatted}"
							id="masterHeight" maxlength="8" class="textFieldSmall"
							tabindex="50" style="dataType: float;" disabled="disabled" />
							</jsp:attribute>
				</cps:renderByResourceAccess><label for="selectedChannel" class="labelFont">in</label></td>
				<td align="right" width="5%"><label class="labelFont helpable" id="MasterLabel">Cube
				</label></td>
				<td align="left" width="10%">&nbsp;&nbsp; <cps:renderByResourceAccess
					resourceId="94" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
								<label id="masterCubeLabel" class="labelFont">${selectedCaseVO.masterCubeFormatted}</label>
							</jsp:attribute>
					<jsp:attribute name="VIEW">
								<label id="masterCubeLabel" class="labelFont">${selectedCaseVO.masterCubeFormatted}</label>
							</jsp:attribute>
				</cps:renderByResourceAccess><label
						for="selectedChannel" class="labelFont"> cu.ft</label></td>
				<td align="right" width="7%"><label class="labelFont helpable" id="MasterWeightLabel">Weight<em><font color="red"><b>*</b></font></em></label></td>
				<td align="left" width="10%"><cps:renderByResourceAccess
					resourceId="95" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
								<input type="text" value="${selectedCaseVO.masterWeightFormatted}"
							id="masterWeight" maxlength="8" class="textFieldSmall"
							tabindex="55" style="dataType: float;" 
							onkeydown="return onKeyDownRestrictDecimal(event, this, 'weight');"
							onblur="chekDecimalValue(this, 2);check();return true;" disabled="disabled"/>
							</jsp:attribute>
					<jsp:attribute name="VIEW">
								<input type="text" value="${selectedCaseVO.masterWeightFormatted}"
							id="masterWeight" maxlength="8" class="textFieldSmall"
							tabindex="55" style="dataType: float;" disabled="disabled" />
							</jsp:attribute>
				</cps:renderByResourceAccess></td>
			</tr>
		</table>
		</div>
	</td>
	</tr> <!-- FIRST ROW ENDS -->
	
	<tr>
			
		<td width="17%"> 
			<div id="whs_details1" style="${styleStr2}">
			<c:choose>
				<c:when	test='${selectedCaseVO.channelVal eq "DSD"}'>
					<c:set	value="visibility: hidden; position: absolute;"		var="styleStr3" />
				</c:when>
				<c:otherwise>
					<c:set	value="visibility: visible; position: static;"		var="styleStr3" />
					
				</c:otherwise>
			</c:choose>
			<div id="shipPackDiv" style="${styleStr3}">
			<table width="100%" border="0">
				<tr align="left">
					<td align="right" width="10%"><label class="labelFont helpable" id="ShipPackLabel">Ship	Pack<em><font color="red"><b>*</b></font></em></label></td>
					<td align="left" width="7%">
						<cps:renderByResourceAccess	resourceId="85" honorViewMode="${selectedCaseVO.caseViewOverride}">
							<jsp:attribute name="EDIT">
								<input type="text" value="${selectedCaseVO.shipPack}"
									id="shipPackText" maxlength="3" class="textFieldSmall"
									tabindex="60" style="dataType: numeric; " onblur="check(); calculateUnitCost();" disabled="disabled" />
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<input type="text" value="${selectedCaseVO.shipPack}"
									id="shipPackText" maxlength="3" class="textFieldSmall"
									tabindex="60" style="dataType: numeric;" disabled="disabled" />
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</td>
				</tr>
			</table>
			</div>
			</div>
		</td>	
		<td width="83%">
			<div id="whs_details2" style="${styleStr2}">
			<table width="100%" border="0" >
			<tr>
				<td align="right" width="7%"><label class="labelFont helpable" id="ShipPackLengthLabel">Length<em><font color="red"><b>*</b></font></em></label></td>
				<td align="left" width="10%"><cps:renderByResourceAccess
					resourceId="96" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
								<input type="text" value="${selectedCaseVO.shipLengthFormatted}"
							id="shipLength" maxlength="8" class="textFieldSmall" tabindex="75" disabled="disabled"
							onkeydown="return onKeyDownRestrictDecimal(event, this, 'length');"
							onblur="checkLength('ship');calculateShipCube();validateShip('Length');return true;" style="dataType: float;" />
							</jsp:attribute>
					<jsp:attribute name="VIEW">
								<input type="text" value="${selectedCaseVO.shipLengthFormatted}"
							id="shipLength" maxlength="8" class="textFieldSmall" tabindex="75"
							style="dataType: float;" disabled="disabled" />
							</jsp:attribute>
				</cps:renderByResourceAccess><label for="selectedChannel" class="labelFont">in</label></td>
				<td align="right" width="7%"><label class="labelFont helpable" id="ShipPackWidthLabel">Width<em><font color="red"><b>*</b></font></em></label></td>
				<td align="left" width="10%"><cps:renderByResourceAccess
					resourceId="97" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
								<input type="text" id="shipWidth"
							value="${selectedCaseVO.shipWidthFormatted}" maxlength="8" disabled="disabled"
							class="textFieldSmall" tabindex="80" 
							onkeydown="return onKeyDownRestrictDecimal(event, this, 'width');"
							onblur="checkWidth('ship');calculateShipCube();validateShip('Width');return true;"
							style="dataType: float;" />
							</jsp:attribute>
					<jsp:attribute name="VIEW">
								<input type="text" id="shipWidth"
							value="${selectedCaseVO.shipWidthFormatted}" maxlength="8"
							class="textFieldSmall" tabindex="80" style="dataType: float;"
							disabled="disabled" />
							</jsp:attribute>
				</cps:renderByResourceAccess><label for="selectedChannel" class="labelFont">in</label></td>
				<td align="right" width="7%"><label class="labelFont helpable" id="ShipPackHeightLabel">Height<em><font color="red"><b>*</b></font></em></label></td>
				<td align="left" width="10%"><cps:renderByResourceAccess
					resourceId="98" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
								<input type="text" value="${selectedCaseVO.shipHeightFormatted}"
							id="shipHeight" maxlength="8" class="textFieldSmall" tabindex="85" disabled="disabled"
							onkeydown="return onKeyDownRestrictDecimal(event, this, 'height');"
							onblur="checkHeight('ship');calculateShipCube();validateShip('Height');return true;" style="dataType: float;" />
							</jsp:attribute>
					<jsp:attribute name="VIEW">
								<input type="text" value="${selectedCaseVO.shipHeightFormatted}"
							id="shipHeight" maxlength="8" class="textFieldSmall" tabindex="85"
							style="dataType: float;" disabled="disabled" />
							</jsp:attribute>
				</cps:renderByResourceAccess><label for="selectedChannel" class="labelFont">in</label></td>
				<td align="right" width="5%"><label class="labelFont helpable" id="ShipLabel">Cube
				</label></td>
				<td align="left" width="10%">&nbsp;&nbsp; <cps:renderByResourceAccess
					resourceId="99" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
								<label class="labelFont" id="shipCubeLabel">${selectedCaseVO.shipCubeFormatted}</label>
							</jsp:attribute>
					<jsp:attribute name="VIEW">
								<label class="labelFont" id="shipCubeLabel">${selectedCaseVO.shipCubeFormatted}</label>
							</jsp:attribute>
				</cps:renderByResourceAccess><label
						for="selectedChannel" class="labelFont"> cu.ft</label></td>
		
		
				<td align="right" width="7%"><label class="labelFont helpable" id="ShipWeightLabel">Weight<em><font color="red"><b>*</b></font></em></label></td>
				<td align="left" width="10%"><cps:renderByResourceAccess
					resourceId="100" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
								<input type="text" value="${selectedCaseVO.shipWeightFormatted}"
							id="shipWeight" maxlength="10" class="textFieldSmall" tabindex="90"
							style="dataType: float;" 
							onkeydown="return onKeyDownRestrictDecimal(event, this, 'weight');"
							onblur="chekDecimalValue(this, 2);return true;" disabled="disabled"/>
							</jsp:attribute>
					<jsp:attribute name="VIEW">
								<input type="text" value="${selectedCaseVO.shipWeightFormatted}"
							id="shipWeight" maxlength="10" class="textFieldSmall" tabindex="90"
							style="dataType: float;" disabled="disabled"/>
							</jsp:attribute>
				</cps:renderByResourceAccess>
				</td>
			</tr>
		</table>
		</div>
	</td>
	</tr> <!-- SECOND ROW ENDS -->
	<tr >
	<!--  UNIT FACTOR.... -->
		<td width="17%"> 
		<div id="whs_details3" style="${styleStr2}">	
		<table width="100%" border="0">
		<tr>	
		<td align="right" width="10%"><label class="labelFont helpable" id="UnitFactorLabel">Unit Factor</label></td>
		<td align="left" width="7%">
			<cps:renderByResourceAccess	resourceId="101" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<input type="text" value="${selectedCaseVO.unitFactorFormatted}"
						id="unitFactor" maxlength="7" class="textFieldSmall" tabindex="95"
						style="dataType: float;" onblur="roundValue(this,3);return true;" disabled="disabled"/>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<input type="text" value="${selectedCaseVO.unitFactorFormatted}"
						id="unitFactor" maxlength="7" class="textFieldSmall" tabindex="95"
						style="dataType: float;" disabled="disabled" />
				</jsp:attribute>
			</cps:renderByResourceAccess>
		</td>
		</tr>
		</table>
		</div>
		</td>
		<td width="83%">
		<div id="whs_details4" style="${styleStr2}">
		<table width="100%" border="0" >
		<tr>
			<td align="right" width="7%">
				<cps:renderByResourceAccess resourceId="243" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<label class="labelFont helpable" id="maxShipLabel">Max Ship</label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label class="labelFont helpable" id="maxShipLabel">Max Ship</label>
					</jsp:attribute>
					<jsp:attribute name="NONE">
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td width="10%" align="left" colspan="2">&nbsp;&nbsp;
				<cps:renderByResourceAccess resourceId="243" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<input type="text" value="${selectedCaseVO.maxShip}"
							id="maxShipText" maxlength="3" class="textFieldSmall" tabindex="100"
							style="dataType: numeric;" disabled="disabled"/>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
						<input type="text" value="${selectedCaseVO.maxShip}"
							id="maxShipText" maxlength="3" class="textFieldSmall" tabindex="100"
							style="dataType: numeric;" disabled="disabled"/>
				</jsp:attribute>
				<jsp:attribute name="NONE">
						<input type="text" value="${selectedCaseVO.maxShip}"
							id="maxShipText" maxlength="3" class="textFieldSmall" tabindex="100"
							style="dataType: numeric; display:none;"/>
				</jsp:attribute>
			</cps:renderByResourceAccess>
			</td>	
			
			<td align="right" width="15%">
				<cps:renderByResourceAccess resourceId="245" honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<label class="labelFont helpable" id="PurchaseStatusLabel">Purchase Status</label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label class="labelFont helpable" id="PurchaseStatusLabel">Purchase Status</label>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left" width="15%">&nbsp;&nbsp;
			<cps:renderByResourceAccess resourceId="245" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<select
					id="purchaseStatus" tabindex="101" class="selectBoxStyle"
					style="dataType: alpha;" disabled="disabled" >
					<c:forEach var="opt"
						items="${selectedCaseVO.purchaseStatusList}">
						<c:if test="${opt.id eq selectedCaseVO.purchaseStatus}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedCaseVO.purchaseStatus}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
					</select>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<select
					id="purchaseStatus" tabindex="101" class="selectBoxStyle"
					style="dataType: alpha;" disabled="disabled">
					<c:forEach var="opt"
						items="${selectedCaseVO.purchaseStatusList}">
						<c:if test="${opt.id eq selectedCaseVO.purchaseStatus}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedCaseVO.purchaseStatus}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
					</select>
				</jsp:attribute>
				<jsp:attribute name="NONE">
					<select
					id="purchaseStatus" tabindex="101" class="selectBoxStyle"
					style="dataType: alpha; visibility: hidden;" disabled="disabled">
					<c:forEach var="opt"
						items="${selectedCaseVO.purchaseStatusList}">
						<c:if test="${opt.id eq selectedCaseVO.purchaseStatus}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedCaseVO.purchaseStatus}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
					</select>
				</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td width="40%"/>
		</tr>
		</table>
		</div>
	</td>
	</tr> <!--  THIRD ROW ENDS -->
	<tr>
		<td width="100%" colspan="2"> 
		<div id="whs_details5" style="${styleStr2}">
			<table width="100%">
			<tr>
			<td width="9%" align="right">
				<cps:renderByResourceAccess	resourceId="105"  honorViewMode="${selectedCaseVO.caseViewOverride}">
					<jsp:attribute name="EDIT">
						<label class="labelFont helpable" id="CodeDateLabel">Code Date</label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label class="labelFont helpable" id="CodeDateLabel">Code Date</label>
					</jsp:attribute>
					<jsp:attribute name="NONE">
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left">&nbsp;
				<cps:renderByResourceAccess resourceId="105" honorViewMode="${selectedCaseVO.caseViewOverride}">	
					<jsp:attribute name="EDIT">
						<c:choose>
							<c:when  test="${selectedCaseVO.codeDate eq true}">
								<input type="checkbox" value="" checked='checked' id="codeDate"	tabindex="105" disabled="disabled" />
							</c:when>
							<c:otherwise>
								<input type="checkbox" value="" id="codeDate"	tabindex="105" disabled="disabled"/>
							</c:otherwise>
						</c:choose>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<c:choose>
							<c:when  test="${selectedCaseVO.codeDate eq true}">
								<input type="checkbox" value="" checked='checked' id="codeDate"	tabindex="105" disabled="disabled" />
							</c:when>
							<c:otherwise>
								<input type="checkbox" value="" id="codeDate"	tabindex="105" disabled="disabled" />
							</c:otherwise>
						</c:choose>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<c:choose>
							<c:when  test="${selectedCaseVO.codeDate eq true}">
								<input type="checkbox" value="" checked='checked' id="codeDate"	tabindex="105" disabled="disabled" style="display:none;"/>
							</c:when>
							<c:otherwise>
								<input type="checkbox" value="" id="codeDate"	tabindex="105" disabled="disabled" style="display:none;"/>
							</c:otherwise>
						</c:choose>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			
			
			</tr>
			</table>
			</div>
		</td>
	</tr> <!-- 4th ROW ENDS -->	
	<tr> 
		<td width="100%" colspan="2">
		<div id="whs_details6" style="${styleStr2}">
		<c:choose>
			<c:when test="${selectedCaseVO.codeDate eq true}">
				<c:set	value="visibility: visible; position: relative;"	var="styleStr4" />
			</c:when>
			<c:otherwise>
				<c:set	value="visibility: hidden; position: absolute;"	var="styleStr4" />
			</c:otherwise>
		</c:choose>
		<div id="codeDateDiv" style="${styleStr4}">
		<table width="100%" border="0" >
			<tr align="left">
				<td align="right" width="13%">
					<cps:renderByResourceAccess
						resourceId="107" honorViewMode="${selectedCaseVO.caseViewOverride}">
						<jsp:attribute name="EDIT">
							<label class="labelFont helpable" id="MaxShelfLabel">Max Shelf Life Days<em><font color="red"><b>*</b></font></em></label>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<label class="labelFont helpable" id="MaxShelfLabel">Max Shelf Life Days<em><font color="red"><b>*</b></font></em></label>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
				<td align="left" width="10%">&nbsp; 
				<cps:renderByResourceAccess
						resourceId="107" honorViewMode="${selectedCaseVO.caseViewOverride}">
						<jsp:attribute name="EDIT">
				<input type="text"
					value="${selectedCaseVO.maxShelfLifeDaysFormatted}" id="shelfDays"
					maxlength="4" class="textFieldSmall mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="110"
					style="dataType: numeric;" disabled="disabled"/></jsp:attribute>
					<jsp:attribute name="VIEW">
							<input type="text"
						value="${selectedCaseVO.maxShelfLifeDaysFormatted}" id="shelfDays"
						maxlength="4" class="textFieldSmall mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="110"
						style="dataType: numeric;" disabled="disabled"/>				
					</jsp:attribute>
					</cps:renderByResourceAccess></td>
				<td align="right" width="17%">
					<cps:renderByResourceAccess
							resourceId="107" honorViewMode="${selectedCaseVO.caseViewOverride}">
							<jsp:attribute name="EDIT">
								<label class="labelFont helpable" id="InboundLabel">Inbound Specification Days<em><font color="red"><b>*</b></font></em></label>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<label class="labelFont helpable" id="InboundLabel">Inbound Specification Days<em><font color="red"><b>*</b></font></em></label>
							</jsp:attribute>
					</cps:renderByResourceAccess>

				</td>
				<td align="left" width="10%">&nbsp;
				<cps:renderByResourceAccess
						resourceId="107" honorViewMode="${selectedCaseVO.caseViewOverride}">
						<jsp:attribute name="EDIT">
							<input type="text"
								value="${selectedCaseVO.inboundSpecificationDaysFormatted}" id="inboundDays"
								maxlength="4" class="textFieldSmall" tabindex="115"
								style="dataType: numeric;" disabled="disabled" />			
							</jsp:attribute>
						<jsp:attribute name="VIEW">
									<input type="text"
								value="${selectedCaseVO.inboundSpecificationDaysFormatted}" id="inboundDays"
								maxlength="4" class="textFieldSmall" tabindex="115"
								style="dataType: numeric;" disabled="disabled"/>				
							</jsp:attribute>
					</cps:renderByResourceAccess></td>
				<td align="right" width="10%">
					<cps:renderByResourceAccess
						resourceId="108" honorViewMode="${selectedCaseVO.caseViewOverride}">
						<jsp:attribute name="EDIT">
							<label class="labelFont helpable" id="ReactionLabel">Reaction Days<em><font color="red"><b>*</b></font></em></label>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<label class="labelFont helpable" id="ReactionLabel">Reaction Days<em><font color="red"><b>*</b></font></em></label>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
				<td align="left" width="10%">&nbsp; 
				<cps:renderByResourceAccess
						resourceId="108" honorViewMode="${selectedCaseVO.caseViewOverride}">
						<jsp:attribute name="EDIT">
									<input type="text"
							value="${selectedCaseVO.reactionDaysFormatted}" id="reactionDays"
							maxlength="4" class="textFieldSmall" tabindex="120"
							style="dataType: numeric;" disabled="disabled"/>							
							</jsp:attribute>
						<jsp:attribute name="VIEW">
											<input type="text"
								value="${selectedCaseVO.reactionDaysFormatted}" id="reactionDays"
								maxlength="4" class="textFieldSmall" tabindex="120"
								style="dataType: numeric;" disabled="disabled"/>								
							</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
				<td align="right" width="17%">
				<cps:renderByResourceAccess
						resourceId="109" honorViewMode="${selectedCaseVO.caseViewOverride}">
						<jsp:attribute name="EDIT">
							<label class="labelFont helpable" id="GuranteeLabel">Guarantee to Store Days<em><font color="red"><b>*</b></font></em></label>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<label class="labelFont helpable" id="GuranteeLabel">Guarantee to Store Days<em><font color="red"><b>*</b></font></em></label>
						</jsp:attribute>
				</cps:renderByResourceAccess>
				</td>
				<td align="left" width="10%">&nbsp;
				<cps:renderByResourceAccess
						resourceId="109" honorViewMode="${selectedCaseVO.caseViewOverride}">
						<jsp:attribute name="EDIT">
								 <input type="text"
								value="${selectedCaseVO.guaranteetoStoreDaysFormatted}"
								id="guaranteestoreDays" maxlength="4" class="textFieldSmall"
								tabindex="125" style="dataType: numeric;" disabled="disabled"/>				
							</jsp:attribute>
						<jsp:attribute name="VIEW">
								 <input type="text"
								value="${selectedCaseVO.guaranteetoStoreDaysFormatted}"
								id="guaranteestoreDays" maxlength="4" class="textFieldSmall"
								tabindex="125" style="dataType: numeric;" disabled="disabled"/>						
							</jsp:attribute>
					</cps:renderByResourceAccess>
				
				
				</td>
			</tr>
		</table>
		</div>
		</div>
		</td>
		</tr> <!--  5th ROW ENDS -->
		<tr>
			<td width="100%" colspan="2" align="left">
			<div id="whs_details7" style="${styleStr2}">
			<c:choose>
				<c:when	test='${selectedCaseVO.channelVal eq "DSD"}'>
					<c:set	value="visibility: hidden; position: absolute;"	var="styleStr5" />
				</c:when>
				<c:otherwise>
					<c:set	value="visibility: visible; position: static;"		var="styleStr5" />
				</c:otherwise>
			</c:choose>

			<div id="oneTuchTypeDiv" style="${styleStr5}">
			<table width="100%" border="0" align="left">
			<tr>
				
				<cps:renderByResourceAccess	resourceId="110" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
				<td align="right" width="10%"><label class="labelFont helpable" id="OneTouchLabel">1-Touch</label></td>
				<td width="30%" align="left" colspan="2">&nbsp;&nbsp; 
					<select id="oneTouchType" tabindex="130" class="selectBoxStyle" disabled="disabled">
			        <c:forEach var="opt" items="${selectedCaseVO.touchTypeList}">
				    <c:if test="${opt.id eq selectedCaseVO.oneTouch}">
					<option value="${opt.id}" selected="selected">${opt.name}</option>
				    </c:if>
				    <c:if test="${opt.id ne selectedCaseVO.oneTouch}">
					<option value="${opt.id}">${opt.name}</option>
				    </c:if>
				    </c:forEach>
		            </select>
				</td>				
				</jsp:attribute>
				<jsp:attribute name="VIEW">
				<td align="right" width="10%"><label class="labelFont helpable" id="OneTouchLabel">1-Touch</label></td>
				<td width="30%" align="left" colspan="2">&nbsp;&nbsp; 
					<select id="oneTouchType" tabindex="130" class="selectBoxStyle" disabled="disabled">
			        <c:forEach var="opt" items="${selectedCaseVO.touchTypeList}">
				    <c:if test="${opt.id eq selectedCaseVO.oneTouch}">
					<option value="${opt.id}" selected="selected">${opt.name}</option>
				    </c:if>
				    <c:if test="${opt.id ne selectedCaseVO.oneTouch}">
					<option value="${opt.id}">${opt.name}</option>
				    </c:if>
				    </c:forEach>
		            </select>
				</td>
				</jsp:attribute>
				<jsp:attribute name="NONE">
				<td width="30%" align="left" colspan="2" style="visibility: hidden;">&nbsp;&nbsp; 
					<select id="oneTouchType" tabindex="130" class="selectBoxStyle" disabled="disabled">
			        <c:forEach var="opt" items="${selectedCaseVO.touchTypeList}">
				    <c:if test="${opt.id eq selectedCaseVO.oneTouch}">
					<option value="${opt.id}" selected="selected">${opt.name}</option>
				    </c:if>
				    <c:if test="${opt.id ne selectedCaseVO.oneTouch}">
					<option value="${opt.id}">${opt.name}</option>
				    </c:if>
				    </c:forEach>
		            </select>
				</td>
				</jsp:attribute>
			</cps:renderByResourceAccess>
			<cps:renderByResourceAccess	resourceId="242" honorViewMode="${selectedCaseVO.caseViewOverride}">
				<jsp:attribute name="EDIT">
					<td align="right" width="10%"><label class="labelFont helpable" id="ItemCategoryLabel">Item Category<em><font color="red"><b>*</b></font></em></label></td>
					<td width="30%" align="left" colspan="2">&nbsp;&nbsp;
					<select id="itmCategory" tabindex="130" class="selectBoxStyle" disabled="disabled">
			        <c:forEach var="opt" items="${selectedCaseVO.itemCategoryList}">
				    <c:if test="${opt.id eq selectedCaseVO.itemCategory}">
					<option value="${opt.id}" selected="selected">${opt.name}</option>
				    </c:if>
				    <c:if test="${opt.id ne selectedCaseVO.itemCategory}">
					<option value="${opt.id}">${opt.name}</option>
				    </c:if>
				    </c:forEach>
		            </select>	
					</td>			
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<td align="right" width="10%"><label class="labelFont helpable" id="ItemCategoryLabel">Item Category<em><font color="red"><b>*</b></font></em></label></td>
					<td width="30%" align="left" colspan="2">&nbsp;&nbsp;
					<select id="itmCategory" tabindex="130" class="selectBoxStyle" disabled="disabled">
			        <c:forEach var="opt" items="${selectedCaseVO.itemCategoryList}">
				    <c:if test="${opt.id eq selectedCaseVO.itemCategory}">
					<option value="${opt.id}" selected="selected">${opt.name}</option>
				    </c:if>
				    <c:if test="${opt.id ne selectedCaseVO.itemCategory}">
					<option value="${opt.id}">${opt.name}</option>
				    </c:if>
				    </c:forEach>
		            </select>
					</td>
				</jsp:attribute>
				<jsp:attribute name="NONE">
					<td width="30%" align="left" colspan="2" style="visibility: hidden;">&nbsp;&nbsp;
					<select id="itmCategory" tabindex="130" class="selectBoxStyle" disabled="disabled">
			        <c:forEach var="opt" items="${selectedCaseVO.itemCategoryList}">
				    <c:if test="${opt.id eq selectedCaseVO.itemCategory}">
					<option value="${opt.id}" selected="selected">${opt.name}</option>
				    </c:if>
				    <c:if test="${opt.id ne selectedCaseVO.itemCategory}">
					<option value="${opt.id}">${opt.name}</option>
				    </c:if>
				    </c:forEach>
		            </select>
					</td>
				</jsp:attribute>
			</cps:renderByResourceAccess>
			
			
			</tr> 
		</table>
		</div>
		</div>
		&nbsp;&nbsp;
		&nbsp;&nbsp;
		</td>	
		</tr>
		<!-- Display Ready Unit  -->	
	<c:choose>
		<c:when test="${selectedCaseVO.dsplyDryPalSw eq true}">
			<c:set	value="visibility: visible; position: relative;"	var="styleStr6" />
		</c:when>
		<c:otherwise>
			<c:set	value="visibility: hidden; position: absolute;"	var="styleStr6" />
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${selectedCaseVO.dsplyDryPalSw eq true}">
			<c:set	value="visibility: visible; position: relative;"	var="styleStr6" />
		</c:when>
		<c:otherwise>
			<c:set	value="visibility: hidden; position: absolute;"	var="styleStr6" />
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${selectedCaseVO.dsplyDryPalSw eq true}">
			<c:set	value="visibility: visible; position: relative;"	var="styleStr7" />
		</c:when>
		<c:otherwise>
			<c:set	value="visibility: hidden; position: absolute;"	var="styleStr7" />
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${selectedCaseVO.dsplyDryPalSw eq true && (selectedCaseVO.srsAffTypCd eq 7 || selectedCaseVO.srsAffTypCd eq 9)}">
			<c:set	value="visibility: visible; position: relative;"	var="styleStr8" />
		</c:when>
		<c:otherwise>
			<c:set	value="visibility: hidden; position: absolute;"	var="styleStr8" />
		</c:otherwise>
	</c:choose>
	<tr>
	<td width="100%" colspan="2" align="left">	
	<div id="displayReadyUnitDiv">
		<table width="100%" align="left">
			<tr>
				<td width="15%" valign="top" align="right">  <label class="labelFont helpable" id="displayReadyUnitlabel">Display Ready Unit</label>
				<cps:renderByResourceAccess resourceId="81" honorViewMode="${selectedCaseVO.caseViewOverride}">	
					<jsp:attribute name="EDIT">
						<c:choose>
							<c:when  test="${selectedCaseVO.dsplyDryPalSw eq true}">
								<input type="checkbox" value="" checked='checked' id="dsplyDryPalSwId"	tabindex="105" disabled="disabled" onclick="displayReadyUnitClick();"/>
							</c:when>
							<c:otherwise>
								<input type="checkbox" value="" id="dsplyDryPalSwId" tabindex="105" disabled="disabled" onclick="displayReadyUnitClick();"/>
							</c:otherwise>
						</c:choose>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<c:choose>
							<c:when  test="${selectedCaseVO.dsplyDryPalSw eq true}">
								<input type="checkbox" value="" checked='checked' id="dsplyDryPalSwId"	tabindex="105" disabled="disabled" />
							</c:when>
							<c:otherwise>
								<input type="checkbox" value="" id="dsplyDryPalSwId"	tabindex="105" disabled="disabled" />
							</c:otherwise>
						</c:choose>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<c:choose>
							<c:when  test="${selectedCaseVO.dsplyDryPalSw eq true}">
								<input type="checkbox" value="" checked='checked' id="dsplyDryPalSwId"	tabindex="105" disabled="disabled" style="display:none;"/>
							</c:when>
							<c:otherwise>
								<input type="checkbox" value="" id="dsplyDryPalSwId"	tabindex="105" disabled="disabled" style="display:none;"/>
							</c:otherwise>
						</c:choose>
					</jsp:attribute>
				</cps:renderByResourceAccess>				
				</td>	
				<td width="85%">
					<div id="displayReadyfieldset" style="${styleStr7}">
						<fieldset style="width: 90%">	
							<table width="100%">
								<tr>
									<td width="55%" valign="top"> 	
										<div id="typeDisplayReadyUnitId" style="${styleStr7}">	
											<table width="100%">
												<tr>
													<td width="50%" align="right"> <label class="labelFont helpable" id="typeDisplayReadyUnitlabel">Type Of Display Ready Unit ?<em><font color="red"><b>*</b></font></em></label> </td>
													<td width="50%" align="left"> 
														<select id="srsAffTypCdId" class="selectBoxStyle" disabled="disabled" onchange="onReadyUnitChange(this);">
											        		<c:forEach var="opt" items="${selectedCaseVO.readyUnits}">
												    			<c:if test="${opt.id eq selectedCaseVO.srsAffTypCd}">
																	<option value="${opt.id}" selected="selected">${opt.name}</option>
												    			</c:if>
												    			<c:if test="${opt.id ne selectedCaseVO.srsAffTypCd}">
																	<option value="${opt.id}">${opt.name}</option>
												    			</c:if>
												    		</c:forEach>
												    	</select>
													</td>							
												</tr>	
											</table>
										</div>		
									</td>
									<td width="45%" valign="top">	
											<div id="typeDisplayReadyUnitValue" style="${styleStr8}">
											<table width="100%">
												<tr>							
													<td width="50%" align="left"><label class="labelFont helpable" id="rowFactRetailsUnitId">Rows Facing in Retail Units <em><font color="red"><b>*</b></font></em></label></td>
													<td width="50%">							
													<cps:renderByResourceAccess	resourceId="81" honorViewMode="${selectedCaseVO.caseViewOverride}">
														<jsp:attribute name="EDIT">
															<input type="text" value="${selectedCaseVO.prodFcngNbr}" maxlength="4" id="prodFcngNbrId" style="dataType: numeric;" disabled="disabled"  class="textFieldSmall"/>
														</jsp:attribute>
														<jsp:attribute name="VIEW">
															<input type="text" value="${selectedCaseVO.prodFcngNbr}" maxlength="4" id="prodFcngNbrId" style="dataType: numeric;" disabled="disabled"  class="textFieldSmall"/>							
														</jsp:attribute>
													</cps:renderByResourceAccess>
													</td>
												</tr>			
												<tr>							
													<td width="50%" align="left"><label class="labelFont helpable" id="rowDeepRetailsUnitId">Rows Deep in Retail Units <em><font color="red"><b>*</b></font></em></label></td>
													<td width="50%">							
													<cps:renderByResourceAccess	resourceId="81" honorViewMode="${selectedCaseVO.caseViewOverride}">
														<jsp:attribute name="EDIT">
															<input type="text" value="${selectedCaseVO.prodRowDeepNbr}" maxlength="4" id="prodRowDeepNbrId" style="dataType: numeric;" disabled="disabled"  class="textFieldSmall"/>
														</jsp:attribute>
														<jsp:attribute name="VIEW">
															<input type="text" value="${selectedCaseVO.prodRowDeepNbr}" maxlength="4" id="prodRowDeepNbrId" style="dataType: numeric;" disabled="disabled"  class="textFieldSmall"/>							
														</jsp:attribute>
													</cps:renderByResourceAccess>
													</td>
												</tr>
												<tr>							
													<td width="50%" align="left"><label class="labelFont helpable" id="rowHigtRetailsUnitId">Rows High in Retail Units <em><font color="red"><b>*</b></font></em></label></td>
													<td width="50%">
													<cps:renderByResourceAccess	resourceId="81" honorViewMode="${selectedCaseVO.caseViewOverride}">
														<jsp:attribute name="EDIT">
															<input type="text" value="${selectedCaseVO.prodRowHiNbr}" maxlength="4" id="prodRowHiNbrId" style="dataType: numeric;" disabled="disabled"  class="textFieldSmall"/>
														</jsp:attribute>
														<jsp:attribute name="VIEW">
															<input type="text" value="${selectedCaseVO.prodRowHiNbr}" maxlength="4" id="prodRowHiNbrId" style="dataType: numeric;" disabled="disabled"  class="textFieldSmall"/>							
														</jsp:attribute>
													</cps:renderByResourceAccess>	
													</td>
												</tr>
												<tr>							
													<td width="50%" align="left"><label class="labelFont helpable" id="orientationOfDrp">Orientation Of DRP <em><font color="red"><b>*</b></font></em></label></td>
													<td width="50%">
														<select id="nbrOfOrintNbrId" class="selectBoxStyleOrientationDRU" disabled="disabled">
												        		<c:forEach var="opt" items="${selectedCaseVO.orientations}">
													    			<c:if test="${opt.id eq selectedCaseVO.nbrOfOrintNbr}">
																		<option value="${opt.id}" selected="selected">${opt.name}</option>
													    			</c:if>
													    			<c:if test="${opt.id ne selectedCaseVO.nbrOfOrintNbr}">
																		<option value="${opt.id}">${opt.name}</option>
													    			</c:if>
													    		</c:forEach>
													    </select>														
													</td>
												</tr>						
											</table>
										</div>				
									</td>
								</tr>
							</table>
						</fieldset>
					</div>
				</td>					
			</tr>
		</table>
	</div>
	</td>
	</tr>	
	<!-- END Display Ready Unit  -->
	</table>
		

</c:otherwise>
</c:choose> <!-- END OF SHOW NO DATA. -->
	
<!-- UPC STARTS HERE -->     

<div id="assoctdUPCDiv" style="position: relative; min-width: 0;">
	<a id="sec1tion"></a>

	<fieldset	style="width: 100%;"	id="f4">
	<legend onclick="toggleAssoctdUPC('f4');"	style="cursor: pointer;"> <img src="${expnd}" id="aUPCImg">Applicable UPC's</legend>
	<div id="associatedUPC">
		<table id="applicableUPCs" align="center" width="100%" border="0"	cellspacing="0" cellpadding="2" class="dataGrid">
		<tbody id="upcTable">
		<tr>
			<td class="dataGridHead" align="left" class="labelFont" width="20%">UPC</td>
			<td class="dataGridHead" align="left" class="labelFont" width="20%">Unit Size</td>
			<td class="dataGridHead" align="left" class="labelFont" width="20%">Unit of Measure</td>
			<td class="dataGridHead" class="labelFont" align="left" width="20%">Link</td>
			<td class="dataGridHead" class="labelFont" align="left" width="20%"> <em><font color="red"><b>*</b></font></em>Primary</td>
		</tr>
		<c:forEach var="opt" items="${selectedCaseVO.caseUPCVOs}" varStatus="count">
			<tr>
				<td align="left" width="20%" class="row${count.count % 2}">
				<c:choose>
				<c:when test="${opt.negative eq true}">
					<font class="labelFont">004_Item_Code</font>
				</c:when>
				<c:otherwise>
					<font class="labelFont">${opt.unitUpc}</font>
				</c:otherwise>
				</c:choose>
				</td>
				<td align="left" width="20%" class="row${count.count % 2}"><font class="labelFont"> ${opt.unitSize}</font></td>
				<td align="left" width="20%" class="row${count.count % 2}">
					<font class="labelFont">${opt.unitMeasureDesc}</font> 
					<input type="hidden" id="caseUPCId${count.count - 1}" value="${opt.unitUpc}" />
				</td>
				<!-- 393 -->
				<td align="left" width="20%" class="row${count.count % 2}">
					<c:set var="disabled" value=""></c:set>
					<c:if test="${CPSForm.userRole eq 'SCMAN'}">
						<c:set var="disabled" value='disabled="disabled"'></c:set>
					</c:if>	
					<cps:renderByResourceAccess resourceId="114" honorViewMode="${selectedCaseVO.caseViewOverride}">
						<jsp:attribute name="EDIT">							
							<c:if test="${opt.linked eq true}">
							    <!--Fix QC -1508 -->
							    <c:if test="${opt.editable}">
									<c:if test="${selectedCaseVO.itemId>0}">
										<input type="checkbox" id="upcCaseCheck${count.count - 1}"
										onclick="enableRadioBut(${count.count - 1},${selectedCaseVO.itemId})" checked="checked" ${disabled}/>
									</c:if>
									<c:if test="${selectedCaseVO.itemId==null || selectedCaseVO.itemId==0}">
										<input type="checkbox" id="upcCaseCheck${count.count - 1}"
										onclick="enableRadioBut(${count.count - 1},'')" checked="checked" disabled="disabled"/>
									</c:if>                                   
                                </c:if>
                                <!--Fix QC -1508 -->
                                <c:if test="${!opt.editable}">
									<c:if test="${selectedCaseVO.itemId>0}">
										<input type="checkbox" id="upcCaseCheck${count.count - 1}"
										onclick="enableRadioBut(${count.count - 1},${selectedCaseVO.itemId})" checked="checked" disabled="disabled"/>
									</c:if>
									<c:if test="${selectedCaseVO.itemId==null || selectedCaseVO.itemId==0}">
										<input type="checkbox" id="upcCaseCheck${count.count - 1}"
										onclick="enableRadioBut(${count.count - 1},'')" checked="checked" disabled="disabled"/>
									</c:if>
                                </c:if>
							</c:if> 
                            <c:if test="${opt.linked eq false}">	
                             	<!--Fix QC -1508 -->									
								<c:if test="${!opt.editable}">
									<c:if test="${selectedCaseVO.itemId>0}">
										<input type="checkbox" id="upcCaseCheck${count.count - 1}"
										onclick="enableRadioBut(${count.count - 1},${selectedCaseVO.itemId})" disabled="disabled"/>
									</c:if>
									<c:if test="${selectedCaseVO.itemId==null || selectedCaseVO.itemId==0}">
										<input type="checkbox" id="upcCaseCheck${count.count - 1}"
										onclick="enableRadioBut(${count.count - 1},'')" disabled="disabled"/>
									</c:if>
                                </c:if>
								<c:if test="${opt.editable}"> 
									<c:if test="${selectedCaseVO.itemId>0}">
										<input type="checkbox" id="upcCaseCheck${count.count - 1}"
										onclick="enableRadioBut(${count.count - 1},${selectedCaseVO.itemId})"  ${disabled}/>
									</c:if>
									<c:if test="${selectedCaseVO.itemId==null || selectedCaseVO.itemId==0}">
										<input type="checkbox" id="upcCaseCheck${count.count - 1}"
												onclick="enableRadioBut(${count.count - 1},'')" disabled="disabled"/>
									</c:if>                                   
                                </c:if>
							</c:if>
						</jsp:attribute>
					<jsp:attribute name="VIEW">
							<c:choose>
								<c:when test="${opt.editable eq true && CPSForm.upcViewOverRide eq false}">
									<c:if
										test="${opt.linked eq true}">
										<input type="checkbox" id="upcCaseCheck${count.count - 1}" onclick='enableSaveCaseBut(this);'  ${disabled} checked="checked"/>
									</c:if> <c:if test="${opt.linked eq false}">									
										<input type="checkbox" id="upcCaseCheck${count.count - 1}" onclick='enableSaveCaseBut(this);' ${disabled}/>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if
										test="${opt.linked eq true}">
										<input type="checkbox" id="upcCaseCheck${count.count - 1}"
											onclick="enableRadioBut(${count.count - 1},'')" checked="checked" disabled="disabled"/>
									</c:if> <c:if test="${opt.linked eq false}">
										<input type="checkbox" id="upcCaseCheck${count.count - 1}"
											onclick="enableRadioBut(${count.count - 1},'')" disabled="disabled"/>
									</c:if>
								</c:otherwise>
							</c:choose>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>				
				<td align="left" width="20%" class="row${count.count % 2}">
					<cps:renderByResourceAccess resourceId="115" honorViewMode="${selectedCaseVO.caseViewOverride}">
						<jsp:attribute name="EDIT">
							<c:if test="${opt.linked eq true}">
								<c:if test="${opt.primary eq true}">
									<input type="radio" name="applUpcLink" id="caseUPCRadio${count.count - 1}" checked="checked" disabled="disabled" />
								</c:if>
								<!--Fix QC -1508 -->
								<c:if test="${opt.primary eq false  && opt.editable && selectedCaseVO.itemId > 0}">
									<input type="radio" name="applUpcLink" id="caseUPCRadio${count.count - 1}" disabled="disabled">
								</c:if>
								 <!--Fix QC -1508 -->
								<c:if test="${opt.primary eq false  && opt.editable && (selectedCaseVO.itemId==null || selectedCaseVO.itemId==0)}">
									<input type="radio" name="applUpcLink" id="caseUPCRadio${count.count - 1}" disabled="disabled">
								</c:if>
								 <!--Fix QC -1508 -->
								<c:if test="${opt.primary eq false  && !opt.editable}">
									<input type="radio" name="applUpcLink" id="caseUPCRadio${count.count - 1}" disabled="disabled" >
								</c:if>
							</c:if> 
							<c:if test="${opt.linked eq false}">
								<input type="radio" name="applUpcLink"	id="caseUPCRadio${count.count - 1}" disabled="disabled" />
							</c:if>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<c:if test="${opt.linked eq true}">
								<c:if test="${opt.primary eq true}">
									<input type="radio" name="applUpcLink"	id="caseUPCRadio${count.count - 1}" checked="checked" disabled="disabled"/>
								</c:if>
								<c:if test="${opt.primary eq false}">
									<input type="radio" name="applUpcLink"	id="caseUPCRadio${count.count - 1}" disabled="disabled">
								</c:if>
							</c:if> 
							<c:if test="${opt.linked eq false}">
								<input type="radio" name="applUpcLink"	id="caseUPCRadio${count.count - 1}" disabled="disabled"/>
							</c:if>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
			</tr>
		</c:forEach>
		</tbody>
		</table>
	</div>
</fieldset>
<!-- SAVE CASE button and CANCEL button -->
	<table width="100%" border="0" cellspacing="0" cellpadding="2" id="caseButtonTable">
		<tr>
			<c:set value="" var="disabled" />
			<c:if test="${selectedCaseVO.itemId > 0 && CPSForm.productVO.workRequest.workStatusCode=='108'}">
				<c:set var="disabled" value='disabled="disabled"'></c:set>
			</c:if>
			<td width="95%" align="right">
				<cps:renderByResourceAccess	resourceId="189" honorViewMode="${CPSForm.caseViewOverRide}">
					<jsp:attribute name="EXEC">	
						<c:if test='${selectedCaseVO.channelVal != "-1" && selectedCaseVO.buttonEditable}'>
							<div id="buttonHolder_DoNotUse" style="position: relative; min-width: 0;">
								<input type="button" id="AVupc" value="Save Case" tabindex="135" ${disabled}/>	
							</div>
						</c:if>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td width="5%" align="right">
				<cps:renderByResourceAccess resourceId="186" honorViewMode="${CPSForm.caseViewOverRide}">
					<jsp:attribute name="EXEC">
						<input type="button" id="cancelBut" value="Cancel"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			
		</tr>
		
	</table>

	<a id="sec2tion"></a>
    </div> 
</fieldset>	
    <br/>
	<br/>
	<!-- Vendor starts -->
    <a id="sec2tion"></a>

    <fieldset style="width: 96%; margin-left: 10px;" id="f5">
    	<legend onclick="toggleVendor('f5');" style="cursor: pointer;"><img src="${expnd}" id="vendorImg">Existing Vendors</legend> 
	    <div id="existingVendors" style="min-width: 0;">

     <table width="100%" cellspacing="0" id="existingVendorsTable">

	<tbody id="vendorTable">
		<tr>
			<td class="dataGridHead" align="center" class="labelFont" width="25%">Vendor</td>
			
			<td class="dataGridHead" align="left" class="labelFont" width="10%">VPC</td>
			<td class="dataGridHead" align="center" class="labelFont" width="5%">Guaranteed
			Sale?</td>
			<td class="dataGridHead" class="labelFont" align="center" width="5%">Deal
			Offered?</td>
			<td class="dataGridHead" class="labelFont" align="left" width="5%">List
			Cost</td>
			
			<td class="dataGridHead" class="labelFont" align="left" width="15%">Cost
			Owner</td>

			<td class="dataGridHead" class="labelFont" align="left" width="15%">Top
			2 Top</td>
			<td class="dataGridHead" class="labelFont" align="left" width="15%">Country
			of Origin</td>
			<td class="dataGridHead" class="labelFont" align="center" width="5%">Channel</td>
			
			<td class="dataGridHead" align="left" width="1%"></td>
		</tr>
		<c:set var="cnt" value="-1"></c:set>
		<c:forEach var="vendor" items="${selectedCaseVO.vendorVOs}" varStatus="count">
			<tr class="row${count.index%2}" id="vendorRow${count.index}"
				onclick="makeRowClickedForTable('vendorTable','vendorRow${count.index}','${count.index}','#FFAA00');
				displayVendorDetails('${count.index}');getVendorChannelTypeBetween();"
				style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
				<td align="left" width="11%" class="row${count.index%2}"><font
					class="labelFont"><c:out value="${vendor.vendorLocation}"/></font></td>
				<td align="left" width="10%" class="row${count.index%2}"><font
					class="labelFont"><c:out value="${vendor.vpc}"/></font></td>
				<td align="left" width="7%" class="row${count.index%2}">
				<c:if test="${vendor.guarenteedSale eq true}">
					<input type="checkbox" disabled="disabled" id="guarSaleReal${count.index}"
						checked="checked">
				</c:if> <c:if test="${vendor.guarenteedSale eq false}">
					<input type="checkbox" disabled="disabled" id="guarSaleReal${count.index}">
				</c:if> <input type="hidden" id="vendorUniq${count.index}"
					value="${vendor.uniqueId}" /></td>
				<td align="left" width="5%" class="row${count.index%2}">
				<c:if test="${vendor.dealOffered eq true}">
					<input type="checkbox" disabled="disabled" id="dealOffrdReal${count.index}"
						checked="checked">
				</c:if> <c:if test="${vendor.dealOffered eq false}">
					<input type="checkbox" disabled="disabled" id="dealOffrdReal${count.index}">
				</c:if></td>

				<td align="left" width="5%" class="row${count.index%2}">
				<font class="labelFont"><c:out value="${vendor.listCostFormatted}"/></font></td>

				<%-- 		<td align="left" width="5%" class="row<%= count.intValue()%2 %>"><font
						class="labelFont"><bean:write name="vendor"
						property="unitCost" /></font></td>
					<td align="left" width="5%" class="row<%= count.intValue()%2 %>"><input
						type="checkbox" id="check1<%= count.intValue() %>"
						onclick="test(<%= count.intValue() %>);importFn();"></td> --%>


				<td align="left" width="7%" class="row${count.index%2}"><font
					class="labelFont"><c:out value="${vendor.costOwner}"/></font></td>
				<td align="left" width="7%" class="row${count.index%2}"><font
					class="labelFont"><c:out value="${vendor.top2Top}"/></font></td>
				<td align="left" width="7%" class="row${count.index%2}"><font
					class="labelFont"><c:out value="${vendor.countryOfOrigin}"/></font></td>
				<td align="left" width="7%" class="row${count.index%2}"><font
					class="labelFont"><c:out value="${vendor.channelByLocation}"/></font></td>
				<%-- 		<td align="left" width="7%" class="row<%= count.intValue()%2 %>"><font
						class="labelFont"><bean:write name="vendor"
						property="seasonalityYr" /></font></td> --%>

				<td align="left" width="1%" class="row${count.index%2}">
				
				</td>
			</tr>
			<c:set var="cnt" value="${count.index}"></c:set>
		<%--<% count++;}%>--%>
		</c:forEach>
		<c:if test="${cnt == -1}">
			<tr id="noVendorDiv">
				<td width="100%" align="center" colspan="13">
				<div style="position: relative; min-width: 0;">No Vendors to
				Show!! Please add vendors</div>
				</td>
			</tr>
		</c:if>
	</tbody>
</table>
</div>

<table width="95%">
	<tr>
		<td width="70%" align="right">
		
		<cps:renderByResourceAccess
				resourceId="189" honorViewMode="${CPSForm.caseViewOverRide}">
				<jsp:attribute name="EXEC">
		<input type="button"
			id="addCaseDetailsBut" value="Add Vendor" tabindex="140" /> 
		</jsp:attribute>
		</cps:renderByResourceAccess>
		
		</td>
		<!--1205 Edit Case Edit Vendor-->
		<!--Add Edit Selected Vendor button-->
		<td width="15%" align="right">
		<div id="editVendorDetailsButDiv" style="display: none;">
		<cps:renderByResourceAccess
				resourceId="190" honorViewMode="${CPSForm.caseViewOverRide}">
				<jsp:attribute name="EXEC">
		<input type="button"
			id="editVendorDetailsBut" value="Edit Selected Vendor" tabindex="141" /> 
		</jsp:attribute>
		</cps:renderByResourceAccess>
		</div>
		</td>
		
		<td width="15%" align="right">
		<div id="deleteVendorDetailsButDiv" style="display: none;">
		<cps:renderByResourceAccess
				 resourceId="190" honorViewMode="${CPSForm.caseViewOverRide}">
		<jsp:attribute name="EXEC">
		<input type="button"
			id="deleteVendorDetailsBut" value="Delete Selected Vendor" tabindex="145" /> 
		</jsp:attribute>

		</cps:renderByResourceAccess>
		</div></td>				
				
	
	</tr>
</table>

</fieldset>
<br />
<br />
<div id="selectedvendorDetailsDiv"	style="position: relative; min-width: 0;"></div>
<div id="vendorDetailsDiv" style="position: relative; min-width: 0;">
<fieldset style="width: 96%; margin-left: 5px; margin-right: 5px; border-collapse: collapse;" id="vendorDetailsFieldSet"><legend>Add New Vendor Details</legend>
<table width="95%" border="0">
	<tr>
		<td width="100%" align="center">
		<table width="100%" border="0">
			<!-- 958 changes -->
			<tr align="left">
				<c:choose>
				<c:when test='${selectedCaseVO.channelVal eq "WHS"}'>
				<c:set value="display: none; position: relative; min-width: 0;" var="styleStrDept"></c:set>
				</c:when>
				<c:otherwise>
				<c:set value="display: block; position: relative; min-width: 0;" var="styleStrDept"></c:set>
				</c:otherwise>
				</c:choose>
				<td align="right" width="12%">&nbsp;<div id="subDeptLabelDiv" style="${styleStrDept }">
					<cps:renderByResourceAccess
							resourceId="257" honorViewMode="${CPSForm.caseViewOverRide}">
							<jsp:attribute name="EDIT">
								<label class="labelFont helpable" id="SubDeptLabel">Sub-Dept </label>
								</jsp:attribute>
							<jsp:attribute name="VIEW">
								<label class="labelFont helpable" id="SubDeptLabel">Sub-Dept </label>
							</jsp:attribute>
					</cps:renderByResourceAccess>	
				</div>
				</td>
				<td align="left" width="12%">&nbsp;&nbsp; <DIV id="subDeptDiv" style="${styleStrDept }">
				<cps:renderByResourceAccess
							resourceId="257" honorViewMode="${CPSForm.caseViewOverRide}">
							<jsp:attribute name="EDIT">
								<input type="text"
								id="subDept" maxlength="3" tabindex="146" class="textFieldNormal"
									style="TEXT-TRANSFORM: uppercase; dataType: alphanumericOnly;" value="${CPSForm.defaultSubDept}" onblur="validateSubDept();"/>
								</jsp:attribute>
							<jsp:attribute name="VIEW">
								<input type="text"
									id="subDept" maxlength="3" tabindex="146" class="textFieldNormal"
								style="TEXT-TRANSFORM: uppercase; dataType: alphanumericOnly;" value="${CPSForm.defaultSubDept}"  disabled="disabled"/>
							</jsp:attribute>
					</cps:renderByResourceAccess>	
				
					</DIV>
					</td>
				<!-- 958 PSS changes -->
				<td align="right" width="12%">&nbsp;<div id="vendPSSLabelDiv" style="${styleStrDept }">
					<cps:renderByResourceAccess
						resourceId="259" honorViewMode="${selectedVendorVO.vendorViewOverride}" >
						<jsp:attribute name="EDIT">
							<label class="labelFont helpable" id="VendPSSLabel">PSS Dept </label>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<label class="labelFont helpable" id="VendPSSLabel">PSS Dept </label>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					</div>
				</td>
				<td align="left" width="12%">&nbsp;&nbsp; 
					<DIV id="vendPSSDiv" style="${styleStrDept }">
					<cps:renderByResourceAccess
						resourceId="259" honorViewMode="${selectedVendorVO.vendorViewOverride}" >
						<jsp:attribute name="EDIT">
						<select	id="vendPssDept" tabindex="147" class="selectBoxStyle2" disabled="disabled">
							<c:forEach var="opt" items="${CPSForm.pssList}">
								<c:choose>
									<c:when test="${CPSForm.vendorVO.pssDept eq null}">
										<c:if test="${opt.id eq CPSForm.productVO.pointOfSaleVO.pssDept}">
											<option value="${opt.id}" selected="selected">${opt.name}</option>
										</c:if>
										<c:if test="${opt.id ne CPSForm.productVO.pointOfSaleVO.pssDept}">
											<option value="${opt.id}">${opt.name}</option>
										</c:if>
									</c:when>
									<c:otherwise>
										<c:if test="${opt.id eq CPSForm.vendorVO.pssDept}">
											<option value="${opt.id}" selected="selected">${opt.name}</option>
										</c:if>
										<c:if test="${opt.id ne CPSForm.vendorVO.pssDept}">
											<option value="${opt.id}">${opt.name}</option>
										</c:if>
									</c:otherwise>							
								</c:choose>
							</c:forEach>
						</select>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
						<select	id="vendPssDept" tabindex="147" class="selectBoxStyle2" disabled="disabled">
							<c:forEach var="opt" items="${CPSForm.pssList}">
								<c:choose>
									<c:when test="${CPSForm.vendorVO.pssDept eq null}">
										<c:if test="${opt.id eq CPSForm.productVO.pointOfSaleVO.pssDept}">
											<option value="${opt.id}" selected="selected">${opt.name}</option>
										</c:if>
										<c:if test="${opt.id ne CPSForm.productVO.pointOfSaleVO.pssDept}">
											<option value="${opt.id}">${opt.name}</option>
										</c:if>
									</c:when>
									<c:otherwise>
										<c:if test="${opt.id eq CPSForm.vendorVO.pssDept}">
											<option value="${opt.id}" selected="selected">${opt.name}</option>
										</c:if>
										<c:if test="${opt.id ne CPSForm.vendorVO.pssDept}">
											<option value="${opt.id}">${opt.name}</option>
										</c:if>
									</c:otherwise>							
								</c:choose>
							</c:forEach>
						</select>
						</jsp:attribute>
						<jsp:attribute name="NONE">
						<select	id="vendPssDept" tabindex="147" class="selectBoxStyle2" disabled="disabled" style="display:none;">
							<c:forEach var="opt" items="${CPSForm.pssList}">
								<c:choose>
									<c:when test="${CPSForm.vendorVO.pssDept eq null}">
										<c:if test="${opt.id eq CPSForm.productVO.pointOfSaleVO.pssDept}">
											<option value="${opt.id}" selected="selected">${opt.name}</option>
										</c:if>
										<c:if test="${opt.id ne CPSForm.productVO.pointOfSaleVO.pssDept}">
											<option value="${opt.id}">${opt.name}</option>
										</c:if>
									</c:when>
									<c:otherwise>
										<c:if test="${opt.id eq CPSForm.vendorVO.pssDept}">
											<option value="${opt.id}" selected="selected">${opt.name}</option>
										</c:if>
										<c:if test="${opt.id ne CPSForm.vendorVO.pssDept}">
											<option value="${opt.id}">${opt.name}</option>
										</c:if>
									</c:otherwise>							
								</c:choose>
							</c:forEach>
						</select>
						</jsp:attribute>
						
					</cps:renderByResourceAccess>
					</DIV>
				</td>
			</tr>
			<!-- 958 changes ends-->

			<tr align="left">
				<td align="right" width="12%"><label class="labelFont helpable" id="VendorLabel">Vendor <em><font color="red"><b>*</b></font></em></label></td>
				<td align="left" width="12%" colspan="3">&nbsp;&nbsp; 
								<cps:autoCompleteVendor searchAction="vendorSearch" uniqueId="vendor"
								compWidth="80%" tabIdx="150"
								elmProperty="vendorVO.vendorLocationVal"
								elmName="vendorVO.vendorLocation" highlightMatch="true"
								maxResults="999" searchOnId="true" showId="true" zi="9000"
								maxCacheEntries="0" onSelectMethod2="checkBicepInLstBicep" onSelectMethod="getVendorChannelTypeBetween" 
								onSelectMethod1="resetDataCostlistAndListCostChangeVendor"
								/>							
				</td>
				<td align="right" width="12%"><label class="labelFont helpable" id="VPCLabel">VPC <em><font color="red"><b>*</b></font></em></label>
				</td>
				<td align="left" width="12%">&nbsp;&nbsp; <input type="text" id="vpc" maxlength="20" tabindex="155" class="textFieldNormal"	style="TEXT-TRANSFORM: uppercase; dataType: alphanumericSpecialOnly;" /></td>
				<td colspan="2">
					<table>
						<tr>
							<td align="right"><label class="labelFont helpable" id="GuranteedSaleLabel">Guaranteed	Sale?</label></td>
							<td>&nbsp;&nbsp;<input type="checkbox" id="gSales"	tabindex="160" size="1"></td>
						</tr>
						<tr>
							<td align="right"><label class="labelFont helpable" id="DealOfferedLabel">Deal	Offered?</label></td>
							<td>&nbsp;&nbsp;<input type="checkbox" id="dealOffered"	tabindex="165" size="1"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr align="left">
<!-- 				<td align="right" width="12%"><label class="labelFont helpable" id="ListCostLabel">List -->
<!-- 				Cost  <em><font color="red"><b>*</b></font></em></label></td> -->
<!-- 				<td align="left" width="12%">&nbsp;&nbsp; <input type="text" -->
<!-- 					id="listCost" maxlength="12" tabindex="170" class="textFieldMedium" -->
<!-- 					onkeydown="return onKeyDownListCost(event, this);" -->
<!-- 					style="dataType: float;" onblur="validateListCost(this);calculateUnitCost();return true;" /></td> -->
				<c:choose>
				<c:when test='${selectedCaseVO.channelVal eq "DSD"}'>
				<c:set value="display: none;" var="styleStrTie"></c:set>
				</c:when>
				<c:otherwise>
				<c:set value="display: block;" var="styleStrTie"></c:set>
				</c:otherwise>
				</c:choose>
				<td align="right" width="12%"><div id="venTie" style="${styleStrTie }"><label class="labelFont helpable" id="VendorTieLabel">Vendor
				Tie<em><font color="red"><b>*</b></font></em></label>
				</div>
				</td>
				<td align="left" width="12%">&nbsp;&nbsp; <DIV id="venTieText" style="${styleStrTie }"><input type="text"
					id="vendorTie" maxlength="6" tabindex="175" class="textFieldMedium"
					style="dataType: numeric;" onblur="validateNumber(this,'Vendor Tie'); return true;" />
					</DIV>
					</td>
				<td align="right" width="12%"><div id="venTier" style="${styleStrTie }"><label class="labelFont helpable" id="VendorTierLabel">Vendor
				Tier<em><font color="red"><b>*</b></font></em></label>
				</div>
				</td>
				<td align="left" width="12%">&nbsp;&nbsp;<DIV id="venTierText" style="${styleStrTie }"> <input type="text"
					id="vendorTier" maxlength="6" tabindex="180"
					class="textFieldMedium" value="" style="dataType: numeric;" onblur="validateNumber(this,'Vendor Tier'); return true;"/>
					</DIV>
					</td>
				<td align="right" width="12%"><label class="labelFont helpable" id="CountryOfOriginLabel">Country
				of Origin <em><font color="red"><b>*</b></font></em></label></td>
				<td align="left" width="12%">&nbsp;&nbsp; <select
					id="countryOfOrigin" tabindex="185" class="selectBoxStyle"
					style="dataType: alpha;">
					<c:forEach var="opt"
						items="${CPSForm.vendorVO.countryOfOriginList}">
						<c:if test="${opt.id eq vendorVO.countryOfOrigin}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne vendorVO.countryOfOrigin}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
				</select></td>
			</tr>
			<tr align="left">
				<td align="right" width="12%">
					<%-- Fix QC 2329 - validate for non-sellable also --%>
					<label class="labelFont helpable" id="CostOwnerLabel">Cost Owner <em><font color="red"><b>*</b></font></em></label>
				</td>
				<td align="left" width="12%">&nbsp;&nbsp;
					<select	id="costOwner" tabindex="190" onchange="cstOwnerChange()">
						<option value="">--Select--</option>
						<c:forEach var="costOwn" items="${CPSForm.costOwners}">
							<c:if test="${costOwn.id eq vendorVO.costOwnerVal}">
								<option value="${costOwn.id}" selected="selected">${costOwn.name}</option>
							</c:if>
							<c:if test="${costOwn.id ne vendorVO.costOwnerVal}">
								<option value="${costOwn.id}">${costOwn.name}</option>
							</c:if>
						</c:forEach>
					</select> 
				</td>
				<td align="right" width="12%">
					<%-- Fix QC 2329 - validate for non-sellable also --%>
					<label class="labelFont helpable" id="Top2TopLabel">Top	2 Top <em><font color="red"><b>*</b></font></em></label>
				</td>
				<td align="left" width="12%">&nbsp;&nbsp; 
					<select id="top2Top" tabindex="195" class="selectBoxStyle3">
					<option value="">--Select--</option>
						<c:forEach var="opt" items="${CPSForm.topToTops}">
							<c:if test="${opt.id eq vendorVO.top2TopVal}">
								<option value="${opt.id}" selected="selected">${opt.name}</option>
							</c:if>
							<c:if test="${opt.id ne vendorVO.top2TopVal}">
								<option value="${opt.id}">${opt.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</td>
				<td align="right" width="12%"><label class="labelFont helpable" id="SeasonalityYrLabel">Seasonality	Yr</label></td>
				<td align="left" width="12%">&nbsp;&nbsp; 
					<input type="text" id="seasonalityYear" maxlength="4" tabindex="200" class="textFieldMedium" value="${vendorVO.seasonalityYr}" onblur="dateCheck();"	onchange="seasonalityYearChange();" style="dataType: numeric;" /></td>
				<td align="right" width="12%"><label class="labelFont helpable" id="SeasonalityLabel">Seasonality</label></td>
				<td align="left" width="12%">&nbsp;&nbsp; 
					<select	id="seasonality" tabindex="205" class="selectBoxStyle3"	style="dataType: alpha;" onchange="seasonalityChange();">
						<c:forEach var="opt" items="${CPSForm.vendorVO.seasonalityList}">
							<c:if test="${opt.id eq CPSForm.vendorVO.seasonality}">
								<option value="${opt.id}" selected="selected">${opt.name}</option>
							</c:if>
							<c:if test="${opt.id ne CPSForm.vendorVO.seasonality}">
								<option value="${opt.id}">${opt.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="4">
						<fieldset style="width: 90%; border-collapse: collapse;" id="costDetailsFieldSet"><legend>Cost Details</legend>
							<table width="100%">
									<tr>
										<c:choose>
											<c:when test="${selectedCaseVO.channelVal == 'DSD'}">
												<c:set value="display: none;" var="styleStrCost"></c:set>
											</c:when>
											<c:otherwise>
												<c:set value="display: block;" var="styleStrCost"></c:set>
											</c:otherwise>
										</c:choose>
										<td align="right" width="24%">
											<label class="labelFont helpable" id="costLinkLabel" style="${styleStrCost }">Cost Link By&nbsp;&nbsp;</label>
										</td>
										<c:set value="" var="costChecked"></c:set>
										<c:if test="${CPSForm.vendorVO.costLinkRadio eq 'true'}">
											<c:set value='selected="selected"' var="costChecked"></c:set>
										</c:if>
										<c:set value="" var="itemChecked"></c:set>
										<c:if test="${CPSForm.vendorVO.itemCodeRadio eq 'true'}">
											<c:set value='selected="selected"' var="itemChecked"></c:set>
										</c:if>
										<td align="left" width="24%">
											<div id="costLink" style="${styleStrCost }">
												<select	id="costLinkBy" onchange="changeCostLinkBy(this)" class="selectBoxStyle3">
													<option value="">--Select--</option>
													<option value="cl" ${costChecked}>Cost Link #</option>
													<option value="ic" ${itemChecked}>Item Code</option>
												</select> 
											</div>
										</td>
										<td colspan="2" width="48%">
											<div id="ItemRadioLabelDiv" style="display: none"><label class="labelFont helpable" id="ItemRadioLabel">Item Code </label></div>
											<div id="costlistDiv" style="${styleStrCost}">
												<input type="text" id="costlist" maxlength="13" tabindex="210" class="textFieldNormal" value="" onblur="calculateListCost();" style="dataType:numeric;" disabled="disabled">
											</div>
										</td>
									</tr>
									<tr>
										<td align="right" width="24%">
											<label class="labelFont helpable" id="ListCostLabel">List Cost 
											<em><font color="red"><b>*</b></font></em></label>
										</td>
										<td align="left" width="24%">
											<input type="text"
											id="listCost" maxlength="12" tabindex="170" class="textFieldMedium"
											onkeydown="return onKeyDownListCost(event, this);"
											style="dataType: float;" onblur="validateListCost(this);calculateUnitCost();" />
										</td>
										<td align="right" width="12%" ><label class="labelFont helpable" id="UnitCost1Label">Unit Cost </label></td>
										<td align="left" width="12%">&nbsp;&nbsp;<label	id="unitCostLabel" class="labelFont"></label></td>
									</tr>
									<tr>
										<td align="right" width="24%">
											<label class="labelFont helpable" id="grossMarginLabel">% Margin &nbsp;&nbsp;
											</label>
										</td>
										<td align="left" width="24%">
											<label
											class="labelFont"
											id="grossMargin" tabindex="170">
											${selectedVendorVO.grossMargin}
											</label>
											<input type="hidden" id="retailFor"
											value="${CPSForm.productVO.retailVO.retailFor}"
											/>
											<input type="hidden" id="unitRetail"
											value="${CPSForm.productVO.retailVO.retail}"
											/>	
										</td>
										<td align="right" width="24%">
											<label class="labelFont helpable" id="grossProfitLabel">Penny Profit &nbsp;&nbsp;
											</label>
										</td>
										<td align="left" width="24%">
											<label class="labelFont"
											id="grossProfit">
											${selectedVendorVO.grossProfit}
											</label>
										</td>
									</tr>	
							</table>
						</fieldset>		
				</td>
				<td colspan="4">
							<table width="100%">
									<tr>
										<c:choose>
										<c:when test="${selectedCaseVO.channelVal == 'DSD'}">
											<c:set value="display: none;" var="styleStrCost"></c:set>
										</c:when>
										<c:otherwise>
											<c:set value="display: block;" var="styleStrCost"></c:set>
										</c:otherwise>
										</c:choose>
										<!-- Order Unit Changes -->
										<td width="12%" align="right">
											<div id="orderUnitLabelDiv" style="${styleStrTie}">
												<cps:renderByResourceAccess resourceId="258"
											honorViewMode="${CPSForm.caseViewOverRide}">
											<jsp:attribute name="EDIT">
														<label class="labelFont helpable" id="OrderUnitLabel">Order Unit&nbsp;</label>
													</jsp:attribute>
											<jsp:attribute name="VIEW">
														<label class="labelFont helpable" id="OrderUnitLabel">Order Unit&nbsp;</label>
													</jsp:attribute>
										</cps:renderByResourceAccess>
											</div>
										</td>
										<td width="12%" align="left"><div id="orderUnitDiv" style="${styleStrTie}">&nbsp;
											<cps:renderByResourceAccess resourceId="258" honorViewMode="${CPSForm.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<select onchange="onChangeOrderUnit(this)"
													id="orderUnit" tabindex="208" class="selectBoxStyle3"
													style="dataType: alpha;">
													<c:forEach var="opt"
														items="${CPSForm.vendorVO.orderUnitList}">
														<c:if test="${opt.id eq vendorVO.orderUnit}">
															<option value="${opt.id}" selected="selected">${opt.name}</option>
														</c:if>
														<c:if test="${opt.id ne vendorVO.orderUnit}">
															<c:set value="" var="selected" />
															<c:if test="${opt.id eq 'C'}">
																<c:set value="selected" var="selected" /> 
															</c:if>
															<option value="${opt.id}" selected=${selected}>${opt.name}</option> 
														</c:if>
													</c:forEach>
													</select>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<select
													id="orderUnit" tabindex="208" class="selectBoxStyle3"
													style="dataType: alpha;" disabled="disabled">
													<c:forEach var="opt"
														items="${CPSForm.vendorVO.orderUnitList}">
														<c:if test="${opt.id eq vendorVO.orderUnit}">
															<option value="${opt.id}" selected="selected">${opt.name}</option>
														</c:if>
														<c:if test="${opt.id ne vendorVO.orderUnit}">
															<option value="${opt.id}">${opt.name}</option>
														</c:if>
													</c:forEach>
													</select>
												</jsp:attribute>
												<jsp:attribute name="NONE">
													<select
													id="orderUnit" tabindex="208" class="selectBoxStyle3"
													style="dataType: alpha; visibility: hidden;" disabled="disabled">
													<c:forEach var="opt"
														items="${CPSForm.vendorVO.orderUnitList}">
														<c:if test="${opt.id eq vendorVO.orderUnit}">
															<option value="${opt.id}" selected="selected">${opt.name}</option>
														</c:if>
														<c:if test="${opt.id ne vendorVO.orderUnit}">
															<option value="${opt.id}">${opt.name}</option>
														</c:if>
													</c:forEach>
													</select>
												</jsp:attribute>
												</cps:renderByResourceAccess>
											</div></td>
											<!-- End of Order Unit changes -->		
									</tr>
									<tr>
										<td align="right" width="12%">
											<table>
												<tr>
													<td width="11%"><label class="labelFont helpable"
														id="ExpWeekMovLabel">Expected Weekly Movement</label></td>
													<td width="1%">
													<DIV class="labelFont" id="ewmMandatory">
														<c:choose>
															<c:when
																test="${CPSForm.productVO.classificationVO.productType eq 'GOODS'}">
																<em><font color="red"><b>*</b></font></em>
															</c:when>
														</c:choose>
													</DIV>
													</td>
												</tr>
											</table>
										</td>
										<td width="12%" align="left"> &nbsp;
											<input type="text" tabindex="212" class="textFieldMedium" id="expectedweeklymovement" maxlength="5" style="dataType: numeric;" onblur="validateNumber(this,'Expected Weekly Movement'); validateExpected();" />
										</td>
										<c:choose>
											<c:when test="${selectedCaseVO.channelVal == 'DSD'}">
												<c:set value="display: none;" var="styleStrOrdr"></c:set>
											</c:when>
											<c:otherwise>
												<c:set value="display: block;" var="styleStrOrdr"></c:set>
											</c:otherwise>
										</c:choose>
										<td align="right" width="12%">
											<div id="orderResLabel" style="${styleStrOrdr}">
												<cps:renderByResourceAccess resourceId="244">
													<jsp:attribute name="EDIT">
														<label class="labelFont helpable" id="OrderRestrictionLabel">Order Restriction</label>
													</jsp:attribute>
													<jsp:attribute name="VIEW">
														<label class="labelFont helpable" id="OrderRestrictionLabel">Order Restriction</label>
													</jsp:attribute>
												</cps:renderByResourceAccess>
											</div>
										</td>
										<td align="left" width="15%">&nbsp;&nbsp;
											<div id="orderRes" style="${styleStrOrdr}">
												<cps:renderByResourceAccess resourceId="244" honorViewMode="${CPSForm.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<select
													id="orderRestriction" tabindex="213" class="selectBoxStyle"
													style="dataType: alpha;">
													<c:forEach var="opt"
														items="${CPSForm.vendorVO.orderRestrictionList}">
														<c:if test="${opt.id eq vendorVO.orderRestrictionVal}">
															<option value="${opt.id}" selected="selected">${opt.name}</option>
														</c:if>
														<c:if test="${opt.id ne vendorVO.orderRestrictionVal}">
															<option value="${opt.id}">${opt.name}</option>
														</c:if>
													</c:forEach>
													</select>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<select
													id="orderRestriction" tabindex="213" class="selectBoxStyle"
													style="dataType: alpha;" disabled="disabled">
													<c:forEach var="opt"
														items="${CPSForm.vendorVO.orderRestrictionList}">
														<c:if test="${opt.id eq vendorVO.orderRestrictionVal}">
															<option value="${opt.id}" selected="selected">${opt.name}</option>
														</c:if>
														<c:if test="${opt.id ne vendorVO.orderRestrictionVal}">
															<option value="${opt.id}">${opt.name}</option>
														</c:if>
													</c:forEach>
													</select>
												</jsp:attribute>
												<jsp:attribute name="NONE">
													<select
													id="orderRestriction" tabindex="211" class="selectBoxStyle"
													style="dataType: alpha; visibility: hidden;" disabled="disabled">
													<c:forEach var="opt"
														items="${CPSForm.vendorVO.orderRestrictionList}">
														<c:if test="${opt.id eq vendorVO.orderRestrictionVal}">
															<option value="${opt.id}" selected="selected">${opt.name}</option>
														</c:if>
														<c:if test="${opt.id ne vendorVO.orderRestrictionVal}">
															<option value="${opt.id}">${opt.name}</option>
														</c:if>
													</c:forEach>
													</select>
												</jsp:attribute>
												</cps:renderByResourceAccess>
											</div>
										</td>
									</tr>
							</table>
				</td>
			</tr>
<!-- 			<tr> -->
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${selectedCaseVO.channelVal == 'DSD'}"> --%>
<%-- 						<c:set value="display: none;" var="styleStrCost"></c:set> --%>
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<%-- 						<c:set value="display: block;" var="styleStrCost"></c:set> --%>
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
<%-- 				<td align="right" width="5%"><div id="costLinkLabel" style="${styleStrCost }"><label class="labelFont helpable" id="CostLinkRadioLabel">Cost	Link# </label></div></td> --%>
<%-- 				<c:set value="" var="costChecked"></c:set> --%>
<%-- 				<c:if test="${CPSForm.vendorVO.costLinkRadio eq 'true'}"> --%>
<%-- 						<c:set value='checked="checked"' var="costChecked"></c:set> --%>
<%-- 				</c:if> --%>
<%-- 				<td align="left" width="6%"><div id="costLink" style="${styleStrCost }">  --%>
<%-- 					<input type="radio" onmousedown="clickRadio(this)" onclick="return false;" onmouseup="return false;" name="vendorradio" tabindex="206" id="costRadio" maxlength="1" ${costChecked}/></div></td> --%>
<%-- 				<td width="5%" align="right"><div id="ItemRadioLabelDiv" style="${styleStrCost}"><label class="labelFont helpable" id="ItemRadioLabel">Item Code </label></div></td> --%>
<%-- 				<c:set value="" var="itemChecked"></c:set> --%>
<%-- 				<c:if test="${CPSForm.vendorVO.itemCodeRadio eq 'true'}"> --%>
<%-- 						<c:set value='checked="checked"' var="itemChecked"></c:set> --%>
<%-- 				</c:if> --%>
<%-- 				<td width="6%" align="left"><div id="itemRadioDiv" style="${styleStrCost}">&nbsp;&nbsp;  --%>
<%-- 					<input type="radio" onmousedown="clickRadio(this)" onclick="return false;" onmouseup="return false;" name="vendorradio" tabindex="207" id="itemRadio" maxlength="1" ${itemChecked}/></div></td> --%>
					
				<!-- Order Unit Changes -->
<!-- 				<td width="5%" align="right"> -->
<%-- 					<div id="orderUnitLabelDiv" style="${styleStrTie}"> --%>
<%-- 						<cps:renderByResourceAccess resourceId="258" --%>
<%-- 					honorViewMode="${CPSForm.caseViewOverRide}"> --%>
<%-- 					<jsp:attribute name="EDIT"> --%>
<!-- 								<label class="labelFont helpable" id="OrderUnitLabel">Order Unit </label> -->
<%-- 							</jsp:attribute> --%>
<%-- 					<jsp:attribute name="VIEW"> --%>
<!-- 								<label class="labelFont helpable" id="OrderUnitLabel">Order Unit </label> -->
<%-- 							</jsp:attribute> --%>
<%-- 				</cps:renderByResourceAccess> --%>
<!-- 					</div> -->
<!-- 				</td> -->
<%-- 				<td width="6%" align="left"><div id="orderUnitDiv" style="${styleStrTie}">&nbsp;&nbsp;  --%>
<%-- 					<cps:renderByResourceAccess resourceId="258" honorViewMode="${CPSForm.caseViewOverRide}"> --%>
<%-- 						<jsp:attribute name="EDIT"> --%>
<!-- 							<select onchange="onChangeOrderUnit(this)" -->
<!-- 							id="orderUnit" tabindex="208" class="selectBoxStyle3" -->
<!-- 							style="dataType: alpha;"> -->
<%-- 							<c:forEach var="opt" --%>
<%-- 								items="${CPSForm.vendorVO.orderUnitList}"> --%>
<%-- 								<c:if test="${opt.id eq vendorVO.orderUnit}"> --%>
<%-- 									<option value="${opt.id}" selected="selected">${opt.name}</option> --%>
<%-- 								</c:if> --%>
<%-- 								<c:if test="${opt.id ne vendorVO.orderUnit}"> --%>
<%-- 									<c:set value="" var="selected" /> --%>
<%-- 									<c:if test="${opt.id eq 'C'}"> --%>
<%-- 										<c:set value="selected" var="selected" />  --%>
<%-- 									</c:if> --%>
<%-- 									<option value="${opt.id}" selected=${selected}>${opt.name}</option>  --%>
<%-- 								</c:if> --%>
<%-- 							</c:forEach> --%>
<!-- 							</select> -->
<%-- 						</jsp:attribute> --%>
<%-- 						<jsp:attribute name="VIEW"> --%>
<!-- 							<select -->
<!-- 							id="orderUnit" tabindex="208" class="selectBoxStyle3" -->
<!-- 							style="dataType: alpha;" disabled="disabled"> -->
<%-- 							<c:forEach var="opt" --%>
<%-- 								items="${CPSForm.vendorVO.orderUnitList}"> --%>
<%-- 								<c:if test="${opt.id eq vendorVO.orderUnit}"> --%>
<%-- 									<option value="${opt.id}" selected="selected">${opt.name}</option> --%>
<%-- 								</c:if> --%>
<%-- 								<c:if test="${opt.id ne vendorVO.orderUnit}"> --%>
<%-- 									<option value="${opt.id}">${opt.name}</option> --%>
<%-- 								</c:if> --%>
<%-- 							</c:forEach> --%>
<!-- 							</select> -->
<%-- 						</jsp:attribute> --%>
<%-- 						<jsp:attribute name="NONE"> --%>
<!-- 							<select -->
<!-- 							id="orderUnit" tabindex="208" class="selectBoxStyle3" -->
<!-- 							style="dataType: alpha; visibility: hidden;" disabled="disabled"> -->
<%-- 							<c:forEach var="opt" --%>
<%-- 								items="${CPSForm.vendorVO.orderUnitList}"> --%>
<%-- 								<c:if test="${opt.id eq vendorVO.orderUnit}"> --%>
<%-- 									<option value="${opt.id}" selected="selected">${opt.name}</option> --%>
<%-- 								</c:if> --%>
<%-- 								<c:if test="${opt.id ne vendorVO.orderUnit}"> --%>
<%-- 									<option value="${opt.id}">${opt.name}</option> --%>
<%-- 								</c:if> --%>
<%-- 							</c:forEach> --%>
<!-- 							</select> -->
<%-- 						</jsp:attribute> --%>
<%-- 						</cps:renderByResourceAccess> --%>
					
					
<!-- 					</div></td> -->
					
<!-- 					End of Order Unit changes					 -->
<!-- 				<td colspan="2"></td> -->
<!-- 			</tr> -->
<!-- 			<tr align="left"> -->
<%-- 				<td align="right" width="12%"><div id="CostItemLabelDiv" style="${styleStrCost}"><label class="labelFont helpable" id="CostItemLabel">Cost Link# /Item Code </label></div></td> --%>
<%-- 				<td align="left" width="12%"><div id="costlistDiv" style="${styleStrCost}">&nbsp;&nbsp;<input type="text" id="costlist" maxlength="13" tabindex="210" class="textFieldNormal" value="" onblur="calculateListCost();" style="dataType:numeric;" disabled="disabled"></div></td> --%>
<!-- 				<td align="right" width="12%" ><label class="labelFont helpable" id="UnitCost1Label">Unit Cost </label></td> -->
<!-- 				<td align="left" width="12%">&nbsp;&nbsp;<label	id="unitCostLabel" class="labelFont"></label></td> -->
<!-- 				<td align="right" width="12%"> -->
<!-- 					<table> -->
<!-- 						<tr> -->
<!-- 							<td width="11%"><label class="labelFont helpable" -->
<!-- 								id="ExpWeekMovLabel">Expected Weekly Movement</label></td> -->
<!-- 							<td width="1%"> -->
<!-- 							<DIV class="labelFont" id="ewmMandatory"> -->
<%-- 								<c:choose> --%>
<%-- 									<c:when --%>
<%-- 										test="${CPSForm.productVO.classificationVO.productType eq 'GOODS'}"> --%>
<!-- 										<em><font color="red"><b>*</b></font></em> -->
<%-- 									</c:when> --%>
<%-- 								</c:choose> --%>
<!-- 							</DIV> -->
<!-- 							</td> -->
<!-- 						</tr> -->
<!-- 					</table> -->
<!-- 				</td> -->
<!-- 				<td width="12%"> -->
<!-- 					<input type="text" tabindex="212" id="expectedweeklymovement" maxlength="5" style="dataType: numeric;" onblur="validateNumber(this,'Expected Weekly Movement'); validateExpected();" /> -->
<!-- 				</td> -->
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${selectedCaseVO.channelVal == 'DSD'}"> --%>
<%-- 						<c:set value="display: none;" var="styleStrOrdr"></c:set> --%>
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<%-- 						<c:set value="display: block;" var="styleStrOrdr"></c:set> --%>
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
<!-- 				<td align="right" width="12%"> -->
<%-- 					<div id="orderResLabel" style="${styleStrOrdr}"> --%>
<%-- 						<cps:renderByResourceAccess resourceId="244"> --%>
<%-- 							<jsp:attribute name="EDIT"> --%>
<!-- 								<label class="labelFont helpable" id="OrderRestrictionLabel">Order Restriction</label> -->
<%-- 							</jsp:attribute> --%>
<%-- 							<jsp:attribute name="VIEW"> --%>
<!-- 								<label class="labelFont helpable" id="OrderRestrictionLabel">Order Restriction</label> -->
<%-- 							</jsp:attribute> --%>
<%-- 						</cps:renderByResourceAccess> --%>
<!-- 					</div> -->
<!-- 				</td> -->
<!-- 				<td align="left" width="15%">&nbsp;&nbsp; -->
<%-- 					<div id="orderRes" style="${styleStrOrdr}"> --%>
<%-- 						<cps:renderByResourceAccess resourceId="244" honorViewMode="${CPSForm.caseViewOverRide}"> --%>
<%-- 						<jsp:attribute name="EDIT"> --%>
<!-- 							<select -->
<!-- 							id="orderRestriction" tabindex="213" class="selectBoxStyle" -->
<!-- 							style="dataType: alpha;"> -->
<%-- 							<c:forEach var="opt" --%>
<%-- 								items="${CPSForm.vendorVO.orderRestrictionList}"> --%>
<%-- 								<c:if test="${opt.id eq vendorVO.orderRestrictionVal}"> --%>
<%-- 									<option value="${opt.id}" selected="selected">${opt.name}</option> --%>
<%-- 								</c:if> --%>
<%-- 								<c:if test="${opt.id ne vendorVO.orderRestrictionVal}"> --%>
<%-- 									<option value="${opt.id}">${opt.name}</option> --%>
<%-- 								</c:if> --%>
<%-- 							</c:forEach> --%>
<!-- 							</select> -->
<%-- 						</jsp:attribute> --%>
<%-- 						<jsp:attribute name="VIEW"> --%>
<!-- 							<select -->
<!-- 							id="orderRestriction" tabindex="213" class="selectBoxStyle" -->
<!-- 							style="dataType: alpha;" disabled="disabled"> -->
<%-- 							<c:forEach var="opt" --%>
<%-- 								items="${CPSForm.vendorVO.orderRestrictionList}"> --%>
<%-- 								<c:if test="${opt.id eq vendorVO.orderRestrictionVal}"> --%>
<%-- 									<option value="${opt.id}" selected="selected">${opt.name}</option> --%>
<%-- 								</c:if> --%>
<%-- 								<c:if test="${opt.id ne vendorVO.orderRestrictionVal}"> --%>
<%-- 									<option value="${opt.id}">${opt.name}</option> --%>
<%-- 								</c:if> --%>
<%-- 							</c:forEach> --%>
<!-- 							</select> -->
<%-- 						</jsp:attribute> --%>
<%-- 						<jsp:attribute name="NONE"> --%>
<!-- 							<select -->
<!-- 							id="orderRestriction" tabindex="211" class="selectBoxStyle" -->
<!-- 							style="dataType: alpha; visibility: hidden;" disabled="disabled"> -->
<%-- 							<c:forEach var="opt" --%>
<%-- 								items="${CPSForm.vendorVO.orderRestrictionList}"> --%>
<%-- 								<c:if test="${opt.id eq vendorVO.orderRestrictionVal}"> --%>
<%-- 									<option value="${opt.id}" selected="selected">${opt.name}</option> --%>
<%-- 								</c:if> --%>
<%-- 								<c:if test="${opt.id ne vendorVO.orderRestrictionVal}"> --%>
<%-- 									<option value="${opt.id}">${opt.name}</option> --%>
<%-- 								</c:if> --%>
<%-- 							</c:forEach> --%>
<!-- 							</select> -->
<%-- 						</jsp:attribute> --%>
<%-- 						</cps:renderByResourceAccess> --%>
<!-- 					</div> -->
<!-- 				</td> -->
<!-- 				</tr> -->
			</table>
			<!-- Cost Link TABLE ENDS -->
		</td>
	</tr>
	<tr>
		<td colspan="8">
			<!-- IMPORT ONLY DIV -->
			<c:choose>
				<c:when test="${selectedCaseVO.importEnabled eq true}">
					<c:set value="visibility: visible; position: relative; min-width: 0;" var="styleStr"></c:set>
				</c:when>
				<c:otherwise>
					<c:set value="visibility: hidden; position: relative; min-width: 0;" var="styleStr"></c:set>
				</c:otherwise>
			</c:choose>
			<div id="importOnly" style="${styleStr}">
				<table>
					<tr align="left">
						<td align="right" width="5%" colspan="3"><label class="labelFont helpable" id="ImportLabel">Import</label></td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess resourceId="122" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
										 <c:if test="${vendorVO.importd eq 'true'}">
											<input type="checkbox" id="import" tabindex="215" onclick="importClicked();" checked="checked" />
										</c:if> 
										<c:if test="${vendorVO.importd eq 'false' || vendorVO.importd ==null || vendorVO.importd ==''}">
									<input type="checkbox" id="import" tabindex="215" onclick="importClicked();" />							
										</c:if>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
			                         	<c:if test="${vendorVO.importd eq 'true'}">
											<input type="checkbox" id="import" tabindex="215" onclick="importClicked();" checked="checked" disabled="disabled" />
										</c:if>
										<c:if test="${selectedVendorVO.importd eq 'false' || vendorVO.importd ==null || vendorVO.importd ==''}">
											<input type="checkbox" id="import" tabindex="215" onclick="importClicked();" disabled="disabled" />
										</c:if>
									</jsp:attribute>	
									
								<jsp:attribute name="NONE">
									<c:if test="${vendorVO.importd eq 'true'}">
											<input type="checkbox" id="import" tabindex="215" onclick="importClicked();" checked="checked" disabled="disabled" />
										</c:if>
										<c:if test="${vendorVO.importd eq 'false' || vendorVO.importd ==null || vendorVO.importd ==''}">
											<input type="checkbox" id="import" tabindex="215" onclick="importClicked();" disabled="disabled" />
										</c:if>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
					</tr>
				</table>
			</div>
			<!-- IMPORT ONLY DIV END -->
		</td>
	</tr>
</table>


<table width="97%">
	<tr>
		<td>
		<div id="importDiv"	style="display: none; position: relative; min-width: 0;">
			<fieldset id="importFieldset"><legend>Import Attributes</legend>
			<table width="100%" border="0">
			<tr>
				<td width="100%" align="center">
				<table border="0" width="100%" align="center">
					<tr align="left">
						<td align="right" width="12%">
							<cps:renderByResourceAccess	resourceId="129" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="ContainerLabel">Container Size<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="ContainerLabel">Container Size<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp;
							<cps:renderByResourceAccess	resourceId="129" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<select id="cntnSize" tabindex="220">												
										<c:forEach var="cntsize" items="${CPSForm.containerList}">
											<c:if test="${cntsize.id eq vendorVO.importVO.containerSize}">
												<option value="${cntsize.id}" selected="selected">${cntsize.name}</option>
											</c:if>
											<c:if test="${cntsize.id ne vendorVO.importVO.containerSize}">
												<option value="${cntsize.id}">${cntsize.name}</option>
											</c:if>
										</c:forEach>
									</select>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<select id="cntnSize" tabindex="220" disabled="disabled">												
										<c:forEach var="cntsize" items="${CPSForm.containerList}">
											<c:if test="${cntsize.id eq vendorVO.importVO.containerSize}">
												<option value="${cntsize.id}" selected="selected">${cntsize.name}</option>
											</c:if>
											<c:if test="${cntsize.id ne vendorVO.importVO.containerSize}">
												<option value="${cntsize.id}">${cntsize.name}</option>
											</c:if>
										</c:forEach>
									</select>
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<select id="cntnSize" tabindex="220" disabled="disabled" style="display:none;">												
										<c:forEach var="cntsize" items="${CPSForm.containerList}">
											<c:if test="${cntsize.id eq vendorVO.importVO.containerSize}">
												<option value="${cntsize.id}" selected="selected">${cntsize.name}</option>
											</c:if>
											<c:if test="${cntsize.id ne vendorVO.importVO.containerSize}">
												<option value="${cntsize.id}">${cntsize.name}</option>
											</c:if>
										</c:forEach>
									</select>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess	resourceId="134" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="IncoTermsLabel">Inco Terms <em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="IncoTermsLabel">Inco Terms <em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess	resourceId="134" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<select id="incoTerms" tabindex="225">
										<c:forEach var="inco"
											items="${CPSForm.incoList}">
											<c:if
												test="${inco.id eq vendorVO.importVO.incoTerms}">
												<option value="${inco.id}" selected="selected">${inco.name}</option>
											</c:if>
											<c:if
												test="${inco.id ne vendorVO.importVO.incoTerms}">
												<option value="${inco.id}">${inco.name}</option>
											</c:if>
										</c:forEach>
									</select>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<select id="incoTerms" tabindex="225" disabled="disabled">
										<c:forEach var="inco"
											items="${CPSForm.incoList}">
											<c:if
												test="${inco.id eq vendorVO.importVO.incoTerms}">
												<option value="${inco.id}" selected="selected">${inco.name}</option>
											</c:if>
											<c:if
												test="${inco.id ne vendorVO.importVO.incoTerms}">
												<option value="${inco.id}">${inco.name}</option>
											</c:if>
										</c:forEach>
									</select>
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<select id="incoTerms" tabindex="225" disabled="disabled" style="display:none;">
										<c:forEach var="inco"
											items="${CPSForm.incoList}">
											<c:if
												test="${inco.id eq vendorVO.importVO.incoTerms}">
												<option value="${inco.id}" selected="selected">${inco.name}</option>
											</c:if>
											<c:if
												test="${inco.id ne vendorVO.importVO.incoTerms}">
												<option value="${inco.id}">${inco.name}</option>
											</c:if>
										</c:forEach>
									</select>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						 <%--  input type="text"
							maxlength="3" tabindex="240" class="textFieldMedium" value=""
							id="incoTerms" style="dataType: alphanumericOnly;" onblur="switchToUpperCase(this);return true;"/>--%>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess	resourceId="130" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="PickupPointLabel">Pickup Point<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="PickupPointLabel">Pickup Point<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp;
							<cps:renderByResourceAccess resourceId="130" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT"> 
									<input type="text" maxlength="20" tabindex="230" class="textFieldNormal" 
										value="${vendorVO.importVO.pickupPoint}"
										id="pcikPoint" style="dataType: alphanumeric;" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" maxlength="20" tabindex="230" class="textFieldNormal" 
										value="${vendorVO.importVO.pickupPoint}"
										id="pcikPoint" style="dataType: alphanumeric;" disabled="disabled"/>
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" maxlength="20" tabindex="230" class="textFieldNormal" 
										value="${vendorVO.importVO.pickupPoint}"
										id="pcikPoint" style="dataType: alphanumeric; display:none;" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
					</tr>
                    	
					<tr align="left">
						<td align="right" width="12%">
							<cps:renderByResourceAccess resourceId="136" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="RatePerLabel">Duty % <em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="RatePerLabel">Duty % <em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess resourceId="136" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" maxlength="6" tabindex="235" class="textFieldSmall" 
										value="${vendorVO.importVO.rate}" id="rate" style="dataType: float;" 
										onblur="roundValue(this,2);return true;"/>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" maxlength="6" tabindex="235" class="textFieldSmall" 
										value="${vendorVO.importVO.rate}" id="rate" style="dataType: float;" disabled="disabled"/>
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" maxlength="6" tabindex="235" class="textFieldSmall" 
										value="${vendorVO.importVO.rate}" id="rate" style="dataType: float; display:none;" 
										disabled="disabled"/>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess	resourceId="133" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="DutyInfoLabel">Duty Info<em><font color="red"><b></b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="DutyInfoLabel">Duty Info<em><font color="red"><b></b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp;
							<cps:renderByResourceAccess	resourceId="133" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" maxlength="20" tabindex="240" class="textFieldNormal" 
										value="${vendorVO.importVO.dutyInfo}"
										id="dutyInfo" style="dataType: alphanumeric;" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" maxlength="20" tabindex="240" class="textFieldNormal" 
										value="${vendorVO.importVO.dutyInfo}" disabled="disabled"
										id="dutyInfo" style="dataType: alphanumeric;" />
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" maxlength="20" tabindex="240" class="textFieldNormal" 
										value="${vendorVO.importVO.dutyInfo}" disabled="disabled"
										id="dutyInfo" style="dataType: alphanumeric;" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess	resourceId="132" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="MinQtyLabel">Minimum Qty<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="MinQtyLabel">Minimum Qty<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess	resourceId="132" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" id="minQntity" maxlength="7" tabindex="245"
										class="textFieldSmall" value="${vendorVO.importVO.minimumQty}" style="dataType: numeric;" onblur="IsNumeric(this);"/>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" id="minQntity" maxlength="7" tabindex="245"
										class="textFieldSmall" value="${vendorVO.importVO.minimumQty}" style="dataType: numeric;" 
										disabled="disabled" onblur="IsNumeric(this);"/>
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" id="minQntity" maxlength="7" tabindex="245"
										class="textFieldSmall" value="${vendorVO.importVO.minimumQty}"  
										style="dataType: numeric; display:none;" disabled="disabled" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess resourceId="137" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="MiniTypeLabel">Min. Order Description<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="MiniTypeLabel">Min. Order Description<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp;
							<cps:renderByResourceAccess resourceId="137" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" maxlength="20" tabindex="250" class="textFieldNormal" onblur="onBlurMinType(this)"
										value="${vendorVO.importVO.minimumType}" id="minType" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" maxlength="20" tabindex="250" class="textFieldNormal" 
										value="${vendorVO.importVO.minimumType}" id="minType" disabled="disabled"/>
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" maxlength="20" tabindex="250" class="textFieldNormal" 
										value="${vendorVO.importVO.minimumType}" id="minType" 
										style="display:none;" disabled="disabled"/>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
					</tr>
					
					<tr>
						<td align="right" width="12%">
							<cps:renderByResourceAccess resourceId="195" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="HTSLabel">HTS1<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="HTSLabel">HTS1<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess resourceId="195" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text"
										id="hts" maxlength="10" tabindex="255" class="textFieldNormal"
										value="${vendorVO.importVO.hts}" style="dataType: numeric;" onblur="isNumericAndPadHts(this);"/>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" disabled="disabled"
										id="hts" maxlength="10" tabindex="255" class="textFieldNormal"
										value="${vendorVO.importVO.hts}" style="dataType: numeric;" onblur="isNumericAndPadHts(this);"/>
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" disabled="disabled"
										id="hts" maxlength="10" tabindex="255" class="textFieldNormal"
										value="${vendorVO.importVO.hts}" style="dataType: numeric; display:none;" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess resourceId="254" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="HTS2Label">HTS2<em><font color="red"><b></b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="HTS2Label">HTS2<em><font color="red"><b></b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess resourceId="254" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" value="${vendorVO.importVO.hts2}" id="hts2" maxlength="10"
									tabindex="260"  class="textFieldNormal" 
									style="dataType: numeric;" onblur="isNumericAndPadHts(this);"/>								
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" value="${vendorVO.importVO.hts2}" id="hts2" maxlength="10"
									tabindex="260"  class="textFieldNormal" disabled="disabled" 
									style="dataType: numeric;" onblur="isNumericAndPadHts(this);"/>								
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" value="${vendorVO.importVO.hts2}" id="hts2" maxlength="10"
									tabindex="260"  class="textFieldNormal" disabled="disabled" 
									style="dataType: numeric; display:none;" />								
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess resourceId="255" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="HTS3Label">HTS3<em><font color="red"><b></b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="HTS3Label">HTS3<em><font color="red"><b></b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess resourceId="255" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" value="${vendorVO.importVO.hts3}" id="hts3" maxlength="10"
									tabindex="265"  class="textFieldNormal" 
									style="dataType: numeric" onblur="isNumericAndPadHts(this);"/>								
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" value="${vendorVO.importVO.hts3}" id="hts3" maxlength="10"
									tabindex="265"  class="textFieldNormal" disabled="disabled" 
									style="dataType: numeric" onblur="isNumericAndPadHts(this);"/>								
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" value="${vendorVO.importVO.hts3}" id="hts3" maxlength="10"
									tabindex="265"  class="textFieldNormal" disabled="disabled" 
									style="dataType: numeric; display:none;" />								
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess	resourceId="133" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="ColorLabel">Product Color<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="ColorLabel">Product Color<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp;
							<cps:renderByResourceAccess	resourceId="133" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" maxlength="50" tabindex="270" class="textFieldNormal" 
										value="${vendorVO.importVO.color}" id="color"/>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" maxlength="50" tabindex="270" class="textFieldNormal" 
										value="${vendorVO.importVO.color}" disabled="disabled" id="color" />
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" maxlength="50" tabindex="270" class="textFieldNormal" 
										value="${vendorVO.importVO.color}" disabled="disabled" id="color" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
					</tr>
					
					<tr>
						<td align="right" width="12%">
							<cps:renderByResourceAccess resourceId="197" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="AgentLabel">Agent % <em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="AgentLabel">Agent % <em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess resourceId="197" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" id="agentPer" maxlength="6" tabindex="275"
									class="textFieldNormal" value="${vendorVO.importVO.agentPerc}" 
									style="dataType: float;" onblur="roundValue(this,2);return true;"/>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" id="agentPer" maxlength="6" tabindex="275" disabled="disabled"
									class="textFieldNormal" value="${vendorVO.importVO.agentPerc}" 
									style="dataType: float;" onblur="roundValue(this,2);return true;"/>
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" id="agentPer" maxlength="6" tabindex="275" disabled="disabled"
									class="textFieldNormal" value="${vendorVO.importVO.agentPerc}" 
									style="dataType: float; display:none;" onblur="roundValue(this,2);return true;"/>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess resourceId="199" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="CartonMarkLabel">Carton Marking<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="CartonMarkLabel">Carton Marking<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess resourceId="199" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" id="cartMarketing" maxlength="30" tabindex="280"
										size="35" value="${vendorVO.importVO.cartonMarketing}" 
										style="dataType: alphanumeric;" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" id="cartMarketing" maxlength="30" tabindex="280"
										size="35" value="${vendorVO.importVO.cartonMarketing}" 
										style="dataType: alphanumeric;" disabled="disabled"/>
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" id="cartMarketing" maxlength="30" tabindex="280"
										size="35" value="${vendorVO.importVO.cartonMarketing}" 
										style="dataType: alphanumeric; display:none;" disabled="disabled"/>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess resourceId="196" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label
								class="labelFont helpable" id="DutyLabel">Duty Confirmed<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
										<label
								class="labelFont helpable" id="DutyLabel">Duty Confirmed<em><font color="red"><b>*</b></font></em></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess resourceId="196" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" id="duty" maxlength="10" tabindex="285" style="width: 70%"
										value="${vendorVO.importVO.duty}"  class="textFieldSmall" onblur="validateDateUsingDWR(this,'Duty Confirmed');"/>
										<img src="${calend}" id="dutyCalend" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" id="duty" maxlength="10" tabindex="285" disabled="disabled" style="width: 70%"
										value="${vendorVO.importVO.duty}"  class="textFieldSmall"/>
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" id="duty" maxlength="10" tabindex="285" disabled="disabled" style="width: 70%"
										value="${vendorVO.importVO.duty}" style="dataType: alphanumericOnly; display:none;"  class="textFieldSmall"/>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess	resourceId="131" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="PickupPointLabel"><label
								class="labelFont helpable" id="FreightLabel">Freight Confirmed<em><font color="red"><b>*</b></font></em></label></label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="FreightLabel"><label
								class="labelFont helpable" id="FreightLabel">Freight Confirmed<em><font color="red"><b>*</b></font></em></label></label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess resourceId="131" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" maxlength="20" tabindex="290" style="width: 70%"
									 value="${vendorVO.importVO.freight}" id="freight"  onblur="validateDateUsingDWR(this,'Freight Confirmed');"/>
									 <img src="${calend1}" id="freights" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" maxlength="20" tabindex="290" style="width: 70%"
									 value="${vendorVO.importVO.freight}" id="freight" disabled="disabled" onblur="validateDateUsingDWR(this,'Freight Confirmed');"/>
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" maxlength="20" tabindex="290" style="width: 70%"
									 value="${vendorVO.importVO.freight}" id="freight" disabled="disabled" onblur="validateDateUsingDWR(this,'Freight Confirmed');"/>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
							
						<td align="right" width="12%"></td>
						<td align="left" width="12%">&nbsp;</td>
					</tr>
					
					<tr>
						<td align="right" width="12%">
							<cps:renderByResourceAccess	resourceId="135" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="ProDateLabel">Proration Date</label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="ProDateLabel">Proration Date</label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess	resourceId="135" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" id="prorDate" maxlength="10" tabindex="295"
										 value="${vendorVO.importVO.prorationDate}" onblur="validateDateUsingDWR(this,'Proration Date');" /> 
									<img src="${calend}" id="propDate" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" id="prorDate" maxlength="10" tabindex="295" disabled="disabled"
										 value="${vendorVO.importVO.prorationDate}" onblur="validateDateUsingDWR(this,'Proration Date');" /> 
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" id="prorDate" maxlength="10" tabindex="295" disabled="disabled" style="display:none;"
										 value="${vendorVO.importVO.prorationDate}" onblur="validateDateUsingDWR(this,'Proration Date');" /> 
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess resourceId="138" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="InstoreDateLabel">Instore Date</label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="InstoreDateLabel">Instore Date</label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess resourceId="138" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" id="instoreDate" maxlength="10" tabindex="300" 
									value="${vendorVO.importVO.instoreDate}"
									onblur="validateDateUsingDWR(this,'Instore Date');" /> 
									<img src="${calen}" id="storeDate" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" id="instoreDate" maxlength="10" tabindex="300" 
									value="${vendorVO.importVO.instoreDate}" disabled="disabled"/> 
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" id="instoreDate" maxlength="10" tabindex="300" 
									value="${vendorVO.importVO.instoreDate}" disabled="disabled" style="display:none;"/> 
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%">
							<cps:renderByResourceAccess resourceId="198" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="WHSEDateLabel">Whse Flush Date</label>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="WHSEDateLabel">Whse Flush Date</label>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="12%">&nbsp;&nbsp; 
							<cps:renderByResourceAccess resourceId="198" honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="text" id="whseFlushDate" maxlength="10" tabindex="305" 
										value="${vendorVO.importVO.whseFlushDate}"
										onblur="validateDateUsingDWR(this,'Whse Flush Date');" /> 
									<img src="${cal}" id="flushDate" />								
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="text" id="whseFlushDate" maxlength="10" tabindex="305" 
										value="${vendorVO.importVO.whseFlushDate}" disabled="disabled"/> 
								</jsp:attribute>
								<jsp:attribute name="NONE">
									<input type="text" id="whseFlushDate" maxlength="10" tabindex="305" 
										value="${vendorVO.importVO.whseFlushDate}" style="display:none;"/> 
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						
						<td align="right" width="12%"></td>
						<td align="left" width="12%">
							<div id="enableFactoryDiv">
								<cps:renderByResourceAccess resourceId="256">
									<jsp:attribute name="EXEC">
										<button id="importFacilities">Import Factory</button>
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<button id="importFacilities">Import Factory</button>
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</div>
							<input type="hidden" id="factoryList" value="${vendorVO.importVO.factoryList}">
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</fieldset>
		</div>
		</td>
	</tr>
	</table>
	
	<!--#1205 Request New Attribute-->
	<table width="100%">
		<tr>
			<td align="left">
			<cps:renderByResourceAccess resourceId="174" honorViewMode="${CPSForm.caseViewOverRide}">
				<jsp:attribute name="EXEC">
					<button type="button" id="reqAttribute" name="button1"
						value="requestnewattribute" tabindex="9">Request New Attribute</button>				
				</jsp:attribute>
			</cps:renderByResourceAccess>
			</td>
		</tr>
	</table>
	
    <table width="100%">
		<tr>
			<!-- <td><input type="button" value="Test Morph2" id="morphButton2" onclick="morphtest();"
											tabindex="320" /></td> -->	
			<td align="right" width="80%">
				<cps:renderByResourceAccess	resourceId="192" honorViewMode="${CPSForm.caseViewOverRide}">
					<jsp:attribute name="EXEC">
						<input type="button" value="Save Vendor" id="addButton6" tabindex="320" />		
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			
			<!--1205 Edit Case Edit Vendor-->
			<!-- Add Cancel Button for Vendor -->
			<td align="right" width="10%"><cps:renderByResourceAccess
					resourceId="192" honorViewMode="${CPSForm.caseViewOverRide}">
					<jsp:attribute name="EXEC">
								<input type="button" value="Cancel" id="vendorCancel"
							tabindex="321" />		
							</jsp:attribute>
				</cps:renderByResourceAccess></td>
			
			<td align="right" width="10%">
			<div id="enableAuthorizeWHS" style="display: none;">
				<cps:renderByResourceAccess	resourceId="194" honorViewMode="${CPSForm.caseViewOverRide}">
					<jsp:attribute name="EXEC">
						<button id="authWHS" tabindex="325">Authorize WHS</button>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</div>
			<div id="enableAuthorizeStore" style="display: none;">
				<cps:renderByResourceAccess	resourceId="193" honorViewMode="${CPSForm.caseViewOverRide}">
					<jsp:attribute name="EXEC">
						<button id="authStore" tabindex="326">Authorize Store</button>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</div>
			</td>
		</tr>
	</table>
	<!-- #1205 Request New Attribute -->
	<div id="RNAPanel" style="display: none;">
		<div class="hd">
			<div class="tl"></div>
			<span><font size="2" color="white">&nbsp;&nbsp;&nbsp; Request New Attribute</font></span>
			<div class="tr"></div>
		</div>
		<div class="bd">
			<iframe id="RNApopupFrame" height="1px" width="1px"></iframe>
		</div>
		<div class="ft">
			<div class="bl"></div>
			<div class="br"></div>
		</div>
	</div>
</fieldset>
	<br>
	<!-- Vendor ends -->
	<div id="nextDiv">
		<table width="100%"style="width: 96%;  margin-left: 10px; border-collapse: collapse;">
			<tr>
				<td width="90%"></td>
				<td align="right" width="6%"><input type="button" value="Back" id="backButton" tabindex="350" /></td>
			</tr>
		</table>
	</div>
</div> 
	
<script type="text/javascript">
	//khoapkl --visible Activate button when modifying a active product
	<c:if test="!${AddNewCandidate.enableActiveButton}">
		if(document.getElementById('activateButton')!=null)
			document.getElementById('activateButton').disabled = false;
	</c:if>	
    if(document.getElementById('AVupc')){
    	new YAHOO.widget.Button("AVupc");
    	//Fix QC -1508
       <c:set value="true" var="isEnaled"/>
		<c:if test="${selectedCaseVO.itemId>0}">
           <c:set value="false" var="isEnaled"/>
              YAHOO.util.Event.removeListener("AVupc", "click");
              YAHOO.util.Event.addListener(YAHOO.util.Dom.get("AVupc"), "click", updateCaseActivated);
       </c:if>
    	document.getElementById('AVupc').disabled = ${isEnaled};
    }
    if(document.getElementById('cancelBut')){
        new YAHOO.widget.Button("cancelBut");
        document.getElementById('cancelBut').disabled = true;
    }

    if(document.getElementById("addButton6")){
   		new YAHOO.widget.Button("addButton6");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", saveCaseAndVendor);
    }
    
    if(document.getElementById('vendorCancel')){
		new YAHOO.widget.Button("vendorCancel");
		YAHOO.util.Event.removeListener("vendorCancel", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("vendorCancel"), "click", clearVendorDetails);
	}
    <c:if test="${CPSForm.productVO.caseCount > 0}">
    	if(document.getElementById("editCaseBut")){
    		document.getElementById('editCaseBut').style.display = 'inline-flex';
    	}
    	if(document.getElementById("deleteBut")){
			document.getElementById('deleteBut').style.display = 'inline-flex';
    	}
    </c:if>

	<c:if test="${vendorVO.newDataSw eq 'Y'.charAt(0)}">
	if(document.getElementById("deleteVendorDetailsButDiv")){
		document.getElementById("deleteVendorDetailsButDiv").style.display = 'block';
	}
	if(document.getElementById("editVendorDetailsButDiv")){
		document.getElementById("editVendorDetailsButDiv").style.display = 'block';
	}
	</c:if>
	<c:if test="${vendorVO.newDataSw eq 'N'.charAt(0)}">
	if(document.getElementById("deleteVendorDetailsButDiv")){
		document.getElementById("deleteVendorDetailsButDiv").style.display = 'none';
	}
	if(document.getElementById("editVendorDetailsButDiv")){
		document.getElementById("editVendorDetailsButDiv").style.display = 'none';
	}
	</c:if>
	new YAHOO.widget.Button("importFacilities");//R2
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("importFacilities"), "click", importFacilities);//R2

	//#1205-Add New Attribute
	var oPushButton1 = new YAHOO.widget.Button("reqAttribute");	
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("reqAttribute"), "click", reqAttributeClick);	    
	
	YAHOO.util.Event.onDOMReady(function(){	
		YAHOO.util.Dom.get("hts").value = padHts(YAHOO.util.Dom.get("hts").value);
		YAHOO.util.Dom.get("hts2").value = padHts(YAHOO.util.Dom.get("hts2").value);
		YAHOO.util.Dom.get("hts3").value = padHts(YAHOO.util.Dom.get("hts3").value);
	});
</script>