<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

/* 각 종류 버튼 스타일 */
.my_btn {
	background-color: #1C427E;
	color: white;
	border: none;
	width: 98%;
	height: 200%;
	font-size: 200%;
	border-radius: 30px;
}

/* 정보등록 위치 수정 */
.middle-button-container {
	position: relative;
	margin-top: 2%;
	margin-left: 0%;
}


.middle-NewRegist-container {
        display: flex;
        justify-content: space-between;
    }

.table-container {
        width: 100%;
    }

/* 사원 추가 위치 수정 */
.middle-NewRegist-container {
	position: relative;
	margin-top: 7.5%;
	margin-left: 0%;
	margin-right:0%;
	font-size: 150%;
}

/* 사원 리스트 위치 수정 */
.middle-Employee_List-container {
	position: relative;
	margin-top: 0%;
	margin-left: 51%;
	font-size: 150%;
}

</
head> <style> /* 공통 스타일 */ * {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-size: 16px;
}

/* Left.jsp에서 사용한 스타일과 겹치지 않도록 스코프 제한 */
.content {
	margin-left: 10%; /* Left.jsp에서 사용한 .left_table의 너비와 동일하게 조절 */
	padding: 20px;
	font-size: 12px;
}
</style>
</head>
<body>
    <!-- 왼쪽 페이지 목록 -->
    <jsp:include page="../MainPage/Left.jsp" />
    <div class="content">
        <form name="vacation_form" method="post" action="../Controller/NewRegist.do" accept-charset="UTF-8">
        
            <!-- 신입사원 등록 양식 -->
            <div class="middle-NewRegist-container">
                <div class="table-container">
                    <table border="1" width="98%">
                        <tr>
                            <th colspan='4'>신입사원 정보 등록</th>
                        </tr>
                        <tr align="center">
                            <th width="25">이름</th>
                            <th width="25">사번(아이디)</th>
                            <th width="25">직급</th>
                            <th width="25">부서</th>
                        </tr>
                        <tr>
                            <td align="center">
                                <input type="text" name="name" style="width: 90%; box-sizing: border-box; text-align: center;">
                            </td>
                            <td align="center">
                                <input type="text" name="emp_num" style="width: 90%; box-sizing: border-box; text-align: center;">
                            </td>
                            <td align="center">
                                <input type="text" name="emp_grade" style="width: 90%; box-sizing: border-box; text-align: center;">
                            </td>
                            <td align="center">
                                <input type="text" name="team" style="width: 90%; box-sizing: border-box; text-align: center;">
                            </td>
                        </tr>
                    </table>
                    
                    <div class="middle-button-container">
						<button type="submit" class='my_btn'>정보등록</button>
					</div>
			
                </div>
                
                <div class="table-container">
                    <table border="1" width="98%">
                        <tr>
                            <th colspan='4'>사원 리스트</th>
                        </tr>
                        <tr align="center">
                            <th width="25">이름</th>
                            <th width="25">사번</th>
                            <th width="25">직급</th>
                            <th width="25">부서</th>
                        </tr>
                    </table>
                </div>
            </div>
        </form>
    </div>
</body>
</html>