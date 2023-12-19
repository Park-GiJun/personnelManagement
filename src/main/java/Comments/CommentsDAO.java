package Comments;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import DBcontrol.DBConnPool;
import FreeboardForm.FreeboardFormDTO;

public class CommentsDAO extends DBConnPool {
	private ResultSet rs;
	private PreparedStatement pstmt;
	
	public List<CommentsDTO> selectListPage(Map<String, Object> map) {
		System.out.println("selectListpage");
		List<CommentsDTO> anno_boards = new Vector<CommentsDTO>();

		System.out.println("상세보기 댓글 SelectListPage 실행");
		// 쿼리문
		String query = "SELECT * FROM (SELECT Tb.*, ROWNUM AS rNum FROM (SELECT * FROM 채ㅡㅡ둣ㄴ";
		if (map.get("searchWord") != null) {
			// 조건 추가
			query += " WHERE " + map.get("searchCategory") + " LIKE '%" + map.get("searchWord") + "%'";
		}

		query += " ORDER BY anno_board_num DESC) Tb) WHERE rNum BETWEEN ? AND ?";
		System.out.println("FreeboardFormController : 51 lines --------------------------");
		System.out.println(query);

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			System.out.println("FreeboardFormController :" + query);
			rs = psmt.executeQuery();

			// 반환된 게시물 목록을 컬렉션에 추가
			while (rs.next()) {
				CommentsDTO dto = new CommentsDTO();

				dto.setanno_board_num(rs.getInt("anno_board_num"));
				dto.setcontent(rs.getString("content"));
				dto.setpass(rs.getInt("pass"));
				dto.setTurn(rs.getInt("Turn"));
				anno_boards.add(dto);
				System.out.println(dto.getanno_board_num() + dto.getcontent() + dto.getpass());
			}
		} catch (Exception e) {
			System.out.println("게시물 조회중 예외 발생");
			e.printStackTrace();
		}
		return anno_boards;
	}
	
	public int FreeboardListCont(Map<String, Object> map) {
		System.out.println("CommentsListCont");
		int totalcount = 0;

		String query = "SELECT COUNT(*) FROM Comments";

		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchCategory") + " LIKE '%" + map.get("searchWord") + "%'";
		}

		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리문 실행
			rs.next();
			totalcount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("양식 게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		System.out.println(totalcount);
		return totalcount;
	}


	public ArrayList<CommentsDTO> getList(int anno_board_num, int Turn) {
		String Sql = "select * from Comments where anno_board_num<? and Turn=? and content order by Turn ";
		ArrayList<CommentsDTO> list = new ArrayList<CommentsDTO>();
		try {
			PreparedStatement pstmt = con.prepareStatement(Sql);
			pstmt.setInt(1, getNext() - (Turn - 1) * 10);
			pstmt.setInt(2, Turn);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CommentsDTO comments = new CommentsDTO();
				comments.setanno_board_num(rs.getInt(1));
				comments.setTurn(rs.getInt(2));
				comments.setcontent(rs.getString(3));
				list.add(comments);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int getNext() {
		String SQL = "select Turn FROM Comments ORDER BY Turn DESC";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				System.out.println(rs.getInt(1)); // select문에서 첫번째 값
				return rs.getInt(1) + 1; // 현재 인덱스(현재 게시글 개수) +1 반환
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public CommentsDTO getDetail(int anno_board_num) {
		CommentsDTO board = null;
		try {
			con = DBConnPool.getConnection();

			StringBuffer sql = new StringBuffer();
			sql.append("select * from Comments where anno_board_num<? and Turn=? and content order by Turn ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, anno_board_num);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				board = new CommentsDTO();
				board.setanno_board_num(anno_board_num);
				board.setTurn(rs.getInt("Turn"));
				board.setcontent(rs.getString("content"));
			}

		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}

		close();
		return board;
	} // end getDetail()
	
	

	// 지정 게시물 찾아 내용을 반환
	public FreeboardFormDTO selectdetailsView(int anno_board_num) {
		FreeboardFormDTO dto = new FreeboardFormDTO();
		String query = " SELECT anno_board_num, title, content ,post_date,board_pass  FROM anno_board WHERE anno_board_num=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, anno_board_num);
			rs = psmt.executeQuery();

			if (rs.next()) {
				dto.setanno_board_num(rs.getInt(1));
				dto.settitle(rs.getString(2));
				dto.setcontent(rs.getString(3));
				dto.setpost_date(rs.getDate(4));
				dto.setboard_pass(rs.getInt("board_pass"));
			}
		} catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}

	// 댓글
	public List<CommentsDTO> selectView(int anno_board_num) {
		String query = "select * from Comments where anno_board_num = ? order by turn";

		List<CommentsDTO> list = new Vector<CommentsDTO>();
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, anno_board_num); // 이 부분 수정
			rs = psmt.executeQuery();
			while (rs.next()) {
				CommentsDTO comments = new CommentsDTO();
				comments.setanno_board_num(rs.getInt(1));
				comments.setTurn(rs.getInt(2));
				comments.setcontent(rs.getString(3));
				comments.setpass(rs.getInt(4));
				list.add(comments);

				System.out.println(rs.getInt(1));
				System.out.println(rs.getInt(2));
				System.out.println(rs.getString(3));
			}
		} catch (Exception e) {
			System.out.println("게시물 댓글 조회 중 예외 발생");
			e.printStackTrace();
		}
		return list;
	}

	// 댓글 db저장
	public int commentWrite(int anno_board_num, String commentscontent, int pass) {
		int result = 0;
		CommentsDTO dto = new CommentsDTO();
		try {
			System.out.println("CommentsWrite");
			String query = "INSERT INTO Comments(anno_board_num,Turn,content,pass )VALUES(?,Turn.NEXTVAL,?,?)";
			psmt = con.prepareStatement(query);
			psmt.setInt(1, anno_board_num);
			psmt.setString(2, commentscontent);
			psmt.setInt(3, pass);// 이 부분 수정
			result = psmt.executeUpdate();
			
			System.out.println(anno_board_num);
			System.out.println(commentscontent);
			System.out.println(pass);
			con.setAutoCommit(false); 
		} catch (Exception e) {
			System.out.println("댓글 입력중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	
	  public List<CommentsDTO> getCommentsList(int anno_board_num) {
	        List<CommentsDTO> commentsList = new ArrayList<>();
	        try {
	        	System.out.println("리스트 가져오기");
	            String query = "SELECT * FROM Comments WHERE anno_board_num = ? ORDER BY Turn";
	            pstmt = con.prepareStatement(query);
	            pstmt.setInt(1, anno_board_num);
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	                CommentsDTO comment = new CommentsDTO();
	                comment.setanno_board_num(rs.getInt("anno_board_num"));
	                comment.setTurn(rs.getInt("Turn"));
	                comment.setcontent(rs.getString("content"));
	                commentsList.add(comment);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            close();
	        }
	        return commentsList;
	    }
	  
	  
//댓글삭제
		public String EliminationsComments(int Turn) {
			
			try {
				System.out.println("댓글 삭제 DAO");
				String query = "DELETE FROM Comments WHERE Turn =?";
				psmt = con.prepareStatement(query);
				psmt.setInt(1, Turn);
				psmt.executeUpdate();
				
			} catch(Exception e) {
				System.out.println("게시물 삭제 중 예외 발생");
				e.printStackTrace();
			}
			return null;
		}
		
		//댓글 패스워드
	  public int Commentpass(int Turn) {
			int resurt=0;
		  try {
				System.out.println("댓글 삭제 전 패스워드 조회 DAO");
				String query = "SELECT * FROM Comments WHERE Turn =?";
				psmt = con.prepareStatement(query);
				psmt.setInt(1, Turn);
				psmt.executeUpdate();
				
			} catch(Exception e) {
				System.out.println("댓글 삭제 중 예외 발생");
				e.printStackTrace();
			}
			return resurt;
	  }
		
}
