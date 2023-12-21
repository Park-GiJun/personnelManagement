<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
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
	font-family: 'intelone-mono-font-family-regular';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-1@1.1/intelone-mono-font-family-regular.woff2')
		format('woff2');
	font-weight: 400;
	font-style: normal;
}

body {
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100vh;
	margin: 0;
	background-color: #272b30
}

h1 {
	background-color: red;
	border-radius: 15px;
	margin-bottom: 3%;
	width: 110%;
	padding: 0.25rem 0rem 0.25rem 0rem;
	text-align: center;
	font-weight: 900;
	font-family: 'ChungjuKimSaengTTF', sans-serif;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

input {
	margin-bottom: 10px;
}

a {
	font-family: 'intelone-mono-font-family-regular', sans-serif;
	--bs-table-color: skyblue;
	color: var(--bs-table-color);
}

.btn-light {
	width: 180px;
	height: 80px;
	border-radius: 25px;
	font-family: 'intelone-mono-font-family-regular', sans-serif;
}

.form-control {
	width: 400px; `
	height: 80px;
	border-radius: 50px;
	font-family: 'intelone-mono-font-family-regular', sans-serif;
}
</style>
</head>
<body>
	<%
	if (session.getAttribute("login_id") == null) {
	%>
	<script type="text/javascript">
		function checkLogin(form) {
			if (!form.login_Id.value) {
				alert("아이디를 입력하세요.")
				form.loginId.focus();
				return false;
			}
		}
	</script>
	<form name="login_form" method="post" action="../Controller/login.do" onsubmit="return checkLogin(this)">
		<input type="text" class="form-control" name="login_Id" placeholder="ID"> <input type="password" class="form-control" name="login_Pwd" placeholder="Password">
		<button type="submit" class="btn-light" value="로그인">Login</button>
	</form>
	<%
	}
	%>
</body>
</html>