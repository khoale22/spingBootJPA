<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%
/*

	This is the javascript and css that's common to just about every page in the app.  It also 
	includes the code for the global <ctrl>-m popup menu

*/
%>


<%
/*
	The HEB-specific css classes
*/
%>
<c:set value="<%=System.currentTimeMillis()%>" var="uniqAppend"></c:set>
<c:set value="?t=<%=System.currentTimeMillis()%>" var="val"></c:set>

<c:url value="${request.getContextPath()}/hebAssets/common.css.jsp${val}" var="styleURL"/>
<link href="${styleURL}" rel="stylesheet" type="text/css" />

<%
/*
	css for the main menu bar (SpryMenu)
*/
%>
<c:url value="${request.getContextPath()}/hebAssets/SpryAssets/SpryMenuBarHorizontal.css${val}" var="styleURL"/>
<link href="${styleURL}" rel="stylesheet" type="text/css" />
<%
/*
	Common js
*/
%>
<c:url value="${request.getContextPath()}/hebAssets/common.js${val}" var="styleURL"/>
<script src="${styleURL}" type="text/javascript"></script>


<%
/*
	js for the main menu bar (SpryMenu)
*/
%>
<c:url value="${request.getContextPath()}/hebAssets/SpryAssets/SpryMenuBar.js${val}" var="styleURL"/>
<script src="${styleURL}" type="text/javascript"></script>

<%
/*
	css for the YUI button component
*/
%>
<c:url value="${request.getContextPath()}/yui/button/assets/skins/sam/button.css${val}" var="styleURL"/>
<link href="${styleURL}" type="text/css" rel="stylesheet" />

<%
/*
	core js for the DWR Ajax functionality
*/
%>
<c:url value="/dwr/engine.js${val}" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>

<%
/*
	 Utils for DWR
*/
%>
<c:url value="/dwr/util.js${val}" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>

<%
/*
	Core yahoo js, supporting namespaces, dom, events
*/
%>
<c:url value="${request.getContextPath()}/yui/yahoo-dom-event/yahoo-dom-event.js${val}" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>

<%
/*
	more YUI js
*/
%>
<c:url value="${request.getContextPath()}/yui/element/element-beta-min.js${val}" var="styleURL"/>
<script type='text/javascript' src="${styleURL}"> </script>

<%
/*
	js for the YUI button component
*/
%>
<c:url value="${request.getContextPath()}/yui/button/button-min.js${val}" var="styleURL"/>
<script type="text/javascript" src="${styleURL}"></script>

<%
/*
	most excellent YUI css that gives us reasonably uniform font rendering across browsers and OSes
*/
%>
<c:url value="${request.getContextPath()}/yui/fonts/fonts-min.css${val}" var="styleURL"/>
<link href="${styleURL}" type="text/css" rel="stylesheet" />

<%
/*
	css for our many YUI panel-menu thingies
*/
%>
<c:url value="${request.getContextPath()}/yui/container/assets/container-core.css${val}" var="styleURL"/>
<link href="${styleURL}" type="text/css" rel="stylesheet" />

<%
/*
	more css for the YUI panel-menus
*/
%>
<c:url value="${request.getContextPath()}/yui/container/assets/skins/sam/container-skin.css${val}" var="styleURL"/>
<link href="${styleURL}" type="text/css" rel="stylesheet" />

<%
/*
	js to allow us to drag the YUI panel-menus around
*/
%>
<c:url value="${request.getContextPath()}/yui/dragdrop/dragdrop-min.js${val}" var="styleURL"/>
<script type="text/javascript" src="${styleURL}"></script>

<%
/*
	js for the panel-menus
*/
%>
<c:url value="${request.getContextPath()}/yui/container/container-min.js${val}" var="styleURL"/>
<script type="text/javascript" src="${styleURL}"></script>



<%
/*
	css for logger
*/
%>
<c:url value="${request.getContextPath()}/yui/logger/assets/logger.css${val}" var="styleURL"/>
<link href="${styleURL}" type="text/css" rel="stylesheet" />


<%
/*
	js for YUI logging
*/
%>
<c:url value="${request.getContextPath()}/yui/logger/logger-min.js${val}" var="styleURL"/>
<script type="text/javascript" src="${styleURL}"></script>

<%
/*
	js for YUI logging
*/
%>
<c:url value="${request.getContextPath()}/yui/yahoo/yahoo-min.js${val}" var="styleURL"/>
<script type="text/javascript" src="${styleURL}" ></script>

<!-- Event source file -->
<c:url value="${request.getContextPath()}/yui/event/event-min.js${val}" var="styleURL"/>
<script type="text/javascript" src="${styleURL}" ></script>


<c:url value="${request.getContextPath()}/yui/yahoo/yahoo-min.js${val}" var="styleURL"/>
<script type="text/javascript" src="${styleURL}" ></script>

