<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@attribute  name="uniqueId" required="true" rtexprvalue="false" %>
<%@attribute  name="searchAction" required="true" rtexprvalue="false" %>
<%@attribute  name="showId" required="false" rtexprvalue="false" %>
<%@attribute  name="maxResults" required="false" rtexprvalue="false" %>
<%@attribute  name="highlightMatch" required="false" rtexprvalue="false" %>
<%@attribute  name="zi" required="false" rtexprvalue="false" description="z-index" %>
<%@attribute  name="searchOnId" required="false" rtexprvalue="false" %>
<%@attribute  name="tabIdx" required="false" rtexprvalue="false" %>
<%@attribute  name="compWidth" required="false" rtexprvalue="false" %>
<%@attribute  name="strutsHiddenElmProperty" required="false" rtexprvalue="false" %>
<%@attribute  name="genericHiddenElmName" required="false" rtexprvalue="false" %>
<%@attribute  name="onSelectMethod" required="false" rtexprvalue="false" %>
<%@attribute  name="maxCacheEntries" required="false" rtexprvalue="false" %>
<%@attribute  name="onInitMethod" required="false" rtexprvalue="false" %>
<%--
	if the struts form has a value set for the specified property,
	looks up the user-friendly name associated with that property
	and puts it in the jspContext as 'currentComponentText' 
--%>
<cps:currentComponentValueSubTag 
	strutsHiddenElmProperty="${strutsHiddenElmProperty}"
	uniqueId="${uniqueId}"/>


<c:choose>
	<c:when test="${maxResults != null}">
		<c:set value="${maxResults}" var="realMaxResults"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="110" var="realMaxResults"></c:set>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${showId != null}">
		<c:set value="${showId}" var="realShowId"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="true" var="realShowId"></c:set>
	</c:otherwise>
</c:choose>


<c:choose>
	<c:when test="${highlightMatch != null}">
		<c:set value="${highlightMatch}" var="realHighlightMatch"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="true" var="realHighlightMatch"></c:set>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${zi != null}">
		<c:set value="${zi}" var="realZIndex"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="9000" var="realZIndex"></c:set>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${searchOnId != null}">
		<c:set value="${searchOnId}" var="realSearchOnId"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="true" var="realSearchOnId"></c:set>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${tabIdx != null}">
		<c:set value="tabindex='${tabIdx}'" var="tabIdxStr"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="" var="tabIdxStr"></c:set>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${compWidth != null}">
		<c:set value="${compWidth}" var="realWidth"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="13em" var="realWidth"></c:set>
	</c:otherwise>
</c:choose>


<c:choose>
	<c:when test="${selectedValueName != null}">
		<c:set value="${selectedValueName}" var="realSelectedValueName"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="ignoreme" var="realSelectedValueName"></c:set>
	</c:otherwise>
</c:choose>


<c:choose>
	<c:when test="${selectedValueId != null}">
		<c:set value="${selectedValueId}" var="realSelectedValueId"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="ignoreme" var="realSelectedValueId"></c:set>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${maxCacheEntries != null}">
		<c:set value="${maxCacheEntries}" var="realMaxCacheEntries"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="5" var="realMaxCacheEntries"></c:set>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${requestScope.currentComponentText != null}">
		<c:set value="value='${requestScope.currentComponentText}'" var="valueText"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="" var="valueText"></c:set>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${requestScope.currentComponentId != null}">
		<c:set value="value='${requestScope.currentComponentId}'" var="valueId"></c:set>
	</c:when>
	<c:otherwise>
		<c:set value="" var="valueId"></c:set>
	</c:otherwise>
</c:choose>



<!-- START AUTOCOMPLETE3 TAG. UNIQUE ID: ${uniqueId}    -->

<c:set var="needToShowGenericCSS" value="${requestScope.ac3CssShown == null}"></c:set>

<c:set var="ac3CssShown" value="true" scope="request"></c:set>

<c:url value="${request.getContextPath()}/hebAssets/images/" var="acImg" />					

<%-- 

this section only needs to be displayed once per page at the beginning 
of the 1st instance, so the tag looks to see if a marker exists in the
request scope.  If it does, then this css code has already been output, so
it does nothing.  If the marker doesn't exist, output the css and put the 
marker in the request scope so subsequent instances of the tag won't output
the css.

