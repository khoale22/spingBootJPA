<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<%@ page import="java.util.*" %>
<%@page import="com.heb.jaf.security.UserInfo"%>

<c:url value="${request.getContextPath()}/yui/datatable/assets/skins/sam/datatable.css" var="styleURL" />
<link type="text/css" rel="stylesheet"
href="${styleURL}">
<c:url value="${request.getContextPath()}/yui/container/assets/skins/sam/container.css" var="styleURL" />
<link rel="stylesheet" type="text/css"
href="${styleURL}" />
<c:url value="${request.getContextPath()}/yui/button/assets/skins/sam/button.css" var="styleURL" />
<link rel="stylesheet" type="text/css" href="${styleURL}" />
<c:url value="${request.getContextPath()}/yui/element/element-beta-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/datasource/datasource-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/json/json-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/connection/connection-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/get/get-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/datatable/datatable-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/event/event-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/container/container-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/animation/animation-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/yahoo-dom-event/yahoo-dom-event.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/dragdrop/dragdrop-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/animation/animation-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/carousel/carousel-beta-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/hebAssets/moduleIncludes/sellingRestriction.js" var="sellingResUrl" />
<script src="${sellingResUrl}"></script>

<script type="text/javascript">
	YAHOO.namespace('HEB.candidate.otherInfo');
	var initValue =0;
</script>

<style>
	.pg-normal {
		color: #336699;
		font-weight: normal;
		text-decoration: none;
		cursor: pointer;
	}
	.pg-selected {
		color: #a3c2c2;
		font-weight: bold;
		text-decoration: underline;
		/*       cursor: pointer; */
	}
	/* Skin default elements */
	.singlePanel_c.yui-panel-container.shadow .underlay {
		left: 1px;
		right: -1px;
		top: 1px;
		bottom: -1px;
		position: absolute;
		background-color: #000;
		opacity: 0.12;
		filter: alpha(opacity =           12);
	}

	/* Apply the border to the right side */
	.singlePanel.yui-panel {
		border: none;
		overflow: visible;
		background: transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat
		top right;
	}

	/* Style the close icon */
	.singlePanel.yui-panel .hd .closeMe {
		position: absolute;
		top: 5px;
		right: 8px;
		height: 21px;
		width: 21px;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
	}

	/* Style the header with its associated corners */
	.singlePanel.yui-panel .hd {
		padding: 0;
		border: none;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-hd.gif) repeat-x;
		color: #FFF;
		height: 30px;
		margin-left: 0px;
		margin-right: 0px;
		text-align: left;
		vertical-align: middle;
		overflow: visible;
	}

	/* Style the body with the left border */
	.singlePanel.yui-panel .bd {
		overflow: hidden;
		padding: 10px;
		border: none;
		background: #FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y;
		margin: 0 4px 0 0;
	}

	/* Style the footer with the bottom corner images */
	.singlePanel.yui-panel .ft {
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
		font-size: 11px;
		height: 26px;
		padding: 0px 10px;
		border: none
	}

	/* Skin custom elements */
	.singlePanel.yui-panel .hd span {
		line-height: 30px;
		vertical-align: middle;
		font-weight: bold;
		margin-left: 12px;
	}

	.singlePanel.yui-panel .hd .tl {
		width: 8px;
		height: 29px;
		top: 1px;
		left: 0px;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
		position: absolute;
	}

	.singlePanel.yui-panel .hd .tr {
		width: 8px;
		height: 29px;
		top: 1px;
		right: 0;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat;
		position: absolute;
	}

	.singlePanel.yui-panel .ft span {
		line-height: 22px;
		vertical-align: middle;
	}

	.singlePanel.yui-panel .ft .bl {
		width: 8px;
		height: 26px;
		bottom: 0;
		left: 0;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
		position: absolute;
	}

	.singlePanel.yui-panel .ft .br {
		width: 8px;
		height: 26px;
		bottom: 0;
		right: 0;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
		position: absolute;
	}

	.yui-skin-sam .yui-dt td.align-center {
		text-align: center;
	}

	.yui-skin-sam .yui-dt th {
		text-align: center;
		font-weight: bold;
		color: #00000;
		font-family: Arial, Helvetica, sans-serif;
		font-size: 12px;
	}
	.yui-skin-sam-tax-category .yui-dt-scrollable .yui-dt-bd {
		overflow: auto;
	}
	.yui-skin-sam-tax-category .yui-dt-scrollable table {
		width:370px;
	}

	#tblSellingRestriction .yui-dt-empty{
		display: none;
	}

	.cps-style{
		width: 100%;
		margin-right: 35px;
		float: right;
	}

	.yui-dt-col-rating{
		width: 130px;
	}
	.yui-dt-col-rateType{
		width: 180px;
	}
	.yui-dt-col-age{
		width: 80px;
	}
	.yui-dt-col-salesTime{
		width: 85px;
	}

	#taxCategoryPop_c.yui-panel-container.shadow .underlay {
		pointer-events: none;
	}

	/* .yui-skin-sam-tax-category .yui-dt table { */
		/* 	width:330px; */
		/* } */
		#tblTaxCategory .yui-dt-empty {
			display: none;
		}
		.yui-dt-col-productId .yui-dt-liner {
			width:50px;
			overflow: hidden;
		}
		.yui-dt-col-size .yui-dt-liner {
			width:42px;
			overflow: hidden;
		}
		.yui-dt-col-productDes .yui-dt-liner {
			width:215px;
			overflow: hidden;
		}

		.float-left{
			float: left;

		}
		.float-right{
			float: right;
			margin-right: 35px;
			width: 45%;
		}
		.yui-skin-sam .yui-dt TABLE{
			border: none;
		}
		.yui-skin-sam .yui-dt th{
			font-weight: normal;
		}
		.width-fixed{
			width: 20px;
		}
		.width-fixed1{
			width: 80px;
		}
		.addRow{
			float: right;
			margin-right: 35px;
			margin-top: 30px;
			margin-bottom: 30px;
		}
		
		.textFieldLarge{
			width : 220px;
			font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 11px;	
			}
		</style>

<%
	String renderView = "";
	org.springframework.security.core.Authentication auth = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication(); 
	UserInfo hebUserDetails = (UserInfo)auth.getPrincipal();
	Map<Integer, String> m = hebUserDetails.getResourceMap();
	if(m != null){
		String acs = m.get(277);	// set role for Selling Restriction area
		if(acs != null){
			if("ED".equals(acs)){
				renderView = "E";
			}
			else if("V".equals(acs)){
				renderView = "V";
			} else {
			    renderView = "N";
			}
		}
		else{
			renderView = "N";
		}
	}
	else{
		renderView = "N";
	}
	pageContext.setAttribute("renderView", renderView);
%>

