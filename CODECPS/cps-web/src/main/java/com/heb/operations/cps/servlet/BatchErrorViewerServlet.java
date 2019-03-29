package com.heb.operations.cps.servlet;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.heb.operations.cps.util.CPSConstants;

public class BatchErrorViewerServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final String PATH_SEPERATOR = System.getProperty("file.separator");
	public static final String BATCH_DIR = "Batch";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BatchErrorViewerServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileName = (String) request.getParameter("errorMessage");
		fileName = CPSConstants.ERR_MESS + fileName;
		if (fileName == null || ("").equals(fileName))
			throw new ServletException("Invalid or non-existent file parameter in UrlServlet servlet.");
		if (fileName.indexOf(".doc") == -1)
			fileName = fileName + ".doc";
		String wordDir = request.getSession().getServletContext().getRealPath("").concat(PATH_SEPERATOR).concat(BATCH_DIR);
		if (wordDir == null || ("").equals(wordDir))
			throw new ServletException("Invalid or non-existent wordDir context-param.");
		ServletOutputStream stream = null;
		BufferedInputStream buf = null;
		try {
			stream = response.getOutputStream();
			File doc = new File(wordDir + PATH_SEPERATOR + fileName);
			response.setContentType("application/msword");
			response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
			response.setHeader("Cache-Control", "");
			response.setHeader("Pragma", "");
			response.setContentLength((int) doc.length());
			FileInputStream input = new FileInputStream(doc);
			buf = new BufferedInputStream(input);
			int readBytes = 0;
			while ((readBytes = buf.read()) != -1)
				stream.write(readBytes);
		} catch (IOException ioe) {
			throw new ServletException(ioe.getMessage(), ioe);
		} finally {
			if (stream != null)
				stream.close();
			if (buf != null)
				buf.close();
		}
		// req.getRequestDispatcher(tempURL).forward(req,resp);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
