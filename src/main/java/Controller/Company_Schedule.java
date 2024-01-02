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

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		ScheduleDAO dao = new ScheduleDAO();

		String select_date = req.getParameter("select_date");
		String content = req.getParameter("content");

		System.out.println("select_date : " + select_date);
		System.out.println("content : " + content);

		dao.Company_Schedule(select_date, content);
		dao.close();
		
		req.setAttribute("select_date", select_date);
		req.getRequestDispatcher("/Company_Schedule/Company_Schedule.jsp").forward(req, resp);
	}

}
