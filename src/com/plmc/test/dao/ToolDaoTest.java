package com.plmc.test.dao;


import java.util.Date;


import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.plmc.dao.ToolDao;
import com.plmc.vo.entity.Tool;

public class ToolDaoTest {
	private ApplicationContext applicationContext;	
	private ToolDao toolDao;
	
	@Before
	public void before(){
		applicationContext=new ClassPathXmlApplicationContext(new String[]{"springmvc-servlet.xml"});
		toolDao=(ToolDao) applicationContext.getBean("toolDaoImpl");
	}
	
	@Test
	//添加道具信息测试
	public void addTool(){
		Date date=new Date();
//		toolDao.addTool(new Tool("登山道具", "测试道具描述1", 50, 142.00, "tool2.jpg", date, 1));
//		toolDao.addTool(new Tool("测试道具名称2", "测试道具描述2", 99, 180.50, "c:/toolpic.jpg", date, 1));
//		toolDao.addTool(new Tool("测试道具名称3", "测试道具描述3", 23, 93.55, "c:/toolpic.jpg", date, 1));
//		toolDao.addTool(new Tool("测试道具名称4", "测试道具描述4", 1, 32.00, "c:/toolpic.jpg", date, 1));
	}
	

	
}
