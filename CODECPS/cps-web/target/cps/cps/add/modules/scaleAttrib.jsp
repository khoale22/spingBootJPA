<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<fieldset style="width: 95%;">
	<legend class="legendFont">Scale Attributes</legend>
	<table width="100%" border="0">
		<tr>
			<td align="right" width="19%" nowrap="nowrap">
				<label class="labelFont helpable" id="IngredientStatementNumberLabel">
					Ingredient Statement Number<em id="ingrStmtRequired" style="color:red"><b>*</b></em>
				</label>
			</td>
			<td align="left" width="5%">
				<cps:renderByResourceAccess resourceId="202" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<input value="${addNewCandidate.productVO.scaleVO.ingStatementNumber}" id="ingStatementNumber"
						       cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="530" onblur="popularValueToHiddenElement();"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.ingStatementNumber}" id="ingStatementNumber" 
						       disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="530" onblur="popularValueToHiddenElement();"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.ingStatementNumber}"
							   styleId="ingStatementNumber" id="ingStatementNumber"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<form:hidden path="productVO.scaleVO.ingStatementNumber" id="ingStatementNumberHidden"/>
			</td>
			<td align="right" width="10%" nowrap="nowrap">
				<label class="labelFont helpable" id="NutritionStatementNumberLabel">Nutrition Statement Number</label>
			</td>
			<td align="left" width="20%">
				<cps:renderByResourceAccess resourceId="185" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<input value="${addNewCandidate.productVO.scaleVO.nutStatementNumber}" id="nutStatementNumber"
							   cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="531" maxlength="7" onblur="popularValueToHiddenElement();"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.nutStatementNumber}"
							   styleId = "nutStatementNumber" id="nutStatementNumber" disabled="true"
							   cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="531" maxlength="7" onblur="popularValueToHiddenElement();"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="addNewCandidate.productVO.scaleVO.nutStatementNumber"
							   styleId = "nutStatementNumber" id="nutStatementNumber"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<form:hidden path="productVO.scaleVO.nutStatementNumber" id="nutStatementNumberHidden"/>
			</td>
			<td align="right" width="10%" nowrap="nowrap">
				<label class="labelFont helpable" id="GradeNumberLabel">Grade number</label>
			</td>
			<td align="left" width="25%">
				<cps:renderByResourceAccess resourceId="253" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<input value="${addNewCandidate.productVO.scaleVO.gradeNbr}" id="gradeNbr"
									maxlength="3" size="3" style="dataType : numeric;"
									cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
									onblur="JavaScript:validateScaleFields();popularValueToHiddenElement();" tabindex="540"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.gradeNbr}" id="gradeNbr"
									maxlength="3" size="3" style="dataType : numeric;" disabled="true"
									cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
									onblur="JavaScript:validateScaleFields();popularValueToHiddenElement();" tabindex="540"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.gradeNbr}" styleId="gradeNbr" id="gradeNbr"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<form:hidden path="productVO.scaleVO.gradeNbr" id="gradeNbrHidden"/>
			</td>
			<td colspan="1">&nbsp;</td>
		</tr>
		<tr>
			<td align="right" width="19%" nowrap="nowrap">
				<label class="labelFont helpable" id="EnglishDescLine1Label">
					English Label Description Line 1<em id="engDescLine1Required" style="color:red"><b>*</b></em>
				</label>
			</td>
			<td align="left" width="5%">
				<cps:renderByResourceAccess resourceId="246" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<input value="${addNewCandidate.productVO.scaleVO.engDescLine1}" id="engDescLine1"
									cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
									style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;" maxlength="32"
									size="30" onblur="switchToUpperCase(this); popularValueToHiddenElement(); return true;" tabindex="532"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.engDescLine1}" styleId="engDescLine1" id="engDescLine1"
							   disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
							   style="TEXT-TRANSFORM: uppercase; dataType: alphanumericSpecial;" maxlength="32" size="30" 
							   onblur="switchToUpperCase(this); popularValueToHiddenElement(); return true;" tabindex="532"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.engDescLine1}" id="engDescLine1"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>				
				<form:hidden path="productVO.scaleVO.engDescLine1" id="engDescLine1Hidden"/>
			</td>
			<td rowspan="5" colspan="2" align="right" width="25%" nowrap="nowrap">
				<fieldset>
					<legend style="font-weight: bold;">Bilingual Label</legend>
					<table width="100%">
						<tr>
							<td align="left" width="19%" nowrap="nowrap">
								<label class="labelFont helpable" id="EnglishDesc1Label">Description English 1 &nbsp;</label>
							</td>
							<td align="left" width="5%">
								<cps:renderByResourceAccess resourceId="246" honorViewMode="${addNewCandidate.scaleViewOverRide}">
									<jsp:attribute name="EDIT">
										<input value="${addNewCandidate.productVO.scaleVO.engDesc1}" id="engDesc1"
											   cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
													style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;"
													maxlength="32" size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true; "
													tabindex="536"/>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input value="${addNewCandidate.productVO.scaleVO.engDesc1}" id="engDesc1"
											   disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
											   style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;"
											   maxlength="32" size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;"
											   tabindex="536"/>
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="hidden" value="${addNewCandidate.productVO.scaleVO.engDesc1}" styleId="engDesc1"
											   id="engDesc1"/>
									</jsp:attribute>
								</cps:renderByResourceAccess>
								<form:hidden path="productVO.scaleVO.engDesc1" id="engDesc1Hidden"/>
							</td>
						</tr>
						<tr>
							<td align="left" width="19%" nowrap="nowrap">
								<label class="labelFont helpable" id="EnglishDesc1Label">Description English 2 &nbsp;</label>
							</td>
							<td align="left" width="5%">
								<cps:renderByResourceAccess resourceId="246" honorViewMode="${addNewCandidate.scaleViewOverRide}">
									<jsp:attribute name="EDIT">
										<input value="${addNewCandidate.productVO.scaleVO.engDesc2}" id="engDesc2"
													cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
													style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;"
													maxlength="32" size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;"
													tabindex="537"/>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input value="${addNewCandidate.productVO.scaleVO.engDesc2}" styleId="engDesc2" id="engDesc2"
											   disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
											   style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;"
											   maxlength="32" size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;"
											   tabindex="537"/>
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="hidden" value="${addNewCandidate.productVO.scaleVO.engDesc2}" styleId="engDesc2"
											   id="engDesc2"/>
									</jsp:attribute>
								</cps:renderByResourceAccess>
								<form:hidden path="productVO.scaleVO.engDesc2" id="engDesc2Hidden"/>
							</td>
						</tr>
						<tr>
							<td align="left" width="19%" nowrap="nowrap">
								<label class="labelFont helpable" id="SpanishDesc1Label">Description Spanish 1 &nbsp;</label>
							</td>
							<td align="left" width="5%">
								<cps:renderByResourceAccess resourceId="246" honorViewMode="${addNewCandidate.scaleViewOverRide}">
									<jsp:attribute name="EDIT">
										<input value="${addNewCandidate.productVO.scaleVO.spaDescLine1}" id="spaDescLine1"
													cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
													style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;"
													maxlength="32" size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;"
													tabindex="538"/>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input value="${addNewCandidate.productVO.scaleVO.spaDescLine1}" styleId="spaDescLine1"
											   id="spaDescLine1" disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
											   style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;"
											   maxlength="32" size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;"
											   tabindex="538"/>
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="hidden" value="${addNewCandidate.productVO.scaleVO.spaDescLine1}" styleId="spaDescLine1"
											   id="spaDescLine1"/>
									</jsp:attribute>
								</cps:renderByResourceAccess>
								<form:hidden path="productVO.scaleVO.spaDescLine1" id="spaDescLine1Hidden"/>
							</td>
						</tr>
						<tr>
							<td align="left" width="19%" nowrap="nowrap">
								<label class="labelFont helpable" id="SpanishDesc2Label">Description Spanish 2 &nbsp;</label>
							</td>
							<td align="left" width="5%">
								<cps:renderByResourceAccess resourceId="247" honorViewMode="${addNewCandidate.scaleViewOverRide}">
									<jsp:attribute name="EDIT">
										<input value="${addNewCandidate.productVO.scaleVO.spaDescLine2}" id="spaDescLine2"
													cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
													style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;"
													maxlength="32" size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;"
													tabindex="539"/>
									</jsp:attribute>
									<jsp:attribute name="VIEW">
										<input value="${addNewCandidate.productVO.scaleVO.spaDescLine2}" styleId="spaDescLine2"
											   id="spaDescLine2" disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
											   style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;"
											   maxlength="32" size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;"
											   tabindex="539"/>
									</jsp:attribute>
									<jsp:attribute name="NONE">
										<input type="hidden" value="${addNewCandidate.productVO.scaleVO.spaDescLine2}"
											   styleId="spaDescLine2" id="spaDescLine2"/>
									</jsp:attribute>
								</cps:renderByResourceAccess>
								<form:hidden path="productVO.scaleVO.spaDescLine2" id="spaDescLine2Hidden"/>
							</td>
						</tr>
					</table>
				</fieldset>
			</td>
			<td align="right" width="10%" nowrap="nowrap">
				<label class="labelFont helpable" id="NetWeightLabel">Net Weight</label>
			</td>
			<td align="left" width="25%">
				<cps:renderByResourceAccess resourceId="253" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<input value="${addNewCandidate.productVO.scaleVO.netWt}" styleId="netWt" id="netWt" maxlength="10" size="8"
									style="dataType : float;" onkeypress="return validNumPress(event)" 
									cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" onblur="roundValue(this,4);popularValueToHiddenElement();return true;"
									tabindex="541"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.netWt}" styleId="netWt" id="netWt" maxlength="10" size="8"
									style="dataType : float;" onkeypress="return validNumPress(event)" disabled="true"
									cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" onblur="roundValue(this,4);popularValueToHiddenElement();return true;"
									tabindex="541"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.netWt}" styleId="netWt" id="netWt"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<form:hidden path="productVO.scaleVO.netWt" id="netWtHidden"/>
			</td>
			<td colspan="1">&nbsp;</td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap="nowrap">
				<label class="labelFont helpable" id="EnglishDescLine2Label">
					English Label Description Line 2 <em id="engDescLine2Required" style="color:red"><b>*</b></em>
				</label>
			</td>
			<td align="left" width="20%">
				<cps:renderByResourceAccess resourceId="247" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<input value="${addNewCandidate.productVO.scaleVO.engDescLine2}" styleId="engDescLine2" id="engDescLine2"
									cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
									style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;" maxlength="32"
									size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;" tabindex="533"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.engDescLine2}" styleId="engDescLine2" id="engDescLine2"
							   cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
							   style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;" maxlength="32"
							   size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;" tabindex="533"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.engDescLine2}" styleId="engDescLine2"
							   id="engDescLine2"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<form:hidden path="productVO.scaleVO.engDescLine2" id="engDescLine2Hidden"/>
			</td>
			<td align="right" width="10%" nowrap="nowrap">
				<label class="labelFont helpable" id="MechTenzFlag">Mechanically Tenderized</label>
			</td>
			<td align="left" width="20%">
				<cps:renderByResourceAccess resourceId="246" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<c:choose>
							<c:when test="${addNewCandidate.productVO.scaleVO.mechTenz}">
								<input type="checkbox" checked="checked" value="${addNewCandidate.productVO.scaleVO.mechTenz}" id="mechTenz"
									   cssClass="mtGroup mtGroup1 mtGroup2" onclick="popularValue(this);popularValueToHiddenElement();" tabindex="542"/>
							</c:when>
							<c:otherwise>
								<input type="checkbox" value="${addNewCandidate.productVO.scaleVO.mechTenz}" id="mechTenz"
									   cssClass="mtGroup mtGroup1 mtGroup2" onclick="popularValue(this);popularValueToHiddenElement();" tabindex="542"/>
							</c:otherwise>
						</c:choose>						
					</jsp:attribute>
					<jsp:attribute name="VIEW">						
							   <c:choose>
							<c:when test="${addNewCandidate.productVO.scaleVO.mechTenz}">								
							<input type="checkbox" checked="checked" value="${addNewCandidate.productVO.scaleVO.mechTenz}" disabled="true" id="mechTenz" cssClass="mtGroup mtGroup1 mtGroup2"
							 onclick="popularValue(this);popularValueToHiddenElement();" tabindex="542"/>
							</c:when>
							<c:otherwise>
								<input type="checkbox" value="${addNewCandidate.productVO.scaleVO.mechTenz}" disabled="true" id="mechTenz" cssClass="mtGroup mtGroup1 mtGroup2"
							 onclick="popularValue(this);popularValueToHiddenElement();" tabindex="542"/>
							</c:otherwise>
						</c:choose>
					</jsp:attribute>
					<jsp:attribute name="NONE">						
							   <c:choose>
							<c:when test="${addNewCandidate.productVO.scaleVO.mechTenz}">
								<input type="checkbox" checked="checked" value="${addNewCandidate.productVO.scaleVO.mechTenz}"
							   id="mechTenz" style="visibility: hidden"/>
							</c:when>
							<c:otherwise>
								<input type="checkbox" value="${addNewCandidate.productVO.scaleVO.mechTenz}"
							   id="mechTenz" style="visibility: hidden"/>
							</c:otherwise>
						</c:choose>							   
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<form:hidden path="productVO.scaleVO.mechTenz" id="mechTenzHidden"/>
			</td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap="nowrap">
				<label class="labelFont helpable" id="EnglishDescLine3Label">English Label Description Line 3 &nbsp;</label>
			</td>
			<td align="left" width="20%">
				<cps:renderByResourceAccess resourceId="246" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<input value="${addNewCandidate.productVO.scaleVO.engDescLine3}" id="engDescLine3"
									cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
									style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;" maxlength="32"
									size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;" tabindex="534"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.engDescLine3}" styleId="engDescLine3" id="engDescLine3"
							   disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
							   style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;" maxlength="32"
							   size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;" tabindex="534"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.engDescLine3}" styleId="engDescLine3"
							   id="engDescLine3"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>				
				<form:hidden path="productVO.scaleVO.engDescLine3" id="engDescLine3Hidden"/>
			</td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap="nowrap">
				<label class="labelFont helpable" id="EnglishDescLine4Label">English Label Description Line 4 &nbsp;</label>
			</td>
			<td align="left" width="20%">
				<cps:renderByResourceAccess resourceId="246" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<input value="${addNewCandidate.productVO.scaleVO.engDescLine4}" id="engDescLine4"
									cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
									style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;" maxlength="32"
									size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;" tabindex="535"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.engDescLine4}" styleId="engDescLine4" id="engDescLine4"
							   disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
							   style="TEXT-TRANSFORM: uppercase;dataType: alphanumericSpecial;" maxlength="32"
							   size="30" onblur="switchToUpperCase(this);popularValueToHiddenElement();return true;" tabindex="535"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.engDescLine4}"
							   styleId="engDescLine4" id="engDescLine4"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<form:hidden path="productVO.scaleVO.engDescLine4" id="engDescLine4Hidden"/>
			</td>
		</tr>
		<tr>
			&nbsp;
		</tr>
		<tr>
			<td align="right" width="19%" nowrap="nowrap">
				<label class="labelFont helpable" id="PrePackTareLabel">
					Pre-pack Tare<em id="prePackRequired" style="color:red"><b>*</b></em>
				</label>
			</td>
			<td align="left" width="5%" >
				<cps:renderByResourceAccess resourceId="253" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<input value="${addNewCandidate.productVO.scaleVO.prePackTare}" id="prePackTare"
									cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" maxlength="5"
									onblur="JavaScript:validateScaleFields();popularValueToHiddenElement();" tabindex="543"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.prePackTare}" styleId="prePackTare" id="prePackTare"
							   disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" maxlength="5"
							   onblur="JavaScript:validateScaleFields();popularValueToHiddenElement();" tabindex="543"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.prePackTare}" styleId="prePackTare"
							   id="prePackTare"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<form:hidden path="productVO.scaleVO.prePackTare" id="prePackTareHidden"/>
			</td>
			<td align="right" width="10%" nowrap="nowrap">
				<label class="labelFont helpable" id="ServiceCounterTareLabel">Service Counter Tare</label>
			</td>
			<td align="left" width="20%">
				<cps:renderByResourceAccess resourceId="251" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:input path="productVO.scaleVO.serviceCounterTare"  id="serviceCounterTare"
									maxlength="5" size="8" style="dataType : float;" onkeypress="return validNumPress(event)"
									cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
									onblur="roundValue(this,3);return true;" tabindex="544"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.serviceCounterTare}" styleId = "serviceCounterTare"
									id="serviceCounterTare" disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="544"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.serviceCounterTare}" styleId="serviceCounterTare"
							   id="serviceCounterTare"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="10%" nowrap="nowrap">
				<label class="labelFont helpable" id="ForceTareLabel">Force Tare</label>
			</td>
			<td align="left" width="25%">
				<cps:renderByResourceAccess resourceId="252" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:select path="productVO.scaleVO.forceTare" style="dataType : alpha;" id="forceTare"
									 styleId="forceTare" tabindex="545">
							<form:options items="${addNewCandidate.yesNoList}" itemLabel="name"	itemValue="id" />
						</form:select>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.forceTare}" styleId = "forceTare" id="forceTare"
							   disabled="true"
									tabindex="545"/>
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.forceTare}" styleId="forceTare" id="forceTare"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.forceTare}" styleId="forceTare" id="forceTare"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
		</tr>
		<tr>
			<td align="right" width="19%" nowrap="nowrap">
				<label class="labelFont helpable" id="ShelfLifeDaysLabel">
					Shelf Life Days<em id="shelfLifeDaysRequired" style="color:red"><b>*</b></em>
				</label>
			</td>
			<td align="left" width="15%">
				<cps:renderByResourceAccess resourceId="250" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<input value="${addNewCandidate.productVO.scaleVO.shelfLifeDays}" id="shelfLifeDays"
									cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
									onblur="JavaScript:validateScaleFields();popularValueToHiddenElement();" tabindex="546"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.shelfLifeDays}" styleId="shelfLifeDays" id="shelfLifeDays"
							   disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5"
							   onblur="JavaScript:validateScaleFields();popularValueToHiddenElement();" tabindex="546"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.shelfLifeDays}" styleId="shelfLifeDays"
							   id="shelfLifeDays"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<form:hidden path="productVO.scaleVO.shelfLifeDays" id="shelfLifeDaysHidden"/>				
			</td>
			<td align="right" width="10%" nowrap="nowrap">
				<label class="labelFont helpable" id="ActionCodeLabel">Action Code</label>
			</td>
			<td align="left" width="20%">
				<cps:renderByResourceAccess resourceId="183" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<cps:autoComplete2 zi="9046"
										   forceSelection="true" jsonSearchMethodName="actionCodeSearch"
										   autoHighlight="true" uniqueId="actionCode" tabindex="547"
										   strutsHiddenElmProperty="productVO.scaleVO.actionCode"
										   onSelectMethod="actionCodeChange" style="width:95%;position:absolute;top:-10px"/>
						</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.actionCode}" styleId="actionCodeACInput" id="actionCodeACInput"
									disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="547"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.actionCode}" styleId="actionCodeACInput"
							   id="actionCodeACInput"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="10%" nowrap="nowrap">
				<label class="labelFont helpable" id="GraphicsCodeLabel">Graphics Code</label>
			</td>
			<td align="left" width="25%">
				<cps:renderByResourceAccess resourceId="184" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<cps:autoComplete2 zi="9044" forceSelection="true" jsonSearchMethodName="graphicsCodeSearch"
										   autoHighlight="true" uniqueId="graphicsCode" tabindex="548"
										   strutsHiddenElmProperty="productVO.scaleVO.graphicsCode"
										   onSelectMethod="graphicsCodeChange" style="width:95%;position:absolute;top:-8px"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.graphicsCode}" styleId="graphicsCodeACInput"
							   id="graphicsCodeACInput" disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="548"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.graphicsCode}" styleId="graphicsCodeACInput"
							   id="graphicsCodeACInput"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
		</tr>
		<tr>
			<td align="right" width="19%" nowrap="nowrap">
				<label class="labelFont helpable" id="LabelFormat1Label">Label Format 1</label>&nbsp;
			</td>

			<td align="left" width="5%" >
				<cps:renderByResourceAccess resourceId="248" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<cps:autoComplete2 zi="9044" forceSelection="true" jsonSearchMethodName="labeFormatSearch"
										   autoHighlight="true" uniqueId="labelFormat1" tabindex="549"
										   strutsHiddenElmProperty="productVO.scaleVO.labelFormat1"
										   onSelectMethod="labelFormat1Change" style="width:95%;position:absolute;top:-8px"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.labelFormat1}" styleId="labelFormat1ACInput"
							   id="labelFormat1ACInput" disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="549"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.labelFormat1}" styleId="labelFormat1ACInput"
							   id="labelFormat1ACInput" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="10%" nowrap="nowrap">
				<label class="labelFont helpable" id="LabelFormat2Label">Label Format 2</label>
			</td>
			<td align="left" width="20%">
				<cps:renderByResourceAccess resourceId="249" honorViewMode="${addNewCandidate.scaleViewOverRide}">
					<jsp:attribute name="EDIT">
						<cps:autoComplete2 zi="9044" forceSelection="true" jsonSearchMethodName="labeFormatSearch"
										   autoHighlight="true" uniqueId="labelFormat2" tabindex="550"
										   strutsHiddenElmProperty="productVO.scaleVO.labelFormat2"
										   onSelectMethod="labelFormat2Change" style="width:95%;position:absolute;top:-8px"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<input value="${addNewCandidate.productVO.scaleVO.labelFormat2}" styleId="labelFormat2ACInput"
							   id="labelFormat2ACInput" disabled="true" cssClass="mtGroup mtGroup1 mtGroup2 mtGroup4 mtGroup5" tabindex="550"/>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<input type="hidden" value="${addNewCandidate.productVO.scaleVO.labelFormat2}" styleId="labelFormat2ACInput"
							   id="labelFormat2ACInput"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td colspan="2">&nbsp;</td>
		</tr>
	</table>
	<form:hidden path="productVO.scaleVO.associatedPLUs" id="associatedPLUs"/>
	<form:hidden path="productVO.scaleVO.actionCodeDescWithId"  id="actionCodeDescWithId"/>
	<form:hidden path="productVO.scaleVO.graphicsCodeDescWithId"  id="graphicsCodeDescWithId"/>
	<form:hidden path="productVO.scaleVO.labelFormat1DescWithId"  id="labelFormat1DescWithId"/>
	<form:hidden path="productVO.scaleVO.labelFormat2DescWithId"  id="labelFormat2DescWithId"/>
