<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>jsTree 예시</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.16/jstree.min.js"></script>
<script src="../WorkBoard/addRef.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.16/themes/default/style.min.css" />
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<style>
#viewpoint {
	height: 80vh;
}

#exampleSelect2 {
	height: 30vh;
}
</style>
</head>
<body>
	<div class="row" id="viewpoint">
		<!-- 높이를 100vh로 조정 -->
		<div class="col-sm-6">
			<div id="organizationTree"></div>
		</div>
		<div class="col-sm-6">
			<!-- 멀티셀렉트 영역 높이 조정 -->
			<div class="form-group h-100">
				<input class="form-control form-control-sm" type="text" placeholder=".form-control-sm" id="inputSmall">
				<select multiple="" class="form-select" id="exampleSelect2">
				</select>
			</div>
		</div>
	</div>
	<div class="row">
	<div class="col-sm-8"></div>
		<div class="col-sm-4">
			<div class="btn-group" role="group" aria-label="Basic example">
				<button type="button" class="btn btn-secondary" id="addButton">추가</button>
				<button type="button" class="btn btn-secondary" id="deleteButton">삭제</button>
				<button type="submit" class="btn btn-secondary" id="submitBuuton" onclick="submitRef()">완료</button>
			</div>
		</div>
	</div>
</body>
</html>

