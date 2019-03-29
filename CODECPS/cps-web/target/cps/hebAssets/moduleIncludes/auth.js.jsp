<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:url var="colspd" value="${request.getContextPath()}/hebAssets/images/collapsed.gif"></c:url>
<c:url var="expnd" value="${request.getContextPath()}/hebAssets/images/expanded.gif"></c:url>
<c:url value="/protected/cps/add/AddNewCandidate.do?tab=addVendor&${_csrf.parameterName}=${_csrf.token}" var="page3" />
<c:url value="/protected/cps/add/viewStores?${_csrf.parameterName}=${_csrf.token}" var="page4" />
<c:url value="/protected/cps/add/authWHS?${_csrf.parameterName}=${_csrf.token}" var="page5" />
<c:url value="/protected/cps/add/prodAndUpc?${_csrf.parameterName}=${_csrf.token}" var="pageLink" />
<c:url value="/protected/cps/add/AddNewCandidate.do?tab=upc&${_csrf.parameterName}=${_csrf.token}" var="page6" />

//global variables
var tableToRowClikedMap = new Object();

// Functions for on clicking rows from existing cases-
	var visi = "v";
	var visi1 = "v";
	var visi2 = "v";
	var visi3 = "v";

	function toggle(id){
		if(visi == "v"){
			hideTable();
			hideBorder(id,'hide');
		}else{
			showTable();
			hideBorder(id,'noHide');
		}
	}
	function hideBorder(id,classname){
		document.getElementById(id).className = classname;
	}
	function toggleAssoctdUPC(id){
		if(visi1 == "v"){
			hideAssoctdUPCTable();
			hideBorder(id,'hide');
		}else{
			showAssoctdUPCTable();
			hideBorder(id,'noHide');
		}
	}
	function toggleElemntUPC(id){
		if(visi2 == "v"){
			hideElemntUPCTable();
			hideBorder(id,'hide');
		}else{
			showElemntUPCTable();
			hideBorder(id,'noHide');
		}
	}
	
	function toggleVendor(id){
		if(visi3 == "v"){
			hideVendorTable();
			hideBorder(id,'hide');
		}else{
			showVendorTable();
			hideBorder(id,'noHide');
		}
	}
	
	var tempHtml;
	var tempHtml1;
	var tempHtml2;
	var tempHtml3;
	
	function hideTable(){
		tempHtml = document.getElementById('caseDiv').innerHTML;
		document.getElementById('caseDiv').innerHTML = "";
		document.getElementById('caseImg').src = "${colspd}";
		visi = "h";
	}
	function showTable(){
		document.getElementById('caseDiv').innerHTML = tempHtml;
		document.getElementById('caseImg').src = "${expnd}";
		visi = "v";
	}function hideAssoctdUPCTable(){
		tempHtml1 = document.getElementById('associatedUPC').innerHTML;
		document.getElementById('associatedUPC').innerHTML = "";
		document.getElementById('aUPCImg').src = "${colspd}";
		visi1 = "h";
	}
	function showAssoctdUPCTable(){
		document.getElementById('associatedUPC').innerHTML = tempHtml1;
		document.getElementById('aUPCImg').src = "${expnd}";
		visi1 = "v";
	}function hideElemntUPCTable(){
		tempHtml2 = document.getElementById('elementUPC').innerHTML;
		document.getElementById('elementUPC').innerHTML = "";
		document.getElementById('eUPCImg').src = "${colspd}";
		visi2 = "h";
	}
	function showElemntUPCTable(){
		document.getElementById('elementUPC').innerHTML = tempHtml2;
		document.getElementById('eUPCImg').src = "${expnd}";
		visi2 = "v";
	}
	function hideVendorTable(){
		tempHtml3 = document.getElementById('existingVendors').innerHTML;
		document.getElementById('existingVendors').innerHTML = "";
		document.getElementById('vendorImg').src = "${colspd}";
		visi3 = "h";
	}
	function showVendorTable(){
		document.getElementById('existingVendors').innerHTML = tempHtml3;
		document.getElementById('vendorImg').src = "${expnd}";
		visi3 = "v";
	}
	
	//Function for color changing in rows while clicking
	var clickedRow = null;
	var mouseOver = null;
	var mouseOut = null;
	var clickedClassName = null;
	var count = 0;
	var selectedCase;
	var vendorSelectionCaseHook = null;
	
	function makeRowClicked(bodyId,count,color){
		if(clickedRow != null){
			colorChangeRow(clickedRow, '#FFF9F4');
			document.getElementById(clickedRow).onmouseover = mouseOver;
			document.getElementById(clickedRow).onmouseout = mouseOut;
		}
		colorChangeRow(bodyId, color);
		clickedRow = bodyId;
		mouseOver = document.getElementById(clickedRow).onmouseover;
		mouseOut = document.getElementById(clickedRow).onmouseout;
		document.getElementById(clickedRow).onmouseover = '';
		document.getElementById(clickedRow).onmouseout = '';
		displayDetails(count);
		
	}
	function makeRowClickedmakeRowClickedAjax(bodyId,count, color){
			
		if(clickedRow != null){
			colorChangeRow(clickedRow, '#FFF9F4');
			document.getElementById(clickedRow).onmouseover = mouseOver;
			document.getElementById(clickedRow).onmouseout = mouseOut;
		}
		colorChangeRow(bodyId, color);
		clickedRow = bodyId;
		mouseOver = document.getElementById(clickedRow).onmouseover;
		mouseOut = document.getElementById(clickedRow).onmouseout;
		document.getElementById(clickedRow).onmouseover = '';
		document.getElementById(clickedRow).onmouseout = '';
		displayDetailsAjax(count);
	}
	
	
	
	//The function will make a row clicked in the table specified
	//and make it appear selected.
	function makeRowClickedForTable(tableName, bodyId,count, color){
		var classAppend = count % 2;
		var col;
		if(classAppend == 0){
			col = "#FEEADA";
		}else{
			col = "#FFF9F4";
		}
		var clickedRow = tableToRowClikedMap[tableName];
		var clickedColorRow = tableToRowClikedMap[tableName+'color'];
		//alert('clicked row '+clickedRow);
		if(clickedRow != null){
			try{
				colorChangeRow(clickedRow, clickedColorRow);
				document.getElementById(clickedRow).onmouseover = mouseOver;
				document.getElementById(clickedRow).onmouseout = mouseOut;
			}catch(e){
				//do nothin.. error for rolling backt the earlier one shudnt afect the flow
			}
		}
		colorChangeRow(bodyId, color);
		tableToRowClikedMap[tableName] = bodyId;
		if(document.getElementById(bodyId)){
		tableToRowClikedMap[tableName+'color'] = document.getElementById(bodyId).style.backgroundColor;
		}
		//mouseOver = document.getElementById(clickedRow).onmouseover;
		//mouseOut = document.getElementById(clickedRow).onmouseout;
		//document.getElementById(clickedRow).onmouseover = '';
		//document.getElementById(clickedRow).onmouseout = '';
		//selectedCaseRowCount = count;
		//displayDetailsAjax(count);
	
		//1205 Edit Case Edit Vendor
		//Keep the number of row which we selected
		tableToRowClikedMap[tableName+'count'] = count;
		//console.log('makeRowClickedForTable');
	}
	
	function makeRowClickedInit(bodyId,count,  color){
		if(clickedRow != null){
			colorChangeRow(clickedRow, '#FFF9F4');clickedClassName
			document.getElementById(clickedRow).onmouseover = mouseOver;
			document.getElementById(clickedRow).onmouseout = mouseOut;
		}
		colorChangeRow(bodyId, color);
		clickedRow = bodyId;
		mouseOver = document.getElementById(clickedRow).onmouseover;
		mouseOut = document.getElementById(clickedRow).onmouseout;
		document.getElementById(clickedRow).onmouseover = '';
		document.getElementById(clickedRow).onmouseout = '';
		displayDetailsInit(count);
		
	}	
	
	
	
	function initDisplayDetails(){
		if(document.getElementById('caseDesc0')){
			var id = document.getElementById('caseDesc0').value;
			makeRowClickedInit('caseRow0','0','#FFAA00');
			document.getElementById('caseDetailsLegend').innerHTML = id+" Details";
		}else{
			document.getElementById('details').style.visibility = 'visible';
		}
	}
	
	function colorChangeRow(bodyId, color){
		if(document.getElementById(bodyId)){
			var trow = document.getElementById(bodyId);
			var i=0;
			for(i=0;i< trow.cells.length;i++){
				trow.cells[i].style.backgroundColor = color;
			}
		}
	}
	
	<c:url value="/protected/cps/add/caseDetails?${_csrf.parameterName}=${_csrf.token}" var="link"></c:url>
	
	//global variables for storing the selected count of the row for normal
	// and ajax page. 
	var selectedCaseRowCount;
	var selectedCaseRowCountAjax;
	
	var addCaseDetailsData = null;
	//global variables for morph
	var vendorUniqueId;
	var caseUniquId;
	var msgSelectVendorAnother = null;
   	var canmorph = "";	
	var enableSaveCase= false;
	function editSavedCase(){
		// enable save & cancel button
		if(YAHOO.util.Dom.get("AVupc")){
			YAHOO.util.Dom.get("AVupc").style.display = 'inline';	
			YAHOO.util.Dom.get("AVupc").disabled = false;
			YAHOO.util.Event.removeListener("AVupc", "click");
			enableSaveCase = true;
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("AVupc"), "click", updateCaseDetails);
		}				
		if(YAHOO.util.Dom.get("cancelBut")){
			YAHOO.util.Dom.get("cancelBut").style.display = 'inline';
			YAHOO.util.Dom.get("cancelBut").disabled = false;
			YAHOO.util.Event.removeListener("cancelBut", "click");
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("cancelBut"), "click", onCancleClick);
		}
		disableAddEditDelBtns(true);
	}
	
	function disableEditDelBtns(isDisable){
		if(YAHOO.util.Dom.get("deleteBut")){
			YAHOO.util.Dom.get("deleteBut").disabled = isDisable;
		}
		// Disable edit case button also
		if(YAHOO.util.Dom.get("editCaseBut")){
			YAHOO.util.Dom.get("editCaseBut").disabled = isDisable;
		}
	}
	
	function disableAddEditDelBtns(isDisable){
		// disable add case and delete case
		if(YAHOO.util.Dom.get("addCaseBut")){
			YAHOO.util.Dom.get("addCaseBut").disabled = isDisable;
		}
		disableEditDelBtns(isDisable);
	}
	
	
	<c:url value="/protected/cps/add/caseDetails?${_csrf.parameterName}=${_csrf.token}" var="getCaseDetails"></c:url>
	function displayDetailsSetCount(count){			
		var formObject = document.getElementById('authAndDistForm');
		selectedCaseRowCountAjax = null;
		selectedCaseRowCount = count;
		selectedRowNumber = count;
		showProgress();	
		
		formObject.action = "${getCaseDetails}"+"&selectedCaseVOId="+document.getElementById('caseVOUniqueId'+count).value + "&showNoData=false";	
		var callback = {
			success:function(o){
				hideProgress();
				if(addCaseDetailsData == null){
					addCaseDetailsData = document.getElementById('details').innerHTML;
					document.getElementById('details').innerHTML = "";
				}
				document.getElementById('details').style.display = 'none';
				document.getElementById('selectedCaseDetails').style.display = 'block';
				document.getElementById('selectedCaseDetails').innerHTML = o.responseText;
				//alert( document.getElementById('caseUpcDiv').outerHTML);
				loadScriptsFromDiv('selectedCaseDetails');
				but = new YAHOO.widget.Button("addButton6");
				YAHOO.util.Event.removeListener("addButton6", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", addVendor);
				
				//but = new YAHOO.widget.Button("addCaseBut");
				//YAHOO.util.Event.removeListener("addCaseBut", "click");
				//YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addCaseBut"), "click", changeDisplay);
				
				but = new YAHOO.widget.Button("addCaseDetailsBut");
				YAHOO.util.Event.removeListener("addCaseDetailsBut", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addCaseDetailsBut"), "click", showVendorDetailsToAdd);
				
				but = new YAHOO.widget.Button("deleteVendorDetailsBut");
				YAHOO.util.Event.removeListener("deleteVendorDetailsBut${count}", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteVendorDetailsBut${count}"), "click", deleteVendorDetails);
				
				but = new YAHOO.widget.Button("backButton");
				YAHOO.util.Event.removeListener("backButton", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd);
				YAHOO.util.Event.removeListener("codeDate", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("codeDate"), "click", checkedCodeDate);
				vendorSelectionCaseHook = function(){
					try{
						document.getElementById('caseDescriptionText').focus();
					}catch(e){}
					selectChannelAjax(); 
				};
				
				YAHOO.util.Event.removeListener("authStore", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
				Calendar.setup({inputField:"whseFlushDate",ifFormat:"%m/%d/%Y",button:"flushDate",align:"T1",singleClick:true});
				// Fix #426
				Calendar.setup({inputField:"instoreDate",ifFormat:"%m/%d/%Y",button:"storeDate",align:"T1",singleClick:true});
                Calendar.setup({inputField:"prorDate",ifFormat:"%m/%d/%Y",button:"propDate",align:"T1",singleClick:true});
				Calendar.setup({inputField:"freight",ifFormat:"%m/%d/%Y",button:"freights",align:"T1",singleClick:true});
				Calendar.setup({inputField:"duty",ifFormat:"%m/%d/%Y",button:"dutyCalend",align:"T1",singleClick:true});

//Why done listener thrice???				
//				YAHOO.util.Event.removeListener("authStore", "click");
//				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
//				Calendar.setup({inputField:"instoreDate",ifFormat:"%m/%d/%Y",button:"storeDate",align:"T1",singleClick:true});
				
//				YAHOO.util.Event.removeListener("authStore", "click");
//				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
//				Calendar.setup({inputField:"prorDate",ifFormat:"%m/%d/%Y",button:"propDate",align:"T1",singleClick:true});
				
				initVendorClick();
				disableAddEditDelBtns(false);	
				
				// Fire DWR call to know if the case is already added
				AddCandidateTemp.isExistingProductAndCase( document.getElementById('caseVOUniqueId'+count).value,  getDWRCallbackMethod(disableEditDelBtns));			
			},
			failure:function(o){
				selectChannelAjax();
				hideProgress();
			}
		};	
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
		
	}
	
	function displayDetails(count){		
		var formObject = document.getElementById('authAndDistForm');
		//showProgress();
		selectedCaseRowCountAjax = null;
		selectedCaseRowCount = count;
		formObject.action = "${link}"+"&selectedCaseVOId="+document.getElementById('caseVOUniqueId'+count).value;
		
		var callback = {
			success:function(o){
				hideProgress();
				if(addCaseDetailsData == null){
					addCaseDetailsData = document.getElementById('details').innerHTML;
					document.getElementById('details').innerHTML = "";
				}
				document.getElementById('details').style.display = 'none';
				document.getElementById('selectedCaseDetails').style.display = 'block';
				document.getElementById('selectedCaseDetails').innerHTML = o.responseText;
				//loadScriptsFromDiv('selectedCaseDetails');
				if(document.getElementById('AVupc')){
					but = new YAHOO.widget.Button("AVupc");
					YAHOO.util.Event.removeListener("AVupc", "click");
					YAHOO.util.Event.addListener(YAHOO.util.Dom.get("AVupc"), "click", updateCaseDetails);
				}
				if(document.getElementById('cancelBut')){
					but = new YAHOO.widget.Button("cancelBut");
					YAHOO.util.Event.removeListener("cancelBut", "click");
					YAHOO.util.Event.addListener(YAHOO.util.Dom.get("cancelBut"), "click", onCancleClick);
				}
				but = new YAHOO.widget.Button("addButton6");
				YAHOO.util.Event.removeListener("addButton6", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", addVendor);
				
				but = new YAHOO.widget.Button("addCaseBut");
				YAHOO.util.Event.removeListener("addCaseBut", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addCaseBut"), "click", changeDisplay);
				
				but = new YAHOO.widget.Button("addCaseDetailsBut");
				YAHOO.util.Event.removeListener("addCaseDetailsBut", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addCaseDetailsBut"), "click", showVendorDetailsToAdd);
				
				but = new YAHOO.widget.Button("deleteVendorDetailsBut");
				YAHOO.util.Event.removeListener("deleteVendorDetailsBut${count}", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteVendorDetailsBut${count}"), "click", deleteVendorDetails);
				
				but = new YAHOO.widget.Button("backButton");
				YAHOO.util.Event.removeListener("backButton", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd);
				YAHOO.util.Event.removeListener("codeDate", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("codeDate"), "click", checkedCodeDate);
				vendorSelectionCaseHook = function(){
					try{
						document.getElementById('caseDescriptionText').focus();
					}catch(e){}
					selectChannelAjax(); 
				};
				
				
				YAHOO.util.Event.removeListener("authStore", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
				Calendar.setup({inputField:"whseFlushDate",ifFormat:"%m/%d/%Y",button:"flushDate",align:"T1",singleClick:true});

// Why done thrice???
//				YAHOO.util.Event.removeListener("authStore", "click");
//				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
				Calendar.setup({inputField:"instoreDate",ifFormat:"%m/%d/%Y",button:"storeDate",align:"T1",singleClick:true});
				
//				YAHOO.util.Event.removeListener("authStore", "click");
//				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
				Calendar.setup({inputField:"prorDate",ifFormat:"%m/%d/%Y",button:"propDate",align:"T1",singleClick:true});
				Calendar.setup({inputField:"freight",ifFormat:"%m/%d/%Y",button:"freights",align:"T1",singleClick:true});
				Calendar.setup({inputField:"duty",ifFormat:"%m/%d/%Y",button:"dutyCalend",align:"T1",singleClick:true});
				but = new YAHOO.widget.Button("importFacilities");
				YAHOO.util.Event.removeListener("importFacilities", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("importFacilities"), "click", importFacilities);
				
				initVendorClick();
			},
			failure:function(o){
				selectChannelAjax();
				hideProgress();
			}
		};	
		//var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
	}
	
	
	function initVendorClick(){
		if(document.getElementById('vendorRow0')){
			document.getElementById('vendorRow0').click();
		}else{
				
			if(vendorSelectionCaseHook != null){
				clearCostLinkFields();
			    if(YAHOO.util.Dom.get('costlist'))
			    {
			     document.getElementById('costlist').value = ''; 
			    }
			    if(YAHOO.util.Dom.get('listCost'))
			    {
			    	document.getElementById('listCost').disabled=false;
				    initKitCostOfKitComponents();
				}
				
				vendorSelectionCaseHook();
				vendorSelectionCaseHook = null;
			}
		}
	}
		
	
	function displayDetailsForAjaxRowsNP(){	
		//showNoData = false;
		if(selectedRowNumber > -1){
			count = selectedRowNumber;
		}else {
			count = 0;
		}

		selectedCaseRowCount = null;
		selectedCaseRowCountAjax = count;
		showProgress();		
		var formObject = document.getElementById('authAndDistForm');
		var uniqueID = "";
		if(document.getElementById('caseVOUniqueIdAjax'+count)){
			uniqueID = document.getElementById('caseVOUniqueIdAjax'+count).value;
		}else {
			uniqueID = document.getElementById('caseVOUniqueId'+count).value;
		}			
		formObject.action = "${link}"+"&selectedCaseVOId="+uniqueID + "&showNoData=false";
		var callback = {
			success:function(o){
				hideProgress();
				if(addCaseDetailsData == null){
					addCaseDetailsData = document.getElementById('details').innerHTML;
					document.getElementById('details').innerHTML = "";
				}
				document.getElementById('details').style.display = 'none';
				document.getElementById('selectedCaseDetails').style.display = 'block';
				document.getElementById('selectedCaseDetails').innerHTML = o.responseText;
				//alert( document.getElementById('caseUpcDiv').outerHTML);
				loadScriptsFromDiv('selectedCaseDetails');
				
				but = new YAHOO.widget.Button("addButton6");
				YAHOO.util.Event.removeListener("addButton6", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", addVendor);
				but = new YAHOO.widget.Button("addCaseDetailsBut");
				YAHOO.util.Event.removeListener("addCaseDetailsBut", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addCaseDetailsBut"), "click", showVendorDetailsToAdd);
				but = new YAHOO.widget.Button("deleteVendorDetailsBut${count}");
				YAHOO.util.Event.removeListener("deleteVendorDetailsBut", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteVendorDetailsBut${count}"), "click", deleteVendorDetails);
				but = new YAHOO.widget.Button("backButton");
				YAHOO.util.Event.removeListener("backButton", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd); 
				YAHOO.util.Event.removeListener("codeDate", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("codeDate"), "click", checkedCodeDate);
				Calendar.setup({inputField:"whseFlushDate",ifFormat:"%m/%d/%Y",button:"flushDate",align:"T1",singleClick:true});
				Calendar.setup({inputField:"instoreDate",ifFormat:"%m/%d/%Y",button:"storeDate",align:"T1",singleClick:true});
                Calendar.setup({inputField:"prorDate",ifFormat:"%m/%d/%Y",button:"propDate",align:"T1",singleClick:true});
				Calendar.setup({inputField:"freight",ifFormat:"%m/%d/%Y",button:"freights",align:"T1",singleClick:true});
				Calendar.setup({inputField:"duty",ifFormat:"%m/%d/%Y",button:"dutyCalend",align:"T1",singleClick:true});
				vendorSelectionCaseHook = function(){ 
					try{
						document.getElementById('caseDescriptionText').focus();
					}catch(e){}
					selectChannelAjax(); 
				};
				initVendorClick();
				
				editSavedCase();
				//1205 Edit Case Edit Vendor
				disabledCaseFields(false);
				<c:if test="${CPSForm.questionnarieVO.selectedOption == 4}">
					disabledDRUField(true);
				</c:if>
				<c:if test="${CPSForm.questionnarieVO.selectedOption != 4}">
					disabledDRUField(false);
				</c:if>
				disabledCaseUPC(false);	
				disabledCaseForMorph();						
				//Sprint - 23
				<c:if test="${CPSForm.productVO.workRequest.intentIdentifier eq '12' || CPSForm.productVO.activeProductKit}">
					if(YAHOO.util.Dom.get('shipPackText')){		
						document.getElementById('shipPackText').disabled = true;
					}
					if(YAHOO.util.Dom.get('masterPackText')){		
						document.getElementById('masterPackText').disabled = true;
					}
				</c:if>
			},
			failure:function(o){
				selectChannelAjax();
				hideProgress();
			}							
			
		};
		//showProgress();
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
	}
	
	function displayDetailsForAjaxRows(count,stopProgress){
		selectedCaseRowCount = null;
		selectedCaseRowCountAjax = count;
		selectedRowNumber = count;
		showProgress();		
		var formObject = document.getElementById('authAndDistForm');
		formObject.action = "${link}"+"&selectedCaseVOId="+document.getElementById('caseVOUniqueIdAjax'+count).value +"&showNoData=false";
		var callback = {
			success:function(o){
				if(caseHook == null && (stopProgress==true || stopProgress==undefined)){
					hideProgress();
					//console.log('hide in displayDetailsForAjaxRows');
				}
				if(addCaseDetailsData == null){
					addCaseDetailsData = document.getElementById('details').innerHTML;
					document.getElementById('details').innerHTML = "";
				}
				document.getElementById('details').style.display = 'none';
				document.getElementById('selectedCaseDetails').style.display = 'block';
				document.getElementById('selectedCaseDetails').innerHTML = o.responseText;
				loadScriptsFromDiv('selectedCaseDetails');
				if(document.getElementById('AVupc')){
					but = new YAHOO.widget.Button("AVupc");
					YAHOO.util.Event.removeListener("AVupc", "click");
					YAHOO.util.Event.addListener(YAHOO.util.Dom.get("AVupc"), "click", updateCaseDetails);
				}
				but = new YAHOO.widget.Button("addButton6");
				YAHOO.util.Event.removeListener("addButton6", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", addVendor);
				but = new YAHOO.widget.Button("addCaseDetailsBut");
				YAHOO.util.Event.removeListener("addCaseDetailsBut", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addCaseDetailsBut"), "click", showVendorDetailsToAdd);
				but = new YAHOO.widget.Button("deleteVendorDetailsBut${count}");
				YAHOO.util.Event.removeListener("deleteVendorDetailsBut", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteVendorDetailsBut${count}"), "click", deleteVendorDetails);
				but = new YAHOO.widget.Button("editVendorDetailsBut${count}");
				YAHOO.util.Event.removeListener("editVendorDetailsBut", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("editVendorDetailsBut${count}"), "click", editVendorDetails);
				but = new YAHOO.widget.Button("backButton");
				YAHOO.util.Event.removeListener("backButton", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd); 
				YAHOO.util.Event.removeListener("codeDate", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("codeDate"), "click", checkedCodeDate);
				Calendar.setup({inputField:"whseFlushDate",ifFormat:"%m/%d/%Y",button:"flushDate",align:"T1",singleClick:true});
				Calendar.setup({inputField:"instoreDate",ifFormat:"%m/%d/%Y",button:"storeDate",align:"T1",singleClick:true});
                Calendar.setup({inputField:"prorDate",ifFormat:"%m/%d/%Y",button:"propDate",align:"T1",singleClick:true});
				Calendar.setup({inputField:"freight",ifFormat:"%m/%d/%Y",button:"freights",align:"T1",singleClick:true});
				Calendar.setup({inputField:"duty",ifFormat:"%m/%d/%Y",button:"dutyCalend",align:"T1",singleClick:true});
				vendorSelectionCaseHook = function(){ 
						try{
							document.getElementById('caseDescriptionText').focus();
						}catch(e){}
						selectChannelAjax(); 
				};
				initVendorClick();
				disableAddEditDelBtns(false);	
			},
			failure:function(o){
				selectChannelAjax();
				hideProgress();
			}
			
			
			
		};
	
		//showProgress();
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
	}
	
	function deleteSelectedCase(evt){	
		if(confirm('You really want to delete this case?')){
			var caseUniqueId = getSelectedCaseID();
			if(null != caseUniqueId){
				showProgress();
				AddCandidateTemp.removeCaseVO( caseUniqueId,  getDWRCallbackMethod(deleteRowFromCaseTable));
			}
		}
		
	}
	
	function deleteSelectedCase1(evt,ary){		
		if(confirm('You really want to delete this case?')){
			var count = arr[0];
			var uniqId = arr[1];
			showProgress();
			AddCandidateTemp.removeCaseVO( uniqId,  getDWRCallbackMethod(deleteRowFromCaseTable1(data, count)));
		}
	}
	function deleteRowFromCaseTable1(data,count){
		//hideProgress();
		var rowId = count;
		var tBody = document.getElementById('caseItemTbody');
		for(var i=0;i < tBody.rows.length;i++){
			if( tBody.rows[i].id == rowId){
				tBody.deleteRow(i);
				colorTableRows('caseItemTbody');
				break;
			}
		}
		
		if(data != null){
			if(data.rmCaseChild != null && data.rmCaseChild != ""){
				deleteCaseItemeDCFromTbl(data);
			}
		}
		
		if( document.getElementById('addCaseBut') ){
			document.getElementById('addCaseBut').click();
		}
		//isSavingCase=false;
		AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligible));
	}
	
	
	function resetScreenOnDeleteCase(){
		document.getElementById('selectedCaseDetails').innerHTML = "";
		document.getElementById('selectedCaseDetails').style.display="none";
		document.getElementById('details').style.display="block";
		if(addCaseDetailsData != null){
			document.getElementById('details').innerHTML = addCaseDetailsData;
			addCaseDetailsData = null;
		}
		clearCaseItemDetails();
		if(document.getElementById('vendorDetailsDiv').style.display == "block"){
			loadScriptsFromDiv('vendorDetailsDiv');
			clearVendorDetails();
		}
		document.getElementById('actions3').selectedIndex = 0;
		selectChannel();		
		YAHOO.util.Event.removeListener("backButton", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd);  
		//but = new YAHOO.widget.Button("AVupc");
		//YAHOO.util.Event.removeListener("AVupc", "click");
		//YAHOO.util.Event.addListener(YAHOO.util.Dom.get("AVupc"), "click", addCaseDetailsToTable);
		but = new YAHOO.widget.Button("addCaseBut");
		YAHOO.util.Event.removeListener("addCaseBut", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addCaseBut"), "click", changeDisplay);
		YAHOO.util.Event.removeListener("codeDate", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("codeDate"), "click", checkedCodeDate);
		but = new YAHOO.widget.Button("addButton6");
		YAHOO.util.Event.removeListener("addButton6", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", saveCaseAndVendor);
		
		document.getElementById('caseDetailsLegend').innerHTML = "Add New Case Details";
		makeAppUPCLinked(null);
			
		if(	document.getElementById("addCaseBut")){
			document.getElementById('addCaseBut').disabled = false;
		}	
		var tBody = document.getElementById('caseItemTbody');
		var disableWhenNoRow = false;
		var hideWhenNoRow = 'inline';
		if(tBody.rows.length == 0){
			disableWhenNoRow = true;
			hideWhenNoRow = 'none';
		}
		
		//YAHOO.util.Dom.get("AVupc").style.display = hideWhenNoRow;	
		if(YAHOO.util.Dom.get("AVupc")){
		YAHOO.util.Dom.get("AVupc").disabled = false;
		}
			
		
		//YAHOO.util.Dom.get("cancelBut").style.display = hideWhenNoRow;
		if(YAHOO.util.Dom.get("cancelBut")){
		YAHOO.util.Dom.get("cancelBut").disabled = false;
		}
		
		if(document.getElementById('editCaseBut')){
			document.getElementById('editCaseBut').disabled = disableWhenNoRow;	
			document.getElementById('editCaseBut').style.display = hideWhenNoRow;
			
		}
		
		if(document.getElementById('deleteBut')){
			document.getElementById('deleteBut').disabled = disableWhenNoRow;
			document.getElementById('deleteBut').style.display = hideWhenNoRow;			
		}
		
		try{
			document.getElementById('caseDescriptionText').focus();
		}catch(e){}
	}
	
	function deleteRowFromCaseTable(data){
		//hideProgress();
		var rowId = getSelectedCaseRowID();
		var tBody = document.getElementById('caseItemTbody');
		for(var i=0;i < tBody.rows.length;i++){
			if( tBody.rows[i].id == rowId){
				tBody.deleteRow(i);
				colorTableRows('caseItemTbody');
				break;
			}
		}
		resetScreenOnDeleteCase();
		if(data != null ){
			if(data.rmCaseChild != null && data.rmCaseChild != ""){
				deleteCaseItemeDCFromTbl(data);
			}
			
		}
		// Just select the first row.if there is any row else disable the add case button.
		if(document.getElementById('caseItemTbody').rows.length > 0){
			document.getElementById('caseItemTbody').rows[0].onclick();

			if(document.getElementById('addCaseBut')) {
				document.getElementById('addCaseBut').disabled = false;
			}	
			
			if(document.getElementById('editCaseBut')){
				document.getElementById('editCaseBut').disabled = false;	
			}
			
			if(document.getElementById('deleteBut')){
				document.getElementById('deleteBut').disabled = false;			
			}
		
		}else{
			if(document.getElementById('addCaseBut')) {
				document.getElementById('addCaseBut').disabled = true;
			}	
		
			if(document.getElementById('editCaseBut')){
				document.getElementById('editCaseBut').disabled = true;	
			}
			
			if(document.getElementById('deleteBut')){
				document.getElementById('deleteBut').disabled = true;			
			}
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("AVupc"), "click", addCaseDetailsToTable);
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("cancelBut"), "click", clearCaseItemDetails);
			AddCandidateTemp.getProductDescription(getDWRCallbackMethod(setCaseDescription));
		}
		
		//enableActivation();
		AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligible));
	}
	
	function setCaseDescription(data){
		document.getElementById('caseDescriptionText').value = data;
	}
	
	function displayDetailsAjax(count){
		//var id = document.getElementById('caseDescAjax'+count).value;
		//document.getElementById('caseDetailsLegend').innerHTML = id+" Details";
		swapUPCs(count);
	}
	
	function displayDetailsInit(count){
		var id = document.getElementById('caseDesc'+count).value;
		document.getElementById('caseDetailsLegend').innerHTML = id+" Details";
	}
	
	
	//Stores popups
	function storeAuthorization(){
		var sel = document.getElementById('availableOption');
		//if(sel.options[sel.selectedIndex].value == '14'){
		 //f1("${page3}"+'&t='+new Date().getTime()+'&vendorFlag=false',"Vendors",'50%','62%','100px','100px');
			//window.showModalDialog("${page3}"+'&t='+new Date().getTime(),window,"dialogHeight:600px;dialogWidth:700px");
			//sel.selectedIndex = 0; 
		//}
		if(sel.options[sel.selectedIndex].value == '15'){
			f1("${page4}"+'&t='+new Date().getTime(),"View Stores",'450px','62%','130px','200px');
			//window.showModalDialog("${page4}"+'&t='+new Date().getTime(),window,"dialogHeight:600px;dialogWidth:700px");
			sel.selectedIndex = 0; 
		}
		if(sel.options[sel.selectedIndex].value == '16'){
			f1("${page5}"+'&t='+new Date().getTime(),"WHS",'200px','62%','130px','200px');
			//window.showModalDialog("${page3}"+'&t='+new Date().getTime(),window,"dialogHeight:600px;dialogWidth:700px");
			sel.selectedIndex = 0; 
		}
	}	
	
	function updateCaseDetails(evt,isSaveCaseAndVendor){
		if(checkCaseDesValue() || checkCaseUPC()) return;
	   if(checkDRU()) return;
		if(validCodeDate() && validateMasterShipPacks()){
			var caseVO = getCurrentCaseObject();
			var uniqueId = document.getElementById('selectedCaseUniqueId').value;
			
			var caseText = YAHOO.util.Dom.get("caseUpcText");
			var caseCheck = YAHOO.util.Dom.get("caseCheckDigit");	
			var caseTextValue = caseText.value;
		    var caseCheckValue = caseCheck.value;
		    var sel = document.getElementById('actions3');
			if(isSaveCaseAndVendor==true) {
				enableSaveCase = false;
			} else {
				 enableSaveCase = true;
			}
		    if(caseCheckValue!="" && null != caseCheckValue) {
			     showProgress();
			    // isSavingCase=false;
				//console.log('updateCaseDetails');
			     AddCandidateTemp.verifyCheckDigit(caseTextValue,caseCheckValue,getDWRCallbackMethod(function(data){
			     	onCheckDigitSuccess(data, uniqueId,caseVO);
			     }));
		    }
		    else if(caseTextValue != null && caseTextValue != "" && (caseCheckValue == null || caseCheckValue == "") && (sel.options[sel.selectedIndex].value != 'DSD') ){
				alert('Please enter the Check Digit');
			}else{
				 showProgress();
				onCheckDigitSuccess(true,uniqueId,caseVO);
			}
		}
	}
	//Fix QC -1508
	function updateCaseActivated(evt){
		showProgress();
		var caseVO = getCurrentCaseObject();
		var uniqueId = document.getElementById('selectedCaseUniqueId').value;			
		var caseText = YAHOO.util.Dom.get("caseUpcText");
		var caseCheck = YAHOO.util.Dom.get("caseCheckDigit");	
		var caseTextValue = caseText.value;
		var caseCheckValue = caseCheck.value;
		AddCandidateTemp.verifyCheckDigit(caseTextValue,caseCheckValue,getDWRCallbackMethod(function(data){
			AddCandidateTemp.saveCaseVO(uniqueId, caseVO,getDWRCallbackMethod(updateSelectedCaseActivated));
		}));		
	}
	//Fix QC -1508
	function updateSelectedCaseActivated(data){
		var seletedRowId;
		var fifthRowData;
		var isAjax = false;
		var cntTmp;	
		//hideProgress();	
		if(document.getElementById('masterPackText')){
			var masterPackText = document.getElementById('masterPackText');
			//HoangVT - in case: this text field is empty -> when use parseInt -> return: NaN
			if(parseInt(masterPackText.value,10) > 0)
				masterPackText.value = parseInt(masterPackText.value,10);
			else
				masterPackText.value = "";
		}
		//Fix 1124. after editing a case and then delete, the row in the table is not deleted
		if(selectedCaseRowCount){		
			seletedRowId = "caseRow"+selectedCaseRowCount;
			cntTmp = selectedCaseRowCount;
			isAjax = false;
			if(!document.getElementById(seletedRowId)){
				seletedRowId = "ajaxCase"+selectedCaseRowCount;
				selectedCaseRowCountAjax = selectedCaseRowCount;
				selectedCaseRowCount = null;	
				isAjax = true;			
			}
			fifthRowData = changeTo(data.caseDescription);
			
		}else if(selectedCaseRowCountAjax){		
			seletedRowId = "ajaxCase"+selectedCaseRowCountAjax;
			isAjax = true;
			cntTmp = selectedCaseRowCountAjax;	
			if(!document.getElementById(seletedRowId)){				
				seletedRowId = "caseRow"+selectedCaseRowCountAjax;
				selectedCaseRowCount = selectedCaseRowCountAjax;
				selectedCaseRowCountAjax = null;	
				isAjax = false;	
			}					
			fifthRowData =  changeTo(data.caseDescription) + '<input type="hidden" id="caseDescAjax'+selectedCaseRowCountAjax+'" value="'+ changeTo(data.caseDescription)+'"/>	 ';	
		}
		var	active = "";		
		//Fix QC 1483
		if(isNaN(data.itemId)) {
			active="Active";//getPurchaseStatus(data.purchaseStatus);	
		}		
		var hiddenPsItmId = '<input type="hidden" id="casePsItemId'+cntTmp+'" value="'+data.psItemId+'"/>';
		var selRow = document.getElementById(seletedRowId);				
		var rowData = [		
			data.vpc, 
			data.formattedCaseUPC,		
				 
			data.itemId,
			fifthRowData, 
			'', 
			data.channel, 
			data.masterPack, 
			data.shipPack, 
			data.listCost,
			active,
			'',
			hiddenPsItmId
			];			
		for(var i=0;i < selRow.cells.length;i++){
			var tCell = selRow.cells[i];
			if(rowData[i]){
				tCell.innerHTML = rowData[i];
			}
		}		
		
		if(YAHOO.util.Dom.get("AVupc")){
			YAHOO.util.Dom.get("AVupc").disabled = false;
		}		
		if(YAHOO.util.Dom.get("cancelBut")){
			YAHOO.util.Dom.get("cancelBut").disabled = true;
		}
		if(YAHOO.util.Dom.get("EditCaseBut")){
			YAHOO.util.Dom.get("EditCaseBut").disabled = true;
		}
		if(YAHOO.util.Dom.get("addCaseBut")){	
			YAHOO.util.Dom.get("addCaseBut").disabled = false;
		}
		if(YAHOO.util.Dom.get("deleteBut")){	
			YAHOO.util.Dom.get("deleteBut").disabled = true;
		}
		//1205 Edit Case Edit Vendor
		//Disabled any Case fields after save Case
		disabledCaseFields(true);
		disabledDRUField(true);
		disabledCaseUPC(true);
		//Change Order Unit when user saved WHS case successful (Add new Case)
		if(YAHOO.util.Dom.get("vendorLocation")) {
			if(YAHOO.util.Dom.get("vendorLocation").value=="") {
				changeOrderUnitDefault();	
			}
		}	
		//isSavingCase=false;
		AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligible));	
	}
	var isSavingCase=false;
	function onCheckDigitSuccess(data,uniqueId,caseVO){
		  if(!data) {
				hideProgress();
				alert('InValid Check Digit. Please Re-enter the UPC/Checkdigit Value');
				document.getElementById('caseCheckDigit').value = '';
		         document.getElementById('caseUpcText').focus();
				document.getElementById('caseUpcText').select();
		  }else{
			  showProgress();
			  //AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligibleWithoutProcessBar));
			  //console.log('onCheckDigitSuccess');
			  AddCandidateTemp.saveCaseVO(uniqueId, caseVO,getDWRCallbackMethod(function(data){
				  updateSelectedRow(data);
			}));	
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
	function changeOrderUnitDefault() {
		for(i=0;i<document.all('orderUnit').length;i++)
		{
			if(document.all('orderUnit').options[i].value=="C")
			{
				document.all('orderUnit').selectedIndex=i;
				break;
			}
		}	
	}
	function updateSelectedRow(data){
		var seletedRowId;
		var fifthRowData;
		var isAjax = false;
		var cntTmp;	
<!-- 		hideProgress();	 -->
		//Change Order Unit when user saved WHS case successful (Add new Case)
		if(YAHOO.util.Dom.get("vendorLocation")) {
			if(YAHOO.util.Dom.get("vendorLocation").value=="") {
				changeOrderUnitDefault();	
			}
		}	
		if(document.getElementById('masterPackText')){
			var masterPackText = document.getElementById('masterPackText');
			//HoangVT - in case: this text field is empty -> when use parseInt -> return: NaN
			if(parseInt(masterPackText.value,10) > 0)
				masterPackText.value = parseInt(masterPackText.value,10);
			else
				masterPackText.value = "";
		}
		//Fix 1124. after editing a case and then delete, the row in the table is not deleted
		if(selectedCaseRowCount){		
			seletedRowId = "caseRow"+selectedCaseRowCount;
			cntTmp = selectedCaseRowCount;
			isAjax = false;
			if(!document.getElementById(seletedRowId)){
				seletedRowId = "ajaxCase"+selectedCaseRowCount;
				selectedCaseRowCountAjax = selectedCaseRowCount;
				selectedCaseRowCount = null;	
				isAjax = true;			
			}
			fifthRowData = changeTo(data.caseDescription);
			
		}else if(selectedCaseRowCountAjax){		
			seletedRowId = "ajaxCase"+selectedCaseRowCountAjax;
			isAjax = true;
			cntTmp = selectedCaseRowCountAjax;	
			if(!document.getElementById(seletedRowId)){				
				seletedRowId = "caseRow"+selectedCaseRowCountAjax;
				selectedCaseRowCount = selectedCaseRowCountAjax;
				selectedCaseRowCountAjax = null;	
				isAjax = false;	
			}					
			fifthRowData =  changeTo(data.caseDescription) + '<input type="hidden" id="caseDescAjax'+selectedCaseRowCountAjax+'" value="'+ changeTo(data.caseDescription)+'"/>	 ';	
		}
		var	active = "";		
		//Fix QC 1483
		if(isNaN(data.itemId)) {
			active="Active";//getPurchaseStatus(data.purchaseStatus);	
		}		
		var checkMRT = '';
		if(data.mrt != null
			&& data.mrt == 'Y'){
			checkMRT = '<input type="checkbox" checked="checked"  disabled="disabled"/><input type="hidden" value="'+data.uniqueId+'" id="caseVOUniqueIdAjax'+cntTmp+'"/>';
		}else{
			checkMRT = '<input type="checkbox" disabled="disabled"/><input type="hidden" value="'+data.uniqueId+'" id="caseVOUniqueIdAjax'+cntTmp+'"/>';
		}	
		var selRow = document.getElementById(seletedRowId);			
		var hiddenPsItmId = '<input type="hidden" id="casePsItemId'+cntTmp+'" value="'+data.psItemId+'"/>';	
		var rowData = [		
			data.vpc, 
			data.formattedCaseUPC,
			 
			'',//data.itemId, 
			fifthRowData, 
			checkMRT, 
			data.channel, 
			data.masterPack, 
			data.shipPack, 
			data.listCost,
			active,
			'',
			hiddenPsItmId
			];			
		for(var i=0;i < selRow.cells.length;i++){
			var tCell = selRow.cells[i];
			if(rowData[i]){
				tCell.innerHTML = rowData[i];
			}
		}
		//DISABLE SAVE & CANCEL Button and ENABLE three buttons
		if(YAHOO.util.Dom.get("AVupc")){
			YAHOO.util.Dom.get("AVupc").disabled = true;
		}		
		if(YAHOO.util.Dom.get("cancelBut")){
			YAHOO.util.Dom.get("cancelBut").disabled = true;
		}
		if(YAHOO.util.Dom.get("EditCaseBut")){
			YAHOO.util.Dom.get("EditCaseBut").disabled = false;
		}
		if(YAHOO.util.Dom.get("addCaseBut")){	
			YAHOO.util.Dom.get("addCaseBut").disabled = false;
		}
		if(YAHOO.util.Dom.get("deleteBut")){	
			YAHOO.util.Dom.get("deleteBut").disabled = false;
		}
		//for saving vendor after saving case 
   		if(caseHook != null){
   		//DISABLE [Edit Selected Case] and [Delete Selected Case] Button
   		if(YAHOO.util.Dom.get("editCaseBut")){
			YAHOO.util.Dom.get("editCaseBut").disabled = true;
		}
		if(YAHOO.util.Dom.get("deleteBut")){	
			YAHOO.util.Dom.get("deleteBut").disabled = true;
		}
   			addedCaseRowCount = cntTmp;
   			addedCaseRowIsAjax = isAjax;
   			var tmp = caseHook;
   			caseHook = null;
   			tmp();
   		}
		//1205 Edit Case Edit Vendor
		//Disabled any Case fields after save Case
		disabledCaseFields(true);
		disabledDRUField(true);
		disabledCaseUPC(true);
		//enableActivation();
		//AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligible));
		if(enableSaveCase) {
			//console.log('hide in updateSelectedRow');
		   hideProgress();
	    }
		var unitCostLabel = document.getElementById("unitCostLabel");
		var listCost = document.getElementById("listCost");
		var profitWarning = document.getElementById("profitWarning");
		var marginWarningIdAjax = document.getElementById("marginWarningIdAjax");
		if(unitCostLabel!=null && listCost!=null) {
			if(listCost.value!="" && unitCostLabel.innerText=="") {
				if(profitWarning!=null) {
					profitWarning.style.display = "block";
				}
				if(marginWarningIdAjax!=null) {
					marginWarningIdAjax.value="% Margin and Penny Profit are blank. Please enter Ship Pack / Master Pack value.";
				}
				calculateUnitCost();
			} else {
				if(profitWarning!=null) {
				   profitWarning.style.display = "none";
				}
			}
		} else {
			calculateUnitCost();
		}
	}
	function getPurchaseStatus(status) {
		var value="";
		if(status=="A") {
			value= "Active";
		} else if(status=="D") {
			value=  "Discontinued";
		} else if(status=="N") {
			value=  "New-Item";
		} else if(status=="S") {
			value=  "Suspended";
		} else if(status=="T") {
			value=  "Temp-OOS";
		} else if(status=="X") {
			value=  "No-Order";
		} 
		return value;
	}
	function changeTo(str){
		if(null != str){
			return str.replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;"); 
		}else {
			return str;
		}
	}
	
	
	var caseHook = null;
	var addedCaseRowCount;
	var addedCaseRowIsAjax = false;
	
	function addCaseDetailsToTable(evt,stopProgress){
		if(document.getElementById('actions3')){
			var channelSelectBox = document.getElementById('actions3');
			var selValue = channelSelectBox.options[channelSelectBox.selectedIndex].value;
			if(selValue == ''  || selValue == '-1'){
				alert('Please select a channel to save the case');
				return;
			}
		}
		if(checkCaseDesValue()) {
			return;
		}
		if(checkCaseUPC()) {
			return;
		} 
		if(checkDRU()) return;
		if(validCodeDate() && validateMasterShipPacks()){
			
			showProgress();
			var caseVO = getCurrentCaseObject();
                        AddCandidateTemp.addCaseVO(caseVO,getDWRCallbackMethod(function(data){
				  addRowToCaseItemDetails(data,stopProgress);
			}));
			
			//AddCandidateTemp.addCaseVO(caseVO,getDWRCallbackMethod(addRowToCaseItemDetails));
		}
	} 
	
	function enableRadioBut(clickedCount,itemId){
		if(document.getElementById('upcCaseCheck'+clickedCount).checked && (itemId==null || itemId=='')){
			document.getElementById('caseUPCRadio'+clickedCount).disabled = false;
		}else{
			document.getElementById('caseUPCRadio'+clickedCount).checked = false;
			document.getElementById('caseUPCRadio'+clickedCount).disabled = true;
		}
	}
	
	function getLinkedUPCUniqueIds(){
		var i=0;
		var linkedUPCs = "";
		while(true){
			var ob = document.getElementById('upcCaseCheck'+i);
			if(ob){
				if(ob.checked){
					linkedUPCs = linkedUPCs + document.getElementById('caseUPCId'+i).value + ",";
				}
			}else{
				break;
			}
			i++;
		}
		return linkedUPCs;
	}
	
	function getPrimaryUPC(){
		var i=0;
		var linkedUPCs = "";
		while(true){
			var ob = document.getElementById('caseUPCRadio'+i);
			if(ob){
				if(ob.checked){
					linkedUPCs = document.getElementById('caseUPCId'+i).value;
					break;
				}
			}else{
				break;
			}
			i++;
		}
		return linkedUPCs;
	}
	
	function getValue(obj){
		if(obj){
			return obj.value;
		}else{
			return null;
		}
	}
	
	
	function getCurrentCaseObject(){
		//var vpc = document.getElementById('vpc'));
		var caseUPC = getValue(document.getElementById('caseUpcText'));
		var caseCheck = getValue(document.getElementById('caseCheckDigit'));
		var itemCode = getValue(document.getElementById('unitFactor'));
		var caseDesc = getValue(document.getElementById('caseDescriptionText'));
		var mrt = '';
		var channel = document.getElementById('actions3');
		var channelVal = channel.options[channel.selectedIndex].text;
		var channelVal1 = getValue(channel.options[channel.selectedIndex]);
		
		var masterPack = getValue(document.getElementById('masterPackText'));
		var masterLength = getValue(document.getElementById('masterLength'));
		var masterHeight = getValue(document.getElementById('masterHeight'));
		var masterWeight = getValue(document.getElementById('masterWeight'));
		var masterWidth = getValue(document.getElementById('masterWidth'));
		var masterCube = document.getElementById('masterCubeLabel').innerText;
		
		
		var shipPack = getValue(document.getElementById('shipPackText'));
		var shipLength = getValue(document.getElementById('shipLength'));
		var shipWeight = getValue(document.getElementById('shipWeight'));
		var shipHeight = getValue(document.getElementById('shipHeight'));
		var shipWidth = getValue(document.getElementById('shipWidth'));
		var shipCube = document.getElementById('shipCubeLabel').innerText;
		
		var unitFactor = getValue(document.getElementById('unitFactor'));
		var maxShelfLifeDays = getValue(document.getElementById('shelfDays'));
		var inboudSpecificationDays = getValue(document.getElementById('inboundDays'));
		var reactionDays = getValue(document.getElementById('reactionDays'));
		var guaranteeToStoreDays = getValue(document.getElementById('guaranteestoreDays'));
		var oneTouchSel = document.getElementById('oneTouchType');
		var itemCategorySel = document.getElementById('itmCategory');	
		var maxShip = getValue(document.getElementById('maxShipText'));
		var purchaseStatus = document.getElementById('purchaseStatus');
		
		var catchWt = document.getElementById('catchRadio').checked;
		var variableWt = document.getElementById('variableRadio').checked;
		var noneWt = document.getElementById('noneRadio').checked;
		//DRU
		//var dsplyDryPalSw = document.getElementById('dsplyDryPalSwId').checked;	
		var srsAffTypCd = document.getElementById('srsAffTypCdId');	
		var prodFcngNbr = getValue(document.getElementById('prodFcngNbrId'));
		var prodRowDeepNbr = getValue(document.getElementById('prodRowDeepNbrId'));
		var prodRowHiNbr = getValue(document.getElementById('prodRowHiNbrId'));
		var nbrOfOrintNbr = document.getElementById('nbrOfOrintNbrId');	
		// END DRU
		if(catchWt == false && variableWt == false){
			noneWt = true;
		}
		
		var caseVO = new Object();
		
		caseVO.catchWeight = catchWt;
		caseVO.variableWeight = variableWt;
		caseVO.none = noneWt;
				
		caseVO.caseDescription = caseDesc;
		caseVO.unitFactor = unitFactor;
		caseVO.caseUPC = caseUPC;
		caseVO.caseChkDigit= caseCheck;
	 	caseVO.maxShelfLifeDays = maxShelfLifeDays;
	 	caseVO.inboundSpecificationDays = inboudSpecificationDays;
		caseVO.reactionDays = reactionDays;
		caseVO.guaranteetoStoreDays = guaranteeToStoreDays;
		caseVO.channel = channelVal;
		caseVO.channelVal = channelVal1;
		caseVO.upcValues = getLinkedUPCUniqueIds();
		caseVO.primaryUpcUniqueId = getPrimaryUPC();
		caseVO.catchWeight = document.getElementById('catchRadio').checked;
		caseVO.variableWeight = document.getElementById('variableRadio').checked;
		
		caseVO.masterPack = masterPack;
		caseVO.masterLength=  masterLength;
		caseVO.masterHeight = masterHeight;
		caseVO.masterWeight = masterWeight ;
		caseVO.masterCube = masterCube;
		caseVO.masterWidth = masterWidth;
		
	 	caseVO.shipPack = shipPack;
	 	caseVO.shipLength = shipLength ;
	 	caseVO.shipHeight = shipHeight;
	 	caseVO.shipWeight = shipWeight;
	 	caseVO.shipCube = shipCube ;
		caseVO.shipWidth = shipWidth;
		if (oneTouchSel && oneTouchSel.selectedIndex > -1 && oneTouchSel.options.length > 0){
			caseVO.oneTouch = oneTouchSel.options[oneTouchSel.selectedIndex].value;
		}
		if(document.getElementById('codeDate')) {
			caseVO.codeDate = document.getElementById('codeDate').checked;
		}
		if(itemCategorySel && itemCategorySel.options.length > 0 &&itemCategorySel.selectedIndex > -1) {
			caseVO.itemCategory = itemCategorySel.options[itemCategorySel.selectedIndex].value;
		}
		caseVO.maxShip = maxShip;
		if(purchaseStatus != null && purchaseStatus.options.length > 0 ){//temp fix to prevent damage.
			caseVO.purchaseStatus = purchaseStatus.options[purchaseStatus.selectedIndex].value;
		}
		if(document.getElementById('dsplyDryPalSwId')) {
			caseVO.dsplyDryPalSw = document.getElementById('dsplyDryPalSwId').checked;
		}
		if (srsAffTypCd && srsAffTypCd.selectedIndex > -1 && srsAffTypCd.options.length > 0){
			caseVO.srsAffTypCd = srsAffTypCd.options[srsAffTypCd.selectedIndex].value;
		}
		caseVO.prodFcngNbr = prodFcngNbr;
		caseVO.prodRowDeepNbr = prodRowDeepNbr;
		caseVO.prodRowHiNbr = prodRowHiNbr;
		if (nbrOfOrintNbr && nbrOfOrintNbr.selectedIndex > -1 && nbrOfOrintNbr.options.length > 0){
			caseVO.nbrOfOrintNbr = nbrOfOrintNbr.options[nbrOfOrintNbr.selectedIndex].value;
		}
		return caseVO;
	}
	
	
	var showNoData = true;
	var addCountCase = 0;
	var selectedRowNumber = -1;
	function addRowToCaseItemDetails(data,stopProgress){
		
		var upcTableBody = document.getElementById('caseItemTbody');
			//addCountCase++;	
			var rowLength = upcTableBody.rows.length; 
			
			//set the row count
			if(rowLength > 0){
				 addCountCase = rowLength+1;
				var lastRow = upcTableBody.rows[upcTableBody.rows.length - 1].id;
                var last = lastRow.substr(lastRow.length - 1);
      		    addCountCase = parseInt(last) + 1;
			}else{
				addCountCase = 1;
			}
			var newRow = upcTableBody.insertRow(-1);
			newRow.id="ajaxCase"+addCountCase;
			var cntTmp = addCountCase;
			newRow.style.fontFamily = 'Verdana, Arial, Helvetica, sans-serif';
			newRow.style.fontSize = '12px';
			
			var col;
			col = "#FFF9F4";
			
			var classAppend = rowLength % 2;
			if(classAppend == 1){
				col = "#FEEADA";
			}else{
				col = "#FFF9F4";
			}
			newRow.style.backgroundColor = col;
			//newRow.onmouseover = function(){ colorChangeRow("ajaxCase"+addCountCase,'white'); };
			newRow.onclick = function(){ makeRowClickedForTable("caseItemTbody","ajaxCase"+cntTmp,cntTmp,'#FFAA00');	
										
										 displayDetailsForAjaxRows(cntTmp, stopProgress); 
							 };
			selectedRowNumber = cntTmp;			
			//newRow.onmouseout = function(){ colorChangeRow("ajaxCase"+addCountCase,col); };
			
			var	active = "";		
			//Fix QC 1483
			if(isNaN(data.itemId)) {
				active="Active";//getPurchaseStatus(data.purchaseStatus);	
			}
			var checkMRT = '';
			if(data.mrt != null
				&& data.mrt == 'Y'){
				checkMRT = '<input type="checkbox" checked="checked"  disabled="disabled"/><input type="hidden" value="'+data.uniqueId+'" id="caseVOUniqueIdAjax'+cntTmp+'"/>';
			}else{
				checkMRT = '<input type="checkbox" disabled="disabled"/><input type="hidden" value="'+data.uniqueId+'" id="caseVOUniqueIdAjax'+cntTmp+'"/>';
			}
			
			var fifthRowData =  changeTo(data.caseDescription) + '<input type="hidden" id="caseDescAjax'+addCountCase+'" value="'+ changeTo(data.caseDescription)+'"/>	 ';	
			var hiddenPsItmId = '<input type="hidden" id="casePsItemId'+cntTmp+'" value="'+data.psItemId+'"/>';
			
			rowLength--;		
			var rowData = [		
			data.vpc, 
			data.formattedCaseUPC,
	
			'',//data.itemId, 
			fifthRowData, 
			checkMRT,
			data.channel, 
			data.masterPack, 
			data.shipPack, 
			data.listCost,
			active,
			'',
			hiddenPsItmId
			];
			for (var i = 0; i < rowData.length; i++) {
		        newCell = newRow.insertCell(i);
		        newCell.align = "center";
		        newCell.style.backgroundColor = col;
		        newCell.innerHTML = rowData[i];
	   		}
	   		
	   		new YAHOO.widget.Button("deleteButAjx'+addCountCase+'");
	   		var idI = data.uniqueId;
  			var ary = [ newRow.id, idI ];
  	   		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteButAjx'+addCountCase+'"), "click", deleteSelectedCase1,ary);
	   		clearCaseItemDetails();
	   		
	   		
	   		//for saving vendor after saving case 
	   		if(caseHook != null){
	   			//enableActivation();
	   			newRow.onclick();
	   			addedCaseRowIsAjax = true;
	   			addedCaseRowCount = cntTmp;
	   			var tmp = caseHook;
	   			caseHook = null;
	   			tmp();
	   		}else{
	   			//hideProgress();
				clearVendorDetails();
				//enableActivation();
	   			newRow.onclick();
	   		}
	   		
	   		
	   		/// code for displaying edit delete button.
	   		if(document.getElementById('editCaseBut')){
				document.getElementById('editCaseBut').style.display = 'inline';	
				document.getElementById('editCaseBut').disabled = false;	
				YAHOO.util.Event.removeListener(YAHOO.util.Dom.get("editCaseBut"), "click");				
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("editCaseBut"), "click", displayDetailsForAjaxRowsNP);
			}
			if(document.getElementById('deleteBut')){
				document.getElementById('deleteBut').style.display = 'inline';
				document.getElementById('deleteBut').disabled = false;	
				YAHOO.util.Event.removeListener(YAHOO.util.Dom.get("deleteBut"), "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteBut"), "click", deleteSelectedCase);
			}	
			if(document.getElementById('addCaseBut')){
				document.getElementById('addCaseBut').disabled = false;	
			}
			//isSavingCase=false;
			//AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligibleWithoutProcessBar));
					
	}
	
	function clearCaseItemDetails(){	
	   	if(YAHOO.util.Dom.get('caseUpcText')){
			document.getElementById('caseUpcText').value = '';
			}
		if(YAHOO.util.Dom.get('caseCheckDigit')){
			document.getElementById('caseCheckDigit').value = '';
			}
		if(YAHOO.util.Dom.get('unitFactor')){
			document.getElementById('unitFactor').value = '';
			}
		if(YAHOO.util.Dom.get('caseDescriptionText')){
		 	document.getElementById('caseDescriptionText').value = '';
		 	}
		 if(YAHOO.util.Dom.get('catchRadio')){	
		 	document.getElementById('catchRadio').checked = false;
		 	}
		 if(YAHOO.util.Dom.get('variableRadio')){
		 	document.getElementById('variableRadio').checked = false;
		 	}
		 if(YAHOO.util.Dom.get('noneRadio')){
		 	document.getElementById('noneRadio').checked = false;
		 	}
		  if(YAHOO.util.Dom.get('masterPackText')){		
	 		document.getElementById('masterPackText').value = '';
	 		}
	 	 if(YAHOO.util.Dom.get('masterLength')){
			document.getElementById('masterLength').value = '';
			}
		 if(YAHOO.util.Dom.get('masterHeight')){
			document.getElementById('masterHeight').value = '';
			}
		 if(YAHOO.util.Dom.get('masterWeight')){
			document.getElementById('masterWeight').value = '';
			}
		 if(YAHOO.util.Dom.get('masterWidth')){
			document.getElementById('masterWidth').value = '';
			}
		 if(YAHOO.util.Dom.get('masterCubeLabel')){
			document.getElementById('masterCubeLabel').innerText = '';
			}
		if(YAHOO.util.Dom.get('shipPackText')){		
	 		document.getElementById('shipPackText').value = '';
	 		}
	 	if(YAHOO.util.Dom.get('shipLength')){
			document.getElementById('shipLength').value = '';
			}
		if(YAHOO.util.Dom.get('shipWeight')){
			document.getElementById('shipWeight').value = '';
			}
		if(YAHOO.util.Dom.get('shipHeight')){
	 		document.getElementById('shipHeight').value = '';
	 		}
	 	if(YAHOO.util.Dom.get('shipWidth')){
	 		document.getElementById('shipWidth').value = '';
	 		}
	 	if(YAHOO.util.Dom.get('shipCubeLabel')){
	 		document.getElementById('shipCubeLabel').innerText = '';
	 		}
	 	if(YAHOO.util.Dom.get('shelfDays')){	
			document.getElementById('shelfDays').value = '';
			}
	 	if(document.getElementById('inboundDays')){
			document.getElementById('inboundDays').value = '';
		}
	 	if(document.getElementById('reactionDays')){
			document.getElementById('reactionDays').value = '';
		}
	 	if(document.getElementById('guaranteestoreDays')){
			document.getElementById('guaranteestoreDays').value = '';
		}
		if(YAHOO.util.Dom.get('oneTouchType')){
			YAHOO.util.Dom.get('oneTouchType').value = "";
		}
		
		if(YAHOO.util.Dom.get('itmCategory')){
			YAHOO.util.Dom.get('itmCategory').value = "";
		}

		if(YAHOO.util.Dom.get('maxShipText')){		
	 		document.getElementById('maxShipText').value = '';
	 	}
		if(YAHOO.util.Dom.get('purchaseStatus')){
			YAHOO.util.Dom.get('purchaseStatus').selectedIndex = 0;
		}
			var i=0;
			while(true){
				if(document.getElementById('upcCaseCheck'+i)){
					document.getElementById('upcCaseCheck'+i).checked = false;
				}else{
					break;
				}
				if(document.getElementById('caseUPCRadio'+i)){
					document.getElementById('caseUPCRadio'+i).checked = false;
					document.getElementById('caseUPCRadio'+i).disabled = true;
				}else{
					break;
				}
				i++;
			}
		
		}
	
	//function for adding vendor details
	//function to be called on clicking addbutton from existing case section
	function changeDisplay(evt){	
		selectedCaseRowCount = null;
		selectedCaseRowCountAjax = null;
		document.getElementById('selectedCaseDetails').innerHTML = "";
		document.getElementById('selectedCaseDetails').style.display="none";
		document.getElementById('details').style.display="block";
		if(addCaseDetailsData != null){
			document.getElementById('details').innerHTML = addCaseDetailsData;
			addCaseDetailsData = null;
		}
		clearCaseItemDetails();

		//Loading of vendor type ahead when Add New Case button is clicked
		if(document.getElementById('vendorDetailsDiv').style.display == "block"){
			loadScriptsFromDiv('vendorDetailsDiv');
			clearVendorDetails();
		}else{
			document.getElementById('selectedvendorDetailsDiv').innerHTML = "";
			document.getElementById('selectedvendorDetailsDiv').style.display = 'none';
			document.getElementById('vendorDetailsDiv').style.display = 'block';
			if(addVendorSectionHTML != null ){
				document.getElementById('vendorDetailsDiv').innerHTML = "";
				document.getElementById('vendorDetailsDiv').innerHTML = addVendorSectionHTML;
				loadScriptsFromDiv('vendorDetailsDiv');
			}
			clearVendorDetails();
		}
		//end of vendor load

		document.getElementById('actions3').selectedIndex = 0;
		//Sprint - 23
		loadDefaultChannel();
		<c:if test="${CPSForm.questionnarieVO.selectedOption == 4}">
			disabledDRUField(true);
		</c:if>
		<c:if test="${CPSForm.questionnarieVO.selectedOption != 4}">
			disabledDRUField(false);
		</c:if>		
		YAHOO.util.Event.removeListener("backButton", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd);  
		//but = new YAHOO.widget.Button("AVupc");
		//YAHOO.util.Event.removeListener("AVupc", "click");
		//YAHOO.util.Event.addListener(YAHOO.util.Dom.get("AVupc"), "click", addCaseDetailsToTable);
		but = new YAHOO.widget.Button("addCaseBut");
		YAHOO.util.Event.removeListener("addCaseBut", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addCaseBut"), "click", changeDisplay);
		YAHOO.util.Event.removeListener("codeDate", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("codeDate"), "click", checkedCodeDate);
		but = new YAHOO.widget.Button("addButton6");
		YAHOO.util.Event.removeListener("addButton6", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", saveCaseAndVendor);
		YAHOO.util.Event.removeListener("reqAttribute", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("reqAttribute"), "click", reqAttributeClick);
		
		document.getElementById('caseDetailsLegend').innerHTML = "Add New Case Details";
		makeAppUPCLinked(null);
			
		
		YAHOO.util.Dom.get("AVupc").style.display = 'inline';	
		YAHOO.util.Dom.get("AVupc").disabled = false;
		YAHOO.util.Event.removeListener(YAHOO.util.Dom.get("AVupc"), "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("AVupc"), "click", addCaseDetailsToTable);
		
		
		if(YAHOO.util.Dom.get("cancelBut")){
		YAHOO.util.Dom.get("cancelBut").style.display = 'inline';
		YAHOO.util.Dom.get("cancelBut").disabled = false;
		YAHOO.util.Event.removeListener(YAHOO.util.Dom.get("cancelBut"), "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("cancelBut"), "click", onCancleClick);
		}
		if(	document.getElementById("addCaseBut")){
			document.getElementById('addCaseBut').disabled = true;
		}	
		if(document.getElementById('editCaseBut')){
			document.getElementById('editCaseBut').disabled = true;	
		}
		if(document.getElementById('deleteBut')){
			document.getElementById('deleteBut').disabled = true;	
		}
		
		if(document.getElementById('editCaseBut')){
			document.getElementById('editCaseBut').disabled = true;	
		}
		
		//1205 Edit Cost Edit Vendor
		//Disable 'List Cost' field
		if(document.getElementById('listCost')){
			document.getElementById('listCost').disabled = false;	
		}
		try{
		document.getElementById('caseDescriptionText').focus();
		}catch(e){}
	}
	
	//YAHOO.util.Event.onDOMReady(makeAppUPCLinked);
	function makeAppUPCLinked(evt){
		var upc1 = document.getElementById('upcCaseCheck0'); 
		var link1 = document.getElementById('caseUPCRadio0');
		var upc2 = document.getElementById('upcCaseCheck1');
		var link2 = document.getElementById('caseUPCRadio1');
		if(upc1 && link1 && !upc2 && !link2){
			upc1.checked = true;
			link1.checked = true;
		}
		//enableActivation();
	}
	
	function onCancleClick_old(){	
		// Disable save and Cancel Buttons	
		document.getElementById('addCaseBut').disabled = false;	
		//YAHOO.util.Dom.get("AVupc").style.display = 'none';
		//YAHOO.util.Dom.get("cancelBut").style.display = 'none';
		document.getElementById('AVupc').disabled = true;
		
		/// Disable cancel but on cancel click.
		document.getElementById('cancelBut').disabled = true;	
		
		
		// If there are rows in the table enable edit case and delete case btns
		var tBody = document.getElementById('caseItemTbody');
		var disableWhenNoRow = false;
		var hideWhenNoRow = 'inline';
		if(tBody.rows.length == 0){
			disableWhenNoRow = true;
			hideWhenNoRow = 'none';
		}
		if(document.getElementById('editCaseBut')){
			document.getElementById('editCaseBut').disabled = disableWhenNoRow;	
			document.getElementById('editCaseBut').style.display = hideWhenNoRow;
			
		}
		
		if(document.getElementById('deleteBut')){
			document.getElementById('deleteBut').disabled = disableWhenNoRow;
			document.getElementById('deleteBut').style.display = hideWhenNoRow;			
		}
		
		// clear case details
		document.getElementById('caseDescriptionText').value = '';
		
		document.getElementById('actions3').selectedIndex = 0;
		document.getElementById('actions3').disabled = false;
		//document.getElementById('actions3').onChange();
		selectChannel();
		
		document.getElementById('catchRadio').checked = false;
		document.getElementById('variableRadio').checked = false;
		document.getElementById('noneRadio').checked = false;
	}
	
	//function to be called on clicking back button
	function showProd(evt) {
		document.forms[0].action = "${pageLink}";
		document.forms[0].submit();
	}
	
	//function to be called on clicking Product&UPC tab
	function router(evt){	
		f1('${page6}'+'&t='+new Date().getTime(),'UPC Details','200px','62%','80px','80px');
	}
	
	function saveVendor(evt){
		if(document.getElementById('vendorACInput').value == null ||
			document.getElementById('vendorACInput').value == ""){
			alert("Please input a vendor.");
			return;
		}
		
		if(document.getElementById('listcost').value == null ||
			document.getElementById('listcost').value == ""){
			alert("Please input a list cost.");
			return;
		}
		
		if(checkValidImportVO())
		{
			var vendorVO = getCurrentVendorVO();
			var vendorUniqueId = document.getElementById('selectedVendorUniqId').value;
			var caseUniqeId = document.getElementById('selectedCaseUniqueId').value;
			showProgress();
			AddCandidateTemp.saveVendorVO(vendorVO,vendorUniqueId,caseUniqeId,getDWRCallbackMethod(updateVendorRow));
			disabledVendor();
		}
		else
		{
		   alert("All the fields should be mandatory except (Duty Info, HTS2, HTS3, Warehouse Flush Date, Instore date and Proration Date).");
		}		
	}
	
	function saveVendorAuthorizeStore(evt){
		if(document.getElementById('vendorACInput').value == null ||
			document.getElementById('vendorACInput').value == ""){
			alert("Please input a vendor.");
			return;
		}
		if(document.getElementById('listcost').value == null ||
			document.getElementById('listcost').value == ""){
			alert("Please input a list cost.");
			return;
		}
		
		if(checkValidImportVO())
		{
			var vendorVO = getCurrentVendorVO();
			var vendorUniqueId = document.getElementById('selectedVendorUniqId').value;
			var caseUniqeId = document.getElementById('selectedCaseUniqueId').value;
			showProgress();
			AddCandidateTemp.saveVendorVO(vendorVO,vendorUniqueId,caseUniqeId,getDWRCallbackMethod(updateVendorRowAuthorizeStore));
			disabledVendor();		
		}
		else
		{
		   alert("All the fields should be mandatory except (Duty Info, HTS2, HTS3, Warehouse Flush Date, Instore date and Proration Date).");
		}		
	}
	function updateVendorRow(data){
<!-- 		hideProgress(); -->
		var seletedRowId;
		var thirdRowData;
		var cnt = null;
		var guarSaleId = null;
		var dealOffrdId = null;

		if(selectedVendorRowCount){
			seletedRowId = "vendorRow"+selectedVendorRowCount;
			cnt = selectedVendorRowCount;
			guarSaleId = "guarSaleReal"+cnt;
			dealOffrdId = "dealOffrdReal"+cnt;
		}else if(selectedVendorRowCountAjax){
			seletedRowId = "vendorAjaxRow"+selectedVendorRowCountAjax;
			cnt = selectedVendorRowCountAjax;
			guarSaleId = "guarSale"+cnt;
			dealOffrdId = "dealOff"+cnt;
		}
		var profitWarning = document.getElementById("profitWarning");
		var marginWarningIdAjax = document.getElementById("marginWarningIdAjax")
		if(data.marginMessageWarning!=null && data.marginMessageWarning!="" && marginWarningIdAjax!=null) {
			profitWarning.style.display = "block";
			marginWarningIdAjax.value=data.marginMessageWarning;
		} else {
			profitWarning.style.display = "none";
		}
		var selRow = document.getElementById(seletedRowId);
		if(data.dealOffered){
			document.getElementById(dealOffrdId).checked = true;
		}else{
			document.getElementById(dealOffrdId).checked = false;
		}
		if(data.guarenteedSale){
			document.getElementById(guarSaleId).checked = true;
		}else{
			document.getElementById(guarSaleId).checked = false;
		}
		
		if(data.listCost){
			data.listCost = formatValue(data.listCost);
		}

		var rCostOwner = "";
		if(data.costOwner != null){
			rCostOwner = data.costOwner;
		}
		
		var rTopToTop = "";
		if(data.top2Top != null){
			rTopToTop = data.top2Top;
		}

		var rListCost = "";
		if(data.listCost != "0"){
			rListCost = data.listCost;
		}

		var rowData = [
		//'', 
		data.vendorLocation,
		data.vpc,
		null,
		null,
		rListCost,
		//data.unitCost,
		//null,
		rCostOwner,
		rTopToTop,
		data.countryOfOrigin,
		//data.seasonality,
		//data.seasonalityYear,
		data.channelByLocation,
		null
		];
		for(var i=0;i < selRow.cells.length;i++){
			var tCell = selRow.cells[i];
			if(rowData[i] != null){
				tCell.innerHTML = rowData[i];
			}
		}
		if(vendorWareHouseHook != null){
			vendorWareHouseHook();
			vendorWareHouseHook = null;
		}
		document.getElementById("conflictMessage").innerText ="";
		
		var selVendorUniqueId = getRemainVendor();//getSelectedVendorId();
		var selCaseUniqueId = getSelectedCaseID();
		//removeCase eDC 
		if(data.psItemWHSeDC != null && data.psItemWHSeDC != ""){
			deleteCaseItemeDCFromTbl1(data.psItemWHSeDC);
		}
		//console.log('updateVendorRow');
		if(null != selVendorUniqueId && null != selCaseUniqueId){
			AddCandidateTemp.beforeMorph(selVendorUniqueId,selCaseUniqueId, false,data.vendorLocationVal,getDWRCallbackMethod(afterBeforeMorph));
		}else{
			AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligible));
		}
	}
	function updateVendorRowAuthorizeStore(data){
		hideProgress();		
		var seletedRowId;
		var thirdRowData;
		var cnt = null;
		var guarSaleId = null;
		var dealOffrdId = null;

		if(selectedVendorRowCount){
			seletedRowId = "vendorRow"+selectedVendorRowCount;
			cnt = selectedVendorRowCount;
			guarSaleId = "guarSaleReal"+cnt;
			dealOffrdId = "dealOffrdReal"+cnt;
		}else if(selectedVendorRowCountAjax){
			seletedRowId = "vendorAjaxRow"+selectedVendorRowCountAjax;
			cnt = selectedVendorRowCountAjax;
			guarSaleId = "guarSale"+cnt;
			dealOffrdId = "dealOff"+cnt;
		}
		var selRow = document.getElementById(seletedRowId);
		if(data.dealOffered){
			document.getElementById(dealOffrdId).checked = true;
		}else{
			document.getElementById(dealOffrdId).checked = false;
		}
		if(data.guarenteedSale){
			document.getElementById(guarSaleId).checked = true;
		}else{
			document.getElementById(guarSaleId).checked = false;
		}
		
		if(data.listCost){
			data.listCost = formatValue(data.listCost);
		}

		var rCostOwner = "";
		if(data.costOwner != null){
			rCostOwner = data.costOwner;
		}
		
		var rTopToTop = "";
		if(data.top2Top != null){
			rTopToTop = data.top2Top;
		}

		var rListCost = "";
		if(data.listCost != "0"){
			rListCost = data.listCost;
		}

		var rowData = [
		//'', 
		data.vendorLocation,
		data.vpc,
		null,
		null,
		rListCost,
		//data.unitCost,
		//null,
		rCostOwner,
		rTopToTop,
		data.countryOfOrigin,
		//data.seasonality,
		//data.seasonalityYear,
		null,
		null
		];
		for(var i=0;i < selRow.cells.length;i++){
			var tCell = selRow.cells[i];
			if(rowData[i] != null){
				tCell.innerHTML = rowData[i];
			}
		}
		if(vendorWareHouseHook != null){
			vendorWareHouseHook();
			vendorWareHouseHook = null;
		}
		document.getElementById("conflictMessage").innerText ="";		
		
		var selVendorUniqueId = getSelectedVendorId();
		var selCaseUniqueId = getSelectedCaseID();
		
		
		//removeCase eDC 
		if(data.psItemWHSeDC != null && data.psItemWHSeDC != ""){
			deleteCaseItemeDCFromTbl1(data.psItemWHSeDC);
		}
		if(null != selVendorUniqueId && null != selCaseUniqueId){
			callbackFunction = reqStoreAttrCore;
			AddCandidateTemp.beforeMorph(selVendorUniqueId,selCaseUniqueId,false,"",getDWRCallbackMethod(afterBeforeMorph));
		}else{
			reqStoreAttrCore();
		}
		
	}	
	
	
	var vendorWareHouseHook = null;
	function addVendor(evt){
		if(document.getElementById('vendorACInput').value == null ||
			document.getElementById('vendorACInput').value == ""){
			alert("Please input a vendor.");
			return;
		}
		
		if(document.getElementById('listCost').value == null ||
			document.getElementById('listCost').value == ""){
			alert("Please input a list cost.");
			return;
		}
		
		var vendorVO = getCurrentVendorVO();
		if(checkValidImportVO())
		{
			if(getSelectedCaseID()){
				showProgress();
				beginMorph=false;
				//console.log('addVendor');
				AddCandidateTemp.addVendorVO(vendorVO,getSelectedCaseID(),getDWRCallbackMethod(addRowToVendorTable));
				if(document.getElementById('backButton')){
					var but = new YAHOO.widget.Button("backButton");
					YAHOO.util.Event.removeListener("backButton", "click");
					YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd);
				}
			} else {
				saveCaseAndVendor(evt);
			}
		}else
			{
				alert("All the fields should be mandatory except (Duty Info, HTS2, HTS3, Warehouse Flush Date, Instore date and Proration Date).");
			}	
		
	}
	
	
	function getCurrentVendorVO(){
		var vendorVO = new Object();
		//958 enhancements
		if(YAHOO.util.Dom.get('subDept')){
			vendorVO.subDept = YAHOO.util.Dom.get("subDept").value;
		}
		if(YAHOO.util.Dom.get('vendPssDept')){
			var vendPssDept = YAHOO.util.Dom.get("vendPssDept");
			if(vendPssDept.length > 0)
				vendorVO.pssDept = vendPssDept.options[vendPssDept.selectedIndex].value;
		}
		if(YAHOO.util.Dom.get('vpc')){
			vendorVO.vpc = YAHOO.util.Dom.get("vpc").value;
		}
		if(YAHOO.util.Dom.get('listCost')){
			vendorVO.listCost = YAHOO.util.Dom.get("listCost").value;
		}
		if(YAHOO.util.Dom.get('gSales')){
			vendorVO.guarenteedSale = YAHOO.util.Dom.get("gSales").checked;
		}
		if(YAHOO.util.Dom.get('import')){
			vendorVO.importd = YAHOO.util.Dom.get("import").checked;
		}
		if(YAHOO.util.Dom.get('dealOffered')){
			vendorVO.dealOffered = YAHOO.util.Dom.get("dealOffered").checked;
		}
		if(YAHOO.util.Dom.get('costOwner')){
		var costOwner2 = YAHOO.util.Dom.get("costOwner");
		vendorVO.costOwner  = costOwner2.options[costOwner2.selectedIndex].text;
		vendorVO.costOwnerVal  = costOwner2.options[costOwner2.selectedIndex].value;
		}
		if(YAHOO.util.Dom.get('countryOfOrigin')){
		var countryOfOrigin2 = YAHOO.util.Dom.get("countryOfOrigin");
		vendorVO.countryOfOrigin = countryOfOrigin2.options[countryOfOrigin2.selectedIndex].text;
		vendorVO.countryOfOriginVal = countryOfOrigin2.options[countryOfOrigin2.selectedIndex].value;
		}
		if(YAHOO.util.Dom.get('vendorLocationVal')){
		var vendorNam2 = YAHOO.util.Dom.get('vendorLocationVal');
		//alert(vendorNam2.value);
		vendorVO.vendorLocationVal = vendorNam2.value;
		}
		if(YAHOO.util.Dom.get('vendorLocation')){
		var vendorNam2 = YAHOO.util.Dom.get('vendorLocation');
		//alert(vendorNam2.value);
		vendorVO.vendorLocation = vendorNam2.value;		
		}
		if(YAHOO.util.Dom.get('top2Top')){
		var top2Top2 = YAHOO.util.Dom.get("top2Top");
		if(top2Top2.selectedIndex >= 0){
			vendorVO.top2Top = top2Top2.options[top2Top2.selectedIndex].text;
			vendorVO.top2TopVal = top2Top2.options[top2Top2.selectedIndex].value;
		}
		}
		if(YAHOO.util.Dom.get('seasonality')){
		var seasonality2 = YAHOO.util.Dom.get("seasonality");
		vendorVO.seasonality =  seasonality2.options[seasonality2.selectedIndex].text;
		vendorVO.seasonalityVal =  seasonality2.options[seasonality2.selectedIndex].value;
		}
		if(YAHOO.util.Dom.get('seasonalityYear')){
			vendorVO.seasonalityYr = YAHOO.util.Dom.get("seasonalityYear").value;
		}
		if(YAHOO.util.Dom.get('vendorTie')){
			vendorVO.vendorTie = YAHOO.util.Dom.get("vendorTie").value;
		}
		if(YAHOO.util.Dom.get('vendorTier')){
			vendorVO.vendorTier = YAHOO.util.Dom.get("vendorTier").value; 
		}
		if(YAHOO.util.Dom.get('costlist')){
			vendorVO.costLink = YAHOO.util.Dom.get("costlist").value;
		}
		if(YAHOO.util.Dom.get('expectedweeklymovement')){
			vendorVO.expectedWeeklyMvt = YAHOO.util.Dom.get("expectedweeklymovement").value;
		}
		if(YAHOO.util.Dom.get('unitCostLabel')){
		vendorVO.unitCostLabel = YAHOO.util.Dom.get("unitCostLabel").innerText;
		}
<!-- 		if(YAHOO.util.Dom.get('costRadio')){ -->
<!-- 		vendorVO.costLinkRadio = document.getElementById('costRadio').checked; -->
<!-- 		} -->
<!-- 		if(YAHOO.util.Dom.get('itemRadio')){ -->
<!-- 		vendorVO.itemCodeRadio = document.getElementById('itemRadio').checked; -->
<!-- 		} -->
		if(YAHOO.util.Dom.get('costLinkBy') != null){
			var costLinkBy = YAHOO.util.Dom.get('costLinkBy');
			if(costLinkBy.value =="cl") {
				vendorVO.costLinkRadio = true;
				vendorVO.itemCodeRadio = false;
			}
			if(costLinkBy.value =="ic" || costLinkBy.value =="up") {
				vendorVO.itemCodeRadio = true;
				vendorVO.costLinkRadio = false;
			}
		}
		var importVO = new Object();
		
		if(YAHOO.util.Dom.get('cntnSize')){
			importVO.containerSize = YAHOO.util.Dom.get('cntnSize').value;
		}
		if(YAHOO.util.Dom.get('pcikPoint')){
			YAHOO.util.Dom.get('pcikPoint').value = trim(YAHOO.util.Dom.get('pcikPoint').value);
			importVO.pickupPoint = YAHOO.util.Dom.get('pcikPoint').value;
		}
		if(YAHOO.util.Dom.get('freight')){
			importVO.freight = YAHOO.util.Dom.get('freight').value;
		}
		if(YAHOO.util.Dom.get('minQntity')){
			importVO.minimumQty = YAHOO.util.Dom.get('minQntity').value;
		}
		if(YAHOO.util.Dom.get('color')){
			importVO.color = YAHOO.util.Dom.get('color').value;
		}
		if(YAHOO.util.Dom.get('incoTerms')){
			importVO.incoTerms = YAHOO.util.Dom.get('incoTerms').value;
		}
		if(YAHOO.util.Dom.get('prorDate')){
			importVO.prorationDate = YAHOO.util.Dom.get('prorDate').value;
		}
		if(YAHOO.util.Dom.get('rate')){
			importVO.rate = YAHOO.util.Dom.get('rate').value;
		}
		if(YAHOO.util.Dom.get('minType')){
			importVO.minimumType = YAHOO.util.Dom.get('minType').value;
		}
		if(YAHOO.util.Dom.get('instoreDate')){
			importVO.instoreDate = YAHOO.util.Dom.get('instoreDate').value;
		}
		if(YAHOO.util.Dom.get('hts')){
			importVO.hts = YAHOO.util.Dom.get('hts').value;
		}
		if(YAHOO.util.Dom.get('duty')){
			importVO.duty = YAHOO.util.Dom.get('duty').value;
		}
		if(YAHOO.util.Dom.get('agentPer')){
			importVO.agentPerc = YAHOO.util.Dom.get('agentPer').value;
		}
		if(YAHOO.util.Dom.get('whseFlushDate')){
			importVO.whseFlushDate = YAHOO.util.Dom.get('whseFlushDate').value;
		}
		if(YAHOO.util.Dom.get('cartMarketing')){
			YAHOO.util.Dom.get('cartMarketing').value = trim(YAHOO.util.Dom.get('cartMarketing').value);
			importVO.cartonMarketing = YAHOO.util.Dom.get('cartMarketing').value;
		}
		
		//Order Unit Changes
		if(YAHOO.util.Dom.get('orderUnit')){
			var orderUnit2 = YAHOO.util.Dom.get("orderUnit");
			vendorVO.orderUnit = orderUnit2.options[orderUnit2.selectedIndex].value;
		}
		if(YAHOO.util.Dom.get('orderRestriction')){
			var orderRestriction2 = YAHOO.util.Dom.get("orderRestriction");
			vendorVO.orderRestriction = orderRestriction2.options[orderRestriction2.selectedIndex].text;
			vendorVO.orderRestrictionVal = orderRestriction2.options[orderRestriction2.selectedIndex].value;
		}		
		
		//BEGIN R2 HTS 2 and 3
		if(YAHOO.util.Dom.get('hts2')){
			importVO.hts2 = YAHOO.util.Dom.get("hts2").value;
		}
		
		//add season and sellYear
		if(YAHOO.util.Dom.get('season')){
			importVO.season = YAHOO.util.Dom.get("season").value;
		}
		if(YAHOO.util.Dom.get('sellYear')){
			importVO.sellYear = YAHOO.util.Dom.get("sellYear").value;
		}
		
		
		if(YAHOO.util.Dom.get('hts3')){
			importVO.hts3 = YAHOO.util.Dom.get("hts3").value;
		}
		if(YAHOO.util.Dom.get('factoryList')){
			importVO.factoryList = YAHOO.util.Dom.get("factoryList").value;
		}
		// END R2 HTS 2 and 3.
		
		//BEGIN ADD dutyInfo		
		if(YAHOO.util.Dom.get('dutyInfo'))
		{
			YAHOO.util.Dom.get("dutyInfo").value = trim(YAHOO.util.Dom.get("dutyInfo").value);
			importVO.dutyInfo = YAHOO.util.Dom.get("dutyInfo").value;
		}
		
		vendorVO.importVO = importVO;	
		return vendorVO;
	}
	
	function getSelectedCaseID(){
		if(selectedCaseRowCount != null){
			if(document.getElementById('caseVOUniqueId'+selectedCaseRowCount)){
				return document.getElementById('caseVOUniqueId'+selectedCaseRowCount).value;
			}else if(document.getElementById('caseVOUniqueIdAjax'+selectedCaseRowCount)){
				return document.getElementById('caseVOUniqueIdAjax'+selectedCaseRowCount).value;
			}
		}else if(selectedCaseRowCountAjax != null){
			if(document.getElementById('caseVOUniqueIdAjax'+selectedCaseRowCountAjax)){
				return document.getElementById('caseVOUniqueIdAjax'+selectedCaseRowCountAjax).value;
			} else if(document.getElementById('caseVOUniqueId'+selectedCaseRowCountAjax)){
				return document.getElementById('caseVOUniqueId'+selectedCaseRowCountAjax).value;
			}
		}else{
			return null;
		}
	}
	
	function getSelectedCaseRowID(){
		if(selectedCaseRowCount != null){
			return 'caseRow'+selectedCaseRowCount;
		}else if(selectedCaseRowCountAjax != null){
			return 'ajaxCase'+selectedCaseRowCountAjax;
		}else{
			return null;
		}
	}
	
	
	var addCountVendor=0;
	var newlyAddedVendorRowShouldBeClicked = false;
	function addRowToVendorTable(data){
		//hideProgress();
		deleteNoVendorDiv();
		var cnt = addCountVendor++;	
		var cnt = addCountVendor;
		var vendorTableBody = document.getElementById("vendorTable");
		var rowLength = vendorTableBody.rows.length; 
		var newRow = vendorTableBody.insertRow(-1);
		newRow.id="vendorAjaxRow"+addCountVendor;
		newRow.style.fontFamily = 'Verdana, Arial, Helvetica, sans-serif';
		newRow.style.fontSize = '12px';	
		isVendorCancelClick = "";
		newRow.onclick = function() { makeRowClickedForTable('vendorTable','vendorAjaxRow'+cnt,cnt,'#FFAA00');
									  displayVendorDetailsAjax(cnt,false); };	
		var classAppend = rowLength % 2;
		var col;
		if(classAppend == 0){
			col = "#FEEADA";
		}else{
			col = "#FFF9F4";
		}
		newRow.style.backgroundColor = col;
		rowLength--;
		
		var butId = "deleteButtonAjax"+addCountVendor;
		
		<c:url var="img" value="${request.getContextPath()}/hebAssets/images/newButtons/delete_normal.gif"/>
		<c:url var="imgOver" value="${request.getContextPath()}/hebAssets/images/newButtons/delete_mouseclick.gif"/>
		
		var but = "<div><a id='link"+addCountVendor+"'>" +
					"<img src='${img}' alt='' name='"+butId+"'  border='0' id='"+butId+"'>"+
				"</a></div>";
		var chk = null;
		if(data.upcScenario){
			chk = "<input type='checkbox' id='checkAjax"+addCountVendor+"' disabled='disabled' checked = 'checked'>";
		}else{
			chk = "<input type='checkbox' id='checkAjax"+addCountVendor+"' disabled='disabled'>";
		}
		
		var rad = null;
		if(data.upcRadio){
			rad = "<input type='radio' id='checkAjax"+addCountVendor+"' disabled='disabled' checked = 'checked'>";
		}else{
			rad = "<input type='radio' id='checkAjax"+addCountVendor+"' disabled='disabled'>";
		}
		
		var inptUniq = '<input type="hidden" id="vendorUniqAjax'+addCountVendor+'" value="'+data.uniqueId+'"/>';
		var guarSaleCheckBox = null;
		if(data.guarenteedSale){
			guarSaleCheckBox = '<input type="checkbox" disabled="true" checked id="guarSale'+cnt+'"/>';
		} else{
			guarSaleCheckBox = '<input type="checkbox" disabled="true"  id="guarSale'+cnt+'"/>';
		}
		var dealOffered = null;
		if(data.dealOffered){
			dealOffered = '<input type="checkbox" disabled="true" checked  id="dealOff'+cnt+'"/>';
		} else{
			dealOffered = '<input type="checkbox" disabled="true" id="dealOff'+cnt+'"/>';
		}
		
		var rCostOwner = "";
		if(data.costOwner != null){
			rCostOwner = data.costOwner;
		}
		
		var rTopToTop = "";
		if(data.top2Top != null){
			rTopToTop = data.top2Top;
		}
		var rListCost = "";
		if(data.listCost != '0'){
			rListCost = data.listCost;
		}
		var rowData = [
		//'', 
		data.vendorLocation,
		//data.vendorNumber,
		data.vpc,
		guarSaleCheckBox+' <input type="hidden" id="hid'+addCountVendor+'" value="'+data.uniqueId+'" />',
		dealOffered + inptUniq,
		rListCost,
	//	data.unitCost,
	//	'<input type="checkbox" id="ajaxImport'+addCountVendor+'" onclick="importFn();"/>',
		
		rCostOwner,
		rTopToTop,
		data.countryOfOrigin,
	//	data.seasonality,
	//	data.seasonalityYear,
		data.channelByLocation,
		''
		];
		for (var i = 0; i < rowData.length; i++) {
	        newCell = newRow.insertCell(i);
	        newCell.style.backgroundColor = col;
	        newCell.innerHTML = rowData[i];
   		}
   		
		new YAHOO.widget.Button("deleteVendButAjx'+data.uniqueId+'");
		YAHOO.util.Event.removeListener(butId, "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteVendButAjx'+data.uniqueId+'"), "click", deleteVendor,addCountVendor);
		
		if(vendorWareHouseHook != null){
			vendorWareHouseHook();
			vendorWareHouseHook = null;
		}else{
			if(!newlyAddedVendorRowShouldBeClicked){
				newRow.click();
			}
		}
		if(newlyAddedVendorRowShouldBeClicked){
			newlyAddedVendorRowShouldBeClicked = false;
			newRow.click();
		}
		clearVendorDetails();
		
		//Fix 1084. Setting this here since clearVendorDetails() sets selectedVendorRowCountAjax to null
		selectedVendorRowCountAjax = cnt;

		//defaultAuthorization();
		document.getElementById("conflictMessage").innerText ="";
		if(data.conflict == "conflict") {
		    document.getElementById("conflictMessage").innerText=" Store conflict exist between vendors. Kindly authorize stores individually.";
			//defaultAuthorizationConflict();
		}
		//enableActivation();
		var selVendorUniqueId = getRemainVendor();//getSelectedVendorId();
		var selCaseUniqueId = getSelectedCaseID();
		if(null != selVendorUniqueId && null != selCaseUniqueId){
		//	console.log('addRowToVendorTable');
			showProgress();
			beginMorph = true;
			AddCandidateTemp.beforeMorph(selVendorUniqueId,selCaseUniqueId,false,data.vendorLocationVal,getDWRCallbackMethod(afterBeforeMorph));
		}else{
			AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligible));
		}
		
	}
	
	
	
	function afterInitElligible(data){
		//toggleVisible("imgAttrDiv", data.isEligible);
		hideVendorToogleButtonDuplicate();
		hideProgress();
	}
	
	function afterInitElligibleWithoutProcessBar(data){
		//toggleVisible("imgAttrDiv", data.isEligible);
	}
	
 	function defaultAuthorization(){
  	  showProgress();
      AddCandidateTemp.defaultAuthorization(getDWRCallbackMethod(defaultAuthorizationCallback));
    }
    
 <c:url value="/protected/cps/add/conflictStore?${_csrf.parameterName}=${_csrf.token}" var="storeConflict"></c:url>
   function defaultAuthorizationCallback(data){
   hideProgress();
       if(data == "conflict"){
         formObject.action = "${storeConflict}";
        }
      else if(data!=""){
         alert(data);
         }
  }
  function defaultAuthorizationConflict(){
  		showProgress();
	   var formObject = document.getElementById('authAndDistForm');
	   formObject.action = "${storeConflict}";
	   var callback = {
			success:function(o){
				hideProgress();
		 	},
			failure:function(o){
				hideProgress();
		 	}
	   };
	   
	   var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
  }
 function setDateDefaultVendorDetails(){
<!--  		set date default for duty and freight -->
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!
		var yyyy = today.getFullYear();
		if(dd<10) {
		    dd='0'+dd
		} 
		if(mm<10) {
		    mm='0'+mm
		} 
		today = mm+'/'+dd+'/'+yyyy;
		YAHOO.util.Dom.get('duty').value = today;
		YAHOO.util.Dom.get('freight').value = today;
 }			
 function clearVendorDetails(){
 		 //958 enhancements
		 if(YAHOO.util.Dom.get('subDept')){
			YAHOO.util.Dom.get('subDept').value = '${CPSForm.defaultSubDept}';
			document.getElementById('subDept').disabled = false;
		}

		 if(YAHOO.util.Dom.get('vendorLocation')){
		 		document.getElementById('vendorLocation').value = ''; 
				}
		 if(YAHOO.util.Dom.get('vendorLocationVal')){
		 		document.getElementById('vendorLocationVal').value = ''; 
				}
		 if(YAHOO.util.Dom.get('vendorACInput')){
		 		document.getElementById('vendorACInput').value = ''; 
				}
		if(YAHOO.util.Dom.get('vpc')){
				document.getElementById('vpc').value = ''; 
				}
		if(YAHOO.util.Dom.get('listCost')){
				document.getElementById('listCost').value = ''; 
				}
		if(YAHOO.util.Dom.get('vendorTie')){
				document.getElementById('vendorTie').value = ''; 
				}
		if(YAHOO.util.Dom.get('vendorTier')){
				document.getElementById('vendorTier').value = ''; 
				}
		if(YAHOO.util.Dom.get('costOwner')){
				document.getElementById('costOwner').selectedIndex = 0; 
				}
		if(YAHOO.util.Dom.get('countryOfOrigin')){
				document.getElementById('countryOfOrigin').value = ''; 
				}
		if(YAHOO.util.Dom.get('seasonality')){
				document.getElementById('seasonality').value = ''; 
				}
		if(YAHOO.util.Dom.get('seasonalityYear')){
				document.getElementById('seasonalityYear').value = ''; 
				}
		if(YAHOO.util.Dom.get('top2Top')){
			var costOwner2 = YAHOO.util.Dom.get("costOwner");
			costOwnerVal  = costOwner2.options[costOwner2.selectedIndex].value;
			
			if(costOwnerVal == null || costOwnerVal == ""){
				var top2Top2 = YAHOO.util.Dom.get("top2Top");
				var flagEmpty = false;
				for(var i=0; i< top2Top2.options.length; i++){
					if(top2Top2.options[i]=="" || top2Top2.options[i]==null){
						top2Top2.selectedIndex = i;
						flagEmpty = true;
						break;
					}
				}
				if(flagEmpty == false){
					top2Top2.options.length = 0;
					top2Top2.options[0] = new Option('--Select--', '');
					top2Top2.selectedIndex = 0;
				}
			}
 
		}		
		if(YAHOO.util.Dom.get('gSales')){
				document.getElementById('gSales').checked = false; 
				}
		if(YAHOO.util.Dom.get('dealOffered')){
				document.getElementById('dealOffered').checked = false; 
				}
		if(YAHOO.util.Dom.get('costlist')){
				document.getElementById('costlist').value = ''; 
				document.getElementById('costlist').disabled = true; 
				}		
		if(YAHOO.util.Dom.get('orderRestriction')){
				document.getElementById('orderRestriction').selectedIndex = 0; 
		}
		//Order Unit Changes
		if(YAHOO.util.Dom.get('orderUnit')){
				document.getElementById('orderUnit').selectedIndex = 0; 
		}
		//import attributes
		if(YAHOO.util.Dom.get('import')){
				document.getElementById('import').checked = false; 
				importClicked();
		}
		
		if(YAHOO.util.Dom.get('cntnSize')){
				document.getElementById('cntnSize').value = ''; 
				}
		if(YAHOO.util.Dom.get('pcikPoint')){
				document.getElementById('pcikPoint').value = ''; 
				}
		if(YAHOO.util.Dom.get('freight')){
				document.getElementById('freight').value = ''; 
				}
		if(YAHOO.util.Dom.get('minQntity')){
				document.getElementById('minQntity').value = ''; 
				}
		if(YAHOO.util.Dom.get('color')){
				document.getElementById('color').value = ''; 
				}
		if(YAHOO.util.Dom.get('incoTerms')){
				document.getElementById('incoTerms').value = ''; 
				}
		if(YAHOO.util.Dom.get('prorDate')){
				document.getElementById('prorDate').value = ''; 
				}
		if(YAHOO.util.Dom.get('rate')){
				document.getElementById('rate').value = ''; 
				}				
		if(YAHOO.util.Dom.get('minType')){
				document.getElementById('minType').value = ''; 
				}
		if(YAHOO.util.Dom.get('instoreDate')){
				document.getElementById('instoreDate').value = ''; 
				}
		if(YAHOO.util.Dom.get('hts')){
				document.getElementById('hts').value = ''; 
				}
		if(YAHOO.util.Dom.get('duty')){
				document.getElementById('duty').value = ''; 
				}
		if(YAHOO.util.Dom.get('agentPer')){
				document.getElementById('agentPer').value = ''; 
				}
		if(YAHOO.util.Dom.get('whseFlushDate')){
				document.getElementById('whseFlushDate').value = ''; 
				}
		if(YAHOO.util.Dom.get('cartMarketing')){
				document.getElementById('cartMarketing').value = ''; 
				}
		if(YAHOO.util.Dom.get('expectedweeklymovement')){
				document.getElementById('expectedweeklymovement').value = ''; 
				}
		if(YAHOO.util.Dom.get('unitCostLabel')){
				document.getElementById('unitCostLabel').innerText = '';
				}
<!-- 		if(YAHOO.util.Dom.get('costRadio')){ -->
<!-- 				document.getElementById('costRadio').checked = false; -->
<!-- 				} -->
<!-- 	    if(YAHOO.util.Dom.get('itemRadio')){ -->
<!-- 				document.getElementById('itemRadio').checked = false; -->
<!-- 				} -->
		if(YAHOO.util.Dom.get('costLinkBy')){
			document.getElementById('costLinkBy').selectedIndex  = "0";
		}
		
		if(YAHOO.util.Dom.get('hts2')){
				document.getElementById('hts2').value = ''; 
				}
		//add season and sell year
		if(YAHOO.util.Dom.get('season')){
			document.getElementById('season').value = '';
		}
		if(YAHOO.util.Dom.get('sellYear')){
			document.getElementById('sellYear').value = '';
		}
			
		//add dutyInfo
		if(YAHOO.util.Dom.get('dutyInfo')){
			document.getElementById('dutyInfo').value = '';
		}
					
		if(YAHOO.util.Dom.get('hts3')){
				document.getElementById('hts3').value = ''; 
				}
		if(YAHOO.util.Dom.get('factoryList')){
				document.getElementById('factoryList').value = ''; 
				}
		selectedVendorRowCount = null;
		selectedVendorRowCountAjax = null;
		//Change Order Unit when user clicking on Cancel [WHS] Vendor	
		if(document.getElementById('actions3')) {
			if(document.getElementById('actions3').value=='WHS' || document.getElementById('actions3').value=='BOTH') {
				changeOrderUnitDefault();
			}
		}
		if(document.getElementById("grossProfit")) {
			document.getElementById("grossProfit").innerHTML="";
		}
		if(document.getElementById("grossMargin")) {
			document.getElementById("grossMargin").innerHTML="";
		}
	}
	
	function deleteNoVendorDiv(){
		var vendorTableBody = document.getElementById("vendorTable");
		var noOfRows = vendorTableBody.rows.length;
		if(document.getElementById('noVendorDiv')){
			vendorTableBody.deleteRow(noOfRows-1);
		}
	}
	
	
	var selectedVendorRowCount;
	var selectedVendorRowCountAjax;
	
	//hook to press request ware house button after saving case and vendor
	var requestWareHouseHook = null;
	
	<c:url value="/protected/cps/add/vendorDetails?${_csrf.parameterName}=${_csrf.token}" var="vendorDetails"></c:url>
	function displayVendorDetails(cnt){
		showProgress();
		msgSelectVendorAnother = null;
		var formObject = document.getElementById('authAndDistForm');
		selectedVendorRowCountAjax = null;
		selectedVendorRowCount = cnt;
		formObject.action = "${vendorDetails}"+"&selectedCaseVOId="+getSelectedCaseID()+"&selectedVendorId="+getSelectedVendorId();	
		var callback = {
			success:function(o){
				if(!beginMorph) {
					//console.log('hide in displayVendorDetails');
				   hideProgress();
				}
				if(null == addVendorSectionHTML){
					addVendorSectionHTML = document.getElementById('vendorDetailsDiv').innerHTML;
					//document.getElementById('vendorDetailsDiv').innerHTML = "";
				}
				selectedVendorRowCount = cnt;
				document.getElementById('vendorDetailsDiv').innerHTML = "";
				document.getElementById('vendorDetailsDiv').style.display = 'none';
				document.getElementById('selectedvendorDetailsDiv').style.display = 'block';
				document.getElementById('selectedvendorDetailsDiv').innerHTML = o.responseText;
				loadScriptsFromDiv('selectedvendorDetailsDiv');
				but = new YAHOO.widget.Button("saveVendorButton");
				YAHOO.util.Event.removeListener("saveVendorButton", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveVendorButton"), "click", saveVendor);
				but = new YAHOO.widget.Button("backButton");
				YAHOO.util.Event.removeListener("backButton", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd);
				
				but = new YAHOO.widget.Button("authWHS");
				YAHOO.util.Event.removeListener("authWHS", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authWHS"), "click", reqWHSAttribute);
				//after selection of vendor	
				typeOfCall = 0;
				but = new YAHOO.widget.Button("authStore");
				YAHOO.util.Event.removeListener("authStore", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
				Calendar.setup({inputField:"whseFlushDate",ifFormat:"%m/%d/%Y",button:"flushDate",align:"T1",singleClick:true});
				Calendar.setup({inputField:"instoreDate",ifFormat:"%m/%d/%Y",button:"storeDate",align:"T1",singleClick:true});
                Calendar.setup({inputField:"prorDate",ifFormat:"%m/%d/%Y",button:"propDate",align:"T1",singleClick:true});
				Calendar.setup({inputField:"freight",ifFormat:"%m/%d/%Y",button:"freights",align:"T1",singleClick:true});
				Calendar.setup({inputField:"duty",ifFormat:"%m/%d/%Y",button:"dutyCalend",align:"T1",singleClick:true});
				
				//R2
				but = new YAHOO.widget.Button("importFacilities");
				YAHOO.util.Event.removeListener("importFacilities", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("importFacilities"), "click", importFacilities);
				//R2
				
				if(vendorSelectionCaseHook != null){
					vendorSelectionCaseHook();
					vendorSelectionCaseHook = null;
				}
				if(requestWareHouseHook != null){
					var tmp = requestWareHouseHook;
					requestWareHouseHook = null;
					tmp();
				}
				selectChannelAjax();
				getVendorChannelType();
				typeOfCall = 0;
				//1205
				disableAddEditDelVendorBtns(false);
			},
			failure:function(o){
				selectChannelAjax();
				hideProgress();
			}
		};		
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
	}
	
	var selCaseUniqueIdSelected = null;
	function deleteVendorDetails(evt){
		if(confirm('You really want to delete this vendor?')){
			var selVendorUniqueId = getSelectedVendorId();
			var selCaseUniqueId = getSelectedCaseID();
			if(null != selCaseUniqueId && null != selVendorUniqueId){
				if(isWHSDSDeDC()){
					alert("An eDC Vendor can not be deleted.");
					return;
				}
				showProgress();
				unAuthorizedStore706 = false;
				selCaseUniqueIdSelected = selCaseUniqueId;
				AddCandidateTemp.removeVendor(selVendorUniqueId,selCaseUniqueId,getDWRCallbackMethod(deleteSelVendorRowFromTable));
			}
		}
	}
	
	function deleteSelVendorRowFromTable(data){
		//hideProgress();
		if(document.getElementById("conflictMessage")!=null) {
	    	document.getElementById("conflictMessage").innerText="";
		}
		var selVendorUniqueId  = "";
		var selRowId = getSelectedVendorRowId();
		var tBody = document.getElementById('vendorTable');
		for(var i=0;i < tBody.rows.length;i++){
			if( tBody.rows[i].id == selRowId){
				tBody.deleteRow(i);
				colorTableRows('vendorTable');
				break;
			}
		}
		//Begin fixing QC-30
		var tBody = document.getElementById('vendorTable');
		for(var i=0;i < tBody.rows.length;i++){
			if(tBody.rows[i].id.indexOf('vendorRow')==0) {
				selVendorUniqueId  +=document.getElementById('vendorUniq'+tBody.rows[i].id.split('vendorRow')[1]).value+"_"; 
				//break;
			} else if(tBody.rows[i].id.indexOf('vendorAjaxRow')==0) {
				selVendorUniqueId  += document.getElementById('vendorUniqAjax'+tBody.rows[i].id.split('vendorAjaxRow')[1]).value+"_"; 
				//break;
			}
		}

		//End fixing QC-30
		// remove case item eDC from table
		if(data != null){
			if(data.psItemWHSeDC != null){
				var psitem = myTrim(data.psItemWHSeDC);
				var caseTbl = document.getElementById('caseItemTbody');
				for(var i = 0; i < caseTbl.rows.length; i++){
					var psitemid = caseTbl.rows[i].cells[caseTbl.rows[i].cells.length - 1].innerHTML;
					if(psitemid.indexOf(psitem) != -1){
						caseTbl.deleteRow(i);
						colorTableRows('caseItemTbody');
						break;
					}
				}
				resetScreenOnDeleteCase();
				
				// Just select the first row.if there is any row else disable the add case button.
				if(document.getElementById('caseItemTbody').rows.length > 0){
					document.getElementById('caseItemTbody').rows[0].onclick();
		
					if(document.getElementById('addCaseBut')) {
						document.getElementById('addCaseBut').disabled = false;
					}	
					
					if(document.getElementById('editCaseBut')){
						document.getElementById('editCaseBut').disabled = false;	
					}
					
					if(document.getElementById('deleteBut')){
						document.getElementById('deleteBut').disabled = false;			
					}
				
				}else{
					if(document.getElementById('addCaseBut')) {
						document.getElementById('addCaseBut').disabled = true;
					}	
				
					if(document.getElementById('editCaseBut')){
						document.getElementById('editCaseBut').disabled = true;	
					}
					
					if(document.getElementById('deleteBut')){
						document.getElementById('deleteBut').disabled = true;			
					}
					YAHOO.util.Event.addListener(YAHOO.util.Dom.get("AVupc"), "click", addCaseDetailsToTable);
					YAHOO.util.Event.addListener(YAHOO.util.Dom.get("cancelBut"), "click", clearCaseItemDetails);
					AddCandidateTemp.getProductDescription(getDWRCallbackMethod(setCaseDescription));
				}
				
				
			}
		}
		var tBody = document.getElementById('vendorTable');
		var noOfRows = tBody.rows.length;
		if(noOfRows > 1){
			tBody.rows[1].click();
		}
		if(noOfRows == 1){
			document.getElementById('deleteVendorDetailsButDiv').style.display = 'none';
			document.getElementById('editVendorDetailsButDiv').style.display = 'none';
			showVendorDetailsToAdd();
			YAHOO.util.Event.removeListener("vendorCancel", "click");
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("vendorCancel"), "click", clearVendorDetails);
			YAHOO.util.Event.removeListener("backButton", "click");
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd); 
		}
		//enableActivation();
		//Begin fixing QC-30
		//var selCaseUniqueId = getSelectedCaseID();	
		if("" != selVendorUniqueId && null != selCaseUniqueIdSelected){
			showProgress();
			beginMorph = true;
			selVendorUniqueId = selVendorUniqueId.substring(0,selVendorUniqueId.length-1);
			AddCandidateTemp.beforeMorph(selVendorUniqueId,selCaseUniqueIdSelected,unAuthorizedStore706,"",getDWRCallbackMethod(afterBeforeMorph));
			//End fixing QC-30
		} else {
			AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligible));
		}
	}
	function getSelectedVendorId(){
		if(selectedVendorRowCount != null 
			&& document.getElementById('vendorUniq'+selectedVendorRowCount) != null){
			return document.getElementById('vendorUniq'+selectedVendorRowCount).value;
		}else if(selectedVendorRowCountAjax != null
			&& document.getElementById("vendorUniqAjax"+selectedVendorRowCountAjax) != null){
			return document.getElementById("vendorUniqAjax"+selectedVendorRowCountAjax).value;
		}else{
			return null;
		}		
	}
	
	function getSelectedVendorRowId(){
		if(selectedVendorRowCount != null){
			return 'vendorRow'+selectedVendorRowCount;
		}else if(selectedVendorRowCountAjax != null){
			return 'vendorAjaxRow'+selectedVendorRowCountAjax;
		}else{
			return null;
		}		
	}
	
	var addVendorSectionHTML = null;
	function showVendorDetailsToAdd(evt){
		if(isWHSDSDeDC()){
			alert("Cannot add new vendor for an eDC item.");
			return;
		}
		validateSubDept();
		document.getElementById('selectedvendorDetailsDiv').innerHTML = "";
		document.getElementById('selectedvendorDetailsDiv').style.display = 'none';
		document.getElementById('vendorDetailsDiv').style.display = 'block';
		if(addVendorSectionHTML != null ){
			document.getElementById('vendorDetailsDiv').innerHTML = "";
			document.getElementById('vendorDetailsDiv').innerHTML = addVendorSectionHTML;
			loadScriptsFromDiv('vendorDetailsDiv');
			//addVendorSectionHTML = null;
		}
		clearVendorDetails();
<!-- 		QC 1594 14/10/2014 setDateDefaultVendorDetails -->
		setDateDefaultVendorDetails();
<!-- 		end QC 1594-->
		fillVendorDetails();		
		selectChannelAjax();
		if(document.getElementById('listCost')){ 
			document.getElementById('listCost').disabled = false;
		}
		YAHOO.util.Event.removeListener("addButton6", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", addVendor);
		YAHOO.util.Event.removeListener("authStore", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
		Calendar.setup({inputField:"whseFlushDate",ifFormat:"%m/%d/%Y",button:"flushDate",align:"T1",singleClick:true});

//Why done thrice???
//		YAHOO.util.Event.removeListener("authStore", "click");
//				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
		Calendar.setup({inputField:"instoreDate",ifFormat:"%m/%d/%Y",button:"storeDate",align:"T1",singleClick:true});
//		YAHOO.util.Event.removeListener("authStore", "click");
//				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
		Calendar.setup({inputField:"prorDate",ifFormat:"%m/%d/%Y",button:"propDate",align:"T1",singleClick:true});
		Calendar.setup({inputField:"freight",ifFormat:"%m/%d/%Y",button:"freights",align:"T1",singleClick:true});
		Calendar.setup({inputField:"duty",ifFormat:"%m/%d/%Y",button:"dutyCalend",align:"T1",singleClick:true});
		YAHOO.util.Dom.get("seasonality").value="13";
		
		but = new YAHOO.widget.Button("importFacilities");
		YAHOO.util.Event.removeListener("importFacilities", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("importFacilities"), "click", importFacilities);

		if(document.getElementById('enableAuthorizeWHS')){
			document.getElementById('enableAuthorizeWHS').style.display = "none";
			document.getElementById('enableFactoryDiv').style.display = "none";
		}
		if(document.getElementById('enableAuthorizeStore')){
			document.getElementById('enableAuthorizeStore').style.display = "none";
		}
		
		selectedVendorRowCount = null;
		selectedVendorRowCountAjax = null;
		
		//1205 Edit Case Edit Vendor
		//Disabled "Edit" and "Delete" button for vendor when click to "Add"
		document.getElementById('editVendorDetailsBut').disabled = true;
		document.getElementById('deleteVendorDetailsBut').disabled = true;
		//HoangVT - disable "Add" button also
		document.getElementById('addCaseDetailsBut').disabled = true;
		if(document.getElementById('vendorCancel')){
			new YAHOO.widget.Button('vendorCancel');
			YAHOO.util.Event.removeListener("vendorCancel", "click");
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("vendorCancel"), "click", clearVendorDetails);
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("vendorCancel"), "click", onVendorCancelClick);
		}
		if(document.getElementById('backButton')){
			new YAHOO.widget.Button("backButton",{disabled:false});			
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd);
		}		
		YAHOO.util.Event.removeListener("reqAttribute", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("reqAttribute"), "click", reqAttributeClick);	
		//Change Order Unit when user clicking on Add [WHS] Vendor	
		if(document.getElementById('actions3')) {
			if(document.getElementById('actions3').value=='WHS' || document.getElementById('actions3').value=='BOTH') {
				changeOrderUnitDefault();
			}
		}
		if(document.getElementById("grossProfit")) {
			document.getElementById("grossProfit").innerHTML="";
		}
		if(document.getElementById("grossMargin")) {
			document.getElementById("grossMargin").innerHTML="";
		}
		var profitWarning = document.getElementById("profitWarning");
		var marginWarningIdAjax = document.getElementById("marginWarningIdAjax");
		var retailFor=document.getElementById('retailFor');
		if(retailFor!=null && (retailFor.value=="" || retailFor.value==0)) {
			if(profitWarning!=null) {
			   profitWarning.style.display = "block";
			}
			if(marginWarningIdAjax!=null) {
				marginWarningIdAjax.value="% Margin and Penny Profit are blank. Please enter Retail For value greater than 0.";
			}
		} else {
			if(profitWarning!=null) {
			   profitWarning.style.display = "none";
	        }
		}
		
		// PIM-1527 Kit component - display list cost
		initKitCostOfKitComponents();
	}
	
	function displayVendorDetailsAjax(cnt,stopProgress){
		showProgress();
		var formObject = document.getElementById('authAndDistForm');
		selectedVendorRowCount = null;
		selectedVendorRowCountAjax = cnt;
		formObject.action = "${vendorDetails}"+"&selectedCaseVOId="+getSelectedCaseID()+"&selectedVendorId="+getSelectedVendorId();
		var callback = {
			success:function(o){
				var vendorTableBody = document.getElementById("vendorTable");
				var rowLength = 1;
				if(vendorTableBody!=null) {
					rowLength = vendorTableBody.rows.length;
				}
				if((isVendorCancelClick != null && stopProgress) || (document.getElementById('vendorAjaxRow'+cnt)!=null && !beginMorph)){
					hideProgress();
				}
				if(null == addVendorSectionHTML){
					addVendorSectionHTML = document.getElementById('vendorDetailsDiv').innerHTML;
					//document.getElementById('vendorDetailsDiv').innerHTML = "";
				}
				selectedVendorRowCountAjax = cnt;
				document.getElementById('vendorDetailsDiv').innerHTML = "";
				document.getElementById('vendorDetailsDiv').style.display = 'none';
				document.getElementById('selectedvendorDetailsDiv').style.display = 'block';
				document.getElementById('selectedvendorDetailsDiv').innerHTML = o.responseText;
				loadScriptsFromDiv('selectedvendorDetailsDiv');
				but = new YAHOO.widget.Button("saveVendorButton");
				YAHOO.util.Event.removeListener("saveVendorButton", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveVendorButton"), "click", saveVendor);
				but = new YAHOO.widget.Button("backButton");
				YAHOO.util.Event.removeListener("backButton", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd); 
				
				but = new YAHOO.widget.Button("authWHS");
				YAHOO.util.Event.removeListener("authWHS", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authWHS"), "click", reqWHSAttribute);	
				typeOfCall = 0;
				YAHOO.util.Event.removeListener("authStore", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
				Calendar.setup({inputField:"whseFlushDate",ifFormat:"%m/%d/%Y",button:"flushDate",align:"T1",singleClick:true});

//Why done thrice???				
//				but = new YAHOO.widget.Button("authStore");
//				YAHOO.util.Event.removeListener("authStore", "click");
//				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
				Calendar.setup({inputField:"instoreDate",ifFormat:"%m/%d/%Y",button:"storeDate",align:"T1",singleClick:true});
				
//				YAHOO.util.Event.removeListener("authStore", "click");
//				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
				Calendar.setup({inputField:"prorDate",ifFormat:"%m/%d/%Y",button:"propDate",align:"T1",singleClick:true});
				Calendar.setup({inputField:"freight",ifFormat:"%m/%d/%Y",button:"freights",align:"T1",singleClick:true});
				Calendar.setup({inputField:"duty",ifFormat:"%m/%d/%Y",button:"dutyCalend",align:"T1",singleClick:true});
				//R2
				but = new YAHOO.widget.Button("importFacilities");
				YAHOO.util.Event.removeListener("importFacilities", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("importFacilities"), "click", importFacilities);
				//R2
				

				if(vendorSelectionCaseHook != null){
					vendorSelectionCaseHook();
					vendorSelectionCaseHook = null;
				}
				if(requestWareHouseHook != null){
					var tmp = requestWareHouseHook;
					requestWareHouseHook = null;
					tmp();
				}
				selectChannelAjax();
				getVendorChannelType();
				typeOfCall = 0;
				//#1205
				disableAddEditDelVendorBtns(false);
			},
			failure:function(o){
				selectChannelAjax();
				hideProgress();
			}		
		};		
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
	}
	
	function deleteVendor(evt, cnt){
		var uniq = document.getElementById('hid'+cnt).value;
		document.getElementById('vendorTable').deleteRow( document.getElementById('ajaxRow'+cnt).rowIndex );
		var caseId = document.getElementById('caseVOUniqueId'+selectedCaseRowCount).value;
		AddCandidateTemp.removeVendor(uniq,caseId,getDWRCallbackMethod(removeRow));
	}
	
	function removeRow(data){
	 var vendorTableclicked = true;
	 //function colortable is in common.js
		colorTable(vendorTableclicked,'','');
		//AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligibleWithoutProcessBar));
	}
	
	function makeFirstItemClicked(evt){
		if(document.getElementById('caseRow0')){
			var initFun = function(){ document.getElementById('caseRow0').onclick(); };
			//alert('first item.  funct: '+initFun);
			execAfterPageLoad(initFun);
		}else if(document.getElementById('addCaseBut')){
			document.getElementById('addCaseBut').onclick();
		}
	}
	
	function saveCaseAndVendor(evt){
		if(document.getElementById('vendorACInput').value == null ||
			document.getElementById('vendorACInput').value == ""){
			alert("Please input a vendor.");
			return;
		}
		
		if(document.getElementById('listCost').value == null ||
			document.getElementById('listCost').value == ""){
			alert("Please input a list cost.");
			return;
		}
		
		if(msgSelectVendorAnother != null){
			alert(msgSelectVendorAnother);
			return;
		}
		
		//HoangVT - trim string blank in text field before save
		if(document.getElementById('cartMarketing'))
			YAHOO.util.Dom.get('cartMarketing').value = trim(YAHOO.util.Dom.get('cartMarketing').value);
		if(document.getElementById('dutyInfo'))
			YAHOO.util.Dom.get('dutyInfo').value = trim(YAHOO.util.Dom.get('dutyInfo').value);
		if(document.getElementById('pcikPoint'))
			YAHOO.util.Dom.get('pcikPoint').value = trim(YAHOO.util.Dom.get('pcikPoint').value);
	
		//setting case Hook and saving case
				
		//var sel = document.getElementById('vendorLocationVal');
		//var uniqueVendorIndex = sel.value;		
		//var importd=false;
		//if(YAHOO.util.Dom.get('import')){
			//importd = YAHOO.util.Dom.get("import").checked;
		//}
		//AddCandidateTemp.checkWareHouseExist(uniqueVendorIndex,getSelectedCaseID(),getDWRCallbackMethod(checkExistWareHouse));
		//if(authenWHScheck) 
		//{	
			//if(importd)		
			//if(!checkFactorylist()) {alert("please select Import Factory") ;return false;}
		//}
		if(checkValidImportVO())
		{
			if(document.getElementById('selectedCaseUniqueId') == null ||
					document.getElementById('selectedCaseUniqueId').value == '') {	
				caseHook = afterAddingCase;
				addCaseDetailsToTable(evt,false);
				//console.log('afterAddingCase');
			}else{
				var vendorUniqueId = document.getElementById('selectedVendorUniqId');
				if (vendorUniqueId == null || vendorUniqueId.value == ''){
					caseHook = addVendorWithoutTableChange;
				}else{
					caseHook = saveVendor;
				}
				//console.log('saveCaseAndVendor');
				updateCaseDetails(evt,true);
			}
		}
		else
		{
				alert("All the fields should be mandatory except (Duty Info, HTS2, HTS3, Warehouse Flush Date, Instore date and Proration Date).");
		}	
<!-- 		AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligible)); -->
	}
	
	function afterAddingCase(){
		//for getting case unique if for adding vendor
		
		selectedCaseRowCount = null;
		if(addedCaseRowIsAjax){
			selectedCaseRowCountAjax = addedCaseRowCount;
			selectedCaseRowCount = null;
		}else{
			selectedCaseRowCount = addedCaseRowCount;
			selectedCaseRowCountAjax = null;
		}
		showProgress();
		addVendorWithoutTableChange();
	}
	
	function addVendorWithoutTableChange(){
		var vendorVO = getCurrentVendorVO();
		if(getSelectedCaseID()){
			showProgress();
			AddCandidateTemp.addVendorVO(vendorVO,getSelectedCaseID(),getDWRCallbackMethod(selectTheCaseAdded));
		}
	}
	
	var caseAndVendorHook = null;
	var beginMorph=false;
	function selectTheCaseAdded(data){
		//hideProgress();
		if(addCaseDetailsData == null){
			addCaseDetailsData = document.getElementById('details').innerHTML;
			document.getElementById('details').innerHTML = "";
		}
		if(document.getElementById("ajaxCase"+addedCaseRowCount)){
			document.getElementById("ajaxCase"+addedCaseRowCount).onclick();
		}
		var selVendorUniqueId  = data.uniqueId;
		if(caseAndVendorHook != null){
			var selCaseUniqueId = getSelectedCaseID();
			if(null != selVendorUniqueId && null != selCaseUniqueId){
				showProgress();
				beginMorph = true;
				AddCandidateTemp.beforeMorph(selVendorUniqueId,selCaseUniqueId,false,"",getDWRCallbackMethod(afterBeforeMorph));
			}else{
				var tmp = caseAndVendorHook;
				caseAndVendorHook = null;
				tmp();
				AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligible));
			}
		}else{
			<!-- var selVendorUniqueId = getSelectedVendorId(); -->
			
			var selCaseUniqueId = getSelectedCaseID();
			if(null != selVendorUniqueId && null != selCaseUniqueId){
				showProgress();
				beginMorph = true;
				AddCandidateTemp.beforeMorph(selVendorUniqueId,selCaseUniqueId,false,"",getDWRCallbackMethod(afterBeforeMorph));
			}else{
				AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligible));
			}
		}
	}
	//*************************************** Functions For MRT - UseCase******************************************************************//
	
	var selectedMRTVendorRowCount;
	var selectedMRTVendorRowCountAjax;
	
	function getSelectedVendorIdForMRT(){		
		if(selectedMRTVendorRowCount != null){		
			if(document.getElementById('vendorUniq'+selectedMRTVendorRowCount)){
				return document.getElementById('vendorUniq'+selectedMRTVendorRowCount).value;
			} else {
			return null;
			}
		}else if(selectedMRTVendorRowCountAjax != null){			
			if(document.getElementById("vendorUniqAjax"+selectedMRTVendorRowCountAjax)){
				return document.getElementById("vendorUniqAjax"+selectedMRTVendorRowCountAjax).value;
			} else {
				return null;
			}
		}else{
			return null;
		}		
	}
	
	function insertMRTCase(){
			var rows = YAHOO.util.Dom.get("mrtTable").rows.length;
			if(rows == 1) {
				alert("MRT's MUST have more than 1 element.");
				return;
			}
			if(checkDRUMRT()) return;
			if(validCodeDate()){
						if(document.getElementById('actions3')){
											var channelSelectBox = document.getElementById('actions3');
											var selValue = channelSelectBox.options[channelSelectBox.selectedIndex].value;
							if(selValue == '-1'){
								alert('Please select a channel to save the case');
								return;
							}
							}
				var caseVO = getCurrentCaseObject();
				var caseText = YAHOO.util.Dom.get("caseUpcText");
			    var caseCheck = YAHOO.util.Dom.get("caseCheckDigit");	
			    var caseTextValue = caseText.value;
		        var caseCheckValue = caseCheck.value;
				var val = true;
				if(caseTextValue=="" || null == caseTextValue){
				alert('Please enter the Case UPC value');
				}
				// else if(caseCheckValue=="" || null == caseCheckValue){
				// showProgress();
				// onCheckDigitSuccessMrt(val,caseVO);
				//} 
		        else if(caseCheckValue!="" && null != caseCheckValue) {
			     showProgress();
			     AddCandidateTemp.verifyCheckDigit(caseTextValue,caseCheckValue,getDWRCallbackMethod(function(data){
			     	onCheckDigitSuccessMrt(data,caseVO);
			     }));
		       }
			    else if(caseTextValue != null && caseTextValue != "" && (caseCheckValue == null || caseCheckValue == "") ){
					alert('Please enter the Check Digit');
				  }
				//Change Order Unit when user clicking on Add [WHS] Vendor	
				if(document.getElementById('actions3')) {
					if(document.getElementById('actions3').value=='WHS' || document.getElementById('actions3').value=='BOTH') {
						changeOrderUnitDefault();
					}
				}
			}
	}
	
	function verifyCheckDigitForCaseUPCMRT(){						
		var caseText = YAHOO.util.Dom.get("caseUpcText");
		var caseCheck = YAHOO.util.Dom.get("caseCheckDigit");
		var caseTextValue = caseText.value;
		var caseCheckValue = caseCheck.value;
	    if(caseCheckValue!="" && null != caseCheckValue) {
	    	if(isNaN(caseTextValue)){
   				alert("Case UPC Must be Number");
   				caseTextValue.value = "";
   				return;
   			} else if(isNaN(caseCheckValue)){
   				alert("Check Digit Must be Number");
   				caseCheckValue.value = "";
   				return;
   			} else {
		     showProgress();
		     AddCandidateTemp.verifyCheckDigitForCase(caseTextValue,caseCheckValue,getDWRCallbackMethod(function(data){
		     	hideProgress();
				  if(!data) {
						alert('InValid Check Digit. Please Re-enter the UPC/Checkdigit Value');
						document.getElementById('caseCheckDigit').value = '';
				         document.getElementById('caseUpcText').focus();
						document.getElementById('caseUpcText').select();
						return false;
				  }else{
					  showProgress();
					  AddCandidateTemp.isExistingUPC(caseTextValue, getDWRCallbackMethod(caseUPCExistsForMRT, data));
				  }
		     }));
	    }
	    }
	    else if(caseTextValue != null && caseTextValue != "" && (caseCheckValue == null || caseCheckValue == "") ){
			alert('Please enter the Check Digit');
			return false;
		} else if(caseTextValue == null || caseTextValue == ""){
				alert("Please enter Case UPC");
   				caseTextValue.value = "";
   				return;
		}		
	}	

	function caseUPCExistsForMRT(data){
		hideProgress();		
		if(data != null && data != ""){			
			document.getElementById('caseCheckDigit').value = '';
			document.getElementById('caseUpcText').focus();
			document.getElementById('caseUpcText').select();	
			return false;	
		}
		else
		{
			isValidCaseUpc=true;	
			insertMRTCase();	
		}
	}
	
	
	function onCheckDigitSuccessMrt(data,caseVO){
	hideProgress();
		  if(!data) {
				alert('InValid Check Digit. Please Re-enter the UPC/Checkdigit Value');
				document.getElementById('caseCheckDigit').value = '';
		         document.getElementById('caseUpcText').focus();
				document.getElementById('caseUpcText').select();
		  }
		  else{
			  showProgress();
	
	AddCandidateTemp.addMRTCaseVO(caseVO,getDWRCallbackMethod(checkdata));
	}
	}
	function checkdata(data){
	          hideProgress();
	          if(data.message !="" && data.message !=null){
	             alert(data.message);
	             document.getElementById("mrtMessage").innerText="";
	          }else {
	          document.getElementById('actions3').disabled = true;
	          if(document.getElementById('errors')!=null) {
	          	document.getElementById('errors').style.display='none';
	          }
	          document.getElementById("mrtMessage").innerText="        Case Saved Successfully";
		          if(document.getElementById('catchRadio').checked) 
		          {
		          	document.getElementById('catchRadio').checked =true;
		          }
		          else if(document.getElementById('variableRadio').checked)
		          {
		          	document.getElementById('variableRadio').checked =true;
		          }
		          else
		          {
		         	 document.getElementById('noneRadio').checked =true;
		          }
				  
				//Enable activate button
				 //enableActivationCBForMRT();	
				  enablePrintFormForMRT();
	          }
	}
	function addMRTVendor(evt){
	  if(document.getElementById('actions3'))
	  {
		var channelSelectBox = document.getElementById('actions3');
		var selValue = channelSelectBox.options[channelSelectBox.selectedIndex].value;
		if(selValue == ''  || selValue == '-1'){
			alert('Please select a channel to save the case');
			return;
		}else {
				var caseText = YAHOO.util.Dom.get("caseUpcText");
				var caseCheck = YAHOO.util.Dom.get("caseCheckDigit");
				var caseTextValue = caseText.value;
				var caseCheckValue = caseCheck.value;
				
				if(caseTextValue != null && caseTextValue != "" && (caseCheckValue == null || caseCheckValue == "") ){
					alert('Please enter the Check Digit');
					return false;
				} else if(caseTextValue == null || caseTextValue == ""){
						alert("Please enter Case UPC");
						caseTextValue.value = "";
						return;
				}		
		}
	  }
	  
	if(checkValidImportVO())
		{
			if(validCodeDate()){
			showProgress();
			var caseVO = getCurrentCaseObject();	 
			AddCandidateTemp.addMRTCaseVO(caseVO,getDWRCallbackMethod(saveMRTandCase));
		}
		}
		else
		{
			alert("All the fields should be mandatory except (Duty Info, HTS2, HTS3, Warehouse Flush Date, Instore date and Proration Date).");
		}		
	}
	function saveMRTandCase(evt){
			if(validCodeDate()){
		        if(evt.message !="" && evt.message !=null){
		             hideProgress();
		             alert(evt.message);
		             return;
		          }
		          else {
		            document.getElementById('actions3').disabled = true;
		            var vendorVO = getCurrentVendorVO();
					AddCandidateTemp.addMRTVendorVO(vendorVO,getDWRCallbackMethod(addRowToVendorTableForMrt));
		          }
		     }else{
                hideProgress();
                }
	}
	var mrtVendorHook = null;
	var newlyAddedMRTVendorRowShouldBeClicked = false;
	function addRowToVendorTableForMrt(data){
		hideProgress();
		deleteNoVendorDiv();
		var cnt = addCountVendor++;	
		var cnt = addCountVendor;
		var vendorTableBody = document.getElementById("vendorTable");
		var rowLength = vendorTableBody.rows.length; 
		var newRow = vendorTableBody.insertRow(-1);
		newRow.id="vendorAjaxRow"+addCountVendor;
		newRow.style.fontFamily = 'Verdana, Arial, Helvetica, sans-serif';
		newRow.style.fontSize = '12px';	
		newRow.onclick = function() { makeRowClickedForTable('vendorTable','vendorAjaxRow'+cnt,cnt,'#FFAA00');
									  displayMRTVendorDetailsAjax(cnt); };	
		var classAppend = rowLength % 2;
		var col;
		if(classAppend == 0){
			col = "#FEEADA";
		}else{
			col = "#FFF9F4";
		}
		newRow.style.backgroundColor = col;
		rowLength--;
		
		var butId = "deleteButtonAjax"+addCountVendor;
		
		<c:url var="img" value="${request.getContextPath()}/hebAssets/images/newButtons/delete_normal.gif"/>
		<c:url var="imgOver" value="${request.getContextPath()}/hebAssets/images/newButtons/delete_mouseclick.gif"/>
		
		var but = "<div><a id='link"+addCountVendor+"'>" +
					"<img src='${img}' alt='' name='"+butId+"'  border='0' id='"+butId+"'>"+
				"</a></div>";
		var chk = null;
		if(data.upcScenario){
			chk = "<input type='checkbox' id='checkAjax"+addCountVendor+"' disabled='disabled' checked = 'checked'>";
		}else{
			chk = "<input type='checkbox' id='checkAjax"+addCountVendor+"' disabled='disabled'>";
		}
		
		var rad = null;
		if(data.upcRadio){
			rad = "<input type='radio' id='checkAjax"+addCountVendor+"' disabled='disabled' checked = 'checked'>";
		}else{
			rad = "<input type='radio' id='checkAjax"+addCountVendor+"' disabled='disabled'>";
		}
		
		var inptUniq = '<input type="hidden" id="vendorUniqAjax'+addCountVendor+'" value="'+data.uniqueId+'"/>';
		
		var guarSaleCheckBox = null;
		if(data.guarenteedSale){
			guarSaleCheckBox = '<input type="checkbox" disabled="true" checked id="guarSale'+cnt+'"/>';
		} else{
			guarSaleCheckBox = '<input type="checkbox" disabled="true"  id="guarSale'+cnt+'"/>';
		}
		var dealOffered = null;
		if(data.dealOffered){
			dealOffered = '<input type="checkbox" disabled="true" checked  id="dealOff'+cnt+'"/>';
		} else{
			dealOffered = '<input type="checkbox" disabled="true" id="dealOff'+cnt+'"/>';
		}

		var rowData = [
		//'', 
		data.vendorLocation,
		//data.vendorNumber,
		data.vpc,
		guarSaleCheckBox+' <input type="hidden" id="hid'+addCountVendor+'" value="'+data.uniqueId+'" />',
		dealOffered + inptUniq,
		data.listCost,
	//	data.unitCost,
	//	'<input type="checkbox" id="ajaxImport'+addCountVendor+'" onclick="importFn();"/>',
		data.costOwner,
		data.top2Top,
		data.countryOfOrigin,
	//	data.seasonality,
	//	data.seasonalityYear,
		data.channelByLocation,
		''
		];
		for (var i = 0; i < rowData.length; i++) {
	        newCell = newRow.insertCell(i);
	        newCell.style.backgroundColor = col;
	        newCell.innerHTML = rowData[i];
   		}
		YAHOO.util.Event.removeListener(butId, "click");
		YAHOO.util.Event.addListener(document.getElementById(butId), "click", deleteVendor,addCountVendor);
		if(!newlyAddedMRTVendorRowShouldBeClicked){
				newRow.click();
		}
		if(newlyAddedMRTVendorRowShouldBeClicked){
			newlyAddedMRTVendorRowShouldBeClicked = false;
			newRow.click();
		}
		//Enable activate button
		//enableActivationCBForMRT();
		if(document.getElementById('activateButton')!=null) 
			document.getElementById('activateButton').disabled = false;
		try{
		clearVendorDetails();
		}catch(e){}
	}
	
	
	<c:url value="/protected/cps/add/vendorMRTDetails?${_csrf.parameterName}=${_csrf.token}" var="Mlink"></c:url>
	function displayMRTVendorDetails(cnt){
		showProgress();
		var formObject = document.getElementById('mrtForm');
		selectedMRTVendorRowCountAjax = null;
		selectedMRTVendorRowCount = cnt;
		formObject.action = "${Mlink}"+"&selectedMRTVendorId="+getSelectedVendorIdForMRT();
		var callback = {
			success:function(o){
				hideProgress();
				if(null == addVendorSectionHTML){
					addVendorSectionHTML = document.getElementById('vendorDetailsDiv').innerHTML;
					//document.getElementById('vendorDetailsDiv').innerHTML = "";
				}
				document.getElementById('vendorDetailsDiv').innerHTML = "";
				document.getElementById('vendorDetailsDiv').style.display = 'none';
				document.getElementById('selectedvendorDetailsDiv').style.display = 'block';
				document.getElementById('selectedvendorDetailsDiv').innerHTML = o.responseText;
				loadScriptsFromDiv('selectedvendorDetailsDiv');
				if(document.getElementById('vendorACInput')){
					document.getElementById('vendorACInput').disabled = true;
				}
				but = new YAHOO.widget.Button("saveVendorButton");
				YAHOO.util.Event.removeListener("saveVendorButton", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveVendorButton"), "click", saveVendorForMrt);
				but = new YAHOO.widget.Button("authWHS");
			  	YAHOO.util.Event.removeListener("authWHS", "click");
			  	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authWHS"), "click", reqWHSAttributeMrtDirect);
				//after selection of vendor	
				typeOfCall = 0;
				but = new YAHOO.widget.Button("authStore");
			  	YAHOO.util.Event.removeListener("authStore", "click");
			  	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAfterSavingCaseMrt);
			  	Calendar.setup({inputField:"whseFlushDate",ifFormat:"%m/%d/%Y",button:"flushDate",align:"T1",singleClick:true});
				Calendar.setup({inputField:"instoreDate",ifFormat:"%m/%d/%Y",button:"storeDate",align:"T1",singleClick:true});
				Calendar.setup({inputField:"freight",ifFormat:"%m/%d/%Y",button:"freights",align:"T1",singleClick:true});
                Calendar.setup({inputField:"prorDate",ifFormat:"%m/%d/%Y",button:"propDate",align:"T1",singleClick:true});
                Calendar.setup({inputField:"duty",ifFormat:"%m/%d/%Y",button:"dutyCalend",align:"T1",singleClick:true});

				//R2
				but = new YAHOO.widget.Button("importFacilities");
				YAHOO.util.Event.removeListener("importFacilities", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("importFacilities"), "click", importFacilitiesMRT);
				//R2
				


			  	if(mrtVendorHook != null){
					var tmp = mrtVendorHook;
					mrtVendorHook = null;
					tmp();
				}
				setMrtCall();
				getVendorChannelTypeBetween();
				typeOfCall = 0;
				enableButtonsViewMRTProduct();
			}
		};
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
	}
	
	function displayMRTVendorDetailsAjax(cnt){
		showProgress();
		var formObject = document.getElementById('mrtForm');
		selectedMRTVendorRowCountAjax = cnt;
		selectedMRTVendorRowCount = null;
		formObject.action = "${Mlink}"+"&selectedMRTVendorId="+getSelectedVendorIdForMRT();
		var callback = {
			success:function(o){
				hideProgress();
				if(null == addVendorSectionHTML){
					addVendorSectionHTML = document.getElementById('vendorDetailsDiv').innerHTML;
					//document.getElementById('vendorDetailsDiv').innerHTML = "";
				}
				document.getElementById('vendorDetailsDiv').innerHTML = "";
				document.getElementById('vendorDetailsDiv').style.display = 'none';
				document.getElementById('selectedvendorDetailsDiv').style.display = 'block';
				document.getElementById('selectedvendorDetailsDiv').innerHTML = o.responseText;
			
				loadScriptsFromDiv('selectedvendorDetailsDiv');
				document.getElementById('vendorACInput').disabled = true;
				but = new YAHOO.widget.Button("saveVendorButton");
				YAHOO.util.Event.removeListener("saveVendorButton", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveVendorButton"), "click", saveVendorForMrt);
				but = new YAHOO.widget.Button("authWHS");
			  	YAHOO.util.Event.removeListener("authWHS", "click");
			  	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authWHS"), "click", reqWHSAttributeMrtDirect);
				//after selection of vendor	
				typeOfCall = 0;
			   	YAHOO.util.Event.removeListener("authStore", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAfterSavingCaseMrt);
				Calendar.setup({inputField:"whseFlushDate",ifFormat:"%m/%d/%Y",button:"flushDate",align:"T1",singleClick:true});
				
				but = new YAHOO.widget.Button("authStore");
				YAHOO.util.Event.removeListener("authStore", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAfterSavingCaseMrt);
				Calendar.setup({inputField:"instoreDate",ifFormat:"%m/%d/%Y",button:"storeDate",align:"T1",singleClick:true});
				
				YAHOO.util.Event.removeListener("authStore", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAfterSavingCaseMrt);
				Calendar.setup({inputField:"prorDate",ifFormat:"%m/%d/%Y",button:"propDate",align:"T1",singleClick:true});
				
			  	YAHOO.util.Event.removeListener("authStore", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAfterSavingCaseMrt);
				Calendar.setup({inputField:"freight",ifFormat:"%m/%d/%Y",button:"freights",align:"T1",singleClick:true});
				
				YAHOO.util.Event.removeListener("authStore", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAfterSavingCaseMrt);
				Calendar.setup({inputField:"duty",ifFormat:"%m/%d/%Y",button:"dutyCalend",align:"T1",singleClick:true});
				//R2
				but = new YAHOO.widget.Button("importFacilities");
				YAHOO.util.Event.removeListener("importFacilities", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("importFacilities"), "click", importFacilitiesMRT);
				//R2
				
				if(mrtVendorHook != null){
					var tmp = mrtVendorHook;
					mrtVendorHook = null;
					tmp();
				}
				setMrtCall();
				getVendorChannelTypeBetween();
				typeOfCall = 0;
				//Enable activate button
				//enableActivationCBForMRT();
			}
		};
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
	}
	
	
	function saveVendorForMrt(evt){
		//HoangVT - [#1204 - Add MRT Product] cannot update new data in view when edit vendor 
		if(document.getElementById('vendorACInput').value == null ||
			document.getElementById('vendorACInput').value == ""){
				alert("Please input a vendor.");
				return;
		}			
		if(checkValidImportVO())
		{
			var vendorVO = getCurrentVendorVO();
			var vendorUniqueId = document.getElementById('selectedVendorUniqId').value;
			showProgress();
			AddCandidateTemp.saveVendorVOForMRT(vendorVO,vendorUniqueId,getDWRCallbackMethod(updateVendorRowForMrt));
		}
		else
		{
		   alert("All the fields should be mandatory except (Duty Info, HTS2, HTS3, Warehouse Flush Date, Instore date and Proration Date).");
		}					
	}
	function updateVendorRowForMrt(data){
		hideProgress();
		document.getElementById("mrtMessage").innerText="";
		if(document.getElementById('errors')){
			document.getElementById('errors').innerHTML = "";
		}
		var seletedRowId;
		var thirdRowData;
		var cnt = null;
		var guarSaleId = null;
		var dealOffrdId = null;
		if(selectedMRTVendorRowCount){
			seletedRowId = "vendorRow"+selectedMRTVendorRowCount;
			cnt = selectedMRTVendorRowCount;
			guarSaleId = "guarSaleReal"+cnt;
			dealOffrdId = "dealOffrdReal"+cnt;
		}else if(selectedMRTVendorRowCountAjax){
			seletedRowId = "vendorAjaxRow"+selectedMRTVendorRowCountAjax;
			cnt = selectedMRTVendorRowCountAjax;
			guarSaleId = "guarSale"+cnt;
			dealOffrdId = "dealOff"+cnt;
		}
		var selRow = document.getElementById(seletedRowId);
		if(data.dealOffered){
			document.getElementById(dealOffrdId).checked = true;
		}else{
			document.getElementById(dealOffrdId).checked = false;
		}
		if(data.guarenteedSale){
			document.getElementById(guarSaleId).checked = true;
		}else{
			document.getElementById(guarSaleId).checked = false;
		}

		if(data.listCost){
			data.listCost = formatValue(data.listCost);
		}
		//HoangVT - [#1204 - Add MRT Product] cannot update new data in view when edit vendor
		if(data.costOwner == null){
			data.costOwner = "UNASSIGNED";
		}
		if(data.top2Top == null){
			data.top2Top = "UNASSIGNED";
		}
		if(data.countryOfOrigin == null){
			data.countryOfOrigin = "UNASSIGNED";
		}
		
		var rowData = [
		//'', 
		data.vendorLocation,
		data.vpc,
		null,
		null,
		data.listCost,
		//data.unitCost,
		//null,
		data.costOwner,
		data.top2Top,
		data.countryOfOrigin,
		//data.seasonality,
		//data.seasonalityYear,
		null,
		null
		];
		for(var i=0;i < selRow.cells.length;i++){
			var tCell = selRow.cells[i];
			if(rowData[i] != null){
				tCell.innerHTML = rowData[i];
			}
		}
		//Enable activate button
		/* Visible Activate when user clicking on Save Vendor to update*/
		//enableActivationCBForMRT();
	}
	
	function deleteVendorDetailsForMrt(evt){
		if(confirm('You really want to delete this vendor?')){
			var selVendorUniqueId = getSelectedVendorIdForMRT();
			if(null != selVendorUniqueId){
				showProgress();
				AddCandidateTemp.removeVendorForMRT(selVendorUniqueId,getDWRCallbackMethod(deleteSelVendorRowFromTableForMrt));
			}
		}
	}
	
	function removeMarginProfit(){
		var percentMarginLabel = document.getElementById("percentMarginLabel");
		var pennyProfitLabel = document.getElementById("pennyProfitLabel");
		if(null != percentMarginLabel && percentMarginLabel != undefined){
			percentMarginLabel.innerText = "";
		}
		if(null != pennyProfitLabel && pennyProfitLabel != undefined){
			pennyProfitLabel.innerText = "";
		}
	}
	
	function deleteSelVendorRowFromTableForMrt(data){
		hideProgress();
		var selRowId = getSelectedVendorRowIdForMrt();
		var tBody = document.getElementById('vendorTable');
		removeMarginProfit();
		for(var i=0;i < tBody.rows.length;i++){
			if( tBody.rows[i].id == selRowId){
				tBody.deleteRow(i);
				colorTableRows('vendorTable');
				break;
			}
		}
		var noOfRows = tBody.rows.length;
		if(noOfRows > 1){
			tBody.rows[1].click();

			//Enable activate button
			//enableActivationCBForMRT();
		}
		if(noOfRows == 1){
			showMRTVendorDetailsToAdd();
		}
		//Change Order Unit when user clicking on Add [WHS] Vendor	
		if(document.getElementById('actions3')) {
			if(document.getElementById('actions3').value=='WHS' || document.getElementById('actions3').value=='BOTH') {
				changeOrderUnitDefault();
			}
		}
	}
	function getSelectedVendorRowIdForMrt(){
		if(selectedMRTVendorRowCount != null){
			return 'vendorRow'+selectedMRTVendorRowCount;
		}else if(selectedMRTVendorRowCountAjax != null){
			return 'vendorAjaxRow'+selectedMRTVendorRowCountAjax;
		}else{
			return null;
		}		
	}
	function showMRTVendorDetailsToAdd(evt){
		document.getElementById('selectedvendorDetailsDiv').style.display = 'none';
		document.getElementById('vendorDetailsDiv').style.display = 'block';
		document.getElementById('selectedvendorDetailsDiv').innerHTML = "";
		if(addVendorSectionHTML != null ){
			document.getElementById('vendorDetailsDiv').innerHTML ="";
			document.getElementById('vendorDetailsDiv').innerHTML = addVendorSectionHTML;
			loadScriptsFromDiv('vendorDetailsDiv');
			//addVendorSectionHTML = null;
		}
		clearVendorDetails();
<!-- 		QC 1594 14/10/2014 setDateDefaultVendorDetails -->
		setDateDefaultVendorDetails();
<!-- 		end QC 1594-->
		//fillMRTVendorDetails();
		selectChannelAjax();
		
		if(document.getElementById('listCost')){ 
			document.getElementById('listCost').disabled = false;
		}
		
		YAHOO.util.Event.removeListener("addButton6", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton6"), "click", addMRTVendor);

		YAHOO.util.Event.removeListener("authStore", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);

		Calendar.setup({inputField:"whseFlushDate",ifFormat:"%m/%d/%Y",button:"flushDate",align:"T1",singleClick:true});
		Calendar.setup({inputField:"instoreDate",ifFormat:"%m/%d/%Y",button:"storeDate",align:"T1",singleClick:true});
		Calendar.setup({inputField:"prorDate",ifFormat:"%m/%d/%Y",button:"propDate",align:"T1",singleClick:true});
		Calendar.setup({inputField:"freight",ifFormat:"%m/%d/%Y",button:"freights",align:"T1",singleClick:true});
		Calendar.setup({inputField:"duty",ifFormat:"%m/%d/%Y",button:"dutyCalend",align:"T1",singleClick:true});

		YAHOO.util.Dom.get("seasonality").value="13";
		if(document.getElementById('enableAuthorizeWHS')){
			document.getElementById('enableAuthorizeWHS').style.display = "none";
			document.getElementById('enableFactoryDiv').style.display = "none";
		}
		if(document.getElementById('enableAuthorizeStore')){
			document.getElementById('enableAuthorizeStore').style.display = "none";
		}
		
		but = new YAHOO.widget.Button("importFacilities");
		YAHOO.util.Event.removeListener("importFacilities", "click");
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("importFacilities"), "click", importFacilitiesMRT);
		
		//Request New Attribute
		new YAHOO.widget.Button("reqAttribute");	
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("reqAttribute"), "click", reqAttributeClick);

		selectedVendorRowCount = null;
		selectedVendorRowCountAjax = null;
		//Change Order Unit when user clicking on Add [WHS] Vendor	
		if(document.getElementById('actions3')) {
			if(document.getElementById('actions3').value=='WHS' || document.getElementById('actions3').value=='BOTH') {
				changeOrderUnitDefault();
			}
		}
		
		enableWarnProfit(false);
	}
	//*************************************** Functions For Authorization WHS - UseCase******************************************************************//
	var uniqueVendorIndex=null;
	var uniqueId = null;
	var listCost =null;
	var typeOfCall = null;
	var mrtCall = false;
	function setMrtCall(){
		mrtCall = true;
	}
	function setMrtCallAndResetDataCostList(){
		setMrtCall();
		resetDataCostlistAndListCostChangeVendor();
	}
	
	function getVendorChannelType(){
	 var sel = document.getElementById('vendorLocationVal');
	 uniqueVendorIndex = sel.value;
	 typeOfCall = 1;
	 AddCandidateTemp.getVendorChannelType(uniqueVendorIndex, getDWRCallbackMethod(checkAuthorize));
   	}
   	
	function getVendorChannelTypeNormal(){
	 var sel = document.getElementById('vendorLocationVal');
	 uniqueVendorIndex = sel.value;
	 typeOfCall = 2;
	 AddCandidateTemp.getVendorChannelType(uniqueVendorIndex, getDWRCallbackMethod(checkAuthorizeNormal));
   	}
   	function removeVendorMatchChannel(){
//	 	remove data of Vendor
		if(document.getElementById("vendorACInput") != null){
			document.getElementById("vendorACInput").value = "";
			if(YAHOO.util.Dom.get('vendorLocationVal')){
			YAHOO.util.Dom.get('vendorLocationVal').value = "";			
			}
		}
	}
	function getVendorChannelTypeBetween(){
	 var channelObj = document.getElementById('actions3');
	 //if(channelObj.options[channelObj.selectedIndex].value != "")
	 //	disableChannel();
	 // 	remove data of Vendor
	 var sel = document.getElementById('vendorLocationVal');
	 uniqueVendorIndex = sel.value;
	 typeOfCall = 3;
	 AddCandidateTemp.getVendorChannelType(uniqueVendorIndex, getDWRCallbackMethod(checkAuthorizeBetween));
   	}
   	function disableChannel(){
		if(document.getElementById('actions3')){
			document.getElementById('actions3').disabled = true;
		}
	}
	function enableChannel(){
		if(document.getElementById('actions3')){
			document.getElementById('actions3').disabled = false;
		}
	}
	var vendorChannel = "D";
	var vendorOriginal = "";
	function resetDataCostlistAndListCostChangeVendor() {
		var elm1 = YAHOO.util.Dom.get("vendorLocationVal"); 
		if(elm1 != null && elm1.value != vendorOriginal){
			vendorOriginal = elm1.value;
			var costlist = document.getElementById('costlist');
			// remove data of cost list when change vendor
			if(null != costlist && costlist != undefined) {
				costlist.value = "";
			}
			var listCost = document.getElementById('listCost');
			if(null != listCost && listCost != undefined) {
				listCost.value = "";
				listCost.disabled=false;
				initKitCostOfKitComponents();
			}
		}
	}
	function checkAuthorize(data) {
			//958 changes
			var viewMode = false;
			if(document.getElementById('viewMode')){
					viewMode = 	document.getElementById('viewMode').value;
			}
			var showHide = 'block';
			var itemRadioLabelDiv = document.getElementById('ItemRadioLabelDiv');
			var itemRadioDiv = document.getElementById('itemRadioDiv');
			var costItemLabelDiv = document.getElementById('CostItemLabelDiv');
			var costlistDiv = document.getElementById('costlistDiv');
			var lblCstLink = document.getElementById('CostItemLabel');		
			var costLink = document.getElementById('costLink');
			var costLinkLabel= document.getElementById('costLinkLabel');  		
			vendorChannel = data;		
			if(data=='V') {
			 uniqueId = getSelectedCaseID();
			 dispVendor();
			 dispEWM();
			  document.getElementById('enableAuthorizeWHS').style.display = 'block';
			  document.getElementById('enableFactoryDiv').style.display = 'block';
			  but = new YAHOO.widget.Button("authWHS");
			  YAHOO.util.Event.removeListener("authWHS", "click");
			  YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authWHS"), "click", reqWHSAttribute);
			  document.getElementById('enableAuthorizeStore').style.display = 'none';
			  //958 enhancements
			  if(document.getElementById('subDept')){
					document.getElementById('subDept').disabled = true;
			  }	
			  if(document.getElementById('vendPssDept')){
					document.getElementById('vendPssDept').disabled = true;
			  }
			  if (itemRadioLabelDiv) {
<!-- 				itemRadioLabelDiv.style.display = showHide;		 -->
				ItemRadioLabel.innerHTML ="Item Code";
				changeCostLinkByForWhs();
<!-- 			    lblCstLink.innerHTML = "Cost Link#/Item Code";	 -->
			  }	
			 if (itemRadioDiv) {
				itemRadioDiv.style.display = showHide;
			  }
			  if (costItemLabelDiv) {
					costItemLabelDiv.style.display = showHide;
			  }
			  if (costlistDiv) {
					costlistDiv.style.display = showHide;
			  }				
			  if(costLink){
				costLink.style.display = showHide;
			  }
			  if(costLinkLabel){
				costLinkLabel.style.display = showHide;
			  }		  
		    }else if(data=='D'){
			    uniqueId = getSelectedCaseID();
			    hideVendor();
			    hideEWM();
			    listCost = YAHOO.util.Dom.get("listCost").value;
				document.getElementById('enableAuthorizeStore').style.display = 'block';
				  but = new YAHOO.widget.Button("authStore");
				  YAHOO.util.Event.removeListener("authStore", "click");
			 	 YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAttribute);
				document.getElementById('enableAuthorizeWHS').style.display = 'none';
				document.getElementById('enableFactoryDiv').style.display = "none";
				//958 enhancements
			  	//1205 Edit Case Edit Vendor
			  	//if(document.getElementById('subDept')){
				 //	 document.getElementById('subDept').disabled = viewMode;
			 	//}				
				 
				//958 PSS
			  if(document.getElementById('vendPssDept')){
					if(viewMode){
						document.getElementById('vendPssDept').disabled = true;
					}else{
						if(document.getElementById('subDept').value != '${CPSForm.defaultSubDept}'){
							//document.getElementById('vendPssDept').disabled = false;
						}else{
							//document.getElementById('vendPssDept').disabled = true;
						}
						document.getElementById('vendPssDept').disabled = true;
					}
			  }
			  if (itemRadioLabelDiv) {
<!-- 					itemRadioLabelDiv.style.display = showHide;	 -->
					ItemRadioLabel.innerHTML ="UPC";
					changeCostLinkByForDsd();
<!-- 					lblCstLink.innerHTML = "Cost Link#/UPC"; -->
				}
			  if (itemRadioDiv) {
				itemRadioDiv.style.display = showHide;
			  }
			  if (costItemLabelDiv) {
					costItemLabelDiv.style.display = showHide;
			  }
			  if (costlistDiv) {
					costlistDiv.style.display = showHide;
			  }				
			   if(costLink){
				costLink.style.display = 'block';
			  }
			  if(costLinkLabel){
				costLinkLabel.style.display = 'block';
			  }		  
			}else {
				document.getElementById('enableAuthorizeWHS').style.display = 'none';
				document.getElementById('enableFactoryDiv').style.display = "none";
				document.getElementById('enableAuthorizeStore').style.display = 'none';
				//958 enhancements
				//if(document.getElementById('subDept')){
					//document.getElementById('subDept').disabled = viewMode;
			  	//}
				//958 PSS
			  if(document.getElementById('vendPssDept')){
					if(viewMode){
						document.getElementById('vendPssDept').disabled = true;
					}else{
						if(document.getElementById('subDept').value != '${CPSForm.defaultSubDept}'){
							document.getElementById('vendPssDept').disabled = false;
						}else{
							document.getElementById('vendPssDept').disabled = true;
						}
					}
			  }
				dispVendor();
				dispEWM();
			}
			displayImportDiv(data);
			doDisableCstLnkDsdBaseVendor(data);
			//fix bug: 1428
			if(${CPSForm.enableActiveButton == true}) {
				if(document.getElementById('activateButton')!=null) {
					document.getElementById('activateButton').disabled = false;
				}
			}
	}
	function checkAuthorizeNormal(data) {
			//958 changes
			var viewMode = false;
			if(document.getElementById('viewMode')){
					viewMode = 	document.getElementById('viewMode').value;
			}
			var showHide = 'block';
			var itemRadioLabelDiv = document.getElementById('ItemRadioLabelDiv');
			var itemRadioDiv = document.getElementById('itemRadioDiv');
			var costItemLabelDiv = document.getElementById('CostItemLabelDiv');
			var costlistDiv = document.getElementById('costlistDiv');
			var lblCstLink = document.getElementById('CostItemLabel');		
			var costLink = document.getElementById('costLink');
			var costLinkLabel= document.getElementById('costLinkLabel');  	
			vendorChannel = data; 	
			if(data=='V') {
			 uniqueId = getSelectedCaseID();
			 dispVendor();
			 dispEWM();
			  document.getElementById('enableAuthorizeWHS').style.display = 'block';
			  document.getElementById('enableFactoryDiv').style.display = "block";
			  but = new YAHOO.widget.Button("authWHS");
			  YAHOO.util.Event.removeListener("authWHS", "click");
			  if(mrtCall){
			  	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authWHS"), "click", reqWHSAttributeMrt);
			  }else{
			  	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authWHS"), "click", reqWHSAttribute);
			  }
			  document.getElementById('enableAuthorizeStore').style.display = 'none';
			  document.getElementById('importOnly').style.display = 'block';
			  //958 enhancements
			  if(document.getElementById('subDept')){
					document.getElementById('subDept').disabled = true;
			  }
			  //958 PSS
			  if(document.getElementById('vendPssDept')){
					document.getElementById('vendPssDept').disabled = true;
			  }
			  if (itemRadioLabelDiv) {
<!-- 				itemRadioLabelDiv.style.display = showHide;		 -->
				ItemRadioLabel.innerHTML ="Item Code";
				changeCostLinkByForWhs();
<!-- 			    lblCstLink.innerHTML = "Cost Link#/Item Code";	 -->
			  }	
			 if (itemRadioDiv) {
				itemRadioDiv.style.display = showHide;
			  }
			  if (costItemLabelDiv) {
					costItemLabelDiv.style.display = showHide;
			  }
			  if (costlistDiv) {
					costlistDiv.style.display = showHide;
			  }				
			   if(costLink){
				costLink.style.display = 'block';
			  }
			  if(costLinkLabel){
				costLinkLabel.style.display = 'block';
			  }		  
		    }else if(data=='D'){
			    uniqueId = getSelectedCaseID();
			    hideVendor();
			    hideEWM();
			    if(YAHOO.util.Dom.get("listCost")){
			    	listCost = YAHOO.util.Dom.get("listCost").value;
			    }
				  document.getElementById('enableAuthorizeStore').style.display = 'block';
				  but = new YAHOO.widget.Button("authStore");
				  YAHOO.util.Event.removeListener("authStore", "click");
				   if(mrtCall){
				   		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAfterSavingCaseMrt);
				   }else{
			 	 		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAfterSavingCase);
			 	 	}
				document.getElementById('enableAuthorizeWHS').style.display = 'none';
				document.getElementById('enableFactoryDiv').style.display = "none";
				document.getElementById('importOnly').style.display = 'none';
				//958 enhancements
			 	 //if(document.getElementById('subDept')){
					//document.getElementById('subDept').disabled = viewMode;
			 	 //}
				//958 PSS
				  if(document.getElementById('vendPssDept')){
						if(viewMode){
							document.getElementById('vendPssDept').disabled = true;
						}else{
							if(document.getElementById('subDept').value != '${CPSForm.defaultSubDept}'){
								document.getElementById('vendPssDept').disabled = false;
							}else{
								document.getElementById('vendPssDept').disabled = true;
							}
						}
				  }
			 if (itemRadioLabelDiv) {
<!-- 				itemRadioLabelDiv.style.display = showHide;	 -->
				ItemRadioLabel.innerHTML ="UPC";
				changeCostLinkByForDsd();
<!-- 				lblCstLink.innerHTML = "Cost Link#/UPC"; -->
			  }
			  if (itemRadioDiv) {
				itemRadioDiv.style.display = showHide;
			  }
			  if (costItemLabelDiv) {
					costItemLabelDiv.style.display = showHide;
			  }
			  if (costlistDiv) {
					costlistDiv.style.display = showHide;
			  }				
			   if(costLink){
				costLink.style.display = 'block';
			  }
			  if(costLinkLabel){
				costLinkLabel.style.display = 'block';
			  }		  
			}
			else {
				document.getElementById('enableAuthorizeWHS').style.display = 'none';
				document.getElementById('enableFactoryDiv').style.display = "none";
				document.getElementById('enableAuthorizeStore').style.display = 'none';
				dispVendor();
				dispEWM();
				//958 enhancements
			  	//if(document.getElementById('subDept')){
					//document.getElementById('subDept').disabled = viewMode;
			  	//}
				//958 PSS
			  if(document.getElementById('vendPssDept')){
					if(viewMode){
						document.getElementById('vendPssDept').disabled = true;
					}else{
						if(document.getElementById('subDept').value != '${CPSForm.defaultSubDept}'){
							document.getElementById('vendPssDept').disabled = false;
						}else{
							document.getElementById('vendPssDept').disabled = true;
						}
					}
			  }
			}
			displayImportDiv(data);
			doDisableCstLnkDsdBaseVendor(data);
	}
	function checkAuthorizeBetween(data) {
			//958 changes
			var viewMode = false;
			if(document.getElementById('viewMode')){
					viewMode = 	document.getElementById('viewMode').value;
			}
			channel=data;
			var showHide = 'block';
			var itemRadioLabelDiv = document.getElementById('ItemRadioLabelDiv');
			var itemRadioDiv = document.getElementById('itemRadioDiv');
			var costItemLabelDiv = document.getElementById('CostItemLabelDiv');
			var costlistDiv = document.getElementById('costlistDiv');
			var lblCstLink = document.getElementById('CostItemLabel');		
			var costLink = document.getElementById('costLink');
			var costLinkLabel= document.getElementById('costLinkLabel'); 
			vendorChannel = data;
			
			
			if(data=='V') {
			 uniqueId = getSelectedCaseID();
			 dispVendor();
			 dispEWM();
			  document.getElementById('enableAuthorizeWHS').style.display = 'block';
			  document.getElementById('enableFactoryDiv').style.display = "block";
			  but = new YAHOO.widget.Button("authWHS");
			  YAHOO.util.Event.removeListener("authWHS", "click");
			  if(mrtCall){
			  	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authWHS"), "click", reqWHSAttributeMrtDirect);
			  }else{
			  	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authWHS"), "click", reqWHSAttribute);
			  }
			  document.getElementById('enableAuthorizeStore').style.display = 'none';
			  //958 enhancements
			  if(document.getElementById('subDept')){
					document.getElementById('subDept').disabled = true;
			  }
			  //958 PSS
			  if(document.getElementById('vendPssDept')){
						document.getElementById('vendPssDept').disabled = true;
				}
				for(i=0;i<document.all('purchaseStatus').length;i++)
				{
					if(document.all('purchaseStatus').options[i].value=="S")
					{
						document.all('purchaseStatus').selectedIndex=i;
						break;
					}
				}
		    if (itemRadioLabelDiv) {
<!-- 				itemRadioLabelDiv.style.display = showHide;		 -->
				ItemRadioLabel.innerHTML ="Item Code";
				changeCostLinkByForWhs();
<!-- 			    lblCstLink.innerHTML = "Cost Link#/Item Code";	 -->
			  }	
			 if (itemRadioDiv) {
				itemRadioDiv.style.display = showHide;
			  }
			  if (costItemLabelDiv) {
					costItemLabelDiv.style.display = showHide;
			  }
			  if (costlistDiv) {
					costlistDiv.style.display = showHide;
			  }				
			   if(costLink){
				costLink.style.display = 'block';
			  }
			  if(costLinkLabel){
				costLinkLabel.style.display = 'block';
			  }	
		    }
			else if(data=='D'){
			    uniqueId = getSelectedCaseID();
			    hideVendor();
			    hideEWM();
			    listCost = YAHOO.util.Dom.get("listCost").value;
				document.getElementById('enableAuthorizeStore').style.display = 'block';
				  but = new YAHOO.widget.Button("authStore");
				  YAHOO.util.Event.removeListener("authStore", "click");
				 if(mrtCall){
				 	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAfterSavingCaseMrt);
				 }else{
			 	 	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authStore"), "click", reqStoreAfterSavingCase);
			 	 }
				document.getElementById('enableAuthorizeWHS').style.display = 'none';
				document.getElementById('enableFactoryDiv').style.display = "none";
				//958 enhancements
			    //if(document.getElementById('subDept')){
					//document.getElementById('subDept').disabled = viewMode;
			    //}
				//958 PSS
			  if(document.getElementById('vendPssDept')){
					if(viewMode){
						document.getElementById('vendPssDept').disabled = true;
					}else{
						if(document.getElementById('subDept').value != '${CPSForm.defaultSubDept}'){
							document.getElementById('vendPssDept').disabled = false;
						}else{
							document.getElementById('vendPssDept').disabled = true;
						}
					}
			  }
			  if (itemRadioLabelDiv) {
<!-- 				itemRadioLabelDiv.style.display = showHide;	 -->
				ItemRadioLabel.innerHTML ="UPC";
				changeCostLinkByForDsd();
<!-- 				lblCstLink.innerHTML = "Cost Link#/UPC"; -->
			  }
			  if (itemRadioDiv) {
				itemRadioDiv.style.display = showHide;
			  }
			  if (costItemLabelDiv) {
					costItemLabelDiv.style.display = showHide;
			  }
			  if (costlistDiv) {
					costlistDiv.style.display = showHide;
			  }				
			   if(costLink){
				costLink.style.display = 'block';
			  }
			  if(costLinkLabel){
				costLinkLabel.style.display = 'block';
			  }		  
			}
			else {
				document.getElementById('enableAuthorizeWHS').style.display = 'none';
				document.getElementById('enableFactoryDiv').style.display = "none";
				document.getElementById('enableAuthorizeStore').style.display = 'none';
				dispVendor();
				dispEWM();
				//958 enhancements
			    //if(document.getElementById('subDept')){
					//document.getElementById('subDept').disabled = viewMode;
			    //}
				//958 PSS
			  if(document.getElementById('vendPssDept')){
					if(viewMode){
						document.getElementById('vendPssDept').disabled = true;
					}else{
						if(document.getElementById('subDept').value != '${CPSForm.defaultSubDept}'){
							document.getElementById('vendPssDept').disabled = false;
						}else{
							document.getElementById('vendPssDept').disabled = true;
						}
					}
			  }
			}
			displayImportDiv(data);
			doDisableCstLnkDsdBaseVendor(data);
	
	}
	
	//R2
	<c:url value="/protected/cps/add/viewFactories?${_csrf.parameterName}=${_csrf.token}" var="toFactories" />
	function importFacilities(){
	    var sel = document.getElementById('vendorLocationVal');
	    var uniqueVendorIndex = sel.value;
	    //showProgress();
		AddCandidateTemp.checkWareHouseExist(uniqueVendorIndex,getSelectedCaseID(), getDWRCallbackMethod(showFactoryPopup));
		
	}
	
	function showFactoryPopup(warehouseExist){
		//hideProgress();
		if(warehouseExist == "true"){
		    var sel = document.getElementById('vendorLocationVal');
		    var uniqueVendorIndex = sel.value;
			//f1('${toFactories}'+'&t='+new Date().getTime()+'&selectedVendorId='+uniqueVendorIndex+'&selectedItemId='+getSelectedCaseID(),'Import Factory','500px','700px','100px','100px');
			var editVendorDetailsButtonStatus  = 'false';
			if(document.getElementById('editVendorDetailsBut') != null && document.getElementById('editVendorDetailsBut') != undefined){
			editVendorDetailsButtonStatus ='true';
			}
			//var url='${toFactories}'+'&t='+new Date().getTime()+'&selectedVendorId='+uniqueVendorIndex+'&selectedItemId='+getSelectedCaseID()+'&editVendorBtnEnable='+document.getElementById('editVendorDetailsBut');
			var url='${toFactories}'+'&t='+new Date().getTime()+'&selectedVendorId='+uniqueVendorIndex+'&selectedItemId='+getSelectedCaseID()+'&editVendorBtnEnable='+editVendorDetailsButtonStatus;
			popupFactory(url);
		} else{
			alert("Please Authorize WHS before selecting factories");
		}
	}
	
	function popupFactory(url)
	{		
		document.getElementById("factoryPanel").style.display="inline";		
		YAHOO.heb.container.factory = new YAHOO.widget.Panel("factoryPanel", 
		{ 	width:"820px", 
			height:"465px", 
			underlay:"none",
			visible:false, 
			constraintoviewport:false, 
			draggable:true,	
			zIndex : 15000,						
			modal:true,
			close:true,
			fixedCenter : true,
			autofillheight: "body",
			effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}						
		} );
		
		YAHOO.heb.container.factory.render(document.body);					
		YAHOO.heb.container.factory.beforeHideEvent.subscribe(onBeforeClosefactoryPanel);		
		YAHOO.heb.container.factory.hide();		
		YAHOO.heb.container.factory.setHeader("Import Factory");
		YAHOO.heb.container.factory.show();		
		showProgress();		
		document.getElementById("factoryFrame").style.height="100%";		
		document.getElementById("factoryFrame").style.width="100%";		
		document.getElementById("factoryFrame").src = url;		
	}
	function setFacilitiesInVendorDOM(list){
		var factoryList = document.getElementById("factoryList");
		factoryList.value = list;
	}
	
	<c:url value="/protected/cps/add/viewFactoriesMRT?${_csrf.parameterName}=${_csrf.token}" var="toFactoriesMRT" />
	function importFacilitiesMRT(){
	    var sel = document.getElementById('vendorLocationVal');
	    var uniqueVendorIndex = sel.value;
	    showProgress();
		AddCandidateTemp.checkWareHouseExistMRT(uniqueVendorIndex,getDWRCallbackMethod(showFactoryPopupMRT));
		
	}
	
	function showFactoryPopupMRT(warehouseExist){
		hideProgress();
		if(warehouseExist == "true"){
		    var sel = document.getElementById('vendorLocationVal');
		    var uniqueVendorIndex = sel.value;
			//f1('${toFactoriesMRT}'+'&t='+new Date().getTime()+'&selectedVendorId='+uniqueVendorIndex,'Import Factory','500px','700px','100px','100px');
			var url='${toFactoriesMRT}'+'&t='+new Date().getTime()+'&selectedVendorId='+uniqueVendorIndex;
			popupFactory(url);
		} else{
			alert("Please Authorize WHS before selecting factories");
		}
	}
	//R2
	
	
	<c:url value="/protected/cps/add/authWHS?${_csrf.parameterName}=${_csrf.token}" var="toWHS" />
	function reqWHSAttribute(evt){	
		if(typeOfCall == 2){
			//typeOfCall = null;
			requestWareHouseHook = function(){
				warreHousePopUp();
			};
	    	saveCaseAndVendor(evt);
		} else if(typeOfCall == 1){
			//typeOfCall = null;
			vendorWareHouseHook = function(){
				warreHousePopUp();
			};
			saveVendor(evt);
		} else if(typeOfCall == 3){
			//typeOfCall = null;
			newlyAddedVendorRowShouldBeClicked = true;
			requestWareHouseHook = function(){
				warreHousePopUp();
			};
			addVendor(evt);
		}  
		//after selection of vendor 
		else if(typeOfCall == 0){
			warreHousePopUp();
		}
	}
	function reqWHSAttributeMrt(evt){
		mrtVendorHook = function(){
			warreHousePopUpMrt();
		}
		addMRTVendor(evt);
	}
	function reqWHSAttributeMrtDirect(evt){
		warreHousePopUpMrt();
	}
	<c:url value="/protected/cps/add/viewStores?${_csrf.parameterName}=${_csrf.token}" var="toStore" />
	var listCost = null;
	var callbackFunction = null;
	function reqStoreAttribute(evt){
		if(listCostSet()){
			if(typeOfCall == 1){			
				saveVendorAuthorizeStore(evt);
			} else {
				reqStoreAttrCore(evt);
			}
		}
	}
	function listCostSet(){
		listCost = YAHOO.util.Dom.get("listCost").value;
	     if(listCost =="" ||listCost ==null) {
	     	alert('Please set the List Cost Value');
	     	if(!document.getElementById('listCost').disabled)
	     		document.getElementById('listCost').focus();
	     	return false;
	     }
	     return true;
	}
	var showStorePopup=false;
	function reqStoreAfterSavingCase(evt){
		if(listCostSet()){
			requestWareHouseHook = function(){
				showStorePopup = true;
				//prevent to show Store Authorize if MORPH did not finish
				if(!beginMorph) {
				   reqStoreAttrCore(evt);
				}
			};
			if(getSelectedCaseID()){
				if(getSelectedVendorId()){
					saveVendor(evt);
				}else{
					addVendor(evt);
				}
			}else{
				saveCaseAndVendor(evt);
			}
		}
	}

	function reqStoreAfterSavingCaseMrt(evt){
		if(listCostSet()){
			if(typeOfCall == 0){
					reqStoreAttrCoreMrt(evt);
			}
			else {
					mrtVendorHook = function(){
						reqStoreAttrCoreMrt(evt);
					}
					addMRTVendor(evt);
			 }
		}
	}
	function afterAddingCaseWHS(){
		//for getting case unique if for adding vendor
		selectedCaseRowCount = null;
		selectedCaseRowCountAjax = addedCaseRowCount;
		
		addVendorWithoutTableChangeWHS();
	}
	function addVendorWithoutTableChangeWHS(){
		var vendorVO = getCurrentVendorVO();
		if(getSelectedCaseID()){			
			beginMorph=false;		
			AddCandidateTemp.addVendorVO(vendorVO,getSelectedCaseID(),getDWRCallbackMethod(reqStoreAttrCore));
		}
	}
	function getRemainVendor() {
		var tBody = document.getElementById('vendorTable');
		var firstUniqueIdVendor ="";
		//QC-30
		if(tBody!=null) {
			for(var i=0;i < tBody.rows.length;i++){
				if(tBody.rows[i].id.indexOf('vendorRow')==0) {
					if(document.getElementById('vendorUniq'+tBody.rows[i].id.split('vendorRow')[1]).value != getSelectedVendorId()) {
						firstUniqueIdVendor +=document.getElementById('vendorUniq'+tBody.rows[i].id.split('vendorRow')[1]).value +"_";
						//break;
					} 		
				} else if(tBody.rows[i].id.indexOf('vendorAjaxRow')==0) {
					if(document.getElementById('vendorUniqAjax'+tBody.rows[i].id.split('vendorAjaxRow')[1]).value!=getSelectedVendorId()) {
						//firstUniqueIdVendor = document.getElementById('vendorUniqAjax'+tBody.rows[i].id.split('vendorAjaxRow')[1]).value;
						firstUniqueIdVendor +=document.getElementById('vendorUniqAjax'+tBody.rows[i].id.split('vendorAjaxRow')[1]).value+"_";
						//break;
					} 
				}
			}
			if(firstUniqueIdVendor!="") {
				firstUniqueIdVendor = firstUniqueIdVendor.substring(0,firstUniqueIdVendor.length-1);
			} else {
				firstUniqueIdVendor = getSelectedVendorId();
			}
		}
		
		return firstUniqueIdVendor;
	}
	function reqStoreAttrCore(evt){
		var sel = document.getElementById('vendorLocationVal');
		var uniqueVendorIndex = sel.value;
	 	var tBody = document.getElementById('vendorTable');
		var firstUniqueIdVendor ="";
		//QC-30
		if(tBody!=null) {
			for(var i=0;i < tBody.rows.length;i++){
				if(tBody.rows[i].id.indexOf('vendorRow')==0) {
					if(document.getElementById('vendorUniq'+tBody.rows[i].id.split('vendorRow')[1]).value != getSelectedVendorId()) {
						firstUniqueIdVendor +=document.getElementById('vendorUniq'+tBody.rows[i].id.split('vendorRow')[1]).value +"_";
						//break;
					} 		
				} else if(tBody.rows[i].id.indexOf('vendorAjaxRow')==0) {
					if(document.getElementById('vendorUniqAjax'+tBody.rows[i].id.split('vendorAjaxRow')[1]).value!=getSelectedVendorId()) {
						//firstUniqueIdVendor = document.getElementById('vendorUniqAjax'+tBody.rows[i].id.split('vendorAjaxRow')[1]).value;
						firstUniqueIdVendor +=document.getElementById('vendorUniqAjax'+tBody.rows[i].id.split('vendorAjaxRow')[1]).value+"_";
						//break;
					} 
				}
			}
		}
		if(firstUniqueIdVendor!="") {
			firstUniqueIdVendor = firstUniqueIdVendor.substring(0,firstUniqueIdVendor.length-1);
		}
		var url = '${toStore}'+'&t='+new Date().getTime()+'&selectedVendorId='+uniqueVendorIndex+'&selectedItemId='+getSelectedCaseID()+'&listCost='+listCost+'&firstUniqueIdVendor='+firstUniqueIdVendor+'&selectedVendorUniq='+getRemainVendor();
	    popupAuthorizeStore(url);
	}
	function popupAuthorizeStore(url){
		//f1('${toStore}'+'&t='+new Date().getTime()+'&selectedVendorId='+uniqueVendorIndex+'&selectedItemId='+getSelectedCaseID()+'&listCost='+listCost,'Authorize Store','450px','800px','130px','100px');
		document.getElementById("authorizeStorePanel").style.display="block";
		YAHOO.heb.container.authorizeStore = new YAHOO.widget.Panel("authorizeStorePanel", 
		{ 	width:"770px", 
			height:"470px", 
			underlay:"none",
			visible:false, 
			constraintoviewport:false, 
			draggable:true,	
			zIndex : 15000,						
			modal:true,
			close:true,
			fixedCenter : true,
			autofillheight: "body",
			effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}						
		} );
		
		YAHOO.heb.container.authorizeStore.render(document.body);
		//YAHOO.heb.container.reqNewAttrib.hide();
		YAHOO.heb.container.authorizeStore.beforeHideEvent.subscribe(onBeforeCloseAuthorizeStroe);
		//YAHOO.heb.container.reqNewAttrib.beforeShowEvent.subscribe(onBeforeShowRNAEvent);		
		//YAHOO.heb.container.reqNewAttrib.show();
		YAHOO.heb.container.authorizeStore.setHeader("Authorize store");
		YAHOO.heb.container.authorizeStore.show();
		
		document.getElementById("authorizeStoreFrame").style.height="450px";
		document.getElementById("authorizeStoreFrame").style.width="750px";
		document.getElementById("authorizeStoreFrame").src = url;		
		showProgress();		
		showStorePopup=false;
	}
	
	function closeAuthorizeStroe(){
		YAHOO.heb.container.authorizeStore.hide();
		if(document.getElementById("conflictMessage")!=null) {
	    	document.getElementById("conflictMessage").innerText="";
		}
	}
	function onBeforeCloseAuthorizeStroe(){
		document.getElementById("authorizeStoreFrame").src = "";
		document.getElementById("authorizeStorePanel").style.display="hidden";	
	}
	
	function closefactory(){
		YAHOO.heb.container.factory.hide();
	}
	function onBeforeClosefactoryPanel(){
		document.getElementById("factoryFrame").src = "";
		document.getElementById("factoryPanel").style.display="hidden";	
	}
	<c:url value="/protected/cps/add/viewMRTStores?${_csrf.parameterName}=${_csrf.token}" var="toStoreMrt" />
	function reqStoreAttrCoreMrt(evt){
		var sel = document.getElementById('vendorLocationVal');
		var uniqueVendorIndex = sel.value;
	    //f1('${toStoreMrt}'+'&t='+new Date().getTime()+'&selectedVendorId='+uniqueVendorIndex+'&selectedItemId='+getSelectedCaseID()+'&listCost='+listCost+'&channel='+selValue,'Authorize Store','450px','800px','130px','100px');
	    var url = '${toStoreMrt}'+'&t='+new Date().getTime()+'&selectedVendorId='+uniqueVendorIndex+'&selectedItemId='+getSelectedCaseID()+'&listCost='+listCost;
		popupAuthorizeStore(url);
	}
	function warreHousePopUp(){
	    var sel = document.getElementById('vendorLocationVal');
	    var uniqueVendorIndex = sel.value;
		f1('${toWHS}'+'&t='+new Date().getTime()+'&selectedVendorId='+uniqueVendorIndex+'&selectedItemId='+getSelectedCaseID(),'Authorize WHS','325px','62%','130px','200px');
	}
	
	<c:url value="/protected/cps/add/authMRTWHS?${_csrf.parameterName}=${_csrf.token}" var="toWHSMrt" />
	function warreHousePopUpMrt(){
	    var sel = document.getElementById('vendorLocationVal');
	    var uniqueVendorIndex = sel.value;
		f1('${toWHSMrt}'+'&t='+new Date().getTime()+'&selectedVendorId='+uniqueVendorIndex+'&selectedItemId='+getSelectedCaseID(),'Authorize WHS','325px','62%','130px','200px');
	}
	function dateCheck(){
		var seasonalityYear = YAHOO.util.Dom.get("seasonalityYear").value;
		if(null!=seasonalityYear && ""!= seasonalityYear){
		 showProgress();
		  AddCandidateTemp.seasonalityDateCheck(seasonalityYear, getDWRCallbackMethod(seasonalityCallBack));
		}
	}
	function seasonalityCallBack(data){
	 hideProgress();
		 if(!data){
		    alert('Seasonalty Yr should be >= current year or <= current year +10');
		    YAHOO.util.Dom.get("seasonalityYear").value ="";
		    YAHOO.util.Dom.get("sellYear").value ="";
		    YAHOO.util.Dom.get("seasonalityYear").focus(); 
		 }
	}
	
	//*************************************** Functions For Calculating The List Cost******************************************************************//
