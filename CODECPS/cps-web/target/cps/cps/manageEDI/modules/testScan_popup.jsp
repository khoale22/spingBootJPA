<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%> 

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>   
<%@ page import="java.util.*" %>

<%@page import="com.heb.operations.cps.vo.TestScanVO"%>
<%@ page import="com.heb.operations.cps.vo.EDISearchResultVO"%>
<%@page import="com.heb.operations.cps.util.CPSHelper"%>
<%@ page import="com.heb.operations.cps.model.ManageEDICandidate" %>
<%@page import="com.heb.operations.cps.vo.UPCVO"%><style type="text/css"> 

.yui-skin-sam .yui-dt tr.mark,
.yui-skin-sam .yui-dt tr.mark td.yui-dt-asc,
.yui-skin-sam .yui-dt tr.mark td.yui-dt-desc,
.yui-skin-sam .yui-dt tr.mark td.yui-dt-asc,
.yui-skin-sam .yui-dt tr.mark td.yui-dt-desc {
    background-color: #a39;
    color: #fff;
}
body{font:11px/1.231 arial,helvetica,clean,sans-serif;*font-size:small;*font:x-small;}
select,input,button,textarea{font:99% arial,helvetica,clean,sans-serif;}
table{font-size:11px; text-align : center;}
pre,code,kbd,samp,tt{font-family:monospace;*font-size:108%;line-height:100%;}

.yui-skin-sam .yui-dt table .tbl-filter {
  width: 100%;
  border: 0px;
}
.yui-skin-sam .yui-dt .td-filter .yui-panel{
	border-color: -moz-use-text-color #CBCBCB -moz-use-text-color -moz-use-text-color;
    border-style: none none none none;
    border-width: medium 0px medium medium;
    margin: 0;
    padding: 0;  
}

.yui-skin-sam .yui-dt td.align-center  { 
		text-align:center;
}

</style>
<link rel="stylesheet" type="text/css" href="${request.getContextPath()}/yui/assets/yui.css?v=3" >
<link rel="stylesheet" type="text/css" href="${request.getContextPath()}/yui/assets/dpSyntaxHighlighter.css">
<link rel="stylesheet" type="text/css" href="/cps/yui/paginator/assets/skins/sam/paginator.css" />
<link rel="stylesheet" type="text/css" href="/cps/yui/datatable/assets/skins/sam/datatable.css" />
<link rel="stylesheet" type="text/css" href="/cps/yui/button/assets/skins/sam/button.css" />
<link rel="stylesheet" type="text/css" href="/cps/yui/autocomplete/assets/skins/sam/autocomplete.css" />
<script type="text/javascript" src="/cps/yui/yuiloader/yuiloader-min.js"></script>
<script type="text/javascript" src="/cps/yui/dom/dom-min.js"></script>
<script type="text/javascript" src="/cps/yui/event/event-min.js"></script>
<script type="text/javascript" src="/cps/yui/element/element-beta-min.js"></script>
<script type="text/javascript" src="/cps/yui/paginator/paginator-min.js"></script>
<script type="text/javascript" src="/cps/yui/dragdrop/dragdrop-min.js"></script>
<script type="text/javascript" src="/cps/yui/animation/animation-min.js"></script>
<script type="text/javascript" src="/cps/yui/datasource/datasource-min.js"></script>
<script type="text/javascript" src="/cps/yui/event-delegate/event-delegate-min.js"></script>
<script type="text/javascript" src="/cps/yui/datatable/datatable-min.js"></script>
<script type="text/javascript" src="/cps/yui/button/button-min.js"></script>
<script type="text/javascript" src="/cps/yui/autocomplete/autocomplete-min.js"></script>
<script type="text/javascript" src="/cps/yui/connection/connection-min.js"></script>
<script type="text/javascript" src="/cps/yui/selector/selector-beta-min.js"></script>
<script src="/cps/yui/yahoo/yahoo-min.js"></script>
<script src="/cps/yui/json/json-min.js"></script>
<c:url value="/dwr/engine.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/util.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/ManageEDIDWR.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/cps/yui/connection/connection-min.js" var="styleLink"/>
<script type="text/javascript" src="${styleLink}"></script>
<c:url value="${request.getContextPath()}/hebAssets/dispatcher.js" var="myJs"/>
<script type="text/javascript">
var dataTestScan =null; 
</script>
<body style="visibility: visible;" onload="onBodyLoad();">
	<div id="container"	style="vertical-align: top; background-color: #edf5ff;">
	<table>
		<tr>
			<td width="100%" align="center"> 
				<jsp:include page="/cpsErrors.jsp" />
			</td>
		</tr>	
		<tr>
			<td align="left"> 
					<fieldset style="vertical-align: top; border-collapse: collapse; background-color: #FFFFFF ; " id="vendorDetailsFieldSet">
						<legend style="cursor: pointer; color: #666666"><b>Available UPC's</b></legend>
						<table>
							<tr>
								<td align="left">
									<div id="yahoo-com" class="yui-skin-sam">	
										<div id="testScanTable" style="z-index:15000;"></div>									
									</div>
								</td>
							</tr>
						</table>
					</fieldset>
			</td>
		</tr>
		<tr>
			<td>
				<div id="functionId">
				<table width="100%">
					<tr>
						<td align="right" width="25%">
							<label class="labelFont">Scan Gun Input</label>
						</td>
						<td width="20%" align="left">						
							<div id="holder" style="position:absolute; z-index:99; background-color:transparent">
									<input type = "text" tabindex="73"	
										maxlength="15" id="scanGun" size="15"
										onkeydown="checkForValue();" readonly = "readonly">
									
							</div>
							<div id="reader" align="left"  style="width:10px">
								<textarea onkeypress="onKeyPressEvent(event);" rows="1" cols="1" 
									style="text-align:right;  border: 0px solid #000000; width:1px; cursor:none;"  
									name="scanGunReader" id="scanGunReader">
								</textarea>
							</div>
						</td>
						<td align="left" width="40%">
							<input type="button" id="validate" name ="validate" value="ValidateUPC" disabled></input>
							<input type="button" id="save" value="Save" onclick="saveTestScan();"></input>
							<input type="button" id="cancel" value="Cancel" onclick="toClose();"></input>
						</td>
						<td width="15%"></td>
					</tr>
				</table>
				</div>
			</td>
		</tr>
		<tr>
			<td align="center" >			
				<label class="labelFont" id="msg" ></label>				
			</td>
		</tr>
	</table>
