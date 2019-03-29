package com.heb.operations.cps.util;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import com.heb.operations.cps.vo.CaseVO;
import com.heb.operations.cps.vo.ConflictStoreVO;
import com.heb.operations.cps.vo.MRTUPCVO;
import com.heb.operations.cps.vo.MrtVO;
import com.heb.operations.cps.vo.PrintConflictVO;
import com.heb.operations.cps.vo.PrintVO;
import com.heb.operations.cps.vo.ProductClassificationVO;
import com.heb.operations.cps.vo.ProductVO;
import com.heb.operations.cps.vo.RetailVO;
import com.heb.operations.cps.vo.StoreVO;
import com.heb.operations.cps.vo.UPCVO;
import com.heb.operations.cps.vo.VendorVO;

public class PrintSummaryHelper {
	public static List<PrintVO> copyEntityToEntity(ProductVO object)
			throws IllegalAccessException, InvocationTargetException {
		return copyProductVOToPrintSummaryVO((ProductVO) object);
	}
	
	public static List<PrintVO> copyEntityToEntity(MrtVO object)
			throws IllegalAccessException, InvocationTargetException {
		return copyMrtVOToPrintSummaryVO((MrtVO) object);
	}
	
	public static List<PrintConflictVO> copyEntityToEntity(List<ConflictStoreVO> object)
	throws IllegalAccessException, InvocationTargetException {
		return copyConflictVOToPrintConflictVO((List<ConflictStoreVO>) object);
	}
	private static List<PrintVO> copyProductVOToPrintSummaryVO(
			ProductVO productVO) throws IllegalAccessException,
			InvocationTargetException {		
		//boolean flagsetParent = false;
		List<PrintVO> printVOResultList = new ArrayList<PrintVO>();
		PrintVO printVO = new PrintVO();
		if(null != productVO.getProdId()){
			printVO.setProductID(productVO.getProdId());
		}
		else{
			printVO.setProductID("");
		}
		printVO.setCreateDate(CPSHelper.getDateString(productVO
				.getWorkRequest().getRecordCreationTimestamp(), "MM/dd/yyyy"));
		ProductClassificationVO productClassificationVO = productVO
				.getClassificationVO();
		printVO.setDescription(productClassificationVO
				.getProdDescritpion());
		printVO.setRecordType(String.valueOf(productVO.getWorkRequest()
				.getIntentIdentifier()));
		
		if ("1".equalsIgnoreCase(printVO.getRecordType()))
			printVO.setRecordType("Introduce A UPC");
		else if ("2".equalsIgnoreCase(printVO.getRecordType()))
			printVO.setRecordType("Introduce a Case");
		else if ("3".equalsIgnoreCase(printVO.getRecordType()))
			printVO.setRecordType("Authorize Vendor");
		else if ("4".equalsIgnoreCase(printVO.getRecordType()))
			printVO.setRecordType("Setup an MRT");
		else if ("5".equalsIgnoreCase(printVO.getRecordType()))
			printVO.setRecordType("Bonus UPC for Existing Product");
		else if ("6".equalsIgnoreCase(printVO.getRecordType()))
			printVO.setRecordType("Size Change for an Existing Product");
		else if ("7".equalsIgnoreCase(printVO.getRecordType()))
			printVO
					.setRecordType("Associate a New UPC to an Existing Product");
		else if ("8".equalsIgnoreCase(printVO.getRecordType()))
			printVO.setRecordType("New Product");
		else if ("9".equalsIgnoreCase(printVO.getRecordType()))
			printVO.setRecordType("Introduce a Product");	
		else
			printVO.setRecordType("None");
		RetailVO retailVO = productVO.getRetailVO();
		if(CPSHelper.isNotEmpty(retailVO.getRetail()) && CPSHelper.isNotEmpty(retailVO.getRetailFor())){
			double retail = Double.valueOf(retailVO.getRetail());
			if(retail != 0){
				double retailFor = Double.valueOf(retailVO.getRetailFor());
				double rs = retailFor/retail;
				printVO.setRetailFor(String.valueOf(rs));
			} else {
				printVO.setRetailFor(retailVO.getRetailFor());
			}
		} else {
		printVO.setRetailFor(retailVO.getRetailFor());
		}
		printVO.setSuggRetailFor(retailVO.getSuggforPrice());		
		List<UPCVO> upcList = productVO.getUpcVO();	
		for (UPCVO upcvo : upcList) {
			if (upcList.size() == 1) {
				printVO.setCaseUPC(upcvo.getUnitUpc());
				printVO.setSize(upcvo.getSize());
			} else {
				printVO.setCaseUPC("Multiple");
				printVO.setSize("Multiple");
			}
			break;
		}			
		printVO.setParentProductFlag(productVO.isProductMainFlag());		
		List<CaseVO> caseVOList = productVO.getCaseVOs();
		for (CaseVO caseVO : caseVOList) {			
			List<VendorVO> vendorVOList = caseVO.getVendorVOs();
			for (VendorVO vendorVO : vendorVOList) {	
				printVO.setStore(null);							
				printVO.setCostGroup(null);
				printVO.setListCost("");
				printVO.setVendorNumber(CPSHelper.getTrimmedValue(String.valueOf(
					vendorVO.getVendorLocNumber())));
				
				printVO.setSource(vendorVO.getChannel());
				printVO.setMasterPack(caseVO.getMasterPack());
				printVO.setShipPack(caseVO.getShipPack());

				printVO.setVendor((vendorVO.getVendorLocation() + " ["
						+ vendorVO.getVendorLocationVal() + "]"));

				if ("WHS".equalsIgnoreCase(vendorVO.getChannel())
						||"BOTH" .equalsIgnoreCase(vendorVO.getChannel())) {
					if (null != caseVO.getShipPack()
							&& !("0").equalsIgnoreCase(caseVO.getShipPack())
							&& CPSHelper.isNotEmpty(vendorVO.getListCost())
							&& !("").equals(caseVO.getShipPack().trim())) {
						double unitCost = Double.parseDouble(vendorVO
								.getListCost())
								/ Integer.parseInt(caseVO.getShipPack());
						printVO.setUnitCost(String.valueOf(unitCost));
					} else {
						printVO.setUnitCost("");
					}
					printVO.setListCost(vendorVO.getListCost());
				} else {
					if (null != caseVO.getShipPack()
							&& !("0").equalsIgnoreCase(caseVO.getMasterPack())
							&& CPSHelper.isNotEmpty(vendorVO.getListCost())
							&& !("").equals(caseVO.getMasterPack().trim())) {
						double unitCost = Double.parseDouble(vendorVO
								.getListCost())
								/ Integer.parseInt(caseVO.getMasterPack());
						printVO.setUnitCost(String.valueOf(unitCost));
					} else {
						printVO.setUnitCost("");
					}
				}
				if (!"".equalsIgnoreCase(printVO.getUnitCost())
						&& null != printVO.getUnitCost()
						&& null != printVO.getRetailFor()
						&& !"".equalsIgnoreCase(printVO.getRetailFor())
						&& Double.valueOf(printVO.getRetailFor())
								.doubleValue() != 0) {
					double retailFor = Double.valueOf(
							printVO.getRetailFor()).doubleValue();
					double unitCost = Double.valueOf(
							printVO.getUnitCost()).doubleValue();
					double margin = 100*(retailFor - unitCost) / retailFor;
					printVO.setMargin(margin + "%");
				} else {
					printVO.setMargin("0.0%");
				}	
				printVO.setCaseID(String.valueOf(CPSHelper.getLongValue(caseVO
						.getCaseUPC())));
				//1198. include products also				
				if(CPSHelper.isEmpty(vendorVO.getChannel())){
					if("D".equalsIgnoreCase(vendorVO.getVendorLocationTypeCode())){
						vendorVO.setChannel("DSD");
					}else if("V".equalsIgnoreCase(vendorVO.getVendorLocationTypeCode())){
						vendorVO.setChannel("WHS");
					}
				}				
				if(!vendorVO.getCostGroups().isEmpty()){					
						List<StoreVO> storeVOList = vendorVO.getPrintStores();
						if(null != storeVOList && !storeVOList.isEmpty()){
							for(String codeGroup : vendorVO.getCostGroups()){	
								printVO.setStore(null);							
								printVO.setCostGroup(codeGroup);
								for(StoreVO storeVO : storeVOList){									
									if(storeVO.getCostGroup().trim().equals(codeGroup.trim()) && !storeVO.isStoreRemoved()){
										printVO.setListCost(storeVO.getListCost());
										String store = storeVO.getStore();	
										if(null != printVO.getStore()){
											printVO.setStore(printVO.getStore() + store + ",");
										} else {
											printVO.setStore(store + ",");										
										}
									}									
								}
								if (printVO.getStore() != null) {
									printVO.setStore(printVO.getStore().substring(0,
											printVO.getStore().lastIndexOf(",")));								
								}
								/*if(!flagsetParent){
									printVO.setParentProductFlag(productVO.isProductMainFlag());
									flagsetParent = true;
								} else {
									printVO.setParentProductFlag(false);
								}*/
								PrintVO returnPrintVO = new PrintVO();
								BeanUtils.copyProperties(returnPrintVO, printVO);
								printVOResultList.add(returnPrintVO);
							}
						} else {
							List<StoreVO> authorizedStores = vendorVO.getAuthorizedStores();
							if (null != authorizedStores && !authorizedStores.isEmpty()){
								for(String codeGroup : vendorVO.getCostGroups()){
									printVO.setStore(null);							
									printVO.setCostGroup(codeGroup);
									for(StoreVO storeVO : authorizedStores){	
										if(vendorVO.getNewDataSw() == 'Y'){
											if(storeVO.getCostGroup().trim().equals(codeGroup.trim())&& !storeVO.isStoreRemoved()){
												printVO.setListCost(storeVO.getListCost());
												String store = storeVO.getStore();	
												if(null != printVO.getStore()){
													printVO.setStore(printVO.getStore() + store + ",");
												} else {
													printVO.setStore(store + ",");
												}
											}
										} else {
											if(storeVO.getCostGroup().trim().equals(codeGroup.trim())){
												printVO.setListCost(storeVO.getListCost());
												String store = storeVO.getStore();	
												if(null != printVO.getStore()){
													printVO.setStore(printVO.getStore() + store + ",");
												} else {
													printVO.setStore(store + ",");
												}
											}
										}
									}
									if (printVO.getStore() != null) {
										printVO.setStore(printVO.getStore().substring(0,
												printVO.getStore().lastIndexOf(",")));								
									}
									/*if(!flagsetParent){
										printVO.setParentProductFlag(productVO.isProductMainFlag());
										flagsetParent = true;
									} else {
										printVO.setParentProductFlag(false);
									}*/
									PrintVO returnPrintVO = new PrintVO();
									BeanUtils.copyProperties(returnPrintVO, printVO);
									printVOResultList.add(returnPrintVO);
								}
							}						
						}
				} else {
					/*if(!flagsetParent){
						printVO.setParentProductFlag(productVO.isProductMainFlag());
						flagsetParent = true;
					} else {
						printVO.setParentProductFlag(false);
					}*/
					PrintVO returnPrintVO = new PrintVO();
					BeanUtils.copyProperties(returnPrintVO, printVO);
					printVOResultList.add(returnPrintVO);
				}
			}
		}
		return printVOResultList;
	}
	
