<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WIICAR - 관리자 로그인</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="/wiicar/resources/css/styles.css" rel="stylesheet"type="text/css" />
</head>

<script>
	$(document).ready(function(){
		$("#backBtn").click(function(){
			window.close();
		});
		
		$("#loginBtn").click(function(){
			if($("#nickname").val() == '') {
				alert("아이디를 입력해주세요.");
				return false;
			}
			if($("#pw").val() == '') {				
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			$.ajax({
				url: '/wiicar/loginPro.do',
				type: 'POST',
				data: {nickname : $("#nickname").val(), pw : $("#pw").val()},
				success: function(data) {
					alert("관리자 로그인 완료.");
					opener.location.reload();
					window.close();
				},
				error: function(e) {
					alert("관리자 로그인 실패");
				}
			})
		})
	})

</script>
<style>
	.row {
		text-align: center;
	}
	input {
		width: 100%;
		padding: 1em;
		border: 1px solid #ccc;
		margin-bottom: 10px;
		border-radius: 1em;
		color: #ccc;
	}
	input:focus {
    	box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 8px rgb(82 168 236 / 60%);
    	outline:0;
    	border-color:rgba(82,168,236,0.8);
	}
	button {
		margin-top: 30px;
		width:170px;
		padding: .8em;
		border:none;
		border-radius:5px;
		color:white;
	}
	#loginBtn:hover {
		background-color:#0080ff !important;
	}
	#backBtn:hover {
		background-color:#555 !important;
	}
</style>
<body>
	<h3 align="center" style="padding-top:100px"> 관리자 로그인 페이지 </h3>
	<div class="container" style="padding:30px 0 0 0;width: 350px;">
		<input type="text" id="nickname" placeholder="아이디"/>
		<input type="password" id="pw" placeholder="비밀번호"/>			
		<button type="button" style="border:none;border-radius:5px;color:white;background-color:#3498DB;" id="loginBtn">로그인</button>
		<button type="button" style="border:none;border-radius:5px;color:white;background-color:gray;" id="backBtn">취소</button>
</body>
</html>