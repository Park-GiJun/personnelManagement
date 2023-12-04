<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta
	name="viewport"
	content="width=device-width, initial-scale=1.0"
>
<title>Simple Datepicker</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
}

.datepicker-container {
	max-width: 800px;
	margin: 50px auto;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	border-radius: 5px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

th, td {
	border: 1px solid #ddd;
	padding: 30px 20px;
	text-align: center;
	font-size: 20px;
}

thead {
	background-color: #f2f2f2;
}

td:hover {
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
</style>
</head>

<body>

	<div class="datepicker-container">
		<div class="navigation-btn">
			<button
				id="prev-month-btn"
				onclick="changeMonth(-1)"
			>이전달</button>
			<h2 id="current-month-year"></h2>
			<button
				id="next-month-btn"
				onclick="changeMonth(1)"
			>다음달</button>
		</div>
		<table id="datepicker-table">

		</table>
	</div>
	<script>
		var currentDate = new Date();
		var currentYear = currentDate.getFullYear();
		var currentMonth = currentDate.getMonth();

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
						dateText.textContent = day++;
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

						cell.addEventListener('click', function() {
							var selectedDate = new Date(currentYear,
									currentMonth, this.firstChild.textContent);
							console.log(formatDate(selectedDate));
						});
					}
				}
			}
		}

		function recordAttendance(type) {
			var todayCell = document.querySelector('.today');
			if (todayCell) {
				var time = new Date();
				var timeText = `${type} 시각 : ${time.getHours()}:${time.getMinutes()}`;
				todayCell.querySelector('.date-text').textContent = timeText;
			} else {
				console.log('오늘 날짜를 선택하세요.');
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
			currentMonthYearText.textContent = `${currentYear}년 ${currentMonth + 1}월`;
		}

		function formatDate(date) {
			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var day = date.getDate();
			return year + '-' + (month < 10 ? '0' : '') + month + '-'
					+ (day < 10 ? '0' : '') + day;
		}
	</script>

</body>

</html>
