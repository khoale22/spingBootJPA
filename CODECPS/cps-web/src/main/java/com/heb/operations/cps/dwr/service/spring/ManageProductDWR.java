package com.heb.operations.cps.dwr.service.spring;

import com.heb.operations.cps.model.ManageProduct;
import com.heb.operations.ui.framework.dwr.custom.SpringFormCorrelatedService;

@SpringFormCorrelatedService(formName = ManageProduct.FORM_NAME)
public class ManageProductDWR extends ProductClassificationDWR {
	@Override
	protected ManageProduct getForm() {
		return (ManageProduct) getForm(ManageProduct.FORM_NAME);
	}
}
