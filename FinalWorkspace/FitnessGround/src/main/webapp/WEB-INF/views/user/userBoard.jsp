<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<c:import url="../include/common/head.jsp" />
	<link rel="stylesheet" href="/fitnessground/resources/css/user/mypage.css" />
    <c:import url="../include/common/headend.jsp" />
	<c:import url="/WEB-INF/views/gym/gymQnADetailView.jsp"/>
<c:import url="/WEB-INF/views/gym/gymQnAUpAndAnswer.jsp"/>	

	<script type="text/javascript">
		$(function(){
			$('#myPageBar nav ul #uBoard').addClass('activeMenu');	
			
			$('#liQ').click(function(event){
				event.preventDefault();
				$('#liQ').parent().addClass('in');
				$('#liC').parent().removeClass('in');
			});
			
			$('#liC').click(function(event){
				event.preventDefault();
				$('#liC').parent().addClass('in');
				$('#liQ').parent().removeClass('in');
			});
		});	
		
		function qSearch() {
			location.href="userBoardSearch.do?searchKeyword="+$('input[name="searchQKeyword"]').val()+"&userno="+${sessionScope.user.user_no};
		}
		function cSearch() {
			location.href="userBoardSearch.do?searchKeyword="+$('input[name="searchCKeyword"]').val()+"&userno="+${sessionScope.user.user_no}+"&com=ok";
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

	<br><div role="tabpanel" class="userBoardNav">
		<!-- Nav tabs -->
		<div class="container is-bg-a">
			<div class="wrap">
				<div class="tab-wrap">
					<ul class="tab-list tab-b is-col-3">
						<c:if test="${com eq 'no'}">
					  	<li class="in"><a id="liQ" href="#qna" aria-controls="qna" role="tab" data-toggle="tab" style="padding-top:10px; padding-bottom:10px;">문의내역</a></li>
					  	<li><a id="liC" href="#community" aria-controls="community" role="tab" data-toggle="tab" style="padding-top:10px; padding-bottom:10px;">커뮤니티</a></li>
						</c:if>
					  	<c:if test="${com eq 'ok'}">
					  	<li><a id="liQ" href="#qna" aria-controls="qna" role="tab" data-toggle="tab" style="padding-top:10px; padding-bottom:10px;">문의내역</a></li>
					  	<li class="in"><a id="liC" href="#community" aria-controls="community" role="tab" data-toggle="tab" style="padding-top:10px; padding-bottom:10px;">커뮤니티_게시글</a></li>
					  	</c:if>
					</ul>
				</div>
			</div>
		</div>
		<!-- Tab panes -->
		<div class="container tab-content col-md-offset-1" style="margin-top:0px;">
			<c:if test="${com eq 'no'}">
			<div role="tabpanel" class="tab-pane fade in active" id="qna">
			</c:if>
		  	<c:if test="${com eq 'ok'}">
		  	<div role="tabpanel" class="tab-pane fade in" id="qna">
		  	</c:if>
				<table class="table-bordered" id="qnaT">
					<tr id="qnaSTitle">
						<th colspan="3" align="right">
							<div id="searchInfo" style="text-align:left;" class="col-md-6"><c:if test="${null ne qSearchKeyword}">
							'${qSearchKeyword}'(으)로 검색한 결과
							</c:if></div>
							<div class="input-group col-md-6" id="qnaF">
							  <input type="text" class="form-control" placeholder="Title Keyword to Search" name="searchQKeyword" onkeydown="javascript: if (event.keyCode == 13) {qSearch();}">
							  <span class="input-group-addon" id="searchBt" style="background:white; margin-top:20px;">
							  	<a onclick="qSearch();" class="glyphicon glyphicon-search"></a>
							  </span>
							</div>
						</th>
					</tr>
					<tr style="font-weight:bold;">
					  <th style="width:15%;">Index</th>
					  <th style="width:60%;">Title</th>
					  <th style="width:25%;">Date</th>
					</tr>
					<c:choose>
						<c:when test="${!empty qlist}">
							<c:forEach items="${qlist}" var="q" varStatus="st">
								<tr>
								  <td>${q.q_no}</td>
								  <td><a href="javascript:gymQnaDetailModal('${q.q_no}')">${q.title}</a></td>
								  <td>${q.write_date}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><td colspan="3">문의내역이 없습니다.</td></tr>
						</c:otherwise>
					</c:choose>
				</table>
				<div class="boardPage col-md-offset-2 col-md-8" align="center"><nav>
				  <ul class="pagination">
				    <li>
					    <c:if test="${qCurrentPage <= 1}">
					    	<a href="#" aria-label="Previous">
					        	<span aria-hidden="true">&laquo;</span>
					      	</a>
					     </c:if>
						<c:if test="${qCurrentPage > 1}">
							<c:if test="${null eq search}">
								<a href="userboard.do?qpage=${qCurrentPage-1}&userno=${sessionScope.user.user_no}" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</c:if>
							<c:if test="${null ne search}">
								<a href="userBoardSearch.do?page=${qCurrentPage-1}&searchKeyword=${qSearchKeyword}&userno=${sessionScope.user.user_no}" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</c:if>
						</c:if>				      
				    </li>
				    <c:forEach var="p" begin="${qStartPage}" end="${qEndPage}">
						<c:choose>
							<c:when test="${qCurrentPage == p}">
								 <li><a href="#">${p}</a></li>
							</c:when>
							<c:otherwise>
								 <li>
								 	<c:if test="${null eq search}">
										<a href="userboard.do?userno=${sessionScope.user.user_no}&qpage=${p}">${p}</a>
									</c:if>
									<c:if test="${null ne search}">
										<a href="userBoardSearch.do?page=${p}&searchKeyword=${qSearchKeyword}&userno=${sessionScope.user.user_no}">${p}</a>
									</c:if>	
								 </li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				    <li>
				    	<c:choose>
				    	<c:when test="${qCurrentPage >= qMaxPage}">
				    		<a href="#" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						    </a>
				    	</c:when>
				    	<c:otherwise>
				    		<c:if test="${null eq search}">
								<a href="userboard.do?qpage=${qCurrentPage+1}&userno=${sessionScope.user.user_no}" aria-label="Next">
					        		<span aria-hidden="true">&raquo;</span>
					      		</a>
							</c:if>
							<c:if test="${null ne search}">
								<a href="userBoardSearch.do?page=${qCurrentPage+1}&searchKeyword=${qSearchKeyword}&userno=${sessionScope.user.user_no}" aria-label="Next">
						        	<span aria-hidden="true">&raquo;</span>
						      	</a>
							</c:if>	
				      	</c:otherwise>
				      	</c:choose>
				    </li>
				  </ul>
				</nav></div>
			</div>
			
			<c:if test="${com eq 'no'}">
			<div role="tabpanel" class="tab-pane fade" id="community">
			</c:if>
		  	<c:if test="${com eq 'ok'}">
		  	<div role="tabpanel" class="tab-pane fade in active" id="community">
		  	</c:if>
		  		<table class="table-bordered" style="background:white; border-style:1px;border-top:0px;" id="communityT">
					<tr>
						<th colspan="3" align="right">
							<div id="searchInfo" style="text-align:left;" class="col-md-6"><c:if test="${null ne cSearchKeyword}">
							'${cSearchKeyword}'(으)로 검색한 결과
							</c:if></div>
							<div class="input-group col-md-6" id="comF">
							  <input type="text" class="form-control" placeholder="Title Keyword to Search" name="searchCKeyword" onkeydown="javascript: if (event.keyCode == 13) {cSearch();}">
							  <span class="input-group-addon" id="searchBt" style="background:white; margin-top:20px;">
							  	<a onclick="cSearch();" class="glyphicon glyphicon-search"></a>
							  </span>
							</div>
						</th>
					</tr>
					<tr style="font-weight:bold;">
					  <th style="width:15%;">Category</th>
					  <th style="width:60%;">Title</th>
					  <th style="width:25%;">Date</th>
					</tr>
					<c:choose>
						<c:when test="${!empty clist}">
							<c:forEach items="${clist}" var="c" varStatus="st">
								<c:url var="meetDetail" value="meetingDetail.do">
									<c:param name="no" value="${c.board_no}"/>
								</c:url>
								<c:url var="qnaDetail" value="qnaDetail.do">
									<c:param name="no" value="${c.board_no}"/>
								</c:url>
								<c:url var="reviewDetail" value="reviewDetail.do">
									<c:param name="no" value="${c.board_no}"/>
								</c:url>
								<tr>
								  <c:if test="${c.category_no eq 0}">
								  	<td>후기</td>
								  	<td><a href="${reviewDetail}">${c.title}</a></td>
								  </c:if>
								  <c:if test="${c.category_no eq 1}">
								  	<td>QnA</td>
								  	<td><a href="${qnaDetail}">${c.title}</a></td>
								  </c:if>
								  <c:if test="${c.category_no eq 2}">
								  	<td>운동모임</td>
								  	<td><a href="${meetDetail}">${c.title}</a></td>
								  </c:if>
								  <td>${c.upload_date}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><td colspan="3">작성하신 글이 없습니다.</td></tr>
						</c:otherwise>
					</c:choose>
				</table>
				<div class="boardPage col-md-offset-2 col-md-8" align="center"><nav>
				  <ul class="pagination">
				    <li>
					    <c:if test="${currentPage <= 1}">
					    	<a href="#" aria-label="Previous">
					        	<span aria-hidden="true">&laquo;</span>
					      	</a>
					     </c:if>
						<c:if test="${currentPage > 1}">
							<c:if test="${null eq search}">
								<a href="userboard.do?cpage=${currentPage-1}&userno=${sessionScope.user.user_no}&com=ok" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</c:if>
							<c:if test="${null ne search}">
								<a href="userBoardSearch.do?page=${currentPage-1}&searchKeyword=${cSearchKeyword}&userno=${sessionScope.user.user_no}&com=ok" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</c:if>
						</c:if>				      
				    </li>
				    <c:forEach var="p" begin="${cStartPage}" end="${cEndPage}">
						<c:choose>
							<c:when test="${currentPage == p}">
								 <li><a href="#">${p}</a></li>
							</c:when>
							<c:otherwise>
								 <li>
								 	<c:if test="${null eq search}">
										<a href="userboard.do?userno=${sessionScope.user.user_no}&cpage=${p}&com=ok">${p}</a>
									</c:if>
									<c:if test="${null ne search}">
										<a href="userBoardSearch.do?page=${p}&searchKeyword=${cSearchKeyword}&userno=${sessionScope.user.user_no}&com=ok">${p}</a>
									</c:if>	
								 	
								 </li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				    <li>
				    	<c:choose>
				    	<c:when test="${currentPage >= cMaxPage}">
				    		<a href="#" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						    </a>
				    	</c:when>
				    	<c:otherwise>
				    		<c:if test="${null eq search}">
						      	<a href="userboard.do?cpage=${currentPage+1}&userno=${sessionScope.user.user_no}&com=ok" aria-label="Next">
						        	<span aria-hidden="true">&raquo;</span>
						      	</a>
							</c:if>
							<c:if test="${null ne search}">
								<a href="userBoardSearch.do?page=${currentPage+1}&searchKeyword=${cSearchKeyword}&userno=${sessionScope.user.user_no}&com=ok" aria-label="Next">
						        	<span aria-hidden="true">&raquo;</span>
						      	</a>
							</c:if>	
				      	</c:otherwise>
				      	</c:choose>
				    </li>
				  </ul>
				</nav></div>
		  	</div>
		</div>
	</div>
	
		
    </c:if>
    
    <c:import url="../include/main/footer.jsp" />
    <c:import url="../include/common/end.jsp" />