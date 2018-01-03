<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page
	import="com.kh.fitnessground.workout.yoga.model.vo.Yoga, java.util.List"%>
<c:import url="../include/common/head.jsp" />

<link rel="stylesheet"
	href="/fitnessground/resources/css/workout/workout.css" />

<c:import url="../include/common/headend.jsp" />
	
<script type="text/javascript" src="/fitnessground/resources/js/workout/workout.js"></script>

<!-- Header -->
<div id="mypage_header">
	<!-- Nav -->
	<c:import url="../include/main/nav.jsp" />
	<c:import url="../user/login.jsp"/>
	<c:import url="../user/findidpwd.jsp"/>
	<c:import url="../user/register.jsp"/>
</div> 
<!-- Modal -->
	<c:import url="detailView.jsp" />

<!-- yoga body -->
<div class="col-sm-12 col-md-12 col-lg-12 col-xs-12" id="workout-body">


	<!-- tab testing -->
	<div class="container is-bg-a">
		<!-- tab-list -->
		<div class="wrap">
			<div class="tab-wrap">
				<div id="hidecate"> <!-- 카테고리별 셀렉박스 알아내는 자리 -->
				
				</div>
				<ul class="tab-list tab-b is-col-3">
					<li><a href="healthMain.do"><span>헬스</span></a></li>
					<li class="in"><a href="yogaMain.do"><span>요가</span></a></li>
					<li><a href="pilatesMain.do"><span>필라테스</span></a></li>
					<li><a href="homeTraning.do"><span>맨몸운동</span></a></li>
				</ul>
			</div>
			
		</div>
	</div>
	<!-- // tab-list -->

	<div class="container news-section-tab">
		<!-- news-section-tab -->
		<div class="wrap">
			<div class="tab-wrap" id="press-cate">
				<ul class="tab-list">
					<li id="tab-li"><a href="javascript: category('빈야사')" class="t-bottom t-md" data-tooltip="동작과 동작이 물흐르듯 연결이 되는, 연속적으로 움직이는 요가입니다.">빈야사<span id="count">(${count1})</span></a></li>
					<li id="vertical-bar"><span>|</span></li>
					<li id="tab-li"><a href="javascript: category('다이어트')">다이어트<span id="count">(${count2})</span></a></li>
					<li id="vertical-bar"><span>|</span></li>
					<li id="tab-li"><a href="javascript: category('체형교정')">체형교정<span id="count">(${count3})</span></a></li>
					<li id="vertical-bar"><span>|</span></li>
					<li id="tab-li"><a href="javascript: category('부위별')">부위별요가<span id="count">(${count4})</span></a></li>
					<li id="vertical-bar"><span>|</span></li>
					<li id="tab-li"><a href="javascript: category('초보자')">초보자<span id="count">(${count5})</span></a></li>
				</ul>
			</div>
			<div class="sort-area">
				<div id="select-div">
						<!-- 	<select name="sort" id="sort">
					<option value="All">All</option>
					<option value="좋아요수">좋아요수</option>
					<option value="조회수">조회수</option>
				</select> -->
				
				</div>
				<!-- animated 검색바 -->
				
				<c:if test="${empty keyWord}"> <span id="head-title">Yoga 전체 인기동영상</span> </c:if>	<!-- 일반 -->
				
				<c:if test="${!empty keyWord }"><span id="head-title"> '${keyWord}' 로 검색한 동영상</span></c:if> <!-- 제목으로 검색 했을 때 -->
				
				<div class="srch_wrpr" id="main-wrpr">
					<div class="srch_sb_cnt">
						<input type="text" name="searchKeyWord" id="title-search" class="sech_txt_inpt"
							placeholder="제목으로 검색" onkeydown="javascript: if(event.keyCode==13){titleSearch();}">
						<a href="javascript: titleSearch();" class="btn btn-primary" id="srch-btn" type="submit"><i class="fa fa-search" aria-hidden="true"></i></a>
					</div>
				</div>
				
				<hr id="video-line">
				
			</div>
		</div>
	</div>
	<!-- thumbnail & 재생시간 youtube API call -->
					<script type="text/javascript">
					var list = new Array(); 
					var duration; 
					var thumbnail;
					var st;
					<c:forEach items="${list}" var="it" varStatus="status">
					list.push("${it.url}");
					st = ${status.count}-1;
					console.log(list);
					/* $(document).ready(function(){ */
						/* for(var i=0;i<5;i++){ */
							$.get("https://www.googleapis.com/youtube/v3/videos", {
								part : 'contentDetails',
								maxResults : 50,
								id : list[st],
								key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
							}, function(data) {
								
								$.each(data.items, function(i, item) {
									duration = item.contentDetails.duration;
									//API시간 -->HH:MM:SS형태로 변환
									var hourRegex = new RegExp("[0-9]{1,2}H", "gi");
			                        var minRegex = new RegExp("[0-9]{1,2}M", "gi");
			                        var secRegex = new RegExp("[0-9]{1,2}S", "gi");
			    
			                        var hour = hourRegex.exec(duration);
			                        var min = minRegex.exec(duration);
			                        var sec = secRegex.exec(duration);
			                        
			                        if(hour!==null){
			                            hour = hour.toString().split("H")[0] + ":";
			                        }else{
			                            hour = "";
			                        }
			                        if(min !==null){
			                            min = min.toString().split("M")[0];
			                            if(min.length<2){
					                    	   min = "0"+min;
					                    }
			                        }else{
			                            min = "00";
			                        }
			                        if(sec !==null){
			                            sec = sec.toString().split("S")[0];
			                            if(sec.length<2){
					                    	   sec = "0"+sec;
					                    }
			                        }else{
			                            sec = "00";
			                        }
			                        duration = hour+min+":"+sec;
									console.log("time:" + duration);
									$('#v-time${it.v_no}').append(duration);
								});
								
				
							});
						/* } */
						/* for(var i=0;i<5;i++){ */
							$.get("https://www.googleapis.com/youtube/v3/videos", {
								part : 'snippet',
								maxResults : 50,
								id : list[st],
								key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
							}, function(data) {
								
								$.each(data.items, function(i, item) {
									 thumbnail = item.snippet.thumbnails.medium.url;

									$('#video-iframe${it.v_no}').append('<img id=\"v-img\" src=\"'+thumbnail+'\">');
								});
				
							});
						/* } */
						/* }); */
					</c:forEach>
					</script>
	<!-- 동영상 리스트 view -->
	<div class="workout-videos">
		<c:if test="${empty list }">	<!-- 제목 검색 리스트 없을때 -->
			<div class="col-sm-12 col-md-12 col-lg-12 col-xs-12" id="search-count"> '${keyWord}' 검색 개수: ${searchCount }</div>
		</c:if>
	
		<c:if test="${!empty list}">		
			<c:if test="${!empty keyWord}">
				<div class="col-sm-12 col-md-12 col-lg-12 col-xs-12" id="search-count"> '${keyWord}' 검색 개수 : ${searchCount }</div>
			</c:if>
		
			<c:forEach items="${list}" var="y" varStatus="st">
					
				<div class="video">
					<a href='javascript:detailView(${y.v_no} , "${y.category1}" , "${y.category2}")'> 
						<div id="video-iframe${y.v_no}">
						</div>
					</a>
					<div id="video-info">
						<div class="time">
						<span class="video-time" id="v-time${y.v_no}"></span>
						</div>
						<span id="video-text">
						<a href='javascript:detailView(${y.v_no} , "${y.category1}" , "${y.category2}")'>${y.title }</a></span> 
						<%-- <span id="video-text"><c:url var="detail" value="#detail" /></span> --%>
						
					</div>
				</div>
			
			</c:forEach>
		</c:if>
	</div>
