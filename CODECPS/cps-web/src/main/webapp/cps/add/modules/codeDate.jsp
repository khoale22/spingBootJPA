<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<a id="sec3tion"></a>
<fieldset style="width: 95%;">
	<legend class="legendFont">Code Date</legend>
	<table width="100%">
		<tr>
		<td width="100%" colspan="2"> 		
		<table width="100%">
		<tr>
			<td width="9%" align="right">
				<cps:renderByResourceAccess	resourceId="105"  honorViewMode="${CPSForm.upcViewOverRide}">
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
				<cps:renderByResourceAccess	resourceId="105"  honorViewMode="${CPSForm.upcViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:checkbox path="productVO.codeDateVO.codeDate" id="codeDate"
							tabindex="105" onclick="checkedCodeDate();"></form:checkbox>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:checkbox path="productVO.codeDateVO.codeDate" id="codeDate"
							tabindex="105" disabled="true"></form:checkbox>
					</jsp:attribute>
					<jsp:attribute name="NONE">
						<form:checkbox path="productVO.codeDateVO.codeDate" id="codeDate"
						tabindex="105" style="display:none;"></form:checkbox>
					</jsp:attribute>
			</cps:renderByResourceAccess>
			</td>
		</tr>
		</table>		
		</td>
	</tr> <!-- 4th ROW ENDS -->
	<tr>
		
		<td width="100%" colspan="2">		
		<div id="codeDateDiv" style="display: none;">
		<table width="100%">
		<tr align="left">
			<td align="right" width="13%">
				<cps:renderByResourceAccess	resourceId="106"  honorViewMode="${CPSForm.upcViewOverRide}">
					<jsp:attribute name="EDIT">
						<label class="labelFont helpable" id="MaxShelfLabel">Max Shelf Life Days<em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label class="labelFont helpable" id="MaxShelfLabel">Max Shelf Life Days<em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left" width="10%">&nbsp; 
				<cps:renderByResourceAccess	resourceId="106"  honorViewMode="${CPSForm.upcViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:input path="productVO.codeDateVO.maxShelfLifeDays"
							cssClass="textFieldSmall" maxlength="4" tabindex="110"
							id="shelfDays" style="dataType: numeric;" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.codeDateVO.maxShelfLifeDays"
							cssClass="textFieldSmall" maxlength="4" tabindex="110"
							id="shelfDays" style="dataType: numeric;" disabled="true" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="17%">
				<cps:renderByResourceAccess	resourceId="107"  honorViewMode="${CPSForm.upcViewOverRide}">
					<jsp:attribute name="EDIT">
						<label class="labelFont helpable" id="InboundLabel">Inbound Specification Days<em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label class="labelFont helpable" id="InboundLabel">Inbound Specification Days<em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left" width="10%">&nbsp;
				<cps:renderByResourceAccess	resourceId="107"  honorViewMode="${CPSForm.upcViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:input path="productVO.codeDateVO.inboundSpecificationDays"
								cssClass="textFieldSmall" maxlength="4" tabindex="115"
								id="inboundDays" style="dataType: numeric;" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.codeDateVO.inboundSpecificationDays"
							cssClass="textFieldSmall" maxlength="4" tabindex="115"
							id="inboundDays" style="dataType: numeric;" disabled="true" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="10%">
				<cps:renderByResourceAccess	resourceId="108"  honorViewMode="${CPSForm.upcViewOverRide}">
					<jsp:attribute name="EDIT">
						<label class="labelFont helpable" id="ReactionLabel">Reaction	Days <em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label class="labelFont helpable" id="ReactionLabel">Reaction	Days <em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left" width="10%">&nbsp;
				<cps:renderByResourceAccess	resourceId="108"  honorViewMode="${CPSForm.upcViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:input path="productVO.codeDateVO.reactionDays"
							cssClass="textFieldSmall" maxlength="4" tabindex="120"
							id="reactionDays" style="dataType: numeric;" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.codeDateVO.reactionDays"
							cssClass="textFieldSmall" maxlength="4" tabindex="120"
							id="reactionDays" style="dataType: numeric;" disabled="true" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="17%">
				<cps:renderByResourceAccess	resourceId="109"  honorViewMode="${CPSForm.upcViewOverRide}">
					<jsp:attribute name="EDIT">
						<label class="labelFont helpable" id="GuranteeLabel">Guarantee to Store Days<em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<label class="labelFont helpable" id="GuranteeLabel">Guarantee to Store Days<em><font color="red"><b>*</b></font></em></label>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="left" width="10%">&nbsp;
				<cps:renderByResourceAccess	resourceId="109"  honorViewMode="${CPSForm.upcViewOverRide}">
					<jsp:attribute name="EDIT">
						<form:input path="productVO.codeDateVO.guaranteetoStoreDays"
							cssClass="textFieldSmall" maxlength="4" tabindex="125"
							id="guaranteestoreDays" style="dataType: numeric;" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.codeDateVO.guaranteetoStoreDays"
							cssClass="textFieldSmall" maxlength="4" tabindex="125"
							id="guaranteestoreDays" style="dataType: numeric;"
							disabled="true" />					
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
		</tr>
	</table>	
	</div>
	</td>
	
	</tr><!--  5th ROW ENDS -->
	</table>
