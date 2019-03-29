<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags" %>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- 	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">	 -->
</head>
<style type="text/css">
	#panel1{
		/* top:100px !important; */
	}
	/* Skin default elements */
	#panel1_c.yui-panel-container.shadow .underlay {
		left:1px;
		right:-1px;
		top:1px;
		bottom:-1px;
		position:absolute;
		background-color:#000;
		opacity:0.12;
		filter:alpha(opacity=12);
	}

	/* Apply the border to the right side */
	#panel1.yui-panel {
		border:none;
		overflow:visible;
		background:transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat top right;
	}

	/* Style the close icon */
	#panel1.yui-panel .container-close {
		position:absolute;
		top:5px;
		right:8px;
		height:21px;
		width:21px;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
	}

	/* Style the header with its associated corners */
	#panel1.yui-panel .hd {
		padding:0;
		border:none;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-hd.gif) repeat-x;
		color:#FFF;
		height:30px;
		margin-left:0px;
		margin-right:0px;
		text-align:left;
		vertical-align:middle;
		overflow:visible;
	}

	/* Style the body with the left border */
	#panel1.yui-panel .bd {
		overflow:visible;
		padding:10px;
		border:none;
		background:#FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y; 
		margin:0 4px 0 0;
	}

	/* Style the footer with the bottom corner images */
	#panel1.yui-panel .ft {
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
		font-size:11px;
		height:26px;
		padding:0px 10px;
		border:none
	}

	/* Skin custom elements */
	#panel1.yui-panel .hd span {
		line-height:30px;
		vertical-align:middle;
		font-weight:bold;
	}
	#panel1.yui-panel .hd .tl {
		width:8px;
		height:29px;
		top:1px;
		left:0px;
		background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
		position:absolute;
	}
	
	#panel1.yui-panel .hd .closeMe {
		position:absolute;
		top:5px;
		right:8px;
		height:21px;
		width:21px;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat; 		
	}
	
	#panel1.yui-panel .hd .tr {
		width:8px;
		height:29px;
		top:1px;
		right:0;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat; 
		position:absolute;
	}

	#panel1.yui-panel .ft span {
		line-height:22px;
		vertical-align:middle;
	}
	#panel1.yui-panel .ft .bl {
		width:8px;
		height:26px;
		bottom:0;
		left:0;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
		position:absolute;
	}
	#panel1.yui-panel .ft .br {
		width:8px;
		height:26px;
		bottom:0;
		right:0;
		background:url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
		position:absolute;
	}
</style>
<body>	
<div id="containerFunction">
<table id="tblFunction" align="right">
	<tr>		
		<td>
			<div id='divCandidatePriv' align = "right" style="positon : absolute;padding-right: 10px">
				<cps:renderByResourceAccess resourceId="161" honorViewMode="">
					<jsp:attribute name="EXEC">
						<input type ="button" id="rejectCommentBut" name="rejectCommentBut" value="Reject Comments"/>												
					</jsp:attribute>
				</cps:renderByResourceAccess>
				
				<cps:renderByResourceAccess resourceId="234" honorViewMode="">
					<jsp:attribute name="EXEC">
						<input type ="button" id="printFormBut" name="printFormBut" value="Print Form"/>						
					</jsp:attribute>
				</cps:renderByResourceAccess>
				
				<cps:renderByResourceAccess resourceId="205" honorViewMode="">
					<jsp:attribute name="EXEC">
						<input type ="button" id="printSumBut" name="printSumBut" value="Print Summary"/>						
					</jsp:attribute>
				</cps:renderByResourceAccess>
				
				<cps:renderByResourceAccess resourceId="206" honorViewMode="">
					<jsp:attribute name="EXEC">
						<input type ="button" id ="viewSumBut" name="viewSumBut" value="View"/>						
					</jsp:attribute>
				</cps:renderByResourceAccess>
				
				<cps:renderByResourceAccess resourceId="164" honorViewMode="">
					<jsp:attribute name="EXEC">
						<input type ="button" id="modifySumBut" name="modifySumBut" value="Modify"/>						
					</jsp:attribute>
				</cps:renderByResourceAccess>
				
				<cps:renderByResourceAccess resourceId="162" honorViewMode="">
					<jsp:attribute name="EXEC">
						<input type ="button" id="testScanSumBut" name="testScanSumBut" value="Test Scan"/>						
					</jsp:attribute>
				</cps:renderByResourceAccess>
								
				<input type="button" id="resetSumBut" value='Reset' />
				
				<cps:renderByResourceAccess resourceId="158" honorViewMode="">
					<jsp:attribute name="EXEC">
						<input type ="button" id="saveSumBut" name="saveSumBut" value="Save"/>															
					</jsp:attribute>
				</cps:renderByResourceAccess>
		
				
				
				<input type="button" id="nextSumBut" value='Next'/>
				
				<cps:renderByResourceAccess resourceId="161" honorViewMode="">
					<jsp:attribute name="EXEC">
						<input type ="button" id="rejectSumBut" name="rejectSumBut" value="Reject"/>						
					</jsp:attribute>
				</cps:renderByResourceAccess>
				
				<cps:renderByResourceAccess resourceId="281" honorViewMode="">
 					<jsp:attribute name="EXEC">
 						<input type ="button" id="deleteSumBut" name="deleteSumBut" value="Delete"/>						
 					</jsp:attribute>
 				</cps:renderByResourceAccess>
 				
				<cps:renderByResourceAccess resourceId="160" honorViewMode="">
					<jsp:attribute name="EXEC">
						<input type ="button" id="activeSumBut" name="activeSumBut" value="Activate"/>						
					</jsp:attribute>
				</cps:renderByResourceAccess>
			</div>	
			<div id='divProductPriv' style="display:none;">
				<cps:renderByResourceAccess resourceId="205" honorViewMode="">
					<jsp:attribute name="EXEC">
						<input type ="button" id="printSumButActvie" name="printSumButActvie" value="Print Summary"/>						
					</jsp:attribute>
				</cps:renderByResourceAccess>
				
				<cps:renderByResourceAccess resourceId="227" honorViewMode="">
					<jsp:attribute name="EXEC">
						<input type ="button" id ="viewSumButActvie" name="viewSumBut" value="View"/>															
					</jsp:attribute>
				</cps:renderByResourceAccess>
				
				<cps:renderByResourceAccess resourceId="229" honorViewMode="">
					<jsp:attribute name="EXEC">
						<input type ="button" id ="modifySumButActive" name="modifySumBut" value="Modify"/>						
					</jsp:attribute>
				</cps:renderByResourceAccess>
				<input type="button" id="nextSumButActive" value='Next'/>
			</div>
		</td>		
	</tr>
