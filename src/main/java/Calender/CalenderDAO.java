package Calender;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.Vector;

import DBcontrol.DBConnPool;


public class CalenderDAO extends DBConnPool {

	public CalenderDAO() {
		super();
	}

	// 1
	public int ScheduleListCount(String selecteddate, String emp_num) {
		System.out.println("ScheduleListCount");
		
		System.out.println("확인 : " + selecteddate + " " + emp_num);
		int totalcount = 0;

		// 쿼리문 준비
		String query = "SELECT COUNT(*) AS count FROM Personal_diaray WHERE Personal_diaray_date =? AND emp_num =?";

		try {
			psmt = con.prepareStatement(query); // 쿼리문 생성
			psmt.setString(1, selecteddate);
			psmt.setString(2, emp_num);
			rs = psmt.executeQuery(); // 쿼리문 실행
			if (rs.next()) {
				totalcount = rs.getInt("count");
			}
		} catch (Exception e) {
			System.out.println("일정 카운트 중 예외 발생");
			e.printStackTrace();
		}

		System.out.println(totalcount);
		return totalcount;
	}

	// 2
	public List<CalenderDTO> selectListPage(String selecteddate, String emp_num) {
		List<CalenderDTO> board = new Vector<CalenderDTO>();
		
		System.out.println("select List Page");

		// 쿼리문 준비
		String query = "SELECT Personal_diaray_schedule FROM Personal_diaray WHERE Personal_diaray_date=? AND emp_num=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, selecteddate);
			psmt.setString(2, emp_num);
			rs = psmt.executeQuery();

			while (rs.next()) {
				CalenderDTO dto = new CalenderDTO();

				dto.setPersonal_diaray_schedule(rs.getString("Personal_diaray_schedule"));
				
				System.out.println(dto.getPersonal_diaray_schedule());

				board.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
	}
	
	

	// 3 삭제하기 기능
	public int deletePost(String Personal_diaray_schedule) {
		int result = 0;
		try {
			String query = "DELETE FROM Personal_diaray WHERE Personal_diaray_schedule=?";
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
	
	
	
	
	
	public CalenderDTO selectView(String Personal_diaray_schedule) {
		CalenderDTO dto = new CalenderDTO();
		String query = "SELECT * FROM Personal_diaray WHERE Personal_diaray_schedule=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1,  Personal_diaray_schedule);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				dto.setPersonal_diaray_date(rs.getString(1));
				dto.setPersonal_diaray_schedule(rs.getString(2));
				dto.setemp_num(rs.getString(3));
			}
		}
		catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
		

	// 4 입력, 저장
	public int insertWrite(CalenderDTO dto) {
		int result = 0;

		try {
			String query = "INSERT INTO Personal_diaray (" + "Personal_diaray_schedule) " + " VALUES ( "
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

	public int addCalendarEvent(String Personal_diaray_date, String Personal_diaray_schedule, String emp_num) {
		int result = 0;

		try {
			// JDBC 드라이버 로딩
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 데이터베이스 연결
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "사용자명", "비밀번호");

			// SQL 쿼리 작성
			String query = "INSERT INTO Personal_diaray (Personal_diaray_date, Personal_diaray_schedule, emp_num) VALUES (?, ?, ?)";

			// PreparedStatement 생성
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, Personal_diaray_date);
			pstmt.setString(2, Personal_diaray_schedule);
			pstmt.setString(3, emp_num);

			// 쿼리 실행 및 결과 확인
			result = pstmt.executeUpdate();

			// 리소스 해제
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
