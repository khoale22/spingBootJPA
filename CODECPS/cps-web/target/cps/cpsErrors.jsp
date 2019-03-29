<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<style type="text/css">
ul
{
list-style-type:disc;
padding:0px;

}
li
{
background-repeat:no-repeat;
background-position:0px 5px; 
padding-left:0px;
}
</style>
<c:if test="${CPSForm.errorFlag}">
<div id="errors" style="position: relative;
    min-width: 0;
    width: 100%;
    margin: auto;
    text-align: left;
    overflow: auto;
    display: table; padding-left: 23px;
    ">
<UL>
<c:set var="index" value="1"/>  
<c:set var="lst" value="${CPSForm.messages}"></c:set>
<c:forEach var="msg" items="${lst}" varStatus="rowCounter" >
	<c:set var="index" value="${index+1}"/> 
	<c:choose>
		<c:when test="${msg.errorSeverity.errorSeverityValue == 4}">
			<LI><font id="four${index}" color="#FF0000" size="2px;" title="${msg.formattedMessage}">${msg.message}</font>	</LI>
		</c:when>
		<c:when test="${msg.errorSeverity.errorSeverityValue == 3}">
			<LI><font id="three${index}" color="#C80000" size="2px;" title="${msg.formattedMessage}">${msg.message}</font></LI>
		</c:when>
		<c:when test="${msg.errorSeverity.errorSeverityValue == 2}">
			<LI><font id="two${index}" color="#980000" size="2px;" title="${msg.formattedMessage}">${msg.message}</font></LI>
		</c:when>
		<c:when test="${msg.errorSeverity.errorSeverityValue == 1}">
			<LI > <font id="one${index}" color="Blue" size="2px;" title="${msg.formattedMessage}" >${msg.message}</font></LI>	
		</c:when>
	</c:choose>
</c:forEach>
</UL>
</div>
</c:if>

<%--<a id="stackClick" style="cursor: pointer;" onclick="errorHndle()"></a>
<div id="stackTrace" style="position: relative;min-width: 0;display: none;">

</div>--%>