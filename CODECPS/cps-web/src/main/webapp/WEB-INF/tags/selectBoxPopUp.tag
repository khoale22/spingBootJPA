<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@attribute  name="divName" required="true" rtexprvalue="false" %>
<%@attribute  name="targetSelectBoxName" required="true" rtexprvalue="false" %>
<%@attribute  name="itemsList" required="true" rtexprvalue="true" type="java.util.List"%>
<%@attribute  name="divHeaderLabel" required="true" rtexprvalue="false"%>
<%@attribute  name="onChangeMethod" required="false" rtexprvalue="false"%>
<%@attribute  name="redrawMethod" required="false" rtexprvalue="false"%>

<%
	
	java.util.Collection o = (java.util.Collection)jspContext.findAttribute("itemsList");
	int sz = 0;
	if(o != null){
		sz = o.size();
	}

%>
<c:set var="collectionSize" value="<%=sz%>"></c:set>

<c:set value="${itemsList}" var="currentPopupCollection"/>
<c:set value="${divName}Panel" var="panelId" />
<c:set value="${divName}List" var="listId" />
<c:set value="${divName}Option_" var="itemIdPrefix" />

<%
//this match the 'id' (called 'styleId' in struts) of the select box component
//in the classification.jsp page
%>
<c:set value="${targetSelectBoxName}" var="selectElementId" />

<c:set value="${divHeaderLabel}" var="panelTitle" />
<%
//important!  this will usually be set to "null"
%>
<c:if test="${onChangeMethod != null}">
	<c:set value="${onChangeMethod}" var="onChangeMethodName" />
</c:if>
<c:if test="${onChangeMethod == null}">
	<c:set value="null" var="onChangeMethodName" />
</c:if>

<c:if test="${redrawMethod != null}">
	<c:set value="${redrawMethod}" var="exposeRedrawMethodAs" />
</c:if>
<c:if test="${redrawMethod == null}">
	<c:set value="null" var="exposeRedrawMethodAs" />
</c:if>


<%
/*
	the actual panel that makes up the menu.  it's hidden by default.
*/
%>
<div id="${panelId}" style="visibility:hidden">
	<div class="hd">${panelTitle}</div>
	<div class="bd">
		<ol id="${listId}">

<c:forEach items="${currentPopupCollection}" var="uType" varStatus="uStat" begin="0" end="8">
			<li>
				<a id="${itemIdPrefix}${uStat.index}">${uType.name}</a>
			</li>
</c:forEach>

		</ol>
		'N' = next<br>
		'P' = previous<br>
		Press [ESC] to dismiss this Panel.
	</div>
</div> 





