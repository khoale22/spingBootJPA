<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>Add Case/Item</title>

	<link rel="stylesheet" href="<spring:url value='/hebAssets/common.css.jsp'></spring:url>" type="text/css" />

<jsp:include page="/common_head.jsp" />
<c:url value="${request.getContextPath()}/dwr/interface/AddCandidateTemp.js" var="myJs" />
<script type="text/javascript" src="${myJs}"></script>
<%
	/*
	 js for YUI ajax connectivity
	 */
%>
<c:url value="${request.getContextPath()}/yui/connection/connection-min.js" var="styleLink" />
<script type="text/javascript" src="${styleLink}"></script>
</head>
<body style="overflow: auto; visibility: visible;" class="popUpbody">
<div id="container" style="background-color: #D6DCE2;"><!-- END HEADER INCLUDE -->
<!-- End of Header --> <form:form
	action="/protected/cps/add" id="addItemForm" modelAttribute="addNewCandidate">
	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<fieldset
		style="margin-left: 6px; background-color: #FFFFFF; margin-right: 6px; padding-bottom: 5px; padding-top: 5px; width: 95%; color: #000000; height: 80px; overflow-x: auto; overflow-y: auto;">
	<table id="upcTble" align="center" width="95%" border="0"
		cellspacing="0" cellpadding="2" class="dataGrid">


		<tr>
			<td class="dataGridHead" align="left" class="labelFont" width="45%">Ingredient</td>
			<td class="dataGridHead" class="labelFont" align="left" width="10%">Sequence
			Number</td>
			<td class="dataGridHead" class="labelFont" align="left" width="45%"></td>
		</tr>
		<tr>
			<td align="left" class="dataGridHead" width="45%"><select
				name="SelectTagActionForm" property="singleSelect" tabindex="1"
				size="1" id="ingredient">
				<option value="3569 - semisweet chocolate">3569 - semisweet
				chocolate</option>
				<option value="2 - wasabi powder ">2 - wasabi powder</option>
				<option value="1017 - chestnut leaves">1017 - chestnut
				leaves</option>
				<option value="1 - acetic acid">1 - acetic acid</option>
				<option value="1002 - basil canola oil">1002 - basil canola
				oil</option>
				<option value="1004 - skim milk(part) ">1004 - skim
				milk(part)</option>
				<option value="1006 - jalapenos">1006 - jalapenos</option>
				<option value="1007 - textured vegetable protein ">1007 -
				textured vegetable protein</option>
				<option value="102 - thistle flower ">102 - thistle flower
				</option>
				<option value="1030 - vegetable oil ">1030 - vegetable oil
				</option>
			</select><br />
			<br />

			</td>

			<td align="left" class="dataGridHead" width="10%"><form:input
				path="ingdDesc" id="ingDesc" tabindex="2" maxlength="10" onkeypress="return isNumberKey(event)"></form:input></td>
			<td class="dataGridHead" class="labelFont" align="left" width="45%"  >
			<button type="button" id="assortAdd" name="assortAdd" value="add">Add</button>
			</td>
		<tr>
		</tr>

	</table>
	</fieldset>

	<fieldset
		style="margin-left: 6px; background-color: #FFFFFF; margin-right: 6px; padding-bottom: 5px; padding-top: 5px; width: 95%; color: #000000; height: 150px; overflow-x: auto; overflow-y: auto;">
	<table id="upcTble1" align="center" width="95%" border="0"
		cellspacing="0" cellpadding="2" class="dataGrid">

		<tbody id="secondTable">
			<tr>
				<td class="dataGridHead" class="labelFont" align="left" width="30%">Ingredient</td>
				<td class="dataGridHead" align="left" class="labelFont" width="30%">Sequence
				Number</td>

				<td class="dataGridHead" class="labelFont" align="left" width="20%"></td>
			</tr>
			<c:forEach items="${addNewCandidate.ingdVOs}" var="ingd" varStatus="loop" >
				<tr class="labelFont">
					<td align="left" width="30%" class="row0"><font
						class="labelFont"><c:out value="${ingd.ingdCode}"></c:out> </font></td>
					<td align="left" width="30%" class="row0"><font
						class="labelFont"><c:out value="${ingd.ingdDesc}"></c:out> </font></td>

					<td align="left" width="20%" class="row0">
					<button type="button" id="assortRemove${loop.index}" name="assortRemove"
						value="remove">Remove</button>
					</td>
				</tr>
				<c:set var="cnt" value="${loop.index}"></c:set>
			</c:forEach>
		</tbody>
	</table>
	</fieldset>
	<table width="100%">
		<tr>
			<td width="70%"></td>
			<td width="15%">
			<button type="button" id="assortSave" name="assortSave" value="save">Save</button>
			</td>
			<td width="15%">
			<button type="button" id="assortCancel" name="assortCancel"
				value="cancel">Cancel</button>

			</td>
		</tr>
	</table>
	<script type="text/javascript">
