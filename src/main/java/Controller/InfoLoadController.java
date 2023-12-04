package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Income.IncentiveDAO;
import Income.IncentiveDTO;
import Income.Incentive_ValueDAO;
import Income.Incentive_ValueDTO;
import Personal.PersonalDAO;
import Personal.PersonalDTO;

@WebServlet("/Controller/infoLoad.do")
public class InfoLoadController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("infoLoad.do");

		String userId = (String) request.getSession().getAttribute("loginid");

		PersonalDAO personaldao = new PersonalDAO();
		PersonalDTO userinfolist = personaldao.getInfo(userId);

		Incentive_ValueDAO incentivevaluedao = new Incentive_ValueDAO();
		Incentive_ValueDTO incentivevaluelist = incentivevaluedao.load_Incentive_Value(userId);

		IncentiveDAO incentivedao = new IncentiveDAO();
		IncentiveDTO incentivelist = incentivedao.load_Incentive(userId);

		request.setAttribute("userinfolist", userinfolist);
		request.setAttribute("incentivevaluelist", incentivevaluelist);
		request.setAttribute("incentivelist", incentivelist);
		request.getRequestDispatcher("/MyInfo/Info.jsp").forward(request, response);
	}

}
