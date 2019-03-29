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

public class PrintFormViewerServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final String PATH_SEPERATOR = System.getProperty("file.separator");
	public static final String PRINT_FORM_DIR = "PrintForm";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PrintFormViewerServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileName = (String) request.getParameter("errorMessage");
		if (fileName == null || ("").equals(fileName))
			throw new ServletException("Invalid or non-existent file parameter in UrlServlet servlet.");
		if (fileName.indexOf(".pdf") == -1)
			fileName = fileName + ".pdf";
		String pdfDir = request.getSession().getServletContext().getRealPath("").concat(PATH_SEPERATOR).concat(PRINT_FORM_DIR);
		if (pdfDir == null || ("").equals(pdfDir))
			throw new ServletException("Invalid or non-existent pdfDir context-param.");
		ServletOutputStream stream = null;
		BufferedInputStream buf = null;
		try {
			stream = response.getOutputStream();
			File pdf = new File(pdfDir + PATH_SEPERATOR + fileName);
			response.setContentType("application/pdf");
			response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
			response.setHeader("Cache-Control", "");
			response.setHeader("Pragma", "");
			response.setContentLength((int) pdf.length());
			FileInputStream input = new FileInputStream(pdf);
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
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
