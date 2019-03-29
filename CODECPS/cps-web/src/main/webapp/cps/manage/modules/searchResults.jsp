<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%@ page import="com.heb.operations.cps.model.ManageCandidate" %>
<c:url var="upArrow" value="${request.getContextPath()}/hebAssets/images/up_arrow.gif"></c:url>
<c:url var="downArrow" value="${request.getContextPath()}/hebAssets/images/down_arrow.gif"></c:url>
<div id="minProgressDivSRs" style=""></div> 
<c:url var="loadingImageSRs" value="${request.getContextPath()}/hebAssets/images/loadingData.gif"></c:url>
<style>
	#clearFilter-button {
		width:73px;
	}
	#panel2{
		top:100px !important;
	}
</style>
<fieldset id="f1" style="margin-left: 6px; background-color:#F5EFEA;
									margin-right: 6px; 
									padding-bottom: 5px; 
									padding-top: 5px; 
									width: 98%; position: relative;
									color: #000000;height: 400px;z-index: -1000;">
	<form:hidden path="lstFilter" id="lstFilter"/>
	<form:hidden path="lstValueFilter" id="lstValueFilter"/>
	<div id="allHeader">
	<div id="tabHeader" style="position: relative;top: -1px;height: 100px;width: 99.6%;min-width: 0;z-index: 10;">
	<table id="searchResults" width="100%" border="0" bordercolor="red" cellspacing="0" cellpadding="0" class="dataGrid" style="position: relative;">
		<tr>
			<td class="dataGridHead" align="left" width="3%"><span style="margin-left:3px"> All</span><br> <input type="checkbox" id="checkAll" 
			onclick='selectAllCheckboxNews();'> </td>	
			<td class="dataGridHead"  align="left" width="15%" id="v1">
				<table border="0" ><tr>
				<td><div id="d1" style="position: relative;"></div></td>
					<td class="#searchResults"><a href="javascript:return false;" onclick="sortColumn(1);return false;">Vendor</a></td>
					<td>   
					
					<cps:renderByResourceAccess resourceId="225">
					<jsp:attribute name="EDIT">
					 <input type="button" onclick="showCompleter(1);" value="..."/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
					 <input type="button" onclick="showCompleter(1);" value="..."/>
					</jsp:attribute>										
					</cps:renderByResourceAccess></td>
					</tr></table>
			</td>
			<td class="dataGridHead"  align="left" width="11%" id="v2">
				<table border="0"><tr>
				<td><div id="d2" style="position: relative;"></div></td>
					<td><a href="javascript:return false;" onclick="sortColumn(2);return false;">Unit UPC</a></td>
					<td>
					<cps:renderByResourceAccess resourceId="145">
					<jsp:attribute name="EDIT"> 
					<input type="button" onclick="showCompleter(2);" value="..."/>
					</jsp:attribute>	
					<jsp:attribute name="VIEW"> 
					<input type="button" onclick="showCompleter(2);" value="..."/>
					</jsp:attribute>									
					</cps:renderByResourceAccess>   </td>
					</tr></table>
			</td>
			<td class="dataGridHead"  align="left" width="19%" id="v3">
				<table border="0"><tr>
				<td><div id="d3" style="position: relative;"></div></td>
					<td><a href="javascript:return false;" onclick="sortColumn(3);return false;">Product Description</a></td>
					<td>
					<cps:renderByResourceAccess resourceId="146">
					<jsp:attribute name="EDIT">
					 <input type="button" onclick="showCompleter(3);" value="..."/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
					 <input type="button" onclick="showCompleter(3);" value="..."/>
					</jsp:attribute>										
					</cps:renderByResourceAccess>   </td>
					</tr></table>
			</td>
			
			<td class="dataGridHead"  align="left" width="14%" id="v5">
				<table border="0"><tr>
				<td><div id="d5" style="position: relative;"></div></td>
					<td>
					<a href="javascript:return false;"	onclick="sortColumn(5);return false;">Presentation Date</a></td>
					<td>   
					<cps:renderByResourceAccess resourceId="241">
					<jsp:attribute name="EDIT">
					 <input type="button" onclick="showCompleter(5);" value="..."/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
					 <input type="button" onclick="showCompleter(5);" value="..."/>
					</jsp:attribute>										
					</cps:renderByResourceAccess> 
					 </td>
					</tr></table>
			</td>
			<td class="dataGridHead"  align="center" width="14%" id="v6">
				<table border="0"><tr>
				<td><div id="d6" style="position: relative;"></div></td>
					<td ><a href="javascript:return false;" onclick="sortColumn(6);return false;">Status</a></td>
					<td>
					<cps:renderByResourceAccess resourceId="149">
					<jsp:attribute name="EDIT">
					 <input type="button" onclick="showCompleter(6);" value="..."/>
					</jsp:attribute>	
					<jsp:attribute name="VIEW">
					 <input type="button" onclick="showCompleter(6);" value="..."/>
					</jsp:attribute>									
					</cps:renderByResourceAccess>   </td>
				</tr></table>
			</td>
			<td class="dataGridHead"  align="left" width="14%" id="v7">
				<table border="0">
				<tr>
				<td><div id="d7" style="position: relative;"></div></td>
					<td ><a href="javascript:return false;" onclick="sortColumn(7);return false;">Test Scan Status</a></td>
					<td> 
					<cps:renderByResourceAccess resourceId="155">
						<jsp:attribute name="EDIT"> 
							<input type="button" onclick="showCompleter(7);" value="..."/>
						</jsp:attribute>	
						<jsp:attribute name="VIEW"> 
							<input type="button" onclick="showCompleter(7);" value="..."/>
						</jsp:attribute>									
					</cps:renderByResourceAccess>  
					</td>
				</tr> 
				</table>
			</td>
		
			<td class="dataGridHead"  align="left" width="16%" id="v8">
				<table border="0">
				<tr>
		
				<td><div id="d8" style="position: relative;"></div></td>
					<td ><a href="javascript:return false;" onclick="sortColumn(8);return false;">MRT Switch</a></td>
					<td> 
						<cps:renderByResourceAccess resourceId="226">
							<jsp:attribute name="EDIT">
							<input type="button" onclick="showMrtSwitch();" value="..."/>
							<!--
								<form:checkbox path="criteria.mrtSwitchCheck" tabindex="6" id="mrtSwitch"></form:checkbox>
							--></jsp:attribute>		
