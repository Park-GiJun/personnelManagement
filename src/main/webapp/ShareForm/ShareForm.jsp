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
	font-size: 12px;
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
				<th width="8%">첨부</th>
			</tr>
			<c:choose>
				<c:when test="${ empty shareboardlists }">
					<!-- 게시물이 없을때 -->
					<tr>
						<td
							colspan="3"
							align="center"
						>등록된 게시글이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<!-- 게시글이 있을 때 -->
					<c:forEach
						items="${ shareboardlists }"
						var="row"
						varStatus="loop"
					>
						<tr align="center">
							<td>
								<!-- 번호 -->
								${ map.totalCount - (((map.pageNum-1) * map.pageSize) + loop.index) }
							</td>
							<td align="left">
								<!-- 제목(링크) -->
								<a href="../mvcboard/view.do?idx=${ row.idx }">${ row.title }</a>
							</td>
							<td>
								<c:if test="${ not empty row.ofile }">
									<a
										href="../mvcboard/download.do?ofile=${ row.ofile }&sfile=${ row.sfile }&idx=${ row.idx }"
									>[Down]</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<!-- 하단 메뉴(바로가기 글쓰기) -->
		<table
			border="1"
			width="90%"
		>
			<form
				name="shareform"
				method="get"
				action="../Controller/sharelist.do"
			>
				<tr>
					<td
						align="left"
						width="20%"
					>
						<select name="searchField">
							<option value="title">제목</option>
							<option value="content">내용</option>
						</select>
						<input
							type="text"
							name="searchWord"
						/>
						<input
							type="submit"
							value="검색하기"
						/>
					</td>
					<td align="center">${ map.get("pagingImg") }</td>
					<td
						align="center"
						width="10%"
					>
						<button
							type="button"
							onclick="location.href='../Controller/write.do';"
						>글쓰기</button>
					</td>
				</tr>
			</form>
		</table>
	</div>
</body>
</html>