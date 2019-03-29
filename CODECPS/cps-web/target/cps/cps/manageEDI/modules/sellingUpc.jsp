<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<%@ page import="com.heb.jaf.security.UserInfo" %>
<%@ page import="com.heb.jaf.vo.Resource" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.heb.operations.cps.vo.EDISearchResultVO" %>
<%@ page import="com.heb.operations.cps.model.ManageEDICandidate" %>
<%@page import="com.heb.operations.cps.util.CPSHelper"%><html>
	<head>		
	<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- 	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">	 -->
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

		.yui-skin-sam #itemCategory .yui-ac-input
		{
			width:90%;
		}
		
		.yui-skin-sam .yui-dt tr.mark,
		.yui-skin-sam .yui-dt tr.mark td.yui-dt-asc,
		.yui-skin-sam .yui-dt tr.mark td.yui-dt-desc,
		.yui-skin-sam .yui-dt tr.mark td.yui-dt-asc,
		.yui-skin-sam .yui-dt tr.mark td.yui-dt-desc {
			background-color: #f1c8ff;
			color: #000;
		}	

		.yui-skin-sam .yui-dt table .tbl-filter 
		{
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
		pre{font:99% arial,helvetica,clean,sans-serif;margin:0;padding:4px 0px 4px 0px;white-space: pre-wrap;word-wrap: break-word;}		
		.disabled-text{ border-width:1px; border-color: #cdcdcd; border-style: solid; padding: 2px; color: #666;width:195px;}		
	</style>		
	</head>
<%
	String renderView = "";
// 	Map<Integer, String> m  = (Map<Integer, String>)pageContext.findAttribute("com.heb.ResourceMap");
	org.springframework.security.core.Authentication auth = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication(); 
	UserInfo hebUserDetails = (UserInfo)auth.getPrincipal();

	Map<Integer, String> m = hebUserDetails.getResourceMap();
	if(m != null){
		String acs = m.get(272);
		if(acs != null){
			if("ED".equals(acs)){
				renderView = "E";
			}
			else if("V".equals(acs)){
				renderView = "V";
			} else {
			    renderView = "N";
			}
		}
		else{
			renderView = "N";
		}
	}
	else{
		renderView = "N";
	}
	pageContext.setAttribute("renderView", renderView);
%>
<body onload="loadTable();" class="yui-skin-sam">
<table width="100%">
	<tr>
		<td width = "30%">
			<div id="totalSellingRecord" style="padding-left: 5px; color: blue" align="left"></div>
		</td>
		<td width="70%">
			<div id="saveResult" style="color: green" align="left"></div>
		</td>
	</tr>
</table>
<div style="display:none" id="content2">
<table id="tableSellingContent">
	<thead>
		<tr>
		<th>
		</th>
		<th>
		</th>
		<th>
			Input Source
		</th>
		<th>
			Tracking ID
		</th>
		<th>
			Submission Date
		</th>
		<th>
			Status
		</th>
		<th>
			Vendor
		</th>
		<th>
			Selling UPC
		</th>
		<th>
			Description
		</th>
		<th>
			BDM
		</th>
		<th>
			Dept
		</th>
		<th>
			SubCommodity
		</th>
		<th>
			Brand
		</th>
		<th>
			Sub Brand
		</th>
		<th>
			Cost Owner
		</th>
		<!--BINHHT add-->
		<cps:renderByResourceAccess resourceId="272">
					<jsp:attribute name="EDIT">
						<th>
							Tax Category
						</th>
					</jsp:attribute>
		</cps:renderByResourceAccess>
		<cps:renderByResourceAccess resourceId="272">
					<jsp:attribute name="VIEW">
						<th>
							Tax Category
						</th>
					</jsp:attribute>
		</cps:renderByResourceAccess>
		<th>
			Item Category
		</th>
		<th>
			Subcommodity Hidden
		</th>
		<th>
			TaxCategory Hidden
		</th>
		<th>
			status Id Hidden
		</th>
		<th>
			IdRow Hidden
		</th>
		<th>
			Disable Status
		</th>
		</tr>		
	</thead>
	<tbody>
		<%--<logic:iterate id="ediSearchResult" property="ediSearchResultVOLst" name="CPSEDIMain" type="com.heb.operations.cps.vo.EDISearchResultVO">--%>
			<%
				ManageEDICandidate manageEDICandidate = (ManageEDICandidate) request.getSession().getAttribute("ManageEDICandidate");
				for (EDISearchResultVO ediSearchResult :manageEDICandidate.getEdiSearchResultVOLst() ) {
				String psWrkId = "";
				if(!CPSHelper.isEmpty(ediSearchResult.getPsWorkId())) {
					psWrkId = ediSearchResult.getPsWorkId().toString();
				} else {
					psWrkId = ediSearchResult.getPsProdId().toString();
				}
				String idRow=psWrkId+"__"+ediSearchResult.getPsProdId()+"__"+ediSearchResult.getPsVendno()+"__"+ediSearchResult.getUpcNo()+"__"+ediSearchResult.getChannel()+"__"+ediSearchResult.getPsItemId()+"__"+ediSearchResult.isActiveProductKit();
			%>
			<tr>
				<td><input type="checkbox" id="chkBoxDS+<%=idRow%>" name="selingUpcList<%=psWrkId%>"/></td>
				<td><%=ediSearchResult.getPsProdId()%></td>
				<td><%
						if(ediSearchResult.getInputSource()!=null) {
							out.print(ediSearchResult.getInputSource());
						} else {
							out.print("");
						}
					%></td>
				<td><%
						if(ediSearchResult.getStrackId()!=null) {
							out.print(ediSearchResult.getStrackId());
						} else {
							out.print("");
						}
					%></td>
				<td><%=ediSearchResult.getSubmitDate()%></td>
				<td><%=ediSearchResult.getStatusValue()%></td>
				<td><%=ediSearchResult.getPsVendno()+" "+CPSHelper.showEmptyWhenNull(ediSearchResult.getPsVendName())%></td>
				<td><%=CPSHelper.displaySellingUPC(ediSearchResult.getUpcNo())%></td>
				<td><%=CPSHelper.displayNativeString(CPSHelper.showEmptyWhenNull(ediSearchResult.getSellingUPCDetailVO().getDescription()).toUpperCase())%></td>
				<td><%=ediSearchResult.getSellingUPCDetailVO().getBdmCode()+" "+CPSHelper.showEmptyWhenNull(ediSearchResult.getSellingUPCDetailVO().getBdmName())%></td>
				<td><%=ediSearchResult.getSellingUPCDetailVO().getDeptNbr() +""+ ediSearchResult.getSellingUPCDetailVO().getSubDeptCode()%></td>
				<td><%=ediSearchResult.getSellingUPCDetailVO().getSubComName()+" "+"["+ediSearchResult.getSellingUPCDetailVO().getSubComCode()+"]"%></td>
				<td><%=ediSearchResult.getSellingUPCDetailVO().getBrandCode()+" "+CPSHelper.showEmptyWhenNull(ediSearchResult.getSellingUPCDetailVO().getBrandName())%></td>
				<td><%=ediSearchResult.getSellingUPCDetailVO().getSubBrandCode()+" "+CPSHelper.showEmptyWhenNull(ediSearchResult.getSellingUPCDetailVO().getSubBrandName())%></td>
				<td><%=ediSearchResult.getSellingUPCDetailVO().getCostOwnerCode()+" "+CPSHelper.showEmptyWhenNull(ediSearchResult.getSellingUPCDetailVO().getCostOwnerName())%></td>
				<!--BINHHT add-->
				<td><%
						if(ediSearchResult.getSellingUPCDetailVO().getTaxCategoryCode()!=null && !"".equals(ediSearchResult.getSellingUPCDetailVO().getTaxCategoryCode())) {
							out.print(ediSearchResult.getSellingUPCDetailVO().getTaxCategoryName());
						}
					%></td>
				<td><%=ediSearchResult.getSellingUPCDetailVO().getItemCategoryCode()+" "+CPSHelper.showEmptyWhenNull(ediSearchResult.getSellingUPCDetailVO().getItemCategoryName())%></td>
				<td id="subComHd<%=idRow%>">0</td>
				<td id="taxCatHd<%=idRow%>">0</td>
				<td><%=ediSearchResult.getStatus()%></td>
				<td><%=idRow%></td>
				<td><%
						if(ediSearchResult.isDisable() || String.valueOf(ediSearchResult.getCandidateSw()).toUpperCase().equals("N")) {
							out.print("true");
						} else {
							out.print("false");
						}
					%></td>
			</tr>
		<%}%>
	</tbody>
</table>
</div>
<div id="tblYuiContent" style="width:100%;z-index:15000;">
</div>
<div id="paginate" style="font-family:arial; font-size:10px;"></div>


<script type="text/javascript">
<c:url value="${request.getContextPath()}/hebAssets/images/dropdown.bmp" var="image"></c:url>
var Ex = YAHOO.namespace('Heb.TableSellingUpc');

Ex.isChangeRequest=false;

Ex.filterItemReturn = []; 

	var valuesTaxAuto=[];	
	var valuesAuto=[];		
	function getSubCommAutoComplete(data)
	{
		
		var temArr=[];
		if(data.length >0)
		{					
			for (var i = 0; i < data.length; i++) 
			{						
				temArr.push([data[i].name,data[i].id]);
			}
			
		}
		valuesAuto=temArr;
	}
	//BINHHT ADD
	function getTaxCategoryAutoComplete(data)
	{
		var temArr=[];
		if(data.length >0)
		{					
			for (var i = 0; i < data.length; i++) 
			{						
				temArr.push([data[i].name,data[i].id]);
			}
			
		}
		valuesTaxAuto=temArr;
	}

	function loadTable()
	{
				Ex.initLstObjFilter();
				ManageEDIDWR.getAllSubCommodities(getDWRCallbackMethod(getSubCommAutoComplete));
				ManageEDIDWR.getAllTaxCategories(getDWRCallbackMethod(getTaxCategoryAutoComplete));
				Ex.initDataTable();
	}
	Ex.dataSourceTemp=[];
	
	Ex.initDataTable =function ()
		{			
		var formatAutocomplete = function(elCell, oRecord, oColumn, sData) 
		{
			 var comp = YAHOO.lang;
			 var cK=oRecord.getData("idRowHidden");
			 var isDisable =oRecord.getData("disableStatus");
			 var idRow=comp.trim(cK);			 			
			 var subCom=comp.trim(oRecord.getData("subCommodity"));
			 if(comp.trim(isDisable)=="false")
			 {				 			 
			 	elCell.innerHTML = "<div class='myAutoComplete' id='myAutoComplete"+idRow+"'><input type='text' id='myInput"+idRow+"' value='"+subCom+"' maxlength='30' style='TEXT-TRANSFORM\: uppercase; position: relative;width:130px;'\ /><div id='myContainer"+idRow+"'></div></div>";
			 }
			 else
			 {
				 elCell.innerHTML = "<div class='myAutoComplete' id='myAutoComplete"+idRow+"'><input type='text' id='myInput"+idRow+"' value='"+subCom+"' maxlength='30'  style='TEXT-TRANSFORM\: uppercase; position: relative;width:130px;' class='disabled-text' readonly='readonly'\ /><div id='myContainer"+idRow+"'></div></div>";
			 }
        };
		
		var formatTaxAutocomplete = function(elCell, oRecord, oColumn, sData) 
		{
			 var comp = YAHOO.lang;
			 var cK=oRecord.getData("idRowHidden");
			 var isDisable =oRecord.getData("disableStatus");
			 var idRow=comp.trim(cK);			 			
			 var taxCat=comp.trim(oRecord.getData("taxCategory"));
			 if(comp.trim(isDisable)=="false")
			 {				 			 
			 	elCell.innerHTML = "<div class='myAutoComplete' id='taxAutoComplete"+idRow+"'><input type='text' <c:if test="${renderView == 'V'}"> disabled </c:if> id='taxInput"+idRow+"' value='"+taxCat+"' maxlength='30' style='TEXT-TRANSFORM\: uppercase; position: relative;width:130px;' <c:if test="${renderView == 'V'}"> class='disabled-text' readonly='readonly' </c:if>\ /><div id='taxContainer"+idRow+"'></div></div>";
			 }
			 else
			 {
				 elCell.innerHTML = "<div class='myAutoComplete' id='taxAutoComplete"+idRow+"'><input type='text' id='taxInput"+idRow+"' value='"+taxCat+"' maxlength='30'  style='TEXT-TRANSFORM\: uppercase; position: relative;width:130px;' class='disabled-text' readonly='readonly'\ /><div id='taxContainer"+idRow+"'></div></div>";
			 }	
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

		var sortInputSource = function(a, b, desc) {           
            return sortCompare(a, b, desc, "inputSource", "sellingUpc", false); 
        };
		var sortTrackingId = function(a, b, desc) {           
            return sortCompare(a, b, desc, "trackingId", "sellingUpc", false); 
        };
		
		var sortSubmitDate = function(a, b, desc) {           
            return sortCompare(a, b, desc, "submissionDate", "sellingUpc", false);
        };
		
		var sortStatus = function(a, b, desc) {           
            return sortCompare(a, b, desc, "status", "sellingUpc", false);
        };
		
		var sortVendor = function(a, b, desc) {           
            return sortCompare(a, b, desc, "vendor", "sellingUpc", false);
        };
		
		var sortSellingUpc = function(a, b, desc) {            
            return sortCompare(a, b, desc, "sellingUpc", "vendor", false);
        };
		
		var sortDescription = function(a, b, desc) {           
            return sortCompare(a, b, desc, "description", "sellingUpc", false);
        };
		
		var sortBDM = function(a, b, desc) {            
            return sortCompare(a, b, desc, "bdm", "sellingUpc", false);
        };
		
		var sortSubDept = function(a, b, desc) {           
            return sortCompare(a, b, desc, "subDept", "sellingUpc", false);
        };
		
		var sortSubCommodity = function(a, b, desc) {            
            return sortCompare(a, b, desc, "subCommodity", "sellingUpc", false);
        };
		
		var sortBrand = function(a, b, desc) {           
            return sortCompare(a, b, desc, "brand", "sellingUpc", false);
        };
		
		var sortSubBrand = function(a, b, desc) {           
            return sortCompare(a, b, desc, "subBrand", "sellingUpc", false);
            
        };
		
		var sortCostOwner = function(a, b, desc) {            
            return sortCompare(a, b, desc, "costOwner", "sellingUpc", false);
        };
		
		var sortTaxCategory = function(a, b, desc) {            
            return sortCompare(a, b, desc, "taxCategory", "sellingUpc", false);
        };
		
		var sortItemCategory = function(a, b, desc) {           
            return sortCompare(a, b, desc, "itemCategory", "sellingUpc", false);
        };
		
		var myRowFormatter = function(elTr, oRecord) {   
				var comp = YAHOO.lang;				
				if ((oRecord.getData('subComHidden') !="" && comp.trim(oRecord.getData('subComHidden'))!="0") || (oRecord.getData('taxCatHidden') !="" && comp.trim(oRecord.getData('taxCatHidden'))!="0")) {   
					
					YAHOO.util.Dom.addClass(elTr, 'mark');   
				}   
				return true;   
			};
		
			Ex.myColumnDefs = [ {key:"checkBoxs",label:"All",width: 23, minWidth: 23,children: [{key:"checkBox", label:"<input type='checkbox' id='SelectAll'/>"}]},
			                     {key:"productID"},
								 {key:"inputSources",label:"Input<br/>Source",width: 40,sortable:true,sortOptions:{sortFunction:sortInputSource},
									children: [{key:"inputSource", label:"<div id='inputSourceDiv' class ='myAutoComplete'><input type='text' id='inputSourceFilter' name='divFilterSel' size='1' style='TEXT-TRANSFORM\: uppercase; position: relative;'\/><img src='${image}' alt='' width='20' id='inputSourceFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerInputSourceFilter'></div></div>",sortable:false, resizeable:false}]},	
	                             {key:"trackingIds",label:"Tracking<br/>ID",width: 35,sortable:true,sortOptions:{sortFunction:sortTrackingId},
									children: [{key:"trackingId", label:"<div id='trackingIdDiv'><input type='text' id='trackIdFilter' name='divFilterSel' size='2'\/></div>",sortable:false, resizeable:false}]},  
	                             {key:"submissionDates",    label:"Submission<br/>Date",sortable:true,width: 70,sortOptions:{sortFunction:sortSubmitDate},
									children: [{key:"submissionDate", label:"<div id='submissionDateDiv' class ='myAutoComplete'><input type='text' id='submiDateFilter' name='divFilterSel' size='5' style='TEXT-TRANSFORM\: uppercase; position: relative;'\/><img src='${image}' alt='' width='20' id='submiDateFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerSubmiDateFilter'></div></div>",sortable:false, resizeable:false}]},
	                             {key:"statusCand ",    label:"Status",sortable:true,width: 112,sortOptions:{sortFunction:sortStatus},
									children: [{key:"status", label:"<div id='statusDiv' class ='myAutoComplete'><input type='text' id='statusFilter' name='divFilterSel' size='4' style='TEXT-TRANSFORM\: uppercase; position: relative;'\/><img src='${image}' alt='' width='20' id='statusFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerStatusFilter'></div></div>",sortable:false, resizeable:false}]},
	                             {key:"vendors",    label:"Vendor",sortable:true,width: 150,sortOptions:{sortFunction:sortVendor},
									children: [{key:"vendor", label:"<div id='vendorDiv' class ='myAutoComplete'><input type='text' id='vendorFilter' name='divFilterSel' size='20' style='TEXT-TRANSFORM\: uppercase; position: relative;'\/><img src='${image}' alt='' width='20' id='vendorFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerVendorFilter'></div></div>",sortable:false,resizeable:false}]},
	                             {key:"sellingUpcs",label:"Selling UPC",sortable:true,width: 100,sortOptions:{sortFunction:sortSellingUpc},
									children: [{key:"sellingUpc", label:"<div id='sellingUpc' class ='myAutoComplete'><input type='text' id='sellingUpcFilter' name='divFilterSel' size='10' style='TEXT-TRANSFORM\: uppercase; position: relative;' align='left'\/><img src='${image}' alt='' width='20' id='sellingUpcFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerSellingUpcFilter'></div></div>",sortable:false, resizeable:false}]},
	                             {key:"descriptions",label:"Description",sortable:true,width: 120,sortOptions:{sortFunction:sortDescription},
									children: [{key:"description", label:"<div id='descriptionDiv'><input type='text' id='descriptionFilter' name='divFilterSel' size='15'\/></div>",sortable:false, resizeable:false}]},
	                             {key:"bdms",label:"BDM",sortable:true,width: 135,sortOptions:{sortFunction:sortBDM},
									children: [{key:"bdm", label:"<div id='bdmDiv' class ='myAutoComplete'><input type='text' id='bdmFilter' name='divFilterSel' size='10' style='TEXT-TRANSFORM\: uppercase; position: relative;'\/><img src='${image}' alt='' width='20' id='bdmFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerBdmFilter'></div></div>",sortable:false,  resizeable:false}]},
	                             {key:"subDepts",label:"Dept",sortable:true,width: 35,sortOptions:{sortFunction:sortSubDept},
									children: [{key:"subDept", label:"<div id='subDeptDiv' class ='myAutoComplete'><input type='text' id='subDeptFilter' size='1' name='divFilterSel' style='TEXT-TRANSFORM\: uppercase; position: relative;'\/><img src='${image}' alt='' width='20' id='subDeptFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerSubDeptFilter'></div></div>",sortable:false, resizeable:false}]},
	                             {key:"subCommoditys",label:"Sub Commodity",sortable:true,width: 140,sortOptions:{sortFunction:sortSubCommodity},
									children: [{key:"subCommodity", label:"<div id='subCommodityDiv'><input type='text' id='subCommodityFilter' name='divFilterSel'\/></div>",sortable:false, resizeable:false,formatter:formatAutocomplete}]},
	                             {key:"brands",label:"Brand",sortable:true,width: 92, sortOptions:{sortFunction:sortBrand},
									children: [{key:"brand", label:"<div id='brandDiv' class ='myAutoComplete'><input type='text' id='brandFilter' name='divFilterSel' size='10' style='TEXT-TRANSFORM\: uppercase; position: relative;'\/><img src='${image}' alt='' width='20' id='brandFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'/><div id='myContainerBrandFilter'></div></div>",sortable:false, resizeable:false}]},
	                             {key:"subBrands",label:"Sub Brand",sortable:true,width: 80,sortOptions:{sortFunction:sortSubBrand},
									children: [{key:"subBrand", label:"<div id='subBrandDiv'><input type='text' id='subBrandFilter' name='divFilterSel' size='10'\/></div>",sortable:false, resizeable:false}]},
	                             {key:"costOwners",label:"Cost Owner",sortable:true,width: 130,sortOptions:{sortFunction:sortCostOwner},
									children: [{key:"costOwner", label:"<div id='costOwnerDiv'><input type='text' id='costOwnerFilter' name='divFilterSel'\/></div>",sortable:false, resizeable:false}]},
								 {key:"taxCategories",label:"Tax Category",sortable:true,width: 140,sortOptions:{sortFunction:sortTaxCategory},
									 hidden : <c:if test="${renderView == 'N'}">true </c:if><c:if test="${renderView != 'N'}">false </c:if>,
									 children: [{key:"taxCategory", label:"<div id='taxCategoryDiv'><input type='text' id='taxCategoryFilter'  name='divFilterSel'\/></div>",sortable:false, resizeable:false,formatter:formatTaxAutocomplete}]},
								 {key:"itemCategorys",label:"Item Category",sortable:true,width: 210,sortOptions:{sortFunction:sortItemCategory},
									children: [{key:"itemCategory", label:"<table class='tbl-filter'><tr><td width='60%' class='td-filter' valign='bottom'><div id='itemCategory' class ='myAutoComplete'><input type='text' id='itemCategoryFilter'  name='divFilterSel' style='TEXT-TRANSFORM\: uppercase; position: relative;'\/><img src='${image}' alt='' width='20' id='itemCategoryFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-5px;'/><div id='myContainerItemCategoryFilter'></div></div></td><td class='td-filter' align='right'><input type='button' id='filterStatus' value='Hide'\/><input type='button' id='clearSelFilter' value='Clear'\/></td></tr></table>",sortable:false,resizeable:false}]},
								  {key:"subComHidden"},
								  {key:"taxCatHidden"},
								  {key:"statusHidden"},
								  {key:"idRowHidden"},
								  {key:"disableStatus"}							  
	                             ];  
		 Ex.myDataSource = new YAHOO.util.DataSource(YAHOO.util.Dom.get("tableSellingContent"),
				{
					responseType : YAHOO.util.DataSource.TYPE_HTMLTABLE,
					responseSchema : {
						fields: [ {key:"checkBox"},
						             {key:"productID"},
									 {key:"inputSource"},
		                             {key:"trackingId"},  
		                             {key:"submissionDate"},
		                             {key:"status"},
		                             {key:"vendor"},
		                             {key:"sellingUpc"},
		                             {key:"description"},
		                             {key:"bdm"},
		                             {key:"subDept"},
		                             {key:"subCommodity"},
		                             {key:"brand"},
		                             {key:"subBrand"},
		                             {key:"costOwner"},
		                             {key:"taxCategory"},
									 {key:"itemCategory"},
									 {key:"subComHidden"},
									 {key:"taxCatHidden"},
									 {key:"statusHidden"},
									 {key:"idRowHidden"},
									 {key:"disableStatus"}		
		                             ]
					},
					doBeforeCallback : function (req,raw,res,cb) {
						// This is the filter function								
						var data     = res.results || [],
							filtered = [],
							i,l;
						if(Ex.dataSourceTemp.length==0)
						{							
							Ex.dataSourceTemp=data;
						}	
						//var factories = document.getElementsByName("factoryList");				
						var i = 0;	
						var comp = YAHOO.lang;

						if(SER.itemResultFilter != null && SER.itemResultFilter != "")
						{				
							var resultFilter = SER.itemResultFilter.split(",");
							if(resultFilter.length > 0 && Ex.filterItemReturn.length == 0){
								for (i = 0; i< Ex.dataSourceTemp.length; i++) 
								{
									var value  = comp.trim(Ex.dataSourceTemp[i].sellingUpc) + "_" + comp.trim(Ex.dataSourceTemp[i].idRowHidden.split("__")[5]) + "_" + comp.trim(Ex.dataSourceTemp[i].idRowHidden.split("__")[2]);
									
									if(resultFilter.inArray(value)){
										Ex.filterItemReturn.push(Ex.dataSourceTemp[i]);
									}
								}					
							}
							res.results = Ex.filterItemReturn;				
						}
									
						if (req) {		
									var temp="";
									if(SER.itemResultFilter != null && SER.itemResultFilter != "" && Ex.filterItemReturn.length >0){
										for (i = 0; i< Ex.filterItemReturn.length; i++) 
										{
											temp="";	
											temp=Ex.filterItemReturn[i].inputSource.toUpperCase()+"__"+Ex.filterItemReturn[i].trackingId.toUpperCase()+"__"+SER.convertFromIrToRegularPattern(Ex.filterItemReturn[i].submissionDate.toUpperCase())+"__"+Ex.filterItemReturn[i].status.toUpperCase()+"__"+SER.convertFromIrToRegularPattern(Ex.filterItemReturn[i].vendor.toUpperCase())+"__"+Ex.filterItemReturn[i].sellingUpc.toUpperCase()+"__"+SER.convertFromIrToRegularPattern(Ex.filterItemReturn[i].description.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(Ex.filterItemReturn[i].bdm.toUpperCase())+"__"+Ex.filterItemReturn[i].subDept.toUpperCase()+"__"+SER.convertFromIrToRegularPattern(Ex.filterItemReturn[i].subCommodity.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(Ex.filterItemReturn[i].brand.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(Ex.filterItemReturn[i].subBrand.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(Ex.filterItemReturn[i].costOwner.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(Ex.filterItemReturn[i].taxCategory.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(Ex.filterItemReturn[i].itemCategory.toUpperCase());																											
											var pattern = new RegExp(req);			
											if(pattern.test(temp))
											{								
												filtered.push(Ex.filterItemReturn[i]);			
											}
										}
									}
									else
									{										
										for (i = 0, l = Ex.dataSourceTemp.length; i < l; ++i) 
										{										
											temp="";																	
											temp=Ex.dataSourceTemp[i].inputSource.toUpperCase()+"__"+Ex.dataSourceTemp[i].trackingId.toUpperCase()+"__"+SER.convertFromIrToRegularPattern(Ex.dataSourceTemp[i].submissionDate.toUpperCase())+"__"+Ex.dataSourceTemp[i].status.toUpperCase()+"__"+SER.convertFromIrToRegularPattern(Ex.dataSourceTemp[i].vendor.toUpperCase())+"__"+Ex.dataSourceTemp[i].sellingUpc.toUpperCase()+"__"+SER.convertFromIrToRegularPattern(Ex.dataSourceTemp[i].description.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(Ex.dataSourceTemp[i].bdm.toUpperCase())+"__"+Ex.dataSourceTemp[i].subDept.toUpperCase()+"__"+SER.convertFromIrToRegularPattern(Ex.dataSourceTemp[i].subCommodity.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(Ex.dataSourceTemp[i].brand.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(Ex.dataSourceTemp[i].subBrand.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(Ex.dataSourceTemp[i].costOwner.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(Ex.dataSourceTemp[i].taxCategory.toUpperCase())+"__"+SER.convertFromIrToRegularPattern(Ex.dataSourceTemp[i].itemCategory.toUpperCase());																				
											var pattern = new RegExp(req);			
											if(pattern.test(temp))
											{													
												filtered.push(Ex.dataSourceTemp[i]);			
											}						
										}
									}
								
								res.results = filtered;	
								
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
					}
					
				});	
				Ex.myConfigs = {
		            	paginator: new YAHOO.widget.Paginator({
		                rowsPerPage: parseInt(SER.currentRecord),
		                template: YAHOO.widget.Paginator.TEMPLATE_ROWS_PER_PAGE,						
		                rowsPerPageOptions: [10,25,50,100],
		                pageLinks: 5,
						containers:paginate	
		            }),
		            draggableColumns:false,	
					height:"220px",
					formatRow: myRowFormatter
		        }

		        
		 
		Ex.myDataTable = new YAHOO.widget.ScrollingDataTable("tblYuiContent", Ex.myColumnDefs, Ex.myDataSource, Ex.myConfigs);
		
		//get data of each field to array
		
		//set autocomplete for filter	
		
		setDataSourceForAutocompleteFilter();
		
		var cnt=0;

	
		for(var i=0;i < Ex.arrSellingIdObj.length;i++)
		{			
			
			//set autocomplete for field requested
			if(i == 1 || i == 6 || i==9 || i ==11 || i ==12 || i ==13)
			{				
				continue;
			}
						
			setAutoCompleteForFilter("myContainer"+Ex.arrSellingIdObj[i].capitaliseFirstLetter(Ex.arrSellingIdObj[i]),Ex.arrSellingIdObj[i],cnt++);
			if(i!=14)
			{
				document.getElementById(Ex.arrSellingIdObj[i]).parentNode.parentNode.parentNode.style.overflow = 'visible';
			}	
			else
			{
				if (document.getElementById("yui-dt0-th-itemCategory-liner")) {
					document.getElementById("yui-dt0-th-itemCategory-liner").style.overflow = 'visible';
				}
			}
			
		}
		
						
		Ex.myDataTable.hideColumn(Ex.myDataTable.getColumn("subComHidden"));
		Ex.myDataTable.hideColumn(Ex.myDataTable.getColumn("taxCatHidden"));
		Ex.myDataTable.hideColumn(Ex.myDataTable.getColumn("productID"));
		Ex.myDataTable.hideColumn(Ex.myDataTable.getColumn("statusHidden"));		
		Ex.myDataTable.hideColumn(Ex.myDataTable.getColumn("idRowHidden"));
		Ex.myDataTable.hideColumn(Ex.myDataTable.getColumn("disableStatus"));		

		var changeRequest = false;
		
			YAHOO.util.Dom.get("tableSellingContent").style.display = 'none';
			
			filterTimeout = null;
			updateFilter  = function () 
			{
				filterTimeout = null;
				var pattent = gePattern();
				Ex.myDataSource.sendRequest(pattent,{
					success : Ex.myDataTable.onDataReturnInitializeTable,
					failure : Ex.myDataTable.onDataReturnInitializeTable,
					scope   : Ex.myDataTable,
					argument: pattent	
				});
			}
						
		 Ex.myDataTable.doBeforeLoadData = function( sRequest , oResponse ) 
			 {
			  //window.parent.execScript('hideProgress();', "JavaScript");
				
			  return true;
			 };					
						
		Ex.myDataTable.on('theadCellClickEvent', function (oArgs) {
    		var target = oArgs.target,
    			column = this.getColumn(target),
    			actualTarget = YAHOO.util.Event.getTarget(oArgs.event),
    			check = actualTarget.checked;
				    		
    		if (column.key == 'checkBox') {
    			if(typeof check != 'undefined'){
	    			var oRS = Ex.myDataTable.getRecordSet();
					//get current record
					var arrCurentRecordsId = new Array();
	    			for(var i=0; i<oRS.getLength(); i++) {
	   	                var oRec = oRS.getRecord(i);
						var comp = YAHOO.lang;					
						var cK=oRec.getData("idRowHidden");							
						var idRow=comp.trim(cK);			
						var arrTemp=idRow.split("__");
						var tempPsWrkId=arrTemp[0];	
						arrCurentRecordsId.push(tempPsWrkId);	
						var idRowAc="chkBoxDS+"+idRow;						
						if(check)
							{								
								oRec.setData("checkBox","<input id="+idRowAc+" type=checkbox CHECKED name='selingUpcList"+idRow.split('__')[0]+ "'class=yui-dt-checkbox />"); 
							}
						else
							oRec.setData("checkBox","<input id="+idRowAc+" type=checkbox name='selingUpcList"+idRow.split('__')[0]+ "' class=yui-dt-checkbox />");
							
	       				   
	    			}
					changeDataSourceTempWhenCheckAll(check,arrCurentRecordsId);
					changeRequest=true;
	    			this.render();
    			}
    		}

    	});	
			
		
        Ex.myDataTable.subscribe("initEvent", function(){changeRequest = true;});
		Ex.myDataTable.subscribe("postRenderEvent", function(){
		var elements = YAHOO.util.Dom.getElementsByClassName('yui-dt-bd', 'div')[0];
		
			if(elements!=null)
			{
				var beforeScroll = elements.scrollLeft;				
				elements.scrollLeft = beforeScroll;
			}	
		});		
        Ex.myDataTable.subscribe("columnSortEvent", function(){changeRequest = true; });
        Ex.myDataTable.get('paginator').on( 'changeRequest', function () {
            var cur = Ex.myDataTable.get('paginator').getState();
            SER.currentRecord = cur.rowsPerPage;
            SER.currentPage = cur.page;
            changeRequest = true;
            console.log('page: '+cur.page);
        } );
        Ex.myDataTable.on('renderEvent', function () {

       	var oRS = Ex.myDataTable.getRecordSet();
   		var isCheckFlag = false;
   		for(var i = 0;i< oRS.getLength();i++)
   		{
   			var oRec = oRS.getRecord(i);									
   			var cK=oRec.getData("checkBox");
   			var bChecked = cK.split("CHECKED");
   			//if check						
   			bChecked = (bChecked[1]) ? "checked" : "";
   			
   			if(bChecked!="checked")
   			{
   				isCheckFlag = true;
   				break;
   			}
   		}
   		
   		if(isCheckFlag)
   		{
   			YAHOO.util.Dom.get('SelectAll').checked = false;
   		}    
        if ( changeRequest || Ex.isChangeRequest) {
        changeRequest = false;
		Ex.isChangeRequest=false;

        /* do your thing */
			//set autocomplete for colummn is used
			
	        var cur = Ex.myDataTable.get('paginator').getState();			
	        var totalRecords = cur.totalRecords;			
            var recordInPage = cur.rowsPerPage * cur.page;						
            if(recordInPage > cur.totalRecords)
            	recordInPage = cur.totalRecords;        	
	        for (var i= (cur.page -1)* cur.rowsPerPage; i<=recordInPage-1;i++)
	        {						
				var comp = YAHOO.lang;
				var recrd=Ex.myDataTable.getRecord(i);	
				var cK=recrd.getData("idRowHidden");	
				var isDisable =recrd.getData("disableStatus");		 				
	        	var idAuto = comp.trim(cK);
	        	if(comp.trim(isDisable)=="false")		        	
	        	{
	        		setAutoComplete(idAuto,recrd);
					setTaxCategoryAutoComplete(idAuto,recrd);
	        	}	
				setZindex(idAuto,i,recordInPage);					
	        }
	        }
	      	//set total record retuned 
			var totalRecords = Ex.myDataTable.get('paginator').getState().totalRecords;					
			var itemReturn = (totalRecords < Ex.dataSourceTemp.length? " (out of " + Ex.dataSourceTemp.length + " total " + (Ex.dataSourceTemp.length>1?"items":"item") + ") returned" : " returned");			
			if(totalRecords > 1)
				YAHOO.util.Dom.get('totalSellingRecord').innerHTML = totalRecords + " items" + itemReturn;
			else
				YAHOO.util.Dom.get('totalSellingRecord').innerHTML = totalRecords + " item" + itemReturn;
        }); 	
		//set page is selected	
        Ex.myDataTable.get('paginator').setPage(parseInt(SER.currentPage));

        var evtFilter= 'change';	
	
        YAHOO.util.Event.on('inputSourceFilter',evtFilter,function (e) {
			doBeforeFilter(e)
		});

		YAHOO.util.Event.on('trackIdFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('submiDateFilter',evtFilter,function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('statusFilter',evtFilter,function (e) {	
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('vendorFilter',evtFilter,function (e) {				
			doBeforeFilter(e);
		});	
		
		YAHOO.util.Event.on('sellingUpcFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('descriptionFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('bdmFilter',evtFilter,function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('subDeptFilter',evtFilter,function (e) {	
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('subCommodityFilter',evtFilter,function (e) {	
			doBeforeFilter(e);
		});	
		
		YAHOO.util.Event.on('brandFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('subBrandFilter',evtFilter,function (e) {			
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('costOwnerFilter',evtFilter,function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('taxCategoryFilter',evtFilter,function (e) {		
			doBeforeFilter(e);
		});
		YAHOO.util.Event.on('itemCategoryFilter',evtFilter,function (e) {	
			doBeforeFilter(e);
		});	
		function doBeforeFilter(e)
		{					
				clearTimeout(filterTimeout);
				setTimeout(updateFilter,600);
				SER.hasFilter = true;			
		}

		YAHOO.util.Event.on('clearSelFilter','click',function (e) {	
			
			emptySelFilter();
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
		Ex.myDataTable.subscribe("checkboxClickEvent", function(oArgs){ 			
			var elCheckbox = oArgs.target; 
            var oRecord = this.getRecord(elCheckbox);      		
			
			changeRecordSetWhenCheck(elCheckbox.checked,elCheckbox.id);	
			changeDataSourceTempWhenCheck(elCheckbox.checked,elCheckbox.id);	
			
			if(!elCheckbox.checked){
				YAHOO.util.Dom.get('SelectAll').checked = false;
			}else{
				var chk=true;
				var allChk = document.getElementsByTagName('input');
				for(var i=0;i<allChk.length;i++){
					if(allChk[i].name.indexOf('selingUpcList')>-1){
						if(!allChk[i].checked && allChk[i].id!=elCheckbox.id){
							chk=false;
							break;
						}						
					}
				}
				YAHOO.util.Dom.get('SelectAll').checked = chk;
			}				
        });

		setFilterValue();
		
		 return {
	            oDS: Ex.myDataSource,
	            oDT: Ex.myDataTable
	       };
	};
	
	function gePattern()
	{
		var comp = YAHOO.lang;

		var lstObj = new Array();
		var lstObjVl = new Array();

		//get obj filter of selling upc tab
		for(var i = 0 ;i< Ex.arrSellingIdObj.length;i++)
		{
			lstObj.push(document.getElementById(Ex.arrSellingIdObj[i]));
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

	getSubCommoAuto = function(query)
	{		
		reslts = [];
		
	    for (var i = 0; i < valuesAuto.length; i++) {
		    var t1 = valuesAuto[i][0];
		    var t2 = query;
		    var t1Up = t1.toUpperCase();
		    var t2Up = t2.toUpperCase();
		    var v1 = valuesAuto[i][1];
		    var v1Up = v1.toUpperCase();
		    
	    	if (t1Up.match(t2Up) || v1Up.match(t2Up)) {
	    		reslts.push(valuesAuto[i]);
	    	}
	    }	   	
	    return reslts;
	};	
	
	//BINHHT -add
	getTaxCatAuto = function(query)
	{		
		reslts = [];
		
	    for (var i = 0; i < valuesTaxAuto.length; i++) {
		    var t1 = valuesTaxAuto[i][0];
		    var t2 = query;
		    var t1Up = t1.toUpperCase();
		    var t2Up = t2.toUpperCase();
		    var v1 = valuesTaxAuto[i][1];
		    var v1Up = v1.toUpperCase();
		    
	    	if (t1Up.match(t2Up) || v1Up.match(t2Up)) {
	    		reslts.push(valuesTaxAuto[i]);
	    	}
	    }	   	
	    return reslts;
	};
	
function setAutoComplete(id,record) {     
	
		var oACDS = new YAHOO.widget.DS_JSFunction(getSubCommoAuto);
	    // Instantiate first AutoComplete
	    var oAutoComp = new YAHOO.widget.AutoComplete("myInput"+id, "myContainer"+id, oACDS);
	    oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
	   // this.oAutoComp.typeAhead = true;
		oAutoComp.queryQuestionMark = false;
		oAutoComp.forceSelection = false;
		oAutoComp.autoHighlight = true;
		oAutoComp.maxResultsDisplayed = 100;
		oAutoComp.resultTypeList = false;
		oAutoComp.useIFrame = true;
		oAutoComp.minQueryLength=0;
		
		oAutoComp.doBeforeExpandContainer = function() {
		var Dom = YAHOO.util.Dom;
		Dom.setXY("myContainer"+id, [Dom.getX("myInput"+id), Dom.getY("myInput"+id) + Dom.get("myInput"+id).offsetHeight] );
		return true;
		}
		
		var curVl = YAHOO.util.Dom.get("myInput"+id).value;		
		var itemSelectHandler = function(sType, aArgs) {
			var aData = aArgs[2]; //array of the data for the item as returned by the DataSource							
			/*var elm1 = YAHOO.util.Dom.get("subComHd"+id);								
			elm1.innerHTML = html_entity_decode(aData[1]);*/

			var arrTemp = getListRowIds(id);							
			showProgress();			
 	    	ManageEDIDWR.validateDeptAndSubDept(html_entity_decode(aData[1]),"",arrTemp,
 	    	    {
 	    		  callback:function(data) {
    					hideProgress();
    					var tempData=data.appData;

    					if(tempData.message != null && tempData.message != '')
    					{
							YAHOO.util.Dom.get("myInput"+id).value = curVl;
        					alert(tempData.message);
        				}					
    					else
    					{		
							var elm1 = YAHOO.util.Dom.get("subComHd"+id);								
							elm1.innerHTML = html_entity_decode(aData[1]);
							curVl = html_entity_decode(aData[1]);
							doWhenChangeSubCommodity(id,elm1.innerHTML,aData[0],tempData);							
    					}
 	    			},
 	    			errorHandler:function(errorString, exception) {
						alert("errors at get data");
 	    				hideProgress();
 	    			},
 	   				timeout:360000
 	    		});			
			
			//YAHOO.util.Dom.addClass(Ex.myDataTable.getTrEl(record), 'mark');
			};
		
		oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
		
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
	
		
}; 	

//BINHHT -add--
function setTaxCategoryAutoComplete(id,record) {     
	
		var oACDS = new YAHOO.widget.DS_JSFunction(getTaxCatAuto);
	    // Instantiate first AutoComplete
	    var oAutoComp = new YAHOO.widget.AutoComplete("taxInput"+id, "taxContainer"+id, oACDS);
	    oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
	   // this.oAutoComp.typeAhead = true;
		oAutoComp.queryQuestionMark = false;
		oAutoComp.forceSelection = false;
		oAutoComp.autoHighlight = true;
		oAutoComp.maxResultsDisplayed = 100;
		oAutoComp.resultTypeList = false;
		oAutoComp.useIFrame = true;
		oAutoComp.minQueryLength=0;
		
		oAutoComp.doBeforeExpandContainer = function() {
		var Dom = YAHOO.util.Dom;
		Dom.setXY("taxContainer"+id, [Dom.getX("taxInput"+id), Dom.getY("taxInput"+id) + Dom.get("taxInput"+id).offsetHeight] );
		return true;
		}
		
		var curVl = YAHOO.util.Dom.get("taxInput"+id).value;		
		var itemSelectHandler = function(sType, aArgs) {
			var aData = aArgs[2];	
			var elm1 = YAHOO.util.Dom.get("taxCatHd"+id);								
			elm1.innerHTML = html_entity_decode(aData[1]);
			doWhenChangeTaxCategory(id,elm1.innerHTML,aData[0]);					
		};
		
		oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
		
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
	
		
};

function setZindex(id,position,totalInPage)
{
	if(document.getElementById("myAutoComplete"+id)!=null)
	{		
		if(document.getElementById("myAutoComplete"+id).parentNode!=null)
		{
			document.getElementById("myAutoComplete"+id).parentNode.style.zIndex=15000+(totalInPage-position)*100;
			document.getElementById("myAutoComplete"+id).parentNode.style.overflow = 'visible';
		}	
			document.getElementById("myAutoComplete"+id).style.zIndex=10000+(totalInPage-position)*100;				
	}
	
	if(document.getElementById("taxAutoComplete"+id)!=null)
	{		
		if(document.getElementById("taxAutoComplete"+id).parentNode!=null)
		{
			document.getElementById("taxAutoComplete"+id).parentNode.style.zIndex=15000+(totalInPage-position)*100;
			document.getElementById("taxAutoComplete"+id).parentNode.style.overflow = 'visible';
		}	
			document.getElementById("taxAutoComplete"+id).style.zIndex=10000+(totalInPage-position)*100;				
	}
}

function html_entity_decode(str) {
	var ta = document.createElement("textarea");
	ta.innerHTML = str.replace(/</g,"&lt;").replace(/>/g,"&gt;");
	return ta.value;
}

function doWhenChangeSubCommodity(idRw,id,name,tempData)
{
	
	//change DataTable 	
	var arrMainValue=idRw.split("__");	
	var psWrkId=arrMainValue[0];
	var comp = YAHOO.lang;
	var oRS = Ex.myDataTable.getRecordSet();				
	for(var i=0; i<oRS.getLength(); i++) {
	
		var oRec = oRS.getRecord(i);		
		var cK=oRec.getData("idRowHidden");							
		var idRow=comp.trim(cK);						
		var arrTemp=idRow.split("__");
		var tempPsWrkId=arrTemp[0];
		
		if(psWrkId==tempPsWrkId)
		{
			oRec.setData("subCommodity",name);					
			oRec.setData("subComHidden",id);
			oRec.setData("bdm",tempData.bdmCode+" "+tempData.bdmName);
			oRec.setData("subDept",tempData.subDept);
			YAHOO.util.Dom.get("subComHd"+idRow).innerHTML=id;
		}
		/*var idRowAc="chkBoxDS+"+idRow;
		if(check)
			oRec.setData("checkBox","<input id="+idRowAc+" type=checkbox CHECKED name='selingUpcList' class=yui-dt-checkbox />"); 
		else
			oRec.setData("checkBox","<input id="+idRowAc+" type=checkbox name='selingUpcList' class=yui-dt-checkbox />"); */
			

		   
	}
	
	//render table
	changeDataSourceTemp(idRw,id,name,tempData);
	Ex.isChangeRequest=true;
	Ex.myDataTable.render();

	
	//change DataSourceTemp
	
	
}

//BINHHT -add 
function doWhenChangeTaxCategory(idRw,id,name)
{
	var arrMainValue=idRw.split("__");	
	var psWrkId=arrMainValue[0];
	var comp = YAHOO.lang;
	var oRS = Ex.myDataTable.getRecordSet();				
	for(var i=0; i<oRS.getLength(); i++) {
	
		var oRec = oRS.getRecord(i);		
		var cK=oRec.getData("idRowHidden");							
		var idRow=comp.trim(cK);						
		var arrTemp=idRow.split("__");
		var tempPsWrkId=arrTemp[0];
		
		if(psWrkId==tempPsWrkId)
		{
			oRec.setData("taxCategory",name);					
			oRec.setData("taxCatHidden",id);
			YAHOO.util.Dom.get("taxCatHd"+idRow).innerHTML=id;
		}
	}
	
	//render table
	changeTaxCatDataSourceTemp(idRw,id,name);
	Ex.isChangeRequest=true;
	Ex.myDataTable.render();
}
 
function changeDataSourceTemp(idRw,id,name,tempData)
{	
	var arrMainValue=idRw.split("__");	
	var psWrkId=arrMainValue[0];	
	var comp = YAHOO.lang;
	for(var i=0;i<Ex.dataSourceTemp.length;i++)
	{		
		var idRow=comp.trim(Ex.dataSourceTemp[i].idRowHidden);																
		var arrTemp=idRow.split("__");
		var tempPsWrkId=arrTemp[0];		
		if(comp.trim(psWrkId)==comp.trim(tempPsWrkId))
		{
			Ex.dataSourceTemp[i].subComHidden=id;	
			Ex.dataSourceTemp[i].subCommodity=name;	
			Ex.dataSourceTemp[i].bdm = tempData.bdmCode+" "+tempData.bdmName;
			Ex.dataSourceTemp[i].subDept=tempData.subDept
		}
	}
		
}

//BINHHT -- add
function changeTaxCatDataSourceTemp(idRw,id,name)
{	
	var arrMainValue=idRw.split("__");	
	var psWrkId=arrMainValue[0];	
	var comp = YAHOO.lang;
	for(var i=0;i<Ex.dataSourceTemp.length;i++)
	{		
		var idRow=comp.trim(Ex.dataSourceTemp[i].idRowHidden);																
		var arrTemp=idRow.split("__");
		var tempPsWrkId=arrTemp[0];		
		if(comp.trim(psWrkId)==comp.trim(tempPsWrkId))
		{
			Ex.dataSourceTemp[i].taxCatHidden=id;	
			Ex.dataSourceTemp[i].taxCategory=name;	
		}
	}		
}

function changeDataSourceTempWhenCheck(isCheck,id)
{
	//var ck=document.getElementById(id);		
	var mainInfo=id.substring(9,id.length);	
	var sliptArr=mainInfo.split("__");
	var psWrkId=sliptArr[0];
	var comp = YAHOO.lang;	
	for(var i=0;i<Ex.dataSourceTemp.length;i++)
	{			
		var idRow=comp.trim(Ex.dataSourceTemp[i].idRowHidden);														
		var arrTemp=idRow.split("__");
		var tempPsWrkId=arrTemp[0];		
		if(comp.trim(psWrkId)==comp.trim(tempPsWrkId))
			{				
				var idRowAc="chkBoxDS+"+idRow;
				if(isCheck)
				{
					Ex.dataSourceTemp[i].checkBox ="<input id="+idRowAc+" type=checkbox CHECKED name='selingUpcList"+comp.trim(tempPsWrkId)+"' class=yui-dt-checkbox />"; 				
				}
				else
				{
					Ex.dataSourceTemp[i].checkBox="<input id="+idRowAc+" type=checkbox name='selingUpcList"+comp.trim(tempPsWrkId)+"' class=yui-dt-checkbox />";
				}	
			}			
	}
	
}

function changeRecordSetWhenCheck(isCheck,id)
{	
	var mainInfo=id.substring(9,id.length);
	var sliptArr=mainInfo.split("__");
	var psWrkId=sliptArr[0];
	var comp = YAHOO.lang;			
	var oRS = Ex.myDataTable.getRecordSet();	
	for(var i=0; i<oRS.getLength(); i++) {
		var oRec = oRS.getRecord(i);		
		var cK=oRec.getData("idRowHidden");							
		var idRow=comp.trim(cK);														
		var arrTemp=idRow.split("__");
		var tempPsWrkId=arrTemp[0];
		
		if(psWrkId==tempPsWrkId)
		{			
			var idRowAc="chkBoxDS+"+idRow;			
			if(isCheck)
				oRec.setData("checkBox","<input id="+idRowAc+" type=checkbox CHECKED name='selingUpcList"+psWrkId+"' class=yui-dt-checkbox />"); 
			else
				oRec.setData("checkBox","<input id="+idRowAc+" type=checkbox name='selingUpcList"+psWrkId+"' class=yui-dt-checkbox />");			
		}	
	}
	//Ex.isChangeRequest=true;
	//Ex.myDataTable.render();	
	var checkBoxs = document.getElementsByName("selingUpcList"+psWrkId);
	if(checkBoxs != null){			
		for(i=0;i<checkBoxs.length;i++)
		{					
			checkBoxs[i].checked = isCheck;					
		}
	} 
}

//=============BEGIN HIDE AND DISPLAY FILTER=============//
		YAHOO.util.Event.on('filterStatus','click',function (e) {				
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
					document.getElementById("yui-dt0-fixedth-subCommoditys").style.width = 150;
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
		});
		//=============END HIDE AND DISPLAY FILTER=============//
		
	//=====================BEGIN SHOW MESSAGE WHEN NO DATA UPDATE====================//	
	Ex.showMess=function()
	{
		YAHOO.util.Dom.get('saveResult').innerHTML ="<span style='color: green;'><b> No data change to update </b></span>";
	}

	//=====================END SHOW MESSAGE WHEN NO DATA UPDATE====================//
	
	//=====================BEGIN HIDE MESSAGE WHEN NO DATA UPDATE====================//	
	Ex.hideMess=function()
	{
		YAHOO.util.Dom.get('saveResult').innerHTML ="";
	}

	//=====================END HIDE MESSAGE WHEN NO DATA UPDATE====================//
	
	
	//====================BEGIN CLEAR HEADER OF YUI SELLING UPC TABLE WHEN RESET=====================//
	Ex.clearSelTable = function()
	{
		document.getElementById("SelectAll").checked=false;
		emptySelFilter();	
	}
	//====================END CLEAR HEADER OF YUI SELLING UPC TABLE WHEN RESET=====================//
	 
	function emptySelFilter()
	{
		document.getElementById("inputSourceFilter").value='';
		document.getElementById("trackIdFilter").value='';
		document.getElementById("submiDateFilter").value='';
		document.getElementById("statusFilter").value='';
		document.getElementById("vendorFilter").value='';
		document.getElementById("sellingUpcFilter").value='';
		document.getElementById("descriptionFilter").value='';
		document.getElementById("bdmFilter").value='';
		document.getElementById("subDeptFilter").value='';
		document.getElementById("subCommodityFilter").value='';
		document.getElementById("brandFilter").value='';
		document.getElementById("subBrandFilter").value='';
		document.getElementById("costOwnerFilter").value='';
		document.getElementById("taxCategoryFilter").value='';
		document.getElementById("itemCategoryFilter").value='';	
	}
	
	new YAHOO.widget.Button("filterStatus"); 
	new YAHOO.widget.Button("clearSelFilter"); 
 
 //=============BEGIN=======CHANGE DATASOURCETEMP WHEN CLICK SELECT ALL========================================//
 
 function changeDataSourceTempWhenCheckAll(isCheck,arrCurentRecordsId)
	{					
		var comp = YAHOO.lang;	
		for(var i=0;i<Ex.dataSourceTemp.length;i++)
		{
			
				var idRow =comp.trim(Ex.dataSourceTemp[i].idRowHidden);	
				var arrTemp=idRow.split("__");
				var tempPsWrkId=arrTemp[0];		
				if(arrCurentRecordsId.inArray(tempPsWrkId))
				{					
					var idRowAc="chkBoxDS+"+idRow;					
					if(isCheck)
					{
						Ex.dataSourceTemp[i].checkBox ="<input id="+idRowAc+" type=checkbox CHECKED name='selingUpcList"+idRow.split('__')[0]+"' class=yui-dt-checkbox />"; 				
					}
					else
					{
						Ex.dataSourceTemp[i].checkBox="<input id="+idRowAc+" type=checkbox name='selingUpcList"+idRow.split('__')[0]+"' class=yui-dt-checkbox />";
					}	
				}
									
		}
		
	}

//=============END=======CHANGE DATASOURCETEMP WHEN CLICK SELECT ALL========================================//

//=============BEGIN INIT ARRAY OBJECT FILTER=================//
 Ex.arrSellingIdObj =new Array();
 Ex.initLstObjFilter = function()
	{
		Ex.arrSellingIdObj.push("inputSourceFilter");
		Ex.arrSellingIdObj.push("trackIdFilter");
		Ex.arrSellingIdObj.push("submiDateFilter");
		Ex.arrSellingIdObj.push("statusFilter");
		Ex.arrSellingIdObj.push("vendorFilter");
		Ex.arrSellingIdObj.push("sellingUpcFilter");
		Ex.arrSellingIdObj.push("descriptionFilter");
		Ex.arrSellingIdObj.push("bdmFilter");
		Ex.arrSellingIdObj.push("subDeptFilter");
		Ex.arrSellingIdObj.push("subCommodityFilter");
		Ex.arrSellingIdObj.push("brandFilter");
		Ex.arrSellingIdObj.push("subBrandFilter");
		Ex.arrSellingIdObj.push("costOwnerFilter");
		Ex.arrSellingIdObj.push("taxCategoryFilter");
		Ex.arrSellingIdObj.push("itemCategoryFilter");
	}

//=============END INIT ARRAY OBJECT FILTER=================//	

//===================BEGIN GET LIST DATA HAVE THE SAME WORK ID TO VALIDATE===================//

function  getListRowIds(idRw)
{
	var tmpArr = new Array();	
	var arrMainValue=idRw.split("__");	
	var psWrkId=arrMainValue[0];	
	var comp = YAHOO.lang;		
	for(var i=0;i<Ex.dataSourceTemp.length;i++)
	{		
		var idRow=comp.trim(Ex.dataSourceTemp[i].idRowHidden);																
		var arrTemp=idRow.split("__");
		var tempPsWrkId=arrTemp[0];		
		if(comp.trim(psWrkId)==comp.trim(tempPsWrkId))
		{
			tmpArr.push(idRow);
		}
	}
	return tmpArr;
}
//===================END GET LIST DATA HAVE THE SAME WORK ID TO VALIDATE===================//

//======================BEGIN SET AUTOCOMPLETE FOR FILTER ==============================//
	
	getSellingTabAutoFilter = function(query)
	{		
		
		var arrTemp = query.split("__");		
		var temp = arrTemp[0];
		temp = decodeURIComponent(temp);
		var po = parseInt(arrTemp[1]);			
		reslts = [];				
	    for (var i = 0; i < Ex.arrayDataFilter[po].length; i++) {
		    var t1 =Ex.arrayDataFilter[po][i];
		    var t2 = temp;
		    var t1Up = t1.toUpperCase();
		    var t2Up = t2.toUpperCase();
			
			if (t1Up.indexOf(t2Up) > -1) 
			{			
				reslts.push(Ex.arrayDataFilter[po][i]);
			}
			
	    }	   	
	    return reslts;
	};	

	function setAutoCompleteForFilter(idContainDiv,idInput,fldIndex)
	{					
		var oACDS = new YAHOO.widget.DS_JSFunction(getSellingTabAutoFilter);
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
//==========================END SET AUTOCOMPLETE FOR FILTER==============================//

//==========================BEGIN SET DATASOURCE FOR FILTER========================//
function setDataSourceForAutocompleteFilter()
{
	Ex.arrayDataFilter = [];
	
	for(var i = 0 ;i< 9 ; i++)
	{
		Ex.arrayDataFilter[i] = [];
	}


	if(SER.itemResultFilter != null && SER.itemResultFilter != "")
	{				
		if(Ex.filterItemReturn.length > 0){
			for (var i = 0; i< Ex.filterItemReturn.length; i++) 
			{					
				if(!(Ex.arrayDataFilter[0]).inArray(Ex.filterItemReturn[i].inputSource) && Ex.filterItemReturn[i].inputSource!='')
				{
					Ex.arrayDataFilter[0].push(Ex.filterItemReturn[i].inputSource);
				}	
				
				if(!(Ex.arrayDataFilter[1]).inArray(Ex.filterItemReturn[i].submissionDate) && Ex.filterItemReturn[i].submissionDate!='')
				{
					Ex.arrayDataFilter[1].push(Ex.filterItemReturn[i].submissionDate);
				}	
				
				if(!(Ex.arrayDataFilter[2]).inArray(Ex.filterItemReturn[i].status) && Ex.filterItemReturn[i].status!='')
				{
					Ex.arrayDataFilter[2].push(Ex.filterItemReturn[i].status);
				}
				
				if(!(Ex.arrayDataFilter[3]).inArray(Ex.filterItemReturn[i].vendor) && Ex.filterItemReturn[i].vendor!='')
				{
					Ex.arrayDataFilter[3].push(Ex.filterItemReturn[i].vendor);
				}
				
				if(!(Ex.arrayDataFilter[4]).inArray(Ex.filterItemReturn[i].sellingUpc) && Ex.filterItemReturn[i].sellingUpc!='')
				{
					Ex.arrayDataFilter[4].push(Ex.filterItemReturn[i].sellingUpc);
				}
				
				if(!(Ex.arrayDataFilter[5]).inArray(Ex.filterItemReturn[i].bdm) && Ex.filterItemReturn[i].bdm!='')
				{
					Ex.arrayDataFilter[5].push(Ex.filterItemReturn[i].bdm);
				}
				
				if(!(Ex.arrayDataFilter[6]).inArray(Ex.filterItemReturn[i].subDept) && Ex.filterItemReturn[i].subDept!='')
				{
					Ex.arrayDataFilter[6].push(Ex.filterItemReturn[i].subDept);
				}
				
				if(!(Ex.arrayDataFilter[7]).inArray(Ex.filterItemReturn[i].brand) && Ex.filterItemReturn[i].brand!='')
				{
					Ex.arrayDataFilter[7].push(Ex.filterItemReturn[i].brand);
				}
				
				if(!(Ex.arrayDataFilter[8]).inArray(Ex.filterItemReturn[i].itemCategory) && Ex.filterItemReturn[i].itemCategory!='')
				{
					Ex.arrayDataFilter[8].push(Ex.filterItemReturn[i].itemCategory);
				}	
			}				
		}							
	}
	else
	{
		for(var i = 0;i < Ex.dataSourceTemp.length; i++)
		{
				if(!(Ex.arrayDataFilter[0]).inArray(Ex.dataSourceTemp[i].inputSource) && Ex.dataSourceTemp[i].inputSource!='')
				{
					Ex.arrayDataFilter[0].push(Ex.dataSourceTemp[i].inputSource);
				}	
				
				if(!(Ex.arrayDataFilter[1]).inArray(Ex.dataSourceTemp[i].submissionDate) && Ex.dataSourceTemp[i].submissionDate!='')
				{
					Ex.arrayDataFilter[1].push(Ex.dataSourceTemp[i].submissionDate);
				}	
				
				if(!(Ex.arrayDataFilter[2]).inArray(Ex.dataSourceTemp[i].status) && Ex.dataSourceTemp[i].status!='')
				{
					Ex.arrayDataFilter[2].push(Ex.dataSourceTemp[i].status);
				}
				
				if(!(Ex.arrayDataFilter[3]).inArray(Ex.dataSourceTemp[i].vendor) && Ex.dataSourceTemp[i].vendor!='')
				{
					Ex.arrayDataFilter[3].push(Ex.dataSourceTemp[i].vendor);
				}
				
				if(!(Ex.arrayDataFilter[4]).inArray(Ex.dataSourceTemp[i].sellingUpc) && Ex.dataSourceTemp[i].sellingUpc!='')
				{
					Ex.arrayDataFilter[4].push(Ex.dataSourceTemp[i].sellingUpc);
				}
				
				if(!(Ex.arrayDataFilter[5]).inArray(Ex.dataSourceTemp[i].bdm) && Ex.dataSourceTemp[i].bdm!='')
				{
					Ex.arrayDataFilter[5].push(Ex.dataSourceTemp[i].bdm);
				}
				
				if(!(Ex.arrayDataFilter[6]).inArray(Ex.dataSourceTemp[i].subDept) && Ex.dataSourceTemp[i].subDept!='')
				{
					Ex.arrayDataFilter[6].push(Ex.dataSourceTemp[i].subDept);
				}
				
				if(!(Ex.arrayDataFilter[7]).inArray(Ex.dataSourceTemp[i].brand) && Ex.dataSourceTemp[i].brand!='')
				{
					Ex.arrayDataFilter[7].push(Ex.dataSourceTemp[i].brand);
				}
				
				if(!(Ex.arrayDataFilter[8]).inArray(Ex.dataSourceTemp[i].itemCategory) && Ex.dataSourceTemp[i].itemCategory!='')
				{
					Ex.arrayDataFilter[8].push(Ex.dataSourceTemp[i].itemCategory);
				}
					
		}
	}	
		
}
//==========================END SET DATASOURCE FOR FILTER========================//

function setFilterValue(){
	if(SER.itemResultFilter != null && SER.itemResultFilter != ""){
		var filterValues = document.getElementById('filterValues').value;
		if(filterValues != "")
		{
			var curTab = 1;
			var com = YAHOO.lang;
			var arrValueTab = filterValues.split("___");
							    
			if(arrValueTab[0] != ""){
				document.getElementById('vendorFilter').value = com.trim(arrValueTab[0].split('||')[0]);
				document.getElementById('sellingUpcFilter').value = com.trim(arrValueTab[0].split('||')[1]);
			}
			
			if(arrValueTab.length >curTab){
				var valueFilterOnTab = com.trim(arrValueTab[curTab]);
				if(valueFilterOnTab != ""){
					var arrObjFilter = Ex.arrSellingIdObj;
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

</body>
</html>

