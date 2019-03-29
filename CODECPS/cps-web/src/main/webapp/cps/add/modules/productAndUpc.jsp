<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<form:form action="/protected/cps/add"  id="prodAndUpcForm" modelAttribute="addNewCandidate">
	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<c:url value="${request.getContextPath()}/hebAssets/titleCase.js" var="tCase" />
	<script type="text/javascript" src="${tCase}"></script>
	<div style="position: relative;min-width: 0;">
		<c:if test="${!addNewCandidate.upcValueFromMRT}">
			<c:out value="Add new MRT Value ${addNewCandidate.upcValue}"></c:out>
			<c:out value="${addNewCandidate.upcSubValue}"></c:out>
		</c:if>
		<br><br>&nbsp;&nbsp;
		<jsp:include page="/cps/add/modules/prodClassification.jsp"></jsp:include>
		<br><br>&nbsp;&nbsp;
		<jsp:include page="/cps/add/modules/upc.jsp"></jsp:include>
		<br><br>&nbsp;&nbsp;
		<jsp:include page="/cps/add/modules/shelfEdge.jsp"></jsp:include>
		<br><br>&nbsp;&nbsp;
		<jsp:include page="/cps/add/modules/physicalAttribute.jsp"></jsp:include>
		<br><br>&nbsp;&nbsp;
		<jsp:include page="/cps/add/modules/posAndAccounting.jsp"></jsp:include>
		<br><br>
		<c:if test="${addNewCandidate.productVO.workRequest.intentIdentifier ==12 || addNewCandidate.productVO.activeProductKit eq true}">
			<div id="retailDiv" style="display: block;position: relative;">
				&nbsp;&nbsp;
				<jsp:include page="/cps/add/modules/kitComponents.jsp"></jsp:include>
			</div>
		</c:if>
		<br>
		<div id="retailDiv" style="display: block;position: relative;">
			&nbsp;&nbsp;
			<jsp:include page="/cps/add/modules/retail.jsp"></jsp:include>
		</div>
		<br>
		<!--  Scale Attributes -->
		<c:if test="${addNewCandidate.scaleAttrib eq 'I'}">
			<div id="scaleAttribDiv" style="display: block;position: relative;">
				&nbsp;&nbsp;
				<jsp:include page="/cps/add/modules/scaleAttrib.jsp"></jsp:include>
			</div>
		</c:if>
		<c:if test="${addNewCandidate.scaleAttrib ne 'I'}">
			<div id="scaleAttribDiv" style="display: none;position: absolute;">
				&nbsp;&nbsp;
				<jsp:include page="/cps/add/modules/scaleAttrib.jsp"></jsp:include>
			</div>
		</c:if>
		<br>
		<!-- Nutrition Informaltion  -->
		<c:choose>
			<c:when test="${addNewCandidate.productVO.pointOfSaleVO.showClrsSw && addNewCandidate.userRole ne 'RVEND' && addNewCandidate.userRole ne 'UVEND'}">
				<div id="nutritionFactsDiv" style="display: block;position: relative;">
					&nbsp;&nbsp;
					<jsp:include page="/cps/add/modules/nutritionFacts.jsp"></jsp:include>
				</div>
			</c:when>
			<c:otherwise>
				<div id="nutritionFactsDiv" style="display: none;position: absolute;">
					&nbsp;&nbsp;
					<jsp:include page="/cps/add/modules/nutritionFacts.jsp"></jsp:include>
				</div>
			</c:otherwise>
		</c:choose>
		<br>
		<div id="pharmacyAttribDiv" style="display: none;position: absolute;">
			&nbsp;&nbsp;
			<jsp:include page="/cps/add/modules/pharmacyAttrib.jsp"></jsp:include>
		</div>
		<br>
		<div id="tobaccoAttribDiv" style="display: none;position: absolute;">
			&nbsp;&nbsp;
			<jsp:include page="/cps/add/modules/tobaccoAttrib.jsp"></jsp:include>
		</div>
	</div>
	<br class="clearfloat" />
	<table width="100%">
		<tr>
			<td width="90%" align="right">
				<cps:renderByResourceAccess resourceId="201">
					<jsp:attribute name="EXEC">
						<button type="button" id="scaleNextButton" tabIndex="670" name="scaleNextButton" value="Next">Next</button>
					</jsp:attribute>
						<jsp:attribute name="NONE">
						<button type="button" id="nextButton" tabIndex="670" name="nextButton" value="Next">Next</button>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td width="10%"></td>
		</tr>
	</table>

	<script type="text/javascript">
        var oPushButton1 = new YAHOO.widget.Button("nextButton");
        var oPushButton2 = new YAHOO.widget.Button("scaleNextButton");

        <c:url value="/protected/cps/add/authAndDist?${_csrf.parameterName}=${_csrf.token}" var="pageLink" />
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("nextButton"), "click", showAuthDist);
        <c:if test="${addNewCandidate.scaleAttrib eq 'I'}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("scaleNextButton"), "click", validateScaleAttributes);
        </c:if>
        <c:if test="${addNewCandidate.scaleAttrib ne 'I'}">
        YAHOO.util.Event.addListener(YAHOO.util.Dom.get("scaleNextButton"), "click", showAuthDist);
        </c:if>

        function callBackDeleteScale(isShow){
            var scaleAttribDiv = YAHOO.util.Dom.get("scaleAttribDiv");
            var engDescLine1 = YAHOO.util.Dom.get("engDescLine1");
            var engDescLine2 =  YAHOO.util.Dom.get("engDescLine2");
            var spaDescLine1 = YAHOO.util.Dom.get("spaDescLine1");
            var spaDescLine2 = YAHOO.util.Dom.get("spaDescLine2");
            var prePackTare = YAHOO.util.Dom.get("prePackTare");
            var shelfLifeDays = YAHOO.util.Dom.get("shelfLifeDays");
            var gradeNbr = YAHOO.util.Dom.get("gradeNbr");
            var netWt = YAHOO.util.Dom.get("netWt");
			/*
			 Hungbang added new field Scale. Date : 21.Jan.2016
			 engDesc1,engDesc2,mechTenz,engDescLine3,engDescLine4
			 */

            var engDesc1 = document.getElementById("engDesc1");
            var engDesc2 = document.getElementById("engDesc2");
            var engDescLine3 = document.getElementById("engDescLine3");
            var engDescLine4 = document.getElementById("engDescLine4");
            var mechTenz = document.getElementById("mechTenz");
            if(null != scaleAttribDiv && undefined != scaleAttribDiv){
                <c:if test="${addNewCandidate.userRole ne 'RVEND'}">
                if(isShow){
                    setColorForBrandCFD("white");
                    scaleAttribDiv.style.display = 'block';
                    scaleAttribDiv.style.position = 'relative';
                    engDescLine1.removeAttribute("disabled");
                    engDescLine2.removeAttribute("disabled");
                    spaDescLine1.removeAttribute("disabled");
                    spaDescLine2.removeAttribute("disabled");
                    prePackTare.removeAttribute("disabled");
                    shelfLifeDays.removeAttribute("disabled");
                    gradeNbr.removeAttribute("disabled");
                    netWt.removeAttribute("disabled");
					/*
					 Hungbang added new field Scale. Date : 21.Jan.2016
					 engDesc1,engDesc2,,mechTenz,engDescLine3,engDescLine4
					 */
                    engDesc1.removeAttribute("disabled");
                    engDesc2.removeAttribute("disabled");
                    engDescLine3.removeAttribute("disabled");
                    engDescLine4.removeAttribute("disabled");
                    mechTenz.removeAttribute("disabled");
                }else{
                    scaleAttribDiv.style.display = 'none';
                    scaleAttribDiv.style.position = 'absolute';
                    setColorForBrandCFD("red");
                    mechTenz.checked = false;
					/*
					 Hungbang added new field Scale. Date : 21.Jan.2016
					 engDesc1,engDesc2,,mechTenz,engDescLine3,engDescLine4
					 */
                    engDesc1.value = "";
                    engDesc2.value = "";
                    engDescLine3.value = "";
                    engDescLine4.value = "";

                    engDescLine1.value = "";
                    engDescLine2.value = "";
                    spaDescLine1.value = "";
                    spaDescLine2.value = "";
                    prePackTare.value = "";
                    shelfLifeDays.value = "";
                    gradeNbr.value = "";
                    netWt.value = "";
                }
                </c:if>
            }
        }

        function showScaleAttribute(isShow){
            var scaleAttribDiv = YAHOO.util.Dom.get("scaleAttribDiv");

            var engDescLine1 = YAHOO.util.Dom.get("engDescLine1");
            var engDescLine2 =  YAHOO.util.Dom.get("engDescLine2");
            var spaDescLine1 = YAHOO.util.Dom.get("spaDescLine1");
            var spaDescLine2 = YAHOO.util.Dom.get("spaDescLine2");
            var prePackTare = YAHOO.util.Dom.get("prePackTare");
            var shelfLifeDays = YAHOO.util.Dom.get("shelfLifeDays");
            var gradeNbr = YAHOO.util.Dom.get("gradeNbr");
            var netWt = YAHOO.util.Dom.get("netWt");
			/*
			 Hungbang added new field Scale. Date : 21.Jan.2016
			 engDesc1,engDesc2,,mechTenz,engDescLine3,engDescLine4
			 */
            var engDesc1 = document.getElementById("engDesc1");
            var engDesc2 = document.getElementById("engDesc2");
            var engDescLine3 = document.getElementById("engDescLine3");
            var engDescLine4 = document.getElementById("engDescLine4");
            var mechTenz = document.getElementById("mechTenz");

            if(null != scaleAttribDiv && undefined != scaleAttribDiv){
                <c:if test="${addNewCandidate.userRole ne 'RVEND'}">
                if(isShow ){
                    setColorForBrandCFD("white");
                    scaleAttribDiv.style.display = 'block';
                    scaleAttribDiv.style.position = 'relative';
                    engDescLine1.removeAttribute("disabled");
                    engDescLine2.removeAttribute("disabled");
                    spaDescLine1.removeAttribute("disabled");
                    spaDescLine2.removeAttribute("disabled");
                    prePackTare.removeAttribute("disabled");
                    shelfLifeDays.removeAttribute("disabled");
                    gradeNbr.removeAttribute("disabled");
                    netWt.removeAttribute("disabled");
					/*
					 Hungbang added new field Scale. Date : 21.Jan.2016
					 engDesc1,engDesc2,,mechTenz,engDescLine3,engDescLine4
					 */
                    engDesc1.removeAttribute("disabled");
                    engDesc2.removeAttribute("disabled");
                    engDescLine3.removeAttribute("disabled");
                    engDescLine4.removeAttribute("disabled");
                    mechTenz.removeAttribute("disabled");
					/*
					 reset value when remove scale
					 */
                    engDescLine1.value = "";
                    engDescLine2.value = "";
                    spaDescLine1.value = "";
                    spaDescLine2.value = "";
                    prePackTare.value = "";
                    shelfLifeDays.value = "";
                    gradeNbr.value = "";
                    netWt.value = "";
                    mechTenz.checked = false;
					/*
					 Hungbang added new field Scale. Date : 21.Jan.2016
					 engDesc1,engDesc2,,mechTenz,engDescLine3,engDescLine4
					 */
                    engDesc1.value = "";
                    engDesc2.value = "";
                    engDescLine3.value = "";
                    engDescLine4.value = "";
                }else{
                    scaleAttribDiv.style.display = 'none';
                    scaleAttribDiv.style.position = 'absolute';
                    setColorForBrandCFD("red");
                }
                </c:if>
            }
        }

        function showAuthDist(evt) {
            enableCheckboxForSave();
            if(document.getElementById("nextButton")){
                document.getElementById("nextButton").disabled = true;
            }
            if(document.getElementById("scaleNextButton")){
                document.getElementById("scaleNextButton").disabled = true;
            }
            if(document.getElementById("saveButton")){
                document.getElementById("saveButton").disabled = true;
            }
            if(saveUPCHook == true){
                goToNextTabHook = goToAuthDist;
                addUpc();
            }else{
                if(document.getElementById("brandACInput")){
                    if(document.getElementById("brandACInput").value=='' || document.getElementById("brandACInput").value=='UNASSIGNED'){
                        alert('Candidate cannot be submitted/activated with the Brand \"Unassigned\"');
                        YAHOO.util.Dom.get("brandName").value = '';
                        if(document.getElementById("nextButton")){
                            document.getElementById("nextButton").disabled = false;
                        }
                        if(document.getElementById("scaleNextButton")){
                            document.getElementById("scaleNextButton").disabled = false;
                        }
                        if(document.getElementById("saveButton")){
                            document.getElementById("saveButton").disabled = false;
                        }
                        //return false;
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
                }
                if(proddesc && proddesc.innerText == null || proddesc.innerText == ""){
                    alert('Please enter Product Description before saving.');
                    enableButtonWhenValidate(false);
                    return false;
                }
                var msgSellingResReturn = validateBeforeSave();
                if(msgSellingResReturn!=""){
                    alert(msgSellingResReturn);
                    enableButtonWhenValidate(false);
                    return false;
                }
                clearKitComponent();
                //if(brick && brick.value != ""){
                var check = YAHOO.util.Dom.hasClass('brickAutoComplete', 'hide');
                if(!check){
                    AddCandidateTemp.checkUpc(afterCheckUpcAuthAndDist1);
                }else{
                    showProgress();
                    var prodUpcForm = YAHOO.util.Dom.get("prodAndUpcForm");
                    prodUpcForm.action = "${pageLink}";
                    prodUpcForm.submit();
                }
            }
        }

        function afterCheckUpcAuthAndDist1(data){
            var msgData = data.messages;
            if(! msgData.exception){
                if(data.appData.valid){
                    if(checkBrick(data.appData.newDataSw)){
                        showProgress();
                        var prodUpcForm = YAHOO.util.Dom.get("prodAndUpcForm");
                        prodUpcForm.action = "${pageLink}";
                        prodUpcForm.submit();
                    }
                }else{
                    showProgress();
                    var prodUpcForm = YAHOO.util.Dom.get("prodAndUpcForm");
                    prodUpcForm.action = "${pageLink}";
                    prodUpcForm.submit();
                }
            }else{
                alert(msgData)
            }
        }


        function goToAuthDist(evt) {
            goToNextTabHook = null;
            var prodUpcForm = YAHOO.util.Dom.get("prodAndUpcForm");
            prodUpcForm.action = "${pageLink}";
            prodUpcForm.submit();
        }


        function reloadProdAndUpc(){
            reloadMerch();
            reloadShelfEdge();
            reloadAddDesc();
            reloadposAcc();
            reloadRetail();
            reloadUpc();
        }

        function validateRetailForNext() {
            if (document.getElementById('centsOff')
                && document.getElementById('retail')
                && document.getElementById('retailForprice')) {
                var centsOff = document.getElementById('centsOff').value;
                var retail = document.getElementById('retail').value;
                var retailForPrice = document.getElementById('retailForprice').value;
                if (retail == 0 || retail == '') retail = 1;
                if (retailForPrice != '') {
                    if (centsOff > (retailForPrice/retail)) {
                        alert('Cents Off is greater than one Retail For value');
                        document.getElementById('centsOff').value = "";
                        return false;
                    }
                }
                return true;
            }
        }

        function validateScaleAttributes(evt){
            var scaleVO = getScaleObject();
            AddCandidateTemp.validateScaleAttributes(scaleVO, getDWRCallbackMethod(validateScaleAttributesCallback));
        }

        function validateScaleAttributesCallback(data) {
            if (data == 'SUCCESS') {
                showAuthDist();
            } else {
                alert(data);
            }
            return false;
        }

        function getValue(obj){
            if (obj){
                return obj.value;
            } else {
                return null;
            }
        }


        function getScaleObject(){
            var ingStatementNumber	=  	getValue(document.getElementById('ingStatementNumber'));
            var actionCodeACInput   =	getValue(document.getElementById('actionCodeACInput'));
            var serviceCounterTare  =	getValue(document.getElementById('serviceCounterTare'));
            var nutStatementNumber  =	getValue(document.getElementById('nutStatementNumber'));
            var graphicsCodeACInput =  	getValue(document.getElementById('graphicsCodeACInput'));
            var shelfLifeDays       =	getValue(document.getElementById('shelfLifeDays'));
            var prePackTare         =	getValue(document.getElementById('prePackTare'));
            var engDescLine1        =	getValue(document.getElementById('engDescLine1'));
            var engDescLine2        =	getValue(document.getElementById('engDescLine2'));
            //HoangVT
            var spaDescLine1        =	getValue(document.getElementById('spaDescLine1'));
            var spaDescLine2        =	getValue(document.getElementById('spaDescLine2'));
            var gradeNbr			=	getValue(document.getElementById('gradeNbr'));
            var netWt				=	getValue(document.getElementById('netWt'));

            var tmpforceTare       	=	document.getElementById('forceTare');
            var labelFormat1ACInput =	getValue(document.getElementById('labelFormat1ACInput'));
            var labelFormat2ACInput =	getValue(document.getElementById('labelFormat2ACInput'));

            var engDesc1            =  getValue(document.getElementById("engDesc1"));
            var engDesc2            =  getValue(document.getElementById("engDesc2"));
            var engDescLine3            =  getValue(document.getElementById("engDescLine3"));
            var engDescLine4            =  getValue(document.getElementById("engDescLine4"));
            //Fix javascript error related to 1302
            var forceTare        	= "";
            if(tmpforceTare.type == 'hidden'){
                forceTare        	=	getValue(tmpforceTare);
            }else{
                forceTare        	=	getValue(tmpforceTare.options[tmpforceTare.selectedIndex]);
            }

            var associatedPLUs      =	getValue(document.getElementById('associatedPLUs'));

            var scaleVO = new Object();
            scaleVO.ingStatementNumber	= 	ingStatementNumber;
            scaleVO.actionCode			=	actionCodeACInput;
            scaleVO.serviceCounterTare	=	serviceCounterTare;
            scaleVO.nutStatementNumber	=	nutStatementNumber;
            scaleVO.graphicsCode		=	graphicsCodeACInput;
            scaleVO.forceTare			=	forceTare;
            scaleVO.shelfLifeDays		=	shelfLifeDays;
            scaleVO.prePackTare			=	prePackTare;
            scaleVO.engDescLine1		=	engDescLine1;
            scaleVO.labelFormat1		=	labelFormat1ACInput;
            scaleVO.engDescLine2		=	engDescLine2;
            scaleVO.labelFormat2		=	labelFormat2ACInput;
            scaleVO.associatedPLUs		= 	associatedPLUs;
            //HoangVT
            scaleVO.spaDescLine1		= 	spaDescLine1;
            scaleVO.spaDescLine2		= 	spaDescLine2;
            scaleVO.gradeNbr			= 	gradeNbr;
            scaleVO.netWt				= 	netWt;

            scaleVO.engDesc1		    = 	engDesc1;
            scaleVO.engDesc2		    = 	engDesc2;
            scaleVO.engDescLine3		= 	engDescLine3;
            scaleVO.engDescLine4		= 	engDescLine4;
            return scaleVO;
        }

        function showNutritionInformation(isShow){
            var nutritionFactsDiv = YAHOO.util.Dom.get("nutritionFactsDiv");
            if(null != nutritionFactsDiv && undefined != nutritionFactsDiv){
                if (isShow && "${addNewCandidate.userRole ne 'RVEND'}" && "${addNewCandidate.userRole ne 'UVEND'}") {
                    nutritionFactsDiv.style.display = 'block';
                    nutritionFactsDiv.style.position = 'relative';
                    refreshDataForNutritionFacts();
                } else {
                    nutritionFactsDiv.style.display = 'none';
                    nutritionFactsDiv.style.position = 'absolute';
                }
            }
        }

        function refreshDataForNutritionFacts(){
            var showCaloriesFlag = YAHOO.util.Dom.get("showClrsSw");
            var nutritionFactsDiv = YAHOO.util.Dom.get("nutritionFactsDiv");
            if(null != nutritionFactsDiv && undefined != nutritionFactsDiv && showCaloriesFlag.checked){
                showProgress();
                AddCandidateTemp.getNutritionFactsInformation(getDWRCallbackMethod(showNutritionFactsInformation));
            }
        }

        function showNutritionFactsInformation(data) {
            hideTheProgress();
            buildNutritionTable(data);
            // update fda menu labeling status when show calories checked
            if (data != null && data.pointOfSaleVO != null) {
                changeFdaMenuLabelingStatus(data.pointOfSaleVO);
            }
        }

        function buildNutritionTable(data){
            var nutrionPeding = YAHOO.util.Dom.get("nutrionPeding");
            var nutrionApproved = YAHOO.util.Dom.get("nutrionApproved");
            var nutritionPendingTbl = YAHOO.util.Dom.get("nutritionPendingTbl");
            var nutritionApprTbl = YAHOO.util.Dom.get("nutritionApprTbl");
            var approveOnArea = YAHOO.util.Dom.get("approveOnArea");
            if(approveOnArea != null && data != null && data.onlyScale == false){
                approveOnArea.style.display = '';
            }else if(approveOnArea != null){
                approveOnArea.style.display = 'none';
            }
            if(data != null && data.nutritionFactsVOsApprPending != null && data.nutritionFactsVOsApprPending.length > 0){
                nutritionPendingTbl.innerHTML = buildNutritionTableForPendingAppr(data);
                nutrionPeding.style.display = '';
            }else{
                nutrionPeding.style.display = 'none';
            }
            if(data != null && data.nutritionFactsVOsApproved != null && data.nutritionFactsVOsApproved.length > 0){
                nutritionApprTbl.innerHTML = buildNutritionTableForApproved(data);
                nutrionApproved.style.display = '';
            }else{
                nutrionApproved.style.display = 'none';
            }
        }

        function buildNutritionTableForPendingAppr(data){
            var innerHTMLContain = '';
            if(data != null && data.nutritionFactsVOsApprPending != null && data.nutritionFactsVOsApprPending.length > 0){
                innerHTMLContain += '<table><tr>';
                for(var i = 0;i<data.nutritionFactsVOsApprPending.length;i++){
                    var nutritionFactsVO = data.nutritionFactsVOsApprPending[i];
                    //contain table
                    innerHTMLContain += '<td style="vertical-align: top;">';
                    innerHTMLContain += '<table><tr><td>';
                    innerHTMLContain += "<div id='ntTable' style='width: 400px; height: 100%;'>";
                    //header
                    innerHTMLContain += "<label style='font-weight: bold;'>UPC: </label>"+nutritionFactsVO.upcKeyFull;
                    innerHTMLContain += "<br>";
                    innerHTMLContain += '<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="'+nutritionFactsVO.source+'">';
                    innerHTMLContain += '<span style="font-weight: bold;">Source </span>'+ nutritionFactsVO.source;
                    if(nutritionFactsVO.srcTs != null && nutritionFactsVO.srcTs != ''){
                        innerHTMLContain += '<span style="font-weight: bold;"> As of </span>' + nutritionFactsVO.srcTs;
                    }
                    innerHTMLContain += '</p>';
                    innerHTMLContain += '<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="'+nutritionFactsVO.servingSizeText+'">';
                    innerHTMLContain += '<span style="font-weight: bold;">Serving Size </span>'+ nutritionFactsVO.servingSizeText;
                    innerHTMLContain += '</p>';
                    innerHTMLContain += '<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="'+myString(nutritionFactsVO.servingPerContainer)+'">';
                    innerHTMLContain += '<span style="font-weight: bold;">Serving Per Container </span>'+myString(nutritionFactsVO.servingPerContainer);
                    innerHTMLContain += '</p>';
                    innerHTMLContain += "<hr>";
                    //table for amount per serving
                    innerHTMLContain += '<table width="100%" border="0" border="0" cellspacing="0" cellpadding="2" style="table-layout: fixed;">';
                    innerHTMLContain += '<tr>';
                    innerHTMLContain += '<td nowrap width="70%" align="left" align="center" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;text-overflow: ellipsis"';
                    innerHTMLContain += 'title="'+myString(nutritionFactsVO.amountPerServing)+'"><span style="font-weight: bold;">Amount per Serving </span>'+myString(nutritionFactsVO.amountPerServing)+'</td>';
                    innerHTMLContain += '<td width="30%" align="left" class="" style="font-weight: bold;">Daily Value*</td>';
                    innerHTMLContain += '</tr>';
                    innerHTMLContain += '</table>';
                    //table body
                    innerHTMLContain += '<table width="100%" border="0" id="nutritionTable" border="0" cellspacing="0" cellpadding="2" style="table-layout: fixed;">';
                    innerHTMLContain += '<tbody id="nutritionTbody">';
                    if(nutritionFactsVO.nutritionDetailVOs != null){
                        for(var j = 0;j<nutritionFactsVO.nutritionDetailVOs.length;j++){
                            var nutritionDetailVO = nutritionFactsVO.nutritionDetailVOs[j];
                            var rowClassName = "row1";
                            if(j%2 == 0){
                                rowClassName = "row0";
                            }
                            innerHTMLContain += '<tr class = "'+rowClassName+'">';
                            innerHTMLContain += '<td nowrap width="40%" align="left" align="center" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;text-overflow: ellipsis;" class="'+rowClassName+'" title="'+nutritionDetailVO.nutritionName+'">';
                            innerHTMLContain += '&nbsp;'+nutritionDetailVO.nutritionName + '</td>';
                            innerHTMLContain += '<td nowrap width="30%" align="left" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;" class="'+rowClassName+'">';
                            innerHTMLContain += '&nbsp;'+nutritionDetailVO.nutriQuantityAndUOM+'</td>';
                            innerHTMLContain += '<td nowrap width="30%" align="left" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;" class="'+rowClassName+'">';
                            innerHTMLContain += '&nbsp;'+nutritionDetailVO.nutriQuantityPercent;
                            if(nutritionDetailVO.nutriQuantityPercent != null && nutritionDetailVO.nutriQuantityPercent != ''){
                                innerHTMLContain += '&nbsp;%';
                            }
                            innerHTMLContain += '</td>';
                            innerHTMLContain += '</tr>';
                        }
                    }
                    innerHTMLContain += '</tbody>';
                    innerHTMLContain += '</table>';
                    //end table
                    //footer
                    if(nutritionFactsVO.isOrContainer != null && nutritionFactsVO.isOrContainer != ''){
                        innerHTMLContain += '<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="'+nutritionFactsVO.isOrContainer+'"><span style="font-weight: bold;">IS or Contains: </span> '+nutritionFactsVO.isOrContainer;
                        innerHTMLContain += '</p>';
                    }else{
                        innerHTMLContain += '<p style="overflow: hidden;white-space: nowrap;margin-top: 0px;margin-bottom: 0px;">&nbsp;</p>';
                    }
                    innerHTMLContain += '<hr>';
                    innerHTMLContain += '<label style="font-weight: bold;font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">&nbsp;*Percentage Daily values are based on a 2,000 calorie diet. Your Daily values may be higher or lower depending on your calorie needs</label>';
                    // end footer
                    //Ingredients, Allergens
                    innerHTMLContain += '<div style="text-align: justify;"><span style="font-weight: bold;">Ingredients List: </span>'+myString(nutritionFactsVO.ingredientsList)+'</div>';
                    innerHTMLContain += '<div style="text-align: justify;"><span style="font-weight: bold;">Allergens: </span>'+myString(nutritionFactsVO.allergens)+'</div>';
                    innerHTMLContain += '<br>&nbsp;<br>&nbsp';
                    //end
                    innerHTMLContain += '</div>'
                    innerHTMLContain += '</td></tr></table></td>';
                }
                innerHTMLContain += '</tr></table>';
            }
            return innerHTMLContain;
        }

        function buildNutritionTableForApproved(data){
            var approvedBy = YAHOO.util.Dom.get("approvedBy");
            var approvedOn = YAHOO.util.Dom.get("approvedOn");
            var innerHTMLContain = '';
            if(data != null && data.nutritionFactsVOsApproved != null && data.nutritionFactsVOsApproved.length > 0){
                innerHTMLContain += '<table><tr>';
                for(var i = 0;i<data.nutritionFactsVOsApproved.length;i++){
                    var nutritionFactsVO = data.nutritionFactsVOsApproved[i];
                    //contain table
                    innerHTMLContain += '<td style="vertical-align: top;">';
                    innerHTMLContain += '<table>';
                    innerHTMLContain += '<tr>';
                    innerHTMLContain += '<td>';
                    innerHTMLContain += "<div id='ntTable' style='width: 400px; height: 100%;'>";
                    //header
                    innerHTMLContain += "<label style='font-weight: bold;'>UPC: </label>"+nutritionFactsVO.upcKeyFull;
                    innerHTMLContain += "<br>";
                    innerHTMLContain += '<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="'+nutritionFactsVO.source+'">';
                    innerHTMLContain += '<span style="font-weight: bold;">Source </span>'+ nutritionFactsVO.source;
                    if(nutritionFactsVO.srcTs != null && nutritionFactsVO.srcTs != ''){
                        innerHTMLContain += '<span style="font-weight: bold;"> As of </span>' + nutritionFactsVO.srcTs;
                    }
                    innerHTMLContain += '</p>';
                    innerHTMLContain += '<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="'+nutritionFactsVO.servingSizeText+'">';
                    innerHTMLContain += '<span style="font-weight: bold;">Serving Size </span>'+ nutritionFactsVO.servingSizeText;
                    innerHTMLContain += '</p>';
                    innerHTMLContain += '<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="'+myString(nutritionFactsVO.servingPerContainer)+'">';
                    innerHTMLContain += '<span style="font-weight: bold;">Serving Per Container </span>'+myString(nutritionFactsVO.servingPerContainer);
                    innerHTMLContain += '</p>';
                    innerHTMLContain += "<hr>";
                    //table for amount per serving
                    innerHTMLContain += '<table width="100%" border="0" border="0" cellspacing="0" cellpadding="2" style="table-layout: fixed;">';
                    innerHTMLContain += '<tr>';
                    innerHTMLContain += '<td nowrap width="70%" align="left" align="center" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;text-overflow: ellipsis"';
                    innerHTMLContain += 'title="'+myString(nutritionFactsVO.amountPerServing)+'"><span style="font-weight: bold;">Amount per Serving </span>'+myString(nutritionFactsVO.amountPerServing)+'</td>';
                    innerHTMLContain += '<td width="30%" align="left" class="" style="font-weight: bold;">Daily Value*</td>';
                    innerHTMLContain += '</tr>';
                    innerHTMLContain += '</table>';
                    //table body
                    innerHTMLContain += '<table width="100%" border="0" id="nutritionTable" border="0" cellspacing="0" cellpadding="2" style="table-layout: fixed;">';
                    innerHTMLContain += '<tbody id="nutritionTbody">';
                    if(nutritionFactsVO.nutritionDetailVOs != null){
                        for(var j = 0;j<nutritionFactsVO.nutritionDetailVOs.length;j++){
                            var nutritionDetailVO = nutritionFactsVO.nutritionDetailVOs[j];
                            var rowClassName = "row1";
                            if(j%2 == 0){
                                rowClassName = "row0";
                            }
                            innerHTMLContain += '<tr class = "'+rowClassName+'">';
                            innerHTMLContain += '<td nowrap width="40%" align="left" align="center" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;text-overflow: ellipsis;" class="'+rowClassName+'" title="'+nutritionDetailVO.nutritionName+'">';
                            innerHTMLContain += '&nbsp;'+nutritionDetailVO.nutritionName + '</td>';
                            innerHTMLContain += '<td nowrap width="30%" align="left" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;" class="'+rowClassName+'">';
                            innerHTMLContain += '&nbsp;'+nutritionDetailVO.nutriQuantityAndUOM+'</td>';
                            innerHTMLContain += '<td nowrap width="30%" align="left" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;" class="'+rowClassName+'">';
                            innerHTMLContain += '&nbsp;'+nutritionDetailVO.nutriQuantityPercent;
                            if(nutritionDetailVO.nutriQuantityPercent != null && nutritionDetailVO.nutriQuantityPercent != ''){
                                innerHTMLContain += '&nbsp;%';
                            }
                            innerHTMLContain += '</td>';
                            innerHTMLContain += '</tr>';
                        }
                    }
                    innerHTMLContain += '</tbody>';
                    innerHTMLContain += '</table>';
                    //end table
                    //footer
                    if(nutritionFactsVO.isOrContainer != null && nutritionFactsVO.isOrContainer != ''){
                        innerHTMLContain += '<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="'+nutritionFactsVO.isOrContainer+'"><span style="font-weight: bold;">IS or Contains: </span> '+nutritionFactsVO.isOrContainer;
                        innerHTMLContain += '</p>';
                    }else{
                        innerHTMLContain += '<p style="overflow: hidden;white-space: nowrap;margin-top: 0px;margin-bottom: 0px;">&nbsp;</p>';
                    }
                    innerHTMLContain += '<hr>';
                    innerHTMLContain += '<label style="font-weight: bold;font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">&nbsp;*Percentage Daily values are based on a 2,000 calorie diet. Your Daily values may be higher or lower depending on your calorie needs</label>';
                    // end footer
                    //Ingredients, Allergens
                    innerHTMLContain += '<div style="text-align: justify;"><span style="font-weight: bold;">Ingredients List: </span>'+myString(nutritionFactsVO.ingredientsList)+'</div>';
                    innerHTMLContain += '<div style="text-align: justify;"><span style="font-weight: bold;">Allergens: </span>'+myString(nutritionFactsVO.allergens)+'</div>';
                    innerHTMLContain += '<br>&nbsp;<br>&nbsp';
                    //end
                    innerHTMLContain += '</div>';
                    innerHTMLContain += '</td>';
                    innerHTMLContain += '</tr>';
                    innerHTMLContain += '</table>';
                    innerHTMLContain += '</td>';
                }
                innerHTMLContain += '</tr></table>';
                //displayApprovedInfo
                if(approvedOn != null && data.apprDate != null){
                    approvedOn.innerHTML = data.apprDate;
                }
                if(data.apprByUserId != null && data.apprByUserId != ''){
                    getApprovedUserName(data.apprByUserId);
                }
            }
            return innerHTMLContain;
        }

        function getApprovedUserName(approvedUserId){
            var approvedBy = YAHOO.util.Dom.get("approvedBy");
            showProgress();
            var callbacks = {
                success : function(o) {
                    try {
                        if (o != null && myTrim(o.responseText) != "") {
                            if(approvedBy != null){
                                approvedBy.innerHTML = o.responseText;
                            }
                        }else{
                            approvedBy.innerHTML = '';
                        }
                        hideTheProgress();
                    } catch (e) {
                        hideTheProgress();
                        return;
                    }
                },
                failure : function() {
                    hideTheProgress();
                }, timeout : 50000
            };
            YAHOO.util.Connect.asyncRequest('GET',
                "getApprovedUserName?approvedUserId="+approvedUserId, callbacks);
        }

        function myString(str){
            if(str == null){
                return '';
            }else{
                return str;
            }
        }
	</script>
</form:form>