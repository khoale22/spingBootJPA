package com.heb.operations.cps.controller;

import com.heb.jaf.security.UserInfo;
import com.heb.operations.business.framework.exeption.CPSMessage;
import com.heb.operations.cps.batchUpload2.BatchUpload2Helper;
import com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO;
import com.heb.operations.cps.model.AddCandidate;
import com.heb.operations.cps.model.HebBaseInfo;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.util.Constants;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Iterator;

@Controller
@RequestMapping(value = BatchUploadController.RELATIVE_PATH_BATCH_UPLOAD)
public class BatchUploadController  extends HEBBaseService{
    public static final String RELATIVE_PATH_BATCH_UPLOAD="/protected/cps";
    public static final String RELATIVE_PATH_BATCH_UPLOAD_PAGE="/batchUpload";
    public static final String RELATIVE_PATH_ROOT_PAGE="/cps/batch/";
    private static final Logger LOG = Logger.getLogger(BatchUploadController.class);

    /**
     * View Batch Upload Page.
     *
     * @param req The HTTP request that initiated this call.
     * @param resp The HTTP response that initiated this call.
     * @return the ModelAndView of Batch Upload page.
     */
    @RequestMapping(value = RELATIVE_PATH_BATCH_UPLOAD_PAGE, method = RequestMethod.GET)
    public ModelAndView viewBatchUploadPage(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + "CPSBatchUpload2");
        AddCandidate addCandidate = new AddCandidate();
        addCandidate.setSession(req.getSession());
        addCandidate.setSelectedFunction(HebBaseInfo.CPS_BATCH_UPLOAD);
        setForm(req, addCandidate);
        return model;
    }

    /**
     * Handle upload file.
     *
     * @param fileUpload The file upload.
     * @return the ModelAndView of Batch Upload page.
     */
    @RequestMapping(value = RELATIVE_PATH_BATCH_UPLOAD_PAGE, method = RequestMethod.POST)
    public ModelAndView uploadFile(@RequestParam(value = "fileUpload", required = false) MultipartFile fileUpload, HttpServletRequest req,
                                   HttpServletResponse resp)  throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+ "CPSBatchUpload2");
        AddCandidate addCandidate = new AddCandidate();

        boolean isValidFile = true;
        try {

            // BatchUpload2Remote uploadBean = (BatchUpload2Remote)
            // getEJB(BATCH_UPLOAD_2_BEAN);
            BatchUpload2Helper batchUploadHelper = new BatchUpload2Helper();
            if (batchUploadHelper.validateBatchFile(fileUpload)) {

                BatchUploadStatusVO uploadStatusVO = batchUploadHelper.saveFile(fileUpload,
                        req.getUserPrincipal().getName());
                uploadStatusVO.setCustomerEmail(addCandidate.getAddressCustomerEmail());
				/*
				 * if(req.getParameter("typeChoise")!=null) { String
				 * type=req.getParameter("typeChoise").trim();
				 * if(type.equals("whs")) { isDsd=false;
				 * uploadStatusVO.setDsd(false); } }
				 */
                UserInfo userInfo = getUserInfo();
                // 1197 Fix
                uploadStatusVO.setEmail(userInfo.getMail());
                String phone = userInfo.getAttributeValue("telephoneNumber");
                if (phone != null) {
                    phone = CPSHelper.cleanPhoneNumber(phone);
                    if (phone.length() >= 10) {
                        uploadStatusVO.setAreaCode(phone.substring(0, 3));
                        uploadStatusVO.setPhone(phone.substring(3, 10));
                    } else {
                        uploadStatusVO.setAreaCode(phone.substring(0, 3));
                        uploadStatusVO.setPhone(phone.substring(3, phone.length()));
                    }
                }
                uploadStatusVO.setUserName(userInfo.getUid());

                String role = Constants.STRING_EMPTY;
                if (userInfo.getUserRoles() != null) {
                    for (Iterator i = userInfo.getUserRoles().keySet().iterator(); i.hasNext();) {
                        String roleNm = (String) i.next();
                        if (!"Guest".equals(roleNm)) {
                            role = roleNm;
                            break;
                        }
                    }
                }
                uploadStatusVO.setUserRole(role);
                String name = userInfo.getDisplayName();
                if (name != null) {
                    String[] names = name.split(",");
                    if (names.length > 1) {
                        uploadStatusVO.setFirstName(names[1]);
                        uploadStatusVO.setLastName(names[0]);
                    } else {
                        uploadStatusVO.setLastName(name);
                    }
                }

                getBatchUpload2Service().submitBatchUploadFile(uploadStatusVO);
            } else {
                isValidFile = false;
                CPSMessage message = new CPSMessage(
                        "Batch Upload Error: " + "Your File is not exists. Please reupload exist file.",
                        CPSMessage.ErrorSeverity.WARNING);
                saveMessage(addCandidate, message);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            LOG.error(ex.getMessage(), ex);
            CPSMessage message = new CPSMessage("Batch Upload Error: " + ex.getMessage(), CPSMessage.ErrorSeverity.ERROR);
            saveMessage(addCandidate, message);
        }
        if (isValidFile) {
            model.getModelMap().addAttribute("isSubmit","ok");
        }
        addCandidate.setSession(req.getSession());
        addCandidate.setSelectedFunction(HebBaseInfo.CPS_BATCH_UPLOAD);
        setForm(req, addCandidate);
        return model;
    }

}
