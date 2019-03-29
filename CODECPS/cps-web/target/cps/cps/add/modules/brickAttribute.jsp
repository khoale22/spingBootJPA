<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:url value="${request.getContextPath()}/yui/datatable/assets/skins/sam/datatable.css" var="styleURL" />
<link type="text/css" rel="stylesheet"
href="${styleURL}">
<c:url value="${request.getContextPath()}/yui/container/assets/skins/sam/container.css" var="styleURL" />
<link rel="stylesheet" type="text/css"
href="${styleURL}" />
<c:url value="${request.getContextPath()}/yui/element/element-beta-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/datasource/datasource-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/json/json-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/connection/connection-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/get/get-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/datatable/datatable-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/event/event-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/container/container-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/animation/animation-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/dragdrop/dragdrop-min.js" var="styleURL" />
<script src="${styleURL}"></script>

<style>

	.columnLeft {
		float: left;
 		width: 33%;
	}
/* Skin default elements */
.singlePanel_c.yui-panel-container.shadow .underlay {
	left: 1px;
	right: -1px;
	top: 1px;
	bottom: -1px;
	position: absolute;
	background-color: #000;
	opacity: 0.12;
	filter: alpha(opacity =       12);
}

/* Apply the border to the right side */
.singlePanel.yui-panel {
	border: none;
	overflow: visible;
	background: transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat
		top right;
}

/* Style the close icon */
.singlePanel.yui-panel .hd .closeMe {
	position: absolute;
	top: 5px;
	right: 8px;
	height: 21px;
	width: 21px;
	background: url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
}

/* Style the header with its associated corners */
.singlePanel.yui-panel .hd {
	padding: 0;
	border: none;
	background: url(<%=request.getContextPath()%>/hebAssets/images/xp-hd.gif) repeat-x;
	color: #FFF;
	height: 30px;
	margin-left: 0px;
	margin-right: 0px;
	text-align: left;
	vertical-align: middle;
	overflow: visible;
}

/* Style the body with the left border */
.singlePanel.yui-panel .bd {
	overflow: hidden;
	padding: 10px;
	border: none;
	background: #FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y;
	margin: 0 4px 0 0;
}

/* Style the footer with the bottom corner images */
.singlePanel.yui-panel .ft {
	background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
	font-size: 11px;
	height: 26px;
	padding: 0px 10px;
	border: none
}

/* Skin custom elements */
.singlePanel.yui-panel .hd span {
	line-height: 30px;
	vertical-align: middle;
	font-weight: bold;
	margin-left: 12px;
}

.singlePanel.yui-panel .hd .tl {
	width: 8px;
	height: 29px;
	top: 1px;
	left: 0px;
	background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
	position: absolute;
}

.singlePanel.yui-panel .hd .tr {
	width: 8px;
	height: 29px;
	top: 1px;
	right: 0;
	background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat;
	position: absolute;
}

.singlePanel.yui-panel .ft span {
	line-height: 22px;
	vertical-align: middle;
}

.singlePanel.yui-panel .ft .bl {
	width: 8px;
	height: 26px;
	bottom: 0;
	left: 0;
	background: url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
	position: absolute;
}

.singlePanel.yui-panel .ft .br {
	width: 8px;
	height: 26px;
	bottom: 0;
	right: 0;
	background: url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
	position: absolute;
}

.yui-skin-sam .yui-dt td.align-center {
	text-align: center;
}


.yui-skin-sam .yui-dt th {
	text-align: center;
	font-weight: bold;
	color: #00000;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
}


.redAsterisk {
	color: red;
	font-size: 15px;
}
</style>

