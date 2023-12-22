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
<title>Share Form Write</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<style>
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
	position: relative;
	padding: 20px;
	max-height: 100%;
}

.btn-info {
	margin-top:1%;
	margin-bottom: 0.5%;
	font-size: 17.5px;
	height: 100%;
	border-radius: 25px;
	width: 15%;
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

.form-control {
	margin-top: 0.5%;
	width: 400px;
	height: 10px;
}
#file {
	padding: 0.25rem 1rem;
	font-size: 15px;
	height: 30px;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}
</style>
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
				if (form.sharecontent.value == null
						|| form.sharecontent.value.trim() === "") {
					alert("내용을 입력하세요");
					form.sharecontent.focus();
					return false;
				}

				if (form.shareOfile.value == null
						|| form.shareOfile.value.trim() === "") {
					alert("첨부파일을 추가해주세요.");
					return false;
				}
			}
		</script>
		<form name="shareFrame" method="post" enctype="multipart/form-data"	action="../Controller/ShareWrite.do" onsubmit="return validateForm(this)">
			<table align="center" border="1" height="80%" width="98%" class="table-dark2">
				<tr>
					<td>
						<input type="text" placeholder="제목을 입력해 주세요."	name="sharetitle" style="width: 98%; margin-left:1%;" class="form-control"
							onfocus="clearDefaultText(this)" onblur="restoreDefaultText(this)"/>
					</td>
				</tr>
				<tr>
					<td>
						<input class="form-control" type="file" id="file" name="shareOfile" style="margin-left:1%;">
					</td>
				</tr>
				<tr>
					<td style="text-align: left; font-size: 15px; display: flex; align-items: center; margin-left: 1%;">
						<input type="password" name="sharepassword" class="form-control" placeholder="Password">
						<button	type="button" onclick="location.href='../Controller/sharelist.do';" class="btn-info">목록</button>
						<button type="submit" class="btn-info">작성완료</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
