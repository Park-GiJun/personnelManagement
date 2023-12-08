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

import NewRegist.NewRegistDAO;
import NewRegist.NewRegistDTO;
import utils.BoardPage;

@WebServlet("/Controller/NewRegist.do")
public class NewRegistController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		String grade = "";
		String name = req.getParameter("name");
		String emp_num = req.getParameter("emp_num");
		String emp_grade = req.getParameter("emp_grade");
		String team = req.getParameter("team");
		// 부서별 검색
		String department = req.getParameter("department");
		System.out.println(department);
		
		if (emp_grade.equals("부장")) {
			grade = "2";
		} else if (emp_grade.equals("차장")) {
			grade = "3";
		} else if (emp_grade.equals("과장")) {
			grade = "4";
		} else if (emp_grade.equals("대리")) {
			grade = "5";
		} else if (emp_grade.equals("사원")) {
			grade = "6";
		} else if (emp_grade.equals("인턴")) {
			grade = "7";
		}

		System.out.println("[" + grade + "]");
		System.out.println("[" + name + "]");
		System.out.println("[" + emp_num + "]");
		System.out.println("[" + emp_grade + "]");
		System.out.println("[" + team + "]");

		NewRegistDAO dao = new NewRegistDAO();
		//사원 등록
		dao.NewRegist(name, emp_num, emp_grade, team, grade);
		//휴가테이블 사원정보 입력
		dao.NewRegistHoliday(emp_num);
		
		Map<String, Object> map = new HashMap<String, Object>();

		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		if (searchWord != null) {
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}

		// 사원수 조회
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

		// 사원 목록 받기
		List<NewRegistDTO> selectList = dao.selectList(map);

		dao.close();// DB 연결닫기

		// 뷰에 전달할 매개 변수 추가
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "../HoliDay/HoliDay.do");

		// 바로가기 영역 HTML 문자열
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);

		// 전달할 데이터를 request 영역애 저장후 List.jsp 로 포워드
		req.setAttribute("selectList", selectList);
		req.setAttribute("map", map);
		req.getRequestDispatcher("/NewRegist/NewRegist.jsp").forward(req, resp);
	}
}
