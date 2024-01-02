package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Schedule.ScheduleDAO;

@WebServlet("/Controller/Team_Schedule.do")
public class Team_ScheduleController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		ScheduleDAO dao = new ScheduleDAO();
		
		String select_date = req.getParameter("select_date");
		String content = req.getParameter("content");
		String Team = (String) req.getSession().getAttribute("inpteam");
		
		System.out.println("Team_schedule : " + select_date);
		System.out.println("content : " + content);
		System.out.println("Team : " + Team);
		
		dao.Team_Schedule(select_date, content, Team);
		dao.close();
		
		req.setAttribute("select_date", select_date);
		req.getRequestDispatcher("/Team_Schedule/Team_Schedule.jsp").forward(req, resp);
	}

}
