package com.heb.operations.ui.framework.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;



public class PropertyManager {
	
    	private static Logger LOG = Logger.getLogger(PropertyManager.class);
	
	private Properties tableProperties = new Properties();
	
	private static PropertyManager manager = new PropertyManager();
	
	private PropertyManager(){
		init();
	}
	
	private void init(){
		InputStream is = this.getClass().getResourceAsStream(
		"/CPSTableNames.properties");
		try {
			tableProperties.load(is);
		} catch (IOException e) {
		    LOG.fatal("Exception:-", e);
			throw new RuntimeException("Error in loading CPSTableNames.properties..",e);
		} finally{
			try{
				is.close();
			}catch(IOException io){
			    LOG.error("Unable to close properties file.", io);
			}
		}
	}
	
	public static synchronized PropertyManager getInstance(){
		return manager;
	}

	public Properties getTableProperties() {
		return tableProperties;
	}

	public void setTableProperties(Properties tableProperties) {
		this.tableProperties = tableProperties;
	}
 
}
