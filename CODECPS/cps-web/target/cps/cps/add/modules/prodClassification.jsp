<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="f" uri="/WEB-INF/functions.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<base ref="site" />

<c:url value="${request.getContextPath()}/yui/treeview/assets/skins/sam/treeview.css" var="treeview"/>
<link rel="stylesheet" type="text/css" href="${treeview}" />
<c:url value="${request.getContextPath()}/yui/treeview/treeview-min.js" var="treeviewjs"/>
<script type='text/javascript' src='${treeviewjs}'></script>

<style type="text/css">
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
	#RNAPanel_c.yui-panel-container.shadow .underlay{
		left: 1px;
		right: -1px;
		top: 1px;
		bottom: -1px;
		position: absolute;
		background-color: #000;
		opacity: 0.12;
		filter: alpha(opacity = 12);
	}

	/* Apply the border to the right side */
	#RNAPanel.yui-panel{
		border: none;
		overflow: visible;
		background: transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat
		top right;
	}

	/* Style the close icon */
	#RNAPanel.yui-panel .container-close{
		position: absolute;
		top: 5px;
		right: 8px;
		height: 21px;
		width: 21px;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
	}

	/* Style the header with its associated corners */
	#RNAPanel.yui-panel .hd{
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
	#RNAPanel.yui-panel .bd {
		overflow: hidden;
		padding: 10px;
		border: none;
		background: #FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y;
		margin: 0 4px 0 0;
	}

	/* Style the footer with the bottom corner images */
	#RNAPanel.yui-panel .ft{
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
		font-size: 11px;
		height: 26px;
		padding: 0px 10px;
		border: none
	}

	/* Skin custom elements */
	#RNAPanel.yui-panel .hd span{
		line-height: 30px;
		vertical-align: middle;
		font-weight: bold;
	}

	#RNAPanel.yui-panel .hd .tl{
		width: 8px;
		height: 29px;
		top: 1px;
		left: 0px;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
		position: absolute;
	}

	#RNAPanel.yui-panel .hd .tr {
		width: 8px;
		height: 29px;
		top: 1px;
		right: 0;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat;
		position: absolute;
	}

	#RNAPanel.yui-panel .ft span{
		line-height: 22px;
		vertical-align: middle;
	}

	#RNAPanel.yui-panel .ft .bl {
		width: 8px;
		height: 26px;
		bottom: 0;
		left: 0;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
		position: absolute;
	}

	#RNAPanel.yui-panel .ft .br{
		width: 8px;
		height: 26px;
		bottom: 0;
		right: 0;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
		position: absolute;
	}

	span.link{
		text-decoration:underline;
	}

	span.link:hover{
		text-decoration:underline;
		color: blue;
		cursor:pointer;
	}


</style>

<script type="text/javascript">
    YAHOO.namespace('HEB.productClassification');
    var allowString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789@$%&-_\\/.?";

    function parseReceiptView(){
        var proddesc = document.getElementById("proddescHidden");
        if(proddesc.innerText.length > 25){
            var receiptView = proddesc.innerText.substring(0,25);
            var rightText = proddesc.innerText.substring(25);
            proddesc.innerHTML = receiptView.fontcolor("0x009900") + rightText;
        }else
            proddesc.innerHTML = proddesc.innerText.fontcolor("0x009900");

        document.getElementById("proddesc").value = proddesc.innerText;
    }

    function copyText()
    {
        if(document.getElementById("proddescHidden"))
        {
            var vl=document.getElementById("proddescHidden");
            var comp = YAHOO.lang;
            var temp = comp.trim(vl.innerText);
            for (i=0; i < temp.length; i++) {
                var x = temp.charAt(i);
                if (allowString.indexOf(x) < 0)
                {
                    alert("Description only allow special character in @ $ % & - _ \\ / . ?");
                    vl.innerText ="";
                    vl.select();
                    vl.focus();
                    return;
                }
            }
        }
        if(document.getElementById("scanDesc")!=null && document.getElementById("proddescHidden")!=null){
            var dsc = document.getElementById("proddescHidden").innerText;
            if(dsc.indexOf(";") > -1 )
                if(document.getElementById("proddescHidden").innerText!=null){
                    document.getElementById("scanDesc").value= document.getElementById("proddescHidden").innerText.substring(0,12);
                } else {
                    document.getElementById("scanDesc").value="";
                }
        }
    }

    function switchToUpperCase1(obj){
        var a = obj.innerText;
        obj.innerText = a.toUpperCase();
    }
</script>

<a id="sec0tion"></a>
<c:url var="iconQuestion" value="${request.getContextPath()}/hebAssets/images/buttons/iconQuestion.png"/>

