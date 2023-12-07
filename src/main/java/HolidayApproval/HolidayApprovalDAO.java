package HolidayApproval;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import DBcontrol.DBConnPool;
import HoliDay.HoliDayDTO;

public class HolidayApprovalDAO extends DBConnPool{
	// 게시물 수를 가져오는 쿼리
		public int selectCount(Map<String, Object> map) {
			int totalCount = 0;

			String query = "SELECT COUNT(*) FROM holiday_check";
			try {
				// 쿼리 실행
				stmt = con.prepareStatement(query);

				rs = stmt.executeQuery(query);
				if (rs.next()) {
				totalCount = rs.getInt(1);
				}
			} catch (Exception e) {
				System.out.println("게시물 수를 구하는 중 예외 발생");
				e.printStackTrace();
			}
			return totalCount;
		}

		// 신청한 휴가 목록 조회 쿼리
		public List<HolidayApprovalDTO> selectList(Map<String, Object> map) {
			List<HolidayApprovalDTO> bbs = new Vector<HolidayApprovalDTO>();

			String query = "SELECT * FROM emp JOIN holiday_check ON emp.emp_num = holiday_check.emp_num ORDER BY APPROVAL, start_vacation, grade, emp.team";

			try {
				// 쿼리 실행
				stmt = con.prepareStatement(query);

				rs = stmt.executeQuery(query);
				while (rs.next()) {
					HolidayApprovalDTO dto = new HolidayApprovalDTO();

					dto.setName(rs.getString("name"));
					dto.setEmp_num(rs.getString("emp_num"));
					dto.setStart_vacation(rs.getString("start_vacation"));
					dto.setEnd_vacation(rs.getString("end_vacation"));
					dto.setTeam(rs.getString("team"));
					dto.setApproval(rs.getString("approval"));
					dto.setEmp_grade(rs.getString("emp_grade"));

					bbs.add(dto);
				}
			} catch (Exception e) {
				System.out.println("게시물 조회 중 예외 발생");
				e.printStackTrace();
			} 
			return bbs;
		}
		
		//휴가 승인 쿼리
		public HolidayApprovalDTO HolidayApproval (String emp_num, String start_vacation, String end_vacation, String team) {
			
			String query = "UPDATE holiday_check SET approval='승인 완료' WHERE emp_num=? AND start_vacation=? AND end_vacation=? AND team=?";
			
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, emp_num);
				psmt.setString(2, start_vacation);
				psmt.setString(3, end_vacation);
				psmt.setString(4, team);
				
				psmt.executeUpdate();
				System.out.println("휴가 승인");
			} catch (Exception e) {
				System.out.println("휴가승인 중 예외 발생");
				e.printStackTrace();
			}
			return null;
		}
		
		//부서별 휴가자 DB저장
		public HolidayApprovalDTO TeamHoliday (String team, String emp_num, String start_vacation, String end_vacation) {
			String query = "";
			
			if (team.equals("개발")) {
				query = "INSERT INTO  DEVELOPMENT_TEAM  (emp_num, start_vacation, end_vacation) VALUES (?, ?, ?)";
			} else if (team.equals("디자인")) {
				query = "INSERT INTO  design_team  (emp_num, start_vacation, end_vacation) VALUES (?, ?, ?)";
			} else if (team.equals("인사")) {
				query = "INSERT INTO  HumanResources_Team  (emp_num, start_vacation, end_vacation) VALUES (?, ?, ?)";
			}
			
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, emp_num);
				psmt.setString(2, start_vacation);
				psmt.setString(3, end_vacation);
				
				psmt.executeUpdate();
				System.out.println("부서별 휴가자 등록");
			} catch (Exception e) {
				System.out.println("부서별 휴가자 등록 중 예외 발생");
				e.printStackTrace();
			}
			return null;
		}
}
