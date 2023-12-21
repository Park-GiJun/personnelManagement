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

import FreeboardForm.FreeboardFormDTO;
import comments.CommentsDAO;
import comments.CommentsDTO;

@WebServlet("/Controller/CommentsController.do")
public class CommentsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("CommentsController");

		int anno_board_num = (int) request.getSession().getAttribute("anno_board_num");
		String commentscontent = request.getParameter("Commentscontent");
		int pass = Integer.parseInt(request.getParameter("commentspassword"));
		CommentsDAO dao = new CommentsDAO();
		FreeboardFormDTO dto = dao.selectdetailsView(anno_board_num);

		Map<String, Object> map = new HashMap<String, Object>();
		String seatchField = request.getParameter("searchField");
		String searchWord = request.getParameter("searchWord");

		// content가 null이 아닌 경우에만 replaceAll을 호출
		if (dto.getcontent() != null) {
			dto.setcontent(dto.getcontent().replaceAll("\r\n", "<br/>"));
		}

		/* 페이지 처리 start */
		int totalCount = dao.FreeboardListCont(map); // 게시물 개수

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

		List<CommentsDTO> CommentsFormList = dao.selectListPage(map);

		dao.commentWrite(anno_board_num, commentscontent, pass);
		// 댓글 리스트 가져오기
		List<CommentsDTO> Commentsdto1 = dao.selectView(anno_board_num);

		request.setAttribute("Commentsdto1", Commentsdto1);
		request.setAttribute("CommentsFormList", CommentsFormList);
		request.setAttribute("map2", map);
		// 포워딩

        request.setAttribute("dto", dto);
        request.getSession().setAttribute("anno_board_num", anno_board_num);
		request.getRequestDispatcher("/Controller/ReturnCommentsController.do").forward(request, response);
		

	}

}
