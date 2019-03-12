package com.plmc.test.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.plmc.dao.UserDao;
import com.plmc.vo.entity.User;

public class UserDaoTest {
	
	private ApplicationContext applicationContext;	
	private UserDao userDao;
	
	@Before
	//通过配置文件获取applicationContext对象、userDao对象
	public void before(){
		applicationContext=new ClassPathXmlApplicationContext(new String[]{"springmvc-servlet.xml"});
		userDao=(UserDao) applicationContext.getBean("userDaoImpl");
	}
	
	@Test
	//添加用户信息测试
	public void addUser(){
		Date date=new Date();
		userDao.save(new User("admin1", "111111", "管理员", 21, 1, "广东省广州市萝岗区光正科技园G11栋", "123456@qq.com", "c:/userpic.jpg", date, 4));
		userDao.save(new User("admin", "111111", "管理员", 21, 1, "广东省广州市萝岗区光正科技园G11栋", "123456@qq.com", "c:/userpic.jpg", date, 4));
		userDao.save(new User("sysAdmin", "111111", "系统管理员", 21, 1, "广东省广州市萝岗区光正科技园G11栋", "123456@qq.com", "c:/userpic.jpg", date, 5));
		userDao.save(new User("MShong", "111111", "罗易红", 21, 1, "广东省广州市萝岗区光正科技园G11栋", "123456@qq.com", "c:/userpic.jpg", date, 1));
		userDao.save(new User("mile", "111111", "米勒", 21, 0, "广东省广州市萝岗区光正科技园G11栋", "123456@qq.com", "c:/userpic.jpg", date, 1));
		userDao.save(new User("kele", "111111", "汉熙可", 21, 1, "广东省广州市萝岗区光正科技园G11栋", "123456@qq.com", "c:/userpic.jpg", date, 1));
		userDao.save(new User("head", "111111", "林老板", 21, 0, "广东省广州市萝岗区光正科技园G11栋", "123456@qq.com", "c:/userpic.jpg", date, 1));
		userDao.save(new User("xiaopang", "111111", "崔颐和", 21, 0, "广东省广州市萝岗区光正科技园G11栋", "123456@qq.com", "c:/userpic.jpg", date, 1));
		userDao.save(new User("like", "111111", "贺一东", 21, 0, "广东省广州市萝岗区光正科技园G11栋", "123456@qq.com", "c:/userpic.jpg", date, 1));
	}
	
	@Test
	//修改用户信息测试
	public void alterUser(){
		Date date=new Date();
//		userDao.alterUser(new User(100000000, "zhangsan", "123456", "张三", 20, 0, "广东省广州市萝岗区光正科技园G11栋", "123456@qq.com", "c:/userpic.jpg", date, 1));
	}
	
	@Test
	//添加用户测试
	public void deleteUser(){
//		userDao.deleteUser(100000000);
	}
	
	@Test
	//根据用户编号查询用户信息测试
	public void findByUserNo(){
//		User user=userDao.findByUserNo(100000000);
//		System.out.println(user.toString());
	}
	
	@Test
	//根据用户名查询用户信息测试
	public void findByUserName(){
//		User user=userDao.findByUserName("zhang");
//			System.out.println(user.toString());
	}
	
	@Test
	//根据用户真实姓名查询用户信息测试
	public void findByUserRealName(){
	}
	
	@Test
	//根据用户注册时间查询用户信息测试
	public void findByUserRegTime() throws ParseException{
		
	}
	
	@Test
	//根据用户状态查询用户信息测试
	public void findByUserState(){
		
	}
	
	@Test
	//根据用户性别查询用户信息测试
	public void findByUserSex() throws ParseException{
	}
	
	
	@Test
	//根据用户真实姓名和注册时间查询用户信息测试
	public void findByUserRealNameUserRegTime() throws ParseException{
		
	}

}
