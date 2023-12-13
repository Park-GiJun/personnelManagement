package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import CountSalary.CountSalaryDAO;
import attend.AttendanceDAO;

@WebServlet("/Controller/Attend.do")
public class AttendController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
		AttendanceDAO dao = new AttendanceDAO();
		String emp_num = (String) request.getSession().getAttribute("loginid");
		
		String action = request.getParameter("action");
		String date = request.getParameter("checkdate");
		String currentTime = request.getParameter("time");
		
		System.out.println("Attend.do // emp_num : " + emp_num + " action : " + action + " date : " + date + " currentTime : " + currentTime);
		
		
		if(action.equals("arrive")) {
			dao.updateArriveTime(emp_num, date, currentTime);
		} else {
			dao.updateLeaveTime(emp_num, date, currentTime);
		}
	}

}