</div>
		

<%
	if (request.getSession().getAttribute("ManageEDICandidate") != null) {
		StringBuffer strData = new StringBuffer();
		ManageEDICandidate cpsEDIManageForm = (ManageEDICandidate)request.getSession().getAttribute("ManageEDICandidate");
		boolean isVend = cpsEDIManageForm.getIsVendor();
		List<UPCVO> results = ((ManageEDICandidate) (request.getSession().getAttribute("ManageEDICandidate"))).getUpcVOs();
		Boolean isExists;

		strData.append("[");
		if (results != null && results.size() > 0) {
			for (int i = 0; i < results.size(); i++) {
				UPCVO upcVO = results.get(i);
				String id = upcVO.getPsProdId() + "-" + upcVO.getSeqNo();
				if (upcVO.getUnitUpc() != null) {
					if (i == 0 || strData.toString().equals("[")){
						if(!isVend)
							strData.append("{checkBox:\"<input type='checkbox' id='ckb_" + id + "' align='bottom'>\",idResult:\"" + id);
						else
							strData.append("{checkBox:\"<input type='checkbox' id='ckb_" + id + "' align='bottom' disabled>\",idResult:\"" + id);
					}
					else {
						if(!isVend)
							strData.append("\n,{checkBox:\"<input type='checkbox' id='ckb_"	+ id + "' align='bottom'>\",idResult:\"" + id);
						else
							strData.append("\n,{checkBox:\"<input type='checkbox' id='ckb_"	+ id + "' align='bottom' disabled>\",idResult:\"" + id);
					}
					strData.append("\",changeStatus:\"" +"0");
					strData.append("\",productID:\""
							+ upcVO.getPsProdId());
					strData.append("\",scanCodeID:\""
							+ upcVO.getUnitUpc());
					strData.append("\",seqNo:\""
							+ upcVO.getSeqNo());
					strData.append("\",overRiddenFlag:\""
							+ upcVO.getTestScanOverridenStatus());
					strData.append("\",unitUPC:\""
							+ upcVO.getUnitUpc());
					strData.append("\",upcType:\""
							+ upcVO.getUpcType() + "\"}");
				}

			}

		}
		strData.append("]");
		
%>
	<script type="text/javascript">
	<c:url value="${request.getContextPath()}/hebAssets/images/newButtons/validated.PNG" var="image"></c:url>
		dataTestScan = {   
  		         areacodes: <%=strData.toString()%>};  
	         
  		var changeRequest = false;
		var dataTestScanResult = makeTestScanTable();
		
		function makeTestScanTable(){		
        // Format color for row is edited  
        var myRowFormatter = function(elTr, oRecord) {   
             if (oRecord.getData('changeStatus') == "2" || oRecord.getData('changeStatus') == "3") {   
                 YAHOO.util.Dom.addClass(elTr, 'mark');   
             }   
             return true;   
         };                 


		var avaiUpc =220;
		var scanSta =125;
		var chK =205;
		var avalCan = 300;
		var scan = 311;
		 if (YAHOO.env.ua.ie > 0) {
			if(YAHOO.env.ua.ie > 8)
			{
				avaiUpc =200;
				scanSta =125;
				chK =205;
				avalCan = 260;
				scan = 270;
			}
			
		}
        if(${!ManageEDICandidate.isVendor}){
			var	myColumnDefs = [{key:"changeStatus",    label:""},
								{key:"idResult",    label:"Id"},
								{key:"unitUPC",		label:"Available UPC", width: avaiUpc, className: 'align-center'},
								{key:"scan",		label:"Scan Status", width: scanSta, className: 'align-center'},
								{key:"checkBox",    label:"Override Test Scan<input type='checkbox' id='SelectAll'/>", width: chK, className: 'align-center'}
								];
		}
		else {
			var myColumnDefs = [{key:"changeStatus",    label:""},
								{key:"idResult",    label:"Id"},
								{key:"unitUPC",		label:"Available UPC", width: avalCan, className: 'align-center'},
								{key:"scan",		label:"Scan Status", width: scan, className: 'align-center'}							
								];
		}


        var myDataSource = new YAHOO.util.DataSource(dataTestScan.areacodes);
        myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
        myDataSource.responseSchema = {
            fields: [{key:"changeStatus"},{key:"idResult"},{key:"unitUPC"},{key:"scan"},{key:"checkBox"},{key:"seqNo"}]
        };	
		
 
        var myConfigs = {          
            draggableColumns:false,
            height:"230px",
            formatRow: myRowFormatter
        }       
 
        var myDataTable = new YAHOO.widget.ScrollingDataTable("testScanTable", myColumnDefs, myDataSource, myConfigs);
		//hiden column
        myDataTable.hideColumn(myDataTable.getColumn("idResult"));
		myDataTable.hideColumn(myDataTable.getColumn("changeStatus"));
		myDataTable.hideColumn(myDataTable.getColumn("seqNo"));

		myDataTable.subscribe("checkboxClickEvent", function(oArgs){ 
        	
            var elCheckbox = oArgs.target; 
            var oRecord = this.getRecord(elCheckbox); 
            var column = this.getColumn(elCheckbox);
			if(elCheckbox.checked){
				oRecord.setData("checkBox","<input type=checkbox id=ckb_"+ oRecord.getData("idResult") +" checked=checked name=factoryList class=yui-dt-checkbox />");
				setChangeStatusOnTestScan(oRecord, true);
			}
			else
			{
				oRecord.setData("checkBox","<input type=checkbox id=ckb_"+ oRecord.getData("idResult") +" name=factoryList class=yui-dt-checkbox />");
				setChangeStatusOnTestScan(oRecord, false);
				//unchecked if SelectAll is checked
				if(YAHOO.util.Dom.get('SelectAll').checked)
					YAHOO.util.Dom.get('SelectAll').checked = false;
			}		        
			changeRequest =true;
 			this.render();
        }); 

        myDataTable.on('theadCellClickEvent', function (oArgs) {
    		var target = oArgs.target,
    			column = this.getColumn(target),
    			actualTarget = YAHOO.util.Event.getTarget(oArgs.event),
    			check = actualTarget.checked;
    		
    		if (column.key == 'checkBox') {

    			var oRS = myDataTable.getRecordSet();
    			
    			for(var i=0; i<oRS.getLength(); i++) {
   	                var oRec = oRS.getRecord(i);
    	            if(check)
    	            {
						if(oRec.getData("changeStatus") !== "-1"){
							oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" checked=checked name=factoryList class=yui-dt-checkbox />");
							setChangeStatusOnTestScan(oRec, true);
						}
    	            }
           			else
           			{
						if(oRec.getData("changeStatus") !== "-1"){
							oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=factoryList class=yui-dt-checkbox />");
							setChangeStatusOnTestScan(oRec, false);
						}
           			}  

    	               
    			}
    			changeRequest =true;
    			this.render();
    		}

    	});	
         	     
        //YAHOO.util.Dom.get('totalRecord').innerHTML = myDataTable.get('paginator').getState().totalRecords + " item returned";
		YAHOO.util.Event.on('validate','click',  function(evt){
				validateCheck(evt);
		});	
		   	
        return {
            oDS: myDataSource,
            oDT: myDataTable
        };
    };
	
	
	
	function setChangeStatusOnTestScan(oRecord, checked)
	{
		//changeStatus = -1: can not edit on editfieldable
	    //changeStatus = 0: initial (alow edit on editfieldable)
		//changeStatus = 1: when checkBox is checked
		//changeStatus = 2: when row is edited
		//changeStatus = 3: when checkBox is checked and row is edited		
		if(checked)
		{
			if(oRecord.getData("changeStatus") == "0")
					oRecord.setData("changeStatus","1");
				else
					if(oRecord.getData("changeStatus") == "2")
						oRecord.setData("changeStatus","3");
						else
							if(oRecord.getData("changeStatus") == "-1")
								oRecord.setData("changeStatus","4");
		}
		else
		{
			if(oRecord.getData("changeStatus") == "1")
					oRecord.setData("changeStatus","0");
				else
					if(oRecord.getData("changeStatus") == "3")
						oRecord.setData("changeStatus","2");
						else
							if(oRecord.getData("changeStatus") == "4")
								oRecord.setData("changeStatus","-1");
		}
	}
	  
    
