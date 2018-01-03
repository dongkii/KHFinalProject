<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:import url="../../include/common/head.jsp" />
	
	
		<style type="text/css">
	  table#community_table {
			
			border: 1px solid #ccc;
			border-collapse: collapse;
			table-layout: fixed;
			font-size:10pt;
		}
		
		table#community_table tr {
			border: 1px solid #ddd;
			
		}		
	
		table#community_table tr:nth-child(even) {
			background: #f8f8f8;
		}
		
		table#community_table th, table td {
			padding: .625em;
			text-align: center;
		}
	
		table#community_table th {
			font-weight: bold;
			background: #D8D8D8;
		}
		
		table#community_table td {
			white-space: nowrap;
			overflow: hidden;
		}
	</style>
<link rel="stylesheet" href="/fitnessground/resources/css/community/template.css">	
<link rel="stylesheet" href="/fitnessground/resources/css/community/community.css">		
	
	<c:import url="../../include/common/headend.jsp" />
    
   
	 <div id="page-wrapper">
		<!-- Header -->
		<div id="mypage_header">
            <!-- Nav -->
			<c:import url="../../include/main/nav.jsp" />
			
			<c:import url="../../user/login.jsp"/>
			<c:import url="../../user/findidpwd.jsp"/>
			<c:import url="../../user/register.jsp"/>
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
		function loginCheck(){
			alert("로그인이 필요한 서비스 입니다.");
			return false;
		}	
		/* $(document).ready(function(){
			$("#write").on("click", function(e){
				e.preventDefault();
				write();
			});
		});
		
		function write() {
			location.href = "reviewInsert.do";
		} */
		
		function reviewLoadList(page)
		{
			$.ajax({
				url:"reviewLoadList.do",
				type: "post",
				dataType: "json",
				data: {"page":page},
				success: function(data)
				{
					console.log(data.currentPage);
					console.log(data.maxPage);
					var jsonStr = JSON.stringify(data.list);
		            var json = JSON.parse(jsonStr);
		            console.log(data.list);
		            var values = "";
		            
		            for(var i in json)
		            {
		            	values += "<tr><td>" + json[i].cb_no + "</td>" + "<td><a href='reviewDetail.do?no=" + json[i].cb_no + "'>" +
		            			json[i].title + "</a></td><td>" + json[i].name + "</td><td>" +
		            			json[i].upload_date + "</td><td>" 
		            			+ json[i].readcount + "</td></tr>" ;
		            }	 
		            
		            $("#reviewlist").html(values);
					
		            var valuesPaging="";
		            
		            if(data.currentPage <= 1){
		            	valuesPaging+="<li class='disabled'>" + 
			              "<a href='#' aria-label='Previous'>" +
			                "<span aria-hidden='true'>&laquo;</span></a></li>";
		            } else {
		            	valuesPaging += "<li><a href='javascript:reviewLoadList(" + (data.currentPage - 1) + ")'  aria-label='Previous'>"
			             + "<span aria-hidden='true'>&laquo;</span></a></li>";
		            }
		            
		           for(var i = data.startPage; i<=data.endPage; i++)
		        	{
		        	   if(data.currentPage == i)
		        		{
		        		  valuesPaging+="<li class='disabled'>"+"<a href='#'>"+ i + "</a></li>";
		        		} else {
		        			 valuesPaging+="<li><a href='javascript:reviewLoadList(" + i + ")'>"+ i + "</a></li>";
		        		}
		
		        	}
		           
		            if(data.currentPage >= data.maxPage)
		            {
		            	valuesPaging+= "<li class='disabled'>" + 
				            "<a href='#' aria-label='Next'>"+
				                "<span aria-hidden='true'>&raquo;</span></a></li>";
		            } else {
		            	valuesPaging += "<li><a href='javascript:reviewLoadList(" + (data.currentPage + 1)+ "') aria-label='Next'>" +
		                "<span aria-hidden='true'>&raquo;</span></a></li>";
		            }
		            
		            $("#reviewpaging").html(valuesPaging);
				}
			});
		}
		
	</script>
<br><br>
<div class="container" id="comm-container">
<h1 align="center" style="
    font-size: 1.8rem;">운동후기</h1>
