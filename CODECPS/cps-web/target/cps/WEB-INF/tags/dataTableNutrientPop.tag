<%@ tag import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@attribute name="compId" required="true" rtexprvalue="true"%>
<%@attribute name="compName" required="false" rtexprvalue="true"%>
<%@attribute name="jsonDataSource" required="false" rtexprvalue="true"%>
<%@attribute name="genericHiddenElmName" required="false"
	rtexprvalue="false"%>
<%@attribute name="viewMode" required="false" rtexprvalue="true"
	type="java.lang.Boolean"%>
<%@attribute name="mandatorySw" required="false" rtexprvalue="true" type="java.lang.Boolean"%>
<%@attribute name="resourceId" required="false" rtexprvalue="false"%>
<script type="text/javascript">
	var dt${compId};
	YAHOO.util.Event.onDOMReady(function(){
		initDataTableNuPopUp${compId}();
    });
	function initDataTableNuPopUp${compId}() {
		// Create the DataTable.
		var formatAutocomplete = function(elCell, oRecord, oColumn, sData) {				 			
		 var nutritionName = oRecord.getData("nutrientTypeTxt");	
		elCell.innerHTML = "<div class='myAutoComplete' id='myAutoComplete"+oRecord.getData("keyNutrition")+"'><input type='text' id='myInput"+oRecord.getData("keyNutrition")+"' value='"+convertHtml(nutritionName)+"' maxlength='30' onKeyPress='return disableEnterKey(event)' style='TEXT-TRANSFORM\: uppercase; position: relative;width:195;'\ /><div id='myContainer"+oRecord.getData("keyNutrition")+"'></div></div>";	
	   };	
	   var formatAutocompleteQuantityUom = function(elCell, oRecord, oColumn, sData) {				 			
			 var quantityUomName = oRecord.getData("sizeUomTxt");	
			elCell.innerHTML = "<div class='myAutoCompleteQuantityUom' id='myAutoCompleteQuantityUom"+oRecord.getData("keyNutrition")+"'><input type='text' id='myInputQuantityUom"+oRecord.getData("keyNutrition")+"' value='"+convertHtml(quantityUomName)+"' maxlength='30' onKeyPress='return disableEnterKey(event)' style='TEXT-TRANSFORM\: uppercase; position: relative;width:195;'\ /><div id='myContainerQuantityUom"+oRecord.getData("keyNutrition")+"'></div></div>";	
	   };	
	    var myColumnDefs = [
	  		{key:"checkBox", label: "Select", formatter : "checkbox"},                      
	        {key:"nutritionId", label : "Nutrient Type Code <c:if test="${mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>", formatter:formatAutocomplete },
	        {key:"nutriQuantity", label : "Quantity Contained <c:if test="${mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>", formatter : "textbox"},
	        {key:"servingSizeUOMCD", label : "Quantity Contained UOM <c:if test="${mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>", formatter:formatAutocompleteQuantityUom },
	        {key:"nutritionMeasr", label : "Measurement Precision", formatter : "dropdown", dropdownOptions : ["","APPROXIMATELY","EXACT","LESS_THAN"] },
	        {key:"dailyValue", label : "Percentage of Daily Value Intake ", formatter : "textbox"},
	        {key:"nutrientTypeTxt", label : "Nutri Type Text", hidden: true, width:0},
	        {key:"sizeUomTxt", label : "Size UOM Text", hidden: true, width:0},
	        {key:"changed", label : "", width:0,hidden :true},
	        {key:"isOrContainer", label : "", width:0,hidden :true},
	        {key:"keyNutrition", label : "", width:0,hidden :true}
	    ];
		var dataTable = {"100": [
		                        {
		                        	"checkBox": false,
		                            "nutritionId": "nutritionName1001",
		                            "nutriQuantity": "nutriQuantity1001",
		                            "servingSizeUOMCD": "servingSizeUOMCD1001",
		                            "nutritionMeasr": "nutritionMeasr1001",
		                            "dailyValue": "dailyValue1001",
		                            "nutrientTypeTxt": "",
		                            "sizeUomTxt": "",
		                            "changed" :"",
		                            "isOrContainer" :"",
		                            "keyNutrition":""
		                        },
		                        {
		                        	"checkBox": false,
		                            "nutritionId": "nutritionName1002",
		                            "nutriQuantity": "nutriQuantity1003",
		                            "servingSizeUOMCD": "servingSizeUOMCD1002",
		                            "nutritionMeasr": "nutritionMeasr1002",
		                            "dailyValue": "dailyValue1002",
		                            "nutrientTypeTxt": "",
		                            "sizeUomTxt": "",
		                            "changed" :"",
		                            "isOrContainer" :"",
		                            "keyNutrition":""
		                        }
		                    ]};
	    var myDataSource = new YAHOO.util.LocalDataSource(dataTable["100"]);
		dt${compId} = new  YAHOO.widget.DataTable("nutrientDataTablePop${compId}", myColumnDefs, myDataSource);
		dt${compId}.subscribe("dropdownChangeEvent", function(oArgs) {
			
		});
		// Subscribe to events for row selection
	       dt${compId}.subscribe("rowMouseoverEvent", dt${compId}.onEventHighlightRow);
	       dt${compId}.subscribe("rowMouseoutEvent", dt${compId}.onEventUnhighlightRow);
	       dt${compId}.subscribe("rowClickEvent", dt${compId}.onEventSelectRow);
		dt${compId}.subscribe("checkboxClickEvent", function (oArgs) {
	        var elCheckbox = oArgs.target;
	        var oRecord = this.getRecord(elCheckbox);
	        var column = this.getColumn(elCheckbox);
			oRecord.setData(column.key,elCheckbox.checked);
	    });
		YAHOO.util.Event.on(dt${compId}.getTbodyEl(),'keyup',function (ev) {
			var elInput = YAHOO.util.Event.getTarget(ev);
			if (elInput.tagName.toUpperCase() == 'INPUT') {
				var oRecord = dt${compId}.getRecord(elInput);
				var column = dt${compId}.getColumn(elInput);
				oRecord.setData(column.key,elInput.value);
			}
		});
		YAHOO.util.Event.on(dt${compId}.getTbodyEl(),'keypress',function (ev) {
			var elInput = YAHOO.util.Event.getTarget(ev);
			if (elInput.tagName.toUpperCase() == 'INPUT') {
			}
		});
		document.getElementById("messageHeader${compId}").style.display="none";
	}
	YAHOO.util.Event.addListener("delete${compId}", "click", fnDelete${compId});
	YAHOO.util.Event.addListener("add${compId}", "click", fnAdd${compId});
	var messageField = "";
	function fnDelete${compId}(e) {
	}
	function disableButWhenErrorConnect${compId}(param) {
		document.getElementById("add${compId}").disabled=param;
		document.getElementById("delete${compId}").disabled=param;
	}
	function fnAdd${compId}() {
		
	}
	function convertHtml(str)
	{
	  str = str.replace(/&/g, "&amp;");
	  str = str.replace(/>/g, "&gt;");
	  str = str.replace(/</g, "&lt;");
	  str = str.replace(/"/g, "&quot;");
	  str = str.replace(/'/g, "&#039;");
	  return str;
	}
	function disableEnterKey(e)
	{
	     var key;		
	     if(window.event)
	          key = window.event.keyCode;     //IE
	     else
	          key = e.which;     //firefox		
	     if(key == 13)
	          return false;
	     else
	          return true;
	}
</script>
<div style="width: 100%;clear: both;">
	<div id="messageHeader${compId}"
		style="display: none; font-size: 12px; color: red;">..is a
		mandatory field !</div>
	<div class="yui-skin-sam">
		<div id="nutrientDataTablePop${compId}"></div>
	</div>
	<div id="buttons${compId}" align="right" style="margin-top: 10px">
		<input type="button" id="add${compId}" name="Add" value="Add"
			style="cursor: pointer;"> <input type="button"
			id="delete${compId}" name="Delete" style="cursor: pointer;"
			value="Delete">
	</div>
</div>



