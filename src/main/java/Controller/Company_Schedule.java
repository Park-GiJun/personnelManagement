package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Schedule.ScheduleDAO;

@WebServlet("/Controller/Company_Schedule.do")
public class Company_Schedule extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ScheduleDAO dao = new ScheduleDAO();

		String Team_schedule = req.getParameter("Company_schedule");
		String content = req.getParameter("content");

		System.out.println("Team_schedule : " + Team_schedule);
		System.out.println("content : " + content);

		dao.Company_Schedule(Team_schedule, content);
		dao.close();

		req.getRequestDispatcher("/Company_Schedule/Company_Schedule.jsp").forward(req, resp);
	}

}
