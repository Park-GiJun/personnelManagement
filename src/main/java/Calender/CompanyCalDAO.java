package Calender;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class CompanyCalDAO extends DBConnPool {

	public CompanyCalDAO() {
		super();
	}
	
	/*
	// 1
		public int ScheduleListCount(String selecteddate, String emp_num) {
			System.out.println("ScheduleListCount");
			
			System.out.println("확인 : " + selecteddate + " " + emp_num);
			int totalcount = 0;

			// 쿼리문 준비
			String query = "SELECT COUNT(*) AS count FROM company_calender WHERE company_calender_date =? AND emp_num =?";

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
*/
		
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
			String query = "SELECT company_schedule FROM company_calender WHERE company_calender_date=? ORDER BY com_count_date";

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
		
		

	// 3 삭제하기 기능
		public int deleteCalender(List<String> selectedSchedules) {
		    int result = 0;

		    try {
		        // PreparedStatement를 사용하여 일괄 삭제
		        String query = "DELETE FROM company_calender WHERE company_schedule=?";
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
		public int insertWrite(String newSchedule, String selecteddate) {
		    int result = 0;
		    
		    System.out.println(newSchedule);
		    System.out.println(selecteddate);

		    try {
		    	//String query = "INSERT INTO Personal_diaray (count_date, Personal_diaray_date, Personal_diaray_schedule, emp_num) VALUES (count_date_num.nextval, ?, ?, ?)";
		        String query = "INSERT INTO company_calender (com_count_date, company_calender_date, company_schedule) VALUES (com_count_date_num.nextval, ?, ?)";
		        psmt = con.prepareStatement(query);
		        psmt.setString(1, selecteddate);
		        psmt.setString(2, newSchedule);
		        result = psmt.executeUpdate();
		       
		    } catch (SQLException e) {
		        System.out.println("게시물 입력 중 예외 발생");
		        e.printStackTrace();
		    } finally {
		        close(); // 리소스를 닫는 코드는 finally 블록에서 수행
		    }

		    return result;
		}

}
