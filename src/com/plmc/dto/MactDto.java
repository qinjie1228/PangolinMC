package com.plmc.dto;


public class MactDto {
	private String mactNo;
	private String userNo;
	private String userName;
	private String actNo;
	private String actTitle;
	private String actResTime;
	private String actResState;
	public MactDto() {
		super();
	}
	public MactDto(String mactNo, String userNo, String userName, String actNo, String actTitle, String actResTime, String actResState) {
		super();
		this.mactNo = mactNo;
		this.userNo = userNo;
		this.userName = userName;
		this.actNo = actNo;
		this.actTitle = actTitle;
		this.actResTime = actResTime;
		this.actResState = actResState;
	}
	@Override
	public String toString() {
		return "MactDto [mactNo=" + mactNo + ", userNo=" + userNo + ", userName=" + userName + ", actNo=" + actNo + ", actTitle=" + actTitle
				+ ", actResTime=" + actResTime + ", actResState=" + actResState + "]";
	}
	
	public String getMactNo() {
		return mactNo;
	}
	public void setMactNo(String mactNo) {
		this.mactNo = mactNo;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getActNo() {
		return actNo;
	}
	public void setActNo(String actNo) {
		this.actNo = actNo;
	}
	public String getActTitle() {
		return actTitle;
	}
	public void setActTitle(String actTitle) {
		this.actTitle = actTitle;
	}
	public String getActResTime() {
		return actResTime;
	}
	public void setActResTime(String actResTime) {
		this.actResTime = actResTime;
	}
	public String getActResState() {
		return actResState;
	}
	public void setActResState(String actResState) {
		this.actResState = actResState;
	}
	
}
