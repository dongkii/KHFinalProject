package com.kh.fitnessground.user.controller;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.GregorianCalendar;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.fitnessground.community.model.vo.CommunityAndMeeting;
import com.kh.fitnessground.gym.model.vo.GymQnABoard;
import com.kh.fitnessground.gym.model.vo.GymQnABoardPage;
import com.kh.fitnessground.user.model.service.UserService;
import com.kh.fitnessground.user.model.vo.User;
import com.kh.fitnessground.user.model.vo.UserSchedule;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	// 로그인 체크
	@RequestMapping(value="/login.do")
	public ModelAndView loginMethod(User user, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mv = new ModelAndView("main");
		User u = userService.loginCheck(user.getEmail()); // 이메일이 같은게 있는지 확인
		if( u == null ) {				
			mv.addObject("user", null); // 없을 경우 null 리턴
			mv.setViewName("jsonView");
			return mv;
		} else {
			if(BCrypt.checkpw(user.getPwd(), u.getPwd())) { // 이메일 같은게 있으면 암호화 데이터 비교
				mv.addObject("user",u);
				mv.setViewName("jsonView");
				session.setAttribute("user", u);  		// 아디비번이 같을 경우 세션값으로 넘김
				return mv;
			} else {						
				mv.addObject("user", null);		// 암호화된 데이터가 같지 않을 시에 null 리턴
				mv.setViewName("jsonView");
				return mv;
			}
		}
	}
	
	// 로그아웃
	@RequestMapping(value="/logout.do")
	public String logoutMethod(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		if(session != null) {
			session.invalidate();
		}
		
		return "main";
	}
	
	// 이메일 중복 확인
	@RequestMapping(value="/emailCheck.do")
	public ModelAndView emailCheckMethod(User user, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("main");
		User u = userService.emailCheck(user.getEmail());
		mv.addObject("user", u);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 닉네임 중복확인
	@RequestMapping(value="/nicknameCheck.do")
	public ModelAndView nicknameCheckMethod(User user, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("main");
		User u = userService.nicknameCheck(user.getNickname());
		mv.addObject("user", u);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 전화번호 중복확인
	@RequestMapping(value="/phonecheck.do")
	public ModelAndView phonecheckMethod(User user, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("main");
		User u = userService.phonecheck(user.getPhone());
		mv.addObject("user", u);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 회원가입 메소드
	@RequestMapping(value="/register.do")
	public ModelAndView registerMethod(User user, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("main");
		int user_level = Integer.parseInt(request.getParameter("userlevel"));
		user.setUser_level(user_level);		// user_level은 int 값이므로 자료형을 맞춰주어야 함
		// BCrypt 로 암호화
		String hashPassword = BCrypt.hashpw(user.getPwd(), BCrypt.gensalt()); // 비밀번호 암호화
		user.setPwd(hashPassword);
		userService.registerCheck(user);
		return mv;
	}
	
	// 아이디 찾기
	@RequestMapping(value="/findid.do")
	public ModelAndView findIdMethod(User user, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("main");
		User u = userService.findid(user);
		mv.addObject("user", u);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 비밀번호 찾기 - 임시비밀번호 이메일로 발송
	@RequestMapping(value="/findpwdcheck.do")
	public ModelAndView findpwdCheckMethod(User user, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("main");
		User u = userService.findpwdCheck(user);	// 찾기에 필요한 데이터와 일치하는 계정 있는지 확인
		if(u == null) {
			mv.addObject("user", u);			// 없으면 null 리턴
			mv.setViewName("jsonView");
		} else {								// 있을 경우
			int tmppwd = (int)(Math.random() * 8999 ) + 1000; // 4자리 랜덤값 생성
			String tmppwdstr = String.valueOf(tmppwd); 			// 스트링으로 변환
			String hashPassword = BCrypt.hashpw(tmppwdstr, BCrypt.gensalt()); // 솔트를 더해 다이제스트 구함
			user.setPwd(hashPassword); 	// 필드 pwd에 다이제스트 삽입
			userService.tmppwd(user);	// 다이제스트 값으로 계정 pwd 업데이트
			
			u = userService.loginCheck(user.getEmail()); // 임시비밀번호로 셀렉해옴
			
			String setfrom = "FitnessGround00@gmail.com"; // 송신자 이메일
			String tomail = u.getEmail(); // 수신자 이메일
			String title = "FitnessGround 임시 비밀번호 입니다."; // 메일 제목
			String content = "임시 비밀번호는 " + tmppwd + " 입니다. 로그인 후 비밀번호를 변경해 주세요."; //메일 내용
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				
				messageHelper.setFrom(setfrom);
				messageHelper.setTo(tomail);
				messageHelper.setSubject(title);
				messageHelper.setText(content);
				
				mailSender.send(message);
			} catch(Exception e) {
				System.out.println(e);
			}
			
			mv.addObject("user", u);
			mv.setViewName("jsonView");
		}
		return mv;
	}
	
	//헬스장등록으로 이동
	@RequestMapping(value="/moveregistergym.do")
	public String moveRegisterGymMethod(HttpSession session) {
		return "gym/registergym";
	}
	

	
	// 마이페이지로 뷰 이동
	@RequestMapping(value="/mypage.do")
	public ModelAndView myPageMethod(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("user/myPage");
		int userNo = Integer.parseInt(request.getParameter("userno"));
		mv.addObject("yesterday", userService.yesterdaySchedule(userNo));
		mv.addObject("today", userService.todaySchedule(userNo));
		/*System.out.println(userService.yesterdaySchedule(userNo));
		System.out.println(userService.todaySchedule(userNo));*/
		String currentDate = new SimpleDateFormat("yyyy.MM.dd").format(new Date(System.currentTimeMillis()));
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date(System.currentTimeMillis()));
		cal.add(Calendar.DATE, -1);
		String yesterDate = new SimpleDateFormat("yyyy.MM.dd").format(cal.getTime());
		mv.addObject("currentDate", currentDate);
		mv.addObject("yesterDate", yesterDate);
		return mv; 
	}
	// 회원정보 뷰 이동
	@RequestMapping(value="/udetail.do")
	public ModelAndView userDetailMethod(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("user/userDetail");
		return mv; 
	}
	// 회원정보 수정 및 비밀번호 수정 및 회원탈퇴에서 원비밀번호 확인 ajax
	@RequestMapping(value="/pwdCk.do")
	@ResponseBody
	public String PwdCheckMethod(User user, HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/json; charset=utf-8");	
		JSONObject job = new JSONObject();
		User u = userService.userPwdSelect(user.getUser_no());
		if(u!=null && BCrypt.checkpw(user.getPwd(), u.getPwd())) 
			job.put("result", 1);
		else
			job.put("result", -1);
		return job.toJSONString();
	}
	// 회원 프로필 이미지 수정
	@RequestMapping(value="/profileImgModify.do")
	public ModelAndView userProfileImgModifyMethod(User u, HttpServletRequest request) throws Exception {
		// 기존 이미지가 있을 경우, 파일 삭제
		String fileName = userService.loginCheck(u.getEmail()).getRename_image();
		if(fileName != null) {
			File file = new File(request.getSession().getServletContext().getRealPath("/resources/images/myimages/"+fileName));
			if(file.exists()) file.delete();
		}
		ModelAndView mv = new ModelAndView("redirect:/mypage.do?userno="+u.getUser_no());
		userService.userProfileImgUpdate(u, request);
		HttpSession session = request.getSession();
		session.setAttribute("user", userService.selectUser(u.getUser_no()));
		return mv; 
	}
	// 회원 프로필 이미지 삭제
	@RequestMapping(value="/profileImgRemove.do")
	public ModelAndView userProfileImgRemoveMethod(User u, HttpServletRequest request) {
		// 기존 이미지 파일 삭제
		String fileName = userService.loginCheck(u.getEmail()).getRename_image();
		if(fileName != null) {
			File file = new File(request.getSession().getServletContext().getRealPath("/resources/images/myimages/"+fileName));
			if(file.exists()) file.delete();
		}	
		ModelAndView mv = new ModelAndView("redirect:/mypage.do?userno="+u.getUser_no());
		userService.userProfileImgRemove(u);
		HttpSession session = request.getSession();
		session.setAttribute("user", userService.selectUser(u.getUser_no()));
		return mv; 
	}
	// 회원정보 수정 ajax
	@RequestMapping(value="/uupdate.do")
	public ModelAndView userUpdateMethod(User u, ModelAndView mv, HttpServletRequest request) {
		userService.userUpdate(u);
		HttpSession session = request.getSession();
		session.setAttribute("user", userService.selectUser(u.getUser_no()));
		mv.setViewName("jsonView");
		return mv; 
	}
	// 비밀번호 수정 뷰 이동
	@RequestMapping(value="/userpwd.do")
	public ModelAndView userPwdModifyMethod(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("user/userPwdModify");
		return mv; 
	}
	// 비밀번호 수정 ajax
	@RequestMapping(value="/upwdupdate.do")
	public ModelAndView userPwdUpdateMethod(User user, ModelAndView mv, HttpServletRequest request) {
		String hashPassword = BCrypt.hashpw(user.getPwd(), BCrypt.gensalt()); // 비밀번호 암호화
		user.setPwd(hashPassword);
		userService.userPwdUpdate(user);
		HttpSession session = request.getSession();
		if(session != null)
			session.invalidate();
		mv.setViewName("jsonView");
		return mv;
	}
	// 회원탈퇴 뷰 이동
	@RequestMapping(value="/userdel.do")
	public ModelAndView userDeleteViewMethod(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("user/userDelete");
		return mv; 
	}
	// 회원탈퇴 ajax
	@RequestMapping(value="/userdelete.do")
	public ModelAndView userDeleteMethod(User u, ModelAndView mv, HttpServletRequest request) {
		userService.userDelete(u);
		HttpSession session = request.getSession();
		if(session != null) {
			session.invalidate();
		}
		mv.setViewName("jsonView");
		return mv; 
	}
	// 내 게시글 목록
	@RequestMapping(value="/userboard.do")
	public ModelAndView userBoardMethod(HttpServletRequest request) {
		int user_no = Integer.parseInt(request.getParameter("userno"));
		int limit = 10;

		// 문의하기 목록 조회
		int qCurrentPage = 1;
		if (request.getParameter("qpage") != null)
			qCurrentPage = Integer.parseInt(request.getParameter("qpage"));
		int listCount = userService.qnABoardCount(user_no);
		GymQnABoardPage qPage = new GymQnABoardPage(qCurrentPage, limit);
		int qMaxPage = (int) ((double) listCount / limit + 0.9);
		int qStartPage = ((int) ((double) qCurrentPage / limit + 0.9) - 1) * limit + 1;
		int qEndPage = qStartPage + limit - 1;
		if (qMaxPage < qEndPage)	qEndPage = qMaxPage;
		ArrayList<GymQnABoard> qlist = userService.qnABoardList(qPage, user_no);
		
		// 커뮤니티 목록 조회
		int currentPage = 1;
		if (request.getParameter("cpage") != null)
			currentPage = Integer.parseInt(request.getParameter("cpage"));
		ArrayList<CommunityAndMeeting> temp = userService.communityBoardList(user_no);
		temp.addAll(userService.meetingBoardList(user_no));
		int cListCount = temp.size();
		GymQnABoardPage cPage = new GymQnABoardPage(currentPage, limit);
		int cMaxPage = (int) ((double) cListCount/limit + 0.9);
		int cStartPage = ((int) ((double) currentPage/limit+0.9)-1)*limit+1;
		int cEndPage = cStartPage + limit - 1;
		if(cMaxPage < cEndPage) cEndPage = cMaxPage;
		// date로 정렬 후, cPage.startPage-1부터 cPage.endPage-1까지의 개수만 다시 list에 넣어줌
		Collections.sort(temp);
		ArrayList<CommunityAndMeeting> cmList = new ArrayList<CommunityAndMeeting>();
		if(cPage.getEndRow()-1 > temp.size()) cPage.setEndRow(temp.size());
		for(int i=cPage.getStartRow()-1; i<=cPage.getEndRow()-1; i++)
			cmList.add(temp.get(i));
//			System.out.println(temp.get(i));
		
		ModelAndView mv = new ModelAndView("user/userBoard");
		if(request.getParameter("com")!=null)
			mv.addObject("com","ok");
		else mv.addObject("com","no");
		
		mv.addObject("qlist", qlist);
		mv.addObject("qCurrentPage", qCurrentPage);
    	mv.addObject("qMaxPage", qMaxPage);
    	mv.addObject("qStartPage", qStartPage);
    	mv.addObject("qEndPage", qEndPage);
    	
    	mv.addObject("clist", cmList);
    	mv.addObject("currentPage", currentPage);
    	mv.addObject("cMaxPage", cMaxPage);
    	mv.addObject("cStartPage", cStartPage);
    	mv.addObject("cEndPage", cEndPage);
    	
		return mv; 
	}
	// 내 게시글 검색
	@RequestMapping(value="/userBoardSearch.do")
	public ModelAndView userBoardSearchMethod(HttpServletRequest request) {
		 
		ModelAndView mv = new ModelAndView("user/userBoard");
		
		String keyword = request.getParameter("searchKeyword");
		int user_no = Integer.parseInt(request.getParameter("userno"));
		
		int qMaxPage, qStartPage, qEndPage, limit=10, currentPage=1;
		int cMaxPage, cStartPage, cEndPage;
		if(request.getParameter("page") != null)
			currentPage = Integer.parseInt(request.getParameter("page"));
		GymQnABoardPage page = new GymQnABoardPage(currentPage, limit);
		GymQnABoardPage noSPage = new GymQnABoardPage(1, limit);
		ArrayList<GymQnABoard> qlist = null;
		ArrayList<CommunityAndMeeting> cmList = new ArrayList<CommunityAndMeeting>();
		
		if(request.getParameter("com") == null) {
			// 문의하기 검색
			qMaxPage = (int) ((double) userService.qnABoardSearchCount(user_no, keyword) / limit + 0.9);
			qStartPage = ((int) ((double) currentPage / limit + 0.9) - 1) * limit + 1;
			qEndPage = qStartPage + limit - 1;
			if (qMaxPage < qEndPage)	qEndPage = qMaxPage;
			qlist = userService.qnABoardSearch(page, keyword, user_no);
			// 커뮤니티 전체 목록
			ArrayList<CommunityAndMeeting> temp = userService.communityBoardList(user_no);
			temp.addAll(userService.meetingBoardList(user_no));
			cMaxPage = (int) ((double) temp.size()/limit + 0.9);
			cStartPage = ((int) ((double) 1/limit+0.9)-1)*limit+1;
			cEndPage = cStartPage + limit - 1;
			if(cMaxPage < cEndPage) cEndPage = cMaxPage;
			Collections.sort(temp);
			if(noSPage.getEndRow()-1 >= temp.size()) noSPage.setEndRow(temp.size());
			for(int i=noSPage.getStartRow()-1; i<=noSPage.getEndRow()-1; i++)
				cmList.add(temp.get(i));
		} 
		else {
			// 커뮤니티 검색
			ArrayList<CommunityAndMeeting> temp = userService.communityBoardSearch(user_no, keyword);
			temp.addAll(userService.meetingBoardSearch(user_no, keyword));
			cMaxPage = (int) ((double) temp.size()/limit + 0.9);
			cStartPage = ((int) ((double) currentPage/limit+0.9)-1)*limit+1;
			cEndPage = cStartPage + limit - 1;
			if(cMaxPage < cEndPage) cEndPage = cMaxPage;
			Collections.sort(temp);
			if(page.getEndRow()-1 >= temp.size()) page.setEndRow(temp.size());
			for(int i=page.getStartRow()-1; i<=page.getEndRow()-1; i++)
				cmList.add(temp.get(i));
			// 문의하기 전체 목록
			qMaxPage = (int) ((double) userService.qnABoardCount(user_no) / limit + 0.9);
			qStartPage = ((int) ((double) 1 / limit + 0.9) - 1) * limit + 1;
			qEndPage = qStartPage + limit - 1;
			if (qMaxPage < qEndPage)	qEndPage = qMaxPage;
			qlist = userService.qnABoardList(new GymQnABoardPage(1, limit), user_no);
		}
		
		if(request.getParameter("com")!=null) {
			mv.addObject("com","ok");
			mv.addObject("cSearchKeyword", keyword);
		}
		else {
			mv.addObject("com","no");
			mv.addObject("qSearchKeyword", keyword);
		}
		
		mv.addObject("search", "ok");
		
		mv.addObject("qlist", qlist);
		mv.addObject("qCurrentPage", currentPage);
    	mv.addObject("qMaxPage", qMaxPage);
    	mv.addObject("qStartPage", qStartPage);
    	mv.addObject("qEndPage", qEndPage);
    	
    	mv.addObject("clist", cmList);
    	mv.addObject("currentPage", currentPage);
    	mv.addObject("cMaxPage", cMaxPage);
    	mv.addObject("cStartPage", cStartPage);
    	mv.addObject("cEndPage", cEndPage);
		
		return mv; 
	}
	// 내 운동 스케줄 관리
	@RequestMapping(value="/uschedule.do")
	public ModelAndView userScheduleMethod(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("user/userSchedule");
		/*System.out.println(userService.userAllSchedule(Integer.parseInt(request.getParameter("userno"))));*/
		mv.addObject("list", userService.userAllSchedule(Integer.parseInt(request.getParameter("userno"))));
		return mv; 
	}
	// 운동스케줄 insert
	@RequestMapping(value="/uscheduleInsert.do")
	public ResponseEntity<String> userScheduleInsertMethod(HttpServletRequest request, @RequestBody String param) throws Exception {
		request.setCharacterEncoding("utf-8");
		JSONObject job = (JSONObject)new JSONParser().parse(param);
		String dateT = (String)job.get("upload_date"); //upload_date
		String[] datesT = dateT.split("-");
		int[] dates = new int[datesT.length];
		for(int i=0; i<dates.length; i++) dates[i] = Integer.parseInt(datesT[i]);
		UserSchedule us = new UserSchedule(((User)request.getSession().getAttribute("user")).getUser_no(),
				(String)job.get("content"), new Date(new GregorianCalendar(dates[0],dates[1]-1,dates[2]).getTimeInMillis()));
		userService.insertUserSchedule(us);
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	// 운동스케줄 delete
	@RequestMapping(value="/uscheduleDel.do")
	public ResponseEntity<String> userScheduleDeleteMethod(HttpServletRequest request, @RequestBody String param) throws Exception {
		request.setCharacterEncoding("utf-8");
		JSONObject job = (JSONObject)new JSONParser().parse(param);
		int s_no = Integer.parseInt(((String)job.get("s_no")));
		userService.deleteUserSchedule(s_no);
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	// 운동스케줄 수정
	@RequestMapping(value="/uscheduleModify.do")
	public ResponseEntity<String> userScheduleModifyMethod(HttpServletRequest request, @RequestBody String param) throws Exception {
		request.setCharacterEncoding("utf-8");
		JSONObject job = (JSONObject)new JSONParser().parse(param);
		int s_no = Integer.parseInt(((String)job.get("s_no")));
		String content = (String)job.get("content");
		userService.updateUserSchedule(s_no, content);
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}	
}
