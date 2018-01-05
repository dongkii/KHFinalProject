<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="../include/common/head.jsp" />
<link rel="stylesheet" href="/fitnessground/resources/css/workout/workout.css"/>	
<!-- <link rel="stylesheet" href="/fitnessground/resources/css/workout/detailView.css"/> -->
<link rel="stylesheet" href="/fitnessground/resources/css/workout/health.css"/>	

<c:import url="../include/common/headend.jsp" />
<script type="text/javascript"
	src="/fitnessground/resources/js/workout/workout.js"></script>
<script type="text/javascript" src="/fitnessground/resources/js/workout/muscle.js"></script>

<!-- Header -->
<div id="mypage_header">
	<!-- Nav -->
	<c:import url="../include/main/nav.jsp"/>
	<c:import url="../user/login.jsp"/>
	<c:import url="../user/findidpwd.jsp"/>
	<c:import url="../user/register.jsp"/>	
</div>

<!-- Modal -->
<c:import url="detailView.jsp"/>

<!-- health head -->
<!-- <div id="workout-head">
	<h2 id="workout-title">Health</h2>
</div> -->
	
	<!-- Health Body -->
<div class="col-sm-12 col-md-12 col-lg-12 col-xs-12" id="workout-body">	
	
	<!-- tab testing -->
	<div class="container is-bg-a">
		<!-- tab-list -->
		<div class="wrap">
			<div class="tab-wrap">
				<ul class="tab-list tab-b is-col-3">
					<li class="in"><a href="#"><span>헬스</span></a></li>
					<li><a href="yogaMain.do"><span>요가</span></a></li>
					<li><a href="pilatesMain.do"><span>필라테스</span></a></li>
					<li><a href="homeTraning.do"><span>맨몸운동</span></a></li>
				</ul>
			</div>
		</div>
	</div>

	



	<!-- 근육 이미지 -->
	<div class = "container">
		<div class ="row">
			<div id="menu"> 
			<div id="diagram" style="background-position: 0px 0px;">
				<div>
				<img src="/fitnessground/resources/images/health/muscle.jpg" alt="Click on a muscle group"
					usemap="#bodyMap" id="myimage" >	
	
				<map name="bodyMap" id="muscle_img_map">
					<!-- 가슴 -->
					<area shape="poly" 
						coords="94,62,72,56,65,68,66,79,74,85,88,85,92,81,100,86,117,83,124,72,115,57"
						href="#" alt="Chest" state="Chest" full="chest" onclick="popUp('chest');"
						data-key = "chest" data-full="chest">
					<!--  왼쪽 어깨 -->
					<area shape="poly"
						coords="60,51,48,53,48,53,48,53,45,62,56,68,67,65,70,56" href="#"
						alt="Shoulders" state="Shoulders" full="shoulders" onclick="popUp('shoulders'); return false;"
						data-key ="shoulders">
					<!-- 오른쪽 어깨 -->
					<area shape="poly"
						coords="134,52,116,49,114,62,126,69,135,65,138,62,138,62" href="#"
						alt="Shoulders" state="Shoulders" full="shoulders" onclick="popUp('shoulders'); return false;"
						data-key="shoulders">
					
					<!-- 뒤쪽 어깨 -->
					<area shape="poly"
						coords="302,63,296,52,263,41,241,44,215,52,205,60,204,65" href="#"
						alt="Shoulders" state="Shoulders" full="shoulders" onclick="popUp('shoulders'); return false;"
						data-key="shoulders">
													
					<!-- 위팔 앞 왼쪽 삼두 -->
					<area shape="poly" coords="47,65,36,75,51,87" href="#"
						alt="triceps" state="Triceps" full="Triceps" onclick="popUp('triceps'); return false;"
						data-key ="triceps">
					
					<!-- 위팔 앞 오른쪽 삼두 -->				
					<area shape="poly" coords="137,84,145,67,131,63" href="#"
						alt="triceps" state = "Triceps" full="Triceps" onclick="popUp('triceps'); return false;"
						data-key = "triceps">
					
					<!-- 뒤 왼쪽 삼두 -->
					<area shape="poly"
						coords="204,65,199,75,207,82,218,88,216,66,216,66" href="#"
						alt="Triceps" state = "Triceps" full="triceps" onclick="popUp('triceps'); return false;"
						data-key="triceps">
				
	
					<!-- 뒤 오른쪽 삼두-->
					<area shape="poly" coords="292,71,303,63,306,84,301,89,286,81"
						href="#" alt="Triceps" state = "Triceps" full="triceps"
						onclick="popUp('triceps'); return false;"
						data-key="triceps">					
					
					
					<!-- 위팔 뒤 왼쪽 이두 -->
					<area shape="poly" coords="46,66,49,85,61,83,61,73,60,67,60,67"
						href="#" alt="Biceps" state="BI" full="Biceps" onclick="popUp('biceps'); return false;"
						data-key="biceps" >
					
					<!-- 위팔 뒤 오른쪽 이두 -->
					<area shape="poly"
						coords="121,73,130,67,137,85,131,88,124,85,123,84" href="#"
						alt="Biceps" state = "BI" full="Biceps" onclick="popUp('biceps'); return false;"
						data-key="biceps">
					
					<!-- 아래팔 왼쪽 전완-->
					<area shape="poly" coords="38,96,39,111,50,111,54,91" href="#"
						alt="lowerarm" state="LowArm" full="Lowarm" onclick="popUp('lowerarm'); return false;"
						data-key="lowerarm">
					
					<!-- 아래팔 오른쪽 전완-->
					<area shape="poly" coords="132,90,149,98,146,111,133,110" href="#"
						alt="lowerarm" state="LowArm" full="Lowarm" onclick="popUp('lowerarm'); return false;"
						data-key="lowerarm">
	
					<!-- 등 -->
					<area shape="poly"
						coords="220,70,221,86,233,93,250,91,257,83,266,93,281,93,287,86,290,70"
						href="#" alt="Back" state = "Back" full="back" onclick="popUp('back'); return false;"
						data-key="back">
	
					<!-- 허리 -->
					<area shape="poly" coords="237,100,275,100,283,86,260,89,257,84,248,90,226,87" href="#"
						alt="Waits" state ="Waites" full="waites"
						onclick="popUp('waist'); return false;"
						data-key="waist">
						
					<!-- 중앙복부 -->
					<area shape="poly" coords="94,88,71,96,85,125,101,125,112,95,112,95"
						href="#" alt="Abdominals" state = "Abdominals" full="abs"
						onclick="popUp('abs'); return false;"
						data-key="abs">
					
					<!-- 엉덩이 -->
					<area shape="poly"
						coords="235,103,226,117,256,126,282,117,274,104,274,104" href="#"
						alt="Hips" state = "Hips" full="hips"
						onclick="popUp('hips'); return false;"
						data-key="hips">
								
					
					<!-- 앞 왼쪽 허벅지 -->
					<area shape="poly"
						coords="92,163,79,166,63,137,62,115,81,121,91,140" href="#"
						alt="Thighs" state = "Thighs" full="thighs"
						 onclick="popUp('thighs'); return false;"
						 data-key="thighs">
				
					<!-- 앞 오른쪽 허벅지 -->
					<area shape="poly"
						coords="100,168,96,155,98,137,104,123,119,114,123,131,118,153"
						href="#" alt="Thighs" state="Thighs" full="thighs"
						onclick="popUp('thighs'); return false;"
						data-key="thighs">
					
					
					<!-- 앞 왼쪽 종아리 -->
					<area shape="poly" coords="79,168,68,180,78,204,89,206,87,167"
						href="#" alt="Calf" state = "Calf" full="calf"
						onclick="popUp('calf'); return false;"
						data-key="calf">
					
					<!-- 앞 오른쪽 종아리 -->
					<area shape="poly"
						coords="100,172,109,165,116,184,106,206,96,207,93,192" href="#"
						alt="Calf" state = "Calf" full="calf"
						onclick="popUp('calf'); return false;"
						data-key="calf">
													
					<!-- 뒤 오른쪽 종아리-->
					<area shape="poly" coords="238,167,230,180,244,206,253,206,252,185"
						href="#" alt="BackCalf" state = "BackCalf" full="BackCalf"
						onclick="popUp('calf'); return false;"
						data-key="calf">
					
					<!-- 뒤 왼쪽 종아리-->
					<area shape="poly" coords="257,187,271,170,275,181,267,210,256,207"
						href="#" alt="Calf" state ="Calf" full="calf"
						onclick="popUp('calf'); return false;"
						data-key="calf">
						
					<!-- 뒤 왼쪽 허벅지 -->
					<area shape="poly" coords="227,118,233,159,250,163,251,128,251,128"
						href="#" alt="Back Thighs" state="Back Thighs" full="backthighs" data-key="backthighs"
						 onclick="popUp('backthighs'); return false;">
				
					<!-- 뒤 오른쪽 허벅지 -->
					<area shape="poly" coords="261,128,282,115,276,159,251,164" href="#"
						alt="Back Thighs" state="Back Thighs" full="backthighs" data-key="backthighs"
						onclick="popUp('backthighs'); return false;">
				
				</map>
				</div>
				
				
			</div>
	
		</div>
		
		
		<div class="explain">
		  <h3>부위별 헬스 동영상</h3>
		  <p>왼쪽 이미지에서 운동부위를 클릭해 주세요.</p>
		   
		</div>
	</div>
		
	<!-- /menu -->
	</div><!-- 사람인체 이미지 끝 -->

	<!-- video 뿌려주는 곳 -->
	
	<div class = "container">
		<div class = "row">
			<div class ="col-sm-offset-2">
				<p id="healthCategory"></p>
					<div class="workout_videos">
						<div id="loadingDiv">
						  <div class="loader">
						    <svg class="circular" viewBox="25 25 50 50">
						      <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"/>
						    </svg>
						  </div>
						</div>
						<div class="row justify-content-center" id="healthVideo">
							
							
						</div>
				</div>
			</div>
		</div>
	</div>

