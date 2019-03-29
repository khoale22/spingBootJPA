<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>


<%

/*

		Most pages will include this fragment (using jsp:include)

		This page fragment contains the company logo, the info bar (with 'you are logged in as...' and 'log out', etc)
		and the main menu bar.  This should be uniform across most pages in the app, and thus should be included 
		whenever possible

		This page assumes that the request scope has a key called 'currentAppName' this is done automatically
		by the HebInfoBase, from which all CPS struts actions should extend
*/



%>
<c:url value="/dwr/interface/FieldHelp.js" var="myJs" />
<script type="text/javascript" src="${myJs}"></script>
<!-- START HEADER INCLUDE --> 

		
<div id="header">
	<div id="head" style="position: relative; top: -15px;">
		<c:url value="${request.getContextPath()}/hebAssets/images/header2.png" var="img"></c:url>
		<table width="100%"><tr>
		<td width="100%">
		<table width="100%" border="0" height="70px">
			<tr>
			<td width="100%" align="right">
				<img src="${img}" width="100%"> 
			</td>
			</tr>
		</table>
		</td></tr>
		<tr><td width="100%">
		</td></tr>
		</table>
	</div>
	


  
  