<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />

<style type="text/css">
	.yui-skin-sam .yui-dt-col-address pre {
		font-family: arial;
		font-size: 100%;
	}

	.origin {
		display: block;
		background: #795089;
		padding: 1ex;
		color: #fff;
		text-align: right;
		margin-bottom: 1em;
	}

	.yui-skin-sam .mask {
		opacity: 0.12;
		*filter: alpha(opacity = 12); /* Set opacity in IE */
	}

	#heb {
		height: 20em;
	}

	/* XP Panel Skin CSS */

	/* Skin default elements */
	#RNAPanel_c.yui-panel-container.shadow .underlay {
		left: 1px;
		right: -1px;
		top: 1px;
		bottom: -1px;
		position: absolute;
		background-color: #000;
		opacity: 0.12;
		filter: alpha(opacity = 12);
	}

	/* Apply the border to the right side */
	#RNAPanel.yui-panel {
		border: none;
		overflow: visible;
		background: transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif)
		no-repeat top right;
	}

	/* Style the close icon */
	#RNAPanel.yui-panel .container-close {
		position: absolute;
		top: 5px;
		right: 8px;
		height: 21px;
		width: 21px;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif)
		no-repeat;
	}

	/* Style the header with its associated corners */
	#RNAPanel.yui-panel .hd {
		padding: 0;
		border: none;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-hd.gif)
		repeat-x;
		color: #FFF;
		height: 30px;
		margin-left: 0px;
		margin-right: 0px;
		text-align: left;
		vertical-align: middle;
		overflow: visible;
	}

	/* Style the body with the left border */
	#RNAPanel.yui-panel .bd {
		overflow: hidden;
		padding: 10px;
		border: none;
		background: #FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif)
		repeat-y;
		margin: 0 4px 0 0;
	}

	/* Style the footer with the bottom corner images */
	#RNAPanel.yui-panel .ft {
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif)
		repeat-x;
		font-size: 11px;
		height: 26px;
		padding: 0px 10px;
		border: none
	}

	/* Skin custom elements */
	#RNAPanel.yui-panel .hd span {
		line-height: 30px;
		vertical-align: middle;
		font-weight: bold;
	}

	#RNAPanel.yui-panel .hd .tl {
		width: 8px;
		height: 29px;
		top: 1px;
		left: 0px;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif)
		no-repeat;
		position: absolute;
	}

	#RNAPanel.yui-panel .hd .tr {
		width: 8px;
		height: 29px;
		top: 1px;
		right: 0;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif)
		no-repeat;
		position: absolute;
	}

	#RNAPanel.yui-panel .ft span {
		line-height: 22px;
		vertical-align: middle;
	}

	#RNAPanel.yui-panel .ft .bl {
		width: 8px;
		height: 26px;
		bottom: 0;
		left: 0;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif)
		no-repeat;
		position: absolute;
	}

	#RNAPanel.yui-panel .ft .br {
		width: 8px;
		height: 26px;
		bottom: 0;
		right: 0;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif)
		no-repeat;
		position: absolute;
	}
</style>

