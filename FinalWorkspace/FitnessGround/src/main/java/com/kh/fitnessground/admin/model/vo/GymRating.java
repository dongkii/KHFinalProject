package com.kh.fitnessground.admin.model.vo;

import java.sql.Date;

public class GymRating {

	private int gym_no;
	private String gym_name;
	private String location;
	private String email;
	private String name;
	private Date register_date;
	private String category;
	private int gc_no;
	private String content;
	private double rating;
		
	public GymRating(){}

	
	public GymRating(int gym_no, String gym_name, String location, String email, String name, Date register_date,
			String category, int gc_no, String content, double rating) {
		super();
		this.gym_no = gym_no;
		this.gym_name = gym_name;
		this.location = location;
		this.email = email;
		this.name = name;
		this.register_date = register_date;
		this.category = category;
		this.gc_no = gc_no;
		this.content = content;
		this.rating = rating;
	}



	public int getGym_no() {
		return gym_no;
	}

	public void setGym_no(int gym_no) {
		this.gym_no = gym_no;
	}

	public String getGym_name() {
		return gym_name;
	}

	public void setGym_name(String gym_name) {
		this.gym_name = gym_name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getRegister_date() {
		return register_date;
	}

	public void setRegister_date(Date register_date) {
		this.register_date = register_date;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getGc_no() {
		return gc_no;
	}

	public void setGc_no(int gc_no) {
		this.gc_no = gc_no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}


	@Override
	public String toString() {
		return "GymRating [gym_no=" + gym_no + ", gym_name=" + gym_name + ", location=" + location + ", email=" + email
				+ ", name=" + name + ", register_date=" + register_date + ", category=" + category + ", gc_no=" + gc_no
				+ ", content=" + content + ", rating=" + rating + "]";
	}

	
	
	
}
