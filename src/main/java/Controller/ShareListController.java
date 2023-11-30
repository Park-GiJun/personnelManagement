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

import ShareForm.ShareFormDAO;
import ShareForm.ShareFormDTO;
import utils.BoardPage;

@WebServlet("/Controller/sharelist.do")
public class ShareListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// DAO 생성
		ShareFormDAO dao = new ShareFormDAO();

		// 매개변수 저장용 맵 생성
		Map<String, Object> map = new HashMap<>();

		String searchField = request.getParameter("searchField");
		String searchWord = request.getParameter("searchWord");

		if (searchWord != null) {
			// 비어있는 값이 아니라면 map에 저장
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}

		// 개시물 개수
		int totalCount = dao.shareListCount(map);

		/* 페이지 처리 start */
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
		int start = (pageNum - 1) * pageSize + 1; // 첫 게시물 번호
		int end = pageNum * pageSize;
		map.put("start", start);
		map.put("end", end);

		/* 페이지 처리 end */

		List<ShareFormDTO> shareboardlists = dao.selectListPage(map);

		dao.close();

		// 뷰페이지에 전달
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockSize, pageNum, "../Controller/sharelist.do");

		// 바로가기 영역 HTML 문자열
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);

		// request 영역에 저장 후 shareform을 포워드
		request.setAttribute("shareboardlists", shareboardlists);
		request.setAttribute("map", map);
		request.getRequestDispatcher("/ShareForm/ShareForm.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
