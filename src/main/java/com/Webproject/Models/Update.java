package com.Webproject.Models;

public class Update {
	private String imageurl;
	private String moviename;
	public String getImageurl() {
		return imageurl;
	}
	public void setImageurl(String imageurl) {
		this.imageurl = imageurl;
	}
	public String getMoviename() {
		return moviename;
	}
	public void setMoviename(String moviename) {
		this.moviename = moviename;
	}
	public Update(String imageurl, String moviename) {
		super();
		this.imageurl = imageurl;
		this.moviename = moviename;
	}
	
}


