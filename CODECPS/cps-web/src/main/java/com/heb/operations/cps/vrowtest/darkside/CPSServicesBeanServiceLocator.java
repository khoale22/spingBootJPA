/**
 * CPSServicesBeanServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.heb.operations.cps.vrowtest.darkside;

import org.apache.log4j.Logger;



public class CPSServicesBeanServiceLocator extends org.apache.axis.client.Service implements com.heb.operations.cps.vrowtest.darkside.CPSServicesBeanService {
    private static Logger LOG = Logger.getLogger(CPSServicesBeanServiceLocator.class);
    public CPSServicesBeanServiceLocator() {
    }


    public CPSServicesBeanServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public CPSServicesBeanServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for CPSServicesBeanPort
    private java.lang.String CPSServicesBeanPort_address = "http://catapl0014303.heb.com:8080/CPSServicesBeanService/CPSServicesBean";

    public java.lang.String getCPSServicesBeanPortAddress() {
        return CPSServicesBeanPort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String CPSServicesBeanPortWSDDServiceName = "CPSServicesBeanPort";

    public java.lang.String getCPSServicesBeanPortWSDDServiceName() {
        return CPSServicesBeanPortWSDDServiceName;
    }

    public void setCPSServicesBeanPortWSDDServiceName(java.lang.String name) {
        CPSServicesBeanPortWSDDServiceName = name;
    }

    public com.heb.operations.cps.vrowtest.darkside.CPSServices getCPSServicesBeanPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(CPSServicesBeanPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getCPSServicesBeanPort(endpoint);
    }

    public com.heb.operations.cps.vrowtest.darkside.CPSServices getCPSServicesBeanPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.heb.operations.cps.vrowtest.darkside.CPSServicesBindingStub _stub = new com.heb.operations.cps.vrowtest.darkside.CPSServicesBindingStub(portAddress, this);
            _stub.setPortName(getCPSServicesBeanPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            LOG.error(e.getMessage(), e);
            return null;
        }
    }

    public void setCPSServicesBeanPortEndpointAddress(java.lang.String address) {
        CPSServicesBeanPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.heb.operations.cps.vrowtest.darkside.CPSServices.class.isAssignableFrom(serviceEndpointInterface)) {
                com.heb.operations.cps.vrowtest.darkside.CPSServicesBindingStub _stub = new com.heb.operations.cps.vrowtest.darkside.CPSServicesBindingStub(new java.net.URL(CPSServicesBeanPort_address), this);
                _stub.setPortName(getCPSServicesBeanPortWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("CPSServicesBeanPort".equals(inputPortName)) {
            return getCPSServicesBeanPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://darkside.vrowtest.cps.operations.heb.com/", "CPSServicesBeanService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://darkside.vrowtest.cps.operations.heb.com/", "CPSServicesBeanPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("CPSServicesBeanPort".equals(portName)) {
            setCPSServicesBeanPortEndpointAddress(address);
        }
        else {
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
