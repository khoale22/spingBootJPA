<% response.setContentType("text/css"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

@charset "UTF-8";
/* CSS Document */

body {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #FFFFFF;
	margin:auto;
	background-color:#FFFFFF;
	visibility : hidden;
}

td, th {
	
}

a {
	color: #3366CC;
	text-decoration: none;
}



.title {
	font-family: Arial, Helvetica, sans-serif;
  font-size: 24px;
	line-height: 30px;
  background-color: #006666;
	color: #DCDCDC;
}

.subtitle {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
	line-height: 22px;
	font-weight: bold;
	color: #006666;
}

.header {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 24px;
	background-color: #006666;
  	color: #DCDCDC;
}


#collapsiblePanel {
	background-color:#CCCCCC;
	border:1px solid #D7D0D0;
	margin-top: 5px;
	margin-right: 5px;
	margin-bottom: 5px;
	margin-left: 5px;
}



/* Login Screen begin */

#loginContainer {
	margin-top: 45px;
	margin-right: 0px;
	margin-bottom: 10px;
	margin-left: 0px;
}

#loginLegalContent {
	margin-top: 10px;
	margin-right: 100px;
	margin-bottom: 15px;
	margin-left: 100px;
}

#loginInputContainer {
	width: 100%;
	margin-top: 10px;
	margin-bottom: 15px;
	padding-top: 10px;
	padding-bottom: 15px;
	line-height: 18px;
	border-top:0px solid #D7D0D0;
	border-bottom:0px solid #D7D0D0;
}

.loginInputContent {
	background:#FFFFFF;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #333333;
	font-weight: bold;
}

.loginContent {
	border-top:1px solid #D7D0D0;
	border-bottom:1px solid #D7D0D0;
	background:#F5EFEA;
	margin: 35px;
	padding-top:10px;
}

.loginLegalPara {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #333333;
	text-align:left;
}

.loginTitle {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
	color: #333333;
	font-weight: bold;
	text-align: center;
}

/* Login Screen end */

.headerPlacement {
	position:absolute;
	left:0px;
	top:0px;
	width:100%;
	height:150px;
	z-index:1;
}


#ContentContainer {
	float:left;
	clear:left;
	margin-top: 10px;
	margin-right: 15px;
	margin-bottom: 10px;
	margin-left: 15px;
	}
	
#announcementIconContainer {
	margin-right: 5px;
}
	
.announcementTitle {
	font-family: Arial, Helvetica, sans-serif;
	font-size:12px;
	font-weight:bold;
}
	
.SnippetTitle {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight:bold;
	line-height: 18px;
	padding-bottom:7px;
}

.columnContent {
	border-top:1px solid #D7D0D0;
	border-bottom:1px solid #D7D0D0;
	border-left:1px solid #D7D0D0;
	border-right:1px solid #D7D0D0;
	background:#F5EFEA;
	padding: 5px;
}


/* Form page begin */

.FormContent {
	border-top:1px solid #D7D0D0;
	border-bottom:1px solid #D7D0D0;
	border-left:1px solid #D7D0D0;
	border-right:1px solid #D7D0D0;
	background:#F5EFEA;
	padding:10px;
	width:600px;
}

div.form-container { 
	margin: 5px; 
	padding: 5px; 
	background-color: #FFF; 
}

p.legend { 
	margin-bottom: 1em; 
}

p.legend em { 
	color: #666666; 
	font-style: normal; 
}

div.errors { 
	margin: 0 0 10px 0; 
	padding: 5px 10px; 
	border: #666666 1px solid; 
	background-color: #F5EFEA; 
}

div.hidden_errors{
	display: none;	
}

div.errors p { 
	margin: 0; 
}

div.errors p em { 
	color: #C00; 
	font-style: normal;
	font-weight:bold;
}

div.form-container form p { 
	margin: 0; 
}

div.form-container form p.note { 
	margin-left: 170px; 
	font-size: 90%; 
	color: #333; 
}

div.form-container form fieldset { 
	margin: 10px 0; 
	padding: 10px; 
	border: #666 1px solid; 
	}
	
