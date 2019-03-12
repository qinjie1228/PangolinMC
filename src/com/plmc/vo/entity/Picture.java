package com.plmc.vo.entity;

import java.util.Date;

public class Picture extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String picNo;
	private String userNo;
	private String picDes;
	private String picPath;
	private Date picPubTime;
	private int picState;
	public Picture() {
		super();
	}
	public Picture(String userNo, String picDes, String picPath, Date picPubTime, int picState) {
		super();
		this.userNo = userNo;
		this.picDes = picDes;
		this.picPath = picPath;
		this.picPubTime = picPubTime;
		this.picState = picState;
	}
	
	public Picture(String picNo, String userNo, String picDes, String picPath, Date picPubTime, int picState) {
		super();
		this.picNo = picNo;
		this.userNo = userNo;
		this.picDes = picDes;
		this.picPath = picPath;
		this.picPubTime = picPubTime;
		this.picState = picState;
	}
	
	@Override
	public String toString() {
		return "Picture [picNo=" + picNo + ", userNo=" + userNo + ", picDes=" + picDes + ", picPath=" + picPath
				+ ", picPubTime=" + picPubTime + ", picState=" + picState + "]";
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
	public Date getPicPubTime() {
		return picPubTime;
	}
	public void setPicPubTime(Date picPubTime) {
		this.picPubTime = picPubTime;
	}
	public int getPicState() {
		return picState;
	}
	public void setPicState(int picState) {
		this.picState = picState;
	}
	
}
