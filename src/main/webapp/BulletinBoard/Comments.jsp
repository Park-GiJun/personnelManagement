<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				if (form.Freeboardpassword.value == null
						&& form.Freeboarduser.value == null&&form.Freeboarduser.value.trim() === ""
						&&form.Freeboardpassword.value.trim() === "") {
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
		<form name="FreeboardFrame" method="post"
			enctype="multipart/form-data" action="../Controller/Freeboard.do"
			onsubmit="return validateForm(this)">
			<table align="center" border="1" height="80%" width="90%">
				<tr><!-- DTO연결 후 변경 -->
					<td><input type="text" value="제목 이름 삽입" name="Freeboardtitle"
						style="width: 70%;" onfocus="clearDefaultText(this)"
						onblur="restoreDefaultText(this)" /> 
						<input type="text" value="시간 삽입" name="Freeboardtitle" style="width: 20%;"
						onfocus="clearDefaultText(this)" onblur="restoreDefaultText(this)" />
						<button type="submit"onclick="crystal()">수정</button>
						<button type="submit"onclick="elimination()">삭제</button>
					</td>
				</tr>
				<tr>
					<td><textarea name="Freeboard"
							style="width: 100%; height: 600px;"></textarea></td>
							<!-- DTO연결 후 변경 -->
				</tr>
				<tr>
					<td><textarea name="Comments list"
							style="width: 100%; height: 200px;"></textarea></td>
				</tr>
				<tr>
					<td><textarea name="Comments"
							style="width: 100%; height: 100px;"></textarea></td>
				</tr>


				<tr>
					<td colspan="3" style="text-align: right;">비밀번호 <input
						type="password" name="Freeboardpassword" />
						<button type="submit">등록</button>
					</td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: right;">
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
