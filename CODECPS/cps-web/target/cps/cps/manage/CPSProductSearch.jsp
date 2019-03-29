<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@page import="com.heb.operations.cps.util.CPSGlobals"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html>
<base ref="site" />
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8"/>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> -->
<title><spring:eval expression="@messageResourcesProperties.getProperty('app.name')" /> - Manage Product</title>

<jsp:include page="/common_head.jsp" />
<jsp:include page="/autoCompleteHeader.jsp" />
<jsp:include page="/cps/manage/modules/searchpanel_head.jsp" />
<c:url value="/dwr/engine.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/util.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/ProductDWR.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="${request.getContextPath()}/yui/connection/connection-min.js" var="styleLink"/>
<script type="text/javascript" src="${styleLink}"></script>
<c:url value="${request.getContextPath()}/hebAssets/dispatcher.js" var="myJs"/>
<script type="text/javascript" src="${myJs}"></script>

<script type="text/javascript">
	YAHOO.namespace('HEB.manageMain');
</script>
</head>
<body class="yui-skin-sam" style="overflow: auto;"  >
	<div id="err" style="background-color: #FFFFFF;min-width: 0;position: relative; z-index: 0;">
		<jsp:include page="/header.jsp" />
		<br/>
		<jsp:include page="/cpsErrors.jsp" />
	
		<div id="cont01" style="background-color: #FFFFFF;min-width: 0;  z-index: 0;">	
	
			<form:form action="/protected/cps/manage/searchProduct" name="searchForm" id="searchForm" modelAttribute="manageProduct">
			<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<div id="cont12"  style="background-color: #FFFFFF;min-width: 0;">
		
				<div id="ContCont"  style="background-color: #FFFFFF;position: relative;min-width: 0;">
			 		<div id="msgDiv" style="top: 80px;" >
			 			<c:if test="${requestScope.myMessage != null}">
			 				<span style="color: blue; font-size: small; font-family: sans-serif;"><b> ${requestScope.myMessage}</b> </span>
			 			</c:if>
			 		</div>
					<div style="background-color: #FFFFFF;position: relative;left: -2px;min-width: 0;">
						&nbsp;
						<jsp:include page="/cps/manage/modules/productSearch.jsp" />
						<br/>
						<div id="searchResultDiv">		
							<jsp:include page="/cps/manage/modules/productSearchResults.jsp" />
						</div>
					</div>
				</div>
			</div>
<script type="text/javascript">
	//check Firefox, Safari, Opera browsers
	if (YAHOO.env.ua.gecko > 0 || YAHOO.env.ua.webkit || YAHOO.env.ua.opera) {
		document.getElementById('searchResultDiv').className="zIndexFireFox";
	}
	//check IE browser
	if (YAHOO.env.ua.ie > 0) {
		document.getElementById('searchResultDiv').className="zIndexIE";
	}
</script>
			</form:form>
		</div>
	</div>
	<jsp:include page="/footer.jsp"></jsp:include>
</body>

</html>
