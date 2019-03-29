<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="/WEB-INF/functions.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<base ref="site" />

<script type="text/javascript">
		YAHOO.namespace('HEB.otherInfo.productAndUPC.upc');
</script>

<style type="text/css">
	.myAutoComplete .yui-ac-content {
		max-height:15em;
		overflow:auto;
		overflow-x:hidden;
		_height:15em;
		z-index:6000;
	}

	.yui-skin-sam .yui-dt-col-address pre {
	font-family: arial;
	font-size: 100%;
	}

	.origin {
		display: block;
		background: #795089;
		padding: 1ex;
		color: #fff;
		text-align: right;
		margin-bottom: 1em;
	}

	.yui-skin-sam .mask {
		opacity: 0.12;
		*filter: alpha(opacity = 12); /* Set opacity in IE */
	}

	#heb {
		height: 20em;
	}
	/* XP Panel Skin CSS */
	/* Skin default elements */
</style>

<a id="sec1tion"></a>
<fieldset style="width: 95%; z-index: 8000;">
	<legend class="legendFont">Selling Unit UPC</legend>
	<table id="upcTble" align="center" width="100%" border="0" cellspacing="0" cellpadding="2" class="dataGrid"
		   bordercolor="red">
		<tbody id="upcTable" >
			<tr bordercolor="blue">
				<td class="dataGridHead" width="9%" class="labelFont" align="center">
					<label for="selectedChannel" class="labelFont helpable" id="UPCTypeLabel">
						<em><font color="red"><b>*</b></font></em>UPC Type:
					</label>
				</td>
				<td class="dataGridHead" width="13%" class="labelFont" align="center">
					<label for="selectedChannel" class="labelFont helpable" id="UPCLabel">
						<em><font color="red"><b>*</b></font></em>Unit UPC:
					</label>
				</td>
				<td class="dataGridHead" width="4%" class="labelFont" align="center">
					<label for="selectedChannel" class="labelFont helpable" id="UPCBonusLabel">Bonus:
					</label>
				</td>
				<td class="dataGridHead" width="8%" class="labelFont" align="center">
					<label for="selectedChannel" class="labelFont helpable" id="UPCTotalSizeLabel">
						<em><font color="red"><b>*</b></font></em>Unit Size:
					</label>
				</td>
				<td class="dataGridHead" width="12%" class="labelFont" align="center">
					<label for="selectedChannel" class="labelFont helpable" id="UPCRetailUOMLabel">
						<em><font color="red"><b>*</b></font></em>Unit of Measure:
					</label>
				</td>
				<td class="dataGridHead" width="6%" class="labelFont" align="center">
					<label for="selectedChannel" class="labelFont helpable" id="UPCLengthLabel">Length:
					</label>
				</td>
				<td class="dataGridHead" width="6%" class="labelFont" align="center">
					<label for="selectedChannel" class="labelFont helpable" id="UPCWidthLabel">Width:
					</label>
				</td>
				<td class="dataGridHead" width="6%" class="labelFont" align="center">
					<label for="selectedChannel" class="labelFont helpable" id="UPCHeightLabel">Height:
					</label>
				</td>
				<td class="dataGridHead" width="6%" class="labelFont" align="center">
					<label for="selectedChannel" class="labelFont helpable" id="UPCSizeLabel">
						<em><font color="red"><b>*</b></font></em>Size:
					</label>
				</td>
				<td class="dataGridHead" width="22%" class="labelFont" align="center">
					<label for="selectedChannel" class="labelFont helpable" id="UPCSubBrandLabel">Sub Brand:
					</label>
				</td>
				<td class="dataGridHead" width="5%" class="labelFont" align="right">&nbsp;&nbsp;</td>
				<td class="dataGridHead" width="5%" class="labelFont" align="right">&nbsp;&nbsp;</td>
				<td class="dataGridHead" width="5%" class="labelFont" align="right">&nbsp;&nbsp;</td>
				<td class="dataGridHead" width="5%" class="labelFont" align="right">&nbsp;&nbsp;</td>
				<td class="dataGridHead" width="5%" class="labelFont" align="right">&nbsp;&nbsp;</td>
			</tr>
			<c:set var = "styleStr" value="display: none;position: absolute;"/>
			<c:if test="${addNewCandidate.productVO.classificationVO.classField == '42'}">
				<c:set var = "styleStr" value="display: block;position: relative;"/>
			</c:if>
			<c:forEach items="${addNewCandidate.productVO.upcVO}" var="upc" varStatus="loop" >
				<tr class="labelFont" id="Normal${loop.index}">
					<td align="center" width="6%" class="labelFont row${loop.index%2}">
						<c:out value="${upc.upcType}"></c:out>
					</td>
					<td align="center" width="16%" class="labelFont row${loop.index%2}">
						<c:choose>
							<c:when test="${upc.negative eq true}">
								004_Item_Code
							</c:when>
							<c:otherwise>								
									<c:out value="${upc.unitUpc}"></c:out> - <c:out value="${upc.checkDigit}"></c:out>
							</c:otherwise>
						</c:choose>
					</td>
					<td align="center" width="3%" class="row${loop.index%2}">
						<input type="checkbox" name="bonus" id="bonus" disabled="true"/>
					</td>
					<td align="center" width="9%" class="labelFont row${loop.index%2}">
							<c:out value="${upc.unitSize}"></c:out>
					</td>
					<td align="center" width="13%" class="labelFont row${loop.index%2}">
							<c:out value="${upc.unitMeasureDesc}"></c:out>
					</td>
					<td align="center" width="6%" class="labelFont row${loop.index%2}">
							<c:out value="${upc.length}"></c:out>
					</td>
					<td align="center" width="6%" class="labelFont row${loop.index%2}">
							<c:out value="${upc.width}"></c:out>
					</td>
					<td align="center" width="6%" class="labelFont row${loop.index%2}">
							<c:out value="${upc.height}"></c:out>
					</td>
					<td align="center" width="6%" class="labelFont row${loop.index%2}">
							<c:out value="${upc.size}"></c:out>
					</td>
					<td align="center" width="22%" class="labelFont row${loop.index%2}">
							<c:if test="${upc.subBrand!= null && upc.subBrand!=''}">
								<c:out value="${upc.subBrandDesc}"></c:out>[<c:out value="${upc.subBrand}"></c:out>]
							</c:if>
					</td>
					<td align="right" width="4%" class="row${loop.index%2}">
						<c:if test="${upc.wicUPC eq true && addNewCandidate.productVO.classificationVO.classField == '42'}">
							<a href='#' id='wicLinkView' onclick='showWic(this.value,true,false);return false;' value="${upc.wic}">WIC</a>
						</c:if>
					</td>
					<td align="center" width="5%" class="row${loop.index%2}">
						<c:if test="${upc.editable eq true}">
							<div>
								<cps:renderByResourceAccess resourceId="175" honorViewMode="${addNewCandidate.upcViewOverRide}">
									<jsp:attribute name="EXEC">
										<button type="button" id="deleteButton${loop.index}" name="deleteButton"
												value="Delete">
											Delete
										</button>
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</div>
						</c:if>
						<c:if test="${upc.editable eq false}">
							<div>
								<cps:renderByResourceAccess resourceId="175" honorViewMode="${addNewCandidate.upcViewOverRide}">
									<jsp:attribute name="EXEC">
										<button type="button" id="placeHolder" name="placeHolder" value="" style="visibility:hidden; position:static;">
											Delete
										</button>
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</div>
						</c:if>
					</td>
					<!-- trungnv add modify and save-->
					<td  align="center" width="5%" class="row${loop.index%2}">
						<c:if test="${upc.editable eq true}">
							<div>
								<cps:renderByResourceAccess resourceId="175" honorViewMode="${addNewCandidate.upcViewOverRide}">
									<jsp:attribute name="EXEC">
										<button type="button" id="modify${loop.index}" name="modify" value="modify">
											Modify
										</button>
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</div>
						</c:if>
						<c:if test="${upc.editable eq false}">
							<div>
								<cps:renderByResourceAccess resourceId="175" honorViewMode="${addNewCandidate.upcViewOverRide}">
									<jsp:attribute name="EXEC">
										<button type="button" id="placeHolderMf" name="placeHolderMf" value=""
												style="visibility:hidden; position:static;">
											Modify
										</button>
									</jsp:attribute>
								</cps:renderByResourceAccess>
							</div>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<form:hidden path="upcvo.selectedUpcType" styleId="hiddenUPC" id="hiddenUPC" />
	<%-- <form:hidden path="upcvo.selectedUnitUPC" styleId="hiddenUnitUPC" id="hiddenUnitUPC" /> --%>
	<form:hidden path="productVO.workRequest.intentIdentifier"/>
	<form:hidden path="productVO.activeProductKit"/>
	<div id="addrow" style="z-index: 4500">
		<cps:renderByResourceAccess resourceId="176" honorViewMode="${addNewCandidate.upcViewOverRide}">
			<jsp:attribute name="EXEC">
				<table id="last" align="center" width="100%" border="0" cellspacing="0" bordercolor="red"
					   cellpadding="2" class="dataGrid">
					<tr class="labelFont">
						<td align="center" width="6%">
							<select id="upcType1" cssClass="selectBoxStyle2" tabindex="10"
									onchange="upcTypeChange();">
								<option value="" styleId="select" id="select">--Select--</option>
							</select>
						<td align="right" width="14%">
							<div id="predigit4Div" style="display: none; position: relative;">
								<form:input id="preDigit"  style="dataType: numeric;width: 25px;"
											path="upcvo.preDigit" size="3" maxlength="3" tabindex="10" disabled="true"/>
								<input style="dataType: numeric;" styleId="unitUpcAuto" id="unitUpcAuto"
									   value="${upcvo.selectedUnitUPC}" size="10" maxlength="10"
									   tabindex="11" onchange="validateEntry(this);" onmousedown="validateEntry(this);"
									   onblur="generateCheckDigit(this.value);"/>
							</div>
							<div id="itmUpcDiv" style="display: none; position: relative">
								<input style="dataType: alpanumeric;" styleId="unitUpcItm" id="unitUpcItm"
									   value="${upcvo.selectedUnitUPC}" size="13" maxlength="13" tabindex="11"
									   disabled="true"/>
							</div>
							<div id="upcDiv" style="display: block; position: relative">
								<c:choose>
								<c:when test="${(addNewCandidate.productVO.workRequest.intentIdentifier == 12 ||
								addNewCandidate.productVO.activeProductKit == true) &&
								 !empty addNewCandidate.productVO.upcVO}">
									<input style="dataType: numeric;" styleId="unitUpc1" id="unitUpc1"
										   value="${upcvo.selectedUnitUPC}" size="13" maxlength="13" tabindex="11"
										   onchange="validateEntry(this);" onmousedown="validateEntry(this);"
										   onkeyup="autotab(this,'unitUpc12');return true;" onblur="invalid0(this);autoShowScale(this.value);"
										   disabled="true"/>
								</c:when>
									<c:otherwise>
										<input style="dataType: numeric;" styleId="unitUpc1" id="unitUpc1"
											   value="${upcvo.selectedUnitUPC}" size="13" maxlength="13" tabindex="11"
											   onchange="validateEntry(this);" onmousedown="validateEntry(this);"
											   onkeyup="autotab(this,'unitUpc12');return true;" onblur="invalid0(this);autoShowScale(this.value);"/>
									</c:otherwise>
								</c:choose>
							</div>
						</td>
						<td align="left" width="5%">
							<div id="chkdigitDiv" style="display: block; position: relative">
								<label for="selectedChannel" class="labelFont">-</label>
								<input id="unitUpc12" styleId="unitUpc12" style="dataType: numeric; width: 10px;"
										value="${upcvo.selectedUnitUPC1}" size="1" maxlength="1"
										tabindex="12" onblur="verifyCheckDigit();"/>
							</div>
						</td>
						<td align="center" width="4%">
							<form:checkbox path="upcvo.selectedBonus" styleId="upcScenario1" id="upcScenario1"
										   tabindex="13" onclick="clearCopyData();"/>
						</td>
						<td align="center" width="9%">
							<form:input styleId="unitSize1" id="unitSize1" style="dataType: float;"
										path="upcvo.selectedUnitSize" size="6" maxlength="6" tabindex="14"
										onblur="roundValue(this,2);showTestScanButton();return true;"/>
						</td>
						<td align="center" width="12%">
							<form:select path="upcvo.selectedUnitOfMeasure" tabindex="15" id="unitOfMeasure1"
										 cssClass="selectBoxStyle2" styleId="unitOfMeasure1">
                    		</form:select>
						</td>
						<td width="6%" align="center">
							<form:input styleId="length" id="length" style="dataType: float;" path="upcvo.selectedUPCLength"
										size="6" maxlength="8" tabindex="16" onblur="roundValue(this,2);return true;"/>
						</td>
						<td width="6%" align="center">
							<form:input styleId="width" id="width" style="dataType: float;" path="upcvo.selectedUPCWidth"
										size="6" maxlength="8" tabindex="17" onblur="roundValue(this,2);return true;"/>
						</td>
						<td width="6%" align="center">
							<form:input styleId="height" id="height" style="dataType: float;" path="upcvo.selectedUPCHeight"
										size="6" maxlength="8" tabindex="18" onblur="roundValue(this,2);return true;"/>
						</td>
						<td width="6%" align="center">
							<form:input styleId="size" id="size" path="upcvo.selectedUPCSize" size="6" maxlength="6"
										tabindex="19" style="TEXT-TRANSFORM: uppercase; dataType: alphanumericSpecial;"
										onblur="switchToUpperCase(this);showTestScanButton(); return true;"/>
						</td>
						<td align="left" width="23%">
							<cps:autoComplete2 forceSelection="false" jsonSearchMethodName="subBrandSearch"
											   autoHighlight="false" addNewLink="false" uniqueId="subbrand" tabindex="20" maxlength="30"
											   strutsHiddenElmProperty="upcvo.selectedSubBrand" strutsHiddenNameElmProperty="upcvo.selectedSubBrandName"
											   clearMethod="subBrandClear" zi="100" style="TEXT-TRANSFORM: uppercase; position: relative;"/>
						</td>
						<td align="right" width="3%">
							<form:hidden styleId="wic" path="upcvo.selectedWic" id="wic"/>
							<div id ="wicDiv1" style="${styleStr}">
								<a href='#' id='wicLink' onclick='showWic(this.value,"","");return false;' value='${upcvo.selectedWic}'>WIC</a>
							</div>
						</td>
						<td align="center" width="4%">
							<button type="button" id="addButton" name="addButton" value="Add" tabindex="21">Add</button>
						</td>
					</tr>
				</table>
			</jsp:attribute>
		</cps:renderByResourceAccess>
	</div>
	<!-- New Row For PLU -->
	<input type="hidden" id="newRowClicked" name="newRowClicked" value=""/>
	<div id="onemore" style="display:  none; z-index: 1000;">
	<cps:renderByResourceAccess resourceId="176" honorViewMode="${addNewCandidate.upcViewOverRide}">
		<jsp:attribute name="EXEC">
			<table id="secondlast" align="center" width="100%" border="0" cellspacing="0" bordercolor="red"
				   cellpadding="2" class="dataGrid">
				<tr class="labelFont">
					<td align="center" width="6%">
						<select value="${upcvo.selectedUpcType}" tabindex="25" id="upcTypeNew1"
								cssClass="selectBoxStyle2" styleId="upcTypeNew1">
							<option value="PLU">PLU</option>
							<option value="" styleId="select" id="select" >--Select--</option>
                    	</select>
					</td>
					<td align="right" width="14%">
						<form:input style="dataType: numeric;" styleId="unitUpcNew1" id="unitUpcNew1"
									path="upcvo.selectedUnitUPCNew" size="13" maxlength="13"
									tabindex="26" onkeyup="autotab(this,'unitUpc13');return true;" readonly="true"/>
					</td>
					<td align="left" width="5%">
						<div id="chkdigitDiv1" style="display: block; position: relative">
							<label for="selectedChannel" class="labelFont"> - </label>
							<input styleId="unitUpc13" id="unitUpc13" style="dataType: numeric; width: 10px;"
										path="${upcvo.selectedUnitUPC1}" size="1" maxlength="1" tabindex="27"
										onblur="verifyCheckDigit();"/>
						</div>
					</td>
					<td align="center" width="4%">
						<!--Will recheck it null-->
						<form:checkbox path="upcvo.selectedBonus" styleId="upcScenarioNew1" id="upcScenarioNew1"
									   tabindex="28" onclick="clearCopyData2();"/>
					</td>
					<td align="center" width="9%">
						<form:input styleId="unitSizeNew1" id="unitSizeNew1" style="dataType: float;"
									path="upcvo.selectedUnitSizeNew" size="6" maxlength="8" tabindex="29"
									onblur="roundValue(this,2);return true;"/>
					</td>
					<td align="center" width="12%">
						<form:select path="upcvo.selectedUnitOfMeasureNew" tabindex="30" id="unitOfMeasureNew1"
									 cssClass="selectBoxStyle2" styleId="unitOfMeasureNew1">
                    	</form:select>
					</td>
					<td width="6%" align="center">
						<form:input styleId="lengthNew" id="lengthNew" style="dataType: float;" path="upcvo.selectedUPCLengthNew"
									size="6" maxlength="8" tabindex="31" onblur="roundValue(this,2);return true;"/>
					</td>
					<td width="6%" align="center">
						<form:input styleId="widthNew" id="widthNew" style="dataType: float;" path="upcvo.selectedUPCWidthNew"
								   size="6" maxlength="8" tabindex="32" onblur="roundValue(this,2);return true;"/>
					</td>
					<td width="6%" align="center">
						<form:input styleId="heightNew" id="heightNew" style="dataType: float;" path="upcvo.selectedUPCHeightNew"
								   size="6" maxlength="8" tabindex="33" onblur="roundValue(this,2);return true;"/>
					</td>
					<td width="6%" align="center">
						<form:input styleId="sizeNew" id="sizeNew" path="upcvo.selectedUPCSizeNew" size="6" maxlength="6"
									tabindex="34" style="TEXT-TRANSFORM: uppercase; dataType: alphanumericSpecial;"
									onkeyup="switchToUpperCase(this); return true;"/>
					</td>
					<td align="left" width="23%">
						<cps:autoComplete2 forceSelection="false" jsonSearchMethodName="subBrandSearch"
										   autoHighlight="false" uniqueId="subbrandNew" tabindex="35"
										   strutsHiddenElmProperty="upcvo.selectedSubBrandNew"
										   strutsHiddenNameElmProperty="upcvo.selectedSubBrandNewName"
										   clearMethod="subBrandNewClear" zi="3000" style="position: relative;"/>
					</td>
					<td align="right" width="3%">
						<form:hidden styleId="wicNew" id="wicNew" path="upcvo.selectedWicNew"/>
						<div id ="wicDiv2" style="${styleStr}">
							<a href='#' id='wicNewLink' onclick='showWic(this.value,false,true);return false;' value=''>WIC</a>
						</div>
					</td>
					<td align="center" width="4%">
						<button type="button" id="addButtonNew" name="addButtonNew" value="Add" tabindex="36">Add
						</button>
					</td>
				</tr>
			</table>
		</jsp:attribute>
	</cps:renderByResourceAccess>
