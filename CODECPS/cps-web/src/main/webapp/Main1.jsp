<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%-- <base ref="site" /> --%>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> -->
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<title><spring:eval expression="@messageResourcesProperties.getProperty('app.name')" />,Version 1.0:Login Page</title>
<c:url value="${request.getContextPath()}/hebAssets/common.css.jsp" var="styleURL" />
<link href="${styleURL}" rel="stylesheet" type="text/css" />
<jsp:include page="/common_head.jsp" />
<script type="text/javascript">
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
</script>

<script type="text/javascript">
<c:if test="${LoginForm.loginFailed}">
</c:if>
//****************************************For Enabling The Enter Key *********************************
 function sub(){
	var key = window.event.keyCode;
	if(key == 13){
	document.forms[0].submit();
	}
	 }
function caseDescFocus(){
      document.getElementById('textfield').focus();
 }
 // executeAfterBodyVisible(caseDescFocus);
		 
	//check if this page is displayed in a popup window
	function checkForPopUp(){
		if(window.parent.location){
			if(window.parent.location.pathname != "/cps/login.do" && window.parent.location.pathname != "/cps/protected/Main.do"
				&& window.parent.location.pathname != "/cps/j_security_check"){
				window.parent.f2();
				window.parent.location.pathname = "/cps/";
			}	
		}
	}

</script>
</head>
<!-- <body onload="MM_preloadImages('hebAssets/images/LI_logIn_over.gif');checkForPopUp();" style="background-color: #D6DCE2;margin:auto;"> -->
<body onload="MM_preloadImages('hebAssets/images/LI_logIn_over.gif');" style="background-color: #D6DCE2;margin:auto;">
<div id="container">
  <div id="header">
    <div class="headerTop">
      <div align="left"><img src="hebAssets/images/IMG_logo.gif" alt="" width="83" height="28" hspace="5" />
        <div id="LoginHelpFloater">
          <div class="helpStyle"><a href="https://onepass.heb.com/onepass/login.jsp">Help</a></div>
        </div>
        <div id="currentLocationStyleContainer" class="currentLocationStyle">Core Product Setup : Site Login	</div>
      </div> 
      <table width="100%" vspace="5" height="25" border="0" align="left" cellpadding="0" cellspacing="0" background="hebAssets/images/menubg.gif">
  <tr>
    <td><img src="hebAssets/images/spacer.gif" width="1" height="25" /></td>
  </tr>
      </table>
    </div>
    <!-- end #header -->
  </div>	
		<div class="loginContent" id="loginContainer">
		  <br class="clearfloat" />
    <div class="loginLegalPara">
      <div align="center"><span class="loginTitle">Core Product Setup<br />
        </span>
      </div>
    </div>
     <!--  login starts --> 
     <c:if test="${LoginForm.loginFailed}">
	<div id="loginInputContainer" align="center"
		style="font: font-family :     Arial, Helvetica, sans-serif; font-size: 11px; color: red;">

	<b> UserName or Password incorrect!! Please Re-enter</b></div>
	<!-- loginInputContent -->
</c:if>
<div class="loginInputContent" id="loginInputContainer">
<form method="POST" action="<c:url value='/j_spring_security_check' />" id="loginForm">
<table width="300" height="40" border="0" align="center" cellspacing="0"
	bordercolor="">
	<tr>
		<td width="100" align="right" valign="middle">
		<div align="right">User Name:</div>
		</td>
		<td width="122" align="left" valign="middle">
		<div align="left"><input name="j_username" type="text"
			id="textfield" size="15" style="width: 122px;" onkeypress="sub();" />
		</div>
		</td>
		<td width="86">&nbsp;</td>
	</tr>
	<tr>
		<td align="right" valign="middle">
		<div align="right">Password:</div>
		</td>
		<td align="left" valign="middle">
		<div align="left"><input name="j_password" type="password"
			id="textfield2" style="width: 122px;" size="15" onkeypress="sub();" />
		</div>
		</td>
		<td align="left" valign="middle">
		<div align="right"><a onmouseout="MM_swapImgRestore()"
			onmouseover="MM_swapImage('LI_logIn','','hebAssets/images/LI_logIn_over.gif',1)"
			onclick="document.forms[0].submit();"> <img
			src="hebAssets/images/LI_logIn.gif" alt="Click Here to Log In"
			name="LI_logIn" width="85" height="18" border="0" id="LI_logIn" /> </a>
		</div>
		</td>
	</tr>

</table>
 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>
</div>

<br class="clearfloat" />
      <div class="loginLegalPara" id="loginLegalContent">
      
        <div>
          <p>This system and all related equipment is for official H-E-B business only. All systems are subject to monitoring for management, unauthorized access and verification of security procedures. Use of this system constitutes consent to monitoring for this purpose. Unauthorized use of this system may subject you to criminal prosecution and penalties.</p>
        </div>
      </div>


  </div>
  <br class="clearfloat" />
  <jsp:include page="footer.jsp"></jsp:include>
	 </div>
</body>
</html>
