package com.Webproject1.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.Webproject.Models.*;
import com.Webproject1.connection.Getconnection;
/**
 * Servlet implementation class Cancel
 */
//@WebServlet("/Cancel")
public class Cancel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Cancel() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String name = request.getParameter("cancel");
		System.out.println(name);
		request.setAttribute("name", name);
		cancel can = new cancel(name);
		Connection con = null;
	    //PreparedStatement insertStmt = null;
	    PreparedStatement checkStmt = null;
	    
	    ResultSet rs = null;
	    ResultSet rs1 = null;
	    Getconnection gc = new Getconnection() ;
        try {
        	con = gc.getConnection();
	        String checksql = "SELECT name FROM bookingdata WHERE name = ?";
	        checkStmt = con.prepareStatement(checksql);
	        checkStmt.setString(1, can.getName());
	        rs = checkStmt.executeQuery();
	        if(rs.next()) {
	        	System.out.println(can.getName()+" is found in Bookinginfo Table");
	        	String dname = request.getParameter("delete");
	        	System.out.println(dname);
	        	request.setAttribute("dname",dname);
	        	delete dele = new delete(dname);
	        	PreparedStatement deleteStmt = null;
	        	String deleteSQL = "DELETE FROM bookingdata WHERE name = ?";
	        	try {
	                deleteStmt = con.prepareStatement(deleteSQL);
	                deleteStmt.setString(1, dele.getDname());
	                
	                // Use executeUpdate for DELETE statements
	                int rowsAffected = deleteStmt.executeUpdate();
	                
	                if (rowsAffected > 0) {
	                	System.out.println("no of rows deleted : "+rowsAffected);
	                    System.out.println("Ticket Deleted ");
	                    RequestDispatcher rd = request.getRequestDispatcher("/delete.jsp");
	                    rd.forward(request, response);
	                } else {
	                    System.out.println("No ticket found with the specified name");
	                }
	            } catch (SQLException e) {
	                e.printStackTrace();
	                System.out.println("An error occurred while trying to delete the ticket");
	            }
	        }
	        else {
	        	System.out.println("name not found");
	        }
	    }catch (Exception e) {
			// TODO: handle exception
	    	e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doGet(request, response);
//	}

}
