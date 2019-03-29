package com.heb.operations.ui.framework.dwr.custom;

import com.heb.operations.business.framework.exeption.CPSBusinessException;
import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.exeption.CPSMessage;
import com.heb.operations.business.framework.exeption.CPSMessage.ErrorSeverity;
import com.heb.operations.business.framework.exeption.CPSSystemException;
import com.heb.operations.cps.model.HebBaseInfo;
import com.heb.operations.cps.util.CPSWebUtil;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.directwebremoting.AjaxFilter;
import org.directwebremoting.AjaxFilterChain;
import org.directwebremoting.WebContextFactory;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;

public class HEBSpringDWRIntegrationFilter implements AjaxFilter {
    private static Logger LOG = Logger.getLogger(HEBSpringDWRIntegrationFilter.class);
    private static final String APPLICATION_DATA = "appData";
    private static final String MESSAGE_DATA = "messages";
    private static final String EXCEPTION_FLAG = "exception";
    private static final String MESSAGE_LIST = "messageList";
    private static final String STACK_TRACE = "stackTrace";

    // private void validateSession() throws Exception {
    // HttpSession session = WebContextFactory.get().getSession(false);
    // if(session != null){
    // if(session.getAttribute("com.heb.UserAccountInfo") == null){
    // throw new Exception("Session expired. Please re-login and try again.");
    // }
    // }else{
    // throw new Exception("Session expired. Please re-login and try again.");
    // }
    // }
    private boolean validateSession() throws Exception {
    	boolean invalid = false;
		Authentication au = SecurityContextHolder.getContext().getAuthentication();
		if (au != null) {
			if(au instanceof AnonymousAuthenticationToken) {
				invalid = true;
			} else if (!au.isAuthenticated()) {
				invalid = true;
			}
		} else {
			invalid = true;
		}
		return invalid;
    }
    
    public Object doFilter(Object obj, Method method, Object[] params, AjaxFilterChain chain) throws Exception {
	Object o = null;
	HashMap<String, Object> map = new HashMap<String, Object>();
	clearMessages();
	try {
	    HttpServletRequest request = WebContextFactory.get().getHttpServletRequest();
	    if((request!=null && !request.isRequestedSessionIdValid()) || validateSession()) {
	    	List<CPSMessage> list = new ArrayList<CPSMessage>();
	    	list.add(new CPSMessage("Session expired. Please re-login and try again.", ErrorSeverity.SESSIONTIMEOUT));
	    	map.put(MESSAGE_DATA, getMessageMap(list, false, null));
			return map;
	    }
	    o = chain.doFilter(obj, method, params);
	} catch (InvocationTargetException e) {
	    LOG.fatal("Exception:-", e);
//	    e.printStackTrace();
	    Throwable trgtE = e.getTargetException();
	    if (trgtE instanceof CPSBusinessException) {
		CPSBusinessException cpe = (CPSBusinessException) trgtE;
		List<CPSMessage> list = cpe.getMessages();
		map.put(MESSAGE_DATA, getMessageMap(list, true, cpe));
		return map;
	    } else if (trgtE instanceof CPSSystemException) {
		CPSSystemException cpe = (CPSSystemException) trgtE;
		CPSMessage m = cpe.getCPSMessage();
		List<CPSMessage> list = new ArrayList<CPSMessage>();
		list.add(m);
		map.put(MESSAGE_DATA, getMessageMap(list, true, cpe));
		return map;
	    } else {
		List<CPSMessage> list = new ArrayList<CPSMessage>();
		String msg = e.getMessage();
		if (msg == null) {
		    if (trgtE instanceof CPSGeneralException) {
			CPSGeneralException exception = (CPSGeneralException) trgtE;
			msg = exception.getMessage();
		    }
		    if (msg == null) {
			msg = trgtE.getMessage();
		    }
		    if (msg == null) {
			list.add(new CPSMessage("Your Operation is being invalid. Please try again!", ErrorSeverity.ERROR));
		    } else {
			list.add(new CPSMessage(msg, ErrorSeverity.ERROR));
		    }
		}
		map.put(MESSAGE_DATA, getMessageMap(list, true, e.getTargetException()));
		return map;
	    }
	} catch (Exception e) {
	    LOG.fatal("Exception:-", e);
	    List<CPSMessage> list = new ArrayList<CPSMessage>();
	    if (e.getMessage() != null) {
		list.add(new CPSMessage(e.getMessage(), ErrorSeverity.ERROR));
	    } else {
		list.add(new CPSMessage("Your Operation is being invalid. Please try again!", ErrorSeverity.ERROR));
	    }
	    map.put(MESSAGE_DATA, getMessageMap(list, true, e));
	    return map;
	}
		SpringFormCorrelatedService serv;
		SpringFormCorrelatedMethod meth;
	// Class c = obj.getClass();
	// Object anns = c.getAnnotations();
	if ((serv = obj.getClass().getAnnotation(SpringFormCorrelatedService.class)) != null) {
	    if ((meth = method.getAnnotation(SpringFormCorrelatedMethod.class)) != null) {
		String formName = serv.formName();
		String scope = serv.formScope();
		String prop = meth.correlatedStrutsFormProperty();
		if ((formName != null) && (prop != null) && (scope != null) && (("session").equals(scope))) {
		    // if((scope != null) && (("session").equals(scope))){
			HebBaseInfo form = (HebBaseInfo) WebContextFactory.get().getSession().getAttribute(formName);
		    if (form != null) {
			BeanUtils.setProperty(form, prop, o);
		    }
		    // }
		}
	    }
	}
	map.put(APPLICATION_DATA, o);
	map.put(MESSAGE_DATA, getMessageMap(getMessages(), false, null));
//	HttpServletRequest req = WebContextFactory.get().getHttpServletRequest();
//	LOG.debug("CONTENT TYPE for this DWR request - " + req.getContentType());
	return map;
    }

