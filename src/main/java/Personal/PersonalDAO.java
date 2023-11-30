package Personal;

import DBcontrol.DBConnPool;

public class PersonalDAO extends DBConnPool {

	public PersonalDAO() {
		super();
	}

	// 로그인 아이디와 패스워드를 반환합니다.
	public PersonalDTO loginQuery(String login_Id, String login_Pwd) {
		PersonalDTO dto = new PersonalDTO();

		// 쿼리문 작성
		String query = "SELECT * FROM emp WHERE emp_num=? AND password=?";

		System.out.println(login_Id + " " + login_Pwd);
		System.out.println("로그인 쿼리실행");

		try {

			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, login_Id);
			psmt.setString(2, login_Pwd);
			System.out.println(query);

			rs = psmt.executeQuery();

			if (rs.next()) {
				// 결과로 얻은 정보를 저장
				dto.setName(rs.getString("name"));
				dto.setEmpNum(rs.getString("emp_num")); 
				dto.setEmail(rs.getString("email"));
				dto.setPassword(rs.getString("password"));
				dto.setDepartment(rs.getString("department"));
				dto.setGrade(rs.getString("grade"));
				dto.setPhone(rs.getInt("phone"));
				dto.setCompanydate(rs.getDate("companydate"));

				System.out.println("dto 받음");

			}
		} catch (Exception e) {
			System.out.println("로그인 중 예외 발생");
			e.printStackTrace();

		}
		return dto;
	}

}
