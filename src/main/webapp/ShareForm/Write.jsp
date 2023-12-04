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
	max-height: 100%;
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
		<form
			name="shareFrame"
			method="post"
			enctype="multipart/form-data"
			action="../Controller/ShareWrite.do"
			onsubmit="return validateForm(this)"
		>
			<table
				align="center"
				border="1"
				height="80%"
				width="90%"
			>
				<tr>
					<td>
						<input
							type="text"
							value="제목을 입력해 주세요."
							name="sharetitle"
							style="width: 90%;"
							onfocus="clearDefaultText(this)"
							onblur="restoreDefaultText(this)"
						/>
					</td>
				</tr>
				<tr>
					<td>
						<textarea
							name="sharecontent"
							style="width: 100%; height: 800px;"
						></textarea>
					</td>
				</tr>
				<tr>
					<td
						colspan="3"
						style="text-align: left;"
					>
						첨부파일
						<input
							type="file"
							name="shareOfile"
						/>
					</td>
				</tr>
				<tr>
					<td
						colspan="3"
						style="text-align: right;"
					>
						<button
							type="button"
							onclick="location.href='../Controller/list.do';"
						>목록</button>
						<button type="submit">작성완료</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
