package Calender;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class TeamCalDAO extends DBConnPool {

	public TeamCalDAO() {
		super();
	}

	// 1
	public int ScheduleListCount(String selecteddate, String team) {
		System.out.println("ScheduleListCount");
		
		System.out.println("확인 : " + selecteddate + " " + team);
		int totalcount = 0;

		// 쿼리문 준비
		String query = "SELECT COUNT(*) AS count FROM Team_calender WHERE Team_calender_date =? AND team =?";

		try {
			psmt = con.prepareStatement(query); // 쿼리문 생성
			psmt.setString(1, selecteddate);
			psmt.setString(2, team);
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
	public List<TeamCalDTO> selectListPage(String selecteddate, String team) {
		List<TeamCalDTO> board = new Vector<TeamCalDTO>();
		
		System.out.println("select List Page");

		// 쿼리문 준비
		String query = "SELECT team_schedule FROM Team_calender WHERE Team_calender_date=? AND team=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, selecteddate);
			psmt.setString(2, team);
			rs = psmt.executeQuery();

			while (rs.next()) {
				TeamCalDTO dto = new TeamCalDTO();

				dto.setteam_schedule(rs.getString("team_schedule"));
				
				System.out.println(dto.getteam_schedule());

				board.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
	}

	// 3 삭제
	public int deletePost(String team_schedule) {
		int result = 0;
		try {
			String query = "DELETE FROM Team_calender WHERE team_schedule = ?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, team_schedule);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	// 4 입력, 저장
	public int insertWrite(TeamCalDTO dto) {
		int result = 0;

		try {
			String query = "INSERT INTO Team_calender (" + "team_schedule) " + " VALUES ( "
					+ " seq_board_num.NEXTVAL, ?)";

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getteam_schedule());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}

		return result;
	}

	public int addCalendarEvent(String Team_calender_date, String team_schedule, String team) {
		int result = 0;

		try {
			// JDBC 드라이버 로딩
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 데이터베이스 연결
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "사용자명", "비밀번호");

			// SQL 쿼리 작성
			String query = "INSERT INTO Team_calender (Team_calender_date, team_schedule, team) VALUES (?, ?, ?)";

			// PreparedStatement 생성
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, Team_calender_date);
			pstmt.setString(2, team_schedule);
			pstmt.setString(3, team);

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
