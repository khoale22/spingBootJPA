package com.heb.operations.ui.framework.exception;


public class CPSWebException extends Exception {
	
	public CPSWebException(){
		super();
	}
	
	public CPSWebException(String message){
		super(message);
	}
	
	public CPSWebException(String message, Throwable throwable){
		super(message, throwable);
	}
	
	public CPSWebException(Throwable throwable){
		super(throwable);
	}
	
}
