package Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.Gson;

import Personal.PersonalDAO;
import Personal.PersonalDTO;

@WebServlet("/Controller/addEMP.do")
public class addEMPTableController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("addEMP");
		StringBuilder sb = new StringBuilder();
		BufferedReader reader = request.getReader();
		String line;
		while ((line = reader.readLine()) != null) {
			sb.append(line);
		}

		String jsonString = sb.toString();

		JSONObject str = new JSONObject(jsonString);

		String empNum = str.getString("selectedEmpNums");

		System.out.println("empnum : " + empNum);

		PersonalDAO dao = new PersonalDAO();

		PersonalDTO dto = dao.findPerson(empNum);

		// Convert PersonalDTO to JSON using Gson
		Gson gson = new Gson();
		String json = gson.toJson(dto);
		
		dao.close();

		// Set response type to JSON
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		// Send JSON response
		try (PrintWriter out = response.getWriter()) {
			out.print(json);
			out.flush();

		}
	}
}
