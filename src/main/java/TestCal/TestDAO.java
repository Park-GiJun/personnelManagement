package TestCal;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import DBcontrol.DBConnPool;

public class TestDAO extends DBConnPool {

	public TestDAO() {
		super();
	}

	public int insertSchedule(String emp, String schedule, String date) {

		System.out.println("insert schedule 실행");

		int result = 0;

		String query = "INSERT INTO PERSONAL_DIARAY (PERSONAL_DIARAY_DATE, PERSONAL_DIARAY_SCHEDULE, EMP_NUM) VALUES (?, ?, ?)";

		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, date);
			psmt.setString(2, schedule);
			psmt.setString(3, emp);

			result = psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("insert 스케쥴중 예외 발생");
			e.printStackTrace();
		}

		return result;
	}

	public void deleteSchdule(String emp, String data) {
		String query = "DELETE FROM PERSONAL_DIARAY WHERE emp_num=? AND PERSONAL_DIARAY_SCHEDULE=?";

		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, emp);
			psmt.setString(2, data);

			psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("개인 스케쥴 삭제");
			e.printStackTrace();
		}

	}

	public Map<String, List<String>> loadSchedule(String status, String emp, String year, String month) {

		String query = "";

		Map<String, List<String>> map = new HashMap<String, List<String>>();

		switch (status) {
		case "company": {
			query = "SELECT COMPANY_SCHEDULE, TO_CHAR(TO_DATE(COMPANY_CALENDER_DATE, 'YYYY-MM-DD'), 'DD') AS DAY_OF_MONTH FROM COMPANY_CALENDER WHERE EXTRACT(YEAR FROM TO_DATE(COMPANY_CALENDER_DATE, 'YYYY-MM-DD')) =? AND EXTRACT(MONTH FROM TO_DATE(COMPANY_CALENDER_DATE, 'YYYY-MM-DD')) =? ORDER BY DAY_OF_MONTH";
			break;

		}
		case "team": {
			query = "SELECT tc.TEAM_SCHEDULE, TO_CHAR(TO_DATE(tc.TEAM_CALENDER_DATE, 'YYYY-MM-DD'), 'DD') AS DAY_OF_MONTH FROM TEAM_CALENDER tc JOIN EMP e ON e.TEAM = tc.TEAM WHERE EXTRACT(YEAR FROM TO_DATE(TEAM_CALENDER_DATE, 'YYYY-MM-DD')) =? AND EXTRACT(MONTH FROM TO_DATE(TEAM_CALENDER_DATE, 'YYYY-MM-DD')) =? AND e.EMP_NUM=? ORDER BY DAY_OF_MONTH";
			break;

		}
		case "personal": {
			query = "SELECT PERSONAL_DIARAY_SCHEDULE, TO_CHAR(TO_DATE(PERSONAL_DIARAY_DATE, 'YYYY-MM-DD'), 'DD') AS DAY_OF_MONTH FROM Personal_diaray WHERE EXTRACT(YEAR FROM TO_DATE(PERSONAL_DIARAY_DATE, 'YYYY-MM-DD')) =? AND EXTRACT(MONTH FROM TO_DATE(PERSONAL_DIARAY_DATE, 'YYYY-MM-DD')) =? AND EMP_NUM=? ORDER BY DAY_OF_MONTH";
			break;

		}
		case "vacation": {
			break;

		}
		default:
			throw new IllegalArgumentException("Unexpected value: " + status);
		}

		try {

			psmt = con.prepareStatement(query);

			switch (status) {
			case "company": {
				psmt.setString(1, year);
				psmt.setString(2, month);
				rs = psmt.executeQuery();

				while (rs.next()) {
					String dayOfMonth = rs.getString("DAY_OF_MONTH");
					String schedule = rs.getString("COMPANY_SCHEDULE");

					if (!map.containsKey(dayOfMonth)) {
						map.put(dayOfMonth, new ArrayList<String>());
					}

					List<String> dailySchedules = map.get(dayOfMonth);
					dailySchedules.add(schedule);
				}
				break;
			}
			case "team": {
				psmt.setString(1, year);
				psmt.setString(2, month);
				psmt.setString(3, emp);
				rs = psmt.executeQuery();
				
				while(rs.next()) {
					String dayOfMonth = rs.getString("DAY_OF_MONTH");
					String schedule = rs.getString("TEAM_SCHEDULE");
					
					if(!map.containsKey(dayOfMonth)) {
						map.put(dayOfMonth, new ArrayList<String>());
					}
					
					List<String> dailySchedules = map.get(dayOfMonth);
					dailySchedules.add(schedule);
				}
				break;

			}
			case "personal": {
				psmt.setString(1, year);
				psmt.setString(2, month);
				psmt.setString(3, emp);
				rs = psmt.executeQuery();
				while(rs.next()) {
					String dayOfMonth = rs.getString("DAY_OF_MONTH");
					String schedule = rs.getString("PERSONAL_DIARAY_SCHEDULE");
					
					if(!map.containsKey(dayOfMonth)) {
						map.put(dayOfMonth, new ArrayList<String>());
					}
					
					List<String> dailySchedules = map.get(dayOfMonth);
					dailySchedules.add(schedule);
				}
				break;
			}
			case "vacation": {
				break;
			}
			default:
				System.out.println("문제가 생겻당");
			}

		} catch (Exception e) {
			System.out.println("스케쥴 불러오는중 예외 발생");
			e.printStackTrace();
		}

		return map;

	}

}
