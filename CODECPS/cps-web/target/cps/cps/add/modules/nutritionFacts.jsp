<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<fieldset style="width: 95%;">
	<legend class="legendFont">Nutrition Facts</legend>
	<cps:renderByResourceAccess resourceId="279">
		<jsp:attribute name="EDIT">
			<jsp:include page="/cps/add/modules/nutritionFactsGrid.jsp"></jsp:include>
		</jsp:attribute>
		<jsp:attribute name="VIEW">
			<jsp:include page="/cps/add/modules/nutritionFactsGrid.jsp"></jsp:include>
		</jsp:attribute>
		<jsp:attribute name="NONE">
			<div>&nbsp;</div>
		</jsp:attribute>
	</cps:renderByResourceAccess>
	<div style="width:100%;">
	<table style="width: 100%;"><tbody><tr><td width="100%">&nbsp;</td></tr></tbody></table>
	</div>
</fieldset>


<script type="text/javascript">
	function doApproveNutriFacts() {
		showProgress();
		AddCandidateTemp.updateApproveSwitch(getDWRCallbackMethod(refreshDataForNutritionFacts));
	}

	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("approveBtn"), "click", doApproveNutriFacts);
</script>
