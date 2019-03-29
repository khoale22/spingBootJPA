package com.heb.operations.cps.util;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.heb.sadc.utils.AntiVirusException;
import com.heb.sadc.utils.ClamAvAntiVirus95;

public class ClamAVAntivirus implements AntiVirus {

    private static Logger LOG = Logger.getLogger(ClamAVAntivirus.class);


	/**
	 * handles the ClamAV Virus Check
	 * 
	 * @param fileData
	 * @return true if No Virus
	 * @throws AntiVirusException 
	 */

	public boolean virusCheck(ByteArrayInputStream fileData) throws AntiVirusException {

		boolean finalResult = false;
		InputStream is = null;
		Properties properties = new Properties();

		try {
			is = this.getClass().getResourceAsStream(
					"/AVResources.properties");
			properties.load(is);

			String serverAddress = properties.getProperty("clamav.servername");
			String serverPort = properties.getProperty("clamav.port");
			String maxBufferSize = properties.getProperty("clamav.maxBufferSize");
			
//			LOG.debug(" ----------- ClamAV Server Details ---------- ");
//			LOG.debug("Server Address ==> " + serverAddress
//					+ " : Server Port ==> " + serverPort);
//			LOG.debug("Max Buffer Size ==> "+maxBufferSize);

			ClamAvAntiVirus95 scanner = new ClamAvAntiVirus95(serverAddress, serverPort);
			
			scanner.setMaxBufferSize(Integer.parseInt(maxBufferSize));
			
			StringBuffer strContent = new StringBuffer();
			int i;
			while ((i = fileData.read()) != -1) {
				strContent.append((char) i); // In case you want to know the contents
			}
			
			finalResult = scanner.isVirus(strContent.toString().getBytes());
			
		} catch (AntiVirusException e) {
			LOG.error(e.getMessage(), e);
			throw e;
		} catch (IOException e) {
			LOG.error("Couldn't get I/O for the connection",e);
			throw new AntiVirusException("Couldn't get I/O for the connection " + e.getMessage());
		} finally {
			// Close the socket and the file
			try {
			    if(is != null){
				is.close();
			    }
			} catch (IOException ioException) {
				LOG.error("Couldn't close connection"
						+ ioException.getMessage(), ioException);
			}
		}
		return finalResult;
	}
}

/*			InetAddress ipAddress = InetAddress.getByName(serverAddress);
			String IP = ipAddress.getHostAddress();
			LOG.debug("Server IP ADDRESS ==> " + IP);

			// Creating a socket to connect to the server
			Socket requestSocket = new Socket(ipAddress, Integer
					.parseInt(serverPort));

			myOS = requestSocket.getOutputStream();
			myOSW = new OutputStreamWriter(myOS);

			LOG.debug("Open connection to ClamAV Server");

			myOSW.write(properties.getProperty("clamav.session") + "\r\n");
			myOSW.flush();
			myOSW.write(properties.getProperty("clamav.stream") + "\r\n");
			myOSW.flush();

			in = new BufferedReader(new InputStreamReader(requestSocket
					.getInputStream()));

			String readPortInfo = in.readLine(); // Get the port back from Server after connection is established

			LOG.debug("Get Port Info : " + readPortInfo);
			StringTokenizer st = new StringTokenizer(readPortInfo, " ");

			while (st.hasMoreTokens()) {
				port = st.nextToken();
			}

			LOG.debug("Port ==> " + port);

			// Open the second connection to scan server
			scannerSocket = new Socket(ipAddress, Integer.parseInt(port));

			// Get the data and create a Buffered input stream.
			StringBuffer strContent = new StringBuffer();
			try {
				int i;
				while ((i = fileData.read()) != -1) {
					strContent.append((char) i); // In case you want to know the contents
				}
				bInput = fileData.toString().getBytes();
				LOG.debug("Actual Byte ::: " + bInput);
				byteInputStrm = new ByteArrayInputStream(bInput);

				myOS = scannerSocket.getOutputStream();
				myOS.write(strContent.toString().getBytes());
				myOS.flush();

				scannerSocket.close(); // Close the socket if not you won't get the results back

				BufferedReader in2 = new BufferedReader(new InputStreamReader(
						requestSocket.getInputStream()));

				String resultMsg = in2.readLine(); // Final Result from Controller
				LOG.debug("Result Message ===> " + resultMsg);

				byteInputStrm.close();
				in2.close();

				StringTokenizer stMsg = new StringTokenizer(resultMsg, ": ");

				while (stMsg.hasMoreTokens()) {
					msgContent = stMsg.nextToken();
				}

				LOG.debug("Message from ClamAV ===> " + msgContent);

				if (msgContent.equalsIgnoreCase("OK"))
					finalResult = true;

				LOG.debug("Final Result ===>" + finalResult);
			} catch (UnknownHostException e) {
				log.fatal("Unable to find the hostname");
			}

		} catch (UnknownHostException e) {
			log.error("Couldn't find information on hostname: ");
		} catch (IOException e) {
			log.error("Couldn't get I/O for the connection to: "
					+ e.getMessage());
		} finally {
			// Close the socket and the file
			try {
				in.close();
				myOSW.flush();
				myOSW.close();
				myOS.close();
				is.close();

				if (requestSocket != null) {
					requestSocket.close();
				}
				log.info("Socket Connection to ClamAV Closed");
			} catch (IOException ioException) {
				log.error("Couldn't close connection"
						+ ioException.getMessage());
			}
		}*/
