<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%> 

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
    
<%@ page import="java.util.*" %>
<%@ page import="com.heb.operations.cps.vo.EDISearchResultVO" %>
<%@ page import="com.heb.operations.cps.model.ManageEDICandidate" %>
<%@ page import="com.heb.operations.cps.util.CPSHelper"%>
<%@ page import="com.heb.operations.cps.util.BusinessConstants"%>


<%@page import="com.heb.operations.business.framework.vo.BaseJSFVO"%>
<%@page import="com.heb.operations.cps.util.BusinessUtil"%><style type="text/css"> 
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
	width:99.9%;				
	position:relative;	
	
}
.yui-skin-sam .yui-dt-scrollable .yui-dt-hd {
	overflow:visible;			
	z-index:2;		
	position:relative;				
	width:"99.9%";
} 		
.disabled-text{ border-width:1px; border-color: #cdcdcd; border-style: solid; padding: 2px; color: #666;}
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
</style>
 
 <c:url value="/protected/cps/manageEDI/updateValues?${_csrf.parameterName}=${_csrf.token}" var="updateUrl" />
 <c:url value="${request.getContextPath()}/hebAssets/images/dropdown.bmp" var="image"></c:url>
<script type="text/javascript">
var dataOtherAttribute =null;
var listSeasonalityData = null;
var isVendor = ${ManageEDICandidate.isVendor};

//======================BEGIN SET AUTOCOMPLETE FOR FILTER ==============================//
var arrayDataFilter;

getOtherAttributeTabAutoFilter = function(query)
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
	var oACDS = new YAHOO.widget.DS_JSFunction(getOtherAttributeTabAutoFilter);
    // Instantiate first AutoComplete
    var oAutoComp = new YAHOO.widget.AutoComplete(idInput,idContainDiv,oACDS);
    oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
   // this.oAutoComp.typeAhead = true;
	oAutoComp.queryQuestionMark = false;
	oAutoComp.forceSelection = false;
	oAutoComp.autoHighlight = true;
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
	
	oAutoComp.generateRequest = function(sQuery) {
    return sQuery +"__"+fldIndex;
	};
			
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
	var itemSelectHandler = function(sType, aArgs) {
		YAHOO.util.Dom.get(idInput).value =  html_entity_decode(YAHOO.util.Dom.get(idInput).value);

		clearTimeout(filterTimeout);
		setTimeout(updateFilter,600);
		
		SER.hasFilter = true;
	};
	
	oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);	

	/*document.getElementById(idContainDiv).onmouseout = function() {
		document.getElementById(idContainDiv).style.display = 'none';
		document.getElementById(idContainDiv).onmouseover = function() {
			document.getElementById(idContainDiv).style.display = '';
		};
	};*/
		
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
		document.getElementById(idContainDiv).style.display = '';		
        setTimeout(function() {t2.sendQuery(""+"__"+fldIndex);}, 0);
        document.getElementById(idInput).focus();
	};
	
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get(idInput+"Image"), "click", sendEmptyQuery,temp);
}
//==========================END SET AUTOCOMPLETE FOR FILTER==============================// 
function getObjectFilter(){
	var arrFilterObj = new Array();
	arrFilterObj.push("vendorFilter");
	arrFilterObj.push("sellingUpcFilter");
	arrFilterObj.push("caseUpcFilter");
	arrFilterObj.push("ratingTypeFilter");
	arrFilterObj.push("styleFilter");
	arrFilterObj.push("modelFilter");
	arrFilterObj.push("colorFilter");
	arrFilterObj.push("ratingFilter");
	arrFilterObj.push("couponFamilyCode1Filter");
	arrFilterObj.push("couponFamilyCode2Filter");
	arrFilterObj.push("codeDateMaxShelfLifeFilter");
	arrFilterObj.push("inboundSpecDaysFilter");
	arrFilterObj.push("reactionDaysFilter");
	arrFilterObj.push("guaranteeToStoreDaysFilter");
	arrFilterObj.push("seasonalityYearFilter");
	arrFilterObj.push("seasonalityFilter");
	return arrFilterObj;
}

function setFilterValue(){
	if(SER.itemResultFilter != null && SER.itemResultFilter != ""){
		var filterValues = document.getElementById('filterValues').value;
		if(filterValues != "")
		{
			var curTab = 5;
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
						if(document.getElementById(arrObjFilter[index]) != null){
							if(arrObjFilter[index] != 'seasonalityFilter'){
								document.getElementById(arrObjFilter[index]).value = arrValueOnTab[i].substring(pos+1);
							}
							else
							{
								var seasonalityFilter = document.getElementById('seasonalityFilter');
								for(j=0; j<seasonalityFilter.options.length;j++)
								{
									if(seasonalityFilter.options[j].value == arrValueOnTab[i].substring(pos+1))
										seasonalityFilter.options[j].selected = true;
								}
							}
						}
					}
				}										
			}
		}
	}
}
</script>

