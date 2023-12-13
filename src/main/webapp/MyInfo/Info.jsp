<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ page import="java.util.List"%>
<%@ page import="attend.AttendanceDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>MyInfo</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<script>

var jsonString = '<%=request.getAttribute("attendDateMap")%>';
var InitAttendData =  JSON.parse(jsonString);

function getCurrentTime() {
		var now = new Date();
		var hours = now.getHours();
		var minutes = now.getMinutes();

		return hours + ':' + minutes;
	}
	var currentDate = new Date();
	var currentYear = currentDate.getFullYear();
	var currentMonth = currentDate.getMonth();

	document
			.addEventListener(
					'DOMContentLoaded',
					function() {
						var currentDate = new Date(); // 오늘 날짜로 초기화
						console.log("DOMContentLoaded");

						// 출근 버튼 클릭 이벤트
						document
								.getElementById('commute-button')
								.addEventListener(
										'click',
										function() {
											console.log("출근버튼");
											var formattedDate = formatDate(currentDate);
											var currentTime = getCurrentTime();
											console
													.log('[' + currentTime
															+ ']');

											// 현재 날짜의 셀을 찾아서 출근 시간 입력
											var todayCell = findCellByDate(currentDate
													.getDate());
											if (todayCell) {
												todayCell
														.querySelector('.arriveText').textContent = currentTime;
											}
											
											sendAttendanceRequest('arrive', formattedDate, currentTime);
											
										});

						// 퇴근 버튼 클릭 이벤트
						document
								.getElementById('leave-button')
								.addEventListener(
										'click',
										function() {
											console.log("퇴근버튼");
											var formattedDate = formatDate(currentDate);
											var currentTime = getCurrentTime();
											console
													.log('[' + currentTime
															+ ']');

											// 현재 날짜의 셀을 찾아서 퇴근 시간 입력
											var todayCell = findCellByDate(currentDate
													.getDate());
											if (todayCell) {
												todayCell
														.querySelector('.leaveText').textContent = currentTime;
											}
											
											sendAttendanceRequest('leave', formattedDate, currentTime);
										});

						generateCalendar(InitAttendData);
						updateMonthYearText();

					});
	function generateCalendar(attendDateMap) {
		var datepickerTable = document.getElementById('datepicker-table');
		datepickerTable.innerHTML = '';

		


		var firstDay = new Date(currentYear, currentMonth, 1);
		var lastDay = new Date(currentYear, currentMonth + 1, 0);
		var daysInMonth = lastDay.getDate();

		var day = 1;
		for (var i = 0; i < 6; i++) {
			var row = datepickerTable.insertRow();

			for (var j = 0; j < 7; j++) {
				var cell = row.insertCell();

				if ((i === 0 && j < firstDay.getDay()) || day > daysInMonth) {
					cell.textContent = '';
				} else {
					var dateText = document.createElement('div');
					dateText.textContent = day;
					dateText.className = 'date-text';
					cell.appendChild(dateText);

					// Create new arriveText and leaveText for each cell
					var arriveText = document.createElement('div');
					var leaveText = document.createElement('div');

					// Iterate over the attendDateMap in JavaScript
					var currentDate = formatDate(new Date(currentYear,
							currentMonth, day));
					var currentDateMap = attendDateMap[currentDate];

					if (currentDateMap) {
						arriveText.textContent = currentDateMap["start_time"];
						arriveText.className = 'arriveText';
						arriveText.setAttribute('id', 'arriveText' + day);

						leaveText.textContent = currentDateMap["finish_time"];
						leaveText.className = 'leaveText';
						leaveText.setAttribute('id', 'leaveText' + day);
					} else {
						arriveText.textContent = '출근시각';
						arriveText.className = 'arriveText';
						arriveText.setAttribute('id', 'arriveText' + day);

						leaveText.textContent = '퇴근시각';
						leaveText.className = 'leaveText';
						leaveText.setAttribute('id', 'leaveText' + day);
					}

					cell.appendChild(arriveText);
					cell.appendChild(leaveText);
					day++;
				}
			}
		}
	}

	function changeMonth(offset) {
		currentMonth += offset;

		if (currentMonth < 0) {
			currentMonth = 11;
			currentYear--;
		} else if (currentMonth > 11) {
			currentMonth = 0;
			currentYear++;
		}

		var updatedYearMonth = formatUpdateDate(currentYear, currentMonth);
		console.log("updatedYearMonth : " + updatedYearMonth);

		sessionStorage.setItem('updateCurrentDate', updatedYearMonth);

		var updateCurrentDate = sessionStorage.getItem('updateCurrentDate');
		console.log("업데이트 현재 날짜 가져오기 : " + updateCurrentDate);

		// updateCalendar 함수 호출
		updateCalendar(updateCurrentDate);

		updateMonthYearText();
	}

	function updateMonthYearText() {
		var currentMonthYearText = document
				.getElementById('current-month-year');
		currentMonthYearText.textContent = currentYear + '년 '
				+ (currentMonth + 1) + '월';

		sessionStorage.setItem('CurrentDate', currentYear + "-"
				+ (currentMonth + 1));
		console.log(sessionStorage.getItem('CurrentDate'));

	}

	function formatDate(date) {
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var day = date.getDate();
		return year + '-' + (month < 10 ? '0' : '') + month + '-'
				+ (day < 10 ? '0' : '') + day;
	}

	function formatUpdateDate(Year, Month) {
		var year = Year;
		var month = Month + 1;
		return year + '-' + (month < 10 ? '0' : '') + month;
	}

	function findCellByDate(day) {
		// 특정 날짜의 셀을 찾아서 반환
		var cells = document.querySelectorAll('.date-text');
		for (var i = 0; i < cells.length; i++) {
			if (cells[i].textContent == day) {
				return cells[i].parentNode; // 부모 셀 반환
			}
		}
		return null; // 찾지 못한 경우
	}

	// 서버로 출근 또는 퇴근 요청을 보내는 함수
	function sendAttendanceRequest(action, date, time) {
		fetch('../Controller/Attend.do', {
			method : 'POST',
			headers : {
				'Content-Type' : 'application/x-www-form-urlencoded',
			},
			body : 'action=' + action + '&checkdate=' + date + '&time=' + time,
		});
	}

	// 서버로부터 날짜 데이터를 가져와서 달력을 업데이트하는 함수
	function updateCalendar(updateCurrentDate) {
    fetch('../Controller/LoadDate.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'updateCurrentDate=' + updateCurrentDate,
    })
    .then(response => response.json())  // 응답을 JSON 형태로 파싱
    .then(attendDateMap => {
    	 console.log(attendDateMap);
    	generateCalendar(attendDateMap);
       
    })
    .catch(error => {
        console.error('Error fetching data:', error);
    });
}
	
	function openModifyWindow() {
		var infoName = document.getElementById('infoName').innerText;
	    var infoEmpNum = document.getElementById('infoEmpNum').innerText;
	    var infoPhone = document.getElementById('infoPhone').innerText;
	    var infoEmail = document.getElementById('infoEmail').innerText;
		
	    
	    var detailsUrl = '../MyInfo/InfoModify.jsp'
	        + '?infoName=' + encodeURIComponent(infoName)
	        + '&infoEmpNum=' + encodeURIComponent(infoEmpNum)
	        + '&infoPhone=' + encodeURIComponent(infoPhone)
	        + '&infoEmail=' + encodeURIComponent(infoEmail);

		window.open(detailsUrl, "_blank", "width=600, height=400");
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

.btn-info {
	border-radius: 25px;
	margin-left: 200px;
	font-size: 20px;
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
	position: relative;
	left: 15%;
	padding: 20px;
	max-height: 100%;
}

.info_profile {
	display: flex;
	width: 50%;
	height: 20%;
	position: relative;
	top: 80px;
	left: 2%;
	top: 2%;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.info_profile_photo {
	background-color: gray;
	width: 200px;
	height: 100%;
	display: inline-block;
}

.info_profile_texts {
	display: flex;
	width: 150%;
	font-size: 20px;
	display: inline-block;
	margin-left: 105%;
}

.info_income {
	background-color: gray;
	margin-top: 20px;
	padding: 20;;
	width: 600px;
	height: 500px;
	/* 높이를 자동으로 조정하도록 수정 */
	position: relative;
	top: 80px;
	left: 50px;
	/* 여백 추가 */
	--bs-table-color: #000;
	color: var(--bs-table-color);
}

.info_income_text {
	width: 500px;
	height: 60px;
	margin: 0 auto;
	/* 가운데 정렬을 위해 추가 */
}

.print_income {
	margin-left: 200px;
	font-size: 20px;
}

.income_table {
	margin-top: 28px;
	height: 75%;
	width: 100%;
	/* 부모에 맞추기 위해 100%로 조정 */
	border-collapse: collapse;
	width: 100%;
	width: 100%;
	/* 테이블 간격 제거 */
}

.income_table th, .income_table td {
	border: 1px solid white;
	/* 테두리 스타일 조정 */
	padding: 8px;
	/* 셀 안 여백 추가 */
	text-align: center;
	/* 텍스트 가운데 정렬 */
}

.info_income_textbox {
	display: flex;
	margin-right: -120px;
	--bs-table-color: #000;
	color: var(--bs-table-color);
}

.current-month-year {
	font-size: 12px;
}

.datepicker-container {
	position: fixed;
	top: 10%;
	left: 65%;
	margin: auto;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 2%;
	border-radius: 5px;
	max-width: 60%;
	z-index: 1; /* 다른 요소 위에 표시되도록 z-index 추가 */
	--bs-table-color: #000;
	color: var(--bs-table-color);
}

.datepicker-container table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

.datepicker-container th, .datepicker-container td {
	border: 1px solid #ddd;
	text-align: center;
	font-size: 20px;
}

.datepicker-container thead {
	background-color: #f2f2f2;
}

.datepicker-container td:hover {
	background-color: #e0e0e0;
	cursor: pointer;
}

.date-text {
	display: block;
	margin-top: 5px;
	font-size: 12px;
}

.navigation-btn {
	margin-top: 20px;
	display: flex;
	justify-content: space-between;
}

.current-month-year {
	font-size: 12px;
}

.arriveText {
	font-size: 15px;
}

.leaveText {
	font-size: 15px;
}

.form-select {
	margin-top: 3.5px;
	width: 20%;
	height: 20px;
}

/* 수정하기 버튼 스타일 */
#modify-button {
	margin-top: 0.5%;
    margin-left: 2.5%;
    width: 100px; /* 수정하기 버튼의 너비 설정 */
}

/* 출력하기 버튼 스타일 */
#print-button {
	margin-top: 0.5%;
    margin-left: 80px;
    width: 150px; /* 출력하기 버튼의 너비 설정 */
}

