<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <c:import url="./include/common/head.jsp" />
	<link rel="stylesheet" href="/fitnessground/resources/css/workout/workout.css" />
    <c:import url="include/common/headend.jsp" />
	<script>
	$(document).ready(function(){

 		if ($(window).width()<500){
 		$('#start-btn').hide();
 		}
 	});
	</script>
    <div id="page-wrapper">
        <!-- Header -->
        <div id="header">
            <!-- Inner -->
        
            <c:import url="include/main/maininner.jsp" />
			
            <!-- Nav -->
            <c:import url="include/main/mainnav.jsp" />
            
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
            	<article id="1"></article>
            	<article id="2"></article>
            	<article id="3"></article>
            	<article id="4"></article>
            	<article id="5"></article>
            	<article id="6"></article>
            	<article id="7"></article>
            	<article id="8"></article>
            	<article id="9"></article>
            	<article id="10"></article>
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
        <div class="wrapper style1" id="bmi-wrapper">

            <section id="features" class="container special">
                <header>
                    <h2>BMI 측정기</h2>
                    <p>당신의 체질량지수를 측정해보세요 .</p>
                </header>
                <div class="sliders">
                	<!-- <div class="gender">
                		<span>성별:</span>
                		<div id="gender">
	                		<label class="radio-inline">
							  <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="1"> 남
							</label>
							<label class="radio-inline">
							  <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="2"> 여
							</label>
						</div>
                	</div> -->
	                <div class="range-slider">
	                <p>키(cm):</p>
					  <input class="range-slider__range" type="range" value="170" min="130" max="200" id="height">
					  <span class="range-slider__value">0</span>
					</div>
					
					<div class="range-slider">
					 <p>몸무게(kg):</p>
					  <input class="range-slider__range" type="range" value="65" min="30" max="150" step="5" id="weight">
					  <span class="range-slider__value">0</span>
					</div>
				</div>
				<div class="explanation">
					
				<span>BMI란  체질량 지수(體質量指數, Body Mass Index)로서  비만도를 측정하는 지수입니다.</span><br>
					<span>BMI는 18세 이상의 성인들을 측정하기에 적합하지만, 나이나 성별 등 개인 차를 고려하지 않기 때문에 완전히 정확한 신체 측정이라고 보기는 어렵습니다.
					정확한 측정을 위해서는 허리둘레, 체지방률까지 함께 측정할 것을 권장합니다. 헬스트레이너, 의사 등과 상의해보세요.
				</span>
				</div>
                <a href="javascript: bmiCal();" class="btn btn-primary" id="bmi-btn">나의 BMI지수 확인하기</a>
            </section>
            
            <script type="text/javascript">
            function bmiCal(){
            	var weight = $('#weight').val();
            	var height = $('#height').val();
            	var queryString = { "weight": weight, "height":height };
            	$.ajax({
            		url: 'bmi.do',
            		data : queryString,
            		type : "post",
            		dataType: "json",
            		async: false,
                   success : function(result){
                	   var yourbmi = result.bmi;
                	   var result;
                	   var indication;
                	   var expl;
         			  if(yourbmi<18.5){
         				  indication = ((yourbmi-7.5)*17/11)*0.94;
         				  result = "저체중입니다(BMI 18.5이하)";
         				  expl = "";
         			  }else if(yourbmi<24.9){
         				  indication= (((yourbmi-18.5)*(55-17)/6.4)+17)*0.94;
         				  result = "정상체중입니다(BMI 18.5 ~ 24.9)";
         				 expl = "건강한 몸을 위해 꾸준히 운동해주세요 :)"
         			  }else if(yourbmi<30){
         				  indication= (((yourbmi-25)*(83-55)/5)+55)*0.94;
         				  result = "과체중입니다(BMI 25 ~ 30)";
         				 expl = "건강한 몸을 위해 운동을 시작하세요! :)"
         			  }else{
         				  indication= (((yourbmi-30)*(100-83)/58.8)+83)*0.94;
         				  result = "비만입니다(BMI 30 이상)";
         				 expl = "지금 바로 운동을 시작하세요! :)"
         			  }
                	   $('.explanation').html('<div class="bmi-num"><a class="t-top t-md" data-toggle="tooltip" data-placement="top" title="'+yourbmi+'"></a></div>');
                	   $('.explanation').append('<div id="resultbar"><div id="bmi_underweight" class="__part is_underweight">'+
							'<span class="__indicator  bmiResult  js_bmi_indicator" data-min="7" data-max="18.5" style="left: 149.565%;"></span>'+
							'<span class="__section-name  is_large">저체중</span>'+
							'</div><div id="bmi_normal" class="__part is_normal is_active">'+
							'<span class="__indicator  bmiResult  js_bmi_indicator" data-min="18.5" data-max="25" style="left: 87.6923%;"></span>'+
							'<span class="__section-name">건강해요<i class="fa fa-smile-o"></i></span>'+
						'</div><div id="bmi_overweight" class="__part is_overweight">'+
							'<span class="__indicator  bmiResult  js_bmi_indicator" data-min="25" data-max="30" style="left: -16%;"></span>'+
						'<span class="__section-name  is_large">과체중</span>'+
						'</div><div id="bmi_obese" class="__part is_obese">'+
							'<span class="__indicator  bmiResult  js_bmi_indicator" data-min="30" data-max="88" style="left: -10%;"></span>'+
							'<span class="__section-name  is_large">비만</span>'+
							'</div><div class="result"><p id="result">'+result+'</p><span>'+expl+'</span></div></div>');
                	  
                		 $(function () { 
                			  $('[data-toggle="tooltip"]').tooltip({trigger: 'manual'}).tooltip('show');
                			  
                			  $('.tooltip').css("margin-left",indication+"%");
                			  
                			});  
                
                   },
                   error : function(request, status, errorData){
                       alert("error code : " + request.status + "\n"
                             + "message : " + request.responseText
                             + "\n" + "error : " + errorData);
                    }
            	});
            }
            
            var rangeSlider = function(){
            	  var slider = $('.range-slider'),
            	      range = $('.range-slider__range'),
            	      value = $('.range-slider__value');
            	    
            	  slider.each(function(){

            	    value.each(function(){
            	      var value = $(this).prev().attr('value');
            	      $(this).html(value);
            	    });

            	    range.on('input', function(){
            	      $(this).next(value).html(this.value);
            	    });
            	  });
            	};

            	rangeSlider();
            </script>

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
       			async:false,
       			success:function(result){

       				console.log('ajax 호출 성공');
       				
       				
       				var jsonStr = JSON.stringify(result);
       				var json = JSON.parse(jsonStr);
       			          	
       			 	var title;
					var url;
					var content;	 									   						
					
       				
       				for(var i in json.list){
       					var no = json.list[i].v_no;
       					console.log(decodeURIComponent(json.list[i].url));
       					
       					if(decodeURIComponent(json.list[i].category1) == "헬스"){ //네이버
       						console.log("i 값 : " + i);
       						values =	
           	                '<a href="javascript:detailView('
           	                    		+json.list[i].v_no + ',\''+ decodeURIComponent(json.list[i].category1) + '\',' + '\'' + decodeURIComponent(json.list[i].category2).replace(/\+/g,' ') +'\');" class="image featured"><img src="' +decodeURIComponent(json.list[i].url) + '" alt=""/></a>'+
           	                '<header>'+
           	                    '<h4><a id = "v-title" href="javascript:detailView('
           	                    		+json.list[i].v_no + ',\''+ decodeURIComponent(json.list[i].category1) + '\',' + '\'' + decodeURIComponent(json.list[i].category2).replace(/\+/g,' ') +'\');">'
           	                    +decodeURIComponent(json.list[i].title).replace(/\+/g," ") + 
           	                    '</a></h4>'+
           	                '</header>';
           	            	
           	            	console.log(values);
           	            	
           	            	$("#"+i).append(values);
           	            	
       					}else{ //유튜브
       						console.log("유튜브 들어옴");
       						
       					title = decodeURIComponent(json.list[i].title).replace(/\+/g," ");
       						vid = decodeURIComponent(json.list[i].url);
       						content = decodeURIComponent(json.list[i].title).replace(/\+/g," ");
       						
       						var category1 = decodeURIComponent(json.list[i].category1);
       						var category2 = decodeURIComponent(json.list[i].category2).replace(/\+/g,' ');
       						var v_no = json.list[i].v_no; 
       						var rank= i;
       						getYoutubeThumbnail(title,vid,content,category1,category2,v_no,rank);
       						
       					
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
    
    
     	function getYoutubeThumbnail(title,vid,content,category1,category2,v_no,rank){
    		console.log("메서드 실행");
    		var thumbnail;
    		var value = "";
    		
    		$.get("https://www.googleapis.com/youtube/v3/videos", {
				part : 'snippet',
				maxResults : 50,
				id : vid,
				key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A',
				async:false,
			}, function(data) {

				$.each(data.items, function(i, item) {
					console.log("data.items : " + data.items);
					
					 thumbnail = item.snippet.thumbnails.medium.url;
					
					 value =	'<div>' +
    	                '<a href="javascript:detailView('
    	                    		+ v_no + ',\''+ category1 + '\',' + '\'' + category2+'\');" class="image featured"><img src="' + thumbnail + '" alt="" /></a>'+
    	                '<header>'+
    	                    '<h4><a id = "v-title" href="javascript:detailView('
    	                    		+ v_no + ',\''+ category1 + '\',' + '\'' + category2 +'\');">'
    	                    + title.substring(0,18).concat("...") + 
    	                    '</a></h4>'+
    	                '</header>'+
    	            	'</div>'
    	            	
    	            	$("#"+rank).append(value);
    	            	console.log(value);
    	            						
				});
			});
    		console.log("메서드 끝");
    		
    		   		
    	}    
	
    
	</script>

    <c:import url="./include/main/footer.jsp" />
    <c:import url="./include/common/end.jsp" />