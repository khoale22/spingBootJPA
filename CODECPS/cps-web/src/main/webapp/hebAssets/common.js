/**
 * Common js functions.
*/

var numOfCall=0;
 
function LTrim( value ) {
	
	var re = /\s*((\S+\s*)*)/;
	return value.replace(re, "$1");
	
}

// Removes ending whitespaces
function RTrim( value ) {
	
	var re = /((\s*\S+)*)\s*/;
	return value.replace(re, "$1");
	
}

// Removes leading and ending whitespaces
function trim( value ) {
	
	return LTrim(RTrim(value));
	
}

//functions for displaying and hiding advanced search
var link1Clicked = false;

function showAttributes(){
	var searchAttrDiv = YAHOO.util.Dom.get("searchAttr");
	var link1Attr = YAHOO.util.Dom.get("link1");
	var link2Attr = YAHOO.util.Dom.get("link2");
	var defaultUPCLabel = YAHOO.util.Dom.get("defaultUPCLabel");	
	var defaultActionLabel = YAHOO.util.Dom.get("defaultActionLabel");
	var defaultUPCLabelTop = YAHOO.util.Dom.get("defaultUPCLabelTop");
	var upcDefault = YAHOO.util.Dom.get("upcDefault");
	var actionSelectDefault = YAHOO.util.Dom.get("actionSelectDefault");
	var upcDefaultTop = YAHOO.util.Dom.get("upcDefaultTop");
	var defaultUpcValue = YAHOO.util.Dom.get("defaultUpcValue");
	var productDesLabel= YAHOO.util.Dom.get("productDesLabel");
	var productDesTxt= YAHOO.util.Dom.get("productDesTxt");
	var upc = YAHOO.util.Dom.get("upc");
	var itemCodeLbl = YAHOO.util.Dom.get("itemCodeLbl");
	var itemCodeTxt = YAHOO.util.Dom.get("itemCodeTxt");
	var caseUpcLbl = YAHOO.util.Dom.get("caseUpcLbl");
	var caseUpcTxt = YAHOO.util.Dom.get("caseUpcTxt");
	var actionSelect = document.getElementById("actionSelect");
	var defaultActionSelect = document.getElementById("defaultActionSelect");
	if(link1Clicked==false){
		searchAttrDiv.style.display = 'block';
		link2Attr.style.display = 'block';
		link1Attr.style.display = 'none';
		link1Clicked=true;
		document.getElementById('isAdvanced').value = 'true';
		if(defaultUpcValue) {
			upc.value=defaultUpcValue.value;
		}
		if(defaultActionSelect){
			actionSelect.value=defaultActionSelect.value;
		}		
		if(productDesLabel) {
			productDesLabel.style.display='block';
		}
		if(productDesTxt) {
			productDesTxt.style.display='';
		}
		//hide upc label & textbox
		if(defaultUPCLabel) {
			defaultUPCLabel.style.display='none';
		}
		if(defaultActionLabel) {
			defaultActionLabel.style.display='none';
		}
		if(upcDefault) {
			upcDefault.style.display='none';
		}
		if(actionSelectDefault) {
			actionSelectDefault.style.display='none';
		}		
		if(upcDefaultTop) {
			upcDefaultTop.style.display='';
		}
		if(itemCodeLbl) itemCodeLbl.style.display = '';
		if(itemCodeTxt) itemCodeTxt.style.display = '';	
		if(caseUpcLbl) caseUpcLbl.style.display = '';
		if(caseUpcTxt) caseUpcTxt.style.display = '';	
	}else{
		searchAttrDiv.style.display = 'none';
		link2Attr.style.display = 'none';
		link1Attr.style.display = 'block';
		if(itemCodeLbl)  itemCodeLbl.style.display = 'none';
		if(itemCodeTxt)  itemCodeTxt.style.display = 'none';
		if(caseUpcLbl) caseUpcLbl.style.display = 'none';
		if(caseUpcTxt) caseUpcTxt.style.display = 'none';	
		link1Clicked=false;
		document.getElementById('isAdvanced').value = 'false';
		if(defaultUPCLabel) {
			defaultUPCLabel.style.display='block';
		}
		if(defaultActionLabel) {
			defaultActionLabel.style.display='block';
		}
		if(upcDefault) {
			upcDefault.style.display='block';
		}
		if(actionSelectDefault) {
			actionSelectDefault.style.display='block';
		}		
		if(productDesLabel) {
			productDesLabel.style.display='none';
		}
		if(productDesTxt) {
			productDesTxt.style.display='none';
		}
		if(defaultUpcValue!=null) {
			if(upc!=null) {
				if(upc.value==''){ defaultUpcValue.value='';
				} else {
					// update value in upc of basic search when user clicking on
					// 'Hide Advanced Search'
					defaultUpcValue.value=upc.value;
				}
			} 
		}
		if(defaultActionSelect!=null) {
			if(actionSelect!=null) {
				if(actionSelect.value==''){ defaultActionSelect.value='';
				} else {
					// update value in upc of basic search when user clicking on
					// 'Hide Advanced Search'
					defaultActionSelect.value=actionSelect.value;
				}
			} 
		}		
	}	
}

