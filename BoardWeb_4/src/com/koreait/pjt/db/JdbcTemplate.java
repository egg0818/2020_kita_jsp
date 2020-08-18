  
package com.koreait.pjt.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

public class JdbcTemplate {	
	//select용
	public static int executeQuery(String sql, JdbcSelectInterface jdbc) {
		int result = 0;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;		
		try {
			con = Dbcon.getCon();
			ps = con.prepareStatement(sql);	
			// RS에 SELECT문 결과값이 담긴다
			rs = jdbc.prepared(ps);
			result = jdbc.excuteQuery(rs);
		} catch (Exception e) {		
			e.printStackTrace();
		} finally {
			Dbcon.close(con, ps, rs);
		}
		return result;
	}
	
	//insert, update, delete에 쓸 친구
	public static int executeUpdate(String sql, JdbcUpdateInterface jdbc) {
		int result = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = Dbcon.getCon();
			ps = con.prepareStatement(sql);			
			result = jdbc.update(ps);
		} catch (Exception e) {		
			e.printStackTrace();
		} finally {
			Dbcon.close(con, ps);
		}
		
		return result;
	}
}