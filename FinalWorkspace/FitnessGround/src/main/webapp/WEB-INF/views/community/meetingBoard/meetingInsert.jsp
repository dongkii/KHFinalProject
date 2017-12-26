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
	border: 1px solid gray;
}

div#div_head {
	padding-left: 10%;
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
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		<form name='meeting' method="post" action="meetingInsert.do">
			<input name="user_no" type="hidden" value="${sessionScope.user.user_no }" />
			<div class="form-group">
				<p>제목<input style="font-size:10pt;" class="input-group input-group-lg" id="title" name="title" type="text" placeholder="제목"/></p>
				<p>모임날짜 &nbsp;<input style="width:120pt;"id="title" name="meeting_date" type="date" /></p>
			</div>
			<div class="form-group">
				<textarea name="content" id="editor2" placeholder="내용을 입력해주세요.."></textarea>
				<script>
					CKEDITOR.replace('editor2');
				</script>
				<br>
				  <div class="col-lg-6">
    <div class="input-group">
      <input type="text" class="form-control" placeholder="Search for..." id="address">
      <span class="input-group-btn">
        <button class="btn btn-default" type="button" id="submit">Go!</button>
      </span>
    </div>
  </div>
</div>

				<div id="map" style="width: 600px; height: 400px; margin-left: 50px">
					<script type="text/javascript" src="/fitnessground/resources/js/community/communityMap.js"></script>
				</div>
				<br>
				<a type="submit" class="btn btn-primary btn-lg pull-right margin-left-20" name="업로드">작성</a>
				<a hrefs="#this" class="btn btn-primary btn-lg pull-right margin-right-20" id="list">목록</a>
			</div>
		</form>
		
		</div>
		
	</div>

</div>
<br>
<br>
<br>
<c:import url="../../include/main/footer.jsp" />
<c:import url="../../include/common/end.jsp" />