<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:import url="../../include/common/head.jsp" />
	
	<style type="text/css">
	
	h1#community_title{
	font-size: 30pt;
	}
    div#detail_div{
    border: 2px double;
    border-color:#BDBDBD;
    }
    h5#community_name{
    padding-top:10pt;
    }

    div#meetingCommentList{
    font-size:12pt;
    }
 
    </style>
	
	
	<c:import url="../../include/common/headend.jsp" />
  <link rel="stylesheet" href="/fitnessground/resources/css/community/community.css">	
<script src="//cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script>
  
	<div id="page-wrapper">
		<!-- Header -->
		<div id="mypage_header">
            <!-- Nav -->
			<c:import url="../../include/main/nav.jsp" />
			
			<c:import url="../../user/login.jsp"/>
			<c:import url="../../user/findidpwd.jsp"/>
			<c:import url="../../user/register.jsp"/>
		</div>
    </div>
       
   <script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=vWkJuuK8gXcwBG8Rijlh&submodules=geocoder">	
   </script>
   
    <script type="text/javascript">
    function loginCheck(){
		alert("로그인이 필요한 서비스 입니다.");
	}	
    //목록
    function meetingCommentList(mb_no){
    	var user_no = $("#user_no").val();
   		$.ajax({
   			 url:"meetingCommentList.do",
   			 type:"post",
   			 dataType:"json",
   			 data:{"mb_no": mb_no},
   			 success: function(data)
   			 {
   				 console.log(data);
   				 console.log(data.mblist);
   				 var values = "";
   				 
   				 for(var i in data.mblist)
   					 {
   					  	
   					 	values += "<div id='reply'><div class='texts-name'><span>" + data.mblist[i].name + "</span></div>"+
      					"<div class='texts-content'><span>" +  data.mblist[i].content + "</span></div><div class='texts-date'>" + data.mblist[i].reply_date +"</div>";
      					
      					if(user_no == data.mblist[i].user_no){
   	      					values += "<div class='texts-del'><a class='btn' type='submit' onclick='meetingCommentDelete("+data.mblist[i].mb_no+","+ data.mblist[i].mbc_no +")'><i class='fa fa-trash' aria-hidden='true'></i></a></div>"
   	      					}
      					
      					values +="</div>";
      					
   						
   					
   				 }
   			    $("#meetingCommentList").html(values);
   			 }
   		});
   	}
    
  	function meetingCommentInsert(mb_no){
  		var content = $("#commentInsert").val();
  		var user_no = $("#user_no").val();
  		$.ajax({
  				url:"meetingCommentInsert.do",
  				type:"post",
  				data :{"mb_no":mb_no,"content":content,"user_no":user_no},
  				async:false
  		});
  		console.clear();
  		$("#commentInsert").val('');
  		meetingCommentList(mb_no);
  	}
  	
  	function meetingCommentDelete(mb_no,mbc_no){ //댓글 delete
  		if (confirm("댓글을 삭제하시겠습니까??") == false){
			return;
		}else{
		$.ajax({
			url:"meetingCommentDelete.do",
			type:"post",
			data:{"mbc_no":mbc_no},
			async:false
		});
		console.clear();
		meetingCommentList(mb_no);
		}
	}
    
  	$(window).on("load", function() {
  		
  	
  		$('#commentInsert').on('keydown', function(e) {
  			var keyCode = e.which;

  			if (keyCode === 13) { // Enter Key
  				if(${sessionScope.user.user_no eq null}){	
  			
  					alert("로그인 후 이용해 주세요");	
  					console.clear();
  				}else{
  					
  					meetingCommentInsert(${meeting.mb_no});
  	  				console.clear();
  				}
  			}
  		});	
	});
  	
	</script>
	
     <div class="container">
     	<h1 id="detail-title">운동같이해요</h1>
     	<div id="board-wrapper">
		     <input type="hidden" id="user_no" value="${sessionScope.user.user_no}">
		    <hr id="title-hr">
		    <div class="row">
		    	<div class=".col-md-4" style="font-size:1.3rem;font-weight: 600;margin-left: 20;color: #022D41;">
		    	${meeting.title}
		    	</div>
		    	<div id="detail-info" style="font-size:12pt">
		    	 | ${meeting.name }
		    	</div>	
		    	<div id="detail-info" style="font-size:12pt">
		    	${meeting.upload_date}
		    	</div>	
		    </div>
		    <hr id="hr">
		    <br>
		     <div id="detail_ail_div" align="center"> 
		  
			    <div align="center">
			    	<div id="community-contents">
				     	<p id="content">${meeting.content}</p>
				    </div>
				    <c:if test="${meeting.user_no ne 1}">   
			     	<input type="hidden" id="location" value=${meeting.meeting_location }>
			     		<div>
			     			<p>모임장소 : ${meeting.meeting_location }</p>
			     			<div id="map">
								<script type="text/javascript" src="/fitnessground/resources/js/community/communityMap.js"></script>
							</div>
						</div>	
					  </c:if>
			        </div>
			        <div align="right">
				   <c:if test="${sessionScope.user.user_no eq meeting.user_no}">
				   <a href="meetingUpdate.do?no=${meeting.mb_no}" class="btn">수정</a>
				   <a href="meetingDelete.do?no=${meeting.mb_no}" class="btn">삭제</a>
				   </c:if>
				   <a href="meeting.do" class="btn">목록</a><br>
			   </div>
			        <input type="hidden" ${meeting.readcount}/>
			   
		    </div>
		    
		   <!-- =========================댓글 쓰는 공간================================== -->
		    <!--  댓글  -->
		    <cbody>
				<div id="comment-area">	  
						
					 	<!--  댓글 입력 -->
					 	<c:if test="${sessionScope.user==null}">
									<div id="meetingCommentInsert" class="input-group">
										
								 		<input type="text"  class="form-control" id="commentInsert" placeholder="로그인 후 댓글 이용 해주세요!">
										<input type="hidden" id="user_no" value="${sessionScope.user.user_no}">
										<span class="input-group-btn">
								        <button class="btn btn-default" type="button" id="commentInsertBtn" onclick="loginCheck();">입력</button>
								     	</span>
									</div>	
								
						</c:if>
						<c:if test="${sessionScope.user!=null}">
					 	<div id="meetingCommentInsert" class="input-group">
					 		
					 		<input type="text"  class="form-control" id="commentInsert" placeholder="댓글을 입력하세요">
							<input type="hidden" id="user_no" value="${sessionScope.user.user_no}">
							<span class="input-group-btn">
					        <button class="btn btn-default" type="button" id="commentInsertBtn" onclick="meetingCommentInsert(${meeting.mb_no});">입력</button>
					     	
					     	</span>
						</div>
							
						</c:if>
						
					   <!--댓글 목록-->
					   <div id="meetingCommentList">
					   	<script type="text/javascript">
					   		meetingCommentList("${meeting.mb_no}");
					   	</script>    
					   </div>  
					</div> 
				</div>  
			   		
			   </div>  
  			</cbody> 
  			
    <c:import url="../../include/main/footer.jsp" />
    <c:import url="../../include/common/end.jsp" />