<a id="sec4tion"></a>
<fieldset style="width: 95%;">
	<legend class="legendFont">Point of Sale </legend>
	<c:choose>
		<c:when test="${addNewCandidate.userRole eq 'UVEND'}">
			<c:set value="visibility: hidden;  position: relative; min-width: 0;padding: 10px 5px 5px 5px; width: 550px"
			var="styleStrSellingRes"></c:set>
		</c:when>
		<c:when test="${addNewCandidate.userRole eq 'RVEND'}">
			<c:set value="visibility: hidden;  position: relative; min-width: 0;padding: 10px 5px 5px 5px; width: 550px"
			var="styleStrSellingRes"></c:set>
		</c:when>
		<c:otherwise>
			<c:set value="visibility: visible;  position: relative; min-width: 0;padding: 10px 5px 5px 5px; width: 550px"
				var="styleStrSellingRes"></c:set>
		</c:otherwise>
	</c:choose>

	<c:url var="iconPopup" value="${request.getContextPath()}/hebAssets/images/icons/iconPopup.png"/>
	<c:url var="iconSearch" value="${request.getContextPath()}/hebAssets/images/icons/IMG_searchIcon.gif"/>
	<c:url var="iconDelete" value="${request.getContextPath()}/hebAssets/images/delete.png"/>
	<c:url var="iconQuestion" value="${request.getContextPath()}/hebAssets/images/buttons/iconQuestion.png"/>
	<c:url var="iconRedStar" value="${request.getContextPath()}/hebAssets/images/red_star.png"/>
	<c:url var="iconAdd" value="${request.getContextPath()}/hebAssets/images/add.png"/>
	<div style="width: 100%;">
		<table width="100%" cellspacing="3" border="0" style="float: left; ">
			<tr>
				<td align=right width="13%">
					<label class="labelFont helpable" for=selectedChannel id="FamCode1Label">Family Code 1</label>
				</td>
				<td align=left width="15%">&nbsp;&nbsp;
					<cps:renderByResourceAccess resourceId="45">
						<jsp:attribute name="EDIT">
							<form:input cssClass="textFieldMedium mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
										style="dataType: numeric;" path="productVO.pointOfSaleVO.familyCode1"
										maxlength="3" size="4" tabindex="50" id="familyCode1"
										onblur="validateFamily();" />
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:input path="productVO.pointOfSaleVO.familyCode1" disabled="true"
										cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" />
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
				<td align=right width="13%">
					<label class="labelFont helpable" for=selectedChannel id="DrugFactPanelLabel">
						Drug Fact Panel&nbsp;
					</label>
				</td>
				<td align=left width="15%">&nbsp;
					<cps:renderByResourceAccess resourceId="49">
						<jsp:attribute name="EDIT">
							<form:checkbox path="productVO.pointOfSaleVO.drugFactPanel"
										   onclick="checkDrug();" id="drugFactPanel" tabindex="55"
										   cssClass="mtGroup mtGroup1 mtGroup4" value="true" />
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:checkbox path="productVO.pointOfSaleVO.drugFactPanel"
										   id="drugFactPanel" tabindex="55" disabled="true"
										   cssClass="mtGroup mtGroup1 mtGroup4" value="true" />
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
				<td align="right" width="13%">
					<label for="selectedChannel" class="labelFont helpable" id="TaxableLabel">Taxable&nbsp;</label>
				</td>
				<td align="left" width="19%">
					<table width="100%">
						<tr>
							<td width="10%">
								<cps:renderByResourceAccess resourceId="52">
									<jsp:attribute name="EDIT">
										<form:checkbox path="productVO.pointOfSaleVO.taxable" tabindex="59"
													   styleId="taxabilityFlag" id = "taxabilityFlag"
													   cssClass="mtGroup mtGroup1 mtGroup4" value="true"
													   onclick="displayTaxFlagWarning();" />
										<form:hidden path="productVO.pointOfSaleVO.taxableDefault"
													 styleId="taxabilityDefaultFlag" id="taxabilityDefaultFlag"/>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<form:checkbox path="productVO.pointOfSaleVO.taxable"
													   id="taxabilityFlag" tabindex="59" disabled="true"
													   cssClass="mtGroup mtGroup1 mtGroup4" value="true" />
										<form:hidden path="productVO.pointOfSaleVO.taxableDefault"
													 styleId="taxabilityDefaultFlag" id="taxabilityDefaultFlag"/>
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</td>
							<td width="90%">
								<img styleId="taxableImageId" id="taxableImageId" src="${iconRedStar}"
									 onclick="warningTaxFlag();" style="display: none;" width="10" height="10" />
							</td>
						</tr>
					</table>
				</td>
				<td align="right" width="13%">
					<label for="selectedChannel" class="labelFont helpable" id="FoodStampLabel">
						Food Stampable
					</label>
				</td>
				<td align="left" width="19%">
					<table width="100%">
						<tr>
							<td width="10%">&nbsp;
								<cps:renderByResourceAccess resourceId="53">
									<jsp:attribute name="EDIT">
										<form:checkbox path="productVO.pointOfSaleVO.foodStamp"
													   styleId="foodStamp" id="foodStamp" tabindex="60"
													   cssClass="mtGroup mtGroup1 mtGroup4" value="true"
													   onclick="displayFoodStampWarning();" />
										<form:hidden path="productVO.pointOfSaleVO.foodStampDefault"
													 styleId="foodStampDefault" id="foodStampDefault"/>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<form:checkbox path="productVO.pointOfSaleVO.foodStamp"
													   styleId="foodStamp" id="foodStamp" tabindex="60" disabled="true"
													   cssClass="mtGroup mtGroup1 mtGroup4" value="true" />
										<form:hidden path="productVO.pointOfSaleVO.foodStampDefault" id="foodStampDefault"
													 styleId="foodStampDefault" />
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</td>
							<td width="90%">
								<img styleId="foodStampImageId" id="foodStampImageId" src="${iconRedStar}"
									 onclick="warningFoodStamp();" style="display: none;" width="10" height="10" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align=right width="13%">
					<label class="labelFont helpable" for=selectedChannel id="FamCode2Label">Family Code 2&nbsp;</label>
				</td>
				<td align=left width="15%">&nbsp;&nbsp;
					<cps:renderByResourceAccess resourceId="46">
						<jsp:attribute name="EDIT">
							<form:input cssClass="textFieldMedium mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
										style="dataType: numeric;" path="productVO.pointOfSaleVO.familyCode2"
										maxlength="3" size="4" tabindex="51" id="familyCode2"
										onblur="validateFamily();" />
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:input path="productVO.pointOfSaleVO.familyCode2" disabled="true"
										cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" />
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
				<c:choose>
					<c:when test="${addNewCandidate.userRole eq 'UVEND'}">
						<c:set value="true" var="forVendorLogin"></c:set>
					</c:when>
					<c:when test="${addNewCandidate.userRole eq 'RVEND'}">
						<c:set value="true" var="forVendorLogin"></c:set>
					</c:when>
					<c:otherwise>
						<c:set value="false" var="forVendorLogin"></c:set>
					</c:otherwise>
				</c:choose>
				<cps:renderByResourceAccess resourceId="47"	honorViewMode="${addNewCandidate.retailViewOverRide}">
					<jsp:attribute name="EDIT">
						<td align=right width="13%">
							<label class="labelFont helpable" for=selectedChannel id="PSSDeptLabel">
								PSS Dept  <em><font	color="red"><b>*</b></font></em>
							</label>
						</td>
						<td align=left width="15%">&nbsp;&nbsp;
							<form:select path="productVO.pointOfSaleVO.pssDept" tabindex="54" styleId="pssdepts"
										 id="pssdepts" cssClass="selectBoxStyle2" disabled="${forVendorLogin}">
								<form:options items="${addNewCandidate.pssList}" itemLabel="name"	itemValue="id" />
							</form:select>
						</td>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<td align=right width="13%">
							<label class="labelFont helpable" for=selectedChannel id="PSSDeptLabel">
								PSS Dept  <em><font color="red"><b>*</b></font></em>
							</label>
						</td>
						<td align=left width="19%">&nbsp;&nbsp;
							<form:select path="productVO.pointOfSaleVO.pssDept" tabindex="54" id="pssdepts"
										 cssClass="selectBoxStyle2" disabled="true">
								<form:options items="${addNewCandidate.pssList}" itemLabel="name"	itemValue="id" />
							</form:select>
						</td>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<td align=right width="13%"/>
						<td align=left width="19%">
							<form:select path="productVO.pointOfSaleVO.pssDept" tabindex="54" styleId="pssdepts"
										 id="pssdepts" style="visibility:hidden;">
								<form:options items="${addNewCandidate.pssList}" itemLabel="name" itemValue="id"/>
							</form:select>
						</td>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<td width="13%">
					<table width="100%">
						<cps:renderByResourceAccess resourceId="272">
							<jsp:attribute name="EDIT">
								<tr style="display: block; height: 25px;">
									<td align="right" width="13%">
										<label class="labelFont helpable" id="taxCategoryLabel">
											Tax Category <em><font color="red"><b>*</b></font></em>
										</label>
									</td>
								</tr>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<tr style="display: block; height: 25px;">
									<td align="right" width="13%">
										<label class="labelFont helpable" id="taxCategoryLabel">
											Tax	Category <em><font color="red"><b>*</b></font></em>
										</label>
									</td>
								</tr>
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</table>
				</td>
				<td>
					<cps:renderByResourceAccess resourceId="272">
						<jsp:attribute name="EDIT">
							<table>
								<tr style="display: block; height: 25px;">
									<td align="left" width="19%" id="taxCategoryWrapId" >
										<div style="float: left; margin-top: 5px;margin-left: 3px" id="taxCategoryWrap">
											<c:if test="${addNewCandidate.productVO.pointOfSaleVO.taxCateCode ne null && addNewCandidate.productVO.pointOfSaleVO.taxCateCode ne ''}">
												<c:out value="${addNewCandidate.productVO.pointOfSaleVO.taxCateCode}"/>-<c:out value="${addNewCandidate.productVO.pointOfSaleVO.taxCateName}"/>
											</c:if>
											<c:if test="${addNewCandidate.productVO.pointOfSaleVO.taxCateCode eq null || addNewCandidate.productVO.pointOfSaleVO.taxCateCode eq ''}">
												-Select-
											</c:if>
										</div>
										<div style="float: left;">
											<img id="taxCatePop" src="${iconPopup}" style="cursor: pointer; margin-top: 3px"
												 onclick="showTaxCatePop()">
										</div>
										<div style="float: left;">
											<img styleId="taxCateImageId" id="taxCateImageId" src="${iconRedStar}"
												 onclick="warningTaxCategory();" style="display: none;" width="10"
												 height="10" />
										</div>
										<form:hidden path="productVO.pointOfSaleVO.taxCateCode"
												  styleId="taxCateCodeHidden" id="taxCateCodeHidden"/>
										<form:hidden path="productVO.pointOfSaleVO.taxCateName"
													 styleId="taxCateNameHidden" id="taxCateNameHidden"/>
									</td>
								</tr>
							</table>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<table>
								<tr style="display: block; height: 25px;">
									<td align="left" width="19%" id="taxCategoryWrapId" >
										<div style="float: left; margin-top: 5px;margin-left: 3px" id="taxCategoryWrap">
											<c:if test="${addNewCandidate.productVO.pointOfSaleVO.taxCateCode ne null && addNewCandidate.productVO.pointOfSaleVO.taxCateCode ne ''}">
												<c:out value="${addNewCandidate.productVO.pointOfSaleVO.taxCateCode}"/>-<c:out value="${addNewCandidate.productVO.pointOfSaleVO.taxCateName}"/>
											</c:if>
											<c:if test="${addNewCandidate.productVO.pointOfSaleVO.taxCateCode eq null || addNewCandidate.productVO.pointOfSaleVO.taxCateCode eq ''}">
												-Select-
											</c:if>
										</div>
										<div style="float: left;">
											<img id="taxCatePop" src="${iconPopup}" style="cursor: pointer; margin-top: 3px"; disabled="true">
										</div>
										<div style="float: left;">
											<img styleId="taxCateImageId" id="taxCateImageId" src="${iconRedStar}"
												 onclick="warningTaxCategory();" style="display: none;" width="10"
												 height="10" />
										</div>
										<form:hidden path="productVO.pointOfSaleVO.taxCateCode" id="taxCateCodeHidden"
													 styleId="taxCateCodeHidden"/>
										<form:hidden path="productVO.pointOfSaleVO.taxCateName"	id="taxCateNameHidden"
													 styleId="taxCateNameHidden"/>
									</td>
								</tr>
							</table>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
				<td align="right" width="13%">
					<label for="selectedChannel" class="labelFont helpable" id="DepositUPCLabel">Deposit UPC</label>
				</td>
				<td align="left" width="19%">&nbsp;&nbsp;
					<cps:renderByResourceAccess	resourceId="54">
						<jsp:attribute name="EDIT">
							<form:input cssClass="textFieldMedium" style="dataType: numeric;" maxlength="13" size="20"
									   path="productVO.pointOfSaleVO.depositUPC" tabindex="61"
										id="depositUPC" onchange="checkActiveUPC();"/>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:input cssClass="textFieldMedium" style="dataType: numeric;"	size="20" tabindex="61"
										path="productVO.pointOfSaleVO.depositUPC" maxlength="13"
										id="depositUPC" disabled="true" />
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
			</tr>
			<tr>
				<td align="right" width="13%">
					<cps:renderByResourceAccess resourceId="69">
						<jsp:attribute name="EDIT">
							<label for="selectedChannel" class="labelFont helpable"	id="fsaLabel">FSA </label>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<label for="selectedChannel" class="labelFont helpable" id="fsaLabel">FSA </label>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
				<td align="left" width="15%">&nbsp;
					<cps:renderByResourceAccess resourceId="69">
						<jsp:attribute name="EDIT">
							<form:checkbox path="productVO.pointOfSaleVO.fsa" styleId="fsa" id="fsa" tabindex="58"
										   cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" value="true"/>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:checkbox path="productVO.pointOfSaleVO.fsa" styleId="fsa" id="fsa"
										   tabindex="58" disabled="true"
										   cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" value="true" />
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
				<td align="right" width="13%">
					<cps:renderByResourceAccess resourceId="70">
						<jsp:attribute name="EDIT">
							<label class="labelFont helpable" for=selectedChannel id="PseLabel">PSE</label>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<label class="labelFont helpable" for=selectedChannel id="PseLabel">PSE</label>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
				<cps:renderByResourceAccess resourceId="70">
					<jsp:attribute name="EDIT">
						<td align="left" width="15%">&nbsp;&nbsp;
							<form:select path="productVO.pointOfSaleVO.pse" tabindex="" styleId="pse" id="pse"
										 onblur="resetPSE();" onfocus="changeStatus();"  style="dataType : alpha"
										 onchange="changePSE();" >
								<form:options items="${addNewCandidate.pseLst}" itemLabel="name" itemValue="id" />
							</form:select>
						</td>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<td align="left" width="15%">&nbsp;&nbsp;
							<form:select path="productVO.pointOfSaleVO.pse" tabindex="" style="dataType : alpha"
										 styleId="pse" id="pse" disabled="true">
								<form:options items="${addNewCandidate.pseLst}" itemLabel="name" itemValue="id" />
							</form:select>
						</td>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<form:hidden path="productVO.pointOfSaleVO.pse" styleId="pseHidden" id="pseHidden"/>
				<cps:renderByResourceAccess resourceId="273">
					<jsp:attribute name="EDIT">
						<td align="right" width="13%" style="display: block; height: 25px;">
							<label class="labelFont helpable" id="qualifyConditionLabel">
								Qualifying Condition
							</label>
						</td>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<td align="right" width="13%" style="display: block; height: 25px;">
							<label class="labelFont helpable" id="qualifyConditionLabel">
								Qualifying Condition
							</label>
						</td>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<cps:renderByResourceAccess resourceId="273">
					<jsp:attribute name="EDIT">
						<td align="left" width="19%" style="display: block; height: 25px;">&nbsp;
							<form:select path="productVO.pointOfSaleVO.qualifyConditionCode">
								<form:option value="">--Select--</form:option>
								<form:options items="${addNewCandidate.listQualifyCondition}" itemLabel="txBltyDvrName" itemValue="txBltyDvrCode"/>
							</form:select>
						</td>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<td align="left" width="19%" style="display: block; height: 25px;">&nbsp;
							<form:select path="productVO.pointOfSaleVO.qualifyConditionCode" disabled ="true">
								<form:option value="">--Select--</form:option>
								<form:options items="${addNewCandidate.listQualifyCondition}" itemLabel="txBltyDvrName" itemValue="txBltyDvrCode"/>
							</form:select>
						</td>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<td align="right" width="13%">
					<label for="selectedChannel" class="labelFont helpable" id="QtyRestLabel">
						Quantity Restricted
					</label>
				</td>
				<td align="left" width="19%">&nbsp;
					<cps:renderByResourceAccess	resourceId="51">
						<jsp:attribute name="EDIT">
							<form:checkbox path="productVO.pointOfSaleVO.qntityRestricted" id="qntityRestricted"
										   styleId="qntityRestricted" tabindex="58"
										   cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" value="true"/>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:checkbox path="productVO.pointOfSaleVO.qntityRestricted" id="qntityRestricted"
										   styleId="qntityRestricted" tabindex="58" disabled="true"
										   cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" value="true"/>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
			</tr>
			<tr>
				<cps:renderByResourceAccess resourceId="274">
					<jsp:attribute name="EDIT">
						<td width="13%"  align="right">
							<label for="selectedChannel" class="labelFont" id="FdaMenuLabellingLabel">
								Show Calories
							</label>
						</td>
						<td width="15%"   align="left">&nbsp;&nbsp;
							<form:checkbox path="productVO.pointOfSaleVO.showClrsSw" styleId="showClrsSw" id="showClrsSw"
										   tabindex="68" value="true" cssClass="mtGroup mtGroup1 mtGroup4" onclick="showClrsSwHandle();"/>
						</td>
						<td width="13%"  align="right" style="font-size:12px;font-family:Verdana">
							Show Calories Status
						</td>
						<td  width="15%" colspan="5">
							<label for="selectedChannel" class="labelFont" id="fdaMenuLabelingStatus"
								   style="font-weight:bold;padding-left:10px;display:${addNewCandidate.productVO.pointOfSaleVO.showClrsSw ? 'block' : 'none'}">
									${addNewCandidate.productVO.pointOfSaleVO.fdaMenuLabelingStatus}
							</label>
						</td>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<td width="13%" align="right">
							<label for="selectedChannel" class="labelFont" id="FdaMenuLabellingLabel">
								Show Calories
							</label>
						</td>
						<td width="15%" align="left">&nbsp;&nbsp;
							<form:checkbox path="productVO.pointOfSaleVO.showClrsSw" styleId="showClrsSw" id="showClrsSw"
										   tabindex="68" value="true" disabled ="true" cssClass="mtGroup mtGroup1 mtGroup4" />
						</td>
						<td width="13%"  align="right" style="font-size:12px;font-family:Verdana">
							Show Calories Status
						</td>
						<td  width="15%" colspan="5">
							<label for="selectedChannel" class="labelFont" id="fdaMenuLabelingStatus"
								   style="font-weight:bold;padding-left:10px;display:${addNewCandidate.productVO.pointOfSaleVO.showClrsSw ? 'block' : 'none'}">
									${addNewCandidate.productVO.pointOfSaleVO.fdaMenuLabelingStatus}
							</label>
						</td>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</tr>
			<cps:renderByResourceAccess	resourceId="277">
				<jsp:attribute name="EDIT">
					<tr>
						<td colspan="8">
							<fieldset style="width: 98.5%;" style="${styleStrSellingRes}">
								<legend class="legendFont">Selling Restrictions </legend>
								<table width="100%">
									<tr>
										<td width="88%">
											<div style="padding: 20px 0px 0px 0px; width: 100%;float:left;display:block" id="tableSellingId"></div>
										</td>
										<td style="vertical-align: bottom;">
											<div style="padding-left: 5px;float:right">
												<div style="padding-right:5px;float:right">
													Add New Row&nbsp;&nbsp
													<img src="${iconAdd}" alt="" onclick="showSellingRestriction(true)"	id="btnNewSelling" style="cursor: pointer;" />
												</div>
												<div style="padding-right: 5px;float:right">
													<select id="sellingRestrictionOption" style="width: 120px; display:none" onchange="addRowSelling(false, this)">
														<option value="-1" disabled>  </option>
													</select>
												</div>
											</div>
										</td>
									</tr>
								</table>
								<form:hidden path="productVO.jsonSellingRestriction" id="jsonSellingRestrictionHidden"
										  styleId="jsonSellingRestrictionHidden"/>
								<form:hidden path="productVO.originSellingRestriction" id="originSellingRestriction"
											 styleId="originSellingRestriction"/>
								<form:hidden path="productVO.flagModify" id="sellingModify" styleId="sellingModify"/>
							</fieldset>
						</td>
					</tr>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<tr>
						<td colspan="8">
							<fieldset style="width: 98.5%;" style="${styleStrSellingRes}">
								<legend class="legendFont">Selling Restrictions </legend>
								<table width="100%">
									<tr>
										<td width="88%">
											<div style="padding: 20px 0px 0px 0px; width: 100%;float:left;display:block" id="tableSellingId"></div>
										</td>
										<td style="vertical-align: bottom;">
											<div style="padding-left: 5px;float:right">
												<div style="padding-right:5px;float:right">
													Add New Row&nbsp;&nbsp
													<img src="${iconAdd}" alt="" disabled id="btnNewSelling" style="cursor: pointer;" />
												</div>
												<div style="padding-right: 5px;float:right">
													<select id="sellingRestrictionOption" style="width: 120px; display:none" onchange="addRowSelling(false, this)">
														<option value="-1" disabled>  </option>
													</select>
												</div>
											</div>
										</td>
									</tr>
								</table>
								<form:hidden path="productVO.jsonSellingRestriction" id="jsonSellingRestrictionHidden"
										  styleId="jsonSellingRestrictionHidden" />
								<form:hidden path="productVO.originSellingRestriction" id="originSellingRestriction"
											 styleId="originSellingRestriction" />
								<form:hidden path="productVO.flagModify" id="sellingModify" styleId="sellingModify"/>
							</fieldset>
						</td>
					</tr>
				</jsp:attribute>
			</cps:renderByResourceAccess>
		</table>
	</div>
