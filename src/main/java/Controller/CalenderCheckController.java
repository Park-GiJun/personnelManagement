package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Controller/CalenderCheck.do")
public class CalenderCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override

	// CalenderCheck.java
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 요청에서 파라미터 추출
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");

		System.out.println("체크 : "  + year + " " + month + " " + day);

		// 처리 결과를 클라이언트에게 전송
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("처리된 날짜: " + year + "-" + month + "-" + day);

	}

}