</script>
		 <%
		 	}
		 %> 
</body>
<script type="text/javascript">

function onBodyLoad(evt){	
	window.parent.hideTheProgress();
	setfocus(evt);
}
function toClose(evt){
	if(confirm("Exit Test Scan? (click OK to exit)")){
		window.parent.closePopup1();
	}
}
function saveTestScan(evt){
	var arrIdResult = new Array();
	var arrUnitUPC = new Array();	
	var arrSeqNo = new Array();
	
	var myDataTable = dataTestScanResult.oDT;
	var isExists;
	
	if(myDataTable != null)
	{   	
    	for(var i=0; i<myDataTable.getRecordSet().getLength(); i++) {
    		var oRec = myDataTable.getRecordSet().getRecord(i);	    		
			if((oRec.getData("changeStatus") != null && oRec.getData("changeStatus") == "1") || (oRec.getData("changeStatus") != null && oRec.getData("changeStatus") == "-1"))
			{
	    		var value = oRec.getData("idResult");
	    		isExists = false;
	    		for(var i=0; i < arrIdResult.length; i++){
	 	    		if(arrIdResult[i] == value){
	 	    			isExists = true;
	 	    			break;
	 	    		}
	    		}
	    		if(!isExists){
	    			arrIdResult.push(value);
	    			arrUnitUPC.push(oRec.getData("unitUPC"));
	    			arrSeqNo.push(oRec.getData("seqNo"));
	    		}

    			oRec.setData("changeStatus", "0");
    			oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=factoryList class=yui-dt-checkbox />");
    			
			}					
		}
		if(arrIdResult.length >0){					
			window.parent.showProgress();
			ManageEDIDWR.updateDataForTestScan(arrIdResult,arrUnitUPC,arrSeqNo,
			{
				callback:function(data) {
					window.parent.hideTheProgress();
					var dataChange = eval(data.appData);
					if(dataChange = 1){
						window.parent.closePopup1(true);
					}
					else{
						window.parent.closePopup1(false);
					}
				},
				errorHandler:function(errorString, exception) {
					hideProgress();
				},
				timeout:180000
			});								
		}
    	else
			alert('Please select UPC(s) that you want to save');
	}
}

