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

@import url('https://fonts.googleapis.com/css2?family=Kanit:wght@700;900&display=swap');

*{
   margin: 0; padding: 0;
    box-sizing: border-box;
}

.re_day {
	text-align: center;
	font-size: 35px;
	position: absolute;
	color : orange;
    top: 15px;
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
    cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.plus_btn:hover {
  color: white;
  background: orange;
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
    cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
.del_btn:hover {
  color: white;
  background: orange;
}


.content1 {
	font-size: 20px;
	position: absolute;
	color : #fff;	
	top : 1px
	
	cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

.content2 {
	font-size: 20px;
	position: absolute;
	color : #fff;	
}

.content3 {
	font-size: 20px;
	position: absolute;
	color : #fff;
}


.reverse{
  top:30px;
  animation-direction:reverse;
  
   overflow: auto;

   position:absolute;
  left:1600px;
  width:330px;
  height:950px;
  background:#1C427E;
  color:#fff;
  /* animation-name:direction; */
  animation-duration:2s;
  animation-iteration-count:3;
  animation-timing-function:ease-in;
}

.reverse::-webkit-scrollbar {
    display: none; /* 스크롤 기능은 계속 적용되지만 안 보이게 설정 */
}

@-webkit-keyframes direction {
  from{
    left:40px;
  }
  to{
    left:300px;
  }
}



.reverse2{
  top:140px;
  
  
   overflow: auto;

   position:absolute;
  left:10px;
  width:310px;
  height:900px;
  background: #1C427E;
  color:#fff;
  /* animation-name:direction; */
  animation-duration:2s;
  animation-iteration-count:3;
  animation-timing-function:ease-in;
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
  
  cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
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
  
  cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
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
  
  cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
}

/* 버튼에 마우스를 올리면 알려주는 마우스 포인터 설정 */
button.my_btn3:hover {
  color: white;
  background: orange;
}


/* 회사 일정 버튼 */
.my_btn4 {
  background-color: #1C427E;
  color: white;
  border: none;
  
  width: 150px;
  height: 70px;
  
  font-size: 20px;
  border-radius: 30px;
  
  cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */
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

   cursor: pointer;  /* 버튼에 마우스를 올리면 알려주는 마우스 포인터 생성 */	
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
   margin: 70px auto;
   margin-left: 250px;
}


.calendar .title{
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
.calendar table thead tr:first-child{
   background: #1c427e;
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
   color: #ccc;
}

/* 다음달의 날짜 색상 지정 */
.calendar table td.gray2 button {
   color: #ccc;
}



</style>

<script type="text/javascript">
function change() {
   var f = document.frm;
 
   f.submit();
}

function showDateAndAlert(day) {
    // 클릭한 날짜를 JavaScript 변수에 저장
    var clickedDay = day;
    // 클릭한 날짜를 해당 <h2> 요소에 표시
    document.querySelector('.re_day').innerText = "<%= year %>년 <%= month %>월 " + clickedDay + "일";

    // 클릭한 날짜를 alert 창에도 표시
    alert('클릭한 날짜: ' + clickedDay + '일');

    // 여기에서 필요한 작업 수행 가능
    // 예를 들어, 다른 요소에도 표시하려면
    document.querySelector('.content1').innerText = "1. 일정1";
    document.querySelector('.content2').innerText = "2. 일정2";
    document.querySelector('.content3').innerText = "3. 일정3";
    
    // 원하는 작업 수행 가능
    // 예를 들어, 다른 페이지로 이동하려면 window.location.href = '다른페이지.jsp';
}

//일정 추가하기 버튼 눌렀을 때 설정
function confirmPlus() {
    while (true) {
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
                
                var existingParagraphs = document.querySelectorAll('.reverse p');
                var lastParagraph = existingParagraphs[existingParagraphs.length - 1];
                
                if (lastParagraph) {
                    lastParagraph.insertAdjacentElement('afterend', newParagraph);
                }
                
                window.alert("일정이 추가되었습니다");
                break;
            } else {
                window.alert("취소되었습니다");
                break;
            }
        } else if (userInput === "") {
            // 사용자가 "확인"을 클릭하고 값을 입력하지 않은 경우
            alert("일정을 입력해주세요.");
        } else {
            // 사용자가 "취소"를 클릭하거나 대화상자를 아무 값도 입력하지 않고 닫은 경우
            console.log("사용자가 대화상자를 취소했거나 닫았습니다.");
            break;
        }
    }
}

// 일정 삭제하기 버튼 눌렀을 때 설정
function confirmDelete() {
    // 일정 삭제 여부를 물어보고 결과에 따라 메시지 표시
    var result = window.confirm("일정을 삭제하시겠습니까?");
    if (result) {
    	var paragraphs = document.querySelectorAll('.reverse p');
        var lastParagraph = paragraphs[paragraphs.length - 1];
        window.alert("삭제되었습니다");
        
        if (lastParagraph) {
            lastParagraph.remove();
        }
    } else {
        // 사용자가 "취소"를 클릭한 경우
        // 추가적인 작업을 수행하거나 아무 작업도 하지 않음
    }
}


function addContent(contentText) {
    // 새로운 <p> 엘리먼트 생성
    var newParagraph = document.createElement('p');
    newParagraph.textContent = contentText;

    // 이미 존재하는 <p> 엘리먼트들을 가져옴
    var existingParagraphs = document.querySelectorAll('.reverse1 p');

    // 새로운 <p> 엘리먼트의 위치를 계산하여 추가
    var newTopPosition = (existingParagraphs.length) * 40; // 40px 간격으로 조절, 원하는 값으로 수정 가능
    newParagraph.style.top = newTopPosition + 'px';

    // 새로운 <p> 엘리먼트를 컨테이너에 추가
    document.getElementById('contentContainer').appendChild(newParagraph);
}



//DOM 요소를 선택
//var contentContainer = document.getElementById('contentContainer');

// <p> 요소들을 선택
//var paragraphs = contentContainer.querySelectorAll('p');

// <p> 요소들을 순회하면서 순서대로 출력
//paragraphs.forEach(function (paragraph, index) {
   // console.log(paragraph.textContent); // 순서대로 출력
//});

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
      <button class='my_btn' onclick="location.href='Person_Cal.jsp';" >개인 일정</button>
      <button class='my_btn2' onclick="location.href='Team_Vcation.jsp';">부서 휴가</button>
      <button class='my_btn3' onclick="location.href='Team_Cal.jsp';">부서 일정</button>
      <button class='my_btn4' onclick="location.href='Company_Cal.jsp';">회사 일정</button>
   </div>
   
	<p class="em" style="font-size: 200px"><%= month %></p> <!-- 화면 달력의 월 표시 -->
	
	<button class='next_btn' onclick="location.href='Calender.jsp';">></button>
	
	<div class="reverse">
		 <h2 class='re_day'><%= year %>년 <%= month %>월 <%= day %>일</h2>
		 
		 <button class='plus_btn' onclick="confirmPlus();">추가하기</button>
		 <button class='del_btn' onclick="confirmDelete();">삭제하기</button>
		 
		 <div class="reverse2" id="contentContainer" >
		 	<p class='content1' onclick="location.href='Calender.jsp';">  </p>
		 </div>	 
	</div>
  
  	

   <div class="calendar" style="width: 1300px; height: 300px;">
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
			
            int click_day = 0;
            // 1일부터 말일까지 출력
            int lastDay = cal.getActualMaximum(Calendar.DATE);
            String cls;
            for (int i = 1; i <= lastDay; i++) {
               cls = year == ty && month == tm && i == td ? "today" : "";

               out.print("<td class='" + cls + "'><button onclick=\"showDateAndAlert(" + i + ")\">" + i + "</button></td>");
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