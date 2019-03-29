<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@attribute  name="uniqueId" required="true" rtexprvalue="false" %>
<%@attribute  name="openMethod" required="true" rtexprvalue="true" %>
<%@attribute  name="closeMethod" required="true" rtexprvalue="true" %>
<%@attribute  name="preCloseMethod" required="true" rtexprvalue="true" %>


<c:url value="${path}" var="popUpPath"></c:url>
<div id="pnl123" style="dataType: default;"></div> 
<div id="authorizeStorePanel" style="display: none;">
	<div class="hd">
	</div>
	<div class="bd">
		<iframe id="authorizeStoreFrame" height="1px" width="1px"></iframe>
	</div>
</div>
<div id="factoryPanel" style="display: none;">
	<div class="hd">
	</div>
	<div class="bd">
		<iframe id="factoryFrame" height="1px" width="1px"></iframe>
	</div>
</div>
<script type="text/javascript">

function hi${uniqueId}(path, header,height, width, top, left){
tmpPnl.show();
document.getElementById('temp${uniqueId}').style.visibility = 'visible';
document.getElementById('${uniqueId}').src=path;
var inHtml = '<table width="100%">'+
'<tr><td>'+ header +'</td><td align="right">'+
'<a onclick="up${uniqueId}(null);close${uniqueId}();return false;" href="#">'+
'<B><font color="white">X</font></B></a>'+
'</td></tr>'+
'</table>';
document.getElementById('head${uniqueId}').innerHTML = inHtml;
document.getElementById('temp${uniqueId}').style.height = height;
var frme = document.getElementById('${uniqueId}');
frme.height = height;
document.getElementById('temp${uniqueId}').style.width = width;
document.getElementById('temp${uniqueId}').style.top = top;
document.getElementById('temp${uniqueId}').style.left = left;
//frme.height = frme.contentWindow.document.body.offsetHeight + 'px';
}
var hook${uniqueId} = null;
function ${preCloseMethod}(funct){
	if(hook${uniqueId} == null){
		hook${uniqueId} = function(){
			return funct();
		};
	}else{
		var tmp = hook${uniqueId};
		hook${uniqueId} = function(){
			if(tmp()){
				return funct();
			}
		};
	}
}
function close${uniqueId}(){
	if( (hook${uniqueId} != null && hook${uniqueId}()) ||  hook${uniqueId} == null){
		document.getElementById('${uniqueId}').src="";
		document.getElementById('temp${uniqueId}').style.visibility = 'hidden';
		tmpPnl.hide();
		hook${uniqueId} = null;
	}
	//stop progress bar if user clicking on Close icon and progress bar still display
	if(stopProgress==false) {
		window.parent.hideProgress();
	}
}

var iframeTop;
var iframeLeft;

var clicked${uniqueId} = false;
var a${uniqueId};var b${uniqueId};

function down${uniqueId}(){
clicked${uniqueId} = true;
var e = window.event;
a${uniqueId} = e.clientX;
b${uniqueId} = e.clientY;
document.onmousemove = move${uniqueId};
document.onmouseup = up${uniqueId};
iframeTop = document.getElementById('temp${uniqueId}').offsetTop;
iframeLeft = document.getElementById('temp${uniqueId}').offsetLeft;
window.frames['${uniqueId}Frame'].document.onmousemove = moveSubDoc;
window.frames['${uniqueId}Frame'].document.onmouseup = up${uniqueId};
}


function moveSubDoc(event){
event = window.frames['${uniqueId}Frame'].event;
var e = event;
var aX = e.clientX;
var bX = e.clientY;
var mRight = aX + iframeLeft;
var mDown = bX + iframeTop;
move1(mRight,mDown); 
iframeTop = document.getElementById('temp${uniqueId}').offsetTop;
iframeLeft = document.getElementById('temp${uniqueId}').offsetLeft;
}

function up${uniqueId}(event){
clicked${uniqueId} = false;
document.onmouseup = '';
window.frames['${uniqueId}Frame'].document.onmousemove = '';
}

function move${uniqueId}(event){
if(clicked${uniqueId} ){	
var e = window.event;
var aX = e.clientX;
var bX = e.clientY;
move1(aX,bX);
}
}

function move1(aX,bX){	
var t = document.getElementById('temp${uniqueId}').style.top + '';
var l = document.getElementById('temp${uniqueId}').style.left + '';
var temp = t.split('px');
var tmath = parseInt(temp[0]);
var temp = l.split('px');
var lmath = parseInt(temp[0]);
var off;
if( a${uniqueId} != aX && aX > a${uniqueId}){
//move right
off = aX - a${uniqueId};
lmath = lmath + off;
}
if( a${uniqueId} != aX && aX < a${uniqueId}){
off = a${uniqueId} - aX;
lmath = lmath - off;
}
if( b${uniqueId} != bX && bX > b${uniqueId}){
//move ri
off = bX-b${uniqueId};
tmath = tmath + off;
}
if( b${uniqueId} != bX && bX < b${uniqueId}){
//move right
off = b${uniqueId} - bX;
tmath = tmath - off;
}
document.getElementById('temp${uniqueId}').style.top = tmath + 'px';
document.getElementById('temp${uniqueId}').style.left = lmath + 'px';
a${uniqueId} = aX;
b${uniqueId} = bX;
}

${openMethod} = hi${uniqueId};
${closeMethod} = close${uniqueId};


var tmpPnl = new YAHOO.widget.Panel("pnl123", { xy:[200,250], width: "1px", height : "1px", visible: false,zIndex : 25000,modal : true,
												draggable:false,close:false } );
tmpPnl.render();


</script>
<div id="temp${uniqueId}" style="visibility: hidden;position:absolute;top:100px;left:100px;width:60%;height:90%;z-index:50000;min-width: 0;">
	<div id="head${uniqueId}" style="background-color:#005A86;height:40px;font-style:bold;font-size:large;color:#FFFFFF;min-width: 0;" onmousedown="down${uniqueId}(); " >
		<table width="100%">
			<tr>
				<td> Header</td>
				<td align="right" >
					<a onclick="up${uniqueId}(null);close${uniqueId}();return false;" href="#">
 						Close
 					</a>
				</td>
			</tr>
		</table>
  	</div>
	<div id="l${uniqueId}" style="min-width: 0;"/>
	<iframe id="${uniqueId}" name="${uniqueId}Frame" width="100%"/>
</div>
