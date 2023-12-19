package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import Personal.PersonalDAO;
import Personal.PersonalDTO;

@WebServlet("/Controller/InfoModify.do")
public class InfoModifyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PersonalDAO Personaldao = new PersonalDAO();
		
		String empNum = (String) request.getParameter("infoEmpNum");
		String modifiedPhone = (String) request.getParameter("modifiedPhone");
		String modifiedEmail = (String) request.getParameter("modifiedEmail");
		String modifiedPass = (String) request.getParameter("modifiedPass");
		
		String userId = (String) request.getSession().getAttribute("loginid");
		String currentDate = (String) request.getSession().getAttribute("currentDate");
		
		// getInfo 메서드를 통해 PersonalDTO 객체의 정보를 가져옴
        PersonalDTO Personaldto = Personaldao.getInfo(empNum);
        
		if (modifiedPass.equals("")) {
			modifiedPass = Personaldto.getPassword();
			System.out.println("기존 비밀번호 : " + Personaldto.getPassword());
		}
		
		Personaldao.modifyInfo(empNum, modifiedPhone, modifiedEmail, modifiedPass);
	}

}
