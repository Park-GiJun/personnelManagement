package Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import TestCal.TestDAO;

@WebServlet("/Controller/getSchedule.do")
public class LoadScheduleController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("get Schedule 실행");
		// Gson 객체 생성
		Gson gson = new Gson();

		// 요청 본문에서 데이터를 읽어 문자열로 변환
		StringBuilder sb = new StringBuilder();
		String line;
		try (BufferedReader reader = request.getReader()) {
			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}
		}

		// JSON 문자열을 Java 객체로 변환
		String requestData = sb.toString();
		JsonObject jsonObject = gson.fromJson(requestData, JsonObject.class);

		String emp_num = (String) request.getSession().getAttribute("loginid");

		String status = jsonObject.get("status").getAsString();
		String year = jsonObject.get("year").getAsString();
		String month = String.valueOf(Integer.parseInt(jsonObject.get("month").getAsString()) + 1);

		System.out.println("get Schedule : " + status + " " + year + " " + month);

		TestDAO dao = new TestDAO();

		Map<String, List<String>> map = dao.loadSchedule(status, emp_num, year, month);

		String jsonMap = gson.toJson(map);
		
		System.out.println("확인용 : " + jsonMap);
		response.setContentType("application/json; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jsonMap);

	}

}
