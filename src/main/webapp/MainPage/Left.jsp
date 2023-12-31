<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String currentDate = sdf.format(new Date());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Left</title>
<style>
@font-face {
	font-family: 'ChungjuKimSaengTTF';
	src: url('../Font/ChungjuKimSaeng.ttf') format('woff2');
	font-weight: normal;
	font-style: normal;
	font-family: 'ChungjuKimSaengTTF', sans-serif;
}

@font-face {
	font-family: 'intelone-mono-font-family-regular';
	src: url('../Font/IntelOneMono-Regular.ttf') format('woff2');
	font-weight: 400;
	font-style: normal;
}

@font-face {
	font-family: 'SF_HambakSnow';
	src: url('../Font/SF_HambakSnow.ttf') format('woff');
	font-weight: normal;
	font-style: normal;
}

}
* {
	box-sizing: border-box;
}

.left_table {
	width: 10%;
	height: 100%;
	background: rgb(68, 74, 83);
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
	.left_MeetingRoom_background, .left_MeetingRoomReservation_background,
	.left_WorkBoard_background, .left_Company_schedule_background,
	.left_Team_schedule_background {
	width: 100%;
	height: 5%;
	background: rgb(68, 74, 83);
	opacity: 1;
	position: absolute;
	overflow: hidden;
}

.left_Time_background {
	width: 100%;
	height: 5%;
	background: rgb(130, 142, 159);
	opacity: 1;
	position: absolute;
	overflow: hidden;
}

/* 텍스트 스타일 */
.left_calender_text, .left_shareform_text, .left_freeboard_text,
	.left_holiday_text, .left_info_text, .left_new_Id_text,
	.left_salaryManagement_text, .left_Holiday_Approval_text,
	.left_meetingroom_text, .left_MeetingRoomReservation_text,
	.left_WorkBoard_text {
	width: 100%;
	color: #fff;
	position: absolute;
	top: 5%;
	left: 0;
	font-family: 'ChungjuKimSaengTTF', sans-serif;
	font-weight: Regular;
	font-size: 150%;
	opacity: 1;
	text-align: center;
}

.left_Time_text {
	margin-top: 2%;
	width: 100%;
	color: #fff;
	position: absolute;
	top: 10%;
	left: 0;
	font-family: 'ChungjuKimSaengTTF', sans-serif;
	font-weight: Regular;
	font-size: 25px;
	opacity: 1;
	text-align: center;
}

/* 각 섹션 간격 조정 */
.left_Time_background {
	top: 0%;
}

.left_calender_background {
	top: 7%;
}

.left_WorkBoard_background {
	top: 14%;
}

.left_shareform_background {
	top: 21%;
}

.left_freeboard_background {
	top: 28%;
}

.left_holiday_background {
	top: 35%;
}

.left_MeetingRoom_background {
	top: 42%;
}

.left_info_background {
	top: 49%;
}

.left_Team_schedule_background {
	top: 64.5%;
}

.left_Company_schedule_background {
	top: 64.5%;
}

.left_Holiday_Approval_background {
	top: 71.5%;
}

.left_salaryManagement_background {
	top: 78.5%;
}

.left_new_Id_background {
	top: 85.5%;
}

.left_MeetingRoomReservation_background {
	top: 92.5%;
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
	//휴가 신청 창
	function openHoliDayWindow() {
		var detailsUrl = "../Controller/HoliDayCount.do";

		window.open(detailsUrl, "_blank", "width=600, height=400");
	}
	// 부서 일정 추가 창
	function open_team_schedule_Window() {
		var detailsUrl = "../Team_Schedule/Team_Schedule.jsp";

		window.open(detailsUrl, "_blank", "width=400, height=70");
	}

	// 회사 일정 추가 창
	function open_Company_schedule_Window() {
		var detailsUrl = "../Company_Schedule/Company_Schedule.jsp";

		window.open(detailsUrl, "_blank", "width=400, height=70");
	}
</script>
</head>
<body>
	<div class="left_table">
		<div class="left_Time_background" onclick="navigateToTest()">
			<h3 class="left_Time_text"><%=currentDate%></h3>
		</div>

		<script>
			function navigateToTest() {
				window.location.href = '../Calender/Calender.jsp';
			}
		</script>
		<div class="left_calender_background">
			<a class="left_Calender_section" href="../TestTest/Test.jsp">
				<span class="left_calender_text">캘린더</span>
			</a>
		</div>
		<div class="left_shareform_background" id="leftShareFormBackground">
			<a class="left_ShareForm_section" href="../Controller/sharelist.do">
				<span class="left_shareform_text">공유양식</span>
			</a>
		</div>

		<div class="left_freeboard_background">
			<a class="left_FreeboardForm_section" href="../Controller/FreeboardList.do">
				<span class="left_freeboard_text">게시판</span>
			</a>
		</div>
		<div class="left_holiday_background">
			<a class="left_holiday_section" onclick="openHoliDayWindow()">
				<span class="left_holiday_text">휴가신청</span>
			</a>
		</div>
		<div class="left_info_background">
			<a class="left_info_section" href="../Controller/infoLoad.do">
				<span class="left_info_text">내정보</span>
			</a>
		</div>
		<div class="left_MeetingRoom_background">
			<a class="left_meetingroom_section" href="../Controller/MeetingRoomLoadController.do">
				<span class="left_meetingroom_text">회의실 예약</span>
			</a>
		</div>
		<div class="left_WorkBoard_background">
			<a class="left_WorkBoard_section" href="../Controller/WorkBoardList.do">
				<span class="left_WorkBoard_text">전자결재</span>
			</a>
		</div>

		<div>
			<!-- 임원이상 로그인시 -->
			<%
			int inpGrade = (int) session.getAttribute("inpGrade");
			if (inpGrade < 3) {
			%>
			<div class="left_new_Id_background">
				<a class="left_new_id_section" href="../Controller/NewRegistLoad.do">
					<span class="left_new_Id_text">사원관리</span>
				</a>
			</div>

			<div class="left_salaryManagement_background">
				<a class="left_salaryManagement_section" href="../Controller/SalaryManagement.do">
					<span class="left_salaryManagement_text">급여관리</span>
				</a>
			</div>
			<div class="left_Holiday_Approval_background">
				<a class="left_salaryManagement_section" href="../Controller/HolidayApprovalLoad.do">
					<span class="left_salaryManagement_text">휴가관리</span>
				</a>
			</div>
			<div class="left_MeetingRoomReservation_background">
				<a class="left_MeetingRoom_section" href="../Controller/MeetingRoomReservationManagement.do">
					<span class="left_MeetingRoomReservation_text">회의실관리</span>
				</a>
			</div>

			<div class="left_Company_schedule_background">
				<a class="left_salaryManagement_section" onclick="open_Company_schedule_Window()">
					<span class="left_salaryManagement_text">회사일정추가</span>
				</a>
			</div>
			<%
			}
			%>
		</div>

		<div>
			<!-- 부장이 로그인시 -->
			<%
			inpGrade = (int) session.getAttribute("inpGrade");
			if (inpGrade == 3) {
			%>
			<div class="left_new_Id_background">
				<a class="left_new_id_section" href="../Controller/NewRegistLoad.do">
					<span class="left_new_Id_text">사원관리</span>
				</a>
			</div>

			<div class="left_salaryManagement_background">
				<a class="left_salaryManagement_section" href="../Controller/SalaryManagement.do">
					<span class="left_salaryManagement_text">급여관리</span>
				</a>
			</div>
			<div class="left_Holiday_Approval_background">
				<a class="left_salaryManagement_section" href="../Controller/HolidayApprovalLoad.do">
					<span class="left_salaryManagement_text">휴가관리</span>
				</a>
			</div>
			<div class="left_MeetingRoomReservation_background">
				<a class="left_MeetingRoom_section" href="../Controller/MeetingRoomReservationManagement.do">
					<span class="left_MeetingRoomReservation_text">회의실관리</span>
				</a>
			</div>

			<div class="left_Team_schedule_background">
				<a class="left_salaryManagement_section" onclick="open_team_schedule_Window()">
					<span class="left_salaryManagement_text">부서일정추가</span>
				</a>
			</div>
			<%
			}
			%>
		</div>

		<div>
			<!-- 팀장이 로그인시 -->
			<%
			inpGrade = (int) session.getAttribute("inpGrade");
			if (inpGrade == 4) {
			%>
			<div class="left_Holiday_Approval_background" style="top: 85.5%;">
				<a class="left_salaryManagement_section" onclick="open_team_schedule_Window()">
					<span class="left_salaryManagement_text">부서일정추가</span>
				</a>
			</div>

			<div class="left_Holiday_Approval_background" style="top: 92.5%;">
				<a class="left_salaryManagement_section" href="../Controller/HolidayApprovalLoad.do">
					<span class="left_salaryManagement_text">휴가관리</span>
				</a>
			</div>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>