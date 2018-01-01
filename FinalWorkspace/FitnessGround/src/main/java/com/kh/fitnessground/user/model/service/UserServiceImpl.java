package com.kh.fitnessground.user.model.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.fitnessground.common.util.FileUtils;
import com.kh.fitnessground.community.model.vo.CommunityAndMeeting;
import com.kh.fitnessground.gym.model.vo.GymQnABoard;
import com.kh.fitnessground.gym.model.vo.GymQnABoardPage;
import com.kh.fitnessground.user.model.dao.UserDao;
import com.kh.fitnessground.user.model.vo.User;
import com.kh.fitnessground.user.model.vo.UserSchedule;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Autowired
	UserDao userDao;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;

	@Override
	public User loginCheck(String email) {
		return userDao.logincheck(email);
	}

	@Override
	public User list(int user_no) {
		return userDao.list(user_no);
	}

	@Override
	public User emailCheck(String vo) {
		return userDao.emailcheck(vo);
	}

	@Override
	public User nicknameCheck(String nickname) {
		return userDao.nicknameCheck(nickname);
	}
	
	@Override
	public User phonecheck(String phone) {
		return userDao.phonecheck(phone);
	}

	@Override
	public void registerCheck(User user) {
		userDao.registerCheck(user);
	}

	@Override
	public User findid(User user) {
		return userDao.findid(user);
	}

	@Override
	public User findpwdCheck(User user) {
		return userDao.findpwdCheck(user);
	}

	@Override
	public int tmppwd(User user) {
		return userDao.tmppwd(user);
	}

	@Override
	public ArrayList<UserSchedule> yesterdaySchedule(int userNo) {
		return userDao.yesterdaySchedule(userNo);
	}

	@Override
	public ArrayList<UserSchedule> todaySchedule(int userNo) {
		return userDao.todaySchedule(userNo);
	}

	@Override
	public void userUpdate(User u) {
		userDao.userUpdate(u);
	}
	
	@Override
	public void userPwdUpdate(User u) {
		userDao.userPwdUpdate(u);
	}

	@Override
	public void userDelete(User u) {
		userDao.userDelete(u);
	}

	@Override
	public ArrayList<UserSchedule> userAllSchedule(int userNo) {
		return userDao.userAllSchedule(userNo);
	}
	
	@Override
	public User userPwdSelect(int user_no) {
		return userDao.userPwdSelect(user_no);
	}

	@Override
	public void userProfileImgUpdate(User u, HttpServletRequest request) throws Exception {
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(request);
		String original_image="", rename_image="";
		for(int i=0, size=list.size(); i<size; i++){
			original_image = (String) list.get(i).get("original_fileName");
			rename_image = (String) list.get(i).get("rename_fileName");
		}
		if(original_image!="" || !original_image.equals("")) {
			u.setOriginal_image(original_image);
			u.setRename_image(rename_image);
			userDao.userProfileImgUpdate(u);
		}
	}

	@Override
	public void userProfileImgRemove(User u) {
		userDao.userProfileImgUpdate(u);
	}

	@Override
	public int qnABoardCount(int user_no) {
		return userDao.qnABoardCount(user_no);
	}

	@Override
	public ArrayList<GymQnABoard> qnABoardList(GymQnABoardPage qPage, int user_no) {
		HashMap<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("qPage", qPage);
		parameters.put("user_no", user_no);
		return userDao.qnABoardList(parameters);
	}

	@Override
	public int qnABoardSearchCount(int user_no, String keyword) {
		HashMap<String, Object> parameters = new HashMap<String, Object>();
	    parameters.put("user_no", user_no);
	    parameters.put("keyword", "%"+keyword+"%");
		return userDao.qnABoardSearchCount(parameters);
	}

	@Override
	public ArrayList<GymQnABoard> qnABoardSearch(GymQnABoardPage qPage, String keyword, int user_no) {
		HashMap<String, Object> parameters = new HashMap<String, Object>();
	    parameters.put("qPage", qPage);
	    parameters.put("keyword", "%"+keyword+"%");
	    parameters.put("user_no", user_no);
		return userDao.qnaBoardSearch(parameters);
	}

	@Override
	public User selectUser(int userNo) {
		return userDao.selectUser(userNo);
	}

	@Override
	public ArrayList<CommunityAndMeeting> communityBoardList(int user_no) {
		return userDao.selectCommunityList(user_no);
	}

	@Override
	public ArrayList<CommunityAndMeeting> meetingBoardList(int user_no) {
		return userDao.selectMeetingList(user_no);
	}

	@Override
	public ArrayList<CommunityAndMeeting> communityBoardSearch(int user_no, String keyword) {
		HashMap<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("user_no", user_no);
		parameters.put("keyword", "%"+keyword+"%");
		return userDao.communitySearch(parameters);
	}

	@Override
	public ArrayList<CommunityAndMeeting> meetingBoardSearch(int user_no, String keyword) {
		HashMap<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("user_no", user_no);
		parameters.put("keyword", "%"+keyword+"%");
		return userDao.meetingSearch(parameters);
	}

	@Override
	public void insertUserSchedule(UserSchedule us) {
		userDao.insertUserSchedule(us);
	}

	@Override
	public void deleteUserSchedule(int s_no) {
		userDao.deleteUserSchedule(s_no);
	}

	@Override
	public void updateUserSchedule(int s_no, String content) {
		HashMap<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("s_no", s_no);
		parameters.put("content", content);
		userDao.updateuserSchedule(parameters);
	}

	@Override
	public int qnABoardSelectedCount(int user_no, String selectValue) {
		HashMap<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("user_no", user_no);
		parameters.put("selectValue", selectValue);
		return userDao.qnABoardSelectedCount(parameters);
	}

	@Override
	public ArrayList<GymQnABoard> qnABoardSelectedList(GymQnABoardPage qPage, int user_no, String selectValue) {
		HashMap<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("qPage", qPage);
		parameters.put("user_no", user_no);
		parameters.put("selectValue", selectValue);
		return userDao.qnABoardSelectedList(parameters);
	}

	@Override
	public ArrayList<CommunityAndMeeting> communityBoardSelectedList(int user_no, String selectValue) {
		HashMap<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("user_no", user_no);
		parameters.put("selectValue", selectValue);
		return userDao.communityBoardSelectedList(parameters);
	}
}