div.form-container form legend { 
	font-weight: 
	bold; color: #666666; 
	}
	
div.form-container form fieldset div { 
	padding: 0.55em 0; 
	}
	
div.form-container label, 
div.form-container span.label { 
	margin-right: 10px; 
	padding-right: 10px; 
	 
	display: block; 
	float: left; 
	text-align: right; 
	position: relative; 
	}
	
div.form-container label.error, 
div.form-container span.error { 
	color: #C00; 
	}
div.form-container label em, 
div.form-container span.label em { 
	position: absolute; 
	right: 0; 
	font-size: 120%; 
	font-style: normal; 
	color: #C00; 
	}
	
div.form-container input.error { 
	border-color: #C00; 
	background-color: #FEF; 
	}
	
div.form-container input:focus,
div.form-container input.error:focus, 
div.form-container textarea:focus {	
	background-color: #FFC; 
	border-color: #FC6; 
	}
	
div.form-container div.controlset label, 
div.form-container div.controlset input { 
	display: inline; 
	float: none; 
	}
	
div.form-container div.controlset div { 
	margin-left: 170px; 
	}
div.form-container div.buttonrow { 
	margin-left: 180px; 
	}

/* Form page end */

.legal {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #333333;
}

.box1 {
	border-color: #CCCCCC #333333 #333333 #CCCCCC;
	border-width: medium;
  border-style: ridge;
}

a:hover {
	text-decoration: underline;
}

input.big {
	width: 100px;
}

input.small {
	width: 50px;
}

#columContainer {
	width: 100%;  /* this width will create a container that will fit in an 800px browser window if text is left at browser default font sizes */
	background: #FFFFFF;
	padding: 5px 5px 5px 5px;
} 


#container {

	width: 100%;  /* this width will create a container that will fit in an 800px browser window if text is left at browser default font sizes */
	background: #FFFFFF;
	margin: auto; /* the auto margins (in conjunction with a width) center the page */
	text-align: left;
} 



.headerTop1 {r
	background:url(${imgUrl}) repeat-x;
	padding:3px 0px 5px 0px;
}
.headerTop {
	background:url(images/IMG_header_bg.gif) repeat-x;
	padding:3px 0px 5px 0px
}

#currentLocationStyleContainer {
	display:none;
	position:absolute;
	width:auto;
	height:auto;
	z-index:6;
	left: 95px;
	top: 10px;
}

.currentLocationStyle {
font-family:Arial, Helvetica, sans-serif;
	font-size:14px;
	color:#BBBBBB;
	font-weight:bold;
	font-style:italic;
}

.mainContent {
	margin-top: 7px;
	text-align:left;
	font-family:Arial, Helvetica, sans-serif;
	font-size:11px;
	color:#333333;
}


<c:url value="${request.getContextPath()}/hebAssets/images/IMG_footerBg.gif" var="imgUrl" />

#footer {
	padding: 0 10px; /* this padding matches the left alignment of the elements in the divs that appear above it. */
	background: url(${imgUrl}) repeat-x #ffffff;
} 

#footer p {
	margin: 0; /* zeroing the margins of the first element in the footer will avoid the possibility of margin collapse - a space between divs */
	padding: 5px 10px; /* padding on this element will create space, just as the the margin would have, without the margin collapse issue */
	text-align:right;
	color:#FFFFFF;
}

.footer {
  	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	line-height: 22px;
	color: #333333;
	background-color: #CCCCCC;
}

.icon {
	padding:5px; /* Not always used */
}

#helpFloater {
	position:absolute;
	right:11px;
	top:11px;
	width:auto;
	height:auto;
	z-index:5;
	text-align:right;
	font-weight:bold;
}

#LoginHelpFloater { /* This is specific to the Login screen */
	position:absolute;
	right:10px;
	top:10px;
	width:40px;
	height:43px;
	z-index:5;
}


.helpStyle {
	background:transparent;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #333333;
	font-weight: bold;
	text-decoration:none;
}

/*tabnav*/