</table>
</div>
<script type="text/javascript">
	var currentTab=1;
	<c:if test="${not empty ManageEDICandidate.currentTab}">
		<c:if test="${ManageEDICandidate.currentTab=='sellingUpctab'}">
			currentTab=1;
		</c:if>
		<c:if test="${ManageEDICandidate.currentTab=='descriptionAndSizeTab'}">
			currentTab=2;
		</c:if>
		<c:if test="${ManageEDICandidate.currentTab=='casePackTab'}">
			currentTab=3;
		</c:if>
		<c:if test="${ManageEDICandidate.currentTab=='costAndRetailTab'}">
			currentTab=4;
		</c:if>
		<c:if test="${ManageEDICandidate.currentTab=='otherAttributeTab'}">
		currentTab=5;
		</c:if>
		<c:if test="${ManageEDICandidate.currentTab=='authorizationAndDistributionTab'}">
			currentTab=6;
			//disabled button Next
			if(YAHOO.util.Dom.get("nextSumBut") != null)
			{
				YAHOO.util.Dom.get("nextSumBut").disabled = true;
				YAHOO.util.Dom.get("nextSumButActive").disabled = true;
			}

		</c:if>
	</c:if>
	<%--<logic:present name="CPSEDIMain"  property="currentTab" >		--%>
		<%--<c:if test="${CPSEDIMain.currentTab=='sellingUpctab'}">--%>
			<%--currentTab=1;--%>
		<%--</c:if>--%>
	<%--</logic:present >--%>

	<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
		<%--<c:if test="${CPSEDIMain.currentTab=='descriptionAndSizeTab'}">--%>
			<%--currentTab=2;--%>
		<%--</c:if>--%>
	<%--</logic:present >--%>

<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
	<%--<c:if test="${CPSEDIMain.currentTab=='casePackTab'}">--%>
		<%--currentTab=3;--%>
	<%--</c:if>--%>
<%--</logic:present >--%>

<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
	<%--<c:if test="${CPSEDIMain.currentTab=='costAndRetailTab'}">--%>
		<%--currentTab=4;	--%>
	<%--</c:if>--%>
<%--</logic:present >--%>

<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
	<%--<c:if test="${CPSEDIMain.currentTab=='otherAttributeTab'}">--%>
		<%--currentTab=5;	--%>
	<%--</c:if>--%>
<%--</logic:present >--%>

<%--<logic:present name="CPSEDIMain"  property="currentTab" >--%>
	<%--<c:if test="${CPSEDIMain.currentTab=='authorizationAndDistributionTab'}">--%>
		<%--currentTab=6;--%>
		<%--//disabled button Next--%>
		<%--if(YAHOO.util.Dom.get("nextSumBut") != null)--%>
			<%--{--%>
				<%--YAHOO.util.Dom.get("nextSumBut").disabled = true;--%>
				<%--YAHOO.util.Dom.get("nextSumButActive").disabled = true;--%>
			<%--}	--%>
		<%----%>
	<%--</c:if>--%>