</fieldset>
<script type="text/javascript">
function checkedCodeDate(){
	boxChecked = document.getElementById("codeDate").checked;
	//var cont;
	var codeDateDiv = YAHOO.util.Dom.get("codeDateDiv");
	if(boxChecked){
		codeDateDiv.style.display = 'block';		
	}else{
		if(document.getElementById("shelfDays")){
			document.getElementById("shelfDays").value = "";
		}
		if(document.getElementById("inboundDays")){
			document.getElementById("inboundDays").value = "";
		}
		if(document.getElementById("reactionDays")){
			document.getElementById("reactionDays").value = "";
		}
		if(document.getElementById("guaranteestoreDays")){
			document.getElementById("guaranteestoreDays").value = "";
		}
		codeDateDiv.style.display = 'none';	
	}
}
function validCodeDate(){
	if((document.getElementById('codeDate') && document.getElementById('codeDate').checked) 
		&& document.getElementById('shelfDays') 
		&& document.getElementById('inboundDays')){
		var shelfDaysval = document.getElementById('shelfDays').value; 
		if(shelfDaysval == "" || shelfDaysval == null){
			showMessage('Please enter Max Shelf Life Days');
			return false;
		}
		else if(!isNaN(shelfDaysval) && parseInt(shelfDaysval,10) > 3650 ){
		showMessage('Max Shelf Life Days must be within the range 0-3650 days');
		return false;
		} else if(parseInt(shelfDaysval,10)<0){
			showMessage('Max Shelf Life Days must be numeric and greater than zero');
			return false;
		}
		
		inboundDaysval = document.getElementById('inboundDays').value; 
		
		if(inboundDaysval == "" || inboundDaysval == null){
			showMessage('Please enter Inbound Specification Days');
			return false;
		}
		else if (!isNaN(inboundDaysval) && parseInt(inboundDaysval,10) <= 0){
		showMessage('Inbound Specification Days must be greater than zero');
		return false;
		}
		else if (!isNaN(inboundDaysval) && parseInt(inboundDaysval,10) >= parseInt(shelfDaysval,10)){
		showMessage('Inbound Specification Days must be less than Max Shelf Life Days ');
		return false;
		}
		
		if(document.getElementById('reactionDays')){
			reactionDaysval = document.getElementById('reactionDays').value; 
			
			if(reactionDaysval == "" || reactionDaysval == null){
				showMessage('Please enter Reaction Days');
				return false;
			}
			else if (!isNaN(reactionDaysval) && parseInt(reactionDaysval,10) <=0){
			showMessage('Reaction Days must be greater than zero');
			return false;
			}
			else if (!isNaN(reactionDaysval) && parseInt(reactionDaysval,10) >= parseInt(inboundDaysval,10)){
			showMessage('Reaction Days must be less than Inbound Specification Days ');
			return false;
			}
		}
		
		if(document.getElementById('guaranteestoreDays')){
			guaranteestoreDaysval = document.getElementById('guaranteestoreDays').value;
			
			if(guaranteestoreDaysval == "" || guaranteestoreDaysval == null){
				showMessage('Please enter Guarantee to Store Days');
				return false;
			}
			else if (!isNaN(guaranteestoreDaysval) && parseInt(guaranteestoreDaysval,10) <=0){
			showMessage('Guarantee to Store Days must be greater than zero');
			return false;
			}
			else if (!isNaN(guaranteestoreDaysval) && parseInt(guaranteestoreDaysval,10) >= parseInt(reactionDaysval ,10)){
			showMessage('Guarantee to Store Days must be less than Reaction Days ');
			return false;
			}
		}
		return true;
	}else{
		return true;
	}
}
function doWhenInitCodeDate()
{
	if(document.getElementById('codeDate').checked)
	{
		var codeDateDiv = YAHOO.util.Dom.get("codeDateDiv");		
		codeDateDiv.style.display = 'block';					
	}
	else
	{
		
	}
}
YAHOO.util.Event.onDOMReady(doWhenInitCodeDate);

</script>