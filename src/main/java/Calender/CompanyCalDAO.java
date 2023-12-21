package Calender;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class CompanyCalDAO extends DBConnPool {

	public CompanyCalDAO() {
		super();
	}

	// 게시물 조회하는 쿼리
	public int ScheduleListCount(String selecteddate) {
		System.out.println("ScheduleListCount");
		
		System.out.println("확인 : " + selecteddate);
		int totalcount = 0;

		// 쿼리문 준비
		String query = "SELECT COUNT(*) AS count FROM company_calender WHERE company_calender_date =?";

		try {
			psmt = con.prepareStatement(query); // 쿼리문 생성
			psmt.setString(1, selecteddate);
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

	// 일정 내용 가져오는 쿼리
	public List<CompanyCalDTO> selectListPage(String selecteddate) {
		List<CompanyCalDTO> board = new Vector<CompanyCalDTO>();
		
		System.out.println("select List Page");

		// 쿼리문 준비
		String query = "SELECT company_schedule FROM company_calender WHERE company_calender_date=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, selecteddate);
			rs = psmt.executeQuery();

			while (rs.next()) {
				CompanyCalDTO dto = new CompanyCalDTO();

				dto.setcompany_schedule(rs.getString("company_schedule"));
				
				System.out.println(dto.getcompany_schedule());

				board.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
	}

	// 3 삭제
	public int deletePost(String company_schedule) {
		int result = 0;
		try {
			String query = "DELETE FROM company_calender WHERE company_schedule = ?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, company_schedule);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	// 4 입력, 저장
	public int insertWrite(CompanyCalDTO dto) {
		int result = 0;

		try {
			String query = "INSERT INTO company_calender (" + "company_schedule) " + " VALUES ( "
					+ " seq_board_num.NEXTVAL, ?)";

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getcompany_schedule());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}

		return result;
	}

	public int addCalendarEvent(String company_calender_date, String company_schedule) {
		int result = 0;

		try {
			// JDBC 드라이버 로딩
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 데이터베이스 연결
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "사용자명", "비밀번호");

			// SQL 쿼리 작성
			String query = "INSERT INTO company_calender_date (company_calender_date, company_schedule) VALUES (?, ?)";

			// PreparedStatement 생성
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, company_calender_date);
			pstmt.setString(2, company_schedule);
		

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
