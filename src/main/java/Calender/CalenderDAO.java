package Calender;

import java.util.List;
import java.util.Map;
import java.util.Vector;

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
	
	public List<CalenderDTO> selectListPage(Map<String,Object> map) {
		List<CalenderDTO> board = new Vector<CalenderDTO>();
		
		// 쿼리문 준비
		String query = " "
					 + "SELECT * FROM ( "
					 + "    SELECT Tb.*, ROWNUM rNum FROM ( "
					 + "		SELECT * FROM Personal_diaray ";
		
		if (map.get("searchWord") != null) {
			query +=  " WHERE " + map.get("searchCategory")
				   + " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		query += "		OEDER BY Personal_diaray_date DESC "
			   + "	) Td "
			   + " ) "
			   + " WHERE rNum BETWEEN ? AND ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1,  map.get("start").toString());
			psmt.setString(2,  map.get("end").toString());
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				CalenderDTO dto = new CalenderDTO();
				
				dto.setPerson_content(rs.getString(1));
				dto.setPerson_day(rs.getString(2));
				dto.setPerson_num(rs.getString(3));
				
				board.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
		
	}
	
	
	
	

}
