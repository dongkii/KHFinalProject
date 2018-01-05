<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	#gymQModalC {height:620px; padding:10px;}
	#gymQnATitle {font-size:20pt; padding-bottom:10px; font-weight:bold; color:black;}
	th {width:120px; font-weight:bold; color:black;}
	td {padding-left:20px;}
	#fileDiv button, #fileDiv a {width:80%;}
	#gymQSendBt {width:100%;}
	#readContent{
		font-size:14pt; padding:15px;
		max-height: 230px;
		overflow: hidden;
		overflow-y: auto;
	}
</style>

<div class="modal modal-center fade" id="gymQnaDetailModal">
	<div class="modal-dialog modal-center modal-lg">
		<div class="modal-content" id="gymQModalC">
			<div class="modal-header" align="top">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>	
				<h4 id="gymQnATitle" class="modal-title" align="center"></h4>
			</div>
			
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" align="center">
				<input type="hidden" name="sender" value="${sessionScope.user.user_no}">
				<input type="hidden" name="receiver" value="">
				<input type="hidden" name="gym_no" value="">
				<table>
					<tr>
						<th>Title : </th>
						<td colspan="2" style="padding-top:20px;" id="qDetailTitle"></td>
					</tr>
					<tr>
						<th>Sender : </th>
						<td colspan="2" style="padding-top:20px;" id="qDetailSender"></td>
					</tr>
					<tr>
						<th>Date : </th>
						<td colspan="2" style="padding-top:20px;" id="qDetailDate"></td>
					</tr>
					<tr>
						<th>Content : </th>
						<td colspan="2" style="padding-top:20px; height:250px;" id="qDetailContent">
							<div class="form-control" id="readContent" style="height:300px;"></div>
							<!-- <textarea rows="13" class="form-control" id="readContent" name="content" readonly></textarea> -->
						</td>
					</tr>
				</table>
				<table>
					<tr id="file">
						<th>Files : </th>
						<td colspan="2">없음</td>
					</tr>
				</table>
				<div class="modal-footer" id="gymQDBt" align="right"></div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/fitnessground/resources/js/gym/gymQnA.js"></script>
<script type="text/javascript">
	function gymQnaDetailModal(q_no) {
		/* $('#gymQnATitle').html(gym_name+'에 문의');
		$("input[name=receiver]").val(gym_no);
		$("input[name=gym_no]").val(gym_no); */
		$.ajax({
	         url:"gymQnaDetailView.do",
	         dataType:"json",
	         type:"post",
	         data : {"q_no" : q_no},
	         success:function(data){
	         	var board = data.board;
	         	var files = data.originalFileNames;

	         	$('#qDetailTitle').html(board.title);
	         	$('#qDetailDate').html(board.stringWrite_date);
	         	/* $('#qDetailContent').html(board.content);
	         	$('#qDetailContent').html($('#qDetailContent').html().replace(/<br\s?\/?>/g,"\n")); */
	         	$('#readContent').html(board.content);
	         	$('#readContent').html($('#readContent').html().replace(/<br\s?\/?>/g,"\n").replace(/\n/gi,"<br/>"));
	         	$('#qDetailSender').html(board.name + " (" + board.email + ")");
	         	if(board.gym_name == "") {
	         		if(board.q_level==0) $('#gymQnATitle').html('관리자에 문의');
	         		else if(board.q_level==1) $('#gymQnATitle').html('답변');
	         	}
	         	else {
	         		if(board.q_level==0) $('#gymQnATitle').html("'"+board.gym_name+"'"+"에 문의");
	         		else if(board.q_level==1) $('#gymQnATitle').html("답변");
	         	}
	         	var fileOut = "";
	         	if(files != null) {
		         	for(var i=0; i<files.length; i++) {
		         		if(i==files.length-1) fileOut += "<a href='gymQnAFDown.do?bnum="+board.q_no+"&filename="+files[i]+"' name='file'>"+files[i]+"</a>";
		         		else fileOut += "<a href='gymQnAFDown.do?bnum="+board.q_no+"&filename="+files[i]+"' name='file'>"+files[i]+"</a>" + ", &nbsp; ";
		         	}
	         	} else {
	         		fileOut="첨부 파일 없음";
	         	}
	         	$('#file td').html(fileOut);
	         	
				var user_no = ${sessionScope.user.user_no};
				var bt = "";
				var del = "gymQnADel.do?q_no=" + board.q_no + "&userno=" + user_no;
				var update = "javascript:gymQnaUpAndAnswerModal('" + board.q_no + "','1')";
				var answer = "javascript:gymQnaUpAndAnswerModal('" + board.q_no + "','2')";
				if(board.sender == user_no) {
					bt += '<a href="' + del + '"><i class="fa fa-trash" aria-hidden="true" style="font-size:13pt"> 삭제</i></a>'
						+ '<a href="' + update + '" style="margin-left:40px;"><i class="fa fa-pencil" aria-hidden="true" style="font-size:13pt;"> 수정</i></a>'; 
				}
				if(board.receiver == user_no) {
					if(board.response_state == 0) 
						bt += '<a href="' + answer + '" style="margin-left:40px;"><i class="fa fa-envelope-o" aria-hidden="true" style="font-size:13pt;"> 답변</i></a>'; 
				}
				$('#gymQDBt').html(bt);
	         },
	         error: function(request, status, errorData){
	            alert("error code : " + request.status + "\n"
	                  + "message : " + request.responseText + "\n"
	                  + "error : " + errorData);
	         }
	      });
		
		$("#gymQnaDetailModal").show();
		$("#gymQnaDetailModal").modal();
	}
</script>