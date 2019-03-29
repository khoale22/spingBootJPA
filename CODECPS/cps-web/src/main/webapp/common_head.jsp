<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%--The HEB-specific css classes--%>
<link href="<spring:url value='/hebAssets/common.css.jsp'/>" type="text/css" rel="stylesheet" />

<%--css for the main menu bar (SpryMenu)--%>
<link href="<spring:url value='/hebAssets/SpryAssets/SpryMenuBarHorizontal.css'/>" type="text/css" rel="stylesheet" />

<%--Common js--%>
<script src="<spring:url value='/hebAssets/common.js'/>" type="text/javascript"></script>

<%-- Js for javascript validation--%>
<script src="<spring:url value='/hebAssets/keyStroke.js'/>" type="text/javascript"></script>

<%--js for the main menu bar (SpryMenu)--%>
<script src="<spring:url value='/hebAssets/SpryAssets/SpryMenuBar.js'/>" type="text/javascript"></script>

<%--css for the YUI button component--%>
<link href="<spring:url value='/yui/button/assets/skins/sam/button.css'/>" type="text/css" rel="stylesheet" />

<%--core js for the DWR Ajax functionality--%>
<script src="<spring:url value='/dwr/engine.js'/>" type="text/javascript"> </script>
<%--Utils for DWR--%>
<script src="<spring:url value='/dwr/util.js'/>" type="text/javascript"> </script>
<%--CPS Util for DWR--%>
<script src="<spring:url value='/dwr/interface/FieldHelp.js'/>" type="text/javascript"> </script>

<%--Core yahoo js, supporting namespaces, dom, events--%>
<script src="<spring:url value='/yui/yahoo/yahoo-min.js'/>" type="text/javascript" ></script>

<script src="<spring:url value='/yui/dom/dom-min.js'/>" type="text/javascript"> </script>

<script src="<spring:url value='/yui/event/event-min.js'/>" type="text/javascript"> </script>

<%--more YUI js--%>
<script src="<spring:url value='/yui/element/element-beta-min.js'/>" type="text/javascript"> </script>

<%--js for the YUI button component--%>
<script src="<spring:url value='/yui/button/button-min.js'/>" type="text/javascript"></script>

<%--most excellent YUI css that gives us reasonably uniform font rendering across browsers and OSes--%>
<link href="<spring:url value='/yui/fonts/fonts-min.css'/>" type="text/css" rel="stylesheet" />

<%--css for our many YUI panel-menu thingies--%>
<link href="<spring:url value='/yui/container/assets/container-core.css'/>" type="text/css" rel="stylesheet" />

<%--more css for the YUI panel-menus--%>
<link href="<spring:url value='/yui/container/assets/skins/sam/container-skin.css'/>" type="text/css" rel="stylesheet" />

<%--js to allow us to drag the YUI panel-menus around--%>
<script src="<spring:url value='/yui/dragdrop/dragdrop-min.js'/>" type="text/javascript"></script>

<%--js for the panel-menus--%>
<script src="<spring:url value='/yui/container/container-min.js'/>" type="text/javascript"></script>

<%--css for logger--%>
<link href="<spring:url value='/yui/logger/assets/logger.css'/>" type="text/css" rel="stylesheet" />

<%--js for YUI logging--%>
<script src="<spring:url value='/yui/logger/logger-min.js'/>" type="text/javascript"></script>

<script type="text/javascript">
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

    var myLogReader;
    var myLogReaderIsHidden = true;

    //various page init things
    function hebInit(){

        //MM_preloadImages('hebAssets/images/F_save_over.gif','hebAssets/images/F_discard_over.gif');

        //instantiate and render the main menu bar
        <spring:url value="/hebAssets/images/menuarrow.gif" var="arrow1"/>
        <spring:url value="/hebAssets/images/menuarrowSub_2.gif" var="arrow2"/>
        var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"${arrow1}", imgRight:"${arrow2}"});

    }
</script>