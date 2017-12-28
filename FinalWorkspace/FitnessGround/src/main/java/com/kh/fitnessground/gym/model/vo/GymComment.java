package com.kh.fitnessground.gym.model.vo;

import java.sql.Date;

public class GymComment {
	private int gc_no;
	private int gym_no;
	private String content;
	private double rating;
	private int user_no;
	private Date upload_date;
	private String nickname;
	private String str_date;
	private String str_rating;
	
	public GymComment() {
		super();
	}

	public GymComment(int gc_no, int gym_no, String content, double rating, int user_no, Date upload_date,
			String nickname, String str_date, String str_rating) {
		super();
		this.gc_no = gc_no;
		this.gym_no = gym_no;
		this.content = content;
		this.rating = rating;
		this.user_no = user_no;
		this.upload_date = upload_date;
		this.nickname = nickname;
		this.str_date = str_date;
		this.str_rating = str_rating;
	}

	public int getGc_no() {
		return gc_no;
	}

	public void setGc_no(int gc_no) {
		this.gc_no = gc_no;
	}

	public int getGym_no() {
		return gym_no;
	}

	public void setGym_no(int gym_no) {
		this.gym_no = gym_no;
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

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public Date getUpload_date() {
		return upload_date;
	}

	public void setUpload_date(Date upload_date) {
		this.upload_date = upload_date;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getStr_date() {
		return str_date;
	}

	public void setStr_date(String str_date) {
		this.str_date = str_date;
	}

	public String getStr_rating() {
		return str_rating;
	}

	public void setStr_rating(String str_rating) {
		this.str_rating = str_rating;
	}

	@Override
	public String toString() {
		return "GymComment [gc_no=" + gc_no + ", gym_no=" + gym_no + ", content=" + content + ", rating=" + rating
				+ ", user_no=" + user_no + ", upload_date=" + upload_date + ", nickname=" + nickname + ", str_date="
				+ str_date + ", str_rating=" + str_rating + "]";
	}
}
