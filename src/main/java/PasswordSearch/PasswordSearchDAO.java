package PasswordSearch;

import DBcontrol.DBConnPool;

public class PasswordSearchDAO extends DBConnPool{

	public String PasswordSearch (String Password, String loginNum) {
		String query = "UPDATE emp SET pass = ? WHERE emp_num= ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, Password);
			psmt.setString(2, loginNum);

			psmt.executeUpdate();
			System.out.println("정보 수정 완료");
		} catch (Exception e) {
			System.out.println("정보 수정 중 예외 발생");
			e.printStackTrace();
		}
		return null;
	}
}
