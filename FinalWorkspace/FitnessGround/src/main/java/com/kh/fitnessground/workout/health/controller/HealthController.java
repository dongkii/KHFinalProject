package com.kh.fitnessground.workout.health.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.codec.binary.Base64;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import com.kh.fitnessground.workout.commentlike.vo.Comment;
import com.kh.fitnessground.workout.commentlike.vo.Like;
import com.kh.fitnessground.workout.health.model.service.HealthService;
import com.kh.fitnessground.workout.health.model.vo.Health;


@Controller
public class HealthController {
	@Autowired
	private HealthService healthService;
	private static int random = 0;
	
	@RequestMapping(value="/healthMain.do")	//메인 페이지 이동
	public ModelAndView boardListMethod(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView mv = new ModelAndView("workout/healthMain");
		
		return mv;
	}
	
	//헬스 (부위별 영상) ajax 
	@RequestMapping(value="/part.do")	
	public void selectCategorytListMethod(Health health,HttpServletResponse response) throws IOException{
		
		  
		if(random==3){
	        random=0;
	    }
		System.out.println("random 값 : " + random);
		ArrayList<Health> list = healthService.selectWorkoutCategoryList(health);
		System.out.println(health.getCategory2());
		/* NAVER api code */
		String clientID=null;
        String clientSecret = null;
        //미향, 준일 , 동균 순서 id,pwd
        String clientIdArr[] = {"ruv96TRHNK8A6XvNLhkO","gW6kXM8gjSemyGCzbFM7","G0XI103VNKmTZuGNcR9G"};
        String clientSecretArr[] = {"L2Y9X7t1_5","JxqdihRctq","GTG4zI8eUQ"};
  
        
       // int select = (int)(Math.random()*2) + 1;
        //System.out.println("select : " + select);
      
        clientID = clientIdArr[random];
        clientSecret = clientSecretArr[random];
                
        random++;
        
        ArrayList<String> srcarr = new ArrayList<String>();
        ArrayList<String> keyarr = new ArrayList<String>();
        for(int i=0;i<list.size();i++) {
        	keyarr.add(list.get(i).getTitle().replaceAll(" ", ""));
        }
        System.out.println("keyarr Size : " + keyarr.size());
        System.out.println(keyarr.toString()); //검색할 동영상 제목들 다 keyarr에 넣어둠
        String query = "";
        String src = "";
        
        for(int i=0;i<keyarr.size();i++) {
        	
	        try {
	        	  query = URLEncoder.encode(keyarr.get(i),"UTF-8");
	        	} catch (UnsupportedEncodingException e1) {
	        	  e1.printStackTrace();
	        	}
	        int j = 0;
	        try {
		        URL url = new URL("https://openapi.naver.com/v1/search/encyc.xml?query="+query);
		        URLConnection urlConn=url.openConnection(); 
		      
		        urlConn.setRequestProperty("X-Naver-Client-ID", clientID);
		        urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
		        BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
		        System.out.println("호출 횟수 : " + i);
		        String data="";
		        String msg = null;
		        while((msg = br.readLine())!=null)
		        {
		            data += msg;
		        }
		       
		         XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
		         XmlPullParser parser = factory.newPullParser(); //연결하는거 담고 
		         parser.setInput(new StringReader(data));
		         int eventType= parser.getEventType();
		       
		         while(eventType != XmlPullParser.END_DOCUMENT){
		             switch(eventType){
		             case XmlPullParser.END_DOCUMENT://문서의 끝 
		                 break;
		             case XmlPullParser.START_DOCUMENT:
		                 break;
		             case XmlPullParser.END_TAG:{
		                 String tag = parser.getName();
		                 break;
		             }
		             case XmlPullParser.START_TAG: 
		            	 if (parser.getName().equals("thumbnail")) {
		            		 src = parser.nextText();
		            		 if(src.contains("muploader")&&j==0) {
		            			 srcarr.add(src);  //query하나에 썸네일 하나만 srcarr에 담도록 - j가 0일때만 담음  
		            			 System.out.println("srcarr:"+srcarr.toString());
		            			 j++;  
		            		 }
		            	 }
		         }
		             eventType =parser.next();
		         }
		         
		        }catch(Exception e) {
					e.printStackTrace();
		        }
        	}
        
        	/* view로 내보내기 */
			JSONObject sendJson = new JSONObject();
			JSONArray jarr = new JSONArray();
			int index = 0;
			for(Health h : list){
				JSONObject jhealth = new JSONObject();
				jhealth.put("v_no", h.getV_no());
				jhealth.put("title", URLEncoder.encode(h.getTitle(),"utf-8"));
				jhealth.put("content", URLEncoder.encode(h.getContent(),"utf-8"));
				jhealth.put("category1", URLEncoder.encode(h.getCategory1(),"utf-8"));
				jhealth.put("category2", URLEncoder.encode(h.getCategory2(),"utf-8"));
				jhealth.put("url", URLEncoder.encode(srcarr.get(index),"utf-8"));
				jhealth.put("readcount", h.getReadcount());
				
				jarr.add(jhealth);
				index++;
			}
			
			sendJson.put("list", jarr);
			
			response.setContentType("aplication/json; charset=utf-8"); 
			PrintWriter out = response.getWriter();
			out.println(sendJson.toJSONString());
			out.flush();
			out.close();
	}
	
