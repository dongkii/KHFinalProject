package com.kh.fitnessground.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.codec.multipart.SynchronossPartHttpMessageReader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.fitnessground.admin.model.service.AdminService;
import com.kh.fitnessground.admin.model.vo.BusinessRequest;
import com.kh.fitnessground.admin.model.vo.Visit;
import com.kh.fitnessground.community.model.service.CommunityBoardService;
import com.kh.fitnessground.community.model.vo.CommunityBoard;
import com.kh.fitnessground.community.model.vo.MeetingBoard;
import com.kh.fitnessground.gym.model.service.GymService;
import com.kh.fitnessground.gym.model.vo.Gym;
import com.kh.fitnessground.gym.model.vo.GymQnABoard;
import com.kh.fitnessground.user.model.service.UserService;
import com.kh.fitnessground.user.model.service.UserServiceImpl;
import com.kh.fitnessground.user.model.vo.User;
import com.kh.fitnessground.workout.commentlike.vo.Like;
import com.kh.fitnessground.workout.health.model.service.HealthService;
import com.kh.fitnessground.workout.health.model.vo.Health;
import com.kh.fitnessground.workout.yoga.model.service.YogaService;
import com.kh.fitnessground.workout.yoga.model.vo.Yoga;
import com.sun.xml.internal.ws.api.message.Message;

@Controller
public class AdminController {
	@Autowired
	private UserService userService;

	@Autowired
	private CommunityBoardService communityBoardService;

	@Autowired
	private HealthService healthService;

	@Autowired
	private YogaService yogaService;

	@Autowired
	private AdminService adminService;
	
	@Autowired
	private GymService gymService;
	
	
	// 관리자 메인뷰 이동
	@RequestMapping(value = "adminMain.do")
	public ModelAndView adminmain(User user, BusinessRequest businessRequest,
			@RequestParam(value = "level", required = false, defaultValue = "0") int level, GymQnABoard gymqnaboard,
			@RequestParam(value = "receiver", required = false, defaultValue = "1") int receiver, HttpServletRequest request, HttpServletResponse response, Visit visit) {
		HttpSession session = request.getSession();	
		System.out.println("adminMain.do실행됨...");
		// 리퀘스트 파람 -> 자동으로 값을 받아옴
		// 근데 받아올 데이터가 없으면 required=false -> 꼭필요하지 않다 라는 뜻
		// defaultValue="0" -> 기본값설정 / 그러니깐 값이 없을때는 0으로 한다 라는뜻
		ModelAndView mv = new ModelAndView("admin/adminMain");
		int gymrequest = adminService.RequestCount(level);// 헬스장등록요청 갯수 승인상태가 0 인것만/ (미승인=0/승인=1)
		int message = adminService.Message(receiver);// 관리자에게 온 문의 갯수 리시버가 1(관리자user_no) 이고, 응답상태가 0 인것만(미응답=0/응답=1)
		
		ArrayList<User> gymRlist = adminService.GymRequest(level);// 헬스장 요청 정보 최신순 3개만리스트로 불러오기 승인상태 0인것만
		ArrayList<GymQnABoard> qnalist = adminService.GymQnABoard(receiver);// 메세지 요청 최신 3개 미응답이고 리시버가 1인 것만 리스트로 불러오기

		//방문자수 
			
		/*// 총 방문자 수
		int total = adminService.getTotalCount(visit);

		// 오늘 방문자 수
		int today = adminService.getTodayCount(visit);
		System.out.println("총 방문자 수 : " +total);
		System.out.println("오늘 방문자 수 : " +today);
		

		
		session.setAttribute("total", total);
		session.setAttribute("today", today);*/
		
		mv.addObject("gymrequest", gymrequest);
		mv.addObject("message", message);
		mv.addObject("gymRlist", gymRlist);
		mv.addObject("qnalist", qnalist);
		
		/*System.out.println("등록요청 수 :" + request);
		System.out.println("등록요청gymRlist : " + gymRlist);
		System.out.println("문의 수 :" + message);
		System.out.println("문의요청list : " + qnalist);*/
		return mv;
	}



