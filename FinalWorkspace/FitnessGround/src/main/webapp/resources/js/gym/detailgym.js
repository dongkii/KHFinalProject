var info = 1;
var sch = 1;
var loc = 1;
var com = 1;
var gym_name = $("#jsgym_name").val();
var category = $("#jscategory").val();
var tel = $("#jstel").val();
var phone = $("#jsphone").val();
var desc = $("#jsdesc").val();

$(document).ready(function(){
	var information = $("#info").position().top;
	var mobileinfo = $("#info").height();
	var gyminfo = $("#gyminfo").height() - 140;
	var schedule = $("#schedule").position().top;
	var location = $("#location").position().top;
	var comment = $("#comment").position().top;
	info = information;
	sch = schedule;
	loc = location;
	com = comment;
	var windowWidth = $( window ).width();
	if( windowWidth < 768){
		sch += gyminfo;
		loc += gyminfo;
		com += gyminfo;
	}
	var image = $("#imagevalue").val();
	imageoutput(image);
	console.log($('#address').val());
	searchAddressToCoordinate($('#address').val());
});

 function imageoutput(image){
	 var arr = new Array();
	 arr = image.split(',');
	 console.log(image);
	 if(image == ''){
		 indicators = '<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>';
		 item = '<div class="item active">' +
	      '<img src="resources/images/gymimages/로고.png" id="detailimg">' +
	      '<div class="carousel-caption">' +
	      '</div>' +
	    '</div>';
		 $("#indicator").append(indicators);
		 $("#inner").append(item);
	 } else {
		 for(var i=0; i < arr.length; i++){
			 var indicators = '';
			 var item = '';
			 if(i == 0){
				 indicators = '<li data-target="#carousel-example-generic" data-slide-to="' + i + '" class="active"></li>';
				 item = '<div class="item active">' +
			      '<img src="resources/images/gymimages/' + arr[i] + '" id="detailimg">' +
			      '<div class="carousel-caption">' +
			      '</div>' +
			    '</div>';
			 } else {
				 indicators = '<li data-target="#carousel-example-generic" data-slide-to="' + i + '"></li>';
				 item = '<div class="item">' +
			      '<img src="resources/images/gymimages/' + arr[i] + '" id="detailimg">' +
			      '<div class="carousel-caption">' +
			      '</div>' +
			    '</div>';
			 }
			 $("#indicator").append(indicators);
			 $("#inner").append(item);
		 }
	 }
 }
 
 function scrollmove(data){
	 if(data == 1){
		 $("#scrollView").animate({
			 scrollTop: 0
		 }, 1000);
		 return false;
	 } else if (data == 2){
		 $("#scrollView").animate({
			 scrollTop: sch
		 }, 1000);
		 return false;
	 } else if (data == 3){
		 $("#scrollView").animate({
			 scrollTop: loc
		 }, 1000);
		 return false;
	 } else {
		 $("#scrollView").animate({
			 scrollTop: com
		 }, 1000);
	 }
 }
 
 // -------------------------------------
 // 지도
 // -------------------------------------
 var map = new naver.maps.Map("map", {
		center : new naver.maps.LatLng(37.3595316, 127.1052133),
		zoom : 10,
		mapTypeControl : true
	});
	
	var infoWindow = new naver.maps.InfoWindow({
		anchorSkew : true
	});
	
	map.setCursor('pointer');
	
	// result by latlng coordinate
	function searchAddressToCoordinate(address) {
		naver.maps.Service
				.geocode(
						{
							address : address
						},
						function(status, response) {
							if (status === naver.maps.Service.Status.ERROR) {
								return alert('올바른 주소가 아닙니다.');
							}
	
							var marker;
	
							var item = response.result.items[0], addrType = item.isRoadAddress ? '도로명 주소 :'
									: '지번 주소 :', point = new naver.maps.Point(
									item.point.x, item.point.y);
	
							infoWindow
									.setContent([
											'<div style="padding:10px;min-width:200px;line-height:150%;">',
											'<h4 style="margin-top:5px;">' + gym_name + '</h4>' +
											'<h6><i class="fa fa-clone" aria-hidden="true"></i>&nbsp;' + category + '</h6>' +
											'<h6><span class="glyphicon glyphicon-earphone"></span>&nbsp;' + tel + '</h6>' +
											'<h6><span class="glyphicon glyphicon-phone"></span>&nbsp;' + phone + '</h6>' +
											'<h6><i class="fa fa-list-alt" aria-hidden="true"></i>&nbsp;' + desc + '</h6>' +
											
											'<br />',
											addrType + ' ' + item.address
													+ '<br /></div>' ]
											.join('\n'));
							map.setCenter(point);
							infoWindow.open(map, point);
						});
	}
	
	function initGeocoder() {
		map.addListener('click', function(e) {
			searchAddressToCoordinate($('#address').val());
		});
	}
	
	// geolocation 코드
	function onSuccessGeolocation(position) {
		var location = new naver.maps.LatLng(position.coords.latitude,
				position.coords.longitude);
	
		map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
		map.setZoom(10); // 지도의 줌 레벨을 변경합니다.
	
		infoWindow.setContent('<div style="padding:20px;">' + '<h5 style="align: center;"검색 결과 </h5>' + '<br />' + 'latitude: '
				+ location.lat() + '<br />' + 'longitude: ' + location.lng()
				+ '</div>');
	
		infoWindow.open(map, location);
	}
	
	function onErrorGeolocation() {
		var center = map.getCenter();
	
		infoWindow
				.setContent('<div style="padding:20px;">'
						+ '<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'
						+ "latitude: " + center.lat() + "<br />longitude: "
						+ center.lng() + '</div>');
	
		infoWindow.open(map, center);
	}
	
	$('#geolocation')
			.on(
					"click",
					function() {
						if (navigator.geolocation) {
							navigator.geolocation.getCurrentPosition(
									onSuccessGeolocation, onErrorGeolocation);
						} else {
							var center = map.getCenter();
	
							infoWindow
									.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5>'
											+ "latitude: "
											+ center.lat()
											+ "<br />longitude: "
											+ center.lng()
											+ '</div>');
							infoWindow.open(map, center);
						}
					});
	
	naver.maps.onJSContentLoaded = initGeocoder;
	
	function adminpage(){
		location.href="adminbusinessRequestlist.do";
	}
	
	function reviewinsert(gym_no){
		var content = $("textfd").val();
		var user_no = $("user-no").val();
		var queryString = { "gym_no": gym_no, "content": content, "user_no": user_no };
		$.ajax({
			url: "reviewinsert.do",
			data: queryString,
			type: "post",
			dataType: "json",
			success: function(data){
				/*reviewselect(gym_no);*/
				alert("리뷰등록");
			}
		});
	}
	
	function reviewselect(gym_no){
		var queryString = { "gym_no": gym_no };
		$.ajax({
			url: "selectreview.do",
			data: queryString,
			type: "post",
			dataType: "json",
			success: function(data){
				var values = '';
			}
		});
	}
	
	function reviewupdate(gc_no){
		
		
	}