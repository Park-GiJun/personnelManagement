package Personal;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
				dto.setTeam_num(rs.getString("team_num"));

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
				dto.setTeam_num(rs.getString("team_num"));

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

	public void modifyInfo(String emp, String phone, String email, String pass) {

		System.out.println(emp + " " + phone + " " + email + " " + pass);

		try {
			String query = "UPDATE emp SET phone=?, email=?, pass=? WHERE emp_num=?";

			psmt = con.prepareStatement(query);
			psmt.setString(1, phone);
			psmt.setString(2, email);
			psmt.setString(3, pass);
			psmt.setString(4, emp);

			psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("사용자 정보 업데이트중 예외 발생");
			e.printStackTrace();
		}
		System.out.println(
				"UPDATE emp SET phone= " + phone + ", email= " + email + ", pass= " + pass + " WHERE emp_num= " + emp);
	}

	public List<Depart> PersonList() {

		List<Depart> org = new ArrayList<>();
		Map<String, Depart> departMap = new HashMap<>();
		Map<String, Team> teamMap = new HashMap<>();
		String query = "SELECT * FROM emp ORDER BY  TEAM_NUM , GRADE, TEAM , name, EMP_NUM";

		try {

			psmt = con.prepareStatement(query);

			rs = psmt.executeQuery();

			while (rs.next()) {
				PersonalDTO dto = new PersonalDTO();
				dto.setName(rs.getString("name"));
				dto.setEmpNum(rs.getString("emp_num"));
				dto.setEmp_grade(rs.getString("emp_grade"));
				dto.setTeam(rs.getString("team"));
				dto.setTeamDetail(rs.getString("team_num"));

				String departName = dto.getTeam();
				String teamName = dto.getTeamDetail();
				String personName = dto.getName();

				// 부서 객체 가져오기, 없으면 생성
				Depart depart = departMap.getOrDefault(departName, new Depart());
				depart.setcDepartname(departName);

				// 팀 객체 가져오기, 없으면 생성
				Team team = teamMap.getOrDefault(teamName, new Team());
				team.setName(teamName);

				// 개인 매핑 추가
				if (team.getTeam() == null) {
					team.setTeam(new HashMap<>());
				}
				team.getTeam().put(personName, dto);

				// 팀이 부서에 없으면 추가
				if (!depart.getDeparts().contains(team)) {
					depart.getDeparts().add(team);
				}

				// 맵에 부서 객체 저장
				departMap.put(departName, depart);
				// 맵에 팀 객체 저장
				teamMap.put(teamName, team);

				// 최종 리스트에 부서 객체 추가
				if (!org.contains(depart)) {
					org.add(depart);
				}
			}

		} catch (Exception e) {
			System.out.println("사람 리스트 불러오는중 예외 발생");
			e.printStackTrace();
		}
		return org;
	}

	public PersonalDTO findPerson(String empnum) {

		PersonalDTO dto = new PersonalDTO();

		String query = "SELECT * FROM emp WHERE emp_num=?";

		try {

			psmt = con.prepareStatement(query);

			psmt.setString(1, empnum);

			rs = psmt.executeQuery();

			if (rs.next()) {

				dto.setTeam(rs.getString("team"));
				dto.setEmp_grade(rs.getString("emp_grade"));
				dto.setEmpNum(rs.getString("emp_num"));
				dto.setName(rs.getString("name"));

			}

		} catch (Exception e) {
			System.out.println("사람 찾는중 예외 발생");
			e.printStackTrace();

		}

		return dto;
	}
}
