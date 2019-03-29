<%@ tag import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%@attribute name="uniqueId" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="entyId" required="false" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="attrId" required="false" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="attrLabel" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="textid" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="dataType" required="false" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="requireAttr" required="true" rtexprvalue="true" type="java.lang.Boolean"%>
<%@attribute name="containerVar" required="false" rtexprvalue="false"%>
<%@attribute name="selectedValueId" required="false" rtexprvalue="false"%>
<%@attribute name="selectedValueName" required="false"
	rtexprvalue="false"%>
<%@attribute name="width" required="false" rtexprvalue="false"%>
<%@attribute name="onchangeMethod" required="false" rtexprvalue="false"%>
<%@attribute name="index" required="false" rtexprvalue="false"%>
<%@attribute name="tabIndex" required="false" rtexprvalue="false"%>
<%@attribute name="valueDisplay" required="false" rtexprvalue="false"
	description=""%>
<%@attribute name="display" required="false" rtexprvalue="false"%>
<%@attribute name="viewMode" required="false" rtexprvalue="true" type="java.lang.Boolean"%>
<%@attribute name="prcsnNbr" required="false" rtexprvalue="true"%>
<%@attribute name="clearMethod" required="false" rtexprvalue="true"%>
<%@attribute  name="genericHiddenElmName" required="false" rtexprvalue="false" %>
<%@attribute  name="resourceId" required="false" rtexprvalue="false" %>
<%@attribute name="maxLnNbr" required="false" rtexprvalue="true"%>
<%@ tag import="com.heb.jaf.security.UserInfo" %>
<%@ tag import="com.heb.jaf.vo.Resource" %>

<%
	boolean renderView = false;
	
// 	Map<Integer, String> m  = (Map<Integer, String>)jspContext.findAttribute("com.heb.ResourceMap");
	org.springframework.security.core.Authentication auth = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication(); 
	UserInfo hebUserDetails = (UserInfo)auth.getPrincipal();

	Map<Integer, String> m = hebUserDetails.getResourceMap();
	if(m != null){
		if(resourceId != null && resourceId != ""){
			String acs = m.get(Integer.parseInt(resourceId));
			if(acs != null){
				if("ED".equals(acs)){
					renderView = false;
				}
				else if("V".equals(acs)){
					renderView = true;
				}else {
				    renderView = true;
				}
			}
			else{
				renderView = true;
			}
		} else {
			renderView = true;
		}
	}
	else{
		renderView = true;
	}
	
	
	//check for 'view mode'
	if(!renderView && viewMode){
		renderView = true;
	}
	jspContext.setAttribute("renderView", renderView);

%>


<c:set var="valName" value="${selectedValueName}"></c:set>
<c:if test="${selectedValueName == null}">
	<c:set var="valName" value="${attrLabel}valName"></c:set>
</c:if>

<c:set var="prcsnNbrVal" value="${prcsnNbr}"></c:set>


<div id="${uniqueId}OuterDiv"
	style="z-index: ${index};min-width: 0;display: ${display}">


	<div id="${uniqueId}cont">
		<div id="${uniqueId}normalText" style="width: 100%">
			<div
				style="float: left; width: 50%; word-wrap: break-word; padding-right: 5px;"
				align="right">
				${attrLabel}
				<c:if test="${requireAttr == true}">
					<strong class="redAsterisk">*</strong>
				</c:if>
			</div>
			<div style="float: left;">
				<div style="float: left;">
					<input id="${textid}" type="text" value="${valueDisplay}"  maxlength="${maxLnNbr}"
						style="width: 140px;"
						<c:if test="${tabIndex != null}">  tabindex="${tabIndex}"</c:if> 
						<c:if test="${dataType != null && dataType == 'I'}"> onkeypress="return isNumberKey${uniqueId}(event);" onblur="validateNumber${uniqueId}();" </c:if>
						<c:if test="${dataType != null && dataType == 'DEC'}"> onkeypress="return isDecimalKey${uniqueId}(event);" onblur="validateNumber${uniqueId}();" </c:if> 
						<c:if test="${renderView == true}">  disabled</c:if>
						/>
				</div>
			</div>

		</div>

	</div>
	<input type="hidden" id="${valName}" />





	<script type="text/javascript">
	function fillDataForTextInput${uniqueId}(arrAtt) {
		if(arrAtt != null && arrAtt.length > 0){
			var att = arrAtt[0];
			for ( var keyAtt in att) {
				if(keyAtt !="codeId") {
					YAHOO.util.Dom.get('${textid}').value = att[keyAtt];
				}
			}
		}
	}
	
	function isNumberKey${uniqueId}(evt){
		 var charCode = (evt.which) ? evt.which : evt.keyCode;
		 return !(charCode > 31 && (charCode < 48 || charCode > 57));
	}
	
	function isDecimalKey${uniqueId}(evt){
	    var charCode = (evt.which) ? evt.which : event.keyCode;
	    return !(charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57));
	}
	
	function validateNumber${uniqueId}() {
		var req =  YAHOO.util.Dom.get('${textid}').value;
		var numbers = /^\d+$/;
		var decNumber = /^\d*(?:\.\d*)?$/;
		//     /^\d*(?:\.\d{0,2})?$/
		<c:if test="${prcsnNbrVal != null && prcsnNbrVal != 0}">
			var prNbr = '${prcsnNbrVal}';
			decNumber = new RegExp("\^\\d*(?:\\.\\d{0,"+prNbr+"})?$");
		</c:if>
		if(req != null && myTrim(req) != '') {
			<c:if test="${dataType != null}">
			<c:if test="${dataType == 'I'}">
				
				if(isNaN(req) || !numbers.test(req) || (req.indexOf('.') > -1 || req.indexOf('-') > -1)){
					YAHOO.util.Dom.get('${textid}').value = '';
					document.getElementById('${textid}').focus();
					var elm1 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElm"); 
			    	if(elm1!=null){	        		
			    		if(elm1.name.indexOf('${genericHiddenElmName}')<0){
			    			elm1.name="${genericHiddenElmName}."+elm1.name;
			    		}	        		
			    		elm1.value = '';	 		
			    	}	
					alert('${attrLabel} must be a number.');
				}
			</c:if>
			
			<c:if test="${dataType == 'DEC'}">
				if(isNaN(req) || !decNumber.test(req) || (req.split('.').length>2 || req.split('.').length==0 || req.indexOf('-') > -1)){
					YAHOO.util.Dom.get('${textid}').value = '';
					document.getElementById('${textid}').focus();
					var elm1 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElm"); 
			    	if(elm1!=null){	        		
			    		if(elm1.name.indexOf('${genericHiddenElmName}')<0){
			    			elm1.name="${genericHiddenElmName}."+elm1.name;
			    		}	        		
			    		elm1.value = '';	 		
			    	}	
					alert('${attrLabel} must be a decimal value.');
				}
			</c:if>
		
		</c:if>
		}
	}
	
	<c:if test="${clearMethod != null}">
	var ${clearMethod} = function() {
		YAHOO.util.Dom.get('${textid}').value = '';
	};
	</c:if>
	YAHOO.util.Event.on('${textid}','keyup',function (e) { 
		var req =  YAHOO.util.Dom.get('${textid}').value;		
		var elm1 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElm"); 
    	if(elm1!=null){	        		
    		if(elm1.name.indexOf('${genericHiddenElmName}')<0){
    			elm1.name="${genericHiddenElmName}."+elm1.name;
    		}	        		
    		elm1.value = req;	 		
    	}	
	});
	function myTrim(x) {
		return x.replace(/^\s+|\s+$/gm,'');
	}
	</script>


</div>

