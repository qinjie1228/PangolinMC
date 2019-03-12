package com.plmc.listener;

import java.text.ParseException;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.lang3.StringUtils;

import com.plmc.task.OrderTask;
import com.plmc.util.PropertiesUtil;
import com.plmc.util.ThreadLocalDateUtil;


/**
 * 订单批处理程序监听器
 *
 */
public class OrderTaskListener implements ServletContextListener{
	private Timer timer = null;
	
	public void contextInitialized(ServletContextEvent event) {
		String reportOpenOrCloseSwitch = PropertiesUtil.get("systemConfig", "batch.plmc.order.switch");
		int repeatTime = Integer.parseInt(PropertiesUtil.get("systemConfig", "batch.plmc.order.RepeatTime"));
		if(StringUtils.equals(reportOpenOrCloseSwitch, "true")){
			timer = new Timer(true);
		    timer.schedule(new OrderTask(), 10000, 1000*repeatTime);
		    try {
				System.out.println("订单批处理监听程序开始运行..." + ThreadLocalDateUtil.formatDate(new Date()));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void contextDestroyed(ServletContextEvent event) {
		if(timer != null){
			timer.cancel();
			try {
				System.out.println("订单批处理监听程序停止运行..." + ThreadLocalDateUtil.formatDate(new Date()));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