<jsp:attribute name="VIEW"> 
							<input type="button" onclick="showMrtSwitch();" value="..."/>
						</jsp:attribute>								
						</cps:renderByResourceAccess> 
					</td>
				</tr> 
				</table>
			</td>
			
			<td class="dataGridHead"  width="2%" id="v10">
				<cps:renderByResourceAccess	resourceId="240">
					<jsp:attribute name="EXEC">
						<button type="button" id="clearFilter">Clear Filter</button>
					</jsp:attribute>
				</cps:renderByResourceAccess>
		</td>
		</tr>   

		<tr>
		<td class="dataGridHead" align="left" width="3%" border="0"></td>
			
			<td class="dataGridHead"  width="15%" border="0">			
			<div id="autoComplete1" style="display: none;">
			<c:if test="${noData eq 'true'}">
				<input type="hidden" id="noData">
			</c:if>			
			<cps:renderByResourceAccess resourceId="225">
				<jsp:attribute name="EDIT">
			<cps:autoComplete sourceList="vendorDescs" compName="vendorDescUniq" containerId="vendorDescContainer"
						textid="vendorDescText" selectedProperty="vndrDesc" 
						clearMethod="vndrDescClear"
						containerVar="YAHOO.HEB.manageMain.vendorDescData"
						resetJSMethodName="YAHOO.HEB.manageMain.vendorDescReset"
						selectedValueId="vendorDescSelectedId"
						selectedValueName="vendorDescSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.vendorDescReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete>
				</jsp:attribute>	
				<jsp:attribute name="VIEW">
			<cps:autoComplete sourceList="vendorDescs" compName="vendorDescUniq" containerId="vendorDescContainer"
						textid="vendorDescText" selectedProperty="vndrDesc" 
						clearMethod="vndrDescClear"
						containerVar="YAHOO.HEB.manageMain.vendorDescData"
						resetJSMethodName="YAHOO.HEB.manageMain.vendorDescReset"
						selectedValueId="vendorDescSelectedId"
						selectedValueName="vendorDescSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.vendorDescReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete>
				</jsp:attribute>					
				</cps:renderByResourceAccess></div></td>
			<td class="dataGridHead"  width="12%" >
			<div id="autoComplete2" style="display: none;">
			<cps:renderByResourceAccess resourceId="145">
			<jsp:attribute name="EDIT">
			 <cps:autoComplete sourceList="unitUPCs" compName="unitUPCUniq" containerId="unitUPCContainer"
						textid="unitUPCText" selectedProperty="vndrUnitUpc" 
						clearMethod="vndrUnitUpcClear"
						containerVar="YAHOO.HEB.manageMain.unitUPCData"
						resetJSMethodName="YAHOO.HEB.manageMain.unitUPCReset"
						selectedValueId="unitUPCSelectedId"
						selectedValueName="unitUPCSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.unitUPCReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete> 
			</jsp:attribute>		
			<jsp:attribute name="VIEW">
			 <cps:autoComplete sourceList="unitUPCs" compName="unitUPCUniq" containerId="unitUPCContainer"
						textid="unitUPCText" selectedProperty="vndrUnitUpc" 
						clearMethod="vndrUnitUpcClear"
						containerVar="YAHOO.HEB.manageMain.unitUPCData"
						resetJSMethodName="YAHOO.HEB.manageMain.unitUPCReset"
						selectedValueId="unitUPCSelectedId"
						selectedValueName="unitUPCSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.unitUPCReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete> 
			</jsp:attribute>							
			</cps:renderByResourceAccess></div></td>
			<td class="dataGridHead"  width="19%">
			<div id="autoComplete3" style="display: none;">
			<cps:renderByResourceAccess resourceId="146">
			<jsp:attribute name="EDIT">		
			<cps:autoComplete sourceList="prodDescriptions" compName="prodDescUniq" containerId="prodDescContainer"
						textid="prodDescText" selectedProperty="prdDesc"
						clearMethod="prdDescClear"
						containerVar="YAHOO.HEB.manageMain.prodDescData"
						resetJSMethodName="YAHOO.HEB.manageMain.prodDescReset"
						selectedValueId="prodDescSelectedId"
						selectedValueName="prodDescSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.prodDescReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete>
			</jsp:attribute>			
			<jsp:attribute name="VIEW">		
			<cps:autoComplete sourceList="prodDescriptions" compName="prodDescUniq" containerId="prodDescContainer"
						textid="prodDescText" selectedProperty="prdDesc"
						clearMethod="prdDescClear"
						containerVar="YAHOO.HEB.manageMain.prodDescData"
						resetJSMethodName="YAHOO.HEB.manageMain.prodDescReset"
						selectedValueId="prodDescSelectedId"
						selectedValueName="prodDescSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.prodDescReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete>
			</jsp:attribute>						
			</cps:renderByResourceAccess>	</div></td>
			
			<td class="dataGridHead"  width="14%">
			<div id="autoComplete5" style="display: none;">
			<cps:renderByResourceAccess resourceId="241">
			<jsp:attribute name="EDIT">
			<cps:autoComplete sourceList="prodPresDates" compName="prodPresDateUniq" containerId="prodPresDateContainer"
						textid="prodPresDateText" selectedProperty="prodPresDate"
						clearMethod="prodPresDateClear"
						containerVar="YAHOO.HEB.manageMain.prodPresDateData"
						resetJSMethodName="YAHOO.HEB.manageMain.prodPresDateReset"
						selectedValueId="prodPresDateSelectedId"
						selectedValueName="prodPresDateSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.prodPresDateReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete>
			</jsp:attribute>
			<jsp:attribute name="VIEW">		
			<cps:autoComplete sourceList="prodPresDates" compName="prodPresDateUniq" containerId="prodPresDateContainer"
						textid="prodPresDateText" selectedProperty="prodPresDate"
						clearMethod="prodPresDateClear"
						containerVar="YAHOO.HEB.manageMain.prodPresDateData"
						resetJSMethodName="YAHOO.HEB.manageMain.prodPresDateReset"
						selectedValueId="prodPresDateSelectedId"
						selectedValueName="prodPresDateSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.prodPresDateReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete>
			</jsp:attribute>						
			</cps:renderByResourceAccess>
					
			</div></td>
			<td class="dataGridHead"  width="13%">
			<div id="autoComplete6" style="display: none;">
			<cps:renderByResourceAccess resourceId="149">
			<jsp:attribute name="EDIT">
			<cps:autoComplete sourceList="statuses" compName="statusUniq" containerId="statusContainer"
						textid="statusText" selectedProperty="status"
						clearMethod="statusClear"
						containerVar="YAHOO.HEB.manageMain.statusData"
						resetJSMethodName="YAHOO.HEB.manageMain.statusReset"
						selectedValueId="statusSelectedId"
						selectedValueName="statusSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.statusReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete>
			</jsp:attribute>				
			<jsp:attribute name="VIEW">
			<cps:autoComplete sourceList="statuses" compName="statusUniq" containerId="statusContainer"
						textid="statusText" selectedProperty="status"
						clearMethod="statusClear"
						containerVar="YAHOO.HEB.manageMain.statusData"
						resetJSMethodName="YAHOO.HEB.manageMain.statusReset"
						selectedValueId="statusSelectedId"
						selectedValueName="statusSelectedName" width="100%" index="9000"
						 reloadMethod="YAHOO.HEB.manageMain.statusReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
					</cps:autoComplete>
			</jsp:attribute>					
			</cps:renderByResourceAccess></div></td>
					<td class="dataGridHead"  width="12%">
						<div id="autoComplete7" style="display: none;">
								<cps:renderByResourceAccess resourceId="155">
						<jsp:attribute name="EDIT">
						<cps:autoComplete sourceList="testScanStatuses" compName="testScanStatusUniq" containerId="testScanStatusContainer"
									textid="testScanStatusText" selectedProperty="testScanStatus"
									clearMethod="testScanStatusClear"
									containerVar="YAHOO.HEB.manageMain.testScanStatusData"
									resetJSMethodName="YAHOO.HEB.manageMain.testScanStatusReset"
									selectedValueId="testScanStatusSelectedId"
									selectedValueName="testScanStatusSelectedName" width="100%" index="9000"
									 reloadMethod="YAHOO.HEB.manageMain.testScanStatusReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
								</cps:autoComplete>
						</jsp:attribute>		
						<jsp:attribute name="VIEW">
						<cps:autoComplete sourceList="testScanStatuses" compName="testScanStatusUniq" containerId="testScanStatusContainer"
									textid="testScanStatusText" selectedProperty="testScanStatus"
									clearMethod="testScanStatusClear"
									containerVar="YAHOO.HEB.manageMain.testScanStatusData"
									resetJSMethodName="YAHOO.HEB.manageMain.testScanStatusReset"
									selectedValueId="testScanStatusSelectedId"
									selectedValueName="testScanStatusSelectedName" width="100%" index="9000"
									 reloadMethod="YAHOO.HEB.manageMain.testScanStatusReload" valueDisplay="false" onchangeMethod="filterChange" enforceSelection="false">
								</cps:autoComplete>		
						</jsp:attribute>	
						</cps:renderByResourceAccess>
						</div>
					</td>
					<td class="dataGridHead"  width="8%">
						<div id="mrtSwitchFilter" style="display: none;padding-left:15px">
							<cps:renderByResourceAccess resourceId="226">
								<jsp:attribute name="EDIT">
									<form:checkbox path="criteria.mrtSwitchCheck" tabindex="6" id="mrtSwitch" onclick="filterChange(null)"></form:checkbox>
								</jsp:attribute>	
								<jsp:attribute name="VIEW">
									<form:checkbox path="criteria.mrtSwitchCheck" tabindex="6" id="mrtSwitch" onclick="filterChange(null)"></form:checkbox>
								</jsp:attribute>	
							</cps:renderByResourceAccess>
						</div>
					</td>					
					<td class="dataGridHead"  align="left" width="2%" id="v10">&nbsp;</td>
		</tr> 
	</table>
	</div>
	<div id="results">
		<div id="resultData" style="overflow-x: auto;overflow-y:auto;height: 270px;">
		<input type="hidden" id="allIds" value="-" name="hiddenTxt"/>
		<input type="hidden" id="allMRTIds" value="-" name="hidMrtSwitch"/>
		<form:hidden path="selectedProductId" id="selectedProductId"/>
		<form:hidden path="hidManageMrtSwitch" id="selectedMRTId"/>
		<form:hidden path="candidateTypeList" id="candidateTypeList"/>
		<form:hidden path="batchCandidate" id="batchCandidate"/>
		<form:hidden path="selectedProdWorkRqstId" id="selectedProdWorkRqstId"/>
		<form:hidden path="selectedWorkStatus" id="selectedWorkStatus" />
		<form:hidden path="selectedProductCandidateId" id="selectedProductCandidateId" />
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="dataGrid" >
			<c:forEach items="${manageCandidate.productsDisplay}" var="product" varStatus="loop" >

		<%-- Bug #240 --%>
		<c:url value="/protected/cps/add/pow?${_csrf.parameterName}=${_csrf.token}" var="pow"></c:url>
		<tr id="row${product.psProdId}" ondblclick="modifyDblClick('${product.psProdId}','${product.workStatusDesc}','${product.mrtLabel}');">
			<td class="row${loop.index%2}" align="left" width="2%">
			<input type="hidden" id="hiddProdId${loop.index}"
				value="${product.psProdId}" /><input type="hidden"
				id="workId${loop.index}" value="${product.workIdentifier}" />
				<input type="hidden"
				id="workStatus${loop.index}" value="${product.workStatusDesc}" />
				<input type="hidden" id="hiddMrtLabel${loop.index}" value="${product.mrtLabel}"/>
				<input type="hidden" id="intentIdentifier${loop.index}" value="${product.intentIdentifier}"/>
				<input type="checkbox" id="check${loop.index}" name="candSelectCheck"
						onclick="selectSingleProductNew(this);">				
			</td>
			<td class="row${loop.index%2}" align="left" width="14%">
			<cps:renderByResourceAccess resourceId="225">
				<jsp:attribute name="EDIT">
				<%--<bean:write name="product" property="vendorDesc" />--%>
					<c:out value="${product.vendorDesc}"></c:out>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
				<%--<bean:write name="product" property="vendorDesc" />--%>
					<c:out value="${product.vendorDesc}"></c:out>
				</jsp:attribute>
			</cps:renderByResourceAccess></td>
			<td class="row${loop.index%2}" align="left" width="10%">
			<cps:renderByResourceAccess resourceId="145">
				<jsp:attribute name="EDIT">
					<%--<bean:write name="product" property="unitUPC" />--%>
					<c:out value="${product.unitUPC}"></c:out>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<%--<bean:write name="product" property="unitUPC" />--%>
					<c:out value="${product.unitUPC}"></c:out>
				</jsp:attribute>
			</cps:renderByResourceAccess></td>
			<td class="row${loop.index%2}" align="left" width="17%">
			<cps:renderByResourceAccess resourceId="146">
				<jsp:attribute name="EDIT">
				<%--<bean:write name="product" property="prodDescription" />--%>
					<c:out value="${product.prodDescription}"></c:out>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
				<%--<bean:write name="product" property="prodDescription" />--%>
					<c:out value="${product.prodDescription}"></c:out>
				</jsp:attribute>
			</cps:renderByResourceAccess></td>
			
			<td class="row${loop.index%2}" width="12%">
			<cps:renderByResourceAccess resourceId="241">
				<jsp:attribute name="EDIT">
				<span style="margin-left:28px">
					<%--<bean:write name="product" property="pressDate" />--%>
					<c:out value="${product.pressDate}"></c:out>
				</span>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<span style="margin-left:28px">
						<%--<bean:write name="product" property="pressDate" />--%>
						<c:out value="${product.pressDate}"></c:out>
					</span>
				</jsp:attribute>
			</cps:renderByResourceAccess>
			</td>
			<td class="row${loop.index%2}" align="center" width="12%">
			<cps:renderByResourceAccess resourceId="149">
				<jsp:attribute name="EDIT">
				<%--<bean:write name="product" property="workStatusDesc" />--%>
					<c:out value="${product.workStatusDesc}"></c:out>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
				<%--<bean:write name="product" property="workStatusDesc" />--%>
					<c:out value="${product.workStatusDesc}"></c:out>
				</jsp:attribute>
			</cps:renderByResourceAccess></td>
			<td class="row${loop.index%2}" align="left" width="14%">
			<cps:renderByResourceAccess resourceId="155">
				<jsp:attribute name="EDIT">
				<span style="margin-left:28px">
				<%--<bean:write name="product" property="testScanStatus" />--%>
					<c:out value="${product.testScanStatus}"></c:out>
				</span>
				</jsp:attribute>
				<jsp:attribute name="VIEW">
					<span style="margin-left:28px">
					<%--<bean:write name="product" property="testScanStatus" />--%>
						<c:out value="${product.testScanStatus}"></c:out>
					</span>
				</jsp:attribute>
			</cps:renderByResourceAccess></td>
				<td  class="row${loop.index%2}" align="left" width="9%">
					<%--	<bean:write name="product" property="mrtLabel"/>--%>
						<c:out value="${product.mrtLabel}"></c:out>
				</td>
			<td class="row${loop.index%2}" align="left" width="5%">&nbsp;</td>
		</tr>
	<%--</logic:iterate>--%>
			</c:forEach>
