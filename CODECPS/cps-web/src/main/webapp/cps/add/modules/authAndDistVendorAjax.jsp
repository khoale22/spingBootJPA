<pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fieldset
	style="width: 98%; margin-left: 10px; border-collapse: collapse;"
	id="vendorDetailsFieldSet"><legend>Vendor Details</legend>
<table width="98%" border="0">
	<tr>
		<td width="100%" align="center">
		<table width="100%" border="0">
			<!-- 958 changes -->
			<tr align="left">
				<c:choose>
					<c:when test="${selectedVendorVO.channelVal eq 'WHS'}">
						<c:set
							value="visibility: hidden;  position: relative; min-width: 0;"
							var="styleStrDept"></c:set>
					</c:when>
					<c:otherwise>
						<c:set
							value="visibility: visible; position: relative; min-width: 0;"
							var="styleStrDept"></c:set>
					</c:otherwise>
				</c:choose>
				<c:set value="" var="disableDept"></c:set>
				<c:if test="${selectedVendorVO.vendorChannelVal eq 'V'}">
					<c:set value='disabled="disabled"' var="disableDept"></c:set>
				</c:if>
				<td align="right" width="12%">&nbsp;
				<div id="subDeptLabelDiv" style="${styleStrDept}"><cps:renderByResourceAccess
					resourceId="257"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">
								<label class="labelFont helpable" id="SubDeptLabel">Sub-Dept </label>
							</jsp:attribute>
					<jsp:attribute name="VIEW">
								<label class="labelFont helpable" id="SubDeptLabel">Sub-Dept </label>
							</jsp:attribute>
				</cps:renderByResourceAccess></div>
				</td>

				<td align="left" width="12%">&nbsp;&nbsp;
				<div id="subDeptDiv" style="${styleStrDept}"><cps:renderByResourceAccess
					resourceId="257"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">
								<input type="text" id="subDept" maxlength="3" tabindex="146"
							value="${selectedVendorVO.subDept}" disabled="disabled"
							class="textFieldNormal" onblur="validateSubDept();"
							style="TEXT-TRANSFORM: uppercase; dataType: alphanumericOnly;" ${disableDept}/>															
						</jsp:attribute>
					<jsp:attribute name="VIEW">
								<input type="hidden"
							value="${selectedVendorVO.vendorViewOverride}" id="viewMode"> 
								  <input type="text" id="subDept" maxlength="3" tabindex="146"
							value="${selectedVendorVO.subDept}" class="textFieldNormal"
							style="dataType: alphanumericOnly;" disabled="disabled" />							
							</jsp:attribute>
				</cps:renderByResourceAccess></div>
				</td>
				<!-- 958 PSS changes -->
				<c:set value="" var="disablePSS"></c:set>
				<c:if
					test="${selectedVendorVO.vendorChannelVal eq 'V' || CPSForm.defaultSubDept == selectedVendorVO.subDept}">
					<c:set value='disabled="disabled"' var="disablePSS"></c:set>
				</c:if>
				<td align="right" width="12%">&nbsp; <cps:renderByResourceAccess
					resourceId="259"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">				
								<div id="vendPSSLabelDiv" style="${styleStrDept}"><label
							class="labelFont helpable" id="VendPSSLabel">PSS Dept </label></div>
							</jsp:attribute>
					<jsp:attribute name="VIEW">				
								<div id="vendPSSLabelDiv" style="${styleStrDept}"><label
							class="labelFont helpable" id="VendPSSLabel">PSS Dept </label></div>
							</jsp:attribute>
				</cps:renderByResourceAccess></td>
				<td align="left" width="12%">&nbsp;&nbsp;
				<div id="vendPSSDiv" style="${styleStrDept}"><cps:renderByResourceAccess
					resourceId="259"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">				
						
							<select id="vendPssDept" tabindex="147" class="selectBoxStyle2"${disablePSS }>
								<c:forEach var="opt" items="${selectedVendorVO.pssList}">
									<c:choose>
										<c:when test="${selectedVendorVO.pssDept eq null}">
											<c:if
											test="${opt.id eq CPSForm.productVO.pointOfSaleVO.pssDept}">
												<option value="${opt.id}" selected="selected">${opt.name}</option>
											</c:if>
											<c:if
											test="${opt.id ne CPSForm.productVO.pointOfSaleVO.pssDept}">
												<option value="${opt.id}">${opt.name}</option>
											</c:if>
										</c:when>
										<c:otherwise>
											<c:if test="${opt.id eq selectedVendorVO.pssDept}">
												<option value="${opt.id}" selected="selected">${opt.name}</option>
											</c:if>
											<c:if test="${opt.id ne selectedVendorVO.pssDept}">
												<option value="${opt.id}">${opt.name}</option>
											</c:if>
										</c:otherwise>							
									</c:choose>
								</c:forEach>
							</select>
							</jsp:attribute>
					<jsp:attribute name="VIEW">				
						
							<select id="vendPssDept" tabindex="147" class="selectBoxStyle2"${disablePSS }>
								<c:forEach var="opt" items="${selectedVendorVO.pssList}">
									<c:choose>
										<c:when test="${selectedVendorVO.pssDept eq null}">
											<c:if
											test="${opt.id eq CPSForm.productVO.pointOfSaleVO.pssDept}">
												<option value="${opt.id}" selected="selected">${opt.name}</option>
											</c:if>
											<c:if
											test="${opt.id ne CPSForm.productVO.pointOfSaleVO.pssDept}">
												<option value="${opt.id}">${opt.name}</option>
											</c:if>
										</c:when>
										<c:otherwise>
											<c:if test="${opt.id eq selectedVendorVO.pssDept}">
												<option value="${opt.id}" selected="selected">${opt.name}</option>
											</c:if>
											<c:if test="${opt.id ne selectedVendorVO.pssDept}">
												<option value="${opt.id}">${opt.name}</option>
											</c:if>
										</c:otherwise>							
									</c:choose>
								</c:forEach>
							</select>
							</jsp:attribute>
					<jsp:attribute name="NONE">				
						
							<select id="vendPssDept" tabindex="147" style="display: none;"
							class="selectBoxStyle2"${disablePSS }>
								<c:forEach var="opt" items="${selectedVendorVO.pssList}">
									<c:choose>
										<c:when test="${selectedVendorVO.pssDept eq null}">
											<c:if
											test="${opt.id eq CPSForm.productVO.pointOfSaleVO.pssDept}">
												<option value="${opt.id}" selected="selected">${opt.name}</option>
											</c:if>
											<c:if
											test="${opt.id ne CPSForm.productVO.pointOfSaleVO.pssDept}">
												<option value="${opt.id}">${opt.name}</option>
											</c:if>
										</c:when>
										<c:otherwise>
											<c:if test="${opt.id eq selectedVendorVO.pssDept}">
												<option value="${opt.id}" selected="selected">${opt.name}</option>
											</c:if>
											<c:if test="${opt.id ne selectedVendorVO.pssDept}">
												<option value="${opt.id}">${opt.name}</option>
											</c:if>
										</c:otherwise>							
									</c:choose>
								</c:forEach>
							</select>
							</jsp:attribute>
				</cps:renderByResourceAccess></div>
				</td>
			</tr>
			<!-- 958 changes ends -->
			<tr align="left">
				<td align="right" width="12%"><label class="labelFont helpable"
					id="VendorLabel">Vendor <em><font color="red"><b>*</b></font></em>
				</label></td>
				<td align="left" width="12%" colspan="3">&nbsp;&nbsp; <cps:renderByResourceAccess
					resourceId="116"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">
					<input type="hidden" value="${selectedVendorVO.uniqueId}"
							id="selectedVendorUniqId"> 
					<!--1205 Edit Case Edit Vendor-->
					<!--Create new div for auto complete-->
					<div id="vendorAutoComplete" style="display: none;">
					<cps:autoCompleteVendor searchAction="vendorSearch"
							uniqueId="vendor" compWidth="80%" tabIdx="150"
							elmProperty="selectedVendorVO.vendorLocationVal"
							elmName="selectedVendorVO.formattedVendorLocation"
							highlightMatch="true" maxResults="999" searchOnId="true"
							showId="true" zi="9000" maxCacheEntries="0"
							onSelectMethod2="checkBicepInLstBicep"
							onSelectMethod="getVendorChannelType" 
							onSelectMethod1="resetDataCostlistAndListCostChangeVendor"/>
					</div>
					<!--Create new div for view only-->
					<div id="vendorDisable">	
						<input type="hidden" value="${selectedVendorVO.vendorLocationVal}"
							id="vendorLocationVal">
						<input type="text" id="vendorLocationView"
							value="${selectedVendorVO.formattedVendorLocation}"
							disabled="disabled" style="width: 80%;" />	
					</div>
						<!-- <input type="text" id="vendorName" maxlength="8" tabindex="28" class="textFieldNormal"/> -->
			  		</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input type="hidden" value="${selectedVendorVO.uniqueId}"
							id="selectedVendorUniqId"> 
						<input type="hidden" value="${selectedVendorVO.vendorLocationVal}"
							id="vendorLocationVal">
						<input type="text" id="vendorLocation"
							value="${selectedVendorVO.formattedVendorLocation}"
							disabled="disabled" style="width: 80%;" />
						<!-- <input type="text" id="vendorName" maxlength="8" tabindex="28" class="textFieldNormal"/> -->
		            </jsp:attribute>
				</cps:renderByResourceAccess></td>

				<td align="right" width="12%"><label class="labelFont helpable"
					id="VPCLabel">VPC <em><font color="red"><b>*</b></font></em>
				</label></td>
				<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
					resourceId="78"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">
						<input type="text" id="vpc" maxlength="20" tabindex="155"
							value="${selectedVendorVO.vpc}" class="textFieldNormal"
							disabled="disabled"
							style="TEXT-TRANSFORM: uppercase; dataType: alphanumericSpecialOnly;" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input type="text" id="vpc" maxlength="20" tabindex="155"
							value="${selectedVendorVO.vpc}" class="textFieldNormal"
							style="dataType: alphanumericSpecialOnly;" disabled="disabled" />
					</jsp:attribute>
				</cps:renderByResourceAccess></td>
				<td colspan="2">
				<table>
					<tr>
						<td align="right"><label class="labelFont helpable"
							id="GuranteedSaleLabel">Guaranteed Sale?</label></td>
						<td>&nbsp;&nbsp; <cps:renderByResourceAccess resourceId="118"
							honorViewMode="${selectedVendorVO.vendorViewOverride}">
							<jsp:attribute name="EDIT">
								<c:if test="${selectedVendorVO.guarenteedSale eq true}">
									<input type="checkbox" id="gSales" tabindex="160" size="1"
										checked="checked" disabled="disabled">
								</c:if> 
								<c:if test="${selectedVendorVO.guarenteedSale eq false}">
									<input type="checkbox" id="gSales" tabindex="160" size="1"
										disabled="disabled">
								</c:if>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
				        		<c:if test="${selectedVendorVO.guarenteedSale eq true}">
									<input type="checkbox" id="gSales" tabindex="160" size="1"
										checked="checked" disabled="disabled">
								</c:if>
								<c:if test="${selectedVendorVO.guarenteedSale eq false}">
									<input type="checkbox" id="gSales" tabindex="160" size="1"
										disabled="disabled">
								</c:if>
							</jsp:attribute>
						</cps:renderByResourceAccess></td>
					</tr>
					<tr>
						<td align="right"><label class="labelFont helpable"
							id="DealOfferedLabel">Deal Offered?</label></td>
						<td>&nbsp;&nbsp; <cps:renderByResourceAccess resourceId="119"
							honorViewMode="${selectedVendorVO.vendorViewOverride}">
							<jsp:attribute name="EDIT">
								<c:if test="${selectedVendorVO.dealOffered eq true}">
									<input type="checkbox" id="dealOffered" tabindex="165" size="1"
										checked="checked" disabled="disabled">
								</c:if>
								<c:if test="${selectedVendorVO.dealOffered eq false}">
									<input type="checkbox" id="dealOffered" tabindex="165" size="1"
										disabled="disabled">
								</c:if>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
					        	<c:if test="${selectedVendorVO.dealOffered eq true}">
									<input type="checkbox" id="dealOffered" tabindex="165" size="1"
										checked="checked" disabled="disabled">
								</c:if>
								<c:if test="${selectedVendorVO.dealOffered eq false}">
									<input type="checkbox" id="dealOffered" tabindex="165" size="1"
										disabled="disabled">
								</c:if>
					        </jsp:attribute>
						</cps:renderByResourceAccess></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr align="left">
