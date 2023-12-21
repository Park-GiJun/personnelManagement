<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.16/jstree.min.js"></script>
<script src="../WorkBoard/addEMP.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.16/themes/default/style.min.css" />
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/choices.js/public/assets/scripts/choices.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/choices.js/public/assets/styles/choices.min.css">
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

	<div id="organizationTree"></div>
	<select id="badge-select"></select>
	<button type="button" class="btn btn-success" id="choiceBtn">선택</button>
</body>
</html>