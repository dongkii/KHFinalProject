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
	function userlistPage() {
		location.href = "adminuserlist.do"
	}
	function businesslistPage() {
		location.href = "adminbusinesslist.do"
	}
	function businessRequestlistPage() {
		location.href = "adminbusinessRequestlist.do"
	}
	
	function userChange(user_no){		
		
		$.ajax({
			url : "adminUserState.do",
			dataType : "json",
			type : "post",
			data : {"user_no" : user_no},
			success: function(result){
				alert(user_no + " 회원이 비활성화되었습니다. ")
				location.href="adminuserlist.do";
			},
			error : function(request, status, error){
				alert("error code : " +request.status + "\n"
						+ "message : " +request.responseText + "\n"
						+ "error : " + errorData);
				
			}
				
			
		})
	}
	
	function userBack(user_no){
		
		$.ajax({
			url : "adminUserBack.do",
			dataType : "json",
			type : "post",
			data : {"user_no" : user_no},
			success: function(result){
				alert(user_no + " 회원이 활성화되었습니다.")
				location.href="adminuserlist.do";
			},
			error : function(request, status, error){
				alert("error code : " +request.status + "\n"
						+ "message : " +request.responseText + "\n"
						+ "error : " + errorData);
				
			}
				
			
		})
	}
	
	function checkUser(date){
		
		alert(date+" 탈퇴 예정인 사용자입니다.");
				  
				 
		

		
	}
	

	
</script>
<c:import url="../common/nav.jsp" />
<div class="content-wrapper">
	<div class="container-fluid">
		<!-- Breadcrumbs-->
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
						<form name="userForm">
							<table class="table table-bordered table-hover" id="dataTable" width="100%"	cellspacing="0">
								<thead>
									<tr align="center">
										<th>Index</th>
										<th>Email</th>
										<th>Name</th>
										<th>NickName</th>
										<th>Phone</th>
										<th>Level</th>
										<th>State</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach var="item" items="${list }" varStatus="status">
										  <c:choose>
										 	<c:when test="${item.user_state==0 && item.delete_date eq null}">
												<tr class="active">
											</c:when> 
										    <c:when test="${item.user_state==1 && item.delete_date eq null}">
												<tr class="success">
											</c:when>
											<c:when test="${item.user_state==0 || item.user_state==1 && item.delete_date != null }">
												<tr class="warning">
											</c:when>
										</c:choose> 
										 
											<td align="center">${status.count }</td>
											<td align="center"><a href="userDetail.do?user_no=${item.user_no }">${item.email }</a></td>
											<td align="center">${item.name }</td>
											<td align="center">${item.nickname }</td>
											<td align="center">${item.phone }</td>
											<td align="center">${item.user_level }</td>
											
											<c:if test="${item.delete_date eq null }">
											<c:choose>
																							
												<c:when test="${item.user_state == 0}">

													<td align="center"><button type="submit" class="btn btn-primary"
															onclick="userChange(${item.user_no});">비활성화</button></td>
												</c:when>
												<c:when test="${item.user_state == 1}">

													<td align="center"><button type="submit" class="btn btn-primary"
															onclick="userBack(${item.user_no});">활성화</button></td>
												</c:when>
												
																		
											</c:choose>
											</c:if>
											<c:if test="${item.delete_date ne null }" >
													
													<td align="center">
													<button class="btn btn-default" onclick="checkUser('${item.delete_date}');" >탈퇴계정</button></td>
												
											</c:if>

										</tr>
									</c:forEach>

								</tbody>
							</table>
						</form>
						</div>
				</div>
				
  
				<div class="card-footer small text-muted"><h4>Total :  ${total }명</h4></div>
			
		</div>
		<!-- /.container-fluid-->
		<!-- /.content-wrapper-->
		<c:import url="../common/footer.jsp" />
		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> 
		<i class="fa fa-angle-up"></i>
		</a>
		
		</div>
	</div>
	<c:import url="../common/end.jsp" />