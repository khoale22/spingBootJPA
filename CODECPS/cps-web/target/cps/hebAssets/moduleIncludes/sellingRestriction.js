var dataSourceSelling1 =[{
	"rowId" : 0,
	"checkBox": false,
    "sellingResId": "",
    "sellingResName": "sellingResName",
    "sellingResDisable":false,
    "sellingTypeId": "",
    "sellingTypeName": "sellingTypeName",
    "quantityRes": 1,
    "containAlcoholId": 1,
    "containAlcoholName": "containAlcoholName",
    "ofPreConsumptId": 1,
    "ofPreConsumptName": "ofPreConsumptName"
}];
var dataSourceSelling = [];
var dataSourceSellingOrg = [];
var dataSellingRestrictList = null;
var ratingRstredQty=0;
var rowidMax=0;
var modifyMode = false;
var ratingData = [];
var ratingDataContainAlYes = [];
var ratingDataContainAlNo = [];
var ratingDataResQty = [];

function changeSpecialCheckBox(rowId,isload){
	var specialCheckBox;
	var restrictionId;
	var sellingRestrictionOption;
	var salsRstrCd="101";
	var restrictionDivId;
	var sellingRatingId;
	if(rowId != null){
		specialCheckBox = document.getElementsByName("specialCheckBox"+rowId)[0];
		restrictionId = document.getElementById("restriction"+rowId);
		sellingRestrictionOption = document.getElementById("sellingRestrictionOption"+rowId);
		restrictionDivId = document.getElementById("restrictionDivId"+rowId);
		sellingRatingId = document.getElementById("sellingRatingId"+rowId);
	} else {
		specialCheckBox = document.getElementsByName("specialCheckBox")[0];
		restrictionId = document.getElementById("restriction");
		sellingRestrictionOption = document.getElementById("sellingRestrictionOption");
		restrictionDivId = document.getElementById("restrictionDivId");
		sellingRatingId = document.getElementById("sellingRatingId");
	}	
	restrictionId.innerHTML= "";
	//Dextromethorphan(10) or Lottery (8)
	if(sellingRestrictionOption.value=="10") { 
		salsRstrCd = specialCheckBox.checked && specialCheckBox.value=='Y' ? "100" : "101";
		restrictionDivId.style.width='450px';
		sellingRatingId.style.width='550px';
		if(salsRstrCd=='101') {
			restrictionDivId.style.width='180px';
			sellingRatingId.style.width='310px';
		} 
	} else if(sellingRestrictionOption.value=="8") {	
		salsRstrCd =specialCheckBox.checked && specialCheckBox.value=='Y' ? "24" : "102";
	}else if(sellingRestrictionOption.value=="11") {	
		salsRstrCd = specialCheckBox.checked && specialCheckBox.value=='Y' ? "103" : "104";
		restrictionDivId.style.width='450px';
		sellingRatingId.style.width='550px';
		if(salsRstrCd=='104') {
			restrictionDivId.style.width='180px';
			sellingRatingId.style.width='310px';
		} 
	}
	
	for (var i = 0; i < dataSourceSelling.length; i++) {
		var rowSelling = dataSourceSelling[i];			
		if(rowSelling["rowId"] == rowId){
			rowSelling["sellingTypeId"]= salsRstrCd;
			break;
		}
	}
	changeRatingType(sellingRestrictionOption.value,salsRstrCd,restrictionId);
}


function changecontainAlcoholOption(valueContainsAlcohol,rowId,isload){
	var sellingTypeOption;
	// var valueContainsAlcohol="N";
	var offPreConsumpOption;
	var restrictionId;
	var containAlcoholOption;
	if(rowId != null){
		sellingTypeOption = document.getElementById("sellingTypeOption"+rowId);
		offPreConsumpOption = document.getElementsByName("offPreConsumpOption"+rowId);
		restrictionId = document.getElementById("restriction"+rowId);
		containAlcoholOption = document.getElementsByName("containAlcoholOption"+rowId);
	} else {
		sellingTypeOption = document.getElementById("sellingTypeOption");
		offPreConsumpOption = document.getElementsByName("offPreConsumpOption");
		restrictionId = document.getElementById("restriction");
		containAlcoholOption = document.getElementsByName("containAlcoholOption");
	}	
	restrictionId.innerHTML= "";
	//console.log('-------------------------------------------------------------------------------'+rowId);
	if(valueContainsAlcohol =="Y") { 
		for(var i=0;i<offPreConsumpOption.length;i++) {			
			offPreConsumpOption[i].disabled = false;
			if(offPreConsumpOption[i].value=="Y") {
				offPreConsumpOption[i].checked=true;	
			}			
		}	
		
		if(isload==false){
			sellingTypeOption.disabled = false;
		}		
// 		reset selling type		
		sellingTypeOption.options.length=0;
		if(null != ratingDataContainAlYes) {
			for (var j = 0; j < ratingDataContainAlYes.length; j++) {
				sellingTypeOption.add(new Option(ratingDataContainAlYes[j]["ratingName"], ratingDataContainAlYes[j]["ratingId"]));				
			}
			sellingTypeOption.selectedIndex = 0;
		}
	}else {	
		sellingTypeOption.options.length=0;
		if(null != ratingData) {
			var indexNone = 0;
			for (var j = 0; j < ratingDataContainAlNo.length; j++) {
				sellingTypeOption.add(new Option(ratingDataContainAlNo[j]["ratingName"], ratingDataContainAlNo[j]["ratingId"]));
			}
			sellingTypeOption.selectedIndex = indexNone;
		}
		sellingTypeOption.disabled = true;
		sellingTypeOption.value="3";//default is NONE = 3
		restrictionId.innerHTML="No age restriction"; 
		for (var i = 0; i < dataSourceSelling.length; i++) {
			var rowSelling = dataSourceSelling[i];
			//Contain Alcohol is NO, Off Premise Consumption is empty when saving into database		
			if(rowSelling["rowId"] == rowId){				
				rowSelling["ofPreConsumptId"]= ' ';	
				break;
			} 		
		}
		//Always disable and uncheck Off Premise Consumption if Contain Alcohol is NO
		for(var i=0;i<offPreConsumpOption.length;i++) {			
			offPreConsumpOption[i].disabled = true;	
			offPreConsumpOption[i].checked=false;			
		}
	}
	if(rowId!=null && isload == false){
		for (var i = 0; i < dataSourceSelling.length; i++) {
			var rowSelling = dataSourceSelling[i];			
			if(rowSelling["rowId"] == rowId){
				if(valueContainsAlcohol!=null){
					rowSelling["containAlcoholId"]= valueContainsAlcohol;
					dataSourceSelling[i]["sellingTypeId"] = sellingTypeOption.value;
				} else {
					rowSelling["containAlcoholId"]= "-1";	
				}																													 				
				break;
			} 		
		}
	}
	var max=0;
	for(var i=0; i< sellingTypeOption.options.length; i++){
		if(sellingTypeOption.options[i].text.length>max){
			max =sellingTypeOption.options[i].text.length;
		}
	}	
	sellingTypeOption.style.width= (valueContainsAlcohol=='N' ? max*10 : max*8) +"px";
	showAdd();
	showSellingRestriction(false);
	showDropdownToolTip(sellingTypeOption);
}

