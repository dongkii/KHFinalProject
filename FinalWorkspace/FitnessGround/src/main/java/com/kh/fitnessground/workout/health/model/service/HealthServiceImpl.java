package com.kh.fitnessground.workout.health.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.fitnessground.workout.commentlike.vo.Comment;
import com.kh.fitnessground.workout.commentlike.vo.Like;
import com.kh.fitnessground.workout.health.model.dao.HealthDao;
import com.kh.fitnessground.workout.health.model.vo.Health;

@Service("healthService")
public class HealthServiceImpl implements HealthService{
	@Autowired
	HealthDao healthDao;
	
	@Override
	public Health selectOneWorkout(int v_no) {	//완성
		// TODO Auto-generated method stub
		return healthDao.selectOneWorkout(v_no);
	}

	@Override
	public ArrayList<Health> selectWorkoutCategoryList(Health health) {	//완성
		// TODO Auto-generated method stub
		return healthDao.selectWorkoutCategoryList(health);
	}

	@Override
	public void addReadCount(int v_no) {	//완성
		healthDao.addReadCount(v_no);
		
	}		
	
	//댓글 불러오기
	@Override
	public ArrayList<Comment> selectCommentList(int v_no) {
		return healthDao.selectCommentList(v_no);
	}
	//댓글 insert
	@Override
	public void insertComment(Comment comment) {
		healthDao.insertComment(comment);
		
	}
	
	@Override
	public Comment selectComment(int vb_no) {
		// 댓글객체 불러오기..
		return healthDao.selectComment(vb_no);
	}
	
	//댓글 delete
	@Override
	public void deleteComment(Comment comment) {
		healthDao.deleteComment(comment);		
	}

	//좋아요
	@Override
	public int selectLikeCount(int v_no) {
		return healthDao.selectLikeCount(v_no);
		
	}

	@Override
	public ArrayList<Like> selectLikeList() {
		ArrayList<Like> list = healthDao.selectLikeList();
		return list;
	}


	@Override //좋아요 테이블에 있는지 확인
	public int checkLikeTable(Like like) {
		ArrayList<Like> list = healthDao.selectLikeList();	//좋아요 테이블에 들어가 있는 리스트들 불러옴..
		int result=0;
		
		for(int i=0; i<list.size();i++){
			if(like.getV_no()==list.get(i).getV_no() && like.getUser_no()==list.get(i).getUser_no()){
				result=1;
				break;
			}else{
				result=0;
			}
		}
		
		return result;
	}

	@Override
	public Like selectLike(Like like) {
		// 좋아요 객체 불러옴
		return healthDao.selectLike(like);
	}
	
	@Override	
	public void insertLike(Like like) {
		//좋아요 테이블에 넣기(좋아요 증가)
		healthDao.insertLike(like);
	}

	@Override	
	public void deleteLike(Like like) {
		// 좋아요 테이블에서 삭제 (좋아요 취소)
		healthDao.deleteLike(like);
	}

	@Override
	public void deleteMySchedule(Like like) {
		// 마이스케줄 테이블 삭제
		healthDao.deleteMySchedule(like);
	}

	@Override
	public void insertMySchedule(Like like) {
		// 마이스케줄 테이블 삽입
		healthDao.insertMySchedule(like);
		
	}

	@Override 
	public ArrayList<Health> selectHomeTraningList() {
		// 맨몸운동 메인
		return healthDao.selectHomeTraningList();
	}

	@Override
	public int selectVideoCount(String category2) {
		// 맨몸운동 영상별 카운트
		return healthDao.selectVideoCount(category2);
	}

	@Override	//제목으로 검색
	public ArrayList<Health> selectSearchList(String keyWord) {
		// 검색
		return healthDao.selectSearchList(keyWord);
	}

	@Override	//제목으로 검색 카운트
	public int selectSearchVideoCount(String keyWord) {
		// TODO Auto-generated method stub
		return healthDao.selectSearchVideoCount(keyWord);
	}

	@Override
	public ArrayList<Health> selectWorkoutReadCountList(Health health) {
		// TODO Auto-generated method stub
		return healthDao.selectWorkoutReadCountList(health);
	}

	@Override
	public ArrayList<Health> selectWorkoutLikeDesList(Health health) {
		// TODO Auto-generated method stub
		return healthDao.selectWorkoutLikeDesList(health);
	}

	@Override
	public ArrayList<Health> selectLikeCountList(Health health) {
		// TODO Auto-generated method stub
		return healthDao.selectLikeCountList(health);
	}

	@Override
	public ArrayList<Health> selectMainList() {
		// TODO Auto-generated method stub
		return healthDao.selectMainList();
	}
	
		
	
	

	
	
}
