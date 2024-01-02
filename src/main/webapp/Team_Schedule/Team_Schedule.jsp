<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<style type="text/css">
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

.date_button {
	font-family: 'ChungjuKimSaengTTF', sans-serif;
	margin-top: 3%;
	margin-left: 1%;
	display: flex;
}

.btn-light {
	margin-left: 27.5%;
	border-radius: 25px;
}

#Team_schedule {
	width: 50%;
	padding: 0rem 0rem 0rem 1rem;"
}

.schedule_content {
	margin-top: 4%;
	margin-left: 1%;
}

#content {
	font-family: 'ChungjuKimSaengTTF', sans-serif;
	width: 100%;
	padding: 0rem 0rem 0rem 0.75rem;
}

</style>
<script>
document.addEventListener('DOMContentLoaded', function() {
	var now_utc = Date.now()
	var timeOff = new Date().getTimezoneOffset()*60000;
	var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
    document.getElementById('Team_schedule').setAttribute('min', today);
});

function submit() {
	alert("팀 일정이 추가 되었습니다.")
}
</script>
</head>
<body>
	<form name="Team_Schedule_form" method="post" action="../Controller/Team_Schedule.do">
		<div class="date_button">
			<input type="date" id="Team_schedule" name="Team_schedule">
			
			<button type="submit" class="btn-light btn-sm" onclick="submit()">일정 추가</button>
		</div>
		
		<div class="schedule_content">
			<table border="1" width="98%">
				<tr>
					<td>
						<input type="text" id="content" name="content">
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>