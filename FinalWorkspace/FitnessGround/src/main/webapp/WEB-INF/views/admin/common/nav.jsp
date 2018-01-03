<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
		<a class="navbar-brand" id= "nav-brand" href="adminMain.do"><img src="/fitnessground/resources/images/blacklogo.png" id="blacklogo" height="30"></a>
		<button class="navbar-toggler navbar-toggler-right" type="button"
			data-toggle="collapse" data-target="#navbarResponsive"
			aria-controls="navbarResponsive" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		
		<div class="collapse navbar-collapse" id="navbarResponsive">
		
			<ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
			
				<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Dashboard">
					<a class="nav-link nav-link-collapse" data-toggle="collapse"
					href="#collapseComponents" data-parent="#exampleAccordion">
						<i class="fa fa-fw fa-dashboard"></i> 
						<span class="nav-link-text">회원관리</span>
					</a>
				
					<ul class="sidenav-second-level collapse show" id="collapseComponents">
							<li><a href="adminuserlist.do">일반회원</a></li>
							<li><a href="adminbusinesslist.do">사업자회원</a></li>
					</ul>
				</li>
				
				<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Tables">
					<a class="nav-link nav-link-collapse collapsed" data-toggle="collapse"
					href="#collapse-second" data-parent="#Accordion">
						<i class="fa fa-fw fa-table"></i> 
							<span class="nav-link-text">게시판관리</span>
					</a>
					<ul class="sidenav-second-level collapse" id="collapse-second">
							<li><a href="adminMettingBoard.do">Meeting</a></li>
							<li><a href="adminQNABoard.do">QnA</a></li>
							<li><a href="adminReviewBoard.do">Review</a></li>
							
					</ul>
				</li>
				
				<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
					<a class="nav-link" href="adminylist.do"> 
						<i class="fa fa-youtube-play"></i> 
							<span class="nav-link-text">운동 동영상관리</span>
					</a>
				</li>
				<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
					<a class="nav-link" href="adminQuestionBoard.do"> 
						<i class="fa fa-question-circle-o"></i> 
							<span class="nav-link-text">문의 관리</span>
					</a>
				</li>
				
				<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Charts">
					<a class="nav-link" href="charts.do">
					 	<i class="fa fa-fw fa-area-chart"></i> 
					 	<span class="nav-link-text">통계관리</span>
					</a>
				</li>
				
			</ul>
			
			<!-- 문의 최신 3개 출력 -->
			 <ul class="navbar-nav sidenav-toggler">
				<li class="nav-item"><a class="nav-link text-center"
					id="sidenavToggler"> <i class="fa fa-fw fa-angle-left"></i>
				</a></li>
			</ul> 
			<ul class="navbar-nav ml-auto">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle mr-lg-2" id="messagesDropdown" 
					href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
					<i class="fa fa-fw fa-envelope"></i> 
					<span class="d-lg-none">Messages 
					<span class="badge badge-pill badge-primary">${message } New</span></span> 
					<span class="indicator text-primary d-none d-lg-block"> 
					<i class="fa fa-fw fa-circle"></i>
					</span>
				</a>
					<div class="dropdown-menu" id="new-dropdown" aria-labelledby="messagesDropdown">
					
						<h6 class="dropdown-header">새로온 문의</h6>
						<c:forEach var="qnaitem" items="${qnalist }" varStatus="status">
						
						<div class="dropdown-divider"></div>
						
						<span class="small float-right text-muted">${qnaitem.write_date }</span>
						<a class="dropdown-item" href="#"> <strong>작성자 이메일 : ${qnaitem.email }<br>작성자 이름 : ${qnaitem.name }</strong> 
									
							<div class="dropdown-message small">
							<br>제목 : ${qnaitem.title } 
							<br>내용 : ${qnaitem.content }</div>
						</a>
					</c:forEach>
						 <div class="dropdown-divider"></div>
						<a class="dropdown-item small" href="adminQuestionBoard.do">자세히보기</a>
					
				<!-- 헬스장 등록요청 최신3개 출력 -->
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle mr-lg-2" id="alertsDropdown"
					href="#" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <i class="fa fa-fw fa-bell"></i> <span
						class="d-lg-none">Request <span
							class="badge badge-pill badge-warning">${gymrequest } New</span>
					</span> <span class="indicator text-warning d-none d-lg-block"> <i
							class="fa fa-fw fa-circle"></i>
					</span>
				</a>
				<div class="dropdown-menu" id="new-dropdown" aria-labelledby="messagesDropdown">
					
						<h6 class="dropdown-header">새로온 요청</h6>
						<c:forEach var="ritem" items="${gymRlist }" varStatus="status">
						
						<div class="dropdown-divider"></div>
						<span class="small float-right text-muted">${ritem.register_date }</span>
						<a class="dropdown-item" href="#"> <strong>사업자 이메일 : ${ritem.email }<br>사업자 이름 : ${ritem.name }</strong> 
						
							<div class="dropdown-message small">
							<br>상호 : ${ritem.gym_name }
							<br>종류 : ${ritem.category } 
							<br>지역 : ${ritem.location }</div>
						</a>
					</c:forEach>
				
					
						<div class="dropdown-divider"></div>
						<a class="dropdown-item small" href="adminbusinessRequestlist.do">자세히보기</a>
					</div></li>
				<li class="nav-item">
					<form class="form-inline my-2 my-lg-0 mr-lg-2">
						<div class="input-group">
							<input class="form-control" type="text"	placeholder="Search for..."> 
							<span class="input-group-btn">
								<button class="btn btn-primary" type="button">
									<i class="fa fa-search"></i>
								</button>
							</span>
						</div>
					</form> 
				<!-- </li><li><a href="adminlogout.do">로그아웃</a></li> -->
				<li class="nav-item"><a class="nav-link" data-toggle="modal"
					data-target="#exampleModal" href="logout.do"> <i class="fa fa-fw fa-sign-out"></i>Logout
				</a></li>
			</ul>
		</div>
	</nav>
