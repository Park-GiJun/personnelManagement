package Income;

import javax.naming.Context;

import DBcontrol.DBConnPool;

public class Incentive_ValueDAO extends DBConnPool {

	public Incentive_ValueDTO load_Incentive_Value(String userNum) {
		Incentive_ValueDTO dto = new Incentive_ValueDTO();

		String query = "SELECT * FROM Incentive_value WHERE emp_num=? ";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, userNum);

			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setEmpNum(rs.getString("emp_num"));
				dto.setIncnetive_value_date(rs.getDate("Incentive_Value_date"));
				dto.setHoliday_pay(rs.getInt("HOLIDAY_PAY"));
				dto.setIncentive(rs.getInt("INCENTIVE"));
				dto.setExtra_work_pay(rs.getInt("EXTRA_WORK_PAY"));
			}
		} catch (Exception e) {
			System.out.println("Incentive Value 예외 발생");
			e.printStackTrace();
		}

		return dto;

	}

}