	// 관리자 차트뷰 이동
	@RequestMapping(value = "charts.do")
	public ModelAndView charts(User user, BusinessRequest businessRequest,
			@RequestParam(value = "level", required = false, defaultValue = "0") int level, GymQnABoard gymqnaboard,
			@RequestParam(value = "receiver", required = false, defaultValue = "1") int receiver) {

		ModelAndView mv = new ModelAndView("admin/charts");

		int gymrequest = adminService.RequestCount(level);
		int message = adminService.Message(receiver);

		ArrayList<User> gymRlist = adminService.GymRequest(level);
		ArrayList<GymQnABoard> qnalist = adminService.GymQnABoard(receiver);
		ArrayList<Health> hlist = adminService.HealthList();

		System.out.println("조회수별 헬스 조회 : "+hlist);
		mv.addObject("gymrequest", gymrequest);
		mv.addObject("message", message);
		mv.addObject("gymRlist", gymRlist);
		mv.addObject("qnalist", qnalist);
		mv.addObject("hlist",hlist);

		return mv;
	}

	// 관리자 로그아웃
	@RequestMapping(value = "/adminlogout.do")
	public String logoutMethod(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (session != null) {
			session.invalidate();
		}

		return "main";
	}

	// 회원 리스트 출력
	@RequestMapping(value = "adminuserlist.do")
	public ModelAndView UserListMethod(User user, BusinessRequest businessRequest,
			@RequestParam(value = "level", required = false, defaultValue = "0") int level, GymQnABoard gymqnaboard,
			@RequestParam(value = "receiver", required = false, defaultValue = "1") int receiver) {

		ModelAndView mv = new ModelAndView("admin/userlist/userlist");

		int gymrequest = adminService.RequestCount(level);// 헬스장등록요청 갯수 승인상태가 0 인것만 (미승인=0/승인=1)
		int message = adminService.Message(receiver);// 관리자에게 온 문의 갯수 리시버가 1(관리자user_no) 이고, 응답 상태가 0 인것만(미응답=0/응답=1)

		ArrayList<User> gymRlist = adminService.GymRequest(level);// 헬스장 요청 정보 최신순 3개만리스트로 불러오기 승인상태 0인것만
		ArrayList<GymQnABoard> qnalist = adminService.GymQnABoard(receiver);//메세지 요청 최신3개 미응답이고 리시버가 1인 것만 리스트로 불러오기																		
		ArrayList<User> list = adminService.userlist(level);
		System.out.println("회원 정보 : " +list);
		mv.addObject("gymrequest", gymrequest);
		mv.addObject("message", message);
		mv.addObject("gymRlist", gymRlist);
		mv.addObject("qnalist", qnalist);
		mv.addObject("list", list);

		return mv;
	}

	// 사업자 리스트 출력(헬스장 등록요청 처리)
	@RequestMapping(value = "adminbusinesslist.do")
	public ModelAndView BuisnessListMethod(User user, BusinessRequest businessRequest,
			@RequestParam(value = "level", required = false, defaultValue = "0") int level, GymQnABoard gymqnaboard,
			@RequestParam(value = "receiver", required = false, defaultValue = "1") int receiver) {

		ModelAndView mv = new ModelAndView("admin/userlist/userbusinesslist");

		int gymrequest = adminService.RequestCount(level);
		int message = adminService.Message(receiver);

		ArrayList<User> gymRlist = adminService.GymRequest(level);
		ArrayList<GymQnABoard> qnalist = adminService.GymQnABoard(receiver);
		ArrayList<User> list = adminService.businesslist(receiver);

		mv.addObject("gymrequest", gymrequest);
		mv.addObject("message", message);
		mv.addObject("gymRlist", gymRlist);
		mv.addObject("qnalist", qnalist);
		mv.addObject("list", list);

		return mv;
	}

	// 사업자 헬스장 등록요청 리스트 출력(헬스장 등록요청 처리)
	@RequestMapping(value = "adminbusinessRequestlist.do")
	public ModelAndView BuisnessRequestListMethod(User user, BusinessRequest businessRequest,
			@RequestParam(value = "level", required = false, defaultValue = "0") int level, GymQnABoard gymqnaboard,
			@RequestParam(value = "receiver", required = false, defaultValue = "1") int receiver) {

		ModelAndView mv = new ModelAndView("admin/userlist/userbusinessRequestlist");

		int gymrequest = adminService.RequestCount(level);
		int message = adminService.Message(receiver);

		ArrayList<User> gymRlist = adminService.GymRequest(level);
		ArrayList<GymQnABoard> qnalist = adminService.GymQnABoard(receiver);
		ArrayList<User> list = adminService.businessRequestlist(receiver);

		mv.addObject("gymrequest", gymrequest);
		mv.addObject("message", message);
		mv.addObject("gymRlist", gymRlist);
		mv.addObject("qnalist", qnalist);
		mv.addObject("list", list);

		return mv;
	}

