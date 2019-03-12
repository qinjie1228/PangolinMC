package com.plmc.dto;

public class PictureDto {
	private String picNo;
	private String userNo;
	private String userName;
	private String picDes;
	private String picPath;
	private String picPubTime;
	private String picState;
	public PictureDto() {
		super();
	}
	public PictureDto(String picNo, String userNo, String userName, String picDes, String picPath, String picPubTime,
			String picState) {
		super();
		this.picNo = picNo;
		this.userNo = userNo;
		this.userName = userName;
		this.picDes = picDes;
		this.picPath = picPath;
		this.picPubTime = picPubTime;
		this.picState = picState;
	}
	@Override
	public String toString() {
		return "PictureDto [picNo=" + picNo + ", userNo=" + userNo + ", userName=" + userName + ", picDes=" + picDes
				+ ", picPath=" + picPath + ", picPubTime=" + picPubTime + ", picState=" + picState + "]";
	}
	public String getPicNo() {
		return picNo;
	}
	public void setPicNo(String picNo) {
		this.picNo = picNo;
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
	public String getPicDes() {
		return picDes;
	}
	public void setPicDes(String picDes) {
		this.picDes = picDes;
	}
	public String getPicPath() {
		return picPath;
	}
	public void setPicPath(String picPath) {
		this.picPath = picPath;
	}
	public String getPicPubTime() {
		return picPubTime;
	}
	public void setPicPubTime(String picPubTime) {
		this.picPubTime = picPubTime;
	}
	public String getPicState() {
		return picState;
	}
	public void setPicState(String picState) {
		this.picState = picState;
	}
	
}
