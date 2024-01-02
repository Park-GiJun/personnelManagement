<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

td {
	border: 1px solid gray; /* 테두리 스타일 지정 */
	padding: 1px; /* 셀 안의 내용과 테두리 사이의 간격 조정 */
}

/* 각 종류 버튼 스타일 */
.my_btn {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 25%;
	height: 300%;
	font-size: 200%;
	border-radius: 30px;
	height: 300%;
}

.form-check {
	display: flex; /* flex 컨테이너로 설정 */
	justify-content: space-between; /* 버튼 사이의 간격을 균등하게 조절 */
	position: relative;
	margin-top: 2.5%;
	margin-left: 50%;
	width: 15%;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.form-check-input {
	background-color: #5bc0de;
	border-color: #5bc0de;
	outline: 0;
	box-shadow: 0 0 0 0.15rem rgba(255, 255, 255);
}

.btn-info {
	width: 25%;
	font-size: 200%;
	height: 200%;
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
	font-size: 150%;
	background-color: rgb(54, 60, 67);;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark3 {
	font-size: 150%;
	background-color: rgb(68, 74, 83);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.btncontent {
	display: flex;
	justify-content: space-between;
	margin-left: 5px;
	margin-right: 5px;
}

.tablecontent {
	margin-top: 2%;
}

/* 공통 스타일 */
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
</style>
</head>
<body>
	<!-- 왼쪽 페이지 목록 -->
	<jsp:include page="../MainPage/Left.jsp" />
	<div class="content">

		<form name="HolidayApproval_form" method="post"
			action="../Controller/HolidayApprovalTrue.do" accept-charset="UTF-8">
			<div class="btncontent">
				<button type="submit" name="approvalType" value="true"
					class="btn-info">휴가승인</button>
				<button type="submit" name="approvalType" value="false"
					class="btn-info">휴가거절</button>
			</div>

			<div class="tablecontent">
				<table border="1" width="100%">
					<tr class="table-drak2" align="center"
						style="font-size: 150%; color: #fff;">
						<th width="5%" scope="row">&nbsp;</th>
						<td width="10%">이름</td>
						<td width="10%">사번</td>
						<td width="30%">휴가 일정</td>
						<td width="10%">직급</td>
						<td width="15%" colspan="2">부서</td>
						<td width="20%">승인 여부</td>
					</tr>
					<c:choose>
						<c:when test="${empty holidayapprovalList}">
							<!-- 게시물이 없을 때 -->
							<tr class="table-dark3">
								<td colspan="8" align="center" scope="row">신청된 휴가가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<!-- 게시물이 있을 때 -->
							<c:forEach items="${holidayapprovalList}" var="row"
								varStatus="loop">
								<tr align="center" class="table-dark3">
									<c:if
										test="${not (row.approval eq '승인 완료' or row.approval eq '승인 거절' or row.team_approval eq '승인 완료' or row.team_approval eq '승인 거절')}">
										<td scope="row" width="5%"><label>
										<input type="checkbox" name="department" value="${row.emp_num}, ${row.start_vacation}, ${row.end_vacation}, ${row.team}"
												class="form-check-input">
										</label></td>
									</c:if>
									<c:if
										test="${(row.approval eq '승인 완료' or row.approval eq '승인 거절' or row.team_approval eq '승인 완료' or row.team_approval eq '승인 거절')}">
										<td>&nbsp;</td>
									</c:if>
									<td width="10%">${row.name}</td>
									<td width="15%">${row.emp_num}</td>
									<td width="15%">${row.start_vacation}~${row.end_vacation}</td>
									<td width="10%">${row.emp_grade}</td>
									<!-- 이사 ~ 사원 까지 로그인시 -->
									<c:if test="${(grade > 1)}">
										<td width="10%">${row.team}</td>
										<td width="10%">${row.team_num }</td>
									</c:if>
									<!-- 사장 로그인시 -->
									<c:if test="${(grade eq '1')}">
										<td width="10%" colspan="2">${row.team}</td>
									</c:if>
									
									<td>
										<c:if test="${grade eq '4' or grade eq '2'}">
											${row.team_approval }
										</c:if>
										
										<c:if test="${grade eq '3' or grade eq '1'}">
											${row.approval }
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
		</form>

		<script>
			// 선택된 행의 데이터를 저장할 배열
			var selectedData = [];

			function handleCheckboxChange(checkbox, name, emp_num, vacation,
					empGrade, team, approval) {
				if (checkbox.checked) {
					// 체크박스가 체크되었을 때 행의 데이터를 객체로 생성하여 배열에 추가
					var rowData = {
						name : name,
						emp_num : emp_num,
						vacation : vacation,
						empGrade : empGrade,
						team : team,
						approval : approval
					};
					selectedData.push(rowData);
				} else {
					// 체크박스가 해제되었을 때 배열에서 제거
					var index = selectedData.findIndex(function(data) {
						return data.empNum === empNum;
					});
					if (index !== -1) {
						selectedData.splice(index, 1);
					}
				}
			}

			function submitForm() {
				// 수집된 값 확인 (선택된 체크박스들의 데이터가 배열에 들어감)
				console.log(selectedData);
			}
		</script>

	</div>
</body>
</html>