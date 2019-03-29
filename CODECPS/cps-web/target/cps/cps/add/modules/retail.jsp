<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<c:url value="${request.getContextPath()}/dwr/interface/AddCandidateTemp.js" var="myJs"/>
<c:url var="iconQuestion" value="${request.getContextPath()}/hebAssets/images/buttons/iconQuestion.png"/>
<script type="text/javascript" src="${myJs}"></script>

<a id="sec5tion"></a>
<fieldset id="retialFields" style="width: 95%;">
	<legend class="legendFont">Retail </legend>
	<form:hidden path="productVO.retailLinkVO.retailLinkNum" id="retailLinkNum"/>
	<c:choose>
		<c:when test="${addNewCandidate.productVO.classificationVO.productType eq 'SPLY'}">
			<c:set value="display: none;position: relative;" var="retailStyleVar"></c:set>
			<c:set value="display: block;position: absolute" var="disa"></c:set>
			<c:set value="true" var="disFlag"></c:set>
		</c:when>
		<c:otherwise>
			<c:set value="display: block;position: relative;" var="retailStyleVar"></c:set>
			<c:set value="display: none;position: absolute;" var="disa"></c:set>
			<c:set value="false" var="disFlag"></c:set>
		</c:otherwise>
	</c:choose>
	<table width="100%" cellspacing="3" border="0" bordercolor="orange">
		<tr>
			<td align="right" width="10%">
				<div id="forSupply-0"  style="display: block;position: relative;">
					<label for="selectedChannel" class="labelFont helpable" id="SuggestRetailLabel">
						Suggested Retail
						<c:choose>
							<c:when test="${addNewCandidate.userRole eq 'UVEND'}">
								<span class="mtGroup mtGroup1 mtGroup4 mtGroup5">
									<em><font color="red"><b>*</b></font></em>
								</span>
							</c:when>
							<c:when test="${addNewCandidate.userRole eq 'RVEND'}">
								<span class="mtGroup mtGroup1 mtGroup4 mtGroup5">
									<em><font color="red"><b>*</b></font></em>
								</span>
							</c:when>
						</c:choose>
					</label>
				</div>
			</td>
			<td align="left" width="20%">
				<div id="forSupply-1"  style="display: block;position: relative;">
					<cps:renderByResourceAccess resourceId="230" honorViewMode="${addNewCandidate.retailViewOverRide}">
						<jsp:attribute name="EDIT">
							<form:input path="productVO.retailVO.suggRetail" maxlength="9" size="9" id="suggRetail"
										style="dataType : numeric;" styleId="suggRetail" tabindex="390"
										disabled="${disFlag}"/>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:input path="productVO.retailVO.suggRetail" maxlength="9" size="9" id="suggRetail"
										style="dataType : numeric;" styleId="suggRetail" tabindex="390"
										disabled="true"/>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<label for="selectedChannel" class="labelFont helpable"id="SuggestedRetailForLabel">For</label>
					<label id="label1">$</label>
					<cps:renderByResourceAccess resourceId="231" honorViewMode="${addNewCandidate.retailViewOverRide}">
						<jsp:attribute name="EDIT">
							<form:input path="productVO.retailVO.suggforPrice" maxlength="10" size="8" tabindex="400"
										styleId="suggforPrice" id="suggforPrice" style="dataType : float;"
										onblur="roundValue(this,2);return true;"  disabled="${disFlag}"/>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:input path="productVO.retailVO.suggforPrice" maxlength="10" size="8" tabindex="400"
										styleId="suggforPrice" style="dataType : float;" disabled="true"/>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<img src="${iconQuestion}" title="Non-Sellable products that are not sold to customers do not need retail."
						 width="20"  onmouseover="this.style.cursor='pointer'" style="${disa}" styleId="imageHelp" id="imageHelp"/>
				</div>
			</td>
			<td align="right" width="10%">
				<div id="forSupply2"  style="${retailStyleVar}">
					<c:choose>
						<c:when test="${addNewCandidate.userRole eq 'UVEND'}">
							<c:set value="visibility: hidden;position: relative;" var="vendorLoginValue"></c:set>
						</c:when>
						<c:when test="${addNewCandidate.userRole eq 'RVEND'}">
							<c:set value="visibility: hidden;position: relative;" var="vendorLoginValue"></c:set>
						</c:when>
						<c:otherwise>
							<c:set value="visibility: visible;position: relative;" var="vendorLoginValue"></c:set>
						</c:otherwise>
					</c:choose>
					<div id="forVendorLogin0" style="${vendorLoginValue}">
						<label for="selectedChannel" class="labelFont helpable" id="SoldByWeightLabel">Sold by Weight</label>
					</div>
				</div>
			</td>
			<td align="left" width="10%">
				<div id="forSupply3"  style="${retailStyleVar}">
					<div id="forVendorLogin1" style="${vendorLoginValue}">
						<cps:renderByResourceAccess resourceId="57" honorViewMode="${addNewCandidate.retailViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:checkbox path="productVO.retailVO.weightFlag" styleId="weightFlag" id="weightFlag"
											   tabindex="410" value="true" cssClass="mtGroup mtGroup1 mtGroup2" />
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:checkbox path="productVO.retailVO.weightFlag" styleId="weightFlag" id="weightFlag"
											   tabindex="410" value="true" disabled="true" cssClass="mtGroup mtGroup1 mtGroup2"/>
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</div>
				</div>
			</td>
			<td align="right" width="5%">
				<cps:renderByResourceAccess resourceId="58" honorViewMode="${addNewCandidate.retailViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:radiobutton path="productVO.retailVO.retailRadio" styleId="retailRadio" id="retailRadio"
										  value="retail" tabindex="420" onclick="enableTextBox()"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:radiobutton path="productVO.retailVO.retailRadio" styleId="retailRadio" id="retailRadio"
										  value="retail" tabindex="420" disabled="true"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left" width="20%">
				<cps:renderByResourceAccess resourceId="58" honorViewMode="${addNewCandidate.retailViewOverRide}">
					<jsp:attribute name="EDIT">
						<div id="rtlShowDiv1"  style="visibility : visible;position: relative;">
							<label for="selectedChannel" class="labelFont helpable" id="RetailRadioLabel">
								Retail
								<span class="mtGroup mtGroup1 mtGroup4 mtGroup5">
									<em><font color="red"><b>*</b></font></em>
								</span>
							</label>
						</div>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<div id="rtlShowDiv2"  style="visibility : visible;position: relative;">
							<label for="selectedChannel" class="labelFont helpable" id="RetailRadioLabel">Retail
								<span class="mtGroup mtGroup1 mtGroup4 mtGroup5">
									<em><font color="red"><b>*</b></font></em>
								</span>
							</label>
						</div>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
		</tr>
		<tr>
			<td align="right" width="10%" >
				<div id="forSupply4"  style="${retailStyleVar}">
					<label for="selectedChannel" class="labelFont helpable"id="PrepriceLabel">Preprice</label>
				</div>
			</td>
			<td align="left" width="20%">
				<div id="forSupply5"  style="${retailStyleVar}">
					<cps:renderByResourceAccess resourceId="55" honorViewMode="${addNewCandidate.retailViewOverRide}">
						<jsp:attribute name="EDIT">
							<form:input path="productVO.retailVO.prePrice" maxlength="9" size="9" styleId="prePrice"
										id="prePrice" tabindex="430" style="dataType : numeric;"
										cssClass="mtGroup mtGroup1 mtGroup4"/>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:input path="productVO.retailVO.prePrice" maxlength="9" size="9" styleId="prePrice"
										id="prePrice" tabindex="430" style="dataType : numeric;" disabled="true"
										cssClass="mtGroup mtGroup1 mtGroup4" />
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<label for="selectedChannel" class="labelFont helpable" id="PrepriceForLabel">For</label>
					<label id="label1">$</label>
					<cps:renderByResourceAccess resourceId="55" honorViewMode="${addNewCandidate.retailViewOverRide}">
						<jsp:attribute name="EDIT">
							<form:input path="productVO.retailVO.forPrice" maxlength="10" size="8" tabindex="440"
										style="dataType : float;" id="prepricefor" onblur="roundValue(this,2);setPrePrice();return true;"
										cssClass="mtGroup mtGroup1 mtGroup4"/>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:input path="productVO.retailVO.forPrice" maxlength="10" size="8" tabindex="440"
										style="dataType : float;" id="prepricefor" disabled="true"
										cssClass="mtGroup mtGroup1 mtGroup4"/>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<label id="prepriceforlabel"></label>
				</div>
			</td>
			<td align="right" width="10%">
				<div id="forSupply6"  style="${retailStyleVar}">
					<div id="forVendorLogin3" style="${vendorLoginValue}">
						<label class="labelFont helpable" id="CriticalItemLabel">
							Critical Item <em><font color="red"><b>*</b></font></em>
						</label>
					</div>
				</div>
			</td>
			<td align="left" width="10%">
				<div id="forSupply7"  style="${retailStyleVar}">
					<cps:renderByResourceAccess resourceId="62" honorViewMode="${addNewCandidate.retailViewOverRide}">
						<jsp:attribute name="EDIT">
							<form:select path="productVO.retailVO.criticalItem" tabindex="450" id="criticalItem"
									  styleId="criticalItem" cssClass="mtGroup mtGroup1 mtGroup2">
								 <form:options items="${addNewCandidate.criItemList}" itemLabel="name"	itemValue="id" />
							</form:select>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:input path="productVO.retailVO.criticalItemName" disabled="true" cssClass="mtGroup mtGroup1 mtGroup2"/>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</div>
			</td>
			<td align="right" width="5%">
				<div id="forSupply8"  style="${retailStyleVar}">
					<cps:renderByResourceAccess resourceId="59" honorViewMode="${addNewCandidate.retailViewOverRide}">
						<jsp:attribute name="EDIT">
							<form:radiobutton path="productVO.retailVO.retailRadio" styleId="retailMatrix" id="retailMatrix"
											  tabindex="460" value="matrixMargin" onclick="selectCritItem();" />
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:radiobutton path="productVO.retailVO.retailRadio" styleId="retailMatrix" id="retailMatrix"
											  tabindex="460" value="matrixMargin" disabled="true" />
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</div>
			</td>
			<td align="left" width="20%">
				<div id="forSupply9"  style="${retailStyleVar}">
					<div id="forVendorLogin4" style="${vendorLoginValue}">
						<label for="selectedChannel" class="labelFont helpable" id="MatrixRadioLabel">
							Matrix Margin<em><font color="red"><b>*</b></font></em>
						</label>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td align="right" width="10%">
				<div id="forSupply10"  style="${retailStyleVar}">
					<div id="forVendorLogin5" style="${vendorLoginValue}">
						<label for="selectedChannel" class="labelFont helpable" id="OffPriceLabel">
							% Off Preprice
						</label>
					</div>
				</div>
			</td>
			<td align="left" width="20%">
				<div id="forSupply11"  style="${retailStyleVar}">
					<div id="forVendorLogin6" style="${vendorLoginValue}">
						<cps:renderByResourceAccess resourceId="61" honorViewMode="${addNewCandidate.retailViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:input path="productVO.retailVO.offPreprice" maxlength="5" size="5"
											tabindex="470" style="dataType : float ;" id="percOffPrePrice"
											cssClass="mtGroup mtGroup1" onblur="roundValue(this,2);return true;"/>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:input path="productVO.retailVO.offPreprice" maxlength="5" size="5" tabindex="470"
											style="dataType : float ;" id="percOffPrePrice" disabled="true" cssClass="mtGroup mtGroup1"/>
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</div>
				</div>
			</td>
			<td align="right" width="10%">
				<div id="forSupply12"  style="${retailStyleVar}">
					<div id="forVendorLogin7" style="${vendorLoginValue}">
						<label class="labelFont helpable" id="TobaccoLabel">Tobacco Tax </label>
					</div>
				</div>
			</td>
			<td align="left" width="10%">
				<div id="forSupply13"  style="${retailStyleVar}">
					<div id="forVendorLogin8" style="${vendorLoginValue}">
						<cps:renderByResourceAccess resourceId="182" honorViewMode="${addNewCandidate.retailViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:select path="productVO.retailVO.tobaccoTax" tabindex="480" id="tobaccoTax"
											 styleId="tobaccoTax" disabled="true">
									<form:options items="${addNewCandidate.yesNoList}" itemLabel="name"	itemValue="id" />
								</form:select>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:select path="productVO.retailVO.tobaccoTax" tabindex="480" id="tobaccoTax"
											 disabled="true">
									<form:options items="${addNewCandidate.yesNoList}" itemLabel="name"	itemValue="id" />
								</form:select>
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</div>
				</div>
			</td>
			<td align="right" width="5%">
				<div id="forSupply14"  style="${retailStyleVar}">
					<cps:renderByResourceAccess resourceId="60" honorViewMode="${addNewCandidate.retailViewOverRide}">
						<jsp:attribute name="EDIT">
							<form:radiobutton path="productVO.retailVO.retailRadio" styleId="retailLink" id="retailLink"
											  value="retailLink" tabindex="490" onclick="selectRetail();"/>
						</jsp:attribute>
						<jsp:attribute name="VIEW">
							<form:radiobutton path="productVO.retailVO.retailRadio" styleId="retailLink" id="retailLink"
											  value="retailLink" tabindex="490" disabled="true"/>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</div>
			</td>
			<td align="left" width="20%">
				<div id="forSupply15"  style="${retailStyleVar}">
					<div id="forVendorLogin9" style="${vendorLoginValue}">
						<label class="labelFont helpable" for="selectedChannel" id="RetailLinkRadioLabel" >
							Retail Link <em><font color="red"><b>*</b></font></em>
						</label>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td align="right" width="10%">
				<div id="forSupply16"  style="${retailStyleVar}">
					<div id="forVendorLogin10" style="${vendorLoginValue}">
						<label for="selectedChannel" class="labelFont helpable" id="CentsOffLabel">Cents Off</label>
					</div>
				</div>
			</td>
			<td align="left" width="20%">
				<div id="forSupply17"  style="${retailStyleVar}">
					<div id="forVendorLogin11" style="${vendorLoginValue}">
						<cps:renderByResourceAccess resourceId="63" honorViewMode="${addNewCandidate.retailViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:input path="productVO.retailVO.centsOff" maxlength="12" size="11" tabindex="500"
											style="dataType : float;" styleId="centsOff" id="centsOff"
											cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
											onblur="roundValue(this,4);validateCentsOff();return true;"/>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:input path="productVO.retailVO.centsOff" maxlength="12" size="11" tabindex="500"
											style="dataType : float;" styleId="centsOff" id="centsOff" disabled="true"
											cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"/>
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</div>
				</div>
			</td>
			<td	colspan="2" width="">
			<td align="right" width="5%">
			<div id="forSupply20"  style="${retailStyleVar}">
				<cps:renderByResourceAccess resourceId="59" honorViewMode="${addNewCandidate.retailViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:radiobutton path="productVO.retailVO.retailRadio" styleId="priceRequired" id="priceRequired"
										  value="priceRequired" tabindex="502"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:radiobutton path="productVO.retailVO.retailRadio" styleId="priceRequired" id="priceRequired"
										  value="priceRequired" tabindex="502" disabled="true"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</div>
		</td>
			<td align="left" width="20%">
				<div id="forSupply21"  style="${retailStyleVar}">
					<div id="forVendorLogin4" style="${vendorLoginValue}">
						<label class="labelFont helpable" for="selectedChannel" id="PriceRequiredRadioLabel" >
							Price Required<em><font color="red"><b>*</b></font></em>
						</label>
				</div>
			</div>
		</td>
		</tr>
	</table>
	<div id="matrixDiv" align="right" style="visibility: hidden; height: 25px;">
		<div id="forSupply18"  style="${retailStyleVar}">
			<table width="100%" align="right" border="0" style="${retailStyleVar}">
				<tr>
					<td width="71%" align="right">
						<label for="selectedChannel" class="labelFont helpable" id="MatrixMarginLabel">
							Matrix Margin
						</label>
					</td>
					<td width="20%" align="left">
						<cps:renderByResourceAccess resourceId="59" honorViewMode="${addNewCandidate.retailViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:input path="productVO.retailVO.matrixMarginSW" readonly="true" maxlength="5"
											size="5" tabindex="530" id="matrixMargin"/>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:input path="productVO.retailVO.matrixMarginSW" readonly="true" maxlength="5"
											size="5" tabindex="530" id="matrixMargin" />
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="retailLinkDiv" align="right" style="visibility: hidden; height: 25px;">
		<div id="forSupply19"  style="${retailStyleVar}">
			<table border="0" width="100%" align="right" >
				<tr>
					<td width="71%" align="right">
						<label for="selectedChannel" class="labelFont helpable" id="RetailLinkToLabel">Retail Link To</label>
					</td>
					<td width="20%" align="left">
						<cps:renderByResourceAccess resourceId="60" honorViewMode="${addNewCandidate.retailViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:input path="productVO.retailVO.retailLinkTo" maxlength="13" size="15" tabindex="540"
											style="dataType : numeric;" id="retailLinkTo" onblur="showPopup();"/>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:input path="productVO.retailVO.retailLinkTo" tabindex="540" style="dataType:numeric;"
											styleId="retailLinkTo" id="retailLinkTo" disabled="true"/>
							</jsp:attribute>
						</cps:renderByResourceAccess>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="tempDiv" align="right">
		<table width="100%" align="right" border="0">
			<tr>
				<td  width="80%" align="right">
					<div id="forVendorLogin12" style="${vendorLoginValue}">
						<label for="selectedChannel" class="labelFont helpable" id="RetailLabel">Retail </label>
						<cps:renderByResourceAccess resourceId="64" honorViewMode="${addNewCandidate.retailViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:input path="productVO.retailVO.retail" maxlength="5" size="9" tabindex="510"
											style="dataType : numeric;" id="retail" onkeydown="removeBSP(event, this);"
											disabled="${disFlag}" cssClass="mtGroup mtGroup1 mtGroup2"/>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:input	path="productVO.retailVO.retail" maxlength="5" size="9" tabindex="510"
											   style="dataType : numeric;" id="retail" onkeydown="removeBSP(event, this);"
											   disabled="true" cssClass="mtGroup mtGroup1 mtGroup2" />
							</jsp:attribute>
						</cps:renderByResourceAccess>
						<label	for="selectedChannel" class="labelFont helpable"id="RetailForLabel">
							For
							<span class="mtGroup mtGroup1 mtGroup4 mtGroup5">
								<em><font color="red"><b>*</b></font></em>
							</span>
							$</label>
						<cps:renderByResourceAccess resourceId="64" honorViewMode="${addNewCandidate.retailViewOverRide}">
							<jsp:attribute name="EDIT">
								<form:input value="${addNewCandidate.productVO.retailVO.retailForWrap}"
											path="productVO.retailVO.retailForWrap" maxlength="10" size="10"
											tabindex="520" style="dataType : float;" id="retailForprice"
											onkeydown="removeBSP(event, this);"  disabled="${disFlag}"
											onblur="roundValue(this,2);validateCentsOff();return true;"
											onchange="updateRet();" cssClass="mtGroup mtGroup1 mtGroup2"/>
							</jsp:attribute>
							<jsp:attribute name="VIEW">
								<form:input value="${addNewCandidate.productVO.retailVO.retailForWrap}"
											path="productVO.retailVO.retailForWrap" maxlength="10" size="10"
											tabindex="520" style="dataType : float;" id="retailForprice"
											onkeydown="removeBSP(event, this);" disabled="true" cssClass="mtGroup mtGroup1 mtGroup2" />
							</jsp:attribute>
						</cps:renderByResourceAccess>
						<label id="retailforlabel"></label>
					</div>
				</td>
				<td width="5%" align="left" style="${vendorLoginValue}">
					<img src="${iconQuestion}" title="Non-Sellable products that are not sold to customers do not need retail."
						 width="20"  onmouseover="this.style.cursor='pointer'" style="${disa }" id="imageHelp1"/>
				</td>
			</tr>
		</table>
	</div>