<!-- 				<td align="right" width="12%"><label class="labelFont helpable" -->
<!-- 					id="ListCostLabel">List Cost <em><font color="red"><b>*</b></font></em></label></td> -->
<%-- 				<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess --%>
<%-- 					resourceId="120" --%>
<%-- 					honorViewMode="${selectedVendorVO.vendorViewOverride}"> --%>
<%-- 					<jsp:attribute name="EDIT"> --%>
<!-- 							<input type="text" id="listCost" maxlength="12" -->
<!-- 							class="textFieldMedium" tabindex="170" -->
<%-- 							value="${selectedVendorVO.listCostFormatted}" --%>
<!-- 							style="dataType: float;" disabled="disabled" -->
<!-- 							onkeydown="return onKeyDownListCost(event, this);" -->
<!-- 							onblur="validateListCost(this);calculateUnitCost();return true;" /> -->
<%-- 						</jsp:attribute> --%>
<%-- 					<jsp:attribute name="VIEW"> --%>
<!-- 							<input type="text" id="listCost" maxlength="12" -->
<!-- 							class="textFieldMedium" tabindex="170" -->
<%-- 							value="${selectedVendorVO.listCostFormatted}" --%>
<!-- 							style="dataType: float;" -->
<!-- 							onblur="return true;calculateUnitCost();" disabled="disabled" /> -->
<%-- 						</jsp:attribute> --%>
<%-- 				</cps:renderByResourceAccess></td> --%>
				<td align="right" width="12%"><c:choose>
					<c:when test="${selectedVendorVO.vendorChannelVal eq 'D'}">
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
				<div id="venTie" style="${styleStrTie }"><label
					class="labelFont helpable" id="VendorTieLabel">Vendor Tie <em><font
					color="red"><b>*</b></font></em></label></div>
				</td>
				<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
					resourceId="102"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">
							<c:choose>
								<c:when test="${selectedVendorVO.vendorChannelVal eq 'D'}">
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
							<DIV id="venTieText" style="${styleStrTieText }">
								<input type="text" id="vendorTie" maxlength="6" tabindex="175"
							disabled="disabled" class="textFieldMedium"
							value="${selectedVendorVO.vendorTieFormatted}"
							style="dataType: numeric;"
							onblur="validateNumber(this,'Vendor Tie'); return true;" />
							</DIV>
						</jsp:attribute>
					<jsp:attribute name="VIEW">
							<c:choose>
								<c:when test="${selectedVendorVO.vendorChannelVal eq 'D'}">
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
							<DIV id="venTieText" style="${styleStrTieText }"> 
								<input type="text" id="vendorTie" maxlength="6" tabindex="175"
							class="textFieldMedium"
							value="${selectedVendorVO.vendorTieFormatted}"
							style="dataType: numeric;" disabled="disabled"
							onblur="validateNumber(this,'Vendor Tie'); return true;" />
							</DIV>
						</jsp:attribute>
				</cps:renderByResourceAccess></td>
				<td align="right" width="12%"><c:choose>
					<c:when test="${selectedVendorVO.vendorChannelVal eq 'D'}">
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
				<div id="venTier" style="${styleStrTier }"><label
					class="labelFont helpable" id="VendorTierLabel">Vendor Tier<em><font
					color="red"><b>*</b></font></em></label></div>
				</td>
				<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
					resourceId="103"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">				
				 
							<c:choose>
							<c:when test="${selectedVendorVO.vendorChannelVal eq 'D'}">
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
							<DIV id="venTierText" style="${styleStrTierText }"><input
							type="text" id="vendorTier" maxlength="6" tabindex="180"
							class="textFieldMedium"
							value="${selectedVendorVO.vendorTierFormatted}"
							style="dataType: numeric;" disabled="disabled"
							onblur="validateNumber(this,'Vendor Tier'); return true;" />
							</DIV>
    		            </jsp:attribute>
					<jsp:attribute name="VIEW">
                
							<c:choose>
							<c:when test="${selectedVendorVO.vendorChannelVal eq 'D'}">
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
							<DIV id="venTierText" style="${styleStrTierText }"><input
							type="text" id="vendorTier" maxlength="6" tabindex="180"
							class="textFieldMedium"
							value="${selectedVendorVO.vendorTierFormatted}"
							style="dataType: numeric;" disabled="disabled"
							onblur="validateNumber(this,'Vendor Tier'); return true;" />
							</DIV>
		                </jsp:attribute>
				</cps:renderByResourceAccess></td>
				<td align="right" width="12%"><label class="labelFont helpable"
					id="CountryOfOriginLabel">Country of Origin <em><font
					color="red"><b>*</b></font></em></label></td>
				<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
					resourceId="125"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">
							<select id="countryOfOrigin" tabindex="185"
							class="selectBoxStyle" style="dataType: alpha;"
							disabled="disabled">
							<c:forEach var="opt"
								items="${CPSForm.vendorVO.countryOfOriginList}">
								<c:if test="${opt.id eq selectedVendorVO.countryOfOriginVal}">
									<option value="${opt.id}" selected>${opt.name}</option>
								</c:if>
								<c:if test="${opt.id ne selectedVendorVO.countryOfOriginVal}">
									<option value="${opt.id}">${opt.name}</option>
								</c:if>
							</c:forEach>
						</select>
		            </jsp:attribute>
					<jsp:attribute name="VIEW">
          				<select id="countryOfOrigin" tabindex="185"
							class="selectBoxStyle" style="dataType: alpha;"
							disabled="disabled">
							<c:forEach var="opt"
								items="${CPSForm.vendorVO.countryOfOriginList}">
								<c:if test="${opt.id eq selectedVendorVO.countryOfOriginVal}">
									<option value="${opt.id}" selected>${opt.name}</option>
								</c:if>
								<c:if test="${opt.id ne selectedVendorVO.countryOfOriginVal}">
									<option value="${opt.id}">${opt.name}</option>
								</c:if>
							</c:forEach>
						</select>
		           </jsp:attribute>
				</cps:renderByResourceAccess></td>

			</tr>
			<tr align="left">
				<td align="right" width="12%">
					<%-- Fix QC 2329 - validate for non-sellable also --%>
					<label class="labelFont helpable" id="CostOwnerLabel">Cost
						Owner <em><font color="red"><b>*</b></font></em></label>
				</td>
				<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
					resourceId="124"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">
							<select id="costOwner" tabindex="190" onchange="cstOwnerChange()"
							disabled="disabled">
								<option value="">--Select--</option>
								<c:forEach var="costOwn" items="${CPSForm.costOwners}">
									<c:if test="${costOwn.id eq selectedVendorVO.costOwnerVal}">
										<option value="${costOwn.id}" selected>${costOwn.name}</option>
									</c:if>
									<c:if test="${costOwn.id ne selectedVendorVO.costOwnerVal}">
										<option value="${costOwn.id}">${costOwn.name}</option>
									</c:if>
								</c:forEach>
								</select> <!-- <input type="text" id="costOwner" maxlength="10" tabindex="185"  class="textFieldMedium"
								 value="${selectedVendorVO.costOwner}"/>	 -->
		                </jsp:attribute>
					<jsp:attribute name="VIEW">
			                <select id="costOwner" tabindex="190"
							onchange="cstOwnerChange()" disabled="disabled">
								<option value="">--Select--</option>
								<c:forEach var="costOwn" items="${CPSForm.costOwners}">
									<c:if test="${costOwn.id eq selectedVendorVO.costOwnerVal}">
										<option value="${costOwn.id}" selected>${costOwn.name}</option>
									</c:if>
									<c:if test="${costOwn.id ne selectedVendorVO.costOwnerVal}">
										<option value="${costOwn.id}">${costOwn.name}</option>
									</c:if>
								</c:forEach>
							</select> <!-- <input type="text" id="costOwner" maxlength="10" tabindex="185"  class="textFieldMedium"
									 value="${selectedVendorVO.costOwner}"/>	 -->
		                </jsp:attribute>
				</cps:renderByResourceAccess></td>
				<td align="right" width="12%">
					<%-- Fix QC 2329 - validate for non-sellable also --%>
					<label class="labelFont helpable" id="Top2TopLabel">Top 2
						Top <em><font color="red"><b>*</b></font></em></label>
				</td>
				<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
					resourceId="126"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">				
							<select id="top2Top" tabindex="195" class="selectBoxStyle3"
							disabled="disabled">
								<option value="">--Select--</option>
								<c:forEach var="opt" items="${CPSForm.topToTops}">
									<c:if test="${opt.id eq selectedVendorVO.top2TopVal}">
										<option value="${opt.id}" selected>${opt.name}</option>
									</c:if>
									<c:if test="${opt.id ne selectedVendorVO.top2TopVal}">
										<option value="${opt.id}">${opt.name}</option>
									</c:if>
								</c:forEach>
							</select>
						 </jsp:attribute>
					<jsp:attribute name="VIEW">
	                 		<select id="top2Top" tabindex="195"
							class="selectBoxStyle3" disabled="disabled">
								<option value="">--Select--</option>
								<c:forEach var="opt" items="${CPSForm.topToTops}">
									<c:if test="${opt.id eq selectedVendorVO.top2TopVal}">
										<option value="${opt.id}" selected>${opt.name}</option>
									</c:if>
									<c:if test="${opt.id ne selectedVendorVO.top2TopVal}">
										<option value="${opt.id}">${opt.name}</option>
									</c:if>
								</c:forEach>
							</select>
		               </jsp:attribute>
				</cps:renderByResourceAccess></td>
				<td align="right" width="12%"><label class="labelFont helpable"
					id="SeasonalityYrLabel">Seasonality Yr</label></td>
				<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
					resourceId="123"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">				
							<input type="text" id="seasonalityYear" maxlength="4"
							tabindex="200" style="dataType: numeric;" class="textFieldMedium"
							value="${selectedVendorVO.seasonalityYrFormatted}"
							onblur="dateCheck();" onchange="seasonalityYearChange();"
							disabled="disabled" />
						</jsp:attribute>
					<jsp:attribute name="VIEW">
               				<input type="text" id="seasonalityYear" maxlength="4"
							tabindex="200" style="dataType: numeric;" class="textFieldMedium"
							value="${selectedVendorVO.seasonalityYrFormatted}"
							onblur="dateCheck();" onchange="seasonalityYearChange();"
							disabled="disabled" />
		               </jsp:attribute>
				</cps:renderByResourceAccess></td>
				<td align="right" width="12%"><label class="labelFont helpable"
					id="SeasonalityLabel">Seasonality</label></td>
				<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
					resourceId="127"
					honorViewMode="${selectedVendorVO.vendorViewOverride}">
					<jsp:attribute name="EDIT">               
							<select id="seasonality" tabindex="205" class="selectBoxStyle3"
							style="dataType: alpha;" onchange="seasonalityChange();"
							disabled="disabled">
								<c:forEach var="opt" items="${selectedVendorVO.seasonalityList}">
									<c:if test="${opt.id eq selectedVendorVO.seasonalityVal}">
										<option value="${opt.id}" selected>${opt.name}</option>
									</c:if>
									<c:if test="${opt.id ne selectedVendorVO.seasonalityVal}">
										<option value="${opt.id}">${opt.name}</option>
									</c:if>
								</c:forEach>
							</select>
						</jsp:attribute>
					<jsp:attribute name="VIEW">
          						<select id="seasonality" tabindex="205"
							class="selectBoxStyle3" style="dataType: alpha;"
							onchange="seasonalityChange();" disabled="disabled">
								<c:forEach var="opt" items="${selectedVendorVO.seasonalityList}">
									<c:if test="${opt.id eq selectedVendorVO.seasonalityVal}">
										<option value="${opt.id}" selected>${opt.name}</option>
									</c:if>
									<c:if test="${opt.id ne selectedVendorVO.seasonalityVal}">
										<option value="${opt.id}">${opt.name}</option>
									</c:if>
								</c:forEach>
							</select>
			           </jsp:attribute>
				</cps:renderByResourceAccess></td>
			</tr>
			<tr align="left">
				<td colspan="4">
						<fieldset style="width: 90%; border-collapse: collapse;" id="costDetailsFieldSet"><legend>Cost Details</legend>
							<table width="100%">
									<tr>
										<c:choose>
											<c:when test="${selectedVendorVO.channelVal == 'DSD'}">
												<c:set value="display: none;" var="styleStrCost"></c:set>
											</c:when>
											<c:otherwise>
												<c:set value="display: block;" var="styleStrCost"></c:set>
											</c:otherwise>
										</c:choose>
										<td align="right" width="24%">
											<div id="costLinkLabel" style="${styleStrCost }"><label
												class="labelFont helpable" id="CostLinkRadioLabel">Cost Link By&nbsp;&nbsp; </label>
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
										<td align="left" width="24%">
											<div id="costLink" style="${styleStrCost }">
												<cps:renderByResourceAccess 
													resourceId="191"
													honorViewMode="${selectedVendorVO.vendorViewOverride}">
													<jsp:attribute name="EDIT">
														<select	id="costLinkBy" onchange="changeCostLinkBy(this)" disabled="disabled" class="selectBoxStyle3">
															<option value="">--Select--</option>
															<option value="cl" ${costChecked}>Cost Link #</option>
															<option value="ic" ${itemChecked}>Item Code</option>
