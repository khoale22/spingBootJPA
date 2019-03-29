<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>

<style type="text/css">
.dataGridHead {
	background-color: #E7DEDE;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-face: #9C9494;
}
.yui-skin-sam .yui-dt tr.mark,
.yui-skin-sam .yui-dt tr.mark td.yui-dt-asc,
.yui-skin-sam .yui-dt tr.mark td.yui-dt-desc,
.yui-skin-sam .yui-dt tr.mark td.yui-dt-asc,
.yui-skin-sam .yui-dt tr.mark td.yui-dt-desc {
    background-color: #a39;
    color: #fff;
}
.yui-skin-sam .yui-dt th {
    text-align: center; font-weight:bold ; color: #00000; font-family: Arial, Helvetica, sans-serif; font-size: 12px;
}

table{font-size:11px; text-align : center;}

.yui-skin-sam .yui-dt table .tbl-filter {
  width: 100%;
  border: 0px;
}
.yui-skin-sam .yui-dt .td-filter .yui-panel{
	border-color: -moz-use-text-color #CBCBCB -moz-use-text-color -moz-use-text-color;
    border-style: none none none none;
    border-width: medium 0px medium medium;
    margin: 0;
    padding: 0;  
}

.yui-skin-sam .yui-dt td.align-center  { 
		text-align:center;
}
#preStatePopup .yui-dt-loading {
	display: none;
}
</style>
<div id="preStatePopup">
	<div class="hd">
			<div class="tl"></div>
			<span>
				<font size="2" color="white">&nbsp;&nbsp;&nbsp;
					Preparation State
				</font>
			</span>
			<div class="closeMe" onclick="doClickClosePreStatePopup()"></div>
			<div class="tr"></div>
	</div>
    <div class="bd">
		<div>
			<div class='colCode'>
				<label>Preparation State</label>
			</div>
			<div class='textBoxContainer'>
				<input id="filterpreTxt" type="text" name="desc" value="">
				<c:url value="${request.getContextPath()}/hebAssets/images/icons/IMG_searchIcon.gif" var="imageSrch"></c:url>	
				<img src="${imageSrch}" alt="" width="20" id="srchImage"
						onclick="beginPreFilter()"
						height="20" style="cursor: pointer;" />
				<c:url value="${request.getContextPath()}/hebAssets/images/delete.png" var="image"></c:url>
				<img src="${image}" alt="" onclick="clearPreFilter()" id="clearImage"/>
			</div>
			<div style="clear: both;"></div>
			<div class='notice'>
				<label>* Select only one value from below </label>
			</div>
			
			<div class='gridWrapper'>
				<div id="yahoo-com" class="yui-skin-sam">
					<div id="tbl"></div>
				</div>
			</div>
			<div class='buttonBar' >
<!-- 				<input type="button" id="btnOkClaims" value="OK" -->
<!-- 					onclick="okPrePopup()"></input> -->
				
				<input type="button" id="btnClosePreState" value="Close"
					onclick="doClickClosePreStatePopup()" ></input>
			</div>
		</div>
	</div>
    <div class="ft">
			<div class="bl"></div>
			<div class="br"></div>
	</div>
</div>

<script type="text/javascript">
/* pop up edit nutrition claims */
YAHOO.namespace('heb.imageAttribute.prepareState');
var dataTablePre = null;
var preStateNS = YAHOO.namespace('heb.nutri.preState.popup');
preStateNS.dataTbl = {
	    items: [{radio: false, cd: "Y", desc: "YES"}, {radio: false, cd: "N", desc: "NO"}]
	}
	
var dataPrSttOrg = document.getElementById('spanPreState').innerText;
var preStateUOMDesc = dataPrSttOrg;

function queryPreStateByTxt(element){ 
	if(element.value && element.value.trim().length > 0){
		element.value = element.value.trim();
		initSuggestDataForPreState(element);
	}
}

function initSuggestDataForPreState(input){
	showProgress();
	var arr = [];
	for (var i = 0 ; i < preStateNS.dataTbl["items"].length; i++){
		var data = preStateNS.dataTbl["items"][i];
		if(data["desc"] && data["desc"].toLowerCase().indexOf(input.value.toLowerCase()) == 0){
			arr.push(data);
		}
	}
	if(arr.length == 1){
		input.value = arr[0]["desc"];
		preStateUOMDesc = arr[0]["desc"];
		hideProgress();
	}else{
		showpreStatePopup();
	}
}

