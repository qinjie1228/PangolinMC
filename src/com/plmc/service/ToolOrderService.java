package com.plmc.service;

import java.util.List;

import com.plmc.vo.entity.ToolOrder;

public interface ToolOrderService {
	
	//道具订单项目增删改
	/**
	 * 添加道具订单项目
	 * @param toolOrder 道具订单项目对象
	 * @return 
	 */
	public int addToolOrder(ToolOrder toolOrder);
	/**
	 * 删除道具订单项目
	 * @param orderNo 订单编号
	 * @param toolNo 道具编号
	 * @return
	 */
	public int deleteToolOrder(int orderNo,int toolNo);
	/**
	 * 真正删除道具订单项目
	 * @param orderNo 订单编号
	 * @param toolNo 道具编号
	 * @return
	 */
	public int deleteToolOrderReally(int orderNo,int toolNo);
	/**
	 * 恢复道具订单项目
	 * @param orderNo 订单编号
	 * @param toolNo 道具编号
	 * @return
	 */
	public int recoverToolOrder(int orderNo,int toolNo);
	/**
	 * 修改道具订单项目
	 * @param toolOrder 道具订单项目对象
	 * @return
	 */
	public int alterToolOrder(ToolOrder toolOrder);

	
	//道具订单项目查询
	/**
	 * 按订单编号查询道具订单项目
	 * @param orderNo 订单编号
	 * @return 道具订单项目对象list集合
	 */
	public List<ToolOrder> findByOrderNo(int orderNo);
	/**
	 * 按道具订单项目状态查询道具订单项目
	 * @param toolOrderState 道具订单项目状态
	 * @return 道具订单项目对象list集合
	 */
	public List<ToolOrder> findBytoolOrderState(int toolOrderState);
	/**
	 * 按订单编号和道具订单项目状态查询道具订单项目
	 * @param orderNo 订单编号
	 * @param toolOrderState 道具订单项目状态
	 * @return 道具订单项目对象list集合
	 */
	public List<ToolOrder> findByOrderNo(int orderNo, int toolOrderState);
	/**
	 * 按道具编号查询道具订单项目
	 * @param toolNo 道具编号
	 * @return 道具订单项目对象list集合
	 */
	public List<ToolOrder> findByToolNo(int toolNo);
	/**
	 * 按道具编号和道具订单项目状态查询道具订单项目
	 * @param toolNo 道具编号
	 * @param toolOrderState 道具订单项目状态
	 * @return 道具订单项目对象list集合
	 */
	public List<ToolOrder> findByToolNo(int toolNo, int toolOrderState);
	/**
	 * 按订单编号和道具编号查询道具订单项目
	 * @param orderNo 订单编号
	 * @param toolNo 道具编号
	 * @return 道具订单项目对象
	 */
	public ToolOrder findByOrderNoToolNo(int orderNo,int toolNo);
	/**
	 * 按订单一种道具实际价格查询道具订单项目
	 * @param toolStartRealPrice 道具最低实际价格
	 * @param toolEndRealPrice 道具最高实际价格
	 * @return 道具订单项目对象list集合
	 */
	public List<ToolOrder> findByToolRealPrice(double toolStartRealPrice,double toolEndRealPrice);
	/**
	 * 按订单一种道具实际价格和道具订单项目状态查询道具订单项目
	 * @param toolStartRealPrice 道具最低实际价格
	 * @param toolEndRealPrice 道具最高实际价格
	 * @param toolOrderState 道具订单项目状态
	 * @return 道具订单项目对象list集合
	 */
	public List<ToolOrder> findByToolRealPrice(double toolStartRealPrice,double toolEndRealPrice, int toolOrderState);
	/**
	 * 查询所有道具订单项目
	 * @return 道具订单项目对象list集合
	 */
	public List<ToolOrder> findAllToolOrder();

	
}
