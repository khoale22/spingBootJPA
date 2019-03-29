<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.heb.operations.cps.model.ManageEDICandidate" %>
<%@ page import="java.util.*"%>
<%@page import="java.util.List"%>
<%@page import="com.heb.operations.cps.vo.EDISearchResultVO"%>
<%@page import="com.heb.operations.cps.util.CPSHelper"%>
<%@page import="com.heb.operations.cps.vo.UpcStoreAuthorizationVO"%>
<%@page import="com.heb.operations.cps.vo.DSDDetailVO"%>
<%@page import="com.heb.operations.cps.util.EDIConstants"%><html>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>Authorized Stores DSD Discontinue</title>
<link rel="stylesheet" type="text/css" href="/cps/yui/fonts/fonts-min.css" />
<link rel="stylesheet" type="text/css" href="/cps/yui/assets/yui.css?v=3" >
<link rel="stylesheet" type="text/css" href="/cps/yui/assets/dpSyntaxHighlighter.css">
<link rel="stylesheet" type="text/css" href="/cps/yui/paginator/assets/skins/sam/paginator.css" />
<link rel="stylesheet" type="text/css" href="/cps/yui/datatable/assets/skins/sam/datatable.css" />
<link rel="stylesheet" type="text/css" href="/cps/yui/button/assets/skins/sam/button.css" />
<script type="text/javascript" src="/cps/yui/yuiloader/yuiloader-min.js"></script>
<script type="text/javascript" src="/cps/yui/dom/dom-min.js"></script>
<script type="text/javascript" src="/cps/yui/event/event-min.js"></script>
<script type="text/javascript" src="/cps/yui/dragdrop/dragdrop-min.js"></script>
<script type="text/javascript" src="/cps/yui/animation/animation-min.js"></script>
<script type="text/javascript" src="/cps/yui/element/element-beta-min.js"></script>
<script type="text/javascript" src="/cps/yui/paginator/paginator-min.js"></script>
<script type="text/javascript" src="/cps//yui/datasource/datasource-min.js"></script>
<script type="text/javascript" src="/cps/yui/event-delegate/event-delegate-min.js"></script>
<script type="text/javascript" src="/cps/yui/datatable/datatable-min.js"></script>
<script type="text/javascript" src="/cps/yui/button/button-min.js"></script>
<script type="text/javascript" src="/cps/yui/connection/connection-min.js"></script>
<script type="text/javascript" src="/cps/yui/selector/selector-beta-min.js"></script>
<script type="text/javascript" src="/cps/yui/yahoo/yahoo-min.js"></script>

<c:url value="/dwr/engine.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/util.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/ManageDWR.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/ManageEDIDWR.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>

<style type="text/css"> 

body{font:11px/1.231 arial,helvetica,clean,sans-serif;*font-size:small;*font:x-small;}
select,input,button,textarea{font:99% arial,helvetica,clean,sans-serif;}
table{font-size:11px;font:100%;}
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

</style>
</head>

<script type="text/javascript">

var dataAuthorizedStores = null;
var dataSelectedItems = null;

<%
String data = null;
if(request.getSession().getAttribute(EDIConstants.ITEMS_SELECTED_SESSION) != null){
	data = request.getSession().getAttribute(EDIConstants.ITEMS_SELECTED_SESSION).toString();
%>
	dataSelectedItems = "<%=data %>";
<%}%>

function hideProgressOnPopup(){
	window.parent.hideProgress();
}

function showProgressOnPopup(){
	window.parent.showProgress();
}

function closeDSDPopup(evt){
	window.parent.closeAuthorizedPopup();
}

function makeAuthorizedStoreTable(datasource){
	
	var myColumnDefs = [ 
		{key:"store",    label:"Store",sortable:false, minWidth: 10},    			
		{key:"storeName",    label:"Store Name",sortable:false, width: 200},
		{key:"costGroup",    label:"Cost Group",sortable:false, minWidth: 20},
		{key:"authorized",    label:"Authorized",sortable:false, minWidth: 10},
		{key:"authorizedDate",    label:"Authorized Date",sortable:false, minWidth: 20},
		{key:"deAuthorizedDate",    label:"De-Authorized Date",sortable:false, minWidth: 20},
		{key:"sbt",    label:"SBT Y/N",sortable:false, minWidth: 10}
	];
	var myDataSource = new YAHOO.util.DataSource(datasource.results);
	myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
	myDataSource.responseSchema = {
		fields: ["store","storeName","costGroup","authorized","authorizedDate","deAuthorizedDate","sbt"]
	};
	var myConfigs = {
		paginator: new YAHOO.widget.Paginator({
			rowsPerPage: 10,
			template: YAHOO.widget.Paginator.TEMPLATE_ROWS_PER_PAGE,
			rowsPerPageOptions: [10,25,50,100],
			pageLinks: 5,
			containers: 'pag'
		}),
		height:"250px",
		draggableColumns:false
	}
	var myDataTable = new YAHOO.widget.ScrollingDataTable("gridRejectDSDDiscontinue", myColumnDefs, myDataSource, myConfigs);		

	
	return {
		oDS: myDataSource,
		oDT: myDataTable
	};
};

