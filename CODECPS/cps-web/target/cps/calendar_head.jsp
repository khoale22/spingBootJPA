<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<c:url value="${request.getContextPath()}/yui/yahoo/yahoo.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>
<!--  
not necessary, common_head has dom-event in it

<c:url value="/yui/event/event.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>


<c:url value="/yui/dom/dom.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>
-->
<c:url value="${request.getContextPath()}/yui/calendar/calendar.js" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="${request.getContextPath()}/yui/calendar/assets/skins/sam/calendar.css" var="styleURL"/>
<link href="${styleURL}" rel="stylesheet" type="text/css" />
