package Calender;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import Comments.CommentsDTO;
import DBcontrol.DBConnPool;


public class CalenderDAO extends DBConnPool {

	public CalenderDAO() {
		super();
	}
	
	
	public List<CalenderDTO> selectListPage(Map<String, Object> map) {
		System.out.println("selectListpage");
		List<CalenderDTO> anno_boards = new Vector<CalenderDTO>();

		System.out.println("상세보기 댓글 SelectListPage 실행");
		// 쿼리문
		String query = "SELECT * FROM (SELECT Tb.*, ROWNUM AS rNum FROM (SELECT * FROM Personal_diaray";
		if (map.get("searchWord") != null) {
			// 조건 추가
			query += " WHERE " + map.get("searchCategory") + " LIKE '%" + map.get("searchWord") + "%'";
		}

		query += " ORDER BY count_date DESC) Tb) WHERE rNum BETWEEN ? AND ?";
		System.out.println("CalenderController : 51 lines --------------------------");
		System.out.println(query);

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			System.out.println("CalenderController :" + query);
			rs = psmt.executeQuery();

			// 반환된 게시물 목록을 컬렉션에 추가
			while (rs.next()) {
				CalenderDTO dto = new CalenderDTO();

				dto.setCount_date(rs.getInt("count_date"));
				dto.setPersonal_diaray_schedule(rs.getString("Personal_diaray_schedule"));
				dto.setPersonal_diaray_date(rs.getString("Personal_diaray_date"));
				dto.setemp_num(rs.getString("emp_num"));
				anno_boards.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 조회중 예외 발생");
			e.printStackTrace();
		}
		return anno_boards;
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
	
	
	
	public List<CalenderDTO> selectListPage2(String selecteddate2, String emp_num) {
		List<CalenderDTO> board = new Vector<CalenderDTO>();
		
		System.out.println("select List Page222222");

		// 쿼리문 준비
		String query = "SELECT Personal_diaray_schedule FROM Personal_diaray WHERE Personal_diaray_date=? AND emp_num=? ORDER BY count_date";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, selecteddate2);
			psmt.setString(2, emp_num);
			rs = psmt.executeQuery();

			while (rs.next()) {
				CalenderDTO dto = new CalenderDTO();

				dto.setPersonal_diaray_schedule(rs.getString("Personal_diaray_schedule"));
				
				System.out.println(dto.getPersonal_diaray_schedule());

				board.add(dto);
				System.out.println("select List Page33333333");
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
	}
	
	
	
	// 화면 페이지 첫 번째
	public List<CalenderDTO> selectListPage4(String selecteddate, String emp_num) {
		List<CalenderDTO> board = new Vector<CalenderDTO>();
		
		System.out.println("select List Page");

		// 쿼리문 준비
		String query = "SELECT Personal_diaray_schedule FROM Personal_diaray WHERE Personal_diaray_date=? AND emp_num=? ORDER BY count_date";

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
	
	
	
	

	// 2
	public List<CalenderDTO> selectListPage(String selecteddate, String emp_num) {
		List<CalenderDTO> board = new Vector<CalenderDTO>();
		
		System.out.println("select List Page");

		// 쿼리문 준비
		String query = "SELECT Personal_diaray_schedule FROM Personal_diaray WHERE Personal_diaray_date=? AND emp_num=? ORDER BY count_date";

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
	
	
	// 날짜만 조회.
	public List<CalenderDTO> selectListPage3(String emp_num, String selectedYear, String selectedMonth) {
		List<CalenderDTO> board = new Vector<CalenderDTO>();
		
		System.out.println("select List Page");

		// 쿼리문 준비
		//String query = "SELECT DISTINCT SUBSTR(Personal_diaray_date, -2) AS LastTwoCharacters FROM Personal_diaray WHERE emp_num=?";
		String query = "SELECT DISTINCT SUBSTR(Personal_diaray_date, -2) AS LastTwoCharacters FROM Personal_diaray WHERE emp_num=? AND SUBSTR(Personal_diaray_date, 1, 4)=? AND SUBSTR(Personal_diaray_date, 6, 2)=?";
		
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, emp_num);
			psmt.setString(2, selectedYear);
			psmt.setString(3, selectedMonth);
			rs = psmt.executeQuery();

			while (rs.next()) {
				CalenderDTO dto = new CalenderDTO();

				dto.setPersonal_diaray_date(rs.getString("LastTwoCharacters"));

	            System.out.println("게시물 날짜 조회(중복x) : " + dto.getPersonal_diaray_date());

	            board.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 날짜 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
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
	

	
	// 추가하기
	public int insertWrite(String newSchedule, String selecteddate, String emp_num) {
	    int result = 0;
	    
	    System.out.println(newSchedule);
	    System.out.println(selecteddate);
	    System.out.println(emp_num);

	    try {
	        String query = "INSERT INTO Personal_diaray (count_date, Personal_diaray_date, Personal_diaray_schedule, emp_num) VALUES (count_date_num.nextval, ?, ?, ?)";
	        psmt = con.prepareStatement(query);
	        psmt.setString(1, selecteddate);
	        psmt.setString(2, newSchedule);
	        psmt.setString(3, emp_num);
	        result = psmt.executeUpdate();
	       
	    } catch (SQLException e) {
	        System.out.println("게시물 입력 중 예외 발생");
	        e.printStackTrace();
	    } finally {
	        close(); // 리소스를 닫는 코드는 finally 블록에서 수행
	    }

	    return result;
	}
	
	

	// 3 삭제하기 기능
	public int deleteCalender(List<String> selectedSchedules) {
	    int result = 0;

	    try {
	        // PreparedStatement를 사용하여 일괄 삭제
	        String query = "DELETE FROM Personal_diaray WHERE Personal_diaray_schedule=?";
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
	            System.out.println("result 값 확인용 ===== " + result);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        //throw new RuntimeException("일괄 삭제 중 예외 발생", e);
	    } finally {
	        // 리소스 해제
	        close();
	    }

	    return result;
}	

	
    public int deleteCalenderByDate(String selecteddate, String emp_num) {
    	
        int result = 0;

        try {
            // 쿼리문 준비
        	String query = "DELETE FROM Personal_diaray WHERE Personal_diaray_date = ? AND emp_num = ?";
            psmt = con.prepareStatement(query);

            // 파라미터 설정
            psmt.setString(1, selecteddate);
            psmt.setString(2, emp_num);

            // 쿼리 실행
            result = psmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("일정 삭제 중 예외 발생");
            e.printStackTrace();
        } finally {
            // 리소스 해제
            close();
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