	@RequestMapping(value="/detail.do",method = RequestMethod.POST)	//썸네일 누르면 누른 v_no로 모달창에서 동영상 재생.. 썸네일은 어케하지..
	public ModelAndView workOutDetail(Health health, HttpServletResponse response){
		//v_no를 파라미터로 보내면 v_no에 따른 health 객체 v_no 만
		int v_no = health.getV_no();
		
		ModelAndView mv = new ModelAndView("workout/detailView");	//모달 jsp 페이지로
		
		healthService.addReadCount(health.getV_no());	//조회수 증가
		
		Health detailHealth = healthService.selectOneWorkout(v_no);
		
		mv.addObject("health",detailHealth);
		mv.setViewName("jsonView");
		
		return mv;
	}	
	//기본 메인페이지 네이버 동영상 끝
	
		
		
	//맨몸운동
		
	//맨몸운동 메인 페이지	
	@RequestMapping(value="/homeTraning.do")
	public ModelAndView HomeTraningListMethod(){
		ModelAndView mv = new ModelAndView("/workout/homeTraningMain");
		ArrayList<Health> list = healthService.selectHomeTraningList();
		
		for(Health h : list){
			h.setTitle(h.getTitle().replaceAll("\\\"", "＇"));
			h.setContent(h.getContent().replaceAll("\\\"", "＇"));// 쌍따옴표jsp출력 문제로 미리 치환
		}
		int pushUpCount = healthService.selectVideoCount("맨몸푸시업");
		int lowerBodyCount = healthService.selectVideoCount("맨몸하체");
		int pullUpCount = healthService.selectVideoCount("맨몸철봉");
		int entireBodyCount = healthService.selectVideoCount("맨몸전신");
		int beginnerCount = healthService.selectVideoCount("맨몸초보자");
		
		mv.addObject("pushUpCount", pushUpCount);
		mv.addObject("lowerBodyCount", lowerBodyCount);
		mv.addObject("pullUpCount", pullUpCount);
		mv.addObject("entireBodyCount", entireBodyCount);
		mv.addObject("beginnerCount", beginnerCount);
		
		mv.addObject("list",list);
		return mv;		
	}
	
	//맨몸운동 카테고리별
	@RequestMapping(value="/htclist.do", method = RequestMethod.POST)
	public ModelAndView homeTraningCategoryList(Health health){
		ModelAndView mv = new ModelAndView("/workout/homeTraningMain");
		
		ArrayList<Health> htclist = healthService.selectWorkoutCategoryList(health);
		
		for(Health ht : htclist){
			ht.setTitle(ht.getTitle().replaceAll("\\\"", "＇"));
			ht.setContent(ht.getContent().replaceAll("\\\"", "＇"));// 쌍따옴표jsp출력 문제로 미리 치환
		}
		mv.addObject("htclist",htclist);
		mv.setViewName("jsonView");
		return mv;
		
	}
	
	@RequestMapping(value="/homeTraningSearch.do")
	public ModelAndView searchList(HttpServletRequest request){
		ModelAndView mv = new ModelAndView("workout/homeTraningMain");
		
		String keyWord = request.getParameter("searchKeyWord");
		
		
		ArrayList<Health> slist = healthService.selectSearchList(keyWord);
		System.out.println(slist);
		
		int pushUpCount = healthService.selectVideoCount("맨몸푸시업");
		int lowerBodyCount = healthService.selectVideoCount("맨몸하체");
		int pullUpCount = healthService.selectVideoCount("맨몸철봉");
		int entireBodyCount = healthService.selectVideoCount("맨몸전신");
		int beginnerCount = healthService.selectVideoCount("맨몸초보자");
		
		int searchCount = healthService.selectSearchVideoCount(keyWord);
		
		mv.addObject("searchCount",searchCount);
		mv.addObject("keyWord",keyWord);
		mv.addObject("pushUpCount", pushUpCount);
		mv.addObject("lowerBodyCount", lowerBodyCount);
		mv.addObject("pullUpCount", pullUpCount);
		mv.addObject("entireBodyCount", entireBodyCount);
		mv.addObject("beginnerCount", beginnerCount);
		mv.addObject("list", slist);
		
		
		
		return mv;
	}
	
