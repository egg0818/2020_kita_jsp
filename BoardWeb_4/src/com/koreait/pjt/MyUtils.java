package com.koreait.pjt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MyUtils {
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
