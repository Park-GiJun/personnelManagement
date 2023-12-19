package WorkDocs;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import DBcontrol.DBConnPool;

public class WorkDocsDAO extends DBConnPool {

	public WorkDocsDAO() {
		super();
	}

	public void writeBoard(WorkDocsDTO dto, List<String> codelist) {

		List<String> prex = Arrays.asList("first", "second", "third", "fourth", "fifth");

		int count = codelist.size();

		System.out.println(count);

		String query = "INSERT INTO APPROVAL_DOC ("
				+ "IDX, EMP_NUM, TEAM, APPROVAL_DOC_TITLE, APPROVAL_DOC_CONTENT, APPROVAL_DOC_OFILE, APPROVAL_DOC_SFILE, APPROVAL_DOC_DATE, FIRST_CODE, SECOND_CODE, THIRD_CODE, FOURTH_CODE, FIFTH_CODE)"
				+ "VALUES (docList.nextval, ?, ?, ?, ?, ?, ?, sysdate,";

		switch (count) {
		case 1: {
			query += " ?, null, null, null, null)";
			break;
		}
		case 2: {
			query += " ?, ?, null, null, null)";
			break;
		}
		case 3: {
			query += " ?, ?, ?, null, null)";
			break;
		}
		case 4: {
			query += " ?, ?, ?, ?, null)";
			break;
		}
		case 5: {
			query += " ?, ?, ?, ?, ?)";
			break;
		}
		default:
			throw new IllegalArgumentException("Unexpected value: " + count);
		}

		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getEmp_num());
			psmt.setString(2, dto.getTeam());
			psmt.setString(3, dto.getApproval_doc_title());
			psmt.setString(4, dto.getApproval_doc_content());
			psmt.setString(5, dto.getApproval_doc_ofile());
			psmt.setString(6, dto.getApproval_doc_sfile());

			switch (count) {
			case 1: {
				psmt.setString(7, codelist.get(0));
				break;
			}
			case 2: {
				psmt.setString(7, codelist.get(0));
				psmt.setString(8, codelist.get(1));
				break;
			}
			case 3: {
				psmt.setString(7, codelist.get(0));
				psmt.setString(8, codelist.get(1));
				psmt.setString(9, codelist.get(2));
				break;
			}
			case 4: {
				psmt.setString(7, codelist.get(0));
				psmt.setString(8, codelist.get(1));
				psmt.setString(9, codelist.get(2));
				psmt.setString(10, codelist.get(3));
				break;
			}
			case 5: {
				psmt.setString(7, codelist.get(0));
				psmt.setString(8, codelist.get(1));
				psmt.setString(9, codelist.get(2));
				psmt.setString(10, codelist.get(3));
				psmt.setString(11, codelist.get(4));
				break;
			}
			default:
				throw new IllegalArgumentException("Unexpected value: " + count);
			}

			psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("글 작성중 예외 발생");
			e.printStackTrace();
		}

	}

	public List<WorkDocsDTO> boardList(String emp) {

		System.out.println("boardList : " + emp);

		List<WorkDocsDTO> list = new ArrayList<WorkDocsDTO>();

		String query = "SELECT ad.idx, ad.APPROVAL_DOC_TITLE AS title, ad.TEAM AS writerteam, "
				+ "ad.APPROVAL_DOC_DATE AS writedate, ad.EMP_NUM AS writer " + "FROM APPROVAL_DOC ad "
				+ "LEFT JOIN APPROVAL_LINE al ON ad.FIRST_CODE = al.CODE "
				+ "LEFT JOIN APPROVAL_LINE al2 ON ad.SECOND_CODE = al2.CODE "
				+ "LEFT JOIN APPROVAL_LINE al3 ON ad.THIRD_CODE = al3.CODE "
				+ "LEFT JOIN APPROVAL_LINE al4 ON ad.FOURTH_CODE = al4.code "
				+ "LEFT JOIN APPROVAL_LINE al5 ON ad.FIFTH_CODE = al5.CODE "
				+ "WHERE ? IN (al.EMP_NUM, al2.EMP_NUM, al3.EMP_NUM, al4.EMP_NUM, al5.EMP_NUM) "
				+ "ORDER BY ad.idx, ad.APPROVAL_DOC_DATE";

		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, emp);

			rs = psmt.executeQuery();

			while (rs.next()) {
				WorkDocsDTO dto = new WorkDocsDTO();

				dto.setIdx(rs.getInt("idx"));
				dto.setApproval_doc_title(rs.getString("title"));
				dto.setTeam(rs.getString("writerteam"));
				dto.setApproval_doc_date(rs.getDate("writedate"));
				dto.setEmp_num(rs.getString("writer"));

				System.out.println("제목 확인 : " + dto.getApproval_doc_title());

				list.add(dto);
			}

		} catch (Exception e) {
			System.out.println("결재문서 불러오는중 예외 발생");
			e.printStackTrace();
		}

		return list;

	}

	public int WorkDocsListCount(Map<String, Object> map, String emp) {
		System.out.println("WorkDocsCount");
		int totalcount = 0;

		// 쿼리문 준비
		String query = "SELECT count(*) FROM APPROVAL_DOC ad "
				+ "LEFT JOIN APPROVAL_LINE al ON ad.FIRST_CODE = al.CODE "
				+ "LEFT JOIN APPROVAL_LINE al2 ON ad.SECOND_CODE = al2.CODE "
				+ "LEFT JOIN APPROVAL_LINE al3 ON ad.THIRD_CODE = al3.CODE "
				+ "LEFT JOIN APPROVAL_LINE al4 ON ad.FOURTH_CODE = al4.code "
				+ "LEFT JOIN APPROVAL_LINE al5 ON ad.FIFTH_CODE = al5.CODE "
				+ "WHERE ? IN (al.EMP_NUM, al2.EMP_NUM, al3.EMP_NUM, al4.EMP_NUM, al5.EMP_NUM)";

//		// 검색 조건이 있다면 where절로 추가
//		if (map.get("searchWord") != null) {
//			query += " WHERE " + map.get("searchCategory") + " LIKE '%" + map.get("searchWord") + "%'";
//		}

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, emp);
			rs = psmt.executeQuery();
			rs.next();
			totalcount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		System.out.println(totalcount);
		return totalcount;
	}

	public WorkDocsDTO getContent(String idx) {

		WorkDocsDTO dto = new WorkDocsDTO();

		String query = "SELECT " + "ad.APPROVAL_DOC_TITLE, " + "ad.APPROVAL_DOC_CONTENT, " + "ad.APPROVAL_DOC_OFILE, "
				+ "ad.APPROVAL_DOC_SFILE, " + "e.team AS FIRSTTEAM, " + "e.EMP_GRADE AS FIRSTGRADE, "
				+ "e.EMP_NUM AS FIRSTEMP, " + "e.NAME AS FIRSTNAME, " + "al.APPROVAL_STATE AS FIRSTSTATUS, "
				+ "e2.team AS SECONDTEAM, " + "e2.EMP_GRADE AS SECONDGRADE, " + "e2.EMP_NUM AS SECONDEMP, "
				+ "e2.NAME AS SECONDNAME, " + "al2.APPROVAL_STATE AS SECONDSTATUS, " + "e3.team AS THIRDTEAM, "
				+ "e3.EMP_GRADE AS THIRDGRADE, " + "e3.EMP_NUM AS THIRDEMP, " + "e3.NAME AS THIRDNAME, "
				+ "al3.APPROVAL_STATE AS THIRDSTATUS, " + "e4.team AS FOURTHTEAM, " + "e4.EMP_GRADE AS FOURTHGRADE, "
				+ "e4.EMP_NUM AS FOURTHEMP, " + "e4.NAME AS FOURTHNAME, " + "al4.APPROVAL_STATE AS FOURTHSTATUS, "
				+ "e5.team AS FIFTHTEAM, " + "e5.EMP_GRADE AS FIFTHGRADE, " + "e5.EMP_NUM AS FIFTHEMP, "
				+ "e5.NAME AS FIFTHNAME, " + "al5.APPROVAL_STATE AS FIFTHSTATUS " + "FROM APPROVAL_DOC ad "
				+ "LEFT JOIN APPROVAL_LINE al ON al.CODE = ad.FIRST_CODE "
				+ "LEFT JOIN EMP e ON al.EMP_NUM = e.EMP_NUM "
				+ "LEFT JOIN APPROVAL_LINE al2 ON al2.CODE = ad.SECOND_CODE "
				+ "LEFT JOIN EMP e2 ON al2.EMP_NUM = e2.EMP_NUM "
				+ "LEFT JOIN APPROVAL_LINE al3 ON al3.CODE = ad.THIRD_CODE "
				+ "LEFT JOIN EMP e3 ON al3.EMP_NUM = e3.EMP_NUM "
				+ "LEFT JOIN APPROVAL_LINE al4 ON al4.CODE = ad.FOURTH_CODE "
				+ "LEFT JOIN EMP e4 ON al4.EMP_NUM = e4.EMP_NUM "
				+ "LEFT JOIN APPROVAL_LINE al5 ON al5.CODE = ad.FIFTH_CODE "
				+ "LEFT JOIN EMP e5 ON al5.EMP_NUM = e5.EMP_NUM " + "WHERE ad.idx = ?";

		try {

			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);

			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setApproval_doc_title(rs.getString("APPROVAL_DOC_TITLE"));
				dto.setApproval_doc_content(rs.getString("APPROVAL_DOC_CONTENT"));
				dto.setApproval_doc_ofile(rs.getString("APPROVAL_DOC_OFILE"));
				dto.setApproval_doc_sfile(rs.getString("APPROVAL_DOC_SFILE"));

				dto.setFirstTEAM(rs.getString("FIRSTTEAM"));
				dto.setFirstGRADE(rs.getString("FIRSTGRADE"));
				dto.setFirstEmp(rs.getString("FIRSTEMP"));
				dto.setFirstNAME(rs.getString("FIRSTNAME"));
				dto.setFirststatus(rs.getString("FIRSTSTATUS"));

				dto.setSecondTEAM(rs.getString("SECONDTEAM"));
				dto.setSecondGRADE(rs.getString("SECONDGRADE"));
				dto.setSecondEmp(rs.getString("SECONDEMP"));
				dto.setSecondNAME(rs.getString("SECONDNAME"));
				dto.setSecondstatus(rs.getString("SECONDSTATUS"));

				dto.setThirdTEAM(rs.getString("THIRDTEAM"));
				dto.setThirdGRADE(rs.getString("THIRDGRADE"));
				dto.setThirdEmp(rs.getString("THIRDEMP"));
				dto.setThirdNAME(rs.getString("THIRDNAME"));
				dto.setThirdstatus(rs.getString("THIRDSTATUS"));

				dto.setFourthTEAM(rs.getString("FOURTHTEAM"));
				dto.setFourthGRADE(rs.getString("FOURTHGRADE"));
				dto.setFourthEmp(rs.getString("FOURTHEMP"));
				dto.setFourthNAME(rs.getString("FOURTHNAME"));
				dto.setFourthstauts(rs.getString("FOURTHSTATUS"));

				dto.setFifthTEAM(rs.getString("FIFTHTEAM"));
				dto.setFifthGRADE(rs.getString("FIFTHGRADE"));
				dto.setFifthEmp(rs.getString("FIFTHEMP"));
				dto.setFifthNAME(rs.getString("FIFTHNAME"));
				dto.setFifthstatus(rs.getString("FIFTHSTATUS"));

			}

		} catch (Exception e) {
			System.out.println("결재문서 디테일 불러오는중 예외 발생");
			e.printStackTrace();
		}

		return null;

	}

}