function showDropdownToolTip(element) {
	if(element!=null && element.selectedIndex >=0) {
		element.title = element.options[element.selectedIndex].text;
	}
}

function changeOffPreConsumpOption(element,rowId){
	if(rowId!=null){
		for (var i = 0; i < dataSourceSelling.length; i++) {
			var rowSelling = dataSourceSelling[i];			
			if(rowSelling["rowId"] == rowId){				
				rowSelling["ofPreConsumptId"]= element.value;	
				rowSelling["ofPreConsumptName"]= element.text;																																	 				
				break;
			} 		
		}
	}
}
function filterAlcoOffPreConTrue(value) {
    return (value == "1" || value == "2");
}

function changeSellingResOption(element,rowId,sellingType,alcohol,offPremiseConsumption,isload, isProduct){
	var containAlcoholArea;
	var offPreConsumpArea;
	var sellTypOpId ;
	var specialCheckBox;
	if(rowId !=null){
		offPreConsumpArea = document.getElementById("offPreConsumpArea"+rowId);
		containAlcoholArea = document.getElementById("containAlcoholArea"+rowId);
		sellTypOpId = document.getElementById("sellingTypeOption"+rowId);
		specialCheckBox = document.getElementsByName("specialCheckBox"+rowId)[0];
	} else {
		offPreConsumpArea = document.getElementById("offPreConsumpArea");
		containAlcoholArea = document.getElementById("containAlcoholArea");
		sellTypOpId = document.getElementById("sellingTypeOption");
		specialCheckBox = document.getElementsByName("specialCheckBox")[0];
	}
	//console.log('rowId='+rowId+'~~~~~~~~~~'+isload);
	if(rowId!=null && isload ==false){
		if(validateDuplicateSaveRowSelling(rowId)){
			alert("Only one type is allowed per Selling Restriction code. Please edit the added row if you would like to change.");
			rewriteUiSelling(dataSourceSelling,true);
			return;
		} else if(rowId!=null){
			for (var i = 0; i < dataSourceSelling.length; i++) {
				var rowSelling = dataSourceSelling[i];	
				if(rowSelling["rowId"] == rowId){
					rowSelling["sellingResId"]= element.value;
					rowSelling["sellingResName"]= element.text;
					if(element.value == "-1"){
						rowSelling["sellingTypeId"] = "-1";
					}
					break;
				} 		
			}
		}
	}
	//console.log(alcohol);	
	if(element.value =="-1"){
		document.getElementById("btnNewSelling").disabled = true;
		if(null != containAlcoholArea){
			containAlcoholArea.style.display = "none";
		}
		if(null != offPreConsumpArea){
			offPreConsumpArea.style.display = "none";
		}
		if(alcohol==null){
			alcohol = "N";
		}	
	} else {
		document.getElementById("btnNewSelling").disabled = false;
		if(element.value =="1") { // is Alcohol
			if(null != containAlcoholArea){
				containAlcoholArea.style.display = "block";
			}
			if(null != offPreConsumpArea){
				offPreConsumpArea.style.display = "block";
			}		
		}else {
			if(null != containAlcoholArea){
				containAlcoholArea.style.display = "none";
			}
			if(null != offPreConsumpArea){
				offPreConsumpArea.style.display = "none";
			}
			if(specialCheckBox!=null) {
				//Dextromethorphan(10) or Lottery (8)
				// PIM-1686 No default value for Dextromethorphan(10)
				//if(element.value=="10") {
				//	sellingType = sellingType=="" ? (specialCheckBox.checked && specialCheckBox.value=='Y' ? "100" : "101") : sellingType;
				//} else
				if(element.value=="8") {
					sellingType = sellingType=="" ? (specialCheckBox.checked && specialCheckBox.value=='Y' ? "24" : "102") : sellingType;
				} else if(element.value=="11") {
					sellingType = sellingType=="" ? (specialCheckBox.checked && specialCheckBox.value=='Y' ? "103" : "104") : sellingType;
				}
			}
		}
		if(alcohol==null){
			alcohol = "Y";
		}	
		if(!(element.value=="10" || element.value=="8" || element.value=="11")) {
			if(!modifyMode){
				sellTypOpId.disabled = true;
			}else{
				sellTypOpId.disabled = false;	
			}
		}
		showAdd();
		showSellingRestriction(false);			
		changeDDRateType(element.value,null,rowId,sellingType,alcohol,offPremiseConsumption,isload,isProduct);
	}
}

function changeSellingTypeOption(element,rowId){
	var quantityResId;
	var restrictionId;
	var sellingRestrictionOption;
	if(rowId !=null){
		quantityResId = document.getElementById("quantityResId"+rowId);
		restrictionId = document.getElementById("restriction"+rowId);
		sellingRestrictionOption = document.getElementById("sellingRestrictionOption"+rowId);
	} else {
		quantityResId = document.getElementById("quantityResId");
		restrictionId = document.getElementById("restriction");
		sellingRestrictionOption = document.getElementById("sellingRestrictionOption");
	}
	if(rowId!=null){
		for (var i = 0; i < dataSourceSelling.length; i++) {
			var rowSelling = dataSourceSelling[i];			
			if(rowSelling["rowId"] == rowId){
				rowSelling["sellingTypeId"]= element.value;		
				break;
			} 		
		}
	}
	//console.log(sellingRestrictionOption.value+":::"+element.value);
	restrictionId.innerHTML='';
	showDropdownToolTip(element);
	if(element.value>=0) {
		changeRatingType(sellingRestrictionOption.value,element.value,restrictionId);
	}
	showAdd();	
}

