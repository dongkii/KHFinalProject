<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.bundle.js"></script>
<script type="text/javascript">
	var btn = document.getElementById('PieAjax')
	
	btn.addEventListener('click', function() {
		PieAjax('http://localhost:8888/fitnessground/charts.do');
	})
	
	function PieAjax(url) {
		var oReq = new XMLHttpRequest();
		
		oReq.open('POST', url);
		oReq.setRequestHeader('content-Type', 'application/json')//json 형태로보냄
		oReq.send();
		
		oReq.addEventListener('load', function(){
			var result = JSON.parse(oReq.resonseText);
			var score = result.score;
			var comp_data = data.datasets[0].data;
			
			for(var i =0; i<comp_data.length; i++){
				comp_data[i] = score[i];
			}
			
			data.datasets[0].data = comp_data;
			myPieChart.update();
			
		})
		
		app.post('/', function(req, res){
			var responseData = {};
			
			var query = connection.query('select  category1,  sum(readcount) from tb_video_board group by category1', function(err, rows){
				responseData.score= [];
				if(err) throw err;
				if(rows[0]){
					responseData.result = "ok";
					rows.forEach(function(val){
						responseData.score.push(val.score);
					})
					
				}else{
					responseData.result = "none";
					responseData.score = "";
				}
				
				res.json(responseData);
				
			});
		
		});
		
	}
	
	
</script>


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
          <i class="fa fa-area-chart"></i> Area Chart Example</div>
        <div class="card-body">
          <canvas id="myAreaChart" width="100%" height="30"></canvas>
          <button id="AreaAjax">button</button>
        </div>
        <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
      </div>
      <div class="row">
        <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i> Bar Chart Example</div>
            <div class="card-body">
              <canvas id="myBarChart" width="100" height="50"></canvas>
               <button id="BarAjax">button</button>
            </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
          </div>
        </div>
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i> Pie Chart Example</div>
            <div class="card-body">
              <canvas id="myPieChart" width="100%" height="100"></canvas>
              <button id="PieAjax">button</button>
            </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
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
    
    <script src="/fitnessground/resources/admin/js/sb-admin-charts.min.js"></script>
  </div>
</body>
</html>