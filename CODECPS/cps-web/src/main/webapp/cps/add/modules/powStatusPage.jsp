<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>

<form:form id="powStatusForm" action="/protected/cps/add" name="powStatusForm"
		   enctype="multipart/form-data" modelAttribute="addNewCandidate">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

	<script type="text/javascript">
        <c:url value="/protected/AttachmentViewServlet" var="attachmentView" />
	</script>

	<div id="all">
		<fieldset style="width: 80%; margin-left: 40px; vertical-align: middle;" id="f1">
			<legend>User Comments</legend>
			<br>
			<table width="100%" border="0" bordercolor="red">
				<tr>
					<td width="50%">
0						<table width="100%" border="0" cellspacing="0" bordercolor="red">
							<tr>
								<td width="12%" align="center" class="dataGridHead">Name</td>
								<td width="16%" align="center" class="dataGridHead">Date</td>
								<td width="16%" align="center" class="dataGridHead">Comments</td>
							</tr>
							<c:forEach items="${addNewCandidate.productVO.commentsVO}" var="comments" varStatus="loop">
								<tr class="labelFont">
									<td align="left" width="1%" class="row${loop.index %2}">
										<input type="hidden" name="selectedUniqueId" id="selectedUniqueId${loop.index}"
											   value="${comments.uniqueId}">
										<input type="hidden" name="visibilitySw" id="visibilitySw${loop.index}"
											   value="${comments.vendorVisibilitySw}">
										<font class="labelFont">
											<a href="javascript:return false;"
											   onclick="showComments('${comments.uniqueId}');return false;">
												<c:out value="${comments.user}"></c:out>
											</a>
										</font>
									</td>
									<td align="left" width="15%" class="row${loop.index}">
										<font class="labelFont">
											<c:out value="${comments.date}"></c:out>
										</font>
									</td>
									<td align="left" width="15%" class="row${loop.index}">
										<font class="labelFont">
											<c:out value="${comments.comments}"></c:out>
										</font>
									</td>
								</tr>
							</c:forEach>
						</table>
					</td>
					<td width="50%">
						<table width="100%" border="0" bordercolor="red" height="40%">
							<tr>
								<td colspan="2">
									<table width="60%">
										<tr>
											<td align="left" width="10%">
												<cps:renderByResourceAccess resourceId="217">
													<jsp:attribute name="EDIT">
														<form:checkbox path="productVO.classificationVO.vendorVisibilitySw"
																	   styleId="visSw" id="visSw" tabindex="7" />
													</jsp:attribute>
												</cps:renderByResourceAccess>
											</td>
											<td width="50%"><cps:renderByResourceAccess resourceId="217">
												<jsp:attribute name="EDIT">
													<label class="labelHead">VISIBLE TO VENDOR</label>
												</jsp:attribute>
											</cps:renderByResourceAccess>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="3" width="100%" align="right">
									<form:textarea path="productVO.classificationVO.userComments" id="userComments"
												  cssClass="textArea" tabindex="8"
												   onblur="validateUserComments()" disabled="true"/>
								</td>
							</tr>
							<tr>
								<td width="50%"></td>
								<td width="25%" align="left">
									<cps:renderByResourceAccess  resourceId="218" honorViewMode="${addNewCandidate.buttonViewOverRide}">
										<jsp:attribute name="EXEC">
											<button type="button" id="addComments" name="addComments" value="Addcomments">Add Comments</button>
										</jsp:attribute>
									</cps:renderByResourceAccess>
								</td>
								<td width="25%" align="left">
									<div id="saveCommentsDiv" style="visibility: hidden; position: absolute;">
										<button type="button" id="saveComments" name="saveComments" value="Savecomments">Save Comments</button>
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br/>
		</fieldset>
		<!--  Kingshuk Added Section for Attachments  -->
		<fieldset style="width: 80%; margin-left: 40px; height: 150px; vertical-align: middle;" id="f1">
			<legend>Attachments</legend>
			<br>
			<table width="100%" border="0" bordercolor="red">
				<tr>
					<td width="75%">
						<div style="position: relative;overflow-y:auto; height: 120px;min-width: 0;">
							<table width="100%" border="0" cellspacing="0" bordercolor="red">
								<tr>
									<td width="12%" align="center" class="dataGridHead">Existing Attachments</td>
									<td width="16%" align="center" class="dataGridHead">Type of document</td>
									<td width="8%" colspan="2" align="center" class="dataGridHead">Actions</td>
								</tr>
								<c:forEach items="${addNewCandidate.productVO.attachmentVO}" var="attachment" varStatus="loop">
									<tr class="labelFont">
										<td align="left" width="1%" class="row${loop.index %2}">
											<input type="hidden" name="seqNbr" id="selectedUniqueId${loop.index}"
												   value="${attachment.seqNbr}">
											<font class="labelFont">
												<c:out value="${attachment.uiFileNm}"></c:out>
											</font>
										</td>
										<td align="center">
											<font class="labelFont">
												<c:out value="${attachment.typeDocumentDes}"></c:out>
											</font>
										</td>
										<td>
											<a 	target="new" href="${attachmentView}?storedFileNm=${attachment.storedFileNm}&storedFileType=${attachment.seqNbr}&uiFileNm=${attachment.uiFileNm}&clipId=${attachment.clipId}">
												<font class="labelFont">View </font>
											</a>
										</td>
										<c:if test="${!addNewCandidate.viewMode || addNewCandidate.upcAdded}">
											<td>
												<a href="javascript:deleteAttachment('${attachment.storedFileNm}','${attachment.typeDocument}');">
													<font class="labelFont">Delete </font>
												</a>
											</td>
										</c:if>
									</tr>
								</c:forEach>
								<tr>
									<td width="40%" align="center" class="row0" >
										<cps:renderByResourceAccess	resourceId="224" honorViewMode="${addNewCandidate.buttonViewOverRide}">
											<jsp:attribute name="EXEC">
												<input name="theFile" id="fileName" type="file" styleId="fileName"/>
												<%--<html:file property="theFile"  styleId="fileName"/>--%>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td width="30%" align="center" class="row0">
										<cps:renderByResourceAccess	resourceId="220" honorViewMode="${addNewCandidate.buttonViewOverRide}">
											<jsp:attribute name="EXEC">
												<label class="labelFont"> Type of document </label>
												<form:select path="typeDocument" styleId="typeDocumentId" id="typeDocumentId">
													<form:options items="${addNewCandidate.docCatList}" itemLabel="name" itemValue="id" />
												</form:select>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td width="10%" align="center" class="row0">
										<cps:renderByResourceAccess	resourceId="220" honorViewMode="${addNewCandidate.buttonViewOverRide}">
											<jsp:attribute name="EXEC">
												<button id="fileUpload" name="fileUpload" value="Upload">Attach</button>
											</jsp:attribute>
										</cps:renderByResourceAccess>
									</td>
									<td width="20%" align="center" class="row0"></td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
			<input type="hidden" name="storedFileNm" id="storedFileNm">
			<input type="hidden" name="typeDocumentHd" id="typeDocumentHd">
			<br />
		</fieldset>
		<!--  Kingshuk End Addition Section for Attachments -->

		<fieldset style="width: 80%; margin-left: 40px; height: 200px; vertical-align: middle;" id="f1">
			<legend>Status History</legend> <br>
			<table width="100%" border="0" bordercolor="red">
				<tr>
					<td width="75%">
						<table width="100%" border="0" cellspacing="0" bordercolor="red">
							<tr>
								<td width="1%" align="center" class="dataGridHead"></td>
								<td width="12%" align="center" class="dataGridHead">Modified User Name</td>
								<td width="16%" align="center" class="dataGridHead">Status</td>
								<td width="14%" align="center" class="dataGridHead">Modified Date</td>
							</tr>
							<c:forEach items="${addNewCandidate.auditTrail}" var="auth" varStatus="loop">
								<tr id="caseRow${loop.index}" nmouseover="colorChangeRow('caseRow${loop.index}','white');"
									onclick="makeRowClicked('caseRow${loop.index}','${loop.index}','#FEEADA');"
									onmouseout="colorChangeRow('caseRow${loop.index}','#FFF9F4');">
									<td width="1%" class="row0" align="center"></td>
									<td width="12%" align="center" class="row0">
										<input type="hidden" id="taskID${loop.index}" value="${auth.userId}"/>
										<c:out value="${auth.userId}"></c:out>
									</td>
									<td width="16%" align="center" class="row0" align="center">
										<input type="hidden" id="assignedToVal${loop.index}" value="${auth.statusCode}"/>
										<c:out value="${auth.statusCode}"></c:out>
									</td>
									<td width="14%" align="center" class="row0">
										<font class="labelFont">
											<input type="hidden" id="statusVal${loop.index}"
												   value="${auth.recordCreationTimestamp}"/>
											<c:out value="${auth.recordCreationTimestamp}"></c:out>
										</font>
									</td>
								</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
			</table>
			<br />
		</fieldset>
	</div>
	<br />
	<br />
