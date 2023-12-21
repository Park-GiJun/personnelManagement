<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Calendar"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="Calender.CompanyCalDTO"%>
<%@ page import="Calender.CompanyCalDAO"%>

<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="fileupload.FileUtil" %>

<%
request.setCharacterEncoding("utf-8");

String name = request.getParameter("name");
String cl_year = request.getParameter("year2");
String cl_month = request.getParameter("month2");
Calendar cal = Calendar.getInstance();



// 시스템 오늘날짜
int ty = cal.get(Calendar.YEAR);
int tm = cal.get(Calendar.MONTH) + 1;
int td = cal.get(Calendar.DATE);

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH) + 1;
int day = cal.get(Calendar.DATE);

// 파라미터 받기
String sy = request.getParameter("year");
String sm = request.getParameter("month");

if (sy != null) { // 넘어온 파라미터가 있으면
	year = Integer.parseInt(sy);
}
if (sm != null) {
	month = Integer.parseInt(sm);
}

cal.set(year, month - 1, 1);
year = cal.get(Calendar.YEAR);
month = cal.get(Calendar.MONTH) + 1;

int week = cal.get(Calendar.DAY_OF_WEEK); // 1(일)~7(토)
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 리스트</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Kanit:wght@700;900&display=swap')
	;

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

.scheduleLink.selected {
        color: orange;
    }
    
.scheduleLink {
	color: white;
}    

.conti {
	text-align: center;
}

.re_day {
	text-align: center;
	font-size: 50px;
	position: absolute;
	color: orange;
	top: 2px;
	left: 40px;
}

