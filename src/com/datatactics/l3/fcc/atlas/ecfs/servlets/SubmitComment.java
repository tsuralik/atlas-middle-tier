package com.datatactics.l3.fcc.atlas.ecfs.servlets;

import java.io.IOException;
import java.io.Writer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.datatactics.l3.fcc.atlas.ecfs.DocumentFactory;
import com.datatactics.l3.fcc.atlas.solr.SolrProxy;

/**
 * Servlet implementation class SubmitComment
 */
@WebServlet("/SubmitComment")
public class SubmitComment extends HttpServlet {
    
    private static final long       serialVersionUID    = 1L;
    private static final String     DEFAULT_VALUE       = "test";
    private static final String     FALSE               = "false";
    private static final String     TRUE                = "true";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmitComment() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected String getParameter(HttpServletRequest request, String parameterName) {

        String retVal = request.getParameter(parameterName);
        if ((retVal == null) || (retVal.trim().equals(""))) {
            retVal = DEFAULT_VALUE;
        }
        
        return retVal;
    }
    
    protected void processCommentSubmission(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
        System.err.println("requestURL   : " + request.getRequestURL());
        System.err.println("queryString  : " + request.getQueryString());
      

        String zookeeperIP = request.getServletContext().getInitParameter("zookeeper.IP");
        int zookeeperPort  = Integer.parseInt(request.getServletContext().getInitParameter("zookeeper.port"));
        

        String proceedingNumber   = getParameter(request, "proceedingNumber");
        String filer              = getParameter(request, "filer");
        String email              = getParameter(request, "email");
        String street             = getParameter(request, "street");
        String street2            = getParameter(request, "street2");
        String city               = getParameter(request, "city");
        String state              = getParameter(request, "state");
        String zip                = getParameter(request, "zip");
        String zipExt             = getParameter(request, "zipExt");
        String comments           = getParameter(request, "comments");
        
        
        Writer writer = response.getWriter();
        try {
            SolrProxy solr = new SolrProxy(zookeeperIP, zookeeperPort, "ECFS");
            DocumentFactory documentFactory = new DocumentFactory();
            documentFactory.setApplicant(filer);
            documentFactory.setApplicant_Sort(DEFAULT_VALUE);
            documentFactory.setBrief(TRUE);
            documentFactory.setCity(city);
            //documentFactory.setDateRcpt(date);
            //documentFactory.setDisseminated(date);
            documentFactory.setExParte(FALSE);
            documentFactory.setId("2");
            //documentFactory.setModified(date);
            documentFactory.setPages("1");
            documentFactory.setProceeding(proceedingNumber);
            documentFactory.setRegFlexAnalysis(FALSE);
            documentFactory.setSmallBusinessImpact(FALSE);
            documentFactory.setStateCd(state);
            documentFactory.setSubmissionType("COMMENT");
            documentFactory.setText(comments);
            documentFactory.setViewingStatus("Unrestricted");
            documentFactory.setZip(zip);
            
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", "3");

            solr.instance().add(documentFactory.createSolrInputDocument());
            solr.instance().commit();
            writer.write(jsonObject.toJSONString());
        } catch(Exception e) {
            String msg = e.getMessage();
            writer.write(msg);

            e.printStackTrace();
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

}
