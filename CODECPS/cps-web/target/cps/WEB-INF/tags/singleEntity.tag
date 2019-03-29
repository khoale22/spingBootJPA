<%@ tag import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%@attribute name="uniqueId" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="attr1Label" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="attr2Label" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="entyId" required="false" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="textid1" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="textid2" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="attrId1" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="attrId2" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="requireAttr1" required="true" rtexprvalue="true" type="java.lang.Boolean"%>
<%@attribute name="requireAttr2" required="true" rtexprvalue="true" type="java.lang.Boolean"%>
<%@attribute name="containerVar" required="false" rtexprvalue="false"%>
<%@attribute name="selectedValueId" required="false" rtexprvalue="false"%>
<%@attribute name="selectedValueName" required="false"
	rtexprvalue="false"%>
<%@attribute name="width" required="false" rtexprvalue="false"%>
<%@attribute name="onchangeMethod" required="false" rtexprvalue="false"%>
<%@attribute name="index" required="false" rtexprvalue="false"%>
<%@attribute name="tabIndex1" required="false" rtexprvalue="false"%>
<%@attribute name="tabIndex2" required="false" rtexprvalue="false"%>
<%@attribute name="valueDisplay1" required="false" rtexprvalue="true"
	description=""%>
<%@attribute name="valueDisplay2" required="false" rtexprvalue="true"
	description=""%>
<%@attribute name="display" required="false" rtexprvalue="false"%>
<%@attribute name="viewMode" required="false" rtexprvalue="true" type="java.lang.Boolean"%>
<%@attribute name="clearMethod" required="false" rtexprvalue="true"%>
<%@attribute  name="genericHiddenElmName" required="false" rtexprvalue="false" %>
<%@attribute  name="resourceId" required="false" rtexprvalue="false" %>
<%@ tag import="com.heb.jaf.security.UserInfo" %>
<%@ tag import="com.heb.jaf.vo.Resource" %>

<%
	boolean renderView = false;
	
// 	Map<Integer, String> m  = (Map<Integer, String>)jspContext.findAttribute("com.heb.ResourceMap");
	org.springframework.security.core.Authentication auth = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication(); 
	UserInfo hebUserDetails = (UserInfo)auth.getPrincipal();

	Map<Integer, String> m = hebUserDetails.getResourceMap();
	if(m != null){
		if(resourceId != null && resourceId != ""){
			String acs = m.get(Integer.parseInt(resourceId));
			if(acs != null){
				if("ED".equals(acs)){
					renderView = false;
				}
				else if("V".equals(acs)){
					renderView = true;
				}else {
				    renderView = true;
				}
			}
			else{
				renderView = true;
			}
		} else {
			renderView = true;
		}
	}
	else{
		renderView = true;
	}
	
	
	//check for 'view mode'
	if(!renderView && viewMode){
		renderView = true;
	}	
	jspContext.setAttribute("renderView", renderView);

%>


<c:set var="valName" value="${selectedValueName}"></c:set>
<c:if test="${selectedValueName == null}">
	<c:set var="valName" value="${attr1Label}valName"></c:set>
</c:if>

