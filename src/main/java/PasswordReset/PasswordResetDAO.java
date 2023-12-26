package PasswordReset;

import DBcontrol.DBConnPool;

public class PasswordResetDAO extends DBConnPool{

	public String PasswordReset (String loginNum) {
		String query = "UPDATE emp SET pass = '1234' WHERE emp_num= ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, loginNum);

			psmt.executeUpdate();
			System.out.println(query);
			System.out.println("비밀번호 리셋 완료");
		} catch (Exception e) {
			System.out.println("비밀번호 리셋 중 예외 발생");
			e.printStackTrace();
		}
		return null;
	}
}
