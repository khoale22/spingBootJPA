<%@ tag body-content="tagdependent" %>
<%@ tag import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@attribute  name="resourceId" required="true" rtexprvalue="false" %>
<%@attribute  name="honorViewMode" required="false" rtexprvalue="true" %>
<%@ attribute name="NONE" fragment="true" %>
<%@ attribute name="VIEW" fragment="true" %>
<%@ attribute name="EDIT" fragment="true" %>
<%@ attribute name="EXEC" fragment="true" %>
<%@ tag import="com.heb.jaf.security.UserInfo" %>
<%@ tag import="com.heb.operations.cps.model.HebBaseInfo" %>


<!-- Start renderByResourceAccess.tag -->

<%
	boolean renderNone = false;
	boolean renderView = false;
	boolean renderExec = false;
	boolean renderEdit = false;
	
	
	
	//VIEW MODE:
	//This happens when the session var: CPS_VIEW_MODE = true
	//if a user has 'edit' access to something, 
	//we'll show the 'view' attribute instead.
	//If they have, 'exec' access, we'll show 'NONE'.
	//tag users can turn off this feature by 
	//specifying the attribute: honorViewMode = "false"
	boolean reallyHonorViewMode = true;
	
	if((honorViewMode != null) &&
			("false".equals(honorViewMode))){
		reallyHonorViewMode = false;
	}
	
	Boolean cpsViewModeBool = ((HebBaseInfo)session.getAttribute("CPSForm")).isViewMode();
	boolean sessionViewMode = false;
	if((cpsViewModeBool != null) && (cpsViewModeBool.booleanValue()) && reallyHonorViewMode){
		sessionViewMode = true;
	}
	
	//placed in session by authentication realm
	//it maps resrc_id -> acess_typ
// 	Map<Integer, String> m  = (Map<Integer, String>)jspContext.findAttribute("com.heb.ResourceMap");
	org.springframework.security.core.Authentication auth = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication(); 
	UserInfo hebUserDetails = (UserInfo)auth.getPrincipal();

	Map<Integer, String> m = hebUserDetails.getResourceMap();
	if(m != null){
		String acs = m.get(Integer.parseInt(resourceId));
		if(acs != null){
			if("EX".equals(acs)){
				renderExec = true;
			}
			else if("ED".equals(acs)){
				renderEdit = true;
			}
			else if("V".equals(acs)){
				renderView = true;
			}
			else{
				renderNone = true;
			}
		}
		else{
			renderNone = true;
		}
	}
	else{
		renderNone = true;
	}
	
	
	//check for 'view mode'
	if(renderEdit && sessionViewMode){
		renderEdit = false;
		renderView = true;
	}
	else if(renderExec && sessionViewMode){
		renderExec = false;
		renderNone = true;
	}
	
	jspContext.setAttribute("renderNone", renderNone);
	jspContext.setAttribute("renderView", renderView);
	jspContext.setAttribute("renderEdit", renderEdit);
	jspContext.setAttribute("renderExec", renderExec);
%>

<c:if test="${renderNone}">
	<jsp:invoke fragment="NONE" />	
</c:if>
<c:if test="${renderView}">
	<jsp:invoke fragment="VIEW" />	
</c:if>
<c:if test="${renderEdit}">
	<jsp:invoke fragment="EDIT" />	
</c:if>
<c:if test="${renderExec}">
	<jsp:invoke fragment="EXEC" />	
</c:if>


<!-- End renderByResourceAccess.tag -->