<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Calendar"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="Calender.CalenderDTO"%>
<%@ page import="Calender.CalenderDAO"%>

<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="fileupload.FileUtil"%>
<%@ page import="java.util.List"%>

<%
request.setCharacterEncoding("utf-8");

String name = request.getParameter("name");
String cl_year = request.getParameter("year2");
String cl_month = request.getParameter("month2");
Calendar cal = Calendar.getInstance();

// 시스템 오늘날짜
int ty = cal.get(Calendar.YEAR);
int tm = cal.get(Calendar.MONTH) + 1;
int td = cal.get(Calendar.DATE);

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH) + 1;
int day = cal.get(Calendar.DATE);

// 파라미터 받기
String sy = request.getParameter("year");
String sm = request.getParameter("month");

if (sy != null) { // 넘어온 파라미터가 있으면
	year = Integer.parseInt(sy);
}
if (sm != null) {
	month = Integer.parseInt(sm);
}

cal.set(year, month - 1, 1);
year = cal.get(Calendar.YEAR);
month = cal.get(Calendar.MONTH) + 1;

int week = cal.get(Calendar.DAY_OF_WEEK); // 1(일)~7(토)
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 일정 리스트</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Kanit:wght@700;900&display=swap')
	;

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

.scheduleLink.selected {
	color: orange;
	background-color: #1C427E;
}

.scheduleLink {
	color: white;
}

.conti {
	text-align: center;
	background-color: #1C427E;
}

.re_day {
	text-align: center;
	font-size: 50px;
	position: absolute;
	color: orange;
	top: 2px;
	left: 40px;
}

.re_day2 {
	text-align: center;
	font-size: 30px;
	position: absolute;
	color: orange;
	top: 2px;
	left: 20px;
}

