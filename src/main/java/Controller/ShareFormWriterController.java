package Controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import ShareForm.ShareFormDAO;
import ShareForm.ShareFormDTO;
import fileupload.FileUtil;
import utils.JSFunction;

@WebServlet("/Controller/ShareWrite.do")
public class ShareFormWriterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1.파일 업로드 처리===
		// 업로드 디렉터리의 물리적 경로 확인
		String userHome = System.getProperty("user.home");
		String saveDirecory = userHome + "/Workboard";

		// 초기화 매개변수로 설정한 첨부 파일 최대 용량 확인
		ServletContext application = getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));

		// 파일 업로드
		MultipartRequest mr = FileUtil.uploadFile(request, saveDirecory, maxPostSize);
		if (mr == null) {
			// 파일 업로드 실패
			JSFunction.alertLocation(response, "첨부 파일이 제한 용량을 초과합니다.", "../Controller/ShareWrite.do");
			return;
		}

		// 2.파일 업로드 외 처리
		// 폼값을 DTO에 저장

		ShareFormDTO dto = new ShareFormDTO();
		dto.setTitle(mr.getParameter("sharetitle"));
		dto.setPassword(mr.getParameter("sharepassword"));
		
		

		// 원본 파일명과 저장된 파일 이름 설정
		String fileName = mr.getFilesystemName("shareOfile");
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

			dto.setShareofile(fileName); // 원래 파일 이름
			dto.setSharesfile(newFileName); // 서버에 저장된 파일 이름
		}

		// DAO를 통해 DB에 게시 내용 저장
		ShareFormDAO dao = new ShareFormDAO();
		dao.insertFile(dto);
		dao.close();
	}

}
