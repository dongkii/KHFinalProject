<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:import url="../include/common/head.jsp" />
<link rel="stylesheet" href="/fitnessground/resources/css/findgym/findgym.css" />
<div id="mypage_header">
	<c:import url="../user/login.jsp" />
	<c:import url="../user/findidpwd.jsp" />
	<c:import url="../user/register.jsp" />
	<c:import url="../include/main/nav.jsp" />
</div>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=G0XI103VNKmTZuGNcR9G&submodules=geocoder"></script>
<script type="text/javascript" src="/fitnessground/resources/js/gym/gymmap.js"></script>
<c:import url="../include/common/headend.jsp" />

<script type="text/javascript">

 $(function(){
	var mode = $('#mode').val();
	if(mode == 1) {
		$('#health').addClass('active');
		$('#public').removeClass('active');
		$('#healthTab').addClass('active');
		$('#publicTab').removeClass('active');
	} else if(mode == 2) {
		$('#public').addClass('active');
		$('#health').removeClass('active');
		$('#publicTab').addClass('active');
		$('#healthTab').removeClass('active');
	} 
});	
</script>

<script type="text/javascript">

	function loadGymList(page) {
		$.ajax({
			url : "findhealth.do",
			type : "post",
			dataType : "json",
			data : {"page" : page},
			success : function(data) {
				console.log(data.gymlist);
				console.log(data.currentPage);
				console.log(data.maxPage);
				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);
				console.log(json);
				// 리스트 처리
				var values = "";
				var image = "";

				for ( var i in json.gymlist) {
					
					if (json.gymlist[i].rename_image == null) {
						values += "<div id='wrapper' style='padding-bottom:10px;padding-top:10px;border-bottom:1px solid #dedede;'><div id='health-desc'>"
								+ "<a href='javascript: gymclick(\"" 
										+ json.gymlist[i].gym_no + "\",\""
										+ json.gymlist[i].location 
								+ "\")'><h4 style='font-weight:bold;color:black;'>" 
								+ json.gymlist[i].gym_name
								+ "</h4>"
								+ json.gymlist[i].location
								+ "<br>"
								+ json.gymlist[i].tel
								+ "</a></div>"
								+ "<div id='thumbnail'>"
								+ "<a href='#'><img class='img-thumbnail' src='/fitnessground/resources/images/default_image.png' style='height:100px; width:100px;'></a></div></div>";
					} else {
						var rename_image = json.gymlist[i].rename_image.split(",");
						values += "<div id='wrapper'style='padding-bottom:10px;padding-top:10px;border-bottom:1px solid #dedede;'><div id='health-desc'>"
								+ "<a href='javascript: gymclick(\"" 
										+ json.gymlist[i].gym_no + "\",\""
										+ json.gymlist[i].location
								+ "\")'><h4 style='font-weight:bold;color:black;'>" 
								+ json.gymlist[i].gym_name
								+ "</h4>"
								+ json.gymlist[i].location
								+ "<br>"
								+ json.gymlist[i].tel
								+ "</a></div>"
								+ "<div id='thumbnail'>"
								+ "<a href='#'><img class='img-thumbnail' src=/fitnessground/resources/images/gymimages/" + rename_image[0] + " style='height:100px; width:100px;'></a></div></div>";
					}
				}
				
				console.log("json.gymlist[i].rename_image");
				console.log(json.gymlist[i].rename_image);
				$("#healthlist").html(values);
				var valuesPaging = "";
				if (data.currentPage <= 1) {
					valuesPaging += "<li class='disabled'><a href='#' aria-label='Previous'>"
							+ "<span aria-hidden='true'>&laquo;</span></a></li>";
				} else {
					if(data.currentPage-5 >= 1) {
						valuesPaging += "<li><a href='javascript:loadGymList(" + (data.currentPage - 5)
						 			 + ")' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
					} else {
						valuesPaging  += "<li><a href='javascript:loadGymList(" + 1
			 						  + ")' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
					}/* 
					 valuesPaging += "<li><a href='javascript:loadGymList("
							+ (data.currentPage - 1)
							+ ")' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";  */
				}
				for (var i = data.startPage; i <= data.endPage; i++) {
					if (data.currentPage == i) {
						valuesPaging += "<li class='disabled'><a href='#'>" + i + "</a></li>";
					} else {
						valuesPaging += "<li><a href='javascript:loadGymList(" + i + ")'>" + i + "</a></li>";
					}
				}	
				if (data.currentPage >= data.maxPage) {
					valuesPaging += "<li class='disabled'><a href='#' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
				} else {
					if(data.pcurrentPage+5 <= data.maxPage) {
						valuesPaging += "<li><a href='javascript:loadGymList(" + (data.currentPage + 5)
						 			 + ")' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
					} else {
						valuesPaging += "<li><a href='javascript:loadGymList(" + (data.maxPage)
			 			 			 + ")' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
					}
					// valuesPaging += "<li><a href='javascript:loadGymList(" + (data.currentPage + 1) + ")' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>"; 
				}
				$("#healthpaging").html(valuesPaging);

				},			
			error : function(request, status, errorData){
					alert("error code : " + request.status + "\n"
							+ "message : " + request.responseText + "\n"
							+ "error : " + errorData);
					}
			});	
	}

	function loadPublicList(ppage) {
		$.ajax({
			url : "findpublic.do",
			type : "post",
			datatype : "json",
			data : {"ppage" : ppage},
			success : function(data) {
				console.log(data.publiclist);
				console.log(data.pcurrentPage);
				console.log(data.pmaxPage);
				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);
				
				// 리스트 처리
				var values = "";
				for (var i in json.publiclist) {
					if (json.publiclist[i].image != null) {
						values += "<div id='wrapper' style='padding-bottom:10px;padding-top:10px;border-bottom:1px solid #dedede;'><div id='public-desc'>"
								+ "<a href='javascript:publicgymclick(\"" + json.publiclist[i].public_name + "\",\"" + json.publiclist[i].tel + "\",\"" + json.publiclist[i].location + "\",\"" + json.publiclist[i].homepage + "\")'><h4 style='font-weight:bold;color:black;'>"
								+ json.publiclist[i].public_name
								+ "</h4>"
								+ json.publiclist[i].location
								+ "<br>Tel : ";
								if (json.publiclist[i].tel != null) { values += json.publiclist[i].tel; }
								else { values += "없음"; }
						values += "</a></div><div id='thumbnail'><a href='#'><img class='img-thumbnail' src='"+json.publiclist[i].image+"' style='height:100px; width:100px;'></a></div></div>";
					} else {
						values += "<div id='wrapper' style='padding-bottom:10px;padding-top:10px;border-bottom:1px solid #dedede;'><div id='public-desc'>"
							+ "<a href='javascript:publicgymclick(\"" + json.publiclist[i].public_name + "\",\"" + json.publiclist[i].tel + "\",\"" + json.publiclist[i].location + "\",\"" + json.publiclist[i].homepage + "\")'><h4 style='font-weight:bold;color:black;'>"
							+ json.publiclist[i].public_name
							+ "</h4>"
							+ json.publiclist[i].location
							+ "<br>Tel : ";
							if (json.publiclist[i].tel != null) { values += json.publiclist[i].tel; }
							else { values += "없음"; }
						values += "</a></div><div id='thumbnail'><a href='#'><img class='img-thumbnail' src='/fitnessground/resources/images/default_image.png' style='height:100px; width:100px;'></a></div></div>";
					}
				}
				$("#publiclist").html(values);

				var valuesPaging = "";
				if (data.pcurrentPage <= 1) {
					valuesPaging += "<li class='disabled'><a href='#' aria-label='Previous'>" + "<span aria-hidden='true'>&laquo;</span></a></li>";
				} else {
					/* valuesPaging += "<li><a href='javascript:loadPublicList(" + (data.pcurrentPage - 1)
					 + ")' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>"; */
					if(data.pcurrentPage-5 >= 1) {
						valuesPaging += "<li><a href='javascript:loadPublicList(" + (data.pcurrentPage - 5)
						 			 + ")' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
					} else {
						valuesPaging  += "<li><a href='javascript:loadPublicList(" + 1
			 						  + ")' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
					}
				}
				for (var i = data.pstartPage; i <= data.pendPage; i++) {
					if (data.pcurrentPage == i) {
						valuesPaging += "<li class='disabled'><a href='#'>" + i + "</a></li>";
					} else {
						valuesPaging += "<li><a href='javascript:loadPublicList(" + i + ")'>" + i + "</a></li>";
					}
				}
				if (data.pcurrentPage >= data.pmaxPage) {
					valuesPaging += "<li class='disabled'><a href='#' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
				} else {
					/* valuesPaging += "<li><a href='javascript:loadPublicList("
					+ (data.pcurrentPage + 1)
					+ ")' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>"; */
					if(data.pcurrentPage+5 <= data.pmaxPage) {
						valuesPaging += "<li><a href='javascript:loadPublicList(" + (data.pcurrentPage + 5)
						 			 + ")' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
					} else {
						valuesPaging += "<li><a href='javascript:loadPublicList(" + (data.pmaxPage)
			 			 			 + ")' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
					}
				}
				$("#publicpaging").html(valuesPaging);
				//setGymlist(map);
			},
			error : function(request, status, errorData) {
				alert("error code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + errorData);
			}
		});
	}