function showProductAttributes(){
	var searchAttrDiv = YAHOO.util.Dom.get("searchAttr");
	var link1Attr = YAHOO.util.Dom.get("link1");
	var link2Attr = YAHOO.util.Dom.get("link2");
	if(link1Clicked==false){
		searchAttrDiv.style.display = 'block';
		link2Attr.style.display = 'block';
		link1Attr.style.display = 'none';
		link1Clicked=true;
		document.getElementById('isAdvanced').value = 'true';
	}else{
		searchAttrDiv.style.display = 'none';
		link2Attr.style.display = 'none';
		link1Attr.style.display = 'block';
		link1Clicked=false;
		document.getElementById('isAdvanced').value = 'false';
	}	
}
function colorTableRows(tableName){
		var rowslength = "";
		var tableSelected = "";
		tableSelected = document.getElementById(tableName);
		rowslength = tableSelected.rows.length;
		var cells;
		var tableCell;
		for(var i=0;i < rowslength;i++){
			var tableRow = tableSelected.rows[i];
			cells = tableRow.cells;
			for(var j=0;j< cells.length;j++){
				if(i % 2 == 0){
					cells[j].style.backgroundColor = "#F7F7F7";
				}else{
					cells[j].style.backgroundColor = "#FFFFFF";	
				}
			}
		}
	}

function colorTable(vendorTableclicked,mrtTableClicked,upcTableClicked){
		var rowslength = "";
		var tableSelected = "";
		if(upcTableClicked){
			tableSelected = document.getElementById('upcTable');
			rowslength = tableSelected.rows.length;
		}else if(vendorTableclicked){
			tableSelected = document.getElementById('vendorTable');
			rowslength = tableSelected.rows.length;
		}else if(mrtTableClicked){
			tableSelected = document.getElementById('mrtTable');
			rowslength = tableSelected.rows.length;
		}
		var cells;
		var tableCell;
		for(var i=0;i < rowslength;i++){
			var tableRow = tableSelected.rows[i];
			cells = tableRow.cells;
			for(var j=0;j< cells.length;j++){
				if(i % 2 == 0){
					cells[j].style.backgroundColor = "#F7F7F7";
				}else{
					cells[j].style.backgroundColor = "#FFFFFF";	
				}
			}
		}
	}
	
	
function loadScriptsFromDiv(divId){
	var divObject = document.getElementById(divId);
	if(divObject){
		var obj = divObject.getElementsByTagName("SCRIPT");
		var len = obj.length;
		for(var i=0; i<len; i++)
		{
		eval(obj[i].text);   // execute the scripts.
		}
	}
}
var funToBeExecAfterPageLoad = function(){};

function execAfterPageLoad(toBeExecFun){
	var tmp = funToBeExecAfterPageLoad;
	funToBeExecAfterPageLoad = function(){ try{tmp();}catch(e){}toBeExecFun(); };
}

function switchToUpperCase(obj){
	var a = obj.value;
	obj.value = a.toUpperCase(); 
}
function valdKeyPressSymbSpec(obj)
	{
		var allowString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789@$%&-_\\/.|?";
		if(obj != null)
		{
			var comp = YAHOO.lang;
			var temp = comp.trim(obj.value);
			
			for (i=0; i < temp.length; i++) {
				var x = temp.charAt(i);
				if (allowString.indexOf(x) < 0)
				{
					alert("Description only allow special character in @ $ % & - _ \\ / . ?");
					obj.value ="";
					obj.select();
					obj.focus();
					return;
				}						
			}
		}
	}	

