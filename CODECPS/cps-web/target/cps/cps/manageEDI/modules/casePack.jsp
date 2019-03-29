<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
    
<%@ page import="java.util.*" %>
<%@ page import="com.heb.operations.cps.vo.EDISearchResultVO" %>
<%@ page import="com.heb.operations.cps.model.ManageEDICandidate" %>
<%@ page import="com.heb.operations.cps.util.CPSHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.heb.operations.cps.util.CPSHelper"%><html>
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>Case Pack Tab</title>
<style type="text/css">
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
.yui-skin-sam .yui-dt-scrollable .yui-dt-bd {
	z-index:1;
	overflow:auto;
	width:"99.9%";				
	position:relative;	
	
}
.yui-skin-sam .yui-dt-scrollable .yui-dt-hd {
	overflow:visible;			
	z-index:2;		
	position:relative;				
	width:"99.9%";
}
.disabled-text{ border-width:1px; border-color: #cdcdcd; border-style: solid; padding: 2px; color: #666;}
</style>
</head>
<body id="yahoo-com" class="yui-skin-sam">
<script type="text/javascript">
var dataCasePack = null;

//======================BEGIN SET AUTOCOMPLETE FOR FILTER ==============================//
var arrayDataFilter;	
	getCasePackTabAutoFilter = function(query)
	{		
		var arrTemp = query.split("__");		
		var temp = arrTemp[0];
		temp = decodeURIComponent(temp);
		var po = parseInt(arrTemp[1]);						
		reslts = [];				
	    for (var i = 0; i < arrayDataFilter[po].length; i++) {
		    var t1 =arrayDataFilter[po][i];
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
		var oACDS = new YAHOO.widget.DS_JSFunction(getCasePackTabAutoFilter);
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
		oAutoComp.doBeforeExpandContainer = function() {
		var Dom = YAHOO.util.Dom;				
		Dom.setXY(idContainDiv, [Dom.getX(idInput), Dom.getY(idInput) + Dom.get(idInput).offsetHeight] );		
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
		 
		var temp = oAutoComp;
		var sendEmptyQuery = function(t1, t2) {			
            setTimeout(function() {t2.sendQuery(""+"__"+fldIndex);}, 0);
            document.getElementById(idInput).focus();
		};
		document.getElementById(idContainDiv).onmouseout = function() {
			document.getElementById(idContainDiv).style.display = 'none';
			document.getElementById(idContainDiv).onmouseover = function() {
				document.getElementById(idContainDiv).style.display = '';
			};
		};

		document.getElementById(idInput+"Image").onclick = function() {
			document.getElementById(idContainDiv).style.display = '';
		};
		
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get(idInput+"Image"), "click", sendEmptyQuery,temp); 
	}
//==========================END SET AUTOCOMPLETE FOR FILTER==============================//
	function getObjectFilter(){
		var arrFilterObj = new Array();
		arrFilterObj.push("vendorFilter");
		arrFilterObj.push("sellingUpcFilter");
		arrFilterObj.push("caseUpcFilter");
		arrFilterObj.push("vpcCodeFilter");
		arrFilterObj.push("mterPackQtyFilter");
		arrFilterObj.push("mterPackLengthFilter");
		arrFilterObj.push("mterPackWidthFilter");
		arrFilterObj.push("mterPackHeightFilter");
		arrFilterObj.push("shipPackQtyFilter");
		arrFilterObj.push("shipPackLengthFilter");
		arrFilterObj.push("shipPackWidthFilter");
		arrFilterObj.push("shipPackHeightFilter");
		arrFilterObj.push("venPalTieFilter");
		arrFilterObj.push("venPalTierFilter");
		return arrFilterObj;
	}
	function setFilterValue(){
		if(SER.itemResultFilter != null && SER.itemResultFilter != ""){
			var filterValues = document.getElementById('filterValues').value;
			if(filterValues != "")
			{
				var curTab = 3;
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
<div id="CasePackMain">
	<div>
	<table width="100%">
		<tr>
			<td width = "30%">
				<div id="totalRecord" style="padding-left: 5px; color: blue" align="left"></div>
			</td>
			<td width="70%">
				<div id="saveResult" style="color: green" align="left"></div>
			</td>
		</tr>
	</table>
	</div>
	<div id="tblCasePack" style="width: 100%; z-index: 15000;"></div>
	<div id="pag" style="font-family:arial; font-size:10px;"></div>
</div>

<%
	if (request.getSession().getAttribute("ManageEDICandidate") != null) {
		StringBuffer strData = new StringBuffer();

		List<EDISearchResultVO> results = ((ManageEDICandidate) (request
				.getSession().getAttribute("ManageEDICandidate")))
				.getEdiSearchResultVOLst();
		strData.append("[");
		if (results != null && results.size() > 0) {
			for (int i = 0; i < results.size(); i++) {
				EDISearchResultVO ediResult = results.get(i);
				String WorkRq = String.valueOf(ediResult.getPsWorkId() != null? ediResult.getPsWorkId():ediResult.getPsProdId());
				String id = WorkRq + "-" 
						+ ediResult.getPsItemId() + "-"
						+ ediResult.getPsVendno() + "-"
						+ ediResult.getChannel();
				String idRowHidden=CPSHelper.displaySellingUPC(ediResult.getUpcNo())+"__"+ediResult.isActiveProductKit();	
				if (ediResult.getPsItemId() != null) {
					if(i==0 || strData.toString().equals("["))
						strData.append("{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ WorkRq +"'>\",idResult:\"" + id);
					else
						strData.append("\n,{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ WorkRq +"'>\",idResult:\"" + id);
						
					strData.append("\",changeStatus:\"" + (!ediResult.isNewDataSw() || ediResult.isDisable() || ediResult.getCandidateSw() == 'N' ? "-1":"0"));
					strData.append("\",productID:\"" + ediResult.getPsProdId());
					strData.append("\",vendor:\""
							+ ediResult.getPsVendno() + " " + CPSHelper.convertCharToHTMLForJSON(ediResult.getPsVendName())
							+ "\",sellingUpc:\""
							+ CPSHelper.displaySellingUPC(ediResult.getUpcNo()));
					strData.append("\",caseUPC:\""+ ediResult.getCasePackDetailVO().getCaseUpc());
					strData.append("\",vpcCode:\""+ ediResult.getCasePackDetailVO().getVpc());
					strData.append("\",mterPackQty:\""+ ediResult.getCasePackDetailVO().getMasterPackQty());
					strData.append("\",mterPackLength:\""+ ediResult.getCasePackDetailVO().getMasterPacklength());
					strData.append("\",mterPackWidth:\""+ ediResult.getCasePackDetailVO().getMasterPackwidth());
					strData.append("\",mterPackHeight:\""+ ediResult.getCasePackDetailVO().getMasterPackHeight());
					strData.append("\",shipPackQty:\""+ ediResult.getCasePackDetailVO().getShipPackQty());
					strData.append("\",shipPackLength:\""+ ediResult.getCasePackDetailVO().getShipPacklength());
					strData.append("\",shipPackWidth:\""+ ediResult.getCasePackDetailVO().getShipPackwidth());
					strData.append("\",shipPackHeight:\""+ ediResult.getCasePackDetailVO().getShipPackHeight());
					strData.append("\",venPalTie:\""+ ediResult.getCasePackDetailVO().getVendPalTie());
					strData.append("\",venPalTier:\""+ ediResult.getCasePackDetailVO().getVendPalTier());
					strData.append("\",status:\""+ ediResult.getStatus());
					strData.append("\",idRowHidden:\""+ idRowHidden+ "\"}");
				}
			}

		}
		strData.append("]");
%>
<script type="text/javascript">
<c:url value="${request.getContextPath()}/hebAssets/images/dropdown.bmp" var="image"></c:url>

	dataCasePack = {

			areacodes: <%=strData.toString()%>};  		
									
			var changeRequest = false;
			var dataSourceTemp = [];
			var filterItemReturn = [];			
			var casePackResult = makeCasePackTable();
							
	function makeCasePackTable() {
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
		
		var sortCaseUpc = function(a, b, desc) {
	        return sortCompare(a, b, desc, "caseUPC", "sellingUpc", true);           
	    };
		
		var sortVpcCode = function(a, b, desc) {
	        return sortCompare(a, b, desc, "vpcCode", "sellingUpc", false);           
	    };
			
		var sortMterPackQty = function(a, b, desc) {
	        return sortCompare(a, b, desc, "mterPackQty", "sellingUpc", true);           
	    };
		
		var sortMterPackLength = function(a, b, desc) {
	        return sortCompare(a, b, desc, "mterPackLength", "sellingUpc", true);           
	    };
		
		var sortMterPackWidth = function(a, b, desc) {
        	return sortCompare(a, b, desc, "mterPackWidth", "sellingUpc", true);           
      	};
		
		var sortMterPackHeight = function(a, b, desc) {
	        return sortCompare(a, b, desc, "mterPackHeight", "sellingUpc", true);           
	    };
		
		var sortShipPackQty = function(a, b, desc) {
           	return sortCompare(a, b, desc, "shipPackQty", "sellingUpc", true);           
        };
		
		var sortShipPackLength = function(a, b, desc) {
            return sortCompare(a, b, desc, "shipPackLength", "sellingUpc", true);           
        };
		
		var sortShipPackWidth = function(a, b, desc) {
            return sortCompare(a, b, desc, "shipPackWidth", "sellingUpc", true);           
        };
		
		var sortShipPackHeight = function(a, b, desc) {
            return sortCompare(a, b, desc, "shipPackHeight", "sellingUpc", true);           
        };
		
		var sortVenPalTie = function(a, b, desc) {
           	return sortCompare(a, b, desc, "venPalTie", "sellingUpc", true);           
        };
		
		var sortVenPalTier = function(a, b, desc) {
           	return sortCompare(a, b, desc, "venPalTier", "sellingUpc", true);           
        }; 

		var myColumnDefs = [
					{key:"checkBoxs",    label:"All",minWidth: 20,
						children: [{key:"checkBox", label:"<input type='checkbox' id='SelectAll'/>"}]},
					{key:"changeStatus",    label:""},
					{key:"idResult",    label:"Id"},
					{key:"vendors",    label:"Vendor", width: 150,minWidth: 150, sortable:true, sortOptions:{sortFunction:sortVendor},
						children: [{key:"vendor", label:"<div id='vendorDiv' class ='myAutoComplete'><input type='text' id='vendorFilter' name='divFilterSel' size='25' maxlength='50' style='TEXT-TRANSFORM\: uppercase; position: relative;'><img src='${image}' alt='' width='20' id='vendorFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerVendorFilter'></div></div>",sortable:false, resizeable:false}]},  
					{key:"sellingUpcs",    label:"Selling UPC", width: 105, minWidth: 105, sortable:true, sortOptions:{sortFunction:sortSellingUpc},
						children: [{key:"sellingUpc", label:"<div id='sellingUpcDiv' class ='myAutoComplete'><input type='text' id='sellingUpcFilter' name='divFilterSel' size='10' maxlength='15' style='TEXT-TRANSFORM\: uppercase; position: relative;'><img src='${image}' alt='' width='20' id='sellingUpcFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerSellingUpcFilter'></div></div>",sortable:false, resizeable:false}]},
					{key:"caseUPCs",    label:"Case UPC",width: 100, minWidth: 100,sortable:true, sortOptions:{sortFunction:sortCaseUpc},
						children: [{key:"caseUPC", label:"<div id='caseUpcDiv' class ='myAutoComplete'><input type='text' id='caseUpcFilter' name='divFilterSel' size='10' maxlength='15' style='TEXT-TRANSFORM\: uppercase; position: relative;'><img src='${image}' alt='' width='20' id='caseUpcFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerCaseUpcFilter'></div></div>",sortable:false, resizeable:false}]},
					{key:"vpcCodes",    label:"VPC/MFG<br/> Code", width: 70, minWidth: 70,sortable:true, sortOptions:{sortFunction:sortVpcCode},
						children: [{key:"vpcCode", label:"<div id='vpcCodeDiv' class ='myAutoComplete'><input type='text' id='vpcCodeFilter' name='divFilterSel' size='5' maxlength='20' style='TEXT-TRANSFORM\: uppercase; position: relative;'><img src='${image}' alt='' width='20' id='vpcCodeFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerVpcCodeFilter'></div></div>",sortable:false, resizeable:false}]},
					{key:"mterPackQtys",    label:"Master Pack<br/> Qty",width: 50, minWidth: 50,sortable:true, sortOptions:{sortFunction:sortMterPackQty},
						children: [{key:"mterPackQty", label:"<input type='text' id='mterPackQtyFilter' name='divFilterSel' size='4' maxlength='15'>",sortable:false, resizeable:false}]},
					{key:"mterPackLengths",    label:"Master Pack<br/> Length",width: 50, minWidth: 50,sortable:true, sortOptions:{sortFunction:sortMterPackLength},
						children: [{key:"mterPackLength", label:"<input type='text' id='mterPackLengthFilter' name='divFilterSel' size='4' maxlength='15'>",sortable:false, resizeable:false}]},
					{key:"mterPackWidths",    label:"Master Pack<br/> Width",width: 50, minWidth: 50,sortable:true, sortOptions:{sortFunction:sortMterPackWidth},
						children: [{key:"mterPackWidth", label:"<input type='text' id='mterPackWidthFilter' name='divFilterSel' size='4' maxlength='15'>",sortable:false, resizeable:false}]},
					{key:"mterPackHeights",    label:"Master Pack<br/> Height",width: 50, minWidth: 50,sortable:true, sortOptions:{sortFunction:sortMterPackHeight},
						children: [{key:"mterPackHeight", label:"<input type='text' id='mterPackHeightFilter' name='divFilterSel' size='4' maxlength='15'>",sortable:false, resizeable:false}]},
					{key:"shipPackQtys",    label:"Ship Pack<br/> Qty",width: 40, minWidth: 40,sortable:true, sortOptions:{sortFunction:sortShipPackQty},
						children: [{key:"shipPackQty", label:"<input type='text' id='shipPackQtyFilter' name='divFilterSel' size='3' maxlength='15'>",sortable:false, resizeable:false}]},
					{key:"shipPackLengths",    label:"Ship Pack<br/> Length",width: 40, minWidth: 40,sortable:true, sortOptions:{sortFunction:sortShipPackLength},
						children: [{key:"shipPackLength", label:"<input type='text' id='shipPackLengthFilter' name='divFilterSel' size='3' maxlength='15'>",sortable:false, resizeable:false}]},
					{key:"shipPackWidths",    label:"Ship Pack<br/> Width",width: 40, minWidth: 40,sortable:true, sortOptions:{sortFunction:sortShipPackWidth},
						children: [{key:"shipPackWidth", label:"<input type='text' id='shipPackWidthFilter' name='divFilterSel' size='3' maxlength='15'>",sortable:false, resizeable:false}]},
					{key:"shipPackHeights",    label:"Ship Pack<br/> Height",width: 40, minWidth: 40,sortable:true, sortOptions:{sortFunction:sortShipPackHeight},
						children: [{key:"shipPackHeight", label:"<input type='text' id='shipPackHeightFilter' name='divFilterSel' size='3' maxlength='15'>",sortable:false, resizeable:false}]},
					{key:"venPalTies",    label:"Vendor<br/> Tie",width: 40, minWidth: 40,sortable:true, sortOptions:{sortFunction:sortVenPalTie},
						children: [{key:"venPalTie", label:"<input type='text' id='venPalTieFilter' name='divFilterSel' size='3' maxlength='15'>",sortable:false, resizeable:false}]},
					{key:"venPalTiers",    label:"Vendor<br/> Tier", width: 125, sortable:true, sortOptions:{sortFunction:sortVenPalTier},
						children: [{key:"venPalTier", label:"<table class='tbl-filter'><tr><td width='40%' class='td-filter'><div id='venPalTier'><input type='text' id='venPalTierFilter' size='3' maxlength='15' name='divFilterSel'\/></div></td><td class='td-filter'><input type='button' id='filterStatus' value='Hide'\/><input type='button' id='clearSelFilter' value='Clear'\/></td></tr></table>",sortable:false, resizeable:false}]},
					{key:"idRowHidden"}];
						                          
						 
		var myDataSource = new YAHOO.util.DataSource(dataCasePack.areacodes);
		myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
		myDataSource.responseSchema = {
			fields: ["productID","checkBox","changeStatus","idResult","vendor","sellingUpc","caseUPC","vpcCode","mterPackQty","mterPackLength",
						"mterPackWidth","mterPackHeight","shipPackQty","shipPackLength","shipPackWidth","shipPackHeight","venPalTie","venPalTier","status","idRowHidden"]
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
				}
				res.results = filterItemReturn;				
			}
			
			if (req) {		
					var temp="";
					if(SER.itemResultFilter != null && SER.itemResultFilter != "" && filterItemReturn.length >0){
						for (i = 0; i< filterItemReturn.length; i++) 
						{
							temp="";																	
							temp=SER.convertFromIrToRegularPattern(convertSpecialChars(filterItemReturn[i].vendor.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].sellingUpc.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].caseUPC.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].vpcCode.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].mterPackQty.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].mterPackLength.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].mterPackWidth.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].mterPackHeight.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].shipPackQty.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].shipPackLength.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].shipPackWidth.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].shipPackHeight.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].venPalTie.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].venPalTier.toUpperCase());
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
							temp=SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].vendor.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].sellingUpc.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].caseUPC.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].vpcCode.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].mterPackQty.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].mterPackLength.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].mterPackWidth.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].mterPackHeight.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].shipPackQty.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].shipPackLength.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].shipPackWidth.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].shipPackHeight.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].venPalTie.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].venPalTier.toUpperCase());
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
				containers: 'pag'
				}),
				height:"220px",
				draggableColumns:false
			}
						
		var myDataTable = new YAHOO.widget.ScrollingDataTable("tblCasePack", myColumnDefs, myDataSource, myConfigs);
		//get data of each field to array
		arrayDataFilter = [];
		setDataSourceForAutocompleteFilter();

		//set autocomplete for filter
		var arrFilter = new Array();			
		arrFilter.push("vendorFilter");
		arrFilter.push("sellingUpcFilter");
		arrFilter.push("caseUpcFilter");
		arrFilter.push("vpcCodeFilter");	
		var cnt=0;
		for(var i=0;i < arrFilter.length;i++)
		{										
			setAutoCompleteForFilter("myContainer"+arrFilter[i].capitaliseFirstLetter(arrFilter[i]),arrFilter[i],cnt++);
			document.getElementById(arrFilter[i]).parentNode.parentNode.parentNode.style.overflow = 'visible';				
		}
		//hiden column
		myDataTable.hideColumn(myDataTable.getColumn("idResult"));
		myDataTable.hideColumn(myDataTable.getColumn("changeStatus"));
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
						oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") + " name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" checked=checked class=yui-dt-checkbox />");
						oRec.setData("changeStatus", getChangeStatusOnCasePackTab(oRec.getData("changeStatus"), true));		        	
		        	}
		        	else
		        	{
		        		oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />");
						oRec.setData("changeStatus", getChangeStatusOnCasePackTab(oRec.getData("changeStatus"), false));

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
					//get current record
					var arrCurentRecordsId = new Array();				    			
					for(var i=0; i<oRS.getLength(); i++) {
						var oRec = oRS.getRecord(i);
						var idWorkRqTemp = oRec.getData("idResult").split('-')[0];
						arrCurentRecordsId.push(idWorkRqTemp);
						if(check)
	    	            {
	    	            	oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" checked=checked class=yui-dt-checkbox />");
	    	            	var changeValue = getChangeStatusOnCasePackTab(oRec.getData("changeStatus"), true);
	    	            	if(changeValue != null)
	    	            		oRec.setData("changeStatus", changeValue);
	    	            }
	           			else
	           			{
	           				oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />");
	           				var changeValue = getChangeStatusOnCasePackTab(oRec.getData("changeStatus"), false);
	    	            	if(changeValue != null)
	           					oRec.setData("changeStatus", changeValue);
	           			}  
					}
						
					//update datatable temp (used for filter)
					if(check)	
	    				saveDataSourceTempWhenCheck(arrCurentRecordsId, true, true);
					else
						saveDataSourceTempWhenCheck(arrCurentRecordsId, false, true);
	    			
	    			changeRequest =true;
	    			this.render();
				}
			}
		});

		//render event
		myDataTable.on('renderEvent', function () {
			var oRS = myDataTable.getRecordSet();
			var isCheckFlag = false;
			for(var i = 0;i< oRS.getLength();i++)
			{
				var oRec = oRS.getRecord(i);									
				var cK=oRec.getData("checkBox");
				var bChecked = cK.split("checked=checked");
				//if check						
				bChecked = (bChecked[1]) ? "checked=checked" : "";
				
				if(bChecked!="checked=checked")
				{
					isCheckFlag = true;
					break;
				}
			}
			
			if(isCheckFlag)
			{
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
		myDataTable.subscribe("postRenderEvent", function(){
			var elements = YAHOO.util.Dom.getElementsByClassName('yui-dt-bd', 'div')[0];
			
				if(elements!=null)
				{
					var beforeScroll = elements.scrollLeft;				
					elements.scrollLeft = beforeScroll;
				}	
		});
		
		myDataTable.get('paginator').on( 'changeRequest', function () {
            var cur = myDataTable.get('paginator').getState();
            SER.currentRecord = cur.rowsPerPage;
        });

		//filtering
		var evtFilter= 'change';
		YAHOO.util.Event.on('vendorFilter',evtFilter,function (e) {
			doBeforeFilter(e);
		});
	
		YAHOO.util.Event.on('sellingUpcFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('caseUpcFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});			
		YAHOO.util.Event.on('vpcCodeFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('mterPackQtyFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('mterPackLengthFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('mterPackWidthFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('mterPackHeightFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('shipPackQtyFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('shipPackLengthFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('shipPackWidthFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('shipPackHeightFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('venPalTieFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('venPalTierFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});

		function doBeforeFilter(e)
		{		
			clearTimeout(filterTimeout);
			setTimeout(updateFilter,600);
			SER.hasFilter = true;
		}

		YAHOO.util.Event.on('clearSelFilter','click',function (e) {	
			
			document.getElementById("vendorFilter").value='';
			document.getElementById("sellingUpcFilter").value='';
			document.getElementById("caseUpcFilter").value='';
			document.getElementById("vpcCodeFilter").value='';
			document.getElementById("mterPackQtyFilter").value='';
			document.getElementById("mterPackLengthFilter").value='';
			document.getElementById("mterPackWidthFilter").value='';
			document.getElementById("mterPackHeightFilter").value='';
			document.getElementById("shipPackQtyFilter").value='';
			document.getElementById("shipPackLengthFilter").value='';
			document.getElementById("shipPackWidthFilter").value='';
			document.getElementById("shipPackHeightFilter").value='';
			document.getElementById("venPalTieFilter").value='';
			document.getElementById("venPalTierFilter").value='';
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
	function setDataSourceForAutocompleteFilter()
	{       	
		for(var i = 0 ;i< 4 ; i++)
		{
			arrayDataFilter[i] = [];
		}
				
		if(SER.itemResultFilter != null && SER.itemResultFilter != "")
		{				
			if(filterItemReturn.length > 0){
				for (var i = 0; i< filterItemReturn.length; i++) 
				{					
					if(!(arrayDataFilter[0]).inArray(filterItemReturn[i].vendor) && filterItemReturn[i].vendor!='')
					{
						arrayDataFilter[0].push(filterItemReturn[i].vendor);
					}	
					if(!(arrayDataFilter[1]).inArray(filterItemReturn[i].sellingUpc) && filterItemReturn[i].sellingUpc!='')
					{
						arrayDataFilter[1].push(filterItemReturn[i].sellingUpc);
					}
					if(!(arrayDataFilter[2]).inArray(filterItemReturn[i].caseUPC) && filterItemReturn[i].caseUPC!='')
					{
						arrayDataFilter[2].push(filterItemReturn[i].caseUPC);
					}
					if(!(arrayDataFilter[3]).inArray(filterItemReturn[i].vpcCode) && filterItemReturn[i].vpcCode!='')
					{
						arrayDataFilter[3].push(filterItemReturn[i].vpcCode);
					}	
				}				
			}							
		}
		else
		{
			for(var i = 0;i < dataSourceTemp.length; i++)
			{
				if(!(arrayDataFilter[0]).inArray(dataSourceTemp[i].vendor) && dataSourceTemp[i].vendor!='')
				{
					arrayDataFilter[0].push(dataSourceTemp[i].vendor);
				}	
				if(!(arrayDataFilter[1]).inArray(dataSourceTemp[i].sellingUpc) && dataSourceTemp[i].sellingUpc!='')
				{
					arrayDataFilter[1].push(dataSourceTemp[i].sellingUpc);
				}
				if(!(arrayDataFilter[2]).inArray(dataSourceTemp[i].caseUPC) && dataSourceTemp[i].caseUPC!='')
				{
					arrayDataFilter[2].push(dataSourceTemp[i].caseUPC);
				}
				if(!(arrayDataFilter[3]).inArray(dataSourceTemp[i].vpcCode) && dataSourceTemp[i].vpcCode!='')
				{
					arrayDataFilter[3].push(dataSourceTemp[i].vpcCode);
				}					
			}
		}
	}	
	
	function gePattern()
	{
		var arrFilterObj = new Array();
		arrFilterObj.push("vendorFilter");
		arrFilterObj.push("sellingUpcFilter");
		arrFilterObj.push("caseUpcFilter");
		arrFilterObj.push("vpcCodeFilter");
		arrFilterObj.push("mterPackQtyFilter");
		arrFilterObj.push("mterPackLengthFilter");
		arrFilterObj.push("mterPackWidthFilter");
		arrFilterObj.push("mterPackHeightFilter");
		arrFilterObj.push("shipPackQtyFilter");
		arrFilterObj.push("shipPackLengthFilter");
		arrFilterObj.push("shipPackWidthFilter");
		arrFilterObj.push("shipPackHeightFilter");
		arrFilterObj.push("venPalTieFilter");
		arrFilterObj.push("venPalTierFilter");
		
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
		return partern;	};
	
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
			//document.getElementById('clearSelFilter').disabled=false;				
			if(isHide)
			{
				target.value="Show";
				//document.getElementById('clearSelFilter').disabled=true;
				document.getElementById('clearSelFilter').style.display='none';
			}
			else
			{
				document.getElementById('clearSelFilter').style.display='';
			}
			for(var i=0;i<selFilterDivArr.length;i++)
			{
				if(isHide)
				{
					selFilterDivArr[i].parentNode.style.display = 'none';
				}
				else
				{
					selFilterDivArr[i].parentNode.style.display = 'block';
				}
			}			
	};
						    	
<%}%>
</script>
<script type="text/javascript">
		function getChangeStatusOnCasePackTab(oldValue, checked)
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
					var idWorkRq = dataSourceTemp[i].idResult.split('-')[0];
					if(id.inArray(idWorkRq)){
						if(checked)
			            {
			            	dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" checked=checked class=yui-dt-checkbox />";
			            	var changeValue = getChangeStatusOnCasePackTab(dataSourceTemp[i].changeStatus, true);
			            	if(changeValue != null)
			            		dataSourceTemp[i].changeStatus = changeValue;
			            }
		       			else
		       			{
		       				dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
		       				var changeValue = getChangeStatusOnCasePackTab(dataSourceTemp[i].changeStatus, false);
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
			        		var changeValue = getChangeStatusOnCasePackTab(dataSourceTemp[i].changeStatus, true);
			            	if(changeValue != null)
			            		dataSourceTemp[i].changeStatus = changeValue;
			        	}
			        	else
			        	{
			        		dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
			        		var changeValue = getChangeStatusOnCasePackTab(dataSourceTemp[i].changeStatus, false);
			            	if(changeValue != null)
			            		dataSourceTemp[i].changeStatus = changeValue;
			        	}
			        }
				 }
			}
		}
		function saveCasePackTab(isNextTab){
			YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: green;'><b> No data change to update </b></span>";
		}
		function resetCasePackTab()
	    {
			if(dataCasePack != null){ 
			    if(changeRequest){
			    	//reset data source temp
	 				dataSourceTemp = [];
			    	casePackResult = makeCasePackTable();
			    	changeRequest = false;
		    		YAHOO.util.Dom.get('saveResult').innerHTML ="";
			    }
			}
	    }
		
		//reset data on datatable
		function resetCasePackTab()
		{
			var myDataSource = casePackResult.oDS;
			var myDataTable = casePackResult.oDT;
		
			YAHOO.util.Dom.get('vendorFilter').value='';
			YAHOO.util.Dom.get('sellingUpcFilter').value='';
			YAHOO.util.Dom.get('caseUpcFilter').value='';
			YAHOO.util.Dom.get('vpcCodeFilter').value='';
			YAHOO.util.Dom.get('mterPackQtyFilter').value='';
			YAHOO.util.Dom.get('mterPackLengthFilter').value='';
			YAHOO.util.Dom.get('mterPackWidthFilter').value='';
			YAHOO.util.Dom.get('mterPackHeightFilter').value='';
			YAHOO.util.Dom.get('shipPackQtyFilter').value='';
			YAHOO.util.Dom.get('shipPackLengthFilter').value='';
			YAHOO.util.Dom.get('shipPackWidthFilter').value='';
			YAHOO.util.Dom.get('shipPackHeightFilter').value='';
			YAHOO.util.Dom.get('venPalTieFilter').value='';
			YAHOO.util.Dom.get('venPalTierFilter').value='';

			var currentPage = myDataTable.get('paginator').getState().page;
			
			if(dataCasePack != null){ 
				//reset data source filter
				filterItemReturn = [];
				
				dataSourceTemp = [];
				filterTimeout = null;
				var pattent = "\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*";			
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
			setFilterValue();
		}
		function html_entity_decode(str) {
			var ta = document.createElement("textarea");
			ta.innerHTML = str.replace(/</g,"&lt;").replace(/>/g,"&gt;");
			return ta.value;
		}
		
</script>
</body>
</html>
