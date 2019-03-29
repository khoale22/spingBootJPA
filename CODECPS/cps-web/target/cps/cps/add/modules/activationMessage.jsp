<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<style type="text/css">
	.yui-skin-sam .yui-dt-col-address pre { font-family:arial;font-size:100%; } 
	.origin { display: block; background: #795089; padding: 1ex; color: #fff; text-align: right; margin-bottom: 1em; }
	#messageTable thead { display: none; }
	#messageTable { margin-top: 1em; }
	#paginated { text-align: center; }
	#paginated table { margin-left:auto; margin-right:auto; }
	#paginated, #paginated .yui-dt-loading { text-align: center; background-color: transparent; }
	.msgTable { border: 1px solid #7F7F7F; border-collapse: separate; border-spacing: 0; width: 600px; }
	.row0 { background: #ffffff; vertical-align: middle; }
	.row1 { background: #edf5ff; vertical-align: middle; }
	.label { vertical-align: inherit; text-align: left; width: 35%; padding: 5px 10px; margin: 0; color: black; font: bold 12px Verdana, Arial, Helvetica, sans-serif; text-decoration: underline; border-right: 1px solid #CBCBCB;}
	.value { vertical-align: inherit; text-align: left; padding: 0px 10px; margin: 0; color: black; font: 12px Verdana, Arial, Helvetica, sans-serif; }
</style>
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
</head>
<body class="yui-skin-sam">
	<table border="0" width="100%" align="center">	
		<tr>
			<td>	
				<div id="messageTable"></div>
			</td>
		</tr>
		<tr>
			<td>
				<font color="blue" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">Existing UPCs/Item Codes are marked with an '*'.</font>
			</td>
		</tr>
	</table>			

</body>
</html>
<c:url value="${request.getContextPath()}/yui/" var="yuiURL"/>
<c:url value="${request.getContextPath()}/yui/yahoo-dom-event/yahoo-dom-event.js" var="yahooDom" />
<script type="text/javascript" src="${yahooDom}"></script>	
<c:url value="${request.getContextPath()}/yui/yuiloader/yuiloader-min.js" var="loaderURL"/> 
<c:url value="${request.getContextPath()}/hebAssets/json3.min.js" var="json3" />
<script type="text/javascript" src="${json3}"></script>
<script type="text/javascript" src="${loaderURL}"></script>  
<script type="text/javascript">

function show() {
	showProgress();

    <c:url value="/protected/cps/add/activationMessage?${_csrf.parameterName}=${_csrf.token}" var="serverUrl" />

    var responseSuccess = function(o) {
    	hideProgress();
    	try {
    		var result = JSON.parse(o.responseText);
    		var activatedProd = result.ResultSet.records;
    		if (!activatedProd) {
    			document.getElementById("messageTable").innerHTML = 'Empty data.';
    			return;
    		}
    		var innerTable = '<table class="msgTable">';
    		for (i = 0; i < activatedProd.length; i++) {
    			innerTable += '<tr class="row' + i%2 +'" id="row' + i + '">';
    			innerTable += '<td class="label" id="label' + i + '">' + activatedProd[i].code + '</td>';
    			innerTable += '<td class="value" id="text' + i + '">' + activatedProd[i].desc + '</td>';
    			innerTable += '</tr>';
    		}
			innerTable += '</table>';
    		document.getElementById("messageTable").innerHTML = innerTable;
    	} catch (e) {
    		alert("Data error: " + YAHOO.lang.dump(e));
    		return;
    	}
    	return;
    }

    var tryCount = 0;
    var responseFailure = function(o) {
    	if (tryCount < 3) {
    		tryCount++;
			var cObj = YAHOO.util.Connect.asyncRequest('POST', '${serverUrl}', callback);
		} else {
			hideProgress();
			alert('Activation is taking longer than the normal time. Please refresh and verify the UPC status.');
			return;
		}
    }

    var callback = {
		success: responseSuccess,
		failure: responseFailure,
		timeout: 20000
   	};
   	var cObj = YAHOO.util.Connect.asyncRequest('POST', '${serverUrl}', callback);

}

function loadTable(){
    var tableLoader = new YAHOO.util.YUILoader({ 
        base: "${yuiURL}", 
        require: ["paginator","datatable","connection","json","datasource", "element", "yuiloader"], 
        loadOptional: true, 
        combine: false, 
        filter: "MIN", 
        allowRollup: false, 
        onSuccess: function() {   
		
			show();			
        },
        onFailure: function(o) { 
            alert("Failure error: " + YAHOO.lang.dump(o)); 
        },
        onTimeout: function(o) { 
            alert("Timeout error: " + YAHOO.lang.dump(o)); 
        }
    }); 
    tableLoader.insert();
}
YAHOO.util.Event.onDOMReady(loadTable); 
</script>
