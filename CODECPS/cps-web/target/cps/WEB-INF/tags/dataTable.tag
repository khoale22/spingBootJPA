<%@ tag import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@attribute name="compId" required="true" rtexprvalue="true"%>
<%@attribute name="compName" required="false" rtexprvalue="true"%>
<%@attribute name="compGroupDes" required="false" rtexprvalue="true"%>
<%@attribute name="data" required="false" rtexprvalue="true"%>
<%@attribute name="columnDefs" required="false" rtexprvalue="true"%>
<%@attribute name="buildTable" required="false" rtexprvalue="true"%>
<%@attribute name="entyId" required="true" rtexprvalue="true"%>
<%@attribute name="groupId" required="true" rtexprvalue="true"%>
<%@attribute name="genericHiddenElmName" required="false"
	rtexprvalue="false"%>
<%@attribute name="brickSw" required="false" rtexprvalue="true"%>
<%@attribute name="viewMode" required="false" rtexprvalue="true"
	type="java.lang.Boolean"%>
<%@attribute  name="resourceId" required="false" rtexprvalue="false" %>
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
				} else {
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

<script type="text/javascript">
	var table${compId},
// 	var arrayCheckBoxDta${compId} = new Array(),
	myPanel${compId}, dt${compId};
	var columnDefs${compId} = ${columnDefs};
	var widthTable = (screen.width - 250)+"px";
	YAHOO.util.Event.onDOMReady(function(){
		buildTable${compId}();
    });
	function fillDataForTable${compId}(dataSource,key) {
		table${compId}.getDataSource().liveData = dataSource;
		table${compId}.getDataSource().sendRequest(null, {success: table${compId}.onDataReturnInitializeTable},table${compId});
	}
	function buildTable${compId}() {
		var dsLocalJSON = new YAHOO.util.LocalDataSource(${data});
		var columnDefsTemp = ${columnDefs};
		if(columnDefsTemp != null && columnDefsTemp.length > 0) {
			var widthColumn = (screen.width - 271)/columnDefsTemp.length;
			if(widthColumn < 300){widthColumn = 300;}
			for(var i = 0 ; i < columnDefsTemp.length; i ++) {
				var arrObj = columnDefsTemp[i];
					arrObj["width"] = widthColumn;
			}
		}
		table${compId} = new  YAHOO.widget.ScrollingDataTable("tableNutrient${compId}", columnDefsTemp, dsLocalJSON,{width:widthTable,height:"8em"});
		table${compId}.showTableMessage("");
        table${compId}.subscribe("rowMouseoverEvent", table${compId}.onEventHighlightRow);
        table${compId}.subscribe("rowMouseoutEvent", table${compId}.onEventUnhighlightRow);
        table${compId}.subscribe("rowClickEvent", table${compId}.onEventSelectRow);
//         table${compId}.render();
	}
	function fnInitialPopUp${compId}(dataListAttr) {
		// Create the DataTable.
		var columnDefsPop = ${columnDefs};
		if(columnDefsPop != null) {
			var arrObjSelect = {key: "select",label: "Select",formatter : "checkbox", width:50,className: 'align-center'};
			var dataCheckHidden = {key: "dataCheckHidden",label: "", width:0,hidden :true};
			columnDefsPop.splice(0,0,arrObjSelect);
			var widthColumn = 558/(columnDefsPop.length -1);
			if(widthColumn < 300){widthColumn = 300;}
			for(var i = 1 ; i < columnDefsPop.length; i ++) {
				var arrObj = columnDefsPop[i];
				arrObj["width"] = widthColumn;
				if(arrObj["attrValListSw"] == "N") {
					if(arrObj["dataType"] == "I") {
						arrObj["formatter"] = "textbox";
// 						arrObj["validator"] = YAHOO.widget.DataTable.validateNumber;
					}else {
						arrObj["formatter"] = "textbox";
					}
				}else {
					arrObj["formatter"] = "dropdown";
					if(dataListAttr != null) {
						for (var key in dataListAttr) {
							if(key ==arrObj["key"]) {
								arrObj["dropdownOptions"] = dataListAttr[key];
							}
						}
					}
					
				}
			}
			columnDefsPop.splice(columnDefsPop.length,0,dataCheckHidden);
		}
// 		select
		if(table${compId}.getDataSource().liveData != null && table${compId}.getDataSource().liveData.length > 0){
			for(var i = 0; i < table${compId}.getDataSource().liveData.length; i++){
				var dataObj = table${compId}.getDataSource().liveData[i];
				dataObj["dataCheckHidden"] = dataObj["select"];
				for (var key in dataObj) {
					var indx = key.indexOf('codeCd');
					if(indx > -1 && dataObj[key] != null && dataObj[key] != "") {
						dataObj[key.substr(0,indx)] = dataObj[key];
					}
				}
			}
		}
		dt${compId} = new  YAHOO.widget.ScrollingDataTable("nutrientDataTablePop${compId}", columnDefsPop,
				table${compId}.getDataSource(),{width:"650px",height:"350px"});
		dt${compId}.subscribe("dropdownChangeEvent", function(oArgs) {
			var elDropdown = oArgs.target;
			var oRecord = this.getRecord(elDropdown);
			var column = this.getColumn(elDropdown);
			var key = column.getKey();
			oRecord.setData(key,
					elDropdown.options[elDropdown.selectedIndex].text);
			var arr = column["dropdownOptions"];
			for(var i = 0; i < arr.length; i++) {
				if(elDropdown.options[elDropdown.selectedIndex].value == arr[i].value) {
					oRecord.setData(key+"codeId",arr[i].attrCdId);
					oRecord.setData(key+"codeCd",arr[i].value);
					oRecord.setData(key+"codeTxt",elDropdown.options[elDropdown.selectedIndex].title);
					break;
				}
			}
// 			dt${compId}.render();
		});
		// Subscribe to events for row selection
        dt${compId}.subscribe("rowMouseoverEvent", dt${compId}.onEventHighlightRow);
        dt${compId}.subscribe("rowMouseoutEvent", dt${compId}.onEventUnhighlightRow);
        dt${compId}.subscribe("rowClickEvent", dt${compId}.onEventSelectRow);
		dt${compId}.subscribe("checkboxClickEvent", function (oArgs) {
	        var elCheckbox = oArgs.target;
	        var oRecord = this.getRecord(elCheckbox);
	        var column = this.getColumn(elCheckbox);
			oRecord.setData(column.key,elCheckbox.checked);
			oRecord.setData("dataCheckHidden",elCheckbox.checked);
	    });
		YAHOO.util.Event.on(dt${compId}.getTbodyEl(),'keyup',function (ev) {
			var elInput = YAHOO.util.Event.getTarget(ev);
			if (elInput.tagName.toUpperCase() == 'INPUT') {
				var oRecord = dt${compId}.getRecord(elInput);
				var column = dt${compId}.getColumn(elInput);
				oRecord.setData(column.key,elInput.value);
			}
		});
		YAHOO.util.Event.on(dt${compId}.getTbodyEl(),'focusout',function (ev) {
			var elInput = YAHOO.util.Event.getTarget(ev);
			if (elInput.tagName.toUpperCase() == 'INPUT') {
				var oRecord = dt${compId}.getRecord(elInput);
				var column = dt${compId}.getColumn(elInput);
				if(column["dataType"] == "I"){
				}else if(column["dataType"] == "DEC"){
					var strNine = "999999999999999999999999999999999999999999999999999999999";
					if(elInput.value != ""){
// 						Don't limit if ATTR_MAX_LN_NBR =  NULL, ATTR_PRCSN_NBR = NULL
						if(column["prcsnNbr"] != null && column["maxLnNbr"] != null) {
							if(!validDecimal(column["prcsnNbr"],elInput.value,column["maxLnNbr"])){
								var labelColumn = column["label"];
				 				var index = labelColumn.search("<strong");
				 				if(index != -1) {
				 					labelColumn = labelColumn.substring(0,index);
				 					alert(labelColumn+" value must be equal or greater than 0 and less than or equal to "+strNine.substring(0,column["maxLnNbr"]-column["prcsnNbr"])+
				 							"."+strNine.substring(0,column["prcsnNbr"]));
				 				}else {
				 					alert(labelColumn+" value must be equal or greater than 0 and less than or equal to "+strNine.substring(0,column["maxLnNbr"]-column["prcsnNbr"])+
				 							"."+strNine.substring(0,column["prcsnNbr"]));
				 				}
								elInput.value = "";
							}else {
								if(elInput.value.length > 0){
									var arr = elInput.value.split('.');
									var strZero = "0000000000";
									if(arr != null && arr.length > 1){
										if(arr[1].length < column["prcsnNbr"]){
											var valueAfCom = arr[1]+strZero.substring(0,column["prcsnNbr"]- arr[1].length);
											elInput.value = arr[0]+"."+valueAfCom;
										}else if(arr[1].length > column["prcsnNbr"]){
											alert(column["label"]+" value must be equal or greater than 0 and less than or equal to "+strNine.substring(0,column["maxLnNbr"]-column["prcsnNbr"])+
						 							"."+strNine.substring(0,column["prcsnNbr"]));
											elInput.value = "";
										}
									}
								}
							}
						}
					}
				}
				oRecord.setData(column.key,elInput.value);
			}
		});
		YAHOO.util.Event.on(dt${compId}.getTbodyEl(),'keypress',function (ev) {
			var elInput = YAHOO.util.Event.getTarget(ev);
			if (elInput.tagName.toUpperCase() == 'INPUT') {
				var oRecord = dt${compId}.getRecord(elInput);
				var column = dt${compId}.getColumn(elInput);
				if(column["dataType"] == "I"){
					return isNumberKey${compId}(ev);
				}else if(column["dataType"] == "DEC"){
					return isDecimalKey${compId}(ev);
				}
			}
		});
		
		function isNumberKey${compId}(evt){
		    var charCode = (evt.which) ? evt.which : event.keyCode;
		    return !(charCode > 31 && (charCode < 48 || charCode > 57));
		}
		function isDecimalKey${compId}(evt){
		    var charCode = (evt.which) ? evt.which : event.keyCode;
		    return !(charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57));
		}
		
		function validInteger(value) {
			var numbers = /\d/;
			if(isNaN(value) || !numbers.test(value) || (value.indexOf('.') > -1 || value.indexOf('-') > -1)){
				return false;
			}
			return true;
		}
		
		function validDecimal(prcsnNbr,value,maxLnNbr){
			var decNumber = /^\d*(?:\.\d*)?$/;
			if(prcsnNbr != null){
				decNumber = new RegExp("\^\\d*(?:\\.\\d{0,"+prcsnNbr+"})?$");
			}
			var arr = value.split('.');
// 			if(isNaN(value) || !decNumber.test(value) || (value.split('.').length>2 || value.split('.').length==0 || value.indexOf('-') > -1)){
			if(isNaN(value) || !decNumber.test(value) || arr.length > 2 || (value.indexOf('.') == value.length - 1) 
					|| value.indexOf('-') > -1 || arr[0].length >(maxLnNbr - prcsnNbr)){
				return false;
			}
			return true;
		}
		addEventListenerForInputDataTable${compId}();
// 		dt${compId}.subscribe('postRenderEvent', function(){
// 		     var ncols = this.getColumnSet().keys.length;
// 		     for (var i=0; i<ncols; i++)
// 		         this.validateColumnWidths( this.getColumn(i) );
// 		});
		// Assign the handler to the Custom Event
// 		dt${compId}.subscribe("editorSaveEvent", function(oArgs) {
// 		    var oEditor = oArgs.editor,
// 		        newData = oArgs.newData,
// 		        oldData = oArgs.oldData;
// 		    var dddd = oEditor.getTdEl().id;
// 		});
// 		document.getElementsByClassName("yui-dt-dropdown").size = 4;
		myPanel${compId} = new YAHOO.widget.Panel("panelActive${compId}", {
			width:"700px", 
			height:"500px", 
			underlay:"shadow",
			visible:false,
			constraintoviewport:true,
			draggable:false,
			zIndex : 5,
			modal:true,
			close:false,
			fixedCenter : true
		});
		document.getElementById("panelActive${compId}").style.display="table";
		document.getElementById("messageHeader${compId}").style.display="none";
		myPanel${compId}.render(document.body);
	}
	function callFillDataCombobox${compId}(dataListAttr) {
		fnInitialPopUp${compId}(dataListAttr);
		hideTheProgress();
		myPanel${compId}.show();
	}
	// When the addRowBtn is pressed, show the modal form.
	YAHOO.util.Event.addListener("getNutrient${compId}", "click", fnOpenPopUp${compId});
	function fnOpenPopUp${compId}(e) {
		if(${renderView} == false){
			var dataListAttr = null;
			showProgress();
			var callbacks = {
					success : function(o) {
						try {
							if (o != null && myTrim(o.responseText) != "") {
								dataListAttr = YAHOO.lang.JSON.parse(o.responseText);
							}
							callFillDataCombobox${compId}(dataListAttr);
							document.getElementById("messageHeader${compId}").style.display="none";
							disableButWhenErrorConnect${compId}(false);
							hideTheProgress();
						} catch (e) {
							callFillDataCombobox${compId}(dataListAttr);
							hideTheProgress();
							return;
						}
					},
					failure : function() {
						callFillDataCombobox${compId}(dataListAttr);
						document.getElementById('messageHeader${compId}').innerHTML = 'Error connecting data.';
						document.getElementById("messageHeader${compId}").style.display="block";
						disableButWhenErrorConnect${compId}(true);
						hideTheProgress();
					},
					timeout : 5000
				};
				// Make the call to the server for JSON data
				YAHOO.util.Connect.asyncRequest('GET',
						"AddNewCandidate.do?tab=getDtaMultiValList&entyId=${entyId}&groupId=${groupId}&brickSw=${brickSw}", callbacks);
		}
		
	}
	function addEventListenerForInputDataTable${compId}() {
		var columnDefsPop = ${columnDefs};
		for(var i = 0 ; i < columnDefsPop.length; i ++) {
			var arrObj = columnDefsPop[i];
			if(arrObj["attrValListSw"] == "N") {
				var column = dt${compId}.getColumn(arrObj["key"]);
				if(column != null && column["maxLnNbr"] != null){
					var inputs = YAHOO.util.Dom.getElementsByClassName('yui-dt-col-'+arrObj["key"]);
					if (typeof inputs != 'undefined' && inputs){
						for (key in inputs) {
							if (inputs[key].childNodes[0].childNodes[0]!=null && inputs[key].childNodes[0].childNodes[0].nodeName=='INPUT') {
								if(column["dataType"] == "DEC"){
									inputs[key].childNodes[0].childNodes[0].setAttribute("maxLength",column["maxLnNbr"]+1);
								}else {
									inputs[key].childNodes[0].childNodes[0].setAttribute("maxLength",column["maxLnNbr"]);		
								}
//			 					YAHOO.util.Event.addListener(inputs[key].childNodes[0].childNodes[0], "blur", validNumBlur );
							}
						}
					}
				}
			}else {
				var inputs = YAHOO.util.Dom.getElementsByClassName('yui-dt-col-'+arrObj["key"]);
				if (typeof inputs != 'undefined' && inputs){
					for (key in inputs) {
						if (inputs[key].childNodes[0].childNodes[0]!=null && inputs[key].childNodes[0].childNodes[0].nodeName=='SELECT') {
							inputs[key].childNodes[0].childNodes[0].setAttribute("width", '560px');
							for (var i=0;i<inputs[key].childNodes[0].childNodes[0].options.length;i++) {
								if (inputs[key].childNodes[0].childNodes[0].options[i].title=='') {
									inputs[key].childNodes[0].childNodes[0].options[i].title=inputs[key].childNodes[0].childNodes[0].options[i].text;
									inputs[key].childNodes[0].childNodes[0].options[i].text=subStringforSelectTag(inputs[key].childNodes[0].childNodes[0].options[i].text);
								}
							}
						}
					}
				}
			}
		}
	}
	
	function subStringforSelectTag(str) {
		if (str.length>110) {
			var subStr1=str.substring(0,110);
			return subStr1.substring(0, subStr1.lastIndexOf(" ")) + "...";
		}
		return str;
	}
	
	YAHOO.util.Event.addListener("delete${compId}", "click", fnDelete${compId});
	YAHOO.util.Event.addListener("add${compId}", "click", fnAdd${compId});
	YAHOO.util.Event.addListener("cancel${compId}", "click", fnCancel${compId});
	YAHOO.util.Event.addListener("closeMeId${compId}", "click", fnHidePopup${compId});
	YAHOO.util.Event.addListener("ok${compId}", "click", fnOkPopup${compId});
	function fnOkPopup${compId}(e) {
		if(validateInput${compId}()) {
			document.getElementById("messageHeader${compId}").style.display="block";
			document.getElementById("messageHeader${compId}").innerHTML = messageField;
		}else {
// 			validate duplicate record
			if(validateDuplicateRecord${compId}()){
				document.getElementById("messageHeader${compId}").innerHTML = "Remove duplicate data";
				document.getElementById("messageHeader${compId}").style.display="block";
			}else {
				document.getElementById("messageHeader${compId}").style.display="none";
				var rowDatas = []; 
				for (var i= 0; i< dt${compId}.getRecordSet().getLength();i++){
					var oRec = dt${compId}.getRecordSet().getRecord(i);
					var oRecDta =  oRec.getData();
					for(var keyRec in oRecDta) {
						var indx = keyRec.indexOf('codeCd');
						var indxTxt = keyRec.indexOf('codeTxt');
						if(indxTxt > -1 && oRecDta[keyRec] != null && oRecDta[keyRec] != "") {
							oRecDta[keyRec.substr(0,indxTxt)] = oRecDta[keyRec];
						}
// 						oRecord.setData(key+"codeCd",arr[i].value);
					}
					rowDatas.push(oRec.getData());
				}
				table${compId}.getDataSource().liveData = rowDatas;			
				var elm1 = YAHOO.util.Dom.get("${compId}StrutsHiddenElm"); 
				if(elm1!=null){	        		
	        		if(elm1.name.indexOf('${genericHiddenElmName}')<0){
	        			elm1.name="${genericHiddenElmName}."+elm1.name;
	        		}        		
	        		elm1.value=YAHOO.lang.JSON.stringify(rowDatas);        
//	         		alert(elm1.value);
	        	}			
				table${compId}.getDataSource().sendRequest(null, {success: table${compId}.onDataReturnInitializeTable},table${compId});
				myPanel${compId}.hide();
			}
		}
	}
	function validateDuplicateRecord${compId}(e) {
		var check = false;
		for (var i= 0; i< dt${compId}.getRecordSet().getLength();i++){
			var oReci = dt${compId}.getRecordSet().getRecord(i).getData();
			for (var j= i+1; j< dt${compId}.getRecordSet().getLength();j++){
				var oRecj = dt${compId}.getRecordSet().getRecord(j).getData();
				var checkRecord = true;
				for(var keyRec in oReci) {
					if(keyRec != "select" && keyRec != "dataCheckHidden" && keyRec != "seqNbr" && keyRec.search("codeId") == -1) {
						if(myTrim(oReci[keyRec]) != myTrim(oRecj[keyRec])){
							checkRecord = false;
							break;
						}
					}
				}
				if(checkRecord){
					check = true
					break;
				}
			}
			if(check){
				break;
			}
		}
		return check;
	}
	var messageField = "";
	function validateInput${compId}(e) {
		var check = false;
		if (!check && dt${compId}.getRecordSet().getLength() > 0) {
			for (var i= 0; i< dt${compId}.getRecordSet().getLength();i++){
				var oRec = dt${compId}.getRecordSet().getRecord(i);
				if(!check && oRec != null) {
					var oRecObj = oRec.getData();
					var checkRequire = false;
// 					check first require field,
					for(var keyRec in oRecObj) {
						var objValue = oRecObj[keyRec];
						var column = dt${compId}.getColumn(keyRec);
						if(column != null && keyRec != "select"){
							if(column["attrRequire"]) {
								checkRequire = true;
								if(!check && objValue != null) {
									if(keyRec != "select" && keyRec != "dataCheckHidden" && keyRec != "seqNbr" && keyRec.search("codeId") == -1) {
										if(objValue == "") {
											check = true;
											messageField = "Please enter mandatory data before adding next row";
											break;
										}
									}
								}
							}
						}
					}
					if(!checkRequire){ //check fields which they are not require
						for(var keyRec in oRecObj) {
							var objValue = oRecObj[keyRec];
							var column = dt${compId}.getColumn(keyRec);
							if(objValue != null) {
								if(keyRec != "select" && keyRec != "dataCheckHidden" && keyRec != "seqNbr" && keyRec.search("codeId") == -1) {
									if(objValue =="") {
										check = true;
										messageField = "Please enter one field at least for existing row";
									}else {
										check = false;										
										break;
									}
								}
							}
						}
					}
				}
			}
		}
		return check;
	}
	function fnHidePopup${compId}(e) {
		myPanel${compId}.hide();
	}
	function fnCancel${compId}(e) {
		myPanel${compId}.hide();
	}
	function fnDelete${compId}(e) {
		if(dt${compId}.getRecordSet().getLength() > 0){
			var check = false;
			for (var i= 0; i< dt${compId}.getRecordSet().getLength();i++){
				var oRec = dt${compId}.getRecordSet().getRecord(i);
				var dataCheckHidden = oRec.getData("dataCheckHidden");
		        if (dataCheckHidden) {
		        	check = true;
		        	break;
		        }
			}
			if(!check){
				alert("Please select at least one ${compGroupDes} to delete !");
			}else {
				var answer = confirm ("Are you sure you want to delete the selected ${compGroupDes} ?");
				if (answer) {
					for (var i = dt${compId}.getRecordSet().getLength()-1; i >= 0;i--){
						var oRec = dt${compId}.getRecordSet().getRecord(i);
				        var dataCheckHidden = oRec.getData("dataCheckHidden");
				        if (dataCheckHidden) {
				        	dt${compId}.deleteRow(i); 
				        }
				 	}
				}
			}
		} else {
			alert("Please select at least one ${compGroupDes} to delete !");
		}
	}
	function disableButWhenErrorConnect${compId}(param) {
		document.getElementById("add${compId}").disabled=param;
		document.getElementById("delete${compId}").disabled=param;
		document.getElementById("ok${compId}").disabled=param;
	}
	function fnAdd${compId}() {
		if(!validateInput${compId}()){
			if(validateDuplicateRecord${compId}()){
				document.getElementById("messageHeader${compId}").innerHTML = "Remove duplicate data";
				document.getElementById("messageHeader${compId}").style.display="block";
			}else {
				document.getElementById("messageHeader${compId}").style.display="none";
				var dataSource = dt${compId}.getRecordSet();
				dt${compId}.addRow(buildData${compId}(), dataSource.getLength()); 
				addEventListenerForInputDataTable${compId}();
			}
		}else {
			document.getElementById("messageHeader${compId}").style.display="block";
			document.getElementById("messageHeader${compId}").innerHTML = messageField;
		}
	}
	var buildData${compId} = function () {
		var rowDatas = new Object();
		var dataSource = dt${compId}.getRecordSet();
		if(dataSource != null && dataSource.getLength()> 0) {
			var rowDataSource = dataSource.getRecord(0).getData();
			var rowData = rowDataSource.constructor();
			for(var key in rowDataSource){
				if(key == "select" || key =="dataCheckHidden") {
					rowData[key] = false;
				}else {
					rowData[key] = "";
				}
			}
			rowDatas = rowData;
		}else {
			var columnDefsPop = ${columnDefs};
			if(columnDefsPop != null) {
				for(var i = 0 ; i < columnDefsPop.length; i ++) {
					var arrObj = columnDefsPop[i];
					var proper = arrObj["key"];
					rowDatas[proper] = "";
					if(proper == "select" || proper =="dataCheckHidden") {
						rowDatas[proper] = false;
					}
					rowDatas[proper+"codeCd"] = "";
					rowDatas[proper+"codeTxt"] = "";
					rowDatas[proper+"codeId"] = "";
				}
			}
			rowDatas["dataCheckHidden"] = false;
			rowDatas["select"] = false;
			rowDatas["seqNbr"] = "";
		}
		return rowDatas;
	};
	
	function myTrim(x) {
		return x.replace(/^\s+|\s+$/gm,'');
	}
