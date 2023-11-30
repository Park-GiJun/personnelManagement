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
<title>ShareForm</title>
</head>
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
	margin-left: 400px; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
}

/* 유니크한 클래스로 스타일 지정 */
.myHeader {
	color: blue;
	font-size: 24px;
}
</style>
<body>
	<jsp:include page="../MainPage/Left.jsp" />

	<div class="content">
		<!-- 다른 페이지에서 불러오는 내용 -->
		<h2 class="myHeader">텍스트 입력</h2>
	</div>


</body>

</html>