package com.plmc.test.dao;


import java.io.File;
import java.util.Date;


import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.plmc.dao.ActDao;
import com.plmc.vo.entity.Act;

public class ActDaoTest {
	private ApplicationContext applicationContext;	
	private ActDao actDao;
	
	@Before
	//通过配置文件获取applicationContext对象、activityDao对象
	public void before(){
		applicationContext=new ClassPathXmlApplicationContext(new String[]{"springmvc-servlet.xml"});
		actDao=(ActDao) applicationContext.getBean("actDaoImpl");
	}
	
	@Test
	//添加活动信息测试
	public void addAct(){
		Date date=new Date();
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题1","测试待审核活动内容1","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题2","测试待审核活动内容2","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题3","测试待审核活动内容3","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题4","测试待审核活动内容4","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题5","测试待审核活动内容5","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题6","测试待审核活动内容6","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题7","测试待审核活动内容7","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题8","测试待审核活动内容8","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题9","测试待审核活动内容9","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题10","测试待审核活动内容10","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题11","测试待审核活动内容11","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题12","测试待审核活动内容12","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题13","测试待审核活动内容13","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题15","测试待审核活动内容14","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题15","测试待审核活动内容15","c:/actpic.jpg",0,date,1));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试待审核活动标题16","测试待审核活动内容16","c:/actpic.jpg",0,date,1));
		
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试已发布活动标题3","测试已发布活动内容3","c:/actpic.jpg",0,date,2));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试已否决活动标题2","测试已否决活动内容2","c:/actpic.jpg",0,date,3));
		actDao.save(new Act("4506c742f40b11e681f2a0481c1905a9","测试已过期活动标题2","测试已过期活动内容2","c:/actpic.jpg",0,date,4));
	}
	
	@Test
	//修改活动信息测试
	public void alterAct(){
//		Date date=new Date();
//		actDao.alterAct(new Act(200000000,100000000,"测试活动标题修改1","测试活动内容修改1","c:/actpic.jpg",0,date,1));
	}
	
	@Test
	//删除活动信息测试
	public void deleteAct(){
//		actDao.deleteAct(200000000);
	}
	
	@Test
	//根据活动编号查询活动信息测试
	public void findByActNo(){
//		Act act=actDao.findByActNo(200000000);
//		System.out.println(act.toString());
	}
	
	@Test
	//根据活动标题查询活动信息测试
	public void findByActTitle(){

	}
	
	@Test
	//根据活动发布时间查询活动信息测试
	public void findByActPubtime(){

	}
	
	@Test
	//根据活动状态查询活动信息测试
	public void findByActState(){
//		File deleteFile = new File("D:/plmc/img/tool/"+"20160921211408");
//		if(deleteFile.isFile() && deleteFile.exists()){
//			System.out.println("dsga");
//		}
//		deleteFile.delete();
	}
	
	
}
