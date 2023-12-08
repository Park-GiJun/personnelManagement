<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form
		method="post"
		action="../Controller/FreeboardWrite.do"
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
						name="Freeboardtitle"
						style="width: 90%;"
						onfocus="clearDefaultText(this)"
						onblur="restoreDefaultText(this)"
					/>
				</td>
			</tr>
			<tr>
				<td>
					<input
						type="text"
						name="Freeboardcontent"
						style="width: 100%; height: 800px;"
					>
				</td>
			</tr>

			<tr>
				<td
					colspan="3"
					style="text-align: left;"
				>
					비밀번호
					<input
						type="password"
						name="Freeboardpassword"
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
						onclick="location.href='../BulletinBoard/FreeboardForm.jsp';"
					>목록</button>
					<button type="submit">작성완료</button>
				</td>
			</tr>
		</table>
	</form>

	</form>

</body>
</html>