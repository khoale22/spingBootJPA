package com.heb.operations.cps.util;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.heb.jaf.security.HebLdapUserService;
import com.heb.jaf.security.UserInfo;
import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.business.framework.vo.VendorLocationVO;
import com.heb.operations.business.framework.vo.WareHouseVO;
import com.heb.operations.cps.ejb.webservice.WarehouseService.GetWarehouseListByVendor_Request.VendorList;
import com.heb.operations.cps.services.AddNewCandidateService;
import com.heb.operations.cps.services.CommonService;
import com.heb.operations.cps.vo.CaseVO;
import com.heb.operations.cps.vo.CommentsVO;
import com.heb.operations.cps.vo.MRTUPCVO;
import com.heb.operations.cps.vo.MrtVO;
import com.heb.operations.cps.vo.PharmacyVO;
import com.heb.operations.cps.vo.PointOfSaleVO;
import com.heb.operations.cps.vo.PrintFormVO;
import com.heb.operations.cps.vo.ProductClassificationVO;
import com.heb.operations.cps.vo.ProductVO;
import com.heb.operations.cps.vo.RetailVO;
import com.heb.operations.cps.vo.ScaleVO;
import com.heb.operations.cps.vo.ShelfEdgeVO;
import com.heb.operations.cps.vo.StoreVO;
import com.heb.operations.cps.vo.UPCKitVO;
import com.heb.operations.cps.vo.UPCVO;
import com.heb.operations.cps.vo.VendorVO;
import com.heb.operations.odc.templateapp.common.util.CustomResourceLocator;
import com.lowagie.text.BadElementException;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class PrintFormHelper {
	private static final Logger LOG = Logger.getLogger(PrintFormHelper.class);

	private static void setMRTSection(PrintFormVO printFormVO, Document document)
			throws DocumentException {
		PdfPTable table = new PdfPTable(5);
		PdfPCell cell8 = null;
		Phrase phrase = new Phrase("Unit UPC", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);

		phrase = new Phrase("Sellable Units", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);
		phrase = new Phrase("Description", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);
		phrase = new Phrase("Item Code", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);
		phrase = new Phrase("Needs Approval", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);

		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);

		phrase = new Phrase("0000123456789", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);

		phrase = new Phrase("10", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);
		phrase = new Phrase("dummy product", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);
		phrase = new Phrase("112345", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);
		phrase = new Phrase("No", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);

		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);

		phrase = new Phrase("1111123456789", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);

		phrase = new Phrase("11", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);
		phrase = new Phrase("dummy product 2", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);
		phrase = new Phrase("67890", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);
		phrase = new Phrase("Yes", PrintFormHelper.labelFont);
		cell8 = new PdfPCell(phrase);

		cell8.setBackgroundColor(Color.YELLOW);
		cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell8);
		document.add(table);
	}

	private static void createMRTPDF(PrintFormVO printFormVO, Document document)
			throws DocumentException {

		// / HEADER - HEB Candidate Introduction
		PdfPTable table = new PdfPTable(3);
		Font font = new Font(Font.TIMES_ROMAN, 10);
		Font headingFont = new Font(Font.TIMES_ROMAN, 13);
		PdfPCell cell = new PdfPCell(new Paragraph(
				"H-E-B MRT Candidate Introduction", headingFont));
		cell.setColspan(3);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setBorder(0);
		table.addCell(cell);

		// PdfPCell cellDate = new PdfPCell(new Phrase("Created on: "
		// + CPSHelper.getDateAsString(new Date()), font));
		PdfPCell cellDate = new PdfPCell(new Phrase("Created on: "
				+ CPSHelper.getDateAsString(printFormVO.getCreateOn()), font));
		cellDate.setColspan(3);
		cellDate.setHorizontalAlignment(Element.ALIGN_CENTER);
		cellDate.setBorder(0);
		table.addCell(cellDate);
		// Header END

		// VENDOR SECTION.
		setVendorTable(printFormVO, table, document);

		table = addLabel("UPC Information");
		document.add(table);
		setMRTSection(printFormVO, document);
		document.add(addLabel("Case Pack"));
		setCasePackTable(printFormVO, document);
		setComments(printFormVO, document);
		setHebBuyer(printFormVO, document);
		setHebSupplyChain(printFormVO, document);
		setHebAdmin(printFormVO, document);
	}

	private static PrintFormVO generatePDFDocumentDummy(
			PrintFormVO printFormVO, String id) {

		FileOutputStream fos = null;
		try {

			Document document = new Document();
			document.setPageSize(PageSize.A4);
			document.setMargins(0, 0, 10, 10);

			PdfWriter.getInstance(document, new FileOutputStream(
					"iTextExampleMRT.pdf"));

			document.open();

			createMRTPDF(printFormVO, document);

			document.close();
		} catch (Exception ex) {
			// LOG.fatal("Exception:-", ex);
		} finally {
			if (fos != null) {
				try {
					fos.close();
				} catch (Exception ex) {
					// LOG.fatal("Exception:-", ex);
				}
			}
		}
		return printFormVO;
	}

	public static List<PrintFormVO> copyEntityToEntityMRT(MrtVO object,
			String id, HttpServletRequest req, HttpServletResponse resp,
			CommonService commonLocal, AddNewCandidateService addNewCandLocal,
			HebLdapUserService hebLdapUserService)
			throws IllegalAccessException, InvocationTargetException {
		return copyProductVOToPrintFormVOMRT(object, id, req, resp,
				commonLocal, addNewCandLocal, hebLdapUserService);
	}

	public static List<PrintFormVO> copyEntityToEntity(ProductVO object,
			String id, HttpServletRequest req, HttpServletResponse resp,
			CommonService commonLocal, AddNewCandidateService addNewCandLocal,
			HebLdapUserService hebLdapUserService)
			throws IllegalAccessException, InvocationTargetException {
		return copyProductVOToPrintFormVO((ProductVO) object, id, req, resp,
				commonLocal, addNewCandLocal, hebLdapUserService);
	}

	private static String getTotalVolumn(ProductVO productVO) {
		String retVal = "";
		List<UPCVO> upcs = productVO.getUpcVO();
		if (CPSHelper.isNotEmpty(upcs)) {
			for (UPCVO upcvo : upcs) {
				if (!upcvo.isBonus()
						&& CPSHelper.isNotEmpty(upcvo.getUnitSize())) {
					retVal = upcvo.getUnitSize();
				}
			}
		}
		return retVal;
	}

	public static String getStringValue(final Number value) {
		if (null != value) {
			String nbr = value.toString();
			int index = nbr.indexOf(".");
			if (index != -1) {
				nbr = nbr.substring(0, index);
			}
			return nbr;
		}
		return null;
	}

	private static String getSeasonality(String code,
			List<BaseJSFVO> seasonalityList) {
		String retVal = null;
		if (CPSHelper.isNotEmpty(code)) {
			for (BaseJSFVO baseJSFVO : seasonalityList) {
				if (baseJSFVO != null
						&& baseJSFVO.getId().equalsIgnoreCase(code)) {
					retVal = baseJSFVO.getName();
					break;
				}
			}
		}
		return retVal;
	}

	private static String get1Touch(String code, List<BaseJSFVO> touchList) {
		String retVal = null;
		if (CPSHelper.isNotEmpty(code)) {
			for (BaseJSFVO baseJSFVO : touchList) {
				if (baseJSFVO != null) {
					if (baseJSFVO.getId().equalsIgnoreCase(code)) {
						retVal = baseJSFVO.getName();
						break;
					}
				}
			}
		}
		return retVal;
	}

	private static List<PrintFormVO> copyProductVOToPrintFormVOMRT(
			MrtVO object, String id, HttpServletRequest req,
			HttpServletResponse resp, CommonService commonBean,
			AddNewCandidateService addNewCandLocal,
			HebLdapUserService hebLdapUserService)
			throws IllegalAccessException, InvocationTargetException {
		List<PrintFormVO> printFormList = new ArrayList<PrintFormVO>();
		PrintFormVO printFormVO = new PrintFormVO();
		// printFormVO.setTotalVolumn(getTotalVolumn(object));
		/*
		 * ProductClassificationVO productClassificationVO = object
		 * .getClassificationVO();
		 */
		/*
		 * printFormVO
		 * .setBuyerName(productClassificationVO.getBdmName().substring(0,
		 * productClassificationVO.getBdmName().indexOf("[")));
		 * printFormVO.setBuyerNumber(productClassificationVO.getBdmName()
		 * .substring( productClassificationVO.getBdmName().indexOf("[") + 1,
		 * productClassificationVO.getBdmName().lastIndexOf("]")));
		 * printFormVO.setBrand(productClassificationVO.getBrandName() + " [" +
		 * productClassificationVO.getBrand() + "]");
		 * printFormVO.setCommodity(object
		 * .getClassificationVO().getCommodityName() + " [" +
		 * object.getClassificationVO().getCommodity() + "]");
		 * printFormVO.setSubCommodity
		 * (object.getClassificationVO().getSubCommodityName());
		 * printFormVO.setProductDescription(productClassificationVO
		 * .getProdDescritpion()); printFormVO
		 * .setProductType(productClassificationVO.getProductTypeName());
		 * printFormVO.setType(productClassificationVO.getMerchandizeName());
		 */

		/**
		 * *** ps_intnt_cd *** 1 UPC Introduce A UPC 100 2 Case Introduce a Case
		 * 101 3 Vendor Authorize Vendor 102 4 MRT Setup an MRT 103 5 Bonus
		 * Bonus UPC for Existing Product 104 6 NewSiz Size Change for an
		 * Existing Product 105 7 Associ Associate a New UPC to an Existing
		 * Product 106 8 NewPdt New Product 107 9 Prod Introduce a Product 108
		 */

		printFormVO.setIntent(object.getWorkRequest().getIntentIdentifier());
		printFormVO.setCreateOn(object.getCreateOn());
		printFormVO.setProductType("Sellable");
		StringBuilder bufBuilder = new StringBuilder();
		String bufferTempPrint = "";
		int count = 0;
		int indexComma = 1;
		for (MRTUPCVO mrtupcvo : object.getComments()) {
			if (mrtupcvo != null) {
				// thang.dang fix defect 1489
				String bufferTemp = "";
				// if(mrtupcvo.getProductVO().getNewDataSw() == 'Y'){
				bufferTemp += mrtupcvo.getSellableUnits();
				bufferTemp += " - ";
				bufferTemp += mrtupcvo.getUnitUPC();
				bufferTemp += "-";
				bufferTemp += mrtupcvo.getUnitUPCCheckDigit();
				bufferTemp += ", ";
				bufferTempPrint += bufferTemp;
				if (bufferTempPrint.lastIndexOf(",")
						/ CPSConstants.weightDSD_StoreListCost == indexComma) {
					bufBuilder.append("\n" + bufferTemp);
					// bufferTempPrint = buffer;
					indexComma++;
				} else {
					bufBuilder.append(bufferTemp);
					// bufferTempPrint = buffer;
				}
				count++;
			}
			// }
		}
		String buffer = bufBuilder.toString();
		String finalComment = "";
		if (count > 25) {
			finalComment = CPSConstants.COMENT_PRINTFORMMRT_GREATERTHAN_25UNITUPC;
		} else {
			if (CPSHelper.isNotEmpty(buffer)) {
				finalComment = buffer.trim();
				finalComment = finalComment.substring(0,
						finalComment.lastIndexOf(","));
			}
		}
		if (finalComment.length() > 80) {
			finalComment = "\n" + finalComment;
		}
		printFormVO.setComments(finalComment);

		int index = 1;
		List<CaseVO> caseVOList = new ArrayList<CaseVO>(1);
		caseVOList.add(object.getCaseVO());
		for (CaseVO caseVO : caseVOList) {
			if (caseVO != null) {
				printFormVO.setItemSize(caseVO.getItemSizeQty());
				printFormVO.setCodeDate(caseVO.isCodeDate());
				// Fix 1247
				printFormVO.setCaseUPC(CPSHelper.getUPCPrintFormat(caseVO
						.getCaseUPC()));
				printFormVO.setCaseDescription(caseVO.getCaseDescription());
				printFormVO.setChannel(caseVO.getChannelVal());

				if (CPSHelper.isNotEmpty(caseVO.getGuaranteetoStoreDays())) {
					String gDays = caseVO.getGuaranteetoStoreDays().trim();
					if ("0".equals(gDays)) {
						gDays = "";
					}
					printFormVO.setGuaranteeToStore(gDays);
				} else {
					printFormVO.setGuaranteeToStore("");
				}

				if (CPSHelper.isNotEmpty(caseVO.getInboundSpecificationDays())) {
					String iDays = caseVO.getInboundSpecificationDays().trim();
					if ("0".equals(iDays)) {
						iDays = "";
					}
					printFormVO.setInboundSpec(iDays);
				} else {
					printFormVO.setInboundSpec("");
				}

				if (CPSHelper.isNotEmpty(caseVO.getReactionDays())) {
					String rDays = caseVO.getReactionDays().trim();
					if ("0".equals(rDays)) {
						rDays = "";
					}
					printFormVO.setReaction(rDays);
				} else {
					printFormVO.setReaction("");
				}

				if (CPSHelper.isNotEmpty(caseVO.getMaxShelfLifeDays())) {
					String mslDays = caseVO.getMaxShelfLifeDays().trim();
					if ("0".equals(mslDays)) {
						mslDays = "";
					}
					printFormVO.setMaxShelfLife(mslDays);
				} else {
					printFormVO.setMaxShelfLife("");
				}

				printFormVO.setMasterPackCube(caseVO.getMasterCubeFormatted());
				printFormVO.setMasterPackHeight(caseVO
						.getMasterHeightFormatted());
				printFormVO.setMasterPackLength(caseVO
						.getMasterLengthFormatted());
				printFormVO.setMasterPackWeight(caseVO
						.getMasterWeightFormatted());
				printFormVO
						.setMasterPackWidth(caseVO.getMasterWidthFormatted());
				printFormVO.setMasterPack(caseVO.getMasterPack());
				printFormVO.setShipPackCube(caseVO.getShipCubeFormatted());
				printFormVO.setShipPackHeight(caseVO.getShipHeightFormatted());
				printFormVO.setShipPackLength(caseVO.getShipLengthFormatted());
				printFormVO.setShipPackWeight(caseVO.getShipWeightFormatted());
				printFormVO.setShipPackWidth(caseVO.getShipWidthFormatted());
				printFormVO.setShipPack(caseVO.getShipPack());
				printFormVO.setOneTouchType(get1Touch(caseVO.getOneTouch(),
						caseVO.getTouchTypeList()));
				printFormVO.setVariableWeight(caseVO.isVariableWeight());
				printFormVO.setCatchWeight(caseVO.isCatchWeight());

				if (CPSHelper.isNotEmpty(caseVO.getItemCategory())) {
					for (BaseJSFVO baseJSFVO : caseVO.getItemCategoryList()) {
						if (baseJSFVO.getId().equalsIgnoreCase(
								caseVO.getItemCategory())) {
							printFormVO.setItemCategory(baseJSFVO.getName());
						}
					}
				} else {
					printFormVO.setItemCategory("");
				}
				// DRU
				if (caseVO.isDsplyDryPalSw()) {
					if ("7".equals(caseVO.getSrsAffTypCd())) {
						printFormVO.setDRP(true);
						printFormVO.setRRP(false);
					} else if ("9".equals(caseVO.getSrsAffTypCd())) {
						printFormVO.setDRP(false);
						printFormVO.setRRP(true);
					}
					printFormVO.setRowsFacing(caseVO.getProdFcngNbr());
					printFormVO.setRowsDeep(caseVO.getProdRowDeepNbr());
					printFormVO.setRowsHigh(caseVO.getProdRowHiNbr());
					printFormVO.setOrientation(caseVO.getNbrOfOrintNbr());
				} else {
					printFormVO.setDRP(false);
					printFormVO.setRRP(false);
					printFormVO.setRowsFacing("");
					printFormVO.setRowsDeep("");
					printFormVO.setRowsHigh("");
					printFormVO.setOrientation(null);
				}
				// END DRU
				List<VendorVO> vendorVOList = caseVO.getVendorVOs();
				List<VendorVO> vendorVOListPrints = new ArrayList<VendorVO>();
				for (VendorVO vendorVO : vendorVOList) {
					if (vendorVO != null && vendorVO.isEditable()) {
						vendorVOListPrints.add(vendorVO);
					}
				}
				for (VendorVO vendorVO : vendorVOListPrints) {
					// Fix 1052. Add only new vendor to printForm
					if (vendorVO != null && vendorVO.isEditable()) {
						printFormVO.setGuaranteedSale(vendorVO
								.isGuarenteedSale());
						printFormVO.setDealOffered(vendorVO.isDealOffered());
						printFormVO.setImportd(vendorVO.getImportd());
						printFormVO.setVendorName(vendorVO.getVendorLocation());
						printFormVO.setVendorNumber(vendorVO
								.getVendorLocationVal());
						printFormVO.setOriginalVendorNumber(vendorVO
								.getOriginalVendorLocNumber() + "");

						// Fix 1197
						String vnID = null;
						if (object.getWorkRequest() != null) {
							vnID = object.getWorkRequest()
									.getRecordCreationUserIdentifier();
						}
						if (vnID != null) {
							// String createdID = object.getWorkRequest()
							// .getCandUpdtUID().toUpperCase();
							UserInfo userInfo = null;
							if (CPSHelper.isNotEmpty(vnID)) {
								try {
									userInfo = (UserInfo) hebLdapUserService
											.getUserInfo(vnID);
								} catch (UsernameNotFoundException e) {
									LOG.error(e.getMessage(), e);
								} catch (DataAccessException e) {
									LOG.error(e.getMessage(), e);
								}
							}
							vnID = vnID.toUpperCase();
							if (vnID.startsWith("VB") || vnID.startsWith("V90")) {
								// Created by Vendor.
								if (null != userInfo) {
									if (CPSHelper.isNotEmpty(userInfo
											.getAttributeValue("sn") != null)) {
										printFormVO
												.setContactName(CPSHelper
														.getTrimmedValue(userInfo
																.getAttributeValue("sn"))
														+ ", "
														+ CPSHelper
																.getTrimmedValue(userInfo
																		.getAttributeValue("givenName")));
									} else {
										printFormVO.setContactName("");
									}
								} else {
									if (object.getWorkRequest() != null) {
										if (CPSHelper.isNotEmpty(object
												.getWorkRequest()
												.getCandUpdtFirstName())) {
											printFormVO
													.setContactName(CPSHelper
															.getTrimmedValue(object
																	.getWorkRequest()
																	.getCandUpdtLastName())
															+ ", "
															+ CPSHelper
																	.getTrimmedValue(object
																			.getWorkRequest()
																			.getCandUpdtFirstName()));
										} else {
											printFormVO
													.setContactName(CPSHelper
															.getTrimmedValue(object
																	.getWorkRequest()
																	.getCandUpdtLastName()));
										}
									}
								}
								if (object.getWorkRequest() != null
										&& object.getWorkRequest()
												.getVendorPhoneAreaCd() != null) {
									printFormVO.setContactPhone("("
											+ object.getWorkRequest()
													.getVendorPhoneAreaCd()
											+ ") "
											+ object.getWorkRequest()
													.getVendorPhoneNumber());
								} else if (object.getWorkRequest() != null) {
									printFormVO.setContactPhone(object
											.getWorkRequest()
											.getVendorPhoneNumber());
								}
								printFormVO.setContactEmail(object
										.getWorkRequest().getVendorEmail());
							} else {
								if (null == userInfo) {
									if (object.getWorkRequest() != null) {
										if (CPSHelper.isNotEmpty(object
												.getWorkRequest()
												.getCandUpdtFirstName())) {
											printFormVO
													.setContactName(CPSHelper
															.getTrimmedValue(object
																	.getWorkRequest()
																	.getCandUpdtLastName())
															+ ", "
															+ CPSHelper
																	.getTrimmedValue(object
																			.getWorkRequest()
																			.getCandUpdtFirstName()));
										} else {
											printFormVO
													.setContactName(CPSHelper
															.getTrimmedValue(object
																	.getWorkRequest()
																	.getCandUpdtLastName()));
										}
									}
								} else {
									if (CPSHelper.isNotEmpty(userInfo
											.getAttributeValue("sn"))) {
										printFormVO
												.setContactName(CPSHelper
														.getTrimmedValue(userInfo
																.getAttributeValue("sn"))
														+ ", "
														+ CPSHelper
																.getTrimmedValue(userInfo
																		.getAttributeValue("givenName")));
									}
								}
							}
						}

						if (CPSHelper.isNotEmpty(vendorVO.getCostOwner())
								&& CPSHelper.isNotEmpty(vendorVO
										.getCostOwnerVal())) {
							if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwner().trim())
									&& !"null".equalsIgnoreCase(vendorVO
											.getCostOwnerVal().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwner()
										+ " ["
										+ vendorVO.getCostOwnerVal() + "]");
							} else if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwner().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwner().trim());
							} else if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwnerVal().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwnerVal().trim());
							}
						} else if (CPSHelper
								.isNotEmpty(vendorVO.getCostOwner())) {
							if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwner().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwner().trim());
							}
						} else if (CPSHelper.isNotEmpty(vendorVO
								.getCostOwnerVal())) {
							if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwnerVal().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwnerVal().trim());
							}
						} else {
							printFormVO.setCostOwner("");
						}
						if (CPSHelper.isNotEmpty(vendorVO.getCountryOfOrigin())
								&& CPSHelper.isNotEmpty(vendorVO
										.getCountryOfOriginVal())) {
							printFormVO.setCountryOfOrigin(vendorVO
									.getCountryOfOrigin()
									+ " ["
									+ vendorVO.getCountryOfOriginVal() + "]");
						} else {
							if (CPSHelper.isNotEmpty(vendorVO
									.getCountryOfOrigin())) {
								printFormVO.setCountryOfOrigin(vendorVO
										.getCountryOfOrigin());
							} else if (CPSHelper.isNotEmpty(vendorVO
									.getCountryOfOriginVal())) {
								printFormVO.setCountryOfOrigin(vendorVO
										.getCountryOfOriginVal());
							}
						}
						if (CPSHelper.isNotEmpty(vendorVO
								.getExpectedWeeklyMvt())) {
							String expWM = vendorVO.getExpectedWeeklyMvt()
									.trim();
							if ("0".equals(expWM)) {
								expWM = "";
							}
							printFormVO.setExpWklyMvmt(expWM);
						} else {
							printFormVO.setExpWklyMvmt("");
						}
						List<VendorLocationVO> vendorLocationVOOfUser = new ArrayList<VendorLocationVO>();
						List<Integer> vendorUserIds = new ArrayList<Integer>();
						boolean flagVendorLogin = true;
						boolean printDataAdd = false;
						if (object.isVendorLogin()) {
							printDataAdd = false;
							flagVendorLogin = true;
							if ("V".equalsIgnoreCase(vendorVO
									.getVendorLocationTypeCode())) {
								vendorLocationVOOfUser = object
										.getVendorLocationList().get("whsLst");
							} else {
								if ("D".equalsIgnoreCase(vendorVO
										.getVendorLocationTypeCode())) {
									vendorLocationVOOfUser = object
											.getVendorLocationList().get(
													"dsdLst");
								} else {
									vendorLocationVOOfUser.addAll(object
											.getVendorLocationList().get(
													"whsLst"));
									vendorLocationVOOfUser.addAll(object
											.getVendorLocationList().get(
													"dsdLst"));
								}
							}
							for (VendorLocationVO vendorLocationVO : vendorLocationVOOfUser) {
								if (CPSHelper.isNotEmpty(vendorLocationVO
										.getVendorId())) {
									try {
										vendorUserIds.add(Integer
												.valueOf(vendorLocationVO
														.getVendorId()));
									} catch (NumberFormatException e) {

									}
								}
							}
						} else {
							flagVendorLogin = false;
							printDataAdd = true;
						}
						printFormVO.setListCost("");
						printFormVO.setDsdStoreGroup("");
						printFormVO.setUnitCost("");
						int vendorLocationVal = NumberUtils.toInt(vendorVO
								.getVendorLocationVal());
						if (!flagVendorLogin
								|| vendorUserIds.contains(vendorLocationVal)) {
							printDataAdd = true;
							List<String> costGroups = new ArrayList<String>();
							costGroups = getDSDStoreGroupAuthor(vendorVO,
									addNewCandLocal);
							if (null != costGroups && !costGroups.isEmpty()) {
								Map<Integer, String> costGroupListCosts = new HashMap<Integer, String>();
								List<String> listCosts = new ArrayList<String>();
								printFormVO.setCostGroups(costGroups);
								printFormVO.setListCost(getListCostByCostGroup(
										vendorVO, costGroups,
										costGroupListCosts, listCosts));
								printFormVO
										.setDsdStoreGroup(getDSDStoreGroup_StoreAuthorize(
												vendorVO, costGroups));
								getUnitCostPrintForm(printFormVO, caseVO,
										vendorVO, costGroups,
										costGroupListCosts, listCosts);
							} else {
								printFormVO.setCostGroups(null);
								printFormVO.setListCost(vendorVO.getListCost());
								printFormVO.setDsdStoreGroup("");
								getUnitCostPrintForm(printFormVO, caseVO,
										vendorVO, costGroups, null, null);
							}
						} else if (vendorUserIds.contains(vendorLocationVal)) {
							printDataAdd = true;
						}
						if (CPSConstants.EMPTY_STRING.equals(printFormVO
								.getListCost().trim())) {
							printFormVO
									.setSuggestedRetail(CPSConstants.EMPTY_STRING);
						}

						printFormVO.setSeasonality(getSeasonality(
								vendorVO.getSeasonalityVal(),
								vendorVO.getSeasonalityList()));
						/**
						 * Keep it empty, it would be filled in by hand.
						 * 
						 * printFormVO.setOrderRestriction(vendorVO.
						 * getOrderRestriction());
						 */
						printFormVO.setOrderRestriction("");

						// Order Unit Changes
						printFormVO.setOrderUnit(getOrderUnit(
								vendorVO.getOrderUnit(),
								vendorVO.getOrderUnitList()));
						if (CPSHelper.isNotEmpty(vendorVO.getSeasonalityYr())) {
							String strSeas = vendorVO.getSeasonalityYr().trim();
							if ("0".equals(strSeas)) {
								strSeas = "";
							}
							printFormVO.setSeasonYear(strSeas);
						} else {
							printFormVO.setSeasonYear("");
						}

						if (CPSHelper.isNotEmpty(vendorVO.getTop2Top())
								&& CPSHelper.isNotEmpty(vendorVO
										.getTop2TopVal())) {
							if (!"null".equalsIgnoreCase(vendorVO.getTop2Top()
									.trim())
									&& !"null".equalsIgnoreCase(vendorVO
											.getTop2TopVal().trim())) {
								printFormVO
										.setT2tVendor(vendorVO.getTop2Top()
												+ " ["
												+ vendorVO.getTop2TopVal()
												+ "]");
							} else if (!"null".equalsIgnoreCase(vendorVO
									.getTop2Top().trim())) {
								printFormVO.setT2tVendor(vendorVO.getTop2Top()
										.trim());
							} else if (!"null".equalsIgnoreCase(vendorVO
									.getTop2TopVal().trim())) {
								printFormVO.setT2tVendor(vendorVO
										.getTop2TopVal().trim());
							}
						} else if (CPSHelper.isNotEmpty(vendorVO.getTop2Top())) {
							if (!"null".equalsIgnoreCase(vendorVO.getTop2Top()
									.trim())) {
								printFormVO.setT2tVendor(vendorVO.getTop2Top()
										.trim());
							}
						} else if (CPSHelper.isNotEmpty(vendorVO
								.getTop2TopVal())) {
							if (!"null".equalsIgnoreCase(vendorVO
									.getTop2TopVal().trim())) {
								printFormVO.setT2tVendor(vendorVO
										.getTop2TopVal().trim());
							}
						} else {
							printFormVO.setT2tVendor("");
						}
						if (CPSHelper.isNotEmpty(vendorVO.getVendorTie())) {
							String vTie = vendorVO.getVendorTie().trim();
							if ("0".equals(vTie)) {
								vTie = "";
							}
							printFormVO.setVendorTie(vTie);
						} else {
							printFormVO.setVendorTie("");
						}

						if (CPSHelper.isNotEmpty(vendorVO.getVendorTier())) {
							String vTier = vendorVO.getVendorTier().trim();
							if ("0".equals(vTier)) {
								vTier = "";
							}
							printFormVO.setVendorTier(vTier);
						} else {
							printFormVO.setVendorTier("");
						}

						printFormVO.setVpc(vendorVO.getVpc());
						if ("TRUE".equalsIgnoreCase(printFormVO.getImportd())
								&& "V".equalsIgnoreCase(vendorVO
										.getVendorLocationTypeCode())) {
							if (vendorVO.getImportVO() != null) {
								printFormVO.setColor(vendorVO.getImportVO()
										.getColor());
								printFormVO.setContainerSize(vendorVO
										.getImportVO().getContainerSize());
								printFormVO.setFreight(vendorVO.getImportVO()
										.getFreight());
								printFormVO.setIncoTerms(vendorVO.getImportVO()
										.getIncoTerms());
								printFormVO.setInStoreDate(vendorVO
										.getImportVO().getInstoreDate());
								if (CPSHelper.isNotEmpty(vendorVO.getImportVO()
										.getMinimumQty())) {
									String minQ = vendorVO.getImportVO()
											.getMinimumQty().trim();
									if ("0".equals(minQ)) {
										minQ = "";
									}
									printFormVO.setMinQty(minQ);
								} else {
									printFormVO.setMinQty("");
								}

								printFormVO.setMinType(vendorVO.getImportVO()
										.getMinimumType());
								printFormVO.setPickupPoint(vendorVO
										.getImportVO().getPickupPoint());
								printFormVO.setProrationDate(vendorVO
										.getImportVO().getProrationDate());
								if (CPSHelper.isNotEmpty(vendorVO.getImportVO()
										.getRate())) {
									String rate = vendorVO.getImportVO()
											.getRate().trim();
									Double d = new Double(rate);
									if (d.equals(0.0000D)) {
										rate = "";
									}
									printFormVO.setRatePercentage(rate);
								} else {
									printFormVO.setRatePercentage("");
								}
							}
						} else {
							printFormVO.setContainerSize("");
							printFormVO.setIncoTerms("");
							printFormVO.setColor("");
							printFormVO.setFreight("");
							printFormVO.setMinType("");
							printFormVO.setMinQty("");
							printFormVO.setPickupPoint("");
							printFormVO.setRatePercentage("");
							printFormVO.setProrationDate("");
							printFormVO.setInStoreDate("");
						}
						printFormVO.setOrderUnit("");
						printFormVO.setCostLink(vendorVO.getCostLink());
						if (CPSHelper.isNotEmpty(printFormVO.getCostLink())) {
							if (CPSHelper.isNotEmpty(printFormVO.getChannel())) {
								// No cost link for DSD cases
								// if(!isDSD(printFormVO.getChannel())){
								printFormVO.setLinkTo(vendorVO
										.getCostLinkFormatted());
								// }
							}
						}

						printFormVO.setWhseNumber("");
						if ("V".equalsIgnoreCase(vendorVO
								.getVendorLocationTypeCode())
								&& (!flagVendorLogin || vendorUserIds
										.contains(CPSHelper.getIntegerValue(vendorVO
												.getVendorLocationVal())))) {
							List<WareHouseVO> wareHouseVOs = null;
							String fmtVendorId = CPSHelper
									.checkVendorNumber(vendorVO
											.getVendorLocationVal());
							VendorList vendorList = new VendorList(null, null,
									CPSHelper.getIntegerValue(fmtVendorId));
							try {
								wareHouseVOs = commonBean
										.getWareHouseList(vendorList, caseVO.getClassCode());
								if (null != wareHouseVOs
										&& !wareHouseVOs.isEmpty()) {
									String facilityNumbers = "";
									for (WareHouseVO wareHouseVO : wareHouseVOs) {
										facilityNumbers += wareHouseVO
												.getFacilityNumber() + ",";
									}
									facilityNumbers = facilityNumbers
											.substring(0, facilityNumbers
													.lastIndexOf(","));
									printFormVO.setWhseNumber(facilityNumbers);
								} else {
									printFormVO.setWhseNumber(null);
								}
							} catch (CPSGeneralException e) {
								LOG.error(e.getMessage(), e);
							} catch (Exception e) {
								LOG.error(e.getMessage(), e);
							}
						}
						if (printDataAdd) {
							generatePDFDocument(printFormVO, id + "-"
									+ vendorVO.getVendorLocNumber(), req, resp);
							PrintFormVO printFormVOReturn = new PrintFormVO();
							BeanUtils.copyProperties(printFormVOReturn,
									printFormVO);
							printFormList.add(printFormVOReturn);
						}
						index++;
					}
				}
			}
		}
		return printFormList;
	}

	private static List<PrintFormVO> copyProductVOToPrintFormVO(
			ProductVO object, String id, HttpServletRequest req,
			HttpServletResponse resp, CommonService commonBean,
			AddNewCandidateService addNewCandLocal,
			HebLdapUserService hebLdapUserService)
			throws IllegalAccessException, InvocationTargetException {
		List<PrintFormVO> printFormList = new ArrayList<PrintFormVO>();
		PrintFormVO printFormVO = new PrintFormVO();
		printFormVO.setTotalVolumn(getTotalVolumn(object));
		ProductClassificationVO productClassificationVO = object
				.getClassificationVO();
		if (productClassificationVO != null) {
			if (CPSHelper.isNotEmpty(productClassificationVO.getBdmName())) {
				printFormVO.setBuyerName(productClassificationVO.getBdmName()
						.substring(
								0,
								productClassificationVO.getBdmName().indexOf(
										"[")));
			}
			if (CPSHelper.isNotEmpty(productClassificationVO.getBdmName())) {
				printFormVO.setBuyerNumber(productClassificationVO.getBdmName()
						.substring(
								productClassificationVO.getBdmName().indexOf(
										"[") + 1,
								productClassificationVO.getBdmName()
										.lastIndexOf("]")));
			}
			printFormVO.setBrand(productClassificationVO.getBrandNameDisplay());
		}
		if (object.getClassificationVO() != null
				&& CPSHelper.isNotEmpty(object.getClassificationVO())) {
			printFormVO.setCommodity(object.getClassificationVO()
					.getCommodityName()
					+ " ["
					+ object.getClassificationVO().getCommodity() + "]");
			printFormVO.setSubCommodity(object.getClassificationVO()
					.getSubCommodityName());
		}
		if (productClassificationVO != null) {
			printFormVO.setProductDescription(productClassificationVO
					.getProdDescritpion());
			printFormVO.setProductType(productClassificationVO
					.getProductTypeName());
			printFormVO.setType(productClassificationVO.getMerchandizeName());
		}

		/**
		 * *** ps_intnt_cd *** 1 UPC Introduce A UPC 100 2 Case Introduce a Case
		 * 101 3 Vendor Authorize Vendor 102 4 MRT Setup an MRT 103 5 Bonus
		 * Bonus UPC for Existing Product 104 6 NewSiz Size Change for an
		 * Existing Product 105 7 Associ Associate a New UPC to an Existing
		 * Product 106 8 NewPdt New Product 107 9 Prod Introduce a Product 108
		 */
		if (CPSHelper.isNotEmpty(object.getWorkRequest())) {
			if (null != object.getWorkRequest().getWorkIdentifier()) {
				try {
					object.getWorkRequest().setIntentIdentifier(
							addNewCandLocal.getIntentIdentifierByPswd(object
									.getWorkRequest().getWorkIdentifier()));
				} catch (Exception e) {
					LOG.error("Cannot get IntentIdentifier");
				}

			}
			printFormVO
					.setIntent(object.getWorkRequest().getIntentIdentifier());
			// Fix PIM 846
			if (CPSHelper.isNotEmpty(object.getWorkRequest().getScnCdId())) {
				printFormVO.setOpenStock("\n "
						+ CPSHelper.getUPCPrintFormat(object.getWorkRequest()
								.getScnCdId()));
				printFormVO.setBonus(true);
			} else {
				printFormVO.setBonus(false);
				printFormVO.setOpenStock("");
			}
			// End fix PIM 846
		}
		printFormVO.setCreateOn(object.getCreateOn());
		ScaleVO scaleVO = object.getScaleVO();
		if (scaleVO != null) {
			if (CPSHelper.isNotEmpty(scaleVO.getActionCode())) {
				String strActionCode = scaleVO.getActionCode().trim();
				if ("0".equals(strActionCode)) {
					strActionCode = "";
				}
				printFormVO.setActionCode(strActionCode);
			}
			if (CPSHelper.isNotEmpty(scaleVO.getGraphicsCode())) {
				String strGC = scaleVO.getGraphicsCode().trim();
				if ("0".equals(strGC)) {
					strGC = "";
				}
				printFormVO.setGraphicsCode(strGC);
			}

			printFormVO
					.setIngredients(String.valueOf(scaleVO.getIngredientSw()));
			printFormVO.setNutrition(scaleVO.getNutStatementNumber());
			printFormVO.setTareWeight(scaleVO.getPrePackTare());
		}
		printFormVO.setScaleTareWeight("");

		ShelfEdgeVO shelfEdgeVO = object.getShelfEdgeVO();
		printFormVO.setPackaging(shelfEdgeVO.getPackaging());

		PharmacyVO pharmacyVO = object.getPharmacyVO();
		/**
		 * Commented out the following lines to ignore PSE, FSA and PSE Grams
		 */
		/*
		 * printFormVO.setPseGr(pharmacyVO.getPseGrams());
		 * printFormVO.setFSA(pharmacyVO.getFSA());
		 */
		if (pharmacyVO != null) {
			printFormVO.setAvgWhslCost(pharmacyVO.getAvgCost());
			printFormVO.setDirectCost(pharmacyVO.getDirectCost());
			try {
				if (CPSHelper.isNotEmpty(pharmacyVO.getDrugSchedule())) {
					List<BaseJSFVO> drugSchedules = commonBean
							.getDrugSchedules();
					for (BaseJSFVO baseJSFVO : drugSchedules) {
						if (baseJSFVO.getId().equalsIgnoreCase(
								pharmacyVO.getDrugSchedule())) {
							printFormVO.setDrugSchedule(baseJSFVO.getName());
							break;
						}
					}
				}
				if (CPSHelper.isNotEmpty(pharmacyVO.getDrugNmCd())) {
					List<BaseJSFVO> drugnames = commonBean.getDrugNameTypes();
					for (BaseJSFVO baseJSFVO : drugnames) {
						if (baseJSFVO.getId().equalsIgnoreCase(
								pharmacyVO.getDrugNmCd())) {
							printFormVO.setDrugAbb(baseJSFVO.getName());
							break;
						}
					}
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
			}

			printFormVO.setNDC(pharmacyVO.getNdc());
		}
		PointOfSaleVO pointOfSaleVO = object.getPointOfSaleVO();
		if (pointOfSaleVO != null) {
			printFormVO.setFamilyCode1(pointOfSaleVO.getFamilyCode1());
			printFormVO.setFamilyCode2(pointOfSaleVO.getFamilyCode2());
			// printFormVO.setAVC(pointOfSaleVO.isAbusiveVolatileChemical());
			printFormVO.setDrugFactsPanel(pointOfSaleVO.isDrugFactPanel());
			printFormVO.setQtyRestricted(pointOfSaleVO.isQntityRestricted());
			printFormVO.setTime(pointOfSaleVO.getPurchaseTimeName());
			printFormVO.setAge(pointOfSaleVO.getRestrictedSalesAgeLimitName());
			printFormVO.setFoodStamp(pointOfSaleVO.isFoodStamp());
			printFormVO.setTaxFlag(pointOfSaleVO.isTaxable());
			printFormVO.setFSAEligible(pointOfSaleVO.isFsa());
		}
		RetailVO retailVO = object.getRetailVO();
		if (retailVO != null) {
			if (!object.isVendorLogin()) {
				printFormVO.setInitialRetail(retailVO.getRetail() + " For $"
						+ retailVO.getRetailFor());
				printFormVO.setRetailLinkTo(retailVO.getRetailLinkTo());
				printFormVO.setCriticalItem(retailVO.getCriticalItem());
				printFormVO.setCentsOff(retailVO.getCentsOff());
				printFormVO.setOffPrePricePercentage(retailVO.getOffPreprice());
				printFormVO.setSoldByLb(retailVO.isWeightFlag());
			}
			if (!CPSHelper.isEmpty(retailVO.getSuggforPrice())
					&& Double.parseDouble(retailVO.getSuggforPrice()) > 0) {
				printFormVO.setSuggestedRetail(retailVO.getSuggRetail() + "/$"
						+ retailVO.getSuggforPrice());
			}
			if (retailVO.getPrePrice() != null
					&& CPSHelper.getDoubleValue(retailVO.getPrePrice()) > 0.00) {
				printFormVO.setPrePriced(true);
			}
		}
		StringBuffer upcKitBuffer = new StringBuffer();
		String upcKit = new String();
		if (CPSHelper.isNotEmpty(object.getUpcKitVOs())) {
			for (UPCKitVO upcKitVo : object.getUpcKitVOs()) {
				upcKitBuffer.append(upcKitVo.getQuantity());
				upcKitBuffer.append(" - ");
				upcKitBuffer.append(upcKitVo.getUnitUPC());
				upcKitBuffer.append("-");
				upcKitBuffer.append(upcKitVo.getUpcDigit());
				upcKitBuffer.append(", ");
			}
		}
		if (CPSHelper.isNotEmpty(upcKitBuffer) && upcKitBuffer.length() > 0) {
			upcKit = upcKitBuffer.toString().substring(0,
					upcKitBuffer.lastIndexOf(", "));
		}
		List<CommentsVO> commentsVOList = object.getCommentsVO();
		if (null != commentsVOList && !commentsVOList.isEmpty()) {
			for (CommentsVO commentsVO : commentsVOList) {
				if(CPSHelper.isNotEmpty(upcKit)) {
					printFormVO
						.setComments(upcKit + ", " + commentsVO.getComments());
				} else {
					printFormVO
					.setComments(commentsVO.getComments());
				}
			}
		} else {
			printFormVO.setComments(upcKit);
		}
		// if more than one Unit UPC is having then the following properties
		// need to shown as multiple
		List<UPCVO> upcList = object.getUpcVO();
		String multilUnitUPC = "";
		boolean flagNewUPC = false;
		int indexBeakline = 0;
		if (null != upcList && !upcList.isEmpty()) {
			for (UPCVO upcvo : upcList) {
				if (upcList.size() == 1) {
					if (CPSHelper.isNotEmpty(upcvo.getSubBrand())
							&& CPSHelper.isNotEmpty(upcvo.getSubBrandDesc())) {
						if (!upcvo.getSubBrandDesc().contains(
								upcvo.getSubBrand())) {
							printFormVO.setSubBrand(upcvo.getSubBrandDesc()
									+ " [" + upcvo.getSubBrand() + "]");
						} else {
							printFormVO.setSubBrand(upcvo.getSubBrandDesc());
						}
					} else {
						if (CPSHelper.isNotEmpty(upcvo.getSubBrandDesc())) {
							printFormVO.setSubBrand(upcvo.getSubBrandDesc());
						} else if (CPSHelper.isNotEmpty(upcvo.getSubBrand())) {
							printFormVO.setSubBrand(upcvo.getSubBrand());
						} else {
							printFormVO.setSubBrand("");
						}
					}
					// Fix 1247
					printFormVO.setUnitUPC(CPSHelper.getUPCPrintFormat(upcvo
							.getUnitUpc()));
					printFormVO.setUOM(upcvo.getUnitMeasureDesc());
					printFormVO.setProductHeight(upcvo.getHeight());
					printFormVO.setProductLength(upcvo.getLength());
					printFormVO.setProductWidth(upcvo.getWidth());
					printFormVO.setSize(upcvo.getSize());
				} else {
					if (upcvo != null) {
						flagNewUPC = true;
						printFormVO.setSubBrand("Multiple");
						if (indexBeakline > 0) {
							multilUnitUPC += "\n";
						}
						if (upcvo.getNewDataSw() == 'Y') {
							multilUnitUPC += "*"
									+ CPSHelper.getUPCPrintFormat(upcvo
											.getUnitUpc()) + ",";
						} else {
							multilUnitUPC += CPSHelper.getUPCPrintFormat(upcvo
									.getUnitUpc()) + ",";
						}
						indexBeakline++;
						printFormVO.setUOM("Multiple");
						printFormVO.setProductHeight("Multiple");
						printFormVO.setProductLength("Multiple");
						printFormVO.setProductWidth("Multiple");
						printFormVO.setSize("Multiple");
					}
				}

			}
		}
		if (flagNewUPC && CPSHelper.isNotEmpty(multilUnitUPC)) {
			multilUnitUPC = multilUnitUPC.substring(0,
					multilUnitUPC.lastIndexOf(","));
			printFormVO.setUnitUPC("\n" + multilUnitUPC);
		}
		List<CaseVO> caseVOList = object.getCaseVOs();
		for (CaseVO caseVO : caseVOList) {
			if (caseVO != null) {
				printFormVO.setItemSize(caseVO.getItemSizeQty());
				printFormVO.setCodeDate(caseVO.isCodeDate());
				// Fix 1247
				printFormVO.setCaseUPC(CPSHelper.getUPCPrintFormat(caseVO
						.getCaseUPC()));
				printFormVO.setCaseDescription(caseVO.getCaseDescription());
				printFormVO.setChannel(caseVO.getChannelVal());
				if (CPSHelper.isNotEmpty(caseVO.getGuaranteetoStoreDays())) {
					String gDays = caseVO.getGuaranteetoStoreDays().trim();
					if ("0".equals(gDays)) {
						gDays = "";
					}
					printFormVO.setGuaranteeToStore(gDays);
				} else {
					printFormVO.setGuaranteeToStore("");
				}

				if (CPSHelper.isNotEmpty(caseVO.getInboundSpecificationDays())) {
					String iDays = caseVO.getInboundSpecificationDays().trim();
					if ("0".equals(iDays)) {
						iDays = "";
					}
					printFormVO.setInboundSpec(iDays);
				} else {
					printFormVO.setInboundSpec("");
				}

				if (CPSHelper.isNotEmpty(caseVO.getReactionDays())) {
					String rDays = caseVO.getReactionDays().trim();
					if ("0".equals(rDays)) {
						rDays = "";
					}
					printFormVO.setReaction(rDays);
				} else {
					printFormVO.setReaction("");
				}

				if (CPSHelper.isNotEmpty(caseVO.getMaxShelfLifeDays())) {
					String mslDays = caseVO.getMaxShelfLifeDays().trim();
					if ("0".equals(mslDays)) {
						mslDays = "";
					}
					printFormVO.setMaxShelfLife(mslDays);
				} else {
					printFormVO.setMaxShelfLife("");
				}

				printFormVO.setMasterPackCube(caseVO.getMasterCubeFormatted());
				printFormVO.setMasterPackHeight(caseVO
						.getMasterHeightFormatted());
				printFormVO.setMasterPackLength(caseVO
						.getMasterLengthFormatted());
				printFormVO.setMasterPackWeight(caseVO
						.getMasterWeightFormatted());
				printFormVO
						.setMasterPackWidth(caseVO.getMasterWidthFormatted());
				printFormVO.setMasterPack(caseVO.getMasterPack());
				printFormVO.setShipPackCube(caseVO.getShipCubeFormatted());
				printFormVO.setShipPackHeight(caseVO.getShipHeightFormatted());
				printFormVO.setShipPackLength(caseVO.getShipLengthFormatted());
				printFormVO.setShipPackWeight(caseVO.getShipWeightFormatted());
				printFormVO.setShipPackWidth(caseVO.getShipWidthFormatted());
				printFormVO.setShipPack(caseVO.getShipPack());
				printFormVO.setOneTouchType(get1Touch(caseVO.getOneTouch(),
						caseVO.getTouchTypeList()));
				printFormVO.setVariableWeight(caseVO.isVariableWeight());
				printFormVO.setCatchWeight(caseVO.isCatchWeight());
				if (CPSHelper.isNotEmpty(caseVO.getItemCategory())) {
					for (BaseJSFVO baseJSFVO : caseVO.getItemCategoryList()) {
						if (baseJSFVO.getId().equalsIgnoreCase(
								caseVO.getItemCategory())) {
							printFormVO.setItemCategory(baseJSFVO.getName());
						}
					}
				} else {
					printFormVO.setItemCategory("");
				}
				if (caseVO.isDsplyDryPalSw()) {
					if ("7".equals(caseVO.getSrsAffTypCd())) {
						printFormVO.setDRP(true);
						printFormVO.setRRP(false);
					} else if ("9".equals(caseVO.getSrsAffTypCd())) {
						printFormVO.setDRP(false);
						printFormVO.setRRP(true);
					}
					printFormVO.setRowsFacing(caseVO.getProdFcngNbr());
					printFormVO.setRowsDeep(caseVO.getProdRowDeepNbr());
					printFormVO.setRowsHigh(caseVO.getProdRowHiNbr());
					printFormVO.setOrientation(caseVO.getNbrOfOrintNbr());
				} else {
					printFormVO.setDRP(false);
					printFormVO.setRRP(false);
					printFormVO.setRowsFacing("");
					printFormVO.setRowsDeep("");
					printFormVO.setRowsHigh("");
					printFormVO.setOrientation(null);
				}

				// fix pim 933
				List<VendorVO> vendorVOListPrints = new ArrayList<VendorVO>();
				vendorVOListPrints = caseVO.getVendorVOListPrints();
				// END --- fix pim 933
				for (VendorVO vendorVO : vendorVOListPrints) {
					if (vendorVO != null) {
						// Fix 1052. Add only new vendor to printForm
						printFormVO.setGuaranteedSale(vendorVO
								.isGuarenteedSale());
						printFormVO.setDealOffered(vendorVO.isDealOffered());
						printFormVO.setImportd(vendorVO.getImportd());
						printFormVO.setVendorName(vendorVO.getVendorLocation());
						printFormVO.setVendorNumber(vendorVO
								.getVendorLocationVal());
						printFormVO
								.setOriginalVendorNumber(String
										.valueOf(vendorVO
												.getOriginalVendorLocNumber()));
						// Fix 1197
						String vnID = null;
						if (object.getWorkRequest() != null) {
							vnID = object.getWorkRequest()
									.getRecordCreationUserIdentifier();
						}
						if (vnID != null) {
							UserInfo userInfo = null;
							if (CPSHelper.isNotEmpty(vnID)) {
								try {
									userInfo = (UserInfo) hebLdapUserService
											.getUserInfo(vnID);
								} catch (UsernameNotFoundException e) {
									LOG.error(e.getMessage(), e);
								} catch (DataAccessException e) {
									LOG.error(e.getMessage(), e);
								}
							}
							vnID = vnID.toUpperCase();
							if (vnID.startsWith("VB") || vnID.startsWith("V90")) {
								// Created by Vendor.
								if (null != userInfo) {
									if (CPSHelper.isNotEmpty(userInfo
											.getAttributeValue("sn"))) {
										printFormVO
												.setContactName(CPSHelper
														.getTrimmedValue(userInfo
																.getAttributeValue("sn"))
														+ ", "
														+ CPSHelper
																.getTrimmedValue(userInfo
																		.getAttributeValue("givenName")));
									}
								} else {
									if (object.getWorkRequest() != null) {
										if (CPSHelper.isNotEmpty(object
												.getWorkRequest()
												.getCandUpdtFirstName())) {
											printFormVO
													.setContactName(CPSHelper
															.getTrimmedValue(object
																	.getWorkRequest()
																	.getCandUpdtLastName())
															+ ", "
															+ CPSHelper
																	.getTrimmedValue(object
																			.getWorkRequest()
																			.getCandUpdtFirstName()));
										} else {
											printFormVO
													.setContactName(CPSHelper
															.getTrimmedValue(object
																	.getWorkRequest()
																	.getCandUpdtLastName()));
										}
									}
								}
								if (object.getWorkRequest() != null
										&& object.getWorkRequest()
												.getVendorPhoneAreaCd() != null) {
									printFormVO.setContactPhone("("
											+ object.getWorkRequest()
													.getVendorPhoneAreaCd()
											+ ") "
											+ object.getWorkRequest()
													.getVendorPhoneNumber());
								} else {
									printFormVO.setContactPhone(object
											.getWorkRequest()
											.getVendorPhoneNumber());
								}
								printFormVO.setContactEmail(object
										.getWorkRequest().getVendorEmail());
							} else {
								if (null != userInfo) {
									if (CPSHelper.isNotEmpty(userInfo
											.getAttributeValue("sn"))) {
										printFormVO
												.setContactName(CPSHelper
														.getTrimmedValue(userInfo
																.getAttributeValue("sn"))
														+ ", "
														+ CPSHelper
																.getTrimmedValue(userInfo
																		.getAttributeValue("givenName")));
									}
								} else {
									if (object.getWorkRequest() != null) {
										if (CPSHelper.isNotEmpty(object
												.getWorkRequest()
												.getCandUpdtFirstName())) {
											printFormVO
													.setContactName(CPSHelper
															.getTrimmedValue(object
																	.getWorkRequest()
																	.getCandUpdtLastName())
															+ ", "
															+ CPSHelper
																	.getTrimmedValue(object
																			.getWorkRequest()
																			.getCandUpdtFirstName()));
										} else {
											printFormVO
													.setContactName(CPSHelper
															.getTrimmedValue(object
																	.getWorkRequest()
																	.getCandUpdtLastName()));
										}
									}
								}
							}
						}
						if (CPSHelper.isNotEmpty(vendorVO.getCostOwner())
								&& CPSHelper.isNotEmpty(vendorVO
										.getCostOwnerVal())) {
							if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwner().trim())
									&& !"null".equalsIgnoreCase(vendorVO
											.getCostOwnerVal().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwner()
										+ " ["
										+ vendorVO.getCostOwnerVal() + "]");
							} else if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwner().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwner().trim());
							} else if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwnerVal().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwnerVal().trim());
							}
						} else if (CPSHelper
								.isNotEmpty(vendorVO.getCostOwner())) {
							if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwner().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwner().trim());
							}
						} else if (CPSHelper.isNotEmpty(vendorVO
								.getCostOwnerVal())) {
							if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwnerVal().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwnerVal().trim());
							}
						} else {
							printFormVO.setCostOwner("");
						}
						if (CPSHelper.isNotEmpty(vendorVO.getCountryOfOrigin())
								&& CPSHelper.isNotEmpty(vendorVO
										.getCountryOfOriginVal())) {
							printFormVO.setCountryOfOrigin(vendorVO
									.getCountryOfOrigin()
									+ " ["
									+ vendorVO.getCountryOfOriginVal() + "]");
						} else {
							if (CPSHelper.isNotEmpty(vendorVO
									.getCountryOfOrigin())) {
								printFormVO.setCountryOfOrigin(vendorVO
										.getCountryOfOrigin());
							} else if (CPSHelper.isNotEmpty(vendorVO
									.getCountryOfOriginVal())) {
								printFormVO.setCountryOfOrigin(vendorVO
										.getCountryOfOriginVal());
							}
						}
						if (CPSHelper.isNotEmpty(vendorVO
								.getExpectedWeeklyMvt())) {
							String expWM = vendorVO.getExpectedWeeklyMvt()
									.trim();
							if ("0".equals(expWM)) {
								expWM = "";
							}
							printFormVO.setExpWklyMvmt(expWM);
						} else {
							printFormVO.setExpWklyMvmt("");
						}
						// list cost
						List<VendorLocationVO> vendorLocationVOOfUser = new ArrayList<VendorLocationVO>();
						List<Integer> vendorUserIds = new ArrayList<Integer>();
						boolean flagVendorLogin = true;
						if (object.isVendorLogin()) {
							flagVendorLogin = true;
							if ("V".equalsIgnoreCase(vendorVO
									.getVendorLocationTypeCode())) {
								vendorLocationVOOfUser = object
										.getVendorLocationList().get("whsLst");
							} else {
								if ("D".equalsIgnoreCase(vendorVO
										.getVendorLocationTypeCode())) {
									vendorLocationVOOfUser = object
											.getVendorLocationList().get(
													"dsdLst");
								} else {
									vendorLocationVOOfUser.addAll(object
											.getVendorLocationList().get(
													"whsLst"));
									vendorLocationVOOfUser.addAll(object
											.getVendorLocationList().get(
													"dsdLst"));
								}
							}
							for (VendorLocationVO vendorLocationVO : vendorLocationVOOfUser) {
								if (CPSHelper.isNotEmpty(vendorLocationVO
										.getVendorId())) {
									try {
										vendorUserIds.add(Integer
												.valueOf(vendorLocationVO
														.getVendorId()));
									} catch (NumberFormatException e) {

									}
								}
							}
						} else {
							flagVendorLogin = false;
						}
						printFormVO.setListCost("");
						printFormVO.setDsdStoreGroup("");
						printFormVO.setUnitCost("");
						int vendorLocationVal = NumberUtils.toInt(vendorVO
								.getVendorLocationVal());
						if (!flagVendorLogin
								|| vendorUserIds.contains(vendorLocationVal)) {
							List<String> costGroups = new ArrayList<String>();
							costGroups = getDSDStoreGroupAuthor(vendorVO,
									addNewCandLocal);
							if (null != costGroups && !costGroups.isEmpty()) {
								Map<Integer, String> costGroupListCosts = new HashMap<Integer, String>();
								List<String> listCosts = new ArrayList<String>();
								printFormVO.setCostGroups(costGroups);
								printFormVO.setListCost(getListCostByCostGroup(
										vendorVO, costGroups,
										costGroupListCosts, listCosts));
								printFormVO
										.setDsdStoreGroup(getDSDStoreGroup_StoreAuthorize(
												vendorVO, costGroups));
								getUnitCostPrintForm(printFormVO, caseVO,
										vendorVO, costGroups,
										costGroupListCosts, listCosts);
							} else {
								printFormVO.setCostGroups(null);
								printFormVO.setListCost(vendorVO.getListCost());
								printFormVO.setDsdStoreGroup("");
								getUnitCostPrintForm(printFormVO, caseVO,
										vendorVO, costGroups, null, null);
							}
						} else if (vendorUserIds.contains(vendorLocationVal)) {
							// printDataAdd = true;
						}
						if (CPSConstants.EMPTY_STRING.equals(printFormVO
								.getListCost().trim())) {
							printFormVO
									.setSuggestedRetail(CPSConstants.EMPTY_STRING);
						}
						printFormVO.setSeasonality(getSeasonality(
								vendorVO.getSeasonalityVal(),
								vendorVO.getSeasonalityList()));
						/**
						 * Keep it empty, it would be filled in by hand.
						 * 
						 * printFormVO.setOrderRestriction(vendorVO.
						 * getOrderRestriction());
						 */
						printFormVO.setOrderRestriction("");

						// Order Unit Changes
						printFormVO.setOrderUnit(getOrderUnit(
								vendorVO.getOrderUnit(),
								vendorVO.getOrderUnitList()));
						if (CPSHelper.isNotEmpty(vendorVO.getSeasonalityYr())) {
							String strSeas = vendorVO.getSeasonalityYr().trim();
							if ("0".equals(strSeas)) {
								strSeas = "";
							}
							printFormVO.setSeasonYear(strSeas);
						} else {
							printFormVO.setSeasonYear("");
						}
						if (CPSHelper.isNotEmpty(vendorVO.getTop2Top())
								&& CPSHelper.isNotEmpty(vendorVO
										.getTop2TopVal())) {
							if (!"null".equalsIgnoreCase(vendorVO.getTop2Top()
									.trim())
									&& !"null".equalsIgnoreCase(vendorVO
											.getTop2TopVal().trim())) {
								printFormVO
										.setT2tVendor(vendorVO.getTop2Top()
												+ " ["
												+ vendorVO.getTop2TopVal()
												+ "]");
							} else if (!"null".equalsIgnoreCase(vendorVO
									.getTop2Top().trim())) {
								printFormVO.setT2tVendor(vendorVO.getTop2Top()
										.trim());
							} else if (!"null".equalsIgnoreCase(vendorVO
									.getTop2TopVal().trim())) {
								printFormVO.setT2tVendor(vendorVO
										.getTop2TopVal().trim());
							}
						} else if (CPSHelper.isNotEmpty(vendorVO.getTop2Top())) {
							if (!"null".equalsIgnoreCase(vendorVO.getTop2Top()
									.trim())) {
								printFormVO.setT2tVendor(vendorVO.getTop2Top()
										.trim());
							}
						} else if (CPSHelper.isNotEmpty(vendorVO
								.getTop2TopVal())) {
							if (!"null".equalsIgnoreCase(vendorVO
									.getTop2TopVal().trim())) {
								printFormVO.setT2tVendor(vendorVO
										.getTop2TopVal().trim());
							}
						} else {
							printFormVO.setT2tVendor("");
						}
						if (CPSHelper.isNotEmpty(vendorVO.getVendorTie())) {
							String vTie = vendorVO.getVendorTie().trim();
							if ("0".equals(vTie)) {
								vTie = "";
							}
							printFormVO.setVendorTie(vTie);
						} else {
							printFormVO.setVendorTie("");
						}

						if (CPSHelper.isNotEmpty(vendorVO.getVendorTier())) {
							String vTier = vendorVO.getVendorTier().trim();
							if ("0".equals(vTier)) {
								vTier = "";
							}
							printFormVO.setVendorTier(vTier);
						} else {
							printFormVO.setVendorTier("");
						}
						printFormVO.setVpc(vendorVO.getVpc());
						if ("TRUE".equalsIgnoreCase(printFormVO.getImportd())
								&& "V".equalsIgnoreCase(vendorVO
										.getVendorLocationTypeCode())) {
							if (vendorVO.getImportVO() != null) {
								printFormVO.setColor(vendorVO.getImportVO()
										.getColor());
								printFormVO.setContainerSize(vendorVO
										.getImportVO().getContainerSize());
								printFormVO.setFreight(vendorVO.getImportVO()
										.getFreight());
								printFormVO.setIncoTerms(vendorVO.getImportVO()
										.getIncoTerms());
								printFormVO.setInStoreDate(vendorVO
										.getImportVO().getInstoreDate());
								if (CPSHelper.isNotEmpty(vendorVO.getImportVO()
										.getMinimumQty())) {
									String minQ = vendorVO.getImportVO()
											.getMinimumQty().trim();
									if ("0".equals(minQ)) {
										minQ = "";
									}
									printFormVO.setMinQty(minQ);
								} else {
									printFormVO.setMinQty("");
								}

								printFormVO.setMinType(vendorVO.getImportVO()
										.getMinimumType());
								printFormVO.setPickupPoint(vendorVO
										.getImportVO().getPickupPoint());
								printFormVO.setProrationDate(vendorVO
										.getImportVO().getProrationDate());
								if (CPSHelper.isNotEmpty(vendorVO.getImportVO()
										.getRate())) {
									String rate = vendorVO.getImportVO()
											.getRate().trim();
									Double d = new Double(rate);
									if (d.equals(0.0000D)) {
										rate = "";
									}
									printFormVO.setRatePercentage(rate);
								} else {
									printFormVO.setRatePercentage("");
								}
							}
						} else {
							printFormVO.setContainerSize("");
							printFormVO.setIncoTerms("");
							printFormVO.setColor("");
							printFormVO.setFreight("");
							printFormVO.setMinType("");
							printFormVO.setMinQty("");
							printFormVO.setPickupPoint("");
							printFormVO.setRatePercentage("");
							printFormVO.setProrationDate("");
							printFormVO.setInStoreDate("");
						}
						printFormVO.setOrderUnit("");
						printFormVO.setCostLink(vendorVO.getCostLink());
						if (CPSHelper.isNotEmpty(printFormVO.getCostLink())) {
							if (CPSHelper.isNotEmpty(printFormVO.getChannel())) {
								// No cost link for DSD cases
								// if(!isDSD(printFormVO.getChannel())){
								printFormVO.setLinkTo(vendorVO
										.getCostLinkFormatted());
								// }
							}
						}
						printFormVO.setWhseNumber("");
						if ("V".equalsIgnoreCase(vendorVO
								.getVendorLocationTypeCode())
								&& (!flagVendorLogin || vendorUserIds
										.contains(CPSHelper.getIntegerValue(vendorVO
												.getVendorLocationVal())))) {
							List<WareHouseVO> wareHouseVOs = null;
							String fmtVendorId = CPSHelper
									.checkVendorNumber(vendorVO
											.getVendorLocationVal());
							VendorList vendorList = new VendorList(null, null,
									CPSHelper.getIntegerValue(fmtVendorId));
							try {
								wareHouseVOs = commonBean
										.getWareHouseList(vendorList, caseVO.getClassCode());
								if (null != wareHouseVOs
										&& !wareHouseVOs.isEmpty()) {
									String facilityNumbers = "";
									for (WareHouseVO wareHouseVO : wareHouseVOs) {
										facilityNumbers += wareHouseVO
												.getFacilityNumber() + ",";
									}
									facilityNumbers = facilityNumbers
											.substring(0, facilityNumbers
													.lastIndexOf(","));
									printFormVO.setWhseNumber(facilityNumbers);
								} else {
									printFormVO.setWhseNumber(null);
								}
							} catch (CPSGeneralException e) {
								LOG.error(e.getMessage(), e);
							} catch (Exception e) {
								LOG.error(e.getMessage(), e);
							}
						}
						generatePDFDocument(printFormVO,
								id + "-" + caseVO.getPsItemId() + "-"
										+ vendorVO.getVendorLocNumber(), req,
								resp);
						PrintFormVO printFormVOReturn = new PrintFormVO();
						BeanUtils
								.copyProperties(printFormVOReturn, printFormVO);
						printFormList.add(printFormVOReturn);
						// index++;
					}
				}
			}
		}
		return printFormList;
	}

	public static void main(String[] args) {

		String s = " 2, 11, 1, 43, ";
		String toBeReplaced = " " + 1 + "*, ";
		CharSequence replacement = toBeReplaced;
		CharSequence target = " 1, ";
		s = s.replace(target, replacement);
	}

	/*
	 * private static PrintFormVO getVO(){ PrintFormVO printFormVO = new
	 * PrintFormVO(); return printFormVO; }
	 */

	private static PdfPTable getSQF(boolean isSoldBy, boolean isQty,
			boolean isFSA) throws DocumentException {
		float cellHeight = 15F;
		float[] f = { 20F, 80F };
		PdfPTable table = new PdfPTable(f);
		table.setWidthPercentage(f, PageSize.LETTER);
		Image sImage = getCheckBoxImage(isSoldBy);
		Image qImage = getCheckBoxImage(isQty);
		Image fImage = getCheckBoxImage(isFSA);
		PdfPCell cell = new PdfPCell(sImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);

		Phrase phrase = new Phrase("Sold By Lb", PrintFormHelper.labelFont);

		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);

		cell = new PdfPCell(qImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);

		phrase = new Phrase("Qty Restricted", PrintFormHelper.labelFont);

		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);

		cell = new PdfPCell(fImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);

		phrase = new Phrase("FSA Eligible", PrintFormHelper.labelFont);

		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);

		return table;
	}

	private static PdfPTable getOrderAttribute(boolean isSoldbyLB,
			boolean isFSAEligible) throws DocumentException {
		float cellHeight = 15F;
		float[] f = { 20F, 80F };
		PdfPTable table = new PdfPTable(f);
		// table.setWidthPercentage(f, PageSize.LETTER);
		Image sImage = getCheckBoxImage(isSoldbyLB);
		Image qImage = getCheckBoxImage(isFSAEligible);
		PdfPCell cell = new PdfPCell(sImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);
		Phrase phrase = new Phrase("Sold by LB", PrintFormHelper.labelFont);
		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);
		cell = new PdfPCell(qImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);
		phrase = new Phrase("FSA Eligible", PrintFormHelper.labelFont);
		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);
		return table;
	}

	private static PdfPTable getSampleProvided(PrintFormVO printFormVO)
			throws DocumentException {
		float cellHeight = 15F;
		float[] f = { 5F, 15F, 5F, 15F, 5F, 15F, 5F, 15F, 5F, 15F };
		// float[] f = { 10F,20F,10F,20F,10F,10F,10F,10F };
		PdfPTable table = new PdfPTable(f);
		table.setWidthPercentage(f, PageSize.LETTER);
		Phrase phrase = new Phrase("Sample Provided: ",
				PrintFormHelper.labelFont);
		PdfPCell cell = new PdfPCell(phrase);
		cell.setColspan(10);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);
		Image retailSellingUnitImage = getCheckBoxImage(false);
		Image productPakagingImage = getCheckBoxImage(false);
		Image frontBackImage = getCheckBoxImage(false);
		Image notValidImage = getCheckBoxImage(false);
		Image noneAtAllImage = getCheckBoxImage(false);
		cell = new PdfPCell(retailSellingUnitImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);
		phrase = new Phrase(" Retail selling unit", PrintFormHelper.labelFont);
		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);
		cell = new PdfPCell(productPakagingImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);
		phrase = new Phrase("Product packaging", PrintFormHelper.labelFont);
		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);
		cell = new PdfPCell(frontBackImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);
		phrase = new Phrase("Image front/back", PrintFormHelper.labelFont);
		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);
		cell = new PdfPCell(notValidImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);
		phrase = new Phrase("Not valid", PrintFormHelper.labelFont);
		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);
		cell = new PdfPCell(noneAtAllImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);
		phrase = new Phrase("None at all", PrintFormHelper.labelFont);
		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);
		return table;
	}

	private static PdfPTable getCodeDatedProducts(PrintFormVO printFormVO)
			throws DocumentException {
		float cellHeight = 15F;
		float[] f = { 10F, 90F };
		PdfPTable table = new PdfPTable(f);
		table.setWidthPercentage(f, PageSize.LETTER);
		Image sImage = getCheckBoxImage(false);
		Image qImage = getCheckBoxImage(false);
		Phrase phrase = new Phrase("Inbound Spec: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getInboundSpec())) {
			phrase.add(new Phrase(
					printFormVO.getInboundSpec().trim() + " Days",
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nReaction: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getReaction())) {
			phrase.add(new Phrase(printFormVO.getReaction().trim() + " Days",
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nGuarantee to Store: ",
				PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getGuaranteeToStore())) {
			phrase.add(new Phrase(printFormVO.getGuaranteeToStore().trim()
					+ " Days", PrintFormHelper.dataFont));
		}
		PdfPCell cell = new PdfPCell(phrase);
		cell.setColspan(2);
		table.addCell(cell);
		phrase = new Phrase("Global Sourcing: ",
				PrintFormHelper.dataFontBoldChild);
		phrase.add(new Phrase("  (select one) ", PrintFormHelper.dataFontItatic));
		cell = new PdfPCell(phrase);
		cell.setColspan(2);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);
		cell = new PdfPCell(sImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);
		phrase = new Phrase("Direct Import (H-E-B importer of record)",
				PrintFormHelper.labelFont);
		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);
		cell = new PdfPCell(qImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);
		phrase = new Phrase("Indirect Import (H-E-B not importer of record)",
				PrintFormHelper.labelFont);
		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);
		// if (CPSHelper.isNotEmpty(printFormVO.getGuaranteeToStore())) {
		// phrase.add(new Phrase(printFormVO.getGuaranteeToStore().trim()
		// + " Days", PrintFormHelper.dataFont));
		// }

		return table;
	}

	private static PdfPTable getInitRetail(String initRetail,
			String retialLinkTo, boolean isMatrix, String margin,
			String subCommodity) throws DocumentException {

		float cellHeight = 15F;
		float[] f = { 10F, 10F, 80F };
		PdfPTable table = new PdfPTable(f);
		table.setWidthPercentage(f, PageSize.LETTER);
		Image sImage = getCheckBoxImage(isMatrix);
		// Phrase phrase ;
		// phrase = new Phrase("Sub Commodity: ", PrintFormHelper.labelFont);
		// if (CPSHelper.isNotEmpty(subCommodity)) {
		// phrase.add(new Phrase(subCommodity, PrintFormHelper.dataFont));
		// }
		// PdfPCell cell = new PdfPCell(phrase);
		// cell.setColspan(3);
		// cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		// cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		// cell.setBorderWidth(0.0F);
		// // cell.setFixedHeight(cellHeight);
		// table.addCell(cell);

		Phrase phrase = new Phrase("(1) Initial Retail: ",
				PrintFormHelper.labelFont);
		if (initRetail != null) {
			phrase.add(new Phrase(initRetail, PrintFormHelper.dataFont));
		}
		PdfPCell cell = new PdfPCell(phrase);
		cell.setColspan(3);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);

		phrase = new Phrase("-Or-", PrintFormHelper.dataFont);
		cell = new PdfPCell(phrase);
		cell.setColspan(3);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);

		phrase = new Phrase("(2) Retail Link to: ", PrintFormHelper.labelFont);
		if (retialLinkTo != null) {
			phrase.add(new Phrase(retialLinkTo, PrintFormHelper.dataFont));
		}
		cell = new PdfPCell(phrase);
		cell.setColspan(3);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);

		phrase = new Phrase("-Or-", PrintFormHelper.dataFont);
		cell = new PdfPCell(phrase);
		cell.setColspan(3);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);

		phrase = new Phrase("(3)", PrintFormHelper.labelFont);
		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);

		cell = new PdfPCell(sImage, false);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(cellHeight);
		cell.setBorderWidth(0.0F);
		table.addCell(cell);

		phrase = new Phrase("Use Matrix Margin ", PrintFormHelper.labelFont);
		phrase.add(new Phrase("  Margin: ", PrintFormHelper.labelFont));
		if (margin != null) {
			phrase.add(new Phrase(margin, PrintFormHelper.dataFont));
		}
		cell = new PdfPCell(phrase);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.0F);
		// cell.setColspan(2);
		cell.setFixedHeight(cellHeight);
		table.addCell(cell);

		return table;
	}

	private static PdfPTable getSRPP(Phrase phrase, boolean prePrice,
			Phrase prePricePhrase) throws DocumentException {
		float cellHeight = 15F;
		float[] f = { 60F, 10F, 30F };
		PdfPTable table = new PdfPTable(f);
		table.setWidthPercentage(f, PageSize.LETTER);
		Image sImage = getCheckBoxImage(prePrice);

		PdfPCell cell = new PdfPCell(phrase);
		cell.setBorderWidth(0.0F);
		// cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		cell = new PdfPCell(sImage, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		cell = new PdfPCell(prePricePhrase);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);

		return table;
	}

	private static PdfPTable setLastItem(Phrase dcPhrase, Phrase awcPhrase,
			boolean isAVC, boolean isDFP, boolean isTax, boolean isFS)
			throws DocumentException {
		float cellHeight = 13F;
		float[] f = { 10F, 50F };
		PdfPTable table = new PdfPTable(f);
		table.setWidthPercentage(f, PageSize.LETTER);
		Image avcImage = getCheckBoxImage(isAVC);
		Image dfpImage = getCheckBoxImage(isDFP);
		Image taxImage = getCheckBoxImage(isTax);
		Image fsImage = getCheckBoxImage(isFS);
		PdfPCell cell = new PdfPCell(dcPhrase);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		cell.setColspan(2);
		table.addCell(cell);

		cell = new PdfPCell(awcPhrase);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		cell.setColspan(2);
		table.addCell(cell);

		cell = new PdfPCell(avcImage, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("AVC", PrintFormHelper.labelFont));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);

		cell = new PdfPCell(dfpImage, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("Drug Facts Panel",
				PrintFormHelper.labelFont));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);

		cell = new PdfPCell(taxImage, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("Taxable", PrintFormHelper.labelFont));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);

		cell = new PdfPCell(fsImage, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("Food Stampable",
				PrintFormHelper.labelFont));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);
		return table;

	}

	private static PdfPTable setDRU(PrintFormVO printFormVO)
			throws DocumentException {
		float cellHeight = 13F;
		float[] fParrent = { 100F };
		PdfPTable tableParrent = new PdfPTable(fParrent);
		float[] f = { 10F, 40F, 10F, 40F };
		PdfPTable table = new PdfPTable(f);
		table.setWidthPercentage(f, PageSize.LETTER);
		Image drpImage = getCheckBoxImage(printFormVO.isDRP());
		Image rrpImage = getCheckBoxImage(printFormVO.isRRP());
		Phrase phrase = new Phrase("Type Of Display Ready Unit ",
				PrintFormHelper.labelFont);
		PdfPCell cell = new PdfPCell(phrase);
		cell.setColspan(2);
		cell.setBorderWidth(0.0F);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);
		phrase = new Phrase("(Ship Pack Sample Required)",
				PrintFormHelper.labelFont);
		cell = new PdfPCell(phrase);
		cell.setColspan(2);
		cell.setBorderWidth(0.0F);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);
		cell = new PdfPCell(drpImage, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("Display Ready Pallet",
				PrintFormHelper.labelFont));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);
		cell = new PdfPCell(rrpImage, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("Retail Ready Packaging",
				PrintFormHelper.labelFont));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);
		cell = new PdfPCell(table);
		cell.setBorderWidth(0.0F);
		tableParrent.addCell(cell);
		float[] fRows = { 25F, 25F, 25F, 25F };
		PdfPTable tableRow = new PdfPTable(fRows);
		phrase = new Phrase("Rows Facing :", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getRowsFacing())) {
			phrase.add(printFormVO.getRowsFacing());
		}
		cell = new PdfPCell(phrase);
		cell.setBorderWidth(0.0F);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		tableRow.addCell(cell);
		phrase = new Phrase("Rows Deep :", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getRowsDeep())) {
			phrase.add(printFormVO.getRowsDeep());
		}
		cell = new PdfPCell(phrase);
		cell.setBorderWidth(0.0F);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		tableRow.addCell(cell);
		phrase = new Phrase("Rows High   :", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getRowsHigh())) {
			phrase.add(printFormVO.getRowsHigh());
		}
		cell = new PdfPCell(phrase);
		cell.setBorderWidth(0.0F);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		tableRow.addCell(cell);
		phrase = new Phrase("Orientation :", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getOrientation())) {
			phrase.add(printFormVO.getOrientation());
		}
		cell = new PdfPCell(phrase);
		cell.setBorderWidth(0.0F);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		tableRow.addCell(cell);
		cell = new PdfPCell(tableRow);
		cell.setBorderWidth(0.0F);
		tableParrent.addCell(cell);
		return tableParrent;

	}

	private static PdfPTable getRSAT(boolean isAge, boolean isTime,
			Phrase phrase) throws DocumentException {
		float cellHeight = 15F;
		float[] f = { 40F, 10F, 13F, 10F, 13F };
		PdfPTable table = new PdfPTable(f);
		table.setWidthPercentage(f, PageSize.LETTER);
		Image aImage = getCheckBoxImage(isAge);
		Image tImage = getCheckBoxImage(isTime);

		PdfPCell cell = new PdfPCell(phrase);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);

		cell = new PdfPCell(aImage, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase("Age ", PrintFormHelper.labelFont));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);

		cell = new PdfPCell(tImage, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase("Time", PrintFormHelper.labelFont));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);
		return table;
	}

	private static PdfPTable getSNS(boolean sVal, boolean nVal, Phrase phrase)
			throws DocumentException {
		float cellHeight = 15F;
		float[] f = { 15F, 30F, 10F, 30F };
		PdfPTable table = new PdfPTable(f);
		table.setWidthPercentage(f, PageSize.LETTER);
		Image sImage = getCheckBoxImage(sVal);
		Image nImage = getCheckBoxImage(nVal);

		PdfPCell cell = new PdfPCell(sImage, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase("Sellable ", PrintFormHelper.labelFont));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);

		cell = new PdfPCell(nImage, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase("Non-Sellable",
				PrintFormHelper.labelFont));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);

		cell = new PdfPCell(phrase);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setColspan(4);
		table.addCell(cell);
		return table;
	}

	private static Image checkedImage = null;
	private static Image unCheckedImage = null;
	private static String contextPath = "";
	private static String image0 = "";
	private static String image1 = "";

	private static Image getCheckBoxImage(boolean isChecked) {
		// CustomResourceLocator.getResourceAsURL("logConf",
		// "chkBox1.jpg").getPath();
		Image image = null;
		try {
			if (isChecked) {
				if (checkedImage == null) {
					checkedImage = Image.getInstance(CustomResourceLocator
							.getResourceAsURL("logConf", "chkBox1.jpg")
							.getPath());
				}
				image = checkedImage;
			} else {
				if (unCheckedImage == null) {
					unCheckedImage = Image.getInstance(CustomResourceLocator
							.getResourceAsURL("logConf", "chkBox0.jpg")
							.getPath());
				}
				image = unCheckedImage;
			}
			image.scalePercent(25);
			image.setBorderWidth(0.0F);
		} catch (BadElementException e) {
			LOG.error(e.getMessage(), e);
		} catch (MalformedURLException e) {
			LOG.error(e.getMessage(), e);
		} catch (IOException e) {
			LOG.error(e.getMessage(), e);
		}
		return image;
	}

	private static PdfPTable getCell(Phrase phrase, float colWidth,
			boolean isChecked) throws DocumentException {
		float cellHeight = 15F;
		float[] f = { 15F, colWidth };
		PdfPTable table = new PdfPTable(f);
		float[] ff = { 15F, colWidth };
		table.setWidthPercentage(ff, PageSize.LETTER);
		Image image = getCheckBoxImage(isChecked);
		PdfPCell cell = new PdfPCell(image, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		cell = new PdfPCell(phrase);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);
		return table;
	}

	private static PdfPTable getCellFromList(List<Phrase> phraseList,
			float colWidth, boolean isChecked) throws DocumentException {
		float cellHeight = 15F;
		float[] f = { 10F, colWidth };
		PdfPTable table = new PdfPTable(f);
		float[] ff = { 10F, colWidth };
		table.setWidthPercentage(ff, PageSize.LETTER);
		Image image = null;
		image = getCheckBoxImage(isChecked);
		PdfPCell cell = new PdfPCell(image, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);

		cell = new PdfPCell(phraseList.get(0));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_TOP);
		table.addCell(cell);
		phraseList.remove(0);
		for (Phrase phrase : phraseList) {
			cell = new PdfPCell(phrase);
			cell.setBorderWidth(0.0F);
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setVerticalAlignment(Element.ALIGN_TOP);
			cell.setColspan(2);
			table.addCell(cell);
		}
		return table;
	}

	// private static Font labelFont = new Font(Font.TIMES_ROMAN, 9);
	// private static Font dataFont = new Font(Font.COURIER, 7);
	// private static Font dataFontBold = new Font(Font.BOLD, 10);
	private static Font labelFont = new Font(Font.TIMES_ROMAN, 9);
	private static Font dataFont = new Font(Font.COURIER, 9);
	private static Font dataFontBold = new Font(Font.BOLD, 10);
	private static Font dataFontBoldChild = new Font(Font.BOLD, 9);
	private static Font dataFontItatic = new Font(Font.ITALIC, 7);
	// private static String LightYellow = "#FFFF7F";
	private static Color lightYellow = new Color(255, 255, 127);

	// Lemon Chiffon #FFF8C6
	// Light Goldenrod Yellow #FAF8CC
	private static void setVendorTable(PrintFormVO printFormVO,
			PdfPTable table, Document document) throws DocumentException {
		Phrase phrase = new Phrase("Vendor Name: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getVendorName())) {
			phrase.add(new Phrase(printFormVO.getVendorName(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nVendor #: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getVendorNumber())) {
			phrase.add(new Phrase(printFormVO.getVendorNumber(),
					PrintFormHelper.dataFont));
		}
		PdfPCell cell = new PdfPCell(phrase);
		cell.setBackgroundColor(lightYellow);
		table.addCell(cell);

		phrase = new Phrase("*Contact Name: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getContactName())) {
			phrase.add(new Phrase(printFormVO.getContactName(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\n*Contact Phone: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getContactPhone())) {
			phrase.add(new Phrase(printFormVO.getContactPhone(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\n*Contact Email: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getContactEmail())) {
			phrase.add(new Phrase(printFormVO.getContactEmail(),
					PrintFormHelper.dataFont));
		}
		cell = new PdfPCell(phrase);
		cell.setBackgroundColor(lightYellow);
		table.addCell(cell);

		phrase = new Phrase("*Buyer Name: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getBuyerName())) {
			phrase.add(new Phrase(printFormVO.getBuyerName(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\n*Buyer Code: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getBuyerNumber())) {
			phrase.add(new Phrase(printFormVO.getBuyerNumber(),
					PrintFormHelper.dataFont));
		}
		cell = new PdfPCell(phrase);
		cell.setBackgroundColor(lightYellow);
		table.addCell(cell);
		document.add(table);

	}

	private static PdfPTable addLabel(String label) {
		PdfPTable table = new PdfPTable(5);
		PdfPCell cell2 = new PdfPCell(new Paragraph(label, dataFontBold));
		cell2.setColspan(5);
		cell2.setBorder(0);
		table.addCell(cell2);
		return table;
	}

	private static void setProductTable(PrintFormVO printFormVO,
			PdfPTable table, Document document) throws DocumentException {
		float[] f = { 20F, 25F, 25F, 25F, 20F };
		table = new PdfPTable(f);
		// table.addCell(getEmptyBox());
		PdfPCell cell2 = null;

		Phrase phrase = null;
		boolean isChecked = false;
		isChecked = printFormVO.getNewProduct();
		cell2 = new PdfPCell(getCell(new Phrase("New Product",
				PrintFormHelper.labelFont), 50F, isChecked));
		cell2.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell2.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		// BOX NEEDED
		List<Phrase> phraseList = new ArrayList<Phrase>();
		phrase = new Phrase("Replacement Product", PrintFormHelper.labelFont);
		phraseList.add(phrase);
		phrase = new Phrase("Replacing: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getReplacing())) {
			phrase.add(new Phrase(printFormVO.getReplacing(),
					PrintFormHelper.dataFont));
		}
		phraseList.add(phrase);
		// cell2 = new PdfPCell(phrase);
		cell2 = new PdfPCell(getCellFromList(phraseList, 60F,
				printFormVO.isReplacement()));
		cell2.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		// BOX NEEDED
		phraseList = new ArrayList<Phrase>();
		phrase = new Phrase("New Pack", PrintFormHelper.labelFont);
		phraseList.add(phrase);
		phrase = new Phrase("Existing Pack: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getExistingPack())) {
			phrase.add(new Phrase(printFormVO.getExistingPack(),
					PrintFormHelper.dataFont));
		}
		phraseList.add(phrase);
		cell2 = new PdfPCell(getCellFromList(phraseList, 60F,
				printFormVO.isNewPack()));
		cell2.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		// BOX NEEDED
		phraseList = new ArrayList<Phrase>();
		phrase = new Phrase("Bonus", PrintFormHelper.labelFont);
		phraseList.add(phrase);
		phrase = new Phrase("Open Stock:", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getOpenStock())) {
			phrase.add(new Phrase(CPSHelper.getTrimmedValue(printFormVO
					.getOpenStock()), PrintFormHelper.dataFont));
		}
		phraseList.add(phrase);
		cell2 = new PdfPCell(getCellFromList(phraseList, 60F,
				printFormVO.isBonus()));
		cell2.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);
		// BOX NEEDED
		phraseList = new ArrayList<Phrase>();
		phrase = new Phrase("MRT", PrintFormHelper.labelFont);
		phraseList.add(phrase);
		phrase = new Phrase("(elements included \n in comments)",
				PrintFormHelper.dataFont);
		phraseList.add(phrase);
		cell2 = new PdfPCell(getCellFromList(phraseList, 40F,
				printFormVO.isMRT()));
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);
		document.add(table);

		document.add(addLabel(""));

		table = new PdfPTable(3);
		/*
		 * phrase = new Phrase("Sellable", PrintFormHelper.labelFont);
		 * phrase.add(new Phrase("Non-Sellable\n", PrintFormHelper.labelFont));
		 */
		phrase = new Phrase("*Type: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getType())) {
			phrase.add(new Phrase(CPSHelper.getTrimmedValue(printFormVO
					.getType()), PrintFormHelper.dataFont));
		}
		boolean isSellable = false;
		if ("Sellable".equalsIgnoreCase(CPSHelper.getTrimmedValue(printFormVO
				.getProductType()))) {
			isSellable = true;
		}
		cell2 = new PdfPCell(getSNS(isSellable, !isSellable, phrase));
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		phrase = new Phrase("*Commodity: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getCommodity())) {
			phrase.add(new Phrase(CPSHelper.getTrimmedValue(printFormVO
					.getCommodity()), PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\n*Sub Commodity: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getSubCommodity())) {
			phrase.add(new Phrase(CPSHelper.getTrimmedValue(printFormVO
					.getSubCommodity()), PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\n*Unit UPC: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getUnitUPC())) {
			phrase.add(new Phrase(CPSHelper.getTrimmedValue(printFormVO
					.getUnitUPC()), PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		phrase = new Phrase("*Brand: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getBrand())) {
			phrase.add(new Phrase(CPSHelper.getTrimmedValue(printFormVO
					.getBrand()), PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nSub Brand: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getSubBrand())) {
			phrase.add(new Phrase(CPSHelper.getTrimmedValue(printFormVO
					.getSubBrand()), PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		document.add(table);
		document.add(addLabel(""));
		table = null;

		table = new PdfPTable(3);
		phrase = new Phrase("*Product Description: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getProductDescription())) {
			phrase.add(new Phrase(CPSHelper.getTrimmedValue(printFormVO
					.getProductDescription()), PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		cell2.setColspan(3);
		table.addCell(cell2);

		phrase = new Phrase("*Total Volume: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getTotalVolumn())) {
			phrase.add(new Phrase(printFormVO.getTotalVolumn(),
					PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		phrase = new Phrase("*UOM: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getUOM())) {
			phrase.add(new Phrase(printFormVO.getUOM(),
					PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		phrase = new Phrase("*Retail Size: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getSize())) {
			phrase.add(new Phrase(printFormVO.getSize(),
					PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);
		document.add(table);

		table = new PdfPTable(4);

		phrase = new Phrase("Product Length: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getProductLength())) {
			phrase.add(new Phrase(printFormVO.getProductLength() + " in",
					PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		phrase = new Phrase("Product Width: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getProductWidth())) {
			phrase.add(new Phrase(printFormVO.getProductWidth() + " in",
					PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		phrase = new Phrase("Product Height: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getProductHeight())) {
			phrase.add(new Phrase(printFormVO.getProductHeight() + " in",
					PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		phrase = new Phrase("*Packaging: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getPackaging())) {
			phrase.add(new Phrase(printFormVO.getPackaging(),
					PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);

		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);
		phrase = new Phrase("Deal Offered", PrintFormHelper.labelFont);
		cell2 = new PdfPCell(getCell(phrase, 40F, printFormVO.isDealOffered()));
		cell2.setColspan(2);
		cell2.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		phrase = new Phrase("Guaranteed Sale", PrintFormHelper.labelFont);
		cell2 = new PdfPCell(getCell(phrase, 40F,
				printFormVO.isGuaranteedSale()));
		cell2.setColspan(2);
		cell2.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		document.add(table);

		document.add(addLabel(""));

		table = new PdfPTable(3);

		phrase = new Phrase("Suggested Retail: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getSuggestedRetail())) {
			phrase.add(new Phrase(printFormVO.getSuggestedRetail(),
					PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(getSRPP(phrase, printFormVO.isPrePriced(),
				new Phrase("Pre-Priced", PrintFormHelper.labelFont)));
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		phrase = new Phrase("Restricted Sales:", PrintFormHelper.labelFont);
		boolean isAge = false;
		if (CPSHelper.isNotEmpty(printFormVO.getAge())) {
			isAge = true;
		}
		boolean isTime = false;
		if (CPSHelper.isNotEmpty(printFormVO.getTime())) {
			isTime = true;
		}
		cell2 = new PdfPCell(getRSAT(isAge, isTime, phrase));
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		phrase = new Phrase("Family Code 1: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getFamilyCode1())) {
			phrase.add(new Phrase(printFormVO.getFamilyCode1(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("  ", PrintFormHelper.labelFont));
		phrase.add(new Phrase("Family Code 2: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getFamilyCode2())) {
			phrase.add(new Phrase(printFormVO.getFamilyCode2(),
					PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);
		document.add(table);
		document.add(addLabel(""));

		table = new PdfPTable(4);

		phrase = new Phrase("Tare Weight: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getTareWeight())) {
			phrase.add(new Phrase(printFormVO.getTareWeight(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nScale Tare Weight: ",
				PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getScaleTareWeight())) {
			phrase.add(new Phrase(printFormVO.getScaleTareWeight(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nVariable Weight: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getScaleTareWeight())) {
			phrase.add(new Phrase(printFormVO.getScaleTareWeight(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nCatch Weight: ", PrintFormHelper.labelFont));
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		phrase = new Phrase("Ingredients: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getIngredients())) {
			phrase.add(new Phrase(printFormVO.getIngredients(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nNutrition: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getNutrition())) {
			phrase.add(new Phrase(printFormVO.getNutrition(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nAction Code: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getActionCode())) {
			phrase.add(new Phrase(printFormVO.getActionCode(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nGraphics Code: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getGraphicsCode())) {
			phrase.add(new Phrase(printFormVO.getGraphicsCode(),
					PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		phrase = new Phrase("NDC: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getNDC())) {
			phrase.add(new Phrase(printFormVO.getNDC(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nDrug Schedule: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getDrugSchedule())) {
			phrase.add(new Phrase(printFormVO.getDrugSchedule(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nDrug Abb: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getDrugAbb())) {
			phrase.add(new Phrase(printFormVO.getDrugAbb(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nPSE: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getPseGr())) {
			// phrase.add(new Phrase(printFormVO.getPseType() + " gr.",
			// PrintFormHelper.dataFont));
			// phrase.add(new Phrase(printFormVO.getPseType(),
			// PrintFormHelper.dataFont)); PrintFormHelper.dataFont));
		}
		cell2 = new PdfPCell(phrase);
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		Phrase dcPhrase = new Phrase("Direct Cost: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getDirectCost())) {
			dcPhrase.add(new Phrase(printFormVO.getDirectCost(),
					PrintFormHelper.dataFont));
		}

		Phrase awcPhrase = new Phrase("Avg Whsl Cost: ",
				PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getAvgWhslCost())) {
			awcPhrase.add(new Phrase(printFormVO.getAvgWhslCost(),
					PrintFormHelper.dataFont));
		}

		// cell2 = new PdfPCell(setLastItem(dcPhrase, awcPhrase, printFormVO
		// .isAVC(), printFormVO.isDrugFactsPanel(), printFormVO
		// .isTaxFlag(), printFormVO.isFoodStamp()));
		cell2 = new PdfPCell(setLastItem(dcPhrase, awcPhrase, false,
				printFormVO.isDrugFactsPanel(), printFormVO.isTaxFlag(),
				printFormVO.isFoodStamp()));
		cell2.setBackgroundColor(lightYellow);
		table.addCell(cell2);

		document.add(table);
	}

	private static boolean isDSD(final String channel) {
		if ("D".equalsIgnoreCase(channel) || "DSD".equalsIgnoreCase(channel)) {
			return true;
		}
		return false;
	}

	private static void setCasePackTable(PrintFormVO printFormVO,
			Document document) throws DocumentException {
		PdfPTable table = new PdfPTable(3);
		PdfPCell cell8 = null;
		Phrase phrase = new Phrase("Delivered to: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getDeliveredTo())) {
			phrase.add(new Phrase(printFormVO.getDeliveredTo(),
					PrintFormHelper.dataFont));
		}
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(lightYellow);
		table.addCell(cell8);

		phrase = new Phrase("T2T Vendor: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getT2tVendor())) {
			phrase.add(new Phrase(printFormVO.getT2tVendor(),
					PrintFormHelper.dataFont));
		}
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(lightYellow);
		table.addCell(cell8);

		phrase = new Phrase("Cost Owner: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getCostOwner())) {
			phrase.add(new Phrase(printFormVO.getCostOwner(),
					PrintFormHelper.dataFont));
		}
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(lightYellow);
		table.addCell(cell8);

		phrase = new Phrase("DSD Store# or Group#: ", PrintFormHelper.labelFont);
		if (null != printFormVO.getCostGroups()
				&& !printFormVO.getCostGroups().isEmpty()) {
			int index = 0;

			String dsdStoreGroup = printFormVO.getDsdStoreGroup();
			int lengcostGroup = 0;
			for (String costGroup : printFormVO.getCostGroups()) {
				String strtemp = "";
				if (costGroup.contains("*"))
					strtemp = "    ";
				else
					strtemp = "  ";
				if (dsdStoreGroup.contains("\n" + costGroup + strtemp)) {
					phrase.add(new Phrase("\n" + costGroup,
							PrintFormHelper.dataFontBold));
				} else {
					phrase.add(new Phrase(costGroup,
							PrintFormHelper.dataFontBold));
				}
				lengcostGroup = costGroup.length();
				String storesCostGroup = "";
				if (index == printFormVO.getCostGroups().size() - 1) {
					if (dsdStoreGroup.indexOf("\n" + costGroup + strtemp + "(") > 0) {
						storesCostGroup = dsdStoreGroup.substring(dsdStoreGroup
								.indexOf("\n" + costGroup + strtemp + "(")
								+ lengcostGroup + strtemp.length() + 1);
					} else if (dsdStoreGroup.indexOf(costGroup + strtemp + "(") > 0) {
						storesCostGroup = dsdStoreGroup.substring(dsdStoreGroup
								.indexOf(costGroup + strtemp + "(")
								+ lengcostGroup + strtemp.length());
					} else if (printFormVO.getCostGroups().size() - 1 == 0
							&& costGroup.contains("*")) {
						storesCostGroup = dsdStoreGroup.substring(dsdStoreGroup
								.indexOf(costGroup + strtemp + "(")
								+ lengcostGroup + strtemp.length());
					}

				} else {//
					int startSub = 0;
					int endSub = 0;
					if (dsdStoreGroup.indexOf("\n" + costGroup + strtemp + "(") > 0) {
						startSub = dsdStoreGroup.indexOf("\n" + costGroup
								+ strtemp + "(")
								+ lengcostGroup + strtemp.length() + 1;
					} else if (dsdStoreGroup.indexOf(costGroup + strtemp + "(") > 0) {
						startSub = dsdStoreGroup.indexOf(costGroup + strtemp
								+ "(")
								+ lengcostGroup + strtemp.length();
					} else {
						startSub = 0;
					}
					if (dsdStoreGroup.indexOf(")," + "\n"
							+ printFormVO.getCostGroups().get(index + 1)) > 0) {
						endSub = dsdStoreGroup.indexOf(")," + "\n"
								+ printFormVO.getCostGroups().get(index + 1));
					} else if (dsdStoreGroup.indexOf("),"
							+ printFormVO.getCostGroups().get(index + 1)) > 0) {
						endSub = dsdStoreGroup.indexOf("),"
								+ printFormVO.getCostGroups().get(index + 1));
					} else {
						endSub = 0;
					}
					if (endSub == 0) {
						storesCostGroup = ",";
					} else {
						if (startSub == 0) {
							startSub = lengcostGroup + strtemp.length();
						}
						storesCostGroup = dsdStoreGroup.substring(startSub,
								endSub + 2);
					}
					if (CPSHelper.isEmpty(storesCostGroup)) {
						storesCostGroup = ",";
					}
				}
				if (!CPSHelper.isEmpty(storesCostGroup)) {
					phrase.add(new Phrase(storesCostGroup,
							PrintFormHelper.dataFont));
				}
				index++;
			}
		}

		// phrase.add(new Phrase(printFormVO.getDsdStoreGroup(),
		// PrintFormHelper.dataFont));
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(lightYellow);
		cell8.setColspan(3);
		table.addCell(cell8);
		phrase = new Phrase("Exp Wkly Mvmt: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getExpWklyMvmt())) {
			phrase.add(new Phrase(printFormVO.getExpWklyMvmt(),
					PrintFormHelper.dataFont));
		}
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(lightYellow);
		table.addCell(cell8);

		phrase = new Phrase("Case UPC: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getCaseUPC())) {
			phrase.add(new Phrase(printFormVO.getCaseUPC(),
					PrintFormHelper.dataFont));
		}
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(lightYellow);
		table.addCell(cell8);

		phrase = new Phrase("Country of Origin: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getCountryOfOrigin())) {
			phrase.add(new Phrase(printFormVO.getCountryOfOrigin(),
					PrintFormHelper.dataFont));
		}
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(lightYellow);
		table.addCell(cell8);

		phrase = new Phrase("Case Description: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getCaseDescription())) {
			phrase.add(new Phrase(printFormVO.getCaseDescription(),
					PrintFormHelper.dataFont));
		}
		PdfPCell cell9 = new PdfPCell(phrase);
		cell9.setBackgroundColor(lightYellow);
		cell9.setColspan(2);
		table.addCell(cell9);

		phrase = new Phrase("VPC: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getVpc())) {
			phrase.add(new Phrase(printFormVO.getVpc(),
					PrintFormHelper.dataFont));
		}
		cell8 = new PdfPCell(phrase);
		cell8.setBackgroundColor(lightYellow);
		table.addCell(cell8);
		document.add(table);

		table = new PdfPTable(6);
		PdfPCell cell10 = null;

		phrase = new Phrase("Master Pack: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getMasterPack())) {
			phrase.add(new Phrase(printFormVO.getMasterPack(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Length: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getMasterPackLength())) {
			phrase.add(new Phrase(printFormVO.getMasterPackLength()
					+ CPSConstants.IN_UNIT, PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Width: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getMasterPackWidth())) {
			phrase.add(new Phrase(printFormVO.getMasterPackWidth()
					+ CPSConstants.IN_UNIT, PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Height: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getMasterPackHeight())) {
			phrase.add(new Phrase(printFormVO.getMasterPackHeight()
					+ CPSConstants.IN_UNIT, PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Cube: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getMasterPackCube())) {
			phrase.add(new Phrase(printFormVO.getMasterPackCube(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Weight: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getMasterPackWeight())) {
			phrase.add(new Phrase(printFormVO.getMasterPackWeight()
					+ CPSConstants.LB_UNIT, PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Inner Pack: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getShipPack())) {
			phrase.add(new Phrase(printFormVO.getShipPack(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Length: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getShipPackLength())) {
			phrase.add(new Phrase(printFormVO.getShipPackLength()
					+ CPSConstants.IN_UNIT, PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Width: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getShipPackWidth())) {
			phrase.add(new Phrase(printFormVO.getShipPackWidth()
					+ CPSConstants.IN_UNIT, PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Height: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getShipPackHeight())) {
			phrase.add(new Phrase(printFormVO.getShipPackHeight()
					+ CPSConstants.IN_UNIT, PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Cube: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getShipPackCube())) {
			phrase.add(new Phrase(printFormVO.getShipPackCube(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Weight: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getShipPackWeight())) {
			phrase.add(new Phrase(printFormVO.getShipPackWeight()
					+ CPSConstants.LB_UNIT, PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		document.add(table);
		table = null;

		float f[] = { 20F, 20F, 25F, 60F };
		table = new PdfPTable(f);
		phrase = new Phrase("Vendor Tie: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getVendorTie())) {
			phrase.add(new Phrase(printFormVO.getVendorTie(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Vendor Tier: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getVendorTier())) {
			phrase.add(new Phrase(printFormVO.getVendorTier(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("One Touch Type: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getOneTouchType())) {
			phrase.add(new Phrase(CPSHelper.getTrimmedValue(printFormVO
					.getOneTouchType()), PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Code Date", PrintFormHelper.labelFont);
		phrase.add(new Phrase("  Max Shelf Life: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getMaxShelfLife())) {
			phrase.add(new Phrase(printFormVO.getMaxShelfLife() + " Days",
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(getCell(phrase, 80F, printFormVO.isCodeDate()));
		cell10.setBackgroundColor(lightYellow);
		cell10.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell10);

		document.add(table);

		table = new PdfPTable(5);

		boolean isImport = false;
		if ("True".equalsIgnoreCase(printFormVO.getImportd())) {
			isImport = true;
		}
		phrase = new Phrase("Import", PrintFormHelper.labelFont);
		cell10 = new PdfPCell(getCell(phrase, 60F, isImport));
		cell10.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Container Size: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getContainerSize())) {
			phrase.add(new Phrase(printFormVO.getContainerSize(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nInco Terms: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getIncoTerms())) {
			phrase.add(new Phrase(printFormVO.getIncoTerms(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Color: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getColor())) {
			phrase.add(new Phrase(printFormVO.getColor(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nFreight: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getFreight())) {
			phrase.add(new Phrase(printFormVO.getFreight(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Min Type: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getMinType())) {
			phrase.add(new Phrase(printFormVO.getMinType(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nMin Qty: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getMinQty())) {
			phrase.add(new Phrase(printFormVO.getMinQty(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Pickup Point: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getPickupPoint())) {
			phrase.add(new Phrase(printFormVO.getPickupPoint(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nRate%: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getRatePercentage())) {
			phrase.add(new Phrase(printFormVO.getRatePercentage(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);
		document.add(table);

		table = new PdfPTable(3);
		phrase = new Phrase("1st Ship Date: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getFirstShipDate())) {
			phrase.add(new Phrase(printFormVO.getFirstShipDate(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("Proration Date: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getProrationDate())) {
			phrase.add(new Phrase(printFormVO.getProrationDate(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		phrase = new Phrase("In-Store Date: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getInStoreDate())) {
			phrase.add(new Phrase(printFormVO.getInStoreDate(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);
		document.add(table);
		table = null;

		table = new PdfPTable(3);
		phrase = new Phrase("*List Cost: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getListCost())) {
			phrase.add(new Phrase(printFormVO.getListCost(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);
		phrase = new Phrase("Unit Cost: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getUnitCost())) {
			phrase.add(new Phrase(printFormVO.getUnitCost(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(phrase);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);
		// BOX
		boolean isCostLink = false;
		if (CPSHelper.isNotEmpty(printFormVO.getCostLink())) {
			if (CPSHelper.isNotEmpty(printFormVO.getChannel())) {
				// No cost link for DSD cases
				// if(!isDSD(printFormVO.getChannel())){
				isCostLink = true;
				// }
			}
		}
		phrase = new Phrase("Cost Link ", PrintFormHelper.labelFont);
		phrase.add(new Phrase("   Link To: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getLinkTo())) {
			phrase.add(new Phrase(printFormVO.getLinkTo(),
					PrintFormHelper.dataFont));
		}
		cell10 = new PdfPCell(getCell(phrase, 50F, isCostLink));
		cell10.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell10.setBackgroundColor(lightYellow);
		table.addCell(cell10);

		/*
		 * table.addCell(new PdfPCell(new Phrase("Item Size: " + (null !=
		 * printFormVO.getItemSize() ? printFormVO .getItemSize() : " "),
		 * font)));
		 */
		document.add(table);
	}

	private static void setComments(PrintFormVO printFormVO, Document document)
			throws DocumentException {
		document.add(addLabel(""));
		Font font = new Font(Font.TIMES_ROMAN, 10);
		PdfPTable table = new PdfPTable(2);
		PdfPCell cell15 = null;
		Phrase phrase = new Phrase("Comments: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getComments())) {
			phrase.add(new Phrase(printFormVO.getComments(),
					PrintFormHelper.dataFont));
		}
		cell15 = new PdfPCell(phrase);
		cell15.setMinimumHeight(40);
		// cell15.setColspan(2);
		cell15.setBackgroundColor(lightYellow);
		table.addCell(cell15);
		// Phrase phraseDRU = new Phrase("Type Of DRU: ",
		// PrintFormHelper.labelFont);
		cell15 = new PdfPCell(setDRU(printFormVO));
		cell15.setBackgroundColor(lightYellow);
		table.addCell(cell15);
		document.add(table);

		table = null;
		table = new PdfPTable(1);
		float cellHeight = 13F;
		float[] ftable = { 15F, 170F, 15F, 170F };
		PdfPTable tableChild = new PdfPTable(ftable);
		tableChild.setWidthPercentage(ftable, PageSize.LETTER);
		Image imageSP = getCheckBoxImage(printFormVO.isSampleProvided());
		Image imageSSA = getCheckBoxImage(printFormVO.isSpecSheetAttached());

		PdfPCell cell = new PdfPCell(imageSP, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setBackgroundColor(lightYellow);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		tableChild.addCell(cell);

		cell = new PdfPCell(new Phrase("Sample Provided",
				PrintFormHelper.labelFont));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setBackgroundColor(lightYellow);
		tableChild.addCell(cell);

		cell = new PdfPCell(imageSSA, false);
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setBackgroundColor(lightYellow);
		tableChild.addCell(cell);

		cell = new PdfPCell(new Phrase("Spec Sheet Provided",
				PrintFormHelper.labelFont));
		cell.setBorderWidth(0.0F);
		cell.setFixedHeight(cellHeight);
		cell.setBackgroundColor(lightYellow);
		tableChild.addCell(cell);

		PdfPCell cell1Parent = new PdfPCell(tableChild);
		cell1Parent.setBorderWidth(0.1F);
		cell1Parent.setBackgroundColor(lightYellow);
		table.addCell(cell1Parent);
		document.add(table);

		table = null;
		table = new PdfPTable(2);
		cell15 = new PdfPCell(new Phrase("Vendor Signature: ", font));
		cell15.setBackgroundColor(lightYellow);
		table.addCell(cell15);
		cell15 = new PdfPCell(new Phrase("Date: ", font));
		cell15.setBackgroundColor(lightYellow);
		table.addCell(cell15);
		document.add(table);
	}

	private static void setHebBuyer(PrintFormVO printFormVO, Document document)
			throws DocumentException {
		Font font = new Font(Font.TIMES_ROMAN, 10);
		float f[] = { 27F, 33F, 20F, 20F };
		PdfPTable table = new PdfPTable(f);
		document.add(addLabel("H-E-B Buyer"));
		PdfPCell cell18 = null;
		Phrase phrase = new Phrase("Sub-Commodity: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getSubCommodity())) {
			phrase.add(new Phrase(printFormVO.getSubCommodity(),
					PrintFormHelper.dataFont));
		}
		cell18 = new PdfPCell(phrase);
		cell18.setColspan(4);
		table.addCell(cell18);
		phrase = new Phrase("Establish Initial Price: ",
				PrintFormHelper.dataFontBoldChild);
		table.addCell(new PdfPCell(phrase));
		phrase = new Phrase("Code Dated Products (in days): ",
				PrintFormHelper.dataFontBoldChild);
		table.addCell(new PdfPCell(phrase));
		phrase = new Phrase(new Phrase("Purchase Intent: ",
				PrintFormHelper.dataFontBoldChild));
		table.addCell(new PdfPCell(phrase));
		phrase = new Phrase("Other Product Attributes: ",
				PrintFormHelper.dataFontBoldChild);
		table.addCell(new PdfPCell(phrase));

		// getInitRetail
		/*
		 * PdfPCell cell18 = null; phrase = new Phrase("*Initial Retail: ",
		 * PrintFormHelper.labelFont);
		 * if(CPSHelper.isNotEmpty(printFormVO.getInitialRetail())){
		 * phrase.add(new Phrase(printFormVO.getInitialRetail(),
		 * PrintFormHelper.dataFont)); } phrase.add(new Phrase(
		 * "\n-Or-\nRetail Link To: ", PrintFormHelper.labelFont));
		 * if(CPSHelper.isNotEmpty(printFormVO.getRetailLinkTo())){
		 * phrase.add(new Phrase(printFormVO.getRetailLinkTo(),
		 * PrintFormHelper.dataFont)); } phrase.add(new Phrase(
		 * "\n-Or-\nUse Matrix Margin", PrintFormHelper.labelFont));
		 * phrase.add(new Phrase(" Margin: ", PrintFormHelper.labelFont));
		 * if(CPSHelper.isNotEmpty(printFormVO.getMargin())){ phrase.add(new
		 * Phrase(printFormVO.getMargin(), PrintFormHelper.dataFont)); }
		 */

		boolean isMargin = false;
		if (CPSHelper.isNotEmpty(printFormVO.getMargin())) {
			isMargin = true;
		}
		table.addCell(getInitRetail(printFormVO.getInitialRetail(),
				printFormVO.getRetailLinkTo(), isMargin,
				printFormVO.getMargin(), printFormVO.getSubCommodity()));

		/*
		 * phrase = new Phrase("Sold By Lb", PrintFormHelper.labelFont);
		 * phrase.add(new Phrase("\nQty Restricted",
		 * PrintFormHelper.labelFont)); phrase.add(new Phrase("\nFSA Eligible",
		 * PrintFormHelper.labelFont)); cell18 = new PdfPCell(phrase);
		 * table.addCell(cell18);
		 */

		// cell18 = new PdfPCell(getSQF(printFormVO.isSoldByLb(), printFormVO
		// .isQtyRestricted(), printFormVO.isFSAEligible()));
		// cell18 = new PdfPCell(getSQF(false, printFormVO
		// .isQtyRestricted(), false));
		// table.addCell(cell18);
		// phrase = new Phrase("Order Unit: ", PrintFormHelper.labelFont);
		// if (CPSHelper.isNotEmpty(printFormVO.getOrderUnit())) {
		// phrase.add(new Phrase(printFormVO.getOrderUnit(),
		// PrintFormHelper.dataFont));
		// }
		// phrase.add(new Phrase("\nCents Off: ", PrintFormHelper.labelFont));
		// if (CPSHelper.isNotEmpty(printFormVO.getCentsOff())) {
		// phrase.add(new Phrase(printFormVO.getCentsOff(),
		// PrintFormHelper.dataFont));
		// }
		// phrase
		// .add(new Phrase("\n% Off Pre-price: ",
		// PrintFormHelper.labelFont));
		// if (CPSHelper.isNotEmpty(printFormVO.getOffPrePricePercentage())) {
		// phrase.add(new Phrase(printFormVO.getOffPrePricePercentage(),
		// PrintFormHelper.dataFont));
		// }
		// cell18 = new PdfPCell(phrase);
		// table.addCell(cell18);

		// phrase = new Phrase("Inbound Spec: ", PrintFormHelper.labelFont);
		// if (CPSHelper.isNotEmpty(printFormVO.getInboundSpec())) {
		// phrase.add(new Phrase(
		// printFormVO.getInboundSpec().trim() + " Days",
		// PrintFormHelper.dataFont));
		// }
		// phrase.add(new Phrase("\nReaction: ", PrintFormHelper.labelFont));
		// if (CPSHelper.isNotEmpty(printFormVO.getReaction())) {
		// phrase.add(new Phrase(printFormVO.getReaction().trim() + " Days",
		// PrintFormHelper.dataFont));
		// }
		// phrase.add(new Phrase("\nGuarantee to Store: ",
		// PrintFormHelper.labelFont));
		// if (CPSHelper.isNotEmpty(printFormVO.getGuaranteeToStore())) {
		// phrase.add(new Phrase(printFormVO.getGuaranteeToStore().trim()
		// + " Days", PrintFormHelper.dataFont));
		// }
		// cell18 = new PdfPCell(phrase);
		// table.addCell(cell18);
		cell18 = new PdfPCell(getCodeDatedProducts(printFormVO));
		table.addCell(cell18);
		phrase = new Phrase("Seasonality: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getSeasonality())) {
			phrase.add(new Phrase(printFormVO.getSeasonality(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nSeasonality YR: ", PrintFormHelper.labelFont));
		if (CPSHelper.isNotEmpty(printFormVO.getSeasonYear())) {
			phrase.add(new Phrase(printFormVO.getSeasonYear().trim(),
					PrintFormHelper.dataFont));
		}
		phrase.add(new Phrase("\nOrder Guide Name: ", PrintFormHelper.labelFont));
		table.addCell(new PdfPCell(phrase));
		PdfPCell cell21 = new PdfPCell(getOrderAttribute(
				printFormVO.isSoldByLb(), printFormVO.isFSAEligible()));
		table.addCell(cell21);
		document.add(table);
		table = null;

		table = new PdfPTable(1);
		PdfPCell cell19 = new PdfPCell(new Phrase("Comments(13 Screen): ",
				PrintFormHelper.labelFont));
		cell19.setMinimumHeight(40);
		table.addCell(cell19);
		document.add(table);
		table = null;

		table = new PdfPTable(2);
		PdfPCell cell20 = new PdfPCell();
		cell20.setColspan(2);
		table.addCell(new PdfPCell(new Phrase("Buyer Signature: ", font)));
		table.addCell(new PdfPCell(new Phrase("Date: ", font)));
		document.add(table);
	}

	private static void setHebSupplyChain(PrintFormVO printFormVO,
			Document document) throws DocumentException {
		Font font = new Font(Font.TIMES_ROMAN, 9);
		PdfPTable table = new PdfPTable(4);
		document.add(addLabel("H-E-B Supply Chain"));
		PdfPCell cell21 = null;
		Phrase phrase = new Phrase("Order Restriction: ",
				PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getOrderRestriction())) {
			phrase.add(new Phrase(printFormVO.getOrderRestriction(),
					PrintFormHelper.dataFont));
		}
		cell21 = new PdfPCell(phrase);
		cell21.setBackgroundColor(Color.LIGHT_GRAY);
		table.addCell(new PdfPCell(cell21));
		phrase = new Phrase("Max Ship: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getMaxShip())) {
			phrase.add(new Phrase(printFormVO.getMaxShip(),
					PrintFormHelper.dataFont));
		}
		cell21 = new PdfPCell(phrase);
		cell21.setBackgroundColor(Color.LIGHT_GRAY);
		table.addCell(cell21);
		phrase = new Phrase("Order unit: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getOrderUnit())) {
			phrase.add(new Phrase(printFormVO.getOrderUnit(),
					PrintFormHelper.dataFont));
		}
		cell21 = new PdfPCell(phrase);
		cell21.setBackgroundColor(Color.LIGHT_GRAY);
		table.addCell(cell21);
		phrase = new Phrase("Whse#: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getWhseNumber())) {
			phrase.add(new Phrase(printFormVO.getWhseNumber()));
		}
		cell21 = new PdfPCell(phrase);
		cell21.setBackgroundColor(Color.LIGHT_GRAY);
		table.addCell(cell21);
		// table.addCell(cell21);
		document.add(table);

		table = new PdfPTable(2);
		PdfPCell cell22 = new PdfPCell(new Phrase("SCA Signature: ", font));
		cell22.setBackgroundColor(Color.LIGHT_GRAY);
		table.addCell(new PdfPCell(cell22));

		cell22 = new PdfPCell(new Phrase("Date: ", font));
		cell22.setBackgroundColor(Color.LIGHT_GRAY);
		table.addCell(cell22);
		document.add(table);
	}

	private static void setHebAdmin(PrintFormVO printFormVO, Document document)
			throws DocumentException {
		document.add(addLabel("H-E-B Admin"));
		Font font = new Font(Font.TIMES_ROMAN, 9);
		PdfPTable table = new PdfPTable(2);
		Phrase phrase = new Phrase("Whse Item Code: ",
				PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getItemCode())
				&& !"null".equalsIgnoreCase(printFormVO.getItemCode())) {
			phrase.add(new Phrase(printFormVO.getItemCode(),
					PrintFormHelper.dataFont));
		}
		PdfPCell cell23 = new PdfPCell(phrase);
		// cell23.setColspan(2);
		cell23.setBackgroundColor(Color.ORANGE);
		table.addCell(cell23);
		phrase = new Phrase("Item Category: ", PrintFormHelper.labelFont);
		if (CPSHelper.isNotEmpty(printFormVO.getItemCategory())) {
			phrase.add(new Phrase(printFormVO.getItemCategory(),
					PrintFormHelper.dataFont));
		}
		cell23 = new PdfPCell(phrase);
		cell23.setBackgroundColor(Color.ORANGE);
		table.addCell(cell23);
		PdfPCell cell24 = new PdfPCell(getSampleProvided(printFormVO));
		cell24.setBackgroundColor(Color.ORANGE);
		cell24.setColspan(2);
		table.addCell(cell24);
		cell23 = new PdfPCell(new Phrase("Admin Signature: ", font));
		cell23.setBackgroundColor(Color.ORANGE);
		table.addCell(cell23);
		cell23 = new PdfPCell(new Phrase("Date: ", font));
		cell23.setBackgroundColor(Color.ORANGE);
		table.addCell(cell23);
		document.add(table);
	}

	private static void createPDF(PrintFormVO printFormVO, Document document)
			throws DocumentException {
		// / HEADER - HEB Candidate Introduction
		PdfPTable table = new PdfPTable(3);
		Font font = new Font(Font.TIMES_ROMAN, 10);
		Font headingFont = new Font(Font.TIMES_ROMAN, 13);
		PdfPCell cell = new PdfPCell(new Paragraph(
				"H-E-B Candidate Introduction", headingFont));
		cell.setColspan(3);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setBorder(0);
		table.addCell(cell);

		// PdfPCell cellDate = new PdfPCell(new Phrase("Created on: "
		// + CPSHelper.getDateAsString(new Date()), font));
		PdfPCell cellDate = new PdfPCell(new Phrase("Created on: "
				+ CPSHelper.getDateAsString(printFormVO.getCreateOn()), font));
		cellDate.setColspan(3);
		cellDate.setHorizontalAlignment(Element.ALIGN_CENTER);
		cellDate.setBorder(0);
		table.addCell(cellDate);
		// Header END

		// VENDOR SECTION.
		setVendorTable(printFormVO, table, document);

		table = addLabel("Product");
		document.add(table);
		setProductTable(printFormVO, table, document);
		document.add(addLabel("Case Pack"));
		setCasePackTable(printFormVO, document);
		setComments(printFormVO, document);
		setHebBuyer(printFormVO, document);
		setHebSupplyChain(printFormVO, document);
		setHebAdmin(printFormVO, document);
	}

	private static PrintFormVO generatePDFDocument(PrintFormVO printFormVO,
			String id, HttpServletRequest request, HttpServletResponse response) {
		FileOutputStream fos = null;
		String path = null;
		try {
			response.setContentType("application/pdf");

			Document document = new Document();
			document.setPageSize(PageSize.A4);
			// set margin
			document.setMargins(-70, -70, 0, 0);

			PrintFormDirectory directory = new PrintFormDirectory();
			directory.printForm(request);
			String filePath = directory.getFilePath(request);
			PdfWriter.getInstance(document, new FileOutputStream(new File(
					filePath + System.getProperty("file.separator")
							+ "H-E-B_Candidate_Introduction_" + id + ".pdf")));
			path = filePath + System.getProperty("file.separator")
					+ "H-E-B Candidate Introduction_" + id + ".pdf";
			printFormVO.setFilePath(path);
			printFormVO
					.setFileName("H-E-B_Candidate_Introduction_" + id + ".pdf");
			if (null != printFormVO.getVendorName())
				printFormVO.setDisplayToUser(printFormVO.getVendorName());
			else
				printFormVO
						.setDisplayToUser("H-E-B_Candidate_Introduction_" + id);
			document.open();

			createPDF(printFormVO, document);

			document.close();
		} catch (Exception ex) {
			// LOG.fatal("Exception:-", ex);
		} finally {
			if (fos != null) {
				try {
					fos.close();
				} catch (Exception ex) {
					// LOG.fatal("Exception:-", ex);
				}
			}
		}
		return printFormVO;
	}

	/*
	 * private static PrintFormVO generatePDFDocumentOld(PrintFormVO
	 * printFormVO, String id, HttpServletRequest request, HttpServletResponse
	 * response) { FileOutputStream fos = null; String path = null; try {
	 * response.setContentType("application/pdf"); Document document = new
	 * Document(); document.setPageSize(PageSize.LETTER); // CHANGE TO 30, 30
	 * document.setMargins(30, 10, 30, 5); Chunk chunk = new Chunk();
	 * PrintFormDirectory directory = new PrintFormDirectory();
	 * directory.printForm(request); String filePath =
	 * directory.getFilePath(request); PdfWriter.getInstance(document, new
	 * FileOutputStream(new File( filePath +
	 * System.getProperty("file.separator") + "HEB_Candidate_Introduction_" + id
	 * + ".pdf"))); path = filePath + System.getProperty("file.separator") +
	 * "HEB Candidate Introduction_" + id + ".pdf";
	 * printFormVO.setFilePath(path); printFormVO
	 * .setFileName("HEB_Candidate_Introduction_" + id + ".pdf"); if (null !=
	 * printFormVO.getVendorName())
	 * printFormVO.setDisplayToUser(printFormVO.getVendorName()); else
	 * printFormVO .setDisplayToUser("HEB_Candidate_Introduction_" + id);
	 * document.open(); // chunk.setFont(new Font(Font.TIMES_ROMAN, 10)); ///
	 * HEADER - HEB Candidate Introduction PdfPTable table = new PdfPTable(3);
	 * Font font = new Font(Font.TIMES_ROMAN, 10); Font headingFont = new
	 * Font(Font.TIMES_ROMAN, 13); PdfPCell cell = new PdfPCell(new Paragraph(
	 * "HEB Candidate Introduction", headingFont)); cell.setColspan(3);
	 * cell.setHorizontalAlignment(Element.ALIGN_CENTER); cell.setBorder(0);
	 * table.addCell(cell); PdfPCell cellDate = new PdfPCell(new Phrase(
	 * "Created on: " + CPSHelper.getDateAsString(new Date()), font));
	 * cellDate.setColspan(3);
	 * cellDate.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * cellDate.setBorder(0); table.addCell(cellDate); // Header END // VENDOR
	 * SECTION. cell.setBackgroundColor(lightYellow); cell = new PdfPCell( new
	 * Phrase( (null == printFormVO.getVendorName() ? "Vendor Name: " :
	 * "Vendor Name: " + printFormVO.getVendorName()) + chunk.NEWLINE + (null !=
	 * printFormVO.getVendorNumber() ? "Vendor #: " +
	 * printFormVO.getVendorNumber() : "Vendor #: "), font));
	 * table.addCell(cell); cell = new PdfPCell( new Phrase( (null !=
	 * printFormVO.getContactName() ? "*Contact Name: " +
	 * printFormVO.getContactName() : "*Contact Name: ") + chunk.NEWLINE + (null
	 * != printFormVO.getContactPhone() ? "*Contact Phone: " +
	 * printFormVO.getContactPhone() : "*Contact Phone: ") + chunk.NEWLINE +
	 * (null != printFormVO.getContactEmail() ? "*Contact Email: " +
	 * printFormVO.getContactEmail() : "*Contact Email: "), font));
	 * table.addCell(cell); cell = new PdfPCell( new Phrase( (null !=
	 * printFormVO.getBuyerName() ? "*Buyer Name: " + printFormVO.getBuyerName()
	 * : "*Buyer Name: ") + chunk.NEWLINE + (null !=
	 * printFormVO.getBuyerNumber() ? "*Buyer Code: " +
	 * printFormVO.getBuyerNumber() : "*Buyer Code: "), font));
	 * table.addCell(cell); document.add(table); // VENDOR SECION ENDS. Status
	 * Complete. table = null; table = new PdfPTable(5); PdfPCell cell2 = new
	 * PdfPCell(new Paragraph()); cell2.setColspan(5); table.addCell(cell2); if
	 * ("8".equalsIgnoreCase(printFormVO.getNewProduct())) cell2 = new
	 * PdfPCell(new Phrase("New Product", font)); else cell2 = new PdfPCell(new
	 * Phrase(" ", font)); table.addCell(cell2); table.addCell(new PdfPCell(new
	 * Phrase("Replacement" + chunk.NEWLINE + "Replacing:", font)));
	 * table.addCell(new PdfPCell(new Phrase("New Pack" + chunk.NEWLINE +
	 * "Existing Pack:", font))); if (printFormVO.isBonus()) table.addCell(new
	 * PdfPCell(new Phrase("Bonus" + chunk.NEWLINE + "Open Stock:", font)));
	 * else table.addCell(new PdfPCell(new Phrase(" " + chunk.NEWLINE +
	 * "Open Stock:", font))); // MRT is the field name appearing blank as it is
	 * not checked in the // page table.addCell(new PdfPCell(new Phrase(" ",
	 * font))); // table.addCell(cell2); document.add(table); table = null;
	 * table = new PdfPTable(3); PdfPCell cell3 = new PdfPCell(new Paragraph());
	 * cell3.setColspan(3); table.addCell(cell3); if
	 * ("Sellable".equalsIgnoreCase(printFormVO.getProductType()))
	 * table.addCell(new PdfPCell(new Phrase("Sellable" + chunk.NEWLINE + (null
	 * != printFormVO.getType() ? "Type: " + printFormVO.getType() : "Type: "),
	 * font))); else table.addCell(new PdfPCell(new Phrase("Non-Sellable" +
	 * chunk.NEWLINE + (null != printFormVO.getType() ? "Type: " +
	 * printFormVO.getType() : "Type: "), font))); if
	 * (printFormVO.getCommodity() != null && printFormVO.getSubCommodity() !=
	 * null && printFormVO.getUnitUPC() != null) table.addCell(new PdfPCell(new
	 * Phrase("Commodity: " + printFormVO.getCommodity() + chunk.NEWLINE +
	 * "Sub Commodity: " + printFormVO.getSubCommodity() + chunk.NEWLINE +
	 * "Unit UPC: " + printFormVO.getUnitUPC(), font))); else if
	 * (printFormVO.getCommodity() != null && printFormVO.getSubCommodity() ==
	 * null && printFormVO.getUnitUPC() == null) table.addCell(new PdfPCell(new
	 * Phrase("Commodity: " + printFormVO.getCommodity() + chunk.NEWLINE +
	 * "Sub Commodity: " + " " + chunk.NEWLINE + "Unit UPC: " + " ", font)));
	 * else if (printFormVO.getCommodity() == null &&
	 * printFormVO.getSubCommodity() != null && printFormVO.getUnitUPC() ==
	 * null) table.addCell(new PdfPCell(new Phrase("Commodity: " + " " +
	 * chunk.NEWLINE + "Sub Commodity: " + printFormVO.getSubCommodity() +
	 * chunk.NEWLINE + "Unit UPC: " + " ", font))); else if
	 * (printFormVO.getCommodity() == null && printFormVO.getSubCommodity() ==
	 * null && printFormVO.getUnitUPC() != null) table.addCell(new PdfPCell(new
	 * Phrase("Commodity: " + " " + chunk.NEWLINE + "Sub Commodity: " + " " +
	 * chunk.NEWLINE + "Unit UPC: " + printFormVO.getUnitUPC(), font))); else
	 * table.addCell(new PdfPCell(new Phrase("Commodity: " + chunk.NEWLINE +
	 * "Sub Commodity: " + chunk.NEWLINE + "Unit UPC: ", font))); if (null !=
	 * printFormVO.getBrand() && null != printFormVO.getSubBrand())
	 * table.addCell(new PdfPCell(new Phrase("Brand: " + printFormVO.getBrand()
	 * + chunk.NEWLINE + "Sub Brand: " + printFormVO.getSubBrand(), font)));
	 * else if (null != printFormVO.getBrand() && null ==
	 * printFormVO.getSubBrand()) table.addCell(new PdfPCell(new Phrase(
	 * "Brand: " + printFormVO.getBrand() + chunk.NEWLINE + "Sub Brand: ",
	 * font))); else if (null == printFormVO.getBrand() && null !=
	 * printFormVO.getSubBrand()) table.addCell(new PdfPCell(new Phrase(
	 * "Brand: " + chunk.NEWLINE + "Sub Brand: " + printFormVO.getSubBrand(),
	 * font))); else table.addCell(new PdfPCell(new Phrase("Brand: " +
	 * chunk.NEWLINE + "Sub Brand: ", font))); table.addCell(cell3);
	 * document.add(table); table = null; table = new PdfPTable(2); PdfPCell
	 * cell4 = new PdfPCell(new Paragraph()); table.addCell(new PdfPCell(new
	 * Phrase(null != printFormVO .getProductDescription() ?
	 * "Product Description: " + printFormVO.getProductDescription() :
	 * "Product Description: ", font))); table.addCell(new PdfPCell(new Phrase(
	 * "Size: " + (null != printFormVO.getSize() ? printFormVO.getSize() : " ")
	 * + "    " + "UOM: " + (null != printFormVO.getUOM() ? printFormVO.getUOM()
	 * : " "), font))); table.addCell(cell4); document.add(table); table = null;
	 * table = new PdfPTable(4); PdfPCell cell5 = new PdfPCell();
	 * table.addCell(new PdfPCell(new Phrase(null != printFormVO
	 * .getProductLength() ? "Product Length: " + printFormVO.getProductLength()
	 * + " in" : "Product Length:    in", font))); table.addCell(new
	 * PdfPCell(new Phrase(null != printFormVO .getProductWidth() ?
	 * "Product Width: " + printFormVO.getProductWidth() + " in" :
	 * "Product Width:    in", font))); table.addCell(new PdfPCell(new
	 * Phrase(null != printFormVO .getProductHeight() ? "Product Height: " +
	 * printFormVO.getProductHeight() : "Product Height:    in", font)));
	 * table.addCell(new PdfPCell(new Phrase("Packaging: " + (null !=
	 * printFormVO.getPackaging() ? printFormVO .getPackaging() : " "), font)));
	 * if (printFormVO.isAVC() && printFormVO.isDrugFactsPanel())
	 * table.addCell(new PdfPCell(new Phrase("AVC" + "\n" + "Drug Facts Panel",
	 * font))); else if (!printFormVO.isAVC() && printFormVO.isDrugFactsPanel())
	 * table.addCell(new PdfPCell(new Phrase(" " + "\n" + "Drug Facts Panel",
	 * font))); else if (printFormVO.isAVC() && !printFormVO.isDrugFactsPanel())
	 * table .addCell(new PdfPCell(new Phrase("AVC" + "\n" + " ", font))); else
	 * if (!printFormVO.isAVC() && !printFormVO.isDrugFactsPanel())
	 * table.addCell(new PdfPCell(new Phrase(" " + "\n" + " ", font)));
	 * table.addCell(new PdfPCell(new Phrase("Sample Provided" + "\n" +
	 * "Spec Sheet Attached", font))); if (printFormVO.isGuaranteedSale())
	 * table.addCell(new PdfPCell(new Phrase("Attribute Sign Sheet" + "\n" +
	 * "Gauranteed Sell", font))); else table.addCell(new PdfPCell(new Phrase(
	 * "Attribute Sign Sheet" + "\n" + "  ", font))); if
	 * (printFormVO.isDealOffered()) table.addCell(new PdfPCell(new Phrase(
	 * "Deal Offered", font))); else table.addCell(new PdfPCell(new Phrase(" ",
	 * font))); cell5.setColspan(4); table.addCell(cell5); document.add(table);
	 * table = null; table = new PdfPTable(3); PdfPCell cell6 = new PdfPCell();
	 * if (printFormVO.isPrePriced()) table.addCell(new PdfPCell(new
	 * Phrase((null != printFormVO .getSuggestedRetail() ? "Suggested Retail: "
	 * + printFormVO.getSuggestedRetail() : "Suggested Retail: ") + "\n" +
	 * "Pre-Priced", font))); else table.addCell(new PdfPCell(new Phrase((null
	 * != printFormVO .getSuggestedRetail() ? "Suggested Retail: " +
	 * printFormVO.getSuggestedRetail() : "Suggested Retail: ") + "\n" + " ",
	 * font))); table.addCell(new PdfPCell(new Phrase("Restricted Sales" + "\n"
	 * + (null != printFormVO.getAge() ? "Age" : " ") + "\n" + (null !=
	 * printFormVO.getTime() ? "Time" : " "), font))); table .addCell(new
	 * PdfPCell( new Phrase( (null != printFormVO.getFamilyCode1() ?
	 * "Family Code 1: " + printFormVO.getFamilyCode1() : "Family Code 1: ") +
	 * "\n" + (null != printFormVO .getFamilyCode2() ? "Family Code 2: " +
	 * printFormVO .getFamilyCode2() : "Family Code 2: "), font)));
	 * cell6.setColspan(3); table.addCell(cell6); document.add(table); table =
	 * null; table = new PdfPTable(3); PdfPCell cell7 = new PdfPCell(); table
	 * .addCell(new PdfPCell( new Phrase( "Tare Weight:" + " " + "\n" +
	 * "Scale Tare Weight:" + " " + "\n" + (true == printFormVO
	 * .isVariableWeight() ? "Variable Weight" : " ") + "\n" + (true ==
	 * printFormVO .isCatchWeight() ? "Catch Weight" : " "), font))); table
	 * .addCell(new PdfPCell( new Phrase( (null != printFormVO.getIngredients()
	 * ? "Ingredients: " + printFormVO.getIngredients() : "Ingredients: ") +
	 * "\n" + (null != printFormVO .getNutrition() ? "Nutrition: " + printFormVO
	 * .getNutrition() : "Nutrition: ") + "\n" + (null != printFormVO
	 * .getActionCode() ? "Action Code:" + printFormVO .getActionCode() :
	 * "Action Code:") + "\n" + (null != printFormVO .getGraphicsCode() ?
	 * "Graphics Code:" + printFormVO .getGraphicsCode() : "Graphics Code:"),
	 * font))); table.addCell(new PdfPCell(new Phrase((!"#"
	 * .equalsIgnoreCase(printFormVO.getNDC()) ? "NDC: " + printFormVO.getNDC()
	 * : "NDC:") + "   " + (null != printFormVO.getDirectCost() ?
	 * "Direct Cost: " + printFormVO.getDirectCost() : "Direct Cost:") + "\n" +
	 * (null != printFormVO.getDrugSchedule() ? "Drug Schedule:" +
	 * printFormVO.getDrugSchedule() : "Drug Schedule:") + "   " + (null !=
	 * printFormVO.getAvgWhslCost() ? "Avg Whsl Cost:" +
	 * printFormVO.getAvgWhslCost() : "Avg Whsl Cost:") + "\n" + (null !=
	 * printFormVO.getDrugAbb() ? "Drug Abb: " + printFormVO.getDrugAbb() :
	 * "Drug Abb: ") + "\n" + (null != printFormVO.getPseGr() ? "PSE Gr: " +
	 * printFormVO.getPseGr() : "PSE Gr: "), font))); cell7.setColspan(3);
	 * table.addCell(cell7); document.add(table); table = null; table = new
	 * PdfPTable(3); PdfPCell cell8 = new PdfPCell(new Paragraph());
	 * table.addCell(new PdfPCell(new Phrase("Delivered to:", font)));
	 * table.addCell(new PdfPCell(new Phrase(null != printFormVO .getT2tVendor()
	 * ? "T2T Vendor: " + printFormVO.getT2tVendor() : "T2T Vendor: ", font)));
	 * table.addCell(new PdfPCell(new Phrase(null != printFormVO .getCostOwner()
	 * ? "Cost Owner: " + printFormVO.getCostOwner() : "Cost Owner: ", font)));
	 * table.addCell(new PdfPCell(new Phrase(null != printFormVO
	 * .getExpWklyMvmt() ? "Exp Wkly Mvmt: " + printFormVO.getExpWklyMvmt() :
	 * "Exp Wkly Mvmt: ", font))); table.addCell(new PdfPCell(new Phrase(null !=
	 * printFormVO .getCaseUPC() ? "Case UPC: " + printFormVO.getCaseUPC() :
	 * "Case UPC: ", font))); table.addCell(new PdfPCell(new Phrase(null !=
	 * printFormVO .getCountryOfOrigin() ? "Country of Origin: " +
	 * printFormVO.getCountryOfOrigin() : "Country of Origin: ", font)));
	 * table.addCell(cell8); document.add(table); table = null; table = new
	 * PdfPTable(2); PdfPCell cell9 = new PdfPCell(new Paragraph());
	 * cell.setColspan(2); table.addCell(new PdfPCell(new Phrase(null !=
	 * printFormVO .getCaseDescription() ? "Case Description: " +
	 * printFormVO.getCaseDescription() : "Case Description: ", font)));
	 * table.addCell(new PdfPCell(new Phrase( null != printFormVO.getVpc() ?
	 * "VPC: " + printFormVO.getVpc() : "VPC: ", font))); table.addCell(cell9);
	 * document.add(table); table = null; table = new PdfPTable(6); PdfPCell
	 * cell10 = new PdfPCell(); table.addCell(new PdfPCell(new Phrase(null !=
	 * printFormVO .getMasterPack() ? "Master Pack: " +
	 * printFormVO.getMasterPack() : "Master Pack: ", font))); table.addCell(new
	 * PdfPCell(new Phrase(null != printFormVO .getMasterPackLength() ?
	 * "Length: " + printFormVO.getMasterPackLength() : "Length: ", font)));
	 * table.addCell(new PdfPCell(new Phrase(null != printFormVO
	 * .getMasterPackWidth() ? "Width: " + printFormVO.getMasterPackWidth() :
	 * "Width: ", font))); table.addCell(new PdfPCell(new Phrase(null !=
	 * printFormVO .getMasterPackHeight() ? "Height: " +
	 * printFormVO.getMasterPackHeight() : "Height: ", font)));
	 * table.addCell(new PdfPCell(new Phrase(null != printFormVO
	 * .getMasterPackCube() ? "Cube: " + printFormVO.getMasterPackCube() :
	 * "Cube: ", font))); table.addCell(new PdfPCell(new Phrase(null !=
	 * printFormVO .getMasterPackWeight() ? "Weight: " +
	 * printFormVO.getMasterPackWeight() : "Weight: ", font)));
	 * table.addCell(new PdfPCell(new Phrase(null != printFormVO .getShipPack()
	 * ? "Inner(Ship) Pack: " + printFormVO.getShipPack() : "Inner(Ship) Pack: "
	 * , font))); table.addCell(new PdfPCell(new Phrase(null != printFormVO
	 * .getShipPackLength() ? "Length: " + printFormVO.getShipPackLength() :
	 * "Length: ", font))); table.addCell(new PdfPCell(new Phrase(null !=
	 * printFormVO .getShipPackWidth() ? "Width: " +
	 * printFormVO.getShipPackWidth() : "Width: ", font))); table.addCell(new
	 * PdfPCell(new Phrase(null != printFormVO .getShipPackHeight() ? "Height: "
	 * + printFormVO.getShipPackHeight() : "Height: ", font)));
	 * table.addCell(new PdfPCell(new Phrase(null != printFormVO
	 * .getShipPackCube() ? "Cube: " + printFormVO.getShipPackCube() : "Cube: ",
	 * font))); table.addCell(new PdfPCell(new Phrase(null != printFormVO
	 * .getShipPackWeight() ? "Weight: " + printFormVO.getShipPackWeight() :
	 * "Weight: ", font))); table.addCell(cell10); document.add(table); table =
	 * null; table = new PdfPTable(4); PdfPCell cell11 = new PdfPCell();
	 * table.addCell(new PdfPCell(new Phrase(null != printFormVO .getVendorTie()
	 * ? "Vendor Tie: " + printFormVO.getVendorTie() : "Vendor Tie: ", font)));
	 * table.addCell(new PdfPCell(new Phrase(null != printFormVO
	 * .getVendorTier() ? "Vendor Tier: " + printFormVO.getVendorTier() :
	 * "Vendor Tier: ", font))); table .addCell(new PdfPCell(new Phrase(null !=
	 * printFormVO .getOneTouchType() ? "One Touch Type: " +
	 * printFormVO.getOneTouchType() : "One Touch Type: ", font))); if
	 * (printFormVO.isCodeDate()) table .addCell(new PdfPCell( new Phrase(
	 * "Code Date" + "\n" + (null != printFormVO .getMaxShelfLife() ?
	 * "Max Shelf Life: " + printFormVO .getMaxShelfLife() + " Days" :
	 * "Max Shelf Life:    Days"), font))); else table .addCell(new PdfPCell(
	 * new Phrase( " " + "\n" + (null != printFormVO .getMaxShelfLife() ?
	 * "Max Shelf Life: " + printFormVO .getMaxShelfLife() + " Days" :
	 * "Max Shelf Life:    Days"), font))); table.addCell(cell11);
	 * document.add(table); table = null; table = new PdfPTable(5); PdfPCell
	 * cell12 = new PdfPCell(); if
	 * ("True".equalsIgnoreCase(printFormVO.getImportd())) table.addCell(new
	 * PdfPCell(new Phrase("Import", font))); else table.addCell(new
	 * PdfPCell(new Phrase(" ", font))); table.addCell(new PdfPCell(new Phrase(
	 * "Container Size: " + (null != printFormVO.getContainerSize() ?
	 * printFormVO .getContainerSize() : " ") + "\n" + "Inco Terms: " + (null !=
	 * printFormVO.getIncoTerms() ? printFormVO .getIncoTerms() : " "), font)));
	 * table.addCell(new PdfPCell(new Phrase("Color: " + (null !=
	 * printFormVO.getColor() ? printFormVO.getColor() : " ") + "\n" +
	 * "Freight: " + (null != printFormVO.getFreight() ? printFormVO
	 * .getFreight() : " "), font))); table.addCell(new PdfPCell(new Phrase(
	 * "Min Type: " + (null != printFormVO.getMinType() ? printFormVO
	 * .getMinType() : " ") + "\n" + "Min Qty: " + (null !=
	 * printFormVO.getMinQty() ? printFormVO .getMinQty() : " "), font)));
	 * table.addCell(new PdfPCell(new Phrase("Pickup Point: " + (null !=
	 * printFormVO.getPickupPoint() ? printFormVO .getPickupPoint() : " ") +
	 * "\n" + "Rate%: " + (null != printFormVO.getRatePercentage() ? printFormVO
	 * .getRatePercentage() : " "), font))); table.addCell(cell12);
	 * document.add(table); table = null; table = new PdfPTable(3); PdfPCell
	 * cell13 = new PdfPCell(); table.addCell(new PdfPCell(new Phrase(null !=
	 * printFormVO .getFirstShipDate() ? "First Ship Date: " +
	 * printFormVO.getFirstShipDate() : "First Ship Date: ", font))); table
	 * .addCell(new PdfPCell(new Phrase(null != printFormVO .getProrationDate()
	 * ? "Proration Date: " + printFormVO.getProrationDate() :
	 * "Proration Date: ", font))); table.addCell(new PdfPCell(new Phrase(null
	 * != printFormVO .getInStoreDate() ? "In-Store Date: " +
	 * printFormVO.getInStoreDate() : "In-Store Date: ", font)));
	 * table.addCell(cell13); document.add(table); table = null; table = new
	 * PdfPTable(4); PdfPCell cell14 = new PdfPCell(); cell14.setColspan(4);
	 * table.addCell(new PdfPCell(new Phrase(null != printFormVO .getListCost()
	 * ? "List Cost: " + printFormVO.getListCost() : "List Cost: ", font)));
	 * table.addCell(new PdfPCell(new Phrase(null != printFormVO .getUnitCost()
	 * ? "Unit Cost: " + printFormVO.getUnitCost() : "Unit Cost: ", font)));
	 * table.addCell(new PdfPCell(new Phrase((null != printFormVO .getCostLink()
	 * ? "Cost Link " : " ") + (null != printFormVO.getLinkTo() ? "  Link To: "
	 * + printFormVO.getLinkTo() : "  Link To: "), font))); table.addCell(new
	 * PdfPCell(new Phrase("Item Size: " + (null != printFormVO.getItemSize() ?
	 * printFormVO .getItemSize() : " "), font))); table.addCell(cell14);
	 * document.add(table); table = null; table = new PdfPTable(1); PdfPCell
	 * cell15 = new PdfPCell(); table.addCell(new PdfPCell(new Phrase(
	 * "Comments: " + (null != printFormVO.getComments() ? printFormVO
	 * .getComments() : " "), font))); table.addCell(cell15);
	 * document.add(table); table = null; table = new PdfPTable(2); PdfPCell
	 * cell16 = new PdfPCell(); cell16.setColspan(2); table.addCell(new
	 * PdfPCell(new Phrase("Vendor Signature: ", font))); table.addCell(new
	 * PdfPCell(new Phrase("Date: ", font))); table.addCell(cell16);
	 * document.add(table); table = null; // The following section is not filled
	 * by the vendor table = new PdfPTable(3); PdfPCell cell17 = new PdfPCell();
	 * table .addCell(new PdfPCell( new Phrase( null !=
	 * printFormVO.getCriticalItem() ? "Critical Item: " +
	 * printFormVO.getCriticalItem() : "Critical Item: ", font))); table
	 * .addCell(new PdfPCell( new Phrase( (null != printFormVO.getSeasonality()
	 * ? "Seasonality: " + printFormVO.getSeasonality() : "Seasonality: ") +
	 * (null != printFormVO .getSeasonYear() ? "   Season Yr: " + printFormVO
	 * .getSeasonYear() : "     Season Yr: "), font))); table .addCell(new
	 * PdfPCell( new Phrase( null != printFormVO.getItemCategory() ?
	 * "Item Category: " + printFormVO.getItemCategory() : "Item Category: ",
	 * font))); table.addCell(cell17); document.add(table); table = null; table
	 * = new PdfPTable(4); PdfPCell cell18 = new PdfPCell(); table.addCell(new
	 * PdfPCell(new Phrase("Initial Retail: " + (null !=
	 * printFormVO.getInitialRetail() ? printFormVO .getInitialRetail() : " ") +
	 * "\n" + "Or" + "\n" + "Retail Link To: " + (null !=
	 * printFormVO.getRetailLinkTo() ? printFormVO .getRetailLinkTo() : " ") +
	 * "\n" + "Or" + "\n" + "Use Matrix", font))); table.addCell(new
	 * PdfPCell(new Phrase( (printFormVO.isSoldByLb() ? "Sold by Lb" : " ") +
	 * "\n" + (printFormVO.isQtyRestricted() ? "Qty Restricted" : " "), font)));
	 * table .addCell(new PdfPCell( new Phrase( "Order Unit: " + "\n" +
	 * "Cents Off: " + (null != printFormVO .getCentsOff() ? printFormVO
	 * .getCentsOff() : " ") + "\n" + "%Off Pre-Price: " + (null != printFormVO
	 * .getOffPrePricePercentage() ? printFormVO .getOffPrePricePercentage() :
	 * " ") + "\n" + (!"#" .equalsIgnoreCase(printFormVO .getFSA()) ?
	 * "FSA Eligible" : " "), font))); table.addCell(new PdfPCell(new
	 * Phrase((true == printFormVO .isCodeDate() ? "Code Date" : " ") + "\n" +
	 * "Inbound Spec: " + (null != printFormVO.getInboundSpec() ? printFormVO
	 * .getInboundSpec() : " " + " Days") + "\n" + "Reaction: " + (null !=
	 * printFormVO.getReaction() ? printFormVO .getReaction() : " ") + " Days" +
	 * "\n" + "Guarantee to Store: " + (null !=
	 * printFormVO.getGuaranteeToStore() ? printFormVO .getGuaranteeToStore() :
	 * " ") + " Days", font))); table.addCell(cell18); document.add(table);
	 * table = null; table = new PdfPTable(1); PdfPCell cell19 = new PdfPCell();
	 * table.addCell(new PdfPCell( new Phrase("Comments(13 Screen): ", font)));
	 * table.addCell(cell19); document.add(table); table = null; table = new
	 * PdfPTable(2); PdfPCell cell20 = new PdfPCell(); cell20.setColspan(2);
	 * table.addCell(new PdfPCell(new Phrase("Buyer Signature: ", font)));
	 * table.addCell(new PdfPCell(new Phrase("Date: ", font)));
	 * table.addCell(cell20); document.add(table); table = null; table = new
	 * PdfPTable(3); PdfPCell cell21 = new PdfPCell(); table .addCell(new
	 * PdfPCell(new Phrase("Order Restriction: ", font))); table.addCell(new
	 * PdfPCell(new Phrase("Max Ship: " + (null != printFormVO.getMaxShip() ?
	 * printFormVO .getMaxShip() : " "), font))); table.addCell(new PdfPCell(new
	 * Phrase("Whse#: " + (null != printFormVO.getWhseNumber() ? printFormVO
	 * .getWhseNumber() : " "), font))); table.addCell(cell21);
	 * document.add(table); table = null; table = new PdfPTable(2); PdfPCell
	 * cell22 = new PdfPCell(); cell22.setColspan(2); table.addCell(new
	 * PdfPCell(new Phrase("SCA Signature: ", font))); table.addCell(new
	 * PdfPCell(new Phrase("Date: ", font))); table.addCell(cell22);
	 * document.add(table); table = null; table = new PdfPTable(1); PdfPCell
	 * cell23 = new PdfPCell(); table.addCell(new PdfPCell(new Phrase(
	 * "Item Code: " + (null != printFormVO.getItemCode() ? printFormVO
	 * .getItemCode() : " "), font))); table.addCell(cell23);
	 * document.add(table); table = null; table = new PdfPTable(2); PdfPCell
	 * cell24 = new PdfPCell(); table.addCell(new PdfPCell(new Phrase(
	 * "Admin Signature: ", font))); table.addCell(new PdfPCell(new Phrase(
	 * "Date: ", font))); table.addCell(cell24); document.add(table); table =
	 * null; document.close(); } catch (Exception ex) {
	 * //log.fatal("Exception:-", ex); } finally { if (fos != null) { try {
	 * fos.close(); } catch (Exception ex) { //log.fatal("Exception:-", ex); } }
	 * } return printFormVO; }
	 */

	private static String getDSDStoreGroup(VendorVO vendorVO,
			AddNewCandidateService addNewCandLocal) {
		final String space = " ";
		String retVal = space;
		try {
			Set<String> strCostGroups = new HashSet<String>();
			Map<Integer, String> costGrpStoreMap = new TreeMap<Integer, String>();
			List<StoreVO> fetchDBStoreList = addNewCandLocal.fetchStoreData(
					String.valueOf(vendorVO.getPsItemId()),
					String.valueOf(vendorVO.getVendorLocNumber()));
			for (StoreVO storeVO : fetchDBStoreList) {
				String costGroup = storeVO.getCostGroup();
				if (CPSHelper.isNotEmpty(costGroup)) {
					costGroup = costGroup.trim();
					// Fix 1015
					if (!strCostGroups.contains(costGroup)) {
						strCostGroups.add(costGroup);
						costGrpStoreMap
								.put(CPSHelper.getIntegerValue(costGroup),
										costGroup);
						int stores = 0;
						int removedStores = 0;
						boolean costChange = false;
						StringBuffer storeNo = new StringBuffer();
						for (StoreVO store1 : fetchDBStoreList) {
							if (costGroup.equals(CPSHelper
									.getTrimmedValue(store1.getCostGroup()))) {
								stores++;
								if (store1.isStoreRemoved()
										|| CPSHelper.getBigdecimalValue(
												store1.getListCost())
												.doubleValue() == 0) {
									removedStores++;
								} else {
									if (CPSHelper.isNotEmpty(store1
											.getStoreId())) {
										storeNo.append(store1.getStoreId()
												+ ",");
									}
								}
								if (isListCostChanged(vendorVO, store1)) {
									costChange = true;
								}

							}
						}

						if (stores == removedStores) {
							costGrpStoreMap.remove(CPSHelper
									.getIntegerValue(costGroup));
						} else if (costChange) {
							costGrpStoreMap.remove(CPSHelper
									.getIntegerValue(costGroup));
							// Commenting this out since the form is truncating
							// when there are lot of stores
							/*
							 * String strStore = storeNo.toString();
							 * if(strStore.length() > 0){ strStore =
							 * strStore.substring(0, strStore.length()-1); }
							 * costGrpStoreMap
							 * .put(CPSHelper.getIntegerValue(costGroup),
							 * costGroup+"*("+ strStore +")");
							 */
							costGrpStoreMap.put(
									CPSHelper.getIntegerValue(costGroup),
									costGroup + "*");
						}
					}
				}
			}

			if (CPSHelper.isNotEmpty(costGrpStoreMap)) {
				Collection<String> cstGrp = costGrpStoreMap.values();
				for (String strCostGroup : cstGrp) {
					retVal += strCostGroup + ", ";
				}
			}

		} catch (CPSGeneralException e) {
			LOG.error(e.getMessage(), e);
		}
		// getrid of last comma.
		retVal = retVal.trim();
		if (retVal.length() > 0) {
			retVal = retVal.substring(0, retVal.length() - 1);
		}
		return retVal;
	}

	private static boolean isListCostChanged(VendorVO vendorVO, StoreVO storeVO) {
		boolean isSame = false;
		Double sListCost = 0.0;
		Double vListCost = 0.0;
		if (vendorVO != null && CPSHelper.isNotEmpty(vendorVO.getListCost())) {
			sListCost = new Double(vendorVO.getListCost().trim());
		}
		if (storeVO != null && CPSHelper.isNotEmpty(storeVO.getListCost())) {
			vListCost = new Double(storeVO.getListCost().trim());
		}
		isSame = sListCost.equals(vListCost);
		return !isSame;
	}

	// Order Unit changes
	private static String getOrderUnit(String code,
			List<BaseJSFVO> orderUnitList) {
		String retVal = null;
		if (CPSHelper.isNotEmpty(code)) {
			for (BaseJSFVO baseJSFVO : orderUnitList) {
				if (baseJSFVO != null
						&& baseJSFVO.getId().equalsIgnoreCase(code)) {
					retVal = baseJSFVO.getName() + " [" + code + "]";
					break;
				}
			}
		}
		/**
		 * keep it empty, it would be filled in by hand.
		 */
		retVal = "";
		return retVal;
	}

	// thang.dang : getlistcost base on Store.
	private static String getListCostByCostGroup(VendorVO vendorVO,
			List<String> costGroups, Map<Integer, String> costGroupListCosts,
			List<String> listCosts) {
		String listCostPrint = "";
		String listCostPrintTemp = "";
		String listCostTemp = "";
		List<StoreVO> storeVos = new ArrayList<StoreVO>();
		if (null != vendorVO.getPrintStores()
				&& !vendorVO.getPrintStores().isEmpty()) {
			storeVos = vendorVO.getPrintStores();
		} else {
			storeVos = vendorVO.getAuthorizedStores();
		}
		for (String costGroup : costGroups) {
			if (costGroup.contains("*"))
				costGroup = costGroup.substring(0, costGroup.indexOf("*"));
			for (StoreVO storeVo : storeVos) {
				if (costGroup.equals(storeVo.getCostGroup())
						&& !storeVo.isStoreRemoved()
						&& Double.valueOf(storeVo.getListCost()) > 0) {
					if (!listCosts.contains(storeVo.getListCost())) {
						listCosts.add(storeVo.getListCost());
					}
					costGroupListCosts.put(Integer.parseInt(costGroup),
							storeVo.getListCost());
					break;
				}
			}
		}
		if (!costGroupListCosts.isEmpty()) {
			Object[] keyValue = costGroupListCosts.keySet().toArray();
			Arrays.sort(keyValue);
			int count = 1;
			for (String listCost : listCosts) {
				if (Double.valueOf(listCost) > 0) {
					listCostPrintTemp = listCostPrintTemp + "$" + listCost
							+ "(";
					if (listCostPrintTemp.lastIndexOf("(")
							/ CPSConstants.weightListCost == count) {
						listCostPrint = listCostPrint + "\n$" + listCost + "(";
						listCostPrintTemp = listCostPrint;
						count++;
					} else {
						listCostPrint = listCostPrint + "$" + listCost + "(";
					}
					// Iterator<Integer> iterator = costGroupListCosts.keySet()
					// .iterator();
					for (Integer i = 0; i < keyValue.length; i++) {
						Integer key = (Integer) keyValue[i];
						listCostTemp = costGroupListCosts.get(key);
						if (listCostTemp.equals(listCost)) {
							listCostPrintTemp += key.toString() + ",";
							if (listCostPrintTemp.lastIndexOf(",")
									/ CPSConstants.weightListCost == count) {
								listCostPrint += "\n" + key.toString() + ",";
								listCostTemp = listCostPrint;
								count++;
							} else {
								listCostPrint += key.toString() + ",";
							}
						}
					}
					listCostPrint = listCostPrint.substring(0,
							listCostPrint.lastIndexOf(","));
					listCostPrint += "),";
					listCostTemp = listCostPrint;
				}
			}
			listCostPrint = listCostPrint.substring(0,
					listCostPrint.lastIndexOf(","));
			listCostTemp = listCostPrint;
		} else {
			listCostPrint = vendorVO.getListCost();
		}
		return listCostPrint;
	}

	private static String getUnitCostPrintForm(PrintFormVO printFormVO,
			CaseVO caseVO, VendorVO vendorVO, List<String> costGroups,
			Map<Integer, String> costGroupListCosts, List<String> listCosts) {
		double unitCost;
		String listUnitCostPrintTemp = "";
		String listUnitCostPrint = "";
		String unitCostTemp = "";
		String listCostTemp = "";
		if (printFormVO.getChannel() != null
				&& ("WHS".equalsIgnoreCase(printFormVO.getChannel()) || "BOTH"
						.equalsIgnoreCase(printFormVO.getChannel()))) {
			if (null != caseVO.getShipPack()
					&& !("0").equalsIgnoreCase(caseVO.getShipPack())) {
				String shipPack = caseVO.getShipPack();
				int sPack = 1;
				if (CPSHelper.isNotEmpty(shipPack)) {
					sPack = Integer.parseInt(shipPack);
				}
				// Fix 1301
				if (CPSHelper.isNotEmpty(vendorVO.getListCost())) {
					if (null != costGroups && !costGroups.isEmpty()) {
						if (costGroupListCosts != null
								&& !costGroupListCosts.isEmpty()) {
							Object[] keyValue = costGroupListCosts.keySet()
									.toArray();
							Arrays.sort(keyValue);
							int count = 1;
							for (String listCost : listCosts) {
								if (CPSHelper.isNotEmpty(listCost)
										&& Double.valueOf(listCost) > 0) {
									try {
										unitCost = (CPSHelper
												.getBigdecimalValue(listCost)
												.divide(new BigDecimal(sPack)))
												.doubleValue();
									} catch (Exception e) {
										LOG.error(e.getMessage(), e);
										unitCost = Double.parseDouble(listCost)
												/ sPack;
									}
									unitCostTemp = CPSHelper
											.roundToFourDecimal(String
													.valueOf(unitCost));
									listUnitCostPrintTemp = listUnitCostPrintTemp
											+ unitCostTemp + "(";
									if (listUnitCostPrintTemp.lastIndexOf('(')
											/ CPSConstants.weightListCost == count) {
										listUnitCostPrint += "\n"
												+ unitCostTemp + "(";
										listUnitCostPrintTemp = listUnitCostPrint;
										count++;
									} else {
										listUnitCostPrint = listUnitCostPrint
												+ unitCostTemp + "(";
									}
									// Iterator<Integer> iterator =
									// costGroupListCosts.keySet()
									// .iterator();
									for (Integer i = 0; i < keyValue.length; i++) {
										Integer key = (Integer) keyValue[i];
										listCostTemp = costGroupListCosts
												.get(key);
										if (listCostTemp.equals(listCost)) {
											listUnitCostPrintTemp += key
													.toString() + ",";
											if (listUnitCostPrintTemp
													.lastIndexOf(",")
													/ CPSConstants.weightListCost == count) {
												listUnitCostPrint += "\n"
														+ key.toString() + ",";
												listUnitCostPrintTemp = listUnitCostPrint;
												count++;
											} else {
												listUnitCostPrint += key
														.toString() + ",";
											}
										}
									}
									listUnitCostPrint = listUnitCostPrint
											.substring(0, listUnitCostPrint
													.lastIndexOf(","));
									listUnitCostPrint += "),";
									listUnitCostPrintTemp = listUnitCostPrint;
								}
							}
							listUnitCostPrint = listUnitCostPrint.substring(0,
									listUnitCostPrint.lastIndexOf(","));
							listUnitCostPrintTemp = listUnitCostPrint;
						}
						printFormVO.setUnitCost(listUnitCostPrint);
					} else {
						try {
							unitCost = (CPSHelper.getBigdecimalValue(vendorVO
									.getListCost())
									.divide(new BigDecimal(sPack)))
									.doubleValue();
						} catch (Exception e) {
							LOG.error(e.getMessage(), e);
							unitCost = Double.parseDouble(vendorVO
									.getListCost()) / sPack;
						}
						printFormVO.setUnitCost(CPSHelper
								.roundToFourDecimal(String.valueOf(unitCost)));
					}
				} else {
					printFormVO.setUnitCost("");
				}
			} else {
				printFormVO.setUnitCost("");
			}
		} else {
			if (null != caseVO.getMasterPack()
					&& !"0".equalsIgnoreCase(caseVO.getMasterPack())) {
				String masterPack = caseVO.getMasterPack();
				int mPack = 1;
				if (CPSHelper.isNotEmpty(masterPack)) {
					mPack = Integer.parseInt(masterPack);
				}
				if (CPSHelper.isNotEmpty(vendorVO.getListCost())) {
					if (null != costGroups && !costGroups.isEmpty()) {
						if (costGroupListCosts != null
								&& !costGroupListCosts.isEmpty()) {
							int count = 1;
							for (String listCost : listCosts) {
								if (CPSHelper.isNotEmpty(listCost)
										&& Double.valueOf(listCost) > 0) {
									try {
										unitCost = (CPSHelper
												.getBigdecimalValue(listCost)
												.divide(new BigDecimal(mPack)))
												.doubleValue();
									} catch (Exception e) {
										LOG.error(e.getMessage(), e);
										unitCost = Double.parseDouble(listCost)
												/ mPack;
									}
									unitCostTemp = CPSHelper
											.roundToFourDecimal(String
													.valueOf(unitCost));
									listUnitCostPrintTemp = listUnitCostPrintTemp
											+ unitCostTemp + "(";
									if (listUnitCostPrintTemp.lastIndexOf("(")
											/ CPSConstants.weightListCost == count) {
										listUnitCostPrint += "\n"
												+ unitCostTemp + "(";
										listUnitCostPrintTemp = listUnitCostPrint;
										count++;
									} else {
										listUnitCostPrint = listUnitCostPrint
												+ unitCostTemp + "(";
									}
									Iterator<Integer> iterator = costGroupListCosts
											.keySet().iterator();
									while (iterator.hasNext()) {
										Integer key = (Integer) iterator.next();
										listCostTemp = costGroupListCosts
												.get(key);
										if (listCostTemp.equals(listCost)) {
											listUnitCostPrintTemp += key
													.toString() + ",";
											if (listUnitCostPrintTemp
													.lastIndexOf(",")
													/ CPSConstants.weightListCost == count) {
												listUnitCostPrint += "\n"
														+ key.toString() + ",";
												listUnitCostPrintTemp = listUnitCostPrint;
												count++;
											} else {
												listUnitCostPrint += key
														.toString() + ",";
											}
										}
									}
									listUnitCostPrint = listUnitCostPrint
											.substring(0, listUnitCostPrint
													.lastIndexOf(","));
									listUnitCostPrint += "),";
									listUnitCostPrintTemp = listUnitCostPrint;
								}
							}
							listUnitCostPrint = listUnitCostPrint.substring(0,
									listUnitCostPrint.lastIndexOf(','));
							listUnitCostPrintTemp = listUnitCostPrint;
						}
						printFormVO.setUnitCost(listUnitCostPrint);
					} else {
						try {
							unitCost = (CPSHelper.getBigdecimalValue(vendorVO
									.getListCost())
									.divide(new BigDecimal(mPack)))
									.doubleValue();
						} catch (Exception e) {
							LOG.error(e.getMessage(), e);
							unitCost = Double.parseDouble(vendorVO
									.getListCost()) / mPack;
						}
						printFormVO.setUnitCost(CPSHelper
								.roundToFourDecimal(String.valueOf(unitCost)));
					}
				} else {
					printFormVO.setUnitCost("");
				}
			} else {
				printFormVO.setUnitCost("");
			}
		}
		return "";
	}

	private static String getDSDStoreGroup_StoreAuthorize(VendorVO vendorVO,
			List<String> costGroups) {
		String dSDStoreGroup = "";
		String dSDStoreGroupTemp = "";
		boolean flag = false;
		boolean flagChange = false;
		List<StoreVO> storeVos = new ArrayList<StoreVO>();
		if (null != vendorVO.getPrintStores()
				&& !vendorVO.getPrintStores().isEmpty()) {
			storeVos = vendorVO.getPrintStores();
		} else {
			storeVos = vendorVO.getAuthorizedStores();
		}
		int count = 1;
		for (String costGroup : costGroups) {
			flagChange = false;
			flag = false;
			String strtemp = "";
			if (costGroup.contains("*"))
				strtemp = "    ";
			else
				strtemp = "  ";
			dSDStoreGroupTemp += costGroup + strtemp + "(";
			if (dSDStoreGroupTemp.lastIndexOf("(")
					/ CPSConstants.weightDSD_StoreListCost == count) {
				dSDStoreGroup += "\n" + costGroup + strtemp + "(";
				dSDStoreGroupTemp = dSDStoreGroup;
				count++;
			} else {
				dSDStoreGroup += costGroup + strtemp + "(";
			}
			if (costGroup.contains("*")) {
				costGroup = costGroup.substring(0, costGroup.indexOf("*"));
				flagChange = true;
			}
			if (flagChange) {
				for (StoreVO storeVo : storeVos) {
					if (costGroup.equals(storeVo.getCostGroup())) {
						if (storeVo != null && !storeVo.isStoreRemoved()
								&& storeVo.getAuthorizationSW().equals("Y")) {
							flag = true;
							dSDStoreGroupTemp += storeVo.getStore() + ",";
							if (dSDStoreGroupTemp.lastIndexOf(",")
									/ CPSConstants.weightDSD_StoreListCost == count) {
								dSDStoreGroup += "\n" + storeVo.getStore()
										+ ",";
								dSDStoreGroupTemp = dSDStoreGroup;
								count++;
							} else {
								dSDStoreGroup += storeVo.getStore() + ",";
							}
						}
					}
				}
			}
			if (flag && flagChange) {
				dSDStoreGroup = dSDStoreGroup.substring(0,
						dSDStoreGroup.lastIndexOf(","));
				dSDStoreGroup += "),";
				dSDStoreGroupTemp = dSDStoreGroup;
			} else {
				dSDStoreGroup = dSDStoreGroup.substring(0,
						dSDStoreGroup.lastIndexOf("("));
				dSDStoreGroup += ",";
				dSDStoreGroupTemp = dSDStoreGroup;
			}
		}
		dSDStoreGroup = dSDStoreGroup.substring(0,
				dSDStoreGroup.lastIndexOf(","));
		return dSDStoreGroup;
	}

	private static List<String> getDSDStoreGroupAuthor(VendorVO vendor,
			AddNewCandidateService addNewCandLocal) {
		List<String> costGroupList = new ArrayList<String>();
		Set<String> strCostGroups = new HashSet<String>();
		Map<Integer, String> costGrpStoreMap = new TreeMap<Integer, String>();
		List<StoreVO> fetchDBStoreList;
		try {
			fetchDBStoreList = addNewCandLocal.fetchStoreData(
					String.valueOf(vendor.getPsItemId()),
					String.valueOf(vendor.getVendorLocNumber()));
			vendor.setPrintStores(fetchDBStoreList);
		} catch (CPSGeneralException e) {
			LOG.error(e.getMessage(), e);
		}
		if (null != vendor.getPrintStores()
				&& !vendor.getPrintStores().isEmpty()) {
			fetchDBStoreList = vendor.getPrintStores();
		} else {
			fetchDBStoreList = vendor.getAuthorizedStores();
		}
		if (null != fetchDBStoreList && !fetchDBStoreList.isEmpty()) {
			for (StoreVO storeVO : fetchDBStoreList) {
				String costGroup = storeVO.getCostGroup();
				if (CPSHelper.isNotEmpty(costGroup)) {
					costGroup = costGroup.trim();
					// Fix 1015
					if (!strCostGroups.contains(costGroup)) {
						strCostGroups.add(costGroup);
						costGrpStoreMap
								.put(CPSHelper.getIntegerValue(costGroup),
										costGroup);
						int stores = 0;
						int removedStores = 0;
						boolean costChange = false;
						boolean storesAuthorized = false;
						for (StoreVO store1 : fetchDBStoreList) {
							if (costGroup.equals(CPSHelper
									.getTrimmedValue(store1.getCostGroup()))) {
								stores++;
								if (store1.isStoreRemoved()
										|| CPSHelper.getBigdecimalValue(
												store1.getListCost())
												.doubleValue() == 0) {
									removedStores++;
								}
								if (isListCostChanged(vendor, store1)) {
									costChange = true;
								}
								if ("Y".equals(storeVO.getAuthorizationSW())) {
									storesAuthorized = true;
								}
							}
						}

						if (stores == removedStores) {
							costGrpStoreMap.remove(CPSHelper
									.getIntegerValue(costGroup));
						} else if (costChange) {
							costGrpStoreMap.remove(CPSHelper
									.getIntegerValue(costGroup));
							costGrpStoreMap.put(
									CPSHelper.getIntegerValue(costGroup),
									costGroup + "*");
						} else if (removedStores > 0 && storesAuthorized) {
							costGrpStoreMap.remove(CPSHelper
									.getIntegerValue(costGroup));
							costGrpStoreMap.put(
									CPSHelper.getIntegerValue(costGroup),
									costGroup + "*");
						}
					}
				}
			}
		}
		if (CPSHelper.isNotEmpty(costGrpStoreMap)) {
			Collection<String> cstGrp = costGrpStoreMap.values();
			for (String strCostGroup : cstGrp) {
				costGroupList.add(strCostGroup);
			}
		}
		return costGroupList;
	}

	// nghianguyen
	public static List<PrintFormVO> copyEDIEntityToEDIEntity(ProductVO object,
			String id, HttpServletRequest req, HttpServletResponse resp,
			CommonService commonLocal, AddNewCandidateService addNewCandLocal,
			HebLdapUserService hebLdapUserService)
			throws IllegalAccessException, InvocationTargetException {
		return copyProductVOToPrintFormVOEDI((ProductVO) object, id, req, resp,
				commonLocal, addNewCandLocal, hebLdapUserService);
	}

	private static List<PrintFormVO> copyProductVOToPrintFormVOEDI(
			ProductVO object, String id, HttpServletRequest req,
			HttpServletResponse resp, CommonService commonBean,
			AddNewCandidateService addNewCandLocal,
			HebLdapUserService hebLdapUserService)
			throws IllegalAccessException, InvocationTargetException {
		List<PrintFormVO> printFormList = new ArrayList<PrintFormVO>();
		PrintFormVO printFormVO = new PrintFormVO();
		printFormVO.setTotalVolumn(getTotalVolumn(object));
		ProductClassificationVO productClassificationVO = object
				.getClassificationVO();
		if (productClassificationVO != null) {
			if (CPSHelper.isNotEmpty(productClassificationVO.getBdmName())) {
				printFormVO.setBuyerName(productClassificationVO.getBdmName()
						.substring(
								0,
								productClassificationVO.getBdmName().indexOf(
										"[")));
				printFormVO.setBuyerNumber(productClassificationVO.getBdmName()
						.substring(
								productClassificationVO.getBdmName().indexOf(
										"[") + 1,
								productClassificationVO.getBdmName()
										.lastIndexOf("]")));
				// printFormVO.setBrand(productClassificationVO.getBrandName() +
				// " ["
				// + productClassificationVO.getBrand() + "]");
			}
			printFormVO.setBrand(productClassificationVO.getBrandNameDisplay());
			if (CPSHelper.isNotEmpty(object.getClassificationVO()
					.getCommodity())) {
				printFormVO.setCommodity(object.getClassificationVO()
						.getCommodityName()
						+ " ["
						+ object.getClassificationVO().getCommodity() + "]");
				printFormVO.setSubCommodity(object.getClassificationVO()
						.getSubCommodityName());
			}
		}
		printFormVO.setProductDescription(productClassificationVO
				.getProdDescritpion());
		printFormVO
				.setProductType(productClassificationVO.getProductTypeName());
		printFormVO.setType(productClassificationVO.getMerchandizeName());

		/**
		 * *** ps_intnt_cd *** 1 UPC Introduce A UPC 100 2 Case Introduce a Case
		 * 101 3 Vendor Authorize Vendor 102 4 MRT Setup an MRT 103 5 Bonus
		 * Bonus UPC for Existing Product 104 6 NewSiz Size Change for an
		 * Existing Product 105 7 Associ Associate a New UPC to an Existing
		 * Product 106 8 NewPdt New Product 107 9 Prod Introduce a Product 108
		 */
		if (object.getWorkRequest() != null) {
			printFormVO
					.setIntent(object.getWorkRequest().getIntentIdentifier());
			// Fix PIM 846
			if (CPSHelper.isNotEmpty(object.getWorkRequest().getScnCdId())) {
				printFormVO.setBonus(true);
				printFormVO.setOpenStock("\n "
						+ CPSHelper.getUPCPrintFormat(object.getWorkRequest()
								.getScnCdId()));
			} else {
				printFormVO.setBonus(false);
				printFormVO.setOpenStock("");
			}
			// End fix PIM 846
		}
		printFormVO.setCreateOn(object.getCreateOn());
		ScaleVO scaleVO = object.getScaleVO();
		if (scaleVO != null) {
			if (CPSHelper.isNotEmpty(scaleVO.getActionCode())) {
				String strActionCode = scaleVO.getActionCode().trim();
				if ("0".equals(strActionCode)) {
					strActionCode = "";
				}
				printFormVO.setActionCode(strActionCode);
			}
			if (CPSHelper.isNotEmpty(scaleVO.getGraphicsCode())) {
				String strGC = scaleVO.getGraphicsCode().trim();
				if ("0".equals(strGC)) {
					strGC = "";
				}
				printFormVO.setGraphicsCode(strGC);
			}

			printFormVO
					.setIngredients(String.valueOf(scaleVO.getIngredientSw()));
			printFormVO.setNutrition(scaleVO.getNutStatementNumber());
			printFormVO.setTareWeight(scaleVO.getPrePackTare());
			printFormVO.setScaleTareWeight("");
		}
		ShelfEdgeVO shelfEdgeVO = object.getShelfEdgeVO();
		if (shelfEdgeVO != null) {
			printFormVO.setPackaging(shelfEdgeVO.getPackaging());
		}

		PharmacyVO pharmacyVO = object.getPharmacyVO();
		/**
		 * Commented out the following lines to ignore PSE, FSA and PSE Grams
		 */
		/*
		 * printFormVO.setPseGr(pharmacyVO.getPseGrams());
		 * printFormVO.setFSA(pharmacyVO.getFSA());
		 */
		if (pharmacyVO != null) {
			printFormVO.setAvgWhslCost(pharmacyVO.getAvgCost());
			printFormVO.setDirectCost(pharmacyVO.getDirectCost());
			try {
				if (CPSHelper.isNotEmpty(pharmacyVO.getDrugSchedule())) {
					List<BaseJSFVO> drugSchedules = commonBean
							.getDrugSchedules();
					for (BaseJSFVO baseJSFVO : drugSchedules) {
						if (baseJSFVO.getId().equalsIgnoreCase(
								pharmacyVO.getDrugSchedule())) {
							printFormVO.setDrugSchedule(baseJSFVO.getName());
							break;
						}
					}
				}
				if (CPSHelper.isNotEmpty(pharmacyVO.getDrugNmCd())) {
					List<BaseJSFVO> drugnames = commonBean.getDrugNameTypes();
					for (BaseJSFVO baseJSFVO : drugnames) {
						if (baseJSFVO.getId().equalsIgnoreCase(
								pharmacyVO.getDrugNmCd())) {
							printFormVO.setDrugAbb(baseJSFVO.getName());
							break;
						}
					}
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
			}

			printFormVO.setNDC(pharmacyVO.getNdc());
		}
		PointOfSaleVO pointOfSaleVO = object.getPointOfSaleVO();
		if (pointOfSaleVO != null) {
			printFormVO.setFamilyCode1(pointOfSaleVO.getFamilyCode1());
			printFormVO.setFamilyCode2(pointOfSaleVO.getFamilyCode2());
			// printFormVO.setAVC(pointOfSaleVO.isAbusiveVolatileChemical());
			printFormVO.setDrugFactsPanel(pointOfSaleVO.isDrugFactPanel());
			printFormVO.setQtyRestricted(pointOfSaleVO.isQntityRestricted());
			printFormVO.setTime(pointOfSaleVO.getPurchaseTimeName());
			printFormVO.setAge(pointOfSaleVO.getRestrictedSalesAgeLimitName());
			printFormVO.setFoodStamp(pointOfSaleVO.isFoodStamp());
			printFormVO.setTaxFlag(pointOfSaleVO.isTaxable());
			printFormVO.setFSAEligible(pointOfSaleVO.isFsa());
		}
		// PIM 482
		// printFormVO.setPseGr(pointOfSaleVO.getPse());
		// if(CPSHelper.isNotEmpty(pointOfSaleVO.getPse())){
		// if(pointOfSaleVO.getPse().equalsIgnoreCase("S")){
		// printFormVO.setPseType("PSE Solid");
		// } else if(pointOfSaleVO.getPse().equalsIgnoreCase("L")){
		// printFormVO.setPseType("PSE Non-Solid");
		// } else {
		// printFormVO.setPseType("NO PSE");
		// }
		// }
		RetailVO retailVO = object.getRetailVO();
		if (retailVO != null) {
			if (!object.isVendorLogin()) {
				printFormVO.setInitialRetail(retailVO.getRetail() + " For $"
						+ retailVO.getRetailFor());
				printFormVO.setRetailLinkTo(retailVO.getRetailLinkTo());
				printFormVO.setCriticalItem(retailVO.getCriticalItem());
				printFormVO.setCentsOff(retailVO.getCentsOff());
				printFormVO.setOffPrePricePercentage(retailVO.getOffPreprice());
				printFormVO.setSoldByLb(retailVO.isWeightFlag());
			}
			if (!CPSHelper.isEmpty(retailVO.getSuggforPrice())
					&& Double.parseDouble(retailVO.getSuggforPrice()) > 0) {
				printFormVO.setSuggestedRetail(retailVO.getSuggRetail() + "/$"
						+ retailVO.getSuggforPrice());
			}
			if (CPSHelper.isNotEmpty(retailVO.getPrePrice())
					&& CPSHelper.getDoubleValue(retailVO.getPrePrice()) > 0.00) {
				printFormVO.setPrePriced(true);
			}
		}
		StringBuffer upcKitBuffer = new StringBuffer();
		String upcKit = new String();
		if (CPSHelper.isNotEmpty(object.getUpcKitVOs())) {
			for (UPCKitVO upcKitVo : object.getUpcKitVOs()) {
				upcKitBuffer.append(upcKitVo.getQuantity());
				upcKitBuffer.append(" - ");
				upcKitBuffer.append(upcKitVo.getUnitUPC());
				upcKitBuffer.append("-");
				upcKitBuffer.append(upcKitVo.getUpcDigit());
				upcKitBuffer.append(", ");
			}
		}
		if (CPSHelper.isNotEmpty(upcKitBuffer) && upcKitBuffer.length() > 0) {
			upcKit = upcKitBuffer.toString().substring(0,
					upcKitBuffer.lastIndexOf(", "));
		}
		List<CommentsVO> commentsVOList = object.getCommentsVO();
		if (null != commentsVOList && !commentsVOList.isEmpty()) {
			for (CommentsVO commentsVO : commentsVOList) {
				printFormVO
						.setComments(upcKit + ", " + commentsVO.getComments());
			}
		} else {
			printFormVO.setComments(upcKit);
		}
		
		// printFormVO.setComments(comments);
		// if more than one Unit UPC is having then the following properties
		// need to shown as multiple
		List<UPCVO> upcList = object.getUpcVO();
		StringBuffer sbOpenStock = new StringBuffer("");
		String multilUnitUPC = "";
		boolean flagNewUPC = false;
		int indexBeakline = 0;
		if (upcList != null && !upcList.isEmpty()) {
			for (UPCVO upcvo : upcList) {
				if (upcList.size() == 1) {
					if (upcvo != null) {
						if (CPSHelper.isNotEmpty(upcvo.getSubBrand())
								&& CPSHelper
										.isNotEmpty(upcvo.getSubBrandDesc())) {
							if (upcvo.getSubBrandDesc().contains(
									upcvo.getSubBrand())) {
								printFormVO
										.setSubBrand(upcvo.getSubBrandDesc());
							} else {
								printFormVO.setSubBrand(upcvo.getSubBrandDesc()
										+ " [" + upcvo.getSubBrand() + "]");
							}
						} else {
							if (CPSHelper.isNotEmpty(upcvo.getSubBrandDesc())) {
								printFormVO
										.setSubBrand(upcvo.getSubBrandDesc());
							} else if (CPSHelper
									.isNotEmpty(upcvo.getSubBrand())) {
								printFormVO.setSubBrand(upcvo.getSubBrand());
							} else {
								printFormVO.setSubBrand("");
							}
						}
						// Fix 1247
						printFormVO.setUnitUPC(CPSHelper
								.getUPCPrintFormat(upcvo.getUnitUpc()));
						printFormVO.setUOM(upcvo.getUnitMeasureDesc());
						printFormVO.setProductHeight(upcvo.getHeight());
						printFormVO.setProductLength(upcvo.getLength());
						printFormVO.setProductWidth(upcvo.getWidth());
						printFormVO.setSize(upcvo.getSize());
					}
				} else {
					if (upcvo != null) {
						flagNewUPC = true;
						printFormVO.setSubBrand("Multiple");
						if (indexBeakline > 0) {
							multilUnitUPC += "\n";
						}
						if (upcvo.getNewDataSw() == 'Y') {
							multilUnitUPC += "*"
									+ CPSHelper.getUPCPrintFormat(upcvo
											.getUnitUpc()) + ",";
						} else {
							multilUnitUPC += CPSHelper.getUPCPrintFormat(upcvo
									.getUnitUpc()) + ",";
						}
						indexBeakline++;
						printFormVO.setUOM("Multiple");
						printFormVO.setProductHeight("Multiple");
						printFormVO.setProductLength("Multiple");
						printFormVO.setProductWidth("Multiple");
						printFormVO.setSize("Multiple");
					}
				}
			}
		}
		if (flagNewUPC) {
			multilUnitUPC = multilUnitUPC.substring(0,
					multilUnitUPC.lastIndexOf(','));
			printFormVO.setUnitUPC("\n" + multilUnitUPC);
		}

		int index = 1;
		List<CaseVO> caseVOList = object.getCaseVOs();
		for (CaseVO caseVO : caseVOList) {
			if (caseVO != null) {
				printFormVO.setItemSize(caseVO.getItemSizeQty());
				printFormVO.setCodeDate(caseVO.isCodeDate());
				// Fix 1247
				printFormVO.setCaseUPC(CPSHelper.getUPCPrintFormat(caseVO
						.getCaseUPC()));
				printFormVO.setCaseDescription(caseVO.getCaseDescription());
				printFormVO.setChannel(caseVO.getChannelVal());
				if (CPSHelper.isNotEmpty(caseVO.getGuaranteetoStoreDays())) {
					String gDays = caseVO.getGuaranteetoStoreDays().trim();
					if ("0".equals(gDays)) {
						gDays = "";
					}
					printFormVO.setGuaranteeToStore(gDays);
				} else {
					printFormVO.setGuaranteeToStore("");
				}

				if (CPSHelper.isNotEmpty(caseVO.getInboundSpecificationDays())) {
					String iDays = caseVO.getInboundSpecificationDays().trim();
					if ("0".equals(iDays)) {
						iDays = "";
					}
					printFormVO.setInboundSpec(iDays);
				} else {
					printFormVO.setInboundSpec("");
				}

				if (CPSHelper.isNotEmpty(caseVO.getReactionDays())) {
					String rDays = caseVO.getReactionDays().trim();
					if ("0".equals(rDays)) {
						rDays = "";
					}
					printFormVO.setReaction(rDays);
				} else {
					printFormVO.setReaction("");
				}

				if (CPSHelper.isNotEmpty(caseVO.getMaxShelfLifeDays())) {
					String mslDays = caseVO.getMaxShelfLifeDays().trim();
					if ("0".equals(mslDays)) {
						mslDays = "";
					}
					printFormVO.setMaxShelfLife(mslDays);
				} else {
					printFormVO.setMaxShelfLife("");
				}

				printFormVO.setMasterPackCube(caseVO.getMasterCubeFormatted());
				printFormVO.setMasterPackHeight(caseVO
						.getMasterHeightFormatted());
				printFormVO.setMasterPackLength(caseVO
						.getMasterLengthFormatted());
				printFormVO.setMasterPackWeight(caseVO
						.getMasterWeightFormatted());
				printFormVO
						.setMasterPackWidth(caseVO.getMasterWidthFormatted());
				printFormVO.setMasterPack(caseVO.getMasterPack());
				printFormVO.setShipPackCube(caseVO.getShipCubeFormatted());
				printFormVO.setShipPackHeight(caseVO.getShipHeightFormatted());
				printFormVO.setShipPackLength(caseVO.getShipLengthFormatted());
				printFormVO.setShipPackWeight(caseVO.getShipWeightFormatted());
				printFormVO.setShipPackWidth(caseVO.getShipWidthFormatted());
				printFormVO.setShipPack(caseVO.getShipPack());
				printFormVO.setOneTouchType(get1Touch(caseVO.getOneTouch(),
						caseVO.getTouchTypeList()));
				printFormVO.setVariableWeight(caseVO.isVariableWeight());
				printFormVO.setCatchWeight(caseVO.isCatchWeight());

				if (CPSHelper.isNotEmpty(caseVO.getItemCategory())) {
					for (BaseJSFVO baseJSFVO : caseVO.getItemCategoryList()) {
						if (baseJSFVO.getId().equalsIgnoreCase(
								caseVO.getItemCategory())) {
							printFormVO.setItemCategory(baseJSFVO.getName());
						}
					}
				} else {
					printFormVO.setItemCategory("");
				}
				if (caseVO.isDsplyDryPalSw()) {
					if ("7".equals(caseVO.getSrsAffTypCd())) {
						printFormVO.setDRP(true);
						printFormVO.setRRP(false);
					} else if ("9".equals(caseVO.getSrsAffTypCd())) {
						printFormVO.setDRP(false);
						printFormVO.setRRP(true);
					}
					printFormVO.setRowsFacing(caseVO.getProdFcngNbr());
					printFormVO.setRowsDeep(caseVO.getProdRowDeepNbr());
					printFormVO.setRowsHigh(caseVO.getProdRowHiNbr());
					printFormVO.setOrientation(caseVO.getNbrOfOrintNbr());
				} else {
					printFormVO.setDRP(false);
					printFormVO.setRRP(false);
					printFormVO.setRowsFacing("");
					printFormVO.setRowsDeep("");
					printFormVO.setRowsHigh("");
					printFormVO.setOrientation(null);
				}

				// fix pim 933
				List<VendorVO> vendorVOListPrints = caseVO
						.getVendorVOListPrints();
				// END --- fix pim 933

				for (VendorVO vendorVO : vendorVOListPrints) {
					// Fix 1052. Add only new vendor to printForm
					// if (vendorVO.isEditable()) {
					if (vendorVO != null) {
						printFormVO.setGuaranteedSale(vendorVO
								.isGuarenteedSale());
						printFormVO.setDealOffered(vendorVO.isDealOffered());
						printFormVO.setImportd(vendorVO.getImportd());
						printFormVO.setVendorName(vendorVO.getVendorLocation());
						printFormVO.setVendorNumber(vendorVO
								.getVendorLocationVal());
						printFormVO
								.setOriginalVendorNumber(String
										.valueOf(vendorVO
												.getOriginalVendorLocNumber()));
						// Fix 1197
						String vnID = null;
						if (object.getWorkRequest() != null) {
							vnID = object.getWorkRequest()
									.getRecordCreationUserIdentifier();
						}
						if (vnID != null) {
							UserInfo userInfo = null;
							if (CPSHelper.isNotEmpty(vnID)) {
								try {
									userInfo = (UserInfo) hebLdapUserService
											.getUserInfo(vnID);
								} catch (UsernameNotFoundException e) {
									LOG.error(e.getMessage(), e);
								} catch (DataAccessException e1) {
									LOG.error(e1.getMessage(), e1);
								}
							}
							vnID = vnID.toUpperCase();
							if (vnID.startsWith("VB") || vnID.startsWith("V90")) {
								// Created by Vendor.
								if (null != userInfo) {
									if (CPSHelper.isNotEmpty(userInfo
											.getAttributeValue("sn"))
											&& CPSHelper
													.isNotEmpty(userInfo
															.getAttributeValue("givenName")))
										printFormVO
												.setContactName(CPSHelper
														.getTrimmedValue(userInfo
																.getAttributeValue("sn"))
														+ ", "
														+ CPSHelper
																.getTrimmedValue(userInfo
																		.getAttributeValue("givenName")));
								} else {
									if (object.getWorkRequest() != null) {
										if (CPSHelper.isNotEmpty(object
												.getWorkRequest()
												.getCandUpdtFirstName())) {
											printFormVO
													.setContactName(CPSHelper
															.getTrimmedValue(object
																	.getWorkRequest()
																	.getCandUpdtLastName())
															+ ", "
															+ CPSHelper
																	.getTrimmedValue(object
																			.getWorkRequest()
																			.getCandUpdtFirstName()));
										} else {
											printFormVO
													.setContactName(CPSHelper
															.getTrimmedValue(object
																	.getWorkRequest()
																	.getCandUpdtLastName()));
										}
									}
								}
								if (object.getWorkRequest() != null
										&& object.getWorkRequest()
												.getVendorPhoneAreaCd() != null) {
									printFormVO.setContactPhone("("
											+ object.getWorkRequest()
													.getVendorPhoneAreaCd()
											+ ") "
											+ object.getWorkRequest()
													.getVendorPhoneNumber());
								} else if (object.getWorkRequest() != null) {
									printFormVO.setContactPhone(object
											.getWorkRequest()
											.getVendorPhoneNumber());
								}
								printFormVO.setContactEmail(object
										.getWorkRequest().getVendorEmail());
							} else {
								// Created by Partner.
								if (null != userInfo) {
									if (CPSHelper.isNotEmpty(userInfo
											.getAttributeValue("sn"))) {
										printFormVO
												.setContactName(CPSHelper
														.getTrimmedValue(userInfo
																.getAttributeValue("sn"))
														+ ", "
														+ CPSHelper
																.getTrimmedValue(userInfo
																		.getAttributeValue("givenName")));
									}
								} else {
									if (object.getWorkRequest() != null
											&& CPSHelper.isNotEmpty(object
													.getWorkRequest()
													.getCandUpdtFirstName())) {
										printFormVO
												.setContactName(CPSHelper
														.getTrimmedValue(object
																.getWorkRequest()
																.getCandUpdtLastName())
														+ ", "
														+ CPSHelper
																.getTrimmedValue(object
																		.getWorkRequest()
																		.getCandUpdtFirstName()));
									} else {
										if (object.getWorkRequest() != null
												&& CPSHelper.isNotEmpty(object
														.getWorkRequest()
														.getCandUpdtLastName())) {
											printFormVO
													.setContactName(CPSHelper
															.getTrimmedValue(object
																	.getWorkRequest()
																	.getCandUpdtLastName()));
										}
									}
								}
							}
						}
						if (CPSHelper.isNotEmpty(vendorVO.getCostOwner())
								&& CPSHelper.isNotEmpty(vendorVO
										.getCostOwnerVal())) {
							if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwner().trim())
									&& !"null".equalsIgnoreCase(vendorVO
											.getCostOwnerVal().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwner()
										+ " ["
										+ vendorVO.getCostOwnerVal() + "]");
							} else if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwner().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwner().trim());
							} else if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwnerVal().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwnerVal().trim());
							}
						} else if (CPSHelper
								.isNotEmpty(vendorVO.getCostOwner())) {
							if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwner().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwner().trim());
							}
						} else if (CPSHelper.isNotEmpty(vendorVO
								.getCostOwnerVal())) {
							if (!"null".equalsIgnoreCase(vendorVO
									.getCostOwnerVal().trim())) {
								printFormVO.setCostOwner(vendorVO
										.getCostOwnerVal().trim());
							}
						} else {
							printFormVO.setCostOwner("");
						}
						if (CPSHelper.isNotEmpty(vendorVO.getCountryOfOrigin())
								&& CPSHelper.isNotEmpty(vendorVO
										.getCountryOfOriginVal())) {
							printFormVO.setCountryOfOrigin(vendorVO
									.getCountryOfOrigin()
									+ " ["
									+ vendorVO.getCountryOfOriginVal() + "]");
						} else {
							if (CPSHelper.isNotEmpty(vendorVO
									.getCountryOfOrigin())) {
								printFormVO.setCountryOfOrigin(vendorVO
										.getCountryOfOrigin());
							} else if (CPSHelper.isNotEmpty(vendorVO
									.getCountryOfOriginVal())) {
								printFormVO.setCountryOfOrigin(vendorVO
										.getCountryOfOriginVal());
							}
						}
						if (CPSHelper.isNotEmpty(vendorVO
								.getExpectedWeeklyMvt())) {
							String expWM = vendorVO.getExpectedWeeklyMvt()
									.trim();
							if ("0".equals(expWM)) {
								expWM = "";
							}
							printFormVO.setExpWklyMvmt(expWM);
						} else {
							printFormVO.setExpWklyMvmt("");
						}
						// list cost

						List<VendorLocationVO> vendorLocationVOOfUser = new ArrayList<VendorLocationVO>();
						List<Integer> vendorUserIds = new ArrayList<Integer>();
						boolean flagVendorLogin = true;
						// boolean printDataAdd = true;
						if (object.isVendorLogin()) {
							// printDataAdd = false;
							flagVendorLogin = true;
							if ("V".equalsIgnoreCase(vendorVO
									.getVendorLocationTypeCode())) {
								vendorLocationVOOfUser = object
										.getVendorLocationList().get("whsLst");
							} else {
								if ("D".equalsIgnoreCase(vendorVO
										.getVendorLocationTypeCode())) {
									vendorLocationVOOfUser = object
											.getVendorLocationList().get(
													"dsdLst");
								} else {
									vendorLocationVOOfUser.addAll(object
											.getVendorLocationList().get(
													"whsLst"));
									vendorLocationVOOfUser.addAll(object
											.getVendorLocationList().get(
													"dsdLst"));
								}
							}
							for (VendorLocationVO vendorLocationVO : vendorLocationVOOfUser) {
								if (CPSHelper.isNotEmpty(vendorLocationVO
										.getVendorId())) {
									try {
										vendorUserIds.add(Integer
												.valueOf(vendorLocationVO
														.getVendorId()));
									} catch (NumberFormatException e) {

									}
								}
							}
						} else {
							flagVendorLogin = false;
							// printDataAdd = true;
						}
						printFormVO.setListCost("");
						printFormVO.setDsdStoreGroup("");
						printFormVO.setUnitCost("");

						int vendorLocationVal = NumberUtils.toInt(vendorVO
								.getVendorLocationVal());
						if (!flagVendorLogin
								|| vendorUserIds.contains(vendorLocationVal)) {
							// printDataAdd = true;
							List<String> costGroups = new ArrayList<String>();
							costGroups = getDSDStoreGroupAuthor(vendorVO,
									addNewCandLocal);
							if (null != costGroups && !costGroups.isEmpty()) {
								Map<Integer, String> costGroupListCosts = new HashMap<Integer, String>();
								List<String> listCosts = new ArrayList<String>();
								printFormVO.setCostGroups(costGroups);
								printFormVO.setListCost(getListCostByCostGroup(
										vendorVO, costGroups,
										costGroupListCosts, listCosts));
								// printFormVO.setDsdStoreGroup(getDSDStoreGroup(vendorVO,
								// addNewCandLocal));
								printFormVO
										.setDsdStoreGroup(getDSDStoreGroup_StoreAuthorize(
												vendorVO, costGroups));
								getUnitCostPrintForm(printFormVO, caseVO,
										vendorVO, costGroups,
										costGroupListCosts, listCosts);
							} else {
								printFormVO.setCostGroups(null);
								printFormVO.setListCost(vendorVO.getListCost());
								printFormVO.setDsdStoreGroup("");
								getUnitCostPrintForm(printFormVO, caseVO,
										vendorVO, costGroups, null, null);
							}
						}

						// if (vendorVO.getSampProvideSw().equals("Y")) {
						// printFormVO.setSampleProvided(true);
						// } else {
						// printFormVO.setSampleProvided(false);
						// }
						printFormVO.setSeasonality(getSeasonality(
								vendorVO.getSeasonalityVal(),
								vendorVO.getSeasonalityList()));
						/**
						 * Keep it empty, it would be filled in by hand.
						 * 
						 * printFormVO.setOrderRestriction(vendorVO.
						 * getOrderRestriction());
						 */
						printFormVO.setOrderRestriction("");

						// Order Unit Changes
						printFormVO.setOrderUnit(getOrderUnit(
								vendorVO.getOrderUnit(),
								vendorVO.getOrderUnitList()));
						if (CPSHelper.isNotEmpty(vendorVO.getSeasonalityYr())) {
							String strSeas = vendorVO.getSeasonalityYr().trim();
							if ("0".equals(strSeas)) {
								strSeas = "";
							}
							printFormVO.setSeasonYear(strSeas);
						} else {
							printFormVO.setSeasonYear("");
						}
						if (CPSHelper.isNotEmpty(vendorVO.getTop2Top())
								&& CPSHelper.isNotEmpty(vendorVO
										.getTop2TopVal())) {
							if (!"null".equalsIgnoreCase(vendorVO.getTop2Top()
									.trim())
									&& !"null".equalsIgnoreCase(vendorVO
											.getTop2TopVal().trim())) {
								printFormVO
										.setT2tVendor(vendorVO.getTop2Top()
												+ " ["
												+ vendorVO.getTop2TopVal()
												+ "]");
							} else if (!"null".equalsIgnoreCase(vendorVO
									.getTop2Top().trim())) {
								printFormVO.setT2tVendor(vendorVO.getTop2Top()
										.trim());
							} else if (!"null".equalsIgnoreCase(vendorVO
									.getTop2TopVal().trim())) {
								printFormVO.setT2tVendor(vendorVO
										.getTop2TopVal().trim());
							}
						} else if (CPSHelper.isNotEmpty(vendorVO.getTop2Top())) {
							if (!"null".equalsIgnoreCase(vendorVO.getTop2Top()
									.trim())) {
								printFormVO.setT2tVendor(vendorVO.getTop2Top()
										.trim());
							}
						} else if (CPSHelper.isNotEmpty(vendorVO
								.getTop2TopVal())) {
							if (!"null".equalsIgnoreCase(vendorVO
									.getTop2TopVal().trim())) {
								printFormVO.setT2tVendor(vendorVO
										.getTop2TopVal().trim());
							}
						} else {
							printFormVO.setT2tVendor("");
						}
						if (CPSHelper.isNotEmpty(vendorVO.getVendorTie())) {
							String vTie = vendorVO.getVendorTie().trim();
							if ("0".equals(vTie)) {
								vTie = "";
							}
							printFormVO.setVendorTie(vTie);
						} else {
							printFormVO.setVendorTie("");
						}

						if (CPSHelper.isNotEmpty(vendorVO.getVendorTier())) {
							String vTier = vendorVO.getVendorTier().trim();
							if ("0".equals(vTier)) {
								vTier = "";
							}
							printFormVO.setVendorTier(vTier);
						} else {
							printFormVO.setVendorTier("");
						}
						printFormVO.setVpc(vendorVO.getVpc());
						if ("TRUE".equalsIgnoreCase(printFormVO.getImportd())
								&& "V".equalsIgnoreCase(vendorVO
										.getVendorLocationTypeCode())) {
							if (vendorVO.getImportVO() != null) {
								printFormVO.setColor(vendorVO.getImportVO()
										.getColor());
								printFormVO.setContainerSize(vendorVO
										.getImportVO().getContainerSize());
								printFormVO.setFreight(vendorVO.getImportVO()
										.getFreight());
								printFormVO.setIncoTerms(vendorVO.getImportVO()
										.getIncoTerms());
								printFormVO.setInStoreDate(vendorVO
										.getImportVO().getInstoreDate());
								if (CPSHelper.isNotEmpty(vendorVO.getImportVO()
										.getMinimumQty())) {
									String minQ = vendorVO.getImportVO()
											.getMinimumQty().trim();
									if ("0".equals(minQ)) {
										minQ = "";
									}
									printFormVO.setMinQty(minQ);
								} else {
									printFormVO.setMinQty("");
								}

								printFormVO.setMinType(vendorVO.getImportVO()
										.getMinimumType());
								printFormVO.setPickupPoint(vendorVO
										.getImportVO().getPickupPoint());
								printFormVO.setProrationDate(vendorVO
										.getImportVO().getProrationDate());
								if (CPSHelper.isNotEmpty(vendorVO.getImportVO()
										.getRate())) {
									String rate = vendorVO.getImportVO()
											.getRate().trim();
									Double d = new Double(rate);
									if (d.equals(0.0000D)) {
										rate = "";
									}
									printFormVO.setRatePercentage(rate);
								} else {
									printFormVO.setRatePercentage("");
								}
							}
						} else {
							printFormVO.setContainerSize("");
							printFormVO.setIncoTerms("");
							printFormVO.setColor("");
							printFormVO.setFreight("");
							printFormVO.setMinType("");
							printFormVO.setMinQty("");
							printFormVO.setPickupPoint("");
							printFormVO.setRatePercentage("");
							printFormVO.setProrationDate("");
							printFormVO.setInStoreDate("");
						}
						printFormVO.setOrderUnit("");
						printFormVO.setCostLink(vendorVO.getCostLink());
						if (CPSHelper.isNotEmpty(printFormVO.getCostLink())) {
							if (CPSHelper.isNotEmpty(printFormVO.getChannel())) {
								// No cost link for DSD cases
								// if(!isDSD(printFormVO.getChannel())){
								printFormVO.setLinkTo(vendorVO
										.getCostLinkFormatted());
								// }
							}
						}
						// if (object.getSpecSheetAttSw() == 'Y')
						// printFormVO.setSpecSheetAttached(true);
						// else
						// printFormVO.setSpecSheetAttached(false);
						List<WareHouseVO> wareHouseVOs = null;
						if (vendorVO.getVendorLocationTypeCode() != null
								&& "V".equalsIgnoreCase(vendorVO
										.getVendorLocationTypeCode())) {
							String fmtVendorId = CPSHelper
									.checkVendorNumber(vendorVO
											.getVendorLocationVal());
							if (CPSHelper.isNotEmpty(fmtVendorId)) {
								VendorList vendorList = new VendorList(null,
										null,
										CPSHelper.getIntegerValue(fmtVendorId));
								try {
									// wareHouseVOs =
									// addNewCandLocal.fetchWHSData(String.valueOf(vendorVO.getPsItemId()),
									// String.valueOf(vendorVO.getVendorLocationVal()));
									wareHouseVOs = commonBean
											.getWareHouseList(vendorList, caseVO.getClassCode());
									if (null != wareHouseVOs
											&& !wareHouseVOs.isEmpty()) {
										String facilityNumbers = "";
										for (WareHouseVO wareHouseVO : wareHouseVOs) {
											facilityNumbers += wareHouseVO
													.getFacilityNumber() + ",";
										}
										facilityNumbers = facilityNumbers
												.substring(0, facilityNumbers
														.lastIndexOf(","));
										printFormVO
												.setWhseNumber(facilityNumbers);
									} else {
										printFormVO.setWhseNumber(null);
									}

								} catch (CPSGeneralException e) {
									LOG.error(e.getMessage(), e);
								} catch (Exception e) {
									LOG.error(e.getMessage(), e);
								}
							}
						}
						// if (printDataAdd) {
						generatePDFDocument(printFormVO,
								id + "-" + caseVO.getPsItemId() + "-"
										+ vendorVO.getVendorLocNumber(), req,
								resp);
						PrintFormVO printFormVOReturn = new PrintFormVO();
						BeanUtils
								.copyProperties(printFormVOReturn, printFormVO);
						printFormList.add(printFormVOReturn);
						// }
						index++;
					}
				}
			}
		}
		return printFormList;
	}
	// nghianguyen
}