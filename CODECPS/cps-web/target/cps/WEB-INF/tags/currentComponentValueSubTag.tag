<%@attribute  name="uniqueId" required="true" rtexprvalue="true" %>
<%@attribute  name="strutsHiddenElmProperty" required="true" rtexprvalue="true" %>


<%

/*

	This tag is meant to be embedded in other tags, Especially autocomplete 2 and 3.
	
	You give it a 'property' of the current struts form and it looks to
	see if that property has been set.
	
	If it has, it uses a cache maintained by the jsonSearch.do struts
	action to look up the user-friendly 'name' of that property so you
	can pre=populate your component with the current value.
	
	In other words, for example, lets say you set the BDM in the 
	autocomplete3 component, leave the page and come back.
	
	The struts form knows that bdm with the bdm_cd of '01' is selected.
	This tag goes out and finds that '01' is Stuart Sheffer and 
	puts 'Stuart Sheffer' in the requestScope under 'currentComponentText' 
	so you can access it with jstl tags like:
		
		<c:out value="requestScope.currentComponentText" ... etc.

*/




//sorry, there has to be a better way to do this, but I don't know what it is.
//see what the 'property' attribute is, and programmatically 
//dig into the struts form to try to get that property

//split the property on '.'
String[] splits = strutsHiddenElmProperty.split("\\.");

//we save the current form in the session under 'CPSForm'
Object currValue = jspContext.findAttribute("CPSForm");

//dig down into the object tree to get the property
for(int i = 0 ; ((i < splits.length) && (currValue != null)) ; i++){
	currValue = jspContext.getELContext().getELResolver().getValue(
				jspContext.getELContext(),
				currValue,
				splits[i]
			);	
}


String currName = null;

//we only store the 'id' in the struts form.  We need to get the user-friendly
//'name' from that id.  We could look it up, or we could cache it.
//the 'jsonSearch.do' struts action keeps a map of all search results'
//id->name mapping so we can get it from that cache, which is stored in the session 
//as well
if(currValue != null){
	request.setAttribute("currentComponentId", currValue);	
	//get the cache out of the session
	java.util.Map resultsMap = (java.util.Map)session.getAttribute("JSON_SEARCH_RESULTS_MAP");
	if(resultsMap != null){
		//the cache stores search results based on the 'uniqueId' of the tag 
		//doing the query
		java.util.Map results = (java.util.Map)resultsMap.get(uniqueId);
		//if the id in question was ever returned as a search result, 
		//it will be in that cache
		if(results != null){
			currName = (String)results.get(currValue);
		}
	}
}
else{
	request.removeAttribute("currentComponentId");
}

//if we found the name for the id, put it in the requestScope so we can 
//access it later on using jstl tags
if(currName != null){
	request.setAttribute("currentComponentText", currName);	
}
//we need to clear it so multiple instances of the same tag don't get each other's data
else{
	request.removeAttribute("currentComponentText");
}


	
%>