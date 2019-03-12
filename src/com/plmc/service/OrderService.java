package com.plmc.service;

import java.text.ParseException;
import java.util.List;

import com.plmc.common.Page;
import com.plmc.dto.ActDto;
import com.plmc.dto.OrderDto;
import com.plmc.dto.UserDto;
import com.plmc.vo.entity.ToolOrder;

public interface OrderService {
	
	//订单查询
	/**
	 * 按订单编号查询订单
	 * @param OrderNo 订单编号
	 * @return 订单对象
	 * @throws ParseException 
	 */
	public OrderDto findByOrderNo(String orderNo) throws ParseException;

	/**
	 * 查询一页订单
	 * @param dtoPage
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException 
	 */
	public Page<OrderDto> findOrderPage(Page<OrderDto> dtoPage, String[] attrs, Object[] values) throws ParseException;
	
	/**
	 * 取指定条件订单
	 * @param attrs
	 * @param values
	 * @return
	 * @throws ParseException 
	 */
	public List<OrderDto> findOrder(String[] attrs, Object[] values) throws ParseException;
	
	/**
	 * 获得用户购物车里面一个道具的订单数量
	 * @param toolNo
	 * @param userNo
	 * @return
	 */
	public int getToolOrderNum(String toolNo, String userNo);
	
	/**
	 * 统计订单
	 * @param attrs
	 * @param values
	 * @return
	 */
	public int countOrder(String[] attrs, Object[] values);

	
	//下单（购买道具）
	/**
	 * 下单，创建新订单
	 * @param orderDto 订单对象
	 * @return
	 * @throws ParseException 
	 */
	public int makeOrder(OrderDto orderDto) throws ParseException;

	/**
	 * 取消、删除订单订单
	 * @param orderNo 订单编号
	 * @return
	 */
	public int deleteOrder(String orderNo);
	
	/**
	 * 支付订单
	 * @param orderNo 订单编号
	 * @return
	 */
	public int payOrder(String orderNo);
	
	/**
	 * 自动计算订单总价
	 * @param orderNo 订单编号
	 * @return
	 * @throws ParseException 
	 */
	public double addOrderPrice(String orderNo) throws ParseException;

	/**
	 * 修改订单
	 * @param orderDto 订单对象
	 * @return
	 * @throws ParseException 
	 */
	public int alterOrder(OrderDto orderDto) throws ParseException;
	
	
	//订单审核
	/**
	 * 订单支付成功
	 * @param orderNo 订单编号
	 * @return
	 */
	public int passPayOrder(String orderNo);
	/**
	 * 订单支付失败
	 * @param orderNo 订单编号
	 * @return
	 */
	public int failPayOrder(String orderNo);
	/**
	 * 订单发货
	 * @param orderNo 订单编号
	 * @return
	 */
	public int sendOutTool(String orderNo);
	
	
	//订单过期
	/**
	 * 订单过期
	 * @param orderNo 订单编号
	 * @return
	 */
	public int overdueOrder(String orderNo);

	
	//订单单项
	/**
	 * 生成道具订单项
	 * @param toolOrder 道具订单项目对象
	 * @return
	 * @throws Exception 
	 */
	public int makeToolOrder(ToolOrder toolOrder, UserDto userDto) throws Exception;
	
	/**
	 * 删除道具订单项
	 * @param toolOrderNo
	 * @return
	 */
	public int deleteToolOrder(String toolOrderNo);

	/**
	 * 订单过期批处理
	 * @throws ParseException 
	 */
	public void batchOverdueOrder() throws ParseException;

	/**
	 * 根据用户编号获取用户购物车总价
	 * @param userNo
	 * @return
	 */
	public double getToltalPice(String userNo);
}
