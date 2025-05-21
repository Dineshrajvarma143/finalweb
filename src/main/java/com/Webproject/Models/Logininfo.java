package com.Webproject.Models;

public class Logininfo {
	private int id;
	

	private String lemail;
	private String password;
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLemail() {
		return lemail;
	}

	public void setLemail(String lemail) {
		this.lemail = lemail;
	}

	public Logininfo(String lemail, String password) {
		super();
		this.lemail = lemail;
		this.password=password;
		
	}

	public Logininfo(int id) {
		super();
		this.id = id;
	}
}