<div id="${uniqueId}OuterDiv"
	style="position : relative;z-index: ${index};min-width: 0;display: ${display}">


	<div id="${uniqueId}cont" style="postion: relative; min-width: 0;">
		<c:url value="${request.getContextPath()}/hebAssets/images/icons/iconPopup.png" var="image"></c:url>
		<div id="${uniqueId}singleEntity">
			<div
				style="float: left; width: 50%; word-wrap: break-word; padding-right: 5px;"
				align="right">${attr1Label}
				<c:if test="${requireAttr1 == true}">
				<strong class="redAsterisk">*</strong>
				</c:if>
				</div>
			<div style="float: left; width: 40px;">
				<input id="${textid1}" type="text" value="${valueDisplay1}"
					style="width: 35px;"
					<c:if test="${tabIndex1 != null}">  tabindex="${tabIndex1}"</c:if> 
					<c:if test="${renderView == true}">  disabled </c:if>
					onkeypress="return isNumberKey${uniqueId}(event);" onblur="validateNumber${uniqueId}();"/>
			</div>
			<div style="float: left;">
			<div  
					style="float: left; width: 57px; overflow: hidden;display: inline-block; text-overflow: ellipsis;
				line-height: 1.5em;  height: 3em;padding-right: 2px;" title="${attr2Label}" 
				align="right">${attr2Label}
				</div>
				<c:if test="${requireAttr2}">
				<strong class="redAsterisk">*</strong>
				</c:if>
				</div>
			<div style="float: left;">
				<div style="float: left;">
					<input id="${textid2}" type="text" value="${valueDisplay2}"
						style="width: 35px;"
						<c:if test="${tabIndex2 != null}">  tabindex="${tabIndex2}"</c:if> 
						<c:if test="${renderView == true}">  disabled</c:if>/>
				</div>
				<div style="float: left;" tabindex="0">
					<img src="${image}" alt="" width="20" id="${uniqueId}Image"
						height="20" style="cursor: pointer;" />
				</div>
			</div>
		</div>

	</div>
	<input type="hidden" id="${valName}" />



	<div id="singleEtPanel${uniqueId}" style="display: none;"
		class="singlePanel">
		<div class="hd">
			<div class="tl"></div>
			<span id="popupHeaderSEP"></span>
			<div class="closeMe" onclick="closeSingleEtPanel${uniqueId}();"></div>
			<div class="tr"></div>
		</div>
		<div class="bd">
			<div>
				<div style="width: 100%; padding-left:10px;">
					<label style="color: red;" id="errorMes${uniqueId}"></label>
				</div>
				<div style="width: 40%; vertical-align: middle; float: left;"
					align="right">
					<label
						style="font-weight: bold; font-size: 13px; vertical-align: middle;">${attr2Label}
					</label>
				</div>
				<div style="width: 3%; vertical-align: middle; float: left;">
				</div>
				<div style="width: 55%; vertical-align: middle; float: left;">
					<input id="${uniqueId}filterTxt" type="text" name="attrName"
						value="">
					<c:url value="${request.getContextPath()}/hebAssets/images/icons/IMG_searchIcon.gif" var="imageSrch"></c:url>	
					<img src="${imageSrch}" alt="" width="20" id="${uniqueId}ImageSrch"
						height="20" style="cursor: pointer;" />
					<c:url value="${request.getContextPath()}/hebAssets/images/delete.png" var="image"></c:url>
					<img src="${image}" alt="" width="20"
						onclick="clearFilter${uniqueId}()" id="${uniqueId}clearImage"
						height="20" style="cursor: pointer;" />
				</div>
				<br /> <br /> <br />
				<div style="width: 100%">
					<label style="font-style: italic; font-size: 11px;">*
						Select only one value from below </label>
				</div>

				<div style="width: 100%; height: 250px;">
					<div id="yahoo-com" class="yui-skin-sam">
						<div id="${uniqueId}tbl"></div>
					</div>
				</div>

				<br />
				<div style="width: 100%; vertical-align: middle; float: left;"
					align="right">
					<input type="button" id="${uniqueId}btnClose" value="Close"
						onclick="closeSingleEtPanel${uniqueId}();" style="cursor: pointer;"></input>
				</div>
			</div>
		</div>
		<div class="ft">
			<div class="bl"></div>
			<div class="br"></div>
		</div>
	</div>
	<div style= "position: absolute; visibility: hidden;  height: auto;  width: auto;" id="testWidth"> </div>
	<script type="text/javascript">
	var dataCodeOfAttr${uniqueId} = null;
	var dataStr${uniqueId} = "";
	var dataStrOrg${uniqueId} = 0;
