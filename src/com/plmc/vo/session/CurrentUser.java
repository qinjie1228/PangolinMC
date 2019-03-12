package com.plmc.vo.session;

import com.plmc.vo.entity.BaseEntity;

public class CurrentUser extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String currentNo;
	private String currentName;
	private String currentPwd;
	private int currentState;
	public CurrentUser() {
		super();
	}
	public CurrentUser(String currentNo, String currentName, String currentPwd, int currentState) {
		super();
		this.currentNo = currentNo;
		this.currentName = currentName;
		this.currentPwd = currentPwd;
		this.currentState = currentState;
	}
	
	@Override
	public String toString() {
		return "CurrentUser [currentNo=" + currentNo + ", currentName=" + currentName + ", currentPwd=" + currentPwd
				+ ", currentState=" + currentState + "]";
	}
	public String getCurrentName() {
		return currentName;
	}
	public void setCurrentName(String currentName) {
		this.currentName = currentName;
	}
	public String getCurrentPwd() {
		return currentPwd;
	}
	public void setCurrentPwd(String currentPwd) {
		this.currentPwd = currentPwd;
	}
	public int getCurrentState() {
		return currentState;
	}
	public void setCurrentState(int currentState) {
		this.currentState = currentState;
	}
	public String getCurrentNo() {
		return currentNo;
	}
	public void setCurrentNo(String currentNo) {
		this.currentNo = currentNo;
	}
	
	
}