<%--</logic:present >--%>


	/*==============BEGIN VISIBLE BUTTON WHEN DISPLAY SEARCH ACTIVE EDI====================*/	
			<c:if test="${ManageEDICandidate.candidateEDISearchCriteria.actionId == '5'}">
					document.getElementById("divProductPriv").style.display = "block";
					document.getElementById("divCandidatePriv").style.display = "none";
					
			</c:if>	
			<c:if test="${ManageEDICandidate.candidateEDISearchCriteria.actionId != '5'}">
					document.getElementById("divProductPriv").style.display = "none";
					document.getElementById("divCandidatePriv").style.display = "block";
					
			</c:if>	
	/*==============END VISIBLE BUTTON WHEN DISPLAY SEARCH ACTIVE EDI====================*/
	new YAHOO.widget.Button("rejectCommentBut"); 
	new YAHOO.widget.Button("resetSumBut"); 	
	new YAHOO.widget.Button("saveSumBut");
	
	new YAHOO.widget.Button("viewSumBut"); 
	new YAHOO.widget.Button("modifySumBut"); 	
	new YAHOO.widget.Button("testScanSumBut");
	new YAHOO.widget.Button("rejectSumBut"); 	
 	new YAHOO.widget.Button("deleteSumBut");
	new YAHOO.widget.Button("activeSumBut");
	new YAHOO.widget.Button("printSumBut");
	new YAHOO.widget.Button("printFormBut");
	
	new YAHOO.widget.Button("printSumButActvie"); 
	new YAHOO.widget.Button("viewSumButActvie"); 
	new YAHOO.widget.Button("modifySumButActive"); 	
		
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("rejectCommentBut"), "click", rejectComment);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("resetSumBut"), "click", resetCurrentTab);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("saveSumBut"), "click", saveMultiSection);		  
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("printSumBut"), "click", printSummary);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifySumBut"), "click", modify); 
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("viewSumBut"), "click", view);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("testScanSumBut"), "click", testScan);	 
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("printFormBut"), "click", printFormPopUp);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("activeSumBut"), "click", activeCandidateEDI);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("rejectSumBut"), "click", reject);
 	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("deleteSumBut"), "click", deleteEdi);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("printSumButActvie"), "click", printSummary); 
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("modifySumButActive"), "click", modify); 
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("viewSumButActvie"), "click", view);
	
	
	
	
	//*****************SAVE*********************
	function saveMultiSection(evt)
	{
		//set result filter
		setResultFilter();				
		if(currentTab==1)
		{		
			var isHaveCheck=false;			
			var arrPsProdIdCheck = "";							
			for(var i=0;i < Ex.dataSourceTemp.length;i++)
			{
					
				var comp = YAHOO.lang;
				var cK=Ex.dataSourceTemp[i].checkBox;									
				if(comp.trim(Ex.dataSourceTemp[i].subComHidden)!="0" || comp.trim(Ex.dataSourceTemp[i].taxCatHidden)!="0")
				{
							isHaveCheck=true;
							var objSave=new Object();
							var bSplit = cK.split("+");												
							var temp=bSplit[1].split("type");						 
							var idRow=comp.trim(temp[0]);
							//get id to get Ps work id and psProdId
							var arrMainValue=idRow.split("__");								
							arrPsProdIdCheck = arrPsProdIdCheck+arrMainValue[1] + ",";																						
				}					
			}									
				//call back function call submit form to save
			if(arrPsProdIdCheck !=""){
				arrPsProdIdCheck = arrPsProdIdCheck.substr(0,arrPsProdIdCheck.lastIndexOf(','));
				showProgress();				 
				ManageEDIDWR.checkMultilPluReuseEDI(arrPsProdIdCheck,getDWRCallbackMethod(saveSellingUpcBack));		
			}							
		}
		
		if(currentTab==5)
		{
			saveOtherAttributeTab(false);
		}
		if(currentTab==2)
		{
			saveDescriptionAndSizeTab(false);
		}
		if(currentTab==4)
		{
			updateDataCostAndRetail(false);
		}
		if(currentTab==3)
		{
			saveCasePackTab();
		}
	};
	function saveSellingUpcBack(data){
		if(data!='' && data == true){		
			alert('PLU(s) tied to a vendor candidate/working candidate/ an existing product. \nThis candidate cannot be modified.');	
			hideProgress();	
		} else {
			var isHaveCheck=false;
			var arrPsWorkId="";
			var arrPsProdId="";
			var arrPsSubcom="";	
			
			var arrPsTaxWorkId="";
			var arrPsTaxProdId="";
			var arrPsTaxCat="";	
			for(var i=0;i < Ex.dataSourceTemp.length;i++)
			{
					
				var comp = YAHOO.lang;
				var cK=Ex.dataSourceTemp[i].checkBox;									
				if(comp.trim(Ex.dataSourceTemp[i].subComHidden)!="0")
				{
							isHaveCheck=true;
							var objSave=new Object();
							var bSplit = cK.split("+");												
							var temp=bSplit[1].split("type");						 
							var idRow=comp.trim(temp[0]);
							//get id to get Ps work id and psProdId
							var arrMainValue=idRow.split("__");	
							if(arrPsWorkId == "")
							{
								arrPsWorkId+=arrMainValue[0];									
							}
							else
							{
								arrPsWorkId+="__"+arrMainValue[0];									
							}	

							if(arrPsProdId == "")
							{									
								arrPsProdId+=arrMainValue[1];
								
							}
							else
							{									
								arrPsProdId+="__"+arrMainValue[1];									
							}																							
							
							if(arrPsSubcom == "")
							{									
								arrPsSubcom+=Ex.dataSourceTemp[i].subComHidden;									
							}
							else
							{									
								arrPsSubcom+="__"+Ex.dataSourceTemp[i].subComHidden;								
							}																										
					}		
				//BINHHT --add
				if(comp.trim(Ex.dataSourceTemp[i].taxCatHidden)!="0")
				{
						isHaveCheck=true;
						var objSave=new Object();
						var idRow =comp.trim(Ex.dataSourceTemp[i].idRowHidden);	
						//get id to get Ps work id and psProdId
						var arrMainValue=idRow.split("__");	
						if(arrPsTaxWorkId == "")
						{
							arrPsTaxWorkId+=arrMainValue[0];									
						}
						else
						{
							arrPsTaxWorkId+="__"+arrMainValue[0];									
						}	

						if(arrPsTaxProdId == "")
						{									
							arrPsTaxProdId+=arrMainValue[1];
							
						}
						else
						{									
							arrPsTaxProdId+="__"+arrMainValue[1];									
						}																							
						
						if(arrPsTaxCat == "")
						{									
							arrPsTaxCat+=Ex.dataSourceTemp[i].taxCatHidden;									
						}
						else
						{									
							arrPsTaxCat+="__"+Ex.dataSourceTemp[i].taxCatHidden;								
						}																												
				}		
			}						
			var obj = new Object();
			obj.arrPsWrkId=arrPsWorkId;
			obj.arrPsProdId=arrPsProdId;
			obj.arrSubComCode=arrPsSubcom;		
			obj.arrPsTaxWrkId=arrPsTaxWorkId;
			obj.arrPsTaxProdId=arrPsTaxProdId;
			obj.arrTaxCatCode=arrPsTaxCat;
			ManageEDIDWR.updateFormForSave(obj,SER.currentPage,getDWRCallbackMethod(saveSellingUpc));			
		} 
	}
	<c:url value="/protected/cps/manageEDI/updateValues?${_csrf.parameterName}=${_csrf.token}" var="updateUrl" />
	function saveSellingUpc(data)
	{	
		if(data+""=="true")
		{
			var formObject = document.getElementById('searchForm');
			showProgress();
			SER.setCurrentRecrdPerPage();
			formObject.action = "${updateUrl}";
			formObject.submit();		
		}
		else
		{
			Ex.showMess();
		}
	}	
	
	function resetCurrentTab(evt)
	{					
		if(currentTab==1)
		{
			Ex.hideMess();
			Ex.clearSelTable();
			Ex.dataSourceTemp=[];

			//reset data source filter
			Ex.filterItemReturn = [];
			
			filterTimeout = null;
			var pattent = "\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*__\.*";			
			Ex.myDataSource.sendRequest(pattent,{
				success : Ex.myDataTable.onDataReturnInitializeTable,
				failure : Ex.myDataTable.onDataReturnInitializeTable,
				scope   : Ex.myDataTable,
				argument: pattent	
			});
			//set current page is selected (before click reset button)
			Ex.myDataTable.get('paginator').setPage(parseInt(SER.currentPage));

			setFilterValue();
		}
		if(currentTab==4)
		{
			resetCostAndRetailTab();	
		}
		if(currentTab==5)
		{
			resetOtherAttributeTab();
		}
		if(currentTab==6)
		{
			resetAuthorizationTab();
		}
		if(currentTab==2)
		{
			resetDescriptionAndSizeTab();
		}
		if(currentTab==3)
		{
			resetCasePackTab();
		}
	}
	/*===========================BEGIN REJECT========================================*/
	<c:url value="/protected/cps/manageEDI/rejectComment?${_csrf.parameterName}=${_csrf.token}" var="rejectComment"></c:url>
	<c:url value="/protected/cps/manageEDI/rejectCommentAjax?${_csrf.parameterName}=${_csrf.token}" var="rejectCommentAjax"></c:url>
	YAHOO.namespace("heb.container.confirmDialog");
	
	function reject(evt){
		//get lst select PsWrkId
		var lstPsWrkIds =new Array();
		lstPsWrkIds =getLstSelectPsWrk();
		//get lst select PsProdId
		var allProdIdsSelected =new Array();
	    allProdIdsSelected=getLstSelectPsProd();		
		if(${ManageEDICandidate.isVendor}) {
	    	if(SER.numOfWorkCand > 0)
		    {
		     	alert("You may not reject working candidate(s), please click view if you would like to see the details");
				return false;
		    }
	    	else if(SER.numOfActiveFailed > 0)
		    {
	    		alert("You may not reject activation failed candidate(s), please click view if you would like to see the details");
				return false;
		    }
	    }
 		if(allProdIdsSelected.length>0){		
 			var message = confirm('Do you want to reject selected UPC(s)?');
			if(message){
				YAHOO.util.Dom.get('productSelectedIds').value = allProdIdsSelected;			
				var formObject = document.getElementById('searchForm');
				formObject.action = "${rejectCommentAjax}";		
				YAHOO.util.Connect.setForm(formObject); 				
				var callback = {
						success:function(o){
							hideProgress();
							try{
								generateRejectPopup(o.responseText);
							}catch(e){
								hideProgress();
							}
						}
					};
					showProgress();
					var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
			}
		} 
		else {
			alert('Please select UPC(s) that you want to reject');
		}				
	}
		
	YAHOO.namespace("heb.container.rejectCommentReject");
	function generateRejectPopup(){			
		showProgress();
		document.getElementById("panel1").style.display="";
		if(once == false){			
			once = true;
			YAHOO.heb.container.rejectCommentReject = new YAHOO.widget.Panel("panel1", 
			{ 	width:"1030px", 
				height:"600px", 
				underlay:"shadow",
				visible:false, 
				constraintoviewport:true, 
				draggable:false,	
				zIndex : 55000,						
				modal:true,
				close:true,
				fixedCenter : true
				//effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}						
			} );
			
			YAHOO.heb.container.rejectCommentReject.render(document.body);	
		}	
		
		YAHOO.heb.container.rejectCommentReject.beforeHideEvent.subscribe(onBeforeHideEvent4);
		YAHOO.heb.container.rejectCommentReject.beforeShowEvent.subscribe(onBeforeShowEvent4);		
		YAHOO.heb.container.rejectCommentReject.show();

		document.getElementById("popupFrame").style.height="100%";
		document.getElementById("popupFrame").style.width="100%";
		document.getElementById("popupFrame").src = "${rejectComment}";
		document.getElementById("popupHeader").innerHTML = '<font size="2" color="white">&nbsp;&nbsp;&nbsp; Reject</font>';		
		document.getElementById("popupFrame").innerHTML =data;		
	}


	
	function closeIt(){
		if(confirm("Exit UPC Reject? (click OK to exit)")){
			closePopup4();
		}
	}
	function onShowEvent4(){
		YAHOO.heb.container.rejectCommentReject.showMask();
	}

	function onBeforeShowEvent4(){
		//YAHOO.heb.container.rejectCommentReject.hideMask();
	}

	function onBeforeHideEvent4(){
		once = false;
		document.getElementById("popupFrame").src = "";
		document.getElementById("panel1").style.display="hidden";
		document.getElementById("popupHeader").innerHTML = "";
	}
	<c:url value="/protected/cps/manageEDI/removeRejectedCandidate?${_csrf.parameterName}=${_csrf.token}" var="removeRejectedCandidate"></c:url>
	function closePopup4(reSumit){
		YAHOO.heb.container.rejectCommentReject.hide();
		if(reSumit){
			//set result filter
			setResultFilter();
		 	//submit form
		    var formObject = document.getElementById('searchForm');
		    SER.setCurrentRecrdPerPage();
			var urlRejectComment='${removeRejectedCandidate}';
			showProgress();
			formObject.action = urlRejectComment;
			formObject.method="POST";
			formObject.submit();
		}
	}
	
	
	/*===========================END REJECT===========================================*/
	
	/*===========================BEGIN REJECT COMMENT=================================*/
	<c:url value="/protected/cps/manageEDI/upcComment?${_csrf.parameterName}=${_csrf.token}" var="upcComment"></c:url>
	<c:url value="/protected/cps/manageEDI/upcCommentAjax?${_csrf.parameterName}=${_csrf.token}" var="upcCommentAjax"></c:url>

	function rejectComment(evt){
		//get lst select PsWrkId
		var lstPsWrkIds =new Array();
		lstPsWrkIds =getLstSelectPsWrk();
		//get lst select PsProdId
		var allProdIdsSelected =new Array();
	    allProdIdsSelected=getLstSelectPsProd();		
		if(${ManageEDICandidate.isVendor}) {
	    	if(SER.numOfWorkCand > 0)
		    {
		     	alert("You may not reject comment working candidate(s), please click view if you would like to see the details");
				return false;
		    }
	    	else if(SER.numOfActiveFailed > 0)
		    {
	    		alert("You may not reject comment activation failed candidate(s), please click view if you would like to see the details");
				return false;
		    }
	    }	    
 		if(allProdIdsSelected.length>0){
 			YAHOO.util.Dom.get('productSelectedIds').value = allProdIdsSelected;			
			var formObject = document.getElementById('searchForm');
			formObject.action = "${upcCommentAjax}";		
			YAHOO.util.Connect.setForm(formObject); 				
			var callback = {
					success:function(o){
						hideProgress();
						try{
							generateRejectCommentPopup(o.responseText);
						}catch(e){
							hideProgress();
						}
					}
			};
			showProgress();
			var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
		} else {
			alert('Please select UPC(s) that you want to reject comment');
		}			
	}	
	
	var once = false;
	YAHOO.namespace("heb.container.upcCommentReject");
	function generateRejectCommentPopup(){			
		showProgress();
		document.getElementById("panel1").style.display="";
		if(once == false){			
			once = true;
			YAHOO.heb.container.upcCommentReject = new YAHOO.widget.Panel("panel1", 
			{ 	width:"1020px", 
				height:"600px", 
				underlay:"shadow",
				visible:false, 
				constraintoviewport:true, 
				draggable:false,	
				zIndex : 55000,						
				modal:true,
				close:true,
				fixedCenter : true
				//effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}						
			} );
			
			YAHOO.heb.container.upcCommentReject.render(document.body);	
		}	
		
		YAHOO.heb.container.upcCommentReject.beforeHideEvent.subscribe(onBeforeHideEvent);
		YAHOO.heb.container.upcCommentReject.beforeShowEvent.subscribe(onBeforeShowEvent);		
		YAHOO.heb.container.upcCommentReject.show();

		document.getElementById("popupFrame").style.height="100%";
		document.getElementById("popupFrame").style.width="100%";
		document.getElementById("popupFrame").src = "${upcComment}";
		document.getElementById("popupHeader").innerHTML = '<font size="2" color="white">&nbsp;&nbsp;&nbsp; Reject Comment</font>';		
		document.getElementById("popupFrame").innerHTML =data;		
	}


	
	function closeIt(){
		if(confirm("Exit UPC Reject Comment? (click OK to exit)")){
			closePopup();
		}
	}
	function onShowEvent(){
		YAHOO.heb.container.upcCommentReject.showMask();
	}

	function onBeforeShowEvent(){
		//YAHOO.heb.container.upcCommentReject.hideMask();	
	}

	function onBeforeHideEvent(){
		once = false;
		document.getElementById("popupFrame").src = "";
		document.getElementById("panel1").style.display="hidden";	
		document.getElementById("popupHeader").innerHTML = "";
	}
	<c:url value="/protected/cps/manageEDI/saveRejectedCommentCandidate?${_csrf.parameterName}=${_csrf.token}" var="saveRejectedCommentCandidate"></c:url>
	function closePopup(reSubmit){
		YAHOO.heb.container.upcCommentReject.hide();
		if(reSubmit){
			//set result filter
			setResultFilter();
			SER.setCurrentRecrdPerPage();			
			var urlRejectComment='${saveRejectedCommentCandidate}';
			 //submit form	
			var formObject = document.getElementById('searchForm');
			showProgress();
			formObject.action = urlRejectComment;
			formObject.method="POST";
			formObject.submit();
		}
	}
	function hideTheProgress(){
		hideProgress();
	}
	/*===========================END REJECT COMMENT=================================*/
	
	//**************************NEXT BUTTON************************
	
	new YAHOO.widget.Button("nextSumBut");  
	new YAHOO.widget.Button("nextSumButActive");
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("nextSumBut"), "click", nextFunction);
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("nextSumButActive"), "click", nextFunction);
	
	function nextFunction(evt)
	{
		if(${ManageEDICandidate.currentTab != 'authorizationAndDistributionTab'}){
			var cT=getCurrentTab()+1;
			doLoadTabData(cT);
		}
	}
	//***************************END NEXT BUTTON SECTION***********
	
	function checkExistProducts(allProdIdsSelected,productId){		
	if(allProdIdsSelected!=''){
		for(var i=0;i<allProdIdsSelected.length;i++){
			if(allProdIdsSelected[i]==productId){
				return true;
			}
		}		
	}		
	 return false;
	}
	
	//**************************PRINT FORM BUTTON************************
