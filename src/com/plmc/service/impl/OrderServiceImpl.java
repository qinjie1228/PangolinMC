package com.plmc.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;

import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.plmc.common.Page;
import com.plmc.dao.OrderDao;
import com.plmc.dao.ToolDao;
import com.plmc.dao.ToolOrderDao;
import com.plmc.dao.UserDao;
import com.plmc.dto.ActDto;
import com.plmc.dto.OrderDto;
import com.plmc.dto.UserDto;
import com.plmc.service.OrderService;
import com.plmc.util.ServiceConstantUtil;
import com.plmc.util.ThreadLocalDateUtil;
import com.plmc.vo.entity.Act;
import com.plmc.vo.entity.Order;
import com.plmc.vo.entity.Tool;
import com.plmc.vo.entity.ToolOrder;
import com.plmc.vo.entity.User;
@Service
@Transactional
public class OrderServiceImpl extends ServiceConstantUtil implements OrderService {
	
	@Autowired 
	private OrderDao orderDao;
	
	@Autowired 
	private UserDao userDao;
	
	@Autowired 
	private ToolOrderDao toolOrderDao;
	
	@Autowired 
	private ToolDao toolDao;

	@Override
	public OrderDto findByOrderNo(String orderNo) throws ParseException {
		return this.entityToDto(orderDao.getById(Order.class, orderNo));
	}

	@Override
	public Page<OrderDto> findOrderPage(Page<OrderDto> dtoPage, String[] attrs, Object[] values) throws ParseException {
		Page<Order> orderPage = new Page<Order>();
		orderPage.setPage(dtoPage.getPage());
		orderPage.setPageSize(dtoPage.getPageSize());
		
		orderPage = orderDao.pageSelect(Order.class, orderPage, attrs, values);

		Page<OrderDto> page = new Page<OrderDto>();
		page.setPage(orderPage.getPage());
		page.setOrder(orderPage.getOrder());
		page.setPageSize(orderPage.getPageSize());
		page.setSort(orderPage.getSort());
		page.setTotal(orderPage.getTotal());
		page.setPageCount(orderPage.getPageCount());
		List<Order> orderPageDate = orderPage.getData();
		int pageDateSize = orderPageDate.size();
		if(pageDateSize <= 0){
			return page;
		}
		else{
			List<OrderDto> pageDate = new ArrayList<OrderDto>();
			for(int i=0; i<pageDateSize; i++){
				pageDate.add(this.entityToDto(orderPageDate.get(i)));
			}
			page.setData(pageDate);
			return page;
		}

	}

	@Override
	public int makeOrder(OrderDto orderDto) throws ParseException {
		return this.alterOrder(orderDto);
	}

	@Override
	public int deleteOrder(String orderNo) {
		try{
			String[] attrs = {"orderNo"};
			Object[] values = {orderNo};
			List<ToolOrder> toolOrderList = toolOrderDao.selectList(ToolOrder.class, attrs, values);
			for(int i = 0; i < toolOrderList.size(); i++){
				ToolOrder toolOrderOne = toolOrderList.get(i);
				this.deleteToolOrder(toolOrderOne.getToolOrderNo());
				
				Tool toolOne = toolDao.getById(Tool.class, toolOrderOne.getToolNo());
				int toolNum = toolOne.getToolNum() + toolOrderOne.getToolOneNum();
				toolOne.setToolNum(toolNum);
				toolDao.update(toolOne);
			}
			return orderDao.deleteById(Order.class, orderNo);
		} catch (Exception e) {
			return -1;
		}
	}

	@Override
	public int payOrder(String orderNo) {
		Order order = orderDao.getById(Order.class, orderNo);
		if(order == null){
			return -1;
		}
		else{
			order = this.clearOrder(order);
			order.setOrderPayTime(new Date());
			order.setOrderState(ORDER_PASSPAY_STATE);
			return orderDao.update(order);
		}
	}

