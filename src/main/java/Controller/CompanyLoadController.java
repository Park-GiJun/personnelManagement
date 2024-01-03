package Controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Calender.CompanyCalDAO;
import Calender.CompanyCalDTO;


@WebServlet("/Controller/CompanyLoadController.do")
public class CompanyLoadController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		CompanyCalDAO dao = new CompanyCalDAO();
		
		LocalDate now = LocalDate.now();
		String selecteddate2 = now.toString();
		System.out.println("현재 날짜 확인용 --------" + now);

		
		String emp_num = (String) request.getSession().getAttribute("loginid");
		
		

		
		List<CompanyCalDTO> calenderlists2 = dao.selectListPage2(selecteddate2);	
		
		dao.close();

		request.setAttribute("calenderlists2", calenderlists2);
		request.getRequestDispatcher("../Calender/Scl5.jsp").forward(request, response);
		
	}



}