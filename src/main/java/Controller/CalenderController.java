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
import javax.servlet.http.HttpSession;

import Calender.CalenderDAO;
import Calender.CalenderDTO;
import utils.BoardPage;


@WebServlet("/Controller/CalenderController.do")
public class CalenderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("Person_Cal.do");
		 System.out.println("");
		// DAO 생성
		CalenderDAO dao = new CalenderDAO();
		HttpSession session = request.getSession();
		
		// Map 생성
		Map<String, Object> map = new HashMap<String, Object>();
		
		String searchField = request.getParameter("searchField");
		String searchWord = request.getParameter("searchWord");
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
		
		System.out.println(selectedYear + selectedMonth + selectedDay);
		
		System.out.println("aaaaa " + selecteddate);
		
		 session.setAttribute("selectedYear", selectedYear);
	     session.setAttribute("selectedMonth", selectedMonth);
	     session.setAttribute("selectedDay", selectedDay);
		
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

		// 페이징 이미지 전달
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockSize, pageNum, "../Controller/Calender.do");
		
		// 바로가기 영역 HTML 문자열
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);
		
		request.setAttribute("selectedYear", selectedYear);
	    request.setAttribute("selectedMonth", selectedMonth);
	    request.setAttribute("selectedDay", selectedDay);
	    
	    System.out.print("추가하기 기능 확인용: " + " " + selectedYear + " " + selectedMonth + " " + selectedDay);
	    System.out.println();

		// 포워딩
		request.setAttribute("calenderlists", calenderlists);
		request.setAttribute("map2", map);
		request.setAttribute("selecteddate", selecteddate);
		//request.setAttribute("selectedSchedules", selectedSchedules); // 리스트 값
        //request.setAttribute("selectedSchedules", Arrays.asList(selectedContent));  // 화면에 선택한 일정들을 전달
		request.getRequestDispatcher("../Calender/Scl.jsp").forward(request, response);
		
	}
	
}
