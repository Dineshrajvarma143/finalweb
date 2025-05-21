package com.Webproject.Models;

public class change{
//	private String oldmovie
	private String newposter;
	private String newmovie;
	public String getNewposter() {
		return newposter;
	}
	public void setNewposter(String newposter) {
		this.newposter = newposter;
	}
	public String getNewmovie() {
		return newmovie;
	}
	public void setNewmovie(String newmovie) {
		this.newmovie = newmovie;
	}
	public change(String newposter, String newmovie) {
		super();
		this.newposter = newposter;
		this.newmovie = newmovie;
	}
	
}