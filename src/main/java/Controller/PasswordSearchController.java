package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import PasswordSearch.PasswordSearchDAO;

@WebServlet("/Controller/PasswordSearch.do")
public class PasswordSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		PasswordSearchDAO dao = new PasswordSearchDAO();
		
		String loginNum = req.getParameter("login_Id");
		String Password = req.getParameter("Password");
		
		dao.PasswordSearch(Password, loginNum);
		
		req.getRequestDispatcher("/Login/Login.jsp").forward(req, resp);
	}

}
