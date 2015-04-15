package com.datatactics.l3.fcc.atlas.ecfs.servlets;

import java.io.IOException;
import java.io.Writer;
import java.sql.CallableStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.datatactics.l3.fcc.atlas.mysql.Connector;

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
      

        String user =       request.getServletContext().getInitParameter("mysql.user");
        String password =   request.getServletContext().getInitParameter("mysql.password");
        String server =     request.getServletContext().getInitParameter("mysql.server");
        String port =       request.getServletContext().getInitParameter("mysql.port");
        String database =   request.getServletContext().getInitParameter("mysql.database");
        

        String proceedingNumber   = getParameter(request, "proceedingNumber");
        String filer              = getParameter(request, "filer");
        //String email              = getParameter(request, "email");
        //String street             = getParameter(request, "street");
        //String street2            = getParameter(request, "street2");
        String city               = getParameter(request, "city");
        String state              = getParameter(request, "state");
        String zip                = getParameter(request, "zip");
        String zipExt             = getParameter(request, "zipExt");
        String comments           = getParameter(request, "comments");

        System.err.println("parameter - zip     : [" + zip + "]");
        System.err.println("parameter - zipExt  : [" + zipExt + "]");
        
        if ((zipExt == null) || (zipExt.trim().equals(""))) {
            zipExt = "0000";
        }
        System.err.println("variable - zipExt   : [" + zipExt + "]");
        String zipCode = zip.concat("-").concat(zipExt);
        System.err.println("variable - zipCode  : [" + zipCode + "]");
        
        Writer writer = response.getWriter();
        try {
            Connector mysql = new Connector(user, password, server, port, database);
            CallableStatement proc = mysql.getConnection().prepareCall("{call insert_indexFields(?, ?, ?, ?, ?, ?)}");
            proc.setString(1,  filer);
            proc.setString(2,  city);
            proc.setString(3,  proceedingNumber);
            proc.setString(4,  state);
            proc.setString(5,  comments);
            proc.setString(6,  zipCode);
            
            proc.execute();
            
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", "x");
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
