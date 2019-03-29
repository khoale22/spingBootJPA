<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<base ref="site" />
<html>
<head>
	<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
	<title>Questionnaire</title>

	<jsp:include page="/common_head.jsp" />
	<jsp:include page="/autoCompleteHeader.jsp" />

	<c:url value="${request.getContextPath()}/yui/tabview/assets/tabview-core.css" var="styleLink" />
	<link rel="stylesheet" type="text/css" href="${styleLink}" />
	<c:url value="${request.getContextPath()}/yui/tabview/assets/skins/sam/tabview-skin.css" var="styleLink" />
	<link rel="stylesheet" type="text/css" href="${styleLink}" />
	<c:url value="${request.getContextPath()}/yui/tabview/tabview-min.js" var="styleLink" />
	<script type="text/javascript" src="${styleLink}"></script>
	<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />
</head>

<body class="yui-skin-sam" onload="loadDefault();">
<div style="background-color: #FFFFFF;width: 100%"  >
	<jsp:include page="/header.jsp" />
	<form:form action="/protected/cps/add" id="qstnForm" name="qstnForm" onsubmit="next('true');"
			   modelAttribute="addNewCandidate">
		<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<br/><br/><br/><br/><br/><br/>
		<jsp:include page="/cpsErrors.jsp" />
		<table border="0" width="80%" align="center">
			<tr align="left">
				<td align="right" width="30%"><label class="labelFont">What do you want to do</label></td>
				<td align="left" width="70%" >
					<form:select onchange="questionaire();"
								 path="selectedOption" tabindex="45" id="caseOption"
								 cssClass="selectBoxStyle2" cssStyle="margin-left:3px;width: 162px">
						<form:options items="${addNewCandidate.sessionVO.questionnarieVO.optionsList}"
									  itemLabel="name"	itemValue="id" />
					</form:select>
				</td>
			</tr>
		</table>

		<div style="visibility:hidden" id="div1">
			<table border="0" width="100%" align="center">
				<tr><td></td><td></td></tr>		<tr><td></td><td></td></tr>
				<tr>
					<td align="right" width="30%"><label class="labelFont">Which of the following describes the UPC</label></td>
					<td align="left" width="30%" >
						<form:select path="upcDescription" tabindex="45" id="describeUPC"
									 cssClass="selectBoxStyle2" cssStyle="margin-left:3px;width: 162px"
									 onchange="questionaire();">
							<form:options items="${addNewCandidate.sessionVO.questionnarieVO.upcDescriptionList}"
										  itemLabel="name" itemValue="id" />
						</form:select>
					</td>
					<td align="left" width="40%">
						<a href="javascript:return false;" style="font-size: small;"
						   onclick="showSearchPage();return false;">Advanced Search
						</a>
					</td>
				</tr>
			</table>
		</div>

		<div style="visibility:hidden" id="div2">
			<table border="0" width="100%" align="center">
				<tr>
					<td align="right" width="30%"><label class="labelFont">Do you know</label></td>
					<td align="left" width="30%" >
						<form:select path="selectedValue" tabindex="45" id="dataEntry"
									 cssClass="selectBoxStyle2" cssStyle="margin-left:3px;width: 162px">
							<form:options items="${addNewCandidate.sessionVO.questionnarieVO.valueEntryList}"
										  itemLabel="name" itemValue="id" />
						</form:select>
						&nbsp;&nbsp;&nbsp;
						<form:input path="enteredValue" id="upcCode" maxlength="15"/>
					</td>
					<td align="left" width="40%">
						<div style="visibility:hidden" id="div3">
							<a href="javascript:return false;" style="font-size: small;"
							   onclick="showSearchPage();return false;">Advanced Search </a>
						</div>
					</td>
				</tr>

				<tr>
					<td align="right"></td>
					<td align="left">
					</td>
				</tr>
				<tr>
					<td></td>
					<td align="left">
						<button type="button" id="next" name="next1" value="next">Next
						</button>
					</td>
				</tr>
			</table>
		</div>

		<input type="hidden" id="vendorFlag" name="vendorFlag" value=""/>
		<input type="hidden" id="caseFlag" name="caseFlag" value=""/>

		<c:if test="${requestScope.ActivationSuccess eq 'Y'}">
			<table border="0" width="100%" align="center">
				<tr>
					<td width="5%"></td>
					<td width="95%">
						<div id="activationMsgDiv" style="display: block;position: relative;" >
							<jsp:include page="/cps/add/modules/activationMessage.jsp"></jsp:include>
						</div>
					</td>
				</tr>
			</table>
		</c:if>
	</form:form>
	<br/><br/><br/><br/><br/><br/>
	<br/><br/><br/><br/>
	<br/><br/>
</div>
</body>

<c:url value="/yui/" var="yuiURL"/>
<c:url value="${request.getContextPath()}/yui/yahoo-dom-event/yahoo-dom-event.js" var="yahooDom" />
<script type="text/javascript" src="${yahooDom}"></script>
<c:url value="${request.getContextPath()}/yui/yuiloader/yuiloader-min.js" var="loaderURL"/>
<script type="text/javascript" src="${loaderURL}"></script>
<c:url value="/dwr/interface/AddCandidateTemp.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>

