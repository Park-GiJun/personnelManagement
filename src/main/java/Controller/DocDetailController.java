package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import WorkDocs.WorkDocsDAO;
import WorkDocs.WorkDocsDTO;

@WebServlet("/Controller/DocDetail.do")
public class DocDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String indx = (String) request.getParameter("idx");

		WorkDocsDAO dao = new WorkDocsDAO();

		WorkDocsDTO dto = dao.getContent(indx);

		request.setAttribute("Doc", dto);
		request.getRequestDispatcher("../WorkBoard/DocDetail.jsp").forward(request, response);

	}

}
