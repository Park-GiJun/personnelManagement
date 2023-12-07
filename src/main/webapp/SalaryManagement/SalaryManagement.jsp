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
<title>SalaryManagement</title>
<style> /* 공통 스타일 */
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
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

.none {
	width: 85%;
	height: 200px;
	position: relative;
	left: 5%;
	background: red;
	left: 5%;
}

.salary_table_header {
	font-size: 25px;
}

.salary_table_background {
	background-color: gray;
	width: 85%;
	height: 80%;
	position: relative;
	top: 10%;
	left: 5%;
}

.salary_table {
	font-size: 30px;
	text-align: center;
	width: 100%;
	height: 100%;
	border-collapse: collapse;
	width: 100%;
}
</style>
<script>
	function handleChange() {
		var selectedTeam = document.getElementById("selectTeam").value;
		window.location.href = "SalaryManagement.do?selectTeam=" + selectedTeam;
	}

	function openModifyWindow(team, name, emp_num, emp_grade, pay, total_pay,
			incentive, holiday_pay, extra_work_pay) {
		var detailsUrl = "../SalaryManagement/EmployeeDetails.jsp" + "?team=" + team + "&name="
				+ name + "&emp_num=" + emp_num + "&emp_grade=" + emp_grade
				+ "&pay=" + pay + "&total_pay=" + total_pay + "&incentive="
				+ incentive + "&holiday_pay=" + holiday_pay
				+ "&extra_work_pay=" + extra_work_pay;

		window.open(detailsUrl, "_blank", "width=600, height=400");
	}
</script>
</head>
<body>
	<jsp:include page="../MainPage/Left.jsp" />
	<div class="content">
		<div class="none">
			<select
				id="selectTeam"
				name="selectTeam"
				onchange="handleChange()"
			>
				<option value="기본">팀선택</option>
				<option value="전체">전체</option>
				<option value="인사">인사</option>
				<option value="디자인">디자인</option>
				<option value="개발">개발</option>
			</select>
		</div>
		<div class="salary_table_background">
			<table
				border="1"
				class="salary_table"
			>
				<tr>
					<td>부서</td>
					<td>이름</td>
					<td>사번</td>
					<td>직급</td>
					<td>기본급</td>
					<td>총 인센티브</td>
					<td>성과급</td>
					<td>추가급</td>
					<td>추가근무수당</td>
				</tr>
				<c:choose>
					<c:when test="${ empty salaryEMPList } ">
						<tr>
							<td
								colspan="9"
								align="center"
							>정보 없음</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach
							items="${salaryEMPList}"
							var="EMPLists"
							varStatus="loop"
						>
							<tr
								align="center"
								onclick="openModifyWindow('${EMPLists.team}', '${EMPLists.name}', '${EMPLists.emp_num}', '${EMPLists.emp_grade}', '${EMPLists.pay}', '${EMPLists.total_pay}', '${EMPLists.incentive}', '${EMPLists.holiday_pay}', '${EMPLists.extra_work_pay}')"
							>
								<td>${EMPLists.team}</td>
								<td>${EMPLists.name}</td>
								<td>${EMPLists.emp_num}</td>
								<td>${EMPLists.emp_grade}</td>
								<td>${EMPLists.pay}</td>
								<td>${EMPLists.total_pay}</td>
								<td>${EMPLists.incentive}</td>
								<td>${EMPLists.holiday_pay}</td>
								<td>${EMPLists.extra_work_pay}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div>

</body>
</html>