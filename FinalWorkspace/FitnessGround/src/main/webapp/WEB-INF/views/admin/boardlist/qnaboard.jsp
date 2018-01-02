<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:import url="../common/head.jsp" />

<style type="text/css">
#modalBodyATag {
	margin-right:30px;
	color:black;
	font-weight:bold;
	text-decoration:none;
}
#modalBodyATag:hover, #modalBodyATag:visited, #modalBodyATag:active {
	color:black;
	text-decoration:none;
}
#contentDiv {
	border:1px solid gray;
	height:250px;
	border-radius:0.3rem;
	
	padding:15px;
	
	
	max-height: 220px;
	overflow: hidden;
	overflow-y: auto;
}
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

function qnaDelete(cb_no){
	
	$.ajax({
		url : "qnaBoardDelete.do",
		dataType : "json",
		type : "post",
		data : {"cb_no" : cb_no},
		success : function(result){
			alert(cb_no + "번 게시물이 삭제 되었습니다.")
			location.href = "adminQNABoard.do";
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
			<li class="breadcrumb-item"><a href="adminMain.do">Fitness
					Ground</a></li>
			<li class="breadcrumb-item active">메인으로 이동</li>
		</ol>
		<!-- Example DataTables Card-->
		<div class="card mb-3">
			<div class="card-header">

				<div class="buttons">

					<button class="btn btn-warning" onclick="adminMettingBoard();">Meeting</button>
					<button class="btn btn-warning" onclick="adminQNABoard();">Q&A</button>
					<button class="btn btn-warning" onclick="adminReviewBoard();">Review</button>
					<button class="btn btn-warning" onclick="registerView();"
						align="right">공지사항 등록</button>


				</div>
			</div>

			<div class="card-body">
				<div class="table-responsive">
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
								<c:if test="${item.board_property == 1}">
									<tr align="center">
										<%-- <td><input type="checkbox" class="deleteCheckBox"
											name="deleteCheckBox" value="${item.user_no} " /></td> --%>
										<td>${status.count }</td>
										<td>${item.name }</td>
										<td align="left"><a href="meetingDetail.do"
											data-target=".${item.cb_no}" data-toggle="modal">${item.title }</a></td>
										<div class="modal fade ${item.cb_no }" tabindex="-1"
											role="dialog" aria-labelledby="myLargeModalLabel"
											aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<!-- header -->
													<div class="modal-header">
														<h4 class="modal-title" align="center" style="color:black;font-weight:bold;">제목 :
															${item.title}</h4>
														<button type="button" class="close" data-dismiss="modal" aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>

													<!-- body -->
													<div class="modal-body" align="left">
														<p><a id="modalBodyATag">작성자 :</a> ${item.name}</p>
														<p><a id="modalBodyATag">이메일 :</a> ${item.email }</p>
														<p><a id="modalBodyATag">작성일 :</a> ${item.upload_date}</p>
														<hr>
														<p><a id="modalBodyATag">내용 :</a><br><div id="contentDiv">${item.content}</div></p>
													</div>
													<!-- Footer -->
													<div class="modal-footer"></div>

												</div>

											</div>

										</div>
										<td>${item.upload_date }</td>
										<td>${item.readcount }</td>
										<td><button class="btn btn-primary"
												onclick="qnaDelete(${item.cb_no});">삭제</button></td>

									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="registerView" tabindex="-1" role="dialog"
				aria-labelledby="myLargeModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg" id="workout-dialog">

					<div class="modal-content">

						<div class="modal-header">
							<h2 class="modal-title" id="qnaBoard" color="red"
								style="color: black">Q&A 게시판 공지사항 등록하기</h2>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">x</button>

						</div>
						<form id="register_form" name='Community' method="post" action="adminqnaInsert.do">
							<input name="user_no" type="hidden" value="${sessionScope.user.user_no }" />

							<div class="modal-body">
								<div id="insert_all_div" style="border: 1px solid;">
									<br>
									<div id="div_head">
										<p>
											제목 <input name="title" type="text" placeholder="제목을 입력해주세요." />
										</p>
									</div>
									<textarea name="content" id="editor1"
										placeholder="내용을 입력해주세요.."></textarea>
									<script>
					CKEDITOR.replace('editor1');
				</script>


								</div>

							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-primary">Register</button>

								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
							</div>
						</form>
					</div>

				</div>

			</div>


			<div class="card-footer small text-muted"><h4>Total QnA : ${qnaCount }개</h4></div>

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