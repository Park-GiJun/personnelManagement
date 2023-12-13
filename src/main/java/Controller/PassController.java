package Controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Calender.CalenderDAO;
import Calender.CalenderDTO;
import FreeboardForm.FreeboardFormDTO;
import utils.BoardPage;

/**
 * Servlet implementation class CalenderController
 */
@WebServlet("/Controller/PassController.do")
public class PassController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("Scl.do");
		
		// DAO 생성
		CalenderDAO dao = new CalenderDAO();
		
		// Map 생성
		Map<String, Object> map = new HashMap<String, Object>();
		
		String Personal_diaray_schedule = request.getParameter("Personal_diaray_schedule");
		String mode = request.getParameter("mode");
		
		if (mode.equals("delete")) {
			dao = new CalenderDAO();
			CalenderDTO dto = dao.selectView(Personal_diaray_schedule);
			int result = dao.deletePost(Personal_diaray_schedule);
			dao.close();
			
		}
	
	}
	
	

}
