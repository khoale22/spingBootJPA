<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@page import="com.heb.operations.cps.util.CPSGlobals"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html>
<%-- <base ref="site" /> --%>
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8"/>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> -->
<title><spring:eval expression="@messageResourcesProperties.getProperty('app.name')" /> - Manage Candidate</title>

<jsp:include page="/common_head.jsp" />
<jsp:include page="/autoCompleteHeader.jsp" />
<jsp:include page="/cps/manage/modules/searchpanel_head.jsp" />
<c:url value="/dwr/engine.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/util.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/ManageDWR.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="${request.getContextPath()}/yui/connection/connection-min.js" var="styleLink"/>
<script type="text/javascript" src="${styleLink}"></script>
<c:url value="${request.getContextPath()}/hebAssets/dispatcher.js" var="dispatcher"/>
<script type="text/javascript" src="${dispatcher}"></script>
<c:url value="${request.getContextPath()}/yui/yahoo-dom-event/yahoo-dom-event.js" var="yahooDom"/>
<script type="text/javascript" src="${yahooDom}"></script>
<c:url value="${request.getContextPath()}/yui/dragdrop/dragdrop-min.js" var="dragdrop"/>
<script type="text/javascript" src="${dragdrop}"></script>
<c:url value="${request.getContextPath()}/yui/container/container-min.js" var="containerJs"/>
<script type="text/javascript" src="${containerJs}"></script>


<c:url value="/yui/" var="yuiURL"></c:url>
<c:url value="${request.getContextPath()}/yui/yuiloader/yuiloader-min.js" var="loaderURL"></c:url> 
<script type="text/javascript" src="${loaderURL}"></script> 

<c:url value="${request.getContextPath()}/yui/fonts/fonts-min.css" var="fontsMinCss"/>
<link rel="stylesheet" type="text/css" href="${fontsMinCss}" />
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
	#panel1_c.yui-panel-container.shadow .underlay {
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
/*    for test scan popup   */
	#panel2_c.yui-panel-container.shadow .underlay {
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
	#panel2.yui-panel {
		border:none;
		overflow:visible;
		background:transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat top right;
	}

	/* Style the close icon */
	#panel2.yui-panel .container-close {
		position:absolute;
		top:5px;
		right:8px;
		height:21px;
		width:21px;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
	}

	/* Style the header with its associated corners */
	#panel2.yui-panel .hd {
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
	#panel2.yui-panel .bd {
		overflow:hidden;
		padding:10px;
		border:none;
		background:#FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y; 
		margin:0 4px 0 0;
	}

	/* Style the footer with the bottom corner images */
	#panel2.yui-panel .ft {
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
		font-size:11px;
		height:26px;
		padding:0px 10px;
		border:none
	}

	/* Skin custom elements */
	#panel2.yui-panel .hd span {
		line-height:30px;
		vertical-align:middle;
		font-weight:bold;
	}
	#panel2.yui-panel .hd .tl {
		width:8px;
		height:29px;
		top:1px;
		left:0px;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
		position:absolute;
	}
	
	#panel2.yui-panel .hd .closeMe {
		position:absolute;
		top:5px;
		right:8px;
		height:21px;
		width:21px;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat; 		
	}
	
	
	#panel2.yui-panel .hd .tr {
		width:8px;
		height:29px;
		top:1px;
		right:0;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat; 
		position:absolute;
	}

	#panel2.yui-panel .ft span {
		line-height:22px;
		vertical-align:middle;
	}
	#panel2.yui-panel .ft .bl {
		width:8px;
		height:26px;
		bottom:0;
		left:0;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
		position:absolute;
	}
	#panel2.yui-panel .ft .br {
		width:8px;
		height:26px;
		bottom:0;
		right:0;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
		position:absolute;
	}
	
	
	/* Skin default elements */
	#cornfirmVendorLogin_c.yui-panel-container.shadow .underlay {
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
	#cornfirmVendorLogin.yui-panel {
		border:none;
		overflow:visible;
		background:transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat top right;
	}

	/* Style the close icon */
	#cornfirmVendorLogin.yui-panel .container-close {
		position:absolute;
		top:5px;
		right:8px;
		height:21px;
		width:21px;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
	}

	/* Style the header with its associated corners */
	#cornfirmVendorLogin.yui-panel .hd {
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
	#cornfirmVendorLogin.yui-panel .bd {
		overflow:hidden;
		padding:10px;
		border:none;
		background:#FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y; 
		margin:0 4px 0 0;
	}

	/* Style the footer with the bottom corner images */
	#cornfirmVendorLogin.yui-panel .ft {
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
		font-size:11px;
		height:26px;
		padding:0px 10px;
		border:none
	}

	/* Skin custom elements */
	#cornfirmVendorLogin.yui-panel .hd span {
		line-height:30px;
		vertical-align:middle;
		font-weight:bold;
	}
	#cornfirmVendorLogin.yui-panel .hd .tl {
		width:8px;
		height:29px;
		top:1px;
		left:0px;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
		position:absolute;
	}
	
	#cornfirmVendorLogin.yui-panel .hd .tr {
		width:8px;
		height:29px;
		top:1px;
		right:0;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat; 
		position:absolute;
	}

	#cornfirmVendorLogin.yui-panel .ft span {
		line-height:22px;
		vertical-align:middle;
	}
	#cornfirmVendorLogin.yui-panel .ft .bl {
		width:8px;
		height:26px;
		bottom:0;
		left:0;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
		position:absolute;
	}
	#cornfirmVendorLogin.yui-panel .ft .br {
		width:8px;
		height:26px;
		bottom:0;
		right:0;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
		position:absolute;
	}