#prev-month-btn {
	margin-left: 0%;
	width: 100px;
}

#next-month-btn {
	margin-left: 0%;
	width: 100px;
}

#commute-button {
	margin-left: 0%;
	width: 100px;
} 
#leave-button {
	margin-left: 0%;
	width: 100px;
}

#yearSelect {
	--bs-table-color: #000;
	color: var(--bs-table-color);
}

#monthSelect {
	--bs-table-color: #000;
	color: var(--bs-table-color);
}
</style>

<body>
	<jsp:include page="../MainPage/Left.jsp" />

	<div class="content">
		<div class="info_profile">
			<div class="info_profile_photo">
				<div class="info_profile_texts">
					<p>이름 : <a id="infoName">${ Infolist.name } </a></p>
					<p>사번 : <a id="infoEmpNum">${ Infolist.emp_num } </a></p>
					<p>전화번호 : <a id="infoPhone">${ Infolist.phone }</a></p>
					<p>이메일 : <a id="infoEmail">${ Infolist.email }</a></p>
				</div>
			</div>
		</div>
		
		<button	type="button" id="modify-button" onclick="openModifyWindow()" class="btn-info">수정하기</button>
		<div class="info_income">
			<div class="info_income_textbox">
			
				<label for="yearSelect">연도:</label>
				<!-- &nbsp;	<select	id="yearSelect" size="1" name="yearSelect" class="form-select"></select> -->
				&nbsp;	<label for="monthSelect">월:</label>  
				<!-- &nbsp;	<select	id="monthSelect" size="1" name="monthSelect" class="form-select"></select> -->

				<button	name="print_income" id="print-button"	class="btn-info">출력하기</button>
			</div>
