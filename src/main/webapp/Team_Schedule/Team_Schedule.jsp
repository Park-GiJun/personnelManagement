<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
	
<%
// 예약 검색 후 선택한 날짜를 파라미터로 추가 (정상적으로 넘어오는지 확인하는 코드)
String selectedDate = request.getParameter("select_date");
%>
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

.form-select {
	margin-top: 2%;
	margin-bottom: 2%;
	height: 32.5px;
	padding: 0rem 0rem 0rem 1rem;
	background-position: right 0.25rem center;
	background-image: none;
}

</style>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var now_utc = Date.now()
    var timeOff = new Date().getTimezoneOffset() * 60000;
    var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
    document.getElementById('Team_schedule').setAttribute('min', today);

    var urlParams = new URLSearchParams(window.location.search);
    var selectedDate = urlParams.get('select_date');
    
    Team_schedule.value = selectedDate ? selectedDate : getCurrentDate();
});

function getCurrentDate() {
    var today = new Date();
    var yyyy = today.getFullYear();
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var dd = String(today.getDate()).padStart(2, '0');
    var currentDate = yyyy + '-' + mm + '-' + dd;
    return currentDate;
}
</script>
</head>
<body>
	<form name="Team_Schedule_form" method="get" action="../Controller/Team_Schedule.do">
		<div class="date_button">
			<input type="date" id="Team_schedule" name="select_date" class="form-select">
			
			<button type="submit" class="btn-light btn-sm">일정 추가</button>
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