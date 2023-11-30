package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Personal.PersonalDAO;
import Personal.PersonalDTO;

@WebServlet("/Controller/login.do")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 매개변수 지정
		String loginNum = request.getParameter("login_Id");
		String loginPassword = request.getParameter("login_Pwd");

		PersonalDAO dao = new PersonalDAO();
		PersonalDTO dto = dao.loginQuery(loginNum, loginPassword);

		String inploginNum = String.valueOf(dto.getEmpNum());
		String inploginPwd = dto.getPassword();

		System.out.println("inp : " + inploginNum + " " + inploginPwd + " db : " + loginNum + " " + loginPassword);

		if (inploginNum.equals(loginNum) && inploginPwd.equals(loginPassword)) {
			// 로그인 성공
			request.getSession().setAttribute("login_id", loginNum);
			response.sendRedirect("../Calender/Calender.jsp");
		} else {
			// 로그인 실패
			response.sendRedirect("Login_View.jsp"); // 로그인 실패 시 다시 로그인 페이지로 리다이렉트
		}
	}
}