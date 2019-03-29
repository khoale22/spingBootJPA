<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<%@ page import="com.heb.operations.cps.model.ManageProduct"%>

<c:set var="index" value="1" />
<c:set var="lst" value="${manageProduct.messages}"></c:set>
<div id="errorAjax">
	<c:forEach var="msg" items="${lst}" varStatus="rowCounter">
		<c:set var="index" value="${index+1}" />
		<c:choose>
			<c:when test="${msg.errorSeverity.errorSeverityValue == 4}">
				<input type="hidden" id="msgError" value="${msg.message}"
					name="msgError" />
				<input type="hidden" id="msgIndex"
					value="${msg.errorSeverity.errorSeverityValue}" name="msgIndex" />
			</c:when>
			<c:when test="${msg.errorSeverity.errorSeverityValue == 3}">
				<input type="hidden" id="msgError" value="${msg.message}"
					name="msgError" />
				<input type="hidden" id="msgIndex"
					value="${msg.errorSeverity.errorSeverityValue}" name="msgIndex" />
			</c:when>
			<c:when test="${msg.errorSeverity.errorSeverityValue == 2}">
				<input type="hidden" id="msgError" value="${msg.message}"
					name="msgError" />
				<input type="hidden" id="msgIndex"
					value="${msg.errorSeverity.errorSeverityValue}" name="msgIndex" />
			</c:when>
			<c:when test="${msg.errorSeverity.errorSeverityValue == 1}">
				<input type="hidden" id="msgError" value="${msg.message}"
					name="msgError" />
				<input type="hidden" id="msgIndex"
					value="${msg.errorSeverity.errorSeverityValue}" name="msgIndex" />
			</c:when>
		</c:choose>
	</c:forEach>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="dataGrid" bordercolor=red>
	<c:forEach items="${manageProduct.productsTemp}" var="product" varStatus="loop">
		<c:url value="/protected/cps/add/prodAndUpc?${_csrf.parameterName}=${_csrf.token}" var="pageSrc" />
		<tr id="row${product.productId}"
			ondblclick="modifyDblClick('${product.productId}','${product.mrtLabel}');">
			<td class="row${loop.index%2}" align="left" width="3%">
				<input type="hidden" id="hiddProdId${loop.index}" value="${product.productId}" />
				<input type="hidden" id="hiddProdIdItmTypCd${loop.index}" value="${product.itemTypCd}" />
				<input type="hidden" id="hiddActiveProductKit${loop.index}" value="${product.activeProductKit}"/>
				<input type="hidden" id="hiddUnitUpc${loop.index}" value="${product.unitUPC}"/>
				<input type="hidden" id="hiddMrtLabel${loop.index}" value="${product.mrtLabel}" />
				<input type="checkbox" id="check" name="candSelectCheck"
					onclick="selectSingleProduct('${product.productId}','${loop.index}')"></td>
			<td class="row${loop.index%2}" align="left" width="18%"><c:out
					value="${product.vendorDesc}" /></td>
			<td class="row${loop.index%2}" align="left" width="9%"><c:out
					value="${product.unitUPC}" /></td>
			<td class="row${loop.index%2}" align="left" width="21%"><c:out
					value="${product.productDesc}" /></td>
			<!--<td  class="row${loop.index%2}"  align="left" width="15%">
			<bean:write name="product" property="pressDate"/></td> -->
			<td class="row${loop.index%2}" width="12%"><span
				style="margin-left: 6px"> <c:out
						value="${product.activationDate}" /></span></td>
			<td class="row${loop.index%2}" width="13%"><c:out
					value="${product.itemCode}" /></td>
			<td class="row${loop.index%2}" align="left" width="11%"><c:out
					value="${product.mrtLabel}" /></td>
			<td class="row${loop.index%2}" align="left" width="10%"></td>
		</tr>
		<input type="hidden" id="upcDSV" value="${product.unitUPC}" />
	</c:forEach>
</table>

