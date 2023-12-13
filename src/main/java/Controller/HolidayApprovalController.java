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

import HoliDay.HoliDayDTO;
import HolidayApproval.HolidayApprovalDAO;
import HolidayApproval.HolidayApprovalDTO;
import utils.BoardPage;

@WebServlet("/Controller/HolidayApprovalTrue.do")
public class HolidayApprovalController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HolidayApprovalDAO dao = new HolidayApprovalDAO();
		String approvalType = req.getParameter("approvalType");
		String approval_num = "";

		String[] selectedDepartments = req.getParameterValues("department");

		if ("false".equals(approvalType)) {
			
			// 휴가 거절
			if (selectedDepartments != null) {
				for (String department : selectedDepartments) {
					String[] values = department.split(", ");
					String emp_num = values[0];
					String start_vacation = values[1];
					String end_vacation = values[2];
					String team = values[3];
					approval_num = "3";

					dao.HolidayApprovalFalse(approval_num, emp_num, start_vacation, end_vacation, team);
					dao.holidayCalculation(emp_num, start_vacation, end_vacation);
				}
			}
		} else if ("true".equals(approvalType)) {

			// 휴가 승인
			if (selectedDepartments != null) {
				for (String department : selectedDepartments) {
					String[] values = department.split(", ");
					String emp_num = values[0];
					String start_vacation = values[1];
					String end_vacation = values[2];
					String team = values[3];
					approval_num = "2";

					dao.TeamHoliday(team, emp_num, start_vacation, end_vacation);
					dao.HolidayApprovalTrue(approval_num, emp_num, start_vacation, end_vacation, team);
				}
			}
		}

		HoliDayDTO dto = new HoliDayDTO();

		System.out.println("Holiday.do");

		String userId = (String) req.getSession().getAttribute("loginid");

		dto.setemp_num(userId);

		// 뷰에 전달할 매개 변수 저장용 맵 생성
		Map<String, Object> map = new HashMap<String, Object>();

		String searchField = req.getParameter("searchfield");
		String searchWord = req.getParameter("searchWord");

		// Map에 검색 조건 저장용 코드
		if (searchField != null && searchWord != null && !searchField.isEmpty() && !searchWord.isEmpty()) {
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}

		// 게시물 수 가져오기
		int totalCount = dao.selectCount(map);

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
		List<HolidayApprovalDTO> holidayapprovalList = dao.selectList(map);

		dao.close();// DB 연결닫기

		// 뷰에 전달할 매개 변수 추가
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum,
				"../HoliDayApproval/HoliDayApproval.do");

		// 바로가기 영역 HTML 문자열
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);

		// 전달할 데이터를 request 영역애 저장후 List.jsp 로 포워드
		req.setAttribute("holidayapprovalList", holidayapprovalList);
		req.setAttribute("map", map);
		req.getRequestDispatcher("/HolidayApproval/HolidayApproval.jsp").forward(req, resp);
	}
}