function checkForValue(){
	if(YAHOO.util.Dom.get("scanGun").value==''){
		document.getElementById("validate").disabled=true;
	}else
		document.getElementById("validate").disabled=false;
}

function onKeyPressEvent(event){
	if((event.keyCode >= 48 && event.keyCode <= 57) || event.keyCode == 13){
		if(event.keyCode == 13){
			document.getElementById('scanGunReader').value = document.getElementById('scanGunReader').value.replace(/^\s+|\s+$/g, '');
			
			if(document.getElementById('scanGunReader').value != ""){
				var theUPC = prependZeros(document.getElementById('scanGunReader').value);
				if(isNumeric(theUPC) == true){
					document.getElementById('scanGun').value = theUPC;
					document.getElementById('scanGun').focus();
					document.getElementById("validate").disabled=false;
				}else{
					document.getElementById('scanGun').value = "";		
					document.getElementById('scanGunReader').value = "";	
				}
			}
		}
	}else{		
		document.getElementById('scanGun').value = "";		
		document.getElementById('scanGunReader').value = "";			
	}
}
function prependZeros(inpt){
	var dificit = 14 - inpt.length;
	for(var i = 0;  i < dificit; i++){
		inpt = "0" + inpt;
	}	
	return inpt;
}	


function validateCheck(evt){
	 validateScanGunValue();
	 validateWithCheckDigit();
}

