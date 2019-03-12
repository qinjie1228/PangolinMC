package com.plmc.vo.entity;

import java.util.Date;

public class Comment extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String commentNo;
	private String postNo;
	private String userNo;
	private String commentContent;
	private Date commentPubTime;
	private int commentState;
	public Comment() {
		super();
	}
	public Comment(String postNo, String userNo, String commentContent, Date commentPubTime, int commentState) {
		super();
		this.postNo = postNo;
		this.userNo = userNo;
		this.commentContent = commentContent;
		this.commentPubTime = commentPubTime;
		this.commentState = commentState;
	}
	
	public Comment(String commentNo, String postNo, String userNo, String commentContent, Date commentPubTime, int commentState) {
		super();
		this.commentNo = commentNo;
		this.postNo = postNo;
		this.userNo = userNo;
		this.commentContent = commentContent;
		this.commentPubTime = commentPubTime;
		this.commentState = commentState;
	}
	
	@Override
	public String toString() {
		return "Comment [commentNo=" + commentNo + ", postNo=" + postNo + ", userNo=" + userNo + ", commentContent="
				+ commentContent + ", commentPubTime=" + commentPubTime + ", commentState=" + commentState + "]";
	}
	public String getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
	}
	public String getPostNo() {
		return postNo;
	}
	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public Date getCommentPubTime() {
		return commentPubTime;
	}
	public void setCommentPubTime(Date commentPubTime) {
		this.commentPubTime = commentPubTime;
	}
	public int getCommentState() {
		return commentState;
	}
	public void setCommentState(int commentState) {
		this.commentState = commentState;
	}
	
}