<!--       function calculateListCost(evt) { -->
<!-- 		showProgress(); -->
<!-- 	    var sel = document.getElementById('vendorLocationVal'); -->
<!--  		var uniqueVendorIndex = sel.value; -->
<!--  		var costlinkid =document.getElementById('costlist').value; -->
<!--  		var costlink = document.getElementById('costRadio').checked; -->
<!--  		var itemcode = document.getElementById('itemRadio').checked; -->
<!--  		var checkvalue = 0; -->
<!--  		var lblSecondRdoLbl =  document.getElementById('ItemRadioLabel').innerHTML; -->
<!--  		if (costlinkid == "" || costlinkid == null){ -->
<!-- 			hideProgress(); -->
<!-- 			return true; -->
<!-- 		} -->
<!--  		else { -->
<!-- 			if (costlink && lblSecondRdoLbl!="UPC") { -->
<!--  				checkvalue = 1 ; -->
<!-- 			} -->
<!-- 			else if (itemcode && lblSecondRdoLbl!="UPC") { -->
<!-- 				checkvalue = 2 ; -->
<!-- 			} -->
<!-- 			else if(costlink && lblSecondRdoLbl=="UPC") -->
<!-- 			{ -->
<!-- 				checkvalue = 3; -->
<!-- 			} -->
<!-- 			else if(itemcode && lblSecondRdoLbl=="UPC") -->
<!-- 			{ -->
<!-- 				checkvalue = 4; -->
<!-- 			}			 -->
<!-- 			if (checkvalue == 0 && costlinkid != "") { -->
<!-- 				hideProgress(); -->
<!-- 				alert('Select Cost Link# / Item Code'); -->
<!-- 				document.getElementById('costlist').value = ""; -->
<!-- 				return true; -->
<!-- 			} -->
<!-- 			else -->
<!-- 			{ -->
<!-- 				if(checkvalue==3 || checkvalue==4) -->
<!-- 				{ -->
<!-- 					var comp = YAHOO.lang; -->
					
<!-- 					if(comp.trim(uniqueVendorIndex).length==0) -->
<!-- 					{ -->
<!-- 						alert("Please select a vendor"); -->
<!-- 						hideProgress(); -->
<!-- 						return true; -->
<!-- 					}					 -->
<!-- 				} -->
<!-- 			} -->
			
<!-- 			var costlinkidTemp =  parseFloat(costlinkid);	 -->
<!-- 			if(isNaN(costlinkidTemp)){ -->
<!-- 				if(checkvalue == 3 || checkvalue ==4){ -->
<!-- 					hideProgress();			    -->
<!-- 					alert("Cost Link#/UPC must be a numeric value"); -->
<!-- 					document.getElementById('costlist').value = ""; -->
<!-- 					 return true; -->
<!-- 				} else { -->
<!-- 				    hideProgress();			    -->
<!-- 					alert("Cost Link#/Item Code must be a numeric value"); -->
<!-- 					document.getElementById('costlist').value = ""; -->
<!-- 					return true; -->
<!-- 				} -->
<!-- 			} -->
			
<!-- 			var caseUniqueId = getSelectedCaseID(); -->
			
<!-- 			if (caseUniqueId == null) { -->
<!-- 				caseUniqueId = -1; -->
<!-- 			} -->
			
<!-- 			AddCandidateTemp.getListCost(costlinkid, uniqueVendorIndex, checkvalue, caseUniqueId, getDWRCallbackMethod(listCostCallBack)); -->
<!-- 		} -->
<!--       } -->
      function calculateListCost(evt) {
		showProgress();
	    var sel = document.getElementById('vendorLocationVal');
 		var uniqueVendorIndex = sel.value;
 		var costlinkid =document.getElementById('costlist').value;
<!--  		var costlink = document.getElementById('costRadio').checked; -->
<!--  		var itemcode = document.getElementById('itemRadio').checked; -->
 		var costLinkBy = document.getElementById('costLinkBy').value;
 		
 		var checkvalue = 0;
 		var lblSecondRdoLbl =  document.getElementById('ItemRadioLabel').innerHTML;
 		if (costlinkid == "" || costlinkid == null){
			hideProgress();
			return true;
		}
 		else {
			if (costLinkBy == "cl" && lblSecondRdoLbl!="UPC") {
 				checkvalue = 1 ;
			}
			else if (costLinkBy =="ic" && lblSecondRdoLbl!="UPC") {
				checkvalue = 2 ;
			}
			else if(costLinkBy == "cl" && lblSecondRdoLbl=="UPC")
			{
				checkvalue = 3;
			}
			else if(costLinkBy == "up" && lblSecondRdoLbl=="UPC")
			{
				checkvalue = 4;
			}			
			if (checkvalue == 0 && costlinkid != "") {
				hideProgress();
				alert('Select Cost Link# / Item Code');
				document.getElementById('costlist').value = "";
				return true;
			}
			else
			{
				if(checkvalue==3 || checkvalue==4)
				{
					var comp = YAHOO.lang;
					
					if(comp.trim(uniqueVendorIndex).length==0)
					{
						alert("Please select a vendor");
						hideProgress();
						return true;
					}					
				}
			}
			
			var costlinkidTemp =  parseFloat(costlinkid);	
			if(isNaN(costlinkidTemp)){
				if(checkvalue == 3 || checkvalue ==4){
					hideProgress();			   
					alert("Cost Link#/UPC must be a numeric value");
					document.getElementById('costlist').value = "";
					 return true;
				} else {
				    hideProgress();			   
					alert("Cost Link#/Item Code must be a numeric value");
					document.getElementById('costlist').value = "";
					return true;
				}
			}
			
			var caseUniqueId = getSelectedCaseID();
			
			if (caseUniqueId == null) {
				caseUniqueId = -1;
			}
			AddCandidateTemp.getListCost(costlinkid, uniqueVendorIndex, checkvalue, caseUniqueId, getDWRCallbackMethod(listCostCallBack));
		}
      }
  function listCostCallBack(data){
  	hideProgress();
  	var masterPack = YAHOO.util.Dom.get("masterPackText").value;
	var shipPack = YAHOO.util.Dom.get("shipPackText").value;
	var sel = document.getElementById('actions3');
  	if(data!=null && data != '' && data.length >10 || isNaN(data)){
		if((data+"").indexOf("This is an operation") > -1)
		{
			alert("No data found");
		}
		else
		{
  		alert(data);
		}	
  		//document.getElementById("lstCstMsg").innerText=data;
  		document.getElementById('listCost').value = "";
  		document.getElementById('listCost').disabled=false;
		document.getElementById('costlist').value ="";
		document.getElementById('unitCostLabel').innerText ="";
		
  	}else{
	  	if(data!=null && data != ''){
	     		document.getElementById('listCost').value = "";
	     		document.getElementById('listCost').value = formatValue(data);			
				document.getElementById('listCost').disabled=false;
	      		document.getElementById("lstCstMsg").innerText="";	      	
				if(sel.options[sel.selectedIndex].value == 'DSD')
				{
	      	 	    var reslt = (data/masterPack);
	      	 	    var rndReslt = Math.round(reslt * 10000)/10000;
	         	    document.getElementById('unitCostLabel').innerText = formatValue(''+rndReslt);
	         	    document.getElementById('listCost').disabled=true;
	        	 }
				else
				{
	        	  if(sel.options[sel.selectedIndex].value == 'WHS'||sel.options[sel.selectedIndex].value == 'BOTH'){
             	      var reslt1 = (data/shipPack);
             	      var rndReslt1 = Math.round(reslt1 * 10000)/10000;
             	      document.getElementById('unitCostLabel').innerText = formatValue(''+rndReslt1);
  	        	  } else {
	        	    document.getElementById('unitCostLabel').innerText = "";  
	         	  }   
	         	  document.getElementById('listCost').disabled=true;
	      		}     
	      } else {
	     	document.getElementById('listCost').disabled=false;
	     	document.getElementById("lstCstMsg").innerText="";
	      }
  		}
  		calculateGrossMargin();
	}
   
    function cstOwnerChange(){
		var cstOwner = YAHOO.util.Dom.get("costOwner");
		AddCandidateTemp.updateTop2Top(cstOwner.value,getDWRCallbackMethod(top2topCallBack));
    }

 	function top2topCallBack(data){
	 	dwr.util.removeAllOptions("top2Top");
		dwr.util.addOptions("top2Top", data, "id", "name");
 	}
 	
 //*************************************** Functions For displaying vendorTie/vendorTier ******************************************************************//	
 	
 	function dispVendor(){
 		if(null != document.getElementById('venTie')){
 			document.getElementById('venTie').style.display = 'block';
 		}
 		if(null != document.getElementById('venTie')){
 			document.getElementById('venTieText').style.display = 'block';
 		}
 		if(null != document.getElementById('venTie')){
 			document.getElementById('venTier').style.display = 'block';
 		}
 		if(null != document.getElementById('venTie')){
 			document.getElementById('venTierText').style.display = 'block';
 		}
	  	var orderRes = document.getElementById('orderRes');
	  	var orderResLabel= document.getElementById('orderResLabel');	
      	var costLink = document.getElementById('costLink');
      	var costLinkLabel= document.getElementById('costLinkLabel');
      	
	  	//Order Unit Changes
	  	var orderUnitLabelDiv = document.getElementById('orderUnitLabelDiv');
	  	var orderUnitDiv= document.getElementById('orderUnitDiv');      	
		if(orderUnitLabelDiv){
        	orderUnitLabelDiv.style.display = 'block';
		}	
		if(orderUnitDiv){
			orderUnitDiv.style.display = 'block';
		}			      	
		if(orderRes){
        	orderRes.style.display = 'block';
		}	
		if(orderResLabel){
			orderResLabel.style.display = 'block';
		}		
		if(costLink){
			costLink.style.display = 'block';
		}
		if(costLinkLabel){
			costLinkLabel.style.display = 'block';
		}
		showVendorCostLinkDetails(true);
						
 	}
 	
 	function hideVendor() {
 		if(null != document.getElementById('venTie')){
 			document.getElementById('venTie').style.display = 'none';
 		}
	 	if(null != document.getElementById('venTieText')){
	 		document.getElementById('venTieText').style.display = 'none';
	 	}
	 	if(null != document.getElementById('venTier')){
	 		document.getElementById('venTier').style.display = 'none';
	 	}
	 	if(null != document.getElementById('venTierText')){
	 		document.getElementById('venTierText').style.display = 'none';
	 	}
	  	var orderRes = document.getElementById('orderRes');
	  	var orderResLabel= document.getElementById('orderResLabel');	
      	var costLink = document.getElementById('costLink');
      	var costLinkLabel= document.getElementById('costLinkLabel');
      	
       	//Order Unit Changes
	  	var orderUnitLabelDiv = document.getElementById('orderUnitLabelDiv');
	  	var orderUnitDiv= document.getElementById('orderUnitDiv');      	
		if(orderUnitLabelDiv){
        	orderUnitLabelDiv.style.display = 'none';
		}	
		if(orderUnitDiv){
			orderUnitDiv.style.display = 'none';
		}		 	
 		if(orderRes){
        	orderRes.style.display = 'none';
		}
		if(orderResLabel){
			orderResLabel.style.display = 'none';
		}
		if(costLink){
			costLink.style.display = 'none';
		}
		if(costLinkLabel){
			costLinkLabel.style.display = 'none';
		}			
 		showVendorCostLinkDetails(false);
 	}
 	
 	function dispEWM(){
 	   if(document.getElementById('ewmMandatory')){
 			document.getElementById('ewmMandatory').style.display = 'block';
 		}
 	}
 	function hideEWM(){
 		if(document.getElementById('ewmMandatory')){
 			document.getElementById('ewmMandatory').style.display = 'none';
 		}
 	}
  
