package Controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import CountSalary.CountSalaryDAO;
import CountSalary.CountSalaryDTO;
import attend.AttendanceDAO;
import attend.AttendanceDTO;

@WebServlet("/Controller/LoadDate.do")
public class LoadDateController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json;charset=UTF-8");

		String userId = (String) request.getSession().getAttribute("loginid");
		String currentDate = (String) request.getParameter("updateCurrentDate");

		System.out.println("UserID: " + userId);
		System.out.println("LoadDateController currentYear: " + currentDate);

		AttendanceDAO attenddao = new AttendanceDAO();
		Map<String, Map<String, String>> attendDateMap = attenddao.loadDateAttendance(userId, currentDate);

		System.out.println("LoadDate.do doPost 완료");
		
		CountSalaryDAO cDao = new CountSalaryDAO();
		CountSalaryDTO cDto = cDao.countSalary(userId, currentDate);
		cDao.updateSalary(cDto);
		

		// Gson을 사용하여 Map을 JSON 형식으로 변환
		String jsonAttendDateMap = new Gson().toJson(attendDateMap);
		cDao.close();

		// 응답으로 JSON 데이터 전송
		response.setContentType("application/json");
		response.getWriter().write(jsonAttendDateMap);
	}
}