<fieldset style="width: 95%">
	<legend class="legendFont">Product Classification </legend>
	<table width="100%" border="0">
		<tr align="left">
			<td align="right" width="15%">
				<label for="selectedChannel" class="labelFont helpable" id="ProductLabel">
					Product Type <em><font color="red"><b>*</b></font></em>
				</label>
			</td>
			<td align="left" width="35%">
				<cps:renderByResourceAccess resourceId="21">
					<jsp:attribute name="EDIT">
						<form:select onchange="getUPCListsForProduct();getMerchandizeTypes();nonSellableHide();setRetailValues();"
									 path="productVO.classificationVO.productType" tabindex="1" id="prodTypeSelect"
									 cssClass="selectBoxStyle2" >
                        	<form:options items="${addNewCandidate.productTypes}" itemLabel="name"	itemValue="id" />
                    	</form:select>
					</jsp:attribute>
				<jsp:attribute name="VIEW">
					<form:input id="prodTypetxt" path="productVO.classificationVO.productTypeName"
							   disabled="true"></form:input>
				</jsp:attribute>
			</cps:renderByResourceAccess>
				<input id="prodTypeHidden" type="hidden" value="${productVO.classificationVO.productType}">
				<%--<form:hidden path="productVO.classificationVO.productType"  id="prodTypeHidden"/>--%>
			</td>
			<td align="right" width="15%">
				<label class="labelFont helpable" id="MerchandiseTypeLabel">
					Merchandise Type <em><font color="red"><b>*</b></font></em>
				</label>
			</td>
			<td align="left" width="35%">
				<cps:renderByResourceAccess resourceId="173">
					<jsp:attribute name="EDIT">
						<c:choose>
							<c:when test="${fn:length(addNewCandidate.sessionVO.merchandizingTypes) == 0}">
								<c:set value="true" var="dis" />
							</c:when>
							<c:otherwise>
								<c:set value="false" var="dis" />
							</c:otherwise>
						</c:choose>
						<form:select onchange="renderPageBasedOnMerchType();setRetailValues();" onblur="checkSelected();"
									 path="productVO.classificationVO.merchandizeType" tabindex="2" id="merchTypes"
									 cssClass="selectBoxStyle2" disabled="${dis}">
                        	<form:options items="${addNewCandidate.sessionVO.merchandizingTypes}" itemLabel="name"
										  itemValue="id" />
                    	</form:select>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.classificationVO.merchandizeName" disabled="true"></form:input>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
		</tr>
		<tr>
			<td align="right" width="15%">
				<label for="selectedChannel" class="labelFont helpable" id="BDMLabel">
					BDM <em><font color="red"><b>*</b></font></em>
				</label>
			</td>
			<td align="left" width="35%">
				<cps:renderByResourceAccess resourceId="22">
					<jsp:attribute name="EDIT">
						<cps:autoComplete3 searchAction="bdmSearch" uniqueId="bdm"
										   zi="9050" compWidth="85%" genericHiddenElmName="bdmSelectedName"
										   highlightMatch="true" maxResults="150" onSelectMethod="bdmChange"
										   searchOnId="true" showId="false"
										   strutsHiddenElmProperty="productVO.classificationVO.alternateBdm"
										   tabIdx="3" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.classificationVO.bdmName" disabled="true" style="width:85%;"></form:input>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="15%">
				<label for="selectedChannel" class="labelFont helpable" id="CommodityLabel">
					Commodity <em><font color="red"><b>*</b></font></em>
				</label>
			</td>
			<td align="left" width="35%">
				<cps:renderByResourceAccess resourceId="24">
					<jsp:attribute name="EDIT">
						<cps:autoComplete3 searchAction="currentCommoditiesSearch"
										   uniqueId="commodity" compWidth="80%" tabIdx="4"
										   strutsHiddenElmProperty="productVO.classificationVO.commodity"
										   genericHiddenElmName="commoditySelectedName"
										   highlightMatch="true" maxResults="150" searchOnId="true"
										   showId="true" zi="9000" maxCacheEntries="0"
										   onSelectMethod="commodityChange" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.classificationVO.commodityNameValue" disabled="true"
									style="width:80%;"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
		</tr>
		<tr>
			<td align="right" width="15%">
				<label for="selectedChannel" class="labelFont helpable" id="SubComLabel">
					Sub Commodity<em><font color="red"><b>*</b></font></em>
				</label>
			</td>
			<td align="left" width="35%">
				<cps:renderByResourceAccess resourceId="25">
					<jsp:attribute name="EDIT">
						<cps:autoComplete3 searchAction="currentSubCommoditiesSearch"
										   uniqueId="subCommodity" compWidth="85%"
										   genericHiddenElmName="subCommoditySelectedName"
										   highlightMatch="true" maxCacheEntries="0" maxResults="100"
										   searchOnId="true" showId="true"
										   strutsHiddenElmProperty="productVO.classificationVO.subCommodity"
										   tabIdx="5" zi="9048" onSelectMethod="subCommodityChange" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.classificationVO.subCommodityName" disabled="true"
									style="width:85%;" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
			<td align="right" width="15%">
				<label for="selectedChannel" class="labelFont helpable" id="ClassLabel">
					Class <em><font color="red"><b>*</b></font></em>
				</label>
			</td>
			<td align="left" width="35%">
				<cps:renderByResourceAccess resourceId="23">
					<jsp:attribute name="EDIT">
						<form:input path="productVO.classificationVO.classDesc"
									readonly="true" cssClass="textFieldNormal" style="width: 80%;"
									id="classDisplay" />
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.classificationVO.classDesc" id="classDisplay"
									readonly="true" cssClass="textFieldNormal" style="width: 80%;" disabled="true" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<form:hidden path="productVO.classificationVO.classField" id="classField" />
			</td>
		</tr>
		<tr>
			<td align="right" width="15%">
				<label for="proddesc" class="labelFont helpable" id="ProductDescriptionLabel">
					Product Description
					<span class="mtGroup mtGroup1 mtGroup3 mtGroup4 mtGroup5 mtGroup6">
						<em> <font color="red"><b>*</b></font></em>
					</span>
				</label>
			</td>
			<form:hidden path="productVO.classificationVO.prodDescritpion" id="proddesc"/>
			<td align="left" width="35%" style="position: relative;">
				<cps:renderByResourceAccess resourceId="26">
					<jsp:attribute name="EDIT">
						<div contenteditable id="proddescHidden" class="textFieldNormal"
						 	style="TEXT-TRANSFORM: uppercase; width:85%;border: 1px solid #707070; line-height: 21px;"
						 	tabindex="7"
						 	onblur="copyText();switchToUpperCase1(this); parseValue(event); parseReceiptView();  return true;"
						 	onkeydown="return maxLength(event);"
							 onkeypress="return preventKeyCode(event);"
						 	onpaste="return maxLengthReturnValue(event) ">
						</div>
					<img src="${iconQuestion}"
						   title="Highlighted area in green represents exact description that will print on the customer's register receipt. Review for excellence and appropriate language." width="20" onmouseover="this.style.cursor='pointer'" style="position: absolute; top: 0px; right: 9%;"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<div id="proddescHidden" class="textFieldNormal"
							 style="TEXT-TRANSFORM: uppercase; width:85%;border: 1px solid #707070; line-height: 21px; background: #e5e5e5;"
							 tabindex="7">
						</div>
						<img src="${iconQuestion}" title="Highlighted area in green represents exact description that will print on the customer's register receipt. Review for excellence and appropriate language." width="20" onmouseover="this.style.cursor='pointer'" style="position: absolute; top: 0px; right: 9%;"/>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>

			<td align="right" width="15%">
				<label for="selectedChannel" class="labelFont helpable" id="BrandLabel">
					<c:choose>
						<c:when test="${addNewCandidate.scaleProduct eq false && addNewCandidate.brandMandatory}">
							<c:set var="brandStyle" value="display:block;"></c:set>
						</c:when>
						<c:otherwise>
							<c:set var="brandStyle" value="display:none;"></c:set>
						</c:otherwise>
					</c:choose>
					Brand
					<span class="mtGroup mtGroup1 mtGroup4 mtGroup5" id="brandix" style="${brandStyle}">
						<em id="brandStar" style="color: red"><b>*</b></em>
					</span>
				</label>
			</td>
			<td align="left" width="35%">
				<cps:renderByResourceAccess resourceId="40">
					<jsp:attribute name="EDIT">
						<cps:autoComplete2 forceSelection="true"
										   jsonSearchMethodName="brandSearch" autoHighlight="true"
										   uniqueId="brand" tabindex="8"
										   strutsHiddenElmProperty="productVO.classificationVO.brand"
										   onSelectMethod="brandChange" style="width:80%;" />
						<form:hidden path="productVO.classificationVO.brandName"  id="brandName"
									 style="visibility: hidden;display:none"/>
					</jsp:attribute>
					<jsp:attribute name="VIEW">
						<form:input path="productVO.classificationVO.brandNameDisplay" disabled="true"
									style="width:80%;" />
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
		</tr>
		<tr>
			<td align="right" width="15%"></td>
			<td align="left" width="35%"></td>
			<td align="left" width="15%"></td>
			<td align="left" width="35%">
				<cps:renderByResourceAccess resourceId="174">
					<jsp:attribute name="EXEC">
						<button type="button" id="reqAttribute" name="button1" value="requestnewattribute" tabindex="9">
							Request new attribute
						</button>
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</td>
		</tr>
	</table>
	<div id="RNAPanel" style="display: none;">
		<div class="hd">
			<div class="tl"></div>
			<span><font size="2" color="white">&nbsp;&nbsp;&nbsp; Request New Attribute</font></span>
			<div class="tr"></div>
		</div>
		<div class="bd">
			<iframe id="RNApopupFrame" height="1px" width="1px"></iframe>
		</div>
		<div class="ft">
			<div class="bl"></div>
			<div class="br"></div>
		</div>
	</div>
