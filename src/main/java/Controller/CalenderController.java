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

import Calender.CalenderDAO;
import Calender.CalenderDTO;
import FreeboardForm.FreeboardFormDTO;
import utils.BoardPage;

/**
 * Servlet implementation class CalenderController
 */
@WebServlet("/CalenderController")
public class CalenderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("Person_Cal.do");
		
		CalenderDAO dao = new CalenderDAO();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String Person_content = request.getParameter("Person_content");
		String Person_day = request.getParameter("Person_day");
		
		
		if (Person_day != null) {
			map.put("Person_content", Person_content);
			map.put("Person_day", Person_day);
		}
		
		/* 페이지 처리 start */
		int totalCount = dao.ScheduleListCount(map); // 게시물 개수
		
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
				
		List<CalenderDTO> CalenderLists = dao.selectListPage(map);	
		
		// 게시물 목록 받기
		dao.close();

		// 페이징 이미지 전달
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockSize, pageNum, "../Controller/Calender.do");
		
		// 바로가기 영역 HTML 문자열
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);

		// 포워딩
		//request.setAttribute("CalenderLists", CalenderLists);
		request.setAttribute("map2", map);
		request.getRequestDispatcher("/BulletinBoard/FreeboardForm.jsp").forward(request, response);
	}

	

}
