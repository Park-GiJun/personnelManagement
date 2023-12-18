<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Comments</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
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

td, th {
   border: 1px solid gray; /* 테두리 스타일 지정 */
   padding: 1px; /* 셀 안의 내용과 테두리 사이의 간격 조정 */
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
   margin-left: 200px; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
   padding: 15px; /*넓이*/
   font-size: 12px; /*글자사이즈*/
   min-height: 400px; /* Set a minimum height for the content area */
}

.btn-info {
	margin-top: 0.25%;
	width : 10%;
	font-size: 15px;
	height: 30px;
	border-radius: 20px;
}

.form-control {
	margin-left: 0.5%;
	margin-top: 0.5%;
	width: 20%;
	height: 10px;
}

.table-info {
	background-color: #5bc0de;
}

.table-dark1 {
	background-color: #272b30;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark2 {
	background-color: rgb(54, 60, 67);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark3 {
	background-color: rgb(68, 74, 83);
	--bs-table-color: #fff;
	--bs-table-border-color: #fff;
	color: var(--bs-table-color);
	border-color: var(--bs-table-border-color);
}

.table-dark4 {
	background-color: rgb(54, 60, 67);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

.table-dark4:nth-child(odd) {
	background-color: rgb(49, 55, 62);
}

.form-select {
	padding: 0rem 0rem 0rem 3rem;
	margin-top: 0.5%;
	width: 100px;
}

#delete {
	width: 75%;
	font-size:7px;
	background: #fff;
}

#btn2 {
	width: 100%;
	font-size:10px;
	background: #fff;
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
                  // 사용자가 확인을 눌렀을 때의 동작
                  // modificationText를 어떻게 사용할지 결정하고, 필요한 동작 추가
                  //alert("수정된 내용: " + modificationText);
                  alert("비밀번호가 일치합니다." + ${dto.board_pass})
                  window.location.href = '../BulletinBoard/FreeboardForm.jsp';   
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
                  window.location.href = '../BulletinBoard/FreeboardForm.jsp';
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
            <tr class="table-dark1" align="center">
               <th width="20%">번호</th>
               <th width="20%">${dto.anno_board_num}</th>
               <th width="25%">작성일</th>
               <th width="25%">${dto.post_date}</th>
               <td style="text-align: left; font-size: 15px; display: flex; align-items: center;">
                  <button type="button" onclick="promptModification()" width="10%" id="btn2" class="btn-info">수정</button>
                  <button type="button" onclick="promptDeletion()" width="10%" id="btn2" class="btn-info">삭제</button>
               </td>
            </tr>
            <tr class="table-dark2" align="center">
               <td style="width: 10%;">제목</td>
               <th colspan="4" style="width: 90%; height: 50px;">${dto.title }</th>
            </tr>
            <tr class="table-dark3" align="center">
               <td scope="row" style="width: 10%;">내용</td>
               <th colspan="4" style="width: 90%; height: 500px;">${dto.content}</th>
            </tr>
         </table>
         <table border="1" width="90%">
            <tr class="table-dark2">
               <td colspan="4">댓글 리스트</td>
            </tr>

            <c:forEach var="comment" items="${Commentsdto1}" varStatus="loop">
               <tr class="table-dark4">
                <td width="5%" align="center">${comment.turn}</td>
                <td width="90%">${comment.content}</td>
                <td width="5%" align="center">
					<button type="button" onclick="CommentsDeletion()" class="btn-info" id="delete">삭제</button>
                </td>

               </tr>
            </c:forEach>
            </table>
            <table border="1" width="90%">
            	<tr class="table-dark1">
              		<td colspan="3" style="text-align: left; font-size: 15px; display: flex; align-items: center;">댓글
               			<input type="text" value="내용을 입력해 주세요." name="Commentscontent" style="width: 95%;" class="form-control"
                              onfocus="clearDefaultText(this)" onblur="restoreDefaultText(this)" />
               		</td>
            	</tr>

            	<tr class="table-dark1">
              		<td colspan="3" style="text-align: left; font-size: 15px; display: flex; align-items: center;">비밀번호
               			<input type="text" name="commentspassword" class="form-control" width="25%"/>
               			<button type="button" onclick="location.href='../Controller/FreeboardList.do';" class="btn-info" style="margin-left:54%;">목록</button>
               			<button type="submit" class="btn-info">댓글쓰기</button>
               		</td>
            	</tr>
         </table>

      </form>
   </div>
</body>
</html>