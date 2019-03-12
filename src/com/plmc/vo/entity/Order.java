package com.plmc.vo.entity;

import java.util.Date;

public class Order extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String orderNo;
	private String orderCode;
	private String userNo;
	private Date orderMakeTime;
	private Date orderPayTime;
	private Date orderSendTime;
	private String orderAddress;
	private double orderPrice;
	private int orderState;
	public Order() {
		super();
	}
	public Order(String orderCode, String userNo, Date orderMakeTime, String orderAddress, double orderPrice, int orderState) {
        super();
        this.orderCode = orderCode;
		this.userNo = userNo;
		this.orderMakeTime = orderMakeTime;
		this.orderAddress = orderAddress;
		this.orderPrice = orderPrice;
		this.orderState = orderState;
	}
	public Order(String orderCode, String userNo, Date orderMakeTime, Date orderPayTime, String orderAddress, double orderPrice,
			int orderState) {
		super();
		this.orderCode = orderCode;
		this.userNo = userNo;
		this.orderMakeTime = orderMakeTime;
		this.orderPayTime = orderPayTime;
		this.orderAddress = orderAddress;
		this.orderPrice = orderPrice;
		this.orderState = orderState;
	}
	public Order(String orderCode, String userNo, Date orderMakeTime, Date orderPayTime, Date orderSentTime, String orderAddress,
			double orderPrice, int orderState) {
		super();
		this.orderCode = orderCode;
		this.userNo = userNo;
		this.orderMakeTime = orderMakeTime;
		this.orderPayTime = orderPayTime;
		this.orderSendTime = orderSentTime;
		this.orderAddress = orderAddress;
		this.orderPrice = orderPrice;
		this.orderState = orderState;
	}
	
	public Order(String orderNo, String orderCode, String userNo, Date orderMakeTime, Date orderPayTime, Date orderSendTime,
			String orderAddress, double orderPrice, int orderState) {
		super();
		this.orderNo = orderNo;
		this.orderCode = orderCode;
		this.userNo = userNo;
		this.orderMakeTime = orderMakeTime;
		this.orderPayTime = orderPayTime;
		this.orderSendTime = orderSendTime;
		this.orderAddress = orderAddress;
		this.orderPrice = orderPrice;
		this.orderState = orderState;
	}
	
	@Override
	public String toString() {
		return "Order [orderNo=" + orderNo + ", orderCode=" + orderCode + ", userNo=" + userNo + ", orderMakeTime=" + orderMakeTime
				+ ", orderPayTime=" + orderPayTime + ", orderSendTime=" + orderSendTime + ", orderAddress="
				+ orderAddress + ", orderPrice=" + orderPrice + ", orderState=" + orderState + "]";
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
	public Date getOrderMakeTime() {
		return orderMakeTime;
	}
	public void setOrderMakeTime(Date orderMakeTime) {
		this.orderMakeTime = orderMakeTime;
	}
	public Date getOrderPayTime() {
		return orderPayTime;
	}
	public void setOrderPayTime(Date orderPayTime) {
		this.orderPayTime = orderPayTime;
	}
	public Date getOrderSendTime() {
		return orderSendTime;
	}
	public void setOrderSendTime(Date orderSendTime) {
		this.orderSendTime = orderSendTime;
	}
	public String getOrderAddress() {
		return orderAddress;
	}
	public void setOrderAddress(String orderAddress) {
		this.orderAddress = orderAddress;
	}
	public double getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(double orderPrice) {
		this.orderPrice = orderPrice;
	}
	public int getOrderState() {
		return orderState;
	}
	public void setOrderState(int orderState) {
		this.orderState = orderState;
	}
	
}