.tableContent {
	border-top:1px solid #D7D0D0;
	border-left:1px solid #D7D0D0;
	border-right:1px solid #D7D0D0;
	border-bottom:1px solid #D7D0D0;
	background:#F5EFEA;
	padding:10px
	}

#tabnav {
	position:relative;
	float:left;
	width:100%;
	padding:0;
	margin:0;
	list-style:none;
	line-height:1em;
}

#tabnav LI {
	float:left;
	margin:0;
	padding:0;
}

#tabnav A {
	display:block;
	color:#989391;
	text-decoration:none;
	font-weight:bold;
	background:#E6DEDB;
	margin:0px 3px 0px 0px;
	padding:0.25em 1em;
	border-left:1px solid #D7D0D0;
	border-top:1px solid #D7D0D0;
	border-right:1px solid #D7D0D0;
	border-bottom:1px solid #D7D0D0;
	width:75px
}

#tabnav A:hover,
#tabnav A:active,
#tabnav A.active:link,
#tabnav A.active:visited {
	background:#F5EFEA;
	border-bottom:1px solid #F5EFEA
}

#tabnav A.active:link,
#tabnav A.active:visited {
	position:relative;
	z-index:102;
}

.basicLinkStyle {
	font-family:Arial, Helvetica, sans-serif;
	text-decoration:none;
	font-size:11px;
	font-weight:bold;
	}

.tabContent {
	border-left:1px solid #D7D0D0;
	border-right:1px solid #D7D0D0;
	border-bottom:1px solid #D7D0D0;
	background:#F5EFEA;
	padding:10px;
	}
	
.dataGridHead {
	background-color:#E7DEDE;
	font-weight:bold;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-face: #9C9494;
	}
	
.labelHead {
	font-weight:bold;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-face: #9C9494;
	}
	
.labelMessageHead {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #0000FF;
	font-face: #9C9494;
	}
	
.uGridAlt {
	background-color:#F7F7F7;
	}
	
.mainTitle {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-weight: bold;
	color: #333333;
	text-align:center;
}

.mainTitle2 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-weight: bold;
	color: #333333;
	text-align:Left;
	padding-bottom: 10px;
	padding-left:5px;
}


/* Miscellaneous classes for reuse */
.fltrt { /* this class can be used to float an element right in your page. The floated element must precede the element it should be next to on the page. */
	float: right;
	margin-left: 8px;
}
.fltlft { /* this class can be used to float an element left in your page */
	float: left;
	margin-right: 8px;
}
.clearfloat { /* this class should be placed on a div or break element and should be the final element before the close of a container that should fully contain a float */
	clear:both;
    height:0;
    font-size: 1px;
    line-height: 0px;
}


/*New classes for CPS*/
.buttonStyle {
	width: 65px;
	}

.selectBoxStyle {
	width : 200px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;	
	}
.selectBoxStyle2 {
	width : 150px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;	
}
.selectBoxStyle3 {
	width : 100px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;	
}
.selectBoxStyleBig {
	width : 275px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;	
	}
.selectBoxStyleOrientationDRU {
	width : 40px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;	
}
.textFieldNormal{
	width : 150px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;	
}
.textFieldMedium{
	width : 120px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;	
}
.textFieldMedium2{
	width : 80px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;	
}
.textFieldSmall{
	width : 60px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;	
}

.labelFont{
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;	
}

.legendFont{
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 13px;
	color: #666666;
	
	
}
/*Even row*/
.row1{
	background-color: #F7F7F7; 
}

/*Odd row*/
.row0{
	background-color: #FFFFFF;
}	
	
.HEBTabContent{
	width: 100%;
	height: 300px;
	overflow: auto;
}

.textArea{
	width: 95%;
	height: 45px;
	overflow: auto;
}	

.hide{
	border : 0;
}
.noHide{
	border : 1;
}

div {
	position : relative;
	min-width:0;
}

BODY {
	FONT-SIZE: 11px; MARGIN: auto; COLOR: #333333; FONT-FAMILY: Arial, Helvetica, sans-serif; BACKGROUND-COLOR: #d6dce2
}
TD {
	
}
TH {
	
}