function getRestrictionName(ratingId) {
	var name ='';
	if(null != ratingData) {
		for (var i = 0; i < ratingData.length; i++) {
			if(ratingData[i].ratingId == ratingId){
				//Dextromethorphan(10) or Lottery (8)
				if(ratingData[i].ratingRstredQty>0 && (ratingData[i].salsRstrGrpCd=="10" || ratingData[i].salsRstrGrpCd=="11")) {
					name = ratingData[i].minRstrAgeNbr+" years and older, Quantity Limit = "
					+ratingData[i].ratingRstredQty + (ratingData[i].salsRstrGrpCd=="11"? " tablets per "+ratingData[i].ratingRstredQty + " days" :" per Customer Order");
				} else {
					name = ratingData[i].minRstrAgeNbr =="0" ? "No age restriction" :  ratingData[i].minRstrAgeNbr +" years and older";
				}
				break;
			}
		}
	}
	return name;
}

function validateSaveRowSelling(rowId){
	var returnResult = false;
	var sellResOpId;
	var sellTypOpId;
	if(rowId !=null){
		sellResOpId = document.getElementById("sellingRestrictionOption"+rowId);
		sellTypOpId = document.getElementById("sellingTypeOption"+rowId);
	} else {
		sellResOpId = document.getElementById("sellingRestrictionOption");
		sellTypOpId = document.getElementById("sellingTypeOption");
	}
	if(sellResOpId.options[sellResOpId.selectedIndex].value !="-1" && sellTypOpId.options[sellTypOpId.selectedIndex].value !="-1"){
		returnResult = true;
	}
	return returnResult;
}

function validateDuplicateSaveRowSelling(rowId){
	var returnResult = false;
	var sellResOpId;
	if(rowId !=null){
		sellResOpId = document.getElementById("sellingRestrictionOption"+rowId);
	} else {
		sellResOpId = document.getElementById("sellingRestrictionOption");
	}	 
	for (var i = 0; i < dataSourceSelling.length; i++) {
		var rowSelling = dataSourceSelling[i];			
		if(rowSelling["sellingResId"] == sellResOpId.options[sellResOpId.selectedIndex].value){
			returnResult = true;
			break;
		} 		
	}
	return returnResult;
}

function saveRowSelling(){
	if(validateSaveRowSelling()) {
		if(!validateDuplicateSaveRowSelling()){
			if(dataSourceSelling != null && dataSourceSelling.length > 0) {
				for (var i = 0; i < dataSourceSelling.length; i++) {
					var rowSelling = dataSourceSelling[i];
					var rowSellingId = document.getElementById("rowId").value;
					if(null != rowSelling && rowSelling["rowId"] == rowSellingId){
						var sellResOpId = document.getElementById("sellingRestrictionOption");
						var sellTypOpId = document.getElementById("sellingTypeOption");
						if(sellResOpId){
							rowSelling["sellingResId"] = sellResOpId.options[sellResOpId.selectedIndex].value;
							rowSelling["sellingResName"] = sellResOpId.options[sellResOpId.selectedIndex].text;
						}
						if(sellTypOpId){
							rowSelling["sellingTypeId"] = sellTypOpId.options[sellTypOpId.selectedIndex].value;
							rowSelling["sellingTypeName"] = sellTypOpId.options[sellTypOpId.selectedIndex].text;
						}
						if(document.getElementById("quantityResId")){
							rowSelling["quantityRes"] = document.getElementById("quantityResId").value;
						}
						if(document.getElementById("sellingRestrictionOption").value == "1") { //is Alcohol
							var containAlcoholAreaId = document.getElementById("containAlcoholOption");
							if(null != containAlcoholAreaId){
								rowSelling["containAlcoholId"] = containAlcoholAreaId.options[containAlcoholAreaId.selectedIndex].value;
								rowSelling["containAlcoholName"] = containAlcoholAreaId.options[containAlcoholAreaId.selectedIndex].text;
							}
							var offPreConsumpAreaId = document.getElementById("offPreConsumpOption");
							if(null != offPreConsumpAreaId){
								rowSelling["ofPreConsumptId"] = offPreConsumpAreaId.options[offPreConsumpAreaId.selectedIndex].value;
								rowSelling["ofPreConsumptName"] = offPreConsumpAreaId.options[offPreConsumpAreaId.selectedIndex].text;
							}
						}
//		 				Update data for html
						if(rowSelling["sellingResId"] != "-1"){
							document.getElementById("sellingRestTxt"+rowSellingId).value = rowSelling["sellingResName"];
						}
						if(rowSelling["sellingTypeId"] != "-1"){
							document.getElementById("sellingTypeTxt"+rowSellingId).value = rowSelling["sellingTypeName"];
						}
						document.getElementById("quantityRestTxt"+rowSellingId).value = rowSelling["quantityRes"];
						break;
					}
				}
				
			}
		}else {
			alert("Only one type is allowed per Selling Restriction code. Please edit the added row if you would like to change.");
		}
	}else {
		alert("Please add a new row and make selections before applying.");
	}
}