	// mettingBoard 리스트 출력
	@RequestMapping(value = "adminMettingBoard.do")
	public ModelAndView mettingBoardListMethod(User user, BusinessRequest businessRequest,
			@RequestParam(value = "level", required = false, defaultValue = "0") int level, GymQnABoard gymqnaboard,
			@RequestParam(value = "receiver", required = false, defaultValue = "1") int receiver) {

		ModelAndView mv = new ModelAndView("admin/boardlist/meetingboard");

		int gymrequest = adminService.RequestCount(level);
		int message = adminService.Message(receiver);

		ArrayList<User> gymRlist = adminService.GymRequest(level);
		ArrayList<GymQnABoard> qnalist = adminService.GymQnABoard(receiver);
		ArrayList<MeetingBoard> list = adminService.meetingListView();

		mv.addObject("gymrequest", gymrequest);
		mv.addObject("message", message);
		mv.addObject("gymRlist", gymRlist);
		mv.addObject("qnalist", qnalist);
		mv.addObject("list", list);

		return mv;
	}

	// qnaBoard 리스트 출력
	@RequestMapping(value = "adminQNABoard.do")
	public ModelAndView qnaBoardListMethod(User user, BusinessRequest businessRequest,
			@RequestParam(value = "level", required = false, defaultValue = "0") int level, GymQnABoard gymqnaboard,
			@RequestParam(value = "receiver", required = false, defaultValue = "1") int receiver) {

		ModelAndView mv = new ModelAndView("admin/boardlist/qnaboard");

		int gymrequest = adminService.RequestCount(level);
		int message = adminService.Message(receiver);

		ArrayList<User> gymRlist = adminService.GymRequest(level);
		ArrayList<GymQnABoard> qnalist = adminService.GymQnABoard(receiver);
		ArrayList<CommunityBoard> list = adminService.qnaListView();

		mv.addObject("gymrequest", gymrequest);
		mv.addObject("message", message);
		mv.addObject("gymRlist", gymRlist);
		mv.addObject("qnalist", qnalist);
		mv.addObject("list", list);

		return mv;
	}

	// reviewBoard 리스트 출력
	@RequestMapping(value = "adminReviewBoard.do")
	public ModelAndView reviewBoardListMethod(User user, BusinessRequest businessRequest,
			@RequestParam(value = "level", required = false, defaultValue = "0") int level, GymQnABoard gymqnaboard,
			@RequestParam(value = "receiver", required = false, defaultValue = "1") int receiver) {

		ModelAndView mv = new ModelAndView("admin/boardlist/reviewboard");

		int gymrequest = adminService.RequestCount(level);
		int message = adminService.Message(receiver);

		ArrayList<User> gymRlist = adminService.GymRequest(level);
		ArrayList<GymQnABoard> qnalist = adminService.GymQnABoard(receiver);
		ArrayList<CommunityBoard> list = adminService.reviewListView();

		mv.addObject("gymrequest", gymrequest);
		mv.addObject("message", message);
		mv.addObject("gymRlist", gymRlist);
		mv.addObject("qnalist", qnalist);
		mv.addObject("list", list);
		return mv;
	}

	// 등록된 헬스장 리스트 출력
	@RequestMapping(value = "adminfindgym.do")
	public ModelAndView GymListMethod() {
		ModelAndView mv = new ModelAndView("#");

		return mv;
	}

	// 관리자가 회원상태 비활성화
	@RequestMapping(value = "adminUserState.do")
	public ModelAndView adminUserStateChangeMethod(@RequestParam(value = "user_no") int user_no,
			HttpServletRequest request) {
		System.out.println("넘어옴?");
		System.out.println(user_no);
		ModelAndView mv = new ModelAndView("admin/userlist/userlist");
		adminService.adminUserStateChange(user_no);

		mv.setViewName("jsonView");
		return mv;
	}

