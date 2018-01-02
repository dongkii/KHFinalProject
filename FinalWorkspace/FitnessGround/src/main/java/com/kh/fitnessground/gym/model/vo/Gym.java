package com.kh.fitnessground.gym.model.vo;

import java.sql.Date;

public class Gym {
	private int gym_no;
	private String gym_name;
	private String original_image;
	private String rename_image;
	private String op_time;
	private String tel;
	private String phone;
	private String price;
	private String category;
	private String description;
	private String location;
	private int user_no;
	private Date delete_date;
	private int approval_state;
	private Date register_date;
	private String str_rating;
	private double lat;
	private double lng;
	
	public Gym() {
		super();
	}

	public Gym(int gym_no, String gym_name, String original_image, String rename_image, String op_time, String tel,
			String phone, String price, String category, String description, String location, int user_no,
			Date delete_date, int approval_state, Date register_date, double lat, double lng) {
		super();
		this.gym_no = gym_no;
		this.gym_name = gym_name;
		this.original_image = original_image;
		this.rename_image = rename_image;
		this.op_time = op_time;
		this.tel = tel;
		this.phone = phone;
		this.price = price;
		this.category = category;
		this.description = description;
		this.location = location;
		this.user_no = user_no;
		this.delete_date = delete_date;
		this.approval_state = approval_state;
		this.register_date = register_date;
		this.lat = lat;
		this.lng = lng;
	}

	public Gym(int gym_no, String gym_name, String original_image, String rename_image, String op_time, String tel,
			String phone, String price, String category, String description, String location, int user_no,
			Date delete_date, int approval_state, Date register_date, String str_rating) {
		super();
		this.gym_no = gym_no;
		this.gym_name = gym_name;
		this.original_image = original_image;
		this.rename_image = rename_image;
		this.op_time = op_time;
		this.tel = tel;
		this.phone = phone;
		this.price = price;
		this.category = category;
		this.description = description;
		this.location = location;
		this.user_no = user_no;
		this.delete_date = delete_date;
		this.approval_state = approval_state;
		this.register_date = register_date;
		this.str_rating = str_rating;
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

	public String getOriginal_image() {
		return original_image;
	}

	public void setOriginal_image(String original_image) {
		this.original_image = original_image;
	}

	public String getRename_image() {
		return rename_image;
	}

	public void setRename_image(String rename_image) {
		this.rename_image = rename_image;
	}

	public String getOp_time() {
		return op_time;
	}

	public void setOp_time(String op_time) {
		this.op_time = op_time;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public Date getDelete_date() {
		return delete_date;
	}

	public void setDelete_date(Date delete_date) {
		this.delete_date = delete_date;
	}

	public int getApproval_state() {
		return approval_state;
	}

	public void setApproval_state(int approval_state) {
		this.approval_state = approval_state;
	}

		
	public Date getRegister_date() {
		return register_date;
	}

	public void setRegister_date(Date register_date) {
		this.register_date = register_date;
	}

	public String getStr_rating() {
		return str_rating;
	}

	public void setStr_rating(String str_rating) {
		this.str_rating = str_rating;
	}

	public double getLat()
	{
		return this.lat;
	}
	
	public void setLat(double lat)
	{
		this.lat = lat;
	}
	
	public double getLng()
	{
		return this.lng;
	}
	
	public void setLng(double lng)
	{
		this.lng = lng;
	}	
	
	@Override
	public String toString() {
		return "Gym [gym_no=" + gym_no + ", gym_name=" + gym_name + ", original_image=" + original_image
				+ ", rename_image=" + rename_image + ", op_time=" + op_time + ", tel=" + tel + ", phone=" + phone
				+ ", price=" + price + ", category=" + category + ", description=" + description + ", location="
				+ location + ", user_no=" + user_no + ", delete_date=" + delete_date + ", approval_state="
				+ approval_state + ", register_date=" + register_date + ", str_rating=" + str_rating + "]";
	}
}
