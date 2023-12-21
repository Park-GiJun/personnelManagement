<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<script src="../WorkBoard/Ref.js"></script>
</head>
<body>
	<div class="row">
		<div class="col-sm-4">
			<div class="form-group h-100">
				<label for="exampleSelect1" class="form-label mt-4">Example multiple</label>
				<select multiple="" class="form-select form-control" id="exampleSelect1">
					<c:forEach var="item" items="${jsonString}">
						<option>${item.name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="col-sm-7">
			<label for="exampleSelect1" class="form-label mt-4">Example multiple select</label>
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">TEAM</th>
						<th scope="col">GRADE</th>
						<th scope="col">NUMBER</th>
						<th scope="col">NAME</th>
					</tr>
				</thead>
				<tbody id="referenceTabel" class="table-primary">
				</tbody>
			</table>
		</div>
	</div>

	<div class="row mt-3">
		<div class="col-sm-7"></div>
		<div class="col-sm-2">
			<button type="submit" id="createRef" onclick="openAddRef()" class="btn btn-primary">생성</button>
		</div>
		<div class="col-sm-2">
			<button type="button" id="sendButton" class="btn btn-primary">선택</button>
		</div>
	</div>
</body>
</html>