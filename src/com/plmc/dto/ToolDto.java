package com.plmc.dto;

public class ToolDto{
	private String toolNo;
	private String toolName;
	private String toolDes;
	private String toolNum;
	private String toolPrice;
	private String toolPic;
	private String toolPubTime;
	private String toolState;
	private String version;
	public ToolDto() {
		super();
	}
	public ToolDto(String toolNo, String toolName, String toolDes, String toolNum, String toolPrice, String toolPic,
			String toolPubTime, String toolState, String version) {
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
		return "ToolDto [toolNo=" + toolNo + ", toolName=" + toolName + ", toolDes=" + toolDes + ", toolNum=" + toolNum
				+ ", toolPrice=" + toolPrice + ", toolPic=" + toolPic + ", toolPubTime=" + toolPubTime + ", toolState="
				+ toolState + ", version=" + version + "]";
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
	public String getToolNum() {
		return toolNum;
	}
	public void setToolNum(String toolNum) {
		this.toolNum = toolNum;
	}
	public String getToolPrice() {
		return toolPrice;
	}
	public void setToolPrice(String toolPrice) {
		this.toolPrice = toolPrice;
	}
	public String getToolPic() {
		return toolPic;
	}
	public void setToolPic(String toolPic) {
		this.toolPic = toolPic;
	}
	public String getToolPubTime() {
		return toolPubTime;
	}
	public void setToolPubTime(String toolPubTime) {
		this.toolPubTime = toolPubTime;
	}
	public String getToolState() {
		return toolState;
	}
	public void setToolState(String toolState) {
		this.toolState = toolState;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}

}