/* 개인 일정 추가하기 버튼 설정 */
.plus_btn {
	text-align: center;
	font-size: 15px;
	position: absolute;
	background-color: #fff;
	top: 80px;
	left: 70px;
	border: none;
	color: #1C427E;
	width: 80px;
	height: 40px;
	border-radius: 30px;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.plus_btn:hover {
	color: white;
	background: orange;
}

.scl {
	top: 480px;
	animation-direction: scl;
	position: absolute;
	left: 992px;
	width: 185px;
	height: 20px;
	background-color: #1C427E;
	border: none;
	color: #fff;
	font-size: 13px;
	/* animation-name:direction; */
	animation-duration: 2s;
	animation-iteration-count: 3;
	animation-timing-function: ease-in;
	position: relative; /* 상대적인 위치 지정 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.scl:hover {
	color: #fff;
	background: green;
}

/* 개인 일정 삭제하기 버튼 설정 */
.del_btn {
	text-align: center;
	font-size: 15px;
	position: absolute;
	background-color: #fff;
	top: 80px;
	left: 160px;
	border: none;
	color: #1C427E;
	width: 80px;
	height: 40px;
	border-radius: 30px;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.del_btn:hover {
	color: white;
	background: orange;
}

.content1 {
	font-size: 20px;
	position: absolute;
	color: #fff;
	top: 1px cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

.content2 {
	font-size: 20px;
	position: absolute;
	color: #fff;
}

.content3 {
	font-size: 20px;
	position: absolute;
	color: #fff;
}

.reverse {
	top: 30px;
	animation-direction: reverse;
	overflow: auto;
	position: absolute;
	left: 1600px;
	width: 330px;
	height: 950px;
	background: #1C427E;
	color: #fff;
	/* animation-name:direction; */
	animation-duration: 2s;
	animation-iteration-count: 3;
	animation-timing-function: ease-in;
}

.reverse::-webkit-scrollbar {
	display: none; /* 스크롤 기능은 계속 적용되지만 안 보이게 설정 */
}

@
-webkit-keyframes direction {from { left:40px;
	
}

to {
	left: 300px;
}

}
.reverse2 {
	top: 140px;
	overflow: auto;
	position: absolute;
	left: 10px;
	width: 310px;
	height: 900px;
	background: #1C427E;
	color: #fff;
	/* animation-name:direction; */
	animation-duration: 2s;
	animation-iteration-count: 3;
	animation-timing-function: ease-in;
}

.reverse2::-webkit-scrollbar {
	display: none; /* 스크롤 기능은 계속 적용되지만 안 보이게 설정 */
}

/* 개인 일정 버튼 */
.my_btn {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 150px;
	height: 70px;
	font-size: 20px;
	border-radius: 30px;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.my_btn:hover {
	color: white;
	background: orange;
}

/* 부서 휴가 버튼 */
.my_btn2 {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 150px;
	height: 70px;
	font-size: 20px;
	border-radius: 30px;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.my_btn2:hover {
	color: white;
	background: orange;
}

/* 부서 일정 버튼 */
.my_btn3 {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 150px;
	height: 70px;
	font-size: 20px;
	border-radius: 30px;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.my_btn3:hover {
	color: white;
	background: orange;
}

/* 회사 일정 버튼 */
.my_btn4 {
	background-color: orange;
	color: white;
	border: none;
	width: 150px;
	height: 70px;
	font-size: 20px;
	border-radius: 30px;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.my_btn4:hover {
	color: white;
	background: orange;
}

/* 개인 일정, 부서 휴가, 부서 일정, 회사 일정 버튼 위치 */
.middle-button {
	text-align: center;
	padding: 30px 30px;
	margin-left: -170px;
	font-family: 'Kanit', sans-serif;
}

.next_btn {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 100px;
	height: 70px;
	font-size: 20px;
	border-radius: 30px;
	position: absolute;
	top: 30px;
	left: 1530px;
	font-family: 'Kanit', sans-serif;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.next_btn:hover {
	color: white;
	background: orange;
}

/*   ↑ 여기까지 버튼 위치, 크기 조절   */
.em {
	color: #1C427E;
	position: absolute;
	top: -40px;
	left: 250px;
	font-size: 100x;
	border-radius: 30px;
}

day {
	font-size: 100px;
}

body {
	font-size: px;
	font-family: 'Kanit', sans-serif;
	/*color: white;*/
}

a {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

a:active, a:hover {
	text-decoration: underline;
	color: #F28011;
}

.calendar {
	width: 1500px;
	margin: 40px auto;
	margin-left: 250px;
}

.calendar .title {
	position: absolute;
	top: 120px;
	left: 240px;
	width: 100%;
	z-index: 1;
}

/* 년도 선택 리스트 */
.selectField {
	border: 1px solid #999;
	padding: 15px 50px;
	border-radius: 25px;
	font-family: 'Kanit', sans-serif;
	font-size: 20px;
	margin-left: 330px;
	top: 10px;
}

/* 월 선택 리스트 */
.selectField2 {
	border: 1px solid #999;
	padding: 15px 50px;
	border-radius: 25px;
	font-family: 'Kanit', sans-serif;
	font-size: 20px;
	margin-left: 5px;
}

.calendar table {
	width: 100%;
	border-collapse: collapse;
	border-spacing: 0;
}

/* 요일 칸 배경 색 지정 */
.calendar table thead tr:first-child {
	background: #1c427e;
	color: white;
}

/* 요일, 날짜 칸 크기 조절 */
.calendar table td {
	padding: 40px 80px;
	text-align: left;
	border: 1px solid #ccc;
}

/* 월, 화, 수, 목, 금 글자 색상 설정 */
.calendar table td:nth-child(1)
.calendar table td:nth-child(2)
.calendar table td:nth-child(3)
.calendar table td:nth-child(4)
.calendar table td:nth-child(5) {
	color: white;
}

/* 일요일 색상 지정 */
.calendar table td:nth-child(7n+1) {
	color: red;
}

/* 토요일 색상 지정 */
.calendar table td:nth-child(7n) {
	color: blue;
}

/* 전 월의 일 색상 */
.calendar table td.gray {
	color: #ccc;
}

/* 날짜 버튼 스타일 지정 */
.calendar table button {
	border: none;
	padding: 0;
	background: none;
	font-size: 20px;
	position: relative; /* 상대적인 위치 설정 */
	top: -40px; /* 상단 여백 조정 */
	left: -70px; /* 왼쪽 여백 조정 */
	font-family: 'Kanit', sans-serif;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.calendar table button:hover {
	color: green;
}

/* 오늘 날짜 스타일 */
.calendar table td.today {
	font-weight: 700;
	background: orange;
	color: #000;
}

/* 일요일 날짜 스타일 */
.calendar table td:nth-child(7n+1) button {
	color: red;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.calendar table td:nth-child(7n+1) button:hover {
	color: green;
}

/* 토요일 날짜 스타일 */
.calendar table td:nth-child(7n) button {
	color: blue;
	cursor: pointer; /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.calendar table td:nth-child(7n) button:hover {
	color: green;
}

/* 전월의 날짜 색상 지정 */
.calendar table td.gray button {
	color: #ccc;
}

/* 다음달의 날짜 색상 지정 */
.calendar table td.gray2 button {
	color: #ccc;
}
</style>



<script type="text/javascript">

function showDateAndAlert(day) {
    // 클릭한 날짜를 JavaScript 변수에 저장
    var clickedDay = day;
    // 클릭한 날짜를 해당 <h2> 요소에 표시
    document.querySelector('.re_day').innerText = "<%=year%>년 <%=month%>월 " + clickedDay + "일";

		// 클릭한 날짜를 alert 창에도 표시
		alert('클릭한 날짜: ' + clickedDay + '일');

		// 선택한 날짜를 숨은 필드에 설정
		document.getElementById('selectedDay').value = clickedDay;

		// 폼 제출
		document.forms["calender_form"].submit();
	}




	//일정 추가하기 버튼 눌렀을 때 설정
	// 일정 추가를 위한 고유한 식별자
	var eventCounter = 1;

	function confirmPlus() {
		// 사용자로부터 입력을 받기 위한 prompt 대화상자 사용
		var userInput = prompt("추가하고자 하시는 일정을 작성해주세요 :)", "");

		// 사용자가 "확인"을 클릭하고 값을 입력한 경우
		if (userInput !== null && userInput !== "") {
			// 사용자가 "확인"을 클릭하고 값을 입력한 경우, userInput 변수에 입력된 값이 포함됩니다.
			console.log("사용자가 이벤트를 추가하려고 합니다:", userInput);

			// 일정 추가 여부를 물어보고 결과에 따라 메시지 표시
			var result = window.confirm("일정을 추가하시겠습니까?");
			if (result) {
				// 사용자가 입력을 취소하지 않은 경우 새로운 <p> 엘리먼트 생성
				var newParagraph = document.createElement('p');
				newParagraph.textContent = userInput;

				// 고유한 ID 추가
				newParagraph.id = 'event' + eventCounter;

				// 고유한 식별자를 증가시킴
				eventCounter++;

				// <div class="reverse2" id="contentContainer">에 <p> 추가
				document.getElementById('contentContainer').appendChild(newParagraph);

				window.alert("일정이 추가되었습니다");
			} else {
				window.alert("취소되었습니다");
			}
		} else if (userInput === "") {
			// 사용자가 "확인"을 클릭하고 값을 입력하지 않은 경우
			alert("일정을 입력해주세요.");
		} else {
			// 사용자가 "취소"를 클릭하거나 대화상자를 아무 값도 입력하지 않고 닫은 경우
			console.log("일정 저장을 취소하였습니다.");
		}
}

	
	
// 삭제하기 버튼 클릭 시 선택한 일정을 서버로 전송하는 함수
function confirmDelete() {
    //var selectedSchedules = Array.from(document.querySelectorAll('.scheduleLink.selected')).map(function (schedule) {
        //return schedule.getAttribute('data-schedule');
    //});

    if (selectedSchedules.length > 0) {
        var confirmed = confirm("선택한 일정을 삭제하시겠습니까?");
        if (confirmed) {
            // 수정된 부분: 선택한 일정의 ID를 서버로 전송
            sendSelectedSchedulesToServer(selectedSchedules);
        }
    } else {
        alert("삭제할 일정을 선택해주세요.");
    }
}
	 
	
// 선택한 일정 삭제를 서버로 전송하는 함수
function sendSelectedSchedulesToServer() {
    // Ajax를 사용하여 Java 서버에 배열 전송
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "../Controller/CalenderDeleteController.do", true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

    // 선택한 일정의 ID 스택을 문자열로 변환하여 서버로 전송
    //var data = "selectedSchedules=" + encodeURIComponent(scheduleStack.join(','));
    //xhr.send(data);
    
 	// 선택한 일정의 ID를 문자열 배열로 변환
    const data = JSON.stringify(selectedSchedules);
    xhr.send(data);

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                alert("일정이 삭제되었습니다.");
                // 페이지 리로드 또는 필요한 갱신 작업 수행
                location.reload();
            } else {
                alert("일정 삭제에 실패했습니다.");
            }
        }
    };
}
	 
	 
    console.log('잘 실행되는지 확인용1111111111111111111111');
	 

  // 링크 클릭 시 선택 및 해제를 토글하는 함수
  var selectedSchedules = [];  // 선택한 일정이 저장되는 곳
 
document.addEventListener('click', function (event) {
    if (event.target.classList.contains('scheduleLink')) {
        event.preventDefault();
        var selectedSchedule = event.target.getAttribute('data-schedule');
        var isSelected = event.target.classList.toggle('selected');

        alert(selectedSchedule + ' 확인용');

        // 선택한 일정을 리스트에 추가 또는 제거
        if (isSelected) {
            selectedSchedules.push(selectedSchedule);
        } else {
            // 해당 값이 리스트에 존재하면 제거
            var index = selectedSchedules.indexOf(selectedSchedule);
            if (index !== -1) {
                selectedSchedules.splice(index, 1);
            }
        }

        // 선택한 일정들을 콘솔에 출력
        console.log('선택한 일정들:', selectedSchedules);
        
    }
    
 	// Ajax를 사용하여 Java 서버에 배열 전송
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "/Controller/CalenderDeleteConteController.do", true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    //xhr.send(JSON.stringify({ array: selectedSchedules }));

});


    
</script>



</head>
<style>
/* 공통 스타일 */
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-size: 20px;
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
	margin-left: 400px; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
}

/* 유니크한 클래스로 스타일 지정 */
.myHeader {
	color: blue;
	font-size: 24px;
}
</style>
<body>
	<jsp:include page="../MainPage/Left.jsp"></jsp:include>

	<form name="calender_form" id="calender_form" method="post" action="../Controller/CompanyController.do">
		<input type="hidden" name="selectedYear" id="selectedYear" value="<%=year%>">
		<input type="hidden" name="selectedMonth" id="selectedMonth" value="<%=month%>">
		<input type="hidden" name="selectedDay" id="selectedDay" value="">
		<!-- <input type="hidden" name="selectedContent" id="selectedContent" value="selectedSchedules"> -->
		<!-- <input type="hidden" name="selectedContent" id="selectedContent" value="<c:out value="${empty row.personal_diaray_schedule ? '' : row.personal_diaray_schedule}"/>"> -->

		<div class="middle-button">
			<!-- 다른 페이지에서 불러오는 내용 -->
			<!-- <h2 class="myHeader">텍스트 입력</h2>  -->
			<button class='my_btn' onclick="location.href='Person_Cal.jsp';">개인
				일정</button>
			<button class='my_btn2' onclick="location.href='Team_Vcation.jsp';">부서
				휴가</button>
			<button class='my_btn3' onclick="location.href='Team_Cal.jsp';">부서
				일정</button>
			<button class='my_btn4' onclick="location.href='Company_Cal.jsp';">회사
				일정</button>
		</div>

		<p class="em" style="font-size: 200px"><%=month%></p>
		<!-- 화면 달력의 월 표시 -->

		<button class='next_btn' onclick="location.href='Calender.jsp';">></button>



		<div class="reverse">
			
			<h2 class='re_day'>${selecteddate}</h2>  <!-- 선택한 날짜(년,월,일) 나오는 부분 -->
		
			<button class='plus_btn' type='submit' onclick="confirmPlus();">추가하기</button>
			<button class='del_btn'  type='submit' onclick="confirmDelete();">삭제하기</button>


			<!-- db에 저장된 개인 일정 내용 가져오는 공간 -->
			<div class="reverse2">
    			<table class="caltabke" width="100%">
        			<c:choose>
            			<c:when test="${empty calenderlists}">
                			<tr>
                    			<td class="conti" align="center">등록된 일정이 없습니다 *^^*</td>
                			</tr>
            			</c:when>
            			<c:otherwise>
                			<c:forEach items="${calenderlists}" var="row" varStatus="loop">
                    			<tr>
                    				<td>
										${loop.index + 1} <!-- 각 일정마다 번호 출력 -->
									</td>
                        			<td>
                            			<a href="#" class="scheduleLink" data-schedule="${row.company_schedule}">
                                			${row.company_schedule}  <!-- db에 있는 개인 일정 출력 -->
                            			</a>
                        			</td>
                    			</tr>
                			</c:forEach>
            			</c:otherwise>
        			</c:choose>
    			</table>
			</div>

		</div>
		
		<c:if test="${not empty deleteMessage}">
    		<div>${deleteMessage}</div>
		</c:if>


		<button class="scl" onclick="location.href='Scl_Cal.jsp';">
			<font class="myFont">여기에 회사 일정 내용 담기</font>
		</button>
		<!-- 1개당 1개의 일정 제목 표시 -->



		<div class="calendar" id="calendar-container" style="width: 1300px; height: 300px;">
			<div class="title">
				<!-- 년도 월 선택 리스트 만드는 위치 -->
				<form name="frm" method="post">
					<select id="yearSelect" name="year" class="selectField"
						onchange="change()">
						<%
						for (int i = year - 50; i <= year + 50; i++) {
						%>
						<option value="<%=i%>" <%=year == i ? "selected='selected'" : ""%>><%=i%>년
						</option>
						<%
						}
						%>
					</select> <select id="monthSelect" name="month" class="selectField2"
						onchange="change()">
						<%
						for (int i = 1; i <= 12; i++) {
						%>
						<option value="<%=i%>"
							<%=month == i ? "selected='selected'" : ""%>><%=i%>월
						</option>
						<%
						}
						%>
					</select>
				</form>
			</div>


			<table>
				<!-- 테이블 표 만드는 곳(달력 만드는 곳) -->
				<thead>
					<tr>
						<td>일</td>
						<td>월</td>
						<td>화</td>
						<td>수</td>
						<td>목</td>
						<td>금</td>
						<td>토</td>
					</tr>
				</thead>
				<tbody>
					<%
					// 1일 앞 달
					Calendar preCal = (Calendar) cal.clone();
					preCal.add(Calendar.DATE, -(week - 1));
					int preDate = preCal.get(Calendar.DATE);

					out.print("<tr>");
					// 전 달 끝부분 일자 출력
					for (int i = 1; i < week; i++) {
						//out.print("<td>&nbsp;</td>");
						out.print("<td class='gray'><button disabled>" + (preDate++) + "</button></td>");
					}

					int click_day = 0;
					// 1일부터 말일까지 출력
					int lastDay = cal.getActualMaximum(Calendar.DATE);
					String cls;
					for (int i = 1; i <= lastDay; i++) {
						cls = year == ty && month == tm && i == td ? "today" : "";

						out.print("<td class='" + cls + "'><button id=\"update\" onclick=\"showDateAndAlert(" + i + ")\">" + i + "</button></td>");
						if (lastDay != i && (++week) % 7 == 1) {
							out.print("</tr><tr>");
						}
					}

					// 다음 달 첫부분 일자 출력
					int n = 1;
					for (int i = (week - 1) % 7; i < 6; i++) {
						// out.print("<td>&nbsp;</td>");
						out.print("<td class='gray'><button disabled>" + (n++) + "</button></td>");
					}
					out.print("</tr>");
					%>
				</tbody>
			</table>

		</div>

	</form>


</body>
</html>