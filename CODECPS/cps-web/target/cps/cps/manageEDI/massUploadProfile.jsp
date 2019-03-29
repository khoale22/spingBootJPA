<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<%@page import="com.heb.operations.cps.util.CPSGlobals"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.heb.operations.cps.vo.MassUploadVO"%>
<%@page import="java.util.List"%><head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>


<title><spring:eval expression="@messageResourcesProperties.getProperty('app.name')" /> -  Volume Upload Profile</title>
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
<c:url value="${request.getContextPath()}/yui/connection/connection-min.js" var="styleLink" />
<script type="text/javascript" src="${styleLink}"></script>
<c:url value="${request.getContextPath()}/hebAssets/dispatcher.js" var="myJs" />
<script type="text/javascript" src="${myJs}"></script>
<script type="text/javascript"
		src="${request.getContextPath()}/cps/yui/yahoo-dom-event/yahoo-dom-event.js"></script>
<script type="text/javascript" src="${request.getContextPath()}/cps/yui/dragdrop/dragdrop-min.js"></script>
<script type="text/javascript" src="${request.getContextPath()}/cps/yui/container/container-min.js"></script>
<c:url value="/yui/" var="yuiURL"></c:url>
<c:url value="${request.getContextPath()}/yui/yuiloader/yuiloader-min.js" var="loaderURL"></c:url>
<script type="text/javascript"
		src="${request.getContextPath()}/cps/yui/yahoo-dom-event/yahoo-dom-event.js"></script>


<script type="text/javascript" src="${loaderURL}"></script>


<link rel="stylesheet" type="text/css" href="${request.getContextPath()}/cps/yui/fonts/fonts-min.css" />
<link rel="stylesheet" type="text/css" href="${request.getContextPath()}/cps/yui/container/assets/container-core.css" />
<link type="text/css" rel="stylesheet" href="${request.getContextPath()}/cps/yui/container/assets/skins/sam/container-skin.css"/>
<style type="text/css">
	.yui-skin-sam .myAutoComplete .yui-ac-content {
		max-height: 15em;
		overflow: auto;
		overflow-x: hidden;
		_height: 15em;
		z-index: 15000;
		left: 0px;
		text-align: left;
		color: #000;
	}

	.yui-skin-sam .yui-dt tr.mark,.yui-skin-sam .yui-dt tr.mark td.yui-dt-asc,.yui-skin-sam .yui-dt tr.mark td.yui-dt-desc,.yui-skin-sam .yui-dt tr.mark td.yui-dt-asc,.yui-skin-sam .yui-dt tr.mark td.yui-dt-desc
	{
		background-color: #f1c8ff;
		color: #000;
	}

	.yui-skin-sam .yui-dt table .tbl-filter {
		width: 100%;
		border: 0px;
	}

	.yui-skin-sam .yui-dt .td-filter {
		border-color: -moz-use-text-color #CBCBCB -moz-use-text-color
		-moz-use-text-color;
		border-style: none none none none;
		border-width: medium 0px medium medium;
		margin: 0;
		padding: 0;
		text-align: left;
	}

	.yui-skin-sam .yui-dt-liner {
		font: 11px Arial, Helvetica, sans-serif;
	}

	.yui-skin-sam .yui-dt td.align-center{
		text-align:center;
	}
	.yui-skin-sam .yui-dt-scrollable .yui-dt-bd {
		z-index: 1;
		overflow: auto;
		width: 99.9%;
		position: relative;
	}

	.yui-skin-sam .yui-dt-scrollable .yui-dt-hd {
		overflow: visible;
		z-index: 2;
		position: relative;
		width: 99.9%;
	}

	.disabled-text {
		border-width: 1px;
		border-color: #cdcdcd;
		border-style: solid;
		padding: 2px;
		color: #666;
	}

	/*.yui-skin-sam tr.yui-dt-even {
		background-color: #F5EFEA;
	}
	.yui-skin-sam tr.yui-dt-odd {
		background-color: #D3DADD;
	}
	.yui-skin-sam tr.yui-dt-even td.yui-dt-asc, .yui-skin-sam tr.yui-dt-even td.yui-dt-desc {
		background-color: #EDF5FF;
	}
	.yui-skin-sam tr.yui-dt-odd td.yui-dt-asc, .yui-skin-sam tr.yui-dt-odd td.yui-dt-desc {
		background-color: #DBEAFF;
	}
	.yui-skin-sam .yui-dt-list tr.yui-dt-even {
		background-color: #F5EFEA;
	}
	.yui-skin-sam .yui-dt-list tr.yui-dt-odd {
		background-color: #FFFFFF;
	}*/
	.yui-skin-sam .yui-dt-list tr.yui-dt-even td.yui-dt-asc, .yui-skin-sam .yui-dt-list tr.yui-dt-even td.yui-dt-desc {
		background-color: #EDF5FF;
	}
	.yui-skin-sam .yui-dt-list tr.yui-dt-odd td.yui-dt-asc, .yui-skin-sam .yui-dt-list tr.yui-dt-odd td.yui-dt-desc {
		background-color: #D3DADD;
	}
	.yui-skin-sam th.yui-dt-highlighted, .yui-skin-sam th.yui-dt-highlighted a {
		background-color: #B2D2FF;
		color: #FFFFFF;
	}
	.yui-skin-sam tr.yui-dt-highlighted, .yui-skin-sam tr.yui-dt-highlighted td.yui-dt-asc, .yui-skin-sam tr.yui-dt-highlighted td.yui-dt-desc, .yui-skin-sam tr.yui-dt-even td.yui-dt-highlighted, .yui-skin-sam tr.yui-dt-odd td.yui-dt-highlighted {
		background-color: #B2D2FF;
		cursor: pointer;
		color: #FFFFFF;
	}
	.yui-skin-sam .yui-dt-list th.yui-dt-highlighted, .yui-skin-sam .yui-dt-list th.yui-dt-highlighted a {
		background-color: #B2D2FF;
		color: #FFFFFF;
	}
	.yui-skin-sam .yui-dt-list tr.yui-dt-highlighted, .yui-skin-sam .yui-dt-list tr.yui-dt-highlighted td.yui-dt-asc, .yui-skin-sam .yui-dt-list tr.yui-dt-highlighted td.yui-dt-desc, .yui-skin-sam .yui-dt-list tr.yui-dt-even td.yui-dt-highlighted, .yui-skin-sam .yui-dt-list tr.yui-dt-odd td.yui-dt-highlighted {
		background-color: #B2D2FF;
		cursor: pointer;
		color: #FFFFFF;
	}
	.yui-skin-sam th.yui-dt-selected, .yui-skin-sam th.yui-dt-selected a {
		background-color: #5D8CA3;
	}
	.yui-skin-sam tr.yui-dt-selected td, .yui-skin-sam tr.yui-dt-selected td.yui-dt-asc, .yui-skin-sam tr.yui-dt-selected td.yui-dt-desc {
		background-color: #5D8CA3;
		color: #FFFFFF;
	}
	.yui-skin-sam tr.yui-dt-even td.yui-dt-selected, .yui-skin-sam tr.yui-dt-odd td.yui-dt-selected {
		background-color: #5D8CA3;
		color: #FFFFFF;
	}
	.yui-skin-sam .yui-dt-list th.yui-dt-selected, .yui-skin-sam .yui-dt-list th.yui-dt-selected a {
		background-color: #5D8CA3;
	}
	.yui-skin-sam .yui-dt-list tr.yui-dt-selected td, .yui-skin-sam .yui-dt-list tr.yui-dt-selected td.yui-dt-asc, .yui-skin-sam .yui-dt-list tr.yui-dt-selected td.yui-dt-desc {
		background-color: #5D8CA3;
		color: #FFFFFF;
	}
	.yui-skin-sam .yui-dt-list tr.yui-dt-even td.yui-dt-selected, .yui-skin-sam .yui-dt-list tr.yui-dt-odd td.yui-dt-selected {
		background-color: #5D8CA3;
		color: #FFFFFF;
	}
	/* Skin default elements */
	/* Skin default elements */
	#minProgressDiv_c.yui-panel-container.shadow .underlay {
		left:1px;
		position:absolute;
		top:2px;
		left:-3px;
		right:-3px;
		bottom:-3px;
		*top:4px;*
	left:-1px;
		*right:-1px;
		*bottom:-1px;
		_top:0;
		_left:0;
		_right:0;
		_bottom:0;
		_margin-top:3px;
		_margin-left:-1px;
		background-color:#000;
		opacity:.12;
		*filter:alpha(opacity=12);
	}

	/* Apply the border to the right side */
	#minProgressDiv.yui-panel {
		position:relative;
		left:0;
		top:0;
		border-style:solid;
		border-width:1px 0;
		border-color:#808080;
		z-index:1;
		*border-width:1px;
		*zoom:1;
		_zoom:normal;
	}


	/* Style the header with its associated corners */
	#minProgressDiv.yui-panel .hd {
		border-style:solid;
		border-width:0 1px;
		border-color:#808080;
		margin:0 -1px;
		*margin:0;
		*border:0;
		border-bottom:solid 1px #ccc;
		padding:0 10px;
		font-size:93%;
		line-height:2;
		*line-height:1.9;
		font-weight:bold;
		color:#000;
		background-color:#F2F2F2;
	}

	/* Style the body with the left border */
	#minProgressDiv.yui-panel .bd {
		padding:10px;
		border-style:solid;
		background-color:#F2F2F2;
		border-style:solid;
		border-width:0 1px;
		border-color:#808080;
		margin:0 -1px;
		*margin:0;
		*border:0;
	}

	/* Style the footer with the bottom corner images */
	#minProgressDiv.yui-panel .ft {
		border-style:solid;
		border-width:0 1px;
		border-color:#808080;
		margin:0 -1px;
		*margin:0;
		*border:0;
		background-color:#F2F2F2;
		border-top:solid 1px #808080;
		padding:5px 10px;
		font-size:77%;
	}

