<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	<link href="/wiicar/resources/css/styles.css" rel="stylesheet"type="text/css" />
  
<script>
	$(document).ready(function(){
		
		$(".btn_result").click(function(){
			var value = $(this).val();
			var reportId = '${reportId}';
			var Id = '${Id}'
			console.log("Value == >> "+value);
			console.log("reportId == >> "+reportId);
			console.log("Id == >> "+Id);
			
			var ajaxJson = new Object;
			ajaxJson.value = value;
			ajaxJson.reportId = reportId,
			ajaxJson.Id = Id;
			
			var allData = JSON.stringify(ajaxJson);
			
			$.ajax({
				url : "reportResult.do",
				type : "POST",
				data : allData,
				contentType : 'application/json;charset=UTF-8',
				success:function(data){
					alert("신고처리 완료")
					opener.parent.location.reload();
					window.close();
				},
				error:function(){
					alert("다시 처리해주세요.");
				}		
			});// ajax
		});// btn-result
		
	}); // document
</script>
<style>
	.row {
		text-align: center;
	}
</style>
  	
<div class="container" style="padding-top:20px">
	<div class="row mb-3"> 
		<div class="col-sm-12"><b>관리자 신고처리</b></div>
	</div>
	<div class="row mb-3">
		<div class="col-sm-6">신고할 사용자 닉네임</div>
		<div class="col-sm-6">${reportId}</div>
	</div>
	<div class="row mb-3">
		<div class="col-sm-6">신고자 닉네임</div>
		<div class="col-sm-6">${Id}</div>
	</div>
	<div class="row mb-3">
		<div class="col-sm-6">신고 사유</div>
		<div class="col-sm-6">${content}</div>
	</div>
	
	<div class="row mb-3">
		<div class="col-sm-12">신고 사유를 허위로 작성했을 시 신고 당사자에게 불이익이 갈 수 있습니다.</div>
	</div>
	
	<div class="row mb-3" style="text-align: center;">
		<div class="col-sm-3"></div>
		<div class="col-sm-3"><button type="button" style="border:none;border-radius:5px;width:150px;height:30px;color:white;background-color:gray;" class="btn_result" value="1">넘어가기</button></div>
		<div class="col-sm-3"><button type="button" style="border:none;border-radius:5px;width:150px;height:30px;color:white;background-color:#3498DB;" class="btn_result" value="2">경고</button></div>
		<div class="col-sm-3"><button type="button" style="border:none;border-radius:5px;width:150px;height:30px;color:white;background-color:#3498DB;" class="btn_result" value="3">탈퇴</button></div>
		<div class="col-sm-3"></div>
	</div>
</div>
