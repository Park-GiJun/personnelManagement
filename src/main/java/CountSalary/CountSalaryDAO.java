package CountSalary;

import DBcontrol.DBConnPool;

public class CountSalaryDAO extends DBConnPool {

	public CountSalaryDAO() {
		super();
	}

	public CountSalaryDTO countSalary(String emp_num, String date) {
		System.out.println("급여 계산 시작");
		
		CountSalaryDTO dto = new CountSalaryDTO();

		String query = "SELECT " +
			    "    emp_num, " +
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
			    " FROM " +
			    "    attendance " +
			    " WHERE " +
			    "    emp_num = ? " +
			    "    AND TO_CHAR(day_of_WORK, 'YYYY-MM') = ? " +
			    " GROUP BY " +
			    "    emp_num";


		try {
	
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, emp_num);
			psmt.setString(2, date);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				
			
				dto.setActual_work_time(rs.getInt("TOTAL_ACTUAL_WORK_HOURS"));
				dto.setOvertime_work(rs.getInt("TOTAL_OVERTIME_HOURS"));
			}
			
		} catch (Exception e) {
			System.out.println("급여계산중 예외 발생");
			e.printStackTrace();
		} 
		
		System.out.println(dto.getActual_work_time() + "\n" + dto.getOvertime_work());
		
		return dto;
	}
}
