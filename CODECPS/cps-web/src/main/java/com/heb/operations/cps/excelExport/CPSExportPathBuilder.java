package com.heb.operations.cps.excelExport;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

public class CPSExportPathBuilder {
	/** The Constant LOG. */
	private static final Logger LOG = Logger.getLogger(CPSExportPathBuilder.class);
	public static final String PATH_SEPERATOR = System.getProperty("file.separator");
	public static final String EXPORT_DIR = "Export";

	public String getExportPath(HttpServletRequest request) {
		String realPathStr;
		StringBuffer realPathStrBuffer = new StringBuffer();
		try {
			realPathStr = request.getSession().getServletContext().getRealPath("");
			realPathStrBuffer.append(realPathStr).append(PATH_SEPERATOR).append(EXPORT_DIR).append(PATH_SEPERATOR);
		} catch (Exception exception) {
			LOG.error("Exception", exception);
			realPathStrBuffer.append("");
		}
		return realPathStrBuffer.toString();
	}

	public boolean checkFolder(HttpServletRequest request) {
		boolean ckBatchFolder = false;
		try {
			String realPathStr = request.getSession().getServletContext().getRealPath("");
			File file = new File(realPathStr.concat(PATH_SEPERATOR).concat(EXPORT_DIR));
			ckBatchFolder = file.exists();
		} catch (Exception exception) {
			LOG.error("Exception:-", exception);
		}
		return ckBatchFolder;
	}

	public boolean createExcelFolder(HttpServletRequest request) {
		boolean mkBatchFolder = false;
		try {
			String realPathStr = request.getSession().getServletContext().getRealPath("");
			File batchFileStr = new File(realPathStr.concat(PATH_SEPERATOR).concat(EXPORT_DIR));
			mkBatchFolder = batchFileStr.mkdir();
		} catch (Exception exception) {
			LOG.error("Exception:-", exception);
		}
		return mkBatchFolder;
	}

	public String excelPath(HttpServletRequest request) {
		if (!checkFolder(request)) {
			createExcelFolder(request);
		}
		return getExportPath(request);
	}

}
