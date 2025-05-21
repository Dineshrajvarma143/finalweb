package com.Webproject1.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
//import sun.rmi.server.Dispatcher;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.Webproject.Models.Bookinginfo;
import com.Webproject1.connection.Getconnection;

/**
 * Servlet implementation class Booking
 */
//@WebServlet("/Booking")
public class Booking extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Booking() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String eventId = request.getParameter("eventId");
        String seatCount = request.getParameter("seatCount");
        request.setAttribute("name", name);
        request.setAttribute("eventId", eventId);
        request.setAttribute("seatCount", seatCount);
        RequestDispatcher rd = request.getRequestDispatcher("/view.jsp");
        rd.forward(request, response);
        Bookinginfo bi = new Bookinginfo(name, eventId, seatCount);

        processBooking(bi, request, response);
    }

    public static void processBooking(Bookinginfo bi, HttpServletRequest request, HttpServletResponse response) {
        Connection con = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        try {
            con = new Getconnection().getConnection();
            String checkSQL = "SELECT seatCount FROM bookingdata WHERE seatCount = ? AND eventId = ?";
            checkStmt = con.prepareStatement(checkSQL);
            checkStmt.setString(1, bi.getSeatCount());
            checkStmt.setString(2, bi.getEventId());
            rs = checkStmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("errorMessage", "This seat is already booked. Please select another seat.");
                request.getRequestDispatcher("/booking.jsp").forward(request, response);
                return;
            }

            String insertSQL = "INSERT INTO bookingdata (name, eventId, seatCount) VALUES (?, ?, ?)";
            insertStmt = con.prepareStatement(insertSQL);
            insertStmt.setString(1, bi.getName());
            insertStmt.setString(2, bi.getEventId());
            insertStmt.setString(3, bi.getSeatCount());

            
            int rowsInserted = insertStmt.executeUpdate();
            if (rowsInserted > 0) {
            	
                System.out.println("Rows inserted: " + rowsInserted);
                request.getRequestDispatcher("/payment.jsp").forward(request, response);
            } else {
            	System.out.println("Ticket is already exists...");
                //request.setAttribute("errorMessage", "Failed to insert booking.");
                request.getRequestDispatcher("/booking.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            try {
                //request.setAttribute("errorMessage", "Booking failed due to a system error.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (checkStmt != null) checkStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (insertStmt != null) insertStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