function getNextPrevious(isNext){
	var itemNext = null;
	var itemPrevious = null;
	var itemSelected = null;
	var order;
	var curItem = dataAuthorizedStores.item + "-" + dataAuthorizedStores.vendorNo + "-" +dataAuthorizedStores.sellingUpc;

	if(dataSelectedItems != null){
		var arrValues = dataSelectedItems.split(',');
		if(arrValues.length > 1){
			for(var i=0; i<arrValues.length; i++){
				if(curItem.indexOf(arrValues[i]) != -1 ){
					if(i<arrValues.length -1)
						itemNext = arrValues[i + 1];
					if(i>0)
						itemPrevious = arrValues[i - 1];

					if(isNext)
						order =  i+1;
					else
						order =  i-1;

					break;
				}
			}

			if(isNext && itemNext != null)
				itemSelected = itemNext;
			else
				if(!isNext && itemPrevious != null)
					itemSelected = itemPrevious;

			if(itemSelected != null){
				showProgressOnPopup();
				ManageEDIDWR.getAuthorizedStore(itemSelected,
		 	    	    {
		 	    		  callback:function(data) {
								hideProgressOnPopup();

								dataAuthorizedStores = eval('(' + data.appData + ')'); 
								
								YAHOO.util.Dom.get('sellingUpc').innerHTML = dataAuthorizedStores.sellingUpc;
								YAHOO.util.Dom.get('description').innerHTML = dataAuthorizedStores.description;
								YAHOO.util.Dom.get('size').innerHTML = dataAuthorizedStores.size;
								YAHOO.util.Dom.get('dept').innerHTML = dataAuthorizedStores.dept;
								YAHOO.util.Dom.get('vendor').innerHTML = dataAuthorizedStores.vendorNo;
								YAHOO.util.Dom.get('vendorName').innerHTML = dataAuthorizedStores.vendorName;
								YAHOO.util.Dom.get('pack').innerHTML = dataAuthorizedStores.pack;
								YAHOO.util.Dom.get('vpc').innerHTML = dataAuthorizedStores.vpc;
								
								makeAuthorizedStoreTable(dataAuthorizedStores);

								if(isNext)
									YAHOO.util.Dom.get('previousBut').disabled = false;
								else
									YAHOO.util.Dom.get('nextBut').disabled = false;	
								
								if(order >= arrValues.length -1){
									YAHOO.util.Dom.get('nextBut').disabled = true;
									YAHOO.util.Dom.get('previousBut').disabled = false;
								}
								else
									if(order <= 0){
										YAHOO.util.Dom.get('nextBut').disabled = false;
										YAHOO.util.Dom.get('previousBut').disabled = true;
									}																
									
		 	    			},
		 	    			errorHandler:function(errorString, exception) {
		 	    				hideProgressOnPopup();
		 	    			},
		 	   				timeout:180000
		 	    		});
			}
		}
	}
}

</script>
<body onload="hideProgressOnPopup()">

<div id="yahoo-com" class="yui-skin-sam">
<div style="margin-left: 6px; padding-bottom: 5px;"><b>UPC - Store Authorization</b></div>
<fieldset id="fHeader" style="margin-left: 6px; background-color: #edf5ff; margin-right: 6px; padding-bottom: 5px; 
		padding-top: 5px; width: 98%; color: #000000;position: relative;z-index: 10000;">
	<div id="headerSection">
		<table cellspacing="10" width="100%">
			<tr>
				<td><b>Selling UPC: </b></td>
				<td>
					<div id="sellingUpc"></div>
				</td>
				<td><b>UPC Desc: </b></td>
				<td>
					<div id="description"></div>
				</td>
				<td><b>Size: </b></td>
				<td>
					<div id="size"></div>
				</td>
				<td><b>Dept: </b></td>
				<td>
					<div id="dept"></div>
				</td>
			</tr>
			<tr>
				<td><b>Vendor: </b></td>
				<td>
					<div id="vendor"></div>
				</td>
				<td><b>Name: </b></td>
				<td>
					<div id="vendorName"></div>
				</td>
				<td><b>Pack: </b></td>
				<td>
					<div id="pack"></div>
				</td>
				<td><b>VPC: </b></td>
				<td>
					<div id="vpc"></div>
				</td>
			</tr>
		</table>
	</div>
