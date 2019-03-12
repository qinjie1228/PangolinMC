package com.plmc.dto;

public class PostDto {
	private String postNo;
	private String userNo;
	private String userName;
	private String postCategory;
	private String postTitle;
	private String postContent;
	private String postPic;
	private String postPubTime;
	private String postCommentNum;
	private String postScanNum;
	private String postState;
	public PostDto() {
		super();
	}
	public PostDto(String postNo, String userNo, String userName, String postCategory, String postTitle,
			String postContent, String postPic, String postPubTime, String postCommentNum, String postScanNum,
			String postState) {
		super();
		this.postNo = postNo;
		this.userNo = userNo;
		this.userName = userName;
		this.postCategory = postCategory;
		this.postTitle = postTitle;
		this.postContent = postContent;
		this.postPic = postPic;
		this.postPubTime = postPubTime;
		this.postCommentNum = postCommentNum;
		this.postScanNum = postScanNum;
		this.postState = postState;
	}
	@Override
	public String toString() {
		return "PostDto [postNo=" + postNo + ", userNo=" + userNo + ", userName=" + userName + ", postCategory="
				+ postCategory + ", postTitle=" + postTitle + ", postContent=" + postContent + ", postPic=" + postPic
				+ ", postPubTime=" + postPubTime + ", postCommentNum=" + postCommentNum + ", postScanNum=" + postScanNum
				+ ", postState=" + postState + "]";
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
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPostCategory() {
		return postCategory;
	}
	public void setPostCategory(String postCategory) {
		this.postCategory = postCategory;
	}
	public String getPostTitle() {
		return postTitle;
	}
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}
	public String getPostContent() {
		return postContent;
	}
	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}
	public String getPostPic() {
		return postPic;
	}
	public void setPostPic(String postPic) {
		this.postPic = postPic;
	}
	public String getPostPubTime() {
		return postPubTime;
	}
	public void setPostPubTime(String postPubTime) {
		this.postPubTime = postPubTime;
	}
	public String getPostCommentNum() {
		return postCommentNum;
	}
	public void setPostCommentNum(String postCommentNum) {
		this.postCommentNum = postCommentNum;
	}
	public String getPostScanNum() {
		return postScanNum;
	}
	public void setPostScanNum(String postScanNum) {
		this.postScanNum = postScanNum;
	}
	public String getPostState() {
		return postState;
	}
	public void setPostState(String postState) {
		this.postState = postState;
	}
	
}
