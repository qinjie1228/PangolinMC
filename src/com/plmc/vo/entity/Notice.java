package com.plmc.vo.entity;

import java.util.Date;

public class Notice extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String noticeNo;
	private String userNo;
	private String noticeTitle;
	private String noticeContent;
	private Date noticePubTime;
	private int noticeState;
	public Notice() {
		super();
	}
	public Notice(String userNo, String noticeTitle, String noticeContent, Date noticePubTime, int noticeState) {
		super();
		this.userNo = userNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticePubTime = noticePubTime;
		this.noticeState = noticeState;
	}
	
	public Notice(String noticeNo, String userNo, String noticeTitle, String noticeContent, Date noticePubTime, int noticeState) {
		super();
		this.noticeNo = noticeNo;
		this.userNo = userNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticePubTime = noticePubTime;
		this.noticeState = noticeState;
	}
	
	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", userNo=" + userNo + ", noticeTitle=" + noticeTitle
				+ ", noticeContent=" + noticeContent + ", noticePubTime=" + noticePubTime + ", noticeState="
				+ noticeState + "]";
	}
	public String getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(String noticeNo) {
		this.noticeNo = noticeNo;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public Date getNoticePubTime() {
		return noticePubTime;
	}
	public void setNoticePubTime(Date noticePubTime) {
		this.noticePubTime = noticePubTime;
	}
	public int getNoticeState() {
		return noticeState;
	}
	public void setNoticeState(int noticeState) {
		this.noticeState = noticeState;
	}
	
}
