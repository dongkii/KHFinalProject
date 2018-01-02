package com.kh.fitnessground.admin.model.vo;

public class GymChart {
	
	private String category1;
	private int count;
	
	public GymChart(){}

	public GymChart(String category1, int count) {
		super();
		this.category1 = category1;
		this.count = count;
	}

	public String getCategory() {
		return category1;
	}

	public void setCategory(String category1) {
		this.category1 = category1;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "GymChart [category1=" + category1 + ", count=" + count + "]";
	}
	
	

}
