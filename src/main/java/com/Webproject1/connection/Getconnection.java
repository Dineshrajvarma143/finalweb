package com.Webproject1.connection;
import java.sql.Connection;
import java.sql.DriverManager;

public class Getconnection {
	public Connection getConnection() {
		String url = "jdbc:mysql://localhost:3306/DRV";
		String username = "root";
		String password = "9494136336";
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Loaded and registered the Driver");
			con = DriverManager.getConnection(url,username,password);
			System.out.println("Connection Established");
			return con;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	}

}