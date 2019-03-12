package com.plmc.vo.util;

import com.plmc.vo.entity.BaseEntity;

public class UserLogin extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String loginNo;
	private String userNo;
	private String ipAddress;
	private int loginState;
	public UserLogin() {
		super();
	}
	
	public UserLogin(String userNo, String ipAddress, int loginState) {
		super();
		this.userNo = userNo;
		this.ipAddress = ipAddress;
		this.loginState = loginState;
	}

	public UserLogin(String loginNo, String userNo, String ipAddress, int loginState) {
		super();
		this.loginNo = loginNo;
		this.userNo = userNo;
		this.ipAddress = ipAddress;
		this.loginState = loginState;
	}
	@Override
	public String toString() {
		return "UserLogin [loginNo=" + loginNo + ", userNo=" + userNo + ", ipAddress=" + ipAddress + ", loginState="
				+ loginState + "]";
	}
	public String getLoginNo() {
		return loginNo;
	}
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public int getLoginState() {
		return loginState;
	}
	public void setLoginState(int loginState) {
		this.loginState = loginState;
	}
	
}
