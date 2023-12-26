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

import org.json.JSONObject;

import WorkDocs.WorkDocsDAO;
import WorkDocs.WorkDocsDTO;
import utils.BoardPage;

@WebServlet("/Controller/selectedDateOnWorkBoard.do")
public class SelectedDateOnWorkBoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String date = request.getParameter("date");
		String loginid = (String) request.getSession().getAttribute("loginid");

		System.out.println("확인용 : " + date + " " + loginid);

		WorkDocsDAO dao = new WorkDocsDAO();
		Map<String, Object> map = new HashMap<String, Object>();
		
		int totalCount = dao.dateWorkDocsListCount(map, loginid, date); // 게시물 개수

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
		
		
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockSize, pageNum,
				"../Controller/WorkBoardList.do");

		List<WorkDocsDTO> list = dao.dateboardList(loginid, date, map);

		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);

//		request.setAttribute("workdocsdatelist", list);
//		request.setAttribute("mapdate", map);

//		// JSON 데이터 생성
//		JSONObject jsonData = new JSONObject();
//		jsonData.put("map", map);
//		jsonData.put("list", list);
//		// 추가 필요한 정보를 jsonData에 추가
//
//		// JSON 데이터를 문자열로 변환
//		String jsonString = jsonData.toString();
//
//		// 클라이언트로 JSON 응답 전송
//		response.setContentType("application/json");
//		response.setCharacterEncoding("UTF-8");
//		response.getWriter().write(jsonString);
		
		request.setAttribute("workdocslist", list);
		request.setAttribute("map", map);
		request.getRequestDispatcher("../WorkBoard/WorkBoardMain.jsp").forward(request, response);

	}

}
