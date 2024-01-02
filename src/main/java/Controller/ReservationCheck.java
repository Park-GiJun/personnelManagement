package Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import MeetingRoom.MeetingRoomDAO;
import MeetingRoom.MeetingRoomDTO;

@WebServlet("/Controller/ReservationCheck.do")
public class ReservationCheck extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
		// Get the type from the JSON payload
		

		// Get the JSON payload as a String
		StringBuilder sb = new StringBuilder();
		BufferedReader reader = request.getReader();
		String line;
		while ((line = reader.readLine()) != null) {
		    sb.append(line);
		}
		String jsonString = sb.toString();

		System.out.println(jsonString);

		Gson gson = new Gson();

		JsonObject jsonObject = gson.fromJson(jsonString, JsonObject.class);

		JsonArray selectedDataArray = jsonObject.getAsJsonArray("selectedData");
		String type = jsonObject.get("type").getAsString();


		Type listType = new TypeToken<List<MeetingRoomDTO>>() {}.getType();
		List<MeetingRoomDTO> dtoList = gson.fromJson(selectedDataArray, listType);

		System.out.println(type);
		
		
		for (MeetingRoomDTO dto : dtoList) {
			MeetingRoomDAO dao = new MeetingRoomDAO();
		    System.out.println("DTO: " + dto.getDate() + " emp " + dto.getEmpNum());
		    dao.updateReservation(dto, type);
		    
		}
		

		// Send a response if needed
		response.getWriter().write("Data received successfully");
		request.getRequestDispatcher("../Controller/MeetingRoomReservationManagement.do").forward(request, response);

    }
}

