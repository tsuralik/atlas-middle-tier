package com.datatactics.l3.fcc.atlas.ecfs.servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;

import com.datatactics.l3.fcc.atlas.solr.SolrProxy;

/**
 * Servlet implementation class Delete
 */
@WebServlet("/Delete")
public class Delete extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Delete() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String zookeeperIP = request.getServletContext().getInitParameter("zookeeper.IP");
        int zookeeperPort  = Integer.parseInt(request.getServletContext().getInitParameter("zookeeper.port"));
        
        SolrProxy solr = new SolrProxy(zookeeperIP, zookeeperPort, "ECFS");
        
        System.err.println("deleting id: [" + request.getParameter("id") + "]");
        
        SolrQuery query = new SolrQuery();
        query.setQuery("*:*");
        query.setFields("id","applicant","deleted");
        query.addFilterQuery("id:" + request.getParameter("id"));
        query.setStart(0);   
        
        QueryResponse queryResponse;
        try {
            queryResponse = solr.instance().query(query);

            SolrDocument solrDoc = null;
            String outputLine = null;
            String outputLineFormat = "solrDoc [id:%1$s]:[application:%2$s]";
            
            SolrDocumentList results = queryResponse.getResults();
            for (int i=0; i<results.size(); i++) {
                solrDoc = (SolrDocument) results.get(i);
                SolrInputDocument sid = new SolrInputDocument();
                
                Map<String, Boolean> partialUpdate = new HashMap<String, Boolean>();
                partialUpdate.put("set", true);
                sid.addField("id", solrDoc.getFieldValue("id"));
                sid.addField("deleted", partialUpdate);
                
                solr.instance().add(sid);
                solr.instance().commit();

                outputLine = String.format(outputLineFormat, solrDoc.getFieldValue("id"), solrDoc.getFieldValue("applicant"));
                response.getWriter().println(outputLine);
            }
        } catch (SolrServerException e) {
            e.printStackTrace();
        }
        
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
    }

}
