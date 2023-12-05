package Income;

import DBcontrol.DBConnPool;

public class IncentiveDAO extends DBConnPool{
	
	public IncentiveDTO load_Incentive(String userNum) {
		IncentiveDTO dto = new IncentiveDTO();

		String query = "SELECT * FROM Incentive WHERE emp_num=? ";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, userNum);

			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setEmpNum(rs.getString("emp_num"));
				dto.setPay(rs.getInt("Pay"));
				dto.setAddtional_pay(rs.getInt("Additional_pay"));
			}
		} catch (Exception e) {
			System.out.println("Incentive 예외 발생");
			e.printStackTrace();
		}

		return dto;

	}

}
