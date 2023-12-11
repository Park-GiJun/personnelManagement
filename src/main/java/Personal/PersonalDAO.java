package Personal;

import java.util.List;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class PersonalDAO extends DBConnPool {

	public PersonalDAO() {
		super();
	}

	// 로그인 아이디와 패스워드를 반환합니다.
	public PersonalDTO loginQuery(String loginId, String loginPwd) {
		PersonalDTO dto = new PersonalDTO();

		// 쿼리문 작성
		String query = "SELECT * FROM emp WHERE emp_num=? AND pass=?";
		System.out.println("longin query " + loginId + " " + loginPwd);
		System.out.println("로그인 쿼리실행");

		try {

			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, loginId);
			psmt.setString(2, loginPwd);
			System.out.println(query);

			rs = psmt.executeQuery();

			if (rs.next()) {
				// 결과로 얻은 정보를 저장
				dto.setName(rs.getString("name"));
				dto.setEmpNum(String.valueOf(rs.getInt("emp_num")));
				dto.setEmail(rs.getString("email"));
				dto.setPassword(rs.getString("pass"));
				dto.setTeam(rs.getString("team"));
				dto.setEmp_grade(rs.getString("emp_grade"));
				dto.setPhone(rs.getString("phone"));
				dto.setWork_start_date(rs.getDate("work_start_day"));
				dto.setGrade(rs.getInt("grade"));

				System.out.println("dto 받음");

			}
		} catch (Exception e) {
			System.out.println("로그인 중 예외 발생");
			e.printStackTrace();

		}
		return dto;
	}

	// 로그인 아이디와 패스워드를 반환합니다.
	public PersonalDTO getInfo(String login_Id) {
		PersonalDTO dto = new PersonalDTO();
		List<PersonalDTO> list = new Vector<PersonalDTO>();

		// 쿼리문 작성
		String query = "SELECT * FROM emp WHERE emp_num=?";

		System.out.println("getInfo" + login_Id);
		System.out.println("정보 받는 쿼리 실행");

		try {

			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, login_Id);
			System.out.println(query);

			rs = psmt.executeQuery();

			if (rs.next()) {
				// 결과로 얻은 정보를 저장
				dto.setName(rs.getString("name"));
				dto.setEmpNum(rs.getString("emp_num"));
				dto.setEmail(rs.getString("email"));
				dto.setPassword(rs.getString("pass"));
				dto.setTeam(rs.getString("team"));
				dto.setEmp_grade(rs.getString("emp_grade"));
				dto.setPhone(rs.getString("phone"));
				dto.setWork_start_date(rs.getDate("work_start_day"));
				dto.setGrade(rs.getInt("grade"));

				System.out.println("dto 받음");

				list.add(dto);

				System.out.println(dto);

			}
		} catch (Exception e) {
			System.out.println("로그인 중 예외 발생");
			e.printStackTrace();

		}
		return dto;
	}

	public void modifyInfo(String emp, String phone, String email) {
		
		System.out.println(emp + " " + phone + " " + email);
		try {
			String query = "UPDATE emp SET phone=?, email=? WHERE emp_num=?";

			psmt = con.prepareStatement(query);
			psmt.setString(1, phone);
			psmt.setString(2, email);
			psmt.setString(3, emp);

			psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("사용자 정보 업데이트중 예외 발생");
			e.printStackTrace();
		}
	}
}