<form:form styleId="authAndDistForm" id="authAndDistForm" name="authAndDistForm" action="/protected/cps/add" modelAttribute="addNewCandidate">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<c:url value="${request.getContextPath()}/hebAssets/moduleIncludes/authAndDist.js" var="authAndDist" />
	<c:url value="${request.getContextPath()}/hebAssets/common.js" var="common" />
	<script type="text/javascript" src="${authAndDist}"></script>
	<script type="text/javascript" src="${common}"></script>
	<c:url value="${request.getContextPath()}/hebAssets/moduleIncludes/auth.js.jsp" var="auth" />
	<script type="text/javascript" src="${auth}"></script>

	<script type="text/javascript">
        <c:url var="colspd" value="${request.getContextPath()}/hebAssets/images/collapsed.gif"/>
        <c:url var="expnd" value="${request.getContextPath()}/hebAssets/images/expanded.gif"/>
        <c:url var="calend" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
        <c:url var="calend1" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
        <c:url var="cal" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
        <c:url var="calen" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
	</script>

	<body onload="makeAppUPCLinked();">
	<br>
	<div id="all">
		<a id="sec0tion"></a>
		<fieldset style="width: 96%; margin-left: 10px; border-collapse: collapse;" id="f1">
			<legend onclick="toggle('f1');" style="cursor: pointer;"><img src="${expnd}" id="caseImg"> Existing Cases</legend>
			<div id="caseDiv">
				<br>
				<table width="100%" border="0" id="existingCases" border="0" cellspacing="0" cellpadding="2">
					<tr>
						<c:url var="img"
							   value="${request.getContextPath()}/hebAssets/images/newButtons/validated.PNG" />
						<td width="1%" align="center" class="dataGridHead"></td>
						<td width="14%" align="center" class="dataGridHead">Case UPC</td>
						<td width="12%" align="center" class="dataGridHead">Item Code</td>
						<td width="17%" align="center" class="dataGridHead">Case Description</td>
						<td width="5%" align="center" class="dataGridHead">MRT</td>
						<td width="8%" align="center" class="dataGridHead">Channel</td>
						<td width="8%" align="center" class="dataGridHead">Master Pack</td>
						<td width="8%" align="center" class="dataGridHead">Ship Pack</td>
						<td width="1%" align="center" class="dataGridHead"></td>
						<td width="5%" align="center" class="dataGridHead">Active</td>
						<td width="11%" align="center" class="dataGridHead"></td>
						<td width="1%" align="center" class="dataGridHead"></td>
					</tr>
					<tbody id="caseItemTbody">
					<c:forEach items="${addNewCandidate.productVO.caseVOs}" var="caseValue" varStatus="loop" >
						<tr id="caseRow${loop.index}"
							onclick="makeRowClickedForTable('caseItemTbody','caseRow${loop.index}','${loop.index}','#FFAA00');
									displayDetailsSetCount('${loop.index}');" class="row${loop.index%2}">
							<td width="1%" align="center" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
								<input type="hidden" id="caseVOUniqueId${loop.index}" value="${caseValue.uniqueId}">
							</td>
							<td width="16%" align="center" class="row${loop.index%2}" align="center" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
								<c:out value="${caseValue.formattedCaseUPC}"></c:out>
							</td>
							<td width="12%" align="center" class="row${loop.index%2}" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
								<c:out value="${caseValue.itemId}"></c:out>
							</td>
							<td width="17%" align="center" class="row${loop.index%2}" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
								<c:out value="${caseValue.caseDescription}"></c:out>
							</td>
							<td align="center" width="7%" class="row${loop.index%2}" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
								<font class="labelFont">
									<c:choose>
										<c:when test="${caseValue.mrt eq 'Y'}">
											<input type="checkbox" checked="checked" disabled="disabled" />
										</c:when>
										<c:otherwise>
											<input type="checkbox" disabled="disabled" />
										</c:otherwise>
									</c:choose>
								</font>
							</td>
							<td width="11%" align="center" class="row${loop.index%2}" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
								<font class="labelFont">
									<input type="hidden" id="channel${loop.index}" value="${caseValue.channel}"/>
									<c:out value="${caseValue.channel}"></c:out>
								</font>
							</td>
							<td width="10%" align="center" class="row${loop.index%2}" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
								<font class="labelFont">
									<input type="hidden" id="masterPack${loop.index}" value="${caseValue.masterPack}"/>
									<c:out value="${caseValue.masterPack}"></c:out>
								</font>
							</td>
							<td width="10%" align="center" class="row${loop.index%2}" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
								<font class="labelFont">
									<input type="hidden" id="shipPack${loop.index}" value="${caseValue.shipPack}"/>
									<c:out value="${caseValue.shipPack}"></c:out>
								</font>
							</td>
							<td width="1%" align="center" class="row${loop.index%2}" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
								<font class="labelFont">
									<input type="hidden" id="listCost${loop.index}" value="${caseValue.listCost}"/>
									<c:out value="${caseValue.listCost}"></c:out>
								</font>
							</td>
							<c:set value="" var="active" />
							<c:if test="${caseValue.itemId > 0}">
								<c:set value="Active" var="active" />
							</c:if>
							<td align="center" width="5%" class="row${loop.index%2}" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
								<font class="labelFont">
									<input type="hidden" id="purchaseStatus${loop.index}" value="${caseValue.purchaseStatus}" />
										${active}
								</font>
							</td>
							<td align="center" width="5%" class="row${loop.index%2}" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;"></td>
							<td align="center" width="11%" class="row${loop.index%2}" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;"></td>
							<td width="1%" align="center" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
								<input type="hidden" id="caseVOPsItemId${loop.index}" value="${caseValue.psItemId}">
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<br />
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="right" width="90%">
						<cps:renderByResourceAccess resourceId="187" honorViewMode="${addNewCandidate.caseViewOverRide}">
							<jsp:attribute name="EXEC">
								<input type="button" value="Add New Case" id="addCaseBut" />
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</td>
					<td align="right" width="5%">
						<cps:renderByResourceAccess resourceId="187" honorViewMode="${addNewCandidate.caseViewOverRide}">
							<jsp:attribute name="EXEC">
								<input type="button" value="Edit Selected Case" id="editCaseBut" />
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</td>
					<td align="right" width="5%">
						<cps:renderByResourceAccess resourceId="187" honorViewMode="${addNewCandidate.caseViewOverRide}">
							<jsp:attribute name="EXEC">
								<input type="button" value="Delete Selected Case" id="deleteBut" />
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</td>
				</tr>
			</table>
		</fieldset>
	</div>
	<br>
	<div id="selectedCaseDetails" style="display: none;"></div>
	<form:hidden path="productVO.classificationVO.productType" id="productType" styleId="productType" />
	<div id="details" style="display: block; margin-left: 10px;">
		<form:hidden path="productVO.classificationVO.commodity" id="commodity" styleId="commodity" />
		<form:hidden path="productVO.classificationVO.classDesc" id="classDesc" styleId="classDesc" />
		<fieldset style="width: 96%; margin-left: 10px; border-collapse: collapse;" id="f2">
			<legend id="caseDetailsLegend">Add New Case Details</legend>
			<!-- Table for Case Description, Channel, Catch Weight Sw. -->
			<table width="100%" border="0" bordercolor="red">
				<tr>
					<td align="right" width="19%">
						<label class="labelFont helpable" id="CaseDescriptionLabel">
							Case Description <em><font color="red"><b>*</b></font></em>
						</label>
					</td>
					<td align="left" width="18%">
						<c:choose>
							<c:when test="${caseVO eq null or caseVO.caseDescription eq ''}">
								<cps:renderByResourceAccess resourceId="81"
															honorViewMode="${addNewCandidate.caseViewOverRide}">
									<jsp:attribute name="EDIT">
										<form:input path="caseVO.caseDescription" id="caseDescriptionText"
													styleId="caseDescriptionText" style="TEXT-TRANSFORM: uppercase; dataType: alphanumeric;"
													cssClass="textFieldNormal" maxlength="30" tabindex="10"
													onblur="valdKeyPressSymbSpec(this);switchToUpperCase(this);return true;"
													value="${addNewCandidate.productVO.classificationVO.prodDescritpion}" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<form:input path="caseVO.caseDescription" id="caseDescriptionText"
													styleId="caseDescriptionText" cssClass="textFieldNormal"
													maxlength="30" tabindex="10" disabled="true"
													value="${addNewCandidate.productVO.classificationVO.prodDescritpion}" />
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</c:when>
							<c:otherwise>
								<cps:renderByResourceAccess resourceId="81"
															honorViewMode="${addNewCandidate.caseViewOverRide}">
									<jsp:attribute name="EDIT">
										<form:input path="caseVO.caseDescription" id="caseDescriptionText"
													styleId="caseDescriptionText" style="TEXT-TRANSFORM: uppercase; dataType: alphanumeric;"
													cssClass="textFieldNormal" maxlength="30" tabindex="10"
													onblur="valdKeyPressSymbSpec(this);switchToUpperCase(this);return true;" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<form:input path="caseVO.caseDescription" id="caseDescriptionText"
													styleId="caseDescriptionText" cssClass="textFieldNormal"
													maxlength="30" tabindex="10" disabled="true" />
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</c:otherwise>
						</c:choose>
					</td>
					<td width="11%" align="right">
						<label class="labelFont helpable" id="ChannelLabel">
							Channel <em><font color="red"><b>*</b></font></em>
						</label>
					</td>
					<td width="11%" align="left">
						<cps:renderByResourceAccess resourceId="83" honorViewMode="${addNewCandidate.caseViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:select path="dummyProperty" styleId="actions3" id="actions3"
											 onchange="onChannelChange(this); selectChannel();fillVendorDetails(); displayImportDiv();"
											 tabindex="15">
									<form:options items="${addNewCandidate.channels}" itemLabel="name" itemValue="id" />
							</form:select>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:select path="dummyProperty" styleId="actions3" id="actions3"
											 onchange="onChannelChange(this); selectChannel();fillVendorDetails(); displayImportDiv();"
											 tabindex="15" disabled="true">
									<form:options items="${addNewCandidate.channels}" itemLabel="name" itemValue="id" />
								</form:select>
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</td>
					<td align="right" width="19%">
						<div id="CatchWtSwLabelDiv" style="display: none;">
							<label class="labelFont helpable" id="CatchWtSwLabel">Catch Weight Sw</label>
						</div>
					</td>
					<td align="left" width="22%">
						<div id="catchRadioDiv" style="display: none;">&nbsp;&nbsp;
							<c:set var="catchChk" value=""></c:set>
							<c:if test="${caseVO.catchWeight eq true}">
								<c:set var="catchChk" value="checked='checked'"></c:set>
							</c:if>
							<cps:renderByResourceAccess resourceId="88"
														honorViewMode="${addNewCandidate.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="radio" name="upcradio" ${catchChk} tabindex="20" id="catchRadio" maxlength="1" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="radio" name="upcradio" ${catchChk} tabindex="20" id="catchRadio" maxlength="1" disabled="disabled" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</div>
					</td>
				</tr>
			</table>
			<!-- Table for Case Description, Channel, Catch Weight Sw. ENDS -->
			<!-- Table for Case UPC and None Btn -->
			<table width="100%" border="0">
				<tr>
					<td width="37%">
						<div id="caseUpcDiv" style="visibility: hidden; position: absolute;">
							<table width="100%" border="0">
								<tr>
									<td align="right" width="57%">
										<label class="labelFont helpable" id="CaseUPCLabel">
											Case UPC <em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="49%">
										<cps:renderByResourceAccess resourceId="79"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="caseVO.caseUPC" styleId="caseUpcText" id="caseUpcText"
															style="dataType: numeric;" cssClass="textFieldMedium"
															onblur="invalid0(this);"
															onkeyup="autotab(this,'caseCheckDigit');return true;"
															maxlength="13" tabindex="23" />
												<label for="selectedChannel" class="labelFont">-</label>
												<form:input tabindex="24" styleId="caseCheckDigit" id="caseCheckDigit"
															maxlength="1" style="dataType: numeric; width: 10px;"
															path="caseVO.caseChkDigit" size="1" onblur="verifyCheckDigit();" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="caseVO.caseUPC" styleId="caseUpcText" id="caseUpcText"
															style="dataType: numeric;" cssClass="textFieldMedium"
															onblur="invalid0(this);" maxlength="13" tabindex="23" disabled="true"
															onkeyup="autotab(this,'caseCheckDigit');return true;"/>
												<label for="selectedChannel" class="labelFont">-</label>
												<form:input styleId="caseCheckDigit" id="caseCheckDigit" maxlength="1"
															style="dataType: numeric; width: 10px;"
															path="caseVO.caseChkDigit" size="1" disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
								</tr>
							</table>
						</div>
					</td>
					<td width="22%"></td>
					<td width="19%" align="right">
						<div id="VariableWtSwLabelDiv" style="display: none;">
							<label class="labelFont helpable" id="VariableWtSwLabel">Variable Weight Sw </label>
						</div>
					</td>
					<td width="22%" align="left">
						<div id="variableRadioDiv" style="display: none;">&nbsp;&nbsp;
							<c:set var="variableChk" value=""></c:set>
							<c:if test="${caseVO.variableWeight eq true}">
								<c:set var="variableChk" value="checked='checked'"></c:set>
							</c:if>
							<cps:renderByResourceAccess resourceId="89"
														honorViewMode="${addNewCandidate.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="radio" name="upcradio" ${variableChk} tabindex="21" id="variableRadio" maxlength="1" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="radio" name="upcradio" ${variableChk} tabindex="21" id="variableRadio" maxlength="1" disabled="disabled" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2"></td>
					<td align="right" width="19%">
						<div id="NoneLabelDiv" style="display: none;">
							<label class="labelFont helpable" id="NoneLabel">None</label>
						</div>
					</td>
					<td align="left" width="22%">
						<div id="noneRadioDiv" style="display: none;"> &nbsp;&nbsp;
							<c:set var="noneChk" value=""></c:set>
							<c:if test="${caseVO.none eq true}">
								<c:set var="noneChk" value="checked='checked'"></c:set>
							</c:if>
							<cps:renderByResourceAccess resourceId="90" honorViewMode="${addNewCandidate.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="radio" name="upcradio" ${noneChk} tabindex="22" id="noneRadio" maxlength="1" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="radio" name="upcradio" ${noneChk} tabindex="22" id="noneRadio" maxlength="1" disabled="disabled" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</div>
					</td>
				</tr>
			</table>
			<!-- Table for Case UPC and None Btn ENDS -->
			<br />
			<table width="100%">
				<tr>
					<td width="17%">
						<div id="masterPackDiv" style="visibility: hidden; position: absolute;">
							<table width="100%">
								<tr>
									<td align="right" width="10%">
										<label class="labelFont helpable" id="MasterPackLabel">
											Master pack<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="7%">
										<cps:renderByResourceAccess resourceId="84" honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="caseVO.masterPack" id="masterPackText"
															styleId="masterPackText" maxlength="3" tabindex="35"
															cssClass="textFieldSmall" style="dataType: numeric; "
															onblur="calculateUnitCost();" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="caseVO.masterPack" id="masterPackText"
															styleId="masterPackText" maxlength="3" tabindex="35"
															cssClass="textFieldSmall" style="dataType: numeric;"
															disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
								</tr>
							</table>
						</div>
					</td>
					<td width="83%">
						<div id="whs_details" style="visibility: hidden; position: absolute;">
							<table width="100%" border="0">
								<tr>
									<td align="right" width="7%">
										<label class="labelFont helpable" id="MasterLengthLabel">
											Length<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="10%">
										<cps:renderByResourceAccess resourceId="91"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="caseVO.masterLength" id="masterLength"
															cssClass="textFieldSmall" maxlength="8" tabindex="40"
															styleId="masterLength" style="dataType: float;"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'length');"
															onblur="checkLength('master');calculateMasterCube(); check();return true;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="caseVO.masterLength" id="masterLength" disabled="true"
															cssClass="textFieldSmall" maxlength="8" tabindex="40"
															styleId="masterLength" style="dataType: float;"/>
											</jsp:attribute>
										</cps:renderByResourceAccess>
										<label for="selectedChannel" class="labelFont">in</label>
									</td>
									<td align="right" width="7%">
										<label class="labelFont helpable" id="MasterWidthLabel">
											Width<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="10%">
										<cps:renderByResourceAccess resourceId="92"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="caseVO.masterWidth" id="masterWidth"
															cssClass="textFieldSmall" maxlength="8" tabindex="45"
															styleId="masterWidth" style="dataType: float;"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'width');"
															onblur="checkWidth('master');calculateMasterCube(); check();return true;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="caseVO.masterWidth" id="masterWidth"
															cssClass="textFieldSmall" maxlength="8" tabindex="45"
															styleId="masterWidth" style="dataType: float;" disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
										<label for="selectedChannel" class="labelFont">in</label>
									</td>
									<td align="right" width="7%">
										<label class="labelFont helpable" id="MasterHeightLabel">
											Height<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="10%">
										<cps:renderByResourceAccess resourceId="93"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="caseVO.masterHeight" id="masterHeight"
															styleId="masterHeight" style="dataType: float;"
															cssClass="textFieldSmall" maxlength="8" tabindex="50"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'height');"
															onblur="checkHeight('master');calculateMasterCube();check();return true;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="caseVO.masterHeight" id="masterHeight"
															styleId="masterHeight" style="dataType: float;"
															cssClass="textFieldSmall" maxlength="8" tabindex="50"
															disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
										<label for="selectedChannel" class="labelFont">in</label>
									</td>
									<td align="right" width="5%">
										<label class="labelFont helpable" id="MasterLabel">Cube</label>
									</td>
									<td align="left" width="10%">&nbsp;&nbsp;
										<label id="masterCubeLabel" class="labelFont">${caseVO.masterCubeFormatted}</label>
										<label for="selectedChannel" class="labelFont"> cu.ft</label>
									</td>
									<td align="right" width="7%">
										<label class="labelFont helpable " id="MasterWeightLabel">
											Weight<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="10%">
										<cps:renderByResourceAccess resourceId="95" honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="caseVO.masterWeight" id="masterWeight"
															cssClass="textFieldSmall" maxlength="8" tabindex="55"
															styleId="masterWeight" style="dataType: float;"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'weight');"
															onblur="chekDecimalValue(this, 2);check();return true;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="caseVO.masterWeight" id="masterWeight"
															cssClass="textFieldSmall" maxlength="8" tabindex="55"
															styleId="masterWeight" style="dataType: float;"
															disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<!-- FIRST ROW ENDS -->
				<tr>
					<td width="17%">
						<div id="whs_details1" style="visibility: hidden; position: absolute;">
							<div id="shipPackDiv" style="visibility: hidden; position: absolute;">
								<table width="100%" border="0">
									<tr>
										<td align="right" width="10%">
											<label class="labelFont helpable" id="ShipPackLabel">
												Ship Pack<em><font color="red"><b>*</b></font></em>
											</label>
										</td>
										<td align="left" width="7%">
											<cps:renderByResourceAccess resourceId="85"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<form:input path="caseVO.shipPack" cssClass="textFieldSmall"
																id="shipPackText" maxlength="3" tabindex="60"
																styleId="shipPackText" style="dataType: numeric;"
																onblur=" check(); calculateUnitCost();" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:input path="caseVO.shipPack" cssClass="textFieldSmall"
																id="shipPackText" maxlength="3" tabindex="60"
																styleId="shipPackText" style="dataType: numeric;" disabled="true" />
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</td>
					<td width="83%">
						<div id="whs_details2" style="visibility: hidden; position: absolute;">
							<table width="100%" border="0">
								<tr>
									<td align="right" width="7%">
										<label class="labelFont helpable" id="ShipPackLengthLabel">
											Length<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="10%">
										<cps:renderByResourceAccess resourceId="96"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="caseVO.shipLength" id="shipLength"
															cssClass="textFieldSmall" maxlength="8" tabindex="75"
															styleId="shipLength" style="dataType: float;"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'length');"
															onblur="checkLength('ship');calculateShipCube();validateShip('Length');return true;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="caseVO.shipLength" id="shipLength"
															cssClass="textFieldSmall" maxlength="8" tabindex="75"
															styleId="shipLength" style="dataType: float;" disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
										<label for="selectedChannel" class="labelFont">in</label>
									</td>
									<td align="right" width="7%">
										<label class="labelFont helpable" id="ShipPackWidthLabel">
											Width<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="10%">
										<cps:renderByResourceAccess resourceId="97" honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="caseVO.shipWidth" id="shipWidth" cssClass="textFieldSmall"
															maxlength="8" tabindex="80" styleId="shipWidth" style="dataType: float;"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'width');"
															onblur="checkWidth('ship');calculateShipCube();validateShip('Width');return true;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="caseVO.shipWidth" id="shipWidth" cssClass="textFieldSmall"
															maxlength="8" tabindex="80" styleId="shipWidth" style="dataType: float;"
															disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
										<label for="selectedChannel" class="labelFont">in</label>
									</td>
									<td align="right" width="7%">
										<label class="labelFont helpable" id="ShipPackHeightLabel">
											Height<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="10%">
										<cps:renderByResourceAccess resourceId="98" honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="caseVO.shipHeight" styleId="shipHeight" id="shipHeight"
															cssClass="textFieldSmall" maxlength="8" tabindex="85"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'height');"
															onblur="checkHeight('ship');calculateShipCube();validateShip('Height');return true;"
															style="dataType: float;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="caseVO.shipHeight" styleId="shipHeight" id="shipHeight"
															cssClass="textFieldSmall" maxlength="8" tabindex="85"
															style="dataType: float;" disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
										<label for="selectedChannel" class="labelFont">in</label>
									</td>
									<td align="right" width="5%">
										<label class="labelFont helpable" id="ShipLabel">Cube</label>
									</td>
									<td align="left" width="10%">&nbsp;&nbsp;
										<label class="labelFont" id="shipCubeLabel">${caseVO.shipCubeFormatted}</label>
										<label for="selectedChannel" class="labelFont"> cu.ft</label>
									</td>
									<td align="right" width="7%">
										<label class="labelFont helpable" id="ShipWeightLabel">
											Weight<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="10%">
										<cps:renderByResourceAccess resourceId="100"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="caseVO.shipWeight" id="shipWeight" cssClass="textFieldSmall"
															maxlength="10" tabindex="90" onkeydown="return onKeyDownRestrictDecimal(event, this, 'weight');"
															styleId="shipWeight" style="dataType: float;"
															onblur="chekDecimalValue(this, 2);return true;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="caseVO.shipWeight" id="shipWeight" cssClass="textFieldSmall"
															maxlength="10" tabindex="90" styleId="shipWeight" style="dataType: float;"
															disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<!-- SECOND ROW ENDS -->
				<tr>
					<!--  UNIT FACTOR.... -->
					<td width="17%">
						<div id="whs_details3" style="visibility: hidden; position: absolute;">
							<table width="100%" border="0">
								<tr>
									<td align="right" width="10%">
										<label class="labelFont helpable" id="UnitFactorLabel">Unit Factor</label>
									</td>
									<td align="left" width="7%">
										<cps:renderByResourceAccess resourceId="101"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="caseVO.unitFactor" id="unitFactor" cssClass="textFieldSmall"
															maxlength="7" tabindex="95" styleId="unitFactor" style="dataType: float;"
															onblur="roundValue(this,3);return true;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="caseVO.unitFactor" id="unitFactor"
															cssClass="textFieldSmall" maxlength="7" tabindex="95"
															styleId="unitFactor" style="dataType: float;"
															disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
								</tr>
							</table>
						</div>
					</td>
					<td width="83%">
						<div id="whs_details4" style="visibility: hidden; position: absolute;">
							<table width="100%" border="0">
								<tr>
									<td align="right" width="7%">
										<cps:renderByResourceAccess resourceId="243"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<label class="labelFont helpable" id="MaxShipLabel">Max Ship</label>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<label class="labelFont helpable" id="MaxShipLabel">Max Ship</label>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td width="10%" align="left" colspan="2">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="243"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="caseVO.maxShip" cssClass="textFieldSmall"
															id="maxShipText" maxlength="5" tabindex="100" styleId="maxShipText"
															style="dataType: numeric;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="caseVO.maxShip" cssClass="textFieldSmall"
															id="maxShipText" maxlength="3" tabindex="100" styleId="maxShipText"
															style="dataType: numeric;" disabled="true" />
											</jsp:attribute>
											<jsp:attribute name="NONE">
												<form:input path="caseVO.maxShip" cssClass="textFieldSmall"
															id="maxShipText" maxlength="3" tabindex="100" styleId="maxShipText"
															style="dataType: numeric; display:none;" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="15%">
										<cps:renderByResourceAccess resourceId="245"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<label class="labelFont helpable" id="PurchaseStatusLabel">Purchase Status</label>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<label class="labelFont helpable" id="PurchaseStatusLabel">Purchase Status</label>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="left" width="15%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="245"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:select path="caseVO.purchaseStatus" tabindex="103" id="purchaseStatus"
															 styleId="purchaseStatus" cssClass="selectBoxStyle"
															 style="dataType: alpha;">
													<form:options items="${addNewCandidate.caseVO.purchaseStatusList}"
																  itemLabel="name" itemValue="id"/>
												</form:select>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:select path="caseVO.purchaseStatus" tabindex="103" id="purchaseStatus"
															 styleId="purchaseStatus" cssClass="selectBoxStyle"
															 style="dataType: alpha;" disabled="true">
													<form:options items="${addNewCandidate.caseVO.purchaseStatusList}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
											<jsp:attribute name="NONE">
												<form:select path="caseVO.purchaseStatus" tabindex="103"
															 id="purchaseStatus" styleId="purchaseStatus" cssClass="selectBoxStyle"
															 style="dataType: alpha; visibility:hidden;" disabled="true">
													<form:options items="${addNewCandidate.caseVO.purchaseStatusList}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td width="40%" />
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<!--  THIRD ROW ENDS -->
				<tr>
					<td width="100%" colspan="2">
						<div id="whs_details5" style="visibility: hidden; position: absolute;">
							<table width="100%">
								<tr>
									<td width="9%" align="right">
										<cps:renderByResourceAccess resourceId="105" honorViewMode="${addNewCandidate.caseViewOverRide}">
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
										<cps:renderByResourceAccess resourceId="105" honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:checkbox path="caseVO.codeDate" styleId="codeDate" id="codeDate"
															   tabindex="105" onclick="checkedCodeDate();"/>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:checkbox path="caseVO.codeDate" styleId="codeDate" id="codeDate"
															   tabindex="105" disabled="true"/>
											</jsp:attribute>
											<jsp:attribute name="NONE">
												<form:checkbox path="caseVO.codeDate" styleId="codeDate" id="codeDate"
															   tabindex="105" style="display:none;"/>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<!-- 4th ROW ENDS -->
				<tr>
					<td width="100%" colspan="2">
						<div id="whs_details6" style="visibility: hidden; position: absolute;">
							<div id="codeDateDiv" style="visibility: hidden; position: absolute;">
								<table width="100%">
									<tr align="left">
										<td align="right" width="13%">
											<cps:renderByResourceAccess resourceId="106"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<label class="labelFont helpable" id="MaxShelfLabel">
														Max Shelf Life Days<em><font color="red"><b>*</b></font></em>
													</label>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<label class="labelFont helpable" id="MaxShelfLabel">
														Max Shelf Life Days<em><font color="red"><b>*</b></font></em>
													</label>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="left" width="10%">&nbsp;
											<cps:renderByResourceAccess resourceId="106"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<form:input path="caseVO.maxShelfLifeDays" id="shelfDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="110"
																styleId="shelfDays" style="dataType: numeric;" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:input path="caseVO.maxShelfLifeDays" id="shelfDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="110"
																styleId="shelfDays" style="dataType: numeric;"
																disabled="true" />
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="right" width="17%">
											<cps:renderByResourceAccess resourceId="107"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<label class="labelFont helpable" id="InboundLabel">
														Inbound Specification Days<em><font color="red"><b>*</b></font></em>
													</label>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<label class="labelFont helpable" id="InboundLabel">
														Inbound Specification Days<em><font color="red"><b>*</b></font></em>
													</label>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="left" width="10%">&nbsp;
											<cps:renderByResourceAccess resourceId="107"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<form:input path="caseVO.inboundSpecificationDays" id="inboundDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="115"
																styleId="inboundDays" style="dataType: numeric;" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:input path="caseVO.inboundSpecificationDays" id="inboundDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="115"
																styleId="inboundDays" style="dataType: numeric;"
																disabled="true" />
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="right" width="10%">
											<cps:renderByResourceAccess resourceId="108"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<label class="labelFont helpable" id="ReactionLabel">
														Reaction	Days <em><font color="red"><b>*</b></font></em>
													</label>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<label class="labelFont helpable" id="ReactionLabel">
														Reaction	Days <em><font color="red"><b>*</b></font></em>
													</label>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="left" width="10%">&nbsp;
											<cps:renderByResourceAccess resourceId="108"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<form:input path="caseVO.reactionDays" id="reactionDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="120"
																styleId="reactionDays" style="dataType: numeric;" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:input path="caseVO.reactionDays" id="reactionDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="120"
																styleId="reactionDays" style="dataType: numeric;"
																disabled="true" />
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="right" width="17%">
											<cps:renderByResourceAccess resourceId="109"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<label class="labelFont helpable" id="GuranteeLabel">
														Guarantee to Store Days<em><font color="red"><b>*</b></font></em>
													</label>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<label class="labelFont helpable" id="GuranteeLabel">
														Guarantee to Store Days<em><font color="red"><b>*</b></font></em>
													</label>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="left" width="10%">&nbsp;
											<cps:renderByResourceAccess resourceId="109"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<form:input path="caseVO.guaranteetoStoreDays" id="guaranteestoreDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="125"
																styleId="guaranteestoreDays" style="dataType: numeric;" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:input path="caseVO.guaranteetoStoreDays" id="guaranteestoreDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="125"
																styleId="guaranteestoreDays" style="dataType: numeric;"
																disabled="true" />
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</td>
				</tr>
				<!--  5th ROW ENDS -->
				<tr>
					<td width="100%" colspan="2" align="left">
						<div id="whs_details7" style="visibility: hidden; position: absolute;">
							<div id="oneTuchTypeDiv" style="visibility: hidden; position: absolute;">
								<table width="100%" align="left">
									<tr>
										<cps:renderByResourceAccess resourceId="110"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<td align="right" width="10%">
													<label class="labelFont helpable" id="OneTouchLabel">1-Touch</label>
												</td>
												<td width="30%" align="left" colspan="2">&nbsp;&nbsp;
													<form:select path="caseVO.oneTouch" tabindex="130" id="oneTouchType"
																 styleId="oneTouchType" cssClass="selectBoxStyle">
														<form:options items="${addNewCandidate.caseVO.touchTypeList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</td>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<td align="right" width="10%">
													<label class="labelFont helpable" id="OneTouchLabel">1-Touch</label>
												</td>
												<td width="30%" align="left" colspan="2">&nbsp;&nbsp;
													<form:select path="caseVO.oneTouch" tabindex="130" id="oneTouchType"
																 disabled="true" styleId="oneTouchType" cssClass="selectBoxStyle">
														<form:options items="${addNewCandidate.caseVO.touchTypeList}"
																	  itemLabel="name" itemValue="id"/>
													</form:select>
												</td>
											</jsp:attribute>
											<jsp:attribute name="NONE">
												<td width="30%" align="left" colspan="2" style="visibility: hidden;">&nbsp;&nbsp;
													<form:select path="caseVO.oneTouch" tabindex="130" disabled="true"
																 styleId="oneTouchType" id="oneTouchType" cssClass="selectBoxStyle">
														<form:options items="${addNewCandidate.caseVO.touchTypeList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</td>
											</jsp:attribute>
										</cps:renderByResourceAccess>
										<cps:renderByResourceAccess resourceId="242"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<td align="right" width="10%">
													<label class="labelFont helpable" id="ItemCategoryLabel">
														Item Category<em><font color="red"><b>*</b></font></em>
													</label>
												</td>
												<td width="30%" align="left" colspan="2">&nbsp;&nbsp;
													<form:select path="caseVO.itemCategory" tabindex="130" id="itmCategory"
																 styleId="itmCategory" cssClass="selectBoxStyle">
														<form:options items="${addNewCandidate.caseVO.itemCategoryList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</td>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<td align="right" width="10%">
													<label class="labelFont helpable" id="ItemCategoryLabel">
														Item Category<em><font color="red"><b>*</b></font></em>
													</label>
												</td>
												<td width="30%" align="left" colspan="2">&nbsp;&nbsp;
													<form:select path="caseVO.itemCategory" tabindex="130" id="itmCategory"
																 disabled="true" styleId="itmCategory" cssClass="selectBoxStyle">
														<form:options items="${addNewCandidate.caseVO.itemCategoryList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</td>
											</jsp:attribute>
											<jsp:attribute name="NONE">
												<td width="30%" align="left" colspan="2" style="visibility: hidden;">&nbsp;&nbsp;
													<form:select path="caseVO.itemCategory" tabindex="130" id="itmCategory"
																 disabled="true" styleId="itmCategory" cssClass="selectBoxStyle">
														<form:options items="${addNewCandidate.caseVO.itemCategoryList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</td>
											</jsp:attribute>
										</cps:renderByResourceAccess>
										<td align="right"></td>
									</tr>
								</table>
							</div>
						</div> &nbsp;&nbsp; &nbsp;&nbsp;
					</td>
				</tr>
				<!-- Display Ready Unit  -->
				<tr>
					<td width="100%" colspan="2" align="left">
						<div id="displayReadyUnitDiv" style="visibility: hidden; position: absolute;">
							<table width="100%" align="left">
								<tr>
									<td width="15%" valign="top" align="right">
										<label class="labelFont helpable" id="displayReadyUnitlabel">Display Ready Unit</label>
										<c:if test="${addNewCandidate.sessionVO.questionnarieVO.selectedOption == 4}">
											<form:checkbox path="caseVO.dsplyDryPalSw" id="dsplyDryPalSwId"
														   styleId="dsplyDryPalSwId"
														   onclick="displayReadyUnitClick();" disabled="true"/>
										</c:if>
										<c:if test="${addNewCandidate.sessionVO.questionnarieVO.selectedOption != 4}">
											<form:checkbox path="caseVO.dsplyDryPalSw" id="dsplyDryPalSwId"
														   styleId="dsplyDryPalSwId" onclick="displayReadyUnitClick();"/>
										</c:if>
									</td>
									<td width="85%">
										<div id="displayReadyfieldset" style="visibility: hidden; position: absolute;">
											<fieldset style="width: 90%">
												<table width="100%">
													<tr>
														<td width="55%" valign="top">
															<div id="typeDisplayReadyUnitId" style="visibility: hidden; position: absolute;">
																<table width="100%">
																	<tr>
																		<td width="50%" align="right">
																			<label class="labelFont helpable" id="typeDisplayReadyUnitlabel">
																				Type Of Display Ready Unit ?<em><font color="red"><b>*</b></font></em>
																			</label>
																		</td>
																		<td width="50%" align="left">
																			<form:select path="caseVO.srsAffTypCd"
																						 id="srsAffTypCdId"
																						 styleId="srsAffTypCdId" cssClass="selectBoxStyle"
																						 onchange="onReadyUnitChange(this);">
																				<form:options items="${addNewCandidate.caseVO.readyUnits}"
																							  itemLabel="name" itemValue="id" />
																			</form:select>
																		</td>
																	</tr>
																</table>
															</div>
														</td>
														<td width="45%" valign="top">
															<div id="typeDisplayReadyUnitValue" style="visibility: hidden; position: absolute;">
																<table width="100%">
																	<tr>
																		<td width="50%" align="left">
																			<label class="labelFont helpable" id="rowFactRetailsUnitId">
																				Rows Facing in Retail Units <em><font color="red"><b>*</b></font></em>
																			</label>
																		</td>
																		<td width="50%">
																			<form:input path="caseVO.prodFcngNbr" id="prodFcngNbrId"
																						cssClass="textFieldSmall" maxlength="4"
																						styleId="prodFcngNbrId" style="dataType: numeric;" />
																		</td>
																	</tr>
																	<tr>
																		<td width="50%" align="left">
																			<label class="labelFont helpable" id="rowDeepRetailsUnitId">
																				Rows Deep in Retail Units <em><font color="red"><b>*</b></font></em>
																			</label>
																		</td>
																		<td width="50%">
																			<form:input path="caseVO.prodRowDeepNbr"
																						id="prodRowDeepNbrId"
																						cssClass="textFieldSmall" maxlength="4"
																						styleId="prodRowDeepNbrId"
																						style="dataType: numeric;" />
																		</td>
																	</tr>
																	<tr>
																		<td width="50%" align="left">
																			<label class="labelFont helpable" id="rowHigtRetailsUnitId">
																				Rows High in Retail Units <em><font color="red"><b>*</b></font></em>
																			</label>
																		</td>
																		<td width="50%">
																			<form:input path="caseVO.prodRowHiNbr"
																						id="prodRowHiNbrId"
																						cssClass="textFieldSmall" maxlength="4"
																						styleId="prodRowHiNbrId" style="dataType: numeric;" />
																		</td>
																	</tr>
																	<tr>
																		<td width="50%" align="left">
																			<label class="labelFont helpable" id="orientationOfDrp">
																				Orientation Of DRP <em><font color="red"><b>*</b></font></em>
																			</label>
																		</td>
																		<td width="50%">
																			<form:select path="caseVO.nbrOfOrintNbr" id="nbrOfOrintNbrId"
																						 styleId="nbrOfOrintNbrId"
																						 cssClass="selectBoxStyleOrientationDRU">
																				<form:options items="${addNewCandidate.caseVO.orientations}"
																							  itemLabel="name" itemValue="id" />
																			</form:select>
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
			</table>

			<fieldset style="width: 100%;" id="f4">
				<legend onclick="toggleAssoctdUPC('f4');" style="cursor: pointer;">
					<img src="${expnd}" id="aUPCImg">Applicable UPC's
				</legend>
				<div id="associatedUPC" style="margin-left: 10px;">
					<table id="applicableUPCs" align="center" width="100%" border="0"
						   cellspacing="0" cellpadding="2" class="dataGrid">
						<tbody id="upcTable">
						<tr>
							<td class="dataGridHead" align="left" class="labelFont" width="20%">UPC</td>
							<td class="dataGridHead" align="left" class="labelFont" width="20%">Unit Size</td>
							<td class="dataGridHead" align="left" class="labelFont" width="20%">Unit of Measure</td>
							<td class="dataGridHead" class="labelFont" align="left" width="20%">Link</td>
							<td class="dataGridHead" class="labelFont" align="left" width="20%">
								<em><font color="red"><b>*</b></font></em>Primary
							</td>
						</tr>
						<c:set var="cnt" value="'a'"></c:set>
						<c:forEach items="${addNewCandidate.caseVO.caseUPCVOs}" var="upc" varStatus="loop" >
							<tr class="labelFont">
								<td align="left" width="20%" class="row${loop.index % 2}">
									<c:choose>
										<c:when test="${upc.negative eq true}">
											<font class="labelFont">004_Item_Code</font>
										</c:when>
										<c:otherwise>
											<font class="labelFont">
												<c:out value="${upc.unitUpc}"></c:out>
											</font>
										</c:otherwise>
									</c:choose>
								</td>
								<td align="left" width="20%" class="row${loop.index % 2}">
									<font class="labelFont">
										<c:out value="${upc.unitSize}"></c:out>
									</font>
								</td>
								<td align="left" width="20%" class="row${loop.index % 2}">
									<input type="hidden" id="caseUPCId${loop.index}" value="${upc.unitUpc}" />
									<font class="labelFont">
										<c:out value="${upc.unitMeasureDesc}"></c:out>
									</font>
								</td>
								<td align="left" width="20%" class="row${loop.index}">
									<cps:renderByResourceAccess resourceId="114"
																honorViewMode="${addNewCandidate.caseViewOverRide}">
										<jsp:attribute name="EDIT">
											<c:set var="disabled" value=""></c:set>
											<c:if test="${addNewCandidate.userRole eq 'SCMAN'}">
												<c:set var="disabled" value='disabled="disabled"'></c:set>
											</c:if>
											<input type="checkbox" id="upcCaseCheck${loop.index}" ${disabled}
												   onclick="enableRadioBut(${loop.index},'');" />
										</jsp:attribute>
									<jsp:attribute name="VIEW">
										<c:set var="disabled" value=""></c:set>
										<c:if test="${(addNewCandidate.upcViewOverRide eq false && upc.editable) || addNewCandidate.viewMode eq true}">
											<c:set var="disabled" value='disabled="disabled"'></c:set>
										</c:if>
										<input type="checkbox" id="upcCaseCheck${loop.index}" ${disabled}
											   onclick="enableSaveCaseBut(this);" />
									</jsp:attribute>
									</cps:renderByResourceAccess>
								</td>
								<td align="left" width="20%" class="row${loop.index % 2}">
									<cps:renderByResourceAccess resourceId="115" honorViewMode="${addNewCandidate.caseViewOverRide}">
										<jsp:attribute name="EDIT">
											<input type="radio" name="applUpcLink" id="caseUPCRadio${loop.index}" disabled="disabled" />
										</jsp:attribute>
										<jsp:attribute name="VIEW">
											<input type="radio" name="applUpcLink" id="caseUPCRadio${loop.index}" disabled="disabled" />
										</jsp:attribute>
									</cps:renderByResourceAccess>
								</td>
							</tr>
							<c:set var="cnt" value="${loop.index}"></c:set>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</fieldset>
			<table width="100%" border="0" cellspacing="0" cellpadding="2" id="caseButtonTable">
				<tr>
					<td align="right" width="98%">
						<div id="buttonHolder_NotInUse">
							<cps:renderByResourceAccess resourceId="189"
														honorViewMode="${addNewCandidate.caseViewOverRide}">
								<jsp:attribute name="EXEC">
									<input type="button" value="Save Case" id="AVupc" tabindex="135" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</div>
					</td>
					<td align="right" width="2%">
						<c:if test="${addNewCandidate.viewMode eq false}">
							<input type="button" id="cancelBut" value="Cancel" />
						</c:if>
					</td>
				</tr>
			</table>
			<a id="sec2tion"></a>
		</fieldset>
		<br> <br>
		<!-- Vendor starts -->
		<fieldset style="width: 96%; margin-left: 10px;" id="f5">
			<legend onclick="toggleVendor('f5');" style="cursor: pointer;">
				<img src="${expnd}" id="vendorImg">Existing Vendors
			</legend>
			<div id="existingVendors" style="min-width: 0;">
				<table width="100%" cellspacing="0" id="existingVendorsTable">
					<tbody id="vendorTable">
					<tr>
						<td class="dataGridHead" align="center" class="labelFont" width="25%">Vendor</td>
						<td class="dataGridHead" align="left" class="labelFont" width="10%">VPC</td>
						<td class="dataGridHead" align="center" class="labelFont" width="5%">Guaranteed Sale?</td>
						<td class="dataGridHead" class="labelFont" align="center" width="5%">Deal Offered?</td>
						<td class="dataGridHead" class="labelFont" align="left" width="5%">List Cost</td>
						<td class="dataGridHead" class="labelFont" align="left" width="15%">Cost Owner</td>
						<td class="dataGridHead" class="labelFont" align="left" width="15%">Top 2 Top</td>
						<td class="dataGridHead" class="labelFont" align="left" width="15%">Country of Origin</td>
						<td class="dataGridHead" class="labelFont" align="center" width="5%">Channel</td>
						<td class="dataGridHead" align="left" width="1%"></td>
					</tr>
					<c:set var="cnt" value="-1"></c:set>
					<c:if test="${selectedCaseVO != null}">
						<c:forEach items="${selectedCaseVO.vendorVOs}" var="vendor" varStatus="loop">
							<tr class="row${loop.index%2}" id="vendorRow${loop.index}"
								onclick="makeRowClickedForTable('vendorTable','vendorRow${loop.index}','${loop.index}','#FFAA00');
								displayVendorDetails('${loop.index}');getVendorChannelTypeNormal();" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">
								<td align="left" width="25%" class="row${loop.index%2}">
									<font class="labelFont">
										<c:out value="${vendor.vendorLocation}"></c:out>
									</font>
								</td>
								<td align="left" width="10%" class="row${loop.index%2}">
									<font class="labelFont">
										<c:out value="${vendor.vpc}"></c:out>
									</font>
								</td>
								<td align="left" width="5%" class="row${loop.index%2}">
									<input type="checkbox" disabled="disabled">
									<input type="hidden" id="vendorUniq${loop.index}" value="${vendor.uniqueId}" />
								</td>
								<td align="left" width="5%" class="row${loop.index%2}">
									<input type="checkbox" disabled="disabled">
								</td>
								<td align="left" width="5%" class="row${loop.index%2}">
									<font class="labelFont">
										<c:out value="${vendor.listCostFormatted}"></c:out>
									</font>
								</td>
								<td align="left" width="15%" class="row${loop.index%2}">
									<font class="labelFont">
										<c:out value="${vendor.costOwner}"></c:out>
									</font>
								</td>
								<td align="left" width="15%" class="row${loop.index%2}">
									<font class="labelFont">
										<c:out value="${vendor.top2Top}"></c:out>
									</font>
								</td>
								<td align="left" width="15%" class="row${loop.index%2}">
									<font class="labelFont">
										<c:out value="${vendor.countryOfOrigin}"></c:out>
									</font>
								</td>
								<td align="left" width="5%" class="row${loop.index%2}">
									<font class="labelFont">
										<c:out value="${vendor.channel}"></c:out>
									</font>
								</td>
								<td align="left" width="1%" class="row${loop.index%2}"></td>
							</tr>
							<c:set var="cnt" value="${loop.index}"></c:set>
						</c:forEach>
					</c:if>
					<c:if test="${cnt == -1}">
						<tr id="noVendorDiv">
							<td width="100%" align="center" colspan="13">
								<div style="position: relative; min-width: 0;">No Vendors to Show!! Please add vendors</div>
							</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
			<table width="95%">
				<tr>
					<td width="85%" align="right">
						<cps:renderByResourceAccess resourceId="189"
													honorViewMode="${addNewCandidate.caseViewOverRide}">
							<jsp:attribute name="EXEC">
								<input type="button" id="addCaseDetailsBut" value="Add Vendor" tabindex="140" />
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</td>
					</td>
					<td width="15%" align="right">
						<div id="editVendorDetailsButDiv" style="display: none;">
							<cps:renderByResourceAccess resourceId="190"
														honorViewMode="${addNewCandidate.caseViewOverRide}">
								<jsp:attribute name="EXEC">
									<input type="button" id="editVendorDetailsBut" value="Edit Selected Vendor" tabindex="141" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</div>
					</td>
					<td width="10%" align="left">
						<div id="deleteVendorDetailsButDiv" style="display: none;">
							<cps:renderByResourceAccess resourceId="190"
														honorViewMode="${addNewCandidate.caseViewOverRide}">
								<jsp:attribute name="EXEC">
									<input type="button" id="deleteVendorDetailsBut" value="Delete Selected Vendor" tabindex="145" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</div>
					</td>
				</tr>
			</table>
		</fieldset>
		<br /> <br />
		<div id="selectedvendorDetailsDiv" style="position: relative; min-width: 0;"></div>
		<div id="vendorDetailsDiv" style="position: relative; min-width: 0;">
			<fieldset style="width: 96%; margin-left: 5px; margin-right: 5px; border-collapse: collapse;" id="vendorDetailsFieldSet">
				<legend>Add New Vendor Details</legend>
				<table width="95%" border="0">
					<tr>
						<td width="100%" align="center">
							<table width="100%" border="0">
								<!-- 958 changes -->
								<tr align="left">
									<td align="right" width="12%">&nbsp;
										<div id="subDeptLabelDiv" style="display: none; position: relative; min-width: 0;">
											<cps:renderByResourceAccess resourceId="257"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<label class="labelFont helpable" id="SubDeptLabel">Sub-Dept </label>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<label class="labelFont helpable" id="SubDeptLabel">Sub-Dept </label>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</div>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<div id="subDeptDiv" style="display: none; position: relative; min-width: 0;">
											<cps:renderByResourceAccess resourceId="257"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<input type="text" id="subDept" maxlength="3" tabindex="146"
														   class="textFieldNormal" style="TEXT-TRANSFORM: uppercase; dataType: alphanumericOnly;" value="${addNewCandidate.defaultSubDept}"
														   onblur="validateSubDept();" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<input type="hidden" value="${addNewCandidate.caseViewOverRide}" id="viewMode">
													<input type="text" id="subDept" maxlength="3" tabindex="146"
														   class="textFieldNormal" style="dataType: alphanumericOnly;" disabled="disabled"
														   value="${addNewCandidate.defaultSubDept}" />
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</div> <!-- 958 PSS changes -->
									<td align="right" width="12%">&nbsp;
										<div id="vendPSSLabelDiv" style="display: none; position: relative; min-width: 0;">
											<cps:renderByResourceAccess resourceId="259"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
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
										<div id="vendPSSDiv" style="display: none; position: relative; min-width: 0;">
											<cps:renderByResourceAccess resourceId="259"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<form:select path="productVO.pointOfSaleVO.pssDept" id="vendPssDept"
																 tabindex="147" styleId="vendPssDept" cssClass="selectBoxStyle2"
																 disabled="true">
														<form:options items="${addNewCandidate.pssList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:select path="productVO.pointOfSaleVO.pssDept" id="vendPssDept"
																 tabindex="147" styleId="vendPssDept" cssClass="selectBoxStyle2" disabled="true">
														<form:options items="${addNewCandidate.pssList}"
																	  itemLabel="name" itemValue="id"/>
													</form:select>
												</jsp:attribute>
												<jsp:attribute name="NONE">
													<form:select path="productVO.pointOfSaleVO.pssDept" id="vendPssDept"
																 tabindex="147" styleId="vendPssDept"
																 cssClass="selectBoxStyle2" style="display:none;"
																 disabled="true">
														<form:options items="${addNewCandidate.pssList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</div>
									</td>
								</tr>
								<!-- 958 changes ends -->
								<tr align="left">
									<td align="right" width="12%">
										<label class="labelFont helpable" id="VendorLabel">
											Vendor <em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="12%" colspan="3">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="116" honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<cps:autoCompleteVendor searchAction="vendorSearch"
																		uniqueId="vendor" compWidth="80%" tabIdx="150"
																		elmProperty="vendorVO.vendorLocationVal"
																		elmName="vendorVO.vendorLocation" highlightMatch="true"
																		maxResults="999" searchOnId="true" showId="true" zi="9000"
																		maxCacheEntries="0"
																		onSelectMethod2="checkBicepInLstBicep"
																		onSelectMethod="getVendorChannelTypeNormal"
																		onSelectMethod1="resetDataCostlistAndListCostChangeVendor" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<input type="hidden" id="vendorLocationVal" />
												<input type="text" id="vendorLocation" disabled="disabled" style="width: 80%;" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="12%">
										<label class="labelFont helpable" id="VPCLabel">
											VPC <em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="78"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<input type="text" id="vpc" maxlength="20" tabindex="155" class="textFieldNormal"
													   style="TEXT-TRANSFORM: uppercase; dataType: alphanumericSpecialOnly;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<input type="text" id="vpc" maxlength="20" tabindex="155"
													   class="textFieldNormal" style="dataType: alphanumericOnly;" disabled="disabled" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td colspan="2">
										<table>
											<tr>
												<td align="right">
													<label class="labelFont helpable" id="GuranteedSaleLabel">Guaranteed Sale?</label>
												</td>
												<td>&nbsp;&nbsp;
													<cps:renderByResourceAccess resourceId="118"
																				honorViewMode="${addNewCandidate.caseViewOverRide}">
														<jsp:attribute name="EDIT">
															<input type="checkbox" id="gSales" tabindex="160" size="1" />
														</jsp:attribute>
														<jsp:attribute name="VIEW">
															<input type="checkbox" id="gSales" tabindex="160" size="1" disabled="disabled" />
														</jsp:attribute>
													</cps:renderByResourceAccess>
												</td>
											</tr>
											<tr>
												<td align="right">
													<label class="labelFont helpable" id="DealOfferedLabel">Deal Offered?</label>
												</td>
												<td>&nbsp;&nbsp;
													<cps:renderByResourceAccess resourceId="119"
																				honorViewMode="${addNewCandidate.caseViewOverRide}">
														<jsp:attribute name="EDIT">
															<input type="checkbox" id="dealOffered" tabindex="165" size="1" />
														</jsp:attribute>
														<jsp:attribute name="VIEW">
															<input type="checkbox" id="dealOffered" tabindex="165" size="1" disabled="disabled" />
														</jsp:attribute>
													</cps:renderByResourceAccess>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr align="left">
									<td align="right" width="12%">
										<div id="venTie" style="display: block;">
											<label class="labelFont helpable" id="VendorTieLabel">
												Vendor Tie <em><font color="red"><b>*</b></font></em>
											</label>
										</div>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<div id="venTieText" style="display: block;">
											<cps:renderByResourceAccess resourceId="102"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<input type="text" id="vendorTie" maxlength="6" tabindex="175"
														   class="textFieldMedium" value="" style="dataType: numeric;"
														   onblur="validateNumber(this,'Vendor Tie'); return true;" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<input type="text" id="vendorTie" maxlength="6" tabindex="175"
														   class="textFieldMedium" value="" style="dataType: numeric;" disabled="disabled" />
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</div>
									</td>
									<td align="right" width="12%">
										<div id="venTier" style="display: block;">
											<label class="labelFont helpable" id="VendorTierLabel">
												Vendor Tier<em><font color="red"><b>*</b></font></em>
											</label>
										</div>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<div id="venTierText" style="display: block;">
											<cps:renderByResourceAccess resourceId="103"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<input type="text" id="vendorTier" maxlength="6" tabindex="180"
														   class="textFieldMedium" value="" style="dataType: numeric;"
														   onblur="validateNumber(this,'Vendor Tier'); return true;" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<input type="text" id="vendorTier" maxlength="6" tabindex="180"
														   class="textFieldMedium" value="" style="dataType: numeric;" disabled="disabled" />
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</div>
									</td>
									<td align="right" width="12%">
										<label class="labelFont helpable" id="CountryOfOriginLabel">
											Country of Origin <em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="125" honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:select path="vendorVO.countryOfOrigin" tabindex="185" id="countryOfOrigin"
															 cssClass="selectBoxStyle" cssStyle="margin-left:3px;width: 162px">
													<form:options items="${addNewCandidate.vendorVO.countryOfOriginList}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:select path="vendorVO.countryOfOrigin" tabindex="185"
															 id="countryOfOrigin" disabled="true"
															 cssClass="selectBoxStyle" cssStyle="margin-left:3px;width: 162px">
													<form:options items="${addNewCandidate.vendorVO.countryOfOriginList}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
								</tr>
								<tr align="left">
									<td align="right" width="12%">
											<%-- Fix QC 2329 - validate for non-sellable also --%>
										<label class="labelFont helpable" id="CostOwnerLabel">
											Cost Owner <em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="124" honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:select path="vendorVO.costOwner" id="costOwner"
															 tabindex="190" onchange="cstOwnerChange()">
													<form:option value="">--Select--</form:option>
													<form:options items="${addNewCandidate.costOwners}" itemLabel="name"
																  itemValue="id" />
												</form:select>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:select path="vendorVO.costOwner" id="costOwner"
															 tabindex="190" disabled="true">
													<form:option value="">--Select--</form:option>
													<form:options items="${addNewCandidate.costOwners}" itemLabel="name"
																  itemValue="id" />
												</form:select>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="12%">
											<%-- Fix QC 2329 - validate for non-sellable also --%>
										<label class="labelFont helpable" id="Top2TopLabel">
											Top 2 Top <em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="126" honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:select path="vendorVO.top2Top" tabindex="195" id="top2Top"
															 cssClass="selectBoxStyle">
													<form:option value="">--Select--</form:option>
													<form:options items="${addNewCandidate.topToTops}" itemLabel="name"
																  itemValue="id" />
												</form:select>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:select path="vendorVO.top2Top" tabindex="195" id="top2Top"
															 cssClass="selectBoxStyle">
													<form:option value="">--Select--</form:option>
													<form:options items="${addNewCandidate.topToTops}" itemLabel="name"
																  itemValue="id" />
												</form:select>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="12%">
										<label class="labelFont helpable" id="SeasonalityYrLabel">
											Seasonality Yr</label>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="123" honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<input type="text" id="seasonalityYear" maxlength="4" tabindex="200"
													   class="textFieldMedium" value="" style="dataType: numeric;" onblur="dateCheck();"
													   onchange="seasonalityYearChange();" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<input type="text" id="seasonalityYear" maxlength="4" tabindex="200"
													   class="textFieldMedium" value="" style="dataType: integer;" disabled="disabled" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="12%">
										<label class="labelFont helpable" id="SeasonalityLabel">Seasonality</label>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="127" honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:select path="vendorVO.seasonality" tabindex="205" id="seasonality"
															 cssClass="selectBoxStyle"
															 style="dataType: alpha;" value="13" onchange="seasonalityChange();">
													<form:options items="${addNewCandidate.vendorVO.seasonalityList}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:select path="vendorVO.seasonality" tabindex="205" id="seasonality"
															 cssClass="selectBoxStyle"
															 style="dataType: alpha;" value="13" onchange="seasonalityChange();">
													<form:options items="${addNewCandidate.vendorVO.seasonalityList}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
								</tr>
								<tr align="left">
									<td colspan="4">
										<fieldset style="width: 90%; border-collapse: collapse;" id="costDetailsFieldSet">
											<legend>Cost Details</legend>
											<table width="100%">
												<tr>
													<td align="right" width="24%">
														<label class="labelFont helpable" id="costLinkLabel">
															Cost Link By&nbsp;&nbsp;</label>
													</td>
													<td align="left" width="24%">&nbsp;&nbsp;
														<div id="costLink" style="display: block;">
															<cps:renderByResourceAccess resourceId="191"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<select id="costLinkBy" onchange="changeCostLinkBy(this)"
																			class="selectBoxStyle3">
																		<option value="">--Select--</option>
																		<option value="cl">Cost Link #</option>
																		<option value="ic">Item Code</option>
																	</select>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<select id="costLinkBy" class="selectBoxStyle3"
																			disabled="disabled">
																		<option value="">--Select--</option>
																		<option value="cl">Cost Link #</option>
																		<option value="ic">Item Code</option>
																	</select>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</div>
													</td>
													<td colspan="2" width="48%">
														<div id="ItemRadioLabelDiv" style="display: none">
															<label class="labelFont helpable" id="ItemRadioLabel">Item Code </label>
														</div>
														<div id="costlistDiv" style="display: block;">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="191"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="costlist" maxlength="13"
																		   tabindex="210" class="textFieldNormal" value=""
																		   onblur="calculateListCost();"
																		   style="dataType: numeric;" disabled="disabled" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="costlist" maxlength="6"
																		   tabindex="210" class="textFieldNormal" value=""
																		   disabled="disabled" style="dataType: numeric;" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</div>
													</td>
												</tr>
												<tr>
													<td align="right" width="24%">
														<label class="labelFont helpable" id="ListCostLabel">
															List Cost <em><font color="red"><b>*</b></font></em>
														</label>
													</td>
													<td align="left" width="24%">
														<cps:renderByResourceAccess resourceId="120"
																					honorViewMode="${addNewCandidate.caseViewOverRide}">
															<jsp:attribute name="EDIT">
																<input type="text" id="listCost" maxlength="12"
																	   tabindex="170" class="textFieldMedium"
																	   style="dataType: float;"
																	   onkeydown="return onKeyDownListCost(event, this);"
																	   onblur="validateListCost(this);calculateUnitCost();" />
															</jsp:attribute>
															<jsp:attribute name="VIEW">
																<input type="text" id="listCost" maxlength="11"
																	   tabindex="170" class="textFieldMedium"
																	   style="dataType: float;" disabled="disabled" />
															</jsp:attribute>
														</cps:renderByResourceAccess></td>
													<td align="right" width="12%">
														<label class="labelFont helpable" id="UnitCost1Label"> Unit Cost</label>
													</td>
													<td align="left" width="12%">&nbsp;&nbsp;
														<label id="unitCostLabel" class="labelFont"></label>
													</td>
												</tr>
												<tr>
													<td align="right" width="24%">
														<label class="labelFont helpable" id="grossMarginLabel">
															% Margin &nbsp;&nbsp;
														</label>
													</td>
													<td align="left" width="24%">
														<label class="labelFont" id="grossMargin" tabindex="170">
																${selectedVendorVO.grossMargin}
														</label>
														<input type="hidden" id="retailFor"
															   value="${addNewCandidate.productVO.retailVO.retailFor}" />
														<input type="hidden" id="unitRetail"
															   value="${addNewCandidate.productVO.retailVO.retail}" />
													</td>
													<td align="right" width="24%">
														<label class="labelFont helpable" id="grossProfitLabel">
															Penny Profit &nbsp;&nbsp;
														</label>
													</td>
													<td align="left" width="24%">
														<label class="labelFont" id="grossProfit">
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
												<td width="12%" align="right">
													<div id="orderUnitLabelDiv" style="display: block;">
														<cps:renderByResourceAccess resourceId="258"
																					honorViewMode="${addNewCandidate.caseViewOverRide}">
															<jsp:attribute name="EDIT">
																<label class="labelFont helpable" id="OrderUnitLabel">Order Unit&nbsp; </label>
															</jsp:attribute>
															<jsp:attribute name="VIEW">
																<label class="labelFont helpable" id="OrderUnitLabel">Order Unit&nbsp; </label>
															</jsp:attribute>
														</cps:renderByResourceAccess>
													</div>
												</td>
												<td width="12%" align="left">
													<div id="orderUnitDiv" style="display: block;">&nbsp;
														<cps:renderByResourceAccess resourceId="258"
																					honorViewMode="${addNewCandidate.caseViewOverRide}">
															<jsp:attribute name="EDIT">
																<form:select path="vendorVO.orderUnit" id="orderUnit"
																			 tabindex="208" onchange="onChangeOrderUnit(this)"
																			 cssClass="selectBoxStyle3" style="dataType: alpha;">
																	<form:options
																			items="${addNewCandidate.vendorVO.orderUnitList}"
																				itemLabel="name" itemValue="id" />
																</form:select>
															</jsp:attribute>
															<jsp:attribute name="VIEW">
																<form:select path="vendorVO.orderUnit" id="orderUnit"
																			 tabindex="208" onchange="onChangeOrderUnit(this)"
																			 cssClass="selectBoxStyle3"
																			 style="dataType: alpha;" disabled="true">
																	<form:options
																			items="${addNewCandidate.vendorVO.orderUnitList}"
																			itemLabel="name" itemValue="id" />
																</form:select>
															</jsp:attribute>
															<jsp:attribute name="NONE">
																<form:select path="vendorVO.orderUnit" id="orderUnit"
																			 tabindex="208" cssClass="selectBoxStyle3"
																			 style="dataType: alpha;visibility: hidden;"
																			 disabled="true">
																	<form:options
																			items="${addNewCandidate.vendorVO.orderUnitList}"
																			itemLabel="name" itemValue="id" />
																</form:select>
															</jsp:attribute>
														</cps:renderByResourceAccess>
													</div>
												</td>
											</tr>
											<tr>
												<td align="right" width="12%">
													<table>
														<tr>
															<td width="11%">
																<label class="labelFont helpable" id="ExpWeekMovLabel">Expected Weekly Movement</label>
															</td>
															<td width="1%">
																<div class="labelFont" id="ewmMandatory">
																	<c:choose>
																		<c:when
																				test="${addNewCandidate.productVO.classificationVO.productType eq 'GOODS'}">
																			<em><font color="red"><b>*</b></font></em>
																		</c:when>
																	</c:choose>
																</div>
															</td>
														</tr>
													</table>
												</td>
												<td align="left" width="12%">&nbsp;
													<cps:renderByResourceAccess resourceId="208"
																				honorViewMode="${addNewCandidate.caseViewOverRide}">
														<jsp:attribute name="EDIT">
															<input type="text" tabindex="212" id="expectedweeklymovement" maxlength="5"
																   style="dataType: numeric;"
																   onblur="validateNumber(this,'Expected Weekly Movement');validateExpected();" />
														</jsp:attribute>
														<jsp:attribute name="VIEW">
															<input type="text" tabindex="212"
																   id="expectedweeklymovement" maxlength="5"
																   style="dataType: numeric;"
																   onblur="validateNumber(this,'Expected Weekly Movement');validateExpected();"
																   disabled="disabled" />
														</jsp:attribute>
													</cps:renderByResourceAccess>
												</td>
												<!-- Order Restriction Field added -->
												<td align="right" width="12%">
													<div id="orderResLabel" style="display: block;">
														<cps:renderByResourceAccess resourceId="244"
																					honorViewMode="${addNewCandidate.caseViewOverRide}">
															<jsp:attribute name="EDIT">
																<label class="labelFont helpable"
																	   id="OrderRestrictionLabel">Order Restriction</label>
															</jsp:attribute>
															<jsp:attribute name="VIEW">
																<label class="labelFont helpable"
																	   id="OrderRestrictionLabel">Order Restriction</label>
															</jsp:attribute>
														</cps:renderByResourceAccess>
													</div>
												</td>
												<td align="left" width="12%">
													<div id="orderRes" style="display: block;">&nbsp;&nbsp;
														<cps:renderByResourceAccess resourceId="244"
																					honorViewMode="${addNewCandidate.caseViewOverRide}">
															<jsp:attribute name="EDIT">
																<form:select path="vendorVO.orderRestriction" id="orderRestriction"
																			 tabindex="213"
																			 cssClass="selectBoxStyle" style="dataType: alpha;">
																	<form:options
																			items="${addNewCandidate.vendorVO.orderRestrictionList}"
																			itemLabel="name" itemValue="id" />
																</form:select>
															</jsp:attribute>
															<jsp:attribute name="VIEW">
																<form:select path="vendorVO.orderRestriction" id="orderRestriction"
																			 tabindex="213"
																			 cssClass="selectBoxStyle"
																			 style="dataType: alpha;" disabled="true">
																	<form:options
																			items="${addNewCandidate.vendorVO.orderRestrictionList}"
																			itemLabel="name" itemValue="id" />
																</form:select>
													</jsp:attribute>
															<jsp:attribute name="NONE">
																<form:select path="vendorVO.orderRestriction" id="orderRestriction"
																			 tabindex="213"
																			 cssClass="selectBoxStyle"
																			 style="dataType: alpha;visibility: hidden;"
																			 disabled="true">
																	<form:options
																			items="${addNewCandidate.vendorVO.orderRestrictionList}"
																			itemLabel="name" itemValue="id" />
																</form:select>
															</jsp:attribute>
														</cps:renderByResourceAccess>
													</div>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr align="left"></tr>
								<tr>
									<td colspan="8">
										<div id="importOnly" style="visibility: hidden; position: relative; min-width: 0;">
											<table>
												<tr align="left">
													<td align="right" width="5%" colspan="3">
														<label class="labelFont helpable" id="ImportLabel">Import</label>
													</td>
													<td align="left" width="12%">&nbsp;&nbsp;
														<cps:renderByResourceAccess resourceId="122"
																					honorViewMode="${addNewCandidate.caseViewOverRide}">
															<jsp:attribute name="EDIT">
																<c:if test="${vendorVO.importd eq 'true'}">
																	<input type="checkbox" id="import" tabindex="215"
																		   onclick="importClicked();" checked="checked" />
																</c:if>
																<c:if test="${vendorVO.importd eq 'false' || vendorVO.importd ==null || vendorVO.importd =='' }">
																	<input type="checkbox" id="import" tabindex="215"
																		   onclick="importClicked();" />
																</c:if>
															</jsp:attribute>
															<jsp:attribute name="VIEW">
																<c:if test="${vendorVO.importd eq 'true'}">
																	<input type="checkbox" id="import" tabindex="215"
																		   onclick="importClicked();" checked="checked"
																		   disabled="disabled" />
																</c:if>
																<c:if test="${selectedVendorVO.importd eq 'false' || vendorVO.importd ==null || vendorVO.importd ==''}">
																	<input type="checkbox" id="import" tabindex="215"
																		   onclick="importClicked();" disabled="disabled" />
																</c:if>
															</jsp:attribute>
															<jsp:attribute name="NONE">
																<c:if test="${vendorVO.importd eq 'true'}">
																	<input type="checkbox" id="import" tabindex="215"
																		   onclick="importClicked();" checked="checked"
																		   disabled="disabled" />
																</c:if>
																<c:if test="${vendorVO.importd eq 'false' || vendorVO.importd ==null || vendorVO.importd ==''}">
																	<input type="checkbox" id="import" tabindex="215"
																		   onclick="importClicked();" disabled="disabled" />
																</c:if>
															</jsp:attribute>
														</cps:renderByResourceAccess>
													</td>
												</tr>
											</table>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table width="97%">
					<tr>
						<td>
							<div id="importDiv" style="display: none; position: relative; min-width: 0;">
								<fieldset id="importFieldset">
									<legend>Import Attributes</legend>
									<table width="100%" border="0">
										<tr>
											<td width="100%" align="center">
												<table border="0" width="100%" align="center">
													<tr align="left">
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="129"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="ContainerLabel">
																		Container Size<em><font color="red"><b>*</b></font></em></label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="ContainerLabel">
																		Container Size<em><font color="red"><b>*</b></font></em></label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="129"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<select id="cntnSize" tabindex="220">
																		<c:forEach var="cntsize" items="${addNewCandidate.containerList}">
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
																		<c:forEach var="cntsize" items="${addNewCandidate.containerList}">
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
																	<select id="cntnSize" tabindex="220" disabled="disabled" style="display: none;">
																		<c:forEach var="cntsize" items="${addNewCandidate.containerList}">
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
															<cps:renderByResourceAccess resourceId="134"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="IncoTermsLabel">
																		Inco Terms <em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="IncoTermsLabel">
																		Inco Terms <em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="134"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<select id="incoTerms" tabindex="225">
																		<c:forEach var="inco" items="${addNewCandidate.incoList}">
																			<c:if test="${inco.id eq vendorVO.importVO.incoTerms}">
																				<option value="${inco.id}" selected="selected">${inco.name}</option>
																			</c:if>
																			<c:if test="${inco.id ne vendorVO.importVO.incoTerms}">
																				<option value="${inco.id}">${inco.name}</option>
																			</c:if>
																		</c:forEach>
																	</select>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<select id="incoTerms" tabindex="225" disabled="disabled">
																		<c:forEach var="inco" items="${addNewCandidate.incoList}">
																			<c:if test="${inco.id eq vendorVO.importVO.incoTerms}">
																				<option value="${inco.id}" selected="selected">${inco.name}</option>
																			</c:if>
																			<c:if test="${inco.id ne vendorVO.importVO.incoTerms}">
																				<option value="${inco.id}">${inco.name}</option>
																			</c:if>
																		</c:forEach>
																	</select>
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<select id="incoTerms" tabindex="225" disabled="disabled" style="display: none;">
																		<c:forEach var="inco" items="${addNewCandidate.incoList}">
																			<c:if test="${inco.id eq vendorVO.importVO.incoTerms}">
																				<option value="${inco.id}" selected="selected">${inco.name}</option>
																			</c:if>
																			<c:if test="${inco.id ne vendorVO.importVO.incoTerms}">
																				<option value="${inco.id}">${inco.name}</option>
																			</c:if>
																		</c:forEach>
																	</select>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="130"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="PickupPointLabel">
																		Pickup Point<em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="PickupPointLabel">
																		Pickup Point<em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="130"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" maxlength="20" tabindex="230"
																		   class="textFieldNormal"
																		   value="${vendorVO.importVO.pickupPoint}"
																		   id="pcikPoint" style="dataType: alphanumeric;" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" maxlength="20" tabindex="230"
																		   class="textFieldNormal"
																		   value="${vendorVO.importVO.pickupPoint}"
																		   id="pcikPoint" style="dataType: alphanumeric;"
																		   disabled="disabled" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" maxlength="20" tabindex="230"
																		   class="textFieldNormal" value="${vendorVO.importVO.pickupPoint}"
																		   id="pcikPoint" style="dataType: alphanumeric; display: none;" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
													</tr>
													<tr align="left">
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="136"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="RatePerLabel">
																		Duty % <em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="RatePerLabel">
																		Duty % <em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="136"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" maxlength="6" tabindex="235"
																		   class="textFieldSmall"
																		   value="${vendorVO.importVO.rate}" id="rate"
																		   style="dataType: float;"
																		   onblur="roundValue(this,2);return true;" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" maxlength="6" tabindex="235"
																		   class="textFieldSmall" value="${vendorVO.importVO.rate}" id="rate"
																		   style="dataType: float;" disabled="disabled" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" maxlength="6" tabindex="235"
																		   class="textFieldSmall" value="${vendorVO.importVO.rate}" id="rate"
																		   style="dataType: float; display: none;" disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="133"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="DutyInfoLabel">
																		Duty Info<em><font color="red"><b></b></font></em>
																	</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="DutyInfoLabel">
																		Duty Info<em><font color="red"><b></b></font></em>
																	</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="133"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" maxlength="20" tabindex="240"
																		   class="textFieldNormal" value="${vendorVO.importVO.dutyInfo}" id="dutyInfo"
																		   style="dataType: alphanumeric;" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" maxlength="20" tabindex="240"
																		   class="textFieldNormal" value="${vendorVO.importVO.dutyInfo}"
																		   disabled="disabled" id="dutyInfo"
																		   style="dataType: alphanumeric;" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" maxlength="20" tabindex="240"
																		   class="textFieldNormal" value="${vendorVO.importVO.dutyInfo}"
																		   disabled="disabled" id="dutyInfo" style="dataType: alphanumeric;" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="132"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="MinQtyLabel">
																		Minimum Qty<em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="MinQtyLabel">
																		Minimum Qty<em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="132"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="minQntity" maxlength="7" tabindex="245"
																		   class="textFieldSmall" value="${vendorVO.importVO.minimumQty}"
																		   style="dataType: numeric;" onblur="IsNumeric(this);" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="minQntity" maxlength="7" tabindex="245"
																		   class="textFieldSmall" value="${vendorVO.importVO.minimumQty}"
																		   style="dataType: numeric;" disabled="disabled" onblur="IsNumeric(this);" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" id="minQntity" maxlength="7" tabindex="245"
																		   class="textFieldSmall" value="${vendorVO.importVO.minimumQty}"
																		   style="dataType: numeric; display: none;" disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="137"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="MiniTypeLabel">
																		Min. Order Description<em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="MiniTypeLabel">
																		Min. Order Description<em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="137"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" maxlength="20" tabindex="250"
																		   class="textFieldNormal" onblur="onBlurMinType(this)"
																		   value="${vendorVO.importVO.minimumType}" id="minType" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" maxlength="20" tabindex="250"
																		   class="textFieldNormal" value="${vendorVO.importVO.minimumType}" id="minType"
																		   disabled="disabled" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" maxlength="20" tabindex="250"
																		   class="textFieldNormal" value="${vendorVO.importVO.minimumType}" id="minType"
																		   style="display: none;" disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
													</tr>
													<tr>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="195"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="HTSLabel">
																		HTS1<em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
															<jsp:attribute name="VIEW">
																<label class="labelFont helpable" id="HTSLabel">
																	HTS1<em><font color="red"><b>*</b></font></em>
																</label>
															</jsp:attribute>
														</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="195"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="hts" maxlength="10" tabindex="255"
																		   class="textFieldNormal" value="${vendorVO.importVO.hts}"
																		   style="dataType: numeric;" onblur="isNumericAndPadHts(this);" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" disabled="disabled" id="hts" maxlength="10"
																		   tabindex="255" class="textFieldNormal"
																		   value="${vendorVO.importVO.hts}"
																		   style="dataType: numeric;" onblur="isNumericAndPadHts(this);" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" disabled="disabled" id="hts" maxlength="10"
																		   tabindex="255" class="textFieldNormal"
																		   value="${vendorVO.importVO.hts}" style="dataType: numeric; display: none;" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="254"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="HTS2Label">
																		HTS2<em><font color="red"><b></b></font></em>
																	</label>
																</jsp:attribute>
															<jsp:attribute name="VIEW">
																<label class="labelFont helpable" id="HTS2Label">
																	HTS2<em><font color="red"><b></b></font></em>
																</label>
															</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="254"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" value="${vendorVO.importVO.hts2}" id="hts2"
																		   maxlength="10" tabindex="260" class="textFieldNormal"
																		   style="dataType: numeric;" onblur="isNumericAndPadHts(this);" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" value="${vendorVO.importVO.hts2}" id="hts2"
																		   maxlength="10" tabindex="260" class="textFieldNormal"
																		   disabled="disabled" style="dataType: numeric;" onblur="isNumericAndPadHts(this);" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" value="${vendorVO.importVO.hts2}" id="hts2"
																		   maxlength="10" tabindex="260" class="textFieldNormal"
																		   disabled="disabled" style="dataType: numeric; display: none;" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="255"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="HTS3Label">
																		HTS3<em><font color="red"><b></b></font></em>
																	</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="HTS3Label">
																		HTS3<em><font color="red"><b></b></font></em>
																	</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="255"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" value="${vendorVO.importVO.hts3}" id="hts3"
																		   maxlength="10" tabindex="265" class="textFieldNormal"
																		   style="dataType: numeric" onblur="isNumericAndPadHts(this);" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" value="${vendorVO.importVO.hts3}" id="hts3"
																		   maxlength="10" tabindex="265" class="textFieldNormal"
																		   disabled="disabled" style="dataType: numeric" onblur="isNumericAndPadHts(this);" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" value="${vendorVO.importVO.hts3}" id="hts3"
																		   maxlength="10" tabindex="265" class="textFieldNormal"
																		   disabled="disabled" style="dataType: numeric; display: none;" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="133"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="ColorLabel">
																		Product Color<em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="ColorLabel">
																		Product Color<em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="133"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" maxlength="50" tabindex="270"
																		   class="textFieldNormal" value="${vendorVO.importVO.color}" id="color" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" maxlength="50" tabindex="270"
																		   class="textFieldNormal" value="${vendorVO.importVO.color}"
																		   disabled="disabled" id="color" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" maxlength="50" tabindex="270"
																		   class="textFieldNormal"
																		   value="${vendorVO.importVO.color}"
																		   disabled="disabled" id="color" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
													</tr>
													<tr>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="197"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="AgentLabel">
																		Agent % <em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="AgentLabel">
																		Agent % <em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="197"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="agentPer" maxlength="6" tabindex="275"
																		   class="textFieldNormal" value="${vendorVO.importVO.agentPerc}"
																		   style="dataType: float;" onblur="roundValue(this,2);return true;" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="agentPer" maxlength="6" tabindex="275"
																		   disabled="disabled" class="textFieldNormal"
																		   value="${vendorVO.importVO.agentPerc}"
																		   style="dataType: float;" onblur="roundValue(this,2);return true;" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" id="agentPer" maxlength="6" tabindex="275"
																		   disabled="disabled" class="textFieldNormal"
																		   value="${vendorVO.importVO.agentPerc}"
																		   style="dataType: float; display: none;" onblur="roundValue(this,2);return true;" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="199"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="CartonMarkLabel">
																		Carton Marking<em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
															<jsp:attribute name="VIEW">
																<label class="labelFont helpable" id="CartonMarkLabel">
																	Carton Marking<em><font color="red"><b>*</b></font></em>
																</label>
															</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="199"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="cartMarketing" maxlength="30"
																		   tabindex="280" size="35" value="${vendorVO.importVO.cartonMarketing}"
																		   style="dataType: alphanumeric;" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="cartMarketing" maxlength="30"
																		   tabindex="280" size="35" value="${vendorVO.importVO.cartonMarketing}"
																		   style="dataType: alphanumeric;" disabled="disabled" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" id="cartMarketing" maxlength="30"
																		   tabindex="280" size="35" value="${vendorVO.importVO.cartonMarketing}"
																		   style="dataType: alphanumeric; display: none;" disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="196"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="DutyLabel">
																		Duty Confirmed<em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="DutyLabel">
																		Duty Confirmed<em><font color="red"><b>*</b></font></em>
																	</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="196"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="duty" maxlength="10" tabindex="285"
																		   style="width: 70%" value="${vendorVO.importVO.duty}"
																		   class="textFieldSmall"
																		   onblur="validateDateUsingDWR(this,'Duty Confirmed');" />
																	<img src="${calend}" id="dutyCalend" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="duty" maxlength="10" tabindex="285"
																		   disabled="disabled" style="width: 70%"
																		   value="${vendorVO.importVO.duty}"
																		   class="textFieldSmall" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" id="duty" maxlength="10" tabindex="285"
																		   disabled="disabled" style="width: 70%"
																		   value="${vendorVO.importVO.duty}"
																		   style="dataType: alphanumericOnly; display:none;" class="textFieldSmall" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="131"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="PickupPointLabel">
																		<label class="labelFont helpable" id="FreightLabel">
																			Freight Confirmed<em><font color="red"><b>*</b></font></em>
																		</label>
																	</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="FreightLabel">
																		<label class="labelFont helpable" id="FreightLabel">
																			Freight Confirmed<em><font color="red"><b>*</b></font></em>
																		</label>
																	</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="131"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" maxlength="20" tabindex="290"
																		   style="width: 70%" value="${vendorVO.importVO.freight}" id="freight"
																		   onblur="validateDateUsingDWR(this,'Freight Confirmed');" />
																	<img src="${calend1}" id="freights" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" maxlength="20" tabindex="290"
																		   style="width: 70%" value="${vendorVO.importVO.freight}" id="freight"
																		   disabled="disabled" onblur="validateDateUsingDWR(this,'Freight Confirmed');" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" maxlength="20" tabindex="290"
																		   style="width: 70%" value="${vendorVO.importVO.freight}" id="freight"
																		   disabled="disabled" onblur="validateDateUsingDWR(this,'Freight Confirmed');" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%"></td>
														<td align="left" width="12%">&nbsp;</td>
													</tr>
													<tr>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="135"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="ProDateLabel">Proration Date</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="ProDateLabel">Proration Date</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="135"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="prorDate" maxlength="10" tabindex="295"
																		   value="${vendorVO.importVO.prorationDate}"
																		   onblur="validateDateUsingDWR(this,'Proration Date');" />
																	<img src="${calend}" id="propDate" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="prorDate" maxlength="10" tabindex="295"
																		   disabled="disabled" value="${vendorVO.importVO.prorationDate}"
																		   onblur="validateDateUsingDWR(this,'Proration Date');" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" id="prorDate" maxlength="10" tabindex="295"
																		   disabled="disabled" style="display: none;" value="${vendorVO.importVO.prorationDate}"
																		   onblur="validateDateUsingDWR(this,'Proration Date');" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="138"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="InstoreDateLabel">Instore Date</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="InstoreDateLabel">Instore Date</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="138"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="instoreDate" maxlength="10"
																		   tabindex="300" value="${vendorVO.importVO.instoreDate}"
																		   onblur="validateDateUsingDWR(this,'Instore Date');" />
																	<img src="${calen}" id="storeDate" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="instoreDate" maxlength="10"
																		   tabindex="300" value="${vendorVO.importVO.instoreDate}"
																		   disabled="disabled" />
																</jsp:attribute>
															<jsp:attribute name="NONE">
																<input type="text" id="instoreDate" maxlength="10"
																	   tabindex="300" value="${vendorVO.importVO.instoreDate}"
																	   disabled="disabled" style="display: none;" />
															</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="198"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="WHSEDateLabel">Whse Flush Date</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="WHSEDateLabel">Whse Flush Date</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="198"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="whseFlushDate" maxlength="10"
																		   tabindex="305" value="${vendorVO.importVO.whseFlushDate}"
																		   onblur="validateDateUsingDWR(this,'Whse Flush Date');" />
																	<img src="${cal}" id="flushDate" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="whseFlushDate" maxlength="10"
																		   tabindex="305" value="${vendorVO.importVO.whseFlushDate}"
																		   disabled="disabled" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" id="whseFlushDate" maxlength="10"
																		   tabindex="305" value="${vendorVO.importVO.whseFlushDate}"
																		   style="display: none;" />
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
				<!--#1205 Add New Attribute-->
				<table width="100%">
					<tr>
						<td align="left">
							<cps:renderByResourceAccess resourceId="174" honorViewMode="${addNewCandidate.caseViewOverRide}">
								<jsp:attribute name="EXEC">
									<button type="button" id="reqAttribute" name="button1" value="requestnewattribute" tabindex="9">
										Request New Attribute
									</button>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
					</tr>
				</table>

				<table width="100%">
					<tr>
						<td align="right" width="90%">
							<cps:renderByResourceAccess resourceId="192" honorViewMode="${addNewCandidate.caseViewOverRide}">
								<jsp:attribute name="EXEC">
									<input type="button" value="Save Vendor" id="addButton6" tabindex="320" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
						<td align="left" width="10%">
							<div id="enableAuthorizeWHS" style="display: none;">
								<cps:renderByResourceAccess resourceId="194" honorViewMode="${addNewCandidate.caseViewOverRide}">
									<jsp:attribute name="EXEC">
										<button id="authWHS" tabindex="325">Authorize WHS</button>
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</div>
							<div id="enableAuthorizeStore" style="display: none;">
								<cps:renderByResourceAccess resourceId="193"
															honorViewMode="${addNewCandidate.caseViewOverRide}">
									<jsp:attribute name="EXEC">
										<button id="authStore" tabindex="326">Authorize Store</button>
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</div>
						</td>
					</tr>
				</table>
				<!-- #1205 Add New Attribute -->
				<div id="RNAPanel" style="display: none;">
					<div class="hd">
						<div class="tl"></div>
						<span><font size="2" color="white">&nbsp;&nbsp;&nbsp;Request New Attribute</font></span>
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
				<table width="100%"  style="width: 96%; margin-left: 10px; border-collapse: collapse;">
					<tr>
						<td width="90%"></td>
						<td align="right" width="6%">
							<input type="button" value="Back" id="backButton" tabindex="350" />
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	</body>
</form:form>

