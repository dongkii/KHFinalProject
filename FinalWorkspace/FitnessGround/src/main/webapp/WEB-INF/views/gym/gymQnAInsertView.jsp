<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	#gymQModalCUA {height:730px; padding:10px;}
	#gymQnAUATitle {font-size:20pt;padding-bottom:10px; font-weight:bold; color:black;}
	th {width:120px;font-weight:bold;}
	td {padding-left:20px;}
	#fileDiv button, #fileDiv a {width:80%;}
	#gymQSendBt {width:100%;}
</style>

<div class="modal modal-center fade" id="gymQnaUpAndAnswerModal" style="z-index:100;">
	<div class="modal-dialog modal-center modal-lg">
		<div class="modal-content" id="gymQModalCUA">
			<div class="modal-header" align="top">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>	
				<h4 id="gymQnAUATitle" class="modal-title" align="center"></h4>
			</div>
			<div class="modal-body col-lg-12 col-md-12 col-sm-12 col-xs-12" align="center"><form id="gymQnAUAForm" method="post" enctype="multipart/form-data">
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
					<!-- <tr><td colspan="3" id="gymQUABt" align="right" style="padding-left:0px;"></td></tr> -->
				</table>
				<div class="modal-footer" id="gymQUABt" align="right"></div>
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
	         	$('#editor1').html();

	    		if(mode === '1') { // 문의글 수정
	    			//$('#gymQModalCUA').css('height','600px');
	    			$('#qUATitle').html('<input class="form-control" type="text" name="title" value="'+board.title+'">');
		         	$('#editor1').html(board.content);
		         	$('#editor1').val($('#editor1').html().replace(/<br\s?\/?>/g,"\n"));
		         	$('#file td').html("첨부 파일 없음");
					$('#fileDiv').html('<tr><th>Files: </th>'
										+'<td><input type="file" class="form-control" id="file" name="file_0" style="width:100%"></td>'
										+'<td align="right"><button class="btn btn-default" onclick="return fn_addFile();" style="border:none;"><i class="fa fa-plus-square fa-2x" aria-hidden="true"></i></button></td></tr>');	
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
	    			$('#qUATitle').html('<input class="form-control" type="text" name="title" value="[ 답변 ] '+board.title+'" readonly>');
	    			$('#gymQnAUATitle').html(board.name+"님에게 답변");
		         	$('#editor1').html("Re: \n\n\n\n-------------------------------------\n\nOrigin: \n"+board.content);
		         	$('#editor1').val($('#editor1').html().replace(/<br\s?\/?>/g,"\n"));
					$('#file td').html("첨부 파일 없음");
					$('#fileDiv').html('<tr><th>Files: </th>'
										+'<td><input type="file" class="form-control" id="file" name="file_0" style="width:100%"></td>'
										+'<td align="right"><button class="btn btn-default" onclick="return fn_addFile();" style="border:0px;"><i class="fa fa-plus-square fa-2x" aria-hidden="true"></i></button></td></tr>');		
					$('#gymQUABt').html('<button class="btn btn-default" onclick="return gymQnAAnswer('+'\''+user_no+'\''+');" style="width:100%;">답변</button>');
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