<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	#gymQModalCUA {height:700px; padding:10px;}
	#gymQnAUATitle {font-size:20pt; padding-bottom:20px; padding-top:20px;}
	th {width:120px;}
	td {padding-left:20px;}
	#fileDiv button, #fileDiv a {width:80%;}
	#gymQSendBt {width:100%;}
</style>

<div class="modal modal-center fade" id="gymQnaUpAndAnswerModal" style="z-index:100;">
	<div class="modal-dialog modal-center modal-lg">
		<div class="modal-content" id="gymQModalCUA">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>	
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" align="center"><form id="gymQnAUAForm" method="post" enctype="multipart/form-data">
				<div id="gymQnAUATitle"></div>
				<input type="hidden" name="sender" value="${sessionScope.user.user_no}">
				<input type="hidden" name="receiver" value="">
				<%-- <input type="hidden" name="gym_no" value=""> --%>
				<input type="hidden" name="q_no" value="">
				<table>
					<tr>
						<th>Title : </th>
						<td colspan="2" style="padding-top:20px;" id="qUATitle"></td>
					</tr>
					<tr>
						<th>Date : </th>
						<td colspan="2" style="padding-top:20px;" id="qUADate"></td>
					</tr>
					<tr>
						<th>Content : </th>
						<td colspan="2" style="padding-top:20px; height:200px;" id="qDetailContent">
							<textarea rows="10" class="form-control" id="editor1" name="content" onkeyup="ckWordLen(this, 1500)"></textarea>
						</td>
					</tr>
				</table>
				<table id="fileDiv">
				</table>
				<table id="answerMode">
					<tr><td colspan="3" align="right" style="font-size:10pt; padding-bottom:10px;">최대 3개의 파일을 첨부하실 수 있습니다.</td></tr>
					<tr><td colspan="3" id="gymQUABt" align="right" style="padding-left:0px;"></td></tr>
				</table>
			</form></div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/fitnessground/resources/js/gym/gymQnA.js"></script>
<script type="text/javascript">
	function gymQnaUpAndAnswerModal(q_no, mode) {
		gfv_count = 1;
		$('input[name=q_no]').val(q_no);
		$.ajax({
	         url:"gymQnaDetailView.do",
	         dataType:"json",
	         type:"post",
	         data : {"q_no" : q_no},
	         success:function(data){
	         	var board = data.board;
	         	var files = data.originalFileNames;
				var user_no = ${sessionScope.user.user_no};
				
	         	$('#qUADate').html(board.stringWrite_date);

	    		if(mode === '1') { // 문의글 수정
	    			//$('#gymQModalCUA').css('height','600px');
	    			$('#qUATitle').html('<input class="form-control" type="text" name="title" value="'+board.title+'">');
		         	$('#editor1').html(board.content);
		         	$('#editor1').val($('#editor1').html().replace(/<br\s?\/?>/g,"\n"));
					$('#fileDiv').html('<tr><th>Files: </th>'
										+'<td><input type="file" class="form-control" id="file" name="file_0" style="width:100%"></td>'
										+'<td align="right"><button class="btn btn-default" onclick="return fn_addFile();">파일추가</button></td></tr>');
		         	/* $('#fileDiv').html('<tr id="file"><th>Files : </th><td colspan="2">없음</td></tr>');
		         	var fileOut = "";
		         	if(files != null) {
			         	for(var i=0; i<files.length; i++) {
			         		if(i==files.length-1) fileOut += "<a href='gymQnAFDown.do?bnum="+board.q_no+"&filename="+files[i]+"' name='file'>"+files[i]+"</a>";
			         		else fileOut += "<a href='gymQnAFDown.do?bnum="+board.q_no+"&filename="+files[i]+"' name='file'>"+files[i]+"</a>" + ", ";
			         	}
		         	} else {
		         		fileOut="첨부 파일 없음";
		         	}
		         	$('#file td').html(fileOut); */
		         	if(board.gym_name == "") {
		         		if(board.q_level==0) $('#gymQnAUATitle').html('관리자에 문의');
		         		else if(board.q_level==1) $('#gymQnAUATitle').html('답변');
		         		//$('#id").attr("readonly" true);
		         	}
		         	else {
		         		if(board.q_level==0) $('#gymQnAUATitle').html(board.gym_name+"에 문의");
		         		else if(board.q_level==1) $('#gymQnAUATitle').html("답변");
		         	}
					$('#gymQUABt').html('<button class="btn btn-default" onclick="gymQnAUpdate('+'\''+user_no+'\''+');" style="width:100%;">수정</button>');
	    		} 
	    		else if(mode === '2') { // 문의글에 대한 답변
	    			//$('#gymQModalCUA').css('height','700px');
	    			$("input[name=receiver]").val(board.sender);
	    			$('#qUATitle').html('<input class="form-control" type="text" name="title" value="[ 답 변 ] '+board.title+'" readonly>');
	    			$('#gymQnAUATitle').html(board.name+"님에게 답변");
		         	$('#editor1').html("Re: \n\n\n\n-------------------------------------\n\nOrigin: \n"+board.content);
					$('#file td').html("첨부 파일 없음");
					$('#gymQUABt').html('<button class="btn btn-default" onclick="return gymQnAAnswer('+'\''+user_no+'\''+');" style="width:100%;">답변</button>');
					$('#fileDiv').html('<tr><th>Files: </th>'
										+'<td><input type="file" class="form-control" id="file" name="file_0" style="width:100%"></td>'
										+'<td align="right"><button class="btn btn-default" onclick="return fn_addFile();">파일추가</button></td></tr>');		
				}
	         },
	         error: function(request, status, errorData){
	            alert("error code : " + request.status + "\n"
	                  + "message : " + request.responseText + "\n"
	                  + "error : " + errorData);
	         }
	      });

		$("#gymQnaDetailModal").hide();
		$("#gymQnaUpAndAnswerModal").show();
		$("#gymQnaUpAndAnswerModal").modal();
	}
