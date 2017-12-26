package com.kh.fitnessground.community.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.fitnessground.community.model.service.CommunityBoardService;
import com.kh.fitnessground.community.model.vo.CommunityBoard;
import com.kh.fitnessground.community.model.vo.CommunityComment;
import com.kh.fitnessground.community.model.vo.MeetingBoard;
import com.kh.fitnessground.community.model.vo.MeetingComment;

@Controller
public class CommunityBoardController {
	@Autowired
	private CommunityBoardService communityBoardService;

	// 리스트
	@RequestMapping(value = "community.do", method = RequestMethod.GET)
	public ModelAndView communityBoard(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("community/communityMain");
		ArrayList<MeetingBoard> mlist = communityBoardService.meetingView();
		ArrayList<CommunityBoard> rlist = communityBoardService.reviewView();
		ArrayList<CommunityBoard> qlist = communityBoardService.qnaView();
		mv.addObject("mlist", mlist);
		mv.addObject("rlist", rlist);
		mv.addObject("qlist", qlist);
		return mv;
	}

	// 운동같이해요
	// 게시판----------------------------------------------------------------------------------------------------
	// 리스트 검색
	@RequestMapping(value = "meeting.do")
	public ModelAndView meetingBoard(@RequestParam(value = "searchOption", required = false, defaultValue = "") String searchOption,
									 @RequestParam(value = "searchKey", required = false, defaultValue = "") String searchKey) {
		ModelAndView mv = new ModelAndView("community/meetingBoard/meetingBoard");
		int currentPage = 1;
		int limit = 10;

		List<MeetingBoard> list = communityBoardService.meetingListView(currentPage, limit, searchOption, searchKey);
		System.out.println("list : " + list);
		Map<String, Object> map = new HashMap<String, Object>();
		int listCount = communityBoardService.getMeetingListCount();

		int maxPage = (int) ((double) listCount / limit + 0.9);

		int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;

		int endPage = startPage + limit - 1;

		if (maxPage < endPage)
			endPage = maxPage;

		map.put("currentPage", currentPage);
		map.put("listCount", listCount);
		map.put("maxPage", maxPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("limit", limit);
		map.put("list", list);

		mv.addObject("meeting", map);

		return mv;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "meetingLoadlist.do")
	@ResponseBody
	public ModelAndView meetingLoadList(ModelAndView mv, @RequestParam("page") int page,
			@RequestParam(value = "searchOption", required = false, defaultValue = "") String searchOption,
			@RequestParam(value = "searchKey", required = false, defaultValue = "") String searchKey) {
		// = new ModelAndView("community/meetingBoard/meetingBoard");

		int currentPage = page;
		int limit = 10;
		List<MeetingBoard> list = communityBoardService.meetingListView(currentPage, limit, searchOption, searchKey);

		Map<String, Object> map = new HashMap<String, Object>();
		int listCount = communityBoardService.getMeetingListCount();

		int maxPage = (int) ((double) listCount / limit + 0.9);

		int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;

		int endPage = startPage + limit - 1;

		if (maxPage < endPage)
			endPage = maxPage;

		map.put("searchOption", searchOption);
		map.put("searchKey", searchKey);
		map.put("currentPage", currentPage);
		map.put("listCount", listCount);
		map.put("maxPage", maxPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("limit", limit);

		JSONArray jar = new JSONArray();

		for (MeetingBoard mb : list) {
			JSONObject jmb = new JSONObject();
			jmb.put("mb_no", mb.getMb_no());
			jmb.put("user_no", mb.getUser_no());
			jmb.put("title", mb.getTitle());
			jmb.put("content", mb.getContent());
			jmb.put("meeting_location", mb.getMeeting_location());
			jmb.put("meeting_date", mb.getMeeting_date().toString());
			jmb.put("upload_date", mb.getUpload_date().toString());
			jmb.put("readcount", mb.getReadcount());
			jmb.put("name", mb.getName());
			jar.add(jmb);

		}

		map.put("list", jar);
		mv.addAllObjects(map);

		mv.setViewName("jsonView");

		return mv;
	}

	// 글쓰기페이지 이동
	@RequestMapping(value = "meetingInsert.do", method = RequestMethod.GET)
	public String meetingInsert() {
		return "community/meetingBoard/meetingInsert";
	}

	// 글쓰기페이지 저장
	@RequestMapping(value = "meetingInsert.do", method = RequestMethod.POST)
	public String meetingInsertPage(MeetingBoard meeting) {
		System.out.println(meeting);
		int result = communityBoardService.meetingInsert(meeting);
		// 1이상 result 값이면 리스트로이동
		if (result > 0) {
			return "redirect:/meeting.do";
		} else {
			return "community/meetingBoard/error";
		}
	}

	// 디테일
	@RequestMapping(value = "meetingDetail.do", method = RequestMethod.GET)
	public ModelAndView meetingDetail(@RequestParam(value = "no") int no, HttpServletRequest request) {
		// 조회수 증가 처리
		communityBoardService.meetingCount(no, request);

		ModelAndView mv = new ModelAndView("community/meetingBoard/meetingDetail");
		MeetingBoard meeting = communityBoardService.meetingDetail(no);
		mv.addObject("meeting", meeting);
		return mv;
	}

	// 삭제하기
	@RequestMapping(value = "meetingDelete.do")
	public String meetingDelete(@RequestParam int no) {
		communityBoardService.meetingDelete(no);
		return "redirect:meeting.do";
	}

	// 수정하기글작성페이지로
	@RequestMapping(value = "meetingUpdate.do")
	public ModelAndView meetingUpdate(@RequestParam int no) {
		ModelAndView mv = new ModelAndView("community/meetingBoard/meetingUpdate");
		MeetingBoard meeting = communityBoardService.meetingUpdate(no);
		mv.addObject("meeting", meeting);
		return mv;
	}

	// 수정하기완료
	@RequestMapping(value = "meetingUpdate.do", method = RequestMethod.POST)
	public ModelAndView meetingUpdatePage(MeetingBoard meeting) {
		System.out.println(meeting.getMb_no());
		ModelAndView mv = new ModelAndView("community/meetingBoard/meetingDetail");
		int resultUpdate = communityBoardService.meetingUpdatePage(meeting);
		String result = null;
		if (resultUpdate > 0) {
			result = "성공적으로 수정하였습니다.";
		} else {
			result = "수정에 실패하였습니다.";
		}
		MeetingBoard meetingOrigin = communityBoardService.meetingDetail(meeting.getMb_no());
		mv.addObject("result", result);
		mv.addObject("meeting", meetingOrigin);
		return mv;
	}

	// qna
	// 게시판-------------------------------------------------------------------------------------------------------
	// 리스트
	@RequestMapping(value = "qna.do")
	public ModelAndView qnaBoard(@RequestParam(value = "searchOption", required = false, defaultValue = "") String searchOption,
								 @RequestParam(value = "searchKey", required = false, defaultValue = "") String searchKey) {
		ModelAndView mv = new ModelAndView("community/qnaBoard/qnaBoard");
		int currentPage = 1;
		int limit = 10;

		List<CommunityBoard> list = communityBoardService.qnaListView(currentPage, limit, searchOption, searchKey);
		System.out.println("list = " + list);

		Map<String, Object> map = new HashMap<String, Object>();
		// 갯수
		int listCount = communityBoardService.getQnAListCount();

		int maxPage = (int) ((double) listCount / limit + 0.9);

		int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;

		int endPage = startPage + limit - 1;

		if (maxPage < endPage)
			endPage = maxPage;

		map.put("currentPage", currentPage);
		map.put("listCount", listCount);
		map.put("maxPage", maxPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("limit", limit);
		map.put("list", list);

		mv.addObject("qna", map);

		return mv;
	}

	// json 리스트
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "qnaLoadList.do")
	@ResponseBody
	public ModelAndView qnaLoadList(ModelAndView mv, @RequestParam("page") int page,
						@RequestParam(value = "searchOption", required = false, defaultValue = "") String searchOption,
						@RequestParam(value = "searchKey", required = false, defaultValue = "") String searchKey) {

		int currentPage = page;
		int limit = 10;
		List<CommunityBoard> list = communityBoardService.qnaListView(currentPage, limit, searchOption, searchKey);

		Map<String, Object> map = new HashMap<String, Object>();

		int listCount = communityBoardService.getQnAListCount();

		int maxPage = (int) ((double) listCount / limit + 0.9);

		int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;

		int endPage = startPage + limit - 1;

		if (maxPage < endPage)
			endPage = maxPage;

		map.put("searchOption", searchOption);
		map.put("searchKey", searchKey);
		map.put("listCount", listCount);
		map.put("maxPage", maxPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("limit", limit);

		JSONArray jar = new JSONArray();

		for (CommunityBoard cb : list) {
			JSONObject jmb = new JSONObject();
			jmb.put("cb_no", cb.getCb_no());
			jmb.put("user_no", cb.getUser_no());
			jmb.put("title", cb.getTitle());
			jmb.put("content", cb.getContent());
			jmb.put("board_property", cb.getBoard_property());
			jmb.put("upload_date", cb.getUpload_date().toString());
			jmb.put("readcount", cb.getReadcount());
			jmb.put("name", cb.getName());

			jar.add(jmb);
		}

		map.put("list", jar);
		mv.addAllObjects(map);
		mv.setViewName("jsonView");

		return mv;
	}

	// 글쓰기 페이지로 이동
	@RequestMapping(value = "qnaInsert.do", method = RequestMethod.GET)
	public String qnaInsert() {
		return "community/qnaBoard/qnaInsert";
	}

	// 글쓰기페이지 저장
	@RequestMapping(value = "qnaInsert.do", method = RequestMethod.POST)
	public String qnaInsertPage(CommunityBoard community) {
		int result = communityBoardService.qnaInsert(community);
		if (result > 0)
			return "redirect:/qna.do";
		else {
			return "System.out.println('에러발생')";

		}
	}

	// 디테일
	@RequestMapping(value = "qnaDetail.do", method = RequestMethod.GET)
	public ModelAndView qnaDetail(@RequestParam(value = "no") int no, HttpServletRequest request) {
		// 조회수 증가 처리
		communityBoardService.communityCount(no, request);

		ModelAndView mv = new ModelAndView("community/qnaBoard/qnaDetail");
		CommunityBoard community = communityBoardService.qnaDetail(no);
		mv.addObject("community", community);
		return mv;
	}

	// 삭제
	@RequestMapping(value = "qnaDelete.do")
	public String qnaDelete(@RequestParam int no) {
		communityBoardService.qnaDelete(no);
		return "redirect:/qna.do";
	}

	// 수정하기글작성페이지로
	@RequestMapping(value = "qnaUpdate.do")
	public ModelAndView qnaUpdate(@RequestParam int no) {
		ModelAndView mv = new ModelAndView("community/qnaBoard/qnaUpdate");
		CommunityBoard community = communityBoardService.qnaUpdate(no);
		mv.addObject("community", community);
		return mv;
	}

	// 수정하기완료
	@RequestMapping(value = "qnaUpdate.do", method = RequestMethod.POST)
	public ModelAndView qnaUpdatePage(CommunityBoard community) {
		System.out.println(community.getCb_no());
		ModelAndView mv = new ModelAndView("community/qnaBoard/qnaDetail");
		int resultUpdate = communityBoardService.qnaUpdatePage(community);
		String result = null;
		if (resultUpdate > 0) {
			result = "성공적으로 수정하였습니다.";
		} else {
			result = "수정에 실패하였습니다.";
		}
		CommunityBoard communityOrigin = communityBoardService.qnaDetail(community.getCb_no());
		mv.addObject("result", result);
		mv.addObject("community", communityOrigin);
		return mv;
	}

	// 리뷰
	// 게시판-------------------------------------------------------------------------------------------------------
	// 리스트,검색
	@RequestMapping(value = "review.do")
	public ModelAndView reviewBoard(
			@RequestParam(value = "searchOption", required = false, defaultValue = "") String searchOption,
			@RequestParam(value = "searchKey", required = false, defaultValue = "") String searchKey) {

		ModelAndView mv = new ModelAndView("community/reviewBoard/reviewBoard");
		int currentPage = 1;
		int limit = 10;

		List<CommunityBoard> list = communityBoardService.reviewListView(currentPage, limit, searchOption, searchKey);
		Map<String, Object> map = new HashMap<String, Object>();
		// 갯수
		int listCount = communityBoardService.getReviewListCount();

		int maxPage = (int) ((double) listCount / limit + 0.9);

		int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;

		int endPage = startPage + limit - 1;

		if (maxPage < endPage)
			endPage = maxPage;

		map.put("currentPage", currentPage);
		map.put("listCount", listCount);
		map.put("maxPage", maxPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("limit", limit);
		map.put("list", list);

		mv.addObject("review", map);

		return mv;
	}

	// json 리스트
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "reviewLoadList.do")
	@ResponseBody
	public ModelAndView reviewLoadList(ModelAndView mv, @RequestParam("page") int page,
			@RequestParam(value = "searchOption", required = false, defaultValue = "") String searchOption,
			@RequestParam(value = "searchKey", required = false, defaultValue = "") String searchKey) {
		
		int currentPage = page;
		int limit = 10;
		List<CommunityBoard> list = communityBoardService.reviewListView(currentPage, limit, searchOption, searchKey);

		Map<String, Object> map = new HashMap<String, Object>();

		int listCount = communityBoardService.getReviewListCount();

		int maxPage = (int) ((double) listCount / limit + 0.9);

		int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;

		int endPage = startPage + limit - 1;

		if (maxPage < endPage)
			endPage = maxPage;

		map.put("searchOption", searchOption);
		map.put("searchKey", searchKey);
		map.put("currentPage", currentPage);
		map.put("listCount", listCount);
		map.put("maxPage", maxPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("limit", limit);

		JSONArray jar = new JSONArray();

		for (CommunityBoard cb : list) {
			JSONObject jmb = new JSONObject();
			jmb.put("cb_no", cb.getCb_no());
			jmb.put("user_no", cb.getUser_no());
			jmb.put("title", cb.getTitle());
			jmb.put("content", cb.getContent());
			jmb.put("upload_date", cb.getUpload_date().toString());
			jmb.put("board_property", cb.getBoard_property());
			jmb.put("readcount", cb.getReadcount());
			jmb.put("name", cb.getName());

			jar.add(jmb);
		}
		System.out.println(jar);
		map.put("list", jar);
		mv.addAllObjects(map);
		mv.setViewName("jsonView");

		return mv;
	}

	// 글쓰기페이지 이동
	@RequestMapping(value = "reviewInsert.do", method = RequestMethod.GET)
	public String reviewInsert() {
		return "community/reviewBoard/reviewInsert";
	}

	// 글쓰기페이지 저장
	@RequestMapping(value = "reviewInsert.do", method = RequestMethod.POST)
	public String reviewInsertPage(CommunityBoard community) {
		System.out.println(community);
		int result = communityBoardService.reviewInsert(community);
		// 1이상 result 값이면 리스트로이동
		if (result > 0) {
			return "redirect:/review.do";
		} else {
			return "community/CommunityBoard/error";
		}
	}

	// 디테일
	@RequestMapping(value = "reviewDetail.do", method = RequestMethod.GET)
	public ModelAndView reviewDetail(@RequestParam(value = "no") int no, HttpServletRequest request) {
		// 조회수 증가 처리
		communityBoardService.communityCount(no, request);

		ModelAndView mv = new ModelAndView("community/reviewBoard/reviewDetail");
		CommunityBoard community = communityBoardService.reviewDetail(no);
		mv.addObject("community", community);
		return mv;
	}

	// 삭제
	@RequestMapping(value = "reviewDelete.do")
	public String reviewDelete(@RequestParam int no) {
		communityBoardService.reviewDelete(no);
		return "redirect:/review.do";
	}

	// 수정하기글작성페이지로
	@RequestMapping(value = "reviewUpdate.do")
	public ModelAndView reviewUpdate(@RequestParam int no) {
		ModelAndView mv = new ModelAndView("community/reviewBoard/reviewUpdate");
		CommunityBoard community = communityBoardService.reviewUpdate(no);
		mv.addObject("community", community);
		return mv;
	}

	// 수정하기완료
	@RequestMapping(value = "reviewUpdate.do", method = RequestMethod.POST)
	public ModelAndView reviewUpdatePage(CommunityBoard community) {
		System.out.println(community.getCb_no());
		ModelAndView mv = new ModelAndView("community/reviewBoard/reviewDetail");
		int resultUpdate = communityBoardService.reviewUpdatePage(community);
		String result = null;
		if (resultUpdate > 0) {
			result = "성공적으로 수정하였습니다.";
		} else {
			result = "수정에 실패하였습니다.";
		}
		CommunityBoard communityOrigin = communityBoardService.reviewDetail(community.getCb_no());
		mv.addObject("result", result);
		mv.addObject("community", communityOrigin);
		return mv;
	}


	// 운동같이해요 댓글-----------------------------------------------------------------------------------------------------
		//목록
		@SuppressWarnings("unchecked")
		@RequestMapping(value="meetingCommentList.do")
		public ModelAndView meetingCommentList(ModelAndView mv, int mb_no){
			
			List<MeetingComment> mblist = communityBoardService.meetingCommentList(mb_no);
			Map<String,Object> map = new HashMap<String,Object>();
					
			JSONArray jmblist = new JSONArray();
			for(MeetingComment mc : mblist){
				JSONObject jmb = new JSONObject();
				jmb.put("mbc_no", mc.getMbc_no());
				jmb.put("mb_no", mc.getMb_no());
				jmb.put("content", mc.getContent());
				jmb.put("user_no", mc.getUser_no());
				jmb.put("reply_date", mc.getReply_date().toString());
				jmb.put("name", mc.getName());
				
				jmblist.add(jmb);
			}	
			map.put("mblist", jmblist);
			mv.addAllObjects(map);
			mv.setViewName("jsonView");
			return mv;
		}
		//삽입
		@RequestMapping(value="meetingCommentInsert.do",method=RequestMethod.POST)
		public void meetingCommentInsert(MeetingComment meetingComment){
			communityBoardService.meetingCommentInsert(meetingComment);
		}
		//삭제
		@RequestMapping(value="meetingCommentDelete.do",method=RequestMethod.POST)
		public void meetingCommentDelete(@RequestParam("mbc_no")int mbc_no){
			communityBoardService.meetingCommentDelete(mbc_no);
		}
		
		
		
	// 커뮤니티 게시판 댓글
		//목록
				@SuppressWarnings("unchecked")
				@RequestMapping(value="communityCommentList.do")
				public ModelAndView communityCommentList(ModelAndView mv, int cb_no){
					
					List<CommunityComment> cblist = communityBoardService.communityCommentList(cb_no);
					Map<String,Object> map = new HashMap<String,Object>();
							
					JSONArray jmblist = new JSONArray();
					for(CommunityComment cc : cblist){
						JSONObject jmb = new JSONObject();
						jmb.put("cbc_no", cc.getCbc_no());
						jmb.put("cb_no", cc.getCb_no());
						jmb.put("content", cc.getContent());
						jmb.put("user_no", cc.getUser_no());
						jmb.put("reply_date", cc.getReply_date().toString());
						jmb.put("name", cc.getName());
						
						jmblist.add(jmb);
					}	
					map.put("cblist", jmblist);
					mv.addAllObjects(map);
					mv.setViewName("jsonView");
					return mv;
				}
				//삽입
				@RequestMapping(value="communityCommentInsert.do",method=RequestMethod.POST)
				public void communityCommentInsert(CommunityComment communityComment){
					communityBoardService.communityCommentInsert(communityComment);
				}
				//삭제
				@RequestMapping(value="communityCommentDelete.do",method=RequestMethod.POST)
				public void communityCommentDelete(@RequestParam("cbc_no")int cbc_no){
					communityBoardService.communityCommentDelete(cbc_no);
				}
}
