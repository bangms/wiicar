<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
   <!-- geolib 라이브러리설치 -->
	<script src="https://cdn.jsdelivr.net/npm/geolib@3.3.1/lib/index.min.js"></script>
	<!-- 캘린더 css -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  	<link href="/wiicar/resources/css/reset.css" rel="stylesheet" type="text/css" />
  	<link href="/wiicar/resources/css/popup.css" rel="stylesheet" type="text/css" />
	<!-- 캘린더 다운로드 -->
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
	<!-- 헤더 -->
	
	<!--테스트 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link href="/wiicar/resources/css/reset.css" rel="stylesheet" type="text/css" />
	<link href="/wiicar/resources/css/carpoollist.css?after" rel="stylesheet" type="text/css" />
	<link href="/wiicar/resources/css/popup.css" rel="stylesheet" type="text/css" />
	<link href="/wiicar/resources/css/modal.css" rel="stylesheet" type="text/css" />
	
</head>
<style>
	.modal {
		top: 0 !important;
		left:0 !important;
		width: 100% !important;;
	}
	.modal-body {
		max-height: 100%!important;
	}
	#searchForm div {
		margin-right:auto!important;
	}
</style>
<script>
 $(document).ready(function(){
	 
    //캘린더 오픈소스
    flatpickr("input[name=time]", {
		enableTime: false,
		minDate: "today",
		dateFormat: "Y-m-d",
    });
	 
	// Get the modal
	var modal; 
	// Get the button that opens the modal
	var btn = document.getElementById("myBtn");
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	// When the user clicks the button, open the modal 
	btn.onclick = function() {
	  	modal = document.getElementById("myModal");
	  	modal.style.display = "block";
	}
	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	  modal.style.display = "none";
	}
	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
	
	$(".likeBtn").click(function() {
		console.log($(this).val());
		if(${empty sessionScope.sid}) {
			alert("로그인 후 사용가능합니다.");
		} else {
			$.ajax({
				url : '/wiicar/carpool/checkLike.do',
				data : {
					carpoolNum : $(this).val()
				}
			});
			location.reload();
		}
	});
	
	$(".requestBtn").click(function(){
		if(${empty sessionScope.sid}) {
			alert("로그인 후 사용가능합니다.");
		} else {
			var num = $(this).val();
			$(".popup").empty();
			$(".popup").load("/wiicar/carpool/requestPopup.do?num=" + num);
			setTimeout(request, 300);
		}
	});
	
	$(".userImg").click(function() {
		var id = $(this).attr("alt");
		$(".popup").empty();
		$(".popup").load("/wiicar/carpool/profilePopup.do?id=" + id);
		setTimeout(popup, 300);
	});
	
	function popup() {
		modal = document.getElementById("userProfilePopup");
		modal.style.display = "block";
	};
	
	function request() {
		modal = document.getElementById("requestModal");
		modal.style.display = "block";
	};
	
	console.log($("#filters input[type=checkbox]"));
	
	// Each time any of checkbox is checked,
	// my function will have the value of whcih is checked?
	$("#filters input[type=checkbox]").click(function(){
		const checkedValue={};
		$("#filters input:checked").each(function() {
			checkedValue[$(this).attr("name")] = $(this).attr("value")
		});
		
		
	})
		
	// 이 펑션은 체크가 안되어있는것들에 대해서 하나하나 다 ajax콜을 해줄것이다.
	
	var myFunction = function (checkedValue) {
		var unCheckedCheckBoxes = $("#filters input:not(:checked)") // = Array (체크안되어있는것들의 리스트)
		unCheckedCheckBoxes.each(function(){ //item = uncheckedCheckBoxes[i]
			//array.forEach => one time the fucntion for each element for the array			
			// 먼저 메인검색하고 => 필터로 넘어온다
			// 내 필터는 각 주제마다 count 보여줌.
			console.log($(this))
			const inputName = $(this).attr("name");
			console.log(inputName)
			let data = { 
				[inputName] : $(this).attr("value")
			} //data
			if (checkedValue) {
				data = {
						...data, 
						...checkedValue
				} 
			}
				
			$("#searchForm input[type=hidden]").each(function(){
				const name = $(this).attr("name");
				const value = $(this).attr("value");
				
				data[name] = value;
			})
				
			data.time = $("#searchForm input[name=time]").attr("value");
				
			$.ajax({
				method : "POST",
				url : "count.do",
				async : false,
				data,
				success : function(response){
					$(`#count_\${inputName}`).html(response.count);
					if(response.count === 0){
						$("input:checkbox[name=" + inputName + "]").attr("disabled", true);
					}else{
						$("input:checkbox[name=" + inputName + "]").attr("disabled", false);
					}
				}
			})
		})
	}
	myFunction(); //페이지 로드 될 때 바로 실행됨 / 첫 숫자들 다 보여줄거임
	
	//검색 결과 ajax로 보내서 위도/경도 구해오는 함수
	$("#searchFormSubmit").click(function(event) {
		event.preventDefault();
		myFunction(checkedValue);
		
		//input결과 티맵API로 보내기
		$.ajax({
			method : "GET",
			url : "https://apis.openapi.sk.com/tmap/geo/fullAddrGeo?version=1&format=json&callback=result",
			async : false,
			data : {	
					"appKey" : "l7xxcbda6a9d9b9241f699b4eacec5b60cf1",
					"coordType" : "WGS84GEO",
					"fullAddr" : $("input[name=depart]").val()
			},
			//전송 성공하면 받아올 데이터 : 위도, 경도 -> 검색물안넣었을 땐 아무것도 안돌려줌
			success : function(response) {
				const lat = response.coordinateInfo.coordinate[0].lat.length ? response.coordinateInfo.coordinate[0].lat : response.coordinateInfo.coordinate[0].newLat;
				const lon = response.coordinateInfo.coordinate[0].lon.length ? response.coordinateInfo.coordinate[0].lon : response.coordinateInfo.coordinate[0].newLon;
				//지정된 지구표면 경계선에 있는 경도/위도 구해주는 함수					
				const departBounds = geolib.getBoundsOfDistance({	
					latitude : lat,
					longitude : lon},
					3000);
				const departSwBounds = departBounds[0];
				const departNeBounds = departBounds[1];
				$("input[name=depart_lat]").val(lat);
				$("input[name=depart_lon]").val(lon);
				$("input[name=depart_sw_bound_lat]").val(departSwBounds.latitude);
				$("input[name=depart_sw_bound_lon]").val(departSwBounds.longitude);
				$("input[name=depart_ne_bound_lat]").val(departNeBounds.latitude);
				$("input[name=depart_ne_bound_lon]").val(departNeBounds.longitude);
				}
			}) // ajax
			
			$.ajax({
				method : "GET",
				url : "https://apis.openapi.sk.com/tmap/geo/fullAddrGeo?version=1&format=json&callback=result",
				async : false,
				data : {
						"appKey" : "l7xxcbda6a9d9b9241f699b4eacec5b60cf1",
						"coordType" : "WGS84GEO",
						"fullAddr" : $("input[name=destination]").val()
				},
				success : function(response) {
					const lat = response.coordinateInfo.coordinate[0].lat.length ? response.coordinateInfo.coordinate[0].lat : response.coordinateInfo.coordinate[0].newLat;
					const lon = response.coordinateInfo.coordinate[0].lon.length ? response.coordinateInfo.coordinate[0].lon : response.coordinateInfo.coordinate[0].newLon;
					const destinationBounds = geolib.getBoundsOfDistance({	
						latitude : lat,
					 	longitude : lon},
						5000);
														
					const destinationSwBounds = destinationBounds[0];
					const destinationNeBounds = destinationBounds[1];
					$("input[name=destination_lat]").val(lat);
					$("input[name=destination_lon]").val(lon);
					$("input[name=destination_sw_bound_lat]").val(destinationSwBounds.latitude);
					$("input[name=destination_sw_bound_lon]").val(destinationSwBounds.longitude);
					$("input[name=destination_ne_bound_lat]").val(destinationNeBounds.latitude);
					$("input[name=destination_ne_bound_lon]").val(destinationNeBounds.longitude);
					}
				});
				$("#searchForm").submit(); // ajax
			}); // searchFormSubmit
	
		//캘린더 오픈소스
	    flatpickr("input[name=time]", {
	    	enableTime: false,
	    	minDate: "today",
	    	dateFormat: "Y-m-d",
	    });
}); // document
//검색 유효성
function check(){
	var depart = $('#depart').val();
	var destination = $('#destination').val();
	var time = $('#time').val();
	console.log("depart == > "+ depart);
	console.log("destination == > "+ destination);
	console.log("time == > "+ time);
	if(depart == ''){
		alert("출발지를 입력하세요.");
		return false;
	}
	if(destination ==''){
		alert("도착지를 입력해주세요.")
		return false;
	}
	if(time ==''){
		alert("날짜를 입력해주세요.")
		return false;
	}
}; // checkForm
</script>
<body style="overflow-y:auto;">
	<div class="popup"></div>
	<div id="container" style="text-align:left;">
		<c:import url="../header.jsp"/>
		<div id="content">
			<div style="width:100%;max-width:1400px;margin:auto;">
				<div>
					<div style="text-align:center;">
						<h2 style="color: #555; padding: 30px;">카풀</h2>
					</div>
					<div style="width:200px;margin-left:auto;padding-top:5px;">
					<c:if test="${userdto.permit == 2 && sessionScope.subsciption == 1}">
						<button style="border:none;border-radius:5px;background-color:#5e5e5e;color:#ffffff;width:150px;height:30px;font-size:15px;"
						onclick="window.location='/wiicar/carpool/registerForm.do'">카풀등록하기</button>
					</c:if>
					</div>
				</div>
				<div> <!-- div 정체 확인 -->
				
				<!-- 검색 밑 content -->
				<!--  검색바 -->
					<div id="search-bar" class="page-start"  style="display:flex;justify-content:center;">
						<form id="searchForm" action="searchList.do" method="post" onsubmit="return check();">
							<div id="bar">
								<div class="input-field start">
									<input name="depart_sw_bound_lat" type="hidden" value="${(input.depart_sw_bound_lat != null)? input.depart_sw_bound_lat : ''}" />
									<input name="depart_sw_bound_lon" type="hidden" value="${(input.depart_sw_bound_lon != null)? input.depart_sw_bound_lon : ''}"/>
									<input name="depart_ne_bound_lat" type="hidden" value="${(input.depart_ne_bound_lat != null)? input.depart_ne_bound_lat : ''}"/> 
									<input name="depart_ne_bound_lon" type="hidden" value="${(input.depart_ne_bound_lon != null)? input.depart_ne_bound_lon : ''}"/> 
									<input name="depart" type="text" placeholder="출발지" value="${(input.depart != null)? input.depart : ''}" /> 
								</div>
								
								<div class="input-field end">
									<input name="destination_sw_bound_lat" type="hidden" value="${(input.destination_sw_bound_lat != null)? input.destination_sw_bound_lat : ''}" /> 
									<input name="destination_sw_bound_lon" type="hidden" value="${(input.destination_sw_bound_lon != null)? input.destination_sw_bound_lon : ''}" /> 
									<input name="destination_ne_bound_lat" type="hidden" value="${(input.destination_ne_bound_lat != null)? input.destination_ne_bound_lat : ''}" /> 
									<input name="destination_ne_bound_lon" type="hidden" value="${(input.destination_ne_bound_lon != null)? input.destination_ne_bound_lon : ''}"  /> 
									<input name="destination" type="text"  placeholder="도착지" value="${(input.destination != null)? input.destination : ''}"/>
								</div>
								<div class="date">
									<input id="time" name="time" type="text" placeholder="날짜" value="${(input.time != null)? input.time: ''}">
									<!-- <input class="clear" type="text" placeholder="날짜"> -->
								</div>
								<input id="searchFormSubmit" type="submit" class="search-btn" value="검색" style="padding:0px;"  />
							</div>
							<!-- Modal content -->
							<c:import url="filter.jsp"/>
						</form>
					</div> <!-- 검색 form -->
		
		
					<div style="margin:auto;width:300px;">
						<button id="myBtn" style="border:none;border-radius:5px;width:100%;height:30px;color:white;background-color:#3498DB;">세부 검색</button>
					</div>
					<div>
					<c:if test="${count == 0}">
						<div style="text-align:center;margin:auto;margin-top:40px;margin-bottom:40px;">원하시는 검색 결과가 없습니다.</div>
					</c:if>
					<c:if test="${count != 0}" >
						<c:forEach var="i" begin="0" end="${listSize-1}">
							<div style="margin-top:20px;">
								<div class="carpoolContent" style="margin:auto;background-color:#ffffff;border-radius:10px;box-shadow:5px 5px 1px 1px gray;">
									<div style="padding-top:20px;">
										<div style="margin-left:20px;margin-right:20px;font-size:20px;">
											<span>${carpoolList[i].depart}</span>
											<span class="glyphicon glyphicon-menu-right"></span>
											<span>${carpoolList[i].destination}</span>
										</div>
										<div style="margin-left:20px;margin-top:10px;font-size:15px;">
											<div>${carpoolList[i].time}</div>
											<div style="margin-left:auto;margin-right:20px;">인당 : ${carpoolList[i].price}원</div>
										</div>
										<div style="display:flex;margin-left:20px;margin-top:10px;">
											<div>
												<c:forEach var="tag" items="${tagList[i]}" >
													<span class="label label-default">${tag}</span>
												</c:forEach>
											</div>
											<div style="margin-right:20px;margin-left:auto;">
												<c:if test="${!sessionScope.subsciption}">
													<c:if test="${max[i] == 0}">
														<button class="requestBtn"
														 style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:#3498DB;" value="${carpoolList[i].carpoolNum}">예약요청</button>
													</c:if>
													<c:if test="${max[i] == 1}">
														<button class="requestBtn"
														 style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:#5e5e5e;pointer-events: none;" value="${carpoolList[i].carpoolNum}">정원초과</button>
													</c:if>
													<c:if test="${max[i] == 2}">
														<button class="requestBtn"
														 style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:#f0ad4e;pointer-events: none;" value="${carpoolList[i].carpoolNum}">예약대기중</button>
													</c:if>
												</c:if>
											</div> 
										</div>
										<div class="carpoolUsers" >
											<div class="carpoolDriver" style="display:flex;">
												<div style="text-align:center;margin-left:20px;">
													<div style="margin-bottom:5px;color:#3498D8;font-weight:700;">운전자</div>
													<div>
														<c:if test="${driverIamge[i] == null}" >
															<img class="userImg" src="/wiicar/resources/imgs/profile_default.png" alt="${carpoolList[i].driverId}" style="width:100%;max-width:75px;border-radius:50%;">
														</c:if>
														<c:if test="${driverIamge[i] != null}" >
															<img class="userImg" src="/wiicar/resources/imgs/${driverIamge[i]}" alt="${carpoolList[i].driverId}"  style="width:100%;max-width:75px;border-radius:50%;">
														</c:if>
													</div>
												</div>
												<div style="width:50%;height:66%;margin-left:10px;margin-top:auto;">
													<div style="text-align: left;">${nickname[i]}</div>
													<div style="display:flex;vertical-align:middle;height:30px;">
														<div style="margin-top:2px;">평점&nbsp;&nbsp;</div>
														<div>
															<c:forEach begin="1" end="${rate[i] / 1}">
																<img src="/wiicar/resources/imgs/star.png" style="width:20px" />
															</c:forEach>
															<c:if test="${(rate[i] % 1) > 0}">
																<img src="/wiicar/resources/imgs/halfstar.png" style="width:20px" />
															</c:if>
														</div>
													</div>
												</div>
											</div>
											<div class="carpoolPassengers" >
												<div style="margin-bottom:5px;color:#3498D8;font-weight:700;text-align: left;">매칭된 탑승자</div>
												<div style="display:flex;">
													<c:if test="${passengerIamges[i] != null}">
														<c:forEach var="j" begin="0" end="${passengercount[i] - 1}">
															<c:if test="${imgs == null}" >
																<div style="margin-right:10px;">
																	<img class="userImg" alt="${passengerId[i][j]}" src="/wiicar/resources/imgs/profile_default.png" style="width:100%;max-width:50px;border-radius:50%;">
																</div>
															</c:if>
															<c:if test="${imgs != null}" >
																<div style="margin-right:10px;">
																	<img class="userImg" alt="${passengerId[i][j]}" src="/wiicar/resources/imgs/${passengerIamges[i][j]}" style="width:100%;max-width:50px;border-radius:50%;">
																</div>
															</c:if>
														</c:forEach>
													</c:if>
													<c:if test="${passengerIamges[i] == null}">
														<div>
															아직 매칭된 탑승자가 없습니다. 
														</div>
													</c:if>
												</div>
											</div>
										</div>
										<div>
											<div style="display:flex;padding-bottom:10px;align-items:center;">
												<div style="margin-left:auto;margin-right:5px;">
													<c:if test="${like[i] == 1}">
														<button class="glyphicon glyphicon-heart likeBtn" style="font-size:30px;color:#ee3333;border:none;background-color:#ffffff;" value="${carpoolList[i].carpoolNum}"></button>
													</c:if>
													<c:if test="${like[i] == 0}">
														<button class="glyphicon glyphicon-heart likeBtn" style="font-size:30px;color:gray;border:none;background-color:#ffffff;" value="${carpoolList[i].carpoolNum}"></button>
													</c:if>
												</div>
												<div style="margin-right:20px;">
													관심카풀등록
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
					</div>
					<div align="center">
						<c:if test="${count > 0}">
							<c:set var="pageBlock" value="5" />
							<fmt:parseNumber var="res" value="${count / pageSize}" integerOnly="true" />
							<c:set var="pageCount" value="${res + (count % pageSize == 0 ? 0 : 1)}" />
							<fmt:parseNumber var="result" value="${(currentPage-1)/pageBlock}" integerOnly="true" />
							<fmt:parseNumber var="startPage" value="${result * pageBlock + 1}"/>
							<fmt:parseNumber var="endPage" value="${startPage + pageBlock -1}" />
							<c:if test="${endPage > pageCount}">
								<c:set var="endPage" value="${pageCount}" /> 
							</c:if>
							<nav>
								<ul class="pagination"  style="display:flex;justify-content:center;align-items:center;">
									<c:if test="${startPage > pageBlock}">
										<li><a href="/wiicar/carpool/searchList.do?pageNum=${startPage-pageBlock}&orderby=${sel}_${sort}" aria-label="Previous">
											<span aria-hidden="true">&lt;</span>
										</a></li>
									</c:if>
									<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
										<li>
								    		<a href="/wiicar/carpool/searchList.do?pageNum=${i}&orderby=${orderby}&depart_lat=${input.depart_lat}&depart_lon=${input.depart_lon}&depart_sw_bound_lat=${input.depart_sw_bound_lat}&depart_sw_bound_lon=${input.depart_sw_bound_lon}&depart_ne_bound_lat=${input.depart_ne_bound_lat}&depart_ne_bound_lon=${input.depart_ne_bound_lon}&depart=${input.depart}&destination_lat=${input.destination_lat}&destination_lon=${input.destination_lon}&destination_sw_bound_lat=${input.destination_sw_bound_lat}&destination_sw_bound_lon=${input.destination_sw_bound_lon}&destination_ne_bound_lat=${input.destination_ne_bound_lat}&destination_ne_bound_lon=${input.destination_ne_bound_lon}&destination=${input.destination}&time=${input.time}">
								    			<span aria-hidden="true"> ${i} </span>
								    		</a>
								    	</li>
									</c:forEach>
									<c:if test="${endPage < pageCount }">
										<li><a href="/wiicar/carpool/searchList.do?pageNum=${startPage+pageBlock}&orderby=${sel}_${sort}" aria-label="Next">
											<span aria-hidden="true">&gt;</span>
										</a></li>
									</c:if>
								</ul>
							</nav>
						</c:if>
						<button onclick="window.location='/wiicar/carpool/carpoolList.do'">전체보기</button>
					</div>
				</div>
			</div>
		</div>
		<c:import url="../footer.jsp"/>
	</div>
</body>
</html>
