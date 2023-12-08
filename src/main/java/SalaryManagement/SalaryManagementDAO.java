package SalaryManagement;

import java.util.ArrayList;
import java.util.List;

import DBcontrol.DBConnPool;

public class SalaryManagementDAO extends DBConnPool {

	public SalaryManagementDAO() {
		super();
	}

	public List<SalaryManagementDTO> selectSalaryList(String team) {
		System.out.println("selectSalaryList DAO");

		List<SalaryManagementDTO> salaryEMPList = new ArrayList<SalaryManagementDTO>();

		String query = "SELECT emp.TEAM, emp.NAME, emp.EMP_NUM, emp.EMP_GRADE, emp.grade, i.PAY, "
		        + "SUM(iv.HOLIDAY_PAY + iv.INCENTIVE + iv.EXTRA_WORK_PAY) AS TOTAL_PAY, iv.INCENTIVE, "
		        + "iv.HOLIDAY_PAY, iv.EXTRA_WORK_PAY FROM emp JOIN INCENTIVE i ON emp.emp_num = i.emp_num "
		        + "JOIN INCENTIVE_VALUE iv ON i.emp_num = iv.EMP_NUM";

		if (!team.equals("전체")) {
		    query += " WHERE emp.TEAM = ?";
		}

		query += " GROUP BY emp.TEAM, emp.NAME, emp.EMP_NUM, emp.EMP_GRADE, emp.grade, i.PAY, iv.INCENTIVE, "
		        + "iv.HOLIDAY_PAY, iv.EXTRA_WORK_PAY ORDER BY emp.grade";

		// 이하 실행 부분 (PreparedStatement 생성 등)


		System.out.println("query : " + query);
		
		try {
			psmt = con.prepareStatement(query);
			
			if(!team.equals("전체")) {
				psmt.setString(1, team);
			}
			
			rs = psmt.executeQuery();
			
			int i = 0;
			
			while(rs.next()) {
				
				SalaryManagementDTO dto = new SalaryManagementDTO();
				
				dto.setTeam(rs.getString("TEAM"));
				dto.setName(rs.getString("NAME"));
				dto.setEmp_num(rs.getString("EMP_NUM"));
				dto.setEmp_grade(rs.getString("EMP_GRADE"));
				dto.setGrade(rs.getInt("GRADE"));
				dto.setPay(rs.getInt("PAY"));
				dto.setTotal_pay(rs.getInt("TOTAL_PAY"));
				dto.setIncentive(rs.getInt("INCENTIVE"));
				dto.setHoliday_pay(rs.getInt("HOLIDAY_PAY"));
				dto.setExtra_work_pay(rs.getInt("EXTRA_WORK_PAY"));
				
				salaryEMPList.add(dto);
				
				System.out.println("dto넣기 완료/ count " + (i++));
			}
			
		} catch (Exception e) {
			System.out.println("급여 사원 목록 불러오는 중 예외 발생");
			e.printStackTrace();
		}
		
		return salaryEMPList;

	}

}