/***********************dwr util methods start******************************/

function validateDateUsingDWR(obj,fieldName){

      if (obj.value == "" || obj.value == null){
      return true;
      }
      if(obj != null){
            var val = obj.value;
           if (isValidDate(val,fieldName)){
           
            return true;
            }
            else{
      
             obj.value = "";
             obj.focus();
            return false;

            }
      }
      else{
      return true;
      }
}

function showDWRError(msg){
	showMessage(msg);
}

function showMessage(msg){
	alert(msg);
}	

function handleMessages(msgs){
	var msg;
	var userMessage = "";
	var i=0;
	var msgExists = false;
	var sessionTimeout=false;
	for(i=0;i<msgs.length;i++){
		msgExists = true;
		msg = msgs[i];
		if(i > 0){
			userMessage = userMessage + "\n";
		}
		if(msg.type=='SESSIONTIMEOUT') {
			sessionTimeout = true;
			userMessage = userMessage +msg.message;
			break;		
		}
		userMessage = userMessage + msg.type + ": "+msg.message;
	}
	if(msgExists){
		if(userMessage.indexOf("The specified call count is not a number")!=-1){
			alert('No records returned.');
		} else {
			//Only show a session time-out pop-up if there are multiple requests to server.
			if(numOfCall>0) {
				alert(userMessage);
				window.parent.hideProgress();
				if(sessionTimeout) {
					numOfCall = 0;
					document.forms[0].action = contextPath+'/login.do?mode=error';
					document.forms[0].submit();
				}
			}
		}
	}
}
/*******************************************************************************
 * * All dwr callbacks should be passed to this method before setting as a
 * callback. This is a post execution hook. DWR's own post execution hook
 * doesn't have a mechanism to alter response data. So writing CPS's own hook.
 ******************************************************************************/
function getDWRCallbackMethod(callBackCoreMethod){
	if(callBackCoreMethod == null || callBackCoreMethod == "" || typeof callBackCoreMethod != "function"){
		callBackCoreMethod = function(d){};
	}
	numOfCall++;
	var callBackMsgHook = handleMessages;
	var callBackMethod = function(data){

		var msgData = data.messages;
		var msgs = msgData.messageList;
		//will be calling the application callback only
		//if there is no exception..
		if(! msgData.exception){
			try{
				callBackCoreMethod(data.appData);
			}catch(e){			
			}
		}else{
					
			try{hideProgress();
			}catch(e){}
			//try{
			//document.getElementById('stackClick').innerText = "See Stack";
			// document.getElementById('stackTrace').innerHTML =
			// msgData.stackTrace;
			//}catch(e){}
			
		}
		callBackMsgHook(msgs);
	};
	/*
	 * try{ document.getElementById('stackClick').innerText = "";
	 * document.getElementById('stackTrace').innerHTML = "";
	 * document.getElementById('stackTrace').style.display = 'none'; }catch(e){}
	 */
	return callBackMethod;
}

// errorHndle(){
	//if(document.getElementById('stackTrace').style.display == 'none'){
		//document.getElementById('stackTrace').style.display = 'block';
	//}else{
	//document.getElementById('stackTrace').style.display = 'none';
	//}
//}

//#1205 add new function
function parseNumber(str){
	for(var i=0;i < str.length; ++i)
    {
		var new_key = str.charAt(i); 
        if(((new_key < "0") || (new_key > "9")) && !(new_key == ""))
		{
			return 'NaN';
        }
     }
	return parseInt(str);
}

function valueMultipleOfOther(numb, factor){
	var a1 = numb;
	var a2 = factor;
	var res = a1/a2;
	var res1 = res + "";
	var cont = res1.indexOf('.') == -1;
	return cont;
}

function clearErrors(){
	if(document.getElementById('errors')){
		document.getElementById('errors').innerHTML = "";
	}
}

var afterBodyVisible = function(){};

function executeAfterBodyVisible(funToExec){
	var tmp = afterBodyVisible;
	afterBodyVisible = function(){
		try{
		tmp();
		}catch(e){}
		funToExec();
	} 
}

var initialString = " ";
var finalString = " ";

 var isFinalInputCheck = new Boolean(true);
 
  
 function checkFinalInputDisable(){
 
  isFinalInputCheck = false;
 
 }
 
 

