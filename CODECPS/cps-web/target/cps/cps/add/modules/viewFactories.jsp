<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cps" tagdir="/WEB-INF/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.heb.operations.cps.util.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.heb.operations.cps.model.*" %>
<%@ page import="com.heb.operations.cps.vo.FactoryVO" %>
<%@ page import="java.util.List" %>
<%	
	ArrayList<String> factoryLst=new ArrayList<String>();
	String temp="";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:url value="${request.getContextPath()}/yui/yahoo-dom-event/yahoo-dom-event.js" var="yahooDom" />
<script type="text/javascript" src="${yahooDom}"></script>	
<style type="text/css">
	.yui-skin-sam .yui-dt-col-address pre { font-family:arial;font-size:100%; } 
	.origin { display: block; background: #795089; padding: 1ex; color: #fff; text-align: right; margin-bottom: 1em; }
	#messageTable thead { display: none; }
	#messageTable { margin-top: 1em; }
	#paginated { text-align: center; }
	#paginated table { margin-left:auto; margin-right:auto; }
	#paginated, #paginated .yui-dt-loading { text-align: center; background-color: transparent; }
	.yui-skin-sam .yui-dt-checkbox {font-family:arial; font-size:5px;}
	
</style>
<meta http-equiv="x-ua-compatible" content="IE=7;charset=UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<c:url value="/dwr/engine.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>

<c:url value="${request.getContextPath()}/hebAssets/common.js" var="styleURL"/>
<script src="${styleURL}" type="text/javascript"></script>

<c:url value="/dwr/util.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>

<c:url value="/dwr/interface/AddCandidateTemp.js" var="styleURL" />
<script type='text/javascript' src="${styleURL}"> </script>
<title>Import Factory</title>
</head>
<body class="yui-skin-sam" onload="loadTable();">
	<table width="100%" >
		<tr>
			<td width="2%"></td>
			<td width="96%" align="center">
				<div style="display:none" id="content2">
				<table style="width: 94%; height: 88%; background-color: #FFFFFF;" id="test">
					<thead>
						<tr>
							<th></th>
							<th>Factory ID</th>
							<th>Factory Name</th>
							<th>Country</th>
							<th>City</th>
						</tr>
					</thead>
					<tbody>
					<%
						AddNewCandidate addNewCandidate = (AddNewCandidate)request.getSession().getAttribute("AddNewCandidate");
						Set<String> vendorFactories = addNewCandidate.getVendorVO().getImportVO().getFactoryIDs();
						List<FactoryVO> factories = (List<FactoryVO>)request.getAttribute(CPSConstants.FACTORY_LIST);
					%>
						<%--<bean:define id="vendorFactories" name="CPSAddCandidate" --%>
						  <%--property="vendorVO.importVO.factoryIDs" type="java.util.Set"></bean:define>--%>
						<%--<logic:iterate id="factory" name="<%=CPSConstants.FACTORY_LIST %>" type="com.heb.operations.cps.vo.FactoryVO">--%>
					<%
						for (FactoryVO factory: factories) { %>
							<tr>
								<td>
									
									<% 
									temp="";%>
									<%
									if(vendorFactories.contains(factory.getFactoryId())) 
									{
										temp+=factory.getFactoryId()+"__"+"Y"+"__"+factory.getFactoryName()+"__"+factory.getCountry()+"__"+factory.getCity();
										factoryLst.add(temp);
										%>	
									<input id="<%=factory.getFactoryId()%>" name="factoryList" type="checkbox" value="<%=factory.getFactoryId()%>" checked> 
									<%} else {
									temp+=factory.getFactoryId()+"__"+"N"+"__"+factory.getFactoryName()+"__"+factory.getCountry()+"__"+factory.getCity();
									factoryLst.add(temp);
									%>
									<input id="<%=factory.getFactoryId()%>" name="factoryList"  type="checkbox" value="<%=factory.getFactoryId()%>"> 
									<%}%>
								</td>
								<td><%=factory.getFactoryId() %></td>
								<td id="name_<%=factory.getFactoryId()%>"><%=factory.getFactoryName() %></td>
								<td id="country_<%=factory.getFactoryId()%>"><%=factory.getCountry() %></td>
								<td id="city_<%=factory.getFactoryId()%>"><%=factory.getCity() %></td>
							</tr>
					<%}%>
						<%--</logic:iterate>--%>
					</tbody>
				</table>
				</div>
			</td>
			<td width="2%"></td>
		</tr>
		<tr>
			<td colspan =3 width="100%">
			<div id="markup" style="font-family:arial; font-size:10px;"></div>
			</td>
		</tr>
		<tr>
			<td colspan =3 align="center">
			<div id="paginate" style="font-family:arial; font-size:10px;"></div>
			</td>
		</tr>
		<tr id="buttonRow" style="display:none;">
			<td width="50%" align="right">
				<button id="factorySave" onclick="saveFactoryDetails();">Save</button>
			</td>
			<td width="50%" align="left"><button id="factoryCancel" onclick="toClose();">Cancel</button></td>
		</tr>
	</table>
	<input type="hidden" name="selectedVendorId" id="selectedVendorId" value="${selectedVendorId}"/>
	<input type="hidden" name="selectedItemId" id="selectedItemId" value="${selectedItemId}"/>
	<input type="hidden" name="editVendorBtnEnable" id="editVendorBtnEnable" value="${editVendorBtnEnable}"/>
	<input type="hidden" name="list" id="list" value=""/>
	<c:url value="/yui/" var="yuiURL"/>
	
	<c:url value="${request.getContextPath()}/yui/yuiloader/yuiloader-min.js" var="loaderURL"/> 
	<script type="text/javascript" src="${loaderURL}"></script>  	
	<script type="text/javascript">

	var warehouseList = "\nTo the following Warehouses:\n";
    <c:forEach items="${AddNewCandidate.wareHouseList}" var="auth" varStatus="loop" >
	   <c:if test="${auth.check eq true}">
		warehouseList += "<c:out value="${auth.whareHouseid}"></c:out>";
		warehouseList += " : ";
		warehouseList += "<c:out value="${auth.whareHouseName}"></c:out>";
		warehouseList += "\n";
		</c:if>
    </c:forEach>
	
	Array.prototype.inArray = function (value)
	{
	// Returns true if the passed value is found in the
	// array. Returns false if it is not.
		var i;
		for (i=0; i < this.length; i++) 
		{
		 if (this[i] == value) 
		 {
		 return true;
		 }
		}
		return false;
	};
	var checkList =new Array();
	function saveFactoryDetails(evt){
			if(document.getElementById('factorySave')){
		    	document.getElementById('factorySave').disabled=true;
			}
		    document.getElementById('factoryCancel').disabled=true;
		 var factories = document.getElementsByName("factoryList");
		 var list = new Array();
		 list=checkList;
		 
		 var i = 0;
		 if(list.length==0)
		 {
			 for(l = 0; l <factories.length; l++){
				if(factories[l].checked){
					list[i] = factories[l].id;
					i++;
				}
			 }
		 }	 
		 i=list.length;
		 if (i > 0){
		 
		    var msg = "You are about to import the following factories:\n";
		    for(j = 0; j < list.length; j++){
		    	msg = msg + list[j]+" : " +document.getElementById("name_"+list[j]).innerHTML + "\n";
		    }
		    
		    msg += warehouseList;
		    var ok = confirm(msg);
		    if(ok){
			    if(null != document.getElementById('list') && document.getElementById('list') != undefined){
			    	document.getElementById('list').value = list;
			    }
			    AddCandidateTemp.saveFactoryDetails(list, getDWRCallbackMethod(factoryCallBack));
		    }else{
		    	if(document.getElementById('factorySave')){
			    	document.getElementById('factorySave').disabled=false;
		    	}
			    document.getElementById('factoryCancel').disabled=false;
		    }
		 }else{
		    var ok = confirm("There are no factories to import. Any existing saved values will be lost");
		    if(ok){
		 	AddCandidateTemp.saveFactoryDetails(list, getDWRCallbackMethod(factoryCallBack));
		    }else{
			if(document.getElementById('factorySave')){
			    document.getElementById('factorySave').disabled=false;
			}
			document.getElementById('factoryCancel').disabled=false;			 
		     }
		 }
	}

	function factoryCallBack(){
		var lstDom = document.getElementById("list");
		
		if(null != lstDom && lstDom != undefined){
			window.parent.execScript('setFacilitiesInVendorDOM("'+lstDom.value+'");');
		}
		
		//window.parent.execScript("f2();");
		window.parent.execScript('closefactory();', "JavaScript");
	}

	function toClose(){	
		//window.parent.execScript("f2();");
		window.parent.execScript('closefactory();', "JavaScript");
	}
	
	function makeTable() {
	
		this.checkBoxFormatter = function(el, oRecord, oColumn, oData) {			 
			var bChecked = oData.split("CHECKED");
			bChecked = (bChecked[1]) ? " checked=\"checked\"" : "";			
			el.innerHTML = "<input type=\"checkbox\"" + bChecked +
				" class=\"yui-dt-checkbox\" />";
		    }
		
		var sortFactoryId = function(a, b, desc) {
            // Deal with empty values   
            if(!YAHOO.lang.isValue(a)) {
                return (!YAHOO.lang.isValue(b)) ? 0 : 1;
            }
            else if(!YAHOO.lang.isValue(b)) {
                return -1;
            }

            // First compare by state
            var comp = YAHOO.util.Sort.compare;
            var compState = comp(a.getData("factoryId"), b.getData("factoryId"), desc);

            // If states are equal, then compare by areacode
            return (compState !== 0) ? compState : comp(a.getData("factoryName"), b.getData("factoryName"), desc);
        };
		
		var sortFactoryName = function(a, b, desc) {
            // Deal with empty values   
            if(!YAHOO.lang.isValue(a)) {
                return (!YAHOO.lang.isValue(b)) ? 0 : 1;
            }
            else if(!YAHOO.lang.isValue(b)) {
                return -1;
            }

            // First compare by state
            var comp = YAHOO.util.Sort.compare;
            var compState = comp(a.getData("factoryName"), b.getData("factoryName"), desc);

            // If states are equal, then compare by areacode
            return (compState !== 0) ? compState : comp(a.getData("factoryId"), b.getData("factoryId"), desc);
        };
		
		var sortCountry = function(a, b, desc) {
            // Deal with empty values   
            if(!YAHOO.lang.isValue(a)) {
                return (!YAHOO.lang.isValue(b)) ? 0 : 1;
            }
            else if(!YAHOO.lang.isValue(b)) {
                return -1;
            }

            // First compare by state
            var comp = YAHOO.util.Sort.compare;
            var compState = comp(a.getData("country"), b.getData("country"), desc);

            // If states are equal, then compare by areacode
            return (compState !== 0) ? compState : comp(a.getData("factoryId"), b.getData("factoryId"), desc);
        };
		
		var sortCity = function(a, b, desc) {
            // Deal with empty values   
            if(!YAHOO.lang.isValue(a)) {
                return (!YAHOO.lang.isValue(b)) ? 0 : 1;
            }
            else if(!YAHOO.lang.isValue(b)) {
                return -1;
            }

            // First compare by state
            var comp = YAHOO.util.Sort.compare;
            var compState = comp(a.getData("city"), b.getData("city"), desc);

            // If states are equal, then compare by areacode
            return (compState !== 0) ? compState : comp(a.getData("factoryId"), b.getData("factoryId"), desc);
        };
		
		
		
	
			
	       var myColumnDefs = [
             {key:"checkBox",label:" ",formatter:this.checkBoxFormatter,sortable:false},
             {key:"factoryIds",label:"Factory ID",sortable:true,sortOptions:{sortFunction:sortFactoryId},
               children: [{key:"factoryId", label:"<input type='text' id='idF'\/>",sortable:false, resizeable:true}]},
             {key:"factoryNames",label:"Factory Name", sortable:true,sortOptions:{sortFunction:sortFactoryName},
                children: [{key:"factoryName", label:"<input type='text' id='nameF' \/>",sortable:false, resizeable:true}]},
             {key:"countrys",label:"Country",sortable:true,sortOptions:{sortFunction:sortCountry},
                children: [{key:"country", label:"<input type='text' id='countryF'\/>",sortable:false, resizeable:true}]},
             {key:"citys",label:"City",sortable:true,sortOptions:{sortFunction:sortCity},
              children: [{key:"city", label:"<input type='text' id='cityF' \/> &nbsp; <input type='button' id='clearFac' value='Clear'\/>",sortable:false, resizeable:true}]}
         ];
	
		
		var myDataSource = new YAHOO.util.DataSource(YAHOO.util.Dom.get("test"),
		{
			responseType : YAHOO.util.DataSource.TYPE_HTMLTABLE,
			responseSchema : {
				fields: [{key:"checkBox"},
							{key:"factoryId", parser:"number"},
							{key:"factoryName"},
							{key:"country"},
							{key:"city"} 
					]
			},
			doBeforeCallback : function (req,raw,res,cb) {
				// This is the filter function			
				var data     = res.results || [],
					filtered = [],
					i,l;
				
				//var factories = document.getElementsByName("factoryList");				
				var i = 0;				
				if (req) {		

					//list data to get what is check
					window.parent.execScript('showProgress();', "JavaScript");
					var list = new Array();					
					list=checkList;
					if(list.length==0)
					{
						 var factories = document.getElementsByName("factoryList");						 						 						 
						 var i = 0;						
							 for(l = 0; l <factories.length; l++)
							 {
								if(factories[l].checked)
								{
									list[i] = factories[l].id;
									i++;
								}
							 }
						 	 
					}
					var temp="";										
					for (i = 0, l = data.length; i < l; ++i) {
						temp="";							
						if(list.inArray(data[i].factoryId))
						{								
							data[i].checkBox="<input id="+ data[i].factoryId +" type='checkbox' CHECKED name='factoryList' class='yui-dt-checkbox' />";							
						}
						else
						{
							data[i].checkBox="<input id="+ data[i].factoryId +" type='checkbox'  name='factoryList' class='yui-dt-checkbox' />";
						}
						temp=data[i].factoryId+"__"+"YN"+"__"+data[i].factoryName.toUpperCase()+"__"+data[i].country.toUpperCase()+"__"+data[i].city.toUpperCase();						
						var pattern = new RegExp(req);			
						if(pattern.test(temp))
						{							
							filtered.push(data[i]);			
						}						
					}
					
					res.results = filtered;					
										
				}				
				return res;
			}
		});					    		
		var oConfigs = {
			paginator: new YAHOO.widget.Paginator({
			    rowsPerPage: 10,
			    template:"{PreviousPageLink} {NextPageLink}",
			    containers:paginate
			})
		};

		    var myDataTable = new YAHOO.widget.DataTable("markup", myColumnDefs, myDataSource, oConfigs);
	        
	        YAHOO.util.Dom.get("test").style.display = 'none';
			
			filterTimeout = null;
			updateFilter  = function () {
        // Reset timeout
				filterTimeout = null;
        
        //patent to filter
		var pattent=getPattent();			

        // Get filtered data
        myDataSource.sendRequest(pattent,{
            success : myDataTable.onDataReturnInitializeTable,
            failure : myDataTable.onDataReturnInitializeTable,
            scope   : myDataTable,
            argument: pattent	
        });
    };
	 myDataTable.subscribe("checkboxClickEvent", function(oArgs){ 
				
				var newArr = document.getElementsByName("factoryList");					
				var	newArr2=new Array(); 			
				for(i=0;i<newArr.length;i++)
				{
					if(newArr[i].checked)
					{						
						newArr2.push(newArr[i].id);
					}
				}
				
				var isCheck =false;
	            var elCheckbox = oArgs.target; 
	            var oRecord = this.getRecord(elCheckbox); 
	            var chkBoxTxt = oRecord.getData("checkBox");
	            var tmp = chkBoxTxt.split("id=")[1];
	            var chkBoxID = tmp.split(" ")[0];							
	            var myChkBox = YAHOO.util.Dom.get(chkBoxID);
	            myChkBox.checked = elCheckbox.checked;
				//HoangVT - fixed[QC: 1387]: Import section - Factory selection is not visible when we move back and forth
				if(elCheckbox.checked){
					oRecord.setData("checkBox","<input id="+ chkBoxID +" type=checkbox CHECKED name=factoryList class=yui-dt-checkbox />"); 
					isCheck=true;
				}
				else
					oRecord.setData("checkBox","<input id="+ chkBoxID +" type=checkbox name=factoryList class=yui-dt-checkbox />"); 
				
				if(!isCheck)				
				{
					if(newArr2.inArray(chkBoxID))
					{						
						removeByElement(newArr2,chkBoxID);
					}
				}
				else
					{						
						if(isCheck && !newArr2.inArray(chkBoxID))
						{
							newArr2.push(chkBoxID);
						}
					}					
				checkList=newArr2;
	        }); 
				
	 myDataTable.doBeforeLoadData = function( sRequest , oResponse ) 
	 {
	  window.parent.execScript('hideProgress();', "JavaScript");
	  return true;
	 };				
	YAHOO.util.Event.on('nameF','keyup',function (e) {			
        clearTimeout(filterTimeout);
        setTimeout(updateFilter,600);
    });
	YAHOO.util.Event.on('idF','keyup',function (e) {			
        clearTimeout(filterTimeout);
        setTimeout(updateFilter,600);
    });
	YAHOO.util.Event.on('countryF','keyup',function (e) {		
        clearTimeout(filterTimeout);
        setTimeout(updateFilter,600);
    });
	YAHOO.util.Event.on('cityF','keyup',function (e) {	
        clearTimeout(filterTimeout);
        setTimeout(updateFilter,600);
    });
	YAHOO.util.Event.on('clearFac','click',function (e) {	
		document.getElementById("idF").value='';
		document.getElementById("nameF").value='';
		var countryF=document.getElementById("countryF").value='';
		var cityF=document.getElementById("cityF").value='';
		
        clearTimeout(filterTimeout);
        setTimeout(updateFilter,600);
    });	
	
	        <c:if test="${AddNewCandidate.vendorVO.newDataSw eq 'Y'.charAt(0)}">
	        	document.getElementById('buttonRow').style.display='';
	        </c:if>

	     /* return {
	            oDS: myDataSource,
	            oDT: myDataTable
	       };*/

	    
	}
	function loadTable(){
	    var tableLoader = new YAHOO.util.YUILoader({ 
	        base: "${yuiURL}", 
	        require: ["paginator","datatable","datasource", "element"], 
	        loadOptional: true, 
	        combine: false, 
	        filter: "MIN", 
	        allowRollup: true, 
	        onSuccess: function() {   
			
				makeTable();			
	        } 
	    }); 
	    tableLoader.insert();
		var disabled = false;
		if(document.getElementById('editVendorBtnEnable')==null) {
			disabled = true;
		} 
		document.getElementById('factorySave').disabled = disabled;
		document.getElementById('factoryCancel').disabled = disabled;
	}		
	function getPattent()
	{
		var idF=document.getElementById("idF");
		var nameF=document.getElementById("nameF");
		var countryF=document.getElementById("countryF");
		var cityF=document.getElementById("cityF");
		
		var partent="";
		if(idF.value.length >0) 
			{
				partent+=idF.value+"[0-9\\s]*";
			}
		else
			{
				partent+="\.*";
			}
		partent+="__[a-zA-Z0-9\\s]*";	
		if(nameF.value.length >0) 
			{
				partent+="__"+"\.*"+nameF.value.toUpperCase()+"\.*";
			}	
		else
			{
				partent+="__\.*";
			}
		if(countryF.value.length >0) 
			{
				partent+="__"+"\.*"+countryF.value.toUpperCase()+"\.*";
			}		
		else
			{
				partent+="__\.*";
			}
		if(cityF.value.length >0) 
			{
				partent+="__"+"\.*"+cityF.value.toUpperCase()+"\.*";
			}		
		else
			{
				partent+="__"+"\.*";
			}			
			return partent;
	}
	window.parent.execScript('hideProgress();', "JavaScript");
	
	function removeByElement(arrayName,arrayElement)
	 {
		  for(var i=0; i<arrayName.length;i++ )
		   { 
			  if(arrayName[i]==arrayElement)
			  arrayName.splice(i,1); 
		   } 
	 }
	</script>

	
</body>
</html>