<!-- ---------------------------------------------------------------------------------------------------------------------- -->
			<script>
			document.addEventListener('DOMContentLoaded', function () {
			    var yearSelect = document.getElementById("yearSelect");
			    var monthSelect = document.getElementById("monthSelect");

			    var currentYear = new Date().getFullYear();

			    // Set default values for year and month
			    yearSelect.value = currentYear;
			    monthSelect.value = new Date().getMonth() + 1; // Note: JavaScript months are 0-based

			    // 연도를 현재 연도부터 10년 전까지 생성
			    for (var year = currentYear; year >= currentYear - 10; year--) {
			        var option = document.createElement("option");
			        option.value = year;
			        option.text = year;
			        yearSelect.add(option);
			    }

			    // 월은 1부터 12까지 생성
			    for (var month = 1; month <= 12; month++) {
			        var monthText = month < 10 ? '0' + month : '' + month;
			        var option = document.createElement("option");
			        option.value = monthText;
			        option.text = monthText;
			        monthSelect.add(option);
			    }

			    // Add onchange event handler
			    yearSelect.onchange = monthSelect.onchange = function () {
			        var selectedYear = yearSelect.value;
			        var selectedMonth = monthSelect.value;
			        console.log('Selected Year:', selectedYear);
			        console.log('Selected Month:', selectedMonth);

			        // You can customize the fetch request based on your needs
			        fetch('../Controller/SalaryPrint.do', {
			            method: 'POST',
			            headers: {
			                'Content-Type': 'application/x-www-form-urlencoded',
			            },
			            body: 'selectedDate=' + selectedYear + "-" + selectedMonth,
			        })
			        .then(response => response.json())
			        .then(chageDateSalary => {
    // Process the fetched data as needed
    console.log('Fetched Data:', chageDateSalary);

    // Assuming 'chageDateSalary' is an object with properties corresponding to the table values
    document.getElementById('payCell').innerText = chageDateSalary.pay;
    document.getElementById('totalPayCell').innerText = chageDateSalary.total_pay;
    document.getElementById('holidayPayCell').innerText = chageDateSalary.holiday_pay;
    document.getElementById('incentiveCell').innerText = chageDateSalary.incentive;
    document.getElementById('extraWorkPayCell').innerText = chageDateSalary.extra_work_pay;
})
			        .catch(error => {
			            console.error('Error fetching data:', error);
			        });
			    };

			    // Trigger the onchange event to fetch data for the default values
			    yearSelect.onchange();
			});