</style>
 
<script type="text/javascript">

YAHOO.namespace('HEB.manageMain');
<c:url var="ieIcon" value="${request.getContextPath()}/hebAssets/images/ieIcon.jpg"></c:url>
<c:if test="${manageCandidate.validForResults}">
<c:url value="/protected/cps/manage/filter?${_csrf.parameterName}=${_csrf.token}" var="link"></c:url>
<c:url value="${request.getContextPath()}/hebAssets/images/loading.gif" var="loading" />
var loadingUrl = '${loading}';
var tempHtml1 = "<br><br><br><table width='100%'><tr><td align='center'><img src='"+loadingUrl+"'  align='middle'/></td></tr></table><br><br><br>"

YAHOO.util.Event.addListener(YAHOO.util.Dom.get("filterGo"), "click", filter);

var d1 = 'no';
var caseVal = '';


function filter(evt){
		var formObject = document.getElementById('searchForm');
		formObject.action = "${link}"+'&direction='+d1+'&sortCaseValue='+caseVal;
//		hideTable(); Fix #819
//		hideBorder('f1','hide');
		YAHOO.util.Connect.setForm(formObject); 
		
		var callback = {
			success:function(o){
				hideProgress();
				document.getElementById('results').innerHTML = o.responseText;
				d1 = 'no';
				var checks = document.getElementsByName('candSelectCheck');	
				var workRequestSelected = document.getElementById('selectedProdWorkRqstId').value;				
				for(var i =0;i<checks.length;i++){
					//if(document.getElementById('checkAll').checked){
						//document.getElementById('check'+i).checked=true;
					//}
					//} else {
						prodWorkRqstSelectId = document.getElementById("workId"+i).value+":"+document.getElementById("hiddProdId"+i).value;							
						if(workRequestSelected!=null && workRequestSelected.search(prodWorkRqstSelectId)!=-1){
							document.getElementById('check'+i).checked=true;
						} else {
							document.getElementById('check'+i).checked=false;	
						}
					//}					
				}
			}
		};
		document.getElementById('results').innerHTML = tempHtml1;
		showProgress();
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
		//to clear selected checkboxes on filter
		//document.getElementById('checkAll').checked = false; 
		//nb = document.all.item('check').length;
		//    for(i=0; i<nb; i++) {
		 //       document.all.item('check', i).checked=false;
		 //   }
}