<!-- Event source file -->
<c:url value="${request.getContextPath()}/yui/yahoo/yahoo.js${val}" var="styleURL"/>
<script type="text/javascript" src="${styleURL}" ></script>
	
	<c:url value="${request.getContextPath()}/yui/event/event.js${val}" var="styleURL"/>
	<script type="text/javascript" src="${styleURL}" ></script>
	
	<c:url value="${request.getContextPath()}/yui/dom/dom.js${val}" var="styleURL"/>
	<script type="text/javascript" src="${styleURL}" ></script>

	<c:url value="${request.getContextPath()}/yui/calendar/calendar.js${val}" var="styleURL"/>
	<script type="text/javascript" src="${styleURL}" ></script>
	
	<c:url value="${request.getContextPath()}/yui/calendar/assets/skins/sam/calendar.css${val}" var="styleURL"/>
	<link type="text/css" rel="stylesheet" href="${styleURL}">



 

<script type="text/javascript">
<!--

// these 3 are from the HEB standard page templates.

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function changeImage(obj, image){
	obj.src = image;
}

//from YUI, lets us call an init function when the page's DOM tree is fully in place
YAHOO.util.Event.onDOMReady(hebInit);

var menuPanel;

var myLogReader;
var myLogReaderIsHidden = true;

//various page init things
function hebInit(){

	//alert('hebinit');
	//MM_preloadImages('hebAssets/images/F_save_over.gif','hebAssets/images/F_discard_over.gif');
	
	//instantiate and render the main menu bar
	<c:url value="${request.getContextPath()}/hebAssets/images/menuarrow.gif" var="arrow1"/>
	<c:url value="${request.getContextPath()}/hebAssets/images/menuarrowSub_2.gif" var="arrow2"/>
	var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"${arrow1}", imgRight:"${arrow2}"});
	
	//instantiate (but don't show the menu panel) (the <ctrl>-m one)
	menuPanel = new YAHOO.widget.Panel("menuPanel", { xy:[200,250], width: "250px", visible: false } );
	//alert('poo');
	//alert(menuPanel);

	//key listener that gets attached to the menu panel.  Right now it just listens for 1,2,3,[esc]
	//since those are the only options on the menu panel right now
	//basically when the menu panel is showing, and one of those keys gets pressed, the
	//js function, 'menuKeyPress' gets called											
	var menuKl2 = new YAHOO.util.KeyListener(document, { keys:[27,49,50,51] },//<esc>,'1','2','3'  							
											  { fn:menuKeyPress,
												scope:document,
												correctScope:true }, "keyup" );//keyup for safari
												

	//this tells YUI that when it finally instantiates and shows the menu panel, attach the
	//key listener we just created to it.
	menuPanel.cfg.queueProperty("keylisteners", menuKl2);
	//generate the DOM code for the menu panel (still hidden), and attach it to the page's DOM
	menuPanel.render();
	
	
	//a key listener that gets attached to the page (always listening)
	//that listens for <ctrl>-m.  When that key sequence is pressed, the
	//'showMenu' method is called
	var kl3 = new YAHOO.util.KeyListener(document, { ctrl:true, keys:[76,77] },//'m' 
												   { fn:showMenu, 
													 scope:document,
													 correctScope:true } );
	//start listening for <ctrl>-m now.
	kl3.enable();
	
	//hide the menu panel 
	function hideMenu(){
		//alert('hide');
		menuPanel.hide();
	}
	
	//show the menu panel
	function showMenu(evt, args){
		if(args[0] == 76){//L
			//if the user did a ctrl-l, they want to show the logger window
			toggleLogReader();
		}
		else{
			menuPanel.show();
		}
	}
	
	function toggleLogReader(){
		if(myLogReaderIsHidden){
			myLogReader.show();
		}
		else{
			myLogReader.hide();
		}
		myLogReaderIsHidden = !myLogReaderIsHidden;
	}
	
	//fired when one of the options on the menu panel is selected.
	//basically navigate to whichever page is associated with the key-press
	//that fired the event: 1=Add New Candidate, 2=Manage Candidates, etc
	function menuKeyPress(evt, args){
		if(args[0] == 27){
			hideMenu();
		}
		else if(args[0] == 49){
			<c:url value="/protected/cps/add/AddNewMain.do" var="linkUrl">
				<c:param name="tab" value="classification"></c:param>
			</c:url>
			window.location.href="${linkUrl}";	
		}
		else if(args[0] == 50){
			<c:url value="/protected/cps/manage/searchCandidate.do" var="linkUrl">
				<c:param name="action" value="search"></c:param>
			</c:url>		
			window.location.href="${linkUrl}";	
		}
		else if(args[0] == 51){
			<c:url value="/Main.do" var="linkUrl">
			</c:url>		
			window.location.href="${linkUrl}";	
		}		
	}
	
	myLogReader = new YAHOO.widget.LogReader();
	myLogReader.hide();
} 



//-->
</script>

