package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Personal.PersonalDAO;
import Personal.PersonalDTO;

@WebServlet("/Controller/infoLoad.do")
public class InfoLoadController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("infoLoad.do");

		String userId = (String) request.getSession().getAttribute("login_id");

		PersonalDAO dao = new PersonalDAO();
		PersonalDTO userinfolist = dao.getInfo(userId); 
		
		request.setAttribute("userinfolist", userinfolist);
		request.getRequestDispatcher("/MyInfo/Info.jsp").forward(request, response);
	}

}