<script type="text/javascript">

    var caseText = YAHOO.util.Dom.get("caseUpcText");
    var caseCheck = YAHOO.util.Dom.get("caseCheckDigit");


    function initvendorLocList(){
        //AddCandidateTemp.updateVendorLocListForDSD(getDWRCallbackMethod(null));
        //AddCandidateTemp.updateVendorLocListForWHS(getDWRCallbackMethod(null));
        //AddCandidateTemp.updateVendorLocListForBOTH(getDWRCallbackMethod(null));
    }

    <cps:renderByResourceAccess resourceId="198">
    <jsp:attribute name="EDIT">
		Calendar.setup({
			inputField     :    "whseFlushDate",     // id of the input field
			ifFormat       :    "%m/%d/%Y",      // format of the input field
			button         :    "flushDate",  // trigger for the calendar (button ID)
			align          :    "T1",           // alignment (defaults to "Bl")
			singleClick    :    true
		});
    </jsp:attribute>
    </cps:renderByResourceAccess>

    <cps:renderByResourceAccess resourceId="138">
    <jsp:attribute name="EDIT">
		Calendar.setup({
			inputField     :    "instoreDate",     // id of the input field
			ifFormat       :    "%m/%d/%Y",      // format of the input field
			button         :    "storeDate",  // trigger for the calendar (button ID)
			align          :    "T1",           // alignment (defaults to "Bl")
			singleClick    :    true
		});
    </jsp:attribute>
    </cps:renderByResourceAccess>
    <cps:renderByResourceAccess	resourceId="135">
    <jsp:attribute name="EDIT">
		Calendar.setup({
			inputField     :    "prorDate",     // id of the input field
			ifFormat       :    "%m/%d/%Y",      // format of the input field
			button         :    "propDate",  // trigger for the calendar (button ID)
			align          :    "T1",           // alignment (defaults to "Bl")
			singleClick    :    true
		});
    </jsp:attribute>
    </cps:renderByResourceAccess>

    <cps:renderByResourceAccess
        resourceId="131">
    <jsp:attribute name="EDIT">
    Calendar.setup({
        inputField     :    "freight",     // id of the input field
        ifFormat       :    "%m/%d/%Y",      // format of the input field
        button         :    "freights",  // trigger for the calendar (button ID)
        align          :    "T1",           // alignment (defaults to "Bl")
        singleClick    :    true
    });
    </jsp:attribute>
    </cps:renderByResourceAccess>
    <cps:renderByResourceAccess	resourceId="196">
    <jsp:attribute name="EDIT">
    Calendar.setup({
        inputField     :    "duty",     // id of the input field
        ifFormat       :    "%m/%d/%Y",      // format of the input field
        button         :    "dutyCalend",  // trigger for the calendar (button ID)
        align          :    "T1",           // alignment (defaults to "Bl")
        singleClick    :    true
    });
    </jsp:attribute>
    </cps:renderByResourceAccess>
    initvendorLocList();
    setChanelDefault();
    function caseDescFocus(){
        document.getElementById('caseDescriptionText').focus();
    }

    new YAHOO.widget.Button("addCaseBut");
    new YAHOO.widget.Button("editCaseBut");
    new YAHOO.widget.Button("deleteBut");


    new YAHOO.widget.Button("AVupc"); // This is save case button
    new YAHOO.widget.Button("cancelBut");


    <c:if test="${addNewCandidate.productVO.caseCount <= 0}">
    //document.getElementById('AVupc').style.display = 'none';
    //document.getElementById('cancelBut').style.display = 'none';
    if(document.getElementById('editCaseBut')){
        document.getElementById('editCaseBut').style.display = 'none';
    }
    if(document.getElementById('deleteBut')){
        document.getElementById('deleteBut').style.display = 'none';
    }
    if(	document.getElementById("addCaseBut")){
        document.getElementById("addCaseBut").disabled = true;
    }
    </c:if>
    <c:if test="${addNewCandidate.productVO.caseCount > 0}">
    //document.getElementById('AVupc').style.display = 'inline';
    //document.getElementById('cancelBut').style.display = 'inline';
    if(document.getElementById('editCaseBut')){
        document.getElementById('editCaseBut').style.display = 'inline';
    }
    if(document.getElementById('deleteBut')){
        document.getElementById('deleteBut').style.display = 'inline';
    }
    if(	document.getElementById("addCaseBut")){
        document.getElementById("addCaseBut").disabled = false;
    }
    //
    </c:if>

    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("AVupc"), "click", addCaseDetailsToTable);
    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("cancelBut"), "click", onCancleClick);
    new YAHOO.widget.Button("addCaseDetailsBut");
    new YAHOO.widget.Button("deleteVendorDetailsBut");
    new YAHOO.widget.Button("editVendorDetailsBut");
    new YAHOO.widget.Button("addButton6");
    new YAHOO.widget.Button("backButton");
    new YAHOO.widget.Button("importFacilities");//R2
    <c:if test='${vendorVO.vendorLocationTypeCode eq "V"}'>
    new YAHOO.widget.Button("authWHS");
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

    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd);

    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addCaseBut"), "click", changeDisplay);

    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("editCaseBut"), "click", displayDetailsForAjaxRowsNP);
    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteBut"), "click", deleteSelectedCase);
    //YAHOO.util.Event.addListener(YAHOO.util.Dom.get("codeDate"), "click", checkedCodeDate);
    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", saveCaseAndVendor);
    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addCaseDetailsBut"), "click", showVendorDetailsToAdd);

    YAHOO.util.Event.removeListener("importFacilities", "click");
    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("importFacilities"), "click", importFacilities);//R2

    YAHOO.util.Event.onDOMReady(makeFirstItemClicked);
    executeAfterBodyVisible(caseDescFocus);

    //#1205 - Add New Attribute
    new YAHOO.widget.Button("reqAttribute");
    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("reqAttribute"), "click", reqAttributeClick);

    function fillVendorDetails(){
        var sel = document.getElementById('actions3');
        //dwr.util.removeAllOptions("vendorLocation");
        if(sel.options[sel.selectedIndex].value=='DSD') {
            hideVendor();
        } else {
            dispVendor();
        }
        AddCandidateTemp.getVendorLocationList(sel.options[sel.selectedIndex].value, getDWRCallbackMethod(updateLocation));
    }

    function updateLocation( data ){
        hideProgress();
        if(data!= null && data.ERR != undefined)
        {
            alert(data.ERR);
        } else 	{
            if(document.getElementById('vendorLocation')){
                dwr.util.removeAllOptions("vendorLocation");
                dwr.util.addOptions("vendorLocation", data.VEND, "id", "name");
            }
        }
    }



    function autotab(original,caseCheckDigit){

        if(original.value.length == original.getAttribute("maxlength")){
            document.getElementById('caseCheckDigit').focus();
        }
    }

    function verifyCheckDigit(){
        var caseText = YAHOO.util.Dom.get("caseUpcText");
        var caseCheck = YAHOO.util.Dom.get("caseCheckDigit");
        var caseTextValue = caseText.value;
        var caseCheckValue = caseCheck.value;
        if(caseCheckValue!="" && null != caseCheckValue) {
            showProgress();
            AddCandidateTemp.verifyCheckDigitForCase(caseTextValue,caseCheckValue,getDWRCallbackMethod(function(data){
                hideProgress();
                if(!data) {
                    alert('InValid Check Digit. Please Re-enter the UPC/Checkdigit Value');
                    document.getElementById('caseCheckDigit').value = '';
                    document.getElementById('caseUpcText').focus();
                    document.getElementById('caseUpcText').select();
                }
            }));
        }
        else if(caseTextValue != null && caseTextValue != "" && (caseCheckValue == null || caseCheckValue == "") ){
            alert('Please enter the Check Digit');
        }
    }

    function validateExpected(){
        var expected = YAHOO.util.Dom.get("expectedweeklymovement").value;
        if(expected == "" || expected == null){
            return true;
        }
        if(expected.indexOf('00')==0){
            expected = expected.substring(2);
        } else 	if(expected.indexOf('0')==0){
            expected = expected.substring(1);
        }
        expected = parseInt(expected);
        if(expected <= 0){
            alert('Please enter a value greater than Zero');
            YAHOO.util.Dom.get("expectedweeklymovement").focus();
            YAHOO.util.Dom.get("expectedweeklymovement").select();
        }
    }
    function setChanelDefault()
    {
        var sel = document.getElementById('actions3');
        if(sel)	{
            sel.selectedIndex = 0;
        }
    }

    function invalid0(element){
        if(null != element && element != undefined){
            var caseUPC = element.value;
            if(/^0+$/.test(caseUPC)){
                alert("This UPC is invalid. Please try another UPC.");
                element.value = "";
                element.focus();
            }
        }
    }

    YAHOO.util.Event.onDOMReady(function(){
        YAHOO.util.Dom.get("hts").value = padHts(YAHOO.util.Dom.get("hts").value);
        YAHOO.util.Dom.get("hts2").value = padHts(YAHOO.util.Dom.get("hts2").value);
        YAHOO.util.Dom.get("hts3").value = padHts(YAHOO.util.Dom.get("hts3").value);
        //Sprint - 23
        loadDefaultChannel();
    });
</script>
