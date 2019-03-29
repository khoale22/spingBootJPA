<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.heb.operations.cps.util.CPSConstants" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<html>
<head>
    <meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title><spring:eval expression="@messageResourcesProperties.getProperty('app.name')" /> - New Candidate</title>

    <jsp:include page="/common_head.jsp" />
    <jsp:include page="/autoCompleteHeader.jsp" />

    <c:url value="/dwr/engine.js" var="styleURL" />
    <script type='text/javascript' src="${styleURL}"> </script>
    <c:url value="/dwr/util.js" var="styleURL" />
    <script type='text/javascript' src="${styleURL}"> </script>
    <c:url value="/dwr/interface/AddCandidateTemp.js" var="styleURL" />
    <script type='text/javascript' src="${styleURL}"> </script>

    <c:url value="${request.getContextPath()}/hebAssets/calendar/calendar.js" var="cal"/>
    <script type="text/javascript" src="${cal}"></script>
    <c:url value="${request.getContextPath()}/hebAssets/calendar/calendar-en.js" var="calen"/>
    <script type="text/javascript" src="${calen}"></script>
    <c:url value="${request.getContextPath()}/hebAssets/calendar/calendar-setup.js" var="calsetup"/>
    <script type="text/javascript" src="${calsetup}"></script>

    <c:url value="${request.getContextPath()}/yui/yahoo-dom-event/yahoo-dom-event.js" var="styleURL"/>
    <script type="text/javascript" src="${styleURL}"></script>
    <c:url value="${request.getContextPath()}/yui/dragdrop/dragdrop-min.js" var="styleURL"/>
    <script type="text/javascript" src="${styleURL}"></script>
    <c:url value="${request.getContextPath()}/yui/container/container-min.js" var="styleURL"/>
    <script type="text/javascript" src="${styleURL}"></script>
    <c:url value="${request.getContextPath()}/yui/paginator/paginator-min.js" var="styleURL"/>
    <script type="text/javascript" src="${styleURL}"></script>

    <c:url value="/yui/" var="yuiURL"></c:url>
    <c:url value="${request.getContextPath()}/yui/fonts/fonts-min.css" var="styleURL"/>
    <link rel="stylesheet" type="text/css" href="${styleURL}" />
    <c:url value="${request.getContextPath()}/yui/container/assets/container-core.css" var="styleURL"/>
    <link rel="stylesheet" type="text/css" href="${styleURL}" />

    <link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />

    <link rel="stylesheet" type="text/css" media="all"
          href="<spring:url value='/hebAssets/calendar/calendar_blue.css'></spring:url>" title="calBlue">

    <c:url value="${request.getContextPath()}/yui/tabview/assets/tabview-core.css" var="styleLink" />
    <link rel="stylesheet" type="text/css" href="${styleLink}" />

    <c:url value="${request.getContextPath()}/yui/tabview/assets/skins/sam/tabview-skin.css"
           var="styleLink" />
    <link rel="stylesheet" type="text/css" href="${styleLink}" />

    <c:url value="${request.getContextPath()}/yui/tabview/tabview-min.js" var="styleLink" />
    <script type="text/javascript" src="${styleLink}"></script>

    <c:url value="${request.getContextPath()}/yui/connection/connection-min.js" var="styleLink" />
    <script type="text/javascript" src="${styleLink}"></script>

    <%--<script type="text/javascript"
            src="<spring:url value='/hebAssets/moduleIncludes/auth.js.jsp'></spring:url>"></script>--%>
    <c:url value="${request.getContextPath()}/hebAssets/moduleIncludes/auth.js.jsp" var="auth" />
    <script type="text/javascript" src="${auth}"></script>

    <style type="text/css">
        .yui-skin-sam .yui-dt-col-address pre { font-family:arial;font-size:100%; }
        .origin { display: block; background: #795089; padding: 1ex; color: #fff; text-align: right; margin-bottom: 1em; }
        #messageTable thead { display: none; }
        #messageTable { margin-top: 1em; }
        #paginated { text-align: center; }
        #paginated table { margin-left:auto; margin-right:auto; }
        #paginated, #paginated .yui-dt-loading { text-align: center; background-color: transparent; }

        #heb {height:20em;}

        /* XP Panel Skin CSS */
        #panel1{
            /* top:100px !important; */
        }
        /* Skin default elements */
        #panel1_c.yui-panel-container.shadow .underlay {
            left:1px;
            right:-1px;
            top:1px;
            bottom:-1px;
            position:absolute;
            background-color:#000;
            opacity:0.12;
            filter:alpha(opacity=12);
            pointer-events: none;
        }

        /* Apply the border to the right side */
        #panel1.yui-panel {
            border:none;
            overflow:visible;
            background:transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat top right;
        }

        /* Style the close icon */
        #panel1.yui-panel .container-close {
            position:absolute;
            top:5px;
            right:8px;
            height:21px;
            width:21px;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
        }

        /* Style the header with its associated corners */
        #panel1.yui-panel .hd {
            padding:0;
            border:none;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-hd.gif) repeat-x;
            color:#FFF;
            height:30px;
            margin-left:0px;
            margin-right:0px;
            text-align:left;
            vertical-align:middle;
            overflow:visible;
        }

        /* Style the body with the left border */
        #panel1.yui-panel .bd {
            overflow:hidden;
            padding:10px;
            border:none;
            background:#FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y;
            margin:0 4px 0 0;
        }

        /* Style the footer with the bottom corner images */
        #panel1.yui-panel .ft {
            background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
            font-size:11px;
            height:26px;
            padding:0px 10px;
            border:none
        }

        /* Skin custom elements */
        #panel1.yui-panel .hd span {
            line-height:30px;
            vertical-align:middle;
            font-weight:bold;
        }
        #panel1.yui-panel .hd .tl {
            width:8px;
            height:29px;
            top:1px;
            left:0px;
            background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
            position:absolute;
        }

        #panel1.yui-panel .hd .closeMe {
            position:absolute;
            top:5px;
            right:8px;
            height:21px;
            width:21px;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
        }

        #panel1.yui-panel .hd .tr {
            width:8px;
            height:29px;
            top:1px;
            right:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat;
            position:absolute;
        }

        #panel1.yui-panel .ft span {
            line-height:22px;
            vertical-align:middle;
        }
        #panel1.yui-panel .ft .bl {
            width:8px;
            height:26px;
            bottom:0;
            left:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
            position:absolute;
        }
        #panel1.yui-panel .ft .br {
            width:8px;
            height:26px;
            bottom:0;
            right:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
            position:absolute;
        }

        #panelPse_c.yui-panel-container.shadow .underlay {
            left:1px;
            right:-1px;
            top:1px;
            bottom:-1px;
            position:absolute;
            background-color:#000;
            opacity:0.12;
            filter:alpha(opacity=12);
        }

        /* Apply the border to the right side */
        #panelPse.yui-panel {
            border:none;
            overflow:visible;
            background:transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat top right;
        }

        /* Style the close icon */
        #panelPse.yui-panel .container-close {
            position:absolute;
            top:5px;
            right:8px;
            height:21px;
            width:21px;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
        }

        /* Style the header with its associated corners */
        #panelPse.yui-panel .hd {
            padding:0;
            border:none;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-hd.gif) repeat-x;
            color:#FFF;
            height:30px;
            margin-left:0px;
            margin-right:0px;
            text-align:left;
            vertical-align:middle;
            overflow:visible;
        }

        /* Style the body with the left border */
        #panelPse.yui-panel .bd {
            overflow:hidden;
            padding:10px;
            border:none;
            background:#FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y;
            margin:0 4px 0 0;
        }

        /* Style the footer with the bottom corner images */
        #panelPse.yui-panel .ft {
            background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
            font-size:11px;
            height:26px;
            padding:0px 10px;
            border:none
        }

        /* Skin custom elements */
        #panelPse.yui-panel .hd span {
            line-height:30px;
            vertical-align:middle;
            font-weight:bold;
        }
        #panelPse.yui-panel .hd .tl {
            width:8px;
            height:29px;
            top:1px;
            left:0px;
            background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
            position:absolute;
        }

        #panelPse.yui-panel .hd .closeMe {
            position:absolute;
            top:5px;
            right:8px;
            height:21px;
            width:21px;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
        }

        #panelPse.yui-panel .hd .tr {
            width:8px;
            height:29px;
            top:1px;
            right:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat;
            position:absolute;
        }

        #panelPse.yui-panel .ft span {
            line-height:22px;
            vertical-align:middle;
        }
        #panelPse.yui-panel .ft .bl {
            width:8px;
            height:26px;
            bottom:0;
            left:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
            position:absolute;
        }
        #panelPse.yui-panel .ft .br {
            width:8px;
            height:26px;
            bottom:0;
            right:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
            position:absolute;
        }


        #panelRmCopy_c.yui-panel-container.shadow .underlay {
            left:1px;
            right:-1px;
            top:1px;
            bottom:-1px;
            position:absolute;
            background-color:#000;
            opacity:0.12;
            filter:alpha(opacity=12);
        }

        /* Apply the border to the right side */
        #panelRmCopy.yui-panel {
            border:none;
            overflow:visible;
            background:transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat top right;
        }

        /* Style the close icon */
        #panelRmCopy.yui-panel .container-close {
            position:absolute;
            top:5px;
            right:8px;
            height:21px;
            width:21px;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
        }

        /* Style the header with its associated corners */
        #panelRmCopy.yui-panel .hd {
            padding:0;
            border:none;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-hd.gif) repeat-x;
            color:#FFF;
            height:30px;
            margin-left:0px;
            margin-right:0px;
            text-align:left;
            vertical-align:middle;
            overflow:visible;
        }

        /* Style the body with the left border */
        #panelRmCopy.yui-panel .bd {
            overflow:hidden;
            padding:10px;
            border:none;
            background:#FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y;
            margin:0 4px 0 0;
        }

        /* Style the footer with the bottom corner images */
        #panelRmCopy.yui-panel .ft {
            background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
            font-size:11px;
            height:26px;
            padding:0px 10px;
            border:none
        }

        /* Skin custom elements */
        #panelRmCopy.yui-panel .hd span {
            line-height:30px;
            vertical-align:middle;
            font-weight:bold;
        }
        #panelRmCopy.yui-panel .hd .tl {
            width:8px;
            height:29px;
            top:1px;
            left:0px;
            background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
            position:absolute;
        }

        #panelRmCopy.yui-panel .hd .closeMe {
            position:absolute;
            top:5px;
            right:8px;
            height:21px;
            width:21px;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
        }

        #panelRmCopy.yui-panel .hd .tr {
            width:8px;
            height:29px;
            top:1px;
            right:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat;
            position:absolute;
        }

        #panelRmCopy.yui-panel .ft span {
            line-height:22px;
            vertical-align:middle;
        }
        #panelRmCopy.yui-panel .ft .bl {
            width:8px;
            height:26px;
            bottom:0;
            left:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
            position:absolute;
        }
        #panelRmCopy.yui-panel .ft .br {
            width:8px;
            height:26px;
            bottom:0;
            right:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
            position:absolute;
        }

        /* Skin default elements */
        #panelImg_c.yui-panel-container.shadow .underlay {
            left:1px;
            right:-1px;
            top:1px;
            bottom:-1px;
            position:absolute;
            background-color:#000;
            opacity:0.12;
            filter:alpha(opacity=12);
        }

        /* Apply the border to the right side */
        #panelImg.yui-panel {
            border:none;
            overflow:visible;
            background:transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat top right;
        }

        /* Style the close icon */
        #panelImg.yui-panel .container-close {
            position:absolute;
            top:5px;
            right:8px;
            height:21px;
            width:21px;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
        }

        /* Style the header with its associated corners */
        #panelImg.yui-panel .hd {
            padding:0;
            border:none;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-hd.gif) repeat-x;
            color:#FFF;
            height:30px;
            margin-left:0px;
            margin-right:0px;
            text-align:left;
            vertical-align:middle;
            overflow:visible;
        }

        /* Style the body with the left border */
        #panelImg.yui-panel .bd {
            overflow:hidden;
            padding:10px;
            border:none;
            background:#FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y;
            margin:0 4px 0 0;
        }

        /* Style the footer with the bottom corner images */
        #panelImg.yui-panel .ft {
            background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
            font-size:11px;
            height:26px;
            padding:0px 10px;
            border:none
        }

        /* Skin custom elements */
        #panelImg.yui-panel .hd span {
            line-height:30px;
            vertical-align:middle;
            font-weight:bold;
        }
        #panelImg.yui-panel .hd .tl {
            width:8px;
            height:29px;
            top:1px;
            left:0px;
            background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
            position:absolute;
        }

        #panelImg.yui-panel .hd .closeMe {
            position:absolute;
            top:5px;
            right:8px;
            height:21px;
            width:21px;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
        }

        #panelImg.yui-panel .hd .tr {
            width:8px;
            height:29px;
            top:1px;
            right:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat;
            position:absolute;
        }

        #panelImg.yui-panel .ft span {
            line-height:22px;
            vertical-align:middle;
        }
        #panelImg.yui-panel .ft .bl {
            width:8px;
            height:26px;
            bottom:0;
            left:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
            position:absolute;
        }
        #panelImg.yui-panel .ft .br {
            width:8px;
            height:26px;
            bottom:0;
            right:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
            position:absolute;
        }


        /* Skin default elements */
        #panelImg1_c.yui-panel-container.shadow .underlay {
            left:1px;
            right:-1px;
            top:1px;
            bottom:-1px;
            position:absolute;
            background-color:#000;
            opacity:0.12;
            filter:alpha(opacity=12);
        }

        /* Apply the border to the right side */
        #panelImg1.yui-panel {
            border:none;
            overflow:visible;
            background:transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat top right;
        }

        /* Style the close icon */
        #panelImg1.yui-panel .container-close {
            position:absolute;
            top:5px;
            right:8px;
            height:21px;
            width:21px;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
        }

        /* Style the header with its associated corners */
        #panelImg1.yui-panel .hd {
            padding:0;
            border:none;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-hd.gif) repeat-x;
            color:#FFF;
            height:30px;
            margin-left:0px;
            margin-right:0px;
            text-align:left;
            vertical-align:middle;
            overflow:visible;
        }

        /* Style the body with the left border */
        #panelImg1.yui-panel .bd {
            overflow:hidden;
            padding:10px;
            border:none;
            background:#FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y;
            margin:0 4px 0 0;
        }

        /* Style the footer with the bottom corner images */
        #panelImg1.yui-panel .ft {
            background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
            font-size:11px;
            height:26px;
            padding:0px 10px;
            border:none
        }

        /* Skin custom elements */
        #panelImg1.yui-panel .hd span {
            line-height:30px;
            vertical-align:middle;
            font-weight:bold;
        }
        #panelImg1.yui-panel .hd .tl {
            width:8px;
            height:29px;
            top:1px;
            left:0px;
            background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
            position:absolute;
        }

        #panelImg1.yui-panel .hd .closeMe {
            position:absolute;
            top:5px;
            right:8px;
            height:21px;
            width:21px;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
        }

        #panelImg1.yui-panel .hd .tr {
            width:8px;
            height:29px;
            top:1px;
            right:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat;
            position:absolute;
        }

        #panelImg1.yui-panel .ft span {
            line-height:22px;
            vertical-align:middle;
        }
        #panelImg1.yui-panel .ft .bl {
            width:8px;
            height:26px;
            bottom:0;
            left:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
            position:absolute;
        }
        #panelImg1.yui-panel .ft .br {
            width:8px;
            height:26px;
            bottom:0;
            right:0;
            background:url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
            position:absolute;
        }

        .hide{
            display:none;
            visibility:hidden;
        }
    </style>

