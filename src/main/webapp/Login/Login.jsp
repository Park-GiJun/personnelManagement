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
<style>
body {
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100vh;
	margin: 0;
}

form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

input {
	margin-bottom: 10px;
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
	<form
		name="login_form"
		method="post"
		action="../Controller/login.do"
		onsubmit="return checkLogin(this)"
	>
		<input
			type="text"
			name="login_Id"
			style="width: 400px; height: 80px;"
		/>

		<input
			type="password"
			name="login_Pwd"
			style="width: 400px; height: 80px;"
		/>

		<input
			type="submit"
			value="로그인"
			style="width: 180px; height: 80px;"
		/>
	</form>
	<%
	}
	%>
</body>
</html>
