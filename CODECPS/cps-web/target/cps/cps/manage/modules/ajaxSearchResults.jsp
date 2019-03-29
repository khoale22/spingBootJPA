<%@ page import="com.heb.operations.cps.model.ManageCandidate" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<div id="resultData" style="overflow-x: auto;overflow-y:auto;height: 270px;">
		<input type="hidden" id="allIds" value="-" name="hiddenTxt"/>
		<input type="hidden" id="allMRTIds" value="-" name="hidMrtSwitch"/>
		<input type="hidden" name="selectedProductId" value="${manageCandidate.selectedProductId}" id="selectedProductId"/>
		<input type="hidden" name="selectedMRTId" value="${manageCandidate.hidManageMrtSwitch}" id="selectedMRTId"/>
		<input type="hidden" name="candidateTypeList" value="${manageCandidate.candidateTypeList}" id="candidateTypeList"/>
		<input type="hidden" name="batchCandidate" value="${manageCandidate.batchCandidate}" id="batchCandidate"/>
		<input type="hidden" name="selectedProdWorkRqstId" value="${manageCandidate.selectedProdWorkRqstId}" id="selectedProdWorkRqstId"/>
		<input type="hidden" name="selectedWorkStatus" value="${manageCandidate.selectedWorkStatus}" id="selectedWorkStatus"/>
		<input type="hidden" name="selectedProductCandidateId" value="${manageCandidate.selectedProductCandidateId}" id="selectedProductCandidateId"/>
	<c:set var="index" value="1"/>  
	<c:set var="lst" value="${manageCandidate.messages}"></c:set>
	<div id="errorAjax">
		<c:forEach var="msg" items="${lst}" varStatus="rowCounter" >
			<c:set var="index" value="${index+1}"/> 
			<c:choose>
				<c:when test="${msg.errorSeverity.errorSeverityValue == 4}">
					<input type="hidden" id="msgError" value="${msg.message}" name="msgError"/>
					<input type="hidden" id="msgIndex" value="${msg.errorSeverity.errorSeverityValue}" name="msgIndex"/>
				</c:when>
				<c:when test="${msg.errorSeverity.errorSeverityValue == 3}">
				<input type="hidden" id="msgError" value="${msg.message}" name="msgError"/>
					<input type="hidden" id="msgIndex" value="${msg.errorSeverity.errorSeverityValue}" name="msgIndex"/>
				</c:when>
				<c:when test="${msg.errorSeverity.errorSeverityValue == 2}">
					<input type="hidden" id="msgError" value="${msg.message}" name="msgError"/>
					<input type="hidden" id="msgIndex" value="${msg.errorSeverity.errorSeverityValue}" name="msgIndex"/>
				</c:when>
				<c:when test="${msg.errorSeverity.errorSeverityValue == 1}">
					<input type="hidden" id="msgError" value="${msg.message}" name="msgError"/>
					<input type="hidden" id="msgIndex" value="${msg.errorSeverity.errorSeverityValue}" name="msgIndex"/>
				</c:when>
			</c:choose>
		</c:forEach>
	</div>
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="dataGrid" bordercolor=red>
		<c:forEach items="${manageCandidate.productsDisplay}" var="product" varStatus="loop" >
		<c:url value="/protected/cps/add/pow?${_csrf.parameterName}=${_csrf.token}" var="pow"></c:url>
			<tr ondblclick="modifyDblClick('${product.psProdId}','${product.workStatusDesc}','${product.mrtLabel}');">
				<td class="row${loop.index%2}"  align="left" width="2%">
				<input type="hidden" id="hiddProdId${loop.index}" value="${product.psProdId}"/>
				<input type="hidden" id="workId${loop.index}" value="${product.workIdentifier}" />
				<input type="hidden"
				id="workStatus${loop.index}" value="${product.workStatusDesc}" />
				<input type="hidden" id="hiddMrtLabel${loop.index}" value="${product.mrtLabel}"/>
				<input type="hidden" id="intentIdentifier${loop.index}" value="${product.intentIdentifier}"/>
				<input type="checkbox" id="check${loop.index}" name="candSelectCheck" onclick="selectSingleProductNew(this);"></td>
				<td   class="row${loop.index%2}" align="left" width="14%">
					<%--<bean:write name="product" property="vendorDesc"/>--%>
						<c:out value="${product.vendorDesc}"></c:out>
				</td>
				<td  class="row${loop.index%2}" align="left" width="10%">
					<%--<bean:write name="product" property="unitUPC"/>--%>
					<c:out value="${product.unitUPC}"></c:out>
				</td>
				<td   class="row${loop.index%2}" align="left" width="17%">&nbsp;&nbsp;&nbsp;
					<%--<bean:write name="product" property="prodDescription"/>--%>
					<c:out value="${product.prodDescription}"></c:out>
				</td>
				<td  class="row${loop.index%2}" width="12%">
					<span style="margin-left:28px">
						<%--<bean:write name="product" property="pressDate"/>--%>
						<c:out value="${product.pressDate}"></c:out>
					</span>
				</td>
				<td   class="row${loop.index%2}" align="center" width="12%">
					<%--<bean:write name="product" property="workStatusDesc"/>--%>
					<c:out value="${product.workStatusDesc}"></c:out>
				</td>
				<td   class="row${loop.index%2}" width="12%"><span style="margin-left:28px">
				<%--	<bean:write name="product" property="testScanStatus"/>--%>
					<c:out value="${product.testScanStatus}"></c:out>
				</span></td>
				<td   class="row${loop.index%2}" align="left" width="9%">
					<%--<bean:write name="product" property="mrtLabel"/>--%>
						<c:out value="${product.mrtLabel}"></c:out>
				</td>
				<td   class="row${loop.index%2}" align="left" width="5%">&nbsp;</td></tr>
		</c:forEach>
	</table>
	</div>		
	<div style="height: 20px;width: 99.6%">
		<%
		int numView = 10;
		int pageCurrent = 0;
		int totalRecord = 0;   
		int totalPage = 0;
		String display="none";
		if(request.getAttribute("manageCandidate")!= null && ((ManageCandidate)request.getAttribute("manageCandidate")).getProductsTemp()!=null){
			if(((ManageCandidate)request.getAttribute("manageCandidate")).getProductsDisplay().size()>0){
				display = "block";
			}
			if(request.getAttribute("totalPage")!=null)
				totalPage = Integer.parseInt(request.getAttribute("totalPage").toString());
			if(request.getAttribute("totalRecord")!=null)
				totalRecord = Integer.parseInt(request.getAttribute("totalRecord").toString());
			if(request.getAttribute("pageCurrent")!=null)
				pageCurrent = Integer.parseInt(request.getAttribute("pageCurrent").toString());
			if(request.getAttribute("numView")!=null)
				numView = Integer.parseInt(request.getAttribute("numView").toString());		
			%>	
			<div id="pagingShow" style="display:<%=display %>">
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
		}else{
		%>
			<div align="center"></div>
		<%
		}
		%>
	</div>