function addRowSelling(isLoad, val){
	if(null != dataSourceSelling) {		
		var rowToAdd = new Object();
		rowToAdd["rowId"] = rowidMax;			
		rowToAdd["sellingResId"] = "-1";
		rowToAdd["sellingResName"] = "";
		rowToAdd["sellingResDisable"] = false;
		rowToAdd["sellingTypeId"] = "-1";
		rowToAdd["sellingTypeName"] = "";
		rowToAdd["quantityRes"] = 0;
		rowToAdd["containAlcoholId"] = "-1";			
		rowToAdd["ofPreConsumptId"] = "-1";
		rowToAdd["ofPreConsumptName"] = "";
		rowToAdd["isProduct"] = false;
		rowToAdd["sellingResDisable"] = false;
		if(isLoad==false){				
			rowToAdd["sellingResId"] = val.options[val.selectedIndex].value;
			rowToAdd["sellingResName"] = val.options[val.selectedIndex].text;
		}

		if((isLoad ==true || !validateDuplicateSaveRowSelling(null))){
			if(rowToAdd["sellingResName"]!="" && rowToAdd["sellingResId"]!="-1") {
				rowidMax = rowidMax+1;
				rowToAdd["rowId"] = rowidMax;
				//console.log('addRowSelling'+rowToAdd["sellingResName"]);
				if(dataSourceSelling != null && dataSourceSelling.length > 0) {				
					dataSourceSelling.push(rowToAdd);				
					var htmlStr = tableSellingId.innerHTML + addRowSellingHtml(rowToAdd,false,rowToAdd["sellingResName"]);
					tableSellingId.innerHTML = htmlStr;						
				}else {
					dataSourceSelling.push(rowToAdd);
					tableSellingId.innerHTML = addRowSellingHtml(rowToAdd,true,rowToAdd["sellingResName"]);
				}
				if(dataSourceSelling.length > 1){
					for (var i = 0; i < dataSourceSelling.length; i++) {
						var item = document.getElementById("btn-delete"+dataSourceSelling[i]["rowId"]);
						if(item){
							document.getElementById("btn-delete"+dataSourceSelling[i]["rowId"]).style.display='block';
						}
					}
				}
				showSellingRestriction(false);
				if(isLoad==false){
					//default values
					if(rowToAdd["sellingResId"]=="1"){
						rowToAdd["containAlcoholId"] = "Y";			
						rowToAdd["ofPreConsumptId"] = "Y";
						rowToAdd["sellingTypeId"] = "-1";
					}
					changeSellingResOption(document.getElementById("sellingRestrictionOption"+rowToAdd["rowId"]),rowToAdd["rowId"],rowToAdd["sellingTypeId"],rowToAdd["containAlcoholId"],rowToAdd["ofPreConsumptId"],true,rowToAdd["isProduct"]);					
					if(rowToAdd["sellingResId"]=="1"){
						changecontainAlcoholOption(rowToAdd["containAlcoholId"],rowToAdd["rowId"],true);
					}
				}
				rewriteUiSelling(dataSourceSelling,true);
			} else {
				document.getElementById("btnNewSelling").disabled = !modifyMode;
			}
		} else {
			alert("Only one type is allowed per Selling Restriction code. Please edit the added row if you would like to change.");
		}
	} else {
		alert("Selling Restriction and Type are mandatory fields.");
	}
}

function resetSellingResArea(){	
	if(null != document.getElementById("sellingRestrictionOption")){
		document.getElementById("sellingRestrictionOption").disabled = false;
		document.getElementById("sellingRestrictionOption").value = "-1";
	}
	var sellTypOpId = document.getElementById("sellingTypeOption");
	//sellTypOpId.options.length=0;
	//sellTypOpId.add(new Option("--Select--", "-1"));
	if(null != document.getElementById("sellingTypeOption")){
		document.getElementById("sellingTypeOption").disabled = false;
		document.getElementById("sellingTypeOption").value = "-1";
	}
	if(null != document.getElementById("containAlcoholArea")){
		document.getElementById("containAlcoholArea").style.display = "none";
	}
	if(null != document.getElementById("offPreConsumpArea")){
		document.getElementById("offPreConsumpArea").style.display = "none";
	}
}

function resetToDefault() {
    editRowSellResData =null;
	var sellTypOpId = document.getElementById("sellingTypeOption");
	sellTypOpId.options.length=0;
	sellTypOpId.add(new Option("--Select--", "-1"));
	sellTypOpId.style.display = "block";
	sellTypOpId.disabled=false;

	if(document.getElementById("containAlcoholArea")!=null) {
		document.getElementById("containAlcoholArea").style.display = "none";
	}
	if(document.getElementById("offPreConsumpArea")!=null) {
		document.getElementById("offPreConsumpArea").style.display = "none";
	}
	if(document.getElementById("quantityResId")!=null) {
		document.getElementById("quantityResId").value="";
	}
}

function deleteRowSelling(rowId){
	if(dataSourceSelling != null && dataSourceSelling.length > 0) {			
		if (confirm("Are you sure you want to delete the selling restriction?")) {
			tableSellingId.innerHTML="";      
			for (var f = 0; f < dataSourceSelling.length ; f++) {			
				if(dataSourceSelling[f]["rowId"]==rowId){
					dataSourceSelling.splice(f,1); 			    				
					break;
				}		
			}
			rewriteUiSelling(dataSourceSelling,true);
			resetSellingResArea();
		}
	}
}
function bindDataIntoSellResHtml(rowSelling){
//	Update data for html
	var rowSellingId = rowSelling["rowId"]
	if(rowSelling["sellingResId"] != "-1"){
		document.getElementById("sellingRestTxt"+rowSellingId).value = rowSelling["sellingResName"];
	}
	if(rowSelling["sellingTypeId"] != "-1"){
		document.getElementById("sellingTypeTxt"+rowSellingId).value = rowSelling["sellingTypeName"];
	}
	if(rowSelling["quantityRes"] != null && rowSelling["quantityRes"] > 0){
		document.getElementById("quantityRestTxt"+rowSellingId).value = rowSelling["quantityRes"];
	}
}