</table>
	</div>
	<%
	int numView = 10;
	int pageCurrent = 0;
	int totalRecord = 0;   
	int totalPage = 0;
	String display="none";
	if(request.getAttribute("manageCandidate")!= null && ((ManageCandidate)request.getAttribute("manageCandidate")).getProductsDisplay()!=null){
		if(((ManageCandidate)request.getAttribute("manageCandidate")).getProductsDisplay().size()>0){
			display = "block";
		}
		if(request.getAttribute("totalPage")!=null){
			totalPage = Integer.parseInt(request.getAttribute("totalPage").toString());
		}
		if(request.getAttribute("totalRecord")!=null){
			totalRecord = Integer.parseInt(request.getAttribute("totalRecord").toString());
		}		
		if(request.getAttribute("pageCurrent")!=null){
			pageCurrent = Integer.parseInt(request.getAttribute("pageCurrent").toString());
		}
		if(request.getAttribute("totalPage")!=null){
			numView = Integer.parseInt(request.getAttribute("numView").toString());
		}		
		%>	
	<div style="height: 20px;width: 99.6%;display:<%=display %>">
			<div id="pagingShow">
			&nbsp;<b>Total page: <%=totalPage %></b>&nbsp;
			<% /* First and Next Button */ %>
			<%
			if(pageCurrent==0){
			%>
				&laquo; first
				&nbsp;
				&lsaquo; previous
			<%
			}else{
			%>
				<a href="javascript:loadAjaxForSearch(0,'')">&laquo; first</a>
				&nbsp;
				<a href="javascript:loadAjaxForSearch(<%=pageCurrent-1 %>,'')">&lsaquo; previous</a>
			<%
			}
			%>
			<% /* Load number show */ %>
			
			<%
			int from = pageCurrent-5;
			if(from<0) from=0;
			int to = pageCurrent+5;
			if(to>totalPage) to = totalPage;
			for(;from<to;from++){
				if(from!=pageCurrent){
			%>
				&nbsp;<a href="javascript:loadAjaxForSearch(<%=from %>,'')"><%=from+1 %></a>&nbsp;
			<%		
				}else{
			%>
				&nbsp;<B><%=from+1 %></B>&nbsp;
			<%
				}
			}
			%>
			
			<% /* Next and Last Button */ %>
			<%
			if(pageCurrent==(totalPage-1)){
			%>
				next &rsaquo;
				&nbsp;
				last &raquo;
			<%
			}else{
			%>
				<a href="javascript:loadAjaxForSearch(<%=pageCurrent+1 %>,'')">next &rsaquo;</a>
				&nbsp;
				<a href="javascript:loadAjaxForSearch(<%=totalPage -1 %>,'')">last &raquo;</a>
			<%
			}
			%>
			&nbsp;
			<select name="numViewSet" onchange="loadAjaxForSearch('',this.value)">
			<%
			for(int i=10;i<200;i=(i*2)){
			%>
				<option value="<%=i %>" <%if(i==numView) out.print("selected"); %>><%=i %></option>
			<%	
			}
			%>
		</select>
			</div>
		<%
		}
		%>
			
	</div>
</div>

	</div>
</fieldset>
	<div id="resultsButtons"  style="margin-left: 6px;
									margin-right: 6px; position: relative;
									padding-bottom: 5px; 
									padding-top: 5px; 
									width: 98.4%;
									color: #000000;">
		<table align="right" width="100%" id="tabResults" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td align="right">
					<cps:renderByResourceAccess resourceId="200">
						<jsp:attribute name="EXEC">
							<button type="button" id="scaleApproveBut" name="scaleApproveBut" value="scaleApprove"  style="width: 18em;">Scale Approve</button>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<cps:renderByResourceAccess resourceId="234">
						<jsp:attribute name="EXEC">
							<button type="button" id="printFormId" name="printFormName" value="printForm"  style="width: 18em;">Print Form</button>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<cps:renderByResourceAccess resourceId="205">
						<jsp:attribute name="EXEC">
							<button type="button" id="printBut" name="printBut" value="Print"  style="width: 18em;">Print Summary</button>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<cps:renderByResourceAccess resourceId="206">
						<jsp:attribute name="EXEC">
							<button type="button" id="viewBut" name="viewBut" value="view" style="width: 5em;">View</button>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<cps:renderByResourceAccess resourceId="164">
						<jsp:attribute name="EXEC">
							<button type="button" id="modifyBut" name="modifyBut" value="modify" style="width: 5em;">Modify</button>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<cps:renderByResourceAccess resourceId="159">
						<jsp:attribute name="EXEC">
							<button type="button" id="submitBut" name="submitBut" value="submit" style="width: 5em;" >Submit</button>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<cps:renderByResourceAccess resourceId="166">
						<jsp:attribute name="EXEC">
							 <button type="button" id="copyBut" name="copyBut" value="copy" style="width: 5em;">Copy</button>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<cps:renderByResourceAccess resourceId="160">
						<jsp:attribute name="EXEC">
							<button type="button" id="activateBut" name="activateBut" value="activate"  style="width: 5em;">Activate</button>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<cps:renderByResourceAccess resourceId="162">
						<jsp:attribute name="EXEC">
							<button type="button" id="testScanBut" name="testScanBut" value="testScan" style="width: 17em;">Test Scan</button>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<cps:renderByResourceAccess resourceId="161">
						<jsp:attribute name="EXEC">
							<button type="button" id="rejectBut" name="rejectBut" value="reject" style="width: 5em;">Reject</button>
						</jsp:attribute>
					</cps:renderByResourceAccess>
					<cps:renderByResourceAccess resourceId="281">
						<jsp:attribute name="EXEC">
							<button type="button" id="deleteBtn" name="deleteBtn" value="delete" style="width: 5em;">Delete</button>
						</jsp:attribute>
					</cps:renderByResourceAccess>
				</td>
			 </tr>
		</table>
	</div>

<script type="text/javascript">
var arrTemp = new Array();
if(document.getElementById("lstFilter").value!="")
{
	var tempArr = document.getElementById("lstFilter").value.split(",");
	for(var i =0;i<tempArr.length;i++)
	{
		if(tempArr[i]!="8")
		{
			document.getElementById('autoComplete'+tempArr[i]).style.display = 'block';
		}
		else
		{
			document.getElementById("mrtSwitchFilter").style.display = 'block';
		}	
		arrTemp.push(tempArr[i]);
	}
}
<c:url value="/protected/cps/add/prodAndUpc?${_csrf.parameterName}=${_csrf.token}" var="prod"></c:url>
<cps:renderByResourceAccess resourceId="200">
	<jsp:attribute name="EXEC">
		new YAHOO.widget.Button("scaleApproveBut");
	</jsp:attribute>
</cps:renderByResourceAccess>
var showProgressCustomize;
var minProgressCustomize;
var hideProgressCustomize;
var hideProdDisabled = false;

function initMinProgressCustomize(){
	var minProgressCustomize = new YAHOO.widget.Panel("minProgressDivSRs",  
	                                         {  xy:[200,250], 
	    										width: "240px", 
	    										height : "70px",  
	    										fixedcenter: true, 
	    										visible: false,
	    										zIndex : 35000,
	    										modal : true,
												draggable:false,
												close:false
	                                         });
	minProgressCustomize.setHeader("Processing, please wait...");
	minProgressCustomize.setBody("<img src=\"${loadingImageSRs}\"/>");
	minProgressCustomize.render(document.body);
	showProgressCustomize = function(){
		document.body.style.cursor = 'wait';
		minProgressCustomize.show();
	}
	hideProgressCustomize = function(){
		if(!hideProdDisabled){
			minProgressCustomize.hide();
			document.body.style.cursor = 'auto';
		}
	}
}
YAHOO.util.Event.onDOMReady(initMinProgressCustomize);

<cps:renderByResourceAccess resourceId="234">
	<jsp:attribute name="EXEC">	
		new YAHOO.widget.Button("printFormId");
   </jsp:attribute>
</cps:renderByResourceAccess>     

YAHOO.util.Event.addListener(YAHOO.util.Dom.get("printFormId"), "click", printFormPopUp);
	<c:url value="/protected/cps/manage/printForm?${_csrf.parameterName}=${_csrf.token}" var="printForm" />
	<c:url value="/protected/cps/manage/printFormAjax?${_csrf.parameterName}=${_csrf.token}" var="printFormAjax" />
