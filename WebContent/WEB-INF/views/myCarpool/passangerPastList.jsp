<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css"  href="/wiicar/resources/css/reset.css">
	<link href="/wiicar/resources/css/memberMenu.css" rel="stylesheet"type="text/css" />
	<link rel="stylesheet" type="text/css"  href="/wiicar/resources/css/modal.css">
	<style>
		#content {
		  width: 100%;
		  height: 100%;
		  background-color: #fff;
		  background-image: none;
		  display: flex;
		}
				
		#driver, #passenger {
		  padding: 2% 3%;
		  width: 49%;
		  border-radius: 30px;
		  font-size: 18px;
		  font-weight: 900;
		  color: #fff;
		}
		
		#driver {
		  float: left;
		   color : #000000;
			  background-color: transparent;
			  border: 1px solid #eee;
		}
		
		#passenger {
		  float:right;
		  background-color: cornflowerblue;
		}
		#driver:hover {
			  background-color: #eee;
			}
		.carpool_list {
		  clear:both;
		  width: 100%;
		  padding-top: 20px;
		  margin: 0 auto;
		  position:relative;
		  text-align: center;
		}
		.list_btn {
		  display: inline-block;
		  margin: 0 auto;
		}
		.list_btn button {
		  background-color: transparent;
		  border: 1px solid #eee;
		  width: 200px;
		  margin: 0 auto;
		  padding:15px;
		  border-radius: 20px;
		}
		.list_btn button:hover {
		  background-color: #eee;
		}
		.list_content {
		  padding-top: 30px;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".reviewBtn").click(function() {
				var id = $(this).attr("value1");
				var num = $(this).attr("value2");
				$("#reviewDiv").empty();
				$("#reviewDiv").load("/wiicar/member/reviewModal.do?id=" + id + "&num=" + num +"&type=0");
				setTimeout(review, 300);
			});
			function review() {
				var modal = document.getElementById("reviewPopup");
				modal.style.display = "block";
			};
		});
	</script>
	</head>
