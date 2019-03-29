<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>



<%@page import="com.heb.operations.cps.ejb.batchUpload2.BatchUpload2VO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO"%>
<%@page import="com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO.STATUS"%><table>
<%
	List<BatchUpload2VO> vos = (List<BatchUpload2VO>)request.getAttribute("parsedVos");
	if(vos != null){
%>
<table style="border: solid 1px black">
	<tr>
		<th>
			UPC
		</th>
		<th>
			Status
		</th>
	</tr>
<% 
		for(Iterator i = vos.iterator() ; i.hasNext() ;){
			String styleText = "";
			String messageText = "";
			BatchUpload2VO vo = (BatchUpload2VO)i.next();
			switch(vo.getStatus()){
			
			case RECOVERABLE_ERRORS:
				styleText = "style=\"color: orange ; font-weight: bold\"";
				StringBuffer sb = new StringBuffer("<ul>");
				for(Iterator j = vo.getErrorMessages().iterator() ; j.hasNext() ;){
					String msg = (String)j.next();
					sb.append("<li>"+msg+"</li>");
				}
				sb.append("</ul>");
				messageText = sb.toString();
				break;
			case FATAL_ERRORS:
				styleText = "style=\"color: red ; font-weight: bold\"";
				StringBuffer sb2 = new StringBuffer("<ul>");
				for(Iterator j = vo.getErrorMessages().iterator() ; j.hasNext() ;){
					String msg = (String)j.next();
					sb2.append("<li>"+msg+"</li>");
				}
				sb2.append("</ul>");
				messageText = sb2.toString();
				break;			
			default:
				messageText = "OK";
				//styleText = "style=\"border: 1px solid black;\"";
			}
			
%>
			<tr <%=styleText %>>
			
				<td>
					<%=vo.getUnitUPC() %>
				</td>
				<td>
					<%=messageText %>
				</td>
			</tr>
				
<%
		}//for Iterator
%>
</table>
<br>
<%
	BatchUploadStatusVO statVo = (BatchUploadStatusVO)request.getAttribute("statVo");
	if(statVo != null && statVo.getStatus() == BatchUploadStatusVO.STATUS.VALIDATED){
%>
		<button onclick="doContinue()" value="CONTINUE" />&nbsp;(items in red will be ignored)
<%		
	}
%>
<% 
	}//if vos != null
%>
