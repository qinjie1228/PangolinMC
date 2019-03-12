package com.plmc.test;

import java.sql.SQLException;

import org.apache.commons.dbcp.BasicDataSource;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;


public class ConnectTest {
	private BasicDataSource dataSource;
	private JdbcTemplate jdbcTemplate =new JdbcTemplate();
	private ApplicationContext applicationContext;
	
	@Before
	//通过配置文件获取applicationContext对象、userDao对象
	public void before(){
		applicationContext=new ClassPathXmlApplicationContext(new String[]{"springmvc-servlet.xml"});
	}
	
	@Test
	//数据库连接测试
	public void text(){
		dataSource=(BasicDataSource)applicationContext.getBean("dataSource");
        jdbcTemplate.setDataSource(dataSource);
        try {
			System.out.println(jdbcTemplate.getDataSource().getConnection().toString());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
