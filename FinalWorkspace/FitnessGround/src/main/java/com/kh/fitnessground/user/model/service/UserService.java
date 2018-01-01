package com.kh.fitnessground.user.model.service;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;

import com.kh.fitnessground.community.model.vo.CommunityAndMeeting;
import com.kh.fitnessground.gym.model.vo.GymQnABoard;
import com.kh.fitnessground.gym.model.vo.GymQnABoardPage;
import com.kh.fitnessground.user.model.vo.User;
import com.kh.fitnessground.user.model.vo.UserSchedule;

public interface UserService {

	User loginCheck(String email);

	User list(int user_no);

	User emailCheck(String email);

	User nicknameCheck(String nickname);
	
	User phonecheck(String phone);

	void registerCheck(User user);

	User findid(User user);

	User findpwdCheck(User user);

	int tmppwd(User user);

	ArrayList<UserSchedule> yesterdaySchedule(int userNo);

	ArrayList<UserSchedule> todaySchedule(int userNo);

	void userUpdate(User u);

	void userPwdUpdate(User u);

	void userDelete(User u);

	ArrayList<UserSchedule> userAllSchedule(int userNo);
	
	User userPwdSelect(int user_no);

	void userProfileImgUpdate(User u, HttpServletRequest request) throws Exception;

	void userProfileImgRemove(User u);

	ArrayList<GymQnABoard> qnABoardList(GymQnABoardPage qPage, int user_no);

	int qnABoardCount(int user_no);

	int qnABoardSearchCount(int user_no, String keyword);

	ArrayList<GymQnABoard> qnABoardSearch(GymQnABoardPage qPage, String keyword, int user_no);

	User selectUser(int userNo);

	ArrayList<CommunityAndMeeting> communityBoardList(int user_no);

	ArrayList<CommunityAndMeeting> meetingBoardList(int user_no);

	ArrayList<CommunityAndMeeting> communityBoardSearch(int user_no, String keyword);

	ArrayList<CommunityAndMeeting> meetingBoardSearch(int user_no, String keyword);

	void insertUserSchedule(UserSchedule us);

	void deleteUserSchedule(int s_no);

	void updateUserSchedule(int s_no, String content);

	int qnABoardSelectedCount(int user_no, String selectValue);

	ArrayList<GymQnABoard> qnABoardSelectedList(GymQnABoardPage qPage, int user_no, String selectValue);

	ArrayList<CommunityAndMeeting> communityBoardSelectedList(int user_no, String selectValue);
}
