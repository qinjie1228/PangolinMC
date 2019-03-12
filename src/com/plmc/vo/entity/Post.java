package com.plmc.vo.entity;

import java.util.Date;

public class Post extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String postNo;
	private String userNo;
	private String postCategory;
	private String postTitle;
	private String postContent;
	private String postPic;
	private Date postPubTime;
	private int postCommentNum;
	private int postScanNum;
	private int postState;
	public Post() {
		super();
	}
	public Post(String userNo, String postCategory, String postTitle, String postContent, String postPic,
			Date postPubTime, int postCommentNum, int postScanNum, int postState) {
		super();
		this.userNo = userNo;
		this.postCategory = postCategory;
		this.postTitle = postTitle;
		this.postContent = postContent;
		this.postPic = postPic;
		this.postPubTime = postPubTime;
		this.postCommentNum = postCommentNum;
		this.postScanNum = postScanNum;
		this.postState = postState;
	}
	public Post(String postNo, String userNo, String postCategory, String postTitle, String postContent, String postPic,
			Date postPubTime, int postCommentNum, int postScanNum, int postState) {
		super();
		this.postNo = postNo;
		this.userNo = userNo;
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
		return "Post [postNo=" + postNo + ", userNo=" + userNo + ", postCategory=" + postCategory + ", postTitle="
				+ postTitle + ", postContent=" + postContent + ", postPic=" + postPic + ", postPubTime=" + postPubTime
				+ ", postCommentNum=" + postCommentNum + ", postScanNum=" + postScanNum + ", postState=" + postState
				+ "]";
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
	public Date getPostPubTime() {
		return postPubTime;
	}
	public void setPostPubTime(Date postPubTime) {
		this.postPubTime = postPubTime;
	}
	public int getPostCommentNum() {
		return postCommentNum;
	}
	public void setPostCommentNum(int postCommentNum) {
		this.postCommentNum = postCommentNum;
	}
	public int getPostScanNum() {
		return postScanNum;
	}
	public void setPostScanNum(int postScanNum) {
		this.postScanNum = postScanNum;
	}
	public int getPostState() {
		return postState;
	}
	public void setPostState(int postState) {
		this.postState = postState;
	}
	
}
