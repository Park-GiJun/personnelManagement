package Controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Calender.TeamCalDAO;
import Calender.TeamCalDTO;


@WebServlet("/Controller/TeamLoadController.do")
public class TeamLoadController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		TeamCalDAO dao = new TeamCalDAO();
		
		LocalDate now = LocalDate.now();
		String selecteddate2 = now.toString();
		System.out.println("현재 날짜 확인용 --------" + now);

		
		String emp_num = (String) request.getSession().getAttribute("loginid");
		String team_what = dao.TeamFind(emp_num);
		String team_a = team_what;
		System.out.println("팀 이름 : " + team_a);
		System.out.println();
		
		

		//
		List<TeamCalDTO> calenderlists2 = dao.selectListPage2(selecteddate2, team_a);	
		
		dao.close();

		request.setAttribute("calenderlists2", calenderlists2);
		request.getRequestDispatcher("../Calender/Scl4.jsp").forward(request, response);
		
	}

	

}