</div>
</fieldset>

<cps:renderByResourceAccess resourceId="176" honorViewMode="${addNewCandidate.upcViewOverRide}">
	<jsp:attribute name="EXEC">

<script type="text/javascript">
	var oPushButton1 = new YAHOO.widget.Button("addButton");
	var oPushButton2 = new YAHOO.widget.Button("addButtonNew");
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButton"), "click", addUpc);
    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addButtonNew"), "click", addUpcNew);

	var upcType = YAHOO.util.Dom.get("upcType1");
	var unitUpc = YAHOO.util.Dom.get("unitUpc1");
	var unitUpc10 = YAHOO.util.Dom.get("unitUpc12");
	var length1 = YAHOO.util.Dom.get("length");
	var width1 = YAHOO.util.Dom.get("width");
	var height1 = YAHOO.util.Dom.get("height");
	var size = YAHOO.util.Dom.get("size");
	var subbrand = YAHOO.util.Dom.get("subbrandStrutsHiddenElm");
	var unitSize = YAHOO.util.Dom.get("unitSize1");
	var unitOfMeasure = YAHOO.util.Dom.get("unitOfMeasure1");
	var upcScenario = YAHOO.util.Dom.get("upcScenario1");
	var wic = YAHOO.util.Dom.get("wic");

	var upcTypeNew = YAHOO.util.Dom.get("upcTypeNew1");
	var unitUpcNew = YAHOO.util.Dom.get("unitUpcNew1");
	var unitUpcNew13 = YAHOO.util.Dom.get("unitUpc13");
	var lengthNew1 = YAHOO.util.Dom.get("lengthNew");
	var widthNew1 = YAHOO.util.Dom.get("widthNew");
	var heightNew1 = YAHOO.util.Dom.get("heightNew");
	var sizeNew = YAHOO.util.Dom.get("sizeNew");
	var subbrandNew = YAHOO.util.Dom.get("subbrandNewStrutsHiddenElm");
	var unitSizeNew = YAHOO.util.Dom.get("unitSizeNew1");
	var unitOfMeasureNew = YAHOO.util.Dom.get("unitOfMeasureNew1");
	var upcScenarioNew = YAHOO.util.Dom.get("upcScenarioNew1");
	var unitUpcItm = YAHOO.util.Dom.get("unitUpcItm");
	var unitUpcAuto = YAHOO.util.Dom.get("unitUpcAuto");
	var preDigit = YAHOO.util.Dom.get("preDigit");
	var wicNew = YAHOO.util.Dom.get("wicNew");
	var newUnp='';
	var sbName=YAHOO.util.Dom.get("subbrandStrutsHiddenNameElm");
	var sbNameNew=YAHOO.util.Dom.get("subbrandNewStrutsHiddenNameElm");
	<c:url var="subBrandPopUp" value="/protected/cps/add/addSubBrand?${_csrf.parameterName}=${_csrf.token}"></c:url>
	function addSubBrand(data){
		var subBrand = data.value;
		f1('${subBrandPopUp}'+'&newSubBrand='+subBrand+'&t='+new Date().getTime(),'Add a New Sub Brand','100px','40%','400px','400px');
	}
	
	function validateEntry(upcTF){
		var strString = upcTF.value+"";
		var strValidChars = "0123456789";
		var strChar;
		var blnResult = true;
		if (strString.length > 0) {
			for (i = 0; i < strString.length; i++){
				strChar = strString.charAt(i);
				if (strValidChars.indexOf(strChar) == -1){
					blnResult = false;
					break;
				}
			}
		}
		if(blnResult == false){
			upcTF.value = "";
		}
        //YAHOO.util.Dom.get("hiddenUnitUPC").value= upcTF.value;
	}
	
	function callAjaxSetScaleIsTrue(){
		showProgress();
		var callbacks = {
				success : function(o) {
					try {
						if (o != null && o.responseText != "") {
							if("true" == myTrim(o.responseText)){
								showScaleAttribute(true);
							}
							
						}
						hideTheProgress();
					} catch (e) {

						hideTheProgress();
						return;
					}
				},
				failure : function() {
					hideTheProgress();
				},
				timeout : 50000
			};
			YAHOO.util.Connect.asyncRequest('GET',
				"setScaleIsTrue", callbacks);
	}
	
	function autoShowScale(unitUpc1){
			var scaleAttribDiv = YAHOO.util.Dom.get("scaleAttribDiv");
			if(upcTableBody.rows.length > 1 && scaleAttribDiv.style.display == 'block'){}else{
				if(null != unitUpc1){
					if("002" == unitUpc1.substring(0,3) && "00000" == unitUpc1.substring(8,13)){
						callAjaxSetScaleIsTrue();
					<c:if test="${addNewCandidate.userRole eq 'RVEND'}">
						if(document.getElementById('engDescLine1Required')){
							document.getElementById('engDescLine1Required').style.color = 'white';
						}
						if(document.getElementById('engDescLine2Required')){
							document.getElementById('engDescLine2Required').style.color = 'white';
						}						
						if(document.getElementById('prePackRequired')){
							document.getElementById('prePackRequired').style.color = 'white';
						}
						if(document.getElementById('shelfLifeDaysRequired')){
							document.getElementById('shelfLifeDaysRequired').style.color = 'white';
						}
					</c:if>
					<c:if test="${(addNewCandidate.userRole eq 'ADMIN' || addNewCandidate.userRole eq 'PIA' || addNewCandidate.userRole eq 'PIAL')}">
						
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
					
					}else{
						 scaleAttribDiv.style.display = 'none';
						 scaleAttribDiv.style.position = 'absolute';
						 setColorForBrandCFD("red");
					}
				}else{
					 scaleAttribDiv.style.display = 'none';
					 scaleAttribDiv.style.position = 'absolute';
					 setColorForBrandCFD("red");
				}
			}
	}
	
	 function autotab(original,unitUpc12)
	 {
		if(original.value.length == original.getAttribute("maxlength")){
			if(document.getElementById(unitUpc12)){
				if(document.getElementById(unitUpc12).style.display != "none"){
					document.getElementById(unitUpc12).focus();
					
				}
			}
		}
	}


	function init(){
	   	upcType.value = document.getElementById('select').value;
		unitUpc.value = '';
		unitUpc10.value = '';
		unitOfMeasure.value = document.getElementById('select').value;
		unitSize.value = '';
		length1.value = '';
		width1.value = '';
		height1.value = '';
		size.value = '';
		subbrand.value = '';
		upcScenario.checked = false;
		unitUpcItm.value = '';
		unitUpcAuto.value = '';
		preDigit.value = '';
		wic.value='';
		YAHOO.util.Dom.get("wicLink").value = '';
		displaySelectedUpcDiv();
		var mode = ${addNewCandidate.modifyMode};
		if(mode == true){
			document.getElementById('addrow').style.display = 'block';
		}
		else{
			document.getElementById('addrow').style.display = 'none';
		}
	}

	<c:if test="${addNewCandidate.questionnarieVO.selectedOption!='4'}">
		init();
	</c:if>

	<c:url var="pluPopUp" value="/protected/cps/add/pluGeneration?${_csrf.parameterName}=${_csrf.token}"></c:url>
	
	function displaySelectedUpcDiv(){
		//Display the corresponding divs
		if(upcType.options[upcType.selectedIndex].value == 'ITUPC'){
			document.getElementById('itmUpcDiv').style.display = 'block';
			document.getElementById('predigit4Div').style.display = 'none';
			document.getElementById('chkdigitDiv').style.display = 'none';
			document.getElementById('upcDiv').style.display = 'none';

		}else if(upcType.options[upcType.selectedIndex].value == '04UPC'){
			document.getElementById('itmUpcDiv').style.display = 'none';
			document.getElementById('predigit4Div').style.display = 'block';
			document.getElementById('chkdigitDiv').style.display = 'block';
			document.getElementById('upcDiv').style.display = 'none';

		}else{
			document.getElementById('itmUpcDiv').style.display = 'none';
			document.getElementById('predigit4Div').style.display = 'none';
			document.getElementById('chkdigitDiv').style.display = 'block';
			document.getElementById('upcDiv').style.display = 'block';
		}
	}

	var saveUPCHook = false;
	var goToNextTabHook = null;

	function upcTypeChange(){
		clearAll();
		displaySelectedUpcDiv();
		document.getElementById('onemore').style.display='none';
		clearData2();
		//clearDataNewRequired1338();
		if(upcTableBody == null || upcTableBody == undefined){
			upcTableBody = YAHOO.util.Dom.get("upcTable");
		}
		if(upcTableBody.rows.length > 1 && firstRowAvailable())
		{
				copyDataTonewRow();
		}
		var scaleAttribDiv = YAHOO.util.Dom.get("scaleAttribDiv");
		if(upcTableBody.rows.length <= 1){
			autoShowScale(null);
		}
		
		if(upcType.options[upcType.selectedIndex].value == 'PLU'){
			document.getElementById('unitUpc1').readOnly=true;
			document.getElementById('unitUpcNew1').readOnly=true;
			document.getElementById('unitUpc12').readOnly=true;
			document.getElementById('unitUpc13').readOnly=true;
			f1('${pluPopUp}'+'&t='+new Date().getTime(),'PLU Generation','220px','60%','130px','200px');
			saveUPCHook = true;


		}else if(upcType.options[upcType.selectedIndex].value == 'HEB'){
			document.getElementById('unitUpc1').readOnly=true;
			//document.getElementById('unitUpcNew1').readOnly=true;
			document.getElementById('unitUpc12').readOnly=true;
			//document.getElementById('unitUpc13').readOnly=true;
			confirmationMessage();

			saveUPCHook = true;


		}else if(upcType.options[upcType.selectedIndex].value == 'UPC'){
			document.getElementById('unitUpc1').readOnly=false;
			//document.getElementById('unitUpcNew1').readOnly=false;
			document.getElementById('unitUpc12').readOnly=false;
			//document.getElementById('unitUpc13').readOnly=false;

			saveUPCHook = true;

		}else if(upcType.options[upcType.selectedIndex].value == 'ITUPC'){
			document.getElementById('unitUpcItm').value='004_Item_Code';
			document.getElementById('unitUpcItm').readOnly=true;
			saveUPCHook = true;
            //YAHOO.util.Dom.get("hiddenUnitUPC").value= upcTF.value;

		}else if(upcType.options[upcType.selectedIndex].value == '04UPC'){
			upcRandomNumberGenerator();
			document.getElementById('unitUpcAuto').readOnly=false;
			document.getElementById('unitUpc12').readOnly=true;
			document.getElementById('preDigit').readOnly=true;
			saveUPCHook = true;

		}else{
			document.getElementById('unitUpc1').readOnly=false;
			document.getElementById('unitUpcNew1').readOnly=false;
			document.getElementById('unitUpc12').readOnly=false;
			document.getElementById('unitUpc13').readOnly=false;
			saveUPCHook = false;
		}
	}

	function upcRandomNumberGenerator(evt){
	 var tmp = upcType.selectedIndex;
	 var upcValue = upcType.options[tmp].text;
		if(document.getElementById('prodTypeSelect')){
			prodTypeSelect = document.getElementById('prodTypeSelect');
			productType = prodTypeSelect.options[prodTypeSelect.selectedIndex].value;
		}else if (document.getElementById('prodTypetxt')){
			productType = document.getElementById('prodTypetxt').value;
		}
	 AddCandidateTemp.randomNumberGenerator(upcValue,productType,getDWRCallbackMethod(generatedUPC));
	}

	function generatedUPC(data){
		if(data !="" && data !=null) {
			// Defect #33 merged with US Tech code
      		document.getElementById("unitUpcAuto").value =data;
			// Defect #33 merged with US Tech code
      		document.getElementById("preDigit").value ='004';
      		generateCheckDigit(data);
		}
		YAHOO.util.Dom.get("hiddenUPC").value= YAHOO.util.Dom.get("upcType1").value;
	}

	function checkDSVCallbacks(message){
		return message;
	}
	
	function checkItemDSV(unitUpc1){
		showProgress();
		var callbacks = {
				success : function(o) {
					try {
						if (o != null && o.responseText != "") {
							checkDSVCallbacks(myTrim(o.responseText));
						}
					} catch (e) {
						return;
					}
				},
				failure : function() {
					hideTheProgress();
				},
				timeout : 5000
			};
			YAHOO.util.Connect
					.asyncRequest(
							'GET',
							"removedDisableScaleAtt",
							callbacks);
	}
	
	var upcTableBody = YAHOO.util.Dom.get("upcTable");
	var normalDivShown = false;
	var newDivShown = false;
	function addUpc(evt){
		upcAdded = false;
		var tmp = upcType.selectedIndex;
		var upcValue = upcType.options[tmp].text;
		var tmp = unitOfMeasure.selectedIndex;
		var unitMeasureDesc = unitOfMeasure.options[tmp].text;
		var unitMeasureCode = unitOfMeasure.options[tmp].value;
		var scnrio = upcScenario.checked;
		var unitUpc1 = unitUpc.value;
		var unitUpc12 = unitUpc10.value;
		var productType = '';
		var wicValue = wic.value;
		var subbranName=sbName.value;
		var subbrandInput=document.getElementById('subbrandACInput').value;
		
		if(subbranName!=subbrandInput)
		{
			subbrand.value='';
		}
		if(document.getElementById('prodTypeSelect')){
			prodTypeSelect = document.getElementById('prodTypeSelect');
			productType = prodTypeSelect.options[prodTypeSelect.selectedIndex].value;
		}else if (document.getElementById('prodTypetxt')){
			
			productType = document.getElementById('prodTypetxt').value;
		}
		if(upcValue == '04UPC'){
			var predgt = preDigit.value;
			var upcAuto = unitUpcAuto.value;
			if(upcAuto != "" && upcAuto!= null){
				unitUpc1 = ""+ predgt + upcAuto;
			}else{
				doWhenUPCsectionInvalid();
				alert("This portion of the UPC cannot be empty");
			}
		}

		if(upcValue == 'ITUPC'){
			unitUpc1 = unitUpcItm.value;
		}
		if((unitUpc1!=null && unitUpc1 !="") &&
				document.getElementById('upcTble') &&
				filter(unitUpc1,"upcTble")==true){
			unitUpc.readOnly=false;
			unitUpc12.readOnly=false;
			doWhenUPCsectionInvalid();
			alert("The entered UPC "+ unitUpc1 +" is already existing in the list!");

			return;
		}
		var uom = document.getElementById("unitOfMeasure1");
		//Sprint - 23
		if(isWorkingKitComponents()) {
			if (upcTableBody.rows.length > 1) {
				alert("A Kit candidate can only have one selling unit UPC.");
				document.getElementById('unitUpc1').value='';
				document.getElementById('unitUpc1').disabled = true;	// PIM-1527 disable Unit UPC of Kit Component
				document.getElementById('unitUpc12').value='';
				document.getElementById('upcScenario1').checked=false;
				document.getElementById('unitSize1').value='';
				document.getElementById('length').value='';
				document.getElementById('width').value='';
				document.getElementById('height').value='';
				document.getElementById('size').value='';
				document.getElementById('subbrandACInput').value='';
				document.getElementById('unitUpc1').readOnly=false;
				return false;
			}
			
			if(unitUpc1=="" && size.value.trim().length>0 && unitSize.value.trim().length>0 && uom.options[uom.selectedIndex].text!='--Select--')
			{
				doWhenUPCsectionInvalid();
				alert("Please enter Unit UPC fields");
				hideProgress();
				return false;
			}
		}
		var s = size.value;
		//SPRINT 22
	
		if(unitUpc1=="" || size.value.trim().length==0 || unitSize.value.trim().length==0 || uom.options[uom.selectedIndex].text=='--Select--')
		{
			doWhenUPCsectionInvalid();
			alert("Please enter Unit UPC, Unit Size, Unit of Measure, Size fields");
			hideProgress();
			return false;
		}

		showProgress();
		AddCandidateTemp.addUPC(upcValue,unitUpc1,unitUpc12,scnrio,unitSize.value,unitMeasureDesc,unitMeasureCode,length1.value,width1.value,height1.value,s,subbrand.value,productType,wicValue,subbranName,getDWRCallbackMethod(wrapperUPC1));
	}

	//HungBang added extract Upc func. 18Feb2016
	function extractUpc(value){
		return value.match(/[0-9]{13}/g);
	}

	function filter (phrase, _id){
		var words = phrase.toLowerCase();
		var table = document.getElementById(_id);
		var ele;
		var existing = false;
		for (var r = 1; r < table.rows.length; r++){
			ele = table.rows[r].innerHTML.replace(/<[^>]+>/g,"");
			if(extractUpc(myTrim(ele)) == words){
				existing = true;
				break;
			}
		}
		return existing;
	}

	<c:url value="/protected/cps/add/fetchCandidateFromUPC?${_csrf.parameterName}=${_csrf.token}" var="getCand"></c:url>
	<c:url value="/protected/cps/add/questionnaireWrapper?${_csrf.parameterName}=${_csrf.token}" var="question"></c:url>
	function wrapperUPC1(data){
		if(data.message == "UPCEXISTS") {
		    hideProgress();
		    var message = confirm('The entered UPC already exists. Do you want to add a new Case Pack to the product which contains the entered UPC?');
		    if(message){
		    	fetchExistingUpc(data.unitUpc);
		    }
		    else {
		    clearData();
		    doWhenUPCsectionInvalid();
		    document.getElementById('onemore').style.display = 'none';
		    clearData2();
			if(document.getElementById('addrow').style.display == 'none'){
				document.getElementById('addrow').style.display = 'block';
				document.getElementById('wicLink').value = '';
			}
			YAHOO.util.Dom.get("upcType1").disabled = false;
		    document.getElementById('unitUpc1').readOnly=false;
		    showProgress();
		    wrapperUPC1CallBack(data);
		    piaMandatoryScaleAttribs(data);
		    hideProgress();
		    }
		} else if(data.message == "SUCCESS"){
			data.message = "";
			wrapperUPC1CallBack(data);
			// enable the test scan button.
			nonSellableHide();
			piaMandatoryScaleAttribs(data);
			//enable Scale Attribute
			var upcLst = new Array();
			upcLst[0] = data.unitUpc;
			var scaleAttribDiv = YAHOO.util.Dom.get("scaleAttribDiv");
			if(scaleAttribDiv.style.display == "none"){
				scaleAttShow(upcLst);
			}
			changeFdaMenuLabelingStatus(data);
			hideProgress();
			//Refresh nutritin facts
			refreshDataForNutritionFacts();
		} else {
			hideProgress();
			var hasAlerted = false;
			if(data.message == "107" || data.message == "109"){
				var shouldLeave = confirm("This UPC is tied to a Working Candidate/Activation Failed. \nDo you want to edit the candidate which contains the entered UPC?");
				hasAlerted = true;
				saveUPCHook = false;
				if(shouldLeave){
					showProgress();
					document.forms[0].action = '${getCand}'+'&SelectedUPC='+data.unitUpc;
					document.forms[0].submit();
				}
			}else if(data.message == "103" || data.message == "105"){
				alert("This UPC is tied to a Vendor Candidate/Rejected Candidate. \nPlease wait for the vendor to submit or reject.");
				hasAlerted = true;
				saveUPCHook = false;
				document.forms[0].action = '${question}';
				document.forms[0].submit();
			}
			if(hasAlerted){
				clearData();
			    document.getElementById('onemore').style.display = 'none';
			    clearData2();
				if(document.getElementById('addrow').style.display == 'none'){
					document.getElementById('addrow').style.display = 'block';
					document.getElementById('wicLink').value = '';
				}
				YAHOO.util.Dom.get("upcType1").disabled = false;
			    document.getElementById('unitUpc1').readOnly=false;
			    showProgress();
			    wrapperUPC1CallBack(data);
			    hideProgress();
			}else if(data.messageCheckDSV != ""){
				doWhenUPCsectionInvalid();
				alert(data.messageCheckDSV);
			}else{
				doWhenUPCsectionInvalid();
				alert(data.message);
			}
		}
		loadUPCTypeDefault();
	}

	<c:url value="/protected/cps/add/fetchUPCProduct?${_csrf.parameterName}=${_csrf.token}" var="actn"></c:url>
	function scaleAttShow(upcLst){
		AddCandidateTemp.checkScaleAttBasedOnUpc(upcLst, getDWRCallbackMethod(showScaleAttribute));
	}
	
	function fetchExistingUpc(unitUpc) {
	 showProgress();
	 document.forms[0].action = '${actn}'+'&SelectedUPC='+unitUpc;
	 document.forms[0].submit();
	}

    function wrapperUPC1CallBack(data){
      	if(data.message =="" || data.message ==null) {
			addRowToUPCTable(data);
			if(normalDivShown){
				document.getElementById('addrow').style.display = 'none';
				normalDivShown = false;
			}
			if(!(newDivShown || normalDivShown)){
				document.getElementById('addrow').style.display = 'block';
			    YAHOO.util.Dom.get("upcType1").disabled = false;
				document.getElementById('unitUpc1').readOnly=false;
				document.getElementById('wicLink').value = '';
				clearData();

				copyDataTonewRow();
			}
			saveUPCHook = false;

			//this var is used by AddCandidateOtherInfo for testscan
			upcAdded=true;

			//Check whether the Checker and Scale PLU is added
			if(document.getElementById('onemore').style.display == 'block'){
				saveNewUPCHook = true;
				addUpcNew();
			}else{
				if(goToNextTabHook != null){
					goToNextTabHook();
					goToNextTabHook = null;
				}
			}
			enableActivationUPC(data);
		}else {
			hideProgress();
			if(data.message == "UPCEXISTS")
			{
				newDivShown=false;
			}
			else {
				 if(data.message != '107' && data.message != '103'&& data.message != '105' && data.message != '109'){
				 	if(data.message != 'SUCCESS'){
					 	alert(data.message);
					}
				 }
			}
		}
		doWhen2DivIsNone();
	}

    function enableActivationUPC(data){
    	piaMandatoryScaleAttribs(data);
		AddCandidateTemp.enableActivateButton(getDWRCallbackMethod(enableActivationUPC_CB));
	}

	function enableActivationUPC_CB(data){
		if(document.getElementById('activateButton')){
			document.getElementById('activateButton').disabled = !data;
		}
	}

	function enableTescScanButtonUPC(testScanNeeded){
		var testScanBtn = YAHOO.util.Dom.get("testScanBut");
		if(testScanBtn){
			YAHOO.util.Event.removeListener(testScanBtn, "click");
			if(testScanNeeded == true){
				testScanBtn.disabled = false;
				if(prodType == "GOODS"){
					YAHOO.util.Event.addListener(testScanBtn, "click", testScan);
				}
			}else{
				testScanBtn.disabled = true;
				if(prodType == "GOODS"){
					YAHOO.util.Event.removeListener(testScanBtn, "click");
				}
			}
		}
	}

	function initBrickAfterDeleteUpc(data){
		var msgData = data.messages;
		if(! msgData.exception){
			if(!data.appData.valid){
				resetBrick();
			}
		}else{
			alert(msgData);
		}
	}

	function addUpcNew(evt){
        var tmp1 = upcTypeNew.selectedIndex;
		var upcValue1 = upcTypeNew.options[tmp1].text;
		var tmp1 = unitOfMeasureNew.selectedIndex;
		var unitMeasureDesc1 = unitOfMeasureNew.options[tmp1].text;
		var unitMeasureCode1 = unitOfMeasureNew.options[tmp1].value;
		var scnrio1 = upcScenarioNew.checked;
		var unitUpc11 = unitUpcNew.value;
		var unitUpc121 = unitUpcNew13.value;
		var productType = '';
		var wicValue = wicNew.value;
		var subbrandNameNew=sbNameNew.value;
		var subbrandNewInput=document.getElementById("subbrandNewAcInput").value;

		if(subbrandNameNew!=subbrandNewInput)
		{
			subbrandNew.value='';
		}
		if(document.getElementById('prodTypeSelect')){
			prodTypeSelect = document.getElementById('prodTypeSelect');
			productType = prodTypeSelect.options[prodTypeSelect.selectedIndex].value;
		}else if (document.getElementById('prodTypetxt')){
			productType = document.getElementById('prodTypetxt').value;
		}
		var s1 = sizeNew.value;
		if(unitUpc11=="" || s1.trim().length==0 || unitSize.value.trim().length==0 || unitMeasureDesc1=='--Select--')
		{
			doWhenUPCsectionInvalid();
			alert("Please enter Unit UPC, Unit Size, Unit of Measure, Size fields");
			hideProgress();
			return false;
		}
		showProgress();
		AddCandidateTemp.addUPC(upcValue1,unitUpc11,unitUpc121,scnrio1,unitSizeNew.value,unitMeasureDesc1,unitMeasureCode1,lengthNew1.value,widthNew1.value,heightNew1.value,s1,subbrandNew.value,productType,wicValue,subbrandNameNew,getDWRCallbackMethod(wrapperCallback));
	}

	/*
	 * CallBack for Scale PLU
	 */
    function wrapperCallback(data){
	 if (data.message == 'SUCCESS') {
		data.message = "";
	 }

	 if(data.message =="" || data.message ==null) {
		
  		addRowToUPCTable(data);
		if(newDivShown){
		document.getElementById('onemore').style.display = 'none';
		clearData2();
		copyDataTonewRow();
		newDivShown = false;
		}
		if(!(newDivShown || normalDivShown)){
		document.getElementById('addrow').style.display = 'block';
		YAHOO.util.Dom.get("upcType1").disabled = false;
		document.getElementById('unitUpc1').readOnly=false;
		document.getElementById('wicLink').value = '';
		clearData();
		copyDataTonewRow();
		}
		saveNewUPCHook = false;
		if(goToNextTabHook != null){
			goToNextTabHook();
			goToNextTabHook = null;
		}
		piaMandatoryScaleAttribs(data);
		var upcLst = new Array();
		upcLst[0] = data.unitUpc;
		var scaleAttribDiv = YAHOO.util.Dom.get("scaleAttribDiv");
		if(scaleAttribDiv.style.display == "none"){
			scaleAttShow(upcLst);
		}
		changeFdaMenuLabelingStatus(data);
		hideProgress();
		//Refresh nutrition facts data
		refreshDataForNutritionFacts();
	}else {
			hideProgress();
			if(data.message == "UPCEXISTS"){
				var message = confirm('The entered UPC already exists. Do you want to add a new Case Pack to the product which contains the entered UPC?');
				if(message){
					fetchExistingUpc(data.unitUpc);
				}
				else {
					clearData();
					document.getElementById('onemore').style.display = 'none';
					clearData2();
					if(document.getElementById('addrow').style.display == 'none'){
						document.getElementById('addrow').style.display = 'block';
						document.getElementById('wicLink').value = '';
					}
					YAHOO.util.Dom.get("upcType1").disabled = false;
					document.getElementById('unitUpc1').readOnly=false;
					showProgress();
					wrapperUPC1CallBack(data);
					piaMandatoryScaleAttribs(data);
					hideProgress();
				}
			}
			else {
				if(data.message == "107" || data.message == "109"){
					var shouldLeave = confirm("This UPC is tied to a Working Candidate. \nDo you want to edit the candidate which contains the entered UPC?");
					hasAlerted = true;
					saveUPCHook = false;
					if(shouldLeave){
						showProgress();
						document.forms[0].action = '${getCand}'+'&SelectedUPC='+data.unitUpc;
						document.forms[0].submit();
					}
				}else if(data.message == "103" || data.message == "105"){
					alert("This UPC is tied to a Vendor Candidate. \nPlease wait for the vendor to submit or reject.");
					hasAlerted = true;
					saveUPCHook = false;
					document.forms[0].action = '${question}';
					document.forms[0].submit();
				} else {
					alert(data.message);
					if(unitSizeNew.value!='' && sizeNew.value!='') {
						clearData();
						document.getElementById('onemore').style.display = 'none';
						clearData2();
						if(document.getElementById('addrow').style.display == 'none'){
							document.getElementById('addrow').style.display = 'block';
							document.getElementById('wicLink').value = '';
						}
						YAHOO.util.Dom.get("upcType1").disabled = false;
						document.getElementById('unitUpc1').readOnly=false;
						piaMandatoryScaleAttribs(data);
					}
				}
			}
		}
		doWhen2DivIsNone();
	}

	var addCount = 0;

	function addRowToUPCTable(data){
		
		if(data.message !="" && data.message !=null) {
      		   if(data.message !="UPCEXISTS"){
      		   alert(data.message);
	      		   if(data.fieldName != null){
	      		     try{
	      		    document.getElementById(data.fieldName).focus();}catch(e){}
	      		   }
      		   }
				YAHOO.util.Dom.get("upcType1").disabled = false;
		         //YAHOO.util.Dom.get("upcTypeNew1").disabled = false;
		         document.getElementById('unitUpc1').readOnly=false;
		         //document.getElementById('unitUpcNew1').readOnly=false;
        	}
      		else {

        		<c:if test="${!addNewCandidate.upcValueFromMRT}">
				document.getElementById('unitUpc1').disabled = false;
				document.getElementById('upcType1').disabled = false;
				YAHOO.util.Dom.get("unitUpc12").disabled = false;
			</c:if>
			addCount++;
			var rowLength = upcTableBody.rows.length;
			var tmp = addCount;
			var newRow = upcTableBody.insertRow(-1);
			newRow.style.fontFamily = 'Verdana, Arial, Helvetica, sans-serif';
			newRow.style.fontSize = '12px';
			newRow.id = 'Ajax'+tmp;
			var classAppend = rowLength % 2;
			if(classAppend == 0){
				var col;
				col = "#F7F7F7";
			}else{
				col = "#FFFFFF";
			}
			//newRow.class="labelFont";
			rowLength--;

			var butId = "deleteButtonAjax"+addCount;
			var butIdModify = "modifyButtonAjax"+addCount;

			<c:url var="img" value="${request.getContextPath()}/hebAssets/images/buttons/delete_normal.PNG"/>
			<c:url var="imgOver" value="${request.getContextPath()}/hebAssets/images/buttons/delete_click.PNG"/>

			<c:url var="imgM" value="${request.getContextPath()}/hebAssets/images/buttons/modify_nomal2.PNG"/>
			<c:url var="imgOverM" value="${request.getContextPath()}/hebAssets/images/buttons/modify_over.PNG"/>

			var but = "<div id='divDelete"+newRow.id+"'><a id='link"+addCount+"'>" +
				"<img src='${img}' alt='' name='"+butId+"'  border='0' id='"+butId+"'"+
				"</a></div>";

			var but2 = "<div id='divModify"+newRow.id+"'><a id='linkM"+addCount+"'>" +
				"<img src='${imgM}' alt='' name='"+butIdModify+"'  border='0' id='"+butIdModify+"'"+
				"</a></div>";
			var chk = null;

			if(data.bonus){
				chk = "<input type='checkbox' id='checkAjax"+addCount+"' disabled='disabled' checked = 'checked'>";
			}
			else{
				chk = "<input type='checkbox' id='checkAjax"+addCount+"' disabled='disabled'>";
			}

			var wic = "";
			var wicVal = data.wic;
			if(wicVal != null && wicVal != ""){
				wic = "<a href='#' onclick='showWic(this.value,true,false);return false;' value="+wicVal+">WIC</a>";
			}

			var actualUPC = "";
			var prodType = dwr.util.getValue("prodTypeSelect"); 
			if(data.upcType == "ITUPC"){
				actualUPC = '004_Item_Code';
			}else{
				actualUPC = data.unitUpc +  '-' + data.unitUpc10;
			}

			var tempText='';
			var tempText2='';
			var rowData = [
				data.upcType,
				actualUPC,
				chk,
				data.unitSize,
				data.unitMeasureDesc,
				data.length,
				data.width,
				data.height,
				data.size,
				data.subBrandDesc,
				wic,
				but,
				but2,
				tempText,
				tempText2
			];
			for (var i = 0; i < rowData.length; i++) {
        		newCell = newRow.insertCell(i);
        		newCell.style.backgroundColor = col;
        		newCell.innerHTML = rowData[i];
        		newCell.align = 'center';
        		if (i == 10){
        			newCell.align = 'right';
        		}
  			}
			//newCell = newRow.insertCell(13);
			//add row

			var tmpTmp = "Ajax"+addCount;
			var idI = data.uniqueId;
			var arrr = [ newRow.id, idI ];
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get(butId), "click", YAHOO.HEB.otherInfo.productAndUPC.upc.deleteUpc,arrr);

			//trungnv add
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get(butIdModify), "click", YAHOO.HEB.otherInfo.productAndUPC.upc.modifyUpc,arrr);
			var arrr = [ YAHOO.util.Dom.get(butId), '${img}' ];
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("link"+addCount), "mouseout", YAHOO.HEB.otherInfo.productAndUPC.upc.changeImageUpc,arrr);
			var arrr = [ YAHOO.util.Dom.get(butId), '${imgOver}' ];
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("link"+addCount), "mouseover", YAHOO.HEB.otherInfo.productAndUPC.upc.changeImageUpc,arrr);

			//trungnv add for modify image

			var arrr = [ YAHOO.util.Dom.get(butIdModify), '${imgM}' ];
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("linkM"+addCount), "mouseout", YAHOO.HEB.otherInfo.productAndUPC.upc.changeImageUpc,arrr);
			var arrr = [ YAHOO.util.Dom.get(butIdModify), '${imgOverM}' ];
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("linkM"+addCount), "mouseover", YAHOO.HEB.otherInfo.productAndUPC.upc.changeImageUpc,arrr);

		}//else
	}//addRowToUPCTable

	function clearData(){
		YAHOO.util.Dom.get("upcType1").value = document.getElementById('select').value;
   		YAHOO.util.Dom.get("unitUpc1").value = '';
   		YAHOO.util.Dom.get("unitUpc12").value = '';
		YAHOO.util.Dom.get("size").value = '';
		YAHOO.util.Dom.get("subbrandStrutsHiddenElm").value = '';
		YAHOO.util.Dom.get("unitSize1").value = '';
		//SPRINT 22
		YAHOO.util.Dom.get("unitOfMeasure1").value = dwr.util.getValue("unitOfMeasureNew1");
		YAHOO.util.Dom.get("length").value = '';
		YAHOO.util.Dom.get("height").value = '';
		YAHOO.util.Dom.get("width").value = '';
		YAHOO.util.Dom.get("upcScenario1").checked = false;
		YAHOO.util.Dom.get("unitUpcItm").value = '';
		YAHOO.util.Dom.get("unitUpcAuto").value = '';
		YAHOO.util.Dom.get("preDigit").value = '';
		YAHOO.util.Dom.get("wic").value = '';
		YAHOO.util.Dom.get("wicLink").value = '';
		displaySelectedUpcDiv();
		subBrandClear();
		sbName.value='';

	}
	<c:url value="/protected/cps/add/manage/modules/search/backend/ajaxSearch?action=subBrandSearch&${_csrf.parameterName}=${_csrf.token}&showId=true&highlightMatch=true&maxResults=100&" var="jsonSearch"></c:url>
	function copyDataTonewRow()
	{
		if(upcTableBody.rows.length>1 &&firstRowAvailable())
		{
			fR=getFirstRow();
			if(fR!=null)
			{
				temp=getValueFromUomDesc(fR);
				YAHOO.util.Dom.get("unitSize1").value = fR[3];
				if(temp != null && temp != undefined && temp.length > 0)
				{
					YAHOO.util.Dom.get("unitOfMeasure1").value = temp;
				}
				YAHOO.util.Dom.get("unitOfMeasure1").text = fR[4];

				YAHOO.util.Dom.get("length").value = fR[5];
				YAHOO.util.Dom.get("width").value = fR[6];
				YAHOO.util.Dom.get("height").value = fR[7];
				YAHOO.util.Dom.get("size").value=fR[8];
				YAHOO.util.Dom.get('subbrandACInput').value = fR[9];
				if(fR[9].length > 0)
				{
					subbrand.value=	fR[9].substring(fR[9].lastIndexOf("[")+1, fR[9].lastIndexOf("]"));
					sbName.value=fR[9];
				}
			}
		}
	}

	function changeImageUpc(evt,ar){
		var obj = ar[0];
		var image = ar[1];
		obj.src = image;
	}

	YAHOO.HEB.otherInfo.productAndUPC.upc.changeImageUpc = changeImageUpc;

	<cps:renderByResourceAccess resourceId="175"  honorViewMode="${addNewCandidate.upcViewOverRide}">
		<jsp:attribute name="EXEC">

	var cTemp = null;
	function deleteUpc(evt,arr){
		var t = arr[0];
		var c = arr[1];
		cTemp = c;
		answer = confirm ("Are you sure you want to delete the UPC");
		if (answer !=0) {
			showProgress();
			AddCandidateTemp.removeUPC( c ,getDWRCallbackMethod(callBackDeleteUpc));			
			deleteRowWithButton(t);
			var tableName = "upcTable";
			colorTableRows(tableName);
			nonSellableHide();
			// get generated UPC for Kit components.
			if (upcTableBody.rows.length <= 1 && isWorkingKitComponents()) {
				getUPCLists();
			}
		}
	}
	
	function callBackDeleteUpc(data){
		hideProgress();
		enableActivationUPC(data);
		refreshDataForNutritionFacts();
	}

	function scaleAttShowDelete(upcList){
		AddCandidateTemp.checkScaleAttBasedOnUpc(upcList, getDWRCallbackMethod(callBackDeleteScale));
	}

	function deleteRowWithButton(idd){
		for(var i=0;i<upcTableBody.rows.length;i++){
			var tableRow = upcTableBody.rows[i];
			if(tableRow.id == idd){
				upcTableBody.deleteRow(i);
				break;
			}
		}
		AddCandidateTemp.getLstUpcFromForm(cTemp, getDWRCallbackMethod(scaleAttShowDelete));
	}
	var cacheUPCData = {};
	function modifyUpc(evt,arr){
		var t = arr[0];
		//alert(t);
		var c = arr[1];
		var autoText="";
		var po=getCurrentRowIndex(t);
		var cD=getDataFromCurrentRow(po);
        var cDText = getTextDataFromCurrentRow(po);
		var newRow = upcTableBody.rows[po];
		var chkl="";
		if(cD[2].indexOf("CHECKED") > -1)
		{
			chkl="<input type='checkbox' id='check"+t+"'  checked = 'checked' onclick='clearCopyDataForEditRow(this.id);'\/>";
		}
		else
		{
			chkl="<input type='checkbox' id='check"+t+"' onclick='clearCopyDataForEditRow(this.id);'\/>";
		}
		newRow.cells[2].innerHTML = chkl;
		newRow.cells[2].align ='center';
		newRow.cells[2].width ='4%';
		newRow.cells[3].innerHTML = "<input type='text' value='"+cDText[3]+"' id='unitSize"+t+"' style='dataType\: float;' size='6' maxlength='6' onblur='roundValue(this,2);return true;'\/>";
		newRow.cells[3].align='center';
		newRow.cells[3].width = '9%';
		newRow.cells[4].innerHTML = "<select id='unitOfMeasure"+t+"'>"+document.getElementById("unitOfMeasure1").innerHTML+"<\/select>";
		newRow.cells[4].width='12%';
		newRow.cells[4].align='center';
		newRow.cells[4].firstChild.selectedIndex=getSelectedIndexFromUom(cDText[4]);
		newRow.cells[5].innerHTML = "<input type='text' value='"+cDText[5]+"' id='length"+t+"' style='dataType\: float;' size='6' maxlength='8' onblur='roundValue(this,2);return true;'\/>";
		newRow.cells[5].align='center';
		newRow.cells[5].width='6%';
		newRow.cells[6].innerHTML = "<input type='text' value='"+cDText[6]+"' id='width"+t+"' style='dataType\: float;' size='6' maxlength='8' onblur='roundValue(this,2);return true;'\/>";
		newRow.cells[6].align='center';
		newRow.cells[6].width='6%';
		newRow.cells[7].innerHTML = "<input type='text' value='"+cDText[7]+"' id='height"+t+"' style='dataType\: float;' size='6' maxlength='8' onblur='roundValue(this,2);return true;'\/>";
		newRow.cells[7].align='center';
		newRow.cells[7].width='6%';
		newRow.cells[8].innerHTML = "<input type='text' value='"+cDText[8]+"' id='size"+t+"'  size='6' maxlength='6' style='TEXT-TRANSFORM\: uppercase; dataType\: alphanumericSpecial;' onblur='switchToUpperCase(this);return true;'\/>";
		newRow.cells[8].align='center';
		newRow.cells[8].width='6%';
		autoText+="<div class='myAutoComplete' id='myAutoComplete"+t+"'>";
		//alert(cD[9]);
		autoText+="<input id='myInput"+t+"' type='text' value='"+cDText[9]+"' maxlength='30' style='TEXT-TRANSFORM\: uppercase; position: relative;'\/>";
		autoText+="<div id='myContainer"+t+"'><\/div>";
		autoText+="<\/div>";
		autoText+="<input type='hidden' value='"+cDText[9]+"' id='subbrandHd"+t+"'\/>";
		newRow.cells[9].innerHTML = autoText;
		newRow.cells[9].align='left';
		newRow.cells[9].width='23%';
		autoSubbrand(t);
		reSetZIndex();
		btnDeleteWrap = (YAHOO.env.ua.ie > 0 && YAHOO.env.ua.ie < 9) ? newRow.cells[11].firstChild : newRow.cells[11].firstElementChild;
 		btnModifyWrap = (YAHOO.env.ua.ie > 0 && YAHOO.env.ua.ie < 9) ? newRow.cells[12].firstChild : newRow.cells[12].firstElementChild;
 		btnDeleteWrap.style.display='none';
 		btnModifyWrap.style.display='none';
		var newCell;
		if(newRow.cells[13]==null)
		{
			newCell = newRow.insertCell(13);
		}
		else
		{
			newCell=newRow.cells[13];
		}
		var txtSave='';
		var saveButtonId='';
		saveButtonId+="save"+t+"_"+c;
		<c:url var="imgS" value="${request.getContextPath()}/hebAssets/images/buttons/Save_normal.PNG"/>
		<c:url var="imgOverS" value="${request.getContextPath()}/hebAssets/images/buttons/Save_over.PNG"/>
		txtSave+="<div id='save"+t+"'><a id='linkS"+t+"'>" +
				"<img src='${imgS}' alt='' name='"+saveButtonId+"'  border='0' id='"+saveButtonId+"' onclick='saveUpc(this.id);'"+
				"<\/a><\/div>";

        newCell.style.backgroundColor = "#FFFFFF";
        newCell.innerHTML = txtSave;//"<input type='button' id='save"+t+"_"+c+"' value='Save' onclick='saveUpc(this.id);'\/>";
        newCell.align = 'right';
		newCell.width = '5%';
		var arrr = [ YAHOO.util.Dom.get(saveButtonId), '${imgS}' ];
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("linkS"+t), "mouseout", YAHOO.HEB.otherInfo.productAndUPC.upc.changeImageUpc,arrr);
			var arrr = [ YAHOO.util.Dom.get(saveButtonId), '${imgOverS}' ];
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("linkS"+t), "mouseover", YAHOO.HEB.otherInfo.productAndUPC.upc.changeImageUpc,arrr);
		//add cancel button
		var newCellCl;
		if(newRow.cells[14]==null)
		{
			newCellCl = newRow.insertCell(14);
		}
		else
		{
			newCellCl=newRow.cells[14];
		}

		var txtCancel='';
		var cancelButtonId='';
		cancelButtonId+="cancel"+t+"_"+c;
		<c:url var="imgC" value="${request.getContextPath()}/hebAssets/images/buttons/Cancel_normal.PNG"/>
		<c:url var="imgOverC" value="${request.getContextPath()}/hebAssets/images/buttons/Cancel_over.PNG"/>
		txtCancel+="<div id='cancel"+t+"'><a id='linkC"+t+"'>" +
				"<img src='${imgC}' alt='' name='"+cancelButtonId+"'  border='0' id='"+cancelButtonId+"' onclick='cancelUpc(this.id);'"+
				"<\/a><\/div>";

        cacheUPCData[cancelButtonId]=cD;

        newCellCl.style.backgroundColor = "#FFFFFF";
        newCellCl.innerHTML = txtCancel;
        newCellCl.align = 'right';
		newCellCl.width = '5%';
		var arrr = [ YAHOO.util.Dom.get(cancelButtonId), '${imgC}' ];
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("linkC"+t), "mouseout", YAHOO.HEB.otherInfo.productAndUPC.upc.changeImageUpc,arrr);
			var arrr = [ YAHOO.util.Dom.get(cancelButtonId), '${imgOverC}' ];
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("linkC"+t), "mouseover", YAHOO.HEB.otherInfo.productAndUPC.upc.changeImageUpc,arrr);
	}

	YAHOO.HEB.otherInfo.productAndUPC.upc.deleteUpc = deleteUpc;
	//trungnv add
	YAHOO.HEB.otherInfo.productAndUPC.upc.modifyUpc = modifyUpc;

	function addEvents(){
		var uniqId ;
		var cnt;
		var butn;
		var arr;
		var butMf;

        <c:forEach items="${addNewCandidate.productVO.upcVO}" var="upc" varStatus="loop" >
			<c:if test="${upc.editable eq true}">
				uniqId = '<c:out value="${upc.uniqueId}"></c:out>';
				cnt = ${loop.index};
				arr = [ 'Normal${loop.index}',  uniqId];
				new YAHOO.widget.Button("deleteButton${loop.index}");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteButton${loop.index}"), "click", YAHOO.HEB.otherInfo.productAndUPC.upc.deleteUpc,arr);
				new YAHOO.widget.Button("modify${loop.index}");
				YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modify${loop.index}"), "click", YAHOO.HEB.otherInfo.productAndUPC.upc.modifyUpc,arr);
			</c:if>
		</c:forEach>
	}

	addEvents();

		</jsp:attribute>
	</cps:renderByResourceAccess>

	function autoTab(event,array){
		if(window.event.keyCode == 9 || window.event.keyCode == 16){
			return true;
	    }
		var src = array[0];
		var dest = array[1];

		if (src.value.length == src.maxLength && dest != null ) {
	        	dest.focus();
	    }
	}
	
	function updateUPCTextBox(plyType, singleData,data1,data2,checkDigit,checkDigit1)
	{
		showProgress();
		
		if(plyType == 'B'){ // This is checker and scale PLU
			setCheckerScaleMandFld();
		}else if(plyType == 'S'){ // This is scale PLU
			setColorEPS('red');
			setColorForBrandCFD('white');
		}else if(plyType == 'C'){ // This is checker PLU
			setColorEPS('white');	//3
			setColorForBrandCFD('red'); //2
		}
		if (data1=='' && data2=='')
		{
			document.getElementById('onemore').style.display='none';
			document.getElementById('unitUpc1').readonly=false;
			document.getElementById('unitUpc1').value=singleData;
			document.getElementById('unitUpc1').readonly=true;
			document.getElementById('unitUpc12').value=checkDigit;
			autoShowScale(singleData);
		}
		else
		{
			document.getElementById('onemore').style.display='block';
			normalDivShown = true;
			newDivShown = true;
			document.getElementById('unitUpc1').readonly=false;
			document.getElementById('unitUpc1').value=data1;
			document.getElementById('unitUpc1').readonly=true;
			document.getElementById('unitUpc12').value=checkDigit;

			document.getElementById('upcTypeNew1').value="PLU";
			document.getElementById('unitUpcNew1').readonly=false;
			document.getElementById('unitUpcNew1').value=data2;
			document.getElementById('unitUpc13').value=checkDigit1;
			document.getElementById('unitUpcNew1').readonly=true;
			document.getElementById('unitUpc13').readonly=true;
			document.getElementById('unitUpc13').readonly=true;
			document.getElementById('wicNewLink').value = '';
			copyDataTonewRow2();
			autoShowScale(data2);
		}
		hideProgress();
	}

	function setColor(clr){
		var isSet = false;
		if(document.getElementById('engDescLine1Required')){
			document.getElementById('engDescLine1Required').style.color = clr;
			isSet = true;
		}
		if(document.getElementById('prePackRequired')){
			document.getElementById('prePackRequired').style.color = clr;
			isSet = true;
		}
		if(document.getElementById('shelfLifeDaysRequired')){
			document.getElementById('shelfLifeDaysRequired').style.color = clr;
			isSet = true;
		}
		return isSet;
	}

	function setScaleMandFldOnUPCChange(){
		if(upcType.options[upcType.selectedIndex].value == 'HEB'
			|| upcType.options[upcType.selectedIndex].value == 'UPC'
				|| upcType.options[upcType.selectedIndex].value == 'ITUPC'
				|| upcType.options[upcType.selectedIndex].value == '04UPC'){
			showProgress();
			if(setColor('white') == true){
				setColorForBrandCFD('red');
			}
			hideProgress();
		}
	}
	
	function setColorForBrandCFD(clr){
		if(document.getElementById('brandStar')){
			document.getElementById('brandStar').style.color = clr;
		}
		if(document.getElementById('cfdStar')){
			document.getElementById('cfdStar').style.color = clr;
		}
	}
	function setColorEPS(clr){
		if(document.getElementById('engDescLine1Required')){
			document.getElementById('engDescLine1Required').style.color = clr;
		}
		if(document.getElementById('engDescLine2Required')){
			document.getElementById('engDescLine2Required').style.color = clr;
		}
		if(document.getElementById('prePackRequired')){
			document.getElementById('prePackRequired').style.color = clr;
		}
		if(document.getElementById('shelfLifeDaysRequired')){
			document.getElementById('shelfLifeDaysRequired').style.color = clr;
		}
	}

	function setCheckerScaleMandFld(){
		setColorEPS('red');
		setColorForBrandCFD('white');
	}

	YAHOO.HEB.otherInfo.productAndUPC.upc.autoTab = autoTab;

	function reloadUpc(){

	}

	// Defect #33 merged with US Tech code
	function verifyCheckDigit(){
		var unitUpc12 = unitUpc10.value;
		var unitUPCValue = unitUpc.value;
		if(upcType.options[upcType.selectedIndex].value == 'PLU' ){
			return false ;
		}
		else {
			if(upcType.options[upcType.selectedIndex].value != ""){
				if (unitUPCValue!="" && null !=unitUPCValue ){
					if(unitUpc12!="" && null != unitUpc12) {
						AddCandidateTemp.verifyCheckDigit(unitUPCValue,unitUpc12,getDWRCallbackMethod(returnData));
					}
					else {
					    doWhenUPCsectionInvalid();
					   	alert('Please enter the Check Digit');
					}
				}
			}
			else {
				doWhenUPCsectionInvalid();
			   alert('Please enter UPC Type');
			}
		}
	}

	<c:if test="${addNewCandidate.selectedFunction == '2'}">
		<c:url value="/protected/cps/manage/trackErrorUPC?${_csrf.parameterName}=${_csrf.token}" var="upcRedirection"></c:url>
	</c:if>
	<c:if test="${addNewCandidate.selectedFunction == '1'}">
		<c:url value="/protected/cps/add/trackErrorUPC?${_csrf.parameterName}=${_csrf.token}" var="upcRedirection"></c:url>
	</c:if>
	function returnData(data){
	  	if('firstTimeError' == data.message) {
			alert('Invalid UPC. Please refer to product bar code. Limit one more attempt');
	  	}else if('secondTimeError' == data.message){
			alert('Wrong check digit entered for the second time');
			document.forms[0].action = '${upcRedirection}'+'&enteredUPC='+data.unitUpc+'&workId='+data.workRequest.workIdentifier;
			document.forms[0].submit();
	  	}else if('numberFormatError' == data.message){
		  	alert('Unit UPC/check digit should be in number format');
	  	}else{
	  		document.getElementById('unitUpc1').readOnly=true;
	  		document.getElementById('unitUpcNew1').readOnly=true;
	  		YAHOO.util.Dom.get("hiddenUPC").value= YAHOO.util.Dom.get("upcType1").value;
	 	 }
	}

	function setEnableAndColorScale(data){
		setColorForBrandCFD(data);
		AddCandidateTemp.removedDisableScaleAtt(getDWRCallbackMethod(removeDisableScaleAtt));
	}
	
	function mandatoryCustomerFriendDesc(){
		AddCandidateTemp.mandatoryCustomerFriendDesc(getDWRCallbackMethod(setEnableAndColorScale));
	}
	
	function getUPCLists(){
		AddCandidateTemp.getUPCLists(getDWRCallbackMethod(populateUPCLists));
	}

	function autoSubbrand(t)
	{
    	// Use an XHRDataSource
    	var oDS = new YAHOO.util.XHRDataSource("${jsonSearch}", ["resultList", "name"]);

    	// Set the responseType
    	oDS.responseType = YAHOO.util.XHRDataSource.TYPE_JSON;
    	// Define the schema of the delimited results
   		oDS.responseSchema = {
        	resultsList: "resultList",
       	 fields: ["name", "id", "markup"]
    	};

		// Enable caching
		oDS.maxCacheEntries = 20;

		// Instantiate the AutoComplete
		var oAC = new YAHOO.widget.AutoComplete("myInput"+t, "myContainer"+t, oDS);
		oAC.queryQuestionMark = false;
		oAC.forceSelection = false;
		oAC.autoHighlight = true;
		oAC.maxResultsDisplayed = 100;
		oAC.resultTypeList = false;
		oAC.useIFrame = true;

		oAC.formatResult = function(oResultItem, sQuery, sResultsMatch) {
			return oResultItem.markup;
		};

		oAC.doBeforeLoadData = function(sQuery, oResponse, oPayload) {
			var name = "";
			if(sQuery != null){
				sQuery = sQuery.toUpperCase();
				name = decodeURIComponent(sQuery);
			}
			var newStr = "Add New " + name;
			if(oResponse != null){
					var aResults = oResponse.results;
					if(aResults != null ){
						var size = aResults.length;
						if(size > 0){
							if(size > 99){
								//insert Add New in the 99th position
								var newarr1 = aResults.slice(0,99);
								var newarr2 = aResults.slice(99);
								aResults = newarr1.concat(newarr2);
								oResponse.results = aResults;
							}
							else{
								if(aResults[size-1].id == "0"){
								}else{
								}
							}
						}else{
						}
					}
			}
			return true;
		};

		 var itemSelectHandler = function(sType, aArgs) {
				var aData = aArgs[2]; //array of the data for the item as returned by the DataSource
				var elm1 = YAHOO.util.Dom.get("subbrandHd"+t);
				elm1.value=aData.name;
		};

		oAC.itemSelectEvent.subscribe(itemSelectHandler);
		oAC.doBeforeExpandContainer = function() {
			var Dom = YAHOO.util.Dom;
			Dom.setXY("myContainer"+t, [Dom.getX("myInput"+t), Dom.getY("myInput"+t) + Dom.get("myInput"+t).offsetHeight] );
			return true;
		}

		oAC.textboxKeyEvent.subscribe(
				function(nKeycode){
					var oSelf = this;
					oSelf.forceSelection = false;
				});

		oAC.textboxFocusEvent.subscribe(
				function(){
					var oSelf = this;
					oSelf.forceSelection = false;
		 });

		return {
			oDS: oDS,
			oAC: oAC
		};
	}


	function populateUPCLists(data){

		var upcTypes = data.UPC_TYPES;
		var uoms = data.UOMS;
	

		dwr.util.removeAllOptions("unitOfMeasure1");
		dwr.util.addOptions("unitOfMeasure1", uoms, "id", "name");
		var currVal = dwr.util.getValue("unitOfMeasure1");
		dwr.util.setValue("unitOfMeasure1", "");
		dwr.util.removeAllOptions("unitOfMeasureNew1");
		dwr.util.addOptions("unitOfMeasureNew1", uoms, "id", "name");
		//SPRINT 22
		dwr.util.setValue("unitOfMeasure1", uoms[0].id);
		var currVal = dwr.util.getValue("unitOfMeasureNew1");
		dwr.util.setValue("unitOfMeasureNew1", uoms[0].id);

		// PIM-1527 set default of UOM is EACH for Kit Components.
		if (isWorkingKitComponents()) {
			var idEach = null;
			for (tmpUom in uoms) {
				if (uoms[tmpUom].name == "EACH") {
					idEach = uoms[tmpUom].id;
					break;
				}
			}
			if (idEach != null) {
				dwr.util.setValue("unitOfMeasure1", idEach);
			}
			// get generated UPC for Kit components.
			if (upcTableBody.rows.length <= 1) {
				showProgress();
				AddCandidateTemp.generateKITUPC(getDWRCallbackMethod(displayKITUPC));
			}
		}
		
		//SPRINT 22
		var unitOfMeasure = YAHOO.util.Dom.get("unitOfMeasure1");
		for(var i = 0;i < unitOfMeasure.length;i++)
		{
			if(unitOfMeasure.options[i].value=="")
			{
				unitOfMeasure.options[i].disabled=true;
				break;
			}
		}
		dwr.util.addOptions("upcType1", upcTypes, "id", "name");
		<c:if test="${(!addNewCandidate.upcValueFromMRT) && addNewCandidate.mrtUpcAdded}">
			YAHOO.util.Dom.get("upcType1").value = 'UPC';
			YAHOO.util.Dom.get("upcType1").disabled = true;
			YAHOO.util.Dom.get("unitUpc12").value = "${addNewCandidate.upcSubValue}";
			YAHOO.util.Dom.get("unitUpc12").disabled = true;
			YAHOO.util.Dom.get("unitUpc1").value = "${addNewCandidate.upcValue}";
			YAHOO.util.Dom.get("unitUpc1").disabled = true;
			YAHOO.util.Dom.get("size").value = '';
			YAHOO.util.Dom.get("subbrandStrutsHiddenElm").value = '';
			YAHOO.util.Dom.get("unitSize1").value = '';
			YAHOO.util.Dom.get("unitOfMeasure1").value = currVal;
			YAHOO.util.Dom.get("length").value = '';
			YAHOO.util.Dom.get("height").value = '';
			YAHOO.util.Dom.get("width").value = '';
			YAHOO.util.Dom.get("upcScenario1").checked = false;
			YAHOO.util.Dom.get("unitUpcItm").value = '';
			YAHOO.util.Dom.get("unitUpcAuto").value = '';
			YAHOO.util.Dom.get("wic").value = '';
			YAHOO.util.Dom.get("wicLink").value = '';
			subBrandClear();

			saveUPCHook = true;
		</c:if>
		mandatoryCustomerFriendDesc();
		loadUPCTypeDefault();
	}

	function clearData2(){
   		YAHOO.util.Dom.get("unitUpcNew1").value = '';
   		YAHOO.util.Dom.get("unitUpc13").value = '';
   		YAHOO.util.Dom.get("sizeNew").value = '';
   		YAHOO.util.Dom.get("subbrandNewStrutsHiddenElm").value = '';
		YAHOO.util.Dom.get("unitSizeNew1").value = '';
		YAHOO.util.Dom.get("lengthNew").value = '';
		YAHOO.util.Dom.get("heightNew").value = '';
		YAHOO.util.Dom.get("widthNew").value = '';
		YAHOO.util.Dom.get("wicNew").value = '';
		YAHOO.util.Dom.get("wicNewLink").value = '';
		YAHOO.util.Dom.get("upcScenarioNew1").checked = false;
		subBrandNewClear();
		sbNameNew.value='';
	}

	// ************************************* For HEB OWN Brand Confirmation ********************************
	function confirmationMessage(){
		var confirmatiom = confirm('System will generate H-E-B UPC. Do you want to continue?');
		if(confirmatiom){
		 showProgress();
		 AddCandidateTemp.generateHEBUPC(getDWRCallbackMethod(displayHEBUPC));
		}else{
			document.getElementById('unitUpc1').readOnly=false;
			document.getElementById('unitUpcNew1').readOnly=false;
			document.getElementById('unitUpc12').readOnly=false;
			document.getElementById('unitUpc13').readOnly=false;
			upcType.value = document.getElementById('select').value;
			saveUPCHook = false;
		}
		return false;
	}

	function displayHEBUPC(data){
	      hideProgress();
	      var myArray = new Array();
			myArray = data.split(',');
      		num1=myArray[0];
      		num2=myArray[1];
			document.getElementById("unitUpc1").value =num1;
			document.getElementById("unitUpc12").value =num2;
	}

	function generateCheckDigit(upc){
		if(upc != null && upc !=''){
	      showProgress();
	      var  finalUpc = document.getElementById("preDigit").value + upc;
	      AddCandidateTemp.generateCheckDigit(finalUpc, getDWRCallbackMethod(populateCheckDigit));
		}else{
			document.getElementById("unitUpc12").value ='';
			alert("This portion of the UPC cannot be empty");
		}
	}

	function populateCheckDigit(data){
		hideProgress();
		document.getElementById("unitUpc12").value =data;
	}

	function clearSubBrand(){
		subbrand.value = "";
		YAHOO.util.Dom.get('subbrandACInput').value = "";
	}

	function setSubBrand(data){
		if(data != null){
			if(data == "UNASSIGNED"){
				clearSubBrand();
			}else{
				subbrand.value = data;
				YAHOO.util.Dom.get('subbrandACInput').value = YAHOO.util.Dom.get('subbrandACInput').value +" ["+data+"]";
			}
		}
	}

	function clearAll(){
   		YAHOO.util.Dom.get("unitUpc1").value = '';
   		YAHOO.util.Dom.get("unitUpc12").value = '';
		YAHOO.util.Dom.get("size").value = '';
		YAHOO.util.Dom.get("subbrandStrutsHiddenElm").value = '';
		YAHOO.util.Dom.get("unitSize1").value = '';
		//SPRINT 22
		dwr.util.setValue("unitOfMeasure1", dwr.util.getValue("unitOfMeasureNew1"));
		YAHOO.util.Dom.get("length").value = '';
		YAHOO.util.Dom.get("height").value = '';
		YAHOO.util.Dom.get("width").value = '';
		YAHOO.util.Dom.get("upcScenario1").checked = false;
		YAHOO.util.Dom.get("unitUpcItm").value = '';
		YAHOO.util.Dom.get("unitUpcAuto").value = '';
		YAHOO.util.Dom.get("preDigit").value = '';
		YAHOO.util.Dom.get("wic").value = '';
		YAHOO.util.Dom.get("wicLink").value = '';
		subBrandClear();
	}
