<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<c:import url="../include/common/head.jsp" />
	<link rel="stylesheet" href="/fitnessground/resources/css/user/mypage.css" />
    <c:import url="../include/common/headend.jsp" />
    
 	<script type="text/javascript">
		$(function(){
			$('#myPageBar nav ul #uPwd').removeClass('activeMenu');
			$('#myPageBar nav ul #uBoard').removeClass('activeMenu');
			$('#myPageBar nav ul #uSchedule').removeClass('activeMenu');
			$('#myPageBar nav ul #uDel').removeClass('activeMenu');
			$('#myPageBar nav ul #uDetail').addClass('activeMenu');	
		});
		
		function phoneHyphen() {
			var phone = $("#phone").val();
			if(phone.length == 3){
				phone += "-";
				$("input[name='phone']").val(phone);
			}else if(phone.length == 8){
				phone += "-";
				$("input[name='phone']").val(phone);
			} else if (phone.length > 13){
				phone = phone.substr(0,13);
				$("input[name='phone']").val(phone);
			}
		}
		
		function pwdCk(){
			var result = false;
			var pwd = $('input[name="userpwd"]').val();
			var user_no = $('input[name="user_no"]').val();
			var phone = $("#phone").val();
			if(phone.length!=13) {
				alert("전화번호를 확인해주세요.");
				return false;
			}
			var nickname = $('#nickname').val();
			if(nickname=="") {
				alert("닉네임을 입력해주세요.");
				return false;
			}
			var originNickname = $('#originNickname').val();
			$.ajax({
				url : "nicknameCheck.do",
				dataType : "json",
				type : "get",
				data : {"nickname":nickname}, 
				success : function(responseData){
					var data = responseData.user;
					if(data!=null && data.nickname!=originNickname){
						alert("이미 사용 중인 닉네임입니다.");
					} else {
						$.ajax({
							url : "pwdCk.do",
							dataType : "json",
							type : "post",
							data : {"pwd":pwd, "user_no":user_no}, 
							success : function(data){
								if(data.result == 1){
									 if(confirm("회원 정보를 수정하시겠습니까?")){
										 $.ajax({async : true, 
											 	type : "post",
											 	url : "uupdate.do",
											 	dataType : "json",
											 	data: $("#userDetailContentForm").serialize(),
											 	success : function(result){
											 		location.href="mypage.do?userno="+user_no;
											 	},
											 	error: function(request,status,error){
											 		alert("error code : " + request.status + "\n"
															+ "message : " + request.responseText + "\n"
															+ "error : " + errorData);
											 	}
										});
									 }
								}
								else {
									alert("비밀번호를 확인해주세요.");
									result = false;
								}
							}
						});
					}
				}
			});
			
			return result;
		}
	</script>
	
    <c:if test="${ sessionScope.user == null }">
		<script type="text/javascript">
			$(function (){
				alert("로그인이 필요합니다.");
				location.href="main.do";
			});
		</script>
	</c:if>
	
    <c:if test="${ sessionScope.user != null }">    
	<div id="page-wrapper">
		<!-- Header -->
		<div id="mypage_header">
            <!-- Nav -->
			<c:import url="../include/main/nav.jsp" />			
			<c:import url="login.jsp"/>
			<c:import url="findidpwd.jsp"/>
			<c:import url="register.jsp"/>
		</div>
    </div>
    
    <div id="myPageBar">
		<c:import url="../include/user/myPageBar.jsp"/>
	</div>
	
	<div class="col-md-offset-2 col-md-8 col-sm-12" id="userDetail" style="margin-top:120px;">
		<table id="uDetailTitle" align="center">
			<tr><th>${sessionScope.user.name}님의 기본정보</th></tr>				
		</table>
		<input type="hidden" value="${sessionScope.user.nickname}" id="originNickname">
		<div id="uDetailContent">
			<div class="col-md-4" align="center" id="profileImg">
				<a href="javascript:profileEdit()">
					<c:if test="${null eq sessionScope.user.rename_image}">
						<img src="/fitnessground/resources/images/myimages/nullicon.png" class="img-circle" style="background:#022D41;">
					</c:if>
					<c:if test="${null ne sessionScope.user.rename_image}">
						<img src="/fitnessground/resources/images/myimages/${sessionScope.user.rename_image}" class="img-circle" style="background:#022D41;">
					</c:if>
				</a><br>
				<a href="javascript:profileEdit()" class="btn btn-default" style="margin-top:30px;">이미지 변경</a>
			</div>
			<div class="col-md-8" id="profileContent">
				<form id="userDetailContentForm" action="" method="post">
				<input type="hidden" value="${sessionScope.user.user_no}" name="user_no">
				<table>
					<tr>
						<th><i class="fa fa-envelope" aria-hidden="true" style="margin-right:15px; width:20px;"></i> E-mail</th>
						<td><input type="email" value="${sessionScope.user.email}" name="email" class="form-control" readonly></td>
					</tr>
					<tr>
						<th><i class="fa fa-lock" aria-hidden="true" style="margin-right:15px; width:20px;"></i> 비밀번호</th>
						<td><input type="password" name="userpwd" value="" class="form-control"></td>
					</tr>
					<tr>
						<th><i class="fa fa-user" aria-hidden="true" style="margin-right:15px; width:20px;"></i> 이름</th>
						<td><input type="text" value="${sessionScope.user.name}" name="name" class="form-control" readonly></td>
					</tr>
					<tr>
						<th><i class="fa fa-user-secret" aria-hidden="true" style="margin-right:15px; width:20px;"></i> 닉네임</th>
						<td><input type="text" value="${sessionScope.user.nickname}" id="nickname" name="nickname" class="form-control"></td>
					</tr>					
					<tr>
						<th><i class="fa fa-phone-square" aria-hidden="true" style="margin-right:15px; width:20px;"></i> Phone</th>
						<td><input type="text" value="${sessionScope.user.phone}" id="phone" name="phone" class="form-control" oninput="phoneHyphen();"></td>
					</tr>
					<tr><th colspan="2"><button type="submit" class="btn btn-default" style="width:100%;" onclick="return pwdCk();">수정</button></th></tr>
				</table></form>
			</div>
		</div>
	</div>   
    </c:if>
    
    <c:import url="../include/main/footer.jsp" />
    <c:import url="../include/common/end.jsp" />