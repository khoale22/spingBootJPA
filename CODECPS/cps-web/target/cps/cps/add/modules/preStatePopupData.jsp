<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>




<link rel="stylesheet" type="text/css" href="${request.getContextPath()}/yui/assets/yui.css?v=3" >
<link rel="stylesheet" type="text/css" href="${request.getContextPath()}/yui/assets/dpSyntaxHighlighter.css">
<link rel="stylesheet" type="text/css" href="/cps/yui/paginator/assets/skins/sam/paginator.css" />
<link rel="stylesheet" type="text/css" href="/cps/yui/datatable/assets/skins/sam/datatable.css" />
<link rel="stylesheet" type="text/css" href="/cps/yui/button/assets/skins/sam/button.css" />
<link rel="stylesheet" type="text/css" href="/cps/yui/autocomplete/assets/skins/sam/autocomplete.css" />
<script type="text/javascript" src="/cps/yui/yuiloader/yuiloader-min.js"></script>
<script type="text/javascript" src="/cps/yui/dom/dom-min.js"></script>
<script type="text/javascript" src="/cps/yui/event/event-min.js"></script>
<script type="text/javascript" src="/cps/yui/element/element-beta-min.js"></script>
<script type="text/javascript" src="/cps/yui/paginator/paginator-min.js"></script>
<script type="text/javascript" src="/cps/yui/dragdrop/dragdrop-min.js"></script>
<script type="text/javascript" src="/cps/yui/animation/animation-min.js"></script>
<script type="text/javascript" src="/cps/yui/datasource/datasource-min.js"></script>
<script type="text/javascript" src="/cps/yui/event-delegate/event-delegate-min.js"></script>
<script type="text/javascript" src="/cps/yui/datatable/datatable-min.js"></script>
<script type="text/javascript" src="/cps/yui/button/button-min.js"></script>
<script type="text/javascript" src="/cps/yui/autocomplete/autocomplete-min.js"></script>
<script type="text/javascript" src="/cps/yui/connection/connection-min.js"></script>
<script type="text/javascript" src="/cps/yui/selector/selector-beta-min.js"></script>
<script src="/cps/yui/yahoo/yahoo-min.js"></script>
<script src="/cps/yui/json/json-min.js"></script>
<c:url value="/dwr/engine.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/util.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="/dwr/interface/ManageEDIDWR.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<c:url value="${request.getContextPath()}/yui/connection/connection-min.js" var="styleLink"/>
<script type="text/javascript" src="${styleLink}"></script>
<c:url value="${request.getContextPath()}/hebAssets/dispatcher.js" var="myJs"/>


<style>
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

body{font:11px/1.231 arial,helvetica,clean,sans-serif;*font-size:small;*font:x-small;}
select,input,button,textarea{font:99% arial,helvetica,clean,sans-serif;}
table{font-size:11px; text-align : center;}
pre,code,kbd,samp,tt{font-family:monospace;*font-size:108%;line-height:100%;}

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
</style>

<script type="text/javascript">

</script>

<div>
	<div style="width: 40%; vertical-align: middle; float: left;" align="right" >
		<label style="font-weight: bold; font-size: 13px; vertical-align: middle;">Preparation State</label>
	</div>
	<div style="width: 3%; vertical-align: middle; float: left;">
	</div>
	<div style="width: 55%; vertical-align: middle; float: left;">
		<input id="filterTxt" type="text" name="attrName" value="">
		<c:url value="${request.getContextPath()}/hebAssets/images/delete.png" var="image"></c:url>
		<img src="${image}" alt="" width="20" onclick="clearFilter()"
						id="clearImage" height="20" style="cursor: pointer;"/>
	</div>
	<br/>
	<br/>
	<br/>
	<div style="width: 100%">
		<label style="font-style:italic; font-size: 11px;">* Select only one value from below </label>
	</div>
	
	<div style="width: 100%; height: 280px;">
		<div id="yahoo-com" class="yui-skin-sam">
			<div id="tbl"></div>
		</div> 
	</div> 

	<br/>
	<div style="width: 100%; vertical-align: middle; float: left;" align="right" >
		<input type="button" id="btnClose" value="Close" onclick="closePopup();" style="cursor: pointer;"></input>
	</div>	