function checkInitialInput(){
    
    var fulltext= "";
   
   for(i=0; true; i++){
	  if(document.forms[0] && document.forms[0].elements[i]){
 
	   if( document.forms[0].elements[i].type == "text" ){
	 
	   fulltext = fulltext + document.forms[0].elements[i].value;
	   }
	 
	   else if( document.forms[0].elements[i].type == "checkbox" ){
	 
	   if( document.forms[0].elements[i].checked){
	 
	    fulltext = fulltext + document.forms[0].elements[i].value;
	     }
	  
	    }
	 
	   else if( document.forms[0].elements[i].type == "radio" ){
	 
	   if( document.forms[0].elements[i].checked){
	 
	    fulltext = fulltext + document.forms[0].elements[i].value;
	    }
	  
	     }
	    else if( document.forms[0].elements[i].type == "textarea" ){
	     
	     fulltext = fulltext + document.forms[0].elements[i].value;
	    
	    }  
	 
	    else if(document.forms[0].elements[i].type == "select-one" ){
	
	    fulltext = fulltext + document.forms[0].elements[i].selectedIndex;
	
	   }
	   
	  }else{
	       break;
	    }
 
    }
      initialString = fulltext;
      fulltext = "";
  
    }
 

 
 function checkFinalInput(){
   var fulltext= "";
 
   if(isFinalInputCheck){
   for(i=0; true; i++){
   if(document.forms[0] && document.forms[0].elements[i]){
 
   if( document.forms[0].elements[i].type == "text" ){
 
   fulltext = fulltext + document.forms[0].elements[i].value;
   }
 
   else if( document.forms[0].elements[i].type == "checkbox" ){
 
   if( document.forms[0].elements[i].checked){
 
    fulltext = fulltext + document.forms[0].elements[i].value;
     }
  
    }
 
   else if( document.forms[0].elements[i].type == "radio" ){
 
   if( document.forms[0].elements[i].checked){
 
    fulltext = fulltext + document.forms[0].elements[i].value;
    }
  
     }
    else if( document.forms[0].elements[i].type == "textarea" ){
     
     fulltext = fulltext + document.forms[0].elements[i].value;
    
    }  
 
    else if(document.forms[0].elements[i].type == "select-one" ){

    fulltext = fulltext + document.forms[0].elements[i].selectedIndex;

   }   

 
   }else{
 
     break;
   }

 

    }
 
  
    finalString =  fulltext;
    fulltext = "";
    if(finalString == initialString){
    
    return true;
  
  }else{
  /*
	 *  // this is commended because for the user this message is making
	 * confusion thats why .
	 * 
	 * var ok = confirm('All unsaved data will be lost!. Do you want to
	 * continue?'); if(ok){ return true; } else{
	 * 
	 * return false; }
 */
  return true; // since the above mesaage is  not needed should return true
  
  }
  }else{
   
   return true;
  
  }
   finalString = "" ;
   initialString = "";


 }
 /***********************for date validation ********************************/
 
var dtCh= "/";
var dtCh2="-"; 

 function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))){ 
        return false;
        }
    }
    // All characters are numbers.
    return true;
}
 
 function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}
 function daysInFebruary (year){

	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {

	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this;
}
function isValidDate(dtStr,fieldName){
	var daysInMonth = DaysArray(12)
	var pos2
	var pos1=dtStr.indexOf(dtCh)
	var flag=false
	if(pos1>0)
	{
		pos2=dtStr.indexOf(dtCh,pos1+1);		
	}	
	else
	{
		pos1=dtStr.indexOf(dtCh2);
		pos2=dtStr.indexOf(dtCh2,pos1+1);		
		flag=true;
		
	}
	var strMonth=dtStr.substring(0,pos1)
	var strDay=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		alert("The date format should be : mm/dd/yyyy or mm-dd-yyyy");
		return false;
	}
	if (strMonth.length<1 || month<1 || month>12){
		alert("Please enter a valid month, "+fieldName+" can have values only in the format mm/dd/yyyy or mm-dd-yyyy");
		return false;
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		alert("Please enter a valid day, "+fieldName+" can have values only in the format mm/dd/yyyy or mm-dd-yyyy");
		return false;
	}
	if (strYear.length<1 || year<1900 || year>9999){
		alert("Please enter a valid year[1900-9999], "+fieldName+" can have values only in the format mm/dd/yyyy or mm-dd-yyyy");
		return false;
	}
	if (strYear.length != 4 ){
		alert("The date format should be : mm/dd/yyyy or mm-dd-yyyy");
		return false
	}
	if(!flag)
	{
		if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
			alert("Please enter a valid date, "+fieldName+" can have values only in the format mm/dd/yyyy or mm-dd-yyyy");
			return false;
		}
	}
	else
	{
		
		
			if (dtStr.indexOf(dtCh2,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh2))==false)
			{
				alert("Please enter a valid date, "+fieldName+" can have values only in the format mm/dd/yyyy or mm-dd-yyyy");
				return false;
			}
		
	}
	
	// #1110 - Validate input dates for Import Attributes
	if (fieldName == "Proration Date" || fieldName == "Instore Date" || fieldName == "Whse Flush Date") {		
		var today = new Date();
		today = new Date(today.toDateString());
		var str = dtStr.replace(/-/g, "/");
		var date = new Date(str);
		
		if (date < today) {
			alert("Please enter a valid date, " + fieldName + " does not allow a past date");
			return false;
		} else {
			today.setFullYear(today.getFullYear() + 10);
			
			if (date > today) {
				alert("Please enter a valid date, " + fieldName + " does not allow a date greater than 10 years from today");
				return false;
			}
		}
	}
	// End #1110

	return true;
}


