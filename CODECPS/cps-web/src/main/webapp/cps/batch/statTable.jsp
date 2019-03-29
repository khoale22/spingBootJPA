<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>



<%@page import="com.heb.operations.cps.ejb.batchUpload2.BatchUpload2VO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO"%>
<%@page import="com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO.STATUS"%>
<%@page import="com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO.STATUS"%>
<%
	BatchUploadStatusVO statVo = (BatchUploadStatusVO)request.getAttribute("statVo");
	List<BatchUpload2VO> rowVos = (List<BatchUpload2VO>)request.getAttribute("rowVos");
	boolean parentHasErrors = ((statVo != null) && (statVo.getStatus() == BatchUploadStatusVO.STATUS.DEAD));
	
	
	if(statVo != null){
	
%>


<%@page import="com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO.STATUS"%>
<%@page import="com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO.STATUS"%>

<table class="dataGrid" width="80%">
	<tr>
		<th colspan="5" class="<%=statVo.getStatClass()%>"><%= statVo.getStatus()%> ( <%= statVo.getTotalRowsComplete()%> of <%= statVo.getTotalRows()%> complete )</th>
	</tr>
	<tr>
		<th class="<%=statVo.getStatClass()%>">
			Row In Spreadsheet
		</th>
		<th class="<%=statVo.getStatClass()%>">
			UPC
		</th>
		<th class="<%=statVo.getStatClass()%>">
			Description
		</th>
		<th class="<%=statVo.getStatClass()%>">
			Status
		</th>		
		<th class="<%=statVo.getStatClass()%>">
			Errors
		</th>				
	</tr>
<%
if(rowVos != null){
	for(Iterator i = rowVos.iterator() ; i.hasNext() ;){
		BatchUpload2VO vo = (BatchUpload2VO)i.next();
%>	
		<tr>
			<td class="<%=vo.getStatClass(parentHasErrors) %>">
				<%=vo.getRowNum() + 1%>
			</td>
			<td class="<%=vo.getStatClass(parentHasErrors) %>">
				<%=vo.getUnitUPC() %>
			</td>
			<td class="<%=vo.getStatClass(parentHasErrors) %>">
				<%=vo.getItemDescription() %>
			</td>			
			<td class="<%=vo.getStatClass(parentHasErrors) %>">
				<%=vo.getStatus().toString() %>
			</td>		
			<td class="<%=vo.getStatClass(parentHasErrors) %>">
				<ul>
					<%
						for(Iterator j = vo.getErrorMessages().iterator() ; j.hasNext() ;){
							String msg = (String)j.next();
					%>
							<li><%= msg%></li>
					<%
						}
					%>
				</ul>
			</td>
		</tr>
<%
	}//for i
}//if statVo
%>
</table>	


<%
	}//if statVo != null
%>
