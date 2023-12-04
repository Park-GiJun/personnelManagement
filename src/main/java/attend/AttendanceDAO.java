package attend;

import java.util.List;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class AttendanceDAO extends DBConnPool {

	public List<AttendanceDTO> loadDateAttendance(String emp_num) {
		System.out.println("Load Date Attendance");

		List<AttendanceDTO> list = new Vector<AttendanceDTO>();

		String query = "SELECET * FROM attendance WHERE ?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, emp_num);

			rs = psmt.executeQuery();

			while (rs.next()) {
				AttendanceDTO dto = new AttendanceDTO();

				dto.setEmpNum(rs.getString("emp_num"));
				dto.setDay_of_work(rs.getDate("day_of_work"));
				dto.setStart_time(rs.getDate("start_date"));
				dto.setEnd_time(rs.getDate("end_date"));

				list.add(dto);
			}

		} catch (Exception e) {
			System.out.println("출근 확인 예외 발생");
			e.printStackTrace();
		}

		return list;
	}

}
