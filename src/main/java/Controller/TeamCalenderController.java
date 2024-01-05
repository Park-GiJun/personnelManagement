package Controller;

import java.io.IOException;
import java.time.LocalDate;
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

import Calender.CompanyCalDTO;
import Calender.TeamCalDAO;
import Calender.TeamCalDTO;
import utils.BoardPage;



@WebServlet("/Controller/TeamCalenderController.do")
public class TeamCalenderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("Team_Cal.do");
		 System.out.println();
		// DAO 생성
		TeamCalDAO dao = new TeamCalDAO();
		HttpSession session = request.getSession();
		
		// Map 생성.
		Map<String, Object> map = new HashMap<String, Object>();
		
		LocalDate now = LocalDate.now();
		String selecteddate2 = now.toString();
		
		String searchField = request.getParameter("searchField");
		String searchWord = request.getParameter("searchWord");
		String selectedDay = request.getParameter("selectedDay");  // 월
		String searchCategory = request.getParameter("searchCategory");
		System.out.println("confirm : " + selectedDay);
		
		
		// 검색 단어가 비어있지 않을 경우
		if (searchWord != null) {
			map.put("searchCategory", searchCategory);
			map.put("searchWord", searchWord);
		}

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
		
		
			
		String selectedYear = request.getParameter("selectedYear");  // 년도
		String selectedMonth = request.getParameter("selectedMonth");   // 월
		
		
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
		} else {
		    // selectedDay가 null이거나 비어있는 경우 처리
		    // 적절한 로깅 또는 예외 처리를 수행
		}
		
		
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
		
		
		String team_what = dao.TeamFind(emp_num);
		String team_a = team_what;
		System.out.println("팀 이름 : " + team_a);
		System.out.println();
		
		/* 페이지 처리 start */
		int totalCount = dao.ScheduleListCount(selecteddate); // 게시물 개수
		
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
				
		List<TeamCalDTO> calenderlists = dao.selectListPage(selecteddate, team_a);	
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
	    
	    System.out.print("추가하기 기능 확인용: " + " " + selectedYear + " " + selectedMonth + " " + selectedDay);
	    System.out.println();
	    
	 // 년-월-일 중에서 일 값만 가져옴.  // 출력 제대로 됨, 값 제대로 가져옴
 		List<TeamCalDTO> calenderlists3 = dao.selectListPage3(team_a, selectedYear, selectedMonth);
 		for (TeamCalDTO dto : calenderlists3) {
             System.out.println("Team_calender_date: " + dto.getTeam_calender_date());
         }	
 		
 		List<Integer> daylist = new ArrayList<>();

 		for (TeamCalDTO item : calenderlists3) {
 		    try {
 		        int day = Integer.parseInt(item.getTeam_calender_date());
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
 		
 		
 		List<TeamCalDTO> calenderlists4 = dao.selectListPage4(selecteddate, team_a);
	    
	    
	    dao.close();
		// 포워딩
		request.setAttribute("calenderlists", calenderlists);
		//request.setAttribute("CalenderList", CalenderList);
		request.setAttribute("map2", map);
		request.setAttribute("selecteddate", selecteddate);
		request.setAttribute("calenderlists3", calenderlists3);
		request.setAttribute("calenderlists4", calenderlists4);
		//request.setAttribute("selectedSchedules", selectedSchedules); // 리스트 값
        //request.setAttribute("selectedSchedules", Arrays.asList(selectedContent));  // 화면에 선택한 일정들을 전달
		//request.getRequestDispatcher("../Calender/Scl4.jsp").forward(request, response);
		RequestDispatcher dispatcher = request.getRequestDispatcher("../Calender/Scl4.jsp");
		dispatcher.forward(request, response);
		
	}	
	
}
