<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	#gymQModalC {height:700px;}
	#gymQnATitle {font-size:20pt;padding-bottom:10px; font-weight:bold; color:black;}
	#gymQnAForm {padding:10px;}
	th {width:120px; font-weight:bold;}
	td {padding-left:20px;}
	#fileDiv button, #fileDiv a {width:80%;}
	#gymQSendBt {width:100%;}
</style>

<div class="modal modal-center fade" id="gymQnaInsertModal" style="z-index:100;">
	<div class="modal-dialog modal-center modal-lg">
		<div class="modal-content" id="gymQModalC">
			<div class="modal-header" align="top">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>	
				<h4 id="gymQnATitle" class="modal-title" align="center"></h4>
			</div>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" align="center">
				<form action="gymQnAInsert.do" id="gymQnAForm" method="post" enctype="multipart/form-data">
					<input type="hidden" name="sender" value="${sessionScope.user.user_no}">
					<input type="hidden" name="receiver" value="">
					<input type="hidden" name="gym_no" value="">
					<table>
						<tr>
							<th>Title</th>
							<td colspan="2" style="padding-top:20px;"><input class="form-control" name="title"></td>
						</tr>
						<tr>
							<th>Content</th>
							<td colspan="2" style="padding-top:20px;"><textarea rows="10" class="form-control" id="editor1" name="content" onkeyup="ckWordLen(this, 1500)"></textarea></td>
						</tr>
						<tr>
							<td colspan="2" id="textCount" style="text-align:right">0/1500</td>
						</tr>
					</table>
					<table id="fileDiv">
						<tr>
							<th>Files</th>
							<td><input type="file" class="form-control" id="file" name="file_0" style='width:100%'></td>
							<td align='right'><button class="btn btn-default" onclick="return fn_addFile();" style="border:none"><i class="fa fa-plus-square fa-2x" aria-hidden="true"></i></button></td>
						</tr>
					</table>
					<table>
						<tr><td colspan="3" align="right" style="font-size:10pt; padding-bottom:20px;">최대 3개의 파일을 첨부하실 수 있습니다.</td></tr>
						<tr><td id="insertBt" colspan="3" align="right"><button id="gymQSendBt" class="btn btn-default" onclick="return gymQnAInsert();">Send</button></td></tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/fitnessground/resources/js/gym/gymQnA.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#addFile").on("click", function(e){ //파일 추가 버튼
			e.preventDefault();
			fn_addFile();
		});
		$("a[name='delete']").on("click", function(e){ //삭제 버튼
			e.preventDefault();
			fn_deleteFile($(this));
		});
		$("#addFileSm").on("click", function(e){
			e.preventDefault();
			fn_addFileSm();
		});
	});
	function gymQnaInsertModal(gym_name, gym_no) {
		$('#gymQnATitle').html(gym_name+'에 문의');
		$("input[name=receiver]").val(gym_no);
		$("input[name=gym_no]").val(gym_no);
		$("#gymQnaInsertModal").show();
		$("#gymQnaInsertModal").modal();
	}
</script>