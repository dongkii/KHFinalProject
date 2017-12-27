package com.kh.fitnessground.gym.model.vo;

public class GymComment {
	private int gc_no;
	private int gym_no;
	private String content;
	private int rating;
	private int user_no;
	
	public GymComment() {
		super();
	}

	public GymComment(int gc_no, int gym_no, String content, int rating, int user_no) {
		super();
		this.gc_no = gc_no;
		this.gym_no = gym_no;
		this.content = content;
		this.rating = rating;
		this.user_no = user_no;
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

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	@Override
	public String toString() {
		return "GymComment [gc_no=" + gc_no + ", gym_no=" + gym_no + ", content=" + content + ", rating=" + rating
				+ ", user_no=" + user_no + "]";
	}
	
	
}