</fieldset>
<div id="taxCategoryPop" style="display: none;" class="singlePanel">
	<div class="hd">
		<div class="tl"></div>
		<span id="popupHeaderSEP"><font size="2" color="white" style="font-weight: bold;">Tax Category</font></span>
		<div class="closeMe" onclick="closeSingleEtPanel();"></div>
		<div class="tr"></div>
	</div>
	<div class="bd">
		<div>
			<div style="width: 100%; padding-left: 10px;"><label style="color: red;" id="errorMess"></label></div>
			<div style="padding-top: 3px; vertical-align: middle; float: left;" align="right">
				<label style="font-weight: bold; font-size: 13px; vertical-align: middle;">Tax Category </label>
			</div>
			<div style="width: 3%; vertical-align: middle; float: left;"></div>
			<div style="vertical-align: middle; float: left;">
				<input id="filterTxtTaxCategory" type="text" name="attrName" value="" style="width: 240px">
			</div>
			<div style="width: 10%;padding-top:1px; float: left;">
				<img src="${iconSearch}" alt="" onclick="searchTaxCategory()" width="22" id="imageSrch" height="22" style="cursor: pointer;" />
				<img src="${iconDelete}" alt="" width="22" onclick="clearFilter()" id="clearImage" height="22" style="cursor: pointer;" />
			</div>
			<div style="width: 12%; vertical-align: middle; float: left;">
				<input type="radio" id= "showAllId" name="showAllorDis" value="showall" onclick="changeRadio(this)">Show all
			</div>
			<div style="width: 15%; vertical-align: middle; float: left;">
				<input type="radio" id= "distinctId" name="showAllorDis" value="distinct" onclick="changeRadio(this)">Suggested
			</div>
			<br />
			<div style="width: 100%">
				<label style="font-style: italic; font-size: 11px;"> Click a value to select </label>
			</div>
			<br />
			<div style="width: 100%;" class="yui-skin-sam-tax-category">
				<div id="tblTaxCategory" style="float: left"></div>
				<div id="tblProduct" style="float: left"></div>
				<div style="clear: both;"></div>
				<div style="float: right;" id="pageNavPosition"></div>
			</div>
		</div>
		<div style="width: 100%; vertical-align: middle; float: left;padding-top: 12px" align="right">
			<input type="button" id="btnClose" value="Close" onclick="closeSingleEtPanel();" style="cursor: pointer;"></input>
		</div>
	</div>
	<div class="ft">
		<div class="bl"></div>
		<div class="br"></div>
	</div>
