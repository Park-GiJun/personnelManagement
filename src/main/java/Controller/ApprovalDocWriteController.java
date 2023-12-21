package Controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import Approval_Code.CodeDAO;
import WorkDocs.WorkDocsDAO;
import WorkDocs.WorkDocsDTO;
import fileupload.FileUtil;
import utils.GenerateCode;
import utils.JSFunction;

/**
 * Servlet implementation class ApprovalDocWriteController
 */
@WebServlet("/Controller/ApprovalWrite.do")
public class ApprovalDocWriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("글작성 실행");
		// 1.파일 업로드 처리===
		// 업로드 디렉터리의 물리적 경로 확인
		String userHome = System.getProperty("user.home");
		String saveDirecory = userHome + "/Uploads";

		// 초기화 매개변수로 설정한 첨부 파일 최대 용량 확인
		ServletContext application = getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));

		// 파일 업로드
		MultipartRequest mr = FileUtil.uploadFile(request, saveDirecory, maxPostSize);
		if (mr == null) {
			// 파일 업로드 실패
			JSFunction.alertLocation(response, "첨부 파일이 제한 용량을 초과합니다.", "../Controller/ApprovalWrite.do");
			return;
		}

		// 2.파일 업로드 외 처리
		// 폼값을 DTO에 저장

		WorkDocsDTO dto = new WorkDocsDTO();
		String emp = (String) request.getSession().getAttribute("loginid");
		String team = (String) request.getSession().getAttribute("inpteam");
		System.out.println("로그인 아이디 불러와짐? : " + emp);

		dto.setEmp_num(emp);
		dto.setTeam(team);
		dto.setApproval_doc_title(mr.getParameter("title"));
		dto.setApproval_doc_content(mr.getParameter("content"));

		System.out.println("확인용 : " + dto.getApproval_doc_title() + " " + dto.getApproval_doc_content());

		// 원본 파일명과 저장된 파일 이름 설정
		String fileName = mr.getFilesystemName("file");
		if (fileName != null) {
			// 첨부파일이 있을 경우 파일명 변경
			// 새로운 파일명 생성
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
			String ext = fileName.substring(fileName.lastIndexOf("."));
			String newFileName = now + ext;

			// 파일명 변경
			File oldFile = new File(saveDirecory + File.separator + fileName);
			File newFile = new File(saveDirecory + File.separator + newFileName);
			oldFile.renameTo(newFile);

			dto.setApproval_doc_ofile(fileName); // 원래 파일 이름
			dto.setApproval_doc_sfile(newFileName); // 서버에 저장된 파일 이름
		}

		int count = Integer.parseInt(mr.getParameter("rowCount"));

		List<String> codeList = new ArrayList<String>();

		for (int i = 0; i < count; i++) {
			GenerateCode gc = new GenerateCode();
			String code = gc.makeCode();

			CodeDAO cDAO = new CodeDAO();
			cDAO.insertCode(code, mr.getParameter("emp" + i), mr.getParameter("state" + i));

			codeList.add(code);

		}

		WorkDocsDAO dao = new WorkDocsDAO();
		dao.writeBoard(dto, codeList);

		// 응답 처리
		// Java (서블릿)
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"message\":\"데이터 처리 완료\"}");

	}

}
