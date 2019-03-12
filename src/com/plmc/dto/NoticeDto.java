package com.plmc.dto;

public class NoticeDto{
	private String noticeNo;
	private String userNo;
	private String userName;
	private String noticeTitle;
	private String noticeContent;
	private String noticePubTime;
	private String noticeState;
	public NoticeDto() {
		super();
	}
	public NoticeDto(String noticeNo, String userNo, String userName, String noticeTitle, String noticeContent,
			String noticePubTime, String noticeState) {
		super();
		this.noticeNo = noticeNo;
		this.userNo = userNo;
		this.userName = userName;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticePubTime = noticePubTime;
		this.noticeState = noticeState;
	}
	@Override
	public String toString() {
		return "NoticeDto [noticeNo=" + noticeNo + ", userNo=" + userNo + ", userName=" + userName + ", noticeTitle="
				+ noticeTitle + ", noticeContent=" + noticeContent + ", noticePubTime=" + noticePubTime
				+ ", noticeState=" + noticeState + "]";
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
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
	public String getNoticePubTime() {
		return noticePubTime;
	}
	public void setNoticePubTime(String noticePubTime) {
		this.noticePubTime = noticePubTime;
	}
	public String getNoticeState() {
		return noticeState;
	}
	public void setNoticeState(String noticeState) {
		this.noticeState = noticeState;
	}
	
}
