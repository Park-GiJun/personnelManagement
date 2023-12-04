package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import HoliDay.HoliDayDAO;
import HoliDay.HoliDayDTO;

@WebServlet("/Controller/Holiday_CheckController.do")
public class Holiday_CheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HoliDayDTO dto = new HoliDayDTO();
		dto.setemp_num("2023120401");
		dto.setTeam("개발");
		
		HoliDayDAO dao = new HoliDayDAO();
		dto.setemp_num("2023120401");
		dto.setTeam("개발");
		System.out.println(dto.getAnnual());
		
	}

}
