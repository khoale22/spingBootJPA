<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@attribute  name="uniqueId" required="true" rtexprvalue="true" %>
<%@attribute  name="image" required="true" rtexprvalue="true" %>
<%@attribute  name="imageOver" required="true" rtexprvalue="true" %>
<%@attribute  name="width" required="false" rtexprvalue="true" %>
<%@attribute  name="height" required="false" rtexprvalue="true" %>
<%@attribute  name="alt" required="false" rtexprvalue="true" %>
<%@attribute  name="tabIndex" required="false" rtexprvalue="true" %>

<c:url value="${image}" var="normalImage"></c:url>
<c:url value="${imageOver}" var="mouseOverImage"></c:url>
<div style="cursor: pointer;">
<script type="text/javascript">
var normalImage${uniqueId} = new Image();
normalImage${uniqueId}.src = '${normalImage}';

var mouseOver${uniqueId} = new Image();
mouseOver${uniqueId}.src = '${mouseOverImage}';

function ${uniqueId}NormalFunction(){
	document.getElementById('${uniqueId}').src = normalImage${uniqueId}.src;
}

function ${uniqueId}MouseOverFunction(){
	document.getElementById('${uniqueId}').src = mouseOver${uniqueId}.src;
}
</script>
	<a onmouseout="${uniqueId}NormalFunction();" onmouseover="${uniqueId}MouseOverFunction();">
		<img src="${normalImage}" alt="${alt}" name="${uniqueId}"  border="0" id="${uniqueId}" 
		 <c:if test="${width != null}">width="${width}"</c:if> <c:if test="${height != null}">height="${height}"</c:if> />
	</a>
</div>