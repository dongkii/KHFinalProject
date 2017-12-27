<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- Modal -->
  <div class="modal fade" id="detailView" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
     <input type="hidden" name="reloadStat">
     <input type="hidden" name="mypageStat">
    <div class="modal-dialog modal-lg" id="workout-dialog">
      <div class="modal-content" id="workout-content">
      
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">x
          </button>
          <h4 class="modal-title" id="video_title"> </h4>
         
        </div>
           <div class="modal-body">
            <div class="modal-play" id="video_detail">
            </div>
            <div class="modal-desc">
               <div id="video_explain" style="color: black; font-size:13px">
                  <span id="span-content"></span>
               </div>
               <hr id="content-hr">
               
               <div id="like_up">   <!-- 좋아요 -->
               </div>
               <div id="read_count" style="color:black; font-size:13px"> <!-- 조회수 -->
               </div>
                              
               <br>
               
            
               <c:if test="${sessionScope.user==null }">
                  <div id="nvideo-reply" style="color:black;">
                     <input type="text" id="reply-input" placeholder="댓글을 입력하세요">
                     <button type="submit" id="reply-btn" onclick="loginMessage();">등록</button>
                  </div>
               </c:if>
               
               <c:if test="${sessionScope.user !=null }">
                  
                  <div id="video-reply" style="color:black; font-size:13px;"> <!-- 댓글 입력하는 곳 -->
                     
                  </div>
               </c:if>
               <!-- 댓글 보여주는 곳 -->
               <div id="reply_content" style="color:black; font-size:13px;">
                  
               </div>
                  
            </div>
         </div>
         
      </div>
    </div>
  </div>
