package com.kh.fitnessground.community.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.fitnessground.community.model.vo.CommunityBoard;
import com.kh.fitnessground.community.model.vo.CommunityComment;
import com.kh.fitnessground.community.model.vo.MeetingBoard;
import com.kh.fitnessground.community.model.vo.MeetingComment;


@Repository("CommunityBoardDao")
public class CommunityBoardDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	//메인 게시판
	public ArrayList<MeetingBoard> meetingView() {
		List<MeetingBoard> mblist = sqlSession.selectList("community.meetingView");
		ArrayList<MeetingBoard> mlist = new ArrayList<MeetingBoard>(mblist);
		return mlist;
	}

	public ArrayList<CommunityBoard> reviewView() {
		List<CommunityBoard> rblist = sqlSession.selectList("community.reviewView");
		ArrayList<CommunityBoard> rlist = new ArrayList<CommunityBoard>(rblist);
		return rlist;
	}
	public ArrayList<CommunityBoard> qnaView() {
		List<CommunityBoard> qblist = sqlSession.selectList("community.qnaView");
		ArrayList<CommunityBoard> qlist = new ArrayList<CommunityBoard>(qblist);
		return qlist;
	}
	
	
	//운동같이해요 게시판-----------------------------------------------------------------------------------------------------------------
	
	public void meetingCount(int no) {
		sqlSession.update("community.meetingCount", no);
    }

	public List<MeetingBoard> meetingListView(int startRow, int endRow, String searchOption, String searchKey) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("startRow", startRow); 
	     map.put("endRow", endRow);
	     map.put("searchKey", "%" + searchKey + "%");  
	     if(searchOption.equals("content")){
	    	 return sqlSession.selectList("community.meetingContentSearch", map);
	     }
	     else if(searchOption.equals("title")) {
	         return sqlSession.selectList("community.meetingTitleSearch", map);
	      }else if(searchOption.equals("name")){
	         return sqlSession.selectList("community.meetingNameSearch", map);
	      }else
    	    return sqlSession.selectList("community.meetingListView", map);
	}

	public int meetingInsert(MeetingBoard meetingboard) {
		int result = sqlSession.insert("community.insertMeeting",meetingboard);		
		return result;
	}

	public int meetingDelete(int no) {
		return sqlSession.delete("community.deleteMeeting", no);
	}

	//수정하기 페이지로 이동
		public MeetingBoard meetingUpdate(int no) {
			MeetingBoard meeting = sqlSession.selectOne("community.updateMeeting", no);
			return meeting;
		}
		//수정하기 완룡 ㅎㅎ
		public int meetingUpdatePage(MeetingBoard meetingBoard) {
			int result = sqlSession.update("community.updateMeetingPage", meetingBoard);
			System.out.println(result);
			return result;
		}
		

	public MeetingBoard meetingDetail(int no) {
		MeetingBoard meeting = sqlSession.selectOne("community.selectDetail", no);
		return meeting;
	}

	public int getMeetingListCount(String searchOption, String searchKey) {
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("searchKey", "%" + searchKey + "%");
		if(searchOption.equals("title")){
			return sqlSession.selectOne("community.getMeetingTitleCount", map);
		}else if(searchOption.equals("name")){
		return sqlSession.selectOne("community.getMeetingNameCount", map);
		}else if(searchOption.equals("content")){
			return sqlSession.selectOne("community.getMeetingContentCount", map);
		}else
			return sqlSession.selectOne("community.getMeetingListCount", map);
	}

	
	

		
	//운동같이해요 게시판 댓글-----------------------------------------------------------------------
	// 댓글 목록
		public List<MeetingComment> meetingCommentList(int mb_no) {
		return sqlSession.selectList("community.meetingCommentList", mb_no);
	}
	// 댓글 삽입
		public void meetingCommentInsert(MeetingComment meetingComment){
			sqlSession.insert("community.meetingCommentInsert", meetingComment);
		}
		
	// 댓글 삭제
		public void meetingCommentDelete(int mbc_no){
			sqlSession.delete("community.meetingCommentDelete", mbc_no);
		}
	
	//리뷰 게시판-------------------------------------------------------------------------------------------------------------------
	public List<CommunityBoard> reviewListView(int startRow, int endRow, String searchOption, String searchKey) {
		Map<String, Object> map = new HashMap<String, Object>();
		 map.put("startRow", startRow); 
	     map.put("endRow", endRow);
	     map.put("searchKey", "%" + searchKey + "%");  
	     if(searchOption.equals("content")){
	    	 return sqlSession.selectList("community.reviewContentSearch", map);
	     }
	     else if(searchOption.equals("title")) {
	         return sqlSession.selectList("community.reviewTitleSearch", map);
	      }else if(searchOption.equals("name")){
	         return sqlSession.selectList("community.reviewNameSearch", map);
	      }else
	    	 return sqlSession.selectList("community.reviewListView", map);
	}

	public int reviewInsert(CommunityBoard communityboard) {
		int result = sqlSession.insert("community.insertReview",communityboard);		
		return result;
	}
	public int reviewDelete(int no) {
		return sqlSession.delete("community.deleteReview", no);
	}

	public CommunityBoard reviewUpdate(int no) {
		CommunityBoard community= sqlSession.selectOne("community.updateReview", no);
		return community;
	}
	public int reviewUpdatePage(CommunityBoard community) {
		int result = sqlSession.update("community.updateReviewPage", community);
		System.out.println(result);
		return result;
	}
	public CommunityBoard reviewDetail(int no) {
		CommunityBoard community = sqlSession.selectOne("community.reviewDetail", no);
		return community;
	}
	
	public int getReviewListCount(String searchOption, String searchKey) {
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("searchKey", "%" + searchKey + "%");
		if(searchOption.equals("title")){
			return sqlSession.selectOne("community.getReviewTitleCount", map);
		}else if(searchOption.equals("name")){
		return sqlSession.selectOne("community.getReviewNameCount", map);
		}else if(searchOption.equals("content")){
			return sqlSession.selectOne("community.getReviewContentCount", map);
		}else
			return sqlSession.selectOne("community.getReviewListCount", map);
	}

	//qna 게시판--------------------------------------------------------------------------------------
	
	public void communityCount(int no) {
		sqlSession.update("community.communityCount", no);
    }
	
	public List<CommunityBoard> qnaListView(int startRow, int endRow, String searchOption, String searchKey) {
		Map<String, Object> map = new HashMap<String, Object>();
		 map.put("startRow", startRow); 
	     map.put("endRow", endRow);
	     map.put("searchKey", "%" + searchKey + "%");  
	     if(searchOption.equals("content")){
	    	 return sqlSession.selectList("community.qnaContentSearch", map);
	     }
	     else if(searchOption.equals("title")) {
	         return sqlSession.selectList("community.qnaTitleSearch", map);
	      }else if(searchOption.equals("name")){
	         return sqlSession.selectList("community.qnaNameSearch", map);
	      }else
	    	 return sqlSession.selectList("community.qnaListView", map);
	      	
	}
	
	public int qnaInsert(CommunityBoard communityboard) {
		int result = sqlSession.insert("community.insertQnA", communityboard);
		return result;
	}
	
	public int qnaDelete(int no) {
		return sqlSession.delete("community.deleteQnA", no);
	}

	public CommunityBoard qnaUpdate(int no) {
		CommunityBoard community= sqlSession.selectOne("community.updateQnA", no);
		return community;
	}
	public int qnaUpdatePage(CommunityBoard community) {
		int result = sqlSession.update("community.updateQnAPage", community);
		System.out.println(result);
		return result;
	}


	public CommunityBoard qnadDetail(int no) {
		CommunityBoard community = sqlSession.selectOne("community.qnaDetail", no);
		return community;
	}
	
	
	public int getQnAListCount(String searchOption, String searchKey) {
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("searchKey", "%" + searchKey + "%");
		if(searchOption.equals("title")){
			return sqlSession.selectOne("community.getQnATitleCount", map);
		}else if(searchOption.equals("name")){
		return sqlSession.selectOne("community.getQnANameCount", map);
		}else if(searchOption.equals("content")){
			return sqlSession.selectOne("community.getQnAContentCount", map);
		}else
			return sqlSession.selectOne("community.getQnAListCount", map);
	}

	//qna 게시판 댓글--------------------------------------------------------------------------------------------------
	
	public List<CommunityComment> communityCommentList(int cb_no) {
		return sqlSession.selectList("community.communityCommentList", cb_no);
	}

	public void communityCommentInsert(CommunityComment communityComment) {
		sqlSession.insert("community.communityCommentInsert", communityComment);
	}

	public void communityCommentDelete(int cbc_no) {
		sqlSession.delete("community.communityCommentDelete", cbc_no);
	}


	

	
	
		
}
