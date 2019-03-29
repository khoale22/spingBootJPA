<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@attribute  name="compName" required="true" rtexprvalue="false" %>
<%@attribute  name="textid" required="true" rtexprvalue="false" %>
<%@attribute  name="containerId" required="true" rtexprvalue="false" %>
<%@attribute  name="sourceList" required="true"%>
<%@attribute  name="selectedProperty" required="true" rtexprvalue="false" %>
<%@attribute  name="containerVar" required="false" rtexprvalue="false" %>
<%@attribute  name="selectedValueId" required="false" rtexprvalue="false" %>
<%@attribute  name="selectedValueName" required="false" rtexprvalue="false" %>
<%@attribute  name="resetJSMethodName" required="false" rtexprvalue="false" %>
<%@attribute  name="width" required="false" rtexprvalue="false" %>
<%@attribute  name="onchangeMethod" required="false" rtexprvalue="false" %>
<%@attribute  name="index" required="false" rtexprvalue="false" %>
<%@attribute  name="tabIndex" required="false" rtexprvalue="false" %>
<%@attribute  name="reloadMethod" required="false" rtexprvalue="false" %>
<%@attribute  name="clearMethod" required="false" rtexprvalue="false" %>
<%@attribute  name="enforceSelection" required="false" rtexprvalue="false" %>
<%@attribute  name="emptyList" required="false" rtexprvalue="false" %>
<%@attribute  name="valueDisplay" required="false" rtexprvalue="false" 
description="pass the value as false if no value is to be displayed along with the label."%>
<c:set var="values" value="${containerVar}"></c:set><c:if test="${containerVar == null}"><c:set var="values" value="${compName}values"></c:set></c:if>
<c:set var="valId" value="${selectedValueId}"></c:set><c:if test="${selectedValueId == null}"><c:set var="valId" value="${compName}valId"></c:set></c:if>
<c:set var="valName" value="${selectedValueName}"></c:set><c:if test="${selectedValueName == null}"><c:set var="valName" value="${compName}valName"></c:set></c:if>
<c:set var="compWidth" value="${width}"></c:set><c:if test="${width == null}"><c:set var="compWidth" value="15em"></c:set> </c:if>
<c:set var="onchangeMethodName" value="${onchangeMethod}"></c:set><c:if test="${onchangeMethod == null}"><c:set var="onchangeMethodName" value="null"></c:set> </c:if>
<c:set var="dispValue" value="${valueDisplay}"></c:set><c:if test="${valueDisplay == null}"><c:set var="dispValue" value="true"></c:set> </c:if>
<c:set var="forceSel" value="${enforceSelection}"></c:set><c:if test="${enforceSelection == null}"><c:set var="forceSel" value="true"></c:set> </c:if>

