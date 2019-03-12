package com.plmc.vo.entity;


import java.util.Date;

public class Act extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String actNo;
	private String userNo;
	private String actTitle;
	private String actContent;
	private String actPic;
	private int actNum;
	private Date actPubTime;
	private int actState;
	public Act() {
		super();
	}
	public Act(String userNo, String actTitle, String actContent, String actPic, int actNum, Date actPubTime,
			int actState) {
		super();
		this.userNo = userNo;
		this.actTitle = actTitle;
		this.actContent = actContent;
		this.actPic = actPic;
		this.actNum = actNum;
		this.actPubTime = actPubTime;
		this.actState = actState;
	}
	
	public Act(String actNo, String userNo, String actTitle, String actContent, String actPic, int actNum, Date actPubTime,
			int actState) {
		super();
		this.actNo = actNo;
		this.userNo = userNo;
		this.actTitle = actTitle;
		this.actContent = actContent;
		this.actPic = actPic;
		this.actNum = actNum;
		this.actPubTime = actPubTime;
		this.actState = actState;
	}
	
	@Override
	public String toString() {
		return "Act [actNo=" + actNo + ", userNo=" + userNo + ", actTitle=" + actTitle + ", actContent=" + actContent
				+ ", actPic=" + actPic + ", actNum=" + actNum + ", actPubTime=" + actPubTime + ", actState=" + actState
				+ "]";
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
	public int getActNum() {
		return actNum;
	}
	public void setActNum(int actNum) {
		this.actNum = actNum;
	}
	public Date getActPubTime() {
		return actPubTime;
	}
	public void setActPubTime(Date actPubTime) {
		this.actPubTime = actPubTime;
	}
	public int getActState() {
		return actState;
	}
	public void setActState(int actState) {
		this.actState = actState;
	}
	
}