.title {
	FONT-SIZE: 24px; COLOR: #dcdcdc; LINE-HEIGHT: 30px; FONT-FAMILY: Arial, Helvetica, sans-serif; BACKGROUND-COLOR: #006666
}
.subtitle {
	FONT-WEIGHT: bold; FONT-SIZE: 16px; COLOR: #006666; LINE-HEIGHT: 22px; FONT-FAMILY: Arial, Helvetica, sans-serif
}
.header {
	FONT-SIZE: 24px; COLOR: #dcdcdc; FONT-FAMILY: Arial, Helvetica, sans-serif; BACKGROUND-COLOR: #006666
}
#collapsiblePanel {
	BORDER-RIGHT: #d7d0d0 1px solid; BORDER-TOP: #d7d0d0 1px solid; MARGIN: 5px; BORDER-LEFT: #d7d0d0 1px solid; BORDER-BOTTOM: #d7d0d0 1px solid; BACKGROUND-COLOR: #cccccc
}
#loginContainer {
	MARGIN: 45px 0px 10px
}
#loginLegalContent {
	MARGIN: 10px 100px 15px
}
#loginInputContainer {
	BORDER-TOP: #d7d0d0 1px solid; MARGIN-TOP: 10px; MARGIN-BOTTOM: 15px; PADDING-BOTTOM: 15px; WIDTH: 100%; LINE-HEIGHT: 18px; PADDING-TOP: 10px; BORDER-BOTTOM: #d7d0d0 1px solid
}
.loginInputContent {
	FONT-WEIGHT: bold; FONT-SIZE: 12px; BACKGROUND: #ffffff; COLOR: #333333; FONT-FAMILY: Arial, Helvetica, sans-serif
}
.loginContent {
	BORDER-TOP: #d7d0d0 1px solid; BACKGROUND: #f5efea; MARGIN: 35px; PADDING-TOP: 10px; BORDER-BOTTOM: #d7d0d0 1px solid
}
.loginLegalPara {
	FONT-SIZE: 11px; COLOR: #333333; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-ALIGN: left
}
.loginTitle {
	FONT-WEIGHT: bold; FONT-SIZE: 16px; COLOR: #333333; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-ALIGN: center
}
#homePageContainer {
	MARGIN: 10px 15px
}
#announcementIconContainer {
	MARGIN-RIGHT: 5px
}
.announcementTitle {
	FONT-WEIGHT: bold; FONT-SIZE: 12px; FONT-FAMILY: Arial, Helvetica, sans-serif
}
.SnippetTitle {
	FONT-WEIGHT: bold; FONT-SIZE: 12px; PADDING-BOTTOM: 7px; LINE-HEIGHT: 18px; FONT-FAMILY: Arial, Helvetica, sans-serif
}
.columnContent {
	BORDER-RIGHT: #d7d0d0 1px solid; PADDING-RIGHT: 5px; BORDER-TOP: #d7d0d0 1px solid; PADDING-LEFT: 5px; BACKGROUND: #f5efea; PADDING-BOTTOM: 5px; BORDER-LEFT: #d7d0d0 1px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #d7d0d0 1px solid
}
.FormContent {
	BORDER-RIGHT: #d7d0d0 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #d7d0d0 1px solid; PADDING-LEFT: 10px; BACKGROUND: #f5efea; PADDING-BOTTOM: 10px; BORDER-LEFT: #d7d0d0 1px solid; WIDTH: 600px; PADDING-TOP: 10px; BORDER-BOTTOM: #d7d0d0 1px solid
}
DIV.form-container {
	PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; MARGIN: 5px; PADDING-TOP: 5px; BACKGROUND-COLOR: #fff
}

