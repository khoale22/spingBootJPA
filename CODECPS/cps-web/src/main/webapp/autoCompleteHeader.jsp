<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>


<!--CSS file (default YUI Sam Skin) -->  
<c:url value="${request.getContextPath()}/yui/autocomplete/assets/skins/sam/autocomplete.css" var="styleURL"/>
<link type="text/css" rel="stylesheet" href="${styleURL}">   
   
<!-- Dependencies -->  
  
  <!-- OPTIONAL: Animation (required only if enabling animation) -->  
<c:url value="${request.getContextPath()}/yui/animation/animation-min.js" var="styleURL"/>
 <script type="text/javascript" src="${styleURL}"></script> 
  
  
 <%-- 
 <!-- OPTIONAL: Get (required only if using Script Node DataSource) -->  
<c:url value="/yui/get/get-min.js" var="styleURL"/>
 <script type="text/javascript" src="${styleURL}"></script>   
--%>

<c:url value="${request.getContextPath()}/yui/datasource/datasource-min.js" var="styleURL"/>
<script type="text/javascript" src="${styleURL}"></script>  

   
 <!-- OPTIONAL: Connection (required only if using XHR DataSource) -->  
<c:url value="${request.getContextPath()}/yui/connection/connection-min.js" var="styleURL"/>
 <script type="text/javascript" src="${styleURL}"></script>  
   
   
 <!-- OPTIONAL: JSON (enables JSON validation) -->  
<c:url value="${request.getContextPath()}/yui/json/json-min.js" var="styleURL"/>
 <script type="text/javascript" src="${styleURL}"></script>  
 
 <%-- 
  <!-- OPTIONAL: Animation (required only if enabling animation) -->  
<c:url value="/yui/animation/animation-min.js" var="styleURL"/>
 <script type="text/javascript" src="${styleURL}"></script> 
 --%>
  
 <c:url value="${request.getContextPath()}/yui/autocomplete/autocomplete-min.js" var="styleURL"/>
 <script type="text/javascript" src="${styleURL}"></script>
    
