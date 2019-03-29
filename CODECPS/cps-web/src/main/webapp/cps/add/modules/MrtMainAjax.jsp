<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fieldset
	style="width: 95%; margin-left: 10px; border-collapse: collapse;"
	id="vendorDetailsFieldSet">
	<legend>Vendor Details</legend>
	<table width="100%" border="0">
		<tr>
			<td width="100%" align="center">
				<table width="100%" border="0">

					<tr align="left">
						<td align="right" width="12%"><label
							class="labelFont helpable" id="VendorLabel">Vendor <em><font
									color="red"><b>*</b></font></em>
						</label></td>
						<cps:renderByResourceAccess resourceId="116"
							honorViewMode="${CPSForm.caseViewOverRide}">
							<jsp:attribute name="EDIT">
				<td align="left" width="12%" colspan="3">&nbsp;&nbsp; <input
									type="hidden" value="${selectedVendorVO.uniqueId}"
									id="selectedVendorUniqId">
					<cps:autoCompleteVendor searchAction="vendorSearch"
										uniqueId="vendor" compWidth="80%" tabIdx="40"
										elmProperty="selectedVendorVO.vendorLocationVal"
										elmName="selectedVendorVO.formattedVendorLocation"
										highlightMatch="true" maxResults="999" searchOnId="true"
										showId="true" zi="9000" maxCacheEntries="0"
										onSelectMethod="setMrtCallAndResetDataCostList"
										onSelectMethod1="getVendorChannelTypeBetween" />
						<%-- <input type="text" id="vendorName" maxlength="8" tabindex="28" value="${selectedVendorVO.vendorName}"  class="textFieldNormal"/>   --%>
				</td>
				 </jsp:attribute>
							<jsp:attribute name="VIEW">
				 	<input type="hidden" value="${selectedVendorVO.vendorLocationVal}"
									id="vendorLocationVal">
				  <td align="left" width="12%" colspan="3">&nbsp;&nbsp; <input
									type="hidden" value="${selectedVendorVO.uniqueId}"
									id="selectedVendorUniqId">
							<input type="text" id="vendorLocation"
									value="${selectedVendorVO.formattedVendorLocation}"
									disabled="disabled" style="width: 80%;" />
							<%-- <input type="text" id="vendorName" maxlength="8" tabindex="28" value="${selectedVendorVO.vendorName}"  class="textFieldNormal"/>   --%>
				</td>
				  </jsp:attribute>
						</cps:renderByResourceAccess>

						<td align="right" width="12%"><label
							class="labelFont helpable" id="VPCLabel">VPC <em><font
									color="red"><b>*</b></font></em>
						</label></td>
						<cps:renderByResourceAccess resourceId="78"
							honorViewMode="${CPSForm.caseViewOverRide}">
							<jsp:attribute name="EDIT">
				<td align="left" width="12%">&nbsp;&nbsp; <input type="text"
									id="vpc" maxlength="13" tabindex="41"
									value="${selectedVendorVO.vpc}" class="textFieldNormal"
									style="TEXT-TRANSFORM: uppercase; dataType: alphanumericSpecialOnly;" /></td>
				</jsp:attribute>
							<jsp:attribute name="VIEW">
				<td align="left" width="12%">&nbsp;&nbsp; <input type="text"
									id="vpc" maxlength="13" tabindex="41"
									value="${selectedVendorVO.vpc}" class="textFieldNormal"
									style="TEXT-TRANSFORM: uppercase; dataType: alphanumericSpecialOnly;"
									disabled="disabled" /></td>
				</jsp:attribute>
						</cps:renderByResourceAccess>
						<td colspan="2">
							<table>
								<tr>
									<td align="right"><label class="labelFont helpable"
										id="GuranteedSaleLabel">Guaranteed Sale?</label></td>
									<td>&nbsp;&nbsp; <cps:renderByResourceAccess
											resourceId="118" honorViewMode="${CPSForm.caseViewOverRide}">
											<jsp:attribute name="EDIT">
							<td>&nbsp;&nbsp; 
											<c:if test="${selectedVendorVO.guarenteedSale eq true}">
												<input type="checkbox" id="gSales" tabindex="42" size="1"
															checked="checked">
											</c:if> <c:if test="${selectedVendorVO.guarenteedSale eq false}">
												<input type="checkbox" id="gSales" tabindex="42" size="1">
											</c:if>
							</td>	
										</jsp:attribute>
											<jsp:attribute name="VIEW">
											<td>&nbsp;&nbsp;
											 <c:if test="${selectedVendorVO.guarenteedSale eq true}">
													<input type="checkbox" id="gSales" tabindex="42" size="1"
															checked="checked" disabled="disabled">
												</c:if> <c:if test="${selectedVendorVO.guarenteedSale eq false}">
														<input type="checkbox" id="gSales" tabindex="42" size="1"
															disabled="disabled">
												</c:if>
											</td>
										</jsp:attribute>
										</cps:renderByResourceAccess></td>
								</tr>
								<tr>
									<td align="right"><label class="labelFont helpable"
										id="DealOfferedLabel">Deal Offered?</label></td>
									<td>&nbsp;&nbsp; <cps:renderByResourceAccess
											resourceId="119" honorViewMode="${CPSForm.caseViewOverRide}">
											<jsp:attribute name="EDIT">
						<td>&nbsp;&nbsp;<c:if
														test="${selectedVendorVO.dealOffered eq true}">
							<input type="checkbox" id="dealOffered" tabindex="43" size="1"
															checked="checked">
						</c:if> <c:if test="${selectedVendorVO.dealOffered eq false}">
							<input type="checkbox" id="dealOffered" tabindex="43" size="1">
						</c:if>
						</td>
						</jsp:attribute>
											<jsp:attribute name="VIEW">
				        <td>&nbsp;&nbsp;<c:if
														test="${selectedVendorVO.dealOffered eq true}">
							<input type="checkbox" id="dealOffered" tabindex="43" size="1"
															checked="checked" disabled="disabled">
						</c:if> <c:if test="${selectedVendorVO.dealOffered eq false}">
							<input type="checkbox" id="dealOffered" tabindex="43" size="1"
															disabled="disabled">
						</c:if>
						</td>
				        </jsp:attribute>
										</cps:renderByResourceAccess></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr align="left">
						<!-- 				<td align="right" width="12%"><label class="labelFont helpable" -->
						<!-- 					id="ListCostLabel">List Cost <em><font color="red"><b>*</b></font></em></label></td> -->
						<%-- 				<cps:renderByResourceAccess resourceId="120" --%>
						<%-- 					honorViewMode="${CPSForm.caseViewOverRide}"> --%>
						<%-- 					<jsp:attribute name="EDIT"> --%>
						<!-- 				<td align="left" width="12%">&nbsp;&nbsp; <input type="text" -->
						<!-- 							id="listCost" maxlength="11" tabindex="44" -->
						<!-- 							class="textFieldMedium" tabindex="36" -->
						<%-- 							value="${selectedVendorVO.listCostFormatted}" --%>
						<!-- 							onkeydown="return onKeyDownListCost(event, this);" -->
						<!-- 							onblur="validateListCost(this);calculateUnitCost();;return true;" /> -->
						<!-- 				</td> -->
						<%-- 				</jsp:attribute> --%>
						<%-- 					<jsp:attribute name="VIEW"> --%>
						<!-- 				<td align="left" width="12%">&nbsp;&nbsp; <input type="text" -->
						<!-- 							id="listCost" maxlength="11" tabindex="44" -->
						<!-- 							class="textFieldMedium" tabindex="36" -->
						<%-- 							value="${selectedVendorVO.listCostFormatted}" --%>
						<!-- 							onblur="calculateUnitCost();return true;calculateUnitCost();" -->
						<!-- 							disabled="disabled" /> -->
						<!-- 				</td> -->
						<%-- 				</jsp:attribute> --%>
						<%-- 				</cps:renderByResourceAccess> --%>

						<td align="right" width="12%">
							<c:if test="${CPSForm.viewMode eq false ||(CPSForm.mrtvo != null && CPSForm.mrtvo.caseVO != null && CPSForm.mrtvo.caseVO.channel !='DSD')}">
							<c:choose>
								<c:when test="${selectedVendorVO.vendorChannelVal == 'D'}">
									<c:set
										value="visibility: hidden;  position: relative; min-width: 0;"
										var="styleStrTie"></c:set>
								</c:when>
								<c:otherwise>
									<c:set
										value="visibility: visible; position: relative; min-width: 0;"
										var="styleStrTie"></c:set>
								</c:otherwise>
							</c:choose>
							<div id="venTie" style="${styleStrTie }">
								<label class="labelFont helpable" id="VendorTieLabel">Vendor
									Tie <em><font color="red"><b>*</b></font></em>
								</label>
							</div>
							</c:if>
							</td>
						<cps:renderByResourceAccess resourceId="102"
							honorViewMode="${CPSForm.caseViewOverRide}">
							<jsp:attribute name="EDIT">				
				<td align="left" width="12%">&nbsp;&nbsp;
				<c:if test="${CPSForm.viewMode eq false ||(CPSForm.mrtvo != null && CPSForm.mrtvo.caseVO != null && CPSForm.mrtvo.caseVO.channel !='DSD')}">
				<c:choose>
				<c:when test="${selectedVendorVO.vendorChannelVal == 'D'}">
				<c:set
												value="visibility: hidden;  position: relative; min-width: 0;"
												var="styleStrTieText"></c:set>
				</c:when>
				<c:otherwise>
				<c:set
												value="visibility: visible; position: relative; min-width: 0;"
												var="styleStrTieText"></c:set>
				</c:otherwise>
				</c:choose>
				<div id="venTieText" style="${styleStrTieText }"> <input
											type="text" id="vendorTie" maxlength="6" tabindex="45"
											class="textFieldMedium"
											value="${selectedVendorVO.vendorTieFormatted}"
											style="dataType: numeric;" />
					</div>
					</c:if>
				</td>
				</jsp:attribute>
							<jsp:attribute name="VIEW">
				<td align="left" width="12%">&nbsp;&nbsp;
				<c:if test="${CPSForm.viewMode eq false ||(CPSForm.mrtvo != null && CPSForm.mrtvo.caseVO != null && CPSForm.mrtvo.caseVO.channel !='DSD')}">
				<c:choose>
				<c:when test="${selectedVendorVO.vendorChannelVal == 'D'}">
				<c:set
												value="visibility: hidden;  position: relative; min-width: 0;"
												var="styleStrTieText"></c:set>
				</c:when>
				<c:otherwise>
				<c:set
												value="visibility: visible; position: relative; min-width: 0;"
												var="styleStrTieText"></c:set>
				</c:otherwise>
				</c:choose>
				<div id="venTieText" style="${styleStrTieText }"> <input
											type="text" id="vendorTie" maxlength="6" tabindex="45"
											class="textFieldMedium"
											value="${selectedVendorVO.vendorTieFormatted}"
											style="dataType: numeric;" disabled="disabled" />
					</div>
					</c:if>
				</td>
				</jsp:attribute>
						</cps:renderByResourceAccess>
						<td align="right" width="12%">
							<c:if test="${CPSForm.viewMode eq false ||(CPSForm.mrtvo != null && CPSForm.mrtvo.caseVO != null && CPSForm.mrtvo.caseVO.channel !='DSD')}">
							<c:choose>
								<c:when test="${selectedVendorVO.vendorChannelVal == 'D'}">
									<c:set
										value="visibility: hidden;  position: relative; min-width: 0;"
										var="styleStrTier"></c:set>
								</c:when>
								<c:otherwise>
									<c:set
										value="visibility: visible; position: relative; min-width: 0;"
										var="styleStrTier"></c:set>
								</c:otherwise>
							</c:choose>
							<div id="venTier" style="${styleStrTier }">
								<label class="labelFont helpable" id="VendorTierLabel">Vendor
									Tier<em><font color="red"><b>*</b></font></em>
								</label>
							</div>
							</c:if>
						</td>
						<cps:renderByResourceAccess resourceId="103"
							honorViewMode="${CPSForm.caseViewOverRide}">
							<jsp:attribute name="EDIT">				
				<td align="left" width="12%">&nbsp;&nbsp; 
				<c:if test="${CPSForm.viewMode eq false ||(CPSForm.mrtvo != null && CPSForm.mrtvo.caseVO != null && CPSForm.mrtvo.caseVO.channel !='DSD')}">
				<c:choose>
				<c:when test="${selectedVendorVO.vendorChannelVal == 'D'}">
				<c:set
												value="visibility: hidden;  position: relative; min-width: 0;"
												var="styleStrTierText"></c:set>
				</c:when>
				<c:otherwise>
				<c:set
												value="visibility: visible; position: relative; min-width: 0;"
												var="styleStrTierText"></c:set>
				</c:otherwise>
				</c:choose>
				<div id="venTierText" style="${styleStrTierText }">
										<input type="text" id="vendorTier" maxlength="6" tabindex="46"
											class="textFieldMedium"
											value="${selectedVendorVO.vendorTierFormatted}"
											style="dataType: numeric;" />
					</div>
				</c:if>
				</td>				
               </jsp:attribute>
							<jsp:attribute name="VIEW">
               <td align="left" width="12%">&nbsp;&nbsp; 
               <c:if test="${CPSForm.viewMode eq false ||(CPSForm.mrtvo != null && CPSForm.mrtvo.caseVO != null && CPSForm.mrtvo.caseVO.channel !='DSD')}">
				<c:choose>
				<c:when test="${selectedVendorVO.vendorChannelVal == 'D'}">
				<c:set
												value="visibility: hidden;  position: relative; min-width: 0;"
												var="styleStrTierText"></c:set>
				</c:when>
				<c:otherwise>
				<c:set
												value="visibility: visible; position: relative; min-width: 0;"
												var="styleStrTierText"></c:set>
				</c:otherwise>
				</c:choose>
				<div id="venTierText" style="${styleStrTierText }">
										<input type="text" id="vendorTier" maxlength="6" tabindex="46"
											class="textFieldMedium"
											value="${selectedVendorVO.vendorTierFormatted}"
											style="dataType: numeric;" disabled="disabled" />
					</div>
					</c:if>
				</td>	
                </jsp:attribute>
						</cps:renderByResourceAccess>

						<td align="right" width="12%"><label
							class="labelFont helpable" id="CountryOfOriginLabel">Country
								of Origin <em><font color="red"><b>*</b></font></em>
						</label></td>
						<cps:renderByResourceAccess resourceId="125"
							honorViewMode="${CPSForm.caseViewOverRide}">
							<jsp:attribute name="EDIT">
				<td align="left" width="12%">&nbsp;&nbsp; <select
									id="countryOfOrigin" tabindex="47" class="selectBoxStyle"
									style="dataType: alpha;">
					<c:forEach var="opt"
											items="${CPSForm.vendorVO.countryOfOriginList}">
						<c:if test="${opt.id eq selectedVendorVO.countryOfOriginVal}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedVendorVO.countryOfOriginVal}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
				</select></td>
				</jsp:attribute>
							<jsp:attribute name="VIEW">
           <td align="left" width="12%">&nbsp;&nbsp; <select
									id="countryOfOrigin" tabindex="47" class="selectBoxStyle"
									style="dataType: alpha;" disabled="disabled">
					<c:forEach var="opt"
											items="${CPSForm.vendorVO.countryOfOriginList}">
						<c:if test="${opt.id eq selectedVendorVO.countryOfOriginVal}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedVendorVO.countryOfOriginVal}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
				</select></td>
				</jsp:attribute>
						</cps:renderByResourceAccess>
					</tr>
					<tr align="left">
						<td align="right" width="12%"><label
							class="labelFont helpable" id="CostOwnerLabel">Cost Owner
								<em><font color="red"><b>*</b></font></em>
						</label></td>
						<cps:renderByResourceAccess resourceId="124"
							honorViewMode="${CPSForm.caseViewOverRide}">
							<jsp:attribute name="EDIT">
				<td align="left" width="12%">&nbsp;&nbsp; <select
									id="costOwner" tabindex="48" onchange="cstOwnerChange()">
					<option value="">--Select--</option>
					<c:forEach var="costOwn" items="${CPSForm.costOwners}">
						<c:if test="${costOwn.id eq selectedVendorVO.costOwnerVal}">
							<option value="${costOwn.id}" selected="selected">${costOwn.name}</option>
						</c:if>
						<c:if test="${costOwn.id ne selectedVendorVO.costOwnerVal}">
							<option value="${costOwn.id}">${costOwn.name}</option>
						</c:if>
					</c:forEach>
				</select></td>
				</jsp:attribute>
							<jsp:attribute name="VIEW">
				<td align="left" width="12%">&nbsp;&nbsp; <select
									id="costOwner" tabindex="48" onchange="cstOwnerChange()"
									disabled="disabled">
					<option value="">--Select--</option>
					<c:forEach var="costOwn" items="${CPSForm.costOwners}">
						<c:if test="${costOwn.id eq selectedVendorVO.costOwnerVal}">
							<option value="${costOwn.id}" selected="selected">${costOwn.name}</option>
						</c:if>
						<c:if test="${costOwn.id ne selectedVendorVO.costOwnerVal}">
							<option value="${costOwn.id}">${costOwn.name}</option>
						</c:if>
					</c:forEach>
				</select></td>
				</jsp:attribute>
						</cps:renderByResourceAccess>
						<td align="right" width="12%"><label
							class="labelFont helpable" id="Top2TopLabel">Top 2 Top <em><font
									color="red"><b>*</b></font></em></label></td>
						<cps:renderByResourceAccess resourceId="126"
							honorViewMode="${CPSForm.caseViewOverRide}">
							<jsp:attribute name="EDIT">	
				<td align="left" width="12%">&nbsp;&nbsp; <select id="top2Top"
									tabindex="49" class="selectBoxStyle3">
					<option value="">--Select--</option>
					<c:forEach var="opt" items="${CPSForm.topToTops}">
						<c:if test="${opt.id eq selectedVendorVO.top2TopVal}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedVendorVO.top2TopVal}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
				</select></td>
				</jsp:attribute>
							<jsp:attribute name="VIEW">
				<td align="left" width="12%">&nbsp;&nbsp; <select id="top2Top"
									tabindex="49" class="selectBoxStyle3" disabled="disabled">
					<option value="">--Select--</option>
					<c:forEach var="opt" items="${CPSForm.topToTops}">
						<c:if test="${opt.id eq selectedVendorVO.top2TopVal}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedVendorVO.top2TopVal}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
				</select></td>
				</jsp:attribute>
						</cps:renderByResourceAccess>
						<td align="right" width="12%"><label
							class="labelFont helpable" id="SeasonalityYrLabel">Seasonality
								Yr</label></td>
						<cps:renderByResourceAccess resourceId="123"
							honorViewMode="${CPSForm.caseViewOverRide}">
							<jsp:attribute name="EDIT">	
				<td align="left" width="12%">&nbsp;&nbsp; <input type="text"
									id="seasonalityYear" maxlength="4" tabindex="50"
									class="textFieldMedium"
									value="${selectedVendorVO.seasonalityYrFormatted}"
									onblur="dateCheck();" /></td>
				</jsp:attribute>
							<jsp:attribute name="VIEW">
               <td align="left" width="12%">&nbsp;&nbsp; <input
									type="text" id="seasonalityYear" maxlength="4" tabindex="50"
									class="textFieldMedium"
									value="${selectedVendorVO.seasonalityYrFormatted}"
									onblur="dateCheck();" disabled="disabled" /></td>
				</jsp:attribute>
						</cps:renderByResourceAccess>
						<td align="right" width="12%"><label
							class="labelFont helpable" id="SeasonalityLabel">Seasonality</label></td>
						<cps:renderByResourceAccess resourceId="127"
							honorViewMode="${CPSForm.caseViewOverRide}">
							<jsp:attribute name="EDIT">  
				<td align="left" width="12%">&nbsp;&nbsp; <select
									id="seasonality" tabindex="51" class="selectBoxStyle3"
									style="dataType: alpha;">
					<c:forEach var="opt" items="${selectedVendorVO.seasonalityList}">
						<c:if test="${opt.id eq selectedVendorVO.seasonalityVal}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedVendorVO.seasonalityVal}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
				</select></td>
				</jsp:attribute>
							<jsp:attribute name="VIEW">
					<td align="left" width="12%">&nbsp;&nbsp; <select
									id="seasonality" tabindex="51" class="selectBoxStyle3"
									style="dataType: alpha;" disabled="disabled">
					<c:forEach var="opt" items="${selectedVendorVO.seasonalityList}">
						<c:if test="${opt.id eq selectedVendorVO.seasonalityVal}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedVendorVO.seasonalityVal}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
				</select></td>
					</jsp:attribute>
						</cps:renderByResourceAccess>
					</tr>
					<!--  <table width="75%" border="0" align="left"> -->
					<c:choose>
						<c:when test="${selectedVendorVO.vendorChannelVal == 'D'}">
							<c:set
								value="visibility: hidden;  position: relative; min-width: 0;"
								var="styleStrCost"></c:set>
						</c:when>
						<c:otherwise>
							<c:set
								value="visibility: visible; position: relative; min-width: 0;"
								var="styleStrCost"></c:set>
						</c:otherwise>
					</c:choose>
					<tr align="left">
						<td colspan="4">
							<fieldset style="width: 90%; border-collapse: collapse;"
								id="costDetailsFieldSet">
								<legend>Cost Details</legend>
								<table width="100%">
									<tr>
										<td align="right" width="24%">
											<div id="costLinkLabel" style="${styleStrCost }">
												<label class="labelFont helpable" id="CostLinkRadioLabel">Cost
													Link By&nbsp;&nbsp; </label>
											</div>
										</td>
										<c:set value="" var="costChecked"></c:set>
										<c:if test="${selectedVendorVO.costLinkRadio eq 'true'}">
											<c:set value='selected="selected"' var="costChecked"></c:set>
										</c:if>
										<c:set value="" var="itemChecked"></c:set>
										<c:if test="${selectedVendorVO.itemCodeRadio eq 'true'}">
											<c:set value='selected="selected"' var="itemChecked"></c:set>
										</c:if>
										<td align="left" width="24%">&nbsp;&nbsp;
											<div id="costLink" style="${styleStrCost }">
												<cps:renderByResourceAccess resourceId="191"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT">
														<select id="costLinkBy" onchange="changeCostLinkBy(this)"
															class="selectBoxStyle3" tabindex="52">
															<option value="">--Select--</option>
															<option value="cl" ${costChecked}>Cost Link #</option>
															<option value="ic" ${itemChecked}>Item Code</option>