<%-- 															<option value="up" ${itemChecked}>UPC</option> --%>
														</select> 
													</jsp:attribute>
													<jsp:attribute name="VIEW">
								                        <select	id="costLinkBy" onchange="changeCostLinkBy(this)" disabled="disabled" class="selectBoxStyle3">
															<option value="">--Select--</option>
															<option value="cl" ${costChecked}>Cost Link #</option>
															<option value="ic" ${itemChecked}>Item Code</option>
<%-- 															<option value="up" ${itemChecked}>UPC2</option> --%>
														</select> 
							                        </jsp:attribute>
												</cps:renderByResourceAccess>
												</div>
										</td>
										<td colspan="2" width="48%">
											<div id="ItemRadioLabelDiv" style="display: none"><label class="labelFont helpable" id="ItemRadioLabel">Item Code </label></div>
											<div id="costlistDiv" style="${styleStrCost}">
												<input type="text" id="costlist" maxlength="13" tabindex="210" class="textFieldNormal" value="${selectedVendorVO.costLinkFormatted}" onblur="calculateListCost();" style="dataType:numeric;" disabled="disabled">
											</div>
										</td>
<%-- 										<c:set value="" var="costChecked"></c:set> --%>
<%-- 										<c:if test="${selectedVendorVO.costLinkRadio eq 'true'}"> --%>
<%-- 											<c:set value='checked="checked"' var="costChecked"></c:set> --%>
<%-- 										</c:if> --%>
<!-- 										<td align="left" width="6%"> -->
<%-- 										<div id="costLink" style="${styleStrCost }"><cps:renderByResourceAccess --%>
<%-- 											resourceId="191" --%>
<%-- 											honorViewMode="${selectedVendorVO.vendorViewOverride}"> --%>
<%-- 											<jsp:attribute name="EDIT"> --%>
<!-- 													<input type="radio" onmousedown="clickRadio(this)" -->
<!-- 													onclick="return false;" onmouseup="return false;" -->
<!-- 													name="vendorradio" tabindex="206" id="costRadio" maxlength="1" -->
<%-- 													disabled="disabled" ${costChecked}/> --%>
												
