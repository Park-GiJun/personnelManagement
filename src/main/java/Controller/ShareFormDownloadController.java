package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fileupload.FileUtil;

@WebServlet("/Controller/ShareFormDownload.do")
public class ShareFormDownloadController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ofile = request.getParameter("ofile"); // 원본 파일명
		String sfile = request.getParameter("sfile"); // 저장된 파일명

		// 파일 다운로드
		FileUtil.download(request, response, "/Uploads/", sfile, ofile);
	}
}
