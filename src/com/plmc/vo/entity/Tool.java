package com.plmc.vo.entity;

import java.util.Date;

public class Tool extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String toolNo;
	private String toolName;
	private String toolDes;
	private int toolNum;
	private double toolPrice;
	private String toolPic;
	private Date toolPubTime;
	private int toolState;
	private int version;
	public Tool() {
		super();
	}
	public Tool(String toolName, String toolDes, int toolNum, double toolPrice, String toolPic, Date toolPubTime, int toolState) {
		super();
		this.toolName = toolName;
		this.toolDes = toolDes;
		this.toolNum = toolNum;
		this.toolPrice = toolPrice;
		this.toolPic = toolPic;
		this.toolPubTime = toolPubTime;
		this.toolState = toolState;
	}
	
	public Tool(String toolNo, String toolName, String toolDes, int toolNum, double toolPrice, String toolPic,
			Date toolPubTime, int toolState) {
		super();
		this.toolNo = toolNo;
		this.toolName = toolName;
		this.toolDes = toolDes;
		this.toolNum = toolNum;
		this.toolPrice = toolPrice;
		this.toolPic = toolPic;
		this.toolPubTime = toolPubTime;
		this.toolState = toolState;
	}
	
	public Tool(String toolNo, String toolName, String toolDes, int toolNum, double toolPrice, String toolPic,
			Date toolPubTime, int toolState, int version) {
		super();
		this.toolNo = toolNo;
		this.toolName = toolName;
		this.toolDes = toolDes;
		this.toolNum = toolNum;
		this.toolPrice = toolPrice;
		this.toolPic = toolPic;
		this.toolPubTime = toolPubTime;
		this.toolState = toolState;
		this.version = version;
	}
	@Override
	public String toString() {
		return "Tool [toolNo=" + toolNo + ", toolName=" + toolName + ", toolDes=" + toolDes + ", toolNum=" + toolNum
				+ ", toolPrice=" + toolPrice + ", toolPic=" + toolPic + ", toolPubTime=" + toolPubTime + ", toolState="
				+ toolState + ", version="+ version + "]";
	}
	public String getToolNo() {
		return toolNo;
	}
	public void setToolNo(String toolNo) {
		this.toolNo = toolNo;
	}
	public String getToolName() {
		return toolName;
	}
	public void setToolName(String toolName) {
		this.toolName = toolName;
	}
	public String getToolDes() {
		return toolDes;
	}
	public void setToolDes(String toolDes) {
		this.toolDes = toolDes;
	}
	public int getToolNum() {
		return toolNum;
	}
	public void setToolNum(int toolNum) {
		this.toolNum = toolNum;
	}
	public double getToolPrice() {
		return toolPrice;
	}
	public void setToolPrice(double toolPrice) {
		this.toolPrice = toolPrice;
	}
	public String getToolPic() {
		return toolPic;
	}
	public void setToolPic(String toolPic) {
		this.toolPic = toolPic;
	}
	public Date getToolPubTime() {
		return toolPubTime;
	}
	public void setToolPubTime(Date toolPubTime) {
		this.toolPubTime = toolPubTime;
	}
	public int getToolState() {
		return toolState;
	}
	public void setToolState(int toolState) {
		this.toolState = toolState;
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
	
}