<%-- 						                        </jsp:attribute> --%>
<%-- 											<jsp:attribute name="VIEW"> --%>
<!-- 						                        <input type="radio" -->
<!-- 													onmousedown="clickRadio(this)" onclick="return false;" -->
<!-- 													onmouseup="return false;" name="vendorradio" tabindex="206" -->
<%-- 													id="costRadio" maxlength="1" disabled="disabled" ${costChecked}/> --%>
<%-- 						                        </jsp:attribute> --%>
<%-- 										</cps:renderByResourceAccess></div> --%>
<!-- 										</td> -->
<!-- 										<td width="5%" align="right"> -->
<%-- 										<div id="ItemRadioLabelDiv" style="${styleStrCost}"><label --%>
<!-- 											class="labelFont helpable" id="ItemRadioLabel">Item Code </label></div> -->
<!-- 										</td> -->
<%-- 										<c:set value="" var="itemChecked"></c:set> --%>
<%-- 										<c:if test="${selectedVendorVO.itemCodeRadio eq 'true'}"> --%>
<%-- 											<c:set value='checked="checked"' var="itemChecked"></c:set> --%>
<%-- 										</c:if> --%>
<!-- 										<td width="6%" align="left"> -->
<%-- 										<div id="itemRadioDiv" style="${styleStrCost}">&nbsp;&nbsp; <cps:renderByResourceAccess --%>
<%-- 											resourceId="80" --%>
<%-- 											honorViewMode="${selectedVendorVO.vendorViewOverride}"> --%>
<%-- 											<jsp:attribute name="EDIT"> --%>
<!-- 													<input type="radio" onmousedown="clickRadio(this)" -->
<!-- 													onclick="return false;" onmouseup="return false;" -->
<!-- 													name="vendorradio" tabindex="207" id="itemRadio" maxlength="1" -->
<%-- 													disabled="disabled" ${itemChecked}/> --%>
<%-- 											</jsp:attribute> --%>
<%-- 											<jsp:attribute name="VIEW"> --%>
<!-- 						                       		<input type="radio" -->
<!-- 													onmousedown="clickRadio(this)" onclick="return false;" -->
<!-- 													onmouseup="return false;" name="vendorradio" tabindex="207" -->
<%-- 													id="itemRadio" maxlength="1" disabled="disabled" ${itemChecked}/> --%>
<%-- 						                        </jsp:attribute> --%>
<%-- 										</cps:renderByResourceAccess></div> --%>
<!-- 										</td> -->
									<tr>
										<td align="right" width="24%"><label class="labelFont helpable"
											id="ListCostLabel">List Cost <em><font color="red"><b>*</b></font></em></label></td>
										<td align="left" width="24%"><cps:renderByResourceAccess
											resourceId="120"
											honorViewMode="${selectedVendorVO.vendorViewOverride}">
											<jsp:attribute name="EDIT">
													<input type="text" id="listCost" maxlength="12"
													class="textFieldMedium" tabindex="170"
													value="${selectedVendorVO.listCostFormatted}"
													style="dataType: float;" disabled="disabled"
													onkeydown="return onKeyDownListCost(event, this);"
													onblur="validateListCost(this);calculateUnitCost();" />
												</jsp:attribute>
											<jsp:attribute name="VIEW">
													<input type="text" id="listCost" maxlength="12"
													class="textFieldMedium" tabindex="170"
													value="${selectedVendorVO.listCostFormatted}"
													style="dataType: float;"
													onblur="calculateUnitCost();" disabled="disabled" />
												</jsp:attribute>
										</cps:renderByResourceAccess></td>
										
										<td align="right" width="12%" ><label class="labelFont helpable" id="UnitCost1Label">Unit Cost </label></td>
										<td align="left" width="10%">&nbsp;&nbsp; <label
											class="labelFont" id="unitCostLabel">
<%-- 												<c:choose> --%>
<%-- 													<c:when	test='${selectedCaseVO.channelVal eq "BOTH"}'> --%>
<%-- 														${selectedVendorVO.unitCostLabelFormattedBoth} --%>
<%-- 													</c:when> --%>
<%-- 													<c:otherwise> --%>
<%-- 														${selectedVendorVO.unitCostLabelFormatted}								 --%>
<%-- 													</c:otherwise> --%>
<%-- 												</c:choose> --%>
												${selectedVendorVO.unitCostLabelFormatted}
											</label>
										</td>
									</tr>
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
												<label class="labelFont" id="grossProfit">
													${selectedVendorVO.grossProfit}
												</label>												
										</td>
										<td align="left" width="5%"><img id="profitWarning"
												src="${iconRedStar}" onclick="return warningProfit();"
												style="${flagEnable}" width="10" height="10" /></td>
									</tr>	
								</table>
						</fieldset>		
				</td>
				<td colspan="4">
							<table width="100%">
								<tr>
									<!-- Order Unit Changes -->
									<td align="right" width="5%">
									<div id="orderUnitLabelDiv" style="${styleStrTier}"><cps:renderByResourceAccess
										resourceId="258"
										honorViewMode="${selectedVendorVO.vendorViewOverride}">
										<jsp:attribute name="EDIT">
												<label class="labelFont helpable" id="OrderUnitLabel">Order Unit </label>
											</jsp:attribute>
										<jsp:attribute name="VIEW">
												<label class="labelFont helpable" id="OrderUnitLabel">Order Unit </label>
											</jsp:attribute>
									</cps:renderByResourceAccess></div>
									</td>
									<td align="left" width="12%">&nbsp;&nbsp;
									<div id="orderUnitDiv" style="${styleStrTier}">&nbsp;&nbsp; <cps:renderByResourceAccess
										resourceId="258"
										honorViewMode="${selectedVendorVO.vendorViewOverride}">
										<jsp:attribute name="EDIT">
													<select id="orderUnit" tabindex="208" class="selectBoxStyle3" onchange="onChangeOrderUnit(this)"
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
										<jsp:attribute name="VIEW">
													<select id="orderUnit" tabindex="208" class="selectBoxStyle3"
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
													<select id="orderUnit" tabindex="208" class="selectBoxStyle3"
												style="dataType: alpha; visibility: hidden;" disabled="disabled">
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
									</cps:renderByResourceAccess></div>
									</td>
									<!-- Order Unit changes ends -->
								</tr>
								<tr>
									<td align="right" width="12%">
										<table>
											<tr>
												<td width="11%"><label class="labelFont helpable"
													id="ExpWeekMovLabel">Expected Weekly Movement</label></td>
												<td width="1%">
												<DIV class="labelFont" id="ewmMandatory"><c:choose>
													<c:when
														test="${CPSForm.productVO.classificationVO.productType eq 'GOODS'}">
														<em><font color="red"><b>*</b></font></em>
													</c:when>
												</c:choose></DIV>
												</td>
											</tr>
										</table>
										</td>
										<td align="left" width="15%"><cps:renderByResourceAccess
											resourceId="208"
											honorViewMode="${selectedVendorVO.vendorViewOverride}">
											<jsp:attribute name="EDIT">  
													<input type="text" tabindex="212" id="expectedweeklymovement"
													maxlength="5" style="dataType: numeric;"
													onblur="validateNumber(this,'Expected Weekly Movement');validateExpected();"
													disabled="disabled"
													value="${selectedVendorVO.expectedWeeklyMvtFormatted}" />
												</jsp:attribute>
											<jsp:attribute name="VIEW"> 
							                        <input type="text" tabindex="212"
													id="expectedweeklymovement" maxlength="5"
													style="dataType: numeric;" onblur="validateExpected();"
													value="${selectedVendorVO.expectedWeeklyMvtFormatted}"
													disabled="disabled" />
							                    </jsp:attribute>
										</cps:renderByResourceAccess></td>
										<td align="right" width="15%"><c:choose>
											<c:when test="${selectedVendorVO.channelVal == 'DSD'}">
												<c:set value="display: none;" var="styleStrOrdr"></c:set>
											</c:when>
											<c:otherwise>
												<c:set value="display: block;" var="styleStrOrdr"></c:set>
											</c:otherwise>
										</c:choose>
										<div id="orderResLabel" style="${styleStrOrdr}"><cps:renderByResourceAccess
											resourceId="244"
											honorViewMode="${selectedVendorVO.vendorViewOverride}">
											<jsp:attribute name="EDIT">
													<label class="labelFont helpable" id="OrderRestrictionLabel">Order Restriction</label>
												</jsp:attribute>
											<jsp:attribute name="VIEW">
													<label class="labelFont helpable" id="OrderRestrictionLabel">Order Restriction</label>
												</jsp:attribute>
										</cps:renderByResourceAccess></div>
										</td>
										<td align="left" width="15%">&nbsp;&nbsp;
										<div id="orderRes" style="${styleStrOrdr}"><cps:renderByResourceAccess
											resourceId="244"
											honorViewMode="${selectedVendorVO.vendorViewOverride}">
											<jsp:attribute name="EDIT">
														<select id="orderRestriction" tabindex="213"
													class="selectBoxStyle" style="dataType: alpha;"
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
											<jsp:attribute name="VIEW">
														<select id="orderRestriction" tabindex="213"
													class="selectBoxStyle" style="dataType: alpha;"
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
											<jsp:attribute name="NONE">
														<select id="orderRestriction" tabindex="213"
													class="selectBoxStyle"
													style="dataType: alpha; visibility: hidden;" disabled="disabled">
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
										</cps:renderByResourceAccess></div>
										</td>
								</tr>
							</table>
					</td>
			</tr>