DIV.errors {
	BORDER-RIGHT: #666666 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #666666 1px solid; PADDING-LEFT: 10px; PADDING-BOTTOM: 5px; MARGIN: 0px 0px 10px; BORDER-LEFT: #666666 1px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #666666 1px solid; BACKGROUND-COLOR: #f5efea
}
DIV.errors P {
	MARGIN: 0px
}
DIV.errors P EM {
	COLOR: #c00; FONT-STYLE: normal
}
DIV.form-container FORM P {
	MARGIN: 0px
}
DIV.form-container FORM P.note {
	FONT-SIZE: 90%; MARGIN-LEFT: 170px; COLOR: #333
}
DIV.form-container FORM FIELDSET {
	BORDER-RIGHT: #ddd 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #ddd 1px solid; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; MARGIN: 10px 0px; BORDER-LEFT: #ddd 1px solid; PADDING-TOP: 10px; BORDER-BOTTOM: #ddd 1px solid
}

DIV.form-container FORM FIELDSET DIV {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0.55em; PADDING-TOP: 0.55em
}
DIV.form-container LABEL {
	PADDING-RIGHT: 10px; DISPLAY: block; FLOAT: left; WIDTH: 150px; MARGIN-RIGHT: 10px; POSITION: relative; TEXT-ALIGN: right
}
DIV.form-container SPAN.label {
	PADDING-RIGHT: 10px; DISPLAY: block; FLOAT: left; WIDTH: 150px; MARGIN-RIGHT: 10px; POSITION: relative; TEXT-ALIGN: right
}
DIV.form-container LABEL.error {
	COLOR: #c00
}
DIV.form-container SPAN.error {
	COLOR: #c00
}
DIV.form-container LABEL EM {
	FONT-SIZE: 120%; RIGHT: 0px; COLOR: #c00; FONT-STYLE: normal; POSITION: absolute
}
DIV.form-container SPAN.label EM {
	FONT-SIZE: 120%; RIGHT: 0px; COLOR: #c00; FONT-STYLE: normal; POSITION: absolute
}
DIV.form-container INPUT.error {
	BORDER-LEFT-COLOR: #c00; BORDER-BOTTOM-COLOR: #c00; BORDER-TOP-COLOR: #c00; BACKGROUND-COLOR: #fef; BORDER-RIGHT-COLOR: #c00
}
DIV.form-container INPUT:focus {
	BORDER-LEFT-COLOR: #fc6; BORDER-BOTTOM-COLOR: #fc6; BORDER-TOP-COLOR: #fc6; BACKGROUND-COLOR: #ffc; BORDER-RIGHT-COLOR: #fc6
}
DIV.form-container INPUT.error:focus {
	BORDER-LEFT-COLOR: #fc6; BORDER-BOTTOM-COLOR: #fc6; BORDER-TOP-COLOR: #fc6; BACKGROUND-COLOR: #ffc; BORDER-RIGHT-COLOR: #fc6
}
DIV.form-container TEXTAREA:focus {
	BORDER-LEFT-COLOR: #fc6; BORDER-BOTTOM-COLOR: #fc6; BORDER-TOP-COLOR: #fc6; BACKGROUND-COLOR: #ffc; BORDER-RIGHT-COLOR: #fc6
}
DIV.form-container DIV.controlset LABEL {
	DISPLAY: inline; FLOAT: none
}
DIV.form-container DIV.controlset INPUT {
	DISPLAY: inline; FLOAT: none
}
DIV.form-container DIV.controlset DIV {
	MARGIN-LEFT: 170px
}
DIV.form-container DIV.buttonrow {
	MARGIN-LEFT: 180px
}
.sidebar {
	PADDING-RIGHT: 3px; PADDING-LEFT: 3px; FONT-SIZE: 12px; PADDING-BOTTOM: 3px; LINE-HEIGHT: 18px; PADDING-TOP: 3px; FONT-FAMILY: Arial, Helvetica, sans-serif; BACKGROUND-COLOR: #ffffff
}
.sidebarHeader {
	FONT-SIZE: 16px; COLOR: #ffffff; LINE-HEIGHT: 24px; FONT-FAMILY: Arial, Helvetica, sans-serif; BACKGROUND-COLOR: #339999
}
.sidebarFooter {
	FONT-SIZE: 12px; LINE-HEIGHT: 18px; FONT-FAMILY: Arial, Helvetica, sans-serif; BACKGROUND-COLOR: #cccccc
}
.footer {
	FONT-WEIGHT: bold; FONT-SIZE: 14px; COLOR: #333333; LINE-HEIGHT: 22px; FONT-FAMILY: Arial, Helvetica, sans-serif; BACKGROUND-COLOR: #cccccc; TEXT-ALIGN: center
}
.legal {
	FONT-SIZE: 9px; COLOR: #333333; FONT-FAMILY: Arial, Helvetica, sans-serif
}
.box1 {
	BORDER-RIGHT: #333333 ridge; BORDER-TOP: #cccccc ridge; BORDER-LEFT: #cccccc ridge; BORDER-BOTTOM: #333333 ridge
}
A:hover {
	TEXT-DECORATION: underline
}
INPUT.big {
	WIDTH: 100px
}
INPUT.small {
	WIDTH: 50px
}
#columContainer {
	PADDING-RIGHT: 5px; PADDING-LEFT: 5px; BACKGROUND: #ffffff; PADDING-BOTTOM: 5px; WIDTH: 100%; PADDING-TOP: 5px
}
#container {
	BACKGROUND: #ffffff; WIDTH: 100%; TEXT-ALIGN: left
}
.headerTop {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; BACKGROUND: url(images/IMG_header_bg.gif) repeat-x; PADDING-BOTTOM: 5px; PADDING-TOP: 3px
}
#currentLocationStyleContainer {
	Z-INDEX: 6; LEFT: 95px; WIDTH: 338px; display:none; POSITION: absolute; TOP: 10px; HEIGHT: 45px
}
.currentLocationStyle {
	FONT-WEIGHT: bold; FONT-SIZE: 14px; COLOR: #bbbbbb; FONT-STYLE: italic
}
.mainContent {
	MARGIN-TOP: 7px; FONT-SIZE: 11px; COLOR: #333333; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-ALIGN: left
}
#footer {
	PADDING-RIGHT: 10px; PADDING-LEFT: 10px; BACKGROUND: url(images/IMG_footerBg.gif) #ffffff repeat-x; PADDING-BOTTOM: 0px; PADDING-TOP: 0px;
}
#footerEdi {
	z-index:-1; PADDING-RIGHT: 10px; PADDING-LEFT: 10px; BACKGROUND: url(images/IMG_footerBg.gif) #ffffff repeat-x; PADDING-BOTTOM: 0px; PADDING-TOP: 0px;
}
#footer P {
	PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 5px; MARGIN: 0px; COLOR: #ffffff; PADDING-TOP: 5px; TEXT-ALIGN: center
}
.icon {
	PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; PADDING-TOP: 5px
}
#helpFloater {
	FONT-WEIGHT: bold; Z-INDEX: 5; RIGHT: 11px; WIDTH: 300px; POSITION: absolute; TOP: 11px; HEIGHT: 43px; TEXT-ALIGN: right
}
#LoginHelpFloater {
	Z-INDEX: 5; RIGHT: 10px; WIDTH: 40px; POSITION: absolute; TOP: 10px; HEIGHT: 43px
}
.helpStyle {
	FONT-WEIGHT: bold; FONT-SIZE: 10px; BACKGROUND: none transparent scroll repeat 0% 0%; COLOR: #333333; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-DECORATION: none
}
.tableContent {
	BORDER-RIGHT: #d7d0d0 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #d7d0d0 1px solid; PADDING-LEFT: 10px; BACKGROUND: #f5efea; PADDING-BOTTOM: 10px; BORDER-LEFT: #d7d0d0 1px solid; PADDING-TOP: 10px; BORDER-BOTTOM: #d7d0d0 1px solid
}
#tabnav {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 100%; LINE-HEIGHT: 1em; PADDING-TOP: 0px; LIST-STYLE-TYPE: none; POSITION: relative
}
#tabnav LI {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px
}
#tabnav A {
	BORDER-RIGHT: #d7d0d0 1px solid; PADDING-RIGHT: 1em; BORDER-TOP: #d7d0d0 1px solid; DISPLAY: block; PADDING-LEFT: 1em; FONT-WEIGHT: bold; BACKGROUND: #e6dedb; PADDING-BOTTOM: 0.25em; MARGIN: 0px 3px 0px 0px; BORDER-LEFT: #d7d0d0 1px solid; WIDTH: 75px; COLOR: #989391; PADDING-TOP: 0.25em; BORDER-BOTTOM: #d7d0d0 1px solid; TEXT-DECORATION: none
}
#tabnav A:hover {
	BACKGROUND: #f5efea; BORDER-BOTTOM: #f5efea 1px solid
}
#tabnav A:active {
	BACKGROUND: #f5efea; BORDER-BOTTOM: #f5efea 1px solid
}
#tabnav A.active:link {
	BACKGROUND: #f5efea; BORDER-BOTTOM: #f5efea 1px solid
}
#tabnav A.active:visited {
	BACKGROUND: #f5efea; BORDER-BOTTOM: #f5efea 1px solid
}
#tabnav A.active:link {
	Z-INDEX: 102; POSITION: relative
}
#tabnav A.active:visited {
	Z-INDEX: 102; POSITION: relative
}
.basicLinkStyle {
	FONT-WEIGHT: bold; FONT-SIZE: 11px; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-DECORATION: none
}
.tabContent {
	BORDER-RIGHT: #d7d0d0 1px solid; PADDING-RIGHT: 10px; PADDING-LEFT: 10px; BACKGROUND: #f5efea; PADDING-BOTTOM: 10px; BORDER-LEFT: #d7d0d0 1px solid; PADDING-TOP: 10px; BORDER-BOTTOM: #d7d0d0 1px solid
}
.dataGrid {
	COLOR:black; BACKGROUND-COLOR: #ffffff
}
.dataGrid TD {
	BORDER-RIGHT: black 0px solid; PADDING-RIGHT: 5px; BORDER-TOP: #ffffff 0px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; BORDER-LEFT: #ffffff 0px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #ffffff 0px solid
}
.dataGrid TR {
	cursor: pointer;
}
.dataGridHead {
	FONT-WEIGHT: bold; BACKGROUND-COLOR: #e6dedb
}

