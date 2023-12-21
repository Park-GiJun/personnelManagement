package Controller;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import FreeboardForm.FreeboardFormDAO;
import FreeboardForm.FreeboardFormDTO;
import utils.BoardPage;

@WebServlet("/Controller/CrystalController.do")
public class CrystalController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	commonLogic(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	commonLogic(request, response);
    }

    private void commonLogic(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("수정 완료 컨트롤러");
    	
       
        int anno_board_num =(int) request.getSession().getAttribute("anno_board_num");

        
        int pass =Integer.parseInt(request.getParameter("Freeboardpassword"));
        
        String title = request.getParameter("Freeboardtitle");
        String content = request.getParameter("Freeboardcontent");
        
        FreeboardFormDAO dao = new FreeboardFormDAO();

        dao.crystalWrite(pass, content, title,anno_board_num);


        // 이 부분에서 forward를 수행하도록 수정
        request.getRequestDispatcher("/BulletinBoard/Comments.jsp").forward(request, response);
    }
}