	@RequestMapping(value="/sortList.do", method=RequestMethod.POST)
	public ModelAndView sortList(HttpServletRequest request,Health health){
		ModelAndView mv = new ModelAndView();
		ArrayList<Health> list = null;
		
		
		
		String selectValue = request.getParameter("selectValue");
		if(health.getCategory2()!=null){
		
			System.out.println("category1:" + health.getCategory1());
			System.out.println("category2:" + health.getCategory2());
			System.out.println("선택 값 : "+selectValue);
			/*ArrayList<Health> sortList = healthService.selectAllList();*/
		
			
			if(selectValue.equals("All")){
				list = healthService.selectWorkoutCategoryList(health);
				
			}else if(selectValue.equals("좋아요수")){
				
				list = healthService.selectLikeCountList(health);
							
			}else if(selectValue.equals("조회수")){
				
				list = healthService.selectWorkoutReadCountList(health);
			
			}
		}
		mv.addObject("list",list);
		mv.setViewName("jsonView");
		return mv;
	}
	
		
	
	
	//주변 헬스장 검색 페이지 이동
	@RequestMapping(value="aroundFitenessCenter.do")
	public String aroundFitnessMethod(){
		return "";
	}
	
	
		
	//댓글 
	@RequestMapping(value="/selectComment.do")
	public ModelAndView selectCommentList(Comment comment){
			
		ModelAndView mv = new ModelAndView("workout/detailView");
	
		ArrayList<Comment> list = healthService.selectCommentList(comment.getV_no());
		
		mv.addObject("commentList",list);
		mv.setViewName("jsonView");
			
		return mv;
	}
	
	//댓글 insert
	@RequestMapping(value="/insertReply.do",method=RequestMethod.POST)
	public void insertComment(Comment comment){
				
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String strDate = sdf.format(Calendar.getInstance().getTime());	//현재 날짜..
			
		java.sql.Date sqlDate = java.sql.Date.valueOf(strDate);
			
		comment.setReply_date(sqlDate);
		comment.setStringReplyDate(strDate);
		
	
								
		healthService.insertComment(comment);	//sqlDate 형식으로 insert 했음
		
		
	}
		
	
	//댓글 삭제
	@RequestMapping(value="/deleteReply.do",method=RequestMethod.POST)
	public ModelAndView deleteComment(Comment comment){
		
		ModelAndView mv = new ModelAndView("workout/detailView");
	    healthService.deleteComment(comment);
	    mv.setViewName("jsonView");
	      
	    return mv;
	}	
	