function sort(dirct,caseValue){
	//alert('in');
	d1 = dirct;
	caseVal = caseValue;
	filter(null);
}

</c:if>

function testScanMess(data){
	document.getElementById("testScanMessage").innerText=data;
}


//////////////// CPS R2 - Activation message display. START
function showActivationMsg() {
	//alert('showActivationMsg');
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
    
    <c:url value="/protected/cps/manage/activationMessage?${_csrf.parameterName}=${_csrf.token}" var="serverUrl" />
    
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
		    myConfigs = {
		        initialRequest: "results=2",         
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
	myDataTable.appendTo(YAHOO.heb.container.panel1.body);

    return {
       myDataSource: myDataSource,
       myDataTable: myDataTable
    };
}


function loadTable(){
	//alert('loadTable');
    var tableLoader = new YAHOO.util.YUILoader({ 
        base: "${yuiURL}", 
        require: ["paginator","datatable","connection","json","datasource", "element", "yuiloader"], 
        loadOptional: true, 
        combine: false, 
        filter: "MIN", 
        allowRollup: false, 
        onSuccess: function() {   
            //alert('suceefully');			
			showActivationMsg();			
        } 
    }); 
    tableLoader.insert();
}

YAHOO.namespace("heb.container");

function generatePanel(){
	//<c:if test="${(manageCandidate.userRole eq 'UVEND' || manageCandidate.userRole eq 'RVEND')}">
	//if((document.all)&&(navigator.appVersion.indexOf("MSIE 7.")!= -1)){
	//	} else {
	//			document.getElementById('cornfirmVendorLogin').style.display = 'block';
	//			generateCofirm();
	//	}
	//</c:if>
	//document.getElementById('panel1Footer').style.display = 'none';
	document.getElementById("panel1Footer").style.display="none";
	document.getElementById("panel1Footer").style.position="fixed";
<c:if test="${requestScope.ActivationSuccess eq 'Y'}">	
//alert('generatePanel 1');
	YAHOO.heb.container.panel1 = new YAHOO.widget.Panel("panel1", 
					{ 	width:"500px", 
						height:"300px", 
						visible:false, 
						constraintoviewport:true, 
						draggable:true,	
						zIndex : 55000,	
						//modal:true,
						fixedCenter : true,// Keep centered if window is scrolled
						effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}						
					} );
	
	YAHOO.heb.container.panel1.render();
	loadTable();	
	YAHOO.heb.container.panel1.show();		
</c:if>
}
function generateCofirm(){		
 
	 YAHOO.heb.container.wait = 
                    new YAHOO.widget.Panel("cornfirmVendorLogin",  
                                 { 
									width:"580px", 
									height:"300px", 
									visible:false, 	
									close: false,								
									draggable:true,	
									zIndex : 55000,	
									modal:true,	
									fixedCenter : true,// Keep centered if window is scrolled
									effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}	
                                         } 
                              ); 								  
            YAHOO.heb.container.wait.render();  
        var callback = {
            success : function(o) {
                content.innerHTML = o.responseText;
                content.style.visibility = "visible";
                //YAHOO.heb.container.wait.hide();
            },
            failure : function(o) {
                content.innerHTML = o.responseText;
                content.style.visibility = "visible";
                content.innerHTML = "CONNECTION FAILED!";
              // YAHOO.heb.container.wait.hide();
            }
        }
// Show the Panel
        YAHOO.heb.container.wait.show();		
};
YAHOO.util.Event.onDOMReady(generatePanel);
////////////////CPS R2 - Activation message display. END
</script>

