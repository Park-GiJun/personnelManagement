<%@page import="HoliDay.HoliDayDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vacation</title>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

/* 각 종류 버튼 스타일 */
.my_btn {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 95%;
	height: 200%;
	font-size: 200%;
	border-radius: 30px;
}

/* 휴가 조회 버튼 스타일 */
.HoliDay_Check_btn {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 20%;
	height: 200%;
	font-size: 200%;
	border-radius: 30px;
}

/* 휴가 신청 위치 수정 */
.middle-button-container {
	position: relative;
	margin-top: -3%;
	margin-left: 80%;
}

/* 휴가 조회 버튼 위치 수정 */
.top-button-container {
	position: relative;
	margin-top: 0%;
	margin-left: 0%;
}

/* 사용가능한 휴가 text 위치 수정 */
.middle-text-container {
	position: relative;
	margin-top: -3%;
	margin-left: 20%;
	font-size: 200%;
}

/* 휴가신청 현황 위치 수정 */
.middle-vaction_list-container {
	position: relative;
	margin-top: 10%;
	margin-left: 0%;
	font-size: 150%;
}

/* 휴가신청 양식 위치 수정 */
.middle-vaction_request-container {
	position: relative;
	margin-top: 7.5%;
	margin-left: 0%;
	font-size: 150%;
}

</
head> <style> /* 공통 스타일 */ * {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-size: 16px;
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
	margin-left: 400px; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
	font-size: 12px;
}
</style>
<body>
	<%
	HoliDayDTO holidaydto = new HoliDayDTO();
	%>
	<!--  왼쪽 페이지 목록  -->
	<jsp:include page="../MainPage/Left.jsp" />
	<div class="content">
		<!-- 다른 페이지에서 불러오는 내용 -->
		
		<form name="Holiday_Check_fornm" method="post" action="../Controller/Holiday_CheckController.do">
  			<div class="top-button-container">
      	 		<button type="submit" class='HoliDay_Check_btn'>남은 휴가 조회</button>
    		<div class="middle-text-container">사용가능 휴가 : <%= holidaydto.getAnnual() %></div>
   			</div>
		</form>

		<form name="vacation_form" method="post"
			action="../Controller/holiday.do">

			<!-- 휴가 신청 버튼 -->
			<div class="middle-button-container">
				<button type="submit" class='my_btn'>휴가 신청</button>
			</div>
			
			<!-- 휴가 신청 양식 -->
			<div class="middle-vaction_request-container">
				<table border="1" width="100%">
					<tr>
						<th colspan="2">휴가 일정</th>
					</tr>
					<tr align="center">
						<td>휴가 시작</td>
						<td>휴가 복귀</td>
					</tr>
					<tr align="center">
						<td><input type="text" name="start_vacation"
							style="width: 75%; box-sizing: border-box;"></td>
						<td><input type="text" name="end_vacation"
							style="width: 75%; box-sizing: border-box;"></td>
					</tr>
				</table>
			</div>

			<!-- 휴가 신청 진행사항 -->
			<div class="middle-vaction_list-container">
				<table border="1" width="100%">
					<tr>
						<th>휴가 일정</th>
						<th>승인 여부</th>
					</tr>
					<tr align="center">
						<td>2023-12-01 ~ 2023-12-05</td>
						<td>승인대기</td>
					</tr>
				</table>
			</div>

		</form>
	</div>
</body>
</html>