function enableActivation(){
	AddCandidateTemp.enableActivateButton(getDWRCallbackMethod(enableActivationCB))
	
}
function enableActivationCB(data){
	if(document.getElementById('activateButton')){
		document.getElementById('activateButton').disabled = !data;
	}
}

	function enableActivationCBForMRT(){
		if(document.getElementById('activateButton')){
			document.getElementById('activateButton').disabled = true;
		}
	}

 //@author khoapkl
	function enableButtonsViewMRTProduct() {
		if(${CPSForm.viewOnlyProductMRT == true}){
			if(document.getElementById('activateButton-button')){
				document.getElementById('activateButton-button').disabled = true;
			}
			document.getElementById('printFormId-button').disabled = true;
			document.getElementById('saveButton-button').disabled = true;
			document.getElementById('rejectBut-button').disabled = true;
			document.getElementById('import').disabled = true;
			document.getElementById('mrtInputTable').style.display='none';
			if(document.getElementById('approveButton-button')){
				document.getElementById('approveButton-button').disabled = true;
			}
			if(document.getElementById('deleteBtn-button')){
				document.getElementById('deleteBtn-button').disabled = true;
		}
	}
	}
	function enablePrintFormForMRT(){
		if(document.getElementById('printFormId')){
			var printFormId = new YAHOO.widget.Button("printFormId");
			YAHOO.util.Event.removeListener("printFormId", "click");
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("printFormId"), "click", printFormPopUp);
			document.getElementById('printFormId').disabled = false;
		}
	}
	
