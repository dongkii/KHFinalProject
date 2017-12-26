$(document).ready(function(){
		var user_no = $("#userno").val();
		mygymlist(user_no);
	});

	function mygymlist(user_no){
		var queryString = { "user_no": user_no };
		$("#gymlist").empty();
		$.ajax({
			url: 'mygymlist.do',
			data: queryString,
			dataType: 'json',
			type: 'post',
			async: false,
			success: function(data){
				var values = '';
				values += '등록된 헬스장 (' + data.gymcount + ')';
				$("#regcount").html(values);
				var gymlist = '';
				for(var i=0; i < data.gymcount; i++ ){
					var approval = '';
					var image = data.list[i].rename_image.split(',');
					if( image[0] == "" ){
						image[0] = '로고.png';
					}
					if ( data.list[i].approval_state == 1 ){
						approval += "<label style='color: green'>&nbsp;(승인)</label>";
					} else {
						approval += "<label style='color: red'>&nbsp;(미승인)</label>";
					}
					gymlist += 
					'<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="gymInfo">' +
						'<div class="col-lg-3 col-md-3 col-sm-3 col-sm-offset-0  col-xs-6 col-xs-offset-3" style="padding:5px;">' +
							'<img src="resources/images/gymimages/' + image[0] + '" id="gymimg" class="img-thumbnail">' +
						'</div>' +
						'<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12" style="padding-left:10px; paading-right:5px;">' +
							'<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px; font-size: 8pt; font-weight: bold;"><label><a href="detailgym.do?gym_no=' + data.list[i].gym_no + '">' + data.list[i].gym_name + '</a></label>' + approval + '</div>' +
							'<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px; font-size: 8pt;">분류 : ' + data.list[i].category + '</div>' +
							'<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px; font-size: 8pt;">전화번호 : ' + data.list[i].tel + '</div>' +
							'<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px; font-size: 8pt;">H.P : ' + data.list[i].phone + '</div>' +
							'<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px; font-size: 8pt;">지역 : ' + data.list[i].location + '</div>' +
						'</div>' +
						'<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12" style="padding:0px;">' +
							'<div class="btn-group col-xs-12" role="group" aria-label="..." style="padding: 0px;">' +
							  '<button type="button" class="btn btn-default col-xs-4" style="padding: 2px; font-size: 8pt;" onclick="location.href=\'detailgym.do?gym_no=' + data.list[i].gym_no + '\'">보기</button>' +
							  '<button type="button" class="btn btn-default col-xs-4" style="padding: 2px; font-size: 8pt;" onclick="location.href=\'updategym.do?gym_no=' + data.list[i].gym_no + '\'">수정</button>' +
							  '<button type="button" class="btn btn-default col-xs-4" style="padding: 2px; font-size: 8pt;" onclick="deletegym(' + data.list[i].gym_no + ',' + user_no + ',\'' + data.list[i].gym_name + '\')">삭제</button>' +
							'</div>' +
						'</div>' +
					'</div>';
				}
				$("#gymlist").html(gymlist);
			}
		});
	}
	
	function gymsearch(user_no){
		var gym_name = $("#gymsearch").val();
		$("#gymlist").empty();
		if(gym_name == ""){
			mygymlist(user_no);
		} else {
			var queryString = { "user_no": user_no, "gym_name": gym_name };
			$.ajax({
				url: 'gymsearch.do',
				data: queryString,
				dataType: 'json',
				type: 'post',
				success: function(data){
					var values = '';
					values += '검색된 헬스장 (' + data.gymcount + ')';
					$("#regcount").html(values);
					var gymlist = '';
					for(var i=0; i < data.gymcount; i++ ){
						var image = data.list[i].rename_image.split(',');
						if( image[0] == "" ){
							image[0] = '로고.png';
						}
						gymlist += 
						'<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="gymInfo">' +
							'<div class="col-lg-3 col-md-3 col-sm-3 col-sm-offset-0  col-xs-6 col-xs-offset-3" style="padding: 5px;">' +
								'<img src="resources/images/gymimages/' + image[0] + '" id="gymimg" class="img-thumbnail">' +
							'</div>' +
							'<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12" style="padding-left: 5px; paading-right: 5px;">' +
								'<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px; font-size: 8pt; font-weight: bold;"><a href="javascript:detailgym(' + data.list[i].gym_no + ')">' + data.list[i].gym_name + '</a></div>' +
								'<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px; font-size: 8pt;">분류 : ' + data.list[i].category + '</div>' +
								'<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px; font-size: 8pt;">전화번호 : ' + data.list[i].tel + '</div>' +
								'<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px; font-size: 8pt;">H.P : ' + data.list[i].phone + '</div>' +
								'<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0px; font-size: 8pt;">지역 : ' + data.list[i].location + '</div>' +
							'</div>' +
							'<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12" style="padding: 0px;">' +
								'<div class="btn-group col-xs-12" role="group" aria-label="..." style="padding: 0px;">' +
								  '<button type="button" class="btn btn-default col-xs-4" style="padding: 2px; font-size: 8pt;" onclick="location.href=\'detailgym.do?gym_no=' + data.list[i].gym_no + '\'">보기</button>' +
								  '<button type="button" class="btn btn-default col-xs-4" style="padding: 2px; font-size: 8pt;" onclick="location.href=\'updategym.do?gym_no=' + data.list[i].gym_no + '\'">수정</button>' +
								  '<button type="button" class="btn btn-default col-xs-4" style="padding: 2px; font-size: 8pt;" onclick="deletegym(' + data.list[i].gym_no + ',' + user_no + ',\'' + data.list[i].gym_name + '\')">삭제</button>' +
								'</div>' +
							'</div>' +
						'</div>';
					}
					$("#gymlist").html(gymlist);
				}
			});
		}
	}
	
	function deletegym(gym_no, user_no, gym_name){
		var queryString = { "gym_no": gym_no };
		if(confirm("정말 " + gym_name + " 헬스장을 삭제하실껀가요?")){
			if(confirm("헬스장 삭제시 모든 데이터는 사라집니다.\n그래도 삭제하실껀가요?")){
				var random = Math.floor(Math.random() * 9000) + 1000;
				var inputval = prompt("다음 번호를 정확히 입력하세요.\n번호 : " + random, "번호를 입력하세요.");
				if(random == inputval){
					if(confirm(gym_name + " 헬스장이 삭제됩니다..")){
						$.ajax({
							url: 'deletegym.do',
							data: queryString,
							type: 'post',
							async: false,
							success: function(data){
								if(data.gym == 1){
									mygymlist(user_no);
									alert(gym_name + " 헬스장이 삭제되었습니다.");
								}
							},
							error: function(){
								alert("에러");
							}
						});
					}
				} else {
					alert("번호가 일치하지 않습니다. \n 헬스장 삭제 실패..!");
					return false;
				}
			} else {
				alert("헬스장 삭제를 취소하였습니다.");
				return false;
			}
		} else {
			alert("헬스장 삭제를 취소하였습니다.");
			return false;
		}
	}