<c:url value="/protected/cps/add/ingredientFilter?${_csrf.parameterName}=${_csrf.token}" var="link"></c:url>

YAHOO.util.Event.addListener(YAHOO.util.Dom.get("assortAdd"), "click", moveToSecondTable1);
YAHOO.util.Event.addListener(YAHOO.util.Dom.get("assortCancel"), "click", toClose);
<c:forEach items="${addNewCandidate.ingdVOs}" var="ingd" varStatus="loop" >
	YAHOO.util.Event.addListener(YAHOO.util.Dom.get("assortRemove${loop.index}"), "click",
				function(evt){ deleteIngdVO('${ingd.uniqueId}','assortRemove${loop.index}') });
</c:forEach>

function removeIngd(uniqueId, rowId){
alert('remove clicked of first function');






 	hideProgress();
		for(var i=0;i < document.getElementById('secondTable').rows.length;i++){
			if( document.getElementById('secondTable').rows[i].id == rowId){
				document.getElementById('secondTable').deleteRow(i);
				colorTableRows('secondTable');
				break;
			}
		}





}
var ingr = YAHOO.util.Dom.get("ingredient");
var seqNumbr = YAHOO.util.Dom.get("ingDesc");

function moveToSecondTable1(evt){
	var ingredientVal = ingr.value;
    var seqNumber = seqNumbr.value;
 
    AddCandidateTemp.addIngdVO(ingredientVal,seqNumber,getDWRCallbackMethod(wrapper1));
}
function wrapper1(data){

addNewRow(data);
}



	
function addNewRow(data){
var addCount = 0;
addCount++;
var tmpCount = addCount;

	
		
            var rowLength = document.getElementById('upcTble1').rows.length; 
        	var newRow = document.getElementById('upcTble1').insertRow(-1);
			 
	   	    newRow.style.fontFamily = 'Verdana, Arial, Helvetica, sans-serif';
			newRow.style.fontSize = '12px';		
			var but = '<button type="button" id="assortRemoveAjax'+tmpCount+'" name="assortRemove" value="remove">Remove</button>';  		
      		var rowData = [ 
				data.ingdCode,
				data.ingdDesc,
				but
								
			];
			
			for (var i = 0; i < rowData.length; i++) {
        		newCell = newRow.insertCell(i);
        		newCell.innerHTML = rowData[i];
  				}
			
			YAHOO.util.Event.addListener(YAHOO.util.Dom.get("assortRemoveAjax"+tmpCount), "click", 
				function(evt){ deleteIngdVO(data.uniqueId,"assortRemoveAjax"+tmpCount) });
		
  		}

		

	
	
	
	function deleteIngdVO(evt,arr){

		var t = arr[0];
		var c = arr[1];
		AddCandidateTemp.removeIngdVOFromSecond( c );
		deleteRowWithButton(t);
		var tableName = "upcTble1";
		//function colorTableRows is in common.js
		colorTableRows(tableName);
	}
	
	
	
	function deleteRowWithButton(idd){
	
		for(var i=0;i< document.getElementById('upcTble1').rows.length;i++){
			var tableRow =  document.getElementById('upcTble1').rows[i];
			var cells = tableRow.cells;
			var lastCell = cells[cells.length - 1];
			if(lastCell.firstChild && lastCell.firstChild && lastCell.firstChild.firstChild 
					&&lastCell.firstChild.firstChild.firstChild && lastCell.firstChild.firstChild.firstChild.id ){
				var id1 = 'assortRemove' + idd;
				if(lastCell.firstChild.firstChild.firstChild.id == id1){
				
					 document.getElementById('upcTble1').deleteRow(i);
						
					break;
				}
			}
		}
	}
	