</fieldset>

<script type="text/javascript">

	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("assortButton"), "click", showAssortment);

	<c:if test= "${addNewCandidate.search}" >
		document.getElementById('prePrice').disabled = true;
		document.getElementById('weightFlag').disabled = true;
		document.getElementById('forPrice').disabled = true;
		document.getElementById('retail1').disabled = true;
		document.getElementById('percOffPrePrice').disabled = true;
		document.getElementById('criticalItem').disabled = true;
		document.getElementById('retail2').disabled = true;
		document.getElementById('retailLinkTo').disabled = true;
		document.getElementById('retail3').disabled = true;
		document.getElementById('retailFor2').disabled = true;
		document.getElementById('retail11').disabled = true;
		document.getElementById('retailFor1').disabled = true;
		document.getElementById('retail').disabled = true;
		document.getElementById('retailFor0').disabled = true;
		document.getElementById('tagType').disabled = true;
		document.getElementById('centsOff').disabled = true;
		document.getElementById('changeTypes').disabled = true;
		document.getElementById('retailLink').disabled = true;
	</c:if>

	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("retailRadio"), "click", selectedRadio,"retail");
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("retailMatrix"), "click", selectedRadio,"retailMatrix");
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("retailLink"), "click", selectedRadio,"retailLink");
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("priceRequired"), "click", selectedRadio,"priceRequired");
	YAHOO.util.Event.onDOMReady(selectedRadio);

	function selectedRadio(evt,obj){
		radioSelected = obj;
		var cont;
		if(radioSelected == "retail"){
			tempDiv.style.visibility = 'visible';
			tempDiv.style.position = 'static';
			matrixDiv.style.visibility = 'hidden';
			matrixDiv.style.position = 'absolute';
			retailLinkDiv.style.visibility = 'hidden';
			retailLinkDiv.style.position = 'absolute';
			setReadOnly(false);

	// 		setColorGrey(false);
			if(YAHOO.util.Dom.hasClass("retailForprice", 'setColorGrey')){
				YAHOO.util.Dom.removeClass("retailForprice", 'setColorGrey');
			}
			if(YAHOO.util.Dom.hasClass("retail", 'setColorGrey')){
				YAHOO.util.Dom.removeClass("retail", 'setColorGrey');
			}

			YAHOO.util.Dom.get("retailLinkTo").value = '';
			YAHOO.util.Dom.get("matrixMargin").value = '';
			document.getElementById('retail').value = "";
			document.getElementById('retailForprice').value = "";
		}else if(radioSelected == "retailMatrix"){
			matrixDiv.style.visibility = 'visible';
			matrixDiv.style.position = 'static';
			tempDiv.style.visibility = 'visible';
			tempDiv.style.position = 'static';
			retailLinkDiv.style.visibility = 'hidden';
			retailLinkDiv.style.position = 'absolute';
			YAHOO.util.Dom.get("retailLinkTo").value = '';
			document.getElementById('retail').value = "";
			document.getElementById('retailForprice').value = "";
	// 		setColorGrey(false);
			if(YAHOO.util.Dom.hasClass("retailForprice", 'setColorGrey')){
				YAHOO.util.Dom.removeClass("retailForprice", 'setColorGrey');
			}
			if(YAHOO.util.Dom.hasClass("retail", 'setColorGrey')){
				YAHOO.util.Dom.removeClass("retail", 'setColorGrey');
			}
		}else if(radioSelected == "retailLink"){
			retailLinkDiv.style.visibility = 'visible';
			retailLinkDiv.style.position = 'static';
			tempDiv.style.visibility = 'visible';
			tempDiv.style.position = 'static';
			matrixDiv.style.visibility = 'hidden';
			matrixDiv.style.position = 'absolute';
			document.getElementById('retail').readOnly=true;
			document.getElementById('retailForprice').readOnly=true;
	// 		setColorGrey(false);
			if(YAHOO.util.Dom.hasClass("retailForprice", 'setColorGrey')){
				YAHOO.util.Dom.removeClass("retailForprice", 'setColorGrey');
			}
			if(YAHOO.util.Dom.hasClass("retail", 'setColorGrey')){
				YAHOO.util.Dom.removeClass("retail", 'setColorGrey');
			}
			YAHOO.util.Dom.get("matrixMargin").value = '';
			document.getElementById('retail').value = "";
			document.getElementById('retailForprice').value = "";

		}else if(radioSelected == "priceRequired"){
			tempDiv.style.visibility = 'visible';
			tempDiv.style.position = 'static';
			matrixDiv.style.visibility = 'hidden';
			matrixDiv.style.position = 'absolute';
			retailLinkDiv.style.visibility = 'hidden';
			retailLinkDiv.style.position = 'absolute';
			YAHOO.util.Dom.get("retailLinkTo").value = '';
			YAHOO.util.Dom.get("matrixMargin").value = '';
			document.getElementById('retail').value = "1";
			document.getElementById('retailForprice').value = "0.00";
			document.getElementById('retail').readOnly=true;
			document.getElementById('retailForprice').readOnly=true;
			YAHOO.util.Dom.addClass("retail", 'setColorGrey');
			YAHOO.util.Dom.addClass("retailForprice", 'setColorGrey');
		}
	}

	function removeBSP(event, ele){
		if(ele.readOnly == true){
			if(event.keyCode == 8){
				event.returnValue = false;
				if(event.preventDefault) event.preventDefault();
			}
		}
	}

	function setReadOnly(flag){
		if(flag){
			document.getElementById('retail').readOnly=true;
			document.getElementById('retailForprice').readOnly=true;
		}else{
			document.getElementById('retail').readOnly=false;
			document.getElementById('retailForprice').readOnly=false;
		}
	}

	<c:url value="/protected/cps/add/assortment?${_csrf.parameterName}=${_csrf.token}" var="pageSrc" />
	function showAssortment(evt) {
		f1("${pageSrc}"+'&t='+new Date().getTime(),"Assortment Attributes",'440px','70%','100px','100px'); 
	}

	<c:url value="/protected/cps/add/matrixMargin?${_csrf.parameterName}=${_csrf.token}" var="matrixMargin" />

	function showMatrix(evt) {
		YAHOO.util.Dom.get("retailLinkTo").value = '';
		YAHOO.util.Dom.get("matrixMargin").value = 'Y';
		var critItem = YAHOO.util.Dom.get("criticalItem").value;
		if (critItem=='N'||critItem=='S'||critItem=='P')
		{
			YAHOO.util.Dom.get("retail").value = 1;
			YAHOO.util.Dom.get("retail").readOnly= true;
			YAHOO.util.Dom.get("retailForprice").readOnly= false;
			f1("${matrixMargin}"+'&t='+new Date().getTime(),"Matrix margin",'180px','60%','130px','200px');
		}
		else {
			YAHOO.util.Dom.get("retail").readOnly= false;
			YAHOO.util.Dom.get("retailForprice").readOnly= false;
		}
	}

	function enableTextBox(evt){
		YAHOO.util.Dom.get("retail").readOnly= false;
		YAHOO.util.Dom.get("retailForprice").readOnly= false;
		YAHOO.util.Dom.get("retailLinkTo").value = '';
		YAHOO.util.Dom.get("matrixMargin").value = '';
	}

	function setPrePrice(){
		var prepriceFor = YAHOO.util.Dom.get("prepricefor").value;
		if(prepriceFor != null && prepriceFor > 0 ){
			var preprice = YAHOO.util.Dom.get("preprice").value;
			if(preprice == null || preprice == "" || preprice == "0"){
				YAHOO.util.Dom.get("preprice").value = '1';
			}
		}
	}

	function calculatePrice(){
		var preprice = YAHOO.util.Dom.get("prepricefor").value;			
		if(preprice == ""){
			document.getElementById('prepricefor').value = '0.00';
		}else 
			var Chars = "0123456789.,$"; 
   		for(var i = 0; i < preprice.length; i++){ 
       		if(Chars.indexOf(preprice.charAt(i)) == -1){ 
	           YAHOO.util.Dom.get("prepricefor").focus(); 
    	       YAHOO.util.Dom.get("prepricefor").select(); 
        	   return; 
			}else
				var pre = parseFloat(preprice);
			if(isNaN(pre)){
				pre = 0.00; 
			}
			var minus = '';
			if(pre < 0){
				minus = '';
			}
			pre = Math.abs(pre);
			pre = parseInt((pre + .005) * 100);
			pre = pre / 100;
			s = new String(pre);
			if(s.indexOf('.') < 0){ 
				s += '.00'; 
			}
			if(s.indexOf('.') == (s.length - 2)){ 
				s += '0'; 
			}
			s = minus + s;
			document.getElementById('prepricefor').value = s;
		}
	}
	
	<c:url var="retailLinkPopUp" value="/protected/cps/add/retailLink?${_csrf.parameterName}=${_csrf.token}"></c:url>
	
	function showPopup(evt){
		var upc = document.getElementById('retailLinkTo').value;			
		if((null != upc) && (upc != "")){
			upc=padding(upc);//trungnv fix bug relate retail link
			if(upc.length == 13 || upc.length ==7) {
				f1('${retailLinkPopUp}'+'&retailLinkUpc='+upc+'&t='+new Date().getTime(),'Retail Link Information','250px','60%','100px','150px');
			}else{
				alert('Please enter a 13 digit UPC or a 7 digit Item Code');
				document.getElementById('retailLinkTo').value = "";
			}
		}
	}
	
	YAHOO.util.Event.onDOMReady(selectRetailOnLoad);
	function selectRetailOnLoad(){
		if(YAHOO.util.Dom.get("retailMatrix").checked){
			matrixDiv.style.visibility = 'visible';
			matrixDiv.style.position = 'static';
			tempDiv.style.visibility = 'visible';
			tempDiv.style.position = 'static';
			retailLinkDiv.style.visibility = 'hidden';
			retailLinkDiv.style.position = 'absolute';
		}else if(YAHOO.util.Dom.get("retailLink").checked){
			selectRetail();
		}else if(YAHOO.util.Dom.get("priceRequired").checked){
			tempDiv.style.visibility = 'visible';
			tempDiv.style.position = 'static';
			matrixDiv.style.visibility = 'hidden';
			matrixDiv.style.position = 'absolute';
			retailLinkDiv.style.visibility = 'hidden';
			retailLinkDiv.style.position = 'absolute';
			document.getElementById('retail').readOnly=true;
			document.getElementById('retailForprice').readOnly=true;
// 			setColorGrey(true);
			YAHOO.util.Dom.addClass("retailForprice", 'setColorGrey');
			YAHOO.util.Dom.addClass("retail", 'setColorGrey');
			
		}else{
			tempDiv.style.visibility = 'visible';
			tempDiv.style.position = 'static';
			matrixDiv.style.visibility = 'hidden';
			matrixDiv.style.position = 'absolute';
			retailLinkDiv.style.visibility = 'hidden';
			retailLinkDiv.style.position = 'absolute';
		}	
	}
	
	function selectRetail() {
		var retailLinkDiv = document.getElementById('retailLinkDiv');
		var tempdiv=document.getElementById('tempDiv');
		retailLinkDiv.style.visibility = 'visible';
		retailLinkDiv.style.position = 'static';
		tempDiv.style.visibility = 'visible';
		tempDiv.style.position = 'static';
		matrixDiv.style.visibility = 'hidden';
		matrixDiv.style.position = 'absolute';
		document.getElementById('retail').readOnly=true;
		document.getElementById('retailForprice').readOnly=true;

	     if(null == YAHOO.util.Dom.get("retailLinkNum").value){
	    	 YAHOO.util.Dom.get("retailLinkNum").value = '';
	     }	     
         //document.getElementById('retailLinkTo').focus();
         if(null == YAHOO.util.Dom.get("retail").value){
         	YAHOO.util.Dom.get("retail").value = '';
         }

         if(null == YAHOO.util.Dom.get("retailForprice").value){
	     	YAHOO.util.Dom.get("retailForprice").value = '';
         }
         YAHOO.util.Dom.get("matrixMargin").value = '';
	}
	
	function updateRetail(data1){ 
    	document.getElementById('retailForprice').value = data1;   
    }

	function updateRetailForRetailLink(data1,data2, data3){ 
   		document.getElementById('retail').value = data1;
    	document.getElementById('retailForprice').value = data2;
    	document.getElementById('retailLinkTo').value = data3;
    }
	
	function selectCritItem(){
		var critItem = YAHOO.util.Dom.get("criticalItem").value;
		var subComCode = YAHOO.util.Dom.get("subCommodityStrutsHiddenElm").value;
		if((null!=subComCode && ""!= subComCode.trim()) && (critItem=='N'||critItem=='S'||critItem=='P'))
		{
		showProgress();
		 AddCandidateTemp.getMarginPercent(critItem,subComCode,getDWRCallbackMethod(updateCritItem));
		}
	}
	
	function updateCritItem(data){
	 hideProgress();
	 showMatrix();
	}

	function updateRet(){
		var critItem = YAHOO.util.Dom.get("criticalItem").value;
		var subComCode = YAHOO.util.Dom.get("subCommodityStrutsHiddenElm").value;
		var retailFor = document.getElementById('retailForprice').value;
		if (critItem=='N'||critItem=='S'||critItem=='P'){
		    if( document.getElementById("retailMatrix").checked){
				AddCandidateTemp.updateMargin(critItem,subComCode,retailFor,getDWRCallbackMethod(updatedRetail));
		    }
		 }
	} 
	
	function updatedRetail(data){
		var min = data.MIN;
		var max = data.MAX;
		var oldMargin = data.OLDMARGIN;
		var updatedMargin = data.MARGIN;
		var retailFor = data.RETAIL;

		if((updatedMargin > max)||(updatedMargin < min)){
			if(0 != min && 0 != max){
				var answer = confirm('Retail out of Tolerance. Tolerance are '+min+ '(min)--' +max+ '(max). Do you wish to continue?');

				if(answer){
					document.getElementById('retailForprice').value = retailFor;
					return ;
				}else{
					document.getElementById('retail').checked = true;
					tempDiv.style.visibility = 'visible';
					tempDiv.style.position = 'static';
					matrixDiv.style.visibility = 'hidden';
					matrixDiv.style.position = 'absolute';
					retailLinkDiv.style.visibility = 'hidden';
					retailLinkDiv.style.position = 'absolute';
					YAHOO.util.Dom.get("retail").readOnly = false;
					return ;
				}
			}
		}
	}

	function validateCentsOff(){
		if(document.getElementById('centsOff') && document.getElementById('retailForprice')){
			if (!validateRetailForNext()) {
				return false;
			}
		}
	}

	function padding(upc)
	{				
		if(upc.length > 7 && upc.length < 13)
		{
			for(i=13;i>=upc.length-1;i--)
			{
				upc="0"+upc;
			}
		}		
		return (upc);
	}
	
	String.prototype.trim = function () {
	    return this.replace(/^\s*/, "").replace(/\s*$/, "");
	}
</script>