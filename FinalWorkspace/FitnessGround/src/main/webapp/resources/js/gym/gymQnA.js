var gfv_count = 1;

function fn_addFile(){
	if(gfv_count<1) {gfv_count=1;}
	if(gfv_count<3) {
		var str = "<tr><th></th><td><input type='file' class='form-control' id='file' name='file_"+(gfv_count++)+"' style='width:100%'></td>"
				+ "<td align='right'><a class='btn btn-danger' href='#this' style='text-decoration:none;' id='delete' name='delete'>삭제</a></td></tr>";
		$("#fileDiv").append(str);
		$("a[name='delete']").on("click", function(e){ //삭제 버튼
			e.preventDefault();
			fn_deleteFile($(this));
		});
	}
	return false;
}
function fn_addFileSm(){
	var str = "<tr><td><input type='file' class='form-control' id='file' name='file_"+(gfv_count++)+"' style='width:100%'></td>"
			+ "<td align='right'><a class='btn btn-danger' href='#this' style='text-decoration:none;' id='delete' name='delete'>삭제</a></td></tr>";
	$("#fileDivSm").append(str);
	$("a[name='delete']").on("click", function(e){ //삭제 버튼
		e.preventDefault();
		fn_deleteFile($(this));
	});
	}
function fn_deleteFile(obj){
	gfv_count--;
	obj.parent().parent().remove();
	return false;
}
function ckWordLen(obj, maxByte) {
	$('#textCount').css('color','black');
	var strValue = obj.value;
    var strLen = strValue.length;
    var totalByte = 0;
    var len = 0;
    var oneChar = "";
    var str2 = "";
    for (var i = 0; i<strLen; i++) {
        oneChar = strValue.charAt(i);
        if (escape(oneChar).length > 4) { // 한글일 경우 판단
            totalByte += 2;
        } else {
            totalByte++;
        }
        $('#textCount').text(totalByte+'/1500');
        // 입력 가능한 최대 글자수까지의 인덱스
        if (totalByte <= maxByte) {
            len = i + 1;
        }
    }
    // 초과되는 글자 자르기
    if (totalByte > maxByte) {
        str2 = strValue.substr(0, len-1);
        obj.value = str2;
        $('#textCount').text(1500+'/1500');
    }
}

function gymQnAInsert() {
	$("#gymQnAForm").submit();
	// ajax로 바꾸기
}
function gymQnAUpdate() {
	$("#gymQnAForm").attr("action", "gymQnAUpdate.do").submit();
}
function gymQnAAnswer() {
	$("#gymQnAForm").attr("action", "gymQnAAnswer.do").submit();
}