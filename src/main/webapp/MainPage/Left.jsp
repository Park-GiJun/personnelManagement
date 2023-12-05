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
	.left_info_background {
	width: 100%;
	height: 12%;
	background: rgb(0, 64, 128);
	opacity: 1;
	position: absolute;
	overflow: hidden;
}

/* 텍스트 스타일 */
.left_calender_text, .left_shareform_text, .left_freeboard_text,
	.left_holiday_text, .left_info_text {
	width: 100%;
	color: rgb(255, 255, 255);
	position: absolute;
	top: 50%;
	left: 0;
	font-family: Inter;
	font-weight: Regular;
	font-size: 25px;
	opacity: 1;
	text-align: center;
}

/* 각 섹션 간격 조정 */
.left_calender_background {
	top: 0;
}

.left_shareform_background {
	top: 13%;
}

.left_freeboard_background {
	top: 26%;
}

.left_holiday_background {
	top: 39%;
}

.left_info_background {
	top: 52%;
}

/* 섹션에 커서 포인터 스타일 적용 */
.left_Calender_section, .left_ShareForm_section {
	cursor: pointer;
}
</style>
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
				<div class="left_shareform_img">
					<span class="left_shareform_text">공유양식</span>
				</div>

				<span class="left_holiday_text">휴가관리</span>
				<a href="../Controller/HoliDayCount.do">
					<div class="left_holiday_img">
						<span class="left_holiday_text">휴가관리</span>
					</div>
				</a>
		</div>
		<div class="left_info_background">
			<a href="../Controller/infoLoad.do">
				<span class="left_info_text">내정보</span>
			</a>
		</div>
	</div>
</body>
</html>