</div>
		
<script type="text/javascript">
//category별 ajax로 동영상 가져오기 
function category(category2){
	$('#head-title').hide();
	$('#main-wrpr').css('margin-top','3.4vh');
	
	var category = category2;
	var values = "<input type='hidden' id='selectCate' value=" + category2 + ">"
	
	$("#hidecate").html(values);
	
	var selectBox = '<select name="sort" id="sort" onchange="sortList();">'+
	'<option value="All" selected="selected">All</option>' +
	'<option value="좋아요수">좋아요수</option>'+
	'<option value="조회수">조회수</option>' +
	'</select>' 
	
	$("#select-div").html(selectBox);
	
	var queryString = { "category2": category };
	$.ajax({
		url: 'yclist.do',
		data : queryString,
		type : "post",
		dataType: "json",
		async: false,
       success : function(result){
          console.log("전송성공:");
          var title;
          var url;
          var content;
  
          for(var i=0;i<result.clist.length;i++){
        	  (function(title, vid, content){
	          var no = result.clist[i].v_no;
	          title = result.clist[i].title;
	          vid = result.clist[i].url;
	          content = result.clist[i].content;
	          var value ="<div class='video'><a href='javascript:detailView("+no+")'><div id='video-iframe"+no+"'></div></a><div id='video-info'><div class='time'><span class='video-time' id='v-time"+no+"'></span>"+
					"</div><span id='video-text'><a href='javascript:detailView("+no+")'>"+title+"</a></span></div></div>";
		
				if(i==0){
					$('.workout-videos').html(value);
				}else{
				  $('.workout-videos').append(value);
	          	}
	
				var duration; 
				var thumbnail;
				var timeid = '#v-time'+no;
				console.log("timeid outside"+timeid);
				
				//이번에도 순서문제. $.get이하가 for문을 다 돌고나서 실행되어버림....api호출이늦어서인가,, 
					$.get("https://www.googleapis.com/youtube/v3/videos", {
						part : 'contentDetails',
						maxResults : 50,
						id : vid,
						key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
					}, function(data) {
						
						$.each(data.items, function(i, item) {
							duration = item.contentDetails.duration;
							//API시간 -->HH:MM:SS형태로 변환
							var hourRegex = new RegExp("[0-9]{1,2}H", "gi");
	                        var minRegex = new RegExp("[0-9]{1,2}M", "gi");
	                        var secRegex = new RegExp("[0-9]{1,2}S", "gi");
	    
	                        var hour = hourRegex.exec(duration);
	                        var min = minRegex.exec(duration);
	                        var sec = secRegex.exec(duration);
	                        
	                        if(hour!==null){
	                            hour = hour.toString().split("H")[0] + ":";
	                        }else{
	                            hour = "";
	                        }
	                        if(min !==null){
	                            min = min.toString().split("M")[0];
	                            if(min.length<2){
			                    	   min = "0"+min;
			                    }
	                        }else{
	                            min = "00";
	                        }
	                        if(sec !==null){
	                            sec = sec.toString().split("S")[0];
	                            if(sec.length<2){
			                    	   sec = "0"+sec;
			                    }
	                        }else{
	                            sec = "00";
	                        }
	                        duration = hour+min+":"+sec;
							console.log("time:" + duration);
							
							console.log("t:"+timeid);
							$(timeid).append(duration);
						});
						
		
					});
				
					$.get("https://www.googleapis.com/youtube/v3/videos", {
						part : 'snippet',
						maxResults : 50,
						id : vid,
						key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
					}, function(data) {
						
						$.each(data.items, function(i, item) {
							 thumbnail = item.snippet.thumbnails.medium.url;

							$('#video-iframe'+no).append('<img id=\"v-img\" src=\"'+thumbnail+'\">');
						});
					}
					);
					
				}(i));//api codes exit
          };//for문종료 

          $("#sort").val("All").attr("selected","selected");
          
       },
       error : function(request, status, errorData){
          alert("error code : " + request.status + "\n"
                + "message : " + request.responseText
                + "\n" + "error : " + errorData);
       }
	});
}

