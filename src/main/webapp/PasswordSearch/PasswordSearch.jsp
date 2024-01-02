<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	width: 100%;
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

button {
	margin-top: 2%;
}

.btn-light {
	width: 180px;
	height: 80px;
	border-radius: 25px;
}

.form-control {
	width: 400px;
	height: 55px;
	border-radius: 15px;
}

.form-select {
	margin-bottom: 3%;
}
</style>
</head>
<body>
	<form name="Password_form" method="post" action="../Controller/PasswordSearch.do">
		<h1>Password Search</h1>

		<input type="text" class="form-control" name="login_Id"	placeholder="User ID">
		
		<input type="Password" class="form-control" name="Password" placeholder="Password">

		<input type="Password" class="form-control" name="Check_Password" placeholder="Check Password">

		<button type="button" class="btn-light" value="비밀번호 변경" onclick="PassForm()">Password Change</button>

		<script>
			function PassForm() {
				console.log("PassForm 함수 호출");
				
				var login_Id = document.forms["Password_form"]["login_Id"].value;
		        var Password = document.forms["Password_form"]["Password"].value;
		        var Check_Password = document.forms["Password_form"]["Check_Password"].value;

				if (Password === Check_Password) {
					document.forms["Password_form"].submit();
					alert("비밀번호가 변경되었습니다.");
				} else {
					alert("비밀번호가 일치하지 않습니다.");
					document.forms["Password_form"]["Check_Password"].focus();
				}
			}
		</script>
	</form>
</body>
</html>