    private Map<String, Object> getMessageMap(List<CPSMessage> list, boolean exception, Throwable t) {
	Map<String, Object> map = new HashMap<String, Object>();
	map.put(EXCEPTION_FLAG, exception);
	map.put(MESSAGE_LIST, list);
	if (exception) {
	    map.put(STACK_TRACE, getStackTraceString(t));
	}
	return map;
    }

    private String getStackTraceString(Throwable t) {
	StringBuffer buffer = new StringBuffer();
	if (null != t) {
	    for (; t != null; t = t.getCause()) {
		buffer.append(getStackTraceHTMLForSingleThrowable(t));
	    }
	}
	return buffer.toString();
    }

    private String getStackTraceHTMLForSingleThrowable(Throwable t) {
	StringBuffer buffer = new StringBuffer();
	if (null != t) {
	    buffer.append(t.toString());
	    StackTraceElement[] elements = t.getStackTrace();
	    if (null != elements) {
		for (StackTraceElement element : elements) {
		    buffer.append(element.getClassName());
		    buffer.append(":");
		    buffer.append(element.getFileName());
		    buffer.append(":");
		    buffer.append(element.getMethodName());
		    buffer.append(":");
		    buffer.append(element.getLineNumber());
		    buffer.append("<br>");
		}
	    }
	}
	return buffer.toString();
    }

    private List<CPSMessage> getMessages() {
    	List<CPSMessage> list = null;
    	try {
    		list = CPSWebUtil.getDWRMessagesInSession(WebContextFactory.get().getSession());
    		if(list!=null){
				Collections.sort(list);
				Collections.reverse(list);
			}
		} catch (Exception e) {
			LOG.error("The error had occured in HEBSpringDWRIntegrationFilter.getMessages():"+e.getMessage(), e);
		}
	return list;
    }

    private void clearMessages() {
	List<CPSMessage> list = CPSWebUtil.getDWRMessagesInSession(WebContextFactory.get().getSession());
	list.clear();
    }

}