<c:url value="/protected/cps/manageEDI/printForm?${_csrf.parameterName}=${_csrf.token}" var="printForm" />
<c:url value="/protected/cps/manageEDI/printFormAjax?${_csrf.parameterName}=${_csrf.token}" var="printFormAjax" />
	<c:url var="loadingImage" value="${request.getContextPath()}/hebAssets/images/loadingData.gif"></c:url>
function printFormPopUp(evt) {	
	var allProdIdsSelected = getLstSelectPsProd();
	YAHOO.util.Dom.get('selectedProductId').value = allProdIdsSelected;	
	if(allProdIdsSelected.length>0){	
		var formObject = document.getElementById('searchForm');
		formObject.action = "${printFormAjax}";
		YAHOO.util.Connect.setForm(formObject);
		
		
		var callback = {
			success:function(o){
					//hideProgress();
				try{
					generatePrintFormPopup(o.responseText);
					
				}catch(e){
					//hideProgress();
				}

			}
		};
		showProgress();
		
		var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);					
	}else
	{
		alert("Please select UPC(s) that you want to print");
	}
}

YAHOO.namespace("heb.container.printForm");
function generatePrintFormPopup(data){
	showProgress();
	var allProdIdsSelected = getLstSelectPsProd();
	document.getElementById("panel1").style.display="";
	if(once == false){			
		once = true;
		YAHOO.heb.container.printForm = new YAHOO.widget.Panel("panel1", 
		{ 	width:"600px", 
			height:"250px", 
			underlay:"shadow",
			visible:false, 
			constraintoviewport:true, 
			draggable:false,	
			zIndex : 55000,
			modal:true,
			close:true,
			fixedCenter : true
			//effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}						
		} );
		
		YAHOO.heb.container.printForm.render(document.body);	
	}


    YAHOO.heb.container.printForm.beforeHideEvent.subscribe(onBeforeHideEvent2);
	YAHOO.heb.container.printForm.beforeShowEvent.subscribe(onBeforeShowEvent2);		
	YAHOO.heb.container.printForm.show();
    document.getElementById("popupProgressDiv").style.display='block';
    document.getElementById('popupFrame').onload= function() {
        document.getElementById("popupProgressDiv").style.display='none';
    };
    document.getElementById("popupFrame").style.height="100%";
	document.getElementById("popupFrame").style.width="100%";
	document.getElementById("popupFrame").src = "${printForm}";
	document.getElementById("popupHeader").innerHTML = '<font size="2" color="white">&nbsp;&nbsp;&nbsp; Print Form</font>';		
	document.getElementById("popupFrame").innerHTML = data;

}