	// 관리자가 회원상태 활성화
	@RequestMapping(value = "adminUserBack.do")
	public ModelAndView adminUserStateBackMethod(@RequestParam(value = "user_no") int user_no,
			HttpServletRequest request) {
		System.out.println("넘어옴?");
		System.out.println(user_no);
		ModelAndView mv = new ModelAndView("admin/userlist/userlist");
		adminService.adminUserStateBack(user_no);

		mv.setViewName("jsonView");
		return mv;
	}

	// 관리자가 사업자회원상태 비활성화(계정 비활성화 + 등록된 헬스장도 비활성화)
	@RequestMapping(value = "adminBusinessState.do")
	public ModelAndView adminBusinessStateChangeMethod(@RequestParam(value = "user_no") int user_no,
			HttpServletRequest request) {
		System.out.println("넘어옴?");
		System.out.println(user_no);
		ModelAndView mv = new ModelAndView("admin/userlist/userbusinesslist");
		adminService.adminBusinessStateChange(user_no);

		mv.setViewName("jsonView");
		return mv;
	}

	// 관리자가 사업자회원상태 비활성화(계정 비활성화 + 등록된 헬스장도 비활성화)
	@RequestMapping(value = "adminBusinessBack.do")
	public ModelAndView adminBusinessStateBackMethod(@RequestParam(value = "user_no") int user_no,
			HttpServletRequest request) {
		System.out.println("넘어옴?");
		System.out.println(user_no);
		ModelAndView mv = new ModelAndView("admin/userlist/userbusinesslist");
		adminService.adminBusinessStateBack(user_no);

		mv.setViewName("jsonView");
		return mv;
	}

	// 사용자가 등록요청한 헬스장 관리자에서 승인하기(approval_state 1로 변경)
	@RequestMapping(value = "gymRequest.do")
	public ModelAndView gymRequestMethod(@RequestParam(value = "gym_no") int gym_no, HttpServletRequest request) {
		System.out.println("등록요청넘어옴");
		System.out.println(gym_no);
		ModelAndView mv = new ModelAndView("admin/userlist/userbusinessRequestlist");
		adminService.adminGymRequest(gym_no);

		mv.setViewName("jsonView");
		return mv;
	}

	// 관리자에서 등록된 헬스장 등록취소하기(approval_state 0으로 변경)
	@RequestMapping(value = "gymCancel.do")
	public ModelAndView gymCancelMethod(@RequestParam(value = "gym_no") int gym_no, HttpServletRequest request) {
		System.out.println("등록 취소 요청넘어옴");
		System.out.println(gym_no);
		ModelAndView mv = new ModelAndView("admin/userlist/userbusinessRequestlist");
		adminService.adminGymCancel(gym_no);

		mv.setViewName("jsonView");
		return mv;
	}

	// MeetingBoard 게시글 삭제
	@RequestMapping(value = "meetingBoardDelete.do")
	public ModelAndView meetingBoardDeleteMethod(@RequestParam(value = "mb_no") int mb_no, HttpServletRequest request) {
		
		ModelAndView mv = new ModelAndView("admin/boardlist/meetingboard");
		adminService.meetingBoardDelete(mb_no);

		mv.setViewName("jsonView");
		return mv;
	}

	// QNABoard 게시글 삭제
	@RequestMapping(value = "qnaBoardDelete.do")
	public ModelAndView qnaBoardDeleteMethod(@RequestParam(value = "cb_no") int cb_no, HttpServletRequest request) {
		
		ModelAndView mv = new ModelAndView("admin/boardlist/qnaboard");
		adminService.qnaBoardDelete(cb_no);

		mv.setViewName("jsonView");
		return mv;
	}

	// ReviewBoard 게시글 삭제
	@RequestMapping(value = "reviewBoardDelete.do")
	public ModelAndView reviewBoardDeleteMethod(@RequestParam(value = "cb_no") int cb_no, HttpServletRequest request) {
		
		ModelAndView mv = new ModelAndView("admin/boardlist/reviewboard");
		adminService.reviewBoardDelete(cb_no);

		mv.setViewName("jsonView");
		return mv;
	}

