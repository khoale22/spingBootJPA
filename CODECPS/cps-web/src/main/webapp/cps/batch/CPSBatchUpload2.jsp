<%@ page language="java" contentType="text/html;charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@page import="com.heb.operations.cps.util.CPSGlobals"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
	/*
	 This is the main screen for the 'Product Search' application.
	 the heart of this screen is the tab-view.
	
	 The way it works, the contents of each tab are loaded dynamically as needed
	 */
%>

<html:html>
<base ref="site" />
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title><spring:eval expression="@messageResourcesProperties.getProperty('app.name')" /> - Manage Candidate</title>
<c:url value="/dwr/engine.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/util.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/AddCandidateTemp.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/BatchUpload2DWR.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>

<jsp:include page="/common_head.jsp" />

<c:url value="${request.getContextPath()}/yui/connection/connection-min.js" var="styleLink" />
<script type="text/javascript" src="${styleLink}"></script>
<c:url value="${request.getContextPath()}/hebAssets/dispatcher.js" var="myJs" />
<script type="text/javascript" src="${myJs}"></script>
<style type="text/css">

.redStat{
	background-color: red;
	color: white;
}

.redStatError{
	background-color: red;
	color: white;
}

.greenStat{
	background-color: green;
	color: black;
}

.greenStatError{
	background-color: #8EE28E;
	color: black;
}

.blueStat{
	background-color: blue;
	color: white;
}

.blueStatError{
	background-color: #6868b2;
	color: white;
}


</style>


</head>
<body class=" yui-skin-sam" style="overflow: auto;">


	<div id="container" style="background-color: #FFFFFF;">
		
		<form:form
			styleId="batchUploadForm" action="/protected/cps/batchUpload"
			method="POST"
			enctype="multipart/form-data">
			<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>

			<%--	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <c:url value="/protected/BatchErrorViewerServlet" var="batchView" />--%>
	
			<div id="container" style="background-color: #FFFFFF;">
			
				<jsp:include page="/header.jsp" />
				
				<br />
				<br />
				
				<jsp:include page="/cpsErrors.jsp" />
	
	
				<br /><br /><br /><br /><br />
	
	
				<table width="100%" border="0">
					<tr>
						<td width="100%" align="center"
							style="font-weight: bold;">
						Select file for Batch Upload</td>
					</tr>
					<tr>
						<td width="100%" align="center">
							<input type="file" style="width: 30%;" name="fileUpload" styleId="fileName" id="fileName"></input>
							<button type="button" id="upLoadButton" name="upLoadButton">Upload</button>
						</td>
					</tr>
					
					<tr>
						<td width="100%" align="center">
							Note: Batch Upload only supports Excel files format (.xls, and .xlsx)
 						</td>
					</tr>
																				
					<!--<tr>
						<td width="100%" align="center">		
								<div align="left">	
									<%--<html:text property="addressCustomerEmail" style="width: 30%;margin-left: 32%" styleId="addressCustomerEmail" onblur="validateEmail(this);"></html:text>--%>
									<span id="overrideEmail" style="font-weight: bold; ">Override Email </span><span style="color: red;">( @heb.com Only)</span>
								</div>
						</td>
					</tr>-->
				</table>
	
				<br />
				<br />
				<br />
				<br />
				
				
	<!-- <div style="padding-left: 5px;"><a onclick="updateStats()" style="cursor: pointer;">Update</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="sortByOriginalOrder()" style="cursor: pointer;">Sort By Spreadsheet Order</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="sortByStatus()" style="cursor: pointer;">Sort By Status</a></div> -->
			<div width="100%" id="statDiv">
				<%
					if(request.getAttribute("isSubmit")!=null)
					{
						out.println("Your file has been submitted. CPS will send email when Batch Uploading is finished.");
					}
				%>
			</div>
				
			</div>
			<!-- Container -->
		</form:form>
	</div>
<script type="text/javascript">	
	var oPushButton2 = new YAHOO.widget.Button("upLoadButton");
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("upLoadButton"), "click", upLoadBatchFile); 
	<c:url value="/protected/cps/batchUpload?${_csrf.parameterName}=${_csrf.token}" var="batchUpLoad" />
	function upLoadBatchFile(){
	    if (document.getElementById('fileName').value == '') {
	        alert ('Please select a file to upload');
	        return false;
	    }
	    else
	    {
			var browserName=navigator.appName;
			
	    	var path = document.getElementById('fileName').value;
			
			if (browserName=="Microsoft Internet Explorer")
			{
				if (path.indexOf(":\\") != 1 || path.lastIndexOf(".") == -1) 
					{
						alert("Please enter the correct path and name of the file that you want to upload.");     
					} 
				else 
					{
						path=trim10(path);
						isValidExtend=false;
						var extend=path.substring(path.lastIndexOf('.') + 1).toLowerCase();						
						if(extend=="xls" || extend=="xlsx")
						{
							isValidExtend=true;
						}
						
						if(!isValidExtend)
					    {
					    	alert("Please choose a valid Excel(.xls or .xlsx) file.");
							return false;
						}
						else
						{
							showProgress();
							document.forms[0].action = "${batchUpLoad}";
							//document.forms[0].file =document.getElementById('fileName').value;
							document.forms[0].submit();
						}
							
					}				
			}
			else
				{
						var extend = path.substring(path.lastIndexOf('.') + 1).toLowerCase();						
						if(extend != "xls" && extend != "xlsx")
					    {
					    	alert("Please choose a valid Excel(.xls or .xlsx) file.");
						}
						else
						{
							showProgress();
							document.forms[0].action = "${batchUpLoad}";
                          //  document.forms[0].file =document.getElementById('fileName').value;
							document.forms[0].submit();
						}	
				}
	    }
	}

	if (document.all)
	{ 
		document.onkeydown = function ()
		{ 
			var key_f5 = 116; // 116 = F5 
			if (key_f5==event.keyCode)
			{ 
				event.keyCode = 27; 
				return false; 
			} 
		} 
	}
	document.body.onunload = function(){AddCandidateTemp.batchSessionClearing();};//fix javascript error while going out of batch upload page.
	function validateEmail(that)
	{
		var email=trim10(that.value);	
		if(email.length >0)
		{	
		if(email.indexOf(" ") > -1)
		{
			alert("your email "+"\""+email+"\""+" is invalid");
			that.value="";
		}	
		else
		{	
				var match = /[a-z0-9]@heb.com/.test(email);		
				if(match)
				{
					var temp=email.length-email.lastIndexOf("@heb.com");				
					if(temp!="@heb.com".length)
					{
						alert("your email "+"\""+email+"\""+" is invalid");
						that.value="";
					}
					
					
				}
				else
				{
					alert("your email "+"\""+email+"\""+" is invalid");
					that.value="";
				}
		}	
		}		
	}
	function trim10 (str) {
	var whitespace = ' \n\r\t\f\x0b\xa0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000';
	for (var i = 0; i < str.length; i++) {
		if (whitespace.indexOf(str.charAt(i)) === -1) {
			str = str.substring(i);
			break;
		}
	}
	for (i = str.length - 1; i >= 0; i--) {
		if (whitespace.indexOf(str.charAt(i)) === -1) {
			str = str.substring(0, i + 1);
			break;
		}
	}
	return whitespace.indexOf(str.charAt(0)) === -1 ? str : '';
}

	
</script>
<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html:html>