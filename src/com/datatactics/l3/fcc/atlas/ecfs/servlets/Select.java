package com.datatactics.l3.fcc.atlas.ecfs.servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.datatactics.l3.fcc.atlas.ecfs.EcfsException;
import com.datatactics.l3.fcc.utils.LogFormatter;

/**
 * Servlet implementation class Select
 */
@WebServlet("/Select")
public class Select extends HttpServlet {
    private static final Logger log = LogManager.getLogger(Select.class);
    private static final long serialVersionUID = 1L;
    
    private static final String HTTP = "http";
    private static final String SOLR_SELECT_SERVLET = "/solr/ECFS/select";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Select() {
        super();
    }
    
    private void logRequestProperties(HttpServletRequest request) {
//      System.err.println("request      : " + request);
      System.err.println("requestURL   : " + request.getRequestURL());
      System.err.println("queryString  : " + request.getQueryString());
//      System.err.println("requestURI   : " + request.getRequestURI());
//      System.err.println("serverName   : " + request.getServerName());
//      System.err.println("serverPort   : " + request.getServerPort());
//      System.err.println("servletPath  : " + request.getServletPath());
//      System.err.println("parameterMap : " + request.getParameterMap());
    }
    
    private String getSolrHostProperty(HttpServletRequest request) {
        return "192.255.32.218"; 
        //return request.getServletContext().getInitParameter(FccConstants.SOLR_HOST);
    }
    
    private int getSolrPortProperty(HttpServletRequest request) {
        return 8500; 
        /*
        int port = -1;
        String portStr = request.getServletContext().getInitParameter(FccConstants.SOLR_PORT);
        if (hasData(portStr)) {
            try {
                port = Integer.parseInt(portStr);
            } catch(NumberFormatException nfe) {
                String msg = "Could not cast solr port property to a number";
                log.warn(LogFormatter.formatException(msg, null, nfe);
            }
        }
        return port;
        */
    }
    
    /** 
     * Check if the specified variable is non-null and non-empty.
     * 
     * @param variable the variable to inspect
     * @return <code>true</code> unless the variable is 1) null or 2) empty - after having trimmed whitespace 
     */
    private boolean hasData(String variable) {
        return (variable != null && !variable.trim().isEmpty());
    }
    
    private URLConnection createConnectionToSolr(HttpServletRequest request) throws EcfsException {
        String solrHost = getSolrHostProperty(request);
        int solrPort  = getSolrPortProperty(request);

        URLConnection conn = null;
        if (hasData(solrHost) && (solrPort > 0)) {
            try {
                URL url = new URL(HTTP, solrHost, solrPort, SOLR_SELECT_SERVLET);
                conn = url.openConnection();
                conn.setDoOutput(true);
            } catch (NullPointerException | IOException ex) {
                String msg = "could not create URLConnection";
                //log.warn(LogFormatter.formatException(msg, null, ex));
                throw new EcfsException(msg, ex);
            }
        }
        
        return conn;
    }
    
    private void forwardTheRequestToSolr(URLConnection conn, String queryString) throws EcfsException {
        OutputStreamWriter writer = null;
        
        try {
            OutputStream os = conn.getOutputStream();

            writer = new OutputStreamWriter(os);
            writer.write(queryString); 
            writer.flush();
        } catch(NullPointerException | IOException ex) {
            String msg = "could not forward the request to solr";
            //log.warn(LogFormatter.formatException(msg, null, ex));
            throw new EcfsException(msg, ex);
        } finally { 
            if (writer != null) {
                try {
                    writer.write("\n");
                    writer.close();
                } catch (IOException ioe) {
                    String msg = "could not close the OutputStreamWriter";
                    log.warn(LogFormatter.formatException(msg, null, ioe));
                }
            }
        }
    }
    
    private void reportResultsBackToClient(URLConnection conn, HttpServletResponse response) throws EcfsException {
        String line;
        BufferedReader reader = null;
        try {
            InputStream is = conn.getInputStream();
            InputStreamReader isr = new InputStreamReader(is);
            reader = new BufferedReader(isr);
            while ((line = reader.readLine()) != null) {
                response.getWriter().println(line);
            }
        } catch(Exception ex) {
            String msg = "could not write the results back to the client";
            //log.warn(LogFormatter.formatException(msg, null, ex));
            throw new EcfsException(msg, ex);
        } finally { 
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException ioe) {
                    String msg = "could not close the BufferedReader";
                    log.warn(LogFormatter.formatException(msg, null, ioe));
                }
            }
        }
    }
    
    private void processSelectRequest(HttpServletRequest request, HttpServletResponse response) {
        System.err.println("select version : " + "?");
        
        logRequestProperties(request);
        
        URLConnection conn = null;
        try {
            conn = createConnectionToSolr(request);
            forwardTheRequestToSolr(conn, request.getQueryString());
            reportResultsBackToClient(conn, response);
        } catch (EcfsException ee) {
            String msg = "could not process selection request";
            log.warn(LogFormatter.formatException(msg, null, ee));
        }
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processSelectRequest(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processSelectRequest(request, response);
    }

}
