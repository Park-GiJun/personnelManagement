package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import FreeboardForm.FreeboardFormDAO;

@WebServlet("/Controller/FreeboardWrite.do")
public class FreeboardWriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String title = request.getParameter("Freeboardtitle");
		String content = request.getParameter("Freeboardcontent");
		int pass = Integer.parseInt(request.getParameter("Freeboardpassword")); 
		
		System.out.println("title " + title + " content : " + content + " pass : " + pass );
		
		FreeboardFormDAO dao = new FreeboardFormDAO();
		
		dao.freeinsertWrite(title, content, pass);
		
		
		
	}

}
