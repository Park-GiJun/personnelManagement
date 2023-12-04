package Personal;

import java.util.List;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class PersonalDAO extends DBConnPool {

	public PersonalDAO() {
		super();
	}

	// 로그인 아이디와 패스워드를 반환합니다.
	public PersonalDTO loginQuery(String login_Id, String login_Pwd) {
		PersonalDTO dto = new PersonalDTO();

		// 쿼리문 작성
		String query = "SELECT * FROM emp WHERE emp_num=? AND pass=?";

		System.out.println("longin query " + login_Id + " " + login_Pwd);
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
				dto.setEmpNum(String.valueOf(rs.getInt("emp_num")));
				dto.setEmail(rs.getString("email"));
				dto.setPassword(rs.getString("pass"));
				dto.setTeam(rs.getString("tea,"));
				dto.setEmp_grade(rs.getString("emp_grade"));
				dto.setPhone(rs.getInt("phone"));
				dto.setWork_start_date(rs.getDate("work_start_date"));

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
			System.out.println("0");

			if (rs.next()) {
				System.out.println("0-1");
				// 결과로 얻은 정보를 저장
				dto.setName(rs.getString("name"));
				dto.setEmpNum(rs.getString("emp_num"));
				dto.setEmail(rs.getString("email"));
				dto.setPassword(rs.getString("pass"));
				dto.setTeam(rs.getString("tea,"));
				dto.setEmp_grade(rs.getString("emp_grade"));
				dto.setPhone(rs.getInt("phone"));
				dto.setWork_start_date(rs.getDate("work_start_date"));

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
}