function addRowSellingHtml(rowToAdd,isFirst,sellingRestrictionText){	
    var cssNotAlcolhol ="float: left; width: 440px";
	var cssRestriction ="float:left;width:215px;margin-left:45px";
	var cssRestrictionName ="float: left;width:120px";
	var sellingRestrictionName = sellingRestrictionText;
	if(rowToAdd["sellingResId"]!="1") {
		cssNotAlcolhol ="float: left; width: 450px";
		cssRestriction ="float:left;width:200px;margin-left:65px";
	}
	if(rowToAdd["sellingResId"]=="10" || rowToAdd["sellingResId"]=="11") {
		cssRestriction ="float:left;width:420px;margin-left:45px";
		cssNotAlcolhol ="float: left; width: 540px";
	}
	if(rowToAdd["sellingResId"]=="8") {
		cssNotAlcolhol ="float:left;width:340px;";
		cssRestriction ="float:left;width:240px;margin-left:45px";
		cssRestrictionName ="float: left;width:100px";
	}
	//Dextromethorphan(10) or Lottery (8)
	if(rowToAdd["sellingResId"]=="10" || rowToAdd["sellingResId"]=="11") {
		sellingRestrictionName = "Contains "+ sellingRestrictionText+ "?<a style='color: red'>*</a>";
	} else if(rowToAdd["sellingResId"]=="8") {
		sellingRestrictionName = sellingRestrictionText+ " Ticket?<a style='color: red'>*</a>";
	} else if(rowToAdd["sellingResId"]=="3") {
		sellingRestrictionName = "Movie Rating";
	}
	var rowStr =		
		'<div style="padding-bottom:7px">';
			if(rowToAdd["sellingResId"]!="1") {
				rowStr = rowStr + '<div style="'+cssRestrictionName+'">' + sellingRestrictionName +'</div>';
			}
			rowStr =rowStr+''+
		'<div style="display: none;float: left; width:180px" id="containAlcoholArea'+rowToAdd["rowId"]+'">'+
'<input type="hidden" id="sellingRestrictionOption'+rowToAdd["rowId"]+'" value="'+rowToAdd["sellingResId"]+'"/>'+		
'<input type="hidden" id="sellingRestrictionText'+rowToAdd["rowId"]+'" value="'+sellingRestrictionText+'"/>'+	
				'<div style="float: left; width: 70px; word-wrap: break-word; ">'+
					'Contains Alcohol? <a style="color: red">*</a>'+
				'</div>'+
				'<div style="float: left;" >'+
					'<input type="radio" name="containAlcoholOption'+rowToAdd["rowId"]+'" value="Y" onclick="changecontainAlcoholOption(this.value,'+rowToAdd["rowId"]+',false)" checked';
  					if(rowToAdd["isProduct"]==true || !modifyMode){
						rowStr =rowStr + ' disabled ';		
					}
					rowStr =rowStr + '> YES<br>'+	 					
					'<input type="radio" name="containAlcoholOption'+rowToAdd["rowId"]+'" value="N" onclick="changecontainAlcoholOption(this.value,'+rowToAdd["rowId"]+',false)"';
					if(rowToAdd["isProduct"]==true || !modifyMode){
						rowStr =rowStr + ' disabled ';		
					}
					rowStr =rowStr + '> NO<br>'+			
  					 							
			'</div>'+
		'</div>'+
		'<div style="display: none;float: left;width:200px" id="offPreConsumpArea'+rowToAdd["rowId"]+'">'+		
				'<div style="float: left; width: 100px ;word-wrap: break-word;">'+
					'Off Premise Consumption? <a style="color: red">*</a>'+
				'</div>'+
				'<div style="float: left;" >'+	
					'<input type="radio" name="offPreConsumpOption'+rowToAdd["rowId"]+'" value="Y"  checked onclick="changeOffPreConsumpOption(this,'+rowToAdd["rowId"]+')"';
  					if(rowToAdd["isProduct"]==true || !modifyMode){
						rowStr =rowStr + ' disabled ';		
					}
  					rowStr =rowStr + '> YES<br>'+			
					'<input type="radio" name="offPreConsumpOption'+rowToAdd["rowId"]+'" value="N" onclick="changeOffPreConsumpOption(this,'+rowToAdd["rowId"]+')"';
					if(rowToAdd["isProduct"]==true || !modifyMode){
						rowStr =rowStr + ' disabled ';		
					}
					rowStr =rowStr + '> NO<br>'+  					
				'</div>'+				
		'</div>'+	
		'<div style="'+cssNotAlcolhol+'" id="sellingRatingId'+rowToAdd["rowId"]+'">';
			if(rowToAdd["sellingResId"]=="8" || rowToAdd["sellingResId"]=="10" || rowToAdd["sellingResId"]=="11") {
				rowStr = rowStr + '<div style="float: left;" >'+
					'<input type="radio" name="specialCheckBox'+rowToAdd["rowId"]+'" value="Y" onclick="changeSpecialCheckBox('+rowToAdd["rowId"]+',false)"';
  					if(!modifyMode){
						rowStr =rowStr + ' disabled';		
					}
					rowStr =rowStr + '> YES<br>'+	 					
					'<input type="radio" name="specialCheckBox'+rowToAdd["rowId"]+'" value="N" onclick="changeSpecialCheckBox('+rowToAdd["rowId"]+',false)"';
					if(!modifyMode){
						rowStr =rowStr + ' disabled';		
					}
					rowStr =rowStr + '> NO<br></div>';
			} else {
				rowStr =rowStr + '<div style="float: left;width:50px">'+
					'Type <a style="color: red">*</a>'+
				'</div>'+
				'<div style="float: left;width: 120px" >'+
					'<select id="sellingTypeOption'+rowToAdd["rowId"]+'" style="width: 120px" onchange="changeSellingTypeOption(this,'+rowToAdd["rowId"]+')"';
					if(!modifyMode){
						rowStr =rowStr + ' disabled ';		
					}
					rowStr =rowStr + '>'+
						'<option value="-1"> --Select-- </option>'+					
					'</select>'+
				'</div>';
			} 
			rowStr =rowStr+''+
			'<div style="'+cssRestriction+'" id="restrictionDivId'+rowToAdd["rowId"]+'">'+ 'Restriction&nbsp;&nbsp;&nbsp;<span id="restriction'+rowToAdd["rowId"]+'"></span></div>'+
			'<div style="float: left; width: 40px ; padding-left: 5px">'+
				'<input type="hidden" style="width: 40px" disabled="disabled" id="quantityResId'+rowToAdd["rowId"]+'"/>'+
			'</div>'+
		'</div>';
		//sellingResDisable=false if there are no data from sub-commodity
		//newDataSw=='Y' if User is creating candidate, copy candidate & product
		// isRenderView get from posAndAccounting.jsp, check render View of Selling Restriction Area
		if(rowToAdd["sellingResDisable"]==false && newDataSw=='Y' && modifyMode){
			rowStr = rowStr + '<div style="float: left;" id="btn-delete'+rowToAdd["rowId"]+'">' +		
					'<img src="/cps/hebAssets/images/delete.png" style="cursor: pointer;" ' +
					(isRenderView ? '' : ('onclick="deleteRowSelling(' + rowToAdd["rowId"] + ')" ')) + '>';		
			rowStr = rowStr + '</div>';	
		}
	rowStr = rowStr +'</div><br>';	
	return rowStr;
}

