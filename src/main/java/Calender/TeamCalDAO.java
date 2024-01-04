package Calender;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class TeamCalDAO extends DBConnPool {

	public TeamCalDAO() {
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

	public List<TeamCalDTO> selectListPage4(String selecteddate, String team_a) {
		List<TeamCalDTO> board = new Vector<TeamCalDTO>();
		
		System.out.println("select List Page");

		// 쿼리문 준비..
		String query = "SELECT team_schedule FROM Team_calender WHERE team=? AND Team_calender_date=? ORDER BY team_count_date";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, team_a);
	        psmt.setString(2, selecteddate); 
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
	
	// 날짜만 조회
		public List<TeamCalDTO> selectListPage3(String team_a, String selectedYear, String selectedMonth) {
			List<TeamCalDTO> board = new Vector<TeamCalDTO>();
			
			System.out.println("select List Page");

			// 쿼리문 준비
			//String query = "SELECT DISTINCT SUBSTR(Personal_diaray_date, -2) AS LastTwoCharacters FROM Personal_diaray WHERE emp_num=?";
			String query = "SELECT DISTINCT SUBSTR(Team_calender_date, -2) AS LastTwoCharacters FROM Team_calender WHERE team=? AND SUBSTR(Team_calender_date, 1, 4)=? AND SUBSTR(Team_calender_date, 6, 2)=?";
			
			
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, team_a);
				psmt.setString(2, selectedYear);
				psmt.setString(3, selectedMonth);
				rs = psmt.executeQuery();

				while (rs.next()) {
					TeamCalDTO dto = new TeamCalDTO();

					dto.setTeam_calender_date(rs.getString("LastTwoCharacters"));

		            System.out.println("게시물 날짜 조회(중복x) : " + dto.getTeam_calender_date());

		            board.add(dto);
				}
			} catch (Exception e) {
				System.out.println("게시물 날짜 조회 중 예외 발생");
				e.printStackTrace();
			}
			return board;
		}
	
	
	
	
	// 1
	public int ScheduleListCount(String selecteddate) {
		
		System.out.println("ScheduleListCount");
		
		System.out.println("확인 : " + selecteddate + " ");
		int totalcount = 0;

		// 쿼리문 준비
		String query = "SELECT COUNT(*) AS count FROM Team_calender WHERE Team_calender_date =?";

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

	// 2
	public List<TeamCalDTO> selectListPage(String selecteddate, String team_a) {
		List<TeamCalDTO> board = new Vector<TeamCalDTO>();
		
		System.out.println("select List Page");
		System.out.println(selecteddate);
		System.out.println("team_what 확인용 : " + team_a);

		// 쿼리문 준비
		
		String query = "SELECT team_schedule FROM Team_calender WHERE team=? AND Team_calender_date=? ORDER BY team_count_date";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, team_a); // 순서 변경
	        psmt.setString(2, selecteddate); // 순서 변경
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
	
	
	public List<TeamCalDTO> selectListPage2(String selecteddate2, String team_a) {
		List<TeamCalDTO> board = new Vector<TeamCalDTO>();
		
		System.out.println("select List Page222222");

		// 쿼리문 준비
		String query = "SELECT team_schedule FROM Team_calender WHERE team=? AND Team_calender_date=? ORDER BY team_count_date";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, team_a); // 순서 변경
	        psmt.setString(2, selecteddate2); // 순서 변경
			rs = psmt.executeQuery();

			while (rs.next()) {
				TeamCalDTO dto = new TeamCalDTO();

				dto.setteam_schedule(rs.getString("team_schedule"));
				
				System.out.println(dto.getteam_schedule());
				board.add(dto);
				System.out.println("select List Page33333333");
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
	}
	
	
	

	// 3 삭제하기 기능
		public int deleteCalender(List<String> selectedSchedules) {
		    int result = 0;

		    try {
		        // PreparedStatement를 사용하여 일괄 삭제
		        String query = "DELETE FROM Team_calender WHERE team_schedule=?";
		        psmt = con.prepareStatement(query);

		        for (String schedule : selectedSchedules) {
		            psmt.setString(1, schedule);
		            psmt.addBatch();
		        }

		        // 일괄 실행
		        int[] batchResults = psmt.executeBatch();

		        // 총 영향 받은 행 계산
		        for (int batchResult : batchResults) {
		            result += batchResult;
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        // 리소스 해제
		        close();
		    }

		    return result;
	}
		

		// 추가하기
		public int insertWrite(String selecteddate, String team_a, String newSchedule) {
		    int result = 0;
		    
		    System.out.println("이거 잘 들어왔나 : " + newSchedule + "ㅇㅇㅇㅇㅇㅇ");
		    System.out.println("---------" + selecteddate);
		    System.out.println("[[[[[[[[" + team_a);

		    try {
		    	String query = "INSERT INTO Team_calender (team_count_date, Team_calender_date, team, team_schedule) VALUES (count_date_team.nextval, ?, ?, ?)";
		    	psmt = con.prepareStatement(query);
		        psmt.setString(1, selecteddate);
		        psmt.setString(2, team_a);
		        psmt.setString(3, newSchedule);
		        result = psmt.executeUpdate();
		       
		    } catch (SQLException e) {
		        System.out.println("게시물 입력 중 예외 발생");
		        e.printStackTrace();
		    } finally {
		        close(); // 리소스를 닫는 코드는 finally 블록에서 수행
		    }

		    return result;
		}
		
		

	public int addCalendarEvent(String Team_calender_date, String team_schedule, String team_a) {
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
			pstmt.setString(3, team_a);

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