</script>
	<!-- ------------------------------------------------------------------------------------------------------------- -->
			<table class="income_table"	border="1">
				<tr>
					<th>기본급</th>
					<th id="payCell">${ Infolist.pay }</th>
				</tr>
				<tr>
					<th>총 인센티브</th>
					<th id="totalPayCell">${ Infolist.total_pay }</th>
				</tr>
				<tr>
					<th>추가급</th>
					<th id="holidayPayCell">${ Infolist.holiday_pay }</th>
				</tr>
				<tr>
					<th>성과급</th>
					<th id="incentiveCell">${ Infolist.incentive }</th>
				</tr>
				<tr>
					<th>추가 근무 수당</th>
					<th id="extraWorkPayCell">${ Infolist.extra_work_pay }</th>
				</tr>
			</table>

		</div>
		<div class="datepicker-container">
			<form
				id="monthForm"
				action="../Controller/LoadDate.do"
				method="post"
			>
				<input
					type="hidden"
					name="currentYear"
					id="currentYear"
					value=""
				>
				<input
					type="hidden"
					name="currentMonth"
					id="currentMonth"
					value=""
				>
			</form>
			<div class="navigation-btn">
				<!-- 이전달로 이동하는 버튼 -->
				<button	id="prev-month-btn"	onclick="changeMonth(-1)" class="btn-info">이전달</button>
				<!-- 현재 월과 년도를 표시하는 곳 -->
				<a id="current-month-year"></a>
				<!-- 다음달로 이동하는 버튼 -->
				<button	id="next-month-btn"	onclick="changeMonth(1)" class="btn-info">다음달</button>
			</div>
			<table id="datepicker-table">
			</table>
			<div class="info_check_buttons"></div>
			<div class="check_btn">
				<button	type="button" id='commute-button' class="btn-info">출근</button>
				<button	type="button" id='leave-button' class="btn-info">퇴근</button>
			</div>
		</div>
		<div class="info_commute"></div>
	</div>
</body>

</html>