	@Override
	public int alterOrder(OrderDto orderDto) throws ParseException {
		Order order = orderDao.getById(Order.class, orderDto.getOrderNo());
		Order orderUpdate = this.clearOrder(orderDao.getById(Order.class, orderDto.getOrderNo()));
		
		if(orderDto.getOrderCode() != null && orderDto.getOrderCode() !=""){
			if(!orderDto.getOrderCode().equals(order.getOrderCode() == null ? "" : order.getOrderCode())){
				orderUpdate.setOrderCode(orderDto.getOrderCode());
			}
		}
		if(orderDto.getUserNo() != null && orderDto.getUserNo() !=""){
			if(!orderDto.getUserNo().equals(order.getUserNo() == null ? "" : order.getUserNo())){
				orderUpdate.setUserNo(orderDto.getUserNo());
			}
		}
		if(orderDto.getOrderMakeTime() != null && orderDto.getOrderMakeTime() !=""){
			if(!orderDto.getOrderMakeTime().equals(order.getOrderMakeTime() == null ? "" : ThreadLocalDateUtil.formatDate(order.getOrderMakeTime()))){
				orderUpdate.setOrderMakeTime(ThreadLocalDateUtil.parse(orderDto.getOrderMakeTime()));
			}
		}
		if(orderDto.getOrderPayTime() != null && orderDto.getOrderPayTime() !=""){
			if(!orderDto.getOrderPayTime().equals(order.getOrderPayTime() == null ? "" : ThreadLocalDateUtil.formatDate(order.getOrderPayTime()))){
				orderUpdate.setOrderPayTime(ThreadLocalDateUtil.parse(orderDto.getOrderPayTime()));
			}
		}
		if(orderDto.getOrderSendTime() != null && orderDto.getOrderSendTime() !=""){
			if(!orderDto.getOrderSendTime().equals(order.getOrderSendTime() == null ? "" : ThreadLocalDateUtil.formatDate(order.getOrderSendTime()))){
				orderUpdate.setOrderSendTime(ThreadLocalDateUtil.parse(orderDto.getOrderSendTime()));
			}
		}
		if(orderDto.getOrderAddress() != null && orderDto.getOrderAddress() !=""){
			if(!orderDto.getOrderAddress().equals(order.getOrderAddress() == null ? "" : order.getOrderAddress())){
				orderUpdate.setOrderAddress(orderDto.getOrderAddress());
			}
		}
		if(orderDto.getOrderPrice() != null && orderDto.getOrderPrice() !=""){
			if(!orderDto.getOrderPrice().equals(String.valueOf(order.getOrderPrice()))){
				orderUpdate.setOrderPrice(Double.parseDouble(orderDto.getOrderPrice()));
			}
		}
		if(orderDto.getOrderState() != null && orderDto.getOrderState() !=""){
			if(!orderDto.getOrderState().equals(String.valueOf(order.getOrderState()))){
				orderUpdate.setOrderState(Integer.parseInt(orderDto.getOrderState()));
			}
		}
		return orderDao.update(orderUpdate);
	}

	@Override
	public int passPayOrder(String orderNo) {
		return this.changeState(orderNo, ORDER_PASSPAY_STATE);
	}

	@Override
	public int failPayOrder(String orderNo) {
		return this.deleteOrder(orderNo);
	}

	@Override
	public int overdueOrder(String orderNo) {
		return this.changeState(orderNo, ORDER_OVERDUE_STATE);
	}
	
	@Override
	public int sendOutTool(String orderNo) {
		Order order = orderDao.getById(Order.class, orderNo);
		if(order == null){
			return -1;
		}
		else{
			order = this.clearOrder(order);
			order.setOrderSendTime(new Date());
			order.setOrderState(ORDER_SEND_STATE);
			return orderDao.update(order);
		}
	}