function onShowEvent2(){
	YAHOO.heb.container.printForm.showMask();
}

function onBeforeShowEvent2(){
	//YAHOO.heb.container.printForm.hideMask();
	
}

function onBeforeHideEvent2(){
	once = false;
	document.getElementById("panel1").style.dsiplay="hidden";
	document.getElementById("popupFrame").src = "";
	document.getElementById("popupHeader").innerHTML = "";
    window.parent.hideProgress();
    YAHOO.heb.container.printForm.hideMask();
    document.getElementById("popupProgressDiv").style.display='none';
    document.getElementById("panel1_mask").remove();
}
//**************************END PRINT FORM BUTTON************************
//print summary
<c:url value="/protected/cps/manageEDI/printSummary?${_csrf.parameterName}=${_csrf.token}" var="print"></c:url>
<c:url value="/protected/cps/manageEDI/printSummaryProd?${_csrf.parameterName}=${_csrf.token}" var="printProd"></c:url>
function printSummary(evt){
	var allProdIdsSelected = getLstSelectPsProd();
	
	if(allProdIdsSelected.length>0){
		YAHOO.util.Dom.get('productSelectedIds').value = allProdIdsSelected;	
		if(${ManageEDICandidate.candidateEDISearchCriteria.actionId == '5'}){
			document.forms[0].action = '${printProd}';
		} else {
			document.forms[0].action = '${print}';
		}
		document.forms[0].submit();
 		} else {
	 		alert('Please select UPC(s) that you want to print summary');
 	}
}

		/*===========================BEGIN TEST SCAN=================================*/
		
<c:url value="/protected/cps/manageEDI/testScans?${_csrf.parameterName}=${_csrf.token}" var="testScans" />
<c:url value="/protected/cps/manageEDI/testScansAjax?${_csrf.parameterName}=${_csrf.token}" var="testScansAjax" />

function testScan(evt){
	//get lst select PsWrkId
	var lstPsWrkIds =new Array();
	lstPsWrkIds =getLstSelectPsWrk();
	//get lst select PsProdId
	var allProdIdsSelected =new Array();
    allProdIdsSelected=getLstSelectPsProd();
    if(${ManageEDICandidate.isVendor}) {
        if(SER.numOfActiveFailed > 0){
	     	alert("You may not test scan activation failed candidate(s), please click view if you would like to see the details");
			return false;
        }
    }
    else{
    	if(SER.numOfSlVdorCand > 0)
	    {
	     	alert("You may not test scan vendor candidate(s), please click view if you would like to see the details");
			return false;
	    }
    }
	
    if(allProdIdsSelected.length>0){		
		YAHOO.util.Dom.get('productSelectedIds').value = allProdIdsSelected;		
		var formObject = document.getElementById('searchForm');
		formObject.action = "${testScansAjax}";		
		YAHOO.util.Connect.setForm(formObject); 				
		var callback = {
				success:function(o){
					hideProgress();
					try{
						generateTestScanPopup(o.responseText);
					}catch(e){
						hideProgress();
					}
				}
			};
			showProgress();
			var cObj = YAHOO.util.Connect.asyncRequest('POST', formObject.action, callback);
		
 	}else {
	 	alert('Please select UPC(s) that you want to test scan');
 	}
}

YAHOO.namespace("heb.container.testScan");
function generateTestScanPopup(){			
	showProgress();
	document.getElementById("panel1").style.display="";
	if(once == false){			
		once = true;
		YAHOO.heb.container.testScan = new YAHOO.widget.Panel("panel1", 
		{ 	width:"700px", 
			height:"500px", 
			underlay:"shadow",
			visible:false, 
			constraintoviewport:true, 
			draggable:false,	
			zIndex : 55000,
			modal:true,
			close:true,
			fixedCenter : true
			//effect:{effect:YAHOO.widget.ContainerEffect.FADE, duration: 0.50}						
		} );
		
		YAHOO.heb.container.testScan.render(document.body);	
	}	
	
	YAHOO.heb.container.testScan.beforeHideEvent.subscribe(onBeforeHideEvent1);
	YAHOO.heb.container.testScan.beforeShowEvent.subscribe(onBeforeShowEvent1);		
	YAHOO.heb.container.testScan.show();

	document.getElementById("popupFrame").style.height="100%";
	document.getElementById("popupFrame").style.width="100%";
	document.getElementById("popupFrame").src = "${testScans}";
	document.getElementById("popupHeader").innerHTML = '<font size="2" color="white">&nbsp;&nbsp;&nbsp; Available UPCs</font>';		
	document.getElementById("popupFrame").innerHTML =data;		
}

function closeIt(){
	if(confirm("Exit Test Scan? (click OK to exit)")){
		closePopup1();
	}
}
function onShowEvent1(){
	YAHOO.heb.container.testScan.showMask();
}

function onBeforeShowEvent1(){
	//YAHOO.heb.container.testScan.hideMask();
	
}

function onBeforeHideEvent1(){
	once = false;
	document.getElementById("popupFrame").src = "";
	document.getElementById("panel1").style.display="hidden";
	document.getElementById("popupHeader").innerHTML = "";
}

<c:url value="/protected/cps/manageEDI/saveTestScanCandidate?${_csrf.parameterName}=${_csrf.token}" var="saveTestScanCandidate"></c:url>
function closePopup1(reSubmit){
	YAHOO.heb.container.testScan.hide();
	if(reSubmit){
		//set result filter
		setResultFilter();
			
		var formObject = document.getElementById('searchForm');
		SER.setCurrentRecrdPerPage();
		var urlTestScan='${saveTestScanCandidate}';
		showProgress();
		formObject.action = urlTestScan;
		formObject.method="POST";
		formObject.submit();	
	}
}
function hideTheProgress(){
	hideProgress();
}
/*===========================END TEST SCAN=================================*/


/*===========================BEGIN MODIFY==================================*/