</fieldset>	
<fieldset id="fSearchResultSection" style="margin-top: 10px; margin-left: 6px; background-color: #edf5ff; margin-right: 6px; padding-bottom: 5px; 
		padding-top: 5px; width: 98%; color: #000000;position: relative;z-index: 9000;">
<div id="searchResultContainer">
	<div id="rejectDSDDiscontinue">
			<div id="totalRecord" style="padding-left: 5px; color: red"></div>	
		    <div style="width:100%; height:90%; padding: 5px 0 5px 0;z-index:15000;">
			    <div id="gridRejectDSDDiscontinue"></div> 
		    </div>
		    <div id="pag" style="font-family:arial; font-size:10px;"></div>
	</div>
</div>
</fieldset>
<div id="containerFunction" style="text-align: right; padding-top:10px; padding-right:10px; font-size:11px;">
	<input type="button" id="previousBut" value='Previous' onclick="getNextPrevious(false)"/>
	<input type="button" id="nextBut" value='Next' onclick="getNextPrevious(true)"/>
	<input type="button" id="backBut" value='Back' onclick="closeDSDPopup()"/>
</div>
</div>
	<%
		if(request.getSession().getAttribute("ManageEDICandidate") != null)
		{
			StringBuffer strData = new StringBuffer();
			UpcStoreAuthorizationVO results = ((ManageEDICandidate)(request.getSession().getAttribute("ManageEDICandidate"))).getUpcStoreAuthorization();
					
			if(results != null)
			{
				strData.append("{sellingUpc:\"" + CPSHelper.displaySellingUPC(results.getUpcNo()));
				strData.append("\",item:\"" + results.getPsItemId());
				strData.append("\",description:\"" + CPSHelper.convertCharToHTMLForJSON(results.getDescription()));
				strData.append("\",vendorNo:\"" + results.getPsVendno());
				strData.append("\",vendorName:\"" + CPSHelper.convertCharToHTMLForJSON(results.getPsVendName()));
				strData.append("\",size:\"" + results.getSize());
				strData.append("\",dept:\"" + results.getDept());
				strData.append("\",pack:\"" + results.getPack());
				strData.append("\",vpc:\"" + results.getVpc());
				strData.append("\",\nresults: [");
				
				List<DSDDetailVO> listDSDDetailVO = results.getListDSDDetailVO();
				for(int i= 0; i< listDSDDetailVO.size(); i++)
				{
					DSDDetailVO dsdResult = listDSDDetailVO.get(i);

					if (i==0)
						strData.append("\n{store:\""+ dsdResult.getStore());
					else
						strData.append("\n,{store:\""+ dsdResult.getStore());
					strData.append("\",storeName:\"" + CPSHelper.replaceSpecialCharHTMLs(dsdResult.getStoreName()));
					strData.append("\",costGroup:\"" + dsdResult.getCostGroup());
					strData.append("\",authorized:\"" + dsdResult.getAuthorized());  
					strData.append("\",authorizedDate:\"" + dsdResult.getAuthorizedDate());
					strData.append("\",deAuthorizedDate:\"" + dsdResult.getDeAuthorizedDate());
					strData.append("\",sbt:\"" + dsdResult.getSbt() +"\"}");

				}
				strData.append("]}");
			}
			
			if(strData.length() > 0){
			
	%>
	<script type="text/javascript">  
		dataAuthorizedStores = <%=strData.toString()%>;  
		YAHOO.util.Dom.get('sellingUpc').innerHTML = dataAuthorizedStores.sellingUpc;
		YAHOO.util.Dom.get('description').innerHTML = dataAuthorizedStores.description;
		YAHOO.util.Dom.get('size').innerHTML = dataAuthorizedStores.size;
		YAHOO.util.Dom.get('dept').innerHTML = dataAuthorizedStores.dept;
		YAHOO.util.Dom.get('vendor').innerHTML = dataAuthorizedStores.vendorNo;
		YAHOO.util.Dom.get('vendorName').innerHTML = dataAuthorizedStores.vendorName;
		YAHOO.util.Dom.get('pack').innerHTML = dataAuthorizedStores.pack;
		YAHOO.util.Dom.get('vpc').innerHTML = dataAuthorizedStores.vpc;
		
		var authorizedStoreResult = makeAuthorizedStoreTable(dataAuthorizedStores);
		
	</script>
<%} }%>

<script type="text/javascript">
	if(dataSelectedItems != null){
		if(dataSelectedItems.split(',').length <= 1){
			YAHOO.util.Dom.get('previousBut').disabled = true;
			YAHOO.util.Dom.get('nextBut').disabled = true;
		}
	}
	else
	{
		YAHOO.util.Dom.get('previousBut').disabled = true;
		YAHOO.util.Dom.get('nextBut').disabled = true;
	}
</script>

</body>
</html>