function enableSaveCaseBut(data){
		if(YAHOO.util.Dom.get("AVupc")){
				YAHOO.util.Dom.get("AVupc").style.display = 'inline';
				YAHOO.util.Dom.get("AVupc").disabled = false;
				YAHOO.util.Event.removeListener("AVupc", "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("AVupc"), "click", updateCaseLinkDetails);
		}		
}

function updateCaseLinkDetails(){
	var caseVO = getCurrentCaseObject();
	var uniqueId = document.getElementById('selectedCaseUniqueId').value;
	showProgress();
	AddCandidateTemp.saveCaseVO(uniqueId, caseVO,getDWRCallbackMethod(disableSaveBut));
}

function disableSaveBut(){
	//hideProgress();
	if(YAHOO.util.Dom.get("AVupc")){
		YAHOO.util.Dom.get("AVupc").disabled = true;
	}
	//isSavingCase=false;
	AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligible));
}

function formatValue(t){
	return parseFloat('' + t).toFixed(4);
}

//958 enhancements
function validateSubDept(){
	if(!document.getElementById('subDept')) return;
	if(document.getElementById('subDeptDiv').style.display == 'none') return;
	var subDept = document.getElementById('subDept').value;
	if(null == subDept || "" == subDept){
		alert("Please enter a Sub-Dept");
		return;
	}else{
		if(subDept.length > 1){
			var len = (subDept.length)-1;
			var deptId = subDept.substring(0, len);
			var subDeptId = subDept.substring(len);
			if(null != deptId && deptId.length == 1){
				deptId = "0" + deptId;
			}	
			if(null != subDeptId){
				subDeptId = subDeptId.toUpperCase();
			}
			if(isNaN(deptId)==false && isNaN(subDeptId)==true){
				document.getElementById('subDept').value = deptId + subDeptId;
				clearVendor();
				var sel = document.getElementById('actions3');
				showProgress();
				AddCandidateTemp.getVendorLocationListForSubDept(deptId, subDeptId, sel.options[sel.selectedIndex].value,getDWRCallbackMethod(null));

				//958 PSS change
				//if(document.getElementById('subDept').value != '${CPSForm.defaultSubDept}'){
				//	showProgress();
					AddCandidateTemp.getPssDeptForVendor(deptId, subDeptId, getDWRCallbackMethod(updateVendorPSSList));	
				//}
			}else{
				displayErrorMsgForSubDept();	
			}
		}else{
			displayErrorMsgForSubDept();
		}
	}	
}



