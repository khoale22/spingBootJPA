<%@ page import="com.heb.operations.cps.model.ManageEDICandidate" %>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="java.util.List"%>
<%@page import="com.heb.operations.cps.vo.EDISearchResultVO"%>
<%@page import="com.heb.operations.cps.util.CPSHelper"%>
<style type="text/css"> 
.yui-skin-sam .yui-dt tr.mark,
.yui-skin-sam .yui-dt tr.mark td.yui-dt-asc,
.yui-skin-sam .yui-dt tr.mark td.yui-dt-desc,
.yui-skin-sam .yui-dt tr.mark td.yui-dt-asc,
.yui-skin-sam .yui-dt tr.mark td.yui-dt-desc {
    background-color: #f1c8ff;
    color: #000;
}

.yui-skin-sam .yui-dt table .tbl-filter {
  width: 100%;
  border: 0px;
}
.yui-skin-sam .yui-dt .td-filter{
	border-color: -moz-use-text-color #CBCBCB -moz-use-text-color -moz-use-text-color;
    border-style: none none none none;
    border-width: medium 0px medium medium;
    margin: 0;
    padding: 0;
    text-align: left;
}
.yui-skin-sam .yui-dt td.align-right{
	text-align:right;
}

.yui-skin-sam .yui-dt-scrollable .yui-dt-bd {
			z-index:1;
			overflow:auto;
			width:99.9%;				
			position:relative;	
			
}
.yui-skin-sam .yui-dt-scrollable .yui-dt-hd {
			overflow:visible;			
			z-index:2;		
			position:relative;				
			width:"99.9%";
} 	
.yui-skin-sam .myAutoComplete .yui-ac-content 
		{
				max-height:15em;
				overflow:auto;
				overflow-x:hidden;
				_height:15em;
				z-index:15000;
				left:0px;
				text-align:left;
		}
