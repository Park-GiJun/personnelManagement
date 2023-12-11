package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Personal.PersonalDAO;

@WebServlet("/Controller/InfoModify.do")
public class InfoModifyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String empNum = (String) request.getParameter("infoEmpNum");
		String modifiedPhone = (String) request.getParameter("modifiedPhone");
		String modifiedEmail = (String) request.getParameter("modifiedEmail");
		
		PersonalDAO dao = new PersonalDAO();
		dao.modifyInfo(empNum, modifiedPhone, modifiedEmail);
	}

}