function displayErrorMsgForSubDept(){
	alert('Please enter a valid Sub-Dept');
	document.getElementById('subDept').value ='';
	document.getElementById('subDept').disabled = false;
	document.getElementById('subDept').focus();
}

function clearVendor(){
	 if(YAHOO.util.Dom.get('vendorLocation')){
	 		document.getElementById('vendorLocation').value = ''; 
			}
	 if(YAHOO.util.Dom.get('vendorLocationVal')){
	 		document.getElementById('vendorLocationVal').value = ''; 
			}
	 if(YAHOO.util.Dom.get('vendorACInput')){
	 		document.getElementById('vendorACInput').value = ''; 
			}	
}

//Fix 1286
function validateShip(data){
	if (document.getElementById("masterPackText") && document.getElementById("shipPackText")){
		if ( document.getElementById("masterPackText").value == document.getElementById("shipPackText").value ){
			if(data == 'Length'){
				if(document.getElementById("shipLength").value != document.getElementById("masterLength").value){
					alert("Length for the ship pack is different than the master pack");
				}
			}
			else if(data == 'Height'){
				if(document.getElementById("shipHeight").value != document.getElementById("masterHeight").value){
					alert("Height for the ship pack is different than the master pack");
				}
			}
			else if(data == 'Width'){
				if(document.getElementById("shipWidth").value != document.getElementById("masterWidth").value){
					alert("Width for the ship pack is different than the master pack");
				}
			}
		}
	}
}

