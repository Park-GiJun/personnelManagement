package FreeboardForm;

import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class FreeboardFormDAO extends DBConnPool{

	public FreeboardFormDAO() {
		super();
	}

	public int FreeboardListCont(Map<String, Object>map) {
		System.out.println("FreeboardListCont");
		int totalcount =0;
		
		String query = "SELECT COUNT(*) FROM anno_board";
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchCategory") + " LIKE '%" + map.get("searchWord") + "%'";
		}

		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리문 실행
			rs.next();
			totalcount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		System.out.println(totalcount);
		return totalcount;
	}
	
	public List<FreeboardFormDTO> selectListPage(Map<String, Object> map) {
		System.out.println("selectListpage");
		List<FreeboardFormDTO> anno_board = new Vector<FreeboardFormDTO>();

		System.out.println("SelectListPage 실행");
		// 쿼리문
		String query = "SELECT * FROM (SELECT Tb.*, ROWNUM AS rNum FROM (SELECT * FROM anno_board";
		if (map.get("searchWord") != null) {
			// 조건 추가
			query += " WHERE " + map.get("searchCategory") + " LIKE '%" + map.get("searchWord") + "%'";
		}

		query += " ORDER BY anno_board_num DESC) Tb) WHERE rNum BETWEEN ? AND ?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			System.out.println("FreeboardFormController :" + query);
			rs = psmt.executeQuery();

			// 반환된 게시물 목록을 컬렉션에 추가
			while (rs.next()) {
				FreeboardFormDTO dto = new FreeboardFormDTO();

				dto.setanno_board_num(rs.getInt("anno_board_num"));
				dto.setboard_pass(rs.getInt("board_pass"));
				dto.settitle(rs.getString("title"));
				dto.setcontent(rs.getString("content"));
				dto.setpost_date(rs.getDate("post_date"));
				dto.setvisitcount ( rs.getInt("visitcount"));
				anno_board.add(dto);

			}
		} catch (Exception e) {
			System.out.println("게시물 조회중 예외 발생");
			e.printStackTrace();
		}
		return anno_board;
	}
	
	
}
