<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page import="java.util.*"%>

<%@page import="com.heb.operations.cps.vo.CommentUPCVO"%>
<%@ page import="com.heb.operations.cps.model.ManageEDICandidate" %>
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
body{font:11px/1.231 arial,helvetica,clean,sans-serif;*font-size:small;*font:x-small;}
select,input,button,textarea{font:99% arial,helvetica,clean,sans-serif;}
table{font-size:11px;}
pre,code,kbd,samp,tt{font-family:monospace;*font-size:108%;line-height:100%;}

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


.disabled-text{ border-width:1px; border-color: #cdcdcd; border-style: solid; padding: 2px; color: #666;}
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
<c:url value="/dwr/interface/ManageDWR.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/ManageEDIDWR.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<script type="text/javascript">
var dataReject = null; 
var checkEdit = false;
var currentPage = "${ManageEDICandidate.currentPage}";
String.prototype.ReplaceAll = function(stringToFind,stringToReplace){

    var temp = this;

    var index = temp.indexOf(stringToFind);

        while(index != -1){

            temp = temp.replace(stringToFind,stringToReplace);

            index = temp.indexOf(stringToFind);

        }

        return temp;

    }
Array.prototype.inArray = function (value)
{
// Returns true if the passed value is found in the
// array. Returns false if it is not.
	var i;
	for (i=0; i < this.length; i++) 
	{
	 	if (this[i] == value) 
	 		return true;
	}
	return false;
};	
var SER = YAHOO.namespace('Heb.searchDSDResult');

SER.arrSpecChar = new Array("+","*","?",".","(",")","[","]","\\","/","|","^","$","&");
SER.arrConvChar = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n");

SER.convertFromIrToRegularPattern = function(IrStr)
{
	for(var i =0 ;i < SER.arrSpecChar.length; i++)
	{
		IrStr=IrStr.ReplaceAll(SER.arrSpecChar[i],SER.arrConvChar[i]);
	}
	return IrStr;
}

function convertSpecialChars2(str){
	if(str != null && str != ""){		
		str = str.replace(/&quot;/gi, "\"");
		str = str.replace(/&#039;/gi, "\'");					
		str = str.replace(/&#092;/gi, "\\");
	}
	return str;
}
var arrSellingIdObj =new Array();
function initLstObjFilter()
{
	arrSellingIdObj.push("sellingUPCFilter");
	arrSellingIdObj.push("descriptionFilter");
	arrSellingIdObj.push("rejectReasonFilter");
	arrSellingIdObj.push("suggestedActionFilter");
}
</script>
<body style="visibility: visible;" onload="onBodyLoad();">
<div style="width:100%" align="center"> 
		<jsp:include page="/cpsErrors.jsp" />
	</div>
<div id="container"
	style="vertical-align: top; height: 485px; background-color: #D6DCE2;">
<fieldset
		style="margin-left: 0px; border-collapse: collapse; font-size:11px; background-color: #edf5ff ;"
		id="vendorDetailsFieldSet"><legend  style="cursor: pointer; color: #666666">Mass Fill
Section</legend>
<div id="massFillId">
<table>
	<tr>
		<td align="center"><label for="selectedChannel"
							class="labelFont helpable" id="dataSourceLabel"> Reject
		Reason Text </label> <input type="text" id="rejectReasonTextId" size="10" maxlength="250"></input>
		</td>
		<td align="center"><label for="selectedChannel"
			class="labelFont helpable" id="dataSourceLabel"> Suggested
		Action </label> <input type="text" id="suggestedActionId" size="10" maxlength="250"></input></td>
		<td><input type="button" id="massFillId" value='Mass Fill'
			onclick="massFillRejectUPCComment();" /></td>
	</tr>
</table>
</div>
</fieldset>
<fieldset style="margin-left: 0px; height: 370px; border-collapse: collapse; background-color: #edf5ff ; font-size:11px; padding-left: 5px; padding-right: 5px;">
	<div id="yahoo-com" class="yui-skin-sam">
	<table border="0" style="width:100%">
				<tr>
					<td width = "40%">
						<div id="totalRecord" style="padding-left: 5px; color: blue" align="left"></div>
					</td>
					<td width="60%">
						<div id="saveResult" style="color: green" align="left"></div>
					</td>
				</tr>
	</table>
	<div id="rejectUPCTable" style="z-index:15000;"></div>
	<div id="pag" style="font-family:arial; font-size:10px;"></div>	

<%
		if(request.getSession().getAttribute("ManageEDICandidate") != null)
		{
			StringBuffer strData = new StringBuffer();
			List<CommentUPCVO> results = ((ManageEDICandidate)(request.getSession().getAttribute("ManageEDICandidate"))).getCommentUPCVOs();
			
			strData.append("[");
			if(results != null && results.size() >0)
			{				
				for(int i= 0; i< results.size(); i++)
				{
					CommentUPCVO commentUPCVO = results.get(i);
					if(commentUPCVO.getUpcNo() != null)
					{
						String id = commentUPCVO.getPsWorkId() + "-" + commentUPCVO.getPsProdId() + "-" + commentUPCVO.getSeqNo();
						if(i==0 || strData.toString().equals("["))
							strData.append("{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ id.split("-")[0] +"'>\",idResult:\"" + id);
						else
							strData.append("\n,{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ id.split("-")[0] +"'>\",idResult:\"" + id);							
						strData.append("\",changeStatus:\"" + "0");
						strData.append("\",productID:\""+commentUPCVO.getPsProdId());	
						strData.append("\",sellingUPC:\"" + CPSHelper.displaySellingUPC(commentUPCVO.getUpcNo()));	
						strData.append("\",description:\"" + CPSHelper.convertCharToHTMLForJSON(commentUPCVO.getDescription()));
						strData.append("\",rejectReason:\"" + CPSHelper.convertCharToHTMLForJSON(commentUPCVO.getRejectReason()));
						strData.append("\",suggestedAction:\"" + CPSHelper.convertCharToHTMLForJSON(commentUPCVO.getSuggestedAction()));
						strData.append("\",status:\""+commentUPCVO.getStatus() +"\"}");
					}
				}
				
			}
			strData.append("]");
	%> <script type="text/javascript">  
		dataReject = {   
				areacodes: <%=strData.toString()%>}; 
	         
  		var changeRequest = false;
  		var dataSourceTemp = [];
		var dataRejectResult = makeRejectTable();
		
		function makeRejectTable(){
			function sortCompare(a, b, sortBy, field, fieldReturnIfEqual, isNumber)
	        {
	        	 // Deal with empty values   
	            if(!YAHOO.lang.isValue(a)) {
	                return (!YAHOO.lang.isValue(b)) ? 0 : 1;
	            }
	            else if(!YAHOO.lang.isValue(b)) {
	                return -1;
	            }

	            // First compare by state
	            var comp = YAHOO.util.Sort.compare;
	            var compState;
				if(isNumber)
					compState = comp(eval(a.getData(field) !== ""?a.getData(field):"0"), eval(b.getData(field)!== ""?b.getData(field):"0"), sortBy);
				else				
					compState = comp(a.getData(field), b.getData(field), sortBy);

	            // If states are equal, then compare by areacode
				return (compState !== 0) ? compState : comp(a.getData(fieldReturnIfEqual), b.getData(fieldReturnIfEqual), sortBy);
	        }
					
	        var sortSellingUpc = function(a, b, desc) {
	        	return sortCompare(a, b, desc, "sellingUPC", "description", false); 
	        };
		
			var sortDescription = function(a, b, desc) {
	            return sortCompare(a, b, desc, "description", "sellingUPC", false);           
	        };
	        var sortRejectReason = function(a, b, desc) {
	        	return sortCompare(a, b, desc, "rejectReason", "sellingUPC", false); 
	        };
		
			var sortSuggestedAction = function(a, b, desc) {
	            return sortCompare(a, b, desc, "suggestedAction", "sellingUPC", false);           
	        };

	        var formatRejectReason = function(elCell, oRecord, oColumn, sData) {
		    	var valueReason = oRecord.getData("rejectReason");
				valueReason = valueReason.replace(/'/g, "&#039;");        	
	         	if(oRecord.getData("changeStatus") !== "-1" && oRecord.getData("changeStatus") !== "4")			        	
					elCell.innerHTML = "<input type='text' id='rejectReason_" + oRecord.getData("idResult") +"' name='rejectReason_" + oRecord.getData("idResult").split('-')[1] +"' value='" + valueReason +"' maxlength='100' size='60' onchange='saveValueEditableFieldToDataTable(this)' />";
				else
					elCell.innerHTML = "<input type='text' id='rejectReason_" + oRecord.getData("idResult") +"' value='" + valueReason +"' maxlength='100' size='60' class='disabled-text' readonly='readonly' />";
			};

			var formatSuggestedAction = function(elCell, oRecord, oColumn, sData) {	
				var valueAction = oRecord.getData("suggestedAction");
				valueAction = valueAction.replace(/'/g, "&#039;");		
	            if(oRecord.getData("changeStatus") !== "-1" && oRecord.getData("changeStatus") !== "4")			        	
					elCell.innerHTML = "<input type='text' id='suggestedAction_" + oRecord.getData("idResult") +"' name='suggestedAction_" + oRecord.getData("idResult").split('-')[1] +"' value='" + valueAction +"' maxlength='250' size='15' onchange='saveValueEditableFieldToDataTable(this)' />";
				else
					elCell.innerHTML = "<input type='text' id='suggestedAction_" + oRecord.getData("idResult") +"' value='" + valueAction +"' maxlength='250' size='15' class='disabled-text' readonly='readonly' />";
			};   
        
        // Format color for row is edited  
        var myRowFormatter = function(elTr, oRecord) {   
             if (oRecord.getData('changeStatus') == "2" || oRecord.getData('changeStatus') == "3") {   
                 YAHOO.util.Dom.addClass(elTr, 'mark');   
             }   
             return true;   
         };                 

		 var selWid = 150;
		 var desWid = 150;
		 var reReas = 150;
		 var sugAct = 210;
		 
		 if (YAHOO.env.ua.ie > 8) 
			{
				 selWid = 140;
				 desWid = 140;
				 reReas = 140;
				 sugAct = 210;
			}		
        var myColumnDefs = [{key:"changeStatus",    label:""},	
                            {key:"productID",    label:""},
                            {key:"checkBoxs",    label:"All", minWidth: 10,
  							  children: [{key:"checkBox", label:"<input type='checkbox' id='SelectAll'/>",sortable:false, resizeable:false}]},
                            {key:"idResult",    label:"Id", minWidth: 10},
                            {key:"sellingUPCs",    label:"Selling UPC", width: selWid,  sortable:true, sortOptions:{sortFunction:sortSellingUpc},
								children: [{key:"sellingUPC", label:"<input type='text' id='sellingUPCFilter' size='15' maxlength='14' name='divFilterSel'>",sortable:false, resizeable:false}]},  
                            {key:"descriptions",    label:"Description",width: desWid, sortable:true, sortOptions:{sortFunction:sortDescription},
								children: [{key:"description", label:"<input type='text' id='descriptionFilter' size='15' maxlength='30' name='divFilterSel'>",sortable:false, resizeable:false}]},
                            {key:"rejectReasons",    label:"Reject Reason", width: 350, minWidth: 350,  sortable:true,formatter:formatRejectReason, sortOptions:{sortFunction:sortRejectReason},
		                        children: [{key:"rejectReason", label:"<input type='text' id='rejectReasonFilter' size='60' maxlength='100' name='divFilterSel'>",sortable:false, resizeable:false}]},
                            {key:"suggestedActions",    label:"Suggested Action", width: sugAct,  sortable:true,formatter:formatSuggestedAction, sortOptions:{sortFunction:sortSuggestedAction},
		                        children: [{key:"suggestedAction", label:"<table class='tbl-filter'><tr><td width='100' class='td-filter'><div id='suggestedAction'><input type='text' id='suggestedActionFilter' size='10' maxlength='30' name='divFilterSel'\/></div></td><td class='td-filter'><input type='button' id='filterStatus' value='Hide'\/><input type='button' id='clearSelFilter' value='Clear'\/></td></tr></table>",sortable:false, resizeable:true}]},
		                    {key:"status",    label:""}   
	                        ];
                             


        var myDataSource = new YAHOO.util.DataSource(dataReject.areacodes);
        myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
        myDataSource.responseSchema = {
            fields: [{key:"changeStatus"},{key:"productID"},{key:"checkBox"},{key:"idResult"},{key:"sellingUPC"},{key:"description"},
                     {key:"rejectReason"},{key:"suggestedAction"},{key:"status"}]
        };	
		myDataSource.doBeforeCallback = function (req,raw,res,cb) {		
			// This is the filter function							
			var data     = res.results || [],
				filtered = [],
				i,l;
			if (dataSourceTemp.length ==0)
				dataSourceTemp = data;	
			var i = 0;						
			if (req) {		
				var temp="";										
				for (i = 0, l = dataSourceTemp.length; i < l; ++i) 
				{
					temp="";																	
					temp=SER.convertFromIrToRegularPattern(dataSourceTemp[i].sellingUPC.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars2(dataSourceTemp[i].description.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars2(dataSourceTemp[i].rejectReason.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars2(dataSourceTemp[i].suggestedAction.toUpperCase()));										
					var pattern = new RegExp(req);			
					if(pattern.test(temp))
					{		
						filtered.push(dataSourceTemp[i]);			
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
                rowsPerPage: 10,
                template: YAHOO.widget.Paginator.TEMPLATE_ROWS_PER_PAGE,
                rowsPerPageOptions: [10,25,50,100],
                pageLinks: 5,
                containers:'pag'
				
            }),
            draggableColumns:false,
            height:"250px",
            formatRow: myRowFormatter
        }       
 
        var myDataTable = new YAHOO.widget.ScrollingDataTable("rejectUPCTable", myColumnDefs, myDataSource, myConfigs);
		//hiden column
        myDataTable.hideColumn(myDataTable.getColumn("idResult"));
		myDataTable.hideColumn(myDataTable.getColumn("changeStatus"));
		myDataTable.hideColumn(myDataTable.getColumn("productID"));
		myDataTable.hideColumn(myDataTable.getColumn("status"));

		myDataTable.get('paginator').on( 'changeRequest', function () {changeRequest = true;} );
        myDataTable.on('renderEvent', function () {
        if ( changeRequest ) {
        	changeRequest = false;

			//set autocomplete for colummn is used
	        var cur = myDataTable.get('paginator').getState();

	        var totalRecords = cur.totalRecords;

            var recordInPage = cur.rowsPerPage * cur.page;
            if(recordInPage > cur.totalRecords)
            	recordInPage = cur.totalRecords;
			
        }});
		var postStr=" item returned"
			if(myDataTable.get('paginator').getState().totalRecords > 1)
			{
				postStr=" items returned"
			}
		YAHOO.util.Dom.get('totalRecord').innerHTML = myDataTable.get('paginator').getState().totalRecords + postStr;

		myDataTable.get('paginator').setPage(parseInt(currentPage));
		
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

		myDataTable.subscribe("checkboxClickEvent", function(oArgs){ 
        	
            var elCheckbox = oArgs.target; 
            var oRecord = this.getRecord(elCheckbox); 
            var column = this.getColumn(elCheckbox);

            var idWorkRqOfCheckBox = oRecord.getData("idResult").split('-')[0];

            //checked all items have the same Ps_work_id		
			 for (var i= 0; i< this.getRecordSet().getLength();i++){
				var oRec = this.getRecordSet().getRecord(i);
		        var idWorkRq = oRec.getData("idResult").split('-')[0];

		        if(idWorkRq == idWorkRqOfCheckBox){
		        	if(elCheckbox.checked){
						oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" checked=checked name=ckb_"+ oRec.getData("idResult").split('-')[0] +" class=yui-dt-checkbox />");
						oRec.setData("changeStatus", getChangeStatusOnRejectPopup(oRec.getData("changeStatus"), true));
		        	}
		        	else
		        	{
		        		oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[0] +" class=yui-dt-checkbox />");
		        		oRec.setData("changeStatus", getChangeStatusOnRejectPopup(oRec.getData("changeStatus"), false));

		        		//unchecked if SelectAll is checked
						if(YAHOO.util.Dom.get('SelectAll').checked)
							YAHOO.util.Dom.get('SelectAll').checked = false;
			        }
		        }
			 }
			//update datatable temp (used for filter)
				if(elCheckbox.checked)	
	   				saveDataSourceTempWhenCheck(idWorkRqOfCheckBox, true, false);
				else
					saveDataSourceTempWhenCheck(idWorkRqOfCheckBox, false, false);

			changeRequest =true;
 			//this.render();
			var checkBoxs = document.getElementsByName("ckb_" + idWorkRqOfCheckBox);
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

		myDataTable.on('theadCellClickEvent', function (oArgs) {
			var target = oArgs.target,
			column = this.getColumn(target),
			actualTarget = YAHOO.util.Event.getTarget(oArgs.event),
			check = actualTarget.checked;
					    		
			if (column.key == 'checkBox') {
				if(typeof check != 'undefined'){	
					var oRS = myDataTable.getRecordSet();					    			
					for(var i=0; i<oRS.getLength(); i++) {
						var oRec = oRS.getRecord(i);
						if(check)
						{
							oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" checked=checked name=ckb_"+ oRec.getData("idResult").split('-')[0] +" class=yui-dt-checkbox />");		
							var changeValue = getChangeStatusOnRejectPopup(oRec.getData("changeStatus"), true);
	    	            	if(changeValue != null)
	    	            		oRec.setData("changeStatus", changeValue);
							
						}
						else
						{
						 	oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[0] +" class=yui-dt-checkbox />");
						 	var changeValue = getChangeStatusOnRejectPopup(oRec.getData("changeStatus"), false);
	    	            	if(changeValue != null)
	           					oRec.setData("changeStatus", changeValue);
						}  
					}
					
					//update datatable temp (used for filter)
					if(check)	
	    				saveDataSourceTempWhenCheck(0, true, true);
					else
						saveDataSourceTempWhenCheck(0, false, true);
	    			
	    			changeRequest =true;
	    			this.render();
				}
			}	
		});	

		YAHOO.util.Event.on('clearSelFilter','click',function (e) {	
			
			document.getElementById("sellingUPCFilter").value='';
			document.getElementById("descriptionFilter").value='';
			document.getElementById("rejectReasonFilter").value='';
			document.getElementById("suggestedActionFilter").value='';
			clearTimeout(filterTimeout);
			setTimeout(updateFilter,600);
		});	
			
		//filtering

		YAHOO.util.Event.on('sellingUPCFilter','keyup',function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('descriptionFilter','keyup',function (e) {			
			doBeforeFilter(e);
		});			
		YAHOO.util.Event.on('rejectReasonFilter','keyup',function (e) {			
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('suggestedActionFilter','keyup',function (e) {			
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('filterStatus','click',  function(e){
			hideShowFilter(e);
		});
		function doBeforeFilter(e)
		{		
			if(e.keyCode != 0)
				{
					var evt = (window.external) ? event : e;
					var target = null;
					if(evt.srcElement){
						target =evt.srcElement; 
					}else if(evt.target){
						target =evt.target;
					}
					clearTimeout(filterTimeout);
					setTimeout(updateFilter,600);
				}
		};
        return {
            oDS: myDataSource,
            oDT: myDataTable
        };
    };
	
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
	
	function getChangeStatusOnRejectPopup(oldValue, checked)
	{
		//changeStatus = -1: can not edit on editfieldable
	    //changeStatus = 0: initial (alow edit on editfieldable)
		//changeStatus = 1: when checkBox is checked
		//changeStatus = 2: when row is edited
		//changeStatus = 3: when checkBox is checked and row is edited
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

	function saveDataSourceTempWhenCheck(id, checked, isCheckAll){
		if(isCheckAll){
			for(var i=0; i<dataSourceTemp.length; i++) {
	            if(checked)
	            {
	            	dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" checked=checked name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
	            	var changeValue = getChangeStatusOnRejectPopup(dataSourceTemp[i].changeStatus, true);
	            	if(changeValue != null)
	            		dataSourceTemp[i].changeStatus = changeValue;
	            }
       			else
       			{
       				dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
       				var changeValue = getChangeStatusOnRejectPopup(dataSourceTemp[i].changeStatus, false);
	            	if(changeValue != null)
	            		dataSourceTemp[i].changeStatus = changeValue;
       			}    	               
			}
		}
		else
		{
			for (var i= 0; i< dataSourceTemp.length;i++){
		        var idWorkRq = dataSourceTemp[i].idResult.split('-')[0];

		        if(idWorkRq == id){
		        	if(checked){
		        		dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" checked=checked name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
		        		var changeValue = getChangeStatusOnRejectPopup(dataSourceTemp[i].changeStatus, true);
		            	if(changeValue != null)
		            		dataSourceTemp[i].changeStatus = changeValue;
		        	}
		        	else
		        	{
		        		dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
		        		var changeValue = getChangeStatusOnRejectPopup(dataSourceTemp[i].changeStatus, false);
		            	if(changeValue != null)
		            		dataSourceTemp[i].changeStatus = changeValue;
		        	}
		        }
			 }
		}
	}

	function saveDataSourceTempWhenChangeEditFieldable(id, key, value){
		 for (var i= 0; i< dataSourceTemp.length; i++){
	            var idProd = dataSourceTemp[i].idResult.split("-")[1];	            
	            if(key =="rejectReason" || key == "suggestedAction"){
		    		if(idProd == id.split("-")[1]){			
		    			if(key == "rejectReason")
		    				dataSourceTemp[i].rejectReason = value;
		    			if(key == "suggestedAction")
		    				dataSourceTemp[i].suggestedAction = value;

		    			if(dataSourceTemp[i].changeStatus == "1")
		    				dataSourceTemp[i].changeStatus = "3";
		    			else
			    			if(dataSourceTemp[i].changeStatus != "3")
			    				dataSourceTemp[i].changeStatus = "2";					
					} 
	            }	              			          
	        }
	}
	function saveValueEditableFieldToDataTable(element)
    {	
		var key = element.id.split('_')[0];
    	var id = element.id.split('_')[1];
    	var myDataTable = dataRejectResult.oDT;

    	for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){
            var oRec = myDataTable.getRecordSet().getRecord(i);
            var idProd = oRec.getData("idResult").split("-")[1];
			
            if(key =="rejectReason" || key == "suggestedAction"){
	    		if(idProd == id.split("-")[1]){			
	    			oRec.setData(key, element.value);
	    			if(oRec.getData("changeStatus") == "1")
						oRec.setData("changeStatus", "3");
	    			else
		    			if(oRec.getData("changeStatus") != "3")
	    					oRec.setData("changeStatus", "2");	

	    			//change color
					YAHOO.util.Dom.addClass(myDataTable.getTrEl(oRec), 'mark'); 				
				} 
            }
    	}
		//update datatable temp (used for filter)
        saveDataSourceTempWhenChangeEditFieldable(id, key, element.value);
        var fieldChangeds = document.getElementsByName(element.name);
		if(fieldChangeds != null && fieldChangeds.length > 1){	
			for(i=0;i<fieldChangeds.length;i++)
				fieldChangeds[i].value = element.value;
		}
        
		 changeRequest =true;
	     //myDataTable.render();       
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
				if(isHide)
				{
					target.value="Show";
					document.getElementById('clearSelFilter').style.display = 'none';
				}
				else
				{
					document.getElementById('clearSelFilter').style.display = 'inline-block';						
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
    
</script> <%} %>
</div>
<div id="functionId">
<table width="100%">
	<tr>
		<td width="50%"></td>
		<td align="right" width="50%">
			<input type="button" id="resetId" value="Reset" onclick="resetReject();"></input>
			<input type="button" id="cancelId" value="Cancel" onclick="toClose();"></input>
			<input type="button" id="saveId" value="Save" onclick="saveReject();"></input>
			<input type="button" id="saveExitId" value="Save & Exit" onclick="saveExit();"></input>
			
		</td>
	</tr>
</table>
</div>
</fieldset>
</div>
</body>
<script type="text/javascript">
function onBodyLoad(evt){	
	initLstObjFilter();
	window.parent.hideTheProgress();	
}
function toClose(evt){
	if(confirm("Exit Reject DSD Discontinue? (click OK to exit)"))
	{	
		if(!checkEdit){
			window.parent.closePopup4(false);
		}else{
			window.parent.closePopup4(true);
		}
	}	
}
function massFillRejectUPCComment()
{

    if(dataRejectResult != null){
		var rejectReasonText = YAHOO.util.Dom.get('rejectReasonTextId');
		var suggestedAction = YAHOO.util.Dom.get('suggestedActionId');		
		var myDataTable = dataRejectResult.oDT;		
		var count = 0;
		var arrEdit = new Array();
		 for(var i=0; i<myDataTable.getRecordSet().getLength(); i++) {
    		 var oRec = myDataTable.getRecordSet().getRecord(i);
    		 if(oRec.getData("changeStatus") == "1" || oRec.getData("changeStatus") == "3")
    		 {
    			 if(rejectReasonText.value !="" || suggestedAction.value !=""){
	        		 if(rejectReasonText.value !="")
					 	oRec.setData("rejectReason", rejectReasonText.value);
	        		 if(suggestedAction.value !="")
					 	oRec.setData("suggestedAction", suggestedAction.value);
						
					 oRec.setData("changeStatus", "3");
	
					//change color
					YAHOO.util.Dom.addClass(myDataTable.getTrEl(oRec), 'mark'); 
	
					if(!checkExistProdOnPopup(arrEdit, oRec.getData("idResult").split('-')[1]))
						arrEdit.push(oRec.getData("idResult").split('-')[1]);					 
    			 }
    			 count++;			 
			 }
		 }					    		
    	if(count>0){
    		//update datatable temp (used for filter)
    		for(var j=0; j< dataSourceTemp.length; j++) {
    			if(dataSourceTemp[j].changeStatus == "1" || dataSourceTemp[j].changeStatus == "3")
	    		 {
	        		 if(rejectReasonText.value !="")
	        			 dataSourceTemp[j].rejectReason = rejectReasonText.value;
	        		 if(suggestedAction.value !="")
	        			 dataSourceTemp[j].suggestedAction = suggestedAction.value;

	        		 if(rejectReasonText.value !="" || suggestedAction.value !="")
	        		 	dataSourceTemp[j].changeStatus = "3";			 
				 }
	    	}
    		changeRequest =true;
			//myDataTable.render();
    		if(arrEdit.length >0){
				if(rejectReasonText.value !=""){
					for(i=0;i<arrEdit.length;i++){
						var fieldChangedRejectReasons = document.getElementsByName("rejectReason_"+arrEdit[i]);
						if(fieldChangedRejectReasons != null){
							for(j=0;j<fieldChangedRejectReasons.length;j++)
								fieldChangedRejectReasons[j].value = rejectReasonText.value;
						}
					}
				}
				if(suggestedAction.value !=""){
					for(i=0;i<arrEdit.length;i++){
						var fieldChangedSuggesActions = document.getElementsByName("suggestedAction_"+arrEdit[i]);
						if(fieldChangedSuggesActions != null){
							for(j=0;j<fieldChangedSuggesActions.length;j++)
								fieldChangedSuggesActions[j].value = suggestedAction.value;
						}
					}
				}
    		}
    	}
    	else	    	
			alert('Please select at least one UPC for mass fill');				
	}		
}
function resetReject(){
	var myDataSource = dataRejectResult.oDS;
	var myDataTable = dataRejectResult.oDT;
	YAHOO.util.Dom.get('sellingUPCFilter').value = "";	
	YAHOO.util.Dom.get('descriptionFilter').value = "";
	YAHOO.util.Dom.get('rejectReasonFilter').value = "";
	YAHOO.util.Dom.get('suggestedActionFilter').value = "";
	currentPage = myDataTable.get('paginator').getState().page;
	checkEdit=false;
	var currentPage = myDataTable.get('paginator').getState().page;
	if(dataReject != null){ 
		dataSourceTemp = [];
		dataRejectResult = makeRejectTable();
		if(YAHOO.util.Dom.get('SelectAll').checked)
					YAHOO.util.Dom.get('SelectAll').checked = false;
		changeRequest = false;
		YAHOO.util.Dom.get('saveResult').innerHTML ="";
		myDataTable.get('paginator').setPage(parseInt(currentPage));
	}
}

function saveReject(){
	
	if(dataReject != null){	
		var arrIdResult = new Array();
		var arrRejectReasonsSelected = new Array();
		var arrSuggestedActionsSelected = new Array();
		var arrStatus = new Array();
		var isExists;	
		var myDataTable = dataRejectResult.oDT;
		var arrChangeStatus = new Array();
		if(dataSourceTemp != null && dataSourceTemp.length >0)
		{   
			for(var i=0; i<dataSourceTemp.length; i++) {	
				if(dataSourceTemp[i].changeStatus != null && (dataSourceTemp[i].changeStatus == "3" || dataSourceTemp[i].changeStatus == "1" || dataSourceTemp[i].changeStatus == "2"))
				{	
					if(dataSourceTemp[i].rejectReason == ''){
						alert('Please fill Reject Reason');
						if(YAHOO.util.Dom.get('rejectReason_' + dataSourceTemp[i].idResult) != null)
							YAHOO.util.Dom.get('rejectReason_' + dataSourceTemp[i].idResult).focus();
						return;
					}
					if(dataSourceTemp[i].suggestedAction == ''){
						alert('Please fill Suggested Action');
						if(YAHOO.util.Dom.get('suggestedAction_' + dataSourceTemp[i].idResult) != null)
							YAHOO.util.Dom.get('suggestedAction_' + dataSourceTemp[i].idResult).focus();
						return;
					}
			 	    var value = dataSourceTemp[i].idResult;
			 	    isExists = false;
			 	    		
			 	    for(var j=0; j < arrIdResult.length; j++){
				 	    if(arrIdResult[j] == value){
				 	    	isExists = true;
				 	    	break;
				 	    }
			 	    }
			 	    if(!isExists){
			 	    	arrIdResult.push(value);
			 	    	arrRejectReasonsSelected.push(dataSourceTemp[i].rejectReason);
			 	    	arrSuggestedActionsSelected.push(dataSourceTemp[i].suggestedAction);
			 	    	arrStatus.push(dataSourceTemp[i].status);
			 	    	arrChangeStatus.push(dataSourceTemp[i].changeStatus);
			 	    
			 	    }
				}
			}
			if(arrIdResult.length >0)
			{
				window.parent.showTheProgress();
				
			    ManageEDIDWR.rejectDSD(arrIdResult,arrRejectReasonsSelected,arrSuggestedActionsSelected,arrStatus,arrChangeStatus, 
			   	{
					callback:function(data) {
			    		var dataOld = dataReject.areacodes;
						var dataChange = eval(data.appData);
						var rejectList = new Array();

						if(dataChange =="-1"){
							checkEdit=false;
							window.parent.setIsRejectChanged(false);
							YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: red;'><b>Reject Fails</b></span>";
						}
						else
						{
						
								for(var i=0; i<dataSourceTemp.length; i++){
									if(dataSourceTemp[i].changeStatus != null && (dataSourceTemp[i].changeStatus == "3" || dataSourceTemp[i].changeStatus == "1"))
									{
											rejectList.push(dataSourceTemp[i].idResult);
				    				}
								}
								for(var k=0; k< dataOld.length; k++){
									if(rejectList.inArray(dataOld[k].idResult)){
										dataOld.splice(k,1);
										k--;
									}
								}
							
							if(dataChange !=="-1" && dataChange.length > 0){
								for(var k=0; k< dataOld.length; k++){
									
									for(var j=0; j< dataChange.length; j++){
										if(dataOld[k].idResult == dataChange[j].idResult){
											if(dataChange[j].rejectReason != "")
												dataOld[k].rejectReason = dataChange[j].rejectReason;
											if(dataChange[j].suggestedAction != "")
												dataOld[k].suggestedAction = dataChange[j].suggestedAction;
										}
									}
								}							
							}
							YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: green;'><b>Rejected successfully</b></span>";
							window.parent.setIsRejectChanged(true);
							checkEdit = true;
							dataSourceTemp=[];
							dataRejectResult = makeRejectTable();
							
							if(YAHOO.util.Dom.get('SelectAll').checked)
								YAHOO.util.Dom.get('SelectAll').checked = false;
						}
						
						window.parent.hideTheProgress();
					},
					errorHandler:function(errorString, exception) {
						window.parent.hideTheProgress();
						changeRequest = true;
						myDataTable.render();
					},
					timeout:180000								    	
			    });
		 			 
			}
			else
				alert('Please select UPC(s) that you want to reject');
		}
	}	
}
function checkExistProducts(allProdIdsSelected,productId){	
	if(allProdIdsSelected!=''){
		for(var i=0;i<allProdIdsSelected.length;i++){
			if(allProdIdsSelected[i]==productId){
				return true;
			}
		}		
	}		
	 return false;
}
function checkExistProdOnPopup(listProd, prod)
{		
	if(listProd != ''){
		for(var i=0;i<listProd.length;i++){
			if(listProd[i]==prod){
				return true;
			}
		}		
	}		
	 return false;
}
function saveExit(){
	if(dataReject != null){	
		var arrIdResult = new Array();
		var arrRejectReasonsSelected = new Array();
		var arrSuggestedActionsSelected = new Array();
		var arrStatus = new Array();
		var isExists;	
		var arrChangeStatus = new Array();
		if(dataSourceTemp != null && dataSourceTemp.length >0)
		{   
			for(var i=0; i<dataSourceTemp.length; i++) {	
				if(dataSourceTemp[i].changeStatus != null && (dataSourceTemp[i].changeStatus == "2" || dataSourceTemp[i].changeStatus == "3"))
				{	
					if(dataSourceTemp[i].rejectReason == ''){
						alert('Please fill Reject Reason');
						if(YAHOO.util.Dom.get('rejectReason_' + dataSourceTemp[i].idResult) != null)
							YAHOO.util.Dom.get('rejectReason_' + dataSourceTemp[i].idResult).focus();
						return;
					}
					if(dataSourceTemp[i].suggestedAction == ''){
						alert('Please fill Suggested Action');
						if(YAHOO.util.Dom.get('suggestedAction_' + dataSourceTemp[i].idResult) != null)
							YAHOO.util.Dom.get('suggestedAction_' + dataSourceTemp[i].idResult).focus();
						return;
					}
			 	    var value = dataSourceTemp[i].idResult;
			 	    isExists = false;
			 	    		
			 	    for(var j=0; j < arrIdResult.length; j++){
				 	    if(arrIdResult[j] == value){
				 	    	isExists = true;
				 	    	break;
				 	    }
			 	    }
			 	    if(!isExists){
			 	    	arrIdResult.push(value);
			 	    	arrRejectReasonsSelected.push(dataSourceTemp[i].rejectReason);
			 	    	arrSuggestedActionsSelected.push(dataSourceTemp[i].suggestedAction);
			 	    	arrStatus.push(dataSourceTemp[i].status);
						arrChangeStatus.push(dataSourceTemp[i].changeStatus);
			 	    }					
				}	    		
			}
			if(arrIdResult.length >0)
			{
				window.parent.showTheProgress();
			    ManageEDIDWR.rejectDSD(arrIdResult,arrRejectReasonsSelected,arrSuggestedActionsSelected,arrStatus,arrChangeStatus,
			   	{
					
					callback:function(data) {
						window.parent.hideTheProgress();
						var dataChange = eval(data.appData);
						if(dataChange.length > 0 || dataChange=="1"){
							YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: green;'><b>Rejected successfully</b></span>";
							if(YAHOO.util.Dom.get('SelectAll').checked)
								YAHOO.util.Dom.get('SelectAll').checked = false;
							checkEdit=true;
							window.parent.setIsRejectChanged(true);
							window.parent.closePopup4(true);
						}
						else{
							YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: red;'><b>Reject Fails</b></span>";
							checkEdit=false;
							window.parent.setIsRejectChanged(false);
							window.parent.closePopup4(false);
						}
					},
					errorHandler:function(errorString, exception) {
						hideProgress();
					},
					timeout:180000								    	
			    });
		 		 	 
			}
			else{
					alert("Please select UPC that you want to reject.");
				}
		}else
		{
					
					checkEdit=true;
					window.parent.setIsRejectChanged(true);
					window.parent.closePopup4(true);
		}
	}else
	{
		window.parent.closePopup4(false);
	}
	
}

</script>
<script type="text/javascript">

	if(dataReject != null && dataReject.areacodes.length >0){
		document.getElementById('saveId').style.display='';
		document.getElementById('resetId').style.display='';
	}
    else{	
		document.getElementById('saveId').style.display='none';
		document.getElementById('resetId').style.display='none';
    }
	
	
</script>