<!-- 			<tr align="left"> -->
<!-- 				<td align="right" width="12%"> -->
<%-- 				<div id="CostItemLabelDiv" style="${styleStrCost}"><label --%>
<!-- 					class="labelFont helpable" id="CostItemLabel">Cost Link# -->
<!-- 				/Item Code </label></div> -->
<!-- 				</td> -->
<!-- 				<td align="left" width="12%"> -->
<%-- 				<div id="costlistDiv" style="${styleStrCost}">&nbsp;&nbsp; <input --%>
<!-- 					type="text" id="costlist" maxlength="13" tabindex="210" -->
<!-- 					class="textFieldNormal" -->
<%-- 					value="${selectedVendorVO.costLinkFormatted}" --%>
<!-- 					onblur="calculateListCost();" style="dataType: numeric;" -->
<!-- 					disabled="disabled"></div> -->
<!-- 				</td> -->
<!-- 				<td align="right" width="12%"><label -->
<!-- 					class="labelFont helpable" id="UnitCost1Label">Unit Cost </label></td> -->
<!-- 				<td align="left" width="10%">&nbsp;&nbsp; <label -->
<!-- 					class="labelFont" id="unitCostLabel"> -->
<%-- 						<c:choose> --%>
<%-- 							<c:when	test='${selectedCaseVO.channelVal eq "BOTH"}'> --%>
<%-- 								${selectedVendorVO.unitCostLabelFormattedBoth} --%>
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<%-- 								${selectedVendorVO.unitCostLabelFormatted}								 --%>
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
<!-- 					</label> -->
<!-- 					</td> -->