<body onload="onLoadWidthDiv()">
<div style="clear: both;"></div>
<div style="margin-left: 20px">

		<div style="width: 100%">
			
			<div style="margin-bottom: 10px;">
				<label id="brkNameLbl" style="width: 100%; font-size: 1.2em; font-weight: bold;"></label>				
			</div>
			<div style="clear: both; width: 100%"></div>
			<div id="dynDiv">			
			<c:set value="${AddNewCandidate.productVO.classificationVO.brick}" var="brickId"></c:set>
			<c:forEach items="${AddNewCandidate.productVO.imageAttVO.brick.extendAttrVO.lstSingle}" var="lstSingle" varStatus="loop" >
					<c:if test="${lstSingle.componentType == 'SINGLE_VALUE'}">
						<div id="dynDiv${lstSingle.attrId} " class="columnLeft">
							<cps:singleValue compName="${lstSingle.label}"
								uniqueId="id${lstSingle.attrId}"
								textid="txt${lstSingle.attrId}"
								attrId="${lstSingle.attrId}"
								entyId="${brickId}"
								requireAttr="${lstSingle.required}"
								clearMethod="clearText${lstSingle.attrId}"
								genericHiddenElmName="productVO.imageAttVO.brick.extendAttrVO"
								viewMode="${AddNewCandidate.viewModeImageAttr}"
								resourceId="271">
							</cps:singleValue>
							 <form:hidden  path="attrValTxt" id="id${lstSingle.attrId}StrutsHiddenElm" indexed="true"/>
							<form:hidden  path="attrCd" id="id${lstSingle.attrId}StrutsHiddenElmCd" indexed="true"/>
						</div>
					</c:if>
					<c:if test="${lstSingle.componentType == 'MULTI_VALUE'}">
						<div id="dynDiv${lstSingle.attrId} " class="columnLeft">
							<cps:mutilValue attrLabel="${lstSingle.label}"
								entyId="${brickId}"
								attrId="${lstSingle.attrId}"
								requireAttr="${lstSingle.required}"
								uniqueId="id${lstSingle.attrId}" textid="txt${lstSingle.attrId}"
								genericHiddenElmName="productVO.imageAttVO.brick.extendAttrVO"
								viewMode="${AddNewCandidate.viewModeImageAttr}"
								resourceId="271">
							</cps:mutilValue>
							 <form:hidden path="attrValTxt" id="id${lstSingle.attrId}StrutsHiddenElm" indexed="true"/>
							<form:hidden  path="attrCd" id="id${lstSingle.attrId}StrutsHiddenElmCd" indexed="true"/>
						</div>
					</c:if>
					<c:if test="${lstSingle.componentType == 'TEXT_INPUT'}">
						<div id="dynDiv${lstSingle.attrId} " class="columnLeft">
							<cps:normalText attrLabel="${lstSingle.label}"
								uniqueId="id${lstSingle.attrId}"
								textid="txt${lstSingle.attrId}"
								attrId="${lstSingle.attrId}"
								entyId="${brickId}"
								requireAttr="${lstSingle.required}"
								dataType="${lstSingle.dataType}"
								prcsnNbr="${lstSingle.prcsnNbr}"
								clearMethod="clearText${lstSingle.attrId}"
								genericHiddenElmName="productVO.imageAttVO.brick.extendAttrVO"
								viewMode="${AddNewCandidate.viewModeImageAttr}"
								resourceId="271">
							</cps:normalText>
							<form:hidden path="attrValTxt" id="id${lstSingle.attrId}StrutsHiddenElm" indexed="true"/>
						</div>
					</c:if>
					<c:if test="${lstSingle.col == 3}">
						<div style="width: 100%">
							&nbsp;
						</div>
					</c:if>
			</c:forEach>
			<c:forEach items="${AddNewCandidate.productVO.imageAttVO.brick.extendAttrVO.lstGrp}" var="lstGrp" varStatus="loop" >
					<c:if test="${lstGrp.componentType =='SINGLE_ENTY_VALUE'}">
						<div id="dynDiv${lstGrp.groupId}"  class="columnLeft">
							<c:if test="${lstGrp.lstAttr[1].attrValListSw eq 'Y'}">
								<cps:singleEntity attr1Label="${lstGrp.lstAttr[0].label}"
									attr2Label="${lstGrp.lstAttr[1].label}"
									attrId1="${lstGrp.lstAttr[0].attrId}"
									attrId2="${lstGrp.lstAttr[1].attrId}"
									uniqueId="0xxx${lstGrp.groupId}"
									textid1="${lstGrp.groupId}xxx${lstGrp.lstAttr[0].attrId}"
									textid2="${lstGrp.groupId}xxx${lstGrp.lstAttr[1].attrId}"
									requireAttr1="${lstGrp.lstAttr[0].required}"
									requireAttr2="${lstGrp.lstAttr[1].required}"
									entyId="${brickId}"
									clearMethod="clearText${lstGrp.groupId}"
									genericHiddenElmName="productVO.imageAttVO.brick.extendAttrVO"
									viewMode="${AddNewCandidate.viewModeImageAttr}"
									resourceId="271">
								</cps:singleEntity>
								<form:hidden path="lstAttr[0].attrValTxt" id="${lstGrp.groupId}xxx${lstGrp.lstAttr[0].attrId}StrutsHiddenElm" indexed="true"/>
								<form:hidden path="lstAttr[1].attrValTxt" id="${lstGrp.groupId}xxx${lstGrp.lstAttr[1].attrId}StrutsHiddenElm" indexed="true"/>
								<form:hidden path="lstAttr[0].attrCd" id="${lstGrp.groupId}xxx${lstGrp.lstAttr[0].attrId}StrutsHiddenElmCd" indexed="true"/>

							</c:if>
							<c:if test="${lstGrp.lstAttr[0].attrValListSw eq 'Y'}">
								<cps:singleEntity attr1Label="${lstGrp.lstAttr[1].label}"
									attr2Label="${lstGrp.lstAttr[0].label}"
									attrId1="${lstGrp.lstAttr[1].attrId}"
									attrId2="${lstGrp.lstAttr[0].attrId}"
									uniqueId="0xxx${lstGrp.groupId}"
									textid1="${lstGrp.groupId}xxx${lstGrp.lstAttr[1].attrId}"
									textid2="${lstGrp.groupId}xxx${lstGrp.lstAttr[0].attrId}"
									requireAttr1="${lstGrp.lstAttr[1].required}"
									requireAttr2="${lstGrp.lstAttr[0].required}"
									entyId="${brickId}"
									clearMethod="clearText${lstGrp.groupId}"
									genericHiddenElmName="productVO.imageAttVO.brick.extendAttrVO"
									viewMode="${AddNewCandidate.viewModeImageAttr}"
									resourceId="271">
								</cps:singleEntity>
								<form:hidden  path="lstAttr[1].attrValTxt" id="${lstGrp.groupId}xxx${lstGrp.lstAttr[1].attrId}StrutsHiddenElm" indexed="true"/>
								<form:hidden  path="lstAttr[0].attrValTxt" id="${lstGrp.groupId}xxx${lstGrp.lstAttr[0].attrId}StrutsHiddenElm" indexed="true"/>
								<form:hidden path="lstAttr[1].attrCd" id="${lstGrp.groupId}xxx${lstGrp.lstAttr[1].attrId}StrutsHiddenElmCd" indexed="true"/>

							</c:if>
						</div>
					</c:if>
					<c:if test="${lstGrp.col == 3}">
						<div style="width: 100%">
							&nbsp;
						</div>
					</c:if>

			</c:forEach>
			<c:forEach items="${AddNewCandidate.productVO.imageAttVO.brick.extendAttrVO.lstGrp}" var="lstGrp" varStatus="loop" >
					<c:if test="${lstGrp.componentType =='MULTI_ENTY_VALUE'}">
						<div style="width: 100%">
							&nbsp;
						</div>
						<div style="width: 100%;clear: both;">
							<cps:dataTable compGroupDes="${lstGrp.label}"
								compId="0xxx${lstGrp.groupId}"
								entyId="${brickId}" groupId="${lstGrp.groupId}"
								data="" columnDefs="${lstGrp.jSonHeaderGroup}"
								brickSw="Y"
								genericHiddenElmName="productVO.imageAttVO.brick.extendAttrVO"
								viewMode="${AddNewCandidate.viewModeImageAttr}"
								resourceId="271">
							</cps:dataTable>
							<form:hidden path="jsonDataUpdate" id="0xxx${lstGrp.groupId}StrutsHiddenElm" indexed="true"/>
						</div>
					</c:if>

			</c:forEach>
			</div>
		</div>