<c:url value="/protected/cps/add/modifyCandFromEDI?${_csrf.parameterName}=${_csrf.token}" var="modi"></c:url>
<c:url value="/protected/cps/add/modifyProductFromEDI?${_csrf.parameterName}=${_csrf.token}" var="modiProd"></c:url>
function modify(evt){
	var allProdIdsSelected = new Array();
	var myDataSource = null;

    var cnt = 0;
	var modifyWorkCand = true;
	var modifyActivationFaildedCand = true;
	var workStatus;
	
	if(${ManageEDICandidate.currentTab == 'sellingUpctab'}){
		var upc ='';
		for(var i=0;i < Ex.dataSourceTemp.length;i++)
		{				
			var comp = YAHOO.lang;
			var cK=Ex.dataSourceTemp[i].checkBox;
			var bChecked = cK.split("CHECKED");
			//if check						
			bChecked = (bChecked[1]) ? "checked" : "";																		
			if(bChecked=="checked")
			{
				cnt++;
				workStatus = YAHOO.lang.trim(Ex.dataSourceTemp[i].statusHidden);
				//Sprint - 23
				var idRowHidden =YAHOO.lang.trim(Ex.dataSourceTemp[i].idRowHidden);
				if(idRowHidden!="") {
					var splitValue = idRowHidden.split("__");
					if(splitValue[6]=='true') {
						if(upc.indexOf(splitValue[3])==-1) {
							upc+=splitValue[3]+", ";
						}
					}
				}
				if(${ManageEDICandidate.isVendor}) {
					if(workStatus == '107'){
						modifyWorkCand = false;
						break;
					} else if(workStatus == '109'){
						modifyActivationFaildedCand = false;
						break;
					} 				
				}else{					
					if(workStatus == '103')
						break;
				}
									
				var bSplit = cK.split("+");												
				var temp=bSplit[1].split("type");						 
				var idRow=comp.trim(temp[0]);
				//get id to get Ps work id and psProdId
				var arrMainValue=idRow.split("__");	
				
				if(!allProdIdsSelected.inArray(arrMainValue[1]))
				{
					allProdIdsSelected.push(arrMainValue[1]);
				}	
																										
			}				
		}
	} else if(${ManageEDICandidate.currentTab == 'descriptionAndSizeTab'}){
		myDataSource = dataSourceTemp;					
	}else if(${ManageEDICandidate.currentTab == 'casePackTab'}){
		myDataSource = dataSourceTemp;			
	}else if(${ManageEDICandidate.currentTab == 'costAndRetailTab'}){
		myDataSource = dataSourceTemp;			
	}else if(${ManageEDICandidate.currentTab == 'otherAttributeTab'}){
		myDataSource = dataSourceTemp;	 		
	}
	else if(${ManageEDICandidate.currentTab == 'authorizationAndDistributionTab'}){
		myDataSource = dataSourceTemp;	
	}

	if(myDataSource != null && myDataSource.length >0)	{ 
	   upc = '';
       for(var i=0; i<myDataSource.length; i++) { 	  
			if(myDataSource[i].changeStatus == "4" || myDataSource[i].changeStatus == "3" || myDataSource[i].changeStatus == "1"){
				cnt++;
				workStatus = myDataSource[i].status;
				if(${ManageEDICandidate.isVendor}) {
					if(workStatus == '107'){
						modifyWorkCand = false;
						break;
					} else if(workStatus == '109'){
						modifyActivationFaildedCand = false;
						break;
					}				
				}else{					
					if(workStatus == '103')
						break;
				}
				var productId = myDataSource[i].productID;						
				if(!checkExistProducts(allProdIdsSelected,productId)){
					allProdIdsSelected.push(productId);
				}							
			}	
			var cK=myDataSource[i].checkBox;		
			var bChecked = cK.split("checked");
			//Sprint - 23
			if(bChecked!=null && bChecked.length>1) {		
				var idRow =YAHOO.lang.trim(myDataSource[i].idRowHidden);
				if(idRow!="" && idRow != undefined) {
					var splitValue = idRow.split("__");
					if(splitValue[1]=='true') {
						if(upc.indexOf(splitValue[0])==-1) {
							upc+=splitValue[0]+", ";
						}
					}
				}
			}
       }
	}

	if(cnt < 1) {
		alert('Please select UPC(s) that you want to modify');
		return false;
	}else if(!modifyWorkCand){
		alert("You may not modify working candidate(s), please click view if you would like to see the details");
		return false;
	}else if(!modifyActivationFaildedCand ) {
		alert("You may not modify activation failed candidate(s), please click view if you would like to see the details");
		return false;
	} else {		
		//prevent PIA Lead, Admin (except Vendor) can be modify candidate
		if(${!ManageEDICandidate.isVendor} && workStatus=='103') {
			alert("You may not modify vendor candidate(s), please click view if you would like to see the details");
			return false;
		}						
	}
	//Sprint - 23
	if(upc!="" && upc.length>1 && YAHOO.util.Dom.get('actionSelect').value==5) {
		alert('A kit product may not be modified.');
		// Please de-select the kit product(s) ('+upc.substring(0,upc.length-2)+') before modifying.');
		return false;
	}
	if(allProdIdsSelected.length>0){
		YAHOO.util.Dom.get('productSelectedIds').value = allProdIdsSelected;
		YAHOO.util.Dom.get('selectedProductId').value = allProdIdsSelected;		
		if(${ManageEDICandidate.candidateEDISearchCriteria.actionId == '5'}){
			//window.location = '${modiProd}' + '&productIds=' + allProdIdsSelected;
			document.forms[0].action = '${modiProd}';
			document.forms[0].submit();
		}
		else{
			//window.location = '${modi}' + '&productIds=' + allProdIdsSelected;
			//document.forms[0].action = '${modi}';
			showProgress();				 
			ManageEDIDWR.checkMultilPluReuse(YAHOO.util.Dom.get('selectedProductId').value,getDWRCallbackMethod(modifyCallBack));		
		}
		
	} 
}

function modifyCallBack(data){
	if(data!='' && data == true){		
		alert('PLU(s) tied to a vendor candidate/working candidate/ an existing product. \nThis candidate cannot be modified.');	
		hideProgress();	
	} else {			
		document.forms[0].action = '${modi}';
		document.forms[0].submit(); 		
	} 
}
/*===========================END MODIFY=================================*/


/*===========================BEGIN VIEW=================================*/

<c:url value="/protected/cps/add/viewCandFromEDI?${_csrf.parameterName}=${_csrf.token}" var="view"></c:url>
<c:url value="/protected/cps/add/viewProductFromEDI?${_csrf.parameterName}=${_csrf.token}" var="viewProd"></c:url>

function view(evt){	
	var allProdIdsSelected = getLstSelectPsProd();
	
	if(allProdIdsSelected.length>0){
		YAHOO.util.Dom.get('productSelectedIds').value = allProdIdsSelected;
		YAHOO.util.Dom.get('selectedProductId').value = allProdIdsSelected;		
		if(${ManageEDICandidate.candidateEDISearchCriteria.actionId == '5'}){
			//window.location = '${viewProd}' + '&productIds=' + allProdIdsSelected;
			document.forms[0].action = '${viewProd}';
		}
		else {
			//window.location = '${view}' + '&productIds=' + allProdIdsSelected;
			document.forms[0].action = '${view}';
		}		
		document.forms[0].submit();
	}else {
		 alert('Please select UPC(s) that you want to view');
 		
 	}
}
/*===========================END VIEW=================================*/


//******************BEGIN get check SellingUPC List array************************//

function getSellingUpcCheckList()
{
	var isHaveCheck=false;
	var psProIdArrReturn = new Array();
								
	for(var i=0;i < Ex.dataSourceTemp.length;i++)
	{
			
			var comp = YAHOO.lang;
			var cK=Ex.dataSourceTemp[i].checkBox;
			var bChecked = cK.split("CHECKED");
			//if check						
			bChecked = (bChecked[1]) ? "checked" : "";																		
			if(bChecked=="checked")
			{					
					var bSplit = cK.split("+");												
					var temp=bSplit[1].split("type");						 
					var idRow=comp.trim(temp[0]);
					//get id to get Ps work id and psProdId
					var arrMainValue=idRow.split("__");	
					
					if(!psProIdArrReturn.inArray(arrMainValue[1]))
					{
						psProIdArrReturn.push(arrMainValue[1]);
					}	
																										
			}
			
	}
	return 	psProIdArrReturn;	
}

