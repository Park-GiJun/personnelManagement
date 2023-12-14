package Controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Calender.CalenderDAO;
import Calender.CalenderDTO;
import utils.BoardPage;

/**
 * Servlet implementation class CalenderController
 */
@WebServlet("/Controller/CalenderController.do")
public class CalenderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("Person_Cal.do");
		
		// DAO 생성
		CalenderDAO dao = new CalenderDAO();
		
		// Map 생성
		Map<String, Object> map = new HashMap<String, Object>();
		
		String searchField = request.getParameter("searchField");
		String searchWord = request.getParameter("searchWord");
		String selectedDay = request.getParameter("selectedDay");
		
		System.out.println("confirm : " + selectedDay);
		
		if (Integer.parseInt(selectedDay) < 10) {
			selectedDay = "0" + selectedDay;
		}
			
		String selectedYear = request.getParameter("selectedYear");
		String selectedMonth = request.getParameter("selectedMonth");
		String selecteddate = selectedYear + "-" + selectedMonth + "-" + selectedDay;
		String emp_num = (String) request.getSession().getAttribute("loginid");
		
		System.out.println("aaaaa " + selecteddate);
		
		
		if (searchWord != null) {
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}
		
		/* 페이지 처리 start */
		int totalCount = dao.ScheduleListCount(selecteddate, emp_num); // 게시물 개수
		
		ServletContext application = getServletContext();
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int blockSize = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		
		// 현재 페이지 확인
		int pageNum = 1; // 기본값
		String pageTemp = request.getParameter("pageNum");
		if (pageTemp != null && !pageTemp.equals("")) {
			pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정
		}

		// 목록에 출력할 게시물 범위 계산
		int start = (pageNum + 1) * pageSize + 1; // 첫 게시물 번호
		int end = pageNum * pageSize;
		map.put("start", start);
		map.put("end", end);
		/* 페이지 처리 end */
				
		List<CalenderDTO> calenderlists = dao.selectListPage(selecteddate, emp_num);	
		
		
		String action = request.getParameter("action");

		if ("delete".equals(action)) {
		    // 삭제 작업 처리
		    String personalDiarayScheduleToDelete = request.getParameter("Personal_diaray_schedule");
		    int deleteResult = dao.deletePost(personalDiarayScheduleToDelete);

		    // 선택적으로 deleteResult를 확인하고 메시지 설정 가능
		    if (deleteResult > 0) {
		        request.setAttribute("deleteMessage", "이벤트가 성공적으로 삭제되었습니다");
		    } else {
		        request.setAttribute("deleteMessage", "이벤트 삭제에 실패했습니다");
		    }
		}

		

		// 페이징 이미지 전달
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockSize, pageNum, "../Controller/Calender.do");
		
		// 바로가기 영역 HTML 문자열
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);

		// 포워딩
		request.setAttribute("calenderlists", calenderlists);
		request.setAttribute("map2", map);
		request.setAttribute("selecteddate", selecteddate);
		request.getRequestDispatcher("../Calender/Scl.jsp").forward(request, response);
		
		
	}
	
	
	
	

}