</fieldset>

<script type="text/javascript">
    <c:choose>
    <c:when test="${fn:length(addNewCandidate.merchandizingTypes) == 0}">
    var selectBox = YAHOO.util.Dom.get("merchTypes");
    selectBox.options[selectBox.length] = new Option('--Select--', '0');
    selectBox.disabled=true;
    </c:when>
    </c:choose>

    //check selected merchandise when tabs out
    function checkSelected(){
        var merchandiseValue = YAHOO.util.Dom.get("merchTypes");
        var prodType = document.getElementById('prodTypeSelect');
        if(prodType.value == "SPLY"){
            if(merchandiseValue.value == ""){
                merchandiseValue.focus();
            }
        }
    }

    function setEndOfContenteditable(contentEditableElement)
    {
        var range,selection;
        if(document.createRange)//Firefox, Chrome, Opera, Safari, IE 9+
        {
            range = document.createRange();//Create a range (a range is a like the selection but invisible)
            range.selectNodeContents(contentEditableElement);//Select the entire contents of the element with the range
            range.collapse(false);//collapse the range to the end point. false means collapse to end rather than the start
            selection = window.getSelection();//get the selection object (allows you to change selection)
            selection.removeAllRanges();//remove any selections already made
            selection.addRange(range);//make the range you have just created the visible selection
        }
        else if(document.selection)//IE 8 and lower
        {
            range = document.body.createTextRange();//Create a range (a range is a like the selection but invisible)
            range.moveToElementText(contentEditableElement);//Select the entire contents of the element with the range
            range.collapse(false);//collapse the range to the end point. false means collapse to end rather than the start
            range.select();//Select the range (make it the visible selection
        }
    }

    function productFocus(){
        document.getElementById('prodTypeSelect').focus();
    }

    executeAfterBodyVisible(productFocus);


    function forClass(evt){
        var classField = YAHOO.util.Dom.get("classField").value;
        showSection(classField);
    }
    <c:if test= "${null != addNewCandidate.productVO.classificationVO.classField}" >
    YAHOO.util.Event.onDOMReady( forClass );
    </c:if>

    function afterSave(evt){
        var bdm = YAHOO.util.Dom.get("bdmStrutsHiddenElm");
        var bdmVal = bdm.value;
        var classField = YAHOO.util.Dom.get("classField").value;
        showSection(classField);
    }

    YAHOO.util.Event.onDOMReady( afterSave );
    function bdmChange(evt){
        var bdm = YAHOO.util.Dom.get("bdmStrutsHiddenElm");
        var bdmVal = bdm.value;
        YAHOO.util.Dom.get("commodityACInput").value = "";
        YAHOO.util.Dom.get("subCommodityACInput").value = "";
        YAHOO.util.Dom.get("classDisplay").value = "";
        var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
        if (!isWorkingKitComponents()) {
            if(null != taxFlag && taxFlag != undefined){
                taxFlag.checked = false;
            }
            resetTaxCate();
        }
        var commodityAC = YAHOO.util.Dom.get("commodityACContainer");
        var elements = commodityAC.getElementsByTagName("div");
        for (var i = 0; i < elements.length; i++) {
            if(elements[i].className == 'yui-ac-content'){
                elements[i].style.display='none';
                break;
            }
        }
        fillDataToTableSellingRes(initData);
        dwr.util.removeAllOptions("pssdepts");
        showWicDiv("");
        showProgress();
        //this method looks up the comms, puts them in the session, and
        //returns a message or nothing at all.  The commodities auto complete
        //will request commodities when it needs them
        AddCandidateTemp.getCommoditiesFromBDMNoReturn(bdmVal, getDWRCallbackMethod(updateComms));
    }

    function resetTaxCate(){
        var taxCateHidden = document.getElementById("taxCateCodeHidden");
        var taxCateNameHidden = document.getElementById("taxCateNameHidden");
        var taxCategoryWrap = document.getElementById("taxCategoryWrap");

        if(null != taxCateHidden && taxCateHidden != undefined){
            document.getElementById("taxCateCodeHidden").value = '';
        }
        if(null != taxCateNameHidden && taxCateNameHidden != undefined){
            document.getElementById("taxCateNameHidden").value = '';
        }
        if(null != taxCategoryWrap && taxCategoryWrap != undefined){
            document.getElementById("taxCategoryWrap").innerHTML = '-Select-';
            document.getElementById('taxCateImageId').style.display  ='none';
        }
    }

    function commodityChange(aArgs){
        var bdm = YAHOO.util.Dom.get("bdmStrutsHiddenElm");
        var comm = YAHOO.util.Dom.get("commodityStrutsHiddenElm");
        var foodStamp = YAHOO.util.Dom.get("foodStamp");
        var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
        resetSubCom();
        fillDataToTableSellingRes(initData);
        dwr.util.removeAllOptions("pssdepts");
        foodStamp.checked=false;
        if (!isWorkingKitComponents()) {
            taxFlag.checked=false;
            resetTaxCate();
        }
        showProgress();
        AddCandidateTemp.getClassSubCommPSSForCommodity(comm.value, getDWRCallbackMethod(updateClassPss));
    }

    function resetSubCom(){
        YAHOO.util.Dom.get("subCommodityStrutsHiddenElm").value = "";
        YAHOO.util.Dom.get("subCommodityGenericHiddenElm").value = "";
        YAHOO.util.Dom.get("subCommodityACInput").value = "";
    }

    function subCommodityChange(aArgs){
        var subComm = YAHOO.util.Dom.get("subCommodityStrutsHiddenElm");
        getInitSellingResDT(subComm.value);
        showProgress();
        AddCandidateTemp.getCodesForSubCommodity(subComm.value, updateCodeWrapper);
    }

    var checkedTax = false ;

    function updateCodeWrapper(data){
        var msgData = data.messages;
        if(! msgData.exception){
            try{
                updateCode(data.appData);
            }catch(e){}
        }else{
            YAHOO.util.Dom.get("bdmACInput").value = "";
            YAHOO.util.Dom.get("commodityACInput").value = "";
            YAHOO.util.Dom.get("subCommodityACInput").value = "";
            YAHOO.util.Dom.get("classDisplay").value = "";
            try{hideProgress();}catch(e){}
            alert("Sorry, there was an error retrieving tax, food stamp, and labor information for the requested Sub Commodity.  Please re-select your commodity and sub-commodity.");
        }
    }

    function updateCode(data){
        var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
        var foodStamp = YAHOO.util.Dom.get("foodStamp");
        var taxFlagDefault = YAHOO.util.Dom.get("taxabilityDefaultFlag");
        var foodStampDefault = YAHOO.util.Dom.get("foodStampDefault");
        var fsc = data.FSC;
        var ctc = data.CTC;
        var lcc = data.LCC;

        if (fsc=='Y'){
            foodStamp.checked=true;
            foodStampDefault.value='true';
        }
        else{
            foodStamp.checked=false;
            foodStampDefault.value='false';
        }
        // fix food stamp sign when change sub-commodity
        displayFoodStampSign();
        if (!isWorkingKitComponents()) {
            if (ctc=='Y'){
                taxFlag.checked=true;
                checkedTax = true ;
                taxFlagDefault.value = 'true';
            }
            else{
                taxFlag.checked=false;
                checkedTax = false ;
                taxFlagDefault.value = 'false';
            }
        }
        this.getBricksBySubCommodity();
    }

    function getBricksBySubCommodity(){
        var subComm = YAHOO.util.Dom.get("subCommodityStrutsHiddenElm");
        AddCandidateTemp.getBricksBySubCommodity(subComm.value, getDWRCallbackMethod(setDataForBrick));
    }

    function setDataForBrick(data){
        if(data && data.message){
        }
        var subComm = YAHOO.util.Dom.get("subCommodityStrutsHiddenElm");
        // get data distinct for TaxCategory-------
        if(${!addNewCandidate.vendor}) {
            var subComm = YAHOO.util.Dom.get("subCommodityStrutsHiddenElm");
            var taxFlag = YAHOO.util.Dom.get("taxabilityFlag");
            changeValueTaxWrap(subComm.value, taxFlag);
        }else {
            hideProgress();
        }
        //SPRINT 22
        AddCandidateTemp.getUOMFromSubCommodity(subComm.value,getDWRCallbackMethod(populateUOM));
    }

    //SPRINT 22
    function populateUOM(data){
        hideProgress();
        dwr.util.removeAllOptions("unitOfMeasure1");
        dwr.util.addOptions("unitOfMeasure1", data, "id", "name");
        var currVal = dwr.util.getValue("unitOfMeasure1");
        dwr.util.setValue("unitOfMeasure1", "");
        dwr.util.removeAllOptions("unitOfMeasureNew1");
        dwr.util.addOptions("unitOfMeasureNew1", data, "id", "name");
        dwr.util.setValue("unitOfMeasure1", data[0].id);
        dwr.util.setValue("unitOfMeasureNew1",  data[0].id);
        //SPRINT 22
        disableEmptyLine(YAHOO.util.Dom.get("unitOfMeasure1"));

        // PIM-1527 set default of UOM is EACH for Kit Components.
        if (isWorkingKitComponents()) {
            var idEach = null;
            for (tmpUom in data) {
                if (data[tmpUom].name == "EACH") {
                    idEach = data[tmpUom].id;
                    break;
                }
            }
            if (idEach != null) {
                dwr.util.setValue("unitOfMeasure1", idEach);
            }
        }

        //update UOM which user is modifying
        var upcTableBody = YAHOO.util.Dom.get("upcTable");
        for(var i=0;i<upcTableBody.rows.length;i++){
            var tableRow = upcTableBody.rows[i];
            if(tableRow.id.indexOf('Ajax')==0) {
                var unitOfMeasureAjax = "unitOfMeasureAjax"+tableRow.id.split("Ajax")[1];
                var value= dwr.util.getValue(unitOfMeasureAjax);
                dwr.util.removeAllOptions(unitOfMeasureAjax);
                dwr.util.addOptions(unitOfMeasureAjax, data, "id", "name");
                dwr.util.setValue(unitOfMeasureAjax, value);
                disableEmptyLine(YAHOO.util.Dom.get(unitOfMeasureAjax));
            }
            if(tableRow.id.indexOf('Normal')==0) {
                var unitOfMeasureNormal = "unitOfMeasureNormal"+tableRow.id.split("Normal")[1];
                var value= dwr.util.getValue(unitOfMeasureNormal);
                dwr.util.removeAllOptions(unitOfMeasureNormal);
                dwr.util.addOptions(unitOfMeasureNormal, data, "id", "name");
                dwr.util.setValue(unitOfMeasureNormal, value);
                disableEmptyLine(YAHOO.util.Dom.get(unitOfMeasureNormal));
            }
        }
    }

    function disableEmptyLine(data) {
        if(data!=null) {
            for(var i = 0;i < data.length;i++)
            {
                if(data.options[i].value=="")
                {
                    data.options[i].disabled=true;
                    break;
                }
            }
        }
    }

    function updateComms(data){
        hideProgress();
        //SPRINT 22
        if(data!=null && data.uoms!=null) {
            populateUOM(data.uoms);
        }
        if(data && data.message){
            alert(data.message);
        }
    }

    function updateClassPss(data){
        YAHOO.log("UPDATE CLASS");
        if(data.ERRORWS){
            alert(data.ERRORWS);
            comm = YAHOO.util.Dom.get("commodityStrutsHiddenElm");
            comm.value="";
            YAHOO.util.Dom.get("commodityACInput").value = "";
            hideProgress();
        }
        if(data.ERR){
            alert(data.ERR);
            comm = YAHOO.util.Dom.get("commodityStrutsHiddenElm");
            comm.value="";
            YAHOO.util.Dom.get("commodityACInput").value = "";
            hideProgress();
        }else{
            disableHideProgress();
            var clsObj = data.CLS;
            var pss = data.PSS;
            var sca = data.SCA;
            var comm = YAHOO.util.Dom.get("commodityStrutsHiddenElm");
            var cd = YAHOO.util.Dom.get("classDisplay");
            cd.value = ''+clsObj.name+' ['+clsObj.id+']';
            showSection(clsObj.id);
            var cf = YAHOO.util.Dom.get("classField");
            cf.value = clsObj.id
            //from the pos & acct module!
            showPSS(pss);
            showWicDiv(cf.value);
            renderPageBasedOnMerchTypeFromComm();
            var pssDept = YAHOO.util.Dom.get("pssdepts");
            var dept = data.DEP;
            var i;
            for(var i=0;i<pssDept.options.length;i++)
            {
                if(pssDept.options[i].value == dept)
                {
                    pssDept.selectedIndex.value = dept;
                }
            }
            populateUOM(data.UOMS);
        }
        AddCandidateTemp.checkEligible(comm.value, getDWRCallbackMethod(afterCheckEligible));
    }

    function afterCheckEligible(data){
        //setBrickVisible(data.isEligible);
        hideProgressOnCommodityChange();
    }

    var commCont = 0;
    function hideProgressOnCommodityChange(){
        commCont++;
        if(commCont == 2){
            enableHideProgress();
            hideProgress();
            commCont = 0;
        }
    }

    function renderPageBasedOnMerchTypeFromComm(){
        renderPageBasedOnMerchType();
        hideProgressOnCommodityChange();
    }

    function showPSS(data){
        dwr.util.removeAllOptions("pssdepts");
        dwr.util.addOptions("pssdepts", data, "id", "name");
    }

    function showSection(classField){
        YAHOO.log('showSection');
        var tobaccoAttribDiv = YAHOO.util.Dom.get("tobaccoAttribDiv");
        var pharmacyAttribDiv = YAHOO.util.Dom.get("pharmacyAttribDiv");
        var nutriDiv = YAHOO.util.Dom.get("nutriDiv");
        var ingdDiv = YAHOO.util.Dom.get("ingdDiv");
        if(classField == '32' || classField == '34' || classField == '68' || classField == '69'){
            pharmacyAttribDiv.style.display = 'block';
            pharmacyAttribDiv.style.position = 'static';
            tobaccoAttribDiv.style.display = 'none';
            tobaccoAttribDiv.style.position = 'absolute';
        }else{
            pharmacyAttribDiv.style.display = 'none';
            if(document.getElementById('PSE')){
                document.getElementById('PSE').selectedIndex = 0;
            }
            if(document.getElementById('pseGrams')){
                document.getElementById('pseGrams').value = '';
            }
            document.getElementById('ndc').value = '';
            //document.getElementById('drugAbb').selectedIndex = 0;
            document.getElementById('drugSchedule').selectedIndex = 0;
            document.getElementById('avgCost').value = '';
            document.getElementById('directCost').value = '';
        }
        <c:if test= "${'N'.charAt(0) ne addNewCandidate.productVO.newDataSw}" >
        if (classField == '62') {
            if(document.getElementById('tobaccoTax')){
                document.getElementById('tobaccoTax').selectedIndex = 1;
            }
        } else {
            if(document.getElementById('tobaccoTax')) {
                document.getElementById('tobaccoTax').selectedIndex = 2;
            }
        }
        </c:if>
        renderPageBasedOnMerchType();
    }

    function updateSubComm(data){
        YAHOO.log("UPDATE SUB COMM");
        hideProgress();
        YAHOO.HEB.productClassification.subCommodityReset(data);
    }

    function textCounter(evt) {
        var field = YAHOO.util.Dom.get("message");
        if (field.value.length > 255){ // if too long...trim it!
            field.value = field.value.substring(0, 255);
        }
    }

    <c:url value="/protected/cps/add/pow?${_csrf.parameterName}=${_csrf.token}" var="showComments"></c:url>
    function showComments(evt){
        //browser compat
        var prodUpcForm = YAHOO.util.Dom.get("prodAndUpcForm");
        prodUpcForm.action = "${showComments}";
        prodUpcForm.submit();
    }

    function getUPCListsForProduct(evt){
        var pt = dwr.util.getValue("prodTypeSelect");
        if(pt != null){
            AddCandidateTemp.getUPCListsForProduct(pt,getDWRCallbackMethod(populateUPCListForProduct));
        }
    }

    function populateUPCListForProduct(data){
        var upcTypes = data.UPC_TYPES;
        dwr.util.removeAllOptions("upcType1");
        dwr.util.addOptions("upcType1", upcTypes, "id", "name");
        <c:if test="${!addNewCandidate.upcValueFromMRT}">
        if(dwr.util.getValue("prodTypeSelect") == 'GOODS'){
            dwr.util.setValue("upcType1", "UPC");
        }
        </c:if>
        loadUPCTypeDefault();
    }

    function getMerchandizeTypes(evt, aArgs){
        var pt = dwr.util.getValue("prodTypeSelect");
        if(pt != null){
            showProgress();
            AddCandidateTemp.getMerchandizeForProductType(pt,getDWRCallbackMethod(updateMerchanType));
        }
    }

    function updateMerchanType(data){
        hideProgress();
        dwr.util.removeAllOptions("merchTypes");
        dwr.util.addOptions("merchTypes", data, "id", "name" );
        YAHOO.util.Dom.get("merchTypes").disabled=false;
        var pt = dwr.util.getValue("prodTypeSelect");
        if(data.length == 0){
            var selectBox = YAHOO.util.Dom.get("merchTypes");
            selectBox.options[selectBox.length] = new Option('--Select--', '0');
            selectBox.disabled=true;
        }
        if(pt == "SPLY"){
            var selectBox = YAHOO.util.Dom.get("merchTypes");
            selectBox.options.add(new Option('',''),0);
        }
        <cps:currentComponentValueSubTag strutsHiddenElmProperty="productVO.classificationVO.merchandizeType" uniqueId="merchTypes" />
        <c:if test="${requestScope.currentComponentId != null}">
        dwr.util.setValue("merchTypes", "${requestScope.currentComponentId}");
        if(pt == "SPLY"){
            dwr.util.setValue("merchTypes", "");
        }
        </c:if>
    }

    var oPushButton1 = new YAHOO.widget.Button("reqAttribute");

    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("reqAttribute"), "click", reqAttribute);
    <c:url value="requestNewAtt" var="page50" />
    var oneTime = false;
    function reqAttribute(evt){
        ///f1('${page50}'+'&t='+new Date().getTime(),'Request New Attribute','200px','62%','130px','200px');
        document.getElementById("RNAPanel").style.display="inline";
        if(oneTime == false){
            oneTime = true;
            YAHOO.heb.container.reqNewAttrib = new YAHOO.widget.Panel("RNAPanel",
                { 	width:"600px",
                    height:"320px",
                    underlay:"shadow",
                    visible:false,
                    constraintoviewport:true,
                    draggable:false,
                    zIndex : 15000,
                    modal:true,
                    close:true,
                    fixedCenter : true,
                    effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}
                } );

            YAHOO.heb.container.reqNewAttrib.render(document.body);

        }
        YAHOO.heb.container.reqNewAttrib.beforeHideEvent.subscribe(onBeforeRNAPanelHide);
        YAHOO.heb.container.reqNewAttrib.beforeShowEvent.subscribe(onBeforeShowRNAEvent);
        YAHOO.heb.container.reqNewAttrib.show();

        document.getElementById("RNApopupFrame").style.height="100%";
        document.getElementById("RNApopupFrame").style.width="100%";
        document.getElementById("RNApopupFrame").src = "${page50}";
    }

    function onShowRNAEvent(){
    }

    function onBeforeShowRNAEvent(){
    }

    function onBeforeRNAPanelHide(){
        document.getElementById("RNAPanel").style.display="none";
        document.getElementById("RNApopupFrame").src = "";
    }
    function closeRNAPanel(){
        YAHOO.heb.container.reqNewAttrib.hide();
    }

    var tree = null;
    var selectedNode = null, selectedNodeTmp = null;
    var treeData = null;

    YAHOO.util.Event.onDOMReady(function(){
        //setBrickVisible(${addNewCandidate.productVO.classificationVO.eligible});
        parseViewDesciption();
    });

    function parseViewDesciption(element){
        var proddesc = document.getElementById("proddescHidden");
        var proddescHidden = document.getElementById("proddesc");
        if(proddescHidden){
            if(proddescHidden.value.length > 25){
                var receiptView = proddescHidden.value.substring(0,25);
                var rightText = proddescHidden.value.substring(25);
                proddesc.innerHTML = receiptView.fontcolor("0x009900") + rightText;
            }else if(proddescHidden.value.length == 0){
                proddesc.innerHTML = proddescHidden.value.fontcolor("black");
            }
            else{
                proddesc.innerHTML = proddescHidden.value.fontcolor("0x009900");
            }
        }
    }

    function setBrickVisible(isVisible){
        //toggleVisible( "imgAttrDiv", isVisible);
    }

    <c:if test= "${addNewCandidate.search}" >
    document.getElementById('subBrand').disabled = true;
    document.getElementById('brands').disabled = true;
    </c:if>

    function brandChange(evt){
        var brand = YAHOO.util.Dom.get("brandStrutsHiddenElm");
        showProgress();
        var msgSellingResReturn = validateBeforeSave();
        YAHOO.util.Dom.get("brandName").value=brand.value;
        if(msgSellingResReturn!=""){
            alert(msgSellingResReturn);
            hideProgress();
            enableButtonWhenValidate(false);
            return false;
        }
        AddCandidateTemp.updateCostOwner(brand.value,getDWRCallbackMethod(hideProCall));
    }

    function hideProCall(data){
        //Temporarily enable so that this info gets saved.
        //Disabled checkboxes dont get updated
        var foodStamp = YAHOO.util.Dom.get("foodStamp");
        var taxable = YAHOO.util.Dom.get("taxabilityFlag");
        taxable.disabled = false;
        foodStamp.disabled = false;
        saveDetailsOnBrandChange();
    }

    function initRenderPageBasedOnMerchType(){
        var merchType = YAHOO.util.Dom.get("merchTypes");
        AddCandidateTemp.getDisplayInfoForMerchType(merchType.value, getDWRCallbackMethod(merchTypeDisplayResult));
    }

    function renderPageBasedOnMerchType(){
        showProgress();
        var merchType = YAHOO.util.Dom.get("merchTypes");
        if (merchType && merchType.value == '9') {
            YAHOO.util.Dom.get("brandix").style.display = 'none';
        } else {
            YAHOO.util.Dom.get("brandix").style.display = 'block';
        }

        AddCandidateTemp.getDisplayInfoForMerchType(merchType.value, getDWRCallbackMethod(merchTypeDisplayResult));
    }

    function merchTypeDisplayResult(dispGroup){
        var allElms = getElementsByClassName("mtGroup");
        var visElms;

        if(dispGroup === 'none'){
            visElms = allElms;
            allElms = null;
        }
        else{
            visElms = getElementsByClassName(dispGroup);
        }
        var currVis;
        for(var i = 0 ; ((allElms != null) && (i < allElms.length)) ; i++){
            YAHOO.util.Dom.setStyle(allElms[i], 'visibility', 'hidden');
        }
        for(var i = 0 ; ((visElms != null) && (i < visElms.length)) ; i++){
            var parDiv = YAHOO.util.Dom. getAncestorByTagName(visElms[i], 'DIV');
            if(parDiv && parDiv.style){
                if(parDiv.style.visibility && (parDiv.style.visibility === 'hidden')){
                    //alert('parent hidden' + visElms[i].id);
                }
                else{
                    YAHOO.util.Dom.setStyle(visElms[i], 'visibility', 'visible');
                }
            }
        }
        hideProgress();
    }

    function isValidDom(el){
        if(null != el && el != undefined){
            return true;
        }
        return false;
    }

    function getElementsByClassName(clsName){
        var isIE  = YAHOO.env.ua.ie;
        //alert(isIE);
        if(isIE){
            return ieGetElementsByClassName(clsName);
        }
        else{
            return YAHOO.util.Dom.getElementsByClassName(clsName);
        }
    }

    function ieGetElementsByClassName(clsName){
        var elms = document.getElementsByTagName('input');
        var nodes = [];
        for(i=0; i< elms.length; i++){
            if(YAHOO.util.Dom.hasClass(elms[i], clsName)){
                nodes[nodes.length] = elms[i];
            }
        }

        elms = document.getElementsByTagName('select');
        for(i=0; i< elms.length; i++){
            if(YAHOO.util.Dom.hasClass(elms[i], clsName)){
                nodes[nodes.length] = elms[i];
            }
        }

        elms = document.getElementsByTagName('span');
        for(i=0; i< elms.length; i++){
            if(YAHOO.util.Dom.hasClass(elms[i], clsName)){
                nodes[nodes.length] = elms[i];
            }
        }
        return nodes;
    }

    <cps:renderByResourceAccess resourceId="173">
    <jsp:attribute name="EDIT">
    YAHOO.util.Event.onDOMReady(initRenderPageBasedOnMerchType);
    </jsp:attribute>
    </cps:renderByResourceAccess>

    var saveCandCallBack = {
        success: function(o){
            hideProgress();
        },
        failure: function(o) {
            hideProgress();
            alert('Failed Saving Product Details');
        }
    }

    function showWicDiv(data){
        if(data == "42"){
            YAHOO.util.Dom.get("wicDiv1").style.display = 'block';
            YAHOO.util.Dom.get("wicDiv1").style.position = 'relative';
            YAHOO.util.Dom.get("wicDiv2").style.display = 'block';
            YAHOO.util.Dom.get("wicDiv2").style.position = 'relative';
        }else{
            YAHOO.util.Dom.get("wicDiv1").style.display = 'none';
            YAHOO.util.Dom.get("wicDiv1").style.position = 'absolute';
            YAHOO.util.Dom.get("wicDiv2").style.display = 'none';
            YAHOO.util.Dom.get("wicDiv2").style.position = 'absolute';
        }
    }

    function setRetailNonSelable(suggRetail,suggforPrice,retail,retailFor,imageHelp1,imageHelp, retailRadio){
        var dataSellingRes = null;
        var callbacks = {
            success : function(o) {
                try {
                    if (o != null && o.responseText != "") {
                        if(myTrim(o.responseText) == "success"){

                            if(null != suggRetail && suggRetail != undefined){
                                suggRetail.value = "1";
                                suggRetail.disabled = true;
                            }
                            if(null != suggforPrice && suggforPrice != undefined){
                                suggforPrice.value = "0.00";
                                suggforPrice.disabled = true;
                            }
                            if(isValidDom(retailRadio) == true){
                                retailRadio.checked = true;
                                retailRadio.disabled = true;
                            }
                            if(null != retail && retail != undefined){
                                retail.value = '1';
                                retail.disabled = true;
                                if(YAHOO.util.Dom.hasClass("retail", "setColorGrey")){
                                    YAHOO.util.Dom.removeClass("retail", "setColorGrey");
                                }
                            }
                            if(null != retailFor && retailFor != undefined){
                                retailFor.value = '0.00';
                                retailFor.disabled = true;
                                if(YAHOO.util.Dom.hasClass("retailForprice", "setColorGrey")){
                                    YAHOO.util.Dom.removeClass("retailForprice", "setColorGrey");
                                }
                            }
                            if(null != imageHelp1 && imageHelp1 != undefined){
                                imageHelp1.style.display = "block";
                                imageHelp1.style.position = "relative";

                            }
                            if(null != imageHelp && imageHelp != undefined){
                                imageHelp.style.display = "block";
                                imageHelp.style.position = "absolute";
                            }
                        }
                    }
                    //hideTheProgress();
                } catch (e) {

                    //hideTheProgress();
                    return;
                }
            },
            failure : function() {
                //hideTheProgress();
            },
            timeout : 50000
        };
        YAHOO.util.Connect.asyncRequest('GET',
            "setRetailNonSelable", callbacks);
    }

    function setRetailValues(){
        var merchType = dwr.util.getValue("merchTypes");
        var prodType = dwr.util.getValue("prodTypeSelect");
        var retail = YAHOO.util.Dom.get("retail");
        var retailFor = YAHOO.util.Dom.get("retailForprice");
        var suggRetail = document.getElementById("suggRetail");
        var suggforPrice = document.getElementById("suggforPrice");
        var imageHelp = document.getElementById("imageHelp");
        var imageHelp1 = document.getElementById("imageHelp1");
        var priceRequired = document.getElementById("priceRequired");
        var retailRadio = document.getElementById("retailRadio");
        if(prodType == "SPLY" && merchType == "1"){
            if(YAHOO.util.Dom.get("retail") && YAHOO.util.Dom.get("retailForprice")){
                if((null == retail.value || "" == retail.value ) && (null == retailFor.value || "" == retailFor.value)){
                    YAHOO.util.Dom.get("retail").value = '1';
                    YAHOO.util.Dom.get("retailForprice").value = '0.02';
                    if(YAHOO.util.Dom.hasClass("retail", "setColorGrey")){
                        YAHOO.util.Dom.removeClass("retail", "setColorGrey")
                    }if(YAHOO.util.Dom.hasClass("retailForprice", "setColorGrey")){
                        YAHOO.util.Dom.removeClass("retailForprice", "setColorGrey")
                    }
                }
            }
        }else if(prodType == "SPLY"){
            setRetailNonSelable(suggRetail,suggforPrice,retail,retailFor,imageHelp1,imageHelp, retailRadio);
        }else{

            if(isValidDom(retailRadio) == true){
                retailRadio.disabled = false;
            }
            if(null != suggRetail && suggRetail != undefined){
                suggRetail.value = "";
                suggRetail.disabled = false;
            }
            if(null != suggforPrice && suggforPrice != undefined){
                suggforPrice.value = "";
                suggforPrice.disabled = false;
            }
            if(null != retail && retail != undefined){

                if(isValidDom(priceRequired) && priceRequired.checked == true){
                    retail.value = '1';
                    retail.disabled = false;
                }else{
                    retail.value = '';
                    retail.disabled = false;
                }
            }
            if(null != retailFor && retailFor != undefined){
                if(isValidDom(priceRequired) && priceRequired.checked == true){
                    retailFor.value = '0.00';
                    retailFor.disabled = false;
                }else{
                    retailFor.value = '';
                    retailFor.disabled = false;
                }
            }
            if(null != imageHelp1 && imageHelp1 != undefined){
                imageHelp1.style.display = "none";
                imageHelp1.style.position = "absolute";
            }
            if(null != imageHelp && imageHelp != undefined){
                imageHelp.style.display = "none";
                imageHelp.style.position = "absolute";
            }
            <c:if test='${addNewCandidate.productVO.psProdId == null || addNewCandidate.productVO.psProdId <= 0 }'>
            if(YAHOO.util.Dom.get("retail") && YAHOO.util.Dom.get("retailForprice")){
                if(isValidDom(priceRequired) && priceRequired.checked == true){
                    YAHOO.util.Dom.get("retail").value = '1';
                    YAHOO.util.Dom.get("retailForprice").value = '0.00';
                }else{
                    YAHOO.util.Dom.get("retail").value = '';
                    YAHOO.util.Dom.get("retailForprice").value = '';
                }
            }
            </c:if>
        }
    }

    function preventKeyCode(e){
        if(e.keyCode === 13){
            return false;
        }
    };

    function setColorDesc(e, ele){
        if(e.keyCode != 39 && e.keyCode != 37){
            var thisValue = ele.innerText;
            if(thisValue.length > 0 && thisValue.length < 26){
                ele.innerHTML = "<span style='color: #009900'>"+ thisValue+"</span>"
                setEndOfContenteditable(ele);
            }else if(thisValue.length > 0 && thisValue.length > 25){
                var firstValue = thisValue.substr(0,25);
                var lastValue = thisValue.substr(25);
                ele.innerHTML = "<span style='color: #009900'>"+ firstValue + "</span>" + lastValue;
                setEndOfContenteditable(ele);
            }else if(thisValue.length == 0 || thisValue == ""){
            }
        }
        document.getElementById("proddesc").value = ele.innerText;
    }

    function maxLength(e)
    {
        var proddescHidden = document.getElementById("proddescHidden");
        var proddescHiddenValue = proddescHidden.innerText;
        if(proddescHidden.innerText.length === 30 && e.keyCode != 8 && e.keyCode != 9){
            if(e.keyCode===46){
                e.returnValue = true;
            }else{
                e.returnValue = false;
            }
        }
        if(proddescHidden.innerText.length > 30 && e.keyCode != 8 && e.keyCode != 9){
            proddescHidden.innerText =  proddescHiddenValue.substring(0,30);
            e.returnValue = false;
        }
    }

    function maxLengthReturnValue(e){
        var proddescHidden = document.getElementById("proddescHidden");
        var proddescHiddenValue = proddescHidden.innerText;
        if(proddescHidden.innerText.length === 30 && e.keyCode != 8 && e.keyCode != 9){
            e.returnValue = false;
        }
        if(proddescHidden.innerText.length > 30 && e.keyCode != 8 && e.keyCode != 9){
            proddescHidden.innerText =  proddescHiddenValue.substring(0,30);
            e.returnValue = false;
        }
    }

    function parseValue(e){
        var proddescHidden = document.getElementById("proddescHidden");
        var proddescHiddenValue = proddescHidden.innerText;
        if(proddescHiddenValue.length > 30 && e.keyCode != 8 && e.keyCode != 9){
            proddescHidden.innerText =  proddescHiddenValue.substring(0,30);
        }
    }

    // check value of food stamp checkbox with food stamp default value to display sign
    function displayFoodStampSign(){
        var foodStamp = YAHOO.util.Dom.get("foodStamp");
        var foodStampDefault = YAHOO.util.Dom.get("foodStampDefault");

        if((foodStamp.checked && foodStampDefault.value == 'false') || (!foodStamp.checked && foodStampDefault.value == 'true')){
            document.getElementById('foodStampImageId').style.display = 'block';
        } else {
            document.getElementById('foodStampImageId').style.display = 'none';
        }
    }

</script>