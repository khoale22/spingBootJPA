<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@attribute  name="jsonSearchMethodName" required="true" rtexprvalue="false" %>
<%@attribute  name="uniqueId" required="true" rtexprvalue="false" %>
<%@attribute  name="forceSelection" required="true" rtexprvalue="false" %>
<%@attribute  name="addNewLink" required="false" rtexprvalue="false" %>
<%@attribute  name="autoHighlight" required="true" rtexprvalue="false" %>
<%@attribute  name="tabindex" required="false" rtexprvalue="false" %>
<%@attribute  name="strutsHiddenElmProperty" required="false" rtexprvalue="false" %>
<%@attribute  name="onSelectMethod" required="false" rtexprvalue="false" %>
<%@attribute  name="clearMethod" required="false" rtexprvalue="false" %>
<%@attribute  name="strutsHiddenNameElmProperty" required="false" rtexprvalue="false" %>
<%@attribute  name="zi" required="false" rtexprvalue="false" %>
<%@attribute  name="style" required="false" rtexprvalue="false" %>
<%@attribute  name="maxlength" required="false" rtexprvalue="false" %>


<!-- START AUTOCOMPLETE2 TAG -->			


<%--
	if the struts form has a value set for the specified property,
	looks up the user-friendly name associated with that property
	and puts it in the jspContext as 'currentComponentText' 
--%>
<cps:currentComponentValueSubTag 
	strutsHiddenElmProperty="${strutsHiddenElmProperty}"
	uniqueId="${uniqueId}"/>

<c:choose>
	<c:when test="${maxlength != null}">
		<c:set value="maxlength='${maxlength}'" var="realMaxlength"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="" var="realMaxlength"></c:set>
	</c:otherwise>
</c:choose>			
<c:choose>
	<c:when test="${tabindex != null}">
		<c:set value="tabindex='${tabindex}'" var="realTabIndexStr"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="" var="realTabIndexStr"></c:set>
	</c:otherwise>
</c:choose>	
<c:choose>
	<c:when test="${style != null}">
		<c:set value="${style}" var="realTextWidth"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="" var="realTextWidth"></c:set>
	</c:otherwise>
</c:choose>			

<c:choose>
	<c:when test="${strutsHiddenElmProperty != null}">
		<c:set value="${strutsHiddenElmProperty}" var="realStrutsHiddenElmProperty"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="" var="realStrutsHiddenElmProperty"></c:set>
	</c:otherwise>
</c:choose>	

<c:choose>
	<c:when test="${zi != null}">
		<c:set value="${zi}" var="indx"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="8000" var="indx"></c:set>
	</c:otherwise>
</c:choose>		


<c:choose>
	<c:when test="${currentComponentText != null}">
		<c:set value="value='${currentComponentText}'" var="valueText"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="" var="valueText"></c:set>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${addNewLink != null}">
		<c:set value="${addNewLink}" var="newLink"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="false" var="newLink"></c:set>
	</c:otherwise>
</c:choose>
		
<style type="text/css">		
	#${uniqueId}AutoComplete .yui-ac-content {
		max-height:15em;
		overflow:auto;
		overflow-x:hidden;
		_height:15em;
		z-index:${indx};
	}
	#${uniqueId}AutoComplete { 
		z-index:${indx}; 
	} 	
	
	
</style>
			
	<div id="${uniqueId}AutoComplete">
		<input
		id="${uniqueId}ACInput"
		type="text"
		${realTabIndexStr}
		${realMaxlength}
		${valueText}  style="${realTextWidth}"/>
		<div id="${uniqueId}ACContainer"></div>
	</div>


	<c:if test="${strutsHiddenElmProperty != null}">
		<form:hidden path="${strutsHiddenElmProperty}" id="${uniqueId}StrutsHiddenElm"/>
	</c:if>
	<c:if test="${strutsHiddenNameElmProperty != null}">
		<form:hidden path="${strutsHiddenNameElmProperty}" id="${uniqueId}StrutsHiddenNameElm"/>
	</c:if>

	<c:url value="/protected/cps/add/manage/modules/search/backend/ajaxSearch?action=${jsonSearchMethodName}&showId=true&highlightMatch=true&maxResults=100&uniqueId=${uniqueId}&" var="jsonSearch"></c:url>

