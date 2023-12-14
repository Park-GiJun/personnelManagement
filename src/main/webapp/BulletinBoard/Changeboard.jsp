<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Changeboard</title>
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
	font-size: 12px;
	min-height: 400px; /* Set a minimum height for the content area */
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
			<table align="center" border="1" height="80%" width="90%">
				<tr>
					<td><input type="text" value="제목을 입력해 주세요."
						name="Freeboardtitle" style="width: 90%;"
						onfocus="clearDefaultText(this)" onblur="restoreDefaultText(this)" />
					</td>
				</tr>
				
				<tr>
					<td><input type="text" name="Freeboardcontent"
						style="width: 100%; height: 800px;"></td>
				</tr>

				<tr>
					<td colspan="3" style="text-align: left;">비밀번호 <input
						type="text" value="숫자만 입력해 주세요." name="Freeboardpassword"
						onfocus="clearDefaultText(this)" onblur="restoreDefaultText(this)" />
						
					</td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: right;">
						<button type="button"
							onclick="location.href='../Controller/FreeboardList.do';">목록</button>
						<button type="submit">작성완료</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>