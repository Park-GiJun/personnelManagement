<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vacation</title>

<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">

<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

td {
	border: 1px solid gray; /* 테두리 스타일 지정 */
	padding: 1px; /* 셀 안의 내용과 테두리 사이의 간격 조정 */
}

.btn-info {
	width: 98%;
	font-size: 200%;
	height: 200%;
	border-radius: 25px;
}

.table-info {
	background-color: #5bc0de;
}

.table-dark1 {
	background-color: #272b30;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark2 {
	background-color: rgb(54, 60, 67);;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark3 {
	background-color: rgb(68, 74, 83);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

/* 추가된 스타일 */
.table-dark3 select {
	margin-top: 10px; /* 원하는 만큼 조절 가능한 여백 값 */
	margin-bottom: 10px; /* 원하는 만큼 조절 가능한 여백 값 */
}

.form-select {
	padding: 0rem 0rem 0rem 1rem;
	background-position: right 1rem center;
	height: 80%;
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

/* 휴가 신청 위치 수정 */
.middle-button-container {
	position: relative;
	margin-top: -3%;
	margin-left: 80%;
}

/* 사용가능한 휴가 text 위치 수정 */
.middle-text-container {
	position: relative;
	margin-top: 0%;
	margin-left: 0%;
	margin-right: 0%;
	font-size: 200%;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

/* 휴가신청 현황 위치 수정 */
.middle-vaction_list-container {
	position: relative;
	margin-top: 2.5%;
	margin-left: 0%;
	font-size: 150%;
}

/* 휴가신청 양식 위치 수정 */
.middle-vaction_request-container {
	position: relative;
	margin-top: 2.5%;
	margin-left: 0%;
	font-size: 150%;
}

/* 공통 스타일 */
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-size: 16px;
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
	margin-left: 10%; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
	font-size: 12px;
}
</style>
</head>
<body>
	<!--  왼쪽 페이지 목록  -->
	<jsp:include page="../MainPage/Left.jsp" />
	<div class="content">
		<!-- 다른 페이지에서 불러오는 내용 -->
		<form name="vacation_form" method="post" action="../Controller/HolidayApplicationController.do">

			<!-- 휴가 신청 버튼 -->
			<div class="middle-text-container">
				<a>사용가능 휴가 : ${userholidaycount.annual }일</a>
			</div>
			<div class="middle-button-container">
				<button type="submit" class='btn-info'>휴가 신청</button>
			</div>

			<!-- 휴가 신청 양식 -->
			<div class="middle-vaction_request-container">
				<table border="1" width="100%" height="26%">
					<tr class="table-dark2" align="center">
						<th colspan="9" scope="row">휴가 일정</th>
					</tr>
					<tr class="table-dark3" align="center">
						<th width="5%" scope="row" align="center"><select id="start_vacation_year" name="start_vacation_year" class="form-select" style="width: 90%; align: center;">
								<option value="">년도를 선택해주세요</option>
								<c:forEach var="year" begin="2023" end="2026">
									<option value="${year}">${year}</option>
								</c:forEach>
							</select></th>
						<th width="5%" align="center"><select id="start_vacation_month" name="start_vacation_month" class="form-select" style="width: 90%; align: center;">
								<option value="">월를 선택해주세요</option>
								<c:forEach var="month" begin="1" end="12">
									<option value="<c:if test='${month lt 10}'>0</c:if>${month}">${month}</option>
								</c:forEach>
							</select></th>
						<th width="5%" align="center"><select id="start_vacation_day" name="start_vacation_day" class="form-select" style="width: 90%; align: center;">
								<option value="">일자를 선택해주세요</option>
								<c:forEach var="day" begin="1" end="31">
									<option value="<c:if test='${day lt 10}'>0</c:if>${day}">${day}</option>
								</c:forEach>
							</select></th>

						<th width="1%" align="center">~</th>
						<th width="5%" align="center"><select id="end_vacation_year" name="end_vacation_year" class="form-select" style="width: 90%; align: center;">
								<option value="">년도를 선택해주세요</option>
								<c:forEach var="year" begin="2023" end="2026">
									<option value="${year}">${year}</option>
								</c:forEach>

							</select></th>

						<th width="5%" align="center"><select id="end_vacation_month" name="end_vacation_month" class="form-select" style="width: 90%; align: center;">

								<option value="">월를 선택해주세요</option>
								<c:forEach var="month" begin="1" end="12">
									<option value="<c:if test='${month lt 10}'>0</c:if>${month}">${month}</option>
								</c:forEach>

							</select></th>

						<th width="5%" align="center"><select id="end_vacation_day" name="end_vacation_day" class="form-select" style="width: 90%; align: center;">

								<option value="">일자를 선택해주세요</option>
								<c:forEach var="day" begin="1" end="31">
									<option value="<c:if test='${day lt 10}'>0</c:if>${day}">${day}</option>
								</c:forEach>
							</select></th>
					</tr>
				</table>
			</div>

			<!-- 휴가 신청 진행사항 -->
			<div class="middle-vaction_list-container">
				<table border="1" width="100%">
					<tr class="table-dark2" align="center">
						<th width="80%" scope="row" rowspan="2">휴가 일정</th>
						<th width="20%" colspan="2">승인 여부</th>
					</tr>

					<tr class="table-dark2" align="center">
						<!-- 과장 ~ 사원 휴가신청 현황  -->
						<c:if test="${grade > 4}">
							<th width="10%">팀장 승인</th>
							<th width="10%">부장 승인</th>
						</c:if>
						<!-- 팀장 휴가신청 현황  -->
						<c:if test="${grade eq '4'}">
							<th width="10%">부장 승인</th>
							<th width="10%">이사 승인</th>
						</c:if>
						<!-- 부장 휴가신청 현황  -->
						<c:if test="${grade eq '3'}">
							<th width="10%">이사 승인</th>
							<th width="10%">사장 승인</th>
						</c:if>

					</tr>
					<c:choose>
						<c:when test="${empty holidayList}">
							<!-- 게시물이 없을 때 -->
							<tr class="table-dark3" align="center">
								<td colspan="2" align="center" scope="row">신청된 휴가가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<!-- 게시물이 있을 때 -->
							<c:forEach items="${holidayList}" var="row" varStatus="loop">
								<tr align="center" class="table-dark3">
									<td scope="row">${row.start_vacation}~${row.end_vacation}</td>
									<td>${row.approval}</td>
									<c:if test="${grade > 2}">
										<td>${row.team_approval }</td>
									</c:if>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>

		</form>
	</div>
</body>
</html>