package com.plmc.dto;

public class CommentDto {
	private String commentNo;
	private String postNo;
	private String postTitle;
	private String userNo;
	private String userName;
	private String commentContent;
	private String commentPubTime;
	private String commentState;
	public CommentDto() {
		super();
	}
	public CommentDto(String commentNo, String postNo, String postTitle, String userNo, String userName,
			String commentContent, String commentPubTime, String commentState) {
		super();
		this.commentNo = commentNo;
		this.postNo = postNo;
		this.postTitle = postTitle;
		this.userNo = userNo;
		this.userName = userName;
		this.commentContent = commentContent;
		this.commentPubTime = commentPubTime;
		this.commentState = commentState;
	}
	@Override
	public String toString() {
		return "CommentDto [commentNo=" + commentNo + ", postNo=" + postNo + ", postTitle=" + postTitle + ", userNo="
				+ userNo + ", userName=" + userName + ", commentContent=" + commentContent + ", commentPubTime="
				+ commentPubTime + ", commentState=" + commentState + "]";
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
	public String getPostTitle() {
		return postTitle;
	}
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
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
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public String getCommentPubTime() {
		return commentPubTime;
	}
	public void setCommentPubTime(String commentPubTime) {
		this.commentPubTime = commentPubTime;
	}
	public String getCommentState() {
		return commentState;
	}
	public void setCommentState(String commentState) {
		this.commentState = commentState;
	}
	
}
