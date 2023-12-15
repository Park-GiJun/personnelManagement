package Controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Reference.ReferenceDAO;
import Reference.ReferenceDTO;

@WebServlet("/Contorller/ReferenceLoad.do")
public class ReferenceLoadController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ReferenceDAO dao = new ReferenceDAO();

		Map<String, ReferenceDTO> RefMap = dao.loadRef();

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		// Gson 라이브러리 사용하여 JSON 형태로 응답
		Gson gson = new Gson();
		String jsonString = gson.toJson(RefMap);

		response.getWriter().write(jsonString);

	}

}
