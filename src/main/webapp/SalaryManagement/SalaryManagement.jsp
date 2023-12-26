<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SalaryManagement</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<style> /* 공통 스타일 */
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

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-size: 16px;
}

.btn-info {
	margin-top: 7px;
	width: 7%;
	font-size: 20px;
	height: 80%;
	border-radius: 25px;
}

.table-info {
	background-color: #5bc0de;
}

.table-dark1 {
	font-size: 25px;
	text-align: center;
	height: 100%;
	border-collapse: collapse;
	width: 100% background-color: #272b30;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark2 {
	font-size: 170%;
	background-color: rgb(54, 60, 67);;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark3 {
	background-color: rgb(68, 74, 83);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.form-select {
	margin-top: 10px;
	margin-right: 10px;
	height: 30px;
	width: 10%;
	padding: 0rem 0rem 0rem 1rem;
	background-position: right 1rem center;
}

.form-select-option {
	background-color: rgb(222.5,222.5,222.5);
}

td {
	border: 1px solid gray; /* 테두리 스타일 지정 */
	padding: 1px; /* 셀 안의 내용과 테두리 사이의 간격 조정 */
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
	margin-left: 5%; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
	font-size: 12px;
	font-family: 'ChungjuKimSaengTTF', sans-serif;
}

.none {
	font-size: 30px;
	display: flex;
	width: 85%;
	position: relative;
	left: 5%;
	left: 5%;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.salary_table_header {
	font-size: 25px;
}

.salary_table_background {
	background-color: gray;
	width: 95%;
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
		var selectedYear = document.getElementById("yearSelect").value;
		var selectedMonth = document.getElementById("monthSelect").value;
		window.location.href = "SalaryManagement.do?selectTeam=" + selectedTeam
				+ "&selectedYear=" + selectedYear + "&selectedMonth="
				+ selectedMonth;
	}

	function openModifyWindow(team, name, emp_num, emp_grade, pay, total_pay,
			incentive, holiday_pay, extra_work_pay, yearmonth) {
		var detailsUrl = "../SalaryManagement/EmployeeDetails.jsp" + "?team="
				+ team + "&name=" + name + "&emp_num=" + emp_num
				+ "&emp_grade=" + emp_grade + "&pay=" + pay + "&total_pay="
				+ total_pay + "&incentive=" + incentive + "&holiday_pay="
				+ holiday_pay + "&extra_work_pay=" + extra_work_pay
				+ "&yearmonth=" + yearmonth;

		window.open(detailsUrl, "_blank", "width=600, height=420");
	}

	function populateYears() {
		var yearSelect = document.getElementById("yearSelect");
		var currentYear = new Date().getFullYear();

		for (var year = currentYear; year >= currentYear - 10; year--) {
			var option = document.createElement("option");
			option.value = year;
			option.text = year;
			yearSelect.add(option);
		}
	}

	function populateMonths() {
		var monthSelect = document.getElementById("monthSelect");

		for (var month = 1; month <= 12; month++) {
			var monthText = month < 10 ? '0' + month : '' + month;
			var option = document.createElement("option");
			option.value = monthText;
			option.text = monthText;
			monthSelect.add(option);
		}

	}

	// Call the functions to populate year and month select boxes
	document.addEventListener('DOMContentLoaded', function() {
		populateYears();
		populateMonths();
	});
</script>
</head>
<body>
	<jsp:include page="../MainPage/Left.jsp" />
	<div class="content">
		<div class="none">
			<select id="selectTeam" name="selectTeam" class="form-select">
			
				<optgroup label="전체/임원"  class="form-select-option">
					<option value="전체">전체</option>
					<option value="임원">임원급</option>
				</optgroup>
				
				<optgroup label="인사팀">
					<option value="인사">전체</option>
					<option value="인사 1팀">1팀</option>
					<option value="인사 2팀">2팀</option>
					<option value="인사 3팀">3팀</option>
				</optgroup>
				
				<optgroup label="디자인팀"  class="form-select-option">
					<option value="디자인">전체</option>
					<option value="디자인 1팀">1팀</option>
					<option value="디자인 2팀">2팀</option>
					<option value="디자인 3팀">3팀</option>
				</optgroup>
				
				<optgroup label="개발팀">
					<option value="개발">전체</option>
					<option value="개발 1팀">1팀</option>
					<option value="개발 2팀">2팀</option>
					<option value="개발 3팀">3팀</option>
				</optgroup>
			</select>
			<label for="yearSelect">연도:</label>
				<select id="yearSelect" name="yearSelect" class="form-select" style="margin-left: 10px"></select>
			<label for="monthSelect">월:</label>
				<select id="monthSelect" name="monthSelect" class="form-select" style="margin-left: 10px">
				<option value="전체">전체</option>
			</select>

			<button class="btn-info" onclick="handleChange()">검색</button>
		</div>
		<div class="salary_table_background">
			<table border="1">
				<tr class="table-dark1">
					<td colspan="2">부서</td>
					<td>이름</td>
					<td>사번</td>
					<td>직급</td>
					<td>기본급</td>
					<td>총 인센티브</td>
					<td>성과급</td>
					<td>추가급</td>
					<td>추가근무수당</td>
					<td>날짜</td>
				</tr>
				<c:choose>
					<c:when test="${ empty salaryEMPList } ">
						<tr class="table-dark2">
							<td colspan="9" align="center">정보 없음</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${salaryEMPList}" var="EMPLists"
							varStatus="loop">
							<tr align="center" class="table-dark2"
								onclick="openModifyWindow('${EMPLists.team}', '${EMPLists.name}', '${EMPLists.emp_num}', '${EMPLists.emp_grade}', '${EMPLists.pay}', '${EMPLists.total_pay}', '${EMPLists.incentive}', '${EMPLists.holiday_pay}', '${EMPLists.extra_work_pay}', '${EMPLists.yearmonth}')">

								<td width="6%">${EMPLists.team}</td>
								<td width="6%">${EMPLists.team_num}</td>
								<td width="6%">${EMPLists.name}</td>
								<td width="7%">${EMPLists.emp_num}</td>
								<td width="7%">${EMPLists.emp_grade}</td>
								<td width="5%">${EMPLists.pay}</td>
								<td width="5%">${EMPLists.total_pay}</td>
								<td width="5%">${EMPLists.incentive}</td>
								<td width="5%">${EMPLists.holiday_pay}</td>
								<td width="5%">${EMPLists.extra_work_pay}</td>
								<td width="9%">${EMPLists.yearmonth }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div>
</body>
</html>
