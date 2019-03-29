<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>    
<%@ page import="java.util.*" %>
<%@ page import="com.heb.operations.cps.vo.EDISearchResultVO" %>
<%@ page import="com.heb.operations.cps.model.ManageEDICandidate" %>
<%@ page import="com.heb.operations.cps.util.CPSHelper"%>

<%@page import="com.heb.operations.cps.util.BusinessConstants"%>
<%@page import="com.heb.operations.cps.util.BusinessUtil"%>
<style type="text/css">
	/* Skin default elements */
	#panel2_c.yui-panel-container.shadow .underlay {
		left:1px;
		right:-1px;
		top:1px;
		bottom:-1px;
		position:absolute;
		background-color:#000;
		opacity:0.12;
		filter:alpha(opacity=12);
	}

	/* Apply the border to the right side */
	#panel2.yui-panel {
		border:none;
		overflow:visible;
		background:transparent url(hebAssets/images/xp-brdr-rt.gif) no-repeat top right;
	}

	/* Style the close icon */
	#panel2.yui-panel .container-close {
		position:absolute;
		top:5px;
		right:8px;
		height:21px;
		width:21px;
		background:url(hebAssets/images/xp-close.gif) no-repeat;
	}

	/* Style the header with its associated corners */
	#panel2.yui-panel .hd {
		padding:0;
		border:none;
		background:url(hebAssets/images/xp-hd.gif) repeat-x;
		color:#FFF;
		height:30px;
		margin-left:0px;
		margin-right:0px;
		text-align:left;
		vertical-align:middle;
		overflow:visible;
	}

	/* Style the body with the left border */
	#panel2.yui-panel .bd {
		overflow:visible;
		padding:10px;
		border:none;
		background:#FFF url(hebAssets/images/xp-brdr-lt.gif) repeat-y; 
		margin:0 4px 0 0;
	}

	/* Style the footer with the bottom corner images */
	#panel2.yui-panel .ft {
		background: url(hebAssets/images/xp-ft.gif) repeat-x;
		font-size:11px;
		height:26px;
		padding:0px 10px;
		border:none
	}

	/* Skin custom elements */
	#panel2.yui-panel .hd span {
		line-height:30px;
		vertical-align:middle;
		font-weight:bold;
	}
	#panel2.yui-panel .hd .tl {
		width:8px;
		height:29px;
		top:1px;
		left:0px;
		background: url(hebAssets/images/xp-tl.gif) no-repeat;
		position:absolute;
	}
	
	#panel2.yui-panel .hd .closeMe {
		position:absolute;
		top:5px;
		right:8px;
		height:21px;
		width:21px;
		background:url(hebAssets/images/xp-close.gif) no-repeat; 		
	}
	
	#panel2.yui-panel .hd .tr {
		width:8px;
		height:29px;
		top:1px;
		right:0;
		background:url(hebAssets/images/xp-tr.gif) no-repeat; 
		position:absolute;
	}

	#panel2.yui-panel .ft span {
		line-height:22px;
		vertical-align:middle;
	}
	#panel2.yui-panel .ft .bl {
		width:8px;
		height:26px;
		bottom:0;
		left:0;
		background:url(hebAssets/images/xp-bl.gif) no-repeat;
		position:absolute;
	}
	#panel2.yui-panel .ft .br {
		width:8px;
		height:26px;
		bottom:0;
		right:0;
		background:url(hebAssets/images/xp-br.gif) no-repeat;
		position:absolute;
	}

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

#_cal {  
     border-spacing:0;   
     border-collapse:collapse;   
     font:90% sans-serif;   
     text-align:center;   
     margin:0;   
   } 

	#calDiscontinueContainer {
		position: absolute;
		z-index: 20000;
	}
	