--%>
<c:if test="${needToShowGenericCSS}">

	<script type="text/javascript">
		YAHOO.namespace("YAHOO.HEB.autocomplete3");
	</script>

	<style type="text/css">
		/* custom styles for inline instances */
		.yui-skin-sam .yui-ac-input { 
										position:static; 
										vertical-align:middle;	
									}
		.yui-skin-sam .yui-ac-container { 	
											left:0px;
										}
		
		/* buttons */
		.yui-ac .yui-button {
			vertical-align:middle;
		}
		.yui-ac .yui-button button {
			background: url(${acImg}dropdown3_rt.bmp) center center no-repeat;  
			width: 20px; 
			height: 20px; 
		}
		.yui-ac .open .yui-button button {
			background: url(${acImg}dropdown3.bmp) center center no-repeat;
		}
	</style>									

</c:if>

<%-- 
	this css is output for every instance of this tag
--%>
<style type="text/css">
	/* custom styles for inline instances */

	#${uniqueId}AutoComplete .yui-ac-content {
		max-height:11em;
		overflow:auto;
		overflow-x:hidden;
		_height:11em;
	}
	/* needed for stacked instances for ie & sf z-index bug of absolute inside relative els */
	#${uniqueId}AutoComplete { 
		z-index:${realZIndex}; 
	} 
	
	#${uniqueId}ACContainer{
		width: ${realWidth};
	}

	#${uniqueId}ACInput{
		width: ${realWidth};
	}


</style>									

<div id="${uniqueId}AutoComplete">
    <input id="${uniqueId}ACInput" type="text" ${tabIdxStr} ${valueText}/><nobr></nobr><span id="${uniqueId}Toggle"></span>
	<div id="${uniqueId}ACContainer"></div>
</div>					


<c:if test="${strutsHiddenElmProperty != null}">
	<form:hidden path="${strutsHiddenElmProperty}" id="${uniqueId}StrutsHiddenElm"  />
</c:if>

<c:if test="${genericHiddenElmName != null}">
	<input type="hidden" name="${genericHiddenElmName}" id="${uniqueId}GenericHiddenElm" ></input>
</c:if>

					
<script type="text/javascript">

