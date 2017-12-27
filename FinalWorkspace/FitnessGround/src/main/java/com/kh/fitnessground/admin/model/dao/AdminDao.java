package com.kh.fitnessground.admin.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.fitnessground.admin.model.vo.Visit;
import com.kh.fitnessground.community.model.vo.CommunityBoard;
import com.kh.fitnessground.community.model.vo.MeetingBoard;
import com.kh.fitnessground.gym.model.vo.GymQnABoard;
import com.kh.fitnessground.user.model.vo.User;
import com.kh.fitnessground.workout.commentlike.vo.Like;
import com.kh.fitnessground.workout.health.model.vo.Health;
import com.kh.fitnessground.workout.yoga.model.vo.Yoga;

@Repository("adminDao")
public class AdminDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public AdminDao(){}
	
	public ArrayList<User> userlist(int level){
		List<User> ulist = sqlSession.selectList("user.userList", level);
		ArrayList<User> list = new ArrayList<User>(ulist);
		return list;
	};
	


	public ArrayList<User> businesslist(int level) {
		List<User> blist = sqlSession.selectList("user.businessList", level);
		ArrayList<User> list = new ArrayList<User>(blist);
		return list;
	}

	public ArrayList<User> businessRequestlist(int level) {
		List<User> brlist = sqlSession.selectList("gym.businessRequest", level);
		ArrayList<User> list = new ArrayList<User>(brlist);
		return list;
	}

	public void adminGymRequest(int gym_no) {
		sqlSession.update("gym.gymRequest", gym_no);
	}

	public void adminGymCancel(int gym_no) {
		sqlSession.update("gym.gymCancel", gym_no);
		
	}

	public void meetingBoardDelete(int mb_no) {
		sqlSession.delete("community.deleteMeeting", mb_no);
		
	}

	public void qnaBoardDelete(int cb_no) {
		sqlSession.delete("community.deleteQnA", cb_no);
		
	}

	public void reviewBoardDelete(int cb_no) {
		sqlSession.delete("community.deleteReview", cb_no);
	}

	public void userStateChange(int user_no) {
		sqlSession.update("user.userChange", user_no);
		
	}

	public void userStateBack(int user_no) {
		sqlSession.update("user.userBack", user_no);
		
	}

	public int RequestCount(int level) {
		int cnt = sqlSession.selectOne("gym.RequestCount", level);
		return cnt;
	}

	public void businessStateChange(int user_no) {
		sqlSession.update("gym.businessChange", user_no);
		sqlSession.update("user.userChange", user_no);
		
	}

	public void businessStateBack(int user_no) {
		sqlSession.update("user.userBack", user_no);
		
	}

	public int Message(int receiver) {
		int cnt = sqlSession.selectOne("gym.QnaMessage", receiver);
		return cnt;
	}

	public ArrayList<User> GymRequest(int level) {
		List<User> brlist = sqlSession.selectList("gym.topGymRequest", level);
		ArrayList<User> list = new ArrayList<User>(brlist);
		return list;
	}

	public ArrayList<GymQnABoard> adminBoard() {
		List<GymQnABoard> glist = sqlSession.selectList("gym.adminBoard");
		ArrayList<GymQnABoard> list = new ArrayList<GymQnABoard>(glist);
		return list;
	}

	public ArrayList<GymQnABoard> GymQnABoard(int receiver) {
		List<GymQnABoard> glist = sqlSession.selectList("gym.GymQnABoard", receiver);
		ArrayList<GymQnABoard> list = new ArrayList<GymQnABoard>(glist);
		return list;
	}

	public int meetingBoardInsert(MeetingBoard mboard) {
		int result = sqlSession.insert("community.adminMeetingBoardInsert", mboard);
		return result;
	}

	public int qnaBoardInsert(CommunityBoard cboard) {
		int result = sqlSession.insert("community.adminQnaBoardInsert", cboard);
		return result;
	}

	public int reviewBoardInsert(CommunityBoard cboard) {
		int result = sqlSession.insert("community.adminReviewBoardInsert", cboard);
		return result;
	}

	public ArrayList<MeetingBoard> meetingBoardList() {
		List<MeetingBoard> list = sqlSession.selectList("community.meetingBoardList");
		ArrayList<MeetingBoard> mlist = new ArrayList<MeetingBoard>(list);
		return mlist;
	}

	public ArrayList<CommunityBoard> qnaBoardList() {
		List<CommunityBoard> list = sqlSession.selectList("community.qnaBoardList");
		ArrayList<CommunityBoard> clist = new ArrayList<CommunityBoard>(list);
		return clist;
	}

	public ArrayList<CommunityBoard> reviewBoardList() {
		List<CommunityBoard> list = sqlSession.selectList("community.reviewBoardList");
		ArrayList<CommunityBoard> rlist = new ArrayList<CommunityBoard>(list);
		return rlist;
	}

	public int qnaResponse(GymQnABoard gqboard) {
		int result = sqlSession.insert("gym.adminQnAResponse", gqboard);
		return result;
	}

	public Object qnaBoardUpdate(int responseQ_no) {
		return sqlSession.update("gym.qnaBoardUpdate", responseQ_no);
	}

	public ArrayList<Health> HealthList() {
		List<Health> list = sqlSession.selectList("health.HealthList");
		ArrayList<Health> hlist = new ArrayList<Health>(list);
		
		return hlist;
	}

	public int visitCount() {
		return sqlSession.insert("visit.visitCount");
	}

	public int getTotalCount(Visit visit) {
		int totalCount = sqlSession.selectOne("visit.totalCount", visit);
		return totalCount;
	}

	public int getTodayCount(Visit visit) {
		int todayCount = sqlSession.selectOne("visit.todayCount", visit);
		return todayCount;
	}

	public User userDetail(User u) {
		return sqlSession.selectOne("user.userDetail", u);
	}

	public Like likeDetail(Like l) {
		return sqlSession.selectOne("like.likeDetail", l);
	}

	public int totalUser(int level) {
		int total = sqlSession.selectOne("user.totalUser", level);
		return total;
	}

	public int totalBusiness(int receiver) {
		int total = sqlSession.selectOne("user.totalBusiness", receiver);
		return total;
	}

	public int gymCount(int receiver) {
		int count = sqlSession.selectOne("gym.gymCount", receiver);
		return count;
	}

	public int boardCount() {
		int count = sqlSession.selectOne("community.getMeetingListCount");
		return count;
	}

	public int qnaCount() {
		int count = sqlSession.selectOne("community.getQnAListCount");
		return count;
	}

	public int reviewCount() {
		int count = sqlSession.selectOne("community.getReviewListCount");
		return count;
	}



	
	
	
}
