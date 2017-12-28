<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.kh.fitnessground.community.model.vo.MeetingBoard,
com.kh.fitnessground.community.model.vo.CommunityBoard, java.sql.Date, java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="../include/common/head.jsp" />
<link rel="stylesheet" href="/fitnessground/resources/css/community/community.css">
<link rel="stylesheet" href="/fitnessground/resources/css/community/template.css">
<c:import url="../include/common/headend.jsp" />
<div id="page-wrapper">
	<!-- Header -->
	<div id="mypage_header">
		<!-- Nav -->
		<c:import url="../include/main/nav.jsp" />
		<c:import url="../user/login.jsp" />
		<c:import url="../user/findidpwd.jsp" />
		<c:import url="../user/register.jsp" />
	</div>
</div>

<script type="text/javascript">
	function meetingPage() {
		location.href = "meeting.do";
	}
	function reviewPage() {
		location.href = "review.do";
	}
	function qnaPage() {
		location.href = "qna.do";
	}
</script>

<div class="container margin-top-60" id="comm-container">
	<div class="row">
		<h1 id=community_title>커뮤니티</h1>
	</div>
	<div class="row" style="padding-left: 2vw;">
		<div class="col-md-4 col-sm-4 col-xs-12" id="boardback">
			<div>
			<p id="p_title">&nbsp;&nbsp;운동같이해요&nbsp;><a class="pull-right" style="font-weight:100;" id="more" onclick="meetingPage();">더보기&nbsp;</a></p>
			</div>
			<hr class="titlehr">
			<div class="padding-hori-10">
					<table>
						<colgroup>
							<col width="8%" />
							<col width="40%" />
							<%-- <col width="35%" /> --%>
						</colgroup>
						<c:forEach items="${mlist}" var="mb">
						<tr style="font-size:10pt; color:#022D41">
							<td>${mb.name}<hr class="aaaaaa"></td>
							<td><a id="a_title" href="meetingDetail.do?no=${mb.mb_no}">${mb.title}</a><hr class="aaaaaa"></td>
							<%-- <td>${mb.upload_date}<hr class="aaaaaa"></td> --%>							
						</tr>								
						</c:forEach>				
					</table>
			</div>
		</div>
		<div class="col-md-4 col-sm-4 col-xs-12" id="boardback">
			<div>
			<p id="p_title">&nbsp;&nbsp;리뷰&nbsp;>
			<a class="pull-right" style="font-weight:100;" id="more" onclick="reviewPage();">더보기&nbsp;</a></p>
			</div>		
			<hr class="titlehr">	
			<div class="padding-hori-10">
				<table id="detail_table">
					<colgroup>
						<col width="8%" />
						<col width="40%" />
						<%-- <col width="35%" /> --%>
					</colgroup>
					<c:forEach items="${rlist }" var="rb">
					<tr style="font-size:10pt; color:#022D41">
						<td>${rb.name}<hr class="aaaaaa"></td>
						<td><a id="a_title" href="reviewDetail.do?no=${rb.cb_no}">${rb.title} </a><hr class="aaaaaa"></td>
						<%-- <td>${rb.upload_date}<hr class="aaaaaa"></td> --%>
					</tr>
					</c:forEach>
				</table>	
			</div>
		</div>
		<div class="col-md-4 col-sm-4 col-xs-12" id="boardback">
			<div>
			<p id="p_title">&nbsp;&nbsp;Q & A&nbsp;＞
			<a class="pull-right" style="font-weight:100;" id="more" onclick="qnaPage();">더보기&nbsp;</a></p>
			</div>
			<hr class="titlehr">
			<div class="padding-hori-10">
				<table id="detail_table">
				<colgroup>
					<col width="8%" />
					<col width="40%" />
					<%-- <col width="35%" /> --%>
				</colgroup>
				<c:forEach items="${qlist }" var="qb">
					<tr style="font-size:10pt; color:#022D41">
						<td>${qb.name}<hr class="aaaaaa"></td>
						<td><a id="a_title" href="qnaDetail.do?no=${qb.cb_no}">	${qb.title}</a><hr class="aaaaaa"></td>
						<%-- <td>${qb.upload_date}<hr class="aaaaaa"></td> --%>
					</tr>
				</c:forEach>
				</table>
			</div>
		</div>
	</div>
</div>
<c:import url="../include/main/footer.jsp" />
<c:import url="../include/common/end.jsp" />