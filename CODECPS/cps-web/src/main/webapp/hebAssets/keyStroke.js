/* This file is for field level data validation.
 * The functions keyDownFunction and keyUpFunction are called
 * in jeader.jsp
 */

var alphaDataType = 'alpha';
var alphaNumDataType = 'alphanumeric';
var numDataType = 'numeric';
var floatDataType = 'float';
var alphaNumericDataType = 'alphanumericOnly';
var alphaNumericSpecialDataType = 'alphanumericSpecial';
var alphaNumSpecialOnlyDataType = 'alphanumericSpecialOnly';
var alphaNumericCustomerDataType = 'alphanumericCustomer';
var styleVarName = 'dataType';


var pressedKeyFirst = null;
var pressedKeySecond = null;
var pressedKeyThird = null;
var pressedKeyFourth = null;
var pressedKeyFifth = null;
var currentKey = null;
var currntVal = null;

function keyDownFunction(ev){
var evt = (window.external) ? event : ev;
var target = null;
if(evt.srcElement){
	target =evt.srcElement; 
}else if(evt.target){
	target =evt.target;
}
var datType;
var keyCde;
if(target && target.style && target.style.dataType){
 datType = target.style.dataType;
 if(target.value){
   currntVal = target.value;
 }else{
    currntVal = null;
 }
}
if(evt && evt.keyCode){
 keyCde = evt.keyCode;
}

if(keyCde && datType){

if(keyCde == currentKey){
 var retval = validate(datType,keyCde);
 if(retval){
  return true;
 }else{
  return false;
 }
}else if(keyCde == pressedKeySecond || keyCde == pressedKeyFirst || keyCde == pressedKeyThird 
                   || keyCde == pressedKeyFourth || keyCde == pressedKeyFifth  ){
 return false;
}
else{
pressedKeyFifth = pressedKeyFourth;
pressedKeyFourth = pressedKeyThird;
pressedKeyThird = pressedKeySecond;
pressedKeySecond = pressedKeyFirst;
pressedKeyFirst = currentKey;
currentKey = keyCde;
return validate(datType,keyCde);
}
}
}


function validate(datType, keyCde){
	//oterh impl for current key
	if(datType && keyCde){
		if(isCntrlPressed()){
		 return false;
		}
		if(escapeSpecialChars(keyCde)){
		 return true;
		}
		if(alphaDataType == datType){
		 return handleAlpha(keyCde);
		}else if(alphaNumDataType == datType){
		 return handleAlphaNumeric(keyCde);
		}else if(numDataType == datType){
		 return handleNumeric(keyCde);
		}else if(floatDataType == datType){
		 return handleFloat(keyCde);
		}
        else if(alphaNumericDataType == datType){
         return handleAlphaNumericOnly(keyCde);
        }else if(alphaNumericSpecialDataType == datType){
            return handleAlphaNumericSpecial(keyCde);
        }else if(alphaNumSpecialOnlyDataType == datType){
            return handleAlphaNumericSpecialOnly(keyCde);
        }else if(alphaNumericCustomerDataType == datType){
            return handleAlphaNumericCustomer(keyCde);
        }

	}else{
	 return true;
	}
}
function isCntrlPressed(){
 if(pressedKeyFirst == 17 || pressedKeySecond == 17 || pressedKeyThird == 17|| pressedKeyFourth == 17|| pressedKeyFifth == 17 ){
  return true;
 }
 return false;
}
function isShiftPressed(){
 if(pressedKeyFirst == 16 || pressedKeySecond == 16 || pressedKeyThird == 16|| pressedKeyFourth == 16|| pressedKeyFifth == 16 ){
  return true;
 }
 return false;
}
function isDote(){
 if( (currentKey == 190 ||currentKey == 110) &&  !isShiftPressed()){
  return true;
 }
  return false;
}

function isAmperSand(){
 if(isShiftPressed() && currentKey == 55){
  return true;
 }
 return false;
}
function isDollar(){
 if(isShiftPressed() && currentKey == 52){
  return true;
 }
 return false;
}
function isPercentage(){
 if(isShiftPressed() && currentKey == 53){
  return true;
 }
 return false;
}
function isBrackets(){
 if(isShiftPressed() && currentKey == 57){
  return true;
 }else if(isShiftPressed() && currentKey == 48){
  return true;
 }
 return false;
}

function isAtTheRate(){
 if(isShiftPressed() && currentKey == 50){
  return true;
 }
 return false;
}
function isUnderScore(){
 if(isShiftPressed() && currentKey == 189){
  return true;
 }
 return false;
}
function isSpace(){
 if(currentKey == 32){
  return true;
 }
 return false;
}
function isHyphen(){
 if(currentKey == 189){
  return true;
 }
 return false;
}
function isArrows(){
 if(currentKey >= 37 && currentKey <= 40){
  return true;
 }
 return false;
}

