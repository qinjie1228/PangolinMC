package com.plmc.test.service;


import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.plmc.service.MactService;

public class MactServiceTest {

	private ApplicationContext applicationContext;	
	private MactService mactService;
	
	@Before
	public void before(){
		applicationContext=new ClassPathXmlApplicationContext(new String[]{"springmvc-servlet.xml"});
		mactService=(MactService) applicationContext.getBean("mactServiceImpl");
	}
	
	@Test
	//活动申请测试
	public void mactApply(){
		mactService.mactApply("342476e3f40c11e681f2a0481c1905a9", "44fb4b9ff40b11e681f2a0481c1905a9");
		mactService.mactApply("342bfc1ff40c11e681f2a0481c1905a9", "44fb4b9ff40b11e681f2a0481c1905a9");
		mactService.mactApply("342d3902f40c11e681f2a0481c1905a9", "44fb4b9ff40b11e681f2a0481c1905a9");
		mactService.mactApply("342e4badf40c11e681f2a0481c1905a9", "44fb4b9ff40b11e681f2a0481c1905a9");
		mactService.mactApply("342fb654f40c11e681f2a0481c1905a9", "450542c4f40b11e681f2a0481c1905a9");
		mactService.mactApply("3430cfacf40c11e681f2a0481c1905a9", "450542c4f40b11e681f2a0481c1905a9");
		mactService.mactApply("3431dd3af40c11e681f2a0481c1905a9", "450542c4f40b11e681f2a0481c1905a9");
		mactService.mactApply("3432f1eaf40c11e681f2a0481c1905a9", "450542c4f40b11e681f2a0481c1905a9");
		mactService.mactApply("34373e47f40c11e681f2a0481c1905a9", "450542c4f40b11e681f2a0481c1905a9");
		mactService.mactApply("343848b6f40c11e681f2a0481c1905a9", "450542c4f40b11e681f2a0481c1905a9");
		mactService.mactApply("34399337f40c11e681f2a0481c1905a9", "4506c742f40b11e681f2a0481c1905a9");
		mactService.mactApply("343aca22f40c11e681f2a0481c1905a9", "4506c742f40b11e681f2a0481c1905a9");
		mactService.mactApply("343c24b0f40c11e681f2a0481c1905a9", "4506c742f40b11e681f2a0481c1905a9");
		mactService.mactApply("343d4f94f40c11e681f2a0481c1905a9", "4506c742f40b11e681f2a0481c1905a9");
		mactService.mactApply("343e5f95f40c11e681f2a0481c1905a9", "4506c742f40b11e681f2a0481c1905a9");
		mactService.mactApply("3431dd3af40c11e681f2a0481c1905a9", "450c1f03f40b11e681f2a0481c1905a9");
		mactService.mactApply("3430cfacf40c11e681f2a0481c1905a9", "450c1f03f40b11e681f2a0481c1905a9");
		mactService.mactApply("342fb654f40c11e681f2a0481c1905a9", "450c1f03f40b11e681f2a0481c1905a9");
		
	}
}