<script type="text/javascript">
function init${uniqueId}Remote(){

    // Use an XHRDataSource
    var oDS = new YAHOO.util.XHRDataSource("${jsonSearch}", ["resultList", "name"]);
    
    // Set the responseType
    oDS.responseType = YAHOO.util.XHRDataSource.TYPE_JSON;
    // Define the schema of the delimited results
    oDS.responseSchema = {
        resultsList: "resultList",
        fields: ["name", "id", "markup"]
    };
    
    // Enable caching
    oDS.maxCacheEntries = 20;

    // Instantiate the AutoComplete
    var oAC = new YAHOO.widget.AutoComplete("${uniqueId}ACInput", "${uniqueId}ACContainer", oDS);
    oAC.queryQuestionMark = false;
    oAC.forceSelection = false;
    oAC.autoHighlight = ${autoHighlight};
    oAC.maxResultsDisplayed = 100;
    oAC.resultTypeList = false;
    oAC.useIFrame = true;
    
    oAC.formatResult = function(oResultItem, sQuery, sResultsMatch) {
    	return oResultItem.markup;
    };

	oAC.doBeforeLoadData = function(sQuery, oResponse, oPayload) {
		<c:if test="${newLink eq 'true'}">
    	//var name = this._elTextbox.value;
    	var name = "";
    	if(sQuery != null){
    		sQuery = sQuery.toUpperCase();
        	name = decodeURIComponent(sQuery);
    	}		
    	var newStr = "Add New " + name;
     	var markup = "<a href='#' onclick='addSubBrand(this);return false;' value='"+sQuery+"'>"+newStr+"</a>";

    	var newData = {"id":"0","markup":markup,"name":name};
    	if(oResponse != null){    
				var aResults = oResponse.results;
				if(aResults != null ){
					var size = aResults.length;
					if(size > 0){
						if(size > 99){
							//insert Add New in the 99th position
							var newarr1 = aResults.slice(0,99);
							var newarr2 = aResults.slice(99);
							aResults = newarr1.concat(newData,newarr2);
							oResponse.results = aResults;
						}	
						else{
							if(aResults[size-1].id == "0"){
							//aResults[size-1].markup = newStr;
							}else{	
								aResults[size] = newData;
								//aResults[size].markup = newStr;
							}
						}	
					}else{
						aResults[0] = newData;	
					}		
				}	
    	}
    	</c:if>
 		return true;
	};

	
	<c:if test="${newLink eq 'true'}">
	oAC.itemMouseOverEvent.subscribe(
			function(elNewListItem){
		        var sHighlight = this.highlightClassName;
		        if(this._elCurListItem) {
			     if(this._elCurListItem._oResultData.id == '0'){
		       	 	YAHOO.util.Dom.removeClass(this._elCurListItem, sHighlight);
			     }
		       }
			});
	</c:if>
	
    var itemSelectHandler = function(sType, aArgs) {

		var aData = aArgs[2]; //array of the data for the item as returned by the DataSource
		
		<c:if test="${strutsHiddenElmProperty != null}">
			//alert('setting struts hidden to: '+aData.id);
			var elm1 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElm");
			elm1.value=aData.id;
		</c:if>
		<c:if test="${strutsHiddenNameElmProperty != null}">	
			var elm2 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenNameElm");
			elm2.value=aData.name;
		</c:if>
		
		<c:if test="${onSelectMethod != null}">
			setTimeout(function() { // For IE
                ${onSelectMethod}.apply(document, aArgs);
            },0);
		</c:if>
		
		
	};
	//subscribe your handler to the event, assuming
	//you have an AutoComplete instance myAC:
	oAC.itemSelectEvent.subscribe(itemSelectHandler);	

	oAC.textboxKeyEvent.subscribe(
			function(nKeycode){
	        	var oSelf = this;
				oSelf.forceSelection = ${forceSelection};
			});
	
	oAC.textboxFocusEvent.subscribe(
			function(){
		    	var oSelf = this;
		    	oSelf.forceSelection = false;
	 });
    
	oAC.textboxBlurEvent.subscribe(
		function(){
			<c:if test="${uniqueId eq 'graphicsCode' || uniqueId eq 'labelFormat2' || uniqueId eq 'labelFormat1' || uniqueId eq 'actionCode'}">
				var valueElm = YAHOO.util.Dom.get('${uniqueId}ACInput').value;
				if(valueElm == ""){
					YAHOO.util.Dom.get('${uniqueId}StrutsHiddenElm').value = "";
				}
			</c:if>
		});
	
    return {
        oDS: oDS,
        oAC: oAC
    };
}

<c:if test="${clearMethod != null}">
	function ${clearMethod}(){
		YAHOO.util.Dom.get('${uniqueId}ACInput').value = "";
		YAHOO.util.Dom.get('${uniqueId}StrutsHiddenElm').value = "";
	}	
</c:if>

YAHOO.util.Event.onDOMReady(init${uniqueId}Remote);

</script>

			
<!-- END AUTOCOMPLETE2 TAG -->