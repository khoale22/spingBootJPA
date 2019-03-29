/**
 * CPSServices.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.heb.operations.cps.vrowtest.darkside;

public interface CPSServices extends java.rmi.Remote {
    public com.heb.operations.cps.vrowtest.darkside.BasicVO[] getBDMs() throws java.rmi.RemoteException, com.heb.operations.cps.vrowtest.darkside.Exception;
    public com.heb.operations.cps.vrowtest.darkside.BasicVO[] getCommoditiesForBDM(java.lang.String arg0) throws java.rmi.RemoteException, com.heb.operations.cps.vrowtest.darkside.Exception;
}
