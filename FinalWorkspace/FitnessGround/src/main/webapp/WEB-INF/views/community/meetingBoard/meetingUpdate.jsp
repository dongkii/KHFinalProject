<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:import url="../../include/common/head.jsp" />

<style type="text/css">
h1 {
	font-size: 30pt;
}

div#all_div {
	padding-left: 9%;
	padding-right: 9%;
}

div#insert_all_div {
	border: 1px solid;
}

div#div_head {
	padding-left: 10%;
}

form#editor_form {
	padding-left: 10%;
	padding-right: 10%;
}

a#write {
	left: 47%;
	width: 30pt;
	height: 30pt;
	font-size: 12pt;
}

a#list {
	left: 47%;
	width: 30pt;
	height: 30pt;
	font-size: 12pt;
}

textarea#editor1 {
	cols: 80;
	rows: 40;
}
</style>

<c:import url="../../include/common/headend.jsp" />

<script src="//cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script>

<div id="page-wrapper">
	<!-- Header -->
	<div id="mypage_header">
		<!-- Nav -->
		<c:import url="../../include/main/nav.jsp" />

		<c:import url="../../user/login.jsp" />
		<c:import url="../../user/findidpwd.jsp" />
		<c:import url="../../user/register.jsp" />
	</div>
</div>

<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=vWkJuuK8gXcwBG8Rijlh&submodules=geocoder">	
</script>


<script type="text/javascript">
	$(document).ready(function() {
		$("#list").on("click", function(e) { //목록으로
			e.preventDefault();
			MeetingList();
		});
	});
	function MeetingList() {
		location.href = "meeting.do";
	}
</script>

<br>
<div class="container">
<h1 align="center">운동같이해요</h1>
<br>
<div id="all_div">
	<div id="insert_all_div">
		<br>
		<form id="editor_form" name='meeting' method="post" action="meetingUpdate.do">
			<input name="user_no" type="hidden" value="${sessionScope.user.user_no }" />
			<input name="mb_no" type="hidden" value="${meeting.mb_no}"/>
			<div id="div_head">
				<p>
					제목
					<input name="title" type="text" value="${meeting.title}" />
				</p>
				<p>모임날짜<input name="meeting_date" type="date" value="${meeting.meeting_date}"/>
				 </p>
			</div>

				<textarea name="content" id="editor1">
				${meeting.content}
				</textarea>
				<script>
					CKEDITOR.replace('editor1');
				</script>
				<br>
				<div class="col-lg-6 col-md-4 col-sm-4 col-xs-4">
						
						<p>모임장소<input type="text" class="form-group" name="meeting_location" id="address" value="${meeting.meeting_location }"/></p>
								
								<button class="btn btn-default" type="button" id="submit">검색</button>
						
						
					</div>
				<div id="map" style="width: 600px; height: 400px;">
					<script type="text/javascript" src="/fitnessground/resources/js/community/communityMap.js"></script>
				</div>
				<input type="submit" name="업로드" value="작성하기" id="write">
				<br>
				
		</form>
	</div>
	<br>
</div>
</div>

<br>
<br>

<a align="center" href="#this" class="btn" id="list">목록</a>
<br>
<br>
<br>






<c:import url="../../include/main/footer.jsp" />
<c:import url="../../include/common/end.jsp" />