function chekDecimalValue(obj, decimalLength){
	value = obj.value;
	if(isNaN(value)){
		obj.value = "";
		return;
	}
	if(value== null || value=="") return;
	
	if(value.length>0 && parseFloat(value) == 0){
		alert("Please enter value greater than 0");
		obj.value = "";
		return;
	}
	
	var index = value.indexOf('.');
	if(index >= 0){
		if(index == 0){
			value = "0" + value;
			index = value.indexOf('.');
		}
		var dec=value.substring(index,value.length);
		if(dec.length > decimalLength +1){
			obj.value = parseInt(value) + value.substring(index,index +decimalLength+1);
		}
		else{
			for(var i=0; i < decimalLength + 1 - dec.length; i++){
				value += "0";
			}
			obj.value = value;
		}
	}
	else{
		value += ".";
		for(var i=0; i < decimalLength; i++){
			value += "0";
		}
		obj.value = value;
	}
	if(parseFloat(value) == 0){
		alert("Please enter value greater than 0");
		obj.value = "";
	}

}

function checkLength(data){
	if(data == 'master'){
		if(document.getElementById("masterLength").value > 999.9){
			alert("Maximum value for master pack length is 999.9. Please re-enter.");
			document.getElementById("masterLength").value = '';
		}
		else
			chekDecimalValue(document.getElementById("masterLength"), 1);
	}
	else if(data == 'ship'){
		if(document.getElementById("shipLength").value > 999.9){
			alert("Maximum value for ship pack length is 999.9. Please re-enter.");
			document.getElementById("shipLength").value = '';
		}
		else
			chekDecimalValue(document.getElementById("shipLength"), 1);
	}
}
function checkHeight(data){
	if(data == 'master'){
		if(document.getElementById("masterHeight").value > 999.9){
			alert("Maximum value for master pack height is 999.9. Please re-enter.");
			document.getElementById("masterHeight").value = '';
			return true;
		}
		else
			chekDecimalValue(document.getElementById("masterHeight"), 1);		
	}
	else if(data == 'ship'){
		if(document.getElementById("shipHeight").value > 999.9){
			alert("Maximum value for ship pack height is 999.9. Please re-enter.");
			document.getElementById("shipHeight").value = '';
		}
		else
			chekDecimalValue(document.getElementById("shipHeight"), 1);				
	}
}
function checkWidth(data){
	if(data == 'master'){
		if(document.getElementById("masterWidth").value > 999.9){
			alert("Maximum value for master pack width is 999.9. Please re-enter.");
			document.getElementById("masterWidth").value = '';
		}
		else
			chekDecimalValue(document.getElementById("masterWidth"), 1);	
	}
	else if(data == 'ship'){
		if(document.getElementById("shipWidth").value > 999.9){
			alert("Maximum value for ship pack width is 999.9. Please re-enter.");
			document.getElementById("shipWidth").value = '';
		}
		else
			chekDecimalValue(document.getElementById("shipWidth"), 1);	
	}
}

