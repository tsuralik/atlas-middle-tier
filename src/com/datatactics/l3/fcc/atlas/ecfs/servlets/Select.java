package com.datatactics.l3.fcc.atlas.ecfs.servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.URISyntaxException;
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
import com.datatactics.l3.fcc.utils.FccConstants;
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

    private String getSolrHost(HttpServletRequest request) {
        return request.getServletContext().getInitParameter(FccConstants.SOLR_HOST);
    }
    
    private int getSolrPort(HttpServletRequest request) throws EcfsException {
        int solrPort = -1;

        String solrPortStr = request.getServletContext().getInitParameter(FccConstants.SOLR_PORT);
        if (hasData(solrPortStr)) {
            try {
                solrPort = Integer.parseInt(solrPortStr);
            } catch(Exception e) {
                throw new EcfsException("could not cast solr port [" + solrPortStr + "] to integer");
            }
        }
        return solrPort;
    }
    
    /**
     * Get the specified parameter from the <code>HttpServletRequest</code>.
     * 
     * @param request the servlet request instance
     * @param parameterName the name of the parameter to retrieve
     * @return
     */
    protected String getParameter(HttpServletRequest request, String parameterName) {

        // get the parameter value from the request
        String retVal = request.getParameter(parameterName);
        
        // if the parameter did not exist, set the default value
        if (!hasData(retVal)) {
            retVal = null;
        }
        
        System.out.println("parameter: " + parameterName + " : [" + retVal + "]");
        
        return retVal;
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
    
    private String appendFQ(String parameterName, String parameterValue) {
        StringBuilder builder = new StringBuilder();
        
        if (hasData(parameterValue)) { 
            builder.append("fq=");
            builder.append(parameterName);
            builder.append("%3A");
            builder.append(parameterValue);
        }
        
        System.out.println(String.format("append FQ: %1$s: [%2$s]", parameterName, builder.toString()));
        
        return builder.toString();
    }
    
    private String convertQueryString(String queryString, SelectionData selectionData) { 
        StringBuilder builder = new StringBuilder();
        builder.append(appendFQ("proceeding",       selectionData.proceeding));
        builder.append(appendFQ("text",             selectionData.text));
        builder.append(appendFQ("submissionType",   selectionData.submissionType));
        builder.append(appendFQ("applicant",        selectionData.applicant));
        builder.append(appendFQ("city",             selectionData.city));
        builder.append(appendFQ("stateCd",          selectionData.stateCd));
        builder.append(appendFQ("zip",              selectionData.zip));
        builder.append(appendFQ("brief",            selectionData.brief));
        builder.append(appendFQ("exParte",          selectionData.exParte));
        builder.append("&");
        builder.append("q=*%3A*&wt=json&indent=true");
        
        return builder.toString();
    }
    
    private URLConnection createConnectionToSolr(HttpServletRequest request) throws EcfsException {
        String solrHost = getSolrHost(request);
        int solrPort  = getSolrPort(request);

        URLConnection conn = null;
        if (hasData(solrHost) && (solrPort > 0)) {
            try {
                URL url = new URL(HTTP, solrHost, solrPort, SOLR_SELECT_SERVLET);
                conn = url.openConnection();
                System.err.println("solr URL: " + conn.getURL());
                conn.setDoOutput(true);
            } catch (NullPointerException | IOException ex) {
                String msg = "could not create URLConnection";
                //log.warn(LogFormatter.formatException(msg, null, ex));
                throw new EcfsException(msg, ex);
            }
        }
        else {
            System.out.println("insufficient data");
            System.out.println("solrHost: " + solrHost);
            System.out.println("solrPort: " + solrPort);
        }
        
        return conn;
    }
    
    private void forwardTheRequestToSolr(URLConnection conn, SelectionData selectionData) throws EcfsException {
        OutputStreamWriter writer = null;
        
        try {
            String convertedQuery = convertQueryString(selectionData.getQueryString(), selectionData);
            
            System.out.println("converted query: " + convertedQuery);
            
            OutputStream os = conn.getOutputStream();
            writer = new OutputStreamWriter(os);
            writer.write(convertedQuery);
//            writer.write(selectionData.getQueryString()); 
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
    
    private void reportResultsBackToClient(URLConnection conn, HttpServletResponse response, SelectionData selectionData) throws EcfsException {
        String line;
        BufferedReader reader = null;
        PrintWriter responseWriter = null;
        try {
            InputStream is = conn.getInputStream();
            InputStreamReader isr = new InputStreamReader(is);
            reader = new BufferedReader(isr);
            
            responseWriter = response.getWriter();
            responseWriter.write(selectionData.getJsonWrf());
            
            // write json object return from solr
            responseWriter.append("(");
            while ((line = reader.readLine()) != null) {
                responseWriter.println(line);
            }
            
            responseWriter.append(")");

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
        System.err.println("select version : " + "8");
        
        logRequestProperties(request);
        
        URLConnection conn = null;
        SelectionData selectionData = null;
        try {
            selectionData = new SelectionData(request);
            conn = createConnectionToSolr(request);
            forwardTheRequestToSolr(conn, selectionData);
            reportResultsBackToClient(conn, response, selectionData);
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

    
    private class SelectionData {   
        String queryString      = null;
        String jsonWrf          = null;
        String proceeding       = null;
        String text             = null;
        String submissionType   = null;
        String applicant        = null;
        String city             = null;
        String stateCd          = null;
        String zip              = null;
        String brief            = null;
        String exParte          = null;
        
        private SelectionData(HttpServletRequest request) throws EcfsException {
            
            queryString     = request.getQueryString();
            jsonWrf         = getParameter(request, "json.wrf");
            proceeding      = getParameter(request, "proceeding");
            text            = getParameter(request, "text");
            submissionType  = getParameter(request, "submissionType");
            applicant       = getParameter(request, "applicant");
            city            = getParameter(request, "city");
            stateCd         = getParameter(request, "stateCd");
            zip             = getParameter(request, "zip");
            brief           = getParameter(request, "brief");
            exParte         = getParameter(request, "exParte");
            
            if (isInvalid()) {
                throw new EcfsException("insufficient parameter details");
            }
        }
        
        private String getQueryString() {
            return queryString;
        }
        
        private String getJsonWrf() {
            return jsonWrf;
        }
        
        private boolean isInvalid() {
            return !isValid();
        }

        private boolean isValid() {
            return hasData(queryString) &&
                   hasData(jsonWrf);
        }
    }

    private class SubmissionResult {
        private boolean success = false;
    }

}
