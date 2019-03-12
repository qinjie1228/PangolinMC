package com.plmc.test.dao;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class PostDaoTest {
	
//	private ApplicationContext applicationContext;	
//	private Post postDao;
//	
//	@Before
//	//通过配置文件获取applicationContext对象、activityDao对象
//	public void before(){
//		applicationContext=new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
//		postDao=(PostDao) applicationContext.getBean("postDaoImpl");
//	}
//	
//	@Test
//	//添加帖子信息测试
//	public void addPost(){
//		Date date=new Date();
//		postDao.addPost(new Post(100000000, "测试帖子类别1", "测试帖子标题1", "测试帖子内容1", "c:/actpic.jpg", date, 0));
//	}
//	
//	@Test
//	//修改帖子信息测试
//	public void alterPost(){
//		Date date=new Date();
//		postDao.alterPost(new Post(500000000, "测试帖子类别修改1", "测试帖子标题修改1", "测试帖子内容修改1", "c:/actpic.jpg", date, 0));
//	}
//	
//	@Test
//	//删除帖子信息测试
//	public void deleteAct(){
//		postDao.deletePost(500000000);
//	}
//	
//	@Test
//	//根据帖子编号查询帖子信息测试
//	public void findByPostNo(){
//		Post post = postDao.findByPostNo(500000000);
//		System.out.println(post.toString());
//	}
//	
//	@Test
//	//根据帖子标题查询帖子信息测试
//	public void findByPostTitle(){
//
//	}
//	
//	@Test
//	//根据帖子发布时间查询帖子信息测试
//	public void findByPostPubTime(){
//
//	}
//	
//	@Test
//	//根据帖子状态查询帖子信息测试
//	public void findByPostState(){
//
//	}
//	
//	@Test
//	//根据用户状态查询帖子信息测试
//	public void findByUserState(){
//
//	}
//	

}
