package Approval_Code;

import DBcontrol.DBConnPool;

public class CodeDAO extends DBConnPool{
	
	public CodeDAO() {
		super();
	}
	
	public void insertCode(String code, String emp, String state) {
		
		String query = "INSERT INTO APPROVAL_CODE (code) VALUES (?)";
		
		try {
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, code);
			
			psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("코드 삽입중 예외발생");
			e.printStackTrace();
		}
		
		query = "INSERT INTO APPROVAL_LINE (code, emp_num, approval_state) VALUES (?, ?, ?)";
		
		try {
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, code);
			psmt.setString(2, emp);
			psmt.setString(3, state);
			
			psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("라인 삽입중 예외발생");
			e.printStackTrace();
		}
	}

}