</script>

	</jsp:attribute>
</cps:renderByResourceAccess>

<script type="text/javascript">
<c:url var="wicPopUp" value="/protected/cps/add/wic?${_csrf.parameterName}=${_csrf.token}"></c:url>

function showWic(data,flag,newRow){
	if(newRow == true){
		document.getElementById("newRowClicked").value = true;
	}else{
		document.getElementById("newRowClicked").value = false;
	}
	f1('${wicPopUp}'+'&t='+new Date().getTime()+'&val='+data+'&disable='+flag,'WIC','100px','40%','350px','325px');
	document.getElementById("pnl123").style.dataType = 'numeric';
}

function setWic(data){
	var plurow = document.getElementById("newRowClicked");
	if(plurow.value == "true" || plurow.value == true){
			if(YAHOO.util.Dom.get("wicNew")){
				YAHOO.util.Dom.get("wicNew").value = data;
			}
			document.getElementById("wicNewLink").value = data;

	}else{
		if(YAHOO.util.Dom.get("wic")){
			YAHOO.util.Dom.get("wic").value = data;
		}
		document.getElementById("wicLink").value = data;
	}
}

function piaMandatoryScaleAttribs(data) {
	if (data == null || data == "" || data.containsScaleUPC == "") {
		return false;
	}
	//HungBang remove mandatory when role is Vendor
	<c:if test="${addNewCandidate.userRole eq 'RVEND'}">
		if(document.getElementById('engDescLine1Required')){
			document.getElementById('engDescLine1Required').style.color = 'white';
		}
		if(document.getElementById('engDescLine2Required')){
			document.getElementById('engDescLine2Required').style.color = 'white';
		}
		if(document.getElementById('prePackRequired')){
			document.getElementById('prePackRequired').style.color = 'white';
		}
		if(document.getElementById('shelfLifeDaysRequired')){
			document.getElementById('shelfLifeDaysRequired').style.color = 'white';
	}
	</c:if>
	<c:if test="${(addNewCandidate.userRole eq 'ADMIN' || addNewCandidate.userRole eq 'PIA' || addNewCandidate.userRole eq 'PIAL')}">
		if (data.containsScaleUPC == 'Y') {
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

		} else {
			if(document.getElementById('engDescLine1Required')){
				document.getElementById('engDescLine1Required').style.color = 'white';
			}
			if(document.getElementById('engDescLine2Required')){
				document.getElementById('engDescLine2Required').style.color = 'white';
			}
			if(document.getElementById('prePackRequired')){
				document.getElementById('prePackRequired').style.color = 'white';
			}
			if(document.getElementById('shelfLifeDaysRequired')){
				document.getElementById('shelfLifeDaysRequired').style.color = 'white';
			}
		}
	</c:if>

	if (data.containsScaleUPC == 'Y') {
		enableTescScanButton(false);
		if(document.getElementById('brandix')){
			document.getElementById('brandix').style.display = 'none';
		}
		if(document.getElementById('cfdix')){
			document.getElementById('cfdix').style.display = 'none';
		}
	} else {
		enableTescScanButton(true);
		if(document.getElementById('brandix')){
			document.getElementById('brandix').style.display = 'block';
		}
		if(document.getElementById('cfdix')){
			document.getElementById('cfdix').style.display = 'block';
		}
	}
}

	function getFirstRow()
	{
		 rD=[];
		 if(upcTableBody.rows.length>1)
		 {
			 fstRow=upcTableBody.rows[1];
			for(var i=0;i<fstRow.cells.length;i++)
			{


				if(fstRow.cells[i].firstChild!=null)
				{
					if(fstRow.cells[i].firstChild.nodeType==1 && fstRow.cells[i].firstChild.tagName=="FONT")
					{
						rD.push(myTrim(fstRow.cells[i].firstChild.innerHTML));
					}					
					else
					{
						rD.push(myTrim(fstRow.cells[i].innerHTML));
					}
				}
				else
				{
					rD.push(myTrim(fstRow.cells[i].innerHTML));
				}
			}
			if(rD[9].indexOf("&amp;")>-1)
			{
				rD[9]= rD[9].replace(/&amp\;/g,'\&');

			}
		}
		return rD;
	}
			
	function getValueFromUomDesc(fR)
	{
		for(var i = 0;i < unitOfMeasure.length;i++)
		{
			if(unitOfMeasure.options[i].text==fR[4])
			{
				return unitOfMeasure.options[i].value;
			}
		}
	}

	function getSelectedIndexFromUom(uomDes)
	{
		for(var i = 0;i < unitOfMeasure.options.length;i++)
		{
			if(unitOfMeasure.options[i].text.trim()==uomDes.trim())
			{
				return i;
			}
		}
		return 0;
	}


	function getDataFromCurrentRow(po)
	{
		 var rD=[];
		if(upcTableBody.rows.length>1)
		{
			var curRow=upcTableBody.rows[po];
			for(var i=0;i<curRow.cells.length;i++)
			{
				if(curRow.cells[i].firstChild!=null)
				{
					if(curRow.cells[i].firstChild.nodeType==1 && curRow.cells[i].firstChild.tagName=="FONT")
					{
						rD.push(curRow.cells[i].firstChild.innerHTML);
					}
					else
					{
						rD.push(curRow.cells[i].innerHTML);
					}
				}
				else
				{

					rD.push(curRow.cells[i].innerHTML);
				}
			}
		}
		return rD;
	}
