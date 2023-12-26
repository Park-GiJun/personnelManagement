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

import WorkDocs.WorkDocsDAO;
import WorkDocs.WorkDocsDTO;
import utils.BoardPage;

@WebServlet("/Controller/WorkBoardList.do")
public class WorkBoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		WorkDocsDAO dao = new WorkDocsDAO();
		Map<String, Object> map = new HashMap<String, Object>();

		String loginId = (String) request.getSession().getAttribute("loginid");
		
		String searchCategory = request.getParameter("Category");
		String searchWord = request.getParameter("searchWord");

		// 검색 단어가 비어있지 않을 경우
		if (searchWord != null) {
			map.put("Category", searchCategory);
			map.put("searchWord", searchWord);
		}

		int totalCount = dao.WorkDocsListCount(map, loginId); // 게시물 개수

		/* 페이지 처리 start */
		ServletContext application = getServletContext();
		int pageSize = 22;
		int blockSize = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

		// 현재 페이지 확인
		int pageNum = 1; // 기본값
		String pageTemp = request.getParameter("pageNum");
		if (pageTemp != null && !pageTemp.equals("")) {
			pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정
		}

		// 목록에 출력할 게시물 범위 계산
		int start = (pageNum - 1) * pageSize + 1; // 첫 게시물 번호
		int end = pageNum * pageSize;
		map.put("start", start);
		map.put("end", end);

		/* 페이지 처리 end */

		List<WorkDocsDTO> list = dao.boardList(loginId, map);

		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockSize, pageNum,
				"../Controller/WorkBoardList.do");

		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);

		request.setAttribute("workdocslist", list);
		request.setAttribute("map", map);
		request.getRequestDispatcher("../WorkBoard/WorkBoardMain.jsp").forward(request, response);

	}
}
