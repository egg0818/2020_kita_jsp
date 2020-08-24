package com.koreait.pjt.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.koreait.pjt.db.Dbcon;
import com.koreait.pjt.vo.BoardVO;

public class BoardDAO {
	
	public static int insBoard(BoardVO param) {
		String sql = " insert into t_board4 (i_board, title, ctnt, i_user) "
				+ " SELECT nvl(max(i_board), 0) + 1, ?, ?, ? "
				+ " FROM t_board4 ";
		
		// 익명클래스, 인터페이스를 객체화 한 것 
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			@Override
			public void update(PreparedStatement ps) throws SQLException {				
				ps.setNString(1, param.getTitle());
				ps.setNString(2, param.getCtnt());
				//수정해야함
				ps.setInt(3, param.getI_user());
			}
		});
	}
	
	public static List<BoardVO> selBoardlist() {
		// 레퍼런스 변수에 final 붙이면 주솟값 변경x
		final List<BoardVO> list = new ArrayList();
		
		String sql = " SELECT A.i_board, A.title, A.hits, A.i_user, B.nm, A.r_dt "
				+ " FROM t_board4 A "
				+ " INNER JOIN t_user B "
				+ " ON A.i_user = B.i_user "
				+ " ORDER BY i_board DESC ";
		
		int result = JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException {}
				
			@Override
			public int excuteQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					int i_board = rs.getInt("i_board");
					String title = rs.getNString("title");
					int hits = rs.getInt("hits");
					int i_user = rs.getInt("i_user");
					String nm = rs.getNString("nm");
					String r_dt = rs.getNString("r_dt");
							
					BoardVO vo = new BoardVO();
					vo.setI_board(i_board);
					vo.setTitle(title);
					vo.setHits(hits);
					vo.setI_user(i_user);
					vo.setR_dt(r_dt);
					vo.setNm(nm);
					
					list.add(vo);
				}
				return 1;
			}
		});
		return list;
	}
	
	public static BoardVO selBoard(BoardVO param) {
		String sql = " select A.*, C.nm, DECODE(B.i_user, null, 0, 1) as ynLike"
				+ " from t_board4 A "
				+ " LEFT JOIN t_board4_like B "
				+ " ON A.i_board = B.i_board "
				+ " AND B.i_user = ? "
				+ " INNER JOIN t_user C "
				+ " ON A.i_user = C.i_user "
				+ " where A.i_board = ? ";
		
		int resultInt = JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_user());
				ps.setInt(2, param.getI_board());
			}
			@Override
			public int excuteQuery(ResultSet rs) throws SQLException {
				if(rs.next()) {
					int i_board = rs.getInt("i_board");
					String title = rs.getNString("title");
					String ctnt = rs.getNString("ctnt");
					String nm = rs.getNString("nm");
					String r_dt = rs.getNString("r_dt");
					int hits = rs.getInt("hits");
					int i_user = rs.getInt("i_user");
					int like = rs.getInt("ynLike");
					
					param.setI_board(i_board);
					param.setTitle(title);
					param.setCtnt(ctnt);
					param.setNm(nm);
					param.setHits(hits);
					param.setR_dt(r_dt);
					param.setI_user(i_user);
					param.setLike(like);
					} 
				return 1;
				} 		
		});
		return param;
	}
	
	public static int uptBoard(BoardVO param) {
		String sql = " UPDATE t_board4 " +
				 " SET title = ? " +
				 " , ctnt = ? " +
				 " WHERE i_board = ? "
				 + " AND i_user = ? ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setNString(1, param.getTitle());
				ps.setNString(2, param.getCtnt());
				ps.setInt(3, param.getI_board());
				ps.setInt(4, param.getI_user());
			}});
	}
	
	public static int delBoard(final BoardVO param) {
		String sql = " DELETE FROM t_board4 WHERE i_board = ? AND i_user = ?";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_board());
				ps.setInt(2, param.getI_user());
			}
		});
	}
	
	public static void addHits(final BoardVO param) {
		String sql = " UPDATE t_board4 "
				+ "SET hits = hits+1 "
				+ "WHERE i_board = ? ";
		
		JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_board());
			}});
		
	}
	
		
}
