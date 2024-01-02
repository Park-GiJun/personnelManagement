package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import FreeboardForm.FreeboardFormDAO;

@WebServlet("/Controller/EliminationController.do")
public class EliminationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("게시글 삭제 컨트롤러");
		int anno_board_num = (int) request.getSession().getAttribute("anno_board_num");

		FreeboardFormDAO dao = new FreeboardFormDAO();

		dao.Eliminations(anno_board_num);
		System.out.println("게시글 삭제 댓글 컨트롤러");
		dao.Elimination(anno_board_num);
		System.out.println("게시글 삭제 메인 컨트롤러");
		dao.close();

		request.getSession().setAttribute("anno_board_num", anno_board_num);
		response.sendRedirect(request.getContextPath() + "/Controller/FreeboardList.do");
	}

}
