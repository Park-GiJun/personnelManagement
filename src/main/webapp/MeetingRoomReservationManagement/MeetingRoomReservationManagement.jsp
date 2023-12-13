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
<title>Insert title here</title>
<style type="text/css">
.content {
	margin-left: 10%; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
	font-size: 12px;
}

.listTable {
	top: 20%;
	width: 100%;
	border-collapse: collapse;
	width: 100%;
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

		<table
			border="1"
			class="listTable"
			align="center"
		>
			<tr>
				<th></th>
				<th>팀</th>
				<th>사번</th>
				<th>이름</th>
				<th>회의실</th>
				<th>일자</th>
				<th>승인여부</th>
			</tr>
			<c:forEach
				items="${ MeetingRoomList }"
				var="list"
				varStatus="loop"
			>
				<tr>
					<td>
						<input type="checkbox">
					</td>
					<td>${ list.team }</td>
					<td>${ list.empNum }</td>
					<td>${ list.name }</td>
					<td>${ list.meetingroomNum }</td>
					<td>${ list.date }</td>
					<td>${ list.status }</td>
				</tr>

			</c:forEach>
		</table>
		<div class="buttons">
			<button
				type="button"
				onclick="confirmAction()"
			>승인</button>
			<button
				type="button"
				onclick="rejectAction()"
			>거절</button>
		</div>
	</div>

</body>
</html>