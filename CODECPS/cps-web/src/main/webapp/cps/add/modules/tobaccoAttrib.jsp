<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<fieldset style="width: 95%;">
	<legend class="legendFont">Tobacco Attributes</legend>
	<table border="0" width="100%">
	<tr>
		<td align="right" width="20%">
			<label for="selectedFSA" class="labelFont helpable" id="TobaccoProdTypeLabel">Tobacco Product Type </label>
		</td>
		<td align="left" width="10%" >&nbsp;&nbsp;
			<form:select path="productVO.tobaccoVO.selTobaccoProdtype" tabindex="630" styleId="tobaccoProdtype" id="tobaccoProdtype">
			</form:select>
		</td>
		<td align="right" width="20%">
			<label for="selectedPSE" class="labelFont helpable" id="UnstampedSwitchLabel">Unstamped Switch </label>
		</td>
		<td align="left" width="10%">&nbsp;&nbsp;
			<form:input path="productVO.tobaccoVO.unstampedSwitch" maxlength="5" size="5" tabindex="640"
						styleId="unstampedSwitch" id="unstampedSwitch"/>
		</td>
		<td align="right" width="20%">
			<label class="labelFont helpable" id="TaxAmountLabel">Tax Amount </label>
		</td>
		<td align="left" width="10%">&nbsp;&nbsp;
			<form:input path="productVO.tobaccoVO.taxAmount" maxlength="5" size="5" tabindex="650"
						styleId="taxAmount" id="taxAmount"/>
		</td>
	</tr>
	</table>
</fieldset>

<script type="text/javascript">
	function getTobaccoAttribLists(){
		AddCandidateTemp.getTobaccoAttribLists(getDWRCallbackMethod(populateTobaccoAttribLists));
	}

	function populateTobaccoAttribLists(data){
			var tpt = data.TOB_PROD_TYPES;
			dwr.util.removeAllOptions("tobaccoProdtype");
			dwr.util.addOptions("tobaccoProdtype", tpt, "id", "name");
	}

	YAHOO.util.Event.onDOMReady(getTobaccoAttribLists);
</script>