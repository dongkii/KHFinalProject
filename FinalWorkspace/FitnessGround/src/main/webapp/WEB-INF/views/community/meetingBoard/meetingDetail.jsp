<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:import url="../../include/common/head.jsp" />
	
	<style type="text/css">
	@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
	cbody{
	font-family: 'Nanum Pen Script', cursive;
	font-size: 20pt;
	}
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
    hr#hr{
    height:1pt;
    background-color:#BDBDBD;
    }
    div#meetingCommentList{
    font-size:12pt;
    }
 
    </style>
	
	
	<c:import url="../../include/common/headend.jsp" />
  
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
   					  	
   					 	values += "<div class='jumbotron'><div class='col-md-2 text-center'><b>" + data.mblist[i].name + "<b></div>"+
      					"<div class='col-md-6 text-left'>" +  data.mblist[i].content + "</div><div class='col-md-2 text-right'>" + data.mblist[i].reply_date +"</div>";
      					
      					if(user_no == data.mblist[i].user_no){
   	      					values += "<div class='col-md-2 text-right'><a class='btn' type='submit' onclick='meetingCommentDelete("+data.mblist[i].mb_no+","+ data.mblist[i].mbc_no +")'>삭제</a></div>"
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
  	
		$.ajax({
			url:"meetingCommentDelete.do",
			type:"post",
			data:{"mbc_no":mbc_no},
			async:false
		});
		console.clear();
		meetingCommentList(mb_no);
		
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
     <input type="hidden" id="user_no" value="${sessionScope.user.user_no}">
    <br>
    <h1 id="community_title" align="center">${meeting.title}</h1><br>
     <div id="detail_ail_div" align="center"> 
    <div id="detail_div" align="center">
   		  		
    	<h5 id="community_name">작성자 : ${meeting.name} 작성날짜:${meeting.upload_date}</h5>
    	<hr id="hr">
     	<p>${meeting.content}</p>
     	<input type="hidden" id="location" value=${meeting.meeting_location }>
  				<div id="map" style="width: 600px; height: 400px; margin-left: 50px">
					<script type="text/javascript" src="/fitnessground/resources/js/community/communityMap.js"></script>
				</div>	  
        </div>
        <input type="hidden" ${meeting.readcount}/>
    <div>
   </div>
   <c:if test="${sessionScope.user.user_no eq meeting.user_no}">
   <a href="meetingUpdate.do?no=${meeting.mb_no}" class="btn">수정</a>
   <a href="meetingDelete.do?no=${meeting.mb_no}" class="btn">삭제</a>
   </c:if>
   <a href="meeting.do" class="btn">목록</a><br>
    </div>
    
   <!-- =========================댓글 쓰는 공간================================== -->
    <!--  댓글  -->
    <cbody>
   <br><h5 align="center">-------- 댓글 --------</h5><br> 
	
 	<!--  댓글 입력 -->
 	<c:if test="${sessionScope.user==null}">
				<div id="meetingCommentInsert" class="input-group">
					
			 		<input type="text"  class="form-control" id="commentInsert" placeholder="로그인 후 댓글 이용 해주세요!">
					<input type="hidden" id="user_no" value="${sessionScope.user.user_no}">
					<span class="input-group-btn">
			        <button class="btn btn-default" type="button" id="commentInsertBtn" onclick="loginCheck();">입력</button>
			     	</span>
				</div>	
				<br>
	</c:if>
	<c:if test="${sessionScope.user!=null}">
 	<div id="meetingCommentInsert" class="input-group">
 		
 		<input type="text"  class="form-control" id="commentInsert" placeholder="댓글을 입력하세요">
		<input type="hidden" id="user_no" value="${sessionScope.user.user_no}">
		<span class="input-group-btn">
        <button class="btn btn-default" type="button" id="commentInsertBtn" onclick="meetingCommentInsert(${meeting.mb_no});">입력</button>
     	
     	</span>
	</div>
	<br>	
	</c:if>
	
   <!--댓글 목록-->
   <div id="meetingCommentList">
   	<script type="text/javascript">
   		meetingCommentList("${meeting.mb_no}");
   	</script>    
   </div>   
   </div>    
  </cbody> 
    <c:import url="../../include/main/footer.jsp" />
    <c:import url="../../include/common/end.jsp" />