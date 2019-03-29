package com.heb.operations.cps.servlet;

import java.io.File;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;

import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.util.CommonBridge;
import com.heb.operations.cps.util.RemoteFileUtils;
import com.heb.operations.cps.vo.ImageVO;

/**
 * Servlet implementation class AttachmentViewServlet
 */
public class AttachmentViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger
			.getLogger(AttachmentViewServlet.class);
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AttachmentViewServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String storedFileNm = CPSHelper.getTrimmedValue(req.getParameter("storedFileNm"));
//		String storedFileType = CPSHelper.getTrimmedValue(req.getParameter("storedFileType"));
		String uiFileNm = CPSHelper.getTrimmedValue(req.getParameter("uiFileNm"));
		String clipId = CPSHelper.getTrimmedValue(req.getParameter("clipId"));
		resp.setContentType("application/x-download");
		resp.setHeader("Content-Disposition", "attachment; filename=" + uiFileNm);
		resp.setHeader("Cache-Control", "");
		resp.setHeader("Pragma", "");
		if(CPSHelper.isEmpty(clipId)){
		Resource resource = new ClassPathResource(CPSHelper.getProfileActivePath() + "/cps-service-application.properties");
		Properties serviceProps;
		String realFilePath = null;
		try {
			serviceProps = PropertiesLoaderUtils.loadProperties(resource);
			realFilePath = serviceProps.getProperty(CPSConstants.FILE_UPLOAD_PATH);
		} catch (IOException e) {
			realFilePath = null;
		}
		// String realFilePath =
		// System.getProperty(CPSConstants.FILE_UPLOAD_PATH) ;
		if (realFilePath == null) {
			throw new ServletException("File Upload Path must be specified in server parameters.  Contact Help Desk.");
		}
		String transientFilePath = getServletContext().getRealPath("/") + "upload/";
		new File(transientFilePath).mkdir();
		File realFile = new File(realFilePath + File.separator + storedFileNm);
		if (!realFile.exists()) {
			File remoteFile = RemoteFileUtils.tryToCopyOver(realFilePath, storedFileNm);
			if ((remoteFile != null) && (remoteFile.exists())) {
				FileUtils.copyFile(remoteFile, realFile);
			} else {
				return;
			}
		}
		String transientFileName = transientFilePath + storedFileNm;
		File transientFile = new File(transientFileName);
		String localTransientFileName = "/upload/" + storedFileNm;
		FileUtils.copyFile(realFile, transientFile);
		// String fileURL = new StringBuilder("/upload/").append(
		// storedFileNm).toString();
		req.getRequestDispatcher(localTransientFileName).forward(req, resp);
		transientFile.delete();
		} else {
			String transientFilePath = getServletContext().getRealPath("/") + "upload/";
			new File(transientFilePath).mkdir();	
			String transientFileName = transientFilePath + storedFileNm;
			File transientFile = new File(transientFileName);	
			String localTransientFileName = "/upload/" + storedFileNm;	
			ImageVO imageVO = CommonBridge.getAddNewCandidateServiceInstance().getDocumentContentByClipId(clipId);
//			 Files.write(localTransientFileName, imageVO.getImageData()); //creates, overwrites
			FileUtils.writeByteArrayToFile(transientFile, imageVO.getImageData());
			req.getRequestDispatcher(localTransientFileName).forward(req, resp);	
			transientFile.delete();
		}

	}
}
