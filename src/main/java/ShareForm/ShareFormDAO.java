package ShareForm;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import DBcontrol.DBConnPool;

public class ShareFormDAO extends DBConnPool {

	public ShareFormDAO() {
		super();
	}

	// 검색 조건에 맞는 게시물의 개수를 반환합니다.
	public int shareListCount(Map<String, Object> map) {
		System.out.println("shareListCount");
		int totalcount = 0;

		// 쿼리문 준비
		String query = "SELECT COUNT(*) FROM board";

		// 검색 조건이 있다면 where절로 추가
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

	// 검색 조건에 맞는 게시물 목록을 반환합니다.
	public List<ShareFormDTO> selectListPage(Map<String, Object> map) {
		System.out.println("selectListpage");
		List<ShareFormDTO> boards = new Vector<ShareFormDTO>();

		System.out.println("SelectListPage 실행");
		// 쿼리문
		String query = "SELECT * FROM (SELECT Tb.*, ROWNUM AS rNum FROM (SELECT * FROM board";
		if (map.get("searchWord") != null) {
			// 조건 추가
			query += " WHERE " + map.get("searchCategory") + " LIKE '%" + map.get("searchWord") + "%'";
		}

		query += " ORDER BY board_num DESC) Tb) WHERE rNum BETWEEN ? AND ?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			System.out.println("ShareFormController :" + query);
			rs = psmt.executeQuery();

			// 반환된 게시물 목록을 컬렉션에 추가
			while (rs.next()) {
				ShareFormDTO dto = new ShareFormDTO();

				dto.setIdx(rs.getString("board_num"));
				dto.setTitle(rs.getString("title"));
				dto.setShareofile(rs.getString("ofile"));
				dto.setSharesfile(rs.getString("sfile"));

				boards.add(dto);

			}
		} catch (Exception e) {
			System.out.println("게시물 조회중 예외 발생");
			e.printStackTrace();
		}
		return boards;
	}

	public int insertFile(ShareFormDTO dto) {

		int result = 0;
		System.out.println("제목 :" + dto.getTitle());
		System.out.println("파일 :" + dto.getSharesfile());
		System.out.println("파일 :" + dto.getSharesfile());
		System.out.println("비밀번호 :" + dto.getPassword());
		try {

			String query = "INSERT INTO board (board_num, title, ofile, sfile, pass) VALUES (BOARD_NUM.NEXTVAL, ?, ?, ?, ?)";

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getShareofile());
			psmt.setString(3, dto.getSharesfile());
			psmt.setString(4, dto.getPassword());

			result = psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("파일 업로드중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}

}
