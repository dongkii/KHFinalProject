<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<div class="hidden-xs hidden-sm visible-md visible-lg">
			<nav class="nav">
				<ul class="nav navbar-nav">
				   	<li id="uHome"><a href="mypage.do?userno=${sessionScope.user.user_no}">
				   		<i class="fa fa-home" aria-hidden="true" style="margin-right:5px;"></i> 마이페이지</a>
				   	</li>
				    <li id="uDetail"><a href="udetail.do">
				    	<i class="fa fa-user" aria-hidden="true" style="margin-right:5px;"></i> 회원정보</a>
				    </li>
					<li id="uPwd"><a href="userpwd.do">
						<i class="fa fa-lock" aria-hidden="true" style="margin-right:5px;"></i> 비밀번호변경</a></li>
					<li id="uBoard"><a href="userboard.do?userno=${sessionScope.user.user_no}">
						<i class="fa fa-list-alt" aria-hidden="true" style="margin-right:5px;"></i> 게시글관리</a>
					</li>
					<c:if test="${ sessionScope.user.user_level == 0 }">
						<li id="uSchedule"><a href="uschedule.do?userno=${sessionScope.user.user_no}">
							<i class="fa fa-calendar" aria-hidden="true" style="margin-right:5px;"></i> 운동스케줄</a>
						</li>
					</c:if>
					<c:if test="${ sessionScope.user.user_level == 1 }">
						<li id="uSchedule"><a href="moveregistergym.do">
							<i class="fa fa-heartbeat" aria-hidden="true" style="margin-right:5px;"></i> 헬스장등록</a>
						</li>
					</c:if>
					<li id="uDel"><a href="userdel.do">
						<i class="fa fa-user-times" aria-hidden="true" style="margin-right:5px;"></i> 회원탈퇴</a>
					</li>
				</ul>
			</nav>
		</div>
		<div class="col-sm-12 visible-xs visible-sm hidden-md hidden-lg navbar-fixed-top" style="margin-top:40px; padding-left: 0px !important; padding-right: 0px !important;">
			<ul class="nav nav-tabs" style="background:white;">
			  <li role="presentation" class="dropdown">
			    <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false" id="sm_title">
			      My Page <span class="caret"></span>
			    </a>
			    <ul class="dropdown-menu" role="menu">
			    <li><a href="mypage.do?userno=${sessionScope.user.user_no}">Home</a>
				<li><a href="udetail.do">회원정보</a></li>
				<li><a href="userpwd.do">비밀번호변경</a></li>
				<li><a href="userboard.do?userno=${sessionScope.user.user_no}">게시글관리</a></li>
				<c:if test="${ sessionScope.user.user_level == 0 }">
					<li><a href="uschedule.do?userno=${sessionScope.user.user_no}">운동스케줄</a></li>
				</c:if>
				<li><a href="userdel.do">회원탈퇴</a></li>
			    </ul>
			  </li>
			</ul>
		</div>