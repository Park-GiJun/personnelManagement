package NewRegist;

import java.util.List;
import java.util.Map;

import DBcontrol.DBConnPool;

public class NewRegistDAO extends DBConnPool{
	public NewRegistDTO NewRegist (String name, String emp_num, String emp_grade, String team) {
		String query = "INSERT INTO emp (name, emp_num, emp_grade, team) VALUES (?, ?, ?, ?)";
		
		System.out.println("정보등록 쿼리 실행");
		
		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, name);
			psmt.setString(2, emp_num);
			psmt.setString(3, emp_grade);
			psmt.setString(4, team);
			
			System.out.println("[" + name + "]");
			System.out.println("[" + emp_num + "]");
			System.out.println("[" + emp_grade + "]");
			System.out.println("[" + team + "]");
			
			psmt.executeUpdate();
			System.out.println("정보 등록 완료");
		} catch (Exception e) {
			System.out.println("정보 등록 중 예외 발생");
			e.printStackTrace();
		}
		return null;
	}
	
}
