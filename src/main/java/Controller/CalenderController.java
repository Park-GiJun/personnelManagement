package Controller;

import java.io.IOException;
<<<<<<< HEAD
import java.time.LocalDate;
=======
>>>>>>> refs/remotes/origin/김채은
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Calender.CalenderDAO;
import Calender.CalenderDTO;


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
		String searchCategory = request.getParameter("searchCategory");
		
		LocalDate now = LocalDate.now();
		String selecteddate2 = now.toString();
		
		
		String selectedDay = request.getParameter("selectedDay");
		String selectedYear = request.getParameter("selectedYear");
		String selectedMonth = request.getParameter("selectedMonth");
		
		System.out.println("클릭한 일자 가져오기 : " + selectedDay);
		
		
		// 검색 단어가 비어있지 않을 경우
		if (searchWord != null) {
			map.put("searchCategory", searchCategory);
			map.put("searchWord", searchWord);
		}

		
		// 년-월-일 에서 1~9일은 앞에 0을 붙여주는 코드
		if (selectedMonth != null && !selectedMonth.isEmpty()) {
		    // selectedDay가 null이 아니고 비어있지 않은 경우에만 변환 시도
		    int dayValue;
		    try {
		        dayValue = Integer.parseInt(selectedMonth);

		        // 변환된 값이 10보다 작으면 앞에 0을 붙여서 문자열로 만듦
		        if (dayValue < 10) {
		        	selectedMonth = "0" + dayValue;
		        }
		    } catch (NumberFormatException e) {
		    	
		    }
		}
		
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
		}
			
		String selecteddate = selectedYear + "-" + selectedMonth + "-" + selectedDay;
		String emp_num = (String) request.getSession().getAttribute("loginid");
		
		System.out.println("전체 일자 확인용--- : " + selecteddate);
		
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
		//int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		//int blockSize = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		
		// 현재 페이지 확인
		int pageNum = 1; // 기본값
		String pageTemp = request.getParameter("pageNum");
		if (pageTemp != null && !pageTemp.equals("")) {
			pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정
		}

		
		
		// 목록에 출력할 게시물 범위 계산
		//int start = (pageNum + 1) * pageSize + 1; // 첫 게시물 번호
		//int end = pageNum * pageSize;
		//map.put("start", start);
		//map.put("end", end);
		/* 페이지 처리 end */
				
		List<CalenderDTO> calenderlists = dao.selectListPage(selecteddate, emp_num);	
		
		
		
		// 년-월-일 중에서 일 값만 가져옴.  // 출력 제대로 됨, 값 제대로 가져옴
		List<CalenderDTO> calenderlists3 = dao.selectListPage3(emp_num, selectedYear, selectedMonth);
		for (CalenderDTO dto : calenderlists3) {
            System.out.println("Personal_diaray_date: " + dto.getPersonal_diaray_date());
        }	
		
		List<Integer> daylist = new ArrayList<>();

		for (CalenderDTO item : calenderlists3) {
		    try {
		        int day = Integer.parseInt(item.getPersonal_diaray_date());
		        daylist.add(day);
		    } catch (NumberFormatException e) {
		        // Personal_diaray_date가 숫자로 변환할 수 없는 경우 처리
		        e.printStackTrace();
		    }
		}
		for (Integer value : daylist) {
		    System.out.println("daylist 값2222222: " + value);
		}
		
		request.setAttribute("daylist", daylist);
		
		
		List<CalenderDTO> calenderlists4 = dao.selectListPage4(selecteddate2, emp_num);
		
		
		//List<CalenderDTO> CalenderList = dao.selectListPage(map);
		// 페이징 이미지 전달
		//String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockSize, pageNum, "../Controller/Calender.do");
		
		
		
		// 바로가기 영역 HTML 문자열
		//map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		//map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);
		
		request.setAttribute("selectedYear", selectedYear);
	    request.setAttribute("selectedMonth", selectedMonth);
	    request.setAttribute("selectedDay", selectedDay);


		// 포워딩
		request.setAttribute("calenderlists", calenderlists);
		request.setAttribute("calenderlists3", calenderlists3);
		request.setAttribute("calenderlists4", calenderlists4);
		request.setAttribute("map2", map);
		request.setAttribute("selecteddate", selecteddate);
		//request.getRequestDispatcher("../Calender/Scl.jsp").forward(request, response);
		//request.getRequestDispatcher("../Calender/Person_Cal.jsp").forward(request, response);
		RequestDispatcher dispatcher = request.getRequestDispatcher("../Calender/Scl.jsp");
		dispatcher.forward(request, response);
		
		//RequestDispatcher dispatcher2 = request.getRequestDispatcher("../Calender/Person_Cal.jsp");
		//dispatcher2.forward(request, response);
		
	}
	
}