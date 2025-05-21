package com.Webproject.Models;

public class Bookinginfo {
	private int id;
	private String name;
	private String eventId;
	private String seatCount;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEventId() {
		return eventId;
	}
	public void setEventId(String eventId) {
		this.eventId = eventId;
	}
	public String getSeatCount() {
		return seatCount;
	}
	public void setSeatCount(String seatCount) {
		this.seatCount = seatCount;
	}
	public Bookinginfo(String name, String eventId, String seatCount) {
		super();
	    this.name = name;
	    this.eventId = eventId;
	    this.seatCount = seatCount;
	}

	
	
	
}