//******************END get check SellingUPC List array************************//

//******************BEGIN get check psWork id SellingUPC List array************************//
function getSellingUpcPsWorkCheckList()
{
	var isHaveCheck=false;
	var psWrkIdArrReturn = new Array();
	var psWrkActiveFailArr = new Array();

	var cnt =0;
	var cntWrk = 0;
	var cntFail = 0;
								
	for(var i=0;i < Ex.dataSourceTemp.length;i++)
	{
			
			var comp = YAHOO.lang;
			var cK=Ex.dataSourceTemp[i].checkBox;
			var bChecked = cK.split("CHECKED");
			//if check						
			bChecked = (bChecked[1]) ? "checked" : "";																		
			if(bChecked=="checked")
			{					
					var bSplit = cK.split("+");												
					var temp=bSplit[1].split("type");						 
					var idRow=comp.trim(temp[0]);
					//get id to get Ps work id and psProdId
					var arrMainValue=idRow.split("__");	
					if(!psWrkIdArrReturn.inArray(arrMainValue[0]))
					{
						psWrkIdArrReturn.push(arrMainValue[0]);
					}
					var workStatus = YAHOO.lang.trim(Ex.dataSourceTemp[i].statusHidden);
					if(workStatus=='103')
					{	
						cnt++;					
					}
					if(workStatus=='107')
					{
						cntWrk++;
					}
					if(workStatus=='109')
					{
						cntFail++;
						if(!psWrkActiveFailArr.inArray(arrMainValue[0]))
						{						
							psWrkActiveFailArr.push(arrMainValue[0]);
						}	
					}	
																										
			}
			
	}	
	YAHOO.util.Dom.get('psWrkActiveFailSelectedIds').value = psWrkActiveFailArr;	
	
	SER.numOfSlVdorCand=cnt;
	SER.numOfWorkCand = cntWrk;
	SER.numOfActiveFailed = cntFail;
	return 	psWrkIdArrReturn;	
}

//******************END get check psWork id SellingUPC List array************************//


//******************BEGIN ACTIVATE*********************************************//

<c:url value="/protected/cps/manageEDI/activate?${_csrf.parameterName}=${_csrf.token}" var="activeUrl" />
function activeCandidateEDI(evt)
{
	//get lst select PsWrkId
	var lstPsWrkIds =new Array();
	lstPsWrkIds =getLstSelectPsWrk();
	//get lst select PsProdId
	var lstPsProdIds =new Array();
    lstPsProdIds=getLstSelectPsProd();
    if(lstPsWrkIds.length == 0)
    {
        alert(" Please select UPC that you want to activate.");
        return false;	
    }    
    else
    {
        if(SER.numOfSlVdorCand > 0)
        {
        	alert("You may not activate vendor candidate(s), please click view if you would like to see the details");
			return false;
        }
    }

   // var message = confirm('Do you want to activate selected UPC(s)?');
	//if(message){
		//set result filter
		setResultFilter();		
		
	    YAHOO.util.Dom.get('productSelectedIds').value= lstPsProdIds;
	    YAHOO.util.Dom.get('psWorkSelectedIds').value= lstPsWrkIds;
	    SER.setCurrentRecrdPerPage();
	   // var urlactive='${activeUrl}';
	 	 //submit form	
	    //var formObject = document.getElementById('searchForm');
		showProgress();
//		formObject.action = urlactive;
//		formObject.method="post";
//		formObject.submit(); 
//      PIM 354
		ManageEDIDWR.warningTaxFoodStamp(YAHOO.util.Dom.get('productSelectedIds').value,getDWRCallbackMethod(warningTaxFoodStampCallBack));
	//}  
	
}
function warningTaxFoodStampCallBack(data){
	 var urlactive='${activeUrl}';
	if(data!=''){
		hideProgress();		
		var messageSelected = confirm(data);
		if(messageSelected){
			showProgress();	
			var formObject = document.getElementById('searchForm');		
			formObject.action = urlactive;
			formObject.method="POST";
			formObject.submit(); 
		} 
	} else {
		hideProgress();		
		 var message = confirm('Do you want to activate selected UPC(s)?');
		 if(message){
			showProgress();	
			var formObject = document.getElementById('searchForm');		
			formObject.action = urlactive;
			formObject.method="POST";
			formObject.submit(); 
		 }
	}
	
}
//******************END ACTIVATE***********************************************//


//******************BEGIN GET LIST PSWORK ID***********************************//
function getLstSelectPsWrk(){
	var allWorkIdsSelected = new Array();
	var myDataSource = null;

	//cnt to count number of vendor candidate
	var cnt =0;
	//cnt to count number of working candidate
	var cntWrk = 0;
	//cnt to count number of active failed
	var cntFail = 0;
	var isSelTab=false;

	var psWrkActiveFailArr = new Array();
	if(${ManageEDICandidate.currentTab == 'sellingUpctab'}){
		isSelTab=true;
		allWorkIdsSelected = getSellingUpcPsWorkCheckList();
	} else if(${ManageEDICandidate.currentTab == 'descriptionAndSizeTab'}){
		myDataSource = dataSourceTemp;					
	}else if(${ManageEDICandidate.currentTab == 'casePackTab'}){
		myDataSource = dataSourceTemp;			
	}else if(${ManageEDICandidate.currentTab == 'costAndRetailTab'}){
		myDataSource = dataSourceTemp;			
	}else if(${ManageEDICandidate.currentTab == 'otherAttributeTab'}){
		myDataSource = dataSourceTemp;
	}
	else if(${ManageEDICandidate.currentTab == 'authorizationAndDistributionTab'}){
		myDataSource = dataSourceTemp;	
	}

	if(myDataSource != null && myDataSource.length >0)	{   	
       for(var i=0; i<myDataSource.length; i++) { 	    		 
			if(myDataSource[i].changeStatus == "4" || myDataSource[i].changeStatus == "3" || myDataSource[i].changeStatus == "1"){
				
				var wordId = myDataSource[i].idResult.split('-')[0];						
				if(getCurrentTab() ==4)
				{
					wordId = myDataSource[i].idResult.split('-')[4];
				}
				if(!checkExistWorkRqs(allWorkIdsSelected,wordId)){					
					allWorkIdsSelected.push(wordId);
					if(myDataSource[i].status=='103')
					{
						cnt++;
					}
					if(myDataSource[i].status=='107')
					{
						cntWrk++;
					}
					if(myDataSource[i].status=='109')
					{
						cntFail++;
						if(!psWrkActiveFailArr.inArray(wordId))
						{
							psWrkActiveFailArr.push(wordId);
						}	
					}
				}							
			}						
       }
	}

	if(!isSelTab)
	{
		SER.numOfSlVdorCand = cnt;
		SER.numOfWorkCand = cntWrk;
		SER.numOfActiveFailed = cntFail;
		YAHOO.util.Dom.get('psWrkActiveFailSelectedIds').value = psWrkActiveFailArr;
	}
	
	return allWorkIdsSelected;
}

function checkExistWorkRqs(allWorkIdsSelected,workId){		
	if(allWorkIdsSelected != ''){
		for(var i=0;i<allWorkIdsSelected.length;i++){
			if(allWorkIdsSelected[i]==workId){
				return true;
			}
		}		
	}		
	 return false;
}