function setDataDefaultForSellingTable(dataSelling){
	dataSourceSelling = [];
	tableSellingId.innerHTML = "";
	flagExist=false;
	if(null != dataSelling && dataSelling.length > 0){
		var dataSellingList = dataSelling[0].rateType;		
		if(null != dataSellingList && dataSellingList.length > 0){
			var flagFirst =true;
			var rowId = 0;
			for(var x in dataSelling){
				if(dataSelling[x].rateTypeSelected != "-1"){
//	 				get name of selling 
					for(var i in dataSellingList){
						var dataItemSelling = dataSellingList[i];
						if(dataSelling[x].rateTypeSelected == dataItemSelling.rateTypeId){
							var rowToAdd = new Object();
							rowToAdd["rowId"] = rowId;
							rowToAdd["checkBox"] = false;
							rowToAdd["sellingResId"] = dataItemSelling.rateTypeId;
							rowToAdd["sellingResName"] = dataItemSelling.rateTypeName;
							rowToAdd["sellingResDisable"] = true;
							rowToAdd["sellingTypeId"] = "-1";
							rowToAdd["sellingTypeName"] = "";
							rowToAdd["quantityRes"] = 0;
							rowToAdd["containAlcoholId"] = "Y";
							// rowToAdd["containAlcoholName"] = "";
							rowToAdd["ofPreConsumptId"] = "Y";
							rowToAdd["ofPreConsumptName"] = "";
							rowToAdd["isProduct"] = false;
							
							if(rowToAdd["sellingResId"]=="1"){
								rowToAdd["sellingTypeId"] = "-1";								
							}					
							if(dataSourceSelling != null && dataSourceSelling.length > 0) {
								rowId = rowId + 1;
								rowToAdd["rowId"] = rowId;
								dataSourceSelling.push(rowToAdd);
								var htmlStr =  tableSellingId.innerHTML+ addRowSellingHtml(rowToAdd,flagFirst,dataItemSelling.rateTypeName);
								tableSellingId.innerHTML = htmlStr;
							}else {								
								dataSourceSelling.push(rowToAdd);
								tableSellingId.innerHTML = addRowSellingHtml(rowToAdd,flagFirst,dataItemSelling.rateTypeName);
							}
							flagFirst = false;
							changeSellingResOption(document.getElementById("sellingRestrictionOption"+rowToAdd["rowId"]),rowToAdd["rowId"],rowToAdd["sellingTypeId"],rowToAdd["containAlcoholId"],rowToAdd["ofPreConsumptId"],true,rowToAdd["isProduct"]);
							if(dataItemSelling.rateTypeId=="1"){
								changecontainAlcoholOption(rowToAdd["containAlcoholId"],rowToAdd["rowId"],true);
							}
							break;
						} 
					}
				} else {
					break;
				}
			}
			rowidMax = dataSourceSelling.length;
			if(flagExist==false && dataSourceSelling.length==0){
				addRowSelling(true,null);
			}
		} 		
	} else {		
		dataSourceSelling = [];
		//console.log('111111111111111');
		addRowSelling(true,null);
	}
}

function resetToDefaultWhenChangeSub() {
	editRowSellResData =null;
	var sellTypOpId = document.getElementById("sellingTypeOption");
	sellTypOpId.options.length=0;
	sellTypOpId.add(new Option("--Select--", "-1"));
	sellTypOpId.style.display = "block";
	// sellTypOpId.disabled = true;
	var sellingRestrictionOption = document.getElementById("sellingRestrictionOption");
	sellingRestrictionOption.selectedIndex=0;
	if(document.getElementById("containAlcoholArea")!=null) {
		document.getElementById("containAlcoholArea").style.display = "none";
	}
	if(document.getElementById("offPreConsumpArea")!=null) {
		document.getElementById("offPreConsumpArea").style.display = "none";
	}
}

