package Approval_Code;

import DBcontrol.DBConnPool;

public class CodeDAO extends DBConnPool {

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
		System.out.println("hi");
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

	public void updateState(String code) {
		String query = "UPDATE APPROVAL_LINE SET APPROVAL_STATE = '완료' WHERE code = ?";


		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, code);

			psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("Update State 중 예외 발생");
			e.printStackTrace();
		}
		
		doc_state(code);

	}

	public void rejectState(String code) {
		String query = "UPDATE APPROVAL_LINE SET APPROVAL_STATE = '거절' WHERE code = ?";

		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, code);

			psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("Reject State 중 예외 발생");
			e.printStackTrace();
		}
		
		doc_state(code);

	}

	public void doc_state(String code) {
		String call = "{call update_doc_status(?)}";
		String query = "SELECT al.ROWID FROM APPROVAL_Line al WHERE code = ?";
		String idxID = "";

		try {
			System.out.println("0");
			psmt = con.prepareStatement(query);
			System.out.println("1");
			psmt.setString(1, code);
			System.out.println("2");
			rs = psmt.executeQuery();
			System.out.println("3");

			if (rs.next()) {
				System.out.println("4");
				idxID = rs.getString(1);
				System.out.println("5");
			}
		} catch (Exception e) {
			System.out.println("idx id 찾는 중 예외 발생");
			e.printStackTrace();
		}

		try {
			System.out.println("6");
			csmt = con.prepareCall(call);
			System.out.println("7");
			csmt.setString(1, idxID);
			System.out.println("8");
			csmt.execute();
			System.out.println("9");
		} catch (Exception e) {
			System.out.println("프로시저 실행 중 예외 발생");
			e.printStackTrace();
		} finally {
			close(); // 자원 정리
		}
	}

}
