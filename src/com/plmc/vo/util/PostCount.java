package com.plmc.vo.util;

import com.plmc.vo.entity.BaseEntity;

public class PostCount extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String postCountNo;
	private String userNo;
	private String postNo;
	private String ipAddress;
	public PostCount() {
		super();
	}
	
	public PostCount(String userNo, String postNo, String ipAddress) {
		super();
		this.userNo = userNo;
		this.postNo = postNo;
		this.ipAddress = ipAddress;
	}

	public PostCount(String postCountNo, String userNo, String postNo, String ipAddress) {
		super();
		this.postCountNo = postCountNo;
		this.userNo = userNo;
		this.postNo = postNo;
		this.ipAddress = ipAddress;
	}
	@Override
	public String toString() {
		return "PostCount [postCountNo=" + postCountNo + ", userNo=" + userNo + ", postNo=" + postNo + ", ipAddress="
				+ ipAddress + "]";
	}
	public String getPostCountNo() {
		return postCountNo;
	}
	public void setPostCountNo(String postCountNo) {
		this.postCountNo = postCountNo;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getPostNo() {
		return postNo;
	}
	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
