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

import HoliDay.HoliDayDAO;
import HoliDay.HoliDayDTO;
import utils.BoardPage;

@WebServlet("/Controller/HolidayApplicationController.do")
public class HolidayApplicationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String userId = (String) req.getSession().getAttribute("loginid");
		String Team = (String) req.getSession().getAttribute("inpteam");
		int grade = (int) req.getSession().getAttribute("inpGrade");

		String start_vacation_year = req.getParameter("start_vacation_year");
		String start_vacation_month = req.getParameter("start_vacation_month");
		String start_vacation_day = req.getParameter("start_vacation_day");
		
		String end_vacation_year = req.getParameter("end_vacation_year");
		String end_vacation_month = req.getParameter("end_vacation_month");
		String end_vacation_day = req.getParameter("end_vacation_day");
		
		String start_vacation = start_vacation_year + "-" + start_vacation_month + "-" + start_vacation_day;
		String end_vacation = end_vacation_year + "-" + end_vacation_month + "-" + end_vacation_day;
		
		HoliDayDAO dao = new HoliDayDAO();
		// 신청한 휴가 날자 DB 저장
		dao.getHolidayApplication(userId, start_vacation, end_vacation, Team);
		// 사용가능한 휴가 계산후 DB저장
		dao.holidayCalculation(userId, start_vacation, end_vacation);
		// 사용가능한 휴가 조회
		HoliDayDTO userholidaycount = dao.selectholidaycount(userId);

		// 뷰에 전달할 매개 변수 저장용 맵 생성
		Map<String, Object> map = new HashMap<String, Object>();

		String searchField = req.getParameter("searchfield");
		String searchWord = req.getParameter("searchWord");

		if (searchField != null) {
			// 쿼리스트링으로 전달받은 매개변수 중 검색어가 있다면 map에 저장
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}

		int totalCount = dao.selectCount(userId);

		// 페이지 처리 start
		ServletContext application = getServletContext();
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

		// 현재 페이지 확인
		int pageNum = 1; // 기본값
		String pageTemp = req.getParameter("pageNum");
		if (pageTemp != null && !pageTemp.equals("")) {
			pageNum = Integer.parseInt(pageTemp);
		}

		// 목록에 출력할 게시물 범위 계산
		int start = (pageNum - 1) * pageSize + 1; // 첫게시물 번호
		int end = pageNum * pageSize; // 마지막 게시물 번호
		map.put("start", start);
		map.put("end", end);
		// 페이지 처리 end

		// 게시물 목록 받기
		List<HoliDayDTO> holidayList = dao.selectList(userId);

		dao.close();// DB 연결닫기

		// 뷰에 전달할 매개 변수 추가
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "../HoliDay/HoliDay.do");

		// 바로가기 영역 HTML 문자열
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);

		// 전달할 데이터를 request 영역애 저장후 List.jsp 로 포워드
		req.setAttribute("holidayList", holidayList);
		req.setAttribute("map", map);
		req.setAttribute("userholidaycount", userholidaycount);
		req.setAttribute("grade", grade);

		req.getRequestDispatcher("/HoliDay/HoliDay.jsp").forward(req, resp);
	}

}
