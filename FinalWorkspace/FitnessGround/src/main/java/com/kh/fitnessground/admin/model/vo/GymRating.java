package com.kh.fitnessground.admin.model.vo;

import java.sql.Date;

public class GymRating {

	private int gym_no;
	private String gym_name;
	private String location;
	private int user_no;
	private int approval_state;
	private String email;
	private String name;
	private int user_level;
	private int user_state;
	private Date register_date;
	private String category;
	private String original_image;
	private String rename_image;
	private String op_time;
	private String tel;
	private String phone;
	private String price;
	private String description;
	private int gc_no;
	private String content;
	private int rating;
		
	public GymRating(){}

	public GymRating(int gym_no, String gym_name, String location, int user_no, int approval_state, String email,
			String name, int user_level, int user_state, Date register_date, String category, String original_image,
			String rename_image, String op_time, String tel, String phone, String price, String description, int gc_no,
			String content, int rating) {
		super();
		this.gym_no = gym_no;
		this.gym_name = gym_name;
		this.location = location;
		this.user_no = user_no;
		this.approval_state = approval_state;
		this.email = email;
		this.name = name;
		this.user_level = user_level;
		this.user_state = user_state;
		this.register_date = register_date;
		this.category = category;
		this.original_image = original_image;
		this.rename_image = rename_image;
		this.op_time = op_time;
		this.tel = tel;
		this.phone = phone;
		this.price = price;
		this.description = description;
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

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public int getApproval_state() {
		return approval_state;
	}

	public void setApproval_state(int approval_state) {
		this.approval_state = approval_state;
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

	public int getUser_level() {
		return user_level;
	}

	public void setUser_level(int user_level) {
		this.user_level = user_level;
	}

	public int getUser_state() {
		return user_state;
	}

	public void setUser_state(int user_state) {
		this.user_state = user_state;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	@Override
	public String toString() {
		return "GymRating [gym_no=" + gym_no + ", gym_name=" + gym_name + ", location=" + location + ", user_no="
				+ user_no + ", approval_state=" + approval_state + ", email=" + email + ", name=" + name
				+ ", user_level=" + user_level + ", user_state=" + user_state + ", register_date=" + register_date
				+ ", category=" + category + ", original_image=" + original_image + ", rename_image=" + rename_image
				+ ", op_time=" + op_time + ", tel=" + tel + ", phone=" + phone + ", price=" + price + ", description="
				+ description + ", gc_no=" + gc_no + ", content=" + content + ", rating=" + rating + "]";
	}
	
	
	
	
}
