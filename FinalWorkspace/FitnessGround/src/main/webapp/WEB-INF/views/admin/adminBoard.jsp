<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="common/head.jsp" />

<style type="text/css">
</style>

<c:import url="common/headend.jsp" />
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
$( document ).ready(function() {
	$('#qnaResponse').on('show.bs.modal', function (event) {
		  var button = $(event.relatedTarget)
		  var sender = button.data('sender')
		  var qno = button.data('qno')
		  
		  console.log("sender: "+sender+", qno: "+qno);
		  
		  var modal = $(this)
		 
		 $('#responseQ_no').val(qno)
		  modal.find('#receiver').val(sender)
		 
		});
});


</script>

<c:import url="common/nav.jsp" />

<div class="content-wrapper">
	<div class="container-fluid">
		<!-- Breadcrumbs-->
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="adminMain.do">Fitness
					Ground</a></li>
			<li class="breadcrumb-item active">메인으로 이동</li>
		</ol>
		<!-- Example DataTables Card-->
		<div class="card mb-3">
			<div class="card-header">

				<div class="buttons">

					<button class="btn btn-primary" onclick="adminBoard();">문의함</button>


				</div>
			</div>

			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr align="center">
								<th>Index</th>
								<th>User_no</th>
								<th>Writer</th>
								<th>Title</th>
								<th>Date</th>
								<th>State</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="item" items="${list }" varStatus="status">
									<c:choose>
										<c:when test="${item.response_state == 1 }">
											<tr id="Activation">
										</c:when>
										<c:when test="${item.response_state == 0 }">
											<tr id="inactive">
										</c:when>
									</c:choose>
									
										<td>${status.count }</td>
										<td>${item.user_no }</td>
										<td>${item.name }</td>
										<td><a href="#"	data-target=".${item.q_no}" data-toggle="modal">${item.title }</a></td>
										<td>${item.write_date }</td>
											<c:choose>
												<c:when test="${item.response_state==0}">

													<td>
													<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#qnaResponse" data-sender="${item.sender }" data-qno="${item.q_no}">답변</button></td>
												</c:when>
												<c:when test="${item.response_state==1}">

													<td><button type="submit" class="btn btn-primary"
															onclick="qnaModify(${item.q_no});">완료</button><%-- 
															<button type="submit"  class="btn btn-success"
															onclick="qnaConfirm(${item.q_no});">확인</button></td> --%>
												</c:when>

											</c:choose>
										
									</tr>
									<div class="modal fade ${item.q_no }" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<!-- header -->
													<div class="modal-header" align="top">
														<h4 class="modal-title" align="center">Title : ${item.title }</h4>
														<button type="button" class="close" data-dismiss="modal" align="right">x</button>
													</div>
													
													<!-- body -->
													<div class="modal-body" align="left">
													<p align="right">Sender : ${item.name }</p>
													<p align="right">Email : ${item.email }</p>
													<p align="right">Date : ${item.write_date}</p><hr>
													<p>Content : ${item.content}</p>
													
													
													
													
													</div>
     											<!-- Footer -->
													<div class="modal-footer" >
														
														
													</div>
													
												</div>
												
											</div>
										
										</div>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			
							<!-- Modal -->
  <div class="modal fade" id="qnaResponse" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" id="workout-dialog">
    
      <div class="modal-content" id="workout-content">
      
        <div class="modal-header">  
          <h2 class="modal-title" id="GymQnABoard" color="red"style="color: black">문의글 답변하기 </h2>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">x</button>
        
        </div>
        <form id="register_form" name="mboard" method="post" action="qnaResponse.do">
        
        	<div class="modal-body">
        	<input type="hidden" id="responseQ_no" name="responseQ_no" value="">
        	<input type="hidden" id="receiver" name="receiver" value="">
        	<input type="hidden" id="sender" name="sender" value="${sessionScope.user.user_no }">
        	
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
			<div class="card-footer small text-muted"><h4>Total Message : ${message }개</h4></div>

		</div>
		<!-- /.container-fluid-->
		<!-- /.content-wrapper-->
		<c:import url="common/footer.jsp" />
		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="fa fa-angle-up"></i>
		</a>
		
		</div>
	</div>
	<c:import url="common/end.jsp" />