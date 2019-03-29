<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%

/*

	This is the login screen.  This screen would never be accessed directly.  Here's how it works.
	web.xml tells the app server that any url starting with '/protected' requires that the user
	be logged in and belong to the role 'HEB'  If the container determines that the user is not logged
	in, it will redirect to the configured login page.  In the case of this app, the login page is
	login.do, which is a mapped struts action.  This action does some minor preliminary stuff and then 
	forwards the user to this page.  
	
	The form on this page does not submit to a struts action, rather it submits to the 
	J2EE container's j_security_check form, which is implemented by the app server.
	
	If the user authenticates successfully, and the container determines that the user 
	has the role 'HEB', he will be redirected to whichever page he was attempting to access
	when he was redirected to this screen in the first place.

*/

%>






<%@page import="java.util.Enumeration"%>
<html>
<base ref="site" />
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> -->
<title><spring:message code="app.name" /> - Login</title>

<jsp:include page="common_head.jsp" />
</head>
<body>
	
	<div id="container">
	
		<jsp:include page="header_login.jsp" />
		<div class="loginContent" id="loginContainer">
			<div class="loginLegalPara">
				<div align="center">
					<span class="loginTitle">H-E-B Core Product Setup</span><br />
				</div>
			</div>
			<div class="loginInputContent" id="loginInputContainer">
			
				<form method="POST" action="j_security_check">
			
				<table width="301" height="50" border="0" align="center" cellspacing="0">
					<tr>
						<td width="87" align="right" valign="middle">
							<div align="right">User Name:</div>
						</td>
						<td width="122" align="left" valign="middle">
							<div align="left">
								<input name="j_username" type="text" id="textfield" size="15" />
							</div>
						</td>
						<td width="86">&nbsp;
						</td>
					</tr>
					<tr>
						<td align="right" valign="middle">
							<div align="right">Password:</div>
						</td>
						<td align="left" valign="middle">
							<div align="left">
								<input name="j_password" type="password" id="textfield2" size="15" />
							</div>
						</td>
						<td align="left" valign="middle">
							<div align="left">
								<a onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('LI_logIn','','hebAssets/images/LI_logIn_over.gif',1)" onclick="document.forms[0].submit();">
									<img src="hebAssets/images/LI_logIn.gif" alt="Click Here to Log In" name="LI_logIn" width="85" height="18" border="0" id="LI_logIn" />
								</a>
							</div>
						</td>
					</tr>
				</table>
				
				</form>
				
				<div align="center"></div>
			</div><!-- loginInputContent -->
			<div class="loginLegalPara" id="loginLegalContent">
				<div>
					<p>This system and all related equipment is for official H-E-B business only. All systems are subject to monitoring for management, unauthorized access and verification of security procedures. Use of this system constitutes consent to monitoring for this purpose. Unauthorized use of this system may subject you to criminal prosecution and penalties.</p>
				</div>
			</div>
		  	<p align="center"><a href="https://onepass.heb.com/onepass/login.jsp">Change Password</a></p>
		</div><!-- loginContent -->		
		<!-- This clearing element should immediately follow the #mainContent div in order to force the #container div to contain all child floats -->
		<br class="clearfloat" />

	</div><!-- container -->
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
