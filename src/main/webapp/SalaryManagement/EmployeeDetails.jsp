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
</head>
<body>
	<h1>Employee Details</h1>
	<ul>
		<li><b>부서:</b> ${param.team}</li>
		<li><b>이름:</b> ${param.name}</li>
		<li><b>사번:</b> ${param.emp_num}</li>
		<li><b>직급:</b> ${param.emp_grade}</li>
		<li><b>기본급:</b> <input
				type="text"
				name="pay"
				value="${param.pay}"
			/>
			<button>+10</button>
			<button>-10</button></li>
		<li><b>총 인센티브:</b> <input
				type="text"
				name="total_pay"
				value="${param.total_pay}"
				readonly="readonly"
			/></li>
		<li><b>성과급:</b> <input
				type="text"
				name="total_pay"
				value="${param.incentive}"
			/>
			<button>+10</button>
			<button>-10</button></li>
		<li><b>추가급:</b> <input
				type="text"
				name="total_pay"
				value="${param.holiday_pay}"
			/>
			<button>+10</button>
			<button>-10</button></li>
		<li><b>추가근무수당:</b> <input
				type="text"
				name="total_pay"
				value=" ${param.extra_work_pay}"
			/>
			<button>+10</button>
			<button>-10</button></li>
	</ul>

	<button type="submit">수정 완료</button>
	<button type="reset">초기화</button>
</body>
</html>
