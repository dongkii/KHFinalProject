<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:import url="../common/head.jsp" />

<style type="text/css">
</style>


<c:import url="../common/headend.jsp" />
 <c:if test="${ sessionScope.user == null }">
		<script type="text/javascript">
			$(function (){
				alert("로그인이 필요합니다.");
				location.href="main.do";
			});
		</script>
	</c:if>
<script type="text/javascript">
	function userlistPage(){
		location.href="adminuserlist.do"
	}
	function businesslistPage(){
		location.href="adminbusinesslist.do"
	}
	function businessRequestlistPage(){
		location.href="adminbusinessRequestlist.do"
	}
	
	function gymRequest(gym_no, user_state){
		/* alert("버튼클릭 : " +gym_no +" ,  유저 상태 : "+ user_state); */
		
		if(user_state == 1){
			alert("해당 계정은 비활성 상태입니다. 헬스장을 등록할 수 없습니다.");
		}else{
		$.ajax({
			url : "gymRequest.do",
			dataType : "json",
			type : "post",
			data : {"gym_no" : gym_no},
			success : function(result) {
				alert("등록되었습니다.")
				location.href="adminbusinessRequestlist.do";
			},
			error : function(request, status, error) {
				alert("error code : " +request.status + "\n"
						+ "message : " +request.responseText + "\n"
						+ "error : " + errorData);
			}
			
		})
		}
		
		
		
	}
	
	function gymCancel(gym_no){
		/* alert("버튼클릭 : " +gym_no); */
		
		$.ajax({
			url : "gymCancel.do",
			dataType : "json",
			type : "post",
			data : {"gym_no" : gym_no},
			success : function(result) {
				alert("등록이 취소 되었습니다.")
				location.href="adminbusinessRequestlist.do";
			},
			error : function(request, status, error) {
				alert("error code : " +request.status + "\n"
						+ "message : " +request.responseText + "\n"
						+ "error : " + errorData);
			}
			
		})
		
		
	}	
	
</script>
<c:import url="../common/nav.jsp" />
<div class="content-wrapper">
	<div class="container-fluid">
		
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="adminMain.do">Fitness Ground</a></li>
			<li class="breadcrumb-item active">메인으로 이동</li>
		</ol>
		<!-- Example DataTables Card-->
		<div class="card mb-3">
			<div class="card-header">

				<div class="buttons" align="right">

					<!-- <button class="btn btn-warning" onclick="userlistPage();">일반회원</button>
					<button class="btn btn-warning" onclick="businesslistPage();">사업자회원</button> -->
					<button class="btn btn-primary" onclick="businessRequestlistPage();">등록요청보기</button>


				</div>
			</div>
	
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered table-hover" id="dataTable" width="100%"	cellspacing="0">
							<thead>
								<tr align="center">
									<th>Index</th>
									<th>State</th>
									<th>Email</th>
									<th>Name</th>
									<th>Gym_No</th>
									<th>Gym_Name</th>
									<th>Location</th>
									<th>Date</th>
									<th>Permission</th>
								</tr>
							</thead>
							<!-- <tfoot>
                <tr>
                  <th>Name</th>
                  <th>Position</th>
                  <th>Office</th>
                  <th>Age</th>
                  <th>Start date</th>
                  <th>Salary</th>
                </tr>
              </tfoot> -->
							<tbody>
								<c:forEach var="item" items="${list }" varStatus="status">
									<c:choose>
											<c:when test="${item.approval_state==0}">
												<tr>
											</c:when>
											<c:when test="${item.approval_state==1}">
												<tr>
											</c:when>
									</c:choose>
										<td>${status.count }</td>
										<td>${item.user_state }</td>
										<td>${item.email }</td>
										<td>${item.name }</td>
										<td>${item.gym_no }</td>
										<td><a href="detailgym.do?gym_no=${ item.gym_no }">${item.gym_name }</a></td>
										<td>${item.location }</td>
										<td>${item.register_date }</td>
										<c:choose>
											<c:when test="${item.approval_state==0}">

												<td><button type="submit" class="btn btn-primary"
														onclick="gymRequest(${item.gym_no}, ${item.user_state});">등록하기</button></td>
											</c:when>
											<c:when test="${item.approval_state==1}">

												<td><button type="submit" class="btn btn-primary"
														onclick="gymCancel(${item.gym_no});">등록취소</button></td>
											</c:when>

										</c:choose>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="card-footer small text-muted"><h4>대기중인 헬스장 : ${gymrequest }개</h4><br><h4>승인된 헬스장 : ${count }개</h4></div>
			
		</div>
		<!-- /.container-fluid-->
		<!-- /.content-wrapper-->
		<c:import url="../common/footer.jsp" />
		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="fa fa-angle-up"></i>
		</a>
		</div>
		
	</div>
	
	<c:import url="../common/end.jsp" />