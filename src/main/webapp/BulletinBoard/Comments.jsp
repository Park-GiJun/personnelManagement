<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Comments</title>
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
	margin-left: 200px; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 15px; /*넓이*/
	font-size: 12px; /*글자사이즈*/
	min-height: 400px; /* Set a minimum height for the content area */
}
</style>
<jsp:include page="../MainPage/Left.jsp" />
<script type="text/javascript">
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

	function validateForm(form) {
		if (form.Freeboardpassword.value == null
				&& form.Freeboarduser.value == null
				&& form.Freeboarduser.value.trim() === ""
				&& form.Freeboardpassword.value.trim() === "") {
			alert("비밀 번호를 입력해주세요.");
			return true;
		} else if (form.Freeboarduser.value == null
				|| form.Freeboarduser.value.trim() === "") {
			alert("내용을 입력하세요");
			form.Freeboarduser.focus();
			return false;
		} else if (form.Freeboardpassword.value == null
				|| form.Freeboardpassword.value.trim() === "") {
			alert("제목을 입력해주세요.");
			return false;
		}

	}

	function crystal() {
		var userInput = prompt("입력하세요:", "");

		// 사용자가 입력을 취소하거나 빈 문자열을 입력한 경우
		if (userInput === null || userInput.trim() === "") {
			alert("입력이 취소되었거나 유효하지 않은 값입니다.");
		} else {
			// 입력값을 사용할 수 있습니다. 여기서는 간단히 경고창에 출력하는 예제입니다.
			alert("입력된 값: " + userInput);
		}
	}

	function elimination() {
		var userInput = prompt("입력하세요:", "");

		// 사용자가 입력을 취소하거나 빈 문자열을 입력한 경우
		if (userInput === null || userInput.trim() === "") {
			alert("입력이 취소되었거나 유효하지 않은 값입니다.");
		} else {
			// 입력값을 사용할 수 있습니다. 여기서는 간단히 경고창에 출력하는 예제입니다.
			alert("입력된 값: " + userInput);
		}
	}
</script>
</head>
<body>

	<div class="content">
		<!-- 다른 페이지에서 불러오는 내용 -->
		<form name="FreeboardFrame" method="post"
			enctype="multipart/form-data" action="../Controller/Freeboard.do"
			onsubmit="return validateForm(this)">
			<table border="1" width="90%">
				<tr>
					<th width="20%">번호</th>
					<th width="20%">${dto.anno_board_num}</th>
					<th width="25%">작성일</th>
					<th width="25%">${dto.post_date}</th>
					<td>
						<button type="submit" onclick="crystal()" width="10%">수정</button>
						<button type="submit" onclick="elimination()" width="10%">삭제</button>
					</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="4">${dto.title }</td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="4">${dto.content}</td>
				</tr>
				<tr>
					<td colspan="5">댓글 리스트</td>
				</tr>
				
				<c:forEach var="comment" items="${Commentsdto1}" varStatus="loop">
					<tr>
						<td colspan="5">${comment.turn} - ${comment.content}</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5">댓글 적는 란</td>
				</tr>
				<tr>
					<td colspan="5"></td>
				</tr>


				<tr>
					<td colspan="5" style="text-align: right;">비밀번호 <input
						type="password" name="Freeboardpassword" />
						<button type="submit">등록</button>
					</td>
				</tr>
				<tr>
					<td colspan="5" style="text-align: right;">
						<button type="button"
							onclick="location.href='../Controller/list.do';">목록</button>
						<button type="submit">작성완료</button>
					</td>
				</tr>

			</table>

		</form>
	</div>
</body>
</html>
