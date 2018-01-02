package com.kh.fitnessground.admin.model.vo;

public class VideoChart {

	
	private String Category1;
	private int readcount;
	
	public VideoChart(){}

	public VideoChart(String category1, int readcount) {
		super();
		Category1 = category1;
		this.readcount = readcount;
	}

	public String getCategory1() {
		return Category1;
	}

	public void setCategory1(String category1) {
		Category1 = category1;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	@Override
	public String toString() {
		return "VideoChart [Category1=" + Category1 + ", readcount=" + readcount + "]";
	}
	
	
}
