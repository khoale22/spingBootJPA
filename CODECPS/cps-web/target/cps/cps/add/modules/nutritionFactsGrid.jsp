<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<table style="table-layout: fixed;width:100%">
	<tr>
		<!-- NUTRITION APPROVE PENDING -->
		<c:choose>
			<c:when test ="${addNewCandidate.productVO != null && addNewCandidate.productVO.nutritionFactsVOsApprPending != null && not empty addNewCandidate.productVO.nutritionFactsVOsApprPending}">
				<td id="nutrionPeding" style="border: 1px solid black;vertical-align: top;">			
					<div style="width:100%;overflow-x: scroll;">
					<span style="color: red;font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bold;">PENDING APPROVAL</span>
					<div id="nutritionPendingTbl">
					<table>
						<tr>
							<c:forEach items="${addNewCandidate.productVO.nutritionFactsVOsApprPending}" var="nutritionFactsVO" varStatus="loop" >
								<td style="vertical-align: top;">
									<table><tr><td>
										<div id="ntTable" style="width: 400px; height: 100%;">
											<label style="font-weight: bold;">UPC: </label><c:out value="${nutritionFactsVO.upcKeyFull}"></c:out>
											<br>
											<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="${nutritionFactsVO.source}">
												<span style="font-weight: bold;">Source </span> <c:out value="${nutritionFactsVO.source}"></c:out>
												<c:if test ="${nutritionFactsVO.srcTs ne null && nutritionFactsVO.srcTs ne ''}">
													<span style="font-weight: bold;"> As of </span><c:out value="${nutritionFactsVO.srcTs}"></c:out>
												</c:if>
											</p>								
											<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="${nutritionFactsVO.servingSizeText}">
												<span style="font-weight: bold;">Serving Size </span> <c:out value="${nutritionFactsVO.servingSizeText}"></c:out>
											</p>
											<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="${nutritionFactsVO.servingPerContainer}">
												<span style="font-weight: bold;">Serving Per Container </span> <c:out value="${nutritionFactsVO.servingPerContainer}"></c:out>
											</p>
											<hr>
											<table width="100%" border="0" border="0" cellspacing="0" cellpadding="2" style="table-layout: fixed;">
												<tr>
													<td nowrap width="70%" align="left" align="center" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;text-overflow: ellipsis"
														title="${nutritionFactsVO.amountPerServing}">
														<span style="font-weight: bold;">Amount per Serving </span>
														<c:out value="${nutritionFactsVO.amountPerServing}"></c:out>
													</td>
													<td width="30%" align="left" style="font-weight: bold;font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">Daily Value*</td>
												</tr>
											</table>
											<table width="100%" border="0" id="nutritionTable" border="0" cellspacing="0" cellpadding="2" style="table-layout: fixed;">						
												<tbody id="nutritionTbody">
													<c:if test ="${nutritionFactsVO.nutritionDetailVOs != null && nutritionFactsVO.nutritionDetailVOs != ''}">
														<c:forEach items="${nutritionFactsVO.nutritionDetailVOs}" var="nutritionDetailVO" varStatus="loopDetails" >
															<tr id="countNutrientDetail${countNutrientDetail}"
																class="row${loopDetails.index%2}">
																<td nowrap width="40%" align="left"
																	class="row${loopDetails.index%2}" align="center"
																	style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;text-overflow: ellipsis"
																	title="${nutritionDetailVO.nutritionName}">
																	<c:out value="${nutritionDetailVO.nutritionName}"></c:out>
																</td>
																<td nowrap width="30%" align="left"
																	class="row${loopDetails.index%2}"
																	style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;">
																	<c:out value="${nutritionDetailVO.nutriQuantityAndUOM}"></c:out>
																</td>
																<td nowrap width="30%" align="left"
																	class="row${loopDetails.index%2}"
																	style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;">
																	<c:out value="${nutritionDetailVO.nutriQuantityPercent}"></c:out>
																	<c:if test ="${nutritionDetailVO.nutriQuantityPercent ne null && nutritionDetailVO.nutriQuantityPercent ne ''}">%</c:if>
																</td>
															</tr>
														</c:forEach>
													</c:if>
												</tbody>
											</table>
											<!-- IS Or Container -->
											<c:if test ="${nutritionFactsVO.isOrContainer ne null && nutritionFactsVO.isOrContainer ne ''}">
											<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 5px;margin-bottom: 5px;" title="${nutritionFactsVO.isOrContainer}">
												<span style="font-weight: bold;">IS or Contains: </span> <c:out value="${nutritionFactsVO.isOrContainer}"></c:out>
											</p>
											</c:if>
											<c:if test ="${nutritionFactsVO.isOrContainer eq null || nutritionFactsVO.isOrContainer eq ''}">
												<p style="overflow: hidden;white-space: nowrap;margin-top: 5px;margin-bottom: 5px;"> </p>
											</c:if>
											<hr>
											<!-- Ingredients, Allergens -->
											<label style="font-weight: bold;font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"> *Percentage Daily values are based on a 2,000 calorie diet. Your Daily values may be higher or lower depending on your calorie needs</label>
											<div style="text-align: justify;">
											<span style="font-weight: bold;" title="${nutritionFactsVO.ingredientsList}">Ingredients List: </span><c:out value="${nutritionFactsVO.ingredientsList}"></c:out>
											</div>
											<div style="text-align: justify;">
											<span style="font-weight: bold;">Allergens: </span><c:out value="${nutritionFactsVO.allergens}"></c:out>
											</div>
											<br>&nbsp;<br>&nbsp;
										</div>		
									</td></tr></table>	
								</td>
							</c:forEach>
						</tr>
					</table>
					</div>
					<!-- Nutrion Approval Button -->
					<div id="approveBtnArea" style="width:100%;">
						<table style="width: 100%;">
							<tbody>
				 				<tr> 		
				 					<td width="80%"></td>
									<cps:renderByResourceAccess resourceId="280" honorViewMode="${addNewCandidate.buttonViewOverRide}">
										<jsp:attribute name="EXEC">
											<td width="20%" align="left" id="approveNutriFacts">
												<span class="yui-button yui-push-button"><span class="first-child">
													<button tabindex="670" id="approveBtn" type="button">Approve</button></span>
												</span>
											</td>
										</jsp:attribute>
									</cps:renderByResourceAccess>									
								</tr>
							</tbody>
						</table>
					</div>
					</div>
				</td>
			</c:when>
			<c:otherwise>
				<td id="nutrionPeding" style="border: 1px solid black;vertical-align: top;display: none;">			
					<div style="width:100%;overflow-x: scroll;">
						<span style="color: red;font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bold;">PENDING APPROVAL</span>
						<div id="nutritionPendingTbl">
						<table>
						<tr>
						</tr>
						</table>
						</div>
						<!-- Nutrion Approval Button -->
						<div id="approveBtnArea" style="width:100%;">
							<table style="width: 100%;">
								<tbody>
					 				<tr> 		
					 					<td width="80%"></td>
										<cps:renderByResourceAccess resourceId="280" honorViewMode="${addNewCandidate.buttonViewOverRide}">
											<jsp:attribute name="EXEC">
												<td width="20%" align="left" id="approveNutriFacts">
													<span class="yui-button yui-push-button"><span class="first-child">
														<button tabindex="670" id="approveBtn" type="button">Approve</button></span>
													</span>
												</td>
											</jsp:attribute>
										</cps:renderByResourceAccess>									
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</td>
			</c:otherwise>
		</c:choose>
		<!-- NUTRITION APPROVED -->
		<c:choose>
			<c:when test ="${addNewCandidate.productVO != null && addNewCandidate.productVO.nutritionFactsVOsApproved != null && not empty addNewCandidate.productVO.nutritionFactsVOsApproved}">
				<td id="nutrionApproved" style="vertical-align: top;">			
					<div style="width:100%;overflow-x: scroll;">
					<span style="color: red;font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bold;">&nbsp;</span>
					<div id="nutritionApprTbl">
					<table>
						<tr>
							<c:forEach items="${addNewCandidate.productVO.nutritionFactsVOsApproved}" var="nutritionFactsVO" varStatus="loop" >
								<td style="vertical-align: top;">
									<table><tr><td>
										<div id="ntTable" style="width: 400px; height: 100%;">
											<label style="font-weight: bold;">UPC: </label><c:out value="${nutritionFactsVO.upcKeyFull}"></c:out>
											<br>
											<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="${nutritionFactsVO.source}">
												<span style="font-weight: bold;">Source </span> <c:out value="${nutritionFactsVO.source}"></c:out>
												<c:if test ="${nutritionFactsVO.srcTs ne null && nutritionFactsVO.srcTs ne ''}">
													<span style="font-weight: bold;"> As of </span><c:out value="${nutritionFactsVO.srcTs}"></c:out>
												</c:if>
											</p>								
											<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="${nutritionFactsVO.servingSizeText}">
												<span style="font-weight: bold;">Serving Size </span> <c:out value="${nutritionFactsVO.servingSizeText}"></c:out>
											</p>
											<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 0px;margin-bottom: 0px;" title="${nutritionFactsVO.servingPerContainer}">
												<span style="font-weight: bold;">Serving Per Container </span> <c:out value="${nutritionFactsVO.servingPerContainer}"></c:out>
											</p>
											<hr>
											<table width="100%" border="0" border="0" cellspacing="0" cellpadding="2" style="table-layout: fixed;">
												<tr>
													<td nowrap width="70%" align="left" align="center"
														style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;text-overflow: ellipsis"
														title="${nutritionFactsVO.amountPerServing}"><span style="font-weight: bold;">Amount per Serving </span>
														<bean:write name="nutritionFactsVO" property="amountPerServing"/></td>							
													<td width="30%" align="left" style="font-weight: bold;font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;">Daily Value*</td>
												</tr>
											</table>
											<table width="100%" border="0" id="nutritionTable" border="0" cellspacing="0" cellpadding="2" style="table-layout: fixed;">						
												<tbody id="nutritionTbody">
													<c:if test ="${nutritionFactsVO.nutritionDetailVOs != null && nutritionFactsVO.nutritionDetailVOs != ''}">
														<c:forEach items="${nutritionFactsVO.nutritionDetailVOs}" var="nutritionDetailVO" varStatus="loopDetails" >
															<tr id="countNutrientDetail${countNutrientDetail}"
																class="row${loopDetails.index%2}">
																<td nowrap width="40%" align="left"
																	class="row${loopDetails.index%2}" align="center"
																	style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;text-overflow: ellipsis"
																	title="${nutritionDetailVO.nutritionName}"> 
																	<c:out value="${nutritionDetailVO.nutritionName}"></c:out>
																</td>
																<td nowrap width="30%" align="left"
																	class="row${loopDetails.index%2}"
																	style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;">
																	<c:out value="${nutritionDetailVO.nutriQuantityAndUOM}"></c:out>
																</td>
																<td nowrap width="30%" align="left"
																	class="row${loopDetails.index%2}"
																	style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;overflow: hidden;">
																	<c:out value="${nutritionDetailVO.nutriQuantityPercent}"></c:out>
																	<c:if test ="${nutritionDetailVO.nutriQuantityPercent ne null && nutritionDetailVO.nutriQuantityPercent ne ''}">%</c:if>
																</td>
															</tr>
														</c:forEach>
													</c:if>
												</tbody>
											</table>
											<!-- IS Or Container -->
											<c:if test ="${nutritionFactsVO.isOrContainer ne null && nutritionFactsVO.isOrContainer ne ''}">
											<p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;margin-top: 5px;margin-bottom: 5px;" title="${nutritionFactsVO.isOrContainer}">
												<span style="font-weight: bold;">IS or Contains: </span> <c:out value="${nutritionFactsVO.isOrContainer}"></c:out>
											</p>
											</c:if>
											<c:if test ="${nutritionFactsVO.isOrContainer eq null || nutritionFactsVO.isOrContainer eq ''}">
												<p style="overflow: hidden;white-space: nowrap;margin-top: 5px;margin-bottom: 5px;"> </p>
											</c:if>
											<hr>
											<!-- Ingredients, Allergens -->
											<label style="font-weight: bold;font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"> *Percentage Daily values are based on a 2,000 calorie diet. Your Daily values may be higher or lower depending on your calorie needs</label>
											<div style="text-align: justify;">
											<span style="font-weight: bold;">Ingredients List: </span><c:out value="${nutritionFactsVO.ingredientsList}"></c:out>
											</div>
											<div style="text-align: justify;">
											<span style="font-weight: bold;">Allergens: </span><c:out value="${nutritionFactsVO.allergens}"></c:out>
											</div>
											<br>&nbsp;<br>&nbsp;
										</div>		
									</td></tr></table>	
								</td>
							</c:forEach>
						</tr>
					</table>
					</div>
					<!-- Approvel On, By -->
					<c:choose>
						<c:when test ="${addNewCandidate.productVO != null && addNewCandidate.productVO.onlyScale == false}">
							<div id="approveOnArea" style="width:100%;">
								<table style="width: 100%;">
									<tbody>
						 				<tr> 		
						 					<td width="70%"></td>				 										
											<cps:renderByResourceAccess resourceId="279">
												<jsp:attribute name="EDIT">
													<td width="30%" align="left" id="notifyApproved">
														<label style="font-weight: bold;">Approved By: </label> <label id="approvedBy"><c:out value="${addNewCandidate.productVO.apprByUserName}"></c:out></label><br>
														<label style="font-weight: bold;">Approved On: </label> <label id="approvedOn"><c:out value="${addNewCandidate.productVO.apprDate}"></c:out></label>
													</td>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<td width="30%" align="left" id="notifyApproved">
														<label style="font-weight: bold;">Approved By: </label> <label id="approvedBy"><c:out value="${addNewCandidate.productVO.apprByUserName}"></c:out></label><br>
														<label style="font-weight: bold;">Approved On: </label> <label id="approvedOn"><c:out value="${addNewCandidate.productVO.apprDate}"></c:out></label>
													</td>
												</jsp:attribute>
												<jsp:attribute name="NONE">
													<td width="30%" align="left" id="notifyApproved" style="display: none;position: absolute">
														<label style="font-weight: bold;">Approved By: </label> <label id="approvedBy"><c:out value="${addNewCandidate.productVO.apprByUserName}"></c:out></label><br>
														<label style="font-weight: bold;">Approved On: </label> <label id="approvedOn"><c:out value="${addNewCandidate.productVO.apprDate}"></c:out></label>
													</td>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</tr>
									</tbody>
								</table>
							</div>
						</c:when>
						<c:otherwise>
							<div id="approveOnArea" style="width:100%;display: none;">
								<table style="width: 100%;">
									<tbody>
						 				<tr> 		
						 					<td width="70%"></td>				 										
											<cps:renderByResourceAccess resourceId="279">
												<jsp:attribute name="EDIT">
													<td width="30%" align="left" id="notifyApproved">
														<label style="font-weight: bold;">Approved By: </label> <label id="approvedBy"><c:out value="${addNewCandidate.productVO.apprByUserName}"></c:out></label><br>
														<label style="font-weight: bold;">Approved On: </label> <label id="approvedOn"><c:out value="${addNewCandidate.productVO.apprDate}"></c:out></label>
													</td>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<td width="30%" align="left" id="notifyApproved">
														<label style="font-weight: bold;">Approved By: </label> <label id="approvedBy"><c:out value="${addNewCandidate.productVO.apprByUserName}"></c:out></label><br>
														<label style="font-weight: bold;">Approved On: </label> <label id="approvedOn"><c:out value="${addNewCandidate.productVO.apprDate}"></c:out></label>
													</td>
												</jsp:attribute>
												<jsp:attribute name="NONE">
													<td width="30%" align="left" id="notifyApproved" style="display: none;position: absolute">
														<label style="font-weight: bold;">Approved By: </label> <label id="approvedBy"><c:out value="${addNewCandidate.productVO.apprByUserName}"></c:out></label><br>
														<label style="font-weight: bold;">Approved On: </label> <label id="approvedOn"><c:out value="${addNewCandidate.productVO.apprDate}"></c:out></label>
													</td>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</tr>
									</tbody>
								</table>
							</div>
						</c:otherwise>
					</c:choose>
					</div>
				</td>
			</c:when>
			<c:otherwise>
				<td id="nutrionApproved" style="border: 1px solid black;vertical-align: top;display: none;">			
					<div style="width:100%;overflow-x: scroll;">
						<span style="color: red;font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14px;font-weight: bold;">&nbsp;</span>
						<div id="nutritionApprTbl">
						<table>
						<tr id="nutritionApprTbl">
						</tr>
						</table>
						</div>
						<!-- Approvel On, By -->
						<c:choose>
						<c:when test ="${addNewCandidate.productVO != null && addNewCandidate.productVO.onlyScale == false}">
							<div id="approveOnArea" style="width:100%;">
								<table style="width: 100%;">
									<tbody>
						 				<tr> 		
						 					<td width="70%"></td>				 										
											<cps:renderByResourceAccess resourceId="279">
												<jsp:attribute name="EDIT">
													<td width="30%" align="left" id="notifyApproved">
														<label style="font-weight: bold;">Approved By: </label> <label id="approvedBy"><c:out value="${addNewCandidate.productVO.apprByUserName}"></c:out></label><br>
														<label style="font-weight: bold;">Approved On: </label> <label id="approvedOn"><c:out value="${addNewCandidate.productVO.apprDate}"></c:out></label>
													</td>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<td width="30%" align="left" id="notifyApproved">
														<label style="font-weight: bold;">Approved By: </label> <label id="approvedBy"><c:out value="${addNewCandidate.productVO.apprByUserName}"></c:out></label><br>
														<label style="font-weight: bold;">Approved On: </label> <label id="approvedOn"><c:out value="${addNewCandidate.productVO.apprDate}"></c:out></label>
													</td>
												</jsp:attribute>
												<jsp:attribute name="NONE">
													<td width="30%" align="left" id="notifyApproved" style="display: none;position: absolute">
														<label style="font-weight: bold;">Approved By: </label> <label id="approvedBy"><c:out value="${addNewCandidate.productVO.apprByUserName}"></c:out></label><br>
														<label style="font-weight: bold;">Approved On: </label> <label id="approvedOn"><c:out value="${addNewCandidate.productVO.apprDate}"></c:out></label>
													</td>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</tr>
									</tbody>
								</table>
							</div>
						</c:when>
						<c:otherwise>
							<div id="approveOnArea" style="width:100%;display: none;">
								<table style="width: 100%;">
									<tbody>
						 				<tr> 		
						 					<td width="70%"></td>				 										
											<cps:renderByResourceAccess resourceId="279">
												<jsp:attribute name="EDIT">
													<td width="30%" align="left" id="notifyApproved">
														<label style="font-weight: bold;">Approved By: </label> <label id="approvedBy"><c:out value="${addNewCandidate.productVO.apprByUserName}"></c:out></label><br>
														<label style="font-weight: bold;">Approved On: </label> <label id="approvedOn"><c:out value="${addNewCandidate.productVO.apprDate}"></c:out></label>
													</td>
												</jsp:attribute>
												<jsp:attribute name="VIEW">
													<td width="30%" align="left" id="notifyApproved">
														<label style="font-weight: bold;">Approved By: </label> <label id="approvedBy"><c:out value="${addNewCandidate.productVO.apprByUserName}"></c:out></label><br>
														<label style="font-weight: bold;">Approved On: </label> <label id="approvedOn"><c:out value="${addNewCandidate.productVO.apprDate}"></c:out></label>
													</td>
												</jsp:attribute>
												<jsp:attribute name="NONE">
													<td width="30%" align="left" id="notifyApproved" style="display: none;position: absolute">
														<label style="font-weight: bold;">Approved By: </label> <label id="approvedBy"><c:out value="${addNewCandidate.productVO.apprByUserName}"></c:out></label><br>
														<label style="font-weight: bold;">Approved On: </label> <label id="approvedOn"><c:out value="${addNewCandidate.productVO.apprDate}"></c:out></label>
													</td>
												</jsp:attribute>
											</cps:renderByResourceAccess>
										</tr>
									</tbody>
								</table>
							</div>
						</c:otherwise>
					</c:choose>
					</div>
				</td>
			</c:otherwise>
		</c:choose>
	</tr>
</table>
		