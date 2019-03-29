<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%@page import="java.util.List"%>
<%@page import="com.heb.operations.business.framework.vo.BaseJSFVO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- 	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">	 -->
	<style type="text/css">		
	   .myAutoCompleteMassFill .yui-ac-content 
		{
				max-height:15em;
				overflow:auto;
				overflow-x:hidden;
				_height:15em;				
				
		}	
		
		
	  #myAutoCompleteBdmMassFill
	    {
			z-index:16000;
		}
		
      #myAutoCompleteComMassFill
	    {
			z-index:16600;
		}
		
	  #myAutoCompleteSubComMassFill
	    {
			z-index:16500;
		}
	.yui-skin-sam .yui-dt-bd .yui-dt-data .yui-dt-even .yui-dt-col-rating,.yui-skin-sam .yui-dt-bd .yui-dt-data .yui-dt-even .yui-dt-col-ratingType {
		word-wrap: break-word;
	}
	</style>
	<script type="text/javascript">
		var subComvaluesAutoConst=[];
		var taxCategoriesAutoConst=[];
		Array.prototype.inArray = function (value)
		{
		// Returns true if the passed value is found in the
		// array. Returns false if it is not.
			var i;
			for (i=0; i < this.length; i++) 
			{
			 if (this[i] == value) 
			 {
			 return true;
			 }
			}
			return false;
		};	

		String.prototype.ReplaceAll = function(stringToFind,stringToReplace){

		    var temp = this;

		    var index = temp.indexOf(stringToFind);

		        while(index != -1){

		            temp = temp.replace(stringToFind,stringToReplace);

		            index = temp.indexOf(stringToFind);

		        }

		        return temp;

		    }

		String.prototype.capitaliseFirstLetter = function(str)	
		{
			return str.charAt(0).toUpperCase() + str.slice(1);
		}

		var SER = YAHOO.namespace('Heb.searchEDIResult');

		SER.arrSpecChar = new Array("+","*","?",".","(",")","[","]","\\","/","|","^","$","&");
		SER.arrConvChar = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n");
		
		SER.numOfSlVdorCand = 0;
		SER.numOfWorkCand = 0;
		SER.numOfActiveFailed = 0;
		SER.currentRecord = 10;
	    SER.currentPage = 1;

		SER.currentRecord="${ManageEDICandidate.currentRecord}";
		SER.currentPage="${ManageEDICandidate.currentPage}";

		SER.itemResultFilter = null;
		SER.hasFilter = false;
		
		SER.convertFromIrToRegularPattern = function(IrStr)
		{
			if(IrStr!='&')
			{
				IrStr=html_entity_decode(IrStr);
			}
			for(var i =0 ;i < SER.arrSpecChar.length; i++)
			{
				IrStr=IrStr.ReplaceAll(SER.arrSpecChar[i],SER.arrConvChar[i]);
			}
			return IrStr;
		}

		//set current record of page
		
		SER.setCurrentRecrdPerPage = function()
		{
			document.getElementById("currentRecord").value = SER.currentRecord;
		}

		function convertSpecialChars(str){
			if(str != null && str != ""){
				str = str.replace(/&quot;/gi, "\"");
				str = str.replace(/&#039;/gi, "\'");					
				str = str.replace(/&#092;/gi, "\\");
			}
			return str;
		}

		function html_entity_decode(str) {
			
			str = str.replace(/</g,"&lt;").replace(/>/g,"&gt;");
			return str;
		}		

		function onlyInputNumbers(evt) {
			var e = evt
			if(window.event){ // IE
				var charCode = e.keyCode;
			} else if (e.which) { // Safari 4, Firefox 3.0.4
				var charCode = e.which
			}
			if (charCode > 31 && (charCode < 48 || charCode > 57))
			return false;
			return true;
		}
		
	</script>
</head>
<body>
<c:if test="${ManageEDICandidate.candidateEDISearchCriteria.actionId != '5'}">
<fieldset id="fMassFill" style="margin-left: 6px; background-color: #FFFFFF; margin-right: 6px; padding-bottom: 1px; 
		padding-top: 5px; color: #000000;position: relative;z-index: 20000;" title="MassFill Section">
<legend style="cursor: pointer; color: #666666"><b>Mass Fill Section</b></legend>	
<div id="massUpdateSection">
<cps:renderByResourceAccess resourceId="164" honorViewMode="">
	<jsp:attribute name="EXEC">	
		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
			<c:if test="${!empty ManageEDICandidate.currentTab}">
				<c:if test="${ManageEDICandidate.currentTab=='sellingUpctab'}">
						<div id="massUpdateSelingSection">
							<c:url value="${request.getContextPath()}/hebAssets/images/dropdown.bmp" var="image"></c:url>
							<table id="massFillTbl" width="100%">
								<tr>
									<td align="right" width="5%">
										<div id="bdmMassFillLabel" style="display:none;">
											BDM
										</div>	
									</td>
									<td width="20%">
										<div class="myAutoCompleteMassFill" id="myAutoCompleteBdmMassFill" style="display:none;">
											<input type="text" id="myInputBdmMassFill"  value="" style='TEXT-TRANSFORM\: uppercase; position: relative;' maxlength='30'/>
												<div id="myContainerBdmMassFill">
											</div>
										</div>																															
									</td>
									<td align="right" width="5%">
									   <div id="comMassFillLabel" style="display:none;">
											Commodity
									   </div>	
									</td>
									<td width="20%">														
										<div class="myAutoCompleteMassFill" id="myAutoCompleteComMassFill" style="display:none;">
											<input type="text" id="myInputComMassFill" value="" style='TEXT-TRANSFORM\: uppercase; position: relative;' maxlength='30'/>
											<div id="myContainerComMassFill"></div>
											<input type='hidden' value='' id='myInputComMassFillHd'/>
										</div>																	
									</td>	
									<td>					
									</td>
									<td>									
									</td>	
								</tr>		
								<tr>
									<td align="right" width="5%">
										<div id="classMassFillLabel" style="display:none;">
											Class
										</div>
									</td>
									<td width="20%">
											<div  id="classMassFill" style="display:none;">
												<input type="text" id="myInputclassMassFill" value="" style='TEXT-TRANSFORM\: uppercase; position: relative;' maxlength='30'/>															
											</div>	
									</td>
								
								<td align="right" width="5%">
									SubCommodity
								</td>
								<td width="25%">
									<div class="myAutoCompleteMassFill" id="myAutoCompleteSubComMassFill">
										<input type="text" id="myInputSubComMassFill" value="" style='TEXT-TRANSFORM\: uppercase; position: relative;width:50%;' maxlength='30'/>
										<div id="myContainerSubComMassFill"></div>
										<input type='hidden' value='' id='myInputSubComMassFillHd'/>
										<input type='hidden' value='' id='myInputBdmMassReTurnFillHd'/>
										&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:return false;" onclick="findSubCommodity();return false;" id="hlink1" tabindex="16">Find Sub Commodity</a>
									</div>									
								</td>
								<!--//BINHHT - add-->
								<cps:renderByResourceAccess resourceId="272">
									<jsp:attribute name="EDIT">
										<td align="right" width="7%">
											Tax Category
										</td>
										<td width="20%">
											<div class="myAutoCompleteMassFill" id="myAutoCompleteTaxCatMassFill">
												<input type="text" id="myInputTaxCatMassFill" value="" style='TEXT-TRANSFORM\: uppercase; position: relative;' maxlength='30'/>
												<div id="myContainerTaxCatMassFill"></div>
												<input type='hidden' value='' id='myInputTaxCatMassFillHd'/>
											</div>
										</td>
									</jsp:attribute>
								</cps:renderByResourceAccess>
								<cps:renderByResourceAccess resourceId="272">
									<jsp:attribute name="VIEW">
										<td align="right" width="7%">
											Tax Category
										</td>
										<td width="20%">
											<div class="myAutoCompleteMassFill" id="myAutoCompleteTaxCatMassFill">
												<input type="text" id="myInputTaxCatMassFill" value="" style='TEXT-TRANSFORM\: uppercase; position: relative;' maxlength='30' disabled="disabled" />
												<div id="myContainerTaxCatMassFill"></div>
												<input type='hidden' value='' id='myInputTaxCatMassFillHd'/>
											</div>
										</td>
									</jsp:attribute>
								</cps:renderByResourceAccess>
								<td>
									<div style="position:relative;" id="findSubCommodityDiv">
									&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' id ='massFillBtnSel' value='Mass Fill' />
									</div>
									<div style="display: none;position: relative;" id="backDiv">
										&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:return false;" onclick="backMassFill();return false;" id="hlink2" tabindex="17">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' id ='massFillBtnSel2' value='Mass Fill'/>
									</div>									
								</td>
								
								<td>
									
								</td>
								</tr>
								
							</table>
						</div>
						<script type="text/javascript">
							
						new YAHOO.widget.Button("massFillBtnSel");
						//*******************BEGIN ADD FUNCTION FOR MASS FILL SECTION**************
						YAHOO.util.Event.addListener(YAHOO.util.Dom.get("massFillBtnSel"), "click", massFillSubCommodity);			
						//*******************BEGIN ADD FUNCTION FOR MASS FILL SECTION**************
						
						new YAHOO.widget.Button("massFillBtnSel2");
						//*******************BEGIN ADD FUNCTION FOR MASS FILL SECTION**************
						YAHOO.util.Event.addListener(YAHOO.util.Dom.get("massFillBtnSel2"), "click", massFillSubCommodity);			
						//*******************BEGIN ADD FUNCTION FOR MASS FILL SECTION**************
						
							
						var isAllDisable=false;
						getBDMAuto = function(query)
						{					
							reslts = [];		
						    for (var i = 0; i < bdmvaluesAuto.length; i++) {
							    var t1 = bdmvaluesAuto[i][0];
							    var t2 = query;
							    var t1Up = t1.toUpperCase();
							    var t2Up = t2.toUpperCase();
							    var v1 = bdmvaluesAuto[i][1];
							    var v1Up = v1.toUpperCase();
							    
						    	if (t1Up.match(t2Up) || v1Up.match(t2Up)) {
						    		reslts.push(bdmvaluesAuto[i]);
						    	}
						    }	   			
						    return reslts;
						};	
						
						var myBdmAuto=function()
						{
							var oACDS = new YAHOO.widget.DS_JSFunction(getBDMAuto);
						    // Instantiate first AutoComplete
						    var oAutoComp = new YAHOO.widget.AutoComplete("myInputBdmMassFill", "myContainerBdmMassFill", oACDS);
						    oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
						   // this.oAutoComp.typeAhead = true;
							oAutoComp.queryQuestionMark = false;
							oAutoComp.forceSelection = false;
							oAutoComp.autoHighlight = true;
							oAutoComp.maxResultsDisplayed = 100;
							oAutoComp.resultTypeList = false;
							oAutoComp.useIFrame = true;
							oAutoComp.minQueryLength=0;
							
							oAutoComp.doBeforeExpandContainer = function() {
							var Dom = YAHOO.util.Dom;
							Dom.setXY("myContainerBdmMassFill", [Dom.getX("myInputBdmMassFill"), Dom.getY("myInputBdmMassFill") + Dom.get("myInputBdmMassFill").offsetHeight] );
							return true;
							}
							
							//display all result when click mouse
							
							  oAutoComp.textboxFocusEvent.subscribe(function() {			
						        var sInputValue = YAHOO.util.Dom.get("myInputBdmMassFill").value;
						        
						        if (sInputValue.length == 0) {
						            var oSelf = this;
						            setTimeout(function() {oSelf.sendQuery("");}, 0);
						        }
						    });
							
							var temp = oAutoComp;
							/*var sendEmptyQuery = function(t1, t2) {			
								var sInputValue = YAHOO.util.Dom.get("myInputBdmMassFill").value;
					            setTimeout(function() {t2.sendQuery("");}, 0);
					            document.getElementById("myInputBdmMassFill").focus();
							};
							
							YAHOO.util.Event.addListener(YAHOO.util.Dom.get("bdmMassFillImage"), "click", sendEmptyQuery,temp);*/
							
							var itemSelectHandler = function(sType, aArgs) {
								var aData = aArgs[2]; //array of the data for the item as returned by the DataSource				
								/*var elm1 = YAHOO.util.Dom.get("subComHd"+id);							
								elm1.value = html_entity_decode(aData[0]);	
								record.setData("subCommodity",elm1.value);*/									
								document.getElementById("myInputComMassFill").value = '';
								document.getElementById("myInputComMassFillHd").value = '';
								document.getElementById("myInputclassMassFill").value = '';
								document.getElementById("myInputSubComMassFill").value = '';
								document.getElementById("myInputSubComMassFillHd").value = '';
								document.getElementById("myInputBdmMassReTurnFillHd").value = '';
								//BINHHT - add
								if(document.getElementById("myInputTaxCatMassFill") != null && document.getElementById("myInputTaxCatMassFill") != undefined){
									document.getElementById("myInputTaxCatMassFill").value = '';
								}
								
								showProgress();								
								ManageEDIDWR.getCommoditiesFromBDM(aData[1], getDWRCallbackMethod(updateCommoditySourceFromBDM));
									
								};
							
							oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
							
							oAutoComp.textboxKeyEvent.subscribe(
								function(nKeycode){
						        	var oSelf = this;
									oSelf.forceSelection = false;
								});
						
							oAutoComp.textboxFocusEvent.subscribe(
									function(){
										var oSelf = this;
										oSelf.forceSelection = false;
							 });
							
							
						}();
						
						//autoComplete commodity
						
						getCommodityAuto=function(query)
						{	
							reslts = [];		
						    for (var i = 0; i < comvaluesAuto.length; i++) {
							    var t1 = comvaluesAuto[i][0];
							    var t2 = query;
							    var t1Up = t1.toUpperCase();
							    var t2Up = t2.toUpperCase();
							    var v1 = comvaluesAuto[i][1];
							    var v1Up = v1.toUpperCase();
							    
						    	if (t1Up.match(t2Up) || v1Up.match(t2Up)) {
						    		reslts.push(comvaluesAuto[i]);
						    	}
						    }	   			
						    return reslts;
						}
						
						var myCommodityAuto =function()
						{
							var oACDS = new YAHOO.widget.DS_JSFunction(getCommodityAuto);
						    // Instantiate first AutoComplete
						    var oAutoComp = new YAHOO.widget.AutoComplete("myInputComMassFill", "myContainerComMassFill", oACDS);
						    oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
						   // this.oAutoComp.typeAhead = true;
							oAutoComp.queryQuestionMark = false;
							oAutoComp.forceSelection = false;
							oAutoComp.autoHighlight = true;
							oAutoComp.maxResultsDisplayed = 100;
							oAutoComp.resultTypeList = false;
							oAutoComp.useIFrame = true;
							oAutoComp.minQueryLength=0;
							
							oAutoComp.doBeforeExpandContainer = function() {
							var Dom = YAHOO.util.Dom;
							Dom.setXY("myContainerComMassFill", [Dom.getX("myInputComMassFill"), Dom.getY("myInputComMassFill") + Dom.get("myInputComMassFill").offsetHeight] );
							return true;
							}
							
							//display all result when click mouse
							
							 oAutoComp.textboxFocusEvent.subscribe(function() {			
						        var sInputValue = YAHOO.util.Dom.get("myInputComMassFill").value;
						        
						        if (sInputValue.length == 0) {
						            var oSelf = this;
						            setTimeout(function() {oSelf.sendQuery("");}, 0);
						        }
						    });
							
							/*var temp = oAutoComp;
							var sendEmptyQuery = function(t1, t2) {			
								var sInputValue = YAHOO.util.Dom.get("myInputComMassFill").value;
					            setTimeout(function() {t2.sendQuery("");}, 0);
					            document.getElementById("myInputComMassFill").focus();
							};
							
							YAHOO.util.Event.addListener(YAHOO.util.Dom.get("comMassFillImage"), "click", sendEmptyQuery,temp);*/
							
							var itemSelectHandler = function(sType, aArgs) {
								var aData = aArgs[2]; //array of the data for the item as returned by the DataSource
								document.getElementById("myInputclassMassFill").value = '';
								document.getElementById("myInputSubComMassFill").value = '';
								document.getElementById("myInputSubComMassFillHd").value = '';
								document.getElementById("myInputBdmMassReTurnFillHd").value = '';
								//BINHHT - add
								if(document.getElementById("myInputTaxCatMassFill") != null && document.getElementById("myInputTaxCatMassFill") != undefined){
									document.getElementById("myInputTaxCatMassFill").value = '';
								}
								
								YAHOO.util.Dom.get("myInputComMassFillHd").value =aData[1];				
								ManageEDIDWR.getClassFromCommNoReturn(aData[1], getDWRCallbackMethod(updateClassAndSubComFromComn));
								
								
								};
							
							oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
							
							oAutoComp.textboxKeyEvent.subscribe(
								function(nKeycode){
						        	var oSelf = this;
									oSelf.forceSelection = false;
								});
						
							oAutoComp.textboxFocusEvent.subscribe(
									function(){
										var oSelf = this;
										oSelf.forceSelection = false;
							 });
						}();
						
						//autoComplete Subcommodity
						
						getSubCommodityAuto = function(query)
						{	
							reslts = [];		
						    for (var i = 0; i < subComvaluesAuto.length; i++) {
							    var t1 = subComvaluesAuto[i][0];
							    var t2 = query;
							    var t1Up = t1.toUpperCase();
							    var t2Up = t2.toUpperCase();
							    var v1 = subComvaluesAuto[i][1];
							    var v1Up = v1.toUpperCase();
							    
						    	if (t1Up.match(t2Up) || v1Up.match(t2Up)) {
						    		reslts.push(subComvaluesAuto[i]);
						    	}
						    }	   			
						    return reslts;
						}
						
						//BINHHT - add
						getTaxCategoryAuto = function(query)
						{	
							reslts = [];		
						    for (var i = 0; i < taxCategoriesAuto.length; i++) {							
							    var t1 = taxCategoriesAuto[i][0];
							    var t2 = query;
							    var t1Up = t1.toUpperCase();
							    var t2Up = t2.toUpperCase();
							    var v1 = taxCategoriesAuto[i][1];
							    var v1Up = v1.toUpperCase();
						    	if (t1Up.match(t2Up) || v1Up.match(t2Up)) {									
						    		reslts.push(taxCategoriesAuto[i]);
						    	}
						    }	   			
						    return reslts;
						}
						
						var mySubCommodityAuto =function()
						{
							var oACDS = new YAHOO.widget.DS_JSFunction(getSubCommodityAuto);
						    // Instantiate first AutoComplete
						    var oAutoComp = new YAHOO.widget.AutoComplete("myInputSubComMassFill", "myContainerSubComMassFill", oACDS);
						    oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
						   // this.oAutoComp.typeAhead = true;
							oAutoComp.queryQuestionMark = false;
							oAutoComp.forceSelection = false;
							oAutoComp.autoHighlight = true;
							oAutoComp.maxResultsDisplayed = 100;
							oAutoComp.resultTypeList = false;
							oAutoComp.useIFrame = true;
							oAutoComp.minQueryLength=0;
							
							oAutoComp.doBeforeExpandContainer = function() {
							var Dom = YAHOO.util.Dom;
							Dom.setXY("myContainerSubComMassFill", [Dom.getX("myInputSubComMassFill"), Dom.getY("myInputSubComMassFill") + Dom.get("myInputSubComMassFill").offsetHeight] );
							return true;
							}
							
							//display all result when click mouse
							
							oAutoComp.textboxFocusEvent.subscribe(function() {			
						        var sInputValue = YAHOO.util.Dom.get("myInputSubComMassFill").value;
						        
						        if (sInputValue.length == 0) {
						            var oSelf = this;
						            setTimeout(function() {oSelf.sendQuery("");}, 0);
						        }
						    });
							
							oAutoComp.textboxChangeEvent.subscribe(function() {			
						        var sInputValue = YAHOO.util.Dom.get("myInputSubComMassFill").value;
						        
						        if (sInputValue.length == 0) {
						            YAHOO.util.Dom.get("myInputSubComMassFillHd").value='';
									YAHOO.util.Dom.get("myInputBdmMassReTurnFillHd").value='';
						        }
						    });
							
							
							/*var temp = oAutoComp;
							var sendEmptyQuery = function(t1, t2) {			
								var sInputValue = YAHOO.util.Dom.get("myInputSubComMassFill").value;
					            setTimeout(function() {t2.sendQuery("");}, 0);
					            document.getElementById("myInputSubComMassFill").focus();
							};
							
							YAHOO.util.Event.addListener(YAHOO.util.Dom.get("subComMassFillImage"), "click", sendEmptyQuery,temp);*/
							
							var itemSelectHandler = function(sType, aArgs) {
								var aData = aArgs[2]; //array of the data for the item as returned by the DataSource									
								YAHOO.util.Dom.get("myInputSubComMassFillHd").value =aData[1];	
								showProgress();
								ManageEDIDWR.getSingleBDMForSubCom(aData[1],
								{
								  callback:function(data) {
										hideProgress();
										var tempData=data.appData;						
										if(tempData.id.length >0)
										{							
											YAHOO.util.Dom.get("myInputBdmMassReTurnFillHd").value=tempData.id+" "+tempData.name;
										}
										else
											{
												alert("subCommodity is not user any more.\nPlease select another subCommodity");
											}
									},
									errorHandler:function(errorString, exception) {
										alert("errors at get data");
										hideProgress();
									},
									timeout:180000
								});		
								};
							
							oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
							
							oAutoComp.textboxKeyEvent.subscribe(
								function(nKeycode){
						        	var oSelf = this;
									oSelf.forceSelection = false;
								});
						
							oAutoComp.textboxFocusEvent.subscribe(
									function(){
										var oSelf = this;
										oSelf.forceSelection = false;
							 });
						}();
						
						var myTaxCategoryAuto =function()
						{
							var oACDS = new YAHOO.widget.DS_JSFunction(getTaxCategoryAuto);
						    // Instantiate first AutoComplete
						    if(YAHOO.util.Dom.get("myInputTaxCatMassFill") != null && YAHOO.util.Dom.get("myInputTaxCatMassFill") != undefined) {
						    var oAutoComp = new YAHOO.widget.AutoComplete("myInputTaxCatMassFill", "myContainerTaxCatMassFill", oACDS);
						    	oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
								   // this.oAutoComp.typeAhead = true;
									oAutoComp.queryQuestionMark = false;
									oAutoComp.forceSelection = false;
									oAutoComp.autoHighlight = true;
									oAutoComp.maxResultsDisplayed = 100;
									oAutoComp.resultTypeList = false;
									oAutoComp.useIFrame = true;
									oAutoComp.minQueryLength=0;
									
									oAutoComp.doBeforeExpandContainer = function() {
									var Dom = YAHOO.util.Dom;
									Dom.setXY("myContainerTaxCatMassFill", [Dom.getX("myInputTaxCatMassFill"), Dom.getY("myInputTaxCatMassFill") + Dom.get("myInputTaxCatMassFill").offsetHeight] );
									return true;
									}
									
									//display all result when click mouse
									 oAutoComp.textboxFocusEvent.subscribe(function() {
											var sInputValue = YAHOO.util.Dom.get("myInputTaxCatMassFill").value;
									        if (sInputValue.length == 0) {
									            var oSelf = this;
									            setTimeout(function() {oSelf.sendQuery("");}, 0);
									        }
									 });
									 oAutoComp.textboxChangeEvent.subscribe(function() {			
									        var sInputValue = YAHOO.util.Dom.get("myInputTaxCatMassFill").value;
									        
									        if (sInputValue.length == 0) {
									            YAHOO.util.Dom.get("myInputTaxCatMassFillHd").value='';
									        }
									    });
									 var itemSelectHandler = function(sType, aArgs) {
											var aData = aArgs[2]; //array of the data for the item as returned by the DataSource									
											YAHOO.util.Dom.get("myInputTaxCatMassFillHd").value =aData[1];	
											//showProgress();	
										};
										oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
									/*var temp = oAutoComp;
									var sendEmptyQuery = function(t1, t2) {			
										var sInputValue = YAHOO.util.Dom.get("myInputTaxCatMassFill").value;
							            setTimeout(function() {t2.sendQuery("");}, 0);
							            document.getElementById("myInputTaxCatMassFill").focus();
									};
									
									YAHOO.util.Event.addListener(YAHOO.util.Dom.get("taxCatMassFillImage"), "click", sendEmptyQuery,temp);*/
									
									oAutoComp.textboxKeyEvent.subscribe(
										function(nKeycode){
								        	var oSelf = this;
											oSelf.forceSelection = false;
										});
								
									oAutoComp.textboxFocusEvent.subscribe(
											function(){
												var oSelf = this;
												oSelf.forceSelection = false;
									 });
							}
						}();
						
						function getInitDataForAutoComplete()
						{		
							ManageEDIDWR.getAllBDMs(getDWRCallbackMethod(fillValueBDM));
							ManageEDIDWR.getAllSubCommodities(getDWRCallbackMethod(fillSubCommodityValue));
							//BINHHT -add
							ManageEDIDWR.getAllTaxCategories(getDWRCallbackMethod(fillTaxCategoryValue));
						}
						function fillValueBDM(data)
						{
							//alert(data.length);
							var temArr=[];
							
							if(data.length >0)
							{					
								for (var i = 0; i < data.length; i++) 
								{						
									temArr.push([data[i].name,data[i].id]);
								}
								
							}
							bdmvaluesAuto=temArr;
						}
						
						function fillSubCommodityValue(data)
						{	
						
							var temArr=[];
							
							if(data.length >0)
							{					
								for (var i = 0; i < data.length; i++) 
								{						
									temArr.push([data[i].name,data[i].id]);
								}
								
							}
							subComvaluesAutoConst=temArr;
							subComvaluesAuto =subComvaluesAutoConst;							
						}
						
						//BINHHT -add
						function fillTaxCategoryValue(data)
						{	
						
							var temArr=[];
							
							if(data.length >0)
							{					
								for (var i = 0; i < data.length; i++) 
								{						
									temArr.push([data[i].name,data[i].id]);
								}
								
							}
							taxCategoriesAutoConst=temArr;
							taxCategoriesAuto =taxCategoriesAutoConst;							
						}
						
						function updateCommoditySourceFromBDM(data)
						{
							var temArr=[];
							
							if(data.length >0)
							{					
								for (var i = 0; i < data.length; i++) 
								{						
									temArr.push([data[i].name,data[i].id]);
								}
								
							}
							else
							{
								alert("There is no commodity for this BDM");
							}
							comvaluesAuto=temArr;
							hideProgress();
						}
						
						function updateClassAndSubComFromComn(data)
						{
							YAHOO.util.Dom.get("myInputclassMassFill").value = ''+data.name+' ['+data.id+']';
							var comMassFillHd=YAHOO.util.Dom.get("myInputComMassFillHd").value;
							showProgress();
							ManageEDIDWR.getSubCommodityForClassCommodity(data.id,comMassFillHd,getDWRCallbackMethod(getSubCommForComm));
							
							
						}
						function getSubCommForComm(data)
						{
							var temArr=[];
							
							if(data.length >0)
							{					
								for (var i = 0; i < data.length; i++) 
								{						
									temArr.push([data[i].name,data[i].id]);
								}
								
							}
							subComvaluesAuto=temArr;				
							hideProgress();
						}
						
						function massFillSubCommodity(evt)
						{				

							isAllDisable = false;
							
							if((YAHOO.util.Dom.get("myInputSubComMassFillHd") != null && YAHOO.util.Dom.get("myInputSubComMassFillHd") != undefined && YAHOO.util.Dom.get("myInputSubComMassFillHd").value.length==0) && YAHOO.util.Dom.get("myInputTaxCatMassFillHd").value.length==0)
							{
								if(YAHOO.util.Dom.get("myInputSubComMassFillHd") != null && YAHOO.util.Dom.get("myInputSubComMassFillHd") != undefined){
									alert("Please select Subcommodity or Tax Category to mass fill.");
									return false;
								}else {
									alert("Please select Subcommodity to mass fill.");
									return false;
								}
								
							}
							
							var arrCheck=getCheckList();							
								
							if(arrCheck.length==0)
							{
								alert("Please select at least one row to mass fill.");
							}
							else
							{
								if(!isAllDisable)
								{
									if((YAHOO.util.Dom.get("myInputSubComMassFillHd") != null && YAHOO.util.Dom.get("myInputSubComMassFillHd").value != null && YAHOO.util.Dom.get("myInputSubComMassFillHd").value.length==0) && YAHOO.util.Dom.get("myInputTaxCatMassFillHd").value.length!=0){
										massFillDataTableTaxCategory();
									}else if(YAHOO.util.Dom.get("myInputSubComMassFillHd").value.length!=0){
										showProgress();
										ManageEDIDWR.validateDeptAndSubDept(YAHOO.util.Dom.get("myInputSubComMassFillHd").value,YAHOO.util.Dom.get("myInputBdmMassReTurnFillHd").value,arrCheck,getDWRCallbackMethod(massFillDataTableSellingUpc));
									}
								}	
								
							}
						}
						
						function getCheckList()
						{									
							var cntDisable = 0;	

							var cntRrcdDisable = 0;
							var arrCheck= new Array();										
							for(var i=0;i < Ex.dataSourceTemp.length;i++)
								{
										
										var comp = YAHOO.lang;
										var cK=Ex.dataSourceTemp[i].checkBox;
										var bChecked = cK.split("CHECKED");
										//if check						
										bChecked = (bChecked[1]) ? "checked" : "";																										
										if(bChecked=="checked")
										{											
											arrCheck.push(Ex.dataSourceTemp[i].idRowHidden);
											if(comp.trim(Ex.dataSourceTemp[i].disableStatus)=="true")
											{
												cntRrcdDisable++;
											}
										}
																				
										if(comp.trim(Ex.dataSourceTemp[i].disableStatus)=="true")
										{
											cntDisable++;
										}										
								}

								if(cntDisable ==Ex.dataSourceTemp.length || cntRrcdDisable == arrCheck.length)
								{
									isAllDisable = true;
								}
								return arrCheck;
							
							
						}
						function massFillDataTableSellingUpc(data)
						{
							hideProgress();
							if(data.message != null && data.message != '')
							{
								alert(data.message);
								return false;
							}

							else
							{	
								//var arrSubCom=document.getElementsByName("selingUpcList");								
								var myTable = Ex.myDataTable;
								var comp = YAHOO.lang;
								var oRS=myTable.getRecordSet();	
								for(var i = 0 ;i< oRS.getLength() ;i++)								
								{
									var oRec = oRS.getRecord(i);									
									var cK=oRec.getData("checkBox");
									var bChecked = cK.split("CHECKED");
									//if check						
									bChecked = (bChecked[1]) ? "checked" : "";																																												
									if(comp.trim(oRec.getData("disableStatus")) == "false" && bChecked=="checked")
									{
										oRec.setData("subCommodity",document.getElementById("myInputSubComMassFill").value);	
										oRec.setData("subComHidden",YAHOO.util.Dom.get("myInputSubComMassFillHd").value);
										oRec.setData("bdm",YAHOO.util.Dom.get("myInputBdmMassReTurnFillHd").value);												
										oRec.setData("subDept",data.subDept);									
									}
								}
								
								Ex.isChangeRequest=true;								
								myTable.render();
								massFillDataSourceSellingTab(data);
								
								if(YAHOO.util.Dom.get("myInputTaxCatMassFillHd").value.length!=0){
									massFillDataTableTaxCategory();
								}
							}
							
						}

						function massFillDataSourceSellingTab(data)
						{
							for(var i=0;i < Ex.dataSourceTemp.length;i++)
							{
									
									var comp = YAHOO.lang;
									var cK=Ex.dataSourceTemp[i].checkBox;
									var bChecked = cK.split("CHECKED");
									//if check						
									bChecked = (bChecked[1]) ? "checked" : "";																										
									if(bChecked=="checked" && comp.trim(Ex.dataSourceTemp[i].disableStatus)=="false")
									{
										
										Ex.dataSourceTemp[i].subComHidden=YAHOO.util.Dom.get("myInputSubComMassFillHd").value;	
										Ex.dataSourceTemp[i].subCommodity=document.getElementById("myInputSubComMassFill").value;		
										Ex.dataSourceTemp[i].bdm=YAHOO.util.Dom.get("myInputBdmMassReTurnFillHd").value;
										Ex.dataSourceTemp[i].subDept = data.subDept;										
									}										
							}
						}
						
						//BINHHT -add *************************
						function massFillDataTableTaxCategory()
						{														
							var myTable = Ex.myDataTable;
							var comp = YAHOO.lang;
							var oRS=myTable.getRecordSet();	
							for(var i = 0 ;i< oRS.getLength() ;i++)								
							{
								var oRec = oRS.getRecord(i);									
								var cK=oRec.getData("checkBox");
								var bChecked = cK.split("CHECKED");
								//if check						
								bChecked = (bChecked[1]) ? "checked" : "";																																												
								if(comp.trim(oRec.getData("disableStatus")) == "false" && bChecked=="checked")
								{
									oRec.setData("taxCategory",document.getElementById("myInputTaxCatMassFill").value);	
									oRec.setData("taxCatHidden",YAHOO.util.Dom.get("myInputTaxCatMassFillHd").value);																			
								}
							}
							
							Ex.isChangeRequest=true;								
							myTable.render();
							massFillDataSourceTaxCategory();						
						}

						function massFillDataSourceTaxCategory()
						{
							for(var i=0;i < Ex.dataSourceTemp.length;i++)
							{
									
									var comp = YAHOO.lang;
									var cK=Ex.dataSourceTemp[i].checkBox;
									var bChecked = cK.split("CHECKED");
									//if check						
									bChecked = (bChecked[1]) ? "checked" : "";																										
									if(bChecked=="checked" && comp.trim(Ex.dataSourceTemp[i].disableStatus)=="false")
									{										
										Ex.dataSourceTemp[i].taxCatHidden=YAHOO.util.Dom.get("myInputTaxCatMassFillHd").value;	
										Ex.dataSourceTemp[i].taxCategory=document.getElementById("myInputTaxCatMassFill").value;											
									}										
							}
						}
						//BINHHT -add *************************
						
						function findSubCommodity()
							{
							
								document.getElementById("myInputSubComMassFill").value = '';
								document.getElementById("myInputSubComMassFillHd").value = '';
								document.getElementById("myInputBdmMassReTurnFillHd").value = '';

								document.getElementById("myInputBdmMassFill").value = '';
								document.getElementById("myInputComMassFill").value = '';
								document.getElementById("myInputComMassFillHd").value = '';
								document.getElementById("myInputclassMassFill").value = '';
								      
								document.getElementById("bdmMassFillLabel").style.display='block';	
								document.getElementById("comMassFillLabel").style.display='block';
								document.getElementById("myAutoCompleteBdmMassFill").style.display='block';
								document.getElementById("myAutoCompleteComMassFill").style.display='block';
								document.getElementById("classMassFill").style.display='block';
								document.getElementById("classMassFillLabel").style.display='block';
								document.getElementById("findSubCommodityDiv").style.display='none';
								document.getElementById("backDiv").style.display='block';
								subComvaluesAuto=[];								
							}
							
							function backMassFill()
							{
								document.getElementById("myInputSubComMassFill").value = '';
								document.getElementById("myInputSubComMassFillHd").value = '';
								document.getElementById("myInputBdmMassReTurnFillHd").value = '';									
								document.getElementById("bdmMassFillLabel").style.display='none';	
								document.getElementById("comMassFillLabel").style.display='none';
								document.getElementById("myAutoCompleteBdmMassFill").style.display='none';
								document.getElementById("myAutoCompleteComMassFill").style.display='none';
								document.getElementById("classMassFill").style.display='none';
								document.getElementById("classMassFillLabel").style.display='none';
								document.getElementById("findSubCommodityDiv").style.display='block';
								document.getElementById("backDiv").style.display='none';
								subComvaluesAuto=subComvaluesAutoConst;
							}

							YAHOO.util.Event.onDOMReady(getInitDataForAutoComplete);
						</script>
				</c:if>
		</c:if >
		
		</jsp:attribute>
	</cps:renderByResourceAccess>
	
	<cps:renderByResourceAccess resourceId="164" honorViewMode="">
		<jsp:attribute name="EXEC">
				<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
			<c:if test="${!empty ManageEDICandidate.currentTab}">
						<c:if test="${ManageEDICandidate.currentTab=='descriptionAndSizeTab'}">
								<div id="massUpdateDescAndSizeSection">
								<div id="MassFill">
									<table cellspacing="10">
										<tr>
											<td align="right">Description :</td>
											<td><input type="text" id="txtMF_DES" onblur="valdKeyPressSymbSpec(this);" maxlength="30"/></td>
											<td align="right">CFD1 :</td>
											<td><input type="text" id="txtMF_CFD1" onblur="camelCase1();" maxlength="30"/></td>
											<td align="right">CFD2 :</td>
											<td><input type="text" id="txtMF_CFD2" onblur="camelCase2();" maxlength="30"/></td>
											<td align="right">Size Text :</td>
											<td><input type="text" id="txtMF_SZT" maxlength="6"/></td>
											<td></td>
											<td><input type="button" value="Mass Fill" id ="massFillBtn" /></td>
										</tr>
									</table>	
								<script type="text/javascript">
									new YAHOO.widget.Button("massFillBtn");
								</script>
									</div>
								</div>	
						</c:if>
				</c:if>
				<%--</logic:present >--%>
		</jsp:attribute>
	</cps:renderByResourceAccess>
	
	<cps:renderByResourceAccess resourceId="164" honorViewMode="">
		<jsp:attribute name="EXEC">
			<c:if test="${!empty ManageEDICandidate.currentTab}">
		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
				<c:if test="${ManageEDICandidate.currentTab=='casePackTab'}">
						<div id="massUpdateCasePackSection">
						<div id="MassFill">
							<table cellspacing="10">
								<tr>
									<td align="right">&nbsp;</td>
									<td>&nbsp;</td>
									<td align="right">&nbsp;</td>
									<td>&nbsp;</td>
									<td align="right">&nbsp;</td>
									<td>&nbsp;</td>
									<td align="right">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							</table>	
							</div>
						</div>
				</c:if>
			</c:if>
		<%--</logic:present >--%>
	</jsp:attribute>
	</cps:renderByResourceAccess>
	
	<cps:renderByResourceAccess resourceId="164" honorViewMode="">
		<jsp:attribute name="EXEC">	
		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
			<c:if test="${!empty ManageEDICandidate.currentTab}">
				<c:if test="${ManageEDICandidate.currentTab=='costAndRetailTab'}">
						<div id="massUpdateCostAndRetailSection">
								<table cellspacing="10">
									<tr>
										<td align="right">Actual Multiple Retail :</td>
										<td><input type="text" id="txtMF_AMR" maxlength="5" style="dataType : numeric;" onchange="validateAR();" /></td>
										<td align="right">Retail Link :</td>
										<td><input type="text" id="txtMF_RetailLink"  maxlength="13" style="dataType : numeric;" onchange="showPopupRTL();"/></td>
									</tr>
									<tr>
										<td align="right">Actual Retail :</td>
										<td><input type="text" id="txtMF_AR" maxlength="12" style="dataType : float;" onchange="validateAR();"/></td>
										<td></td>
										<td><input type="button" value="Mass Fill" id ="massFillBtnCostAndRetail" /></td>
									</tr>
								</table>	
							
						<script type="text/javascript">
							new YAHOO.widget.Button("massFillBtnCostAndRetail");
						</script>
						</div>
				</c:if>
			</c:if>
		<%--</logic:present >--%>
		</jsp:attribute>
	</cps:renderByResourceAccess>
	<cps:renderByResourceAccess resourceId="164" honorViewMode="">
		<jsp:attribute name="EXEC">
			<c:if test="${!empty ManageEDICandidate.currentTab}">
		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
				<c:if test="${ManageEDICandidate.currentTab=='otherAttributeTab'}">
						<div id="massUpdateOtherAtrSection">
							<table width="80%">
								<tr>
									<td width="50%">
										<fieldset>
											<legend>Code dating</legend>
											<table>
												<tr>
													<td align="right" style="padding-left: 10px; padding-right: 10px">Inbound Spec Days:</td>
													<td>
														<input id="inboundSpecDays" type="text" size="6" maxlength="4" onkeypress="return onlyInputNumbers(event);"/>
													</td>
													<td align="right" style="padding-left: 10px; padding-right: 10px">Reaction Days:</td>
													<td>
														<input id="reactionDays" type="text" size="6" maxlength="4" onkeypress="return onlyInputNumbers(event);"/>
													</td>
												</tr>
												<tr>
													<td align="right" style="padding-left: 10px; padding-right: 10px">Guarantee to Store:</td>
													<td>
														<input id="guaranteeToStoreDays" type="text" size="6" maxlength="4" onkeypress="return onlyInputNumbers(event);"/>
													</td>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>
											</table>
										</fieldset>
									</td>
									<td>
										<table>
											<tr>
												<td align="right" style="padding-left: 10px; padding-right: 10px">Seasonality Year:</td>
												<td align="left">
													<select id="seasonalityYear">
													</select>
													<script type="text/javascript">
														//add item into combo seasonalityYear
														var seasonalityYear = document.getElementById("seasonalityYear");
														var optionEmpty=document.createElement("option");
														optionEmpty.value = '';
														optionEmpty.text = '-- Select -- ';
														try{
												        	  // for IE earlier than version 8
												        	  seasonalityYear.add(optionEmpty,seasonalityYear.options[null]);
											        	  }
											        	catch (e)
											        	  {
											        		seasonalityYear.add(optionEmpty,null);
											        	  }     
														var year = (new Date()).getFullYear();
												        for (var i=0;i<=10;i++)
												    	{
												        	var option=document.createElement("option");
												        	option.value = year + i;
												        	option.text = year + i;
												        	try{
													        	  // for IE earlier than version 8
													        	  seasonalityYear.add(option,seasonalityYear.options[null]);
												        	  }
												        	catch (e)
												        	  {
												        		seasonalityYear.add(option,null);
												        	  }      	        	
												    	} 

												        //Vendor isn't allow to modify Reaction Day and Guarantee to store day
														if(${ManageEDICandidate.isVendor}) {
															document.getElementById("reactionDays").readOnly  = true;
															document.getElementById("guaranteeToStoreDays").readOnly  = true;
														}
													</script>
												</td>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td align="right" style="padding-left: 10px; padding-right: 10px">Seasonality:</td>
												<td align="left">												   
													<select id="seasonality">
														<c:if test="${!empty listSeasonality}">
															<c:forEach items="${listSeasonality}" var="seasonal">
																<c:if test="${seasonal.name == 'EVERYDAY'}">
																	<option value="${seasonal.id}" selected="selected">${seasonal.name}</option>
																</c:if>
																<c:if test="${seasonal.name != 'EVERYDAY'}">
																	<option value="${seasonal.id}">${seasonal.name}</option>
																</c:if>
															</c:forEach>
														</c:if>
													</select>
												</td>
												<td style="padding-left: 10px;"><input type="button" id ="massFillBtn" value="Mass Fill" /></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
							<script type="text/javascript">
									new YAHOO.widget.Button("massFillBtn");
								</script>
						</div>
				</c:if>
		<%--</logic:present >--%>
			</c:if>
	</jsp:attribute>
	</cps:renderByResourceAccess>
	
	<cps:renderByResourceAccess resourceId="164" honorViewMode="">
		<jsp:attribute name="EXEC">
			<c:if test="${!empty ManageEDICandidate.currentTab}">
		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
				<c:if test="${ManageEDICandidate.currentTab=='authorizationAndDistributionTab'}">
						<div id="massUpdateAuthorAndDisSection">
						</div>
				</c:if>
		<%--</logic:present >--%>
			</c:if>
		</jsp:attribute>
	</cps:renderByResourceAccess>
		
</div>	
</fieldset>
</c:if>
<form:hidden path="productSelectedIds" id="productSelectedIds"/>
<form:hidden path="selectedProductId" id="selectedProductId"/>
<form:hidden path="psWorkSelectedIds" id="psWorkSelectedIds"/>
<form:hidden path="filterValues" id="filterValues"/>
<form:hidden path="itemsResultFilter" id="itemsResultFilter"/>
<form:hidden path="currentRecord" id="currentRecord"/>
<input type="hidden" id="psWrkActiveFailSelectedIds" name="psWrkActiveFailSelectedId"/>


<script type="text/javascript">
	if(document.getElementById('itemsResultFilter').value != ""){
		SER.itemResultFilter = document.getElementById('itemsResultFilter').value;
		document.getElementById('itemsResultFilter').value = "";
	}
</script>

<div id="ediTabView" class="yui-navset" style="margin-left: 6px; margin-right: 6px; padding-top: 5px; padding-bottom: 5px;">
	<ul class="yui-nav">   
        <li><a id="sellingUPCTabBut"><em>Selling UPC</em></a></li>  
        <li><a id="descriptionSizeTabBut"><em>Description/Size</em></a></li>  
        <li><a id="casePackTabBut"><em>Case Pack</em></a></li>  
        <li><a id="costRetailTabBut"><em>Cost & Retail</em></a></li> 
        <li><a id="otherAttributesTabBut"><em>Other Attributes</em></a></li> 
        <li><a id="authorizationDistributionTabBut"><em>Authorization/Distribution</em></a></li> 
    </ul>    
     <div class="yui-content" style="width:99%; overflow-x:scroll ; overflow-y: hidden;">
		 <c:if test="${!empty ManageEDICandidate.currentTab}">
     	<%--<logic:present name="CPSEDIMain"  property="currentTab" >		--%>
				<c:if test="${ManageEDICandidate.currentTab=='sellingUpctab'}">
						<div id="sellingUPCDiv">		
							<jsp:include page="/cps/manageEDI/modules/sellingUpc.jsp" />
						</div>
						<div></div>
						<div></div>
						<div></div>
						<div></div>
						<div></div>
				</c:if>
		 </c:if>
		<%--</logic:present >--%>
		 <c:if test="${!empty ManageEDICandidate.currentTab}">
		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
				<c:if test="${ManageEDICandidate.currentTab=='descriptionAndSizeTab'}">
						<div></div>
						<div id="descriptionAndSizeDiv">		
							<jsp:include page="/cps/manageEDI/modules/descriptionAndSize.jsp" />
						</div>
						<div></div>
						<div></div>
						<div></div>
						<div></div>
				</c:if>
		 </c:if>
		<%--</logic:present >--%>
		<c:if test="${!empty ManageEDICandidate.currentTab}">
		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
				<c:if test="${ManageEDICandidate.currentTab=='casePackTab'}">
						<div></div>
						<div></div>
						<div id="casePackDiv">		
							<jsp:include page="/cps/manageEDI/modules/casePack.jsp" />
						</div>
						<div></div>
						<div></div>
						<div></div>
				</c:if>
		</c:if>
		<%--</logic:present >--%>
		<c:if test="${!empty ManageEDICandidate.currentTab}">
		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
				<c:if test="${ManageEDICandidate.currentTab=='costAndRetailTab'}">
						<div></div>
						<div></div>
						<div></div>
						<div id="costAndRetailDiv">		
							<jsp:include page="/cps/manageEDI/modules/costAndRetail.jsp" />
						</div>
						<div></div>
						<div></div>
				</c:if>
		</c:if>
		<%--</logic:present >--%>
		<c:if test="${!empty ManageEDICandidate.currentTab}">
		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
				<c:if test="${ManageEDICandidate.currentTab=='otherAttributeTab'}">
						<div></div>
						<div></div>
						<div></div>
						<div></div>
						<div id="otherAttributeDiv">		
							<c:if test="${ManageEDICandidate.candidateEDISearchCriteria.actionId != '5'}">
							<jsp:include page="/cps/manageEDI/modules/otherAttribute.jsp" />
							</c:if>
							<c:if test="${ManageEDICandidate.candidateEDISearchCriteria.actionId == '5'}">
								<jsp:include page="/cps/manageEDI/modules/otherAttributeForActiveProd.jsp" />
							</c:if>									
						</div>
						<div></div>
				</c:if>
		</c:if>
		<%--</logic:present >--%>
		<c:if test="${!empty ManageEDICandidate.currentTab}">
		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
				<c:if test="${ManageEDICandidate.currentTab=='authorizationAndDistributionTab'}">
						<div></div>
						<div></div>
						<div></div>
						<div></div>
						<div></div>
						<div id="authorizationAndDistributionDiv">		
							<jsp:include page="/cps/manageEDI/modules/authorizationAndDistribution.jsp" />
						</div>
				</c:if>
		<%--</logic:present >--%>
		</c:if>
     </div> 	
</div>
<script type="text/javascript">
	hideTable();
	 hideBorder('f1','hide');	

	var bdmvaluesAuto=[];
	var comvaluesAuto=[];
	var subComvaluesAuto=[];
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("sellingUPCTabBut"), "click", getSellingUpcDetails);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("descriptionSizeTabBut"), "click", getDescriptionAndSizeTab);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("casePackTabBut"), "click", getCasePackTab);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("costRetailTabBut"), "click", getCostAndRetailDetail);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("otherAttributesTabBut"), "click", getOtherAttributeTab);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authorizationDistributionTabBut"), "click", getAuthorizationDistributionTab);
<c:url value="/protected/cps/manageEDI/getSellingUpcSectionDetails?${_csrf.parameterName}=${_csrf.token}" var="sellingUpcUrl" />


	function getSellingUpcDetails(evt)
	{
		doLoadTabData(1);
	}
	<c:url value="/protected/cps/manageEDI/getDescriptionAndSizeDetail?${_csrf.parameterName}=${_csrf.token}" var="desAndSizeUrl" />

	function getDescriptionAndSizeTab(evt)
	{
		//doBeforeLoadDescriptionAndSize();
		doLoadTabData(2);
		
	}
	var curTab=getCurrentTab();	
	
	function getCurrentTab()
	{
		<%--<logic:present name="CPSEDIMain"  property="currentTab" >		--%>
		<c:if test="${!empty ManageEDICandidate.currentTab}">
			<c:if test="${ManageEDICandidate.currentTab=='sellingUpctab'}">
				return 1;
			</c:if>
			<c:if test="${ManageEDICandidate.currentTab=='descriptionAndSizeTab'}">
				return 2;
			</c:if>
			<c:if test="${ManageEDICandidate.currentTab=='casePackTab'}">
				return 3;
			</c:if>
			<c:if test="${ManageEDICandidate.currentTab=='costAndRetailTab'}">
				return 4;
			</c:if>
			<c:if test="${ManageEDICandidate.currentTab=='otherAttributeTab'}">
				return 5;
			</c:if>
			<c:if test="${ManageEDICandidate.currentTab=='authorizationAndDistributionTab'}">
				return 6;
			</c:if>
		</c:if>
		<%--</logic:present >--%>

		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
			<%--<c:if test="${CPSEDIMain.currentTab=='descriptionAndSizeTab'}">--%>
				<%--return 2;--%>
			<%--</c:if>--%>
		<%--</logic:present >--%>

		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
			<%--<c:if test="${CPSEDIMain.currentTab=='casePackTab'}">--%>
				<%--return 3;--%>
			<%--</c:if>--%>
		<%--</logic:present >--%>

		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
			<%--<c:if test="${CPSEDIMain.currentTab=='costAndRetailTab'}">--%>
				<%--return 4;--%>
			<%--</c:if>--%>
		<%--</logic:present >--%>

		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
			<%--<c:if test="${CPSEDIMain.currentTab=='otherAttributeTab'}">--%>
				<%--return 5;--%>
			<%--</c:if>--%>
		<%--</logic:present >--%>

		<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
			<%--<c:if test="${CPSEDIMain.currentTab=='authorizationAndDistributionTab'}">--%>
				<%--return 6;--%>
			<%--</c:if>--%>
		<%--</logic:present >--%>
	}
	
	<c:url value="/protected/cps/manageEDI/getCasePackDetail?${_csrf.parameterName}=${_csrf.token}" var="casePackUrl" />

	function getCasePackTab(evt)
	{
		doLoadTabData(3);
	}

	<c:url value="/protected/cps/manageEDI/getOtherAttribute?${_csrf.parameterName}=${_csrf.token}" var="linkOtherAttribute"></c:url>

	function getOtherAttributeTab(evt){
		doLoadTabData(5);
	}

	<c:url value="/protected/cps/manageEDI/getAuthorizationDistribution?${_csrf.parameterName}=${_csrf.token}" var="linkAuthorizationDistribution"></c:url>

	function getAuthorizationDistributionTab(evt){
		doLoadTabData(6);
	}
		
	<c:url value="/protected/cps/manageEDI/getCostAndRetailDetail?${_csrf.parameterName}=${_csrf.token}" var="costAndRetailUrl" />
	function getCostAndRetailDetail(evt)
	{
		doLoadTabData(4);
	}

		
	SER.toTab=0;
	 function doLoadTabData(to)
	 {
		  
		  SER.toTab = to;		
			var from=curTab;					
			switch(from)
			{
			case 1:			
			  //do before change from selling upc to 'to' tab
			  doBeforeLoadDatas(to);
			  break;
			case 2:
			  doBeforeLoadDatas(to);
			  break;
			case 3:
			  setResultFilter();
			  loadTabDatas(to);
			  break;
			case 4:
			  doBeforeLoadDatas(to);
			  break;  
			case 5:
			  //do before change from otherAtribute tab to 'to' tab
			  doBeforeLoadDatas(to);
			  break;    
			case 6:
			  setResultFilter();
			  loadTabDatas(to);
			  break;    
			default:
			  loadTabDatas(1);
			  break;
			}				
		//save data and get data for new tab
		
	}
	
	function doBeforeLoadDatas(to)
	{
		setResultFilter();
		
		<c:if test="${ManageEDICandidate.candidateEDISearchCriteria.actionId != '5'}">
		if(curTab==1)
		{		
			//save selling Upc detail and load data	
			saveSellingUpcBeforeLoadNewTab(to);
		}
		if(curTab==2)
		{
			saveDescriptionAndSizeBeforeLoadNewTab(to);
		}
		if(curTab==4)
		{
			saveCostAndRetailBeforeLoadNewTab(to);
		}
		if(curTab==5)
		{
			saveOtherAttributeBeforeLoadNewTab(to);			
		}		
		</c:if>	
		<c:if test="${ManageEDICandidate.candidateEDISearchCriteria.actionId == '5'}">
			loadTabDatas(to);
		</c:if>	
	}
	var toValue;
	function saveSellingUpcBeforeLoadNewTab(to)
	{
			var isHaveCheck=false;			
			var arrPsProdIdCheck = "";								
			for(var i=0;i < Ex.dataSourceTemp.length;i++)
			{
					
				var comp = YAHOO.lang;
				var cK=Ex.dataSourceTemp[i].checkBox;									
				if(comp.trim(Ex.dataSourceTemp[i].subComHidden)!="0" || comp.trim(Ex.dataSourceTemp[i].taxCatHidden)!="0")
				{
							isHaveCheck=true;
							var objSave=new Object();
							var idRow =comp.trim(Ex.dataSourceTemp[i].idRowHidden);	
							//get id to get Ps work id and psProdId
							var arrMainValue=idRow.split("__");								
							arrPsProdIdCheck = arrPsProdIdCheck+arrMainValue[1] + ",";	 																						
					}
					
			}
			
			if(isHaveCheck)
			{				
				if(arrPsProdIdCheck !=""){
					arrPsProdIdCheck = arrPsProdIdCheck.substr(0,arrPsProdIdCheck.lastIndexOf(','));
					showProgress();				 
					toValue = to;						
					ManageEDIDWR.checkMultilPluReuseEDI(arrPsProdIdCheck,getDWRCallbackMethod(saveSellingUpcBeforeLoadNewTabBack));									
				}	
			}
			else
			{				
				loadTabDatas(to);		
			}		
	}
	function saveSellingUpcBeforeLoadNewTabBack(data){	
		if(data!='' && data == true){		
			alert('PLU(s) tied to a vendor candidate/working candidate/ an existing product. \nThis candidate cannot be modified.');	
			hideProgress();	
		} else {
			var isHaveCheck=false;
			var arrPsWorkId="";
			var arrPsProdId="";
			var arrPsSubcom="";				
			
			var arrPsTaxWorkId="";
			var arrPsTaxProdId="";
			var arrPsTaxCat="";	
			for(var i=0;i < Ex.dataSourceTemp.length;i++)
			{					
				var comp = YAHOO.lang;
				var cK=Ex.dataSourceTemp[i].checkBox;									
				if(comp.trim(Ex.dataSourceTemp[i].subComHidden)!="0")
				{
						isHaveCheck=true;
						var objSave=new Object();
						var idRow =comp.trim(Ex.dataSourceTemp[i].idRowHidden);	
						//get id to get Ps work id and psProdId
						var arrMainValue=idRow.split("__");	
						if(arrPsWorkId == "")
						{
							arrPsWorkId+=arrMainValue[0];									
						}
						else
						{
							arrPsWorkId+="__"+arrMainValue[0];									
						}	

						if(arrPsProdId == "")
						{									
							arrPsProdId+=arrMainValue[1];
							
						}
						else
						{									
							arrPsProdId+="__"+arrMainValue[1];									
						}																							
						
						if(arrPsSubcom == "")
						{									
							arrPsSubcom+=Ex.dataSourceTemp[i].subComHidden;									
						}
						else
						{									
							arrPsSubcom+="__"+Ex.dataSourceTemp[i].subComHidden;								
						}																												
				}	
				//BINHHT --add
				if(comp.trim(Ex.dataSourceTemp[i].taxCatHidden)!="0")
				{
						isHaveCheck=true;
						var objSave=new Object();
						var idRow =comp.trim(Ex.dataSourceTemp[i].idRowHidden);	
						//get id to get Ps work id and psProdId
						var arrMainValue=idRow.split("__");	
						if(arrPsTaxWorkId == "")
						{
							arrPsTaxWorkId+=arrMainValue[0];									
						}
						else
						{
							arrPsTaxWorkId+="__"+arrMainValue[0];									
						}	

						if(arrPsTaxProdId == "")
						{									
							arrPsTaxProdId+=arrMainValue[1];
							
						}
						else
						{									
							arrPsTaxProdId+="__"+arrMainValue[1];									
						}																							
						
						if(arrPsTaxCat == "")
						{									
							arrPsTaxCat+=Ex.dataSourceTemp[i].taxCatHidden;									
						}
						else
						{									
							arrPsTaxCat+="__"+Ex.dataSourceTemp[i].taxCatHidden;								
						}																												
				}		
			}						
			if(isHaveCheck)
			{				
				var obj = new Object();
				obj.arrPsWrkId=arrPsWorkId;
				obj.arrPsProdId=arrPsProdId;
				obj.arrSubComCode=arrPsSubcom;
				obj.arrPsTaxWrkId=arrPsTaxWorkId;
				obj.arrPsTaxProdId=arrPsTaxProdId;
				obj.arrTaxCatCode=arrPsTaxCat;
				
						
				//call back function call submit form to save
				ManageEDIDWR.updateFormForSave(obj,SER.currentPage,{
						callback:function(data)
						{
							//call back function load data for new tab
							loadTabDatas(toValue);
						}
					});
			}		
			else
			{				
				loadTabDatas(toValue);		
			}		
		} 
	}

	function saveOtherAttributeBeforeLoadNewTab(to){
		if(curTab==5){
			var isHaveCheck=false;							
			for(var i=0;i < dataSourceTemp.length;i++){
				if(dataSourceTemp[i].changeStatus == "2" || dataSourceTemp[i].changeStatus == "3"){
					isHaveCheck = true;
					break;
				}
			}

			if(isHaveCheck){
				//call function saveOtherAttributeTab from OtherAttribute.jsp page
				saveOtherAttributeTab(true);				
			}
			else
				loadTabDatas(to);			
		}
	}
	function saveCostAndRetailBeforeLoadNewTab(to){
		if(curTab==4){
			var isHaveCheck=false;							
			for(var i=0;i < dataSourceTemp.length;i++){
				if(dataSourceTemp[i].changeStatus == "2" || dataSourceTemp[i].changeStatus == "3"){
					isHaveCheck = true;
					break;
				}
			}

			if(isHaveCheck){
				//call function updateDataCostAndRetail from CostAndRetail.jsp page
				updateDataCostAndRetail(true);				
			}
			else
				loadTabDatas(to);			
		}
	}
	function saveDescriptionAndSizeBeforeLoadNewTab(to){
		if(curTab==2){
			var isHaveCheck=false;							
			for(var i=0;i < dataSourceTemp.length;i++){
				if(dataSourceTemp[i].changeStatus == "2" || dataSourceTemp[i].changeStatus == "3"){
					isHaveCheck = true;
					break;
				}
			}

			if(isHaveCheck){
				//call function saveDescriptionAndSizeTab from DescriptionAndSize.jsp page
				saveDescriptionAndSizeTab(true);				
			}
			else
				loadTabDatas(to);			
		}
	}

	<c:url value="/protected/cps/manageEDI/modifySeach?${_csrf.parameterName}=${_csrf.token}" var="modifySearch"></c:url>
	function loadTabDatas(to)
	{			
			var url;
			switch(to)
			{
			case 1:
			  url="${sellingUpcUrl}";
			  break;
			case 2:
			  url="${desAndSizeUrl}";
			  break;
			case 3:
			  url="${casePackUrl}";
			  break;  
			case 4:
			  url="${costAndRetailUrl}";
			  break;  
			case 5:
			  url="${linkOtherAttribute}";
			  break;    
			case 6:
			  url="${linkAuthorizationDistribution}";
			  break;
			case 7:
			  url="${modifySearch}";
			  break;       
			default:
			  url="${sellingUpcUrl}";
			  break;
			}		
			var formObject = document.getElementById('searchForm');
			SER.setCurrentRecrdPerPage();
			showProgress();
			formObject.action = url;
			formObject.submit();
	}

	function setResultFilter()
	{
		var comp = YAHOO.lang;
		var myDataTable = null;
		var resultFilter = new Array();
		var myDataSourceTemp = null;
		var arrObjFilter = null;
		var filterValues = "";
		var filterValuesTemp = "";					
				
		if(curTab==1){
			myDataTable = Ex.myDataTable;
			myDataSourceTemp = Ex.dataSourceTemp;

			arrObjFilter = Ex.arrSellingIdObj;	
		}
		else
		{
			myDataSourceTemp = dataSourceTemp;
		}
		
		if(curTab==2){
			myDataTable = descriptionAndSizeResult.oDT;
			arrObjFilter = arrDescIdObj;
		}
		if(curTab==3){
			myDataTable = casePackResult.oDT;
			arrObjFilter = getObjectFilter();
		}
		if(curTab==4){
			myDataTable = costAndRetailResult.oDT;	
			arrObjFilter = arrSellingIdObj;
		}	
		if(curTab==5){
			myDataTable = otherAttributeResult.oDT;	
			arrObjFilter = getObjectFilter();
		}
		if(curTab==6){
			myDataTable = authorizationResult.oDT;
			arrObjFilter = getObjectFilter();
		}						

		if(SER.hasFilter && (myDataTable.getRecordSet().getLength() != myDataSourceTemp.length)){
			//set filter values
			//2 field vendor and sellingUPC contain on all tab
			var vendorFilter = comp.trim(document.getElementById('vendorFilter').value);
			var sellingUpcFilter = comp.trim(document.getElementById('sellingUpcFilter').value);

			if((vendorFilter != "" || sellingUpcFilter != ""))
				filterValues = vendorFilter + "||" + sellingUpcFilter;
			
			if(document.getElementById('filterValues').value != ""){
				var values = document.getElementById('filterValues').value;						
				filterValues += values.substring(values.indexOf("___"));			
			}
			
			//get obj filter
			if(arrObjFilter != null){						
				for(var i = 0 ;i< arrObjFilter.length;i++)
				{
					if(arrObjFilter[i] != 'vendorFilter' && arrObjFilter[i] != 'sellingUpcFilter' && comp.trim(document.getElementById(arrObjFilter[i]).value !=""))
					{
						if(filterValuesTemp == "")
							filterValuesTemp += i + ":" + document.getElementById(arrObjFilter[i]).value;
						else
							filterValuesTemp += "||" + i + ":" + document.getElementById(arrObjFilter[i]).value;
					}
				}

				if(filterValues != "" || filterValuesTemp != ""){
					var arrValueTab = filterValues.split("___");
		
					if(filterValuesTemp == "")
						filterValuesTemp = " ";
		
					filterValues = "";
					for(var j = 0 ;j< 7;j++)
					{
						if(j==0)
							filterValues += arrValueTab[j];
						else
							if(curTab == j)
								filterValues += "___" + filterValuesTemp;
							else
								if(arrValueTab.length <= 1)
									filterValues += "___ ";
								else
									filterValues += "___" + arrValueTab[j];
					}
						
				}
			}

			if(curTab==1)
			{
				for(var i=0; i<myDataTable.getRecordSet().getLength(); i++) {
		   			 var oRec = myDataTable.getRecordSet().getRecord(i);
		   			 var values = oRec.getData("idRowHidden").split("__");
		   			 //sellingUpc-item-vendorNo
		   			 resultFilter.push(comp.trim(oRec.getData("sellingUpc")) + "_" + comp.trim(values[5]) + "_" + comp.trim(values[2]));
				}
			}			
			if(curTab==4 || curTab==5 || curTab==6 || curTab==2 || curTab==3){
				for(var i=0; i<myDataTable.getRecordSet().getLength(); i++) {
		   			 var oRec = myDataTable.getRecordSet().getRecord(i);
		   			 var values = oRec.getData("idResult").split("-");
		   		     //sellingUpc-item-vendorNo
		   			 resultFilter.push(oRec.getData("sellingUpc") + "_" + values[1] + "_" + values[2]);
				}
			}
						
			document.getElementById('itemsResultFilter').value = resultFilter;			
		}
		else
		{
			if(SER.itemResultFilter != null)
				document.getElementById('itemsResultFilter').value = SER.itemResultFilter;
		}

		if(myDataTable.getRecordSet().getLength() != 0 && filterValues != "")
			document.getElementById('filterValues').value = filterValues;	
		else
			if(myDataTable.getRecordSet().getLength() == 0)
				document.getElementById('filterValues').value = "";
		
	}
		
