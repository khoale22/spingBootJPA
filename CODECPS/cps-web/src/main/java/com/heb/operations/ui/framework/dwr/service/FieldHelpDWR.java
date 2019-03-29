package com.heb.operations.ui.framework.dwr.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import com.heb.operations.cps.model.HebBaseInfo;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.ui.framework.exception.CPSWebException;
import com.heb.operations.ui.framework.servlet.CPSApplicationContext;

public class FieldHelpDWR extends AbstractSpringDWR {

	@Override
	protected HebBaseInfo getForm() {
		return null;
	}
	

	public String getHelpForId(String fieldId) throws CPSWebException{

		String value = CPSApplicationContext.getInstance().getHelp().getProperty(fieldId);
		
		return value;
	}
	
	public Map<String, Object> validateDate(String dte, String fieldName){
		DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		Map<String, Object> map = new HashMap<String, Object>();
		if(CPSHelper.isNotEmpty(dte)){
			try {
				dateFormat.parse(dte);
			} catch (ParseException e) {
				map.put("success", Boolean.FALSE);
				map.put("message", fieldName + " can have values only in the format mm/dd/yyyy");
				return map;
			}
		}
		map.put("success", Boolean.TRUE);
		return map;
	}


}
