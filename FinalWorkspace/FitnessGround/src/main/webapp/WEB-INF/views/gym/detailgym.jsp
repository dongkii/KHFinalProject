<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8; IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">

<c:import url="../include/common/head.jsp" />
<c:import url="/WEB-INF/views/gym/gymQnAInsertView.jsp"/>

<style type="text/css">
	body{
		position: relative;
	}

	.scrollspy-example {
		position: relative;
		height: auto;
		max-height: 70vh;
		overflow: hidden;
		overflow-y: auto;
		margin-right: -20px;
	}
	
	#detailimg {
		width: 100%;
		height: 60vh;
	}
	
	#gyminfo {
		padding-left: 10px;
		padding-right: 0px;
		padding-top : 10px;
		padding-bottom : 10px;
	}
	
	#gyminfo> div{
		margin-top: 10px;
	}
	
	#gymdesc {
		height: 100px;
		max-height: 100px;
		overflow: hidden;
		overflow-y: auto;
	}
	
	.nav-tabs > li{
		padding: 0px;
		text-align: center;
	}
	#navbar-example{
		margin: 0px;
		border-bottom-left-radius: 0px;
		border-bottom-right-radius: 0px;
	}
	
	#background{
		position: relative;
		padding: 0px;
		height: 50px;
		z-index: 3;
		top: -90vh;
		background-color: #ffffff;
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		margin-top: 20px;
	}
	
	#contents {
		position: absolute;
		width: 100%;
		overflow: hidden;
		background-color: #ffffff;
		margin-left: auto;
		border-bottom-left-radius: 10px;
		border-bottom-right-radius: 10px;
		padding-left: 10px;
		padding-top: 10px;
	}
	
	#anchor {
		padding: 0px;
		margin-bottom: 0px;
	}
	
	.list-group > #list-item2{
		padding: 0px;
		margin-right: 20px;
	}
	
	.list-group > #list-item1{
		margin-right: 20px;
	}
	
	#list-item1 {
		font-weight: bold;
	}
	
	#comment {
		height: 500px;
		margin-bottom: 20px;
	}
	
	.btn-holder {
	text-align: center;
	margin: 10px 0 10px 0;
	}
	
	#calendar table {
		border-collapse: collapse;
		text-align: center;
	}
	
	#calendar table thead td {
		height: 30px;
		font-weight: bold;
	}	
	
	#calendar table td {
		border: solid 1px #000;
	}
	
	#calendar table td.date-cell {
		height: 55px;
	}
	
	#calendar table td.sun {
		color: red;
	}
	
	#calendar table td.sat {
		color: blue;
	}
	
	#calendar table td.not-this-month {
		background: #ddd;
		color: #999;
	}
	
	#adminback{
		position: absolute;
		background: rbga(0,0,0,0);
		top: 5vh;
		left: 5vw;
		z-index: 10;
	}
</style>

<c:import url="../include/common/headend.jsp" />

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=G0XI103VNKmTZuGNcR9G&submodules=geocoder"></script>

