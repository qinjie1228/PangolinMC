package com.plmc.dto;

public class OrderDto{
	private String orderNo;
	private String orderCode;
	private String userNo;
	private String userName;
	private String toolNumPrice;
	private String orderMakeTime;
	private String orderPayTime;
	private String orderSendTime;
	private String orderAddress;
	private String orderPrice;
	private String orderState;
	public OrderDto() {
		super();
	}
	public OrderDto(String orderNo, String orderCode, String userNo, String userName, String toolNumPrice, String orderMakeTime,
			String orderPayTime, String orderSendTime, String orderAddress, String orderPrice, String orderState) {
		super();
		this.orderNo = orderNo;
		this.orderCode = orderCode;
		this.userNo = userNo;
		this.userName = userName;
		this.toolNumPrice = toolNumPrice;
		this.orderMakeTime = orderMakeTime;
		this.orderPayTime = orderPayTime;
		this.orderSendTime = orderSendTime;
		this.orderAddress = orderAddress;
		this.orderPrice = orderPrice;
		this.orderState = orderState;
	}
	@Override
	public String toString() {
		return "OrderDto [orderNo=" + orderNo + ", orderCode=" + orderCode + ", userNo=" + userNo + ", userName=" + userName + ", toolNumPrice="
				+ toolNumPrice + ", orderMakeTime=" + orderMakeTime + ", orderPayTime=" + orderPayTime
				+ ", orderSendTime=" + orderSendTime + ", orderAddress=" + orderAddress + ", orderPrice=" + orderPrice
				+ ", orderState=" + orderState + "]";
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getOrderCode() {
		return orderCode;
	}
	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
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
	public String getToolNumPrice() {
		return toolNumPrice;
	}
	public void setToolNumPrice(String toolNumPrice) {
		this.toolNumPrice = toolNumPrice;
	}
	public String getOrderMakeTime() {
		return orderMakeTime;
	}
	public void setOrderMakeTime(String orderMakeTime) {
		this.orderMakeTime = orderMakeTime;
	}
	public String getOrderPayTime() {
		return orderPayTime;
	}
	public void setOrderPayTime(String orderPayTime) {
		this.orderPayTime = orderPayTime;
	}
	public String getOrderSendTime() {
		return orderSendTime;
	}
	public void setOrderSendTime(String orderSendTime) {
		this.orderSendTime = orderSendTime;
	}
	public String getOrderAddress() {
		return orderAddress;
	}
	public void setOrderAddress(String orderAddress) {
		this.orderAddress = orderAddress;
	}
	public String getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(String orderPrice) {
		this.orderPrice = orderPrice;
	}
	public String getOrderState() {
		return orderState;
	}
	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}
	
}