//******************END GET LIST PSWORK ID***********************************//

//******************BEGIN GET LIST PSPROD ID***********************************//
function getLstSelectPsProd(){
	var allProdIdsSelected = new Array();
	var myDataSource = null;
	
	if(${ManageEDICandidate.currentTab == 'sellingUpctab'}){
		allProdIdsSelected = getSellingUpcCheckList();	
	} else if(${ManageEDICandidate.currentTab == 'descriptionAndSizeTab'}){
		myDataSource = dataSourceTemp;					
	}else if(${ManageEDICandidate.currentTab == 'casePackTab'}){
		myDataSource = dataSourceTemp;			
	}else if(${ManageEDICandidate.currentTab == 'costAndRetailTab'}){
		myDataSource = dataSourceTemp;			
	}else if(${ManageEDICandidate.currentTab == 'otherAttributeTab'}){
		myDataSource = dataSourceTemp;	 		
	}
	else if(${ManageEDICandidate.currentTab == 'authorizationAndDistributionTab'}){
		myDataSource = dataSourceTemp;	
	}

	if(myDataSource != null && myDataSource.length >0)	{   	
       for(var i=0; i<myDataSource.length; i++) { 	    		 
			if(myDataSource[i].changeStatus == "4" || myDataSource[i].changeStatus == "3" || myDataSource[i].changeStatus == "1"){
				var productId = myDataSource[i].productID;						
				if(!checkExistProducts(allProdIdsSelected,productId)){
					allProdIdsSelected.push(productId);
				}							
			}						
       }
	}

	return allProdIdsSelected;
}

//******************END GET LIST PSPROD ID***********************************//
/*=====================================================================*/
function alertDialog(message){
	document.getElementById("simpledialog1").style.display="";		
	YAHOO.heb.container.confirmDialog =  new YAHOO.widget.SimpleDialog("simpledialog1",  
	{ 	   width: "450px", 
		   fixedcenter: true, 
		   visible: false, 
		   draggable: false, 
		   close: true,
		   modal:true,
		   text: message, 
		   icon: YAHOO.widget.SimpleDialog.ICON_WARN, 
		   constraintoviewport: true, 
		   buttons: [ { text:"OK", handler:handleNo, isDefault:true } ]
	} ); 
	YAHOO.heb.container.confirmDialog.render(document.body);
	YAHOO.heb.container.confirmDialog.show();
	document.getElementById("dialogHeader").innerHTML = '<font size="2" color="black">&nbsp;&nbsp;&nbsp; Warning!</font>';

}

//=================BEGIN FUNCTION CHECK WHEREVER CURRENT TAB HAVE CHANGE DATA TO SAVE===================//

function checkDataChangeForAllTab()
{
	
	var allProdIdsSelected = new Array();
	var myDataSource = null;
	
	if(${ManageEDICandidate.currentTab == 'sellingUpctab'}){
		allProdIdsSelected = checkDataChangeSellingTab();	
	} else if(${ManageEDICandidate.currentTab == 'descriptionAndSizeTab'}){
		myDataSource = dataSourceTemp;					
	}else if(${ManageEDICandidate.currentTab == 'casePackTab'}){
		myDataSource = dataSourceTemp;			
	}else if(${ManageEDICandidate.currentTab == 'costAndRetailTab'}){
		myDataSource = dataSourceTemp;			
	}else if(${ManageEDICandidate.currentTab == 'otherAttributeTab'}){
		myDataSource = dataSourceTemp;	 		
	}
	else if(${ManageEDICandidate.currentTab == 'authorizationAndDistributionTab'}){
		myDataSource = dataSourceTemp;	
	}

	if(myDataSource != null && myDataSource.length >0)	{   	
       for(var i=0; i<myDataSource.length; i++) { 	    		 
			if(myDataSource[i].changeStatus == "2" || myDataSource[i].changeStatus == "3"){
				var productId = myDataSource[i].productID;						
				if(!checkExistProducts(allProdIdsSelected,productId)){
					allProdIdsSelected.push(productId);
				}							
			}						
       }
	}

	return allProdIdsSelected;	
}

//=================END FUNCTION CHECK WHEREVER CURRENT TAB HAVE CHANGE DATA TO SAVE===================//

//==============BEGIN TEST HAVE CHANGE DATA FOR SELLING TAB====================//
function checkDataChangeSellingTab()
{	
	var psProIdArrReturn = new Array();
								
	for(var i=0;i < Ex.dataSourceTemp.length;i++)
	{
			
		var comp = YAHOO.lang;
		var cK=Ex.dataSourceTemp[i].checkBox;									
		if(comp.trim(Ex.dataSourceTemp[i].subComHidden)!="0")
		{				
					var idRow =comp.trim(Ex.dataSourceTemp[i].idRowHidden);
					//get id to get Ps work id and psProdId
					var arrMainValue=idRow.split("__");	
					
					if(!psProIdArrReturn.inArray(arrMainValue[1]))
					{
						psProIdArrReturn.push(arrMainValue[1]);
					}	
																										
		}
			
	}
	return 	psProIdArrReturn;	
}

//==============END TEST HAVE CHANGE DATA FOR SELLING TAB====================//

//===========================BEGIN DELETE========================================//
 	<c:url value="/protected/cps/manageEDI/deleteEdi?${_csrf.parameterName}=${_csrf.token}" var="deleteEdi"></c:url>
 
 	function deleteEdi(evt) {
 		// get lst select PsWrkId
 		var lstPsWrkIds = new Array();
 		lstPsWrkIds = getLstSelectPsWrk();
 		// get lst select PsProdId
 		var allProdIdsSelected = new Array();
 	    allProdIdsSelected = getLstSelectPsProd();		
  		if (allProdIdsSelected.length > 0) {		
  			var message = confirm('Do you want to Delete selected UPC(s)?');
 			if (message) {
 				YAHOO.util.Dom.get('productSelectedIds').value = allProdIdsSelected;	
 				showProgress();		
 				var formObject = document.getElementById('searchForm');
 				formObject.action = "${deleteEdi}";		
 				formObject.submit();
 			}
 		} else {
 			alert('Please select UPC(s) that you want to delete');
 		}				
 	}

//===========================END DELETE========================================//
</script>
<style>
	#popupProgressDiv
	{

		position:absolute;
		height:300px;
		width:500px;
		bottom:0;
		left:0;
		right:0;
		top:0;
	}

	#loading
	{
		position:absolute;
	}
</style>
<div id="panel1" style="display: none;">
	<div class="hd">
		<div class="tl"></div>
		<span id="popupHeader"></span>	
		<div class="closeMe" onclick="closeIt();"></div>		
	</div>
	<div class="bd">
		<iframe id="popupFrame" height="1px" width="1px"></iframe>
		<div id="popupProgressDiv" style="display:none;visibility:visible;left:30%;z-index: 99999999; width: 240px; height: 70px;margin: 0 auto;" ><div style="cursor: auto;
		text-align: center;margin-top: 21px;color: black">Processing, please wait...</div><div  style="height: 29px;"><img id="loading" src="${loadingImage}"/></div></div>
	</div>
	<div class="ft">
		<div class="bl"></div>
		<div class="br"></div>
	</div>
</div>
<div id="simpledialog1" style="display: none;" class="yui-pe-content">
	<div class="hd" style = "height: 30px;">
		<span id="dialogHeader"></span>
	</div>
	<div class="bd">
		<iframe id="dialogFrame" height="1px" width="1px"></iframe>
	</div>
</div>
</body>
</html>
