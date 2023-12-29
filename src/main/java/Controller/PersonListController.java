package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Personal.Depart;
import Personal.PersonalDAO;

@WebServlet("/Controller/PersonList.do")
public class PersonListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("Personlist servlet");
		PersonalDAO dao = new PersonalDAO();
		
		List<Depart> org = dao.PersonList();
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		Gson gson = new Gson();
		String organization = gson.toJson(org);
		dao.close();

		response.getWriter().write(organization);
	}

}
