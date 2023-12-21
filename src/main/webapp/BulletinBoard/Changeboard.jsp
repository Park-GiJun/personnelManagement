<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Changeboard</title>
<style>
@font-face {
	font-family: 'ChungjuKimSaengTTF';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/ChungjuKimSaengTTF.woff2')
		format('woff2');
	font-weight: normal;
	font-style: normal;
	font-family: 'ChungjuKimSaengTTF', sans-serif;
}

@font-face {
	font-family: 'SF_HambakSnow';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2106@1.1/SF_HambakSnow.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
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
	margin-left: 200px; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 10px; /*넓이*/
	font-size: 12px; /*글자사이즈*/
	min-height: 400px; /* Set a minimum height for the content area */
}

td, th {
	border: 1px solid gray; /* 테두리 스타일 지정 */
	padding: 1px; /* 셀 안의 내용과 테두리 사이의 간격 조정 */
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.btn-info {
	margin-top: 0.25%;
	width: 10%;
	font-size: 15px;
	height: 30px;
	border-radius: 20px;
}

.form-control {
	margin-left: 0.5%;
	margin-top: 0.5%;
	width: 20%;
	height: 10px;
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
	background-color: rgb(54, 60, 67);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark3 {
	background-color: rgb(68, 74, 83);
	--bs-table-color: #fff;
	--bs-table-border-color: #fff;
	color: var(--bs-table-color);
	border-color: var(--bs-table-border-color);
}

.table-dark4 {
	background-color: rgb(54, 60, 67);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark4:nth-child(odd) {
	background-color: rgb(49, 55, 62);
}

.form-select {
	padding: 0rem 0rem 0rem 3rem;
	margin-top: 0.5%;
	width: 100px;
}

#delete {
	width: 75%;
	font-size: 7px;
	background: #fff;
}

#btn2 {
	width: 100%;
	font-size: 10px;
	background: #fff;
}
</style>
<jsp:include page="../MainPage/Left.jsp" />
<script>
	function clearDefaultText(input) {
		if (input.value === input.defaultValue) {
			input.value = '';
		}
	}

	function restoreDefaultText(input) {
		if (input.value === '') {
			input.value = input.defaultValue;
		}
	}
</script>
</head>
<body>
	<div class="content">
		<!-- 다른 페이지에서 불러오는 내용 -->
		<script type="text/javascript">
			function validateForm(form) {
				if (form.Freeboardtitle.value == null
						|| form.Freeboardtitle.value.trim() === "") {
					alert("제목을 입력해주세요.");
					return false;
				}
				if (form.Freeboardcontent.value == null
						|| form.Freeboardcontent.value.trim() === "") {
					alert("내용을 입력하세요");
					return false;
				}
				if (form.Freeboardpassword.value == null
						|| form.Freeboardpassword.value.trim() === "") {
					alert("비밀 번호를 입력해주세요.");
					return false;
				}

				// 작성 완료 메시지
				alert("수정 완료되었습니다");
				// 페이지 이동
				window.location.href = "/Controller/CommentsController.do";
			}
		</script>
		<form method="post" action="../Controller/CrystalController.do" onsubmit="return validateForm(this)">
			<table align="center" border="1" height="80%" width="90%">
				<tr class="table-dark1" align="center">
					<th width="20%">번호</th>
					<th width="20%">${dto.anno_board_num}</th>
					<th width="25%">작성일</th>
					<th width="25%">${dto.post_date}</th>
				</tr>

				<tr class="table-dark1" align="center">
					<td width="20%">제목</td>
					<td colspan="4"><input type="text" value="${dto.title}" name="Freeboardtitle" style="width: 100%;" onfocus="clearDefaultText(this)" onblur="restoreDefaultText(this)" /></td>
				</tr>

				<tr class="table-dark3" align="center">
					<td width="20%">내용</td>
					<td colspan="4"><input type="text" value="${dto.content}" name="Freeboardcontent" style="width: 100%; height: 800px;"></td>
				</tr>
			</table>
			<table border="1" width="90%">
				<tr class="table-dark1">
					<td style="text-align: left; font-size: 15px; display: flex; align-items: center;">비밀번호 <input type="text" name="Freeboardpassword" class="form-control" width="40%" />
						<button type="button" onclick="location.href='../Controller/FreeboardList.do';" class="btn-info" style="margin-left: 54%;">목록</button>
						<button type="submit" class="btn-info">수정완료</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
