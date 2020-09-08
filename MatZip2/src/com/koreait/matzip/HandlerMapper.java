package com.koreait.matzip;

import javax.servlet.http.HttpServletRequest;

import com.koreait.matzip.user.UserController;

public class HandlerMapper {
	private UserController userCon;
	
	
	public HandlerMapper() { //생성자
		userCon = new UserController();
	}
	
	public String nav(HttpServletRequest request) {
		String[] uriArr = request.getRequestURI().split("/"); //request.getRequestURI() 결과값 String 
		// 공백/user/login
		if(uriArr.length < 3) {
			return "405"; //Error
		}
		
		switch(uriArr[1]) {
		case ViewRef.URI_USER: // "user"
			switch(uriArr[2]) {
			case "login":
				return userCon.login(request);	
			case "loginProc":
				return userCon.loginProc(request);
			case "join":
				return userCon.join(request);
			case "joinProc":
				return userCon.joinProc(request);
			}
		}
		
		 
		return "404"; //NotFound
		
	}

}
