package HoliDay;

import DBcontrol.DBConnPool;

public class HoliDayDAO extends DBConnPool {
	HoliDayDTO holidaydto = new HoliDayDTO();
	public HoliDayDAO() {
		super();
	}
	
	public void vacation_count (String emp_num) {
		// 사용가능한 휴가 횟수 가져오기
		String query = "SELECT Annual FROM holiday WHERE emp_num = ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, emp_num);
			
			rs = psmt.executeQuery();
			
			if (rs.next()) {
			holidaydto.setAnnual(rs.getString("Annual"));
			System.out.println(holidaydto.getAnnual());
			
			System.out.println("dto 받음");
			}
		} catch (Exception e) {
			System.out.println("사용가능한 휴가 횟수 찾는중 예외 발생");
			e.printStackTrace();
		}
	}
	
	public void HoliDay_Request (String start_vacation, String end_vacation) {
		// 휴가 신청시 DB 저장
		String query = "INSERT INTO holiday_check (emp_num, start_vacation, end_vacation, team)"
				+ " VALUES (?, ?, ?, ?)";
		
		System.out.println(holidaydto.getemp_num());
		System.out.println(holidaydto.getTeam());
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, holidaydto.getemp_num());
			psmt.setString(2, start_vacation);
			psmt.setString(3, end_vacation);
			psmt.setString(4, holidaydto.getTeam());
			
			psmt.executeUpdate();
			System.out.println("휴가 신청 완료");
		} catch (Exception e) {
			System.out.println("휴가 신청중 예외 발생");
			e.printStackTrace();
		}
	}
}
