package Controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import CountSalary.CountSalaryDAO;
import CountSalary.CountSalaryDTO;
import Income.IncentiveDAO;
import Income.IncentiveDTO;
import Income.Incentive_ValueDAO;
import Income.Incentive_ValueDTO;
import Personal.PersonalDAO;
import Personal.PersonalDTO;
import SalaryManagement.SalaryManagementDAO;
import SalaryManagement.SalaryManagementDTO;
import attend.AttendanceDAO;

@WebServlet("/Controller/infoLoad.do")
public class InfoLoadController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("infoLoad.do");

		String userId = (String) request.getSession().getAttribute("loginid");
		String currentDate = (String) request.getSession().getAttribute("currentDate");

		System.out.println("infoLoadController currentDate : " + currentDate);

//		PersonalDAO personaldao = new PersonalDAO();
//		PersonalDTO userinfolist = personaldao.getInfo(userId);
//
//		Incentive_ValueDAO incentivevaluedao = new Incentive_ValueDAO();
//		Incentive_ValueDTO incentivevaluelist = incentivevaluedao.load_Incentive_Value(userId);
//
//		IncentiveDAO incentivedao = new IncentiveDAO();
//		IncentiveDTO incentivelist = incentivedao.load_Incentive(userId);

		LocalDate currentDay = LocalDate.now();

		// Format the current date to store in the session or use in your application
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
		String formattedDate = currentDay.format(formatter);

		// Now you can use the 'formattedDate' in your code
		System.out.println("Current Year and Month: " + formattedDate);
		
		CountSalaryDAO cDao = new CountSalaryDAO();
		CountSalaryDTO cDTO = cDao.countSalary(userId, formattedDate);
		cDao.updateSalary(cDTO);
		
		SalaryManagementDAO dao = new SalaryManagementDAO();
		dao.noExistDate(userId, formattedDate);
		SalaryManagementDTO dto = dao.salaryPrint(userId, formattedDate);
		

		AttendanceDAO attenddao = new AttendanceDAO();
		Map<String, Map<String, String>> attendDateMap = attenddao.loadDateAttendance(userId, currentDate);

		request.setAttribute("attendDateMap", new Gson().toJson(attendDateMap));
		dao.close();
//		request.setAttribute("userinfolist", userinfolist);
//		request.setAttribute("incentivevaluelist", incentivevaluelist);
//		request.setAttribute("incentivelist", incentivelist);
		request.setAttribute("Infolist", dto);
		request.getRequestDispatcher("/MyInfo/Info.jsp").forward(request, response);
	}

}
