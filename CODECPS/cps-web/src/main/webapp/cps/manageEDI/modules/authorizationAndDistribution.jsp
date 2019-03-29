<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="com.heb.operations.cps.vo.EDISearchResultVO" %>
<%@ page import="com.heb.operations.cps.model.ManageEDICandidate" %>
<%@ page import="com.heb.operations.cps.util.CPSHelper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<style type="text/css"> 

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

</style>

 
<script type="text/javascript">

function getWarehouseStore(postData){	
	var arrValues =  postData.split('_')[1].split('-');
	var idResult = arrValues[1] + "-" + arrValues[2] + "-" + arrValues[3];	
	var channel = arrValues[3];
	//if channel flag is both
	if(channel == 'null' || channel == ''){
		if(arrValues[2].length >= 6)
			channel = "V";
		else
			channel = "D";
	}
	showProgress();
	/*
	var callback = {
		success: function(o) {
			hideProgress();
			if(chanel == "D")
				getDSDDetail(o.responseText);
			else
				if(chanel == "V")
					getWHSDetail(o.responseText);

			},
		failure: function(o) {
			hideProgress();
			alert("AJAX doesnt work"); //FAILURE			
			},
		timeout: 120000
		} 

	var transaction = YAHOO.util.Connect.asyncRequest('POST', '${link123}', callback, "idResult="+idResult);
	*/
	ManageEDIDWR.getAuthorizationFromVendorSelected(idResult, {
		  callback:function(data) {
			hideProgress();
			if(channel == "D")
				getDSDDetail(data.appData);
			else
				if(channel == "V")
					getWHSDetail(data.appData);
			 },
			errorHandler:function(errorString, exception) {
				hideProgress();
			},
			timeout:120000			
		});
} 
function getObjectFilter(){
	var arrFilterObj = new Array();
	arrFilterObj.push("vendorFilter");
	arrFilterObj.push("sellingUpcFilter");
	arrFilterObj.push("descriptionFilter");
	return arrFilterObj;
}
function setFilterValue(){
	if(SER.itemResultFilter != null && SER.itemResultFilter != ""){
		var filterValues = document.getElementById('filterValues').value;
		if(filterValues != "")
		{
			var curTab = 6;
			var com = YAHOO.lang;
			var arrValueTab = filterValues.split("___");
							    
			if(arrValueTab[0] != ""){
				document.getElementById('vendorFilter').value = com.trim(arrValueTab[0].split('||')[0]);
				document.getElementById('sellingUpcFilter').value = com.trim(arrValueTab[0].split('||')[1]);
			}
			
			if(arrValueTab.length >curTab){
				var valueFilterOnTab = com.trim(arrValueTab[curTab]);
				if(valueFilterOnTab != ""){
					var arrObjFilter = getObjectFilter();
					var arrValueOnTab = valueFilterOnTab.split('||');
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
</script>

<div id="yahoo-com" class="yui-skin-sam">
	<div id="totalRecord" style="padding-left: 5px; color: blue"></div>
  	<div style="width:100%; z-index:15000;">
  		<table width="100%"> 
  			<tr>
  				<td width="55%" valign="top">
	    			<div id="tblAuthorization"></div> 
					<div id="pag" style="font-family:arial; font-size:10px;"></div>
  				</td>
  				<td valign="top">
  					<div id="resultWarehouseStore"></div>
  				</td>
  			</tr>
  		</table>	    
	</div>
	<%
		if(request.getSession().getAttribute("ManageEDICandidate") != null)
		{
			StringBuffer strData = new StringBuffer();
			List<EDISearchResultVO> results = ((ManageEDICandidate)(request.getSession().getAttribute("ManageEDICandidate"))).getEdiSearchResultVOLst();
			
			strData.append("[");
			if(results != null && results.size() >0)
			{				
				for(int i= 0; i< results.size(); i++)
				{								
					EDISearchResultVO ediResult = results.get(i);
					if(ediResult.getPsItemId() != null)
					{
						String WorkRq = String.valueOf(ediResult.getPsWorkId() != null? ediResult.getPsWorkId():ediResult.getPsProdId());
						String id = WorkRq + "-" + ediResult.getPsItemId() + "-" + ediResult.getPsVendno() + "-" + ediResult.getChannel() +"-"+i;
						String idRowHidden=CPSHelper.displaySellingUPC(ediResult.getUpcNo())+"__"+ediResult.isActiveProductKit();	
						if(i==0 || strData.toString().equals("["))
							strData.append("{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ WorkRq +"'>\",idResult:\"" + id);
						else
							strData.append("\n,{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ WorkRq +"'>\",idResult:\"" + id);					
						
						strData.append("\",changeStatus:\"0");
						strData.append("\",radio:\"<input type='radio' id='rdb_"+ id +"' name='rdbreview'>");
						strData.append("\",productID:\"" + ediResult.getPsProdId());
						strData.append("\",vendor:\"" + ediResult.getPsVendno() +" " + CPSHelper.convertCharToHTMLForJSON(ediResult.getPsVendName()));
						strData.append("\",sellingUpc:\"" + CPSHelper.displaySellingUPC(ediResult.getUpcNo()));
						strData.append("\",description:\"" + CPSHelper.convertCharToHTMLForJSON(ediResult.getSellingUPCDetailVO().getDescription()));
						strData.append("\",status:\""+ ediResult.getStatus());
						strData.append("\",idRowHidden:\""+ idRowHidden+ "\"}");
					}
				}
				
			}
			strData.append("]");
	%>
 		
	<script type="text/javascript">   		
	    var radioChecked = null;
	    var dataSourceTemp = [];
	    var filterItemReturn = [];
    	var authorizationResult = makeAuthorizationTable();

        function makeAuthorizationTable() {
    	 
    	var changeRequest = false;
    	
    	var	dataAuthorization = {   
     		         areacodes: <%=strData.toString()%>};  	                     

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
        
		var sortVendor = function(a, b, desc) {
            return sortCompare(a, b, desc, "vendor", "sellingUpc", false);           
        };

        var sortSellingUpc = function(a, b, desc) {
        	return sortCompare(a, b, desc, "sellingUpc", "vendor", false); 
        };

        var sortDescription = function(a, b, desc) {
            return sortCompare(a, b, desc, "description", "sellingUpc", false);           
        };
           
        var myColumnDefs = [{key:"changeStatus",    label:"" },
							{key:"idResult",    label:"" },	
							{key:"checkBoxs",    label:"All", minWidth: 30,
                            	children: [{key:"checkBox", label:"<input type='checkbox' id='SelectAll'/>",sortable:false, resizeable:false}]},                          
							{key:"radios",    label:"Review", width: 30,
								children: [{key:"radio", label:"",sortable:false, resizeable:false}]},													
                            {key:"vendors",    label:"Vendor", width: 185, sortable:true, sortOptions:{sortFunction:sortVendor},
								children: [{key:"vendor", label:"<div id ='vendorDiv'><input type='text' id='vendorFilter' name='divFilter' size='30' maxlength='50'></div>",sortable:false, resizeable:false}]},  
                            {key:"sellingUpcs",    label:"Selling UPC", width: 80, sortable:true, sortOptions:{sortFunction:sortSellingUpc},
								children: [{key:"sellingUpc", label:"<div id ='sellingUpcDiv'><input type='text' id='sellingUpcFilter' name='divFilter' size='10' maxlength='20'></div>",sortable:false, resizeable:false}]},
                            {key:"descriptions",    label:"Description", width: 200, sortable:true, resizeable:false, sortOptions:{sortFunction:sortDescription},
								children: [{key:"description", label:"<table class='tbl-filter'><tr><td width='110' class='td-filter'><div id ='descriptionDiv'><input type='text' id='descriptionFilter' name='divFilter' size='15' maxlength='50'></div></td><td class='td-filter'><input type='button' id='filterStatus' value='Hide'><input type='button' id='clearFilter' value='Clear'></td></tr></table>",sortable:false, resizeable:false}]},
							{key:"idRowHidden"}];   

 
        var myDataSource = new YAHOO.util.DataSource(dataAuthorization.areacodes);
        myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
        myDataSource.responseSchema = {
            fields: [{key:"changeStatus"},{key:"idResult"},{key:"productID"},{key:"checkBox"},{key:"radio"},
                     {key:"vendor"},{key:"sellingUpc"},{key:"description"},{key:"status"},{key:"idRowHidden"}]
        };

        myDataSource.doBeforeCallback = function (req,raw,res,cb) {
			// This is the filter function							
			var data     = res.results || [],
				filtered = [],
				i,l;

			if (dataSourceTemp.length ==0)
				dataSourceTemp = data;	
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
					res.results = filterItemReturn;
				}				
			}
					
			if (req) {															
						var temp="";	
						if(SER.itemResultFilter != null && SER.itemResultFilter != "" && filterItemReturn.length >0){
							for (i = 0; i< filterItemReturn.length; i++) 
							{
								temp="";																	
								temp=SER.convertFromIrToRegularPattern(convertSpecialChars(filterItemReturn[i].vendor.toUpperCase()))+"__"+filterItemReturn[i].sellingUpc.toUpperCase()+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(filterItemReturn[i].description.toUpperCase()));
								var pattern = new RegExp(req);			
								if(pattern.test(temp))
								{								
									filtered.push(filterItemReturn[i]);			
								}
							}
						}
						else
						{
							for (i = 0, l = dataSourceTemp.length; i < l; ++i) 
							{
								temp="";																	
								temp=SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].vendor.toUpperCase()))+"__"+dataSourceTemp[i].sellingUpc.toUpperCase()+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].description.toUpperCase()));										
								var pattern = new RegExp(req);			
								if(pattern.test(temp))
								{								
									filtered.push(dataSourceTemp[i]);			
								}						
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
            	rowsPerPage: parseInt(SER.currentRecord),
                template: YAHOO.widget.Paginator.TEMPLATE_ROWS_PER_PAGE,
                rowsPerPageOptions: [10,25,50,100],
                pageLinks: 5,
                containers:'pag'
            }),
			height: "250px",
            draggableColumns:false
        }

        var myDataTable = new YAHOO.widget.ScrollingDataTable("tblAuthorization", myColumnDefs, myDataSource, myConfigs);
        //hidden column
        myDataTable.hideColumn(myDataTable.getColumn("changeStatus"));
        myDataTable.hideColumn(myDataTable.getColumn("idResult"));
		myDataTable.hideColumn(myDataTable.getColumn("idRowHidden"));
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

		myDataTable.subscribe("radioClickEvent", function(oArgs){ 
        	
            var elRadio = oArgs.target; 
            var oRecord = this.getRecord(elRadio); 
			
			if(elRadio.checked){
				radioChecked = oRecord.getData("idResult");
				getWarehouseStore(elRadio.id);
			}

        });

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
		        		oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") + " name=ckb_"+ oRec.getData("idResult").split('-')[0] +" checked=checked class=yui-dt-checkbox />");
						oRec.setData("changeStatus","1");
		        	}
		        	else
		        	{
		        		oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[0] +" class=yui-dt-checkbox />");
		        		oRec.setData("changeStatus","0");

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
			
			changeRequest = true;
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
							oRec.setData("changeStatus","1");
	    	            }
	           			else
	           			{
	           				oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[0] +" class=yui-dt-checkbox />");
			        		oRec.setData("changeStatus","0");
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

		myDataTable.get('paginator').on( 'changeRequest', function () {
            var cur = myDataTable.get('paginator').getState();;
            SER.currentRecord= cur.rowsPerPage;
        });
	
        
        myDataTable.subscribe("initEvent", function(){changeRequest = true;});
        myDataTable.subscribe("columnSortEvent", function(){changeRequest = true; });
        myDataTable.get('paginator').on( 'changeRequest', function () {changeRequest = true;} );
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
	        if(changeRequest) {
			
	        	changeRequest = false;       	
				
				if(radioChecked != null && YAHOO.util.Dom.get("rdb_"+radioChecked) != null)
					YAHOO.util.Dom.get("rdb_"+radioChecked).checked = true;
		        
	        }
        
		//set total record retuned
	        var totalRecords = myDataTable.get('paginator').getState().totalRecords;
	        var itemReturn = (totalRecords < dataSourceTemp.length? " (out of " + dataSourceTemp.length + " total " + (dataSourceTemp.length>1?"items":"item") + ") returned" : " returned");			
			if(totalRecords > 1)
				YAHOO.util.Dom.get('totalRecord').innerHTML = totalRecords + " items" + itemReturn;
			else
				YAHOO.util.Dom.get('totalRecord').innerHTML = totalRecords + " item" + itemReturn;
        }); 

         //filtering
		YAHOO.util.Event.on('vendorFilter','change',function (e) {			
			doBeforeFilter(e);
		});
	
		YAHOO.util.Event.on('sellingUpcFilter','change',function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('descriptionFilter','change',function (e) {		
			doBeforeFilter(e);
		});
		   
		YAHOO.util.Event.on('clearFilter','click',function (e) {	
			document.getElementById("vendorFilter").value='';
			document.getElementById("sellingUpcFilter").value='';
			document.getElementById("descriptionFilter").value='';
			
			SER.hasFilter = false;
			SER.itemResultFilter = "";
			document.getElementById('filterValues').value = "";
			
			clearTimeout(filterTimeout);
			setTimeout(updateFilter,600);
		});

		function doBeforeFilter(e)
		{		
			clearTimeout(filterTimeout);
			setTimeout(updateFilter,600);

			SER.hasFilter = true;
		}

		//event for Hide and Show button
    	YAHOO.util.Event.on('filterStatus','click',  function(e){
			hideShowFilter(e);
		});

    	setFilterValue();
		
        return {
            oDS: myDataSource,
            oDT: myDataTable
        };
    };

    //event for Hide and Show button Clear filter
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
		arrFilterObj.push("vendorFilter");
		arrFilterObj.push("sellingUpcFilter");
		arrFilterObj.push("descriptionFilter");
		
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
						dataSourceTemp[i].changeStatus = "1";
	            	}
	            }
       			else
       			{
       				if((isFilter && id.inArray(idWorkRq)) || !isFilter){
	       				dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
	       				dataSourceTemp[i].changeStatus = "0";
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
		        		dataSourceTemp[i].changeStatus = "1";
		        	}
		        	else
		        	{
		        		dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
		        		dataSourceTemp[i].changeStatus = "0";
		        	}
		        }
			 }
		}
	}

    function getWHSDetail(dataWHS) {
		YAHOO.util.Dom.get('resultWarehouseStore').innerHTML = "";
        var	data = 	eval(dataWHS);
        var myColumnDefs = [{key:"bicep",    label:"Bicep", width: 50},
                            {key:"warehouse",    label:"Warehouse", width: 60 },	
							{key:"warehouseName",    label:"Warehouse Name", width: 200},
							{key:"authorized",    label:"Authorized", width: 50}];   

 
        var myDataSource = new YAHOO.util.DataSource(data);
        myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
        myDataSource.responseSchema = {
            fields: [{key:"bicep"},{key:"warehouse"},{key:"warehouseName"},{key:"authorized"}]
        };
 
        var myConfigs = {
        	height: "280px",
            draggableColumns:false
        }

        var myDataTable = new YAHOO.widget.ScrollingDataTable("resultWarehouseStore", myColumnDefs, myDataSource, myConfigs);    
    }
	
	function getDSDDetail(dataDSD) {  
		YAHOO.util.Dom.get('resultWarehouseStore').innerHTML = "";	
		var	data = 	eval(dataDSD);		
        var myColumnDefs = [{key:"costGroup",    label:"Cost Group", width: 50},
                            {key:"store",    label:"Store", width: 30 },	
							{key:"storeName",    label:"Store Name", width: 202},
							{key:"authorized",    label:"Authorized", width: 50}];   

 
        var myDataSource = new YAHOO.util.DataSource(data);
        myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
        myDataSource.responseSchema = {
            fields: [{key:"costGroup"},{key:"store"},{key:"storeName"},{key:"authorized"}]
        };

 
        var myConfigs = {
			height: "280px",
            draggableColumns:false
        }

        var myDataTable = new YAHOO.widget.ScrollingDataTable("resultWarehouseStore", myColumnDefs, myDataSource, myConfigs);    
    	
    }

	function resetAuthorizationTab(){
		radioChecked = null;

		document.getElementById("vendorFilter").value='';
		document.getElementById("sellingUpcFilter").value='';
		document.getElementById("descriptionFilter").value='';

		//reset data source filter
		filterItemReturn = [];
		//reset data source temp
		dataSourceTemp = [];
		
		var myDataSource = authorizationResult.oDS;
		var myDataTable = authorizationResult.oDT;
		
		var currentPage = myDataTable.get('paginator').getState().page;
		
		filterTimeout = null;
		var pattent = "\.*__\.*__\.*";			
		myDataSource.sendRequest(pattent,{
			success : myDataTable.onDataReturnInitializeTable,
			failure : myDataTable.onDataReturnInitializeTable,
			scope   : myDataTable,
			argument: pattent	
		});

		if(YAHOO.util.Dom.get('SelectAll').checked)
			YAHOO.util.Dom.get('SelectAll').checked = false;

		YAHOO.util.Dom.get('resultWarehouseStore').innerHTML = "";
		//set current page is selected (before click reset button)
		myDataTable.get('paginator').setPage(parseInt(currentPage));

		setFilterValue();
				}
</script>
 <%} %> 		

</div>
