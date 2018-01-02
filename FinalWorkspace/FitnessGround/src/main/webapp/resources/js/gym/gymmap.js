/**
 * 시설 지도
 */
var map = new naver.maps.Map("map",	{zoom : 10});

var infoWindow = new naver.maps.InfoWindow({
	anchorSkew : true
});

var markers = [];
var hmarkers = [];
var infoWindows = [];
var hinfoWindows = [];
var markerBuffer;//시설마커버퍼
var markerCurrent;//시설현재마커
var uMarkerBuffer;//사용자마커버퍼
var uMarkerCurrent;//사용자현재마커

var gymno = '';
var gym_name = '';
var category = '';
var tel = '';
var phone = '';
var desc = '';
var str_rating = '';

// search by tm128 coordinate
// 위도 경도 -> 주소로 변환
function searchCoordinateToAddress(latlng) {
	var tm128 = naver.maps.TransCoord.fromLatLngToTM128(latlng);

	infoWindow.close();

	naver.maps.Service.reverseGeocode({
		location : tm128,
		coordType : naver.maps.Service.CoordType.TM128
	}, function(status, response) {
		if (status === naver.maps.Service.Status.ERROR) {
			return alert('올바른 주소가 아닙니다.');
		}
		
		var items = response.result.items, htmlAddresses = [];

		for (var i = 0, ii = items.length, item, addrType; i < ii; i++) {
			item = items[i];
			addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]';

			htmlAddresses.push((i + 1) + '. ' + addrType + ' ' + item.address);
			htmlAddresses.push('&nbsp&nbsp&nbsp -> ' + item.point.x + ',' + item.point.y);
		}

		infoWindow.setContent([
				'<div style="padding:10px;min-width:200px;line-height:150%;">',
				'<h4 style="margin-top:5px;">검색 좌표 : '
						+ response.result.userquery + '</h4><br />',
				htmlAddresses.join('<br />'), '</div>' ].join('\n'));

		infoWindow.open(map, latlng);
		
		marker = new naver.maps.Marker({
			map: map,
			position: latlng,
			title: "나의 위치",
			zIndex: 150,
			icon:{
				url:"/fitnessground/resources/images/gym_marker.png"
			}
	});	
		
	});
}

// result by latlng coordinate 주소 -> 위도 경도로 변환
function searchAddressToCoordinate(address) {
	naver.maps.Service.geocode({
		address : address
	}, function(status, response) {
		if (status === naver.maps.Service.Status.ERROR) {
			return alert('올바른 주소가 아닙니다.');
		}

		var item = response.result.items[0], addrType = item.isRoadAddress ? '[도로명 주소]'
					: '[지번 주소]', point = new naver.maps.Point(item.point.x, item.point.y);

		infoWindow.setContent([
			'<div style="padding:10px;min-width:200px;line-height:150%;">',
			'<h4 style="margin-top:5px;">' + gym_name + '</h4>' +
			'<h6><i class="fa fa-clone" aria-hidden="true"></i>&nbsp;' + category + '</h6>' +
			'<h6><span class="glyphicon glyphicon-earphone"></span>&nbsp;' + tel + '</h6>' +
			'<h6><span class="glyphicon glyphicon-phone"></span>&nbsp;' + phone + '</h6>' +
			'<h6>' + str_rating + '</h6>' + 
			'<h6><i class="fa fa-list-alt" aria-hidden="true"></i>&nbsp;' + desc + '</h6>' +
			'<a href="detailgym.do?gym_no=' + gymno + '"><h6>자세히보기</h6></a>' +
			
			'<br />',
			addrType + ' ' + item.address
					+ '<br /></div>'  
				].join(""));
		
		map.setCenter(point);
		
		marker = new naver.maps.Marker({
			map: map,
			position: point,
			title: "나의 위치",
			zIndex: 150,
			icon:{
				url:"/fitnessground/resources/images/gym_marker.png",
				size : new naver.maps.Size(21, 32),
				origin : new naver.maps.Point(0, 0),
				anchor : new naver.maps.Point(10, 32)
			}
		});	
		
		infoWindow.open(map, marker); 
		});
}

