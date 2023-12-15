<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
    window.onload = function() {
        // 서버에 POST 요청 보내기
        fetch('../Contorller/ReferenceLoad.do', {
            method: 'POST',
        })
        .then(response => response.json())
        .then(data => {
            console.log(data);
            updateSelectOptions(data);
        })
        .catch(error => {
            console.error('Error:', error);
        });
    };

    function updateSelectOptions(data) {
        var selectElement = document.getElementById("exampleSelect1");
        
        // 기존 옵션 제거
        selectElement.innerHTML = "";

        // 데이터를 이용하여 새로운 옵션 추가
        for (var key in data) {
            if (data.hasOwnProperty(key)) {
                var option = document.createElement("option");
                option.text = data[key].name;
                selectElement.add(option);
            }
        }
    }
</script>
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
				<tbody>
					<tr class="table-primary">
						<td>개발</td>
						<td>사장</td>
						<td>1234567890</td>
						<td>홍길동</td>
					</tr>
					<tr class="table-primary">
						<td>개발</td>
						<td>사장</td>
						<td>1234567890</td>
						<td>홍길동</td>
					</tr>
					<tr class="table-primary">
						<td>개발</td>
						<td>사장</td>
						<td>1234567890</td>
						<td>홍길동</td>
					</tr>
					<tr class="table-primary">
						<td>개발</td>
						<td>사장</td>
						<td>1234567890</td>
						<td>홍길동</td>
					</tr>
					<tr class="table-primary">
						<td>개발</td>
						<td>사장</td>
						<td>1234567890</td>
						<td>홍길동</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div class="row mt-3">
		<div class="col-sm-7"></div>
		<div class="col-sm-2">
			<button type="submit" class="btn btn-primary">생성</button>
		</div>
		<div class="col-sm-2">
			<button type="submit" class="btn btn-primary">선택</button>
		</div>
	</div>



</body>
</html>