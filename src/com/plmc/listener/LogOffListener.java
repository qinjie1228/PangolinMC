package com.plmc.listener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.plmc.service.UserLoginService;
import com.plmc.vo.session.CurrentUser;


public class LogOffListener implements HttpSessionListener {
	private ApplicationContext applicationContext;	
	private UserLoginService userLoginService;
	
    public void sessionCreated(HttpSessionEvent event) {}
    
    public void sessionDestroyed(HttpSessionEvent event) {
    	applicationContext=new ClassPathXmlApplicationContext(new String[]{"springmvc-servlet.xml"});
    	userLoginService=(UserLoginService) applicationContext.getBean("userLoginServiceImpl");
    	HttpSession session = event.getSession();
    	CurrentUser currentUser = (CurrentUser) session.getAttribute("currentUser");
    	if(currentUser != null){
    		userLoginService.recoverLoginOne(currentUser.getCurrentNo());
    	}
    }
}