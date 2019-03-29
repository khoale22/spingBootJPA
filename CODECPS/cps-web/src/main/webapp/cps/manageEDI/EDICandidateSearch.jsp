<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@page import="com.heb.operations.cps.util.CPSGlobals"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<base ref="site" />
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title><spring:eval expression="@messageResourcesProperties.getProperty('app.name')" /> - Manage Candidate</title>
<jsp:include page="/common_head.jsp" />
<jsp:include page="/autoCompleteHeader.jsp" />
<jsp:include page="/initYuiDatatable.jsp" />
<c:url value="/dwr/engine.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/util.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/ManageDWR.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/ManageEDIDWR.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<%-- <c:url value="${request.getContextPath()}/yui/connection/connection-min.js" var="styleLink"/> --%>
<script type="text/javascript" src="${styleLink}"></script>
<c:url value="${request.getContextPath()}/hebAssets/dispatcher.js" var="myJs"/>
<script type="text/javascript" src="${myJs}"></script>

<c:url value="${request.getContextPath()}/yui/" var="yuiURL"></c:url>


<c:url value="${request.getContextPath()}/yui/yuiloader/yuiloader-min.js" var="loaderURL"></c:url>
<script type="text/javascript" src="${loaderURL}"></script>

<c:url value="${request.getContextPath()}/yui/fonts/fonts-min.css" var="fontsMin"/>
<link rel="stylesheet" type="text/css" href="${fontsMin}" />
<c:url value="${request.getContextPath()}/yui/container/assets/container-core.css" var="containerCss"/>
<link rel="stylesheet" type="text/css" href="${containerCss}" />
<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />


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

	/* Skin default elements */
	#panelActive_c.yui-panel-container.shadow .underlay {
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
	#panelActive.yui-panel {
		border:none;
		overflow:visible;
		background:transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat top right;
	}

	/* Style the close icon */
	#panelActive.yui-panel .container-close {
		position:absolute;
		top:5px;
		right:8px;
		height:21px;
		width:21px;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
	}

	/* Style the header with its associated corners */
	#panelActive.yui-panel .hd {
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
	#panelActive.yui-panel .bd {
		overflow:hidden;
		padding:10px;
		border:none;
		background:#FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y;
		margin:0 4px 0 0;
	}

	/* Style the footer with the bottom corner images */
	#panelActive.yui-panel .ft {
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
		font-size:11px;
		height:26px;
		padding:0px 10px;
		border:none
	}

	/* Skin custom elements */
	#panelActive.yui-panel .hd span {
		line-height:30px;
		vertical-align:middle;
		font-weight:bold;
	}
	#panelActive.yui-panel .hd .tl {
		width:8px;
		height:29px;
		top:1px;
		left:0px;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
		position:absolute;
	}

	#panelActive.yui-panel .hd .tr {
		width:8px;
		height:29px;
		top:1px;
		right:0;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat;
		position:absolute;
	}

	#panelActive.yui-panel .ft span {
		line-height:22px;
		vertical-align:middle;
	}
	#panelActive.yui-panel .ft .bl {
		width:8px;
		height:26px;
		bottom:0;
		left:0;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
		position:absolute;
	}
	#panelActive.yui-panel .ft .br {
		width:8px;
		height:26px;
		bottom:0;
		right:0;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
		position:absolute;
	}

	.labelFont{
		font-family: Arial, Helvetica, sans-serif;
		font-size:11px;
	}
	.textFieldMedium{font-family: Arial, Helvetica, sans-serif;}
	.selectBoxStyle2{font-family: Arial, Helvetica, sans-serif;}
	.selectBoxStyle3{font-family: Arial, Helvetica, sans-serif;}
	#link1,#link2{font-size:11px;}
</style>

<script type="text/javascript">

YAHOO.namespace('HEB.manageMain');

YAHOO.namespace("heb.container");

////////////////CPS R2 - Activation message display. START
function showActivationMsg() {
	YAHOO.widget.DataTable.Formatter.keyFormatter = function(elLiner, oRecord, oColumn, oData){
		elLiner.innerHTML = '<font color="black" style="font-weight: bold; font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; text-decoration: underline;">'+ oData +'</font>';
	};

	YAHOO.widget.DataTable.Formatter.valueFormatter = function(elLiner, oRecord, oColumn, oData){
		elLiner.innerHTML = '<font color="black" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">'+ oData +'</font>';
	};

    var myColumnDefs = [
    	{key:"code", formatter:"keyFormatter"},
    	{key:"desc", formatter:"valueFormatter"}
    ];

    <c:url value="/protected/cps/manageEDI/activationMessage?${_csrf.parameterName}=${_csrf.token}" var="serverUrl" />

    // DataSource instance
    var myDataSource = new YAHOO.util.DataSource("${serverUrl}");
    myDataSource.connMethodPost = true;
    myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSON;
    myDataSource.connXhrMode = "cancelStaleRequests";
    myDataSource.responseSchema = {
        resultsList: "ResultSet.records",
        fields: [
        	{key:"code"},
        	{key:"desc"}
        ]
    };

	var myDataTable;

	<c:if test="${requestScope.SingleActivation eq 'N'}">
		var myConfigs;
		/*<c:if test="${sessionScope.isMRT eq 'Y'}">
		    myConfigs = {
		        initialRequest: "results=2",
		        paginator: new YAHOO.widget.Paginator({ rowsPerPage: 2 })
		    };
	    </c:if>
	    <c:if test="${sessionScope.isMRT eq 'N'}">
	   	 	myConfigs = {
		        initialRequest: "results=4",
		        paginator: new YAHOO.widget.Paginator({ rowsPerPage: 4 }),
				width:"40em",
				height:"18em"
		    };
	    </c:if>   */
		    myConfigs = {
			        initialRequest: "results=4",
			        paginator: new YAHOO.widget.Paginator({ rowsPerPage: 4 }),
					width:"40em",
					height:"18em"
			    }
	    myDataTable = new YAHOO.widget.ScrollingDataTable("messageTable", myColumnDefs, myDataSource, myConfigs);
	</c:if>
	<c:if test="${requestScope.SingleActivation eq 'Y'}">
	    myDataTable = new YAHOO.widget.ScrollingDataTable("messageTable", myColumnDefs, myDataSource, {width:"40em", height:"18em"});
	</c:if>
	myDataTable.hideTableMessage();
	myDataTable.appendTo(YAHOO.heb.container.activePanel.body);

    return {
       myDataSource: myDataSource,
       myDataTable: myDataTable
    };
}


