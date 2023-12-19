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

		String emp_num = (String) request.getSession().getAttribute("loginid");

		System.out.println("docdetail");

		WorkDocsDAO dao = new WorkDocsDAO();

		WorkDocsDTO dto = dao.getContent(indx);
		// First 단계 체크
		if (dto.getFirstEmp().equals(emp_num)) {
			dto.setFirstMakeButton(dto.getFirststatus().equals("대기") ? "Y" : "N");
		}

		// Second 단계 체크
		if (dto.getSecondEmp() != null && dto.getSecondEmp().equals(emp_num)) {
			if (dto.getSecondstatus().equals("대기") && dto.getFirststatus().equals("완료")) {
				dto.setSecondMakeButton("Y");
			}
		}

		// Third 단계 체크
		if (dto.getThirdEmp() != null && dto.getThirdEmp().equals(emp_num)) {
			if (dto.getThirdstatus().equals("대기") && dto.getSecondstatus().equals("완료")) {
				dto.setThirdMakeButton("Y");
			}
		}

		// Fourth 단계 체크
		if (dto.getFourthEmp() != null && dto.getFourthEmp().equals(emp_num)) {
			if (dto.getFourthstatus().equals("대기") && dto.getThirdstatus().equals("완료")) {
				dto.setFourthMakeButton("Y");
			}
		}

		// Fifth 단계 체크
		if (dto.getFifthEmp() != null && dto.getFifthEmp().equals(emp_num)) {
			if (dto.getFifthstatus().equals("대기") && dto.getFourthstatus().equals("완료")) {
				dto.setFifthMakeButton("Y");
			}
		}

		request.setAttribute("Doc", dto);
		request.getRequestDispatcher("../WorkBoard/DocDetail.jsp").forward(request, response);

	}

}
