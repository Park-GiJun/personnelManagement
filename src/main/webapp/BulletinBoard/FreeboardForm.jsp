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
<title>FreeboardForm</title>
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
   font-size: 12px;
   max-height: 100%;
}
</style>
<body>
   <jsp:include page="../MainPage/Left.jsp" />

   <div class="content">
      <!-- 다른 페이지에서 불러오는 내용 -->

      <!-- 목록테이블 -->
      <table
         border="1"
         width="90%"
      >
         <tr>
            <th width="10%">번호</th>
            <th width="*">제목</th>
            <th width="10%">작성일</th>
         </tr>
         <c:choose>
            <c:when test="${ empty FreeboardFormList }">
               <!-- 게시물이 없다면 -->
               <tr>
                  <td
                     colspan="3"
                     align="center"
                  >게시물이 없습니다.</td>
               </tr>
            </c:when>
            <c:otherwise>
               <c:forEach
                  items="${ FreeboardFormList }"
                  var="row"
                  varStatus="loop"
               >

                  <tr align="center">
                     <!-- 번호 -->
                     <td>${ map2.totalCount -(((map2.pageNum-1) * map2.pageSize) + loop.index) }
                     </td>
                     <td align="center">
                        <!-- 제목 -->
                        <a href="BoardDetailAction.bo?num=${board.board_num}&pageNum=${spage}">${ row.title }</a>
                     </td>
                     <td align="center">
                        <a>${ row.post_date }</a>
                     </td>
                  </tr>
               </c:forEach>
            </c:otherwise>
         </c:choose>
      </table>
      <!-- 하단 메뉴 -->
      <form
         method="get"
         action="../Controller/FreeboardFormList.do"
      >
         <table
            border="1"
            width="90%"
         >
            <tr>
               <th
                  align="center"
                  colspan="2"
               ><select name="searchCategory">
                     <option value="title">제목</option>
               </select> <input
                     type="text"
                     name="searchWord"
                  /> <input
                     type="submit"
                     name="listSearch"
                     value="검색하기"
                     id="listSearch"
                  /></th>
            </tr>
            <tr align="center">

               <th>${ map2.paginImg }</th>
               <th
                  width="100"
                  rowspan="2"
               >
                  <button
                     type="button"
                     onclick="location.href='../BulletinBoard/Freeboard.jsp';"
                  >글작성</button>
               </th>
            </tr>
         </table>
      </form>
   </div>
</body>
</html>