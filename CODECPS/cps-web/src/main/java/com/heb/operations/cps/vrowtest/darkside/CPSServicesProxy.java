package com.heb.operations.cps.vrowtest.darkside;

import org.apache.log4j.Logger;


public class CPSServicesProxy implements com.heb.operations.cps.vrowtest.darkside.CPSServices {
  private static Logger LOG = Logger.getLogger(CPSServicesProxy.class);  
  private String _endpoint = null;
  private com.heb.operations.cps.vrowtest.darkside.CPSServices cPSServices = null;
  
  public CPSServicesProxy() {
    _initCPSServicesProxy();
  }
  
  public CPSServicesProxy(String endpoint) {
    _endpoint = endpoint;
    _initCPSServicesProxy();
  }
  
  private void _initCPSServicesProxy() {
    try {
      cPSServices = (new com.heb.operations.cps.vrowtest.darkside.CPSServicesBeanServiceLocator()).getCPSServicesBeanPort();
      if (cPSServices != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)cPSServices)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)cPSServices)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {
	LOG.error(serviceException.getMessage(), serviceException);
    }
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (cPSServices != null)
      ((javax.xml.rpc.Stub)cPSServices)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.heb.operations.cps.vrowtest.darkside.CPSServices getCPSServices() {
    if (cPSServices == null)
      _initCPSServicesProxy();
    return cPSServices;
  }
  
  public com.heb.operations.cps.vrowtest.darkside.BasicVO[] getBDMs() throws java.rmi.RemoteException, com.heb.operations.cps.vrowtest.darkside.Exception{
    if (cPSServices == null)
      _initCPSServicesProxy();
    return cPSServices.getBDMs();
  }
  
  public com.heb.operations.cps.vrowtest.darkside.BasicVO[] getCommoditiesForBDM(java.lang.String arg0) throws java.rmi.RemoteException, com.heb.operations.cps.vrowtest.darkside.Exception{
    if (cPSServices == null)
      _initCPSServicesProxy();
    return cPSServices.getCommoditiesForBDM(arg0);
  }
  
  
}