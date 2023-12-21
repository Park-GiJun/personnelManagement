<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.content {
	margin-left: 10%; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
	font-size: 12px;
}

.sort_tab {
	width: 97.9%;
	background: rgb(72, 75, 79);
	align-content: center;
}

.Main {
	width: 86.1%;
	height: 92%;
	position: absolute;
}

.DocList {
	position: absolute;
	width: 50%;
	height: 100%;
	background: rgb(72, 75, 79);
}

.Detail {
	position: absolute;
	left: 50%;
	width: 50%;
	height: 100%;
}

.docslist {
	width: 100%;
	border-collapse: collapse;
	text-align: center;
}

.docs {
	color: black;
	cursor: pointer;
}
</style>
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<script src="../WorkBoard/WorkBoard.js"></script>
</head>
<body>

	<jsp:include page="../MainPage/Left.jsp" />
	<div class="content">
		<div class="sort_tab">
			<form method="GET" action="../Controller/WorkBoardList.do">
				<input type="date" id="datePicker" onchange="dateChanged()">
				<select name="Category">
					<option value="">전체</option>
					<option value="APPROVAL_DOC_TITLE">제목</option>
					<option value="APPROVAL_DOC_CONTENT">내용</option>
					<option value="APPROVAL_DOC_OFILE">파일명</option>
					<option value="TEAM">부서</option>
				</select>
				<input type="text" id="textInput" name="searchWord" placeholder="검색어를 입력하세요."> <input type="submit" class="btn btn-secondary" value="검색" style="--bs-btn-line-height: 0.01;"> <input type="button" id="writeButton" class="btn btn-secondary" style="--bs-btn-line-height: 0.01;" value="글작성" />
			</form>
		</div>
		<div class="Main">
			<div class="DocList">
				<table class="table table-hover" border="1" id="boarlist">
					<thead class="table-info">
						<tr class="table-info">
							<th style="text-align: center;">INDEX</th>
							<th style="text-align: center;">TITLE</th>
							<th style="text-align: center;">TEAM</th>
							<th style="text-align: center;">EMP</th>
							<th style="text-align: center;">DATE</th>
							<th style="text-align: center;">FILE</th>
							<th style="text-align: center;">STATUS</th>
						</tr>
					</thead>
					<tbody class="table-light">
						<c:choose>
							<c:when test="${ empty workdocslist }">
								<!-- 게시물이 없다면 -->
								<tr class="table-light">
									<td colspan="6" align="center" scope="row">결재할 게시물이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<!-- 게시물이 있을때 -->
								<c:forEach items="${ workdocslist }" var="row" varStatus="loop">
									<tr class="table-light">
										<td scope="row" style="text-align: center;">${ map.totalCount - (((map.pageNum-1) * map.pageSize) + loop.index) }</td>
										<td style="text-align: center;"><a class="docs" id="${ row.idx }">${ row.approval_doc_title }</a></td>
										<td style="text-align: center;">${ row.team }</td>
										<td style="text-align: center;">${ row.emp_num }</td>
										<td style="text-align: center;">${ row.approval_doc_date }</td>
										<td style="text-align: center;"><c:if test="${ not empty row.approval_doc_ofile }">
										${ row.approval_doc_ofile }
											</c:if></td>
										<td style="text-align: center;">${ row.doc_status }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						<tr>
							<th colspan="7" style="text-align: center;">${ map.pagingImg }</th>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="Detail"></div>
		</div>

	</div>

</body>
</html>