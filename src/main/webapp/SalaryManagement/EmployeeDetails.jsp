<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Details</title>
<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/bootstrap.rtl.css" rel="stylesheet" type="text/css">
<style>
@font-face {
    font-family: 'ChungjuKimSaengTTF';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/ChungjuKimSaengTTF.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
    font-family: 'ChungjuKimSaengTTF', sans-serif;
}

body {
	font-family: 'ChungjuKimSaengTTF', sans-serif;
	font-size: 20px;
	background-color: rgb(54, 60, 67);
	--bs-table-color: #fff;
	color: var(--bs-table-color);
}

h1 {
	margin-left:2%;
	margin-top:2%;
}

.btn-info {
	margin-top: 7px;
	margin-left:2%;
	width: 20%;
	font-size:20px;
	height: 80%;
	border-radius: 25px;
}

.form-control {
	width: 20%;
	padding: 0rem 0rem 0rem 0.75rem;
}

</style>
<script>
function modifySalary(){
    var empNum = "${param.emp_num}";
    var yearmonth = "${param.yearmonth}";
    
    var incentive = document.getElementById('incentive').value;
    var holidaypay = document.getElementById('holidaypay').value;
    
    fetch('../Controller/ModifySalary.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'incentive=' + incentive + '&holiday=' + holidaypay + '&empNum=' + empNum + '&yearmonth=' + yearmonth,
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
</head>
<body>
	<h1>Employee Details</h1>
	<ul>
		<li><b>부서:</b> ${param.team}</li>
		<li><b>이름:</b> ${param.name}</li>
		<li><b>사번:</b> ${param.emp_num}</li>
		<li><b>직급:</b> ${param.emp_grade}</li>
		<li><b>기본급:</b> ${param.pay}</li>
		<li><b>총 인센티브:</b> ${param.total_pay}</li>
		<li style="display: flex; align-items: center;"><b>성과급:</b>
        	<input type="text" id="incentive" value="${param.incentive}" class="form-control" style="margin-right: 10px; margin-left: 10px;">
        		<button class="btn-info">+100000</button>
        		<button class="btn-info">-100000</button>
		</li>
		<li style="display: flex; align-items: center;"><b>추가급:</b>
			<input type="text" id="holidaypay" value="${param.holiday_pay}" class="form-control" style="margin-right: 10px; margin-left: 10px;">
				<button class="btn-info">+10</button>
				<button class="btn-info">-10</button>
		</li>
		<li>
			<b>추가근무수당:</b> ${param.extra_work_pay}
		</li>
	</ul>
	<button type="button" onclick="modifySalary()" class="btn-info">수정 완료</button>
	<button type="reset" class="btn-info">초기화</button>
</body>
</html>