.disabled-text{ border-width:1px; border-color: #cdcdcd; border-style: solid; padding: 2px; color: #666;}
</style>
<c:url value="/protected/cps/manageEDI/updateValues?${_csrf.parameterName}=${_csrf.token}" var="updateUrl" />
<c:url value="${request.getContextPath()}/hebAssets/images/dropdown.bmp" var="image"></c:url>
<script type="text/javascript" >
	var dataCostAndRetail = null;
	var isVendor = ${ManageEDICandidate.isVendor};
	var actualRT=null;
	var actualAMR=null;
	var arrayDataFilter = [];
	var arrSellingIdObj =new Array();
	function html_entity_decode(str) {
		var ta = document.createElement("textarea");
		ta.innerHTML = str.replace(/</g,"&lt;").replace(/>/g,"&gt;");
		return ta.value;
	}
	// Save data on datatable 
	getCostAndRetailTabAutoFilter = function(query)
	{		
		var arrTemp = query.split("__");		
		var temp = arrTemp[0];
		temp = decodeURIComponent(temp);
		var po = parseInt(arrTemp[1]);						
		reslts = [];				
	    for (var i = 0; i < arrayDataFilter[po].length; i++) {
		    var t1 = arrayDataFilter[po][i];
		    var t2 = temp;
		    var t1Up = t1.toUpperCase();
		    var t2Up = t2.toUpperCase();		    		    
		    if (t1Up.indexOf(t2Up) > -1) 
			{			
				reslts.push(arrayDataFilter[po][i]);
			}
	    }
	    return reslts;
	};
	function setAutoCompleteForFilter(idContainDiv,idInput,fldIndex)
	{		
		
		var oACDS = new YAHOO.widget.DS_JSFunction(getCostAndRetailTabAutoFilter);
	    // Instantiate first AutoComplete
	    var oAutoComp = new YAHOO.widget.AutoComplete(idInput,idContainDiv,oACDS);
	    oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
	   // this.oAutoComp.typeAhead = true;
		oAutoComp.queryQuestionMark = false;
		oAutoComp.forceSelection = false;
		oAutoComp.autoHighlight = false;
		oAutoComp.maxResultsDisplayed = 100;
		oAutoComp.resultTypeList = false;
		oAutoComp.useIFrame = true;
		oAutoComp.minQueryLength=0;
		var scale =0;
		
		oAutoComp.doBeforeExpandContainer = function() {
		var Dom = YAHOO.util.Dom;				
		Dom.setXY(idContainDiv, [Dom.getX(idInput)- scale, Dom.getY(idInput) + Dom.get(idInput).offsetHeight] );		
		return true;
		}

		var itemSelectHandler = function(sType, aArgs) {
			YAHOO.util.Dom.get(idInput).value = html_entity_decode(YAHOO.util.Dom.get(idInput).value);
			clearTimeout(filterTimeout);
			setTimeout(updateFilter,600);
			SER.hasFilter = true;
			};
			
		oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
		
		oAutoComp.generateRequest = function(sQuery) {
        return sQuery +"__"+fldIndex;
		};

		oAutoComp.textboxKeyEvent.subscribe(function(oSelf, nKeycode) {
	    	document.getElementById(idContainDiv).style.display = '';	    	
	    	var sInputValue = YAHOO.util.Dom.get(idInput).value;
			var comp = YAHOO.lang;	
	    	sInputValue = comp.trim(sInputValue);
	    	
	    	if ('' == sInputValue && nKeycode[1] == 32) {
			  	setTimeout(function() {
					YAHOO.util.Dom.get(idInput).value = "";
				}, 0);
			}
	    });
	    
		oAutoComp.textboxFocusEvent.subscribe(function() {			
			var sInputValue = YAHOO.util.Dom.get(idInput).value;
			
			if (sInputValue.length == 0) {
				var oSelf = this;
				//setTimeout(function() {oSelf.sendQuery(""+"__"+fldIndex);}, 0);
			}
		});		
		
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
		document.getElementById(idContainDiv).onmouseout = function() {
			document.getElementById(idContainDiv).style.display = 'none';
			document.getElementById(idContainDiv).onmouseover = function() {
				document.getElementById(idContainDiv).style.display = '';
			};
		};
		document.getElementById(idInput+"Image").onclick = function() {
			document.getElementById(idContainDiv).style.display = '';
		};	 	 
		var temp = oAutoComp;
		var sendEmptyQuery = function(t1, t2) {			
            setTimeout(function() {t2.sendQuery(""+"__"+fldIndex);}, 0);
            document.getElementById(idInput).focus();
		};
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get(idInput+"Image"), "click", sendEmptyQuery,temp);
	}
	var isNextDataCostAndRetail ;
	function updateDataCostAndRetail(isNextTab){		
 		var myDataTable = costAndRetailResult.oDT;
 		var editCheck = 0;
 		var  prodIds ="";
 		if(dataSourceTemp != null && dataSourceTemp.length >0)
 		{
			if(dataSourceTemp != null && dataSourceTemp.length >0)
			{
				for(var i=0; i<dataSourceTemp.length; i++) 
	 	 		{			
	 				if(dataSourceTemp[i].changeStatus != null && (dataSourceTemp[i].changeStatus == "2" || dataSourceTemp[i].changeStatus == "3"))
					{    				
	    				prodIds = prodIds + dataSourceTemp[i].productID +",";
						editCheck++;
					}				
	 			}
		 		if(editCheck < 1){
		 			YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: green;'><b> No data change to update </b></span>";
			 		return false;
		 		}				
			}
			
			
			if(prodIds !=""){		 	    		
 	    		prodIds = prodIds.substr(0,prodIds.lastIndexOf(','));
				showProgress();	
				isNextDataCostAndRetail = isNextTab; 			 
				ManageEDIDWR.checkMultilPluReuseEDI(prodIds,getDWRCallbackMethod(updateDataForCostAndRetailTabBack));		
			}	
			else
			{
 				YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: green;'><b> No data change to update </b></span>";
			}
 		}	
	}
	function updateDataForCostAndRetailTabBack(data){
		if(data!='' && data == true){		
			alert('PLU(s) tied to a vendor candidate/working candidate/ an existing product. \nThis candidate cannot be modified.');	
			hideProgress();	
		} else {	
			var arrIdResult = new Array();
			var arrActualRetail = new Array();
	 		var arrActualMultipleRetail = new Array();
	 		var arrRetailLink = new Array();
	 		var arrPennyProfit = new Array();
	 		var arrMargin = new Array();
	 		var arrListCost = new Array();
	 		var arrUnitCost = new Array();
	 		var myDataTable = costAndRetailResult.oDT;
	 		var editCheck = 0;
	 		var  prodIds ="";
	 		if(dataSourceTemp != null && dataSourceTemp.length >0)
	 		{
				if(dataSourceTemp != null && dataSourceTemp.length >0)
				{
					for(var i=0; i<dataSourceTemp.length; i++) 
		 	 		{			
		 				if(dataSourceTemp[i].changeStatus != null && (dataSourceTemp[i].changeStatus == "2" || dataSourceTemp[i].changeStatus == "3"))
						{								
		    				arrIdResult[i] = dataSourceTemp[i].idResult;
		    				arrActualRetail[i] = dataSourceTemp[i].actualRetail;
		    				arrActualMultipleRetail[i] = dataSourceTemp[i].actualMultipleRetail;
		    				arrRetailLink[i]=dataSourceTemp[i].retailLink;
		    				arrPennyProfit[i] = dataSourceTemp[i].pennyProfit;
		    				arrMargin[i] = dataSourceTemp[i].margin;
		    				arrListCost[i] = dataSourceTemp[i].listCost.substring(1);
		    				arrUnitCost[i] = dataSourceTemp[i].unitCost.substring(1);
		    				prodIds = prodIds + dataSourceTemp[i].productID +",";
						editCheck++;
						}				
		 			}
			 		if(editCheck < 1){
			 			YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: green;'><b> No data change to update </b></span>";
				 		return false;
			 		}				
				}
	 		}
	 		if(arrIdResult!= null)
			{		
				ManageEDIDWR.updateDataForCostAndRetailTab(arrIdResult,arrActualRetail,arrActualMultipleRetail,arrRetailLink,arrPennyProfit,arrMargin,arrListCost,arrUnitCost,SER.currentPage,{
					callback:function(str) 
					{
						if(!isNextDataCostAndRetail){
							var formObject = document.getElementById('searchForm');
		 					showProgress();
		 					SER.setCurrentRecrdPerPage();
		 					formObject.action = "${updateUrl}";
		 					formObject.submit();
						}
						else
						{
							loadTabDatas(SER.toTab);
		    		  		}
					},
		    			errorHandler:function(errorString, exception) {
		    				hideProgress();
		    			},
		   				timeout:180000
				});	
			}else
			{
 				YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: green;'><b> No data change to update </b></span>";
			}	
		} 
	}
	// check format of UPC retail link and get Actual retail + Actual Multiple Retail
	function showPopupRTL(evt){
		var elRetailLink = YAHOO.util.Dom.get('txtMF_RetailLink');
		var elAMR = YAHOO.util.Dom.get('txtMF_AMR');
		var elAR = YAHOO.util.Dom.get('txtMF_AR');
		var upc = elRetailLink.value;			
		if((null != upc) && (upc != ""))
		{
			upc=paddingRTL(upc);
			if(upc.length == 13 || upc.length ==7) {
				showProgress();
				elAMR.value = "";
				elAR.value = "";
				var actualRetail = null;
				var actualMultiple = null;
				var retailLink = null;
				var result = "";
				ManageEDIDWR.getActualAndMultipleRetail(upc,{
					callback:function(str) {
					if(str.appData != ""){
						result = str.appData;
						actualRetail = result.split('_')[1];
						actualMultiple = result.split('_')[0];
						retailLink = result.split('_')[2];
						elAMR.value = actualMultiple;
						elAR.value = actualRetail;
						elRetailLink.value = retailLink;	
						actualRT=actualRetail;
						actualAMR=actualMultiple;
						hideProgress();
					}else{
						alert("Invalid UPC.Please enter the correct UPC/Retail Link.");
						elAMR.value = "";
						elAR.value = "";
						elRetailLink.value = "";	
						hideProgress();
					}
				}
				});		
			}
			else
			{
				alert('Please enter a 13 digit UPC or a 7 digit Item Code');
				document.getElementById('txtMF_RetailLink').value = "";
				return false;
			}
			
		}else{
						elAMR.value = "";
						elAR.value = "";
		}
		
	}
	// padding retail link
	function paddingRTL(upc)
	{				
		if(upc.length > 7 && upc.length < 13)
		{
			for(i=13;i>=upc.length-1;i--)
			{
				upc="0"+upc;
			}
		}		
		return (upc);
	}
	
	// Mass fill for tab Cost And Retail
	function massfillCostAndRetail(evt){
		var elRetailLink = YAHOO.util.Dom.get('txtMF_RetailLink');
		var elAMR = YAHOO.util.Dom.get('txtMF_AMR');
		var elAR = YAHOO.util.Dom.get('txtMF_AR');
		var myDataTable = costAndRetailResult.oDT;
		var oRS = myDataTable.getRecordSet();
		
		if(dataSourceTemp != null && dataSourceTemp.length >0)
 		{
			var countCheck = 0;
			for(var i=0; i<dataSourceTemp.length; i++) 
 	 		{
				if(dataSourceTemp[i].changeStatus == "1" || dataSourceTemp[i].changeStatus== "3" || dataSourceTemp[i].changeStatus== "4" ){
					countCheck++;
				}
 			}
			if(countCheck == 0){
				alert("Please select at least one UPC to mass fill.");
				return false;
			}
		}
		
		if(elAMR.value != "" && isNaN(elAMR.value)){
			alert("Actual Multiple Retail must be a number");
			return false;
		}
		if(elAR.value !="" && isNaN(elAR.value)){
			alert("Actual Retail must be a number");
			return false;
		}
		if(elRetailLink.value != "" && isNaN(elRetailLink.value)){
			alert("Retail Link must be a number");
			return false;
		}
		if(elAMR.value != "" && elAMR.value <= 0){
			alert("Actual Multile Retail must greater than 0");
			elAMR.value = "";
			return false;
		}
		if(elAR.value != "" && elAR.value <= 0){
			alert("Actual Retail must greater than 0");
			elAR.value = "";
			return false;
		}
		
		if(elRetailLink.value !="" && elAMR.value != "" && elAR.value != ""){
			elAMR.value = "" ;
			elAR.value = "";
		}else{
			if(elRetailLink.value !="" && (elAMR.value !="" || elAR.value !=""))
			{
				elAMR.value = "" ;
				elAR.value = "";
			}
		}

		if(elAR.value > 9999999.99)
		{
			alert("Actual Retail is above the maximum limit [9999999.99].Please re-enter.");
			elAR.value = "";
			return false;
		}
		// Mass fill Retail link
    	if(elRetailLink.value !="" && elAMR.value=="" && elAR.value==""){
    		showProgress();
			elAMR.value = "";
			elAR.value = "";
			var actualRetail = null;
			var actualMultiple = null;
			var retailLink = null;
			var result = "";
			var count = 0;
			// get Actual retail and Actual Multiple Retail
			ManageEDIDWR.getActualAndMultipleRetail(elRetailLink.value,{
				callback:function(str) {
				if(str.appData != ""){
					var arrEditOnItem = new Array();
					result = str.appData;
					actualRetail = result.split('_')[1];
					actualMultiple = result.split('_')[0];
					retailLink = result.split('_')[2];

					
					
					var unitRetail;
					if(actualMultiple.value > 1)
						unitRetail = (actualRetail/actualMultiple);
					else
						unitRetail = actualRetail;
					
					for(var i=0; i<oRS.getLength(); i++) {
						var oRec = oRS.getRecord(i);
						var marginDiv = document.getElementById("margin_"+oRec.getData("idResult"));
						var pennyDiv = document.getElementById("pennyProfit_"+oRec.getData("idResult"));
										
						if(oRec.getData("changeStatus")=="1" || oRec.getData("changeStatus")=="3")
						{		
							if(!checkExistItem(arrEditOnItem, oRec.getData("idResult").split('-')[0]))
								arrEditOnItem.push(oRec.getData("workrqstID"));						
							var unitCost = oRec.getData("unitCost").substring(1);
							if(unitCost!=="" && unitCost!== null){									
								var pennyProfit = eval(unitRetail) - eval(unitCost);
								if(pennyDiv!=null)
									pennyDiv.innerHTML ="$"+ pennyProfit.toFixed(2);
								oRec.setData("pennyProfit",pennyProfit.toFixed(2));
								var margin = ((eval(unitRetail) - eval(unitCost))/eval(unitRetail))*100;
								if(marginDiv!=null)
									marginDiv.innerHTML = margin.toFixed(2);
								oRec.setData("margin",margin.toFixed(2));
							}else{
								oRec.setData("pennyProfit","");
								oRec.setData("margin","");
								if(marginDiv!=null)
									marginDiv.innerHTML = "";
								if(pennyDiv!=null)
									pennyDiv.innerHTML = "";
							}
							oRec.setData("actualRetail",actualRetail);
							oRec.setData("actualMultipleRetail",actualMultiple);
							oRec.setData("retailLink",retailLink);	
							actualRT=actualRetail;
							actualAMR=actualMultiple;
							oRec.setData("changeStatus","3");
							YAHOO.util.Dom.addClass(myDataTable.getTrEl(oRec), 'mark'); 
						}
					}

					//update datasource temp (used for filter)
		    		for(var j=0; j< dataSourceTemp.length; j++) {
		    			if(dataSourceTemp[j].changeStatus == "1" || dataSourceTemp[j].changeStatus == "3")
			    		 {
		    				var unitCost = dataSourceTemp[j].unitCost.substring(1);
							if(unitCost!=="" && unitCost!== null){									
								var pennyProfit = eval(unitRetail) - eval(unitCost);
								dataSourceTemp[j].pennyProfit = pennyProfit.toFixed(2);

								var margin = ((eval(unitRetail) - eval(unitCost))/eval(unitRetail))*100;
								dataSourceTemp[j].margin = margin.toFixed(2);
							}else{
								dataSourceTemp[j].pennyProfit = "";
								dataSourceTemp[j].margin = "";
							}
							dataSourceTemp[j].actualRetail = actualRetail;
							dataSourceTemp[j].actualMultipleRetail = actualMultiple;	
							dataSourceTemp[j].retailLink = retailLink;
							dataSourceTemp[j].changeStatus = "3";
			    		 }
		    		}
		    		if(arrEditOnItem.length >0){
						if(actualMultiple !=""){
							for(i=0;i<arrEditOnItem.length;i++){
								var fieldChangedInAMR = document.getElementsByName("actualMultipleRetail_"+arrEditOnItem[i]);
								if(fieldChangedInAMR != null){
									for(j=0;j<fieldChangedInAMR.length;j++)
										fieldChangedInAMR[j].value = actualMultiple;
								}
							}
							
						}
						if(actualRetail !=""){
							for(i=0;i<arrEditOnItem.length;i++){
								var fieldChangedInAR = document.getElementsByName("actualRetail_"+arrEditOnItem[i]);
								if(fieldChangedInAR != null){
									for(j=0;j<fieldChangedInAR.length;j++)
										fieldChangedInAR[j].value = actualRetail;
								}
							}
						
						}
						if(retailLink !=""){
							for(i=0;i<arrEditOnItem.length;i++){
								var fieldChangedInRL = document.getElementsByName("retailLink_"+arrEditOnItem[i]);
								if(fieldChangedInRL != null){
									for(j=0;j<fieldChangedInRL.length;j++)
										fieldChangedInRL[j].value = retailLink;
								}
							}
							
						}
					}
					elAMR.value = actualMultiple;
					elAR.value = actualRetail;	
					
					hideProgress();
				  }else{
					alert("Invalid UPC.Please enter the correct UPC/Retail Link.");
					hideProgress();
				  }
			  }
			});										
		}
    	else
    	{
			if(elAR.value!=""  || elAMR.value != "")
			{
				
		        var arrEditOnItem = new Array();
				for(var i=0; i<oRS.getLength(); i++) 
				{
					var oRec = oRS.getRecord(i);					
					if((oRec.getData("changeStatus")=="1" || oRec.getData("changeStatus")=="3") && isVendor == false && oRec.getData("status")!== "103" && oRec.getData("retailLink")=="")
					{
						var marginDiv = document.getElementById("margin_"+oRec.getData("idResult"));
						var pennyDiv = document.getElementById("pennyProfit_"+oRec.getData("idResult"));
						if(elAMR.value != ""){
							if(!checkExistItem(arrEditOnItem, oRec.getData("idResult").split('-')[0]))
								arrEditOnItem.push(oRec.getData("workrqstID"));
							oRec.setData("actualMultipleRetail",elAMR.value);
						}
						if(elAR.value!=""){
							if(!checkExistItem(arrEditOnItem, oRec.getData("idResult").split('-')[0]))
								arrEditOnItem.push(oRec.getData("workrqstID"));
							oRec.setData("actualRetail",parseFloat(elAR.value).toFixed(2));
						}
						
						if(oRec.getData("actualMultipleRetail") != "" && oRec.getData("actualRetail") != ""){
							var unitRetail;
							if(oRec.getData("actualMultipleRetail") > 1)
								unitRetail = (oRec.getData("actualRetail")/oRec.getData("actualMultipleRetail"));
							else
								unitRetail = oRec.getData("actualRetail");

							var unitCost = oRec.getData("unitCost").substring(1);
							if(unitCost!=="" && unitCost!== null){
									
								var pennyProfit = eval(unitRetail) - eval(unitCost);
								oRec.setData("pennyProfit",pennyProfit.toFixed(2));
								if(pennyDiv!=null)
									pennyDiv.innerHTML ="$"+ pennyProfit.toFixed(2);
								var margin = ((eval(unitRetail) - eval(unitCost))/eval(unitRetail))*100;
								if(marginDiv!=null)
									marginDiv.innerHTML = margin.toFixed(2);
								oRec.setData("margin",margin.toFixed(2));
							}else{
								oRec.setData("pennyProfit","");
								oRec.setData("margin","");
								if(marginDiv!=null)
									marginDiv.innerHTML = "";
								if(pennyDiv!=null)
									pennyDiv.innerHTML = "";
							}
							oRec.setData("changeStatus","3");
							YAHOO.util.Dom.addClass(myDataTable.getTrEl(oRec), 'mark'); 
						} 
					
					}
					
				}

				
				//update datasource temp (used for filter)
	    		for(var j=0; j< dataSourceTemp.length; j++) {
	    			if((dataSourceTemp[j].changeStatus == "1" || dataSourceTemp[j].changeStatus == "3") && isVendor == false && dataSourceTemp[j].status !== "103" && dataSourceTemp[j].retailLink =="" )
		    		{
	    				if(elAMR.value != "")
							dataSourceTemp[j].actualMultipleRetail = elAMR.value;
	    				if(elAR.value!="")
							dataSourceTemp[j].actualRetail = parseFloat(elAR.value).toFixed(2);

	    				if(dataSourceTemp[j].actualMultipleRetail != "" && dataSourceTemp[j].actualRetail != ""){
							var unitRetail;
							if(dataSourceTemp[j].actualMultipleRetail > 1)
								unitRetail = (dataSourceTemp[j].actualRetail/dataSourceTemp[j].actualMultipleRetail);
							else
								unitRetail = dataSourceTemp[j].actualRetail;

							var unitCost = dataSourceTemp[j].unitCost.substring(1);
							if(unitCost!=="" && unitCost!== null){
									
								var pennyProfit = eval(unitRetail) - eval(unitCost);
								dataSourceTemp[j].pennyProfit = pennyProfit.toFixed(2);
								var margin = ((eval(unitRetail) - eval(unitCost))/eval(unitRetail))*100;
								dataSourceTemp[j].margin = margin.toFixed(2);
							}else{
								dataSourceTemp[j].pennyProfit = "";
								dataSourceTemp[j].margin = "";
							}
							dataSourceTemp[j].changeStatus = "3";
						} 
		    		}
	    		}
	    		if(arrEditOnItem.length >0){
					if(elAMR.value !=""){
						for(i=0;i<arrEditOnItem.length;i++){
							var fieldChangedInAMR = document.getElementsByName("actualMultipleRetail_"+arrEditOnItem[i]);
							if(fieldChangedInAMR != null){
								for(j=0;j<fieldChangedInAMR.length;j++)
									fieldChangedInAMR[j].value = elAMR.value;
							}
						}
		 
					}
					if(elAR.value !=""){
						for(i=0;i<arrEditOnItem.length;i++){
							var fieldChangedInAR = document.getElementsByName("actualRetail_"+arrEditOnItem[i]);
							if(fieldChangedInAR != null){
								for(j=0;j<fieldChangedInAR.length;j++){
									fieldChangedInAR[j].value = parseFloat(elAR.value).toFixed(2);
								}
							}
						}
						
					}
				}
	    		
			}
			
			changeRequest = true;
			//myDataTable.render();
    	}
	}
	function checkExistItem(listItem,item)
	{		
		if(listItem != ''){
			for(var i=0;i<listItem.length;i++){
				if(listItem[i]==item){
					return true;
				}
			}		
		}		
		 return false;
	}  
	// edit content on row
	function editRowContentRetailLink(element){
		var myDataTable = costAndRetailResult.oDT;
		var key = element.id.split('_')[0];
		var id = element.id.split('_')[1];
		var psWorkRqst = id.split('-')[4];
		var upc = element.value;
			if((null != upc) && (upc != "")){
				upc=paddingRTL(upc);//trungnv fix bug relate retail link
				if(upc.length == 13 || upc.length ==7)
				{
					showProgress();
					var actualRetail = null;
					var actualMultiple = null;
					var retailLink = null;
					var result = "";
					ManageEDIDWR.getActualAndMultipleRetail(upc,{
					callback:function(str)
					{
							if(str.appData != "")
							{			
								result = str.appData;
								//START FOR
								for(var i=0; i<myDataTable.getRecordSet().getLength(); i++) 
								{
									var oRec = myDataTable.getRecordSet().getRecord(i);
									var idResult = oRec.getData("idResult");
									var workrqstID = oRec.getData("workrqstID");
									actualRetail = result.split('_')[1];
									actualMultiple = result.split('_')[0];
									retailLink = result.split('_')[2];
									if(workrqstID == psWorkRqst)
									{
										var marginDiv = document.getElementById("margin_"+idResult);
										var pennyDiv = document.getElementById("pennyProfit_"+idResult);

										oRec.setData("actualRetail",actualRetail);
										oRec.setData("actualMultipleRetail",actualMultiple);
										oRec.setData("retailLink",retailLink);
										var unitRetail;
										if(oRec.getData("actualMultipleRetail")>1){
											unitRetail = (oRec.getData("actualRetail")/oRec.getData("actualMultipleRetail"));
										}else
										{
											unitRetail = oRec.getData("actualRetail");
										}
										var unitCost = oRec.getData("unitCost").substring(1);
										if(unitCost!=="" && unitCost!== null){
												
											var pennyProfit = eval(unitRetail) - eval(unitCost);
											oRec.setData("pennyProfit",pennyProfit.toFixed(2));
											if(pennyDiv!=null)
												pennyDiv.innerHTML ="$"+ pennyProfit.toFixed(2);
											
											var margin = ((eval(unitRetail) - eval(unitCost))/eval(unitRetail))*100;
											oRec.setData("margin",margin.toFixed(2));
											if(marginDiv!=null)
												marginDiv.innerHTML = margin.toFixed(2);
											
										}else{
											oRec.setData("pennyProfit","");
											oRec.setData("margin","");
											if(marginDiv!=null)
												marginDiv.innerHTML = "";
											if(pennyDiv!=null)
												pennyDiv.innerHTML = "";
											
										}
										if(dataSourceTemp[i].changeStatus == "1"){
											oRec.setData("changeStatus", "3");
										}else if(dataSourceTemp[i].changeStatus !="3"){
											oRec.setData("changeStatus", "2");
										}													
									}
								}
								actualRT=actualRetail;
								actualAMR=actualMultiple;
								//END FOR
							}else{
								alert("Invalid UPC.Please enter the correct UPC/Retail Link.");
								hideProgress();
							}
							saveDataSourceTempWhenChangeEditFieldable(id, key, retailLink,actualRetail,actualMultiple);	
							changeRequest = true;
							myDataTable.render();
							hideProgress();
						}
					});		
				}else{
					alert('Please enter a 13 digit UPC or a 7 digit Item Code');
					document.getElementById(element.id).value = "";
					return false;
				}
			}else
			{				
				for(var i=0; i<myDataTable.getRecordSet().getLength(); i++) 
				{
					var oRec = myDataTable.getRecordSet().getRecord(i);
					var idResult = oRec.getData("idResult");
					var workrqstID = oRec.getData("workrqstID");
					if(workrqstID == psWorkRqst)
					{
						var marginDiv = document.getElementById("margin_"+idResult);
						var pennyDiv = document.getElementById("pennyProfit_"+idResult);
						oRec.setData("retailLink",upc);
						oRec.setData("actualRetail","");
						oRec.setData("actualMultipleRetail","");
						oRec.setData("pennyProfit","");
						oRec.setData("margin","");
						
						if(marginDiv!=null)
							marginDiv.innerHTML = "";
						if(pennyDiv!=null)
							pennyDiv.innerHTML = "";
						
						if(dataSourceTemp[i].changeStatus == "1")
						{
							oRec.setData("changeStatus", "3");
							
						}else if(dataSourceTemp[i].changeStatus !="3")
						{
							oRec.setData("changeStatus", "2");
							
						}		
						
					}
				}
				saveDataSourceTempWhenChangeEditFieldable(id, key, element.value,null,null);
				changeRequest = true;
				myDataTable.render();
				hideProgress();							
			}
	}
	
	function editRowContent(element){
		var myDataTable = costAndRetailResult.oDT;
		var key = element.id.split('_')[0];
		var id = element.id.split('_')[1];
		var psWorkRqst = id.split('-')[4];
		var isValid = true;
		if(isNaN(element.value))
		   isValid = false;
			 else
				 if(element.value <0)
				  isValid = false;

		if(!isValid)
		  {
			if(element.oldValue != null && typeof element.oldValue != 'undefined')
				element.value = element.oldValue;
			else
				myDataTable.render();
			return;
		  }
		//Actual Retail 
		if(key=="actualRetail") 
		{
			var retailLinkKey = "retailLink_"+ id;
			var aRvalue = element.value;
			var aR = parseFloat(aRvalue);
			var aRTemp = null;
			var aMRTemp=null;
			if(document.getElementById(retailLinkKey).value!=""){
					alert("The Retail Link is entered,to edit Actual Retail please remove Retail Link.");
					changeRequest = true;
					if(element.oldValue != null && typeof element.oldValue != 'undefined')
						element.value = element.oldValue;
					else
						myDataTable.render();
					
					return false;
			}
			if(element.value > 9999999.99)
			{
					alert("The entered value is above the maximum limit [9999999.99].Please re-enter.");
					changeRequest = true;
					if(element.oldValue != null && typeof element.oldValue != 'undefined')
						element.value = element.oldValue;
					else
						myDataTable.render();
					return false;
			}
			if(element.value =="0"){
				alert("Actual  Retail must be greater than 0");
				changeRequest = true;
				if(element.oldValue != null && typeof element.oldValue != 'undefined')
					element.value = element.oldValue;
				else
					myDataTable.render();
				return false;
			}
			for(var i=0; i<myDataTable.getRecordSet().getLength(); i++) {
				var oRec = myDataTable.getRecordSet().getRecord(i);
				var idResult = oRec.getData("idResult");
				var workrqstID = oRec.getData("workrqstID");
				if(workrqstID == psWorkRqst)
				{  
					if(aRvalue=="")
						oRec.setData("actualRetail",aRvalue);
					else
						oRec.setData("actualRetail", aR.toFixed(2));

					var marginDiv = document.getElementById("margin_"+idResult);
					var pennyDiv = document.getElementById("pennyProfit_"+idResult);
					
					if((oRec.getData("actualRetail")!="" && oRec.getData("actualMultipleRetail") == "") || (oRec.getData("actualRetail")=="" && oRec.getData("actualMultipleRetail") != "")|| (oRec.getData("actualRetail")=="" && oRec.getData("actualMultipleRetail") == "")){						
						oRec.setData("margin","");
						oRec.setData("pennyProfit","");

						if(marginDiv!=null)
							marginDiv.innerHTML = "";
						if(pennyDiv!=null)
							pennyDiv.innerHTML = "";
					}else{
						
						var unitRetail;						
						if(oRec.getData("actualMultipleRetail")>1)
							unitRetail = (oRec.getData("actualRetail")/oRec.getData("actualMultipleRetail"));
						else
							unitRetail = oRec.getData("actualRetail");

						var unitCost = oRec.getData("unitCost").substring(1);
						if(unitCost!=="" && unitCost!== null){								
							var pennyProfit = eval(unitRetail) - eval(unitCost);
							oRec.setData("pennyProfit",pennyProfit.toFixed(2));
							if(pennyDiv!=null)
								pennyDiv.innerHTML ="$"+ pennyProfit.toFixed(2);							
							
							var margin = ((eval(unitRetail) - eval(unitCost))/eval(unitRetail))*100;
							oRec.setData("margin",margin.toFixed(2));
							if(marginDiv!=null)
								marginDiv.innerHTML = margin.toFixed(2);
							
						}else{
							oRec.setData("pennyProfit","");						
							
							oRec.setData("margin","");
						
							if(marginDiv!=null)
								marginDiv.innerHTML = "";
							if(pennyDiv!=null)
								pennyDiv.innerHTML = "";
						}
						//saveDataSourceTempWhenChangeEditFieldable(id, key, element.value,oRec.getData("actualRetail"),oRec.getData("actualMultipleRetail"));						
					}
					if(oRec.getData("changeStatus") == "1"){
						oRec.setData("changeStatus", "3");
					}else if(oRec.getData("changeStatus") !=="3"){
						oRec.setData("changeStatus", "2");
					}
					YAHOO.util.Dom.addClass(myDataTable.getTrEl(oRec), 'mark');					
				}
			}
			saveDataSourceTempWhenChangeEditFieldable(id, key, element.value,null,null);	
		}
		//Actual Multiple Retail
		if(key=="actualMultipleRetail") 
		{
			var retailLinkKey = "retailLink_"+ id;
			if(document.getElementById(retailLinkKey).value!=""){
					alert("The Retail Link is entered,to edit Actual Multiple Retail please remove Retail Link.");
					changeRequest = true;
					if(element.oldValue != null && typeof element.oldValue != 'undefined')
						element.value = element.oldValue;
					else
						myDataTable.render();
					return false;
			}
			if(element.value =="0"){
				alert("Actual Multiple Retail must be greater than 0");
				changeRequest = true;
				if(element.oldValue != null && typeof element.oldValue != 'undefined')
					element.value = element.oldValue;
				else
					myDataTable.render();
				return false;
			}
			for(var i=0; i<myDataTable.getRecordSet().getLength(); i++) {
				var oRec = myDataTable.getRecordSet().getRecord(i);
				var idResult = oRec.getData("idResult");
				var workrqstID = oRec.getData("workrqstID");
				if(workrqstID == psWorkRqst)
				{  
					oRec.setData("actualMultipleRetail", element.value);

					var marginDiv = document.getElementById("margin_"+idResult);
					var pennyDiv = document.getElementById("pennyProfit_"+idResult);
					
					if((oRec.getData("actualRetail")!="" && oRec.getData("actualMultipleRetail") == "") || (oRec.getData("actualRetail")=="" && oRec.getData("actualMultipleRetail") != "") || (oRec.getData("actualRetail")=="" && oRec.getData("actualMultipleRetail") == "")){
						oRec.setData("margin","");
						oRec.setData("pennyProfit","");
						if(marginDiv!=null)
							marginDiv.innerHTML = "";
						if(pennyDiv!=null)
							pennyDiv.innerHTML = "";
					}else{
						var unitRetail;
						
						if(oRec.getData("actualMultipleRetail")>1){
							unitRetail = (oRec.getData("actualRetail")/oRec.getData("actualMultipleRetail"));
						}else
						{
							unitRetail = oRec.getData("actualRetail");
						}
						var unitCost = oRec.getData("unitCost").substring(1);
						if(unitCost!=="" && unitCost!== null){
								
							var pennyProfit = eval(unitRetail) - eval(unitCost);
							oRec.setData("pennyProfit",pennyProfit.toFixed(2));
							if(pennyDiv!=null)
								pennyDiv.innerHTML ="$"+ pennyProfit.toFixed(2);
							
							var margin = ((eval(unitRetail) - eval(unitCost))/eval(unitRetail))*100;
							oRec.setData("margin",margin.toFixed(2));
							if(marginDiv!=null)
								marginDiv.innerHTML = margin.toFixed(2);
							
							
						}else{
							oRec.setData("pennyProfit","");				
							oRec.setData("margin","");
							if(marginDiv!=null)
								marginDiv.innerHTML = "";
							if(pennyDiv!=null)
								pennyDiv.innerHTML = "";
						}
						//saveDataSourceTempWhenChangeEditFieldable(id, key, element.value,oRec.getData("actualRetail"),element.value);						
					}
					if(oRec.getData("changeStatus") == "1"){
						oRec.setData("changeStatus", "3");
					}else if(oRec.getData("changeStatus") !=="3"){
						oRec.setData("changeStatus", "2");
					}
					YAHOO.util.Dom.addClass(myDataTable.getTrEl(oRec), 'mark');				
				}
			}
			saveDataSourceTempWhenChangeEditFieldable(id, key, element.value,null,null); 		
		}

		var fieldChangeds = document.getElementsByName(element.name);
		if(fieldChangeds != null && fieldChangeds.length > 1){	
			for(i=0;i<fieldChangeds.length;i++)
				fieldChangeds[i].value = element.value;
		}
		changeRequest = true;
		//myDataTable.render();
	}
	function saveDataSourceTempWhenChangeEditFieldable(id, key, value,actualRetail,actualMultiple){
		for (var i= 0; i< dataSourceTemp.length; i++){
            var idProduct = dataSourceTemp[i].idResult.split("-")[0];
            var idVendorItem = dataSourceTemp[i].idResult;
            if(key =="actualRetail" || key == "actualMultipleRetail" || key == "retailLink"){
	    		if(idProduct == id.split("-")[0]){			
	    			if(key == "actualRetail"){
	    				dataSourceTemp[i].actualRetail = value;
						if(value == ""){
							dataSourceTemp[i].pennyProfit = "";
							dataSourceTemp[i].margin = "";
						}
					}
	    			if(key == "actualMultipleRetail"){
	    				dataSourceTemp[i].actualMultipleRetail = value;
						if(value == ""){
							dataSourceTemp[i].pennyProfit = "";
							dataSourceTemp[i].margin = "";
						}
					}
	    			if(key == "retailLink"){
	    				dataSourceTemp[i].retailLink = value;
	    				if(actualRetail!==null || actualRetail!== ""){
	    					dataSourceTemp[i].actualRetail = actualRetail;
	    				}else{
	    					dataSourceTemp[i].actualRetail = "";
	    				}
	    				if(actualMultiple!==null || actualMultiple!== ""){
	    					dataSourceTemp[i].actualMultipleRetail = actualMultiple;
	    				}else{
	    					dataSourceTemp[i].actualMultipleRetail = "";
	    				}
					}
					
					if((dataSourceTemp[i].actualRetail !== null && dataSourceTemp[i].actualRetail !== "") &&(dataSourceTemp[i].actualMultipleRetail!==null && dataSourceTemp[i].actualMultipleRetail!=="")){
    					var unitRetail;

						if(eval(actualMultiple)>1){
							unitRetail = eval(dataSourceTemp[i].actualRetail)/eval(dataSourceTemp[i].actualMultipleRetail);
						}else
						{
							unitRetail = eval(dataSourceTemp[i].actualRetail);
						}
						var unitCost = dataSourceTemp[i].unitCost.substring(1);
						if(unitCost!=="" && unitCost!== null){
								
							var pennyProfit = eval(unitRetail) - eval(unitCost);
							dataSourceTemp[i].pennyProfit = pennyProfit.toFixed(2);

							var margin = ((eval(unitRetail) - eval(unitCost))/eval(unitRetail))*100;
							dataSourceTemp[i].margin = margin.toFixed(2);
						}else{
							dataSourceTemp[i].pennyProfit = "";
							dataSourceTemp[i].margin = "";
						}
    				}
    				
	    			if(dataSourceTemp[i].changeStatus == "1")
	    				dataSourceTemp[i].changeStatus = "3";
	    			else
		    			if(dataSourceTemp[i].changeStatus != "3")
		    				dataSourceTemp[i].changeStatus = "2";					
				} 
			
            }
            			          
        }		
	}	
	
	function setChangeStatusOnCostAndRetailTab(oRecord, checked){
		 //changeStatus = 0: initial
	     //changeStatus = 1: when checkBox is checked
	     //changeStatus = 2: when row is edited
	     //changeStatus = 3: when checkBox is checked and row is edited
	  
		  if(checked)
		  {		
			if(oRecord.getData("changeStatus") == "0"){
			 	oRecord.setData("changeStatus","1");
			 }
			else{
			 if(oRecord.getData("changeStatus") == "2"){					
					oRecord.setData("changeStatus","3");					
				}
			}
		  }
		  else
		  {
		   	if(oRecord.getData("changeStatus") == "1")
			 	oRecord.setData("changeStatus","0");
			else
			 	if(oRecord.getData("changeStatus") == "3")
			  		oRecord.setData("changeStatus","2");
		  }		  		  
	 }

	function saveDataSourceTempWhenCheck(id, checked, isCheckAll){
		if(isCheckAll){
			for(var i=0; i<dataSourceTemp.length; i++) {
				var idWorkRq = dataSourceTemp[i].idResult.split('-')[4];
				if(id.inArray(idWorkRq)){
		            if(checked)
		            {	            	
		            	dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[4] +" checked=checked class=yui-dt-checkbox />";
		            	var changeValue = getChangeStatusOnCostAndRetailTab(dataSourceTemp[i].changeStatus, true);
		            	if(changeValue != null)
		            		dataSourceTemp[i].changeStatus = changeValue;	            	
		            }
	       			else
	       			{	            	
	       				dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[4] +" class=yui-dt-checkbox />";
	       				var changeValue = getChangeStatusOnCostAndRetailTab(dataSourceTemp[i].changeStatus, false);
		            	if(changeValue != null)
		            		dataSourceTemp[i].changeStatus = changeValue;	            	
	       			}
				}               
			}
		}
		else
		{
			for (var i= 0; i< dataSourceTemp.length;i++){
		        var idWorkRq = dataSourceTemp[i].idResult.split('-')[4];

		        if(idWorkRq == id){
		        	if(checked){		        		
		        		dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[4] +" checked=checked class=yui-dt-checkbox />";
		        		var changeValue = getChangeStatusOnCostAndRetailTab(dataSourceTemp[i].changeStatus, true);
		            	if(changeValue != null)
		            		dataSourceTemp[i].changeStatus = changeValue;		        		
		        	}
		        	else
		        	{		        		
		        		dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[4] +" class=yui-dt-checkbox />";
		        		var changeValue = getChangeStatusOnCostAndRetailTab(dataSourceTemp[i].changeStatus, false);
		            	if(changeValue != null)
		            		dataSourceTemp[i].changeStatus = changeValue;		        		
		        	}
		        }
			 }
		}
	}	
		 
	function getChangeStatusOnCostAndRetailTab(oldValue, checked)
	{
		//changeStatus = -1: can not edit on editfieldable
	    //changeStatus = 0: initial (alow edit on editfieldable)
		//changeStatus = 1: when checkBox is checked
		//changeStatus = 2: when row is edited
		//changeStatus = 3: when checkBox is checked and row is edited
		//changeStatus = 4: when checked and disabled
		var newValue = null;				
		
		if(checked)
		{
			if(oldValue == "0")
				newValue = "1";
				else
					if(oldValue == "2")
						newValue = "3";
					else
						if(oldValue == "-1")
							newValue = "4";
		}
		else
		{
			if(oldValue == "1")
				newValue = "0";
				else
					if(oldValue == "3")
						newValue = "2";
					else
						if(oldValue == "4")
							newValue = "-1";
		}
		return newValue;
	}
	
	function validateAR(){
		var elAMR = YAHOO.util.Dom.get('txtMF_AMR');
		var elAR = YAHOO.util.Dom.get('txtMF_AR');
		var elRL = YAHOO.util.Dom.get('txtMF_RetailLink');
		if(elAMR.value != "" && isNaN(elAMR.value)){
			alert("Actual Multiple Retail must be a number");
			elAMR.value = "";
			return false;
		}
		if(elAR.value !="" && isNaN(elAR.value)){
			alert("Actual Retail must be a number");
			elAR.value = "";
			return false;
		}
		if(elAR.value > 9999999.99)
			{
					alert("Actual Retail is above the maximum limit [9999999.99].Please re-enter.");
					elAR.value = "";
					return false;
			}
		if(elRL.value!= null &&	elRL.value != ""){
			alert("The Retail Link is entered,to edit Actual Multiple Retail or ActualRetail please remove Retail Link");
			elAR.value=actualRT;
			elAMR.value=actualAMR;
		}
	}
	
	/*function initCostAndRetail(){
		
		initLstObjFilter();
	}*/
	
	function initLstObjFilter()
	{
		if(arrSellingIdObj.length ==0){
		arrSellingIdObj.push("vendorFilter");
		arrSellingIdObj.push("sellingUpcFilter");
		arrSellingIdObj.push("caseUPCFilter");
		arrSellingIdObj.push("listCostFilter");
		arrSellingIdObj.push("unitCostFilter");
		arrSellingIdObj.push("suggestedMultipleRetailFilter");
		arrSellingIdObj.push("suggestedRetailFilter");
		arrSellingIdObj.push("prePriceMultipleRetailFilter");
		arrSellingIdObj.push("prePriceRetailFilter");
		arrSellingIdObj.push("actualMultipleRetailFilter");
		arrSellingIdObj.push("actualRetailFilter");
		arrSellingIdObj.push("marginFilter");
		arrSellingIdObj.push("pennyProfitFilter");
		arrSellingIdObj.push("costLinkFilter");
		arrSellingIdObj.push("retailLinkFilter");
	}
	}

	function setFilterValue(){
		if(SER.itemResultFilter != null && SER.itemResultFilter != ""){
			var filterValues = document.getElementById('filterValues').value;
			if(filterValues != "")
			{
				var curTab = 4;
				var com = YAHOO.lang;
				var arrValueTab = filterValues.split("___");
								    
				if(arrValueTab[0] != ""){
					document.getElementById('vendorFilter').value = com.trim(arrValueTab[0].split('||')[0]);
					document.getElementById('sellingUpcFilter').value = com.trim(arrValueTab[0].split('||')[1]);
				}
				
				if(arrValueTab.length >curTab){
					var valueFilterOnTab = com.trim(arrValueTab[curTab]);
					if(valueFilterOnTab != ""){
						var arrObjFilter = arrSellingIdObj;
						var arrValueOnTab = valueFilterOnTab.split('||');
						if(arrObjFilter.length >0){
							for(var i = 0 ;i< arrValueOnTab.length;i++)
							{
								var pos = arrValueOnTab[i].indexOf(':');
								var index = arrValueOnTab[i].substring(0,pos);
								if(document.getElementById(arrObjFilter[index]) != null)
									document.getElementById(arrObjFilter[index]).value = arrValueOnTab[i].substring(pos+1);
							}
						}
					}										
				}
			}
		}
	}
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("massFillBtnCostAndRetail"), "click", massfillCostAndRetail);			
</script>
<body class="yui-skin-sam">
	<div id="yahoo-com" class="yui-skin-sam">
		<div id="CostAndRetailMain">
			<table border="0" width="100%">
				<tr>
					<td width="40%"><div id="totalRecord" style="padding-left: 5px; color: blue"></div>	</td>
					<td><div id="saveResult" style="color: green"></div></td>
				</tr>
			</table>
		    <div style="width:100%; z-index:15000;">
			    <div id="gridCostAndRetail"></div> 
			    <div id="pag" style="font-family:arial; font-size:10px;"></div>
		    </div>
		</div>
	</div>
	<% if(request.getSession().getAttribute("ManageEDICandidate") != null)
  		{
		String tempid="";
			ManageEDICandidate cpsEDIManageForm = (ManageEDICandidate)request.getSession().getAttribute("ManageEDICandidate");
		List<EDISearchResultVO> ediSearchResultVO = cpsEDIManageForm.getEdiSearchResultVOLst();
		boolean isActiveProduct = cpsEDIManageForm.getCandidateEDISearchCriteria().getActionId().equals("5");
		boolean isVend = cpsEDIManageForm.getIsVendor();
		//get list result and add to String Buffer to make a data for yui datatable
		String strContent = "";  
		StringBuffer strBuffer = new StringBuffer();
		for(int i=0;i<ediSearchResultVO.size();i++){
     		EDISearchResultVO ediResult = ediSearchResultVO.get(i);
     		if(CPSHelper.isNotEmpty(ediResult.getPsItemId()))
     		{
    			String WorkRq = String.valueOf(ediResult.getPsWorkId() != null? ediResult.getPsWorkId():ediResult.getPsProdId());
    			String id = ediResult.getPsProdId()+"-"+ ediResult.getPsItemId() + "-" + ediResult.getPsVendno() + "-" + ediResult.getChannel()+"-"+ WorkRq +"-"+i;
     			String idRowHidden=CPSHelper.displaySellingUPC(ediResult.getUpcNo())+"__"+ediResult.isActiveProductKit();	
      			String vendor_id = ediResult.getPsVendno() +" "+ CPSHelper.convertCharToHTMLForJSON(ediResult.getPsVendName());
	         	if(i==0 || strBuffer.length()==0 ){
 		         	strBuffer.append("{checkBox:\"<input type='checkbox' id='ckb_"+ id +"'  name ='ckb_"+ WorkRq +"' >\",idResult:\"" + id);
					}
	         	else
		         	strBuffer.append("\n,{checkBox:\"<input type='checkbox' id='ckb_"+ id +"'  name ='ckb_"+ WorkRq +"'>\",idResult:\"" + id);
		         		
         		
         		strBuffer.append("\",vendor:\"" + vendor_id + "\",sellingUpc:\"" + CPSHelper.displaySellingUPC(ediResult.getUpcNo()));
         		strBuffer.append("\",changeStatus:\""+ (ediResult.isDisable() || ediResult.getCandidateSw()=='N' ? "-1":"0"));
       			strBuffer.append("\",caseUPC:\"" + (CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getCaseUpc()) ? "" : ediResult.getCostAndRetailDetailVO().getCaseUpc())); 
  				strBuffer.append("\",listCost:\"" + ((isActiveProduct && isVend)|| CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getListCost()) ? "" : "$" + ediResult.getCostAndRetailDetailVO().getListCost()) ); 
				strBuffer.append("\",unitCost:\"" + ((isActiveProduct && isVend) || CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getUnitCost()) ? "": "$" + ediResult.getCostAndRetailDetailVO().getUnitCost())); 
				strBuffer.append("\",suggestedMultipleRetail:\"" +  (CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getSuggestedMultipleRetail()) ? "" : ediResult.getCostAndRetailDetailVO().getSuggestedMultipleRetail())); 
				strBuffer.append("\",suggestedRetail:\"" + (CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getSuggestedRetail()) ? "" : "$" + ediResult.getCostAndRetailDetailVO().getSuggestedRetail())); 
			    strBuffer.append("\",prePriceMultipleRetail:\"" + (CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getPrePriceMultipleRetail()) ? "" : ediResult.getCostAndRetailDetailVO().getPrePriceMultipleRetail())); 
			    strBuffer.append("\",prePriceRetail:\"" + (CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getPrePriceRetail()) ? "" : "$" + ediResult.getCostAndRetailDetailVO().getPrePriceRetail())); 
			    strBuffer.append("\",actualMultipleRetail:\"" + (isVend || CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getActualMultipleRetail()) ? "" :  ediResult.getCostAndRetailDetailVO().getActualMultipleRetail())); 
			   	strBuffer.append("\",actualRetail:\"" + (isVend || CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getActualRetail()) ? "" : ediResult.getCostAndRetailDetailVO().getActualRetail())); 
			   	strBuffer.append("\",margin:\"" + (isVend || CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getPercentageMargin()) ? "" : ediResult.getCostAndRetailDetailVO().getPercentageMargin()));
			   	strBuffer.append("\",pennyProfit:\"" + ( isVend || CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getPennyProfit()) ? "" : "$" + ediResult.getCostAndRetailDetailVO().getPennyProfit()));
			   	strBuffer.append("\",workrqstID:\"" + (ediResult.getPsWorkId()!=null ? ediResult.getPsWorkId():ediResult.getPsProdId()));
			   	strBuffer.append("\",costLink:\"" + (CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getCostLink()) ? "" : ediResult.getCostAndRetailDetailVO().getCostLink()));
			   	strBuffer.append("\",productID:\"" + ediResult.getPsProdId());
			   	strBuffer.append("\",retailLink:\"" + (CPSHelper.isEmpty(ediResult.getCostAndRetailDetailVO().getRetailLink()) ? "" : ediResult.getCostAndRetailDetailVO().getRetailLink()));
			  	strBuffer.append("\",status:\""+ ediResult.getStatus());
				strBuffer.append("\",idRowHidden:\""+ idRowHidden+ "\"}");
	         	
		     }
      	}
		
  	%>
	
  	<script type="text/javascript">  
  		dataCostAndRetail = {   
  		         listCostAndRetail:[<%=strBuffer%>]
	         };  

		var changeRequest = false;
		var dataSourceTemp = [];
		var filterItemReturn = []; 		
		initLstObjFilter();
		var costAndRetailResult = makeCostAndRetailTable();
		function makeCostAndRetailTable() {
    	 
        // Custom sort handler to sort by state and then by areacode
        // where a and b are Record instances to compare
        
        var formatActualMultipleRetail = function(elCell, oRecord, oColumn, sData) {
            if(oRecord.getData("changeStatus") == "-1" || oRecord.getData("status") == "103" || isVendor==true || oRecord.getData("changeStatus") == "4"){
				elCell.innerHTML = "<input type='text' style='text-align: right;' id='actualMultipleRetail_" + oRecord.getData("idResult") +"' value='" + oRecord.getData("actualMultipleRetail") +"' class='disabled-text' size='2' readonly='readonly' />";
			}else{
				elCell.innerHTML = "<input type='text' style='text-align: right;' id='actualMultipleRetail_" + oRecord.getData("idResult") +"' name='actualMultipleRetail_" + oRecord.getData("workrqstID") +"' value='" + oRecord.getData("actualMultipleRetail") +"' onchange='editRowContent(this);' maxlength='5' size='2' style='dataType : numeric;' onfocus='setOldValueToElement(this)' />";
			}
        };
		var formatActualRetail = function(elCell, oRecord, oColumn, sData) {
            if(oRecord.getData("changeStatus") == "-1" || oRecord.getData("status") == "103" || isVendor==true || oRecord.getData("changeStatus") == "4"){
            	elCell.innerHTML = "$<input type='text' style='text-align: right;' id='actualRetail_" + oRecord.getData("idResult") +"' value='" + oRecord.getData("actualRetail") +"' class='disabled-text' size='11' readonly='readonly'/>";
			}else{
				elCell.innerHTML = "$<input type='text' style='text-align: right;' id='actualRetail_" + oRecord.getData("idResult") +"' name='actualRetail_" + oRecord.getData("workrqstID") +"' value='" + oRecord.getData("actualRetail") +"' onchange='editRowContent(this);' maxlength='11' size='11' style='dataType : float;' onfocus='setOldValueToElement(this)' />";
			}
        };
		var formatRetailLink = function(elCell, oRecord, oColumn, sData) {
            if(oRecord.getData("changeStatus") == "-1" || oRecord.getData("status") == "103" || isVendor==true || oRecord.getData("changeStatus") == "4"){
            	elCell.innerHTML = "<input type='text' id='retailLink_" + oRecord.getData("idResult") +"' value='" + oRecord.getData("retailLink") +"' class='disabled-text' readonly='readonly'/>";
			}else{
				elCell.innerHTML = "<input type='text' id='retailLink_" + oRecord.getData("idResult") +"' name='retailLink_" + oRecord.getData("workrqstID") +"' value='" + oRecord.getData("retailLink") +"' onchange='editRowContentRetailLink(this);' maxlength='13' style='dataType : numeric;' />";
			}			
        };
        var formatPenny = function(elCell, oRecord, oColumn, sData) {
            	elCell.innerHTML = "<div id='pennyProfit_" + oRecord.getData("idResult") +"' class='pennyProfit_" + oRecord.getData("workrqstID") +"'>"+oRecord.getData("pennyProfit")+"</div>";
        };
        var formatMargin = function(elCell, oRecord, oColumn, sData) {
        	elCell.innerHTML = "<div id='margin_" + oRecord.getData("idResult") +"' class='margin_" + oRecord.getData("workrqstID") +"'>"+oRecord.getData("margin")+"</div>";
        };
    

        function sortCompare(a, b, sortBy, field, fieldReturnIfEqual, isNumber)
        {
        	 // Deal with empty values   
            if(!YAHOO.lang.isValue(a)) {
                return (!YAHOO.lang.isValue(b)) ? 0 : 1;
            }
            else if(!YAHOO.lang.isValue(b)) {
                return -1;
            }
            var comp = YAHOO.util.Sort.compare;
            var compState;
			if(field == "listCost" || field=="unitCost" || field=="suggestedRetail" || field=="prePriceRetail" || field=="pennyProfit"){
				compState = comp(eval(a.getData(field).substring(1) !== "" ?a.getData(field).substring(1) :"0"), eval(b.getData(field).substring(1)!== ""?b.getData(field).substring(1):"0"), sortBy);
			}else{
            // First compare by state
           
			if(isNumber)
				compState = comp(eval(a.getData(field) !== ""?a.getData(field):"0"), eval(b.getData(field)!== ""?b.getData(field):"0"), sortBy);
			else				
				compState = comp(a.getData(field), b.getData(field), sortBy);
			}

            // If states are equal, then compare by areacode
			return (compState !== 0) ? compState : comp(a.getData(fieldReturnIfEqual), b.getData(fieldReturnIfEqual), sortBy);
        }

        var sortVendor = function(a, b, desc) {
            return sortCompare(a, b, desc, "vendor", "sellingUpc",false);           
        };
        var sortSellingUPC = function(a, b, desc) {
        	return sortCompare(a, b, desc, "sellingUpc", "vendor",false); 
        };
        var sortCaseUPC = function(a, b, desc) {
        	return sortCompare(a, b, desc, "caseUPC", "sellingUpc",true); 
        };
        var sortListCost = function(a, b, desc) {
        	return sortCompare(a, b, desc, "listCost", "sellingUpc",true); 
        };
        var sortUnitCost = function(a, b, desc) {
        	return sortCompare(a, b, desc, "unitCost", "sellingUpc",true); 
        };
        var sortSuggestedMultipleRetail = function(a, b, desc) {
        	return sortCompare(a, b, desc, "suggestedMultipleRetail", "sellingUpc",true); 
        };
        var sortSuggestedRetail = function(a, b, desc) {
        	return sortCompare(a, b, desc, "suggestedRetail", "sellingUpc",true); 
        };
        var sortPrePriceMultipleRetail = function(a, b, desc) {
        	return sortCompare(a, b, desc, "prePriceMultipleRetail", "sellingUpc",true); 
        };
        var sortPrePriceRetail = function(a, b, desc) {
        	return sortCompare(a, b, desc, "prePriceRetail", "sellingUpc",true); 
        };
        var sortActualMultipleRetail = function(a, b, desc) {
        	return sortCompare(a, b, desc, "actualMultipleRetail", "sellingUpc",true); 
        };
        var sortActualRetail = function(a, b, desc) {
        	return sortCompare(a, b, desc, "actualRetail", "sellingUpc",true); 
        };
        var sortMargin = function(a, b, desc) {
        	return sortCompare(a, b, desc, "margin", "sellingUpc",true); 
        };
        var sortPennyProfit = function(a, b, desc) {
        	return sortCompare(a, b, desc, "pennyProfit", "sellingUpc",true); 
        };
        var sortCostLink = function(a, b, desc) {
        	return sortCompare(a, b, desc, "costLink", "sellingUpc",true); 
        };
        var sortRetailLink = function(a, b, desc) {
        	return sortCompare(a, b, desc, "retailLink", "sellingUpc",true); 
        };
        var myRowFormatter = function(elTr, oRecord) {   
            if (oRecord.getData('changeStatus') == "2" || oRecord.getData('changeStatus') == "3" || oRecord.getData('changeStatus') == "-2") {   
                YAHOO.util.Dom.addClass(elTr, 'mark');   
            }
            return true;   
        };
        var myColumnDefs = [ 
							 {key:"checkboxs",    label:"All", minWidth: 10,
							  children: [{key:"checkBox", label:"<input type='checkbox' id='SelectAll'/>",sortable:false, resizeable:false}]},
							 {key:"idResult",    label:"<input type='hidden' id='hiddenResultColumn'/>", minWidth: 10},
                            {key:"vendors",    label:"Vendor", width: 150,sortable:true ,sortOptions:{sortFunction:sortVendor},
							  children: [{key:"vendor", label:"<div id='vendorDiv'  class ='myAutoComplete'><input type='text' id='vendorFilter' name='divFilterSel' size='25' maxlength='30'  style='TEXT-TRANSFORM\: uppercase; position: relative;' \/><img src='${image}' alt='' width='20' id='vendorFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerVendorFilter'></div></div>",width:200,sortable:false, resizeable:false}]},
							 {key:"changeStatus",    label:"<input type='hidden' id='hiddencolumn'/>", minWidth: 10},  
                            {key:"sellingUpcs",    label:"Selling UPC",width: 105, sortable:true ,sortOptions:{sortFunction:sortSellingUPC},
							 children: [{key:"sellingUpc", label:"<div id ='sellingUpcDiv' class ='myAutoComplete'><input type='text' id='sellingUpcFilter' name='divFilterSel' size='19' maxlength='30' style='TEXT-TRANSFORM\: uppercase; position: relative;' \/><img src='${image}' alt='' width='20' id='sellingUpcFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerSellingUpcFilter'></div></div>",sortable:false, resizeable:false}]},
                            {key:"caseUPCs",    label:"Case UPC", width: 100, sortable:true,sortOptions:{sortFunction:sortCaseUPC},
							 children: [{key:"caseUPC", label:"<div id ='caseUPCDiv' class ='myAutoComplete'><input type='text' id='caseUPCFilter' name='divFilterSel' size='19' maxlength='30' style='TEXT-TRANSFORM\: uppercase; position: relative;' \/><img src='${image}' alt='' width='20' id='caseUPCFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerCaseUPCFilter'></div></div>",sortable:false, resizeable:false}]},
                            {key:"listCosts",    label:"List Cost", width: 50, sortable:true,sortOptions:{sortFunction:sortListCost},
							 children: [{key:"listCost", label:"<div id ='listCostDiv'><input type='text' id='listCostFilter' name='divFilterSel' size='5' maxlength='30'\/></div>",sortable:false, resizeable:false, className: "align-right"}]},
                            {key:"unitCosts",    label:"Unit Cost", width: 50, sortable:true,sortOptions:{sortFunction:sortUnitCost},
							 children: [{key:"unitCost", label:"<div id ='unitCostDiv'><input type='text' id='unitCostFilter' name='divFilterSel' size='5' maxlength='30'\/></div>",sortable:false, resizeable:false, className: "align-right"}]},
                            {key:"suggestedMultipleRetails",    label:"Suggested<br/><center>Multiple</center>Retail", width: 50, sortable:true,sortOptions:{sortFunction:sortSuggestedMultipleRetail},
							 children: [{key:"suggestedMultipleRetail", label:"<div id ='suggestedMultipleRetailDiv'><input type='text' id='suggestedMultipleRetailFilter' name='divFilterSel' size='5' maxlength='30'\/></div>",sortable:false, resizeable:false, className: "align-right"}]},
                            {key:"suggestedRetails",    label:"Suggested<br/> Retail", width: 50, sortable:true,sortOptions:{sortFunction:sortSuggestedRetail},
							 children: [{key:"suggestedRetail", label:"<div id ='suggestedRetailDiv'><input type='text' id='suggestedRetailFilter' name='divFilterSel' size='5' maxlength='30'\/></div>",sortable:false, resizeable:false, className: "align-right"}]},
                            {key:"prePriceMultipleRetails",    label:"Pre Price <br/><center>Multiple</center> Retail", width: 50, sortable:true,sortOptions:{sortFunction:sortPrePriceMultipleRetail},
							 children: [{key:"prePriceMultipleRetail", label:"<div id ='prePriceMultipleRetailDiv'><input type='text' id='prePriceMultipleRetailFilter' name='divFilterSel' size='5' maxlength='12'\/></div>",sortable:false, resizeable:false, className: "align-right"}]},
                            {key:"prePriceRetails",    label:"Pre<br/><center>Price</center>&nbsp;&nbsp;&nbsp;&nbsp;Retail", width: 50, sortable:true,sortOptions:{sortFunction:sortPrePriceRetail},
							 children: [{key:"prePriceRetail", label:"<div id ='prePriceRetailDiv'><input type='text' id='prePriceRetailFilter' name='divFilterSel' size='5' maxlength='12'\/></div>",sortable:false, resizeable:false, className: "align-right"}]},
                            {key:"actualMultipleRetails",    label:"Actual<br/><center>Multiple</center>&nbsp;&nbsp;Retail", width: 50, sortable:true,sortOptions:{sortFunction:sortActualMultipleRetail},formatter:formatActualMultipleRetail,
							 children: [{key:"actualMultipleRetail", label:"<div id ='actualMultipleRetailDiv'><input type='text' id='actualMultipleRetailFilter' name='divFilterSel' size='5' maxlength='12'\/></div>",sortable:false, resizeable:false, className: "align-right"}]},
                            {key:"actualRetails",    label:"Actual<br/><center>Retail</center>", width: 100, sortable:true,sortOptions:{sortFunction:sortActualRetail},formatter:formatActualRetail,
							 children: [{key:"actualRetail", label:"<div id ='actualRetailDiv'><input type='text' id='actualRetailFilter' name='divFilterSel' size='11' maxlength='12'\/></div>",sortable:false, resizeable:false, className: "align-right"}]},
                            {key:"margins",    label:"% Margin", width: 60, sortable:true,sortOptions:{sortFunction:sortMargin},formatter:formatMargin,
							 children: [{key:"margin", label:"<div id ='marginDiv'><input type='text' id='marginFilter' name='divFilterSel' size='5' maxlength='30'\/></div>",sortable:false, resizeable:false, className: "align-right"}]},
							 {key:"status",    label:"<input type='hidden' id='hiddenStatus'/>", minWidth: 10}, 
                            {key:"pennyProfits",    label:"Penny<br/><center>Profit</center>", width: 50, sortable:true,sortOptions:{sortFunction:sortPennyProfit},formatter:formatPenny,
							 children: [{key:"pennyProfit", label:"<div id ='pennyProfitDiv'><input type='text' id='pennyProfitFilter' name='divFilterSel' size='5' maxlength='12'\/></div>",sortable:false, resizeable:false, className: "align-right"}]},
							 {key:"workrqstID",    label:"<input type='hidden' id='hiddenProductID'/>", minWidth: 10},
                            {key:"costLinks",    label:"Cost Link", width: 85, sortable:true,sortOptions:{sortFunction:sortCostLink},
							 children: [{key:"costLink", label:"<div id ='costLinkDiv'><input type='text' id='costLinkFilter' name='divFilterSel' size='10' maxlength='15'\/></div>",sortable:false, resizeable:false}]},
                            {key:"retailLinks",    label:"Retail Link", minWidth: 180, sortable:true,sortOptions:{sortFunction:sortRetailLink},formatter:formatRetailLink,
							 children: [{key:"retailLink", label:"<table class='tbl-filter'><tr><td width='110' class='td-filter'><div id='retailLink'><input type='text' id='retailLinkFilter' size='15' name='divFilterSel'\/></div></td><td class='td-filter'><input type='button' id='filterStatus' value='Hide'\/><input type='button' id='clearSelFilter' value='Clear'\/></td></tr></table>",sortable:false, resizeable:false}]},
							{key:"idRowHidden"}];
 

 
        var myDataSource = new YAHOO.util.DataSource(dataCostAndRetail.listCostAndRetail);
        myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
        myDataSource.responseSchema = {
            fields: ["checkBox","idResult","vendor","changeStatus","sellingUpc","caseUPC","listCost","unitCost","suggestedMultipleRetail","suggestedRetail","prePriceMultipleRetail","prePriceRetail","actualMultipleRetail","actualRetail","margin","status","pennyProfit","workrqstID","costLink","productID","retailLink","status","idRowHidden"]
        };
		myDataSource.doBeforeCallback = function (req,raw,res,cb) {
			// This is the filter function							
			var data     = res.results || [],
				filtered = [],
				i,l;
			
			if (dataSourceTemp.length ==0){
				dataSourceTemp = data;		
			}		
			var i = 0;	

			if(SER.itemResultFilter != null && SER.itemResultFilter != "")
			{				
				var resultFilter = SER.itemResultFilter.split(",");
				if(resultFilter.length > 0 && filterItemReturn.length == 0){
					for (i = 0; i< dataSourceTemp.length; i++) 
					{
						var value  = dataSourceTemp[i].sellingUpc + "_" + dataSourceTemp[i].idResult.split("-")[1] + "_" + dataSourceTemp[i].idResult.split("-")[2];
						
						if(resultFilter.inArray(value)){
							filterItemReturn.push(dataSourceTemp[i]);
						}
					}					
				}
				res.results = filterItemReturn;				
			}		
			if (req) {		
				var temp="";	
				if(SER.itemResultFilter != null && SER.itemResultFilter != "" && filterItemReturn.length >0){
					for (i = 0; i< filterItemReturn.length; i++) 
					{
						temp="";																	
						temp=SER.convertFromIrToRegularPattern(filterItemReturn[i].vendor.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].sellingUpc.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].caseUPC.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].listCost.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].unitCost.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].suggestedMultipleRetail.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].suggestedRetail.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].prePriceMultipleRetail.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].prePriceRetail.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].actualMultipleRetail.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].actualRetail.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].margin.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].pennyProfit.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].costLink.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].retailLink.toUpperCase());
						var pattern = new RegExp(req);			
						if(pattern.test(temp))
						{								
							filtered.push(filterItemReturn[i]);			
						}
					}
				}else{									
					for (i = 0, l = dataSourceTemp.length; i < l; ++i) 
					{
						temp="";																	
						temp=SER.convertFromIrToRegularPattern(dataSourceTemp[i].vendor.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].sellingUpc.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].caseUPC.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].listCost.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].unitCost.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].suggestedMultipleRetail.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].suggestedRetail.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].prePriceMultipleRetail.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].prePriceRetail.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].actualMultipleRetail.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].actualRetail.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].margin.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].pennyProfit.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].costLink.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].retailLink.toUpperCase());										
						var pattern = new RegExp(req);			
						if(pattern.test(temp))
						{													
							filtered.push(dataSourceTemp[i]);			
						}						
					}
				}
				res.results = filtered;	
				//set style to enable and disable the word "No record found"
				var nodes = YAHOO.util.Selector.query('td.yui-dt-empty div.yui-dt-liner');
				if(filtered.length >0){						   
					 if(nodes != null)							
						YAHOO.util.Dom.setStyle(nodes, 'display', 'none');							
				}
				else
				{
					if(nodes != null)
						YAHOO.util.Dom.setStyle(nodes, 'display', '');
				}
			}		
			return res;
		};
 
        var myConfigs = {
            paginator: new YAHOO.widget.Paginator({
                rowsPerPage: parseInt(SER.currentRecord),
                template: YAHOO.widget.Paginator.TEMPLATE_ROWS_PER_PAGE,
                rowsPerPageOptions: [10,25,50,100],
                pageLinks: 5,
                containers:'pag'
            }),
            draggableColumns:false,
            height:"250px",
            formatRow: myRowFormatter
        }     
 
        var myDataTable = new YAHOO.widget.ScrollingDataTable("gridCostAndRetail", myColumnDefs, myDataSource, myConfigs);
		
		//get data of each field to array
		
		arrayDataFilter = [];
		setDataSourceForAutocompleteFilter();
			
		//set autocomplete for filter		
		var cnt=0;
		for(var i=0;i < 3;i++)
		{					
			setAutoCompleteForFilter("myContainer"+arrSellingIdObj[i].capitaliseFirstLetter(arrSellingIdObj[i]),arrSellingIdObj[i],cnt++);
			document.getElementById(arrSellingIdObj[i]).parentNode.parentNode.parentNode.style.overflow = 'visible';
		}
		
		
        //hide column
		myDataTable.hideColumn(myDataTable.getColumn("changeStatus"));
		myDataTable.hideColumn(myDataTable.getColumn("idResult"));
		myDataTable.hideColumn(myDataTable.getColumn("workrqstID"));
		myDataTable.hideColumn(myDataTable.getColumn("status"));
		myDataTable.hideColumn(myDataTable.getColumn("idRowHidden"));
		// start event when click on checkbox
        myDataTable.subscribe("checkboxClickEvent", function(oArgs){ 
        	
            var elCheckbox = oArgs.target; 
            var oRecord = this.getRecord(elCheckbox); 
            var column = this.getColumn(elCheckbox);
			var idResult = oRecord.getData("idResult");
			var workrqstID = oRecord.getData("workrqstID");
			var oRS = myDataTable.getRecordSet();
			for(var i=0; i<oRS.getLength(); i++) {
   	                var oRec = oRS.getRecord(i);
				if(workrqstID == oRec.getData("workrqstID")&& elCheckbox.checked){
					
						oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[4] +" checked=checked name=factoryList class=yui-dt-checkbox />"); 
						oRec.setData("changeStatus", getChangeStatusOnCostAndRetailTab(oRec.getData("changeStatus"), true));
					
				}
				else{
						if(workrqstID == oRec.getData("workrqstID")&& !elCheckbox.checked){
								oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[4] +" class=yui-dt-checkbox />");
								oRec.setData("changeStatus", getChangeStatusOnCostAndRetailTab(oRec.getData("changeStatus"), false));
							
						if(YAHOO.util.Dom.get('SelectAll').checked)
							YAHOO.util.Dom.get('SelectAll').checked = false;
						}
					}
					
			}
			if(elCheckbox.checked)	
   				saveDataSourceTempWhenCheck(workrqstID, true, false);
			else
				saveDataSourceTempWhenCheck(workrqstID, false, false);
				
			changeRequest = true;
			//this.render();
			var checkBoxs = document.getElementsByName("ckb_" + workrqstID);
			if(checkBoxs != null){			
				for(i=0;i<checkBoxs.length;i++)
				{
					if(elCheckbox.checked)
						checkBoxs[i].checked = true;
					else
						checkBoxs[i].checked = false;
				}
			}			
		
        }); 

		// event for clill check box "All"
        myDataTable.on('theadCellClickEvent', function (oArgs) {
    		var target = oArgs.target,
    			column = this.getColumn(target),
    			actualTarget = YAHOO.util.Event.getTarget(oArgs.event),
    			check = actualTarget.checked;
    		
    		if (column.key == 'checkBox') {
    			if(typeof check != 'undefined'){
	    			var oRS = myDataTable.getRecordSet();
	    			var arrCurentRecordsId = new Array();
	    			for(var i=0; i<oRS.getLength(); i++) {
	   	                var oRec = oRS.getRecord(i);
	   	             	var tempPsWrkId=oRec.getData("workrqstID");	
						arrCurentRecordsId.push(tempPsWrkId);
	    	            if(check){	    	            	
	    	            	oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[4] +" checked=checked name=factoryList class=yui-dt-checkbox />");
								var changeValue = getChangeStatusOnCostAndRetailTab(oRec.getData("changeStatus"), true);
								if(changeValue != null)
									oRec.setData("changeStatus", changeValue);
		    	            	
						}else{								
	           				oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[4] +" class=yui-dt-checkbox />");  
								var changeValue = getChangeStatusOnCostAndRetailTab(oRec.getData("changeStatus"), false);
								if(changeValue != null)
									oRec.setData("changeStatus", changeValue);
								
						}		    	               
	    			}
	    			if(check)	
	    				saveDataSourceTempWhenCheck(arrCurentRecordsId, true, true);
					else
						saveDataSourceTempWhenCheck(arrCurentRecordsId, false, true);
						
					changeRequest = true;
					this.render();	
					
    			}
    		}
			

    	});
      //render event
		myDataTable.on('renderEvent', function () {
			if(SER.hasFilter){
				var isCheckFlag = false;
				for(var i = 0;i< myDataTable.getRecordSet().getLength();i++)
		   		{
		   			var oRec = myDataTable.getRecordSet().getRecord(i);
		   			var status = oRec.getData("changeStatus");
		   			if(status != 1 && status != 3 && status != 4){
		   				isCheckFlag = true;
		   				break;
		   			}
		   		}

		   		if(isCheckFlag)
		   			YAHOO.util.Dom.get('SelectAll').checked = false;
			}

			//set total record retuned 
			var totalRecords = myDataTable.get('paginator').getState().totalRecords;
			var itemReturn = (totalRecords < dataSourceTemp.length? " (out of " + dataSourceTemp.length + " total " + (dataSourceTemp.length>1?"items":"item") + ") returned" : " returned");			
			if(totalRecords > 1)
				YAHOO.util.Dom.get('totalRecord').innerHTML = totalRecords + " items" + itemReturn;
			else
				YAHOO.util.Dom.get('totalRecord').innerHTML = totalRecords + " item" + itemReturn;
		});
		
        myDataTable.get('paginator').on( 'changeRequest', function () {
            var cur = myDataTable.get('paginator').getState();
            SER.currentRecord = cur.rowsPerPage;
            SER.currentPage = cur.page;
            changeRequest = true;} );

        //set page is selected	
        myDataTable.get('paginator').setPage(parseInt(SER.currentPage)); 
    	
		//filter	
		filterTimeout = null;
			updateFilter  = function () 
			{
				filterTimeout = null;
				var pattent = gePattern();			
				myDataSource.sendRequest(pattent,{
					success : myDataTable.onDataReturnInitializeTable,
					failure : myDataTable.onDataReturnInitializeTable,
					scope   : myDataTable,
					argument: pattent	
				});
			}
			myDataTable.subscribe("postRenderEvent", function(){
		    		var elements = YAHOO.util.Dom.getElementsByClassName('yui-dt-bd', 'div')[0];
		    		
		    			if(elements!=null)
		    			{
		    				var beforeScroll = elements.scrollLeft;
		    				elements.scrollLeft = beforeScroll;
		    				//elements.scrollLeft = beforeScroll;
		    			}	
		    		});	

	    var evtFilter= 'change';		        	
		YAHOO.util.Event.on('vendorFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
	
		YAHOO.util.Event.on('sellingUpcFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('caseUPCFilter',evtFilter,function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('listCostFilter',evtFilter,function (e) {	
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('unitCostFilter',evtFilter,function (e) {				
			doBeforeFilter(e);
		});	
		
		YAHOO.util.Event.on('suggestedMultipleRetailFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('suggestedRetailFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('prePriceMultipleRetailFilter',evtFilter,function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('prePriceRetailFilter',evtFilter,function (e) {	
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('actualMultipleRetailFilter',evtFilter,function (e) {	
			doBeforeFilter(e);
		});	
		
		YAHOO.util.Event.on('actualRetailFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('marginFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('pennyProfitFilter',evtFilter,function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('costLinkFilter',evtFilter,function (e) {	
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('retailLinkFilter',evtFilter,function (e) {	
			doBeforeFilter(e);
		});
		
		// clear filter
		YAHOO.util.Event.on('clearSelFilter','click',function (e) {	
			document.getElementById("vendorFilter").value='';
			document.getElementById("sellingUpcFilter").value='';
			document.getElementById("caseUPCFilter").value='';
			document.getElementById("listCostFilter").value='';
			document.getElementById("unitCostFilter").value='';
			document.getElementById("suggestedMultipleRetailFilter").value='';
			document.getElementById("suggestedRetailFilter").value='';
			document.getElementById("prePriceMultipleRetailFilter").value='';
			document.getElementById("prePriceRetailFilter").value='';
			document.getElementById("actualMultipleRetailFilter").value='';
			document.getElementById("actualRetailFilter").value='';
			document.getElementById("marginFilter").value='';
			document.getElementById("pennyProfitFilter").value='';
			document.getElementById("costLinkFilter").value='';
			document.getElementById("retailLinkFilter").value='';
			
			SER.hasFilter = false;
			
			if(SER.itemResultFilter != null && SER.itemResultFilter != "")
			{
				SER.itemResultFilter = "";
				setDataSourceForAutocompleteFilter();
			}
			document.getElementById('filterValues').value = "";
			
			clearTimeout(filterTimeout);
			setTimeout(updateFilter,600);
		});
		
		// check for symbol that not support
		function doBeforeFilter(e)
		{		
			clearTimeout(filterTimeout);
			setTimeout(updateFilter,600);
			SER.hasFilter = true;
		};
		YAHOO.util.Event.on('filterStatus','click',  function(e){
			hideShowFilter(e);
		});

		setFilterValue();
    	
        return {
            oDS: myDataSource,
            oDT: myDataTable
        };
    };

    function setDataSourceForAutocompleteFilter()
    {       	
    	for(var i = 0 ;i< 3 ; i++)
		{
			arrayDataFilter[i] = [];
		}
				
		if(SER.itemResultFilter != null && SER.itemResultFilter != "")
		{				
			if(filterItemReturn.length > 0){
				for (var i = 0; i< filterItemReturn.length; i++) 
				{					
					if(!(arrayDataFilter[0]).inArray(filterItemReturn[i].vendor) && filterItemReturn[i].vendor !=''){
						arrayDataFilter[0].push(filterItemReturn[i].vendor);
					}
				
					if(!(arrayDataFilter[1]).inArray(filterItemReturn[i].sellingUpc) && filterItemReturn[i].sellingUpc !=''){
						arrayDataFilter[1].push(filterItemReturn[i].sellingUpc);
					}
					
					if(!(arrayDataFilter[2]).inArray(filterItemReturn[i].caseUPC) && filterItemReturn[i].caseUPC !=''){
						arrayDataFilter[2].push(filterItemReturn[i].caseUPC);	
				}				
			}							
		 }
		}
		else
		{
			for(var i = 0;i < dataSourceTemp.length; i++)
			{
				if(!(arrayDataFilter[0]).inArray(dataSourceTemp[i].vendor) && dataSourceTemp[i].vendor !=''){
					arrayDataFilter[0].push(dataSourceTemp[i].vendor);
				}
				
				if(!(arrayDataFilter[1]).inArray(dataSourceTemp[i].sellingUpc) && dataSourceTemp[i].sellingUpc !=''){
					arrayDataFilter[1].push(dataSourceTemp[i].sellingUpc);
				}
				
				if(!(arrayDataFilter[2]).inArray(dataSourceTemp[i].caseUPC) && dataSourceTemp[i].caseUPC!=''){
					arrayDataFilter[2].push(dataSourceTemp[i].caseUPC);					
			}
		}	
    }
    }
    
    function gePattern()
	{
		var comp = YAHOO.lang;

		var lstObj = new Array();
		var lstObjVl = new Array();

		for(var i = 0 ;i< arrSellingIdObj.length;i++)
		{
			lstObj.push(document.getElementById(arrSellingIdObj[i]));
		}

		//get value of each field of filter
		for(var i = 0 ;i< lstObj.length;i++)
		{
			lstObjVl.push(comp.trim(lstObj[i].value.toUpperCase()));
		}


		//convert from irregular pattern to regular pattern
		for(var i = 0 ;i< lstObjVl.length;i++)
		{
			lstObjVl[i]=SER.convertFromIrToRegularPattern(lstObjVl[i]);
		}
							
		var partern="";
		
		//get pattent
		
		if(lstObjVl[0].length > 0) 
			{
				partern+="\.*"+lstObjVl[0]+"\.*";
			}
		else
			{
				partern+="\.*";
			}
		
		for(var i = 1 ;i< lstObjVl.length;i++)
		{
			if(lstObjVl[i].length > 0)
			{
				partern+="__"+"\.*"+lstObjVl[i]+"\.*";
			}
			else
			{
				partern+="__\.*";
			}
		}
		return partern;
	};
	//reset data on datatable
	function resetCostAndRetailTab()
    {
		var myDataSource = costAndRetailResult.oDS;
		var myDataTable = costAndRetailResult.oDT;
		YAHOO.util.Dom.get('vendorFilter').value='';
		YAHOO.util.Dom.get('sellingUpcFilter').value='';
		YAHOO.util.Dom.get('caseUPCFilter').value='';
		YAHOO.util.Dom.get('listCostFilter').value='';
		YAHOO.util.Dom.get('unitCostFilter').value='';
		YAHOO.util.Dom.get('suggestedMultipleRetailFilter').value='';
		YAHOO.util.Dom.get('suggestedRetailFilter').value='';
		YAHOO.util.Dom.get('prePriceMultipleRetailFilter').value='';
		YAHOO.util.Dom.get('prePriceRetailFilter').value='';
		YAHOO.util.Dom.get('actualMultipleRetailFilter').value='';
		YAHOO.util.Dom.get('actualRetailFilter').value='';
		YAHOO.util.Dom.get('marginFilter').value='';
		YAHOO.util.Dom.get('pennyProfitFilter').value='';
		YAHOO.util.Dom.get('costLinkFilter').value='';
		YAHOO.util.Dom.get('retailLinkFilter').value='';
		if(dataCostAndRetail != null){ 
			//reset data source filter
			filterItemReturn = [];
			
			dataSourceTemp = [];
			filterTimeout = null;
			var pattent = "\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*";			
			myDataSource.sendRequest(pattent,{
				success : myDataTable.onDataReturnInitializeTable,
				failure : myDataTable.onDataReturnInitializeTable,
				scope   : myDataTable,
				argument: pattent	
			});
    		//costAndRetailResult = makeCostAndRetailTable();
			if(YAHOO.util.Dom.get('SelectAll').checked)
						YAHOO.util.Dom.get('SelectAll').checked = false;
			
    		changeRequest = false;
    		YAHOO.util.Dom.get('saveResult').innerHTML ="";
    		//set current page is selected (before click reset button)
			myDataTable.get('paginator').setPage(parseInt(SER.currentPage));		    
		}

		setFilterValue();
		
    }
    //event for Hide and Show button Clear filter
	function hideShowFilter(e) {
		
		var evt = (window.external) ? event : e;
			var target = null;
			if(evt.srcElement){
				target =evt.srcElement; 
			}else if(evt.target){
				target =evt.target;
			}
		var selFilterDivArr = document.getElementsByName("divFilterSel");								
		var isHide=false;											
		if(target.value=='Hide')
		{
			isHide=true;
		}
		target.value="Hide";
		document.getElementById('clearSelFilter').style.display='inline-block';
		if(isHide)
		{
			target.value="Show";
			document.getElementById('clearSelFilter').style.display='none';
		}
		for(var i=0;i<selFilterDivArr.length;i++)
		{
			if(isHide)
			{
				selFilterDivArr[i].parentNode.style.display = 'none';
			}
			else
			{
				selFilterDivArr[i].parentNode.style.display = 'inline-block';
			}
		}			
	};
	function setOldValueToElement(element){
        element.oldValue = element.value;
    }
	
	
	
	    	
	</script>
  	<%}%>
 </body> 	
