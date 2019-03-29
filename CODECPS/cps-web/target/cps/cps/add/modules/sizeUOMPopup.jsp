<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>

<c:url value="${request.getContextPath()}/yui/paginator/assets/skins/sam/paginator.css" var="styleURL" />
<link type="text/css" rel="stylesheet"
	href="${styleURL}">

<!-- Dependencies -->
<c:url value="${request.getContextPath()}/yui/yahoo-dom-event/yahoo-dom-event.js" var="styleURL" />
<script src="${styleURL}"></script>
<c:url value="${request.getContextPath()}/yui/element/element-beta-min.js" var="styleURL" />
<script src="${styleURL}"></script>

<!-- Source File -->
<c:url value="${request.getContextPath()}/yui/paginator/paginator-min.js" var="styleURL" />
<script src="${styleURL}"></script>
<style type="text/css">
/* .dataGridHead { */
/* 	background-color: #E7DEDE; */
/* 	font-weight: bold; */
/* 	font-family: Arial, Helvetica, sans-serif; */
/* 	font-size: 12px; */
/* 	font-face: #9C9494; */
/* } */

.yui-skin-sam .yui-dt tr.mark,.yui-skin-sam .yui-dt tr.mark td.yui-dt-asc,.yui-skin-sam .yui-dt tr.mark td.yui-dt-desc,.yui-skin-sam .yui-dt tr.mark td.yui-dt-asc,.yui-skin-sam .yui-dt tr.mark td.yui-dt-desc
	{
	background-color: #a39;
	color: #fff;
}

/* .yui-skin-sam .yui-dt th { */
/* 	text-align: center; */
/* 	font-weight: bold; */
/* 	color: #00000; */
/* 	font-family: Arial, Helvetica, sans-serif; */
/* 	font-size: 12px; */
/* } */

/* table { */
/* 	font-size: 11px; */
/* 	text-align: center; */
/* } */

.yui-skin-sam .yui-dt table .tbl-filter {
	width: 100%;
	border: 0px;
}

.yui-skin-sam .yui-dt .td-filter .yui-panel {
	border-color: -moz-use-text-color #CBCBCB -moz-use-text-color
		-moz-use-text-color;
	border-style: none none none none;
	border-width: medium 0px medium medium;
	margin: 0;
	padding: 0;
}

.yui-skin-sam .yui-dt td.align-center {
	text-align: center;
}
</style>
<c:url value="${request.getContextPath()}/hebAssets/images/icons/IMG_searchIcon.gif" var="imageSrch"/>
<c:url value="${request.getContextPath()}/hebAssets/images/delete.png" var="image"/>
<div id="sizeUOMPopup" style="display: none;">
	<div class="hd">
		<div class="tl"></div>
			<span>
				<font size="2" color="white">&nbsp;&nbsp;&nbsp;
					Serving Size UOM
				</font>
			</span>
			<div class="closeMe" onclick="doClickClose()"></div>
			<div class="tr"></div>
	</div>
	<div class="bd">
		<div>
			<div class='colCode'>
				<label>Serving size UOM</label>
			</div>
			<div class='textBoxContainer'>
				<input id="filterUOMTxt" type="text" name="desc" value="">
				<img src="${imageSrch}" alt="" width="20" id="srchImage"
					onclick="beginUOMFilter()" height="20" style="cursor: pointer;" />
				<img src="${image}" alt="" onclick="clearUOMFilter()"
					id="clearImage" style="cursor: pointer;" />
			</div>
			<div style="clear: both;"></div>
			<div class='notice'>
				<label>* Select only one value from below </label>
			</div>

			<div class='gridWrapper'>
				<div id="yahoo-com" class="yui-skin-sam">
					<div id="tbl"></div>
					<div id="paging"></div>
				</div>
			</div>
			<div class='buttonBar'>
				<!-- 				<input type="button" id="btnOkUOM" value="OK" -->
				<!-- 					onclick="okUOMPopup()"></input> -->

				<input type="button" id="btnCloseUOM" value="Close"
					onclick="doClickClose()"></input>
			</div>
		</div>
	</div>
	<div class="ft">
		<div class="bl"></div>
		<div class="br"></div>
	</div>
</div>

<script type="text/javascript">
/* pop up edit nutrition UOM */
YAHOO.namespace('heb.imageAttribute.sizeUOMPopup');
var dataTableUOM = null;
var arrUOM = new Array();
var sizeUomNS = YAHOO.namespace('heb.nutri.UOM.popup');
sizeUomNS.dataTbl = {
	    items: arrUOM
	}
var dataOfUOMs = null;
var dataStrOrg = document.getElementById('spanSizeUOM').innerText;
var dataSizeUOMDesc = dataStrOrg;

