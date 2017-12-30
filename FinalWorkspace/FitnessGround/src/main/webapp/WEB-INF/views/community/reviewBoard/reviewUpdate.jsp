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
<link rel="stylesheet" href="/fitnessground/resources/css/community/communitywrite.css">
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

<script type="text/javascript">
	$(document).ready(function() {
		$("#list").on("click", function(e) { //목록으로
			e.preventDefault();
			ReviewList();
		});
	});
	function ReviewList() {
		location.href = "review.do";
	}
</script>

<br>
<div class="container">
<h1 id="title">운동후기-수정</h1>
<div class="margin-vert-20" id="insert-wrapper">
<br>
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		<form id="editor_form" name='review' method="post" action="reviewUpdate.do">
			<input name="user_no" type="hidden" value="${sessionScope.user.user_no }" />
			<input name="cb_no" type="hidden" value="${community.cb_no}"/>
			<div class="form-group">
				<p>제목<input style="font-size:10pt;" class="input-group input-group-lg" name="title" type="text" value="${community.title}" /></p>
			</div>
	<div class="form-group">
				<textarea name="content" id="editor1">
				${community.content}
				</textarea>
				<script>
					CKEDITOR.replace('editor1');
				</script>
			<br>	
				<input type="submit" name="업로드" value="작성하기" id="submit-btn" class="btn btn-primary">
		</form>
	</div>
	<br>
</div>
</div>
<br>
<br>






<c:import url="../../include/main/footer.jsp" />
<c:import url="../../include/common/end.jsp" />