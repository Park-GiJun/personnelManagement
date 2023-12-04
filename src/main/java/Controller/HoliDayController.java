package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import HoliDay.HoliDayDAO;
import HoliDay.HoliDayDTO;

@WebServlet("/Controller/holiday.do")
public class HoliDayController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HoliDayDTO holidaydto = new HoliDayDTO();
		
		String start_vacation = req.getParameter("start_vacation");
		String end_vacation = req.getParameter("end_vacation");
		
		HoliDayDAO dao = new HoliDayDAO();
		dao.HoliDay_Request(start_vacation, end_vacation);
		
		System.out.println(start_vacation + " / " + end_vacation);
	}

}
