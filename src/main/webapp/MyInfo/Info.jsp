<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
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
					arriveText.textContent = '출근시각';
					arriveText.className = 'arriveText';
					arriveText.setAttribute('id', 'arriveText' + day);
					cell.appendChild(arriveText);

					var leaveText = document.createElement('div');
					leaveText.textContent = '퇴근시각';
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
/* 공통 스타일 */
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
	position: relative;
	left: 10%;
	padding: 20px;
	max-height: 100%;
}

.info_profile {
	width: 50%;
	height: 20%;
	position: relative;
	top: 80px;
	left: 2%;
	top: 2%;
}

.info_profile_photo {
	background-color: gray;
	width: 200px;
	height: 100%;
	display: inline-block;
}

.info_profile_texts {
	width: 100%;
	font-size: 15px;
	display: inline-block;
	vertical-align: middle;
	margin-left: 120%;
}

.info_profile_texts a {
	display: block;
	margin-top: 10px;
	margin-bottom: 10px;
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
}

.info_income_text {
	width: 500px;
	height: 60px;
	color: white;
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
	margin-right: -120px;
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
	<jsp:include page="../MainPage/Left.jsp" />

	<div class="content">
		<div class="info_profile">
			<div class="info_profile_photo">
				<div class="info_profile_texts">
					<a> 이름 : ${ userinfolist.name } </a>
					<br />
					<a> 사번 : ${ userinfolist.empNum } </a>
					<br />
					<a> 전화번호 : ${ userinfolist.phone }</a>
					<br />
					<a> 이메일 : ${ userinfolist.email }</a>
				</div>
			</div>
		</div>
		<div class="info_income">
			<div
				class="info_income_text"
				align="center"
			>
				<div class="info_income_textbox">
					급여정보
					<button
						name="print_income"
						class="print_income"
					>출력하기</button>
				</div>

			</div>
			<table
				class="income_table"
				border="1"
			>
				<tr>
					<th>기본급</th>
					<th>${ incentivelist.pay }</th>
				</tr>
				<tr>
					<th>총 인센티브</th>
					<th>${ incentivelist.addtional_pay }</th>
				</tr>
				<tr>
					<th>추가급</th>
					<th>${ incentivevaluelist.holiday_pay }</th>
				</tr>
				<tr>
					<th>성과급</th>
					<th>${ incentivevaluelist.incentive }</th>
				</tr>
				<tr>
					<th>추가 근무 수당</th>
					<th>${ incentivevaluelist.extra_work_pay }</th>
				</tr>

			</table>
		</div>
		<div class="datepicker-container">
			<div class="navigation-btn">
				<button
					id="prev-month-btn"
					onclick="changeMonth(-1)"
				>이전달</button>
				<a id="current-month-year"></a>
				<button
					id="next-month-btn"
					onclick="changeMonth(1)"
				>다음달</button>
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
	</div>

</body>

</html>
