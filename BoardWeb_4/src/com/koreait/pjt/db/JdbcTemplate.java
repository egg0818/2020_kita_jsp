  
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
			jdbc.prepared(ps);
			
			rs = ps.executeQuery();
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
			
			jdbc.update(ps);
			
			result = ps.executeUpdate();
		} catch (Exception e) {		
			e.printStackTrace();
		} finally {
			Dbcon.close(con, ps);
		}
		
		return result;
	}
}