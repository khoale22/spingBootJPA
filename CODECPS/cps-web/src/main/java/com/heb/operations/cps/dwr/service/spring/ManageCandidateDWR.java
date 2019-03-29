package com.heb.operations.cps.dwr.service.spring;
import com.heb.operations.cps.model.ManageCandidate;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.ui.framework.dwr.custom.SpringFormCorrelatedService;

@SpringFormCorrelatedService(formName=ManageCandidate.FORM_NAME)
public class ManageCandidateDWR extends ProductClassificationDWR {

	@Override
	protected ManageCandidate getForm() {
		return (ManageCandidate) getForm(ManageCandidate.FORM_NAME);
	}
	
	public boolean clearSearchResults(){
		if(!CPSHelper.isEmpty(getForm().getProducts())){
			getForm().getProducts().clear();
		}
		if(!CPSHelper.isEmpty(getForm().getProductsTemp())){
			getForm().getProductsTemp().clear();
		}
		/*
		 * Reset Batch Upload Switch
		 * @author khoapkl
		 */
		getForm().getCriteria().setBatchUploadSwitch(false);
		return true;
	}
	/**
	 * Clear Batch Upload Switch
	 * @return true
	 * @author khoapkl
	 */
	public boolean changeBatchUploadSwitch() {
		getForm().getCriteria().setBatchUploadSwitch(false);
		return true;
	}
}
