package com.plmc.dto;

public class ActDto{

	private String actNo;
	private String userNo;
	private String userName;
	private String actTitle;
	private String actContent;
	private String actPic;
	private String actNum;
	private String actPubTime;
	private String actState;
	public ActDto() {
		super();
	}
	public ActDto(String actNo, String userNo, String userName, String actTitle, String actContent, String actPic,
			String actNum, String actPubTime, String actState) {
		super();
		this.actNo = actNo;
		this.userNo = userNo;
		this.userName = userName;
		this.actTitle = actTitle;
		this.actContent = actContent;
		this.actPic = actPic;
		this.actNum = actNum;
		this.actPubTime = actPubTime;
		this.actState = actState;
	}
	@Override
	public String toString() {
		return "ActDto [actNo=" + actNo + ", userNo=" + userNo + ", userName=" + userName + ", actTitle=" + actTitle
				+ ", actContent=" + actContent + ", actPic=" + actPic + ", actNum=" + actNum + ", actPubTime="
				+ actPubTime + ", actState=" + actState + "]";
	}
	public String getActNo() {
		return actNo;
	}
	public void setActNo(String actNo) {
		this.actNo = actNo;
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
	public String getActTitle() {
		return actTitle;
	}
	public void setActTitle(String actTitle) {
		this.actTitle = actTitle;
	}
	public String getActContent() {
		return actContent;
	}
	public void setActContent(String actContent) {
		this.actContent = actContent;
	}
	public String getActPic() {
		return actPic;
	}
	public void setActPic(String actPic) {
		this.actPic = actPic;
	}
	public String getActNum() {
		return actNum;
	}
	public void setActNum(String actNum) {
		this.actNum = actNum;
	}
	public String getActPubTime() {
		return actPubTime;
	}
	public void setActPubTime(String actPubTime) {
		this.actPubTime = actPubTime;
	}
	public String getActState() {
		return actState;
	}
	public void setActState(String actState) {
		this.actState = actState;
	}
	
}
