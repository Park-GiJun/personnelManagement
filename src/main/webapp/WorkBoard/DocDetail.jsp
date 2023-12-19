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
											<th style="text-align: center;">team</th>
											<th style="text-align: center;">grade</th>
											<th style="text-align: center;">emp</th>
											<th style="text-align: center;">이름</th>
											<th style="text-align: center;">상태</th>
											<th style="text-align: center;">승인여부</th>
										</tr>
									</thead>
									<tbody>
										<tr class="table-light">
											<td style="text-align: center;">${ Doc.firstTEAM }</td>
											<td style="text-align: center;">${ Doc.firstGRADE }</td>
											<td style="text-align: center;">${ Doc.firstEMP }</td>
											<td style="text-align: center;">${ Doc.firstNAME }</td>
											<td style="text-align: center;">${ Doc.firstSTATUS }</td>
											<td style="text-align: center;"><button type="button" class="btn btn-success btn-sm">승인</button>
												<button type="button" class="btn btn-danger btn-sm">거절</button></td>
										</tr>
										<tr class="table-light">
											<td style="text-align: center;">${ Doc.secondTEAM }</td>
											<td style="text-align: center;">${ Doc.secondGRADE }</td>
											<td style="text-align: center;">${ Doc.secondEMP }</td>
											<td style="text-align: center;">${ Doc.secondNAME }</td>
											<td style="text-align: center;">${ Doc.secondSTATUS }</td>
											<td style="text-align: center;"><button type="button" class="btn btn-success btn-sm">승인</button>
												<button type="button" class="btn btn-danger btn-sm">거절</button></td>
										</tr>
										<tr class="table-light">
											<td style="text-align: center;">${ Doc.thirdTEAM }</td>
											<td style="text-align: center;">${ Doc.thirdGRADE }</td>
											<td style="text-align: center;">${ Doc.thirdEMP }</td>
											<td style="text-align: center;">${ Doc.thirdNAME }</td>
											<td style="text-align: center;">${ Doc.thirdSTATUS }</td>
											<td style="text-align: center;"><button type="button" class="btn btn-success btn-sm">승인</button>
												<button type="button" class="btn btn-danger btn-sm">거절</button></td>
										</tr>
										<tr class="table-light">
											<td style="text-align: center;">${ Doc.fourthTEAM }</td>
											<td style="text-align: center;">${ Doc.fourthGRADE }</td>
											<td style="text-align: center;">${ Doc.fourthEMP }</td>
											<td style="text-align: center;">${ Doc.fourthNAME }</td>
											<td style="text-align: center;">${ Doc.fourthSTATUS }</td>
											<td style="text-align: center;"><button type="button" class="btn btn-success btn-sm">승인</button>
												<button type="button" class="btn btn-danger btn-sm">거절</button></td>
										</tr>
										<tr class="table-light">
											<td style="text-align: center;">${ Doc.fifthTEAM }</td>
											<td style="text-align: center;">${ Doc.fifthGRADE }</td>
											<td style="text-align: center;">${ Doc.fifthEMP }</td>
											<td style="text-align: center;">${ Doc.fifthNAME }</td>
											<td style="text-align: center;">${ Doc.fifthSTATUS }</td>
											<td style="text-align: center;"><button type="button" class="btn btn-success btn-sm">승인</button>
												<button type="button" class="btn btn-danger btn-sm">거절</button></td>
										</tr>
										<tr class="table-light">
											<td style="text-align: center;">${ Doc.secondTEAM }</td>
											<td style="text-align: center;">${ Doc.secondGRADE }</td>
											<td style="text-align: center;">${ Doc.secondEMP }</td>
											<td style="text-align: center;">${ Doc.secondNAME }</td>
											<td style="text-align: center;">${ Doc.secondSTATUS }</td>
											<td style="text-align: center;"><button type="button" class="btn btn-success btn-sm">승인</button>
												<button type="button" class="btn btn-danger btn-sm">거절</button></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<p class="card-text">${ Doc.approval_doc_content }</p>
						<a href="#" class="card-link">다운로드</a>
					</div>
				</div>
			</div>

		</div>
	</div>
</body>
</html>