</script>
<c:url value="${request.getContextPath()}/hebAssets/images/icons/iconPopup.png" var="iconPopup"/>
<div style="width: 100%">
	<div style="width: 96.5%; padding-top: 8px; font-weight: bold;">
		<div style="float: left; width: 70%">${compGroupDes}</div>
		<div style="text-align: right; width: 30%; float: left;">
			<img alt="" src="${iconPopup}" style="cursor: pointer;"
				id="getNutrient${compId}">
		</div>
	</div>
	<div style="width: 90%; float: left;">
		<div class="yui-skin-sam">
			<div id="tableNutrient${compId}" style="text-align: left;"></div>
		</div>
	</div>
	<div id="panelActive${compId}" style="display: none"
		class="singlePanel">
		<div class="hd">
			<div class="tl"></div>
			<span id="popupHeaderSP">${compGroupDes}</span>
			<div class="closeMe" id="closeMeId${compId}" style="cursor: pointer;"></div>
			<div class="tr"></div>
		</div>
		<div class="bd">
			<div id="messageHeader${compId}"
				style="display: none; font-size: 12px; color: red;">..is a mandatory field !</div>
			<div class="yui-skin-sam">
				<div id="nutrientDataTablePop${compId}"></div>
			</div>
			<div id="buttons${compId}" align="right" style="margin-top: 10px">
				<input type="button" id="add${compId}" name="Add" value="Add" style="cursor: pointer;">
				<input type="button" id="delete${compId}" name="Delete" style="cursor: pointer;"
					value="Delete"> <input type="button" id="ok${compId}" style="cursor: pointer;"
					name="Ok" value="OK"> <input type="button"
					id="cancel${compId}" name="Cancel" value="Cancel" style="cursor: pointer;">
			</div>
		</div>
		<div class="ft">
			<div class="bl"></div>
			<div class="br"></div>
		</div>
	</div>
	<%-- 	<div id="panelActive${compId}" > --%>
	<!-- 		<div class="yui3-widget-bd"> -->
	<%-- 			<div align="center" id="nutrientDataTablePop${compId}"></div> --%>
	<!-- 		</div> -->
	<!-- 		<div id="nestedPanel"></div> -->
	<!-- 	</div> -->
</div>



