package com.plmc.vo.entity;

public class ToolOrder extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String toolOrderNo;
	private String orderNo;
	private String toolNo;
	private int toolOneNum;
	private double toolRealPrice;
	private int toolOrderState;
	public ToolOrder() {
		super();
	}
	public ToolOrder(String orderNo, String toolNo, int toolOneNum, double toolRealPrice, int toolOrderState) {
		super();
		this.orderNo = orderNo;
		this.toolNo = toolNo;
		this.toolOneNum = toolOneNum;
		this.toolRealPrice = toolRealPrice;
		this.toolOrderState = toolOrderState;
	}
	
	public ToolOrder(String toolNo, int toolOneNum, double toolRealPrice) {
		super();
		this.toolNo = toolNo;
		this.toolOneNum = toolOneNum;
		this.toolRealPrice = toolRealPrice;
	}
	public ToolOrder(String toolOrderNo, String orderNo, String toolNo, int toolOneNum, double toolRealPrice,
			int toolOrderState) {
		super();
		this.toolOrderNo = toolOrderNo;
		this.orderNo = orderNo;
		this.toolNo = toolNo;
		this.toolOneNum = toolOneNum;
		this.toolRealPrice = toolRealPrice;
		this.toolOrderState = toolOrderState;
	}
	@Override
	public String toString() {
		return "ToolOrder [toolOrderNo=" + toolOrderNo + ", orderNo=" + orderNo + ", toolNo=" + toolNo + ", toolOneNum=" + toolOneNum
				+ ", toolRealPrice=" + toolRealPrice + ", toolOrderState=" + toolOrderState + "]";
	}
	
	public String getToolOrderNo() {
		return toolOrderNo;
	}
	public void setToolOrderNo(String toolOrderNo) {
		this.toolOrderNo = toolOrderNo;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getToolNo() {
		return toolNo;
	}
	public void setToolNo(String toolNo) {
		this.toolNo = toolNo;
	}
	public int getToolOneNum() {
		return toolOneNum;
	}
	public void setToolOneNum(int toolOneNum) {
		this.toolOneNum = toolOneNum;
	}
	public double getToolRealPrice() {
		return toolRealPrice;
	}
	public void setToolRealPrice(double toolRealPrice) {
		this.toolRealPrice = toolRealPrice;
	}
	public int getToolOrderState() {
		return toolOrderState;
	}
	public void setToolOrderState(int toolOrderState) {
		this.toolOrderState = toolOrderState;
	}
	
}
