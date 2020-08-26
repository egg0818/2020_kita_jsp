package com.koreait.pjt.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.koreait.pjt.vo.BoardCmtVO;
import com.koreait.pjt.vo.BoardVO;

public class BoardCmtDAO {
	public static int insCmt(BoardCmtVO param) {
		String sql = " insert into T_BOARD4_CMT "
				+ " (i_cmt, i_board, i_user, cmt) "
				+ " values (seq_board4_cmt.nextval, ?, ?, ?) ";
		
		// 익명클래스, 인터페이스를 객체화 한 것 
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			@Override
			public void update(PreparedStatement ps) throws SQLException {				
				ps.setInt(1, param.getI_board());
				ps.setInt(2, param.getI_user());
				ps.setNString(3, param.getCmt());
			}
		});
	}
	
	public static int updCmt() {
		return 0;
	}
	
	public static int delCmt() {
		return 0;
	}
	
	public static List<BoardCmtVO> selBoardCmtlist(BoardVO param) {
		// 레퍼런스 변수에 final 붙이면 주솟값 변경x
		final List<BoardCmtVO> list = new ArrayList();
		
		String sql = "select A.i_cmt, A.i_board, A.i_user, B.nm, A.cmt, A.r_dt, A.m_dt"
				+ " from T_BOARD4_CMT A"
				+ " inner join t_user B"
				+ " on A.i_user = B.i_user "
				+ " where i_board = ? "
				+ " ORDER BY i_cmt ASC ";
		
		
		int result = JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_board());
			}
				
			@Override
			public int excuteQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					int i_cmt = rs.getInt("i_cmt");
					int i_board = rs.getInt("i_board");
					int i_user = rs.getInt("i_user");
					String nm = rs.getNString("nm");
					String cmt = rs.getNString("cmt");
					String r_dt = rs.getNString("r_dt");
					String m_dt = rs.getNString("m_dt");
							
					BoardCmtVO vo = new BoardCmtVO();
					vo.setI_board(i_board);
					vo.setCmt(cmt);
					vo.setI_cmt(i_cmt);
					vo.setI_user(i_user);
					vo.setM_dt(m_dt);
					vo.setR_dt(r_dt);
					vo.setNm(nm);
					
					list.add(vo);
				}
				return 1;
			}
		});
		return list;
	}
	
	public static int delCmt(final BoardCmtVO param) {
		String sql = " DELETE FROM T_BOARD4_CMT WHERE i_cmt = ?";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_cmt());
			}
		});
	}
}
