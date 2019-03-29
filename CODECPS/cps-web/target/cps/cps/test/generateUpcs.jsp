
<%@page import="javax.naming.InitialContext"%>
<%@page import="com.heb.operations.cps.ejb.indexing.CPSIndexUtilLocal"%>
<%@page import="com.heb.operations.cps.ejb.batchUpload2.BatchUpload2Remote"%>

<%
	String refresh = request.getParameter("prefix");

	String[][] results = null;
	if(refresh != null){
		BatchUpload2Remote util = (BatchUpload2Remote)new InitialContext().lookup("java:comp/env/BatchUpload2Bean");
		results = util.generateUpcs(request.getParameter("prefix"), 
												request.getParameter("numUpcs"),
												request.getParameter("desc"));
	}
%>

push the button to run cache refresh

<%@page import="com.heb.operations.cps.ejb.batchUpload2.BatchUpload2Remote"%><form>
prefix
<input type="text" name="prefix"/>
<input type="text" name="desc"/>
<input type="text" name="numUpcs" />
<input type="submit" />
</form>

<%
	if(results != null){
%>
			<table>
<%
				for(int i = 0; i< results.length ; i++){
%>
					<tr>
<%
						for(int j = 0 ; j < results[i].length ; j++){
%>
							<td>
								<%=results[i][j] %>						
							</td>
<%
						}//for j
%>					
					</tr>
<%
				}//for i
%>
			</table>
<%
	}//if results
%>