function queryItemByTxt(element){ 
	if(element.value.trim().length > 0){
		element.value = element.value.trim();
		if(dataOfUOMs != null){
			initSuggestData(element);
		} else {
			getLstNutriUOM(false);
		}
	} else {
		sizeUOMCD = '';
	}
}

function initSuggestData(input){
	showProgress();
	var arr = [];
	for (var i = 0 ; i < dataOfUOMs["items"].length; i++){
		var data = dataOfUOMs["items"][i];
		if(data["desc"] && data["desc"].toLowerCase().indexOf(input.value.toLowerCase()) == 0){
			arr.push(data);
		}
	}
	if(arr.length == 1){
		var desc, temp1= document.createElement('p');
	    temp1.innerHTML= arr[0]["desc"];
	    desc = temp1.textContent || temp1.innerText;
		input.value = desc;
		dataSizeUOMDesc = desc;
		sizeUOMCD = arr[0]["id"];
		hideProgress();
	}else{
		sizeUOMCD ='';
		input.value = "";
		doShowNutriUOMPopup(true);
		fillDataForUOMPopup();
	}
}

function showNutriUOMPopup(){
	if(YAHOO.util.Dom.get("txtSizeUOM").value.trim().length == 0){
		sizeUOMCD = '';
	}
	doShowNutriUOMPopup(false);
}

function doShowNutriUOMPopup(isQuery){
	if (!isUomShowed) {
		isUomShowed = true;
		document.getElementById("sizeUOMPopup").style.display="inline";
		YAHOO.heb.imageAttribute.sizeUOMPopup = new YAHOO.widget.Panel("sizeUOMPopup",
		{ 	width:"680px",
			height:"450px",
			underlay:"shadow",
			visible:false,
			constraintoviewport:true, 
			draggable:false,
			zIndex : 15000,
			modal:true,
			close:true,
			fixedCenter : true
		} );
		
		YAHOO.heb.imageAttribute.sizeUOMPopup.render(document.body);
		if(!isQuery){
			if(dataOfUOMs != null){
				showProgress();
				fillDataForUOMPopup();
			} else {
				getLstNutriUOM(true);
			}
		}
//	 	showProgress();
	}
}

<c:url value="getServSizeUOMData?${_csrf.parameterName}=${_csrf.token}" var="showUOMsPopupURL"></c:url>
function getLstNutriUOM(isShowPopup) {
	//AddCandidateTemp.getLstNutriUOM(showLstNutriUOM);

	showProgress();
	var callbacks = {
			success : function(o) {
				try {
					if (o != null && myTrim(o.responseText) != "") {
						dataOfUOMs = YAHOO.lang.JSON.parse(o.responseText);
						if(isShowPopup){
							fillDataForUOMPopup();
						}else{
							initSuggestData(YAHOO.util.Dom.get("txtSizeUOM"));
						}
// 						document.getElementById('errorMes${uniqueId}').innerHTML = '';
					}
				} catch (e) {
					alert('Error connecting data.');
					hideProgress();
					return;
				}
			},
			failure : function() {
				alert('Error connecting data.');
				hideProgress();
			},
			timeout : 10000
		};
		YAHOO.util.Connect.asyncRequest('GET',
				"${showUOMsPopupURL}", callbacks);

}

