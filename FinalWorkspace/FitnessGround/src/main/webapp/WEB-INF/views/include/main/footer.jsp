<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    <link rel="stylesheet" href="/fitnessground/resources/css/common/footer.css" />
    
    <script language="javascript">
		function captureReturnKey(e) {
		    if(e.keyCode==13 && e.srcElement.type != 'textarea')
		    return false;
		}
		function adminQnAInsert() {
			$.ajax({async : true, 
			 	type : "get",
			 	url : "adminQnAInsert.do",
			 	dataType : "json",
			 	data: $("#adminQnAForm").serialize(),
			 	success : function(result){
			 		location.reload();
			 	},
			 	error: function(request,status,error){
			 		alert("error code : " + request.status + "\n"
							+ "message : " + request.responseText + "\n"
							+ "error : " + errorData);
			 	}
			});
		}
	</script>
    
<div id="footer" style="clear:left;">

	<c:if test="${ sessionScope.user != null }">
		<div class="col-md-offset-2 col-md-8" id="footerQna"><form action="" id="adminQnAForm" method="post" enctype="multipart/form-data" onkeydown="return captureReturnKey(event)">	
			<input type="hidden" name="receiver" value="1">
			<input type="hidden" name="mode" value="1">
			<input type="hidden" name="sender" value="${sessionScope.user.user_no}">
			<div class="col-md-6 col-sm-12" id="footerQnaTitle">
				<table>
					<tr><th style="padding-bottom:40px;">Send message to admin</th></tr>
					<tr><td>궁금하신 사항을 관리자에게 문의하세요!</td></tr>
					<tr><td>문의하신 내용 및 답변은 </td></tr>
					<tr><td>마이페이지의 문의내역에서 확인하실 수 있습니다.</td></tr>
				</table>
			</div>
	    	<div class="col-md-offset-1 col-md-5 col-sm-12" id="footerQnaContent" align="center">
				<table>
					<tr><th>Title</th></tr>
					<tr><td style="padding-bottom:20px;"><input class="form-control" name="title"></td></tr>
					<tr><th>Content</th></tr>
					<tr><td style="padding-bottom:30px;"><textarea rows="10" class="form-control" id="editor1" name="content"></textarea></td></tr>
					<tr><td style="padding-bottom:20px;"><button class="btn btn-primary" onclick="adminQnAInsert();">SEND</button></td></tr>
				</table>
	   		</div>
	   	</form></div>
   	</c:if>
            	
            <div class="container">
                <div class="row">
                    <!-- 1 -->
                    <section class="4u 12u(mobile)">
                        <header>
                            <h2><i class="fa fa-youtube-play" aria-hidden="true"></i></h2>
                        </header>
                        <ul class="divided">
                            <li>
                                <h3 id="footer-title">운동법 동영상</h3>
                            </li>
                           	<li>
                           	<p id="footer-menu"><a href="healthMain.do">헬스</a></p>
                           	<p id="footer-menu"><a href="yogaMain.do">요가</a></p>
                           	<p id="footer-menu"><a href="pilatesMain.do">필라테스</a></p>
                           	<p id="footer-menu"><a href="homeTraning.do">맨몸운동</a></p>
								</li>
                        </ul>
                    </section>
                     <!-- 2-->
                    <section class="4u 12u(mobile)">
                        <header>
                            <h2><i class="fa fa-search" aria-hidden="true"></i></h2>
                        </header>
                        <ul class="divided">
                            <li>
                                <h3 id="footer-title">운동시설 찾기</h3>
                            </li>
                           		<li>
                           	<p id="footer-menu"><a href="findgym.do?mode=2">공공체육시설</a></p>
                           	<p id="footer-menu"><a href="findgym.do?mode=1">헬스장</a></p>
								</li>
                        </ul>
                    </section>
                     <!-- 3 -->
                    <section class="4u 12u(mobile)">
                        <header>
                            <h2><i class="fa fa-users" aria-hidden="true"></i></h2>
                        </header>
                        <ul class="divided">
                            <li>
                                <h3 id="footer-title">커뮤니티</h3>
                            </li>
                           		<li>
                           	<p id="footer-menu"><a href="meeting.do">운동모임</a></p>
                           	<p id="footer-menu"><a href="review.do">운동후기</a></p>
                           	<p id="footer-menu"><a href="qna.do">Q&A</a></p>
								</li>
                        </ul>
                    </section>
                </div>
                
                <div class="row">
                    <div class="12u">
                        <!-- Copyright -->
                        <div class="copyright">
                            <ul class="menu">
                                <li>&copy; FitnessGround. All rights reserved.</li>
                                <li>team 뚝이</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
            </div>
</div>