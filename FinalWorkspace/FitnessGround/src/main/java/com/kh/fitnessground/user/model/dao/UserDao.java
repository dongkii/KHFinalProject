package com.kh.fitnessground.user.model.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.fitnessground.community.model.vo.CommunityAndMeeting;
import com.kh.fitnessground.gym.model.vo.GymQnABoard;
import com.kh.fitnessground.gym.model.vo.GymQnABoardPage;
import com.kh.fitnessground.user.model.vo.User;
import com.kh.fitnessground.user.model.vo.UserSchedule;

@Repository("userDao")
public class UserDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public UserDao() {}

	public User logincheck(String email) {
		User user = sqlSession.selectOne("user.selectUser", email);
		return user;
	}

	public User list(int user_no) {
		return sqlSession.selectOne("user.selectInfo", user_no);
	}

	public User emailcheck(String vo) {
		return sqlSession.selectOne("user.emailCheck", vo);
	}

	public User nicknameCheck(String nickname) {
		return sqlSession.selectOne("user.nicknameCheck", nickname);
	}
	
	public User phonecheck(String phone) {
		return sqlSession.selectOne("user.phonecheck", phone);
	}

	public void registerCheck(User user) {
		sqlSession.insert("user.register", user);
	}

	public User findid(User user) {
		return sqlSession.selectOne("user.findid", user);
	}

	public User findpwdCheck(User user) {
		return sqlSession.selectOne("user.findpwdcheck", user);
	}

	public int tmppwd(User user) {
		return sqlSession.update("user.tmppwd", user);
	}

	public ArrayList<UserSchedule> yesterdaySchedule(int userNo) {
		List<UserSchedule> list = sqlSession.selectList("user.yesterdaySchedule", userNo);
		return new ArrayList<UserSchedule>(list);
	}

	public ArrayList<UserSchedule> todaySchedule(int userNo) {
		List<UserSchedule> list = sqlSession.selectList("user.todaySchedule", userNo);
		return new ArrayList<UserSchedule>(list);
	}

	public void userUpdate(User u) {
		sqlSession.update("user.userUpdate", u);
	}

	public void userPwdUpdate(User u) {
		sqlSession.update("user.userPwdUpdate", u);		
	}

	public void userDelete(User u) {
		sqlSession.delete("user.userDelete", u);
	}

	public ArrayList<UserSchedule> userAllSchedule(int userNo) {
		List<UserSchedule> list = sqlSession.selectList("user.userAllSchedule", userNo);
		return new ArrayList<UserSchedule>(list);
	}

	public User userPwdSelect(int user_no) {
		return sqlSession.selectOne("user.userPwdSelect", user_no);
	}

	public void userProfileImgUpdate(User u) {
		sqlSession.update("user.userProfileImgUpdate", u);
	}

	public ArrayList<GymQnABoard> qnABoardList(HashMap<String, Object> parameters) {
		List<GymQnABoard> list = sqlSession.selectList("gym.myPageQnABoardList", parameters);
		return new ArrayList<GymQnABoard>(list);
	}

	public int qnABoardCount(int user_no) {
		return sqlSession.selectOne("gym.myPageQnABoardCount", user_no);
	}

	public int qnABoardSearchCount(HashMap<String, Object> parameters) {
		return sqlSession.selectOne("gym.myPageQnABoardSearchCount", parameters);
	}

	public ArrayList<GymQnABoard> qnaBoardSearch(HashMap<String, Object> parameters) {
		List<GymQnABoard> list = sqlSession.selectList("gym.myPageQnABoardSearchList", parameters);
		return new ArrayList<GymQnABoard>(list);
	}

	public User selectUser(int userNo) {
		return sqlSession.selectOne("user.selectInfo", userNo);
	}

	public ArrayList<CommunityAndMeeting> selectCommunityList(int user_no) {
		List<CommunityAndMeeting> list = sqlSession.selectList("community.myPageCommunityList", user_no); 
		return new ArrayList<CommunityAndMeeting>(list);
	}

	public ArrayList<CommunityAndMeeting> selectMeetingList(int user_no) {
		List<CommunityAndMeeting> list = sqlSession.selectList("community.myPageMeetingList", user_no); 
		return new ArrayList<CommunityAndMeeting>(list);
	}

	public ArrayList<CommunityAndMeeting> communitySearch(HashMap<String, Object> parameters) {
		List<CommunityAndMeeting> list = sqlSession.selectList("community.myPageCommunitySearchList", parameters);
		return new ArrayList<CommunityAndMeeting>(list);
	}

	public ArrayList<CommunityAndMeeting> meetingSearch(HashMap<String, Object> parameters) {
		List<CommunityAndMeeting> list = sqlSession.selectList("community.myPageMeetingSearchList", parameters);
		return new ArrayList<CommunityAndMeeting>(list);
	}

	public void insertUserSchedule(UserSchedule us) {
		sqlSession.insert("user.insertUSchedule", us);
	}

	public void deleteUserSchedule(int s_no) {
		sqlSession.delete("user.deleteUSchedule", s_no);
	}

	public void updateuserSchedule(HashMap<String, Object> parameters) {
		sqlSession.update("user.updateUSchedule", parameters);
	}

	public int qnABoardSelectedCount(HashMap<String, Object> parameters) {
		return sqlSession.selectOne("gym.myPageQnABoardSelectedCount", parameters);
	}

	public ArrayList<GymQnABoard> qnABoardSelectedList(HashMap<String, Object> parameters) {
		List<GymQnABoard> list = sqlSession.selectList("gym.myPageQnABoardSelectedList", parameters);
		return new ArrayList<GymQnABoard>(list);
	}

	public ArrayList<CommunityAndMeeting> communityBoardSelectedList(HashMap<String, Object> parameters) {
		List<CommunityAndMeeting> list = sqlSession.selectList("community.myPageCommunitySelectedList", parameters); 
		return new ArrayList<CommunityAndMeeting>(list);
	}
}
