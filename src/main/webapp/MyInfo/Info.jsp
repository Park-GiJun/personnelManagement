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

	document.addEventListener('DOMContentLoaded', function() {
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
					arriveText.textContent = '출근시각 : ';
					arriveText.className = 'date-text';
					cell.appendChild(arriveText);

					var leaveText = document.createElement('div');
					leaveText.textContent = '퇴근시각 : ';
					leaveText.className = 'date-text';
					cell.appendChild(leaveText);

					cell.addEventListener('click', function(day) {
						return function() {
							var selectedDate = new Date(currentYear,
									currentMonth, day);
							var formattedDate = formatDate(selectedDate);

							// 현재 시간을 가져오는 함수 (시간을 조절할 수 있음)
							var currentTime = getCurrentTime();
							console.log('[' + currentTime + ']');

							this.childNodes[1].textContent = `출근시각 : `
									+ currentTime;

						};
					}(day));

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
	left: 400px;
	padding: 20px;
}

.info_profile {
	width: 600px;
	height: 200px;
	position: relative;
	top: 80px;
	left: 50px;
	top: 80px;
}

.info_profile_photo {
	background-color: gray;
	width: 200px;
	height: 200px;
	display: inline-block;
}

.info_profile_texts {
	width: 400px;
	font-size: 15px;
	display: inline-block;
	vertical-align: middle;
	margin-left: 220px;
	font-size: 15px;
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
	position: relative;
	bottom: 630px;
	left: 50px;
	margin: auto;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	border-radius: 5px;
	max-width: 500px;
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
</style>

<body>
	<jsp:include page="../MainPage/Left.jsp" />

	<div class="content">
		<div class="info_profile">
			<div class="info_profile_photo">
				<div class="info_profile_texts">
					<a> 이름 : 박기준 </a>
					<br />
					<a> 사번 : 12345 </a>
					<br />
					<a> 전화번호 : 010-2842-0351</a>
					<br />
					<a> 이메일 : tpgj98@naver.com</a>
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
					<th>100</th>
				</tr>
				<tr>
					<th>성과급</th>
					<th>200</th>
				</tr>
				<tr>
					<th>추가근무수당</th>
					<th>50</th>
				</tr>
				<tr>
					<th>추가금</th>
					<th>3000</th>
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
			<div class="info_check_buttons">
			
			</div>
		</div>
		<div class="info_commute"></div>
	</div>

</body>

</html>