</div>

<script type="text/javascript">
	<c:if test= "${addNewCandidate.search}" >
		document.getElementById('familyCode1').disabled = true;
		document.getElementById('pssDept').disabled = true;
		document.getElementById('restrictedSalesAgeLimit').disabled = true;
		document.getElementById('purchaseTime').disabled = true;
		document.getElementById('familyCode2').disabled = true;
		document.getElementById('drugFactPanel').disabled = true;
		document.getElementById('foodStamp').disabled = true;
		document.getElementById('qntityRestricted').disabled = true;
		document.getElementById('taxabilityFlag').disabled = true;
	</c:if>

	function reloadposAcc(){
	    //I can't find these implemented anywhere
		YAHOO.HEB.candidate.otherInfo.drugFactPanelreload();
		YAHOO.HEB.candidate.otherInfo.qntityRestrictedreload();
		YAHOO.HEB.candidate.otherInfo.foodStampreload();
		YAHOO.HEB.candidate.otherInfo.taxabilityFlagreload();
	}

	function getPosAcctLists(){
		displaySignDefault();
		AddCandidateTemp.getPOSAcctLists(getDWRCallbackMethod(populatePosAcctLists));
	}

	function displayTaxCateFlag(){
		var taxCateWrap = YAHOO.util.Dom.get("taxCategoryWrap");
		if(null != taxCateWrap && taxCateWrap != undefined && !isWorkingKitComponents()){
			if(taxCateWrap.innerHTML.indexOf("-Select-") != -1){
				document.getElementById('taxCateImageId').style.display  ='block';
			}else{
				document.getElementById('taxCateImageId').style.display  ='none';
			}
		}
	}

	function displaySignDefault(){
		//<c:url var="img" value="/hebAssets/images/red_star.png"></c:url>
		var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
		var foodStamp = YAHOO.util.Dom.get("foodStamp");
		var taxFlagDefault = YAHOO.util.Dom.get("taxabilityDefaultFlag");
		var foodStampDefault = YAHOO.util.Dom.get("foodStampDefault");

		if (!isWorkingKitComponents()) {
			if((taxFlag.checked && taxFlagDefault.value == 'false') || (!taxFlag.checked && taxFlagDefault.value == 'true')){
				document.getElementById('taxableImageId').style.display  ='block' ;
			}
		}
		if((foodStamp.checked && foodStampDefault.value == 'false') || (!foodStamp.checked && foodStampDefault.value == 'true')){
			document.getElementById('foodStampImageId').style.display  ='block' ;
		}
		displayTaxCateFlag();
	}

	function getTaxCategoryBasedOnTaxFlag(taxFlag, subCommodity){
		var taxAble = taxFlag.checked;
		var object = null;
		showProgress();
		var callbacks = {
			success : function(o) {
				try {
					if (o != null && myTrim(o.responseText) != "") {
						object = YAHOO.lang.JSON.parse(o.responseText);
						fillDataIntoTaxWrap(object);
					}else{
						fillDataIntoTaxWrap(null);
					}
						hideTheProgress();
				} catch (e) {
						hideTheProgress();
						return;
					}
				},
			failure : function() {
					hideTheProgress();
				},
						timeout : 50000
		};
		YAHOO.util.Connect.asyncRequest('GET',
			"getTaxCategoryBasedOnTaxFlag?taxFlag="+taxAble+"&subCommodity="+subCommodity, callbacks);
	}

	function displayTaxFlagWarning1(){
		var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
		var taxFlagDefault = YAHOO.util.Dom.get("taxabilityDefaultFlag");
		var taxvalue = 'N=No';
		var taxFlagDefaultValue = 'N=No';
		if(((taxFlag.checked && taxFlagDefault.value == 'false') || (!taxFlag.checked && taxFlagDefault.value == 'true'))
				&& !isWorkingKitComponents()){
			if(taxFlag.checked){
				taxvalue = 'Y=Yes';
			}
			if(taxFlagDefault.value == 'true')
				taxFlagDefaultValue = 'Y=Yes';
			alert('Tax Flag (selected as '+taxvalue+') is different than the default for the sub-commodity (set at '+taxFlagDefaultValue+')');
			document.getElementById('taxableImageId').style.display  ='block' ;
		} else {
			document.getElementById('taxableImageId').style.display  ='none' ;
		}
	}

	function displayTaxFlagWarning(){
		var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
		var taxFlagDefault = YAHOO.util.Dom.get("taxabilityDefaultFlag");

		var taxvalue = 'N=No';
		var taxFlagDefaultValue = 'N=No';
		if(((taxFlag.checked && taxFlagDefault.value == 'false') || (!taxFlag.checked && taxFlagDefault.value == 'true'))
				&& !isWorkingKitComponents()){
			if(taxFlag.checked){
				taxvalue = 'Y=Yes';
			}
			if(taxFlagDefault.value == 'true')
				taxFlagDefaultValue = 'Y=Yes';
			alert('Tax Flag (selected as '+taxvalue+') is different than the default for the sub-commodity (set at '+taxFlagDefaultValue+')');
			document.getElementById('taxableImageId').style.display  ='block' ;
		} else {
			document.getElementById('taxableImageId').style.display  ='none' ;
		}
		var subComm = YAHOO.util.Dom.get("subCommodityStrutsHiddenElm");
		if(null != subComm && subComm != undefined){
			getTaxCategoryBasedOnTaxFlag(taxFlag,subComm.value);
		}
	}

	function displayFoodStampWarning(){
		<c:url var="img" value="${request.getContextPath()}/hebAssets/images/red_star.png"></c:url>
		var foodStamp = YAHOO.util.Dom.get("foodStamp");
		var foodStampDefault = YAHOO.util.Dom.get("foodStampDefault");
		var foodStampvalue = 'N=No';
		var foodStampDefaultValue = 'N=No';
		var redSignFoodStamp = 'Food Stampable <img src="${img}" width="8" height="8" class="icon" onclick="warningFoodStamp();"/>';
		if((foodStamp.checked==true && foodStampDefault.value == 'false') || (foodStamp.checked==false && foodStampDefault.value == 'true')){
			if(foodStamp.checked==true){
				foodStampvalue = 'Y=Yes';
			}
			if(foodStampDefault.value == 'true')
				foodStampDefaultValue = 'Y=Yes';
			alert('Food Stamp Flag (selected as '+foodStampvalue+') is different than the default for the sub-commodity (set at '+foodStampDefaultValue+')');
			document.getElementById('foodStampImageId').style.display  ='block';
		} else {
			document.getElementById('foodStampImageId').style.display  ='none';
		}
	}
	function warningFoodStamp()
	{
		var foodStamp = YAHOO.util.Dom.get("foodStamp");
		var foodStampDefault = YAHOO.util.Dom.get("foodStampDefault");
		var foodStampvalue = 'N=No';
		var foodStampDefaultValue = 'N=No';
		if((foodStamp.checked==true && foodStampDefault.value == 'false') || (foodStamp.checked==false && foodStampDefault.value == 'true')){
			if(foodStamp.checked==true)
				foodStampvalue = 'Y=Yes';
			if(foodStampDefault.value == 'true')
				foodStampDefaultValue = 'Y=Yes';
			alert('Food Stamp Flag (selected as '+foodStampvalue+') is different than the default for the sub-commodity (set at '+foodStampDefaultValue+')');
		}
	}

	function warningTaxFlag(){
		var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
		var taxFlagDefault = YAHOO.util.Dom.get("taxabilityDefaultFlag");
		var taxvalue = 'N=No';
		var taxFlagDefaultValue = 'N=No';
		if(((taxFlag.checked && taxFlagDefault.value == 'false') || (!taxFlag.checked && taxFlagDefault.value == 'true'))
				&& !isWorkingKitComponents()){
			if(taxFlag.checked)
				taxvalue = 'Y=Yes';
			if(taxFlagDefault.value == 'true')
				taxFlagDefaultValue = 'Y=Yes';
			alert('Tax Flag (selected as '+taxvalue+') is different than the default for the sub-commodity (set at '+taxFlagDefaultValue+')');
		}
	}

	function warningTaxCategory(){
		var taxCateWrap = YAHOO.util.Dom.get("taxCategoryWrap");
		if(taxCateWrap.innerHTML.indexOf("-Select-") != -1){
			alert('There is no Tax Category. Please select a tax category before saving.');
		}else{
			alert('Tax Category is different than the default for the sub-commonity');
		}
	}

	function  checkDrug(){

		if (document.getElementById('drugFactPanel').checked){
			document.getElementById('taxabilityFlag').checked = false ;

			var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
			var taxFlagDefault = YAHOO.util.Dom.get("taxabilityDefaultFlag");
			var taxvalue = 'N=No';
			var taxFlagDefaultValue = 'N=No';
			if(((taxFlag.checked && taxFlagDefault.value == 'false') || (!taxFlag.checked && taxFlagDefault.value == 'true'))
					&& !isWorkingKitComponents()){
				if(taxFlag.checked){
					taxvalue = 'Y=Yes';
				}
				if(taxFlagDefault.value == 'true')
					taxFlagDefaultValue = 'Y=Yes';
				alert('Tax Flag (selected as '+taxvalue+') is different than the default for the sub-commodity (set at '+taxFlagDefaultValue+')');
				document.getElementById('taxableImageId').style.display  ='block' ;
			} else {
				document.getElementById('taxableImageId').style.display  ='none' ;
			}

		}
		else
		{
			if(checkedTax == true){
				document.getElementById('taxabilityFlag').checked =true ;
			}

		}
	}

	function checkActiveUPC(){
		var depositUpcCheck = document.getElementById('depositUPC').value;
		if(depositUpcCheck!="" && null != depositUpcCheck){
			var depositUpcCheckTemp =  parseFloat(depositUpcCheck);
			if(isNaN(depositUpcCheckTemp)){
				alert("Deposit UPC must be a numeric value");
				document.getElementById('depositUPC').value ="";
				document.getElementById('depositUPC').focus;
			} else {
				showProgress();
				AddCandidateTemp.validateDepositUPC(depositUpcCheck,getDWRCallbackMethod(depositCallBack));
			}
		}
	}

	function depositCallBack(data){
		hideProgress();
		if(data=="Fails"){
			alert('Deposit UPC entered is not a Active UPC, please re-enter');
			document.getElementById('depositUPC').value ="";
			document.getElementById('depositUPC').focus;
		}
	}

	function populatePosAcctLists(data){
		<cps:renderByResourceAccess resourceId="178">
			<jsp:attribute name="EDIT">
				var laborCats = data.LABOR_CATS;
				<cps:currentComponentValueSubTag strutsHiddenElmProperty="productVO.pointOfSaleVO.laborCategory" uniqueId="ignore" />
				<c:if test="${currentComponentId != null}"></c:if>
			</jsp:attribute>
		</cps:renderByResourceAccess>
		var rating = document.getElementById("ratingHidden");
	
		if(rating!=null && rating!="")
		{
			var rateType= document.getElementById("rateHidden").value;
			dwr.util.setValue("rateType", rateType);
			dwr.util.setValue("rating", rating.value);
		}
		var pse = document.getElementById("pseHidden");
		if(pse!=null && pse!="")
		{
			dwr.util.setValue("pse", pse.value);
		}
	}

	function populateRateAndRating(data)
	{
		dwr.util.addOptions("rateType", data, "id", "name");
		var rating = document.getElementById("ratingHidden").value;
		if(rating!=null && rating!="" )
		{
			showProgress();
			AddCandidateTemp.getAllParamForRating(rating,getDWRCallbackMethod(fillDataBaseOnRating));
		}
	}

	function fillDataBaseOnRating(data)
	{
		hideProgress();
		dwr.util.removeAllOptions("rating");
		dwr.util.addOptions("rating", data.rateTing, "id", "name");
		if(document.getElementById("restrictedLimitName"))
		{
			document.getElementById("restrictedLimitName").value = data.restrictedLimitName
		}
		if(document.getElementById("purchaseTime"))
		{
			document.getElementById("purchaseTime").value = data.purchaseTime
		}
		//set Selected index for rateType and rating
		dwr.util.setValue("rateType", data.rateType);
		var rating = document.getElementById("ratingHidden").value;
		dwr.util.setValue("rating", rating);
	}

	function changeRatingType(ratingType,salsRstrCd,restrictionId)
	{
		showProgress();
		AddCandidateTemp.getRating(ratingType,salsRstrCd,{
			callback:function(data){
			  hideProgress();
			  if(data!=null) {
				if(data.appData.rstredQty>0 && (ratingType=="10" || ratingType=="11")) {
					restrictionId.innerHTML =data.appData.minRstrAgeNbr==0 ? "No age restriction" :data.appData.minRstrAgeNbr+" years and older, Quantity Limit = "+data.appData.rstredQty + (ratingType=="11"? " tablets per "+data.appData.rstredQty + " days" :" per Customer Order");
				} else {
					restrictionId.innerHTML =data.appData.minRstrAgeNbr==0 ? "No age restriction" :data.appData.minRstrAgeNbr+" years and older";
				}
			  }
			}
		})
	}

	function changeRating()
	{
		var selectBox1 = YAHOO.util.Dom.get("rateType");
		var selectBox2= YAHOO.util.Dom.get("rating");
		var rType=selectBox1.options[selectBox1.selectedIndex].value;
		var rT=selectBox2.options[selectBox2.selectedIndex].value;
		showProgress();
		AddCandidateTemp.getAgeAndTimeRestric(rType,rT,getDWRCallbackMethod(displayRestric));
	}

	function displayRestric(data)
	{
		hideProgress();
		if(document.getElementById("restrictedLimitName"))
		{
			document.getElementById("restrictedLimitName").value = data.restrictedLimitName
		}
		if(document.getElementById("purchaseTime"))
		{
			document.getElementById("purchaseTime").value = data.purchaseTime
		}
	}

	var editStatus = false;

	<c:url var="psePopup" value="/protected/cps/add/psePopup?${_csrf.parameterName}=${_csrf.token}"></c:url>
	function changePSE()
	{
		var pseCbx = YAHOO.util.Dom.get("pse");
		var pseVl=pseCbx.options[pseCbx.selectedIndex].value;
		editStatus = true;
		if(pseVl!="")
		{
			generatePsePopup(pseCbx);
		}
	}

	function doWhenChangeTypeN(data)
	{

	}

	YAHOO.namespace("heb.container.psePopup");
	var oncePse = false;
	function generatePsePopup(pseCbx){
		showProgress();
		document.getElementById("panelPse").style.display="inline";
		if(oncePse == false){
			oncePse = true;
			YAHOO.heb.container.psePopup = new YAHOO.widget.Panel("panelPse",
				{ 	width:"700px",
				height:"400px",
				underlay:"shadow",
				visible:false,
				constraintoviewport:true,
				draggable:false,
				zIndex : 15000,
				modal:true,
				close:false,
				fixedCenter : true
			} );

			YAHOO.heb.container.psePopup.render();
		}

		YAHOO.heb.container.psePopup.beforeHideEvent.subscribe(onBeforeHideEvent);
		YAHOO.heb.container.psePopup.beforeShowEvent.subscribe(onBeforeShowEvent);
		YAHOO.heb.container.psePopup.show();

		document.getElementById("popupFramePse").style.height="100%";
		document.getElementById("popupFramePse").style.width="100%";
		document.getElementById("popupFramePse").src = '${psePopup}'+'&pseType='+pseCbx.options[pseCbx.selectedIndex].text
		document.getElementById("popupHeaderPse").innerHTML = '<font size="2" color="white">&nbsp;&nbsp;&nbsp; PSE</font>';
	}

	function onShowEvent(){
	}

	function onBeforeShowEvent(){
	}

	function onBeforeHideEvent(){
		document.getElementById("panelPse").style.display="hidden";
		document.getElementById("popupFramePse").src = "";
		document.getElementById("popupHeaderPse").innerHTML = "";

	}

	function closePsePopup(flag){
		if(flag)
		{
			document.getElementById("panelPse").style.display="none";
			document.getElementById("popupFramePse").src = "";
			document.getElementById("popupHeaderPse").innerHTML = "";

		}
		YAHOO.heb.container.psePopup.hide();
	}

	function changeStatus()
	{
		editStatus = false;
		var pseCbx = YAHOO.util.Dom.get("pse");

		initValue = pseCbx.selectedIndex;
		pseCbx.selectedIndex = -1;
	}
	function resetPSE()
	{
		var pseCbx = YAHOO.util.Dom.get("pse");
		if(!editStatus)
		{
			var pseCbx = YAHOO.util.Dom.get("pse");
			pseCbx.selectedIndex = initValue;
		}
	}
	function validateFamily()
	{
		if(document.getElementById("familyCode1"))
		{
			if(isNaN(document.getElementById("familyCode1").value))
			{
				alert('Family Cd 1 must be an integer and between [0,999].');
				document.getElementById("familyCode1").value='';
			}
		}
		if(document.getElementById("familyCode2"))
		{
			if(isNaN(document.getElementById("familyCode2").value))
			{
				alert('Family Cd 2 must be an integer and between [0,999].');
				document.getElementById("familyCode2").value='';
			}
		}
	}

	var taxCatePanel;
	function tooltip_show(event) {
	}
	var codeName = '<c:out value="${addNewCandidate.productVO.pointOfSaleVO.taxCateCode}"/>';
	var subCommodityModify = '<c:out value="${addNewCandidate.productVO.classificationVO.subCommodity}"/>';
	var taxCatePanel,tableTaxCateLeftPanel,
	tableTaxCateRightPanel;
	var txBltyDvrCodeSelected = "";
	var taxListCategory = new Array();
	var taxListCategoryDistinct = new Array();
	var taxCategoryFormatter = function(elLiner, oRecord, oColumn, oData) {
		if(oRecord.getData('radioOption')){
			elLiner.innerHTML = "<div style='float:left'><input type='radio' name='taxOption'  checked onclick='onChangeOption(this)'></div>"
			+"<div style='float:left;padding-top:3px;white-space: nowrap; max-width: 290px; overflow: hidden; text-overflow: ellipsis;' title='"+oRecord.getData('txBltyDvrName')+"'>"
			+"<label id='"+oRecord.getData('txBltyDvrCode')+"' onclick='rowTaxClick(this)'>"
			+oRecord.getData('txBltyDvrCode')+"-"+oRecord.getData('txBltyDvrName')+"</label></div>"
			+ "<div style='float:left'><img src='${iconQuestion}' title='"+oRecord.getData('txBltyCatDesc')+"'></image> </div>";
		}else {
			elLiner.innerHTML = "<div style='float:left'><input type='radio' name='taxOption' onclick='onChangeOption(this)'></div>"
			+"<div style='float:left;padding-top:3px;white-space: nowrap; max-width: 290px; overflow: hidden; text-overflow: ellipsis;' title='"+oRecord.getData('txBltyDvrName')+"'>"
			+"<label id='"+oRecord.getData('txBltyDvrCode')+"' onclick='rowTaxClick(this)'>"
			+oRecord.getData('txBltyDvrCode')+"-"+oRecord.getData('txBltyDvrName')+"</label></div>"
			+ "<div style='float:left'><img src='${iconQuestion}' title='"+oRecord.getData('txBltyCatDesc')+"'></image> </div>";
		}
	};
	var prodDesFormatter = function(elLiner, oRecord, oColumn, oData) {
		elLiner.innerHTML = "<div style='white-space: nowrap; max-width: 215px; overflow: hidden; text-overflow: ellipsis;' title='"+oRecord.getData('productDes')+"'>"
		+oRecord.getData('productDes')+"</div>";
	};
	var columnDefsTaxCate = [ {key:"taxCategory", label : "Tax Category",formatter:taxCategoryFormatter,width:349}];
	var columnDefsProduct = [ {key:"productId", label : "Product ID",width:50},
	{key:"productDes", label : "Product Description",formatter:prodDesFormatter,width:215},
	{key:"size", label : "Size",width:42}];
	// CPSForm
	<c:forEach var="item" items="${addNewCandidate.productVO.pointOfSaleVO.listTaxCategory}" varStatus="count">
	taxListCategory.push({
		taxCategory:'${item.txBltyDvrCode}',
		radioOption:false,
		txBltyDvrCode:'${item.txBltyDvrCode}',
		txBltyDvrName:'${item.txBltyDvrName}',
		txBltyCatDesc:'${item.txBltyCatDesc}'});
	</c:forEach>
	<c:forEach var="item" items="${addNewCandidate.productVO.pointOfSaleVO.listTaxCategoryDistinct}" varStatus="count">
	taxListCategoryDistinct.push({
		taxCategory:'${item.txBltyDvrCode}',
		radioOption:false,
		txBltyDvrCode:'${item.txBltyDvrCode}',
		txBltyDvrName:'${item.txBltyDvrName}',
		txBltyCatDesc:'${item.txBltyCatDesc}'});
	</c:forEach>
	function buildDataCategoryDistinct(){
		<c:forEach var="item" items="${addNewCandidate.productVO.pointOfSaleVO.listTaxCategoryDistinct}" varStatus="count">
		taxListCategoryDistinct.push({
			taxCategory:'${item.txBltyDvrCode}',
			radioOption:false,
			txBltyDvrCode:'${item.txBltyDvrCode}',
			txBltyDvrName:'${item.txBltyDvrName}',
			txBltyCatDesc:'${item.txBltyCatDesc}'});
		</c:forEach>
	}

	function taxWarningDefault(defaultTaxCateValue,newTaxCateValue){
		if(defaultTaxCateValue != ""){
			if(newTaxCateValue != defaultTaxCateValue && !isWorkingKitComponents()){
				document.getElementById('taxCateImageId').style.display  ='block' ;
			}else{
				document.getElementById('taxCateImageId').style.display  ='none' ;
			}
		}
	}

	function setTaxFlagWhenChangeTaxCate(subCommodity, vertexTax){
		var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
		var taxFlagDefault = YAHOO.util.Dom.get("taxabilityDefaultFlag");
		showProgress();
		var callbacks = {
				success : function(o) {
			try {
			if (o != null && myTrim(o.responseText) != "") {
				if(myTrim(o.responseText) == "true"){
					taxFlag.checked = true;
				}else if(myTrim(o.responseText) == "false"){
					taxFlag.checked = false;
				}else{
				}
			}
			displayTaxFlagWarning1();
			hideTheProgress();
		} catch (e) {
			hideTheProgress();
			return;
			}
		},
			failure : function() {
			hideTheProgress();
		},
			timeout : 50000
		};
			YAHOO.util.Connect.asyncRequest('GET',"setTaxFlagWhenChangeTaxCate?vertexTax="+vertexTax+"&subCommodity="+subCommodity, callbacks);
	}

	function getTaxCateDefault(subCommodity, newValue){
		var object = null;
		var taxAble = taxFlag.checked;
		var callbacks = {
			success : function(o) {
		try {
		if (o != null && myTrim(o.responseText) != "") {
			object = YAHOO.lang.JSON.parse(o.responseText);
			var str = object['txBltyDvrCode']+"-"+object['txBltyDvrName'];
			taxWarningDefault(myTrim(str),newValue);
		}else{
			taxWarningDefault("None",newValue);
		}
	} catch (e) {
		return;
		}
	},
		failure : function() {
	},
		timeout : 50000
	};
		YAHOO.util.Connect.asyncRequest('GET',"getTaxCateDefault?subCommodity="+subCommodity, callbacks);
	}

	function showTableTaxCategory(){
		var dataLocalTaxCate = new YAHOO.util.LocalDataSource(taxListCategory);
		tableTaxCateLeftPanel = new  YAHOO.widget.ScrollingDataTable("tblTaxCategory", columnDefsTaxCate,dataLocalTaxCate,{width:"370px",height:"380px"});
		tableTaxCateLeftPanel.subscribe("rowMouseoverEvent", tableTaxCateLeftPanel.onEventHighlightRow);
		tableTaxCateLeftPanel.subscribe("rowMouseoutEvent", tableTaxCateLeftPanel.onEventUnhighlightRow);
		tableTaxCateLeftPanel.subscribe("rowClickEvent", tableTaxCateLeftPanel.onEventSelectRow);
		tableTaxCateLeftPanel.subscribe("radioClickEvent", function(oArgs){
			var elRadio = oArgs.target;
			var oRecord = this.getRecord(elRadio);
			document.getElementById("taxCategoryWrap").innerHTML = oRecord.getData("txBltyDvrCode")+"-"+oRecord.getData("txBltyDvrName");
			document.getElementById("taxCateCodeHidden").value = oRecord.getData("txBltyDvrCode");
			document.getElementById("taxCateNameHidden").value = oRecord.getData("txBltyDvrName");
			closeSingleEtPanel();
			displayTaxCateFlag();
			var subComm = YAHOO.util.Dom.get("subCommodityStrutsHiddenElm");
			setTaxFlagWhenChangeTaxCate(subComm.value, oRecord.getData("txBltyDvrCode"));
			var newTaxCategoryWrap = myTrim(document.getElementById("taxCategoryWrap").innerHTML);
			var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
			if(null != subComm && subComm != undefined){
				 getTaxCateDefault(subComm.value, newTaxCategoryWrap);
			 }
		});
		var sortFunction = function(field){
			return function (a,b){
				if(a[field].toLowerCase() < b[field].toLowerCase()){
					return -1;
				}
				if(a[field].toLowerCase() > b[field].toLowerCase()){
					return 1;
				}
				return 0;
			}
		}
		tableTaxCateLeftPanel.getDataSource().doBeforeCallback = function (req,raw,res,cb) {
			var data     = res.results || [],
			filtered = [],
			i,l;
			if (req) {
				if(req.indexOf("-") >= 0){
					var arr = req.split("-");
					var code = arr[0];
					code = code.toLowerCase();
					for (i = 0, l = data.length; i < l; ++i) {
						if (data[i].txBltyDvrCode.toLowerCase().indexOf(code) >=0) {
							data[i].radioOption = true;
							filtered.push(data[i]);
						}else {
							data[i].radioOption = false;
						}
					}
				}else {
					req = req.toLowerCase();
					for (i = 0, l = data.length; i < l; ++i) {
						if (data[i].txBltyDvrName.toLowerCase().indexOf(req) >=0 || data[i].txBltyDvrCode.toLowerCase().indexOf(req) >=0) {
							filtered.push(data[i]);
						}
					}
				}

				res.results = filtered;
			}else {
				var taxCategoryWrapTm = myTrim(document.getElementById("taxCategoryWrap").innerHTML);
				if(taxCategoryWrapTm.indexOf("-") >= 0){
					var arr = taxCategoryWrapTm.split("-");
					var code = arr[0].toLowerCase();
					for (i = 0, l = data.length; i < l; ++i) {
						if (taxCategoryWrapTm.indexOf("-Select-")==-1 && data[i].txBltyDvrCode.toLowerCase().indexOf(code) >=0) {
							data[i].radioOption = true;
						}else {
							data[i].radioOption = false;
						}
					}
				}
			}
	//         if(res.results != null && res.results.length > 0){
	//         	res.results.sort(sortFunction('txBltyDvrName'));
	//         }
	return res;
	};
	}
	var updateFilter  = function () {
		tableTaxCateLeftPanel.getDataSource().sendRequest(YAHOO.util.Dom.get('filterTxtTaxCategory').value ,{
			success : tableTaxCateLeftPanel.onDataReturnInitializeTable,
			failure : tableTaxCateLeftPanel.onDataReturnInitializeTable,
			scope   : tableTaxCateLeftPanel
		});
	}
	function showTableProduct(){
		var dataLocalProduct = new YAHOO.util.LocalDataSource(new Array());
		tableTaxCateRightPanel = new  YAHOO.widget.ScrollingDataTable("tblProduct", columnDefsProduct,dataLocalProduct,{width:"370px",height:"380px"});
		tableTaxCateRightPanel.subscribe("rowMouseoverEvent", tableTaxCateRightPanel.onEventHighlightRow);
		tableTaxCateRightPanel.subscribe("rowMouseoutEvent", tableTaxCateRightPanel.onEventUnhighlightRow);
		tableTaxCateRightPanel.subscribe("rowClickEvent", tableTaxCateRightPanel.onEventSelectRow);
	}
	var itemsPerPage = 50;
	var currentPage = 1;
	var numberPageView = 10;
	var pages = 0;
	function pagerprev() {
		if (currentPage > 1){
			if((currentPage%numberPageView) == 1) {
				preparePaging(currentPage - numberPageView,currentPage - 1);
			}else {
				pagershowPage(currentPage - 1);
			}
		}
	}
	function pagershowPage(pageNumber) {
		var oldPageAnchor = document.getElementById('pg'+currentPage);
		if(oldPageAnchor != null){
			oldPageAnchor.className = 'pg-normal';
		}
		currentPage = pageNumber;
		var newPageAnchor = document.getElementById('pg'+currentPage);
		if(newPageAnchor != null){
			newPageAnchor.className = 'pg-selected';
		}
		var from = 0;
		var from = (pageNumber - 1) * itemsPerPage;
		showRecords(from, itemsPerPage);
	}
	function showRecords(from, numberOfRows) {
		if(totalRecord < itemsPerPage) {
			getDataProduct(txBltyDvrCodeSelected,from,totalRecord);
		}else {
			getDataProduct(txBltyDvrCodeSelected,from,itemsPerPage);
		}
	}
	function pagernext() {
		if (currentPage < pages) {
			if((currentPage%numberPageView) == 0) {
				preparePaging(currentPage + 1,currentPage + 1);
			}else {
				pagershowPage(currentPage + 1);
			}
		}
	}

	function preparePaging(from,pageCurrent){
		var positionId = 'pageNavPosition';
		var pagerName = 'pager';
		var element = document.getElementById(positionId);
		var pagerHtml = '<span onclick="' + pagerName + 'prev();" class="pg-normal"> &#171 Prev </span> | ';
		var end = 0;
		if((pages-from) < (numberPageView -1)){
			end = pages;
		}else {
			end = from + numberPageView -1;
		}
		for (var page = from; page <= end; page++){
			pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName + 'showPage(' + page + ');">' + page + '</span> | ';
		}
		pagerHtml += '<span onclick="'+pagerName+'next();" class="pg-normal"> Next &#187;</span>';
		element.innerHTML = pagerHtml;
		pagershowPage(pageCurrent);
	}

