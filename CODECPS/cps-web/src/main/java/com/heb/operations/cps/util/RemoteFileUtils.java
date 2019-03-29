package com.heb.operations.cps.util;

import java.io.File;
import java.io.IOException;

public class RemoteFileUtils {
	
	private static String[] remoteHosts = null;
	private static String pkiPassPhrase = null;
	private static String remoteUser = null;
	private static String tmpDir = null;
	private static String privateKey = null;
	
	static{
		String clusterPeers = System.getProperty(CPSConstants.CPS_CLUSTER_PEERS);
		if(clusterPeers != null){
			remoteHosts = clusterPeers.split(",");
		}
		
		pkiPassPhrase = System.getProperty(CPSConstants.CPS_PKI_PASSPHRASE);
		remoteUser = System.getProperty(CPSConstants.CPS_PKI_REMOTE_USER);
		privateKey = System.getProperty(CPSConstants.CPS_PKI_PRIVATE_KEY);
		tmpDir = System.getProperty("java.io.tmpdir");
	}
	
	public static File tryToCopyOver(String path, String fileName) throws IOException{
			
		File ret = null;
		
		String fullName = path+File.separator+fileName;
		File existingFile = new File(fullName);
		
		
		
		
		if(existingFile.exists()){
			ret = existingFile;
		}
		else{
			if((remoteHosts != null) && (remoteHosts.length > 0)){
				for (int i = 0; i < remoteHosts.length; i++) {
					
					String tmpFileName = tmpDir+File.separator+remoteHosts[i]+"_"+fileName;
					
					SCPFrom.remoteCopy2(remoteUser, remoteHosts[i], pkiPassPhrase, privateKey, fullName, tmpFileName);
					File tmpFile = new File(tmpFileName);
					if(tmpFile.exists()){
						ret = tmpFile;
						break;
					}
				}
			}

		}
		
		return ret;
		
	}
	
	
}
