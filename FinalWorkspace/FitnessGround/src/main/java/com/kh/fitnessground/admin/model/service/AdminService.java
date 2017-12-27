package com.kh.fitnessground.admin.model.service;

import java.util.ArrayList;

import com.kh.fitnessground.admin.model.vo.Visit;
import com.kh.fitnessground.community.model.vo.CommunityBoard;
import com.kh.fitnessground.community.model.vo.MeetingBoard;
import com.kh.fitnessground.gym.model.vo.GymQnABoard;
import com.kh.fitnessground.user.model.vo.User;
import com.kh.fitnessground.workout.commentlike.vo.Like;
import com.kh.fitnessground.workout.health.model.vo.Health;

public interface AdminService {

	


    ArrayList<User> businesslist(int level);


	ArrayList<User> userlist(int level);


	ArrayList<User> businessRequestlist(int level);


	void adminGymRequest(int gym_no);


	void adminGymCancel(int gym_no);


	void meetingBoardDelete(int mb_no);


	void qnaBoardDelete(int cb_no);


	void reviewBoardDelete(int cb_no);


	void adminUserStateChange(int user_no);


	void adminUserStateBack(int user_no);


	int RequestCount(int level);


	void adminBusinessStateChange(int user_no);


	void adminBusinessStateBack(int user_no);


	int Message(int receiver);


	ArrayList<User> GymRequest(int level);


	ArrayList<GymQnABoard> adminBoard();

	ArrayList<GymQnABoard> GymQnABoard(int receiver);


	int meetingBoardInsert(MeetingBoard mboard);


	int qnaBoardInsert(CommunityBoard cboard);


	int reviewBoardInsert(CommunityBoard cboard);


	ArrayList<MeetingBoard> meetingListView();


	ArrayList<CommunityBoard> qnaListView();


	ArrayList<CommunityBoard> reviewListView();


	int qnaResponse(GymQnABoard gqboard);


	Object qnaBoardUpdate(int responseQ_no);


	ArrayList<Health> HealthList();

	int visitCount();


	int getTotalCount(Visit visit);

	int getTodayCount(Visit visit);


	User userDetail(User u);


	Like likeDetail(Like l);


	int totalUser(int level);


	int totalbusiness(int receiver);


	int gymCount(int receiver);


	int boardCount();


	int qnaCount();


	int reviewCount();








}
