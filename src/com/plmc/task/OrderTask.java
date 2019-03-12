package com.plmc.task;

import java.util.TimerTask;

import com.plmc.service.OrderService;
import com.plmc.util.SpringContext;


/**
 * 订单批处理定时任务
 *
 */
public class OrderTask extends TimerTask {
	public void run() {
		OrderService orderService = (OrderService)SpringContext.getBean("orderServiceImpl");
		try{
			orderService.batchOverdueOrder();
		}catch(Exception e){
		}
	}
}
