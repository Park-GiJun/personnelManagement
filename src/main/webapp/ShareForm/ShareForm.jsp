<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShareForm</title>
</head>
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
td {
   border: 1px solid gray; /* 테두리 스타일 지정 */
   padding: 1px; /* 셀 안의 내용과 테두리 사이의 간격 조정 */
}
/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
	position: relative;
	left: 10%;
	padding: 20px;
	max-height: 100%;
}
.btn-info {
	margin-top: 0.7%;
	margin-bottom: 0%;
	font-size: 15px;
	height: 30px;
	width: 100px;
	border-radius: 25px;
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
	background-color: rgb(54, 60, 67);;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}
.table-dark3 {
	background-color: rgb(68, 74, 83);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}
.form-select {
	padding: 0rem 0rem 0rem 3rem;
	margin-top: 0.5%;
	width: 100px;
}
.form-control {
	margin-top: 0.5%;
	width: 400px;
	height: 35px;
}
</style>
<body>
	<jsp:include page="../MainPage/Left.jsp" />
	<div class="content">
		<!-- 다른 페이지에서 불러오는 내용 -->
		<!-- 목록테이블 -->
		<table border="1" width="90%">
			<tr class="table-dark1" align="center">
				<th width="10%" scope="row">번호</th>
				<th width="*">제목</th>
				<th width="10%">첨부파일</th>
			</tr>
			<c:choose>
				<c:when test="${ empty shareboardlists }">
					<!-- 게시물이 없다면 -->
					<tr class="table-dark2">
						<td colspan="3" align="center" scope="row">게시물이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<!-- 게시물이 있을때 -->
					<c:forEach items="${ shareboardlists }" var="row" varStatus="loop">
						<tr align="center" class="table-dark2">
							<!-- 번호 -->
							<td scope="row">${ map.totalCount -(((map.pageNum-1) * map.pageSize) + loop.index) }
							</td>
							<td align="center">
								<!-- 제목 --> <a>${ row.title }</a>
							</td>
							<td><c:if test="${ not empty row.shareofile }">
										${ dto.ofile }
									<a
										href="../Controller/ShareFormDownload.do?ofile=${ dto.ofile }&sfile=${ dto.sfile }&idx=${ dto.idx }">[다운로드]</a>
								</c:if></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<!-- 하단 메뉴 -->
		<form method="get" action="../Controller/sharelist.do">
			<table border="1" width="90%" height="50px">
				<tr class="table-dark3" align="center">
					<th style="display: flex; margin-left:32.5%;" scope="row">
						<select name="searchCategory" class="form-select">
							<option value="title">제목</option>
						</select>
						
						<input type="text" name="searchWord" class="form-control">
						
						<button type="submit" name="listSearch" value="검색하기" id="listSearch" class="btn-info" style="margin-right: 37.5%;">검색하기</button>
						
						<button type="button" onclick="location.href='../ShareForm/Write.jsp';" class="btn-info">글작성</button>
					</th>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>