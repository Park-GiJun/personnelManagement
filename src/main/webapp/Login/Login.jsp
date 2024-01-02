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
<<<<<<< HEAD
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

=======
>>>>>>> 492c5fd 2023-12-21 11:27 휴가신청 페이지 팝업화 및 일정 달력으로 선택 / 폰트 변경 및 UI 개선
=======
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

>>>>>>> branch 'master' of https://github.com/Park-GiJun/personnelManagement.git
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
	text-decoration: none;
}

.btn-light {
	width: 180px;
	height: 80px;
<<<<<<< HEAD
	border-radius: 25px;<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	text-decoration: none;
}

.btn-light {
	width: 180px;
	height: 80px;
=======
>>>>>>> branch 'master' of https://github.com/Park-GiJun/personnelManagement.git
	border-radius: 25px;
	font-family: 'intelone-mono-font-family-regular', sans-serif;
}

.form-control {
<<<<<<< HEAD
	width: 400px;	`
=======
	width: 400px;
>>>>>>> branch 'master' of https://github.com/Park-GiJun/personnelManagement.git
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
		<h1>PersonnelManagement</h1>
	
		<input type="text" class="form-control" name="login_Id" placeholder="ID">

		<input type="password" class="form-control" name="login_Pwd" placeholder="Password">

		<button type="submit" class="btn-light"	value="로그인">Login</button>
		
	</form>
	<%
	}
	%>
<<<<<<< HEAD
</body>
</html>
}

.form-control {
	width: 400px;
	height: 80px;
	border-radius: 50px;
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
		<h1>PersonnelManagement</h1>
	
		<input type="text" class="form-control" name="login_Id" placeholder="ID">

		<input type="password" class="form-control" name="login_Pwd" placeholder="Password">

		<button type="submit" class="btn-light"	value="로그인">Login</button>
		
	</form>
	<%
	}
	%>
=======
>>>>>>> branch 'master' of https://github.com/Park-GiJun/personnelManagement.git
</body>
</html>