function printFormPopUp(evt) {
	if(checkSelection3(evt)){
		var formObject = document.getElementById('searchForm');
		formObject.action = "${printFormAjax}";
		YAHOO.util.Connect.setForm(formObject); 			
		var callback = {
			success:function(o){
				//hideProgress();
				try{
					f1('${printForm}'+'&t='+new Date().getTime(),'Print Forms','200px','62%','130px','200px');
					document.getElementById('litemPop').innerHtml=o.responseText;
					document.getElementById('itemPop').style.background = "white";
                    document.getElementById('minProgressDiv_c').style.zIndex= '9999999';

                    document.getElementById('itemPop').onload= function() {
                        hideProgress();
                        document.getElementById('minProgressDiv_c').style.zIndex= '35003';
                    };
                    document.getElementById('itemPop').onunload= function() {
                        hideProgress();
                        document.getElementById('minProgressDiv_c').style.zIndex= '35003';
                    };
                }catch(e){hideProgress();}
			}
		};
		showProgress();
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);	
	}
} 	  
                              
<cps:renderByResourceAccess resourceId="205">
	<jsp:attribute name="EXEC">                                        
		new YAHOO.widget.Button("printBut");
    </jsp:attribute>
</cps:renderByResourceAccess>

<cps:renderByResourceAccess resourceId="164">
	<jsp:attribute name="EXEC"> 
		new YAHOO.widget.Button("modifyBut");
  	</jsp:attribute>
</cps:renderByResourceAccess>  
 
<cps:renderByResourceAccess resourceId="206">
	<jsp:attribute name="EXEC">                                        
		new YAHOO.widget.Button("viewBut");                                          
	</jsp:attribute>
</cps:renderByResourceAccess>                                        
<c:choose>
	<c:when test="${manageCandidate.criteria.mrtSwitchCheck eq true}">
		<c:set value="true" var="dStr" />
	</c:when>
	<c:otherwise>
		<c:set value="false" var="dStr" />
	</c:otherwise>
</c:choose>                                        
                         
<cps:renderByResourceAccess resourceId="159">
	<jsp:attribute name="EXEC">
		new YAHOO.widget.Button("submitBut");  
	</jsp:attribute>
</cps:renderByResourceAccess>
               
<cps:renderByResourceAccess resourceId="166">
	<jsp:attribute name="EXEC">
		new YAHOO.widget.Button("copyBut");  
	</jsp:attribute>
</cps:renderByResourceAccess>

<cps:renderByResourceAccess resourceId="160">
	<jsp:attribute name="EXEC">
		new YAHOO.widget.Button("activateBut");
	</jsp:attribute>
</cps:renderByResourceAccess>  

<cps:renderByResourceAccess resourceId="162">
	<jsp:attribute name="EXEC">
		new YAHOO.widget.Button("testScanBut");
	</jsp:attribute>
</cps:renderByResourceAccess>

<cps:renderByResourceAccess resourceId="161">
	<jsp:attribute name="EXEC">
		new YAHOO.widget.Button("rejectBut"); 
	</jsp:attribute>
</cps:renderByResourceAccess>

<cps:renderByResourceAccess resourceId="281">
	<jsp:attribute name="EXEC">
		new YAHOO.widget.Button("deleteBtn"); 
	</jsp:attribute>
</cps:renderByResourceAccess>


<cps:renderByResourceAccess resourceId="240">
	<jsp:attribute name="EXEC">
		new YAHOO.widget.Button("clearFilter");
    </jsp:attribute>
</cps:renderByResourceAccess>



YAHOO.util.Event.addListener(YAHOO.util.Dom.get("clearFilter"), "click", clearFilt);

<c:if test="${manageCandidate.validForResults}">
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifyBut"), "click", modify);
	YAHOO.util.Event.addListener("viewBut", "click", sr_view);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("activateBut"), "click", submitActivate); 
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("testScanBut"), "click", testScan); 
	<c:if test="${!manageCandidate.criteria.mrtSwitchCheck}">
	YAHOO.util.Event.addListener("copyBut", "click", copyCand); 
	</c:if>
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("rejectBut"), "click", reject);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteBtn"), "click", deleteCand);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("submitBut"), "click", submit);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("printBut"), "click", printSummary);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("scaleApproveBut"), "click", scaleApprove);
</c:if>





<c:url value="/protected/cps/add/modifyCandDblClick?${_csrf.parameterName}=${_csrf.token}" var="modi"></c:url>
function modify(){
		if(document.getElementById("selectedMRTId")!=null)
			document.getElementById("allMRTIds").value = document.getElementById("selectedMRTId").value;
		var selectedWorkStatus;
		var selectedProdWorkRqstId ;
		var cnt = 0;
		var modifyWorkCand = true;
		var modifyActivationFaildedCand = true;
		var workStatus;
		if(document.getElementById('selectedProdWorkRqstId')){
			selectedProdWorkRqstId = document.getElementById('selectedProdWorkRqstId').value;
			if(selectedProdWorkRqstId!=null && selectedProdWorkRqstId!=''){
				cnt = 1;
			}
		}
				if(${manageCandidate.vendor}) {
			if(document.getElementById('selectedWorkStatus')){
				selectedWorkStatus = document.getElementById('selectedWorkStatus').value;				
				if(selectedWorkStatus!=null && selectedWorkStatus.search('Working Candidate')!=-1){
						modifyWorkCand = false;
				} else if(selectedWorkStatus!=null && selectedWorkStatus.search('Activation Failed')!=-1){
						modifyActivationFaildedCand = false;
					} 
				}
		} else if(document.getElementById('selectedWorkStatus')){
			selectedWorkStatus = document.getElementById('selectedWorkStatus').value;			
			if(selectedWorkStatus!=null && selectedWorkStatus.search('Vendor Candidate')!=-1){
				workStatus = 'Vendor Candidate';
			}
		}
		if(cnt < 1) {
			alert('Please select a candidate');
			return false;
		}else if(!modifyWorkCand){
			alert("You may not modify working candidate(s), please click view if you would like to see the details");
			return false;
		}else if(!modifyActivationFaildedCand ) {
			alert("You may not modify activation failed candidate(s), please click view if you would like to see the details");
			return false;
		} else {		
			//prevent PIA Lead, Admin (except Vendor) can be modify candidate
			if(${!manageCandidate.vendor} && workStatus=='Vendor Candidate') {
				alert("You may not modify vendor candidate(s), please click view if you would like to see the details");
				return false;
			}		
			showProgressCustomize(); 	
			//document.forms[0].action = '${modi}'+'&batchUpload='+document.getElementById('batchUploadSwitch').checked;
			//document.forms[0].submit();	 
			AddCandidateTemp.checkMultilPluReuse(YAHOO.util.Dom.get('selectedProductId').value,YAHOO.util.Dom.get('candidateTypeList').value,getDWRCallbackMethod(modifyCallBack));		
		}
}

function modifyCallBack(data){	
	if(data!='' && data == true){		
		alert('PLU(s) tied to a vendor candidate/working candidate/ an existing product. \nThis candidate cannot be modified.');	
		hideProgressCustomize();	
	} else {					
			document.forms[0].action = '${modi}'+'&batchUpload='+document.getElementById('batchUploadSwitch').checked;
			document.forms[0].submit();	 		
		}
}

<c:url value="/protected/cps/add/modifyCandDblClick?${_csrf.parameterName}=${_csrf.token}" var="modifyDbl"></c:url>
function modifyDblClick(evt, workStatus,mrtCheck){
	var prodId = evt;
	var candidateTypeArray=new Array();
	var allProdIdsSelected = new Array();
	allProdIdsSelected.push(prodId);
	if(${manageCandidate.vendor}) {
		if(workStatus == 'Working Candidate'){
			alert("You may not modify working candidate, please click view if you would like to see the details");
			return false;
		} else if(workStatus == 'Activation Failed'){
			alert("You may not modify activation failed candidate(s), please click view if you would like to see the details");
			return false;
		}
	}else{		
	    //prevent PIA Lead, Admin (except Vendor) can be modify candidate
		if(${!manageCandidate.vendor} && workStatus=='Vendor Candidate') {
			alert("You may not modify vendor candidate(s), please click view if you would like to see the details");
			return false;
		}
	}
	/*
	 * user selected a checkbox before double-click on per row
	 *@author khoapkl
	 */
	 //Fix PIM 542
	showProgress();
	candidateTypeArray.push(mrtCheck==''?'None-MRT':'MRT');
	document.getElementById('candidateTypeList').value=candidateTypeArray;		
	YAHOO.util.Dom.get('selectedProductId').value = allProdIdsSelected;
	 	AddCandidateTemp.checkPluReuse(prodId,getDWRCallbackMethod(modifyDblClickCallBack));	
	 //End Fix
	
}

function modifyDblClickCallBack(data){
	if(data!='' && data == true){		
		alert('PLU(s) tied to a vendor candidate/working candidate/ an existing product. \nThis candidate cannot be modified.');	
		hideProgress();	
	} else {
	document.forms[0].action = '${modifyDbl}'+'&batchUpload='+document.getElementById('batchUploadSwitch').checked;
	document.forms[0].submit();
}
}


<c:url value="/protected/cps/manage/scaleApprove?${_csrf.parameterName}=${_csrf.token}" var="scaleAppr"></c:url>
function scaleApprove(evt){
	if(checkSelection3(evt)){
		 var multiple = true;			
		 var message = confirm('Are you sure you want to Approve ?');
		 if(message){
      		//document.forms[0].action = '${scaleAppr}'+'&SelectedAttributeList='+workRequestArray +'&multipleApprove='+multiple;
      		document.forms[0].action = '${scaleAppr}'+'&multipleApprove='+multiple;
			document.forms[0].submit();
		 }	
	}
}


<c:url value="/protected/cps/manage/printSummary?${_csrf.parameterName}=${_csrf.token}" var="print"></c:url>
function printSummary(evt){
	if(checkSelection3(evt)){
		document.forms[0].action = '${print}';//+'&SelectedPrintList='+printRequestArray;
		document.forms[0].submit();
	}
}

