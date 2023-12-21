<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Meeting Room Detail</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<style>
@font-face {
    font-family: 'ChungjuKimSaengTTF';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/ChungjuKimSaengTTF.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
    font-family: 'ChungjuKimSaengTTF', sans-serif;
}

h1 {
	--bs-table-color: #fff;
	color: var(--bs-table-color);
	margin-left: 5%;
}

th {
   	border: 1px solid gray; /* 테두리 스타일 지정 */
   	padding: 1px; /* 셀 안의 내용과 테두리 사이의 간격 조정 */
}
tbody {
	border: 1px solid gray; /* 테두리 스타일 지정 */
  	padding: 1px; /* 셀 안의 내용과 테두리 사이의 간격 조정 */
}

body {
	font-family: 'ChungjuKimSaengTTF', sans-serif;
}

.my_btn {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 98%;
	height: 200%;
	font-size: 200%;
	border-radius: 30px;
}

.btn-info {
	margin-top: 1%;
	margin-left: 5%;
	width: 20%;
	height: 50px;
	font-size:80%;
	border-radius: 25px;
}

.table-info {
	background-color: #5bc0de;
}

.table-dark1 {
	background-color: #272b30;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark2 {
	font-size:20px;
	background-color: rgb(54, 60, 67);;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark3 {
	font-size:20px;
	background-color: rgb(68, 74, 83);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}
</style>
</head>
<body>
	<h1>Meeting Room Detail</h1>

	<table border="1" style="width: 90%; margin-left: 5%;">
		<thead>
			<tr class="table-dark2" align="center">
				<th width="20%">시간</th>
				<th width="20%">사번</th>
				<th width="15%">이름</th>
				<th width="15%">부서</th>
				<th width="15%">상태</th>
				<th width="15%">예약</th>
			</tr>
		</thead>
			<tbody id="meetingRoomTableBody" class="table-dark3" align="center">
		</tbody>
	</table>

	<button onclick="sendReservation()" class="btn-info">예약 보내기</button>

	<script>
		var urlParams = new URLSearchParams(window.location.search);
		var meetingRoomLists = JSON.parse(urlParams.get('meetingRoomLists'));

		function formatTime(hour) {
		    return hour + ":00-" + (hour + 1) + ":00";
		}

		function sendReservation() {
		    var meetingRoomId = localStorage.getItem('meetingRoomId');
		    var selectedDate = localStorage.getItem('date');
		    var reservations = [];

		    for (var hour = 9; hour < 18; hour++) {
		        var checkbox = document.getElementById('reserveCheckbox' + hour);

		        if (checkbox && checkbox.checked) {
		            // 숫자를 문자열로 변환
		            var formattedHour = String(hour + 9);

		            var combinedDate = new Date(selectedDate + 'T' + formattedHour + ':00:00');

		            // Convert combinedDate to a formatted string
		            var formattedDate = combinedDate.toISOString().slice(0, 19).replace('T', ' ');

		            var reservationData = {
		                Date: formattedDate,
		            };

		            reservations.push(reservationData);
		        }
		    }

		    // meetingRoomId를 별도의 키로 추가
		    var requestData = {
		        meetingRoomId: meetingRoomId,
		        reservations: reservations
		    };

		    // 예약 정보와 meetingRoomId를 서버로 전송
		    fetch('../Contorller/MeetingRoomReservation.do', {
		        method: 'POST',
		        headers: {
		            'Content-Type': 'application/json',
		        },
		        body: JSON.stringify(requestData),
		    })
		    .then(() => {
		        // 서버의 응답을 처리
		        console.log('서버 응답:');
		        alert("신청이 완료 되었습니다.")
		        window.opener.location.reload(); // 부모 창 새로 고침
		        window.close();
		    })

		    .catch(error => {
		        console.error('에러:', error);
		    });
		}




		function populateTable() {
		    var tableBody = document.getElementById('meetingRoomTableBody');

		    for (var hour = 9; hour < 18; hour++) {
		        var row = document.createElement('tr');
		        var timeCell = document.createElement('td');
		        var empNumCell = document.createElement('td');
		        var nameCell = document.createElement('td');
		        var teamCell = document.createElement('td');
		        var statusCell = document.createElement('td');
		        var reserveCell = document.createElement('td');

		        var entry = meetingRoomLists.find(function(item) {
		            return parseInt(item.date) === hour;
		        });

		        if (entry) {
		            empNumCell.textContent = entry.empNum;
		            nameCell.textContent = entry.name;
		            teamCell.textContent = entry.team;
		            statusCell.textContent = entry.status;
		        }

		        // Check if the time is already reserved or rejected
		        var isReservedOrRejected = entry && (entry.status === 'Wait' || entry.status === 'Confirm');
		        
		        var isReject = entry && entry.status === 'Reject';

		        // Create a checkbox for each row if not reserved or rejected
		        if (!isReservedOrRejected) {
		            var checkbox = document.createElement('input');
		            checkbox.type = 'checkbox';
		            checkbox.id = 'reserveCheckbox' + hour;
		            checkbox.value = hour;

		            // Append the checkbox to the reserveCell
		            reserveCell.appendChild(checkbox);
		        }

		        // Set the content of cells based on the entry
		        timeCell.textContent = formatTime(hour);

		        // Append cells to the row only if not reserved or rejected
		        row.appendChild(timeCell);
		        if (!isReject) {
		            row.appendChild(empNumCell);
		            row.appendChild(nameCell);
		            row.appendChild(teamCell);
		            row.appendChild(statusCell);
		        } else {
		            // If rejected, create empty cells and append them
		            row.appendChild(document.createElement('td'));
		            row.appendChild(document.createElement('td'));
		            row.appendChild(document.createElement('td'));
		            row.appendChild(document.createElement('td'));
		        }
		        row.appendChild(reserveCell);

		        // Append the row to the table body
		        tableBody.appendChild(row);
		    }
		}


		

		// Call the function to populate the table
		populateTable();
	</script>
</body>
</html>