<div id="${compName}OuterDiv" style="position : relative;z-index: ${index};min-width: 0;">
	<style type="text/css">
		#${compName}sautocomplete {
		    width:${compWidth}; /* set width here */
		    font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 11px;	
		    padding-bottom:2em;
		    postion:absolute;
		    top:0px;
			<c:if test="${index != null}">
				z-index : ${index};
			</c:if>
		}
		.${compName}sautocompleteClass {
		    width:${compWidth}; /* set width here */
		    font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 11px;	
		    padding-bottom:2em;
		    postion:absolute;
		    top:0px;
			<c:if test="${index != null}">
				z-index : ${index};
			</c:if>
		}
		#${textid}{
		    _position:absolute; /* abs pos needed for ie quirks */
		    font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 11px;	
		}
		.${textid}Class{
		    _position:absolute; /* abs pos needed for ie quirks */
		    font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 11px;	
		}
		#${containerId} .yui-ac-content {
		    max-height:11em;overflow:auto;overflow-x:hidden; /* scrolling */
		    _height:11em; /* ie6 */
		    font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 11px;	
		}
		.${containerId}Class .yui-ac-content {
		    max-height:11em;overflow:auto;overflow-x:hidden; /* scrolling */
		    _height:11em; /* ie6 */
		    font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 11px;	
		}
	</style>
	<div id="${compName}cont" style="postion:relative;min-width: 0;">
	<c:url value="${request.getContextPath()}/hebAssets/images/dropdown.bmp" var="image"></c:url>
	<div id="${compName}sautocomplete">
		<input id="${textid}" type="text"
	<c:if test="${tabIndex != null}">  tabindex="${tabIndex}"</c:if>   />
	<img src="${image}" alt="" width="20" id="${compName}Image" height="20" hspace="5" style="position:absolute;top: +0px;right:-12px;"
	/>
		<div id="${containerId}"></div>
	</div>
	</div>
	<form:hidden  path="${selectedProperty}" id="${valId}" />
	<input type="hidden" id="${valName}"/>
	
	<script type="text/javascript">
	<c:set var="sourceListArray" value="${sourceList}"/>
	${values} = [
	    <c:forEach items="${CPSForm[sourceListArray]}" var="sourceitem" varStatus="loop" >
        	['<c:out value="${sourceitem.name}"></c:out>','<c:out value="${sourceitem.id}"></c:out>']<c:if test="${not loop.last}">,</c:if>
        </c:forEach>
	];
	
	get${compName} = function(query) {
		reslts = [];
		try{
	    for (var i = 0; i < ${values}.length; i++) {
		    var t1 = ${values}[i][0];
		    var t2 = query;
		    var t1Up = t1.toUpperCase();
		    var t2Up = t2.toUpperCase();
		    var v1 = ${values}[i][1];
		    var v1Up = v1.toUpperCase();
		    
	    	if (t1Up.match(t2Up) || v1Up.match(t2Up)) {
	    		reslts.push(${values}[i]);
	    	}
	    }
		}catch(er){}
	    return reslts;
	};
	
	var ${compName}val;
	var ${compName}Selected = false;
	
	<c:if test="${reloadMethod != null}">
	${reloadMethod}Temp = function() {
	</c:if>
	
	<c:if test="${reloadMethod == null}">
	new function() {
	</c:if>
	
		// Instantiate first JS Array DataSource
	    var oACDS = new YAHOO.widget.DS_JSFunction(get${compName});
	    // Instantiate first AutoComplete
	    var oAutoComp = new YAHOO.widget.AutoComplete('${textid}','${containerId}', oACDS);
	    oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
	   // this.oAutoComp.typeAhead = true;
	    oAutoComp.useShadow = true;
	    oAutoComp.minQueryLength = 0;
	    //oAutoComp.forceSelection = true;
	    oAutoComp.maxResultsDisplayed = 200;
	    oAutoComp.animVert = false;  
	    oAutoComp.animHoriz = false;  
	    oAutoComp.animSpeed = 0;
	    
	    oAutoComp.textboxFocusEvent.subscribe(function() {
	        var sInputValue = YAHOO.util.Dom.get('${textid}').value;
	        
	        if (sInputValue.length == 0) {
	            var oSelf = this;
	            setTimeout(function() {oSelf.sendQuery(sInputValue);}, 0);
	        }
	    });
	    
	    oAutoComp.textboxKeyEvent.subscribe(function(oSelf, nKeycode) {
	    	document.getElementById('${containerId}').style.display = '';
	    	${compName}Selected = false;
	    	var sInputValue = YAHOO.util.Dom.get('${textid}').value;
	    	sInputValue = trim(sInputValue);
	    	
	    	if ('' == sInputValue && nKeycode[1] == 32) {
			  	setTimeout(function() {
					YAHOO.util.Dom.get('${textid}').value = "";
				}, 0);
			}
	    });

		// Fix bug #441 - Start
		document.getElementById('${containerId}').onmouseout = function() {
			document.getElementById('${containerId}').style.display = 'none';
			document.getElementById('${containerId}').onmouseover = function() {
				document.getElementById('${containerId}').style.display = '';
			};
		};

		document.getElementById('${compName}Image').onclick = function() {
			document.getElementById('${containerId}').style.display = '';
		};
		
	    oAutoComp.textboxBlurEvent.subscribe(function() {
	    	var f = function() {
		    	<c:if test="${!forceSel}">
		    	var currntVal = document.getElementById('${textid}').value;
		    	
		    	try{
		    	if (null == currntVal || "".match(currntVal)) {
					document.getElementById('${valId}').value = '';
					
					var changeFunction = eval(${onchangeMethodName});
					if (changeFunction != null) {
						var selectElement = YAHOO.util.Dom.get("${textid}");
						changeFunction({target:selectElement});
					}				
		    	} else {	    		
		    		if (null != ${compName}val) {	    			
		    			YAHOO.util.Dom.get('${textid}').value = ${compName}val;
		    		}
		    	}
		    	}catch(er){
			    	}
		    	</c:if>
		    	
		    	<c:if test="${forceSel}">
		    	var currntVal = document.getElementById('${textid}').value;
		    	/* replace "".match(currntVal) by ""==currntVal
		    	 * @author khoapkl
		    	 */
		    	if (null == currntVal || ""==currntVal) {
					document.getElementById('${valId}').value = '';
				} else if (null != ${compName}val && '' != ${compName}val) { 
	        		/*add command '' != ${compName}val
	        		 *@author khoapkl
	        		 */	    			
	    			YAHOO.util.Dom.get('${textid}').value = ${compName}val;
	    		}
		    	</c:if>
	    	}
	    	
	    	if (!${compName}Selected) {
				//hide commands below
	    		//document.getElementById('${textid}').value = '';
	    		//document.getElementById('${valId}').value = '';
	    	}
	    	
	    	setTimeout(f, 0);
	    });
	    
	    oAutoComp.formatResult = function(oResultItem, sQuery) {
	    	var sMarkup;
	    	
	    	if (null != sQuery) {
	    		sQuery = trim(sQuery);
	    		
	    		if ("" != sQuery) {
	    			var entryCode;	
	    			var label;
	    			var inLabel = false;
		    		var inCode = false;
	    			var capQuery = sQuery.toUpperCase();
	    			var labelCap = oResultItem[0].toUpperCase();
	    			var ind = labelCap.indexOf(capQuery);
	    			
	    			if (ind != -1) {
	    				inLabel = true;
		    			var endInd = ind + capQuery.length;
		    			var firstPart = oResultItem[0].substring(0,ind);
		    			var secPart = oResultItem[0].substring(ind,endInd);
		    			var lastPart = oResultItem[0].substring(endInd,oResultItem[0].length);
		    			label = firstPart + '<b>' + secPart + '</b>' + lastPart;
			    	}
			    	
	    			var valDisp = ${dispValue};
	    			
	    			if (valDisp) {
		    			capQuery = sQuery.toUpperCase();
		    			labelCap = oResultItem[1].toUpperCase();
		    			ind = labelCap.indexOf(capQuery);
		    			
		    			if (ind != -1) {
		    				inCode = true;
			    			var endInd = ind + capQuery.length;
			    			var firstPart = oResultItem[1].substring(0,ind);
			    			var secPart = oResultItem[1].substring(ind,endInd);
			    			var lastPart = oResultItem[1].substring(endInd,oResultItem[0].length);
			    			var entryCode = firstPart + '<b>' + secPart + '</b>' + lastPart;
		    			}

		    			var l;
		    			var c;
		    			
		    			if (inLabel) {
			    			l = label;
			    		} else {
				    		l = oResultItem[0];
				    	}
				    	
		    			if (inCode) {
			    			c = entryCode;
			    		} else {
				    		c = oResultItem[1];
				    	}

		    			if (inLabel || inCode) {
			        		sMarkup = l + "  [" + c + "]";
			        	} else {
			        		sMarkUp = null;
			        	}
			        } else {
			        	sMarkup = label;
			        }
			        
	        		return (sMarkup);
			    }
	        }
	        
	        var v = ${dispValue};
	        
	        if (v) {
	        	sMarkup = oResultItem[0] + "  [" + oResultItem[1] + "]";
	        } else {
				sMarkup = oResultItem[0];
	        }
	        
	        return (sMarkup);
	    };
	    
	    var myOnDataReturn = function(sType, aArgs) {
	        var oAutoComp = aArgs[0];
	        var sQuery = aArgs[1];
	        var aResults = aArgs[2];
	        
	        if (aResults.length == 0) {
	            oAutoComp.setBody("<div id=\"${containerId}default\">No matching results</div>");
	        }
	    };
	    
	    oAutoComp.dataReturnEvent.subscribe(myOnDataReturn);	    
		    
	    var itemSelectHandler = function(sType, aArgs) {
			YAHOO.log(sType); //this is a string representing the event;
						      //e.g., "itemSelectEvent"
			var oMyAcInstance = aArgs[0]; // your AutoComplete instance
			var elListItem = aArgs[1]; //the <li> element selected in the suggestion
			   					       //container
			var aData = aArgs[2]; //array of the data for the item as returned by the DataSource
			document.getElementById('${valId}').value = html_entity_decode(aData[1]);
			${compName}val = html_entity_decode(aData[0]);
			var changeFunction = eval(${onchangeMethodName});
			
			if (changeFunction != null) {
				YAHOO.util.Dom.get("${textid}").value = html_entity_decode(YAHOO.util.Dom.get("${textid}").value);
				var selectElement = YAHOO.util.Dom.get("${textid}");				
				changeFunction({target:selectElement});
			}
			${compName}Selected = true;
		};
		
		//subscribe your handler to the event, assuming
		//you have an AutoComplete instance myAC:
		oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);	
		
		//set the value in the textbox		
		var id = document.getElementById('${valId}').value;
		
		if (id != null && id != "") {
			for (var i = 0; i < ${values}.length; i++) {
				var tmp = ${values}[i];
				
				if (tmp[1] == id) {
					document.getElementById('${textid}').value = html_entity_decode(tmp[0]);
				}
			}
		}
		
		var temp = oAutoComp;
		var sendEmptyQuery = function(t1, t2) {
			var sInputValue = YAHOO.util.Dom.get('${textid}').value;
            setTimeout(function() {t2.sendQuery("");}, 0);
            document.getElementById('${textid}').focus();
		};
		
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("${compName}Image"), "click", sendEmptyQuery,temp); 
	};
	
	<c:if test="${resetJSMethodName != null}">
	${resetJSMethodName} = function(data) {
		${values} = [];
		
		for (var i = 0; i < data.length; i++) {
			${values}.push([data[i].name,data[i].id]);
		}
	};
	</c:if>
	
	<c:if test="${reloadMethod != null}">
	${reloadMethod} = function() {
		YAHOO.util.Dom.get("${compName}sautocomplete").className = '${compName}sautocompleteClass' ;
		YAHOO.util.Dom.get("${textid}").className = '${textid}Class' ;
		YAHOO.util.Dom.get("${containerId}").className = '${containerId}Class' ;
		YAHOO.util.Dom.get("${compName}cont").style.position = 'relative' ;
		YAHOO.util.Event.onDOMReady(${reloadMethod}Dummy);
		//setTimeout(function(){${reloadMethod}Dummy();},25);
	};

	${reloadMethod}Dummy = function() {
		${reloadMethod}Temp();
	};
	
	YAHOO.util.Event.onDOMReady(${reloadMethod}Temp);
	</c:if>
	
	<c:if test="${clearMethod != null}">
	var ${clearMethod} = function() {
		YAHOO.util.Dom.get('${textid}').value = '';
		${compName}val = '';
		YAHOO.util.Dom.get('${valId}').value = '';
	};
	</c:if>
	
	<c:if test="${emptyList != null}">		
	${emptyList} = function(){
		${values} = [];
	};
	</c:if>
	
	function html_entity_decode(str) {
		var ta = document.createElement("textarea");
		ta.innerHTML = str.replace(/</g,"&lt;").replace(/>/g,"&gt;");
		return ta.value;
	}

	</script>
	
</div>