<c:url value="/protected/cps/add/viewCandFromManage?${_csrf.parameterName}=${_csrf.token}" var="viewCandUrl"></c:url>
function sr_view(evt){
	if(document.getElementById("selectedMRTId")!=null)
		document.getElementById("allMRTIds").value = document.getElementById("selectedMRTId").value;
	if(checkSelection3(evt)){
		showProgressCustomize();  
		document.forms[0].action = '${viewCandUrl}'+'&batchUpload='+document.getElementById('batchUploadSwitch').checked;
		document.forms[0].submit();
	}
}


<c:url value="/protected/cps/add/copyCand?${_csrf.parameterName}=${_csrf.token}" var="copyCand"></c:url>
function copyCand(evt){	
    if(checkSelection2(evt)){ 	
        if(document.getElementById('candidateTypeList')){
            var candidateType = document.getElementById('candidateTypeList').value;
            if(candidateType=='MRT'){
                alert('MRT cannot be copied.');
            }            	
            else {           	
            	showProgressCustomize();
	  		 	document.forms[0].action = '${copyCand}' + '&batchUpload=' + document.getElementById('batchUploadSwitch').checked;
	   			document.forms[0].submit();
    		}
		}
    }
}
<c:url value="/protected/cps/manage/rejectCand?${_csrf.parameterName}=${_csrf.token}" var="rej"></c:url>
<c:url value="/protected/cps/manage/rejectCandComments?${_csrf.parameterName}=${_csrf.token}" var="toReject"></c:url>
<c:url value="/protected/cps/manage/rejectMRTCandidate?${_csrf.parameterName}=${_csrf.token}" var="rejectMRT"></c:url>
<c:url value="/protected/cps/manage/rejectCandCommentsAjax?${_csrf.parameterName}=${_csrf.token}" var="rejectCandCommentsAjax"></c:url>
function reject(evt){		
	if(checkSelection3(evt)){
		var rejectActivationFaildedCand = true;
		var rejectWorkCand = true;
		var selectedWorkStatus;	
				if(${manageCandidate.vendor}) {
			if(document.getElementById('selectedWorkStatus')){
				selectedWorkStatus = document.getElementById('selectedWorkStatus').value;				
				if(selectedWorkStatus!=null && selectedWorkStatus.search('Working Candidate')!=-1){
					rejectWorkCand = false;
				} else if(selectedWorkStatus!=null && selectedWorkStatus.search('Activation Failed')!=-1){
						rejectActivationFaildedCand = false;
				}
			}
		}
		if(!rejectActivationFaildedCand){
			alert("You may not reject activation failed candidate(s), please click view if you would like to see the details");
			return false;
		} 
		if(!rejectWorkCand){
			alert("You may not reject working candidate(s), please click view if you would like to see the details");
			return false;
		} 
		var message = confirm('Are you sure you want to reject the selected candidate(s)?');
		if(message){		
			var formObject = document.getElementById('searchForm');
			formObject.action = "${rejectCandCommentsAjax}";
			YAHOO.util.Connect.setForm(formObject); 			
			var callback = {
				success:function(o){
					hideProgress();
					try{
						 f1('${toReject}'+'&t='+new Date().getTime(),'Reject Comments','200px','62%','130px','200px');										 
						 document.getElementById('litemPop').innerHtml=o.responseText;
					}catch(e){}
				}
			};
			showProgress();
			var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);	
		 }
	}	
}

<c:url value="/protected/cps/manage/submitCandidate?${_csrf.parameterName}=${_csrf.token}" var="submited"></c:url>
function submit(evt){	
	if(document.getElementById("selectedMRTId")!=null)
		document.getElementById("allMRTIds").value = document.getElementById("selectedMRTId").value;
	if(checkSelection3(evt)){
		var modifyWorkCand = true;
		var modifyActivationFaildedCand = true;
		var selectedWorkStatus;						
				if(${manageCandidate.vendor}) {
			if(document.getElementById('selectedWorkStatus')){
				selectedWorkStatus = document.getElementById('selectedWorkStatus').value;				
				if(selectedWorkStatus!=null && selectedWorkStatus.search('Working Candidate')!=-1){
						modifyWorkCand = false;
				} else if(selectedWorkStatus!=null && selectedWorkStatus.search('Activation Failed')!=-1){
						modifyActivationFaildedCand = false;
				}
			}
		}
		if(!modifyWorkCand){
			alert("You may not submit working candidate(s), please click view if you would like to see the details");
			return false;
		}else if(!modifyActivationFaildedCand ) {
			alert("You may not submit activation failed candidate(s), please click view if you would like to see the details");
			return false;
		} 
		var message = confirm('Are you sure you want to Submit the selected candidate(s)?');
		if(message){
			showProgressCustomize();
			if(document.getElementById('submitBut')!=null) {
				document.getElementById('submitBut').disable=true;
			}
      		document.forms[0].action = '${submited}'+'&mrtCheck='+document.getElementById("allMRTIds").value;	
			document.forms[0].submit();
		}
	}
}

function showCompleter(iddd){

	if(document.getElementById('autoComplete'+iddd).style.display == 'none'){
		//arrTemp.push(iddd);
		document.getElementById('autoComplete'+iddd).style.display = 'block';
		
	}else if(document.getElementById('autoComplete'+iddd).style.display == 'block'){
		//removeByValue(arrTemp,iddd);
		document.getElementById('autoComplete'+iddd).style.display = 'none';
	}
}
function removeByValue(arr, val) {
    for(var i=0; i<arr.length; i++) {
        if(arr[i] == val) {
            arr.splice(i, 1);
            break;
        }
    }
}
/*@author khoapkl*/
function showMrtSwitch() {
	if(document.getElementById('mrtSwitchFilter').style.display=='none') {
		document.getElementById('mrtSwitchFilter').style.display='';
		arrTemp.push("8");		
	} else if (document.getElementById('mrtSwitchFilter').style.display=='') {
		document.getElementById('mrtSwitchFilter').style.display='none';
		removeByValue(arrTemp,"8");
	}
}	
function clearFlt(){
	if(document.getElementById('vndrDesc')){	document.getElementById('vndrDesc').value = '';}
	if(document.getElementById('source')){	document.getElementById('source').value = '';}
	if(document.getElementById('vndrUnitUpc')){	document.getElementById('vndrUnitUpc').value = '';}
	if(document.getElementById('prdDesc')){	document.getElementById('prdDesc').value = '';}
	if(document.getElementById('prodPresDate')){	document.getElementById('prodPresDate').value = '';}
	if(document.getElementById('status')){	document.getElementById('status').value = '';}
	if(document.getElementById('testScanStatus')){	document.getElementById('testScanStatus').value = '';}
	if(document.getElementById('listCost')){	document.getElementById('listCost').value = '';}
	if(document.getElementById('shipPack')){	document.getElementById('shipPack').value = '';}
	if(document.getElementById('masterPack')){	document.getElementById('masterPack').value = '';}
	if(document.getElementById('mrtSwitch')) {
		document.getElementById('mrtSwitch').checked=false;
	} 
}

clearFlt();

function hide(elem){
	var data = document.getElementById(elem);
	if (data){
		data.style.display = 'none';
	}
}

function clearFilt(){
<cps:renderByResourceAccess resourceId="225">
<jsp:attribute name="EDIT">
    vndrDescClear();
    hide('autoComplete1');
</jsp:attribute>	
<jsp:attribute name="VIEW">
    vndrDescClear();
    hide('autoComplete1');
</jsp:attribute>									
</cps:renderByResourceAccess>
<cps:renderByResourceAccess resourceId="145">
<jsp:attribute name="EDIT">
    vndrUnitUpcClear();
    hide('autoComplete2');
</jsp:attribute>
<jsp:attribute name="VIEW">
    vndrUnitUpcClear();
    hide('autoComplete2');
</jsp:attribute>										
</cps:renderByResourceAccess>
<cps:renderByResourceAccess resourceId="146">
<jsp:attribute name="EDIT">
    prdDescClear();
    hide('autoComplete3');
</jsp:attribute>		
<jsp:attribute name="VIEW">
    prdDescClear();
    hide('autoComplete3');
</jsp:attribute>								
</cps:renderByResourceAccess>
<cps:renderByResourceAccess resourceId="241">
<jsp:attribute name="EDIT">
prodPresDateClear();
hide('autoComplete5');
</jsp:attribute>		
<jsp:attribute name="VIEW">
prodPresDateClear();
hide('autoComplete5');
</jsp:attribute>								
</cps:renderByResourceAccess>

<cps:renderByResourceAccess resourceId="149">
<jsp:attribute name="EDIT">
    statusClear();
    hide('autoComplete6');
</jsp:attribute>	
<jsp:attribute name="VIEW">
    statusClear();
    hide('autoComplete6');
</jsp:attribute>									
</cps:renderByResourceAccess>
<cps:renderByResourceAccess resourceId="155">
<jsp:attribute name="EDIT">
    testScanStatusClear();
    hide('autoComplete7');
</jsp:attribute>			
<jsp:attribute name="VIEW">
    testScanStatusClear();
    hide('autoComplete7');
</jsp:attribute>							
</cps:renderByResourceAccess>
<cps:renderByResourceAccess resourceId="226">
<jsp:attribute name="EDIT">
	if(document.getElementById('mrtSwitch').checked==true) {
		document.getElementById('mrtSwitch').checked=false;
	} 
</jsp:attribute>			
<jsp:attribute name="VIEW">
	if(document.getElementById('mrtSwitch').checked==true) {
		document.getElementById('mrtSwitch').checked=false;
	} 
</jsp:attribute>	
</cps:renderByResourceAccess>
	document.getElementById('mrtSwitchFilter').style.display='none';
	arrTemp = new Array();	
	if (document.getElementById('selectedProductId')) {
		document.getElementById('selectedProductId').value = "";
	}
	if (YAHOO.util.Dom.get('selectedProdWorkRqstId')) {
		YAHOO.util.Dom.get('selectedProdWorkRqstId').value="";
	}
	if (document.getElementById('candidateTypeList')) {
		document.getElementById('candidateTypeList').value="";
	}
	filterChange(true);
}

