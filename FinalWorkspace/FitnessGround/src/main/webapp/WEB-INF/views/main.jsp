<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <c:import url="./include/common/head.jsp" />
	<link rel="stylesheet" href="/fitnessground/resources/css/workout/workout.css" />
	<link rel="stylesheet" href="/fitnessground/resources/css/common/main.css" />
    <c:import url="include/common/headend.jsp" />

    <div id="page-wrapper">
        <!-- Header -->
        <div id="header">
            <!-- Inner -->
        
            <c:import url="include/main/maininner.jsp" />
			
            <!-- Nav -->
            <c:import url="include/main/nav.jsp" />
            
            <c:import url="user/login.jsp"/>
			<c:import url="user/findidpwd.jsp"/>
			<c:import url="user/register.jsp"/>
			<c:import url="workout/detailView.jsp"/>
        </div>
        <!-- Banner -->
        <section id="banner">
            <header>
                <h2>동영상을 보면서 운동 기초를 다져보세요 .</h2>
            </header>
            <h3>헬스, 요가, 필라테스, 맨몸운동 - 종류별/부위별 다양한 동영상이 제공됩니다 </h3>
        </section>

        <!-- Carousel -->
        <section class="carousel">	<!-- 캐러셀  -->
            <div class="reel">
            	
            </div>
        </section>

        <!-- Main -->
        <div class="wrapper style2">

            <article id="main" class="container special">
                <header>
                    <h3 id="gym-title">내 주변 운동시설/헬스장을 찾아보세요</h3>
                </header>
                <footer>
                	<input type="search" placeholder="지역을 입력하세요">
                    <a href="#" class="btn"><i class="fa fa-search fa-2x" aria-hidden="true"></i></a>
                </footer>
            </article>

        </div>

        <!-- Features -->
        <div class="wrapper style1">

            <section id="features" class="container special">
                <header>
                    <h2>커뮤니티</h2>
                    <p>Ipsum volutpat consectetur orci metus consequat imperdiet duis integer semper magna.</p>
                </header>
                <div class="row">
                    <article class="4u 12u(mobile) special">
                        <a href="#" class="image featured"><img src="/fitnessground/resources/images/pic07.jpg" alt="" /></a>
                        <header>
                            <h3><a href="#">Gravida aliquam penatibus</a></h3>
                        </header>
                        <p>
                            Amet nullam fringilla nibh nulla convallis tique ante proin sociis accumsan lobortis. Auctor etiam porttitor phasellus tempus cubilia ultrices tempor sagittis. Nisl fermentum consequat integer interdum.
                        </p>
                    </article>
                    <article class="4u 12u(mobile) special">
                        <a href="#" class="image featured"><img src="/fitnessground/resources/images/pic08.jpg" alt="" /></a>
                        <header>
                            <h3><a href="#">Sed quis rhoncus placerat</a></h3>
                        </header>
                        <p>
                            Amet nullam fringilla nibh nulla convallis tique ante proin sociis accumsan lobortis. Auctor etiam porttitor phasellus tempus cubilia ultrices tempor sagittis. Nisl fermentum consequat integer interdum.
                        </p>
                    </article>
                    <article class="4u 12u(mobile) special">
                        <a href="#" class="image featured"><img src="/fitnessground/resources/images/pic09.jpg" alt="" /></a>
                        <header>
                            <h3><a href="#">Magna laoreet et aliquam</a></h3>
                        </header>
                        <p>
                            Amet nullam fringilla nibh nulla convallis tique ante proin sociis accumsan lobortis. Auctor etiam porttitor phasellus tempus cubilia ultrices tempor sagittis. Nisl fermentum consequat integer interdum.
                        </p>
                    </article>
                </div>
            </section>

        </div>

        <!-- Footer -->
        
    </div>
    
    <script type="text/javascript">
	$(function(){
		
		
		var user_level = ${sessionScope.user.user_level} //일반회원
		console.log(user_level);
   	
       	/* if(!user_level){ */	//로그인 안했을 때 좋아요 많은 순서
       		console.log("if문 실행");
        
      	 	var values="";
      	 	
      	 	$.ajax({
       			url:'mainVideoList.do',
       			type:'post',
       			success:function(result){

       				console.log('ajax 호출 성공');
       				
       				
       				var jsonStr = JSON.stringify(result);
       				var json = JSON.parse(jsonStr);
       			          	
       			/* 	var title;
					var url;
					var content;	 */										   						
						
       				
       				for(var i in json.list){
       					var no = json.list[i].v_no;
       					console.log(decodeURIComponent(json.list[i].url));
       					
       					if(decodeURIComponent(json.list[i].category1) == "헬스"){ //네이버
       						console.log("i 값 : " + i);
       						values =	'<article>' +
           	                '<a href="javascript:detailView('
           	                    		+json.list[i].v_no + ',\''+ decodeURIComponent(json.list[i].category1) + '\',' + '\'' + decodeURIComponent(json.list[i].category2).replace(/\+/g,' ') +'\');" class="image featured"><img src="' +decodeURIComponent(json.list[i].url) + '" alt=""/></a>'+
           	                '<header>'+
           	                    '<h4><a id = "v-title" href="javascript:detailView('
           	                    		+json.list[i].v_no + ',\''+ decodeURIComponent(json.list[i].category1) + '\',' + '\'' + decodeURIComponent(json.list[i].category2).replace(/\+/g,' ') +'\');">'
           	                    +decodeURIComponent(json.list[i].title).replace(/\+/g," ") + 
           	                    '</a></h4>'+
           	                '</header>'+
           	            	'</article>'
           	            	console.log(values);
           	            	
           	            	$("").append(values);
           	            	
       					}else{ //유튜브
       						console.log("유튜브 들어옴");
       						
       				/* 		title = decodeURIComponent(json.list[i].title).replace(/\+/g," ");
       						vid = decodeURIComponent(json.list[i].url);
       						content = decodeURIComponent(json.list[i].title).replace(/\+/g," ");
       						
       						var category1 = decodeURIComponent(json.list[i].category1);
       						var category2 = decodeURIComponent(json.list[i].category2).replace(/\+/g,' ');
       						var v_no = json.list[i].v_no; */
       						
       						//getYoutubeThumbnail(title,vid,content,category1,category2,v_no);
       						
       						(function(title,vid,content,category1,category2,v_no){
       							
           						title = decodeURIComponent(json.list[i].title).replace(/\+/g," ");
           						vid = decodeURIComponent(json.list[i].url);
           						content = decodeURIComponent(json.list[i].title).replace(/\+/g," ");
           						category1 = decodeURIComponent(json.list[i].category1);
           						category2 = decodeURIComponent(json.list[i].category2).replace(/\+/g,' ');
           						v_no = json.list[i].v_no;
           						
           						var thumbnail;
           			    		var value = "";
           			    		
           			    		$.get("https://www.googleapis.com/youtube/v3/videos", {
           							part : 'snippet',
           							maxResults : 50,
           							id : vid,
           							key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
           						}, function(data) {
           							
           							$.each(data.items, function(i, item) {
           								 thumbnail = item.snippet.thumbnails.medium.url;
           								 var j =0;
           								 value =	'<article>' +
           			    	                '<a href="javascript:detailView('
           			    	                    		+ v_no + ',\''+ category1 + '\',' + '\'' + category2+'\');" class="image featured"><img src="' + thumbnail + '" alt="" /></a>'+
           			    	                '<header>'+
           			    	                    '<h4><a id = "v-title" href="javascript:detailView('
           			    	                    		+ v_no + ',\''+ category1 + '\',' + '\'' + category2 +'\');">'
           			    	                    + title.substring(0,30).concat("...") + 
           			    	                    '</a></h4>'+
           			    	                '</header>'+
           			    	            	'</article>'
           			    	            	console.log("j : " + j + "value " + value);
           			    	            	j++;
           			    	            	$(".reel").append(value);
           								 
           								
           							});
           						});
           						
       						}());
               	            	
       					}//else 문 끝
       						
       				}//for문 끝      					
       			
       			},error: function(request, status, errorData){
       	            console.log("error code : " + request.status + "\n"
       	                  + "message : " + request.responseText + "\n"
       	                  + "error : " + errorData);
       	         }
     	  	})
       	          	
		       	
	/* 	} */
       	
	});	
    
    
    /* 	function getYoutubeThumbnail(title,vid,content,category1,category2,v_no){
    		console.log("메서드 실행");
    		var thumbnail;
    		var value = "";
    		
    		$.get("https://www.googleapis.com/youtube/v3/videos", {
				part : 'snippet',
				maxResults : 50,
				id : vid,
				key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
			}, function(data) {
				
				$.each(data.items, function(i, item) {
					 thumbnail = item.snippet.thumbnails.medium.url;
					 var j =0;
					 value =	'<article><div>' +
    	                '<a href="javascript:detailView('
    	                    		+ v_no + ',\''+ category1 + '\',' + '\'' + category2+'\');" class="image featured"><img src="' + thumbnail + '" alt="" /></a>'+
    	                '<header>'+
    	                    '<h3><a id = "v-title" href="javascript:detailView('
    	                    		+ v_no + ',\''+ category1 + '\',' + '\'' + category2 +'\');">'
    	                    + title.substring(0,18).concat("...") + 
    	                    '</a></h3>'+
    	                '</header>'+
    	            	'</div></article>'
    	            	console.log("j : " + j + "value " + value);
    	            	j++;
    	            	$("#view_video").append(value);
					 
					
				});
			});
    		
    		
    	} */
    
    
   				
    
	</script>

    <c:import url="./include/main/footer.jsp" />
    <c:import url="./include/common/end.jsp" />