.disabled-text{ border-width:1px; border-color: #cdcdcd; border-style: solid; padding: 2px; color: #666;}
</style>

<link rel="stylesheet" type="text/css" href="/cps/yui/calendar/assets/skins/sam/calendar.css" />
<script type="text/javascript" src="/cps/yui/calendar/calendar-min.js"></script>

<c:url value="/protected/cps/manageEDI/updateDsdDiscontinue?${_csrf.parameterName}=${_csrf.token}" var="updateDsdUrl" />
<c:url value="/protected/cps/manageEDI/modifySeach?${_csrf.parameterName}=${_csrf.token}" var="modifySearch"></c:url>

<script type="text/javascript">
var isRejectChanged = false;
var dataDsdDiscontinue =null; 
var canEditOnGrid = true;
var yuiCalendar = function(){

    var _cal;
    var _div;
    var _imgField;
    var _over_cal = false;
	cur_imgField = '';

    function initCal(){ 

        _cal = new YAHOO.widget.Calendar("_cal", _div, {title:"Choose a date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",close:true });
        _cal.selectEvent.subscribe(getCalDate, _cal, true);
        _cal.renderEvent.subscribe(setupCalListeners, _cal, true);
        //YAHOO.util.Event.addListener(_field, 'focus', showCal);
        //YAHOO.util.Event.addListener(_field, 'blur', hideCal);
		YAHOO.util.Event.addListener(_imgField, 'click', showCal);
		YAHOO.util.Event.addListener(document, 'mousedown', hideCal);

        _cal.render();
        hideCal();
    }

    function setupCalListeners(){
        YAHOO.util.Event.addListener(_div, 'mouseover', overCal);
        YAHOO.util.Event.addListener(_div, 'mouseout', outCal);
    }

    function showCal(ev){        	
		var tar = YAHOO.util.Event.getTarget(ev); 	

		cur_imgField = YAHOO.util.Dom.get('discontinueDate_' + tar.id.split('_')[1]);
		
		var xy = YAHOO.util.Dom.getXY(tar);  
        var date = cur_imgField.value;   
         if (date) {
             _cal.cfg.setProperty('selected', date);   
             _cal.cfg.setProperty('pagedate', new Date(date), true); 					 
         } 
		 else {
            _cal.cfg.setProperty('selected', '');
            _cal.cfg.setProperty('pagedate', new Date(), true);
        }
		 _cal.render();	
		YAHOO.util.Dom.setStyle(_div, 'display', 'block');

		var heightDivCal = YAHOO.util.Dom.get(_div).offsetHeight;
		
		if(tar.id != 'imgCal_massfill')
			xy[1] = xy[1] - heightDivCal;
		else
		{
			if(xy[1] - heightDivCal < 60)
				xy[1] = xy[1] + 18;
			else
				xy[1] = xy[1] - heightDivCal;
		}
		 
        YAHOO.util.Dom.setXY(_div, xy);
    }

    function getCalDate(){
        var calDate = this.getSelectedDates()[0];
        var day = calDate.getDate();
        if (day < 10)
            day = "0" + day;

        calDate = (calDate.getMonth() + 1) + '/' + day + '/' + calDate.getFullYear();
        if(canEditOnGrid || cur_imgField.id == 'discontinueDate_massfill')
        	cur_imgField.value = calDate;
        _over_cal = false;
        hideCal();
		
		//set change to datatable
        if(canEditOnGrid && cur_imgField.id != 'discontinueDate_massfill')		
			saveValueEditableFieldToDataTable(cur_imgField);
    }

    function hideCal(ev){
        if (!_over_cal) {
            YAHOO.util.Dom.setStyle(_div, 'display', 'none');
        }

    }   

    function overCal(){
        _over_cal = true;
    }   

    function outCal(){
        _over_cal = false;
    }  
    
    return {

        create: function(container, field){
            _div = container;
            _imgField = field;
            initCal();
            return _cal;
        }

    }
}();

String.prototype.ReplaceAll = function(stringToFind,stringToReplace){

    var temp = this;

    var index = temp.indexOf(stringToFind);

        while(index != -1){

            temp = temp.replace(stringToFind,stringToReplace);

            index = temp.indexOf(stringToFind);

        }

        return temp;

    }

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

function convertSpecialChars(str){
	if(str != null && str != ""){
		str = str.replace(/&quot;/gi, "\"");
		str = str.replace(/&#039;/gi, "\'");					
		str = str.replace(/&#092;/gi, "\\");
	}
	return str;
}

var currentPage = "${ManageEDICandidate.currentPage}";

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
</script>

<fieldset id="fMassFill" style="margin-left: 6px; background-color: #FFFFFF; margin-right: 6px; padding-bottom: 5px; 
		padding-top: 5px; width: 98%; color: #000000;" title="MassFill Section">
	<legend  style="cursor: pointer; color: #666666; font-size:11px;"><b>Mass Fill Section</b> </legend>		
	<div id="massUpdateSection">
		<div style="text-align:center;">
			<table align="center">
				<tr>
					<td>
						Discontinue Date
					</td>
					<td>
						<input id="discontinueDate_massfill" type="text" size="10" maxlength="10" onblur="validateDateMassFill(this);"> 
						<img id='imgCal_massfill' src='${request.getContextPath()}/hebAssets/images/calbtn.gif'/>
					</td>
					<td style="padding-left: 10px;">
						<input id="massFillBut" type="button" value="Mass Fill">
					</td>
				</tr>
			</table>				
		</div>
	</div>
</fieldset>
<fieldset id="fSearchResultSection" style="margin-left: 6px; background-color: #edf5ff; margin-right: 6px; padding-bottom: 5px; 
		padding-top: 5px; width: 98%; color: #000000; overflow-x:scroll; overflow-y: hidden;">
<div id="searchResultContainer">
	<div id="yahoo-com" class="yui-skin-sam">
		<input type="hidden" id="isSaveExit" name="isSaveExit">
		<table border="0" width="100%">
			<tr>
				<td width="40%"><div id="totalRecord" style="padding-left: 5px; color: blue"></div>	</td>
				<td><div id="saveResult" style="color: green"></div></td>
			</tr>
		</table>
	  	<div style="width:100%; z-index:15000;">  		
		    <div id="tblDsdDiscontinue"></div>
			<div id="pag" style="font-family:arial; font-size:10px;"></div>
		</div>
		<%
			if(request.getSession().getAttribute("ManageEDICandidate") != null)
			{
				StringBuffer strData = new StringBuffer();
				ManageEDICandidate ediForm = (ManageEDICandidate)(request.getSession().getAttribute("ManageEDICandidate"));
				List<EDISearchResultVO> results = ediForm.getEdiSearchResultVOLst();
				
				String role = ediForm.getCandidateEDISearchCriteria().getRole();
				boolean isDisable = (BusinessUtil.isVendor(role) || BusinessUtil.isBDM(role) || BusinessUtil.isSCA(role) || BusinessUtil.isRPA(role));
				
				strData.append("[");
				if(results != null && results.size() >0)
				{				
					for(int i= 0; i< results.size(); i++)
					{
						EDISearchResultVO ediResult = results.get(i);
						if(ediResult.getPsItemId() != null)
						{
							String id =  ediResult.getPsWorkId() + "-" + ediResult.getPsItemId() + "-" + ediResult.getPsVendno() + "-" + ediResult.getUpcNo() + "-" + i;
							if(i==0 || strData.toString().equals("["))
								strData.append("{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ ediResult.getPsWorkId() +"'>\",idResult:\"" + id);
							else
								strData.append("\n,{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ ediResult.getPsWorkId() +"'>\",idResult:\"" + id);
								
							strData.append("\",changeStatus:\"" + ((isDisable)? "-1":"0"));
							strData.append("\",productID:\"" + ediResult.getPsProdId()); 
							strData.append("\",sellingUpc:\"" + CPSHelper.displaySellingUPC(ediResult.getUpcNo()));
							strData.append("\",description:\"" + (ediResult.getUpcDescription() != null? CPSHelper.convertCharToHTMLForJSON(ediResult.getUpcDescription()):""));	
							strData.append("\",vendorNo:\""+ ediResult.getPsVendno()); 
							strData.append("\",vendorName:\"" + CPSHelper.convertCharToHTMLForJSON(ediResult.getPsVendName())); 
							strData.append("\",discontinueDate:\"" + (ediResult.getDiscontinueDate() != null? ediResult.getDiscontinueDate():""));
							strData.append("\",dsdStatus:\"" + ediResult.getStatus());
							strData.append("\",status:\"" + ediResult.getStatusValue() +"\"}");
						}
					}
					
				}
				strData.append("]");
		%>
	 		
	  		<script type="text/javascript">  
	  		dataDsdDiscontinue = {   
	  		         areacodes: <%=strData.toString()%>};  
		         
	  		var changeRequest = false;
	  		canEditOnGrid = <%=!isDisable%>;
	  		var dataSourceTemp = [];
			var dsdDiscontinueResult = makeDsdDiscontinueTable();
					
			function makeDsdDiscontinueTable(){
	        
	        var formatDisContinueDate = function(elCell, oRecord, oColumn, sData) {
	        	if(oRecord.getData("changeStatus") !== "-1" && oRecord.getData("changeStatus") !== "4")
	            	elCell.innerHTML = "<input type='text' id='discontinueDate_" + oRecord.getData("idResult") +"' name='discontinueDate_" + oRecord.getData("idResult").split('-')[1] + "' value='" + oRecord.getData("discontinueDate") +"' maxlength='10' size='10' onchange='saveValueEditableFieldToDataTable(this)' /><img id='img_" + oRecord.getData("idResult") +"' src='${request.getContextPath()}/hebAssets/images/calbtn.gif'/>";
	            else
	            	elCell.innerHTML = "<input type='text' id='discontinueDate_" + oRecord.getData("idResult") +"' name='discontinueDate_" + oRecord.getData("idResult").split('-')[1] + "' value='" + oRecord.getData("discontinueDate") +"' maxlength='10' size='10' class='disabled-text' readonly='readonly'/><img id='img_" + oRecord.getData("idResult") +"' src='${request.getContextPath()}/hebAssets/images/calbtn.gif'/>";
	        };
	
	
	      	//custom sort function
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
	        	return sortCompare(a, b, desc, "sellingUpc", "vendor", false); 
	        };
	
	        var sortDescription = function(a, b, desc) {
	        	return sortCompare(a, b, desc, "description", "sellingUpc", false); 
	        };
	
	        var sortVendorNo = function(a, b, desc) {
	            return sortCompare(a, b, desc, "vendorNo", "sellingUpc", true);           
	        };
	
	        var sortVendorName = function(a, b, desc) {
	            return sortCompare(a, b, desc, "vendorName", "sellingUpc", false);           
	        };       
	
	        var sortDiscontinueDate = function(a, b, desc) {
	        	return sortCompare(a, b, desc, "discontinueDate", "sellingUpc", false); 
	        };
	
	        var sortStatus = function(a, b, desc) {
	        	return sortCompare(a, b, desc, "status", "sellingUpc", false); 
	        };
	        
	        // Format color for row is edited  
	        var myRowFormatter = function(elTr, oRecord) {   
	             if (oRecord.getData('changeStatus') == "2" || oRecord.getData('changeStatus') == "3") {   
	                 YAHOO.util.Dom.addClass(elTr, 'mark');   
	             }   
	             return true;   
	         };                 
	
	        var myColumnDefs = [{key:"changeStatus",    label:""},	
								{key:"checkBoxs",    label:"All", minWidth: 30,
	                            	children: [{key:"checkBox", label:"<input type='checkbox' id='SelectAll'/>",sortable:false, resizeable:false}]},
	                            {key:"idResult",    label:"Id", minWidth: 50},                            
	                            {key:"sellingUpcs",    label:"Selling UPC", width: 100, sortable:true, sortOptions:{sortFunction:sortSellingUpc},
									children: [{key:"sellingUpc", label:"<div id ='sellingUpcDiv'><input type='text' id='sellingUpcFilter' name='divFilter' size='15' maxlength='20'></div>",sortable:false, resizeable:false}]},
								{key:"descriptions",    label:"UPC Description", width: 250,  sortable:true, sortOptions:{sortFunction:sortDescription},
									children: [{key:"description", label:"<div id ='descriptionDiv'><input type='text' id='descriptionFilter' name='divFilter' size='40' maxlength='50'></div>",sortable:false, resizeable:false}]}, 
								{key:"vendorNos",    label:"Vendor", width: 80,  sortable:true, sortOptions:{sortFunction:sortVendorNo},
									children: [{key:"vendorNo", label:"<div id ='vendorNoDiv'><input type='text' id='vendorNoFilter' name='divFilter' size='8' maxlength='10'></div>",sortable:false, resizeable:false}]}, 
								{key:"vendorNames",    label:"Vendor Name", width: 250,  sortable:true, sortOptions:{sortFunction:sortVendorName},
									children: [{key:"vendorName", label:"<div id ='vendorNameDiv'><input type='text' id='vendorNameFilter' name='divFilter' size='40' maxlength='30'></div>",sortable:false, resizeable:false}]}, 
	                            {key:"discontinueDates",    label:"Discontinue Date", width: 100,  formatter:formatDisContinueDate, sortable:true, sortOptions:{sortFunction:sortDiscontinueDate},
									children: [{key:"discontinueDate", label:"<div id ='discontinueDateDiv'><input type='text' id='discontinueDateFilter' name='divFilter' size='10' maxlength='11'></div>",sortable:false, resizeable:false}]},
	                            {key:"statuss",    label:"Status", width: 145,  sortable:true, sortOptions:{sortFunction:sortStatus},
									children: [{key:"status", label:"<table class='tbl-filter'><tr><td width='95' class='td-filter'><div id ='statusDiv'><input type='text' id='statusFilter' name='divFilter' size='10' maxlength='20'>&nbsp;</div></td><td class='td-filter'><input type='button' id='filterStatus' value='Hide'><input type='button' id='clearFilter' value='Clear'>",sortable:false, resizeable:false}]},
								{key:"dsdStatus",    label:""}];   
	
	
	        var myDataSource = new YAHOO.util.DataSource(dataDsdDiscontinue.areacodes);
	        myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
	        myDataSource.responseSchema = {
	            fields: [{key:"changeStatus"},{key:"productID"},{key:"checkBox"},{key:"idResult"},{key:"sellingUpc"},
	                     {key:"description"},{key:"vendorNo"},{key:"vendorName"},{key:"discontinueDate"},{key:"dsdStatus"},{key:"status"}]
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
								temp=dataSourceTemp[i].sellingUpc.toUpperCase()+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].description.toUpperCase()))+"__"+dataSourceTemp[i].vendorNo.toUpperCase()+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].vendorName.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].discontinueDate.toUpperCase())+"__"+dataSourceTemp[i].status.toUpperCase();										
								var pattern = new RegExp(req);			
								if(pattern.test(temp))
								{								
									filtered.push(dataSourceTemp[i]);			
								}						
							}
						
						res.results = filtered;	
	
						//set style
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
	            height: "250px",
	            formatRow: myRowFormatter
	        }       
	 
	        var myDataTable = new YAHOO.widget.ScrollingDataTable("tblDsdDiscontinue", myColumnDefs, myDataSource, myConfigs);
			//hiden column
	        myDataTable.hideColumn(myDataTable.getColumn("idResult"));
			myDataTable.hideColumn(myDataTable.getColumn("changeStatus"));
			myDataTable.hideColumn(myDataTable.getColumn("dsdStatus"));
	
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
				var arr
	            //checked all items have the same Ps_work_id		
				 for (var i= 0; i< this.getRecordSet().getLength();i++){
					var oRec = this.getRecordSet().getRecord(i);
			        var idWorkRq = oRec.getData("idResult").split('-')[0];
	
			        if(idWorkRq == idWorkRqOfCheckBox){
			        	if(elCheckbox.checked){
			        		oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") + " name=ckb_"+ oRec.getData("idResult").split('-')[0] +" checked=checked class=yui-dt-checkbox />");
							oRec.setData("changeStatus", getChangeStatusOnDsdDiscontinueTab(oRec.getData("changeStatus"), true));
			        	}
			        	else
			        	{
			        		oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[0] +" class=yui-dt-checkbox />");
							oRec.setData("changeStatus", getChangeStatusOnDsdDiscontinueTab(oRec.getData("changeStatus"), false));
	
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
		    			var arrItemFilter = new Array();
		    			
		    			for(var i=0; i<oRS.getLength(); i++) {
		   	                var oRec = oRS.getRecord(i);
		   	                var idWorkRq = oRec.getData("idResult").split('-')[0];
		   	             	arrItemFilter.push(idWorkRq);
		    	            if(check)
		    	            {
		    	            	oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") + " name=ckb_"+ oRec.getData("idResult").split('-')[0] +" checked=checked class=yui-dt-checkbox />");
		    	            	var changeValue = getChangeStatusOnDsdDiscontinueTab(oRec.getData("changeStatus"), true);
		    	            	if(changeValue != null)
		    	            		oRec.setData("changeStatus", changeValue);
		    	            }
		           			else
		           			{
		           				oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[0] +" class=yui-dt-checkbox />");
		           				var changeValue = getChangeStatusOnDsdDiscontinueTab(oRec.getData("changeStatus"), false);
		    	            	if(changeValue != null)
		           					oRec.setData("changeStatus", changeValue);
		           			}    	               
		    			}
		
						//update datatable temp (used for filter)
						if(check)	
		    				saveDataSourceTempWhenCheck(arrItemFilter, true, true);
						else
							saveDataSourceTempWhenCheck(arrItemFilter, false, true);
		    			
		    			changeRequest =true;
		    			this.render();
	    			}
	    		}
	
	    	});	
			
			myDataTable.subscribe("initEvent", function(){changeRequest = true;});
	        myDataTable.subscribe("columnSortEvent", function(){changeRequest = true; });
	        myDataTable.get('paginator').on( 'changeRequest', function () {changeRequest = true;} );
	        myDataTable.on('renderEvent', function () {
		        if(YAHOO.util.Dom.get('SelectAll').checked){
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
	   			
		        if (changeRequest) {
					var arrField = "[";
		        	changeRequest = false;
		
					//set autocomplete for colummn is used
			        var cur = myDataTable.get('paginator').getState();
		
			        var totalRecords = cur.totalRecords;
		
		            var recordInPage = cur.rowsPerPage * cur.page;
		            if(recordInPage > cur.totalRecords)
		            	recordInPage = cur.totalRecords;
		        	
			        for (i= (cur.page -1)* cur.rowsPerPage; i<=recordInPage-1;i++)
			        {
			        	var idResult = myDataTable.getRecord(i).getData("idResult");
			        	if(arrField != "[")
							arrField += "," + "'img_" + idResult + "'";
						else
							arrField += "'img_" + idResult + "'";
			        	
			        }
					arrField += "]";
		
			        yuiCalendar.create('calDiscontinueContainer',eval(arrField)); 
		        }

	        //set total record retuned     
		        var totalRecords = myDataTable.get('paginator').getState().totalRecords;
		        var itemReturn = (totalRecords < dataSourceTemp.length? " (out of " + dataSourceTemp.length + " total " + (dataSourceTemp.length>1?"items":"item") + ") returned" : " returned");			
				if(totalRecords > 1)
					YAHOO.util.Dom.get('totalRecord').innerHTML = totalRecords + " items" + itemReturn;
				else
					YAHOO.util.Dom.get('totalRecord').innerHTML = totalRecords + " item" + itemReturn;
	        });

			//set page is selected	
            myDataTable.get('paginator').setPage(parseInt(currentPage));
			 
			//filtering	
			YAHOO.util.Event.on('sellingUpcFilter','change',function (e) {			
				doBeforeFilter(e);
			});
			YAHOO.util.Event.on('descriptionFilter','change',function (e) {			
				doBeforeFilter(e);
			});
			YAHOO.util.Event.on('vendorNoFilter','change',function (e) {			
				doBeforeFilter(e);
			});
			YAHOO.util.Event.on('vendorNameFilter','change',function (e) {			
				doBeforeFilter(e);
			});
			YAHOO.util.Event.on('discontinueDateFilter','change',function (e) {		
				doBeforeFilter(e);
			});
			YAHOO.util.Event.on('statusFilter','change',function (e) {	
				doBeforeFilter(e);
			});
	
			YAHOO.util.Event.on('clearFilter','click',function (e) {	
				document.getElementById("sellingUpcFilter").value='';
				document.getElementById("descriptionFilter").value='';
				document.getElementById("vendorNoFilter").value='';
				document.getElementById("vendorNameFilter").value='';
				document.getElementById("discontinueDateFilter").value='';
				document.getElementById("statusFilter").value='';
				clearTimeout(filterTimeout);
				setTimeout(updateFilter,600);
			});
	
			function doBeforeFilter(e)
			{		
				clearTimeout(filterTimeout);
				setTimeout(updateFilter,600);
			}

			//event for Hide and Show button
	    	YAHOO.util.Event.on('filterStatus','click',  function(e){
				hideShowFilter(e);
			});
			
	        return {
	            oDS: myDataSource,
	            oDT: myDataTable
	        };
	    };
	
	  
		function hideShowFilter(e) {
			
			var evt = (window.external) ? event : e;
				var target = null;
				if(evt.srcElement){
					target =evt.srcElement; 
				}else if(evt.target){
					target =evt.target;
				}
				
			var selFilterDivArr = document.getElementsByName("divFilter");								
			var isHide=false;				
											
			if(target.value=='Hide')
			{
				isHide=true;
			}
			
			target.value="Hide";
			document.getElementById('clearFilter').disabled=false;
			if(isHide)
			{
				target.value="Show";
				document.getElementById('clearFilter').disabled=true;
				document.getElementById('clearFilter').style.display = 'none';
			}
			else
			{
				document.getElementById('clearFilter').style.display = '';
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
		
		function gePattern()
		{
			var arrFilterObj = new Array();
			arrFilterObj.push("sellingUpcFilter");
			arrFilterObj.push("descriptionFilter");
			arrFilterObj.push("vendorNoFilter");
			arrFilterObj.push("vendorNameFilter");
			arrFilterObj.push("discontinueDateFilter");
			arrFilterObj.push("statusFilter");
			
			var comp = YAHOO.lang;
			var lstObjVl = new Array();

			//get value of each field of filter
			for(var i = 0 ;i< arrFilterObj.length;i++)
			{
				lstObjVl.push(comp.trim(document.getElementById(arrFilterObj[i]).value.toUpperCase()));
			}

			//convert from irregular pattern to regular pattern
			for(var i = 0; i< lstObjVl.length; i++)
			{
				//call function SER.convertFromIrToRegularPattern from SearchEDIResult.jsp page
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
		
		function getChangeStatusOnDsdDiscontinueTab(oldValue, checked)
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

		function validateDateMassFill(element){
			element.value = YAHOO.lang.trim(element.value);
			validateDate(element);
		}
	
		function saveDataSourceTempWhenCheck(id, checked, isCheckAll){
			if(isCheckAll){
				var isFilter = false;
				if(id.length != dataSourceTemp.length)
					isFilter = true;
				
				for(var i=0; i<dataSourceTemp.length; i++) {
					var idWorkRq = dataSourceTemp[i].idResult.split('-')[0];
		            if(checked)
		            {
		            	if((isFilter && id.inArray(idWorkRq)) || !isFilter){
			            	dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" checked=checked class=yui-dt-checkbox />";
			            	var changeValue = getChangeStatusOnDsdDiscontinueTab(dataSourceTemp[i].changeStatus, true);
			            	if(changeValue != null)
			            		dataSourceTemp[i].changeStatus = changeValue;
		            	}
		            }
	       			else
	       			{
	       				if((isFilter && id.inArray(idWorkRq)) || !isFilter){
		       				dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
		       				var changeValue = getChangeStatusOnDsdDiscontinueTab(dataSourceTemp[i].changeStatus, false);
			            	if(changeValue != null)
			            		dataSourceTemp[i].changeStatus = changeValue;
	       				}
	       			}    	               
				}
			}
			else
			{
				for (var i= 0; i< dataSourceTemp.length;i++){
			        var idWorkRq = dataSourceTemp[i].idResult.split('-')[0];
	
			        if(idWorkRq == id){
			        	if(checked){
			        		dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" checked=checked class=yui-dt-checkbox />";
			        		var changeValue = getChangeStatusOnDsdDiscontinueTab(dataSourceTemp[i].changeStatus, true);
			            	if(changeValue != null)
			            		dataSourceTemp[i].changeStatus = changeValue;
			        	}
			        	else
			        	{
			        		dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
			        		var changeValue = getChangeStatusOnDsdDiscontinueTab(dataSourceTemp[i].changeStatus, false);
			            	if(changeValue != null)
			            		dataSourceTemp[i].changeStatus = changeValue;
			        	}
			        }
				 }
			}
		}
	
		function saveDataSourceTempWhenChangeEditFieldable(id, key, value){
			 for (var i= 0; i< dataSourceTemp.length; i++){
		            var idItem = dataSourceTemp[i].idResult.split("-")[1];
		    		if(idItem == id.split("-")[1]){	
		    			dataSourceTemp[i].discontinueDate = value;			    				
		    			if(dataSourceTemp[i].changeStatus == "1")
		    				dataSourceTemp[i].changeStatus = "3";
		    			else
			    			if(dataSourceTemp[i].changeStatus != "3")
			    				dataSourceTemp[i].changeStatus = "2";					
					}   			          
		        }
		}
	
	    function saveValueEditableFieldToDataTable(element)
	    {	
	    	var myDataTable = dsdDiscontinueResult.oDT;
	    	var key = element.id.split('_')[0];
	    	var id = element.id.split('_')[1];

	    	element.value = YAHOO.lang.trim(element.value);
			//call function to validate type date
			if(!validateDate(element)){
				changeRequest =true;
				myDataTable.render();
				return;
			}

			var hasEdit = false;									
	
	        for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){
	            var oRec = myDataTable.getRecordSet().getRecord(i);
		        if(oRec.getData("changeStatus") != "-1" && oRec.getData("changeStatus") != "4"){
		            var idItem = oRec.getData("idResult").split("-")[1];
		
		    		if(idItem == id.split("-")[1]){	
			
		    			oRec.setData(key, element.value);
		    			if(oRec.getData("changeStatus") == "1")
							oRec.setData("changeStatus", "3");
		    			else
			    			if(oRec.getData("changeStatus") != "3")
		    					oRec.setData("changeStatus", "2");
													
		    			//change color
						YAHOO.util.Dom.addClass(myDataTable.getTrEl(oRec), 'mark');	

						hasEdit = true;				
					} 
	            } 			          
	    	}

			if(hasEdit){
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
	    }
	
	    function massFillDsdDiscontinue()
	    {
	        if(dataDsdDiscontinue != null){   
		    	var myDataTable = dsdDiscontinueResult.oDT;
		
		    	var discontinueDate = YAHOO.util.Dom.get('discontinueDate_massfill').value; 
				
				if(discontinueDate == ""){
					alert('Please select a discontinue date');
					 YAHOO.util.Dom.get('discontinueDate_massfill').focus();
					return;
				}
				
	            //call function to validate type date
				if(!validateDate(YAHOO.util.Dom.get('discontinueDate_massfill')))
					return;

		        var count = 0;	
		        var arrItemEdit = new Array();
		
		    	for(var i=0; i<myDataTable.getRecordSet().getLength(); i++) {
		    		 var oRec = myDataTable.getRecordSet().getRecord(i);
		    		 if(oRec.getData("changeStatus") == "1" || oRec.getData("changeStatus") == "3")
		    		 {
		        		 if(discontinueDate !=""){
						 	oRec.setData("discontinueDate", discontinueDate);						 
							oRec.setData("changeStatus", "3");

							//change color
							YAHOO.util.Dom.addClass(myDataTable.getTrEl(oRec), 'mark');	

							if(!checkExistItem(arrItemEdit,oRec.getData("idResult").split("-")[1]))
								arrItemEdit.push(oRec.getData("idResult").split("-")[1]);
							
							count++;
		        		 }				 
					 }
		    	}
		
		    	if(count>0){
		    		//update datatable temp (used for filter)
		    		for(var j=0; j< dataSourceTemp.length; j++) {
		    			if(dataSourceTemp[j].changeStatus == "1" || dataSourceTemp[j].changeStatus == "3")
			    		 {
			        		 dataSourceTemp[j].discontinueDate = discontinueDate;							 
			        		 dataSourceTemp[j].changeStatus = "3";			 
						 }
			    	}

			    	if(arrItemEdit.length >0){
			    		for(i=0;i<arrItemEdit.length;i++){
							var fieldChangeds = document.getElementsByName("discontinueDate_"+arrItemEdit[i]);
							if(fieldChangeds != null){
								for(j=0;j<fieldChangeds.length;j++)
									fieldChangeds[j].value = discontinueDate;
							}
						}
			    	}
			    	
		    		changeRequest =true;
					//myDataTable.render();
		    	}
		    	else
		    	{
		    		alert('Please select UPC(s) that you want to mass fill');
		    	}
	        }
	    }
	
	    function saveDsdDiscontinue(ev)
	    {
	    	var tar = YAHOO.util.Event.getTarget(ev);
	    	if(dataDsdDiscontinue != null){ 
		    	var arrIdResult = new Array();
		 		var arrDiscontinueDate = new Array();
				
		 		var isExists;
		 		var countChanged =0;
				
		 		if(dataSourceTemp != null && dataSourceTemp.length >0)
		 		{   	
		 	       for(var i=0; i<dataSourceTemp.length; i++) {	    		
			 	       
						if(dataSourceTemp[i].changeStatus != null && (dataSourceTemp[i].changeStatus == "2" || dataSourceTemp[i].changeStatus == "3"))
						{
							countChanged++;
							//validate
							if (dataSourceTemp[i].discontinueDate == ""){
								alert('Please select a discontinue date');							
								if(YAHOO.util.Dom.get('discontinueDate_' + dataSourceTemp[i].idResult) != null)
									YAHOO.util.Dom.get('discontinueDate_' + dataSourceTemp[i].idResult).focus();
								return;
							}
							
							var arrValues = dataSourceTemp[i].idResult.split('-');
			 	    		var value = arrValues[1];
		
			 	    		isExists = false;
			 	    		
			 	    		for(var j=0; j < arrIdResult.length; j++){
				 	    		if(arrIdResult[j] == value){
				 	    			isExists = true;
				 	    			break;
				 	    		}
			 	    		}
		
			 	    		if(!isExists){
			 	    			arrIdResult.push(value);
			 	    			arrDiscontinueDate.push(dataSourceTemp[i].discontinueDate);
			 	    		}
						}	    		
		 	    	}
		
		 	      if(arrIdResult.length >0)
				  {
		 	    	ManageEDIDWR.updateDataForDsdDiscontinue(arrIdResult,arrDiscontinueDate,currentPage,
		 	    	    {
		 	    		  callback:function(data) {
								if(tar.id == 'saveExitBut-button')
									YAHOO.util.Dom.get('isSaveExit').value = "1";
								else
									YAHOO.util.Dom.get('isSaveExit').value = "";
								
		    					var formObject = document.getElementById('searchForm');
	 	    					showProgress();
	 	    					formObject.action = "${updateDsdUrl}";
	 	    					formObject.submit();
		 	    			},
		 	    			errorHandler:function(errorString, exception) {
		 	    				hideProgress();
		 	    			},
		 	   				timeout:180000
		 	    		});
		  		  }
		 	      else
		 	      {
			 	      if(countChanged == 0)				 	      
			 	    	 YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: green;'><b> No data change to update </b></span>"
		 	      }
				}
	    	}
	    }
		
		function resetDsdDiscontinue()
	    {
			var myDataSource = dsdDiscontinueResult.oDS;
			var myDataTable = dsdDiscontinueResult.oDT;
			//YAHOO.util.Dom.get('discontinueDate_massfill').value ="";
			
			YAHOO.util.Dom.get("sellingUpcFilter").value='';
			YAHOO.util.Dom.get("descriptionFilter").value='';
			YAHOO.util.Dom.get("vendorNoFilter").value='';
			YAHOO.util.Dom.get("vendorNameFilter").value='';
			YAHOO.util.Dom.get("discontinueDateFilter").value='';
			YAHOO.util.Dom.get("statusFilter").value='';
				
			isRejectChanged = false;
			currentPage = myDataTable.get('paginator').getState().page;
			if(dataDsdDiscontinue != null){ 
		    	//reset data source temp
				dataSourceTemp = [];
				filterTimeout = null;
				var pattent = "\.*__\.*__\.*__\.*__\.*";			
				myDataSource.sendRequest(pattent,{
					success : myDataTable.onDataReturnInitializeTable,
					failure : myDataTable.onDataReturnInitializeTable,
					scope   : myDataTable,
					argument: pattent	
				});
	    		
				if(YAHOO.util.Dom.get('SelectAll').checked)
					YAHOO.util.Dom.get('SelectAll').checked = false;
				
	    		changeRequest = false;
	    		YAHOO.util.Dom.get('saveResult').innerHTML ="";  

	    		//set current page is selected (before click reset button)
				myDataTable.get('paginator').setPage(parseInt(currentPage));		
			}
	    }

		 function modifySearchForDsdDiscontinue()
		 {
	    	var arrIdResult = new Array();
	 		var arrDiscontinueDate = new Array();
			
	 		var isExists;
	 		var isValid = true;
			
	 		if(dataSourceTemp != null && dataSourceTemp.length >0)
	 		{   	
	 	       for(var i=0; i<dataSourceTemp.length; i++) {	    		
					if(dataSourceTemp[i].changeStatus != null && (dataSourceTemp[i].changeStatus == "2" || dataSourceTemp[i].changeStatus == "3"))
					{
						isValid = true;
						//validate
						if (dataSourceTemp[i].discontinueDate == ""){							
							isValid = false;
						}

						if(isValid){
							var arrValues = dataSourceTemp[i].idResult.split('-');
			 	    		var value = arrValues[1];
		
			 	    		isExists = false;
			 	    		
			 	    		for(var j=0; j < arrIdResult.length; j++){
				 	    		if(arrIdResult[j] == value){
				 	    			isExists = true;
				 	    			break;
				 	    		}
			 	    		}
		
			 	    		if(!isExists){
			 	    			arrIdResult.push(value);
			 	    			arrDiscontinueDate.push(dataSourceTemp[i].discontinueDate);
			 	    		}
						}
					}	    		
	 	    	}

	 	      
	 	      if(arrIdResult.length >0)
			  {
	 	    	ManageEDIDWR.updateDataForDsdDiscontinue(arrIdResult,arrDiscontinueDate,currentPage,
	 	    	    {
	 	    		  callback:function(data) {
	 	    				modifySearchSubmitAction();    					
 	    					
	 	    			},
	 	    			errorHandler:function(errorString, exception) {
	 	    				hideProgress();
	 	    			},
	 	   				timeout:180000
	 	    		});
	  		  }
	 	      else
	 	      {
	 	    	 modifySearchSubmitAction();
	 	      }
			}
	 		else
	 		{
	 			modifySearchSubmitAction();
	 		} 		
		 }

		 function modifySearchSubmitAction()
		 {
			 var formObject = document.getElementById('searchForm');
			 showProgress();
			 formObject.action = "${modifySearch}";
			 formObject.submit();
		 }	    
	</script>
		
		
	</div>
</div>
</fieldset>
<div class="yui-skin-sam">
	<div id ="calDiscontinueContainer"></div>
	<script type="text/javascript">
		 yuiCalendar.create('calDiscontinueContainer',['imgCal_massfill']); 
	</script>
</div>
<form:hidden path="selectedItems" id="selectedItems"/>
	
<script type="text/javascript">

hideTable();
hideBorder('f1','hide');
new YAHOO.widget.Button("massFillBut");

//Authorized Store Click
var once = false;
<c:url value="/protected/cps/manageEDI/authorizedStore?${_csrf.parameterName}=${_csrf.token}" var="authorizedDSD"></c:url>
<c:url value="/protected/cps/manageEDI/authorizedStoreAjax?${_csrf.parameterName}=${_csrf.token}" var="authorizedDSDAjax"></c:url>

function authorizeDSDPopup(evt) 
{	
	var allItemSelected = getLstSelectItemToAuthorized(); 
	
	if(allItemSelected.length >0){	
		YAHOO.util.Dom.get('selectedItems').value = allItemSelected;

		var formObject = document.getElementById('searchForm');
		formObject.action = "${authorizedDSDAjax}";
		YAHOO.util.Connect.setForm(formObject);
		var callback = {
			success:function(o){
					hideProgress();
				try{
					generateAuthorizedDSDPopup(o.responseText);
					
				}catch(e){}
			}
		};
			showProgress();
			var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);			
			
	}else
	{
		alert("Please select UPC(s) that you want to authorized store.");
	}
}

YAHOO.namespace("heb.container.dsddiscontinue.AuthorizedDSDDiscontinue");
function generateAuthorizedDSDPopup()
{			
	showProgress();
	document.getElementById("panel2").style.display="";
	if(once == false){			
		once = true;
		YAHOO.heb.container.dsddiscontinue.AuthorizedDSDDiscontinue = new YAHOO.widget.Panel("panel2", 
		{ 	width:"780px", 
			height:"600px", 
			underlay:"shadow",
			visible:false, 
			constraintoviewport:true, 
			draggable:false,	
			zIndex : 55000,						
			modal:true,
			close:true,
			fixedCenter : true
			//effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}						
		} );
		
		YAHOO.heb.container.dsddiscontinue.AuthorizedDSDDiscontinue.render(document.body);	
	}	
	YAHOO.heb.container.dsddiscontinue.AuthorizedDSDDiscontinue.beforeHideEvent.subscribe(onBeforeHideAuthorizedDSDPanel);		
	YAHOO.heb.container.dsddiscontinue.AuthorizedDSDDiscontinue.beforeShowEvent.subscribe(onBeforeShowEvent4);			
	YAHOO.heb.container.dsddiscontinue.AuthorizedDSDDiscontinue.show();
	
	document.getElementById("popupFrame").style.height="100%";
	document.getElementById("popupFrame").style.width="100%";
	document.getElementById("popupFrame").src = "${authorizedDSD}";
	document.getElementById("popupHeader").innerHTML = '<font size="2" color="black">&nbsp;&nbsp;&nbsp; Authorized Stores</font>';		
	document.getElementById("popupFrame").innerHTML =data;					

}
function onBeforeHideAuthorizedDSDPanel(){
	once = false;
	document.getElementById("popupFrame").src = "";
	document.getElementById("panel2").style.display = "hidden";	
	document.getElementById("popupHeader").innerHTML = "";	
}
function onShowEvent4(){
	YAHOO.heb.container.dsddiscontinue.AuthorizedDSDDiscontinue.showMask();
}

function onBeforeShowEvent4(){
	//YAHOO.heb.container.dsddiscontinue.AuthorizedDSDDiscontinue.hideMask();
}



//Reject DSD Click
<c:url value="/protected/cps/manageEDI/rejectDSD?${_csrf.parameterName}=${_csrf.token}" var="rejectDSD"></c:url>
<c:url value="/protected/cps/manageEDI/rejectDSDAjax?${_csrf.parameterName}=${_csrf.token}" var="rejectDSDAjax"></c:url>

function rejectButDSDPopup(evt) 
{	
	var allProdIdsSelected = getLstSelectPsProdDSD(); 
	if(${ManageEDICandidate.isVendor}) {
		 for(var i=0; i<dataSourceTemp.length; i++) 
		 { 	    		 
			if((dataSourceTemp[i].changeStatus == "4" || dataSourceTemp[i].changeStatus == "3" || dataSourceTemp[i].changeStatus == "1") && (dataSourceTemp[i].dsdStatus=="107" || dataSourceTemp[i].dsdStatus=="109"))
			{
				alert("You may not reject working/activation failed candidate(s)");
				return;
			}
		 }
    }
	if(allProdIdsSelected.length>0){
		var message = confirm('Do you want to reject selected UPC(s)?');
		if(message){	
		YAHOO.util.Dom.get('productSelectedIds').value = allProdIdsSelected;
		var formObject = document.getElementById('searchForm');
		formObject.action = "${rejectDSDAjax}";
		YAHOO.util.Connect.setForm(formObject);
		var callback = {
			success:function(o){
					hideProgress();
				try{
					generateRejectDSDPopup(o.responseText);
					
				}catch(e){}
			}
		};
			showProgress();
			var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);			
		}		
	}else{
		alert("Please select UPC(s) that you want to reject");
	}
}
var once = false;
YAHOO.namespace("heb.container.dsddiscontinue.RejectDSDDiscontinue");
function generateRejectDSDPopup()
{			
	showProgress();
	document.getElementById("panel2").style.display="";
	if(once == false){			
		once = true;
		YAHOO.heb.container.dsddiscontinue.RejectDSDDiscontinue = new YAHOO.widget.Panel("panel2", 
		{ 	width:"1030px", 
			height:"600px", 
			underlay:"shadow",
			visible:false, 
			constraintoviewport:true, 
			draggable:false,	
			zIndex : 55000,						
			modal:true,
			close:false,
			fixedCenter : true
			//effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}						
		} );
		
		YAHOO.heb.container.dsddiscontinue.RejectDSDDiscontinue.render(document.body);	
	}	
		
	YAHOO.heb.container.dsddiscontinue.RejectDSDDiscontinue.beforeHideEvent.subscribe(onBeforeCloseRejectDSDPanel);		
	YAHOO.heb.container.dsddiscontinue.RejectDSDDiscontinue.beforeShowEvent.subscribe(onBeforeShowEvent3);			
	YAHOO.heb.container.dsddiscontinue.RejectDSDDiscontinue.show();
	
	document.getElementById("popupFrame").style.height="100%";
	document.getElementById("popupFrame").style.width="100%";
	document.getElementById("popupFrame").src = "${rejectDSD}";
	document.getElementById("popupHeader").innerHTML = '<font size="2" color="white">&nbsp;&nbsp;&nbsp; Reject DSD Discontinue</font>';		
	document.getElementById("popupFrame").innerHTML =data;					

}

function onBeforeCloseRejectDSDPanel(){
	once = false;
	document.getElementById("popupFrame").src = "";
	document.getElementById("panel2").style.display = "hidden";	
	document.getElementById("popupHeader").innerHTML = "";
}
function onShowEvent3(){
	YAHOO.heb.container.dsddiscontinue.RejectDSDDiscontinue.showMask();
}

function onBeforeShowEvent3(){
	//YAHOO.heb.container.dsddiscontinue.RejectDSDDiscontinue.hideMask();
}

function getLstSelectPsProdDSD()
{
	var allProdIdsSelected = new Array();
	var myDataSource = null;
	myDataSource = dataSourceTemp;		
	

	if(myDataSource != null && myDataSource.length >0)	
	{   	
	   for(var i=0; i<myDataSource.length; i++) 
	   { 	    		 
			if(myDataSource[i].changeStatus == "4" || myDataSource[i].changeStatus == "3" || myDataSource[i].changeStatus == "1")
			{
				var productId = myDataSource[i].productID;						
				if(!checkExistItem(allProdIdsSelected,productId))
				{
					allProdIdsSelected.push(productId);
				}							
			}						
	   }
	}

	return allProdIdsSelected;
}
function checkExistItem(allItemIdsSelected,itemId)
{		
	if(allItemIdsSelected != ''){
		for(var i=0;i<allItemIdsSelected.length;i++){
			if(allItemIdsSelected[i]==itemId){
				return true;
			}
		}		
	}		
	 return false;
}
function closePopup(){
	YAHOO.heb.container.dsddiscontinue.RejectDSDDiscontinue.hide();
}
function closeAuthorizedPopup(){
	YAHOO.heb.container.dsddiscontinue.AuthorizedDSDDiscontinue.hide();
}
function hideTheProgress(){
	hideProgress();
}
function showTheProgress(){
	showProgress();
}


function getLstSelectItemToAuthorized()
{
	var allItemSelected = new Array();
	var myDataSource = null;
	myDataSource = dataSourceTemp;		
	
	if(myDataSource != null && myDataSource.length >0)	
	{   	
	   for(var i=0; i<myDataSource.length; i++) 
	   { 	    		 
			if(myDataSource[i].changeStatus == "4" || myDataSource[i].changeStatus == "3" || myDataSource[i].changeStatus == "1")
			{
				var arrValues =  myDataSource[i].idResult.split('-');
				var item = arrValues[1] + "-" + arrValues[2] + "-" + arrValues[3];

				if(!checkExistItem(allItemSelected,item))
					allItemSelected.push(item);							
			}						
	   }
	}

	return allItemSelected;
}
function getLstSelectPsWorkIdDSD()
{
	var allPsWorkIdSelected = new Array();
	var myDataSource = null;
	myDataSource = dataSourceTemp;		
	

	if(myDataSource != null && myDataSource.length >0)	
	{   	
	   for(var i=0; i<myDataSource.length; i++) 
	   { 	    		 
			if(myDataSource[i].changeStatus == "4" || myDataSource[i].changeStatus == "3" || myDataSource[i].changeStatus == "1")
			{
				var psWorkId = myDataSource[i].idResult.split("-")[0];
				if(!checkExistItem(allPsWorkIdSelected,psWorkId))
				{
					allPsWorkIdSelected.push(psWorkId);
				}							
			}						
	   }
	}

	return allPsWorkIdSelected;
}
function getLstSelectApproveDSD()
{
	var allPsWorkIdSelected = new Array();
	var myDataSource = null;
	myDataSource = dataSourceTemp;		
	var count=0;
	
	if(myDataSource != null && myDataSource.length >0)	
	{   	
	   for(var i=0; i<myDataSource.length; i++) 
	   { 	    		 
			if((myDataSource[i].changeStatus == "4" || myDataSource[i].changeStatus == "3" || myDataSource[i].changeStatus == "1") && (myDataSource[i].dsdStatus=="107" || myDataSource[i].dsdStatus=="109"))
			{
				var psWorkId = myDataSource[i].idResult.split("-")[0];
				if(!checkExistItem(allPsWorkIdSelected,psWorkId))
				{
					allPsWorkIdSelected.push(psWorkId);
				}							
			}else if((myDataSource[i].changeStatus == "4" || myDataSource[i].changeStatus == "3" || myDataSource[i].changeStatus == "1") && (myDataSource[i].dsdStatus!=="107" || myDataSource[i].dsdStatus!=="109"))
			{	
				alert("You may not approve rejected candidate(s) and vendor candidate(s).");
				return false;
			}						
	   }
	}

	return allPsWorkIdSelected;
}

<c:url value="/protected/cps/manageEDI/approveDSD?${_csrf.parameterName}=${_csrf.token}" var="approveDSD"></c:url>
function approveDSDClick(evt) 
{	
	var myDataTable = dsdDiscontinueResult.oDT;
	var arrIdResult = new Array();
	var arrDiscontinueDate = new Array();
	var isExists;
	var countChanged =0;
	if(dataSourceTemp != null && dataSourceTemp.length >0)
	{   	
       for(var i=0; i<dataSourceTemp.length; i++) 
	   {	    		
	       
			if(dataSourceTemp[i].changeStatus != null && (dataSourceTemp[i].changeStatus == "1" || dataSourceTemp[i].changeStatus == "3"))
			{
				countChanged++;
				//validate
				if (dataSourceTemp[i].discontinueDate == ""){
					alert('Please select a discontinue date');							
					if(YAHOO.util.Dom.get('discontinueDate_' + dataSourceTemp[i].idResult) != null)
						YAHOO.util.Dom.get('discontinueDate_' + dataSourceTemp[i].idResult).focus();
					return;
				}
				
				var arrValues = dataSourceTemp[i].idResult.split('-');
 	    		var value = arrValues[1];

 	    		isExists = false;
 	    		
 	    		for(var j=0; j < arrIdResult.length; j++){
	 	    		if(arrIdResult[j] == value){
	 	    			isExists = true;
	 	    			break;
	 	    		}
 	    		}

 	    		if(!isExists){
 	    			arrIdResult.push(value);
 	    			arrDiscontinueDate.push(dataSourceTemp[i].discontinueDate);
 	    		}
			}	    		
    	}
    }
	
	var count = 0;
	for(var i=0; i<myDataTable.getRecordSet().getLength(); i++) {
		var oRec = myDataTable.getRecordSet().getRecord(i);
		if(oRec.getData("changeStatus")!= null && (oRec.getData("changeStatus") == "1" || oRec.getData("changeStatus")=="3")){
			// PIM 390
			//var discontinueDate = oRec.getData("discontinueDate");
			//var d = new Date(discontinueDate);
			//var toDate = new Date();
			//if(d <= toDate){
			//	alert("Discontinue Date must be greater than Today");
				//return false;
			//}
			count++;
		}
	}
	
	if(count<1){
		alert("Please select UPC(s) that you want to approve");
		return false;
	}
	var allPsWorkIdSelected = getLstSelectApproveDSD();
	if(allPsWorkIdSelected.length>0 && arrIdResult.length >0 && allPsWorkIdSelected.length==arrIdResult.length){
		var message = confirm('Do you want to approve selected UPC(s)?');
		if(message){
			ManageEDIDWR.approveDSDDiscontinue(allPsWorkIdSelected,arrIdResult,arrDiscontinueDate,currentPage,{
				callback:function(str){
				var formObject = document.getElementById('searchForm');
					showProgress();
					formObject.action = "${approveDSD}";
					formObject.submit();	
				},errorHandler:function(errorString, exception) {
	    				hideProgress();
				},
	   				timeout:180000
			});
		}
	}
/*
	 if(arrIdResult.length >0)
	  {
    	ManageEDIDWR.updateDataForDsdDiscontinue(arrIdResult,arrDiscontinueDate,currentPage,
    	    {
    		  callback:function(data) {
					if(tar.id == 'saveExitBut-button')
						YAHOO.util.Dom.get('isSaveExit').value = "1";
					else
						YAHOO.util.Dom.get('isSaveExit').value = "";
					
					var formObject = document.getElementById('searchForm');
					showProgress();
					formObject.action = "${updateDsdUrl}";
					formObject.submit();
    			},
    			errorHandler:function(errorString, exception) {
    				hideProgress();
    			},
   				timeout:180000
    		});
		  }
      else
      {
	      if(countChanged == 0)				 	      
	    	 YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: green;'><b> No data change to update </b></span>"
      }
*/    
}

function closePopup4(reSumit){
		if(!isRejectChanged){
			YAHOO.heb.container.dsddiscontinue.RejectDSDDiscontinue.hide();
		}
		if(reSumit && isRejectChanged){
			 //reload search edi candidate
		 	 //submit form	
		    var formObject = document.getElementById('searchForm');
			showProgress();
			formObject.action = "${removeRejectedCandidate}";
			formObject.method="POST";
			formObject.submit();    
		}
			
}
function setIsRejectChanged(isChanged){
	isRejectChanged = isChanged;
}
function closeIt(){
	if(confirm("Exit Reject DSD Discontinue? (click OK to exit)")){
		if(isRejectChanged){
			closePopup4(true);
		}else{
			closePopup4(false);
		}
	}
}
function checkDataChangeForAllTab(){
	var allItemChanged = new Array();
	var myDataSource = dataSourceTemp;		
	
	if(myDataSource != null && myDataSource.length >0)	
	{   	
	   for(var i=0; i<myDataSource.length; i++) 
	   { 	    		 
			if(myDataSource[i].changeStatus == "2" || myDataSource[i].changeStatus == "3")
			{
				var id = myDataSource[i].productID;
				if(!checkExistItem(allItemChanged,id))
				{
					allItemChanged.push(id);
				}							
			}						
	   }
	}
	return allItemChanged;
}
<c:url value="/protected/cps/manageEDI/removeRejectedCandidate?${_csrf.parameterName}=${_csrf.token}" var="removeRejectedCandidate"></c:url>
</script>
<form:hidden path="productSelectedIds" id="productSelectedIds"/>
	
<div id="dsdContainerFunction" style="text-align: center; padding-top: 10px;">
<%	
    if(BusinessUtil.isVendor(role)){
%>
	<input type="button" id="authorizedBut" value='Authorized Stores'/>
	<input type="button" id="rejectBut" value='Reject'/>
	
	<script type="text/javascript">	 	
		new YAHOO.widget.Button("authorizedBut");	
		new YAHOO.widget.Button("rejectBut"); 
		
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authorizedBut"), "click", authorizeDSDPopup);		  
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("rejectBut"), "click", rejectButDSDPopup); 
	</script>
<% }else if (BusinessUtil.isBDM(role) || BusinessUtil.isSCA(role) || BusinessUtil.isRPA(role)){ %>
	<input type="button" id="authorizedBut" value='Authorized Stores'/>
	
	<script type="text/javascript">	
		new YAHOO.widget.Button("authorizedBut");
		
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authorizedBut"), "click", authorizeDSDPopup);		  
	</script>
<%} else { %>
<div style="font-size:11px;">
	<input type="button" id="saveExitBut" value='Save & Exit'/>
	<input type="button" id="saveBut" value='Save'/>
	<input type="button" id="authorizedBut" value='Authorized Stores'/>
	<input type="button" id="resetBut" value='Reset'/>
	<input type="button" id="approveBut" value='Approve'/>
	<input type="button" id="rejectBut" value='Reject'/>
</div>	
	<script type="text/javascript">	
		
		new YAHOO.widget.Button("saveExitBut");
		new YAHOO.widget.Button("saveBut"); 	
		new YAHOO.widget.Button("authorizedBut");
		new YAHOO.widget.Button("resetBut");
		new YAHOO.widget.Button("approveBut");	
		new YAHOO.widget.Button("rejectBut");		
		
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveExitBut"), "click", saveDsdDiscontinue);
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveBut"), "click", saveDsdDiscontinue);
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authorizedBut"), "click", authorizeDSDPopup);		  
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("resetBut"), "click", resetDsdDiscontinue);
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("approveBut"), "click", approveDSDClick); 
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("rejectBut"), "click", rejectButDSDPopup);
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("massFillBut"), "click", massFillDsdDiscontinue);
	</script>
<%} %>
</div>
<%} %> 

<div id="panel2" style="display: none;">
<div class="hd">
	<div class="tl"></div>
	<span id="popupHeader"></span>
	<div class="closeMe" onclick="closeIt();"></div>		
</div>
<div class="bd">
	<iframe id="popupFrame" height="1px" width="1px"></iframe>
</div>
<div class="ft">
	<div class="bl"></div>
	<div class="br"></div>
</div>
</div>