var panels = new Array();
var i=0;
for(i=0;i<11;i++){
panels[i] = new YAHOO.widget.Panel("filterPanel"+i, { xy:[250,250], width: "350px", visible: false } );
panels[i].render();
}

function filterChangeOnthis(val, stylId){
	clearFlt();
	document.getElementById(stylId).value = val;
	panels[shownPanelIndex].hide();
	filterChange(null);
}

var shownPanelIndex;

function showPanel(index){
	panels[index].show();	
	panels[index].moveTo(250,250);
	shownPanelIndex = index;
}



var sortedCol = null;
var dir = "down";

function sortColumn(col){

	if(col == sortedCol){
		if(dir == "down"){
			dir = "up";
		}else{
			dir = "down";
		}
	}else{
		dir = "up";
	}
	d = dir;
	var sr = null;
	if(dir == 'up'){
		sr = '${upArrow}';
	}else{
		sr = '${downArrow}';
	}
	if(null != sortedCol){
		document.getElementById('d'+sortedCol).innerHTML = '';
	}
	document.getElementById('d'+col).innerHTML = '<img src="'+sr+'" />';
	sortedCol = col;
	var caseVl = col + 1;
	sort(dir, caseVl);

}

<c:url value="/protected/cps/manage/activate?${_csrf.parameterName}=${_csrf.token}" var="activate" />
function submitActivate(evt) {
	if(document.getElementById("selectedMRTId")!=null)
		document.getElementById("allMRTIds").value = document.getElementById("selectedMRTId").value;
	if(checkSelection3(evt)) {
		var cnt=0;
		var selectedWorkStatus;		
		if(document.getElementById('selectedWorkStatus')){
			selectedWorkStatus = document.getElementById('selectedWorkStatus').value;				
			if(selectedWorkStatus!=null && selectedWorkStatus.search('Vendor Candidate')!=-1){
					cnt = 1;
			}
		}
		if(cnt==1) {
			alert("You may not activate vendor candidate(s), please click view if you would like to see the details");
			return false;	
		}
		//PIM 354
		//showProgressCustomize();				
		var allProdIdsSelected ="";					
		/*--for(i=0; i<nb; i++) {
			if(checks[i].checked) {
				if(document.getElementById("hiddMrtLabel"+i).value=='') {
					allProdIdsSelected+=document.getElementById('hiddProdId'+i).value +",";
				}							
			}
		}*/			
		allProdIdsSelected = document.getElementById('selectedProductCandidateId').value;
		if(allProdIdsSelected!=""){		
			showProgressCustomize();			
		 	AddCandidateTemp.warningTaxFoodStamp(allProdIdsSelected,getDWRCallbackMethod(warningTaxFoodStampCallBack));	
		} else {
		var message = confirm('Are you sure you want to activate the selected candidate(s)?');
		if(message){
			showProgressCustomize();
			if(document.getElementById('activateBut')!=null) {
				document.getElementById('activateBut').disabled =true;
			}	
      		document.forms[0].action = '${activate}'+
      		    					'&mrtCheck='+document.getElementById("allMRTIds").value+
      		    					'&batchUpload='+document.getElementById("batchCandidate").value;
			document.forms[0].submit();
		}
	}
}	
}	
function warningTaxFoodStampCallBack(data){
	if(data!=''){
		hideProgressCustomize();		
		var messageSelected = confirm(data);
		if(messageSelected){
			showProgressCustomize();	
			if(document.getElementById('activateBut')!=null) {
				document.getElementById('activateBut').disabled =true;
			}	
      		document.forms[0].action = '${activate}'+
      		    					'&mrtCheck='+document.getElementById("allMRTIds").value+
      		    					'&batchUpload='+document.getElementById("batchCandidate").value;
			document.forms[0].submit();
		} 
	} else {
		hideProgressCustomize();
		var message = confirm('Are you sure you want to activate the selected candidate(s)?');
		if(message){
			showProgressCustomize();	
			if(document.getElementById('activateBut')!=null) {
				document.getElementById('activateBut').disabled =true;
			}	
	  		document.forms[0].action = '${activate}'+
	  		    					'&mrtCheck='+document.getElementById("allMRTIds").value+
	  		    					'&batchUpload='+document.getElementById("batchCandidate").value;
			document.forms[0].submit();
		}
	}
	
}	
function closeConfirm(){
	var message = confirm('Are you sure you want to quit Test Scan?');
 	if(message)
 		return true;
 	else
 		return false;
}

<c:url value="/protected/cps/manage/testScan?${_csrf.parameterName}=${_csrf.token}" var="page1" />
<c:url value="/protected/cps/manage/testScanAjax?${_csrf.parameterName}=${_csrf.token}" var="testScanAjax" />
function testScan(evt){
	var mrtcheck='';
	if(document.getElementById("selectedMRTId")!=null)
		mrtcheck = document.getElementById("selectedMRTId").value;
	if(checkSelection3(evt)) {
		if(mrtcheck == 'false' && !isMrt) { 
			var cnt=0;
			var rejectTestScanFaildedCand = true;
			var selectedWorkStatus;		
			if(document.getElementById('selectedWorkStatus')){
				selectedWorkStatus = document.getElementById('selectedWorkStatus').value;				
				if(selectedWorkStatus!=null && selectedWorkStatus.search('Vendor Candidate')!=-1){
						cnt = 1;
					} 
				if(selectedWorkStatus!=null && selectedWorkStatus.search('Activation Failed')!=-1){
							rejectTestScanFaildedCand = false;
				}
			}
			if(cnt==1 && ${!manageCandidate.vendor}) {
				alert("You may not test scan vendor candidate(s), please click view if you would like to see the details");
				return false;	
			}
			if(!rejectTestScanFaildedCand){
				alert("You may not test scan activation failed candidate(s), please click view if you would like to see the details");
				return false;
			}
			var formObject = document.getElementById('searchForm');
			formObject.action = "${testScanAjax}";
			YAHOO.util.Connect.setForm(formObject); 			
			var callback = {
				success:function(o){
					hideProgress();
					try{
						generateTestScanPopup(o.responseText);
					}catch(e){}
				}
			};
			showProgress();
			var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
			// beforePopUpClose(closeConfirm);
			 //f1("${page1}"+'&t='+new Date().getTime()+'&selecetedValues='+searchArray,"Available UPCs",'300px','70%','200px','200px');
			 //document.getElementById("pnl123").style.dataType = 'numeric';
		} else {
			alert('Test scan is not available for MRT candidate');
		}
	} 
}
var intentIdentifierSelected = null;
	function selectCheckboxes() {	
	    /*check object is not null
		 *@author khoapkl
		 */
		var allProdIdsSelected = new Array();
		var productTypeArray = new Array();
		var prodWorkRqstId=new Array();
		intentIdentifierSelected = new Array();
		if(document.getElementById('check')!=null) {
			if(document.getElementById('checkAll').checked){
				document.getElementById('check').checked=true;
			} else {
				document.getElementById('check').checked=false;
			}     
			var checkedValue = document.getElementById('checkAll').checked;
			var checks=document.getElementsByName('candSelectCheck');			
			for(i=0; i<checks.length; i++) {
				checks[i].checked=checkedValue;
				if(checkedValue) {
					allProdIdsSelected.push(YAHOO.util.Dom.get('hiddProdId'+i).value);
					prodWorkRqstId.push(document.getElementById("workId"+i).value+":"+document.getElementById("hiddProdId"+i).value);
					if(document.getElementById("hiddMrtLabel"+i).value=='') {
						productTypeArray.push('None-MRT');
					} else {
						productTypeArray.push(document.getElementById("hiddMrtLabel"+i).value);
					}
					intentIdentifierSelected.push(YAHOO.util.Dom.get('intentIdentifier'+i).value);
				}			
			}
			//khoapkl			
			for(var j=0;j<productTypeArray.length;j++) {
				if(productTypeArray[0]=='None-MRT') {
					document.getElementById("selectedMRTId").value=false;
				} else {
					document.getElementById("selectedMRTId").value=true;
				}
				if(productTypeArray[j]=='MRT') {
					isMrt=true;
					break;
				} else {
					isMrt=false;
				}
			}

			YAHOO.util.Dom.get('selectedProdWorkRqstId').value=prodWorkRqstId;
			YAHOO.util.Dom.get('candidateTypeList').value=productTypeArray;
			YAHOO.util.Dom.get('selectedProductId').value = allProdIdsSelected;
			YAHOO.util.Dom.get('allIds').value = allProdIdsSelected;
		}          					
	}
	
	function selectSingle(){
		var cnt =0;
		var HeaderCheckBox = document.getElementById('checkAll');
		var nb = document.all.item('check').length;
		    for(i=0; i<nb; i++) {
		        if(document.all.item('check', i).checked)
		        	cnt++;
		    }	
		if(cnt<nb){
			HeaderCheckBox.checked = false;
		}
   		else if(cnt == nb){
      		HeaderCheckBox.checked = true;
		}
	}
		
	
	<c:url value="/protected/cps/add/classification?${_csrf.parameterName}=${_csrf.token}" var="actn"></c:url>
		
	function checkSelection(evt) {
		   var nb = document.all.item('check').length;
		   var cnt = 0;
		    for(i=0; i<nb; i++) {
		        if(document.all.item('check', i).checked)
		        	cnt++;
		    }
		    if(cnt < 1){
		    	alert('Please select a candidate');
		    	return false;
		    }else
		    	return true;
		}
	function checkSelection2(evt) {
		var checks = document.getElementsByName('candSelectCheck');
		var cnt = 0;
		var flagMultil = 'false';
		var flagSelected = 'true';
		for(var i =0;i<checks.length;i++){
			if(checks[i].checked){
				cnt++;
			}
		}	
		if(document.getElementById('selectedProdWorkRqstId')){
			workRequestSelected = document.getElementById('selectedProdWorkRqstId').value;
			if(workRequestSelected != null && workRequestSelected.indexOf(',')!=-1){
				flagMultil = 'true';
				flagSelected = 'true';
			} else if(workRequestSelected != null && workRequestSelected==''){
				flagMultil = 'false';
				flagSelected = 'false';
			}	
		}else{
			flagSelected = 'false';
		}	
	    if(cnt > 1 && flagMultil == 'true'){
	    	alert('Please select one candidate to Copy');
	    	return false;
	    }else if(cnt < 1 && flagSelected == 'false'){
	    	alert('Please select a candidate');
	    	return false;
	    }else{
	    	//Sprint - 23
			if(intentIdentifierSelected!=null) {
				for(var i =0;i<intentIdentifierSelected.length;i++){
					if(intentIdentifierSelected[i]==12) {
						alert("A kit cannot be copied.");
						return false;
					}
				}
			}
			return true;
	    }

	}

	// checkSelection function for approve,reject and delete candidate
	function checkSelection3(evt) {
		var checks = document.getElementsByName('candSelectCheck');
		var cnt = 0;
		var workRequestSelected;
		var flagSelected='false';
		for(var i =0;i<checks.length;i++){
			if(checks[i].checked){
				cnt++;
			}
		}	
		if(document.getElementById('selectedProdWorkRqstId')){
			 workRequestSelected = document.getElementById('selectedProdWorkRqstId').value;		
			 if(workRequestSelected != null && workRequestSelected!= ''){
				 flagSelected = 'true';
			 }
		}	
	    if(cnt < 1 && flagSelected == 'false'){
	    	alert('Please select a candidate');
	    	return false;
	    }else{
	    	return true;
	    }
	}

	function submitPage(evt){ 
		if(checkSelection(evt)){   
			document.forms[0].action = '${prod}';
			document.forms[0].submit();
		}
	}
	
	//function popUp1(evt){
	///	var sel = document.getElementById('actions1');
	//	if(sel.options[sel.selectedIndex].value == '01'||sel.options[sel.selectedIndex].value == '02'){
	//		if(checkSelection2(evt)){   
	//			var prms = '';
	//			if(sel.options[sel.selectedIndex].value == '01'){
	//				prms = prms + '&action=modify'; 
	//			}else if(sel.options[sel.selectedIndex].value == '02'){
	//				prms = prms + '&action=activate'; 
	//			}
	//			document.forms[0].action = '${prod}'+prms;
	//			document.forms[0].submit();
	//		}
	//	}
	//	if(sel.options[sel.selectedIndex].value == '03'){
	//		submitActivate(evt);
	//	}
	//	if(sel.options[sel.selectedIndex].value == '04'){
	//		submitReject(evt);
	//	}
	//	if(sel.options[sel.selectedIndex].value == '05'){
	//		testScan(evt);
	//	}
		
