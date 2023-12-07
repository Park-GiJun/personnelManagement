package Calender;

import java.util.Map;

import DBcontrol.DBConnPool;

public class CalenderDAO extends DBConnPool{
	
	public CalenderDAO() {
		super();
	}
	
	public int ScheduleListCount(Map<String, Object> map) {
		System.out.println("ScheduleListCount");
		int totalcount = 0;
		
		// 쿼리문 준비
		String query = "SELECT COUNT (*) FROM Personal_diaray";
		
		// 검색 조건이 있다면 where절로 추가
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchCategory") + " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		try {
			stmt = con.createStatement();  // 쿼리문 생성
			rs = stmt.executeQuery(query);  // 쿼리문 실행
			rs.next();
			totalcount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("일정 카운트 중 예외 발생");
			e.printStackTrace();
		}
		
		System.out.println(totalcount);
		return totalcount;
	}
	
	
	
	

}
