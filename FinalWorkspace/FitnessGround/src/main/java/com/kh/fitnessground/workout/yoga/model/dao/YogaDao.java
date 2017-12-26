package com.kh.fitnessground.workout.yoga.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.fitnessground.workout.yoga.model.vo.Yoga;

@Repository("yogaDao")
public class YogaDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ArrayList<Yoga> selectAllYList() {
		List<Yoga> ylist = sqlSession.selectList("yoga.selectAllYList");
		ArrayList<Yoga> list = new ArrayList<Yoga>(ylist);
		return list;
	}
	
	public ArrayList<Yoga> selectAllPList() {
		List<Yoga> ylist = sqlSession.selectList("yoga.selectAllPList");
		ArrayList<Yoga> list = new ArrayList<Yoga>(ylist);
		return list;
	}

	public ArrayList<Yoga> selectCList(Yoga yoga) {
		List<Yoga> ylist = sqlSession.selectList("yoga.selectCList", yoga);
		return new ArrayList<Yoga>(ylist);
	}

	public Yoga selectYoga(int no) {
		return (Yoga)sqlSession.selectOne("yoga.selectYoga", no);
	}
	public void insertYoga(List<Yoga> ylist) {
		for(Yoga yoga : ylist) {
			sqlSession.insert("yoga.insertYoga", yoga);
		}
	}

	public void updateYoga(Yoga yoga) {
		sqlSession.update("yoga.updateYoga", yoga);
	}

	public void deleteYoga(Yoga yoga) {
		sqlSession.delete("yoga.deleteYoga", yoga);
	}

	public void deleteYogaList(List<Integer> dellist) {
		for(int i=0;i<dellist.size();i++) {
			System.out.println(dellist.get(i));
			sqlSession.delete("yoga.deleteYoga", dellist.get(i));
		}
	}

	public void addReadCount(int v_no) {
		sqlSession.update("yoga.addReadCount", v_no);
	}

	public ArrayList<Yoga> selectAllList() {
		List<Yoga> ylist = sqlSession.selectList("yoga.selectAllList");
		ArrayList<Yoga> list = new ArrayList<Yoga>(ylist);
		return list;
	}

	public ArrayList<Yoga> selectWList(Yoga yoga) {
		List<Yoga> ylist = sqlSession.selectList("yoga.selectWList", yoga);
		return new ArrayList<Yoga>(ylist);
	}

	public Yoga updateViewYoga(Yoga yoga) {
		Yoga y = sqlSession.selectOne("yoga.selectOne", yoga);
		return y;
	}

	public int selectVideoCount(String category2) {
		return sqlSession.selectOne("yoga.selectVideoCount",category2);
	}

	public ArrayList<Yoga> selectSearchList(HashMap<String,String> parameters) {
		return (ArrayList)sqlSession.selectList("yoga.selectSearchList",parameters);
	}

	public int selectSearchVideoCount(HashMap<String,String> parameters) {
		return sqlSession.selectOne("yoga.selectSearchVideoCount",parameters);
	}

	public ArrayList<Yoga> selectWorkoutReadCountList(Yoga yoga) {
		return (ArrayList)sqlSession.selectList("yoga.selectWorkoutReadCountList",yoga);
	}

	public ArrayList<Yoga> selectLikeCountList(Yoga yoga) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("yoga.selectLikeCountlist",yoga);
	}

}
