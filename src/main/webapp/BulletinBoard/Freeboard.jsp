<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Freeboard</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<style>
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
/* 공통 스타일 */
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-size: 16px;
	font-family: 'ChungjuKimSaengTTF', sans-serif;
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
	margin-left: 200px; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
	font-size: 12px;
	min-height: 400px; /* Set a minimum height for the content area */
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

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
	width: 99%;
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
	padding: 0rem 0rem 0rem 3rem;
	margin-top: 0.5%;
	width: 100px;
}

#listSearch {
	margin-top: 0.4%;
	margin-left: 0%;
	margin-bottom: 0%;
	width: 100px;
	font-size: 15px;
	height: 30px;
	width: 100px;
}

#Freeboardpassword {
	width: 10%;
	text-align: center;
	margin-bottom: 0.5%;
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
				alert("작성 완료되었습니다");

				// 페이지 이동
				window.location.href = '../BulletinBoard/Comments.jsp';

			}
		</script>
		<form method="post" action="../Controller/FreeboardWrite.do"
			onsubmit="return validateForm(this)">
			<table border="1" width="100%">
				<tr>
					<td>
						<input type="text" name="Freeboardtitle" class="form-control" placeholder="제목"
							onfocus="clearDefaultText(this)" onblur="restoreDefaultText(this)"/>
					</td>
				</tr>

				<tr>
					<td><input type="text" name="Freeboardcontent" style="height: 590px;" class="form-control" placeholder="내용"></td>
				</tr>

				<tr>
					<td colspan="3"	style="text-align: left; font-size: 15px; display: flex; align-items: center;">
							<input type="password" placeholder="Password" name="Freeboardpassword" class="form-control" id="Freeboardpassword"
								onfocus="clearDefaultText(this)" onblur="restoreDefaultText(this)" />

						<button type="button" onclick="location.href='../Controller/FreeboardList.do';"	class="btn-info" style="margin-left: 69%;">목록</button>
						<button type="submit" class="btn-info">작성완료</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>