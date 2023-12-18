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

@WebServlet("/Controller/MeetingRoomReservationManagement.do")
public class MeetingRoomReservationManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		MeetingRoomDAO dao = new MeetingRoomDAO();

		List<MeetingRoomDTO> list = dao.getMeetingRoomList();

		request.setAttribute("MeetingRoomList", list);
		request.getRequestDispatcher("../MeetingRoomReservationManagement/MeetingRoomReservationManagement.jsp").forward(request, response);
	}

}
