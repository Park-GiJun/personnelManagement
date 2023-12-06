package NewRegist;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import DBcontrol.DBConnPool;
import HoliDay.HoliDayDTO;

public class NewRegistDAO extends DBConnPool {
	public NewRegistDTO NewRegist(String name, String emp_num, String emp_grade, String team , String grade) {
		String query = "INSERT INTO emp (name, emp_num, emp_grade, team, grade) VALUES (?, ?, ?, ?, ?)";

		System.out.println("정보등록 쿼리 실행");

		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, name);
			psmt.setString(2, emp_num);
			psmt.setString(3, emp_grade);
			psmt.setString(4, team);
			psmt.setString(5, grade);

			psmt.executeUpdate();
			System.out.println("정보 등록 완료");
		} catch (Exception e) {
			System.out.println("정보 등록 중 예외 발생");
			e.printStackTrace();
		}
		return null;
	}

	// 게시물 수를 가져오는 쿼리
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;

		String query = "SELECT COUNT(*) FROM emp";
		try {
			// 쿼리 실행
			stmt = con.createStatement();

			rs = stmt.executeQuery(query);
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	// 사원 목록 조회 쿼리
		public List<NewRegistDTO> selectList(Map<String, Object> map) {
			List<NewRegistDTO> bbs = new Vector<NewRegistDTO>();

			String query = "SELECT * FROM emp ORDER BY grade, team, name";

			try {
				// 쿼리 실행
				psmt = con.prepareStatement(query);

				rs = psmt.executeQuery();
				while (rs.next()) {
					NewRegistDTO dto = new NewRegistDTO();

					dto.setName(rs.getString("name"));
					dto.setEmp_num(rs.getString("emp_num"));
					dto.setEmail(rs.getString("email"));
					dto.setPass(rs.getString("pass"));
					dto.setEmp_grade(rs.getString("emp_grade"));
					dto.setPhone(rs.getString("phone"));
					dto.setTeam(rs.getString("team"));
					dto.setWork_start_day(rs.getString("work_start_day"));

					bbs.add(dto);
				}
			} catch (Exception e) {
				System.out.println("사원 조회 중 예외 발생");
				e.printStackTrace();
			} 
			return bbs;
		}
}
