<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ taglib
	prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vacation</title>
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
<body>
	<!--  왼쪽 페이지 목록  -->
	<jsp:include page="../MainPage/Left.jsp" />
	<div class="content">
		<!-- 다른 페이지에서 불러오는 내용 -->


		<form
			name="vacation_form"
			method="post"
			action="../Controller/HolidayApplicationController.do"
		>

			<!-- 휴가 신청 버튼 -->
			<div class="middle-text-container">
				<a>사용가능 휴가 : ${userholidaycount.annual }일</a>
			</div>
			<div class="middle-button-container">
				<button
					type="submit"
					class='my_btn'
				>휴가 신청</button>
			</div>

			<!-- 휴가 신청 양식 -->
			<div class="middle-vaction_request-container">
				<table
					border="1"
					width="100%"
				>
					<tr>
						<th colspan="3">휴가 일정</th>
					</tr>
					<tr align="center">
						<td
							align="center"
							width="49%"
							style="text-align: center;"
						>

							<select
								id="start_vacation_year"
								name="start_vacation_year"
								size="1"
								style="width: 25%"
							>
								<option value="">년도를 선택해주세요</option>
								<c:forEach
									var="year"
									begin="2023"
									end="2026"
								>
									<option value="${year}">${year}</option>
								</c:forEach>
							</select>
							<a> - </a>

							<select
								id="start_vacation_month"
								name="start_vacation_month"
								size="1"
								style="width: 25%"
							>
								<option value="">월를 선택해주세요</option>
								<c:forEach
									var="month"
									begin="1"
									end="12"
								>
									<option value="<c:if test='${month lt 10}'>0</c:if>${month}">${month}</option>
								</c:forEach>
							</select>
							<a> - </a>

							<select
								id="start_vacation_day"
								name="start_vacation_day"
								size="1"
								style="width: 25%"
							>
								<option value="">일자를 선택해주세요</option>
								<c:forEach
									var="day"
									begin="1"
									end="31"
								>
									<option value="<c:if test='${day lt 10}'>0</c:if>${day}">${day}</option>
								</c:forEach>
							</select>
						</td>

						<td
							align="center"
							width="2%"
							style="text-align: center;"
						>~</td>

						<td
							align="center"
							width="49%"
							style="text-align: center;"
						>

							<select
								id="end_vacation_year"
								name="end_vacation_year"
								size="1"
								style="width: 25%"
							>
								<option value="">년도를 선택해주세요</option>
								<c:forEach
									var="year"
									begin="2023"
									end="2026"
								>
									<option value="${year}">${year}</option>
								</c:forEach>
							</select>
							<a> - </a>

							<select
								id="end_vacation_month"
								name="end_vacation_month"
								size="1"
								style="width: 25%"
							>
								<option value="">월를 선택해주세요</option>
								<c:forEach
									var="month"
									begin="1"
									end="12"
								>
									<option value="<c:if test='${month lt 10}'>0</c:if>${month}">${month}</option>
								</c:forEach>
							</select>
							<a> - </a>

							<select
								id="end_vacation_day"
								name="end_vacation_day"
								size="1"
								style="width: 25%"
							>
								<option value="">일자를 선택해주세요</option>
								<c:forEach
									var="day"
									begin="1"
									end="31"
								>
									<option value="<c:if test='${day lt 10}'>0</c:if>${day}">${day}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
			</div>

			<!-- 휴가 신청 진행사항 -->
			<div class="middle-vaction_list-container">
				<table
					border="1"
					width="100%"
				>
					<tr>
						<th width="80%">휴가 일정</th>
						<th width="20%">승인 여부</th>
					</tr>
					<c:choose>
						<c:when test="${empty holidayList}">
							<!-- 게시물이 없을 때 -->
							<tr>
								<td
									colspan="2"
									align="center"
								>신청된 휴가가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<!-- 게시물이 있을 때 -->
							<c:forEach
								items="${holidayList}"
								var="row"
								varStatus="loop"
							>
								<tr align="center">
									<td>${row.start_vacation}~${row.end_vacation}</td>
									<td>${row.approval}</td>
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