function handleAlpha(keyCde){
 if(keyCde >= 65 && keyCde <= 90){
  return true;
 }else if( isAmperSand() || 
           isDollar()    ||
           isPercentage()||
	   isAtTheRate() ||
	   isUnderScore()||
	   isHyphen()    ||
	   isSpace()     ||
	   isArrows()    ||
	   isSlash()){
  return true;
 }else{
  return false;
 }
}
function handleAlphaNumeric(keyCde){
 if(handleAlpha(keyCde) || handleNumeric(keyCde)|| isDote()){
  return true;
 }else{
  return false;
 }
}
function handleFloat(keyCde){
 if(handleNumeric(keyCde) || ((currntVal!=null) && isDote() && !isDoteAlreadyInValue())){
  return true;
 }
 return false;
}
function isDoteAlreadyInValue(){
  var tmp = currntVal;
  if(tmp!=null){
	  var lngth = tmp.length;
	  for(var i=0;i<lngth;i++){
		  var t = tmp.charAt(i);
		  if(t == '.') return true;
	  }
  }
  return false;
}
function handleNumeric(keyCde){
 if(!isShiftPressed() && keyCde >= 48 && keyCde <= 57){
  return true;
 }else if(!isShiftPressed() && keyCde >= 96 && keyCde <= 105){
  return true;
 }else{
  return false;
 }

}

function keyUpFunction(ev){
var evt = (window.external) ? event : ev;
var target = null;
if(evt.srcElement){
	target =evt.srcElement; 
}else if(evt.target){
	target =evt.target;
}
var datType;
var keyCde;
if(target && target.style && target.style.dataType){
 datType = target.style.dataType;
}
if(evt && evt.keyCode){
 keyCde = evt.keyCode;
}
if(keyCde){
 if(keyCde == currentKey){
  currentKey = pressedKeyFirst;
  pressedKeyFirst = pressedKeySecond;
  pressedKeySecond = pressedKeyThird;
  pressedKeyThird = pressedKeyFourth;
  pressedKeyFourth = pressedKeyFifth;
  pressedKeyFifth = null;
 }else if(keyCde == pressedKeyFirst){
  pressedKeyFirst = pressedKeySecond;
  pressedKeySecond = pressedKeyThird;
  pressedKeyThird = pressedKeyFourth;
  pressedKeyFourth = pressedKeyFifth;
  pressedKeyFifth = null;
 }else if(keyCde == pressedKeySecond){
  pressedKeySecond = pressedKeyThird;
  pressedKeyThird = pressedKeyFourth;
  pressedKeyFourth = pressedKeyFifth;
  pressedKeyFifth = null;
 }else if(keyCde == pressedKeyThird){
  pressedKeyThird = pressedKeyFourth;
  pressedKeyFourth = pressedKeyFifth;
  pressedKeyFifth = null;
 }else if(keyCde == pressedKeyFourth){
  pressedKeyFourth = pressedKeyFifth;
  pressedKeyFifth = null;
 }else if(keyCde == pressedKeyFifth){
  pressedKeyFifth = null;
 }
}else{
 return true;
}
}

document.onkeydown = keyDownFunction;
document.onkeyup = keyUpFunction;
//document.oncontextmenu = function(){return false;}

function isArrows(keyCde){
 if(keyCde >= 37 && keyCde <= 40){
  return true;
 }
 return false;
}

function escapeSpecialChars(keyCde){
 // all function keys
 if(keyCde >= 112 && keyCde <= 123){
  return true;
 }else if(keyCde == 13 || keyCde == 8 || keyCde == 18 || keyCde == 9 || keyCde == 20 || keyCde == 45 ||
     keyCde == 36 || keyCde == 33 || keyCde == 46 || keyCde == 35 || keyCde == 34|| keyCde == 144 || isArrows(keyCde)){
    //13 - enter, 8 - backspace, 18 - alt, 9 - tab, 20 - caps lock, 45 - insert, 36 - home, 33 - page up, 46 - delete, 35 - end, 34 - page down, 144 - num lock
  return true;   
 }
 return false;
}
function isSlash(){
 if (currentKey == 191 || currentKey == 220 || currentKey == 111){
 return true;
 }
 else{
 return false;
 }
 }

function handleAlphaNumericOnly(keyCde){
 if(keyCde >= 65 && keyCde <= 90){
  return true;
}
else if(handleNumeric(keyCde) || (isDote() && !isDoteAlreadyInValue())){
  return true;
 }
else{
return false;
}
}

function handleAlphaNumericSpecial(keyCde){
	if(handleAlphaNumeric(keyCde)){
		  return true;
	}else if(isPlus()|| isPound()){	
		  return true;
	 }
	else{
		return false;
	}
}

function handleAlphaNumericSpecialOnly(keyCde){
	if(handleAlphaNumericOnly(keyCde)){
	  return true;
	}else if(isPlus() || isPound() || isSlash() || isHyphen() || isSpace()){				
		  return true;
	 }
	else{
		return false;
	}
}

function handleAlphaNumericCustomer(keyCde) {
	if (handleAlphaNumericSpecial(keyCde)) {
		  return true;
	} else if (isBrackets() || isAsterisk()) {	
		  return true;
	} else {
		return false;
	}
}

function isPlus(){
	 if(currentKey == 107){
		  return true;
	 }else if(isShiftPressed() && currentKey == 187){
		 return true;
	 }
	return false;
}

function isPound(){
	 if(isShiftPressed() && currentKey == 51){
		  return true;
	 }
	return false;
}

function isAsterisk() {
	if (isShiftPressed() && currentKey == 56) {
		return true;
	} else if (currentKey == 106) {
		return true;
	}
	return false;
}