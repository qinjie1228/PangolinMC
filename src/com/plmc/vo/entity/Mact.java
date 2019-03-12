package com.plmc.vo.entity;

import java.util.Date;

public class Mact extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String mactNo;
	private String userNo;
	private String actNo;
	private Date actResTime;
	private int actResState;
	public Mact() {
		super();
	}
	
	public Mact(String userNo, String actNo, Date actResTime, int actResState) {
		super();
		this.userNo = userNo;
		this.actNo = actNo;
		this.actResTime = actResTime;
		this.actResState = actResState;
	}
	
	public Mact(String mactNo, String userNo, String actNo, Date actResTime, int actResState) {
		super();
		this.mactNo = mactNo;
		this.userNo = userNo;
		this.actNo = actNo;
		this.actResTime = actResTime;
		this.actResState = actResState;
	}
	
	@Override
	public String toString() {
		return "Mact [mactNo=" + mactNo + ", userNo=" + userNo + ", actNo=" + actNo + ", actResTime=" + actResTime + ", actResState="
				+ actResState + "]";
	}

	public String getMactNo() {
		return mactNo;
	}

	public void setMactNo(String mactNo) {
		this.mactNo = mactNo;
	}

	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getActNo() {
		return actNo;
	}
	public void setActNo(String actNo) {
		this.actNo = actNo;
	}
	public Date getActResTime() {
		return actResTime;
	}
	public void setActResTime(Date actResTime) {
		this.actResTime = actResTime;
	}

	public int getActResState() {
		return actResState;
	}

	public void setActResState(int actResState) {
		this.actResState = actResState;
	}
	
}
