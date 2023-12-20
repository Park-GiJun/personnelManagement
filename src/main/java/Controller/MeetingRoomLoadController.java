package Controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MeetingRoom.MeetingRoomDAO;
import MeetingRoom.MeetingRoomDTO;

@WebServlet("/Controller/MeetingRoomLoadController.do")
public class MeetingRoomLoadController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 오늘 날짜를 얻기
			LocalDate today = LocalDate.now();
			System.out.println(today);
			String Sysdate = today.toString();
			
			String selectedDate = req.getParameter("selectedDate");
		
			
		MeetingRoomDAO dao = new MeetingRoomDAO();
        List<MeetingRoomDTO> selectList;

        if (selectedDate == null || selectedDate.equals("")) {
            // 메인에서 Load 시 출력하는 코드
            selectList = dao.selectList(Sysdate);
            
        } else {
            // 날짜로 검색하는 코드
            selectList = dao.selectList(selectedDate);
            
        }
        
        req.setAttribute("selectedDate", selectedDate);
		req.setAttribute("selectList", selectList);
		req.getRequestDispatcher("/MeetingRoom/MeetingRoom.jsp").forward(req, resp);
	}
}