	private static List<PrintVO> copyMrtVOToPrintSummaryVO(
			MrtVO mrtVO) throws IllegalAccessException,
			InvocationTargetException {	
//		boolean flagsetParent = false;
		List<PrintVO> printVOResultList = new ArrayList<PrintVO>();
		PrintVO printVO = new PrintVO();
		
		// No Product ID for MRT
		printVO.setProductID("N/A"); 
		printVO.setCreateDate(CPSHelper.getDateString(mrtVO
				.getWorkRequest().getRecordCreationTimestamp(), "MM/dd/yyyy"));
		printVO.setCaseID(String.valueOf(mrtVO
				.getCaseVO().getCaseUPC()));
		printVO.setDescription(mrtVO
				.getCaseVO().getCaseDescription());  
		printVO.setRecordType(String.valueOf(mrtVO.getWorkRequest()
				.getIntentIdentifier()));
		printVO.setRecordType("Setup an MRT"); // check ???
		
		// Actual Retail N/A for MRT
		printVO.setRetailFor("");
		
		// Suggested Retail N/A for MRT
		printVO.setSuggRetailFor("");
		
		// UPC - N/A for MRT (Case UPC of MRT mapped to Case ID field of Summary)
		// printVO.setCaseUPC(mrtVO.getCaseVO().getCaseUPC());
		printVO.setCaseUPC("");
		
		// Size N/A for MRT
		printVO.setSize("");
		
		List<MRTUPCVO> mrtUPCVOList =  mrtVO.getMrtVOs();
		Integer totalSellableUnits = 0;
		for(MRTUPCVO mrtUPCVO : mrtUPCVOList){
			if(!CPSHelper.isEmpty(mrtUPCVO.getSellableUnits())){			
				if(mrtUPCVO.isSellableUnitsCount()){
					totalSellableUnits +=Integer.valueOf(mrtUPCVO.getSellableUnits());
				}
			}
		}
		//printVO.setSellableUnits(String.valueOf(totalSellableUnits));		
		printVO.setParentProductFlag(mrtVO.isMRTParentFlag());
		CaseVO caseVO = mrtVO.getCaseVO();
		List<VendorVO> vendorVOList = caseVO.getVendorVOs();
		boolean flagSetSellableUnits = false;
		for (VendorVO vendorVO : vendorVOList) {	
			printVO.setStore(null);							
			printVO.setCostGroup(null);
			printVO.setListCost("");
			printVO.setSource(caseVO.getChannelVal());
			printVO.setMasterPack(caseVO.getMasterPack());
			printVO.setShipPack(caseVO.getShipPack());
			printVO.setVendor((vendorVO.getVendorLocation() + " ["
					+ vendorVO.getVendorLocationVal() + "]"));

			if (("WHS").equalsIgnoreCase(vendorVO.getChannel())
					|| ("BOTH").equalsIgnoreCase(vendorVO.getChannel())) {
				if (null != caseVO.getShipPack()
						&& !("0").equalsIgnoreCase(caseVO.getShipPack())
						&& CPSHelper.isNotEmpty(vendorVO.getListCost())
						&& !("").equals(caseVO.getShipPack().trim())) {
					double unitCost = Double.parseDouble(vendorVO
							.getListCost())
							/ Integer.parseInt(caseVO.getShipPack());
					printVO.setUnitCost(String.valueOf(unitCost));
				} else {
					printVO.setUnitCost("");
				}
				printVO.setListCost(vendorVO.getListCost());
			} else {
				if (null != caseVO.getShipPack()
						&& !("0").equalsIgnoreCase(caseVO.getMasterPack())
						&& CPSHelper.isNotEmpty(vendorVO.getListCost())
						&& !("").equals(caseVO.getMasterPack().trim())) {
					double unitCost = Double.parseDouble(vendorVO
							.getListCost())
							/ Integer.parseInt(caseVO.getMasterPack());
					printVO.setUnitCost(String.valueOf(unitCost));
				} else {
					printVO.setUnitCost("");
				}
			}			
			printVO.setVendorNumber(CPSHelper.getTrimmedValue(String.valueOf(
				vendorVO.getVendorLocNumber())));
			
			// Margin N/A to MRT
			printVO.setMargin("0.0%");
			
			// set CostGroup and Store
			if(!vendorVO.getCostGroups().isEmpty()){
				List<StoreVO> storeVOList = vendorVO.getPrintStores();
				if (null != storeVOList && !storeVOList.isEmpty()) {					
					for(String codeGroup : vendorVO.getCostGroups()){
						if(!flagSetSellableUnits){
							printVO.setSellableUnits(String.valueOf(totalSellableUnits));
							flagSetSellableUnits = true;
						} else {
							printVO.setSellableUnits("");
						}
						printVO.setStore(null);	
						printVO.setCostGroup(codeGroup);
						for (StoreVO storeVO : storeVOList) {
							String store = storeVO.getStore();
							if(storeVO.getCostGroup().trim().equals(codeGroup.trim())&& !storeVO.isStoreRemoved()){
								printVO.setListCost(storeVO.getListCost());
								if (printVO.getStore() != null) {								
									printVO.setStore(printVO.getStore() + store + ",");
								} else {								
									printVO.setStore(store + ",");
								}
							}
						}
						if (printVO.getStore() != null) {
							printVO.setStore(printVO.getStore().substring(0,
									printVO.getStore().lastIndexOf(",")));								
						}
						/*if(!flagsetParent){
							printVO.setParentProductFlag(mrtVO.isMRTParentFlag());
							flagsetParent = true;
						} else {
							printVO.setParentProductFlag(false);
						}*/
						PrintVO returnPrintVO = new PrintVO();
						BeanUtils.copyProperties(returnPrintVO, printVO);
						printVOResultList.add(returnPrintVO);
					}					
				} else {
					List<StoreVO> authorizedStores = vendorVO.getAuthorizedStores();
					if (null != authorizedStores && !authorizedStores.isEmpty()) {						
						for(String codeGroup : vendorVO.getCostGroups()){
							if(!flagSetSellableUnits){
								printVO.setSellableUnits(String.valueOf(totalSellableUnits));
								flagSetSellableUnits = true;
							} else {
								printVO.setSellableUnits("");
							}
							printVO.setStore(null);	
							printVO.setCostGroup(codeGroup);
							for (StoreVO storeVO : authorizedStores) {
								String store = storeVO.getStore();
								if(vendorVO.getNewDataSw() == 'Y'){
									if(storeVO.getCostGroup().trim().equals(codeGroup.trim()) && !storeVO.isStoreRemoved()){
										printVO.setListCost(storeVO.getListCost());
										if (printVO.getStore() != null) {								
											printVO.setStore(printVO.getStore() + store + ",");
										} else {								
											printVO.setStore(store + ",");
										}
									}
								} else {
									if(storeVO.getCostGroup().trim().equals(codeGroup.trim())){
										printVO.setListCost(storeVO.getListCost());
										if (printVO.getStore() != null) {								
											printVO.setStore(printVO.getStore() + store + ",");
										} else {								
											printVO.setStore(store + ",");
										}
									}
								}
							}
							if (printVO.getStore() != null) {
								printVO.setStore(printVO.getStore().substring(0,
										printVO.getStore().lastIndexOf(",")));								
							}
							/*if(!flagsetParent){
								printVO.setParentProductFlag(mrtVO.isMRTParentFlag());
								flagsetParent = true;
							} else {
								printVO.setParentProductFlag(false);
							}*/
							PrintVO returnPrintVO = new PrintVO();
							BeanUtils.copyProperties(returnPrintVO, printVO);
							printVOResultList.add(returnPrintVO);
						}						
					}
				}				
			} else {
				/*if(!flagsetParent){
					printVO.setParentProductFlag(mrtVO.isMRTParentFlag());
					flagsetParent = true;
				} else {
					printVO.setParentProductFlag(false);
				}*/
				PrintVO returnPrintVO = new PrintVO();
				if(!flagSetSellableUnits){
					printVO.setSellableUnits(String.valueOf(totalSellableUnits));
					flagSetSellableUnits = true;
				}				
				BeanUtils.copyProperties(returnPrintVO, printVO);
				printVOResultList.add(returnPrintVO);
			}
		}
		return printVOResultList;
	}
	
	private static List<PrintConflictVO> copyConflictVOToPrintConflictVO(List<ConflictStoreVO> objects)
								throws IllegalAccessException,InvocationTargetException {	
		List<PrintConflictVO> printVOResults = new ArrayList<PrintConflictVO>();
		for(ConflictStoreVO object:objects){
			PrintConflictVO printConflictVO = new PrintConflictVO();
			printConflictVO.setCaseDescription(object.getCaseDescription());
			printConflictVO.setUnitUPC(object.getUnitUPC());
			printConflictVO.setConflictCostGroup(object.getConflictCostGroup1());
			printConflictVO.setConflictStoreId(String.valueOf(object.getConflictStoreId()));
			printConflictVO.setConflictVNumber1(object.getConflictVNumber1());
			printConflictVO.setConflictVName1(object.getConflictVName1());
			printConflictVO.setConflictListCost1(object.getConflictListCost1());
			printConflictVO.setConflictVNumber2(object.getConflictVNumber2());
			printConflictVO.setConflictVName2(object.getConflictVName2());
			printConflictVO.setConflictListCost2(object.getConflictListCost2());
			printVOResults.add(printConflictVO);
		}
		
		return printVOResults;
	}
}
