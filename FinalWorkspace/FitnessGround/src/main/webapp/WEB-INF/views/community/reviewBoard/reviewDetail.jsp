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
    h1{
    font-size: 30pt;
    }
    div#detail_all_div{
    padding: 5%;
    }
    div#detail_div{
    border: 1px solid;
    border-color: #BDBDBD;
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
    
    
      
      <script type="text/javascript">
      function loginCheck(){
  		alert("로그인이 필요한 서비스 입니다.");
  	}	
    //목록
    function communityCommentList(cb_no){
    	var user_no = $("#user_no").val();
    
   		$.ajax({
   			 url:"communityCommentList.do",
   			 type:"post",
   			 dataType:"json",
   			 data:{"cb_no": cb_no},
   			 success: function(data)
   			 {
   				 console.log(data);
   				 console.log(data.cblist);
   				 var values = "";
   				 
   				 for(var i in data.cblist)
   					 {
   					 values += "<div class='jumbotron'><div class='col-md-2 text-center'><b>" + data.cblist[i].name + "<b></div>"+
   					"<div class='col-md-6 text-center'>" +  data.cblist[i].content + "</div><div class='col-md-2 text-center'>" + data.cblist[i].reply_date + "</div>"
   					
   					if(user_no == data.cblist[i].user_no){
   					values += "<div class='col-md-2 text-right'><a class='btn' type='submit' onclick='communityCommentDelete("+data.cblist[i].cb_no+","+ data.cblist[i].cbc_no +")'>삭제</a></div>"
   					}
   					 values += "</div>";
   					 }
   			    $("#communityCommentList").html(values);
   			 }
   		});
   	}
    
  	function communityCommentInsert(cb_no){
  		var content = $("#commentInsert").val();
  		var user_no = $("#user_no").val();
  		$.ajax({
  				url:"communityCommentInsert.do",
  				type:"post",
  				data :{"cb_no":cb_no,"content":content,"user_no":user_no},
  				async:false
  		});
  		console.clear();
  		$("#commentInsert").val('');
  		communityCommentList(cb_no);
  	}
  	
  	function communityCommentDelete(cb_no,cbc_no){ //댓글 delete
  	
		$.ajax({
			url:"communityCommentDelete.do",
			type:"post",
			data:{"cbc_no":cbc_no},
			async:false
		});
		console.clear();
		communityCommentList(cb_no);
		
	}
    
  	$(window).on("load", function() {
  		$('#commentInsert').on('keydown', function(e) {
  			var keyCode = e.which;

  			if (keyCode === 13) { // Enter Key
  				if(${sessionScope.user.user_no eq null}){
  					alert("로그인 후 이용해주세요");
  	  				console.clear();
  			}else{
  				communityCommentInsert(${community.cb_no});
	  				console.clear();
  				}
  			}
  		});	
	});
  	
	</script>
	
     <div class="container">
     <input type="hidden" id="user_no" value="${sessionScope.user.user_no}">
    <br>
    <h1 align="center">${community.title}</h1>
   <div id="detail_ail_div"> 
    <div id="detail_div">
    	<div>

    	</div>
     	<p align="center">${community.name}</p>
     	<p>${community.content}</p>
        </div>
   <input type="hidden" value="${community.readcount}"/>
    <div>
   </div> 
   <c:if test="${sessionScope.user.user_no eq community.user_no}">
   <a href="reviewUpdate.do?no=${community.cb_no}" class="btn">수정</a>
   <a href="reviewDelete.do?no=${community.cb_no}" class="btn">삭제</a>
   </c:if>
   <a href="review.do" class="btn">목록</a>
  </div>
    <!-- =========================댓글 쓰는 공간================================== -->
    <!--  댓글  -->
    <cbody>
    <br><h5 align="center">-------- 댓글 --------</h5><br>
 	<!--  댓글 입력 -->
 <c:if test="${sessionScope.user==null}">
 	<div id="communityCommentInsert" class="input-group" >
 		<input type="text"  class="form-control" id="commentInsert" placeholder="댓글을 입력하세요">
		<input type="hidden" id="user_no" value="${sessionScope.user.user_no}">
		<span class="input-group-btn">
        <button class="btn btn-default" type="button" id="commentInsertBtn" onclick="loginCheck();">입력</button>
     	</span>
	</div>	
	<br>
 </c:if>
 <c:if test="${sessionScope.user!=null}">
 	<div id="communityCommentInsert" class="input-group" >
 		<input type="text"  class="form-control" id="commentInsert" placeholder="댓글을 입력하세요">
		<input type="hidden" id="user_no" value="${sessionScope.user.user_no}">
		<span class="input-group-btn">
        <button class="btn btn-default" type="button" id="commentInsertBtn" onclick="communityCommentInsert(${community.cb_no});">입력</button>
     	</span>
	</div>	
 </c:if>	
   <!--댓글 목록-->
   <div id="communityCommentList">
   	<script type="text/javascript">
   		communityCommentList("${community.cb_no}");
   	</script>    
   </div>   
   </div>   
  <cbody>  
       
    <c:import url="../../include/main/footer.jsp" />
    <c:import url="../../include/common/end.jsp" />