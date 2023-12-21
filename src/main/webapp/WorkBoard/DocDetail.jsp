<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	border-collapse: collapse;
}

body {
	height: 100%;
}

.card-text {
	height: 450px;
	overflow: auto;
}
</style>
</head>
<body>
	<div class="page">
		<div class="form-group">
			<div class="row align-items-center">
				<div class="card mb-3">
					<h6 class="card-header">${ Doc.approval_doc_title }</h6>
					<div class="card-body">
						<div class="row">
							<div class="col-md-12">
								<table class="table table-hover" border="1">
									<thead>
										<tr class="table-info">
											<th style="text-align: center;">팀</th>
											<th style="text-align: center;">직급</th>
											<th style="text-align: center;">사번</th>
											<th style="text-align: center;">이름</th>
											<th style="text-align: center;">상태</th>
											<th style="text-align: center;">승인버튼</th>
										</tr>
									</thead>
									<tbody>
										<tr class="table-light">
											<td style="text-align: center;">${ Doc.firstTEAM }</td>
											<td style="text-align: center;">${ Doc.firstGRADE }</td>
											<td style="text-align: center;">${ Doc.firstEmp }</td>
											<td style="text-align: center;">${ Doc.firstNAME }</td>
											<td style="text-align: center;"><c:choose>
													<c:when test="${Doc.firststatus == '완료'}">
														<span class="badge bg-success">완료</span>
													</c:when>
													<c:when test="${Doc.firststatus == '대기'}">
														<span class="badge bg-secondary">대기</span>
													</c:when>
													<c:when test="${Doc.firststatus == '거절'}">
														<span class="badge bg-danger">거절</span>
													</c:when>
													<c:when test="${Doc.firststatus == '참조'}">
														<span class="badge bg-info">참조</span>
													</c:when>
												</c:choose></td>
											<td style="text-align: center;"><c:if test="${ Doc.firstMakeButton == 'Y' }">
													<button type="button" class="btn btn-success btn-sm" data-code="${ Doc.firstCODE }" onclick="approval(this.getAttribute('data-code'))">승인</button>
													<button type="button" class="btn btn-danger btn-sm" data-code="${ Doc.firstCODE }" onclick="reject(this.getAttribute('data-code'))">거절</button>
												</c:if></td>
										</tr>
										<tr class="table-light">
											<td style="text-align: center;">${ Doc.secondTEAM }</td>
											<td style="text-align: center;">${ Doc.secondGRADE }</td>
											<td style="text-align: center;">${ Doc.secondEmp }</td>
											<td style="text-align: center;">${ Doc.secondNAME }</td>
											<td style="text-align: center;"><c:choose>
													<c:when test="${Doc.secondstatus == '완료'}">
														<span class="badge bg-success">완료</span>
													</c:when>
													<c:when test="${Doc.secondstatus == '대기'}">
														<span class="badge bg-secondary">대기</span>
													</c:when>
													<c:when test="${Doc.secondstatus == '거절'}">
														<span class="badge bg-danger">거절</span>
													</c:when>
													<c:when test="${Doc.secondstatus == '참조'}">
														<span class="badge bg-info">참조</span>
													</c:when>
												</c:choose></td>
											<td style="text-align: center;"><c:if test="${ Doc.secondMakeButton == 'Y' }">
													<button type="button" class="btn btn-success btn-sm" data-code="${ Doc.secondCODE }" onclick="approval(this.getAttribute('data-code'))">승인</button>
													<button type="button" class="btn btn-danger btn-sm" data-code="${ Doc.secondCODE }" onclick="reject(this.getAttribute('data-code'))">거절</button>
												</c:if></td>
										</tr>
										<tr class="table-light">
											<td style="text-align: center;">${ Doc.thirdTEAM }</td>
											<td style="text-align: center;">${ Doc.thirdGRADE }</td>
											<td style="text-align: center;">${ Doc.thirdEmp }</td>
											<td style="text-align: center;">${ Doc.thirdNAME }</td>
											<td style="text-align: center;"><c:choose>
													<c:when test="${Doc.thirdstatus == '완료'}">
														<span class="badge bg-success">완료</span>
													</c:when>
													<c:when test="${Doc.thirdstatus == '대기'}">
														<span class="badge bg-secondary">대기</span>
													</c:when>
													<c:when test="${Doc.thirdstatus == '거절'}">
														<span class="badge bg-danger">거절</span>
													</c:when>
													<c:when test="${Doc.thirdstatus == '참조'}">
														<span class="badge bg-info">참조</span>
													</c:when>
												</c:choose></td>
											<td style="text-align: center;"><c:if test="${ Doc.thirdMakeButton == 'Y' }">
													<button type="button" class="btn btn-success btn-sm" data-code="${ Doc.thirdCODE }" onclick="approval(this.getAttribute('data-code'))">승인</button>
													<button type="button" class="btn btn-danger btn-sm" data-code="${ Doc.thirdCODE }" onclick="reject(this.getAttribute('data-code'))">거절</button>
												</c:if></td>
										</tr>
										<tr class="table-light">
											<td style="text-align: center;">${ Doc.fourthTEAM }</td>
											<td style="text-align: center;">${ Doc.fourthGRADE }</td>
											<td style="text-align: center;">${ Doc.fourthEmp }</td>
											<td style="text-align: center;">${ Doc.fourthNAME }</td>
											<td style="text-align: center;"><c:choose>
													<c:when test="${Doc.fourthstatus == '완료'}">
														<span class="badge bg-success">완료</span>
													</c:when>
													<c:when test="${Doc.fourthstatus == '대기'}">
														<span class="badge bg-secondary">대기</span>
													</c:when>
													<c:when test="${Doc.fourthstatus == '거절'}">
														<span class="badge bg-danger">거절</span>
													</c:when>
													<c:when test="${Doc.fourthstatus == '참조'}">
														<span class="badge bg-info">참조</span>
													</c:when>
												</c:choose></td>
											<td style="text-align: center;"><c:if test="${ Doc.fourthMakeButton == 'Y' }">
													<button type="button" class="btn btn-success btn-sm" data-code="${ Doc.fourthCODE }" onclick="approval(this.getAttribute('data-code'))">승인</button>
													<button type="button" class="btn btn-danger btn-sm" data-code="${ Doc.fourthCODE }" onclick="reject(this.getAttribute('data-code'))">거절</button>
												</c:if></td>
										</tr>
										<tr class="table-light">
											<td style="text-align: center;">${ Doc.fifthTEAM }</td>
											<td style="text-align: center;">${ Doc.fifthGRADE }</td>
											<td style="text-align: center;">${ Doc.fifthEmp }</td>
											<td style="text-align: center;">${ Doc.fifthNAME }</td>
											<td style="text-align: center;"><c:choose>
													<c:when test="${Doc.fifthstatus == '완료'}">
														<span class="badge bg-success">완료</span>
													</c:when>
													<c:when test="${Doc.fifthstatus == '대기'}">
														<span class="badge bg-secondary">대기</span>
													</c:when>
													<c:when test="${Doc.fifthstatus == '거절'}">
														<span class="badge bg-danger">거절</span>
													</c:when>
													<c:when test="${Doc.fifthstatus == '참조'}">
														<span class="badge bg-info">참조</span>
													</c:when>
												</c:choose></td>
											<td style="text-align: center;"><c:if test="${ Doc.fifthMakeButton == 'Y' }">
													<button type="button" class="btn btn-success btn-sm" data-code="${ Doc.fifthCODE }" onclick="approval(this.getAttribute('data-code'))">승인</button>
													<button type="button" class="btn btn-danger btn-sm" data-code="${ Doc.fifthCODE }" onclick="reject(this.getAttribute('data-code'))">거절</button>
												</c:if></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<p class="card-text">${ Doc.approval_doc_content }</p>
						<a href="../Controller/DocDetailDownload.do?ofile=${ Doc.approval_doc_ofile }&sfile=${ Doc.approval_doc_sfile }&idx=${ Doc.idx }" class="card-link">다운로드</a>
					</div>
				</div>
			</div>

		</div>
	</div>
</body>
</html>