function setValue(obj, val){
	if(obj){
		obj.value = val;
	}
}
 

/***********************dwr util methods end********************************/

/**
 * *********************Limitting the maximun value Entered in a field
 * Starts**************
 */

function roundValue(text,precision){
           var number = text.value;
		    if(number == "0" || isNaN(number)){
 	           	text.value = '0.00';
				return; 
		   }
           var numberValue = parseFloat(number);
           var maxLength = text.getAttribute("maxlength");
           var decimal = precision;
           var decimalValue = (decimal+1);
           var intiger = (maxLength-decimalValue);
           var Chars = ".";
           var np = "";
             var dp = "";
            for(var j = 0; j < intiger; j++){
                  np=np+"9";
            } 
            for(var k = 0; k < decimal; k++){
                  dp=dp+"9";
            }
           var maxLimit =(np+"."+dp);
           var maxLimitValue = parseFloat(maxLimit);
           for (var i = 0; i< number.length;i++){
           if(numberValue <= maxLimitValue){
		   if(precision == 4){
           calculatePrice3(text);
		   }else if(precision == 3)
		   {
           calculatePrice2(text);
		   }else {
		   calculatePrice1(text);
		   }
           }else {
           alert('The entered value is above the maximum limit['+maxLimitValue+'],Please re-enter');
           text.select();
           text.focus();
           break;
           }
           }
      }
      
      
      
       function calculatePrice1(text){
 	               var retailprice = text.value;
		           for (var j = 0; j < retailprice.length; j++){ 
					      var ret = parseFloat(retailprice);
				             var minus1 = '';
				             if(ret < 0) { minus1 = '';}
				             ret = Math.abs(ret);
				             ret = parseInt((ret + .005) * 100);
				             ret = ret / 100;
				             t = new String(ret);
				             if(t.indexOf('.') < 0){ 
					           t += '.00'; 
				                }
				               if(t.indexOf('.') == (t.length - 2)){ 
					            t += '0'; 
				                 }
				                 t = minus1 + t;
				                 text.value = t;
			     }
		  }

		   function calculatePrice2(text){
 	               var retailprice = text.value;
		           for (var j = 0; j < retailprice.length; j++){ 
					      var ret = parseFloat(retailprice);
				             var minus1 = '';
				             if(ret < 0) { minus1 = '';}
				             ret = Math.abs(ret);
				             ret = parseInt((ret + .0005) * 1000);
				             ret = ret / 1000;
				             t = new String(ret);
				             if(t.indexOf('.') < 0){ 
					           t += '.000'; 
				                }
				               if(t.indexOf('.') == (t.length - 2)){ 
					            t += '0'; 
				                 }
				                 t = minus1 + t;
				                 text.value = t;
			     }
		  }

		   function calculatePrice3(text){
 	               var retailprice = text.value;
		           for (var j = 0; j < retailprice.length; j++){ 
					      var ret = parseFloat(retailprice);
				             var minus1 = '';
				             if(ret < 0) { minus1 = '';}
				             ret = Math.abs(ret);
				             ret = parseInt((ret + .00005) * 10000);
				             ret = ret / 10000;
				             t = new String(ret);
				             if(t.indexOf('.') < 0){ 
					           t += '.0000'; 
				                }
				               if(t.indexOf('.') == (t.length - 2)){ 
					            t += '0'; 
				                 }
				                 t = minus1 + t;
				                 text.value = t;
			     }
		  }

		   
		   function roundValueListCost(text,precision){
	           var number = text.value;
			    if(number == "0" || isNaN(number)){
	 	           	text.value = '0.00';
					return; 
			   }
	           var numberValue = parseFloat(number);
	           var maxLength = text.getAttribute("maxlength");
	           var decimal = precision;
	           var decimalValue = (decimal+1);
	           var intiger = (maxLength-decimalValue);
	           var Chars = ".";
	           var np = "";
	             var dp = "";
	            for(var j = 0; j < intiger; j++){
	                  np=np+"9";
	            } 
	            for(var k = 0; k < decimal; k++){
	                  dp=dp+"9";
	            }
	           var maxLimit =(np+"."+dp);
	           var maxLimitValue = parseFloat(maxLimit);
	           for (var i = 0; i< number.length;i++){
	           if(numberValue <= maxLimitValue){
			   if(precision == 4){
	           calculatePrice3(text);
	           formatListCost(text);
			   }else if(precision == 3)
			   {
	           calculatePrice2(text);
			   }else {
			   calculatePrice1(text);
			   }
	           }else {
	           alert('The entered value is above the maximum limit['+maxLimitValue+'],Please re-enter');
	           text.select();
	           text.focus();
	           break;
	           }
	           }
	      }		   
   function formatListCost(text){
	   var data = new String(text.value);
	   var length = data.length;
	   var index = data.indexOf('.');
	   if(index < 0){
		   data += '.0000'; 
	   }else{
		   var missingZero = 4 - (length - index - 1);
		   for (var j = 0; j < missingZero; j++){ 
			   data += '0';
		   }
	   }
	   text.value = data;       
  }
