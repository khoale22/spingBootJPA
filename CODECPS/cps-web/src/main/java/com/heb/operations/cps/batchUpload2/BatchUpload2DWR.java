package com.heb.operations.cps.batchUpload2;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.heb.operations.cps.model.HebBaseInfo;
import com.heb.operations.ui.framework.dwr.service.AbstractSpringDWR;
import org.apache.log4j.Logger;
import org.directwebremoting.WebContextFactory;

import com.heb.operations.cps.ejb.batchUpload2.BatchUpload2VO;
import com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO;
import com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO.SORT_TYPE;
import com.heb.operations.cps.services.BatchUpload2Service;
import com.heb.operations.cps.util.BusinessConstants;

public class BatchUpload2DWR extends AbstractSpringDWR implements BusinessConstants {
	private static Logger LOG = Logger.getLogger(BatchUpload2DWR.class);

	@Override
	protected HebBaseInfo getForm() {
		return null;
	}

	private BatchUpload2Service batchUpload2Service;

	public BatchUpload2Service getBatchUpload2Service() {
		return batchUpload2Service;
	}

	public void setBatchUpload2Service(BatchUpload2Service batchUpload2Service) {
		this.batchUpload2Service = batchUpload2Service;
	}

	private Map<String, Object> sort(SORT_TYPE sortType) {

		try {
			String name = WebContextFactory.get().getHttpServletRequest().getUserPrincipal().getName();

			getBatchUpload2Service().setCurrentSortType(name, sortType);

		} catch (Exception ex) {
			LOG.error(ex.getMessage(), ex);
		}

		return getStats2();
	}

	public Map<String, Object> sortByStatus() {
		return sort(SORT_TYPE.STATUS);
	}

	public Map<String, Object> sortByOriginalOrder() {
		return sort(SORT_TYPE.ORIGINAL_ORDER);
	}

	public Map<String, Object> getStats2() {
		Map<String, Object> ret = new HashMap<String, Object>();

		try {
			String name = WebContextFactory.get().getHttpServletRequest().getUserPrincipal().getName();

			BatchUploadStatusVO statVo = getBatchUpload2Service().getCurrentStatus(name);

			if (statVo != null) {
				List<BatchUpload2VO> rowVos = getBatchUpload2Service().getAllRowVos(statVo.getRealFileName());
				if (rowVos != null) {
					if (statVo.getSortType() == SORT_TYPE.STATUS) {
						Collections.sort(rowVos);
					} else {
						Collections.sort(rowVos, new BatchUpload2VO.RowNumComparator());
					}
					WebContextFactory.get().getHttpServletRequest().setAttribute("rowVos", rowVos);
				}

				WebContextFactory.get().getHttpServletRequest().setAttribute("statVo", statVo);

				String content = WebContextFactory.get().forwardToString("/cps/batch/statTable.jsp");
				boolean isComplete = ((statVo.getTotalRows() == statVo.getTotalRowsComplete()) && (statVo.getTotalRows() != 0));

				if (!isComplete) {
					if (statVo.getStatus() == com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO.STATUS.DEAD) {
						isComplete = true;
					}
				}
				ret.put("content", content);
				ret.put("complete", isComplete);
			} else {
				ret.put("complete", true);
			}
		} catch (Exception ex) {
			LOG.error(ex.getMessage(), ex);
		}

		return ret;
	}
}
