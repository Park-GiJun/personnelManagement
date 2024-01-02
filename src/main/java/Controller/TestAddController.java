package Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import TestCal.TestDAO;

@WebServlet("/Controller/TestAdd.do")
public class TestAddController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("Test Add 실행");
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
		// JSON 데이터에서 날짜와 텍스트를 추출
		String date = jsonObject.get("date").getAsString();
		String text = jsonObject.get("text").getAsString();

		TestDAO dao = new TestDAO();
		int result = dao.insertSchedule(emp_num, text, date);

		// 응답 설정
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();

		// 클라이언트에게 JSON 응답을 보냄
		JsonObject jsonResponse = new JsonObject();
		jsonResponse.addProperty("status", "success");
		out.print(gson.toJson(jsonResponse));
	}
}
