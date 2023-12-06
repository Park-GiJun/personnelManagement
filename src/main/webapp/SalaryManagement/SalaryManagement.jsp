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
</head>
<body>
	<jsp:include page="../MainPage/Left.jsp" />
	<div class="content">
		<div class="none"></div>
		<div class="salary_table_background">
			<table
				border="1"
				class="salary_table"
			>
				<tr>
					<td>이름</td>
					<td>사번</td>
					<td>기본급</td>
					<td>총 인센티브</td>
					<td>성과급</td>
					<td>기본급</td>
					<td>추가근무수당</td>
				</tr>
				<tr>
					<td>류동규</td>
					<td>2023120401</td>
					<td>200</td>
					<td>300</td>
					<td>100</td>
					<td>100</td>
					<td>20</td>
			</table>
		</div>
	</div>

</body>
</html>