<%-- 															<option value="up" ${itemChecked}>UPC</option> --%>
														</select> 
													</jsp:attribute>
													<jsp:attribute name="VIEW">
								                        <select id="costLinkBy"
															onchange="changeCostLinkBy(this)" disabled="disabled"
															class="selectBoxStyle3" tabindex="52">
															<option value="">--Select--</option>
															<option value="cl" ${costChecked}>Cost Link #</option>
															<option value="ic" ${itemChecked}>Item Code</option>
<%-- 															<option value="up" ${itemChecked}>UPC</option> --%>
														</select> 
							                        </jsp:attribute>
												</cps:renderByResourceAccess>
											</div>
											</div>
										</td>
										<td colspan="2" width="48%">
											<div id="ItemRadioLabelDiv" style="display: none">
												<label class="labelFont helpable" id="ItemRadioLabel">Item
													Code </label>
											</div> <%-- 											<div id="costlistDiv" style="${styleStrCost}"> --%>
											<!-- 												<input type="text" id="costlist" maxlength="13" tabindex="210" class="textFieldNormal" value="" onblur="calculateListCost();" style="dataType:numeric;" disabled="disabled"> -->
											<!-- 											</div> -->
											<div id="costlistDiv" style="${styleStrCost}">
												<cps:renderByResourceAccess resourceId="191"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT">
															 <input type="text" id="costlist" maxlength="13"
															tabindex="54" class="textFieldNormal"
															value="${selectedVendorVO.costLinkFormatted}"
															onblur="calculateListCost();" style="dataType: numeric;"
															disabled="disabled" />											
														</jsp:attribute>
													<jsp:attribute name="VIEW">
															 <input type="text" id="costlist" maxlength="13"
															tabindex="54" class="textFieldNormal"
															value="${selectedVendorVO.costLinkFormatted}"
															onblur="calculateListCost();" style="dataType: numeric;"
															disabled="disabled" />												
														</jsp:attribute>
												</cps:renderByResourceAccess>
											</div>
										</td>
									</tr>
									<tr>
										<td align="right" width="24%"><label
											class="labelFont helpable" id="ListCostLabel">List
												Cost <em><font color="red"><b>*</b></font></em>
										</label></td>
										<td align="left" width="24%">&nbsp;&nbsp; <cps:renderByResourceAccess
												resourceId="120" honorViewMode="${CPSForm.caseViewOverRide}">
												<jsp:attribute name="EDIT">
													<input type="text" id="listCost" maxlength="11"
														tabindex="44" class="textFieldMedium" tabindex="36"
														value="${selectedVendorVO.listCostFormatted}"
														onkeydown="return onKeyDownListCost(event, this);"
														onblur="validateListCost(this);calculateUnitCostMRT();;return true;" />
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<input type="text" id="listCost" maxlength="11"
														tabindex="44" class="textFieldMedium" tabindex="36"
														value="${selectedVendorVO.listCostFormatted}"
														onblur="calculateUnitCostMRT();return true;"
														disabled="disabled" />
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</td>
										<td align="right" width="12%"><label
											class="labelFont helpable" id="UnitCost1Label">Unit
												Cost </label></td>

										<td align="left" width="10%">&nbsp;&nbsp; <label
											class="labelFont" id="unitCostLabel"> <c:if
													test="${mrtvo.caseVO.channelVal == 'BOTH'}">
												${selectedVendorVO.unitCostLabelFormattedBoth}
											</c:if> <c:if test="${mrtvo.caseVO.channelVal != 'BOTH'}">
												${selectedVendorVO.unitCostLabelFormatted}
											</c:if>
										</label>
										</td>
									</tr>
