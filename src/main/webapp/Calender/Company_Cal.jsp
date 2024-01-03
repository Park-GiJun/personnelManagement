<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.List" %>

<%
request.setCharacterEncoding("utf-8");

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
<title>회사 일정</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">

@import url('https://fonts.googleapis.com/css2?family=Kanit:wght@700;900&display=swap');

*{
   margin: 0; padding: 0;
    box-sizing: border-box;
}

/* 일정 나오는 곳 설정 (여기에서는 의미 없음) */
.scl{
  top:480px;
  animation-direction:scl;
  
  position:absolute;
  left:985px;
  width:185px;
  height:20px;
  background-color :#1C427E;
  border: none;
  color:#fff;
  
  font-size: 13px;
  /* animation-name:direction; */
  animation-duration:2s;
  animation-iteration-count:3;
  animation-timing-function:ease-in;
  position: relative; /* 상대적인 위치 지정 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.scl:hover {
  color:#fff;
  background:green;
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
  
  cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 개인 일정 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
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
  
  cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 부서 휴가 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
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
  
  cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 부서 일정 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
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
  
  cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 회사 일정 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.my_btn4:hover {
  color: white;
  background: orange;
}


/* 개인 일정, 부서 휴가, 부서 일정, 회사 일정 버튼 위치 */
.middle-button {
    text-align: center;
    padding: 30px 30px;
    margin-left: -120px;
    font-family: 'Kanit', sans-serif;
}

/* 일정 리스트 불러오는 버튼 설정 */
.next_btn {
background-color: #1C427E;
  color: white;
  border: none;
  
  width: 100px;
  height: 70px;
  
  font-size: 20px;
  border-radius: 30px;
  
  position: absolute;
  top: 31px;
  left: 1850px;
  
  font-family: 'Kanit', sans-serif;

   cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */	
}

/* 일정 리스트 불러오는 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.next_btn:hover {
  color: white;
  background: orange;
}



/*   ↑ 여기까지 버튼 위치, 크기 조절   */


/* 크게 무슨 월인지 표시 설정 */
.em {
	color: #1C427E;
	position: absolute;
  	top: -40px;
  	left: 410px;
  	font-size: 100x;
  	border-radius: 30px;
}

day {
	 font-size: 100px;
}

body {
	background-color: #272b30;
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
   width: 700px;
   margin: 40px auto;
}



/* 년도 월 선택 리스트 설정 */
.calendar .title{
   position: absolute;
   top: 120px;
   left: 420px;
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
   margin-left: 240px;
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
.calendar table thead tr:first-child{
	background-color: rgb(68, 74, 83);
    color: white;
}

/* 요일, 날짜 칸 크기 조절 */
.calendar table td{
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
.calendar table td:nth-child(7n+1){
   color: red;
}

/* 토요일 색상 지정 */
.calendar table td:nth-child(7n){
   color: blue;
}

/* 전 월의 일 색상 */
.calendar table td.gray {
   color: #ccc;
}

/* 날짜 버튼 스타일 지정 */
.calendar table button {
	color: #fff;
   border: none;
   padding: 0;
   background: none;
   font-size: 20px;
   
   position: relative;  /* 상대적인 위치 설정 */
   top: -40px;  /* 상단 여백 조정 */
   left: -70px;  /* 왼쪽 여백 조정 */
   
   font-family: 'Kanit', sans-serif;
   
   cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.calendar table button:hover {
   color: green;
}

/* 오늘 날짜 스타일 */
.calendar table td.today{
   font-weight:700;
   background: orange;
   color: #000;
}

/* 일요일 날짜 스타일 */
.calendar table td:nth-child(7n+1) button {
   color: red;
   cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.calendar table td:nth-child(7n+1) button:hover {
   color: green;
}

/* 토요일 날짜 스타일 */
.calendar table td:nth-child(7n) button {
   color: blue;
   cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.calendar table td:nth-child(7n) button:hover {
   color: green;
}

/* 전월의 날짜 색상 지정 */
.calendar table td.gray button {
   color: #000;
}

/* 다음달의 날짜 색상 지정 */
.calendar table td.gray2 button {
   color: #000;
}



</style>

<script type="text/javascript">

function change() {
	   var f = document.frm;
	   f.submit();
	}

	function updateCalendar() {
		   var year = document.getElementById("yearSelect").value;
		   var month = document.getElementById("monthSelect").value;

		   var url = "calendar.jsp?year=" + year + "&month=" + month;
		   window.location.href = url;
	}

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

tbody {
	background : gray;
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
		<input type="hidden" name="selectedDay" id="selectedDay" value="<%=day%>"> 

   <div class="middle-button">
      <!-- 다른 페이지에서 불러오는 내용 -->
      <!-- <h2 class="myHeader">텍스트 입력</h2>  -->
      <button class='my_btn' type="button" onclick="location.href='../Calender/Person_Cal.jsp';">개인 일정</button>
			<!-- <button class='my_btn2' onclick="location.href='Team_Vcation.jsp';">부서
				휴가</button> -->
			<button class='my_btn3' type="button" onclick="location.href='../Calender/Team_Cal.jsp';">부서 일정</button>
			<button class='my_btn4' type="button" onclick="location.href='../Calender/Company_Cal.jsp';">회사 일정</button>
   </div>
   
	<p class="em" style="font-size: 200px"><%= month %></p> <!-- 화면 달력의 월 표시 -->
	
	<button class='next_btn' onclick="location.href='../Controller/CompanyLoadController.do';"><</button>
	
	<div class="reverse2">
					<c:choose>
						<c:when test="${not empty calenderlists}">
								<c:forEach items="${calenderlists}" var="row" varStatus="loop">
								<tr>
									<td style="background-color: #1C427E;">${loop.index + 1}<!-- 각 일정마다 번호 출력 -->
									</td>
									<td style="background-color: #1C427E;"><a href="#"
										class="scheduleLink"
										data-schedule="${row.company_schedule}">
											${row.company_schedule} <!-- db에 있는 개인 일정 출력 -->
									</a></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:when test="${not empty calenderlists2}">
							<c:forEach items="${calenderlists2}" var="row" varStatus="loop">
								<tr>
									<td style="background-color: #1C427E;">${loop.index + 1}<!-- 각 일정마다 번호 출력 -->
									</td>
									<td style="background-color: #1C427E;"><a href="#"
										class="scheduleLink"
										data-schedule="${row.company_schedule}">
											${row.company_schedule} <!-- db에 있는 개인 일정 출력 -->
									</a></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<!-- <td class="conti" align="center">등록된 일정이 없습니다 *^^*</td>  -->
							</tr>
						</c:otherwise>
					</c:choose>
		</div>

   <div class="calendar" style="width: 1050px; margin-top: 40px; height: 300px;">
      <div class="title" >
         <form name="frm" method="post" >
            <select id="yearSelect" name="year" class="selectField" onchange="change()"  >
               <%
               for (int i = year - 50; i <= year + 50; i++) {
               %>
               <option value="<%=i%>" <%=year == i ? "selected='selected'" : ""%>><%=i%>년
               </option>
               <%
               }
               %>
            </select> <select id="monthSelect" name="month" class="selectField2" onchange="change()">
               <%
               for (int i = 1; i <= 12; i++) {
               %>
               <option value="<%=i%>" <%=month == i ? "selected='selected'" : ""%>><%=i%>월
               </option>
               <%
               }
               %>
            </select>
         </form>
      </div>

	
      <table> <!-- 테이블 표 만드는 곳(달력 만드는 곳) -->
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
            // 1일 앞 부분
            for (int i = 1; i < week; i++) {
               //out.print("<td>&nbsp;</td>");
               out.print("<td class='gray'><button disabled>" + (preDate++) + "</button></td>");
            }

            // 1일부터 말일까지 출력
            int lastDay = cal.getActualMaximum(Calendar.DATE);
            String cls;
            
            List<Integer> daylist = (List<Integer>) request.getAttribute("daylist");
            
            for (int i = 1; i <= lastDay; i++) {
               cls = year == ty && month == tm && i == td ? "today" : "";

               out.print("<td class='" + cls
						+ "' style='min-width: 100px; max-width: 100px; width: 100px; height: 50px; position: relative;'>");
              //out.print("<td class='" + cls + "'><button onclick=\"alert('클릭한 날짜 : " + i + "일');\">" + i + "</button></td>");
              out.print("<button id=\"update\" style='max-height: 50px; min-height: 50px;' disabled>" + i + "</button>");
              
              
              int buttonStartRightPercentage = 50; // 시작 위치값 설정 (예: 30%)
						
						%>	
						<c:if test="${not empty calenderlists}"> <!-- 값이 비어있지 않을 경우 밑에 코드 실행 -->
						
						<% 
						if (daylist != null) {
							if(daylist.contains(i)) {
								out.print("<button disabled class=\"scl\" id=\"bin\" style=\"font-size: 12px; max-height: 20px; position: relative; bottom: 100%; right: calc("
					                	+ buttonStartRightPercentage + "% + 10px); background-color: #1C427E; color: white; max-height: 20px;\" onclick=\"location.href='Scl_Cal.jsp';\">일정이 있습니다.</button>");
							} 
						} 
				    	%>
						</c:if>
						<% 

						out.print("</td>");
						
               if (lastDay != i && (++week) % 7 == 1) {
                  out.print("</tr><tr>");
               }
            }

            // 마지막 주 마지막 일자 다음 처리..
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
   


</body>
</html>