/* ACTION */
function fillDataForUOMPopup() {
	sizeUomNS.Scrolling = new function() {
        var myColumnDefs = [
                {key:"radio", label:"Select", width:50, formatter: 'radio'},
                {key:"cd", label:"Serving Size UOM", width:200},
                {key:"desc", label:"Serving Size UOM Description", width:300},
                {key:"id", width:0, hidden:true}
            ];

        var myDataSource = new YAHOO.util.LocalDataSource(dataOfUOMs);
		myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSON;
        myDataSource.responseSchema = {
			resultsList: "items", 
			fields: ["id","desc","radio","cd"] 
        };
		
        var sortFunction = function(field){
        	return function (a,b){
        		if ( a.radio == true && b.radio == true ) {
        			if(a[field].toLowerCase() < b[field].toLowerCase()){
        				return -1;
        			}
        			if(a[field].toLowerCase() > b[field].toLowerCase()){
        				return 1;
        			}
        			return 0;
        		}
        		
        		if ( a.radio == true && b.radio == false )
        		    return -1;
    		    if ( a.radio == false && b.radio == true )
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
                	if (data[i].desc != null && data[i].desc != ""){
                		var desc1, temp2= document.createElement('p');
                	    temp2.innerHTML= data[i].desc;
                	    desc1 = temp2.textContent || temp2.innerText;
    					if (desc1.toLowerCase().indexOf(req) >=0) {
    						if(data[i].id != null && data[i].id != "" && data[i].id == sizeUOMCD){
    							data[i].radio = true;
    						} 
                            filtered.push(data[i]);
                        }
                	}
                }
                res.results = filtered;
            } else {
            	for (i = 0, l = data.length; i < l; ++i) {
					if(data[i].id != null && data[i].id != "" && data[i].id == sizeUOMCD){
						data[i].radio = true;
					}
				}
			}
            
            if(res.results != null && res.results.length > 0){
            	res.results.sort(sortFunction('cd'));
            }
            return res;
        };
        
        var myConfigs = {
   			paginator: new YAHOO.widget.Paginator({
   				rowsPerPage: 10,
   				pageLinks: 5,
   				template : "<strong>{CurrentPageReport}</strong> {FirstPageLink} {PreviousPageLink} {PageLinks} {NextPageLink} {LastPageLink} " ,
   				pageReportTemplate : "Total Records: {totalRecords} ",
				containers  : 'paging'
   			}),
   			height:"220px",
			draggableColumns:false
   		};

        dataTableUOM = new YAHOO.widget.ScrollingDataTable("tbl", myColumnDefs, myDataSource, myConfigs);
      //  dataTableUOM.showTableMessage("");
       
        
        dataTableUOM.subscribe("radioClickEvent", function (oArgs) {
            var elCheckbox = oArgs.target;
            var oRecord = this.getRecord(elCheckbox);
            var column = this.getColumn(elCheckbox);           
    		oRecord.setData(column.key, elCheckbox.checked);
    		var desc, temp1= document.createElement('p');
    	    temp1.innerHTML= oRecord.getData("desc");
    	    desc = temp1.textContent || temp1.innerText;
        	var id = oRecord.getData("id");
        	sizeUOMCD = id;
        	YAHOO.util.Dom.get('txtSizeUOM').value  = desc;
        	dataSizeUOMDesc = desc;
    		/* for (var i= dataTableUOM.getRecordSet().getLength() -1 ; i >=0 ;i--){
    			var oRec = dataTableUOM.getRecordSet().getRecord(i);
    	        var dataCheckBox = oRec.getData("radio");
    	        if (dataCheckBox) {
    	        	var desc = decodeHTMLEntity(oRec.getData("desc"));
    	        	var id = oRec.getData("id");
    	        	sizeUOMCD = id;
    	        	YAHOO.util.Dom.get('txtSizeUOM').value  = desc;
    	        	break;
    	        }
    	 	} */
    		closeUOMPopup();
        });
		
		
		
        sizeUomNS.updateFilter  = function () {
        	var state = dataTableUOM.getState();
			myDataSource.sendRequest(YAHOO.util.Dom.get('filterUOMTxt').value ,{
				success : dataTableUOM.onDataReturnInitializeTable,
				failure : dataTableUOM.onDataReturnInitializeTable,
				scope   : dataTableUOM,
				argument: state
			});
		}
		
       
    }

	var str, temp= document.createElement('p');
    temp.innerHTML= YAHOO.util.Dom.get('txtSizeUOM').value;
    str= temp.textContent || temp.innerText;
	YAHOO.util.Dom.get('filterUOMTxt').value = str;
       
   	if(YAHOO.util.Dom.get('filterUOMTxt').value != ''){
       	beginUOMFilter();
	}
	
	setTimeout(function(){showUOMsPopup()},2000);
	
}


function showUOMsPopup(){
	YAHOO.heb.imageAttribute.sizeUOMPopup.show();
	hideProgress();
}

YAHOO.util.Event.on('filterUOMTxt','keyup',function (e) {
	if(e.keyCode == 13){
		beginUOMFilter();
	}
});

function beginUOMFilter(){
	 
	sizeUomNS.updateFilter(); 
}

function clearUOMFilter(){
	YAHOO.util.Dom.get('filterUOMTxt').value = '';
	beginUOMFilter();
}

function closeUOMPopup(){
	isUomShowed = false;
	document.getElementById("sizeUOMPopup").style.display="none";
	YAHOO.heb.imageAttribute.sizeUOMPopup.hide();
}

function doClickClose(){
	YAHOO.util.Dom.get('txtSizeUOM').value = dataSizeUOMDesc;
	closeUOMPopup();
}

function okUOMPopup() {
	for (var i= dataTableUOM.getRecordSet().getLength() -1 ; i >=0 ;i--){
		var oRec = dataTableUOM.getRecordSet().getRecord(i);
        var dataCheckBox = oRec.getData("radio");
        if (dataCheckBox) {
        	var desc = oRec.getData("desc");
        	var id = oRec.getData("id");
        	sizeUOMCD = id;
        	YAHOO.util.Dom.get('txtSizeUOM').value  = desc;
        	break;
        }
 	}
	closeUOMPopup();
}

function decodeHTMLEntity(s) {
	var str, temp= document.createElement('p');
    temp.innerHTML= s;
    str= temp.textContent || temp.innerText;
    temp=null;
    return str;

}

function encodeHtmlEntity(str) {
	 var div = document.createElement('div');
	 div.innerText = html;
	 return div.innerHTML;
}
</script>