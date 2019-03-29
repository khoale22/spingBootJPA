<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<html>
<head>
<base ref="site" />
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> -->
	<title><spring:eval expression="@messageResourcesProperties.getProperty('app.name')" /> - Landing</title>
<%	
/*
	All the css and js that's on every page
*/
%>
<jsp:include page="/common_head.jsp" />
<jsp:include page="/autoCompleteHeader.jsp" />


</head>
<body class=" yui-skin-sam"
	style="overflow: hidden; background-color: #F6F6F6;" bgcolor="#FFF9F4"
	id="landingBody">


<div id="container" style="background-color: white;"><jsp:include
	page="/header.jsp" />

<div id="ContentContainer">
<div class="form-container1">


<jsp:include page="/cpsErrors.jsp" />



<br><br><br><br>
<center><h1>Welcome to CPS</h1></center>
<br>

Please select a task from the menu above.  If you don't see a menu, you don't have access to any part of this application.

<br><br><br><br>


<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>