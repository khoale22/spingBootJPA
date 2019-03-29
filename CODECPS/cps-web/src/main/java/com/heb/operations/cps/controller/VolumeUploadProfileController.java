package com.heb.operations.cps.controller;

import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.exeption.CPSMessage;
import com.heb.operations.cps.model.HebBaseInfo;
import com.heb.operations.cps.model.ManageEDICandidate;
import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.vo.MassUploadVO;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = VolumeUploadProfileController.RELATIVE_PATH__BASE)
public class VolumeUploadProfileController extends HEBBaseService {

    private static final Logger LOG = Logger.getLogger(HEBBaseService.class);

    public static final String RELATIVE_PATH__BASE="/protected/cps";
    public static final String RELATIVE_PATH_UPLOAD_PROFILE_PAGE="/volumeUploadProfile";
    public static final String RELATIVE_PATH_DELETE_MASS_UPLOAD_PROFILE="/volumeUploadProfile/deleteMassUploadProfilies";
    public static final String RELATIVE_PATH_UPDATE_MASS_UPLOAD_PROFILE="/volumeUploadProfile/updateMassUploadProfilies";
    public static final String RELATIVE_PATH_ROOT_PAGE="/cps/manageEDI/";

    /**
     * View Volume Upload Profile page.
     *
     * @param req The HTTP request that initiated this call.
     * @param resp The HTTP response that initiated this call.
     * @return the ModelAndView of volume upload profile page.
     */
    @RequestMapping(value = RELATIVE_PATH_UPLOAD_PROFILE_PAGE, method = RequestMethod.GET)
    public ModelAndView viewMassUploadProfiliesPage(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + "massUploadProfile");
        ManageEDICandidate cpsEDIManage = new ManageEDICandidate();
        cpsEDIManage.setSession(req.getSession());
       // this.setForm(req, cpsEDIManage);
        Object currentMode = req.getSession().getAttribute(
                CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null) {
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        }
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
        cpsEDIManage.setFilterValues("");
        cpsEDIManage.setCurrentPage(1);
        cpsEDIManage.setCurrentRecord(50);
        cpsEDIManage.setSelectedFunction(HebBaseInfo.CPS_VOLUME_UPLOAD_PROFILE);
        setForm(req, cpsEDIManage);
        List<MassUploadVO> lstMassUploadVOs= new ArrayList<MassUploadVO>();
        try{
            lstMassUploadVOs = getCommonService()
                    .getAllMassUpploadProfiles();
        } catch (Exception ex) {
            ex.printStackTrace();
            LOG.error(ex.getMessage(), ex);
            CPSMessage message = new CPSMessage("Volume Upload Profile Error: " + ex.getMessage(), CPSMessage.ErrorSeverity.ERROR);
            saveMessage(cpsEDIManage, message);
        }
        if (req.getSession().getAttribute(CPSConstants.MASS_UPLOAD_VOs) != null) {
            req.getSession().removeAttribute(CPSConstants.MASS_UPLOAD_VOs);
        }
        req.getSession().setAttribute(CPSConstants.MASS_UPLOAD_VOs, lstMassUploadVOs);
        return model;
    }

    /**
     * Delete Volume Upload Profile.
     *
     * @param req The HTTP request that initiated this call.
     * @param resp The HTTP response that initiated this call.
     * @return the ModelAndView of volume upload profile page.
     */
    @RequestMapping(value = RELATIVE_PATH_DELETE_MASS_UPLOAD_PROFILE, method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView deleteMassUploadProfilies(HttpServletRequest req, HttpServletResponse resp) throws CPSGeneralException {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + "massUploadProfile");
        ManageEDICandidate cpsEDIManage = (ManageEDICandidate) getForm(req);
        if (req.getSession().getAttribute(CPSConstants.MASS_UPLOAD_VOs) != null) {
            req.getSession().removeAttribute(CPSConstants.MASS_UPLOAD_VOs);
        }
        List<MassUploadVO> lstMassUPloadUpdates = cpsEDIManage
                .getLstMassUPloadUpdates();
        try{
            getCommonService().removeMassUpploadProfiles(lstMassUPloadUpdates);
            saveMessage(cpsEDIManage, new CPSMessage("Deleted Successfully.",
                    CPSMessage.ErrorSeverity.INFO));
        } catch (Exception ex) {
            ex.printStackTrace();
            LOG.error(ex.getMessage(), ex);
            CPSMessage message = new CPSMessage("Volume Upload Profile Error: " + ex.getMessage(), CPSMessage.ErrorSeverity.ERROR);
            saveMessage(cpsEDIManage, message);
        }
        List<MassUploadVO> lstMassUploadVOs = getCommonService()
                .getAllMassUpploadProfiles();
        req.getSession().setAttribute(CPSConstants.MASS_UPLOAD_VOs, lstMassUploadVOs);
        cpsEDIManage.setSession(req.getSession());
        cpsEDIManage.setSelectedFunction(HebBaseInfo.CPS_VOLUME_UPLOAD_PROFILE);
        setForm(req, cpsEDIManage);
        return model;
    }

    /**
     * Update/Add Volume Upload Profile.
     *
     * @param req The HTTP request that initiated this call.
     * @param resp The HTTP response that initiated this call.
     * @return the ModelAndView of volume upload profile page.
     */
    @RequestMapping(value = RELATIVE_PATH_UPDATE_MASS_UPLOAD_PROFILE, method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView updateMassUploadProfilies(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + "massUploadProfile");
        ManageEDICandidate fmEDI = (ManageEDICandidate) getForm(req);
        fmEDI.setSession(req.getSession());
        this.setForm(req, fmEDI);
        if (req.getSession().getAttribute(CPSConstants.MASS_UPLOAD_VOs) != null)
            req.getSession().removeAttribute(CPSConstants.MASS_UPLOAD_VOs);
        List<MassUploadVO> lstMassUploadUpdates = fmEDI.getLstMassUPloadUpdates();
        try{
            getCommonService().saveMassUpploadProfiles(lstMassUploadUpdates);
            saveMessage(fmEDI, new CPSMessage("Saved Successfully.",
                    CPSMessage.ErrorSeverity.INFO));
        } catch (Exception ex) {
            ex.printStackTrace();
            LOG.error(ex.getMessage(), ex);
            CPSMessage message = new CPSMessage("Volume Upload Profile Error: " + ex.getMessage(), CPSMessage.ErrorSeverity.ERROR);
            saveMessage(fmEDI, message);
        }
        List<MassUploadVO> lstMassUploadVOs = getCommonService().getAllMassUpploadProfiles();
        Integer vendorIdAdd = null;
        int functionId = 0;
        for (MassUploadVO massUploadVO : lstMassUploadUpdates) {
            if (massUploadVO != null && massUploadVO.isAddFlag()) {
                vendorIdAdd = massUploadVO.getVendorId();
                functionId = massUploadVO.getFunctionId();
                break;
            }
        }
        if (!CPSHelper.isEmpty(vendorIdAdd)) {
            List<MassUploadVO> lstMassUploadVOsDisplay = new ArrayList<MassUploadVO>();
            MassUploadVO massUploadVOAdd = null;
            for (MassUploadVO massUploadVO : lstMassUploadVOs) {
                if (massUploadVO != null
                        && massUploadVO.getVendorId().equals(vendorIdAdd)
                        && massUploadVO.getFunctionId() == functionId) {
                    massUploadVOAdd = massUploadVO;
                } else {
                    lstMassUploadVOsDisplay.add(massUploadVO);
                }
            }
            if (massUploadVOAdd != null) {
                int currentPage = fmEDI.getCurrentPage();
                int currentRowPage = fmEDI.getCurrentRecord();
                int index = 0;
                if (currentPage > 1) {
                    index = (currentPage - 1) * currentRowPage;
                }
                lstMassUploadVOsDisplay.add(index, massUploadVOAdd);
            }
            req.getSession().setAttribute(CPSConstants.MASS_UPLOAD_VOs,
                    lstMassUploadVOsDisplay);
        } else {
            req.getSession().setAttribute(CPSConstants.MASS_UPLOAD_VOs, lstMassUploadVOs);
        }

        fmEDI.setSelectedFunction(HebBaseInfo.CPS_VOLUME_UPLOAD_PROFILE);
        setForm(req, fmEDI);

        return model;
    }

}
