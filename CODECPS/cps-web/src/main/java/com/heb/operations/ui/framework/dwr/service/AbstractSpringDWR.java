package com.heb.operations.ui.framework.dwr.service;

import com.heb.jaf.security.Role;
import com.heb.jaf.security.UserInfo;
import com.heb.operations.business.framework.exeption.CPSMessage;
import com.heb.operations.cps.model.HebBaseInfo;
import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.util.CPSWebUtil;
import org.apache.log4j.Logger;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.http.HttpSession;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Base for all CPS DWR services. Allows all service methods to have access to
 * the current struts action form.
 * @author robhardt
 *
 */
public abstract class AbstractSpringDWR implements CPSConstants {

    private static final Logger LOG = Logger.getLogger(AbstractSpringDWR.class);

    protected HebBaseInfo getForm(String name) {
	WebContext wc = WebContextFactory.get();
	HttpSession sess = wc.getSession();
	HebBaseInfo hebBaseInfo = (HebBaseInfo)sess.getAttribute(name);
	if(hebBaseInfo != null){
		hebBaseInfo.setSession(sess);
	}
	return hebBaseInfo;
    }
    protected abstract HebBaseInfo getForm();

    protected void saveMessage(CPSMessage msg) {
	List<CPSMessage> list = CPSWebUtil.getDWRMessagesInSession(WebContextFactory.get().getSession());
	if (null != list) {
	    list.add(msg);
	}
    }

    protected void saveMessages(List<CPSMessage> messages) {
	if (null != messages) {
	    List<CPSMessage> list = CPSWebUtil.getDWRMessagesInSession(WebContextFactory.get().getSession());
	    list.addAll(messages);
	}
    }

    protected Map getCachedResults(String uniqueId) {
	Map resultsMap = (Map) WebContextFactory.get().getSession().getAttribute("JSON_SEARCH_RESULTS_MAP");
	if (resultsMap != null) {
	    // the cache stores search results based on the 'uniqueId' of the
	    // tag
	    // doing the query
	    Map results = (Map) resultsMap.get(uniqueId);
	    return results;
	}
	return null;
    }

    // protected String getUserRole(){
    // String[] ret = null;
    // try {
    // HttpServletRequest request =
    // (HttpServletRequest)PolicyContext.getContext(HEBCustomRealmDelegateImpl.WEB_REQUEST_KEY);
    // Map <String,UserRole> userRoles = (Map
    // <String,UserRole>)request.getSession(true).getAttribute("com.heb.UserRoles");
    // if(null != userRoles && userRoles.size()>0){
    // ret = new String[userRoles.size()];
    // Object [] ur = userRoles.values().toArray();
    // int i=0;
    // for(Object ur1 : ur) {
    // ret[i++]=((UserRole)ur1).getRoleCd();
    // }
    // for (String role : ret) {
    // if(!"Guest".equalsIgnoreCase(role)){
    // return role;
    // }
    // }
    // }else{
    // return "Guest";
    // }
    // } catch (PolicyContextException e) {
    //// LOG.fatal("Exception", e);
    // }
    // return "Guest";
    // }
    protected String getUserRole() {
	Authentication au = SecurityContextHolder.getContext().getAuthentication();
	if (au != null) {
	    Collection<? extends GrantedAuthority> getAuth = au.getAuthorities();
	    if (null != getAuth && !getAuth.isEmpty()) {
		Role role = null;
		for (GrantedAuthority grantedAuthority : getAuth) {
		    role = ((Role) grantedAuthority);
		    if (!"Guest".equalsIgnoreCase(role.getRoleName())) {
			return role.getRoleName();
		    }
		}
	    }
	}
	return "Guest";
    }

    // protected UserInfo getUserInfo(){
    // try {
    // HttpServletRequest request =
    // (HttpServletRequest)PolicyContext.getContext(HEBCustomRealmDelegateImpl.WEB_REQUEST_KEY);
    // UserInfo info =
    // (UserInfo)request.getSession(true).getAttribute("com.heb.UserAccountInfo");
    // return info;
    // } catch (PolicyContextException e) {
    //// LOG.fatal("Exception:-", e);
    // }
    //
    // return null;
    // }
    protected UserInfo getUserInfo() {
	Authentication au = SecurityContextHolder.getContext().getAuthentication();
	if (au != null) {
	    return (UserInfo) au.getPrincipal();
	}
	return null;
    }
}