	@Override
	public int makeToolOrder(ToolOrder toolOrder, UserDto userDto) throws Exception {
			int result = 0;
			String[] attrsWait = {"userNo", "orderState"};
			Object[] valuesWait = {userDto.getUserNo(), ORDER_WAITINGCHECK_STATE};
			List<Order> orderWaitList = orderDao.selectList(Order.class, attrsWait, valuesWait);
			int orderWaitListSize = orderWaitList.size();
			if(orderWaitListSize > 0){
				result = -3;
				return result;
			}
			
			String[] attrs = {"userNo", "orderInCart"};
			Object[] values = {userDto.getUserNo(), "true"};
			List<Order> orderList = orderDao.selectList(Order.class, attrs, values);
			int orderListSize = orderList.size();
			Order order = new Order();
			if(orderListSize > 1){
				result = -2;
				return result;
			}
			else if(orderListSize == 0){
				order.setOrderCode(this.createOrderCode(userDto.getUserNo()));
				order.setUserNo(userDto.getUserNo());
				order.setOrderState(ORDER_CART_STATE);
				order.setOrderAddress(userDto.getUserAddress());
				orderDao.save(order);
				
				Tool tool = toolDao.getById(Tool.class, toolOrder.getToolNo());
				int toolNum = tool.getToolNum() - toolOrder.getToolOneNum() < 0 ? -1 : tool.getToolNum() - toolOrder.getToolOneNum();
				if(toolNum == -1){
					throw new Exception("库存量不够！");
				}
				tool.setToolNum(toolNum);
				toolDao.update(tool);
			}
			
			if(orderListSize == 1){
				Tool tool = toolDao.getById(Tool.class, toolOrder.getToolNo());
				String orderOldNo = orderList.get(0).getOrderNo();
				String[] attrsToolOrder = {"orderNo", "toolNo"}; 
				Object[] valuesToolOrder = {orderOldNo, toolOrder.getToolNo()};
				List<ToolOrder> toolOrderList = toolOrderDao.selectList(ToolOrder.class, attrsToolOrder, valuesToolOrder);
				if(toolOrderList.size() > 0){
					int toolNum = tool.getToolNum() - (toolOrder.getToolOneNum() - toolOrderList.get(0).getToolOneNum()) < 0 ? -1 : tool.getToolNum() - (toolOrder.getToolOneNum() - toolOrderList.get(0).getToolOneNum());
					if(toolNum == -1){
						throw new Exception("库存量不够！");
					}
					tool.setToolNum(toolNum);
					toolDao.update(tool);
					
					ToolOrder toolOrderOne = toolOrderList.get(0); 
					ToolOrder toolOrderOneUpdate = new ToolOrder();
					toolOrderOneUpdate.setToolOrderNo(toolOrderOne.getToolOrderNo());
					toolOrderOneUpdate.setToolOneNum(toolOrder.getToolOneNum());
					result = toolOrderDao.update(toolOrderOneUpdate);
				}
				else{
					int toolNum = tool.getToolNum() - toolOrder.getToolOneNum() < 0 ? -1 : tool.getToolNum() - toolOrder.getToolOneNum();
					if(toolNum == -1){
						throw new Exception("库存量不够！");
					}
					tool.setToolNum(toolNum);
					toolDao.update(tool);
					
					toolOrder.setOrderNo(orderOldNo);
					toolOrder.setToolOrderState(TOOLORDER_NORMAL_STATE);
					result = toolOrderDao.save(toolOrder);
				}
			}
			else if(orderListSize == 0){
				String orderNewNo = order.getOrderNo();
				toolOrder.setOrderNo(orderNewNo);
				toolOrder.setToolOrderState(TOOLORDER_NORMAL_STATE);
				result = toolOrderDao.save(toolOrder);
			}
			return result;
	}

	@Override
	public int deleteToolOrder(String toolOrderNo) {
		return toolOrderDao.deleteById(ToolOrder.class , toolOrderNo);
	}

