package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MeetingRoom.MeetingRoomDAO;
import MeetingRoom.MeetingRoomDTO;

import com.google.gson.Gson;

@WebServlet("/Controller/MeetingRoomList.do")
public class MeetingRoomListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String meetingRoom = request.getParameter("MeetingRoom");
		String selectedDate = request.getParameter("selectedDate");

		MeetingRoomDAO dao = new MeetingRoomDAO();
		List<MeetingRoomDTO> lists = dao.getRooms(meetingRoom, selectedDate);

		// Convert the list to JSON using Gson
		Gson gson = new Gson();
		String meetingRoomLists = gson.toJson(lists);
		dao.close();

		// Set the content type and write the JSON response
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(meetingRoomLists);
	}
}
