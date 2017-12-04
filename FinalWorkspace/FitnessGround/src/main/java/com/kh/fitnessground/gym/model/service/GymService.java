package com.kh.fitnessground.gym.model.service;

import java.util.ArrayList;

import com.kh.fitnessground.gym.model.vo.Gym;
import com.kh.fitnessground.gym.model.vo.GymReview;

public interface GymService {
		//헬스장 등록
		boolean RegisterGym(Gym gym);
		// 헬스장 스케줄 등록
		void GymScheduleInsert(int gym_no);
		
		// 게시글 개수
		int getListCount();
		// 목록 가져오기
		ArrayList<GymReview> selectList(int limit);
		//등록
		int enrollReview(GymReview gymreview);
		//삭제
		int deleteReview(int gcno);
			//수정
		int updateReview(int gcno, GymReview gymreview);

}