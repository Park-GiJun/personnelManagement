package WorkDocs;

import java.util.Arrays;
import java.util.List;

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

}
