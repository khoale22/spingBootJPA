<%@ tag import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%@attribute name="uniqueId" required="true" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="entyId" required="false" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="attrId" required="false" rtexprvalue="true"
	type="java.lang.String"%>
<%@attribute name="attrLabel" required="true" rtexprvalue="true"
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
<%@attribute name="valueDisplay" required="false" rtexprvalue="true"
	description=""%>
<%@attribute name="display" required="false" rtexprvalue="false"%>
<%@attribute name="viewMode" required="false" rtexprvalue="true" type="java.lang.Boolean"%>
<%@attribute name="clearMethod" required="false" rtexprvalue="true"%>
<%@attribute  name="genericHiddenElmName" required="false" rtexprvalue="false" type="java.lang.String"%>
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
	<c:set var="valName" value="${attrLabel}valName"></c:set>
</c:if>
<div id="${uniqueId}OuterDiv"
	style="position : relative;z-index: ${index};min-width: 0;display: ${display}">
	<c:url value="${request.getContextPath()}/hebAssets/images/icons/iconPopup.png" var="image"/>
	<div id="${uniqueId}multiValue">
		<div style="float: left; width: 50%; word-wrap: break-word;  padding-right: 5px;" align="right">
			${attrLabel}
			<c:if test="${requireAttr == true}">
				<strong class="redAsterisk">*</strong>
			</c:if>
		</div>
		<div style="float: left;">
			<div style="float: left;">
				<input id="${textid}" type="text" value="${valueDisplay}" style="width: 140px;"
					<c:if test="${tabIndex != null}">  tabindex="${tabIndex}"</c:if> 
					<c:if test="${renderView == true}">  disabled</c:if>/>
			</div>
			<div style="float: left;" tabindex="0">
				<img src="${image}" alt="" width="20" id="${uniqueId}Image"
					height="20" style="cursor: pointer;"/>
			</div>
		</div>
	</div>
	<input type="hidden" id="${valName}" />



	<div id="multiPanel${uniqueId}" style="display: none;" class="singlePanel">
		<div class="hd">
			<div class="tl"></div>
			<span id="popupHeaderMP"></span>
			<div class="closeMe" onclick="closeMultiPanel${uniqueId}();"></div>
			<div class="tr"></div>
		</div>
		<div class="bd">
			<div>
				<div style="width: 100%; padding-left:10px;">
					<label style="color: red;" id="errorMes${uniqueId}"></label>
				</div>
				<div style="width: 40%; vertical-align: middle; float: left;" align="right" >
					<label style="font-weight: bold; font-size: 13px; vertical-align: middle;">${attrLabel} </label>
				</div>
				<div style="width: 3%; vertical-align: middle; float: left;">
				</div>
				<div style="width: 55%; vertical-align: middle; float: left;">
					<input id="${uniqueId}filterTxt" type="text" name="attrName" value="">
					<c:url value="${request.getContextPath()}/hebAssets/images/icons/IMG_searchIcon.gif" var="imageSrch"></c:url>	
					<img src="${imageSrch}" alt="" width="20" id="${uniqueId}ImageSrch"
						height="20" style="cursor: pointer;" />
					<c:url value="${request.getContextPath()}/hebAssets/images/delete.png" var="image"></c:url>
					<img src="${image}" alt="" width="20" onclick="clearFilter${uniqueId}()"
									id="${uniqueId}clearImage" height="20" style="cursor: pointer;"/>
				</div>
				<br/>
				<br/>
				<br/>
				<div style="width: 100%">
					<label style="font-style:italic; font-size: 11px;">* Select one or more values from below </label>
				</div>
				
				<div style="width: 100%; height: 280px;">
					<div id="yahoo-com" class="yui-skin-sam">
						<div id="${uniqueId}tbl"></div>
					</div> 
				</div> 
			
				<br/>
				<div style="width: 100%; vertical-align: middle; float: left;" align="right" >
					<input type="button" id="${uniqueId}btnOK" value="OK" style="cursor: pointer;"></input>
					<input type="button" id="${uniqueId}btnClose" value="Close" onclick="closeMultiPanel${uniqueId}();" style="cursor: pointer;"></input>
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
	var dataCode${uniqueId} = "";
	var dataStrOrg${uniqueId} = "";
	var myDataTable${uniqueId};
	
	function fillDataForTextInput${uniqueId}(arrAtt) {
		if(arrAtt != null && arrAtt.length > 0){
			var str = "";
			var strOrg = "";
			for ( var i = 0; i < arrAtt.length; i++) {
				var att = arrAtt[i];
				for ( var keyAtt in att) {
					if(keyAtt == "codeId"){
						strOrg += att[keyAtt]+";";
					}else {
						str += att[keyAtt]+"; ";
					}
				}
			}
			if(str.length > 0){
				str = str.substring(0, str.length-2); 
			}
			if(strOrg.length > 0){
				strOrg = strOrg.substring(0, strOrg.length-1); 
			}
			dataStr${uniqueId} = str;
			dataStrOrg${uniqueId} = strOrg;
			YAHOO.util.Dom.get('${textid}').value = str;
		}
	}
	document.getElementById('${uniqueId}Image').onclick = function() {
		if(${renderView} == false){
			open${uniqueId}Popup();
		}
	};
	<c:url value="AddNewCandidate.do?tab=openSinglePopup" var="showMultiPopupURL"></c:url>
	function callGetDataForPopup${uniqueId}(e) {
		showProgress();
		var callbacks = {
				success : function(o) {
					try {
						if (o != null && myTrim(o.responseText) != "") {
							dataCodeOfAttr${uniqueId} = YAHOO.lang.JSON.parse(o.responseText);
							fillDataAndShow${uniqueId}MultiPopup();
							document.getElementById('errorMes${uniqueId}').innerHTML = '';
						}
					} catch (e) {
						fillDataAndShow${uniqueId}MultiPopup();
						document.getElementById('errorMes${uniqueId}').innerHTML = 'Error connecting data.';
						return;
					}
				},
				failure : function() {
					fillDataAndShow${uniqueId}MultiPopup();
					document.getElementById('errorMes${uniqueId}').innerHTML = 'Error connecting data.';
				},
				timeout : 10000
			};
			YAHOO.util.Connect.asyncRequest('GET',
					"${showMultiPopupURL}&entyId=${entyId}&attrId=${attrId}", callbacks);
	}
	
	function open${uniqueId}Popup(){
		//get Data before show popup
		if(dataCodeOfAttr${uniqueId} != null){
			showProgress();
			fillDataAndShow${uniqueId}MultiPopup();
		} else {
			callGetDataForPopup${uniqueId}();
		}
	}
	
	function fillDataAndShow${uniqueId}MultiPopup() {
		
		HCD.Scrolling = new function() {
			
		var myColumnDefs = [
	                {key:"checkBox", label:"Select", width:50, className: 'align-center',formatter : "checkbox"},
	                {key:"attrName", label:"${attrLabel}", width:250},
	                {key:"attrDesc", label:"${attrLabel} Description", width:290},
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
	                i,l,
					j,k;

	            if (req) {
	                req = req.toLowerCase();
					var arrReq = req.split(";");
	                for (i = 0, l = data.length; i < l; ++i) {
	                	data[i].checkBox = false;
						for (j = 0, k = arrReq.length; j < k; j++) {
							if (data[i].attrName.toLowerCase().indexOf(myTrim(arrReq[j])) >=0 && myTrim(arrReq[j]) != '') {
								if(isConstain${uniqueId}Str(data[i].attrCode, dataStrOrg${uniqueId})){
		                    		data[i].checkBox = true;
		                    	}
								filtered.push(data[i]);
								break;
							}
						}
	                }
	                res.results = filtered;
	            } else {
	            	for (i = 0, l = data.length; i < l; ++i) {
						if(isConstain${uniqueId}Str(data[i].attrCode, dataStrOrg${uniqueId})){
                    		data[i].checkBox = true;
                    	}
	                }
	            }
	            
	            if(res.results != null && res.results.length > 0){
	            	res.results.sort(sortFunction('attrName'));
	            }

	            return res;
	        };

	        myDataTable${uniqueId} = new YAHOO.widget.ScrollingDataTable("${uniqueId}tbl", myColumnDefs, myDataSource, {width:"650px",height:"15em"});
	        myDataTable${uniqueId}.subscribe("checkboxClickEvent", function (oArgs) {
		        var elCheckbox = oArgs.target;
		        var oRecord = this.getRecord(elCheckbox);
		        var column = this.getColumn(elCheckbox);
				oRecord.setData(column.key,elCheckbox.checked);
		    });
	        HCD.filterTimeout = null; 
			
	        HCD.updateFilter  = function () {
				myDataSource.sendRequest(YAHOO.util.Dom.get('${uniqueId}filterTxt').value ,{
					success : myDataTable${uniqueId}.onDataReturnInitializeTable,
					failure : myDataTable${uniqueId}.onDataReturnInitializeTable,
					scope   : myDataTable${uniqueId}
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

			document.getElementById("multiPanel${uniqueId}").style.display="block";
			
			HCD.popup = new YAHOO.widget.Panel("multiPanel${uniqueId}", 
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
				
			document.getElementById("popupHeaderMP").innerHTML = '<font size="2" color="white">${attrLabel}</font>';
			
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
	
	
	YAHOO.util.Event.on('${uniqueId}btnOK','click',  function(evt){
		dataStr${uniqueId} = ""; 
		dataCode${uniqueId}="";
		for (var i= 0; i< myDataTable${uniqueId}.getRecordSet().getLength();i++){
			var oRec = myDataTable${uniqueId}.getRecordSet().getRecord(i);
			if(oRec.getData("checkBox")) {
				dataStr${uniqueId} += oRec.getData("attrName") + "; ";
				dataCode${uniqueId}+= oRec.getData("attrCode") + ";";
			}
		}
		if(dataStr${uniqueId} != null && dataStr${uniqueId}.length > 0){
			dataStr${uniqueId} = dataStr${uniqueId}.substring(0,dataStr${uniqueId}.length - 2);
		}
		if(dataCode${uniqueId} != null && dataCode${uniqueId}.length > 0){
			dataCode${uniqueId} = dataCode${uniqueId}.substring(0,dataCode${uniqueId}.length - 1);
		}
// 		dataStrOrg${uniqueId} = dataCode${uniqueId};
		 var elm1 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElm"); 
    	if(elm1!=null){	        		
    		if(elm1.name.indexOf('${genericHiddenElmName}')<0){
    			elm1.name="${genericHiddenElmName}."+elm1.name;
    		}	        		
    		elm1.value = dataStr${uniqueId};	    		
    	}	
    	var elm2 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElmCd"); 
    	if(elm2!=null){	        		
    		if(elm2.name.indexOf('${genericHiddenElmName}')<0){
    			elm2.name="${genericHiddenElmName}."+elm2.name;
    		}	        		
    		elm2.value = dataCode${uniqueId};	        		
    	}	
		YAHOO.util.Dom.get('${textid}').value = dataStr${uniqueId};
		closeMultiPanel${uniqueId}();
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
	
	YAHOO.util.Event.on('${textid}','blur',function (e) { 
		
		if(YAHOO.util.Dom.get('${textid}').value != ''){			
			if(dataCodeOfAttr${uniqueId} != null  && dataCodeOfAttr${uniqueId}[${attrId}] != null){
				var req =  YAHOO.util.Dom.get('${textid}').value;
				req = req.toLowerCase();
				var arrReq = req.split(";");
				//begin filter
				var filtered = filterData${uniqueId}WhenFocusOut(arrReq);
				setDataFor${uniqueId}Attribute(filtered, arrReq);
				 
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
	
	function filterData${uniqueId}WhenFocusOut(arrReq){
		var results = [],
        filtered = [],
        i,l,
        j,k;
		
	    if (arrReq) {
	        for (i = 0, l = dataCodeOfAttr${uniqueId}[${attrId}].length; i < l; ++i) {
	        	for (j = 0, k = arrReq.length; j < k; j++) {
	        		 if (dataCodeOfAttr${uniqueId}[${attrId}][i].attrName.toLowerCase().indexOf(myTrim(arrReq[j])) >=0) {
	 	                filtered.push(dataCodeOfAttr${uniqueId}[${attrId}][i]);
	 	               	break;
	 	            }
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
							req = req.toLowerCase();
							var arrReq = req.split(";");
							var filtered = filterData${uniqueId}WhenFocusOut(arrReq);
							setDataFor${uniqueId}Attribute(filtered, arrReq);
						}
					} catch (e) {
						YAHOO.util.Dom.get('${textid}').value = dataStr${uniqueId};
						fillDataAndShow${uniqueId}MultiPopup();
						document.getElementById('errorMes${uniqueId}').innerHTML = 'Error connecting data.';
						hideTheProgress();
						return;
					}
				},
				failure : function() {
					YAHOO.util.Dom.get('${textid}').value = dataStr${uniqueId};
					fillDataAndShow${uniqueId}MultiPopup();
					document.getElementById('errorMes${uniqueId}').innerHTML = 'Error connecting data.';
					hideTheProgress();
				},
				timeout : 5000
			};
		YAHOO.util.Connect.asyncRequest('GET',
				"${showMultiPopupURL}&entyId=${entyId}&attrId=${attrId}", callbacks);
		
	}
	
	function setDataFor${uniqueId}Attribute(filtered, arrReq) {
		if(isEqual${uniqueId}Filter(filtered, arrReq)){
			var str = "";
			var strCd = "";
			for(var i=0;i<filtered.length;i++){
				str = str.concat(filtered[i].attrName).concat("; ");
				strCd =  str.concat(filtered[i].attrCode).concat(";");
			}
			if(str.length > 0){
				str = str.substring(0, str.length-2); 
				strCd = strCd.substring(0, strCd.length-1)
			}
			dataStr${uniqueId} = str;
			YAHOO.util.Dom.get('${textid}').value = str;
			var elm1 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElm"); 
			if(elm1!=null){	        		
	    		if(elm1.name.indexOf('${genericHiddenElmName}')<0){
	    			elm1.name="${genericHiddenElmName}."+elm1.name;
	    		}	        		
	    		elm1.value = str;	    		
	    	}	
	    	var elm2 = YAHOO.util.Dom.get("${uniqueId}StrutsHiddenElmCd"); 
	    	if(elm2!=null){	        		
	    		if(elm2.name.indexOf('${genericHiddenElmName}')<0){
	    			elm2.name="${genericHiddenElmName}."+elm2.name;
	    		}	        		
	    		elm2.value = strCd;	        		
	    	}
	    	hideTheProgress();
		} else {
			open${uniqueId}Popup();
		}
		
	}

	function isEqual${uniqueId}Filter(filtered, arrReq) {
		var flg = false;
		if(filtered.length == arrReq.length){
			for(var i=0;i<arrReq.length;i++){
				if(isExist${uniqueId}Req(filtered, arrReq[i])){
					flg = true;
				} else {
					flg = false;
					break;
				}
			}
		}
		return flg;
	}
	
	
	function isExist${uniqueId}Req(filtered, req) {
		var flg = false;
		for(var i=0;i<filtered.length;i++){
			if(filtered[i].attrName.toLowerCase().indexOf(myTrim(req)) >=0){
				flg = true;
				break;
			}
		}
		return flg;
	}
	
	
	function isConstain${uniqueId}Str(str, req) {
		var flg = false;
		var arrReq = req.split(";");
		for(var i=0;i<arrReq.length;i++){
			if(parseInt(str) == parseInt(arrReq[i])){
				flg = true;
				break;
			}
		}
		return flg;
	}
	
	function closeMultiPanel${uniqueId}() {
		closePopupMultiPanel${uniqueId}();
	}

	function closePopupMultiPanel${uniqueId}() {
		YAHOO.util.Dom.get('${textid}').value = dataStr${uniqueId};
		document.getElementById("multiPanel${uniqueId}").style.display="none";
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