	// 문의함 페이지 이동
	@RequestMapping(value = "adminQuestionBoard.do")
	public ModelAndView adminBoardMethod(User user, BusinessRequest businessRequest,
			@RequestParam(value = "level", required = false, defaultValue = "0") int level, GymQnABoard gymqnaboard,
			@RequestParam(value = "receiver", required = false, defaultValue = "1") int receiver) {

		ModelAndView mv = new ModelAndView("admin/adminBoard");

		int gymrequest = adminService.RequestCount(level);
		int message = adminService.Message(receiver);

		ArrayList<User> gymRlist = adminService.GymRequest(level);
		ArrayList<GymQnABoard> qnalist = adminService.GymQnABoard(receiver);
		ArrayList<GymQnABoard> list = adminService.adminBoard();

		mv.addObject("gymrequest", gymrequest);
		mv.addObject("message", message);
		mv.addObject("gymRlist", gymRlist);
		mv.addObject("qnalist", qnalist);
		mv.addObject("list", list);

		return mv;
	}

	//관리자 - MeetingBoard에 공지사항 글쓰기
	@RequestMapping(value = "/adminmeetingInsert.do", method = RequestMethod.POST)
	public String adminMeetingInsertMethod(MeetingBoard mboard) {
		System.out.println(mboard);

		int result = adminService.meetingBoardInsert(mboard);
		if (result > 0) {
			return "redirect:adminMettingBoard.do";
		} else {
			return "redirect:adminMettingBoard.do";
		}

	}

	//관리자 - QnABoard에 공지사항 글쓰기
	@RequestMapping(value = "/adminqnaInsert.do", method = RequestMethod.POST)
	public String adminQnaInsertMethod(CommunityBoard cboard) {
		System.out.println(cboard);

		int result = adminService.qnaBoardInsert(cboard);
		if (result > 0) {
			return "redirect:adminQNABoard.do";
		} else {
			return "redirect:adminQNABoard.do";
		}

	}

	//관리자 - ReviewBoard에 공지사항 글쓰기
	@RequestMapping(value="/adminreviewInsert.do", method=RequestMethod.POST)
	public String adminReviewInsertMethod(CommunityBoard cboard){
		System.out.println(cboard);
	
		int result = adminService.reviewBoardInsert(cboard);
		if(result>0){
			return "redirect:adminReviewBoard.do";
		}else{
			return "redirect:adminReviewBoard.do";
		}
		
	}
		
	//관리자 - 문의에 대한 답변 쓰기
	@RequestMapping(value="/qnaResponse.do", method=RequestMethod.POST)
	public String qnaResponseMethod(GymQnABoard gqboard, int responseQ_no){
		System.out.println("response_state 바꿔야할 q_no(답변된 q_no): " +responseQ_no);
		System.out.println("gqboard : "+gqboard);
		adminService.qnaBoardUpdate(responseQ_no);
		int result = adminService.qnaResponse(gqboard);
		if(result>0){
			return "redirect:adminQuestionBoard.do";
		}else{
			return "redirect:adminQuestionBoard.do";
		}
			
	}	
	
	
	@RequestMapping(value="userDetail.do")
	public ModelAndView userDetailMethod(User u, Like l, HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView mv = new ModelAndView("admin/userlist/userDetail");
		
		User user = adminService.userDetail(u);
		Like like = adminService.likeDetail(l);
		
		mv.addObject("user", user);
		mv.addObject("like", like);
		
		return mv;
	}
	
	
	/*public void sessionCreated(HttpSessionEvent sessionEve) {

		if (sessionEve.getSession().isNew()) {
			execute(sessionEve);
		}
	}

	private void execute(HttpSessionEvent sessionEve) {

		// 방문자 수 증가
		adminService.visitCount();

		// 총 방문자 수
		int totalCount = adminService.getTotalCount();

		// 오늘 방문자 수
		int todayCount = adminService.getTodayCount();

		HttpSession session = sessionEve.getSession();
		session.setAttribute("totalCount", totalCount);
		session.setAttribute("todayCount", todayCount);
		
		
	}*/
		
	// footer 관리자에게 문의 보내기
	@RequestMapping(value="/adminQnAInsert.do", method=RequestMethod.POST)
	public ModelAndView userUpdateMethod(GymQnABoard b, ModelAndView mv, HttpServletRequest request) {
		gymService.insertGymQnABoard(b, 2);
		mv.setViewName("jsonView");
		return mv; 
	}
}
