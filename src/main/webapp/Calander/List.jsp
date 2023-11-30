<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%
request.setCharacterEncoding("utf-8");

Calendar cal = Calendar.getInstance();

// 시스템 오늘날짜
int ty = cal.get(Calendar.YEAR);
int tm = cal.get(Calendar.MONTH) + 1;
int td = cal.get(Calendar.DATE);

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH) + 1;

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
<title>MainPage</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
*{
   margin: 0; padding: 0;
    box-sizing: border-box;
}

/* 각 종류 버튼 스타일 */
.my_btn {
  background-color: #1C427E;
  color: white;
  border: none;
  
  width: 150px;
  height: 70px;
  
  font-size: 20px;
  border-radius: 30px;
}

.middle-button {
    text-align: center;
    padding: 30px 30px;
    margin-left: 500px;
}

.my_btns {
background-color: #1C427E;
  color: white;
  border: none;
  
  width: 100px;
  height: 70px;
  
  font-size: 20px;
  border-radius: 30px;
  
  position: absolute;
  top: 31px;
  left: 2400px;

}




body {
   font-size: px;
   font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
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
   margin: 70px auto;
}
.calendar .title{
   position: fixed;
   top: 120px;
   left: 20px;
   width: 100%;
   z-index: 1; 
}

/* 년도, 월 선택 리스트 스타일 */
.selectField {

   border: 1px solid #999;
   padding: 15px 50px;
   border-radius: 25px;
   font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
   font-size: 20px;
   margin-left: 550px;
   
}

.selectField2 {
	
	
   border: 1px solid #999;
   padding: 15px 50px;
   border-radius: 25px;
   font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
   font-size: 20px;
   margin-left: 5px;
   
}




.calendar table {
   width: 100%;
   border-collapse: collapse;
   border-spacing: 0;
}

.calendar table thead tr:first-child{
   background: #1c427e;
}

.calendar table td{
   padding: 60px;
   text-align: center;
   border: 1px solid #ccc;
}

.calendar table td:nth-child(7n+1){
   color: red;
}
.calendar table td:nth-child(7n){
   color: blue;
}
.calendar table td.gray {
   color: #ccc;
}
.calendar table td.today{
   font-weight:700;
   background: #FFF75A;
}

//아래 오늘 날짜로 버튼
.calendar .footer{
   height: 25px;
   line-height: 25px;
   text-align: right;
   font-size: 12px;
}
</style>

<script type="text/javascript">
function change() {
   var f = document.frm;
   f.action="calendar2.jsp";
   f.submit();
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


   <div class="middle-button">
      <!-- 다른 페이지에서 불러오는 내용 -->
      <!-- <h2 class="myHeader">텍스트 입력</h2>  -->
      <button class='my_btn' onclick="location.href='Person_Cal.jsp';">개인 일정</button>
      <button class='my_btn' onclick="location.href='Person_Cal.jsp';">부서 휴가</button>
      <button class='my_btn' onclick="location.href='Person_Cal.jsp';">부서 일정</button>
      <button class='my_btn' onclick="location.href='Person_Cal.jsp';">회사 일정</button>
   </div>
   
   <div class="plus">
      <button class='my_btns' onclick="location.href='Calander.jsp';">></button>
   </div>

   <div class="calendar" style="width: 1400px; height: 300px;">
      <div class="title" >
         <form name="frm" method="post" >
            <select name="year" class="selectField" onchange="change()"  >
               <%
               for (int i = year - 50; i <= year + 50; i++) {
               %>
               <option value="<%=i%>" <%=year == i ? "selected='selected'" : ""%>><%=i%>년
               </option>
               <%
               }
               %>
            </select> <select name="month" class="selectField2" onchange="change()">
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

      <table>
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
               out.print("<td class='gray'>" + (preDate++) + "</td>");
            }

            // 1일부터 말일까지 출력
            int lastDay = cal.getActualMaximum(Calendar.DATE);
            String cls;
            for (int i = 1; i <= lastDay; i++) {
               cls = year == ty && month == tm && i == td ? "today" : "";

               out.print("<td class='" + cls + "'>" + i + "</td>");
               if (lastDay != i && (++week) % 7 == 1) {
                  out.print("</tr><tr>");
               }
            }

            // 마지막 주 마지막 일자 다음 처리
            int n = 1;
            for (int i = (week - 1) % 7; i < 6; i++) {
               // out.print("<td>&nbsp;</td>");
               out.print("<td class='gray'>" + (n++) + "</td>");
            }
            out.print("</tr>");
            %>
         </tbody>
      </table>

      <div class="footer">
         <a href="calendar2.jsp">오늘날짜로</a>
      </div>

   </div>

   


</body>
</html>