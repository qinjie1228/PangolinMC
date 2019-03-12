package com.plmc.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.plmc.service.UserLoginService;

public class TomcatListener implements ServletContextListener{  
	  
	private ApplicationContext applicationContext;	
	private UserLoginService userLoginService;
    @Override  
    public void contextDestroyed(ServletContextEvent arg0) {
    	applicationContext=new ClassPathXmlApplicationContext(new String[]{"springmvc-servlet.xml"});
    	userLoginService=(UserLoginService) applicationContext.getBean("userLoginServiceImpl");
    	userLoginService.recoverLogin();
    }  
  
    @Override  
    public void contextInitialized(ServletContextEvent arg0) {  
    	applicationContext=new ClassPathXmlApplicationContext(new String[]{"springmvc-servlet.xml"});
    	userLoginService=(UserLoginService) applicationContext.getBean("userLoginServiceImpl");
    	userLoginService.recoverLogin();
    }  
  
}  