</div>

<script type="text/javascript">
	var areas = $.map($('area[data-full]'),function(el) {
	    return { 
	        key: $(el).attr('name'),
	        toolTip: $(el).attr('data-full')
	    };               
	});
	
	$('#loadingDiv').hide(); 
	$('#myimage').
		mapster({
			fillColor:'ff0000',
			fillOpacity:0.5,
			staticState:false,
			mapKey: 'data-key'
		});
	
	
	

	
	function popUp(part){	//부위에 따른 ajax 처리		
		
		$('#loadingDiv').show();
		
		var category1 = "헬스";
		var category2 = part;		
		
		if ( part == 'chest')
			category2 = "가슴";
		else if (part == 'shoulders')
			category2 = "어깨";
		else if(part == 'biceps')
			category2 = "위팔 앞(이두)";
		else if(part == 'triceps')
			category2 ="위팔 뒤(삼두)";
		else if(part == 'lowerarm')
			category2 = "아래팔";
		else if(part == 'back')
			category2 =  "등";
		else if(part == 'waist')
			category2 = "허리";
		else if(part == 'abs')
			category2 = "복근";
		else if(part == 'hips')
			category2 = "엉덩이";
		else if(part == 'thighs')
			category2 = "허벅지";
		else if(part == 'backthighs')
			category2 = "허벅지 뒤";
		else if(part =='calf')
			category2 = "종아리";
				
		$.ajax({
			url: "part.do",
			dataType:"json",
			data : {"category1":category1, "category2":category2},
			success: function(data){
				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);
				
				var values = "";
						
			
				for(var i in json.list){
					values +=
						"<div class='video'>" +
		                  "<a id='v-title' href='javascript:detailView("
		                  + json.list[i].v_no + ",\"" + decodeURIComponent(json.list[i].category1) + "\"," 
		                  + "\"" + decodeURIComponent(json.list[i].category2).replace(/\+/g," ") +"\");'>" +
		                  "<img src='"+decodeURIComponent(json.list[i].url)+"' id='video-thumbnail' width='250' ></a>" +
		                  "<a id='v-title' href='javascript:detailView("
		                        + json.list[i].v_no + ",\"" + decodeURIComponent(json.list[i].category1) + "\"," 
		                        + "\"" + decodeURIComponent(json.list[i].category2).replace(/\+/g," ") +"\");'>" + decodeURIComponent(json.list[i].title).replace(/\+/g," ") + "</a>"+
		                 "</div>"  
					
				}
				
				$("#healthCategory").html(category2 + "운동 동영상");
				$("#healthVideo").html(values);
				$('#loadingDiv').hide();
				
				
			},
			error: function(request, status, errorData){
				alert("error code : " + request.status + "\n"
						+ "message : " + request.responseText + "\n"
						+ "error : " + errorData);
			}
		});
		
	}
</script>


<c:import url="../include/main/footer.jsp"></c:import>
<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> 
		<i class="fa fa-angle-up"></i>
		</a>
<c:import url="../include/common/end.jsp"></c:import>