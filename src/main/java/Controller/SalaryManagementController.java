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
		int num = 0;
		
		String selectTeam = (String) request.getParameter("selectTeam");
		String year = (String) request.getParameter("selectedYear");
		String month = (String) request.getParameter("selectedMonth");
		String selectTeam_num = "";
		
		if (selectTeam == null || selectTeam.equals("기본")) {
	        selectTeam = "전체";
	    }
		
		if (selectTeam.equals("개발") || selectTeam.equals("인사") || selectTeam.equals("디자인")) {
			// 사원 목록 받기
			num = 1;
		}
		
		if (selectTeam.equals("개발 1팀") || selectTeam.equals("개발 2팀") || selectTeam.equals("개발 3팀") ||
				selectTeam.equals("인사 1팀") || selectTeam.equals("인사 2팀") || selectTeam.equals("인사 3팀") ||
				selectTeam.equals("디자인 1팀") || selectTeam.equals("디자인 2팀") || selectTeam.equals("디자인 3팀")) {
				String[] Team = selectTeam.split(" ");
				selectTeam = Team[0];
				System.out.println(selectTeam);
				selectTeam_num = Team[1];
				System.out.println(selectTeam_num);
				num = 2;
		}
		
		if (selectTeam.equals("임원")) {
			num = 3;
		}
		
		SalaryManagementDAO dao = new SalaryManagementDAO();
		
		List<SalaryManagementDTO> salaryEMPList = dao.selectSalaryList(selectTeam, selectTeam_num, year, month, num);
		dao.close();
		request.setAttribute("salaryEMPList", salaryEMPList);
		
		System.out.println(year + " : " + month);
		request.getRequestDispatcher("../SalaryManagement/SalaryManagement.jsp").forward(request, response);
	}

}
