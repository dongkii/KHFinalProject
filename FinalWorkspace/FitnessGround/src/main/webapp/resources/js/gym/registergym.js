var checkimage = 0;
var checkinfo = 0;
var checkschedule = 1;
var checkloc = 0;
var resultaddr = '';
var arr = new Array();

		$("#panelOne").css({'boader-color':'#F60808', 'box-shadow':'0 0 1px 1px rgb(232, 13, 13)'});
		$("#headingOne").css("color","red");
		$("#panelTwo").css({'boader-color':'#F60808', 'box-shadow':'0 0 1px 1px rgb(232, 13, 13)'});
		$("#headingTwo").css("color","red");
		$("#panelThree").css({'boader-color':'#B0F6AC', 'box-shadow':'0 0 1px 1px rgb(117, 254, 109)'});
		$("#headingThree").css("color","green");
		$("#panelFour").css({'boader-color':'#F60808', 'box-shadow':'0 0 1px 1px rgb(232, 13, 13)'});
		$("#headingFour").css("color","red");
		
		
		
		// 이미지 미리보기
		var sel_files = [];
		$(document).ready(function(){
			$("#input_imgs").on("change", handleImgFileSelect);
			$("#input_imgs").hide();
			
			$('#myCarousel').carousel({
                interval: 5000
	        });
	 
	        $('#carousel-text').html($('#slide-content-0').html());
		});
		
		function fileUploadAction(){
			$("#input_imgs").trigger("click");
		}
		
		function imageclick(index){
			for(var i = 0; i < 12; i++){
				$("#bigimage" + i + "").hide();
				$("#smallimg" + i + "").css({"border-color":"#33333300"});
			}
			$("#bigimage" + index + "").show();
			$("#smallimg" + index + "").css({"border":"3px solid #8deb7a", "border-radius":"8px"});
		}
		
		function gymimageborder(){
			var check = "<span class='glyphicon glyphicon-ok' aria-hidden='true'></span>&nbsp;&nbsp;헬스장 사진";
			$("#panel1").html(check);
			$("#panelOne").css({'boader-color':'#B0F6AC', 'box-shadow':'0 0 1px 1px rgb(117, 254, 109)'});
			$("#headingOne").css("color","green");
			checkimage = 1;
			registergymcheck()
		}
		
		// ***********************
		// 이미지 드래그 앤 드롭
		// ***********************
		var fd = document.getElementById('mainimage');
		var list = document.getElementById('list');
		function fdOver(e)
		{
			e.stopPropagation();
			e.preventDefault();
			if (e.type == "dragover")
			{
				// 파일 올림
				$("#mainimage").css({"border":"2px solid #0600ff"});
			}
			else
			{
				// 파일 놓음 [원상복구]
				$("#mainimage").css({"border":"2px dashed #3333338a"});
			}
		}
		
		function handleFileUpload(files){
			filelength = files.length;
			for (var i = 0; i < files.length; i++){
				arr[i] = files[i];
			}
		}
		
		function fdUpload(e){
			e.stopPropagation();
			e.preventDefault();
			fdOver(e);
			
			sel_files = [];
			$("#li1").empty();
			$("#mainimage").empty();
			$(".carousel-indicators").empty();
			$("#div2").remove();
			$("#div3").remove();
			$("#div4").remove();
			
			// 캐러셀 좌우버튼
			var prevnext = 	"<a data-slide='prev' href='#Carousel' class='left carousel-control' id='prev'>‹</a>" +
           					"<a data-slide='next' href='#Carousel' class='right carousel-control' id='next'>›</a>";
		 
			var files = e.target.files || e.dataTransfer.files;
			var filesArr = Array.prototype.slice.call(files);
			
			handleFileUpload(files);
	
			var index = 0;
			filesArr.forEach(function(f){
				if(!f.type.match("image.*")){
					var bigimagerr = "<div class='bigimage' id='bigimage' style='width: 360px; height: 360px;'>" +
									"<img src='/fitnessground/resources/images/gymimages/draganddrop.png' style='width: 300px; height: 108px; border-radius: 10px; margin-top: 126; margin-left: 30px;'>" +					
									"</div>";
					$("#mainimage").append(bigimagerr);
					alert("확장자는 이미지 확장자만 가능합니다.");
					return;
				}
				sel_files.push(f);
				
				var reader = new FileReader();
				reader.onload = function imagelist(e){
					var imgli = "<div class='col-lg-2 col-md-2 col-sm-2 col-xs-4'>" +
									"<a href='javascript:imageclick(" + index+ ")' class='thumbnail' id='smallimg" + index + "'>" +
										"<img src='" + e.target.result + "' alt='Image' id='imagelist' style='border-radius: 5px;'>" +
									"</a>" +
								"</div>";
					var mainimage = "<div class='bigimage' id='bigimage" + index + "' style='width: 360px; height: 360px;'>" +
										"<img src='" + e.target.result + "' style='width: 360px; height: 360px; border-radius: 10px;'>" +
									"</div>";
					$("#mainimage").append(mainimage);
					if( index == 0 ){
						$("#bigimage" + index + "").show();
					} else {
						$("#bigimage" + index + "").hide();
					}
					
					var windowWidth = $( window ).width();
					if( windowWidth < 700){ // 모바일
						if(index < 3){
							if( index == 0){
								var indicator = "<li data-target='#Carousel' data-slide-to='0' class='active'></li>";
								$(".carousel-indicators").append(indicator);
							}
							$("#li1").append(imgli);
						} else if ( index < 6){
							if( index == 3){
								var indicator = "<li data-target='#Carousel' data-slide-to='1'></li>";
								$(".carousel-indicators").append(indicator);
								var item = "<div class='item' id='div2'>" +
											"<div id='li2'></div>" +
											"</div>";
								$(".carousel-inner").append(item);
							}
							$("#li2").append(imgli);
						} else if ( index < 9){
							if(index == 6){
								var indicator = "<li data-target='#Carousel' data-slide-to='2'></li>";
								$(".carousel-indicators").append(indicator);
								var item = "<div class='item' id='div3'>" +
											"<div id='li3'></div>" +
											"</div>";
								$(".carousel-inner").append(item);
							}
							$("#li3").append(imgli);
						} else if ( index < 12){
							if( index == 9){
								var indicator = "<li data-target='#Carousel' data-slide-to='3'></li>";
								$(".carousel-indicators").append(indicator);
								var item = "<div class='item' id='div4'>" +
											"<div id='li4'></div>" +
											"</div>";
								$(".carousel-inner").append(item);
							}
							$("#li4").append(imgli);
						} else {
							alert("이미지는 최대 12장까지 업로드 할 수 있습니다.");
							$('#Carousel').append(prevnext);
							return;
						}
					} else { // 태블릿이상 ~ 데스크탑
						if(index < 6){
							if( index == 0){
								var indicator = "<li data-target='#Carousel' data-slide-to='0' class='active'></li>";
								$(".carousel-indicators").append(indicator);
							}
							// 목록 붙임
							$("#li1").append(imgli);
						} else if (index < 12 && index > 5){
							if( index == 6){
								var indicator = "<li data-target='#Carousel' data-slide-to='2'></li>";
								$(".carousel-indicators").append(indicator);
								var item = "<div class='item' id='div2'>" +
											"<div id='li2'></div>" +
											"</div>";
								$(".carousel-inner").append(item);
							}
							// 목록 붙임
							$("#li2").append(imgli);
						} else {
							alert("이미지는 최대 12장까지 업로드 할 수 있습니다.");
							$('#Carousel').append(prevnext);
							return;
						}
					}
					$("#smallimg0").css({"border":"3px solid #8deb7a", "border-radius":"8px"});
					index++;
				}
				reader.readAsDataURL(f);
				gymimageborder();
			});
			// 이미지가 다 삽입되고나면 캐러셀 좌우 버튼 생성
			$("#Carousel").append(prevnext);
		}
		fd.addEventListener("dragover", fdOver, false);
		fd.addEventListener("dragleave", fdOver, false);
		fd.addEventListener("drop", fdUpload, false);
		
		function handleImgFileSelect(e) {
			//이미지 정보들을 초기화
			sel_files = [];
			$("#li1").empty();
			
			$(".carousel-indicators").empty();
			$("#div2").remove();
			$("#div3").remove();
			$("#div4").remove();
			
			// 캐러셀 좌우버튼
			var prevnext = 	"<a data-slide='prev' href='#Carousel' class='left carousel-control' id='prev'>‹</a>" +
           					"<a data-slide='next' href='#Carousel' class='right carousel-control' id='next'>›</a>";
			
			var files = e.originalEvent.target.files;
			var filesArr = Array.prototype.slice.call(files);
			
			handleFileUpload(files);
			
			var index = 0;
			filesArr.forEach(function(f){
				if(!f.type.match("image.*")){
					alert("확장자는 이미지 확장자만 가능합니다.");
					return;
				}
				$("#mainimage").empty();
				sel_files.push(f);
				
				var reader = new FileReader();
				reader.onload = function imagelist(e){
					var imgli = "<div class='col-lg-2 col-md-2 col-sm-2 col-xs-4'>" +
									"<a href='javascript:imageclick(" + index+ ")' class='thumbnail' id='smallimg" + index + "'>" +
										"<img src='" + e.target.result + "' alt='Image' id='imagelist' style='border-radius: 5px;'>" +
									"</a>" +
								"</div>";
					var mainimage = "<div class='bigimage' id='bigimage" + index + "' style='width: 360px; height: 360px;'>" +
										"<img src='" + e.target.result + "' style='width: 360px; height: 360px; border-radius: 10px;'>" +
									"</div>";
					$("#mainimage").append(mainimage);
					if( index == 0 ){
						$("#bigimage" + index + "").show();
					} else {
						$("#bigimage" + index + "").hide();
					}
					
					var windowWidth = $( window ).width();
					if( windowWidth < 700){ // 모바일
						if(index < 3){
							if( index == 0){
								var indicator = "<li data-target='#Carousel' data-slide-to='0' class='active'></li>";
								$(".carousel-indicators").append(indicator);
							}
							$("#li1").append(imgli);
						} else if ( index < 6){
							if( index == 3){
								var indicator = "<li data-target='#Carousel' data-slide-to='1'></li>";
								$(".carousel-indicators").append(indicator);
								var item = "<div class='item' id='div2'>" +
											"<div id='li2'></div>" +
											"</div>";
								$(".carousel-inner").append(item);
							}
							$("#li2").append(imgli);
						} else if ( index < 9){
							if(index == 6){
								var indicator = "<li data-target='#Carousel' data-slide-to='2'></li>";
								$(".carousel-indicators").append(indicator);
								var item = "<div class='item' id='div3'>" +
											"<div id='li3'></div>" +
											"</div>";
								$(".carousel-inner").append(item);
							}
							$("#li3").append(imgli);
						} else if ( index < 12){
							if( index == 9){
								var indicator = "<li data-target='#Carousel' data-slide-to='3'></li>";
								$(".carousel-indicators").append(indicator);
								var item = "<div class='item' id='div4'>" +
											"<div id='li4'></div>" +
											"</div>";
								$(".carousel-inner").append(item);
							}
							$("#li4").append(imgli);
						} else {
							alert("이미지는 최대 12장까지 업로드 할 수 있습니다.");
							$('#Carousel').append(prevnext);
							return;
						}
					} else { // 태블릿이상 ~ 데스크탑
						if(index < 6){
							if( index == 0){
								var indicator = "<li data-target='#Carousel' data-slide-to='0' class='active'></li>";
								$(".carousel-indicators").append(indicator);
							}
							// 목록 붙임
							$("#li1").append(imgli);
						} else if (index < 12 && index > 5){
							if( index == 6){
								var indicator = "<li data-target='#Carousel' data-slide-to='2'></li>";
								$(".carousel-indicators").append(indicator);
								var item = "<div class='item' id='div2'>" +
											"<div id='li2'></div>" +
											"</div>";
								$(".carousel-inner").append(item);
							}
							// 목록 붙임
							$("#li2").append(imgli);
						} else {
							alert("이미지는 최대 12장까지 업로드 할 수 있습니다.");
							$('#Carousel').append(prevnext);
							return;
						}
					}

					$("#smallimg0").css({"border":"3px solid #8deb7a", "border-radius":"8px"});
					index++;
				}
				reader.readAsDataURL(f);
				gymimageborder();
			});
			
			// 이미지가 다 삽입되고나면 캐러셀 좌우 버튼 생성
			$("#Carousel").append(prevnext);
		}
		
		/**
		 * Checkboxy, a simple jQuery checkbox plug-in
		 * Version 1.0.0
		 * Copyright 2013, Dmitry Stillman (https://github.com/stillman)
		 * Licensed under GPL v3
		 */
		(function($) {

		$.fn.checkboxy = function(options) {
			function deinit() {
				// Remove event handlers
				$('input.' + options.class + '[data-checkboxy-el-id]').off('change.checkboxy');
			}

			function init() {
				// Remove old event handlers (if any)
				deinit();

				$(options.tagname + '.' + options.class).on('click', function(evt) {
					if ($(this).closest('label').length) {
						// There is a <label> around the element
						return true;
					}

					$input = $('input.' + options.class + '[data-checkboxy-el-id="' + $(this).data('checkboxy-el-id') + '"]');

					if (!$input.prop('disabled')) {
						$input.trigger('change');
					}
				});

				// Add event handlers
				$('input.' + options.class + '[data-checkboxy-el-id]').on('change.checkboxy', function() {
					$(options.tagname + '.' + options.class + '[data-checkboxy-el-id="' + $(this).data('checkboxy-el-id') + '"]').toggleClass('checked');
				});
			}

			options = $.extend({}, {
				tagname: 'span',
				class: 'checkboxy'
			}, options);

			$(options.tagname + '.' + options.class).remove();

			this.each(function(id) {
				var $input = $(this);
				var $checkboxy = $('<' + options.tagname + '/>').addClass(options.class);

				$input
					.attr('data-checkboxy-el-id', id)
					.addClass(options.class)
					.hide();

				if ($input.prop('checked')) {
					$checkboxy.addClass('checked');
				}

				if ($input.prop('disabled')) {
					$checkboxy.addClass('disabled');
				}

				$checkboxy
					.attr('data-checkboxy-el-id', id)
					.insertBefore(this);
			});

			init();

			return this;
		};

		})(jQuery);
		
		var checkgymname = 0;
		var checkoptime = 0;
		var checktel = 0;
		var checkphone = 0;
		var checkprice = 0;
		var checkbox0 = 0;
		var checkbox1 = 0;
		var checkbox2 = 0;
		var checkbox3 = 0;
		var checkdesc = 0;		
		
		function gymemptycheck(){
			telcheck();
			phonecheck();
			
			if( $("#gymname").val() != "" ){
				checkgymname = 1;
			} else {
				checkgymname = 0;
			}
			if( $("#optime").val() != "" ){
				checkoptime = 1;
			} else {
				checkoptime = 0;
			}
			if( $("#tel").val() != "" ){
				checktel = 1;
			} else {
				checktel = 0;
			}
			if( $("#phone").val() != "" ){
				checkphone = 1;
			} else {
				checkphone = 0;
			}
			if( $("#price").val() != "" ){
				checkprice = 1;
			} else {
				checkprice = 0;
			}
			if($("#gymdesc").val() != ""){
				checkdesc = 1;
			} else {
				checkdesc = 0;
			}
			borderchange();
		}
		
		function boxcheck(id){
			if(id == 0){
				if( checkbox0 == 0)
					checkbox0 = 1;
				else
					checkbox0 = 0;
			} else if(id == 1){
				if( checkbox1 == 0)
					checkbox1 = 1;
				else
					checkbox1 = 0;
			} else if(id == 2){
				if( checkbox2 == 0)
					checkbox2 = 1;
				else
					checkbox2 = 0;
			} else if(id == 3){
				if( checkbox3 == 0)
					checkbox3 = 1;
				else
					checkbox3 = 0;
			}
			borderchange();
		}
		
		function borderchange(){
			var sum = checkgymname + checkoptime + checktel + checkphone + checkprice + checkdesc;
			var checkbox = checkbox0 + checkbox1 + checkbox2 + checkbox3;	
			if( sum == 6 && checkbox > 0 ){
				var check = "<span class='glyphicon glyphicon-ok' aria-hidden='true'></span>&nbsp;&nbsp;헬스장 정보";
				$("#panel2").html(check);
				$("#panelTwo").css({'boader-color':'#B0F6AC', 'box-shadow':'0 0 1px 1px rgb(117, 254, 109)'});
				$("#headingTwo").css("color","green");
				checkinfo = 1;
				registergymcheck();
			} else{
				var check = "<span class='glyphicon glyphicon-remove' aria-hidden='true'></span>&nbsp;&nbsp;헬스장 정보";
				$("#panel2").html(check);
				$("#panelTwo").css({'boader-color':'#F60808', 'box-shadow':'0 0 1px 1px rgb(232, 13, 13)'});
				$("#headingTwo").css("color","red");
				checkinfo = 0;
				registergymcheck();
			}
		}
		
		function telcheck(){
			var tel = $("#tel").val();
			if(tel.length == 2){
				tel += "-";
				$("#tel").val(tel);
			}else if(tel.length == 6){
				tel += "-";
				$("#tel").val(tel);
			} else if (tel.length == 11 ){
				tel = tel.replace(/\-/g, '');
				tel = tel.substr(0,2) + "-" + tel.substr(2,3) + "-" + tel.substr(5, 4);
				$("#tel").val(tel);
			} else if (tel.length == 12){
				tel = tel.replace(/\-/g, '');
				tel = tel.substr(0,3) + "-" + tel.substr(3,3) + "-" + tel.substr(6, 4);
				$("#tel").val(tel);
			} else if (tel.length == 13){
				tel = tel.replace(/\-/g, '');
				tel = tel.substr(0,3) + "-" + tel.substr(3,4) + "-" + tel.substr(7, 4);
				$("#tel").val(tel);
			}
		}
		
		function phonecheck(){
			var phone = $("#phone").val();
			if(phone.length == 3){
				phone += "-";
				$("#phone").val(phone);
			}else if(phone.length == 8){
				phone += "-";
				$("#phone").val(phone);
			} else if (phone.length == 12){
				phone = phone.replace(/\-/g, '');
				phone = phone.substr(0,3) + "-" + phone.substr(3,3) + "-" + phone.substr(6, 4);
				$("#phone").val(phone);
			} else if (phone.length == 13){
				phone = phone.replace(/\-/g, '');
				phone = phone.substr(0,3) + "-" + phone.substr(3,4) + "-" + phone.substr(7, 4);
				$("#phone").val(phone);
			}
		}
		
		
		
		// *********************************************
		// 지도
		// *********************************************	
		var map = new naver.maps.Map("map", {
			center : new naver.maps.LatLng(37.3595316, 127.1052133),
			zoom : 10,
			mapTypeControl : true
		});
		
		var infoWindow = new naver.maps.InfoWindow({
			anchorSkew : true
		});
		
		map.setCursor('pointer');
		
		// search by tm128 coordinate
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
					htmlAddresses.push('&nbsp&nbsp&nbsp -> ' + item.point.x + ','
							+ item.point.y);
				}
		
				infoWindow.setContent([
						'<div style="padding:10px;min-width:200px;line-height:150%;">',
						'<h4 style="margin-top:5px;">검색 좌표 : '
								+ response.result.userquery + '</h4><br />',
						htmlAddresses.join('<br />'), '</div>' ].join('\n'));
		
				infoWindow.open(map, latlng);
			});
		}
		
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
		
								var item = response.result.items[0], addrType = item.isRoadAddress ? '[도로명 주소]'
										: '[지번 주소]', point = new naver.maps.Point(
										item.point.x, item.point.y);
		
								infoWindow
										.setContent([
												'<div style="padding:10px;min-width:200px;line-height:150%;">',
												'<h4 style="margin-top:5px;">검색 주소 : '
														+ response.result.userquery
														+ '</h4><br />',
												addrType + ' ' + item.address
														+ '<br /></div>' ]
												.join('\n'));
								var check = "<span class='glyphicon glyphicon-ok' aria-hidden='true'></span>&nbsp;&nbsp;헬스장 위치";
								$("#panel4").html(check);
								$("#panelFour").css({'boader-color':'#B0F6AC', 'box-shadow':'0 0 1px 1px rgb(117, 254, 109)'});
								$("#headingFour").css("color","green");
								resultaddr = item.address;
								checkloc = 1;
								registergymcheck();
								map.setCenter(point);
								infoWindow.open(map, point);
							});
		}
		
		function initGeocoder() {
			map.addListener('click', function(e) {
				searchCoordinateToAddress(e.coord);
			});
		
			$('#address').on('keydown', function(e) {
				var keyCode = e.which;
		
				if (keyCode === 13) { // Enter Key
					searchAddressToCoordinate($('#address').val());
				}
			});
		
			$('#addressbtn').on('click', function(e) {
				e.preventDefault();
		
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
		
		
		function registergymcheck(){
			var sum = checkimage + checkinfo + checkschedule + checkloc;
			if(sum == 4){
				$("#gymregisterbtn").prop("disabled", false);
			} else {
				$("#gymregisterbtn").prop("disabled", true);
			}
		}

		// 이미지 파일로 헬스장 생성
		function registergym(user_no){
			//이미지 다중파일 가져와야함
			var formd = new FormData();
			for(var i=0; i < arr.length; i++){
				if(i == (arr.length - 1)){
					formd.append(i, arr[i]);
				} else {
					formd.append(i, arr[i]);
				}
			}
			 $.ajax({
		            type : 'post',
		            url : 'imagereg.do',
		            data : formd,
		            processData : false,
		            contentType : false,
		            cachae: false,
		            async: false,
		            success: function(data){
		            	contentInsert(user_no, data.gym.gym_no);
		            },
		            error: function(data){
		            	alert("실패");
		            }
			 });			
		}
		
		// 헬스장 데이터 삽입
		function contentInsert(user_no, gym_no){
			var user_no = user_no;
			var gym_no = gym_no;
			//헬스장 정보
			var gym_name = $("#gymname").val();
			var op_time = $("#optime").val();
			var tel = $("#tel").val();
			var phone = $("#phone").val();
			var price = $("#price").val();
			var category = '';
			if($("#ex_chk0").is(":checked")){
				category += '헬스, ';
			}
			if($("#ex_chk1").is(":checked")){
				category += '요가, ';
			}
			if($("#ex_chk2").is(":checked")){
				category += '필라테스, ';
			}
			if($("#ex_chk3").is(":checked")){
				category += '맨몸운동';
			}
			var description = $("#gymdesc").val();
			//헬스장 달력정보
			//추가해야함,,
			
			//헬스장 주소
			var queryString = { "gym_name": gym_name,
								"op_time": op_time, 
								"tel": tel, 
								"phone": phone, 
								"price": price, 
								"category": category, 
								"description": description, 
								"location": resultaddr, 
								"user_no": user_no,
								"gym_no": gym_no };
			
			$.ajax({
				url: 'contentreg.do',
				type: 'post',
				async: false,
				data: queryString,
				success: function(data){
					schedulereg(user_no, gym_no);
				}
			});
			
		}
		
		// 스케줄 등록
		function schedulereg(user_no, gym_no){
			var m_oMonth = new Date();
			m_oMonth.setDate(1);
			
			for(var i=1; i < 31; i++ ){
				if(document.getElementById("" + m_oMonth.getFullYear() + (m_oMonth.getMonth()+1)  + i + "day")){
					var day = $("#" + m_oMonth.getFullYear() + (m_oMonth.getMonth()+1)  + i + "day").val();
					var time = $("#" + m_oMonth.getFullYear() + (m_oMonth.getMonth()+1)  + i + "time").val();
					var title = $("#" + m_oMonth.getFullYear() + (m_oMonth.getMonth()+1)  + i + "title").val();
					var queryString = { "gym_no": gym_no, "day": day, "schedule_time": time, "title": title };
					$.ajax({
						url: 'OneSchedule.do',
						data: queryString,
						async: false,
						type: 'post'
					});
				}
			}
			alert("헬스장이 등록되었습니다. \n관리자의 승인 후에 '운동시설찾기'에 \n보여지게 됩니다.");
			location.href='mypage.do?userno='+ user_no +'';
		}