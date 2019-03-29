package com.heb.operations.cps.controller;

import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.business.framework.vo.VendorLocationVO;
import com.heb.operations.cps.model.AddNewCandidate;
import com.heb.operations.cps.model.AjaxSearchVO;
import com.heb.operations.cps.services.CpsIndexService;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.util.SearchUtils;
import com.heb.operations.cps.util.SimpleJsonContainer;
import com.heb.operations.cps.util.SimpleJsonObject;
import flexjson.JSONSerializer;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping(value = JsonSearchController.RELATIVE_PATH_JSON_SEARCH_BASE)
public class JsonSearchController  extends HEBBaseService {

    private static final Logger LOG = Logger.getLogger(JsonSearchController.class);

	public static final String RELATIVE_PATH_JSON_SEARCH_BASE="/protected/cps/add/manage/modules/search/backend";
	public static final String RELATIVE_PATH_AJAX_SEARCH = "/ajaxSearch";

	@RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = RELATIVE_PATH_AJAX_SEARCH)
	public ModelAndView searchHandle(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		AjaxSearchVO ajaxSearchVO = new AjaxSearchVO();

		ajaxSearchVO.setAction(req.getParameter("action"));
		ajaxSearchVO.setShowId(Boolean.valueOf(req.getParameter("showId")));
		ajaxSearchVO.setHighlightMatch(Boolean.valueOf(req.getParameter("highlightMatch")));
		ajaxSearchVO.setMaxResults(Integer.valueOf(req.getParameter("maxResults")));
		ajaxSearchVO.setUniqueId(req.getParameter("uniqueId"));
		ajaxSearchVO.setQuery(req.getParameter("query"));

		AddNewCandidate addNewCandidate = (AddNewCandidate) req.getSession().getAttribute(AddNewCandidate.FORM_NAME);

		String resStr = StringUtils.EMPTY;
		if("currentCommoditiesSearch".equals(ajaxSearchVO.getAction())){
			resStr = this.currentCommoditiesSearch(addNewCandidate, ajaxSearchVO, req);
		}
		else if("currentSubCommoditiesSearch".equals(ajaxSearchVO.getAction())){
			resStr = this.currentSubCommoditiesSearch(addNewCandidate, ajaxSearchVO, req);
		}
		else if("vendorSearch".equals(ajaxSearchVO.getAction())){
			resStr = this.vendorSearch(addNewCandidate, ajaxSearchVO, req);
		}
		else if("appLocationSearch".equals(ajaxSearchVO.getAction())){
			resStr = this.appLocationSearch(ajaxSearchVO, req);
		}
		else if("brickSearch".equals(ajaxSearchVO.getAction())){
			resStr = this.brickSearch(addNewCandidate, ajaxSearchVO, req);
		}
		else {
			resStr = handleLuceneQuery(req, ajaxSearchVO);
		}
		resp.getOutputStream().write(resStr.getBytes());
		return null;
	}

	private String currentCommoditiesSearch(AddNewCandidate addNewCandidate, AjaxSearchVO ajaxSearchVO,
										   HttpServletRequest req) throws Exception {
		String str = StringUtils.EMPTY;
		String query = ajaxSearchVO.getQuery();
		if (query != null && addNewCandidate != null && addNewCandidate.getCommodities() != null) {
			boolean reallyHighlightMatch = (ajaxSearchVO.isHighlightMatch()) && (query.trim().length() != 0);
			List<BaseJSFVO> comms = addNewCandidate.getCommodities();
			String[][] results = new String[comms.size()][2];
			for (int i = 0; i < comms.size(); i++) {
				try {
					results[i][0] = String.valueOf((long) Double.parseDouble(comms.get(i).getId()));
				} catch (Exception e) {
					LOG.error(e.getMessage(), e);
					results[i][0] = comms.get(i).getId();
				}
				results[i][1] = comms.get(i).getName();
			}
			String[][] filteredResults = SearchUtils.simpleSearch(results, query, true);
			cacheResults(req, filteredResults, ajaxSearchVO.getUniqueId());
			// show Id is false because the results come back to us with the ID
			// already showing
			str = jsonFormatCodeTableResults(filteredResults, query, false, reallyHighlightMatch);
		}
		return str;
	}

	private String currentSubCommoditiesSearch(AddNewCandidate addNewCandidate, AjaxSearchVO ajaxSearchVO,
											   HttpServletRequest req) throws Exception {
		String outStr = StringUtils.EMPTY;
		String query = ajaxSearchVO.getQuery();
		if (query != null && addNewCandidate != null && addNewCandidate.getCommodities() != null) {
			boolean reallyHighlightMatch = ajaxSearchVO.isHighlightMatch() && query.trim().length() != 0;
			List<BaseJSFVO> sComms = addNewCandidate.getSubCommodities();
			String[][] results = new String[sComms.size()][2];
			for (int i = 0; i < sComms.size(); i++) {
				try {
					results[i][0] = String.valueOf((long) Double.parseDouble(sComms.get(i).getId()));
				} catch (Exception e) {
					LOG.error(e.getMessage(), e);
					results[i][0] = sComms.get(i).getId();
				}
				results[i][1] = sComms.get(i).getName();
			}
			String[][] filteredResults = SearchUtils.simpleSearch(results, query, true);
			cacheResults(req, filteredResults, ajaxSearchVO.getUniqueId());
			// show Id is false because the results come back to us with the ID
			// already showing
			outStr = jsonFormatCodeTableResults(filteredResults, query, false, reallyHighlightMatch);
		}
		return outStr;
	}

	private String vendorSearch(AddNewCandidate addNewCandidate, AjaxSearchVO ajaxSearchVO,
								HttpServletRequest req) throws Exception {
		String outStr = StringUtils.EMPTY;
		String query = ajaxSearchVO.getQuery();

		if (query != null && addNewCandidate != null && addNewCandidate.getVendorVO() != null && addNewCandidate.getVendorVO().getVendorLocationList() != null) {

			boolean reallyHighlightMatch = ((ajaxSearchVO.isHighlightMatch()) && (query.trim().length() != 0));

			List<VendorLocationVO> vendorList = addNewCandidate.getVendorVO().getVendorLocationList();

			int size = vendorList.size();
			outStr = "No vendors";
			if (size > 0) {
				//String[][] results = new String[size][2];
				String[][] results = new String[size][4];
				for (int i = 0; i < size; i++) {
					try {
						results[i][0] = vendorList.get(i).getVendorId();
					} catch (Exception e) {
						LOG.error(e.getMessage(), e);
						i--; // Ignore the vendor that won't come nicely.
						continue;
					}
					results[i][1] = vendorList.get(i).getName();
					results[i][2] = vendorList.get(i).getPrimCity();
					results[i][3] = vendorList.get(i).getPrimStateCd();
				}

				String[][] filteredResults = SearchUtils.containsSearch(results, query, true);

				cacheResults(req, filteredResults, ajaxSearchVO.getUniqueId());

				// show Id is false because the results come back to us with the
				// ID already showing
				outStr = jsonFormatCodeTableResultsNew(filteredResults, query, false, reallyHighlightMatch);
			}
		}

		return outStr;
	}

	private String appLocationSearch(AjaxSearchVO ajaxSearchVO, HttpServletRequest req) throws Exception {
		List<BaseJSFVO> allApLocation = getCommonService().getApLocationsAsBaseJSFVOs();
		int size = allApLocation.size();
		String query = ajaxSearchVO.getQuery();
		boolean reallyHighlightMatch = false;
		if (query != null && query.trim().length() != 0)
			reallyHighlightMatch = true;
		String outStr = "No vendors";
		if (size > 0) {
			String[][] results = new String[size][2];
			for (int i = 0; i < size; i++) {
				try {
					results[i][0] = allApLocation.get(i).getId();
				} catch (Exception ohWell) {
					LOG.error(ohWell.getMessage(), ohWell);
					i--; // Ignore the vendor that won't come nicely.
					continue;
				}
				results[i][1] = allApLocation.get(i).getName();
			}
			String[][] filteredResults = SearchUtils.containsSearchAPVendor(results, query, true);
			// show Id is false because the results come back to us with the ID
			// already showing
			outStr = jsonFormatCodeTableResults(filteredResults, query, false, reallyHighlightMatch);
		}
		return outStr;
	}

	private String brickSearch(AddNewCandidate addNewCandidate, AjaxSearchVO ajaxSearchVO, HttpServletRequest req) throws Exception {
		String query = ajaxSearchVO.getQuery();
		String outStr = StringUtils.EMPTY;
		if (query != null && addNewCandidate != null) {
			boolean reallyHighlightMatch = ((ajaxSearchVO.isHighlightMatch()) && (query.trim().length() != 0));
			List<BaseJSFVO> bricks = addNewCandidate.getBricks();
			String[][] results = new String[bricks.size()][2];
			for (int i = 0; i < bricks.size(); i++) {
				results[i][0] = bricks.get(i).getId();
				results[i][1] = bricks.get(i).getName();
			}
			String[][] filteredResults = SearchUtils.simpleSearch(results, query, true);
			cacheResults(req, filteredResults, ajaxSearchVO.getUniqueId());
			// show Id is false because the results come back to us with the ID
			// already showing
			outStr = jsonFormatCodeTableResults(filteredResults, query, false, reallyHighlightMatch);
		}
		return outStr;
	}

	private String handleLuceneQuery(HttpServletRequest req, AjaxSearchVO ajaxSearchVO) throws Exception {
		String brandValue = ajaxSearchVO.getQuery().replace("&#43;", "+");
		ajaxSearchVO.setQuery(brandValue.toLowerCase());
		CpsIndexService indexLocal = getCpsIndexService();
		String[][] res = null;

		Method m = null;
		int methSig = -1;
		try {
			m = CpsIndexService.class.getMethod(ajaxSearchVO.getAction(), String.class);
			methSig = 1;
		} catch (NoSuchMethodException e1) {
			LOG.error(e1.getMessage(), e1);
			try {
				m = CpsIndexService.class.getMethod(ajaxSearchVO.getAction(), new Class[] { String.class, Integer.TYPE });
				methSig = 2;
			} catch (NoSuchMethodException e2) {
				LOG.error(e2.getMessage(), e2);
				try {
					m = CpsIndexService.class.getMethod(ajaxSearchVO.getAction(), new Class[] { String.class, Boolean.TYPE });
					methSig = 3;
				} catch (NoSuchMethodException e3) {
					LOG.error(e3.getMessage(), e3);
				}
			}
		}
		if (m != null) {
			Object[] args = null;

			switch (methSig) {
				case 1:
					args = new Object[] { ajaxSearchVO.getQuery() };
					break;
				case 2:
					args = new Object[] { ajaxSearchVO.getQuery(), ajaxSearchVO.getMaxResults() };
					break;
				case 3:
					args = new Object[] { ajaxSearchVO.getQuery(), ajaxSearchVO.isSearchOnId() };
					break;

				default:
					break;
			}
			res = (String[][]) m.invoke(indexLocal, args);
		}

		String outStr = null;

		if (res != null) {
			cacheResults(req, res, ajaxSearchVO.getUniqueId());

			boolean reallyHighlightMatch = ((ajaxSearchVO.isHighlightMatch()) && (ajaxSearchVO.getQuery().trim().length() != 0));
			outStr = jsonFormatCodeTableResults(res, ajaxSearchVO.getQuery(), ajaxSearchVO.isShowId(), reallyHighlightMatch);
		}
		return outStr;
	}

    private void cacheResults(final HttpServletRequest req, final String[][] res, final String uniqueId) {
	// moved implementation to base class so as to facilitate caching from
	// all
	// action classes - albin
	cacheAutoCompleterResults(req, res, uniqueId);
    }

	private String jsonFormatCodeTableResults(String[][] rawResults, String query, boolean showId, boolean highlightMatch) {
		Pattern p = null;
		StringBuffer pieceAssembler = null;
		if (highlightMatch) {
			p = Pattern.compile("\\b\\[?" + query.trim(), Pattern.CASE_INSENSITIVE);
			pieceAssembler = new StringBuffer();
		}

		List<SimpleJsonObject> resList = new ArrayList<SimpleJsonObject>();

		JSONSerializer ser = new JSONSerializer();

		for (int i = 0; i < rawResults.length; i++) {
			SimpleJsonObject sjo = new SimpleJsonObject();
			sjo.setId(rawResults[i][0]);

			String txt;
			if (showId) {
				txt = rawResults[i][1] + " [" + rawResults[i][0] + "]";
			} else {
				txt = rawResults[i][1];
			}

			sjo.setName(txt);

			if (highlightMatch) {
				sjo.setMarkup(highlightText(p, pieceAssembler, txt));
			} else {
				sjo.setMarkup(txt);
			}

			resList.add(sjo);
		}

		SimpleJsonContainer cont = new SimpleJsonContainer();
		cont.setResultList(resList);

		String outStr = ser.exclude("class").serialize("resultList", resList);
		// ser.include("resultList").exclude("class").exclude("resultList.class").serialize(cont);

		return outStr;
	}


    private String highlightText(Pattern p, StringBuffer sb, String txt) {
	Matcher m = p.matcher(txt);
	sb.delete(0, sb.length());
	if (m.find()) {
	    sb.append(txt.substring(0, m.start()));
	} else {
	    return txt;
	}

	int lastEnd = -1;
	do {
	    if (lastEnd > 0) {
		sb.append(txt.substring(lastEnd, m.start()));
	    }
	    sb.append("<b>");
	    sb.append(txt.substring(m.start(), m.end()));
	    sb.append("</b>");
	    lastEnd = m.end();
	} while (m.find());

	if (lastEnd > 0 && lastEnd < txt.length()) {
	    sb.append(txt.substring(lastEnd));
	}
	return sb.toString();
    }

    private String jsonFormatCodeTableResultsNew(String[][] rawResults, String query, boolean showId,
			boolean highlightMatch) {
    	Pattern p = null;
    	StringBuffer pieceAssembler = null;
    	if (highlightMatch) {
    	    p = Pattern.compile("\\b\\[?" + query.trim(), Pattern.CASE_INSENSITIVE);
    	    pieceAssembler = new StringBuffer();
    	}

    	List<SimpleJsonObject> resList = new ArrayList<SimpleJsonObject>();

    	JSONSerializer ser = new JSONSerializer();

    	for (int i = 0; i < rawResults.length; i++) {
    	    SimpleJsonObject sjo = new SimpleJsonObject();
    	    sjo.setId(rawResults[i][0]);

    	    String txt;
    	    if (showId) {
    		txt = rawResults[i][1] + " [" + rawResults[i][0] + "]";
    	    } else {
    	    	if(CPSHelper.isNotEmpty(rawResults[i][2]) && CPSHelper.isNotEmpty(rawResults[i][3])){
    	    		txt = rawResults[i][1] + " " + rawResults[i][2] + "," + rawResults[i][3];
    	    	}else{
    	    		txt = rawResults[i][1];
    	    	}
    	    }
    	    sjo.setName(txt);

    	    if (highlightMatch) {
    		sjo.setMarkup(highlightText(p, pieceAssembler, txt));
    	    } else {
    		sjo.setMarkup(txt);
    	    }

    	    resList.add(sjo);
    	}

    	SimpleJsonContainer cont = new SimpleJsonContainer();
    	cont.setResultList(resList);

    	String outStr = ser.exclude("class").serialize("resultList", resList);
    	// ser.include("resultList").exclude("class").exclude("resultList.class").serialize(cont);

    	return outStr;
	}
}