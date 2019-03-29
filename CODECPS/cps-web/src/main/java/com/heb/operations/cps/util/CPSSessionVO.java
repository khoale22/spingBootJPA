package com.heb.operations.cps.util;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.business.framework.vo.VendorLocationVO;
import com.heb.operations.cps.vo.QuestionnarieVO;
import com.heb.operations.cps.vo.VendorLocDeptVO;

public class CPSSessionVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int selectedFunction;
	private QuestionnarieVO questionnarieVO;

	private List<BaseJSFVO> merchandizingTypes;
	private Map<String, VendorLocDeptVO> vendorIdMap = null;

	public Map<String, VendorLocDeptVO> getVendorIdMap() {
		return vendorIdMap;
	}

	public void setVendorIdMap(Map<String, VendorLocDeptVO> vendorIdMap) {
		this.vendorIdMap = vendorIdMap;
	}

	public VendorLocDeptVO getVendorInfo(String locId) {
		VendorLocDeptVO value = null;
		if (vendorIdMap != null) {
			value = vendorIdMap.get(locId);
		}
		return value;
	}

	public int getSelectedFunction() {
		return selectedFunction;
	}

	public void setSelectedFunction(int selectedFunction) {
		this.selectedFunction = selectedFunction;
	}

	public void setMerchandizingTypes(List<BaseJSFVO> merchandizingTypes) {
		this.merchandizingTypes = merchandizingTypes;
	}

	public List<BaseJSFVO> getMerchandizingTypes() {
		return merchandizingTypes;
	}

	public List<VendorLocationVO> getVendorLocationVOs(String deptNo,
			String subDeptNo, String classField, String comm, String channelVal)
			throws CPSGeneralException {
		List<VendorLocDeptVO> list = new ArrayList<VendorLocDeptVO>();
		try {
			list = CommonBridge.getCommonServiceInstance()
					.getVendorLocationListFromCache(deptNo, subDeptNo,
							classField, comm, channelVal);
		} catch (Exception ex) {
			list = null;
		}
		// Iterator<VendorLocDeptVO> iterator = list.iterator();
		List<VendorLocationVO> jsfList = new ArrayList<VendorLocationVO>();
		vendorIdMap = new HashMap<String, VendorLocDeptVO>();
		// while(iterator.hasNext()){
		// VendorLocDeptVO vendorLocDeptVO = iterator.next();
		// VendorLocationVO baseJSFVO = new VendorLocationVO();
		// baseJSFVO.setVendorId(vendorLocDeptVO.getVendorLocationNumber().toString());
		// baseJSFVO.setName(vendorLocDeptVO.getLocationName());
		// baseJSFVO.setVendorLocationType(vendorLocDeptVO.getChannel());
		// jsfList.add(baseJSFVO);
		// vendorIdMap.put(baseJSFVO.getVendorId(), vendorLocDeptVO);
		// }
		if (list != null && list.size() > 0) {
			for (VendorLocDeptVO vendorLocDeptVO : list) {
				VendorLocationVO baseJSFVO = new VendorLocationVO();
				baseJSFVO.setVendorId(vendorLocDeptVO.getVendorLocationNumber()
						.toString());
				baseJSFVO.setName(vendorLocDeptVO.getLocationName());
				baseJSFVO.setVendorLocationType(vendorLocDeptVO.getChannel());

				if (CPSHelper.isNotEmpty(vendorLocDeptVO.getPrimCity())) {
					baseJSFVO.setPrimCity(vendorLocDeptVO.getPrimCity());
				}

				if (CPSHelper.isNotEmpty(vendorLocDeptVO.getPrimStateCd())) {
					baseJSFVO.setPrimStateCd(vendorLocDeptVO.getPrimStateCd());
				}

				jsfList.add(baseJSFVO);
				vendorIdMap.put(baseJSFVO.getVendorId(), vendorLocDeptVO);
			}
		}
		// return initSelect(clonedList);
		return jsfList;
	}

	public QuestionnarieVO getQuestionnarieVO() {
		return questionnarieVO;
	}

	public void setQuestionnarieVO(QuestionnarieVO questionnarieVO) {
		this.questionnarieVO = questionnarieVO;
	}

}