function changeAddressTolatlng(latlng)
{
	var tm128 = naver.maps.TransCoord.fromLatLngToTM128(latlng);
	
	var addr="";
	infoWindow.close();
	
	naver.maps.Service.reverseGeocode({
		location : tm128,
		coordType : naver.maps.Service.CoordType.TM128
	}, function(status, response) {
		if (status === naver.maps.Service.Status.ERROR) {
			return alert('올바른 주소가 아닙니다.');
		}

		var items = response.result.items;

		addr = items[0].address;
		console.log("changeAddressTolatlng addr:");
		console.log(addr);		
		return items[0].address;
	});
}

function changeLatlngToAddress(address)
{
	naver.maps.Service.geocode({
		address : address
	}, function(status, response) {
		if (status === naver.maps.Service.Status.ERROR) {
			console.log("status");
			console.log(status);
			
			return alert('올바른 헬스장 주소가 아닙니다.');
		}

		var item = response.result.items[0], addrType = item.isRoadAddress ? '[도로명 주소]'
					: '[지번 주소]', point = new naver.maps.Point(item.point.x, item.point.y);

		/*infoWindow.setContent(['<div style="padding:10px;min-width:200px;line-height:150%;">',
				'<h4 style="margin-top:5px;">검색 주소 : '+ response.result.userquery
				+ '</h4><br />', addrType + ' ' + item.address + '<br />',
				'&nbsp&nbsp&nbsp -> ' + point.x + ',' + point.y, '</div>' ].join(""));*/
		
		//map.setCenter(point);
		
		console.log("changeLatlngToAddressEnd");
		
		console.log(point);
		console.log(item.address);
		return point;
		});
}

function initMap() {
	/*map.addListener('click', function(e) {
		searchCoordinateToAddress(e.coord);
	});*/
	map.setOptions({
		scaleControl : true,
		logoControl : false,
		mapDataControl : false,
		zoomControl : false,
		minZoom : 10,
		maxZoom : 12,
		zoom : 10,
		mapTypeControl : false
	});

	$('#address').on('keydown', function(e) {
		var keyCode = e.which;

		if (keyCode === 13) { // Enter Key
			searchAddressToCoordinate($('#address').val());
		}
	});

	$('#submit').on('click', function(e) {
		e.preventDefault();
		searchAddressToCoordinate($('#address').val());
	});
	
	naver.maps.Event.addListener(map, 'zoom_changed', function(){
		//줌에 변경이 있을경우실행됨
		setGymlist(map);
	});
	  
	naver.maps.Event.addListener(map, 'dragend', function(){
		//화면이동이 끝나면 실행됨 
		setGymlist(map);
	});
	
	$('#geolocation').on("click", function() {
		onLoadGeolocation();
	});
	console.log("initMap()");
}

// geolocation 성공 시 실행 함수
function onSuccessGeolocation(position) {
	var location = new naver.maps.LatLng(position.coords.latitude,
			position.coords.longitude);
	//var center = map.getCenter();
	var currentAddr = "";
	
	console.log("onSuccessGeolocationStart");
	
	marker = new naver.maps.Marker({
			map: map,
			position: location,
			title: "나의 위치",
			zIndex: 150,
			icon:{
				url:"/fitnessground/resources/images/current_marker.png",
				size : new naver.maps.Size(21, 32),
				origin : new naver.maps.Point(0, 0),
				anchor : new naver.maps.Point(10, 32)
			}
	});	
	
	console.log("changeaddresInSuccess");  
	
	var tm128 = naver.maps.TransCoord.fromLatLngToTM128(location);
	
	naver.maps.Service.reverseGeocode({
		location : tm128,
		coordType : naver.maps.Service.CoordType.TM128
	}, function(status, response) {
		if (status === naver.maps.Service.Status.ERROR) {
			return alert('올바른 주소가 아닙니다.');
		}

		var items = response.result.items;

		currentAddr = items[0].address;
	});
	
	currentAddr = changeAddressTolatlng(location);
	console.log("currentAddr");
	console.log(currentAddr);
	
	var contentString = ['<div style="padding:20px;"><h5 style="margin-bottom:5px;">현재 내 위치</h5>'].join("");
	
	var infoWindow = new naver.maps.InfoWindow({
		anchorskew: true,
		content:contentString
	});
	
	infoWindow.open(map, marker);
	console.log("onSuccessGeolocationEnd");
	map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
	map.setZoom(10); // 지도의 줌 레벨을 변경합니다.
	setGymlist(map);
}