//958 PSS changes
function updateVendorPSSList(data){
	hideProgress();	
	if(document.getElementById('vendPssDept')){
		if(data !=null && data !=""){
			var originalPssDept=document.getElementById("vendPssDept").value;
			dwr.util.removeAllOptions("vendPssDept");
			dwr.util.addOptions("vendPssDept", data, "id", "name");
			//Fix QC-1501 (step 5)
			//Keep PssDept from Product & UPC tab
			document.getElementById("vendPssDept").value=originalPssDept;
			if(null == document.getElementById("vendPssDept").value || "" == document.getElementById("vendPssDept").value){				
				dwr.util.setValue('vendPssDept',data[0].name);	
			}
		}
		document.getElementById('vendPssDept').disabled = false;
	}
	
}

// [[#1110
function checkValidImportVO()
{	
	var importFields = [
		'cntnSize',
		'pcikPoint',
		'freight',
		'minQntity',
		'color',
		'incoTerms',
		'rate',
		'minType',
		'hts',
		'duty',
		'agentPer',
		'cartMarketing'
	];
	var importData = false;	
	if(YAHOO.util.Dom.get('import')){	
		importData = YAHOO.util.Dom.get("import").checked;
	}
	if(importData){
		for(var index in importFields){
			if(document.getElementById(importFields[index]) != null){
				if(document.getElementById(importFields[index]).value ==''){				
					return false;
				}		
			}
		}
	}
	return true;
}

function ReplaceAll(Source,stringToFind,stringToReplace){

  var temp = Source;

    var index = temp.indexOf(stringToFind);

        while(index != -1){

            temp = temp.replace(stringToFind,stringToReplace);

            index = temp.indexOf(stringToFind);

        }

        return temp;

}
function checkFactorylist()
{
	var factoryList='';
	if(YAHOO.util.Dom.get('factoryList')){
			factoryList = YAHOO.util.Dom.get("factoryList").value;
			if(factoryList=='') return false;
		}
	return true;	
}

function checkExistWareHouse(ext)
{
	authenWHScheck=false;
	if(ext=="true") authenWHScheck=true;
	
}
function seasonalityChange()
{
	if(YAHOO.util.Dom.get('seasonality'))
		{
			var seasonality2 = YAHOO.util.Dom.get("seasonality");
			var	seasonality =  seasonality2.options[seasonality2.selectedIndex].text;		
				if(YAHOO.util.Dom.get('season'))
					{
						if(seasonality=="--Select--")
							{
								seasonality="";
							}
						YAHOO.util.Dom.get('season').value=seasonality;
					}
		}				
}
function seasonalityYearChange()
{
	if(YAHOO.util.Dom.get('seasonalityYear'))
		{
			var	seasonalityYr = YAHOO.util.Dom.get("seasonalityYear").value;
				if(YAHOO.util.Dom.get('sellYear'))
				{
					YAHOO.util.Dom.get('sellYear').value=seasonalityYr;
				}
		}
}
function IsNumeric(sTextObj)
{	
   var ValidChars = "0123456789";
   var IsNumber=true;
   var Char;
   var sText=trim(sTextObj.value);   
   for (i = 0; i < sText.length && IsNumber == true; i++) 
      { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
         {
         IsNumber = false;
         }
      }
   if(!IsNumber) 
	{
		YAHOO.util.Dom.get(sTextObj.id).value="";
		YAHOO.util.Dom.get(sTextObj.id).focus();
	}
 }
 function isNumericAndPadHts(sTextObj){	
   var ValidChars = "0123456789";
   var padZero = "0000000000";
   var IsNumber=true;
   var Char;
   var sText=trim(sTextObj.value); 
   if(sText != ""){
	   for (i = 0; i < sText.length && IsNumber == true; i++){ 
	  		Char = sText.charAt(i); 
	  		if (ValidChars.indexOf(Char) == -1){
	     		IsNumber = false;
	     	}
	   }
	   if(IsNumber){
		var strPad = padZero.substring(0,10 - sText.length)+ sText;
		YAHOO.util.Dom.get(sTextObj.id).value = strPad;
	   }else {
			YAHOO.util.Dom.get(sTextObj.id).value = "";
			YAHOO.util.Dom.get(sTextObj.id).focus();
	   }
   }
 }
 function padHts(sTextObj){
 	var strPad = "";
 	var sText=trim(sTextObj);
 	if(sText != ""){
	  	var padZero = "0000000000";	  	   
	  	strPad = padZero.substring(0,10 - sText.length)+ sText;
 	}
    return strPad;   
 }
 function onChangeOrderUnit(object){
 	if(object != null){
 		var ordUnitTxt = YAHOO.util.Dom.get(object.id).options[YAHOO.util.Dom.get(object.id).options.selectedIndex].text;
 		YAHOO.util.Dom.get('minType').value = filterKey(ordUnitTxt);
 	}
 }
 function filterKey(ordUnitTxt){
 	var indx = ordUnitTxt.indexOf('[');
	if(ordUnitTxt != "" && indx > -1){
		ordUnitTxt = ordUnitTxt.substring(0,indx);
	}
	return trim(ordUnitTxt);
 }
 function onBlurMinType(object){
 	if(YAHOO.util.Dom.get('orderUnit') != null){ 	
		var ordUnitTxt = YAHOO.util.Dom.get('orderUnit').options[YAHOO.util.Dom.get('orderUnit').options.selectedIndex].text;
		YAHOO.util.Dom.get(object.id).value = filterKey(ordUnitTxt);
	}
 }
// #1110]]
 
