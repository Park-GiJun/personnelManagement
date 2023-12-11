<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
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

.btncontent {
	display: flex;
	justify-content: space-between;
	margin-left: 5px;
	margin-right: 5px;
}

.tablecontent {
	margin-top: 2%;
}

<
style> /* 공통 스타일 */ * {
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
				<button type="submit" class='my_btn' name="approvalType"
					value="true">휴가승인</button>
				<button type="submit" class='my_btn' name="approvalType"
					value="false">휴가거절</button>
			</div>

			<div class="tablecontent">
				<table border="1" width="100%">
					<tr>
						<th width="5%"></th>
						<th width="10%">이름</th>
						<th width="10%">사번</th>
						<th width="30%">휴가 일정</th>
						<th width="10%">직급</th>
						<th width="15%">부서</th>
						<th width="20%">승인 여부</th>
					</tr>
					<c:choose>
						<c:when test="${empty holidayapprovalList}">
							<!-- 게시물이 없을 때 -->
							<tr>
								<td colspan="2" align="center">신청된 휴가가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<!-- 게시물이 있을 때 -->
							<c:forEach items="${holidayapprovalList}" var="row"
								varStatus="loop">
								<tr align="center">
									<c:if test="${not (row.approval eq '승인 완료' or row.approval eq '승인 거절')}">
										<td><label>
										<input type="checkbox" name="department"
												value="${row.emp_num}, ${row.start_vacation}, ${row.end_vacation}, ${row.team}">
										</label></td>
									</c:if>
									<c:if
										test="${(row.approval eq '승인 완료' or row.approval eq '승인 거절')}">
										<td>&nbsp;</td>
									</c:if>

									<td>${row.name}</td>
									<td>${row.emp_num}</td>
									<td>${row.start_vacation}~${row.end_vacation}</td>
									<td>${row.emp_grade}</td>
									<td>${row.team}</td>
									<td>${row.approval}</td>
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