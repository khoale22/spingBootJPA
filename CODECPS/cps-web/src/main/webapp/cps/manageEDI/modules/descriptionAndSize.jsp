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
<html>
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>Description And Size Tab</title>
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
<body onload="initDescription();" id="yahoo-com" class="yui-skin-sam">
<c:url value="/protected/cps/manageEDI/updateValues?${_csrf.parameterName}=${_csrf.token}" var="updateUrl" />
<script type="text/javascript">
var dataDescriptionAndSize = null;

//======================BEGIN SET AUTOCOMPLETE FOR FILTER ==============================//
var arrayDataFilter;	
	getDescTabAutoFilter = function(query)
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
		var oACDS = new YAHOO.widget.DS_JSFunction(getDescTabAutoFilter);
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

	//=============BEGIN INIT ARRAY OBJECT FILTER=================//	
	var arrDescIdObj =new Array();
	function initLstObjFilter()
	{
		if(arrDescIdObj.length == 0){
			arrDescIdObj.push("vendorFilter");
			arrDescIdObj.push("sellingUpcFilter");
			arrDescIdObj.push("descriptionFilter");
			arrDescIdObj.push("cfd1Filter");
			arrDescIdObj.push("cfd2Filter");
			arrDescIdObj.push("sizeFilter");
			arrDescIdObj.push("uomFilter");
			arrDescIdObj.push("sizeTextFilter");
		}
	};
	//=============END INIT ARRAY OBJECT FILTER=================//
	
	function setFilterValue(){
		if(SER.itemResultFilter != null && SER.itemResultFilter != ""){
			var filterValues = document.getElementById('filterValues').value;
			if(filterValues != "")
			{
				var curTab = 2;
				var com = YAHOO.lang;
				var arrValueTab = filterValues.split("___");
								    
				if(arrValueTab[0] != ""){
					document.getElementById('vendorFilter').value = com.trim(arrValueTab[0].split('||')[0]);
					document.getElementById('sellingUpcFilter').value = com.trim(arrValueTab[0].split('||')[1]);
				}
				
				if(arrValueTab.length >curTab){
					var valueFilterOnTab = com.trim(arrValueTab[curTab]);
					if(valueFilterOnTab != ""){
						initLstObjFilter();
						var arrObjFilter = arrDescIdObj;
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
</script>

<div id="DescriptionAndSizeMain">
	<div>
	<table width="100%">
		<tr>
			<td width = "40%">
				<div id="totalRecord" style="padding-left: 5px; color: blue" align="left"></div>
			</td>
			<td width="60%">
				<div id="saveResult" style="color: green" align="left"></div>
			</td>
		</tr>
	</table>
	</div>
	<div>
		<div id="tblDescriptionAndSize"
			style="width: 100%; z-index: 15000;"></div>
		<div id="pag" style="font-family:arial; font-size:10px;"></div>
	</div>
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
						+ ediResult.getChannel() + "-"
						+ ediResult.getPsProdId() + "-"
						+ ediResult.getScnCdSeqNbr()+"-"+ediResult.isActiveProductKit();
				String idRowHidden=CPSHelper.displaySellingUPC(ediResult.getUpcNo())+"__"+ediResult.isActiveProductKit();		
				if (ediResult.getPsItemId() != null) {
					if(i==0 || strData.toString().equals("["))
						strData.append("{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ WorkRq +"'>\",idResult:\"" + id);
					else
						strData.append("\n,{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ WorkRq +"'>\",idResult:\"" + id);
						
					strData.append("\",changeStatus:\"" + ((!ediResult.isNewDataSw() && ediResult.getUpcDataSW() == 'N') || ediResult.isDisable() || (ediResult.getCandidateSw() == 'N' && ediResult.getUpcDataSW() == 'N') ? "-1":"0"));
					strData.append("\",productID:\"" + ediResult.getPsProdId());
					strData.append("\",vendor:\""
									+ ediResult.getPsVendno() +" "+ CPSHelper.convertCharToHTMLForJSON(ediResult.getPsVendName())
									+ "\",sellingUpc:\""
									+ CPSHelper.displaySellingUPC(ediResult.getUpcNo()));
					strData.append("\",description:\""+ CPSHelper.convertCharToHTMLForJSON(ediResult.getDescriptionAndSizeDetailVO().getDescription().toUpperCase()));
					strData.append("\",cfd1:\""+ CPSHelper.convertCharToHTMLForJSON(ediResult.getDescriptionAndSizeDetailVO().getCfd1()));
					strData.append("\",cfd2:\""+ CPSHelper.convertCharToHTMLForJSON(ediResult.getDescriptionAndSizeDetailVO().getCfd2()));
					strData.append("\",size:\""+ ediResult.getDescriptionAndSizeDetailVO().getSize());
					strData.append("\",uom:\""+ ediResult.getDescriptionAndSizeDetailVO().getUomDes());
					strData.append("\",sizetext:\""+ CPSHelper.convertCharToHTMLForJSON(ediResult.getDescriptionAndSizeDetailVO().getSizeText()));
					strData.append("\",upcDataSW:\""+ String.valueOf(ediResult.getUpcDataSW()));					
					strData.append("\",status:\""+ ediResult.getStatus());					
					strData.append("\",isEditable:\""+ (ediResult.isNewDataSw() && ediResult.getCandidateSw() != 'N'? "Y":"N"));
					strData.append("\",isDisable:\""+ ediResult.isDisable());
					strData.append("\",idRowHidden:\""+ idRowHidden+ "\"}");
				}
			}

		}
		strData.append("]");
%>
<script type="text/javascript">
<c:url value="${request.getContextPath()}/hebAssets/images/dropdown.bmp" var="image"></c:url>

	dataDescriptionAndSize = {

			areacodes: <%=strData.toString()%>};  		
									
			var changeRequest = false;
			var dataSourceTemp = [];
			var filterItemReturn = [];
			var descriptionAndSizeResult = makeDescriptionAndSizeTable();
							
		function makeDescriptionAndSizeTable() {


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
		
			
			var sortCfd1 = function(a, b, desc) {
	            return sortCompare(a, b, desc, "cfd1", "sellingUpc", false);           
	        };
		
			var sortCfd2 = function(a, b, desc) {
	            return sortCompare(a, b, desc, "cfd2", "sellingUpc", false);           
	        };
			
			var sortSize = function(a, b, desc) {
	            return sortCompare(a, b, desc, "size", "sellingUpc", true);           
	        };
		
			var sortUom = function(a, b, desc) {
	            return sortCompare(a, b, desc, "uom", "sellingUpc", false);           
	        };
		
			var sortSizetext = function(a, b, desc) {
	            return sortCompare(a, b, desc, "sizetext", "sellingUpc", false);           
	        };
			
			
			// Custom sort handler to sort by state and then by areacode
			// where a and b are Record instances to compare
			var formatDescription = function(elCell, oRecord, oColumn, sData) {
				var valueDes = oRecord.getData("description");
				valueDes = valueDes.replace(/'/g, "&#039;");
				if(oRecord.getData("changeStatus") !== "-1" && oRecord.getData("changeStatus") !== "4" && oRecord.getData("isEditable") !== 'N')
					elCell.innerHTML = "<input type='text' id='description_" + oRecord.getData("idResult") +"' name= 'description_" + oRecord.getData("idResult").split('-')[4] + "' value='" + valueDes +"' maxlength='30' size='25' onblur='valdKeyPressSymbSpec(this);' onchange='saveValueEditableFieldToDataTable(this)'/>";
				else
					elCell.innerHTML = "<input type='text' id='description_" + oRecord.getData("idResult") +"' value='" + valueDes +"' size='25' class='disabled-text' readonly='readonly' />";
			};
							
			var formatCfd1 = function(elCell, oRecord, oColumn, sData) {
			    var valueCfd1 = oRecord.getData("cfd1");
				valueCfd1 = valueCfd1.replace(/'/g, "&#039;");
				if(oRecord.getData("changeStatus") !== "-1" && oRecord.getData("changeStatus") !== "4" && oRecord.getData("isEditable") !== 'N')	        	
					elCell.innerHTML = "<input type='text' id='cfd1_" + oRecord.getData("idResult") +"' name= 'cfd1_" + oRecord.getData("idResult").split('-')[4] + "' value='" + valueCfd1 +"' maxlength='30' size='25'  onblur='camelCase1DataGrid(this, \"" + valueCfd1 + "\");'  />";
				else
					elCell.innerHTML = "<input type='text' id='cfd1_" + oRecord.getData("idResult") +"' value='" + valueCfd1 +"' size='25' class='disabled-text' readonly='readonly' />";
                
			};
			
			var formatCfd2 = function(elCell, oRecord, oColumn, sData) {
				var valueCfd2 = oRecord.getData("cfd2");
				valueCfd2 = valueCfd2.replace(/'/g, "&#039;");
				if(oRecord.getData("changeStatus") !== "-1" && oRecord.getData("changeStatus") !== "4" && oRecord.getData("isEditable") !== 'N')	        	
					elCell.innerHTML = "<input type='text' id='cfd2_" + oRecord.getData("idResult") +"' name= 'cfd2_" + oRecord.getData("idResult").split('-')[4] + "' value='" + valueCfd2 +"' maxlength='30' size='25' onblur='camelCase2DataGrid(this, \"" + valueCfd2 + "\");'  />";
				else
					elCell.innerHTML = "<input type='text' id='cfd2_" + oRecord.getData("idResult") +"' value='" + valueCfd2 +"' size='25' class='disabled-text' readonly='readonly' />";
			};
						
			var formatSizetext = function(elCell, oRecord, oColumn, sData) {
				var valueSizetext = oRecord.getData("sizetext");
				valueSizetext = valueSizetext.replace(/'/g, "&#039;");
				if(${!ManageEDICandidate.isVendor}) {
					if(oRecord.getData("upcDataSW") !== 'N' && oRecord.getData("changeStatus") !== "-1" && oRecord.getData("changeStatus") !== "4")		        	
						elCell.innerHTML = "<input type='text' id='sizetext_" + oRecord.getData("idResult") +"' name= 'sizetext_" + oRecord.getData("idResult").split('-')[4] +""+ oRecord.getData("idResult").split('-')[5] + "' value='" + valueSizetext +"' maxlength='6' size='7' onchange='saveValueEditableFieldToDataTable(this)' />";
					else
						elCell.innerHTML = "<input type='text' id='sizetext_" + oRecord.getData("idResult") +"' value='" + valueSizetext +"' size='7' class='disabled-text' readonly='readonly' />";
				}
				else{
					if((oRecord.getData("upcDataSW") !== 'N') && oRecord.getData("changeStatus") !== "-1" && oRecord.getData("changeStatus") !== "4" && (oRecord.getData("status") !== "107" && oRecord.getData("status") !== "109"))		        	
						elCell.innerHTML = "<input type='text' id='sizetext_" + oRecord.getData("idResult") +"' name= 'sizetext_" + oRecord.getData("idResult").split('-')[4] +""+ oRecord.getData("idResult").split('-')[5] + "' value='" + valueSizetext +"' maxlength='6' size='7' onchange='saveValueEditableFieldToDataTable(this)' />";
					else
						elCell.innerHTML = "<input type='text' id='sizetext_" + oRecord.getData("idResult") +"' value='" + valueSizetext +"' size='7' class='disabled-text' readonly='readonly' />";
				}
			};
						
		  	// Format color for row is edited  
			var myRowFormatter = function(elTr, oRecord) {   
				if (oRecord.getData('changeStatus') == "2" || oRecord.getData('changeStatus') == "3") {   
					YAHOO.util.Dom.addClass(elTr, 'mark');   
				}   
				return true;   
			}; 
						                
						            
			var myColumnDefs = [				
					{key:"changeStatus",    label:""},
					{key:"status",    label:""},
					{key:"checkBoxs",    label:"All",minWidth: 30,
						children: [{key:"checkBox", label:"<input type='checkbox' id='SelectAll'/>"}]},  	
					{key:"idResult",    label:"Id"},
					{key:"vendors",    label:"Vendor<br/>", width: 150, minWidth: 150, sortable:true, sortOptions:{sortFunction:sortVendor},
						children: [{key:"vendor", label:"<div id='vendorDiv' class ='myAutoComplete'><input type='text' id='vendorFilter' name='divFilterSel' size='25' maxlength='50' style='TEXT-TRANSFORM\: uppercase; position: relative;'><img src='${image}' alt='' width='20' id='vendorFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerVendorFilter'></div></div>",sortable:false, resizeable:false}]},  
					{key:"sellingUpcs",    label:"Selling UPC<br/>", width: 105, minWidth: 105, sortable:true, sortOptions:{sortFunction:sortSellingUpc},
						children: [{key:"sellingUpc", label:"<div id='sellingUpcDiv' class ='myAutoComplete'><input type='text' id='sellingUpcFilter' name='divFilterSel' size='10' maxlength='15' style='TEXT-TRANSFORM\: uppercase; position: relative;'><img src='${image}' alt='' width='20' id='sellingUpcFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerSellingUpcFilter'></div></div>",sortable:false, resizeable:false}]},
					{key:"descriptions",    label:"Description<br/>", width: 160, minWidth: 160, sortable:true,formatter:formatDescription, sortOptions:{sortFunction:sortDescription},
						children: [{key:"description", label:"<div id='descriptionDiv'><input type='text' id='descriptionFilter' name='divFilterSel' size='25' maxlength='30'></div>",sortable:false, resizeable:false}]},
					{key:"cfd1s",    label:"CFD1<br/>", width: 160, minWidth: 160,sortable:true,formatter:formatCfd1, sortOptions:{sortFunction:sortCfd1},
						children: [{key:"cfd1", label:"<div id='cfd1Div'><input type='text' id='cfd1Filter' name='divFilterSel' size='25' maxlength='30'></div>",sortable:false, resizeable:false}]},
					{key:"cfd2s",    label:"CFD2<br/>", width: 160, minWidth: 160,sortable:true,formatter:formatCfd2, sortOptions:{sortFunction:sortCfd2},
						children: [{key:"cfd2", label:"<div id='cfd2Div'><input type='text' id='cfd2Filter' name='divFilterSel' size='25' maxlength='30'></div>",sortable:false, resizeable:false}]},
					{key:"sizes",    label:"Size<br/>", width: 60, minWidth: 60,sortable:true, sortOptions:{sortFunction:sortSize},
						children: [{key:"size", label:"<div id='sizeDiv'><input type='text' id='sizeFilter' name='divFilterSel' size='7' maxlength='10'></div>",sortable:false, resizeable:false}]},
					{key:"uoms",    label:"UOM<br/>", width: 60, minWidth: 60,sortable:true, sortOptions:{sortFunction:sortUom},
						children: [{key:"uom", label:"<div id='uomDiv'><input type='text' id='uomFilter' name='divFilterSel' size='7' maxlength='20'></div>",sortable:false, resizeable:false}]},
					{key:"sizetexts",    label:"Size Text<br/>",width: 135, minWidth: 135,sortable:true,formatter:formatSizetext, sortOptions:{sortFunction:sortSizetext},
						children: [{key:"sizetext", label:"<table class='tbl-filter'><tr><td width='50%' class='td-filter'><div id='sizetextDiv'><input type='text' id='sizeTextFilter' size='7' maxlength='6' name='divFilterSel'\/></div></td><td class='td-filter'><input type='button' id='filterStatus' value='Hide'\/><input type='button' id='clearSelFilter' value='Clear'\/></td></tr></table>",sortable:false, resizeable:false}]},
					{key:"isEditable",    label:""},
					{key:"upcDataSW",    label:""},
					{key:"idRowHidden"}
					];
						                          
						 
			var myDataSource = new YAHOO.util.DataSource(dataDescriptionAndSize.areacodes);
			myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
			myDataSource.responseSchema = {
					fields: ["changeStatus","productID","checkBox","idResult","vendor","sellingUpc","description","cfd1","cfd2","size","uom","sizetext","upcDataSW","status","isEditable","idRowHidden"]
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
							temp=SER.convertFromIrToRegularPattern(convertSpecialChars(filterItemReturn[i].vendor.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(filterItemReturn[i].sellingUpc.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(filterItemReturn[i].description.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(filterItemReturn[i].cfd1.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(filterItemReturn[i].cfd2.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(filterItemReturn[i].size.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(filterItemReturn[i].uom.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(filterItemReturn[i].sizetext.toUpperCase()));
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
							temp=SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].vendor.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].sellingUpc.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].description.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].cfd1.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].cfd2.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(dataSourceTemp[i].size.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].uom.toUpperCase()))+"__"+SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].sizetext.toUpperCase()));										
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
					containers  : 'pag'
					
				}),
					draggableColumns:false,
					height:"220px",
					formatRow: myRowFormatter
			}
						
			var myDataTable = new YAHOO.widget.ScrollingDataTable("tblDescriptionAndSize", myColumnDefs, myDataSource, myConfigs);

			//get data of each field to array
			arrayDataFilter = [];
			setDataSourceForAutocompleteFilter();
			//set autocomplete for filter
			var arrFilter = new Array();			
			arrFilter.push("vendorFilter");
			arrFilter.push("sellingUpcFilter");			
			var cnt=0;
			for(var i=0;i < arrFilter.length;i++)
			{										
				setAutoCompleteForFilter("myContainer"+arrFilter[i].capitaliseFirstLetter(arrFilter[i]),arrFilter[i],cnt++);
				document.getElementById(arrFilter[i]).parentNode.parentNode.parentNode.style.overflow = 'visible';				
			}
			//hiden column
			myDataTable.hideColumn(myDataTable.getColumn("idResult"));
			myDataTable.hideColumn(myDataTable.getColumn("changeStatus"));
			myDataTable.hideColumn(myDataTable.getColumn("status"));
			myDataTable.hideColumn(myDataTable.getColumn("upcDataSW"));
			myDataTable.hideColumn(myDataTable.getColumn("isEditable"));
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
				var arr
	            //checked all items have the same Ps_work_id		
				 for (var i= 0; i< this.getRecordSet().getLength();i++){
					var oRec = this.getRecordSet().getRecord(i);
			        var idWorkRq = oRec.getData("idResult").split('-')[0];

			        if(idWorkRq == idWorkRqOfCheckBox){
			        	if(elCheckbox.checked){
							oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") + " name=ckb_"+ oRec.getData("idResult").split('-')[0] +" checked=checked class=yui-dt-checkbox />");
							oRec.setData("changeStatus", getChangeStatusOnDescriptionAndSizeTab(oRec.getData("changeStatus"), true));		        	
			        	}
			        	else
			        	{
			        		oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[0] +" class=yui-dt-checkbox />");
							oRec.setData("changeStatus", getChangeStatusOnDescriptionAndSizeTab(oRec.getData("changeStatus"), false));

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
		    	            	oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[0] +" checked=checked class=yui-dt-checkbox />");
		    	            	var changeValue = getChangeStatusOnDescriptionAndSizeTab(oRec.getData("changeStatus"), true);
		    	            	if(changeValue != null)
		    	            		oRec.setData("changeStatus", changeValue);
								
							}
							else
							{
		           				oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[0] +" class=yui-dt-checkbox />");
		           				var changeValue = getChangeStatusOnDescriptionAndSizeTab(oRec.getData("changeStatus"), false);
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
	            SER.currentPage = cur.page;
	        });

			//set page is selected	
	        myDataTable.get('paginator').setPage(parseInt(SER.currentPage));
			
			YAHOO.util.Event.on('clearSelFilter','click',function (e) {	
				
				document.getElementById("vendorFilter").value='';
				document.getElementById("sellingUpcFilter").value='';
				document.getElementById("descriptionFilter").value='';
				document.getElementById("cfd1Filter").value='';
				document.getElementById("cfd2Filter").value='';
				document.getElementById("sizeFilter").value='';
				document.getElementById("uomFilter").value='';
				document.getElementById("sizeTextFilter").value='';
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
				
			//filtering
			var evtFilter= 'change';
			YAHOO.util.Event.on('vendorFilter',evtFilter,function (e) {			
				doBeforeFilter(e);
			});
			YAHOO.util.Event.on('sellingUpcFilter',evtFilter,function (e) {			
				doBeforeFilter(e);
			});			
			YAHOO.util.Event.on('descriptionFilter',evtFilter,function (e) {			
				doBeforeFilter(e);
			});			
			YAHOO.util.Event.on('cfd1Filter',evtFilter,function (e) {			
				doBeforeFilter(e);
			});	
			YAHOO.util.Event.on('cfd2Filter',evtFilter,function (e) {			
				doBeforeFilter(e);
			});	
			YAHOO.util.Event.on('sizeFilter',evtFilter,function (e) {			
				doBeforeFilter(e);
			});	
			YAHOO.util.Event.on('uomFilter',evtFilter,function (e) {			
				doBeforeFilter(e);
			});	
			YAHOO.util.Event.on('sizeTextFilter',evtFilter,function (e) {			
				doBeforeFilter(e);
			});
			
			// check for symbol that not support
			function doBeforeFilter(e)
			{		
				clearTimeout(filterTimeout);
				setTimeout(updateFilter,600);
				SER.hasFilter = true;
			};
			
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

	function initDescription(){
		initLstObjFilter();
		YAHOO.util.Event.addListener(YAHOO.util.Dom.get("massFillBtn"), "click", massfillDescriptionAndSize);		
	}
	
	function setDataSourceForAutocompleteFilter()
    {       	
		for(var i = 0 ;i< 2 ; i++)
		{
			arrayDataFilter[i] = [];
		}
				
		if(SER.itemResultFilter != null && SER.itemResultFilter != "")
		{				
			if(filterItemReturn.length > 0){
				for(var i = 0;i < filterItemReturn.length; i++)
				{
					if(!(arrayDataFilter[0]).inArray(filterItemReturn[i].vendor) && filterItemReturn[i].vendor!='')
					{
						arrayDataFilter[0].push(filterItemReturn[i].vendor);
					}	
					
					if(!(arrayDataFilter[1]).inArray(filterItemReturn[i].sellingUpc) && filterItemReturn[i].sellingUpc!='')
					{
						arrayDataFilter[1].push(filterItemReturn[i].sellingUpc);
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
			}
		}
    }
	
	function gePattern()
	{
		var comp = YAHOO.lang;

		var lstObj = new Array();
		var lstObjVl = new Array();

		for(var i = 0 ;i< arrDescIdObj.length;i++)
		{
			lstObj.push(document.getElementById(arrDescIdObj[i]));
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
	
	
	function getChangeStatusOnDescriptionAndSizeTab(oldValue, checked)
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
						var changeValue = getChangeStatusOnDescriptionAndSizeTab(dataSourceTemp[i].changeStatus, true);
						if(changeValue != null)
							dataSourceTemp[i].changeStatus = changeValue;
					}
					else
					{
						dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
						var changeValue = getChangeStatusOnDescriptionAndSizeTab(dataSourceTemp[i].changeStatus, false);
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
		        		var changeValue = getChangeStatusOnDescriptionAndSizeTab(dataSourceTemp[i].changeStatus, true);
		            	if(changeValue != null)
		            		dataSourceTemp[i].changeStatus = changeValue;
		        	}
		        	else
		        	{
		        		dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
		        		var changeValue = getChangeStatusOnDescriptionAndSizeTab(dataSourceTemp[i].changeStatus, false);
		            	if(changeValue != null)
		            		dataSourceTemp[i].changeStatus = changeValue;
		        	}
		        }
			 }
		}
	}

	function saveDataSourceTempWhenChangeEditFieldable(id, key, value){
		 for (var i= 0; i< dataSourceTemp.length; i++){
	            var idProd = dataSourceTemp[i].idResult.split("-")[4];
	            var idSellingUPC = dataSourceTemp[i].idResult.split("-")[0] + dataSourceTemp[i].idResult.split("-")[5];
	            if(key =="description" || key == "cfd1" || key == "cfd2"){
		    		if(idProd == id.split("-")[4]){			
		    			if(key == "description")
		    				dataSourceTemp[i].description = value;
		    			if(key == "cfd1")
		    				dataSourceTemp[i].cfd1 = value;
		    			if(key == "cfd2")
		    				dataSourceTemp[i].cfd2 = value;
	    				
		    			if(dataSourceTemp[i].changeStatus == "1")
		    				dataSourceTemp[i].changeStatus = "3";
		    			else
			    			if(dataSourceTemp[i].changeStatus != "3")
			    				dataSourceTemp[i].changeStatus = "2";					
					} 
	            }
	            else
	            {
	            	if(idSellingUPC == id.split("-")[0] + id.split("-")[5]){			
		    			if(key == "sizetext")
		    				dataSourceTemp[i].sizetext = value;
	    					    			
		    			if(dataSourceTemp[i].changeStatus == "1")
		    				dataSourceTemp[i].changeStatus = "3";
		    			else
			    			if(dataSourceTemp[i].changeStatus != "3")
			    				dataSourceTemp[i].changeStatus = "2";					
					} 
	            }   			          
	        }
	}
	
	function massfillDescriptionAndSize(evt){
	
		if(dataDescriptionAndSize != null){
			var elDes = YAHOO.util.Dom.get('txtMF_DES');
			var elCFD1 = YAHOO.util.Dom.get('txtMF_CFD1');
			var elCFD2 = YAHOO.util.Dom.get('txtMF_CFD2');
			var elSzt = YAHOO.util.Dom.get('txtMF_SZT');
			var myDataTable = descriptionAndSizeResult.oDT;
			
			var count = 0;
			var cntUnEdit = 0;
			var arrEditOnProduct = new Array();
		    var arrEditOnScanCodes = new Array();
			
			 for(var i=0; i<myDataTable.getRecordSet().getLength(); i++) {
	    		 var oRec = myDataTable.getRecordSet().getRecord(i);
	    		 if(oRec.getData("changeStatus") == "1" || oRec.getData("changeStatus") == "3")
	    		 {	 			 
					if(oRec.getData("isEditable") != "N"){
						 if(elDes.value !="")
							oRec.setData("description", makeUppercase(elDes.value));
						 if(elCFD1.value !="")
							oRec.setData("cfd1", toUpper(elCFD1.value));
						 if(elCFD2.value !="")	
							oRec.setData("cfd2", toUpper(elCFD2.value));					
						 
						 if(elDes.value !="" || elCFD1.value !="" || elCFD2.value !=""){
							if(!checkExistProd(arrEditOnProduct, oRec.getData("idResult").split('-')[4]))
								arrEditOnProduct.push((oRec.getData("idResult").split('-')[4]));

							 oRec.setData("changeStatus", "3");
							//change color
							YAHOO.util.Dom.addClass(myDataTable.getTrEl(oRec), 'mark');	
						 }
					}	
		    		 if(oRec.getData("upcDataSW") != 'N'){
						 if(elSzt.value !=""){	
						 	oRec.setData("sizetext", elSzt.value);
						 	if(!checkExistProd(arrEditOnScanCodes, (oRec.getData("idResult").split("-")[4] + oRec.getData("idResult").split("-")[5])))
						 		arrEditOnScanCodes.push((oRec.getData("idResult").split("-")[4] + oRec.getData("idResult").split("-")[5]));
						 		
							oRec.setData("changeStatus", "3");
							//change color
							YAHOO.util.Dom.addClass(myDataTable.getTrEl(oRec), 'mark');	
						 }
		    		 }
		    						 
					count++;				 
				 }
	    		 if(oRec.getData("changeStatus") == "4")
	    		 {	        		 						
					 cntUnEdit++;				 
				 }
			}					    		
	    	if(count>0){
	    		//update datatable temp (used for filter)
	    		for(var j=0; j< dataSourceTemp.length; j++) {
	    			if(dataSourceTemp[j].changeStatus == "1" || dataSourceTemp[j].changeStatus == "3")
		    		 {
						if(dataSourceTemp[j].isEditable != 'N'){
							 if(elDes.value !="")
								 dataSourceTemp[j].description = elDes.value;
							 if(elCFD1.value !="")
								 dataSourceTemp[j].cfd1 = elCFD1.value;
							 if(elCFD2.value !="")	
								 dataSourceTemp[j].cfd2 = elCFD2.value;

							 if(elDes.value !="" || elCFD1.value !="" || elCFD2.value !="")
							 	dataSourceTemp[j].changeStatus = "3";
						}								 
			    		if(dataSourceTemp[j].upcDataSW != 'N'){
			        		 if(elSzt.value !=""){	
			        			 dataSourceTemp[j].sizetext = elSzt.value;
								 dataSourceTemp[j].changeStatus = "3";
							}
			    		}
		        		 			 
					 }
		    	}
	    		changeRequest =true;
				//myDataTable.render();
	    		if(arrEditOnProduct.length >0){
					if(elDes.value !=""){
						for(i=0;i<arrEditOnProduct.length;i++){
							var fieldChangedDesc = document.getElementsByName("description_"+arrEditOnProduct[i]);
							if(fieldChangedDesc != null){
								for(j=0;j<fieldChangedDesc.length;j++)
									fieldChangedDesc[j].value = makeUppercase(elDes.value);
							}
						}
					}
					if(elCFD1.value !=""){
						for(i=0;i<arrEditOnProduct.length;i++){
							var fieldChangedCfd1 = document.getElementsByName("cfd1_"+arrEditOnProduct[i]);
							if(fieldChangedCfd1 != null){
								for(j=0;j<fieldChangedCfd1.length;j++)
									fieldChangedCfd1[j].value = toUpper(elCFD1.value);
							}
						}
					}
					if(elCFD2.value !=""){
						for(i=0;i<arrEditOnProduct.length;i++){
							var fieldChangedCfd2 = document.getElementsByName("cfd2_"+arrEditOnProduct[i]);
							if(fieldChangedCfd2 != null){
								for(j=0;j<fieldChangedCfd2.length;j++)
									fieldChangedCfd2[j].value = toUpper(elCFD2.value);
							}
						}
					}
				}
	    		if(arrEditOnScanCodes.length >0){
	    			if(elSzt.value !=""){
	    				for(i=0;i<arrEditOnScanCodes.length;i++){
							var fieldChangedSzt = document.getElementsByName("sizetext_"+arrEditOnScanCodes[i]);
							if(fieldChangedSzt != null){
								for(j=0;j<fieldChangedSzt.length;j++)
									fieldChangedSzt[j].value = elSzt.value;
							}
						}
	    			}
	    		}
	    	}
	    	else if(count==0 && cntUnEdit==0){	    	
				alert('Please select at least one UPC for mass fill');
				return false;
	    	}
	    	else
	    		return false;				
		}			
	}					
						
	function saveValueEditableFieldToDataTable(element)
	{	
		var myDataTable = descriptionAndSizeResult.oDT;
		var key = element.id.split('_')[0];
		var id = element.id.split('_')[1];
							
		for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){
            var oRec = myDataTable.getRecordSet().getRecord(i);
            var idProd = oRec.getData("idResult").split("-")[4];
            var idSellingUPC = oRec.getData("idResult").split("-")[4] + oRec.getData("idResult").split("-")[5];
			
			if(key =="description" || key == "cfd1" || key == "cfd2"){
				if(idProd == id.split("-")[4]){
					if(key =="description"){
						oRec.setData(key, makeUppercase(element.value));
						if(oRec.getData("changeStatus") == "1")
							oRec.setData("changeStatus", "3");
						else
							if(oRec.getData("changeStatus") != "3")
								oRec.setData("changeStatus", "2");					
					}
					if(key == "cfd1" || key == "cfd2"){
						oRec.setData(key, element.value);
						if(oRec.getData("changeStatus") == "1")
							oRec.setData("changeStatus", "3");
						else
							if(oRec.getData("changeStatus") != "3")
								oRec.setData("changeStatus", "2");					
					}
					//change color
					YAHOO.util.Dom.addClass(myDataTable.getTrEl(oRec), 'mark'); 
				}
			}
            else
            {
            	if(idSellingUPC == id.split("-")[4] + id.split("-")[5]){			
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
    	
		var fieldChangeds = document.getElementsByName(element.name);

		if(fieldChangeds != null && fieldChangeds.length > 1){
			for(i=0;i<fieldChangeds.length;i++){
				if(key =="description" || key == "cfd1" || key == "cfd2"){
					if(key =="description")
						fieldChangeds[i].value = makeUppercase(element.value);
					else
						fieldChangeds[i].value = toUpper(element.value);
				}
				else {
					fieldChangeds[i].value = element.value;
				}
			}
		}
		else
		{
			if(key =="description" || key == "cfd1" || key == "cfd2"){
				if(key =="description")
					element.value = makeUppercase(element.value);
				else
					element.value = element.value;
			}
			else
				element.value = element.value;
		}
    	
		//update datatable temp (used for filter)
        saveDataSourceTempWhenChangeEditFieldable(id, key, element.value);
        
		changeRequest =true;
	     //myDataTable.render();
	}
	var isNextTabDescriptionAndSize;
	function saveDescriptionAndSizeTab(isNextTab){
		if(dataDescriptionAndSize != null){ 			
			var prodIds = "";
			var isExists;
			var countChanged =0;
			var arrIdResult = new Array();
			if(dataSourceTemp != null && dataSourceTemp.length >0)
			{   	
				 for(var i=0; i<dataSourceTemp.length; i++) {
					if(dataSourceTemp[i].changeStatus != null && (dataSourceTemp[i].changeStatus == "2" || dataSourceTemp[i].changeStatus == "3"))
					{
						countChanged++;		
						
									
						var value = dataSourceTemp[i].idResult;
						isExists = false;						
						for(var j=0; j < arrIdResult.length; j++){
							if(arrIdResult[j] == value){
								isExists = true;
								break;
							}
						}
						if(!isExists){							
							prodIds = prodIds + dataSourceTemp[i].productID +",";
						}
						
					}	    		
		    	}
				 if(prodIds !=""){
	 	    			prodIds = prodIds.substr(0,prodIds.lastIndexOf(','));
						showProgress();	
						isNextTabDescriptionAndSize = isNextTab;			 
						ManageEDIDWR.checkMultilPluReuseEDI(prodIds,getDWRCallbackMethod(updateDataForDescriptionAndSizeTabBack));		
				} 	 
		    	else
		 	    {
			 	      if(countChanged == 0)
			 	    	 YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: green;'><b> No data change to update </b></span>";
		 	    }
			}
		}
	}
	function updateDataForDescriptionAndSizeTabBack(data){
		if(data!='' && data == true){		
			alert('PLU(s) tied to a vendor candidate/working candidate/ an existing product. \nThis candidate cannot be modified.');	
			hideProgress();	
		} else {
			var arrIdResult = new Array();
			var arrDescription = new Array();
			var arrCfd1 = new Array();
			var arrCfd2 = new Array();
			var arrSizeText = new Array();			
			var isExists;
			var countChanged =0;
			
			if(dataSourceTemp != null && dataSourceTemp.length >0)
			{   	
				 for(var i=0; i<dataSourceTemp.length; i++) {
					if(dataSourceTemp[i].changeStatus != null && (dataSourceTemp[i].changeStatus == "2" || dataSourceTemp[i].changeStatus == "3"))
					{
						countChanged++;
						
						if(dataSourceTemp[i].description == '' && dataSourceTemp[i].isEditable != 'N'){
							alert('Please fill Product Description');							
							if(YAHOO.util.Dom.get('description_' + dataSourceTemp[i].idResult) != null)
								YAHOO.util.Dom.get('description_' + dataSourceTemp[i].idResult).focus();
							hideProgress();	
							return;
						}
						if(dataSourceTemp[i].cfd1 == '' && dataSourceTemp[i].isEditable != 'N'){
							alert('Please fill Customer Friendly Description 1');							
							if(YAHOO.util.Dom.get('cfd1_' + dataSourceTemp[i].idResult) != null)
								YAHOO.util.Dom.get('cfd1_' + dataSourceTemp[i].idResult).focus();
							hideProgress();	
							return;
						}
						if(dataSourceTemp[i].sizetext == '' && dataSourceTemp[i].upcDataSW != 'N'){
							alert('Please fill Size Text');							
							if(YAHOO.util.Dom.get('sizetext_' + dataSourceTemp[i].idResult) != null)
								YAHOO.util.Dom.get('sizetext_' + dataSourceTemp[i].idResult).focus();
							hideProgress();	
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
							arrDescription.push(makeUppercase(dataSourceTemp[i].description));
							arrCfd1.push(toUpper(dataSourceTemp[i].cfd1));
							arrCfd2.push(toUpper(dataSourceTemp[i].cfd2));
							arrSizeText.push(dataSourceTemp[i].sizetext);						
						}
						
					}	    		
		    	}
		    	if(arrIdResult.length >0)
		 	 	{				
					ManageEDIDWR.updateDataForDescriptionAndSizeTab(arrIdResult,arrDescription,arrCfd1,arrCfd2, arrSizeText,SER.currentPage,
			    	    {
			    			callback:function(data) {
			    				if(!isNextTabDescriptionAndSize){
	 	    		  				//updateUrl is called from ediFunction.jsp
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
			 	      if(countChanged == 0)
			 	    	 YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: green;'><b> No data change to update </b></span>";
		 	    }
			}		
		} 
	}
	//reset data on datatable
	function resetDescriptionAndSizeTab()
    {
		var myDataSource = descriptionAndSizeResult.oDS;
		var myDataTable = descriptionAndSizeResult.oDT;
		//YAHOO.util.Dom.get('txtMF_DES').value = "";
		//YAHOO.util.Dom.get('txtMF_CFD1').value = "";
		//YAHOO.util.Dom.get('txtMF_CFD2').value ="";
		//YAHOO.util.Dom.get('txtMF_SZT').value ="";
		
		YAHOO.util.Dom.get('vendorFilter').value='';
		YAHOO.util.Dom.get('sellingUpcFilter').value='';
		YAHOO.util.Dom.get('descriptionFilter').value='';
		YAHOO.util.Dom.get('cfd1Filter').value='';
		YAHOO.util.Dom.get('cfd2Filter').value='';
		YAHOO.util.Dom.get('sizeFilter').value='';
		YAHOO.util.Dom.get('uomFilter').value='';
		YAHOO.util.Dom.get('sizeTextFilter').value='';
		
		if(dataDescriptionAndSize != null){ 
			//reset data source filter
			filterItemReturn = [];
					    
			dataSourceTemp = [];
			filterTimeout = null;
			var pattent = "\.*__\.*__\.*__\.*__\.*__\.*__\.*";			
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
	
	function parseData(data){
		var result = "";
		for(var item in data){
			if("appData" == item){
				result = data[item];
				break;
			}
		}
		return result;
	}
	
	// uppercase for firsr char for field cfd1 cfd2
	function toUpper(obj) {
		AddCandidateTemp.getSpellCheckDes(obj,
	    	    {
	    	    	async: false, 
	    			callback:function(data) {
	    				obj = parseData(data);
	    				},
	    				errorHandler:function(errorString, exception) {
	    					//hideProgress();
	    				},
	   					timeout:180000
	    		});	
		return obj;
	}
	// uppercase for field Description
	function makeUppercase(obj) {
		obj = obj.toUpperCase();
		return obj;
	}
	function checkExistProd(listProd, prod)
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
	function html_entity_decode(str) {
		var ta = document.createElement("textarea");
		ta.innerHTML = str.replace(/</g,"&lt;").replace(/>/g,"&gt;");
		return ta.value;
	}
	
	//Apply CFD New Rule for Manage Candidate Beta
	function isValid(str){
		return !/[~`!^*=\[\]\';,{}\":<>]/g.test(str);
	}
	
	function spaceTrim(x) {
		return x.replace(/^\s+|\s+$/gm,'');
	}
	var originalCfd1 = "";
	var originalCfd2 = "";
	function camelCase1(evt){
		var cfd1 = YAHOO.util.Dom.get('txtMF_CFD1').value;
		if(null != cfd1 && spaceTrim(cfd1) !=""){
			if(isValid(cfd1)){
				if(cfd1 != originalCfd1){
					showProgress();
					AddCandidateTemp.getSpellCheckDes(cfd1,getDWRCallbackMethod(camelCaseCallback1));
				}
			}else {
				alert("Customer Friendly Description 1 is not allow special characters");
				YAHOO.util.Dom.get("txtMF_CFD1").value = "";
			}
			
		}
	}
	function camelCaseCallback1(data){
		originalCfd1 = data;
		YAHOO.util.Dom.get("txtMF_CFD1").value = data;
		hideTheProgress();
		YAHOO.util.Dom.get("txtMF_CFD2").focus();
	}
	function camelCaseCallback2(data){
		originalCfd2 = data;
		YAHOO.util.Dom.get("txtMF_CFD2").value = data;
		hideTheProgress();
		YAHOO.util.Dom.get("style").focus();
	}
	function camelCase2(evt){
		var cfd2 = YAHOO.util.Dom.get("txtMF_CFD2").value; 
		if(null != cfd2 && spaceTrim(cfd2) !=""){
			if(isValid(cfd2)){
				if(cfd2 != originalCfd2){
					showProgress();
					AddCandidateTemp.getSpellCheckDes(cfd2,getDWRCallbackMethod(camelCaseCallback2));
				}
			}else {
				alert("Customer Friendly Description 2 is not allow special characters");
				YAHOO.util.Dom.get("txtMF_CFD2").value = "";
			}
		}
	}
	
	var setKey1 = "";
	var setKey2 = "";
	var setElement1 = null;
	var setElement2 = null;
	function camelCase1DataGrid(element, oldValue1){
		var key = element.id;
		setKey1 = key;
		setElement1 = element;
		var cfd1 = YAHOO.util.Dom.get(key).value;
		if(null != cfd1 && spaceTrim(cfd1) !=""){
			if(isValid(cfd1)){
				if(cfd1 != oldValue1){
					showProgress();
					AddCandidateTemp.getSpellCheckDes(cfd1,getDWRCallbackMethod(camelCaseDataGridCallback1));
				}
			}else {
				alert("Customer Friendly Description 1 is not allow special characters");
				YAHOO.util.Dom.get(key).value = "";
			}
			
		}else {
			if(oldValue1 != cfd1){
				saveValueEditableFieldToDataTable(setElement2);
			}
		}
	}
	function camelCase2DataGrid(element, oldValue2){
		var key = element.id;
		setKey2 = key;
		setElement2 = element;
		var cfd2= YAHOO.util.Dom.get(key).value;
		if(null != cfd2 && spaceTrim(cfd2) !=""){
			if(isValid(cfd2)){
				if(cfd2 != oldValue2){
					showProgress();
					AddCandidateTemp.getSpellCheckDes(cfd2,getDWRCallbackMethod(camelCaseDataGridCallback2));
				}
			}else {
				alert("Customer Friendly Description 2 is not allow special characters");
				YAHOO.util.Dom.get(key).value = "";
			}
		}else {
			if(oldValue2 != cfd2){
				saveValueEditableFieldToDataTable(setElement2);
			}
		}
	}
	
	function camelCaseDataGridCallback1(data){
		YAHOO.util.Dom.get(setKey1).value = data;
		saveValueEditableFieldToDataTable(setElement1);
		hideTheProgress();
	}
	function camelCaseDataGridCallback2(data){
		YAHOO.util.Dom.get(setKey2).value = data;
		saveValueEditableFieldToDataTable(setElement2);
		hideTheProgress();
	} 
	
</script>
<%}%> 
</body>
</html>
