package com.kh.fitnessground.gym.model.vo;

public class PublicGym implements java.io.Serializable{
	private String public_name;
	private String category;
	private String category_public;
	private String location;
	private double lng;
	private double lat;
	private String tel;
	private String homepage;
	private String op_time;
	private String end_time;
	private String image;
	
	public PublicGym(){}

	public PublicGym(String public_name, String category, String category_public, String location, double lng, double lat,
			String tel, String homepage, String op_time, String end_time, String image) {
		super();
		this.public_name = public_name;
		this.category = category;
		this.category_public = category_public;
		this.location = location;
		this.lng = lng;
		this.lat = lat;
		this.tel = tel;
		this.homepage = homepage;
		this.op_time = op_time;
		this.end_time = end_time;
		this.image = image;
	}

	
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getPublic_name() {
		return public_name;
	}

	public void setPublic_name(String public_name) {
		this.public_name = public_name;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getCategory_public() {
		return category_public;
	}

	public void setCategory_public(String category_public) {
		this.category_public = category_public;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getHomepage() {
		return homepage;
	}

	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}

	public String getOp_time() {
		return op_time;
	}

	public void setOp_time(String op_time) {
		this.op_time = op_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}	
	
	@Override
	public String toString() {
		return this.public_name + ", " + this.location + ", " + this.image;
	}
}