</script>




<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="../include/common/head.jsp" />
<link rel="stylesheet" href="/fitnessground/resources/css/gym/gymQnA.css" />	
<c:import url="../include/common/headend.jsp" />

<c:if test="${ sessionScope.user == null }">
	<script type="text/javascript">
			$(function (){
				alert("로그인이 필요합니다.");
				location.href="main.do";
			});
		</script>
</c:if>

<div id="page-wrapper">
	<!-- Header -->
	<div id="mypage_header">
        <!-- Nav -->
		<c:import url="../include/main/nav.jsp" />
		<c:import url="../user/login.jsp"/>
		<c:import url="../user/findidpwd.jsp"/>
		<c:import url="../user/register.jsp"/>
	</div>
</div>

<div class="col-md-offset-2 col-md-8 hidden-xs hidden-sm hidden-md visible-lg" id="gymQTitle">
	<c:if test="${board.gym_name eq null}">
	관리자에 문의
	</c:if>
	<c:if test="${board.gym_name ne null}">
	${board.gym_name}에 문의
	</c:if>
</div>
<div class="col-md-offset-2 col-md-8 hidden-xs hidden-sm hidden-md visible-lg" id="gymQContent">
	<form id="gymQnAForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ref_no" value="${board.ref_no}">
	<c:if test="${mode eq 2}">
		<input type="hidden" name="receiver" value="${board.sender}">
		<c:if test="${board.gym_name eq null}">
		관리자에 문의
		</c:if>
		<c:if test="${board.gym_name ne null}">
		<input type="hidden" name="gym_name" value="${board.gym_name}">
		</c:if>
	</c:if>
	<input type="hidden" name="q_no" value="${board.q_no}">
	<input type="hidden" name="sender" value="${sessionScope.user.user_no}">
	<table>
		<tr>
			<th>제목</th>
			<td colspan="2" style="padding-bottom:50px;">
			<c:if test="${mode eq 1}">
				<input class="form-control" name="title" value="${board.title}">
			</c:if>
			<c:if test="${mode eq 2}">
				<input class="form-control" name="title" value="[ 답 변 ] ${board.title}" readonly>
			</c:if>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="2">
			<c:if test="${mode eq 1}">
				<textarea rows="15" class="form-control" name="content" onkeyup="ckWordLen(this, 1500)">${board.content}</textarea>
			</c:if>
			<c:if test="${mode eq 2}">
				<textarea rows="15" class="form-control" name="content" onkeyup="ckWordLen(this, 1500)"></textarea>
			</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="3" id="textCount" style="padding-bottom:40px;">0/1500</td>
		</tr>
	</table>
	<table id="fileDiv">
		<tr>
			<th>첨부파일</th>
			<td><input type="file" class="form-control" id="file" name="file_0" style='width:100%'></td>
			<td align='right'></td>
		</tr>
	</table>
	<table>
		<tr>
			<th></th>
			<td colspan="2" style="padding-bottom:70px;"><a href="#this" class="btn btn-default" id="addFile">파일 추가</a></td>
		</tr>
		<tr>
			<td id="insertBt" colspan="3" align="right">
			<c:if test="${mode eq 1}">
				<button class="btn btn-primary" onclick="gymQnAUpdate();">수정</button>
			</c:if>
			<c:if test="${mode eq 2}">
				<button class="btn btn-primary" onclick="gymQnAAnswer();">답변</button>
			</c:if>
			</td>
		</tr>
	</table>
	</form>