<script type="text/javascript" >
new function(){

			//instantiate the panel menu	
			var popupPanel = new YAHOO.widget.Panel("${panelId}", { xy:[200,250], width: "350px", visible: false } );
			
			
			//maps '1' to 'Basic', '2' to 'MRT', etc.
			//used to handle key clicks.  We need to know what value to put in the select box when the user types '1', '2', or '3'
			var numberToIdMap = {};
			
			var idToNameMap = {}
			
			//when we have > 10 choices.  show 0-10 or 72-82, etc
			var offset = 0; 
			
			//for each bdm, map a number 1-9 to the BDM's id and also add a click handler to the <a> tag 
			//in case the user clicks on an option with the mouse instead of typing a number
			<c:forEach items="${currentPopupCollection}" var="uType" varStatus="uStat">			
				numberToIdMap["${uStat.index}"] = "${uType.id}";
				idToNameMap["${uType.id}"] = "${uType.name}";
			</c:forEach>
			
			

			
			var itemCount = ${collectionSize};
			//YAHOO.log("item count: "+itemCount);
			//key click handler for the popup menu.
			//listen for n,p,[esc], and 1-9
			//n and p are not yet implemented (good luck!)
			//esc does nothing and hides the popup menu
			// 1-9 set the BDM select box to the proper value
			function popupKP(event, args){
				var theKey = String.fromCharCode(args[0]);
				if((theKey == "N") || (theKey == "P")){
					//dalert('@TODO: implement next and previous (its a toughie!)');
					//YAHOO.log("n or p");
					doNextPrevious(theKey);
				}
				else if(args[0] == 27){//[esc]
					popupPanel.hide();
				}
				else{
					var keyNum = parseInt(theKey);
					var realKey = keyNum + offset - 1;//-1 because the keys are 1 indexed and the bdms are 0 indexed
					//YAHOO.log(realKey);
					var realVal = numberToIdMap[''+realKey];
					//YAHOO.log("real val: "+realVal);
					setItemSelectValue(realVal);
				}
				//else if(numberToIdMap[theKey]){
				//	setItemSelectValue(numberToIdMap[getIdFromKey(theKey)]);
				//}
				
			}
			
			function doNextPrevious(theKey){
				if(itemCount < 10){
					return;
				}
				//YAHOO.log(" in N or P :"+theKey);
				var newOffset = offset;
				//YAHOO.log("equals string: "+(theKey == "N"));
				//YAHOO.log("equals char: "+(theKey == 'N'));
				if(theKey == "N"){
					//YAHOO.log("doNP: "+numberToIdMap);
					//YAHOO.log("doNP: "+itemCount);
					newOffset = Math.min((offset + 9), (itemCount - 9));
				}
				else{
					newOffset = Math.max(0, (offset - 9));
				}
				//YAHOO.log(newOffset);
				offset = newOffset;
				
				dwr.util.removeAllOptions("${listId}");
				
				var newItemArray = [];
				//YAHOO.log("outside loop");
				for(var i = 0 ; i < 9 ; i++){
					//YAHOO.log("inside loop");
					//YAHOO.log(numberToIdMap);
					var currId = numberToIdMap[""+(i+offset)];
					//YAHOO.log("currId: "+currId);
					var currName = idToNameMap[currId];
					//YAHOO.log("currName: "+currName);
					newItemArray[i] = "<a id=\"${itemIdPrefix}"+i+"\">"+currName+"</a>";
				}
				 
				dwr.util.addOptions("${listId}", newItemArray, null, {escapeHtml:false});
				
				resetClickHandlers();
				
			}
			
			
			function createItemClickedFunction(itemId){
				return function(){itemClicked(itemId)};
			}
			
			//@TODO: fix closure issue
			function resetClickHandlers(){
				for(var i = 0 ; i < 10 ; i++){
					YAHOO.util.Event.removeListener("${itemIdPrefix}"+i, "click");
					var currId = numberToIdMap[""+(i + offset)];
					YAHOO.util.Event.addListener("${itemIdPrefix}"+i, "click", createItemClickedFunction(currId));
				}
			}
			
			
			//handler for when a user clicks a BDM on the popup menu panel
			function itemClicked(arg){
				setItemSelectValue(arg);
			}
			
			//set the value of the BDM select box to the requested value.
			//for some reason the change event doesn't get fired when we do it this way, 
			//so we have to fire it manually.
			function setItemSelectValue(val){
				//YAHOO.log('set bdm select val: '+val);
				selectElement.value=val;
				var changeFunction = eval(${onChangeMethodName});
				//YAHOO.log('change function: ');
				//YAHOO.log(changeFunction);
				if(changeFunction != null){
					changeFunction({target:selectElement});
				}
				
				popupPanel.hide();
			}
			
			
			
								
				//key listener that only gets activated when the panel is showing.
				//listens for n,p,[esc],1-9 and fires off call to 'popupKP' when one is pressed				
				var panelKl2 = new YAHOO.util.KeyListener(document, { keys:[27,49,50,51,52,53,54,55,56,57,78,80] },//<esc>,'1','2','3' ... '9','n','p' 							
														  { fn:popupKP,
															scope:document,
															correctScope:true }, "keyup" );//keyup for safari
															
			
				//when the popupPanel is actually showing, apply the key listener to it.
				popupPanel.cfg.queueProperty("keylisteners", panelKl2);
				//generate the DOM but don't show it
				popupPanel.render();
			
				//called when the space bar is pressed while the BDM select box has focus
				function selectElementSpacePressed(evt){
					popupPanel.show();
					resetClickHandlers();
				}
			
				//get the select box
				var selectElement = YAHOO.util.Dom.get("${selectElementId}");
				//alert('uts: '+upcTypeSelect);
				
				//create a key listener for the space bar and attach it to the BDM select box.
				//this listener only listens for key presses while the BDM select box has focus
				var selectElementSpaceKL = new YAHOO.util.KeyListener(selectElement, { keys:[32] },//space bar  							
														  { fn:selectElementSpacePressed,
															scope:document,
															correctScope:true }, "keyup" );//keyup for safari
				//enable the key listener
				selectElementSpaceKL.enable();
				
				
				function redraw(data){
				
					YAHOO.log("*****REDRAW*******");
					YAHOO.log(data);
				
				
					numberToIdMap = {};
					idToNameMap = {};
					for(var k = 0 ; k < data.length ; k++){
						data[k].idx = k;
						numberToIdMap[""+k] = data[k].id;
						idToNameMap[data[k].id] = data[k].name;
					}
				
					dwr.util.removeAllOptions("${listId}");
					
					var commFormatter = function(entry){
						return "<a id='${itemIdPrefix}"+entry.idx+"'>"+entry.name+"</a>";
					}	
				
					var theMin = Math.min(data.length, 10);
					
					var visibleData = [];
					for(var m = 0 ; m < theMin ; m++){
						visibleData[m] = data[m];
					}
					
				
					dwr.util.addOptions("${listId}", visibleData, commFormatter, { escapeHtml:false });
				
					offset = 0;
					itemCount = data.length;
				
					resetClickHandlers();
										
				}
				
				
<c:if test="${exposeRedrawMethodAs != 'null'}">
				YAHOO.log('We have an exposed redraw method');
				${exposeRedrawMethodAs} = redraw;
</c:if>
				
				
				
				
}();
</script>