function onErrorGeolocation() {
	var center = map.getCenter();

	infoWindow.setContent('<div style="padding:20px;">'
					+ '<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'
					+ "latitude: " + center.lat() + "<br />longitude: "
					+ center.lng() + '</div>');

	infoWindow.open(map, center);
}

function onLoadGeolocation(){
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(
				onSuccessGeolocation, onErrorGeolocation);
		console.log("onSuccessInonLoadGeo");
	} else {
		var center = map.getCenter();

		infoWindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5>'
										+ "latitude: "
										+ center.lat()
										+ "<br />longitude: "
										+ center.lng()
										+ '</div>');
		infoWindow.open(map, center);
		
	}
	console.log("onLoadgeolocation");
}

function setGymlist(map){
	console.log("setGymlist");
	for (var i = 0, ii = this.markers.length; i < ii; i++) {
		this.markers[i].setMap(null);
	}
	
	for(var i =0, ii = this.hmarkers.length; i < ii; i++)
	{
		this.hmarkers[i].setMap(null);
	}
	
	this.markers = [];
	this.hmarkers = [];
	
	this.hinfoWindows = [];
	this.infoWindows = [];
	console.log("beforeOnloadPublic");
	onLoadPublic(map);
	onLoadHealth(map);
}
  	
function onLoadPublic(map){
	var mapBounds = map.getBounds();
	var minLat = mapBounds.minY();
	var maxLat = mapBounds.maxY();
	var minLng = mapBounds.minX();
	var maxLng = mapBounds.maxX();
	
	var queryString = {
		"minLat": minLat,
		"maxLat": maxLat,
		"minLng": minLng,
		"maxLng": maxLng
	};
	
	$.ajax({
		url:"publicmap.do",
		data: queryString,
		type: "post",
		dataType: "json",
		success:function(data){
			var jsonStr = JSON.stringify(data);
			var json=JSON.parse(jsonStr);
			console.log(data.publiclist);
			var marker;
			var infoWindow;
			console.log("onLoadPublic");
			for(var i in json.publiclist)
			{
				
				marker = new naver.maps.Marker({
					map: map,
					position: new naver.maps.LatLng(json.publiclist[i].lat, json.publiclist[i].lng),
					title: json.publiclist[i].public_name,
					zIndex: 150,
					icon:{
						url: "/fitnessground/resources/images/public_marker.png",
						size : new naver.maps.Size(21, 32),
						origin : new naver.maps.Point(0, 0),
						anchor : new naver.maps.Point(10, 32)
					}				
				});	
				
			var contentString = ["<div style='padding:20px;'>"+
								"<h3><b>" + json.publiclist[i].public_name + "</b></h3>" +
								"<p>" + json.publiclist[i].location + "<br><br>"+
								json.publiclist[i].homepage + "</p>"+
								"</div>"].join("");
			
			infoWindow = new naver.maps.InfoWindow({
				anchorSkew: true,
				content: contentString
			});		
			
			markers.push(marker);
			infoWindows.push(infoWindow);	
			}
			
			for(var i = 0, ii=markers.length; i < ii; i++)
			{
				naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
			}
			// map.setCenter(location);
			
		},
		error: function(request, status, error){
			alert("code:" + request.status + "\n" + "message:" + request.responseText
					+ "\n" + "error:" + error);
		}
	});
}

