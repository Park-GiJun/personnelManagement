package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import attend.AttendanceDAO;
import attend.AttendanceDTO;

@WebServlet("/Controller/LoadDate.do")
public class LoadDate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userId = (String) request.getSession().getAttribute("loginid");
		int currentYear = Integer.parseInt(request.getParameter("currentYear"));
		int currentMonth = Integer.parseInt(request.getParameter("currentMonth"));

		// 업데이트된 currentYear와 currentMonth를 세션에 저장
		request.getSession().setAttribute("currentYear", currentYear);
		request.getSession().setAttribute("currentMonth", currentMonth);
		System.out.println("UserID : " + userId);
		System.out.println("LoadDateController currentYear : " + currentYear);
		System.out.println("LoadDateController currentMonth : " + currentMonth);

		AttendanceDAO attenddao = new AttendanceDAO();
		List<AttendanceDTO> attendDateList = attenddao.loadDateAttendance(userId, currentYear + "-" + currentMonth);

		request.setAttribute("attendDateList", attendDateList);
		request.getRequestDispatcher("/MyInfo/Info.jsp").forward(request, response);
	}
}
