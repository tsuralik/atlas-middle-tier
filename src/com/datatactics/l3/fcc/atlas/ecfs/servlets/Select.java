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

/**
 * Servlet implementation class Select
 */
@WebServlet("/Select")
public class Select extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Select() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
//        System.err.println("request      : " + request);
        System.err.println("requestURL   : " + request.getRequestURL());
        System.err.println("queryString  : " + request.getQueryString());
//        System.err.println("requestURI   : " + request.getRequestURI());
//        System.err.println("serverName   : " + request.getServerName());
//        System.err.println("serverPort   : " + request.getServerPort());
//        System.err.println("servletPath  : " + request.getServletPath());
//        System.err.println("parameterMap : " + request.getParameterMap());
        
        URL url = new URL("http", "10.0.2.15", 9090, "/solr/ECFS/select");
        URLConnection conn = url.openConnection();
        conn.setDoOutput(true);

        OutputStreamWriter writer = null;
        try {
            OutputStream os = conn.getOutputStream();
            writer = new OutputStreamWriter(os);
            writer.write(request.getQueryString()); 
            writer.flush();
        } catch(Exception e) {
            e.printStackTrace();
        }

        String line;
        BufferedReader reader = null;
        try {
            InputStream is = conn.getInputStream();
            InputStreamReader isr = new InputStreamReader(is);
            reader = new BufferedReader(isr);
            while ((line = reader.readLine()) != null) {
                response.getWriter().println(line);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        if (writer != null) {
            writer.write("\n");
            writer.close();
        }
        reader.close();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
    }

}
