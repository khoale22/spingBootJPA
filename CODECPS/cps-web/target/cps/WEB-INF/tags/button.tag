<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@attribute  name="uniqueId" required="true" rtexprvalue="true" %>
<%@attribute  name="label" required="true" rtexprvalue="true" %>
<%@attribute  name="width" required="false" rtexprvalue="true" %>
<%@attribute  name="height" required="false" rtexprvalue="true" %>
<%@attribute  name="alt" required="false" rtexprvalue="true" %>
<%@attribute  name="top" required="false" rtexprvalue="true" %>
<%@attribute  name="left" required="false" rtexprvalue="true" %>
<c:set var="image" value="${request.getContextPath()}/hebAssets/images/newButtons/small_normal.jpg"></c:set>
<c:set var="imageOver" value="${request.getContextPath()}/hebAssets/images/newButtons/small_mouse_click.jpg"></c:set>
<c:set value="${top}" var="tTop"></c:set>
<c:set value="${left}" var="tDown"></c:set>
<c:if test="tTop == null"><c:set value="5px" var="tTop"></c:set></c:if>
<c:if test="tDown == null"><c:set value="20px" var="tDown"></c:set></c:if>
<c:url value="${image}" var="normalImage"></c:url>
<c:url value="${imageOver}" var="mouseOverImage"></c:url>
<div id="cont${uniqueId}" style="position:relative;cursor: pointer;background: transparent;height:20px;min-width: 0;">
<script type="text/javascript">

var normalImage${uniqueId} = new Image();
normalImage${uniqueId}.src = '${normalImage}';

var mouseOver${uniqueId} = new Image();
mouseOver${uniqueId}.src = '${mouseOverImage}';

function ${uniqueId}NormalFunction(){
	document.getElementById('${uniqueId}Img').src = normalImage${uniqueId}.src;
}

function ${uniqueId}MouseOverFunction(){
	document.getElementById('${uniqueId}Img').src = mouseOver${uniqueId}.src;
}
//${uniqueId}NormalFunction();
//${uniqueId}MouseOverFunction();
</script>
	<a  id="${uniqueId}"  onmouseout="" onmouseover="">	
<div id="label${uniqueId}" style="position:absolute;top:${tTop};left:${tDown};color: white;cursor: pointer;background: transparent;height:20px;min-width: 0;">
<font color="white" size="3" face = "calibri">${label}</font> 
</div>
		<img src="${normalImage}" alt="${alt}" name="${uniqueId}"  border="0"  id="${uniqueId}Img" 
		 <c:if test="${width != null}">width="${width}"</c:if> <c:if test="${height != null}">height="${height}"</c:if> />
	</a>
</div>