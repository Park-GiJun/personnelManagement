<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Modification</title>

<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">

<style type="text/css">
@font-face {
    font-family: 'ChungjuKimSaengTTF';
    src: url('../Font/ChungjuKimSaeng.ttf') format('woff2');
    font-weight: normal;
    font-style: normal;
    font-family: 'ChungjuKimSaengTTF', sans-serif;
}

@font-face {
    font-family: 'intelone-mono-font-family-regular';
    src: url('../Font/IntelOneMono-Regular.ttf') format('woff2');
    font-weight: 400;
    font-style: normal;
}

@font-face {
	font-family: 'SF_HambakSnow';
	src: url('../Font/SF_HambakSnow.ttf') format('woff');
	font-weight: normal;
	font-style: normal;
}}

body {
	font-family: 'ChungjuKimSaengTTF', sans-serif;
}

.btn-info {
	margin-top: 5%;
	margin-left: 1%;
	width: 98%;
	font-size: 200%;
	height: 200%;
	border-radius: 25px;
}

.form-control {
	margin-top: 5px;
	width: 45%;
	height: 10px;
	text-align: center;
}

.div_style {
	font-size: 140%;
	--bs-table-color: #fff;
	color: var(--bs-table-color);
	width: 100%;
}

.h1_style {
	--bs-table-color: #fff;
	color: var(--bs-table-color);
	text-align: center;
}

li {
    display: flex; /* 수평 배치 할때사용 사용 */
    margin-bottom: 10px; /* 각 항목 간 간격 조절 */
}

</style>
</head>
<body>
	<div class="h1_style">
		<h1>Employee Modification</h1>
	</div>
	<div class="div_style">
		<ul>
			<li><b>이름 : </b>&nbsp;${param.infoName}</li>
			<li><b>사번 : </b>&nbsp;${param.infoEmpNum}</li>
			<li><b>전화번호 : </b>&nbsp;<input type="text" id="modifiedPhone" value="${param.infoPhone}" class="form-control"></li>
			<li><b>이메일 : </b>&nbsp;<input type="text" id="modifiedEmail" value="${param.infoEmail}" class="form-control"></li>
			<li><b>비밀번호 재설정 : </b>&nbsp;<input type="password" id="modifiedPass" class="form-control" placeholder="미입력시 기존비밀번호 유지"></li>
			<li><b>비밀번호 확인 : </b>&nbsp;<input type="password" id="modifiedPass2" class="form-control"></li>
		</ul>
	</div>
	<button type="button" onclick="performModification()" class='btn-info'>수정 완료</button>

	<script>
        function performModification() {
            // 수정된 정보 가져오기
            var modifiedPhone = document.getElementById('modifiedPhone').value;
            var modifiedEmail = document.getElementById('modifiedEmail').value;
            var modifiedPass = document.getElementById('modifiedPass').value;
            var modifiedPass2 = document.getElementById('modifiedPass2').value;
            
            if (modifiedPass == modifiedPass2) {
            	alert("정보가 변경되었습니다.")
            	// 사번 정보 가져오기
                var infoEmpNum = "${param.infoEmpNum}";

                // 서버로 수정된 정보 전송
                fetch('../Controller/InfoModify.do', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'modifiedPhone=' + encodeURIComponent(modifiedPhone)
                        + '&modifiedEmail=' + encodeURIComponent(modifiedEmail)
                        + '&modifiedPass=' + encodeURIComponent(modifiedPass)
                        + '&infoEmpNum=' + encodeURIComponent(infoEmpNum),
                })
                .then(response => {
                    if (response.ok) {
                        // 성공적으로 처리된 경우 원하는 동작 수행
                        console.log('수정이 완료되었습니다.');
                        window.opener.location.reload(); // 부모 창 새로 고침
                        window.close();
                    } else {
                        // 오류 처리
                        console.error('수정 중 오류가 발생했습니다.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
            } else {
            	alert("비밀번호가 일치하지 않습니다.")
            }
        }
        
    </script>
</body>
</html>
