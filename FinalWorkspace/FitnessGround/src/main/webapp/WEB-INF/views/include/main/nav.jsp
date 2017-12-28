<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/views/user/profileEdit.jsp"/>

<nav id="nav" style="height:85px;">
	
	<ul>
		<li><a href="main.do">HOME</a></li>
		<li><a href="healthMain.do">운동법</a>
			<ul>
				<li><a href="healthMain.do">헬스</a></li>
				<li><a href="yogaMain.do">요가</a></li>
				<li><a href="pilatesMain.do">필라테스</a></li>
				<li><a href="homeTraning.do">맨몸운동</a>
					<!-- <ul>
						<li><a href="#">Lorem ipsum dolor</a></li>
						<li><a href="#">Phasellus consequat</a></li>
						<li><a href="#">Magna phasellus</a></li>
						<li><a href="#">Etiam dolore nisl</a></li>
					</ul> -->
				</li> 
			</ul>
		</li>
		<li><a href="findgym.do">운동시설 찾기</a>
			<ul>
				<li><a href="findgym.do?mode=2">공공체육시설</a></li>
				<li><a href="findgym.do?mode=1">헬스장</a></li>
			</ul>
		</li>
		<li><a href="community.do">커뮤니티</a>
			<ul>
				<li><a href="meeting.do">운동모임</a></li>
				<li><a href="review.do">운동후기</a></li>
				<li><a href="qna.do">Q&A</a></li>
			</ul>
		</li>
		<c:if test="${ sessionScope.user == null}">
			<li><a href="javascript:login()">로그인</a></li>
		</c:if>
		<c:if test="${ sessionScope.user != null}">
			<li><a href="mypage.do?userno=${sessionScope.user.user_no}">${sessionScope.user.name }님</a>
				<ul>
					<c:if test="${ sessionScope.user.user_level == 1 }">
					<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0px; padding-right: 0px; margin-top:12%;">
					</c:if>
					<c:if test="${ sessionScope.user.user_level ne 1 }">
					<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0px; padding-right: 0px; margin-top:10px;">
					</c:if>
					<c:if test="${null eq sessionScope.user.rename_image}">
						<a href="javascript:profileEdit()"><img src="/fitnessground/resources/images/myimages/nullicon.png" class="img-circle" style="width: 85px; height: 85px; background:#022D41;"></a>
					</c:if>
					<c:if test="${null ne sessionScope.user.rename_image}">
						<a href="javascript:profileEdit()"><img src="/fitnessground/resources/images/myimages/${ sessionScope.user.rename_image }" class="img-circle" style="width: 85px; height: 85px;"></a>
					</c:if>
					</div>
					<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
					<c:if test="${ sessionScope.user.user_level == 2 }">
						<li><a href="adminMain.do">관리자페이지</a></li>
					</c:if>
					<c:if test="${ sessionScope.user.user_level != 2 }">
						<li><a href="mypage.do?userno=${sessionScope.user.user_no}">마이페이지</a></li>
					</c:if>
					<c:if test="${ sessionScope.user.user_level == 1 }">
						<li><a href="moveregistergym.do">헬스장등록</a></li>
					</c:if>
					<li><a href="userboard.do?userno=${sessionScope.user.user_no}">문의내역</a></li>
					<li><a href="logout.do">로그아웃</a></li>
					</div>
				</ul>
			</li>
		</c:if>
	</ul>
</nav>