	//좋아요 테이블에 삽입, 삭제하는 메서드
	@RequestMapping(value="/likeUp.do",method=RequestMethod.POST)
	public ModelAndView likeUp(Like like){
		
		ModelAndView mv = new ModelAndView();
		
		int checkLikeTable = healthService.checkLikeTable(like); //좋아요 테이블에 있는지 확인하는 변수
		// 있으면 1 없으면 0
		
		int userLoginCheck = like.getUser_no();

		if (checkLikeTable == 0 && userLoginCheck != 0) {
			// 좋아요 처음 클릭
			// 좋아요 테이블에 넣음
			healthService.insertLike(like);
			healthService.insertMySchedule(like);

		} else if (checkLikeTable == 1 && userLoginCheck != 0) {
			// 좋아요 두번 클릭
			// 좋아요 테이블에서 삭제
			healthService.deleteLike(like);
			healthService.deleteMySchedule(like);

		}	
		
		mv.addObject("userLoginCheck",userLoginCheck);
		mv.addObject("checkLikeTable",checkLikeTable);
		mv.setViewName("jsonView");
		
		return mv;
	}
	//좋아요 갯수
	@RequestMapping(value="/likeCount.do",method=RequestMethod.POST)
	public ModelAndView likeCount(Like like){
		ModelAndView mv = new ModelAndView();
		
		//좋아요 테이블에서 특정 게시물 좋아요 갯수..
		int likeCount= healthService.selectLikeCount(like.getV_no());
		int checkLikeTable = healthService.checkLikeTable(like);
		
		mv.addObject("checkLikeTable",checkLikeTable);
		mv.addObject("likeCount",likeCount);
		mv.setViewName("jsonView");
		
		return mv;
	}	
	//메인에 영상 뿌려주기
	@RequestMapping(value="mainVideoList.do",method=RequestMethod.POST)
	public void mainVideoList(HttpServletRequest request,HttpServletResponse response) throws IOException{		
		ArrayList<Health> list = healthService.selectMainList();
	
		/* NAVER api code */
		String clientID="ruv96TRHNK8A6XvNLhkO";
        String clientSecret = "L2Y9X7t1_5";
       
        ArrayList<String> srcarr = new ArrayList<String>();
        ArrayList<String> keyarr = new ArrayList<String>();
        
        String query = "";
        String src = "";
		
		for(int i=0; i<list.size();i++){	//뽑아온 리스트중에 헬스가 있으면
			if(list.get(i).getCategory1().equals("헬스")){
				keyarr.add(list.get(i).getTitle().replaceAll(" ", ""));
				System.out.println("i번째 : " + i);
				  for(int k=0;k<keyarr.size();k++) {
			        		
				        try {
				        	  query = URLEncoder.encode(keyarr.get(k),"UTF-8");
				        	} catch (UnsupportedEncodingException e1) {
				        	  e1.printStackTrace();
				        	}
				        int j = 0;
				        try {
					        URL url = new URL("https://openapi.naver.com/v1/search/encyc.xml?query="+query);
					        URLConnection urlConn=url.openConnection(); 
					        urlConn.setRequestProperty("X-Naver-Client-ID", clientID);
					        urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
					        BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
					        String data="";
					        String msg = null;
					        while((msg = br.readLine())!=null)
					        {
					            data += msg;
					        }
					       
					         XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
					         XmlPullParser parser = factory.newPullParser(); //연결하는거 담고 
					         parser.setInput(new StringReader(data));
					         int eventType= parser.getEventType();
					       
					         while(eventType != XmlPullParser.END_DOCUMENT){
					             switch(eventType){
					             case XmlPullParser.END_DOCUMENT://문서의 끝 
					                 break;
					             case XmlPullParser.START_DOCUMENT:
					                 break;
					             case XmlPullParser.END_TAG:{
					                 String tag = parser.getName();
					                 break;
					             }
					             case XmlPullParser.START_TAG: 
					            	 if (parser.getName().equals("thumbnail")) {
					            		 src = parser.nextText();
					            		 if(src.contains("muploader")&&j==0) {
					            			 srcarr.add(src);  //query하나에 썸네일 하나만 srcarr에 담도록 - j가 0일때만 담음  
					            			 //System.out.println("srcarr:"+srcarr.toString());
					            			 j++;  
					            		 }
					            	 }
					         }
					             eventType =parser.next();
					         }
					         
					        }catch(Exception e) {
								e.printStackTrace();
					        }
			        	}
			}else{ //유투브
				list.get(i).setTitle(list.get(i).getTitle().replaceAll("\\\"", "＇"));
				list.get(i).setContent(list.get(i).getContent().replaceAll("\\\"", "＇"));
			
			}
			
		}
		
		System.out.println("리스트 : " + list);
		
		/* view로 내보내기 */
		JSONObject sendJson = new JSONObject();
		JSONArray jarr = new JSONArray();
		int index = 0;
		for(Health h : list){
			JSONObject jhealth = new JSONObject();
			jhealth.put("v_no", h.getV_no());
			jhealth.put("title", URLEncoder.encode(h.getTitle(),"utf-8"));
			jhealth.put("content", URLEncoder.encode(h.getContent(),"utf-8"));
			jhealth.put("category1", URLEncoder.encode(h.getCategory1(),"utf-8"));
			jhealth.put("category2", URLEncoder.encode(h.getCategory2(),"utf-8"));
			if(h.getCategory1().equals("헬스")){
				jhealth.put("url", URLEncoder.encode(srcarr.get(index),"utf-8"));
				index++;
			}
			else{
				jhealth.put("url", URLEncoder.encode(h.getUrl(),"utf-8"));
			}
			jhealth.put("readcount", h.getReadcount());
			
			jarr.add(jhealth);
			
			
			
		}
		
		sendJson.put("list", jarr);
		
		response.setContentType("aplication/json; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		out.println(sendJson.toJSONString());
		out.flush();
		out.close();
		
	
		
		
		
	}
	
	
}
