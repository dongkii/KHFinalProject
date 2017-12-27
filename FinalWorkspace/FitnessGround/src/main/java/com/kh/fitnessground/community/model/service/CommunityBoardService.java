package com.kh.fitnessground.community.model.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.kh.fitnessground.community.model.vo.CommunityBoard;
import com.kh.fitnessground.community.model.vo.CommunityComment;
import com.kh.fitnessground.community.model.vo.MeetingBoard;
import com.kh.fitnessground.community.model.vo.MeetingComment;

public interface CommunityBoardService {

	//메인화면 보드
		//운동같이해요 게시판 게시글 5개씩 보여주는 리스트
			ArrayList<MeetingBoard> meetingView();
			//리뷰 게시판 게시글 5개씩 보여주는 리스트
			ArrayList<CommunityBoard> reviewView();
			//qna게시판 게시글 5개씩 보여주는 리스트
			ArrayList<CommunityBoard> qnaView();
			
		//운동같이해요 게시판
			//게시글 조회수
			void meetingCount(int no, HttpServletRequest request);
			//목록
			List<MeetingBoard> meetingListView(int currentPage, int limit, String searchOption, String searchKey);
			//등록
			int meetingInsert(MeetingBoard meetingboard);
			//삭제
			int meetingDelete(int no);
			//수정페이지로 이동
			MeetingBoard meetingUpdate(int no);
			//수정하기완료
			int meetingUpdatePage(MeetingBoard meeting);
			//디테일
			MeetingBoard meetingDetail(int no);
			//게시글 갯수
			int getMeetingListCount(String searchOption, String searchKey);
		//운동같이해요 게시판 댓글
			//목록
			List<MeetingComment> meetingCommentList(int mb_no);
			//입력
			void meetingCommentInsert(MeetingComment meetingComment);
			//삭제
			void meetingCommentDelete(int mbc_no);
			
			
		//리뷰 게시판
			//목록,검색
				List<CommunityBoard> reviewListView(int currentPage, int limit, String searchOption, String searchKey);
				//등록
				int reviewInsert(CommunityBoard communityboard);
				//삭제
				int reviewDelete(int no);
				//수정
				CommunityBoard reviewUpdate(int no);
				//수정 완료
				int reviewUpdatePage(CommunityBoard community);
				//디테일
				CommunityBoard reviewDetail(int no);
				//게시글 갯수
				int getReviewListCount(String searchOption, String searchKey);
			
		//qna 게시판
				//게시글 조회수
					void communityCount(int no, HttpServletRequest request);
				//목록
					List<CommunityBoard> qnaListView(int currentPage, int limit, String searchOption, String searchKey);
					//등록
					int qnaInsert(CommunityBoard communityboard);
					//삭제
					int qnaDelete(int no);
					//수정
					CommunityBoard qnaUpdate(int no);
					//수정 완료
					int qnaUpdatePage(CommunityBoard community);
					//디테일
					CommunityBoard qnaDetail(int no);
					//게시글 갯수
					int getQnAListCount(String searchOption, String searchKey);
		//커뮤니티 게시판 댓글	
					//목록
					List<CommunityComment> communityCommentList(int cb_no);
					//삽입
					void communityCommentInsert(CommunityComment communityComment);
					//삭제
					void communityCommentDelete(int cbc_no);
				
				
					 
					 
					
					
					
					
				
				
}
