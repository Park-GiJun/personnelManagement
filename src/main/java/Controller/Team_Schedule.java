package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Schedule.ScheduleDAO;

@WebServlet("/Controller/Team_Schedule.do")
public class Team_Schedule extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ScheduleDAO dao = new ScheduleDAO();
		
		String Team_schedule = req.getParameter("Team_schedule");
		String content = req.getParameter("content");
		String Team = (String) req.getSession().getAttribute("inpteam");
		
		System.out.println("Team_schedule : " + Team_schedule);
		System.out.println("content : " + content);
		System.out.println("Team : " + Team);
		
		dao.Team_Schedule(Team_schedule, content, Team);
		dao.close();
		
		req.getRequestDispatcher("/Team_Schedule/Team_Schedule.jsp").forward(req, resp);
	}

}
