package com.datatactics.l3.fcc.atlas.ecfs.servlets;

import java.io.IOException;
import java.io.Writer;
import java.sql.CallableStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.solr.client.solrj.SolrServerException;
import org.json.simple.JSONObject;

import com.datatactics.l3.fcc.atlas.ecfs.DocumentFactory;
import com.datatactics.l3.fcc.atlas.ecfs.EcfsException;
import com.datatactics.l3.fcc.atlas.mysql.Connector;
import com.datatactics.l3.fcc.atlas.solr.SolrProxy;
import com.datatactics.l3.fcc.utils.FccConstants;

/**
 * Servlet implementation class SubmitComment
 */
@WebServlet("/SubmitComment")
public class SubmitComment extends HttpServlet {
    private static final Logger log = LogManager.getLogger(SubmitComment.class);
    
    /**
     * Auto-generated serial version UID
     */
    private static final long serialVersionUID = 8022958382695837096L;
    
    private static final String     DEFAULT_VALUE       = "test";
    private static final String     FALSE               = "false";
    private static final String     TRUE                = "true";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmitComment() {
        super();
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
            retVal = DEFAULT_VALUE;
        }
        
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
    
    /** 
     * Push the comment data to a MySQL server. The configuration parameters for the MySQL server are expected to 
     * be in the servletContext of the servlet request.  The SubmissionData is expected to have the required data
     * fields populated.
     * 
     * @param request the servlet request containing the servlet context which should have MySQL configuration values
     * @param submissionData the submission form data to be inserted into MySQL
     * @return <code>true</code> if the insertion succeeded properly, <code>false</code> false otherwise
     * @throws EcfsException
     */
    protected SubmissionResult sendCommentSubmissionToMySQL(HttpServletRequest request, SubmissionData submissionData) throws EcfsException {
        SubmissionResult submissionResult = new SubmissionResult();
        
        String user =       request.getServletContext().getInitParameter(FccConstants.MYSQL_USER);
        String password =   request.getServletContext().getInitParameter(FccConstants.MYSQL_PASSWORD);
        String server =     request.getServletContext().getInitParameter(FccConstants.MYSQL_SERVER);
        String port =       request.getServletContext().getInitParameter(FccConstants.MYSQL_PORT);
        String database =   request.getServletContext().getInitParameter(FccConstants.MYSQL_DATABASE);
        
        Connector mysql;
        try {
            // create a connection to the server
            mysql = new Connector(user, password, server, port, database);
            
            // insert the data into the <code>insert_indexFields</code> table via a stored procedure
            CallableStatement proc = mysql.getConnection().prepareCall("{call insert_indexFields(?, ?, ?, ?, ?, ?)}");
            proc.setString(1,  submissionData.filer);
            proc.setString(2,  submissionData.city);
            proc.setString(3,  submissionData.proceedingNumber);
            proc.setString(4,  submissionData.state);
            proc.setString(5,  submissionData.comments);
            proc.setString(6,  submissionData.getZipCode());            
            proc.execute();
            
            // set the return value to true if we have gotten to this point without an exception
            submissionResult.success = true;
        } catch (SQLException e) {
            throw new EcfsException("could not execute stored procedure to insert rows into indexFields");
        }
        
        return submissionResult;
    }

    /** 
     * Push the comment data to a SOLR instance. The configuration parameters for the SOLR server are expected to 
     * be in the servletContext of the servlet request.  The SubmissionData is expected to have the required data
     * fields populated.
     * 
     * @param request the servlet request containing the servlet context which should have SOLR configuration values
     * @param submissionData the submission form data to be inserted into SOLR
     * @return <code>true</code> if the insertion succeeded properly, <code>false</code> false otherwise
     * @throws EcfsException
     */
    protected SubmissionResult sendCommentSubmissionToSolr(HttpServletRequest request, SubmissionData submissionData) throws EcfsException {
        SubmissionResult submissionResult = new SubmissionResult();
        
        String zookeeperIPStr   = request.getServletContext().getInitParameter("zookeeper.IP");
        String zookeeperPortStr = request.getServletContext().getInitParameter("zookeeper.port");
        String collectionName   = "ECFS";
        
        // if all of the parameters have data
        if (hasData(zookeeperIPStr) && hasData(zookeeperPortStr) && hasData(collectionName)) {
            try {
                // convert the port string to an integer
                int zookeeperPort = Integer.parseInt(zookeeperPortStr);
                
                // connect to the solr server
                SolrProxy solrProxy = new SolrProxy(zookeeperIPStr, zookeeperPort, collectionName);
                
                // use the factory to configure a SolrInputDocument
                DocumentFactory solrDocFactory = new DocumentFactory();
                solrDocFactory.setApplicant(submissionData.filer);
                solrDocFactory.setCity(submissionData.city);
                solrDocFactory.setProceeding(submissionData.proceedingNumber);
                solrDocFactory.setStateCd(submissionData.state);
                solrDocFactory.setText(submissionData.comments);
                solrDocFactory.setZip(submissionData.getZipCode());
                
                System.out.println("sending comment to solr:\n" + solrDocFactory.toString());
                
                // stage the document for commit to solr
                solrProxy.instance().add(solrDocFactory.createSolrInputDocument());
                
                // commit the document and set the return value to the success of the operation
                submissionResult.success = solrProxy.commit();
                submissionResult.id = solrDocFactory.getId();
            } catch (NumberFormatException nfe) {
                System.err.println("could not format [" + zookeeperPortStr + "] to an integer");
            } catch (SolrServerException e) {
                System.err.println("could add submission to solr: " + e.getMessage());
            } catch (IOException e) {
                System.err.println("could add submission to solr: " + e.getMessage());
            } 
        }
        
        return submissionResult;
    }

