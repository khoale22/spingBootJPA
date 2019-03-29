<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>

<!--   START header.jsp -->
<%
	/*

	 Most pages will include this fragment (using jsp:include)

	 This page fragment contains the company logo, the info bar (with 'you are logged in as...' and 'log out', etc)
	 and the main menu bar.  This should be uniform across most pages in the app, and thus should be included 
	 whenever possible

	 This page assumes that the request scope has a key called 'currentAppName' this is done automatically
	 by the HebInfoBase, from which all CPS struts actions should extend
	 */
%>
<c:url value="/dwr/interface/FieldHelp.js" var="myJs" />




<style type="text/css">

.help {
	background: transparent;
	border-top: 0;
	border-right: 0;
	border-bottom: 0;
	border-left: 0;
	color: #3366CC;
	display: inline;
	margin: 0;
	padding: 0;
	text-decoration: none;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}

*:first-child+html .help {		/* hack needed for IE 7 */
	border-bottom: 0;
	text-decoration: none;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}

* html .help {				/* hack needed for IE 5/6 */
	border-bottom: 0;	
	text-decoration: none;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
a:hover {

	cursor:pointer;
}

</style>


<script type="text/javascript" src="${myJs}"></script>



 <DIV class="screenName" id="screenLabel">
<CENTER><FONT SIZE="+1" COLOR="#00006E">
<c:if test="${currentModeAppName == 'CPS'}">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<spring:eval expression="@messageResourcesProperties.getProperty('app.name')" /> : <c:out value="${CPSForm.currentAppName}" />
</c:if>
<c:if test="${currentModeAppName == 'EDI'}">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<spring:eval expression="@messageResourcesProperties.getProperty('appEDI.name')" />
</c:if>
</FONT></CENTER>
 </DIV>

<div class="helpStyle"
	style="position: absolute; z-index: 2000; right: -0px; top: 15px; width: 25%;">
	<font color="black"> 
		You are logged in as 
		<c:choose>
			<c:when test="${pageContext.request.userPrincipal != null}">
				<c:out value="${pageContext.request.userPrincipal.name}" />
			</c:when>
			<c:otherwise>
				Guest
			</c:otherwise>
		</c:choose>
	</font> 
	&nbsp;|&nbsp; 
<%-- 	<html:link action="/logout"  onclick="return logoutConfirm()"> --%>
<%-- 		<html:param name="action" value="logout"></html:param> --%>
<!-- 		Log Out -->
<%-- 	</html:link> --%>
<%-- 	<html:link action="/j_spring_security_logout"  onclick="return logoutConfirm()"> --%>
<%-- 		<html:param name="action" value="logout"></html:param> --%>
<!-- 		Log Out -->
<%-- 	</html:link> --%>
<c:url value="/j_spring_security_logout" var="logoutUrl" />
	<a id="lblLogout" onclick="logout();">Log Out</a>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	&nbsp;|&nbsp; 
	<input class="help" type="button" onclick="helpMe();" onmouseout="mouseOut(this);" onmouseover="mouseOver(this);" value="Help"/>
</div>
	
<div id="hmenu" style="position: absolute; z-index: 1000; top: 32px;">
	<ul id="MenuBar1" class="MenuBarHorizontal">
		<cps:renderByResourceAccess resourceId="167">
			<jsp:attribute name="VIEW">		
				<li>
					<a href="#" onclick="return false;">Manage Candidate</a>
					<ul>
						<cps:renderByResourceAccess resourceId="167">
							<jsp:attribute name="VIEW">
								<li>
									<a href="<s:url value="/protected/cps/manage/candSearchWrapper?${_csrf.parameterName}=${_csrf.token}"></s:url>" onclick="return checkFinalInput();">Manage Candidate</a>
								</li>
						</jsp:attribute>
						</cps:renderByResourceAccess>	
						<cps:renderByResourceAccess resourceId="260">
							<jsp:attribute name="VIEW">		
								<li>
									<a href="<s:url value="/protected/cps/manageEDI/ediSearchWrapper?${_csrf.parameterName}=${_csrf.token}"></s:url>" onclick="return checkFinalInput();">Manage Candidate(Beta)</a>
								</li>
						</jsp:attribute>
						</cps:renderByResourceAccess>																											
					</ul>
				</li> 
				
			</jsp:attribute>
		</cps:renderByResourceAccess>
		
		<cps:renderByResourceAccess resourceId="168">
			<jsp:attribute name="VIEW">
				<li>
					<a href="#" onclick="return false;">Add Candidate</a>
					<ul>
						<cps:renderByResourceAccess resourceId="169">
							<jsp:attribute name="VIEW">
		
								<li>
										<%--<html:link action="/protected/cps/add/AddNewCandidate.do?tab=questionnaireWrapper&${_csrf.parameterName}=${_csrf.token}"  onclick="return checkFinalInput();">
<!-- 										error html:param please find other method to fix this issue -->
<!-- 											<param name="tab" value="questionnaireWrapper" ></param> -->
											Add New Candidate
										</html:link>--%>
									<a href="<s:url value="/protected/cps/add/questionnaireWrapper?${_csrf.parameterName}=${_csrf.token}"></s:url>" onclick="return checkFinalInput();">Add New Candidate</a>
								</li>
								
							</jsp:attribute>
						</cps:renderByResourceAccess>
						
						<cps:renderByResourceAccess resourceId="170">
							<jsp:attribute name="VIEW">
		
								<li>
									<c:if test="${CPSForm.selectedFunction != 3}">
								<%--		<html:link action="/protected/cps/manage/searchProduct.do?advSearch=false&action=prodSearchWrapper&${_csrf.parameterName}=${_csrf.token}"  onclick="return checkFinalInput();">
									<!-- 										error param please find other method to fix this issue -->
<!-- 											<param name="action" value="prodSearchWrapper"></param> -->
<!-- 											<param name="advSearch" value="false"></param> -->
											Search Active Product
										</html:link>--%>
										<a href="<s:url value="/protected/cps/manage/prodSearchWrapper?advSearch=false&${_csrf.parameterName}=${_csrf.token}"></s:url>" onclick="return checkFinalInput();">Search Active Product</a>
									</c:if>
									<c:if test="${CPSForm.selectedFunction == 3}">
										<a href="#" onclick="return false;"><b>Search Active Product</b></a>
									</c:if>
								</li>
							</jsp:attribute>
						</cps:renderByResourceAccess>
		<%--	
			
			
			<li><c:if test="${CPSForm.selectedFunction !=5}">
					<html:link action="/protected/cps/manage/searchCandidate"
						onclick="return cnfrm();">
						<html:param name="action" value="copyCand"></html:param>
											Copy Candidate
										</html:link>
				</c:if> <c:if test="${CPSForm.selectedFunction == 5}">
					<a href="#" onclick="return false;"><b>Copy Candidate</b></a>
				</c:if></li>	 
		
		--%>
				
				
		<%--  
		
		
				<li>		
									<c:if test = "${CPSForm.selectedFunction == 6}">
											<a href="#" onclick= "return false;"><b>Add UPC/Case Pack</b></a>
									</c:if>			
									<c:if test = "${CPSForm.selectedFunction != 6}">
											<a href="#" onclick= "show();return false;">Add UPC/Case Pack</a>
									</c:if>				
								
								</li>	 
				<li><c:if test="${CPSForm.selectedFunction != 4}">
					<html:link action="/protected/cps/add/AddNewCandidate"
						onclick="return cnfrm();">
						<html:param name="tab" value="authAndDist"></html:param>
										Add MRT
									</html:link>
				</c:if> <c:if test="${CPSForm.selectedFunction == 4}">
					<a href="#" onclick="return false;"><b>Add MRT</b></a>
				</c:if></li> 
				
				
				
		--%>
					</ul>
				</li> 
			</jsp:attribute>
		</cps:renderByResourceAccess>
			
			
		<cps:renderByResourceAccess resourceId="171">
			<jsp:attribute name="VIEW">

						<li>
		
							<c:if test="${CPSForm.selectedFunction != 9}">
	<%--							<html:link action="/protected/cps/add/AddNewCandidate.do?tab=batchUploadWrapper2&${_csrf.parameterName}=${_csrf.token}"  onclick="return checkFinalInput();">
<!-- 									<param name="tab" value="batchUploadWrapper2" ></param> -->
									Batch Upload
								</html:link>--%>
								<a href="<s:url value="/protected/cps/batchUpload"></s:url>" onclick="return checkFinalInput();">Batch Upload</a>
							</c:if>
							<c:if test="${CPSForm.selectedFunction == 9}">
								<a href="#" onclick="return false;"><b>Batch Upload</b></a>
							</c:if>
						</li>
				
			
			</jsp:attribute>
		</cps:renderByResourceAccess>		
		
		
		
		
<%-- 
		<li>
						<c:if test = "${CPSForm.selectedFunction != 7}">
							<html:link action="/protected/cps/manage/searchCandidate" onclick="return cnfrm();">
								<html:param name="action" value="ownBrand"></html:param>
								Manage Own Brand
							</html:link>
						</c:if>
						<c:if test = "${CPSForm.selectedFunction == 7}">
								<a href="#" onclick="return false;"><b>Manage Own Brand</b></a>
						</c:if>
					
				</li> 
				<li>
					<a href="#" onclick="return false;">Report</a>
					<ul>
						<li>
							<a href="#" onclick="return false;">Report1</a>	
						</li>
						<li>
							<a href="#" onclick="return false;">Report2</a>	
						</li>
						<li>
							<a href="#" onclick="return false;">Report3</a>
						</li>
					</ul>
				</li>
				
				
--%>
		<cps:renderByResourceAccess resourceId="172">
			<jsp:attribute name="VIEW">
				<li>
					<a href="#" onclick="return false;">Admin</a>
					<ul>
						<cps:renderByResourceAccess resourceId="172">
							<jsp:attribute name="VIEW">		
								<li>
					<c:if test="${CPSForm.selectedFunction != 8}">
						<%--<html:link action="/protected/cps/security/roles.do?tab=roles&${_csrf.parameterName}=${_csrf.token}" onclick="return checkFinalInput();">
<!-- 							<param name="tab" value="roles"></param> -->
							Roles & Privileges
						</html:link>--%>
						<a href="<s:url value="/protected/cps/security/roles?${_csrf.parameterName}=${_csrf.token}"></s:url>" onclick="return checkFinalInput();">Roles & Privileges</a>
					</c:if> 
					<c:if test="${CPSForm.selectedFunction == 8}">
						<a href="#" onclick="return false;"><b>Roles & Privileges</b></a>
					</c:if>
				</li>				
			</jsp:attribute>
		</cps:renderByResourceAccess>			
						<cps:renderByResourceAccess resourceId="267">
							<jsp:attribute name="VIEW">		
								<li>
									<c:if test="${CPSForm.selectedFunction != 10}">
										<a href="<s:url value="/protected/cps/volumeUploadProfile"></s:url>" onclick="return checkFinalInput();">Volume Upload Profile</a>
									</c:if>
									<c:if test="${CPSForm.selectedFunction == 10}">
										<a href="#" onclick="return false;"><b>Volume Upload Profile</b></a>
									</c:if>
								</li>
						</jsp:attribute>
						</cps:renderByResourceAccess>																											
					</ul>
				</li> 
				
			</jsp:attribute>
		</cps:renderByResourceAccess>			
				
				
	</ul>
</div><!-- hmenu -->


<c:url value="${request.getContextPath()}/hebAssets/images/IMG_logo.gif" var="logoUrl"></c:url>
<div id="header">
	<div class="headerTop">
		<div align="left">
			<img src="${logoUrl}" alt="" width="83" height="28" hspace="5" />
		</div>
	</div>
</div>


<div id="messageDiv" style="position: relative;"></div>




<div id="helpPanel" style="visibility: hidden;">
	<div class="hd" id="helpPanelTitle"></div>
	<div class="bd" id="helpPanelContent"></div>
	<div class="bd"></div>
</div>


<script type="text/javascript">
	var contextPath='<%=request.getContextPath()%>';
	function logout() {
	  document.forms[0].action = '${logoutUrl}';
	  document.forms[0].submit();
	}

	function mouseOut(help){
		help.style.textDecoration = "none";	
		help.style.cursor = "pointer";			
	}
	
	function mouseOver(help){
		help.style.textDecoration = "underline";		
		help.style.cursor = "hand";		
	}
	
	
  	function helpMe(){
  		f1('/cps/protected/cps/add/cpsHelp','CPS Help','350px','70%','230px','200px');
		return false;
	}
	
	function show(){
		var t = confirm('All unsaved data will be lost on navigating away from the page.Do you want to continue?');
		  
	}
	
	function cnfrm(){
		var t = confirm('All unsaved data will be lost on navigating away from the page.Do you want to continue?');
		if(t){
			return true;
		}
		return false;
	}

	function logoutConfirm() {
		var msgFlg = true;

		if (document.getElementById('logoutMsgFlg')) {
			if (document.getElementById('modifyFormButton') 
					|| document.getElementById('modifyProdFormButton')) {
				return true;
			}
			var msgFlg = confirm('Are you sure you want to logout? Any unsaved information would be lost.');
		}
		
		if(!msgFlg){
			return false;
		}
		return true;
	}

	window.onbeforeunload = function(e) {
		var evt = e || window.event;
		if (( evt.clientX < 0) || (evt.clientY < 0 )) {
			if (document.getElementById('logoutMsgFlg') 
					&& !(document.getElementById('modifyFormButton') 
							|| document.getElementById('modifyProdFormButton'))) {
				return ("Any unsaved information would be lost.");
			}
		}
	}
	
	/*document.onhelp = function(){return false;}
	document.onkeydown = function(ev) {
				
		value = (window.external) ? event.keyCode : ev.keyCode;
		var help = false;
		var target;
		if (window.external) {
			if (event.keyCode == 112 || value == 112) { help = true;target = event.srcElement; }
		} else {
			if (ev.keyCode == 112 || value == 112) { help = true;target = event.srcElement; }
		}
		if(help){
			if(target && target.id){
				FieldHelp.getHelpForId(document.body.id,target.id,getDWRCallbackMethod(helpDisplay));
			}
		}
	}*/
	
	function closeHelp(evt){
		helpPanel.hide();
	}
	
	function helpDisplay(data){
		//alert('help display: '+data);
		if(data != null){
			//document.getElementById('helpPanelContent').innerHTML = data;
			helpPanel.setBody(data);
			helpPanel.show();
		}
	}
	var helpPanel = //new YAHOO.widget.Panel("helpPanel", { xy:[200,250], width: "350px", visible: false } );
					new YAHOO.widget.Panel("helpPanel", {
					width:"350px", 
					fixedcenter: true, 
					constraintoviewport: true, 
					underlay:"none", 
					close:true, 
					visible:false, 
					draggable:true,
					xy:[0,0]} );
	
	
	helpPanel.setHeader("CPS - Help");
	helpPanel.setFooter("Press [ESC] to close.");
	
	
	
	var panelKl2 = new YAHOO.util.KeyListener(document, { keys:[27] },//<esc>
														  { fn:closeHelp,
															scope:document,
															correctScope:true }, "keyup" );//keyup for safari

	helpPanel.cfg.queueProperty("keylisteners", panelKl2);

	helpPanel.render();
	
	//document.getElementById('hmenu').style.width = document.getElementById('header2Image').width + 'px';
	
	//global variable for knowing page load..
	var pageLoaded = false;
	//functions o be executed after page visibility set to true
	
	YAHOO.util.Event.onDOMReady(initHelp);
	
	function initHelp(){
		//alert('init help');
		YAHOO.util.Event.addListener(document, "click", checkForHelp);
	}
	
	
	function checkForHelp(evt){
	    var xco = evt.clientX;
	    var yco = evt.clientY;
		var tgt = YAHOO.util.Event.getTarget(evt);
		var id = tgt.id;
		if(id){
			var isHelpable = YAHOO.util.Dom.hasClass(tgt, 'helpable');
			//alert("helpable: "+isHelpable);
			if(isHelpable){
				if(xco <= 600 && yco <= 450){
				var hxy = YAHOO.util.Event.getXY(evt);
				YAHOO.util.Dom.setXY('helpPanel', hxy);
			}else if(xco >= 600 && yco <= 450){
			var yco = parseInt(yco);
			YAHOO.util.Dom.setXY('helpPanel',[600,yco]);
			}else if(xco <= 600 && yco >= 450){
			var xco = parseInt(xco);
			YAHOO.util.Dom.setXY('helpPanel',[xco,400]);
			}
				FieldHelp.getHelpForId(id,getDWRCallbackMethod(helpDisplay));
			}
		} 
		else{
			//alert('no id');
		}
		// + ":" + evt.getTarget().id);
	}
	
	function myTrim(x) {
		return x.replace(/^\s+|\s+$/gm,'');
	}
	
</script>	
<!-- END header.jsp -->