function toClose(evt){
	window.parent.execScript('f2();', "JavaScript");
}


function toVendor(evt){
	window.parent.execScript('popUp5();', "JavaScript");
}

function colorChangeRow(bodyId, color){
	var trow = document.getElementById(bodyId);
	var i=0;
	for(i=0;i<trow.cells.length;i++){
		trow.cells[i].style.backgroundColor = color;
	}
}
var clickedRow = null;
var clickedRowCount = null;
var mouseOver = null;
var mouseOut = null;

function makeRowClicked(bodyId,count,  color){
	if(clickedRow != null){
		colorChangeRow(clickedRow, '#F7F7F7');
		document.getElementById(clickedRow).onmouseover = mouseOver;
		document.getElementById(clickedRow).onmouseout = mouseOut;
	}
	colorChangeRow(bodyId, color);
	clickedRow = bodyId;
	clickedRowCount = count;
	mouseOver = document.getElementById(clickedRow).onmouseover;
	mouseOut = document.getElementById(clickedRow).onmouseout;
	document.getElementById(clickedRow).onmouseover = '';
	document.getElementById(clickedRow).onmouseout = '';
}
/*
function moveToSecondTable(){
	var ingUniq = document.getElementById('ingUniq'+clickedRowCount).value;
	document.getElementById('firstTable').deleteRow( document.getElementById('ingd'+clickedRowCount).rowIndex );
	showProgress();
AddCandidateTemp.addIngdVOToSecondList(ingUniq,getDWRCallbackMethod(organizeTable));
}

var addCount = 0;

function organizeTable(data){
	hideProgress();
	addCount++;
	var sectable = document.getElementById('secondTable');
	var newRow = sectable.insertRow(-1);
	newRow.id="ajaxRow"+addCount;
	var col = '#F7F7F7';
	var rowData = [ 
		'<input type="text" size="5" maxlength="2"/> <input type="hidden" id="ajaxHidden'+addCount+'" value="'+data.uniqueId+'" />',
		data.ingdCode,
		data.ingdDesc,
		'<div style="cursor: pointer;">'+
	'<a onmouseout="changeImage(document.getElementById(\'assortRemove\'),\'/cps/hebAssets/images/newButtons/remove_normal.gif\')"'+
	 'onmouseover="changeImage(document.getElementById(\'assortRemove\'),\'/cps/hebAssets/images/newButtons/remove_mouseclick.gif\')">'+
		'<img src="/cps/hebAssets/images/newButtons/remove_normal.gif" alt="" name="assortRemove'+addCount+'"  border="0" id="assortRemove" '+
		  ' />'+
	'</a>'+
'</div>'
		];
		
		for (var i = 0; i < rowData.length; i++) {
	        newCell = newRow.insertCell(i);
	        newCell.style.backgroundColor = col;
	        newCell.innerHTML = rowData[i];
   		}   		
YAHOO.util.Event.addListener(YAHOO.util.Dom.get("assortRemove"+addCount), "click", removeIngd, addCount);
	clickedRow = null;
	clickedRowCount = null;
	
} 

function removeIngd(evt, cnt){
	var uniquId = document.getElementById('ajaxHidden'+cnt).value;
	document.getElementById('secondTable').deleteRow(document.getElementById('ajaxRow'+cnt).rowIndex);
	AddCandidateTemp.removeIngdVOFromSecond(uniquId, getDWRCallbackMethod(aferRemove));
}

function aferRemove(data){
	filter(null);
}
*/

document.body.scroll = 'no';


function isNumberKey(evt)
      {
         var charCode = (evt.which) ? evt.which : event.keyCode
         if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;

         return true;
      }

</script>
</form:form></div>
</body>
</html>