	@Override
	public int countOrder(String[] attrs, Object[] values) {
		return orderDao.pageCount(Order.class, attrs, values);
	}

	@Override
	public List<OrderDto> findOrder(String[] attrs, Object[] values) throws ParseException {
		List<OrderDto> listDto = new ArrayList<OrderDto>(); 
		List<Order> listEntity = orderDao.selectList(Order.class, attrs, values);
		for(int i=0; i<listEntity.size(); i++ ){
			OrderDto dto = this.entityToDto(listEntity.get(i));
			listDto.add(dto);
		}
		return listDto;
	}
	
	@Override
	public void batchOverdueOrder() throws ParseException {
		String[] attrs = {"orderInCart"}; 
		Object[] values = {"true"};
		List<Order> orderList = orderDao.selectList(Order.class, attrs, values);
		if(orderList.size() > 0){
			for(int i = 0; i < orderList.size(); i ++){
				Order order = orderList.get(i);
				long orderTimeDifference = ThreadLocalDateUtil.dateCalculate(order.getOrderMakeTime(),new Date()) + 30*60*1000;
				if(orderTimeDifference < 0){
					this.changeState(order.getOrderNo(), ORDER_OVERDUE_STATE);
				}
			}
		}
		
	}
	

	@Override
	public int getToolOrderNum(String toolNo, String userNo) {
		int toolOrderNum = 0;
		String[] attrs = {"toolNo", "userNo", "orderInCart"}; 
		Object[] values = {toolNo, userNo, "true"};
		List<Order> orderList = orderDao.selectList(Order.class, attrs, values);
		if(orderList.size() == 1){
			String[] attrsToolOrder = {"orderNo", "toolNo", "toolOrderState"}; 
			Object[] valuesToolOrder = {orderList.get(0).getOrderNo(), toolNo, TOOLORDER_NORMAL_STATE};
			List<ToolOrder> toolOrderList = toolOrderDao.selectList(ToolOrder.class, attrsToolOrder, valuesToolOrder);
			if(toolOrderList.size() > 0){
				for(int i=0; i<toolOrderList.size(); i++){
					toolOrderNum += toolOrderList.get(i).getToolOneNum();
				}
			}
		}
		return toolOrderNum;
	}
	
	//**************私有方法 开始**************//
	private OrderDto entityToDto(Order order) throws ParseException{
		OrderDto orderDto = new OrderDto();
		orderDto.setOrderNo(order.getOrderNo());
		orderDto.setOrderCode(order.getOrderCode());
		orderDto.setOrderNo(order.getOrderNo());
		orderDto.setUserName(userDao.getById(User.class, order.getUserNo()).getUserName());
		
		String toolNumPrice = "";
		double orderPrice = 0;
		String[] attrs = {"orderNo"};
		Object[] values = {order.getOrderNo()};
		List<ToolOrder> toolOrderList = toolOrderDao.selectList(ToolOrder.class, attrs, values);
		for(int i = 0; i < toolOrderList.size(); i++){
			ToolOrder toolOrderOne = toolOrderList.get(i);
			toolNumPrice += toolDao.getById(Tool.class, toolOrderOne.getToolNo()).getToolName() + "  " + String.valueOf(toolOrderOne.getToolRealPrice());
			toolNumPrice += "          X ";
			toolNumPrice += String.valueOf(toolOrderOne.getToolOneNum()) +"\n";
			orderPrice += toolOrderOne.getToolOneNum() * toolOrderOne.getToolRealPrice();
		}
		toolNumPrice += "\t\t\t\t\t\t\t\t\t\t\t总价:￥" + String.valueOf(orderPrice);
		orderDto.setToolNumPrice(toolNumPrice);
		
		orderDto.setOrderMakeTime(order.getOrderMakeTime() == null ? "" : ThreadLocalDateUtil.formatDate(order.getOrderMakeTime()));
		orderDto.setOrderPayTime(order.getOrderPayTime() == null ? "" : ThreadLocalDateUtil.formatDate(order.getOrderPayTime()));
		orderDto.setOrderSendTime(order.getOrderSendTime() == null ? "" : ThreadLocalDateUtil.formatDate(order.getOrderSendTime()));
		orderDto.setOrderAddress(order.getOrderAddress());
		orderDto.setOrderPrice(String.valueOf(order.getOrderPrice()));
		orderDto.setOrderState(String.valueOf(order.getOrderState()));
		
		return orderDto;
	}
	
