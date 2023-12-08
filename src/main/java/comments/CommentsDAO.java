package comments;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DBcontrol.DBConnPool;

public class CommentsDAO extends DBConnPool {
    private ResultSet rs;
    private PreparedStatement pstmt;

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
		String SQL="select Turn FROM Comments ORDER BY Turn DESC";
		try {
			PreparedStatement pstmt=con.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				System.out.println(rs.getInt(1)); // select문에서 첫번째 값
				return rs.getInt(1)+1;  // 현재 인덱스(현재 게시글 개수) +1 반환
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
             sql.append("select * from anno_boardwhere anno_board_num = ?");
             
             pstmt = con.prepareStatement(sql.toString());
             pstmt.setInt(1, anno_board_num);
             
             rs = pstmt.executeQuery();
             if(rs.next())
             {
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
     
    	
    	
    
    
}
