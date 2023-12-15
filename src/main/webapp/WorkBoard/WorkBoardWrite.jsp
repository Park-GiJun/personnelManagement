<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
form {
	background: rgb(72, 75, 79);
}
</style>
</head>
<body>
	<form>
		<div class="form-group">
			<div class="row align-items-center">
				<div class="col-md-10">
					<input type="text" class="form-control form-control-sm" placeholder="Default input" id="inputDefault">
				</div>
				<div class="col-md-1 text-end">
					<button type="submit" class="btn btn-secondary btn-sm">제출</button>
				</div>
				<div class="col-md-1 text-end">
					<button type="button" id="referenceBtn" class="btn btn-secondary btn-sm" onclick="openNewJSP()">양식</button>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<table class="table table-hover">
						<tr class="table-secondary">
							<th style="text-align: center;">TEAM</th>
							<th style="text-align: center;">Grade</th>
							<th style="text-align: center;">EMP</th>
							<th style="text-align: center;">이름</th>
							<th style="text-align: center;">상태</th>
							<th style="text-align: center;"></th>
						</tr>
						<tr class="table-light">
							<td style="text-align: center;">개발</td>
							<td style="text-align: center;">사장</td>
							<td style="text-align: center;">2023120401</td>
							<td style="text-align: center;">류동규</td>
							<td style="text-align: center;"><span class="badge bg-success">완료</span>
							<td style="text-align: center;">
								<button type="button" class="btn btn-danger btn-sm">제거</button>
							</td>
						</tr>
						<tr class="table-light">
							<td style="text-align: center;">개발</td>
							<td style="text-align: center;">사장</td>
							<td style="text-align: center;">2023120401</td>
							<td style="text-align: center;">류동규</td>
							<td style="text-align: center;"><span class="badge bg-secondary">대기</span>
							<td style="text-align: center;">
								<button type="button" class="btn btn-danger btn-sm">제거</button>
						</tr>
						<tr class="table-light">
							<td style="text-align: center;">개발</td>
							<td style="text-align: center;">사장</td>
							<td style="text-align: center;">2023120401</td>
							<td style="text-align: center;">류동규</td>
							<td style="text-align: center;"><span class="badge bg-secondary">대기</span>
							<td style="text-align: center;">
								<button type="button" class="btn btn-danger btn-sm">제거</button>
							</td>
						</tr>
						<tr class="table-light">
							<td style="text-align: center;">개발</td>
							<td style="text-align: center;">사장</td>
							<td style="text-align: center;">2023120401</td>
							<td style="text-align: center;">류동규</td>
							<td style="text-align: center;"><span class="badge bg-info">참조</span>
							<td style="text-align: center;">
								<button type="button" class="btn btn-danger btn-sm">제거</button>
							</td>
						</tr>
						<tr class="table-light">
							<td colspan="6" style="text-align: center;"><button type="button" class="btn btn-success btn-sm">추가</button></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="row mt-1">
				<div class="col-md-12">
					<textarea class="form-control" id="exampleTextarea" rows="18" style="resize: vertical;"></textarea>
				</div>
			</div>
			<div class="row mt-2">
				<div class="col-md-12">
					<input class="form-control" type="file" id="formFile">
				</div>
			</div>
		</div>
	</form>
</body>
</html>