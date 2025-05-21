package com.Webproject1.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Webproject.Models.Bookinginfo;
import com.Webproject1.connection.Getconnection;

/**
 * Servlet implementation class view
 */
//@WebServlet("/view")
public class view extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public view() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        List<Bookinginfo> bookingss = new ArrayList<>();
		Getconnection gc = new Getconnection() ;
        try (Connection con = gc.getConnection();
        		
		         PreparedStatement stmt = con.prepareStatement("SELECT * FROM bookingdata");
		         ResultSet rs = stmt.executeQuery()) {

		        java.util.List<Bookinginfo> bookings = new java.util.ArrayList<>();
		        while (rs.next()) {
		            Bookinginfo b = new Bookinginfo(
		                rs.getString("name"),
		                rs.getString("eventId"),
		                rs.getString("seatCount")
		            );
		            b.setId(rs.getInt("id"));
		            bookings.add(b);
		        }
		        request.setAttribute("bookings", bookingss);
	            request.getRequestDispatcher("/view.jsp").forward(request, response);
		        request.setAttribute("bookings", bookings);
		        RequestDispatcher rd =request.getRequestDispatcher("/cancel.jsp");
		        rd.forward(request, response);
		        //String username = (String) request.getSession().getAttribute("username");
		        PreparedStatement ps = con.prepareStatement("SELECT * FROM bookingdata WHERE name = ?");
		        ps.setString(1, username);

		    } catch (Exception e) {
		        e.printStackTrace();
		        request.setAttribute("errorMessage", "Could not fetch bookings.");
		        request.getRequestDispatcher("/error.jsp").forward(request, response);
		    }
	}
}
