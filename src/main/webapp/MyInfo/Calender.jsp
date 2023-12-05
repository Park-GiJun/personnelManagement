<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ page import="attend.AttendanceDTO"%>
<%@ page import="java.util.*"%>

<%
List<AttendanceDTO> attendDateList = (List<AttendanceDTO>) request.getAttribute("attendDateList");
if (attendDateList == null) {
	attendDateList = new ArrayList<>(); // 빈 리스트로 초기화
}
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>MyInfo</title>
<script>
	function getCurrentTime() {
		var now = new Date();
		var hours = now.getHours();
		var minutes = now.getMinutes();

		return hours + ':' + minutes;
	}
	var currentDate = new Date();
	var currentYear = currentDate.getFullYear();
	var currentMonth = currentDate.getMonth();

	console.log(currentYear + " " + currentMonth);

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
										});

						generateCalendar();
						updateMonthYearText();

					});

	function generateCalendar() {
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

	                var arriveText = document.createElement('div');
	                var leaveText = document.createElement('div');

	                // Iterate over the attendDateList in JavaScript
	                <%for (int i = 0; i < attendDateList.size(); i++) {%>
	                    var date<%=i%> = '<%=attendDateList.get(i).getDay_of_work()%>';
	                    var arrive<%=i%> = '<%=attendDateList.get(i).getStart_time()%>';
	                    var leave<%=i%> = '<%=attendDateList.get(i).getEnd_time()%>';

					if (day === parseInt(date
<%=i%>
	)) {
						arriveText.textContent = arrive
<%=i%>
	;
						leaveText.textContent = leave
<%=i%>
	;
						break; // 해당 날짜의 데이터를 찾았으므로 반복문 종료
					} else {
						arriveText.textContent = '출근시각';
						leaveText.textContent = '퇴근시각';
					}
<%}%>
	arriveText.className = 'arriveText';
					arriveText.setAttribute('id', 'arriveText' + day);
					cell.appendChild(arriveText);

					leaveText.className = 'leaveText';
					leaveText.setAttribute('id', 'leaveText' + day);
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

		generateCalendar();
		updateMonthYearText();
	}

	function updateMonthYearText() {
		var currentMonthYearText = document
				.getElementById('current-month-year');
		currentMonthYearText.textContent = currentYear + '년 '
				+ (currentMonth + 1) + '월';

		sessionStorage.setItem('currentDate', currentYear + "-"
				+ (currentMonth + 1));
		console.log(sessionStorage.getItem('currentDate'));

	}

	function formatDate(date) {
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var day = date.getDate();
		return year + '-' + (month < 10 ? '0' : '') + month + '-'
				+ (day < 10 ? '0' : '') + day;
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
</script>
</head>
<style>
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
</style>

<body>
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
			<form
				action="../Controller/LoadDate.do"
				method="post"
			>
				<button
					id="prev-month-btn"
					onclick="changeMonth(-1)"
				>이전달</button>
			</form>

			<!-- 현재 월과 년도를 표시하는 곳 -->
			<a id="current-month-year"></a>

			<!-- 다음달로 이동하는 버튼 -->
			<form
				action="../Controller/LoadDate.do"
				method="post"
			>
				<button
					id="next-month-btn"
					onclick="changeMonth(1)"
				>다음달</button>
			</form>
		</div>
		<table id="datepicker-table">
		</table>
		<div class="info_check_buttons"></div>
		<div class="check_btn">
			<button
				type="button"
				id='commute-button'
			>출근</button>
			<button
				type="button"
				id='leave-button'
			>퇴근</button>
		</div>
	</div>
	<div class="info_commute"></div>


</body>

</html>