</fieldset>

<script>
	if (document.getElementById('ingrStmtRequired'))
		document.getElementById('ingrStmtRequired').style.color = 'white';
	if (document.getElementById('engDescLine1Required'))
		document.getElementById('engDescLine1Required').style.color = 'white';
	if (document.getElementById('engDescLine2Required'))
		document.getElementById('engDescLine2Required').style.color = 'white';
	if (document.getElementById('prePackRequired'))
		document.getElementById('prePackRequired').style.color = 'white';
	if (document.getElementById('shelfLifeDaysRequired'))
		document.getElementById('shelfLifeDaysRequired').style.color = 'white';


	<c:if test="${addNewCandidate.userRole eq 'SCMAN' && !addNewCandidate.productVO.onlyCheckerUPC}">
		if(document.getElementById('ingrStmtRequired')){
			document.getElementById('ingrStmtRequired').style.color = 'red';
		}
		if(document.getElementById('engDescLine1Required')){
			document.getElementById('engDescLine1Required').style.color = 'red';
		}
		if(document.getElementById('engDescLine2Required')){
			document.getElementById('engDescLine2Required').style.color = 'red';
		}
	</c:if>
	<c:if test="${addNewCandidate.productVO.scaleUPC && !addNewCandidate.productVO.onlyCheckerUPC &&
				(addNewCandidate.userRole eq 'ADMIN' || addNewCandidate.userRole eq 'PIA' || addNewCandidate.userRole eq 'PIAL')}">
		if(document.getElementById('engDescLine1Required')){
			document.getElementById('engDescLine1Required').style.color = 'red';
		}

		if(document.getElementById('engDescLine2Required')){
			document.getElementById('engDescLine2Required').style.color = 'red';
		}

		if(document.getElementById('prePackRequired')){
			document.getElementById('prePackRequired').style.color = 'red';
		}
		if(document.getElementById('shelfLifeDaysRequired')){
			document.getElementById('shelfLifeDaysRequired').style.color = 'red';
		}
	</c:if>

	function actionCodeChange(evt) {
	}

	function graphicsCodeChange(evt) {
	}

	function ingStatementNumberChange(evt) {
	}

	function nutStatementNumberChange(evt) {
	}

	function labelFormat1Change(evt) {
	}

	function labelFormat2Change(evt) {
	}

	if (document.getElementById('actionCodeACInput')
			&& document.getElementById('actionCodeDescWithId')) {
		document.getElementById('actionCodeACInput').value = document.getElementById('actionCodeDescWithId').value;
	}


	if (document.getElementById('graphicsCodeACInput')
			&& document.getElementById('graphicsCodeDescWithId')) {
		document.getElementById('graphicsCodeACInput').value = document.getElementById('graphicsCodeDescWithId').value;
	}

	if (document.getElementById('labelFormat1ACInput')
			&& document.getElementById('labelFormat1DescWithId')) {
		document.getElementById('labelFormat1ACInput').value = document.getElementById('labelFormat1DescWithId').value;
	}


	if (document.getElementById('labelFormat2ACInput')
			&& document.getElementById('labelFormat2DescWithId')) {
		document.getElementById('labelFormat2ACInput').value = document.getElementById('labelFormat2DescWithId').value;
	}

	if (document.getElementById('forceTareDesc')
			&& document.getElementById('forceTare')) {
		var yesNo = document.getElementById('forceTare').value;
		if (yesNo == '1') {
			document.getElementById('forceTareDesc').value = 'Yes';
		} else {
			document.getElementById('forceTareDesc').value = 'No';
		}
	}

	function validNumPress(evt){
		var charCode = (evt.which) ? evt.which : event.keyCode;
		var target = evt.target || evt.srcElement;
		if(charCode == 8) return true;
		if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
			return false;
		var indexOfDot = target.value.indexOf('.');
		var check = indexOfDot != -1;
		if(check && charCode == 46){
			return false;
		}
		return true;
	}

	function validateScaleFields() {
			var prePackTare = document.getElementById('prePackTare');
			if (null != prePackTare && prePackTare != undefined) {
				var pptVal = prePackTare.value;
				if(isNaN(pptVal)){
					alert("Pre-pack Tare should be a number");
					document.getElementById('prePackTare').value = '';
					document.getElementById('prePackTare').focus();
				}else{
					var takePreNum = parseFloat(pptVal);
					if(takePreNum > 3){
						alert("Pre-pack Tare cannot be more than 3.0");
						document.getElementById('prePackTare').value = '';
						document.getElementById('prePackTare').focus();
					}
				}
			}

			if (document.getElementById('shelfLifeDays')) {
				var sldVal = document.getElementById('shelfLifeDays').value;
				if(isNaN(sldVal)){
					alert("Shelf Life Days should be a number");
					document.getElementById('shelfLifeDays').value = '';
					document.getElementById('shelfLifeDays').focus();
				}else{
					if (sldVal > 999) {
						alert("Shelf Life Days cannot be more than 999");
						document.getElementById('shelfLifeDays').value = '';
						document.getElementById('shelfLifeDays').focus();
					}
				}
			}
			/*
			 * added by HoangVT: validation for grade number, net weight
			 * date: 27.May.2010
			 * Enhancement: new scale fields [defect 1013]
			 */
			if (document.getElementById('netWt')) {
				var netWtVal = document.getElementById('netWt').value;
				if(isNaN(netWtVal)){
					alert("Net weight should be a number");
					document.getElementById('netWt').value = '';
					document.getElementById('netWt').focus();
				}else{
					if (netWtVal > 999999999) {
						alert("Net weight cannot be more than 999999999");
						document.getElementById('netWt').value = '';
						document.getElementById('netWt').focus();
					}
					if (netWtVal < 0) {
						alert("Net weight cannot be negative number");
						document.getElementById('netWt').value = '';
						document.getElementById('netWt').focus();
					}
				}
			}


			if (document.getElementById('serviceCounterTare')) {
				var netWtVal = document.getElementById('serviceCounterTare').value;
				if(isNaN(netWtVal)){
					alert("Service Counter Tare should be a number");
					document.getElementById('serviceCounterTare').value = '';
					document.getElementById('serviceCounterTare').focus();
				}else{
					if (netWtVal > 9999) {
						alert("Service Counter Tare cannot be more than 9999");
						document.getElementById('serviceCounterTare').value = '';
						document.getElementById('serviceCounterTare').focus();
					}
					if (netWtVal < 0) {
						alert("Service Counter Tare cannot be negative number");
						document.getElementById('serviceCounterTare').value = '';
						document.getElementById('serviceCounterTare').focus();
					}
				}
			}
			if (document.getElementById('gradeNbr')) {
				var gradeNbrVal = document.getElementById('gradeNbr').value;
				if(isNaN(gradeNbrVal)){
					alert("Grade number should be a number");
					document.getElementById('gradeNbr').value = '';
					document.getElementById('gradeNbr').focus();
				}else{
					if (gradeNbrVal > 999) {
						alert("Grade number cannot be more than 999");
						document.getElementById('gradeNbr').value = '';
						document.getElementById('gradeNbr').focus();
					}
					else{
						if (gradeNbrVal < 0) {
							alert("Grade number cannot be negative number");
							document.getElementById('gradeNbr').value = '';
							document.getElementById('gradeNbr').focus();
						}
						else{
							if (!(/^\d+$/.test(gradeNbrVal)) & gradeNbrVal.length > 0){
								alert("Grade number must be integer number");
								document.getElementById('gradeNbr').value = '';
								document.getElementById('gradeNbr').focus();
							}
						}
					}
				}
			}
	}

	function popularValue(element){
		var engDescLine4 = document.getElementById("engDescLine4");
		var engDesc2 = document.getElementById("engDesc2");
		if(element.checked == true){
			if(null != engDescLine4 && engDescLine4 != undefined){
				engDescLine4.value = "Mechanically Tenderized";
			}
			if(null != engDesc2 && engDesc2 != undefined){
				engDesc2.value = "Mechanically Tenderized";
			}
		}
	}

	function validBasedOnMech(){
		var engDescLine4 = document.getElementById("engDescLine4");
		var engDesc2 = document.getElementById("engDesc2");
		var mechTenz = document.getElementById("mechTenz");
		if((null != engDescLine4 && engDescLine4 != undefined) && (null != engDescLine4 && engDescLine4 != undefined) && (null != mechTenz && mechTenz != undefined)){
			if(myTrim(engDescLine4.value) == "" && mechTenz.checked == true && myTrim(engDesc2.value) == ""){
				mechTenz.checked = false;
			}
		}
	}
	
	function popularValueToHiddenElement(){
		document.getElementById('ingStatementNumberHidden').value	=  	getValue(document.getElementById('ingStatementNumber'));		
		document.getElementById('nutStatementNumberHidden').value	=  	getValue(document.getElementById('nutStatementNumber'));				
		document.getElementById('gradeNbrHidden').value	= getValue(document.getElementById('gradeNbr'));
		document.getElementById('engDescLine1Hidden').value	= getValue(document.getElementById('engDescLine1'));
		document.getElementById('engDesc1Hidden').value	= getValue(document.getElementById('engDesc1'));
		document.getElementById('engDesc2Hidden').value	= getValue(document.getElementById('engDesc2'));
		document.getElementById('spaDescLine1Hidden').value	= getValue(document.getElementById('spaDescLine1'));
		document.getElementById('spaDescLine2Hidden').value	= getValue(document.getElementById('spaDescLine2'));
		document.getElementById('netWtHidden').value	= getValue(document.getElementById('netWt'));
		document.getElementById('engDescLine2Hidden').value	= getValue(document.getElementById('engDescLine2'));	
		document.getElementById('mechTenz').value = document.getElementById('mechTenz').checked
		document.getElementById('mechTenzHidden').value	= document.getElementById('mechTenz').checked;
		document.getElementById('engDescLine3Hidden').value	= getValue(document.getElementById('engDescLine3'));
		document.getElementById('engDescLine4Hidden').value	= getValue(document.getElementById('engDescLine4'));
		document.getElementById('prePackTareHidden').value	= getValue(document.getElementById('prePackTare'));
		document.getElementById('shelfLifeDaysHidden').value	= getValue(document.getElementById('shelfLifeDays'));
    }
	
	function getValue(obj){
        if (obj){
            return obj.value;
        } else {
            return null;
        }
    }
</script>