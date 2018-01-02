<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<c:import url="common/head.jsp" />

<style type="text/css">
</style>


	
<c:import url="common/headend.jsp" />

 <c:if test="${ sessionScope.user == null }">
		<script type="text/javascript">
			$(function (){
				alert("로그인이 필요합니다.");
				location.href="main.do";
			});
		</script>
		
	</c:if>

<c:import url="common/nav.jsp" />

  <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="#">Dashboard</a>
        </li>
        <li class="breadcrumb-item active">Charts</li>
      </ol>
      <!-- Area Chart Example-->
      <div class="card mb-3">
        <div class="card-header">
          <i class="fa fa-area-chart"></i>지역별 공공시설물 갯수 현황</div>
        <div class="card-body">
          <canvas id="myAreaChart" width="100%" height="30"></canvas>
        </div>
        <div class="card-footer small text-muted"></div>
      </div>
      <div class="row">
        <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>등록된 동영상의 갯수 현황</div>
            <div class="card-body">
              <canvas id="myBarChart" width="100" height="50"></canvas>
            </div>
            <div class="card-footer small text-muted"></div>
          </div>
        </div>
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i>카테고리별 동영상 조회수 현황</div>
            <div class="card-body">
              <canvas id="myPieChart" width="100%" height="100"></canvas>
            </div>
            <div class="card-footer small text-muted"></div>
          </div>
        </div>
      </div>
    </div>
    <!-- /.container-fluid-->
    <!-- /.content-wrapper-->
    <c:import url="common/footer.jsp" />
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fa fa-angle-up"></i>
    </a>
     
  </div>
  
  <script type="text/javascript">
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';
// -- Area Chart Example

var areaLables=[],areaDatas=[],
barLables=[],barDatas=[],
pieLables=[],pieDatas=[];
 $(function(){
	 $.ajax({
		 url:'/fitnessground/ajax/chart.do',
		 type:'get',
		 success:function(data){
			 var pglist=data.pglist;
			 for(var i in pglist){
				 areaLables.push(pglist[i].location);
				 areaDatas.push(pglist[i].public_count);
			 }
			 var glist=data.glist;
			 for(var j in glist){
				 barLables.push(glist[j].category);
				 barDatas.push(glist[j].count);
			 }
			 var hlist=data.hlist;
			 for(var k in hlist){
				 console.log(hlist[k].category1+","+hlist[k].readcount);
				 pieLables.push(hlist[k].category1);
				 pieDatas.push(hlist[k].readcount);
			 }
			 init();
		 },
		 error:function(error){
			console.log(error); 
		 }		 
	 });
 });
 function init(){
 var myLineChart = new Chart($("#myAreaChart"), {
   type: 'line',
   data: {
     labels: areaLables,
     datasets: [{
       label: "공공시설 수",
       lineTension: 0.3,
       backgroundColor: "rgba(2,117,216,0.2)",
       borderColor: "rgba(2,117,216,1)",
       pointRadius: 5,
       pointBackgroundColor: "rgba(2,117,216,1)",
       pointBorderColor: "rgba(255,255,255,0.8)",
       pointHoverRadius: 5,
       pointHoverBackgroundColor: "rgba(2,117,216,1)",
       pointHitRadius: 20,
       pointBorderWidth: 2,
       data: areaDatas,
     }],
   },
   options: {
     scales: {
       xAxes: [{
         time: {
           unit: 'date'
         },
         gridLines: {
           display: false
         },
         ticks: {
           maxTicksLimit: 7
         }
       }],
       yAxes: [{
         ticks: {
           min: 0,
           max: 2000,
           maxTicksLimit: 5
         },
         gridLines: {
           color: "rgba(0, 0, 0, .125)",
         }
       }],
     },
     legend: {
       display: false
     }
   }
 });
 // -- Bar Chart Example
 var ctx = $("#myBarChart");
 var myLineChart = new Chart(ctx, {
   type: 'bar',
   data: {
     labels: barLables,
     datasets: [{
       label: "동영상 수",
       backgroundColor: "rgba(2,117,216,1)",
       borderColor: "rgba(2,117,216,1)",
       data: barDatas,
     }],
   },
   options: {
     scales: {
       xAxes: [{
         time: {
           unit: 'month'
         },
         gridLines: {
           display: false
         },
         ticks: {
           maxTicksLimit: 6
         }
       }],
       yAxes: [{
         ticks: {
           min: 0,
           max: 300,
           maxTicksLimit: 5
         },
         gridLines: {
           display: true
         }
       }],
     },
     legend: {
       display: false
     }
   }
 });
 // -- Pie Chart Example
 var ctx = $("#myPieChart");
 var myPieChart = new Chart(ctx, {
   type: 'pie',
   data: {
     labels: pieLables,
     datasets: [{
       data: pieDatas,
       backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28a745'],
     }],
   },
 });
 }
 </script>
<c:import url="common/end.jsp" />