function updateRatingOption(dataRating,rowId,sellingType,alcohol,offPremiseC,isload,isProduct){
	var element ;
	var elementSelling;
	var containAlcoholOption;
	var offPreConsumpOption;
	var specialCheckBox;
	var restrictionId;
	var sellingRatingId;
	var restrictionDivId;
	if(rowId!=null){
	 	element = document.getElementById("sellingTypeOption"+rowId);
	 	elementSelling = document.getElementById("sellingRestrictionOption"+rowId);
	 	containAlcoholOption = document.getElementsByName("containAlcoholOption"+rowId);	 
	 	offPreConsumpOption = document.getElementsByName("offPreConsumpOption"+rowId);	
		specialCheckBox = document.getElementsByName("specialCheckBox"+rowId);		
		restrictionId = document.getElementById("restriction"+rowId);
		sellingRatingId = document.getElementById("sellingRatingId"+rowId);		
		restrictionDivId = document.getElementById("restrictionDivId"+rowId);
	} else {
		element = document.getElementById("sellingTypeOption");
	 	elementSelling = document.getElementById("sellingRestrictionOption");
	 	containAlcoholOption = document.getElementsByName("containAlcoholOption");	 
	 	offPreConsumpOption = document.getElementsByName("offPreConsumpOption");	
		specialCheckBox = document.getElementsByName("specialCheckBox");
		restrictionId = document.getElementById("restriction");		
		sellingRatingId = document.getElementById("sellingRatingId");		
		restrictionDivId = document.getElementById("restrictionDivId");
	}
	//console.log('specialCheckBox:'+specialCheckBox);
	//console.log('elementSelling:'+elementSelling.value);
	//console.log('sellingType:'+sellingType);
	//console.log('offPremiseC:'+offPremiseC);
	//console.log('alcohol:'+alcohol);
	if(specialCheckBox && (elementSelling.value =="10" || elementSelling.value =="8" || elementSelling.value =="11")) {
		if(dataRating.rating.length > 0) {
			ratingData = dataRating.rating;	
		}
		//Dextromethorphan(10) or Lottery (8)
		// PIM-1686 No default value for Dextromethorphan(10)
		if((elementSelling.value =="10" && sellingType!=-1) || elementSelling.value =="8" || elementSelling.value =="11") {	
			var checkboxValue = "N";
			if(sellingType==-1|| sellingType=='24' || sellingType=='100' || sellingType=='103') {
				checkboxValue = "Y";
			}
			//Copy product
			//console.log('----'+newDataSw);
			for (var i = 0; i < dataSourceSelling.length; i++) {
				var rowSelling = dataSourceSelling[i];			
				if(rowSelling["rowId"] == rowId){
					for(var i=0;i<specialCheckBox.length;i++) {
						// isRenderView get from posAndAccounting.jsp, check render View of Selling Restriction Area
						specialCheckBox[i].disabled=(newDataSw =='N' || !modifyMode || isRenderView);
					}
					break;
				}
			}
			for(var i=0;i<specialCheckBox.length;i++) {
				if(specialCheckBox[i].value==checkboxValue){
					specialCheckBox[i].checked = true;
					break;
				}
			}
			for (var i = 0; i < dataSourceSelling.length; i++) {
				var rowSelling = dataSourceSelling[i];			
				if(rowSelling["rowId"] == rowId){
					for(var i=0;i<specialCheckBox.length;i++) {
						if(specialCheckBox[i].checked==true){
							if(elementSelling.value =="10") {
								rowSelling["sellingTypeId"]= "100";	
								if(specialCheckBox[i].value=='N') {
									rowSelling["sellingTypeId"]= "101";	
								}
							} else if(elementSelling.value =="8") {
								rowSelling["sellingTypeId"]= "24";	
								if(specialCheckBox[i].value=='N') {
									rowSelling["sellingTypeId"]= "102";	
								}
							} else if(elementSelling.value =="11") {
								rowSelling["sellingTypeId"]= "103";	
								if(specialCheckBox[i].value=='N') {
									rowSelling["sellingTypeId"]= "104";	
								}
							}
							break;
						}						
					}
					break;
				}
			}
			//console.log(rowSelling["sellingTypeId"]);
			restrictionId.innerHTML = getRestrictionName(rowSelling["sellingTypeId"]);
			if(elementSelling.value =="10" || elementSelling.value =="11") {	
				sellingRatingId.style.width= checkboxValue=='N' ? '300px' :'540px';
				restrictionDivId.style.width=checkboxValue=='N' ? '200px' :'420px';
			}
		}		
	}
	if(element){	
		element.options.length = 0;	
		if(dataRating.rating.length > 0) {
			ratingData = dataRating.rating;		
			if(elementSelling.value =="1") {//Alcohol
				ratingDataContainAlYes = [];	
				ratingDataContainAlNo = [];
				ratingDataContainAlYes.push({ratingId:"-1",ratingName:"--Select--"});
				for (var i = 0; i < dataRating.rating.length; i++) {				
					var rowToAdd = new Object();
					rowToAdd["ratingId"] = dataRating.rating[i].ratingId;
					rowToAdd["ratingName"] = dataRating.rating[i].ratingName;				
					if(dataRating.rating[i].ratingId == "3"){ //NONE Alcohol
						ratingDataContainAlNo.push(rowToAdd);
					} else {			
						ratingDataContainAlYes.push(rowToAdd);
					}
				}				
			}
		}else {
			element.add(new Option("--Select--", "-1"));
		}
		var max=0;				
		if(elementSelling.value =="1") {//Alcohol		
			if(alcohol=="Y"){
				for (var i = 0; i < ratingDataContainAlYes.length; i++) {
					element.add(new Option(ratingDataContainAlYes[i]["ratingName"] + "", ratingDataContainAlYes[i]["ratingId"]));
				}			
			} else {
				for (var i = 0; i < ratingDataContainAlNo.length; i++) {
					element.add(new Option(ratingDataContainAlNo[i]["ratingName"], ratingDataContainAlNo[i]["ratingId"]));						
				}
				 element.disabled = true;
			}		
			if(alcohol!=null){
				for(var i=0;i<containAlcoholOption.length;i++) {
					if(containAlcoholOption[i].value==alcohol){
					    containAlcoholOption[i].checked = true;
					    break;
					}
				}					
			}
			if(offPremiseC!=null){
				for(var i=0;i<offPreConsumpOption.length;i++)
				{
					if(offPremiseC=="") {
						offPreConsumpOption[i].checked = false;
						offPreConsumpOption[i].disabled=true;
					} else {
						if(offPreConsumpOption[i].value==offPremiseC){
							offPreConsumpOption[i].checked = true;
							break;
						}
					}
			   }
			}			
			if(sellingType!=null && sellingType!="-1"){
				element.value = sellingType;
			} else {
				element.selectedIndex =0;
			}

			if(rowId!=null && !isload) {			
				for (var i = 0; i < dataSourceSelling.length; i++) {
					var rowSelling = dataSourceSelling[i];			
					if(rowSelling["rowId"] == rowId){
						rowSelling["sellingTypeId"]= element.value;		
						for(var i=0;i<containAlcoholOption.length;i++) {
							if(containAlcoholOption[i].checked==true){
								rowSelling["containAlcoholId"]= containAlcoholOption[i].value;		
								break;
							}
						}
						for(var i=0;i<offPreConsumpOption.length;i++) {
							if(offPreConsumpOption[i].checked==true){
								rowSelling["ofPreConsumptId"]= offPreConsumpOption[i].value;
								rowSelling["ofPreConsumptName"]= offPreConsumpOption[i].text;		
								break;
							} else {
								rowSelling["ofPreConsumptId"]= ' ';
								rowSelling["ofPreConsumptName"]= "";
							}
						}												 				
						break;
					} 		
				}	
			}				
		}else {
			element.options.length = 0;
			element.add(new Option("--Select--", "-1"));
			for (var i = 0; i < ratingData.length; i++) {
				//element.add(new Option(ratingData[i].ratingName+(elementSelling.value =="3" ? ' (parents strongly cautioned)': (elementSelling.value =="4"? ' (everyone 10 and older)':(elementSelling.value =="5"? ' (Parent Advisory label)':''))), ratingData[i].ratingId));
				element.add(new Option(ratingData[i].ratingName, ratingData[i].ratingId));
			}
			if(rowId!=null && isload ==false){
				for (var i = 0; i < dataSourceSelling.length; i++) {
					var rowSelling = dataSourceSelling[i];			
					if(rowSelling["rowId"] == rowId){
						rowSelling["sellingTypeId"]= element.value;																										 				
						break;
					} 		
				}
			}	
			if(sellingType!=null && sellingType!="-1"){
				element.value = sellingType;
			} else {
				element.selectedIndex =0;
			}
		}
		for(var i=0; i< element.options.length; i++){
			if(element.options[i].text.length>max){
				max =element.options[i].text.length;
			}
		}
		//console.log(max);
		//console.log(sellingRatingId.style.width);
		if(elementSelling.value =="1") {
			sellingRatingId.style.width= (max>=35) ? '570px' :'520px';
			restrictionDivId.style.marginLeft=(max>=35) ? '165px' :'85px';
		}
		if(elementSelling.value =="3" ) {
			sellingRatingId.style.width= (max>=25) ? '580px' :'400px';
			restrictionDivId.style.marginLeft=(max>=25) ? '185px' :'0px';
			restrictionDivId.style.width=(max>=25) ? '200px' :'200px';
		}
		if(elementSelling.value =="4") {
			sellingRatingId.style.width= (max>=25) ? '540px' :'450px';
			restrictionDivId.style.marginLeft=(max>=25) ? '125px' :'65px';
			restrictionDivId.style.width=(max>=25) ? '190px' :'200px';
		}
		if(elementSelling.value =="5") {
			sellingRatingId.style.width= (max>=23) ? '540px' :'410px';
			restrictionDivId.style.marginLeft=(max>=23) ? '125px' :'0px';
			restrictionDivId.style.width=(max>=23) ? '200px' :'185px';
		}
		//Music(5), Movie(3), Gaming(4)
		element.style.width= (alcohol=="N" ? max*10 : max*8) +"px";	
		//console.log('isProduct:'+isProduct);
		for (var i = 0; i < dataSourceSelling.length; i++) {
			var rowSelling = dataSourceSelling[i];			
			if(rowSelling["rowId"] == rowId){
				// isRenderView get from posAndAccounting.jsp, check render View of Selling Restriction Area
				var disabled = (newDataSw =='N' || !modifyMode || isRenderView) ? true : !modifyMode;					
				element.disabled = ((elementSelling.value =="1" && alcohol=="N") || disabled) ? true : false;
				for(var i=0;i<containAlcoholOption.length;i++) {
					containAlcoholOption[i].disabled = disabled;
				}
					
				for(var i=0;i<offPreConsumpOption.length;i++) {
					//Off Premise Consumption always disable if Alcohol is NO
					offPreConsumpOption[i].disabled = (alcohol=="N" || newDataSw =='N' || !modifyMode) ? true : disabled;				
				}												 				
				break;
			} 		
		}	
		restrictionId.innerHTML = getRestrictionName(sellingType);
		element.title= (element.selectedIndex>=0 ? element.options[element.selectedIndex].text : "");
	}
	elementSelling.style.display='none';
	showAdd();
}

