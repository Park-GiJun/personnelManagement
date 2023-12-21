package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Calender.CalenderDAO;


@WebServlet("/Controller/CalenderPlusController.do")
public class CalenderPlusController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("CalenderDeleteController.do");
		System.out.println("");
		
		CalenderDAO dao = new CalenderDAO();
		
	    // 클라이언트로부터 전송된 일정 파라미터를 받아옵니다.
	    String newSchedule = request.getParameter("userInput");
	        
	    System.out.println("추가한 일정 값 확인: " + newSchedule);
	    
	    String selectedDay = request.getParameter("selectedDay");
		
		System.out.println("confirm : " + selectedDay);
		
		/* 참고
		if (Integer.parseInt(selectedDay) < 10) {
			selectedDay = "0" + selectedDay;
		}
		*/
		
		// 년-월-일 에서 1~9일은 앞에 0을 붙여주는 코드
		if (selectedDay != null && !selectedDay.isEmpty()) {
		    // selectedDay가 null이 아니고 비어있지 않은 경우에만 변환 시도
		    int dayValue;
		    try {
		        dayValue = Integer.parseInt(selectedDay);

		        // 변환된 값이 10보다 작으면 앞에 0을 붙여서 문자열로 만듦
		        if (dayValue < 10) {
		            selectedDay = "0" + dayValue;
		        }
		    } catch (NumberFormatException e) {
		    	
		    }
		} else {
		    // selectedDay가 null이거나 비어있는 경우 처리
		    // 적절한 로깅 또는 예외 처리를 수행
		}
			
		String selectedYear = request.getParameter("selectedYear");
		String selectedMonth = request.getParameter("selectedMonth");
		String selecteddate = selectedYear + "-" + selectedMonth + "-" + selectedDay;
		String emp_num = (String) request.getSession().getAttribute("loginid");
		
		System.out.println("aaaaa " + selecteddate);

	    dao.insertWrite(newSchedule, selecteddate, emp_num);
	        
	    // 처리 후 필요한 응답을 클라이언트로 전송할 수 있습니다.
	    response.getWriter().write("일정이 성공적으로 추가되었습니다.");
	    response.sendRedirect("../Calender/Scl.jsp");
	    
	    
	    request.setAttribute("selecteddate", selecteddate);
        RequestDispatcher dispatcher = request.getRequestDispatcher("../Calender/Scl.jsp");
        dispatcher.forward(request, response);
        return;
	    
	    }
	
}
