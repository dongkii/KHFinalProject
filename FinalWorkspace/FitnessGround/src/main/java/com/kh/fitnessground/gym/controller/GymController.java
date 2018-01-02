package com.kh.fitnessground.gym.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.synth.SynthSeparatorUI;

import org.apache.commons.io.FileUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.fitnessground.common.util.GymFileUtils;
import com.kh.fitnessground.common.util.GymImageUtils;
import com.kh.fitnessground.community.model.vo.MeetingBoard;
import com.kh.fitnessground.gym.model.service.GymService;
import com.kh.fitnessground.gym.model.vo.Gym;
import com.kh.fitnessground.gym.model.vo.GymComment;
import com.kh.fitnessground.gym.model.vo.GymQnABoard;
import com.kh.fitnessground.gym.model.vo.GymSchedule;
import com.kh.fitnessground.gym.model.vo.NaverMap;
import com.kh.fitnessground.gym.model.vo.PublicGym;
import com.kh.fitnessground.workout.health.model.vo.Health;

import oracle.sql.DATE;



@Controller
public class GymController {
	@Autowired
	private GymService gymService;
	@Autowired
	private GymImageUtils gymImageUtils;
	@Autowired
	private GymFileUtils gymFileUtils;
	
	// 헬스장 이미지 등록
	@RequestMapping(value="/imagereg.do", method=RequestMethod.POST)
	public ModelAndView multiImageUpload(Gym gym, Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Map<String, Object>> list = gymImageUtils.parseInsertFileInfo(request);
		String originalFileName = "";
		String renameFileName = "";
		for(int i = 0; i < list.size()-1; i++) {
			originalFileName += list.get(i).get("original_fileName")+",";
			renameFileName += list.get(i).get("rename_fileName")+",";
		}
		originalFileName += list.get(list.size()-1).get("original_fileName");
		renameFileName += list.get(list.size()-1).get("rename_fileName");
		if(originalFileName != "" || !originalFileName.equals("")) {
			gym.setOriginal_image(originalFileName);
			gym.setRename_image(renameFileName);
		}
		System.out.println(gym);
		gymService.RegisterGymImage(gym);
		ModelAndView mv = new ModelAndView();
		Gym g = gymService.selectfromImg(gym);
		mv.addObject("gym", g);
		mv.setViewName("jsonView");
		return mv;
	}
	
	//헬스장 내용 등록
	@RequestMapping(value="/contentreg.do", method=RequestMethod.POST)
	public void registerGym(Gym gym, HttpServletRequest request, HttpServletResponse response) {
		gymService.RegisterGymContent(gym);
	}
	
	//헬스장 일정 등록
	@RequestMapping(value="/OneSchedule.do", method=RequestMethod.POST)
	public void OneSchedule(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		GymSchedule gs = new GymSchedule();
		java.util.Date utilDate = new java.util.Date();
		
		gs.setGym_no(Integer.parseInt(request.getParameter("gym_no")));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		utilDate = sdf.parse(request.getParameter("day"));
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		gs.setDay(sqlDate);
		
		gs.setSchedule_time(request.getParameter("schedule_time"));
		gs.setTitle(request.getParameter("title"));
		gymService.OneSchedule(gs);
	}
	