<c:if test="${ManageEDICandidate.currentTab=='sellingUpctab'}">
	YAHOO.util.Dom.get("sellingUPCTabBut").parentNode.className = "selected";	
</c:if>
<c:if test="${ManageEDICandidate.currentTab=='descriptionAndSizeTab'}">
	YAHOO.util.Dom.get("descriptionSizeTabBut").parentNode.className = "selected";	
</c:if>
<c:if test="${ManageEDICandidate.currentTab=='casePackTab'}">
	YAHOO.util.Dom.get("casePackTabBut").parentNode.className = "selected";	
</c:if>
<c:if test="${ManageEDICandidate.currentTab=='costAndRetailTab'}">
	YAHOO.util.Dom.get("costRetailTabBut").parentNode.className = "selected";	
</c:if>	
<c:if test="${ManageEDICandidate.currentTab=='otherAttributeTab'}">
	YAHOO.util.Dom.get("otherAttributesTabBut").parentNode.className = "selected";	
</c:if>	
<c:if test="${ManageEDICandidate.currentTab=='authorizationAndDistributionTab'}">
	YAHOO.util.Dom.get("authorizationDistributionTabBut").parentNode.className = "selected";	
</c:if>		

var tabView = new YAHOO.widget.TabView('ediTabView');
tabView.on('beforeActiveTabChange', function (oArgs) {
	//var tar = YAHOO.util.Event.getTarget(oArgs.newValue);
	return false;
});
</script>
</body>
</html>
