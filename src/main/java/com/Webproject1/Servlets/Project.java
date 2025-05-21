package com.Webproject1.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import com.Webproject.Models.Information;
import com.Webproject.Models.Logininfo;
import com.Webproject1.connection.Getconnection;
import com.sun.net.httpserver.Request;
/**
 * Servlet implementation class Project
 */
//@WebServlet("/Project")
public class Project extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Project() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");
		String password = request.getParameter("pass");
		String confirm = request.getParameter("cpass");
		System.out.println("Conditions : " + password.equals(confirm));
		if(password.equals(confirm)) {
//			System.out.println("Name: "+name);
//			System.out.println("Mobile number: "+mobile);
//			System.out.println("email: "+email);
			System.out.println("Registration success!Welcome to Retro Movies...");
			request.setAttribute("name",name);
			request.setAttribute("mobile",mobile);
			request.setAttribute("email",email);
			request.setAttribute("password",password);
			request.setAttribute("confirm",confirm);
			Information info = new Information(name,mobile,email,password,confirm);
			insertintoDatabase(info, request, response);
			RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
			rd.forward(request, response);
		
		}else {
			System.out.println("Please check your password....");
			RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
			rd.forward(request, response);
			}
		
		}
		public static void insertintoDatabase(Information info,HttpServletRequest request, HttpServletResponse response) {
			Connection con = null;
			Getconnection gc = new Getconnection();
			Statement stmt = null;
			
			//String Remail = request.getParameter("email");
			String Password = info.getPassword();
			String confirm = info.getConfirm();
			String insert = "insert into Registerdatails values('"+info.getId()+"','"+info.getName()+"','"+info.getMobile()+"','"+info.getEmail()+"','"+info.getPassword()+"','"+info.getConfirm()+"');";
			System.out.println("SQL Query: " + insert);
			try {
				System.out.println("Reached insert into database");
				con = gc.getConnection();
				stmt =con.createStatement();
				if(Password.equals(confirm)) {
					int i =stmt.executeUpdate(insert);
					System.out.println("No of rows inserted: "+i);
				}
//					else if (Remail.matches(info.getEmail())) {
//					
//				}
				else {
					System.out.println("Password is different from confirm password!");
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		
	}
}