function loadInitTable(){
	showActivationMsg();
}



function generatePanel(){
	//<c:if test="${(ManageEDICandidate.userRole eq 'UVEND' || ManageEDICandidate.userRole eq 'RVEND')}">
	//if((document.all)&&(navigator.appVersion.indexOf("MSIE 7.")!= -1)){
	//	} else {
	//			document.getElementById('cornfirmVendorLogin').style.display = 'block';
	//			generateCofirm();
	//	}
	//</c:if>
	document.getElementById('panelActiveFooter').style.display = 'none';
<c:if test="${requestScope.ActivationSuccess eq 'Y'}">

	//document.getElementById("panelActive").style.display = '';
	document.getElementById("panelActive").style.display="block";
	document.getElementById("panelActive").style.position="fixed";
	YAHOO.heb.container.activePanel = new YAHOO.widget.Panel("panelActive",
					{ 	width:"500px",
						height:"300px",
						visible:false,
						constraintoviewport:true,
						draggable:true,
						zIndex : 55000,
						modal:true,
						fixedCenter : true,// Keep centered if window is scrolled
						effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}
					} );

	YAHOO.heb.container.activePanel.render(document.body);
	loadInitTable();
	YAHOO.heb.container.activePanel.show();
</c:if>
}
YAHOO.util.Event.onDOMReady(generatePanel);
////////////////CPS R2 - Activation message display. END
</script>

</head>
<body class="yui-skin-sam" style="overflow: auto;"  >
	<div id="erraa" style="background-color: #FFFFFF;min-width: 0;position: relative; z-index: 0;">
		<jsp:include page="/header.jsp" />
		<br/>
		<jsp:include page="/cpsErrors.jsp" />
	<div id="cont01" style="background-color: #FFFFFF; min-width: 0;position: relative;  z-index: 0;padding-top: 2px;width: 100%;
    overflow: auto;    margin: auto;">
	<form:form action="/protected/cps/manageEDI" name="searchForm" id="searchForm"  modelAttribute="manageEDICandidate">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<div id="cont12"  style="background-color: #FFFFFF;min-width: 0;">
				<div id="ContCont"  style="background-color: #FFFFFF;position: relative;min-width: 0;padding-bottom: 2px; padding-top: 2px;">
					<div style="background-color: #FFFFFF;position: relative; min-width: 0;">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<label id="testScanMessage" class="labelMessageHead"></label>
						<jsp:include page="/cps/manageEDI/modules/searchEDI.jsp" />
						<c:if test="${!empty manageEDICandidate.ediSearchResultVOLst}">
							<div id="contentAfterSearchDiv">
								<c:if test="${manageEDICandidate.candidateEDISearchCriteria.actionId != '4'}">
									<div id="searchResultDiv">
										<jsp:include page="/cps/manageEDI/modules/searchEDIResult.jsp" />
									</div>
									<div id="footerFunctionDiv" style="position: relative;
										padding-bottom: 1px;
										padding-top: 2px;
										width: 98.4%;
										color: #000000;">
										<jsp:include page="/cps/manageEDI/modules/ediFunction.jsp" />
									</div>
								</c:if>
								<c:if test="${manageEDICandidate.candidateEDISearchCriteria.actionId == '4'}">
									<div id="searchResultDiv">
										<jsp:include page="/cps/manageEDI/modules/dsdDiscontinue.jsp" />
									</div>
								</c:if>
							</div>
						</c:if>
					</div>
				</div>
			</div>
			<div id="panelActive" style="display :none;">
				<div class="hd">
					<div class="tl"></div>
					<span><font size="2" color="white">&nbsp;&nbsp;&nbsp; ${requestScope.MessageTitles}</font></span>
					<div class="tr"></div>
				</div>
				<div class="bd">
					<div id="messageTable"></div>
				</div>
				<div class="ft">
					<div class="bl"></div>
					<div id="panelActiveFooter" style="display: none;">
						<font color="blue" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">Existing UPCs/Item Codes are marked with an '*'.</font>
					</div>
					<div class="br"></div>
				</div>
			</div>
		</form:form>
	</div>
	</div>
	<jsp:include page="/footerEdi.jsp"></jsp:include>

</body>
<script type="text/javascript">
//check Firefox, Safari, Opera browsers
	if(document.getElementById('searchResultDiv')!=null)
	{
		if (YAHOO.env.ua.gecko > 0 || YAHOO.env.ua.webkit || YAHOO.env.ua.opera)
		{
		document.getElementById('searchResultDiv').className="zIndexFireFox";
	}
//check IE browser
		if (YAHOO.env.ua.ie > 0)
		{
			if(YAHOO.env.ua.ie < 8)
	{
		document.getElementById('searchResultDiv').className="zIndexIE";
	}
			else
			{
				document.getElementById('searchResultDiv').className="zIndexNewIE";
			}
		}
}
</script>
</html>

