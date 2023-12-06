package Controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

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
		String inpTeam = String.valueOf(dto.getTeam());
		String inpemp_grade = String.valueOf(dto.getEmp_grade());
		String inploginPwd = dto.getPassword();

		System.out.println("inp : " + inploginNum + " " + inploginPwd + " db : " + loginNum + " " + loginPassword);

		// Get the current date
		LocalDate currentDate = LocalDate.now();

		// Format the current date to store in the session or use in your application
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
		String formattedDate = currentDate.format(formatter);

		// Now you can use the 'formattedDate' in your code
		System.out.println("Current Year and Month: " + formattedDate);

		if (inploginNum.equals(loginNum) && inploginPwd.equals(loginPassword))

		{
			// 로그인 성공
			request.getSession().setAttribute("loginid", loginNum);
			request.setAttribute("dto", dto);

			// Store formatted date in session 세션의 값저장
			request.getSession().setAttribute("inpemp_grade", inpemp_grade);
			request.getSession().setAttribute("currentDate", formattedDate);
			request.getSession().setAttribute("inpteam", inpTeam);
			response.sendRedirect("../Calender/Calender.jsp");

		} else {
			// 로그인 실패
			response.sendRedirect("Login.jsp"); // 로그인 실패 시 다시 로그인 페이지로 리다이렉트
		}
	}
}