.dataGridHead1 {
	FONT-WEIGHT: bold; BACKGROUND-COLOR: #FFFFFF
}

.dataGridAlt {
	BACKGROUND-COLOR: #f7f7f7
}
.mainTitle {
	FONT-WEIGHT: bold; FONT-SIZE: 16px; COLOR: #333333; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-ALIGN: center
}
.mainTitle2 {
	FONT-WEIGHT: bold; FONT-SIZE: 16px; PADDING-BOTTOM: 10px; COLOR: #333333; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-ALIGN: left
}
.fltrt {
	FLOAT: right; MARGIN-LEFT: 8px
}
.fltlft {
	FLOAT: left; MARGIN-RIGHT: 8px
}
.clearfloat {
	CLEAR: both; FONT-SIZE: 1px; LINE-HEIGHT: 0px; HEIGHT: 0px
}


.dataGridAlt {
	BACKGROUND-COLOR: #f7f7f7
}
.mainTitle {
	FONT-WEIGHT: bold; FONT-SIZE: 16px; COLOR: #333333; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-ALIGN: center
}
.mainTitle2 {
	FONT-WEIGHT: bold; FONT-SIZE: 16px; PADDING-BOTTOM: 10px; COLOR: #333333; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-ALIGN: left
}
.fltrt {
	FLOAT: right; MARGIN-LEFT: 8px
}
.fltlft {
	FLOAT: left; MARGIN-RIGHT: 8px
}
.clearfloat {
	CLEAR: both; FONT-SIZE: 1px; LINE-HEIGHT: 0px; HEIGHT: 0px
}