	private Order clearOrder(Order order){
		order.setOrderCode("");
		order.setUserNo("");
		order.setOrderMakeTime(null);
		order.setOrderPayTime(null);
		order.setOrderSendTime(null);
		order.setOrderAddress("");
		order.setOrderPrice(-1);
		order.setOrderState(-1);
		return order;
	}
	
	private int changeState(String orderNo, int state){
		Order order = orderDao.getById(Order.class, orderNo);
		if(order == null){
			return -1;
		}
		else{
			order = this.clearOrder(order);
			order.setOrderState(state);
			return orderDao.update(order);
		}
	}
	
	/**
	 * 生成订单code编号
	 * 生成规则：po(pangolin mountaineering club order)+年月4位+日时分秒毫秒取随机数4位+用户编号取随机数4位，共14位
	 * @param userNo
	 * @return
	 */
	private String createOrderCode(String userNo){
		
		Random random = new Random();
		
		char[] dateAfterFormat =new char[4];
		char[] date = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()).toCharArray();
		char[] dateBeforeFormat = Arrays.copyOfRange(date, 6, 17);
		
        for(int i = 0; i < 4; i ++){
        	dateAfterFormat[i] =dateBeforeFormat[random.nextInt(11)];
        }
        
        char[] prefix = {'p', 'o', date[2], date[3], date[4], date[5]};
        
        char[] userNoAfterFormat =new char[4];
		char[] userNoBeforeFormat = userNo.toCharArray();
        for(int i = 0; i < 4; i ++){
        	userNoAfterFormat[i] =userNoBeforeFormat[random.nextInt(32)];
        }
        return String.valueOf(ArrayUtils.addAll(ArrayUtils.addAll(prefix, dateAfterFormat), userNoAfterFormat));
	}
	//**************私有方法 结束**************//

	@Override
	public double addOrderPrice(String orderNo) throws ParseException {
		double orderPrice = 0;
		String[] attrs = {"orderNo"};
		Object[] values = {orderNo};
		Order order = orderDao.getById(Order.class, orderNo);
		List<ToolOrder> toolOrderList = toolOrderDao.selectList(ToolOrder.class, attrs, values);
		for(int i = 0; i < toolOrderList.size(); i++){
			ToolOrder toolOrderOne = toolOrderList.get(i);
			orderPrice += toolOrderOne.getToolOneNum() * toolOrderOne.getToolRealPrice();
		}
		order = this.clearOrder(order);
		order.setOrderPrice(orderPrice);
		orderDao.update(order);
		return orderPrice;
	}

	@Override
	public double getToltalPice(String userNo) {
		double orderPrice = 0;
		String[] attrs = {"userNo", "orderInCart"};
		Object[] values = {userNo, "true"};
		List<Order> orderList = orderDao.selectList(Order.class, attrs, values);
		if(orderList.size() != 1){
			return orderPrice;
		}
		else{
			String[] attrsOrder = {"orderNo"};
			Object[] valuesOrder = {orderList.get(0).getOrderNo()};
			List<ToolOrder> toolOrderList = toolOrderDao.selectList(ToolOrder.class, attrsOrder, valuesOrder);
			for(int i = 0; i < toolOrderList.size(); i++){
				ToolOrder toolOrderOne = toolOrderList.get(i);
				orderPrice += toolOrderOne.getToolOneNum() * toolOrderOne.getToolRealPrice();
			}
		}
		return orderPrice;
	}

}
