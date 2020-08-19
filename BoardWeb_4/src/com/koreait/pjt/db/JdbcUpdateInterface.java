package com.koreait.pjt.db;

import java.sql.PreparedStatement;
import java.sql.SQLException;

// 인터페이스만 부모역할만 하고 자식만 가르킴 // 객체 생성x
// 인터페이스는 public abstract 생략해도 자동으로 넣어준다
// 강제성이 있음 ! 부모 ! 단호하 다! -> implement 써야함
// 추상클래스 : 추상메소드를 가지고 있고 객체생성 x // 클래스앞에 abstract 붙임

public interface JdbcUpdateInterface {
	void update(PreparedStatement ps) throws SQLException;
}