function showTaxCatePop(){
	if(subCommodityTmp != null && subCommodityTmp != "" && subCommodityTmp != undefined ){
		if(subCommodityTmp == subCommodityTmpLastTime && taxListCategoryDistinct.length > 0) {
			showTaxCatePopExe();
		}else {
			getListDataDistinct(subCommodityTmp);
		}
	}else {
		if(null != subCommodityModify && subCommodityModify != ""){
			subCommodityTmp = subCommodityModify;
			if(subCommodityTmp == subCommodityTmpLastTime && taxListCategoryDistinct.length > 0) {
				showTaxCatePopExe();
			}else {
				getListDataDistinct(subCommodityTmp);
			}
		}
	}
}
function getListDataDistinct(subCommodity) {
	showProgress();
	var callbacks = {
		success : function(o) {
			try {
				if (o != null && myTrim(o.responseText) != "") {
					if(o.responseText.indexOf("cpsexception:") != -1){
						var error = document.getElementById('errorMess');
						if(null != error && error != undefined){
							document.getElementById('errorMess').innerHTML = myTrim(o.responseText).slice(13);
							document.getElementById("errorMess").style.display="inline";
						}
						
					}else{
						taxListCategoryDistinct = YAHOO.lang.JSON.parse(o.responseText);
						if(taxListCategoryDistinct != null && taxListCategoryDistinct.length > 0){
							subCommodityTmpLastTime = subCommodityTmp;
						}else {
							subCommodityTmpLastTime = "";
						}
					}
				}else{
						taxListCategoryDistinct = new Array();
						subCommodityTmpLastTime = "";
					}
				showTaxCatePopExe();
				hideTheProgress();
			} catch (e) {
					hideTheProgress();
					return;
				}
			},
			failure : function(e) {
				//alert(e);
				// document.getElementById('errorMess').innerHTML = 'Error connecting data.';
				// document.getElementById("errorMess").style.display="inline";
				hideTheProgress();
			},
			timeout : 50000
		};
		YAHOO.util.Connect.asyncRequest('GET',
			"getListDataDistinct?subCommodity="+subCommodity, callbacks);
	}
	function showTaxCatePopExe(){
		document.getElementById("taxCategoryPop").style.display="inline";
		taxCatePanel = new YAHOO.widget.Panel("taxCategoryPop",
			{ 	width:"768px",
			height:"600px",
			underlay:"shadow",
			visible:false,
			constraintoviewport:true,
			draggable:false,
			zIndex : 1,
			modal:true,
			close:false,
			fixedCenter : true
		} );
		showTableTaxCategory();
		var taxCategoryWrap = myTrim(document.getElementById("taxCategoryWrap").innerHTML);
		showTableProduct();
		taxCatePanel.render(document.body);
		if(taxCategoryWrap != null && taxCategoryWrap != "" && taxCategoryWrap.indexOf("-Select-")==-1 &&
			taxCategoryWrap != "-" && taxCategoryWrap.indexOf("-")>= 0) {
			var arr = taxCategoryWrap.split("-");
		var code = arr[0];
		var arrTaxSelected = new Array();
		if(taxListCategory != null && taxListCategory.length > 0) {
			for (var i = 0;i < taxListCategory.length; ++i) {
				var taxObj = taxListCategory[i];
				if (taxObj["txBltyDvrCode"].indexOf(code) >=0) {
					arrTaxSelected.push(taxObj);
				}
			}
		}
		fillDataIntoTableTaxCate(arrTaxSelected);
		tableTaxCateLeftPanel.getDataSource().sendRequest(taxCategoryWrap ,{
			success : tableTaxCateLeftPanel.onDataReturnInitializeTable,
			failure : tableTaxCateLeftPanel.onDataReturnInitializeTable,
			scope   : tableTaxCateLeftPanel
		});
		document.getElementById("distinctId").checked = false;
		document.getElementById("showAllId").checked = false;
		displayTaxCateFlag();
		}else {
		// 	remove radioOption
			for(var i = 0; i < taxListCategory.length ;i++){
				taxListCategory[i].radioOption = false;
			}
			fillDataIntoTableTaxCate(taxListCategoryDistinct);
			document.getElementById("distinctId").checked = true;
		}
		showTableProduct();
		taxCatePanel.show();
		document.getElementById("pageNavPosition").style.display="none";
	}
	var totalRecord = 0;
	function getTotalProduct(txBltyDvrCode) {
		document.getElementById("errorMess").style.display="none";
		txBltyDvrCodeSelected = txBltyDvrCode;
		showProgress();
		var callbacks = {
			success : function(o) {
				try {
					if (o != null && o.responseText != "") {
						var totalRecordObj = YAHOO.lang.JSON.parse(o.responseText);
						if(totalRecordObj != null && totalRecordObj['total'] != ""){
							totalRecord = parseInt(totalRecordObj['total']);
							pages = Math.ceil(totalRecord / itemsPerPage);
							document.getElementById("pageNavPosition").style.display="inline";
							preparePaging(1,1);
						}else {
							document.getElementById("pageNavPosition").style.display="none";
							hideTheProgress();
						}
					}else {
						document.getElementById("pageNavPosition").style.display="none";
						hideTheProgress();
					}
	// 					hideTheProgress();
				} catch (e) {
							hideTheProgress();
							document.getElementById("pageNavPosition").style.display="none";
							return;
						}
					},
					failure : function() {
						document.getElementById("pageNavPosition").style.display="none";
						document.getElementById('errorMess').innerHTML = 'Error connecting data.';
						document.getElementById("errorMess").style.display="inline";
						hideTheProgress();
					},
					timeout : 50000
				};
			// Make the call to the server for JSON data
			YAHOO.util.Connect.asyncRequest('GET',
				"getTotalProdByTaxCategory?txBltyDvrCode="+txBltyDvrCode, callbacks);
	}

	function rowTaxClick(element){
		var value = element.id;
		// 	get total record;
		getTotalProduct(value);
		// 	after get list record with startValue and nbrOfRows
	}
	function getDataProduct(txBltyDvrCode,startValue,nbrOfRows) {
		document.getElementById("errorMess").style.display="none";
		var dataListAttr = null;
		showProgress();
		var callbacks = {
			success : function(o) {
				try {
					if (o != null && o.responseText != "") {
						dataListAttr = YAHOO.lang.JSON.parse(o.responseText);
						fillDataIntoTableProduct(dataListAttr);
					}
					hideTheProgress();
				} catch (e) {
					fillDataIntoTableProduct(dataListAttr);
					hideTheProgress();
					return;
				}
			},
			failure : function() {
				document.getElementById('errorMess').innerHTML = 'Error connecting data.';
				document.getElementById("errorMess").style.display="inline";
				hideTheProgress();
			},
			timeout : 60000
		};
				// Make the call to the server for JSON data
		YAHOO.util.Connect.asyncRequest('GET',
			"getListProdByTaxCategory?txBltyDvrCode="+txBltyDvrCode+"&startValue="+startValue+"&numberOfRows="+nbrOfRows+"&total="+totalRecord, callbacks);
	}
	function fillDataIntoTableProduct(dataListAttr){
		tableTaxCateRightPanel.getDataSource().liveData = dataListAttr;
		tableTaxCateRightPanel.getDataSource().sendRequest(null, {success: tableTaxCateRightPanel.onDataReturnInitializeTable},tableTaxCateRightPanel);
	}
	function fillDataIntoTableTaxCate(dataListAttr){
		tableTaxCateLeftPanel.getDataSource().liveData = dataListAttr;
		tableTaxCateLeftPanel.getDataSource().sendRequest(null, {success: tableTaxCateLeftPanel.onDataReturnInitializeTable},tableTaxCateLeftPanel);
		tableTaxCateRightPanel.getDataSource().liveData = new Array();
		tableTaxCateRightPanel.getDataSource().sendRequest(null, {success: tableTaxCateRightPanel.onDataReturnInitializeTable},tableTaxCateRightPanel);
		tableTaxCateRightPanel.refreshView();
	}
	function changeRadio(element){
		if(element.value == "showall"){
			fillDataIntoTableTaxCate(taxListCategory);
		}else {
			fillDataIntoTableTaxCate(taxListCategoryDistinct);
		}
		if(null != document.getElementById("pageNavPosition")){
			document.getElementById("pageNavPosition").style.display="none";
		}
	}
	function searchTaxCategory(){
		var text = document.getElementById("filterTxtTaxCategory").value;
		if(text != ""){
			updateFilter();
		}
	}
	function fillDataIntoTaxWrap(object){
		if (!isWorkingKitComponents()) {
			if(null != object && null != object['txBltyDvrCode'] && 'null' != object['txBltyDvrCode']){
				var str = object['txBltyDvrCode']+"-"+object['txBltyDvrName'];
				document.getElementById("taxCateCodeHidden").value = object['txBltyDvrCode'];
				document.getElementById("taxCateNameHidden").value = object['txBltyDvrName'];
				document.getElementById("taxCategoryWrap").innerHTML = str;
				document.getElementById('taxCateImageId').style.display  ='none' ;
			}else {
				document.getElementById("taxCateCodeHidden").value = '';
				document.getElementById("taxCateNameHidden").value = '';
				document.getElementById("taxCategoryWrap").innerHTML = '-Select-';
				document.getElementById('taxCateImageId').style.display  ='block' ;
			}

			var subComm = YAHOO.util.Dom.get("subCommodityStrutsHiddenElm");
			if(null != subComm && subComm != undefined){
				getTaxCateDefault(subComm.value, str);
			}
		}
	}
	var subCommodityTmp = "";
	var subCommodityTmpLastTime = "";

	function changeValueTaxWrap(subCommodity, taxFlag){
		subCommodityTmp = subCommodity;
		var object = null;
		var taxAble = taxFlag.checked;
		var callbacks = {
			success : function(o) {
		try {
			if (o != null && myTrim(o.responseText) != "") {
				object = YAHOO.lang.JSON.parse(o.responseText);
				fillDataIntoTaxWrap(object);
			}else{
				fillDataIntoTaxWrap(null);
			}
			hideTheProgress();
		} catch (e) {
			hideTheProgress();
			return;
			}
		},
			failure : function() {
			hideTheProgress();
		},
			timeout : 50000
		};
			YAHOO.util.Connect.asyncRequest('GET',
		"getTaxCategoryBasedOnTaxFlag?taxFlag="+taxAble+"&subCommodity="+subCommodity, callbacks);
	}

	function clearFilter(){
		document.getElementById("filterTxtTaxCategory").value = '';
		updateFilter();
	}

	function closeSingleEtPanel(){
		document.getElementById("taxCategoryPop").style.display="none";
		taxCatePanel.hide();
		if(null != document.getElementById("taxCategoryWrap") && document.getElementById("taxCategoryWrap") != undefined){
			 var newTaxCategoryWrap = myTrim(document.getElementById("taxCategoryWrap").innerHTML);
			 var subComm = YAHOO.util.Dom.get("subCommodityStrutsHiddenElm");
			 var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
			 if(null != subComm && subComm != undefined){
				 getTaxCateDefault(subComm.value, newTaxCategoryWrap);
			 }
		}
	}

	function onChangeOption(){
	}

	function myTrim(x) {
		return x.replace(/^\s+|\s+$/gm,'');
	}

	//Generate table for selling restrictions
	var tblSellingRestriction;
	var Event = YAHOO.util.Event;

	function changeDDRateType(value, oRecord,rowId,sellingType,alcohol,offPremiseConsumption,isload,isProduct){
		showProgress();
		var dataRating = null;
		var callbacks = {
			success : function(o) {
				try {
					if (o != null && o.responseText != "") {
						dataRating = YAHOO.lang.JSON.parse(o.responseText);
						// alert(dataRating)
	// 					updateRating(dataRating,oRecord);
						updateRatingOption(dataRating,rowId,sellingType,alcohol,offPremiseConsumption,isload,isProduct);
					}
					hideTheProgress();
				} catch (e) {

					hideTheProgress();
					return;
				}
			},
			failure : function() {
				hideTheProgress();
			},
			timeout : 50000
		};
		YAHOO.util.Connect.asyncRequest('GET',
			"changeSellingRestrictions?rateType="+value, callbacks);
	}

	function setJsonSellingRestrictions(oRecs){
		var sellingHidden = document.getElementById("jsonSellingRestrictionHidden");
		if(sellingHidden != undefined){
			sellingHidden.value =YAHOO.lang.JSON.stringify(oRecs);
		}
	}

	function validateBeforeSave(){
		setJsonSellingRestrictions(dataSourceSelling);
		if(dataSourceSelling != null && dataSourceSelling.length > 0) {
			//Sprint - 23
			var sellingTypeId = dataSourceSelling[0]["sellingTypeId"];
			var sellingResId = dataSourceSelling[0]["sellingResId"];
			if(dataSourceSelling.length>1){
				for (var f = 0; f < dataSourceSelling.length ; f++) {
					//console.log(dataSourceSelling[f]["sellingResId"]);
					//console.log(dataSourceSelling[f]["sellingTypeId"]);
					if(dataSourceSelling[f]["sellingResId"] == "-1" && dataSourceSelling[f]["sellingTypeId"] == "-1"){
						return "Selling Restriction and Type are mandatory fields.";
					} else if(dataSourceSelling[f]["sellingResId"] == "-1"){
						return "Please enter data into Selling Restriction.";
					} else if(dataSourceSelling[f]["sellingTypeId"] == "-1"){
						return "Please, enter mandatory fields of Selling Restriction.";
					}
				}
			} else if(sellingResId!="-1" && sellingTypeId=="-1") {
				return "Please, enter mandatory fields of Selling Restriction.";
			} else if((sellingResId != "-1" && sellingTypeId == "-1") ||(sellingResId == "-1" && sellingTypeId != "-1")){
				if(sellingResId == "1"){
					return "";
				}else{
					return "Selling Restriction and Type are mandatory fields.";
				}

			}

		}
		return "";
	}


	var initData = [{"rateType":[{"rateTypeId":"0","rateTypeName":"NONE"},{"rateTypeId":"6","rateTypeName":"ABUSIVE AND VOLATILE CHEMICAL"},{"rateTypeId":"5","rateTypeName":"MUSIC"},{"rateTypeId":"9","rateTypeName":"Shipping Restrictions"},{"rateTypeId":"8","rateTypeName":"LOTTERY"},{"rateTypeId":"1","rateTypeName":"ALCOHOL"},{"rateTypeId":"3","rateTypeName":"MOVIES"},{"rateTypeId":"4","rateTypeName":"GAMING"},{"rateTypeId":"7","rateTypeName":"OVER THE COUNTER"},{"rateTypeId":"2","rateTypeName":"TOBACCO"},{"rateTypeId":"10","rateTypeName":"Dextromethorphan"}],"rateTypeSelected":"-1","age":"","ratingSelected":"-1","rating":"","salesTime":"","isMapping":"false" }] ;

	function fillDataToTableSellingRes(dataSellingRes){

	}

	function getInitSellingResDT(subComm){
		showProgress();
		var dataSellingRes = null;
		var callbacks = {
			success : function(o) {
				try {
					if (o != null && o.responseText != "") {
						dataSellingRes = YAHOO.lang.JSON.parse(o.responseText);
						document.getElementById("jsonSellingRestrictionHidden").value = o.responseText;
						setDataDefaultForSellingTable(dataSellingRes);
					}
					hideTheProgress();
				} catch (e) {
					addRowSelling(true);
					hideTheProgress();
					return;
				}
			},
			failure : function() {
				addRowSelling(true);
				hideTheProgress();
			},
			timeout : 50000
		};
		YAHOO.util.Connect.asyncRequest('GET',
			"getSellingRestrictions?subComm="+subComm, callbacks);
	}
	//var dataSellingRestrictList = null;
	function getAllSellingRestrictions(){
		var callbacks = {
			success : function(o) {
				try {
					if (o != null && o.responseText != "") {
						dataSellingRestrictList = YAHOO.lang.JSON.parse(o.responseText);
						setDataForSellingList(dataSellingRestrictList);
						modifySellingRes();
					}
					hideTheProgress();
				} catch (e) {
					hideTheProgress();
					return;
				}
			},
			failure : function() {
				hideTheProgress();
			},
			timeout : 50000
		};
		YAHOO.util.Connect.asyncRequest('GET',"getAllSellingResFromCache", callbacks);
	}

	function showClrsSwHandle(){
		var showCaloriesFlag = YAHOO.util.Dom.get("showClrsSw");
		// show or hide fda menu labeling status when show calories checked or not
		document.getElementById("fdaMenuLabelingStatus").style.display = showCaloriesFlag.checked ? 'block' : 'none';
		showNutritionInformation(showCaloriesFlag.checked);
	}

	if(null != document.getElementById("taxCategoryWrap") && document.getElementById("taxCategoryWrap") != undefined
			 && !isWorkingKitComponents()){
		 var newTaxCategoryWrap = myTrim(document.getElementById("taxCategoryWrap").innerHTML);
		 var subComm = YAHOO.util.Dom.get("subCommodityStrutsHiddenElm");
		 var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
		 if(null != subComm && subComm != undefined){
			 getTaxCateDefault(subComm.value, newTaxCategoryWrap);
		 }else{
			 getTaxCateDefault(subCommodityModify, newTaxCategoryWrap);
		 }
	}

	YAHOO.util.Event.onDOMReady(function(){
		if('${addNewCandidate.upcValueFromMRT}' == 'false' && '${addNewCandidate.mrtUpcAdded}' == 'true'){
			modifyMode = true;
		}else{
			modifyMode = ${addNewCandidate.modifyMode};
		}
		getPosAcctLists();
		getAllSellingRestrictions();
		newDataSw= '${addNewCandidate.productVO.newDataSw}';
		isRenderView = ('<c:out value="${renderView}"/>' != 'E');	// check is render View get from pageContext for Selling Restriction Area
	 });

</script>