package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import SalaryManagement.SalaryManagementDAO;

@WebServlet("/Controller/ModifySalary.do")
public class SalaryModifyController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String empNumParam = request.getParameter("empNum");
        String incentiveParam = request.getParameter("incentive");
        String holidayParam = request.getParameter("holiday");
        String yearmonthParam = request.getParameter("yearmonth");
        
        System.out.println("확인용1 : " + empNumParam + " " + incentiveParam + " " + holidayParam + " " + yearmonthParam);

        // Validate and sanitize parameters (implement your validation logic)

        SalaryManagementDAO dao = new SalaryManagementDAO();

        try {
            dao.updateIncentive(empNumParam, incentiveParam, holidayParam, yearmonthParam);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Update successful");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error updating incentive information");
            e.printStackTrace(); // Log the exception for debugging purposes
        }
    }
}
