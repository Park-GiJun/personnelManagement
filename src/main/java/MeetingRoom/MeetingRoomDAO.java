package MeetingRoom;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.google.gson.JsonElement;

import DBcontrol.DBConnPool;

public class MeetingRoomDAO extends DBConnPool {

	public MeetingRoomDAO() {
		super();
	}

	public List<MeetingRoomDTO> getRooms(String roomNunm, String date) {

		List<MeetingRoomDTO> lists = new ArrayList<MeetingRoomDTO>();

		String query = "SELECT e.team, e.name, m.emp_num, e.team AS emp_team, TO_CHAR(m.meetingdate, 'HH24') AS formatted_hour, m.status "
				+ "FROM meetingroom m " + "JOIN emp e ON m.emp_num = e.emp_num "
				+ "WHERE m.meetingroomNum=? AND TRUNC(m.meetingdate) = TO_DATE(? , 'YYYY-MM-DD')";

		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, roomNunm);
			psmt.setString(2, date);

			rs = psmt.executeQuery();

			while (rs.next()) {
				MeetingRoomDTO dto = new MeetingRoomDTO();

				dto.setEmpNum(rs.getString("emp_num"));
				dto.setTeam(rs.getString("emp_team"));
				dto.setDate(rs.getString("formatted_hour"));
				dto.setStatus(rs.getString("status"));
				dto.setName(rs.getString("name"));

				lists.add(dto);
			}

		} catch (Exception e) {
			System.out.println("방목록 불러오는중 예외 발생");
			e.printStackTrace();
		}

		return lists;

	}

	public void reservationMeetingRoom(String date, String room, String empNum) {

		System.out.println("확인용 : " + date + " " + room + " " + empNum);

		Timestamp timestamp = Timestamp.valueOf(date);

		// 수정된 SQL 쿼리
		String query = "INSERT INTO meetingroom (emp_num, meetingdate, meetingroomnum) VALUES (?, ?, ?)";

		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, empNum);
			psmt.setTimestamp(2, timestamp);
			psmt.setString(3, room);

			psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("회의실 예약 중 예외 발생");
			e.printStackTrace();
		}
	}

	public List<MeetingRoomDTO> getMeetingRoomList() {
		List<MeetingRoomDTO> list = new ArrayList<MeetingRoomDTO>();

		String query = "SELECT e.team, e.emp_num, e.name, m.meetingroomnum, TO_CHAR(m.meetingdate, 'YYYY-MM-DD HH24') AS time, m.status " +
	             "FROM meetingroom m " +
	             "JOIN emp e ON m.emp_num = e.emp_num " +
	             "ORDER BY " +
	             "  CASE " +
	             "    WHEN m.status = 'Wait' THEN 1 " +
	             "    WHEN m.status = 'Reject' THEN 2 " +
	             "    WHEN m.status = 'Confirm' THEN 3 " +
	             "    ELSE 4 " +
	             "  END, " +
	             "  TO_CHAR(m.meetingdate, 'YYYY-MM-DD HH24'), " +
	             "  e.name";

		try {

			psmt = con.prepareStatement(query);

			rs = psmt.executeQuery();

			while (rs.next()) {
				MeetingRoomDTO dto = new MeetingRoomDTO();

				dto.setTeam(rs.getString("team"));
				dto.setEmpNum(rs.getString("emp_num"));
				dto.setName(rs.getString("name"));
				dto.setMeetingroomNum(rs.getString("MEETINGROOMNUM"));
				dto.setDate(rs.getString("time"));
				dto.setStatus(rs.getString("status"));

				list.add(dto);
			}

		} catch (Exception e) {
			System.out.println("회의실 리스트 받는 중 예외 발생");
			e.printStackTrace();
		}

		return list;
	}

	public void updateReservation(MeetingRoomDTO dto, String type) {

		if (type.equals("confirm")) {
			
			System.out.println("확인 실행");
			String query = "UPDATE meetingroom SET status='Confirm' WHERE TO_CHAR(MEETINGDATE, 'YYYY-MM-DD HH24') = ? AND emp_num = ? AND meetingroomnum=?";

			try {

				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getDate());
				psmt.setString(2, dto.getEmpNum());
				psmt.setString(3, dto.getMeetingroomNum());

				psmt.executeUpdate();

			} catch (Exception e) {
				System.out.println("업데이트 confirm 중 오류 발생");
			}
		}

		if (type.equals("reject")) {
			
			System.out.println("거절 실행");
			String query = "UPDATE meetingroom SET status='Reject' WHERE TO_CHAR(MEETINGDATE, 'YYYY-MM-DD HH24') = ? AND emp_num = ? AND meetingroomnum=?";

			try {

				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getDate());
				psmt.setString(2, dto.getEmpNum());
				psmt.setString(3, dto.getMeetingroomNum());

				psmt.executeUpdate();

			} catch (Exception e) {
				System.out.println("업데이트 Reject 중 오류 발생");
			}
		}

	}

}