</div>
</body>

<script type="text/javascript">

	function onLoadWidthDiv(){
		var wtd = screen.width - 200;
		document.getElementById('dynDiv').style.width = ""+wtd+"px";
		var brickNm = "";
		<c:if test="${AddNewCandidate.productVO.classificationVO.brickName != null && AddNewCandidate.productVO.classificationVO.brickName != ''}">
			var brNm = '${AddNewCandidate.productVO.classificationVO.brickName}';
			brickNm = brNm.split("[")[0];
		</c:if>
		<c:if test="${not empty AddNewCandidate.productVO.imageAttVO.brick.extendAttrVO.lstSingle || not empty AddNewCandidate.productVO.imageAttVO.brick.extendAttrVO.lstGrp}">
		document.getElementById('brkNameLbl').innerHTML = brickNm;
		</c:if>

	}


	function fnCallFillData() {
		if (dataTableJson != null) {
			for ( var keyEnty in dataTableJson) {
				var objEnty = dataTableJson[keyEnty];
				for ( var i = 0; i < objEnty.length; i++) {
					var objGrp = objEnty[i];
					for ( var key in objGrp) {
						if (parseInt(key) == 0) {
							var objAtt = objGrp[key];
							for ( var keyAtt in objAtt) {
								var arrAtt = objAtt[keyAtt];
								window["fillDataForTextInput" + "id" + keyAtt](arrAtt);
							}
						} else {
							if(objGrp[key] != null) {
								window["fillDataForTable" + "0xxx" + key](objGrp[key],key);
							}
						}
					}
				}
			}
		}
	}

	var dataTableJson = null;
	var callbacksBrick = {
		success : function(o) {
			try {
				if (o != null && o.responseText !== undefined && myTrim(o.responseText) != '') {
					dataTableJson = YAHOO.lang.JSON.parse(o.responseText);
					fnCallFillData();
				}
			} catch (e) {
				return;
			}
		},
		failure : function() {
		},
		timeout : 5000
	};
	// Make the call to the server for JSON data
	//protected/cps/add/AddNewCandidate.do?tab=getDataBrickInfor&upc=${AddNewCandidate.productVO.upcImageAndAttr}&psWorkId=${AddNewCandidate.productVO.workRequest.workIdentifier}",
			//protected/cps/add/AddNewCandidate.do?tab=getDataBrickInfor&upc=60998394&psWorkId=3148627",
	YAHOO.util.Connect
			.asyncRequest(
					'GET',
					"getDataBrickInfor?upc=${AddNewCandidate.productVO.upcImageAndAttr}&psWorkId=${AddNewCandidate.productVO.workRequest.workIdentifier}&${_csrf.parameterName}=${_csrf.token}",
					callbacksBrick);
	
	function myTrim(x) {
		return x.replace(/^\s+|\s+$/gm,'');
	}
	
</script>