function titleSearch(){
	var searchKeyWord =$("#title-search").val();
	var category1="요가";
	location.href="yogaSearch.do?searchKeyWord=" + searchKeyWord + "&category1=" + category1;
}

function sortList(){ //체크박스 sortList
	var selectValue = $("#sort option:selected").val();
	var category1="요가";
	var category2 = $("#selectCate").val();
	var title;
    var url;
    var content;
	
    	
	var queryString = {"selectValue":selectValue,"category1":category1,"category2":category2};
		
	$.ajax({
		url: "ypSortList.do",
		data: queryString,
		type:"post",
		dataType:"json",
		async:false,
		success:function(result){
						
			  for(var i=0;i<result.list.length;i++){
	        	  (function(title, vid, content){
		          var no = result.list[i].v_no;
		          title = result.list[i].title;
		          vid = result.list[i].url;
		          content = result.list[i].content;
		          var value ="<div class='video'><a href='javascript:detailView("+no+")'><div id='video-iframe"+no+"'></div></a><div id='video-info'><div class='time'><span class='video-time' id='v-time"+no+"'></span>"+
						"</div><span id='video-text'><a href='javascript:detailView("+no+")'>"+title+"</a></span></div></div>";
			
					if(i==0){
						$('.workout-videos').html(value);
					}else{
					  $('.workout-videos').append(value);
		          	}
					
					var duration; 
					var thumbnail;
					var timeid = '#v-time'+no;
					//console.log("timeid outside"+timeid);
					
					//이번에도 순서문제. $.get이하가 for문을 다 돌고나서 실행되어버림....api호출이늦어서인가,, 
						$.get("https://www.googleapis.com/youtube/v3/videos", {
							part : 'contentDetails',
							maxResults : 50,
							id : vid,
							key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
						}, function(data) {
							
							$.each(data.items, function(i, item) {
								duration = item.contentDetails.duration;
								//API시간 -->HH:MM:SS형태로 변환
								var hourRegex = new RegExp("[0-9]{1,2}H", "gi");
		                        var minRegex = new RegExp("[0-9]{1,2}M", "gi");
		                        var secRegex = new RegExp("[0-9]{1,2}S", "gi");
		    
		                        var hour = hourRegex.exec(duration);
		                        var min = minRegex.exec(duration);
		                        var sec = secRegex.exec(duration);
		                        
		                        if(hour!==null){
		                            hour = hour.toString().split("H")[0] + ":";
		                        }else{
		                            hour = "";
		                        }
		                        if(min !==null){
		                            min = min.toString().split("M")[0];
		                            if(min.length<2){
				                    	   min = "0"+min;
				                    }
		                        }else{
		                            min = "00";
		                        }
		                        if(sec !==null){
		                            sec = sec.toString().split("S")[0];
		                            if(sec.length<2){
				                    	   sec = "0"+sec;
				                    }
		                        }else{
		                            sec = "00";
		                        }
		                        duration = hour+min+":"+sec;
								/* console.log("time:" + duration); */
								
							/* 	console.log("t:"+timeid); */
								$(timeid).append(duration);
							});
							
			
						});
					
						$.get("https://www.googleapis.com/youtube/v3/videos", {
							part : 'snippet',
							maxResults : 50,
							id : vid,
							key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
						}, function(data) {
							
							$.each(data.items, function(i, item) {
								 thumbnail = item.snippet.thumbnails.medium.url;

								$('#video-iframe'+no).append('<img id=\"v-img\" src=\"'+thumbnail+'\">');
							});
						}
						);
						
					}(i));//api codes exit
	          };//for문종료 
			
		},
		 error : function(request, status, errorData){
	          alert("error code : " + request.status + "\n"
	                + "message : " + request.responseText
	                + "\n" + "error : " + errorData);
	       }
	})
	

}
</script>


<c:import url="../include/main/footer.jsp" />
<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> 
		<i class="fa fa-angle-up"></i>
		</a>
<c:import url="../include/common/end.jsp" />				 