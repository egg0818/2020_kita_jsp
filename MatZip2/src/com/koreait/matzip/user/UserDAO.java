package com.koreait.matzip.user;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.koreait.matzip.vo.UserVO;
import com.koreait.matzip.db.JdbcTemplate;
import com.koreait.matzip.db.JdbcUpdateInterface;

public class UserDAO {
	
	public int join(UserVO param) {
		int result = 0;
		
		String sql = " INSERT INTO t_user "
				+ " (user_id, user_pw, salt, nm) "
				+ " VALUES "
				+ " (?, ?, ?, ?) ";
		
		// 인터페이스를 객체화 한게 아니고 implements 한거다
		// 익명클래스 활용 - 따로 클래스를 만들지 않아도 된다
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			@Override
			public void update(PreparedStatement ps) throws SQLException {				
				ps.setNString(1, param.getUser_id());
				ps.setNString(2, param.getUser_pw());
				ps.setNString(3, param.getSalt());
				ps.setNString(4, param.getNm());
			}
		});
	}
	
		
		
		
	}

