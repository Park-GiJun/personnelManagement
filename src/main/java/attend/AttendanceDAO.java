package attend;

import java.util.HashMap;
import java.util.Map;

import DBcontrol.DBConnPool;

public class AttendanceDAO extends DBConnPool {

	public Map<String, Map<String, String>> loadDateAttendance(String emp_num, String currentDate) {
		System.out.println("Load Date Attendance");

		Map<String, Map<String, String>> attendDateMap = new HashMap<>();

		String query = "SELECT emp_num, TO_CHAR(day_of_work, 'YYYY-MM-DD') AS day, "
				+ "TO_CHAR(start_time, 'hh24:mi') AS start_time, TO_CHAR(finish_time, 'hh24:mi') AS finish_time "
				+ "FROM attendance WHERE emp_num = ? AND TO_CHAR(day_of_work, 'YYYY-MM') = ? ORDER BY day";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, emp_num);
			psmt.setString(2, currentDate);

			System.out.println("query: " + query + "\n" + emp_num + " " + currentDate);

			rs = psmt.executeQuery();

			while (rs.next()) {
				System.out.println("dto 넣는작업 시작, loadDate");
				AttendanceDTO dto = new AttendanceDTO();

				dto.setEmpNum(rs.getString("emp_num"));
				dto.setDay_of_work(rs.getString("day")); // 문자열로 변경
				dto.setStart_time(rs.getString("start_time")); // 문자열로 변경
				dto.setEnd_time(rs.getString("finish_time")); // 문자열로 변경

				System.out.println(dto.getEmpNum() + " " + dto.getDay_of_work() + " " + dto.getEnd_time() + " "
						+ dto.getStart_time());
				Map<String, String> timeMap = new HashMap<>();
				timeMap.put("start_time", dto.getStart_time());
				timeMap.put("finish_time", dto.getEnd_time());

				attendDateMap.put(dto.getDay_of_work(), timeMap);
			}

		} catch (Exception e) {
			System.out.println("출근 확인 예외 발생");
			e.printStackTrace();
		} finally {
			close();
		}

		return attendDateMap;
	}
}