a1 {
	color: #FFFFFF;
	text-decoration: none;
}
#searchResults a:link {
     color : black;
     font-family : arial;
     font-weight : bold;
     BACKGROUND-COLOR:#E6DEDB;
    
    }

.yui-skin-sam .yui-dt-col-address pre { font-family:arial;font-size:100%; } 
.origin { display: block; background: #795089; padding: 1ex; color: #fff; text-align: right; margin-bottom: 1em; }
.yui-skin-sam .mask {
	opacity: 0.12;
	*filter: alpha(opacity=12); /* Set opacity in IE */
} 
	
#heb {height:20em;}

/* XP Panel Skin CSS */
	
/* Skin default elements */
#RNAPanel_c.yui-panel-container.shadow .underlay {
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
#RNAPanel.yui-panel {
	border:none;
	overflow:visible;
	background:transparent url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-rt.gif) no-repeat top right;
}

/* Style the close icon */
#RNAPanel.yui-panel .container-close {
	position:absolute;
	top:5px;
	right:8px;
	height:21px;
	width:21px;
	background:url(<%=request.getContextPath()%>/hebAssets/images/xp-close.gif) no-repeat;
}

/* Style the header with its associated corners */
#RNAPanel.yui-panel .hd {
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
#RNAPanel.yui-panel .bd {
	overflow:hidden;
	padding:10px;
	border:none;
	background:#FFF url(<%=request.getContextPath()%>/hebAssets/images/xp-brdr-lt.gif) repeat-y; 
	margin:0 4px 0 0;
}

