<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<style type="text/css">
<<<<<<< 김채은
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

=======
>>>>>>> 492c5fd 2023-12-21 11:27 휴가신청 페이지 팝업화 및 일정 달력으로 선택 / 폰트 변경 및 UI 개선
.content {
	margin-left: 10%; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
	font-size: 12px;
}

.buttons {
	margin-top: 0%;
	margin-bottom: 1%;
}

.listTable {
	top: 20%;
	width: 100%;
	border-collapse: collapse;
	width: 100%;
}

.btn-info {
	width: 7%;
	font-size:15px;
	height: 20%;
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
	background-color: rgb(54, 60, 67);;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark3 {
	background-color: rgb(68, 74, 83);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark4 {
	background-color: rgb(54, 60, 67);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark4:nth-child(odd) {
	background-color: rgb(44, 50, 57);
}

.form-check-input {
	background-color: #5bc0de;
	border-color: #5bc0de;
	outline: 0;
	box-shadow: 0 0 0 0.15rem rgba(255, 255, 255);
}
</style>
<script type="text/javascript">
        function confirmAction() {
            var type = "confirm";
            var selectedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');

            var selectedData = [];

            selectedCheckboxes.forEach(function (checkbox) {
                var row = checkbox.closest('tr');
                var team = row.cells[1].innerText;
                var empNum = row.cells[2].innerText;
                var name = row.cells[3].innerText;
                var meetingroomNum = row.cells[4].innerText;
                var date = row.cells[5].innerText;
                var status = row.cells[6].innerText;

                selectedData.push({
                    team: team,
                    empNum: empNum,
                    name: name,
                    meetingroomNum: meetingroomNum,
                    date: date,
                    status: status
                });
            });

            fetch("../Controller/ReservationCheck.do", {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json', // Update content type to JSON
                },
                body: JSON.stringify({
                    type: type,
                    selectedData: selectedData
                })
            }).then(() => {
                // Handle the response as needed
            	location.reload();
            }).catch(error => {
                console.error('Error:', error);
            });
        }
        
        function rejectAction() {
            var type = "reject";
            var selectedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');

            var selectedData = [];

            selectedCheckboxes.forEach(function (checkbox) {
                var row = checkbox.closest('tr');
                var team = row.cells[1].innerText;
                var empNum = row.cells[2].innerText;
                var name = row.cells[3].innerText;
                var meetingroomNum = row.cells[4].innerText;
                var date = row.cells[5].innerText;
                var status = row.cells[6].innerText;

                selectedData.push({
                    team: team,
                    empNum: empNum,
                    name: name,
                    meetingroomNum: meetingroomNum,
                    date: date,
                    status: status
                });
            });

            fetch("../Controller/ReservationCheck.do", {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json', // Update content type to JSON
                },
                body: JSON.stringify({
                    type: type,
                    selectedData: selectedData
                })
            }).then(() => {
                // Handle the response as needed
                location.reload();
            }).catch(error => {
                console.error('Error:', error);
            });
        }
    </script>
</head>
<body>
	<jsp:include page="../MainPage/Left.jsp" />

	<div class="content">
	
		<div class="buttons">
			<button type="button" onclick="confirmAction()" class="btn-info">승인</button>
			<button type="button" onclick="rejectAction()" class="btn-info">거절</button>
		</div>

		<table border="1" class="listTable">
			<tr class="table-dark1" style="font-size: 20px;" align="center">
				<th></th>
				<th>팀</th>
				<th>사번</th>
				<th>이름</th>
				<th>회의실</th>
				<th>일자</th>
				<th>승인여부</th>
			</tr>
			<c:forEach items="${ MeetingRoomList }" var="list" varStatus="loop" >
				<tr class="table-dark4" style="font-size: 20px;" align="center">
				<c:if test="${not(list.status eq 'Confirm' or list.status eq 'Reject')}">
					<td>
						<input type="checkbox" class="form-check-input">
					</td>
				</c:if>
				
				<c:if test="${(list.status eq 'Confirm' or list.status eq 'Reject')}">
					<td>&nbsp;</td>
				</c:if>
					<td>${ list.team }</td>
					<td>${ list.empNum }</td>
					<td>${ list.name }</td>
					<td>${ list.meetingroomNum }</td>
					<td>${ list.date }</td>
					<td>${ list.status }</td>
				</tr>

			</c:forEach>
		</table>
	</div>

</body>
</html>