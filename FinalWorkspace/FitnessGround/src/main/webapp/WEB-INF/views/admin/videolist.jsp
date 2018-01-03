<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page
	import="com.kh.fitnessground.workout.yoga.model.vo.Yoga, java.util.List"%>

<c:import url="common/head.jsp" />

<link href="/fitnessground/resources/admin/css/workout-admin.css" rel="stylesheet">

<c:import url="common/headend.jsp" />


<c:import url="common/nav.jsp" />

<!-- Body부분  -->
<div class="content-wrapper">
	<div class="container-fluid">
	<!-- Breadcrumbs-->
		
		<ol class="breadcrumb">
		<h3 id="page-title">&nbsp;동영상관리</h3>
			<li class="breadcrumb-item active ct"><a href="adminylist.do" id="active" class="all">ALL </a></li>
			<li class="breadcrumb-item ct"><a href="javascript: listing('헬스')" class="헬스" >헬스</a> </li>
			<li class="breadcrumb-item ct"><a href="javascript: listing('요가')" class="요가">요가 </a></li>
			<li class="breadcrumb-item ct"><a href="javascript: listing('필라테스')" class="필라테스">필라테스</a></li>
			<li class="breadcrumb-item ct"><a href="javascript: listing('맨몸운동')" class="맨몸운동">맨몸운동 </a></li>
		</ol>

		<!-- Example DataTables Card-->
		<div class="card mb-3">
			<div class="card-header">
				<h4>동영상추가하기</h4>
				<p>youtube playlist id를 입력하세요 .</p>
				<div class="input-area">
				<span>운동: </span>
				<select name="select-workout" id="select-workout" class="form-control">
					<option value="2">요가</option>
					<option value="3">필라테스</option>
					<option value="4">맨몸운동</option>
					
				</select>
				<span>카테고리: </span>
				<select name="select-ct" id="select-ct" class="form-control">
					<option value="2">빈야사</option>
					<option value="2">다이어트</option>
					<option value="2">체형교정</option>
					<option value="2">부위별</option>
					<option value="2">초보자</option>
					<option value="3">스트레칭</option>
					<option value="3">복근집중운동</option>
					<option value="3">전신운동</option>
					<option value="3">하체운동</option>
					<option value="4">맨몸푸시업</option>
					<option value="4">맨몸하체</option>
					<option value="4">맨몸철봉</option>
					<option value="4">맨몸전신</option>
					<option value="4">맨몸초보자</option>
					
				</select>
				<input type="text" class="form-control" placeholder="playlist Id입력" id="playlist_id" oninput="idCheck();">
				
				<button class="btn btn-info" onclick="insert()">추가</button>
				<div id="check-msg"></div>
				</div>
				
				
			</div>
			<div id="card-result"></div>
			<div class="card-body">
					<div class="table-responsive">
							<div id="loadingDiv">
								  <div class="loader">
								    <svg class="circular" viewBox="25 25 50 50">
								      <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"/>
								    </svg>
								  </div>
								</div>
							<table class="table table-bordered" id="dataTable" width="100%"
								cellspacing="0">
								<thead>
									<tr>
										<th id="ch"><input type="checkbox" id="selectall"/></th>
										<th>v_no</th>
										<th>Title</th>
										<th>운동</th>
										<th>category</th>
										<th>조회수</th>
										<th>관리</th>
									</tr>
								</thead>
								<tbody id="rows">
									
									<c:forEach var="item" items="${list }" varStatus="status">
										<tr id="tr-${item.v_no }">
											<td><input type="checkbox" class="case" name="case" value="${item.v_no }"/></td>
											<td>${item.v_no }</td>
											<td>${item.title }</td>
											<td>${item.category1 }</td>
											<td>${item.category2 }</td>
											<td>${item.readcount }</td>
											<td><a class="cps" aria-expanded="false" data-target = "#collapse${item.v_no }" data-toggle="collapse" href="#collapse${item.v_no }">
                                 				<button type="submit" class="btn btn-primary btn-sm" onclick="editView(${item.v_no})">수정</button></a>
												<button type="submit" class="btn btn-danger btn-sm"
															onclick="deleteOne(${item.v_no})">삭제</button>
											</td>

										</tr>
										<%-- <tr id='collapse${item.v_no }' class='collapse in' data-parent='collapse-${item.v_no }'>
										<td colspan='6'></td></tr> --%>
									</c:forEach>

								</tbody>
							</table>
						
						</div>
				</div>
		</div>
		<script type="text/javascript" src="/fitnessground/resources/admin/js/videolist.js"></script>
		
		
<!-- admin common code  -->		
		<!-- /.container-fluid-->
		<!-- /.content-wrapper-->
		<c:import url="common/footer.jsp" />
		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> 
		<i class="fa fa-angle-up"></i>
		</a>
	</div>
	</div>
<c:import url="common/end.jsp" />
