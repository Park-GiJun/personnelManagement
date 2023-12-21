package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Comments.CommentsDAO;


 
@WebServlet("/Controller/CommentsDeletionController.do")
public class CommentsDeletionController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("댓글삭제 컨트롤러");
		 CommentsDAO dao = new CommentsDAO(); 
		
		 int Trun = Integer.parseInt(request.getParameter("boardNum"));
		 System.out.println(Trun);
		 dao.EliminationsComments(Trun);
		 
		request.getRequestDispatcher("/Controller/ReturnCommentsController.do").forward(request, response);
	}
}
