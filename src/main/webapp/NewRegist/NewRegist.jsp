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
	width: 98%;
	height: 200%;
	font-size: 200%;
	border-radius: 30px;
}

/* 부서 버튼 위치 수정 */
.middle-Team_btn-container {
	position: relative;
	margin-top: 2.5%;
	margin-left: 50%;
}

/* 정보등록 버튼 위치 수정 */
.middle-button-container {
	position: relative;
	margin-top: 2%;
	margin-left: 0%;
}

.Edit-table-container {
	position: relative;
	margin-top: 10%;
	margin-left: 0%;
}

.middle-NewRegist-container {
	display: flex;
	justify-content: space-between;
}

.table-container {
	width: 100%;
}

/* 사원 추가 위치 수정 */
.middle-NewRegist-container {
	position: relative;
	margin-top: 1%;
	margin-left: 0%;
	margin-right: 0%;
	font-size: 150%;
}

/* 사원 리스트 위치 수정 */
.middle-Employee_List-container {
	position: relative;
	margin-top: 0%;
	margin-left: 51%;
	font-size: 150%;
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

		<form name="team_form" method="post"
			action="../Controller/NewRegistTeamSearch.do" accept-charset="UTF-8">
			<div class="middle-Team_btn-container">
				<label> <input type="radio" name="department_search"
					value="전체" onclick="submitForm()">전체
				</label> <label> <input type="radio" name="department_search"
					value="개발" onclick="submitForm()">개발
				</label> <label> <input type="radio" name="department_search"
					value="인사" onclick="submitForm()">인사
				</label> <label> <input type="radio" name="department_search"
					value="디자인" onclick="submitForm()">디자인
				</label>
			</div>
		</form>

		<script>
			function submitForm() {
				document.forms["team_form"].submit();
			}
		</script>

		<!-- ---------------------------------------------------------------------------------------------------------------- -->

		<form name="vacation_form" method="post"
			action="../Controller/NewRegist.do" accept-charset="UTF-8">

			<!-- 신입사원 등록 양식 -->
			<div class="middle-NewRegist-container">
				<div class="table-container">
					<table border="1" width="98%">
						<tr>
							<th colspan='4'>신입사원 정보 등록</th>
						</tr>
						<tr align="center">
							<th width="25">이름</th>
							<th width="25">사번(아이디)</th>
							<th width="25">직급</th>
							<th width="25">부서</th>
						</tr>
						<tr>
							<td align="center"><input type="text" name="name"
								style="width: 90%; box-sizing: border-box; text-align: center;">
							</td>
							<td align="center"><input type="text" name="emp_num"
								style="width: 90%; box-sizing: border-box; text-align: center;">
							</td>

							<td align="center"><input type="text" name="emp_grade"
								style="width: 90%; box-sizing: border-box; text-align: center;">
							</td>

							<td align="center"><input type="text" name="team"
								style="width: 90%; box-sizing: border-box; text-align: center;">
							</td>
						</tr>
					</table>

					<div class="middle-button-container">
						<button type="submit" class='my_btn'>정보등록</button>
					</div>

					<!-- ---------------------------------------------------------------------------------------------------------------- -->

					<!-- 사원 정보 수정 -->
					<div class="Edit-table-container">
						<table border="1" width="98%">
							<tr>
								<th colspan='4'>사원 정보 수정</th>
							</tr>
							<tr align="center">
								<th width="25">이름</th>
								<th width="25">사번(아이디)</th>
								<th width="25">직급</th>
								<th width="25">부서</th>
							</tr>
							<tr>
								<td align="center" width="25%">
									<input name="nameinfo" readonly="readonly" style="text-align: center;">
								</td>

								<td align="center" width="25%">
									<input name="emp_numinfo" readonly="readonly" style="text-align: center;">
								</td>

								<td align="center" width="25%"><input type="text"
									name="emp_grade"
									style="width: 90%; box-sizing: border-box; text-align: center;">
								</td>

								<td align="center" width="25%"><input type="text"
									name="team"
									style="width: 90%; box-sizing: border-box; text-align: center;">
								</td>
							</tr>
						</table>

						<div class="middle-button-container">
							<button type="submit" class='my_btn'>정보수정</button>
						</div>
					</div>

					<!-- ---------------------------------------------------------------------------------------------------------------- -->

				</div>

				<div class="table-container">
					<table border="1" width="98%">
						<tr>
							<th colspan='5'>사원 리스트</th>
						</tr>
						<tr align="center">
							<th width="20"></th>
							<th width="30">이름</th>
							<th width="10">사번</th>
							<th width="20">직급</th>
							<th width="20">부서</th>
						</tr>
						<c:choose>
							<c:when test="${empty selectList}">
								<!-- 사원이 없을 때 -->
								<tr>
									<td colspan="4" align="center">회사가 망했나?</td>
								</tr>
							</c:when>
							<c:otherwise>
								<!-- 사원이 있을 때 -->
								<c:forEach items="${selectList}" var="row" varStatus="loop">
									<tr align="center">
										<td align="center"><label> <input type="radio"
												name="department_edit" value="info"
												onclick="infosubmitForm('${row.name}', '${row.emp_num}')">
										</label></td>
										<td>${row.name}</td>
										<td>${row.emp_num}</td>
										<td>${row.emp_grade}</td>
										<td>${row.team}</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</table>

					<script>
						function infosubmitForm(nameinfo, emp_numinfo) {
							// "사원 정보 수정" 테이블의 필드에 값을 채우기
							document.forms["vacation_form"]["nameinfo"].value = nameinfo;
							document.forms["vacation_form"]["emp_numinfo"].value = emp_numinfo;
						}
					</script>
				</div>
			</div>
		</form>
	</div>
</body>
</html>