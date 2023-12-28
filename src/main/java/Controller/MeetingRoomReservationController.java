package Controller;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import MeetingRoom.MeetingRoomDAO;

@WebServlet("/Contorller/MeetingRoomReservation.do")
public class MeetingRoomReservationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 받아온 JSON 데이터를 읽습니다.
		BufferedReader reader = request.getReader();
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = reader.readLine()) != null) {
			sb.append(line);
		}
		
		String emp = (String) request.getSession().getAttribute("loginid");

		String jsonContent = sb.toString();
		System.out.println("BufferedReader content: " + jsonContent);

		// Gson을 사용하여 JSON을 Java 객체로 변환합니다.
		Gson gson = new GsonBuilder().setLenient().create();
		JsonObject jsonObject = gson.fromJson(jsonContent, JsonObject.class);

		// meetingRoomId와 reservations를 각각 추출합니다.
		String meetingRoomId = jsonObject.get("meetingRoomId").getAsString();
		JsonArray reservationsArray = jsonObject.getAsJsonArray("reservations");
		
		for (JsonElement reservationElement : reservationsArray) {
			
			MeetingRoomDAO dao = new MeetingRoomDAO();
            JsonObject reservationObject = reservationElement.getAsJsonObject();
            String date = reservationObject.get("Date").getAsString();
            dao.reservationMeetingRoom(date, meetingRoomId, emp);
            
        }

	}

}
