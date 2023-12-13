<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Modification</title>
</head>
<body>
	<h1>Employee Modification</h1>
	<ul>
		<li><b>이름:</b> ${param.infoName}</li>
		<li><b>사번:</b> ${param.infoEmpNum}</li>
		<li><b>전화번호:</b>
		<input
				type="text"
				id="modifiedPhone"
				value="${param.infoPhone}"
			></li>
		<li><b>이메일:</b>
		<input
				type="text"
				id="modifiedEmail"
				value="${param.infoEmail}"
			></li>
	</ul>

	<button
		type="button"
		onclick="performModification()"
	>수정 완료</button>

	<script>
        function performModification() {
            // 수정된 정보 가져오기
            var modifiedPhone = document.getElementById('modifiedPhone').value;
            var modifiedEmail = document.getElementById('modifiedEmail').value;
            
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
                    + '&infoEmpNum=' + encodeURIComponent(infoEmpNum),
            })
            .then(response => {
                if (response.ok) {
                    // 성공적으로 처리된 경우 원하는 동작 수행
                    console.log('수정이 완료되었습니다.');
                    window.close();
                } else {
                    // 오류 처리
                    console.error('수정 중 오류가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }
    </script>
</body>
</html>