function showpreStatePopup(){
	preStateUOMDesc = YAHOO.util.Dom.get('txtPreState').value;
	if (!isPreShowed) {
		isPreShowed = true;
		document.getElementById("preStatePopup").style.display="inline";
		YAHOO.heb.imageAttribute.prepareState = new YAHOO.widget.Panel("preStatePopup",
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
		
		YAHOO.heb.imageAttribute.prepareState.render(document.body);
		showProgress();
		showLstPreState();
	}
}

function doClickClosePreStatePopup(){
	YAHOO.util.Dom.get('txtPreState').value = preStateUOMDesc;
	closePrePopup();
}

function showLstPreState() {
	preStateNS.Scrolling = new function() {
        var myColumnDefs = [
                {key:"radio", label:"Select", width:50, formatter: 'radio'},
                {key:"cd", label:"Preparation State", width:200},
                {key:"desc", label:"Preparation State Description", width:300}
            ];

        var myDataSource = new YAHOO.util.DataSource(preStateNS.dataTbl);
		myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSON;
        myDataSource.responseSchema = {
            resultsList: "items",
            fields: [
                {key:"radio"},
                {key:"cd"},
                {key:"desc"}
            ]
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
							data[i].radio = false;
		                    if (data[i].desc.toLowerCase().indexOf(myTrim(req)) >=0) {
		                    	if(data[i].desc.toLowerCase() == preStateUOMDesc.toLowerCase()){
		                    		data[i].radio = true;
		                    	}
		                        filtered.push(data[i]);
		                    }
		                }
		                res.results = filtered;
		            } 
					
					else {
						for (i = 0, l = data.length; i < l; ++i) {
							if(data[i].desc.toLowerCase() == preStateUOMDesc.toLowerCase()){
		                    	data[i].radio = true;
		                    }
						}
					}
		            
		            if(res.results != null && res.results.length > 0){
		            	res.results.sort(sortFunction('cd'));
		            }

            return res;
        };

        dataTablePre = new YAHOO.widget.ScrollingDataTable("tbl", myColumnDefs, myDataSource, {height:"15em"});
        dataTablePre.showTableMessage("");
        preStateNS.filterTimeout = null; 
		
        preStateNS.updateFilter  = function () {
			myDataSource.sendRequest(YAHOO.util.Dom.get('filterpreTxt').value ,{
				success : dataTablePre.onDataReturnInitializeTable,
				failure : dataTablePre.onDataReturnInitializeTable,
				scope   : dataTablePre
			});
		}
		        
        
        
        dataTablePre.subscribe("radioClickEvent", function (oArgs) {
            var elCheckbox = oArgs.target;
            var oRecord = this.getRecord(elCheckbox);
            var column = this.getColumn(elCheckbox);
    		oRecord.setData(column.key, elCheckbox.checked);
    		for (var i= dataTablePre.getRecordSet().getLength() -1 ; i >=0 ;i--){
    			var oRec = dataTablePre.getRecordSet().getRecord(i);
    	        var dataCheckBox = oRec.getData("radio");
    	        if (dataCheckBox) {
    	        	var desc = oRec.getData("desc");
    	        	YAHOO.util.Dom.get('txtPreState').value  = desc;
    	        	preStateUOMDesc = desc;
    	        	break;
    	        }
    	 	}
    		closePrePopup();
        });
    };
	
	YAHOO.util.Dom.get('filterpreTxt').value = YAHOO.util.Dom.get('txtPreState').value;
	
	if(YAHOO.util.Dom.get('filterpreTxt').value != ''){
       	beginPreFilter();
	}
	
	YAHOO.util.Event.on('filterpreTxt','keyup',function (e) {
		if(e.keyCode == 13){
			beginPreFilter();
		}
	});
	
	setTimeout(function(){showPrepareStatePopup()},2000);
}

function showPrepareStatePopup(){
	YAHOO.heb.imageAttribute.prepareState.show();
	hideProgress();	
}

/* ACTION */
function beginPreFilter(){
	clearTimeout(preStateNS.filterTimeout); 
	setTimeout(preStateNS.updateFilter,600); 
}

function clearPreFilter(){
	YAHOO.util.Dom.get('filterpreTxt').value = '';
	beginPreFilter();
}

function closePrePopup(){
	isPreShowed = false;
	document.getElementById("preStatePopup").style.display="none";
	YAHOO.heb.imageAttribute.prepareState.hide();
}
function okPrePopup() {
	for (var i= dataTablePre.getRecordSet().getLength() -1 ; i >=0 ;i--){
		var oRec = dataTablePre.getRecordSet().getRecord(i);
        var dataCheckBox = oRec.getData("radio");
        if (dataCheckBox) {
        	var desc = oRec.getData("desc");
        	YAHOO.util.Dom.get('txtPreState').value  = desc;
        	break;
        }
 	}
	closePrePopup();
}
</script>