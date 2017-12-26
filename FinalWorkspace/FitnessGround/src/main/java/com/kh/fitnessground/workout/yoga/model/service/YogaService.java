package com.kh.fitnessground.workout.yoga.model.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.kh.fitnessground.workout.yoga.model.vo.Yoga;

public interface YogaService {
	
	ArrayList<Yoga> selectAllYList();
	ArrayList<Yoga> selectAllPList();
	ArrayList<Yoga> selectCList(Yoga yoga);
	Yoga selectYoga(int no);
	Yoga updateViewYoga(Yoga yoga, HttpServletRequest request);
	void insertYoga(List<Yoga> ylist, HttpServletRequest request);
	void updateYoga(Yoga yoga, HttpServletRequest request);
	void deleteYoga(Yoga yoga, HttpServletRequest request);
	void deleteYogaList(List<Integer> dellist, HttpServletRequest request);
	void addReadCount(int v_no, HttpServletRequest request);
	ArrayList<Yoga> selectAllList();
	ArrayList<Yoga> selectWList(Yoga yoga);
	int selectVideoCount(String string);
	
	int selectSearchVideoCount(String keyWord,String category1);
	ArrayList<Yoga> selectSearchList(String keyWord, String category1);
	ArrayList<Yoga> selectWorkoutReadCountList(Yoga yoga);
	ArrayList<Yoga> selectLikeCountList(Yoga yoga);
	
	
	
}
