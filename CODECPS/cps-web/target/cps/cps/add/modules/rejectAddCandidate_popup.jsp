<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
		<title>Reject Candidate Comments</title>
		<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />
		<jsp:include page="/common_head.jsp" />
		<c:url value="/dwr/interface/AddCandidateTemp.js" var="myJs" />
		<script type="text/javascript" src="${myJs}"></script>
	</head>
	<body style="visibility: visible;" onload="check()">
		<form:form action="/protected/cps/add" id="rejectAddCandidateForm" name="rejectAddCandidateForm" modelAttribute="addNewCandidate">
			<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<jsp:include page="/cpsErrors.jsp" />
			<table width="100%">
				<tr>
					<td width="2%" class="dataGridHead">Enter Comments:</td>
					<td width="98%">
						<textarea id="rejectCommentsId" name="rejectComments" class="textArea" tabindex="1"></textarea>
					</td>
				</tr>
				<tr>
					<td width="50%" align="right"><button id="saveComment">Save</button></td>
					<td width="50%" align="left"><button id="cancelComment">Cancel</button></td>
				</tr>
			</table>
		</form:form>
	</body>

	<script type="text/javascript">
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveComment"), "click", saveComments);

	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("cancelComment"), "click", cancelComments);
	
	function checkValue(evt){	
	toClose();
	}
	
	function toClose(evt){	
		window.parent.execScript("f2();");
	}

	<c:url value="/protected/cps/add/rejectComments?${_csrf.parameterName}=${_csrf.token}" var="saveComments"></c:url>
	function saveComments(evt){
		var comments = document.getElementById("rejectCommentsId").value;
			if(null!=comments && ""!=comments.trim){
			  document.getElementById('saveComment').disabled=true;
			  document.getElementById('cancelComment').disabled=true;
			  document.forms[0].action = '${saveComments}';
			  document.forms[0].submit();
			}else{
			alert('Please enter reject comments');
			}
	}

	<c:url value="/protected/cps/add/rejectCand?${_csrf.parameterName}=${_csrf.token}" var="rejectCandidate"></c:url>
	function cancelComments(evt){
	          document.getElementById('saveComment').disabled=true;
			  document.getElementById('cancelComment').disabled=true;
	 		  document.forms[0].action = '${rejectCandidate}';
			  document.forms[0].submit();
	}
	function check(){
	    <c:if test="${CPSForm.rejectClose}">
	        	var ex = "rejectQuestionaire();";
     			window.parent.execScript(ex);
     			window.parent.execScript("f2();");
	    </c:if>
    }
	String.prototype.trim = function () {
    	return this.replace(/^\s*/, "").replace(/\s*$/, "");
	}
	</script>
</html>