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
<title>MeetingRoom</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">

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

body {
	font-size: 16px;
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
	margin-left: 10%; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
	font-size: 12px;
}

.MeetingRooms {
	margin-left:5%;
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
	var datePickerInput = document.getElementById('datePickerInput');
	var today = new Date();
	var yyyy = today.getFullYear();
	var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
	var dd = String(today.getDate()).padStart(2, '0');
	var currentDate = yyyy + '-' + mm + '-' + dd;
	datePickerInput.value = currentDate;
});

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
	        	window.open("./MeetingRoomDetail.jsp?meetingRoomLists=" + encodeURIComponent(JSON.stringify(meetingRoomLists)));
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
		<div class="datePicker">
			<input type="text" id="datePickerInput" readonly onclick="showDatePicker()">
		</div>
		<div class="MeetingRooms">
			<div class="MeetingRoomA">
				<div class="MeetingRoomA-1"></div>
				<div class="MeetingRoomA-2"></div>
			</div>
			<div class="MeetingRoomB"></div>
			<div class="MeetingRoomC"></div>
		</div>
	</div>

	<script>
		// Add an event listener to call getMeetingRoomInfo on DOMContentLoaded
		document.addEventListener("DOMContentLoaded", getMeetingRoomInfo);
	</script>

</body>
</html>
