package com.koreait.matzip.user;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.koreait.matzip.vo.UserVO;
import com.koreait.matzip.db.JdbcSelectInterface;
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
	
	public UserVO selUser(UserVO param) {
		UserVO result = new UserVO();
		
		String sql = " select i_user, user_id, user_pw, salt, nm, profile_img, r_dt "
				+ "	from t_user where ";
		
		//i_user 값을 안넣어줬으니 0 일것이다
		if(param.getI_user() > 0 ) {
			sql += " i_user = " + param.getI_user();
		} else if(param.getUser_id() != null && !"".contentEquals(param.getUser_id())) {
			sql += " user_id = '" + param.getUser_id() + "'";
		}
		
		JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException {}

			@Override
			public void excuteQuery(ResultSet rs) throws SQLException {
				if(rs.next()) {
					
					result.setI_user(rs.getInt("i_user"));
					System.out.println("아이디" + result.getI_user());
					result.setUser_id(rs.getString("user_id"));
					result.setUser_pw(rs.getString("user_pw"));
					result.setSalt(rs.getString("salt")); 
					result.setNm(rs.getString("nm"));
					result.setProfile_img(rs.getString("profile_img"));
					result.setR_dt(rs.getString("r_dt"));
				}
			}		
		});
		
		return result;
	}	
		
		
	}

