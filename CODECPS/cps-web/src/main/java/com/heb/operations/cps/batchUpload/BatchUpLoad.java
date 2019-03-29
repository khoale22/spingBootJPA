package com.heb.operations.cps.batchUpload;

import java.io.IOException;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.heb.jaf.security.UserInfo;
import com.heb.operations.cps.util.CPSConstants;
import org.springframework.web.multipart.MultipartFile;


public class BatchUpLoad {
	BatchDirectoryCreator batchDirectoryCreator= new BatchDirectoryCreator();
	public static final String SUCCESS = "Success";
	public static final String LESS_ROW_COUNT = "LessRowCount";
	/**
	 * Main function to execute the Batch function
	 * @param formFile
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public String batchExecute(MultipartFile formFile, HttpServletRequest request,
							   HttpServletResponse response, String userRole, UserInfo userInfo) throws Exception {
		
		//completely misleading.  This just creates the directory if necessary
		batchExcelUpload(request);
		
		//declarations
		String batchFileName = formFile.getOriginalFilename();
		String batchFilePath = getFilePath(request);
		String returnStatus = "";
		byte[] fileData = formFile.getBytes();
		
		//put the file on the filesystem
		batchDirectoryCreator.insertFile(batchFileName,
				batchFilePath, formFile);
		
		//count how many readable rows
		String rowCount = batchRowCount(fileData);
		
		
	    if(SUCCESS.equalsIgnoreCase(rowCount)){
	    	//if there is a valid number of rows, read and process each one
	    	returnStatus = batchExcelReader(fileData,batchFileName,userRole, userInfo);
			 	}else {
			if(LESS_ROW_COUNT.equalsIgnoreCase(rowCount))
				returnStatus = LESS_ROW_COUNT;
			else
				returnStatus = rowCount;
		}
		
		batchDirectoryCreator.deleteFile(batchFileName,
				batchFilePath, formFile);
		return returnStatus;
	}
   /**
	 * To check whether the batch folder is exists in the server. if(use that
	 * folder otherwise create a new folder)
	 * 
	 * @param request
	 */
	public void batchExcelUpload(HttpServletRequest request) {
		if (!batchDirectoryCreator.checkFolder(request)) {
			batchDirectoryCreator.createBatchFolder(request);
		}
	}
	/**
	 * Taking the uploading file path from the server
	 * @param request
	 * @return
	 */
	public String getFilePath(HttpServletRequest request){
		return batchDirectoryCreator.getFilePath(request);
	}
	/**
	 * Validate whether the Excel file is in correct format or not
	 * @param formFile
	 * @return
	 */
	public boolean validateBatchFile(MultipartFile formFile){
		boolean retunValue = true;
		if (formFile.getSize() == 0) {
			retunValue = false;
		} else {
			String batchFileName = formFile.getOriginalFilename();
			if (batchFileName == null || "".equals(batchFileName)) {
				retunValue = false;
			} else {
				int fileIndex = batchFileName.indexOf('.');
				if (fileIndex == -1) {
					retunValue = false;
				}
			}
		}
		return retunValue;
	}
	/**
	 * To read the contents of the excel file
	 * @param fileData
	 * @param batchFileName
	 */
	public String batchExcelReader(byte[] fileData,String batchFileName,String userRole, UserInfo userInfo){
		
		//declarations
		BatchExcelReader batchExcelReader = new BatchExcelReader();
		boolean insertFlag = false;
		String returnValue = CPSConstants.EMPTY_STRING;
		int numberOfInValidRows = 0;
		
		//pass data to the reader
		returnValue = batchExcelReader.excelReader(fileData, insertFlag,batchFileName,userRole, userInfo);
		
		//returns a colon separated list of ids
		StringTokenizer idList = new StringTokenizer(returnValue, ":");
		if (idList.hasMoreElements()) {
			//ignore the first?
			idList.nextToken();
		}
		if (idList.hasMoreElements()) { // to take the invalid row numbers
			//next element is a pipe-separated list of stuff
			String rows = idList.nextToken().trim();
			StringTokenizer rowsList = new StringTokenizer(rows, "|");
			if (rowsList.hasMoreElements()) {
				//first element in the pipe-separated thing is the number of bad rows.
				numberOfInValidRows = Integer.parseInt(rowsList.nextToken()
						.trim());
			}
		}
		if (numberOfInValidRows < 1) {
			returnValue = CPSConstants.EMPTY_STRING;
			insertFlag = true;
			
			//so far so good, now send it off somewhere else
			returnValue = batchExcelReader.excelReader(fileData, insertFlag,batchFileName,userRole, userInfo);
		}

		return returnValue;
	}
	public void batchErrorMessage(String errorMessage,String sessionId,HttpServletRequest request) throws IOException{
		String batchFilePath = getFilePath(request);
		batchDirectoryCreator.batchErrorMessage(errorMessage, sessionId, batchFilePath);
	}
	public String batchRowCount(byte[] fileData) throws Exception{
     	BatchRowCountValidate batchRowCountValidate = new BatchRowCountValidate();
     	return batchRowCountValidate.batchRowCount(fileData);
	}
	public void batchErrorSessionClearing(String sessionId,HttpServletRequest request)throws IOException{
		String batchFilePath = getFilePath(request);
		batchDirectoryCreator.batchErrorSessionClearing(sessionId, batchFilePath);
	}
}
