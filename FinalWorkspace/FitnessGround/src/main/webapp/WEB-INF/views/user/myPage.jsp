<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<c:import url="../include/common/head.jsp" />	
	<link rel="stylesheet" href="/fitnessground/resources/css/user/mypage.css" />
	<link rel="stylesheet" href="/fitnessground/resources/css/workout/workout.css" />	
    <c:import url="../include/common/headend.jsp" />
    <script type="text/javascript" src="/fitnessground/resources/js/gym/mypagegym.js"></script>
    
    <c:if test="${ sessionScope.user == null }">
		<script type="text/javascript">
			$(function (){
				alert("로그인이 필요합니다.");
				location.href="main.do";
			});
		</script>
	</c:if>
	
	<script type="text/javascript">
    	$(function (){
			$('#myPageBar nav ul #uHome').addClass('activeMenu');
    	});
	</script>
	
    <c:if test="${ sessionScope.user != null }">
	<div id="page-wrapper">
		<!-- Header -->
		<div id="mypage_header">
            <!-- Nav -->
			<c:import url="../include/main/nav.jsp" />	
			<c:import url="login.jsp"/>
			<c:import url="findidpwd.jsp"/>
			<c:import url="register.jsp"/>
		</div>
    </div>
    
	<div id="myPageBar" align="center">
		<c:import url="../include/user/myPageBar.jsp"/>
	</div>
	
	<div class="mypage_info col-md-3 col-md-offset-2 col-sm-10">
		<div class="mypage_info_title" align="center">
			<a href="javascript:profileEdit()">
				<c:if test="${null eq sessionScope.user.rename_image}">
					<img src="/fitnessground/resources/images/myimages/nullicon.png" class="img-circle" style="background:#022D41;">
				</c:if>
				<c:if test="${null ne sessionScope.user.rename_image}">
					<img src="/fitnessground/resources/images/myimages/${sessionScope.user.rename_image}" class="img-circle" style="background:#022D41;">
				</c:if>
			</a>
			<p align="center">${sessionScope.user.name} 님</p>
		</div>
		<div class="mypage_info_content">
			<p>
				<span class="btn-lg glyphicon glyphicon-user" aria-hidden="true"> 닉네임</span>
				${sessionScope.user.nickname}
			</p>
			<p>
				<span class="btn-lg glyphicon glyphicon-envelope" aria-hidden="true"> E-mail</span>
				${sessionScope.user.email}
			</p>
			<p>
				<span class="btn-lg glyphicon glyphicon-phone" aria-hidden="true"> Phone</span>
				${sessionScope.user.phone}
			</p>
			<div id="mypage_btn">
				<table>
					<tr align="center">
						<td><button class="btn btn-default" onclick="location.href='udetail.do'">회원정보수정</button></td>
						<td><button class="btn btn-default" onclick="location.href='userpwd.do'">비밀번호변경</button></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	
	<c:if test="${ sessionScope.user.user_level == 0 }">
	<c:import url="./userScheduleEdit.jsp"/>
	<c:import url="../workout/detailView.jsp" />
	<input type="hidden" name="user_no" value="${sessionScope.user.user_no}">
	<div class="mypage_schedule_y col-md-5 col-sm-12">
		<div id="yesterdayScheduleTitle">
			<table>
				<tr>
					<th>어제의 운동</th>
					<td align="right">${yesterDate}</td>
				</tr>				
			</table>
		</div>
		<div id="yesterdayScheduleContent">
			<c:choose>
			<c:when test="${!empty yesterday}">
				<c:forEach items="${yesterday}" var="s" varStatus="st">
				<div>
					<c:if test="${null eq s.content}">
						<a href="javascript:detailView('${s.v_no}', '${s.category1}', '${s.category2}', '1');">${s.title}</a>
					</c:if>
					<c:if test="${null ne s.content}">
						<a href="javascript:userScheduleDetail('${s.s_no}', '${s.content}', '1');">${s.content}</a>
					</c:if>
				</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr><td colspan="2">운동내역이 없습니다.</td></tr>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="mypage_schedule_t col-md-5 col-sm-12">
		<div id="todayScheduleTitle">
			<table>
				<tr>
					<th>오늘의 운동</th>
					<td align="right">${currentDate}</td>
				</tr>				
			</table>
		</div>
		<div id="todayScheduleContent">
			<c:choose>
			<c:when test="${!empty today}">
				<c:forEach items="${today}" var="s" varStatus="st">
				<div>
					<c:if test="${null eq s.content}">
						<a href="javascript:detailView('${s.v_no}', '${s.category1}', '${s.category2}', '1');">${s.title}</a>
					</c:if>
					<c:if test="${null ne s.content}">
						<a href="javascript:userScheduleDetail('${s.s_no}', '${s.content}', '1');">${s.content}</a>
					</c:if>
				</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr><td colspan="2">운동내역이 없습니다.</td></tr>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="mypage_schedule_bt col-md-5 col-sm-12">
		<button class="btn btn-default" onclick="location.href='uschedule.do?userno=${sessionScope.user.user_no}'">운동 스케줄 더 보기</button>
	</div>
	</c:if>
	
	<c:if test="${ sessionScope.user.user_level == 1 }">
		<div class="mypage_gymmanage col-md-5 col-sm-12">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="regcount">
				<input type="hidden" id="userno" value="${ sessionScope.user.user_no }">
			</div>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="gymsearchdiv">
				<div class="input-group">
					<input type="text" oninput="gymsearch(${ sessionScope.user.user_no });" id="gymsearch" class="form-control" placeholder="헬스장 이름으로 검색">
					<span class="input-group-addon" style="background:white;"><a href="javascript:gymsearch(${ sessionScope.user.user_no })"><span class="glyphicon glyphicon-search"></span></a></span>
				</div>
			</div>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="gymlist">
				<!-- 헬스장 리스트 -->
			</div>
		</div>
		<div class="col-md-5 col-sm-12" id="registerGymBt">
			<Button class="btn btn-default" onclick="location.href='moveregistergym.do'">새 헬스장 등록</Button>
		</div>
	</c:if>
	</c:if>	
	
    <c:import url="../include/main/footer.jsp" />
    <c:import url="../include/common/end.jsp" />