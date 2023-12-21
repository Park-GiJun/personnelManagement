package Reference;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;

import DBcontrol.DBConnPool;

public class ReferenceDAO extends DBConnPool {

	public ReferenceDAO() {
		super();
	}

	public Map<String, ReferenceDTO> loadRef() {

		Map<String, ReferenceDTO> map = new HashMap<String, ReferenceDTO>();

		String query = "SELECT " + "    ar.*, " + "    e.name AS firstNAME, " + "    e.EMP_GRADE AS firstGRADE, "
				+ "    e.TEAM AS firstTEAM, " + "    e2.NAME AS secondNAME, " + "    e2.EMP_GRADE AS secondGRADE, "
				+ "    e2.TEAM AS secondTEAM, " + "    e3.name AS THIRDNAME, " + "    e3.EMP_GRADE AS thirdGRADE, "
				+ "    e3.team AS thirdTEAM, " + "    e4.name AS fourthNAME, " + "    e4.EMP_GRADE AS fourthGRADE, "
				+ "    e4.team AS fourthTEAM, " + "    e5.name AS fifthNAME, " + "    e5.EMP_GRADE AS fifthGRADE, "
				+ "    e5.team AS fifthTEAM " + "FROM " + "    APPROVAL_REFERENCE ar " + "LEFT JOIN "
				+ "    emp e ON ar.FIRST_EMP = e.emp_num " + "LEFT JOIN " + "    emp e2 ON ar.SECOND_EMP = e2.emp_num "
				+ "LEFT JOIN " + "    emp e3 ON ar.THIRD_EMP = e3.emp_num " + "LEFT JOIN "
				+ "    emp e4 ON ar.FOURTH_EMP = e4.emp_num " + "LEFT JOIN "
				+ "    emp e5 ON ar.FIFTH_EMP = e5.emp_num";

		try {

			psmt = con.prepareStatement(query);

			rs = psmt.executeQuery();

			while (rs.next()) {
				ReferenceDTO dto = new ReferenceDTO();

				dto.setName(rs.getString("REFERENCES_NAME"));

				dto.setFirstEmp(rs.getString("FIRST_EMP"));
				dto.setFirstNAME(rs.getString("firstNAME"));
				dto.setFirstGRADE(rs.getString("firstGRADE"));
				dto.setFirstTEAM(rs.getString("firstTEAM"));

				dto.setSecondEmp(rs.getString("SECOND_EMP"));
				dto.setSecondNAME(rs.getString("secondNAME"));
				dto.setSecondGRADE(rs.getString("secondGRADE"));
				dto.setSecondTEAM(rs.getString("secondTEAM"));

				dto.setThirdEmp(rs.getString("THIRD_EMP"));
				dto.setThirdNAME(rs.getString("thirdNAME"));
				dto.setThirdGRADE(rs.getString("thirdGRADE"));
				dto.setThirdTEAM(rs.getString("thirdTEAM"));

				dto.setFourthEmp(rs.getString("FOURTH_EMP"));
				dto.setFourthNAME(rs.getString("fourthNAME"));
				dto.setFourthGRADE(rs.getString("fourthGRADE"));
				dto.setFourthTEAM(rs.getString("fourthTEAM"));

				dto.setFifthEmp(rs.getString("FIFTH_EMP"));
				dto.setFifthNAME(rs.getString("fifthNAME"));
				dto.setFifthGRADE(rs.getString("fifthGRADE"));
				dto.setFifthTEAM(rs.getString("fifthTEAM"));

				map.put(dto.getName(), dto);

			}

		} catch (Exception e) {
			System.out.println("레퍼런스 불러오는중 예외 발생");
			e.printStackTrace();
		}

		return map;
	}

	public void addRef(JSONArray str, String title) {

		int leg = str.length();

		String query = "INSERT INTO APPROVAL_REFERENCE (REFERENCES_NAME, ";

		switch (leg) {
		case 1: {
			query += "FIRST_EMP) VALUES (?, ?)";
			break;
		}
		case 2: {
			query += "FIRST_EMP, SECOND_EMP) VALUES (?, ?, ?)";
			break;
		}
		case 3: {
			query += "FIRST_EMP, SECOND_EMP, THIRD_EMP) VALUES (?, ?, ?, ?)";
			break;
		}
		case 4: {
			query += "FIRST_EMP, SECOND_EMP, THIRD_EMP, FOURTH_EMP) VALUES (?, ?, ?, ?, ?)";
			break;
		}
		case 5: {
			query += "FIRST_EMP, SECOND_EMP, THIRD_EMP, FOURTH_EMP, FIFTH_EMP) VALUES (?, ?, ?, ?, ?, ?)";
			break;
		}
		default:
			throw new IllegalArgumentException("Unexpected value: " + leg);
		}
		System.out.println(query);

		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, title);

			for (int i = 0; i < leg; i++) {
				psmt.setString(i + 2, str.getString(i));
			}
			psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("업데이트 레퍼런스 중 예외 발생");
			e.printStackTrace();
		}
	}

}
