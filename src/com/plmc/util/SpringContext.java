package com.plmc.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;


/**
 * 提供Spring上下文
 *
 */
@Component
public class SpringContext implements ApplicationContextAware {

	private static ApplicationContext ctx;

	/**
	 * 设置上下文
	 *@param applicationContext
	 *
	 */
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {

		ctx = applicationContext;
	}
	
	/**
	 * 根据bean的Id获取bean的实例
	 *@param beanId
	 *
	 */
	public static Object getBean(String beanId)
	{
		if (null == ctx) {
			throw new NullPointerException("ApplicationContext is null");
		}

		return ctx.getBean(beanId);
	}

}