function validateScanGunValue(){
    var scanGunValue = document.getElementById('scanGun').value;
	var length = scanGunValue.length;
	if(length < 14){
		var	numberofZero = 14-length;
		for(var j = 0; j < numberofZero; j++){
		scanGunValue = "0" + scanGunValue;
		}
		YAHOO.util.Dom.get("scanGun").value = scanGunValue;
	}else { 
		YAHOO.util.Dom.get("scanGun").value = scanGunValue;
	}
}

function validateWithCheckDigit(evt){
	var scanGunVal = YAHOO.util.Dom.get("scanGun").value+"";
	var finalScanGunVal = scanGunVal.substring(2,(scanGunVal.length));
	var myDataTable = dataTestScanResult.oDT;
	var bln=false;
	for(var i=0;i<myDataTable.getRecordSet().getLength();i++){
		var oRec = myDataTable.getRecordSet().getRecord(i);
		var upc = oRec.getData("unitUPC");
		var upcTrimmed = upc.replace(/^\s+|\s+$/g, '');
		var finalUPC = upcTrimmed.substring(2,(upcTrimmed.length));
		if(finalUPC==finalScanGunVal){
			bln=true;
			YAHOO.util.Dom.get("scanGunReader").value = "";
			YAHOO.util.Dom.get("scanGun").value = "";
			document.getElementById("validate").disabled=true;
			oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" class=yui-dt-checkbox disabled=true/>");
			oRec.setData("scan","<input type=image src='${image}' alt='' id='Image'/>");
			oRec.setData("changeStatus", "-1");
			setfocus();
		}
	}
	YAHOO.util.Dom.get("msg").innerHTML = "";
	if(!bln){
		YAHOO.util.Dom.get("msg").innerHTML = '<font color="#FF0000" size="2px;">No matching UPC Found. Please scan again.</font>'
		YAHOO.util.Dom.get("scanGunReader").value = "";
		YAHOO.util.Dom.get("scanGun").value = "";
		document.getElementById("validate").disabled=true;
		setfocus();
	}
	else{
		myDataTable.render();		
	}
}

function setfocus(evt){	
	setfocusIn();
}

function setfocusIn(){
	setCaretToEnd(document.getElementById("scanGunReader"));
}

function setCaretToEnd (input) {
	if(input){	
		if(input.style.visibility = 'visible'){	
			try {
				input.focus();
				input.select();
				window.parent.onShowEvent1();
			}catch(er){
			}
		}
	}
}
function isNumeric(scanVal){
	var re14digit=/^\d{14}$/
	if (scanVal.search(re14digit)==-1)
	{
		return false;
	}
	return true;
}	


</script>
<script type="text/javascript">
	if(dataTestScan != null && dataTestScan.areacodes.length >0)
		document.getElementById('save').style.display='';
    else	
		document.getElementById('save').style.display='none';
</script>