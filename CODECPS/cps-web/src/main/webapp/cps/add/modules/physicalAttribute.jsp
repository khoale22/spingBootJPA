<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="/WEB-INF/functions.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<a id="sec3tion"></a>
<fieldset style="width: 95%;">
	<legend class="legendFont">Merchandising Attribute </legend>
	<table width="100%" border="0" cellspacing="3" bordercolor="red">
		<tr>		
			<td align="right" width="19%">
				<cps:renderByResourceAccess resourceId="262" honorViewMode="${addNewCandidate.packagingViewOverRide}">
					<jsp:attribute name="EDIT">
						<label for="selectedChannel" class="labelFont helpable" id="styleLabel">Style</label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label for="selectedChannel" class="labelFont helpable" id="styleLabel">Style</label>
					</jsp:attribute>
				</cps:renderByResourceAccess>				
			</td>
			<td align="left" width="5%">&nbsp;&nbsp;
				<cps:renderByResourceAccess resourceId="262" honorViewMode="${addNewCandidate.packagingViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:input path="productVO.physicalAttributeVO.style" maxlength="20" size="" tabindex="44"
								cssClass="textFieldNormal" id="style" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.physicalAttributeVO.style" disabled="true" id="style"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>		
			<td align="right" width="29%">
				<cps:renderByResourceAccess resourceId="263" honorViewMode="${addNewCandidate.packagingViewOverRide}">
					<jsp:attribute name="EDIT">
						<label for="selectedChannel" class="labelFont helpable" id="modelLabel">Model</label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label for="selectedChannel" class="labelFont helpable" id="modelLabel">Model</label>
					</jsp:attribute>
				</cps:renderByResourceAccess>						
			</td>
			<td align="left" width="5%">&nbsp;&nbsp;
				<cps:renderByResourceAccess resourceId="263" honorViewMode="${addNewCandidate.packagingViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:input path="productVO.physicalAttributeVO.model"
									cssClass="textFieldNormal mtGroup mtGroup1 mtGroup4" maxlength="20" size=""
									tabindex="45" id="model"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.physicalAttributeVO.model" disabled="true" id="model"
									cssClass="mtGroup mtGroup1 mtGroup4"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="28%">
			<cps:renderByResourceAccess resourceId="264" honorViewMode="${addNewCandidate.packagingViewOverRide}">
					<jsp:attribute name="EDIT">
						<label for="selectedChannel" class="labelFont helpable" id="color">Color</label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label for="selectedChannel" class="labelFont helpable" id="color">Color</label>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left" width="5%">
				<cps:renderByResourceAccess resourceId="264">
					<jsp:attribute name="EDIT">
						<form:input path="productVO.physicalAttributeVO.color"
									cssClass="textFieldNormal mtGroup mtGroup1 mtGroup4" maxlength="10" size=""
									tabindex="46" id="color"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.physicalAttributeVO.color" disabled="true" id="color"
									cssClass="mtGroup mtGroup1 mtGroup4" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>			
		</tr>		
	</table>
</fieldset>