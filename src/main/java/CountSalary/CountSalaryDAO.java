package CountSalary;

import DBcontrol.DBConnPool;

public class CountSalaryDAO extends DBConnPool {

	public CountSalaryDAO() {
		super();
	}
	public CountSalaryDTO countSalary(String empNum, String date) {
	    System.out.println("countSalary 메서드 시작");

	    CountSalaryDTO dto = new CountSalaryDTO();

	    String query = "SELECT " +
	            "    emp_num, " +
	            "    TO_CHAR(day_of_WORK, 'YYYY-MM') AS Salarydate, " +
	            "    SUM( " +
	            "        CASE " +
	            "            WHEN (finish_time - start_time) * 24 > 9 THEN 9 " +
	            "            WHEN (finish_time - start_time) * 24 > 1 THEN (finish_time - start_time) * 24 " +
	            "            ELSE 0 " +
	            "        END " +
	            "    ) AS total_actual_work_hours, " +
	            "    SUM( " +
	            "        CASE " +
	            "            WHEN (finish_time - start_time) * 24 > 9 THEN (finish_time - start_time) * 24 - 9 " +
	            "            ELSE 0 " +
	            "        END " +
	            "    ) AS total_overtime_hours " +
	            "FROM " +
	            "    attendance " +
	            "WHERE " +
	            "    emp_num = ? " +
	            "    AND TO_CHAR(day_of_WORK, 'YYYY-MM') = ? " +
	            "GROUP BY " +
	            "    emp_num, TO_CHAR(day_of_WORK, 'YYYY-MM')";




	    try {
	        psmt = con.prepareStatement(query);
	        psmt.setString(1, empNum);
	        psmt.setString(2, date);

	        rs = psmt.executeQuery();

	        if (rs.next()) {
	            dto.setEmp_num(rs.getString("emp_num"));
	            dto.setSalaryDate(rs.getString("Salarydate"));      
	            dto.setActual_work_time(rs.getInt("total_actual_work_hours"));
	            dto.setOvertime_work(rs.getInt("total_overtime_hours"));
	        }

	    } catch (Exception e) {
	        System.out.println("급여계산중 예외 발생");
	        e.printStackTrace();
	    }

	    System.out.println("countSalary - " + dto.getActual_work_time() + " " + dto.getOvertime_work());

	    return dto;
	}

	
	public void updateSalary(CountSalaryDTO dto) {
		System.out.println("update Salary");
		
		String emp_num = dto.getEmp_num();
		String salaryDate = dto.getSalaryDate();
		int actual = dto.getActual_work_time()*14000;
		int over = (int) (dto.getOvertime_work()*14000*1.5);
		
		System.out.println("Update Salary Check " + emp_num + " " + salaryDate + " " + actual + " " + over);
		
		String query = "UPDATE incentive SET pay=? WHERE emp_num=? AND yearmonth=TO_DATE(?, 'YYYY-MM')";

		String query2 = "UPDATE incentive_value SET extra_work_pay=? WHERE emp_num=? AND yearmonth=TO_DATE(?, 'YYYY-MM')";

		
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, actual);
			psmt.setString(2, emp_num);
			psmt.setString(3, salaryDate);
			
			rs = psmt.executeQuery();
			
			psmt.close();
			rs.close();
			
		} catch (Exception e) {
			System.out.println("pay set 중 예외 발생");
			e.printStackTrace();
		}
		
		try {
			psmt = con.prepareStatement(query2);
			psmt.setInt(1, over);
			psmt.setString(2, emp_num);
			psmt.setString(3, salaryDate);
			
			rs = psmt.executeQuery();
			
		} catch(Exception e) {
			System.out.println("extra set 중 예외 발생");
			e.printStackTrace();
		}
	}
}