<!--============================== Hungbang added enhancement % Margin & Penny Profit======================================== -->
									<c:url var="iconRedStar"
										value="${request.getContextPath()}/hebAssets/images/red_star.png" />
									<c:choose>
										<c:when
											test="${fn:trim(selectedVendorVO.marginMessageWarning) ne ''}">
											<c:set var="flagEnable" value="display: block;"></c:set>
										</c:when>
										<c:otherwise>
											<c:set var="flagEnable" value="display: none;"></c:set>
										</c:otherwise>
									</c:choose>
									<input type="hidden" value="${selectedVendorVO.marginMessageWarning }" id="marginWarningIdAjax" />
									<tr>
										<td align="right" width="24%"><label
											class="labelFont helpable" id="LabelPercentMargin">%
												Margin </label></td>
										<td align="left" width="24%">&nbsp;&nbsp; <label
											id="percentMarginLabel" class="labelFont">
												${selectedVendorVO.percentMarginLabelFormatted} </label>
										</td>
										<td align="right" width="12%"><label
											class="labelFont helpable" id="LabelPennyProfit">Penny
												Profit </label></td>
										<td align="left" width="10%">&nbsp;&nbsp;<label
											id="pennyProfitLabel" class="labelFont">
												${selectedVendorVO.pennyProfitLabelFormatted} </label>
										</td>

										<td align="left" width="5%"><img id="profitWarning"
												src="${iconRedStar}" onclick="return warningProfit();"
												style="${flagEnable}" width="10" height="10" /></td>
									</tr>
								</table>
							</fieldset>
						</td>

						<%-- 					<td align="right" width="12%"><DIV id="costLinkLabel" style="${styleStrCost}"><label class="labelFont helpable" --%>
						<!-- 						id="CostLinkRadioLabel">Cost Link# </label></DIV></td> -->
						<%-- 				<c:set value="" var="costChecked"></c:set> --%>
						<%-- 				<c:if test="${selectedVendorVO.costLinkRadio eq 'true'}"> --%>
						<%-- 						<c:set value="checked" var="costChecked"></c:set> --%>
						<%-- 				</c:if> --%>
						<%-- 					<cps:renderByResourceAccess resourceId="191" --%>
						<%-- 						honorViewMode="${CPSForm.caseViewOverRide}"> --%>
						<%-- 						<jsp:attribute name="EDIT"> --%>
						<%-- 						<td align="left" width="6%">&nbsp;&nbsp;<DIV id="costLink" style="${styleStrCost}"> <input type="radio" --%>
						<!-- 								onmousedown="clickRadio(this)" onclick="return false;" onmouseup="return false;" name="vendorradio" tabindex="52" -->
						<%-- 								id="costRadio" maxlength="1" ${costChecked}/></DIV></td> --%>
						<%-- 						</jsp:attribute> --%>
						<%-- 						<jsp:attribute name="VIEW"> --%>
						<%-- 					<td align="left" width="6%">&nbsp;&nbsp;<DIV id="costLink" style="${styleStrCost}"><input type="radio" --%>
						<!-- 								onmousedown="clickRadio(this)" onclick="return false;" onmouseup="return false;" name="vendorradio" tabindex="52" -->
						<%-- 								id="costRadio" maxlength="1" disabled="disabled" ${costChecked}/></DIV></td> --%>
						<%-- 						</jsp:attribute> --%>
						<%-- 					</cps:renderByResourceAccess> --%>
						<%-- 					<td width="12%" align="right"><DIV id="ItemRadioLabelDiv" style="${styleStrCost}"><label class="labelFont helpable" --%>
						<!-- 						id="ItemRadioLabel">Item Code </label></DIV></td> -->
						<%-- 				<c:set value="" var="itemChecked"></c:set> --%>
						<%-- 				<c:if test="${selectedVendorVO.itemCodeRadio eq 'true'}"> --%>
						<%-- 						<c:set value='checked="checked"' var="itemChecked"></c:set> --%>
						<%-- 				</c:if> --%>
						<%-- 					<cps:renderByResourceAccess resourceId="80" --%>
						<%-- 						honorViewMode="${CPSForm.caseViewOverRide}"> --%>
						<%-- 						<jsp:attribute name="EDIT"> --%>
						<%-- 						<td width="6%" align="left"><DIV id="itemRadioDiv" style="${styleStrCost}">&nbsp;&nbsp; <input type="radio" --%>
						<!-- 								onmousedown="clickRadio(this)" onclick="return false;" onmouseup="return false;" name="vendorradio" tabindex="53" -->
						<%-- 								id="itemRadio" maxlength="1" ${itemChecked}/></DIV></td> --%>
						<%-- 					</jsp:attribute> --%>
						<%-- 						<jsp:attribute name="VIEW"> --%>
						<%-- 						<td width="6%" align="left"><DIV id="itemRadioDiv" style="${styleStrCost}">&nbsp;&nbsp; <input type="radio" --%>
						<!-- 								onmousedown="clickRadio(this)" onclick="return false;" onmouseup="return false;" name="vendorradio" tabindex="53" -->
						<%-- 								id="itemRadio" maxlength="1" disabled="disabled" ${itemChecked}/></DIV></td> --%>
						<%-- 					</jsp:attribute> --%>
						<%-- 					</cps:renderByResourceAccess> --%>
						<td colspan="4">
							<table width="100%">
								<tr>
									<!-- Order Unit changes -->
									<td align="right" width="12%">
										<div id="orderUnitLabelDiv" style="${styleStrTie}">
											<cps:renderByResourceAccess resourceId="258"
												honorViewMode="${CPSForm.caseViewOverRide}">
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
										<div id="orderUnitDiv" style="${styleStrTie }">
											&nbsp;&nbsp;
											<cps:renderByResourceAccess resourceId="258"
												honorViewMode="${CPSForm.caseViewOverRide}">
												<jsp:attribute name="EDIT">
									<select id="orderUnit" tabindex="55" class="selectBoxStyle3"
														onchange="onChangeOrderUnit(this)"
														style="dataType: alpha;">
									<c:forEach var="opt" items="${CPSForm.vendorVO.orderUnitList}">
										<c:if test="${opt.id eq selectedVendorVO.orderUnit}">
											<option value="${opt.id}" selected="selected">${opt.name}</option>
										</c:if>
										<c:if test="${opt.id ne selectedVendorVO.orderUnit}">
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
									<select id="orderUnit" tabindex="55" class="selectBoxStyle3"
														style="dataType: alpha;" disabled="disabled">
									<c:forEach var="opt" items="${CPSForm.vendorVO.orderUnitList}">
										<c:if test="${opt.id eq selectedVendorVO.orderUnit}">
											<option value="${opt.id}" selected="selected">${opt.name}</option>
										</c:if>
										<c:if test="${opt.id ne selectedVendorVO.orderUnit}">
											<option value="${opt.id}">${opt.name}</option>
										</c:if>
									</c:forEach>
									</select>
								</jsp:attribute>
												<jsp:attribute name="NONE">
									<select id="orderUnit" tabindex="55" class="selectBoxStyle3"
														style="dataType: alpha; visibility: hidden;"
														disabled="disabled">
									<c:forEach var="opt" items="${CPSForm.vendorVO.orderUnitList}">
										<c:if test="${opt.id eq selectedVendorVO.orderUnit}">
											<option value="${opt.id}" selected="selected">${opt.name}</option>
										</c:if>
										<c:if test="${opt.id ne selectedVendorVO.orderUnit}">
											<option value="${opt.id}">${opt.name}</option>
										</c:if>
									</c:forEach>
									</select>
								</jsp:attribute>
											</cps:renderByResourceAccess>
										</div>
									</td>
									<!-- Order Unit changes ends -->
								</tr>
								<tr align="left">
									<%-- 					<td align="right" width="10%"><DIV id="CostItemLabelDiv" style="${styleStrCost}"><label --%>
									<!-- 						class="labelFont helpable" id="CostItemLabel">Cost Link# -->
									<!-- 					/Item Code </label></DIV></td> -->

									<%-- 					<td align="left" width="10%"><DIV id="costlistDiv" style="${styleStrCost}">&nbsp;&nbsp; --%>
									<%-- 					<cps:renderByResourceAccess --%>
									<%-- 							resourceId="191" honorViewMode="${CPSForm.caseViewOverRide}"> --%>
									<%-- 							<jsp:attribute name="EDIT"> --%>
									<!-- 								 <input type="text" id="costlist" maxlength="6" tabindex="54" -->
									<!-- 								class="textFieldNormal" -->
									<%-- 								value="${selectedVendorVO.costLinkFormatted}" --%>
									<!-- 								onblur="calculateListCost();" style="dataType: numeric;" -->
									<!-- 								disabled="disabled" />											 -->
									<%-- 							</jsp:attribute> --%>
									<%-- 							<jsp:attribute name="VIEW"> --%>
									<!-- 								 <input type="text" id="costlist" maxlength="6" tabindex="54" -->
									<!-- 								class="textFieldNormal" -->
									<%-- 								value="${selectedVendorVO.costLinkFormatted}" --%>
									<!-- 								onblur="calculateListCost();" style="dataType: numeric;" -->
									<!-- 								disabled="disabled" />												 -->
									<%-- 							</jsp:attribute> --%>
									<%-- 					</cps:renderByResourceAccess></DIV> --%>
									<!-- 					</td> -->

									<!-- 					<td align="right" width="10%"><label -->
									<!-- 						class="labelFont helpable" id="UnitCost1Label">Unit Cost </label></td> -->

									<!-- 					<td align="left" width="10%">&nbsp;&nbsp; <label -->
									<!-- 						class="labelFont" id="unitCostLabel"> -->
									<%-- 						<c:if test="${mrtvo.caseVO.channelVal == 'BOTH'}"> --%>
									<%-- 							${selectedVendorVO.unitCostLabelFormattedBoth} --%>
									<%-- 						</c:if> --%>
									<%-- 						<c:if test="${mrtvo.caseVO.channelVal != 'BOTH'}"> --%>
									<%-- 							${selectedVendorVO.unitCostLabelFormatted} --%>
									<%-- 						</c:if>							 --%>
									<!-- 						</label> -->
									<!-- 					</td> -->

									<td align="right" width="15%">
										<table>
											<tr>
												<td width="14%"><label class="labelFont helpable"
													id="ExpWeekMovLabel">Expected Weekly Movement</label></td>
												<td width="1%"><c:choose>
														<c:when
															test="${selectedVendorVO.vendorLocationTypeCode == 'V'}">
															<c:set
																value="visibility: visible;  position: relative; min-width: 0;"
																var="styleExpMvt"></c:set>
														</c:when>
														<c:otherwise>
															<c:set
																value="visibility: hidden; position: relative; min-width: 0;"
																var="styleExpMvt"></c:set>
														</c:otherwise>
													</c:choose>
													<div class="labelFont" id="ewmMandatory"
														style="${styleExpMvt}">
														<em><font color="red"><b>*</b></font></em>
													</div></td>
											</tr>
										</table>
									</td>
									<td align="left" width="15%"><cps:renderByResourceAccess
											resourceId="208" honorViewMode="${CPSForm.caseViewOverRide}">
											<jsp:attribute name="EDIT">  
					<input type="text" tabindex="55" id="expectedweeklymovement"
													maxlength="5" style="dataType: numeric;"
													onblur="validateExpected();"
													value="${selectedVendorVO.expectedWeeklyMvtFormatted}" />
						</jsp:attribute>
											<jsp:attribute name="VIEW"> 
                        <input type="text" tabindex="55"
													id="expectedweeklymovement" maxlength="5"
													style="dataType: numeric;" onblur="validateExpected();"
													value="${selectedVendorVO.expectedWeeklyMvtFormatted}"
													disabled="disabled" />
                        </jsp:attribute>
										</cps:renderByResourceAccess></td>
									<c:choose>
										<c:when test="${selectedVendorVO.vendorChannelVal == 'D'}">
											<c:set
												value="visibility: hidden;  position: relative; min-width: 0;"
												var="styleStrOrdr"></c:set>
										</c:when>
										<c:otherwise>
											<c:set
												value="visibility: visible; position: relative; min-width: 0;"
												var="styleStrOrdr"></c:set>
										</c:otherwise>
									</c:choose>
									<td align="right" width="12%"><div id="orderResLabel"
											style="${styleStrOrdr}">
											<cps:renderByResourceAccess resourceId="244"
												honorViewMode="${CPSForm.caseViewOverRide}">
												<jsp:attribute name="EDIT">
					<label class="labelFont helpable" id="OrderRestrictionLabel">Order Restriction</label>
				</jsp:attribute>
												<jsp:attribute name="VIEW">
					<label class="labelFont helpable" id="OrderRestrictionLabel">Order Restriction</label>
				</jsp:attribute>
											</cps:renderByResourceAccess>
										</div></td>
									<td align="left" width="12%">&nbsp;&nbsp;
										<div id="orderRes" style="${styleStrOrdr }">
											<cps:renderByResourceAccess resourceId="244"
												honorViewMode="${CPSForm.caseViewOverRide}">
												<jsp:attribute name="EDIT">
					<select id="orderRestriction" tabindex="55" class="selectBoxStyle"
														style="dataType: alpha;">
					<c:forEach var="opt"
															items="${CPSForm.vendorVO.orderRestrictionList}">
						<c:if test="${opt.id eq selectedVendorVO.orderRestrictionVal}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedVendorVO.orderRestrictionVal}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
				</select>
				</jsp:attribute>
												<jsp:attribute name="VIEW">
					<select id="orderRestriction" tabindex="55" class="selectBoxStyle"
														style="dataType: alpha;" disabled="disabled">
					<c:forEach var="opt"
															items="${CPSForm.vendorVO.orderRestrictionList}">
						<c:if test="${opt.id eq selectedVendorVO.orderRestrictionVal}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedVendorVO.orderRestrictionVal}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
					</select>
				</jsp:attribute>
												<jsp:attribute name="NONE">
					<select id="orderRestriction" tabindex="55" class="selectBoxStyle"
														style="dataType: alpha; visibility: hidden;"
														disabled="disabled">
					<c:forEach var="opt"
															items="${CPSForm.vendorVO.orderRestrictionList}">
						<c:if test="${opt.id eq selectedVendorVO.orderRestrictionVal}">
							<option value="${opt.id}" selected="selected">${opt.name}</option>
						</c:if>
						<c:if test="${opt.id ne selectedVendorVO.orderRestrictionVal}">
							<option value="${opt.id}">${opt.name}</option>
						</c:if>
					</c:forEach>
					</select>
				</jsp:attribute>
											</cps:renderByResourceAccess>
										</div>
									</td>
								</tr>
								<!--  </table>-->
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table width="97%">
		<tr>
			<td><c:choose>
					<c:when
						test="${(selectedCaseVO.importEnabled eq true) && (selectedVendorVO.vendorLocTypeCode ne 'D')}">
						<c:set
							value="visibility: visible; position: relative; min-width: 0;"
							var="styleStr"></c:set>
					</c:when>
					<c:otherwise>
						<c:set
							value="visibility: hidden; position: relative; min-width: 0;"
							var="styleStr"></c:set>
					</c:otherwise>
				</c:choose>
				<div id="importOnly" style="${styleStr }">
					<table>
						<tr align="left">
							<td align="right" width="5%" colspan="3"><label
								class="labelFont helpable" id="ImportLabel">Import </label></td>
							<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="122" honorViewMode="${CPSForm.caseViewOverRide}">
									<jsp:attribute name="EDIT"> 
						<c:if test="${selectedVendorVO.importd eq 'true'}">
							<input type="checkbox" id="import" tabindex="56"
												onclick="importClickedAjax();" checked="checked" />
						</c:if> 
						<c:if test="${selectedVendorVO.importd eq 'false'}">
							<input type="checkbox" id="import" tabindex="56"
												onclick="importClickedAjax();" />
						</c:if>
						</jsp:attribute>
									<jsp:attribute name="VIEW">
								<c:if test="${selectedVendorVO.importd eq 'true'}">
								<input type="checkbox" id="import" tabindex="56"
												onclick="importClickedAjax();" checked="checked"
												disabled="disabled" />
							</c:if> 
							<c:if test="${selectedVendorVO.importd eq 'false'}">
								<input type="checkbox" id="import" tabindex="56"
												onclick="importClickedAjax();" disabled="disabled" />
							</c:if>															
						</jsp:attribute>
								</cps:renderByResourceAccess>
							</td>
						</tr>
					</table>
				</div></td>
		</tr>
	</table>

	<table width="97%">
		<tr>
			<td><c:choose>
					<c:when
						test="${(selectedVendorVO.importd eq 'true') && (selectedVendorVO.vendorLocTypeCode ne 'D')}">
						<c:set value="display: block;position: relative;min-width: 0;"
							var="styleStr" />
					</c:when>
					<c:otherwise>
						<c:set value="display: none;position: relative;min-width: 0;"
							var="styleStr" />
					</c:otherwise>
				</c:choose>

				<div id="importDivAjax" style="${styleStr}">
					<fieldset
						style="width: 100%; margin-left: 10px; border-collapse: collapse;"
						id="f2">
						<legend id="caseDetailsLegend">Import Attributes</legend>

						<table width="100%" border="0">
							<tr>
								<td width="100%" align="center">
									<table border="0" width="100%" align="center">
										<c:url var="calend"
											value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
										<c:url var="calend1"
											value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
										<c:url var="cal"
											value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
										<c:url var="calen"
											value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
										<tr align="left">
											<td align="right" width="12%"><label
												class="labelFont helpable" id="ContainerLabel">Container
													Size <em><font color="red"><b>*</b></font></em>
											</label></td>
											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="129"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT"> 
						<select id="cntnSize" tabindex="57">
							<c:forEach var="cntsize" items="${CPSForm.containerList}">
								<c:if
																	test="${cntsize.id eq selectedVendorVO.importVO.containerSize}">
									<option value="${cntsize.id}" selected="selected">${cntsize.name}</option>
								</c:if>
								<c:if
																	test="${cntsize.id ne selectedVendorVO.importVO.containerSize}">
									<option value="${cntsize.id}">${cntsize.name}</option>
								</c:if>
							</c:forEach>
						</select>
						</jsp:attribute>
													<jsp:attribute name="VIEW"> 
						<select id="cntnSize" tabindex="57" disabled="disabled">
							<c:forEach var="cntsize" items="${CPSForm.containerList}">
								<c:if
																	test="${cntsize.id eq selectedVendorVO.importVO.containerSize}">
									<option value="${cntsize.id}" selected="selected">${cntsize.name}</option>
								</c:if>
								<c:if
																	test="${cntsize.id ne selectedVendorVO.importVO.containerSize}">
									<option value="${cntsize.id}">${cntsize.name}</option>
								</c:if>
							</c:forEach>
						</select>
						</jsp:attribute>
												</cps:renderByResourceAccess>
											</td>

											<td align="right" width="12%"><label
												class="labelFont helpable" id="IncoTermsLabel">Inco
													Terms<em><font color="red"><b>*</b></font></em>
											</label></td>

											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="134"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT">
						 <select id="incoTerms" tabindex="58">
							<c:forEach var="inco" items="${CPSForm.incoList}">
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
							<c:forEach var="inco" items="${CPSForm.incoList}">
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

											<td align="right" width="12%"><label
												class="labelFont helpable" id="PickupPointLabel">Pickup
													Point <em><font color="red"><b>*</b></font></em>
											</label></td>
											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="130"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT"> 
						<input type="text" id="pcikPoint" maxlength="20" tabindex="59"
															class="textFieldNormal"
															value="${selectedVendorVO.importVO.pickupPoint}" />
						</jsp:attribute>
													<jsp:attribute name="VIEW"> 
						<input type="text" id="pcikPoint" maxlength="20" tabindex="59"
															class="textFieldNormal"
															value="${selectedVendorVO.importVO.pickupPoint}"
															style="dataType: alphanumericOnly;" disabled="disabled" />
						</jsp:attribute>
												</cps:renderByResourceAccess>
											</td>
										</tr>

										<tr align="left">
											<td align="right" width="12%"><label
												class="labelFont helpable" id="RatePerLabel">Duty %
													<em><font color="red"><b>*</b></font></em>
											</label></td>

											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="136"
													honorViewMode="${CPSForm.caseViewOverRide}">
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

											<td align="right" width="12%"><label
												class="labelFont helpable" id="DutyInfoLabel">Duty
													Info</label></td>

											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="133"
													honorViewMode="${CPSForm.caseViewOverRide}">
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

											<td align="right" width="12%"><label
												class="labelFont helpable" id="MinQtyLabel">Minimum
													Qty<em><font color="red"><b>*</b></font></em>
											</label></td>

											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="132"
													honorViewMode="${CPSForm.caseViewOverRide}">
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

											<td align="right" width="12%"><label
												class="labelFont helpable" id="MiniTypeLabel">Min.
													Order Description<em><font color="red"><b>*</b></font></em>
											</label></td>
											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="137"
													honorViewMode="${CPSForm.caseViewOverRide}">
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

											<td align="right" width="12%"><label
												class="labelFont helpable" id="HTSLabel">HTS1<em><font
														color="red"><b>*</b></font></em></label></td>

											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="195"
													honorViewMode="${CPSForm.caseViewOverRide}">
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

											<td align="right" width="12%"><cps:renderByResourceAccess
													resourceId="254"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="HTS2Label">HTS2</label>
								</jsp:attribute>
													<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="HTS2Label">HTS2</label>
								</jsp:attribute>
												</cps:renderByResourceAccess></td>
											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="254"
													honorViewMode="${CPSForm.caseViewOverRide}">
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

											<td align="right" width="12%"><cps:renderByResourceAccess
													resourceId="255"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT">
									<label class="labelFont helpable" id="HTS3Label">HTS3</label>
								</jsp:attribute>
													<jsp:attribute name="VIEW">
									<label class="labelFont helpable" id="HTS3Label">HTS3</label>
								</jsp:attribute>
												</cps:renderByResourceAccess></td>
											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="255"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT">
									<input type="text" value="${selectedVendorVO.importVO.hts3}"
															id="hts3" maxlength="10" tabindex="66"
															class="textFieldNormal"
															onblur="isNumericAndPadHts(this);"
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

											<td align="right" width="12%"><label
												class="labelFont helpable" id="ColorLabel">Product
													Color<em><font color="red"><b>*</b></font></em>
											</label></td>

											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="133"
													honorViewMode="${CPSForm.caseViewOverRide}">
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
											<td align="right" width="12%"><label
												class="labelFont helpable" id="AgentLabel">Agent %<em><font
														color="red"><b>*</b></font></em>
											</label></td>
											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="197"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT">
						<input type="text" id="agentPer" maxlength="6" tabindex="68"
															class="textFieldNormal"
															value="${selectedVendorVO.importVO.agentPerc}"
															style="dataType: float;"
															onblur="roundValue(this,2);return true;" />
						</jsp:attribute>
													<jsp:attribute name="VIEW">
						<input type="text" id="agentPer" maxlength="6" tabindex="68"
															class="textFieldNormal"
															value="${selectedVendorVO.importVO.agentPerc}"
															style="dataType: float;"
															onblur="roundValue(this,2);return true;"
															disabled="disabled" />
						</jsp:attribute>
												</cps:renderByResourceAccess>
											</td>

											<td align="right" width="12%"><label
												class="labelFont helpable" id="CartonMarkLabel">Carton
													Marketing<em><font color="red"><b>*</b></font></em>
											</label></td>
											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="199"
													honorViewMode="${CPSForm.caseViewOverRide}">
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

											<td align="right" width="12%"><label
												class="labelFont helpable" id="DutyLabel">Duty
													Confirmed<em><font color="red"><b>*</b></font></em>
											</label></td>

											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="196"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT">
						<input type="text" id="duty" maxlength="20" tabindex="70"
															value="${selectedVendorVO.importVO.duty}"
															style="width: 70%"
															onblur="validateDateUsingDWR(this,'Duty Confirmed');" />
							<img src="${calend}" id="dutyCalend" />
						</jsp:attribute>
													<jsp:attribute name="VIEW">
						<input type="text" id="duty" maxlength="20" tabindex="70"
															style="width: 70%"
															value="${selectedVendorVO.importVO.duty}"
															disabled="disabled" />
						</jsp:attribute>
												</cps:renderByResourceAccess>
											</td>

											<td align="right" width="12%"><label
												class="labelFont helpable" id="FreightLabel">Freight
													Confirmed <em><font color="red"><b>*</b></font></em>
											</label></td>

											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="131"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT">
						<input type="text" id="freight" maxlength="20" tabindex="71"
															style="width: 70%"
															value="${selectedVendorVO.importVO.freight}"
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
											<td align="right" width="12%"><label
												class="labelFont helpable" id="ProDateLabel">Proration
													Date </label></td>

											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="135"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT">
						<input type="text" id="prorDate" maxlength="10" tabindex="72"
															class="textFieldMedium"
															value="${selectedVendorVO.importVO.prorationDate}"
															onblur="validateDateUsingDWR(this,'Proration Date');" />
														<img src="${calend}" id="propDate" />
						</jsp:attribute>
													<jsp:attribute name="VIEW">
						<input type="text" id="prorDate" maxlength="10" tabindex="72"
															class="textFieldMedium"
															value="${selectedVendorVO.importVO.prorationDate}"
															disabled="disabled" />							
						</jsp:attribute>
												</cps:renderByResourceAccess>
											</td>

											<td align="right" width="12%"><label
												class="labelFont helpable" id="InstoreDateLabel">Instore
													Date</label></td>

											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="138"
													honorViewMode="${CPSForm.caseViewOverRide}">
													<jsp:attribute name="EDIT">
						 <input type="text" id="instoreDate" maxlength="10" tabindex="73"
															class="" value="${selectedVendorVO.importVO.instoreDate}"
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

											<td align="right" width="12%"><label
												class="labelFont helpable" id="WHSEDateLabel">Whse
													Flush Date</label></td>
											<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
													resourceId="198"
													honorViewMode="${CPSForm.caseViewOverRide}">
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
										<button id="importFacilities">Import Factory</button>
									</jsp:attribute>
													</cps:renderByResourceAccess>
												</div> <input type="hidden" id="factoryList"
												value="${selectedVendorVO.importVO.factoryList}">
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</fieldset>
				</div></td>
		</tr>
	</table>
	<br />

	<table width="97%">
		<tr>
			<td>
				<div id="buttonDiv"
					style="display: block; position: relative; min-width: 0;">
					<table>
						<tr align="left">
							<td align="right" width="12%"><label class="labelFont"></label></td>
							<td align="left" width="12%">&nbsp;&nbsp;</td>
							<td align="right" width="12%"><label class="labelFont"></label></td>
							<cps:renderByResourceAccess resourceId="192"
								honorViewMode="${CPSForm.caseViewOverRide}">
								<jsp:attribute name="EXEC">
			<td align="left" width="12%">&nbsp;&nbsp; <input type="text"
										value="Save Vendor" id="saveVendorButton" tabindex="75" /> <!-- <cps:button label="Save Vendor" uniqueId="saveVendorButton" width="90px" left="10px" height="25px"></cps:button>  -->
			</td>
			</jsp:attribute>
							</cps:renderByResourceAccess>
							<td align="right" width="12%"><c:if
									test="${selectedVendorVO.vendorLocTypeCode eq 'V'}">
									<div id="enableAuthorizeWHS" style="display: block;">
										<cps:renderByResourceAccess resourceId="194"
											honorViewMode="${CPSForm.caseViewOverRide}">
											<jsp:attribute name="EXEC">
				<button id="authWHS" tabindex="76">Authorize WHS</button>
				</jsp:attribute>
										</cps:renderByResourceAccess>
									</div>
								</c:if> <c:if test="${selectedVendorVO.vendorLocTypeCode ne 'V'}">
									<div id="enableAuthorizeWHS" style="display: none;">
										<cps:renderByResourceAccess resourceId="194"
											honorViewMode="${CPSForm.caseViewOverRide}">
											<jsp:attribute name="EXEC">
				<button id="authWHS" tabindex="76">Authorize WHS</button>
				</jsp:attribute>
										</cps:renderByResourceAccess>
									</div>
								</c:if> <c:if test="${selectedVendorVO.vendorLocTypeCode eq 'D'}">
									<div id="enableAuthorizeStore" style="display: block;">
										<cps:renderByResourceAccess resourceId="193"
											honorViewMode="${CPSForm.caseViewOverRide}">
											<jsp:attribute name="EXEC">
				<button id="authStore" tabindex="77">Authorize Store</button>
				</jsp:attribute>
										</cps:renderByResourceAccess>
									</div>
								</c:if> <c:if test="${selectedVendorVO.vendorLocTypeCode ne 'D'}">
									<div id="enableAuthorizeStore" style="display: none;">
										<cps:renderByResourceAccess resourceId="193"
											honorViewMode="${CPSForm.caseViewOverRide}">
											<jsp:attribute name="EXEC">
				<button id="authStore" tabindex="77">Authorize Store</button>
				</jsp:attribute>
										</cps:renderByResourceAccess>
									</div>
								</c:if></td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>

</fieldset>
<script type="text/javascript">
	YAHOO.util.Event.onDOMReady(function(){	
		YAHOO.util.Dom.get("hts").value = padHts(YAHOO.util.Dom.get("hts").value);
		YAHOO.util.Dom.get("hts2").value = padHts(YAHOO.util.Dom.get("hts2").value);
		YAHOO.util.Dom.get("hts3").value = padHts(YAHOO.util.Dom.get("hts3").value);
	});
	<c:choose>
	<c:when test="${selectedVendorVO.costLinkFormatted ne null && selectedVendorVO.costLinkFormatted ne '' && selectedVendorVO.costLinkFormatted ne '0'}">
		if(document.getElementById("listCost")){
			document.getElementById("listCost").disabled = true;
		}
	</c:when>
	<c:otherwise>
		<c:if test="${!CPSForm.caseViewOverRide && !CPSForm.viewMode}">
			if(document.getElementById("listCost")){
				document.getElementById("listCost").disabled = false;
			}
		</c:if>
	</c:otherwise>
	</c:choose>		
	
</script>