// 헬스장 목록 뿌려주기
function onLoadHealth(map){
	$.ajax({
		url:"healthmap.do",
		type: "post",
		dataType: "json",
		success:function(data){
			var jsonStr = JSON.stringify(data);
			var json=JSON.parse(jsonStr);
			console.log("data.healthlist");
			//console.log(data.healthlist);
			
			var marker;
			var infoWindow;
			for(var i in json.healthlist)
			{
				marker = new naver.maps.Marker({
					map: map,
					position: changeLatlngToAddress(json.healthlist[i].location),
					title: json.healthlist[i].title,
					zIndex: 150,
					icon:{
						url: "/fitnessground/resources/images/gym_marker.png",
						size : new naver.maps.Size(21, 32),
						origin : new naver.maps.Point(0, 0),
						anchor : new naver.maps.Point(10, 32)
					}				
				});	
				console.log(json.healthlist[i].location);
			var contentString = ["<div style='padding:20px;'>"+
								"<h3><b>" + json.healthlist[i].title + "</b></h3>" +
								"<p>" + json.healthlist[i].location + "<br><br>"+
								json.healthlist[i].tel + "</p>"+
								"</div>"].join("");
			
			infoWindow = new naver.maps.InfoWindow({
				anchorSkew: true,
				content: contentString
			});		
			
			hmarkers.push(marker);
			hinfoWindows.push(infoWindow);	
			}
			
			for(var i = 0, ii=hmarkers.length; i < ii; i++)
			{
				naver.maps.Event.addListener(hmarkers[i], 'click', getClickHandler(i));
			}
			// map.setCenter(location);
			
		},
		error: function(request, status, error){
			alert("code:" + request.status + "\n" + "message:" + request.responseText
					+ "\n" + "error:" + error);
		}
	});
}

function getClickHandler(seq) { // 클릭 이벤트 핸들러 추가하는 함수
	return function(e) {
		var marker = markers[seq];
		var infoWindow = infoWindows[seq];

		if (infoWindow.getMap()) {
			infoWindow.close();
		} else {
			infoWindow.open(map, marker);
		}
	};
}

function getAddress(address)
{
	
	naver.maps.Service.geocode({
		address : address
	}, function(status, response) {
		if (status === naver.maps.Service.Status.ERROR) {
			return alert('올바른 주소가 아닙니다.');
		}

		var item = response.result.items[0], addrType = item.isRoadAddress ? '[도로명 주소]'
					: '[지번 주소]', point = new naver.maps.Point(item.point.x, item.point.y);

		infoWindow.setContent(['<div style="padding:10px;min-width:200px;line-height:150%;">',
				'<h4 style="margin-top:5px;">검색 주소 : '+ response.result.userquery
				+ '</h4><br />', addrType + ' ' + item.address + '<br />',
				'&nbsp&nbsp&nbsp -> ' + point.x + ',' + point.y, '</div>' ].join(""));
		
		map.setCenter(point);
		for(var i = 0, ii=markers.length; i < ii; i++)
		{
			naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
		}
		
		infoWindow.open(map, map.getCenter());
		});
}

function gymclick(gym_no, location){
	var queryString = {"gym_no": gym_no};
	$.ajax({
		url: 'onegym.do',
		data: queryString,
		type: 'post',
		dataType: 'json',
		async: false,
		success: function(data){
			searchAddressToCoordinate(location);
			gymno = data.gym.gym_no;
			gym_name = data.gym.gym_name;
			category = data.gym.category;
			tel = data.gym.tel;
			phone = data.gym.phone;
			result = data.gym.str_rating;
			var mod = result % 1;
			var t = 0;
			result = Math.floor(result);
			str_rating = '';
			for(var j = 0; j < result; j ++){
				str_rating += '<i class="fa fa-star" aria-hidden="true"></i>';
				t++;
			}
			if (mod > 0){
				str_rating += '<i class="fa fa-star-half-o" aria-hidden="true"></i>';
				t++;
			}
			for(var z = t; z < 5; z++){
				str_rating += '<i class="fa fa-star-o" aria-hidden="true"></i>';
			}
			str_rating += '&nbsp;' + data.gym.str_rating;
		}
	});
}


$(window).on("load", function() {
	initMap();
	onLoadGeolocation();
});