/************************used for list cost***************************/
 //allow enter maximum 4 decimal digits in List cost field
   function onKeyDownListCost(e, obj){
   	try{
   	var isShift=false;
   	keyCode = e.keyCode
   	if(keyCode==16)
   			isShift = true;
   	if((keyCode >= 48 && keyCode <= 57 ||
   			(keyCode >= 96 && keyCode <= 105)) && isShift == false){
   		num = obj.value;
   		var pos = num.indexOf(".");
   		if (pos==-1) return true;
   		var cur = getSelectionStart(obj);
   		if(cur <= pos) return true;
   		else{
   			var dec=num.substring(pos,num.length);
   			if(dec.length > 4){
   				if (window.event){
   					e.keyCode = 0;
   					e.returnValue = false;
   					return false;
   				}
   				else{
   					return false;
   				}
   				
   			}
   		}
   	}
   	}
   	catch(err){
   		alert(err.description);
   	}
   	
   }
   function validateListCost(data){
   	var producSellable = true;
   	if(document.getElementById('productType')){
   		if(document.getElementById('productType').value == 'SPLY'){
   			producSellable = false;
   		}
   	}
   	if(null != data && "" != data){
   		var listCost = data.value;
   		if(isNaN(listCost)){
   			alert("List Cost Must be Number");
   			data.value = "";
   			return;
   		}
   		if(null != listCost && "" != listCost){
   			if(listCost > 99999.9999){
   				alert("List Cost should not exceed $99999.9999");
   				data.value = "";
   				return;
   			}
   			// HoangVT - [Change Request - A&D tab - QC:1398] Vendor should be
			// able to enter list cost 2 cent at least
   			// [Defect 1467] for non-sellable product: list cost cannot be <
			// 0.01
   			if(producSellable == false && listCost < 0.01){
   				alert("List Cost should be greater than or equal to 0.01");
   				data.value = "";
   				return;
   			}
   			if(producSellable == true && listCost < 0.02){
   				alert("List Cost should be greater than or equal to 0.02");
   				data.value = "";
   				return;
   			}
   			var index = listCost.indexOf('.');
   			if(index > 0){
   				var dec=listCost.substring(index,listCost.length);
   				if(dec.length > 5){
   					alert("Allow to enter maximum 4 decimal digits in List Cost");
   					data.value = "";
   					return;
   				}
   			}
   			formatListCost(data);   			
   		}
   	}
   }

   function onKeyDownRestrictDecimal(e, obj, type){
   	var isShift=false;
   	keyCode = e.keyCode
   	if(keyCode==16)
   			isShift = true;

   	if((keyCode >= 48 && keyCode <= 57 ||
   			(keyCode >= 96 && keyCode <= 105)) && isShift == false){
   		var lengthDecimal = 2;
   		if(type == 'length' || type == 'width' || type == 'height') lengthDecimal = 1;
   		else 
   			if(type == 'weigth') lengthDecimal = 2;
   		num = obj.value;
   		var pos = num.indexOf(".");
   		if (pos==-1) return true;
   		var cur = getSelectionStart(obj);
   		if(cur <= pos) return true;
   		else{
   			var dec=num.substring(pos,num.length);
   			if(dec.length > lengthDecimal){
   				if (window.event){
   					e.keyCode = 0;
   					e.returnValue = false;
   					return false;
   				}
   				else{
   					return false;
   				}
   				
   			}
   		}
   	}
   }

   function getSelectionStart(o) {
   	if (o.createTextRange) {
   		var r = document.selection.createRange().duplicate()
   		r.moveEnd('character', o.value.length)
   		if (r.text == '') return o.value.length
   		return o.value.lastIndexOf(r.text)
   	} else return o.selectionStart
   }