<script type="text/javascript">
   function loginMessage(){
      alert("로그인이 필요한 서비스 입니다.");
      
   }   

   function detailView(v_no,category1,category2, mypageStat){   //모달창 띄우는 메서드
      
	  $("#detailView").show();
      $("#detailView").modal();
      $("input[name=mypageStat]").val(mypageStat);
      
      
      
      
      selectComment(v_no); //댓글
      var comment = '<input type="text" id="reply-input" placeholder="댓글을 입력하세요">' +
                '<input type="hidden" id="user_no" value="' + ${sessionScope.user.user_no}  + '" >' +
                '<input type="hidden" id="user_level" value="' + ${sessionScope.user.user_level}  + '" >' +
                /* '<input type="hidden" id="user" value="' + ${sessionScope.user}  + '" >' +  */
                '<input type="hidden" id="v_no" value="' + v_no  + '" >' +
               '<button type="submit" id="reply-btn" onclick="return insertComment(' + v_no + ');">등록</button>';
      
      $("#video-reply").html(comment);
      
            
      viewVideo(v_no); //모달창에서 영상 띄워주는 메서드         
      
      selectComment(v_no); 
      /*modal 댓글창 크기 조정 */
      if( screen.width <= 480 ) {
	      var contentHeight = $("#video_explain").outerHeight();
	      var modalHeight = $("#workout-content").height();
	      if(contentHeight==0){
	    	  contentHeight = 96;
	      }
	      var replyHeight = (modalHeight - contentHeight - 433);
	      console.log("mobileheights:"+contentHeight+"__"+modalHeight+"__"+replyHeight);
	      $("#reply_content").css({'max-height': replyHeight});
      }else{
    	  var contentHeight = $("#video_explain").outerHeight();
	      var modalHeight = $("#workout-content").height();
	      if(contentHeight==0){
	    	  contentHeight = 96;
	      }
	      var replyHeight = (modalHeight - contentHeight - 300);
	      console.log("heights:"+contentHeight+"__"+modalHeight+"__"+replyHeight);
	      $("#reply_content").css({'max-height': replyHeight});
      }
      
      
   
   }
   
   function viewVideo(v_no){ //모달창에서 영상 띄워주는 메서드 (조회수, 제목, 설명 ,좋아요 누르는부분)
      var user_no = $("#user_no").val();
   
      /*댓글 엔터키 입력*/
      $("#reply-input").keydown(function(key){
         if(key.keyCode==13){
            insertComment(v_no);
         }
      })
            
      $.ajax({
         url:"detail.do",
         dataType:"json",
         type:"post",
         data : {"v_no" : v_no},
         success:function(data){
         
         var responseData = data.health;
         var src= "";
         var like="";
         var likeCount = selectLikeCount(v_no);
         var category1 = responseData.category1;
         
         console.log("category1" + category1);
         
         /* 모달창 왼쪽에 영상 띄워주는 부분 */   
         if(category1=="헬스"){
        	 src="<iframe id='video-play' src="+ responseData.url.replace(/\^/g,"&")
            +"frameborder='0' gesture='media' allow='encrypted-media' allowfullscreen name='iframe'></iframe>"
         }else{
            src= "<iframe id='video-play' src='https://www.youtube.com/embed/"+responseData.url+"' frameborder='0'"+
            "gesture='media' allow='encrypted-media' allowfullscreen></iframe>"
         }
         

         like='<button type="submit" id="like-btn" onclick="likeUp(' + v_no    + ',' + 
               '\'' + responseData.category1 +'\'' + ',' + '\'' + responseData.category2  + '\'' +')"><i class="fa fa-heart" aria-hidden="true"></i></button>' +
         '<span style="color:black; font-size:13px"></span>'+
         '<span id="like_count" style="color:black; font-size:13px">' + likeCount + '&nbsp;</span>'
            
         $("#read_count").html("조회 " + responseData.readcount + "회");
         $("#video_title").html(responseData.title.replace(/\+/g," "));
         $("#video_explain").html(responseData.content);
         $("#video_detail").html(src);
         $("#like_up").html(like);
            
         },
         error: function(request, status, errorData){
            alert("error code : " + request.status + "\n"
                  + "message : " + request.responseText + "\n"
                  + "error : " + errorData);
         }
            
      })
   }
   
   function selectComment(v_no){   //댓글 select
      var user_no = $("#user_no").val();
      
      $.ajax({
         url:"selectComment.do",
         dataType:"json",
         type:"post",
         data : {"v_no" : v_no},
         success:function(data){
            var values="";
            console.log(data.commentList);
            //스크롤 바로 수정 해야함
            for(var i =0; i<data.commentList.length;i++){
               values += "<hr id='reply-hr'><span id='reply-writer'>" + data.commentList[i].name + "</span><span id='reply-content'>" + data.commentList[i].content + "</span><span id='reply-date'>"+ data.commentList[i].stringReplyDate + "</span>"
               
               if(user_no==data.commentList[i].user_no){ //내가 쓴 댓글 삭제
                  
                  values+="<button type='submit' id='del-btn' onclick ='deleteComment("+ v_no +")'><i class='fa fa-trash-o' aria-hidden='true'></i></button>"+
                        "<input type='hidden' id='vb_no' value="+data.commentList[i].vb_no+">"
               }
            }
            
            $("#reply_content").html(values); 
         
            
         },
         error: function(request, status, errorData){
            alert("error code : " + request.status + "\n"
                  + "message : " + request.responseText + "\n"
                  + "error : " + errorData);
         }
         
      })
   }
     
   function insertComment(v_no){   //댓글 insert
      
      var content = $("#reply-input").val();
      var vb_no = $("#vb_no").val();
      
   
      var user_no = $("#user_no").val();
      console.log(user_no);
      
      if(!user_no){
         loginMessage();
         return false;
      }else if(user_no!=="" && (content=="" || content==null)){
         alert("댓글 내용을 입력 해 주세요!");
         focus("#reply-input");
         return false;
      }
      
      console.log("insertComment vb_no : " + vb_no);
   
      var queryString ={"v_no" : v_no,"content" : content,"user_no":user_no,"vb_no":vb_no};
      
      $.ajax({
         url:"insertReply.do",
         type:"post",
         data : queryString,
         async:false
      });
      
      $("#reply-input").val(' ');
      selectComment(v_no);
            
      return true;
   }
   
   function deleteComment(v_no){ //댓글 delete
      var vb_no = $("#vb_no").val();
      $.ajax({
         url:"deleteReply.do",
         dataType:"json",
         type:"post",
         data:{"v_no":v_no,"vb_no":vb_no},
         async:false
      });
   
      selectComment(v_no);
      alert("댓글이 삭제되었습니다");
      
   }
   
   //좋아요 증가처리
   function likeUp(v_no,category1,category2){   
      var userLoginCheck = 0;
      var checkLikeTable = 0;
      var user_no = $("#user_no").val();
      var user_level = $("#user_level").val();
      $("input[name=reloadStat]").val('1');
      
      $.ajax({
         url:"likeUp.do",
         dataType:"json",
         type:"post",
         data:{"v_no":v_no,"user_no":user_no,"category1":category1,"category2":category2},
         async:false,
         success:function(data){
            userLoginCheck= data.userLoginCheck;
            checkLikeTable = data.checkLikeTable;
            
            console.log("checkLikeTable"+checkLikeTable);
            if(userLoginCheck==0){
               alert("로그인이 필요한 서비스 입니다.");
            }else if(userLoginCheck!=0 && checkLikeTable==0 && user_level==0){ //일반
               alert("게시물을 추천하셨습니다.\n MyPage - 운동 스케줄에서 게시물을 확인 하실 수 있습니다.");
            }else if(userLoginCheck!=0 && checkLikeTable==1 &&user_level==0){
               alert("추천을 취소 하셨습니다.\n MyPage - 운동 스케줄에서 해당 게시물이 삭제됩니다.");
            }else if(userLoginCheck!=0 && checkLikeTable==0 && user_level!=0){ //사업자,관리자
            	alert("게시물을 추천하셨습니다");
            }else if(userLoginCheck!=0 && checkLikeTable==1 &&user_level!=0){
            	alert("추천을 취소 하셨습니다.");
            }
         },
         error: function(xhr,status,error){
            alert("에러 발생");
         }
         
      });
      
      selectLikeCount(v_no);   //좋아요 갯수 다시 뿌려주기
   }
   
   function selectLikeCount(v_no){
      var user_no = $("#user_no").val();
      
      $.ajax({
         url:"likeCount.do",
         dataType:"json",
         type:"post",
         data:{"v_no":v_no,"user_no":user_no},
         success:function(data){
            var likeCount = data.likeCount;   
            var checkLikeTable = data.checkLikeTable;
            
            if(user_no){ //로그인 한경우 
               if(likeCount==1 && checkLikeTable == 1){   //나 혼자 좋아요 눌럿을 때
                  $("#like_count").html("회원님이 이 게시물을 좋아합니다.");   
               }else if(likeCount==0 && checkLikeTable == 0){   //아무도 좋아요 안눌렀을 때
                  $("#like_count").html(likeCount + " 명이 이 게시물을 좋아합니다")
               }else if(likeCount!=0 && checkLikeTable ==1){ //이미 좋아요를 클릭한 상황
                  $("#like_count").html("회원 님 외 " + (likeCount-1) + "명이 이 게시물을 좋아합니다.");
               }else if(likeCount !=0 && checkLikeTable ==0){
                  $("#like_count").html(likeCount + " 명이 이 게시물을 좋아합니다.")
               }
            }else{
               $("#like_count").html(likeCount + " 명이 게시물을 좋아합니다");
            }
         },
         error: function(request, status, errorData){
            alert("error code : " + request.status + "\n"
                  + "message : " + request.responseText + "\n"
                  + "error : " + errorData);
         }
      });
   }
   
    $(function (){
         $('#detailView').on('hidden.bs.modal', function (e) {
            e.preventDefault();
            fn_reload($(this));
         });
      });
      function fn_reload(obj) {
         var reloadStat = $("input[name=reloadStat]");
         var mypageStat = $("input[name=mypageStat]");
         if(obj.find(reloadStat).val()==1 && obj.find(mypageStat).val()==1) {
            location.reload();
         }
      }
   
</script>