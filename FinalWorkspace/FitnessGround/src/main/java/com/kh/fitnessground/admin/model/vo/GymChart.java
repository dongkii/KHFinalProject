package com.kh.fitnessground.admin.model.vo;

public class GymChart {
	
	private String category;
	private int count;
	
	public GymChart(){}

	public GymChart(String category, int count) {
		super();
		this.category = category;
		this.count = count;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "GymChart [category=" + category + ", count=" + count + "]";
	}
	
	

}
