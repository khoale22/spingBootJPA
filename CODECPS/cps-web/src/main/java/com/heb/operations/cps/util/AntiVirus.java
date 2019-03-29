package com.heb.operations.cps.util;

import java.io.ByteArrayInputStream;

import com.heb.sadc.utils.AntiVirusException;

public interface AntiVirus {
	/**
	 * 
	 * @param fileData
	 * @return  true if No Virus false if it has Virus
	 * @throws AntiVirusException 
	 */
	public boolean virusCheck(ByteArrayInputStream fileData) throws AntiVirusException ;

}


/*
 * 
 * From http://www.clamav.net/doc/0.88.4/man/clamdscan.1
> >
> > .SH "RETURN CODES"
> > .LP
> > 0 : No virus found.
> > .TP
> > 1 : Virus(es) found.
> > .TP
> > 2 : An error occured.
*/