// 	function txtToolTip(txtname,ccount){
// 		var txtTool=document.getElementById(txtname);
// 		if(txtTool.value.length>ccount)
// 		{
// 			txtTool.title=txtTool.value;
// 		}
// 	}
	function fillDataForTable${uniqueId}(arrAtt,key) {
		if(arrAtt != null){
			for ( var keyAtt in arrAtt) {
				var att = arrAtt[keyAtt];
				if(att != null && att.length > 0){
					var objDta = att[0];
					for ( var keyAttValue in objDta) {
						if(keyAttValue =="codeId"){
							if((key+"xxx"+keyAtt)=="${textid2}"){
								dataStrOrg${uniqueId} = objDta[keyAttValue];
							}
						}else{
							YAHOO.util.Dom.get(key+"xxx"+keyAtt).value = objDta[keyAttValue];
						}
					}
				}
			}
			dataStr${uniqueId} = YAHOO.util.Dom.get('${textid2}').value;
// 			dataStrOrg${uniqueId} = YAHOO.util.Dom.get('${textid2}').value;
		}
	}
	
	function isNumberKey${uniqueId}(evt){
	    var charCode = (evt.which) ? evt.which : event.keyCode;
	    return !(charCode > 31 && (charCode < 48 || charCode > 57));
	}
	
	function validateNumber${uniqueId}() {
		var req =  YAHOO.util.Dom.get('${textid1}').value;
		var numbers = /\d/;
		if(isNaN(req) && numbers.test(req) || (req.indexOf('.') > -1 || req.indexOf('-') > -1)){
			YAHOO.util.Dom.get('${textid1}').value = '';
		}
	}
	
	
	document.getElementById('${uniqueId}Image').onclick = function() {
		if(${renderView} == false){
			open${uniqueId}Popup();
		}
	};
	
	
	<c:url value="AddNewCandidate.do?tab=openSinglePopup" var="showPopupURL"></c:url>
	function callGetDataForPopup${uniqueId}(e) {
		var callbacks = {
				success : function(o) {
					try {
						if (o != null && myTrim(o.responseText) != "") {
							dataCodeOfAttr${uniqueId} = YAHOO.lang.JSON.parse(o.responseText);
							fillDataAndShow${uniqueId}EtPopup();
							document.getElementById('errorMes${uniqueId}').innerHTML = '';
						}
					} catch (e) {
						fillDataAndShow${uniqueId}EtPopup();
						document.getElementById('errorMes${uniqueId}').innerHTML = 'Error connecting data.';
						return;
					}
				},
				failure : function() {
					fillDataAndShow${uniqueId}EtPopup();
					document.getElementById('errorMes${uniqueId}').innerHTML = 'Error connecting data.';
				},
				timeout : 10000
			};
			YAHOO.util.Connect.asyncRequest('GET',
					"${showPopupURL}&entyId=${entyId}&attrId=${attrId2}", callbacks);
			showProgress();
	}
	function open${uniqueId}Popup(){
		//get Data before show popup
		if(dataCodeOfAttr${uniqueId} != null){
			fillDataAndShow${uniqueId}EtPopup();
			showProgress();
		} else {
			callGetDataForPopup${uniqueId}();
		}
	}
	
	
	function fillDataAndShow${uniqueId}EtPopup() {
		
		HCD.Scrolling = new function() {
			document.getElementById("testWidth").innerHTML = "${attr2Label}";
			var widthAttr2Label = document.getElementById("testWidth").clientWidth;
			if(widthAttr2Label < 250){
				widthAttr2Label = 250;
			}
			var widthAttrDesc = widthAttr2Label + 70;
			var myColumnDefs = [
		                {key:"checkBox", label:"Select", width:50, className: 'align-center',formatter : "radio"},
		                {key:"attrName", label:"${attr2Label}",width:widthAttr2Label},
		                {key:"attrDesc", label:"${attr2Label} Description",width:widthAttrDesc},
		                {key:"attrCode", label:"", width:0,hidden :true}
		            ];

		        var myDataSource;
		        var checkHasData = false;
		        var str = "                                                                                                                                          ";
				if(dataCodeOfAttr${uniqueId}!= null && dataCodeOfAttr${uniqueId}[${attrId2}] != null){
					myDataSource = new YAHOO.util.LocalDataSource(dataCodeOfAttr${uniqueId}[${attrId2}]);
					checkHasData = true;
				} else {
					checkHasData = false;
					myDataSource = new YAHOO.util.LocalDataSource(null);
				}
				
				var sortFunction = function(field){
		        	return function (a,b){
		        		if ( a.checkBox == true && b.checkBox == true ) {
		        			if(a[field].toLowerCase() < b[field].toLowerCase()){
		        				return -1;
		        			}
		        			if(a[field].toLowerCase() > b[field].toLowerCase()){
		        				return 1;
		        			}
		        			return 0;
		        		}
		        		
		        		if ( a.checkBox == true && b.checkBox == false )
		        		    return -1;
	        		    if ( a.checkBox == false && b.checkBox == true )
	        		        return 1;
	        		    if(a[field].toLowerCase() < b[field].toLowerCase()){
	        				return -1;
	        			}
	        			if(a[field].toLowerCase() > b[field].toLowerCase()){
	        				return 1;
	        			}
	        		    return 0;
		        	}
		        }
				
				myDataSource.doBeforeCallback = function (req,raw,res,cb) {
		            
		            var data     = res.results || [],
		                filtered = [],
		                i,l;
		            
		            if (req) {
		                req = req.toLowerCase();
		                for (i = 0, l = data.length; i < l; ++i) {
							data[i].checkBox = false;
		                    if (data[i].attrName.toLowerCase().indexOf(myTrim(req)) >=0) {
		                    	if(data[i].attrCode == dataStrOrg${uniqueId}){
		                    		data[i].checkBox = true;
		                    	}
		                        filtered.push(data[i]);
		                    }
		                }
		                res.results = filtered;
		            } else {
						for (i = 0, l = data.length; i < l; ++i) {
							if(data[i].attrCode == dataStrOrg${uniqueId}){
		                    	data[i].checkBox = true;
		                    }
						}
					}
		            
		            if(res.results != null && res.results.length > 0){
		            	res.results.sort(sortFunction('attrName'));
		            }

		            return res;
		        };

		        var myDataTable = new YAHOO.widget.ScrollingDataTable("${uniqueId}tbl", myColumnDefs, myDataSource, {width:"650px",height:"15em"});
		        if(!checkHasData){
		        	myDataTable.showTableMessage(str);
		        }
		        var lastSelectedRadioRecord = null;
		        myDataTable.subscribe("radioClickEvent", function(oArgs){ 
			        if(lastSelectedRadioRecord != null) { 
			        	lastSelectedRadioRecord.setData("checkBox",false); 
			        } 
		        	var elRadio = oArgs.target; 
		        	var oRecord = this.getRecord(elRadio); 
		        	oRecord.setData("checkBox",true); 
		        	lastSelectedRadioRecord = oRecord; 
		        	var name = oRecord.getData("attrName"); 
		        	YAHOO.util.Dom.get('${textid2}').value = name;
		        	var elm1 = YAHOO.util.Dom.get("${textid2}StrutsHiddenElm"); 
		        	if(elm1!=null){	        		
		        		if(elm1.name.indexOf('${genericHiddenElmName}')<0){
		        			elm1.name="${genericHiddenElmName}."+elm1.name;
		        		}	        		
		        		elm1.value = name;		        		
		        	}
		        	var elm2 = YAHOO.util.Dom.get("${textid2}StrutsHiddenElmCd"); 
		        	if(elm2!=null){	        		
		        		if(elm2.name.indexOf('${genericHiddenElmName}')<0){
		        			elm2.name="${genericHiddenElmName}."+elm2.name;
		        		}	        		
		        		elm2.value = oRecord.getData("attrCode");         		
		        	}	
		        	dataStr${uniqueId} = name;
// 		        	dataStrOrg${uniqueId} = oRecord.getData("attrCode");
		        	closeSingleEtPanel${uniqueId}();
		       	}); 
		        HCD.filterTimeout = null; 
				
		        HCD.updateFilter  = function () {
					myDataSource.sendRequest(YAHOO.util.Dom.get('${uniqueId}filterTxt').value ,{
						success : myDataTable.onDataReturnInitializeTable,
						failure : myDataTable.onDataReturnInitializeTable,
						scope   : myDataTable
					});
				}
			
		}
		
		YAHOO.util.Dom.get('${uniqueId}filterTxt').value = YAHOO.util.Dom.get('${textid2}').value;
		
		if(YAHOO.util.Dom.get('${uniqueId}filterTxt').value != ''){
        	beginFilter();
		}

		setTimeout(function(){showPopup${uniqueId}()},2000);
	}
	
	function showPopup${uniqueId}(){
		if(isPopUpOpen == false){
			document.getElementById("singleEtPanel${uniqueId}").style.display="block";
		
			HCD.popup = new YAHOO.widget.Panel("singleEtPanel${uniqueId}", 
			{ 	width:"700px", 
				height:"500px", 
				underlay:"shadow",
				visible:false,
				constraintoviewport:true,
				draggable:false,
				zIndex : 15000,
				modal:true,
				close:false,
				fixedCenter : true
			} );
			
			document.getElementById("popupHeaderSEP").innerHTML = '<font size="2" color="white">${attr2Label}</font>';
			
		}
		
		HCD.popup.render(document.body);
		HCD.popup.show();
		hideTheProgress();
		isPopUpOpen = true;
	}
	
	YAHOO.util.Event.on('${uniqueId}filterTxt','keyup',function (e) { 
		if(e.keyCode == 13){
			beginFilter();
		}
	});
	
	function beginFilter(){
		clearTimeout(HCD.filterTimeout); 
		setTimeout(HCD.updateFilter,600); 
	}

	function clearFilter${uniqueId}(){
		YAHOO.util.Dom.get('${uniqueId}filterTxt').value = '';
		beginFilter();
	}
	
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("${uniqueId}ImageSrch"), "click", search${uniqueId}Click);
	
	function search${uniqueId}Click(){
		beginFilter();
	}

	YAHOO.util.Event.on('${textid2}','blur',function (e) { 
		
		if(YAHOO.util.Dom.get('${textid2}').value != ''){
			
			if(dataCodeOfAttr${uniqueId} != null  && dataCodeOfAttr${uniqueId}[${attrId2}] != null){
				var req =  YAHOO.util.Dom.get('${textid2}').value;
				//begin filter
				var filtered = filterData${uniqueId}WhenFocusOut(req);
				setDataFor${uniqueId}Attribute(filtered);
				 
			} else {
				//get data
				getDataPopUp${uniqueId}ForFilter();
			}
		} else {
			var elm1 = YAHOO.util.Dom.get("${textid2}StrutsHiddenElm"); 
        	if(elm1!=null){	        		
        		if(elm1.name.indexOf('${genericHiddenElmName}')<0){
        			elm1.name="${genericHiddenElmName}."+elm1.name;
        		}	        		
        		elm1.value = "";		        		
        	}
        	var elm2 = YAHOO.util.Dom.get("${textid2}StrutsHiddenElmCd"); 
        	if(elm2!=null){	        		
        		if(elm2.name.indexOf('${genericHiddenElmName}')<0){
        			elm2.name="${genericHiddenElmName}."+elm2.name;
        		}	        		
        		elm2.value = "";         		
        	}	
		}
	});
	
	
	function filterData${uniqueId}WhenFocusOut(req){
		var results = [],
        filtered = [],
        i,l;
		
	    if (req) {
	        req = req.toLowerCase();
	        for (i = 0, l = dataCodeOfAttr${uniqueId}[${attrId2}].length; i < l; ++i) {
	            if (dataCodeOfAttr${uniqueId}[${attrId2}][i].attrName.toLowerCase().indexOf(myTrim(req)) >=0) {
	                filtered.push(dataCodeOfAttr${uniqueId}[${attrId2}][i]);
	            }
	        }
	        results = filtered;
	    }

    	return results;
	}
	
	function getDataPopUp${uniqueId}ForFilter(){
		showProgress();
		var callbacks = {
				success : function(o) {
					try {
						if (o != null && myTrim(o.responseText) != "") {
							dataCodeOfAttr${uniqueId} = YAHOO.lang.JSON.parse(o.responseText);
							var req =  YAHOO.util.Dom.get('${textid2}').value;
							var filtered = filterData${uniqueId}WhenFocusOut(req);
							setDataFor${uniqueId}Attribute(filtered);
						}
					} catch (e) {
						YAHOO.util.Dom.get('${textid2}').value = dataStr${uniqueId};
						fillDataAndShow${uniqueId}EtPopup();
						document.getElementById('errorMes${uniqueId}').innerHTML = 'Error connecting data.';
						//hideTheProgress();
						return;
					}
				},
				failure : function() {
					YAHOO.util.Dom.get('${textid2}').value = dataStr${uniqueId};
					fillDataAndShow${uniqueId}EtPopup();
					document.getElementById('errorMes${uniqueId}').innerHTML = 'Error connecting data.';
					//hideTheProgress();
				},
				timeout : 5000
			};
		YAHOO.util.Connect.asyncRequest('GET',
				"${showPopupURL}&entyId=${entyId}&attrId=${attrId2}", callbacks);
		
	}
	
	function setDataFor${uniqueId}Attribute(filtered) {
		if(filtered.length != 1){
			open${uniqueId}Popup();
		 } else {
			 YAHOO.util.Dom.get('${textid2}').value = filtered[0].attrName;
			 dataStr${uniqueId} = filtered[0].attrName;
			 var elm1 = YAHOO.util.Dom.get("${textid2}StrutsHiddenElm"); 
	        	if(elm1!=null){	        		
	        		if(elm1.name.indexOf('${genericHiddenElmName}')<0){
	        			elm1.name="${genericHiddenElmName}."+elm1.name;
	        		}	        		
	        		elm1.value =filtered[0].attrName;		        		
	        	}
	        	var elm2 = YAHOO.util.Dom.get("${textid2}StrutsHiddenElmCd"); 
	        	if(elm2!=null){	        		
	        		if(elm2.name.indexOf('${genericHiddenElmName}')<0){
	        			elm2.name="${genericHiddenElmName}."+elm2.name;
	        		}	        		
	        		elm2.value = filtered[0].attrCode;         		
	        	}
	        hideTheProgress();	
		 }
	}
	
	
	function closeSingleEtPanel${uniqueId}() {
		closeSingleEtPanelPopup${uniqueId}();
	}

	function closeSingleEtPanelPopup${uniqueId}() {
		YAHOO.util.Dom.get('${textid2}').value = dataStr${uniqueId};
		document.getElementById("singleEtPanel${uniqueId}").style.display="none";
		HCD.popup.hide();
		isPopUpOpen = false;
	}
	YAHOO.util.Event.on('${textid1}','keyup',function (e) { 
		var req =  YAHOO.util.Dom.get('${textid1}').value;
		var elm1 = YAHOO.util.Dom.get("${textid1}StrutsHiddenElm"); 
    	if(elm1!=null){	        		
    		if(elm1.name.indexOf('${genericHiddenElmName}')<0){
    			elm1.name="${genericHiddenElmName}."+elm1.name;
    		}	        		
    		elm1.value = req;	    		
    	}    	

	});
	<c:if test="${clearMethod != null}">
	var ${clearMethod} = function() {
		YAHOO.util.Dom.get('${textid1}').value = '';
		YAHOO.util.Dom.get('${textid2}').value = '';
	};
	</c:if>
		
	function myTrim(x) {
		return x.replace(/^\s+|\s+$/gm,'');
	}
	</script>


</div>