	//등록한 헬스장 갯수 및 리스트
	@RequestMapping(value="/mygymlist.do", method=RequestMethod.POST)
	public ModelAndView mygymlist(Gym gym, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		int gymcount = gymService.regCount(gym);
		ArrayList<Gym> list = gymService.mygymlist(gym);
		System.out.println(list);
		mv.addObject("gymcount", gymcount);
		mv.addObject("list", list);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 검색한 헬스장 갯수 및 리스트
	@RequestMapping(value="/gymsearch.do", method=RequestMethod.POST)
	public ModelAndView gymSearch(Gym gym, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		int gymcount = gymService.regCountName(gym);
		ArrayList<Gym> list = gymService.mygymlistName(gym);
		mv.addObject("gymcount", gymcount);
		mv.addObject("list", list);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 헬스장 수정으로 이동
	@RequestMapping(value="/updategym.do")
	public ModelAndView updateGym(Gym gym, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("gym/updategym");
		Gym g = gymService.selectOne(gym);
		mv.addObject("gym", g);
		return mv;
	}
	
	//헬스장 정보 수정
	@RequestMapping(value="/contentup.do")
	public ModelAndView updatecontent(Gym gym){
		ModelAndView mv = new ModelAndView();
		gymService.updatecontent(gym);
		Gym g = gymService.selectOne(gym);
		mv.addObject("gym", g);
		mv.setViewName("jsonView");
		return mv;
	}
	
	//헬스장 위치 변경
	@RequestMapping(value="/locationup.do", method=RequestMethod.POST)
	public ModelAndView updateLocation(Gym gym) {
		ModelAndView mv = new ModelAndView();
		gymService.updateLocation(gym);
		Gym g = gymService.selectOne(gym);
		mv.addObject("gym", g);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 헬스장 이미지 수정
	@RequestMapping(value="/imageup.do", method=RequestMethod.POST)
	public ModelAndView multiImageUpdate(Gym gym, Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Map<String, Object>> list = gymImageUtils.parseInsertFileInfo(request);
		String originalFileName = "";
		String renameFileName = "";
		
		for(int i = 0; i < list.size()-1; i++) {
			originalFileName += list.get(i).get("original_fileName")+",";
			renameFileName += list.get(i).get("rename_fileName")+",";
		}
		originalFileName += list.get(list.size()-1).get("original_fileName");
		renameFileName += list.get(list.size()-1).get("rename_fileName");
		if(originalFileName != "" || !originalFileName.equals("")) {
			gym.setOriginal_image(originalFileName);
			gym.setRename_image(renameFileName);
		}
		System.out.println(gym);
		gymService.updategymimg(gym);
		
		ModelAndView mv = new ModelAndView();
		Gym g = gymService.selectfromImg(gym);
		mv.addObject("gym", g);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 헬스장 삭제
	@RequestMapping(value="/deletegym.do", method=RequestMethod.POST)
	public ModelAndView deleteGym(Gym gym, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		gymService.deleteGym(gym);
		mv.addObject("gym", 1);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 헬스장 디테일 뷰
	@RequestMapping(value="/detailgym.do")
	public ModelAndView detailGym(Gym gym, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("gym/detailgym");
		Gym g = gymService.selectOne(gym);
		mv.addObject("gym", g);
		return mv;
	}
	
	// 헬스장 달력 불러오기
	@RequestMapping(value="/dbschedule.do", method=RequestMethod.POST)
	public ModelAndView dbschedule(GymSchedule gs, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		ArrayList<GymSchedule> list = gymService.dbschedule(gs);
		System.out.println(list);
		mv.addObject("list", list);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 리뷰 등록
	@RequestMapping(value="/reviewinsert.do", method=RequestMethod.POST)
	public ModelAndView enrollReview(GymComment gc, HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView();
		gymService.InserReview(gc);
		mv.setViewName("jsonView");
		return mv;
	}
	
	//리뷰 삭제
	@RequestMapping(value="/deletereview.do", method=RequestMethod.POST)
	public ModelAndView deleteReview(GymComment gc, HttpServletRequest request, HttpServletResponse response){
		ModelAndView mv = new ModelAndView();
		gymService.deleteReview(gc);
		mv.setViewName("jsonView");
		return mv;
	}
	
	//리뷰 셀렉
	@RequestMapping(value="/selectreview.do", method=RequestMethod.POST)
	public ModelAndView selectReview(GymComment gc, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		ArrayList<GymComment> agc = gymService.SelectReview(gc);
		mv.addObject("gc", agc);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// findgym
		@SuppressWarnings("unchecked")
		@RequestMapping(value = "findgym.do")
		@ResponseBody
		public ModelAndView findGym(HttpServletRequest request, HttpServletResponse response) {
			ModelAndView mv = new ModelAndView("findgym/findgym");
			int currentPage = 1;
			int pcurrentPage = 1;
			
			int limit = 3;
			Map<String, Object> map = new HashMap<String, Object>();
			int listCount = gymService.getListCount(); // 헬스장
			int plistCount = gymService.getPublicListCount(); // 공공시설
					
			ArrayList<Gym> list = gymService.healthList(currentPage, limit);
			ArrayList<PublicGym> plist = gymService.publicList(currentPage, limit);
			
			int maxPage = (int) ((double) listCount / limit + 0.9);
			int pmaxPage = (int) ((double) plistCount/ limit + 0.9);
			
			int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;
			int pstartPage = (((int) ((double) pcurrentPage / limit + 0.9)) - 1) * limit + 1;
			
			int endPage = startPage + limit - 1;
			int pendPage = pstartPage + limit - 1;

			if (maxPage < endPage)
				endPage = maxPage;
			
			if(pmaxPage < pendPage)
				pendPage = pmaxPage;
			
			System.out.println("listCount = " + listCount);
			System.out.println(list);
			map.put("currentPage", currentPage);
			map.put("pcurrentPage", pcurrentPage);
			map.put("listCount", listCount);
			map.put("plistCount", plistCount);
			map.put("maxPage", maxPage);
			map.put("pmaxPage", pmaxPage);
			map.put("startPage", startPage);
			map.put("pstartPage", pstartPage);
			map.put("endPage", endPage);
			map.put("pendPage", pendPage);
			map.put("limit", limit);
			
			//map.put("list", list);
			JSONArray jar = new JSONArray();
			String rename = "";
			
			for (Gym gym : list) {
				JSONObject jgym = new JSONObject();
				jgym.put("gym_no", gym.getGym_no());
				jgym.put("gym_name", gym.getGym_name());
				jgym.put("location", gym.getLocation());
				jgym.put("rename_image", gym.getRename_image().toString().split(",")[0]);
				jgym.put("tel", gym.getTel());

				jar.add(jgym);
			}
			map.put("list", jar);
			map.put("plist", plist);
			
			if(request.getParameter("mode")!=null) mv.addObject("mode", request.getParameter("mode"));
			
			mv.addObject("gympage",map);
			
			return mv;
		}

		@SuppressWarnings("unchecked")
		@RequestMapping(value = "findhealth.do")
		@ResponseBody
		public ModelAndView findHealth(ModelAndView mv, @RequestParam("page") int page) {

			int currentPage = page;
			int limit = 3;
			Map<String, Object> map = new HashMap<String, Object>();

			int listCount = gymService.getListCount();
			ArrayList<Gym> list = gymService.healthList(currentPage, limit);

			int maxPage = (int)((double) listCount / limit + 0.9);

			int startPage = (((int)((double) currentPage / limit + 0.9)) - 1) * limit + 1;

			int endPage = startPage + limit - 1;

			if (maxPage < endPage)
				endPage = maxPage;
			
			System.out.println("listCount = " + listCount);
			System.out.println("maxPage =" + maxPage);
			System.out.println("startPage = " + startPage);
			System.out.println("endPage = " + endPage);
			System.out.println(list);

			map.put("currentPage", currentPage);
			map.put("listCount", listCount);
			map.put("maxPage", maxPage);
			map.put("startPage", startPage);
			map.put("endPage", endPage);
			map.put("limit", limit);

			JSONObject sendjson = new JSONObject(); // 전송용 최종 객체
			JSONArray jar = new JSONArray();

			for (Gym gym : list) {
				JSONObject jgym = new JSONObject();
				jgym.put("gym_no", gym.getGym_no());
				jgym.put("gym_name", gym.getGym_name());
				jgym.put("location", gym.getLocation());
				jgym.put("rename_image", gym.getRename_image().split(",")[0]);
				jgym.put("tel", gym.getTel());

				jar.add(jgym);
			}

			map.put("gymlist", jar);

			mv.addAllObjects(map);

			mv.setViewName("jsonView");

			return mv;

		}
		
		@SuppressWarnings("unchecked")
		@RequestMapping(value="findpublic.do")
		@ResponseBody
		public ModelAndView findPublic(ModelAndView mv, @RequestParam("ppage") int page)
		{
			int currentPage = page;
			
			int limit = 3;
			Map<String, Object> map = new HashMap<String, Object>();

			int listCount = gymService.getPublicListCount();
			ArrayList<PublicGym> list = gymService.publicList(currentPage, limit);

			int maxPage = (int)((double) listCount / limit + 0.9);

			int startPage = (((int)((double) currentPage / limit + 0.9)) - 1) * limit + 1;

			int endPage = startPage + limit - 1;

			if (maxPage < endPage)
				endPage = maxPage;
			
			System.out.println("listCount = " + listCount);
			System.out.println("maxPage =" + maxPage);
			System.out.println("startPage = " + startPage);
			System.out.println("endPage = " + endPage);
			System.out.println(list);

			map.put("pcurrentPage", currentPage);
			map.put("plistCount", listCount);
			map.put("pmaxPage", maxPage);
			map.put("pstartPage", startPage);
			map.put("pendPage", endPage);
			map.put("plimit", limit);

			JSONObject sendjson = new JSONObject(); // 전송용 최종 객체
			JSONArray jar = new JSONArray();

			for (PublicGym publicgym : list) {
				JSONObject jpgym = new JSONObject();
				jpgym.put("public_name", publicgym.getPublic_name());
				jpgym.put("location", publicgym.getLocation());
				jpgym.put("homepage", publicgym.getHomepage());
				jpgym.put("tel", publicgym.getTel());

				jar.add(jpgym);
			}

			map.put("publiclist", jar);

			mv.addAllObjects(map);

			mv.setViewName("jsonView");
			return mv;
		}
		
	// 헬스장 문의하기 등록
	@RequestMapping(value="/gymQnAInsert.do")
	public ModelAndView gymQnAInsertMethod(Gym gym, GymQnABoard b, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("gym/detailgym");
		mv.addObject("gym", gymService.selectOne(gym));
		
		List<Map<String, Object>> list = gymFileUtils.parseInsertFileInfo(request);
		String originalFileName = "";
		String renameFileName = "";
		for(int i = 0; i < list.size(); i++) {
			originalFileName += list.get(i).get("original_fileName")+",";
			renameFileName += list.get(i).get("rename_fileName")+",";
		}
		if(originalFileName != "" || !originalFileName.equals("")) {
			b.setOriginal_filename(originalFileName);
			b.setRename_filename(renameFileName);
		}
		gymService.insertGymQnABoard(b, 2);
		return mv; 
	}
	// 헬스장 문의하기 디테일 뷰 ajax
	@RequestMapping(value="/gymQnaDetailView.do")
	public ModelAndView gymQnADetailViewMethod(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("gym/gymQnADetailView");
		GymQnABoard b = gymService.selectGymQnABoard(Integer.parseInt(request.getParameter("q_no")));
		String originalFileName = b.getOriginal_filename();
		String[] originalFileNames;
		if(originalFileName!=null) {
			originalFileNames = originalFileName.split(",");
			int[] index = new int[originalFileNames.length];
			for(int i=0; i<index.length; i++) index[i] = i;
			mv.addObject("originalFileNames", originalFileNames);
		}
		mv.addObject("board", b);
		mv.setViewName("jsonView");
		return mv; 
	}
	// 헬스장 문의하기 파일 다운
	@RequestMapping(value = "/gymQnAFDown.do")
	public void downloadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GymQnABoard board =  gymService.selectGymQnABoard(Integer.parseInt(request.getParameter("bnum")));
		String[] originalFileNames = board.getOriginal_filename().split(",");
		String[] renameFileNames = board.getRename_filename().split(",");
		String fileName = request.getParameter("filename"), originalFileName="", renameFileName="";
		for(int i=0; i<originalFileNames.length; i++) {
			if(fileName.equals(originalFileNames[i])) {
				originalFileName = originalFileNames[i];
				renameFileName = renameFileNames[i];
			}
		}
		byte fileByte[] = FileUtils.readFileToByteArray(new File(request.getSession().getServletContext().getRealPath("/resources/files/gym/") + renameFileName));
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	// 헬스장 문의하기 게시글 삭제
	@RequestMapping(value="/gymQnADel.do")
	public ModelAndView gymQnADeleteMethod(HttpServletRequest request) {
		ModelAndView mv = null;
		if(request.getParameter("mode")!=null && request.getParameter("mode").equals("admin"))
			mv = new ModelAndView("redirect:/adminQuestionBoard.do");
		else
			mv = new ModelAndView("redirect:/userboard.do?userno="+request.getParameter("userno"));
		int q_no = Integer.parseInt(request.getParameter("q_no"));
		GymQnABoard b = gymService.selectGymQnABoard(q_no);
		// 파일 삭제
		String fileNames = b.getRename_filename();
		if(fileNames!=null) {
			String fileName[] = fileNames.split(",");
			System.out.println(fileName);
			if(fileName != null) {
				for(int i=0; i<fileName.length; i++) {
					File file = new File(request.getSession().getServletContext().getRealPath("/resources/files/gym/"+fileName[i]));
					if(file.exists()) file.delete();
				}
			}
		}
		// 게시글 삭제
		gymService.deleteGymQnABoard(q_no);
		if(b.getQ_level() == 1) { // 답변을 삭제할 경우, 원글의 답변여부 상태 변경
			gymService.updateGymQnABoardResponse(b.getRef_no(), 0);
		}
		return mv; 
	}
	// 헬스장 문의하기 게시글 수정
	@RequestMapping(value="/gymQnAUpdate.do")
	public ModelAndView gymQnAUpdateMethod(GymQnABoard b, HttpServletRequest request) throws Exception {
		ModelAndView mv = null;
		if(request.getParameter("mode")!=null && request.getParameter("mode").equals("admin"))
			mv = new ModelAndView("redirect:/adminQuestionBoard.do");
		else
			mv = new ModelAndView("redirect:/userboard.do?userno="+request.getParameter("userno"));
		List<Map<String, Object>> list = gymFileUtils.parseInsertFileInfo(request);
		String originalFileName = "";
		String renameFileName = "";
		for(int i = 0; i < list.size(); i++) {
			originalFileName += list.get(i).get("original_fileName")+",";
			renameFileName += list.get(i).get("rename_fileName")+",";
		}
		if(originalFileName != "" || !originalFileName.equals("")) {
			b.setOriginal_filename(originalFileName);
			b.setRename_filename(renameFileName);
		}
		gymService.updateGymQnABoard(b);
		return mv; 
	}
	// 헬스장 문의하기 게시글 답변
	@RequestMapping(value="/gymQnAAnswer.do")
	public ModelAndView gymQnAAnswerMethod(GymQnABoard b, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/userboard.do?userno="+request.getParameter("userno"));
		List<Map<String, Object>> list = gymFileUtils.parseInsertFileInfo(request);
		String originalFileName = "";
		String renameFileName = "";
		for(int i = 0; i < list.size(); i++) {
			originalFileName += list.get(i).get("original_fileName")+",";
			renameFileName += list.get(i).get("rename_fileName")+",";
		}
		if(originalFileName != "" || !originalFileName.equals("")) {
			b.setOriginal_filename(originalFileName);
			b.setRename_filename(renameFileName);
		}
		gymService.insertGymQnABoardAnswer(b);
		gymService.updateGymQnABoardResponse(b.getQ_no(), 1);		// 답변완료된 게시글
		gymService.updateGymQnABoardResponse(b.getRef_no(), 1);		// 답글 모두 응답여부 1로 바꿈
		return mv; 
	}
	// 관리자 답변 글 번호 조회
	@RequestMapping(value="/adminQnAResponseQNo.do")
	public void adminQnAResponseQNoMethod(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		String responseQ_no = gymService.selectadminQnAResponseQNo(Integer.parseInt(request.getParameter("q_no")));
		out.append(responseQ_no);
		out.flush();
		out.close();
	}
	

	@SuppressWarnings("unchecked")
	@RequestMapping(value="publicmap.do")
	@ResponseBody
	public ModelAndView publicMap(ModelAndView mv, NaverMap nmap)
	{
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<PublicGym> publiclist = gymService.publicMaplist(nmap);
		JSONArray jar = new JSONArray();
		System.out.println("nmap : " + nmap);
		System.out.println(publiclist);
		
		for(PublicGym pgym : publiclist)
		{
			JSONObject jlist = new JSONObject();
			jlist.put("public_name", pgym.getPublic_name());
			jlist.put("location", pgym.getLocation());
			jlist.put("homepage", pgym.getHomepage());
			jlist.put("lat", pgym.getLat());
			jlist.put("lng", pgym.getLng());
			jlist.put("tel", pgym.getTel());
			
			jar.add(jlist);
		}
		map.put("publiclist", jar);
		mv.addAllObjects(map);
		mv.setViewName("jsonView");
		
		return mv;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value="healthmap.do")
	@ResponseBody
	public ModelAndView healthMap(ModelAndView mv)
	{
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<Gym> list = gymService.healthMapList();
		JSONArray jar = new JSONArray();
		
		for(Gym gym : list)
		{
			JSONObject jlist = new JSONObject();
			jlist.put("gym_no", gym.getGym_no());
			jlist.put("gym_name", gym.getGym_name());
			jlist.put("category", gym.getCategory());
			jlist.put("location", gym.getLocation());
			jlist.put("title",gym.getGym_name());
			jlist.put("tel", gym.getTel());
			jlist.put("lat", gym.getLat());
			jlist.put("lng", gym.getLng());
			jlist.put("str_rating", gym.getStr_rating());
			jlist.put("phone", gym.getPhone());
			jar.add(jlist);
		}
		map.put("healthlist", jar);
		mv.addAllObjects(map);
		mv.setViewName("jsonView");
		System.out.println("healthlist: " + map);
		return mv;
	}
	
	@RequestMapping(value="/onegym.do", method=RequestMethod.POST)
	public ModelAndView Onegym(Gym gym,  HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		Gym g = gymService.onegym(gym);
		mv.addObject("gym", g);
		mv.setViewName("jsonView");
		return mv;
	}

}