<br>
<div class="row">
	<div class="col-md-4 col-sm-4 col-xs-4">
	<a class="btn btn-primary button-size margin-left-10" id="tab-btn" onclick="meetingPage();">운동같이해요</a>
	</div>
	<div class="col-md-4 col-sm-4 col-xs-4">
	<a class="btn btn-primary button-size margin-left-10" id="selected-btn" onclick="reviewPage();">후기</a>
	</div>
	<div class="col-md-4 col-sm-4 col-xs-4">
	<a class="btn btn-primary button-size margin-left-10" id="tab-btn" onclick="qnaPage();">Q & A</a>
	</div>
	</div>
			<div class="row">			
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="board-info">
					<h1 class="margin-left-10" id="count">&nbsp;총 ${review.listCount}개의 게시물</h1>
					<form class="form-inline" name="form1" role="form" action="review.do" method="post">
						<div class="form-group">
							  <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
					   		 <span>
								<select class="btn btn-default" id="selection" style="width:80;" name="searchOption">
									<option value="title"<c:out value="${map.searchOption == 'title'?'selected':''}"/>>제목</option>
									<option value="name"<c:out value="${map.searchOption == 'name'?'selected':''}"/>>이름</option>
									<option value="content"<c:out value="${map.searchOption == 'content'?'selected':''}"/>>내용</option>
								</select>
							</span>
							</div>
					  	</div>
			  				<div class="form-group">
			   					<input type="text" class="form-control" id="srch-area" name ="searchKey"  value="${map.searchKey}" placeholder="Search for..">
							 </div>
			 			<span>
					  		<button class="btn btn-default" id="srch-btn" type="submit"><i class="fa fa-search" aria-hidden="true"></i></button>
						</span>
					</form>
			</div>	
			
		</div>
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<table id="community_table">
  <thead>
  		<colgroup>
			<col width="10%"/>
			<col width="*%"/>
			<col width="10%"/>
			<col width="15%"/>
			<col width="10%"/>
		</colgroup>
     <tr>
	      <th>번호</th>
	      <th id="th-title">제목</th>
	      <th id="th-writer">글쓴이</th>
	      <th  class="desktop">작성일</th>
	      <th  class="desktop">조회수</th>
    </tr>
  
  <tbody id="reviewlist">
 
	<c:forEach items="${review.list}" var="cm"> 
	<script>
	console.log("${cm.title}");
	</script>
   <tr>
      <td>${cm.cb_no}</td>
      <td id="td-title"><a href="reviewDetail.do?no=${cm.cb_no}" class="a-title${cm.cb_no }">${cm.title}</a>
      </td>
      <td id="td-writer">${cm.name}</td>
      <td class="desktop">${cm.upload_date}</td>
      <td class="desktop">${cm.readcount}</td>
    </tr>
     <script>
					if( $(window).width()<500){
						$('.desktop').hide();
						$('table#community_table').css('table-layout','auto');
						$('table#community_table th').css('padding','2px');
						$('#td-title').css('width','60vw');
						$('#th-title').css('width','60vw');
						$('#th-writer').css('width','20vw');
						$('#td-writer').css('width','20vw');
						if("${cm.title}".length>20){
						var mbtitle = "${cm.title}".substr(0,20)+"..";
						console.log(mbtitle);
						$('.a-title'+${cm.cb_no}).html(mbtitle);
						}
					}
	</script>
   </c:forEach>
  
  </tbody>
</table>	
			
<div id="paging">
	<nav>
  <ul class="pagination" id="reviewpaging">
    
    <c:if test="${review.currentPage <= 1}">
    <li class="disabled">
      <a href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    </c:if>
    
    <c:if test="${review.currentPage > 1}">
    <li>
      <a href="javascript:reviewLoadList(${review.currentPage - 1})" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    </c:if>
    
    <c:forEach var="i" begin="${review.startPage}" end="${review.endPage}" step="1">
    <c:if test="${review.currentPage eq i}">
    	<li class="disabled"><a href="#">${i}</a></li>
    </c:if>
    
    <c:if test="${review.currentPage ne i}">
    	<li><a href='javascript:reviewLoadList(${i})'>${i}</a></li>
    </c:if>
    
    </c:forEach>
    
    <c:if test="${review.currentPage >= review.maxPage}">
     <li class="disabled">
    <a href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
       </li>
    </c:if>
    
    <c:if test="${review.currentPage < review.maxPage}">
     <li>
    <a href='javascript:reviewLoadList(${review.currentPage + 1})' aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
       </li>
    </c:if>
 </ul>
  <c:if test="${sessionScope.user==null}">
<a class="btn btn-primary pull-right margin-right-20" id="write" onclick="return loginCheck();">글쓰기</a>
</c:if>
<c:if test="${sessionScope.user.name != null }">
<a href="reviewInsert.do" class="btn btn-primary pull-right margin-right-20">글쓰기</a>			
</c:if>
</nav>
</div>
</div>
</div>

    <c:import url="../../include/main/footer.jsp" />
    <c:import url="../../include/common/end.jsp" />