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
	
	public static List<BoardVO> selBoardlist(BoardVO vo) {
		// 레퍼런스 변수에 final 붙이면 주솟값 변경x
		final List<BoardVO> list = new ArrayList();
		
//		String sql = " SELECT * FROM"
//				+ " ( "
//				+ " SELECT ROWNUM as RNUM, A.* FROM"
//				+ " ( "
//				+ " SELECT A.i_board, A.title, A.hits, A.i_user, B.nm, A.r_dt, B.profile_img "
//				+ " , (select count(*) from t_board4_like where i_board = A.i_board) as likecnt "
//				+ ", (select count(*) from t_board4_cmt where i_board = A.i_board) as cmtcnt"
//				+ " FROM t_board4 A "
//				+ " INNER JOIN t_user B "
//				+ " ON A.i_user = B.i_user "
//				+ " WHERE A.title like ? "
//				+ " ORDER BY i_board DESC "
//				+ " ) A"
//				+ " WHERE ROWNUM <= ? "
//				+ " ) A "
//				+ " WHERE A.RNUM > ? ";
		
		String sql =  "select A.* from (select  rownum as rnum, A.* from (select A.i_board, A.title, A.hits, B.i_user, B.nm, A.r_dt, B.profile_img, " 
		           + " nvl(c.cnt, 0) as c_like, nvl(d.cmt_cnt,0) as c_cmt, decode(e.i_board, null,0,1) as yn_like "
		           + " from t_board4 A "
		              + " left join t_user B "
		          + " on A.i_user = B.i_user "
		             + " left join " 
		             + " (select i_board,count(i_board) as cnt from t_board4_like group by i_board ) C "
		             + " on a.i_board=c.i_board "
		             + " left join "
		             + " (select i_board, count(i_board) as cmt_cnt from t_board4_cmt group by i_board) D "
		             + " on a.i_board=d.i_board "
		             + " left join "
		             + " (select i_board from t_board4_like where i_user = ? ) E "
		             + " on a.i_board = e.i_board "
		             + " where ";
					switch(vo.getSearchType()) {
					case "a":
						sql += " A.title like ? ";
						break;
					case "b":
						sql += " A.ctnt like ? ";
						break;
					case "c":
						sql += " (A.ctnt like ? or A.title like ?) ";
						break;
					}
		         sql += " order by i_board desc"
		         		+ " 	) A where rownum <= ? "
		         		+ " ) A where a.rnum > ?";
		
		int result = JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				int seq = 1;
				ps.setInt(seq, vo.getI_user()); //로그인한 사람의 i_user
				ps.setNString(++seq, vo.getSearchText());
				
				if(vo.getSearchType().equals("c")) {
					ps.setNString(++seq, vo.getSearchText());
				}
				
				ps.setInt(++seq, vo.geteIdx());
				ps.setInt(++seq, vo.getSldx());
			}
				
			@Override
			public int excuteQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					int i_board = rs.getInt("i_board");
					String title = rs.getNString("title");
					int hits = rs.getInt("hits");
					int i_user = rs.getInt("i_user");
					String nm = rs.getNString("nm");
					String r_dt = rs.getNString("r_dt");
//					int likecnt = rs.getInt("likecnt");
					int c_like = rs.getInt("c_like");
//					int cmtcnt = rs.getInt("cmtcnt");	
					int c_cmt = rs.getInt("c_cmt");	
					String profile_img = rs.getNString("profile_img");
					int yn_like = rs.getInt("yn_like");
					
					BoardVO vo = new BoardVO();
					vo.setI_board(i_board);
					vo.setTitle(title);
					vo.setHits(hits);
					vo.setI_user(i_user);
					vo.setR_dt(r_dt);
					vo.setNm(nm);
//					vo.setLikecnt(likecnt);
					vo.setLikecnt(c_like);
//					vo.setCmtcnt(cmtcnt);
					vo.setCmtcnt(c_cmt);
					vo.setProfile_img(profile_img);
					vo.setYn_like(yn_like);
					
					list.add(vo);
				}
				return 1;
			}
		});
		return list;
	}
	
	public static BoardVO selBoard(BoardVO param) {
		String sql = " select A.*, C.nm, DECODE(B.i_user, null, 0, 1) as yn_like "
				+ " , (select count(*) from t_board4_like where i_board = ?) as likecnt "
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
				ps.setInt(1, param.getI_board()); 
				ps.setInt(2, param.getI_user()); //로그인 한 사람 i_user
				ps.setInt(3, param.getI_board());
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
					int i_user = rs.getInt("i_user"); //작성자 i_user
					int like = rs.getInt("yn_like");
					int likecnt = rs.getInt("likecnt");
					
					param.setI_board(i_board);
					param.setTitle(title);
					param.setCtnt(ctnt);
					param.setNm(nm);
					param.setHits(hits);
					param.setR_dt(r_dt);
					param.setI_user(i_user);
					param.setLike(like);
					param.setLikecnt(likecnt);
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
	
	public static void insLike(BoardVO param) {
		String sql = " insert into t_board4_like "
				+ " (i_user, i_board) "
				+ " VALUES (?, ?) "; 
		
		JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_user());
				ps.setInt(2, param.getI_board());
			}});
		
	}
	
	public static void delLike(BoardVO param) {
		String sql = " delete from t_board4_like "
				+ " where i_board = ? "
				+ " AND i_user = ? ";
		
		JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_board());
				ps.setInt(2, param.getI_user());
			}});
		
	}
	
	public static List<BoardVO> selLikecntlist() {
		final List<BoardVO> list = new ArrayList();
		
		String sql = "select count(*) as likecnt "
				+ " from t_board4_like "
				+ " group by i_board";
		
		int result = JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException {}
				
			@Override
			public int excuteQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					int likecnt = rs.getInt("likecnt");
							
					BoardVO vo = new BoardVO();
					vo.setLikecnt(likecnt);
					
					list.add(vo);
				}
				return 1;
			}
		});
		return list;
	}
	
	//페이징 숫자 가져오기
	public static int selPagingCnt(final BoardVO param) {
		String sql = " SELECT CEIL(COUNT(i_board) / ?) FROM t_board4 WHERE ";
		
		switch(param.getSearchType()) {
		case "a":					
			sql += " title like ? ";
			break;
		case "b":
			sql += " ctnt like ? ";
			break;
		case "c":
			sql += " (ctnt like ? or title like ?) ";
			break;
		}	
		
		return JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getRecord_cnt());
				ps.setNString(2, param.getSearchText());
				ps.setNString(2, param.getSearchText());				
				if(param.getSearchType().equals("c")) {
					ps.setNString(3, param.getSearchText());	
				}
			}

			@Override
			public int excuteQuery(ResultSet rs) throws SQLException {
				if(rs.next()) {
					// 스칼라 (1열1행) 값일 땐 이렇게 가져올 수 있다.
					// 1은 인덱스 값
					return rs.getInt(1);
				}
				return 0;
			}
		
		});
	}
	
	
		
}