function setDataForSellingList(dataRateType){
	var element = document.getElementById("sellingRestrictionOption");
	if(element){
		if(dataRateType != null && dataRateType.length > 0){
			element.options.length = 0;
			element.add(new Option("--Select--", "-1"));
			for(var x in dataRateType){
				if(dataRateType[x].rateTypeId.trim() != "9"){
					element.add(new Option(dataRateType[x].rateTypeName, dataRateType[x].rateTypeId));
				}
			}
		}
	}
}

function modifySellingRes()
{	
	var jsonSelling = document.getElementById("originSellingRestriction");
	if(jsonSelling){
		if(jsonSelling.value != null  &&  jsonSelling.value != ""){
			var jsonData = YAHOO.lang.JSON.parse(jsonSelling.value);
			//console.log('modifySellingRes==='+jsonSelling.value);
			dataSourceSellingOrg = jsonData;
			dataSourceSelling = jsonData;
			if(dataSourceSelling!=null && dataSourceSelling.length>0){
				rowidMax = dataSourceSelling.length;
			}			
		}
		rewriteUiSelling(dataSourceSellingOrg,true);
	}
}

function rewriteUiSelling(dataSourceSelling,isload){	
	tableSellingId.innerHTML = "";
	if(dataSourceSelling != null && dataSourceSelling.length > 0) {
		var flagFirst = true;
		for (var f = 0; f < dataSourceSelling.length; f++) {
			if(dataSourceSelling[f]["sellingResName"]!=undefined) {
				tableSellingId.innerHTML += addRowSellingHtml(dataSourceSelling[f],flagFirst,dataSourceSelling[f]["sellingResName"]);
				flagFirst= false;
				changeSellingResOption(document.getElementById("sellingRestrictionOption"+dataSourceSelling[f]["rowId"]),dataSourceSelling[f]["rowId"],dataSourceSelling[f]["sellingTypeId"],dataSourceSelling[f]["containAlcoholId"],dataSourceSelling[f]["ofPreConsumptId"],true,dataSourceSelling[f]["isProduct"]);
				if(dataSourceSelling[f]["sellingResId"]=="1"){
					changecontainAlcoholOption(dataSourceSelling[f]["containAlcoholId"],dataSourceSelling[f]["rowId"],isload);
				}
			}
		}		
	} 
	document.getElementById("btnNewSelling").disabled = !modifyMode;
}

function showSellingRestriction(flag){
	if(flag){
		var msgSellingResReturn = validateBeforeSave();
		if(msgSellingResReturn!=""){
			alert(msgSellingResReturn);
			return false;
		}
		document.getElementById("sellingRestrictionOption").value = -1;
		document.getElementById("sellingRestrictionOption").style.display="block";
	} else{	
		document.getElementById("sellingRestrictionOption").style.display="none";
	
	}
}

function showAdd(){	
	var showFlag = true;
	if(dataSourceSelling != null && dataSourceSelling.length > 0) {		
		for (var f = 0; f < dataSourceSelling.length ; f++) {
			if(dataSourceSelling[f]["sellingResId"]=="1"){
				// is alcohol then don't check type
				//continue;	
			}
			if(dataSourceSelling[f]["sellingResId"] == "-1" || dataSourceSelling[f]["sellingTypeId"] == "-1"){
				showFlag = false;
			}
		}			
	}	
	document.getElementById("sellingRestrictionOption").style.display="none";
	if(modifyMode && newDataSw=='Y'){
		document.getElementById("btnNewSelling").disabled=false;
	} else{
		document.getElementById("btnNewSelling").disabled=true;		
	}
}

//Adding trim function to String object
if(typeof String.prototype.trim !== 'function') {
  String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g, '');
  }
}