package com.heb.operations.ui.framework.lifecyclelistener;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.lang.ref.Reference;
import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.util.Iterator;
import java.util.Properties;

import javax.management.MBeanServer;
import javax.management.ObjectName;
import javax.servlet.ServletContextEvent;
import javax.servlet.http.HttpSessionEvent;

import org.apache.log4j.Logger;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.cps.services.CPSIndexUtilService;
import com.heb.operations.cps.util.CPSHelper;

import org.apache.commons.io.FileUtils;

/**
 * The listener interface for receiving CPSIndexLifecycle events. The class that is interested in processing a
 * CPSIndexLifecycle event implements this interface, and the object created with that class is registered with a
 * component using the component's <code>addCPSIndexLifecycleListener<code> method. When the CPSIndexLifecycle event
 * occurs, that object's appropriate method is invoked.
 * @see ContextLoaderListener
 */
public class CPSIndexLifecycleListener extends ContextLoaderListener {

	/** The log. */
	private static Logger LOG = Logger.getLogger(CPSIndexLifecycleListener.class);

	/** The mbs. */
	MBeanServer mbs = null;

	/** The mbean name. */
	ObjectName mbeanName = null;

	/** The cps index util service. */
	private CPSIndexUtilService cpsIndexUtilService;

	/**
	 * Invoked when session is created.
	 * @param evt
	 *            the evt
	 */
	public void sessionCreated(HttpSessionEvent evt) {

	}

	/**
	 * Session destroyed.
	 * @param evt
	 *            the evt
	 */
	public void sessionDestroyed(HttpSessionEvent evt) {
	}

	/*
	 * (non-Javadoc)
	 * @see org.springframework.web.context.ContextLoaderListener#contextDestroyed(javax.servlet.ServletContextEvent)
	 */
	public void contextDestroyed(ServletContextEvent evt) {
		try {
			cpsIndexUtilService.destroyCaches();
		} catch (Exception ex) {
			LOG.error("UNABLE TO Destroy cache: " + ex + ":  Stack trace to follow.");
		}
		cleanThreadLocals();
	}

	/**
	 * Populate help desc.
	 * @param codeDescList
	 *            the code desc list
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private void populateHelpDesc(BaseJSFVO[] codeDescList) throws IOException {
		Properties descriptions = new Properties();
		InputStream descStream = null;
		try {
			descStream = this.getClass().getClassLoader().getResourceAsStream("HelpTexts.properties");
			descriptions.load(descStream);

			Iterator<Object> keyIterator = descriptions.keySet().iterator();
			while (keyIterator.hasNext()) {
				String key = (String) keyIterator.next();
				int i = Integer.parseInt(key);
				String desc = descriptions.getProperty(key);
				codeDescList[i - 1].setName(desc);
			}
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		} finally {
			if (descStream != null) {
				descStream.close();
			}
		}
	}

	/**
	 * Populate help texts.
	 * @param evt
	 *            the evt
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private void populateHelpTexts(ServletContextEvent evt) throws IOException {
		Properties codes = new Properties();
		InputStream codeStream = null;
		try {
			codeStream = this.getClass().getClassLoader().getResourceAsStream("HelpCodes.properties");
			codes.load(codeStream);
			codeStream.close();

			Iterator<Object> keyIterator = codes.keySet().iterator();
			BaseJSFVO[] codeDescList = new BaseJSFVO[codes.size()];
			while (keyIterator.hasNext()) {
				String key = (String) keyIterator.next();
				String code = codes.getProperty(key);
				BaseJSFVO codeDesc = new BaseJSFVO(code, code);

				int i = Integer.parseInt(key);
				codeDescList[i - 1] = codeDesc;
			}
			// Arrays.sort(codeDescList);
			populateHelpDesc(codeDescList);
			evt.getServletContext().setAttribute("helpTexts", codeDescList);
		} catch (IOException e) {
			// LOG.fatal("IO Exception while loading the CPS Help.", e);
		} finally {
			if (codeStream != null) {
				codeStream.close();
			}
		}

	}

	/*
	 * (non-Javadoc)
	 * @see org.springframework.web.context.ContextLoaderListener#contextInitialized(javax.servlet.ServletContextEvent)
	 */
	@Override
	public void contextInitialized(ServletContextEvent evt) {
		// deleteCacheWhenShutDown();
		WebApplicationContext springContext = WebApplicationContextUtils
				.getWebApplicationContext(evt.getServletContext());
		cpsIndexUtilService = (CPSIndexUtilService) springContext.getBean("cpsIndexUtilService");
		try {
			cpsIndexUtilService.updateCaches();
		} catch (Exception ex) {
			LOG.error("UNABLE TO REFRESH DATA AND SET TIMERS: " + ex + ":  Stack trace to follow.");
		}
		try {
			populateHelpTexts(evt);
		} catch (IOException e) {
			LOG.error("UNABLE TO GET HELP TEXTS", e);
		}
	}

	/**
	 * Clean thread locals.
	 */
	private void cleanThreadLocals() {
		try {
			// Get a reference to the thread locals table of the current thread

			Thread thread = Thread.currentThread();
			Field threadLocalsField = Thread.class.getDeclaredField("threadLocals");
			threadLocalsField.setAccessible(true);
			Object threadLocalTable = threadLocalsField.get(thread);
			// Get a reference to the array holding the thread local variables
			// inside the
			// ThreadLocalMap of the current thread
			Class threadLocalMapClass = Class.forName("java.lang.ThreadLocal$ThreadLocalMap");
			Field tableField = threadLocalMapClass.getDeclaredField("table");
			tableField.setAccessible(true);
			Object table = tableField.get(threadLocalTable);
			// The key to the ThreadLocalMap is a WeakReference object. The
			// referent field of this object
			// is a reference to the actual ThreadLocal variable
			Field referentField = Reference.class.getDeclaredField("referent");
			referentField.setAccessible(true);
			for (int i = 0; i < Array.getLength(table); i++) {
				// Each entry in the table array of ThreadLocalMap is an Entry
				// object
				// representing the thread local reference and its value
				Object entry = Array.get(table, i);
				if (entry != null) {
					// Get a reference to the thread local object and remove it
					// from the table
					ThreadLocal threadLocal = (ThreadLocal) referentField.get(entry);
					threadLocal.remove();
				}
			}
		} catch (Exception e) {
			// We will tolerate an exception here and just log it
			throw new IllegalStateException(e);
		}
	}

	/**
	 * Delete cache when shut down.
	 */
	private void deleteCacheWhenShutDown() {
		try {
			File f = new File(getDirLoc());
			FileUtils.cleanDirectory(f);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * Gets the dir loc.
	 * @return the dir loc
	 * @throws Exception
	 *             the exception
	 */
	private String getDirLoc() throws Exception {
		Resource resource = new ClassPathResource(
				CPSHelper.getProfileActivePath() + "/cps-service-application.properties");
		Properties serviceProps;
		String dirLoc = null;
		try {
			serviceProps = PropertiesLoaderUtils.loadProperties(resource);
			dirLoc = serviceProps.getProperty("com.heb.operations.cps.CPSIndexBaseDir");
		} catch (IOException e) {
			LOG.warn(
					"No index base directory specified in system props.  It's a bad idea, but I'll have to use the tmp directory instead.");
			dirLoc = System.getProperty("java.io.tmpdir");
			if (dirLoc == null) {
				throw new Exception("unable to find a directory to write CPS indexes to");
			}
		}
		return dirLoc;
	}

}
