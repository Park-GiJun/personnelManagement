package Controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import FreeboardForm.FreeboardFormDAO;
import FreeboardForm.FreeboardFormDTO;

@WebServlet("/Controller/BoardeditController.do")
public class BoardeditController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("BoardeditController.do");
		FreeboardFormDAO dao = new FreeboardFormDAO();
		String boardNum = request.getParameter("boardNum");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		int anno_board_num = (int) request.getSession().getAttribute("anno_board_num");
		FreeboardFormDTO dto = dao.selectChangeView(anno_board_num);
		System.out.println(anno_board_num);
		
		// 맵 생성
		Map<String, Object> map = new HashMap<String, Object>();

		String searchCategory = request.getParameter("searchCategory");
		String searchWord = request.getParameter("searchWord");
		// content가 null이 아닌 경우에만 replaceAll을 호출
		if (dto.getcontent() != null) {
			dto.setcontent(dto.getcontent().replaceAll("\r\n", "<br/>"));

		}
		request.getSession().setAttribute("anno_board_num", anno_board_num);
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("/BulletinBoard/Changeboard.jsp").forward(request, response);
	}

}
