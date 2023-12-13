<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Left</title>
<style>
* {
	box-sizing: border-box;
}

.left_table {
	width: 10%;
	height: 100%;
	background: rgb(0, 64, 128);
	opacity: 1;
	position: absolute;
	top: 0px;
	left: 0px;
	overflow: hidden;
}

/* 공통 스타일 */
.left_calender_background, .left_shareform_background,
	.left_freeboard_background, .left_holiday_background,
	.left_info_background, .left_new_Id_background,
	.left_salaryManagement_background, .left_Holiday_Approval_background,
	.left_MeetingRoom_background, .left_MeetingRoomReservation_background {
	width: 100%;
	height: 5%;
	background: rgb(0, 64, 128);
	opacity: 1;
	position: absolute;
	overflow: hidden;
}

/* 텍스트 스타일 */
.left_calender_text, .left_shareform_text, .left_freeboard_text,
	.left_holiday_text, .left_info_text, .left_new_Id_text,
	.left_salaryManagement_text, .left_Holiday_Approval_background,
	.left_meetingroom_text, .left_MeetingRoomReservation_text {
	width: 100%;
	color: rgb(255, 255, 255);
	position: absolute;
	top: 30%;
	left: 0;
	font-family: Inter;
	font-weight: Regular;
	font-size: 18px;
	opacity: 1;
	text-align: center;
}

/* 각 섹션 간격 조정 */
.left_calender_background {
	top: 0;
}

.left_shareform_background {
	top: 7%;
}

.left_freeboard_background {
	top: 14%;
}

.left_holiday_background {
	top: 21%;
}

.left_MeetingRoom_background {
	top: 28%;
}

.left_info_background {
	top: 35%;
}

.left_info_background {
	top: 42%;
}

.left_Holiday_Approval_background {
	top: 49%
}

.left_salaryManagement_background {
	top: 56%;
}

.left_new_Id_background {
	top: 63%;
}

.left_MeetingRoomReservation_background {
	top: 70%;
}

/* 섹션에 커서 포인터 스타일 적용 */
.left_Calender_section, .left_ShareForm_section,
	.left_FreeboardForm_section, .left_holiday_section, .left_info_section,
	.left_new_id_section, .left_salaryManagement_section,
	.left_meetingroom_section {
	cursor: pointer;
}
</style>
<script>
	var host = window.location.hostname; // 호스트명
	var port = window.location.port; // 포트번호

	console.log("Host: " + host);
	console.log("Port: " + port);
	var socket = new WebSocket("ws://" + host + ":" + port
			+ "/PersonnelManagement/websocket");

	socket.onopen = function(event) {
		console.log("WebSocket 연결됨");
	};

	socket.onclose = function(event) {
		console.log("WebSocket 연결 종료됨");
	};

	socket.onerror = function(error) {
		console.error("WebSocket 에러 발생: ", error);
	};

	socket.onmessage = function(event) {
		// 서버로부터 메시지 수신 시 알림창 띄우기
		var message = event.data;
		showAlert(message);
	};

	// showAlert 함수 정의
	function showAlert(message) {
		window.alert(message);
	}
</script>
</head>
<body>
	<div class="left_table">
		<div class="left_calender_background">
			<a
				class="left_Calender_section"
				href="../Calender/Calender.jsp"
			>
				<span class="left_calender_text">캘린더</span>
			</a>
		</div>
		<div
			class="left_shareform_background"
			id="leftShareFormBackground"
		>
			<a
				class="left_ShareForm_section"
				href="../Controller/sharelist.do"
			>
				<span class="left_shareform_text">공유양식</span>
			</a>
		</div>

		<div class="left_freeboard_background">
			<a
				class="left_FreeboardForm_section"
				href="../Controller/FreeboardList.do"
			>
				<span class="left_freeboard_text">게시판</span>
			</a>
		</div>


		<div class="left_holiday_background">
			<a
				class="left_holiday_section"
				href="../Controller/HoliDayCount.do"
			>
				<span class="left_holiday_text">휴가신청</span>
			</a>
		</div>
		<div class="left_info_background">
			<a
				class="left_info_section"
				href="../Controller/infoLoad.do"
			>
				<span class="left_info_text">내정보</span>
			</a>
		</div>
		<div class="left_MeetingRoom_background">
			<a
				class="left_meetingroom_section"
				href="../MeetingRoom/MeetingRoom.jsp"
			>
				<span class="left_meetingroom_text">회의실 예약</span>
			</a>
		</div>

		<div>
			<%
			int inpGrade = (int) session.getAttribute("inpGrade");
			if (inpGrade < 3) {
			%>
			<div class="left_new_Id_background">
				<a
					class="left_new_id_section"
					href="../Controller/NewRegistLoad.do"
				>
					<span class="left_new_Id_text">사원관리</span>
				</a>
			</div>

			<div class="left_salaryManagement_background">
				<a
					class="left_salaryManagement_section"
					href="../Controller/SalaryManagement.do"
				>
					<span class="left_salaryManagement_text">급여관리</span>
				</a>
			</div>
			<div class="left_Holiday_Approval_background">
				<a
					class="left_salaryManagement_section"
					href="../Controller/HolidayApprovalLoad.do"
				>
					<span class="left_salaryManagement_text">휴가관리</span>
				</a>
			</div>
			<div class="left_MeetingRoomReservation_background">
				<a
					class="left_MeetingRoom_section"
					href="../Controller/MeetingRoomReservationManagement.do"
				>
					<span class="left_MeetingRoomReservation_text">회의실관리</span>
				</a>
			</div>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>