<script type="text/javascript">
    var oPushButton1 = new YAHOO.widget.Button("next");
    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("next"), "click", next);
    <c:url value="authAndDist" var="navToAuthAndDist"></c:url>
    <c:url value="fetchProduct" var="fetchProduct"></c:url>
    <c:url value="navToProdAndUPC" var="navToProdAndUPC"></c:url>
    <c:url value="mrtScreen?${_csrf.parameterName}=${_csrf.token}" var="mrtlink"></c:url>
    <c:url value="handleExistingId?${_csrf.parameterName}=${_csrf.token}" var="existingLink"></c:url>
    function advSearch(){

    }

    var nextClicked = false;
    function executeNext(evt){
        //browser compat
        if(nextClicked){
            return;
        }
        nextClicked = true;
        var qstnForm = YAHOO.util.Dom.get("qstnForm");
        var selectedValue = YAHOO.util.Dom.get("caseOption");
        var dataEntry = YAHOO.util.Dom.get('dataEntry').value;
        var enteredVal = YAHOO.util.Dom.get("upcCode");
        if(null != dataEntry && '' != dataEntry ){

        }else{
            alert('Select the type of entry');
            nextClicked = false;
            return false;
        }
        if(enteredVal.value == ''){
            alert('Enter the value for UPC, item or product');
            nextClicked = false;
            return false;
        }
        if(selectedValue.value=="3" || selectedValue.value=="2"){
            showProgress();
            qstnForm.action = "${existingLink}";
            document.getElementById('vendorFlag').value = 'true';
            document.getElementById('caseFlag').value = '';
            qstnForm.submit();
            return;
        }
        if(document.getElementById('upcCode').value.length >= 0){
            showProgress();
            qstnForm.action = "${fetchProduct}";
        }
        qstnForm.submit();
    }

    function myTrim(x) {
        return x.replace(/^\s+|\s+$/gm,'');
    }

    function next(evt){
        var enteredVal = YAHOO.util.Dom.get("upcCode");
        var selectedValue = YAHOO.util.Dom.get("dataEntry");
        var param = "";

        if(selectedValue.value == "1"){
            param = "upc";
        }else if(selectedValue.value == "2"){
            param = "itemid";
        }else if(selectedValue.value == "3"){
            param = "prodid";
        }else {
            executeNext(evt);
            return;
        }
        if(myTrim(enteredVal.value) == "" || myTrim(selectedValue.value) == ""){
            executeNext(evt);
            return;
        }
        showProgress();
        if(evt=='true') {
            executeNext(evt);
        } else {
            var callbacks = {
                success : function(o) {
                    try {
                        if (o != null && myTrim(o.responseText) != "") {
                            alert(o.responseText);
                            hideProgress();
                        }else{
                            executeNext(evt);
                        }
                    } catch (e) {
                        hideProgress();
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
                    "checkDSVItem?"+param+"="+enteredVal.value,
                    callbacks);
        }
    }

    <c:url value="${request.getContextPath()}/protected/cps/manage/prodSearchWrapper?advSearch=false" var="showPage"></c:url>
    function showSearchPage(evt){
        window.location.href = '${showPage}';
    }

    function questionaire(evt){

        var selectedValue = YAHOO.util.Dom.get("caseOption");
        var selectVal = YAHOO.util.Dom.get("describeUPC");
        var dataEntryVal = YAHOO.util.Dom.get("dataEntry");

        var div1 = YAHOO.util.Dom.get("div1");
        var div2 = YAHOO.util.Dom.get("div2");
        var qstnForm = YAHOO.util.Dom.get("qstnForm");
        var upcCodeValue = YAHOO.util.Dom.get("upcCode");

        if(selectedValue.value=="4"){
            showProgress();
            dataEntryVal.value = "";
            upcCodeValue.value="";
            document.forms[0].action = "${mrtlink}";
            document.forms[0].submit();
        }
        if(selectedValue.value=="1" && selectVal.value=="8"){
            showProgress();
            upcCodeValue.value="";
            dataEntryVal.value = "";
            qstnForm.action = "${navToProdAndUPC}";
            qstnForm.submit();
        }
        if(selectedValue.value=="9" || selectedValue.value=="12"){
            showProgress();
            upcCodeValue.value="";
            dataEntryVal.value = "";
            qstnForm.action = "${navToProdAndUPC}";
            qstnForm.submit();
        }
        if(selectedValue.value=="2" && selectVal.value=="3"){
            upcCodeValue.value="";
            dataEntryVal.value = "";
            next();
        }

        if(selectedValue.value=="1" && (selectVal.value=="5"
            || selectVal.value=="6" || selectVal.value=="7")){
            upcCodeValue.value="";
            dataEntryVal.value = "";
            div2.style.visibility="visible";
        }else if(selectedValue.value=="2" ||
            selectedValue.value=="3" ){
            if(selectedValue.value=="2"){
                div3.style.visibility="visible";
            }
            else {
                div3.style.visibility="hidden";
            }
            upcCodeValue.value="";
            selectVal.value = "";
            dataEntryVal.value = "";
            div1.style.visibility="hidden";
            div2.style.visibility="visible";
        }else if (selectedValue.value=="1"){
            div1.style.visibility="visible";
            div2.style.visibility="hidden";
            div3.style.visibility="hidden";
        }else{
            div1.style.visibility="hidden";
            div2.style.visibility="hidden";
            div3.style.visibility="hidden";
            selectVal.value = "";
        }
    }

    function loadDefault(){
        var selectedValue = YAHOO.util.Dom.get("caseOption");
        var selectVal = YAHOO.util.Dom.get("describeUPC");
        selectedValue.value="";
        selectVal.value="";
    }
</script>

<jsp:include page="/footer.jsp"></jsp:include>
</html>