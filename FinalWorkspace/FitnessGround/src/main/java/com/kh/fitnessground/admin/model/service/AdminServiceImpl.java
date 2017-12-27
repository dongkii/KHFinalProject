package com.kh.fitnessground.admin.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.fitnessground.admin.model.dao.AdminDao;
import com.kh.fitnessground.admin.model.vo.Visit;
import com.kh.fitnessground.community.model.vo.CommunityBoard;
import com.kh.fitnessground.community.model.vo.MeetingBoard;
import com.kh.fitnessground.gym.model.vo.GymQnABoard;
import com.kh.fitnessground.user.model.dao.UserDao;
import com.kh.fitnessground.user.model.vo.User;
import com.kh.fitnessground.workout.commentlike.vo.Like;
import com.kh.fitnessground.workout.health.model.vo.Health;

@Service("adminService")
public class AdminServiceImpl  implements AdminService{

	@Autowired
	private AdminDao adminDao;



	@Override
	public ArrayList<User> userlist(int level) {
		// TODO Auto-generated method stub
		return adminDao.userlist(level);
	}


	@Override
	public ArrayList<User> businesslist(int level) {
		// TODO Auto-generated method stub
		return adminDao.businesslist(level);
	}


	@Override
	public ArrayList<User> businessRequestlist(int level) {
		// TODO Auto-generated method stub
		return adminDao.businessRequestlist(level);
	}


	@Override
	public void adminGymRequest(int gym_no) {
		adminDao.adminGymRequest(gym_no);
		
	}


	@Override
	public void adminGymCancel(int gym_no) {
		adminDao.adminGymCancel(gym_no);
		
	}


	@Override
	public void meetingBoardDelete(int mb_no) {
		adminDao.meetingBoardDelete(mb_no);
		
	}


	@Override
	public void qnaBoardDelete(int cb_no) {
		adminDao.qnaBoardDelete(cb_no);
		
	}


	@Override
	public void reviewBoardDelete(int cb_no) {
		adminDao.reviewBoardDelete(cb_no);
		
	}


	@Override
	public void adminUserStateChange(int user_no) {
		adminDao.userStateChange(user_no);
		
	}


	@Override
	public void adminUserStateBack(int user_no) {
		adminDao.userStateBack(user_no);
		
	}


	@Override
	public int RequestCount(int level) {
		return adminDao.RequestCount(level);
	}


	@Override
	public void adminBusinessStateChange(int user_no) {
		adminDao.businessStateChange(user_no);
		
	}


	@Override
	public void adminBusinessStateBack(int user_no) {
		adminDao.businessStateBack(user_no);
		
	}


	@Override
	public int Message(int receiver) {
		return adminDao.Message(receiver);
	}


	@Override
	public ArrayList<User> GymRequest(int level) {
		return adminDao.GymRequest(level);
	}


	@Override
	public ArrayList<GymQnABoard> adminBoard() {
		return adminDao.adminBoard();
	}


	@Override
	public ArrayList<GymQnABoard> GymQnABoard(int receiver) {
		return adminDao.GymQnABoard(receiver);
	}


	@Override
	public int meetingBoardInsert(MeetingBoard mboard) {
		return adminDao.meetingBoardInsert(mboard);
		
	}


	@Override
	public int qnaBoardInsert(CommunityBoard cboard) {
		return adminDao.qnaBoardInsert(cboard);
	}


	@Override
	public int reviewBoardInsert(CommunityBoard cboard) {
		return adminDao.reviewBoardInsert(cboard);
	}


	@Override
	public ArrayList<MeetingBoard> meetingListView() {
		return adminDao.meetingBoardList();
	}


	@Override
	public ArrayList<CommunityBoard> qnaListView() {
		return adminDao.qnaBoardList();
	}


	@Override
	public ArrayList<CommunityBoard> reviewListView() {
		return adminDao.reviewBoardList();
	}


	@Override
	public int qnaResponse(GymQnABoard gqboard) {
		return adminDao.qnaResponse(gqboard);
	}


	@Override
	public Object qnaBoardUpdate(int responseQ_no) {
		return adminDao.qnaBoardUpdate(responseQ_no);
		
	}


	@Override
	public ArrayList<Health> HealthList() {
		return adminDao.HealthList();
	}


	@Override
	public int visitCount() {
		return adminDao.visitCount();
		
	}


	@Override
	public int getTotalCount(Visit visit) {
		return adminDao.getTotalCount(visit);
	}


	@Override
	public int getTodayCount(Visit visit) {
		return adminDao.getTodayCount(visit);
	}


	@Override
	public User userDetail(User u) {
		return adminDao.userDetail(u);
	}


	@Override
	public Like likeDetail(Like l) {
		return adminDao.likeDetail(l);
	}


	@Override
	public int totalUser(int level) {
		return adminDao.totalUser(level);
	}


	@Override
	public int totalbusiness(int receiver) {
		return adminDao.totalBusiness(receiver);
	}


	@Override
	public int gymCount(int receiver) {
		return adminDao.gymCount(receiver);
	}


	@Override
	public int boardCount() {
		return adminDao.boardCount();
	}


	@Override
	public int qnaCount() {
		return adminDao.qnaCount();
	}


	@Override
	public int reviewCount() {
		return adminDao.reviewCount();
	}






	
}
