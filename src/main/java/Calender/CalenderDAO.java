package Calender;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class CalenderDAO extends DBConnPool{
	
	String driver="oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:xe";
	
	public CalenderDAO() {
		super();
	}
	
	//1
	public int ScheduleListCount(Map<String, Object> map) {
		System.out.println("ScheduleListCount");
		int totalcount = 0;
		
		// 쿼리문 준비
		String query = "SELECT COUNT (*) FROM Personal_diaray";
		
		// 검색 조건이 있다면 where절로 추가
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchCategory") + " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		//if (map.get("searchWord") != null) {
		    //query += " WHERE " + map.get("searchCategory") + " LIKE ?";
		//}
		
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
	
	
	//2
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
		
		query += "		ORDER BY Personal_diaray_date DESC "
			   + "	) Tb "
			   + " ) "
			   + " WHERE rNum BETWEEN ? AND ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1,  map.get("start").toString());
			psmt.setString(2,  map.get("end").toString());
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				CalenderDTO dto = new CalenderDTO();
				
				dto.setPersonal_diaray_schedule(rs.getString(1));
				dto.setPersonal_diaray_date(rs.getString(2));
				dto.setemp_num(rs.getString(3));
				
				board.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
	}
	
	
	//3 삭제
	public int deletePost(String Personal_diaray_schedule) {
		int result = 0;
		try {
			String query = "INSERT INTO Personal_diaray (Personal_diaray_schedule) VALUES (?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1, Personal_diaray_schedule);
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	
	//4 입력, 저장
	public int insertWrite(CalenderDTO dto) {
		int result = 0;

		try {
			String query = "INSERT INTO Personal_diaray ("
					+ "Personal_diaray_schedule) "
					+ " VALUES ( "
					+ " seq_board_num.NEXTVAL, ?)";

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getPersonal_diaray_schedule());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}

		return result;
	}
	

}
