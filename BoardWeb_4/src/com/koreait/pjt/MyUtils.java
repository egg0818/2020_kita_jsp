package com.koreait.pjt;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.db.Const;
import com.koreait.pjt.vo.UserVO;

public class MyUtils {
	
	public static int getIntParameter(HttpServletRequest request, String keyNm) {
		return parseStrToInt(request.getParameter(keyNm));
	}
	
	public static int parseStrToInt(String str) {
		return parseStrToInt(str, 0);
	}
	
	public static int parseStrToInt(String str, int defNo) {
		try {
			return Integer.parseInt(str);
		} catch(Exception e) {
			return defNo;
		}
	}
	
	public static UserVO getLoginUser(HttpServletRequest request) {
		HttpSession hs = request.getSession();
		return (UserVO)hs.getAttribute(Const.LOGIN_USER);
	}
	
	//return true : 로그인 안됨!, false : 로그인 된 상태
	public static boolean isLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession hs = request.getSession();
		if(hs.getAttribute(Const.LOGIN_USER) == null) {
			return true;
		}
		return false;
	}
	
	public static String encrypetString(String str) {
		  String sha = "";

	       try{
	          MessageDigest sh = MessageDigest.getInstance("SHA-256");
	          sh.update(str.getBytes());
	          byte byteData[] = sh.digest();
	          
	          // StringBuffer 문자열을 합칠때 많이 씀
	          // 일반 String보다 리소스가 적어서 사용
	          StringBuffer sb = new StringBuffer();
	          for(int i = 0 ; i < byteData.length ; i++){
	              sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
	          }

	          sha = sb.toString();

	      }catch(NoSuchAlgorithmException e){
	          //e.printStackTrace();
	          System.out.println("Encrypt Error - NoSuchAlgorithmException");
	          sha = null;
	      }

	      return sha;
	}
}
