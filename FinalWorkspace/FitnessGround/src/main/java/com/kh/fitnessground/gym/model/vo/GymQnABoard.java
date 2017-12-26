package com.kh.fitnessground.gym.model.vo;

import java.sql.Date;

public class GymQnABoard {
	private int q_no;
	private String sender;
	private String receiver;
	private String title;
	private String content;
	private String original_filename;
	private String rename_filename;
	private Date write_date;
	private int q_level;
	private int ref_no;
	private int response_state;
	private String email;
	private String name;
	private int user_no;
	private String gym_name;
	private String stringWrite_date;
	
	public GymQnABoard() {
		super();
	}

	public GymQnABoard(int q_no, String sender, String receiver, String title, String content, String original_filename,
			String rename_filename, Date write_date, int q_level, int ref_no, int response_state, String email,
			String name, int user_no, String gym_name, String stringWrite_date) {
		super();
		this.q_no = q_no;
		this.sender = sender;
		this.receiver = receiver;
		this.title = title;
		this.content = content;
		this.original_filename = original_filename;
		this.rename_filename = rename_filename;
		this.write_date = write_date;
		this.q_level = q_level;
		this.ref_no = ref_no;
		this.response_state = response_state;
		this.email = email;
		this.name = name;
		this.user_no = user_no;
		this.gym_name = gym_name;
		this.stringWrite_date = stringWrite_date;
	}

	
	public String getStringWrite_date() {
		return stringWrite_date;
	}

	public void setStringWrite_date(String stringWrite_date) {
		this.stringWrite_date = stringWrite_date;
	}

	public int getQ_no() {
		return q_no;
	}

	public void setQ_no(int q_no) {
		this.q_no = q_no;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getOriginal_filename() {
		return original_filename;
	}

	public void setOriginal_filename(String original_filename) {
		this.original_filename = original_filename;
	}

	public String getRename_filename() {
		return rename_filename;
	}

	public void setRename_filename(String rename_filename) {
		this.rename_filename = rename_filename;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	public int getQ_level() {
		return q_level;
	}

	public void setQ_level(int q_level) {
		this.q_level = q_level;
	}

	public int getRef_no() {
		return ref_no;
	}

	public void setRef_no(int ref_no) {
		this.ref_no = ref_no;
	}

	public int getResponse_state() {
		return response_state;
	}

	public void setResponse_state(int response_state) {
		this.response_state = response_state;
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

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getGym_name() {
		return gym_name;
	}

	public void setGym_name(String gym_name) {
		this.gym_name = gym_name;
	}

	@Override
	public String toString() {
		return "GymQnABoard [q_no=" + q_no + ", sender=" + sender + ", receiver=" + receiver + ", title=" + title
				+ ", content=" + content + ", original_filename=" + original_filename + ", rename_filename="
				+ rename_filename + ", write_date=" + write_date + ", q_level=" + q_level + ", ref_no=" + ref_no
				+ ", response_state=" + response_state + ", email=" + email + ", name=" + name + ", user_no=" + user_no
				+ ", gym_name=" + gym_name + "]";
	}
	
	
	
}