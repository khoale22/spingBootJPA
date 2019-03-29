package com.heb.operations.cps.servlet;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

import org.apache.log4j.Logger;

import com.heb.operations.cps.util.CPSWebUtil;

public class CPSWebFilter implements Filter {

	private static Logger LOG = Logger.getLogger(CPSWebFilter.class);

	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		FilteredRequest filteredRequest = new FilteredRequest(request);

		DummyResponseWrapper wrapper = new DummyResponseWrapper((HttpServletResponse) response);
		try {
			clearAllPreviousForms((HttpServletRequest) request);
			chain.doFilter(filteredRequest, wrapper);
		} catch (Exception e) {
			LOG.error("Stack Trace Ends..." + e.getMessage(), e);
			LOG.error("Request URI------------> " + ((HttpServletRequest) request).getRequestURI());
		}
		response.getWriter().print(wrapper.getResponseData());
	}

	private void clearAllPreviousForms(HttpServletRequest request) {
		try {
			if (request.getRequestURI().endsWith(".do")
					&& !(request.getQueryString() != null && request.getQueryString().contains("printForm") || request.getQueryString().contains("printMRT") || request.getQueryString().contains(
							"PrintFormViewerServlet"))) {// Fix
				// 1331
				List<String> list = CPSWebUtil.getToBeClearedFormList(request);
				if (!list.isEmpty()) {
					for (Iterator<String> iter = list.listIterator(); iter.hasNext();) {
						String s = iter.next();
						if ((s != null) && (!("").equals(s.trim()))) {
							request.getSession().removeAttribute(s);
						}

						iter.remove();

					}
				}
			}
		} catch (Exception e) {
			LOG.error("in web filter - clearAllPreviousForms --> " + e.getMessage(), e);
			LOG.error(((HttpServletRequest) request).getRequestURI());
		}

	}

	public void init(FilterConfig arg0) throws ServletException {
	}

	private class DummyResponseWrapper extends HttpServletResponseWrapper {

		ServletOutputStream sos;
		PrintWriter pw;
		CharArrayWriter caw;

		public DummyResponseWrapper(HttpServletResponse response) {
			super(response);
			caw = new CharArrayWriter();
		}

		public ServletOutputStream getOutputStream() throws IOException {
			if (sos == null) {
				sos = new ServletOutputStream() {
					public void write(int i) throws IOException {
						caw.write(i);
					}
				};
			}
			return sos;
		}

		public PrintWriter getWriter() throws IOException {
			if (pw == null) {
				pw = new PrintWriter(caw);
			}
			return pw;
		}

		public String getResponseData() {
			String responseData = caw.toString();
			if (responseData != null) {
				responseData = responseData.replaceAll("&amp;", "&");
			}
			return responseData;
		}
	}

	class FilteredRequest extends HttpServletRequestWrapper {

		public FilteredRequest(ServletRequest request) {
			super((HttpServletRequest) request);
		}

		public String getParameter(String paramName) {
			String value = super.getParameter(paramName);
			return CPSWebUtil.sanitize(value);
		}

		public String[] getParameterValues(String paramName) {
			String values[] = super.getParameterValues(paramName);
			if (values != null) {
				for (int index = 0; index < values.length; index++) {
					values[index] = CPSWebUtil.sanitize(values[index]);
				}
			}
			return values;
		}

	}
}
