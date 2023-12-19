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

@WebServlet("/Controller/NewRegistTeamSearch.do")
public class NewRegistTeamSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String TeamSearch = req.getParameter("department_search");
		String team_num = "";
		int num = 0;

		NewRegistDAO dao = new NewRegistDAO();

		Map<String, Object> map = new HashMap<String, Object>();

		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		if (searchWord != null) {
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}

		// 사원수 조회
		int totalCount = dao.selectdepartmentCount(TeamSearch);

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

		List<NewRegistDTO> selectList = null;
		if (TeamSearch.equals("전체") || TeamSearch.equals("")) {
			selectList = dao.selectList(map);
		}
		if (TeamSearch.equals("개발") || TeamSearch.equals("인사") || TeamSearch.equals("디자인")) {
			// 사원 목록 받기
			num = 1;
			selectList = dao.selectdepartmentList(TeamSearch, team_num, num);
		}
		
		if (TeamSearch.equals("개발 1팀") || TeamSearch.equals("개발 2팀") || TeamSearch.equals("개발 3팀") ||
			TeamSearch.equals("인사 1팀") || TeamSearch.equals("인사 2팀") || TeamSearch.equals("인사 3팀") ||
			TeamSearch.equals("디자인 1팀") || TeamSearch.equals("디자인 2팀") || TeamSearch.equals("디자인 3팀")) {
			String[] Team = TeamSearch.split(" ");
			TeamSearch = Team[0];
			System.out.println(TeamSearch);
			team_num = Team[1];
			System.out.println(team_num);
			num = 2;
			selectList = dao.selectdepartmentList(TeamSearch, team_num, num);
		}
		
		if (TeamSearch.equals("임원")) {
			num = 3;
			selectList = dao.selectdepartmentList(TeamSearch, team_num, num);
		}
		
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
