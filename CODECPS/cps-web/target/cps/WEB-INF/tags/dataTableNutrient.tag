<%@ tag import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@attribute name="compId" required="true" rtexprvalue="true"%>
<%@attribute name="compName" required="false" rtexprvalue="true"%>
<%@attribute name="jsonDataSource" required="false" rtexprvalue="true"%>
<%@attribute name="mandatorySw" required="false" rtexprvalue="true" type="java.lang.Boolean"%>
<script type="text/javascript">
	var dataTableWrapper${compId};
	var widthTable = (screen.width - 250)+"px";
	YAHOO.util.Event.onDOMReady(function(){
		initDataTableNuPopUp${compId}();
    });
	function initDataTableNuPopUp${compId}() {
		// Create the DataTable.
	    var myColumnDefs = [
	        {key:"nutritionId", label : "Nutrient Type Code <c:if test="${mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>"},
	        {key:"nutriQuantity", label : "Quantity Contained <c:if test="${mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>"},
	        {key:"servingSizeUOMCD", label : "Quantity Contained UOM <c:if test="${mandatorySw == true}"><strong class=\"redAsterisk\">*</strong></c:if>"},
	        {key:"nutritionMeasr", label : "Measurement Precision"},
	        {key:"dailyValue", label : "Percentage of Daily Value Intake "}
	    ];
		var dataTable = {"100": [
		                        {
		                            "nutritionId": "nutritionName1001",
		                            "nutriQuantity": "nutriQuantity1001",
		                            "servingSizeUOMCD": "servingSizeUOMCD1001",
		                            "nutritionMeasr": "nutritionMeasr1001",
		                            "dailyValue": "dailyValue1001"
		                        },
		                        {
		                        	"checkBox": false,
		                            "nutritionId": "nutritionName1002",
		                            "nutriQuantity": "nutriQuantity1003",
		                            "servingSizeUOMCD": "servingSizeUOMCD1002",
		                            "nutritionMeasr": "nutritionMeasr1002",
		                            "dailyValue": "dailyValue1002"
		                        }
		                    ]};
	    var myDataSource = new YAHOO.util.LocalDataSource(${jsonDataSource});
	    dataTableWrapper${compId} = new  YAHOO.widget.ScrollingDataTable("nutrientDataTable${compId}", myColumnDefs, myDataSource,{width:widthTable,height:"8em"});
		// Subscribe to events for row selection
	    dataTableWrapper${compId}.subscribe("rowMouseoverEvent", dataTableWrapper${compId}.onEventHighlightRow);
	    dataTableWrapper${compId}.subscribe("rowMouseoutEvent", dataTableWrapper${compId}.onEventUnhighlightRow);
	    dataTableWrapper${compId}.subscribe("rowClickEvent", dataTableWrapper${compId}.onEventSelectRow);
	}
</script>
<div style="width: 100%;clear: both;">
	<div class="yui-skin-sam">
		<div id="nutrientDataTable${compId}"></div>
	</div>
</div>



