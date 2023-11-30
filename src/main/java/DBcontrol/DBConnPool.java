package DBcontrol;

import java.sql.*;
import javax.sql.*;

import javax.naming.*;

public class DBConnPool {
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;

	public DBConnPool() {
		try {
			// 커넥션 풀 얻기
			Context initCtx = new InitialContext();
			Context ctx = (Context) initCtx.lookup("java:comp/env");
			DataSource source = (DataSource) ctx.lookup("dbcp_myoracle");

			// 커넥션 풀을 통해 연결 얻기
			con = source.getConnection();

			System.out.println("DB 커넥션 풀 성공");
		} catch (Exception e) {
			System.out.println("DB 커넥션 풀 실패");
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (psmt != null)
				psmt.close();
			if (con != null)
				con.close();

			System.out.println("DB 커넥션 풀 자원 반납");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