/* Style the footer with the bottom corner images */
#RNAPanel.yui-panel .ft {
	background: url(<%=request.getContextPath()%>/hebAssets/images/xp-ft.gif) repeat-x;
	font-size:11px;
	height:26px;
	padding:0px 10px;
	border:none
}

/* Skin custom elements */
#RNAPanel.yui-panel .hd span {
	line-height:30px;
	vertical-align:middle;
	font-weight:bold;
}
#RNAPanel.yui-panel .hd .tl {
	width:8px;
	height:29px;
	top:1px;
	left:0px;
	background: url(<%=request.getContextPath()%>/hebAssets/images/xp-tl.gif) no-repeat;
	position:absolute;
}
	
	
#RNAPanel.yui-panel .hd .tr {
	width:8px;
	height:29px;
	top:1px;
	right:0;
	background:url(<%=request.getContextPath()%>/hebAssets/images/xp-tr.gif) no-repeat; 
	position:absolute;
}

#RNAPanel.yui-panel .ft span {
	line-height:22px;
	vertical-align:middle;
}
#RNAPanel.yui-panel .ft .bl {
	width:8px;
	height:26px;
	bottom:0;
	left:0;
	background:url(<%=request.getContextPath()%>/hebAssets/images/xp-bl.gif) no-repeat;
	position:absolute;
}
#RNAPanel.yui-panel .ft .br {
	width:8px;
	height:26px;
	bottom:0;
	right:0;
	background:url(<%=request.getContextPath()%>/hebAssets/images/xp-br.gif) no-repeat;
	position:absolute;
}
 .zIndexFireFox{
	z-index:200;
}
.zIndexIE{
	z-index:200;
}
.zIndexNewIE{
	z-index:0;
}
.screenName-Search{
	position:relative;
    font-style:italic;
	width:auto;
	margin-left:-740px;
	height:2px;
	z-index:6;
	top: 10px;
}
#errors{
	position: relative;
	min-width: 0;
	margin-top:15px\0/IE8+9;
}
.screenName{
	position:absolute;
    font-style:italic;
	width:auto;
	height:2px;
	z-index:6;
	left: 95px;
	top: 10px;
}#searchResults tr td {
	border-right:1px solid #F2EDEB;/*#F5EFEA;*/
}
#searchResults tr td tr td {
	border:none;
}
#results tr td{
	border-right:1px solid #F5EFEA;/*#F5EFEA;*/
}

#resultsButtons {
	height:100px\0/IE8+9;
}

#f1 legend,#f5 legend , #f2 legend, #selectedvendorDetailsDiv legend,#vendorDetailsFieldSet legend{
	color:#2A5685;
}.setColorGrey{
	background-color: #e5e5e5;
	border: solid 1px #8f8f8f;
}
button:disabled {
    color:gray !important;
}