</form:form>

<script type="text/javascript">
    var oPushButton1 = new YAHOO.widget.Button("addComments");
    var oPushButton2 = new YAHOO.widget.Button("saveComments");
    var oPushButton3 = new YAHOO.widget.Button("fileUpload");

    <c:url value="/protected/cps/add/prodAndUpc?${_csrf.parameterName}=${_csrf.token}" var="pageLink" />

    function showProd(evt) {
        document.powStatusForm.action = "${pageLink}";
        document.powStatusForm.submit();
    }

    var clickedRow = null;
    var mouseOver = null;
    var mouseOut = null;

    function colorChangeRow(bodyId, color){
        var trow = document.getElementById(bodyId);
        var i=0;
        for(i=0;i<trow.cells.length;i++){
            trow.cells[i].style.backgroundColor = color;
        }
    }
    function makeRowClicked(bodyId,count,  color){
        if(clickedRow != null){
            colorChangeRow(clickedRow, '#FFF9F4');
            document.getElementById(clickedRow).onmouseover = mouseOver;
            document.getElementById(clickedRow).onmouseout = mouseOut;
        }
        colorChangeRow(bodyId, color);
        clickedRow = bodyId;
        mouseOver = document.getElementById(clickedRow).onmouseover;
        mouseOut = document.getElementById(clickedRow).onmouseout;
        document.getElementById(clickedRow).onmouseover = '';
        document.getElementById(clickedRow).onmouseout = '';
        //document.getElementById('rad'+count).checked = true;
        //displayDetails(count);
    }

    function reloadAuthAndDist(){
        YAHOO.util.Event.onDOMReady(init);
    }

    function init(){
        document.getElementById('all').style.visibility = 'visible';
        document.getElementById('f1').style.visibility = 'visible';
        document.getElementById('details').style.visibility = 'visible';
        document.getElementById('f2').style.visibility = 'visible';
        document.getElementById('tabs').style.visibility = 'visible';
    }

    function selectPageAuth(num){
        var tab1;
        var tab2;
        var tab3;
        if(num == 1){
            tab1 = 'tab1';tab2 = 'tab2';tab3 = 'tab3';
        }else if (num == 2){
            tab1 = 'tab2';tab2 = 'tab3';tab3 = 'tab1';
        }else if (num == 3){
            tab1 = 'tab3';tab2 = 'tab1';tab3 = 'tab2';
        }
        document.getElementById(tab2).style.visibility = 'hidden';
        document.getElementById(tab2).style.position = 'absolute';
        document.getElementById(tab2).style.display = 'none';

        document.getElementById(tab3).style.visibility = 'hidden';
        document.getElementById(tab3).style.position = 'absolute';
        document.getElementById(tab3).style.display = 'none';

        document.getElementById(tab1).style.visibility = 'visible';
        document.getElementById(tab1).style.position = 'relative';
        document.getElementById(tab1).style.display = 'block';
		//	document.body.scroll = 'no';
    }

    function showProd(evt) {
        document.powStatusForm.action = "${pageLink}";
        document.powStatusForm.submit();
    }

    function showComments(id){
        var id = id;
        AddCandidateTemp.getCommentsFromVO(id, getDWRCallbackMethod(updateComments));
    }

    function updateComments(data){
        document.getElementById('userComments').value = data;
    }

    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("addComments"), "click", addComments);
    function addComments(){
        saveCommentsDiv.style.visibility = 'visible';
        saveCommentsDiv.style.position = 'static';
        document.getElementById('userComments').disabled = false;
    }

    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveComments"), "click", saveComments);
    <c:url value="/protected/cps/add/saveComments?${_csrf.parameterName}=${_csrf.token}" var="comments" />

    function saveComments(){
        var comments = YAHOO.util.Dom.get('userComments').value;
        if(comments.length > 255){
            alert('User Comments field is longer than 255 characters');
            YAHOO.util.Dom.get('userComments').value = "";
            return false;
        }

        var switchFalg = false;
        if(document.getElementById("visSw")){
            if(document.getElementById("visSw").checked)
                switchFalg = true;
        }
        document.powStatusForm.action = "${comments}"+'&selectedSwitch='+switchFalg;
        document.powStatusForm.submit();
    }

    function validateUserComments() {
        var comments = YAHOO.util.Dom.get('userComments').value;
        if(comments.length > 255){
            alert('User Comments field should not be longer than 255 characters');
            YAHOO.util.Dom.get('userComments').value = "";
            return false;
        }
    }

    <!--  Kingshuk Added Section for Attachments  -->

    YAHOO.util.Event.addListener(YAHOO.util.Dom.get("fileUpload"), "click", fileUpload);
    <c:url value="/protected/cps/add/fileUpload?${_csrf.parameterName}=${_csrf.token}" var="fileUpload" />
    function fileUpload(){
        var path = document.getElementById('fileName').value;
        var typeDocumentId = document.getElementById('typeDocumentId').value;
        if (YAHOO.env.ua.ie > 0) {
            if (path.indexOf(":\\") != 1 || path.lastIndexOf(".") == -1)
            {
                alert("Please enter the correct path and name of the file that you want to upload.");
            } else 	if(path.indexOf(".exe")!=-1) {
                alert("Please choose an another file.");
            } else if(typeDocumentId.length == 0){
                alert("Please select type of document.");
            } else {
                showProgress();
                document.powStatusForm.action = "${fileUpload}"; // Set Action to File Upload
                document.powStatusForm.submit();
            }
        }
    }

    <!-- View File Atachment -->
    <c:url value="/protected/cps/add/deleteAttachment?${_csrf.parameterName}=${_csrf.token}" var="fileDelete" />
    function deleteAttachment(storedFileNm1,typeDocument){
        document.powStatusForm.storedFileNm.value=storedFileNm1;
        document.powStatusForm.typeDocumentHd.value=typeDocument;
        document.powStatusForm.action = "${fileDelete}"; // Set Action to File View
        document.powStatusForm.submit();
    }
    <!--  End Kingshuk Added Section for Attachments  -->
    if (document.all)
    {
        document.onkeydown = function ()
        {
            var key_f5 = 116; // 116 = F5
            if (key_f5==event.keyCode)
            {
                event.keyCode = 27;
                return false;
            }
        }
    }
</script>