function getTextDataFromCurrentRow(po)
{
   var rD=[];
    if(upcTableBody.rows.length>1)
    {
        curRow=upcTableBody.rows[po];
        for(var i=0;i<curRow.cells.length;i++)
        {
            if(curRow.cells[i].firstChild!=null)
            {
                if(curRow.cells[i].firstChild.nodeType==1 && curRow.cells[i].firstChild.tagName=="FONT")
                {
                    rD.push(curRow.cells[i].firstChild.innerText);
                }
                else
                {
                    rD.push(curRow.cells[i].innerText);
                }
            }
            else
            {

                rD.push(curRow.cells[i].innerText);
            }
        }
    }
    return rD;
}
	function clearCopyData()
	{
		YAHOO.util.Dom.get("unitSize1").value = '';
		//SPRINT 22
		YAHOO.util.Dom.get("unitOfMeasure1").value = dwr.util.getValue("unitOfMeasureNew1");
		YAHOO.util.Dom.get("length").value = '';
		YAHOO.util.Dom.get("width").value = '';
		YAHOO.util.Dom.get("height").value = '';
		YAHOO.util.Dom.get("size").value='';
		subBrandClear();
	}

	function clearCopyDataForEditRow(that)
	{
			rowId=that.substring(5,that.length);
			po=getCurrentRowIndex(rowId);
			newRow=upcTableBody.rows[po];
			newRow.cells[3].firstChild.value = '';
			//SPRINT 22
			newRow.cells[4].firstChild.value = dwr.util.getValue("unitOfMeasureNew1");
			newRow.cells[5].firstChild.value = '';
			newRow.cells[6].firstChild.value = '';
			newRow.cells[7].firstChild.value = '';
			newRow.cells[8].firstChild.value = '';
			newRow.cells[9].firstChild.firstChild.value = '';
			newRow.cells[9].firstChild.nextSibling.value='';
	}
	function getUpcTypeValueFromDesc(fR)
	{
		for(var i = 0;i < upcType.length;i++)
		{
			if(upcType.options[i].text==fR[0])
			{
				return upcType.options[i].value;
			}
		}
	}

	function getCurrentRowIndex(idd)
	{
		for(var i=0;i<upcTableBody.rows.length;i++){
			var tableRow = upcTableBody.rows[i];
			if(tableRow.id == idd){
				return i;
			}
		}
	}

	function saveUpc(key)
	{
		var separateC=key.lastIndexOf("_");
		rowId=key.substring(4,separateC);
		var unq='';
		po=getCurrentRowIndex(rowId);
		unq=key.substring(separateC+1,key.length);
		rowSave=upcTableBody.rows[po];
		var upcValue = rowSave.cells[0].innerHTML;
		var uom = document.getElementById("unitOfMeasure"+rowId);
		var tmp = uom.selectedIndex;
		var unitMeasureDesc = uom.options[tmp].text;
		var unitMeasureCode = uom.options[tmp].value;
		var length = document.getElementById("length"+rowId).value;
		var width = document.getElementById("width"+rowId).value;
		var height = document.getElementById("height"+rowId).value;
		var size = document.getElementById("size"+rowId).value;
		var unitSize = document.getElementById("unitSize"+rowId).value;
		//SPRINT 22
		if(size.trim().length==0 || unitSize.trim().length==0 || uom.options[uom.selectedIndex].text=='--Select--')
		{
			alert("Please enter Unit Size, Unit of Measure, Size fields");
			return false;
		}
		var scnrio = document.getElementById("check"+rowId).checked;
		var subbrand=document.getElementById("myInput"+rowId).value;
		var subbrandHd=document.getElementById("subbrandHd"+rowId).value;
		subbrandHd=doFilterSubbrand(subbrand,subbrandHd);
		showProgress();
		AddCandidateTemp.saveUPC(unq,scnrio,unitSize,unitMeasureDesc,unitMeasureCode,length,width,height,size,subbrandHd,rowId,getDWRCallbackMethod(wrapperUPCAfterSave));
	}

	function wrapperUPCAfterSave(data)
	{
		 hideProgress();
		 if(data!=null)
		 {
			rowId=data.rowId;
			po=getCurrentRowIndex(rowId);
			newRow=upcTableBody.rows[po];
			chk='';
			if(data.bonus){
				chk = "<input type='checkbox' id='checkAjax"+rowId+"' disabled='disabled' checked = 'checked'\/>";
			}
			else{
				chk = "<input type='checkbox' id='checkAjax"+rowId+"' disabled='disabled'\/>";
			}

			newRow.cells[2].innerHTML = chk;
			newRow.cells[3].innerHTML = data.unitSize;
			newRow.cells[4].innerHTML = data.unitMeasureDesc;
			newRow.cells[5].innerHTML = data.length;
			newRow.cells[6].innerHTML = data.width;
			newRow.cells[7].innerHTML = data.height;
			newRow.cells[8].innerHTML = data.size;
			newRow.cells[9].innerHTML = data.subBrandDesc;
			//newRow.cells[9].innerHTML=data.wic
			btnDeleteWrap = (YAHOO.env.ua.ie > 0 && YAHOO.env.ua.ie < 9) ? newRow.cells[11].firstChild : newRow.cells[11].firstElementChild;
 			btnModifyWrap = (YAHOO.env.ua.ie > 0 && YAHOO.env.ua.ie < 9) ? newRow.cells[12].firstChild : newRow.cells[12].firstElementChild;
 			btnDeleteWrap.style.display='block';
 			btnModifyWrap.style.display='block';
			newRow.cells[13].innerHTML = '';
			newRow.cells[14].innerHTML = '';
			for(var i=2;i<10;i++)
			{
				newRow.cells[i].align='center';
			}
		 }
	}

	function firstRowAvailable()
	{
		fstRow=upcTableBody.rows[1];
		var isValid=false;

		if(fstRow.cells[13]!=null)
		{
			if(fstRow.cells[13].innerHTML=='')
			{
				isValid=true;
			}
		}
		else
		{
			isValid=true;
		}
		if(isValid)
		{
			fstRow.cells[2].firstChild.disabled=true;
		}
		if(fstRow.cells[2].firstChild.disabled)
		{
			return true;
		}
		return false;
	}

	function addCss(cssCode) {
		var styleElement = document.createElement("style");
		styleElement.type = "text/css";
	if (styleElement.styleSheet) {
		styleElement.styleSheet.cssText = cssCode;
	} else {
    styleElement.appendChild(document.createTextNode(cssCode));
	}
		document.getElementsByTagName("head")[0].appendChild(styleElement);
	}

	function copyDataTonewRow2()
	{
		if(upcTableBody.rows.length>1 &&firstRowAvailable())
		{
			fR=getFirstRow();
			if(fR!=null)
			{
				temp=getValueFromUomDesc(fR);
				YAHOO.util.Dom.get("unitSizeNew1").value = fR[3];
				if(temp.length > 0)
				{
					YAHOO.util.Dom.get("unitOfMeasureNew1").value = temp;
				}
				YAHOO.util.Dom.get("unitOfMeasureNew1").text = fR[4];

				YAHOO.util.Dom.get("lengthNew").value = fR[5];
				YAHOO.util.Dom.get("widthNew").value = fR[6];
				YAHOO.util.Dom.get("heightNew").value = fR[7];
				YAHOO.util.Dom.get("sizeNew").value=fR[8];
				YAHOO.util.Dom.get('subbrandNewACInput').value = fR[9];
				if(fR[9].length > 0)
				{
					subbrandNew.value=	fR[9].substring(fR[9].lastIndexOf("[")+1, fR[9].lastIndexOf("]"));
					sbNameNew.value=fR[9];
				}
			}
		}
	}

	function clearCopyData2()
	{
		YAHOO.util.Dom.get("unitSizeNew1").value = '';
		dwr.util.setValue("unitOfMeasure1", dwr.util.getValue("unitOfMeasureNew1"));
		//YAHOO.util.Dom.get("unitOfMeasureNew1").value = 'D';
		YAHOO.util.Dom.get("lengthNew").value = '';
		YAHOO.util.Dom.get("widthNew").value = '';
		YAHOO.util.Dom.get("heightNew").value = '';
		YAHOO.util.Dom.get("sizeNew").value='';
		subBrandNewClear();
	}

	function doFilterSubbrand(subbrand,subbrandHd)
	{
		if(subbrand.length==0)
		{

			return '';
		}
		if(subbrand=="[]")
		{
			return '';
		}

			var temp=subbrandHd;

			if(subbrandHd!=subbrand)
			{
				return '';
			}
			return subbrandHd;
	}

	function isExistStyle(str) {

		var St = document.all.tags('STYLE');
		for(var i=0;i<St.length;i++)
		{

			if(St[i].innerHTML.indexOf(str, 0) > -1)
			{
				return true;
			}
		}
		return false;

	}

	function reSetZIndex()
	{
		aL=getavailableList();
		if(aL!=null)
		{
			var scaleVl=aL.length;
			for(var i=0;i<aL.length;i++)
			{
				cR=upcTableBody.rows[aL[i]];
				if(cR.cells[9]!=null)
				{
					if(cR.cells[9].firstChild!=null)
					{
					    try{
                            cR.cells[9].firstChild.style.zIndex=6000+(scaleVl*30)+50;
						}catch (e){}
						scaleVl--;
					}
				}
			}
		}
	}

	function getavailableList()
	{
		aL=[];
		var isValid=false;
		for(var i=0;i<upcTableBody.rows.length;i++)
		{
				cR=upcTableBody.rows[i];
				if(!(cR.cells[2].firstChild.disabled))
				{
					aL.push(i);
				}
		}
		return aL;
	}

	function cancelUpc(key)
	{
        var beforeEditVl = cacheUPCData[key];
		 if(beforeEditVl!=null)
		 {
			var separateC=key.lastIndexOf("_");
			var rowId=key.substring(6,separateC);
			var po=getCurrentRowIndex(rowId);
			var newRow=upcTableBody.rows[po];
			newRow.cells[2].innerHTML = beforeEditVl[2];
			newRow.cells[3].innerHTML = beforeEditVl[3];
			newRow.cells[4].innerHTML = beforeEditVl[4];
			newRow.cells[5].innerHTML = beforeEditVl[5];
			newRow.cells[6].innerHTML = beforeEditVl[6];
			newRow.cells[7].innerHTML = beforeEditVl[7];
			newRow.cells[8].innerHTML = beforeEditVl[8];
			newRow.cells[9].innerHTML = beforeEditVl[9];
			//newRow.cells[9].innerHTML=data.wic
			btnDeleteWrap = (YAHOO.env.ua.ie > 0 && YAHOO.env.ua.ie < 9) ? newRow.cells[11].firstChild : newRow.cells[11].firstElementChild;
 			btnModifyWrap = (YAHOO.env.ua.ie > 0 && YAHOO.env.ua.ie < 9) ? newRow.cells[12].firstChild : newRow.cells[12].firstElementChild;
 			btnDeleteWrap.style.display='block';
 			btnModifyWrap.style.display='block';
			newRow.cells[13].innerHTML = '';
			newRow.cells[14].innerHTML = '';
			for(var i=2;i<10;i++)
			{
				newRow.cells[i].align='center';
			}
		}
	}

	function trim(str, chars)
	{
		return ltrim(rtrim(str, chars), chars);
	}

	function ltrim(str, chars) {
		chars = chars || "\\s";
		return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
	}

	function rtrim(str, chars) {
		chars = chars || "\\s";
		return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
	}

	function doWhen2DivIsNone()
	{
		if(document.getElementById('addrow').style.display == 'none' && document.getElementById('onemore').style.display == 'none')
		{
			document.getElementById('addrow').style.display = 'block';
			clearData();
			copyDataTonewRow();
		}
	}

	function doWhenUPCsectionInvalid()
	{
		if(document.getElementById("nextButton")!=null) {
	    	document.getElementById("nextButton").disabled = false;
		}
		goToNextTabHook=null;
		doAfterRunEnableCheckboxForSave();
	}

	function doAfterRunEnableCheckboxForSave()
	{
		if(upcTableBody!=null)
		{
			if(upcTableBody.rows.length>1)
			{
				for(i=0;i<upcTableBody.rows.length;i++)
				{
					cR=upcTableBody.rows[i];
					isValid=false;
					if(cR.cells[13]!=null)
						{
							if(cR.cells[13].innerHTML=='')
							{
								isValid=true;
							}
						}
						else
						{
							isValid=true;
						}

					if((!cR.cells[2].firstChild.disabled) && isValid)
					{
						cR.cells[2].firstChild.disabled=true;
					}
				}
			}
		}
	}

	function invalid0(element){
		if(null != element && element != undefined){
			var caseUPC = element.value;
			if(/^0+$/.test(caseUPC)){
				alert("This UPC is invalid. Please try another UPC.");
				element.value = "";
				element.focus();
			}
		}
	}
	
	function myTrim(x) {
		return x.replace(/^\s+|\s+$/gm,'');
	}

	function removeDisableScaleAtt(isRemove){
		var engDescLine1 = YAHOO.util.Dom.get("engDescLine1");
		var engDescLine2 =  YAHOO.util.Dom.get("engDescLine2");
		var spaDescLine1 = YAHOO.util.Dom.get("spaDescLine1");
		var spaDescLine2 = YAHOO.util.Dom.get("spaDescLine2");
		var engDescLine3 = YAHOO.util.Dom.get("engDescLine3");
		var engDescLine4 = YAHOO.util.Dom.get("engDescLine4");
		var engDesc1 = YAHOO.util.Dom.get("engDesc1");
		var engDesc2 = YAHOO.util.Dom.get("engDesc2");
		var prePackTare = YAHOO.util.Dom.get("prePackTare");
		var shelfLifeDays = YAHOO.util.Dom.get("shelfLifeDays");
		var gradeNbr = YAHOO.util.Dom.get("gradeNbr");
		var netWt = YAHOO.util.Dom.get("netWt");
		var mechTenz = YAHOO.util.Dom.get("mechTenz");
		<c:if test="${addNewCandidate.userRole eq 'RVEND' || (addNewCandidate.productVO.workRequest.workStatusCode eq '103' && addNewCandidate.userRole ne 'RVEND')}">
			var scaleAttribDiv = YAHOO.util.Dom.get("scaleAttribDiv");
			if(null != scaleAttribDiv && scaleAttribDiv != undefined){
				 scaleAttribDiv.style.display = 'none';
				 scaleAttribDiv.style.position = 'absolute';
			}
		</c:if>
		<c:if test="${addNewCandidate.userRole ne 'RVEND'}">
			if(isRemove == "true"){
				if(null != engDescLine1 && engDescLine1 != undefined){
					engDescLine1.removeAttribute("disabled");
				}
				if(null != engDescLine2 && engDescLine2 != undefined){
					engDescLine2.removeAttribute("disabled");
				}
				if(null != spaDescLine1 && spaDescLine1 != undefined){
					spaDescLine1.removeAttribute("disabled");
				}
				if(null != spaDescLine2 && spaDescLine2 != undefined){
					spaDescLine2.removeAttribute("disabled");
				}
				if(null != prePackTare && prePackTare != undefined){
					prePackTare.removeAttribute("disabled");
				}
				if(null != shelfLifeDays && shelfLifeDays != undefined){
					shelfLifeDays.removeAttribute("disabled");
				}
				if(null != gradeNbr && gradeNbr != undefined){
					gradeNbr.removeAttribute("disabled");
				}
				if(null != engDescLine3 && engDescLine3 != undefined){
					engDescLine3.removeAttribute("disabled");
				}
				if(null != engDescLine4 && engDescLine4 != undefined){
					engDescLine4.removeAttribute("disabled");
				}
				if(null != engDesc1 && engDesc1 != undefined){
					engDesc1.removeAttribute("disabled");
				}
				if(null != engDesc2 && engDesc2 != undefined){
					engDesc2.removeAttribute("disabled");
				}
				if(null != netWt && netWt != undefined){
					netWt.removeAttribute("disabled");
				}
				if(null != mechTenz && mechTenz != undefined){
					mechTenz.removeAttribute("disabled");
				}
			}
		</c:if>
	}

	var callbacks = {
			success : function(o) {
				try {
					if (o != null && o.responseText != "") {
						removeDisableScaleAtt(myTrim(o.responseText));
					}
				} catch (e) {
					return;
				}
			},
			failure : function() {
				hideTheProgress();
			},
			timeout : 5000
		};
		YAHOO.util.Connect
				.asyncRequest(
						'GET',
						"removedDisableScaleAtt",
						callbacks);
	
	YAHOO.util.Event.onDOMReady(function(){
		getUPCLists();
		 });
	//PIM-1484
	function changeFdaMenuLabelingStatus(data) {	 
		var fdaMenuLabelingStatus = document.getElementById("fdaMenuLabelingStatus");
		if(fdaMenuLabelingStatus!=null) {
			fdaMenuLabelingStatus.innerText = data.fdaMenuLabelingStatus;
		}
	}
	
	function displayKITUPC(data) {
		hideProgress();
		var numArray = data.split(',');
		kitUpc = numArray[0];
		checkDigit = numArray[1];
		document.getElementById("unitUpc1").value = kitUpc;
		document.getElementById("unitUpc1").disabled = true;
		document.getElementById("unitUpc12").value = checkDigit;
	}
</script>
<!-- END upc.jsp MODULE -->