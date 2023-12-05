package attend;

import java.util.List;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class AttendanceDAO extends DBConnPool {

	public List<AttendanceDTO> loadDateAttendance(String emp_num, String currentDate) {
		System.out.println("Load Date Attendance");

		List<AttendanceDTO> list = new Vector<>();
		
		System.out.println("emp_num : " + emp_num + " crruentDate : " + currentDate);

		String query = "SELECT emp_num, TO_CHAR(day_of_work, 'MM/DD') AS day, "
				+ "TO_CHAR(start_time, 'hh24:mi') AS start_time, TO_CHAR(finish_time, 'hh24:mi') AS finish_time "
				+ "FROM attendance WHERE emp_num = ? AND TO_CHAR(day_of_work, 'YYYY-MM') = ? ORDER BY day";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, emp_num);
			psmt.setString(2, currentDate);

			System.out.println("Query: " + query); // 쿼리 확인
			rs = psmt.executeQuery(); // 쿼리 실행
			System.out.println("Query executed successfully");

			System.out.println("Has result: " + rs.next());

			while (rs.next()) {
				System.out.println("dto 넣는작업 시작, loadDate");

				AttendanceDTO dto = new AttendanceDTO();

				dto.setEmpNum(rs.getString("emp_num"));
				dto.setDay_of_work(rs.getString("day")); // 문자열로 변경
				dto.setStart_time(rs.getString("start_time")); // 문자열로 변경
				dto.setEnd_time(rs.getString("finish_time")); // 문자열로 변경

				System.out.println(dto.getEmpNum() + " day : " + dto.getDay_of_work() + " end time : "
						+ dto.getEnd_time() + " start time : " + dto.getStart_time());
				list.add(dto);
			}

		} catch (Exception e) {
			System.out.println("출근 확인 예외 발생");
			e.printStackTrace();
		} finally {
			close();
		}

		return list;
	}
}
package attend;

import java.util.List;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class AttendanceDAO extends DBConnPool {

	public List<AttendanceDTO> loadDateAttendance(String emp_num, String currentDate) {
		System.out.println("Load Date Attendance");

		List<AttendanceDTO> list = new Vector<>();

		String query = "SELECT emp_num, TO_CHAR(day_of_work, 'DD') AS day, "
				+ "TO_CHAR(start_time, 'hh24:mi') AS start_time, TO_CHAR(finish_time, 'hh24:mi') AS finish_time "
				+ "FROM attendance WHERE emp_num = ? AND TO_CHAR(day_of_work, 'YYYY-MM') = ?";

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
				list.add(dto);
			}

		} catch (Exception e) {
			System.out.println("출근 확인 예외 발생");
			e.printStackTrace();
		} finally {
			close();
		}

		return list;
	}
}
