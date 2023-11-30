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

body {
	font-size: 40px;
}

.left_table {
	width: 400px;
	height: 100%;
	background: rgb(0, 64, 128);
	opacity: 1;
	position: absolute;
	top: 0px;
	left: 0px;
	overflow: hidden;
}

.left_calender_background {
	width: 400px;
	height: 80px;
	background: rgb(0, 64, 128);
	opacity: 1;
	position: absolute;
	top: 0px;
	left: 0px;
	overflow: hidden;
}

.left_calender_img {
	width: 400px;
	height: 80px;
	background: url("../images/v1_307.png");
	background-repeat: no-repeat;
	background-position: center center;
	background-size: cover;
	padding: 16px 32px;
	opacity: 1;
	position: absolute;
	top: 0px;
	left: 0px;
	overflow: hidden;
}

.left_calender_text {
	width: 336px;
	color: rgb(255, 255, 255);
	position: absolute;
	top: 16px;
	left: 32px;
	font-family: Inter;
	font-weight: Regular;
	font-size: 40px;
	opacity: 1;
	text-align: center;
}

.left_shareform_background {
	width: 400px;
	height: 80px;
	background: rgb(0, 64, 128);
	opacity: 1;
	position: absolute;
	top: 90px;
	left: 0px;
	overflow: hidden;
}

.left_shareform_img {
	width: 400px;
	height: 80px;
	background: url("../images/v1_310.png");
	background-repeat: no-repeat;
	background-position: center center;
	background-size: cover;
	padding: 16px 32px;
	opacity: 1;
	position: absolute;
	top: 0px;
	left: 0px;
	overflow: hidden;
}

.left_shareform_text {
	width: 336px;
	color: rgb(255, 255, 255);
	position: absolute;
	top: 16px;
	left: 32px;
	font-family: Inter;
	font-weight: Regular;
	font-size: 40px;
	opacity: 1;
	text-align: center;
}

.left_freeboard_background {
	width: 400px;
	height: 80px;
	background: rgb(0, 64, 128);
	opacity: 1;
	position: absolute;
	top: 180px;
	left: 0px;
	overflow: hidden;
}

.left_freeboard_img {
	width: 400px;
	height: 80px;
	background: url("../images/v1_313.png");
	background-repeat: no-repeat;
	background-position: center center;
	background-size: cover;
	padding: 16px 32px;
	opacity: 1;
	position: absolute;
	top: 0px;
	left: 0px;
	overflow: hidden;
}

.left_freeboard_text {
	width: 336px;
	color: rgb(255, 255, 255);
	position: absolute;
	top: 16px;
	left: 32px;
	font-family: Inter;
	font-weight: Regular;
	font-size: 40px;
	opacity: 1;
	text-align: center;
}

.left_holiday_background {
	width: 400px;
	height: 80px;
	background: rgb(0, 64, 128);
	opacity: 1;
	position: absolute;
	top: 270px;
	left: 0px;
	overflow: hidden;
}

.left_holiday_img {
	width: 400px;
	height: 80px;
	background: url("../images/v1_316.png");
	background-repeat: no-repeat;
	background-position: center center;
	background-size: cover;
	padding: 16px 32px;
	opacity: 1;
	position: absolute;
	top: 0px;
	left: 0px;
	overflow: hidden;
}

.left_holiday_text {
	width: 336px;
	color: rgb(255, 255, 255);
	position: absolute;
	top: 16px;
	left: 32px;
	font-family: Inter;
	font-weight: Regular;
	font-size: 40px;
	opacity: 1;
	text-align: center;
}

.left_info_background {
	width: 400px;
	height: 80px;
	background: rgb(0, 64, 128);
	opacity: 1;
	position: absolute;
	top: 360px;
	left: 0px;
	overflow: hidden;
}

.left_info_img {
	width: 400px;
	height: 80px;
	background: url("../images/v1_319.png");
	background-repeat: no-repeat;
	background-position: center center;
	background-size: cover;
	padding: 16px 32px;
	opacity: 1;
	position: absolute;
	top: 0px;
	left: 0px;
	overflow: hidden;
}

.left_info_text {
	width: 336px;
	color: rgb(255, 255, 255);
	position: absolute;
	top: 16px;
	left: 32px;
	font-family: Inter;
	font-weight: Regular;
	font-size: 40px;
	opacity: 1;
	text-align: center;
}

.left_section {
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="left_table">
		<div class="left_calender_background">
			<a
				class="left_section"
				href="../Calender/Calender.jsp"
			>
				<div class="left_calender_img">
					<span class="left_calender_text">캘린더</span>
				</div>
			</a>
		</div>
		<div class="left_shareform_background">
			<a
				class="left_section"
				href="../ShareForm/ShareForm.jsp"
			>
				<div class="left_shareform_img">
					<span class="left_shareform_text">공유양식</span>
				</div>
			</a>
		</div>
		<div class="left_freeboard_background">
			<div class="left_freeboard_img">
				<span class="left_freeboard_text">게시판</span>
			</div>
		</div>
		<div class="left_holiday_background">
			<div class="left_holiday_img">
				<span class="left_holiday_text">휴가관리</span>
			</div>
		</div>
		<div class="left_info_background">
			<div class="left_info_img">
				<span class="left_info_text">내정보</span>
			</div>
		</div>
	</div>
</body>
</html>
