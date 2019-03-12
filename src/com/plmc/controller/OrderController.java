package com.plmc.controller;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.plmc.common.Page;
import com.plmc.dto.NoticeDto;
import com.plmc.dto.OrderDto;
import com.plmc.dto.UserDto;
import com.plmc.service.OrderService;
import com.plmc.service.UserService;
import com.plmc.util.ControllerConstantUtil;
import com.plmc.util.ThreadLocalDateUtil;
import com.plmc.vo.entity.Order;
import com.plmc.vo.entity.ToolOrder;
import com.plmc.vo.entity.User;
import com.plmc.vo.session.CurrentUser;

@RequestMapping("/order")
@Controller
public class OrderController extends ControllerConstantUtil {
	
	@Autowired  
	private OrderService orderService;
	
	@Autowired  
	private UserService userService;

	@RequestMapping(value = "/toGetAllOrder", method = RequestMethod.GET)
	public ModelAndView toGetAllOrder(HttpSession session,
			@RequestParam("orderState") String orderState, String url) {
		ModelAndView orderModel = new ModelAndView();
		CurrentUser currentUser = (CurrentUser) session.getAttribute(CURRENT_USER);
		orderModel.addObject(CURRENT_USER, currentUser);
		orderModel.addObject(ORDER_STATE, orderState);
		orderModel.setViewName(url);
		return orderModel;
	}
	
	
	@ResponseBody
	@RequestMapping("/doGetAllOrder")
	public Page<OrderDto> doGetAllOrder(int pageNow, int pageSize, int orderState) throws ParseException {
		Page<OrderDto> page =new Page<OrderDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"orderState"};
		Object[] values = {orderState};
		page = orderService.findOrderPage(page, attrs, values);
		return page;
	}
	
	
	@ResponseBody
	@RequestMapping("/getOrderCondition")
	public Page<OrderDto> getOrderCondition(int pageNow, int pageSize, OrderDto dto, int orderState, String searchStartPrice, String searchEndPrice, String searchMakeStartTime, String searchMakeEndTime, String searchPayStartTime, String searchPayEndTime, String searchSendStartTime, String searchSendEndTime) throws ParseException {
		Page<OrderDto> page =new Page<OrderDto>();
		page.setPage(pageNow);
		page.setPageSize(pageSize);
		String[] attrs = {"orderCode","userName","priceStart","priceEnd","makeTimeStart","makeTimeEnd","payTimeStart","payTimeEnd","sendTimeStart","sendTimeEnd","orderState"};
		Object[] values = {dto.getOrderCode(),dto.getUserName(),searchStartPrice,searchEndPrice,searchMakeStartTime,searchMakeEndTime,searchPayStartTime,searchPayEndTime,searchSendStartTime,searchSendEndTime,orderState};
		page = orderService.findOrderPage(page, attrs, values);
		return page;
	}
	

	@ResponseBody
	@RequestMapping("/findOrderByOrderNo")
	public OrderDto findOrderByOrderNo(String orderNo) throws ParseException{
		OrderDto orderDto = orderService.findByOrderNo(orderNo);
		return orderDto;
	}
	
	
	@ResponseBody
	@RequestMapping("/getToolOrderNum")
	public int getToolOrderNum(String toolNo, String userNo) throws ParseException{
		int orderToolNum = orderService.getToolOrderNum(toolNo, userNo);
		return orderToolNum;
	}
	
	
	@RequestMapping(value = "/doAlterOrder", method = RequestMethod.POST)
	public ModelAndView doAlterOrder( 
			@ModelAttribute("orderDto") OrderDto orderDto) throws ParseException{
		ModelAndView orderModel = new ModelAndView();
		int result = orderService.alterOrder(orderDto);
		orderModel.addObject(ORDER_STATE, orderDto.getOrderState());
		if(1 == result){
			orderModel.addObject("alterMsg", "订单修改成功！");
			orderModel.addObject("alterState", 1);
		}
		else{
			orderModel.addObject("alterMsg", "订单修改失败！");
			orderModel.addObject("alterState", 0);
		}
		orderModel.setViewName("page/background/order-list");
		return orderModel;
		
	}
	
	
	@RequestMapping(value = "/addOrder", method = RequestMethod.POST)
	public ModelAndView addOrder(
			@ModelAttribute("orderDto") OrderDto orderDto) throws ParseException{
		ModelAndView userModel = new ModelAndView();
		userModel.addObject(ORDER_STATE, orderDto.getOrderState());
		orderDto.setOrderMakeTime(ThreadLocalDateUtil.formatDate(new Date()));
		orderDto.setOrderState(String.valueOf(ORDER_WAITINGCHECK_STATE));
		int result = orderService.makeOrder(orderDto);
		if(1 == result){
			userModel.addObject("addMsg", "订单创建成功！");
			userModel.addObject("addState", 1);
		}
		else{
			userModel.addObject("addMsg", "订单创建失败！");
			userModel.addObject("addState", 0);
		}
		userModel.setViewName("page/forehead/order-list");
		return userModel;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/passOrder")
	public Model passOrder(Model model, String orderNo){
		int result = orderService.passPayOrder(orderNo);
		if(1==result){
			model.addAttribute("passMsg","活动申请已通过并发布！");
			model.addAttribute("passState",1);
		}
		else{
			model.addAttribute("passMsg","活动申请处理失败！");
			model.addAttribute("passState",0);
		}
		return model;
		
	}

	
	@ResponseBody
	@RequestMapping("/sendOutTool")
	public Model sendOutTool(Model model, String orderNo){
		int result = orderService.sendOutTool(orderNo);
		if(1==result){
			model.addAttribute("sendMsg","订单状态已变更为已发货状态！");
			model.addAttribute("sendState",1);
		}
		else{
			model.addAttribute("sendMsg","订单发货处理失败！");
			model.addAttribute("sendState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/deleteOrder")
	public Model deleteOrder(Model model, String orderNo){
		int result = orderService.deleteOrder(orderNo);
		if(1==result){
			model.addAttribute("deleteMsg","已彻底删除订单！");
			model.addAttribute("deleteState",1);
		}
		else{
			model.addAttribute("deleteMsg","删除订单失败！");
			model.addAttribute("deleteMsg",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/overdueOrder")
	public Model overdueOrder(Model model, String orderNo){
		int result = orderService.overdueOrder(orderNo);
		if(1==result){
			model.addAttribute("deleteMsg","已彻底删除订单！");
			model.addAttribute("deleteState",1);
		}
		else{
			model.addAttribute("deleteMsg","删除订单失败！");
			model.addAttribute("deleteMsg",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/doPayOrder")
	public HashMap<String, Object> doPayOrder(OrderDto orderDto) throws ParseException{
		HashMap<String,Object> model =new HashMap<String,Object>();
		orderDto.setOrderState(String.valueOf(ORDER_WAITINGCHECK_STATE));
		orderDto.setOrderPayTime(ThreadLocalDateUtil.formatDate(new Date()));
		int result = orderService.alterOrder(orderDto);
		if(1==result){
			model.put("payMsg","支付成功！");
			model.put("payState",1);
		}
		else{
			model.put("payMsg","支付失败！");
			model.put("payState",0);
		}
		return model;
		
	}

	
	@ResponseBody
	@RequestMapping("/alterDo")
	public HashMap<String, Object> alterDo(OrderDto orderDto) throws ParseException{
		HashMap<String,Object> model =new HashMap<String,Object>();
		int result = orderService.alterOrder(orderDto);
		if(1==result){
			model.put("msg","修改成功！");
			model.put("state",1);
		}
		else{
			model.put("msg","修改失败！");
			model.put("state",0);
		}
		return model;
		
	}

	
	@ResponseBody
	@RequestMapping("/addCart")
	public Model addCart(Model model, String toolNo, int toolNum, String toolPrice, String userNo) throws Exception{
		ToolOrder toolOrder = new ToolOrder(toolNo, toolNum, Double.parseDouble(toolPrice));
		UserDto userDto = userService.findByUserNo(userNo);
		int result = orderService.makeToolOrder(toolOrder, userDto);
		if(1==result){
			model.addAttribute("addState",1);
		}
		else if(-2==result){
			model.addAttribute("addState",2);
		}
		else if(-3==result){
			model.addAttribute("addState",3);
		}
		else{
			model.addAttribute("addState",0);
		}
		return model;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/getToltalPice")
	public String getToltalPice(String userNo) throws Exception{
		DecimalFormat decimalFormat=new DecimalFormat(".00");
		return decimalFormat.format(orderService.getToltalPice(userNo));
	}
	
	
	@ResponseBody
	@RequestMapping("/getOrderNoByUserNo")
	public String getOrderNoByUserNo(String userNo) throws Exception{
		String orderNo ="";
		String[] attrsAll = {"userNo"};
		Object[] valuesAll = {userNo};
		List<OrderDto> orderListAll = orderService.findOrder(attrsAll, valuesAll);
		if(orderListAll.size() < 1){
			orderNo = "-1";
		}
		else{
			String[] attrs = {"userNo", "orderInCart"};
			Object[] values = {userNo, "true"};
			List<OrderDto> orderList = orderService.findOrder(attrs, values);
			if(orderList.size() != 1){
				return orderNo;
			}
			else{
				orderNo = orderList.get(0).getOrderNo();
			}
		}
		
		return orderNo;
	}
	
	
	@RequestMapping(value = "/toPayOrderDo", method = RequestMethod.GET)
	public ModelAndView toPayOrderDo(String orderNo) throws ParseException{
		ModelAndView model = new ModelAndView();
		OrderDto orderDto = orderService.findByOrderNo(orderNo);
		if(orderDto.getOrderState().equals(String.valueOf(ORDER_CART_STATE))){
			orderDto.setOrderState(String.valueOf(ORDER_CART_CONFIRM_STATE));
			orderDto.setOrderMakeTime(ThreadLocalDateUtil.formatDate(new Date()));
			orderDto.setOrderPrice(String.valueOf(orderService.addOrderPrice(orderNo)));
			orderService.alterOrder(orderDto);
		}
		HttpSession session =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession(); 
		CurrentUser currentUser = (CurrentUser)session.getAttribute(CURRENT_USER);
		if(currentUser != null){
			model.addObject(CURRENT_USER, currentUser);
		}
		model.addObject("order", orderDto);
		model.setViewName("page/forehead/pay-order");
		return model;
		
	}
}
