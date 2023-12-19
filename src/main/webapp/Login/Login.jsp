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
<title>Login</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<style>
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
	padding: 0rem 0rem 0.5rem 0rem;
	text-align: center;
	font-weight: 900;
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
	--bs-table-color: skyblue;
	color: var(--bs-table-color);
}

.btn-light {
	width: 180px;
	height: 80px;
	border-radius: 25px;
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
		
		<a href="../PasswordSearch/PasswordSearch.jsp">Forgot Password?</a>
	</form>
	<%
	}
	%>
</body>
</html>