<!-- ***1205 Edit Case - Edit Vendor***START*** -->
	var caseFields = [
		'caseDescriptionText',
		'masterPackText'	,
		'caseUpcText',
		'caseCheckDigit',
		'masterLength',
		'masterWidth',
		'masterHeight',
		'masterWeight',
		'shipPackText',
		'shipLength',
		'shipWidth',
		'shipHeight',
		'shipWeight',
		'unitFactor',
		'maxShipText',
		'oneTouchType',
		'itmCategory',	
		'catchRadio',	
		'variableRadio',
		'noneRadio',
		'purchaseStatus',
		'codeDate',
		'shelfDays',
		'inboundDays',
		'reactionDays',
		'guaranteestoreDays'
			
	];
	var caseDRUFields = [		
		'dsplyDryPalSwId',
		'srsAffTypCdId',
		'prodFcngNbrId',
		'prodRowDeepNbrId',
		'prodRowHiNbrId',
		'nbrOfOrintNbrId'		
	];
	var vendorFields = [
		'subDept',
		'vpc',
		'listCost',
		'vendorTie',
		'vendorTier',
		'countryOfOrigin',
		'costOwner',
		'top2Top',
		'seasonalityYear',
		'seasonality',
<!-- 		'costRadio', -->
<!-- 		'itemRadio', -->
		'costLinkBy',
		'orderUnit',
		'costlist',
		'expectedweeklymovement',
		'orderRestriction',
		'import',
		'gSales',
		'dealOffered',
		'cntnSize',
		'pcikPoint',
		'freight',
		'minQntity',
		'color',
		'incoTerms',
		'prorDate',
		'rate',
		'minType',
		'instoreDate',
		'hts',
		'duty',
		'dutyInfo',
		'agentPer',
		'whseFlushDate',
		'cartMarketing',
		'hts2',
		'hts3',
		'dutyCalend',
		'propDate',
		'freights',
		'storeDate',
		'flushDate',		
	];
	
	function disabledVendorFields(isDisabled){
		for(var index in vendorFields){
			if(document.getElementById(vendorFields[index]))
			{
				document.getElementById(vendorFields[index]).disabled = isDisabled;
<!-- 				if(vendorFields[index] == 'costRadio' || vendorFields[index] == 'itemRadio'){ -->
				if(vendorFields[index] == 'costLinkBy'){
					var costLinkBy = document.getElementById("costLinkBy");
					if(costLinkBy.value =="cl" || costLinkBy.value =="ic"|| costLinkBy.value =="up"){
						document.getElementById('listCost').disabled = true;
					}
				}
			}
		}
		if (isWorkingKitComponents() && ${not empty CPSForm.hiddenKitCost}) {
			document.getElementById('listCost').disabled = true;
			document.getElementById('costLinkBy').disabled = true;
			document.getElementById('costlist').disabled = true;
		}
	}
	
	function disabledCaseFields(isDisabled){
		for(var index in caseFields){
			//HoangVT - when login as vendor -> fields: reactionDays and guaranteestoreDays are invisible
			// for vendor -> error javascript
			if(document.getElementById(caseFields[index]))
				document.getElementById(caseFields[index]).disabled = isDisabled;
		}
	}
	function disabledDRUField(isDisabled){		
		for(var index in caseDRUFields){		
			if(document.getElementById(caseDRUFields[index]))
				document.getElementById(caseDRUFields[index]).disabled = isDisabled;
		}
	}
	function disabledCaseUPC(isDisabled){
		var caseUpcTable = document.getElementById('upcTable');
		for(var i=0;i< caseUpcTable.rows.length-1;i++){
			var caseCheckBox = document.getElementById("upcCaseCheck"+i);
			caseCheckBox.disabled = isDisabled;
			if(caseCheckBox.checked==true){
				document.getElementById("caseUPCRadio"+i).disabled = isDisabled;
			}
		}
	}
	
	function disabledVendor(){
		disabledVendorFields(true);
		document.getElementById('vendorAutoComplete').style.display = 'none';
		document.getElementById('vendorDisable').style.display = 'block';
		var vendorLoc = document.getElementById('vendorLocationView');
		vendorLoc.value = document.getElementById('vendorACInput').value;
		
		//HoangVT - [#1387 - Import Section] the Import Factory still enable in VIEW mode
		YAHOO.util.Dom.get("importFacilities").disabled = false;
		//document.getElementById('enableFactoryDiv').style.display = 'none';
		
		document.getElementById('addButton6').disabled = true;
		document.getElementById('vendorCancel').disabled = true;
		disableAddEditDelVendorBtns(false);
	}
	
	function onCancleClick(){
		var caseRow = tableToRowClikedMap['caseItemTbody'];
		var caseRowCount = tableToRowClikedMap['caseItemTbodycount'];
		if(caseRow!=null){
			if(caseRow.indexOf("ajaxCase")<0){
				makeRowClickedForTable('caseItemTbody',caseRow,caseRowCount,'#FFAA00');
				displayDetailsSetCount(caseRowCount);
			}
			else {
				makeRowClickedForTable("caseItemTbody",caseRow,caseRowCount,'#FFAA00');							
				displayDetailsForAjaxRows(caseRowCount,true); 
				document.getElementById('addCaseBut').disabled = false;
			}
		}
		else {
			clearCaseItemDetails();
		}
	}	
	
	function editVendorDetails(evt){
		disabledVendorFields(false);
		document.getElementById('vendorAutoComplete').style.display = 'block';
		document.getElementById('vendorDisable').style.display = 'none';
		document.getElementById('addButton6').disabled = false;	
		
		//HoangVT - [#1387 - Import Section] the Import Factory still enable in VIEW mode -  enbale when click 'Edit selected vendor'
		document.getElementById('importFacilities').disabled = false;
		
		document.getElementById('vendorCancel').disabled = false;	
		disableAddEditDelVendorBtns(true);
		var viewMode = false;
		if(document.getElementById('viewMode')){
			viewMode = 	document.getElementById('viewMode').value;
		}
		if(document.getElementById('subDept')){
			 document.getElementById('subDept').disabled = viewMode;
		}
		doDisableCstLnkDsdBaseVendorWhenEdit(vendorChannel);
		disabledVendorByMorph();
	}
	var isVendorCancelClick = null;
	function onVendorCancelClick(evt){
		var vendorRow = tableToRowClikedMap['vendorTable'];
		var vendorRowCount = tableToRowClikedMap['vendorTablecount'];
		if(vendorRow!=null){
			if(vendorRow.indexOf("vendorAjax")< 0){
				makeRowClickedForTable('vendorTable',vendorRow,vendorRowCount,'#FFAA00');
				displayVendorDetails(vendorRowCount);
			}
			else{
				makeRowClickedForTable('vendorTable',vendorRow,vendorRowCount,'#FFAA00');
				isVendorCancelClick = "onVendorCancelClick";
				displayVendorDetailsAjax(vendorRowCount,true);
			}
		}
		disableAddEditDelVendorBtns(false);
		if(document.getElementById("grossProfit")) {
			document.getElementById("grossProfit").innerHTML="";
		}
		if(document.getElementById("grossMargin")) {
			document.getElementById("grossMargin").innerHTML="";
		}
	}
	
	function checkCaseDesValue() {
		if(document.getElementById('caseDescriptionText').value == ''){
			alert('Please enter a value in Case Description field!');
			return true;
		}
		return false;
	}
	function checkCaseUPC(){	
		var channel = document.getElementById('actions3');
		if(channel){
			var selected = channel.options[channel.selectedIndex].value;			
			if(selected== 'WHS'||selected == 'BOTH'){		
				if(document.getElementById('caseUpcText')!=null){
					if(trim(document.getElementById('caseUpcText').value) != ''){
				if(isNaN(trim(document.getElementById('caseUpcText').value))){
   					alert("Case UPC Must be Number");
   					document.getElementById('caseUpcText').value = "";
   					return true;
   				}				
					} else {
						alert('Please enter the Case UPC value');
						return true;
					}
				}
			}
		}
		return false;
	}
	function checkDRU(){
		var prodFcngNbrValue = document.getElementById('prodFcngNbrId').value; 
		var prodRowDeepNbrValue = document.getElementById('prodRowDeepNbrId').value; 
		var prodRowHiNbrValue = document.getElementById('prodRowHiNbrId').value; 		
		var channel = document.getElementById('actions3');
		var typeDisplayReadyUnitId = document.getElementById('typeDisplayReadyUnitId');		
		var dsplyDryPalSwId = document.getElementById('dsplyDryPalSwId');		
		var srsAffTypCdId = document.getElementById('srsAffTypCdId');	
		var selectedSrsAffTypCd = srsAffTypCdId.options[srsAffTypCdId.selectedIndex].value;		
		if(dsplyDryPalSwId.checked){	
			if(channel){
				if(selectedSrsAffTypCd == '7'|| selectedSrsAffTypCd=='9'){
					var selected = channel.options[channel.selectedIndex].value;			
					if(selected== 'WHS'||selected == 'BOTH'){					
						var shipPackQty = document.getElementById('shipPackText').value; 
						if(shipPackQty == ''){
							alert('Please input Ship Pack');
							return true;
						} else if(prodFcngNbrValue == ''|| prodRowDeepNbrValue == '' || prodRowHiNbrValue == ''){
							alert('Please input required fields.');
							return true;
						} else if(parseInt(prodFcngNbrValue)<=0 || parseInt(prodRowDeepNbrValue) <=0 || parseInt(prodRowHiNbrValue) <=0){
							alert('Rows value must be greater than zero');
							return true;
						} else {
							var total = parseInt(prodFcngNbrValue) * parseInt(prodRowDeepNbrValue) * parseInt(prodRowHiNbrValue);
							if(total != shipPackQty){
								alert('Product of rows Facing, rows Deep and rows High is not equal to Ship Pack quantity. Please enter the values again');
								return true;
							}
						}
					} else {
						var masterPackQty = document.getElementById('masterPackText').value; 
						if(masterPackQty == ''){
							alert('Please input Master Pack');
							return true;
						} else if(prodFcngNbrValue == ''|| prodRowDeepNbrValue == '' || prodRowHiNbrValue == ''){
							alert('Please input required fields.');
							return true;
						} else if(parseInt(prodFcngNbrValue)<=0 || parseInt(prodRowDeepNbrValue) <=0 || parseInt(prodRowHiNbrValue) <=0){
							alert('Rows value must be greater than zero');
							return true;
						} else {
							var total = parseInt(prodFcngNbrValue) * parseInt(prodRowDeepNbrValue) * parseInt(prodRowHiNbrValue);
							if(total != masterPackQty){
								alert('Product of rows Facing, rows Deep and rows High is not equal to Master Pack quantity. Please enter the values again');
								return true;
							}
						}
					}
				} else {
				alert('Please Selected Type Of Display Ready Unit ?');
				return true;
				}
			}
		}
		return false;
	}
	function checkDRUMRT(){
		var prodFcngNbrValue = document.getElementById('prodFcngNbrId').value; 
		var prodRowDeepNbrValue = document.getElementById('prodRowDeepNbrId').value; 
		var prodRowHiNbrValue = document.getElementById('prodRowHiNbrId').value; 		
		var channel = document.getElementById('actions3');
		var typeDisplayReadyUnitId = document.getElementById('typeDisplayReadyUnitId');		
		var dsplyDryPalSwId = document.getElementById('dsplyDryPalSwId');		
		var srsAffTypCdId = document.getElementById('srsAffTypCdId');	
		var selectedSrsAffTypCd = srsAffTypCdId.options[srsAffTypCdId.selectedIndex].value;		
		if(dsplyDryPalSwId.checked){	
			if(channel){
				if(selectedSrsAffTypCd != '7' && selectedSrsAffTypCd!='9'){
					alert('Please Selected Type Of Display Ready Unit ?');
					return true;
				} else if(prodFcngNbrValue == '' || parseInt(prodFcngNbrValue)<=0){
					alert('Please input Rows Facing in Retail Units and must be greater than zero');
					return true;
				}else if(prodRowDeepNbrValue == '' || parseInt(prodRowDeepNbrValue)<=0){
					alert('Please input Rows Deep in Retail Units and must be greater than zero');
					return true;
				}else if(prodRowHiNbrValue == '' || parseInt(prodRowHiNbrValue)<=0){				
					alert('Please input Rows High in Retail Units and must be greater than zero');
					return true;
				}
			}
		}
		return false;
	}
	<c:url value="/protected/cps/add/requestNewAtt?${_csrf.parameterName}=${_csrf.token}" var="page50" />
	var oneTime = false;
	function reqAttributeClick(evt){	
		///f1('${page50}'+'&t='+new Date().getTime(),'Request New Attribute','200px','62%','130px','200px');
		document.getElementById("RNAPanel").style.display="block";
		if(oneTime == false){
			oneTime = true;
			YAHOO.heb.container.reqNewAttrib = new YAHOO.widget.Panel("RNAPanel", 
			{ 	width:"600px", 
				height:"320px", 
				underlay:"shadow",
				visible:false, 
				constraintoviewport:true, 
				draggable:false,	
				zIndex : 15000,						
				modal:true,
				close:true,
				fixedCenter : true,
				effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}						
			} );
			
			YAHOO.heb.container.reqNewAttrib.render(document.body);
		
		}
		YAHOO.heb.container.reqNewAttrib.beforeHideEvent.subscribe(onBeforeRNAPanelHide);
		YAHOO.heb.container.reqNewAttrib.beforeShowEvent.subscribe(onBeforeShowRNAEvent);		
		YAHOO.heb.container.reqNewAttrib.show();

		document.getElementById("RNApopupFrame").style.height="100%";
		document.getElementById("RNApopupFrame").style.width="100%";
		document.getElementById("RNApopupFrame").src = "${page50}";	
		
	}
	function onShowRNAEvent(){
		//YAHOO.heb.container.reqNewAttrib.showMask();
	}
	function onBeforeShowRNAEvent(){
		
		//YAHOO.heb.container.reqNewAttrib.hideMask();
	}
	function onBeforeRNAPanelHide(){
		document.getElementById("RNAPanel").style.display="hidden";	
		document.getElementById("RNApopupFrame").src = "";
	}
	function closeRNAPanel(){
		YAHOO.heb.container.reqNewAttrib.hide();
	}
	
	function disableAddEditDelVendorBtns(isDisabled){
		if(document.getElementById('addCaseDetailsBut')){
			document.getElementById('addCaseDetailsBut').disabled = isDisabled;
		}
		if(document.getElementById('editVendorDetailsBut')){
			document.getElementById('editVendorDetailsBut').disabled = isDisabled;
		}
		if(document.getElementById('deleteVendorDetailsBut')){
			document.getElementById('deleteVendorDetailsBut').disabled = isDisabled;
		}
		
		// PIM-1527 Kit components only have 1 vendor, so disable button add more vendors.
		if (isWorkingKitComponents()) {
			if (document.getElementById("vendorTable").rows.length > 1 && document.getElementById('addCaseDetailsBut').disabled == false) {
				document.getElementById('addCaseDetailsBut').disabled = true;
			}
		}
	}
	function doDisableCstLnkDsdBaseVendor(data)
	{
		 //var sel = document.getElementById('actions3');
 		if(data == 'D')
		{
			var vdId = document.getElementById('vendorLocationVal');
			var uniqueVendorIndex = vdId.value;
			if(uniqueVendorIndex.length > 0)
			{
				//showProgress();
				AddCandidateTemp.doCheckVendDCM(uniqueVendorIndex, getDWRCallbackMethod(doDisableCstLnkDsdBaseVendorCallBack));
			}			
		}	
	}	
	function doDisableCstLnkDsdBaseVendorCallBack(data)
	{
		//hideProgress();
		
		var costlinkid = document.getElementById('costlist');
<!-- 		var costlink = document.getElementById('costRadio'); -->
<!-- 		var itemcode = document.getElementById('itemRadio');	 -->
			var costLink = document.getElementById('costLink');
			var costLinkBy = document.getElementById('costLinkBy');
		if(!data)
		{	
			costlinkid.disabled = true;
			costLinkBy.disabled = true;
<!-- 			itemcode.disabled = true;	 -->
			if(document.getElementById('vendorAutoComplete').style.display =='block' || document.getElementById('vendorAutoComplete').style.display=='')
			{		
				clearCostLinkFields();	
<!-- 			if(costlink.checked == true || itemcode.checked == true){ -->
				if(costLinkBy.value == "cl" || costLinkBy.value == "ic" || costLinkBy.value == "up"){
					if(document.getElementById('listCost'))
					{
						document.getElementById('listCost').disabled=true;
					}	
				} else {
					if(document.getElementById('listCost'))
					{
						document.getElementById('listCost').disabled=false;
					}
				}	
			}	
		}
		else
		{	
			var viewMode = false;
			if(document.getElementById('viewMode')){
					viewMode = 	document.getElementById('viewMode').value;
			}
			if(!viewMode)
			{							
				if(document.getElementById('vendorAutoComplete').style.display =='block' || document.getElementById('vendorAutoComplete').style.display=='')
				{		
					costlinkid.disabled = false;
					costLinkBy.disabled = false;
<!-- 					itemcode.disabled = false; -->
<!-- 					if(costlink.checked == true || itemcode.checked == true){			 -->
					if(costLinkBy.value == "cl" || costLinkBy.value == "ic" || costLinkBy.value == "up"){
						if(document.getElementById('listCost'))
						{
							document.getElementById('listCost').disabled=true;
						}	
					} else {
						if(document.getElementById('listCost'))
						{
							document.getElementById('listCost').disabled=false;
						}
						costlinkid.disabled = true;
					}
				}
			}
		}
	}
	
	function doDisableCstLnkDsdBaseVendorWhenEdit(data)
	{
		 //var sel = document.getElementById('actions3');
 		if(data == 'D')
		{
			var vdId = document.getElementById('vendorLocationVal');
			var uniqueVendorIndex = vdId.value;
			if(uniqueVendorIndex.length > 0)
			{
				showProgress();
				AddCandidateTemp.doCheckVendDCM(uniqueVendorIndex, getDWRCallbackMethod(doDisableCstLnkDsdBaseVendorCallBackWhenEdit));
			}			
		}	
	}
	
	function doDisableCstLnkDsdBaseVendorCallBackWhenEdit(data)
	{
		hideProgress();
		var costlinkid = document.getElementById('costlist');
		var costLink = document.getElementById('costLink');
		var costLinkBy = document.getElementById('costLinkBy');
		if(!data)
		{					
			costlinkid.disabled = true;
			costLinkBy.disabled = true;
			if(costLinkBy.value == "cl" || costLinkBy.value == "ic" || costLinkBy.value == "up"){
				if(document.getElementById('listCost'))
				{
					document.getElementById('listCost').disabled=true;
				}	
			} else {
				if(document.getElementById('listCost'))
				{
					document.getElementById('listCost').disabled=false;
				}
			}			
		}else{			
			var viewMode = false;
			if(document.getElementById('viewMode')){
					viewMode = 	document.getElementById('viewMode').value;
			}
			if(!viewMode)
			{							
				if(document.getElementById('vendorAutoComplete').style.display =='block' || document.getElementById('vendorAutoComplete').style.display=='')
				{		
					costlinkid.disabled = false;
					costLinkBy.disabled = false;
					if(costLinkBy.value == "cl" || costLinkBy.value == "ic" || costLinkBy.value == "up"){
						if(document.getElementById('listCost'))
						{
							document.getElementById('listCost').disabled=true;
						}	
					} else {
					if(document.getElementById('listCost'))
					{
						document.getElementById('listCost').disabled=false;
					}				
						costlinkid.disabled = true;
				}	
			}
		}
	}
}
	
	function getChannelFromCaseTable(){
		var count = "";
   		var rowId = getSelectedCaseRowID();
   		if(rowId != null){
			if(rowId.indexOf('ajaxCase') != -1){
				count = rowId.substring(8);
			}else if(rowId.indexOf('caseRow') != -1){
				count = rowId.substring(7);
			}
		}
   		var caseTable = document.getElementById("caseItemTbody");
   		for(var i = 0; i < caseTable.rows.length; i++){
   			var caseRowId = caseTable.rows[i].id;
   			var countTable = "";
				if(caseRowId.indexOf('ajaxCase') != -1){
					countTable = caseRowId.substring(8);
				}else if(caseRowId.indexOf('caseRow') != -1){
					countTable = caseRowId.substring(7);
				}
   			if(countTable == count){
   				return myTrim(caseTable.rows[i].cells[5].innerText);
   			}
   		}
   	}
	
   	function checkBicepInLstBicep(){
		 var sel = document.getElementById('vendorLocationVal');
		 uniqueVendorIndex = sel.value;
		 var caseUnique = getSelectedCaseID();
		 var channel = getChannelFromCaseTable(caseUnique);
		 var vendorUnique = getSelectedVendorId();
			msgSelectVendorAnother = null;
		if(channel == "WHS(DSDeDC)"){
			AddCandidateTemp.checkBicepInLstBicep(uniqueVendorIndex, vendorUnique, caseUnique, getDWRCallbackMethod(callbackcheckBicepInLstBicep));
		}
   	}
   	
   	function callbackcheckBicepInLstBicep(data){
   		msgSelectVendorAnother = null;
   		if(data != null && data != ""){
   			if(data == "CANMORPH"){
   				canmorph = data;
   			}else{
   				msgSelectVendorAnother = data;
   				alert(data);
   			}
   		}
   	}

	
	function afterBeforeMorph(data){
		if(myTrim(data.morphWarning) == "no_morphing"){
			hideProgress();
			beginMorph=false;
			if(showStorePopup==true) {
				reqStoreAttrCore();
			}
		}else if(myTrim(data.morphWarning) == "MORPH"){
			showProgress();
			beginMorph=false;
			addCaseMorphToTable(data);
		}else{
			hideProgress();
			alert(data.morphWarning);
		}
		if(callbackFunction != null){
			var tmp = callbackFunction;
			callbackFunction = null;
			tmp();
		}
	}
	
	
	function addCaseMorphToTable(data){
		var upcTableBody = document.getElementById('caseItemTbody');
			var rowLength = upcTableBody.rows.length; 
			if(rowLength > 0){
				addCountCase = rowLength+1;
			}else{
				addCountCase = 1;
			}

			var newRow = upcTableBody.insertRow(-1);
			newRow.id="ajaxCase"+addCountCase;
			var cntTmp = addCountCase;
			
			newRow.style.fontFamily = 'Verdana, Arial, Helvetica, sans-serif';
			newRow.style.fontSize = '12px';
			
			var col;
			col = "#FFF9F4";
			
			var classAppend = rowLength % 2;
			if(classAppend == 1){
				col = "#FEEADA";
			}else{
				col = "#FFF9F4";
			}
			newRow.style.backgroundColor = col;
			newRow.onclick = function(){ makeRowClickedForTable("caseItemTbody","ajaxCase"+cntTmp,cntTmp,'#FFAA00');	
										 displayDetailsForAjaxRows(cntTmp,true); 
							 };
			
			selectedRowNumber = cntTmp;	
			var	active = "";		
			if(isNaN(data.itemId)) {
				active="Active";
			}
			var checkMRT = '';
			if(data.mrt != null
				&& data.mrt == 'Y'){
				checkMRT = '<input type="checkbox" checked="checked"  disabled="disabled"/><input type="hidden" value="'+data.uniqueId+'" id="caseVOUniqueIdAjax'+cntTmp+'"/>';
			}else{
				checkMRT = '<input type="checkbox" disabled="disabled"/><input type="hidden" value="'+data.uniqueId+'" id="caseVOUniqueIdAjax'+cntTmp+'"/>';
			}
			
			
			var fifthRowData =  changeTo(data.caseDescription) + '<input type="hidden" id="caseDescAjax'+addCountCase+'" value="'+ changeTo(data.caseDescription)+'"/>	 ';	
			var hiddenPsItmId = '<input type="hidden" id="casePsItemId'+cntTmp+'" value="'+data.psItemId+'"/>';
			
			rowLength--;		
			var rowData = [			
			data.vpc, 
			data.formattedCaseUPC,
		
			'', 
			fifthRowData, 
			checkMRT,
			data.channel, 
			data.masterPack, 
			data.shipPack, 
			data.listCost,
			active,
			'',
			hiddenPsItmId
			];
			for (var i = 0; i < rowData.length; i++) {
		        newCell = newRow.insertCell(i);
		        newCell.align = "center";
		        newCell.style.backgroundColor = col;
		        newCell.innerHTML = rowData[i];
	   		}
	   		
	   		new YAHOO.widget.Button("deleteButAjx'+addCountCase+'");
	   		var idI = data.uniqueId;
  			var ary = [ newRow.id, idI ];
  	   		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteButAjx'+addCountCase+'"), "click", deleteSelectedCase1,ary);
  	   		selectChannelWHS();
	   		newRow.onclick();
	   		if(document.getElementById('editCaseBut')){
				document.getElementById('editCaseBut').style.display = 'inline';	
				document.getElementById('editCaseBut').disabled = false;	
				YAHOO.util.Event.removeListener(YAHOO.util.Dom.get("editCaseBut"), "click");				
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("editCaseBut"), "click", displayDetailsForAjaxRowsNP);
			}
			if(document.getElementById('deleteBut')){
				document.getElementById('deleteBut').style.display = 'inline';
				document.getElementById('deleteBut').disabled = false;	
				YAHOO.util.Event.removeListener(YAHOO.util.Dom.get("deleteBut"), "click");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteBut"), "click", deleteSelectedCase);
			}	
			if(document.getElementById('addCaseBut')){
				document.getElementById('addCaseBut').disabled = false;	
			}
			hideProgress();
			if(showStorePopup==true) {
				reqStoreAttrCore();
			}
		//AddCandidateTemp.initElligible(getDWRCallbackMethod(afterInitElligibleWithoutProcessBar));		
	}
	
	

	function isWHSDSDeDC(){
		var rowId = getSelectedCaseRowID();
		var count = "";
   		if(rowId != null){
			if(rowId.indexOf('ajaxCase') != -1){
				count = rowId.substring(8);
			}else if(rowId.indexOf('caseRow') != -1){
				count = rowId.substring(7);
			}
		}
		var caseTbl = document.getElementById('caseItemTbody');
			for(var i = 0; i < caseTbl.rows.length; i++){
				var caseRowId = caseTbl.rows[i].id;
				var countTable = "";
				if(caseRowId.indexOf('ajaxCase') != -1){
					countTable = caseRowId.substring(8);
				}else if(caseRowId.indexOf('caseRow') != -1){
					countTable = caseRowId.substring(7);
				}
				if(countTable == count){
					var WHSeDCValue = caseTbl.rows[i].cells[5].innerText;
					if(myTrim(WHSeDCValue) == "WHS(DSDeDC)"){
						return true;
					}
				}
			}
		return false;
	}
	
	
	function disableCaseBasedOnWHSeDC(flag){
		var masterPackDiv = document.getElementById('masterPackText');
		var shipPackDiv = document.getElementById('shipPackText');
		if(flag){
			if(masterPackDiv){
				masterPackDiv.readOnly= true;
				masterPackDiv.onkeydown=function(){
					event.returnValue = false;
					if(event.preventDefault) 
						event.preventDefault();
				};
				masterPackDiv.style.background = "#e5e5e5";
			}
			if(shipPackDiv){
				shipPackDiv.readOnly = true;
				shipPackDiv.onkeydown=function(){
					event.returnValue = false;
					if(event.preventDefault) 
						event.preventDefault();
				};
				shipPackDiv.style.background = "#e5e5e5";
			}
		}else{
			if(masterPackDiv){
				masterPackDiv.readOnly= false;
				YAHOO.util.Event.removeListener("masterPackDiv", "keydown");
				masterPackDiv.style.background = '';
			}
			if(shipPackDiv){
				shipPackDiv.readOnly = false;
				YAHOO.util.Event.removeListener("shipPackDiv", "keydown");
				shipPackDiv.style.background = '';
			}
		}
	
	}
	
	
	function disabledCaseForMorph(){
		var count = "";
		var rowId = getSelectedCaseRowID();
		if(rowId != null){
			if(rowId.indexOf('ajaxCase') != -1){
				count = rowId.substring(8);
			}else if(rowId.indexOf('caseRow') != -1){
				count = rowId.substring(7);
			}
		}
		
		
		disableCaseBasedOnWHSeDC(false);
		var caseTable = document.getElementById("caseItemTbody");
		for(var i = 0; i < caseTable.rows.length; i++){
			var caseRowId = caseTable.rows[i].id;
			var countTable = "";
			if(caseRowId.indexOf('ajaxCase') != -1){
				countTable = caseRowId.substring(8);
			}else if(caseRowId.indexOf('caseRow') != -1){
				countTable = caseRowId.substring(7);
			}
			var channel = caseTable.rows[i].cells[5].innerText;
			if(countTable == count){
				if(myTrim(channel) == "WHS(DSDeDC)"){
					disableCaseBasedOnWHSeDC(true);
					break;
				}				
			}
		}
	}
	
	
	function setReadOnlyDOM(flag, domEle){
		if(flag){
			if(domEle){
				domEle.readOnly= true;
				domEle.onkeydown=function(){
					event.returnValue = false;
					if(event.preventDefault) 
						event.preventDefault();
				};
				domEle.style.background = "#e5e5e5";
			}
		}else{
			if(domEle){
				masterPackDiv.readOnly= false;
				YAHOO.util.Event.removeListener("domEle", "keydown");
				domEle.style.background = '';
			}
		}
	}
	
	
	function disabledVendorByMorph(){
		var listcost = document.getElementById('listCost');
		setReadOnlyDOM(false, listcost);
		var rowId = getSelectedCaseRowID();
		var count = "";
		if(rowId != null){
			if(rowId.indexOf('ajaxCase') != -1){
				count = rowId.substring(8);
			}else if(rowId.indexOf('caseRow') != -1){
				count = rowId.substring(7);
			}
		}
		var caseTable = document.getElementById("caseItemTbody");
		for(var i = 0; i < caseTable.rows.length; i++){
			var caseRowId = caseTable.rows[i].id;
			var countTable = "";
				if(caseRowId.indexOf('ajaxCase') != -1){
					countTable = caseRowId.substring(8);
				}else if(caseRowId.indexOf('caseRow') != -1){
					countTable = caseRowId.substring(7);
				}
			var channel = caseTable.rows[i].cells[5].innerText;
			if(countTable == count){
				if(myTrim(channel) == "WHS(DSDeDC)"){
					setReadOnlyDOM(true, listcost);
					document.getElementById('vendorAutoComplete').style.display = 'none';
					document.getElementById('vendorDisable').style.display = 'block';
					var costLinkBy = document.getElementById('costLinkBy');
					var costlinkid = document.getElementById('costlist');
					if(costLinkBy){
						costLinkBy.disabled = true;
					}
					if(costlinkid){
						costlinkid.disabled = true;
					}
					break;
				}				
			}
		}
	}
	
	function deleteCaseItemeDCFromTbl(data){
		if(data.rmCaseChild != null){
			var result = myTrim(data.rmCaseChild);
			if(result != ""){
				var caseTbl = document.getElementById('caseItemTbody');
				for(var i = 0; i < caseTbl.rows.length; i++){
					var rowValue = caseTbl.rows[i].cells[caseTbl.rows[i].cells.length - 1].innerHTML;
					if(rowValue.indexOf(result) != -1){
						caseTbl.deleteRow(i);
						colorTableRows('caseItemTbody');
						break;
					}
				}
				resetScreenOnDeleteCase();
				if(document.getElementById('caseItemTbody').rows.length <= 0){
					var tBody = document.getElementById('vendorTable');
					var noOfRows = tBody.rows.length;
					document.getElementById('deleteVendorDetailsButDiv').style.display = 'none';
					document.getElementById('editVendorDetailsButDiv').style.display = 'none';
					showVendorDetailsToAdd();
					YAHOO.util.Event.removeListener("backButton", "click");
					YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backButton"), "click", showProd); 
				}
			}
		}
	}
	function deleteCaseItemeDCFromTbl1(data){
			if(data != ""){
				var caseTbl = document.getElementById('caseItemTbody');
				for(var i = 0; i < caseTbl.rows.length; i++){
					var rowValue = caseTbl.rows[i].cells[caseTbl.rows[i].cells.length - 1].innerHTML;
					if(rowValue.indexOf(data) != -1){
						caseTbl.deleteRow(i);
						colorTableRows('caseItemTbody');
						break;
					}
				}
				resetScreenOnDeleteCase();
				
		// Just select the first row.if there is any row else disable the add case button.
		if(document.getElementById('caseItemTbody').rows.length > 0){
			document.getElementById('caseItemTbody').rows[0].onclick();

			if(document.getElementById('addCaseBut')) {
				document.getElementById('addCaseBut').disabled = false;
			}	
			
			if(document.getElementById('editCaseBut')){
				document.getElementById('editCaseBut').disabled = false;	
			}
			
			if(document.getElementById('deleteBut')){
				document.getElementById('deleteBut').disabled = false;			
			}
		
		}else{
			if(document.getElementById('addCaseBut')) {
				document.getElementById('addCaseBut').disabled = true;
			}	
		
			if(document.getElementById('editCaseBut')){
				document.getElementById('editCaseBut').disabled = true;	
			}
			
			if(document.getElementById('deleteBut')){
				document.getElementById('deleteBut').disabled = true;			
			}
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("AVupc"), "click", addCaseDetailsToTable);
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("cancelBut"), "click", clearCaseItemDetails);
			AddCandidateTemp.getProductDescription(getDWRCallbackMethod(setCaseDescription));
		}
	}
	}
	
	function selectChannelWHS(){
			
			 var sel = document.getElementById('actions3');
	  var caseUpcDiv = document.getElementById('caseUpcDiv');
	  var oneTuchTypeDiv = document.getElementById('oneTuchTypeDiv');
	  var shipPackDiv = document.getElementById('shipPackDiv');
      var whs_details = document.getElementById('whs_details');
      var masterPackDiv = document.getElementById('masterPackDiv');
      var codeDateDiv = document.getElementById('codeDateDiv');
      var venTierText = document.getElementById('venTierText');
      var venTier = document.getElementById('venTier');
      var venTieText = document.getElementById('venTieText');
      var venTie = document.getElementById('venTie');
      
      var orderRes = document.getElementById('orderRes');
      var orderResLabel= document.getElementById('orderResLabel');

      var costLink = document.getElementById('costLink');
      var costLinkLabel= document.getElementById('costLinkLabel');         
      var displayReadyUnitDiv = document.getElementById('displayReadyUnitDiv');  
      var dsplyDryPalSwId = document.getElementById('dsplyDryPalSwId');	
			
			dispEWM();
            if(whs_details){
				whs_details.style.visibility = 'visible';
				whs_details.style.position = 'static';
			}
            showWhs_details(true);
			if(caseUpcDiv){
				caseUpcDiv.style.visibility = 'visible';
				caseUpcDiv.style.position = 'static';
			}
			if(oneTuchTypeDiv){
				oneTuchTypeDiv.style.visibility = 'visible';
				oneTuchTypeDiv.style.position = 'static';
		    }
			if(displayReadyUnitDiv){				
				 var typeDisplayReadyUnitId = document.getElementById('typeDisplayReadyUnitId');
				 displayReadyUnitClick();				
				displayReadyUnitDiv.style.visibility = 'visible';
				displayReadyUnitDiv.style.position = 'static';
				displayReadyUnitDiv.style.visibility = 'visible';
				displayReadyUnitDiv.style.position = 'static';
			} 
			
		    if(shipPackDiv){ 
		    	shipPackDiv.style.visibility = 'visible';
		    	shipPackDiv.style.position = 'static';
		    }
			if(masterPackDiv){
				masterPackDiv.style.visibility = 'visible';
				masterPackDiv.style.position = 'static';
			}
			if(venTierText){
				venTierText.style.display = 'block';
			}	
			if(venTier){
				venTier.style.display = 'block';
			}
			if(venTieText){
				venTieText.style.display = 'block';
			}
			if(venTie){
				venTie.style.display = 'block';
			}
			if(orderRes){
	        	orderRes.style.display = 'block';
			}	
			if(orderResLabel){
				orderResLabel.style.display = 'block';
			}		
			if(costLink){
				costLink.style.display = 'block';
			}
			if(costLinkLabel){
				costLinkLabel.style.display = 'block';
			}				
			
			//HungBang added clear fields when not save Case 04Feb2016
			try{
    	  		clearCaseDetailsForChannelChange();
  			}catch(e){}
			
			var codeDate;
			if(document.getElementById('codeDate')){
				codeDate = document.getElementById('codeDate').checked;
			}
			if(codeDate){
				if(codeDateDiv){
					codeDateDiv.style.visibility = 'visible';
					codeDateDiv.style.position = 'static';
				}
			}
			showCaseDetailsWtHtRadioSection(true);
			showVendorCostLinkDetails(true)
			setDefaultMaxShipValue();
			if(sel.options[sel.selectedIndex].value == 'BOTH'){
				showSubDept(true);
			}else{
				showSubDept(false);
			}
			changePurchaseStatus();
	}
	
	function hideVendorToogleButtonDuplicate() {
		var doc = document.getElementById("vendorToggle");
		var notes = null;
		if(doc!=null) {
			for (var i = 0; i < doc.childNodes.length; i++) {
				if (doc.childNodes[i].className == "yui-button yui-push-button" && i>0) {
					doc.childNodes[i].style.display='none';
				}        
			}
		}
	}
	
	var unAuthorizedStore706 = false;
	//call when user is unauthorized to store 706 on pop-up
	//QC-30
	function beforeMorph(selVendorUniqueId,selCaseUniqueId,selectedVendorId){
		AddCandidateTemp.beforeMorph(selVendorUniqueId,selCaseUniqueId, unAuthorizedStore706,selectedVendorId,getDWRCallbackMethod(afterBeforeMorph));
	}
	
	function loadDefaultChannel() {
		if(isWorkingKitComponents()) {
			selectChannelWHS();
			var sel = document.getElementById('actions3');
			if(sel)	{
				sel.disabled=true;
				sel.selectedIndex = 2;
			}
			if(YAHOO.util.Dom.get('masterPackText')){		
				document.getElementById('masterPackText').value = '1';
				document.getElementById('masterPackText').disabled = true;
			}
			 if(YAHOO.util.Dom.get('masterLength')){
				document.getElementById('masterLength').value = '1';
			}
			 if(YAHOO.util.Dom.get('masterHeight')){
				document.getElementById('masterHeight').value = '1';
			}
			 if(YAHOO.util.Dom.get('masterWeight')){
				document.getElementById('masterWeight').value = '1';
			}
			 if(YAHOO.util.Dom.get('masterWidth')){
				document.getElementById('masterWidth').value = '1';
			}
			 if(YAHOO.util.Dom.get('masterCubeLabel')){
				document.getElementById('masterCubeLabel').innerText = '';
			}
			if(YAHOO.util.Dom.get('shipPackText')){		
				document.getElementById('shipPackText').value = '1';
				document.getElementById('shipPackText').disabled = true;
			}
			if(YAHOO.util.Dom.get('shipLength')){
				document.getElementById('shipLength').value = '1';
			}
			if(YAHOO.util.Dom.get('shipWeight')){
				document.getElementById('shipWeight').value = '1';
			}
			if(YAHOO.util.Dom.get('shipHeight')){
				document.getElementById('shipHeight').value = '1';
			}
			if(YAHOO.util.Dom.get('shipWidth')){
				document.getElementById('shipWidth').value = '1';
			}
			if(YAHOO.util.Dom.get('shipCubeLabel')){
				document.getElementById('shipCubeLabel').innerText = '';
			}
			calculateMasterCube();
			calculateShipCube();
		} else {
			selectChannel();		
		}
	}
	
	function loadUPCTypeDefault() {
		//Sprint - 23
		if(isWorkingKitComponents()) {
			YAHOO.util.Dom.get("upcType1").selectedIndex=1;
			YAHOO.util.Dom.get("upcType1").disabled = true;
			YAHOO.util.Dom.get("prodTypeSelect").selectedIndex=1;
			YAHOO.util.Dom.get("prodTypeSelect").disabled = true;	
			YAHOO.util.Dom.get("prodTypeHidden").value='GOODS';
			//getUPCListsForProduct();
			getMerchandizeTypes();
			nonSellableHide();
			//setRetailValues();
			if (upcTableBody.rows.length <= 1) {
				saveUPCHook = true;
			}
			
		}
	}
	
	function clearKitComponent() {
		if(document.getElementById("unitUPCKit")!=null) {
			document.getElementById("unitUPCKit").value="";
		}
		if(document.getElementById("quantity")!=null) {
			document.getElementById("quantity").value="";
		}
		if(document.getElementById("upcDigit")!=null) {
			document.getElementById("upcDigit").value="";
		}
		if(document.getElementById("description")!=null) {
			document.getElementById("description").value="";
		}
		if(document.getElementById("avgCost")!=null) {
			document.getElementById("avgCost").value="";
		}
		if(document.getElementById("retailKit")!=null) {
			document.getElementById("retailKit").value="";
		}
		if(document.getElementById("extendedCost")!=null) {
			document.getElementById("extendedCost").value="";
		}
		if(document.getElementById("extendedRetail")!=null) {
			document.getElementById("extendedRetail").value="";
		}
	}
	
	function isWorkingKitComponents() {
		// check condition is Kit Components.
		return ${CPSForm.productVO.workRequest.intentIdentifier eq '12' || CPSForm.productVO.activeProductKit};
	}
	
	function initKitCostOfKitComponents() {
		// check condition Kit components have exist kit cost from Product & UPC tab.
		if (isWorkingKitComponents() && ${not empty CPSForm.hiddenKitCost}) {
			var hidden = '<c:out value="${CPSForm.hiddenKitCost}"/>';
			var listCost = formatValue(hidden);
			var shipPack = YAHOO.util.Dom.get("shipPackText").value;
			var result = listCost / shipPack;
			
			// display list cost is Kit cost, display unit cost, and disable list cost.
			document.getElementById('listCost').value = listCost;
			document.getElementById('unitCostLabel').innerText = formatValue(result);
			document.getElementById('listCost').disabled = true;
			document.getElementById('costLinkBy').disabled = true;
			document.getElementById('costlist').disabled = true;
			
			// calculate and display % margin and penny profit.
			calculateGrossMargin();
		}
	}