<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Modal -->
  <div class="modal fade" id="userScheduleDetail" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md" id="workout-dialog">
      <div class="modal-content" id="workout-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">x
          </button>
          <h4 class="modal-title" id="us_title">운동 내용</h4>
        </div>
        	<div class="modal-body">
        		<div id="userScheduleContent">
        			
        		</div>
			</div>
      </div>
    </div>
  </div>
  
  <div class="modal fade" id="userScheduleInput" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md" id="workout-dialog">
      <div class="modal-content" id="workout-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">x
          </button>
          <h4 class="modal-title" id="us_title">운동 내용</h4>
        </div>
        	<div class="modal-body">
        		<div id="userScheduleInput">
        			<input type="text" class="form-control" name="usInput" id="usInput" placeholder="달력에 보여질 내용을 입력하세요.">
        			<div style="margin-top:20px;" align="right"><button class="btn btn-primary" style="width:80px" onclick="return userScheduleInputBt();">입력</button></div>
        			<div id="inputUsDate"></div>
        		</div>
			</div>
      </div>
    </div>
  </div>
  
<script type="text/javascript">
	function userScheduleDetail(s_no, title, mode){
		$("#userScheduleDetail").show();
		$("#userScheduleDetail").modal();
		
		var content = '<input type="text" id="userScheduleTitle" class="form-control" value="'+title+'">' +
					  '<input type="hidden" id="s_no" value="' + s_no  + '" >' +
					  '<input type="hidden" id="mode" value="' + mode  + '" >' +
					  '<div align="right" style="margin-top:20px;">' +
					  '<button class="btn btn-primary" style="margin-right:10px; width:80px;" onclick="return userScheduleModify();">수정</button>' +
					  '<button class="btn btn-danger" style="width:80px;" onclick="return userScheduleDel();">삭제</button></div>';
		$("#userScheduleContent").html(content);
		
		$("#userScheduleTitle").keydown(function(key){
			if(key.keyCode==13){
				userScheduleModify();
			}
		})
	}
	
	function userScheduleModify() {
		var title = $("#userScheduleTitle").val();
		var s_no = $("#s_no").val();
		
		if(title=="" || title==null){
			alert("내용을 입력 해 주세요!");
			focus("#userScheduleTitle");
			return false;
		}
	
		if (confirm("'"+title+"' 으로 수정하시겠습니까?")===true) {
			var mode = $("#mode").val();
			var user_no = $("input[name=user_no]");
			var queryString ={s_no:s_no, content:title};
			$.ajax({
			 	type : "post",
			 	url : "uscheduleModify.do",
			 	data : JSON.stringify(queryString),
			 	contentType : "application/json; charset=utf-8",
			 	success : function(data){
			 		$("#userScheduleDetail").hide();
			 		/* var event = $("#calendar").fullCalendar( 'clientEvents', s_no)[0];
			 		event.title = title;
			 		$('#calendar').fullCalendar('updateEvent', event); */
			 		if(mode == 2)
			 			location.href="uschedule.do?userno="+user_no.val();
			 		else
			 			location.href="mypage.do?userno="+user_no.val();
			 	},
			 	error: function(request,status,error){
			 		alert("error code : " + request.status + "\n"
							+ "message : " + request.responseText + "\n"
							+ "error : " + errorData);
			 	}
			});
        }
				
		return false;
	}
	
	function userScheduleDel() {
		var title = $("#userScheduleTitle").val();
		var s_no = $("#s_no").val();

		if (confirm("'"+title+"' 을 삭제하시겠습니까?")===true) {
			var mode = $("#mode").val();
			var user_no = $("input[name=user_no]");
			var queryString ={s_no:s_no};
			$.ajax({
			 	type : "post",
			 	url : "uscheduleDel.do",
			 	data : JSON.stringify(queryString),
			 	contentType : "application/json; charset=utf-8",
			 	success : function(data){
			 		$("#userScheduleDetail").hide();
			 		//$('#calendar').fullCalendar('removeEvents', s_no);
			 		if(mode == 2)
			 			location.href="uschedule.do?userno="+user_no.val();
			 		else
			 			location.href="mypage.do?userno="+user_no.val();
			 	},
			 	error: function(request,status,error){
			 		alert("error code : " + request.status + "\n"
							+ "message : " + request.responseText + "\n"
							+ "error : " + errorData);
			 	}
			});
        }

		return false;
	}
	
	function userScheduleInput(date){
		$("#userScheduleInput").show();
		$("#userScheduleInput").modal();
		
		var temp = new Date(date);
		var dt = temp.getFullYear()+"-"+(temp.getMonth()+1)+"-"+temp.getDate();
		
		$("#inputUsDate").html('<input type="hidden" id="userScheduleDate" class="form-control" value="'+dt+'">');
		
		$("#usInput").keydown(function(key){
			if(key.keyCode==13){
				userScheduleInputBt();
			}
		});
	}
	
	function userScheduleInputBt() {
		var title = $("#usInput").val();
		var start = $("#userScheduleDate").val();
		if (title != "") {
			var user_no = $("input[name=user_no]");
			var job = {content:title, upload_date:start};
			$.ajax({
			 	type : "post",
			 	url : "uscheduleInsert.do",
			 	data : JSON.stringify(job),
			 	contentType : "application/json; charset=utf-8",
			 	success : function(data){
			 		$("#userScheduleInput").hide();
			 		location.href="uschedule.do?userno="+user_no.val();
			 	},
			 	error: function(request,status,error){
			 		alert("error code : " + request.status + "\n"
							+ "message : " + request.responseText + "\n"
							+ "error : " + errorData);
			 	}
			});
		}else {
			alert("내용을 입력하세요.");
		}
		
		return false;
	}
	
</script>
