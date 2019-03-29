<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="/WEB-INF/functions.tld" %>
<html>
<base ref="site" />
<link rel="stylesheet"
	href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>"
	type="text/css" />
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<jsp:include page="/common_head.jsp" /> 
<jsp:include page="/autoCompleteHeader.jsp" />
<script type="text/javascript">

<c:url var="colspd" value="${request.getContextPath()}/hebAssets/images/collapsed.gif"></c:url>
<c:url var="expnd" value="${request.getContextPath()}/hebAssets/images/expanded.gif"></c:url>

function toggle(id,img,header){	
	var headerId = document.getElementById(header);
	if(headerId.style.display == 'block'){
		hideTable(img,header);
		//hideBorder(id,'hide');
	}else{
		showTable(img,header);
		//hideBorder(id,'noHide');
	}
}

//function hideBorder(id,classname){
//	document.getElementById(id).className = classname;
//}
function hideTable(img,header){
	document.getElementById(header).style.display = 'none';
	document.getElementById(img).src = "${colspd}";
}
function showTable(img,header){
	document.getElementById(header).style.display = 'block';
	document.getElementById(img).src = "${expnd}";
}

<c:url var="rolesLink" value="/protected/cps/security/roles"></c:url>
function changeLabel(rowNum,v,abb){
	document.getElementById('roleSelected').value = abb;
	if(document.getElementById('roleRad'+rowNum).checked){
		document.forms[0].action = '${rolesLink}';
		document.forms[0].submit();
	}
}

<c:url var="rolesSave" value="/protected/cps/security/save?${_csrf.parameterName}=${_csrf.token}"></c:url>
function save(){
	document.forms[0].action = '${rolesSave}';
	document.forms[0].submit();
}
</script>
<style type="text/css">
.div{
	position: relative;
	min-width: 0;
}
</style>
</head>
<body id="rolesBody" style="overflow: auto;">
<div style="background-color: #FFF9F4;position: relative;">

<jsp:include page="/header.jsp" />
<input type="hidden" name="logoutMsgFlg" id="logoutMsgFlg" value="true" />
<form:form name="rolesForm" action="/protected/cps/security/" modelAttribute="roles">	<!-- roles.do?tab=save -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div id="formCont1" style="position: relative;margin-top: 25px;">
<table border="0" width="100%" bordercolor="red"><tr>
<td width="22%" valign="top">
<br>
<font style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 16px;	"><b>Roles</b></font>
<br>
<br>
<table border="0" width="100%" bordercolor="red" >
<tr>
<td> 
<font style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 14px;">
<c:if test="${not empty roles.returnedRoles}">	
				<c:forEach items="${roles.returnedRoles}" var="resrc" varStatus="loop">
					<tr>
						<td>
						<c:if test="${resrc.usrRoleAbb eq roles.roleSelected}">
						<input type="radio" name="hi" id="roleRad${loop.index}" checked="true"
						onclick="changeLabel('${loop.index}','<c:out value="${resrc.usrRoleDes}"/>','<c:out value="${resrc.usrRoleAbb}"/>')">
						</c:if>
						<c:if test="${resrc.usrRoleAbb ne roles.roleSelected}">
						<input type="radio" name="hi" id="roleRad${loop.index}"
						onclick="changeLabel('${loop.index}','<c:out value="${resrc.usrRoleDes}"/>','<c:out value="${resrc.usrRoleAbb}"/>')">
						</c:if>
						</td>
						<td>
							<B><c:out value="${resrc.usrRoleDes}"></c:out></B>
						</td>
					</tr>				
				</c:forEach>
			</c:if>	
</font> </td> </tr>
</table>
</td>
<td width="78%">
	<jsp:include page="/cpsErrors.jsp" />
<table border="0" width="100%" bordercolor="red"><tr><td width="100%">
<form:hidden path="roleSelected" id="roleSelected"></form:hidden>
<fieldset style="margin-left: 10px; background-color: #FFF9F4; width: 95%;position: relative;min-width : 0;">
	<table width="50%" border="0" align="center">
		<tr>
			<td align="left" width="10%"><label class="subtitle" id="nameLabel"> <c:out value="${roles.roleNameSelected}"/> </label> </td>
		</tr>
		
	</table>	
</fieldset>
	<fieldset style="width: 95%;margin-left: 10px;border-collapse: collapse;position: relative;min-width : 0;" id="f1" ><legend onclick="toggle('f1','caseImg','tabHeader');" style="cursor: pointer;">
	<img src="${expnd}" id="caseImg"> Functions</legend>
	<div id="tabHeader" style="display:block; position: relative;background-color: #FFF9F4;">
	<table width="100%">
	<tr><td width="6%">&nbsp;</td><td width="94%">
	<table  width="100%" border="0">
		<c:set var="cnt" value="1"></c:set>
		<c:set var="tmpCnt" value="0"></c:set>
		<c:set var="rowCount" value="${f:ceil(roles.rolesPrivilgesVO.functionLength / 3)}" />
		<c:forEach var="i" begin="1" end="${rowCount}">
			<tr>
				<c:forEach var="ii" begin="${cnt}" end="${f:min(roles.rolesPrivilgesVO.functionLength, (cnt + 2))}">
					
					<c:set value="${roles.rolesPrivilgesVO.functions[tmpCnt]}" var="attributeVO"/>
					
					<td align="left" width="10%">
						<form:checkbox path="rolesPrivilgesVO.functions[${tmpCnt}].accesCode" value="EX"></form:checkbox></td>
					
					<td align="left" width="20%">&nbsp;&nbsp;
					<label> ${attributeVO.resrcNm} </label>
					</td>
					
					<c:set var="cnt" value="${cnt+1}"></c:set>
					<c:set var="tmpCnt" value="${tmpCnt + 1}"></c:set>
				</c:forEach>
			</tr>			
		</c:forEach>
	</table>
	</td></tr>
	</table>
	</div>