</style>
</head>
<body>
<div id="yahoo-com" class="yui-skin-sam"
	 style="background-color: #FFFFFF; min-width: 0; position: relative; z-index: 0;"><jsp:include
		page="/header.jsp" /><br />
	<div style="margin-left: 10px;">
		<div id="CasePackMain"
			 style="padding-top: 15px; padding-left: 10px; width: 1110px; border-width: 2px; border-style: solid; border-color: #5d8ca3;">
			<form:form
					action="/protected/cps/volumeUploadProfile/updateMassUploadProfilies"
					id="massUploadProfiliesForm">
				<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<div style="background: #5d8ca3; width: 1100px;"><label
						style="font-size: 11pt;"> Volume Upload Profile</label></div>
				<br />
				<c:set var="lst" value="${CPSForm.messages}"></c:set>
				<c:forEach var="msg" items="${lst}" varStatus="rowCounter" >
					<c:choose>
						<c:when test="${msg.errorSeverity.errorSeverityValue == 1}">
							<div id="errors" style="position: relative;min-width: 0; color: blue">
									${msg.message}
							</div>
						</c:when>
					</c:choose>
				</c:forEach>
				<div id="tblMassUploadProfiles" style="width: 100%;"></div>
				<div id="pag" style="font-family: arial; font-size: 11px;"></div>
				<%--<form:hidden path="massUploadProfilesId" styleId="massUploadProfilesId" />
				<form:hidden path="filterValues" styleId="filterValues" />--%>
				<%--form:hidden path="filterValues" id="filterValues" />--%>
				<input type="hidden" id="filterValues"/>
			</form:form>
			<div id="containerFunction"
				 style="width: 1000px; margin-top: 5px; text-align: right;">
				<table id="tblFunction" style="text-align: right;" width="100%">
					<tr>
						<td width="90%"></td>
						<td width="5%">
							<div id="addDiv" align = "right">
								<cps:renderByResourceAccess	resourceId="164" honorViewMode="">
			<jsp:attribute name="EXEC">
								<input type="button" id="add" onclick="addRow();" value="Add" style='width: 60px;'/>
								</jsp:attribute>
                                    </cps:renderByResourceAccess>
							</div>
							<div id="saveDiv" align = "right" style="display: none;">
								<cps:renderByResourceAccess	resourceId="206" honorViewMode="" >
			<jsp:attribute name="EXEC">
								<input type="button" id="save" onclick="saveMassUploadProfilies();" value="Save" style='width: 60px;'/>
								</jsp:attribute>
                                    </cps:renderByResourceAccess>
							</div>
						</td>
						<td width="5%">
							<div id="deleteDiv" align = "right">
								<cps:renderByResourceAccess	resourceId="234" honorViewMode="">
			<jsp:attribute name="EXEC">
								<input type="button" id="delete"  onclick="deleteRow();" value="Delete" style='width: 60px;'/>
								</jsp:attribute>

                                    </cps:renderByResourceAccess>
							</div>
							<div id="revertDiv" align = "right" style="display: none;">
								<cps:renderByResourceAccess	resourceId="205" honorViewMode="">
			<jsp:attribute name="EXEC">
								<input type="button" id="reset" onclick="revert();" value="Reset" style='width: 60px;'/>
								</jsp:attribute>
                                    </cps:renderByResourceAccess>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<%
	if (request.getSession().getAttribute("allMassUploadProfiles") != null) {
		StringBuffer strData = new StringBuffer();
		strData.append("[");
		List<MassUploadVO> results = (List<MassUploadVO>) request
				.getSession().getAttribute("allMassUploadProfiles");
		if (results != null && results.size() > 0) {
			for (MassUploadVO massUploadVO : results) {
				String id = massUploadVO.getVendorId() + "-" +massUploadVO.getFunctionId();
				if (strData.toString().equals("["))
					strData.append("{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ id +"'>");
				else
					strData.append("\n,{checkBox:\"<input type='checkbox' id='ckb_"+ id +"' name ='ckb_"+ id +"'>");
				strData.append("\",Vendor:\""+ massUploadVO.getVendorName());
				strData.append("\",Id:\"" + id);
				//strData.append("\",SBT:\"" + massUploadVO.getsBT());
				strData.append("\",EditStatus:\"" + '0');
				strData.append("\",AddStatus:\"" + '0');
				strData.append("\",ModifyRow:\"" + '0');
				strData.append("\",AddRow:\"" + '0');
				strData.append("\",FunctionId:\""
						+ massUploadVO.getFunctionId());
				strData.append("\",FunctionNames:\""
						+ massUploadVO.getFunctionName());
				strData.append("\",VendorId:\"" + massUploadVO.getVendorId());
				strData.append("\",DSD:\"" + massUploadVO.isDSD());
				strData.append("\",apTypCd:\"" + "");
				strData.append("\",WHS:\"" + massUploadVO.isWHS());
				strData.append("\",chanelBoth:\"" + massUploadVO.isBoth());
				strData.append("\",DeleteStatus:\"" + '0');
				strData.append("\",autoApproveId:\""
						+ massUploadVO.getAutoApproveId());
				strData.append("\",autoApprove:\""
						+ massUploadVO.getAutoApprove()+ "\"}");
			}
		}
		strData.append("]");
%>
<script type="text/javascript">
    <c:url value="${request.getContextPath()}/hebAssets/images/dropdown.bmp" var="image"></c:url>
    String.prototype.ReplaceAll = function(stringToFind,stringToReplace){
        var temp = this;
        var index = temp.indexOf(stringToFind);
        while(index != -1){
            temp = temp.replace(stringToFind,stringToReplace);
            index = temp.indexOf(stringToFind);
        }
        return temp;
    }
    Array.prototype.inArray = function (value)
    {
        // Returns true if the passed value is found in the
        // array. Returns false if it is not.
        var i;
        for (i=0; i < this.length; i++)
        {
            if (this[i] == value)
            {
                return true;
            }
        }
        return false;
    };
    function disableEnterKey(e)
    {
        var key;
        if(window.event)
            key = window.event.keyCode;     //IE
        else
            key = e.which;     //firefox
        if(key == 13)
            return false;
        else
            return true;
    }
    var arrayDataFilter;
    var arrayDataFilterFunctions;
    var dataSourceTemp = [];
    var dataSourceFitler = [];
    var dataMassUploadProfiles = {
        areacodes: <%=strData.toString()%>};
    var massUploadProfilesResult = makeMassUploadProfilesTable();
    var valuesAuto=[];
    var vendorAdd = "";
    var flagAdd = false;
    var indexRow = 0;
    var recordInPage=0;
    var oldFunctionId = '';
    var oldVendor = '';
    var idAdd;
    var idDelete;
    var idOldEdit;
    var isFiltter = false;

    function getVendorAutoFilter(query)
    {
        var temp =  decodeURIComponent(query);
        reslts = [];
        for (var i = 0; i < arrayDataFilter.length; i++) {
            var t1 = arrayDataFilter[i];
            var t2 = temp;
            var t1Up = t1.toUpperCase();
            var t2Up = t2.toUpperCase();
            if (t1Up.indexOf(t2Up) > -1)
            {
                reslts.push(arrayDataFilter[i]);
            }
        }
        return reslts;
    };
    function getFunctionAutoFilter(query)
    {
        var temp =  decodeURIComponent(query);
        reslts = [];
        for (var i = 0; i < arrayDataFilterFunctions.length; i++) {
            var t1 = arrayDataFilterFunctions[i];
            var t2 = temp;
            var t1Up = t1.toUpperCase();
            var t2Up = t2.toUpperCase();
            if (t1Up.indexOf(t2Up) > -1)
            {
                reslts.push(arrayDataFilterFunctions[i]);
            }
        }
        return reslts;
    };
    function setAutoCompleteForFilter(idContainDiv,idInput)
    {
        var oACDS = new YAHOO.widget.DS_JSFunction(getVendorAutoFilter);
        // Instantiate first AutoComplete
        var oAutoComp = new YAHOO.widget.AutoComplete(idInput,idContainDiv,oACDS);
        oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
        // this.oAutoComp.typeAhead = true;
        oAutoComp.queryQuestionMark = false;
        oAutoComp.forceSelection = false;
        oAutoComp.autoHighlight = false;
        oAutoComp.maxResultsDisplayed = 100;
        oAutoComp.resultTypeList = false;
        oAutoComp.useIFrame = true;
        oAutoComp.minQueryLength=0;
        var scale =0;
        oAutoComp.doBeforeExpandContainer = function() {
            var Dom = YAHOO.util.Dom;
            Dom.setXY(idContainDiv, [Dom.getX(idInput)- scale, Dom.getY(idInput) + Dom.get(idInput).offsetHeight] );
            return true;
        }

        oAutoComp.generateRequest = function(sQuery) {
            return sQuery;
        };

        oAutoComp.textboxKeyEvent.subscribe(
            function(nKeycode){
                var oSelf = this;
                oSelf.forceSelection = false;
            });

        oAutoComp.textboxFocusEvent.subscribe(
            function(){
                var oSelf = this;
                oSelf.forceSelection = false;
            });
        var itemSelectHandler = function(sType, aArgs) {
            document.getElementById(idInput).value =  html_entity_decode(document.getElementById(idInput).value);
            clearTimeout(filterTimeout);
            setTimeout(updateFilter,600);
        };

        oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
        document.getElementById(idInput+"Image").onclick = function() {
            document.getElementById(idContainDiv).style.display = '';
        };

        var temp = oAutoComp;
        var sendEmptyQuery = function(t1, t2) {
            document.getElementById(idContainDiv).style.display = '';
            setTimeout(function() {t2.sendQuery("");}, 0);
            document.getElementById(idInput).focus();
        };

        YAHOO.util.Event.addListener(YAHOO.util.Dom.get(idInput+"Image"), "click", sendEmptyQuery,temp);
    }
    function setAutoCompleteForFunctionFilter(idContainDiv,idInput)
    {
        var oACDS = new YAHOO.widget.DS_JSFunction(getFunctionAutoFilter);
        // Instantiate first AutoComplete
        var oAutoComp = new YAHOO.widget.AutoComplete(idInput,idContainDiv,oACDS);
        oAutoComp.prehighlightClassName = "yui-ac-prehighlight";
        // this.oAutoComp.typeAhead = true;
        oAutoComp.queryQuestionMark = false;
        oAutoComp.forceSelection = false;
        oAutoComp.autoHighlight = false;
        oAutoComp.maxResultsDisplayed = 100;
        oAutoComp.resultTypeList = false;
        oAutoComp.useIFrame = true;
        oAutoComp.minQueryLength=0;
        var scale =0;
        oAutoComp.doBeforeExpandContainer = function() {
            var Dom = YAHOO.util.Dom;
            Dom.setXY(idContainDiv, [Dom.getX(idInput)- scale, Dom.getY(idInput) + Dom.get(idInput).offsetHeight] );
            return true;
        }

        oAutoComp.generateRequest = function(sQuery) {
            return sQuery;
        };

        oAutoComp.textboxKeyEvent.subscribe(
            function(nKeycode){
                var oSelf = this;
                oSelf.forceSelection = false;
            });

        oAutoComp.textboxFocusEvent.subscribe(
            function(){
                var oSelf = this;
                oSelf.forceSelection = false;
            });
        var itemSelectHandler = function(sType, aArgs) {
            document.getElementById(idInput).value =  html_entity_decode(document.getElementById(idInput).value);
            clearTimeout(filterTimeout);
            setTimeout(updateFilter,600);
        };

        oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);
        document.getElementById(idInput+"Image").onclick = function() {
            document.getElementById(idContainDiv).style.display = '';
        };

        var temp = oAutoComp;
        var sendEmptyQuery = function(t1, t2) {
            document.getElementById(idContainDiv).style.display = '';
            setTimeout(function() {t2.sendQuery("");}, 0);
            document.getElementById(idInput).focus();
        };

        YAHOO.util.Event.addListener(YAHOO.util.Dom.get(idInput+"Image"), "click", sendEmptyQuery,temp);
    }
    function setResultFilter()
    {
        var filterValues = "";
        //set filter values
        //2 field vendor and sellingUPC contain on all tab
        //get obj filter
        var arrFilterObj = new Array();
        arrFilterObj.push("vendorFilter");
        //arrFilterObj.push("sbtFilter");
        arrFilterObj.push("functionNamesFilter");
        arrFilterObj.push("dsdFilter");
        arrFilterObj.push("whsFilter");
        arrFilterObj.push("autoppproveFilter");
        if(arrFilterObj != null){
            for(var i = 0 ;i< arrFilterObj.length;i++)
            {
                if(document.getElementById(arrFilterObj[i])){
                    filterValues = filterValues + arrFilterObj[i]+":"+ document.getElementById(arrFilterObj[i]).value +"___";
                }
            }
        }
        if(filterValues!=""){
            filterValues = filterValues.substring(0,filterValues.lastIndexOf("___"));
        }
        document.getElementById('filterValues').value = filterValues;
    }
    function setFilterValue(){
        var filterValues = document.getElementById('filterValues').value;
        if(filterValues != "")
        {
            var arrFilterObj = new Array();
            arrFilterObj.push("vendorFilter");
            //arrFilterObj.push("sbtFilter");
            arrFilterObj.push("functionNamesFilter");
            arrFilterObj.push("dsdFilter");
            arrFilterObj.push("whsFilter");
            arrFilterObj.push("autoppproveFilter");
            if(arrFilterObj != null){
                var arrValueTab = filterValues.split("___");
                var item;
                for(var i = 0 ;i< arrFilterObj.length;i++)
                {
                    if(arrValueTab[i]!=''){
                        item = arrValueTab[i].split(":");
                        if(item[0] == arrFilterObj[i])
                        {
                            if(document.getElementById(arrFilterObj[i]) && item[1]!='')
                            {
                                document.getElementById(arrFilterObj[i]).value = item[1];
                            }
                        }
                    }
                }
                doBeforeFilter();
            }
        }
    }

    function editRowContent(element){
        if(document.getElementById('errors')){
            document.getElementById('errors').innerHTML = '';
        }

        var elements = YAHOO.util.Dom.getElementsByClassName('yui-dt-bd')[0];
        var flagDuplicate = false;
        var scrollTopValue = 0;
        if(elements)
            scrollTopValue = elements.scrollTop;
        var oRS = massUploadProfilesResult.oDT;
        var lengthDatatable = oRS.getRecordSet().getLength();
        var cur = oRS.get('paginator').getState();
        var totalRecords = cur.totalRecords;
        recordInPage = cur.rowsPerPage * cur.page;
        //  if(document.getElementById('errors'))
        //	document.getElementById('errors').innerHTML='';
        if(vendorAdd == "" && flagAdd){
            alert('Vendor must be not empty. Please select vendor.');
            return false;
        } else {
            for(var i=0; i<lengthDatatable; i++) {
                var oRec = oRS.getRecord(i);
                if(flagAdd && oRec.getData('AddStatus') != '1' && oRec.getData('Id') == idAdd){
                    alert('Rules duplicate. Please select other vendor or function.');
                    flagDuplicate = true;
                    //oRec.setData('ModifyRow','0');
                    //YAHOO.util.Dom.removeClass(oRS.getTrEl(oRec), 'mark');
                    return false;

                } else if(idOldEdit != oRec.getData('Id') && oldFunctionId == oRec.getData('FunctionId') && oldVendor == oRec.getData('Vendor')){
                    alert('Rules duplicate. Please select other vendor or function.');
                    //oRec.setData('ModifyRow','0');
                    //YAHOO.util.Dom.removeClass(oRS.getTrEl(oRec), 'mark');
                    flagDuplicate = true;
                    return false;
                }
                //oRec.setData('EditStatus','0');
                oRec.setData('AddStatus','0');
                YAHOO.util.Dom.removeClass(oRec, 'yui-dt-selected');
            }
            if(!flagDuplicate){
                for(var i=0; i<lengthDatatable; i++) {
                    var oRec = oRS.getRecord(i);
                    if(element.id == oRec.getData('Id')){
                        oRec.setData('EditStatus','1');
                        if(dataSourceTemp!=null){
                            dataSourceTemp[i].EditStatus = '1';
                        }
                        oRS.render();
                        oRS.selectRow(oRec);
                        if(elements)
                            elements.scrollTop = scrollTopValue;
                        document.getElementById("saveDiv").style.display = "block";
                        document.getElementById("revertDiv").style.display = "block";
                        document.getElementById("deleteDiv").style.display = "none";
                        document.getElementById("addDiv").style.display = "none";
                        flagAdd = false;
                        break;
                    }
                }
            }
        }
    }
    function makeMassUploadProfilesTable() {
        var formatAutocomplete = function(elCell, oRecord, oColumn, sData) {
            var vendorName = oRecord.getData("Vendor");
            var addStatus = oRecord.getData("AddStatus");
            if(addStatus == '1'){
                elCell.innerHTML = "<div class='myAutoComplete' id='myAutoComplete"+oRecord.getData("Id")+"'><input type='text' id='myInput"+oRecord.getData("Id")+"' value='"+convertHtml(vendorName)+"' maxlength='30' onKeyPress='return disableEnterKey(event)' style='TEXT-TRANSFORM\: uppercase; position: relative;width:195;'\ /><div id='myContainer"+oRecord.getData("Id")+"'></div></div>";
            }	else {
                elCell.innerHTML =vendorName;
            }
        };
        var formatComboBoxWHS = function(elCell, oRecord, oColumn, sData){
            var selected = oRecord.getData("WHS");
            var editStatus = oRecord.getData("EditStatus");
            var checked = '';
            if(selected == 'true'){
                checked = "checked='checked'";
            }
            var htmlCode = "<input type='checkbox' id='whs_" + oRecord.getData("Id") +"' name='whs_" + oRecord.getData("Id")+"' onclick='saveValueEditableFieldToDataTable(this);'" ;
            if(editStatus!='1'){
                htmlCode +="disabled='disabled'";
            } else if(oRecord.getData('chanelBoth')== 'false'){
                htmlCode +="disabled='disabled'";
            }
            htmlCode += checked;
            htmlCode +="/input>";
            elCell.innerHTML = htmlCode;
        };
        var formatComboBoxDSD = function(elCell, oRecord, oColumn, sData){
            var selected = oRecord.getData("DSD");
            var editStatus = oRecord.getData("EditStatus");
            var checked = '';
            if(selected == 'true'){
                checked = "checked='checked'";
            }
            var htmlCode = "<input type='checkbox' id='dsd_" + oRecord.getData("Id") +"' name='dsd_" + oRecord.getData("Id")+"' onclick='saveValueEditableFieldToDataTable(this);'";
            if(editStatus!='1'){
                htmlCode +="disabled='disabled'";
            }else if(oRecord.getData('chanelBoth')== 'false'){
                htmlCode +="disabled='disabled'";
            }
            htmlCode += checked;
            htmlCode +="/input>";
            elCell.innerHTML = htmlCode;
        };

        var formatComboBoxAutoApprove = function(elCell, oRecord, oColumn, sData){
            var editStatus = oRecord.getData("EditStatus");
            if(editStatus == '1'){
                var selectObject;
                selectObject = "<select id='autoApprove_" + oRecord.getData("Id") +"' name='autoApprove_" + oRecord.getData("Id") +"' style='width: 70px;' onchange='saveValueEditableFieldToDataTable(this)'>";
                if(oRecord.getData("autoApprove") == ''){
                    selectObject += "<option value='0' selected='selected'>--Select--</option>";
                } else {
                    selectObject += "<option value='0'>--Select--</option>";
                }
                if(oRecord.getData("autoApprove") == 'Y'){
                    selectObject += "<option value='1' selected='selected'>Y</option>";
                } else {
                    selectObject += "<option value='1'>Y</option>";
                }
                if(oRecord.getData("autoApprove") == 'N'){
                    selectObject += "<option value='2' selected='selected'>N</option>";
                } else {
                    selectObject += "<option value='2'>N</option>";
                }
                selectObject +=	"</select>";
                elCell.innerHTML = selectObject;
            } else {
                elCell.innerHTML = oRecord.getData("autoApprove");
            }
        };
        var formatButtonEdit = function(elCell, oRecord, oColumn, sData){
            var editStatus = oRecord.getData("EditStatus");
            var vendor = oRecord.getData("Vendor");
            if(editStatus=='1' ||vendor == ''){
                elCell.innerHTML='';
            } else {
                elCell.innerHTML = "<input type='button' id='" + oRecord.getData("Id") +"' value='Edit' onclick='return editRowContent(this);' style='width: 60px;'/>";
            }
        };
        var formatComboBox = function(elCell, oRecord, oColumn, sData) {
            var editStatus = oRecord.getData("EditStatus");
            if(editStatus == '1'){
                var selectObject;
                selectObject = "<select id='function_" + oRecord.getData("Id") +"' name='function_" + oRecord.getData("Id") +"' style='width: 150px;' onchange='saveValueEditableFieldToDataTable(this)'>";
                if(oRecord.getData("FunctionId") == '1'){
                    selectObject += "<option value='1' selected='selected'>Add New Products</option>";
                } else {
                    selectObject += "<option value='1'>Add New Products</option>";
                }
                if(oRecord.getData("FunctionId") == '2'){
                    selectObject += "<option value='2' selected='selected'>Discontinue/Deletes</option>";
                } else {
                    selectObject += "<option value='2'>Discontinue/Deletes</option>";
                }
                selectObject +=	"</select>";
                elCell.innerHTML = selectObject;
            } else {
                elCell.innerHTML = oRecord.getData("FunctionNames");
            }
        };
        //  var formatSBT = function(elCell, oRecord, oColumn, sData) {
        //   elCell.innerHTML = oRecord.getData("SBT");
        //};
        function sortCompare(a, b, sortBy, field, fieldReturnIfEqual, isNumber)
        {
            // Deal with empty values
            if(!YAHOO.lang.isValue(a)) {
                return (!YAHOO.lang.isValue(b)) ? 0 : 1;
            }
            else if(!YAHOO.lang.isValue(b)) {
                return -1;
            }
            var comp = YAHOO.util.Sort.compare;
            var compState;
            // First compare by state
            if(isNumber)
                compState = comp(eval(a.getData(field) !== ""?a.getData(field):"0"), eval(b.getData(field)!== ""?b.getData(field):"0"), sortBy);
            else
                compState = comp(a.getData(field), b.getData(field), sortBy);


            // If states are equal, then compare by areacode
            return (compState !== 0) ? compState : comp(a.getData(fieldReturnIfEqual), b.getData(fieldReturnIfEqual), sortBy);
        }

        var sortVendor = function(a, b, desc) {
            return sortCompare(a, b, desc, "VendorId", "FunctionId",true);
        };
        // Format color for row is edited
        var myRowFormatter = function(elTr, oRecord) {
            if (oRecord.getData('ModifyRow') == "1") {
                YAHOO.util.Dom.addClass(elTr, 'mark');
            }
            return true;
        };
        var myColumnDefs = [
            {key:"checkBoxs",    label:"All", minWidth: 30,
                children: [{key:"checkBox", label:"<input type='checkbox' id='SelectAll'/>",sortable:false, resizeable:false}]},
            {key:"Vendor",    label:"Vendor", width: 350,minWidth: 350,formatter:formatAutocomplete,sortable:true,sortOptions:{sortFunction:sortVendor},
                children: [{key:"vendor", label:"<div id ='vendorDiv' class ='myAutoComplete'><input type='text' id='vendorFilter' name='divFilter' size='25' maxlength='50' style='TEXT-TRANSFORM\: uppercase; position: relative;'><img src='${image}' alt='' width='20' id='vendorFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'><div id='myContainerVendorFilter'></div></div>",sortable:false, resizeable:false}]},
            {key:"Id",    label:"Id"},
            {key:"FunctionId",    label:""},
            {key:"ModifyRow",    label:""},
            {key:"FunctionNames",    label:"Function", width: 150,minWidth: 150,formatter:formatComboBox,sortable:true,
                children: [{key:"functionNames", label:"<div id ='functionNamesDiv' class ='myAutoComplete'><input type='text' id='functionNamesFilter' name='divFilter' size='25' maxlength='50' style='position: relative;'><img src='${image}' alt='' width='20' id='functionNamesFilterImage' height='20' hspace='5' style='position:absolute;top: +0px;right:-12px;'><div id='myContainerFunctionNamesFilter'></div></div>",sortable:false, resizeable:false}]},
            {key:"EditStatus",    label:""},
            {key:"VendorId",    label:""},
            {key:"DSD",    label:"DSD", width: 80,minWidth: 80,formatter:formatComboBoxDSD,className: "align-center",
                children: [{key:"dsd", label:"<div id ='dsdDiv'><select id='dsdFilter' name='divFilter' style='width: 70px;'><option value='0'>--Select--</option><option value='1'>Y</option><option value='2'>N</option></select>&nbsp;</div>",sortable:false, resizeable:false}]},
            {key:"AddStatus",    label:""},
            {key:"WHS",    label:"WHS", width: 80,minWidth: 80,formatter:formatComboBoxWHS,className: "align-center",
                children: [{key:"whs", label:"<div id ='whsDiv'><select id='whsFilter' name='divFilter' style='width: 70px;'><option value='0'>--Select--</option><option value='1'>Y</option><option value='2'>N</option></select>&nbsp;</div>",sortable:false, resizeable:false}]},
            {key:"AddRow",    label:""},
            {key:"chanelBoth",    label:""},
            {key:"autoApprove",    label:"Auto Approve", width: 80,minWidth: 80,formatter:formatComboBoxAutoApprove,className: "align-center",
                children: [{key:"autoppprove", label:"<div id ='autoppproveDiv'><select id='autoppproveFilter' name='divFilter' style='width: 70px;'><option value='0'>--Select--</option><option value='1'>Y</option><option value='2'>N</option></select>&nbsp;</div>",sortable:false, resizeable:false}]},
            {key:"apTypCd",    label:""},
            {key:"DeleteStatus",    label:""},
            {key:"autoApproveId",    label:""},
            {key:"buttonEdit", label:"",width: 80,minWidth: 60, formatter:formatButtonEdit,className: "align-center",
                children: [{key:"buttonedit", label:"<table class='tbl-filter'><tr><td class='td-filter'><input type='button' id='filterStatus' value='Hide'><input type='button' id='clearFilter' value='Clear'></td></tr></table>",sortable:false, resizeable:false}]}
        ];
        var myDataSource = new YAHOO.util.DataSource(dataMassUploadProfiles.areacodes);
        myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
        myDataSource.responseSchema = {
            fields: [
                {key:"Vendor"},
                {key:"Id"},
                {key:"FunctionId"},
                {key:"FunctionNames"},
                {key:"EditStatus"},
                {key:"AddStatus"},
                {key:"ModifyRow"},
                {key:"AddRow"},
                {key:"DSD"},
                {key:"VendorId"},
                {key:"WHS"},
                {key:"chanelBoth"},
                {key:"autoApprove"},
                {key:"autoApproveId"},
                {key:"apTypCd"},
                {key:"DeleteStatus"},
                {key:"checkBox"}
            ]
        };
        myDataSource.doBeforeCallback = function (req,raw,res,cb) {
            // This is the filter function
            var data     = res.results || [],
                filtered = [],
                i,l;
            if (dataSourceTemp.length ==0)
                dataSourceTemp = data;
            dataSourceFitler = dataSourceTemp;
            var i = 0;
            var functionName;
            //var sbt;
            var dsd;
            var whs;
            var autoApprove;
            if (req) {
                var pattern = new RegExp(req);
                dataSourceFitler = [];
                var temp="";
                for (i = 0, l = dataSourceTemp.length; i < l; ++i)
                {
                    //temp="";
                    //if(dataSourceTemp[i].SBT.toUpperCase() == 'N'){
                    //	sbt = '2';
                    //} else {
                    //	sbt = '1';
                    //}
                    //if(dataSourceTemp[i].FunctionNames.toUpperCase() == 'ADD NEW PRODUCTS'){
                    //	functionName = '1';
                    //} else {
                    //	functionName = '2';
                    //}
                    if(dataSourceTemp[i].DSD.toUpperCase() == 'TRUE'){
                        dsd = '1';
                    } else {
                        dsd = '2';
                    }
                    if(dataSourceTemp[i].WHS.toUpperCase() == 'TRUE'){
                        whs = '1';
                    } else {
                        whs = '2';
                    }
                    //if(dataSourceTemp[i].autoApprove.toUpperCase() == 'TRUE'){
                    //	autoApprove = '1';
                    //} else {
                    //	autoApprove = '2';
                    //}
                    temp=convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].Vendor.toUpperCase()))+"__"+convertFromIrToRegularPattern(convertSpecialChars(dataSourceTemp[i].FunctionNames.toUpperCase()))+"__"+dsd.toUpperCase()+"__"+whs.toUpperCase()+"__"+dataSourceTemp[i].autoApproveId;
                    if(pattern.test(temp))
                    {
                        filtered.push(dataSourceTemp[i]);
                        dataSourceFitler.push(dataSourceTemp[i]);
                    }
                }
                if(YAHOO.util.Dom.get('SelectAll').checked)
                    YAHOO.util.Dom.get('SelectAll').checked = false;
                res.results = filtered;
                //set style
                var nodes = YAHOO.util.Selector.query('td.yui-dt-empty div.yui-dt-liner');
                if(filtered.length >0){
                    if(nodes != null)
                        YAHOO.util.Dom.setStyle(nodes, 'display', 'none');
                }
                else
                {
                    if(nodes != null)
                        YAHOO.util.Dom.setStyle(nodes, 'display', '');
                }
            }
            return res;
        };
        var rowsPerPage = ${ManageEDICandidate.currentRecord};
        var currentPage = ${ManageEDICandidate.currentPage};
		document.getElementById('filterValues').value = '${ManageEDICandidate.filterValues}';

        var myConfigs = {
            paginator: new YAHOO.widget.Paginator({
                rowsPerPage : rowsPerPage,
                page : currentPage,
                template: YAHOO.widget.Paginator.TEMPLATE_ROWS_PER_PAGE,
                rowsPerPageOptions: [10,25,50,100],
                pageLinks: 5,
                containers: 'pag'
            }),
            height:"405px",
            formatRow: myRowFormatter,
            draggableColumns:false,
            selectionMode:"single"
        }
        var myDataTable = new YAHOO.widget.ScrollingDataTable("tblMassUploadProfiles", myColumnDefs, myDataSource, myConfigs);
        //hiden column
        //myDataTable.hideColumn(myDataTable.getColumn("Id"));
        myDataTable.hideColumn(myDataTable.getColumn("FunctionId"));
        myDataTable.hideColumn(myDataTable.getColumn("EditStatus"));
        myDataTable.hideColumn(myDataTable.getColumn("ModifyRow"));
        myDataTable.hideColumn(myDataTable.getColumn("AddStatus"));
        myDataTable.hideColumn(myDataTable.getColumn("AddRow"));
        myDataTable.hideColumn(myDataTable.getColumn("Id"));
        myDataTable.hideColumn(myDataTable.getColumn("chanelBoth"));
        myDataTable.hideColumn(myDataTable.getColumn("apTypCd"));
        myDataTable.hideColumn(myDataTable.getColumn("VendorId"));
        myDataTable.hideColumn(myDataTable.getColumn("autoApproveId"));
        myDataTable.hideColumn(myDataTable.getColumn("DeleteStatus"));
        filterTimeout = null;
        updateFilter  = function ()
        {
            filterTimeout = null;
            var pattent = gePattern();
            if(pattent!=null && (pattent !='.*__.*__.*__.*__.*'||isFiltter)){
                isFiltter = false;
                myDataSource.sendRequest(pattent,{
                    success : myDataTable.onDataReturnInitializeTable,
                    failure : myDataTable.onDataReturnInitializeTable,
                    scope   : myDataTable,
                    argument: pattent
                });
            }
        }

        myDataTable.subscribe("postRenderEvent", function(){
            var oRS = massUploadProfilesResult.oDT;
            var arrItemFilter = new Array();
            for (var i= 0; i< myDataTable.getRecordSet().getLength();i++){
                var oRec = myDataTable.getRecord(i);
                var idWorkRq = oRec.getData("Id");
                arrItemFilter.push(idWorkRq);
                if(oRec.getData('AddStatus') == '1'){
                    setZindex(oRec.getData('Id'),indexRow%recordInPage,recordInPage);
                    document.getElementById("myAutoComplete"+oRec.getData("Id")).parentNode.parentNode.parentNode.style.overflow = 'visible';
                    setAutoComplete(oRec.getData('Id'));
                }
            }
            if(myDataTable.getRecordSet().getLength() > 0){
                setCheckAllFlag(arrItemFilter);
            }
        });
        myDataTable.subscribe("checkboxClickEvent", function(oArgs){
            var elCheckbox = oArgs.target;
            var oRecord = this.getRecord(elCheckbox);
            var column = this.getColumn(elCheckbox);
            var idWorkRqOfCheckBox = oRecord.getData("Id");
            //checked all items have the same Ps_work_id
            var arrItemFilter = new Array();
			var idCheckBox = elCheckbox.id;
			if(idCheckBox.indexOf("ckb") != -1){
                for (var i= 0; i< this.getRecordSet().getLength();i++){
                    var oRec = this.getRecordSet().getRecord(i);
                    var idWorkRq = oRec.getData("Id");
                    arrItemFilter.push(idWorkRq);
                    if(idWorkRq == idWorkRqOfCheckBox){
                        if(elCheckbox.checked){
                            oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("Id") + " name=ckb_"+ oRec.getData("Id") +" checked=checked class=yui-dt-checkbox />");
                            oRec.setData("DeleteStatus","1");
                        }
                        else {
                            oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("Id") +" name=ckb_"+ oRec.getData("Id") +" class=yui-dt-checkbox />");
                            oRec.setData("DeleteStatus","0");
                            //unchecked if SelectAll is checked
                            if(YAHOO.util.Dom.get('SelectAll').checked)
                                YAHOO.util.Dom.get('SelectAll').checked = false;
                        }
                    }
                }

                //update datatable temp (used for filter)
                if(elCheckbox.checked)
                    saveDataSourceTempWhenCheck(idWorkRqOfCheckBox, true, false);
                else
                    saveDataSourceTempWhenCheck(idWorkRqOfCheckBox, false, false);

                setCheckAllFlag(arrItemFilter);
			}

            //changeRequest =true;
            //this.render();
            //var checkBoxs = document.getElementsByName("ckb_" + idWorkRqOfCheckBox);
            //if(checkBoxs != null){
            //	for(i=0;i<checkBoxs.length;i++)
            //	{
            //	if(elCheckbox.checked)
            //		checkBoxs[i].checked = true;
            //	else
            //	checkBoxs[i].checked = false;
            //}
            //}
        });

        myDataTable.on('theadCellClickEvent', function (oArgs) {
            var target = oArgs.target,
                column = this.getColumn(target),
                actualTarget = YAHOO.util.Event.getTarget(oArgs.event),
                check = actualTarget.checked;

            if (column.key == 'checkBox') {
                if(typeof check != 'undefined'){
                    var oRS = myDataTable.getRecordSet();
                    var arrItemFilter = new Array();
                    for(var i=0; i<oRS.getLength(); i++) {
                        var oRec = oRS.getRecord(i);
                        var idWorkRq = oRec.getData("Id");
                        arrItemFilter.push(idWorkRq);
                        if(check)
                        {
                            oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("Id") + " name=ckb_"+ oRec.getData("Id").split('-')[0] +" checked=checked class=yui-dt-checkbox />");
                            oRec.setData("DeleteStatus","1");
                        }
                        else
                        {
                            oRec.setData("DeleteStatus","0");
                            oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("Id") +" name=ckb_"+ oRec.getData("Id").split('-')[0] +" class=yui-dt-checkbox />");
                        }
                    }

                    //update datatable temp (used for filter)
                    if(check)
                        saveDataSourceTempWhenCheck(arrItemFilter, true, true);
                    else
                        saveDataSourceTempWhenCheck(arrItemFilter, false, true);
                    this.render();
                }
            }

        });
        // Subscribe to events for row selection
        myDataTable.subscribe("rowMouseoverEvent", myDataTable.onEventHighlightRow);
        myDataTable.subscribe("rowMouseoutEvent", myDataTable.onEventUnhighlightRow);
        myDataTable.subscribe("rowClickEvent", myDataTable.onEventSelectRow);
        myDataTable.subscribe("rowClickEvent", function (oArgs) {
            var elTarget = oArgs.target;
            var oRecord = this.getRecord(elTarget);
            idDelete = oRecord.getData("Id");
        });
        myDataTable.selectRow(myDataTable.getTrEl(0));
        var recordID = myDataTable.getSelectedRows()[0],
            record = myDataTable.getRecord(recordID);
        if(record !== null){
            idDelete = record.getData("Id");
        }
        // Programmatically select the first row
        //myDataTable.subscribe(myDataTable.getTrEl(0));
        // Selects the first row on the page

        // Programmatically bring focus to the instance so arrow selection works immediately
        //myDataTable.focus();

        //get data of each field to array
        arrayDataFilter = [];
        arrayDataFilterFunctions = [];
        setDataSourceForAutocompleteFilter();
        setDataSourceForAutocompleteFunctionFilter();
        setAutoCompleteForFilter("myContainerVendorFilter","vendorFilter");
        setAutoCompleteForFunctionFilter("myContainerFunctionNamesFilter","functionNamesFilter");
        document.getElementById("vendorFilter").parentNode.parentNode.parentNode.style.overflow = 'visible';
        document.getElementById("functionNamesFilter").parentNode.parentNode.parentNode.style.overflow = 'visible';
        //filtering
        YAHOO.util.Event.on('vendorFilter','change',function (e) {
            isFiltter = true;
            doBeforeFilter(e);
        });

        //	YAHOO.util.Event.on('sbtFilter','change',function (e) {
        //	isFiltter = true;
        //doBeforeFilter(e);
        //});
        YAHOO.util.Event.on('functionNamesFilter','change',function (e) {
            isFiltter = true;
            doBeforeFilter(e);
        });
        YAHOO.util.Event.on('dsdFilter','change',function (e) {
            isFiltter = true;
            doBeforeFilter(e);
        });
        YAHOO.util.Event.on('whsFilter','change',function (e) {
            isFiltter = true;
            doBeforeFilter(e);
        });
        YAHOO.util.Event.on('autoppproveFilter','change',function (e) {
            isFiltter = true;
            doBeforeFilter(e);
        });

        YAHOO.util.Event.on('clearFilter','click',function (e) {
            var pattent = gePattern();
            if(pattent!=null && pattent !='.*__.*__.*__.*__.*'){
                setResultFilter();
                //dataSourceTemp = [];
                flagAdd = false;
                idDelete = "";
                oldVendor = "";
                oldFunctionId = "";
                var myDataSource = massUploadProfilesResult.oDS;
                var myDataTable = massUploadProfilesResult.oDT;
                document.getElementById('filterValues').value = '';
                document.getElementById("vendorFilter").value='';
                //document.getElementById("sbtFilter").options[0].selected = true;
                //document.getElementById("functionNamesFilter").options[0].selected = true;
                document.getElementById("functionNamesFilter").value='';
                document.getElementById("dsdFilter").options[0].selected = true;
                document.getElementById("whsFilter").options[0].selected = true;
                document.getElementById("autoppproveFilter").options[0].selected = true;
                var currentPage = myDataTable.get('paginator').getState().page;
                var currentRow = myDataTable.get('paginator').getState().rowsPerPage;

                if(dataMassUploadProfiles != null){
                    //reset data source filter
                    filterTimeout = null;
                    var pattent = "\.*__\.*__\.*__\.*__\.*";
                    myDataSource.sendRequest(pattent,{
                        success : myDataTable.onDataReturnInitializeTable,
                        failure : myDataTable.onDataReturnInitializeTable,
                        scope   : myDataTable,
                        argument: pattent
                    });
                    //set current page is selected (before click reset button)
                    myDataTable.get('paginator').setPage(parseInt(currentPage));
                    myDataTable.get('paginator').setRowsPerPage(parseInt(currentRow));
                }
                if(YAHOO.util.Dom.get('SelectAll').checked)
                    YAHOO.util.Dom.get('SelectAll').checked = false;
                setFilterValue();
                // document.getElementById("saveDiv").style.display = "none";
                //document.getElementById("revertDiv").style.display = "none";
                //document.getElementById("deleteDiv").style.display = "block";
                //document.getElementById("addDiv").style.display = "block";
            }
        });
        YAHOO.util.Event.on('filterStatus','click',  function(e){
            hideShowFilter(e);
        });
        setFilterValue();
        //set page is selected
        myDataTable.get('paginator').setPage(parseInt("${ManageEDICandidate.currentPage}"));
        //set per row is selected
        myDataTable.get('paginator').setRowsPerPage(parseInt("${ManageEDICandidate.currentRecord}"));
        return {
            oDS: myDataSource,
            oDT: myDataTable
        };
    };
    function doBeforeFilter(e)
    {
        idDelete = "";
        clearTimeout(filterTimeout);
        setTimeout(updateFilter,600);
    }
    function setAutoComplete(id) {
        <c:url value="/protected/cps/add/manage/modules/search/backend/ajaxSearch?action=appLocationSearch&showId=true&highlightMatch=true&maxResults=100000&searchOnId=false&uniqueId=&${_csrf.parameterName}=${_csrf.token}&" var="jsonSearch"></c:url>

        var oACDS = new YAHOO.util.XHRDataSource("${jsonSearch}");

        // Set the responseType
        oACDS.responseType = YAHOO.util.XHRDataSource.TYPE_JSON;
        // Define the schema of the delimited results
        oACDS.responseSchema = {
            resultsList: "resultList",
            fields: ["name", "id","markup"]
        };
        // Instantiate AutoCompletes
        var oConfigs = {
            prehighlightClassName: "yui-ac-prehighlight",
            useShadow: true,
            queryDelay: 2,
            minQueryLength: 0
        }
        // Instantiate first AutoComplete
        var oAutoComp = new YAHOO.widget.AutoComplete("myInput"+id, "myContainer"+id, oACDS,oConfigs);
        oAutoComp.queryQuestionMark = false;
        oAutoComp.forceSelection = false;
        oAutoComp.autoHighlight = true;
        oAutoComp.maxResultsDisplayed = 100;
        oAutoComp.resultTypeList = false;
        oAutoComp.doBeforeExpandContainer = function(elTextbox , elContainer , sQuery , aResults) {
            var Dom = YAHOO.util.Dom;
            Dom.setXY("myContainer"+id, [Dom.getX("myInput"+id), Dom.getY("myInput"+id) + Dom.get("myInput"+id).offsetHeight] );
            return true;
        }
        var curVl = YAHOO.util.Dom.get("myInput"+id).value;
        var itemSelectHandler = function(sType, aArgs) {
            var aData = aArgs[2];
            //var arrTemp = getListRowIds(id);
            showProgress();
            ManageEDIDWR.appLocationInfo(aData.id,
                {
                    callback:function(data) {
                        hideProgress();
                        //YAHOO.util.Dom.get("myInput"+id).value = html_entity_decode(aData.name);
                        //YAHOO.util.Dom.get("myInput"+id).innerHTML = html_entity_decode(aData.name);
                        var tempData=data.appData;
                        var oRS = massUploadProfilesResult.oDT;
                        var idTemp =tempData.apNbr;
                        var cur = oRS.get('paginator').getState();
                        var totalRecords = cur.totalRecords;
                        recordInPage = cur.rowsPerPage * cur.page;
                        var idcheck = idTemp;
                        var flagError = false;
                        var lengthDataTable =  oRS.getRecordSet().getLength();
                        var indexAdd = 	lengthDataTable -1;
                        for (var i= 0; i< lengthDataTable;i++){
                            var oRec = oRS.getRecord(i);
                            if(oRec.getData('AddStatus') == '1'){
                                idTemp +='-'+oRec.getData('FunctionId')+'-addNew';
                                if(tempData.dsdFlag == 'true'){
                                    oRec.setData('DSD', 'true');
                                    dataSourceTemp[indexAdd].DSD = 'true';
                                } else {
                                    oRec.setData('DSD', 'false');
                                    dataSourceTemp[indexAdd].DSD = 'false';
                                }
                                if(tempData.whsFlag == 'true') {
                                    oRec.setData('WHS', 'true');
                                    dataSourceTemp[indexAdd].WHS = 'true';
                                } else {
                                    oRec.setData('WHS', 'false');
                                    dataSourceTemp[indexAdd].WHS = 'false';
                                }
                                oRec.setData('Id', idTemp);
                                dataSourceTemp[indexAdd].Id = idTemp;
                                oRec.setData("checkBox","<input type=checkbox id=ckb_"+ oRec.getData("Id") +" name=ckb_"+ oRec.getData("Id") +" class=yui-dt-checkbox />");
                                //unchecked if SelectAll is checked
                                if(YAHOO.util.Dom.get('SelectAll').checked)
                                    YAHOO.util.Dom.get('SelectAll').checked = false;
                                dataSourceTemp[indexAdd].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[indexAdd].Id +" name=ckb_"+ dataSourceTemp[indexAdd].Id +" checked=checked class=yui-dt-checkbox />";
                                oRec.setData('Vendor', tempData.apNbr + " " + tempData.rmitCoNm);
                                dataSourceTemp[indexAdd].Vendor = tempData.apNbr + " " + tempData.rmitCoNm;
                                oRec.setData('apTypCd', tempData.apTypCd);
                                dataSourceTemp[indexAdd].apTypCd = tempData.apTypCd;
                                oRec.setData('chanelBoth', tempData.bothFlag);
                                dataSourceTemp[indexAdd].chanelBoth = tempData.bothFlag;
                                vendorAdd =   oRec.getData('Vendor');
                                //oRec.setData('SBT', tempData.sbtFlag);
                                //dataSourceTemp[indexAdd].SBT = tempData.sbtFlag;
                                oRec.setData('ModifyRow','1');
                                dataSourceTemp[indexAdd].ModifyRow = '1';
                                dataSourceTemp[indexAdd].EditStatus = '1';
                                idAdd = oRec.getData('Id');
                                var elements = YAHOO.util.Dom.getElementsByClassName('yui-dt-bd')[0];
                                var scrollTopValue = 0;
                                if(elements)
                                    scrollTopValue = elements.scrollTop;
                                oRS.render();
                                if(elements)
                                    elements.scrollTop =scrollTopValue;
                                break;
                            }
                        }
                    },
                    errorHandler:function(errorString, exception) {
                        alert("errors at get data");
                        hideProgress();
                    },
                    timeout:360000
                });
        };

        oAutoComp.itemSelectEvent.subscribe(itemSelectHandler);

        oAutoComp.formatResult = function(oResultItem, sQuery, sResultsMatch) {
            return oResultItem.markup;
        };

        oAutoComp.textboxKeyEvent.subscribe(
            function(nKeycode){
                var oSelf = this;
                oSelf.forceSelection = false;
            });

        oAutoComp.textboxFocusEvent.subscribe(
            function(){
                var oSelf = this;
                oSelf.forceSelection = false;
            });
        return {
            oDS: oACDS,
            oAC: oAutoComp
        };
    };


    function html_entity_decode(str) {
        var ta = document.createElement("textarea");
        ta.innerHTML = str.replace(/</g,"&lt;").replace(/>/g,"&gt;");
        return ta.value;
    }
    function convertHtml(str)
    {
        str = str.replace(/&/g, "&amp;");
        str = str.replace(/>/g, "&gt;");
        str = str.replace(/</g, "&lt;");
        str = str.replace(/"/g, "&quot;");
        str = str.replace(/'/g, "&#039;");
        return str;
    }
    function setZindex(id,position,totalInPage)
    {
        if(document.getElementById("myAutoComplete"+id)!=null)
        {
            if(document.getElementById("myAutoComplete"+id).parentNode!=null)
            {
                document.getElementById("myAutoComplete"+id).parentNode.style.zIndex=15000+(totalInPage-position)*100;
                document.getElementById("myAutoComplete"+id).parentNode.style.overflow = 'visible';
            }
            document.getElementById("myAutoComplete"+id).style.zIndex=10000+(totalInPage-position)*100;
            if(document.getElementById("myContainer"+id))
            {
                document.getElementById('tblMassUploadProfiles').style.zIndex=2;
                document.getElementById("myContainer"+id).style.zIndex=1;
            }

        }
    };
    function setCheckAllFlag(listItem) {
        var index = 0;
        for(var i=0; i<dataSourceTemp.length; i++) {
            var idWorkRq = dataSourceTemp[i].Id;
            if(dataSourceTemp[i].DeleteStatus == "1" && (listItem.inArray(idWorkRq))){
                index = index +1;
            }
        }
        if(index != 0 && index == listItem.length){
            document.getElementById("SelectAll").checked = true;
        }else {
            document.getElementById("SelectAll").checked = false;
        }
    }
    function saveDataSourceTempWhenCheck(id, checked, isCheckAll){
        if(isCheckAll){
            var isFilter = false;
            if(id.length != dataSourceTemp.length)
                isFilter = true;
            for(var i=0; i<dataSourceTemp.length; i++) {
                var idWorkRq = dataSourceTemp[i].Id;
                if(checked)
                {
                    if((isFilter && id.inArray(idWorkRq)) || !isFilter){
                        dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].Id +" name=ckb_"+ dataSourceTemp[i].Id +" checked=checked class=yui-dt-checkbox />";
                        dataSourceTemp[i].DeleteStatus = "1";
                    } else {
                        dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].Id +" name=ckb_"+ dataSourceTemp[i].Id +" class=yui-dt-checkbox />";
                        dataSourceTemp[i].DeleteStatus = "0";
                    }
                }
                else
                {   if((isFilter && id.inArray(dataSourceTemp[i].Id)) || !isFilter){
                    dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].Id +" name=ckb_"+ dataSourceTemp[i].Id +" class=yui-dt-checkbox />";
                    dataSourceTemp[i].DeleteStatus = "0";
                }
                }
            }
        }
        else
        {
            for (var i= 0; i< dataSourceTemp.length;i++){
                if(dataSourceTemp[i].Id == id){
                    if(checked){
                        dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].Id +" name=ckb_"+ dataSourceTemp[i].Id +" checked=checked class=yui-dt-checkbox />";
                        dataSourceTemp[i].DeleteStatus = "1";
                    }
                    else
                    {
                        dataSourceTemp[i].checkBox = "<input type=checkbox id=ckb_"+ dataSourceTemp[i].Id +" name=ckb_"+ dataSourceTemp[i].Id +" class=yui-dt-checkbox />";
                        dataSourceTemp[i].DeleteStatus = "0";
                    }
                }
            }
        }

    }
    function saveValueEditableFieldToDataTable(element)
    {
        var oRS = massUploadProfilesResult.oDT;
        var key = element.id.split('_')[0];
        var id = element.id.split('_')[1];
        var flagChange = false;
        for (var i= 0; i< oRS.getRecordSet().getLength();i++){
            var oRec = oRS.getRecord(i);
            if(id == oRec.getData('Id')){
                idOldEdit = oRec.getData('Id');
                if(key=='autoApprove'){
                    flagChange = true;
                    oRec.setData('ModifyRow','1');
                    dataSourceTemp[i].ModifyRow = '1';
                    oRec.setData("autoApproveId", element.value);
                    dataSourceTemp[i].autoApproveId = element.value;
                    if(element.value == '1'){
                        oRec.setData("autoApprove", 'Y');
                        dataSourceTemp[i].autoApprove = 'Y';
                    } else if(element.value == '2'){
                        oRec.setData("autoApprove", 'N');
                        dataSourceTemp[i].autoApprove = 'N';
                    }  else if(element.value == '0'){
                        oRec.setData("autoApprove", '');
                        dataSourceTemp[i].autoApprove = '';
                    }
                } else if(key=='function'){
                    flagChange = true;
                    oRec.setData('ModifyRow','1');
                    dataSourceTemp[i].ModifyRow = '1';
                    oRec.setData("FunctionId", element.value);
                    dataSourceTemp[i].FunctionId = element.value;
                    oldVendor = oRec.getData('Vendor');
                    oldFunctionId = oRec.getData('FunctionId');
                    if(element.value == '1'){
                        oRec.setData("FunctionNames", 'Add New Products');
                        dataSourceTemp[i].FunctionNames = 'Add New Products';
                    } else if(element.value == '2'){
                        oRec.setData("FunctionNames", 'Discontinue/Deletes');
                        dataSourceTemp[i].FunctionNames = 'Discontinue/Deletes';
                    }
                } else if(key=='dsd'){
                    flagChange = true;
                    oRec.setData('ModifyRow','1');
                    dataSourceTemp[i].ModifyRow = '1';
                    if(element.checked){
                        oRec.setData("DSD", 'true');
                        dataSourceTemp[i].DSD = 'true';
                    } else {
                        oRec.setData("DSD", 'false');
                        dataSourceTemp[i].DSD = 'false';
                    }
                } else if(key=='whs'){
                    flagChange = true;
                    oRec.setData('ModifyRow','1');
                    dataSourceTemp[i].ModifyRow = '1';
                    if(element.checked){
                        oRec.setData("WHS", 'true');
                        dataSourceTemp[i].WHS = 'true';
                    } else{
                        oRec.setData("WHS", 'false');
                        dataSourceTemp[i].WHS = 'false';
                    }
                }
                //change color
                if(flagChange == true){
                    YAHOO.util.Dom.addClass(oRS.getTrEl(oRec), 'mark');
                }
                break;
            }
        }
    }
    function addRow(){
        if(document.getElementById('errors')){
            document.getElementById('errors').innerHTML = '';
        }
        var allData={checkBox:"<input type='checkbox' id='ckb_addNew' name ='ckb_addNew'>",Vendor:"", Id:"addNew", FunctionId:"1",FunctionNames:"Add New Products",EditStatus:"1",ModifyRow:"1",AddRow:"1",AddStatus:"1",DSD:"false",WHS:"false",autoApproveId:"0",autoApprove:"",chanelBoth:"false",apTypCd:"",DeleteStatus:"0"};
        var record = YAHOO.widget.DataTable._cloneObject(allData);
        var oRS = massUploadProfilesResult.oDT;
        var lengthTable = oRS.getRecordSet().getLength();
        for(var i=0; i<lengthTable; i++) {
            var oRec = oRS.getRecord(i);
            //oRec.setData('EditStatus','0');
            oRec.setData('AddStatus','0');
            dataSourceTemp[i].AddStatus = '0';
            //dataSourceTemp[i].EditStatus = '0';
        }
        var cur = oRS.get('paginator').getState();
        var totalRecords = cur.totalRecords;
        recordInPage = cur.rowsPerPage * cur.page;
        indexRow = 0;
        //if(cur.page < totalRecords/cur.rowsPerPage){
        //	indexRow = cur.rowsPerPage * cur.page - 1;
        // } else {
        //	indexRow = totalRecords;
        // }
        if(cur.page>1){
            indexRow = cur.rowsPerPage * (cur.page-1);
        }
        var elements = YAHOO.util.Dom.getElementsByClassName('yui-dt-bd')[0];
        var scrollTopValue = 0;
        //if(elements)
        // scrollTopValue = elements.scrollHeight;
        oRS.addRow(record,indexRow);
        dataSourceTemp[lengthTable] = allData;
        if(dataSourceFitler!=null){
            dataSourceFitler[dataSourceFitler.length] = allData;
        }

        //if(elements)
        //	elements.scrollTop = scrollTopValue;
        flagAdd = true;
        document.getElementById("saveDiv").style.display = "block";
        document.getElementById("revertDiv").style.display = "block";
        document.getElementById("deleteDiv").style.display = "none";
        document.getElementById("addDiv").style.display = "none";
    }
    function revert(){
        if(document.getElementById('errors')){
            document.getElementById('errors').innerHTML = '';
        }
        if(confirm('Do you want to revert?')){
            setResultFilter();
            dataSourceTemp = [];
            dataSourceFitler = [];
            flagAdd = false;
            idDelete = "";
            oldVendor = "";
            oldFunctionId = "";
            var myDataSource = massUploadProfilesResult.oDS;
            var myDataTable = massUploadProfilesResult.oDT;
            document.getElementById('filterValues').value = '';
            document.getElementById("vendorFilter").value='';
            //document.getElementById("sbtFilter").options[0].selected = true;
            document.getElementById("functionNamesFilter").value='';
            document.getElementById("dsdFilter").options[0].selected = true;
            document.getElementById("whsFilter").options[0].selected = true;
            document.getElementById("autoppproveFilter").options[0].selected = true;
            var currentPage = myDataTable.get('paginator').getState().page;
            var currentRow = myDataTable.get('paginator').getState().rowsPerPage;
            if(dataMassUploadProfiles != null){
                //reset data source filter
                filterTimeout = null;
                var pattent = "\.*__\.*__\.*__\.*__\.*";
                myDataSource.sendRequest(pattent,{
                    success : myDataTable.onDataReturnInitializeTable,
                    failure : myDataTable.onDataReturnInitializeTable,
                    scope   : myDataTable,
                    argument: pattent
                });
                //set current page is selected (before click reset button)
                myDataTable.get('paginator').setPage(parseInt(currentPage));
                myDataTable.get('paginator').setRowsPerPage(parseInt(currentRow));
            }
            setFilterValue();
            document.getElementById("saveDiv").style.display = "none";
            document.getElementById("revertDiv").style.display = "none";
            document.getElementById("deleteDiv").style.display = "block";
            document.getElementById("addDiv").style.display = "block";
        }
    }
    function deleteRow(){
        <c:url value="/protected/cps/volumeUploadProfile/deleteMassUploadProfilies" var="deleteMassUploadProfilies"></c:url>
        if(document.getElementById('errors')){
            document.getElementById('errors').innerHTML = '';
        }
        var oRS = massUploadProfilesResult.oDT;
        var flagDeleted = false;
        var allVendorSelected = new Array();
        if(dataSourceTemp != null){
            for(var i=0; i<dataSourceTemp.length; i++) {
                //var oRec = oRS.getRecord(i);
                if(dataSourceTemp[i].DeleteStatus =='1'){
                    flagDeleted = true;
                    if(dataSourceTemp[i].AddRow !='1'){
                        allVendorSelected.push(dataSourceTemp[i].Id);
                    }
                }
            }
            if(flagDeleted){
                if(confirm('Do you want to delete?')){
                    //YAHOO.util.Dom.get('massUploadProfilesId').value = idDelete;
                    idDelete = "";
                    //var formObject = document.getElementById('massUploadProfiliesForm');
                    //showProgress();
                    //setResultFilter();
                    //formObject.action = "${deleteMassUploadProfilies}";
                    //formObject.submit();
                    showProgress();
                    ManageEDIDWR.deleteMassUploadProfilies(allVendorSelected,
                        {
                            callback:function(data) {
                                setResultFilter();
                                var formObject = document.getElementById('massUploadProfiliesForm');
                                formObject.action = "${deleteMassUploadProfilies}";
                                formObject.submit();
                            },
                            errorHandler:function(errorString, exception) {
                                hideProgress();
                            },
                            timeout:180000
                        });
                }
            } else {
                alert('Please select record(s) to delete.');
            }
        }
    }
    function saveMassUploadProfilies(){
        if(document.getElementById('errors')){
            document.getElementById('errors').innerHTML = '';
        }
        <c:url value="/protected/cps/volumeUploadProfile/updateMassUploadProfilies" var="updateMassUploadProfilies"></c:url>
        var allVendorSelected = new Array();
        var allFunctionSelected = new Array();
        var allAutoApproveSelected = new Array();
        var allStatus = new Array();
        var alltypeCdSelected = new Array();
        var allDSDSelected = new Array();
        var allWHSSelected = new Array();
        var allBothSelected = new Array();
        var allVendorCheck = new Array();
        var oRS = massUploadProfilesResult.oDT;
        var cur = oRS.get('paginator').getState();
        var rowsPerPage = cur.rowsPerPage;
        var page = cur.page;
        setResultFilter();
        var filterValues = document.getElementById('filterValues').value;
        for(var i=0; i<oRS.getRecordSet().getLength(); i++) {
            var oRec = oRS.getRecord(i);
            if(oRec.getData('AddRow')=='1'){
                if(oRec.getData('Vendor')!=null && oRec.getData('Vendor')!=''){
                    var vendorId = oRec.getData('Id').split('-')[0] +'-'+oRec.getData('Id').split('-')[1];
                    allVendorCheck.push(oRec.getData('Vendor'));
                    allVendorSelected.push(vendorId);
                    allFunctionSelected.push(oRec.getData('FunctionId'));
                    if(oRec.getData('autoApprove') !=''){
                        allAutoApproveSelected.push(oRec.getData('autoApprove'));
                    } else {
                        allAutoApproveSelected.push('none');
                    }
                    allStatus.push(oRec.getData('AddRow'));
                    alltypeCdSelected.push(oRec.getData('apTypCd'));
                    allDSDSelected.push(oRec.getData('DSD'));
                    allWHSSelected.push(oRec.getData('WHS'));
                    allBothSelected.push(oRec.getData('chanelBoth'));
                } else {
                    alert('Please select vendor before save.');
                    return;
                }
            } else if(oRec.getData('ModifyRow')=='1'){
                if(oRec.getData('Vendor')!=null && oRec.getData('Vendor')!=''){
                    allVendorCheck.push(oRec.getData('Vendor'));
                    allVendorSelected.push(oRec.getData('Id'));
                    allFunctionSelected.push(oRec.getData('FunctionId'));
                    if(oRec.getData('autoApprove') !=''){
                        allAutoApproveSelected.push(oRec.getData('autoApprove'));
                    } else {
                        allAutoApproveSelected.push('none');
                    }
                    allStatus.push(oRec.getData('AddRow'));
                    alltypeCdSelected.push(oRec.getData('apTypCd'));
                    allDSDSelected.push(oRec.getData('DSD'));
                    allWHSSelected.push(oRec.getData('WHS'));
                    allBothSelected.push(oRec.getData('chanelBoth'));
                } else {
                    alert('Please select vendor before save.');
                    return;
                }
            }
            if(oRec.getData('AddRow')=='1')  {
                if(document.getElementById("myInput"+oRec.getData('Id'))!=null)
                {
                    if(document.getElementById("myInput"+oRec.getData('Id')).value == null ||(document.getElementById("myInput"+oRec.getData('Id')).value==''))
                    {
                        alert('Please select vendor before save.');
                        return;
                    }
                }
            }
        }
        if(allVendorSelected!=null && allVendorSelected.length >0 ){
            var countDuplicate = 0;
            var flag = false;
            for(var i=0; i<allVendorSelected.length; i++){
                countDuplicate = 0;
                for(var j=0; j<oRS.getRecordSet().getLength(); j++) {
                    var oRec = oRS.getRecord(j);
                    if(oRec.getData('Vendor')==allVendorCheck[i] && oRec.getData('FunctionId')==allFunctionSelected[i])
                    {
                        countDuplicate++;
                    }
                    if(oRec.getData('chanelBoth') == 'true' && oRec.getData('ModifyRow')=='1')
                    {
                        if(oRec.getData('DSD')=='false' && oRec.getData('WHS')=='false')
                        {
                            flag = true;
                            break;
                        }
                    }
                }
                if(countDuplicate>1)
                {
                    alert('Rules duplicate. Please select other vendor or function.');
                    return;
                }
            }
            if(flag)
            {
                alert('At least one box (DSD or WHS) must be checked.');
                return;
            }
            showProgress();
            ManageEDIDWR.updateDataMassUPloadProfilied(allVendorSelected,allFunctionSelected,allAutoApproveSelected,allStatus,alltypeCdSelected,allDSDSelected,allWHSSelected,allBothSelected,parseInt(page),parseInt(rowsPerPage),filterValues,
                {
                    callback:function(data) {
                        var formObject = document.getElementById('massUploadProfiliesForm');
                        formObject.action = "${updateMassUploadProfilies}";
                        formObject.submit();
                    },
                    errorHandler:function(errorString, exception) {
                        hideProgress();
                    },
                    timeout:180000
                });
        } else {
            alert('Please change data before save.');
            return;
        }
    }
    //==========================END SET AUTOCOMPLETE FOR FILTER==============================//



    function gePattern()
    {
        var arrFilterObj = new Array();
        arrFilterObj.push("vendorFilter");
        //arrFilterObj.push("sbtFilter");
        arrFilterObj.push("functionNamesFilter");
        arrFilterObj.push("dsdFilter");
        arrFilterObj.push("whsFilter");
        arrFilterObj.push("autoppproveFilter");

        var comp = YAHOO.lang;
        var lstObjVl = new Array();

        //get value of each field of filter
        for(var i = 0 ;i< arrFilterObj.length;i++)
        {
            lstObjVl.push(comp.trim(document.getElementById(arrFilterObj[i]).value.toUpperCase()));
        }
        //convert from irregular pattern to regular pattern
        for(var i = 0; i< lstObjVl.length; i++)
        {
            //call function SER.convertFromIrToRegularPattern from SearchEDIResult.jsp page
            //if(i!=2){
            lstObjVl[i]=convertFromIrToRegularPattern(lstObjVl[i]);
            //}
        }
        var partern="";

        //get pattent
        if(lstObjVl[0].length > 0)
        {
            partern+="\.*"+lstObjVl[0]+"\.*";
        }
        else
        {
            partern+="\.*";
        }
        for(var i = 1 ;i< lstObjVl.length;i++)
        {
            if(lstObjVl[i].length > 0 && lstObjVl[i]!=0)
            {
                //partern+="__"+lstObjVl[i];
                partern+="__"+"\.*"+lstObjVl[i]+"\.*";
            }
            else
            {
                partern+="__\.*";
            }
        }
        return partern;
    };
    function convertFromIrToRegularPattern(IrStr)
    {
        var arrSpecChar = new Array("+","*","?",".","(",")","[","]","\\","/","|","^","$","&");
        var arrConvChar = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n");
        if(IrStr!='&')
        {
            IrStr=html_entity_decode(IrStr);
        }
        for(var i =0 ;i < arrSpecChar.length; i++)
        {
            IrStr=IrStr.ReplaceAll(arrSpecChar[i],arrConvChar[i]);
        }
        return IrStr;
    }

    function convertSpecialChars(str)
    {
        if(str != null && str != ""){
            str = str.replace(/&quot;/gi, "\"");
            str = str.replace(/&#039;/gi, "\'");
            str = str.replace(/&#092;/gi, "\\");
        }
        return str;
    }

    function html_entity_decode(str) {

        str = str.replace(/</g,"&lt;").replace(/>/g,"&gt;");
        return str;
    }
    function hideShowFilter(e) {
        var evt = (window.external) ? event : e;
        var target = null;
        if(evt.srcElement){
            target =evt.srcElement;
        }else if(evt.target){
            target =evt.target;
        }

        var selFilterDivArr = document.getElementsByName("divFilter");
        var isHide=false;

        if(target.value=='Hide')
        {
            isHide=true;
        }

        target.value="Hide";
        document.getElementById('clearFilter').disabled=false;
        if(isHide)
        {
            target.value="Show";
            document.getElementById('clearFilter').style.display = 'none';
        }
        else
        {
            document.getElementById('clearFilter').style.display = '';
        }
        for(var i=0;i<selFilterDivArr.length;i++)
        {
            if(isHide)
            {
                selFilterDivArr[i].parentNode.style.display = 'none';
            }
            else
            {
                selFilterDivArr[i].parentNode.style.display = 'inline-block';
            }
        }
    };
    function setDataSourceForAutocompleteFilter()
    {
        var flag = false;
        for(var i = 0;i < dataSourceTemp.length; i++)
        {
            if(arrayDataFilter!= null   && dataSourceTemp[i].Vendor !=''){
                flag = false;
                for (var j=0; j < arrayDataFilter.length; j++)
                {
                    if (arrayDataFilter[j] == dataSourceTemp[i].Vendor)
                    {
                        flag = true;
                        break;
                    }
                }
                if(!flag){
                    arrayDataFilter.push(dataSourceTemp[i].Vendor);
                }
            }
        }
    };
    function setDataSourceForAutocompleteFunctionFilter()
    {
        // var flag = false;
        arrayDataFilterFunctions.push("Add New Products");
        arrayDataFilterFunctions.push("Discontinue/Deletes");
    };
</script>
<%
	}
%>
<jsp:include page="/footerEdi.jsp"></jsp:include>
</body>