</div>

<!-- 모바일 -->
<div class="col-sm-12 visible-xs visible-sm visible-md hidden-lg" id="gymQTitleSm">
	<c:if test="${board.gym_name eq null}">
	관리자에 문의
	</c:if>
	<c:if test="${board.gym_name ne null}">
	${board.gym_name}에 문의
	</c:if>
</div>
<div class="col-sm-12 visible-xs visible-sm visible-md hidden-lg" id="gymQContentSm">
	<form id="gymQnAForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ref_no" value="${board.ref_no}">
	<c:if test="${mode eq 2}">
		<input type="hidden" name="receiver" value="${board.sender}">
		<c:if test="${board.gym_name eq null}">
		관리자에 문의
		</c:if>
		<c:if test="${board.gym_name ne null}">
		<input type="hidden" name="gym_name" value="${board.gym_name}">
		</c:if>
	</c:if>
	<input type="hidden" name="q_no" value="${board.q_no}">
	<input type="hidden" name="sender" value="${sessionScope.user.user_no}">
	<table>
		<tr>
			<th>제목</th>
			<td colspan="2" style="padding-bottom:50px;">
			<c:if test="${mode eq 1}">
				<input class="form-control" name="title" value="${board.title}">
			</c:if>
			<c:if test="${mode eq 2}">
				<input class="form-control" name="title" value="[ 답 변 ] ${board.title}" readonly>
			</c:if>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="2">
			<c:if test="${mode eq 1}">
				<textarea rows="15" class="form-control" name="content" onkeyup="ckWordLen(this, 1500)">${board.content}</textarea>
			</c:if>
			<c:if test="${mode eq 2}">
				<textarea rows="15" class="form-control" name="content" onkeyup="ckWordLen(this, 1500)"></textarea>
			</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="3" id="textCount" style="padding-bottom:40px;">0/1500</td>
		</tr>
		<tr><th colspan="3" >첨부파일</th></tr>
	</table>
	<table id="fileDivSm">
		<tr>
			<td><input type="file" class="form-control" id="file" name="file_0" style='width:100%'></td>
			<td align='right'></td>
		</tr>
	</table>
	<table>
		<tr>
			<td colspan="2" style="padding-bottom:50px;"><a href="#this" class="btn btn-default" id="addFileSm">파일 추가</a></td>
		</tr>
		<tr><td id="insertBt" colspan="2"><button class="btn btn-primary" style="width:100%;" onclick="gymQnAInsert();">등록</button></td></tr>
	</table>
	<table>
		<tr>
			<th></th>
			<td colspan="2" style="padding-bottom:70px;"><a href="#this" class="btn btn-default" id="addFile">파일 추가</a></td>
		</tr>
		<tr>
			<td id="insertBt" colspan="3" align="right">
			<c:if test="${mode eq 1}">
				<button class="btn btn-primary" onclick="gymQnAUpdate();">수정</button>
			</c:if>
			<c:if test="${mode eq 2}">
				<button class="btn btn-primary" onclick="gymQnAAnswer();">답변</button>
			</c:if>
			</td>
		</tr>
	</table>
	</form>
</div>


<script type="text/javascript" src="/fitnessground/resources/js/gym/gymQnA.js"></script>
<c:import url="../include/main/footer.jsp" />
<c:import url="../include/common/end.jsp" /> --%>