</div>

<script type="text/javascript">

var HCD = YAHOO.namespace('heb.container.dynamicRender');


HCD.dataTbl = {
	    items: [
	        {checkBox: "<input type='radio' name=myradio id='ckb_1' align='bottom'>", attrName:"Formation Name 1", attrDesc:"Description 1 Description 1 Description 1"},
	        {checkBox: "<input type='radio' name=myradio id='ckb_2' align='bottom'>", attrName:"Line 2", attrDesc:"Description 2"},
	        {checkBox: "<input type='radio' name=myradio id='ckb_3' align='bottom'>", attrName:"Fation N3", attrDesc:"Description 3"},
	        {checkBox: "<input type='radio' name=myradio id='ckb_5' align='bottom'>", attrName:"label Name 5", attrDesc:"Description 5"},
	        {checkBox: "<input type='radio' name=myradio id='ckb_4' align='bottom'>", attrName:"FoOue Name 4", attrDesc:"Description 4"},
	        {checkBox: "<input type='radio' name=myradio id='ckb_6' align='bottom'>", attrName:"Gjiuiww N 6", attrDesc:"Description 6"},
	        {checkBox: "<input type='radio' name=myradio id='ckb_7' align='bottom'>", attrName:"Loiuasd Name 7", attrDesc:"Description 7"},
	        {checkBox: "<input type='radio' name=myradio id='ckb_8' align='bottom'>", attrName:"Chanel  8", attrDesc:"Description 8"},
	        {checkBox: "<input type='radio' name=myradio id='ckb_9' align='bottom'>", attrName:"FAceee Name 9", attrDesc:"Description 9"},
	        {checkBox: "<input type='radio' name=myradio id='ckb_10' align='bottom'>", attrName:"Book 10", attrDesc:"Description 14"}
	        
	    ]
	}
	
YAHOO.util.Event.addListener(window, "load", function() {
    HCD.Scrolling = new function() {

            
        var myColumnDefs = [
                {key:"checkBox", label:"Select", width:50, className: 'align-center'},
                {key:"attrName", label:"ATTR_VAL_CD", width:250},
                {key:"attrDesc", label:"ATTR_VAL_TXT", width:320}
            ];


        var myDataSource = new YAHOO.util.DataSource(HCD.dataTbl);
        myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSON;
        myDataSource.responseSchema = {
            resultsList: "items",
            fields: [
                {key:"checkBox"},
                {key:"attrName"},
                {key:"attrDesc"}
            ]
        };
		
		myDataSource.doBeforeCallback = function (req,raw,res,cb) {
            
            var data     = res.results || [],
                filtered = [],
                i,l;

            if (req) {
                req = req.toLowerCase();
                for (i = 0, l = data.length; i < l; ++i) {
                    if (data[i].attrName.toLowerCase().indexOf(req) >=0) {
                        filtered.push(data[i]);
                    }
                }
                res.results = filtered;
            }

            return res;
        };

        var myDataTable = new YAHOO.widget.ScrollingDataTable("tbl", myColumnDefs, myDataSource, {height:"15em"});
		
        HCD.filterTimeout = null; 
		
        HCD.updateFilter  = function () {
			myDataSource.sendRequest(YAHOO.util.Dom.get('filterTxt').value ,{
				success : myDataTable.onDataReturnInitializeTable,
				failure : myDataTable.onDataReturnInitializeTable,
				scope   : myDataTable,
				argument: attrName
			});
		}
		        
        if(YAHOO.util.Dom.get('filterTxt').value != ''){
        	beginFilter();
		}
    };
	
	YAHOO.util.Event.on('filterTxt','keyup',function (e) { 
		if(e.keyCode == 13){
			beginFilter();
		}
	});
	
	window.parent.execScript("hideTheProgress();");
});


function beginFilter(){
	clearTimeout(HCD.filterTimeout); 
	setTimeout(HCD.updateFilter,600); 
}

function clearFilter(){
	YAHOO.util.Dom.get('filterTxt').value = '';
	beginFilter();
}

function closePopup(){
	window.parent.execScript('closeSinglePanel();');
}



</script>