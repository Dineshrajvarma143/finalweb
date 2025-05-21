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
import java.sql.Statement;

import com.Webproject.Models.Information;
import com.Webproject.Models.Logininfo;
import com.Webproject1.connection.Getconnection;
import com.mysql.cj.protocol.Resultset;
import com.sun.net.httpserver.Request;

/**
 * Servlet implementation class Login
 */
//@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
       // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lemail = request.getParameter("lemail");
        String password = request.getParameter("pass");

        System.out.println("Email: " + lemail);
        System.out.println("Password: " + password);

        request.setAttribute("email", lemail);
        request.setAttribute("passkey", password);

        if (lemail != null && lemail.contains("@retro.com") && password.equals("admin123")) {
            RequestDispatcher rd = request.getRequestDispatcher("/update.jsp");
            rd.forward(request, response);
            return; 
        }

        System.out.println("You are not admin");

        Logininfo lf = new Logininfo(lemail, password); 
        try {
            insertintologin(lf, request, response); 
        } catch (SQLException e) {
            e.printStackTrace();
            //response.sendRedirect("/error.jsp");
        }
    }
	public static void insertintologin(Logininfo lf, HttpServletRequest request, HttpServletResponse response) throws SQLException {
	    Connection con = null;
	    PreparedStatement insertStmt = null;
	    PreparedStatement checkStmt = null;
	    ResultSet rs = null;

	    try {
	        
	        con = new Getconnection().getConnection();//Get database connection

	        
	        String insertSQL = "INSERT INTO logindata (id, email, password) VALUES (?, ?, ?)";// Insert login data using PreparedStatement (safe from SQL injection)
	        insertStmt = con.prepareStatement(insertSQL);
	        insertStmt.setInt(1, lf.getId());
	        insertStmt.setString(2, lf.getLemail());
	        insertStmt.setString(3, lf.getPassword());

	        int rowsInserted = insertStmt.executeUpdate();
	        System.out.println("Rows inserted: " + rowsInserted);

	        String checkSQL = "SELECT email FROM registerdatails WHERE email = ? and password = ?";// Check if the email is registered in registerdetails
	        checkStmt = con.prepareStatement(checkSQL);
	        checkStmt.setString(1, lf.getLemail());
	        checkStmt.setString(2, lf.getPassword());

	        rs = checkStmt.executeQuery();

	        if (rs.next()) {
	            System.out.println("Email found in registerdetails: " + lf.getLemail());// Forward based on email existence
	            RequestDispatcher rd = request.getRequestDispatcher("/home.jsp");
	            rd.forward(request, response);
	        } else {
	            System.out.println("Email/Password Mis-match in registerdetails: " + lf.getLemail());
	            RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
	            rd.forward(request, response);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        // Clean up resources
	        if (rs != null) try { rs.close(); } catch (Exception e) {}// Clean up resources
	        if (insertStmt != null) try { insertStmt.close(); } catch (Exception e) {}
	        if (checkStmt != null) try { checkStmt.close(); } catch (Exception e) {}
	        if (con != null) try { con.close(); } catch (Exception e) {}
	    }
	}
}


