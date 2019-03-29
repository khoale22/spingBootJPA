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
<form:form id="mrtForm" name="mrtForm" action="/protected/cps/add" modelAttribute="addNewCandidate">
	<form:hidden path="hidUpcValue" />
	<form:hidden path="hidDescription"  />
	<form:hidden path="hidUpcCheckDigit" />
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<c:url value="${request.getContextPath()}/hebAssets/moduleIncludes/authAndDist.js" var="authAndDist" />
	<c:url value="${request.getContextPath()}/hebAssets/common.js" var="common" />
	<script type="text/javascript" src="${authAndDist}"></script>
	<script type="text/javascript" src="${common}"></script>
	<script type="text/javascript" src="<spring:url value='/hebAssets/moduleIncludes/auth.js.jsp'></spring:url>"/>
	<script type="text/javascript">
        <c:url var="colspd" value="${request.getContextPath()}/hebAssets/images/collapsed.gif"/>
        <c:url var="expnd" value="${request.getContextPath()}/hebAssets/images/expanded.gif"/>
        <c:url var="calend" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
        <c:url var="calend1" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
        <c:url var="cal" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
        <c:url var="calen" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
        <c:url var="iconRedStar" value="${request.getContextPath()}/hebAssets/images/red_star.png"/>
	</script>
	<body>
	<br>
	<!--------------------- UPC Section Begins  -------------------->
	<div id="all">
		<fieldset style="width: 96%; margin-left: 10px; border-collapse: collapse;" id="f1">
			<legend onclick="toggle('f1');" style="cursor: pointer;">
				<img src="${expnd}" id="caseImg"> UPC Information
			</legend>
			<div id="caseDiv">
				<br>
				<table width="100%" border="0" id="addMRTTable">
					<tr>
						<td>
							<table width="100%" cellspacing="0" bordercolor="red" border="0">
								<tr>
									<td width="13%" align="center" class="dataGridHead">Unit UPC</td>
									<td class="dataGridHead" width="2%" class="labelFont"></td>
									<td width="15%" align="center" class="dataGridHead">SellableUnits
										<div id="unitTotalAttribute" style="position: absolute">
											(${addNewCandidate.mrtvo.mrtUpcVO.unitTotalAttribute})
										</div>
									</td>
									<td width="15%" align="center" class="dataGridHead">Description</td>
									<td width="15%" align="center" class="dataGridHead">Item Code</td>
									<td width="20%" align="center" class="dataGridHead">Needs Approval</td>
									<td width="20%" align="center" class="dataGridHead"></td>
								</tr>
								<tbody id="mrtTable" align="center">
									<c:forEach items="${addNewCandidate.mrtvo.mrtVOs}" var="setMRTValue" varStatus="loop" >
										<tr id="caseRow${loop.index}" class="labelFont">
											<td width="13%" align="center" nowrap="nowrap" class="labelFont" align="center">
												<c:out value="${setMRTValue.unitUPC}"></c:out>
											</td>
											<td align="left" width="2%" class="labelFont">
												<font class="labelFont">
													<c:out value="${setMRTValue.unitUPCCheckDigit}"></c:out>
												</font>
											</td>
											<td width="15%" align="center" nowrap="nowrap" class="labelFont" align="center">
												<c:out value="${setMRTValue.sellableUnits}"></c:out>
											</td>
											<td width="15%" align="center" nowrap="nowrap" class="labelFont" />
											<c:if test="${!addNewCandidate.viewOnlyProductMRT}">
												<a href='#' onclick='javascript:return false;'
												   id="<c:out value="${setMRTValue.unitUPC}"></c:out>">
													<c:out value="${setMRTValue.description}"></c:out>
												</a>
											</c:if>
											<c:if test="${addNewCandidate.viewOnlyProductMRT}">
												<c:out value="${setMRTValue.description}"></c:out>
											</c:if>
											<input type="hidden" id="hiddenNormal${loop.index}"
												   value="${setMRTValue.uniqueId}" />
											</td>
											<td width="15%" align="center" class="labelFont" />
												<c:out value="${setMRTValue.itemCode}"></c:out>
											</td>
											<td width="20%" align="center" class="labelFont" />
												<c:out value="${setMRTValue.approval}"></c:out>
											</td>
											<td width="20%" align="center" class="labelFont">
												<cps:renderByResourceAccess resourceId="214"
																			honorViewMode="${addNewCandidate.caseViewOverRide}">
													<jsp:attribute name="EXEC">
														<input type="Button" value="Remove" id="deleteButton${loop.index}" />
													</jsp:attribute>
												</cps:renderByResourceAccess>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</td>
					</tr>
				</table>
				<br />
				<table width="100%" border="0">
					<tr>
						<td>
							<table id="mrtInputTable" width="100%" cellspacing="0" bordercolor="red">
								<tbody align="center">
								<tr class="labelFont" align="center">
									<td width="15%" align="center">
										<cps:renderByResourceAccess resourceId="215"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="dummyProperty" size="15" maxlength="13"
															tabindex="11"  id="unitUPC"
															style="dataType : numeric;"
															onkeyup="autotab1(this,'unitUPCCheckDigit');return true;"/>
												<label for="selectedChannel" class="labelFont"> -</label>
												<input  type="text" id="unitUPCCheckDigit"
															style="dataType: numeric; width: 14px;"
															value="${addNewCandidate.dummyProperty}" size="1" maxlength="1"
															tabindex="12" onblur="verifyCheckDigit();"/>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="dummyProperty" size="15" maxlength="13"
															tabindex="11"   id="unitUPC"
															style="dataType : numeric;" disabled="true"
															onkeyup="autotab1(this,'unitUPCCheckDigit');return true;"/>
												<label for="selectedChannel" class="labelFont"> -</label>
												<input type="text"  id="unitUPCCheckDigit"
															style="dataType: numeric; width: 10px;"
													       value="${addNewCandidate.dummyProperty}"  size="1" maxlength="1"
															tabindex="12" onblur="verifyCheckDigit();"
															disabled="true"/>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td width="15%" align="center">
										<cps:renderByResourceAccess resourceId="210"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<input type="text" value="${addNewCandidate.dummyProperty}" size="15" maxlength="5" tabindex="13"
															  id="sellableUnits"
															onblur="IsNumeric(this);" style="dataType : numeric;"/>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<input value="${addNewCandidate.dummyProperty}" type="text" size="15" maxlength="5" tabindex="13"
															 id="sellableUnits" disabled="true"
															onblur="IsNumeric(this);" style="dataType : numeric;"/>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td width="15%" align="center"></td>
									<td width="15%" align="center"></td>
									<td width="20%" align="center"></td>
									<td width="20%" align="center">
										<cps:renderByResourceAccess resourceId="216"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EXEC">
												<button type="button" id="mrtAddButton" name="addMRTButton" value="Add"
														tabindex="14">Add</button>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
								</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</table>
				<br />
			</div>
		</fieldset>
	</div>
	<!--------------------- UPC Section Ends  -------------------->
	<!--------------------- Case Details  Section Begins  -------------------->
	<BR />
	<BR />
	<div id="details" style="display: block;">
		<fieldset tyle="width: 96%; margin-left: 10px; border-collapse: collapse;" id="f2">
			<legend id="caseDetailsLegend">MRT Case Details</legend>
			<table width="100%" border="0">
				<tr>
					<td align="right" width="19%">
						<label class="labelFont helpable" id="CaseDescriptionLabel">
							Case Description <em><font color="red"><b>*</b></font></em>
						</label>
					</td>
					<td align="left" width="18%">
						<cps:renderByResourceAccess resourceId="81" honorViewMode="${addNewCandidate.caseViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:input path="mrtvo.caseVO.caseDescription"
											cssClass="textFieldNormal" id="caseDescriptionText" maxlength="30"
											style="TEXT-TRANSFORM: uppercase; dataType: alphanumeric;" tabindex="15"
											onblur="valdKeyPressSymbSpec(this);switchToUpperCase(this);return true;"/>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:input path="mrtvo.caseVO.caseDescription"
											cssClass="textFieldNormal" id="caseDescriptionText" maxlength="30"
											tabindex="15" disabled="true" />
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</td>
					<td width="11%" align="right">
						<label class="labelFont helpable" id="ChannelLabel">
							Channel <em><font color="red"><b>*</b></font></em></label>
					</td>
					<td width="11%" align="left">
						<c:set var="strDisable" value="true"></c:set>
						<c:if test="${addNewCandidate.mrtvo.caseVO.channel == null || addNewCandidate.mrtvo.caseVO.channel == ''}">
							<c:set var="strDisable" value="false"></c:set>
						</c:if>
						<cps:renderByResourceAccess resourceId="83" honorViewMode="${addNewCandidate.caseViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:select path="mrtvo.caseVO.channel" id="actions3" tabindex="16"
											 disabled="${strDisable}"
											 onchange="getVendorChannelTypeBetween();removeVendorMatchChannel();">
									<form:options items="${addNewCandidate.channels}"  itemLabel="name" itemValue="id" />
								</form:select>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:select path="mrtvo.caseVO.channel"   id="actions3"
											 onchange="getVendorChannelTypeBetween();" tabindex="16" disabled="true">
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
							<cps:renderByResourceAccess resourceId="88"
														honorViewMode="${addNewCandidate.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="radio" name="upcradio" tabindex="17" id="catchRadio" maxlength="1" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="radio" name="upcradio" tabindex="17" id="catchRadio" maxlength="1"
										   disabled="disabled" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</div>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" bordercolor="blue">
				<tr>
					<td align="right" width="19%">
						<label class="labelFont helpable" id="CaseUPCLabel">
							Case UPC <em><font color="red"><b>*</b></font></em></label>
					</td>
					<td align="left" width="10%">
						<cps:renderByResourceAccess	resourceId="79" honorViewMode="${addNewCandidate.caseViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:input path="mrtvo.caseVO.caseUPC"  id="caseUpcText"
											cssClass="textFieldMedium" maxlength="13" tabindex="20"
											onkeyup="autotab(this,'caseCheckDigit');return true;"
											onblur="setFocusToCheckDigit();" />
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:input path="mrtvo.caseVO.caseUPC"  id="caseUpcText"
											cssClass="textFieldMedium" maxlength="13" tabindex="20" disabled="true"/>
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</td>
					<td align="left" width="8%">
						<label for="selectedChannel" class="labelFont">-</label>
						<cps:renderByResourceAccess resourceId="79" honorViewMode="${addNewCandidate.caseViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:input tabindex="21"  id="caseCheckDigit" maxlength="1"
											style="dataType: numeric; width: 14px;" path="mrtvo.caseVO.caseChkDigit"
											size="1" onkeyup="verifyCheckDigitForCaseUPC();" />
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:input tabindex="21"  id="caseCheckDigit" maxlength="1"
											style="dataType: numeric; width: 14px;" path="mrtvo.caseVO.caseChkDigit"
											size="1" disabled="true" onblur="verifyCheckDigitForCaseUPC();" />
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</td>
					<td width="22%"></td>
					<td width="19%" align="right">
						<div id="VariableWtSwLabelDiv" style="display: none;">
							<label class="labelFont helpable" id="VariableWtSwLabel">Variable Weight Sw </label>
						</div>
					</td>
					<td width="22%" align="left">
						<div id="variableRadioDiv" style="display: none;">&nbsp;&nbsp;
							<cps:renderByResourceAccess resourceId="89"
														honorViewMode="${addNewCandidate.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="radio" name="upcradio" tabindex="18" id="variableRadio" maxlength="1"/>
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="radio" name="upcradio" tabindex="18" id="variableRadio" maxlength="1"
										   disabled="disabled"/>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="4"></td>
					<td align="right" width="19%">
						<div id="NoneLabelDiv" style="display: none;">
							<label class="labelFont helpable" id="NoneLabel">None </label>
						</div>
					</td>
					<td align="left" width="22%">
						<div id="noneRadioDiv" style="display: none;">&nbsp;&nbsp;
							<cps:renderByResourceAccess resourceId="90"
														honorViewMode="${addNewCandidate.caseViewOverRide}">
								<jsp:attribute name="EDIT">
									<input type="radio" name="upcradio" tabindex="19" id="noneRadio" maxlength="1" />
								</jsp:attribute>
								<jsp:attribute name="VIEW">
									<input type="radio" name="upcradio" tabindex="19" id="noneRadio" maxlength="1"
										   disabled="disabled" />
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</div>
					</td>
				</tr>
			</table>
			<br />
			<table width="100%">
				<tr>
					<td width="17%">
						<div id="masterPackDiv" style="visibility: hidden; position: absolute;">
							<table width="100%" border="0">
								<tr>
									<td align="right" width="10%">
										<label class="labelFont helpable" id="MasterPackLabel">
											Master pack <em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="7%">
										<cps:renderByResourceAccess resourceId="84"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="mrtvo.caseVO.masterPack" id="masterPackText"
															  maxlength="3" tabindex="22"
															cssClass="textFieldSmall" style="dataType : numeric;"
															onblur="calculateUnitCost();" readonly="true" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="mrtvo.caseVO.masterPack" id="masterPackText"
															 maxlength="3" tabindex="22"
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
												<form:input path="mrtvo.caseVO.masterLength" id="masterLength"
															cssClass="textFieldSmall" maxlength="8" tabindex="23"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'length');"
															onblur="checkLength('master');calculateMasterCube();check();return true;" />
												<label for="selectedChannel" class="labelFont">in</label>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="mrtvo.caseVO.masterLength" id="masterLength"
															cssClass="textFieldSmall" maxlength="8" tabindex="23"
															  style="dataType: float;"
															disabled="true"/>
											</jsp:attribute>
										</cps:renderByResourceAccess>
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
												<form:input path="mrtvo.caseVO.masterWidth" id="masterWidth"
															cssClass="textFieldSmall" maxlength="8" tabindex="24"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'width');"
															onblur="checkWidth('master');calculateMasterCube();check();return true;" />
												<label for="selectedChannel" class="labelFont">in</label>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="mrtvo.caseVO.masterWidth" id="masterWidth"
															cssClass="textFieldSmall" maxlength="8" tabindex="24"
													 style="dataType: float;" disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="7%">
										<label class="labelFont helpable" id="MasterHeightLabel">
											Height<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="10%">
										<cps:renderByResourceAccess	resourceId="93"
																	   honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="mrtvo.caseVO.masterHeight" id="masterHeight"
														  cssClass="textFieldSmall"
															maxlength="8" tabindex="25"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'height');"
															onblur="checkHeight('master');calculateMasterCube();check();return true;" />
												<label for="selectedChannel" class="labelFont">in</label>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="mrtvo.caseVO.masterHeight" id="masterHeight"
															 style="dataType: float;"
															cssClass="textFieldSmall" maxlength="8" tabindex="25"
															disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="5%">
										<label class="labelFont helpable" id="MasterLabel">Cube </label>
									</td>
									<td align="left" width="10%">&nbsp;&nbsp;
										<label id="masterCubeLabel" class="labelFont">
												${addNewCandidate.mrtvo.caseVO.masterCubeFormatted}
										</label>
										<label for="selectedChannel" class="labelFont"> cu.ft</label>
									</td>
									<td align="right" width="7%">
										<label class="labelFont helpable" id="MasterWeightLabel">
											Weight<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="10%">
										<cps:renderByResourceAccess resourceId="95"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="mrtvo.caseVO.masterWeight" id="masterWeight"
															cssClass="textFieldSmall" maxlength="8" tabindex="26"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'weight');"
															onblur="chekDecimalValue(this, 2); check();return true;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="mrtvo.caseVO.masterWeight" id="masterWeight"
															cssClass="textFieldSmall" maxlength="8" tabindex="26"
															 style="dataType: float;"
															disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
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
													<form:input path="mrtvo.caseVO.shipPack" id="shipPackText"
																cssClass="textFieldSmall" maxlength="3" tabindex="27"
																onblur=" check();calculateUnitCost();" readonly="true" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:input path="mrtvo.caseVO.shipPack" id="shipPackText"
																cssClass="textFieldSmall" maxlength="3" tabindex="27"
																  style="dataType: numeric;"
																disabled="true" />
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
							<table width="100%">
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
												<form:input path="mrtvo.caseVO.shipLength" id="shipLength"
															cssClass="textFieldSmall" maxlength="8" tabindex="28"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'length');"
															onblur="checkLength('ship');calculateShipCube();validateShip('Length');return true;" />
												<label for="selectedChannel" class="labelFont">in</label>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="mrtvo.caseVO.shipLength" id="shipLength"
															cssClass="textFieldSmall" maxlength="8" tabindex="28"
													 style="dataType: float;" disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="7%">
										<label class="labelFont helpable" id="ShipPackWidthLabel">
											Width<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="10%">
										<cps:renderByResourceAccess resourceId="97"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="mrtvo.caseVO.shipWidth" id="shipWidth"
															cssClass="textFieldSmall" maxlength="8" tabindex="29"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'width');"
															onblur="checkWidth('ship');calculateShipCube();validateShip('Width');return true;" />
												<label for="selectedChannel" class="labelFont">in</label>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="mrtvo.caseVO.shipWidth" id="shipWidth"
															cssClass="textFieldSmall" maxlength="8" tabindex="29"
															style="dataType: float;" disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="7%">
										<label class="labelFont helpable" id="ShipPackHeightLabel">
											Height<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="10%">
										<cps:renderByResourceAccess resourceId="98"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:input path="mrtvo.caseVO.shipHeight" id="shipHeight" maxlength="8"
															  cssClass="textFieldSmall" tabindex="30"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'height');"
															onblur="checkHeight('ship');calculateShipCube();validateShip('Height');return true;" />
												<label for="selectedChannel" class="labelFont">in</label>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="mrtvo.caseVO.shipHeight" id="shipHeight" maxlength="8"
													 cssClass="textFieldSmall" tabindex="30"
															style="dataType: float;" disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="5%">
										<label class="labelFont helpable" id="ShipLabel">Cube </label>
									</td>
									<td align="left" width="10%">&nbsp;&nbsp;
										<label class="labelFont" id="shipCubeLabel">
												${addNewCandidate.mrtvo.caseVO.shipCubeFormatted}
										</label>
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
												<form:input path="mrtvo.caseVO.shipWeight" id="shipWeight"
															cssClass="textFieldSmall" maxlength="10" tabindex="31"
															onkeydown="return onKeyDownRestrictDecimal(event, this, 'weight');"
															onblur="chekDecimalValue(this, 2);return true;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="mrtvo.caseVO.shipWeight" id="shipWeight"
															cssClass="textFieldSmall" maxlength="10" tabindex="31"
															  style="dataType: float;" disabled="true" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr>
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
												<form:input path="mrtvo.caseVO.unitFactor" id="unitFactor"
															cssClass="textFieldSmall" maxlength="10" tabindex="32"
															onblur="roundValue(this,4);return true;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="mrtvo.caseVO.unitFactor" id="unitFactor"
															cssClass="textFieldSmall" maxlength="10" tabindex="32"  style="dataType: float;" disabled="true" />
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
												<form:input path="mrtvo.caseVO.maxShip" cssClass="textFieldSmall"
															maxlength="3" tabindex="32"
															id="maxShipText" style="dataType: numeric;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:input path="mrtvo.caseVO.maxShip" id="maxShipText"
															cssClass="textFieldSmall" maxlength="3" tabindex="32"
															style="dataType: numeric;  display:none;" />
											</jsp:attribute>
											<jsp:attribute name="NONE">
												<form:input path="mrtvo.caseVO.maxShip" id="maxShipText"
															cssClass="textFieldSmall" maxlength="3" tabindex="32"
														    disabled="true"
															style="dataType: numeric; visibility:hidden;"/>
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
												<form:select path="mrtvo.caseVO.purchaseStatus" tabindex="33"
													  id="purchaseStatus"
															 cssClass="selectBoxStyle" style="dataType: alpha;">
													<form:options items="${addNewCandidate.mrtvo.caseVO.purchaseStatusList}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:select path="mrtvo.caseVO.purchaseStatus" tabindex="33"
															  id="purchaseStatus"
															 cssClass="selectBoxStyle" style="dataType: alpha;"
															 disabled="true">
													<form:options items="${addNewCandidate.mrtvo.caseVO.purchaseStatusList}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
											<jsp:attribute name="NONE">
												<form:select path="mrtvo.caseVO.purchaseStatus" tabindex="33"
															  id="purchaseStatus"
															 cssClass="selectBoxStyle" disabled="true"
															 style="dataType: alpha; visibility:hidden;">
													<form:options items="${addNewCandidate.mrtvo.caseVO.purchaseStatusList}"
																  itemLabel="name" itemValue="id" />
												</form:select>
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
						<div id="whs_details5" style="visibility: hidden; position: absolute;">
							<table width="100%">
								<tr>
									<td width="9%" align="right">
										<cps:renderByResourceAccess resourceId="105"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<label class="labelFont helpable" id="CodeDateLabel">Code Date</label>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<label class="labelFont helpable" id="CodeDateLabel">Code Date</label>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="left">&nbsp;
										<cps:renderByResourceAccess resourceId="105"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:checkbox path="mrtvo.caseVO.codeDate" id="codeDate"
															   tabindex="33"/>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:checkbox path="mrtvo.caseVO.codeDate" id="codeDate"
															  tabindex="33" disabled="true"/>
											</jsp:attribute>
											<jsp:attribute name="NONE">
												<form:checkbox path="mrtvo.caseVO.codeDate" id="codeDate"
															   tabindex="33" style="display:none;"/>
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
						<div id="whs_details6" style="visibility: hidden; position: absolute;">
							<div id="codeDateDiv" style="visibility: hidden; position: absolute;">
								<table width="100%">
									<tr align="left">
										<td align="right" width="10%">
											<cps:renderByResourceAccess	resourceId="106"
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
										<td align="left" width="15%">&nbsp;&nbsp;
											<cps:renderByResourceAccess	resourceId="106"
																		   honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<form:input path="mrtvo.caseVO.maxShelfLifeDays" id="shelfDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="34"
															  style="dataType: numeric;" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:input path="mrtvo.caseVO.maxShelfLifeDays" id="shelfDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="34"
															  style="dataType: numeric;"
																disabled="true" />
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="right" width="10%">
											<cps:renderByResourceAccess	resourceId="107"
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
										<td align="left" width="15%">&nbsp;&nbsp;
											<cps:renderByResourceAccess resourceId="107"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<form:input path="mrtvo.caseVO.inboundSpecificationDays" id="inboundDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="35"
														 style="dataType: numeric;" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:input path="mrtvo.caseVO.inboundSpecificationDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="35"
														 style="dataType: numeric;"
																disabled="true" id="inboundDays"/>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="right" width="10%">
											<cps:renderByResourceAccess resourceId="108"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<label class="labelFont helpable" id="ReactionLabel">
														Reaction Days <em><font color="red"><b>*</b></font></em>
													</label>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<label class="labelFont helpable" id="ReactionLabel">
														Reaction Days <em><font color="red"><b>*</b></font></em>
													</label>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="left" width="15%">&nbsp;&nbsp;
											<cps:renderByResourceAccess resourceId="108"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<form:input path="mrtvo.caseVO.reactionDays" id="reactionDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="36"
															 style="dataType: numeric;" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:input path="mrtvo.caseVO.reactionDays" id="reactionDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="36"
																  style="dataType: numeric;"
																disabled="true" />
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="right" width="10%">
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
										<td align="left" width="15%">&nbsp;&nbsp;
											<cps:renderByResourceAccess resourceId="109"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<form:input path="mrtvo.caseVO.guaranteetoStoreDays" id="guaranteestoreDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="37"
															  style="dataType: numeric;" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:input path="mrtvo.caseVO.guaranteetoStoreDays" id="guaranteestoreDays"
																cssClass="textFieldSmall" maxlength="4" tabindex="37"
																 style="dataType: numeric;"
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
				<tr>
					<td width="100%" colspan="2" align="left">
						<div id="whs_details7" style="visibility: hidden; position: absolute;">
							<div id="oneTuchTypeDiv" style="visibility: hidden; position: absolute;">
								<table width="100%" style="margin-left: -12px;">
									<tr>
										<td align="right" width="10%">
											<cps:renderByResourceAccess	resourceId="110"
																		   honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<label class="labelFont helpable" id="OneTouchLabel">1-Touch</label>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<label class="labelFont helpable" id="OneTouchLabel">1-Touch</label>
												</jsp:attribute>
												<jsp:attribute name="NONE">
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td width="30%" align="left" colspan="2">&nbsp;&nbsp;
											<cps:renderByResourceAccess resourceId="110"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<form:select path="mrtvo.caseVO.oneTouch" tabindex="38" id="oneTouchType"
																  cssClass="selectBoxStyle">
														<form:options items="${addNewCandidate.mrtvo.caseVO.touchTypeList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:select path="mrtvo.caseVO.oneTouch" tabindex="38" id="oneTouchType"
														 cssClass="selectBoxStyle"
																 disabled="true">
														<form:options items="${addNewCandidate.mrtvo.caseVO.touchTypeList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</jsp:attribute>
												<jsp:attribute name="NONE">
													<form:select path="mrtvo.caseVO.oneTouch" tabindex="38" id="oneTouchType"
																 disabled="true"   style="visibility: hidden;">
														<form:options items="${addNewCandidate.mrtvo.caseVO.touchTypeList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="right" width="10%">
											<cps:renderByResourceAccess resourceId="242"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<label class="labelFont helpable" id="OneTouchLabel">
														Item Category<em><font color="red"><b>*</b></font></em>
													</label>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<label class="labelFont helpable" id="OneTouchLabel">
														Item Category<em><font color="red"><b>*</b></font></em>
													</label>
												</jsp:attribute>
												<jsp:attribute name="NONE">
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td width="30%" align="left" colspan="2">&nbsp;&nbsp;
											<cps:renderByResourceAccess resourceId="242"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<form:select path="mrtvo.caseVO.itemCategory" tabindex="39" id="itmCategory"
															  cssClass="selectBoxStyle">
														<form:options items="${addNewCandidate.mrtvo.caseVO.itemCategoryList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<form:select path="mrtvo.caseVO.itemCategory" tabindex="39" id="itmCategory"
																 disabled="true"  cssClass="selectBoxStyle">
														<form:options items="${addNewCandidate.mrtvo.caseVO.itemCategoryList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</jsp:attribute>
												<jsp:attribute name="NONE">
													<form:select path="mrtvo.caseVO.itemCategory" tabindex="39"
																 disabled="true"  id="itmCategory"
																 style="visibility: hidden;">
														<form:options items="${addNewCandidate.mrtvo.caseVO.itemCategoryList}"
																	  itemLabel="name" itemValue="id" />
													</form:select>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
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
										<label class="labelFont helpable" id="displayReadyUnitlabel">
											Display	Ready Unit
										</label>
										<cps:renderByResourceAccess resourceId="81"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:checkbox path="mrtvo.caseVO.dsplyDryPalSw" id="dsplyDryPalSwId"
															   tabindex="105"
															   onclick="displayReadyUnitMRTClick();"/>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:checkbox path="mrtvo.caseVO.dsplyDryPalSw" id="dsplyDryPalSwId"
															   tabindex="105"
															   onclick="displayReadyUnitMRTClick();" disabled="true"/>
											</jsp:attribute>
											<jsp:attribute name="NONE">
												<form:checkbox path="mrtvo.caseVO.dsplyDryPalSw" id="dsplyDryPalSwId"
															    tabindex="105"
															   onclick="displayReadyUnitMRTClick();"
															   style="display:none;"/>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td width="85%">
										<div id="displayReadyfieldset">
											<fieldset style="width: 90%">
												<table width="100%">
													<tr>
														<td width="55%" valign="top">
															<div id="typeDisplayReadyUnitId">
																<table width="100%">
																	<tr>
																		<td width="50%" align="right">
																			<label class="labelFont helpable"
																				   id="typeDisplayReadyUnitlabel">
																				Type Of Display Ready Unit ?
																				<em><font color="red"><b>*</b></font></em>
																		</label>
																		</td>
																		<td width="50%" align="left">
																			<cps:renderByResourceAccess resourceId="81"
																										honorViewMode="${addNewCandidate.caseViewOverRide}">
																				<jsp:attribute name="EDIT">
																					<form:select id="srsAffTypCdId"
																								 path="mrtvo.caseVO.srsAffTypCd"
																								 tabindex="39"
																								 cssClass="selectBoxStyle"
																								 onchange="onReadyUnitChange(this);">
																						<form:options items="${addNewCandidate.mrtvo.caseVO.readyUnits}"
																									  itemLabel="name" itemValue="id" />
																					</form:select>
																				</jsp:attribute>
																				<jsp:attribute name="VIEW">
																					<form:select id="srsAffTypCdId"
																								 path="mrtvo.caseVO.srsAffTypCd"
																								 tabindex="39" disabled="true"
																								 cssClass="selectBoxStyle">
																						<form:options items="${addNewCandidate.mrtvo.caseVO.readyUnits}"
																									  itemLabel="name" itemValue="id" />
																					</form:select>
																				</jsp:attribute>
																				<jsp:attribute name="NONE">
																					<form:select id="srsAffTypCdId"
																								 path="mrtvo.caseVO.srsAffTypCd"
																								 tabindex="39" disabled="true"
																								 style="visibility: hidden;">
																						<form:options items="${addNewCandidate.mrtvo.caseVO.readyUnits}"
																									  itemLabel="name" itemValue="id" />
																					</form:select>
																				</jsp:attribute>
																			</cps:renderByResourceAccess>
																		</td>
																	</tr>
																</table>
															</div>
														</td>
														<td width="45%" valign="top">
															<div id="typeDisplayReadyUnitValue">
																<table width="100%">
																	<tr>
																		<td width="50%" align="left">
																			<label class="labelFont helpable"
																				   id="rowFactRetailsUnitId">
																				Rows Facing in Retail Units
																				<em><font color="red"><b>*</b></font></em>
																			</label>
																		</td>
																		<td width="50%">
																			<cps:renderByResourceAccess resourceId="81"
																										honorViewMode="${addNewCandidate.caseViewOverRide}">
																				<jsp:attribute name="EDIT">
																					<form:input id="prodFcngNbrId"
																								path="mrtvo.caseVO.prodFcngNbr"
																								cssClass="textFieldSmall" maxlength="4"

																								style="dataType: numeric;" />
																				</jsp:attribute>
																				<jsp:attribute name="VIEW">
																					<form:input id="prodFcngNbrId"
																								path="mrtvo.caseVO.prodFcngNbr"
																								cssClass="textFieldSmall" maxlength="4"
																								style="dataType: numeric;" disabled="true" />
																				</jsp:attribute>
																			</cps:renderByResourceAccess>
																		</td>
																	</tr>
																	<tr>
																		<td width="50%" align="left">
																			<label class="labelFont helpable"
																				   id="rowDeepRetailsUnitId">
																				Rows Deep in Retail Units
																				<em><font color="red"><b>*</b></font></em>
																			</label>
																		</td>
																		<td width="50%">
																			<cps:renderByResourceAccess resourceId="81"
																										honorViewMode="${addNewCandidate.caseViewOverRide}">
																				<jsp:attribute name="EDIT">
																					<form:input id="prodRowDeepNbrId"
																								path="mrtvo.caseVO.prodRowDeepNbr"
																								cssClass="textFieldSmall" maxlength="4"
																								style="dataType: numeric;" />
																				</jsp:attribute>
																				<jsp:attribute name="VIEW">
																					<form:input id="prodRowDeepNbrId"
																								path="mrtvo.caseVO.prodRowDeepNbr"
																								cssClass="textFieldSmall" maxlength="4"
																								style="dataType: numeric;" disabled="true" />
																				</jsp:attribute>
																			</cps:renderByResourceAccess>
																		</td>
																	</tr>
																	<tr>
																		<td width="50%" align="left">
																			<label class="labelFont helpable"
																				   id="rowHigtRetailsUnitId">
																				Rows High in Retail Units
																				<em><font color="red"><b>*</b></font></em>
																			</label>
																		</td>
																		<td width="50%">
																			<cps:renderByResourceAccess resourceId="81"
																										honorViewMode="${addNewCandidate.caseViewOverRide}">
																				<jsp:attribute name="EDIT">
																					<form:input id="prodRowHiNbrId"
																								path="mrtvo.caseVO.prodRowHiNbr"
																								cssClass="textFieldSmall" maxlength="4"
																								style="dataType: numeric;" />
																				</jsp:attribute>
																				<jsp:attribute name="VIEW">
																					<form:input id="prodRowHiNbrId"
																								path="mrtvo.caseVO.prodRowHiNbr"
																								cssClass="textFieldSmall" maxlength="4"
																								style="dataType: numeric;" disabled="true" />
																				</jsp:attribute>
																			</cps:renderByResourceAccess>
																		</td>
																	</tr>
																	<tr>
																		<td width="50%" align="left">
																			<label class="labelFont helpable"
																				   id="orientationOfDrp">
																			</label>
																		</td>
																		<td width="50%">
																			<cps:renderByResourceAccess resourceId="81"
																										honorViewMode="${addNewCandidate.caseViewOverRide}">
																				<jsp:attribute name="EDIT">
																					<form:select id="nbrOfOrintNbrId"
																								 path="mrtvo.caseVO.nbrOfOrintNbr"
																								 tabindex="39"
																								 cssClass="selectBoxStyleOrientationDRU">
																						<form:options items="${addNewCandidate.mrtvo.caseVO.orientations}"
																									  itemLabel="name" itemValue="id" />
																					</form:select>
																				</jsp:attribute>
																				<jsp:attribute name="VIEW">
																					<form:select id="nbrOfOrintNbrId"
																								 path="mrtvo.caseVO.nbrOfOrintNbr"
																								 tabindex="39" disabled="true"
																								 cssClass="selectBoxStyleOrientationDRU">
																						<form:options items="${addNewCandidate.mrtvo.caseVO.orientations}"
																									  itemLabel="name" itemValue="id" />
																					</form:select>
																				</jsp:attribute>
																				<jsp:attribute name="NONE">
																					<form:select id="nbrOfOrintNbrId"
																								 path="mrtvo.caseVO.nbrOfOrintNbr"
																								 tabindex="39" disabled="true"
																								 style="visibility: hidden;">
																						<form:options items="${addNewCandidate.mrtvo.caseVO.orientations}"
																									  itemLabel="name" itemValue="id" />
																					</form:select>
																				</jsp:attribute>
																			</cps:renderByResourceAccess>
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
				<!-- END Ready Unit  -->
			</table>
			<br />
			<div style="display: block; position: relative;" align="right" id="caseAddBut">
				<table bordercolor="red" border="0" width="100%">
					<tr>
						<td align="right">
							<cps:renderByResourceAccess resourceId="213"
														honorViewMode="${addNewCandidate.caseViewOverRide}">
								<jsp:attribute name="EXEC">
									<button type="button" id="saveMRTCase" name="saveMRTCase"
											value="SaveMRTCase" tabindex="40">Save MRT Case</button>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
					</tr>
				</table>
			</div>
		</fieldset>
	</div>
	<!--------------------- Case Details  Section Ends  -------------------->
	<BR />
	<!--------------------- Vendor  Section Begins  ------------------------>
	<c:if test="${addNewCandidate.mrtvo.existingMRT eq true}">
		<c:set value="display: block;" var="styleStr" />
	</c:if>
	<c:if test="${addNewCandidate.mrtvo.existingMRT eq false}">
		<c:set value="display: none;" var="styleStr" />
	</c:if>
	<div id="enableVendor" style="${styleStr}">
		<fieldset style="width: 95%; margin-left: 10px; border-collapse: collapse;" id="f5">
			<legend onclick="toggleVendor('f5');" style="cursor: pointer;">Existing Vendors</legend>
			<table id="vendorTable1" align="center" width="100%" cellspacing="0" cellpadding="2" class="dataGrid">
			</table>
			<br>
			<div id="existingVendors" style="min-width: 0;">
				<table width="100%" cellspacing="0" id="existingVendorsTable">
					<tbody id="vendorTable">
					<tr>
						<td class="dataGridHead" align="left" class="labelFont" width="5%">Vendor</td>
						<td class="dataGridHead" align="left" class="labelFont" width="10%">VPC</td>
						<td class="dataGridHead" align="left" class="labelFont" width="7%">Guaranteed Sale?</td>
						<td class="dataGridHead" class="labelFont" align="left" width="5%">Deal Offered?</td>
						<td class="dataGridHead" class="labelFont" align="left" width="5%">List Cost</td>
						<td class="dataGridHead" class="labelFont" align="left" width="7%">Cost Owner</td>
						<td class="dataGridHead" class="labelFont" align="left" width="7%">Top 2 Top</td>
						<td class="dataGridHead" class="labelFont" align="left" width="7%">Country of Origin</td>
						<td class="dataGridHead" class="labelFont" align="left" width="7%">Channel</td>
						<td class="dataGridHead" align="left" width="7%">&nbsp;</td>
					</tr>
					<c:set var="cnt" value="-1"></c:set>
					<c:forEach items="${addNewCandidate.mrtvo.caseVO.vendorVOs}" var="vendor" varStatus="loop" >
						<tr class="row${loop.index%2}" id="vendorRow${loop.index}"
							onclick="makeRowClickedForTable('vendorTable','vendorRow${loop.index}','${loop.index}','#FFAA00'); displayMRTVendorDetails('${loop.index}');">
							<td align="left" width="5%" class="row${loop.index%2}">
								<font class="labelFont">
									<c:out value="${vendor.vendorLocation}"></c:out>
								</font>
							</td>
							<td align="left" width="10%" class="row${loop.index%2}">
								<font class="labelFont">
									<c:out value="${vendor.vpc}"></c:out>
								</font>
							</td>
							<td align="left" width="7%" class="row${loop.index%2}">
								<c:choose>
									<c:when test="${vendor.guarenteedSale}">
										<input type="checkbox" disabled="disabled" checked="checked" id="guarSaleReal${loop.index}">
									</c:when>
									<c:otherwise>
										<input type="checkbox" disabled="disabled" id="guarSaleReal${loop.index}">
									</c:otherwise>
								</c:choose>
								<input type="hidden" id="vendorUniq${loop.index}" value="${vendor.uniqueId}" />
							</td>
							<td align="left" width="5%" class="row${loop.index%2}">
								<c:choose>
									<c:when test="${vendor.dealOffered}">
										<input type="checkbox" disabled="disabled" checked="checked" id="dealOffrdReal${loop.index}">
									</c:when>
									<c:otherwise>
										<input type="checkbox" disabled="disabled" id="dealOffrdReal${loop.index}">
									</c:otherwise>
								</c:choose>
							</td>
							<td align="left" width="5%" class="row${loop.index%2}">
								<font class="labelFont">
									<c:out value="${vendor.listCost}"></c:out>
								</font>
							</td>
							<td align="left" width="7%" class="row${loop.index%2}">
								<font class="labelFont">
									<c:out value="${vendor.costOwner}"></c:out>
								</font>
							</td>
							<td align="left" width="7%" class="row${loop.index%2}">
								<font class="labelFont">
									<c:out value="${vendor.top2Top}"></c:out>
								</font>
							</td>
							<td align="left" width="7%" class="row${loop.index%2}">
								<font class="labelFont">
									<c:out value="${vendor.countryOfOrigin}"></c:out>
								</font>
							</td>
							<td align="left" width="7%" class="row${loop.index%2}">
								<font class="labelFont">
									<c:out value="${vendor.channelByLocation}"></c:out>
								</font>
							</td>
							<td align="left" width="7%" class="row${loop.index%2}">&nbsp;</td>
						</tr>
						<c:set var="cnt" value="${loop.index}"></c:set>
					</c:forEach>
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
		</fieldset>
		<table width="97%" border="0" bordercolor="red" id="buttonsVendor">
			<tr>
				<td width="81%">&nbsp;</td>
				<td width="8%" align="right">
					<cps:renderByResourceAccess resourceId="189"
												honorViewMode="${addNewCandidate.caseViewOverRide}">
						<jsp:attribute name="EXEC">
							<div id="addVendor">
								<button id="addCaseDetailsBut">Add Vendor</button>
							</div>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
				<td width="8%" align="left">
					<cps:renderByResourceAccess resourceId="190"
												honorViewMode="${addNewCandidate.caseViewOverRide}">
						<jsp:attribute name="EXEC">
							<div id="deleteVendor">
								<button id="deleteVendorDetailsBut">Delete Vendor</button>
							</div>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
			</tr>
		</table>
		<br /> <br />
		<div id="selectedvendorDetailsDiv" style="position: relative; min-width: 0;"></div>
		<div id="vendorDetailsDiv" style="position: relative; min-width: 0;">
			<fieldset style="width: 95%; margin-left: 10px; border-collapse: collapse;" id="vendorDetailsFieldSet">
				<legend>Add New Vendor Details</legend>
				<table width="100%" border="0">
					<tr>
						<td width="100%" align="center">
							<table width="100%" border="0">
								<tr align="left">
									<td align="right" width="12%">
										<label class="labelFont helpable" id="VendorLabel">Vendor
											<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="12%" colspan="3">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="116"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<cps:autoCompleteVendor searchAction="vendorSearch"
																		uniqueId="vendor" compWidth="80%" tabIdx="40"
																		elmProperty="vendorVO.vendorLocationVal"
																		elmName="vendorVO.formattedVendorLocation"
																		highlightMatch="true" maxResults="999" searchOnId="true"
																		showId="true" zi="9000" maxCacheEntries="0"
																		onSelectMethod="setMrtCallAndResetDataCostList"
																		onSelectMethod1="getVendorChannelTypeNormal" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<input type="hidden" id="vendorLocationVal" />
												<input type="text" id="vendorLocation" disabled="disabled" style="width: 80%;" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="12%">
										<label class="labelFont helpable" id="VPCLabel">VPC
											<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="78"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<input type="text" id="vpc" maxlength="13" tabindex="41"
													   class="textFieldNormal" style="TEXT-TRANSFORM: uppercase; dataType: alphanumericSpecialOnly;" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<input type="text" id="vpc" maxlength="13" tabindex="41" class="textFieldNormal"
													   style="TEXT-TRANSFORM: uppercase; dataType: alphanumericSpecialOnly;" disabled="disabled" />
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
															<input type="checkbox" id="gSales" tabindex="42" size="1" />
														</jsp:attribute>
														<jsp:attribute name="VIEW">
															<input type="checkbox" id="gSales" tabindex="42" size="1" disabled="disabled" />
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
															<input type="checkbox" id="dealOffered" tabindex="43" size="1"/>
														</jsp:attribute>
														<jsp:attribute name="VIEW">
															<input type="checkbox" id="dealOffered" tabindex="43" size="1" disabled="disabled" />
														</jsp:attribute>
													</cps:renderByResourceAccess>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr align="left">
									<td align="right" width="12%">
										<c:if test="${addNewCandidate.viewMode eq false ||(addNewCandidate.mrtvo != null && addNewCandidate.mrtvo.caseVO != null && addNewCandidate.mrtvo.caseVO.channel !='DSD')}">
											<div id="venTie" style="display: block;">
												<label class="labelFont helpable" id="VendorTieLabel">
													Vendor Tie <em><font color="red"><b>*</b></font></em>
												</label>
											</div>
										</c:if>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<c:if test="${addNewCandidate.viewMode eq false || (addNewCandidate.mrtvo != null && addNewCandidate.mrtvo.caseVO != null && addNewCandidate.mrtvo.caseVO.channel !='DSD')}">
											<div id="venTieText" style="display: block;">
												<cps:renderByResourceAccess resourceId="102"
																			honorViewMode="${addNewCandidate.caseViewOverRide}">
													<jsp:attribute name="EDIT">
														<input type="text" id="vendorTie" maxlength="6" tabindex="45"
															   class="textFieldMedium" value="" style="dataType: numeric;"
															   onblur="validateNumber(this,'Vendor Tie'); return true;" />
													</jsp:attribute>
													<jsp:attribute name="VIEW">
														<input type="text" id="vendorTie" maxlength="6" tabindex="45"
															   class="textFieldMedium" value="" style="dataType: numeric;" disabled="disabled" />
													</jsp:attribute>
												</cps:renderByResourceAccess>
											</div>
										</c:if>
									</td>
									<td align="right" width="12%">
										<c:if test="${addNewCandidate.viewMode eq false || (addNewCandidate.mrtvo != null && addNewCandidate.mrtvo.caseVO != null && addNewCandidate.mrtvo.caseVO.channel !='DSD')}">
											<div id="venTier" style="display: block;">
												<label class="labelFont helpable" id="VendorTierLabel">
													Vendor Tier<em><font color="red"><b>*</b></font></em>
												</label>
											</div>
										</c:if>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<c:if test="${addNewCandidate.viewMode eq false || (addNewCandidate.mrtvo != null && addNewCandidate.mrtvo.caseVO != null && addNewCandidate.mrtvo.caseVO.channel !='DSD')}">
											<div id="venTierText" style="display: block;">
												<cps:renderByResourceAccess resourceId="103"
																			honorViewMode="${addNewCandidate.caseViewOverRide}">
													<jsp:attribute name="EDIT">
														<input type="text" id="vendorTier" maxlength="6" tabindex="46"
															   class="textFieldMedium" value="" style="dataType: numeric;"
															   onblur="validateNumber(this,'Vendor Tier'); return true;" />
													</jsp:attribute>
													<jsp:attribute name="VIEW">
														<input type="text" id="vendorTier" maxlength="6" tabindex="46"
															   class="textFieldMedium" value="" style="dataType: numeric;"
															   disabled="disabled" />
													</jsp:attribute>
												</cps:renderByResourceAccess>
											</div>
										</c:if>
									</td>
									<td align="right" width="12%">
										<label class="labelFont helpable" id="CountryOfOriginLabel">
											Country of Origin <em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="125"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:select path="vendorVO.countryOfOrigin" tabindex="47" id="countryOfOrigin"
															  cssClass="selectBoxStyle"
															 style="dataType: alpha;">
													<form:options items="${addNewCandidate.vendorVO.countryOfOriginList}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:select path="vendorVO.countryOfOrigin" tabindex="47" id="countryOfOrigin"
															  cssClass="selectBoxStyle"
															 style="dataType: alpha;" disabled="true">
													<form:options items="${addNewCandidate.vendorVO.countryOfOriginList}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
								</tr>
								<tr align="left">
									<td align="right" width="12%">
										<label class="labelFont helpable" id="CostOwnerLabel">
											Cost Owner<em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="124"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:select path="vendorVO.costOwner"  id="costOwner"
															 tabindex="48" onchange="cstOwnerChange()">
													<form:option value="">--Select--</form:option>
													<form:options items="${addNewCandidate.costOwners}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:select path="vendorVO.costOwner"
														  id="costOwner"
															 tabindex="48" disabled="true">
													<form:option value="">--Select--</form:option>
													<form:options items="${addNewCandidate.costOwners}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="12%">
										<label class="labelFont helpable" id="Top2TopLabel">
											Top 2 Top <em><font color="red"><b>*</b></font></em>
										</label>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="126"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:select path="vendorVO.top2Top" tabindex="49" id="top2Top"
															   cssClass="selectBoxStyle">
													<form:option value="">--Select--</form:option>
													<form:options items="${addNewCandidate.topToTops}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:select path="vendorVO.top2Top" tabindex="49" id="top2Top"
															 cssClass="selectBoxStyle"
															 disabled="true">
													<form:options items="${addNewCandidate.topToTops}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="12%">
										<label class="labelFont helpable" id="SeasonalityYrLabel">
											Seasonality Yr
										</label>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="123"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<input type="text" id="seasonalityYear" maxlength="4" tabindex="50"
													   class="textFieldMedium" value="" style="dataType: numeric;" onblur="dateCheck();" />
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<input type="text" id="seasonalityYear" maxlength="4" tabindex="50"
													   class="textFieldMedium" value="" style="dataType: integer;" disabled="disabled" />
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td align="right" width="12%">
										<label class="labelFont helpable" id="SeasonalityLabel">Seasonality</label></td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<cps:renderByResourceAccess resourceId="127"
																	honorViewMode="${addNewCandidate.caseViewOverRide}">
											<jsp:attribute name="EDIT">
												<form:select path="vendorVO.seasonality" tabindex="51" id="seasonality"
															   cssClass="selectBoxStyle"
															 style="dataType: alpha;" value="13">
													<form:options items="${addNewCandidate.vendorVO.seasonalityList}"
																  itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
											<jsp:attribute name="VIEW">
												<form:select path="vendorVO.seasonality" tabindex="51" id="seasonality"
														  cssClass="selectBoxStyle"
															 style="dataType: alpha;" disabled="true" value="13">
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
														<div id="costLinkLabel" style="display: block;">
															<label class="labelFont helpable" id="CostLinkRadioLabel">
																Cost Link By&nbsp;&nbsp;
															</label>
														</div>
													</td>
													<td align="left" width="24%">&nbsp;&nbsp;
														<div id="costLink">
															<cps:renderByResourceAccess resourceId="191"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<select id="costLinkBy" onchange="changeCostLinkBy(this)"
																			class="selectBoxStyle3" tabindex="52">
																		<option value="">--Select--</option>
																		<option value="cl">Cost Link #</option>
																		<option value="ic">Item Code</option>
																	</select>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<select id="costLinkBy"
																			onchange="changeCostLinkBy(this)" disabled="disabled"
																			class="selectBoxStyle3" tabindex="52">
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
															<label class="labelFont helpable" id="ItemRadioLabel">
																Item Code
															</label>
														</div>
														<div id="costlistDiv" style="display: block;">
															<cps:renderByResourceAccess resourceId="191"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="costlist" maxlength="13"
																		   tabindex="54" class="textFieldNormal" value=""
																		   onblur="calculateListCost();"
																		   style="dataType: numeric;" disabled="disabled" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="costlist" maxlength="13"
																		   tabindex="54" class="textFieldNormal" value=""
																		   onblur="calculateListCost();"
																		   style="dataType: numeric;" disabled="disabled" />
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
													<td align="left" width="24%">&nbsp;&nbsp;
														<cps:renderByResourceAccess resourceId="120"
																					honorViewMode="${addNewCandidate.caseViewOverRide}">
															<jsp:attribute name="EDIT">
																<input type="text" id="listCost" maxlength="11"
																	   tabindex="44" class="textFieldMedium" style="dataType: float;"
																	   onkeydown="return onKeyDownListCost(event, this);"
																	   onblur="validateListCost(this);calculateUnitCostMRT();return true;" />
															</jsp:attribute>
															<jsp:attribute name="VIEW">
																<input type="text" id="listCost" maxlength="11"
																	   tabindex="44" class="textFieldMedium"
																	   style="dataType: float;" disabled="disabled" />
															</jsp:attribute>
														</cps:renderByResourceAccess>
													</td>
													<td align="right" width="12%">
														<label class="labelFont helpable" id="UnitCost1Label">
															Unit Cost
														</label>
													</td>
													<td align="left" width="10%">&nbsp;&nbsp;
														<label id="unitCostLabel" class="labelFont"></label>
													</td>
												</tr>
												<!-- Hungbang added enhancement % Margin & Penny Profit -->
												<tr>
													<td align="right" width="24%">
														<label class="labelFont helpable" id="LabelPercentMargin">
															% Margin
														</label>
													</td>
													<td align="left" width="24%">&nbsp;&nbsp;
														<label id="percentMarginLabel" class="labelFont"></label>
													</td>
													<td align="right" width="12%">
														<label class="labelFont helpable" id="LabelPennyProfit">
															Penny Profit
														</label>
													</td>
													<td align="left" width="10%">&nbsp;&nbsp;
														<label id="pennyProfitLabel" class="labelFont"></label>
													</td>
													<input type="hidden" id="marginWarningId" />
													<td align="left" width="5%">
														<img id="profitWarning" src="${iconRedStar}"
															 onclick="return warningProfit();"
															 style="display: none;" width="10" height="10" />
													</td>
												</tr>
											</table>
										</fieldset>
									</td>
									<td colspan="4">
										<table width="100%">
											<tr>
												<td align="right" width="12%">
													<div id="orderUnitLabelDiv" style="display: block;">
														<cps:renderByResourceAccess resourceId="258"
																					honorViewMode="${addNewCandidate.caseViewOverRide}">
															<jsp:attribute name="EDIT">
																<label class="labelFont helpable" id="OrderUnitLabel">Order Unit </label>
															</jsp:attribute>
															<jsp:attribute name="VIEW">
																<label class="labelFont helpable" id="OrderUnitLabel">Order Unit </label>
															</jsp:attribute>
														</cps:renderByResourceAccess>
													</div>
												</td>
												<td align="left" width="12%">&nbsp;&nbsp;
													<div id="orderUnitDiv" style="display: block;">&nbsp;&nbsp;
														<cps:renderByResourceAccess resourceId="258"
																					honorViewMode="${addNewCandidate.caseViewOverRide}">
															<jsp:attribute name="EDIT">
																<form:select path="vendorVO.orderUnit" tabindex="55"
																			  cssClass="selectBoxStyle3"
																			 onchange="onChangeOrderUnit(this)"
																			 style="dataType: alpha;" id="orderUnit">
																	<form:options items="${addNewCandidate.vendorVO.orderUnitList}"
																				  itemLabel="name" itemValue="id" />
																</form:select>
															</jsp:attribute>
															<jsp:attribute name="VIEW">
																<form:select path="vendorVO.orderUnit" tabindex="55"
																		  cssClass="selectBoxStyle3"
																			 style="dataType: alpha;" disabled="true"
																			 id="orderUnit">
																	<form:options items="${addNewCandidate.vendorVO.orderUnitList}"
																				  itemLabel="name" itemValue="id" />
																</form:select>
															</jsp:attribute>
															<jsp:attribute name="NONE">
																<form:select path="vendorVO.orderUnit" tabindex="55"
																			 cssClass="selectBoxStyle3"
																			 style="dataType: alpha; visibility: hidden;" id="orderUnit">
																	<form:options items="${addNewCandidate.vendorVO.orderUnitList}"
																				  itemLabel="name" itemValue="id" />
																</form:select>
															</jsp:attribute>
														</cps:renderByResourceAccess>
													</div>
												</td>
											</tr>
											<tr align="left">
												<td align="right" width="15%">
													<table>
														<tr>
															<td width="14%">
																<label class="labelFont helpable" id="ExpWeekMovLabel">
																	Expected Weekly Movement
																</label>
															</td>
															<td width="1%">
																<div class="labelFont" id="ewmMandatory" style="display: block;">
																	<em><font color="red"><b>*</b></font></em>
																</div>
															</td>
														</tr>
													</table>
												</td>
												<td align="left" width="11%">
													<cps:renderByResourceAccess resourceId="208"
																				honorViewMode="${addNewCandidate.caseViewOverRide}">
														<jsp:attribute name="EDIT">
															<input type="text" tabindex="55" id="expectedweeklymovement"
																   maxlength="5" style="dataType: numeric;"
																   onblur="validateNumber(this,'Expected Weekly Movement');validateExpected();" />
														</jsp:attribute>
														<jsp:attribute name="VIEW">
															<input type="text" tabindex="55" id="expectedweeklymovement"
																   maxlength="5" style="dataType: numeric;"
																   onblur="validateNumber(this,'Expected Weekly Movement');validateExpected();"
																   disabled="disabled" />
														</jsp:attribute>
													</cps:renderByResourceAccess>
												</td>
												<td align="right" width="12%">
													<div id="orderResLabel" style="display: block;">
														<cps:renderByResourceAccess resourceId="244"
																					honorViewMode="${addNewCandidate.caseViewOverRide}">
															<jsp:attribute name="EDIT">
																<label class="labelFont helpable" id="OrderRestrictionLabel">Order Restriction</label>
															</jsp:attribute>
															<jsp:attribute name="VIEW">
																<label class="labelFont helpable" id="OrderRestrictionLabel">Order Restriction</label>
															</jsp:attribute>
														</cps:renderByResourceAccess>
													</div>
												</td>
												<td align="left" width="12%">&nbsp;&nbsp;
													<div id="orderRes" style="display: block;">
														<cps:renderByResourceAccess resourceId="244"
																					honorViewMode="${addNewCandidate.caseViewOverRide}">
															<jsp:attribute name="EDIT">
																<form:select path="vendorVO.orderRestriction"
																			 tabindex="55" id="orderRestriction"
																			  cssClass="selectBoxStyle"
																			 style="dataType: alpha;">
																	<form:options items="${addNewCandidate.vendorVO.orderRestrictionList}"
																				  itemLabel="name" itemValue="id" />
																</form:select>
															</jsp:attribute>
															<jsp:attribute name="VIEW">
																<form:select path="vendorVO.orderRestriction"
																			 tabindex="55"
																			 cssClass="selectBoxStyle"
																			 id="orderRestriction"
																			 style="dataType: alpha;" disabled="true">
																	<form:options items="${addNewCandidate.vendorVO.orderRestrictionList}"
																				  itemLabel="name" itemValue="id" />
																</form:select>
															</jsp:attribute>
															<jsp:attribute name="NONE">
																<form:select path="vendorVO.orderRestriction"
																			 tabindex="55" id="orderRestriction"
																			 cssClass="selectBoxStyle"
																			 style="dataType: alpha; visibility: hidden;">
																	<form:options items="${addNewCandidate.vendorVO.orderRestrictionList}"
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
							</table>
						</td>
					</tr>
				</table>
				<table width="97%">
					<tr>
						<td>
							<div id="importOnly" style="visibility: hidden; position: relative; min-width: 0;">
								<table width="97%">
									<tr align="left">
										<td align="right" width="5%" colspan="3">
											<label class="labelFont helpable" id="ImportLabel">Import</label>
										</td>
										<td align="left" width="12%">&nbsp;&nbsp;
											<cps:renderByResourceAccess resourceId="122"
																		honorViewMode="${addNewCandidate.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<c:if test="${selectedVendorVO.importd eq 'true'}">
														<input type="checkbox" id="import" tabindex="215"
															   onclick="importClicked();" checked="checked" />
													</c:if>
													<c:if test="${selectedVendorVO.importd eq 'false' || selectedVendorVO.importd ==null || selectedVendorVO.importd ==''}">
														<input type="checkbox" id="import" tabindex="215" onclick="importClicked();" />
													</c:if>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<script language='text/javascript'>
														alert("${selectedVendorVO.importd}");
													</script>
													<c:if test="${selectedVendorVO.importd eq 'true'}">
														<input type="checkbox" id="import" tabindex="215"
															   checked="checked" disabled="disabled" />
													</c:if>
													<c:if test="${selectedVendorVO.importd eq 'false' || selectedVendorVO.importd ==null || selectedVendorVO.importd ==''}">
														<input type="checkbox" id="import" tabindex="215" disabled="disabled" />
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
				<table width="97%">
					<tr>
						<td>
							<div id="importDiv" style="display: none; position: relative; min-width: 0;">
								<fieldset style="width: 100%; margin-left: 10px; border-collapse: collapse;" id="f2">
									<legend id="caseDetailsLegend">Import Attributes</legend>
									<table width="100%" border="0">
										<tr>
											<td width="100%" align="center">
												<table border="0" width="100%" align="center">
													<tr align="left">
														<td align="right" width="12%">
															<label class="labelFont helpable" id="ContainerLabel">
																Container Size <em><font color="red"><b>*</b></font></em>
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="129"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<select id="cntnSize" tabindex="57">
																		<c:forEach var="cntsize" items="${addNewCandidate.containerList}">
																			<c:if test="${cntsize.id eq selectedVendorVO.importVO.containerSize}">
																				<option value="${cntsize.id}" selected="selected">${cntsize.name}</option>
																			</c:if>
																			<c:if test="${cntsize.id ne selectedVendorVO.importVO.containerSize}">
																				<option value="${cntsize.id}">${cntsize.name}</option>
																			</c:if>
																		</c:forEach>
																	</select>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<select id="cntnSize" tabindex="57" disabled="disabled">
																		<c:forEach var="cntsize" items="${addNewCandidate.containerList}">
																			<c:if test="${cntsize.id eq selectedVendorVO.importVO.containerSize}">
																				<option value="${cntsize.id}" selected="selected">${cntsize.name}</option>
																			</c:if>
																			<c:if test="${cntsize.id ne selectedVendorVO.importVO.containerSize}">
																				<option value="${cntsize.id}">${cntsize.name}</option>
																			</c:if>
																		</c:forEach>
																	</select>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="IncoTermsLabel">
																Inco Terms<em><font color="red"><b>*</b></font></em>
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="134"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<select id="incoTerms" tabindex="58">
																		<c:forEach var="inco" items="${addNewCandidate.incoList}">
																			<c:if test="${inco.id eq selectedVendorVO.importVO.incoTerms}">
																				<option value="${inco.id}" selected="selected">${inco.name}</option>
																			</c:if>
																			<c:if test="${inco.id ne selectedVendorVO.importVO.incoTerms}">
																				<option value="${inco.id}">${inco.name}</option>
																			</c:if>
																		</c:forEach>
																	</select>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<select id="incoTerms" tabindex="58" disabled="disabled" />
																	<c:forEach var="inco" items="${addNewCandidate.incoList}">
																		<c:if test="${inco.id eq selectedVendorVO.importVO.incoTerms}">
																			<option value="${inco.id}" selected="selected">${inco.name}</option>
																		</c:if>
																		<c:if test="${inco.id ne selectedVendorVO.importVO.incoTerms}">
																			<option value="${inco.id}">${inco.name}</option>
																		</c:if>
																	</c:forEach>
																	</select>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="PickupPointLabel">
																Pickup Point <em><font color="red"><b>*</b></font></em>
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="130"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="pcikPoint" maxlength="20" tabindex="59"
																		   class="textFieldNormal"
																		   value="${selectedVendorVO.importVO.pickupPoint}" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="pcikPoint" maxlength="20" tabindex="59"
																		   class="textFieldNormal"
																		   value="${selectedVendorVO.importVO.pickupPoint}"
																		   disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
													</tr>
													<tr align="left">
														<td align="right" width="12%">
															<label class="labelFont helpable" id="RatePerLabel">
																Duty % <em><font color="red"><b>*</b></font></em>
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="136"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="rate" maxlength="6" tabindex="60"
																		   class="textFieldSmall"
																		   value="${selectedVendorVO.importVO.rate}"
																		   style="dataType: float;"
																		   onblur="roundValue(this,2);return true;" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="rate" maxlength="6" tabindex="60"
																		   class="textFieldSmall"
																		   value="${selectedVendorVO.importVO.rate}"
																		   style="dataType: float;"
																		   onblur="roundValue(this,2);return true;"
																		   disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="DutyInfoLabel">
																Duty Info
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="133"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" maxlength="20" tabindex="61"
																		   class="textFieldNormal"
																		   value="${selectedVendorVO.importVO.dutyInfo}"
																		   id="dutyInfo" style="dataType: alphanumeric;" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" maxlength="20" tabindex="61"
																		   class="textFieldNormal"
																		   value="${selectedVendorVO.importVO.dutyInfo}"
																		   disabled="disabled" id="dutyInfo"
																		   style="dataType: alphanumeric;" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" maxlength="20" tabindex="61"
																		   class="textFieldNormal"
																		   value="${selectedVendorVO.importVO.dutyInfo}"
																		   disabled="disabled" id="dutyInfo"
																		   style="dataType: alphanumeric;" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="MinQtyLabel">
																Minimum Qty<em><font color="red"><b>*</b></font></em>
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="132"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="minQntity" maxlength="7" tabindex="62"
																		   class="textFieldSmall"
																		   value="${selectedVendorVO.importVO.minimumQty}"
																		   style="dataType: numeric;" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="minQntity" maxlength="7" tabindex="62"
																		   class="textFieldSmall"
																		   value="${selectedVendorVO.importVO.minimumQty}"
																		   style="dataType: numeric;" disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="MiniTypeLabel">
																Min.Order Description<em><font color="red"><b>*</b></font></em>
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="137"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="minType" maxlength="20" tabindex="63"
																		   class="textFieldNormal" onblur="onBlurMinType(this)"
																		   value="${selectedVendorVO.importVO.minimumType}" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="minType" maxlength="20" tabindex="63"
																		   class="textFieldNormal"
																		   value="${selectedVendorVO.importVO.minimumType}"
																		   disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
													</tr>
													<tr>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="HTSLabel">
																HTS1<em><font color="red"><b>*</b></font></em></label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="195"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="hts" maxlength="10" tabindex="64"
																		   class="textFieldNormal"
																		   value="${selectedVendorVO.importVO.hts}"
																		   onblur="isNumericAndPadHts(this);"
																		   style="dataType: numeric;" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="hts" maxlength="10" tabindex="64"
																		   class="textFieldNormal"
																		   value="${selectedVendorVO.importVO.hts}"
																		   onblur="isNumericAndPadHts(this);"
																		   style="dataType: numeric;" disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="254"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="HTS2Label">HTS2</label>
																</jsp:attribute>
															<jsp:attribute name="VIEW">
																<label class="labelFont helpable" id="HTS2Label">HTS2</label>
															</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="254"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" value="${selectedVendorVO.importVO.hts2}"
																		   id="hts2" maxlength="10" tabindex="65"
																		   class="textFieldNormal"
																		   onblur="isNumericAndPadHts(this);"
																		   style="dataType: numeric;" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" value="${selectedVendorVO.importVO.hts2}"
																		   id="hts2" maxlength="10" tabindex="65"
																		   class="textFieldNormal" disabled="disabled"
																		   onblur="isNumericAndPadHts(this);"
																		   style="dataType: numeric;" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" value="${selectedVendorVO.importVO.hts2}"
																		   id="hts2" maxlength="10" tabindex="65"
																		   class="textFieldNormal" disabled="disabled"
																		   style="dataType: numeric; display: none;" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<cps:renderByResourceAccess resourceId="255"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<label class="labelFont helpable" id="HTS3Label">HTS3</label>
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<label class="labelFont helpable" id="HTS3Label">HTS3</label>
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="255"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" value="${selectedVendorVO.importVO.hts3}"
																		   id="hts3" maxlength="10" tabindex="66"
																		   class="textFieldNormal" onblur="isNumericAndPadHts(this);"
																		   style="dataType: numeric;" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" value="${selectedVendorVO.importVO.hts3}"
																		   id="hts3" maxlength="10" tabindex="66"
																		   class="textFieldNormal" disabled="disabled"
																		   onblur="isNumericAndPadHts(this);"
																		   style="dataType: numeric;" />
																</jsp:attribute>
																<jsp:attribute name="NONE">
																	<input type="text" value="${selectedVendorVO.importVO.hts3}"
																		   id="hts3" maxlength="10" tabindex="66"
																		   class="textFieldNormal" disabled="disabled"
																		   style="dataType: numeric; display: none;" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="ColorLabel">
																Product Color<em><font color="red"><b>*</b></font></em>
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="133"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="color" maxlength="50" tabindex="67"
																		   class="textFieldNormal"
																		   value="${selectedVendorVO.importVO.color}" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="color" maxlength="50" tabindex="67"
																		   class="textFieldNormal"
																		   value="${selectedVendorVO.importVO.color}"
																		   disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
													</tr>
													<tr>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="AgentLabel">
																Agent%<em><font color="red"><b>*</b></font></em>
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="197"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="agentPer" maxlength="6" tabindex="68"
																		   class="textFieldNormal" value="${selectedVendorVO.importVO.agentPerc}"
																		   style="dataType: float;" onblur="roundValue(this,2);return true;" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="agentPer" maxlength="6" tabindex="68"
																		   class="textFieldNormal" value="${selectedVendorVO.importVO.agentPerc}"
																		   style="dataType: float;" onblur="roundValue(this,2);return true;"
																		   disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="CartonMarkLabel">
																Carton Marketing<em><font color="red"><b>*</b></font></em>
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="199"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="cartMarketing" maxlength="30"
																		   tabindex="69" class="textFieldNormal"
																		   value="${selectedVendorVO.importVO.cartonMarketing}" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="cartMarketing" maxlength="30"
																		   tabindex="69" class="textFieldNormal"
																		   value="${selectedVendorVO.importVO.cartonMarketing}"
																		   disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="DutyLabel">
																Duty Confirmed<em><font color="red"><b>*</b></font></em>
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="196"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="duty" maxlength="20" tabindex="70"
																		   style="width: 70%" value="${selectedVendorVO.importVO.duty}"
																		   onblur="validateDateUsingDWR(this,'Duty Confirmed');" />
																	<img src="${calend}" id="dutyCalend" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="duty" maxlength="20" tabindex="70"
																		   style="width: 70%" value="${selectedVendorVO.importVO.duty}"
																		   disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="FreightLabel">
																Freight Confirmed <em><font color="red"><b>*</b></font></em>
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="131"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="freight" maxlength="20" tabindex="71"
																		   style="width: 70%" value="${selectedVendorVO.importVO.freight}"
																		   onblur="validateDateUsingDWR(this,'Freight Confirmed');" />
																	<img src="${calend1}" id="freights" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="freight" maxlength="20" tabindex="71"
																		   class="textFieldNormal" style="width: 70%"
																		   value="${selectedVendorVO.importVO.freight}"
																		   style="dataType: alphanumericOnly;" disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%"></td>
														<td align="left" width="12%">&nbsp;</td>
													</tr>
													<tr>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="ProDateLabel">
																Proration Date
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="135"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="prorDate" maxlength="10" tabindex="72"
																		   class="textFieldMedium" value="${selectedVendorVO.importVO.prorationDate}"
																		   onblur="validateDateUsingDWR(this,'Proration Date');" />
																	<img src="${calend}" id="propDate" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="prorDate" maxlength="10" tabindex="72"
																		   class="textFieldMedium" value="${selectedVendorVO.importVO.prorationDate}"
																		   onblur="validateDateUsingDWR(this,'Proration Date');"
																		   disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="InstoreDateLabel">
																Instore Date
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="138"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="instoreDate" maxlength="10" tabindex="73"
																		   class=""
																		   value="${selectedVendorVO.importVO.instoreDate}"
																		   onblur="validateDateUsingDWR(this,'Instore Date');" />
																	<img src="${calen}" id="storeDate" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="instoreDate" maxlength="10" tabindex="73"
																		   class="" value="${selectedVendorVO.importVO.instoreDate}"
																		   onblur="validateDateUsingDWR(this,'Instore Date');"
																		   disabled="disabled" />
																</jsp:attribute>
															</cps:renderByResourceAccess>
														</td>
														<td align="right" width="12%">
															<label class="labelFont helpable" id="WHSEDateLabel">
																Whse Flush Date
															</label>
														</td>
														<td align="left" width="12%">&nbsp;&nbsp;
															<cps:renderByResourceAccess resourceId="198"
																						honorViewMode="${addNewCandidate.caseViewOverRide}">
																<jsp:attribute name="EDIT">
																	<input type="text" id="whseFlushDate" maxlength="10" tabindex="74"
																		   value="${selectedVendorVO.importVO.whseFlushDate}"
																		   onblur="validateDateUsingDWR(this,'Whse Flush Date');" />
																	<img src="${cal}" id="flushDate" />
																</jsp:attribute>
																<jsp:attribute name="VIEW">
																	<input type="text" id="whseFlushDate" maxlength="10" tabindex="74"
																		   value="${selectedVendorVO.importVO.whseFlushDate}"
																		   onblur="validateDateUsingDWR(this,'Whse Flush Date');"
																		   disabled="disabled" />
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
																		<button id="importFacilities" disabled="disabled">Import Factory</button>
																	</jsp:attribute>
																</cps:renderByResourceAccess>
															</div>
															<input type="hidden" id="factoryList"
																   value="${selectedVendorVO.importVO.factoryList}">
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
				<br />
				<!-- Add New Attribute-->
				<table width="100%">
					<tr>
						<td align="left" width="35%">
							<cps:renderByResourceAccess resourceId="174">
								<jsp:attribute name="EXEC">
									<button type="button" id="reqAttribute" name="button1"
											value="requestnewattribute" tabindex="9">Request New Attribute
									</button>
								</jsp:attribute>
							</cps:renderByResourceAccess>
						</td>
					</tr>
				</table>
				<br />
				<table width="97%">
					<tr>
						<td>
							<div id="buttonDiv" style="display: block; position: relative; min-width: 0;">
								<table>
									<tr align="left">
										<td align="right" width="12%"><label class="labelFont"></label></td>
										<td align="left" width="12%">&nbsp;&nbsp;</td>
										<td align="right" width="12%"><label class="labelFont"></label></td>
										<td align="left" width="12%">&nbsp;&nbsp;
											<div style="position: relative; min-width: 0;" id="saveVendor">
												<cps:renderByResourceAccess resourceId="192"
																			honorViewMode="${addNewCandidate.caseViewOverRide}">
													<jsp:attribute name="EXEC">
														<button id="addButton6" tabindex="75">Save Vendor</button>
													</jsp:attribute>
												</cps:renderByResourceAccess>
											</div>
										</td>
										<td align="right" width="12%">
											<div id="enableAuthorizeWHS" style="display: none;">
												<cps:renderByResourceAccess resourceId="194"
																			honorViewMode="${addNewCandidate.caseViewOverRide}">
													<jsp:attribute name="EXEC">
														<button id="authWHS" tabindex="76">Authorize WHS</button>
													</jsp:attribute>
												</cps:renderByResourceAccess>
											</div>
											<div id="enableAuthorizeStore" style="display: none;">
												<cps:renderByResourceAccess resourceId="193"
																			honorViewMode="${addNewCandidate.caseViewOverRide}">
													<jsp:attribute name="EXEC">
														<button id="authStore" tabindex="77">Authorize Store</button>
													</jsp:attribute>
												</cps:renderByResourceAccess>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>
				<!-- Request New Attribute -->
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
		</div>
	</div>
	<!--------------------- Vendor  Section Ends  ---------------------->
	<br />
	</body>

	<style type="text/css">
		#addCaseBut button {
			width: 8em;
		}

		#deleteBut button {
			width: 8em;
		}

		#AVupc button {
			width: 8em;
		}

		#addCaseDetailsBut button {
			width: 8em;
		}

		#deleteVendorDetailsBut button {
			width: 8em;
		}

		#addButton6 button {
			width: 8em;
		}

		#backButton button {
			width: 8em;
		}
	</style>

	<script type="text/javascript">
        but = new YAHOO.widget.Button("addButton6");
        YAHOO.util.Event.removeListener("addButton6", "click");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", addMRTVendor);
        // YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", saveCaseAndVendor);

        but = new YAHOO.widget.Button("addCaseDetailsBut");
        YAHOO.util.Event.removeListener("addCaseDetailsBut", "click");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addCaseDetailsBut"), "click", showMRTVendorDetailsToAdd);

        but = new YAHOO.widget.Button("deleteVendorDetailsBut");
        YAHOO.util.Event.removeListener("deleteVendorDetailsBut", "click");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteVendorDetailsBut"), "click", deleteVendorDetailsForMrt);

        YAHOO.util.Event.onDOMReady(makeFirstItemClicked);

        new YAHOO.widget.Button("importFacilities");//R2
        YAHOO.util.Event.removeListener("importFacilities", "click");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("importFacilities"), "click", importFacilitiesMRT);//R2

        new YAHOO.widget.Button("reqAttribute");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("reqAttribute"), "click", reqAttributeClick);

        var oPushButton1 = new YAHOO.widget.Button("saveMRTCase");
        var oPushButton2 = new YAHOO.widget.Button("mrtAddButton");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveMRTCase"), "click", verifyCheckDigitForCaseUPCMRT);
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("codeDate"), "click", checkedCodeDate);
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("mrtAddButton"), "click", addMrt);
        var unitUPC = YAHOO.util.Dom.get("unitUPC");
        var sellableUnits = YAHOO.util.Dom.get("sellableUnits");
        var unitUPCCheckDigit = YAHOO.util.Dom.get("unitUPCCheckDigit");

        function autotab1(original,unitUPCCheckDigit){
            if(original.value.length == original.getAttribute("maxlength")){
                document.getElementById('unitUPCCheckDigit').focus();
            }
        }
        function verifyCheckDigit(){
            var unitUPCValue = unitUPC.value;
            var unitUPCCheckDigitValue = unitUPCCheckDigit.value;
            if(unitUPCCheckDigitValue!="" && null != unitUPCCheckDigitValue) {
                // showProgress();
                AddCandidateTemp.verifyCheckDigit(unitUPCValue,unitUPCCheckDigitValue,getDWRCallbackMethod(returnData));
            }
        }

        function returnData(data) {
            hideProgress();
            if('firstTimeError' == data.message || 'secondTimeError' == data.message){
                unitUPC.focus();
                unitUPC.select();
                alert('InValid Check Digit. Please Re-enter the UPC/Checkdigit Value');
            }else if('numberFormatError' == data.message){
                unitUPC.focus();
                unitUPC.select();
                alert('Unit UPC/check digit should be in number format');
            }
        }

        function addMrt(){
            var unitUPCValue = unitUPC.value;
            var unitUPCCheckDigitValue = unitUPCCheckDigit.value;
            var sellableUnitsValue = sellableUnits.value;
            if(null != sellableUnitsValue && "" != sellableUnitsValue && "0" != sellableUnitsValue){
                if(sellableUnitsValue.indexOf('0')==0){
					/*Because it checked number  */
                    sellableUnitsValue = Number(sellableUnitsValue);
                    sellableUnits.value = sellableUnitsValue;
                }
                if(unitUPCCheckDigitValue!="" && null != unitUPCCheckDigitValue) {
                    showProgress();
                    AddCandidateTemp.showMRT(unitUPCValue,unitUPCCheckDigitValue,sellableUnitsValue,getDWRCallbackMethod(addRowToMRTTable));
                }
                else {
                    alert('Please enter the Check Digit');
                    return true;
                }
            }else{
                if("0" == sellableUnitsValue){
                    alert('Sellable units should be greater than 0');
                } else if(sellableUnitsValue.indexOf('0')==0){
                    alert('Sellable units should be a number');
                } else {
                    alert('Please enter the Sellable Units');
                }
            }
        }

        var addCount = 0;
        var mrtTableBody = document.getElementById("mrtTable");
        var mrtSize = ${addNewCandidate.mrtvo.mrtvoSize};

        function addRowToMRTTable(data){
            hideProgress();
            if(data.message !="" && data.message !=null) {
                alert(data.message);
                document.getElementById("unitUPCCheckDigit").value ="";
            }
            else {
                if(data.existingMRT) {
                    document.getElementById('enableVendor').style.display = 'block';
                    YAHOO.util.Event.removeListener("actions3", "change");
                    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("actions3"), "change", selectChannelMRT);
                    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("actions3"), "change", fillVendorDetailsCheck);
                }
                else {
                    document.getElementById('enableVendor').style.display = 'none';
                    YAHOO.util.Event.removeListener("actions3", "change");
                    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("actions3"), "change", selectChannelMRT);
                }
                document.getElementById("unitUPC").value =data.unitUPC;
                addCount++;
                var rowLength = mrtTableBody.rows.length;
                var newRow = mrtTableBody.insertRow(-1);
                newRow.id = "caseAjax"+addCount;
                newRow.style.fontFamily = 'Verdana, Arial, Helvetica, sans-serif';
                newRow.style.fontSize = '12px';
                var classAppend = rowLength % 2;
                if(classAppend == 0){
                    var col;
                    col = "#F7F7F7";
                }else{
                    col = "#FFFFFF";
                }
                rowLength--;
                <c:url var="img" value="${request.getContextPath()}/hebAssets/images/newButtons/delete_normal.gif"/>
                <c:url var="imgOver" value="${request.getContextPath()}/hebAssets/images/newButtons/delete_mouseclick.gif"/>

                var butId = "checkAjax"+addCount;
                var del = "<input type='button' id='"+butId+"' value='Remove'>";
                var description = "<div><a href='#' target='_parent' id ='"+data.unitUPC +"'onclick='javascript:return false;' >" +data.description	+
                    "</a></div>";
                var rowData = [
                    data.unitUPC,
                    data.unitUPCCheckDigit,
                    data.sellableUnits,
                    description+'<input type="hidden" id="hiddenAjax'+addCount+'" value="'+data.uniqueId+'"></input>',
                    data.itemCode,
                    data.approval,
                    del,
                    ''
                ];
				/*
				 *update unit total attribute after add
				 *@author khoapkl
				 */
                document.getElementById('unitTotalAttribute').innerHTML='('+data.unitTotalAttribute+')';
                for (var i = 0; i < rowData.length; i++) {
                    newCell = newRow.insertCell(i);
                    newCell.style.backgroundColor = col;
                    newCell.innerHTML = rowData[i];
                }
                var tmpTmp = "caseAjax"+addCount;
                var idI = data.uniqueId;
                var tempCount = addCount;
                var arrr = [ tempCount, "hiddenAjax" ];
                var delBut = new YAHOO.widget.Button(butId);
                YAHOO.util.Event.addListener(YAHOO.util.Dom.get(butId), "click", deleteUpc,arrr);

                document.getElementById("unitUPC").value ="";
                document.getElementById("unitUPCCheckDigit").value ="";
                document.getElementById("sellableUnits").value ="";
                var upcID=data.unitUPC;
                var upcCheckDigit = data.unitUPCCheckDigit;
                var descrip =data.description;
                var upcarr=[idI,upcID,descrip,data.unitUPCCheckDigit];
                YAHOO.util.Event.addListener(upcID, "click", interceptLink,upcarr);
                resetRemovedButtons();
                hideDeleteButton();
                calculatePctMarginAndPProfitMrt();
                //Fix 1289
                if(document.getElementById('actions3')){
                    var sel = document.getElementById('actions3');
                    var channel = sel.options[sel.selectedIndex].value;
                    if(channel != null && channel != ""){
                        //showProgress();
                        //AddCandidateTemp.setCostOwnerValuesForMRT(getDWRCallbackMethod(updateCostOwnerLocation));
                    }
                }
            }
        }

        function resetRemovedButtons(){
            var tempName = null;
            if(null!=hiddenButtonName){
                var arrr = [ hiddenButtonCount, hiddenButtonName];
                if(hiddenButtonName == "hiddenAjax") {
                    tempName = "checkAjax";
                }
                else {
                    tempName = "deleteButton";
                }
                new YAHOO.widget.Button(tempName+hiddenButtonCount);
                YAHOO.util.Event.addListener(YAHOO.util.Dom.get(tempName+hiddenButtonCount), "click", deleteUpc,arrr);
                YAHOO.util.Dom.get(tempName+hiddenButtonCount).disabled = false;
                hiddenButtonName = null;
            }
        }

        var hiddenButtonName = null;
        var hiddenButtonCount;
        function hideDeleteButton(){
            var totalCount=0;
            var singleButtonType;
            var singleButtonCount;
            var uniqueIdType;
            for (var i = 0; i <= addCount; i++) {
                if( document.getElementById("checkAjax"+i+"")){
                    singleButtonType = "checkAjax";
                    uniqueIdType ="hiddenAjax";
                    singleButtonCount = i;
                    totalCount++;
                }

            }
            for (var i = 0; i < mrtSize; i++) {
                if( document.getElementById("deleteButton"+i+"")){
                    singleButtonType = "deleteButton";
                    uniqueIdType ="hiddenNormal";
                    singleButtonCount = i;
                    totalCount++;
                }
            }
        }
        var selectedUPCRow = "";
        function deleteUpc(evt,arr){
            var rows = YAHOO.util.Dom.get("mrtTable").rows.length;
            if(rows <=2) {
                alert("MRT's MUST have more than 1 element.");
                return;
            }
            var tempName="";
            showProgress();
            var c = arr[1];
            if(c == "hiddenAjax") {
                tempName = "caseAjax";
            }
            else {
                tempName = "caseRow";
            }
            selectedUPCRow = tempName+arr[0];
            var d= arr[1]+arr[0];
            var k= document.getElementById(d).value;
            AddCandidateTemp.purgeMRT( k,getDWRCallbackMethod(PurgeValue));

        }
        function PurgeValue(data){
			/*
			 *update unit total attribute after remove
			 *@author khoapkl
			 */
            document.getElementById('unitTotalAttribute').innerHTML='('+data.unitTotalAttribute+')';
            deleteRowWithButton(selectedUPCRow);
            hideDeleteButton();
            calculatePctMarginAndPProfitMrt();
            //Fix 1289
            if(document.getElementById('actions3')){
                var sel = document.getElementById('actions3');
                var channel = sel.options[sel.selectedIndex].value;
                if(channel != null && channel != ""){
                    //showProgress();
                    //AddCandidateTemp.setCostOwnerValuesForMRT(getDWRCallbackMethod(updateCostOwnerLocation));
                }
            }

        }
        function deleteRowWithButton(rowId){
            hideProgress();
            for(var i=0;i < mrtTableBody.rows.length;i++){
                if( mrtTableBody.rows[i].id == rowId){
                    mrtTableBody.deleteRow(i);
                    colorTableRows('mrtTable');
                    break;
                }
            }
        }
        <c:url value="/protected/cps/add/prodAndUpcFromMRT?${_csrf.parameterName}=${_csrf.token}" var="prod"></c:url>
        function interceptLink(evt,upcarr){
            var t = upcarr[0];
            var c = upcarr[1];
            var d = upcarr[2];
            var e = upcarr[3];
            document.forms[0].hidUpcValue.value=c;
            document.forms[0].hidDescription.value=d;
            document.forms[0].hidUpcCheckDigit.value=e;
            document.forms[0].action = '${prod}'+'&workStatusCode='+'${addNewCandidate.productVO.workRequest.workStatusCode}';
            document.forms[0].submit();
        }

        function addEvents(){
            var uniqId;
            var cnt;
            var butn;
            var arr;
            <c:forEach items="${addNewCandidate.mrtvo.mrtVOs}" var="setMRTValue" varStatus="loop" >
            	uniqId = '<c:out value="${setMRTValue.uniqueId}"></c:out>';
         	   	cnt = ${loop.index};
           		arr = [cnt,"hiddenNormal"];
           		var delBut = new YAHOO.widget.Button("deleteButton${loop.index}",{disabled : false});
            	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteButton${loop.index}"), "click",deleteUpc,arr);
            </c:forEach>
        }

        addEvents()
        function addHyperLinkEvents(){
            var upcLinkId;
            var cnt;
            var arr;
            var descriptionId;
            var upcCheckDigit;
            <c:forEach items="${addNewCandidate.mrtvo.mrtVOs}" var="setMRTValue" varStatus="loop" >
            	upcLinkId = '<c:out value="${setMRTValue.unitUPC}"></c:out>';
            	upcCheckDigit = '<c:out value="${setMRTValue.unitUPCCheckDigit}"></c:out>';
          	  	cnt = 'caseRow${loop.index}';
          	  	descriptionId = '<c:out value="${setMRTValue.description}"></c:out>';
          	  	arr = [cnt,upcLinkId,descriptionId,upcCheckDigit];
          	  	YAHOO.util.Event.addListener(YAHOO.util.Dom.get(upcLinkId), "click", interceptLink,arr);
            </c:forEach>
            hideDeleteButton();
        }
        addHyperLinkEvents()
        YAHOO.util.Event.onDOMReady(selectChannelMRT);
        selectChannelMRT()

        function fillVendorDetailsCheck(){
            showProgress();
            var sel = document.getElementById('actions3');
            AddCandidateTemp.setVendorValuesForMRTCheck(sel.options[sel.selectedIndex].value, getDWRCallbackMethod(updateLocationCheck));
        }
        function updateLocationCheck(data){
            hideProgress();
            if(data =="Success"){
                fillMRTVendorDetails();
            }
        }
        function fillMRTVendorDetails(){
            showProgress();
            var sel = document.getElementById('actions3');
            AddCandidateTemp.setVendorValuesForMRTTemp(sel.options[sel.selectedIndex].value, getDWRCallbackMethod(updateLocation));
        }

        function updateLocation( data ){
            hideProgress();
            if(data ==null ||data ==""){
                alert("You are not Authorized to sell this Product");
            }else{
				/*if(document.getElementById('vendorLocation')){
				 dwr.util.removeAllOptions("vendorLocation");
				 dwr.util.addOptions("vendorLocation", data, "id", "name");
				 }*/
                showProgress();
                AddCandidateTemp.setCostOwnerValuesForMRT(getDWRCallbackMethod(updateCostOwnerLocation));
            }
        }
        function updateCostOwnerLocation( data ){
            hideProgress();
            //enableChannel();
            if(data ==null ||data ==""){
            }else {
                if(document.getElementById('costOwner')){
                    dwr.util.removeAllOptions("costOwner");
                    dwr.util.addOptions("costOwner", data, "id", "name");
                }
            }
        }
        function roundListCost(){
            var listCostValue = YAHOO.util.Dom.get("listCost").value;
            if(listCostValue == "" || listCostValue == null){
                return true;
            }
            listCostValue = parseFloat(listCostValue);
            if(listCostValue <= 0){
                alert('Please enter a value greater than Zero');
                YAHOO.util.Dom.get("listCost").focus();
                YAHOO.util.Dom.get("listCost").select();
                return;
            }
            else{
                var pre = listCostValue;
                if(isNaN(pre)) {
                    pre=0;
                    alert('Please enter a value for List Cost');
                    YAHOO.util.Dom.get("listCost").focus();
                    YAHOO.util.Dom.get("listCost").select();
                }
                var minus = '';
                if(pre < 0) { minus = '';}
                pre = Math.abs(pre);
                pre = parseInt((pre + .00005) * 10000);
                pre = pre / 10000;
                s = new String(pre);
                if(s.indexOf('.') < 0) { s += '.0000'; }
                if(s.indexOf('.') == (s.length - 2)) { s += '0'; }
                s = minus + s;
                document.getElementById('listCost').value = s;
            }

        }
        function check(){
            if ( document.getElementById("masterPackText").value == document.getElementById("shipPackText").value ){
                copyTextFields();
            }
            return true;
        }


        function copyTextFields(evt){
            document.getElementById("shipLength").value= document.getElementById("masterLength").value;
            document.getElementById("shipWidth").value= document.getElementById("masterWidth").value;
            document.getElementById("shipHeight").value= document.getElementById("masterHeight").value;
            document.getElementById("shipWeight").value= document.getElementById("masterWeight").value;
            calculateShipCube();
        }

        selectDefaultMRTValues()
        function selectDefaultMRTValues(){
            <c:choose>
            <c:when test="${addNewCandidate.mrtvo.caseVO.catchWeight eq true}">
            document.getElementById('catchRadio').checked = true;
            document.getElementById('variableRadio').checked = false;
            document.getElementById('noneRadio').checked = false;
            </c:when>
            <c:when test="${addNewCandidate.mrtvo.caseVO.variableWeight eq true}">
            document.getElementById('catchRadio').checked = false;
            document.getElementById('variableRadio').checked = true;
            document.getElementById('noneRadio').checked = false;
            </c:when>
            <c:otherwise>
            document.getElementById('catchRadio').checked = false;
            document.getElementById('variableRadio').checked = false;
            document.getElementById('noneRadio').checked = true;
            </c:otherwise>
            </c:choose>
            document.getElementById('caseCheckDigit').value = '${addNewCandidate.mrtvo.caseVO.mrtCaseCheckDigit}';

        }
        executeAfterBodyVisible(getVendorDefault);
        function getVendorDefault(){
            if(document.getElementById('vendorRow0')){
                document.getElementById('vendorRow0').click();
            }
        }

        <c:if test="${addNewCandidate.mrtvo.existingMRT eq true}">
        YAHOO.util.Event.removeListener("actions3", "change");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("actions3"), "change", selectChannelMRT);
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("actions3"), "change", fillVendorDetailsCheck);
        </c:if>

        <c:if test="${addNewCandidate.mrtvo.existingMRT eq false}">
        YAHOO.util.Event.removeListener("actions3", "change");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("actions3"), "change", selectChannelMRT);
        </c:if>
        <cps:renderByResourceAccess
        resourceId="196">
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
        <cps:renderByResourceAccess
                            resourceId="198">
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
        <cps:renderByResourceAccess
                            resourceId="138">
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
        <cps:renderByResourceAccess
                           resourceId="135">
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

        function validateExpected(){
            var expected = YAHOO.util.Dom.get("expectedweeklymovement").value;
            if(expected == "" || expected == null){
                return true;
            }
            if(expected.indexOf('00')==0){
                expected = expected.substring(2);
            } else if(expected.indexOf('0')==0){
                expected = expected.substring(1);
            }
            expected = parseInt(expected);
            if(expected <= 0){
                alert('Please enter a value greater than Zero');
                YAHOO.util.Dom.get("expectedweeklymovement").focus();
                YAHOO.util.Dom.get("expectedweeklymovement").select();
            }
        }
        function autotab(original,caseCheckDigit){
            if(original.value.length == original.getAttribute("maxlength")){
                document.getElementById('caseCheckDigit').focus();
            }
        }
        function verifyCheckDigitForCaseUPC(){
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
                    }else{
                        showProgress();
                        AddCandidateTemp.isExistingUPC(caseTextValue, getDWRCallbackMethod(caseUPCExists, data));
                    }
                }));
            }
            else if(caseTextValue != null && caseTextValue != "" && (caseCheckValue == null || caseCheckValue == "") ){
                alert('Please enter the Check Digit');
            }
        }

        function caseUPCExists(data){
            hideProgress();
            if(data != null && data != ""){
                alert(data);
                document.getElementById('caseCheckDigit').value = '';
                document.getElementById('caseUpcText').focus();
                document.getElementById('caseUpcText').select();
            }
        }

        function setFocusToCheckDigit(){
            document.getElementById('caseCheckDigit').focus();
        }

        YAHOO.util.Event.onDOMReady(function(){
            YAHOO.util.Dom.get("hts").value = padHts(YAHOO.util.Dom.get("hts").value);
            YAHOO.util.Dom.get("hts2").value = padHts(YAHOO.util.Dom.get("hts2").value);
            YAHOO.util.Dom.get("hts3").value = padHts(YAHOO.util.Dom.get("hts3").value);
        });
	</script>
</form:form>