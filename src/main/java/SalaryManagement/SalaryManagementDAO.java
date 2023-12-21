package SalaryManagement;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBcontrol.DBConnPool;

public class SalaryManagementDAO extends DBConnPool {

	public SalaryManagementDAO() {
		super();
	}

	public List<SalaryManagementDTO> selectSalaryList(String selectTeam, String selectTeam_NUM, String selectedYear, String selectedMonth, int num) {
		System.out.println("selectSalaryList DAO");

		System.out.println("check select team : " + selectTeam);

		List<SalaryManagementDTO> salaryEMPList = new ArrayList<>();

		String query = "SELECT emp.TEAM_NUM, emp.TEAM, emp.NAME, emp.EMP_NUM, emp.EMP_GRADE, emp.grade, i.PAY, TO_CHAR(iv.yearmonth, 'YYYY-MM') AS yearmonth, "
				+ "SUM(iv.HOLIDAY_PAY + iv.INCENTIVE + iv.EXTRA_WORK_PAY) AS TOTAL_PAY, iv.INCENTIVE, "
				+ "iv.HOLIDAY_PAY, iv.EXTRA_WORK_PAY FROM emp JOIN INCENTIVE i ON emp.emp_num = i.emp_num "
				+ "JOIN INCENTIVE_VALUE iv ON i.emp_num = iv.EMP_NUM AND i.yearmonth = iv.yearmonth";

		// Check if a specific team is selected
		// 부서별 전체조회
		if (num == 1) {
			query += " WHERE emp.TEAM = ? ";
		}
		// 부서, 팀별 조회
		if (num == 2) {
			query += " WHERE emp.TEAM=? AND emp.TEAM_NUM=? ";
		}
		// 임원급 조회 (부장~사장)
		if (num == 3) {
			query += " WHERE emp.GRADE <= 3 ";
		}

		// Check if a specific date is selected
		if (selectedYear != null && selectedMonth != null) {
			if (!"전체".equals(selectTeam)) {
				query += " AND";
			} else {
				query += " WHERE";
			}
			// 수정된 부분: 월이 '전체'가 아닐 때와 '전체'일 때의 조건을 나눠 처리
			if ("전체".equals(selectedMonth)) {
				System.out.println("a월이 전체입니다." + selectedMonth);
				query += "  TO_CHAR(iv.yearmonth, 'YYYY') = ?";
			} else {
				System.out.println("a월이 전체가 아닙니다." + selectedMonth);
				query += " iv.yearmonth = TO_DATE(?, 'YYYY-MM')";
			}

		}
		query += " GROUP BY emp.Team_NUM, emp.TEAM, emp.NAME, emp.EMP_NUM, emp.EMP_GRADE, emp.grade, i.PAY, iv.yearmonth, "
				+ "iv.INCENTIVE, iv.HOLIDAY_PAY, iv.EXTRA_WORK_PAY ORDER BY emp.grade, emp.team, emp.team_num";

		System.out.println("query : " + query);

		try {
			psmt = con.prepareStatement(query);

			int parameterIndex = 1;

			if (num == 1) {
				psmt.setString(parameterIndex++, selectTeam);
			}
			
			// 부서별 팀 조회
			if (num == 2) {
				psmt.setString(parameterIndex++, selectTeam);
				psmt.setString(parameterIndex++, selectTeam_NUM);
			}

			if (selectedYear != null && selectedMonth != null) {
				// 수정된 부분: '전체'가 아닐 때와 '전체'일 때의 매개변수 설정
				if ("전체".equals(selectedMonth)) {
					System.out.println("b:월이 전체입니다." + selectedMonth);
					psmt.setString(parameterIndex++, selectedYear);
				} else {
					System.out.println("b:월이 전체가 아닙니다." + selectedMonth);
					psmt.setString(parameterIndex++, selectedYear + "-" + selectedMonth);
				}

			}

			// 쿼리를 실행하고 결과를 처리합니다
			rs = psmt.executeQuery();

			int i = 0;

			while (rs.next()) {
				SalaryManagementDTO dto = new SalaryManagementDTO();

				dto.setTeam(rs.getString("TEAM"));
				dto.setTeam_num(rs.getString("TEAM_NUM"));
				dto.setName(rs.getString("NAME"));
				dto.setEmp_num(rs.getString("EMP_NUM"));
				dto.setEmp_grade(rs.getString("EMP_GRADE"));
				dto.setGrade(rs.getInt("GRADE"));
				dto.setPay(rs.getInt("PAY"));
				dto.setTotal_pay(rs.getInt("TOTAL_PAY"));
				dto.setIncentive(rs.getInt("INCENTIVE"));
				dto.setHoliday_pay(rs.getInt("HOLIDAY_PAY"));
				dto.setExtra_work_pay(rs.getInt("EXTRA_WORK_PAY"));
				dto.setYearmonth(rs.getString("yearmonth"));

				salaryEMPList.add(dto);

				System.out.println("dto넣기 완료/ count " + (i++));
			}

		} catch (Exception e) {
			System.out.println("급여 사원 목록 불러오는 중 예외 발생");
			e.printStackTrace();
		}

		return salaryEMPList;
	}