<body style="overflow-y:auto;margin-top:30px;">
<div id="container" class="memberContainer">
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div id="content">
		<div id="sidebar">
			<jsp:include page="/WEB-INF/views/member/memberMenu.jsp" />
		</div>
 		<div id="reviewDiv"></div>
		<div id="mypage">
	 		<div class="mypageContent">
    			<!--???????????????-->
    			<div class="content">
		      		<button id="driver" onclick="location.href='/wiicar/member/driverReserv.do'">?????????</button>
		      		<button id="passenger" onclick="location.href='/wiicar/member/passangerMyCarpool.do?sort=reservation'">?????????</button>
					<div class="carpool_list">
						<div class="list_btn">
			          		<button class="waiting" onclick="location.href='/wiicar/member/passangerMyCarpool.do?sort=reservation'">?????? ?????????</button>
	          				<button class="schedule" onclick="location.href='/wiicar/member/passangerMyCarpool.do?sort=upcomming'">????????? ??????</button>
	          				<button class="past"onclick="location.href='/wiicar/member/passangerMyCarpool.do?sort=past'">?????? ??????</button>
						</div>
						<div>
						<c:if test="${listSize == 0}">
							???????????? ?????? ????????? ????????????.
						</c:if>
						<c:if test="${listSize > 0}">
							<c:forEach var="i" begin="0" end="${listSize-1}">
								<div style="margin-top:20px;">
									<div style="margin:auto;width:600px;background-color:#ffffff;border-radius:10px;box-shadow:5px 5px 1px 1px gray;">
										<div style="padding-top:20px;">
											<div style="margin-left:20px;font-size:20px;">
												<span>${carpoolList[i].depart}</span>
												<span class="glyphicon glyphicon-menu-right"></span>
												<span>${carpoolList[i].destination}</span>
											</div>
											<div style="margin-left:20px;margin-top:10px;font-size:15px;">
												<div>${carpoolList[i].time}</div>
												<div style="margin-left:auto;margin-right:20px;">?????? : ${carpoolList[i].price}???</div>
											</div>
											<div style="display:flex;margin-left:20px;margin-top:10px;">
												<div>
													<c:forEach var="tag" items="${tagList[i]}" >
														<span class="label label-default">${tag}</span>
													</c:forEach>
												</div>
												<div style="margin-right:20px;margin-left:auto;">
													<c:if test="${reviewCheck[i] == 0}">
														<button class="reviewBtn"
														 style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:orange;" value1="${carpoolList[i].driverId}" value2="${carpoolList[i].carpoolNum}">?????? ??????</button>
													</c:if>
													<c:if test="${reviewCheck[i] != 0}">
														<button class="reviewBtn"
														 style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:gray;pointer-events: none;" value1="${carpoolList[i].driverId}" value2="${carpoolList[i].carpoolNum}">?????? ??????</button>
													</c:if>
												</div> 
											</div>
											<div style="display:flex;margin:auto;margin-top:20px;">
												<div style="text-align:center;margin-left:20px;">
													<div style="margin-bottom:5px;color:#3498D8;font-weight:700;">?????????</div>
													<div>
														<c:if test="${driverIamge[i] == null}" >
															<img class="userImg" src="/wiicar/resources/imgs/profile_default.png" alt="${carpoolList[i].driverId}" style="width:100%;max-width:75px;border-radius:50%;">
														</c:if>
														<c:if test="${driverIamge[i] != null}" >
															<img class="userImg" src="/wiicar/resources/imgs/${driverIamge[i]}" alt="${carpoolList[i].driverId}"  style="width:100%;max-width:75px;border-radius:50%;">
														</c:if>
													</div>
												</div>
												<div style="width:120;margin-left:10px;margin-bottom:0px;margin-top:5%;">
													<div>${nickname[i]}</div>
													<div style="display:flex;vertical-align:middle;height:30px;">
														<div style="margin-top:2px;">??????&nbsp;&nbsp;</div>
														<div>
															<c:forEach begin="1" end="${rate[i] / 1}">
																<img src="/wiicar/resources/imgs/star.png" style="width:20px" />
															</c:forEach>
															<c:if test="${(rate[i] % 1) == 0.5}">
																<img src="/wiicar/resources/imgs/halfstar.png" style="width:20px" />
															</c:if>
														</div>
													</div>
												</div>
												<div style="margin-left:auto;width:50%;">
													<div style="margin-bottom:5px;color:#3498D8;font-weight:700;">????????? ?????????</div>
													<div style="display:flex;">
														<c:if test="${passengerIamges[i] != null}">
															<c:forEach var="j" begin="0" end="${passengercount[i]}">
																<c:if test="${imgs == null}" >
																	<div style="margin-right:10px;">
																		<img class="userImg" value="${passengerId[j]}" src="/wiicar/resources/imgs/profile_default.png" style="width:100%;max-width:50px;border-radius:50%;">
																	</div>
																</c:if>
																<c:if test="${imgs != null}" >
																	<div style="margin-right:10px;">
																		<img class="userImg" value="${passengerId[j]}" src="/wiicar/resources/imgs/${passengerIamges[j]}" style="width:100%;max-width:50px;border-radius:50%;">
																	</div>
																</c:if>
															</c:forEach>
														</c:if>
														<c:if test="${passengerIamges[i] == null}">
															<div>
																?????????????????? ???????????????.
															</div>
														</c:if>
													</div>
												</div>
											</div>
											<div style="height:20px;">
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>
					<div align="center">
							<c:if test="${count > 0}">
								<c:set var="pageBlock" value="3" />
								<fmt:parseNumber var="res" value="${count / pageSize}" integerOnly="true" />
								<c:set var="pageCount" value="${res + (count % pageSize == 0 ? 0 : 1)}" />
								<fmt:parseNumber var="result" value="${(currentPage-1)/pageBlock}" integerOnly="true" />
								<fmt:parseNumber var="startPage" value="${result * pageBlock + 1}"/>
								<fmt:parseNumber var="endPage" value="${startPage + pageBlock -1}" />
								<c:if test="${endPage > pageCount}">
									<c:set var="endPage" value="${pageCount}" /> 
								</c:if>
								<nav>
									<ul class="pagination" style="display: flex;justify-content: center;font-size: 20px;">
										<c:if test="${startPage > pageBlock}">
											<a href="/wiicar/member/driverPast.do?pageNum=${startPage-pageBlock}" aria-label="Previous">
												<span aria-hidden="true">&laquo;</span>
											</a>
										</c:if>
										<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
											<li style="margin:10px;">
									    		<a href="/wiicar/member/driverPast.do?pageNum=${i}">
									    			<span aria-hidden="true"> ${i} </span>
									    		</a>
									    	</li>
										</c:forEach>
										<c:if test="${startPage > pageBlock}">
											<a href="/wiicar/member/driverPast.do?pageNum=${startPage+pageBlock}" aria-label="Next">
												<span aria-hidden="true">&raquo;</span>
											</a>
										</c:if>
									</ul>
								</nav>
							</c:if>
						</div>
				</div>
   			</div>
  		 </div>
		</div><!-- mypage -->
	</div>
	<!-- FOOTER -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</div>
</body>
</html>