</head>
<body class="yui-skin-sam" style="overflow: auto;"  >
	<div id="erraa" style="background-color: #FFFFFF;min-width: 0;position: relative; z-index: 0;">
		<jsp:include page="/header.jsp" />	
		<br/>
		<jsp:include page="/cpsErrors.jsp" />
	
	
	<div id="cont01" style="background-color: #FFFFFF; min-width: 0;position: relative;  z-index: 0;">
		<form:form action="/protected/cps/manage" name="searchForm" id="searchForm" modelAttribute="manageCandidate">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<div id="cont12"  style="background-color: #FFFFFF;min-width: 0;">				
				<div id="ContCont"  style="background-color: #FFFFFF;position: relative;min-width: 0;">
			 		<div id="msgDiv" style="background-color: #FFFFFF; top: 80px;" >
				 		<c:if test="${requestScope.myMessage != null}">
				 			<span style="color: blue; font-size: small; font-family: sans-serif;"><b> ${requestScope.myMessage}</b> </span>
				 		</c:if>
			 		</div>					
					<div style="background-color: #FFFFFF;position: relative; min-width: 0;">						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<label id="testScanMessage" class="labelMessageHead"></label>
						<jsp:include page="/cps/manage/modules/search.jsp" />
						<div id="searchResultDiv">		
							<jsp:include page="/cps/manage/modules/searchResults.jsp" />
						</div>
					</div>
				</div>
			</div>
			<div id="panel1">
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
					<div id="panel1Footer" style="display: none;">
						<font color="blue" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">Existing UPCs/Item Codes are marked with an '*'.</font>
					</div>
					<div class="br"></div>
				</div>
			</div>

		</form:form>
	</div>
	</div>

	<jsp:include page="/footer.jsp"></jsp:include>
	
<div id="pan" style="display: none;left:300px;top:200px;">
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
<div id="panel2" style="display: none;left:300px;top:200px;">
	<div class="hd">
		<div class="tl"></div>
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
<div id="cornfirmVendorLogin" style="display: none;">
<div class="hd">
 <div class="tl"></div>
	<span><font size="2" color="white">&nbsp;&nbsp;&nbsp;Warning Vendor</font></span>
	<div class="tr"></div>
 </div>
<div class="bd">
<h2 style="color:#003333"> Your current browser is not supported.</h2>
  --------------------------------------------------------------------------------
  <br/>
  <strong>We're sorry for the inconvenience. Please use one of the supported browsers below and you'll be up and 
  	running in no time.</strong>
	<table width="515" border="0">
	  <tr>
	    <td width="87" align="center"><img src="${ieIcon}" width="54" height="54" /></td>
	    <td width="418"><p><strong>Internet Explorer (Windows) 7.0 </strong><br/>
	      <a href="http://www.microsoft.com/downloads/en/details.aspx?FamilyID=9ae91ebe-3385-447c-8a30-081805b2f90b&displaylang=en">Click here to download.</a></p></td>
	  </tr>
	  <tr>
	    <td align="center"><img src="${ieIcon}" width="54" height="54" /></td>
	    <td><p><strong>Internet Explorer (Windows) 8.0(Compatibility mode)</strong> <br />	      
	      <a href="http://windows.microsoft.com/en-us/internet-explorer/products/ie/home">Click here to download.</a><br />
	      After downloading, Open Internet Explorer and click on <strong>Tools</strong>-&gt; <strong>Compatibility View</strong>
	      </p></td>
	  </tr>
	</table>
</div>
<div class="ft">
		<div class="bl"></div>
		<div class="br"></div>
	</div>

</div>
</body>
<script type="text/javascript">
//check Firefox, Safari, Opera browsers
if (YAHOO.env.ua.gecko > 0 || YAHOO.env.ua.webkit || YAHOO.env.ua.opera) {
	document.getElementById('searchResultDiv').className="zIndexFireFox";
}
//check IE browser
if (YAHOO.env.ua.ie > 0) {
	document.getElementById('searchResultDiv').className="zIndexIE";
}
</script>
</html>