	public SalaryManagementDTO salaryPrint(String emp_num, String Date) {
		SalaryManagementDTO dto = new SalaryManagementDTO();

		String query = "SELECT " + "emp.NAME, " + "emp.EMP_NUM, " + "emp.EMP_GRADE, " + "emp.PHONE, " + "emp.EMAIL, "
				+ "i.PAY, " + "SUM(iv.HOLIDAY_PAY + iv.INCENTIVE + iv.EXTRA_WORK_PAY) AS TOTAL_PAY, " + "iv.INCENTIVE, "
				+ "iv.HOLIDAY_PAY, " + "iv.EXTRA_WORK_PAY " + "FROM " + "emp " + "JOIN " + "INCENTIVE i ON "
				+ "emp.emp_num = i.emp_num " + "JOIN " + "INCENTIVE_VALUE iv ON " + "i.emp_num = iv.EMP_NUM "
				+ "AND i.YEARMONTH = iv.YEARMONTH " + "WHERE " + "emp.EMP_NUM = ? "
				+ "AND i.YEARMONTH = TO_DATE(?, 'YYYY-MM') " + "GROUP BY " + "emp.NAME, " + "emp.EMP_NUM, "
				+ "emp.EMP_GRADE, " + "emp.PHONE, " + "emp.EMAIL, " + "i.PAY, " + "iv.INCENTIVE, " + "iv.HOLIDAY_PAY, "
				+ "iv.EXTRA_WORK_PAY";

		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, emp_num);
			psmt.setString(2, Date);

			rs = psmt.executeQuery();

			System.out.println("확인용 : " + emp_num + Date);

			if (rs.next()) {
				dto.setName(rs.getString("NAME"));
				dto.setEmp_num(rs.getString("EMP_NUM"));
				dto.setEmp_grade(rs.getString("EMP_GRADE"));
				dto.setPhone(rs.getString("PHONE"));
				dto.setEmail(rs.getString("EMAIL"));
				dto.setPay(rs.getInt("PAY"));
				dto.setTotal_pay(rs.getInt("TOTAL_PAY"));
				dto.setIncentive(rs.getInt("INCENTIVE"));
				dto.setHoliday_pay(rs.getInt("HOLIDAY_PAY"));
				dto.setExtra_work_pay(rs.getInt("EXTRA_WORK_PAY"));

				// Assuming you have a SalaryManagementDTO object named 'dto' with the above
				// attributes set

				System.out.println("Name: " + dto.getName());
				System.out.println("Employee Number: " + dto.getEmp_num());
				System.out.println("Employee Grade: " + dto.getEmp_grade());
				System.out.println("Phone: " + dto.getPhone());
				System.out.println("Email: " + dto.getEmail());
				System.out.println("Pay: " + dto.getPay());
				System.out.println("Total Pay: " + dto.getTotal_pay());
				System.out.println("Incentive: " + dto.getIncentive());
				System.out.println("Holiday Pay: " + dto.getHoliday_pay());
				System.out.println("Extra Work Pay: " + dto.getExtra_work_pay());

			}

		} catch (Exception e) {
			System.out.println("SalaryPrint중 예외 발생");
			e.printStackTrace();
		}

		return dto;

	}

	public void updateIncentive(String emp, String incentive, String holiday, String yearmonth) {

		System.out.println("확인용2 : " + emp + " " + incentive + " " + holiday + " " + yearmonth);

		try {

			String query = "UPDATE incentive_value SET incentive=?, holiday_pay=? WHERE emp_num=? AND TO_DATE(?, 'YYYY-MM') = yearmonth";

			psmt = con.prepareStatement(query);

			psmt.setString(1, incentive);
			psmt.setString(2, holiday);
			psmt.setString(3, emp);
			psmt.setString(4, yearmonth);

			psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("인센티브 설정중 예외 발생");
			e.printStackTrace();
		}
	}

	public void noExistDate(String emp, String date) {
		System.out.println("noExistDate1");

		String query1 = "INSERT INTO incentive (emp_num, pay, ADDITIONAL_PAY, yearmonth) VALUES (? , 0, 0, TO_DATE(? , 'YYYY-MM'))";
		try {
			System.out.println("인센티브 밸류 실행");
			psmt = con.prepareStatement(query1);
			psmt.setString(1, emp);
			psmt.setString(2, date);
			psmt.executeUpdate();
		} catch (Exception e2) {
			System.out.println("첫번째 새 달 생성중 예외발생");
			e2.printStackTrace();
		}

		String query2 = "INSERT INTO incentive_value (emp_num, incentive_value_date, holiday_pay, incentive, extra_work_pay, yearmonth) VALUES (? , TO_DATE(? , 'YYYY-MM'), 0, 0, 0, TO_DATE(? , 'YYYY-MM'))";
		try {
			System.out.println("인센티브 실행");
			psmt = con.prepareStatement(query2);
			psmt.setString(1, emp);
			psmt.setString(2, date);
			psmt.setString(3, date);
			psmt.executeUpdate();
		} catch (Exception e2) {
			System.out.println("두번째 새 달 생성중 예외발생");
			e2.printStackTrace();
		}
	}

}
