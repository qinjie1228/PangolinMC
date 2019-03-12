package com.plmc.test.dao;

import java.util.Date;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.plmc.dao.NoticeDao;
import com.plmc.vo.entity.Notice;

public class NoticeDaoTest {
	
	private ApplicationContext applicationContext;	
	private NoticeDao noticeDao;
	
	@Before
	//通过配置文件获取applicationContext对象、userDao对象
	public void before(){
		applicationContext=new ClassPathXmlApplicationContext(new String[]{"springmvc-servlet.xml"});
		noticeDao=(NoticeDao) applicationContext.getBean("noticeDaoImpl");
	}
	
	@Test
	//添加公告信息测试
	public void addNotice(){
		Date date=new Date();
		noticeDao.save(new Notice("450542c4f40b11e681f2a0481c1905a9", "测试已发布公告标题1", "测试已发布公告内容1", date, 1));
	}
	

}
