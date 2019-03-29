<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%
/*

	This is a global footer that should be included at the bottom of every page.

*/
%>

<script type="text/javascript">
//document.bgColor = '#D6DCE2';
//document.body.scroll = 'no';
</script>
<c:url var="img" value="${request.getContextPath()}/hebAssets/images/footer.PNG"></c:url>
<br class="clearfloat" />
  <div id="footer" style="z-index: -1;">
	<table width="100%"><tr><td width="100%" align="center" style="font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight: bold;
	line-height: 15px;
	color: white;
	text-align: center;">©2008 H-E-B Company </td></tr> </table>
      </div>
 <div id="progressDiv" style=""></div>
<div id="minProgressDiv" style=""></div> 
<c:url var="loadingImage" value="${request.getContextPath()}/hebAssets/images/loadingData.gif"></c:url>
<c:url value="/dwr/interface/AddCandidateTemp.js" var="myJs" />
<script type="text/javascript" src="${myJs}"></script>

<script type="text/javascript">

 executeAfterBodyVisible(function(){ 
 	setTimeout('checkInitialInput();',3000);
 });
 
 
var showProgress;
var showProgbar;
var minProgress;
var hideProgress;
var initSubmit;
var showBigProg;
var hideBigProg;
var hideProdDisabled = false;

var progressEvent = new YAHOO.util.CustomEvent("onProgressInit"); 

function disableHideProgress(){
hideProdDisabled = true;
}

function enableHideProgress(){
hideProdDisabled = false;
}

function initProgressBar(){
	showProgbar = new YAHOO.widget.Panel("progressDiv",  
                                                    { width: "240px", 
                                                      fixedcenter: true, 
                                                      close: false, 
                                                      draggable: false, 
                                                      zindex:30000,
                                                      modal: true,
                                                      visible: false
                                                    } 
                                                );
            showProgbar.setHeader("Loading, please wait...");
            showProgbar.setBody("<img src=\"${loadingImage}\"/>");
            showProgbar.render(document.body);
            showBigProg = function(){
            	showProgbar.show();
            }
            hideBigProg = function(){
            	showProgbar.hide();
            }
            var frmCnt = 0;
	}

function initMinProgress(){
	var minProgress = new YAHOO.widget.Panel("minProgressDiv",  
	                                         {  xy:[200,250], 
	    										width: "240px", 
	    										height : "70px",  
	    										fixedcenter: true, 
	    										visible: false,
	    										zIndex : 35000,
	    										modal : true,
												draggable:false,
												close:false
	                                         });
	minProgress.setHeader("Processing, please wait...");
	minProgress.setBody("<img src=\"${loadingImage}\"/>");
	minProgress.render(document.body);
	showProgress = function(){
		document.body.style.cursor = 'wait';
		minProgress.show();
	}
	hideProgress = function(){
		if(!hideProdDisabled){
			minProgress.hide();
			document.body.style.cursor = 'auto';
		}
	}
            
    //progressEvent.fire({});
}

<c:if test="${!CPSForm.login}">
YAHOO.util.Event.onDOMReady(initProgressBar);
YAHOO.util.Event.onDOMReady(initMinProgress);
</c:if>
function makeBodyVisible(){
	document.body.style.visibility = 'visible';
	afterBodyVisible();
}



execAfterPageLoad(makeBodyVisible);
//make sure this is the last line of script execution for any page..
function makePageLoadTrue(){
	pageLoaded = true;
	//impl in common.js
	funToBeExecAfterPageLoad();
}
YAHOO.util.Event.onDOMReady(makePageLoadTrue);

//////////////////////////////////////////////////////////////////////
var prodType;	
function nonSellableHide(){				
	prodType = dwr.util.getValue("prodTypeSelect");	
	var testScanBtn = YAHOO.util.Dom.get("testScanBut");
	if(YAHOO.util.Dom.get("prodTypeSelect")){
		prodType = dwr.util.getValue("prodTypeSelect");			
	} else {
		prodType = dwr.util.getValue("prodTypetxt");
	}
	if(prodType == "Sellable"){
	   prodType = "GOODS";
	} else if(prodType == "Non-Sellable"){
		prodType = "SPLY";
	} 
	if(prodType == "SPLY"){
		//R2 Enhancement - Retail for Non Sellables.
		//Dont hide Retail div.. hide individual fields in it.
		//hide the mandatory em for FSA
		for(i = 0;i < 22; i++){
			var section = document.getElementById("forSupply"+i);
			if(section){
				section.style.display = "none";
			}
		}
		if(testScanBtn){				
			testScanBtn.disabled = true; 
			YAHOO.util.Event.removeListener(testScanBtn, "click");
		}
	}else {		
		//R2 Enhancement - Retail for Non Sellables.
		for(i = 0;i < 22; i++){
			var section = document.getElementById("forSupply"+i);
			if(section){
				section.style.display = "block";
			}
		}
		//show the mandatory em for FSA
		if(testScanBtn){
			if(prodType == "GOODS"){
				AddCandidateTemp.isTestScanNeeded(getDWRCallbackMethod(enableTescScanButton));
			}
		}

	}		
}
function enableTescScanButton(testScanNeeded){		
	var testScanBtn = YAHOO.util.Dom.get("testScanBut");
	if(testScanBtn){
		YAHOO.util.Event.removeListener(testScanBtn, "click");
		if(testScanNeeded == true){
			testScanBtn.disabled = false; 
			if(prodType == "GOODS"){
				YAHOO.util.Event.addListener(testScanBtn, "click", testScan);
			}
		}else{
			testScanBtn.disabled = true; 
			if(prodType == "GOODS"){
				YAHOO.util.Event.removeListener(testScanBtn, "click");
			}
		}
	}
}
function nonSellableHideNew(){					
	var testScanBtn = YAHOO.util.Dom.get("testScanBut");
	if(testScanBtn){
		AddCandidateTemp.isTestScanNeeded(getDWRCallbackMethod(enableTescScanButtonNew));
	}			
}
function enableTescScanButtonNew(testScanNeeded){		
	var testScanBtn = YAHOO.util.Dom.get("testScanBut");
	if(testScanBtn){
		YAHOO.util.Event.removeListener(testScanBtn, "click");			
		if(testScanNeeded == true){	
			testScanBtn.disabled = false; 
			YAHOO.util.Event.addListener(testScanBtn, "click", testScan);			
		}else{
			testScanBtn.disabled = true; 
			YAHOO.util.Event.removeListener(testScanBtn, "click");
		}
	}
}
//////////////////////////////////////////////////////////////////////



</script>
	