//	}	
	
<c:url value="/protected/cps/manage/filterChange?${_csrf.parameterName}=${_csrf.token}" var="link"></c:url>
	function filterChange(evt){
		var formObject = document.getElementById('searchForm');
		formObject.action = "${link}";
		YAHOO.util.Connect.setForm(formObject); 
		
		var callback = {
			success:function(o){
				hideProgress();
				try{
					document.getElementById('results').innerHTML =o.responseText;
					var checks = document.getElementsByName('candSelectCheck');	
					var workRequestSelected = document.getElementById('selectedProdWorkRqstId').value;					
					for(var i =0;i<checks.length;i++){
						if(document.getElementById('checkAll').checked){
							document.getElementById('checkAll').checked=false;
						}
						//	document.getElementById('check'+i).checked=true;
						//} else {
							prodWorkRqstSelectId = document.getElementById("workId"+i).value+":"+document.getElementById("hiddProdId"+i).value;							
							if(workRequestSelected!=null && workRequestSelected.search(prodWorkRqstSelectId)!=-1){
								document.getElementById('check'+i).checked=true;
							} else {
								document.getElementById('check'+i).checked=false;	
							}
						//}	
						//Clear all check-boxes when user clicking on Clear Filter button
						if(evt==true) {
							document.getElementById('check'+i).checked=false;
						}
					}
					if(document.getElementById('msgError')!=null) {
						document.getElementById('errors').innerHTML='<ul>'+handleMessageFilter(document.getElementById('msgError').value,document.getElementById('msgIndex').value)+'</ul>';
					}
				}catch(err){}
			}
		};
		//document.getElementById('results').innerHTML = tempHtml1; //Defect#819
		showProgress();
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
		
		//to clear selected checkboxes on filter
		//document.getElementById('checkAll').checked = false; 
		//nb = document.all.item('check').length;
		//    for(i=0; i<nb; i++) {
		 //       document.all.item('check', i).checked=false;
		 //   }	
	}

	/*@author khoapkl*/
	function handleMessageFilter(msgError,msgIndex) {
		var msg='';
		if(msgIndex=='1') {
			msg+='<LI><font color="\Blue\" size="\1px\">'+msgError+'</li>';
		} else if(msgIndex=='2') {
			msg+='<LI><font color="\#980000\" size="\1px\">'+msgError+'</li>';
		} else if(msgIndex=='3') {
			msg+='<LI><font color="\#C80000\" size="\1px\">'+msgError+'</li>';
		} else {
			msg+='<LI><font color="\#FF0000\" size="\1px\">'+msgError+'</li>';
		}
		return msg;
	}	
	<c:url value="/protected/cps/manage/updateRejectMessage?${_csrf.parameterName}=${_csrf.token}" var="updateMessage"></c:url>
	function updateMessage(){
		showProgress();
		document.forms[0].action = '${updateMessage}';
		document.forms[0].submit();
	}	
var isSelected=false;
var isMrt=false;
function selectSingleProduct(){
	var allProdIdsSelected = new Array();
    var checks = document.getElementsByName('candSelectCheck');
	var candidateTypeArray = new Array();
	var prodWorkRqstId= new Array();
	isSelected=true;
    for(var i =0;i<checks.length;i++){
    	if(checks[i].checked){
    		allProdIdsSelected.push(document.getElementById('hiddProdId'+i).value);
    		prodWorkRqstId.push(document.getElementById("workId"+i).value+":"+document.getElementById("hiddProdId"+i).value);
			//khoapkl
			if(document.getElementById("hiddMrtLabel"+i).value=='') {
				candidateTypeArray.push('None-MRT');
			} else {
				candidateTypeArray.push(document.getElementById("hiddMrtLabel"+i).value);
			}		
	    }
    } 
	//khoapkl
	for(var j=0;j<candidateTypeArray.length;j++) {
		if(candidateTypeArray[0]=='None-MRT') {
			document.getElementById("selectedMRTId").value=false;
		} else {
			document.getElementById("selectedMRTId").value=true;
		}
		if(candidateTypeArray[j]=='MRT') {
			isMrt=true;
			break;
		} else {
			isMrt=false;
		}
	}
	YAHOO.util.Dom.get('selectedProdWorkRqstId').value=prodWorkRqstId;
	document.getElementById('candidateTypeList').value=candidateTypeArray;
	document.getElementById('selectedProductId').value = allProdIdsSelected;
    document.getElementById('allIds').value = allProdIdsSelected;
}
function selectSingleProductNew(temp){	
	var idProduct = temp.id;
	idProduct = idProduct.substr(5);	
	var prodWorkRqstId = YAHOO.util.Dom.get('selectedProdWorkRqstId').value;
	var candidateTypeArray = document.getElementById('candidateTypeList').value;
	var allProdIdsSelected = document.getElementById('selectedProductId').value;	
	var allWorkStatus = document.getElementById('selectedWorkStatus').value;
	var allSelectedProductCandidateId = document.getElementById('selectedProductCandidateId').value;
	var productid = document.getElementById('hiddProdId'+idProduct).value ;
	var	prodWorkRqstSelectId = document.getElementById("workId"+idProduct).value+":"+document.getElementById("hiddProdId"+idProduct).value;		
	var hiddMrtLabel =document.getElementById("hiddMrtLabel"+idProduct).value;
	var workStatus =document.getElementById("workStatus"+idProduct).value;	
	intentIdentifierSelected = new Array();
	if(hiddMrtLabel == '')
		hiddMrtLabel = 'None-MRT';
	if(allProdIdsSelected.search(productid)==-1 && temp.checked){	
		if(allSelectedProductCandidateId == null || allSelectedProductCandidateId =='')
		{
			if(hiddMrtLabel=='None-MRT')
			{
				allSelectedProductCandidateId = productid;
			}
		} 
		else
		{
			if(hiddMrtLabel=='None-MRT')
			{
				allSelectedProductCandidateId = allSelectedProductCandidateId + "," +productid;
			}
		}
		if(allProdIdsSelected == null || allProdIdsSelected == ''){
			allProdIdsSelected = productid;	
			allWorkStatus = workStatus;				
		}else if(hiddMrtLabel=='None-MRT' && candidateTypeArray.search('MRT')!=-1){
			allProdIdsSelected = productid + "," +allProdIdsSelected;
			allWorkStatus = workStatus + "," +allWorkStatus;	
		} else {
			allProdIdsSelected = allProdIdsSelected + "," +productid;
			allWorkStatus = allWorkStatus + "," +workStatus;	
		}
		if(prodWorkRqstId == null || prodWorkRqstId == ''){
			prodWorkRqstId = prodWorkRqstSelectId;
		}
		else if(hiddMrtLabel=='None-MRT' && candidateTypeArray.search('MRT')!=-1){
			prodWorkRqstId = prodWorkRqstSelectId + "," +prodWorkRqstId;
		} else {
			prodWorkRqstId = prodWorkRqstId + "," +prodWorkRqstSelectId;
		}
		if(candidateTypeArray == null || candidateTypeArray == ''){
			candidateTypeArray = hiddMrtLabel;	
		}
		else if(hiddMrtLabel=='None-MRT' && candidateTypeArray.search('MRT')!=-1){
			candidateTypeArray = hiddMrtLabel + "," + candidateTypeArray;
		} else {	
			candidateTypeArray = candidateTypeArray + "," + hiddMrtLabel;
		}				
		YAHOO.util.Dom.get('selectedProdWorkRqstId').value=prodWorkRqstId;
		document.getElementById('candidateTypeList').value=candidateTypeArray;
		document.getElementById('selectedProductId').value = allProdIdsSelected;
		document.getElementById('selectedWorkStatus').value = allWorkStatus;
	    document.getElementById('allIds').value = allProdIdsSelected;
	    document.getElementById('selectedProductCandidateId').value = allSelectedProductCandidateId;
		intentIdentifierSelected.push(YAHOO.util.Dom.get('intentIdentifier'+idProduct).value);
	} else if(!temp.checked && allProdIdsSelected.search(document.getElementById('hiddProdId'+idProduct).value)!=-1){	
		
		if(allProdIdsSelected.indexOf(',')==-1){
			allProdIdsSelected = allProdIdsSelected.replace(productid,"");
		} else if(allProdIdsSelected.indexOf(','+productid) != -1){			
			allProdIdsSelected = allProdIdsSelected.replace(','+productid,"");
		} else {				
			allProdIdsSelected = allProdIdsSelected.replace(productid+',',"");
		}
		if(prodWorkRqstId.indexOf(',')==-1){
			prodWorkRqstId = prodWorkRqstId.replace(prodWorkRqstSelectId,"");
		} else if(prodWorkRqstId.indexOf(','+prodWorkRqstSelectId) != -1){			
			prodWorkRqstId = prodWorkRqstId.replace(','+prodWorkRqstSelectId,"");
		} else {			
			prodWorkRqstId = prodWorkRqstId.replace(prodWorkRqstSelectId+',',"");
		}
		if(candidateTypeArray.indexOf(',')==-1){
			candidateTypeArray ="";
		} else {
			if(hiddMrtLabel == 'MRT')
				candidateTypeArray = candidateTypeArray.substr(0,candidateTypeArray.length -4);
			else
				candidateTypeArray = candidateTypeArray.substr(9);
		 }
		allWorkStatus = allWorkStatus.replace(workStatus,"");
		if(allSelectedProductCandidateId.search(document.getElementById('hiddProdId'+idProduct).value)!=-1)
		{
			if(allSelectedProductCandidateId.indexOf(',')==-1){
				allSelectedProductCandidateId = allSelectedProductCandidateId.replace(productid,"");
			} else if(allSelectedProductCandidateId.indexOf(','+productid) != -1){			
				allSelectedProductCandidateId = allSelectedProductCandidateId.replace(','+productid,"");
			} else {				
				allSelectedProductCandidateId = allSelectedProductCandidateId.replace(productid+',',"");
			}
		}
		YAHOO.util.Dom.get('selectedProdWorkRqstId').value=prodWorkRqstId;
		document.getElementById('candidateTypeList').value=candidateTypeArray;
		document.getElementById('selectedProductId').value = allProdIdsSelected;
		document.getElementById('selectedWorkStatus').value = allWorkStatus;
	    document.getElementById('allIds').value = allProdIdsSelected;
	    document.getElementById('checkAll').checked = false;		
		document.getElementById('selectedProductCandidateId').value = allSelectedProductCandidateId;
	}
	if(candidateTypeArray!=null && (candidateTypeArray.indexOf('MRT')==0 || candidateTypeArray.indexOf(',MRT')!=-1)){
		isMrt=true;	
		document.getElementById("selectedMRTId").value=true;
	} else {
		isMrt=false;	
		document.getElementById("selectedMRTId").value=false;		
	}	
	var checks = document.getElementsByName('candSelectCheck');
	if(checks.length==allProdIdsSelected.split(',').length && allProdIdsSelected.split(',')!="") {
		document.getElementById('checkAll').checked = true;	
	}
}