    /**
     * Write the results of the submission back to the client.
     * 
     * @param response the servlet response containing the writer to communicate back to the client
     * @param success the value indicating whether the commit was successful
     * @throws EcfsException 
     */
    @SuppressWarnings("unchecked")
    private void writeResults(HttpServletResponse response, SubmissionResult submissionResult) throws EcfsException {
        JSONObject jsonObject = new JSONObject();

        Writer writer = null;
        try {
            writer = response.getWriter();
            jsonObject.put("success", Boolean.toString(submissionResult.success));
            jsonObject.put("id", submissionResult.id);
            writer.write(jsonObject.toJSONString());
        } catch (IOException ioe) {
            System.err.println("could not write response [" + jsonObject.toJSONString() + "]");
            throw new EcfsException("could not write response", ioe);
        } finally {
            try {
                if (writer != null) {
                    writer.close();
                }
            } catch(Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    protected void processCommentSubmission(HttpServletRequest request, HttpServletResponse response) {
        System.err.println("submit version : " + "?");
        System.err.println("requestURL     : " + request.getRequestURL());
        System.err.println("queryString    : " + request.getQueryString());
        
        SubmissionData submissionData = null;
        SubmissionResult submissionResult = null;
        try {
            submissionData = new SubmissionData(request);

            if (submissionData.isValid()) {
                //submissionSuccess = sendCommentSubmissionToMySQL(request, submissionData);
                submissionResult = sendCommentSubmissionToSolr(request, submissionData);
            }
        } catch (EcfsException ee) {
            submissionResult.success = false;
        }

        try {
            writeResults(response, submissionResult);
        } catch (EcfsException e) {
            System.err.println("could not write response back to client: [" + submissionResult.success + "]");
        }
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processCommentSubmission(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processCommentSubmission(request, response);
    }
    
    private class SubmissionData {   
        String proceedingNumber   = null;
        String filer              = null;
        //String email              = null;
        //String street             = null;
        //String street2            = null;
        String city               = null;
        String state              = null;
        String zip                = null;
        String zipExt             = null;
        String comments           = null;

        
        private SubmissionData(HttpServletRequest request) throws EcfsException {
            proceedingNumber   = getParameter(request, "proceedingNumber");
            filer              = getParameter(request, "filer");
            //email              = getParameter(request, "email");
            //street             = getParameter(request, "street");
            //street2            = getParameter(request, "street2");
            city               = getParameter(request, "city");
            state              = getParameter(request, "state");
            zip                = getParameter(request, "zip");
            zipExt             = getParameter(request, "zipExt");
            comments           = getParameter(request, "comments");

            System.err.println("parameter - zip     : [" + zip + "]");
            System.err.println("parameter - zipExt  : [" + zipExt + "]");
            
            if ((zipExt == null) || (zipExt.trim().equals(""))) {
                zipExt = "0000";
            }
            
            System.err.println("variable - zipExt   : [" + zipExt + "]");
            
            if (isInvalid()) {
                throw new EcfsException("insufficient parameter details");
            }
        }
        
        private String getZipCode() {
            return zip.concat("-").concat(zipExt);
        }
        
        private boolean isInvalid() {
            return !isValid();
        }

        private boolean isValid() {
            return hasData(proceedingNumber) &&
                   hasData(filer) &&
                   hasData(city) &&
                   hasData(state) &&
                   hasData(zip) &&
                   hasData(zipExt) &&
                   hasData(comments);
        }
    }

    private class SubmissionResult {
        private boolean success = false;
        private String id = "N/A";
    }
}
