$(document).ready(function(){
	var calendar = new controller(); 
	calendar.init();
});
										
	function controller(target) {
		var that = this;   
		var m_oMonth = new Date();
		m_oMonth.setDate(1);

		this.init = function() {
			that.renderCalendar();
			that.initEvent();
		}

	    /* 달력 UI 생성 */
		this.renderCalendar = function() {
			var arrTable = [];

			arrTable.push('<table class="col-lg-12 col-md-12 col-sm-12"><colgroup>');
			for(var i=0; i<7; i++) {
				arrTable.push('<col width="100">');
			}		
			arrTable.push('</colgroup><thead><tr>');

			var arrWeek = "일월화수목금토".split("");

			for(var i=0, len=arrWeek.length; i<len; i++) {
				var sClass = '';
				sClass += i % 7 == 0 ? 'sun' : '';
				sClass += i % 7 == 6 ? 'sat' : '';
				arrTable.push('<td class="'+sClass+'">' + arrWeek[i] + '</td>');
			}
			arrTable.push('</tr></thead>');
			arrTable.push('<tbody>');

			var oStartDt = new Date(m_oMonth.getTime());
			// 1일에서 1일의 요일을 빼면 그 주 첫번째 날이 나온다.
			oStartDt.setDate(oStartDt.getDate() - oStartDt.getDay());
			
			for(var i=0; i<100; i++) {
				if(i % 7 == 0) {
					arrTable.push('<tr>');
				}

				var sClass = 'date-cell '
			    sClass += m_oMonth.getMonth() != oStartDt.getMonth() ? 'not-this-month ' : '';
				sClass += i % 7 == 0 ? 'sun' : '';
				sClass += i % 7 == 6 ? 'sat' : '';
				
				if( sClass.includes("not-this-month")){
					arrTable.push('<td class="'+sClass+'"><div>' + oStartDt.getDate() + '</div></td>');
				} else {
					arrTable.push('<td class="'+sClass+'" id="' + m_oMonth.getFullYear() + (m_oMonth.getMonth()+1)  + oStartDt.getDate() + '"><div>' + oStartDt.getDate() + '</div></td>');
				}
				oStartDt.setDate(oStartDt.getDate() + 1);

				if(i % 7 == 6) {
					arrTable.push('</tr>');
					if(m_oMonth.getMonth() != oStartDt.getMonth()) {
					break;
					}
				}
			}
			arrTable.push('</tbody></table>');

			$('#calendar').html(arrTable.join(""));
			
			that.dbschedule(m_oMonth.getFullYear(), (m_oMonth.getMonth()+1), oStartDt.getDate());
			
			that.changeMonth();			
		}

	    /* Next, Prev 버튼 이벤트 */
		this.initEvent = function() {
			$('#btnPrev').click(that.onPrevCalendar);
			$('#btnNext').click(that.onNextCalendar);
		}

	    /* 이전 달력 */
		this.onPrevCalendar = function() {
			m_oMonth.setMonth(m_oMonth.getMonth() - 1);
			that.renderCalendar();
		}

		/* 다음 달력 */
		this.onNextCalendar = function() {
			m_oMonth.setMonth(m_oMonth.getMonth() + 1);
			that.renderCalendar();
		}

		/* 달력 이동되면 상단에 현재 년 월 다시 표시 */
		this.changeMonth = function() {
			$('#currentDate').text(that.getYearMonth(m_oMonth).substr(0,9));
		}

		/* 날짜 객체를 년 월 문자 형식으로 변환 */
		this.getYearMonth = function(oDate) {
			return oDate.getFullYear() + '년 ' + (oDate.getMonth() + 1) + '월';
		}
		
		this.dbschedule = function(year, month, day){
			var gym_no = $("#jsgym_no").val();
			var queryString = { "gym_no": gym_no };
			
			$.ajax({
				url: 'dbschedule.do',
				data: queryString,
				async: false,
				dataType: 'json',
				type: 'post',
				success: function(data){
					var i = 0;
					var ymout = year + "" + month;
					if( data.list.length != 0){
						if(month < 10){
							month = "0" + month;
						}
						for(var t=1; t < 32; t++){
							var ym = (data.list[i].strDate.replace("-", "")).substr(0,6);
							var values = '';
							// 년월이 같은지 확인
							if( ym == year + "" + month ){
								// 디비 날짜랑 일 같은지 확인
								if( ((data.list[i].strDate.replace("-", "")).substr(7,2)).replace("0", "") == t){
									values += "<button class='btn btn-danger' style='padding: 0px; font-size: 8pt;'>"
										+ data.list[i].schedule_time 
										+ " " 
										+ data.list[i].title 
										+ "</button>";
									$("#" + ymout + t + "").append(values);
									i++;
									t--;
									if(i == data.list.length){
										break;
									}
								}
							}
						}
					}
				}
			});
		}
	} 