<c:url value="/protected/cps/manage/checkAlls?${_csrf.parameterName}=${_csrf.token}" var="checkAllsURL"></c:url>
function selectAllCheckboxNews() {    
	if(document.getElementById('checkAll')){	
		var formObject = document.getElementById('searchForm');			
		formObject.action = '${checkAllsURL}'+'&flag='+document.getElementById('checkAll').checked;	
		YAHOO.util.Connect.setForm(formObject); 	
		var callback = {
			success:function(o){
				hideProgress();	
				try{
					var	prodWorkRqstSelectId;
					document.getElementById('results').innerHTML =o.responseText;
					var checks = document.getElementsByName('candSelectCheck');	
					var workRequestSelected = document.getElementById('selectedProdWorkRqstId').value;		
					var candidateTypeList = document.getElementById('candidateTypeList').value;							
					for(var i =0;i<checks.length;i++){
						if(document.getElementById('checkAll').checked)
							document.getElementById('check'+i).checked=true;
						else
							document.getElementById('check'+i).checked=false;
					}
					if(candidateTypeList!=null && (candidateTypeList.indexOf('MRT')==0 || candidateTypeList.indexOf(',MRT')!=-1)){
						isMrt=true;	
						document.getElementById("selectedMRTId").value=true;
					} else {
						isMrt=false;	
						document.getElementById("selectedMRTId").value=false;		
					}	
					if(document.getElementById('msgError')!=null) {
						document.getElementById('errors').innerHTML='<ul>'+handleMessageFilter(document.getElementById('msgError').value,document.getElementById('msgIndex').value)+'</ul>';
					}
				}catch(err){}		
			}
		};
		//document.getElementById('results').innerHTML = tempHtml1; //Defect#819
		showProgress();
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);		
	}			
}
function selectAllCheckboxCallBack(data){	
	var checks = document.getElementsByName('candSelectCheck');	
	for(var i =0;i<checks.length;i++){
		if(document.getElementById('checkAll').checked)
			document.getElementById('check'+i).checked=true;
		else
			document.getElementById('check'+i).checked=false;
	}	
}

/////////////////////////////////////////////////////  TEST SCAN...
YAHOO.namespace("heb.container.testScanNew");
<c:url value="/protected/cps/manage/testScan?${_csrf.parameterName}=${_csrf.token}" var="testScanNewURL"></c:url>
		
var once = false;		
function generateTestScanPopup(data){	
	showProgress();
	document.getElementById("panel2").style.display="block";
	document.getElementById("panel2").style.position="fixed";
	if(once == false){
		once = true;
		YAHOO.heb.container.testScanNew = new YAHOO.widget.Panel("panel2", 
		{ 	width:"700px", 
			height:"500px", 
			underlay:"shadow",
			visible:false, 
			constraintoviewport:true, 
			draggable:false,	
			zIndex : 55000,						
			modal:true,
			close:false,
			fixedCenter : true							
		} );
		
		YAHOO.heb.container.testScanNew.render();	
	}	
	
	YAHOO.heb.container.testScanNew.beforeHideEvent.subscribe(onBeforeHideEvent);
	YAHOO.heb.container.testScanNew.beforeShowEvent.subscribe(onBeforeShowEvent);		
	YAHOO.heb.container.testScanNew.show();
	
	
	document.getElementById("popupFrame").style.height="100%";
	document.getElementById("popupFrame").style.width="100%";
	document.getElementById("popupFrame").src = "${testScanNewURL}"+'&t='+new Date().getTime();//+'&selecetedValues='+searchArray;
	document.getElementById("popupHeader").innerHTML = '<font size="2" color="white">&nbsp;&nbsp;&nbsp; Available UPCs</font>';		
	document.getElementById("popupFrame").innerHTML =data;
}

function hideTheProgress(){
	hideProgress();
}

function onShowEvent(){
	YAHOO.heb.container.testScanNew.showMask();
}

function onBeforeShowEvent(){
	YAHOO.heb.container.testScanNew.hideMask();
}

function onBeforeHideEvent(){
	document.getElementById("panel2").style.display="none";
	document.getElementById("popupFrame").src = "";
	document.getElementById("popupHeader").innerHTML = "";
}
function closePopup(){
	//Fix 1053. Reload the screen after testscan
	showProgress();
	searchCandidate();
	YAHOO.heb.container.testScanNew.hide();
}

function closeIt(){
	if(confirm("Exit Test Scan? (click OK to exit)")){
		closePopup();
	}
}
<c:url value="/protected/cps/manage/loadPagingSearch?${_csrf.parameterName}=${_csrf.token}" var="loadPagingSearchURL"></c:url>
function loadAjaxForSearch(pageCurrent,numView){
	var formObject = document.getElementById('searchForm');	
	formObject.action = '${loadPagingSearchURL}'+'&pageSet='+pageCurrent+'&numSet='+numView;	
	YAHOO.util.Connect.setForm(formObject); 	
	var callback = {
		success:function(o){
			hideProgress();	
			try{
				var	prodWorkRqstSelectId;
				document.getElementById('results').innerHTML =o.responseText;
				var checks = document.getElementsByName('candSelectCheck');	
				var workRequestSelected = document.getElementById('selectedProdWorkRqstId').value;				
				for(var i =0;i<checks.length;i++){
					//if(document.getElementById('checkAll').checked){
					//	document.getElementById('check'+i).checked=true;
					//} else {
						prodWorkRqstSelectId = document.getElementById("workId"+i).value+":"+document.getElementById("hiddProdId"+i).value;							
						if(workRequestSelected!=null && workRequestSelected.search(prodWorkRqstSelectId)!=-1){
							document.getElementById('check'+i).checked=true;
						} else {
							document.getElementById('check'+i).checked=false;	
						}
					//}					
				}
				if(document.getElementById('msgError')!=null) {
					document.getElementById('errors').innerHTML='<ul>'+handleMessageFilter(document.getElementById('msgError').value,document.getElementById('msgIndex').value)+'</ul>';
				}
			}catch(err){}		
		}
	};
	//document.getElementById('results').innerHTML = tempHtml1; //Defect#819
	showProgress();
	var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
}

<c:url value="/protected/cps/manage/deleteCand?${_csrf.parameterName}=${_csrf.token}" var="deleteCand"></c:url>
function deleteCand(evt){	
    if(checkSelection3(evt)){ 	
        if(document.getElementById('selectedWorkStatus')){
            var workStatus = document.getElementById('selectedWorkStatus').value;
            
            var message = confirm('Are you sure you want to Delete the selected candidate(s)?');
    		if(message){
            	showProgressCustomize();          	
	  		 	document.forms[0].action = '${deleteCand}';
	   			document.forms[0].submit();
	
    		}
		}
    }
}
</script>