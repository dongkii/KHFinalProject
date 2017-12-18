package com.kh.fitnessground.gym.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.fitnessground.gym.model.dao.GymDao;
import com.kh.fitnessground.gym.model.vo.Gym;
import com.kh.fitnessground.gym.model.vo.GymQnABoard;
import com.kh.fitnessground.gym.model.vo.GymReview;
import com.kh.fitnessground.gym.model.vo.GymSchedule;
import com.kh.fitnessground.gym.model.vo.PublicGym;

@Service("gymService")
public class GymServiceImpl implements GymService{
	@Autowired
	GymDao gymDao;
	
	@Override
	public void RegisterGymImage(Gym gym) {
		gymDao.RegisterGymImage(gym);
	}

	@Override
	public void GymScheduleInsert(int gym_no) {
		gymDao.GymScheduleInsert(gym_no);
	}
	
	@Override
	public int getListCount() {
		return gymDao.getListCount();
	}

	@Override
	public ArrayList<GymReview> selectList(int limit) {
		return gymDao.selectList(limit);
	}

	@Override
	public int enrollReview(GymReview gymreview) {
		return gymDao.enrollReview(gymreview);
	}

	@Override
	public int deleteReview(int gcno) {
		return gymDao.deleteReview(gcno);
	} 

	@Override
	public int updateReview(int gcno, GymReview gymreview) {
		return gymDao.updateReview(gcno,gymreview);
	}

	@Override
	public ArrayList<Gym> healthList(int currentPage, int limit) {
		HashMap<String, Object> parameters = new HashMap<String, Object>();
		int startRow =(currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		parameters.put("startRow", startRow);
		parameters.put("endRow", endRow);
		
		return gymDao.healthList(parameters);
	}
	
	@Override
	public ArrayList<PublicGym> publicList(int currentPage, int limit) {
		HashMap<String, Object> parameters = new HashMap<String, Object>();
		int startRow =(currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		parameters.put("startRow", startRow);
		parameters.put("endRow", endRow);
		
		return gymDao.publicList(parameters);
	}

	@Override
	public int getPublicListCount() {
		// TODO Auto-generated method stub
		return gymDao.getPublicListCount();
	}

	@Override
	public void RegisterGymContent(Gym gym) {
		gymDao.RegisterGymContent(gym);
	}

	@Override
	public Gym selectfromImg(Gym gym) {
		return gymDao.selectfromImg(gym);
	}

	@Override
	public void OneSchedule(GymSchedule gs) {
		gymDao.OneSchedule(gs);
	}

	@Override
	public int regCount(Gym gym) {
		return gymDao.regCount(gym);
	}

	@Override
	public ArrayList<Gym> mygymlist(Gym gym) {
		return gymDao.mygymlist(gym);
	}

	@Override
	public int regCountName(Gym gym) {
		return gymDao.regCountName(gym);
	}

	@Override
	public ArrayList<Gym> mygymlistName(Gym gym) {
		return gymDao.mygymListName(gym);
	}

	@Override
	public void deleteGym(Gym gym) {
		gymDao.deleteGym(gym);
	}

	@Override
	public Gym selectOne(Gym gym) {
		return gymDao.selectOne(gym);
	}

	@Override
	public void insertGymQnABoard(GymQnABoard b, int mode) {
		HashMap<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("board", b);
		parameters.put("mode", mode);
		gymDao.insertGymQnABoard(parameters);
	}

	@Override
	public GymQnABoard selectGymQnABoard(int q_no) {
		return gymDao.selectGymQnABoard(q_no);
	}

	@Override
	public void deleteGymQnABoard(int q_no) {
		gymDao.deleteGymQnABoard(q_no);
	}

	@Override
	public void updateGymQnABoard(GymQnABoard b) {
		gymDao.updateGymQnABoard(b);
	}

	@Override
	public void insertGymQnABoardAnswer(GymQnABoard b) {
		gymDao.insertGymQnaBoardAnswer(b);
	}

	@Override
	public ArrayList<GymSchedule> dbschedule(GymSchedule gs) {
		return gymDao.dbschedule(gs);
	}
}
