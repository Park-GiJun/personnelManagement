<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.content {
	margin-left: 10%; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
	font-size: 12px;
	height: 100%;
}

.top-right {
	text-align: right;
	vertical-align: top;
	padding-right: 5px; /* 오른쪽 여백을 추가하여 더 나은 시각적 간격을 제공합니다. */
	padding-top: 5px; /* 위쪽 여백을 추가하여 더 나은 시각적 간격을 제공합니다. */
}

.sidebar {
	height: 100%;
	width: 0; /* 초기 상태에서 사이드바는 보이지 않음 */
	position: fixed;
	z-index: 1;
	top: 0;
	right: 0;
	background-color: rgb(101, 111, 124); /* 사이드바 배경색 */
	overflow-x: hidden; /* 내용이 너무 많을 경우 스크롤바 숨김 */
	transition: 0.5s; /* 사이드바 토글 시 애니메이션 효과 */
	padding-top: 30px;
	background-color: rgb(101, 111, 124); /* 내용이 상단에서 조금 떨어지도록 함 */
}

.sidebar a {
	padding: 8px 8px 8px 32px;
	text-decoration: none;
	font-size: 25px;
	color: #818181;
	display: block;
	transition: 0.3s;
}

.diary-entry {
	margin: 10px 0;
	padding: 5px;
	background-color: #f9f9f9;
	border-left: 3px solid #4CAF50;
}

.diary-entry-container {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.diary-checkbox {
	margin-right: 10px;
}

#calendar {
	font-family: Arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

#calendar th {
	color: white;
	padding: 8px;
}

#calendar td {
	border: 1px solid #ddd;
	text-align: center;
	padding: 8px;
	cursor: pointer;
	width: 60px;
	height: 120px;
}

#calendar .today {
	background-color: gray;
}

#calendar td:hover {
	background-color: lightblue; /* 하이라이트될 배경색 */
	cursor: pointer; /* 커서를 포인터 모양으로 변경 */
}

.next-month {
	color: rgba(0, 0, 0, 0.5); /* 검정색 텍스트에 50% 투명도 */
}

.diary-entry-container {
	margin-bottom: 10px; /* 각 일정 항목 사이의 여백 */
}

.form-check-input {
	margin-top: 0; /* 체크박스의 상단 여백 제거 */
	margin-bottom: 0; /* 체크박스의 하단 여백 제거 */
}

.diary-text {
	margin-top: 0; /* 텍스트의 상단 여백 제거 */
	margin-bottom: 0; /* 텍스트의 하단 여백 제거 */
}

.schedule-item {
    background-color: #f0f0f0;
    margin-top: 2px;
    padding: 2px;
    font-size: 0.8em;
    border-radius: 4px;
    /* 추가 스타일링 */
}

</style>
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<script src="../TestTest/Test.js"></script>
</head>
<body>
	<jsp:include page="../MainPage/Left.jsp" />
	<div class="content">
		<div class="row">
			<div class="col-md-1">
				<h4 id="displayMonth"></h4>
			</div>
			<div class="col-md-5">
				<div id="secBtn">
					<button class="btn btn-secondary btn-sm" onclick="company()">회사일정</button>
					<button class="btn btn-secondary btn-sm" onclick="team()">부서일정</button>
					<button class="btn btn-secondary btn-sm" onclick="personal()">개인일정</button>
					<button class="btn btn-secondary btn-sm" onclick="vacation()">부서휴가자</button>
				</div>
			</div>
			<div class="col-md-4">
				<div class="d-flex">
					<select class="form-select form-select-sm me-2" id="selectYear">
					</select>
					<select class="form-select form-select-sm" id="selectMonth">
					</select>
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="calender">
			<div id="calendar-container">
				<table id="calendar" class="table table-hover">
					<thead class="table-info" style="text-align: center;">
						<tr>
							<th>일</th>
							<th>월</th>
							<th>화</th>
							<th>수</th>
							<th>목</th>
							<th>금</th>
							<th>토</th>
						</tr>
					</thead>
					<tbody class="table-light">
					</tbody>
				</table>
			</div>
			<div id="sidebar" class="sidebar">
				<div style="display: flex; justify-content: center; align-items: center; width: 100%;">
					<h2 id="headerDate" class="text-info"></h2>
				</div>
				<div style="display: flex; justify-content: center; align-items: center; width: 100%;">
					<button id="addDiaryButton" onclick="addDiary()" class="btn btn-secondary btn-sm">일정 생성</button>
					<button id="deleteDiaryButton" onclick="deleteDiary()" class="btn btn-secondary btn-sm">일정 삭제</button>
					<button id="sidebarToggle" class="btn btn-primary btn-sm">닫기</button>
				</div>
				<div id="sidebarContent"></div>
			</div>
		</div>
	</div>
</body>
</html>