<!-- 				<td align="right" width="12%"> -->
<!-- 				<table> -->
<!-- 					<tr> -->
<!-- 						<td width="11%"><label class="labelFont helpable" -->
<!-- 							id="ExpWeekMovLabel">Expected Weekly Movement</label></td> -->
<!-- 						<td width="1%"> -->
<%-- 						<DIV class="labelFont" id="ewmMandatory"><c:choose> --%>
<%-- 							<c:when --%>
<%-- 								test="${CPSForm.productVO.classificationVO.productType eq 'GOODS'}"> --%>
<!-- 								<em><font color="red"><b>*</b></font></em> -->
<%-- 							</c:when> --%>
<%-- 						</c:choose></DIV> --%>
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 				</table> -->
<!-- 				</td> -->
<%-- 				<td align="left" width="15%"><cps:renderByResourceAccess --%>
<%-- 					resourceId="208" --%>
<%-- 					honorViewMode="${selectedVendorVO.vendorViewOverride}"> --%>
<%-- 					<jsp:attribute name="EDIT">   --%>
<!-- 							<input type="text" tabindex="212" id="expectedweeklymovement" -->
<!-- 							maxlength="5" style="dataType: numeric;" -->
<!-- 							onblur="validateNumber(this,'Expected Weekly Movement');validateExpected();" -->
<!-- 							disabled="disabled" -->
<%-- 							value="${selectedVendorVO.expectedWeeklyMvtFormatted}" /> --%>
<%-- 						</jsp:attribute> --%>
<%-- 					<jsp:attribute name="VIEW">  --%>
<!-- 	                        <input type="text" tabindex="212" -->
<!-- 							id="expectedweeklymovement" maxlength="5" -->
<!-- 							style="dataType: numeric;" onblur="validateExpected();" -->
<%-- 							value="${selectedVendorVO.expectedWeeklyMvtFormatted}" --%>
<!-- 							disabled="disabled" /> -->
<%-- 	                    </jsp:attribute> --%>
<%-- 				</cps:renderByResourceAccess></td> --%>
<%-- 				<td align="right" width="15%"><c:choose> --%>
<%-- 					<c:when test="${selectedVendorVO.channelVal == 'DSD'}"> --%>
<%-- 						<c:set value="display: none;" var="styleStrOrdr"></c:set> --%>
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<%-- 						<c:set value="display: block;" var="styleStrOrdr"></c:set> --%>
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
<%-- 				<div id="orderResLabel" style="${styleStrOrdr}"><cps:renderByResourceAccess --%>
<%-- 					resourceId="244" --%>
<%-- 					honorViewMode="${selectedVendorVO.vendorViewOverride}"> --%>
<%-- 					<jsp:attribute name="EDIT"> --%>
<!-- 							<label class="labelFont helpable" id="OrderRestrictionLabel">Order Restriction</label> -->
<%-- 						</jsp:attribute> --%>
<%-- 					<jsp:attribute name="VIEW"> --%>
<!-- 							<label class="labelFont helpable" id="OrderRestrictionLabel">Order Restriction</label> -->
<%-- 						</jsp:attribute> --%>
<%-- 				</cps:renderByResourceAccess></div> --%>
<!-- 				</td> -->
<!-- 				<td align="left" width="15%">&nbsp;&nbsp; -->
<%-- 				<div id="orderRes" style="${styleStrOrdr}"><cps:renderByResourceAccess --%>
<%-- 					resourceId="244" --%>
<%-- 					honorViewMode="${selectedVendorVO.vendorViewOverride}"> --%>
<%-- 					<jsp:attribute name="EDIT"> --%>
<!-- 								<select id="orderRestriction" tabindex="213" -->
<!-- 							class="selectBoxStyle" style="dataType: alpha;" -->
<!-- 							disabled="disabled"> -->
<%-- 									<c:forEach var="opt" --%>
<%-- 								items="${CPSForm.vendorVO.orderRestrictionList}"> --%>
<%-- 										<c:if test="${opt.id eq selectedVendorVO.orderRestrictionVal}"> --%>
<%-- 											<option value="${opt.id}" selected="selected">${opt.name}</option> --%>
<%-- 										</c:if> --%>
<%-- 										<c:if test="${opt.id ne selectedVendorVO.orderRestrictionVal}"> --%>
<%-- 											<option value="${opt.id}">${opt.name}</option> --%>
<%-- 										</c:if> --%>
<%-- 									</c:forEach> --%>
<!-- 								</select> -->
<%-- 							</jsp:attribute> --%>
<%-- 					<jsp:attribute name="VIEW"> --%>
<!-- 								<select id="orderRestriction" tabindex="213" -->
<!-- 							class="selectBoxStyle" style="dataType: alpha;" -->
<!-- 							disabled="disabled"> -->
<%-- 									<c:forEach var="opt" --%>
<%-- 								items="${CPSForm.vendorVO.orderRestrictionList}"> --%>
<%-- 										<c:if test="${opt.id eq selectedVendorVO.orderRestrictionVal}"> --%>
<%-- 											<option value="${opt.id}" selected="selected">${opt.name}</option> --%>
<%-- 										</c:if> --%>
<%-- 										<c:if test="${opt.id ne selectedVendorVO.orderRestrictionVal}"> --%>
<%-- 											<option value="${opt.id}">${opt.name}</option> --%>
<%-- 										</c:if> --%>
<%-- 									</c:forEach> --%>
<!-- 								</select> -->
<%-- 							</jsp:attribute> --%>
<%-- 					<jsp:attribute name="NONE"> --%>
<!-- 								<select id="orderRestriction" tabindex="213" -->
<!-- 							class="selectBoxStyle" -->
<!-- 							style="dataType: alpha; visibility: hidden;" disabled="disabled"> -->
<%-- 									<c:forEach var="opt" --%>
<%-- 								items="${CPSForm.vendorVO.orderRestrictionList}"> --%>
<%-- 										<c:if test="${opt.id eq selectedVendorVO.orderRestrictionVal}"> --%>
<%-- 											<option value="${opt.id}" selected="selected">${opt.name}</option> --%>
<%-- 										</c:if> --%>
<%-- 										<c:if test="${opt.id ne selectedVendorVO.orderRestrictionVal}"> --%>
<%-- 											<option value="${opt.id}">${opt.name}</option> --%>
<%-- 										</c:if> --%>
<%-- 									</c:forEach> --%>
<!-- 								</select> -->
<%-- 							</jsp:attribute> --%>
<%-- 				</cps:renderByResourceAccess></div> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
			<tr>
				<td colspan="8"><c:choose>
					<c:when test="${selectedCaseVO.importEnabled eq true}">
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
							resourceId="122"
							honorViewMode="${selectedVendorVO.vendorViewOverride}">
							<jsp:attribute name="EDIT">
										 <c:if test="${selectedVendorVO.importd eq 'true'}">
											<input type="checkbox" id="import" tabindex="211"
										onclick="importClickedAjax();" checked="checked"
										disabled="disabled" />
										</c:if> 
										<c:if
									test="${selectedVendorVO.importd eq 'false' || selectedVendorVO.importd == null || selectedVendorVO.importd ==''}">
											<input type="checkbox" id="import" tabindex="211"
										onclick="importClickedAjax();" disabled="disabled" />
										</c:if>
									</jsp:attribute>
							<jsp:attribute name="VIEW"> 
			                         	<c:if
									test="${selectedVendorVO.importd eq 'true'}">
											<input type="checkbox" id="import" tabindex="211"
										onclick="importClickedAjax();" checked="checked"
										disabled="disabled" />
										</c:if>
										<c:if
									test="${selectedVendorVO.importd eq 'false' || selectedVendorVO.importd ==null || selectedVendorVO.importd ==''}">
											<input type="checkbox" id="import" tabindex="211"
										onclick="importClickedAjax();" disabled="disabled" />
										</c:if>
									</jsp:attribute>
						</cps:renderByResourceAccess></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="97%">
			<tr>
				<td><c:choose>
					<c:when test="${selectedVendorVO.importd eq 'true'}">
						<c:set value="display: block;position: relative;min-width: 0;"
							var="styleStr" />
					</c:when>
					<c:otherwise>
						<c:set value="display: none;position: relative;min-width: 0;"
							var="styleStr" />
					</c:otherwise>
				</c:choose>


				<div id="importDivAjax" style="${styleStr}">
				<fieldset id="importFieldset"><legend>Import
				Attributes</legend>

				<table width="100%" border="0">
					<tr>
						<td width="100%" align="center">
						<table border="0" width="100%" align="center">
							<c:url var="calend" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
							<c:url var="cal" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
							<tr align="left">
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="129"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="ContainerLabel">Container Size<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="ContainerLabel">Container Size<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="129"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<select id="cntnSize" tabindex="220" disabled="disabled">												
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
										<select id="cntnSize" tabindex="220" disabled="disabled">												
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
									<jsp:attribute name="NONE">
										<select id="cntnSize" tabindex="220" disabled="disabled"
											style="display: none;">												
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
								</cps:renderByResourceAccess></td>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="134"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="IncoTermsLabel">Inco Terms <em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="IncoTermsLabel">Inco Terms <em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="134"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<select id="incoTerms" tabindex="225" disabled="disabled">
											<c:forEach var="inco" items="${CPSForm.incoList}">
												<c:if
													test="${inco.id eq selectedVendorVO.importVO.incoTerms}">
													<option value="${inco.id}" selected="selected">${inco.name}</option>
												</c:if>
												<c:if
													test="${inco.id ne selectedVendorVO.importVO.incoTerms}">
													<option value="${inco.id}">${inco.name}</option>
												</c:if>
											</c:forEach>
										</select>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<select id="incoTerms" tabindex="225" disabled="disabled">
											<c:forEach var="inco" items="${CPSForm.incoList}">
												<c:if
													test="${inco.id eq selectedVendorVO.importVO.incoTerms}">
													<option value="${inco.id}" selected="selected">${inco.name}</option>
												</c:if>
												<c:if
													test="${inco.id ne selectedVendorVO.importVO.incoTerms}">
													<option value="${inco.id}">${inco.name}</option>
												</c:if>
											</c:forEach>
										</select>
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<select id="incoTerms" tabindex="225" disabled="disabled"
											style="display: none;">
											<c:forEach var="inco" items="${CPSForm.incoList}">
												<c:if
													test="${inco.id eq selectedVendorVO.importVO.incoTerms}">
													<option value="${inco.id}" selected="selected">${inco.name}</option>
												</c:if>
												<c:if
													test="${inco.id ne selectedVendorVO.importVO.incoTerms}">
													<option value="${inco.id}">${inco.name}</option>
												</c:if>
											</c:forEach>
										</select>
									</jsp:attribute>
								</cps:renderByResourceAccess> <%--  input type="text"
								maxlength="3" tabindex="240" class="textFieldMedium" value=""
								id="incoTerms" style="dataType: alphanumericOnly;" onblur="switchToUpperCase(this);return true;"/>--%>
								</td>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="130"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="PickupPointLabel">Pickup Point<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="PickupPointLabel">Pickup Point<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="130"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT"> 
									<input type="text" maxlength="20" tabindex="230"
											class="textFieldNormal"
											value="${selectedVendorVO.importVO.pickupPoint}"
											disabled="disabled" id="pcikPoint"
											style="dataType: alphanumeric;" />
								</jsp:attribute>
									<jsp:attribute name="VIEW">
									<input type="text" maxlength="20" tabindex="230"
											class="textFieldNormal"
											value="${selectedVendorVO.importVO.pickupPoint}"
											id="pcikPoint" style="dataType: alphanumeric;"
											disabled="disabled" />
								</jsp:attribute>
									<jsp:attribute name="NONE">
									<input type="text" maxlength="20" tabindex="230"
											class="textFieldNormal"
											value="${selectedVendorVO.importVO.pickupPoint}"
											id="pcikPoint" style="dataType: alphanumeric; display: none;" />
								</jsp:attribute>
								</cps:renderByResourceAccess></td>
							</tr>
							<c:url var="calen" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
							<tr>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="136"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="RatePerLabel">Duty % <em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="RatePerLabel">Duty % <em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="136"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" maxlength="6" tabindex="235"
											class="textFieldSmall" disabled="disabled"
											value="${selectedVendorVO.importVO.rate}" id="rate"
											style="dataType: float;"
											onblur="roundValue(this,2);return true;" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" maxlength="6" tabindex="235"
											class="textFieldSmall"
											value="${selectedVendorVO.importVO.rate}" id="rate"
											style="dataType: float;" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" maxlength="6" tabindex="235"
											class="textFieldSmall"
											value="${selectedVendorVO.importVO.rate}" id="rate"
											style="dataType: float; display: none;" disabled="disabled" />
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td><cps:renderByResourceAccess resourceId="133"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="DutyInfoLabel">Duty Info<em><font
											color="red"><b></b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="ColorLabel">Duty Info<em><font
											color="red"><b></b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="133"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" maxlength="20" tabindex="240"
											class="textFieldNormal"
											value="${selectedVendorVO.importVO.dutyInfo}" id="dutyInfo"
											style="dataType: alphanumeric;" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" maxlength="20" tabindex="240"
											class="textFieldNormal"
											value="${selectedVendorVO.importVO.dutyInfo}"
											disabled="disabled" id="dutyInfo"
											style="dataType: alphanumeric;" />
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" maxlength="20" tabindex="240"
											class="textFieldNormal"
											value="${selectedVendorVO.importVO.dutyInfo}"
											disabled="disabled" id="dutyInfo"
											style="dataType: alphanumeric;" />
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="132"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="MinQtyLabel">Minimum Qty<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="MinQtyLabel">Minimum Qty<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="132"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" id="minQntity" maxlength="7" tabindex="245"
											disabled="disabled" class="textFieldSmall"
											value="${selectedVendorVO.importVO.minimumQty}"
											style="dataType: numeric;" onblur="IsNumeric(this);" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" id="minQntity" maxlength="7" tabindex="245"
											class="textFieldSmall"
											value="${selectedVendorVO.importVO.minimumQty}"
											style="dataType: numeric;" disabled="disabled"
											onblur="IsNumeric(this);" />
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" id="minQntity" maxlength="7" tabindex="245"
											class="textFieldSmall"
											value="${selectedVendorVO.importVO.minimumQty}"
											style="dataType: numeric; display: none;" disabled="disabled" />
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="137"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="MiniTypeLabel">Min. Order Description<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="MiniTypeLabel">Min. Order Description<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="137"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" maxlength="20" tabindex="250"
											class="textFieldNormal"
											value="${selectedVendorVO.importVO.minimumType}" id="minType" onblur="onBlurMinType(this)"
											disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" maxlength="20" tabindex="250"
											class="textFieldNormal"
											value="${selectedVendorVO.importVO.minimumType}" id="minType"
											disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" maxlength="20" tabindex="250"
											class="textFieldNormal"
											value="${selectedVendorVO.importVO.minimumType}" id="minType"
											style="display: none;"
											disabled="disabled" />
									</jsp:attribute>
								</cps:renderByResourceAccess></td>

							</tr>
							<tr>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="195"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="HTSLabel">HTS1<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="HTSLabel">HTS1<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="195"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" id="hts" maxlength="10" tabindex="255"
											class="textFieldNormal" disabled="disabled"
											value="${selectedVendorVO.importVO.hts}" onblur="isNumericAndPadHts(this);"
											style="dataType: numeric;" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" disabled="disabled" id="hts" maxlength="10"
											tabindex="255" class="textFieldNormal"
											value="${selectedVendorVO.importVO.hts}"
											style="dataType: numeric;" onblur="isNumericAndPadHts(this);" />
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" disabled="disabled" id="hts" maxlength="10"
											tabindex="255" class="textFieldNormal"
											value="${selectedVendorVO.importVO.hts}"
											style="dataType: numeric; display: none;" />
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="254"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="HTS2Label">HTS2<em><font
											color="red"><b></b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="HTS2Label">HTS2<em><font
											color="red"><b></b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="254"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" value="${selectedVendorVO.importVO.hts2}"
											id="hts2" maxlength="10" tabindex="260"
											class="textFieldNormal" disabled="disabled"
											style="dataType: numeric;" onblur="isNumericAndPadHts(this);" />								
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" value="${selectedVendorVO.importVO.hts2}"
											id="hts2" maxlength="10" tabindex="260"
											class="textFieldNormal" disabled="disabled"
											style="dataType: numeric;" onblur="isNumericAndPadHts(this);" />								
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" value="${selectedVendorVO.importVO.hts2}"
											id="hts2" maxlength="10" tabindex="260"
											class="textFieldNormal" disabled="disabled"
											style="dataType: numeric; display: none;" />								
									</jsp:attribute>
								</cps:renderByResourceAccess></td>

								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="255"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="HTS3Label">HTS3<em><font
											color="red"><b></b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="HTS3Label">HTS3<em><font
											color="red"><b></b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="255"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" value="${selectedVendorVO.importVO.hts3}"
											id="hts3" maxlength="10" tabindex="265"
											class="textFieldNormal" disabled="disabled"
											style="dataType: numeric;" onblur="isNumericAndPadHts(this);" />								
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" value="${selectedVendorVO.importVO.hts3}"
											id="hts3" maxlength="10" tabindex="265"
											class="textFieldNormal" disabled="disabled"
											style="dataType: numeric;" onblur="isNumericAndPadHts(this);" />								
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" value="${selectedVendorVO.importVO.hts3}"
											id="hts3" maxlength="10" tabindex="265"
											class="textFieldNormal" disabled="disabled"
											style="dataType: numeric; display: none;" />								
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="133"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="ColorLabel">Product Color<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="ColorLabel">Product Color<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="133"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" maxlength="50" tabindex="270"
											class="textFieldNormal"
											value="${selectedVendorVO.importVO.color}"
											disabled="disabled" id="color"/>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" maxlength="50" tabindex="270"
											class="textFieldNormal"
											value="${selectedVendorVO.importVO.color}"
											disabled="disabled" id="color" />
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" maxlength="50" tabindex="270"
											class="textFieldNormal"
											value="${selectedVendorVO.importVO.color}"
											disabled="disabled" id="color"/>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
							</tr>
							<tr>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="197"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="AgentLabel">Agent % <em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="AgentLabel">Agent % <em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="197"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" id="agentPer" maxlength="6" tabindex="275"
											disabled="disabled" class="textFieldNormal"
											value="${selectedVendorVO.importVO.agentPerc}"
											style="dataType: float;"
											onblur="roundValue(this,2);return true;" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" id="agentPer" maxlength="6" tabindex="275"
											disabled="disabled" class="textFieldNormal"
											value="${selectedVendorVO.importVO.agentPerc}"
											style="dataType: float;"
											onblur="roundValue(this,2);return true;" />
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" id="agentPer" maxlength="6" tabindex="275"
											disabled="disabled" class="textFieldNormal"
											value="${selectedVendorVO.importVO.agentPerc}"
											style="dataType: float; display: none;"
											onblur="roundValue(this,2);return true;" />
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="199"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="CartonMarkLabel">Carton Marking<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="CartonMarkLabel">Carton Marking<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="199"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" id="cartMarketing" maxlength="30"
											tabindex="280" size="35"
											value="${selectedVendorVO.importVO.cartonMarketing}"
											style="dataType: alphanumeric;" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" id="cartMarketing" maxlength="30"
											tabindex="280" size="35"
											value="${selectedVendorVO.importVO.cartonMarketing}"
											style="dataType: alphanumeric;" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" id="cartMarketing" maxlength="30"
											tabindex="280" size="35"
											value="${selectedVendorVO.importVO.cartonMarketing}"
											style="dataType: alphanumeric; display: none;"
											disabled="disabled" />
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="196"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="DutyLabel">Duty Confirmed<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="DutyLabel">Duty Confirmed<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="196"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" id="duty" maxlength="10" tabindex="285" style="width: 70%"
											disabled="disabled" value="${selectedVendorVO.importVO.duty}"
											class="textFieldSmall"
											onblur="validateDateUsingDWR(this,'Duty Confirmed');" />
											<img src="${calend}" id="dutyCalend" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" id="duty" maxlength="20" tabindex="285" style="width: 70%"
											disabled="disabled" value="${selectedVendorVO.importVO.duty}"
											style="dataType: alphanumericOnly;" />
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" id="duty" maxlength="20" tabindex="285" style="width: 70%"
											disabled="disabled" value="${selectedVendorVO.importVO.duty}"
											style="dataType: alphanumericOnly; display: none;" />
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="131"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="FreightLabel">Freight Confirmed<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="FreightLabel">Freight Confirmed<em><font
											color="red"><b>*</b></font></em></label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<c:url var="calend" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
								<c:url var="calend1" value="${request.getContextPath()}/hebAssets/images/calendar.gif"></c:url>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="131"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" maxlength="20" tabindex="290" style="width: 70%"
											disabled="disabled"
											value="${selectedVendorVO.importVO.freight}" id="freight"
											onblur="validateDateUsingDWR(this,'Freight Confirmed');" />
										 <img src="${calend1}" id="freights" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" maxlength="20" tabindex="290" style="width: 70%"
											value="${selectedVendorVO.importVO.freight}" id="freight"
											disabled="disabled"
											onblur="validateDateUsingDWR(this,'Freight Confirmed');" />
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" maxlength="20" tabindex="290" style="width: 70%"
											disabled="disabled"
											value="${selectedVendorVO.importVO.freight}" id="freight"
											onblur="validateDateUsingDWR(this,'Freight Confirmed');" />
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="right" width="12%"></td>
								<td align="left" width="12%">&nbsp;</td>
							</tr>
							<tr>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="135"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="ProDateLabel">Proration Date</label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="ProDateLabel">Proration Date</label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="135"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" id="prorDate" maxlength="10" tabindex="295"
											disabled="disabled"
											value="${selectedVendorVO.importVO.prorationDate}"
											onblur="validateDateUsingDWR(this,'Proration Date');" /> 
										<img src="${calend}" id="propDate" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" id="prorDate" maxlength="10" tabindex="295"
											disabled="disabled"
											value="${selectedVendorVO.importVO.prorationDate}"
											onblur="validateDateUsingDWR(this,'Proration Date');" /> 
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" id="prorDate" maxlength="10" tabindex="295"
											disabled="disabled" style="display: none;"
											value="${selectedVendorVO.importVO.prorationDate}"
											onblur="validateDateUsingDWR(this,'Proration Date');" /> 
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="138"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="InstoreDateLabel">Instore Date</label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="InstoreDateLabel">Instore Date</label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="138"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" id="instoreDate" maxlength="10"
											tabindex="300"
											value="${selectedVendorVO.importVO.instoreDate}"
											onblur="validateDateUsingDWR(this,'Instore Date');"
											disabled="disabled" /> 
										<img src="${calen}" id="storeDate" disabled="disabled" />
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" id="instoreDate" maxlength="10"
											tabindex="300"
											value="${selectedVendorVO.importVO.instoreDate}"
											disabled="disabled" /> 
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" id="instoreDate" maxlength="10"
											tabindex="300"
											value="${selectedVendorVO.importVO.instoreDate}"
											disabled="disabled" style="display: none;" /> 
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="right" width="12%"><cps:renderByResourceAccess
									resourceId="198"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<label class="labelFont helpable" id="WHSEDateLabel">Whse Flush Date</label>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<label class="labelFont helpable" id="WHSEDateLabel">Whse Flush Date</label>
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="left" width="12%">&nbsp;&nbsp; <cps:renderByResourceAccess
									resourceId="198"
									honorViewMode="${selectedVendorVO.vendorViewOverride}">
									<jsp:attribute name="EDIT">
										<input type="text" id="whseFlushDate" maxlength="10"
											tabindex="305"
											value="${selectedVendorVO.importVO.whseFlushDate}"
											disabled="disabled"
											onblur="validateDateUsingDWR(this,'Whse Flush Date');" /> 
										<img src="${cal}" id="flushDate" disabled="disabled" />								
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input type="text" id="whseFlushDate" maxlength="10"
											tabindex="305"
											value="${selectedVendorVO.importVO.whseFlushDate}"
											disabled="disabled" /> 
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="text" id="whseFlushDate" maxlength="10"
											tabindex="305"
											value="${selectedVendorVO.importVO.whseFlushDate}"
											style="display: none;" /> 
									</jsp:attribute>
								</cps:renderByResourceAccess></td>
								<td align="right" width="12%"></td>
								<td align="left" width="12%">
								<div id="enableFactoryDiv" style="display: none;"><cps:renderByResourceAccess
									resourceId="256">
									<jsp:attribute name="EXEC">
											<button id="importFacilities">Import Factory</button>
										</jsp:attribute>
									<jsp:attribute name="NONE">
											<button id="importFacilities">Import Factory</button>
										</jsp:attribute>
								</cps:renderByResourceAccess></div>
								<input type="hidden" id="factoryList"
									value="${selectedVendorVO.importVO.factoryList}"></td>
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
		<table width="100%">
			<tr>

				<!-- <td><input type="button" value="Test Morph3" id="morphButton3" onclick="morphtest();"
											tabindex="320" /></td> -->	
				<td align="right" width="80%"><cps:renderByResourceAccess
					resourceId="192" honorViewMode="${CPSForm.caseViewOverRide}">
					<jsp:attribute name="EXEC">
								<input type="button" value="Save Vendor" id="addButton6"
							tabindex="320" />		
							</jsp:attribute>
				</cps:renderByResourceAccess></td>

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
				<c:if
					test="${selectedVendorVO.vendorLocTypeCode eq 'V'}">
					<div id="enableAuthorizeWHS" style="display: block;"><cps:renderByResourceAccess
						resourceId="194"
						honorViewMode="${selectedVendorVO.vendorViewOverride}">
						<jsp:attribute name="EXEC">
								<button id="authWHS" tabindex="325">Authorize WHS</button>
											</jsp:attribute>
					</cps:renderByResourceAccess></div>
				</c:if> <c:if test="${selectedVendorVO.vendorLocTypeCode ne 'V'}">
					<div id="enableAuthorizeWHS" style="display: none;"><cps:renderByResourceAccess
						resourceId="194"
						honorViewMode="${selectedVendorVO.vendorViewOverride}">
						<jsp:attribute name="EXEC">
								<button id="authWHS" tabindex="325">Authorize WHS</button>
											</jsp:attribute>
					</cps:renderByResourceAccess></div>
				</c:if> <c:if test="${selectedVendorVO.vendorLocTypeCode eq 'D'}">
					<div id="enableAuthorizeStore" style="display: block;"><cps:renderByResourceAccess
						resourceId="193"
						honorViewMode="${selectedVendorVO.vendorViewOverride}">
						<jsp:attribute name="EXEC">
									<button id="authStore" tabindex="326">Authorize Store</button>
									</jsp:attribute>
					</cps:renderByResourceAccess></div>
				</c:if> <c:if test="${selectedVendorVO.vendorLocTypeCode ne 'D'}">
					<div id="enableAuthorizeStore" style="display: none;"><cps:renderByResourceAccess
						resourceId="193"
						honorViewMode="${selectedVendorVO.vendorViewOverride}">
						<jsp:attribute name="EXEC">
								<button id="authStore" tabindex="326">Authorize Store</button>
									</jsp:attribute>
					</cps:renderByResourceAccess></div>
				</c:if></td>

			</tr>
		</table>
		</td>
	</tr>
