package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Calender.CalenderDAO;


@WebServlet("/Controller/CalenderPlusController.do")
public class CalenderPlusController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("CalenderPlusController.do");
		System.out.println();
		
		CalenderDAO dao = new CalenderDAO();
		HttpSession session = request.getSession();
		
		
	    // 클라이언트로부터 전송된 일정 파라미터를 받아옵니다.
	    String newSchedule = request.getParameter("userInput");
	        
	    System.out.println("추가한 일정 값 확인: " + newSchedule);
	    
	    String selectedDay = (String) session.getAttribute("selectedDay");
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
			
	    
	    String selectedYear = (String) session.getAttribute("selectedYear");
        String selectedMonth = (String) session.getAttribute("selectedMonth");

	    String selecteddate = selectedYear + "-" + selectedMonth + "-" + selectedDay;
	    
	    // selecteddate와 emp_num을 HttpServletRequest에서 가져와서 사용
	    //String selecteddate = (String) request.getSession().getAttribute("selecteddate");
	    String emp_num = (String) request.getSession().getAttribute("loginid");
	 
	    
	    System.out.println("가져온 값 확인: " + selecteddate + " " + emp_num);
	    
		 if (newSchedule != null) {
			 
			 dao.insertWrite(newSchedule, selecteddate, emp_num);
			 
			 response.getWriter().write("일정이 성공적으로 추가되었습니다.");
			 System.out.println("일정 추가 성공~!!!!!!!!!!");
	         response.sendRedirect("../Calender/Scl.jsp");
			 
		 } else {
	            response.getWriter().write("추가할 일정이 작성되지 않았습니다.");
	        }

		 dao.close();
		 request.setAttribute("selecteddate", selecteddate);
		 
	   
	    
	    }
	
}