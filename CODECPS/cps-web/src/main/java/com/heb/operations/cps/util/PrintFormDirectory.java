package com.heb.operations.cps.util;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;


public class PrintFormDirectory {
    	private static Logger LOG = Logger.getLogger(CPSWebUtil.class);
	public static final String PATH_SEPERATOR = System
			.getProperty("file.separator");
	public static final String PRINT_FORM_DIR = "PrintForm";
	

	public String getFilePath(HttpServletRequest request) {
		String realPathStr;
		StringBuffer realPathStrBuffer = new StringBuffer();
		try {
			realPathStr = request.getSession().getServletContext().getRealPath(
					"");
			realPathStrBuffer.append(realPathStr).append(
					System.getProperty("file.separator"))
					.append(PRINT_FORM_DIR);
		} catch (Exception exception) {
		    LOG.fatal("Exceptio.:-", exception);
			realPathStrBuffer.append("");
		}
		return realPathStrBuffer.toString();

	}

	/**
	 * To Check whether the folder is exists or not
	 * 
	 * @param request
	 * @return
	 */
	public boolean checkFolder(HttpServletRequest request) {
		boolean ckBatchFolder = false;
		try {
			String realPathStr = request.getSession().getServletContext()
					.getRealPath("");
			File file = new File(realPathStr.concat(PATH_SEPERATOR).concat(
					PRINT_FORM_DIR));
			ckBatchFolder = file.exists();
		} catch (Exception exception) {
		    LOG.fatal("Exceptio.:-", exception);
		}
		return ckBatchFolder;
	}

	/**
	 * For creating a Batch uploading folder in the appServer
	 * 
	 * @param request
	 * @return
	 */
	public boolean createPrintFormFolder(HttpServletRequest request) {
		boolean mkBatchFolder = false;
		try {
			String realPathStr = request.getSession().getServletContext()
					.getRealPath("");
			File printFormFile = new File(realPathStr.concat(PATH_SEPERATOR)
					.concat(PRINT_FORM_DIR));
			mkBatchFolder = printFormFile.mkdir();
		} catch (Exception exception) {
		    LOG.fatal("Exceptio.:-", exception);
		}
		return mkBatchFolder;
	}

	public void printForm(HttpServletRequest request) {
		if (!checkFolder(request)) {
			createPrintFormFolder(request);
		}

	}

}
