package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Controller/CommentsController.do")
public class CommentsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("CommentsController");
        
		int anno_board_num = Integer.parseInt(request.getParameter(""));
		
		
		// 포워딩
		request.getRequestDispatcher("/BulletinBoard/FreeboardForm.jsp").forward(request, response);
	}

}
