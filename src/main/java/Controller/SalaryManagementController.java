package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import SalaryManagement.SalaryManagementDAO;
import SalaryManagement.SalaryManagementDTO;

@WebServlet("/Controller/SalaryManagement.do")
public class SalaryManagementController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (((int) request.getSession().getAttribute("inpGrade")) > 2) {
			response.getWriter().write("<script>alert(\"권한이 없습니다.\");</script>");
			request.getRequestDispatcher("../Calender/Calender.jsp").forward(request, response);
		}
		
		String selectTeam = (String) request.getParameter("selectTeam");
		
		if (selectTeam == null) {
	        selectTeam = "전체";
	    }
		
		SalaryManagementDAO dao = new SalaryManagementDAO();
		
		List<SalaryManagementDTO> salaryEMPList = dao.selectSalaryList(selectTeam);
		
		request.setAttribute("salaryEMPList", salaryEMPList);
		request.getRequestDispatcher("../SalaryManagement/SalaryManagement.jsp").forward(request, response);
	}

}
