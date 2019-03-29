package com.heb.operations.cps.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.log4j.Logger;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.UserInfo;

public class SCPFrom {
    private static Logger LOG = Logger.getLogger(SCPFrom.class);
    public static void remoteCopy(String remoteUser, String remoteHost, String passPhrase, String remoteFile, String localFile) {
	//final Logger LOG = Logger.getInstance();
	FileOutputStream fos = null;
	try {

	    String user = remoteUser;
	    // arg[0]=arg[0].substring(arg[0].indexOf('@')+1);
	    String host = remoteHost;// arg[0].substring(0,
	    // arg[0].indexOf(':'));
	    String rfile = remoteFile; // arg[0].substring(arg[0].indexOf(':')+1);
	    String lfile = localFile; // arg[1];
	    String pPhrase = passPhrase;

	    String prefix = null;
	    if (new File(lfile).isDirectory()) {
		prefix = lfile + File.separator;
	    }

	    JSch jsch = new JSch();
	    Session session = jsch.getSession(user, host, 22);

	    // username and password will be given via UserInfo interface.
	    UserInfo ui = null;// new MyUserInfo();
	    session.setUserInfo(ui);
	    session.connect();

	    // exec 'scp -p -f rfile' remotely
	    String command = "scp -p -f " + rfile;
	    Channel channel = session.openChannel("exec");
	    ((ChannelExec) channel).setCommand(command);

	    // get I/O streams for remote scp
	    OutputStream out = channel.getOutputStream();
	    InputStream in = channel.getInputStream();

	    channel.connect();

	    byte[] buf = new byte[1024];

	    // send '\0'
	    buf[0] = 0;
	    out.write(buf, 0, 1);
	    out.flush();

	    while (true) {

		int c = checkAck(in);
		if (c != 'T') {
		    break;
		}

		long modtime = 0L;
		while (true) {
		    if (in.read(buf, 0, 1) < 0) {
			// error
			break;
		    }
		    if (buf[0] == ' ')
			break;
		    modtime = modtime * 10L + (long) (buf[0] - '0');
		}
		in.read(buf, 0, 2);
		long acctime = 0L;
		while (true) {
		    if (in.read(buf, 0, 1) < 0) {
			// error
			break;
		    }
		    if (buf[0] == ' ')
			break;
		    acctime = acctime * 10L + (long) (buf[0] - '0');
		}

		// send '\0'
		buf[0] = 0;
		out.write(buf, 0, 1);
		out.flush();

		while (true) {
		    c = checkAck(in);
		    if (c == 'C') {
			break;
		    }
		}
		in.read(buf, 0, 5);
		long filesize = 0L;
		while (true) {
		    if (in.read(buf, 0, 1) < 0) {
			// error
			break;
		    }
		    if (buf[0] == ' ')
			break;
		    filesize = filesize * 10L + (long) (buf[0] - '0');
		}

		String file = null;
		for (int i = 0;; i++) {
		    in.read(buf, i, 1);
		    if (buf[i] == (byte) 0x0a) {
			file = new String(buf, 0, i);
			break;
		    }
		}

		// send '\0'
		buf[0] = 0;
		out.write(buf, 0, 1);
		out.flush();

		// read a content of lfile
		fos = new FileOutputStream(prefix == null ? lfile : prefix + file);
		int foo;
		while (true) {
		    if (buf.length < filesize)
			foo = buf.length;
		    else
			foo = (int) filesize;
		    foo = in.read(buf, 0, foo);
		    if (foo < 0) {
			// error
			break;
		    }
		    fos.write(buf, 0, foo);
		    filesize -= foo;
		    if (filesize == 0L)
			break;
		}
		fos.close();
		fos = null;
		File tempfile = new File(prefix + file);
		tempfile.setLastModified(modtime * 1000);

		if (checkAck(in) != 0) {
		    // System.exit(0);
		    return;
		}

		// send '\0'
		buf[0] = 0;
		out.write(buf, 0, 1);
		out.flush();
	    }

	    session.disconnect();

	    // System.exit(0);
	} catch (Exception e) {
	    LOG.error(e.getMessage(), e);
	    try {
		if (fos != null)
		    fos.close();
	    } catch (Exception ee) {
		LOG.error(ee.getMessage(), ee);
	    }
	}
    }

    static int checkAck(InputStream in) throws IOException {
	int b = in.read();
	// b may be 0 for success,
	// 1 for error,
	// 2 for fatal error,
	// -1
	if (b == 0)
	    return b;
	if (b == -1)
	    return b;

	if (b == 1 || b == 2) {
	    StringBuffer sb = new StringBuffer();
	    int c;
	    do {
		c = in.read();
		sb.append((char) c);
	    } while (c != '\n');
	}
	return b;
    }

    public static void remoteCopy2(String remoteUser, String remoteHost, String passPhrase, String privateKey, String remoteFile, String localFile) {

	try {

	    final String fPassPhrase = passPhrase;

	    JSch jsch = new JSch();

	    jsch.addIdentity(privateKey);

	    String host = remoteHost;

	    String user = remoteUser;

	    Session session = jsch.getSession(user, host, 22);

	    UserInfo ui = new UserInfo() {

		public String getPassphrase() {
		    return fPassPhrase;
		}

		public String getPassword() {
		    return null;
		}

		public boolean promptPassphrase(String arg0) {
		    return true;
		}

		public boolean promptPassword(String arg0) {
		    return true;
		}

		public boolean promptYesNo(String arg0) {
		    return true;
		}

		public void showMessage(String arg0) {
		}

	    };
	    session.setUserInfo(ui);
	    session.connect();

	    // exec 'scp -f rfile' remotely
	    String command = "scp -f " + remoteFile;
	    Channel channel = session.openChannel("exec");
	    ((ChannelExec) channel).setCommand(command);

	    // get I/O streams for remote scp
	    OutputStream out = channel.getOutputStream();
	    InputStream in = channel.getInputStream();

	    channel.connect();

	    byte[] buf = new byte[1024];

	    // send '\0'
	    buf[0] = 0;
	    out.write(buf, 0, 1);
	    out.flush();

	    while (true) {
		int c = checkAck(in);
		if (c != 'C') {
		    break;
		}

		// read '0644 '
		in.read(buf, 0, 5);

		long filesize = 0L;
		while (true) {
		    if (in.read(buf, 0, 1) < 0) {
			// error
			break;
		    }
		    if (buf[0] == ' ')
			break;
		    filesize = filesize * 10L + (long) (buf[0] - '0');
		}

		String file = null;
		for (int i = 0;; i++) {
		    in.read(buf, i, 1);
		    if (buf[i] == (byte) 0x0a) {
			file = new String(buf, 0, i);
			break;
		    }
		}

		// send '\0'
		buf[0] = 0;
		out.write(buf, 0, 1);
		out.flush();

		// read a content of lfile
		FileOutputStream fos = new FileOutputStream(localFile);
		int foo;
		while (true) {
		    if (buf.length < filesize)
			foo = buf.length;
		    else
			foo = (int) filesize;
		    foo = in.read(buf, 0, foo);
		    if (foo < 0) {
			// error
			break;
		    }
		    fos.write(buf, 0, foo);
		    filesize -= foo;
		    if (filesize == 0L)
			break;
		}
		fos.close();
		fos = null;

		if (checkAck(in) != 0) {
		    return;
		}

		// send '\0'
		buf[0] = 0;
		out.write(buf, 0, 1);
		out.flush();
	    }

	    session.disconnect();

	} catch (Exception e) {	    
	    LOG.error(e.getMessage(), e);
	}
    }

}