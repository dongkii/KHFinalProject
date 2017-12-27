package com.kh.fitnessground.gym.model.service;

import java.util.ArrayList;

import com.kh.fitnessground.gym.model.vo.Gym;
import com.kh.fitnessground.gym.model.vo.GymComment;
import com.kh.fitnessground.gym.model.vo.GymQnABoard;
import com.kh.fitnessground.gym.model.vo.GymSchedule;
import com.kh.fitnessground.gym.model.vo.NaverMap;
import com.kh.fitnessground.gym.model.vo.PublicGym;

public interface GymService {
		//헬스장 이미지 등록
		void RegisterGymImage(Gym gym);
		// 헬스장 스케줄 등록
		void GymScheduleInsert(int gym_no);
		
		// 게시글 개수
		int getListCount();
		
		// 헬스장 목록 가져오기
		ArrayList<Gym> healthList(int currentPage, int limit);
	//	ArrayList<Gym> healthList();
		
		int getPublicListCount();
		
		ArrayList<PublicGym> publicList(int currentPage, int limit);
		
		void RegisterGymContent(Gym gym);
		
		Gym selectfromImg(Gym gym);
		
		void OneSchedule(GymSchedule gs);
		
		int regCount(Gym gym);
		
		ArrayList<Gym> mygymlist(Gym gym);
		
		int regCountName(Gym gym);
		
		ArrayList<Gym> mygymlistName(Gym gym);
		
		void deleteGym(Gym gym);
		
		Gym selectOne(Gym gym);
		
		void insertGymQnABoard(GymQnABoard b, int mode);
		
		GymQnABoard selectGymQnABoard(int q_no);
		
		void deleteGymQnABoard(int q_no);
	
		
		void updateGymQnABoard(GymQnABoard b);
		
		void insertGymQnABoardAnswer(GymQnABoard b);
		
		ArrayList<GymSchedule> dbschedule(GymSchedule gs);

		void updateGymQnABoardResponse(int ref_no, int responseSt);
		
		void updatecontent(Gym gym);
		
		void updateLocation(Gym gym);
		
		void updategymimg(Gym gym);
		ArrayList<PublicGym> publicMaplist(NaverMap nmap);
		
		void InserReview(GymComment gc);
}
