<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>    
<a id="sec2tion"></a>
<fieldset style="width: 95%;">
	<legend class="legendFont">Merchandising Attribute </legend>
	<table width="100%" cellspacing="3" border="0" bordercolor="red">
		<tr>
			<td colspan="1" width="1%"></td>
			<td align="right" width="16%"><label for="selectedChannel" class="labelFont">Brand <em>*</em></label></td>
			<td align="left" width="17%">&nbsp;&nbsp;
						
	<cps:autoComplete2 
		forceSelection="true" 
		jsonSearchMethodName="brandSearch" 
		autoHighlight="true" 
		uniqueId="brand" 
		tabindex="200"
		strutsHiddenElmProperty="productVO.merchandisingAttributesVO.brand"
		onSelectMethod="brandChange"
		/>		
			
			</td>
			<td>&nbsp;</td>
			<td align="right" width="15%"><label for="selectedChannel" class="labelFont">Sub Brand </label></td>
			<td align="left" width="15%">&nbsp;&nbsp;
					
	
				<cps:autoComplete2 
					forceSelection="false" 
					jsonSearchMethodName="subBrandSearch" 
					autoHighlight="false" 
					uniqueId="subbrand" 
					tabindex="210"
					strutsHiddenElmProperty="productVO.merchandisingAttributesVO.subBrand"
				/>
				
	
			
			</td>
			<td align="left" width="2%">&nbsp;</td>
			<td align="right" width="15%">
			<div>		 
			<button type="button" id="reqAttribute" name="button1" value="requestnewattribute">Request new attribute</button> 
			</div>
			<%--  
			<cps:buttonImg imageOver="/hebAssets/images/newButtons/request_mouseclick.gif" 
				image="/hebAssets/images/newButtons/request_normal.gif" uniqueId="reqAttribute" tabIndex="22" ></cps:buttonImg>
				
			--%>
			</td>
			<td align="left" width="13%">&nbsp;</td>
		</tr>
	</table>
	</fieldset>
	
<script type="text/javascript">
var oPushButton1 = new YAHOO.widget.Button("reqAttribute");

	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("reqAttribute"), "click", reqAttribute);
	<c:url value="/protected/cps/add/requestNewAtt?${_csrf.parameterName}=${_csrf.token}" var="page50" />
	function reqAttribute(evt){	
		f1('${page50}'+'&t='+new Date().getTime(),'Request New Attribute','200px','62%','130px','200px');
	}

<c:if test= "${addNewCandidate.search}" >
//document.getElementById('costOwners').disabled = true;
document.getElementById('subBrand').disabled = true;
document.getElementById('brands').disabled = true;
//document.getElementById('countriesOfOrigin').disabled = true;
//document.getElementById('topToTops').disabled = true;
//document.getElementById('channelSelect').disabled = true;
//document.getElementById('seasonalityYear').disabled = true;
</c:if>

function brandChange(evt){
	var brand = YAHOO.util.Dom.get("brandStrutsHiddenElm");
	AddCandidateTemp.updateCostOwnerAndBrand(brand.value,getDWRCallbackMethod(null));
}
</script>