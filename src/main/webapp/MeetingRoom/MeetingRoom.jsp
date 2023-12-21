<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
// 예약 검색 후 선택한 날짜를 파라미터로 추가
String selectedDate = request.getParameter("selectedDate");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MeetingRoom</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">

<style type="text/css">
@font-face {
    font-family: 'ChungjuKimSaengTTF';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/ChungjuKimSaengTTF.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
    font-family: 'ChungjuKimSaengTTF', sans-serif;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

td, th {
	border: 1px solid gray; /* 테두리 스타일 지정 */
	padding: 1px; /* 셀 안의 내용과 테두리 사이의 간격 조정 */
}

h1 {
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark1 {
	background-color: #272b30;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark2 {
	background-color: rgb(54, 60, 67);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark3 {
	background-color: rgb(68, 74, 83);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
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

.btn-info {
	margin-left: 1%;
	width : 7.5%;
	font-size: 15px;
	height: 45px;
	border-radius: 25px;
	width: 7.5%;
}

body {
	font-size: 16px;
	font-family: 'ChungjuKimSaengTTF', sans-serif;
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
	margin-left: 10%; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
	font-size: 12px;
}

.MeetingRooms {
	margin-left: 5%;
	position: relative;
	left: 10%;
	top: 30%;
	background: black;
}

/* 추가된 스타일 */
.MeetingRoomA {
	width: 300px;
	height: 300px;
	background-color: #272b30;
	margin: 10px;
	float: left;
	position: relative;
}

.MeetingRoomA-1 {
	width: 300px;
	height: 150px;
	background-color: gray;
	margin: 0px;
	float: left;
}

.MeetingRoomA-2 {
	width: 150px;
	height: 150px;
	background-color: gray;
	margin: 0px;
	float: left;
}

.MeetingRoomB {
	width: 300px;
	height: 150px;
	background-color: gray;
	margin: 10px;
	float: left;
}

.MeetingRoomC {
	width: 150px;
	height: 300px;
	background-color: gray;
	margin: 10px;
	float: left;
}

.MeetingRoom-table {
	display: flex;
	margin-top: 20%;
	font-size: 20px;
}

.top {
	display: flex;
}

/* Datepicker 스타일 */
.datePicker {
	position: relative;
	display: inline-block;
	width: 200px;
	height: 40px;
	background-color: #fff;
	border: 1px solid #ccc;
	border-radius: 4px;
	overflow: hidden;
	cursor: pointer;
}

.date-form {
	display: flex;
}

.datePicker input {
	width: calc(100% - 20px);
	height: 100%;
	padding: 10px;
	outline: none;
	border: none;
	background-color: transparent;
	cursor: pointer;
}
</style>

<script>

document.addEventListener('DOMContentLoaded', function() {
	// Add an event listener to call getMeetingRoomInfo on DOMContentLoaded
	getMeetingRoomInfo();
	

	// Set the initial value of the datepicker to the current date
	var urlParams = new URLSearchParams(window.location.search);
    var selectedDate = urlParams.get('selectedDate');
    
	var datePickerInput = document.getElementById('datePickerInput');
	var today = new Date();
	var yyyy = today.getFullYear();
	var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
	var dd = String(today.getDate()).padStart(2, '0');
	var currentDate = yyyy + '-' + mm + '-' + dd;
	
	datePickerInput.value = selectedDate ? selectedDate : getCurrentDate();
});

	function getCurrentDate() {
		var datePickerInput = document.getElementById('datePickerInput');
		var today = new Date();
		var yyyy = today.getFullYear();
		var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
		var dd = String(today.getDate()).padStart(2, '0');
		var currentDate = yyyy + '-' + mm + '-' + dd;
	}

	function showDatePicker() {
		var datePickerInput = document.getElementById("datePickerInput");

		// 이미 생성된 Datepicker가 있다면 삭제
		var existingDatePicker = document.getElementById("customDatePicker");
		if (existingDatePicker) {
			existingDatePicker.parentNode.removeChild(existingDatePicker);
		}

		// Datepicker 생성
		var datePicker = document.createElement("div");
		datePicker.id = "customDatePicker";
		datePicker.className = "datePicker";

		// Date input 생성
		var dateInput = document.createElement("input");
		dateInput.type = "date";
		dateInput.id = "datePickerInput";
		dateInput.addEventListener("input", function() {
			// 선택된 날짜를 입력란에 표시
			datePickerInput.value = dateInput.value;
			// Datepicker 숨김
			datePicker.style.display = "none";
		});

		datePicker.appendChild(dateInput);

		// Datepicker를 body에 추가
		document.body.appendChild(datePicker);

		// Datepicker 위치 조정
		var inputRect = datePickerInput.getBoundingClientRect();
		datePicker.style.position = "absolute";
		datePicker.style.top = inputRect.bottom + "px";
		datePicker.style.left = inputRect.left + "px";
		datePicker.style.display = "block";
	}

	function openMeetingRoomWindow(date, meetingRoomId) {
	    // URL to send the POST request
	    var url = "../Controller/MeetingRoomList.do";

	    // Data to be sent in the request body
	    var data = {
	        MeetingRoom: meetingRoomId, // Fix typo in the parameter name
	        selectedDate: date
	    };

	    // Fetch options
	    var options = {
	        method: "POST",
	        headers: {
	            "Content-Type": "application/x-www-form-urlencoded"
	        },
	        body: new URLSearchParams(data)
	    };

	    // Make the Fetch request
	    fetch(url, options)
	        .then(response => response.json())
	        .then(meetingRoomLists => {
	        	  localStorage.setItem('meetingRoomId', meetingRoomId);
	        	  localStorage.setItem('date', date);
	        	  console.log("확인용 : " + date + " " + meetingRoomId);
	        	  var newWindow = window.open("../MeetingRoom/MeetingRoomDetail.jsp?meetingRoomLists=" + encodeURIComponent(JSON.stringify(meetingRoomLists)), 'MeetingRoomDetail', 'width=600,height=350,resizable=yes');
	        })
	        .catch(error => console.error('Error:', error));
	}



	function getMeetingRoomInfo() {
		// Meeting Room A click event
		var meetingRoomA = document.querySelector(".MeetingRoomA");
		meetingRoomA.addEventListener("click",
				function() {
					var selectedDate = document
							.getElementById("datePickerInput").value;
					openMeetingRoomWindow(selectedDate, "A");
				});

		// Meeting Room B click event
		var meetingRoomB = document.querySelector(".MeetingRoomB");
		meetingRoomB.addEventListener("click",
				function() {
					var selectedDate = document
							.getElementById("datePickerInput").value;
					openMeetingRoomWindow(selectedDate, "B");
				});

		// Meeting Room C click event
		var meetingRoomC = document.querySelector(".MeetingRoomC");
		meetingRoomC.addEventListener("click",
				function() {
					var selectedDate = document
							.getElementById("datePickerInput").value;
					openMeetingRoomWindow(selectedDate, "C");
				});
	}
</script>
</head>
<body>

	<!-- 왼쪽 페이지 목록 -->
	<jsp:include page="../MainPage/Left.jsp" />
	<div class="content">
	
		<form id="dateForm" action="../Controller/MeetingRoomLoadController.do"	method="get">
			<div class="date-form">
				<div class="datePicker">
					<input type="date" id="datePickerInput" name="selectedDate" readonly onclick="showDatePicker()">
				</div>
			
				<button type="submit" class="btn-info">날짜 검색</button>
			</div>
		</form>
		
		<div class="MeetingRooms">
			<div class="MeetingRoomA">
				<div class="MeetingRoomA-1">
					<h1 align="center" style="margin-top: 10%;">A</h1>
				</div>
				<div class="MeetingRoomA-2"></div>
			</div>
			<div class="MeetingRoomB">
				<h1 align="center" style="margin-top: 10%;">B</h1>
			</div>

			<div class="MeetingRoomC">
				<h1 align="center" style="margin-top: 20%;">C</h1>
			</div>
		</div>

		<div class="MeetingRoom-table">
			<table width="33%">
				<tr class="table-dark1" align="center">
					<th colspan="5">A Room</th>
				</tr>

				<tr class="table-dark2" align="center">
					<th>시간</th>
					<th>사번</th>
					<th>이름</th>
					<th>부서</th>
					<th>상태</th>
				</tr>
				<c:forEach begin="9" end="17" var="hour">
					<tr class="table-dark3" align="center">
						<td width="20%">${hour}:00~${hour + 1}:00</td>
						<c:set var="found" value="false" />
						<c:forEach items="${selectList}" var="row" varStatus="loop">
							<c:if
								test="${(row.meetingroomNum eq 'A') && (row.date == hour) && (row.status ne 'Reject')}">
								<td width="20%">${row.empNum }</td>
								<td width="15%">${row.name }</td>
								<td width="15%">${row.team }</td>
								<td width="15%">${row.status }</td>
								<c:set var="found" value="true" />
							</c:if>
						</c:forEach>
						<c:if test="${not found}">
							<!-- 데이터가 없는 경우 빈 셀 삽입 -->
							<td width="20%"></td>
							<td width="15%"></td>
							<td width="15%"></td>
							<td width="15%"></td>
						</c:if>
					</tr>
				</c:forEach>
			</table>

			&nbsp;

			<table width="33%">
				<tr class="table-dark1" align="center">
					<th colspan="5">B Room</th>
				</tr>

				<tr class="table-dark2" align="center">
					<th>시간</th>
					<th>사번</th>
					<th>이름</th>
					<th>부서</th>
					<th>상태</th>
				</tr>
				<c:forEach begin="9" end="17" var="hour">
					<tr class="table-dark3" align="center">
						<td width="20%">${hour}:00~${hour + 1}:00</td>
						<c:set var="found" value="false" />
						<c:forEach items="${selectList}" var="row" varStatus="loop">
							<c:if
								test="${(row.meetingroomNum eq 'B') && (row.date == hour) && (row.status ne 'Reject')}">
								<td width="20%">${row.empNum }</td>
								<td width="15%">${row.name }</td>
								<td width="15%">${row.team }</td>
								<td width="15%">${row.status }</td>
								<c:set var="found" value="true" />
							</c:if>
						</c:forEach>
						<c:if test="${not found}">
							<!-- 데이터가 없는 경우 빈 셀 삽입 -->
							<td width="20%"></td>
							<td width="15%"></td>
							<td width="15%"></td>
							<td width="15%"></td>
						</c:if>
					</tr>
				</c:forEach>
			</table>

			&nbsp;

			<table width="33%">
				<tr class="table-dark1" align="center">
					<th colspan="5">C Room</th>
				</tr>

				<tr class="table-dark2" align="center">
					<th>시간</th>
					<th>사번</th>
					<th>이름</th>
					<th>부서</th>
					<th>상태</th>
				</tr>
				<c:forEach begin="9" end="17" var="hour">
					<tr class="table-dark3" align="center">
						<td width="20%">${hour}:00~${hour + 1}:00</td>
						<c:set var="found" value="false" />
						<c:forEach items="${selectList}" var="row" varStatus="loop">
							<c:if
								test="${(row.meetingroomNum eq 'C') && (row.date == hour) && (row.status ne 'Reject')}">
								<td width="20%">${row.empNum }</td>
								<td width="15%">${row.name }</td>
								<td width="15%">${row.team }</td>
								<td width="15%">${row.status }</td>
								<c:set var="found" value="true" />
							</c:if>
						</c:forEach>
						<c:if test="${not found}">
							<!-- 데이터가 없는 경우 빈 셀 삽입 -->
							<td width="20%"></td>
							<td width="15%"></td>
							<td width="15%"></td>
							<td width="15%"></td>
						</c:if>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

	<script>
		// Add an event listener to call getMeetingRoomInfo on DOMContentLoaded
		document.addEventListener("DOMContentLoaded", getMeetingRoomInfo);
	</script>

</body>
</html>
