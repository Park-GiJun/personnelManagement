package Calender;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class TeamVactionDAO extends DBConnPool {

	public TeamVactionDAO() {
		super();
	}
	
	
	// 팀 알아내기
		public String TeamFind(String emp_num) {
			System.out.println("TeamFind");
			
			System.out.println("확인 : " + emp_num + " ");
			String team = null;
			int totalcount = 0;
			
			// 쿼리문 준비
			String query = "SELECT team FROM emp WHERE emp_num = ?";
			
			try {
		        psmt = con.prepareStatement(query); // 쿼리문 생성
		        psmt.setString(1, emp_num);
		        rs = psmt.executeQuery(); // 쿼리문 실행
		        if (rs.next()) {
		            team = rs.getString("team"); // team 값을 변수에 저장
		        }
		    } catch (Exception e) {
		        System.out.println("팀 조회 중 예외 발생");
		        e.printStackTrace();
		    }
			return team;
			
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
	public List<TeamVactionDTO> selectListPage(String selecteddate, String team_a) {
		List<TeamVactionDTO> board = new Vector<TeamVactionDTO>();
		
		System.out.println("select List Page");
		System.out.println(selecteddate);
		//System.out.println(emp_num);
		System.out.println("team_what 확인용 : " + team_a);

		// 쿼리문 준비
		
		//String query = "SELECT holiday_check FROM Team_calender WHERE team=? AND Team_calender_date=? ORDER BY team_count_date";
		String query = "SELECT emp_num FROM holiday_check WHERE team=? AND Approval = '승인 완료' AND TO_DATE(?, 'YYYY-MM-DD') BETWEEN TO_DATE(Start_vacation, 'YYYY-MM-DD') AND TO_DATE(end_vacation, 'YYYY-MM-DD')";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, team_a); // 순서 변경
			psmt.setString(2, selecteddate);
			rs = psmt.executeQuery();

			while (rs.next()) {
				TeamVactionDTO dto = new TeamVactionDTO();

				dto.setemp_num(rs.getString("emp_num"));
				
				System.out.println(dto.getemp_num());
				board.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
	}

	
	
	// 3 삭제
	public int deletePost(String Personal_diaray_schedule) {
		int result = 0;
		try {
			String query = "DELETE FROM Personal_diaray WHERE Personal_diaray_schedule = ?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, Personal_diaray_schedule);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
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
