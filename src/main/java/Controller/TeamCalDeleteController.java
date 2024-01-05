package Controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Calender.CalenderDAO;
import Calender.TeamCalDAO;


@WebServlet("/Controller/TeamCalDeleteController.do")
public class TeamCalDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		System.out.println("TeamCalDeleteController.do");
		 System.out.println();
		// DAO 생성
		TeamCalDAO dao = new TeamCalDAO();
		
		// Map 생성
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		
		
		// 1. 요청 매개변수에서 선택된 일정 가져오기.
        String[] selectedSchedules = request.getParameterValues("selectedSchedules"); // 값이 안 들어옴
        
        System.out.println("selectedSchedules 값 확인: " + Arrays.toString(selectedSchedules));
        
        if (selectedSchedules != null && selectedSchedules.length > 0) {
        	//CalenderDAO dao = new CalenderDAO();
        	//dao.deleteCalender(Arrays.asList(selectedSchedules));
            // 2. 선택된 일정 삭제 로직 구현 (실제 삭제 로직으로 대체)
        	System.out.println("선택된 일정 목록:");
            for (String schedule : selectedSchedules) {
                // 실제 삭제 로직 여기에 구현 (예: 데이터베이스에서 삭제)
                // 예: CalenderDAO.deleteSchedule(schedule);
            	 dao.deleteCalender(Collections.singletonList(schedule));
                 System.out.println("선택한 일정 삭제: " + schedule);
            }

            // 3. 클라이언트에 응답 보내기 (실제 응답 로직으로 대체)
            response.getWriter().write("선택된 일정이 성공적으로 삭제되었습니다.");
            //response.sendRedirect("../Calender/Scl4.jsp");
        } else {
            response.getWriter().write("삭제할 일정이 선택되지 않았습니다.");
        }
        dao.close();
        request.setAttribute("map2", map);
        request.setAttribute("selectedSchedules", selectedSchedules);
        request.setCharacterEncoding("UTF-8");
        RequestDispatcher dispatcher = request.getRequestDispatcher("../Calender/Scl4.jsp");
        dispatcher.forward(request, response);
        
	}

}
