package MeetingRoom;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import DBcontrol.DBConnPool;

public class MeetingRoomDAO extends DBConnPool {

	public MeetingRoomDAO() {
		super();
	}

	public List<MeetingRoomDTO> getRooms(String roomNunm, String date) {

		List<MeetingRoomDTO> lists = new ArrayList<MeetingRoomDTO>();

		String query = "SELECT e.team, e.name, m.emp_num, e.team AS emp_team, TO_CHAR(m.meetingdate, 'HH24') AS formatted_hour, m.status "
				+ "FROM meetingroom m "
				+ "JOIN emp e ON m.emp_num = e.emp_num "
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

}
