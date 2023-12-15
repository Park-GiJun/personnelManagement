<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<style type="text/css">
.content {
	margin-left: 10%; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
	font-size: 12px;
}

.sort_tab {
	width: 97.9%;
	background: rgb(72, 75, 79);
	align-content: center;
}

.Main {
	width: 86.1%;
	height: 92%;
	position: absolute;
}

.DocList {
	position: absolute;
	width: 50%;
	height: 100%;
	border: 1px;
	border-color: black;
	background: rgb(72, 75, 79);
}

.Detail {
	position: absolute;
	left: 50%;
	width: 50%;
	height: 100%;
}

.table-secondary {
	width: 100%;
	border-collapse: collapse;
	text-align: center;
}
</style>
<script src="../WorkBoard/WorkBoard.js"></script>
</head>
<body>

	<jsp:include page="../MainPage/Left.jsp" />
	<div class="content">
		<div class="sort_tab">
			<select>
				<option>전체</option>
				<option>참조</option>
				<option>제목</option>
				<option>작성일</option>
			</select>
			<input type="date"> <input type="text" id="textInput" name="userInput" placeholder="Type something..."> <input type="button" class="btn btn-secondary" value="검색" style="--bs-btn-line-height: 0.01;"> <input type="button" id="writeButton" class="btn btn-secondary" style="--bs-btn-line-height: 0.01;" value="글작성" />
		</div>
		<div class="Main">
			<div class="DocList">
				<table class="table-secondary" border="1">
					<tr>
						<th>INDEX</th>
						<th>Title</th>
						<th>TEAM</th>
						<th>EMP</th>
						<th>DATE</th>
					</tr>
				</table>
			</div>
			<div class="Detail"></div>
		</div>

	</div>

</body>
</html>