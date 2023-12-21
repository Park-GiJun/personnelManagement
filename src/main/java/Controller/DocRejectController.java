package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Approval_Code.CodeDAO;

@WebServlet("/Controller/DocReject.do")
public class DocRejectController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String code = (String) request.getParameter("code");
		System.out.println(code);

		CodeDAO dao = new CodeDAO();

		dao.rejectState(code);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"message\":\"거절 처리 완료\"}");
	}

}
