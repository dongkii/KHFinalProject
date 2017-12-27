package com.kh.fitnessground.community.model.vo;

import java.sql.Date;

public class MeetingBoard {

	private int mb_no; // 운동모임 게시글 번호
	private int user_no; // 작성자
	private String name; // 작성자명
	private String title; // 게시글 제목
	private String content; // 게시글 내용
	private String meeting_location; //모임장소
	private Date meeting_date; // 모임날짜
	private Date upload_date; // 작성일자
	private int readcount; // 조회수
	private String email;
	
	public MeetingBoard() {
		super();
	}

	public MeetingBoard(int mb_no, int user_no, String name, String title, String content, String meeting_location,
			Date meeting_date, Date upload_date, int readcount, String email) {
		super();
		this.mb_no = mb_no;
		this.user_no = user_no;
		this.name = name;
		this.title = title;
		this.content = content;
		this.meeting_location = meeting_location;
		this.meeting_date = meeting_date;
		this.upload_date = upload_date;
		this.readcount = readcount;
		this.email = email;
	}

	public int getMb_no() {
		return mb_no;
	}

	public void setMb_no(int mb_no) {
		this.mb_no = mb_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getMeeting_location() {
		return meeting_location;
	}

	public void setMeeting_location(String meeting_location) {
		this.meeting_location = meeting_location;
	}

	public Date getMeeting_date() {
		return meeting_date;
	}

	public void setMeeting_date(Date meeting_date) {
		this.meeting_date = meeting_date;
	}

	public Date getUpload_date() {
		return upload_date;
	}

	public void setUpload_date(Date upload_date) {
		this.upload_date = upload_date;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "MeetingBoard [mb_no=" + mb_no + ", user_no=" + user_no + ", name=" + name + ", title=" + title
				+ ", content=" + content + ", meeting_location=" + meeting_location + ", meeting_date=" + meeting_date
				+ ", upload_date=" + upload_date + ", readcount=" + readcount + ", email=" + email + "]";
	}


}