/**
 * *********************Limitting the maximun value Entered in a field Ends
 * **************
 */
		   
		// Declaring valid date character, minimum year and maximum year
		   var dtCh= "/";
		   var minYear=1900;
		   var maxYear=2100;

		   function isInteger(s){
		   	var i;
		       for (i = 0; i < s.length; i++){   
		           // Check that current character is number.
		           var c = s.charAt(i);
		           if (((c < "0") || (c > "9"))) return false;
		       }
		       // All characters are numbers.
		       return true;
		   }

		   function stripCharsInBag(s, bag){
		   	var i;
		       var returnString = "";
		       // Search through string's characters one by one.
		       // If character is not in bag, append to returnString.
		       for (i = 0; i < s.length; i++){   
		           var c = s.charAt(i);
		           if (bag.indexOf(c) == -1) returnString += c;
		       }
		       return returnString;
		   }

		   function daysInFebruary (year){
		   	// February has 29 days in any year evenly divisible by four,
		       // EXCEPT for centurial years which are not also divisible by
				// 400.
		       return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
		   }
		   function DaysArray(n) {
		   	for (var i = 1; i <= n; i++) {
		   		this[i] = 31
		   		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		   		if (i==2) {this[i] = 29}
		      } 
		      return this
		   }

		   function isDate(dtStr){
		   	var daysInMonth = DaysArray(12)
		   	var pos1=dtStr.indexOf(dtCh)
		   	var pos2=dtStr.indexOf(dtCh,pos1+1)
		   	var strMonth=dtStr.substring(0,pos1)
		   	var strDay=dtStr.substring(pos1+1,pos2)
		   	var strYear=dtStr.substring(pos2+1)
		   	strYr=strYear
		   	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
		   	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
		   	for (var i = 1; i <= 3; i++) {
		   		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
		   	}
		   	month=parseInt(strMonth)
		   	day=parseInt(strDay)
		   	year=parseInt(strYr)
		   	if (pos1==-1 || pos2==-1){
		   		alert("The date format should be : mm/dd/yyyy")
		   		return false
		   	}
		   	if (strMonth.length<1 || month<1 || month>12){
		   		alert("Please enter a valid month")
		   		return false
		   	}
		   	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		   		alert("Please enter a valid day")
		   		return false
		   	}
		   	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		   		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		   		return false
		   	}
		   	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		   		alert("Please enter a valid date")
		   		return false
		   	}
		   return true
		   }

		   function validateDate(date){
			if(date.value == null || date.value == ""){
				return true
			}else{	
				if (isDate(date.value)==false){
					date.value=""
					date.focus()
					return false
				}
				return true
			}
		  }
		   function validateNumber(data, value){
			   if(null != data && "" != data){
			   		var valueTemp = data.value;
			   		if(isNaN(valueTemp)){
			   			alert(value +" Must be Number");
			   			data.value = "";
			   			return;
			   		}
			   }
		   }