</fieldset>
<fieldset style="width: 95%;margin-left: 10px;border-collapse: collapse;position: relative;min-width : 0;" id="menu1" ><legend onclick="toggle('menu1','menuImg','menuHeader');" style="cursor: pointer;">
	<img src="${expnd}" id="menuImg"> Menus</legend>
	<div id="menuHeader" style="display:block; position: relative;background-color: #FFF9F4;">
	<table width="100%">
	<tr><td width="6%">&nbsp;</td><td width="94%">
	<table  width="100%" border="0">
		<c:set var="cnt" value="1"></c:set>
		<c:set var="tmpCnt" value="0"></c:set>
		<c:set var="rowCount" value="${f:ceil(roles.rolesPrivilgesVO.menuLength / 3)}" />
		<c:forEach var="i" begin="1" end="${rowCount}">
			<tr>
				<c:forEach var="ii" begin="${cnt}" end="${f:min(roles.rolesPrivilgesVO.menuLength, (cnt + 2))}">
					
					<c:set value="${roles.rolesPrivilgesVO.menus[tmpCnt]}" var="attributeVO"/>
					
					<td align="left" width="10%">
						<form:checkbox path="rolesPrivilgesVO.menus[${tmpCnt}].accesCode" value="V"></form:checkbox></td>
					
					<td align="left" width="20%">&nbsp;&nbsp;
					<label> ${attributeVO.resrcNm} </label>
					</td>
					
					<c:set var="cnt" value="${cnt+1}"></c:set>
					<c:set var="tmpCnt" value="${tmpCnt + 1}"></c:set>
				</c:forEach>
			</tr>			
		</c:forEach>
	</table>
	</td></tr>
	</table>
	</div>
</fieldset>
<fieldset style="width: 95%;margin-left: 10px;border-collapse: collapse;position: relative;min-width : 0;" id="f2" ><legend onclick="toggle('f2','attribImg','attribHeader');" style="cursor: pointer;">
	<img src="${expnd}" id="attribImg"> Attributes</legend><br/>
	<div id="attribHeader" style="display:block; position: relative;background-color: #FFF9F4;">	
	<table width="100%" border="0" bordercolor="red">
	<tr><td width="1%">&nbsp;</td><td width="95%">
	
	<c:set var="rolesPrivVO" value="${roles.rolesPrivilgesVO}"></c:set>
	<c:forEach items="${rolesPrivVO.attributes}" var="sectionVO" varStatus="loop">
	<fieldset style="width: auto;margin-left: 0px;border-collapse: collapse;position: relative;min-width : 0;" id="f3${loop.index}" ><legend onclick="toggle('f3${loop.index}','prodImg${loop.index}','prodHeader${loop.index}');" style="cursor: pointer;">
	<img src="${expnd}" id="prodImg${loop.index}"> ${sectionVO.resrcNm} </legend>
	<div id="prodHeader${loop.index}" style="display:block;position: relative;background-color: #FFF9F4;">
	<table  width="100%" border="0">
		<c:set var="cnt" value="1"></c:set>
		<c:set var="tmpCnt" value="0"></c:set>
		<c:set var="rowCount" value="${f:ceil(sectionVO.childrenLength / 3)}" />
		
		<c:forEach var="i" begin="1" end="${rowCount}">
			<tr>
				<c:forEach var="ii" begin="${cnt}" end="${f:min(sectionVO.childrenLength, (cnt + 2))}">
					
					<c:set value="${sectionVO.childAttributes[tmpCnt]}" var="attributeVO"/>
					
					<td align="left" width="10%"><label> ${attributeVO.resrcNm} </label></td>
					
					<td align="left" width="20%">&nbsp;&nbsp;
						<form:select path="rolesPrivilgesVO.attributes[${loop.index}].childAttributes[${tmpCnt}].accesCode" tabindex="88" id="functions">
							<form:options items="${roles.functions}" itemLabel="name" itemValue="id"/>
						</form:select>
					</td>
					
					<c:set var="cnt" value="${cnt+1}"></c:set>
					<c:set var="tmpCnt" value="${tmpCnt + 1}"></c:set>
				</c:forEach>
			</tr>			
		</c:forEach>

		
		
	</table>
	</div>
	</fieldset>	
	</c:forEach>
	
	</td></tr>
	</table>
	</div>
</fieldset>

</td></tr>


</table>
</td></tr>
</table>
</div>
<input type="submit" value="Save" onclick="save()"/>
</form:form>
<jsp:include page="/footer.jsp" />
</div>




</body>
</html>

