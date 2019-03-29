package com.heb.operations.cps.batchUpload;

import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.heb.operations.cps.util.AntiVirus;
import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.util.ClamAVAntivirus;
import org.springframework.web.multipart.MultipartFile;

public class BatchDirectoryCreator {
	public static final String PATH_SEPERATOR = System.getProperty("file.separator");
	public static final String BATCH_DIR = "Batch";
	/** The Constant LOG. */
	private static final Logger LOG = Logger.getLogger(BatchDirectoryCreator.class);

	/**
	 * For creating a Batch uploading folder in the appServer.
	 * 
	 * @param request
	 * @return boolean
	 */
	public boolean createBatchFolder(HttpServletRequest request) {
		boolean mkBatchFolder = false;
		try {
			String realPathStr = request.getSession().getServletContext().getRealPath("");
			File batchFileStr = new File(realPathStr.concat(PATH_SEPERATOR).concat(BATCH_DIR));
			mkBatchFolder = batchFileStr.mkdir();
		} catch (Exception exception) {
			LOG.error("Exception", exception);
		}
		return mkBatchFolder;
	}

	/**
	 * To Check whether the folder is exists or not.
	 * 
	 * @param request
	 * @return boolean
	 */
	public boolean checkFolder(HttpServletRequest request) {
		boolean ckBatchFolder = false;
		try {
			String realPathStr = request.getSession().getServletContext().getRealPath("");
			File file = new File(realPathStr.concat(PATH_SEPERATOR).concat(BATCH_DIR));
			ckBatchFolder = file.exists();
		} catch (Exception exception) {
			LOG.error("Exception", exception);
		}
		return ckBatchFolder;
	}

	/**
	 * To find the realPath of the AppServer.
	 * 
	 * @param request
	 * @return String
	 */
	public String getFilePath(final HttpServletRequest request) {
		String realPathStr;
		StringBuffer realPathStrBuffer = new StringBuffer();
		try {
			realPathStr = request.getSession().getServletContext().getRealPath("");
			realPathStrBuffer.append(realPathStr).append(PATH_SEPERATOR).append(BATCH_DIR);
		} catch (Exception exception) {
			LOG.error("Exception", exception);
			realPathStrBuffer.append("");
		}
		return realPathStrBuffer.toString();
	}

	/**
	 * Uploading the file into the AppServer Folder location.
	 * 
	 * @param batchFileName
	 * @param batchFilePath
	 * @param formFile
	 * @return File
	 * @throws Exception
	 */
	public File insertFile(String batchFileName, String batchFilePath, MultipartFile formFile) throws Exception {
		File fileToCreate = new File(batchFilePath, batchFileName);
		ByteArrayInputStream byteArrayIS = null;

		if (!"".equals(batchFileName)) {
			// Create file
			fileToCreate = new File(batchFilePath, batchFileName);
			// If file does not exists create file
			if (!fileToCreate.exists()) {
				FileOutputStream fileOutStream = new FileOutputStream(fileToCreate);
				// NEW CODE STARTS HERE //
				byte[] byteArray = formFile.getBytes();
				fileOutStream.write(byteArray);
				byteArrayIS = new ByteArrayInputStream(byteArray);
				// ENDS HERE
				// fileOutStream.write(formFile.getFileData());
				fileOutStream.flush();
				fileOutStream.close();
			}

			// Check the File for Viruses - If it has Virus Delete the file
			AntiVirus av = new ClamAVAntivirus();

			// Get the Performance Metrics
			long lStartTime = System.currentTimeMillis();
			if (!av.virusCheck(byteArrayIS)) {
				fileToCreate.delete();
				throw new Exception("User Tried to Upload a Virus Infected File");
			}
			// Get the Performance Metrics
			// long lFinishTime = System.currentTimeMillis();
			// long lReturnValue = lFinishTime - lStartTime;
//			LOG.info("Response time in ms: " + (System.currentTimeMillis() - lStartTime));
		}
		return fileToCreate;
	}

	public boolean deleteFile(String batchFileName, String batchFilePath, MultipartFile formFile) throws Exception {
		File fileToPurge = new File(batchFilePath, batchFileName);
		boolean returnValue = false;
		if (!"".equals(batchFileName)) {
			fileToPurge = new File(batchFilePath, batchFileName);
			if (fileToPurge.exists()) {
				returnValue = fileToPurge.delete();
			}
		}
		return returnValue;
	}

	public void batchErrorMessage(String errorMessage, String sessionId, String batchFilePath) throws IOException {
		File fileToCreate = new File(batchFilePath, CPSConstants.ERR_MESS + sessionId + ".doc");
		// delete already existing files in the batchFolder
		File folder = new File(batchFilePath + PATH_SEPERATOR);
		File[] listOfFiles = folder.listFiles();
		for (int i = 0; i < listOfFiles.length; i++) {
			if (listOfFiles[i].isFile()) {
				if (listOfFiles[i].getName().equalsIgnoreCase(CPSConstants.ERR_MESS + sessionId + ".doc")) {
					listOfFiles[i].delete();
				}
			}
		}
		if (!fileToCreate.exists()) {
			Writer output = new BufferedWriter(new FileWriter(fileToCreate));
			try {
				output.write(errorMessage);
			} finally {
				output.close();
			}
		} else {
			fileToCreate.delete();
			Writer output = new BufferedWriter(new FileWriter(fileToCreate));
			try {
				output.write(errorMessage);
			} finally {
				output.close();
			}
		}
	}

	public void batchErrorSessionClearing(String sessionId, String batchFilePath) throws IOException {
		// File fileToCreate = new File(batchFilePath, "ErrorMessage" +
		// sessionId
		// + ".doc");
		// delete already existing files in the batchFolder
		File folder = new File(batchFilePath + PATH_SEPERATOR);
		File[] listOfFiles = folder.listFiles();
		for (int i = 0; i < listOfFiles.length; i++) {
			if (listOfFiles[i].isFile()) {
				if (listOfFiles[i].getName().equalsIgnoreCase(CPSConstants.ERR_MESS + sessionId + ".doc")) {
					listOfFiles[i].delete();
				}
			}
		}
	}
}
