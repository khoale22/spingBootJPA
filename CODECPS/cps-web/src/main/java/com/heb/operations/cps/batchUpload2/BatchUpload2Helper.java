package com.heb.operations.cps.batchUpload2;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.Properties;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;

import com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO;
import com.heb.operations.cps.ejb.batchUpload2.BatchUploadStatusVO.STATUS;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.odc.templateapp.common.exception.HEBApplicationException;
import org.springframework.web.multipart.MultipartFile;

public class BatchUpload2Helper {

	/**
	 * Validate whether the Excel file is in correct format or not
	 * 
	 * @param fileUpload
	 * @return
	 */
	public boolean validateBatchFile(MultipartFile fileUpload) {
		boolean retunValue = true;
		if (fileUpload.getSize() == 0) {
			retunValue = false;
		} else {
			String batchFileName = fileUpload.getOriginalFilename();
			if (batchFileName == null || "".equals(batchFileName)) {
				retunValue = false;
			} else {
				int fileIndex = batchFileName.indexOf('.');
				if (fileIndex == -1) {
					retunValue = false;
				}
			}
		}
		return retunValue;
	}

	public BatchUploadStatusVO saveFile(MultipartFile fileUpload, String userId) throws HEBApplicationException, IOException {

		Resource resource = new ClassPathResource(CPSHelper.getProfileActivePath() + "/cps-service-application.properties");
		Properties serviceProps;
		String uploadDirectory = null;
		try {
			serviceProps = PropertiesLoaderUtils.loadProperties(resource);
			uploadDirectory = serviceProps.getProperty("BatchUploadDirectory");
		} catch (IOException e) {
			throw new HEBApplicationException("No batch upload directory specified.  Call Help Desk");
		}

		new File(uploadDirectory).mkdirs();

		String realFileName = generateFileName(fileUpload.getOriginalFilename(), userId);

		FileOutputStream fos = new FileOutputStream(uploadDirectory + File.separator + realFileName);
		fos.write(fileUpload.getBytes());
		fos.flush();
		fos.close();

		BatchUploadStatusVO ret = new BatchUploadStatusVO();
		ret.setPctComplete((short) 0);
		ret.setRealFileName(realFileName);
		ret.setUploadTime(Calendar.getInstance());
		ret.setUserFileName(fileUpload.getOriginalFilename());
		ret.setUserName(userId);
		ret.setStatus(STATUS.RECEIVED);

		return ret;

	}

	private String generateFileName(String fileName, String userId) {
		StringBuilder builderFile = new StringBuilder();
		builderFile.append(userId).append("_").append(CPSHelper.getStringValue(System.currentTimeMillis())).append("_").append(CPSHelper.getStringValue(((int) (Math.random() * (double) 100000))))
				.append("_").append(fileName);
		// userId + "_" + System.currentTimeMillis() + "_" + ((int)
		// (Math.random() * (double) 100000)) + "_" + fileName;
		return builderFile.toString();
	}

}
