package Controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import utils.BoardPage;
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
		String saveDirecory = userHome + "/Uploads";

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
		dto.setTitle(mr.getParameter("title"));
		dto.setPassword(mr.getParameter("sharepassword"));

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

			dto.setShareofile(fileName); // 원래 파일 이름
			dto.setSharesfile(newFileName); // 서버에 저장된 파일 이름
		}

		// DAO를 통해 DB에 게시 내용 저장
		ShareFormDAO dao = new ShareFormDAO();
		dao.insertFile(dto);

		// 맵 생성
		Map<String, Object> map = new HashMap<String, Object>();

		String searchCategory = request.getParameter("searchCategory");
		String searchWord = request.getParameter("searchWord");

		// 검색 단어가 비어있지 않을 경우
		if (searchWord != null) {
			map.put("searchCategory", searchCategory);
			map.put("searchWord", searchWord);
		}

		/* 페이지 처리 start */
		int totalCount = dao.shareListCount(map); // 게시물 개수

		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int blockSize = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

		// 현재 페이지 확인
		int pageNum = 1; // 기본값
		String pageTemp = request.getParameter("pageNum");
		if (pageTemp != null && !pageTemp.equals("")) {
			pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정
		}

		// 목록에 출력할 게시물 범위 계산
		int start = (pageNum - 1) * pageSize + 1; // 첫 게시물 번호
		int end = pageNum * pageSize;
		map.put("start", start);
		map.put("end", end);

		System.out.println("페이징 확인 : " + totalCount + " " + start + " " + end);
		/* 페이지 처리 end */

		List<ShareFormDTO> shareboardlists = dao.selectListPage(map);

		// 게시물 목록 받기
		dao.close();

		// 페이징 이미지 전달
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockSize, pageNum, "../Controller/sharelist.do");

		// 바로가기 영역 HTML 문자열
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);

		// 포워딩
		request.setAttribute("shareboardlists", shareboardlists);
		request.setAttribute("map", map);
		// 응답 처리
		// Java (서블릿)
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"message\":\"데이터 처리 완료\"}");
	}

}
