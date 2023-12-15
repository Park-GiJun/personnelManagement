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
</script>
</head>
<body>
	<div class="content">
		<!-- 다른 페이지에서 불러오는 내용 -->
		<script type="text/javascript">
			function promptModification() {
				if (confirm("정말로 수정하시겠습니까?")) {
					var modificationText = prompt("비밀번호를 입력하세요:");
					if (modificationText == ${dto.board_pass}) {
						  var boardNum = "${dto.anno_board_num}";
				            var title = "${dto.title}";
				            var content = "${dto.content}";

				            // 폼 요소를 동적으로 생성
				            var form = document.createElement('form');
				            form.method = 'POST';
				            form.action = '../Controller/BoardeditController.do';

				            // hidden 필드를 생성하여 데이터 추가
				            var inputBoardNum = document.createElement('input');
				            inputBoardNum.type = 'hidden';
				            inputBoardNum.name = 'boardNum';
				            inputBoardNum.value = boardNum;
				            form.appendChild(inputBoardNum);

				            var inputTitle = document.createElement('input');
				            inputTitle.type = 'hidden';
				            inputTitle.name = 'title';
				            inputTitle.value = title;
				            form.appendChild(inputTitle);

				            var inputContent = document.createElement('input');
				            inputContent.type = 'hidden';
				            inputContent.name = 'content';
				            inputContent.value = content;
				            form.appendChild(inputContent);

				            // 폼을 body에 추가하고 submit
				            document.body.appendChild(form);
				            form.submit();
					}else{
						alert("비밀번호가 일치하지 않습니다.")
					}
						
					} else {
						// 사용자가 취소를 눌렀을 때의 동작
						// 아무 동작 없음 또는 필요한 동작 추가
					}
				}
			
			function promptDeletion() {
				if (confirm("정말로 삭제하시겠습니까?")) {
					var deletionText = prompt("비밀번호를 입력하세요:");
					if (deletionText == ${dto.board_pass}) {
						"location.href='../Controller/BoardeditController.do';"
						alert("삭제 되었습니다.")
					} else {
						// 사용자가 취소를 눌렀을 때의 동작
						// 아무 동작 없음 또는 필요한 동작 추가
						alert("비밀번호가 일치하지 않습니다.")
					}
				} else {
					// 사용자가 확인을 누르지 않았을 때의 동작
					// 아무 동작 없음 또는 필요한 동작 추가
				}
			}
			
			function validateForm(form) {

				if (form.Commentscontent.value == null
						|| form.Commentscontent.value.trim() === "") {
					alert("내용을 입력하세요");
					return false;
				}
				if (form.commentspassword.value == null
						|| form.commentspassword.value.trim() === "") {
					alert("비밀 번호를 입력해주세요.");
					return false;
				}

				// 작성 완료 메시지
				alert("작성 완료되었습니다");

				// 페이지 이동
				window.location.href = '../BulletinBoard/Comments.jsp';

			}
		</script>

		<!-- 다른 페이지에서 불러오는 내용 -->
		<form name="Comments" method="post"
			action="../Controller/CommentsController.do"
			onsubmit="return validateForm(this)">
			<table border="1" width="90%">
				<tr>
					<th width="20%">번호</th>
					<th width="20%">${dto.anno_board_num}</th>
					<th width="25%">작성일</th>
					<th width="25%">${dto.post_date}</th>
					<td>
						<button type="button" onclick="promptModification()" width="10%">수정</button>
						<button type="button" onclick="promptDeletion()" width="10%">삭제</button>
					</td>
				</tr>
				<tr>
					<td>제목</td>
					<th colspan="4" style="width: 100%; height: 50px;">${dto.title }</th>
				</tr>
				<tr>
					<td>내용</td>
					<th colspan="4" style="width: 100%; height: 600px;">${dto.content}</th>
				</tr>
			</table>
			<table border="1" width="90%">
				<tr>
					<td colspan="5">댓글 리스트</td>
				</tr>

				<c:forEach var="comment" items="${Commentsdto1}" varStatus="loop">
					<tr>
						<td width="20%">${comment.turn}</td>
						<td width="75%">${comment.content}</td>
						<td>
						<button type="button" onclick="CommentsDeletion()">삭제</button></td>

					</tr>
				</c:forEach>
				<tr>
					<td colspan="5">댓글 적는 란</td>
				</tr>
				<tr>
					<td colspan="5"><input type="text" value="내용을 입력해 주세요."
						name="Commentscontent" style="width: 90%;"
						onfocus="clearDefaultText(this)" onblur="restoreDefaultText(this)" /></td>
				</tr>


				<tr>
					<td colspan="5" style="text-align: right;">비밀번호 <input
						type="text" name="commentspassword" />
					</td>
				</tr>
				<tr>
					<td colspan="5" style="text-align: right;">
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