</script>

<div id="container" class="container">
	<div class="row">
		<div class="col-md-4" style="margin-top:50px;" align="left">
			<div class="row" style="padding:10px; width:100%;">
				<div class="input-group">
					<c:if test="${mode ne null}"><input type="hidden" id="mode" value="${mode}"></c:if>
					<c:if test="${address ne null}"><input type="text" class="form-control" id="address" placeholder="Search for..." style="width:420px;" value="${address}"></c:if>
					<c:if test="${address eq null}"><input type="text" class="form-control" id="address" placeholder="Search for..." style="width:420px;"></c:if>
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" id="submit" style='height:34px;'>
							<span class="glyphicon glyphicon-search"></span>
						</button>
						<button class="btn btn-default" type="button" id="geolocation" style='height:34px;'>
							<span class="glyphicon glyphicon-map-marker"></span>
						</button>
					</span>
				</div>
			</div>

			<div class="row" style="padding:10px;">
				<div role="tabpanel" id="panel">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" role="tablist" style="text-align: center;">
						<li role="presentation" class="active" id="healthTab" style="width:50%;">
							<a href="#health" aria-controls="home" role="tab" data-toggle="tab">헬스장 찾기</a>
						</li>
						<li role="presentation" id="publicTab" style="width:50%;">
							<a href="#public" aria-controls="profile" role="tab" data-toggle="tab">공공체육시설 찾기</a>
						</li>
					</ul>
					
					<!-- Tab panes 헬스 -->
					<div class="tab-content" align="left" style="padding:10px;">
						<div role="tabpanel" class="tab-pane active" id="health">
							<div class="row">
								<div id="healthlist" style="height:450px;">
									<c:forEach var="glist" items="${gympage.list}">
										<div id='wrapper' style='padding-bottom:10px;padding-top:10px;border-bottom:1px solid #dedede;'>
											<div id="health-desc">
												<a href='javascript:gymclick("${glist.gym_no}","${glist.location}")'><h4 style="font-weight:bold;color:black;">${glist.gym_name}</h4>${glist.location}<br>${glist.tel}</a>
											</div>
											<div id="thumbnail" align="right">
												<c:if test="${empty glist.rename_image}">
													<a href='#'><img class="img-thumbnail" src="/fitnessground/resources/images/default_image.png" style="width: 100px; height: 100px;"></a>
												</c:if>
												<c:if test="${not empty glist.rename_image }">
												<c:set var="rename_image" value="${fn:split(glist.rename_image,',')}" />
													<img class="img-thumbnail" src="/fitnessground/resources/images/gymimages/${rename_image[0]}" style="width: 100px; height: 100px;">
												</c:if>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
							<div id="paging" align="center">
								<nav>
									<ul class="pagination" id="healthpaging">
										<!-- 페이지 번호 처리 -->
										<c:if test="${gympage.currentPage <=1 }">
											<li class='disabled'><a href='#' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>
										</c:if>
										<c:if test="${gympage.currentPage > 1 }">
											<c:choose>
									    	<c:when test="${gympage.currentPage-5 >= 1}">
									    		<input type="hidden" name="page" value="${gympage.currentPage - 5}">
												<li>
													<a href='javascript:loadGymList(${gympage.currentPage - 5})' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a>
												</li>
									    	</c:when>
									    	<c:otherwise>
									    		<li class='disabled'><a href='javascript:loadGymList(${gympage.startPage})' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>
									      	</c:otherwise>
									      	</c:choose>
										</c:if>
										<c:forEach var="i" begin="${gympage.startPage }" end="${gympage.endPage }" step="1">
											<c:if test="${gympage.currentPage eq i }">
 												<li class='disabled'><a href='#'>${i }</a></li>
												<input type="hidden" name="page" value="${gympage.currentPage }">
											</c:if>
											<c:if test="${gympage.currentPage ne i }">
												<li><a href="javascript:loadGymList(${i })">${i }</a></li>
												<input type="hidden" name="page" value="${i}">
											</c:if>
										</c:forEach>
										<c:if test="${gympage.currentPage >= gympage.maxPage }">
											<li class='disabled'><a href='#' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>
											<input type="hidden" name="page" value="${gympage.currentPage }">
										</c:if>
										<c:if test="${gympage.currentPage < gympage.maxPage }">
											<c:choose>
									    	<c:when test="${gympage.currentPage+5 <= gympage.maxPage}">
									    		<input type="hidden" name="page" value="${gympage.currentPage + 5}">
												<li>
													<a href='javascript:loadGymList(${gympage.currentPage + 5})' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a>
												</li>
									    	</c:when>
									    	<c:otherwise>
									    		<li class='disabled'>
									    			<a href='javascript:loadGymList(${gympage.maxPage})' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a>
									    		</li>
									      	</c:otherwise>
									      	</c:choose>
										</c:if>
									</ul>
								</nav>
							</div>
							<!-- paging -->
						</div>
						
						<!-- Tab panes 공공 체육 시설 -->
						<div role="tabpanel" class="tab-pane" id="public" align="left">
							<div class="row">
								<div id="publiclist" style="height:450px;">
									<c:forEach var="plist" items="${gympage.plist}">
										<div id='wrapper' style='padding-bottom:10px;padding-top:10px;border-bottom:1px solid #dedede;'>
											<div id="public-desc">
												<a href='javascript:publicgymclick("${plist.public_name }","${plist.tel }","${plist.location }","${plist.homepage }")'>
													<h4 style="font-weight:bold;color:black;">${plist.public_name }</h4>${plist.location }<br>Tel : 
													<c:if test="${empty plist.tel }">없음</c:if> 
													<c:if test="${not empty plist.tel }">${plist.tel}</c:if>
												</a>
											</div>
											<div id="thumbnail">
												<a href='#'>
													<c:if test="${plist.image ne null}">
													<img class="img-thumbnail" src="${plist.image}" style="height: 100px; width: 100px;">
													</c:if>
													<c:if test="${plist.image eq null}">
													<img class="img-thumbnail" src="/fitnessground/resources/images/default_image.png" style="height: 100px; width: 100px;">
													</c:if>
												</a>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
							<div id="paging" align="center">
								<nav>
									<ul class="pagination" id="publicpaging">
										<!-- 페이지 번호 처리 -->
										<c:if test="${gympage.pcurrentPage <=1 }">
											<li class='disabled'><a href='#' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>
										</c:if>
										<c:if test="${gympage.pcurrentPage > 1 }">
											<c:choose>
									    	<c:when test="${gympage.pcurrentPage-5 >= 1}">
									    		<input type="hidden" name="page" value="${gympage.pcurrentPage - 5}">
												<li>
													<a href='javascript:loadPublicList(${gympage.pcurrentPage - 5})' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a>
												</li>
									    	</c:when>
									    	<c:otherwise>
									    		<li class='disabled'><a href='javascript:loadPublicList(${gympage.startPage})' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>
									      	</c:otherwise>
									      	</c:choose>
										</c:if>
										<c:forEach var="i" begin="${gympage.pstartPage }" end="${gympage.pendPage }" step="1">
											<c:if test="${gympage.pcurrentPage eq i }">
												<li class='disabled'><a href='#'>${i }</a></li>
												<input type="hidden" name="page" value="${gympage.pcurrentPage }">
											</c:if>
											<c:if test="${gympage.pcurrentPage ne i }">
												<li><a href="javascript:loadPublicList(${i })">${i }</a></li>
												<input type="hidden" name="page" value="${i}">
											</c:if>
										</c:forEach>
										<c:if test="${gympage.pcurrentPage >= gympage.pmaxPage }">
											<li class='disabled'><a href='#' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>
											<input type="hidden" name="page" value="${gympage.pcurrentPage }">
										</c:if>
										<c:if test="${gympage.pcurrentPage < gympage.pmaxPage }">
											<c:choose>
									    	<c:when test="${gympage.pcurrentPage+5 <= gympage.pmaxPage}">
												<li><a href='javascript:loadPublicList(${gympage.pcurrentPage + 5})' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>
									    	</c:when>
									    	<c:otherwise>
									    		<li><a href='javascript:loadPublicList(${gympage.pmaxPage})' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>
									      	</c:otherwise>
									      	</c:choose>
										</c:if>
									</ul>
								</nav>
							</div>
							<!-- paging -->
						</div>
						<!-- tab panel public -->
					</div>
					<!-- tab panel -->
				</div>
				<!-- tab content -->
			</div>
			<!-- row -->
		</div>
		<!-- col-md-4 -->

		<div class="col-md-7" style="margin-top:60px;" align="center">
			<div id="marker-explain">
			<span>내위치 <img width="16" src="/fitnessground/resources/images/current_marker.png">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			공공시설<img width="16" src="/fitnessground/resources/images/public_marker.png">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			헬스장 <img width="16" src="/fitnessground/resources/images/gym_marker.png"> </span>
			</div>
			<div id="map">
				<script type="text/javascript" src="/fitnessground/resources/js/gym/gymmap.js"></script>
			</div>
		</div>
		<!-- div class -->
	</div>
	<!-- row -->
</div>
<!-- container -->
<c:import url="../include/main/footer.jsp" />
<c:import url="../include/common/end.jsp" />