<div id="yahoo-com" class="yui-skin-sam">
	<table border="0" width="100%">
		<tr>
			<td width="40%"><div id="totalRecord" style="padding-left: 5px; color: blue"></div>	</td>
			<td><div id="saveResult" style="color: green"></div></td>
		</tr>
	</table>
  	<div style="width:100%; z-index:15000;">  		
	    <div id="tblOtherAttribute"></div>
		<div id="pag" style="font-family:arial; font-size:10px;"></div>
	</div>
	<%
		if(request.getSession().getAttribute("ManageEDICandidate") != null)
		{
			StringBuffer strData = new StringBuffer();
			ManageEDICandidate form = (ManageEDICandidate)(request.getSession().getAttribute("ManageEDICandidate"));
			List<EDISearchResultVO> results = form.getEdiSearchResultVOLst();
			
			boolean isActiveProduct = form.getCandidateEDISearchCriteria().getActionId().equals(BusinessConstants.SEARCH_ACTION_ACTIVEPRODUCTS_ID);
			boolean isVendorLogin = BusinessUtil.isVendor(form.getCandidateEDISearchCriteria().getRole());
			
			strData.append("[");
			if(results != null && results.size() >0)
			{							
				for(int i= 0; i< results.size(); i++)
				{
					EDISearchResultVO ediResult = results.get(i);
					if(ediResult.getPsItemId() != null)
					{
						String WorkRq = String.valueOf(ediResult.getPsWorkId() != null? ediResult.getPsWorkId():ediResult.getPsProdId());
						String id = WorkRq + "-" + ediResult.getPsItemId() + "-" + ediResult.getPsVendno() + "-" + ediResult.getChannel();
						String idRowHidden=CPSHelper.displaySellingUPC(ediResult.getUpcNo())+"__"+ediResult.isActiveProductKit();	
						if(i==0 || strData.toString().equals("["))
							strData.append("{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ WorkRq +"'>\",idResult:\"" + id);
						else
							strData.append("\n,{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ WorkRq +"'>\",idResult:\"" + id);
							
						strData.append("\",changeStatus:\"" + (!ediResult.isNewDataSw() || ediResult.isDisable()? "-1":"0"));
						strData.append("\",productID:\"" + ediResult.getPsProdId());
						strData.append("\",vendor:\"" + ediResult.getPsVendno() +" " + CPSHelper.convertCharToHTMLForJSON(ediResult.getPsVendName()));  
						strData.append("\",sellingUpc:\"" + CPSHelper.displaySellingUPC(ediResult.getUpcNo()));
						strData.append("\",caseUpc:\"" + ediResult.getOtherAttributeDetailVO().getCaseUpc());
						strData.append("\",ratingType:\"" + ediResult.getOtherAttributeDetailVO().getRatingType()); 
						strData.append("\",style:\"" + ediResult.getOtherAttributeDetailVO().getStyle()); 
						strData.append("\",model:\"" + ediResult.getOtherAttributeDetailVO().getModel()); 
						strData.append("\",color:\"" + ediResult.getOtherAttributeDetailVO().getColor());
						strData.append("\",itemCode:\"" + ediResult.getPsItemId());
						strData.append("\",rating:\"" + ediResult.getOtherAttributeDetailVO().getRating()); 
						strData.append("\",couponFamilyCode1:\"" + ediResult.getOtherAttributeDetailVO().getCouponFamilyCode1()); 
						strData.append("\",couponFamilyCode2:\"" + ediResult.getOtherAttributeDetailVO().getCouponFamilyCode2()); 
						strData.append("\",codeDateMaxShelfLife:\"" + ediResult.getOtherAttributeDetailVO().getCodeDateMaxShelfLife());
						strData.append("\",inboundSpecDays:\"" + (CPSHelper.isEmptyOrZero(ediResult.getOtherAttributeDetailVO().getInboundSpecDays())? "": ediResult.getOtherAttributeDetailVO().getInboundSpecDays()));
						strData.append("\",reactionDays:\"" + (CPSHelper.isEmptyOrZero(ediResult.getOtherAttributeDetailVO().getReactionDays()) || isVendorLogin? "": ediResult.getOtherAttributeDetailVO().getReactionDays())); 
						strData.append("\",guaranteeToStoreDays:\"" + (CPSHelper.isEmptyOrZero(ediResult.getOtherAttributeDetailVO().getGuaranteeToStoreDays()) || isVendorLogin? "": ediResult.getOtherAttributeDetailVO().getGuaranteeToStoreDays())); 
						strData.append("\",seasonalityYear:\"" + (CPSHelper.isEmptyOrZero(ediResult.getOtherAttributeDetailVO().getSeasonalityYear())? "": ediResult.getOtherAttributeDetailVO().getSeasonalityYear()));
						strData.append("\",seasonality:\"" + ediResult.getOtherAttributeDetailVO().getSeasonality());	
						strData.append("\",seasonalityName:\"" + ediResult.getOtherAttributeDetailVO().getSeasonalityName());
						strData.append("\",status:\"" + ediResult.getStatus());
						strData.append("\",idRowHidden:\""+ idRowHidden+ "\"}");
					}
				}
				
			}
			strData.append("]");
	%>
 		<%
 			if(isActiveProduct){
 				StringBuffer strDataSeasonality = new StringBuffer();
 				List<BaseJSFVO> listSeasonality = (List<BaseJSFVO>)(request.getSession().getAttribute("listSeasonality"));
 				if(listSeasonality != null && !listSeasonality.isEmpty()){
 					strDataSeasonality.append("[");
 					for(int j= 0; j< listSeasonality.size(); j++)
 					{
 						if(j==0)
 							strDataSeasonality.append("{id:\""+ listSeasonality.get(j).getId() +"\",name:\"" + CPSHelper.convertCharToHTMLForJSON(listSeasonality.get(j).getName()) + "\"}");
 						else
 							strDataSeasonality.append(",{id:\""+ listSeasonality.get(j).getId() +"\",name:\"" + CPSHelper.convertCharToHTMLForJSON(listSeasonality.get(j).getName()) + "\"}");
 					}
 					strDataSeasonality.append("]");
 		%>
 					<script type="text/javascript">
 						listSeasonalityData = <%=strDataSeasonality.toString()%>;
 					</script>
 		<%
 				}
 			}
 		%>
 		
  		<script type="text/javascript">  
  		dataOtherAttribute = {   
  		         areacodes: <%=strData.toString()%>};  
	         
  		var changeRequest = false;
  		var dataSourceTemp = []; 
		var filterItemReturn = []; 		
		var otherAttributeResult = makeOtherAttributeTable();
				
		function makeOtherAttributeTable(){
        
		var formatInboundSpecDays = function(elCell, oRecord, oColumn, sData) {
	        elCell.innerHTML = "<input type='text' id='inboundSpecDays_" + oRecord.getData("idResult") +"' value='" + oRecord.getData("inboundSpecDays") +"' size='6' class='disabled-text' readonly='readonly' />";
        };

		var formatReactionDays = function(elCell, oRecord, oColumn, sData) {
            elCell.innerHTML = "<input type='text' id='reactionDays_" + oRecord.getData("idResult") +"' value='" + oRecord.getData("reactionDays") +"' size='6' class='disabled-text' readonly='readonly' />";
        };

		var formatGuaranteeToStoreDays = function(elCell, oRecord, oColumn, sData) {
            elCell.innerHTML = "<input type='text' id='guaranteeToStoreDays_" + oRecord.getData("idResult") +"' value='" + oRecord.getData("guaranteeToStoreDays") +"' size='6' class='disabled-text' readonly='readonly' />";
        };

		var formatSeasonalityYear = function(elCell, oRecord, oColumn, sData) {
            elCell.innerHTML = "<input type='text' id='seasonalityYear_" + oRecord.getData("idResult") +"' value='" + oRecord.getData("seasonalityYear") +"' size='4' class='disabled-text' readonly='readonly' />";
        };

        var formatComboBox = function(elCell, oRecord, oColumn, sData) {
        	var selectObject;
        	
        	selectObject = "<select id='seasonality_" + oRecord.getData("idResult") +"' style='width: 120px;' disabled='disabled'>";

    		var hasValueSelected = false;
       		if(listSeasonalityData != null){
       			for (var i=0;i<listSeasonalityData.length;i++)
   	        	{
        			if(listSeasonalityData[i].id == oRecord.getData("seasonality")){
        				hasValueSelected = true;
						selectObject += "<option value='" + listSeasonalityData[i].id + "' selected='selected'>" + listSeasonalityData[i].name + "</option>";
        			}
					else
						selectObject += "<option value='" + listSeasonalityData[i].id + "'>" + listSeasonalityData[i].name + "</option>";
   	        	}
       		}
        	if(!hasValueSelected)
        		selectObject += "<option value='0' selected='selected'>UNASSIGNED</option>";
        	selectObject +=	"</select>";          
            elCell.innerHTML = selectObject;
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
				compState = comp(eval(a.getData(field) !== ""?a.getData(field):"-1"), eval(b.getData(field)!== ""?b.getData(field):"-1"), sortBy);
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
        	return sortCompare(a, b, desc, "caseUpc", "sellingUpc", true); 
        };

        var sortRatingType = function(a, b, desc) {
        	return sortCompare(a, b, desc, "ratingType", "sellingUpc", false); 
        };

        var sortStyle = function(a, b, desc) {
        	return sortCompare(a, b, desc, "style", "sellingUpc", false); 
        };

        var sortModel = function(a, b, desc) {
        	return sortCompare(a, b, desc, "model", "sellingUpc", false); 
        };

        var sortColor = function(a, b, desc) {
        	return sortCompare(a, b, desc, "color", "sellingUpc", false); 
        };

        var sortItemCode = function(a, b, desc) {
        	return sortCompare(a, b, desc, "itemCode", "sellingUpc", true); 
        };

        var sortRating = function(a, b, desc) {
        	return sortCompare(a, b, desc, "rating", "sellingUpc", false); 
        };

        var sortCouponFamilyCode1 = function(a, b, desc) {
        	return sortCompare(a, b, desc, "couponFamilyCode1", "sellingUpc", true); 
        };

        var sortCouponFamilyCode2 = function(a, b, desc) {
        	return sortCompare(a, b, desc, "couponFamilyCode2", "sellingUpc", true); 
        };

        var sortCodeDateMaxShelfLife = function(a, b, desc) {
        	return sortCompare(a, b, desc, "codeDateMaxShelfLife", "sellingUpc", true); 
        };

        var sortInboundSpecDays = function(a, b, desc) {
        	return sortCompare(a, b, desc, "inboundSpecDays", "sellingUpc", true); 
        };

        var sortReactionDays = function(a, b, desc) {
        	return sortCompare(a, b, desc, "reactionDays", "sellingUpc", true); 
        };

        var sortGuaranteeToStoreDays = function(a, b, desc) {
        	return sortCompare(a, b, desc, "guaranteeToStoreDays", "sellingUpc", true); 
        };

        var sortSeasonalityYear = function(a, b, desc) {
        	return sortCompare(a, b, desc, "seasonalityYear", "sellingUpc", true); 
        };

        var sortSeasonality = function(a, b, desc) {
        	return sortCompare(a, b, desc, "seasonalityName", "sellingUpc", false); 
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
                            {key:"vendors",    label:"Vendor", width: 150,  sortable:true, sortOptions:{sortFunction:sortVendor},
								children: [{key:"vendor", label:"<div id ='vendorDiv' class ='myAutoComplete'><input type='text' id='vendorFilter' name='divFilter' size='25' maxlength='50' style='TEXT-TRANSFORM\: uppercase; position: relative;'><img src='${image}' alt='' width='20' id='vendorFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'><div id='myContainerVendorFilter'></div></div>",sortable:false, resizeable:false}]},  
                            {key:"sellingUpcs",    label:"Selling UPC", width: 105, sortable:true, sortOptions:{sortFunction:sortSellingUpc},
								children: [{key:"sellingUpc", label:"<div id ='sellingUpcDiv' class ='myAutoComplete'><input type='text' id='sellingUpcFilter' name='divFilter' size='12' maxlength='20' style='TEXT-TRANSFORM\: uppercase; position: relative;'><img src='${image}' alt='' width='20' id='sellingUpcFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerSellingUpcFilter'></div></div>",sortable:false, resizeable:false}]},
                            {key:"caseUpcs",    label:"Case UPC", width: 100,  sortable:true, sortOptions:{sortFunction:sortCaseUpc},
								children: [{key:"caseUpc", label:"<div id ='caseUpcDiv' class ='myAutoComplete'><input type='text' id='caseUpcFilter' name='divFilter' size='12' maxlength='20' style='TEXT-TRANSFORM\: uppercase; position: relative;'><img src='${image}' alt='' width='20' id='caseUpcFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerCaseUpcFilter'></div></div>",sortable:false, resizeable:false}]},
							{key:"styles",    label:"Style", width: 90,   sortable:true, sortOptions:{sortFunction:sortStyle},
								children: [{key:"style", label:"<div id ='styleDiv'><input type='text' id='styleFilter' name='divFilter' size='12' maxlength='20'></div>",sortable:false, resizeable:false}]},
							{key:"models",    label:"Model", width: 50,   sortable:true, sortOptions:{sortFunction:sortModel},
								children: [{key:"model", label:"<div id ='modelDiv'><input type='text' id='modelFilter' name='divFilter' size='5' maxlength='20'></div>",sortable:false, resizeable:false}]},
							{key:"colors",    label:"Color", width: 50,   sortable:true, sortOptions:{sortFunction:sortColor},
								children: [{key:"color", label:"<div id ='colorDiv'><input type='text' id='colorFilter' name='divFilter' size='5' maxlength='20'></div>",sortable:false, resizeable:false}]},
							{key:"itemCodes",    label:"Item Code", width: 80,   sortable:true, sortOptions:{sortFunction:sortItemCode},
								children: [{key:"itemCode", label:"<div id ='itemCodeDiv'><input type='text' id='itemCodeFilter' name='divFilter' size='10' maxlength='20'></div>",sortable:false, resizeable:false}]},
                            {key:"ratings",    label:"Rating", width: 50,   sortable:true, sortOptions:{sortFunction:sortRating},
								children: [{key:"rating", label:"<div id ='ratingDiv'><input type='text' id='ratingFilter' name='divFilter' size='5' maxlength='20'></div>",sortable:false, resizeable:false}]},
							{key:"ratingTypes",    label:"Rating Type", width: 50,  sortable:true, sortOptions:{sortFunction:sortRatingType},
								children: [{key:"ratingType", label:"<div id ='ratingTypeDiv'><input type='text' id='ratingTypeFilter' name='divFilter' size='4' maxlength='20'></div>",sortable:false, resizeable:false}]},								
                            {key:"couponFamilyCode1s",    label:"Coupon Family<br/>Code 1", width: 63,  sortable:true, sortOptions:{sortFunction:sortCouponFamilyCode1},
								children: [{key:"couponFamilyCode1", label:"<div id ='couponFamilyCode1Div'><input type='text' id='couponFamilyCode1Filter' name='divFilter' size='7' maxlength='20'></div>",sortable:false, resizeable:false}]},
                            {key:"couponFamilyCode2s",    label:"Coupon Family<br/>Code 2", width: 63,  sortable:true, sortOptions:{sortFunction:sortCouponFamilyCode2},
								children: [{key:"couponFamilyCode2", label:"<div id ='couponFamilyCode2Div'><input type='text' id='couponFamilyCode2Filter' name='divFilter' size='7' maxlength='20'></div>",sortable:false, resizeable:false}]},
                            {key:"codeDateMaxShelfLifes",    label:"Code Date Max<br/>Shelf Life", width: 65,  sortable:true, sortOptions:{sortFunction:sortCodeDateMaxShelfLife},
								children: [{key:"codeDateMaxShelfLife", label:"<div id ='codeDateMaxShelfLifeDiv'><input type='text' id='codeDateMaxShelfLifeFilter' name='divFilter' size='7' maxlength='20'></div>",sortable:false, resizeable:false}]},
                            {key:"inboundSpecDayss",    label:"Inbound Spec<br/>Days", width:58, formatter:formatInboundSpecDays, sortable:true, sortOptions:{sortFunction:sortInboundSpecDays},
                            	children: [{key:"inboundSpecDays", label:"<div id ='inboundSpecDaysDiv'><input type='text' id='inboundSpecDaysFilter' name='divFilter' size='6' maxlength='4'></div>",sortable:false, resizeable:false}]},
                            {key:"reactionDayss",    label:"Reaction<br/>Days", width: 60, formatter:formatReactionDays, sortable:true, sortOptions:{sortFunction:sortReactionDays},
                            	children: [{key:"reactionDays", label:"<div id ='reactionDaysDiv'><input type='text' id='reactionDaysFilter' name='divFilter' size='6' maxlength='4'></div>",sortable:false, resizeable:false}]},
                            {key:"guaranteeToStoreDayss",    label:"Guarantee to<br/>Store Days", width: 60, formatter:formatGuaranteeToStoreDays, sortable:true, sortOptions:{sortFunction:sortGuaranteeToStoreDays},
                            	children: [{key:"guaranteeToStoreDays", label:"<div id ='guaranteeToStoreDaysDiv'><input type='text' id='guaranteeToStoreDaysFilter' name='divFilter' size='6' maxlength='4'></div>",sortable:false, resizeable:false}]},
                            {key:"seasonalityYears",    label:"Seasonality<br/>Year", width: 50, formatter:formatSeasonalityYear, sortable:true, sortOptions:{sortFunction:sortSeasonalityYear},
                            	children: [{key:"seasonalityYear", label:"<div id ='seasonalityYearDiv'><input type='text' id='seasonalityYearFilter' name='divFilter' size='4' maxlength='4'></div>",sortable:false, resizeable:false}]},
                            {key:"seasonalitys",    label:"Seasonality", minWidth: 190, formatter:formatComboBox, sortable:true, sortOptions:{sortFunction:sortSeasonality},
                            	children: [{key:"seasonality", label:"<table class='tbl-filter'><tr><td width='115' class='td-filter'><div id ='seasonalityDiv'><select id='seasonalityFilter' name='divFilter' style='width: 110px;'><option value=''>-- All --</option></select>&nbsp;</div></td><td class='td-filter'><input type='button' id='filterStatus' value='Hide'><input type='button' id='clearFilter' value='Clear'></td></tr></table>",sortable:false, resizeable:false}]},
                            {key:"seasonalityName",    label:""},
							{key:"idRowHidden"}];   
		
        var myDataSource = new YAHOO.util.DataSource(dataOtherAttribute.areacodes);
        myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
        myDataSource.responseSchema = {
            fields: [{key:"changeStatus"},{key:"productID"},{key:"checkBox"},{key:"idResult"},{key:"vendor"},{key:"sellingUpc"},
                     {key:"caseUpc"},{key:"style"},{key:"model"},{key:"color"},{key:"itemCode"},{key:"rating"},{key:"ratingType"},
                     {key:"couponFamilyCode1"},{key:"couponFamilyCode2"},{key:"codeDateMaxShelfLife"},
                     {key:"inboundSpecDays"},{key:"reactionDays"},{key:"guaranteeToStoreDays"},
                     {key:"seasonalityYear"},{key:"seasonality"}, {key:"seasonalityName"}, {key:"status"}, {key:"idRowHidden"}]
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
								temp=SER.convertFromIrToRegularPattern(convertSpecialChars(filterItemReturn[i].vendor.toUpperCase()))+"__"+filterItemReturn[i].sellingUpc.toUpperCase()+"__"+filterItemReturn[i].caseUpc.toUpperCase()+"__"+filterItemReturn[i].ratingType.toUpperCase()+"__"+filterItemReturn[i].style.toUpperCase()+"__"+filterItemReturn[i].model.toUpperCase()+"__"+filterItemReturn[i].color.toUpperCase()+"__"+filterItemReturn[i].itemCode.toUpperCase()+"__"+filterItemReturn[i].rating.toUpperCase()+"__"+filterItemReturn[i].couponFamilyCode1.toUpperCase()+"__"+filterItemReturn[i].couponFamilyCode2.toUpperCase()+"__"+filterItemReturn[i].codeDateMaxShelfLife.toUpperCase()+"__"+filterItemReturn[i].inboundSpecDays.toUpperCase()+"__"+filterItemReturn[i].reactionDays.toUpperCase()+"__"+filterItemReturn[i].guaranteeToStoreDays.toUpperCase()+"__"+filterItemReturn[i].seasonalityYear.toUpperCase()+"__"+filterItemReturn[i].seasonality.toUpperCase();
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
								temp=SER.convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].vendor.toUpperCase()))+"__"+dataSourceTemp[i].sellingUpc.toUpperCase()+"__"+dataSourceTemp[i].caseUpc.toUpperCase()+"__"+dataSourceTemp[i].ratingType.toUpperCase()+"__"+dataSourceTemp[i].style.toUpperCase()+"__"+dataSourceTemp[i].model.toUpperCase()+"__"+dataSourceTemp[i].color.toUpperCase()+"__"+dataSourceTemp[i].itemCode.toUpperCase()+"__"+dataSourceTemp[i].rating.toUpperCase()+"__"+dataSourceTemp[i].couponFamilyCode1.toUpperCase()+"__"+dataSourceTemp[i].couponFamilyCode2.toUpperCase()+"__"+dataSourceTemp[i].codeDateMaxShelfLife.toUpperCase()+"__"+dataSourceTemp[i].inboundSpecDays.toUpperCase()+"__"+dataSourceTemp[i].reactionDays.toUpperCase()+"__"+dataSourceTemp[i].guaranteeToStoreDays.toUpperCase()+"__"+dataSourceTemp[i].seasonalityYear.toUpperCase()+"__"+dataSourceTemp[i].seasonality.toUpperCase();										
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
            draggableColumns:false,
            height:"250px",
            formatRow: myRowFormatter
        }       
 
        var myDataTable = new YAHOO.widget.ScrollingDataTable("tblOtherAttribute", myColumnDefs, myDataSource, myConfigs);
		//hiden column
        myDataTable.hideColumn(myDataTable.getColumn("idResult"));
		myDataTable.hideColumn(myDataTable.getColumn("changeStatus"));
		myDataTable.hideColumn(myDataTable.getColumn("seasonalityName"));
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

		//add item into combo seasonalityFilter
		var seasonFilter = document.getElementById("seasonalityFilter");

		if(listSeasonalityData != null){
			for (var i=0;i<listSeasonalityData.length;i++)
	    	{
	        	var option=document.createElement("option");
	        	option.value = listSeasonalityData[i].id;
	        	option.text = listSeasonalityData[i].name;
	        	try{
		        	  // for IE earlier than version 8
		        	  seasonFilter.add(option,seasonFilter.options[null]);
	        	  }
	        	catch (e)
	        	  {
	        		seasonFilter.add(option,null);
	        	  }      	        	
	    	}
		}

		var optionEnd = document.createElement("option");
		optionEnd.value = 0;
		optionEnd.text = "UNASSIGNED";
    	try{
        	  // for IE earlier than version 8
        	  seasonFilter.add(optionEnd,seasonFilter.options[null]);
    	  }
    	catch (e)
    	  {
    		seasonFilter.add(optionEnd,null);
    	  }			
		
		//get data of each field to array	
		arrayDataFilter = [];
		setDataSourceForAutocompleteFilter();
		//set autocomplete for filter
		var arrFilterObj = new Array();
		arrFilterObj.push("vendorFilter");
		arrFilterObj.push("sellingUpcFilter");
		arrFilterObj.push("caseUpcFilter");		
		var cnt=0;
		for(var i=0;i < arrFilterObj.length;i++)
		{									
			setAutoCompleteForFilter("myContainer"+arrFilterObj[i].capitaliseFirstLetter(arrFilterObj[i]),arrFilterObj[i],cnt++);
			document.getElementById(arrFilterObj[i]).parentNode.parentNode.parentNode.style.overflow = 'visible';			
		}
  	  
		myDataTable.subscribe("postRenderEvent", function(){
			var elements = YAHOO.util.Dom.getElementsByClassName('yui-dt-bd', 'div')[0];
			
				if(elements!=null)
				{
					var beforeScroll = elements.scrollLeft;				
					elements.scrollLeft = beforeScroll;
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
						oRec.setData("changeStatus", getChangeStatusOnOtherAttributeTab(oRec.getData("changeStatus"), true));			        	
		        	}
		        	else
		        	{
		        		oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[0] +" class=yui-dt-checkbox />");
						oRec.setData("changeStatus", getChangeStatusOnOtherAttributeTab(oRec.getData("changeStatus"), false));
							
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
	    	            	var changeValue = getChangeStatusOnOtherAttributeTab(oRec.getData("changeStatus"), true);
	    	            	if(changeValue != null)
	    	            		oRec.setData("changeStatus", changeValue);
	    	            }
	           			else
	           			{
	           				oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("idResult") +" name=ckb_"+ oRec.getData("idResult").split('-')[0] +" class=yui-dt-checkbox />");
	           				var changeValue = getChangeStatusOnOtherAttributeTab(oRec.getData("changeStatus"), false);
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
            SER.currentRecord= cur.rowsPerPage;
            SER.currentPage = cur.page;
        });	
        //set page is selected	
        myDataTable.get('paginator').setPage(parseInt(SER.currentPage));
		
		//filtering
		YAHOO.util.Event.on('vendorFilter','change',function (e) {			
			doBeforeFilter(e);
		});
	
		YAHOO.util.Event.on('sellingUpcFilter','change',function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('caseUpcFilter','change',function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('ratingTypeFilter','change',function (e) {	
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('styleFilter','change',function (e) {				
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('modelFilter','change',function (e) {				
			doBeforeFilter(e);
		});	
		YAHOO.util.Event.on('colorFilter','change',function (e) {				
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('itemCodeFilter','change',function (e) {				
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('ratingFilter','change',function (e) {				
			doBeforeFilter(e);
		});	
		
		YAHOO.util.Event.on('couponFamilyCode1Filter','change',function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('couponFamilyCode2Filter','change',function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('codeDateMaxShelfLifeFilter','change',function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('inboundSpecDaysFilter','change',function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('reactionDaysFilter','change',function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('guaranteeToStoreDaysFilter','change',function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('seasonalityYearFilter','change',function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('seasonalityFilter','change',function (e) {	
			doBeforeFilter(e)
		});

		YAHOO.util.Event.on('clearFilter','click',function (e) {	
			document.getElementById("vendorFilter").value='';
			document.getElementById("sellingUpcFilter").value='';
			document.getElementById("caseUpcFilter").value='';
			document.getElementById("ratingTypeFilter").value='';
			document.getElementById("styleFilter").value='';
			document.getElementById("modelFilter").value='';
			document.getElementById("colorFilter").value='';
			document.getElementById("itemCodeFilter").value='';
			document.getElementById("ratingFilter").value='';
			document.getElementById("couponFamilyCode1Filter").value='';
			document.getElementById("couponFamilyCode2Filter").value='';
			document.getElementById("codeDateMaxShelfLifeFilter").value='';
			document.getElementById("inboundSpecDaysFilter").value='';
			document.getElementById("reactionDaysFilter").value='';
			document.getElementById("guaranteeToStoreDaysFilter").value='';
			document.getElementById("seasonalityYearFilter").value='';
			document.getElementById("seasonalityFilter").options[0].selected = true;

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
					if(!(arrayDataFilter[0]).inArray(filterItemReturn[i].vendor) && filterItemReturn[i].vendor !='')
						arrayDataFilter[0].push(filterItemReturn[i].vendor);
				
					if(!(arrayDataFilter[1]).inArray(filterItemReturn[i].sellingUpc) && filterItemReturn[i].sellingUpc !='')
						arrayDataFilter[1].push(filterItemReturn[i].sellingUpc);
					
					if(!(arrayDataFilter[2]).inArray(filterItemReturn[i].caseUpc) && filterItemReturn[i].caseUpc!='')
						arrayDataFilter[2].push(filterItemReturn[i].caseUpc);	
				}				
			}							
		}
		else
		{
			for(var i = 0;i < dataSourceTemp.length; i++)
			{
				if(!(arrayDataFilter[0]).inArray(dataSourceTemp[i].vendor) && dataSourceTemp[i].vendor !='')
					arrayDataFilter[0].push(dataSourceTemp[i].vendor);
				
				if(!(arrayDataFilter[1]).inArray(dataSourceTemp[i].sellingUpc) && dataSourceTemp[i].sellingUpc !='')
					arrayDataFilter[1].push(dataSourceTemp[i].sellingUpc);
				
				if(!(arrayDataFilter[2]).inArray(dataSourceTemp[i].caseUpc) && dataSourceTemp[i].caseUpc!='')
					arrayDataFilter[2].push(dataSourceTemp[i].caseUpc);					
			}
		}
    }

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
		arrFilterObj.push("caseUpcFilter");
		arrFilterObj.push("ratingTypeFilter");
		arrFilterObj.push("styleFilter");
		arrFilterObj.push("modelFilter");
		arrFilterObj.push("colorFilter");
		arrFilterObj.push("itemCodeFilter");
		arrFilterObj.push("ratingFilter");
		arrFilterObj.push("couponFamilyCode1Filter");
		arrFilterObj.push("couponFamilyCode2Filter");
		arrFilterObj.push("codeDateMaxShelfLifeFilter");
		arrFilterObj.push("inboundSpecDaysFilter");
		arrFilterObj.push("reactionDaysFilter");
		arrFilterObj.push("guaranteeToStoreDaysFilter");
		arrFilterObj.push("seasonalityYearFilter");
		arrFilterObj.push("seasonalityFilter");
		
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
				if(i < lstObjVl.length -1)
					partern+="__"+"\.*"+lstObjVl[i]+"\.*";
				else //if filter by seasonality than have to filter with criteria is equal
					partern+="__"+lstObjVl[i];
			}
			else
			{
				partern+="__\.*";
			}
		}
		return partern;
	};
	
	function getChangeStatusOnOtherAttributeTab(oldValue, checked)
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
			var isFilter = false;
			if(id.length != dataSourceTemp.length)
				isFilter = true;
			
			for(var i=0; i<dataSourceTemp.length; i++) {
				var idWorkRq = dataSourceTemp[i].idResult.split('-')[0];
	            if(checked)
	            {
		            if((isFilter && id.inArray(idWorkRq)) || !isFilter){
		            	dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" checked=checked class=yui-dt-checkbox />";
		            	var changeValue = getChangeStatusOnOtherAttributeTab(dataSourceTemp[i].changeStatus, true);
		            	if(changeValue != null)
		            		dataSourceTemp[i].changeStatus = changeValue;
		            }		         
	            }
       			else
       			{
       			    if((isFilter && id.inArray(idWorkRq)) || !isFilter){
	       				dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
	       				var changeValue = getChangeStatusOnOtherAttributeTab(dataSourceTemp[i].changeStatus, false);
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
		        		var changeValue = getChangeStatusOnOtherAttributeTab(dataSourceTemp[i].changeStatus, true);
		            	if(changeValue != null)
		            		dataSourceTemp[i].changeStatus = changeValue;
		        	}
		        	else
		        	{
		        		dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].idResult +" name=ckb_"+ dataSourceTemp[i].idResult.split('-')[0] +" class=yui-dt-checkbox />";
		        		var changeValue = getChangeStatusOnOtherAttributeTab(dataSourceTemp[i].changeStatus, false);
		            	if(changeValue != null)
		            		dataSourceTemp[i].changeStatus = changeValue;
		        	}
		        }
			 }
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
	function html_entity_decode(str) {
		var ta = document.createElement("textarea");
		ta.innerHTML = str.replace(/</g,"&lt;").replace(/>/g,"&gt;");
		return ta.value;
	} 

</script>
 <%} %> 		
</div>