</table>
</fieldset>
<!-- Vendor ends -->
<br>
<div id="nextDiv">
<table width="100%"
	style="width: 96%; margin-left: 10px; border-collapse: collapse;">
	<tr>
		<td width="90%"></td>
		<td align="right" width="6%"><input type="button" value="Back"
			id="backButton" tabindex="350" /></td>

	</tr>
</table>
</div>

<script type="text/javascript">
	//khoapkl --visible Activate button when modifying a active product
	<c:if test="!${AddNewCandidate.enableActiveButton}">
		if(document.getElementById('activateButton')!=null)
			document.getElementById('activateButton').disabled = false;
	</c:if>		
	<c:if test="${selectedVendorVO.newDataSw eq 'Y'.charAt(0)}">
	if(document.getElementById("deleteVendorDetailsButDiv")){
		document.getElementById("deleteVendorDetailsButDiv").style.display = 'block';
	}
	//Add Edit Vendor button
	if(document.getElementById("editVendorDetailsButDiv")){
		document.getElementById("editVendorDetailsButDiv").style.display = 'block';
		new YAHOO.widget.Button("editVendorDetailsBut",{disabled:false});
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("editVendorDetailsBut"), "click", editVendorDetails); 
	}
	</c:if>
	
	<c:if test="${selectedVendorVO.newDataSw eq 'N'.charAt(0)}">
	if(document.getElementById("deleteVendorDetailsButDiv")){
		document.getElementById("deleteVendorDetailsButDiv").style.display = 'none';
	}
	//Add Edit Vendor button
	if(document.getElementById("editVendorDetailsButDiv")){
		document.getElementById("editVendorDetailsButDiv").style.display = 'none';
	}
	if(document.getElementById("authWHS")){
		new YAHOO.widget.Button("authWHS");
		YAHOO.util.Event.removeListener("authWHS", "click");				
		YAHOO.util.Dom.get("authWHS").disabled = true;						 
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authWHS"), "click", reqWHSAttribute);
	}	
	if(document.getElementById("authStore")){
		new YAHOO.widget.Button("authStore");
		YAHOO.util.Event.removeListener("authStore", "click");				
		YAHOO.util.Dom.get("authStore").disabled = true;						 
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
	}
	</c:if>	

	if(document.getElementById("addButton6"))
	{
		new YAHOO.widget.Button("addButton6");
    	YAHOO.util.Dom.get("addButton6").disabled = true;
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", saveCaseAndVendor);
	}
	if(document.getElementById("vendorCancel")){
		new YAHOO.widget.Button("vendorCancel");
		YAHOO.util.Dom.get("vendorCancel").disabled = true;
		YAHOO.util.Event.removeListener("vendorCancel", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("vendorCancel"), "click", onVendorCancelClick);
	}
	if(document.getElementById("importFacilities")){
		new YAHOO.widget.Button("importFacilities");
		
		//HoangVT - [#1387 - Import Section] the Import Factory still enable in VIEW mode - disable when load view
		YAHOO.util.Dom.get("importFacilities").disabled = false;

		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("importFacilities"), "click", importFacilities);//R2
	}
	YAHOO.util.Event.onDOMReady(function(){
		YAHOO.util.Dom.get("hts").value = padHts(YAHOO.util.Dom.get("hts").value);
		YAHOO.util.Dom.get("hts2").value = padHts(YAHOO.util.Dom.get("hts2").value);
		YAHOO.util.Dom.get("hts3").value = padHts(YAHOO.util.Dom.get("hts3").value);
	});
</script>