/* 개인 일정 추가하기 버튼 설정 */
.plus_btn {
	text-align: center;
	font-size: 15px;
	position: absolute;
	background-color: #fff;
	top: 80px;
	left: 70px;
	border: none;
	color: #1C427E;
	width: 80px;
	height: 40px;
	border-radius: 30px;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.plus_btn:hover {
	color: white;
	background: orange;
}

.scl {
	top: 600px;
	/* position: absolute; */
	left: 800px;
	width: 185px;
	height: 20px;
	background-color: #1C427E;
	border: none;
	color: #fff;
	font-size: 13px;
	/* position: relative; /* 상대적인 위치 지정 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.scl:hover {
	color: #fff;
	background: green;
}

/* 개인 일정 삭제하기 버튼 설정 */
.del_btn {
	text-align: center;
	font-size: 15px;
	position: absolute;
	background-color: #fff;
	top: 80px;
	left: 160px;
	border: none;
	color: #1C427E;
	width: 80px;
	height: 40px;
	border-radius: 30px;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.del_btn:hover {
	color: white;
	background: orange;
}

.content1 {
	font-size: 20px;
	position: absolute;
	color: #fff;
	top: 1px cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

.content2 {
	font-size: 20px;
	position: absolute;
	color: #fff;
}

.content3 {
	font-size: 20px;
	position: absolute;
	color: #fff;
}

.reverse {
	top: 30px;
	animation-direction: reverse;
	overflow: auto;
	position: absolute;
	left: 1600px;
	width: 330px;
	height: 950px;
	background: #1C427E;
	color: #fff;
	/* animation-name:direction; */
	animation-duration: 2s;
	animation-iteration-count: 3;
	animation-timing-function: ease-in;
}

.reverse::-webkit-scrollbar {
	display: none; /* 스크롤 기능은 계속 적용되지만 안 보이게 설정 */
}

@
-webkit-keyframes direction {from { left:40px;
	
}

to {
	left: 300px;
}

}
.reverse2 {
	top: 140px;
	overflow: auto;
	position: absolute;
	left: 10px;
	width: 310px;
	height: 900px;
	background-color: #1C427E;
	color: #fff;
	/* animation-name:direction; */
	animation-duration: 2s;
	animation-iteration-count: 3;
	animation-timing-function: ease-in;
}

.reverse2::-webkit-scrollbar {
	display: none; /* 스크롤 기능은 계속 적용되지만 안 보이게 설정 */
}

/* 개인 일정 버튼 */
.my_btn {
	background-color: orange;
	color: white;
	border: none;
	width: 150px;
	height: 70px;
	font-size: 20px;
	border-radius: 30px;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.my_btn:hover {
	color: white;
	background: orange;
}

/* 부서 휴가 버튼 */
.my_btn2 {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 150px;
	height: 70px;
	font-size: 20px;
	border-radius: 30px;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.my_btn2:hover {
	color: white;
	background: orange;
}

/* 부서 일정 버튼 */
.my_btn3 {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 150px;
	height: 70px;
	font-size: 20px;
	border-radius: 30px;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.my_btn3:hover {
	color: white;
	background: orange;
}

/* 회사 일정 버튼 */
.my_btn4 {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 150px;
	height: 70px;
	font-size: 20px;
	border-radius: 30px;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.my_btn4:hover {
	color: white;
	background: orange;
}

/* 개인 일정, 부서 휴가, 부서 일정, 회사 일정 버튼 위치 */
.middle-button {
	text-align: center;
	padding: 30px 30px;
	margin-left: 200px;
	font-family: 'Kanit', sans-serif;
}

.next_btn {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 100px;
	height: 70px;
	font-size: 20px;
	border-radius: 30px;
	position: absolute;
	top: 30px;
	left: 1530px;
	font-family: 'Kanit', sans-serif;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.next_btn:hover {
	color: white;
	background: orange;
}

/*   ↑ 여기까지 버튼 위치, 크기 조절   */
.em {
	color: #1C427E; /* 파란색 */
	position: absolute;
	top: -30px;
	left: 250px;
	font-size: 50x;
	border-radius: 30px;
}

day {
	font-size: 100px;
}

tbody {
	background: gray;
}

body {
	background-color: #272b30; /* 검정색 */
	font-size: px;
	font-family: 'Kanit', sans-serif;
	/*color: white;*/
}

a {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

a:active, a:hover {
	text-decoration: underline;
	color: #F28011;
}

.calendar {
	width: 1500px;
	margin: -20px auto;
	margin-left: 250px;
}

.calendar .title {
	position: absolute;
	top: 60px;
	left: 240px;
	width: 100%;
	z-index: 1;
}

/* 년도 선택 리스트 */
.selectField {
	border: 1px solid #999;
	padding: 5px 30px;
	border-radius: 25px;
	font-family: 'Kanit', sans-serif;
	font-size: 18px;
	margin-left: 150px;
	top: 50px;
}

/* 월 선택 리스트 */
.selectField2 {
	border: 1px solid #999;
	padding: 5px 30px;
	border-radius: 25px;
	font-family: 'Kanit', sans-serif;
	font-size: 18px;
	margin-left: 5px;
}

.calendar table {
	width: 100%;
	border-collapse: collapse;
	border-spacing: 0;
}

/* 요일 칸 배경 색 지정 */
.calendar table thead tr:first-child {
	background-color: rgb(68, 74, 83); /* 찐한 회색 */
	color: white;
}

/* 요일, 날짜 칸 크기 조절 */
.calendar table td {
	padding: 30px 80px;
	text-align: left;
	border: 1px solid #ccc;
}

/* 월, 화, 수, 목, 금 글자 색상 설정 */
.calendar table td:nth-child(1)
.calendar table td:nth-child(2)
.calendar table td:nth-child(3)
.calendar table td:nth-child(4)
.calendar table td:nth-child(5) {
	color: white;
}

/* 일요일 색상 지정 */
.calendar table td:nth-child(7n+1) {
	color: red;
}

/* 토요일 색상 지정 */
.calendar table td:nth-child(7n) {
	color: blue;
}

/* 전 월의 일 색상 */
.calendar table td.gray {
	color: #ccc;
	height: 30px; /* 각 날짜 셀의 높이를 최대 30px로 설정 */
	overflow: hidden;
}

/* 날짜 버튼 스타일 지정 */
.calendar table button {
	color: #fff;
	border: none;
	padding: 0;
	background: none;
	font-size: 20px;
	position: relative; /* 상대적인 위치 설정 */
	top: -30px; /* 상단 여백 조정 */
	left: -80px; /* 왼쪽 여백 조정 */
	font-family: 'Kanit', sans-serif;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
	/* background: red; */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.calendar table button:hover {
	color: green;
}

/* 오늘 날짜 스타일 */
.calendar table td.today {
	font-weight: 700;
	background: orange;
	color: #000;
}

/* 일요일 날짜 스타일 */
.calendar table td:nth-child(7n+1) button {
	color: red;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.calendar table td:nth-child(7n+1) button:hover {
	color: green;
}

/* 토요일 날짜 스타일 */
.calendar table td:nth-child(7n) button {
	color: blue;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.calendar table td:nth-child(7n) button:hover {
	color: green;
}

/* 전월의 날짜 색상 지정 */
.calendar table td.gray button {
	color: #000;
	position: relative; /* 상대적인 위치 설정 */
	top: -45px; /* 상단 여백 조정 */
}

/* 다음달의 날짜 색상 지정 */
.calendar table td.gray2 button {
	color: #000;
	position: relative; /* 상대적인 위치 설정 */
	top: -45px; /* 상단 여백 조정 */
}

#bin {
	position: absolute;
	width: 185px;
	background-color: #1C427E;
}
</style>




<script type="text/javascript">




//페이지가 로드될 때 실행되는 함수
document.addEventListener("DOMContentLoaded", function() {
    // 현재 날짜 정보 가져오기
    var currentYear = <%=ty%>;
    var currentMonth = <%=tm%>;
    var currentDay = <%=td%>;

    // 서버로 데이터 전송
    sendDataToServer(currentYear, currentMonth, currentDay);
});

// 서버로 데이터를 전송하는 함수
function sendDataToServer(year, month, day) {
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "../Controller/CalenderController.do", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");

    // 전송할 데이터 설정
    const data = "currentYear=" + encodeURIComponent(year) +
                 "&currentMonth=" + encodeURIComponent(month) +
                 "&currentDay=" + encodeURIComponent(day);

    xhr.send(data);

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                // 서버 응답 처리
                console.log("데이터 전송 성공");
            } else {
                console.error("데이터 전송 실패");
            }
        }
    };
}


function showDateAndAlert(day) {
    // 클릭한 날짜를 JavaScript 변수에 저장
    var clickedDay = day;
    // 클릭한 날짜를 해당 <h2> 요소에 표시
    document.querySelector('.re_day').innerText = "<%=year%>년 <%=month%>월 " + clickedDay + "일";

		// 클릭한 날짜를 alert 창에도 표시
		alert('클릭한 날짜: ' + clickedDay + '일');

		// 선택한 날짜를 숨은 필드에 설정
		document.getElementById('selectedDay').value = clickedDay;
		document.getElementById('selectedYear').value = '<%=year%>';
		document.getElementById('selectedMonth').value = '<%=month%>';

		// 폼 제출
		document.forms["calender_form"].submit();
	}

	//일정 추가하기 버튼 눌렀을 때 설정
	// 일정 추가를 위한 고유한 식별자
	var eventCounter = 1;

	function confirmPlus() {
		var userInput = prompt("추가하고자 하시는 일정을 작성해주세요 :)", "");

		if (userInput !== null && userInput !== "") {
			// 사용자가 확인을 클릭하면 입력한 일정을 서블릿으로 전송
			sendNewScheduleToServer(userInput);
		} else if (userInput === "") {
			alert("일정을 입력해주세요.");
		} else {
			console.log("일정 저장을 취소하였습니다.");
		}
	}

	// 새로운 일정을 서버로 전송하는 함수
	function sendNewScheduleToServer(userInput) {
		const xhr = new XMLHttpRequest();
		xhr.open("POST", "../Controller/CalenderPlusController.do", true);
		xhr.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded; charset=UTF-8");

		// 서버로 전송할 데이터 설정
		const data = "userInput=" + encodeURIComponent(userInput);

		xhr.send(data);

		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4) {
				if (xhr.status === 200) {
					alert(xhr.responseText); // 서버 응답을 알림으로 표시
					location.reload();
					console.log('추가한 일정들:', userInput);
				} else {
					alert("일정 추가에 실패했습니다.");
					console.log('실패한 일정들:', userInput);
				}
			}
		};

	}

	console.log('잘 실행되는지 확인용1111111111111111111111');

	// 링크 클릭 시 선택 및 해제를 토글하는 함수
	var selectedSchedules = []; // 선택한 일정이 저장되는 곳

	document.addEventListener('click', function(event) {
		if (event.target.classList.contains('scheduleLink')) {
			event.preventDefault();
			var selectedSchedule = event.target.getAttribute('data-schedule');
			var isSelected = event.target.classList.toggle('selected');

			alert(selectedSchedule + ' 확인용');

			// 선택한 일정을 리스트에 추가 또는 제거
			if (isSelected) {
				selectedSchedules.push(selectedSchedule);
			} else {
				// 해당 값이 리스트에 존재하면 제거
				var index = selectedSchedules.indexOf(selectedSchedule);
				if (index !== -1) {
					selectedSchedules.splice(index, 1);
				}
			}

			// 선택한 일정들을 콘솔에 출력
			console.log('선택한 일정들:', selectedSchedules);

		}

		// Ajax를 사용하여 Java 서버에 배열 전송
		const xhr = new XMLHttpRequest();
		xhr.open("POST", "/Controller/CalenderDeleteConteController.do", true);
		xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	});

	//삭제하기 버튼 클릭 시 선택한 일정을 서버로 전송하는 함수
	function confirmDelete() {
		var selectedSchedules = Array.from(
				document.querySelectorAll('.scheduleLink.selected')).map(
				function(schedule) {
					return schedule.getAttribute('data-schedule');
				});

		if (selectedSchedules.length > 0) {
			var confirmed = confirm("선택한 일정을 삭제하시겠습니까?");
			if (confirmed) {
				// 수정된 부분: 선택한 일정의 ID를 서버로 전송
				sendSelectedSchedulesToServer(selectedSchedules);
			}
		} else {
			alert("삭제할 일정을 선택해주세요.");
		}
	}

	// 선택한 일정 삭제를 서버로 전송하는 함수
	function sendSelectedSchedulesToServer(selectedSchedules) {
		// Ajax를 사용하여 Java 서버에 배열 전송
		const xhr = new XMLHttpRequest();
		xhr.open("POST", "../Controller/CalenderDeleteController.do", true);
		xhr.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded; charset=UTF-8");

		const data = "selectedSchedules="
				+ encodeURIComponent(selectedSchedules.join(','));
		xhr.send(data);

		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4) {
				if (xhr.status === 200) {
					alert("일정이 삭제되었습니다.");
					// 페이지 리로드 또는 필요한 갱신 작업 수행
					location.reload();
				} else {
					alert("일정 삭제에 실패했습니다.");
				}
			}
		};
	}
</script>

</head>
<style>
/* 공통 스타일 */
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-size: 20px;
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
	margin-left: 400px; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
}

/* 유니크한 클래스로 스타일 지정 */
.myHeader {
	color: blue;
	font-size: 24px;
}
</style>
<body>
	<jsp:include page="../MainPage/Left.jsp"></jsp:include>

	<form name="calender_form" id="calender_form" method="post"
		action="../Controller/CalenderController.do">
		<input type="hidden" name="selectedYear" id="selectedYear"
			value="<%=year%>"> <input type="hidden" name="selectedMonth"
			id="selectedMonth" value="<%=month%>"> <input type="hidden"
			name="selectedDay" id="selectedDay" value=""> <input
			type="hidden" name="currentYear" id="currentYear" value="<%=ty%>">
		<input type="hidden" name="currentMonth" id="currentMonth"
			value="<%=tm%>"> <input type="hidden" name="currentDay"
			id="currentDay" value="<%=td%>">

		<div class="middle-button">
			<!-- 다른 페이지에서 불러오는 내용 -->
			<!-- <h2 class="myHeader">텍스트 입력</h2>  -->
			<button class='my_btn' onclick="location.href='Person_Cal.jsp';">개인
				일정</button>
			<!-- <button class='my_btn2' onclick="location.href='Team_Vcation.jsp';">부서
				휴가</button> -->
			<button class='my_btn3' onclick="location.href='Team_Cal.jsp';">부서
				일정</button>
			<button class='my_btn4' onclick="location.href='Company_Cal.jsp';">회사
				일정</button>
		</div>

		<p class="em" style="font-size: 120px"><%=month%></p>
		<!-- 화면 달력의 월 표시 -->

		<button class='next_btn' onclick="location.href='Person_Cal.jsp';">></button>

		<div class="reverse">

			<h2 class='re_day'>
				<%
				String selectedDate = (String) request.getAttribute("selecteddate");
				if (selectedDate == null) {
					Calendar currentDate = Calendar.getInstance();
					int currentYear = currentDate.get(Calendar.YEAR);
					int currentMonth = currentDate.get(Calendar.MONTH) + 1;
					int currentDay = currentDate.get(Calendar.DATE);

					out.print(currentYear + "-" + currentMonth + "-" + currentDay);
				}
				%>
			</h2>

			<h2 class='re_day'>${selecteddate}</h2>

			<button class='plus_btn' type='submit' onclick="confirmPlus();">추가하기</button>
			<button class='del_btn' type='submit' onclick="confirmDelete();">삭제하기</button>


			<!-- db에 저장된 개인 일정 내용 가져오는 공간 -->
			<div class="reverse2">
				<table class="caltabke" width="100%">
						
					<c:choose>
						<c:when test="${not empty calenderlists}">
								<c:forEach items="${calenderlists}" var="row" varStatus="loop">
								<tr>
									<td style="background-color: #1C427E;">${loop.index + 1}<!-- 각 일정마다 번호 출력 -->
									</td>
									<td style="background-color: #1C427E;"><a href="#"
										class="scheduleLink"
										data-schedule="${row.personal_diaray_schedule}">
											${row.personal_diaray_schedule} <!-- db에 있는 개인 일정 출력 -->
									</a></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:when test="${not empty calenderlists2}">
							<c:forEach items="${calenderlists2}" var="row" varStatus="loop">
								<tr>
									<td style="background-color: #1C427E;">${loop.index + 1}<!-- 각 일정마다 번호 출력 -->
									</td>
									<td style="background-color: #1C427E;"><a href="#"
										class="scheduleLink"
										data-schedule="${row.personal_diaray_schedule}">
											${row.personal_diaray_schedule} <!-- db에 있는 개인 일정 출력 -->
									</a></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td class="conti" align="center">등록된 일정이 없습니다 *^^*</td>
							</tr>
						</c:otherwise>
					</c:choose>
					
					
					
				</table>
			</div>
		</div>

		<c:if test="${not empty deleteMessage}">
			<div>${deleteMessage}</div>
		</c:if>

		<div class="calendar" id="calendar-container"
			style="width: 1300px; height: 300px;">
			<div class="title">
				<!-- 년도 월 선택 리스트 만드는 위치 -->
				<form name="frm" method="post">
					<select id="yearSelect" name="year" class="selectField"
						onchange="change()">
						<%
						for (int i = year - 50; i <= year + 50; i++) {
						%>
						<option value="<%=i%>" <%=year == i ? "selected='selected'" : ""%>><%=i%>년
						</option>
						<%
						}
						%>
					</select> <select id="monthSelect" name="month" class="selectField2"
						onchange="change()">
						<%
						for (int i = 1; i <= 12; i++) {
						%>
						<option value="<%=i%>"
							<%=month == i ? "selected='selected'" : ""%>><%=i%>월
						</option>
						<%
						}
						%>
					</select>
				</form>
			</div>

			<table>
				<!-- 테이블 표 만드는 곳(달력 만드는 곳) -->
				<thead>
					<tr style="width: 100%;">
						<td width="14.25%">일</td>
						<td width="14.25%">월</td>
						<td width="14.25%">화</td>
						<td width="14.25%">수</td>
						<td width="14.25%">목</td>
						<td width="14.25%">금</td>
						<td width="14.25%">토</td>
					</tr>
				</thead>
				<tbody>
					<%
					// 1일 앞 달
					Calendar preCal = (Calendar) cal.clone();
					preCal.add(Calendar.DATE, -(week - 1));
					int preDate = preCal.get(Calendar.DATE);

					out.print("<tr>");
					// 전 달 끝부분 일자 출력
					for (int i = 1; i < week; i++) {
						//out.print("<td>&nbsp;</td>");
						out.print("<td class='gray'style='width: 100px; position: relative; top: 0px; height: 50px;'><button disabled>"
						+ (preDate++) + "</button></td>");
					}

					int click_day = 0;
					// 1일부터 말일까지 출력
					int lastDay = cal.getActualMaximum(Calendar.DATE);
					String cls;

					for (int i = 1; i <= lastDay; i++) {
						cls = year == ty && month == tm && i == td ? "today" : "";

						out.print("<td class='" + cls
						+ "' style='min-width: 100px; max-width: 100px; width: 100px; height: 50px; position: relative;'>");
						//out.print("<td class='" + cls + "' style='min-width: 100px; max-width: 100px; width: 100px; min-height: 10px !important; max-height: 10px !important; height: 50px !important; position: relative;'>");
						out.print("<button id=\"update\" style='max-height: 50px;' onclick=\"showDateAndAlert(" + i + ")\">" + i
						+ "</button>");

						// 버튼 출력 부분 수정 시작
						int buttonStartRightPercentage = 50; // 시작 위치값 설정 (예: 30%)
						out.print(
						"<button disabled class=\"scl\" id=\"bin\" style=\"font-size: 12px; position: relative; bottom: 100%; right: calc("
								+ buttonStartRightPercentage
								+ "% + 10px); background-color: #1C427E; color: white; max-height: 20px;\" onclick=\"location.href='Scl_Cal.jsp';\">일정이 있습니다.</button>");
						// 버튼 출력 부분 수정 끝

						out.print("</td>");

						if (lastDay != i && (++week) % 7 == 1) {
							out.print("</tr><tr>");
						}
					}

					// 다음 달 첫부분 일자 출력
					int n = 1;
					for (int i = (week - 1) % 7; i < 6; i++) {
						// out.print("<td>&nbsp;</td>");
						out.print("<td class='gray' style='width: 100px; position: relative; top: 0px; height: 50px;'><button disabled>"
						+ (n++) + "</button></td>");
					}
					out.print("</tr>");
					%>
				</tbody>
			</table>
		</div>
	</form>
</body>
</html>