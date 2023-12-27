package Schedule;

import DBcontrol.DBConnPool;

public class ScheduleDAO extends DBConnPool{
	public void Team_Schedule (String team_Schedule_date, String content, String team) {
		String query = "INSERT INTO TEAM_CALENDER (team_CALENDER_date, team_schedule, team) VALUES (?, ?, ?)";
		
		System.out.println("팀 일정 추가 쿼리 실행");

		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, team_Schedule_date);
			psmt.setString(2, content);
			psmt.setString(3, team);

			psmt.executeUpdate();
			System.out.println("DB 저장 완료");
		} catch (Exception e) {
			System.out.println("팀 일정 추가 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	public void Company_Schedule (String Company_Schedule_date, String content) {
		String query = "INSERT INTO COMPANY_CALENDER (COMPANY_CALENDER_date, COMPANY_schedule) VALUES (?, ?)";
		
		System.out.println("회사 일정 추가 쿼리 실행");

		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, Company_Schedule_date);
			psmt.setString(2, content);

			psmt.executeUpdate();
			System.out.println("DB 저장 완료");
		} catch (Exception e) {
			System.out.println("회사 일정 추가 중 예외 발생");
			e.printStackTrace();
		}
	}
}
