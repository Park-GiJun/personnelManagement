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
	width: 98%;
	height: 200%;
	font-size: 200%;
	border-radius: 30px;
}

.btn-info {
	width: 98%;
	font-size:200%;
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
	background-color: rgb(54, 60, 67);;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark3 {
	background-color: rgb(68, 74, 83);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

/* 부서 버튼 위치 수정 */
.middle-Team_btn-container {
	position: relative;
	margin-top: 2.5%;
	margin-left: 50%;
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
	background-color: #fff;
	border-color: #5bc0de;
	outline: 0;
	box-shadow: 0 0 0 0.15rem rgba(255, 255, 255);
}

.form-select {
	padding: 0rem 0rem 0rem 3rem;
	height: 80%;
}

.form-control {
	padding: 0rem 0rem;
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
	width: 100%;
	height: 100%;
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
	background-color: #272b30;
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
			<div class="form-check">
				<label>
					<select id="department_search" name="department_search" size="1" style="width: 100%; height: 100%;" class="form-select" onchange="submitForm()">
							<option value="전체">선택해주세요.</option>
							<option value="전체">전체</option>
							<option value="개발">개발팀전체</option>
							<option value="개발 1팀">개발 1팀</option>
							<option value="개발 2팀">개발 2팀</option>
							<option value="개발 3팀">개발 3팀</option>
							<option value="">------</option>
							<option value="인사">인사팀전체</option>
							<option value="인사 1팀">인사 1팀</option>
							<option value="인사 2팀">인사 2팀</option>
							<option value="인사 3팀">인사 3팀</option>
							<option value="">------</option>
							<option value="디자인">디자인팀전체</option>
							<option value="디자인 1팀">디자인 1팀</option>
							<option value="디자인 2팀">디자인 2팀</option>
							<option value="디자인 3팀">디자인 3팀</option>
					</select>
				</label>
			</div>
		</form>

		<!-- ---------------------------------------------------------------------------------------------------------------- -->

		<form name="vacation_form" method="post"
			action="../Controller/NewRegist.do" accept-charset="UTF-8">

			<!-- 신입사원 등록 양식 -->
			<div class="middle-NewRegist-container">
				<div class="table-container">
					<table border="1" width="98%" height="26%">
						<tr align="center" class="table-dark1">
							<th colspan='5' align="center" scope="row">신입사원 정보 등록</th>
						</tr>
						<tr align="center" class="table-dark2">
							<td width="25" scope="row">이름</td>
							<td width="25">사번(아이디)</td>
							<td width="25">직급</td>
							<td width="25" colspan='2'>부서</td>
						</tr>
						<tr class="table-dark3">
							<th align="center" width="20%" height="100%" scope="row">
								<input type="text" class="form-control" name="name" placeholder="이름" style="width: 90%; height: 80%; box-sizing: border-box; text-align: center;">
							</th>
							<th align="center" width="20%">
								<input type="text" class="form-control" name="emp_num" placeholder="사번" style="width: 90%; height: 80%; box-sizing: border-box; text-align: center;">
							</th>

							<th align="center" width="20%">
								<select id="emp_grade" name="emp_grade" size="1" style="width: 90%;" class="form-select">
									<option value="">선택하세요.</option>
									<option value="임원">임원</option>
									<option value="부장">부장</option>
									<option value="팀장">팀장</option>
									<option value="대리">대리</option>
									<option value="사원">사원</option>
							</select>
							</th>

							<th align="center" width="20%">
								<select id="team" name="team" size="1" style="width: 90%;" class="form-select">
									<option value="">선택하세요.</option>
									<option value="인사">인사</option>
									<option value="개발">개발</option>
									<option value="디자인">디자인</option>
								</select>
							</th>
							
							<th align="center" width="20%">
								<select id="team_num" name="team_num" size="1" style="width: 90%;" class="form-select">
									<option value="">선택하세요.</option>
									<option value="1팀">1팀</option>
									<option value="2팀">2팀</option>
									<option value="3팀">3팀</option>
								</select>
							</th>
						</tr>
					</table>

					<div class="middle-button-container">
						<button type="submit" class="btn-info" name="NewRegistType"
							value="NewRegist" onclick="validateForm()">정보등록</button>
					</div>
					
					<!-- ---------------------------------------------------------------------------------------------------------------- -->

					<!-- 사원 정보 수정 -->
					<div class="Edit-table-container">
						<table border="1" width="98%" height="26%">
							<tr align="center" class="table-dark1">
								<th colspan='4' scope="row">사원 정보 수정</th>
							</tr>
							<tr align="center" class="table-dark2">
								<td width="25" scope="row">이름</td>
								<td width="25">사번(아이디)</td>
								<td width="25">직급</td>
								<td width="25" colspan='2'>부서</td>
							</tr>
							<tr class="table-dark3">
								<th align="center" width="20%" height="100%" scope="row">
									<input type="text" class="form-control" name="nameinfo" placeholder="이름" style="width: 90%; height: 80%; text-align: center;" readonly="readonly">
								</th>

								<th align="center" width="20%" height="100%">
									<input type="text" class="form-control" name="emp_numinfo" placeholder="사번" style="width: 90%; height: 80%; text-align: center;" readonly="readonly">
								</th>

								<th align="center" width="20%" height="100%">
									<select id="emp_grade_Edit"	name="emp_grade_Edit" size="1" style="width: 90%;" class="form-select">
										<option value="">선택하세요.</option>
										<option value="임원">임원</option>
										<option value="부장">부장</option>
										<option value="팀장">팀장</option>
										<option value="대리">대리</option>
										<option value="사원">사원</option>
									</select>
								</th>

								<th align="center" width="20%" height="100%">
									<select id="team_Edit"	name="team_Edit" size="1" style="width: 90%;" class="form-select">
										<option value="">선택하세요.</option>
										<option value="인사">인사</option>
										<option value="개발">개발</option>
										<option value="디자인">디자인</option>
									</select>
								</th>
								
								<th align="center" width="20%">
								<select id="team_num_Edit" name="team_num_Edit" size="1" style="width: 90%;" class="form-select">
									<option value="">선택하세요.</option>
									<option value="1팀">1팀</option>
									<option value="2팀">2팀</option>
									<option value="3팀">3팀</option>
								</select>
							</th>
							</tr>
						</table>

						<div class="middle-button-container">
							<button type="submit" class='btn-info' name="NewRegistType" value="Edit" onclick="validate_Edit_Form()">정보수정</button>
						</div>
					</div>

					<!-- ---------------------------------------------------------------------------------------------------------------- -->

				</div>

				<div class="table-container">
					<table border="1" width="98%">
						<tr align="center" class="table-dark1">
							<th colspan='5' scope="row">사원 리스트</th>
						</tr>
						<tr align="center" align="center" class="table-dark2">
							<th width="10%" scope="row"></th>
							<th width="15%">이름</th>
							<th width="15%">사번</th>
							<th width="20%">직급</th>
							<th width="20%" colspan='2'>부서</th>
						</tr>
						<c:choose>
							<c:when test="${empty selectList}">
								<!-- 사원이 없을 때 -->
								<tr class="table-dark3">
									<td colspan="5" align="center" scope="row">해당 부서에는 사원이 존재하지 않습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<!-- 사원이 있을 때 -->
								<c:forEach items="${selectList}" var="row" varStatus="loop">
									<tr align="center" class="table-dark3">
										<td align="center" scope="row" width="10%">
											<label>
												<input type="radio"	name="department_edit" value="info" class="form-check-input"
													onclick="infosubmitForm('${row.name}', '${row.emp_num}')">
											</label>
										</td>
										<td width="15%">${row.name}</td>
										<td width="15%">${row.emp_num}</td>
										<td width="20%">${row.emp_grade}</td>
										<td width="10%">${row.team}</td>
										<td width="10%">${row.team_num}</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</table>
				<!-- ---------------------------------------------------------------------------------------------------------------- -->
					<script>
						//리스트정보 받아서 정보수정부분에 입력
						function infosubmitForm(nameinfo, emp_numinfo) {
							// "사원 정보 수정" 테이블의 필드에 값을 채우기
							document.forms["vacation_form"]["nameinfo"].value = nameinfo;
							document.forms["vacation_form"]["emp_numinfo"].value = emp_numinfo;
						}
						
						// 정보 등록
						function validateForm() {
							var emp_grade = document.getElementById("emp_grade").value;
							var team = document.getElementById("team").value;
							var team_num = document.getElementById("team_num").value;

							if (emp_grade === "" || team === "" || team_num === "") {
								alert("직급 또는 부서를 선택해주세요.");
							} else {
								// 폼 제출 로직 추가 (예: document.forms["vacation_form"].submit();)
								document.forms["vacation_form"].submit();
								alert("사원정보가 등록 되었습니다..");
							}
						}
						
						// 정보 수정
						function validate_Edit_Form() {
							var emp_grade_Edit = document.getElementById("emp_grade_Edit").value;
							var team_Edit = document.getElementById("team_Edit").value;
							var team_num_Edit = document.getElementById("team_num_Edit").value;

							if (emp_grade_Edit === "" || team_Edit === "" || team_num_Edit === "") {
								alert("직급 또는 부서를 선택해주세요.");
							} else {
								// 폼 제출 로직 추가 (예: document.forms["vacation_form"].submit();)
								document.forms["vacation_form"].submit();
								alert("사원정보가 수정 되었습니다..");
							}
						}
						
					    // 부서별 사원 검색
					    function submitForm() {
					        document.forms["team_form"].submit();
					    }
					</script>
				</div>
			</div>
		</form>
	</div>
</body>
</html>