</head>
<c:url value="${request.getContextPath()}/hebAssets/images/newButtons/normal.jpg" var="norm"></c:url>
<c:url value="${request.getContextPath()}/hebAssets/images/newButtons/mouse_over.jpg" var="over"></c:url>
<c:url value="${request.getContextPath()}/hebAssets/images/newButtons/mouse_click.jpg" var="clck"></c:url>

<body class=" yui-skin-sam" style="overflow: auto; background-color: #F6F6F6;" bgcolor="#FFF9F4" id="candOtherInfoBody">
    <div id="container" style="background-color: white;">
        <jsp:include page="/header.jsp" />
        <input type="hidden" name="logoutMsgFlg" id="logoutMsgFlg" value="true" />
        <div id="ContentContainer">
            <div class="form-container1" style="padding-top: 20px;">
                <jsp:include page="/cpsErrors.jsp" />
                &nbsp;&nbsp;&nbsp;&nbsp;<label id="mrtMessage" class="labelMessageHead"></label>
                &nbsp;&nbsp;&nbsp;&nbsp;<label id="testScanMessage1" class="labelMessageHead"></label>
                &nbsp;&nbsp;&nbsp;&nbsp;<label id="subBrandMessage" class="labelMessageHead" style="color: red;"></label>
                &nbsp;&nbsp;&nbsp;&nbsp;<label id="lstCstMsg" class="labelMessageHead" style="color: red;"></label>
                &nbsp;&nbsp;<label id="conflictMessage" class="labelMessageHead" style="color: red;"></label>

                <table>
                    <tr>
                        <!-- MRT Tab Starts -->
                        <c:if test="${addNewCandidate.selectedOption == 4}">
                            <td>
                                <div id="mrt" style="position: relative; top: 7px; left: 4px;">
                                    <script type="text/javascript">
                                        var normalImagemrt = new Image();
                                        normalImagemrt.src = '${norm}';
                                        var mouseOvermrt = new Image();
                                        mouseOvermrt.src = '${over}';

                                        function mrtNormalFunction(){
                                            document.getElementById('mrtImg').src = normalImagemrt.src;
                                        }
                                        function mrtMouseOverFunction(){
                                            document.getElementById('mrtImg').src = mouseOvermrt.src;
                                        }
                                    </script>
                                    <a id="mrtTabId" onmouseout="mrtNormalFunction();"
                                       onmouseover="mrtMouseOverFunction();">
                                        <div id="labelmrt" style="position: absolute; top: 5px; left: 30px; color: white; font-size: 2; cursor: pointer;" >
                                            <font color="black" size="2">MRT</font>
                                        </div>
                                        <img src="${norm}" alt="" name="mrt" border="0" id="mrtImg" width="150px" height="25px" />
                                    </a>
                                </div><!-- mrt -->
                            </td>
                        </c:if>
                        <!-- MRT Tab Ends -->
                        <!-- PRODUCT & UPC Tab Starts -->
                        <td>
                            <div id="1" style="position:relative;top:7px;left:4px;">
                                <script type="text/javascript">
                                    var normalImageprodAndUpcTabBut = new Image();
                                    normalImageprodAndUpcTabBut.src = '${norm}';
                                    var mouseOverprodAndUpcTabBut = new Image();
                                    mouseOverprodAndUpcTabBut.src = '${over}';
                                    function prodAndUpcTabButNormalFunction(){
                                        document.getElementById('prodAndUpcTabButImg').src = normalImageprodAndUpcTabBut.src;
                                    }
                                    function prodAndUpcTabButMouseOverFunction(){
                                        document.getElementById('prodAndUpcTabButImg').src = mouseOverprodAndUpcTabBut.src;
                                    }
                                </script>

                                <a  id="prodAndUpcTabBut"  onmouseout="prodAndUpcTabButNormalFunction();" onmouseover="prodAndUpcTabButMouseOverFunction();">
                                    <div id="labelprodAndUpcTabBut" style="position:absolute;top:5px;left:25px;color: white;font-size: 2;cursor: pointer;">
                                        <font color="black" size="2">Product & UPC</font>
                                    </div>
                                    <img src="${norm}" alt="" name="prodAndUpcTabBut"  border="0"  id="prodAndUpcTabButImg"
                                         width="200px" height="25px"/>
                                </a>
                            </div>
                        </td>
                        <!-- PRODUCT & UPC Tab Ends -->
                        <!-- AUTH Tab Starts -->
                        <td>
                            <div id="authAndDist1" style="position: relative; top: 7px; left: 4px;">
                                <script type="text/javascript">
                                    var normalImageauthAndDist = new Image();
                                    normalImageauthAndDist.src = '${norm}';
                                    var mouseOverauthAndDist = new Image();
                                    mouseOverauthAndDist.src = '${over}';
                                    function authAndDistNormalFunction(){
                                        document.getElementById('authAndDistImg').src = normalImageauthAndDist.src;
                                    }
                                    function authAndDistMouseOverFunction(){
                                        document.getElementById('authAndDistImg').src = mouseOverauthAndDist.src;
                                    }
                                </script>
                                <a id="authAndDist" onmouseout="authAndDistNormalFunction();"
                                   onmouseover="authAndDistMouseOverFunction();">
                                    <div id="labelauthAndDist"
                                         style="position: absolute; top: 5px; left: 25px; color: white; font-size: 2; cursor: pointer;">
                                        <font color="black" size="2">Authorization & Distribution</font>
                                    </div>
                                    <img src="${norm}" alt="" name="authAndDist" border="0" id="authAndDistImg" width="200px" height="25px" />
                                </a>
                            </div>
                        </td>
                        <!-- AUTH Tab Ends -->
                        <!-- Images and Attributes Tab Starts -->
                        <%-- <cps:renderByResourceAccess resourceId="271">
                            <jsp:attribute name="VIEW">
                                <td>
                                    <div id="imgAttrDiv" style="position: relative; top: 7px; left: 4px;">
                                        <script type="text/javascript">
                                            var normalImageImgAndAttr = new Image();
                                            normalImageImgAndAttr.src = '${norm}';

                                            var mouseOverImgAndAttr = new Image();
                                            mouseOverImgAndAttr.src = '${over}';

                                            function imgAttrNormalFunction(){
                                                document.getElementById('imgAttrImg').src = normalImageImgAndAttr.src;
                                            }

                                            function imgAttrMouseOverFunction(){
                                                document.getElementById('imgAttrImg').src = mouseOverImgAndAttr.src;
                                            }
                                        </script>
                                        <a id="imgAttr" onmouseout="imgAttrNormalFunction();" onmouseover="imgAttrMouseOverFunction();">
                                            <div id="labelimgAttr" style="position: absolute; top: 5px; left: 30px; color: white; font-size: 2; cursor: pointer;">
                                                <font color="black" size="2">Images & Attributes</font>
                                            </div>
                                            <img src="${norm}" alt="" name="imgAttr" border="0" id="imgAttrImg" width="185px" height="25px" />
                                        </a>
                                     </div>
                                </td>
                            </jsp:attribute>
                            <jsp:attribute name="EDIT">
                                <td>
                                    <div id="imgAttrDiv" style="position: relative; top: 7px; left: 4px;">
                                        <script type="text/javascript">
                                            var normalImageImgAndAttr = new Image();
                                            normalImageImgAndAttr.src = '${norm}';

                                            var mouseOverImgAndAttr = new Image();
                                            mouseOverImgAndAttr.src = '${over}';

                                            function imgAttrNormalFunction(){
                                                document.getElementById('imgAttrImg').src = normalImageImgAndAttr.src;
                                            }

                                            function imgAttrMouseOverFunction(){
                                                document.getElementById('imgAttrImg').src = mouseOverImgAndAttr.src;
                                            }
                                        </script>
                                        <a id="imgAttr" onmouseout="imgAttrNormalFunction();" onmouseover="imgAttrMouseOverFunction();">
                                            <div id="labelimgAttr" style="position: absolute; top: 5px; left: 30px; color: white; font-size: 2; cursor: pointer;">
                                                <font color="black" size="2">Images & Attributes</font>
                                            </div>
                                            <img src="${norm}" alt="" name="imgAttr" border="0" id="imgAttrImg" width="185px" height="25px" />
                                        </a>
                                    </div>
                                </td>
                            </jsp:attribute>
                        </cps:renderByResourceAccess> --%>
                        <!-- Images and Attributes Tab Ends -->
                        <!-- Audit Tab Starts -->
                        <td>
                            <div id="contpow" style="position: relative; top: 7px; left: 4px;">
                                <script type="text/javascript">
                                    var normalImagepow = new Image();
                                    normalImagepow.src = '${norm}';

                                    var mouseOverpow = new Image();
                                    mouseOverpow.src = '${over}';

                                    function powNormalFunction(){
                                        document.getElementById('powImg').src = normalImagepow.src;
                                    }

                                    function powMouseOverFunction(){
                                        document.getElementById('powImg').src = mouseOverpow.src;
                                    }
                                </script>
                                <a id="pow" onmouseout="powNormalFunction();" onmouseover="powMouseOverFunction();">
                                    <div id="labelpow" style="position: absolute; top: 5px; left: 30px; color: white; font-size: 2; cursor: pointer;">
                                        <font color="black" size="2">Additional Information</font>
                                    </div>
                                    <img src="${norm}" alt="" name="pow" border="0" id="powImg" width="185px" height="25px" />
                                </a>
                            </div>
                        </td>
                        <!-- Audit Tab Ends -->
                    </tr>
                </table>

                <%-- fieldset's inline style is now in common.css.jsp --%>
                <fieldset style="background-color: white; margin-right: 6px; padding-bottom: 5px; padding-top: 5px;
                width: 100%; z-index: 50; color: #000000; height: 700px; overflow-x: hidden; overflow-y: auto;
                position: relative; left: -10px; border-color: #9AB1DA" id="prodAuthField">
                    <c:if test="${addNewCandidate.tabIndex == 80}">
                        <div id="tabview2">
                            <jsp:include page="/cps/add/modules/productAndUpc.jsp" />
                        </div>
                    </c:if>
                    <c:if test="${addNewCandidate.tabIndex == 110}">
                        <div id="tabview4">
                            <jsp:include page="/cps/add/modules/powStatusPage.jsp" />
                        </div>
                    </c:if>
                    <c:if test="${addNewCandidate.tabIndex == 120}">
                        <div id="tabview3">
                            <jsp:include page="/cps/add/modules/mrtMainScreen.jsp" />
                        </div>
                     </c:if>
                    <c:if test="${addNewCandidate.tabIndex == 130}">
                        <div id="tabview5">
                            <jsp:include page="/cps/add/modules/authorizationAndDistribution.jsp" />
                        </div>
                    </c:if>
                   <%-- <c:if test="${addNewCandidate.tabIndex == 140}">
                        <div id="tabview6">
                            <jsp:include page="/cps/add/modules/imagesAndAttributes.jsp" />
                        </div>
                    </c:if>--%>
                </fieldset>

                <!--Button-->
                <table width="100%" border="0">
                    <tr>
                        <td width="30%" align="right"></td>
                        <td width="9%" align="right" height="15px">
                            <c:if test="${addNewCandidate.selectedFunction == 6}">
                                <button id="testScan1" name="testScan" value="testscan">Test Scan.</button>
                            </c:if>
                        </td>
                        <td width="9%" align="right">
                            <c:if test="${addNewCandidate.selectedFunction == 6}">
                                <button id="Candidate1" name="submitCandidate" value="">Submit Cand.</button>
                            </c:if>
                        </td>
                        <td width="9%" align="right">
                             <c:if test="${addNewCandidate.selectedFunction == 6}">
                                 <button type="button" id="activateCandidate1" name="activateCandidate">
                                     Activate Cand.
                                 </button>
                             </c:if>
                        </td>
                        <td width="9%" align="right">
                            <c:if test="${addNewCandidate.selectedFunction == 6}">
                                <button type="button" id="saveCandidate1" name="saveCandidate">Save</button>
                            </c:if>
                        </td>
                        <c:set value="disabled" var="styleStr" />
                        <c:choose>
                        <c:when test="${addNewCandidate.testScanNeeded}">
                        <c:set value="false" var="styleStr" />
                        </c:when>
                        </c:choose>
                        <td align="right" width="40%" nowrap>
                            <cps:renderByResourceAccess resourceId="270"  honorViewMode="${addNewCandidate.buttonViewOverRide}">
                                <jsp:attribute name="EXEC">
                                    <c:if test="${addNewCandidate.tabIndex == 140 && addNewCandidate.upcAdded && addNewCandidate.containUpcNew}">
                                        <button id="copyToAllUpc" name="copyToAllUpc" value="copyUpcs" style="width: 10em;">
                                            Copy To All UPCs
                                        </button>
                                    </c:if>
                                </jsp:attribute>
                            </cps:renderByResourceAccess>
                            <cps:renderByResourceAccess resourceId="162" honorViewMode="${addNewCandidate.buttonViewOverRide}">
                                <jsp:attribute name="EXEC">
                                    <c:if test="${!addNewCandidate.hidMrtSwitch}">
                                        <button id="testScanBut" name="testScanBut" value="testscan" style="width: 7em;">Test Scan</button>
                                    </c:if>
                                </jsp:attribute>
                            </cps:renderByResourceAccess>
                            <cps:renderByResourceAccess resourceId="158"  honorViewMode="${addNewCandidate.buttonViewOverRide}">
                                <jsp:attribute name="EXEC">
                                    <c:choose>
                                    <c:when test="${addNewCandidate.holdingPendingProdIds}">
                                        <c:set value="Save & Close" var="bTxt" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set value="Save" var="bTxt" />
                                    </c:otherwise>
                                    </c:choose>
                                    <button id="saveButton" name="saveButton" value="saveDiv" style="width: 5em;" >${bTxt}</button>
                                </jsp:attribute>
                            </cps:renderByResourceAccess>
                            <cps:renderByResourceAccess resourceId="159"  honorViewMode="${addNewCandidate.buttonViewOverRide}">
                                <jsp:attribute name="EXEC">
                                    <button id="approveButton" name="approveButton" value="Div1" style="width: 6em;">Submit</button>
                                </jsp:attribute>
                            </cps:renderByResourceAccess>
                            <cps:renderByResourceAccess resourceId="160"  honorViewMode="${addNewCandidate.buttonViewOverRide}">
                                <jsp:attribute name="EXEC">
                                    <button id="activateButton" name="activateButton" value="activate" style="width: 6em;">Activate</button>
                                </jsp:attribute>
                            </cps:renderByResourceAccess>
                            <cps:renderByResourceAccess resourceId="161"  honorViewMode="${addNewCandidate.buttonViewOverRide}">
                                <jsp:attribute name="EXEC">
                                    <button id="rejectBut" name="rejectBut" value="reject" style="width: 5em;">Reject</button>
                                </jsp:attribute>
                            </cps:renderByResourceAccess>
                            <cps:renderByResourceAccess resourceId="281" honorViewMode="${addNewCandidate.buttonViewOverRide}">
                                <jsp:attribute name="EXEC">
                                    <button id="deleteBtn" name="deleteBtn" value="delete" style="width: 5em;">Delete</button>
                                </jsp:attribute>
                            </cps:renderByResourceAccess>
                            <!-- Adding Modify button in the view page -->
                            <c:if test="${addNewCandidate.viewMode}">
                                <c:choose>
                                    <c:when test="${addNewCandidate.product}">
                                        <cps:renderByResourceAccess resourceId="229" honorViewMode="${!addNewCandidate.buttonViewOverRide}">
                                            <jsp:attribute name="EXEC">
                                                <button id="modifyProdFormButton" name="modifyProdFormButton" value="modifyProdFormButton" style="width: 5em;">
                                                    Modify
                                                </button>
                                            </jsp:attribute>
                                        </cps:renderByResourceAccess>
                                    </c:when>
                                <c:otherwise>
                                    <c:if test="${addNewCandidate.eligibleToModify}">
                                        <cps:renderByResourceAccess resourceId="164" honorViewMode="${!addNewCandidate.buttonViewOverRide}">
                                            <jsp:attribute name="EXEC">
                                                <button id="modifyFormButton" name="modifyFormButton" value="modifyFormButton" style="width: 5em;">
                                                    Modify
                                                </button>
                                            </jsp:attribute>
                                        </cps:renderByResourceAccess>
                                    </c:if>
                                </c:otherwise>
                                </c:choose>
                            </c:if>
                            <cps:renderByResourceAccess resourceId="234" honorViewMode="${addNewCandidate.buttonViewOverRide}">
                                <jsp:attribute name="EXEC">
                                    <c:if test="${!addNewCandidate.hidMrtSwitch}">
                                        <c:if test="${addNewCandidate.productVO.psProdId ne null && addNewCandidate.productVO.psProdId ne ''}">
                                            <button type="button" id="printFormId" name="printFormId" value="printFormId"  style="width: 6em;">
                                                Print Form
                                            </button>
                                        </c:if>
                                        <c:if test="${addNewCandidate.productVO.psProdId eq null || addNewCandidate.productVO.psProdId eq ''}">
                                            <button type="button" id="printFormId" name="printFormId" value="printFormId"  style="width: 6em;" disabled="disabled">
                                                Print Form
                                            </button>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${addNewCandidate.hidMrtSwitch}">
                                        <button type="button" id="printFormId" name="printFormId" value="printFormId"  style="width: 6em;">
                                            Print Form
                                        </button>
                                    </c:if>
                                </jsp:attribute>
                            </cps:renderByResourceAccess>
                            <c:if test="${addNewCandidate.viewMode && addNewCandidate.holdingPendingProdIds}">
                                <button id="viewNextButton" name="viewNextButton" value="viewnext" style="width: 5em;">View Next</button>
                            </c:if>
                            <%
                                String present_bts = (String)request.getSession().getAttribute(CPSConstants.PRESENT_BTS);
                                if(present_bts.equals("2")){
                            %>
                            <c:if test="${addNewCandidate.viewMode || addNewCandidate.modifyMode}">
                                <button id="backToSearchButton" name="backToSearchButton" value="backtosearch" style="width: 5em;">
                                    Back To Search
                                </button>
                            </c:if>
                            <%
                                }
                            %>
                            <c:if test="${addNewCandidate.tabIndex == 130 && !addNewCandidate.viewMode && addNewCandidate.holdingPendingProdIds}">
                                <button id="closeButton" name="closeButton" value="closeButton" style="width: 5em;">Close</button>
                            </c:if>
                        </td>
                    </tr>
                </table>
                <input type="hidden" value="${addNewCandidate.modifyProdCand}" id="isModify">
            </div>
        </div>
        <br class="clearfloat" />
    </div>

    <script type="text/javascript">

        YAHOO.util.Event.onDOMReady(function(){
            //toggleVisible( "imgAttrDiv", ${addNewCandidate.productVO.classificationVO.eligible});
        });

        function toggleVisible ( divORdom, force)
        {
            if ( force === undefined || force==='' )
                force = ( YAHOO.util.Dom.hasClass( divORdom,'hide') ) ? true :  false;

            if ( force===true )
                YAHOO.util.Dom.removeClass( divORdom, 'hide');
            else
                YAHOO.util.Dom.addClass( divORdom, 'hide');
        }

        var copyAllButton = new YAHOO.widget.Button("copyToAllUpc");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("copyToAllUpc"), "click", copyAllUpcCand);

        <cps:renderByResourceAccess resourceId="162"  honorViewMode="${addNewCandidate.buttonViewOverRide}">
        <jsp:attribute name="EXEC">
        <c:if test="${!addNewCandidate.hidMrtSwitch}">
        var oPushButton1 = new YAHOO.widget.Button("testScanBut");
        YAHOO.util.Event.removeListener(YAHOO.util.Dom.get("testScanBut"), "click");
        <c:choose>
        <c:when test="${addNewCandidate.testScanNeeded}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("testScanBut"), "click", testScan);
        YAHOO.util.Dom.get("testScanBut").disabled = false;
        </c:when>
        <c:otherwise>
        YAHOO.util.Dom.get("testScanBut").disabled = true;
        </c:otherwise>
        </c:choose>
        </c:if>
        </jsp:attribute>
        </cps:renderByResourceAccess>

        <cps:renderByResourceAccess resourceId="158"  honorViewMode="${addNewCandidate.buttonViewOverRide}">
        <jsp:attribute name="EXEC">
        var oPushButton2 = new YAHOO.widget.Button("saveButton");
        <c:choose>
        <c:when test="${addNewCandidate.tabIndex == 120}">
        YAHOO.util.Dom.get("saveButton").disabled = true;
        </c:when>
        </c:choose>
        </jsp:attribute>
        </cps:renderByResourceAccess>

        <cps:renderByResourceAccess resourceId="159"  honorViewMode="${addNewCandidate.buttonViewOverRide}">
        <jsp:attribute name="EXEC">
        var oPushButton3 = new YAHOO.widget.Button("approveButton");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("approveButton"), "click", submitCand);
        </jsp:attribute>
        </cps:renderByResourceAccess>

        <cps:renderByResourceAccess resourceId="160"  honorViewMode="${addNewCandidate.buttonViewOverRide}">
        <jsp:attribute name="EXEC">
        var oPushButton4 = new YAHOO.widget.Button("activateButton");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("activateButton"), "click", activateCand);
        </jsp:attribute>
        </cps:renderByResourceAccess>

        <cps:renderByResourceAccess resourceId="161"  honorViewMode="${addNewCandidate.buttonViewOverRide}">
        <jsp:attribute name="EXEC">
        var oPushButton4 = new YAHOO.widget.Button("rejectBut");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("rejectBut"), "click", reject);
        </jsp:attribute>
        </cps:renderByResourceAccess>

        <cps:renderByResourceAccess resourceId="281" honorViewMode="${addNewCandidate.buttonViewOverRide}">
        <jsp:attribute name="EXEC">
        var oPushButton4 = new YAHOO.widget.Button("deleteBtn");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteBtn"), "click", deleteCand);
        </jsp:attribute>
        </cps:renderByResourceAccess>

        <c:if test="${addNewCandidate.viewMode && addNewCandidate.holdingPendingProdIds}">
        var viewNextButton = new YAHOO.widget.Button("viewNextButton");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("viewNextButton"), "click", viewNext);
        </c:if>

        <c:if test="${addNewCandidate.tabIndex == 130 && !addNewCandidate.viewMode && addNewCandidate.holdingPendingProdIds}">
        var viewNextButton = new YAHOO.widget.Button("closeButton");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("closeButton"), "click", viewNext);
        </c:if>

        var backToSearchButton = new YAHOO.widget.Button("backToSearchButton");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("backToSearchButton"), "click", backToSearch);

        <c:if test="${addNewCandidate.viewMode}">
        <c:choose>
        <c:when test="${addNewCandidate.product}">
        <cps:renderByResourceAccess resourceId="229" honorViewMode="${!addNewCandidate.buttonViewOverRide}">
        <jsp:attribute name="EXEC">
        var modifyProdFormButton = new YAHOO.widget.Button("modifyProdFormButton");
        <c:if test="${addNewCandidate.tabIndex == 80}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifyProdFormButton"), "click", modifyProdForm);
        </c:if>
        <c:if test="${addNewCandidate.tabIndex == 130}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifyProdFormButton"), "click", modifyAuthForm);
        </c:if>
        <c:if test="${addNewCandidate.tabIndex == 110}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifyProdFormButton"), "click", modifyAdditionalForm);
        </c:if>
        <c:if test="${addNewCandidate.tabIndex == 140}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifyProdFormButton"), "click", modifyImageAttributeForm);
        </c:if>
        </jsp:attribute>
        </cps:renderByResourceAccess>
        </c:when>
        <c:otherwise>
        <c:if test="${addNewCandidate.eligibleToModify}">
        <cps:renderByResourceAccess resourceId="164" honorViewMode="${!addNewCandidate.buttonViewOverRide}">
        <jsp:attribute name="EXEC">
        var modifyFormButton = new YAHOO.widget.Button("modifyFormButton");
        <c:if test="${addNewCandidate.tabIndex == 80}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifyFormButton"), "click", modifyForm);
        </c:if>
        <c:if test="${addNewCandidate.tabIndex == 130}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifyFormButton"), "click", modifyAuthForm);
        </c:if>
        <c:if test="${addNewCandidate.tabIndex == 110}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifyFormButton"), "click", modifyAdditionalForm);
        </c:if>
        <c:if test="${addNewCandidate.tabIndex == 120}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifyFormButton"), "click", modifyMRTForm);
        </c:if>
        <c:if test="${addNewCandidate
        .tabIndex == 140}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifyFormButton"), "click", modifyImageAttributeForm);
        </c:if>
        </jsp:attribute>
        </cps:renderByResourceAccess>
        </c:if>
        </c:otherwise>
        </c:choose>
        </c:if>

        <cps:renderByResourceAccess resourceId="158"  honorViewMode="${addNewCandidate.buttonViewOverRide}">
        <jsp:attribute name="EXEC">
        <c:if test="${addNewCandidate.tabIndex == 80}">
        <cps:renderByResourceAccess resourceId="201" honorViewMode="${addNewCandidate.buttonViewOverRide}">
        <jsp:attribute name="EXEC">
        <c:choose>
        <c:when test="${addNewCandidate.scaleAttrib eq 'I'}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveButton"), "click", saveScaleDetails);
        </c:when>
        <c:otherwise>
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveButton"),"click", saveDetails);
        </c:otherwise>
        </c:choose>
        </jsp:attribute>
        <jsp:attribute name="NONE">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveButton"),"click", saveDetails);
        </jsp:attribute>
        </cps:renderByResourceAccess>
        </c:if>
        <c:if test="${addNewCandidate.tabIndex == 110}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveButton"),"click", saveAttachments);
        </c:if>
        <c:if test="${addNewCandidate.tabIndex == 140}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveButton"),"click", saveImageAttriDetails);
        </c:if>
        </jsp:attribute>
        </cps:renderByResourceAccess>

        <c:url value="candSearch?${_csrf.parameterName}=${_csrf.token}" var="link1"></c:url>
        <c:url value="/protected/cps/add/submit?${_csrf.parameterName}=${_csrf.token}" var="submited"></c:url>
        <c:url value="/protected/cps/add/activate?${_csrf.parameterName}=${_csrf.token}" var="activeCand"></c:url>
        <c:url value="/protected/cps/add/testScanNew?${_csrf.parameterName}=${_csrf.token}" var="testScanFrom"></c:url>
        <c:url value="/protected/cps/add/copyToAllUpc?${_csrf.parameterName}=${_csrf.token}" var="copyToAllUpcCand"></c:url>

        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("submitButton"), "click", manageCand);

        <c:choose>
        <c:when test="${addNewCandidate.holdingPendingProdIds}">
        <c:url value="/protected/cps/add/removeAndGetNextDetails?${_csrf.parameterName}=${_csrf.token}" var="mrtProd"></c:url>
        <c:url value="/protected/cps/add/removeAndGetNextDetails?${_csrf.parameterName}=${_csrf.token}" var="prod"></c:url>
        <c:url value="/protected/cps/add/removeAndGetNextDetails?${_csrf.parameterName}=${_csrf.token}" var="saveImageAttriDetails"></c:url>
        </c:when>
        <c:otherwise>
        <c:url value="/protected/cps/add/saveDetails?${_csrf.parameterName}=${_csrf.token}" var="mrtProd"></c:url>
        <c:url value="/protected/cps/add/saveDetails?${_csrf.parameterName}=${_csrf.token}" var="prod"></c:url>
        <c:url value="/protected/cps/add/saveImageAttriDetails?${_csrf.parameterName}=${_csrf.token}" var="saveImageAttriDetails"></c:url>
        </c:otherwise>
        </c:choose>

        <c:url value="/protected/cps/add/saveCaseDetails?${_csrf.parameterName}=${_csrf.token}" var="authSave"></c:url>
        <c:url value="/protected/cps/add/saveAttachments?${_csrf.parameterName}=${_csrf.token}" var="saveAttachment"></c:url>
        <c:url value="/protected/cps/add/viewNext?${_csrf.parameterName}=${_csrf.token}" var="viewNext"></c:url>

        function saveAttachments(evt){
            document.powStatusForm.action = "${saveAttachment}";
            document.powStatusForm.submit();
        }
        var saveUPCHook = false;
        var saveNewUPCHook = false;
        var upcAdded = false;

        function myTrim(x) {
            return x.replace(/^\s+|\s+$/gm,'');
        }

        function saveDetails(evt){
            enableCheckboxForSave();

            var btnNewSelling=YAHOO.util.Dom.get("btnNewSelling");
            if(btnNewSelling){
                var msgSellingResReturn = validateBeforeSave();
                if(msgSellingResReturn!=""){
                    alert(msgSellingResReturn);
                    enableButtonWhenValidate(false);
                    return false;
                }
            }

            if(saveUPCHook == true){
                goToNextTabHook = goToProdSave;
                addUpc();
            }else if(saveNewUPCHook == true){
                goToNextTabHook = goToProdSave;
                addUpcNew();
            }else{
                enableButtonWhenValidate(true);
                var commodity=YAHOO.util.Dom.get("commodityACInput");
                var subCommodity=YAHOO.util.Dom.get("subCommodityACInput");
                var classCommodity=YAHOO.util.Dom.get("classDisplay");
                var brick=YAHOO.util.Dom.get("brickACInput");
                var merchandise = YAHOO.util.Dom.get("merchTypes");
                var productType = YAHOO.util.Dom.get("prodTypeSelect");
                var proddesc = YAHOO.util.Dom.get("proddescHidden");

                if(null != productType && productType != undefined){
                    if(productType.value == ""){
                        alert('Please enter Product Type before saving.');
                        hideProgress();
                        enableButtonWhenValidate(false);
                        return false;
                    }
                }
                if(null != merchandise && merchandise != undefined){
                    if(merchandise.options[merchandise.selectedIndex].text == "" || merchandise.options[merchandise.selectedIndex].text == "--Select--"){
                        alert('Please enter Merchandise before saving.');
                        hideProgress();
                        enableButtonWhenValidate(false);
                        return false;
                    }
                }
                if(commodity && subCommodity && classCommodity) {
                    if(commodity.value == "" || subCommodity.value == "" || classCommodity.value == "") {
                        alert('Please enter Commodity, Sub Commodity and Class before saving.');
                        enableButtonWhenValidate(false);
                        return false;
                    }
                }
                if(proddesc && (proddesc.innerText == null || proddesc.innerText == "")){
                    alert('Please enter Product Description before saving.');
                    enableButtonWhenValidate(false);
                    return false;
                }
                if(document.getElementById("brandACInput")){
                    if(document.getElementById("brandACInput").value=='' || document.getElementById("brandACInput").value=='UNASSIGNED'){
                        alert('Candidate cannot be submitted/activated with the Brand \"Unassigned\"');
                        YAHOO.util.Dom.get("brandName").value = '';
                        enableButtonWhenValidate(false);
                        //return false;
                    }
                }
                clearKitComponent();
                document.forms[0].action = "${prod}";
                if(!YAHOO.util.Dom.hasClass('brickAutoComplete', 'hide')){
                    AddCandidateTemp.checkUpc(afterCheckUpc);
                }else{
                    doSaveDataDetails();
                }
            }
        }

        function enableButtonWhenValidate(flag) {
            if(document.getElementById("saveButton")){
                document.getElementById("saveButton").disabled = flag;
            }
            if(document.getElementById("nextButton")){
                document.getElementById("nextButton").disabled = flag;
            }
            if(document.getElementById("scaleNextButton")){
                document.getElementById("scaleNextButton").disabled = flag;
            }
        }

        function afterCheckUpc(data){
            var msgData = data.messages;
            if(! msgData.exception){
                if(data.appData.valid){
                    if(checkBrick(data.appData.newDataSw)){
                        doSaveDataDetails();
                    }else{
                        hideProgress();
                    }
                }else{
                    doSaveDataDetails();
                }
            }else{
                alert(msgData);
                hideProgress();
            }
        }

        function doSaveDataDetails(){
            showProgress();
            document.forms[0].submit();
        }

        <c:url value="saveDetails" var="saveOnBrandChange"></c:url>
        function saveDetailsOnBrandChange(evt){
            if(saveUPCHook == true){
                goToNextTabHook = goToProdSave;
                addUpc();
            }else if(saveNewUPCHook == true){
                goToNextTabHook = goToProdSave;
                addUpcNew();
            }else{
                if(document.getElementById("saveButton")){
                    document.getElementById("saveButton").disabled = true;
                }
                if(document.getElementById("nextButton")){
                    document.getElementById("nextButton").disabled = true;
                }
                if(document.getElementById("scaleNextButton")){
                    document.getElementById("scaleNextButton").disabled = true;
                }
                var commodity=YAHOO.util.Dom.get("commodityACInput");
                var subCommodity=YAHOO.util.Dom.get("subCommodityACInput");
                var classCommodity=YAHOO.util.Dom.get("classDisplay");
                var brick=YAHOO.util.Dom.get("brickACInput");
                var merchandise = YAHOO.util.Dom.get("merchTypes");
                var proddesc = YAHOO.util.Dom.get("proddescHidden");
                if(null != merchandise && merchandise != undefined){
                    if(merchandise.value == "" || merchandise.value == "--Select--"){
                        alert('Please enter Merchandise before saving.');
                        hideProgress();
                        if(document.getElementById("saveButton")){
                            document.getElementById("saveButton").disabled = false;
                        }
                        if(document.getElementById("nextButton")){
                            document.getElementById("nextButton").disabled = false;
                        }
                        if(document.getElementById("scaleNextButton")){
                            document.getElementById("scaleNextButton").disabled = false;
                        }
                        return false;
                    }
                }
                if(commodity && subCommodity && classCommodity) {
                    if(commodity.value == "" || subCommodity.value == "" || classCommodity.value == "") {
                        alert('Please enter Commodity, Sub Commodity and Class before saving.');
                        if(document.getElementById("saveButton")){
                            document.getElementById("saveButton").disabled = false;
                        }
                        if(document.getElementById("nextButton")){
                            document.getElementById("nextButton").disabled = false;
                        }
                        if(document.getElementById("scaleNextButton")){
                            document.getElementById("scaleNextButton").disabled = false;
                        }
                        hideProgress();
                        return false;
                    }
                }
                if(proddesc && (proddesc.innerText == null || proddesc.innerText == "")){
                    alert('Please enter Product Description before saving.');
                    enableButtonWhenValidate(false);
                    hideProgress();
                    return false;
                }
                clearKitComponent();
                document.forms[0].action = "${saveOnBrandChange}";
                if(!YAHOO.util.Dom.hasClass('brickAutoComplete', 'hide')){
                    AddCandidateTemp.checkUpc(afterCheckUpc);
                }else{
                    doSaveDataDetails();
                }
            }
        }

        function goToProdSave(evt) {
            if(document.getElementById("brandACInput")){
                if(document.getElementById("brandACInput").value==''||document.getElementById("brandACInput").value=='UNASSIGNED'){
                    alert('Candidate cannot be submitted/activated with the Brand \"Unassigned\"');
                    YAHOO.util.Dom.get("brandName").value = '';
                    enableButtonWhenValidate(false);
                }
                showProgress();
                document.forms[0].action = "${prod}";
                document.forms[0].submit();
            }
        }

        function saveMRTDetails(evt){
            document.mrtForm.action = "${mrtProd}";
            document.mrtForm.submit();
        }

        function saveCaseDetails(evt){
            document.authAndDistForm.action = "${authSave}";
            document.authAndDistForm.submit();
        }

        function saveImageAttriDetails(evt){
            // document.imageAndAttrForm.action = "${saveImageAttriDetails}";
            // document.imageAndAttrForm.submit();
        }

        function manageCand(evt) {
            document.forms[0].action = "${link1}";
            document.forms[0].submit();
        }

        function submitCand(evt) {
            var message = confirm('Are you sure you want to submit the selected candidate?');
            if(message){
                showProgress();
                if(document.getElementById('approveButton')!=null) {
                    document.getElementById('approveButton').disabled = true;
                }
                document.forms[0].action = "${submited}";
                document.forms[0].submit();
            }
        }

        function copyAllUpcCand(evt){
            // showProgress();
            // AddCandidateTemp.checkValidUpcCopyToAll(getDWRCallbackMethod(copyAllUpcCandCallBack));
        }

        function copyAllUpcCandCallBack(data){
            hideProgress();
            if(data!='' && data == true){
                var message = confirm('Are you sure you want to copy data of to all the UPCs of this product?');
                if(message){
                    showProgress();
                    document.forms[0].action = "${copyToAllUpcCand}";
                    document.forms[0].submit();
                }
            } else {
                alert("Activated UPC cannot be copied to new UPCs");
                return false;
            }
        }

        function activateCand(evt) {
            //workStatusCode=103 as Vendor Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='103'} && ${!addNewCandidate.vendor}) {
                alert("This is a vendor candidate, you may not activate");
                return false;
            }
            // PIM-1686 Validate selling restriction
            var btnNewSelling=YAHOO.util.Dom.get("btnNewSelling");
            if (btnNewSelling) {
                var msgSellingResReturn = validateBeforeSave();
                if (msgSellingResReturn != "") {
                    alert(msgSellingResReturn);
                    enableButtonWhenValidate(false);
                    return false;
                }
            }
            //PIM 354
            showProgress();
            var taxFlag =${addNewCandidate.productVO.pointOfSaleVO.taxable};
            var foodStamp = ${addNewCandidate.productVO.pointOfSaleVO.foodStamp};
            var taxFlagDefault = ${addNewCandidate.productVO.pointOfSaleVO.taxableDefault};
            var foodStampDefault = ${addNewCandidate.productVO.pointOfSaleVO.foodStampDefault};
            var taxFlagWarning = '';
            var taxFlagDefaultValue = 'N=No';
            var taxFlagValue = 'N=No';
            var foodStampWarning = '';
            var foodStampValue = 'N=No';
            var foodStampDefaultValue = 'N=No';
            var warningContent='';
            if(${addNewCandidate.questionnarieVO !=null } && ${addNewCandidate.questionnarieVO.selectedOption != 4}){
                if(taxFlag!=taxFlagDefault){
                    if(taxFlag)
                        taxFlagValue = 'Y=Yes';
                    if(taxFlagDefault)
                        taxFlagDefaultValue = 'Y=Yes';
                    taxFlagWarning = 'Tax Flag (selected as '+taxFlagValue+') is different than the default for the sub-commodity (set at '+taxFlagDefaultValue+').';
                }
                if(foodStamp!=foodStampDefault){
                    if(foodStamp)
                        foodStampValue = 'Y=Yes';
                    if(foodStampDefault)
                        foodStampDefaultValue = 'Y=Yes';
                    foodStampWarning = ' Food Stamp Flag (selected as '+foodStampValue+') is different than the default for the sub-commodity (set at '+foodStampDefaultValue+').';

                }
                if(taxFlagWarning!=''){
                    warningContent = warningContent + taxFlagWarning + '\n\n';
                }
                if(foodStampWarning!=''){
                    warningContent = warningContent + foodStampWarning;
                }
            }
            if(warningContent!=null && warningContent!=''){
                hideProgress();
                warningContent = warningContent +'\n\n';
                warningContent = warningContent +'For assistance with the rules, please contact Procurement Support\'s Product Team at ext. 87800, Option #1.'
                warningContent = warningContent +'\n\n';
                warningContent += 'Do you want to proceed with activation?';
                var messageSelected = confirm(warningContent);
                if(messageSelected){
                    showProgress();
                    if(document.getElementById('activateButton')!=null) {
                        document.getElementById('activateButton').disabled = true;
                    }
                    document.forms[0].action = "${activeCand}";
                    document.forms[0].submit();
                }
            } else {
                hideProgress();
                var message = confirm('Are you sure you want to activate the selected candidate?');
                if(message){
                    showProgress();
                    if(document.getElementById('activateButton')!=null) {
                        document.getElementById('activateButton').disabled = true;
                    }
                    document.forms[0].action = "${activeCand}";
                    document.forms[0].submit();
                }
            }
        }
        function saveScaleDetails(evt){
            var scaleVO = getScaleObject();
            AddCandidateTemp.validateScaleAttributes(scaleVO, getDWRCallbackMethod(saveScaleDetailsCallback));
        }

        function saveScaleDetailsCallback(data) {
            if (data == 'SUCCESS') {
                saveDetails();
            } else {
                alert(data);
            }
            return false;
        }

        <c:url value="/protected/cps/add/rejectCandComments?${_csrf.parameterName}=${_csrf.token}" var="toReject"></c:url>
        <c:url value="/protected/cps/add/rejectMRTCandidate?${_csrf.parameterName}=${_csrf.token}" var="rejectMRT"></c:url>

        function reject(evt){
            var message = confirm('Are you sure you want to reject the selected candidate?');
            if(message){
                <c:choose>
                <c:when test="${addNewCandidate.tabIndex == 120}">
                document.forms[0].action = '${rejectMRT}';
                document.forms[0].submit();
                </c:when>
                <c:otherwise>
                f1('${toReject}'+'&t='+new Date().getTime(),'Reject Comments','200px','62%','130px','200px');
                </c:otherwise>
                </c:choose>
            }
        }

        <c:url value="/protected/cps/add/modifyCand?${_csrf.parameterName}=${_csrf.token}" var="modiForm"></c:url>
        function modifyForm(evt){
            //fix QC-1326
            //prevent user (except Vendor) can modify candidate
            //workStatusCode=103 as Vendor Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='103'} && ${!addNewCandidate.vendor}) {
                alert("This is a vendor candidate, you may not modify");
                return false;
            }
            //workStatusCode=109 as Activation Failed Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='109'} && ${addNewCandidate.vendor}) {
                alert("This is a activation failed candidate, you may not modify");
                return false;
            }
            //workStatusCode=107 as working Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='107'} && ${addNewCandidate.vendor}) {
                alert("This is a working candidate, you may not modify");
                return false;
            }
            showProgress();
            var psProdId = '${addNewCandidate.productVO.psProdId}';
            AddCandidateTemp.checkPluReuse(psProdId,getDWRCallbackMethod(modifyFormCallBack));
        }

        function modifyFormCallBack(data){
            if(data!='' && data == true){
                alert('PLU(s) tied to a vendor candidate/working candidate/ an existing product. \nThis candidate cannot be modified.');
                hideTheProgress();
            } else {
                document.forms[0].action = '${modiForm}';
                document.forms[0].submit();
            }
        }

        <c:url value="/protected/cps/add/authAndDist?modifyFromView=Y&${_csrf.parameterName}=${_csrf.token}" var="modiAuthForm"></c:url>
        function modifyAuthForm(evt){
            //fix QC-1326
            //prevent user (except Vendor) can modify candidate
            //workStatusCode=103 as Vendor Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='103'} && ${!addNewCandidate.vendor}) {
                alert("This is a vendor candidate, you may not modify");
                return false;
            }
            //workStatusCode=109 as Activation Failed Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='109'} && ${addNewCandidate.vendor}) {
                alert("This is a activation failed candidate, you may not modify");
                return false;
            }
            //workStatusCode=107 as working Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='107'} && ${addNewCandidate.vendor}) {
                alert("This is a working candidate, you may not modify");
                return false;
            }
            //Sprint - 23
            if(${addNewCandidate.productVO.activeProductKit}==true) {
                alert('A kit product may not be modified.');
                return false;
            }
            showProgress();
            var callbacks = {
                success : function(o) {
                    try {
                        if (o != null && myTrim(o.responseText) != "") {
                            alert(myTrim(o.responseText));
                            hideProgress();
                        }else{
                            showProgress();
                            var psProdId = '${addNewCandidate.productVO.psProdId}';
                            AddCandidateTemp.checkPluReuse(psProdId,getDWRCallbackMethod(modifyAuthFormCallBack));
                        }
                    } catch (e) {
                        return;

                    }
                },
                failure : function() {
                    hideProgress();
                },
                timeout : 5000
            };
            YAHOO.util.Connect
                .asyncRequest(
                    'GET',
                    "checkDSVItemModifyFromView",
                    callbacks);
        }

        function modifyAuthFormCallBack(data){
            if(data!='' && data == true){
                alert('PLU(s) tied to a vendor candidate/working candidate/ an existing product. \nThis candidate cannot be modified.');
                hideTheProgress();
            } else {
                document.authAndDistForm.action = '${modiAuthForm}';
                document.authAndDistForm.submit();
            }
        }

        <c:url value="/protected/cps/add/pow?${_csrf.parameterName}=${_csrf.token}&modifyFromView=Y" var="modiAdditionalForm"></c:url>
        function modifyAdditionalForm(evt){
            //fix QC-1326
            //prevent user (except Vendor) can modify candidate
            //workStatusCode=103 as Vendor Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='103'} && ${!addNewCandidate.vendor}) {
                alert("This is a vendor candidate, you may not modify");
                return false;
            }
            //workStatusCode=109 as Activation Failed Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='109'} && ${addNewCandidate.vendor}) {
                alert("This is a activation failed candidate, you may not modify");
                return false;
            }
            //workStatusCode=107 as working Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='107'} && ${addNewCandidate.vendor}) {
                alert("This is a working candidate, you may not modify");
                return false;
            }
            //Sprint - 23
            if(${addNewCandidate.productVO.activeProductKit}==true) {
                alert('A kit product may not be modified.');
                return false;
            }
            showProgress();
            var callbacks = {
                success : function(o) {
                    try {
                        if (o != null && myTrim(o.responseText) != "") {
                            alert(myTrim(o.responseText));
                            hideProgress();
                        }else{
                            showProgress();
                            var psProdId = '${addNewCandidate.productVO.psProdId}';
                            AddCandidateTemp.checkPluReuse(psProdId,getDWRCallbackMethod(modifyAdditionalFormCallBack));
                        }
                    } catch (e) {
                        return;

                    }
                },
                failure : function() {
                    hideProgress();
                },
                timeout : 5000
            };
            YAHOO.util.Connect
                .asyncRequest(
                    'GET',
                    "checkDSVItemModifyFromView",
                    callbacks);
        }

        function modifyAdditionalFormCallBack(data){
            if(data!='' && data == true){
                alert('PLU(s) tied to a vendor candidate/working candidate/ an existing product. \nThis candidate cannot be modified.');
                hideTheProgress();
            } else {
                document.powStatusForm.action = '${modiAdditionalForm}';
                document.powStatusForm.submit();
            }
        }

        <c:url value="/protected/cps/add/imageAttribute?modifyFromView=Y&${_csrf.parameterName}=${_csrf.token}" var="modifyImageAttributeForm"></c:url>
        function modifyImageAttributeForm(evt){
            //fix QC-1326
            //prevent user (except Vendor) can modify candidate
            //workStatusCode=103 as Vendor Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='103'} && ${!addNewCandidate.vendor}) {
                alert("This is a vendor candidate, you may not modify");
                return false;
            }
            //workStatusCode=109 as Activation Failed Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='109'} && ${addNewCandidate.vendor}) {
                alert("This is a activation failed candidate, you may not modify");
                return false;
            }
            //workStatusCode=107 as working Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='107'} && ${addNewCandidate.vendor}) {
                alert("This is a working candidate, you may not modify");
                return false;
            }
            //Sprint - 23
            if(${addNewCandidate.productVO.activeProductKit}==true) {
                alert('A kit product may not be modified.');
                return false;
            }
            showProgress();
            var callbacks = {
                success : function(o) {
                    try {
                        if (o != null && myTrim(o.responseText) != "") {
                            alert(myTrim(o.responseText));
                            hideProgress();
                        }else{
                            showProgress();
                            var psProdId = '${addNewCandidate.productVO.psProdId}';
                            AddCandidateTemp.checkPluReuse(psProdId,getDWRCallbackMethod(modifyImageAttributeFormCallBack));
                        }
                    } catch (e) {
                        return;

                    }
                },
                failure : function() {
                    hideProgress();
                },
                timeout : 5000
            };
            YAHOO.util.Connect
                .asyncRequest(
                    'GET',
                    "checkDSVItemModifyFromView",
                    callbacks);
        }

        function modifyImageAttributeFormCallBack(data){
            if(data!='' && data == true){
                alert('PLU(s) tied to a vendor candidate/working candidate/ an existing product. \nThis candidate cannot be modified.');
                hideTheProgress();
            } else {
                document.imageAndAttrForm.action = '${modifyImageAttributeForm}';
                document.imageAndAttrForm.submit();
            }
        }

        <c:url value="/protected/cps/add/modifyCand?mrtCheck=true&${_csrf.parameterName}=${_csrf.token}" var="modiMRTForm"></c:url>
        function modifyMRTForm(evt){
            //fix QC-1326
            //prevent user (except Vendor) can modify candidate
            //workStatusCode=103 as Vendor Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='103'} && ${!addNewCandidate.vendor}) {
                alert("This is a vendor candidate, you may not modify");
                return false;
            }
            //workStatusCode=109 as Activation Failed Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='109'} && ${addNewCandidate.vendor}) {
                alert("This is a activation failed candidate, you may not modify");
                return false;
            }
            //workStatusCode=107 as working Candidate
            if(${addNewCandidate.productVO.workRequest.workStatusCode=='107'} && ${addNewCandidate.vendor}) {
                alert("This is a working candidate, you may not modify");
                return false;
            }
            document.mrtForm.action = '${modiMRTForm}';
            document.mrtForm.submit();
        }

        <c:url value="/protected/cps/add/modifyProduct?${_csrf.parameterName}=${_csrf.token}" var="modiProdForm"></c:url>
        function modifyProdForm(evt){
            //Sprint - 23
            if(${addNewCandidate.productVO.activeProductKit}==true) {
                alert('A kit product may not be modified.');
                return;
            }
            showProgress();
            var callbacks = {
                success : function(o) {
                    try {
                        if (o != null && myTrim(o.responseText) != "") {
                            alert(myTrim(o.responseText));
                            hideProgress();
                        }else{
                            document.forms[0].action = '${modiProdForm}';
                            document.forms[0].submit();
                        }
                    } catch (e) {
                        return;

                    }
                },
                failure : function() {
                    hideProgress();
                },
                timeout : 5000
            };
            YAHOO.util.Connect
                .asyncRequest(
                    'GET',
                    "checkDSVItemModifyFromView",
                    callbacks);
        }

        function viewNext(evt) {
            document.forms[0].action = "${viewNext}";
            document.forms[0].submit();
        }

        <c:url value="searchCandidate.do?action=keepValueSearch" var="searchCPS"></c:url>
        <c:url value="searchProduct.do?action=keepValueSearch" var="searchCPSProduct"></c:url>
        <c:url value="/protected/cps/add/backToSearch?${_csrf.parameterName}=${_csrf.token}" var="backToSearch"></c:url>
        function backToSearch(evt) {
            showProgress();
            document.forms[0].action = "${backToSearch}";
            document.forms[0].submit();
        }

        function closeConfirm(){
            var message = confirm('Are you sure you want to quit Test Scan?');
            if(message)
                return true;
            else
                return false;
        }

        <c:url value="/protected/cps/add/rejectQuestionnaire?${_csrf.parameterName}=${_csrf.token}" var="rejectQues"></c:url>
        function rejectQuestionaire(){
            document.forms[0].action = '${rejectQues}';
            document.forms[0].submit();
        }

        function testScan(evt){
            if(document.getElementById("brandACInput")){
                if(document.getElementById("brandACInput").value=='' || document.getElementById("brandACInput").value=='UNASSIGNED'){
                    alert('Candidate cannot be submitted/activated with the Brand \"Unassigned\"');
                    YAHOO.util.Dom.get("brandName").value = '';
                    enableButtonWhenValidate(false);
                }
            }
            //if upc is entered add it before test scan
            if(saveUPCHook == true){
                upcAdded = false;
                goToNextTabHook = testScanPopup;
                addUpc();
            } else{
                generateTestScanPopup();
            }
        }

        function testScanPopup(evt){
            if(upcAdded == true){
                upcAdded = false;
                generateTestScanPopup();
            }
        }

        function enableCheckboxForSave() {
            for(i=0; true; i++) {
                if( document.forms[0] && document.forms[0].elements[i]) {
                    if (document.forms[0].elements[i].type == "checkbox") {
                        var chkbxId = document.forms[0].elements[i].id;
                        if (chkbxId != '') {
                            document.getElementById(chkbxId).disabled = false;
                        }
                    }
                } else {
                    break;
                }
            }
        }

        <c:if test="${addNewCandidate.tabIndex == 80}">
        YAHOO.util.Dom.get("prodAndUpcTabButImg").src =  '${clck}';
        YAHOO.util.Dom.get("prodAndUpcTabBut").onmouseover = '';
        YAHOO.util.Dom.get("prodAndUpcTabBut").onmouseout = '';
        </c:if>

        <c:if test="${addNewCandidate.tabIndex == 90}">
        YAHOO.util.Dom.get("authAndDistTabBut").src = '${authSelImg}';
        YAHOO.util.Dom.get("authAndDistTabButLayer").onmouseover = function (){};
        YAHOO.util.Dom.get("authAndDistTabButLayer").onmouseout = function (){};
        reloadAuthAndDist();
        </c:if>

        <c:if test="${addNewCandidate.tabIndex == 110}">
        YAHOO.util.Dom.get("powImg").src = '${clck}';
        YAHOO.util.Dom.get("pow").onmouseover = function (){};
        YAHOO.util.Dom.get("pow").onmouseout = function (){};
        reloadAuthAndDist();
        </c:if>

        <c:if test="${addNewCandidate.tabIndex == 120}">
        try{
            YAHOO.util.Dom.get("mrtImg").src = '${clck}';
        }catch(e){}
        YAHOO.util.Dom.get("mrtTabId").onmouseover = function (){};
        YAHOO.util.Dom.get("mrtTabId").onmouseout = function (){};
        reloadAuthAndDist();
        </c:if>

        <c:if test="${addNewCandidate.tabIndex == 130}">
        var i = '${clck}';
        YAHOO.util.Dom.get("authAndDistImg").src = i;
        YAHOO.util.Dom.get("authAndDist").onmouseover = function (){};
        YAHOO.util.Dom.get("authAndDist").onmouseout = function (){};
        reloadAuthAndDist();
        </c:if>

        <c:if test="${addNewCandidate.tabIndex == 140}">
        YAHOO.util.Dom.get("imgAttrImg").src = '${clck}';
        YAHOO.util.Dom.get("imgAttr").onmouseover = function (){};
        YAHOO.util.Dom.get("imgAttr").onmouseout = function (){};
        </c:if>

        <c:url value="/protected/cps/add/deleteCand?${_csrf.parameterName}=${_csrf.token}" var="deleteCand"></c:url>
        function deleteCand(evt){
            var message = confirm('Are you sure you want to delete the selected candidate?');
            if(message){
                document.forms[0].action = '${deleteCand}';
                document.forms[0].submit();
            }
        }
    </script>

    <script type="text/javascript">

        but = new YAHOO.widget.Button("activateCandidate1");
        but = new YAHOO.widget.Button("saveCandidate1");
        but = new YAHOO.widget.Button("promoteCand");

        <c:if test="${addNewCandidate.selectedFunction == 6}">
        var but = new YAHOO.widget.Button("submitCandidate1");
        but = new YAHOO.widget.Button("testScan1");
        </c:if>
        <c:if test="${addNewCandidate.tabIndex == 130}">
        try{
            YAHOO.util.Dom.get("saveButton").disabled=true;
            YAHOO.util.Event.removeListener("saveButton", "click");
        }catch(e){}
        </c:if>
        <c:url value="productAndUpc.do" var="prodLoad" />
        <c:url value="authAndDist.do" var="authLoad" />

        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("prodAndUpcTabBut"), "click", action1);
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authAndDistTabBut"), "click", action2);
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("newauth"), "click", action4);
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("mrtTabId"), "click", action6);
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("imgAttr"), "click", action7);

        <cps:renderByResourceAccess resourceId="201">
        <jsp:attribute name="EXEC">
        <c:choose>
        <c:when test="${addNewCandidate.scaleAttrib eq 'I' && addNewCandidate.tabIndex == 80}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("pow"), "click", scaleAction3);
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authAndDist"), "click", scaleAction5);
        </c:when>
        <c:otherwise>
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("pow"), "click", action3);
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authAndDist"), "click", action5);
        </c:otherwise>
        </c:choose>
        </jsp:attribute>
        <jsp:attribute name="NONE">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("pow"), "click", action3);
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("authAndDist"), "click", action5);
        </jsp:attribute>
        </cps:renderByResourceAccess>

        var mouseOver;
        var mouseOut;
        var selected;

        var hook = function(){alert('hook not set, something terrible!!');};

        <c:url value="/protected/cps/add/prodAndUpc?${_csrf.parameterName}=${_csrf.token}" var="prod"></c:url>
        <c:url value="/protected/cps/add/authDist?${_csrf.parameterName}=${_csrf.token}" var="auth"></c:url>
        <c:url value="/protected/cps/add/pow?${_csrf.parameterName}=${_csrf.token}" var="pow"></c:url>
        <c:url value="/protected/cps/add/amy?${_csrf.parameterName}=${_csrf.token}" var="amy"></c:url>
        <c:url value="/protected/cps/add/authAndDist?${_csrf.parameterName}=${_csrf.token}" var="authAndDist"></c:url>
        <c:url value="/protected/cps/add/showMRT?${_csrf.parameterName}=${_csrf.token}" var="showMRT"></c:url>
        <c:url value="/protected/cps/add/imageAttribute?${_csrf.parameterName}=${_csrf.token}" var="showImgAttr"></c:url>

        function action1(evt){
            if(document.getElementById("brandACInput")){
                if(document.getElementById("brandACInput").value=='' || document.getElementById("brandACInput").value=='UNASSIGNED'){
                    alert('Candidate cannot be submitted/activated with the Brand \"Unassigned\"');
                    YAHOO.util.Dom.get("brandName").value = '';
                    enableButtonWhenValidate(false);
                }
            }
            showProgress();
            document.forms[0].action = '${prod}';
            document.forms[0].submit();
        }

        //navigate to Autho and Distribute tabs
        function action2(evt){
            if(document.getElementById("brandACInput")){
                if(document.getElementById("brandACInput").value=='' || document.getElementById("brandACInput").value=='UNASSIGNED'){
                    alert('Candidate cannot be submitted/activated with the Brand \"Unassigned\"');
                    YAHOO.util.Dom.get("brandName").value = '';
                    enableButtonWhenValidate(false);
                }
            }
            document.forms[0].action = '${auth}';
            document.forms[0].submit();
        }

        function action3(evt){
            if(saveUPCHook == true){
                goToNextTabHook = goToAdditional;
                addUpc();
            }else{
                goToAdditional(evt);
            }
        }

        function goToAdditional(evt){
            var param='';
            if(document.getElementById('isModify')!=null) {
                //check modify mode, visible buttons in Additional Information
                if(document.getElementById('isModify').value=='true')
                    param='&modifyFromView=Y';
            }
            var commodity=YAHOO.util.Dom.get("commodityACInput");
            var subCommodity=YAHOO.util.Dom.get("subCommodityACInput");
            var classCommodity=YAHOO.util.Dom.get("classDisplay");
            var brick=YAHOO.util.Dom.get("brickACInput");
            var proddesc = YAHOO.util.Dom.get("proddescHidden");
            if(commodity && subCommodity && classCommodity) {
                if(commodity.value == "" || subCommodity.value == "" || classCommodity.value == "") {
                    alert('Please enter Commodity, Sub Commodity and Class before saving.');
                    if(document.getElementById("nextButton")){
                        document.getElementById("nextButton").disabled = false;
                    }
                    if(document.getElementById("scaleNextButton")){
                        document.getElementById("scaleNextButton").disabled = false;
                    }
                    if(document.getElementById("saveButton")){
                        document.getElementById("saveButton").disabled = false;
                    }
                    return false;
                }
                var btnNewSelling=YAHOO.util.Dom.get("btnNewSelling");
                if(btnNewSelling){
                    var msgSellingResReturn = validateBeforeSave();
                    if(msgSellingResReturn!=""){
                        alert(msgSellingResReturn);
                        enableButtonWhenValidate(false);
                        return false;
                    }
                }
            }
            if(proddesc && (proddesc.innerText == null || proddesc.innerText == "")){
                alert('Please enter Product Description before saving.');
                enableButtonWhenValidate(false);
                return false;
            }
            clearKitComponent();
            document.forms[0].action = '${pow}'+param;
            if(!YAHOO.util.Dom.hasClass('brickAutoComplete', 'hide')){
                AddCandidateTemp.checkUpc(afterCheckUpcAction3);
            }else{
                showProgress();
                document.forms[0].submit();
                //khoapkl
                if(${addNewCandidate.viewAddInforPage==true}) {
                    document.getElementById("1").disabled=true;
                    document.getElementById("authAndDist1").disabled=true;
                }
            }
        }

        function afterCheckUpcAction3(data){
            var msgData = data.messages;
            if(! msgData.exception){
                showProgress();
                document.forms[0].submit();
                if(${addNewCandidate.viewAddInforPage==true}) {
                    document.getElementById("1").disabled=true;
                    document.getElementById("authAndDist1").disabled=true;
                }
            }else{
                alert(msgData)
            }
        }

        function checkBrick(newDataSw){
            return true;
        }

        function action4(evt){
            document.forms[0].action = '${amy}';
            document.forms[0].submit();
        }

        function action5(evt){
            if(saveUPCHook == true){
                goToNextTabHook = goToAuthDist;
                addUpc();
            }else{
                if(document.getElementById("brandACInput")){
                    if(document.getElementById("brandACInput").value=='' || document.getElementById("brandACInput").value=='UNASSIGNED'){
                        alert('Candidate cannot be submitted/activated with the Brand \"Unassigned\"');
                        YAHOO.util.Dom.get("brandName").value = '';
                        enableButtonWhenValidate(false);
                    }
                }
                var commodity=YAHOO.util.Dom.get("commodityACInput");
                var subCommodity=YAHOO.util.Dom.get("subCommodityACInput");
                var classCommodity=YAHOO.util.Dom.get("classDisplay");
                var brick=YAHOO.util.Dom.get("brickACInput");
                var proddesc = YAHOO.util.Dom.get("proddescHidden");
                if(commodity && subCommodity && classCommodity) {
                    if(commodity.value == "" || subCommodity.value == "" || classCommodity.value == "") {
                        alert('Please enter Commodity, Sub Commodity and Class before saving.');
                        enableButtonWhenValidate(false);
                        return false;
                    }
                    var btnNewSelling=YAHOO.util.Dom.get("btnNewSelling");
                    if(btnNewSelling){
                        var msgSellingResReturn = validateBeforeSave();
                        if(msgSellingResReturn!=""){
                            alert(msgSellingResReturn);
                            enableButtonWhenValidate(false);
                            return false;
                        }
                    }
                }
                if(proddesc && (proddesc.innerText == null || proddesc.innerText == "")){
                    alert('Please enter Product Description before saving.');
                    enableButtonWhenValidate(false);
                    return false;
                }
                clearKitComponent();
                document.forms[0].action = '${authAndDist}';
                if(!YAHOO.util.Dom.hasClass('brickAutoComplete', 'hide')){
                    var btnNewSelling=YAHOO.util.Dom.get("btnNewSelling");
                    if(btnNewSelling){
                        var msgSellingResReturn = validateBeforeSave();
                        if(msgSellingResReturn!=""){
                            alert(msgSellingResReturn);
                            enableButtonWhenValidate(false);
                            return false;
                        }
                    }
                    AddCandidateTemp.checkUpc(afterCheckUpcAuthAndDist);
                }else{
                    showProgress();
                    document.forms[0].submit();
                }
            }
        }

        function scaleAction3(evt){
            var scaleVO = getScaleObject();
            AddCandidateTemp.validateScaleAttributes(scaleVO, getDWRCallbackMethod(scaleAction3Callback));
        }

        function scaleAction3Callback(data) {
            if (data == 'SUCCESS') {
                action3();
            } else {
                alert(data);
            }
            return false;
        }

        function scaleAction5(evt){
            var scaleVO = getScaleObject();
            AddCandidateTemp.validateScaleAttributes(scaleVO, getDWRCallbackMethod(scaleAction5Callback));
        }

        function scaleAction5Callback(data) {
            if (data == 'SUCCESS') {
                action5();
            } else {
                alert(data);
            }
            return false;
        }

        function goToAuthDist(evt){
            if(document.getElementById("brandACInput")){
                if(document.getElementById("brandACInput").value=='' || document.getElementById("brandACInput").value=='UNASSIGNED'){
                    alert('Candidate cannot be submitted/activated with the Brand \"Unassigned\"');
                    YAHOO.util.Dom.get("brandName").value = '';
                    enableButtonWhenValidate(false);
                }
            }
            var commodity=YAHOO.util.Dom.get("commodityACInput");
            var subCommodity=YAHOO.util.Dom.get("subCommodityACInput");
            var classCommodity=YAHOO.util.Dom.get("classDisplay");
            var brick=YAHOO.util.Dom.get("brickACInput");
            var proddesc = YAHOO.util.Dom.get("proddescHidden");
            if(commodity && subCommodity && classCommodity) {
                if(commodity.value == "" || subCommodity.value == "" || classCommodity.value == "") {
                    alert('Please enter Commodity, Sub Commodity and Class before saving.');
                    enableButtonWhenValidate(false);
                    return false;
                }
                var btnNewSelling=YAHOO.util.Dom.get("btnNewSelling");
                if(btnNewSelling){
                    var msgSellingResReturn = validateBeforeSave();
                    if(msgSellingResReturn!=""){
                        alert(msgSellingResReturn);
                        enableButtonWhenValidate(false);
                        return false;
                    }
                }
            }
            if(proddesc && (proddesc.innerText == null || proddesc.innerText == "")){
                alert('Please enter Product Description before saving.');
                enableButtonWhenValidate(false);
                return false;
            }
            document.forms[0].action = '${authAndDist}';
            if(!YAHOO.util.Dom.hasClass('brickAutoComplete', 'hide')){
                AddCandidateTemp.checkUpc(afterCheckUpcAuthAndDist);
            }else{
                showProgress();
                document.forms[0].submit();
            }
        }

        function afterCheckUpcAuthAndDist(data){
            var msgData = data.messages;
            if(! msgData.exception){
                if(data.appData.valid){
                    if(checkBrick(data.appData.newDataSw)){
                        showProgress();
                        document.forms[0].submit();
                    }
                }else{
                    showProgress();
                    document.forms[0].submit();
                }
            }else{
                alert(msgData)
            }
        }

        function isValidDom(el){
            if(null != el && el != undefined){
                return true;
            }
            return false;
        }

        // navigate to MRT tabs
        function action6(evt){
            showProgress();
            document.forms[0].action = '${showMRT}';
            document.forms[0].submit();
        }

        // navigate to Image tabs
        function action7(evt){
            if(saveUPCHook == true){
                goToNextTabHook = goToImgAtr;
                addUpc();
            }else{
                if(document.getElementById("brandACInput")){
                    if(document.getElementById("brandACInput").value=='' || document.getElementById("brandACInput").value=='UNASSIGNED'){
                        alert('Candidate cannot be submitted/activated with the Brand \"Unassigned\"');
                        YAHOO.util.Dom.get("brandName").value = '';
                        enableButtonWhenValidate(false);
                    }
                }
                var commodity=YAHOO.util.Dom.get("commodityACInput");
                var subCommodity=YAHOO.util.Dom.get("subCommodityACInput");
                var classCommodity=YAHOO.util.Dom.get("classDisplay");
                var brick=YAHOO.util.Dom.get("brickACInput");
                var proddesc = YAHOO.util.Dom.get("proddescHidden");

                var merchandise = YAHOO.util.Dom.get("merchTypes");
                if(null != merchandise && merchandise != undefined){
                    if(merchandise.value == "" || merchandise.value == "--Select--"){
                        alert('Please enter Merchandise before saving.');
                        hideProgress();
                        enableButtonWhenValidate(false);
                        return false;
                    }
                }

                if(commodity && subCommodity && classCommodity) {
                    if(commodity.value == "" || subCommodity.value == "" || classCommodity.value == "") {
                        alert('Please enter Commodity, Sub Commodity and Class before saving.');
                        enableButtonWhenValidate(false);
                        return false;
                    }
                    var btnNewSelling=YAHOO.util.Dom.get("btnNewSelling");
                    if(btnNewSelling){
                        var msgSellingResReturn = validateBeforeSave();
                        if(msgSellingResReturn!=""){
                            alert(msgSellingResReturn);
                            enableButtonWhenValidate(false);
                            return false;
                        }
                    }
                }
                if(proddesc && (proddesc.innerText == null || proddesc.innerText == "")){
                    alert('Please enter Product Description before saving.');
                    enableButtonWhenValidate(false);
                    return false;
                }

                AddCandidateTemp.checkUpc(afterAction7);
            }
        }

        function afterAction7(data){
            var btnNewSelling=YAHOO.util.Dom.get("btnNewSelling");
            if(btnNewSelling){
                var msgSellingResReturn = validateBeforeSave();
                if(msgSellingResReturn!=""){
                    alert(msgSellingResReturn);
                    enableButtonWhenValidate(false);
                    return false;
                }
            }
            var msgData = data.messages;
            if(! msgData.exception){
                if(data.appData.valid){
                    if(data.appData.message && data.appData.message != ""){
                        alert(data.appData.message);
                    }else{
                        if(checkBrick(data.appData.newDataSw)){
                            showProgress();
                            clearKitComponent();
                            //document.forms[0].action = '${showImgAttr}';
                            //document.forms[0].submit();
                        }
                    }
                }else{
                    alert("Please enter a UPC in Selling Unit UPC section");
                }
            }else{
                alert(msgData);
            }
        }

        function goToImgAtr(evt){
            if(document.getElementById("brandACInput")){
                if(document.getElementById("brandACInput").value=='' || document.getElementById("brandACInput").value=='UNASSIGNED'){
                    alert('Candidate cannot be submitted/activated with the Brand \"Unassigned\"');
                    YAHOO.util.Dom.get("brandName").value = '';
                    enableButtonWhenValidate(false);
                }
            }
            var commodity=YAHOO.util.Dom.get("commodityACInput");
            var subCommodity=YAHOO.util.Dom.get("subCommodityACInput");
            var classCommodity=YAHOO.util.Dom.get("classDisplay");
            var brick=YAHOO.util.Dom.get("brickACInput");
            var proddesc = YAHOO.util.Dom.get("proddescHidden");
            if(commodity && subCommodity && classCommodity) {
                if(commodity.value == "" || subCommodity.value == "" || classCommodity.value == "") {
                    alert('Please enter Commodity, Sub Commodity and Class before saving.');
                    enableButtonWhenValidate(false);
                    return false;
                }
                var btnNewSelling=YAHOO.util.Dom.get("btnNewSelling");
                if(btnNewSelling){
                    var msgSellingResReturn = validateBeforeSave();
                    if(msgSellingResReturn!=""){
                        alert(msgSellingResReturn);
                        enableButtonWhenValidate(false);
                        return false;
                    }
                }
            }
            if(proddesc && (proddesc.innerText == null || proddesc.innerText == "")){
                alert('Please enter Product Description before saving.');
                enableButtonWhenValidate(false);
                return false;
            }
            clearKitComponent();
            //document.forms[0].action = '${showImgAttr}';
            if(!YAHOO.util.Dom.hasClass('brickAutoComplete', 'hide')){
                AddCandidateTemp.checkUpc(afterAction7);
            }else{
                //showProgress();
                //document.forms[0].submit();
            }
        }

        //handles all tab functions wiht normal buttons.
        function prodAndUpc(evt){
            if(selected == 'auth'){
                selectPage(1);
                YAHOO.util.Dom.get("authAndDistTabBut").src = '${authNormalImg}';
                YAHOO.util.Dom.get("prodAndUpcTabBut").src = '${prodSelImg}';

                YAHOO.util.Dom.get("authAndDistTabButLayer").onmouseover = function (){ changeImage(document.getElementById('authAndDistTabBut'),'${authOverImg}') };
                YAHOO.util.Dom.get("prodAndUpcTabButLayer").onmouseover = '';

                YAHOO.util.Dom.get("authAndDistTabButLayer").onmouseout = function (){ changeImage(document.getElementById('authAndDistTabBut'),'${authNormalImg}') };
                YAHOO.util.Dom.get("prodAndUpcTabButLayer").onmouseout = '';
                selected = 'prod';

                saveDiv.style.visibility = 'visible';
                nextDiv.style.visibility = 'visible';
                backDiv.style.visibility = 'hidden';
                hook = reloadProdAndUpc;
                window.setTimeout('selectPage(2)',500,'Javascript');
            }
        }

        function authAndDist(evt){
            if(selected == 'prod'){
                selectPage(1);
                YAHOO.util.Dom.get("prodAndUpcTabBut").src = '${prodNormalImg}';
                YAHOO.util.Dom.get("authAndDistTabBut").src = '${authSelImg}';

                YAHOO.util.Dom.get("prodAndUpcTabButLayer").onmouseover = function (){ changeImage(document.getElementById('prodAndUpcTabBut'),'${prodOverImg}') };
                YAHOO.util.Dom.get("authAndDistTabButLayer").onmouseover = function (){};

                YAHOO.util.Dom.get("prodAndUpcTabButLayer").onmouseout = function (){ changeImage(document.getElementById('prodAndUpcTabBut'),'${prodNormalImg}') };
                YAHOO.util.Dom.get("authAndDistTabButLayer").onmouseout = function (){};

                saveDiv.style.visibility = 'visible';
                backDiv.style.visibility = 'visible';
                nextDiv.style.visibility = 'hidden';

                selected = 'auth';
                hook = reloadAuthAndDist;
                window.setTimeout('selectPage(3)',500,'Javascript');
            }
        }

        function selectPage(num){
            var tab1;
            var tab2;
            var tab3;
            if(num == 1){
                hook = function(){};
                tab1 = 'tabview1';tab2 = 'tabview2';tab3 = 'tabview3';
            }else if (num == 2){
                tab1 = 'tabview2';tab2 = 'tabview3';tab3 = 'tabview1';
            }else if (num == 3){
                tab1 = 'tabview3';tab2 = 'tabview1';tab3 = 'tabview2';
            }
            document.getElementById(tab2).style.visibility = 'hidden';
            document.getElementById(tab2).style.position = 'absolute';
            document.getElementById(tab2).style.display = 'none';

            document.getElementById(tab3).style.visibility = 'hidden';
            document.getElementById(tab3).style.position = 'absolute';
            document.getElementById(tab3).style.display = 'none';

            document.getElementById(tab1).style.visibility = 'visible';
            document.getElementById(tab1).style.position = 'relative';
            document.getElementById(tab1).style.display = 'block';

            YAHOO.util.Event.onDOMReady(hook);
        }

        function getPage(url){
            var formObject = document.getElementById('tempForm');
            formObject.action = url;
            YAHOO.util.Connect.setForm(formObject);

            var callback = {
                success:function(o){
                    hideProgress();
                    document.getElementById('tabview2').innerHTML = o.responseText;
                    document.getElementById('candOtherInfoBody').style.overflow = 'auto';
                }
            };
            setWaitPageToDiv();
            showProgress();
            var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
        }


        <c:if test="${addNewCandidate.tabIndex == 80}">
        selected = 'auth';
        </c:if>
        <c:if test="${addNewCandidate.tabIndex == 90}">
        selected = 'prod';
        </c:if>

        function setVendorTi(shouldEnable){
            if(shouldEnable){
                if(document.getElementById('venTie')){
                    document.getElementById('venTie').style.display='block';
                }
                if(document.getElementById('venTieText')){
                    document.getElementById('venTieText').style.display='block';
                }
                if(document.getElementById('venTier')){
                    document.getElementById('venTier').style.display='block';
                }
                if(document.getElementById('venTierText')){
                    document.getElementById('venTierText').style.display='block';
                }
            }else{
                if(document.getElementById('venTie')){
                    document.getElementById('venTie').style.display='none';
                }
                if(document.getElementById('venTieText')){
                    document.getElementById('venTieText').style.display='none';
                }
                if(document.getElementById('venTier')){
                    document.getElementById('venTier').style.display='none';
                }
                if(document.getElementById('venTierText')){
                    document.getElementById('venTierText').style.display='none';
                }
            }
        }

        <c:choose>
        <c:when test="${addNewCandidate.userRole eq 'UVEND'}">
        <c:set value="true" var="isVendorLogin"></c:set>
        </c:when>
        <c:when test="${addNewCandidate.userRole eq 'RVEND'}">
        <c:set value="true" var="isVendorLogin"></c:set>
        </c:when>
        <c:otherwise>
        <c:set value="false" var="isVendorLogin"></c:set>
        </c:otherwise>
        </c:choose>

        function onChannelChange(sel){
            var selected = sel.options[sel.selectedIndex].value;
            var isVendor = '${isVendorLogin}';
            if(selected == "WHS"){
                setCaseUPC();
            }else{
                if(document.getElementById("caseUpcText")
                    && document.getElementById("caseCheckDigit")){
                    document.getElementById("caseUpcText").value = "";
                    document.getElementById("caseCheckDigit").value = "";
                }
            }
            if(isVendor == 'true'){
                if(selected == "DSD"){
                    setVendorTi(false);
                }else{
                    setVendorTi(true);
                }
            }
            if(document.getElementById("vendorACInput") != null){
                document.getElementById("vendorACInput").value = "";
                if(YAHOO.util.Dom.get('vendorLocationVal')){
                    YAHOO.util.Dom.get('vendorLocationVal').value = "";
                }
            }
        }

        function setCaseUPC(){
            AddCandidateTemp.getPLU(getDWRCallbackMethod(setTheCaseUPC));
        }

        function setTheCaseUPC(data){
            if(data != null){
                if(document.getElementById("caseUpcText")
                    && document.getElementById("caseCheckDigit")){
                    document.getElementById("caseUpcText").value = data.unitUpc;
                    document.getElementById("caseCheckDigit").value = data.checkDigit;
                }
            }
        }
        function fieldHeight(){
            var h = window.screen.height;
            var height = 0.6 * h;
            document.getElementById("prodAuthField").style.height = height + 'px';
        }

        fieldHeight();

        function scrollDivToBottom(){
            var myDiv = document.getElementById("prodAuthField");
            myDiv.scrollTop = myDiv.scrollHeight;
        }

        onload();

        function onload(){
            if((${addNewCandidate.questionnarieVO.selectedOption == 4})&&(${addNewCandidate.tabIndex == 120})){
                document.getElementById("1").disabled=true;
                document.getElementById("authAndDist1").disabled=true;
                //khoapkl
                if(${addNewCandidate.viewAddInforPage}){
                    document.getElementById("contpow").disabled=false;
                } else {
                    document.getElementById("contpow").disabled=true;
                }
            } else {
                if(${addNewCandidate.viewAddInforPage} && !${addNewCandidate.enableTabs}){
                    document.getElementById("1").disabled=true;
                    document.getElementById("authAndDist1").disabled=true;
                    if(document.getElementById('mrt')!=null) {
                        document.getElementById('mrt').style.display='';
                    }
                } else {
                    if(document.getElementById('mrt')!=null && !${addNewCandidate.viewAddInforPage}) {
                        document.getElementById('mrt').style.display='none';
                    }
                    //disabled Production&UPC, Authorization&Distribution tabs when user clicking modify a MRT candidate
                    if(${addNewCandidate.viewAddInforPage} && ${addNewCandidate.enableTabs} &&
                    ${addNewCandidate.questionnarieVO.selectedOption==4}){
                        document.getElementById("1").disabled=true;
                        document.getElementById("authAndDist1").disabled=true;
                    }
                }
            }
            enableActivation1();
        }

        function enableActivation1(){
            AddCandidateTemp.enableActivateButton(getDWRCallbackMethod(enableActivationCB1))
        }

        function enableActivationCB1(data){
            if(document.getElementById('activateButton') && !${addNewCandidate.viewOnlyProductMRT}){
                if(${addNewCandidate.enableActiveButton})
                    document.getElementById('activateButton').disabled = false;
            } else {
                document.getElementById('activateButton').disabled=true;
                document.getElementById('printFormId').disabled=true;
            }
        }

        function reloadImageInfo(){
            AddCandidateTemp.getImageInforUpload(getDWRCallbackMethod(imageInforUpload));
        }

        function imageInforUpload(data){
            if(document.getElementById('viewImage') && data!=''){
                document.getElementById('viewImage').src = data;
                if(document.getElementById('imageExpectDt')){
                    document.getElementById('imageExpectDt').value='';
                    document.getElementById('imageExpectDt').disabled = true;
                    document.getElementById('calImage').disabled = true;
                }
            }
        }

        <c:url value="/protected/cps/add/resetProduct?${_csrf.parameterName}=${_csrf.token}" var="fromStore"></c:url>
        function fromExecute(){
            document.forms[0].action = '${fromStore}';
            document.forms[0].submit();
        }

        <c:url value="/protected/cps/add/resetTestScan?${_csrf.parameterName}=${_csrf.token}" var="resetTestScan"></c:url>
        function fromTestScan(){
            document.forms[0].action = '${resetTestScan}';
            document.forms[0].submit();
        }

        <c:url value="/protected/cps/add/resetMatrixMargin?${_csrf.parameterName}=${_csrf.token}" var="fromMM"></c:url>
        function fromMatrixMargin(){
            document.forms[0].action = '${fromMM}';
            document.forms[0].submit();
        }

        function testScanMess1(data){
            document.getElementById("testScanMessage1").innerText=data;
        }

        <c:url value="/protected/cps/add/updateCandidateMessage?${_csrf.parameterName}=${_csrf.token}" var="updateMessage"></c:url>
        function updateMessage(){
            document.forms[0].action = '${updateMessage}';
            document.forms[0].submit();
        }

        function showTestScanButton(){
            var upcType = document.getElementById('upcType1');
            var upcTypeVal = upcType.options[upcType.selectedIndex].value;
            var upc = document.getElementById('unitUpc1').value;
            var unitSize = document.getElementById('unitSize1').value;
            var size = document.getElementById('size').value;
            var prodType1 = document.getElementById('prodTypetxt');
            var prodTypetxt ="";
            if(prodType1 != null){
                prodTypetxt=prodType1.value;
            }
            var prodTypeSelect = document.getElementById('prodTypeSelect');
            var prodType = "";
            if(prodTypeSelect != null){
                prodType = prodTypeSelect.options[prodTypeSelect.selectedIndex].value;
            }
            var enable = true;
            if(prodTypetxt == "Sellable" || prodType == "GOODS"){
                enable = true;
            }else{
                enable = false;
            }
            if(upc == null || upc==""){
                enable = false;
            }
            if(unitSize == null || unitSize==""){
                enable = false;
            }
            if(size == null || size==""){
                enable = false;
            }

            if (enable) {
                if (upc >= 20000000000 && upc <= 29999999999) {
                    enableTescScanButton(false);
                    if(document.getElementById('brandix')){
                        document.getElementById('brandix').style.display = 'none';
                    }
                    if(document.getElementById('cfdix')){
                        document.getElementById('cfdix').style.display = 'none';
                    }
                    <c:if test="${addNewCandidate.userRole eq 'ADMIN' || addNewCandidate.userRole eq 'PIA' || addNewCandidate.userRole eq 'PIAL'}">
                    if(document.getElementById('engDescLine1Required')){
                        document.getElementById('engDescLine1Required').style.color = 'red';
                    }
                    if(document.getElementById('engDescLine2Required')){
                        document.getElementById('engDescLine2Required').style.color = 'red';
                    }
                    if(document.getElementById('prePackRequired')){
                        document.getElementById('prePackRequired').style.color = 'red';
                    }
                    if(document.getElementById('shelfLifeDaysRequired')){
                        document.getElementById('shelfLifeDaysRequired').style.color = 'red';
                    }
                    </c:if>
                } else if (upcTypeVal == 'UPC' || upcTypeVal == 'HEB'){
                    enableTescScanButtonNew(true);
                }
            }
        }

        function dispSubBrandMsg(data){
            document.getElementById("subBrandMessage").innerText=data;
            if(data != null){
                if(data.indexOf('successfully') != -1){
                    document.getElementById("subBrandMessage").style.color = "blue";
                }else{
                    document.getElementById("subBrandMessage").style.color = "red";
                }
            }
            initsubbrandRemote();
        }

        YAHOO.namespace("heb.container.testScan");
        <c:url value="/protected/cps/add/testScanNew?${_csrf.parameterName}=${_csrf.token}" var="testScanURL"></c:url>

        var once = false;

        function hideTheProgress(){
            hideProgress();
        }

        function generateTestScanPopup(){
            //showProgress();
            document.getElementById("panel1").style.display="inline";
            if(once == false){
                once = true;
                YAHOO.heb.container.testScan = new YAHOO.widget.Panel("panel1",
                    { 	width:"700px",
                        height:"500px",
                        underlay:"shadow",
                        visible:false,
                        constraintoviewport:true,
                        draggable:false,
                        zIndex : 55000,
                        modal:true,
                        close:false,
                        fixedCenter : true
                    } );
                YAHOO.heb.container.testScan.render(document.body);
            }

            YAHOO.heb.container.testScan.beforeHideEvent.subscribe(onBeforeHideEvent);
            YAHOO.heb.container.testScan.beforeShowEvent.subscribe(onBeforeShowEvent);
            YAHOO.heb.container.testScan.show();

            document.getElementById("popupFrame").style.height="500px";
            document.getElementById("popupFrame").style.width="700px";
            document.getElementById("popupFrame").src = "${testScanURL}";
            document.getElementById("popupHeader").innerHTML = '<font size="2" color="white">&nbsp;&nbsp;&nbsp; Available UPCs</font>';
        }

        function onShowEvent(){
            YAHOO.heb.container.testScan.showMask();
        }

        function onBeforeShowEvent(){
            YAHOO.heb.container.testScan.hideMask();

        }

        function onBeforeHideEvent(){
            document.getElementById("panel1").style.dsiplay="hidden";
            document.getElementById("popupFrame").src = "";
            document.getElementById("popupHeader").innerHTML = "";
        }

        function closePopup(){
            YAHOO.heb.container.testScan.hide();
        }

        function closeIt(){
            if(confirm("Exit Test Scan? (click OK to exit)")){
                closePopup();
            }
        }

        var printFormId = new YAHOO.widget.Button("printFormId");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("printFormId"), "click", printFormPopUp);
        <c:url value="/protected/cps/add/printForm?${_csrf.parameterName}=${_csrf.token}" var="pagePrintForm" />
        <c:url value="/protected/cps/add/printForm?${_csrf.parameterName}=${_csrf.token}" var="page50" />
        function printFormPopUp(evt){
            if(document.getElementById('errors')){
                document.getElementById('errors').innerHTML = "";
            }
            if(document.getElementById('mrtMessage')){
                document.getElementById('mrtMessage').innerText="";
            }
            <c:if test="${!addNewCandidate.hidMrtSwitch}">
            <c:if test="${addNewCandidate.productVO.psProdId ne null}">
            showProgress();
            f1('${pagePrintForm}'+'&t='+new Date().getTime()+'${printForm}'+'&SelectedPrintList='+'${addNewCandidate.selectedProductId}','Print Forms','200px','62%','130px','200px');
            </c:if>
            <c:if test="${addNewCandidate.productVO.psProdId eq null}">
            <c:if test="${addNewCandidate.productVO.prodId ne null}">
            showProgress();
            f1('${pagePrintForm}'+'&t='+new Date().getTime()+'${printForm}'+'&SelectedPrintList='+'${addNewCandidate.selectedProductId}','Print Forms','200px','62%','130px','200px');
            </c:if>
            </c:if>
            </c:if>
            <c:if test="${addNewCandidate.hidMrtSwitch}">
            AddCandidateTemp.allowPrintFormMRT(getDWRCallbackMethod(printFormMRT));
            </c:if>
        }

        function printFormMRT(isPsItmIdNull){
            if(isPsItmIdNull){
                showProgress();
                f1('${pagePrintForm}'+'&t='+new Date().getTime()+'${printForm}'+'&SelectedPrintList='+isPsItmIdNull,'Print Forms','200px','62%','130px','200px');
            }else{
                alert('Please Save MRT before Printing.');
            }
        }

        var printBut =	new YAHOO.widget.Button("printBut");
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("printBut"), "click", printSummary);
        <c:url value="/protected/cps/add/printSummary?${_csrf.parameterName}=${_csrf.token}" var="pagePrintSummary"></c:url>
        function printSummary(evt){
            <c:if test="${addNewCandidate.productVO.psProdId ne null}">
            document.forms[0].action = '${pagePrintSummary}'+'&SelectedPrintList='+'${addNewCandidate.selectedProductId}';
            document.forms[0].submit();
            </c:if>
        }
    </script>

    <jsp:include page="/footer.jsp"></jsp:include>

    <div id="pan" style="display: none;">
        <div class="hd">
            <div class="tl"></div>
            <div class="tr"></div>
        </div>
        <div class="bd">
            <iframe style="display: none;" id="popupFrame1" height="1px" width="1px"></iframe>
        </div>
        <div class="ft">
            <div class="bl"></div>
            <div class="br"></div>
        </div>
    </div>
    <div id="panel1" style="display: none;">
        <div class="hd">
            <div class="tl" ></div>
            <span id="popupHeader"></span>
            <div class="closeMe" onclick="closeIt();"></div>
            <div class="tr"></div>
        </div>
        <div class="bd">
            <iframe id="popupFrame" height="1px" width="1px"></iframe>
        </div>
        <div class="ft">
            <div class="bl"></div>
            <div class="br"></div>
        </div>
    </div>
    <div id="panelPse" style="display: none;">
        <div class="hd">
            <div class="tl"></div>
            <span id="popupHeaderPse"></span>
            <div class="closeMe" onclick="closePsePopup(true);"></div>
            <div class="tr"></div>
        </div>
        <div class="bd">
            <iframe id="popupFramePse" height="1px" width="1px"></iframe>
        </div>
        <div class="ft">
            <div class="bl"></div>
            <div class="br"></div>
        </div>
    </div>

    <div id="panelImg" style="display: none;">
        <div class="hd">
            <div class="tl" ></div>
            <span id="popupHeaderImg"></span>
            <div class="closeMe" onclick="closeImgPopup();"></div>
            <div class="tr"></div>
        </div>
        <div class="bd">
            <iframe id="popupFrameImg" height="1px" width="1px"></iframe>
        </div>
        <div class="ft">
            <div class="bl"></div>
            <div class="br"></div>
        </div>
    </div>

    <div id="panelImg1" style="display: none;">
        <div class="hd">
            <div class="tl" ></div>
            <span id="popupHeaderImg1"></span>
            <div class="closeMe" onclick="closeImgPopup1();"></div>
            <div class="tr"></div>
        </div>
        <div class="bd">
            <iframe id="popupFrameImg1" height="1px" width="1px"></iframe>
        </div>
        <div class="ft">
            <div class="bl"></div>
            <div class="br"></div>
        </div>
    </div>
</body>
</html>