<div style="height: 90vh;">	
	<img src="resources/images/header.jpg" style="position:relative; width:100vw; height:90vh; z-index: 1">
	<div id="page-wrapper">
		<!-- Header -->
		<div id="mypage_header">
			<!-- Nav -->
			<c:import url="../include/main/nav.jsp" />

			<c:import url="../user/login.jsp" />
			<c:import url="../user/findidpwd.jsp" />
			<c:import url="../user/register.jsp" />
		</div>
	</div>
	
	<c:if test="${ sessionScope.user.user_level == 2 }">
		<div id="adminback">
			<button class="btn btn-info" onclick="adminpage();">관리자 헬스장 목록으로 이동</button>
		</div>
	</c:if>
	
	<div class="container" id="background">
		<nav id="navbar-example" class="navbar navbar-default navbar-static" role="navigation">
			<div class="navbar form-control" id="anchor">
			    <ul class="nav nav-tabs" role="tablist">
			      <li class="col-lg-3 col-md-3 col-sm-3 col-xs-3"><a href="#" onclick="return scrollmove(1);"><i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp;정보</a></li>
			      <li class="col-lg-3 col-md-3 col-sm-3 col-xs-3"><a href="#" onclick="return scrollmove(2);"><i class="fa fa-calendar" aria-hidden="true"></i>&nbsp;일정</a></li>
			      <li class="col-lg-3 col-md-3 col-sm-3 col-xs-3"><a href="#" onclick="return scrollmove(3);"><i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp;위치</a></li>
			      <li class="col-lg-3 col-md-3 col-sm-3 col-xs-3"><a href="#" onclick="return scrollmove(4);"><i class="fa fa-comments-o" aria-hidden="true"></i>&nbsp;후기</a></li>
			    </ul>
			 </div>
		</nav>
		<div id="contents">
			<div data-spy="scroll" data-target="#navbar-example" id="scrollView" class="scrollspy-example">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px;" id="info">
					<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12" style="padding: 0px;">
						<input type="hidden" id="imagevalue" value="${ gym.rename_image }"> 
						<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
						  <!-- Indicators -->
						  <ol class="carousel-indicators" id="indicator">
						    	<!--  -->
						  </ol>
						
						  <!-- Wrapper for slides -->
						  <div class="carousel-inner" id="inner" role="listbox">
							<!-- 이미지 아이템 -->
						  </div>
						
						  <!-- Controls -->
						  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev" style="max-width:70px;">
						    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						    <span class="sr-only">Previous</span>
						  </a>
						  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next" style="max-width:70px;">
						    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						    <span class="sr-only">Next</span>
						  </a>
						</div>
					</div>
					
					<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12" id="gyminfo">
						<!-- 헬스장 정보 -->
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<h3 style="font-weight: bold;">${ gym.gym_name }</h3>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<h6 style="font-weight: bold;"><span class="glyphicon glyphicon-time"></span>&nbsp;&nbsp;운영시간</h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top: 5px;">
							<h6>${ gym.op_time }</h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<h6 style="font-weight: bold;"><span class="glyphicon glyphicon-earphone"></span>&nbsp;&nbsp;전화번호</h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top: 5px;">
							<h6>${ gym.tel }</h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<h6 style="font-weight: bold;"><span class="glyphicon glyphicon-phone"></span>&nbsp;&nbsp;핸드폰번호</h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top: 5px;">
							<h6>${ gym.phone }</h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<h6 style="font-weight: bold;"><i class="fa fa-krw" aria-hidden="true"></i>&nbsp;&nbsp;가격</h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top: 5px;">
							<h6>${ gym.price }</h6>
							
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<h6 style="font-weight: bold;"><i class="fa fa-clone" aria-hidden="true"></i>&nbsp;&nbsp;분류</h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top: 5px;">
							<h6>${ gym.category }</h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<h6 style="font-weight: bold;"><a href="#" onclick="return scrollmove(3);"><i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp;&nbsp;위치</a></h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top: 5px;">
							<h6><a href="#" onclick="return scrollmove(3);">${ gym.location }</a></h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<h6 style="font-weight: bold;"><i class="fa fa-list-alt" aria-hidden="true"></i>&nbsp;&nbsp;헬스장 소개</h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top: 5px;" id="gymdesc">
							<h6>${ gym.description }</h6>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-right: 22px" align="right">
							<button class="btn btn-danger" onclick="javascript:gymQnaInsertModal('${gym.gym_name}','${gym.gym_no}')">문의하기</button>
						</div>
					</div>
				</div>
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px;" id="schedule">
					<ul class="list-group">
					 	 <li class="list-group-item" id="list-item1"><h4><i class="fa fa-calendar" aria-hidden="true"></i>&nbsp;&nbsp;일정</h4></li>
					 	 <li class="list-group-item" id="list-item2" style="padding-left: 20px; padding-right: 20px; height: 480px;">
					 	 	<div>
								<div class='btn-holder'>
									<button id='btnPrev' class="btn btn-danger">&lt;</button>
								 	<span id='currentDate'></span> 
									<button id='btnNext' class="btn btn-danger">&gt;</button>
								</div>
								<div id="calendar"></div>
							</div>
						</li>
					</ul>
					<!-- 달력 -->
				</div>
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px;" id="location">
					<!-- 지도 -->
					<input type="hidden" id="jsgym_no" value="${ gym.gym_no }">
					<input type="hidden" id="jsgym_name" value="${ gym.gym_name }">
					<input type="hidden" id="jscategory" value="${ gym.category }">
					<input type="hidden" id="jstel" value="${ gym.tel }">
					<input type="hidden" id="jsphone" value="${ gym.phone }">
					<input type="hidden" id="jsdesc" value="${ gym.description }">
					<input type="hidden" id="address" value="${ gym.location }">
					
					<ul class="list-group">
					  <li class="list-group-item" id="list-item1"><h4><i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp;&nbsp;위치</h4></li>
					  <li class="list-group-item" id="list-item2">
					  	<div id="map" style="width:100%;height:480px;">
						<!-- 지도 api 위치 -->
						</div>
					  </li>
					</ul>
				</div>
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px;" id="comment">
					<!-- 헬스장 댓글부분 -->
					헬스장 댓글부분
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/fitnessground/resources/js/gym/detailgym.js"></script>  
<script type="text/javascript" src="/fitnessground/resources/js/gym/gymdetailcalendar.js"></script>
	
<c:import url="../include/main/footer.jsp" />

<c:import url="../include/common/end.jsp" />