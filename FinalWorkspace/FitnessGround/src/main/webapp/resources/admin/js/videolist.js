	/**
	 * videolist.jsp에 적용
	 */
	
	/*template layout때문에 수정 */
	$(document).ready(function(){
		
		var value2 = '<a href="javascript: deleteSelected()"><button class="btn btn-info" id="delete-btn"><i class="fa fa-trash-o" aria-hidden="true"></i></button></a>';
		$('.dataTables_length>label').prepend(value2); //삭제버튼 붙이기 
		
		$("#ch").removeClass("sorting_asc");//체크박스th에 필터표시 안뜨도록
		
		$("#selectall").click(function(){
		    $('input:checkbox').not(this).prop('checked', this.checked);
		});
		
	});		
	
	/*운동 선택 시 category 바뀌도록 */
	$(document).ready(function(){
		
		if($("#select-workout").data('options') === undefined){
			$("#select-workout").data('options', $('#select-ct option').clone());
		}
		var id = $("#select-workout").val();
		var options = $("#select-workout").data('options').filter('[value=' + id+ ']');
		$('#select-ct').html(options);
		
		$("#select-workout").change(function(){
			if($(this).data('options') === undefined){
				$(this).data('options', $('#select-ct option').clone());
			}
			var id = $(this).val();
			var options = $(this).data('options').filter('[value=' + id+ ']');
			$('#select-ct').html(options);
		});
	});
	
	/*운동종류별 목록 ajax로 select */
	function listing(category1){
		$('#active').removeAttr('id','active');
		$('.'+category1).attr('id', 'active');
		$('.all').removeAttr('id','active');
		var category = category1;
		console.log(category);
		var queryString = { "category1": category };
		$.ajax({
			url: 'adminwlist.do',
			data : queryString,
			type : "post",
			dataType: "json",
			async: false,
	       success : function(result){
	          console.log("전송성공:"+result.clist[0].v_no+result.clist[0].title);
	          var v_no;
	          var title;
	          var category1;
	          var category2;
	          var url;
	          var readcount;
	          var content; //나중에 update할때 필요하면쓰기 
	          var value;
	  
	 	for(var i=0;i<result.clist.length;i++){
		  (function(v_no, title, category1, category2, vid, readcount, content){
	          v_no = result.clist[i].v_no;
	          title = result.clist[i].title;
	          category1 = result.clist[i].category1;
	          category2 = result.clist[i].category2;
	          vid = result.clist[i].url;
	          readcount = result.clist[i].readcount;
	          content = result.clist[i].content;
	          value +="<tr><td><input type='checkbox' class='case' name='case' value='"+v_no+"'/></td><td>"+v_no+"</td>"+
					"<td>"+title+"</td>"+
					"<td>"+category1+"</td>"+
					"<td>"+category2+"</td>"+
				
					"<td>"+readcount+"</td>"+
					"<td><button type='submit' class='btn btn-primary btn-sm' onclick='editView("+v_no+")'>수정</button>"+
					"<button type='submit' class='btn btn-danger btn-sm' onclick='deleteOne("+v_no+")'>삭제</button></td></tr>";
	
				/* if(i==0){
					$('#rows').html(value);
				}else{
				  $('#rows').append(value);
	          	} */
			
			}(i));//IIFE codes exit
		  $('#rows').html(value);
	  		};//for문종료  
	
	  
	   },
	   error : function(request, status, errorData){
	      alert("error code : " + request.status + "\n"
	            + "message : " + request.responseText
	            + "\n" + "error : " + errorData);
	   }
	});//ajax code exit 
	} //listing() ends... 
	
	
	/* insert, update playlistId Check */
	function idCheck(){
		var id = $("#playlist_id").val();
		if(id==""||id.length<33){
			var value = '';
			value += "<div style='color: #FE424D; margin-left:25vw; font-size: 0.9rem;'> 올바른 playist id가 아닙니다 </div>";
		}else if(id.length>33){
			var value = "";
		}
		$("#check-msg").html(value);
	}
	
	/*YoutubeAPI호출, Ajax 관리자 INSERT*/
	function insert(){
		console.log("insert() works!");
		var category1 = $("#select-workout option:selected").text(); //선택된 운동종류 
		var category2 = $("#select-ct option:selected").text(); //선택된 카테고리
		var playlist = $("#playlist_id").val(); //입력된 playlistId
		var vTitle;
		var vDesc;
		var vId;
		var job = new Object();
		var jarr = [];
		
		APICall();
		
		function APICall() { 
			 $.get("https://www.googleapis.com/youtube/v3/playlistItems", {
				part : 'snippet',
				maxResults : 50,
				playlistId : playlist,
				key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
			}, function(data) {
				console.log("API is called");
				$.each(data.items, function(i, item) {
					vTitle = item.snippet.title.replace(/&/gi, "+");
					vDesc = item.snippet.description.replace(/&/gi, "+");
					vId = item.snippet.resourceId.videoId;
					//하나가 아니라서 json array에 담고 그걸 다시 json객체에 담아서 컨트롤러에 보내야.....
					var job = new Object();
					job.title = vTitle;
					/* job.content = vDesc; */
					job.url = vId;
					job.category1 = category1;
					job.category2 = category2;
					jarr.push(job);
	
				});
				console.log(JSON.stringify(jarr));
				ajaxFunction();
			});
			
	
		}; 
	
			//Controller로 넘기기 
			function ajaxFunction() {
				console.log("ajaxFunction실행");
				$.ajax({
					url : "yinsert.do",
					data : JSON.stringify(jarr),
					type : "post",
					async: false,
					contentType : "application/json; charset=utf-8",
					success : function(result) {
						console.log("전송성공:");
						$('#card-result').append('<div class="alert alert-success" role="alert">"'+vTitle+'" 외 '+(jarr.length-1)+'개의 영상이 추가되었습니다!</div>');
						listing(category1);
					},
					error : function(request, status, errorData) {
						alert("error code : " + request.status + "\n"
								+ "message : " + request.responseText + "\n"
								+ "error : " + errorData);
					}
				})
					
			}
	}//Insert() ends... 
	
	
	
	/* Edit 수정하기 화면 collapse */
	function editView(v_no){
		var id = "#tr-"+v_no;
		var value = "<tr id='collapse"+v_no+"' class='collapse in' data-toggle='collapse'><td colspan='5' id='edit-td'>"+
		"<label for='title'>Title</label>"+
		"<input type='text' class='form-control' id='v-title' placeholder='제목을 입력하세요'><br>"+
		"<label for='url/video-id'>url/video-id</label>"+
		"<input type='text' class='form-control' id='v-url' oninput='vIdCheck();'><br>"+
		"<div id='check-msg'></div>"+
		"<label for='운동'>운동</label><select name='select-w' id='select-w' class='form-control'>"+
		"<option value='2'>요가</option><option value='3'>필라테스</option><option value='4'>맨몸운동</option></select>"+
		"<label for='카테고리'>카테고리</label><select name='select-c' id='select-c' class='form-control'><option value='2'>빈야사</option>"+
		"<option value='2'>다이어트</option>"+
			"<option value='2'>체형교정</option>"+
			"<option value='2'>부위별</option>"+
			"<option value='2'>초보자</option>"+
			"<option value='3'>스트레칭</option>"+
			"<option value='3'>복근집중운동</option>"+
			"<option value='3'>전신운동</option>"+
			"<option value='3'>하체운동</option>"+
			"<option value='4'>맨몸푸시업</option>"+
			"<option value='4'>맨몸하체</option>"+
			"<option value='4'>맨몸철봉</option>"+
			"<option value='4'>맨몸전신</option>"+
			"<option value='4'>맨몸초보자</option></select><br>"+
			"<label for='content'>내용</label>"+
			"<textarea class='form-control' id='v-content' rows='5'></textarea><br>"+
			"<a class='btn btn-primary' id='edit-btn' href='javascript: update("+v_no+")' role='button'>수정</a>"+"</td></tr>";
		
		$('#collapse'+v_no).toggle(inserttr(), removetr());	
		function inserttr(){
			$(value).insertAfter(id);
		}
		function removetr(){
			$('#collapse'+v_no).removeClass("show");
		}
		
		//category1 선택하면 자동으로 category2 바뀜
			if($("#select-w").data('options') === undefined){
				$("#select-w").data('options', $('#select-c option').clone());
			}
			var id = $("#select-w").val();
			var options = $("#select-w").data('options').filter('[value=' + id+ ']');
			$('#select-c').html(options);
			
			$("#select-w").change(function(){
				if($(this).data('options') === undefined){
					$(this).data('options', $('#select-c option').clone());
				}
				var id = $(this).val();
				var options = $(this).data('options').filter('[value=' + id+ ']');
				$('#select-c').html(options);
			});
			
			
		//ajax로 원래 값 표시 
		var queryString = {"v_no": v_no};
		$.ajax({
			url : "editview.do",
			data: queryString,
			dataType: "json",
			type: "post",
			success: function(result){
				console.log("edit view 전송 성공");
				var title = result.yoga.title;
				var url = result.yoga.url;
				var category1 = result.yoga.category1;
				var category2 = result.yoga.category2;
				var content = result.yoga.content;
				$('#v-title').val(title);
				$('#v-url').val(url);
				$('#v-content').val(content);
				$("#select-w > option[value"+category1+"]").prop("selected", true);
				$("#select-c > option[value"+category2+"]").prop("selected", true);
				
			},
			error: function(request, status, errorData) {
				alert("error code : " + request.status + "\n"
						+ "message : " + request.responseText + "\n"
						+ "error : " + errorData);
			}
		})//ajax ends..
			
	}// edit(v_no) ends...
	
	/* 수정하기 videoId check */
	   function vIdCheck(){
	      var vid = $('#v-url').val();
	   
	      if(vid==""||vid.length<10){
	         $("#v-url").css({'border':'1px solid #FE424D'});
	      }else if(vid.length>10){
	         var value = "";
	         $("#v-url").css({'border':'1px solid #ced4da'});
	      }
	      $("#check-msg").html(value);
	   }
	
	/* Update 수정처리 */
	function update(v_no){
		console.log("update() is running..");
		var title = $('#v-title').val();
		var url = $('#v-url').val();
		var content = $('#v-content').val();
		var category1 = $('#select-w option:selected').text();
		var category2 = $('#select-c option:selected').text();
		
		var data = { 
					"v_no" : v_no,
					"title" : title, 
					"url" : url, 
					"content" : content, 
					"category1" : category1, 
					"category2": category2
				};
		$.ajax({
			url : "yupdate.do",
			data : data,
			dataType: "json",
			type: "post",
			success: function(result){
				alert("수정되었습니다.");
				var category1 = result.list[0].category1;
				listing(category1);
			},
			error: function(request, status, errorData) {
				alert("error code : " + request.status + "\n"
						+ "message : " + request.responseText + "\n"
						+ "error : " + errorData);
					}
		})//ajax ends..
	}//update(v_no) ends...
	
	
	/* Delete (하나씩) */
	function deleteOne(v_no){
		console.log("deleteOne() works with v_no:"+ v_no);
		if (confirm("정말 삭제하시겠습니까??") == false){
			return;
		}else{
			var queryString = {"v_no": v_no };
			$.ajax({
				url : "deleteone.do",
				data : queryString,
				dataType: "json",
				type : "post",
				success : function(result) {
					console.log("전송성공:");
					alert("삭제되었습니다!");
					setTimeout(function(){
						window.location.reload();
					}, 1500);
				},
				error : function(request, status, errorData) {
					alert("error code : " + request.status + "\n"
							+ "message : " + request.responseText + "\n"
							+ "error : " + errorData);
				}
			}) //ajax ends..
		}			
	}//deleteOne(v_no) ends...
	
	/*Delete 여러개 한꺼번에(체크박스선택된것) */
	function deleteSelected(){
		var checkedlist = [];
		$('input[type="checkbox"]:checked').each(function() {
		    checkedlist.push($(this).attr('value'));
		});
		console.log(checkedlist+"selected");
		if (confirm(checkedlist.toString()+"번 영상을 정말 삭제하시겠습니까??") == false){
			return;
		}else{
			$.ajax({
				url : "deletemany.do",
				data : JSON.stringify(checkedlist),
				type : "post",
				contentType : "application/json; charset=utf-8",
				success : function(result) {
					console.log("전송성공:");
					alert("선택한 동영상이 삭제되었습니다.");
					setTimeout(function(){
						window.location.reload();
					}, 700);
				},
				error : function(request, status, errorData) {
					alert("error code : " + request.status + "\n"
							+ "message : " + request.responseText + "\n"
							+ "error : " + errorData);
				}
			}) //ajax ends..
		}
		
	}//deleteSelected() ends...