package Controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import FreeboardForm.FreeboardFormDTO;
import comments.CommentsDAO;
import comments.CommentsDTO;


@WebServlet("/Controller/ReturnCommentsController.do")
public class ReturnCommentsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		CommentsDAO dao = new CommentsDAO();
		int anno_board_num = (int) request.getSession().getAttribute("anno_board_num");
		
		Map<String, Object>map = new HashMap<String, Object>();
		String seatchField= request.getParameter("searchField");
		String searchWord= request.getParameter("searchWord");
		
		//게시물 목록받기
		FreeboardFormDTO dto = dao.selectdetailsView(anno_board_num);
		// content가 null이 아닌 경우에만 replaceAll을 호출
		if (dto.getcontent() != null) {
		    dto.setcontent(dto.getcontent().replaceAll("\r\n", "<br/>"));
		}

		//댓글 목록 받기
		List<CommentsDTO> Commentsdto1 = dao.selectView(anno_board_num);

		// 게시물 목록 받기
		dao.close();
		// 포워딩
		request.getSession().setAttribute("anno_board_num", anno_board_num);
        request.setAttribute("dto", dto);
        request.setAttribute("Commentsdto1", Commentsdto1);
		request.getRequestDispatcher("/BulletinBoard/Comments.jsp").forward(request, response);
	
	}

}
