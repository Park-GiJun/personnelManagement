package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import SalaryManagement.SalaryManagementDAO;
import SalaryManagement.SalaryManagementDTO;

@WebServlet("/Controller/SalaryPrint.do")
public class SalaryPrintController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("application/json;charset=UTF-8");
		
		String selectedDate = (String) request.getParameter("selectedDate");
		String userId = (String) request.getSession().getAttribute("loginid");
		
		SalaryManagementDAO dao = new SalaryManagementDAO();
		SalaryManagementDTO dto = dao.salaryPrint(userId, selectedDate);
		dao.close();
		
		String chageDateSalary = new Gson().toJson(dto);
		
		response.setContentType("application/json");
		response.getWriter().write(chageDateSalary);
		
	}

}
