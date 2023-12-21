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
		
		System.out.println("CalenderPlusController.do");
		System.out.println("");
		
		CalenderDAO dao = new CalenderDAO();
		
	    // 클라이언트로부터 전송된 일정 파라미터를 받아옵니다.
	    String newSchedule = request.getParameter("userInput");
	        
	    System.out.println("추가한 일정 값 확인: " + newSchedule);
	    
	    // selecteddate와 emp_num을 HttpServletRequest에서 가져와서 사용
	    String selecteddate = (String) request.getAttribute("selecteddate");
	    String emp_num = (String) request.getSession().getAttribute("loginid");
	   
	    System.out.println("가져온 값 확인: " + selecteddate + " " + emp_num);
	    
		 if (newSchedule != null) {
			 
			 dao.insertWrite(newSchedule, selecteddate, emp_num);
			 
			 response.getWriter().write("일정이 성공적으로 추가되었습니다.");
	         response.sendRedirect("../Calender/Scl.jsp");
			 
		 } else {
	            response.getWriter().write("추가할 일정이 작성되지 않았습니다.");
	        }

	   
	        
	   
	    
	    }
	
}