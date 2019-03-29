<%@ tag import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%@attribute name="uniqueId" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="entyId" required="false" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="attrId" required="false" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="compName" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="textid" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="requireAttr" required="true" rtexprvalue="true" type="java.lang.Boolean"%>
<%@attribute name="containerVar" required="false" rtexprvalue="false"%>
<%@attribute name="selectedValueId" required="false" rtexprvalue="false"%>
<%@attribute name="selectedValueName" required="false"
	rtexprvalue="false"%>
<%@attribute name="width" required="false" rtexprvalue="false"%>
<%@attribute name="onchangeMethod" required="false" rtexprvalue="false"%>
<%@attribute name="index" required="false" rtexprvalue="false"%>
<%@attribute name="tabIndex" required="false" rtexprvalue="false"%>
<%@attribute name="valueDisplay" required="false" rtexprvalue="false"
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
				} else {
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
	<c:set var="valName" value="${compName}valName"></c:set>
</c:if>

<div id="${uniqueId}OuterDiv"
	style="z-index: ${index};min-width: 0;display: ${display}">


	<div id="${uniqueId}cont">
		<c:url value="${request.getContextPath()}/hebAssets/images/icons/iconPopup.png" var="image"/>

		<div id="${uniqueId}singleValue" style="width: 100%">
			<div
				style="float: left; width: 50%; word-wrap: break-word; padding-right: 5px;"
				align="right">${compName}
				<c:if test="${requireAttr == true}">
				<strong class="redAsterisk">*</strong>
				</c:if>
			</div>
			<div style="float: left;">
				<div style="float: left;">
					<input id="${textid}" type="text"  value="${valueDisplay}"
						style="width: 140px;"
						<c:if test="${tabIndex != null}">  tabindex="${tabIndex}"</c:if>
						<c:if test="${renderView == true}">  disabled</c:if> />
				</div>
				<div style="float: left;" tabindex="0">
					<img src="${image}" alt="" width="20" id="${uniqueId}Image"
						height="20" style="cursor: pointer;" />
				</div>
			</div>

		</div>

	</div>
	<input type="hidden" id="${valName}" />



	<div id="singlePanel${uniqueId}" style="display: none;"
		class="singlePanel">
		<div class="hd">
			<div class="tl"></div>
			<span id="popupHeaderSP"></span>
			<div class="closeMe" onclick="closeSinglePanel${uniqueId}();"></div>
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
						style="font-weight: bold; font-size: 13px; vertical-align: middle;">${compName}
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
						onclick="closeSinglePanel${uniqueId}();" style="cursor: pointer;"></input>
				</div>
			</div>
		</div>
		<div class="ft">
			<div class="bl"></div>
			<div class="br"></div>
		</div>
	</div>

	<script type="text/javascript">
	var dataCodeOfAttr${uniqueId} = null;
	var dataStr${uniqueId} = "";
	var dataStrOrg${uniqueId} = 0;
	YAHOO.util.Event.onDOMReady(function(){

    });
	function fillDataForTextInput${uniqueId}(arrAtt) {
		if(arrAtt != null && arrAtt.length > 0){
			var att = arrAtt[0];
			for ( var keyAtt in att) {
				if(keyAtt =="codeId") {
					dataStrOrg${uniqueId} = att[keyAtt];
				}else {
					if(att[keyAtt] != null){
						YAHOO.util.Dom.get('${textid}').value = att[keyAtt];
					}else{
						YAHOO.util.Dom.get('${textid}').value = '';
					}
					dataStr${uniqueId} = att[keyAtt];
				}
			}
		}
	}
	document.getElementById('${uniqueId}Image').onclick = function() {
		if(${renderView} == false){
			open${uniqueId}Popup();
		}
	};
	
	<c:url value="AddNewCandidate.do?tab=openSinglePopup" var="showPopupURL"></c:url>
	function callGetDataForPopup${uniqueId}(e) {
		showProgress();
		var callbacks = {
				success : function(o) {
					try {
						if (o != null && myTrim(o.responseText) != "") {
							dataCodeOfAttr${uniqueId} = YAHOO.lang.JSON.parse(o.responseText);
							fillDataAndShow${uniqueId}Popup();
							document.getElementById('errorMes${uniqueId}').innerHTML = '';
						}
					} catch (e) {
						fillDataAndShow${uniqueId}Popup();
						document.getElementById('errorMes${uniqueId}').innerHTML = 'Error connecting data.';
						return;
					}
				},
				failure : function() {
					fillDataAndShow${uniqueId}Popup();
					document.getElementById('errorMes${uniqueId}').innerHTML = 'Error connecting data.';
				},
				timeout : 10000
			};
			YAHOO.util.Connect.asyncRequest('GET',
					"${showPopupURL}&entyId=${entyId}&attrId=${attrId}", callbacks);
	}

	function open${uniqueId}Popup(){
		//get Data before show popup
		if(dataCodeOfAttr${uniqueId} != null){
			showProgress();
			fillDataAndShow${uniqueId}Popup();
		} else {
			callGetDataForPopup${uniqueId}();
		}


	}

	function fillDataAndShow${uniqueId}Popup() {
	HCD.Scrolling = new function() {
		var myColumnDefs = [
	                {key:"checkBox", label:"Select", width:50, className: 'align-center',formatter : "radio"},
	                {key:"attrName", label:"${compName}", width:250},
	                {key:"attrDesc", label:"${compName} Description", width:290},
	                {key:"attrCode", label:"", width:0,hidden :true}
	            ];

	        var myDataSource;
			if(dataCodeOfAttr${uniqueId}!= null && dataCodeOfAttr${uniqueId}[${attrId}] != null){
				myDataSource = new YAHOO.util.LocalDataSource(dataCodeOfAttr${uniqueId}[${attrId}]);
			} else {
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
// 	                    if (data[i].attrName.toLowerCase().indexOf(myTrim(req)) >=0) {
// 	                    	if(data[i].attrName.toLowerCase() == dataStrOrg${uniqueId}.toLowerCase()){
// 	                    		data[i].checkBox = true;
// 	                    	}
// 	                        filtered.push(data[i]);
// 	                    }
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
// 						if(data[i].attrName.toLowerCase() == dataStrOrg${uniqueId}.toLowerCase()){
// 	                    	data[i].checkBox = true;
// 	                    }
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
	        	YAHOO.util.Dom.get('${textid}').value = name;
	        	var elm1 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElm");
	        	if(elm1!=null){
	        		if(elm1.name.indexOf('${genericHiddenElmName}')<0){
	        			elm1.name="${genericHiddenElmName}."+elm1.name;
	        		}
	        		elm1.value = name;
	        	}
	        	var elm2 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElmCd");
	        	if(elm2!=null){
	        		if(elm2.name.indexOf('${genericHiddenElmName}')<0){
	        			elm2.name="${genericHiddenElmName}."+elm2.name;
	        		}
	        		elm2.value = oRecord.getData("attrCode");
	        	}

	        	dataStr${uniqueId} = name;
// 	        	dataStrOrg${uniqueId} = oRecord.getData("attrCode");
	        	closeSinglePanel${uniqueId}();
	       	});

	        HCD.updateFilter  = function () {
				myDataSource.sendRequest(YAHOO.util.Dom.get('${uniqueId}filterTxt').value ,{
					success : myDataTable.onDataReturnInitializeTable,
					failure : myDataTable.onDataReturnInitializeTable,
					scope   : myDataTable
				});
			}



		}

		YAHOO.util.Dom.get('${uniqueId}filterTxt').value = YAHOO.util.Dom.get('${textid}').value;

		if(YAHOO.util.Dom.get('${uniqueId}filterTxt').value != ''){
	    	beginFilter();
		}

		setTimeout(function(){showPopup${uniqueId}()},2000);
	}

	function showPopup${uniqueId}(){
		if(isPopUpOpen == false){
			document.getElementById("singlePanel${uniqueId}").style.display="block";
			HCD.popup = new YAHOO.widget.Panel("singlePanel${uniqueId}",
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
				});

			document.getElementById("popupHeaderSP").innerHTML = '<font size="2" color="white">${compName}</font>';

		}
		HCD.popup.render(document.body);
		HCD.popup.show();
		isPopUpOpen = true;
		hideTheProgress();
	}


	YAHOO.util.Event.on('${uniqueId}filterTxt','keyup',function (e) {
		if(e.keyCode == 13){
			beginFilter();
		}
	});


	function beginFilter(){
		HCD.updateFilter();
	}

	function clearFilter${uniqueId}(){
		YAHOO.util.Dom.get('${uniqueId}filterTxt').value = '';
		beginFilter();
	}

	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("${uniqueId}ImageSrch"), "click", search${uniqueId}Click);

	function search${uniqueId}Click(){
		beginFilter();
	}


	YAHOO.util.Event.on('${textid}','blur',function (e) {
		if(YAHOO.util.Dom.get('${textid}').value != ''){
			if(dataCodeOfAttr${uniqueId} != null && dataCodeOfAttr${uniqueId}[${attrId}] != null){
				var req =  YAHOO.util.Dom.get('${textid}').value;
				//begin filter
				var filtered = filterData${uniqueId}WhenFocusOut(req);
				setDataFor${uniqueId}Attribute(filtered);

			} else {
				//get data
				getDataPopUp${uniqueId}ForFilter();
			}
		} else {
			var elm1 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElm");
        	if(elm1!=null){
        		if(elm1.name.indexOf('${genericHiddenElmName}')<0){
        			elm1.name="${genericHiddenElmName}."+elm1.name;
        		}
        		elm1.value = "";
        	}
        	var elm2 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElmCd");
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
	        for (i = 0, l = dataCodeOfAttr${uniqueId}[${attrId}].length; i < l; ++i) {
	            if (dataCodeOfAttr${uniqueId}[${attrId}][i].attrName.toLowerCase().indexOf(myTrim(req)) >=0) {
	                filtered.push(dataCodeOfAttr${uniqueId}[${attrId}][i]);
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
							var req =  YAHOO.util.Dom.get('${textid}').value;
							var filtered = filterData${uniqueId}WhenFocusOut(req);
							setDataFor${uniqueId}Attribute(filtered);
						}

					} catch (e) {
						YAHOO.util.Dom.get('${textid}').value = dataStr${uniqueId};
						fillDataAndShow${uniqueId}Popup();
						document.getElementById('errorMes${uniqueId}').innerHTML = 'Error connecting data.';
						//hideTheProgress();
						return;
					}
				},
				failure : function() {
					YAHOO.util.Dom.get('${textid}').value = dataStr${uniqueId};
					fillDataAndShow${uniqueId}Popup();
					document.getElementById('errorMes${uniqueId}').innerHTML = 'Error connecting data.';
					//hideTheProgress();
				},
				timeout : 15000
			};
			YAHOO.util.Connect.asyncRequest('GET',
					"${showPopupURL}&entyId=${entyId}&attrId=${attrId}", callbacks);

	}

	function setDataFor${uniqueId}Attribute(filtered) {
		if(filtered.length != 1){
			open${uniqueId}Popup();
		 } else {
			 YAHOO.util.Dom.get('${textid}').value = filtered[0].attrName;
			 dataStr${uniqueId} = filtered[0].attrName;
			 var elm1 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElm");
	        if(elm1!=null){
	        	if(elm1.name.indexOf('${genericHiddenElmName}')<0){
	        		elm1.name="${genericHiddenElmName}."+elm1.name;
	        	}
	        	elm1.value = filtered[0].attrName;
	        }
	        var elm2 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElmCd");
        	if(elm2!=null){
        		if(elm2.name.indexOf('${genericHiddenElmName}')<0){
        			elm2.name="${genericHiddenElmName}."+elm2.name;
        		}
        		elm2.value = filtered[0].attrCode;
        	}
        	hideTheProgress();
		 }
	}

	function closeSinglePanel${uniqueId}() {
		closePopupSinglePanel${uniqueId}();
	}

	function closePopupSinglePanel${uniqueId}() {
		if(dataStr${uniqueId} == null){
			YAHOO.util.Dom.get('${textid}').value ='';
		}else {
			YAHOO.util.Dom.get('${textid}').value = dataStr${uniqueId};
		}
		document.getElementById("singlePanel${uniqueId}").style.display="none";
		HCD.popup.hide();
		isPopUpOpen = false;
	}

	<c:if test="${clearMethod != null}">
	var ${clearMethod} = function() {
		YAHOO.util.Dom.get('${textid}').value = '';
	};
	</c:if>

	function myTrim(x) {
		return x.replace(/^\s+|\s+$/gm,'');
	}
	</script>


</div>
