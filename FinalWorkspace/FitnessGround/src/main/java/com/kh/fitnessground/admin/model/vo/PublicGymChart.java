package com.kh.fitnessground.admin.model.vo;

public class PublicGymChart {
	
	
	private String location;
	private int public_count;
	
	public PublicGymChart(){}

	public PublicGymChart(String location, int public_count) {
		super();
		this.location = location;
		this.public_count = public_count;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getPublic_count() {
		return public_count;
	}

	public void setPublic_count(int public_count) {
		this.public_count = public_count;
	}

	@Override
	public String toString() {
		return "PublicGymList [location=" + location + ", public_count=" + public_count + "]";
	}
	
	

}
