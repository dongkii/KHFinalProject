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

<script src="//cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script>
<script type="text/javascript">
function adminMettingBoard(){
	location.href="adminMettingBoard.do"
}
function adminQNABoard(){
	location.href="adminQNABoard.do"
}
function adminReviewBoard(){
	location.href="adminReviewBoard.do"
}

function registerView(){
	
	
	$("#registerView").show();
	$("#registerView").modal();
}

	function meetingBoardDelete(mb_no){
		
		
		$.ajax({
			url : "meetingBoardDelete.do",
			dataType : "json",
			type : "post",
			data : {"mb_no" : mb_no},
			success : function(result){
				alert(mb_no + "번 게시물이 삭제 되었습니다.")
				location.href = "adminMettingBoard.do";
			},
			error : function(request, status, error){
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
		<!-- Breadcrumbs-->
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="adminMain.do">Fitness Ground</a></li>
			<li class="breadcrumb-item active">메인으로 이동</li>
		</ol>
		<!-- Example DataTables Card-->
		<div class="card mb-3">
			<div class="card-header">

				<div class="buttons">

					<button class="btn btn-warning" onclick="adminMettingBoard();">Meeting</button>
					<button class="btn btn-warning" onclick="adminQNABoard();">Q&A</button>
					<button class="btn btn-warning" onclick="adminReviewBoard();">Review</button>
					<button class="btn btn-warning" onclick="registerView();" align="right" >공지사항 등록</button>

				</div>
</div>



				<div class="card-body">
					<div class="table-responsive">
					<form name="userForm">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr align="center">
									<th>Index</th>
									<th>Writer</th>
									<th>Title</th>
									<th>Date</th>
									<th>Hits</th>
									<th>Delete</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach var="item" items="${list }" varStatus="status">
									<tr align="center">
										<%-- <td><input type="checkbox" class="deleteCheckBox"
											name="deleteCheckBox" value="${item.user_no} " /></td> --%>
										<td>${status.count }</td>
										<td>${item.name }</td>
										<td align="left">
										<a  href="meetingDetail.do" data-target=".${item.mb_no}"
											data-toggle="modal">${item.title }</a></td>
										<div class="modal fade ${item.mb_no }" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<!-- header -->
													<div class="modal-header" align="top">
														<h4 class="modal-title" align="center">제목 : ${item.title}</h4>
														<button type="button" class="close" data-dismiss="modal" align="right">x</button>
													</div>
													
													<!-- body -->
													<div class="modal-body" align="left">
													<p align="right">작성자 : ${item.name}</p>
													<p align="right">이메일 : ${item.email }</p>
													<p align="right">작성일 : ${item.upload_date}</p><hr>
													<h4>내용 : </h4><p>${item.content}</p>
													</div>
     											<!-- Footer -->
													<div class="modal-footer" >
														
														
													</div>
													</div>
													
												</div>
												
											</div>
										
										
										<td>${item.upload_date }</td>
										<td>${item.readcount }</td>
										<td><button class="btn btn-primary" onclick="meetingBoardDelete(${item.mb_no});">삭제</button></td>

									</tr>
								</c:forEach>
							</tbody>
						</table>
						</form>
					</div>
				</div>
				
				<!-- Modal -->
  <div class="modal fade" id="registerView" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" id="workout-dialog">
    
      <div class="modal-content" id="workout-content">
      
        <div class="modal-header">  
          <h2 class="modal-title" id="meetingBoard" color="red"style="color: black">커뮤니티 게시판 공지사항 등록하기 </h2>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">x</button>
        
        </div>
        <form id="register_form" name="mboard" method="post" action="adminmeetingInsert.do">
        <input type="hidden" name="user_no" value="${sessionScope.user.user_no }">
        	<div class="modal-body">
				<div id="insert_all_div" style="border: 1px solid;">
				<br>
					
						
							<div id="div_head">
								<p>
									제목
							<input name="title" type="text" placeholder="제목을 입력해주세요."/>
								</p>				
							</div>
							
				<textarea name="content" id="editor1" placeholder="내용을 입력해주세요.."></textarea>
				<script>
					CKEDITOR.replace('editor1');
				</script>
				
				</div>
											
		  </div>
				<div class="modal-footer">
					
					<button type="submit" class="btn btn-primary" >Register</button>
					
      				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      			</div>
      			
      			</form>
      			
	  </div>
			
     </div>
      	
  </div>    
  </div>
				
				
				<div class="card-footer small text-muted"><h4>Total Board : ${boardCount }개</h4></div>
			
		</div>
		<!-- /.container-fluid-->
		<!-- /.content-wrapper-->
		<c:import url="../common/footer.jsp" />
		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="fa fa-angle-up"></i>
		</a>
		
	</div>
	<c:import url="../common/end.jsp" />