YAHOO.HEB.init${uniqueId}CB = function() {
    // Instantiate DataSources
    
    
<c:url value="/protected/cps/add/manage/modules/search/backend/ajaxSearch?action=${searchAction}&showId=${realShowId}&highlightMatch=${realHighlightMatch}&maxResults=${realMaxResults}&searchOnId=${realSearchOnId}&uniqueId=${uniqueId}&" var="jsonSearch"></c:url>    
    
    //var bdmDS = new YAHOO.util.LocalDataSource(YAHOO.HEB.testData);

	//var bdmDS = new YAHOO.util.XHRDataSource("${jsonSearch}", ["resultList", "name"]);
	var bdmDS = new YAHOO.util.XHRDataSource("${jsonSearch}");
    // Set the responseType
    bdmDS.responseType = YAHOO.util.XHRDataSource.TYPE_JSON;
    // Define the schema of the delimited results
	bdmDS.responseSchema = {
        resultsList: "resultList",
        fields: ["name", "id", "markup"]
    };
    

    bdmDS.maxCacheEntries = ${realMaxCacheEntries};


    // Instantiate AutoCompletes
    var oConfigs = {
        prehighlightClassName: "yui-ac-prehighlight",
        useShadow: true,
        queryDelay: 0,
        minQueryLength: 0
    }
    var bdmAC = new YAHOO.widget.AutoComplete("${uniqueId}ACInput", "${uniqueId}ACContainer", bdmDS, oConfigs);
    //var bdmAC = new YAHOO.HEB.customAutoComplete.HEBCustomAutocomplete("${uniqueId}ACInput", "${uniqueId}ACContainer", bdmDS, oConfigs, "${uniqueId}StrutsHiddenElm");
    
    bdmAC.queryQuestionMark = false;
    bdmAC.forceSelection = false;
    bdmAC.autoHighlight = true;
    bdmAC.maxResultsDisplayed = 110;
    bdmAC.resultTypeList = false;
    
    bdmAC.doBeforeLoadData = function(sQuery, oResponse, oPayload) {
    	return true;
    }
       
    bdmAC.doBeforeLoadData = function(sQuery, oResponse, oPayload) {
		<c:if test="${strutsHiddenElmProperty != null}">
			if(oPayload && (oPayload.query != undefined) && (oPayload.query != null)){
				if("" == oPayload.query){
					var aResults = oResponse.results;
					var xElm = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElm"); 
					if((xElm) && (xElm.value) && (xElm.value != null) && (xElm.value != "")){
						if(aResults && (aResults != null) && (aResults.length > 0)){
							var val = xElm.value;
							var matchIndex = -1;
							for(var i = 0 ; i < aResults.length ; i++){
								if(aResults[i].id == val){
									matchIndex = i;
									break;
								}
							}
							if(matchIndex >= 0){
								var moveToTop = aResults[matchIndex];
								aResults.splice(matchIndex, 1);
								aResults.splice(0, 0, moveToTop);
							}					
						}
					}					
				}
			}
		</c:if>    	
    	return true;
	};
   

    bdmAC.containerExpandEvent.subscribe(
    	function(evt){
    		this._elContent.scrollTop = this._elContent.firstChild.offsetTop;	
    	}
    );
	
	
	bdmAC.textboxFocusEvent.subscribe(
	function(){
    	var oSelf = this;
    	oSelf.forceSelection = false;
    	var sInputValue = YAHOO.util.Dom.get('${uniqueId}ACInput').value;
    	if(sInputValue.length === 0) {
        	setTimeout(function(){oSelf.sendQuery("");},0);
    	}
	});
    

	bdmAC.textboxKeyEvent.subscribe(
			function(nKeycode){
	        	var oSelf = this;
				oSelf.forceSelection = true;
			});
	

	var itemSelectHandler = function(sType, aArgs) {	
		var oMyAcInstance = aArgs[0]; // your AutoComplete instance
		var elListItem = aArgs[1]; //the <li> element selected in the suggestion
		   					       //container
		var aData = aArgs[2]; //array of the data for the item as returned by the DataSource
		<c:if test="${strutsHiddenElmProperty != null}">
			//alert('setting struts hidden to: '+aData.id);
			var elm1 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElm"); 
			elm1.value=aData.id;
		</c:if>			
		<c:if test="${genericHiddenElmName != null}">
			//alert('setting generic hidden to: '+aData.id);
			YAHOO.util.Dom.get("${uniqueId}GenericHiddenElm").value=aData.id;		
		</c:if>			
		<c:if test="${onSelectMethod != null}">
			setTimeout(function() { // For IE
                ${onSelectMethod}.apply(document, aArgs);
            },0);
		</c:if>		
		AddCandidateTemp.getSizeUPC(aftersValidateitemSelectHandler);			
	};
	
	function aftersValidateitemSelectHandler(data){				
		alert('Please select at least a Brick.');
		}
	}
	//subscribe your handler to the event, assuming
	//you have an AutoComplete instance myAC:
	bdmAC.itemSelectEvent.subscribe(itemSelectHandler);	
    
   
    bdmAC.formatResult = function(oResultItem, sQuery, sResultsMatch) {
    	return oResultItem.markup;
    };    
    
// If the selection goes beyond the first element then clear the input if it is "query="
    var checkQ = function (evt){
		var elt = YAHOO.util.Dom.getElementsByClassName("yui-ac-highlight", "li"); 
		if(elt.length == 0){			
			if(bdmAC.getInputEl().value == "query="){
				bdmAC.getInputEl().value="";
			}
		}		
	};
	
	YAHOO.util.Event.addListener(bdmAC.getInputEl(),"keyup", checkQ, bdmAC);

    
    // Breakfast combobox
    var bToggler = YAHOO.util.Dom.get("${uniqueId}Toggle");
    var oPushButtonB = new YAHOO.widget.Button({container:bToggler});
    var toggleB = function(e) {
        //YAHOO.util.Event.stopEvent(e);
        if(!YAHOO.util.Dom.hasClass(bToggler, "open")) {
            YAHOO.util.Dom.addClass(bToggler, "open")
        }
        
        // Is open
        if(bdmAC.isContainerOpen()) {
            bdmAC.collapseContainer();
        }
        // Is closed
        else {
            bdmAC.getInputEl().focus(); // Needed to keep widget active
            setTimeout(function() { // For IE
                bdmAC.sendQuery("");
            },0);
        }
    };
    
    oPushButtonB.on("click", toggleB);
    bdmAC.containerCollapseEvent.subscribe(function(){YAHOO.util.Dom.removeClass(bToggler, "open")});
    
    
	<c:if test="${onInitMethod != null}">
		setTimeout(function() { // For IE
               ${onInitMethod}.apply(document, ["${valueId}", "${valueText}"]);
           },0);
	</c:if>
    
    
    return {
        bdmDS: bdmDS,
        bdmAC: bdmAC
    };
};

YAHOO.util.Event.onDOMReady(YAHOO.HEB.init${uniqueId}CB);

</script>



<!-- END AUTOCOMPLETE3 tag -->

