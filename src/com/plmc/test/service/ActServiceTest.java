package com.plmc.test.service;


import java.util.HashMap;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.plmc.service.ActService;

public class ActServiceTest {

	private ApplicationContext applicationContext;	
	private ActService actService;
	
	@Before
	public void before(){
		applicationContext=new ClassPathXmlApplicationContext(new String[]{"springmvc-servlet.xml"});
		actService=(ActService) applicationContext.getBean("actServiceImpl");
	}
	
	@Test
	//添加活动信息测试
	public void addAct(){
		HashMap<String , Object> map = new HashMap<String , Object>();
		map.put("k1", 1);
		map.put("k2", "sfds");
		System.out.println(map.get("k1"));

	}
}
